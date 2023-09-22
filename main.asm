[org 0x7c00]
LINE_FEED EQU 0x0a
CARRIAGE_FEED EQU 0x0D
SECOND_SECTOR_LOCATION EQU 0x7e00

start:
	; Store disk num from BIOS
	mov [DISK_NUM], dl

	; Set Extra segment to 0
	mov ax, 0
	mov es, ax

	mov ah, 0x02
	mov al, 0x01
	mov ch, 0x00
	mov cl, 0x02
	mov dh, 0x00
	mov dl, [DISK_NUM]
	mov bx, SECOND_SECTOR_LOCATION
	int 0x13
	jc handle_disk_errors

	mov si, SECOND_SECTOR_LOCATION
	call print_string
	jmp end

print_string:
	; Expects the pointer to string in si
	mov ah, 0x0e
print_string_loop:
	mov al, [si]
	cmp al, 0
	je print_string_return
	int 0x10
	inc si
	jmp print_string_loop
print_string_return:
	ret

handle_disk_errors:
	mov si, FAIL_MESSAGE
	jmp end
	

end:
	nop
	jmp end

DISK_NUM:
	DB 0

FAIL_MESSAGE:
	DB "Failed to read second disk sector, ERROR CODE: 0x[TODO!]", 0

DB 510-($-$$) DUP(0)
DW 0xaa55

DB "String from other sector", 0
