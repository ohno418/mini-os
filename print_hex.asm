print_hex:
    pusha

    ; Print prefix '0x'
    mov ah, 0x0e
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    ; Use cx as loop index.
    mov cx, 0
    jmp loop

; Process a first digit of hex number, and print it.
loop:
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
    jg print_char
    jmp print_num

; 0xa~0xf
print_char:
    ; Convert hex alphabet number to ascii character.
    ; (e.g. 0x000d -> 0x0044 (ascii 'D'))
    add ax, 0x37
    jmp print_ax

; 0x0~0x9
print_num:
    ; Convert hex number to ascii character.
    ; (e.g. 0x0002 -> 0x0032 (ascii '2'))
    add ax, 0x30
    jmp print_ax

print_ax:
    mov ah, 0x0e
    int 0x10
    jmp loop_update

loop_update:
    ; Increment loop index.
    add cx, 1

    ; End loop condition
    cmp cx, 4
    je end_print_hex

    ; Left shift
    ; (e.g. 0x2fe5 -> 0xfe50)
    shl dx, 0x04
    jmp loop

end_print_hex:
    popa
    ret
