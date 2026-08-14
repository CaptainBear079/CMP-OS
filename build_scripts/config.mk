
# Directories
BUILD_DIR = $(abspath ./../build)
BOOTLOADER_STAGE1 = $(abspath ./bootloader/stage1)
BOOTLOADER_STAGE2 = $(abspath ./bootloader/stage2)
KERNEL = $(abspath ./kernel)

# Toolchain variables
TOOLCHAIN_PREFIX = $(abspath ./../toolchain/$(TOOLCHAIN))
TOOLCHAIN_TARGET = $(TOOLCHAIN)

# Binaries
BOOTLOADER_STAGE1_BIN = bootloader.bin
BOOTLOADER_STAGE2_BIN = bootmanager.bin
KERNEL_BIN = kernel.bin

export PATH := $(TOOLCHAIN_PREFIX)/bin:$(PATH)

export TOOLCHAIN = i686-elf

export CC = gcc
export CXX = g++
export LINKER = gcc
export C_FLAGS = -c -Wall -std=c99 -g -fno-builtin-printf
export LINKER_FLAGS = -x none -nostdlib

export TARGET_CC = $(abspath ./../../toolchain/$(TOOLCHAIN)/bin/$(TOOLCHAIN)-gcc)
export TARGET_CXX = $(abspath ./../../toolchain/$(TOOLCHAIN)/bin/$(TOOLCHAIN)-g++)
export TARGET_LINKER = $(abspath ./../../toolchain/$(TOOLCHAIN)/bin/$(TOOLCHAIN)-gcc)
export TARGET_C_FLAGS = -c -Wall -std=c99 -g -nostdlib -ffreestanding
export TARGET_LINKER_FLAGS = -nostdlib -ffreestanding -lgcc
export TARGET_ASM = /usr/bin/nasm
export TARGET_ASM_FLAGS = -f elf
export TARGET_STAGE1_ASM_FLAGS = -f bin

export EMULATOR = qemu-system-x86_64
export EMULATOR_FLAGS = -drive format=raw,file=$(BUILD_DIR)/os.img -m 512M -smp 2
