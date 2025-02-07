;--------------------------------------------------------------------
; File: myfile.asm
;
; This is a single-file assembly program for 64-bit Linux using NASM.
; It prints "Hello, world!" to the screen.
;
; BUILD AND RUN PROCEDURE:
;
; 1) ASSEMBLE:
;       nasm -f elf64 myfile.asm -o myfile.o
;    Explanation:
;       - "nasm" is the Netwide Assembler.
;       - "-f elf64" tells NASM to produce a 64-bit ELF object file (myfile.o).
;       - "myfile.asm" is our source.
;       - "-o myfile.o" is the output object file name.
;
; 2) LINK:
;       ld myfile.o -o myfile
;    Explanation:
;       - "ld" is the GNU linker.
;       - "myfile.o" is the object file from step 1.
;       - "-o myfile" creates an executable named "myfile".
;
; 3) RUN:
;       ./myfile
;    Explanation:
;       - "./myfile" executes the newly created program.
;       - You should see "Hello, world!" printed to the terminal.
;
;--------------------------------------------------------------------

section .data
    msg db "Hello, world!", 0x0A  ; The string we want to print, ending with a newline
    len equ $ - msg               ; Calculate the length of 'msg'

section .text
    global _start                 ; Export the entry point for the linker

_start:
    ;----------------------------------------------------------------
    ; sys_write
    ;   rax = 1   (write syscall number on Linux)
    ;   rdi = 1   (file descriptor: 1 = stdout)
    ;   rsi = address of the message (msg)
    ;   rdx = length of the message (len)
    ;----------------------------------------------------------------
    mov rax, 1          ; system call: sys_write
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, msg        ; message address
    mov rdx, len        ; message length
    syscall

    ;----------------------------------------------------------------
    ; sys_exit
    ;   rax = 60  (exit syscall number on Linux)
    ;   rdi = 0   (exit code: 0 = success)
    ;----------------------------------------------------------------
    mov rax, 60         ; system call: sys_exit
    xor rdi, rdi        ; exit code 0
    syscall