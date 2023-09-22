[org 0x7c00]
mov ah, 0x0e
mov bx, string
	cmp al, 0
	je end
start:
	mov al, [bx]
	cmp al, 0
	je end
	int 0x10
	inc bx
	jmp start

end:
	nop
	jmp end

string:
	DB "Hello, World!", 0

DB 510-($-$$) DUP(0)
DW 0xaa55
