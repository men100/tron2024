#ifndef __MTK3BSP2_MQTT_H__
#define __MTK3BSP2_MQTT_H__

typedef enum
{
  /** Accepted */
  MTK3BSP2_MQTT_CONNECT_ACCEPTED                 = 0,
  /** Refused protocol version */
  MTK3BSP2_MQTT_CONNECT_REFUSED_PROTOCOL_VERSION = 1,
  /** Refused identifier */
  MTK3BSP2_MQTT_CONNECT_REFUSED_IDENTIFIER       = 2,
  /** Refused server */
  MTK3BSP2_MQTT_CONNECT_REFUSED_SERVER           = 3,
  /** Refused user credentials */
  MTK3BSP2_MQTT_CONNECT_REFUSED_USERNAME_PASS    = 4,
  /** Refused not authorized */
  MTK3BSP2_MQTT_CONNECT_REFUSED_NOT_AUTHORIZED_  = 5,
  /** Disconnected */
  MTK3BSP2_MQTT_CONNECT_DISCONNECTED             = 256,
  /** Timeout */
  MTK3BSP2_MQTT_CONNECT_TIMEOUT                  = 257
} mtk3bsp2_mqtt_connection_status_t;

enum {
  /** Flag set when last fragment of data arrives in data callback */
  MTK3BSP2_MQTT_DATA_FLAG_LAST = 1
};

typedef void (*mtk3bsp2_mqtt_connection_cb_t)(void *arg, mtk3bsp2_mqtt_connection_status_t status);
typedef void (*mtk3bsp2_mqtt_request_cb_t)(void *arg, int err);
typedef void (*mtk3bsp2_mqtt_incoming_publish_cb_t)(void *arg, const char *topic, u32_t tot_len);
typedef void (*mtk3bsp2_mqtt_incoming_data_cb_t)(void *arg, const u8_t *data, u16_t len, u8_t flags);

int mtk3bsp2_mqtt_init(u8_t octet1, u8_t octet2, u8_t octet3, u8_t octet4);
int mtk3bsp2_mqtt_connect(mtk3bsp2_mqtt_connection_cb_t connection_cb, void *arg);
int mtk3bsp2_mqtt_publish(const char *topic, const void *payload, u16_t payload_length, u8_t qos, u8_t retain, mtk3bsp2_mqtt_request_cb_t cb, void *arg);
void mtk3bsp2_mqtt_set_inpub_callback(mtk3bsp2_mqtt_incoming_publish_cb_t pub_cb, mtk3bsp2_mqtt_incoming_data_cb_t data_cb, void *arg);
int mtk3bsp2_mqtt_subscribe(const char* topic, u8_t qos, mtk3bsp2_mqtt_request_cb_t cb, void* arg);

#endif /* __MTK3BSP2_MQTT_H__ */
