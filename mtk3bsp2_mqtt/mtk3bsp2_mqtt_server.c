#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/tcp.h"
#include "lwip/apps/mqtt.h"
#include "mtk3bsp2_mqtt_server.h"

typedef struct {
    struct tcp_pcb *pcb;
    char subscribed_topics[MAX_MQTT_TOPICS][MAX_MQTT_TOPIC_LENGTH];
    int num_topics;
} mtk3bsp2_mqtt_client_t;

static mtk3bsp2_mqtt_client_t clients[MAX_MQTT_CLIENTS];
static int num_clients = 0;

static uint32_t mtk3bsp2_decode_remaining_length(const uint8_t* buf, uint32_t* length) {
    uint32_t multiplier = 1;
    uint32_t value = 0;
    uint8_t digit;
    uint32_t offset = 0;

    do {
        digit = buf[offset];
        value += (digit & 127) * multiplier;
        multiplier *= 128;
        offset++;
    } while ((digit & 128) != 0);

    *length = value;
    return offset;
}

// CONNECTメッセージを処理する関数
static err_t mtk3bsp2_handle_connect_message(struct tcp_pcb *pcb, uint8_t *data, uint32_t length)
{
    // CONNACKを送信
    uint8_t connack[4];
    connack[0] = MQTT_HEADER_TYPE_CONNACK;
    connack[1] = 2;    // remaining length
    connack[2] = 0x00; // connect acknowledge flags (session present flag = 0)
    connack[3] = 0x00; // connect return code (0 = connection accepted)

    tcp_write(pcb, connack, 4, TCP_WRITE_FLAG_COPY);
    tcp_output(pcb);

    return ERR_OK;
}

// SUBSCRIBEメッセージを処理する関数
static err_t mtk3bsp2_handle_subscribe_message(struct tcp_pcb *pcb, uint8_t *data, uint32_t length, int client_index)
{
    uint32_t remaining_length;
    uint32_t offset;

    // 残りの長さをデコード
    offset = mtk3bsp2_decode_remaining_length(data + 1, &remaining_length);
    offset += 1;  // ヘッダーバイトの分を加算

    // パケットIDを取得
    uint16_t packet_id = (data[offset] << 8) | data[offset + 1];
    offset += 2;

    while (offset < length) {
        // トピック長を取得
        uint16_t topic_length = (data[offset] << 8) | data[offset + 1];
        offset += 2;

        // トピックをコピー
        if (topic_length < MAX_MQTT_TOPIC_LENGTH &&
            clients[client_index].num_topics < MAX_MQTT_TOPICS) {

            memcpy(clients[client_index].subscribed_topics[clients[client_index].num_topics],
                   &data[offset], topic_length);
            clients[client_index].subscribed_topics[clients[client_index].num_topics][topic_length] = '\0';
            clients[client_index].num_topics++;

            // QoSを取得（現在使用しない）
            // uint8_t requested_qos = data[offset + topic_length];
        }

        offset += topic_length + 1;  // +1 はQoSバイトの分
    }

    // SUBACKを送信
    uint8_t suback[5];
    suback[0] = MQTT_HEADER_TYPE_SUBACK;
    suback[1] = 3;    // remaining length
    suback[2] = (uint8_t)(packet_id >> 8);
    suback[3] = (uint8_t)(packet_id & 0xFF);
    suback[4] = 0x00; // QoS 0

    tcp_write(pcb, suback, 5, TCP_WRITE_FLAG_COPY);
    tcp_output(pcb);

    return ERR_OK;
}

static err_t mtk3bsp2_parse_mqtt_message(struct pbuf *p, char *topic, char *message) {
    uint8_t *data = (uint8_t *)p->payload;
    uint8_t header = data[0];
    uint32_t remaining_length;
    uint32_t offset;

    tm_printf((UB*)"mtk3bsp2_parse_mqtt_message: dump message\n");
    for (int i = 0; i < p->len; i++) {
        tm_printf((UB*)"%c ", data[i]);
    }
    tm_printf((UB*)"\n");

    // ヘッダーの種類をチェック
    if ((header & MQTT_HEADER_TYPE_MASK) != MQTT_HEADER_TYPE_PUBLISH) {
        tm_printf((UB*)"mtk3bsp2_parse_mqtt_message: not publish message.\n");
        return ERR_VAL;  // PUBLISHメッセージでない
    }
    tm_printf((UB*)"mtk3bsp2_parse_mqtt_message: it's publish message.\n");

    // 残りの長さをデコード
    offset = mtk3bsp2_decode_remaining_length(data + 1, &remaining_length);
    offset += 1;  // ヘッダーバイトの分を加算

    // トピック長を取得
    uint16_t topic_length = (data[offset] << 8) | data[offset + 1];
    offset += 2;

    // トピックをコピー
    if (topic_length >= MAX_MQTT_TOPIC_LENGTH) {
        return ERR_MEM;  // トピックが長すぎる
    }
    memcpy(topic, &data[offset], topic_length);
    topic[topic_length] = '\0';
    offset += topic_length;

    // QoSフラグをチェック
    uint8_t qos = (header & MQTT_HEADER_QOS_MASK) >> 1;
    if (qos > 0) {
        // パケットIDをスキップ
        offset += 2;
    }

    // メッセージ長を計算
    uint32_t message_length = remaining_length - (offset - (1 + mtk3bsp2_decode_remaining_length(data + 1, &remaining_length)));

    if (message_length >= MAX_MQTT_MESSAGE_LENGTH) {
        return ERR_MEM;  // メッセージが長すぎる
    }

    // メッセージをコピー
    memcpy(message, &data[offset], message_length);
    message[message_length] = '\0';

    return ERR_OK;
}

