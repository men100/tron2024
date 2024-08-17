################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/netif/ethernet.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/system/OS/sys_arch.c 

OBJS += \
./Middlewares/LwIP/Netif/ethernet.o \
./Middlewares/LwIP/Netif/sys_arch.o 

C_DEPS += \
./Middlewares/LwIP/Netif/ethernet.d \
./Middlewares/LwIP/Netif/sys_arch.d 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/LwIP/Netif/ethernet.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/netif/ethernet.c Middlewares/LwIP/Netif/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/BSP/Components -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/Components/Common -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Netif/sys_arch.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/system/OS/sys_arch.c Middlewares/LwIP/Netif/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/BSP/Components -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/Components/Common -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-LwIP-2f-Netif

clean-Middlewares-2f-LwIP-2f-Netif:
	-$(RM) ./Middlewares/LwIP/Netif/ethernet.cyclo ./Middlewares/LwIP/Netif/ethernet.d ./Middlewares/LwIP/Netif/ethernet.o ./Middlewares/LwIP/Netif/ethernet.su ./Middlewares/LwIP/Netif/sys_arch.cyclo ./Middlewares/LwIP/Netif/sys_arch.d ./Middlewares/LwIP/Netif/sys_arch.o ./Middlewares/LwIP/Netif/sys_arch.su

.PHONY: clean-Middlewares-2f-LwIP-2f-Netif

