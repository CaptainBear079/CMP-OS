[BITS 16]   ; 16-bit mode
[ORG 0x7C00] ; Set origin to 0x7C00

%define ENDL 0x0D, 0x0A

_start:
jmp short main
nop

main:
; Data segments and stack setup (interrupts disabled)
cli
mov ax, 0
mov ds, ax
mov es, ax

mov ss, ax
mov sp, 0x07C00 ; up to 0x05000
sti

; save boot drive from dl
mov [boot_drive], dl

mov si, [dap]

; Read the sector with Stage 2
; - Check for EDD support
clc
mov ah, 0x41
mov bx, 0x55AA
int 0x13
jc no_edd
cmp bx, 0xAA55
jne no_edd

; - Read Sector
mov ah, 0x42
mov dl, [boot_drive]
mov si, dap
int 0x13
jc read_sector_error

mov dl, [boot_drive] ; Stage 2 expects dl to contain boot drive

jmp 0x0000:0x7E00

read_sector_error:
mov ah, 2
jmp ERROR

no_edd:
mov ah, 3
jmp ERROR

print_string:
mov ah, 0x0E
jmp next_char

ERROR:
cmp ah, 2
je ERROR__2
cmp ah, 3
je ERROR__3

ERROR__2:
mov si, ERROR_2
call print_string
jmp done

ERROR__3:
mov si, ERROR_3
call print_string
jmp done

next_char:
lodsb
cmp al, 0
je done
int 0x10
jmp next_char
done:
mov ah, 0

hlt

; Boot text
ERROR_2: db 'LBA Reading error. Please restart the PC. ERROR CODE 0x000002', ENDL, 0
ERROR_3: db 'No EDD support. Please restart the PC. ERROR CODE 0x000003', ENDL, 0

; Boot data space
boot_drive: db 0

; DAP
dap:
db 0x10   ; DAP size (always 0x10)
db 0x00   ; Reserved (always 0x00)
dw 0x000F ; Number of sectors to read
dw 0x7E00 ; Buffer address (segment)
dw 0x0000 ; Buffer address (offset)
dq 1      ; Starting LBA (bootmanager)

times 510-($-$$) db 0 ; Fill remaining partition table entries
; Boot signature
db 0x55
db 0xAA