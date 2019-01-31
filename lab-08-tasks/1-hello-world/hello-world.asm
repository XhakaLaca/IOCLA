%include "io.inc"
extern puts
extern printf
section .data
    msg db 'Hello, world!', 10, 0

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp

    push msg
    call printf
    add esp, 4

    leave
    ret
