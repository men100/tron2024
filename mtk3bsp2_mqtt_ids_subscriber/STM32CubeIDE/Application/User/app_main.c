#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/timeouts.h"
#include "main.h"
#include "ethernetif.h"
#include "app_ethernet.h"
#include "mtk3bsp2_mqtt.h"
#include "ti_data.h"

extern UART_HandleTypeDef huart2;

const char* Mqtt_Topic = "sample";

extern struct netif gnetif;
BOOL isConnected = FALSE;
BOOL isPublish = FALSE;
BOOL isTriggeredUserButton = FALSE;

int tiDataIndex = 0;
int totalTiDataSize = 0;
uint8_t receivedTiData[1024];

int publishCount = 0;

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

// EXTI検出コールバック
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
    if (GPIO_Pin == B1_Pin) {
    	tm_printf((UB*)"Blue_User_Button pressed\n");
    	isTriggeredUserButton = TRUE;
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

LOCAL void mtk3bsp2_mqtt_publish_request_cb(void *arg, int result) {
  if (result != ERR_OK) {
	tm_printf((UB*)"mtk3bsp2_mqtt_publish_request_cb: publish failed(%d)\n", result);
  } else {
	tm_printf((UB*)"mtk3bsp2_mqtt_publish_request_cb: published successfully\n");
  }
  isPublish = FALSE;
}

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

LOCAL void mtk3bsp2_mqtt_incoming_publish_cb(void *arg, const char *topic, u32_t tot_len)
{
  tm_printf((UB*)"mtk3bsp2_mqtt_incoming_publish_cb: Incoming publish at topic \"%s\" with total length %u\n", topic, (unsigned int)tot_len);
  tiDataIndex = 0;
  totalTiDataSize = tot_len;
}

LOCAL void mtk3bsp2_mqtt_incoming_data_cb(void *arg, const u8_t *data, u16_t len, u8_t flags)
{
  tm_printf((UB*)"mtk3bsp2_mqtt_incoming_data_cb: Incoming publish payload with length %d, flags %u\n", len, (unsigned int)flags);
  memcpy(receivedTiData + tiDataIndex, data, len);
  tiDataIndex += len;

  if (flags & MTK3BSP2_MQTT_DATA_FLAG_LAST) {
    tm_printf((UB*)"mtk3bsp2_mqtt_incoming_data_cb: Last fragment of payload received\n");
    if (tiDataIndex == totalTiDataSize) {
    	tm_printf((UB*)"received length is correct.\n");

  	  uint8_t vramClearCommand[] = "ER\r";
  	  uint8_t repaintCommand[] = "DP\r";
  	  uint8_t tiCommand[2 + 1024 + 1];

  	  memcpy(tiCommand, (uint8_t*)"TI", 2);
  	  memcpy(tiCommand + 2, receivedTiData, 1024);
  	  memcpy(tiCommand + 2 + 1024, (uint8_t*)"\r", 1);

  	  // VRAM クリア
        if (HAL_UART_Transmit(&huart2, vramClearCommand, sizeof(vramClearCommand), HAL_MAX_DELAY) != HAL_OK)
        {
          Error_Handler();
        }

        // 画像転送
        if (HAL_UART_Transmit(&huart2, tiCommand, sizeof(tiCommand), HAL_MAX_DELAY) != HAL_OK)
        {
          Error_Handler();
        }

  	  // 表示書き換え
        if (HAL_UART_Transmit(&huart2, repaintCommand, sizeof(repaintCommand), HAL_MAX_DELAY) != HAL_OK)
        {
          Error_Handler();
        }
    } else {
    	tm_printf((UB*)"received length is incorrect.(received=%d, total_length=%d)\n", tiDataIndex, totalTiDataSize);
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

LOCAL void task_publisher(INT stacd, void *exinf)
{
	while(1) {
    	if (isConnected && !isPublish && isTriggeredUserButton) {
			isTriggeredUserButton = FALSE;

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
			isPublish = TRUE;
			publishCount++;
			if (publishCount > 1) {
				publishCount = 0;
			}
    	}

		tk_dly_tsk(3000);
	}
}

/* usermain関数 */
EXPORT INT usermain(void)
{
	int ret = 0;

	tm_putstring((UB*)"Start User-main program.\n");

	ret = mtk3bsp2_mqtt_init("192.168.1.72");
	if (ret != 0) {
		tm_printf((UB*)"mqtt_init failed(%d)\n", ret);
		return ret;
	}

	ret = mtk3bsp2_mqtt_connect(mtk3bsp2_mqtt_connection_cb, 60, NULL);
	if (ret != 0) {
		tm_printf((UB*)"mqtt_connect failed(%d)\n", ret);
		return ret;
	}

	mtk3bsp2_mqtt_set_inpub_callback(mtk3bsp2_mqtt_incoming_publish_cb, mtk3bsp2_mqtt_incoming_data_cb, NULL);

	tskid_handler = tk_cre_tsk(&ctsk_handler);
	tk_sta_tsk(tskid_handler, 0);

	tskid_publisher = tk_cre_tsk(&ctsk_publisher);
	tk_sta_tsk(tskid_publisher, 0);

	tk_slp_tsk(TMO_FEVR);

	return 0;
}
