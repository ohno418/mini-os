print_string:
    pusha
    jmp exec

exec:
    ; Print a character
    mov ah, 0x0e
    mov al, [bx]
    int 0x10

    ; Increment pointe.
    add bx, 1

    mov cl, [bx]
    cmp cl, 0
    je end
    jmp exec

end:
    popa
    ret


print_new_line:
    pusha
    mov ah, 0x0e
    mov al, 0x0a ; '\n'
    int 0x10
    mov al, 0x0d ; '\r'
    int 0x10
    popa
    ret
