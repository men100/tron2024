#ifndef __ECR1264_H__
#define __ECR1264_H__

#include "main.h"

void ecr1264_init(UART_HandleTypeDef* huart);

void ecr1264_clear_vram();

void ecr1264_set_ti_data(const uint8_t* data, size_t data_size, uint16_t offset);
void ecr1264_send_ti_data();

void ecr1264_update();

#endif /* __ECR1264_H__ */
