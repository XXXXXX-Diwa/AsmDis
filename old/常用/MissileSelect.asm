﻿.gba
.open "zm.gba","MSelect.gba",0x8000000

.org 0x800817C
	ldr r0,=8760D40h	;freespace/missile hijack
	mov r15,r0
.pool
.org 0x800815C
	ldr r0,=8760D40h	;power bomb hijack, make the freespace value the same as missile hijack
	mov r15,r0
.pool

.org 0x8760D40
	push r6
	ldr r0,=3001416h	;missile selected
	ldrb r0,[r0]
	mov r6,r0
	ldr r0,=3001380h	;changed input
	ldr r1,=300168Ch	;seems to always be 100h
	ldrh r2,[r0]
	ldrh r0,[r1]
	and r0,r2
	cmp r6,0h		;checks is missile select is on
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
	ldr r0,=80081A6h	;jumps back to setting 0 on selected missiles/PBs
	mov r15,r0
@@On:
	pop r6
	ldr r0,=30013D4h	;Samus' pose
	ldrb r0,[r0]
	cmp r0,11h
	beq @@PowerBombs
	cmp r0,12h
	beq @@PowerBomb
	cmp r0,14h
	beq @@PowerBomb		;checks if in morphball
	ldr r0,=800818Ah	;jumps to code that enables missiles to fire
	mov r15,r0
@@PowerBomb:
	ldr r0,=800816Ah	;jumps to code that enables PBs to fire
	mov r15,r0
.pool
.close
