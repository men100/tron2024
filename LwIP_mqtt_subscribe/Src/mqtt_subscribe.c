#include "mqtt_subscribe.h"
#include "lwip/apps/mqtt.h"
#include <string.h>

static mqtt_client_t* mqtt_client;

static void mqtt_sub_request_cb(void *arg, err_t result)
{
  printf("Subscribe result: %d\n", result);
}

static void mqtt_connection_cb(mqtt_client_t *client, void *arg, mqtt_connection_status_t status)
{
  if (status == MQTT_CONNECT_ACCEPTED) {
    printf("MQTT client connected\n");

    // サブスクライブ
    mqtt_subscribe(client, "test", 0, mqtt_sub_request_cb, NULL);
  } else {
    printf("MQTT client connection failed: %d\n", status);
  }
}

static void mqtt_incoming_publish_cb(void *arg, const char *topic, u32_t tot_len)
{
  printf("Incoming publish at topic %s with total length %u\n", topic, (unsigned int)tot_len);
}

static void mqtt_incoming_data_cb(void *arg, const u8_t *data, u16_t len, u8_t flags)
{
  printf("Incoming publish payload with length %d, flags %u\n", len, (unsigned int)flags);
  if (flags & MQTT_DATA_FLAG_LAST) {
    printf("Last fragment of payload received\n");
  }
}

int mqtt_subscribe_init(void)
{
  ip_addr_t mqtt_server_ip;
  struct mqtt_connect_client_info_t ci;

  IP4_ADDR(&mqtt_server_ip, 192,168,1,72);  // MQTTブローカーのIPアドレス

  memset(&ci, 0, sizeof(ci));
  ci.client_id = "lwip_test";
  ci.keep_alive = 60;

  mqtt_client = mqtt_client_new();

  if (mqtt_client == NULL) {
	  printf("mqtt_client_new: failed\n");
	  return -1;
  }

  err_t err = mqtt_client_connect(mqtt_client, &mqtt_server_ip, MQTT_PORT, mqtt_connection_cb, NULL, &ci);
  if (err != ERR_OK) {
	  printf("mqtt_connect return %d\n", err);
	  return err;
  }

  mqtt_set_inpub_callback(mqtt_client, mqtt_incoming_publish_cb, mqtt_incoming_data_cb, NULL);

  printf("mqtt_client_connect: success\n");
  return 0;
}
