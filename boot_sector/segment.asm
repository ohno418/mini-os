;
; A simple boot sector program that demonstrates segment offsetting.
;

; Segment offsetting calculation:
;   <value in segment register> * 16 + <offset value>

; tty mode
mov ah, 0x0e

; Without offsetting, wrong address.
mov al, [the_secret]
int 0x10

; Set the data segment register (ds).
; (Note that it's not possible to set ds directly.)
mov bx, 0x7c0
mov ds, bx
mov al, [the_secret]
int 0x10

; With extra (user defined) register.
mov al, [es: the_secret]
int 0x10

; With extra (user defined) register, that set the value 0x7c0.
mov bx, 0x7c0
mov es, bx
mov al, [es: the_secret]
int 0x10

jmp $

the_secret:
    db "X"

; Padding and magic BIOS number.
times 510-($-$$) db 0
dw 0xaa55


; nasm -f bin -o segment.bin segment.asm && qemu-system-x86_64 segment.bin
