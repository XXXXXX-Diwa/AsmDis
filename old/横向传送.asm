.gba
.open "zm.gba","morph_shot.gba",0x8000000

; Code by OneOf99
; Thanks to CaptGlitch for help

.definelabel Air,0x00
.definelabel MorphLeft,0x78
.definelabel MorphRight,0x79

.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8

; new code
.org 0x8304094    ; crocomire graphics



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
	cmp     r0,MorphLeft
	beq     @@ShotLeft
	cmp		r0,MorphRight
	beq		@@ShotRight
	cmp     r4,r5          ; check if horizontal blocks are same
	beq     @@Loop
; check block to right
	add     r0,r1,2
	ldrh    r0,[r0]
	cmp		r0,Air
	beq		@@Reset
	cmp     r0,MorphLeft
	beq     @@ShotLeft
	cmp		r0,MorphRight
	beq		@@ShotRight

@@Loop:
	cmp     r6,r3          ; check if lowest block checked
	bcs     @@Reset
	add     r6,1           ; add 1 to y block
	b       @@CheckLeftSide
	
@@ShotLeft:

	ldr		r1,=030013D4h		; Load pose
	ldr		r2,=030013E2h		; Load direction
	ldr		r3,=030013D9h		; Load speedboost flag
	ldr		r4,=030013EAh		; Load X velocity
	ldr		r5,=030013ECh		; Load Y velocity
	ldr		r6,=030013D8h		; Load shinespark angle
	ldrb	r0,[r1]
	
	cmp		r0,12h				; Check if morph ball
	bne		@@AfterSparkLeft	; Skip if not morphed
	
;	cmp		r3,1h
;	beq		@@DirectLeft	; Check if already sparking
	
	mov		r0,10h
	strb	r0,[r2]				; Set direction to Left
	mov 	r0,26h
	strb	r0,[r1]				; Set pose to ballspark
	
	mov		r0,1h
	strb	r0,[r3]				; Set speedboost flag to true
	
	ldr		r0,=0FF40h
	strh	r0,[r4]				; Set leftward speed
	
	mov		r0,0h
	strb	r0,[r5]				; Set vertical speed
	
	mov		r0,1h
	strb	r0,[r6]				; Set spark angle
	
@@AfterSparkLeft:
	b		@@Done

@@ShotRight:

	ldr		r1,=030013D4h		; Load pose
	ldr		r2,=030013E2h		; Load direction
	ldr		r3,=030013D9h		; Load speedboost flag
	ldr		r4,=030013EAh		; Load X velocity
	ldr		r5,=030013ECh		; Load Y velocity
	ldr		r6,=030013D8h		; Load shinespark angle
	ldrb	r0,[r1]
	
	cmp		r0,12h				; Check if morph ball
	bne		@@AfterSparkRight	; Skip if not morphed
	
;	cmp		r3,1h
;	beq		@@DirectLeft	; Check if already sparking
	
	mov		r0,20h
	strb	r0,[r2]				; Set direction to Right
	mov 	r0,26h
	strb	r0,[r1]				; Set pose to ballspark
	
	mov		r0,1h
	strb	r0,[r3]				; Set speedboost flag to true
	
	ldr		r0,=0C0h
	strh	r0,[r4]				; Set rightward speed
	
	mov		r0,0h
	strb	r0,[r5]				; Set vertical speed
	
	mov		r0,1h
	strb	r0,[r6]				; Set spark angle
	
@@AfterSparkRight:
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
.org 0x85D91FC + MorphLeft
	.byte 0
.org 0x85D91FC + MorphRight
	.byte 0

; fix clipdata behavior table
.org 0x85D92AC + (MorphLeft * 2)
	.halfword 0
.org 0x85D92AC + (MorphRight * 2)
	.halfword 0
	
.close