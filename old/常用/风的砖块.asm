.gba
.open "zm.gba","WindyBlocks.gba",0x8000000

.definelabel Air,0x00
.definelabel RightGustClip,0x91
.definelabel LeftGustClip,0x92

.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8

; new code
.org 0x8304054    ; crocomire graphics



CheckTouchingClip:
	push    r14
	push    r4-r6
	ldr     r1,=SamusData
	ldrh    r2,[r1,0x12]   ; r2 = x position
	ldrh    r3,[r1,0x14]   ; r3 = y position
	ldr     r1,=SamusHitbox
	mov	r0,0
	ldsh    r4,[r1,r0]     ; r4 = left hitbox
	ldrh    r5,[r1,2]      ; r5 = right hitbox
	mov     r0,4
	ldsh    r6,[r1,r0]     ; r6 = top hitbox
	add     r4,r4,r2       ; r4 = left-most position
	add     r5,r5,r2       ; r5 = right-most position
	add     r6,r6,r3       ; r6 = top-most position
	lsr     r3,r3,6        ; r3 = bottom block
	lsr     r4,r4,6        ; r4 = left block
	lsr     r5,r5,6        ; r5 = right block
	lsr     r6,r6,6        ; r6 = top block
	ldr     r2,=RoomWidth
	ldrh    r2,[r2]        ; r2 = room width
@@CheckLeftSide:
	mov     r1,r2
	mul     r1,r6
	add     r1,r1,r4
	lsl     r1,r1,1
	ldr     r0,=DecompClipdata
	add     r1,r0,r1
	ldrh    r0,[r1]
	cmp		r0,Air
	beq		@@Reset
	cmp     r0,RightGustClip
	beq     @@TouchingRight
	cmp		r0,LeftGustClip
	beq		@@TouchingLeft
	cmp     r4,r5          ; check if horizontal blocks are same
	beq     @@Loop
; check block to right
	add     r0,r1,2
	ldrh    r0,[r0]
	cmp		r0,Air
	beq		@@Reset
	cmp     r0,RightGustClip
	beq     @@TouchingRight
	cmp		r0,LeftGustClip
	beq		@@TouchingLeft

@@Loop:
	cmp     r6,r3          ; check if lowest block checked
	bcs     @@Reset
	add     r6,1           ; add 1 to y block
	b       @@CheckLeftSide
	
@@TouchingRight:
	ldr 	r1,=300152Ch
	ldrb	r0,[r1]			;Load timer
	ldrb	r3,[r1]			;Load timer
	cmp		r0,02Ah			;Check if max increment
	bgt		@@NoIncrementRight
	add		r0,1h			;Increment timer by 1
	strb	r0,[r1]			;Store timer
		
@@NoIncrementRight:	
	ldr		r1,=SamusData	;Load SamusData
	ldrh	r2,[r1,12h]
	lsr    	r0,r0,1h
	add		r2,r0,r2
	strh	r2,[r1,12h]		;Store x position
	
	ldr		r1,=30013E2h	;Load direction
	ldrb	r2,[r1]
	cmp		r2,10h			;Check if direction is rightward
	beq		@@Done			;If true, skip speedboost checks
	
	ldr		r1,=30013D9h	;Load Speedboost flag
	ldrb	r2,[r1]
	mov		r2,0h			;Set flag to 0
	strb	r2,[r1]			;Store flag
	
	ldr		r1,=30013D4h
	ldrb	r2,[r1]
	cmp		r2,22h			;Check for shinespark
	beq		@@AntiSpeedRight
	cmp		r2,26h			;Check for ballspark
	beq		@@AntiSpeedRight
	cmp		r3,028h			;Check again for max increment
	bgt		@@AntiSpeedRight
	b		@@Done
	
@@AntiSpeedRight:
	mov		r0,07h			;Set pose to 'skidding'
	strb	r0,[r1]			;Store pose and cancel shinespark
	b		@@Done

@@TouchingLeft:
	ldr 	r1,=300152Ch
	ldrb	r0,[r1]			;Load timer
	ldrb	r3,[r1]			;Load timer
	cmp		r0,02Ah			;Check if max increment
	bgt		@@NoIncrementLeft
	add		r0,1h			;Increment timer by 1
	strb	r0,[r1]			;Store timer

@@NoIncrementLeft:	
	ldr		r1,=30013E2h	;Load direction
	ldrb	r2,[r1]
	cmp		r2,20h			;Check if direction is rightward
	beq		@@Done			;If true, skip speedboost checks

	ldr		r1,=30013D9h	;Load Speedboost flag
	ldrb	r2,[r1]
	mov		r2,0h			;Set flag to 0
	strb	r2,[r1]			;Store flag	
	
	ldr		r1,=SamusData	;Load SamusData
	ldrh	r2,[r1,12h]
	lsr    	r0,r0,1h
	sub		r2,r2,r0
	strh	r2,[r1,12h]		;Store x position
	
	ldr		r1,=30013D4h	;Load Poses
	ldrb	r2,[r1]
	cmp		r2,22h			;Check for shinespark
	beq		@@AntiSpeedLeft
	cmp		r2,26h			;Check for ballspark
	beq		@@AntiSpeedLeft
	cmp		r3,028h			;Check again for max increment
	bgt		@@AntiSpeedLeft
	b		@@Done
	
@@AntiSpeedLeft:
	mov		r0,07h			;Set pose to 'skidding'
	strb	r0,[r1]			;Store pose and cancel shinespark
	b		@@Done
	
@@Reset:
	ldr 	r1,=300152Ch
	mov		r0,0h
	strb	r0,[r1]

@@Done:
	pop     r4-r6
	ldr     r0,=0x3000C72
	mov     r1,0
	pop     r2
	bx      r2
	.pool


; hijack code near end of in-game routine
.org 0x800C6D0
	bl      CheckTouchingClip
	
; fix clipdata collision table
.org 0x85D91FC + RightGustClip
	.byte 0
.org 0x85D91FC + LeftGustClip
	.byte 0

; fix clipdata behavior table
.org 0x85D92AC + (RightGustClip * 2)
	.halfword 0
.org 0x85D92AC + (LeftGustClip * 2)
	.halfword 0
	
.close