#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/ip_addr.h"
#include "lwip/timeouts.h"
#include "main.h"
#include "ethernetif.h"
#include "app_ethernet.h"
#include "mtk3bsp2_mqtt.h"

#include "lwip/tcp.h"
#include "lwip/apps/mqtt.h"
#include <string.h>

#define MAX_CLIENTS 10
#define MAX_TOPICS 5
#define MAX_TOPIC_LENGTH 50
#define MAX_MESSAGE_LENGTH 100

#define MQTT_HEADER_TYPE_MASK 0xF0


#define MQTT_HEADER_TYPE_CONNECT	0x10
#define MQTT_HEADER_TYPE_CONNACK	0x20
#define MQTT_HEADER_TYPE_PUBLISH	0x30
#define MQTT_HEADER_TYPE_SUBSCRIBE	0x80
#define MQTT_HEADER_TYPE_SUBACK		0x90

#define MQTT_HEADER_QOS_MASK 0x06
#define MQTT_HEADER_RETAIN_MASK 0x01

extern struct netif gnetif;

typedef struct {
    struct tcp_pcb *pcb;
    char subscribed_topics[MAX_TOPICS][MAX_TOPIC_LENGTH];
    int num_topics;
} mqtt_client_t2;

static mqtt_client_t2 clients[MAX_CLIENTS];
static int num_clients = 0;