static err_t mtk3bsp2_mqtt_broker_recv(void *arg, struct tcp_pcb *pcb, struct pbuf *p, err_t err)
{
	if (err == ERR_OK && p != NULL) {
		uint8_t *data = (uint8_t *)p->payload;
		uint8_t header = data[0];

		// クライアントのインデックスを検索
		int client_index = -1;
		for (int i = 0; i < num_clients; i++) {
			if (clients[i].pcb == pcb) {
				client_index = i;
				break;
			}
		}

	    tm_printf((UB*)"mtk3bsp2_mqtt_broker_recv: header=0x%x\n", header);
		switch (header & MQTT_HEADER_TYPE_MASK) {
			case MQTT_HEADER_TYPE_CONNECT:
			    tm_printf((UB*)"mtk3bsp2_mqtt_broker_recv: type is MQTT_HEADER_TYPE_CONNECT.\n");
				mtk3bsp2_handle_connect_message(pcb, data, p->len);
				break;

			case MQTT_HEADER_TYPE_SUBSCRIBE:
			    tm_printf((UB*)"mtk3bsp2_mqtt_broker_recv: type is MQTT_HEADER_TYPE_SUBSCRIBE.\n");
				if (client_index >= 0) {
					mtk3bsp2_handle_subscribe_message(pcb, data, p->len, client_index);
				}
				break;

			case MQTT_HEADER_TYPE_PUBLISH:
			    tm_printf((UB*)"mtk3bsp2_mqtt_broker_recv: type is MQTT_HEADER_TYPE_PUBLISH.\n");
				char topic[MAX_MQTT_TOPIC_LENGTH];
				char message[MAX_MQTT_MESSAGE_LENGTH];

				if (mtk3bsp2_parse_mqtt_message(p, topic, message) == ERR_OK) {
				    tm_printf((UB*)"mtk3bsp2_mqtt_broker_recv: message is parsed.\n");

				    // すべてのサブスクライバーにメッセージを配信
					for (int i = 0; i < num_clients; i++) {
						for (int j = 0; j < clients[i].num_topics; j++) {
							if (strcmp(clients[i].subscribed_topics[j], topic) == 0) {
								// 簡易的なMQTTメッセージの構築
								uint8_t header = MQTT_HEADER_TYPE_PUBLISH;
								uint16_t topic_len = strlen(topic);
								uint16_t msg_len = strlen(message);
								uint32_t total_length = 2 + topic_len + msg_len;

								// ヘッダーとトピック長を送信
								uint8_t buf[5];
								buf[0] = header;
								buf[1] = (uint8_t)total_length;
								buf[2] = (uint8_t)(topic_len >> 8);
								buf[3] = (uint8_t)(topic_len & 0xFF);

								tcp_write(clients[i].pcb, buf, 4, TCP_WRITE_FLAG_COPY);
								tcp_write(clients[i].pcb, topic, topic_len, TCP_WRITE_FLAG_COPY);
								tcp_write(clients[i].pcb, message, msg_len, TCP_WRITE_FLAG_COPY);
								tcp_output(clients[i].pcb);
								break;
							}
						}
					}
				}
				break;
		}

        pbuf_free(p);
    } else if (err == ERR_OK && p == NULL) {
	    // 接続クローズ処理
		for (int i = 0; i < num_clients; i++) {
			if (clients[i].pcb == pcb) {
				// クライアント情報をクリア
				memset(&clients[i], 0, sizeof(mtk3bsp2_mqtt_client_t));
				if (i == num_clients - 1) {
					num_clients--;
				}
				break;
			}
		}
		tcp_arg(pcb, NULL);
		tcp_recv(pcb, NULL);
		tcp_close(pcb);

		tm_printf((UB*)"mtk3bsp2_mqtt_broker_recv: connection closed.\n");
    }
    return ERR_OK;
}

static err_t mtk3bsp2_mqtt_broker_accept(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	if (err == ERR_OK && num_clients < MAX_MQTT_CLIENTS) {
        tcp_setprio(newpcb, TCP_PRIO_MIN);
        tcp_recv(newpcb, mtk3bsp2_mqtt_broker_recv);
        clients[num_clients].pcb = newpcb;
        clients[num_clients].num_topics = 0;
        num_clients++;
    } else {
        tcp_close(newpcb);
    }
    return ERR_OK;
}

err_t mtk3bsp2_mqtt_broker_init(void)
{
    struct tcp_pcb *pcb;
    err_t err;

    pcb = tcp_new();
    err = tcp_bind(pcb, IP_ADDR_ANY, 1883);  // MQTTデフォルトポート

    if (err == ERR_OK) {
        pcb = tcp_listen(pcb);
        tcp_accept(pcb, mtk3bsp2_mqtt_broker_accept);
        return ERR_OK;
    } else {
        memp_free(MEMP_TCP_PCB, pcb);
        return err;
    }
}
