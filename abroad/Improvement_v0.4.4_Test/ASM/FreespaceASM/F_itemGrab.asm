;
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
;