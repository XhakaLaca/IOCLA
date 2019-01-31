extern puts
extern printf
extern strlen

%define BAD_ARG_EXIT_CODE -1

section .data
filename: db "./input0.dat", 0
inputlen: dd 2263

fmtstr:            db "Key: %d",0xa, 0
usage:             db "Usage: %s <task-no> (task-no can be 1,2,3,4,5,6)", 10, 0
error_no_file:     db "Error: No input file %s", 10, 0
error_cannot_read: db "Error: Cannot read input file %s", 10, 0

section .text
global main
        
xor_strings:
	; TODO TASK 1    
        xor ebx, ebx 
        xor eax, eax
notdone:
        ; muta un byte in al din string-ul codificat
        mov byte al, [ecx + ebx]
        ; muta un byte in ah din string-ul cheie
        mov byte ah, [edi + ebx]
        ; face xor byte cu byte
        xor al, ah
        ; mut byte-ul inapoi
        mov byte [ecx + ebx], al
        inc ebx
        ; compar sa vad daca este sfarsitul string-ului
        cmp al, 0x00
        ; daca nu continui sa fac xor
        jne notdone
        
        ret

rolling_xor:
	; TODO TASK 2
        xor ebx, ebx
        xor eax, eax
        xor edx, edx
        cld
        ; mut primul byte din string-ul codificat
        mov byte al, [ecx]
        ; mut al doilea byte din string-ul codificat
        mov byte ah, [ecx + 1]
        ; primul byte e deja codificat si il mut inapoi
        mov byte [ecx], al
        ; pentru a decodifica al doilea byte fac xor cu primul
        xor ah, al
        ; salvez in dl byte-ul codificat
        mov dl, [ecx + 1]
        ; mut byte-ul decodificat inapoi in string
        mov byte [ecx + 1], ah
        inc ebx
notdone1:
        ; mut in ah urmatorul byte codificat
        mov byte ah, [ecx + ebx + 1]
        ; compar cu null, sa vad daca e sfarsitul string-ului
        cmp ah, 0x00
        je done1
        ; salvez in al byte-ul codificat
        mov byte al, dl
        ; il decodific
        xor ah, al
        ; citesc din nou byte-ul codificat
        mov byte dl, [ecx + ebx + 1]
        ; il pun in string pe cel decodificat
        mov byte [ecx + ebx + 1], ah
        inc ebx
        jne notdone1
done1:              
        ret

xor_hex_strings:
	; TODO TASK 3
        xor ebx, ebx 
        xor eax, eax
        xor edx, edx
loop_first_string:
        ; cu al citesc partile pare din string
        mov byte al, [ecx + 2 * ebx]
        ; cu dl citesc partile impare din string
        mov byte dl, [ecx + 2 * ebx + 1]
        ; vad daca este sfarsitul stringului
        cmp dl, 0x00
        je first_string_done
        ; scad din ambii registrii 48 
        sub al, 48
        sub dl, 48
        ; compar cu 9 sa vad daca este cifra sau litera
        cmp al, 9
        ; daca e litera sar la modificare
        jg modify_al_first
        ; daca e cifra il shiftez pe al de 4 ori sa elimin primii 4 byte
        ; iar apoi il adun pe dl dupa ce fac modificarile aferente
        jle put_al_first
modify_al_first:
        sub al, 39
put_al_first:
        shl al, 4
identify_dl_first:
        cmp dl, 9
        jle put_dl_first
        je modify_dl_first
modify_dl_first:
        sub dl, 39
put_dl_first:
        add al, dl
        mov byte [ecx + ebx], al
        inc ebx
        jmp loop_first_string        
first_string_done:
        ; null-ul il pun la jumatatea lungimii string-ului initial
        ; intrucat acesta se injumatateste in urma operatiilor efectuate pe el
        mov eax, ebx
        mov ebx, 2
        idiv ebx
        mov byte [ecx + eax], 0x00
        xor ebx, ebx
        xor eax, eax
        xor edx, edx
loop_secound_string:
        ; fac acelasi set de operatii si pe cheie ca pe string-ul pe care doresc sa il
        ; decodific        
        mov byte al, [edi + 2 * ebx]
        mov byte dl, [edi + 2 * ebx + 1]
        cmp dl, 0x00
        je secound_string_done 
        sub al, 48
        sub dl, 48
        cmp al, 9
        jg modify_al_secound
        jle put_al_secound
modify_al_secound:
        sub al, 39
put_al_secound:
        shl al, 4
identify_dl_secound:
        cmp dl, 9
        jle put_dl_secound
        je modify_dl_secound
modify_dl_secound:
        sub dl, 39
put_dl_secound:
        add al, dl
        mov byte [edi + ebx], al
        inc ebx
        jmp loop_secound_string        
secound_string_done:
        mov eax, ebx
        mov ebx, 2
        idiv ebx
        mov byte [edi + eax], 0x00
        xor ebx, ebx
        xor eax, eax
        xor edx, edx
