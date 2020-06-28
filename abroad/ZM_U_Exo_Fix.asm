.gba
.open "zm.gba","Exo_Patch.gba",0x8000000


.org 0x80093BE			;routine run when moving in ball form
	bl MorphSpeed
.org 0x8009460
	b 8009464h		;skips a routine related to keeping speed under cap

.org 0x8304054			; Crocomire graphics
MorphSpeed:
	push r14
	push r0-r6
	ldrb r4,[r0,1h]		;checks if ball is grounded
	cmp r4,0h
	bne @@Return
	bl 80084DCh		;speedbooster timer routine
@@Return:
	pop r0-r6
	mov r4,r0
	ldr r0,=3001380h	;overwritten things
	pop r7
	bx r7
Pose0:
    push    r4,r14
    ldr     r0,=CurrSpriteData
    mov     r12,r0			; r12 = CurrSpriteData
	; new code to check item collected
	ldrb    r0,[r0,1Dh]
	bl      CheckChozoItemCollected
	cmp     r0,0h
	beq     @@Initialize
	mov     r1,r12
	mov     r0,0h
	strh    r0,[r1]			; remove sprite
	b       @@Return
	; end of new code
@@Initialize:
	mov     r0,r12
	ldrh    r1,[r0]
    ldr     r0,=0FFFBh
    and     r0,r1
    mov     r2,0h
    mov     r3,0h
    mov     r1,r12
    strh    r0,[r1]			; status &= FFFB
	; new code to adjust height
	ldrh    r0,[r1,2h]
	sub     r0,20h
	strh    r0,[r1,2h]
	; end of new code
    ldr     r1,=0FFE4h
    mov     r4,r12			; r4 = CurrSpriteData
    strh    r1,[r4,0Ah]		; top boundary = FFE4
    mov     r0,1Ch
    strh    r0,[r4,0Ch]		; bottom boundary = 1C
    strh    r1,[r4,0Eh]		; left boundary = FFE4
    strh    r0,[r4,10h]		; right boundary = 1C
    mov     r0,r12
    add     r0,27h
    mov     r1,0Ch
    strb    r1,[r0]			; sprite[27] = C
    add     r0,1h
    strb    r1,[r0]			; sprite[28] = C
    add     r0,1h
    strb    r1,[r0]			; sprite[29] = C
    strb    r2,[r4,1Ch]		; animation counter = 0
    strh    r3,[r4,16h]		; animation = 0
    mov     r1,r12
    add     r1,25h
    mov     r0,1h
    strb    r0,[r1]			; sprite[25] = 1
    strh    r0,[r4,14h]		; health = 1
    sub     r1,1h
    mov     r0,8h
    strb    r0,[r1]			; pose = 8
    ; use own sprite ID
    ldrb    r0,[r4,1Dh]		; r0 = sprite ID
    bl      SetPose0_OAM
@@Return:
    pop     r4
    pop     r0
    bx      r0
    .pool
	
Pose8:
    bx      r14
	.align
	
PoseDefault:
    push    r14
    ldr     r0,=CurrSpriteData
    mov     r12,r0
    mov     r2,r12
    add     r2,32h
    ldrb    r1,[r2]
    mov     r0,40h
    mov     r3,0h
    orr     r0,r1
    strb    r0,[r2]			; sprite[32] |= 40
    mov     r2,0h
    mov     r0,1h
    mov     r1,r12
    strh    r0,[r1,14h]		; health = 1
    add     r1,25h
    mov     r0,1Eh
    strb    r0,[r1]			; sprite[25] = 1E
    sub     r1,1h
    mov     r0,67h
    strb    r0,[r1]			; pose = 67
    mov     r0,r12
    strb    r2,[r0,1Ch]		; animation counter = 0
    strh    r3,[r0,16h]		; animation = 0
    add     r0,34h
    ldrb    r1,[r0]
    sub     r0,14h
    strb    r1,[r0]			; collision -= 14
    mov     r2,r12
    add     r2,2Bh
    ldrb    r1,[r2]
    mov     r0,80h
    and     r0,r1
    strb    r0,[r2]			; sprite[2B] &= 80
    ; use own sprite ID
    ldrb    r0,[r2,1Dh]		; r0 = sprite ID
    bl      SetPose67_OAM
    ldr     r0,=11Dh
    bl      PlaySound
    pop     r0
    bx      r0
    .pool
	
	
