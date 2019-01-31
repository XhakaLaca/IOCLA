.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    // initialization
    mov r0, #10           // n
    and r1, r1, #0        // sum
    mov r2, #0          // current number

    // TODO Compute sum of squares; place result in r1
back:    
    ADD r2,r2,#1
    MUL r10,r2,r2
    ADD r1,r1,r10
    cmp r2,r0
    bl back
    mov r1,r10
    // print result
    ldr r0, =output
    bl printf

    // epilogue
    sub sp, r11, #0
    pop {r11, pc}

.data
output:
  .asciz "%d\n"
