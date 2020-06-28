.gba
.open "zm.gba","FanBlocks.gba",0x8000000

.definelabel FanLeft,0x37
.definelabel FanRight,0x38
.definelabel FanUp,0x39
.definelabel FanDown,0x3A
.definelabel Fan,0x3B

.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8

;This asm adds clipdata that functions like Samus Returns' Bombs and Fan system. Bombs 
;can be manipulated to move based on fan direction, allowing for puzzles and barriers.

;FanLeft sucks the bomb leftwards
;FanRight sucks the bomb rightwards
;FanUp sucks the bomb upwards
;FanDown sucks the bomb downwards
;Fan detonates bomb

; new code
.org 0x8304280    ; crocomire graphics
CheckBombClip:
	push 	r2,r14
	mov	r4,r0		;projectile slot
	ldrb	r0,[r4,11h]
	cmp 	r0,0		;skip if bomb is spawning
	beq	@@Return	;reset's accel timer for ram slot
	cmp	r0,3h		;skip if bomb detonated
	beq	@@Reset
	ldrh	r0,[r4,8h]	;Bomb Y
	ldrh	r1,[r4,0Ah]	;Bomb X
	lsr     r0,r0,6 
	lsr     r1,r1,6        
	ldr     r2,=RoomWidth
	ldrh    r2,[r2]        
	mul     r2,r0
	add     r2,r2,r1
	lsl     r2,r2,1
	ldr     r0,=DecompClipdata
	add     r1,r0,r2
	ldrh    r0,[r1]		;clipdata the bomb is on
	cmp	r0,FanLeft	;this takes up less space than setting up a loop, so while gross, it's better
	beq	@@FanLeft
	cmp	r0,FanRight
	beq	@@FanRight
	cmp	r0,FanUp
	beq	@@FanUp
	cmp	r0,FanDown
	beq	@@FanDown
	cmp	r0,Fan
	beq	@@Fan
	b	@@Return
.pool
@@FanLeft:
	ldrh	r0,[r4,0Ah]	;bomb X
	bl	FindSlot
	sub	r0,r0,r2
	strh	r0,[r4,0Ah]
	b	@@Return
@@FanRight:
	ldrh	r0,[r4,0Ah]	;bomb X
	bl	FindSlot
	add	r0,r0,r2
	strh	r0,[r4,0Ah]
	b	@@Return
@@FanUp:
	ldrh	r0,[r4,8h]	;bomb Y
	bl	FindSlot
	sub	r0,r0,r2
	strh	r0,[r4,8h]
	b	@@Return
@@FanDown:
	ldrh	r0,[r4,8h]	;bomb Y
	bl	FindSlot
	add	r0,r0,r2
	strh	r0,[r4,8h]
	b	@@Return
@@Fan:	
	mov	r0,1h
	strb	r0,[r4,13h]
	add	r0,1h
	strb	r0,[r4,11h]	;detonate bomb
@@Reset:
	bl	FindSlot
	mov	r0,0h
	strb	r0,[r1]
@@Return:
	pop	r2
	ldrb	r0,[r4,11h]
	pop	r1
	bx	r1


FindSlot:			;this routine is used to give each projectile slot an extra RAM slot for an acceleration timer
	push	r0
	mov	r1,1Ch
	mov	r2,0	
	ldr	r0,=3000A2Ch
@@Continue:
	cmp	r0,r4
	bne	@@Loop
	ldr	r1,=3001610h	;extra ram base (not sure if these are unused in vanilla)
	add	r1,r1,r2	;extra ram address based on projectile slot
	ldrb	r2,[r1]
	cmp	r2,0Ch
	beq	@@Return
	add	r2,1h
	strb	r2,[r1]
	lsr	r2,r2,1h	;slows acceleration
@@Return:
	pop	r0
	bx	r14	

@@Loop:
	add 	r2,1h
	add	r0,r0,r1
	b	@@Continue
.pool


	


; hijack code at start of bomb processing code
.org 0x8051FFA
	bl      CheckBombCLip
	
; fix clipdata collision table
.org 0x85D91FC + FanLeft
	.byte 0,0,0,0		;blowing fan blocks
	.byte 1			;fan block

; fix clipdata behavior table
.org 0x85D92AC + (FanLeft * 2)
	.halfword 0,0,0,0,0	;all blocks
	
.close
