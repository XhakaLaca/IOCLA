%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139 
    mov ebx, 169
    PRINT_DEC 4, eax ; afiseaza prima multime
    NEWLINE
    PRINT_DEC 4, ebx ; afiseaza cea de-a doua multime
    NEWLINE

    ; TODO1: reuniunea a doua multimi
    or eax,ebx
    PRINT_DEC 4,eax
    NEWLINE
    mov eax, 139
    ; TODO2: adaugarea unui element in multime
    or eax, 256
    PRINT_DEC 4,eax
    NEWLINE
    mov eax, 139
    

    ; TODO3: intersectia a doua multimi
    and eax,ebx
    PRINT_DEC 4,eax
    NEWLINE
    mov eax, 139


    ; TODO4: complementul unei multimi
    not eax
    PRINT_DEC 4,eax
    NEWLINE
    mov eax, 139


    ; TODO5: eliminarea unui element
    xor eax,ebx
    PRINT_DEC 4,eax
    NEWLINE
    mov eax, 139    

    ; TODO6: diferenta de multimi EAX-EBX
    


    xor eax, eax
    ret
