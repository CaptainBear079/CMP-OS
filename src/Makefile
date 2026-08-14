include ./../build_scripts/config.mk
include ./bootloader/bootloader.mk
include ./kernel/kernel.mk

all:
	echo "Specify architecture: i686"

create-build-dir:
	mkdir -p $(BUILD_DIR)/bootloader
	mkdir -p $(BUILD_DIR)/kernel

i686: create-build-dir build-bootloader build-kernel-i686
	cat $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/kernel.bin > $(BUILD_DIR)/os.img

clear:
	rm -rf $(BUILD_DIR)
