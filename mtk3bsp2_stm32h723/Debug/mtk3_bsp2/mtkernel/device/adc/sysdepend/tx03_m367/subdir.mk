################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.c 

OBJS += \
./mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.o 

C_DEPS += \
./mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.c mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-mtkernel-2f-device-2f-adc-2f-sysdepend-2f-tx03_m367

clean-mtk3_bsp2-2f-mtkernel-2f-device-2f-adc-2f-sysdepend-2f-tx03_m367:
	-$(RM) ./mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.cyclo ./mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.d ./mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.o ./mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367/adc_m367.su

.PHONY: clean-mtk3_bsp2-2f-mtkernel-2f-device-2f-adc-2f-sysdepend-2f-tx03_m367

