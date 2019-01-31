%include "io.inc"

section .data

%define ARRAY_LEN 7

    input dd 122, 184, 199, 242, 263, 845, 911
    output times ARRAY_LEN dd 0

section .text
global CMAIN
CMAIN:

    ; TODO push the elements of the array on the stack
    xor ecx, ecx
    push ARRAY_LEN
    pop ecx
loops1:
    push dword[input + 4*ecx - 4]
    loop loops1
    ; TODO retrieve the elements (pop) from the stack into the output array
    push ARRAY_LEN
    pop ecx
loops2:
    pop dword[output + 4*ecx - 4]
    loop loops2
    PRINT_STRING "Reversed array:"
    NEWLINE
    xor ecx, ecx
print_array:
    PRINT_UDEC 4, [output + 4 * ecx]
    NEWLINE
    inc ecx
    cmp ecx, ARRAY_LEN
    jb print_array

    xor eax, eax
    ret