xor_them:
        ; aplic ce am facut la primul exercitiu
        mov byte al, [ecx + ebx]
        mov byte dl, [edi + ebx]
        cmp al, 0x05 
        je finish_it
        xor al, dl
        mov byte [ecx + ebx], al
        inc ebx
        jmp xor_them
finish_it:        
        ret

base32decode:
	; TODO TASK 4
	ret

bruteforce_singlebyte_xor:
	; TODO TASK 5
        ; cheia o retin in al
        xor eax, eax
        xor edx, edx
        mov al, 0x00
        xor ebx, ebx
loop1:
        ; citesc byte cu byte din string-ul pe care il primes
        mov byte dl, [ecx + ebx]
        ; vad daca este sfarsitul string-ului
        cmp dl, 0x00
        ; daca este null atunci il fac pe ebx 0 pentru a incepe din nou citirea
        ; si incrementez cheia
        je reset
        ; aplic xor pe byte si doresc sa vad daca este caracterul 'f'
        ; daca este continui cu urmatorul byte
        xor dl, al
        cmp dl, 102
        je continue1
        inc ebx
        jmp loop1
continue1:
        mov byte dl, [ecx + ebx + 1]
        xor dl, al
        ; dupa ce aplic xor pe byte-ul citit vad daca este caracterul 'o'
        ; daca este atunci continui cu urmatorul byte
        cmp dl, 111
        je continue2
        inc ebx
        jne loop1
continue2:
        mov byte dl, [ecx + ebx + 2]
        xor dl, al
        ; aplic xor si verific daca byte-ul citit este caracterul 'r'
        ; daca este atunci continui cu urmatorul byte
        cmp dl, 114
        je continue3
        inc ebx
        jne loop1
continue3:
        mov byte dl, [ecx + ebx + 3]
        xor dl, al
        ; aplic xor si verific daca byte-ul citit este caracterul 'c'
        ; si continui cu urmatorul byte
        cmp dl, 99
        je continue4
        inc ebx
        jne loop1
continue4:
        mov byte dl, [ecx + ebx + 4]
        xor dl, al
        ; aplic xor si verific daca byte-ul citit este 'e'
        cmp dl, 101
        je loop2
        inc ebx
        jne loop1        
reset:
        xor ebx, ebx
        inc al        
        jmp loop1               
loop2:  
        ; in acest loop dupa ce gasesc cheia fac xor pe tot string-ul
        ; si il modific exact ca la primul exercitiu
        xor edx, edx
        xor ebx, ebx
xor_string:
        mov byte dl, [ecx + ebx]
        cmp dl, 0x00
        je finish
        xor dl, al
        mov byte [ecx + ebx], dl
        inc ebx 
        jmp xor_string
finish:
        ret        

decode_vigenere:
	; TODO TASK 6
        xor ebx, ebx
        xor eax, eax
        xor edx, edx
schimba_cheie_cifre:
        ; pentru acest task, am folosit varianta cu key offset
        mov byte dl, [edi + ebx]
        ; am scazut din intregul string codul ascii al lui 'a'
        sub dl, 97
        cmp dl, -97
        mov byte [edi + ebx], dl
        ; reset_cheie imi face ebx-ul 0 si sare la loop3
        je reset_cheie
        inc ebx
        jmp schimba_cheie_cifre        
loop3:  
        ; citesc un byte daca este mai mare ca 122('z') nu il decodific
        ; daca este mai mic decat 97('a'), iar nu il modific, ci incrementez
        ; contorul, iar daca este 0x00 termin
        mov byte dh, [ecx + eax]
        cmp dh, 0x00
        je finish1
        cmp dh, 97
        jl increment
        cmp dh, 122
        jg increment
        ; citesc un byte din cheie si vad daca este -97, intrucat am scazut din el
        ; codul ascii al lui 'a', daca este atunci fac contorul pentru cheie 0 si sar
        ; din nou il loop
        mov byte dl, [edi + ebx]
        cmp dl, -97
        je reset_cheie
        ; scad din byte-ul citit din string, valoarea cheii si o compar cu 97
        ; daca este mai mica atunci trebuie sa o fac corect
        sub dh, dl
        cmp dh, 97
        jl put_right
        mov byte [ecx + eax], dh
        inc ebx
        inc eax
        jmp loop3
increment:
        inc eax
        jmp loop3
reset_cheie:
        xor ebx, ebx
        jmp loop3
put_right:
        ; pun din nou byte-ul codificat in dh 
        mov byte dh, [ecx + eax] 
local_loop:
        ; il decrementez pe dh pana cand dl este 0
        ; il compar pe dh cu 96, sa stiu daca am sarit de 'a', daca am sarit,
        ; atunci il fac pe dh 'z' si continui sa scad
        dec dh
        dec dl
        cmp dl, 0x00
        je local_loop_done
        cmp dh, 96
        je change_var
        jmp local_loop
