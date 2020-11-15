;
; A simple boot sector that prints a message to the screen using a BIOS routine.
;

; tele-type mode.
mov ah, 0x0e

mov al, 'h'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

; TODO: ???
jmp $

; padding and magic BIOS number.
times 510-($-$$) db 0
dw 0xaa55
