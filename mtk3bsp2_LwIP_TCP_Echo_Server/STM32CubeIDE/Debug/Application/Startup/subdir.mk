################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Application/Startup/startup_stm32h723zgtx.s 

OBJS += \
./Application/Startup/startup_stm32h723zgtx.o 

S_DEPS += \
./Application/Startup/startup_stm32h723zgtx.d 


# Each subdirectory must supply rules for building sources it contributes
Application/Startup/%.o: ../Application/Startup/%.s Application/Startup/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -D_STM32CUBE_NUCLEO_H723_ -c -I../../Inc -I"C:/dev/git/tron2024/mtk3_bsp2" -I"C:/dev/git/tron2024/mtk3_bsp2/config" -I"C:/dev/git/tron2024/mtk3_bsp2/include" -I"C:/dev/git/tron2024/mtk3_bsp2/mtkernel/kernel/knlinc" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Application-2f-Startup

clean-Application-2f-Startup:
	-$(RM) ./Application/Startup/startup_stm32h723zgtx.d ./Application/Startup/startup_stm32h723zgtx.o

.PHONY: clean-Application-2f-Startup

