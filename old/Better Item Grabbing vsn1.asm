.gba
.open "zm.gba","SM_ItemGrab.gba",0x8000000

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
	bl ChargeBeam
.org 0x801365A
	bl PlasmaBeam	
.org 0x8013B12
	bl Bombs	

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