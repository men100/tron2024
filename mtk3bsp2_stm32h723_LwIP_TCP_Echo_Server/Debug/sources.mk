################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

ELF_SRCS := 
OBJ_SRCS := 
S_SRCS := 
C_SRCS := 
S_UPPER_SRCS := 
O_SRCS := 
CYCLO_FILES := 
SIZE_OUTPUT := 
OBJDUMP_LIST := 
SU_FILES := 
EXECUTABLES := 
OBJS := 
MAP_FILES := 
S_DEPS := 
S_UPPER_DEPS := 
C_DEPS := 

# Every subdirectory with source files must be described here
SUBDIRS := \
Application \
Core/Src \
Core/Startup \
Drivers/BSP/STM32H743ZI-Nucleo \
Drivers/STM32H7xx_HAL_Driver/Src \
mtk3_bsp2/mtkernel/device/adc \
mtk3_bsp2/mtkernel/device/adc/sysdepend/rx231 \
mtk3_bsp2/mtkernel/device/adc/sysdepend/rx65n \
mtk3_bsp2/mtkernel/device/adc/sysdepend/rza2m \
mtk3_bsp2/mtkernel/device/adc/sysdepend/stm32h7 \
mtk3_bsp2/mtkernel/device/adc/sysdepend/stm32l4 \
mtk3_bsp2/mtkernel/device/adc/sysdepend/tx03_m367 \
mtk3_bsp2/mtkernel/device/common/drvif \
mtk3_bsp2/mtkernel/device/i2c \
mtk3_bsp2/mtkernel/device/i2c/sysdepend/rx231 \
mtk3_bsp2/mtkernel/device/i2c/sysdepend/rx65n \
mtk3_bsp2/mtkernel/device/i2c/sysdepend/rza2m \
mtk3_bsp2/mtkernel/device/i2c/sysdepend/stm32h7 \
mtk3_bsp2/mtkernel/device/i2c/sysdepend/stm32l4 \
mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367 \
mtk3_bsp2/mtkernel/device/ser \
mtk3_bsp2/mtkernel/device/ser/sysdepend/rx231 \
mtk3_bsp2/mtkernel/device/ser/sysdepend/rx65n \
mtk3_bsp2/mtkernel/device/ser/sysdepend/rza2m \
mtk3_bsp2/mtkernel/device/ser/sysdepend/stm32h7 \
mtk3_bsp2/mtkernel/device/ser/sysdepend/stm32l4 \
mtk3_bsp2/mtkernel/device/ser/sysdepend/tx03_m367 \
mtk3_bsp2/mtkernel/kernel/inittask \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7a \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/armv7m \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2 \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/rx231 \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/rx65n \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/rza2m \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/stm32h7 \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/stm32l4 \
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/tx03_m367 \
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_m367 \
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_rx231 \
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_rza2m \
mtk3_bsp2/mtkernel/kernel/sysdepend/iote_stm32l4 \
mtk3_bsp2/mtkernel/kernel/sysinit \
mtk3_bsp2/mtkernel/kernel/tkernel \
mtk3_bsp2/mtkernel/kernel/tstdlib \
mtk3_bsp2/mtkernel/kernel/usermain \
mtk3_bsp2/mtkernel/lib/libtk \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/core/armv7a \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/core/armv7m \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/core/rxv2 \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/rx231 \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/rx65n \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/rza2m \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7 \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32l4 \
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/tx03_m367 \
mtk3_bsp2/mtkernel/lib/libtm \
mtk3_bsp2/mtkernel/lib/libtm/sysdepend/iote_m367 \
mtk3_bsp2/mtkernel/lib/libtm/sysdepend/iote_rx231 \
mtk3_bsp2/mtkernel/lib/libtm/sysdepend/iote_rza2m \
mtk3_bsp2/mtkernel/lib/libtm/sysdepend/iote_stm32l4 \
mtk3_bsp2/mtkernel/lib/libtm/sysdepend/no_device \
mtk3_bsp2/sysdepend/nxp_mcux/cpu/core/armv8m \
mtk3_bsp2/sysdepend/nxp_mcux/device/hal_adc \
mtk3_bsp2/sysdepend/nxp_mcux/device/hal_lpi2c \
mtk3_bsp2/sysdepend/nxp_mcux \
mtk3_bsp2/sysdepend/nxp_mcux/lib/libtk/cpu/core/armv8m \
mtk3_bsp2/sysdepend/nxp_mcux/lib/libtm/evk_lpc55s69 \
mtk3_bsp2/sysdepend/nxp_mcux/lib/libtm/frdm_mcxn947 \
mtk3_bsp2/sysdepend/ra_fsp/cpu/core/armv7m \
mtk3_bsp2/sysdepend/ra_fsp/cpu/core/armv8m \
mtk3_bsp2/sysdepend/ra_fsp/device/hal_adc \
mtk3_bsp2/sysdepend/ra_fsp/device/hal_i2c \
mtk3_bsp2/sysdepend/ra_fsp/device/hal_i3c_i2c \
mtk3_bsp2/sysdepend/ra_fsp/device/hal_sci_i2c \
mtk3_bsp2/sysdepend/ra_fsp \
mtk3_bsp2/sysdepend/ra_fsp/lib/libtk/cpu/core/armv7m \
mtk3_bsp2/sysdepend/ra_fsp/lib/libtk/cpu/core/armv8m \
mtk3_bsp2/sysdepend/ra_fsp/lib/libtm/arduino_unor4 \
mtk3_bsp2/sysdepend/ra_fsp/lib/libtm/ek_ra6m3 \
mtk3_bsp2/sysdepend/ra_fsp/lib/libtm/ek_ra8m1 \
mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv7m \
mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc \
mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend \
mtk3_bsp2/sysdepend/stm32_cube/device/hal_i2c \
mtk3_bsp2/sysdepend/stm32_cube \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/core/armv7m \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32f4 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32f7 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32g4 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32h7 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk/cpu/stm32l4 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtk \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32f401 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32f411 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32f446 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32f767 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32g431 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32g491 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32h723 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32l476 \
mtk3_bsp2/sysdepend/stm32_cube/lib/libtm/nucleo_stm32l4r5 \
