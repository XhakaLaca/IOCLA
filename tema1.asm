%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .bss
	expr: resb MAX_INPUT_SIZE

section .text
global CMAIN
CMAIN:
        ; for correct debugging
        mov ebp, esp
	push ebp
	mov ebp, esp

	GET_STRING expr, MAX_INPUT_SIZE
        xor ecx, ecx
        xor eax, eax
        xor ebx, ebx
        xor edx, edx
read:        
	; your code goes here        
        mov al, [expr + ecx]
        inc ecx
        
        ; vad daca caracterul este operator
        cmp eax, 42
        je inmultire
        cmp eax, 47
        je impartire
        cmp eax, 43
        je adunare
        
        ; compar sa vad daca e minus
        cmp eax, 45
        je nr_negativ
        
        ; compar sa vad daca este cifra
        cmp eax, 48
        jg concatenare
        je concatenare
        
        ; compar sa vad daca e sfarsitul string-ului
        cmp eax, 0
        je end   
        
        ; compar sa vad daca e spatiu
        cmp eax, 32
        je push_in_stack                                

    ;operatia de adunare
adunare:
        xor eax, eax
        xor ebx, ebx
        pop eax
        pop ebx
        add eax, ebx
        push eax
        xor eax, eax
        xor ebx, ebx
        jmp read
    ; operatie de impartire               
impartire:
        xor eax, eax
        xor ebx, ebx
        pop ebx
        pop eax
        cdq
        idiv ebx
        push eax
        xor eax, eax
        xor ebx, ebx
        xor edx, edx
        jmp read
    ; operatie de inmultire        
inmultire:
        xor eax, eax
        xor ebx, ebx
        pop ebx
        pop eax
        cdq
        imul eax, ebx
        push eax
        xor eax, eax
        xor ebx, ebx
        xor edx, edx
        jmp read
    ; operatie de scadere
scadere:
        xor eax, eax
        xor ebx, ebx
        pop ebx
        pop eax
        sub eax, ebx
        push eax
        xor eax, eax
        xor ebx, ebx
        jmp read
    
    ; concatenez cifrele        
concatenare:
        mov esi, eax
        sub esi, 48
        imul ebx, 10
        add ebx, esi
        jmp read
    
    ; adaug numarul in stiva dupa ce il concatenez
push_in_stack:
        cmp byte[expr + ecx - 2], 48
        jl read
        cmp edx, 1
        je push_in_stack_negative        
        push ebx
        xor ebx, ebx
        jmp read
    
    ; verific daca este numar negativ sau daca este scadere
nr_negativ:        
        cmp byte[expr + ecx], 32
        je scadere
        cmp byte[expr + ecx], 0
        je scadere
        xor edx, edx
        mov edx, 1
        jmp read
        
    ; daca nr este negativ il transform in negativ
push_in_stack_negative:
        not ebx
        inc ebx
        push ebx
        xor edx, edx
        xor ebx, ebx
        jmp read        
end:                        
        xor eax, eax
	pop eax
        PRINT_DEC 4, eax
        pop eax
        ret
