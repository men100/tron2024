#include <string.h>
#include <tk/tkernel.h>
#include <tm/tmonitor.h>
#include "lwip/ip_addr.h"
#include "lwip/timeouts.h"
#include "main.h"
#include "ethernetif.h"
#include "app_ethernet.h"
#include "mtk3bsp2_mqtt_server.h"

extern struct netif gnetif;

LOCAL void task_handler(INT stacd, void *exinf);	// task execution function
LOCAL ID	tskid_handler;	  // Task ID number
LOCAL T_CTSK ctsk_handler = { // Task creation information
	.itskpri	= 10,
	.stksz		= 1024,
	.task		= task_handler,
	.tskatr		= TA_HLNG | TA_RNG3,
};

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

/* usermain関数 */
EXPORT INT usermain(void)
{
	int ret = 0;

	tm_putstring((UB*)"Start User-main program.\n");

	ret = mtk3bsp2_mqtt_broker_init();
	if (ret != 0) {
		tm_printf((UB*)"mtk3bsp2_mqtt_broker_init failed(%d)\n", ret);
		return ret;
	}

	// パケットハンドルタスクを生成・起動
	tskid_handler = tk_cre_tsk(&ctsk_handler);
	tk_sta_tsk(tskid_handler, 0);

	tk_slp_tsk(TMO_FEVR);

	return 0;
}
