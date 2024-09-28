#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/timeouts.h"
#include "main.h"
#include "ethernetif.h"
#include "app_ethernet.h"
#include "mtk3bsp2_mqtt.h"
#include "ti_data.h"

#define FLAG_USER_BUTTON		0x01
#define FLAG_MQTT_DISCONNECTED	0x02

extern struct netif gnetif;

// Broker の IP アドレス
const char* Mqtt_Broker_Ip_Addr = "192.168.1.72";

// MQTT Client ID (ユニークである必要がある)
const char* Mqtt_Client_Id = "ids_publisher";

// MQTT Topic
const char* Mqtt_Topic = "ids";

// MQTT Broker に接続されているかどうか
BOOL is_mqtt_connected = FALSE;

// MQTT Publish 中かどうか
BOOL is_mqtt_publishing = FALSE;

int publishCount = 0;

LOCAL ID	flgid;
LOCAL CONST T_CFLG cflg = {
	.exinf		= NULL,
	.flgatr		= TA_TFIFO | TA_WMUL,
	.iflgptn	= 0
};

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

LOCAL void task_reconnector(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_reconnector;	// Task ID number
LOCAL T_CTSK ctsk_reconnector = {	// Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_reconnector,
	.tskatr		= TA_HLNG | TA_RNG3,
};

// EXTI検出コールバック
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
	// User Button が押された
    if (GPIO_Pin == B1_Pin) {
    	tk_set_flg(flgid, FLAG_USER_BUTTON);
    }
}

// Publish Request の結果を返す Callback
LOCAL void mtk3bsp2_mqtt_publish_request_cb(void *arg, int result) {
  if (result != ERR_OK) {
	tm_printf((UB*)"mtk3bsp2_mqtt_publish_request_cb: publish failed(%d)\n", result);
  }
  is_mqtt_publishing = FALSE;
}

// Connection の状態を返す Callback
LOCAL void mtk3bsp2_mqtt_connection_cb(void* arg, mtk3bsp2_mqtt_connection_status_t status) {
	if (status == MTK3BSP2_MQTT_CONNECT_ACCEPTED) {
	    tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: MQTT client connected successfully\n");
	    is_mqtt_connected = TRUE;
	} else {
		tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: MQTT client connection failed(%d)\n", status);
		if (is_mqtt_connected) {
			is_mqtt_connected = FALSE;
			tk_set_flg(flgid, FLAG_MQTT_DISCONNECTED);
		}
	}
}

// パケットを受信する Task
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

// Publish する Task
LOCAL void task_publisher(INT stacd, void *exinf)
{
	while(1) {
		tk_wai_flg(flgid, FLAG_USER_BUTTON, TWF_BITCLR, NULL, TMO_FEVR);

		tm_printf((UB*)"[task_publisher] awaked.\n");

    	if (is_mqtt_connected && !is_mqtt_publishing) {
			u8_t qos = 0;
			u8_t retain = 0;

			const u8_t* p;

			if (publishCount == 0) {
				p = tiDataTraverable;
			} else if (publishCount == 1) {
				p = tiDataUnderConstruction;
			}

    		// Publish
			err_t err = mtk3bsp2_mqtt_publish(Mqtt_Topic, p, 1024, qos, retain, mtk3bsp2_mqtt_publish_request_cb, NULL);
			if (err != ERR_OK) {
				tm_printf((UB*)"mtk3bsp2_mqtt_connection_cb: mqtt_publish failed: %d\n", err);
			}
			tm_printf((UB*)"[task_publisher] published.\n");
			is_mqtt_publishing = TRUE;
			publishCount++;
			if (publishCount > 1) {
				publishCount = 0;
			}
    	} else {
			tm_printf((UB*)"[task_publisher] not published.\n");
    	}
	}
}

// MQTT Broker に再接続を試みる Task
LOCAL void task_reconnector(INT stacd, void *exinf)
{
	int ret = 0;
	while(1) {
		tk_wai_flg(flgid, FLAG_MQTT_DISCONNECTED, TWF_BITCLR, NULL, TMO_FEVR);

		tm_printf((UB*)"[task_reconnector] awaked.\n");

		ret = mtk3bsp2_mqtt_connect(mtk3bsp2_mqtt_connection_cb, Mqtt_Client_Id, 0, NULL);
		if (ret != 0) {
			tm_printf((UB*)"mqtt_connect failed(%d)\n", ret);
		}
	}
}

/* usermain関数 */
EXPORT INT usermain(void)
{
	int ret = 0;

	tm_putstring((UB*)"Start mtk3bsp2_mqtt_ids_control.\n");

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

	flgid = tk_cre_flg(&cflg);

	tskid_handler = tk_cre_tsk(&ctsk_handler);
	tk_sta_tsk(tskid_handler, 0);

	tskid_publisher = tk_cre_tsk(&ctsk_publisher);
	tk_sta_tsk(tskid_publisher, 0);

	tskid_reconnector = tk_cre_tsk(&ctsk_reconnector);
	tk_sta_tsk(tskid_reconnector, 0);

	tk_slp_tsk(TMO_FEVR);

	return 0;
}
