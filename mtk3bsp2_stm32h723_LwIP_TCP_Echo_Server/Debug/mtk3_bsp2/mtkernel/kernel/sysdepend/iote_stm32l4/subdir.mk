################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.c \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.c \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.c \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.c 

OBJS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.o 

C_DEPS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.c mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../../Middlewares/Third_Party/LwIP/system -I../../Middlewares/Third_Party/LwIP/src/include -I../../Drivers/BSP/STM32H7xx_Nucleo -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.c mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../../Middlewares/Third_Party/LwIP/system -I../../Middlewares/Third_Party/LwIP/src/include -I../../Drivers/BSP/STM32H7xx_Nucleo -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.c mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../../Middlewares/Third_Party/LwIP/system -I../../Middlewares/Third_Party/LwIP/src/include -I../../Drivers/BSP/STM32H7xx_Nucleo -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.c mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../../Middlewares/Third_Party/LwIP/system -I../../Middlewares/Third_Party/LwIP/src/include -I../../Drivers/BSP/STM32H7xx_Nucleo -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-iote_stm32l4

clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-iote_stm32l4:
	-$(RM) ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/cpu_clock.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/devinit.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/hw_setting.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4/power_save.su

.PHONY: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-iote_stm32l4
