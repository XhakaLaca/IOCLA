%include "io.inc"

%define ARRAY_SIZE    10

section .data
    byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1392849, 12544, 879923, 8799279, 7202277, 971872, 28789292, 17897892, 12988, 8799201
    print_format db "Array sum is ", 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx            ; Store current value in dl; zero entire edx.

add_byte_array_element1:
    mov dl, byte [byte_array + ecx - 1]
    add eax, edx
    loop add_byte_array_element1 ; Decrement ecx, if not zero, add another element.

    PRINT_STRING print_format
    PRINT_UDEC 4, eax
    NEWLINE

    mov ecx, ARRAY_SIZE 
    xor eax, eax
    xor edx, edx
    
add_byte_array_element2:
    mov dx, word [word_array + 2*ecx - 2]
    add eax, edx
    loop add_byte_array_element2 ; Decrement ecx, if not zero, add another element.

    PRINT_STRING print_format
    PRINT_UDEC 4, eax
    NEWLINE

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx            ; Store current value in dl; zero entire edx.

add_byte_array_element3:
    mov edx, dword [dword_array + 4*ecx - 4]
    add eax, edx
    loop add_byte_array_element3 ; Decrement ecx, if not zero, add another element.

    PRINT_STRING print_format
    PRINT_UDEC 4, eax
    NEWLINE
    
    mov ecx, ARRAY_SIZE     
    xor eax, eax            
    xor edx, edx            
    xor ebx, ebx
    xor edi, edi
sum_square:
    mov bl, byte [byte_array + ecx - 1]
    mov al, bl
    mul bl
    add edi, eax
    loop sum_square ; Decrement ecx, if not zero, add another element.

    PRINT_STRING print_format
    PRINT_UDEC 4, edi
    NEWLINE

    
    ; TODO: Compute sum for elements in word_array and dword_array.

    leave
    ret
