.gba
.open "motherom.gba","ZM_U_chozoBall.gba",0x8000000

; Instructions: uncomment the chozo statue AI and weakness 
; below for each statue you want to be just the ball

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
	.byte 0x28
.org 0x82B1006				; ice beam
	.byte 0x19
.org 0x82B102A				; wave beam
	.byte 0x15
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
	.byte 0x28
.org 0x82B13A8				; space jump
	.byte 0x1A
.org 0x82B17D4				; plasma beam
	.byte 0x1A

; copy of chozo ball AI (place in bl range)
.org 0x8304bc0		; Crocomire graphics
Pose0:
    push    r4,r14
    ldr     r0,=CurrSpriteData
    mov     r12,r0			; r12 = CurrSpriteData
	; new code to check item collected
	ldrb    r0,[r0,1Dh]
	bl      CheckChozoItemCollected         ;获取ID检查是否已经被得到
	cmp     r0,0h
	beq     @@Initialize
	mov     r1,r12
	mov     r0,0h
	strh    r0,[r1]			; remove sprite 清除精灵
	b       @@Return
	; end of new code
@@Initialize:                        ;初始化
	mov     r0,r12
	ldrh    r1,[r0]
    ldr     r0,=0FFFBh
    and     r0,r1
    mov     r2,0h
    mov     r3,0h
    mov     r1,r12
    strh    r0,[r1]			; status &= FFFB
	; new code to adjust height
	ldrh    r0,[r1,2h]               ;垂直坐标向上20h再写入
	sub     r0,20h
	strh    r0,[r1,2h]
	; end of new code
    ldr     r1,=0FFE4h
    mov     r4,r12			; r4 = CurrSpriteData
    strh    r1,[r4,0Ah]		; top boundary = FFE4
    mov     r0,1Ch
    strh    r0,[r4,0Ch]		; bottom boundary = 1C
    strh    r1,[r4,0Eh]		; left boundary = FFE4
    strh    r0,[r4,10h]		; right boundary = 1C         ;四面分界
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
    mov     r0,1h           ;属性写入1
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
    ldrb    r1,[r2]         ;读取碰撞属性
    mov     r0,40h
    mov     r3,0h
    orr     r0,r1           ; 写入40h
    strb    r0,[r2]			; sprite[32] |= 40
    mov     r2,0h
    mov     r0,1h
    mov     r1,r12
    strh    r0,[r1,14h]		; health = 1
    add     r1,25h
    mov     r0,1Eh
    strb    r0,[r1]			; sprite[25] = 1E 属性写入1E,可以获取?
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
    ldr     r0,=30016-06h
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
    ldrb    r0,[r0]			; r0 = sprite pose 检查pose值
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

	
.close
