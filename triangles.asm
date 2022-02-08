extern printf
extern scanf
extern cos
extern sin

global triangles

segment .data

; triangle stuff
pi: db 0x400921FB54442D18

; prompts
input3prompt: db "Please enter the length of side 1, length of side 2, and size (degrees) of the included angle between them as real float numbers. Separate the numbers by white space, and be sure to press <enter> after the last inputted number.  ", 0
prompt_name: db "Please enter your name: ", 0

; formats
string_format: db "%s", 0
three_float_format: db "%lf %lf %lf", 0


; messages
welcome_msg: db  "We take care of all your triangles", 10, 0
good_bye: db "Have a good day", 10, 0

; displays
good_morning: db "Good morning %s. ", 0
output_three_float: db "Thank you. You entered %7.5lf %7.5lf %7.5lf", 10, 0

segment .bss

user_name: resb 64

segment .text
triangles:

	push rbp
	mov rbp, rsp
	push rdi
	push rsi
	push rdx
	push rcx
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push rbx
	pushf

	push qword 0

	; --- WELCOME MESSAGES ---
	mov rax, 0
	mov rdi, welcome_msg
	call printf

	; --- PROMPT USER FOR NAME ---
	push qword 0
	mov rax, 0
	mov rdi, prompt_name
	call printf
	pop rax

	;begin scanf block
	push qword 0
	mov rax, 0
	mov rdi, string_format
	mov rsi, user_name
	call scanf

	mov rax, 0
	mov rdi, good_morning 
	mov rsi, user_name
	call printf

	pop rax

	; --- PROMPT USER FOR NUMBERS ---
	push qword 0
	mov rax, 0
	mov rdi, input3prompt
	call printf
	pop rax

	; begin scanf block
	push qword -1
	push qword -2
	push qword -3
	mov rax, 0
	mov rdi, three_float_format
	mov rsi, rsp
	mov rdx, rsp
	add rdx, 8
	mov rcx, rsp
	add rcx, 16
	call scanf
	movsd xmm15, [rsp]
	movsd xmm14, [rsp+8]
	movsd xmm13, [rsp+16]
	pop rax
	pop rax
	pop rax

	;display numbers
	push qword 99
	mov rax, 3
	mov rdi, output_three_float
	movsd xmm0, xmm15
	movsd xmm1, xmm14
	movsd xmm2, xmm13
	call printf

	;--- CONVERT XMM13 INTO RADIANS ---
	movsd xmm12, [pi]	; set xmm12 to pi
	mov rax, 180.0
	cvtsi2sd xmm11, rax	; xmm11 = 180
	mulsd xmm13, xmm12	; rad * deg
	divsd xmm13, xmm11	; (rad * deg) / 180.0

	;--- CALCULATE PERIMETER ---
	

	pop rax

	; --- EXIT PROGRAM ---
	mov rax, 0
	mov rdi, good_bye
	call printf

	pop rax

	popf
	pop rbx
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	pop rbp

	ret
