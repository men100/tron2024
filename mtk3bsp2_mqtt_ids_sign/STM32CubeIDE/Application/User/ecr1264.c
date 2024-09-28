#include <string.h>
#include "ecr1264.h"

static UART_HandleTypeDef* sp_huart;

static const uint8_t s_vram_clear_command[] = "ER\r";
static const uint8_t s_update_command[] = "DP\r";

#define TI_COMMAND_SIZE 	2
#define TI_DATA_SIZE		1024
#define TI_DELIMITER_SIZE	1

static uint8_t s_ti[TI_COMMAND_SIZE + TI_DATA_SIZE + TI_DELIMITER_SIZE];

void ecr1264_init(UART_HandleTypeDef* huart) {
	sp_huart = huart;

	memcpy(s_ti, (uint8_t*)"TI", TI_COMMAND_SIZE);
	memcpy(s_ti + TI_COMMAND_SIZE + TI_DATA_SIZE, (uint8_t*)"\r", TI_DELIMITER_SIZE);
}

void ecr1264_clear_vram() {
	if (HAL_UART_Transmit(sp_huart, s_vram_clear_command, sizeof(s_vram_clear_command), HAL_MAX_DELAY) != HAL_OK)
	{
		Error_Handler();
	}
}

void ecr1264_set_ti_data(const uint8_t* data, size_t data_size, uint16_t offset) {
	memcpy(s_ti + TI_COMMAND_SIZE + offset, data, data_size);
}

void ecr1264_send_ti_data() {
    if (HAL_UART_Transmit(sp_huart, s_ti, sizeof(s_ti), HAL_MAX_DELAY) != HAL_OK)
    {
      Error_Handler();
    }
}

void ecr1264_update() {
	if (HAL_UART_Transmit(sp_huart, s_update_command, sizeof(s_update_command), HAL_MAX_DELAY) != HAL_OK)
	{
		Error_Handler();
	}
}
