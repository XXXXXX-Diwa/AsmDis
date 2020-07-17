.gba
.open "zm.gba","HighGravity.gba",0x8000000

.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel underwaterflag,0x30015e3
.definelabel setunderwater,0x8760d50


.org 0x08007684
	ldr 	r0,=setunderwater
	mov		r15,r0
.pool

.org	setunderwater
	ldr		r1,=030000CCh
	ldrb	r1,[r1]
	cmp		r1,09h             ; Check Room Effect
	bne 	Done

LoadProjectile:
	ldr 	r1,=03000A2Ch
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	bl		ProjectilesFall
	b		Done
ProjectilesFall:
	ldrb	r0,[r1]
	cmp		r0,0h
	beq		@@endofloop
	ldrb 	r0,[r1,0fh]
	cmp		r0,0dh
	beq		@@fall
	cmp		r0,0ch
	bne		@@endofloop
@@fall:
	ldrh	r0,[r1,08h]
	ldrb	r2,[r1,13h]
	cmp		r2,6h
	bls		@@endofloop
	add		r0,r2
	lsl		r2,1h
	add		r0,r2
	strh	r0,[r1,08h]

@@endofloop:
	mov		r0,1ch
	add		r1,r0
	bx		r14

Done:
	ldr		r1,=030000CCh
	ldrb	r1,[r1]
	cmp		r1,09h              ;check room effect
	bne 	noeffect


	ldr 	r0,=0300153Fh
	mov 	r2,20h
	ldrb	r0,[r0]
	and		r0,r2			;check gravity suit
	cmp		r0,0h
	bne		noeffect
	cmp		r5,0h
	bne		noeffect		;check in-air
	mov		r5,1h

noeffect:
	mov     r0,r4   
    add     r0,5Bh  
    strb    r5,[r0] 
    cmp     r5,0h   
    beq     notunderwater
	ldr		r2,=0800768Eh
	ldr 	r0,=underwaterflag
	mov		r15,r2
notunderwater:
	ldr		r0,=80076D0h
	mov 	r15,r0

.pool





.close