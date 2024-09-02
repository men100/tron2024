################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.c \
C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.c \
C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.c 

S_UPPER_SRCS += \
C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/dispatch.S 

OBJS += \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.o \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/dispatch.o \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.o \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.o 

S_UPPER_DEPS += \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/dispatch.d 

C_DEPS += \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.d \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.d \
./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.o: C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.c mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../../Middlewares/Third_Party/LwIP/system -I../../Middlewares/Third_Party/LwIP/src/include -I../../Drivers/BSP/STM32H7xx_Nucleo -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/dispatch.o: C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/dispatch.S mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"
mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.o: C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.c mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../../Middlewares/Third_Party/LwIP/system -I../../Middlewares/Third_Party/LwIP/src/include -I../../Drivers/BSP/STM32H7xx_Nucleo -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.o: C:/dev/git/tron2024/mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.c mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx -D_STM32CUBE_NUCLEO_H723_ -c -I../../Middlewares/Third_Party/LwIP/system -I../../Middlewares/Third_Party/LwIP/src/include -I../../Drivers/BSP/STM32H7xx_Nucleo -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-sysdepend-2f-nxp_mcux-2f-cpu-2f-core-2f-armv8m

clean-mtk3_bsp2-2f-sysdepend-2f-nxp_mcux-2f-cpu-2f-core-2f-armv8m:
	-$(RM) ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.cyclo ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.d ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.o ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/cpu_cntl.su ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/dispatch.d ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/dispatch.o ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.cyclo ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.d ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.o ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/interrupt.su ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.cyclo ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.d ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.o ./mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m/sys_start.su

.PHONY: clean-mtk3_bsp2-2f-sysdepend-2f-nxp_mcux-2f-cpu-2f-core-2f-armv8m

