.gba
.open "zm.gba","Imago larva.gba",0x8000000
.definelabel SpawnNewPrimarySprite,0x800E31C
.definelabel EventFunctions,0x80608BC


.org 0x8025F42
	bl SetTimer

;The following is the ready-made code XD from CaptGLitch
;.org 0x8053978			;uncomment if you want MB timer/comment other 
	;.byte 0x25		;Ridley event
.org  0x8053994			;uncomment if you want mecha timer/comment other
	.byte 0x20		;Ridley event
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
	bl SpawnNewPrimarySprite	;escape message set
	pop r3-r7
	mov r0,8h			;overwritten instructions/escape theme set 
	mov r1,40h
	pop r2
	bx r2
.pool
.close