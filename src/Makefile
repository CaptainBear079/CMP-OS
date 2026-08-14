include ./../build_scripts/config.mk
include ./bootloader/bootloader.mk
include ./kernel/kernel.mk

all:
	echo "Specify architecture: i686"

create-build-dir:
	mkdir -p $(BUILD_DIR)/bootloader
	mkdir -p $(BUILD_DIR)/kernel

i686: clear create-build-dir build-bootloader build-kernel-i686
	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/os.img bs=512 count=1 conv=notrunc
	dd if=$(BUILD_DIR)/kernel.bin of=$(BUILD_DIR)/os.img bs=512 seek=16 count=10 conv=sync

clear:
	rm -rf $(BUILD_DIR)

emulate:
	$(EMULATOR) $(EMULATOR_FLAGS)
