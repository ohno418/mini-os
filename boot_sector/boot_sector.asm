[org 0x7c00]
    ; BIOS stores our boot drive in DL.
    mov [BOOT_DRIVE], dl

    ; Stack settings.
    mov bp, 0x8000
    mov sp, bp

    ; Disk read settings.
    ; See disk_load.asm.
    mov dl, [BOOT_DRIVE]
    mov dh, 2
    mov bx, 0
    mov es, bx
    mov bx, 0x9000
    call disk_load

    mov dx, [0x9000]
    call print_hex

    call print_new_line

    mov dx, [0x9000 + 510]
    call print_hex

    call print_new_line

    mov dx, [0x9000 + 512]
    call print_hex

    jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

BOOT_DRIVE:
    db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xcada
times 256 dw 0xface

; nasm -f bin -o boot_sector.bin boot_sector.asm && qemu-system-x86_64 boot_sector.bin
