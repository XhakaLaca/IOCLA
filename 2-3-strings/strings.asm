%include "io.inc"

section .data
    string db "Lorem ipsum dolor sit amet.", 0
    print_strlen db "strlen: ", 10, 0
    print_occ db "occurences of `i`:", 10, 0

    occurences dd 0
    length dd 0    
    char db 'i'

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    xor eax,eax
    cld
    mov al,0x00
    mov edi, string
    repne scasb
    sub edi, string
    dec edi
    mov [length], edi
    
    cld
    mov ecx, dword [length]             
    mov al, byte [char]           
    mov edi, string
loops: 
    repne scasb   
    inc dword [occurences]
    cmp ecx, 0
    jg loops
    dec dword[occurences]
    ; TODO1: compute the length of a string

    ; TODO1: save the result in at address length

    ; print the result of strlen
    PRINT_STRING print_strlen
    PRINT_UDEC 4, [length]
    NEWLINE

    ; TODO2: compute the number of occurences

    ; TODO2: save the result in at address occurences

    ; print the number of occurences of the char
    PRINT_STRING print_occ
    PRINT_UDEC 4, [occurences]
    NEWLINE

    xor eax, eax
    leave
    ret
