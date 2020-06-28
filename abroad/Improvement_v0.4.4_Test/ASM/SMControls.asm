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