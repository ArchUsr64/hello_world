start:
	mov cl, 'A'
alphs:
	mov al, cl
	and al, 0x1
	mov al, cl
	jnz skip_case_change
	or al, 0x20
skip_case_change:
	call write_char
	inc cl
	cmp cl, 'Z' + 1
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