Pose67:
    push    r14
    bl      CheckEndSpriteAnimation
    cmp     r0,0h
    beq     @@Return
    ldr     r1,=CurrSpriteData
    mov     r3,r1
    add     r3,24h
    mov     r2,0h
    mov     r0,9h
    strb    r0,[r3]			; pose = 9
    strb    r2,[r1,1Ch]		; animation counter = 0
    strh    r2,[r1,16h]		; animation = 0
    ; use own sprite ID
    ldrb    r0,[r1,1Dh]		; r0 = sprite ID
    bl      SetPose9_OAM
@@Return:
    pop     r0
    bx      r0
    .pool
	
	
Pose9:
    push    r4,r14
    ldr     r3,=CurrSpriteData
    ldrh    r1,[r3]
    mov     r0,80h
    lsl     r0,r0,4h
    and     r0,r1
    cmp     r0,0h
    beq     @@Return		; return if status doesn't have 800
    ldr     r1,=3001606h	; ???
    mov     r2,0FAh
    lsl     r2,r2,2h
    mov     r0,r2
    strh    r0,[r1]			; [3001606] = 3E8
    mov     r4,r3
    add     r4,32h
    ldrb    r1,[r4]
    mov     r0,1h
    mov     r2,0h
    orr     r0,r1
    strb    r0,[r4]			; freeze timer |= 1
    mov     r1,r3
    add     r1,26h
    mov     r0,1h
    strb    r0,[r1]			; sprite[26] = 1
    sub     r1,2h
    mov     r0,23h
    strb    r0,[r1]			; pose = 23
    mov     r0,r3
    add     r0,2Ch
    strb    r2,[r0]			; sprite[2C] = 0
	; use own sprite ID
    ldrb    r4,[r3,1Dh]
    mov     r0,r4			; r0 = sprite ID
    bl      SetChozoEvent
    mov     r0,r4			; r0 = sprite ID
    bl      GetItem
@@Return:
    pop     r4
    pop     r0
    bx      r0
    .pool

	
Pose23:
    push    r14
    ldr     r2,=CurrSpriteData
    mov     r1,r2
    add     r1,26h
    mov     r0,1h
    strb    r0,[r1]			; sprite[26] = 1
    add     r1,6h
    ldrb    r1,[r1]			; r1 = sprite[2C]
    and     r0,r1
    cmp     r0,0h
    bne     @@SkipToggle	; skip if sprite[2C] has 1
    ldrh    r0,[r2]
    mov     r1,4h
    eor     r0,r1
    strh    r0,[r2]			; status ^= 2
@@SkipToggle:
    ldr     r0,=3001606h
    ldrh    r1,[r0]
    ldr     r0,=3E6h
    cmp     r1,r0
    bhi     @@Return		; return if [3001606] > 3E6
    mov     r0,0h
    strh    r0,[r2]			; status = 0 (remove sprite)
@@Return:
    pop     r0
    bx      r0
    .pool


ChozoBallAI:
	push    r14
    ldr     r0,=CurrSpriteData
    add     r0,24h
    ldrb    r0,[r0]			; r0 = sprite pose
    cmp     r0,23h
    beq     @@Pose23
    cmp     r0,23h
    bgt     @@Pose24_plus
    cmp     r0,8h
    beq     @@Pose8
    cmp     r0,8h
    bgt     @@Pose9_plus
    cmp     r0,0h
    beq     @@Pose0
    b       @@PoseDefault
