.gba
.open "zm.gba","SM_ItemGrab.gba",0x8000000

.org 801b876h
    nop
    nop	
.org 801b8b0h
    nop
    nop
	
;This version enables UnknownItems, and thus has most of Biospark's Unknown Item enabling code in here
.org 0x801BAF8
	bl 0x804F670	;refreshes beam GFX (thanks biospark)
	b 0x801BB00	;prevents going to status screen when getting an item
.org 0x8013176
	bl MorphBall
.org 0x8013B2A
	bl SpeedBooster
.org 0x8013B42
	bl HiJump
.org 0x8013B62
	bl ScrewAttack
.org 0x8013B82
	bl Varia
.org 0x8013BBA
	bl Gravity
.org 0x80133B4
	bl Grip
.org 0x8013BA2
	bl SpaceJump
.org 0x8013ACA
	bl LongBeam
.org 0x8013AE2
	bl IceBeam
.org 0x8013AFA
	bl WaveBeam
.org 0x8013BD2
	bl PlasmaBeam
.org 0x801365A
	bl ChargeBeam	
.org 0x8013B12
	bl Bombs	
;-----
; All
;-----
.org 0x801B886			; Play correct jingle
	mov r0,0x37
.org 0x8071120			; Play correct sound
	.halfword 0x01F7	; 8071118 ldr r0,=1F7h

	
;--------
; Plasma
;--------
.org 0x807057E			; Show non-garbled text
	b 0x8070584
.org 0x8071944			; Display proper description text
	mov r3,0x4
	b 0x8071A32
;---------
; Gravity
;---------
.org 0x80706EC			; Show non-garbled text
	b 0x80706F2
.org 0x80719BC			; Display proper description text
	mov r3,0xA
	b 0x8071A32
.org 0x800B4A0			; Load proper palette
	.halfword 0x480F	; ldr r0,=0x3001530
	ldrb r2,[r0,0xF]
	mov r0,0x20
	and r0,r2
	cmp r0,0
	beq 0x800B554
	b 0x800B4B0
;------------
; Space Jump
;------------
.org 0x807085A			; Show non-garbled text
	b 0x8070860
.org 0x8071A24			; Display proper description text
	mov r3,0x10

;------
; Text
;------

;04 PLASMA BEAM ¥×¥é¥º¥Þ¥Ó©`¥à
;0A GRAVITY SUIT ¥°¥é¥Ó¥Æ¥£¥¹©`¥Ä
;10 SPACE JUMP ¥¹¥Ú©`¥¹¥¸¥ã¥ó¥×

.org 0x8441F96			; ¥×¥é¥º¥Þ¥Ó©`¥à
	.halfword 0x8052,0x8105,0x1D1,0x197,0x1DD,0x18F,0x1CB,0x150,0x191,0xFE00,0x806E,0xFF00

.org 0x8441FE0			; ¥°¥é¥Ó¥Æ¥£¥¹©`¥Ä
	.halfword 0x804E,0x8105,0x1D8,0x197,0x1CB,0x183,0x148,0x15D,0x150,0x182,0xFE00,0x806E,0xFF00
	
.org 0x844206A			; ¥¹¥Ú©`¥¹¥¸¥ã¥ó¥×
	.halfword 0x804E,0x8105,0x15D,0x1D2,0x150,0x15D,0x1DC,0x14C,0x19D,0x1D1,0xFE00,0x806E,0xFF00
	
.org 0x844284C			; Plasma Beam
	.halfword 0x804E,0x8105,0x90,0xCC,0xC1,0xD3,0xCD,0xC1,0x40,0x82,0xC5,0xC1,0xCD,0xFE00,0x806E,0xFF00
	
.org 0x844289E			; Gravity Suit
	.halfword 0x8050,0x8105,0x87,0xD2,0xC1,0xD6,0xC9,0xD4,0xD9,0x40,0x93,0xD5,0xC9,0xD4,0xFE00,0x806E,0xFF00
	
.org 0x844293C			; Space Jump
	.halfword 0x804E,0x8105,0x93,0xD0,0xC1,0xC3,0xC5,0x40,0x8A,0xD5,0xCD,0xD0,0xFE00,0x806E,0xFF00

.org 0x8043DF0 ; Croco AI, Unused
MorphBall:
	mov r0,40h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh]
	mov r0,r12
	ldrh r3,[r0,2h]
	bx r14
SpeedBooster:
	mov r0,2h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh] 
	mov r0,1h
	mov r1,0Bh
	bx r14
Hijump:
	mov r0,1h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh] 
	mov r0,1h
	mov r1,15h
	bx r14
ScrewAttack:
	mov r0,8h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh] 
	mov r0,1h
	mov r1,12h
	bx r14
Varia:
	mov r0,10h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh] 
	mov r0,1h
	mov r1,13h
	bx r14
Gravity:
	mov r0,20h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh] 
	mov r0,1h
	mov r1,17h
	strb r0,[r2,12h]
	bx r14
Grip:
	mov r0,80h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh] 
	mov r0,1h
	mov r1,10h
	bx r14
SpaceJump:
	mov r0,4h
	ldrb r1,[r2,0Fh]
	eor r0,r1
	strb r0,[r2,0Fh] 
	mov r0,1h
	mov r1,16h
	bx r14
LongBeam:
	mov r0,1h
	ldrb r1,[r2,0Dh]
	eor r0,r1
	strb r0,[r2,0Dh]
	mov r0,1h
	mov r1,8h
	bx r14
IceBeam:
	mov r0,2h
	ldrb r1,[r2,0Dh]
	add r0,r0,r1
	strb r0,[r2,0Dh]
	mov r0,1h
	mov r1,0Ah
	bx r14
WaveBeam:
	mov r0,4h
	ldrb r1,[r2,0Dh]
	eor r0,r1
	strb r0,[r2,0Dh]
	mov r0,1h
	mov r1,0Eh
	bx r14
PlasmaBeam:
	mov r0,8h
	ldrb r1,[r2,0Dh]
	eor r0,r1
	strb r0,[r2,0Dh]
	mov r0,1h
	mov r1,18h
	bx r14
ChargeBeam:
	mov r0,10h
	ldrb r1,[r2,0Dh]
	eor r0,r1
	strb r0,[r2,0Dh]
	mov r0,1h
	mov r1,14h
	bx r14
Bombs:
	mov r0,80h
	ldrb r1,[r2,0Dh]
	eor r0,r1
	strb r0,[r2,0Dh]
	mov r0,1h
	mov r1,9h
	bx r14

.pool
.close