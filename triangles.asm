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
results: db "The area of your triangle is %lf square units", 10, "the perimeter is %lf linear units.", 10

segment .bss

user_name: resb 64
perimeter: resq 1
area: resq 1

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
	mov rax, 180
	cvtsi2sd xmm11, rax	; xmm11 = 180
	mulsd xmm13, xmm12	; rad * deg
	divsd xmm13, xmm11	; (rad * deg) / 180.0

	;--- CALCULATE PERIMETER ---
	; first we need to get length of side 3. We only have side 1, side 2, and the angle between them
	; Formula for side 3: sqrt(A^2 + B^2 - 2AB*cos(x)) A = side1(xmm15) B = side2(xmm14)

	; 2AB
	mov rax, 2
	cvtsi2sd xmm12, rax	;xmm12 = 2
	mulsd xmm12, xmm15	;2*A
	mulsd xmm12, xmm14	;(2*A)*B


	;A^2
	movsd xmm11, xmm15	;copy value of xmm15 (A) to xmm11
	mulsd xmm11, xmm11	;multiple xmm11 by itself A^2

	;B^2
	movsd xmm10, xmm14
	mulsd xmm10, xmm10

	; cos(x)
	movsd xmm0, xmm13
	call cos ; xmm0 = cos(x)

	mov rax, -1
	cvtsi2sd xmm9, rax
	mulsd xmm9, xmm12	; -1 * 2AB = -2AB
	mulsd xmm9, xmm0	; xmm9 = -2AB*cos(x)
	addsd xmm9, xmm10	; xmm9 = B^2 - 2AB*cos(x)
	addsd xmm9, xmm11	; xmm9 = A^2 + B^2 - 2AB*cos(x)
	sqrtsd xmm9, xmm9	; xmm9 = sqrt(xmm9)

	; add all 3 sides. xmm15 = side 1, xmm14 = side 2, xmm9 = side 3
	addsd xmm9, xmm15	; xmm9 = xmm9 + xmm15
	addsd xmm9, xmm14	; xmm9 = xmm9 + xmm14

	movsd [perimeter], xmm9

	; --- CALCULATE AREA ---
	; Formula for area:1/2AB*sin(angle)

	movsd xmm0, xmm13
	call sin	; xmm0 = angle. xmm0 = sin(angle)

	;perform formula
	movsd xmm12, xmm0	; copy sin(angle) into xmm12
	mulsd xmm12, xmm15	; A*sin(angle)
	mulsd xmm12, xmm14	; A*B*sin(angle)
	mov rax, 2
	cvtsi2sd xmm11, rax
	divsd xmm12, xmm11	; (A*B*sin(angle))/2
	movsd [area], xmm12	; move area into [area]


	; --- PRINT RESULTS ---
	movsd xmm0, [perimeter]
	movsd xmm1, [area]
	mov rdi, results
	mov rax, 2
	call printf

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