@@Pose9_plus:
    cmp     r0,9h
    beq     @@Pose9
    b       @@PoseDefault
@@Pose24_plus:
    cmp     r0,67h
    beq     @@Pose67
    b       @@PoseDefault
@@Pose0:
    bl      Pose0
    b       @@Return
@@Pose8:
    bl      Pose8
    b       @@Return
@@Pose67:
    bl      Pose67
    b       @@Return
@@Pose9:
    bl      Pose9
    b       @@Return
@@Pose23:
	bl      Pose23
    b       @@Return
@@PoseDefault:
	bl      PoseDefault
@@Return:
    pop     r0
    bx      r0
.pool

.org 0x80075C4			;r0 = 30013F4,  r2 = 30013D4, r3 = 3001528 at hijack start
	ldr r1,=8760D39h	;make r1 freespace, if used on vanilla rom the current offset is okay
	bl 808ABFCh		;branches directly to bx r1 to jump to code
	b 80075FEh		
.pool
.org 0x8760D38		;Freespace
	push r14	
	mov r1,r2	;moves 30013D4 into r1
	sub r1,58h	;subtracts r1 by 58 to get 300137C, (Button Input Address)
	ldrh r0,[r1]	;loads current input to r0
	ldrh r1,[r2,0Eh];loads Samus'current direction to r1. 10=right 20=left
	and r0,r1
	cmp r0,0h	;checks if input direction and direction facing are the same
	beq @@NormalLand
	mov r1,r2	;moves 30013D4 into r1
	add r1,20h	;adds 20 to get 30013F4
	ldrb r0,[r1,1h]	;loads 30013F5 into r0
	cmp r0,0h
	beq @@LandingCheck
	ldrb r0,[r2,1h]	;mid-air flag
	cmp r0,0h	;checking if grounded
	beq @@LandingCheck
	b @@NormalLand
@@LandingCheck:	
	mov r1,r13	
	add r1,4h
	ldrb r0,[r1]
	cmp r0,0FDh	;seems to only be true if landing from a jump
	bne @@MorphJump
	ldrb r0,[r2]	;loads current pose
	cmp r0,14h	;checks if falling/landing in morphball mode
	bne @@MorphChecks
	mov r0,12h
	strb r0,[r1]  	;sets r1 t0 12, which has to do with morphball
	b @@BoostCheck
@@MorphJump:
	cmp r0,0FEh	;seems to be true when jumping in morphball mode
	bne @@NormalLand
	b @@BoostCheck
@@MorphChecks:
	ldrb r0,[r2]	;loads current pose
	cmp r0,31h	;checks if getting hurt in morphball
	beq @@NormalLand
	cmp r0,32h	;checks if knocked back while in morphball
	beq @@NormalLand
	mov r0,0h
	strb r0,[r1]
@@BoostCheck:
	ldrb r0,[r2,5h]	;checking if speedboosting
	cmp r0,0h
	beq @@SmoothLand
	mov r0,22h
	strb r0,[r2]	;sets samus in shinespark pose, seems to cause samus 
			;to pop out of morphball in the spinjump pose rather than
			;make her shinespark. Also read when jumping while boosting
@@SmoothLand:
	bl Return	
	b @@ResetNormal
@@NormalLand:	
	bl Return	
	b @@SpeedReset	
@@SpeedReset:		;overwritten instructions that store 0 to speed related 
	mov r0,0h	;offsets. Skipped when keeping speed
	strh r0,[r2,16h]
	strb r0,[r2,5h]
	strb r0,[r2,2h]	
	strb r0,[r2,0Ah]
@@ResetNormal:		;overwritten instructions that store 0, always read
	mov r0,0h	
	strh r0,[r2,0Ch]
	strh r0,[r2,10h]
	strh r0,[r2,18h]
	strb r0,[r2,1Ch]
	strb r0,[r2,1Dh]
	mov r0,0h
	strb r0,[r2,4h]
	strb r0,[r2,7h]
	pop r0
	mov r1,0h
	bx r0
