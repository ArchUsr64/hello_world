[org 0x7c00]
str_len EQU 10
line_feed EQU 0x0a
carriage_feed EQU 0x0D
enter_scancode EQU 0x1c

start:
	mov ah, 0x0e
	mov si, input_prompt
	call print_string

echo_mode:
	mov bx, input_buffer
echo_loop:
	mov ah, 0
	int 0x16
	cmp ah, enter_scancode
	mov ah, 0x0e
	int 0x10
	je output
	mov [bx], al
	inc bx
	jmp echo_loop

output:
	mov ah, 0x0e
	mov al, line_feed
	int 0x10
	mov si, output_prompt
	call print_string

print_inverted_case:
	mov bx, input_buffer
print_inverted_case_loop:
	mov al, [bx]
	cmp al, 0
	je restart
	xor al, 0x20
	int 0x10
	inc bx
	jmp print_inverted_case_loop

restart:
	mov ah, 0x0e
	mov al, line_feed
	mov ah, 0x0e
	int 0x10
	mov al, 13
	int 0x10
	jmp start

end:
	nop
	jmp end

print_string:
	; Expects the pointer to string in si
	mov al, [si]
	cmp al, 0
	je return
	int 0x10
	inc si
	jmp print_string
return:
	ret

input_prompt:
	DB "Enter string: ", 0

output_prompt:
	DB "Toggled Case: ", 0

input_buffer:
	TIMES str_len DB 0

DB 510-($-$$) DUP(0)
DW 0xaa55
