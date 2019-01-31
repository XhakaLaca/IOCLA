%include "io.inc"

%define NUM 5

section .text
global CMAIN
CMAIN:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands
    mov ecx, NUM
push_nums:
    sub esp, 4
    mov dword [esp], ecx
    loop push_nums
    sub esp,4
    mov dword[esp], 0
    sub esp,4
    mov dword[esp], "mere"
    sub esp,4
    mov dword[esp], "are "
    sub esp,4
    mov dword[esp], "Ana "
    PRINT_STRING [esp]
    NEWLINE

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    mov eax, ebp
    sub eax, esp
print:
    PRINT_HEX 4, ebpocw casd,mansda,sdna,.dns
    PRINT_STRING ": "
    PRINT_HEX 4, [ebp]
    NEWLINE
    sub eax, 4
 
    sub ebp, 4
    cmp eax, 0
    jge print

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
