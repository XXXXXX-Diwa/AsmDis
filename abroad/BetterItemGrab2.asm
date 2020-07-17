.gba
.open "zm.gba","SM_ItemGrab.gba",0x8000000

;additional options
;.org 0x801B8CC          ; Play sound routine for abilities (Prevents music from cutting off)
;   bl PlaySound
;.org 0x801B886          ; sound for unknown items
;   mov r0,0x3A   
;.org 0x801B898          ; sound for abilities
;    mov r0,0x3A
.org 0x801B958			;time before an ability message can be closed
	mov		r0,64h
.org 0x801B962			;time before an expansion messages can be closed
	mov		r0,64h


.org 0x801BAF0
	bl 		0x804F670	;refreshes beam GFX (thanks biospark)	
	b 		0x801BB00		;prevents going to status screen when getting an item
.org 0x8013172
	bl	EquipmentGet		;MorphBall
.org 0x8013B26
	bl	EquipmentGet		;SpeedBooster
.org 0x8013B3E
	bl	EquipmentGet		;HiJump
.org 0x8013B5E
	bl 	EquipmentGet		;ScrewAttack
.org 0x8013B7E
	bl EquipmentGet			;Varia
.org 0x8013BB6
	bl EquipmentGet			;Gravity
.org 0x80133B0
	bl EquipmentGet			;Grip
.org 0x8013B9E
	bl 	EquipmentGet		;SpaceJump
.org 0x8013AC6
	bl BeamGet				;LongBeam
.org 0x8013ADE
	bl BeamGet				;IceBeam
.org 0x8013AF6
	bl BeamGet				;WaveBeam
.org 0x8013BCE
	bl BeamGet				;PlasmaBeam
.org 0x8013656
	ldrb	r1,[r2,0Ch]
	mov		r0,10h
	bl BeamGet				;ChargeBeam	
.org 0x8013B0E
	bl BeamGet				;Bombs	

.org 0x8043DF0 ; Croco AI, Unused
EquipmentGet:
	orr		r1,r0
	strb	r1,[r2,0Eh]
	ldrb	r1,[r2,0Fh]
;uncomment if not using Obtain Unknown Items
;	mov		r3,24h		;checks for space jump or grav and prevents their activation
;	and		r3,r1
;	cmp		r3,0h
;	bne		@@Return
	orr		r0,r1
	strb	r0,[r2,0Fh]
@@Return:
	bx		r14
	
BeamGet:
	orr		r1,r0
	strb	r1,[r2,0Ch]
	ldrb	r1,[r2,0Dh]
;uncomment if not using Obtain Unknown Items
;	mov		r3,8h		;checks for plasma and prevents its activation
;	and		r3,r1
;	cmp		r3,0h
;	bne		@@Return
	orr		r0,r1
	strb	r0,[r2,0Dh]
@@Return:
	bx		r14
	
.close