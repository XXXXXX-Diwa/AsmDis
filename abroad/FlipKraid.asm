.gba
.open "zm.gba","karid.gba",0x8000000

;AUTHOR'S NOTES
;Freespace has to used unfortunately, as every hitbox must be reveresed. As a result,
;some hitboxes values that were positive and 1 byte became negative and 2 bytes. I
;did my best to minimize the space needed.

;SS sprite 3 parts list
;1 = Belly
;2 = front arm (claw thowing arm)
;3 = half of top belly hole
;4 = half top belly hole
;5 = half of middle belly hole
;6 = half of middle belly hole
;7 = half of bottom belly hole
;8 = half of bottom belly hole
;9 = back leg
;A = back arm (swinging arm) 801A36E
;B = front leg

;fixes scroll lock
.org 0x801AE36
	mov		r0,0h
.org 0x801AE46
	sub		r0,r2,r0
.org 0x801AE84
	.word	0x140

;fixes teleportation and invisable wall position
.org 0x8019B16
	sub		r0,0C0h
.org 0x8019B22
	ble 8019B26h

;fixes side to check for arm swing x
.org 0x801A394
	cmp		r3,4h

;flips swinging arm's hitboxes    x
.org 0x8018D2C
	bl		ReverseArmHitbox
.org 0x8018E84
	bl		ReverseArmHitbox

;fixes kraid movement and movement boundaries
.org 0x80196A8
	sub		r0,r0,r2
.org 0x80196AE
	ble		80196C8h
.org 0x80197E4
	sub		r0,r0,r2
.org 0x80197EA
	bge		80197FCh

;fixes BG2 when moving with kraid
.org 0x8019338
	sub		r1,r1,r0
.org 0x8019340
	add		r1,r1,r0
.org 0x8019358
	add		r1,r1,r0
.org 0x8019360
	sub		r1,r1,r0
.org 0x801AD82
	sub		r0,4h
.org 0x801ACE2
	add		r0,4h


;flips kraid head
.org 0x80193F2
	mov		r1,60h	

;flips body sprites
.org 0x8019ED4
	mov		r0,44h
	eor		r0,r1
.org 0x8018426
	bl 		NegateValue

;flips belly spikes	
.org 0x801B0BE
	mov		r0,44h			
	eor		r0,r1
	
;fixes arm position	
.org 0x801139C
	sub		r0,r3,r0
	
	
;fixes movement of samus when on moving belly spike
.org 0x801B1F4
	sub		r0,8h

;adjust kraid spawn	 x
.org 0x8019390
	add		r0,20h
	
;reverses belly spike direction
.org 0x801B1FE
	sub		r1,8h
	
;fixes wall collision detection and destruction
.org 0x801B204
	sub		r0,88h
.org 0x801B22C
	sub		r0,r0,r1
.org 0x801B230
	bgt		801B234h
.org 0x801B382
	add		r5,20h
.org 0x801B3AA
	add		r5,60h
.org 0x801B3D2
	add		r5,0A0h
	
;fix belly spike explosion
.org 0x801B4D2
	sub		r1,50h
	
;fixes belly spike damage hitbox
.org 0x800ECB6
	cmp		r0,r8
	bgt		800ECF6h

;secondary hitboxes	
.org 0x8019F66
	bl		BodyHitbox
	strh	r0,[r2,0Eh]
.org 0x8019FAE
	strh	r1,[r2,10h]
	sub		r1,20h
	strh	r1,[r2,0Eh]
.org 0x801A086
	strh	r0,[r2,0Eh]
	neg		r0,r0
	strh	r0,[r2,10h]
.org 0x801A01A
	strh	r0,[r2,0Eh]
	mov		r0,20h
	strh	r0,[r2,10h]
.org 0x801A034
	.byte 0xD0
.org 0x801A1F2
	bl		LegHitbox
	strh	r0,[r1,0Eh]

;fix stomp "puff" effects
.org 0x801AD26
	add		r1,2Ch
.org 0x801AD48
	sub		r1,0ECh
.org 0x801ADD8
	sub		r1,64h
.org 0x801ADE6
	add		r1,0C8h
.org 0x801AE0C
	sub		r1,r1,r3
.org 0x801AE1E
	sub		r1,r1,r2
	
;fix kraid direction
.org 0x801ACE2

;reverses fingernail direction 	
.org 0x801B616
	b		801B622h

;fix fingernail spawn
.org 0x801A2AE
	sub		r0,80h
.org 0x801A2DC
	sub		r0,0E0h
;fixes head hitbox
.org 0x80193C4
	bl	HeadHitbox
	strh	r0,[r3,10h]
.org 0x80187EC
	bne		80187F0h

;fix belly spike hitboxes 
.org 0x801B0FA
	add		r0,24h
	strh	r0,[r4,0Eh]
	strh	r5,[r4,10h]
	mov		r0,20h
	strh	r0,[r4,0Ch]
.org 0x801B12E
	bl		SpikeHitboxes
.org 0x801B152
	bl		SpikeHitboxes
.org 0x801B15C
	bl		SpikeHitboxes
.org 0x801B166
	bl		SpikeHitboxes
.org 0x801B174
	neg		r0,r0
	bl 		BellyHitboxMain
	


.org 0x8304054
BellyHitboxMain:
	strh	r0,[r1,10h]
	mov		r0,0A0h
	neg		r0,r0
	strh	r0,[r1,0Eh]
	bx		r14
;this uses less freespace than just changing each hitbox for the sprite
SpikeHitboxes:
	neg		r0,r0
	strh	r0,[r1,0Eh]
	ldr		r0,=0x801B19A
	mov		r15,r0
.pool
NegateValue:
	ldrh	r0,[r0,4h]
	neg		r0,r0
	ldrh	r4,[r4,8h]
	bx		r14
HeadHitbox:
	neg		r1,r1
	strh	r1,[r3,0Eh]
	mov		r0,0A0h
	bx		r14
BodyHitbox:
	neg		r0,r0
	strh	r0,[r2,10h]
	mov		r0,0D0h
	neg		r0,r0
	bx		r14
;this uses less freespace than just changing each hitbox for the sprite
ReverseArmHitbox:
	ldr		r1,=3000738h
	cmp		r1,r0
	beq		@@Return			;gross way to prevent it from reversing hitbox unless it needs to be
	ldrh	r0,[r2,10h]
	ldrh	r1,[r2,0Eh]
	neg		r0,r0
	neg		r1,r1
	strh	r0,[r2,0Eh]
	strh	r1,[r2,10h]
@@Return:
	pop		r0
	bx		r0
.pool
LegHitbox:
	neg		r0,r0
	strh	r0,[r1,10h]
	mov		r0,0B0h
	neg		r0,r0
	bx		r14
	
.close