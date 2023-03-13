SYS_WRITE equ 1
SYS_EXIT  equ 60

section .data
message: db "Hello, world!", 10
message_size equ $ - message

section .text
global _start
_start:
	mov rax, SYS_WRITE
	mov rdi, 1
	mov rsi, message
	mov rdx, message_size
	syscall

	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
