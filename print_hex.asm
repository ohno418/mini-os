print_hex:
    pusha

    ; Print prefix '0x'
    mov ah, 0x0e
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    ; Use cx as the interation index.
    mov cx, 0
    jmp print_hex_iter

print_hex_iter:
    ; Use ax as working register.
    mov ax, dx

    ; Mask last 3 numbers to 0.
    ; (e.g. 0x2fe5 -> 0x2000)
    and ax, 0xf000

    ; Right shift
    ; (e.g. 0x2000 -> 0x0002)
    shr ax, 0x0c

    ; Print last hex digit.
    cmp ax, 0x09
    jg print_hex_char
    jmp print_hex_num

print_hex_char:
    ; Convert hex alphabet number to ascii character.
    ; (e.g. 0x000d -> 0x0044 (ascii 'D'))
    add ax, 0x37
    jmp print_ax

print_hex_num:
    ; Convert hex number to ascii character.
    ; (e.g. 0x0002 -> 0x0032 (ascii '2'))
    add ax, 0x30
    jmp print_ax

print_ax:
    mov ah, 0x0e
    int 0x10
    jmp print_hex_iter_update

print_hex_iter_update:
    add cx, 1
    cmp cx, 4
    je end_print_hex

    ; Left shift
    ; (e.g. 0x2fe5 -> 0xfe50)
    shl dx, 0x04
    jmp print_hex_iter

end_print_hex:
    popa
    ret
