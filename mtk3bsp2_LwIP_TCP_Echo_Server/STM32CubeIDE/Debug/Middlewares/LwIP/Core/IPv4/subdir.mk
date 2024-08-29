################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/autoip.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/dhcp.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/etharp.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/icmp.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/igmp.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_addr.c \
C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_frag.c 

OBJS += \
./Middlewares/LwIP/Core/IPv4/autoip.o \
./Middlewares/LwIP/Core/IPv4/dhcp.o \
./Middlewares/LwIP/Core/IPv4/etharp.o \
./Middlewares/LwIP/Core/IPv4/icmp.o \
./Middlewares/LwIP/Core/IPv4/igmp.o \
./Middlewares/LwIP/Core/IPv4/ip4.o \
./Middlewares/LwIP/Core/IPv4/ip4_addr.o \
./Middlewares/LwIP/Core/IPv4/ip4_frag.o 

C_DEPS += \
./Middlewares/LwIP/Core/IPv4/autoip.d \
./Middlewares/LwIP/Core/IPv4/dhcp.d \
./Middlewares/LwIP/Core/IPv4/etharp.d \
./Middlewares/LwIP/Core/IPv4/icmp.d \
./Middlewares/LwIP/Core/IPv4/igmp.d \
./Middlewares/LwIP/Core/IPv4/ip4.d \
./Middlewares/LwIP/Core/IPv4/ip4_addr.d \
./Middlewares/LwIP/Core/IPv4/ip4_frag.d 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/LwIP/Core/IPv4/autoip.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/autoip.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Core/IPv4/dhcp.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/dhcp.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Core/IPv4/etharp.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/etharp.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Core/IPv4/icmp.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/icmp.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Core/IPv4/igmp.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/igmp.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Core/IPv4/ip4.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Core/IPv4/ip4_addr.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_addr.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/LwIP/Core/IPv4/ip4_frag.o: C:/dev/git/tron2024/Middlewares/Third_Party/LwIP/src/core/ipv4/ip4_frag.c Middlewares/LwIP/Core/IPv4/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DUSE_HAL_DRIVER -DSTM32H723xx -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Src -I../../Inc -I../../../Middlewares/Third_Party/LwIP/system -I../../../Middlewares/Third_Party/LwIP/src/include -I../../../Drivers/BSP/STM32H7xx_Nucleo -I../../../Drivers/BSP/Components -I../../../Drivers/BSP/Components/Common -I../../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../../Drivers/CMSIS/Include -I../../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-LwIP-2f-Core-2f-IPv4

clean-Middlewares-2f-LwIP-2f-Core-2f-IPv4:
	-$(RM) ./Middlewares/LwIP/Core/IPv4/autoip.cyclo ./Middlewares/LwIP/Core/IPv4/autoip.d ./Middlewares/LwIP/Core/IPv4/autoip.o ./Middlewares/LwIP/Core/IPv4/autoip.su ./Middlewares/LwIP/Core/IPv4/dhcp.cyclo ./Middlewares/LwIP/Core/IPv4/dhcp.d ./Middlewares/LwIP/Core/IPv4/dhcp.o ./Middlewares/LwIP/Core/IPv4/dhcp.su ./Middlewares/LwIP/Core/IPv4/etharp.cyclo ./Middlewares/LwIP/Core/IPv4/etharp.d ./Middlewares/LwIP/Core/IPv4/etharp.o ./Middlewares/LwIP/Core/IPv4/etharp.su ./Middlewares/LwIP/Core/IPv4/icmp.cyclo ./Middlewares/LwIP/Core/IPv4/icmp.d ./Middlewares/LwIP/Core/IPv4/icmp.o ./Middlewares/LwIP/Core/IPv4/icmp.su ./Middlewares/LwIP/Core/IPv4/igmp.cyclo ./Middlewares/LwIP/Core/IPv4/igmp.d ./Middlewares/LwIP/Core/IPv4/igmp.o ./Middlewares/LwIP/Core/IPv4/igmp.su ./Middlewares/LwIP/Core/IPv4/ip4.cyclo ./Middlewares/LwIP/Core/IPv4/ip4.d ./Middlewares/LwIP/Core/IPv4/ip4.o ./Middlewares/LwIP/Core/IPv4/ip4.su ./Middlewares/LwIP/Core/IPv4/ip4_addr.cyclo ./Middlewares/LwIP/Core/IPv4/ip4_addr.d ./Middlewares/LwIP/Core/IPv4/ip4_addr.o ./Middlewares/LwIP/Core/IPv4/ip4_addr.su ./Middlewares/LwIP/Core/IPv4/ip4_frag.cyclo ./Middlewares/LwIP/Core/IPv4/ip4_frag.d ./Middlewares/LwIP/Core/IPv4/ip4_frag.o ./Middlewares/LwIP/Core/IPv4/ip4_frag.su

.PHONY: clean-Middlewares-2f-LwIP-2f-Core-2f-IPv4

