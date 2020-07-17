.gba
.open "zm.gba","icedeath.gba",0x8000000
.definelabel freezekill,0x8760d50

.org 0x0800D330
	ldr		r0,=freezekill
	mov		r15,r0
.pool

.org freezekill
	mov 	r0,30h
	add		r0,r2
	ldrb    r0,[r0]	
    cmp     r0,1h   
    beq     unfreezing
    cmp     r0,0h   
    bne     frozen
	b		notfrozen
unfreezing:
	mov 	r0,1Dh
	add		r0,r2
	ldrb	r0,[r0]

	cmp		r0,64h		; Copy these two lines to exclude another sprite
	beq		notfrozen	; change 64 to ID of sprite to exclude

	cmp		r0,65h		;64&65 are metroids.
	beq		notfrozen


	mov 	r0,30h
	add		r0,r2
	mov 	r1,1h
	strb	r1,[r0]
	push	r2
	mov		r0,r2
	mov 	r1,70h		; 70 is the amount of damage to inflict upon unfreezing
	ldr		r2,=@continue
	add		r2,1h
	mov		r14,r2
	ldr 	r2,=08050424h
	mov 	r15,r2
@continue:
	pop 	r2
	ldr		r1,=3000769h

notfrozen:
	ldr		r0,=0800D338h
	mov		r15,r0

frozen:
	ldr		r0,=0800D368h
	mov		r15,r0

.pool
.close