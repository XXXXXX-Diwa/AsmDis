.gba
.open "zm.gba","fastunfreeze.gba",0x8000000
.definelabel fastunfreeze,0x8760d50

.org 0x0800D330
	ldr		r0,=fastunfreeze
	mov		r15,r0
.pool

.org fastunfreeze
	mov 	r0,30h
	add		r0,r2
	ldrb    r0,[r0]	
    cmp     r0,2h   
    bcs     unfreezing
    cmp     r0,0h   
    bne     frozen
	b		notfrozen
unfreezing:
	ldr 	r0,=30000CCh
	ldrb	r0,[r0]
	cmp		r0,4h
	beq		hotroom
	cmp 	r0,06h
	beq		coldroom
	cmp		r0,07h
	beq		coldroom
	b		frozen
coldroom:
	mov 	r0,30h
	add		r0,r2
	ldr		r1,[r0]
	mov 	r0,2h
	and		r0,r1
	cmp		r0,0h
	bne		dontadd
	add 	r1,1h
dontadd:
	mov 	r0,30h
	add		r0,r2
	strb	r1,[r0]
	ldr		r1,=3000769h
	b		frozen
hotroom:
	mov 	r0,30h
	add		r0,r2
	ldr		r1,[r0]
	sub 	r1,1h			; change 1 to 2 to increase thaw speed
	strb	r1,[r0]
	ldr		r1,=3000769h
frozen:
	ldr		r0,=0800D368h
	mov		r15,r0

notfrozen:
	ldr		r0,=0800D338h
	mov		r15,r0



.pool
.close