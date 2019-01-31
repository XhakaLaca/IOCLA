%include "io.inc"

struc stud_struct
    name: resb 32
    surname: resb 32
    age: resb 1
    group: resb 8
    gender: resb 1
    birth_year: resw 1
    id: resb 16
endstruc

section .data

sample_student:
    istruc stud_struct
        at name, db 'Andrei', 0
        at surname, db 'Voinea', 0
        at age, db 21
        at group, db '321CA', 0
        at gender, db 1
        at birth_year, dw 1994
        at id, db 0
    iend

print_format db "ID:", 0

section .text
global CMAIN

CMAIN:
    push ebp
    mov ebp, esp
    xor eax,eax
    
    cld
    lea esi,[sample_student + name]
    lea edi,[sample_student + id] 
    mov ecx,3
    rep movsb
    cld
    lea esi,[sample_student + surname]
    lea edi,[sample_student + id + 3] 
    mov ecx,3
    rep movsb
    mov byte [sample_student + id + 6], '-'
    cld
    lea esi,[sample_student + group]
    lea edi,[sample_student + id + 7] 
    mov ecx,5
    rep movsb
    mov byte [sample_student + id + 13], 0x00
    
      ; TODO: store in a register the address of the sample_student struct

    ; TODO: copy the first 3 bytes from the name field to id using movsb

    ; TODO: copy the first 3 bytes from the surname field to id using movsb

    ; TODO: insert `-`

    ; TODO: copy the bytes from field group to id using movsb

    ; print the new ID added
    PRINT_STRING print_format
    PRINT_STRING [sample_student + id]
    
    leave
    ret