build-bootloader:
	$(TARGET_ASM) $(TARGET_STAGE1_ASM_FLAGS) -o $(BUILD_DIR)/bootloader/bootloader_stage1.bin $(BOOTLOADER_STAGE1)/BOOT.asm
	$(TARGET_ASM) $(TARGET_ASM_FLAGS) -o $(BUILD_DIR)/bootloader/entry.o $(BOOTLOADER_STAGE2)/entry.asm
	$(TARGET_ASM) $(TARGET_ASM_FLAGS) -o $(BUILD_DIR)/bootloader/realmode.o $(BOOTLOADER_STAGE2)/realmode.asm
	$(TARGET_ASM) $(TARGET_ASM_FLAGS) -o $(BUILD_DIR)/bootloader/protectedmode.o $(BOOTLOADER_STAGE2)/protectedmode.asm
	$(TARGET_CC) $(TARGET_C_FLAGS) -o $(BUILD_DIR)/bootloader/utils.o $(BOOTLOADER_STAGE2)/utils.c -D__32BIT__
	$(TARGET_CC) $(TARGET_C_FLAGS) -o $(BUILD_DIR)/bootloader/restdio.o $(BOOTLOADER_STAGE2)/stdio.c -D__32BIT__
	$(TARGET_CC) $(TARGET_C_FLAGS) -o $(BUILD_DIR)/bootloader/disk.o $(BOOTLOADER_STAGE2)/disk.c -D__32BIT__
	$(TARGET_CC) $(TARGET_C_FLAGS) -o $(BUILD_DIR)/bootloader/bootmanager.o $(BOOTLOADER_STAGE2)/bootmanager.c
	$(TARGET_LINKER) $(TARGET_LINKER_FLAGS) -Wl,-Map=$(BUILD_DIR)/bootmanager.map -T $(BOOTLOADER_STAGE2)/linker.ld -o $(BUILD_DIR)/bootloader/bootmanager.bin $(BUILD_DIR)/bootloader/entry.o $(BUILD_DIR)/bootloader/bootmanager.o $(BUILD_DIR)/bootloader/restdio.o $(BUILD_DIR)/bootloader/realmode.o $(BUILD_DIR)/bootloader/protectedmode.o $(BUILD_DIR)/bootloader/disk.o $(BUILD_DIR)/bootloader/utils.o
	dd if=$(BUILD_DIR)/bootloader/bootloader_stage1.bin of=$(BUILD_DIR)/bootloader.bin bs=512 count=1 conv=notrunc
	dd if=$(BUILD_DIR)/bootloader/bootmanager.bin of=$(BUILD_DIR)/bootloader.bin bs=512 seek=1 count=15 conv=sync

bootloader-clear:
	rm -f $(BUILD_DIR)/bootloader/
