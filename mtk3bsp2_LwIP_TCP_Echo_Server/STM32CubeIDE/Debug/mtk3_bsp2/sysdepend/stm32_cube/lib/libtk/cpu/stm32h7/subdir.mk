################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/dev/git/tron2024/mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.c \
C:/dev/git/tron2024/mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.c 

OBJS += \
./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.o \
./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.o 

C_DEPS += \
./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.d \
./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.o: C:/dev/git/tron2024/mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.c mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.o: C:/dev/git/tron2024/mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.c mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-lib-2f-libtk-2f-cpu-2f-stm32h7

clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-lib-2f-libtk-2f-cpu-2f-stm32h7:
	-$(RM) ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.d ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.o ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/int_stm32h7.su ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.d ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.o ./mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7/ptimer_stm32h7.su

.PHONY: clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-lib-2f-libtk-2f-cpu-2f-stm32h7

