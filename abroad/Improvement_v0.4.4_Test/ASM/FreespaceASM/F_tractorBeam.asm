DrawPickup:
	push r2-r6
	ldr r0,=ChargeCounter
	ldrb r0,[r0]
	cmp r0,0x40				; check if fully charged
	bcc @@Return
	ldr r0,=ArmPosition
	ldrh r2,[r0]			; r2 = arm Y position
	ldr r0,=SamusData
	ldrh r1,[r0,0x12]		; r1 = Sam's X position
	ldr r0,=CurrSprite
	ldrh r3,[r0,0x4]		; r3 = sprite X position
	ldrh r4,[r0,0x2]		; r4 = sprite Y position

; get diffX and diffY
@@GetDiffX:
	cmp     r1,r3
	bls     @@Else1				; if spriteX < armX
	sub     r1,r1,r3			; r1 = diffX
	mov     r5,0
	b       @@GetDiffY
@@Else1:
	sub     r1,r3,r1
	mov     r5,1
@@GetDiffY:
	cmp     r2,r4
	bls     @@Else2				; if spriteY < armY
	sub     r2,r2,r4			; r2 = diffY
	mov     r6,0
	b       @@CheckX
@@Else2:
	sub     r2,r4,r2
	mov     r6,1

@@CheckX:
	cmp     r1,4
	bcc     @@CheckY			; skip if diffX < 4
	mov     r3,0				; r3 = factor
	mov     r4,r2				; r4 = orig
@@WhileX:
	cmp     r1,r2
	bcc     @@BreakX			; while diffX >= diffY
	add     r2,r2,r4				; diffY += orig
	add     r3,1					; factor++
	cmp     r3,4
	beq     @@BreakX				; break if factor == 3
	b       @@WhileX
@@BreakX:
	cmp     r3,0
	beq     @@CheckY			; if factor > 0
	ldr     r0,=MoveTable
	lsl     r3,1
	add     r0,r0,r3
	ldrb    r1,[r0]
	ldrb    r2,[r0,1]
	b       @@Write
	
@@CheckY:
	cmp     r2,4
	bcc     @@Return			; skip if diffY < 4
	mov     r3,0				; r5 = factor
	mov     r4,r1				; r6 = orig
@@WhileY:
	cmp     r2,r1
	bcc     @@BreakY			; while diffY >= diffX
	add     r1,r1,r4				; diffX += orig
	add     r3,1					; factor++
	cmp     r3,4
	beq     @@BreakY				; break if factor == 3
	b       @@WhileY
@@BreakY:
	cmp     r3,0
	beq     @@Return			; if factor > 0
	ldr     r0,=MoveTable
	lsl     r3,1
	add     r0,r0,r3
	ldrb    r1,[r0,1]
	ldrb    r2,[r0]
	
@@Write:
	ldr     r0,=CurrSprite
	ldrh    r3,[r0,4]			; r3 = sprite X position
	ldrh    r4,[r0,2]			; r4 = sprite Y position
	cmp     r5,0
	beq     @@PosX
	sub     r3,r3,r1
	b       @@WriteX
@@PosX:
	add     r3,r3,r1
@@WriteX:
	strh    r3,[r0,4]
	cmp     r6,0
	beq     @@PosY
	sub     r4,r4,r2
	b       @@WriteY
@@PosY:
	add     r4,r4,r2
@@WriteY:
	strh    r4,[r0,2]
	
@@Return:
	pop     r2-r6
	; replaced instructions
	ldr     r2,=CurrSprite
	mov     r0,r2
	bx      r14
	.pool
	
MoveTable:
	.byte 0,0
	.byte 3,3		; 1:1
	.byte 3,2		; 2:1
	.byte 4,1		; 3:1
	.byte 4,0		; 4:1