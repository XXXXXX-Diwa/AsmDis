.gba
.open "fusion.gba","MSelectF.gba",0x8000000


.org 0x80060E8
	bl CheckR
.org 0x80060A0
	bl CheckR



.org 0x80F9A28			;unused fusion sound
CheckR:
	push r6
	ldr r3,=30012F0h
	ldr r0,=300124Ch	;missile selected
	ldrb r0,[r0]
	mov r6,r0
	ldr r0,=30011ECh	;changed input
	ldr r1,=3001450h	;seems to always be 100h
	ldrh r2,[r0]
	ldrh r0,[r1]
	and r0,r2
	cmp r6,0h		;checks if missile select is on
	beq @@TurnOnCheck
	cmp r0,0h		;checks if R is pressed
	bne @@Reset
	b @@On
@@TurnOnCheck:		;checks if R is pressed
	cmp r0,0h
	beq @@Reset
	b @@On
@@Reset:
	pop r6
	ldr r0,=8006116h	;jumps back to setting 0 on selected missiles/PBs
	mov r15,r0
@@On:
	pop r6
	ldr r0,=3001245h	;Samus' pose
	ldrb r0,[r0]
	cmp r0,0Dh
	beq @@PowerBomb
	cmp r0,0Eh
	beq @@PowerBomb
	cmp r0,10h
	beq @@PowerBomb		;checks if in morphball
	ldr r0,=80060F8h	;jumps to code that enables missiles to fire
	mov r15,r0
@@PowerBomb:
	ldr r0,=80060B0h	;jumps to code that enables PBs to fire
	mov r15,r0


.pool
.close
