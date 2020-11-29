; BIOS read disk sectors
; (https://stanislavs.org/helppc/int_13-2.html)

; Requirement:
;   - DL    = drive number
;   - DH    = how many sectors to read
;   - ES:BX = pointer to buffer (segment ES with offset BX)

disk_load:
    ; Store DX on the stack, to recall
    ; how many sectors are requested to read.
    push dx

    ; BIOS read sector mode
    mov ah, 0x02

    mov al, dh   ; Read DH sectors from the start point
    mov ch, 0x00 ; Select cylinder 0
    mov cl, 0x02 ; Start reading from second sector
                 ; (i.e. after the boot sector)
    mov dh, 0x00 ; Select head 0 (count from 0)

    ; Do actual read
    int 0x13

    ; Error handling
    ; 1. Jump if carry flag (CF) was set (i.e. error raised)
    jc disk_error
    ; 2. Compare two numbers;
    ;    how many sectors were requested to read,
    ;    and how many sectors were actually read.
    pop dx
    cmp al, dh ; AL = number of sectors read
    jne disk_error

    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG:
    db "Disk read error!", 0
