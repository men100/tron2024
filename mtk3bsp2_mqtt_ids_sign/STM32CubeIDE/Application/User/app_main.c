#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/timeouts.h"
#include "main.h"
#include "ethernetif.h"
#include "app_ethernet.h"
#include "mtk3bsp2_mqtt.h"
#include "ecr1264.h"

extern UART_HandleTypeDef huart2;
extern struct netif gnetif;

// Broker の IP アドレス
const char* Mqtt_Broker_Ip_Addr = "192.168.1.72";

// MQTT Client ID (ユニークである必要がある)
const char* Mqtt_Client_Id = "ids_subscriber";

// MQTT Topic
const char* Mqtt_Topic = "ids";

// MQTT Broker に接続されているかどうか
BOOL isMqttConnected = FALSE;

int ti_data_offset = 0;
int total_ti_data_size = 0;

LOCAL void task_handler(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_handler;	  // Task ID number
LOCAL T_CTSK ctsk_handler = { // Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_handler,
	.tskatr		= TA_HLNG | TA_RNG3,
};

// EXTI検出コールバック
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
	// User Button が押された
	if (GPIO_Pin == B1_Pin) {
    }
}

LOCAL void mtk3bsp2_mqtt_subscribe_request_cb(void *arg, int result) {
  if (result != ERR_OK) {
	tm_printf((UB*)"mtk3bsp2_mqtt_subscribe_request_cb: subscribe failed(%d)\n", result);
	BSP_LED_Off(LED1);
  } else {
	tm_printf((UB*)"mtk3bsp2_mqtt_subscribe_request_cb: subscribe successfully\n");
	BSP_LED_On(LED1);
  }
}

LOCAL void mtk3bsp2_mqtt_connection_cb(void* arg, mtk3bsp2_mqtt_connection_status_t status) {
	if (status == MTK3BSP2_MQTT_CONNECT_ACCEPTED) {
	    tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: MQTT client connected successfully\n");
	    isMqttConnected = TRUE;

	    // Subscribe
        mtk3bsp2_mqtt_subscribe(Mqtt_Topic, 0, mtk3bsp2_mqtt_subscribe_request_cb, NULL);
	} else {
		tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: MQTT client connection failed(%d)\n", status);
		isMqttConnected = FALSE;
	}
}

// Publish された Message が届いた初回に呼ばれる Callback
LOCAL void mtk3bsp2_mqtt_incoming_publish_cb(void *arg, const char *topic, u32_t tot_len)
{
  tm_printf((UB*)"mtk3bsp2_mqtt_incoming_publish_cb: Incoming publish at topic \"%s\" with total length %u\n", topic, (unsigned int)tot_len);
  ti_data_offset = 0;
  total_ti_data_size = tot_len;
}

// Publish された Message が届いたときに呼ばれる Callback
LOCAL void mtk3bsp2_mqtt_incoming_data_cb(void *arg, const u8_t *data, u16_t len, u8_t flags)
{
  tm_printf((UB*)"mtk3bsp2_mqtt_incoming_data_cb: Incoming publish payload with length %d, flags %u\n", len, (unsigned int)flags);
  ecr1264_set_ti_data(data, len, ti_data_offset);
  ti_data_offset += len;

  if (flags & MTK3BSP2_MQTT_DATA_FLAG_LAST) {
    tm_printf((UB*)"mtk3bsp2_mqtt_incoming_data_cb: Last fragment of payload received\n");
    if (ti_data_offset == total_ti_data_size) {
    	tm_printf((UB*)"received length is correct.\n");

    	ecr1264_clear_vram();
    	ecr1264_send_ti_data();
    	ecr1264_update();
    } else {
    	tm_printf((UB*)"received length is incorrect.(received=%d, total_length=%d)\n", ti_data_offset, total_ti_data_size);
    }
  }
}

LOCAL void task_handler(INT stacd, void *exinf)
{
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
}

/* usermain関数 */
EXPORT INT usermain(void)
{
	int ret = 0;

	tm_putstring((UB*)"Start mtk3bsp2_mqtt_ids_sign.\n");

	ecr1264_init(&huart2);

	ret = mtk3bsp2_mqtt_init(Mqtt_Broker_Ip_Addr);
	if (ret != 0) {
		tm_printf((UB*)"mqtt_init failed(%d)\n", ret);
		return ret;
	}

	ret = mtk3bsp2_mqtt_connect(mtk3bsp2_mqtt_connection_cb, Mqtt_Client_Id, 0, NULL);
	if (ret != 0) {
		tm_printf((UB*)"mqtt_connect failed(%d)\n", ret);
		return ret;
	}

	mtk3bsp2_mqtt_set_inpub_callback(mtk3bsp2_mqtt_incoming_publish_cb, mtk3bsp2_mqtt_incoming_data_cb, NULL);

	tskid_handler = tk_cre_tsk(&ctsk_handler);
	tk_sta_tsk(tskid_handler, 0);

	tk_slp_tsk(TMO_FEVR);

	return 0;
}
