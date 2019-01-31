%include "io.inc"

%define NUM_FIBO 10

section .text
global CMAIN
    xor eax, eax
    xor ebx, ebx
    inc ebx 
    push eax 
    push ebx
foo:
    push ebp
    mov ebp, esp
 
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
  
 
    add eax, ebx
    push eax
CMAIN:
    mov ebp, esp
    mov ecx, NUM_FIBO
FIB: 
    cmp ecx, 0 
    je print
    dec ecx 
    call foo 
    

    sub esp, NUM_FIBO * 4

    mov ecx, NUM_FIBO
print:
    PRINT_UDEC 4, [esp + (ecx - 1) * 4]
    PRINT_STRING " "
    dec ecx
    cmp ecx, 0
    ja print

    mov esp, ebp
    xor eax, eax
    ret
