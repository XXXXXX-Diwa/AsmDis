.gba
.open "zm.gba","zipline.gba",0x8000000
.definelabel ziplinecheck,0x8760d50
.definelabel ButtonInput,0x0300137C
.definelabel ButtonInputCopy,0x0300137E
.definelabel ChangedButtonInput,0x03001380
.definelabel TurningFlag,0x030013D7
.definelabel SamusDirection,0x030013E2
.definelabel ZiplineStatus,0x03000738
.definelabel SamusPose,0x030013D4


.org	0x0801d3f4
	.word	ziplinecheck

.org	0x0801D3CC
	mov r15,r0


.org	ziplinecheck
	ldr     r0,=ZiplineStatus
    ldrh    r1,[r0]     
    mov     r0,80h      
    lsl     r0,r0,4h       ; Only if carrying Samus
    and     r0,r1       
    cmp     r0,0h       
    beq     Done 

	ldr		r0,=TurningFlag
	ldrb	r0,[r0]             ; only if not turning
	cmp		r0,0h
	bne		Done

	ldr		r0,=SamusPose
	ldrb	r0,[r0]             ; only if not turning pose
	cmp		r0,2Ah
	beq		Done

	ldr		r1,=SamusDirection
	ldrb	r1,[r1]
	mov		r0,30h
	and		r1,r0
	cmp		r1,20h
	beq		@Leftwards
	cmp		r1,10h
	beq		@Rightwards
	b		Done
@Leftwards:
	ldr		r0,=ChangedButtonInput
	ldrb	r0,[r0]
	mov		r1,20h
	and		r0,r1
	cmp		r0,0h
	beq		Done

	ldr		r0,=ZiplineStatus
	ldrh	r0,[r0]
	mov     r1,80h  
	lsl     r1,r1,2h
	and		r1,r0
	sub		r0,r0,r1
	ldr		r1,=ZiplineStatus
	strh	r0,[r1]
	b		Done


@Rightwards:
	ldr		r0,=ChangedButtonInput
	ldrb	r0,[r0]
	mov		r1,10h
	and		r0,r1
	cmp		r0,0h
	beq		Done
	ldr		r0,=ZiplineStatus
	ldrh	r0,[r0]
	mov     r1,80h  
	lsl     r1,r1,2h
	orr		r0,r1
	ldr		r1,=ZiplineStatus
	strh	r0,[r1]
	b		Done


Done:	
	ldr		r0,=030000DCh
	ldrh	r0,[r0]
	ldr		r1,=0801D3CEh
	mov		r15,r1

.pool

.close