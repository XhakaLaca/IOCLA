%include "io.inc"

section .text
global CMAIN
CMAIN:
    ; cele doua numere se gasesc in eax si ebx
    mov eax, 124
    mov ebx, 21
    mov ebp, esp
    ; TODO: aflati maximul folosind doar o instructiune de salt si push/pop
    cmp eax, ebx
    jg loops
    PRINT_DEC 4,eax
    NEWLINE
    ret
loops:
    push ebx
    pop eax
    PRINT_STRING "Stiva"
    PRINT_DEC 4, eax ; afiseaza minimul
    NEWLINE

    ret