static uint32_t decode_remaining_length(const uint8_t* buf, uint32_t* length) {
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
static err_t handle_connect_message(struct tcp_pcb *pcb, uint8_t *data, uint32_t length)
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
static err_t handle_subscribe_message(struct tcp_pcb *pcb, uint8_t *data, uint32_t length, int client_index)
{
    uint32_t remaining_length;
    uint32_t offset;

    // 残りの長さをデコード
    offset = decode_remaining_length(data + 1, &remaining_length);
    offset += 1;  // ヘッダーバイトの分を加算

    // パケットIDを取得
    uint16_t packet_id = (data[offset] << 8) | data[offset + 1];
    offset += 2;

    while (offset < length) {
        // トピック長を取得
        uint16_t topic_length = (data[offset] << 8) | data[offset + 1];
        offset += 2;

        // トピックをコピー
        if (topic_length < MAX_TOPIC_LENGTH &&
            clients[client_index].num_topics < MAX_TOPICS) {

            memcpy(clients[client_index].subscribed_topics[clients[client_index].num_topics],
                   &data[offset], topic_length);
            clients[client_index].subscribed_topics[clients[client_index].num_topics][topic_length] = '\0';
            clients[client_index].num_topics++;

            // QoSを取得（ただし、この実装では使用しない）
            uint8_t requested_qos = data[offset + topic_length];
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

static err_t parse_mqtt_message(struct pbuf *p, char *topic, char *message) {
    uint8_t *data = (uint8_t *)p->payload;
    uint8_t header = data[0];
    uint32_t remaining_length;
    uint32_t offset;

    tm_printf((UB*)"parse_mqtt_message\n");

    for (int i = 0; i < p->len; i++) {
        tm_printf((UB*)"%c ", data[i]);
    }
    tm_printf((UB*)"\n");

    // ヘッダーの種類をチェック
    if ((header & MQTT_HEADER_TYPE_MASK) != MQTT_HEADER_TYPE_PUBLISH) {
        tm_printf((UB*)"not publish message\n");
        return ERR_VAL;  // PUBLISHメッセージでない
    }
    tm_printf((UB*)"it's publish message\n");

    // 残りの長さをデコード
    offset = decode_remaining_length(data + 1, &remaining_length);
    offset += 1;  // ヘッダーバイトの分を加算

    // トピック長を取得
    uint16_t topic_length = (data[offset] << 8) | data[offset + 1];
    offset += 2;

    // トピックをコピー
    if (topic_length >= MAX_TOPIC_LENGTH) {
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
    uint32_t message_length = remaining_length - (offset - (1 + decode_remaining_length(data + 1, &remaining_length)));

    if (message_length >= MAX_MESSAGE_LENGTH) {
        return ERR_MEM;  // メッセージが長すぎる
    }

    // メッセージをコピー
    memcpy(message, &data[offset], message_length);
    message[message_length] = '\0';

    return ERR_OK;
}

static err_t mqtt_broker_recv(void *arg, struct tcp_pcb *pcb, struct pbuf *p, err_t err)
{
    tm_printf((UB*)"mqtt_broker_recv\n");

	if (err == ERR_OK && p != NULL) {
	    tm_printf((UB*)"1-1\n");

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

	    tm_printf((UB*)"1-2: type=0x%x\n", header & MQTT_HEADER_TYPE_MASK);

		switch (header & MQTT_HEADER_TYPE_MASK) {
			case MQTT_HEADER_TYPE_CONNECT:
			    tm_printf((UB*)"connect\n");
				handle_connect_message(pcb, data, p->len);
				break;

			case MQTT_HEADER_TYPE_SUBSCRIBE:
			    tm_printf((UB*)"subscribe\n");
				if (client_index >= 0) {
					handle_subscribe_message(pcb, data, p->len, client_index);
				}
				break;

			case MQTT_HEADER_TYPE_PUBLISH:
			    tm_printf((UB*)"publish\n");
				char topic[MAX_TOPIC_LENGTH];
				char message[MAX_MESSAGE_LENGTH];

				if (parse_mqtt_message(p, topic, message) == ERR_OK) {
				    tm_printf((UB*)"parse ok\n");

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
	    tm_printf((UB*)"2\n");

	    // 接続クローズ処理
		for (int i = 0; i < num_clients; i++) {
			if (clients[i].pcb == pcb) {
				// クライアント情報をクリア
				memset(&clients[i], 0, sizeof(mqtt_client_t2));
				if (i == num_clients - 1) {
					num_clients--;
				}
				break;
			}
		}
		tcp_arg(pcb, NULL);
		tcp_recv(pcb, NULL);
		tcp_close(pcb);
    }
    return ERR_OK;
}

static err_t mqtt_broker_accept(void *arg, struct tcp_pcb *newpcb, err_t err)
{
    tm_printf((UB*)"mqtt_broker_accept\n");

	if (err == ERR_OK && num_clients < MAX_CLIENTS) {
        tcp_setprio(newpcb, TCP_PRIO_MIN);
        tcp_recv(newpcb, mqtt_broker_recv);
        clients[num_clients].pcb = newpcb;
        clients[num_clients].num_topics = 0;
        num_clients++;
    } else {
        tcp_close(newpcb);
    }
    return ERR_OK;
}

int mqtt_broker_init(void)
{
    struct tcp_pcb *pcb;
    err_t err;

    tm_printf((UB*)"mqtt_broker_init\n");

    pcb = tcp_new();
    err = tcp_bind(pcb, IP_ADDR_ANY, 1883);  // MQTTデフォルトポート

    if (err == ERR_OK) {
        pcb = tcp_listen(pcb);
        tcp_accept(pcb, mqtt_broker_accept);
        return 0;
    } else {
        memp_free(MEMP_TCP_PCB, pcb);
        return -1;
    }
}

/* usermain関数 */
EXPORT INT usermain(void)
{
	int ret = 0;

	tm_printf((UB*)"usermain\n");

	ret = mqtt_broker_init();
	if (ret != 0) {
		tm_printf((UB*)"mqtt_broker_init failed(%d)\n", ret);
		return ret;
	}

	tm_printf((UB*)"before while\n");

	while(1) {
    	// Read a received packet from the Ethernet buffers and send it to the lwIP for handling
    	ethernetif_input(&gnetif);

		// Handle timeouts
		sys_check_timeouts();

#if LWIP_NETIF_LINK_CALLBACK
		Ethernet_Link_Periodic_Handle(&gnetif);
#endif

#if LWIP_DHCP
		DHCP_Periodic_Handle(&gnetif);
#endif
		tk_dly_tsk(100);
	}

	/*
	tm_putstring((UB*)"Start User-main program.\n");

	// MQTT Client の初期化
	ret = mtk3bsp2_mqtt_init(Mqtt_Broker_Ip_Addr);
	if (ret != 0) {
		tm_printf((UB*)"mqtt_init failed(%d)\n", ret);
		return ret;
	}

	// MQTT Broker へ接続
	ret = mtk3bsp2_mqtt_connect(mtk3bsp2_mqtt_connection_cb, Mqtt_Client_Id, 0, NULL);
	if (ret != 0) {
		tm_printf((UB*)"mqtt_connect failed(%d)\n", ret);
		return ret;
	}

	// Message を受け取ったときの Callback を登録
	mtk3bsp2_mqtt_set_inpub_callback(mtk3bsp2_mqtt_incoming_publish_cb, mtk3bsp2_mqtt_incoming_data_cb, NULL);

	// パケットハンドルタスクを生成・起動
	tskid_handler = tk_cre_tsk(&ctsk_handler);
	tk_sta_tsk(tskid_handler, 0);

	// Publish タスクを生成・起動
	tskid_publisher = tk_cre_tsk(&ctsk_publisher);
	tk_sta_tsk(tskid_publisher, 0);
	*/

	tk_slp_tsk(TMO_FEVR);

	return 0;
}
