extern printf   ; includes printf
extern scanf    ; includes scanf 

; include <iostream>

INPUT_LEN equ 64 ;  input length for scanf
                 ; this is the equivalent of writing const int INPUT_LEN = 64;

global hello_world_simple

segment .data

; these are strings. 
; 0 is the termination (null terminator) \0, 10 is a newline \n
string_format: db "%s", 0 ; -> char format_specifier[] = "%s";
prompt_name: db "Please enter your name user: ", 0
exit: db "The program will now return to the driver", 10, 0

; printf("%s", my_string_pointer);

segment .bss

; this is the same as saying char user_name[INPUT_LEN];
; this is just reserving an array of bytes and giving it a identifier
user_name: resb INPUT_LEN

segment .text
hello_world_simple: ; essentially the same as int main() {} <--- enters program

    ; 15 pushes and pops, this stuff is boilerplate. you won't have to learn the meaning
    ; until later on in the course.

    push rbp ; Push memory address of base of previous stack frame onto stack top

    mov rbp, rsp ; Copy value of stack pointer into base pointer, rbp = rsp = both point to stack top
    ; Rbp now holds the address of the new stack frame, i.e "top" of stack
    push rdi ; Backup rdi
    push rsi ; Backup rsi
    push rdx ; Backup rdx
    push rcx ; Backup rcx
    push r8 ; Backup r8
    push r9 ; Backup r9
    push r10 ; Backup r10
    push r11 ; Backup r11
    push r12 ; Backup r12
    push r13 ; Backup r13
    push r14 ; Backup r14
    push r15 ; Backup r15
    push rbx ; Backup rbx
    pushf ; Backup rflags

    ; simple printf block
    mov rax, 0 ; printing 0 floats (xmm registers)
    mov rdi, string_format
    mov rsi, prompt_name
    call printf
	
	; printf("%s", prompt_name);

    ; simple scanf block
    mov rax, 0
    mov rdi, string_format
    mov rsi, user_name
    call scanf
	
	; scanf("%s", user_name);

    ; simple printf block
    mov rax, 0
    mov rdi, string_format
    mov rsi, exit
    call printf

    ; rax = user_name
    ; this is the same as saying 
    ; return user_name in C++
	
	; return user_name;
    mov rax, user_name

    popf ; Restore rflags
    pop rbx ; Restore rbx
    pop r15 ; Restore r15
    pop r14 ; Restore r14
    pop r13 ; Restore r13
    pop r12 ; Restore r12
    pop r11 ; Restore r11
    pop r10 ; Restore r10
    pop r9 ; Restore r9
    pop r8 ; Restore r8
    pop rcx ; Restore rcx
    pop rdx ; Restore rdx
    pop rsi ; Restore rsi
    pop rdi ; Restore rdi

    pop rbp ; Restore rbp

    ret ;  return