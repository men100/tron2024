#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/ip_addr.h"
#include "lwip/timeouts.h"
#include "main.h"
#include "ethernetif.h"
#include "app_ethernet.h"
#include "mtk3bsp2_mqtt_client.h"

// Broker の IP アドレス
const char* Mqtt_Broker_Ip_Addr = "192.168.1.72";

// Client Id
const char* Mqtt_Client_Id = "mtk3bsp2_mqtt_client";

// Subscribe, Publish する Topic
const char* Mqtt_Topic = "sample";

extern struct netif gnetif;
BOOL isConnected = FALSE;
BOOL isPublish = FALSE;

LOCAL void task_handler(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_handler;	  // Task ID number
LOCAL T_CTSK ctsk_handler = { // Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_handler,
	.tskatr		= TA_HLNG | TA_RNG3,
};

LOCAL void task_publisher(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_publisher;	// Task ID number
LOCAL T_CTSK ctsk_publisher = {	// Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_publisher,
	.tskatr		= TA_HLNG | TA_RNG3,
};

// Subscribe Request の結果を返す Callback
LOCAL void mtk3bsp2_mqtt_subscribe_request_cb(void *arg, int result) {
  if (result != ERR_OK) {
	tm_printf((UB*)"mtk3bsp2_mqtt_subscribe_request_cb: subscribe failed(%d)\n", result);
	BSP_LED_Off(LED1);
  } else {
	tm_printf((UB*)"mtk3bsp2_mqtt_subscribe_request_cb: subscribe successfully\n");
	BSP_LED_On(LED1);
  }
}

// Publish Request の結果を返す Callback
LOCAL void mtk3bsp2_mqtt_publish_request_cb(void *arg, int result) {
  if (result != ERR_OK) {
	tm_printf((UB*)"mtk3bsp2_mqtt_publish_request_cb: publish failed(%d)\n", result);
  } else {
	tm_printf((UB*)"mtk3bsp2_mqtt_publish_request_cb: published successfully\n");
  }
  isPublish = FALSE;
}

// Connection の結果を返す Callback
LOCAL void mtk3bsp2_mqtt_connection_cb(void* arg, mtk3bsp2_mqtt_connection_status_t status) {
	if (status == MTK3BSP2_MQTT_CONNECT_ACCEPTED) {
	    tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: MQTT client connected successfully\n");

	    isConnected = TRUE;

	    // Subscribe
        mtk3bsp2_mqtt_subscribe(Mqtt_Topic, 0, mtk3bsp2_mqtt_subscribe_request_cb, NULL);
	} else {
		tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: MQTT client connection failed(%d)\n", status);
		isConnected = FALSE;
	}
}

// Publish された Message が届いた初回に呼ばれる Callback
LOCAL void mtk3bsp2_mqtt_incoming_publish_cb(void *arg, const char *topic, u32_t tot_len)
{
  tm_printf((UB*)"mtk3bsp2_mqtt_incoming_publish_cb: Incoming publish at topic \"%s\" with total length %u\n", topic, (unsigned int)tot_len);
}

// Publish された Message が届いたときに呼ばれる Callback
LOCAL void mtk3bsp2_mqtt_incoming_data_cb(void *arg, const u8_t *data, u16_t len, u8_t flags)
{
  tm_printf((UB*)"mtk3bsp2_mqtt_incoming_data_cb: Incoming publish payload with data \"%s\", length %d, flags %u\n", data, len, (unsigned int)flags);
  // TK3BSP2_MQTT_DATA_FLAG_LAST が立っていれば、最後のメッセージであることを示す
  if (flags & MTK3BSP2_MQTT_DATA_FLAG_LAST) {
    tm_printf((UB*)"mtk3bsp2_mqtt_incoming_data_cb: Last fragment of payload received\n");
  }
}

// パケットハンドルタスク
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

// Publish タスク
LOCAL void task_publisher(INT stacd, void *exinf)
{
	char message[80];
	int count = 0;
	while(1) {
    	if (isConnected && !isPublish) {
			u8_t qos = 0;
			u8_t retain = 0;

			// Message を生成
			sprintf(message, "Hello, mtk3bsp2_mqtt!: Count=%d\n", ++count);

    		// Publish
			err_t err = mtk3bsp2_mqtt_publish(Mqtt_Topic, message, strlen(message), qos, retain, mtk3bsp2_mqtt_publish_request_cb, NULL);
			if (err != ERR_OK) {
				tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: mqtt_publish failed: %d\n", err);
			}
			isPublish = TRUE;
    	}

		tk_dly_tsk(3000);
	}
}

/* usermain関数 */
EXPORT INT usermain(void)
{
	int ret = 0;

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

	tk_slp_tsk(TMO_FEVR);

	return 0;
}
