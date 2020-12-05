[bits 32]

; Define some constants.
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY   ; Set EDX to the start of vid mem.

print_string_pm_loop:
    mov al, [ebx]           ; Store the char at EBX in AL.
    mov ah, WHITE_ON_BLACK  ; Store the attributes in AH.

    cmp al, 0               ; Check if end of string.
    je print_string_pm_done

    mov [edx], ax ; Store char and attrs at current character cell.
    add ebx, 1    ; Increment to the next char in string.
    add edx, 2    ; Move to next char cell in vid mem.
                  ; (Each char cell of the screen is represented by 2 bytes in memory.)

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
