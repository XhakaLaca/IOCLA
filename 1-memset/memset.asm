%include "io.inc"

extern printf

%DEFINE LENGTH 20

section .data
    string db "Nunc tristique ante maximus, dictum nunc in, ultricies dui.", 0
    char db 'a'

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    mov ecx, LENGTH
    mov al, [char]
    mov edi, string
    rep stosb     
    PRINT_STRING string

    xor eax, eax
    leave
    ret
