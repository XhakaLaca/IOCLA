%include "io.inc"

section .data
    myString: db "Hello, World!",0
    mySecoundString: db "Goodbye World!",0
section .text
global CMAIN
CMAIN:
    mov ecx, 6                 ; N = valoarea registrului ecx
    mov eax, 2
    mov ebx, 1
back:   
    cmp ecx,1
    jl exit
    dec ecx   
    PRINT_STRING myString
    NEWLINE
    jmp back
    ret  
                               ; TODO2.2: afisati "Hello, World!" de N ori
                               ; TODO2.1: afisati "Goodbye, World!"
exit:
    PRINT_STRING mySecoundString
    NEWLINE    
    ret
