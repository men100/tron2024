#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "mqtt_publish.h"
#include "lwip/apps/mqtt.h"

static mqtt_client_t* s_mqtt_client;

static void mqtt_pub_request_cb(void *arg, err_t result)
{
  if (result != ERR_OK) {
    tm_printf((UB*)"Publish result: %d\n", result);
  } else {
    tm_printf((UB*)"Message published successfully\n");
  }
}

static void mqtt_connection_cb(mqtt_client_t *client, void *arg, mqtt_connection_status_t status)
{
  if (status == MQTT_CONNECT_ACCEPTED) {
    printf("MQTT client connected\n");

    // パブリッシュ
    const char* topic = "test";
    const char* message = "Hello, MQTT!";
    u8_t qos = 0;
    u8_t retain = 0;

    err_t err = mqtt_publish(client, topic,  message, strlen(message), qos, retain, mqtt_pub_request_cb, NULL);
    if (err != ERR_OK) {
    	printf("mqtt_publish failed: %d\n", err);
    }
  } else {
    printf("MQTT client connection failed: %d\n", status);
  }
}

int mqtt_publish_init(void)
{
  ip_addr_t mqtt_server_ip;
  struct mqtt_connect_client_info_t ci;

  IP4_ADDR(&mqtt_server_ip, 192,168,1,72);  // MQTTブローカーのIPアドレス

  memset(&ci, 0, sizeof(ci));
  ci.client_id = "lwip_test";
  ci.keep_alive = 60;

  s_mqtt_client = mqtt_client_new();

  if (s_mqtt_client == NULL) {
	  printf("mqtt_client_new: failed\n");
	  return -1;
  }

  err_t err = mqtt_client_connect(s_mqtt_client, &mqtt_server_ip, MQTT_PORT, mqtt_connection_cb, NULL, &ci);
  if (err != ERR_OK) {
	  printf("mqtt_connect return %d\n", err);
	  return err;
  }

//  mqtt_set_inpub_callback(mqtt_client, mqtt_incoming_publish_cb, mqtt_incoming_data_cb, NULL);

  printf("mqtt_client_connect: success\n");
  return 0;
}
