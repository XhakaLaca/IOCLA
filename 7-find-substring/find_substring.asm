%include "io.inc"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCBB", 0
substring: db "BABC", 0

source_length: resd 0
substr_length: dd 4

print_format: db "Substring found at index: ", 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    ;cld
    ;mov al,0x00
    ;mov edi, source_text
    ;repne scasb
    ;sub edi, source_text
    ;dec edi
    ;mov dword[source_length], edi
 
    ;cld
    ;mov al,0x00
    ;mov edi, substring
    ;repne scasb
    ;sub edi, substring
    ;dec edi
    ;mov dword[substr_length], edi
    cld
    mov edi, source_text
    mov esi, substring
    repne cmpsb
    PRINT_UDEC 4,edi
    ;xor eax,eax
    ;mov al, byte[substring]
    ;mov ebx, source_text
    ;xor ecx,ecx
    ;xor edx,edx
;back:
    ;cmp byte[ebx + ecx], 0x00
    ;je print
    ;cmp byte[ebx + ecx],al
    ;je check_substr
;not_equal:
    ;inc ecx
    ;jmp back
;check_substr:
    ;cmp byte[ebx + ecx + 1], 65
    ;jne not_equal
    ;cmp byte[ebx + ecx + 2], 66
    ;jne not_equal
    ;cmp byte[ebx + ecx + 3], 67
    ;jne not_equal
    ;inc edx
    ;add ecx,1
    ;jmp back 
    ; TODO: Print the start indices for all occurrences of the substring in source_text
;print:
    ;PRINT_DEC 4, edx
    leave
    ret
