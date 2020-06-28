.gba
.open "zm.gba","Speedball.gba",0x8000000


.org 0x80093BE			;routine run when moving in ball form
	bl MorphSpeed
.org 0x8009460
	b 8009464h		;skips a routine related to keeping speed under cap

.org 0x8304054			; Crocomire graphics
MorphSpeed:
	push r14
	mov r4,r0
	bl 80084DCh		;speedbooster timer routine
	ldr r0,=3001380h	;overwritten things
	pop r1
	bx r1
.pool
.close