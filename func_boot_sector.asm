;
; A boot sector that prints a string using our function.
;

; Tell the assembler where this code will be loaded.
[org 0x7c00]

mov bx, HELLO_MSG
call print_string

call print_new_line

mov bx, GOODBYE_MSG
call print_string

jmp $ ; Hang

%include "print_string.asm"

; Data
HELLO_MSG:
    db 'Hello, world!', 0

GOODBYE_MSG:
    db 'Goodbye!', 0

; Padding and magic number.
times 510-($-$$) db 0
dw 0xaa55
