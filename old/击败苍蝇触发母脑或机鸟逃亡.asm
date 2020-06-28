.gba
.open "zm.gba","Imago.gba",0x8000000
.definelabel SpawnNewPrimarySprite,0x800E31C
.definelabel EventFunctions,0x80608BC


.org 0x8043140
	bl SetTimer
.org 0x804315A
	mov r0,8h		;escape song
	mov r1,40h
.org 0x8043178
	b 804318Ch		;Imago door unlocks at its death


;.org 0x8053978			;uncomment if you want MB timer/comment other 
;	.byte 0x23		;Imago event
.org  0x8053994			;uncomment if you want mecha timer/comment other
	.byte 0x23		;imago event
.org 0x805397E
	cmp r0,1h
	bne 8053986h



.org 0x8304054				; Crocomire graphics
SetTimer:
	push r14
	push r3-r7
	mov r0,11h
	mov r1,22h			;21 for MB escape, 22 for Mecha 
	mov r2,0h			;GFX row
	mov r3,0h
	str r3,[sp,4h]
	ldr r3,=200h
	str r3,[sp]
	ldr r3,=400h
	bl SpawnNewPrimarySprite			;escape message set
	mov r0,1h
	mov r1,23h
	bl EventFunctions			;sets imago killed event, so timer shows right time
	pop r3-r7
	ldr r1,=3000738h		;overwritten instructions
	mov r2,r1
	pop r0
	bx r0
.pool
.close