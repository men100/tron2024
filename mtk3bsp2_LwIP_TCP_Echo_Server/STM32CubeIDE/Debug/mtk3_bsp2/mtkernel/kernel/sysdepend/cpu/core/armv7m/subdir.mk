################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.c \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.c \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.c \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.c 

S_UPPER_SRCS += \
C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/dispatch.S 

OBJS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/dispatch.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.o 

S_UPPER_DEPS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/dispatch.d 

C_DEPS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.c mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/dispatch.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/dispatch.S mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Inc -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.c mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.c mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.o: C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.c mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-cpu-2f-core-2f-armv7m

clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-cpu-2f-core-2f-armv7m:
	-$(RM) ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/cpu_cntl.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/dispatch.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/dispatch.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/exc_hdr.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/interrupt.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m/reset_hdl.su

.PHONY: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-cpu-2f-core-2f-armv7m

