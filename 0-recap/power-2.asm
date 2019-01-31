%include "io.inc"

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    xor ecx,ecx
    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power
verify:    
    test eax,ebx
    jg print
back:
    cmp eax,0
    je exit
    shl ebx,1
    jmp verify
print:
    sub eax,ebx
    PRINT_DEC 4,ebx
    NEWLINE
    jmp back
exit:   
    leave
    ret
