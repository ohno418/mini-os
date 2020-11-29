; nasm -f bin -o condition_boot_sector.bin condition_boot_sector.asm && qemu-system-x86_64 condition_boot_sector.bin

mov bx, 30

cmp bx, 4
jle less_4

cmp bx, 40
jl less_or_equal_40

mov al, 'C'
jmp endif

less_4:
    mov al, 'A'
    jmp endif

less_or_equal_40:
    mov al, 'B'
    jmp endif

endif:
mov ah, 0x0e
int 0x10

jmp $

times  510-($-$$) db 0
dw 0xaa55