local_loop_done:
        ; dupa ce corectez byte-ul il pun in string si incrementez cele doua contoare
        ; apoi sar la loop-ul initial, reiau operatiile pana la finalul string-ului
        mov byte [ecx + eax], dh
        inc eax
        inc ebx                
        jmp loop3
change_var:
        mov dh, 122
        jmp local_loop
finish1:	
        ret

main:
        mov ebp, esp; for correct debugging
        push ebp
        mov ebp, esp
        sub esp, 2300

	; test argc
	mov eax, [ebp + 8]
	cmp eax, 2
	jne exit_bad_arg

	; get task no
	mov ebx, [ebp + 12]
	mov eax, [ebx + 4]
	xor ebx, ebx
	mov bl, [eax]
	sub ebx, '0'
	push ebx

	; verify if task no is in range
	cmp ebx, 1
	jb exit_bad_arg
	cmp ebx, 6
	ja exit_bad_arg

	; create the filename
	lea ecx, [filename + 7]
	add bl, '0'
	mov byte [ecx], bl

	; fd = open("./input{i}.dat", O_RDONLY):
	mov eax, 5
	mov ebx, filename
	xor ecx, ecx
	xor edx, edx
	int 0x80
	cmp eax, 0
	jl exit_no_input

	; read(fd, ebp - 2300, inputlen):
	mov ebx, eax
	mov eax, 3
	lea ecx, [ebp-2300]
	mov edx, [inputlen]
	int 0x80
	cmp eax, 0
	jl exit_cannot_read

	; close(fd):
	mov eax, 6
	int 0x80

	; all input{i}.dat contents are now in ecx (address on stack)
	pop eax
	cmp eax, 1
	je task1
	cmp eax, 2
	je task2
	cmp eax, 3
	je task3
	cmp eax, 4
	je task4
	cmp eax, 5
	je task5
	cmp eax, 6
	je task6
	jmp task_done

task1:
	; TASK 1: Simple XOR between two byte streams

	; TODO TASK 1: find the address for the string and the key
	; TODO TASK 1: call the xor_strings function
        push ecx
        ; caut unde e sfarsitul cheii cu scasb
        mov edi, ecx
        mov al, 0x00
        repne scasb
        pop ecx
        push edi
        push ecx
        ; apelez functia
        call xor_strings
        call puts                   ;print resulting string
        add esp, 8

	jmp task_done

task2:
	; TASK 2: Rolling XOR

	; TODO TASK 2: call the rolling_xor function
        
        push ecx
        call rolling_xor
        call puts
        add esp, 4

        jmp task_done

task3:
	; TASK 3: XORing strings represented as hex strings

	; TODO TASK 1: find the addresses of both strings
	; TODO TASK 1: call the xor_hex_strings function
        ; precum la primul task caut adresa cheii
        push ecx
        mov edi, ecx
        mov al, 0x00
        repne scasb
        pop ecx
        push edi
        push ecx
        ; apoi apelez functia
        call xor_hex_strings
        call puts                   ;print resulting string
        add esp, 8

        jmp task_done

task4:
	; TASK 4: decoding a base32-encoded string

	; TODO TASK 4: call the base32decode function
	
        push ecx
        call puts                    ;print resulting string
        pop ecx
	
        jmp task_done

task5:
	; TASK 5: Find the single-byte key used in a XOR encoding

	; TODO TASK 5: call the bruteforce_singlebyte_xor function
        xor ebx, ebx
        push ecx
        call bruteforce_singlebyte_xor
        ; datorita functiei puts, se modifica valoarea cheii, care se afla in eax
        ; din acest motiv o mut in ebx
        mov ebx, eax                   
        call puts
        pop ecx
        mov eax, ebx
        push eax                    ;eax = key value
        push fmtstr
        call printf                 ;print key value
        add esp, 8

	jmp task_done

task6:
	; TASK 6: decode Vignere cipher

	; TODO TASK 6: find the addresses for the input string and key
	; TODO TASK 6: call the decode_vigenere function

        push ecx
        call strlen
        pop ecx

        add eax, ecx
        inc eax
        
        push eax
        push ecx
        ; caut adresa cheii cu scasb
        mov edi, ecx
        mov al, 0x00
        repne scasb
        pop ecx
        push edi
        push ecx                   ;ecx = address of input string 
        ; apelez functia
        call decode_vigenere
        pop ecx
        add esp, 4

	push ecx
	call puts
	add esp, 4

task_done:
	xor eax, eax
	jmp exit

exit_bad_arg:
	mov ebx, [ebp + 12]
	mov ecx , [ebx]
	push ecx
	push usage
	call printf
	add esp, 8
	jmp exit

exit_no_input:
	push filename
	push error_no_file
	call printf
	add esp, 8
	jmp exit

exit_cannot_read:
	push filename
	push error_cannot_read
	call printf
	add esp, 8
	jmp exit

exit:
	mov esp, ebp
	pop ebp
	ret
