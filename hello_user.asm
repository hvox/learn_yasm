SYS_READ  equ 0
SYS_WRITE equ 1
SYS_EXIT  equ 60

MAX_NAME_SIZE equ 10

section .data
prompt: db "Enter your name: "
prompt_size equ $ - prompt
message: db "I'm glad to see you, "
message_size equ $ - message

section .bss
name resb MAX_NAME_SIZE
access_check resb 8

section .text
global _start
_start:
	mov qword [access_check], 42

	mov rax, SYS_WRITE
	mov rdi, 1
	mov rsi, prompt
	mov rdx, prompt_size
	syscall

	mov rax, SYS_READ
	mov rdi, 0
	mov rsi, name
	mov rdx, MAX_NAME_SIZE
	sub rdx, 1 ; for \0
	syscall

	cmp rax, 0
	jge name_is_successfully_readed
	mov rax, SYS_EXIT
	mov rdi, 1
	syscall

name_is_successfully_readed:
	mov rsi, name
	mov byte [rsi+rax-1], 10
	mov byte [rsi+rax], 0

	mov rax, SYS_WRITE
	mov rdi, 1
	mov rsi, message
	mov rdx, message_size
	syscall

	mov rax, SYS_WRITE
	mov rdi, 1
	mov rsi, name
	mov rdx, MAX_NAME_SIZE
	syscall

	mov rax, SYS_EXIT
	mov rdi, [access_check]
	syscall