Return:		;overwritten and skipped routine being replaced
	push r14	
	mov r0,r2
	add r0,20h
	mov r1,r2
	ldmia [r1]!,r4-r6
	stmia [r0]!,r4-r6
	ldmia [r1]!,r4-r6
	stmia [r0]!,r4-r6
	ldmia [r1]!,r4,r5
	stmia [r0]!,r4,r5
	ldrb r0,[r2,3h]
	cmp r0,0h
	beq @@SubReturn
	ldrh r0,[r2,0Eh]
	mov r1,30h
	eor r0,r1
	mov r1,0h
	strh r0,[r2,0Eh]
	strb r1,[r2,3h]
@@SubReturn:		;overwritten and skipped routine being replaced
	pop r0		;8760E1C
	bx r0
.pool

; new code
.org 0x8760E1E
CheckFireBeam:
	ldrb r0,[r4,0x5]		; load charge counter
	cmp r0,0x3F
	bls @@Return
; fire beam
	mov r0,0x0
	strb r0,[r4,0x5]		; reset charge counter
	mov r0,0x6
	strb r0,[r4,0x1]		; set flag to fire charged shot
@@Return:
	ldr r0,=0x80081B8
	mov r15,r0
.pool
	
; hijack code
.org 0x80081B0
	ldr r0,=CheckFireBeam
	mov r15,r0
.pool

org 0x80075FA
	bl MorphCheck
.org 0x80077AC
	bl IdleStop


.org 0x8043DF0 ; Croco AI, Unused
IdleStop:
	push r5
	mov r5,r0
	ldrb r0,[r4]		;checks if not moving in morphball
	cmp r0,11h
	beq @@Return
	add r5,1h		;if moving, adds to animation counter like normal
	strb r5,[r4,1Ch]
@@Return:
	pop r5
	bx r14

MorphCheck:
	ldrb r0,[r2]
	cmp r0,11h		;checks ball poses
	beq @@ButtonCheck
	cmp r0,12h		;checks ball poses
	beq @@ButtonCheck
@@Zero:
	strb r1,[r2,1Ch]	;zeros animation values
	strb r1,[r2,1Dh]
	b @@Return
@@ButtonCheck:			;needed if player is unmorphing, otherwise the game can 
	push r1			;load an animation that doesnt exist and crash
	ldr r0,=3001380h	;changed input
	ldrh r0,[r0]
	mov r1,40h
	and r0,r1
	pop r1
	cmp r0,40h		;checks if pressed up is pressed
	beq @@Zero
@@Return:
	bx r14
	
.pool

.org 0x801B910
	nop
	nop
.pool

.definelabel CurrSprite,0x3000738
.definelabel ArmPosition,0x3000BEC
.definelabel ChargeCounter,0x3001419


; new code
.org 0x876B21A
DrawPickup:
	push r2-r6
	ldr r0,=ChargeCounter
	ldrb r0,[r0]
	cmp r0,0x40				; check if fully charged
	bcc @@Return
	ldr r0,=ArmPosition
	ldrh r1,[r0,0x2]		; r1 = arm X position
	ldrh r2,[r0]			; r2 = arm Y position
	ldr r0,=CurrSprite
	ldrh r3,[r0,0x4]		; r3 = sprite X position
	ldrh r4,[r0,0x2]		; r4 = sprite Y position

; get diffX and diffY
@@GetDiffX:
	cmp r1,r3
	bls @@Else1				; if spriteX < armX
	sub r1,r1,r3			; r1 = diffX
	mov r5,0x0
	b @@GetDiffY
@@Else1:
	sub r1,r3,r1
	mov r5,0x1
@@GetDiffY:
	cmp r2,r4
	bls @@Else2				; if spriteY < armY
	sub r2,r2,r4			; r2 = diffY
	mov r6,0x0
	b @@CheckX
