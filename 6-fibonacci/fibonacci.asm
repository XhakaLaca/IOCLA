%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, 9       ; vrem sa aflam al N-lea numar; N = 7
    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)
    mov ebx,0
    mov ecx,1
    xor edx,edx 
    xor edi,edi
back:    
    cmp eax,2 
    je exit
    add edx,ebx
    add edx,ecx
    mov ebx,ecx
    mov ecx,edx
    mov edi,edx
    xor edx,edx
    dec eax
    jmp back
exit: 
    PRINT_DEC 4,edi  
    ret