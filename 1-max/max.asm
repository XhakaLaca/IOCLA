%include "io.inc"

section .text
global CMAIN
CMAIN:
    ; cele doua numere se gasesc in eax si ebx
    mov eax, 13
    mov ebx, 10 
    cmp eax, ebx
    jg toPush
    push ebx
    jmp exit
    ; TODO: aflati maximul folosind doar o instructiune de salt si push/pop
toPush:
    push eax 
exit:
    pop eax
    PRINT_DEC 4, eax ; afiseaza maximul
    NEWLINE

    ret
