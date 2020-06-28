.gba
.open "zm.gba","SMControls.gba",0x8000000



;|
;|ANGLE RELATED
;|


.org 0x80079AC		
	bl AngleCheck
	ldrh r0,[r0]		;checks for R
.org 0x8007AD0
	cmp r7,0h		
	beq 8007AE0h		;only true if L was pressed
	b 8007ADAh
.org 0x800C58E
	bl RLCheck
.org 0x8007C5C
	bl RLCheck


;|
;|WEAPON SELECT RELATED
;|



.org 0x8008086
	mov r6,0h
	ldr r0,=3001380h	;changed input
	mov r1,4h
	ldrh r0,[r0]
	and r0,r1
	cmp r0,0h	
	beq 80080BAh
	ldrb r0,[r4,2h]		;checks if PBs are selected
	cmp r0,4h
	beq @@Off
	bl SwitchWeapons
	cmp r0,1h
	bne 80080B4h
@@Off:
	mov r0,0h
	mov r1,8h
	strb r0,[r4,2h]
	strb r1,[r4,3h]		;unarms all ammo based weapons
	cmp r2,3h		;true if all weapons are out of ammo
	beq 80080BAh		;skips switch weapon sound
	b 80080B4h
.pool

.org 0x800817C
	ldrb r0,[r4,3h]		;skips old routine to arm missiles
	cmp r0,8h
	beq 80081A6h
	b 800818Ah

.org 0x800815C
	ldrb r0,[r4,3h]		;skips old routine to arm PowerBombs
	cmp r0,8h
	beq 80081A6h
	b 800818Ah

.org 0x80081B8
	nop			

.org 0x80081B2
	b 80081BAh		;stops a bug with missile armed SFX

.org 0x8053698			;following two changes affect missile HUD
	.halfword 0x04C8	;83304C8
.org 0x8053656
	nop


.org 0x80537E8			;following 5 changes affect Super HUD GFX
	.byte 0x48		;8330648
.org 0x80538CC
	.byte 0x48		;8330648
.org 0x80537DC
	.byte 0x0
.org 0x805388A
	.byte 0x0
.org 0x8053879
	.byte 0x0E0

.org 0x80536AC			;following 5 changes affect PB HUD GFX
	.halfword 0x07C8	;83307C8
.org 0x80537B0
	.halfword 0x07C8	;83307C8
.org 0x805368A
	.byte 0x0
.org 0x8053770
	.byte 0x0
.org 0x805375F
	.byte 0x0E0


;|
;|ANGLE RELATED
;|


.org 0x8304054			; Crocomire graphics
AngleCheck:
	ldrh r1,[r2]		;button input
	ldrb r0,[r4]
	cmp r0,1h		;checks if Samus is standing still
	bne @@LCheck
	ldr r0,=300h		;only checked if Samus is idle 	
	mov r7,r0		;checks L + R
	and r0,r1
	cmp r0,r7
	beq @@NoAngle
@@Lcheck:
	ldr r0,=200h		;L
	and r1,r0
	mov r7,r1		;used for a rountine later 
	cmp r1,r0
	beq @@Lpressed
	ldr r0,=300168Ch
	ldrh r1,[r2]
	bx r14
@@LPressed:
	ldr r0,=80079BAh
	mov r15,r0
@@NoAngle:
	ldr r0,=8007AFCh	;makes the arm cannon not angled if R & L pressed is true
	mov r15,r0
.pool

RLCheck:
	push r4	
	ldr r0,=300h		;checks if L + R is pressed
	mov r4,r1
	and r1,r0
	cmp r1,r0
	bne @@Return
	pop r4
	ldr r0,=800C593h	;used to check where the code was run from
	mov r1,r14
	cmp r0,r1
	beq @@C58E_Return
	ldr r0,=8007C82h	
	mov r15,r0
@@C58E_Return:
	ldr r0,=800C59Ch
	mov r15,r0
@@Return:
	mov r0,40h		;return if R + L isn't pressed
	and r0,r4
	pop r4
	bx r14



SwitchWeapons:
	mov r5,r2
	mov r2,0h		;used to check to not play switch sound
	cmp r0,0h
	beq @@Missile
	cmp r0,1h
	beq @@Super
	b @@PowerBomb		;checks which item to arm
@@Missile:
	ldrh r0,[r5,8h]
	cmp r0,0h		;checks if missile count is 0
	beq @@PreSuper
	mov r0,0h
	mov r1,1h
	strb r1,[r4,2h]
	strb r0,[r4,3h]
	mov r0,0h		;turns on missiles
	b @@Return
@@PreSuper:
	add r2,1h
@@Super:
	ldrb r0,[r5,0Ah]
	cmp r0,0h		;checks if super missile count is 0	
	beq @@PrePB
	mov r0,1h
	mov r1,2h
	strb r1,[r4,2h]
	strb r0,[r4,3h]
	mov r0,0h		;turns on Supers
	b @@Return
@@PrePB:
	add r2,1h
@@PowerBomb:
	ldrb r0,[r5,0Bh]
	cmp r0,0h		;checks if PB count is 0	
	beq @@Off
	mov r0,2h
	mov r1,4h
	strb r1,[r4,2h]
	strb r0,[r4,3h]
	mov r0,0h		;turns on PBs
	b @@Return
@@Off:
	add r2,1h
	mov r0,1h		;return value to unarm all ammo based weapons
@@Return:
	bx r14



.pool
.close