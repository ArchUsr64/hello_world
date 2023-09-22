start:
  mov al, 'H'
  call write_char
  call move_cursor_right
  mov al, 'e'
  call write_char
  call move_cursor_right
  mov al, 'l'
  call write_char
  call move_cursor_right
  mov al, 'l'
  call write_char
  call move_cursor_right
  mov al, 'o'
  call write_char
  call move_cursor_right
  mov al, ','
  call write_char
  call move_cursor_right
  mov al, ' '
  call write_char
  call move_cursor_right
  mov al, 'W'
  call write_char
  call move_cursor_right
  mov al, 'o'
  call write_char
  call move_cursor_right
  mov al, 'r'
  call write_char
  call move_cursor_right
  mov al, 'l'
  call write_char
  call move_cursor_right
  mov al, 'd'
  call write_char
  call move_cursor_right
  mov al, '!'
  call write_char
  call move_cursor_right
  jmp end

write_char:
  ; Write character storead at al with color white
  mov ah, 0x09
  ; Count of character
  mov cx, 0x01
  ; Set color for character writing
  mov bl, 0x0f
  ; Page number
  mov bh, 0x00
  int 0x10
  ret

move_cursor_right:
  ; Moves the cursor right by 1 character
  ; Get character position
  mov ah, 0x03
  mov bh, 0x00
  int 0x10
  ; Set character position
  mov ah, 0x02
  inc dl
  int 0x10
  ret

end:
  nop
  jmp end

DB 510-($-start) DUP(0)
DW 0xaa55
