#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/apps/mqtt.h"
#include "mtk3bsp2_mqtt.h"

static mqtt_client_t* s_mqtt_client;
static ip_addr_t s_mqtt_server_ip;
static mtk3bsp2_mqtt_connection_cb_t s_connection_cb = NULL;
static mtk3bsp2_mqtt_request_cb_t s_publish_request_cb = NULL;
static mtk3bsp2_mqtt_incoming_publish_cb_t s_incoming_publish_cb = NULL;
static mtk3bsp2_mqtt_incoming_data_cb_t s_incoming_data_cb = NULL;
static mtk3bsp2_mqtt_request_cb_t s_subscribe_request_cb = NULL;

static void mqtt_connection_cb(mqtt_client_t *client, void *arg, mqtt_connection_status_t status)
{
  if (s_connection_cb != NULL) {
  	s_connection_cb(arg, (mtk3bsp2_mqtt_connection_status_t)status);
  }
}

static void mqtt_publish_request_cb(void *arg, err_t result)
{
  if (s_publish_request_cb != NULL)
  {
	  s_publish_request_cb(arg, result);
  }
}

static void mqtt_subscribe_request_cb(void *arg, err_t result)
{
  if (s_subscribe_request_cb != NULL)
  {
	  s_subscribe_request_cb(arg, result);
  }
}

static void mqtt_incoming_publish_cb(void *arg, const char *topic, u32_t tot_len)
{
  if (s_incoming_publish_cb != NULL)
  {
	  s_incoming_publish_cb(arg, topic, tot_len);
  }
}

static void mqtt_incoming_data_cb(void *arg, const u8_t *data, u16_t len, u8_t flags)
{
  if (s_incoming_data_cb != NULL)
  {
	  s_incoming_data_cb(arg, data, len, flags);
  }
}

int mtk3bsp2_mqtt_init(u8_t octet1, u8_t octet2, u8_t octet3, u8_t octet4)
{
  if (s_mqtt_client != NULL) {
	  tm_printf((UB*)"mqtt_init: already initialized\n");
	  return -1;
  }

  IP4_ADDR(&s_mqtt_server_ip, octet1, octet2, octet3, octet4); // MQTTブローカーのIPアドレス

  s_mqtt_client = mqtt_client_new();
  if (s_mqtt_client == NULL) {
	  tm_printf((UB*)"mqtt_init: mqtt_client_new failed\n");
	  return -1;
  }

  return 0;
}

int mtk3bsp2_mqtt_connect(mtk3bsp2_mqtt_connection_cb_t connection_cb, void *arg)
{
  struct mqtt_connect_client_info_t ci;
  err_t err;

  memset(&ci, 0, sizeof(ci));
  ci.client_id = "mtk3bsp2_mqtt";
  ci.keep_alive = 60;

  s_connection_cb = connection_cb;

  err = mqtt_client_connect(s_mqtt_client, &s_mqtt_server_ip, MQTT_PORT, mqtt_connection_cb, arg, &ci);
  if (err != ERR_OK) {
	  tm_printf((UB*)"mtk3bsp2_mqtt_connect: mqtt_connect failed(%d)\n", err);
	  return err;
  }

  return 0;
}

int mtk3bsp2_mqtt_publish(const char *topic, const void *payload, u16_t payload_length, u8_t qos, u8_t retain, mtk3bsp2_mqtt_request_cb_t cb, void *arg)
{
	s_publish_request_cb = cb;

	err_t err = mqtt_publish(s_mqtt_client, topic, payload, payload_length, qos, retain, mqtt_publish_request_cb, arg);
    if (err != ERR_OK) {
    	tm_printf((UB*)"mtk3bsp2_mqtt_publish: mqtt_publish failed(%d)\n", err);
    	return err;
    }
    return 0;
}

void mtk3bsp2_mqtt_set_inpub_callback(mtk3bsp2_mqtt_incoming_publish_cb_t pub_cb, mtk3bsp2_mqtt_incoming_data_cb_t data_cb, void *arg)
{
	s_incoming_publish_cb = pub_cb;
	s_incoming_data_cb = data_cb;

    mqtt_set_inpub_callback(s_mqtt_client, mqtt_incoming_publish_cb, mqtt_incoming_data_cb, NULL);
}

int mtk3bsp2_mqtt_subscribe(const char* topic, u8_t qos, mtk3bsp2_mqtt_request_cb_t cb, void* arg)
{
	s_subscribe_request_cb = cb;

	err_t err = mqtt_subscribe(s_mqtt_client, topic, qos, mqtt_subscribe_request_cb, arg);
    if (err != ERR_OK) {
    	tm_printf((UB*)"mtk3bsp2_mqtt_subscribe: mqtt_subscribe failed(%d)\n", err);
    	return err;
    }
    return 0;
}