@@Else2:
	sub r2,r4,r2
	mov r6,0x1

@@CheckX:
	cmp r1,0x4
	bcc @@CheckY			; skip if diffX < 4
	mov r3,0x0				; r3 = factor
	mov r4,r2				; r4 = orig
@@WhileX:
	cmp r1,r2
	bcc @@BreakX			; while diffX >= diffY
	add r2,r2,r4				; diffY += orig
	add r3,0x1					; factor++
	cmp r3,0x4
	beq @@BreakX				; break if factor == 3
	b @@WhileX
@@BreakX:
	cmp r3,0x0
	beq @@CheckY			; if factor > 0
	ldr r0,=MoveTable
	lsl r3,0x1
	add r0,r0,r3
	ldrb r1,[r0]
	ldrb r2,[r0,0x1]
	b @@Write
	
@@CheckY:
	cmp r2,0x4
	bcc @@Return			; skip if diffY < 4
	mov r3,0x0				; r5 = factor
	mov r4,r1				; r6 = orig
@@WhileY:
	cmp r2,r1
	bcc @@BreakY			; while diffY >= diffX
	add r1,r1,r4				; diffX += orig
	add r3,0x1					; factor++
	cmp r3,0x4
	beq @@BreakY				; break if factor == 3
	b @@WhileY
@@BreakY:
	cmp r3,0x0
	beq @@Return			; if factor > 0
	ldr r0,=MoveTable
	lsl r3,0x1
	add r0,r0,r3
	ldrb r1,[r0,0x1]
	ldrb r2,[r0]
	
@@Write:
	ldr r0,=CurrSprite
	ldrh r3,[r0,0x4]		; r3 = sprite X position
	ldrh r4,[r0,0x2]		; r4 = sprite Y position
	cmp r5,0x0
	beq @@PosX
	sub r3,r3,r1
	b @@WriteX
@@PosX:
	add r3,r3,r1
@@WriteX:
	strh r3,[r0,0x4]
	cmp r6,0x0
	beq @@PosY
	sub r4,r4,r2
	b @@WriteY
@@PosY:
	add r4,r4,r2
@@WriteY:
	strh r4,[r0,0x2]
	
@@Return:
	pop r2-r6
	ldr r2,=CurrSprite
	mov r0,r2
	ldr r1,=Resume
	mov r15,r1
	.pool
	
MoveTable:
	.byte 0,0
	.byte 3,3		; 1:1
	.byte 3,2		; 2:1
	.byte 4,1		; 3:1
	.byte 4,0		; 4:1


; hijack pickup AI
.org 0x8012E9A
	.halfword 0x4806		; ldr r0,=DrawPickup
	mov r15,r0
Resume:
	
.org 0x8012EB4
	.word DrawPickup
.pool

;-----
; All
;-----
.org 0x801B886			; Play correct jingle
	mov r0,0x37
.org 0x8071120			; Play correct sound
	.halfword 0x01F7	; 8071118 ldr r0,=1F7h

	
;--------
; Plasma
;--------
.org 0x807057E			; Show non-garbled text
	b 0x8070584
.org 0x8071944			; Display proper description text
	mov r3,0x4
	b 0x8071A32
.org 0x8071B8E			; Enable plasma
	b 0x8071C1A
	
;---------
; Gravity
;---------
.org 0x80706EC			; Show non-garbled text
	b 0x80706F2
.org 0x80719BC			; Display proper description text
	mov r3,0xA
	b 0x8071A32
.org 0x8071BDE			; Enable gravity
	b 0x8071C1A
	
.org 0x800B4A0			; Load proper palette
	.halfword 0x480F	; ldr r0,=0x3001530
	ldrb r2,[r0,0xF]
	mov r0,0x20
	and r0,r2
	cmp r0,0
	beq 0x800B554
	b 0x800B4B0
	
;------------
; Space Jump
;------------
.org 0x807085A			; Show non-garbled text
	b 0x8070860
