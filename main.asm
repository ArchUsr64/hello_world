start:
	mov al, 'A'
alphs:
	call write_char
	inc al
	cmp al, 'Z' + 1
	jne alphs
	jmp end

write_char:
	mov bh, 0x00
	mov bl, 0x0f
	mov ah, 0x0e
	int 0x10
	ret

end:
	nop
	jmp end

DB 510-($-start) DUP(0)
DW 0xaa55
