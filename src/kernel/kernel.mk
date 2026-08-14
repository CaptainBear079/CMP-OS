build-kernel-i686:
	$(TARGET_CC) $(TARGET_C_FLAGS) -I$(KERNEL) -o $(BUILD_DIR)/kernel_stdio.o $(KERNEL)/language_support/C/Standard_Libraries/stdio.c -D__32BIT__ -D__CPU_I686__
	$(TARGET_CC) $(TARGET_C_FLAGS) -I$(KERNEL) -o $(BUILD_DIR)/kernel_other.o $(KERNEL)/other.c -D__32BIT__ -D__CPU_I686__
	$(TARGET_CC) $(TARGET_C_FLAGS) -I$(KERNEL) -o $(BUILD_DIR)/kernel_GDT_C.o $(KERNEL)/SystemSetup/GDT.c -D__32BIT__ -D__CPU_I686__
	$(TARGET_CC) $(TARGET_C_FLAGS) -I$(KERNEL) -o $(BUILD_DIR)/ckernel.o $(KERNEL)/kernel.c -D__CPU_I686__
	$(TARGET_ASM) $(TARGET_ASM_FLAGS) -o $(BUILD_DIR)/kernel_asm.o $(KERNEL)/i686/protectedmode.asm
	$(TARGET_ASM) $(TARGET_ASM_FLAGS) -o $(BUILD_DIR)/kernel_GDT.o $(KERNEL)/SystemSetup/GDT.asm
	$(TARGET_LINKER) $(TARGET_LINKER_FLAGS) -Wl,-Map=$(BUILD_DIR)/kernel.map -T $(KERNEL)/linker.ld -o $(BUILD_DIR)/kernel.bin $(BUILD_DIR)/ckernel.o $(BUILD_DIR)/kernel_asm.o $(BUILD_DIR)/kernel_stdio.o $(BUILD_DIR)/kernel_other.o $(BUILD_DIR)/kernel_GDT.o $(BUILD_DIR)/kernel_GDT_C.o

kernel-clear:
	rm -f $(BUILD_DIR)/kernel/