.org 0x8071A24			; Display proper description text
	mov r3,0x10
	b 0x8071A32
.org 0x8071C12			; Enable space
	b 0x8071C1A

	
;------
; Text
;------

;04 PLASMA BEAM
;0A GRAVITY SUIT
;10 SPACE JUMP

.org 0x8441F96			
	.halfword 0x8052,0x8105,0x1D1,0x197,0x1DD,0x18F,0x1CB,0x150,0x191,0xFE00,0x806E,0xFF00

.org 0x8441FE0			
	.halfword 0x804E,0x8105,0x1D8,0x197,0x1CB,0x183,0x148,0x15D,0x150,0x182,0xFE00,0x806E,0xFF00
	
.org 0x844206A			
	.halfword 0x804E,0x8105,0x15D,0x1D2,0x150,0x15D,0x1DC,0x14C,0x19D,0x1D1,0xFE00,0x806E,0xFF00
	
.org 0x844284C			
	.halfword 0x804E,0x8105,0x90,0xCC,0xC1,0xD3,0xCD,0xC1,0x40,0x82,0xC5,0xC1,0xCD,0xFE00,0x806E,0xFF00
	
.org 0x844289E			
	.halfword 0x8050,0x8105,0x87,0xD2,0xC1,0xD6,0xC9,0xD4,0xD9,0x40,0x93,0xD5,0xC9,0xD4,0xFE00,0x806E,0xFF00
	
.org 0x844293C			
	.halfword 0x804E,0x8105,0x93,0xD0,0xC1,0xC3,0xC5,0x40,0x8A,0xD5,0xCD,0xD0,0xFE00,0x806E,0xFF00
.pool

.definelabel CurrSpriteData,0x3000738
.definelabel PlaySound,0x8002A18
.definelabel SpawnNewPrimarySprite,0x800E31C
.definelabel CheckEndSpriteAnimation,0x800FBC8

; reusable functions
.definelabel SetChozoEvent,0x80138D8
.definelabel CheckChozoItemCollected,0x8013DE0
.definelabel GetItem,0x80162B0
.definelabel SetPose0_OAM,0x8016344
.definelabel SetPose67_OAM,0x80163A8
.definelabel SetPose9_OAM,0x801640C

; chozo statue AI (uncomment ones you want as ball only)
.org 0x875E94C				; long beam
	.word ChozoBallAI + 1
.org 0x875E954				; ice beam
	.word ChozoBallAI + 1
.org 0x875E95C				; wave beam
	.word ChozoBallAI + 1
.org 0x875E964				; bombs
	.word ChozoBallAI + 1
.org 0x875E96C				; speed booster
	.word ChozoBallAI + 1
.org 0x875E974				; hi-jump
	.word ChozoBallAI + 1
.org 0x875E97C				; screw attack
	.word ChozoBallAI + 1
.org 0x875E984				; varia
	.word ChozoBallAI + 1
.org 0x875EA20				; gravity
	.word ChozoBallAI + 1
.org 0x875EA24				; space jump
	.word ChozoBallAI + 1
.org 0x875EB10				; plasma beam
	.word ChozoBallAI + 1
	
; chozo statue weakness (uncomment ones you want as ball only)
.org 0x82B0FE2				; long beam
	.byte 0x1A
.org 0x82B1006				; ice beam
	.byte 0x1A
.org 0x82B102A				; wave beam
	.byte 0x1A
.org 0x82B104E				; bombs
	.byte 0x1A
.org 0x82B1072				; speed booster
	.byte 0x1A
.org 0x82B1096				; hi-jump
	.byte 0x1A
.org 0x82B10BA				; screw attack
	.byte 0x1A
.org 0x82B10DE				; varia
	.byte 0x1A
.org 0x82B139C				; gravity
	.byte 0x1A
.org 0x82B13A8				; space jump
	.byte 0x1A
.org 0x82B17D4				; plasma beam
	.byte 0x1A
.pool
.close