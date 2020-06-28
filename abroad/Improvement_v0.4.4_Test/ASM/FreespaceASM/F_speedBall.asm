MorphSpeed:
	push r14
    mov r4,r0
    bl 80084DCh        ;speedbooster timer routine
    ldr r0,=3001380h    ;overwritten things
    pop r1
    bx r1