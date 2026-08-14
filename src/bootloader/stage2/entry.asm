bits 16
; Bootmanager asm c setup using GCC

section .entry

extern __bss_start
extern __end

extern _cstart
extern switch_to_protected_mode
global bootmanager_entry
global call_c

bootmanager_entry:
    [bits 16]
    mov [bootdrive], dl

    ; Setup
    cli
    mov ax, ds ; DS should be zero since stage 1 just set it up but didn't change it
    mov ss, ax
    mov sp, 0xFFF0
    mov bp, sp
    sti

    call switch_to_protected_mode

call_c:
    [bits 32]

    ; Pass parameters to C code _cstart(uint32_t boot_drive)
    mov dl, [bootdrive]
    xor dh, dh
    push edx
    call _cstart ; Call C code to handle the boot manager logic

    cli
    hlt

section .data
; System Information
global bootdrive
bootdrive: db 0