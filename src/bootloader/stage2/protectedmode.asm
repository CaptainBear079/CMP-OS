extern __bss_start
extern __end

extern call_c

section .text
; Switch to protected mode
global switch_to_protected_mode
switch_to_protected_mode:
    [bits 16]
    cli
    lgdt [gdt_descriptor] ; Load GDT
    call EnableA20
    mov eax, cr0
    or  eax, 1
    mov cr0, eax

    jmp dword 0x08:protected_mode_entry

protected_mode_entry:
    [bits 32]
    mov eax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0xFFF0
    mov ebp, esp
 
    sti

    mov edi, __bss_start
    mov ecx, __end
    sub ecx, edi
    mov al, 0
    cld
    rep stosb
    cld

    jmp dword 0x08:call_c

EnableA20:
    [bits 16]
    push ax
    in al, 0x92
    or al, 00000010b
    out 0x92, al
    pop ax
    ret

global asm_input
global asm_output
asm_input:
    [bits 32]
    ; Input for C
    ; Stack frame and callee-saved registers
    push ebp
    mov ebp, esp
    push edx
    

    ; Get port (uint16_t) in dx and value (uint8_t) in al
    mov dx, [ebp + 8]
    xor eax, eax
    in al, dx

    ; Restore stack frame
    pop edx
    pop ebp
    ret

asm_output:
    [bits 32]
    ; Output for C
    ; Stack frame and callee-saved registers
    push ebp
    mov ebp, esp
    push edx
    push eax

    ; Get port (uint16_t) in dx and value (uint8_t) in al
    mov dx, [ebp + 8]
    mov al, [ebp + 12]
    out dx, al

    ; Restore stack frame
    pop eax
    pop edx
    pop ebp
    ret

section .data
gdt_start:
    dq 0 ; Null descriptor

    ; 32 Bit Code segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

    ; 32 Bit Data segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

    ; 16 Bit Code segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 00000000b
    db 0x00

    ; 16 Bit Data segment
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 00000000b
    db 0x00
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1   ; size of GDT (limit)
    dd gdt_start                 ; address of GDT