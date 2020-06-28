.gba
.open "zm.gba","ChozoBall2.gba",0x8000000

; Instructions: for any sprite you wish to not spawn in a ball
;make it's health ather than 0 in MAGE. Will not effect amount of shots
;it takes to open ball

.definelabel CurrSpriteData,0x3000738
.definelabel PlaySound,0x8002A18
.definelabel SpawnNewPrimarySprite,0x800E31C
.definelabel CheckEndSpriteAnimation,0x800FBC8
.definelabel PrimarySpriteStats,0x82B0D68
.definelabel SpriteGfxPointers,0x875EBF8

; reusable functions
.definelabel SetChozoEvent,0x80138D8
.definelabel CheckChozoItemCollected,0x8013DE0
.definelabel GetItem,0x80162B0

;OAM
.org 0x82B541E  ;(original oam offset)
ItemExposed_Frame1:
	.halfword 1
	.halfword 0x00F8,0x41F8,0x8200
ItemExposed_Frame2:
	.halfword 1
	.halfword 0x00F8,0x41F8,0x8202
ItemExposed_Frame3:
	.halfword 1
	.halfword 0x00F8,0x41F8,0x8204
	
.org 0x82B53BE  ;(original oam offset)
ItemShot_Frame1:
	.halfword 5
	.halfword 0x00F4,0x41F4,0x9255
	.halfword 0x80F4,0x0004,0x9257
	.halfword 0x4004,0x01F4,0x9272
	.halfword 0x0004,0x0004,0x9274
	.halfword 0x00F8,0x41F8,0x8200
ItemShot_Frame2:
	.halfword 5
	.halfword 0x40F4,0x01F4,0x9259
	.halfword 0x80F4,0x0004,0x925B
	.halfword 0x80FC,0x01F4,0x9258
	.halfword 0x4004,0x01FC,0x9279
	.halfword 0x00F8,0x41F8,0x8200
ItemShot_Frame3:
	.halfword 5
	.halfword 0x40F4,0x01F4,0x925D
	.halfword 0x80F4,0x0004,0x925F
	.halfword 0x80FC,0x01F4,0x925C
	.halfword 0x4004,0x01FC,0x927E
	.halfword 0x00F8,0x41F8,0x8200
	
.org 0x82B5382  ;(original oam offset)
ItemOrb_Frame1:
	.halfword 3
	.halfword 0x00F7,0x41F7,0x9247
	.halfword 0x80F7,0x0007,0x9249
	.halfword 0x4007,0x01F7,0x9250
ItemOrb_Frame2:
	.halfword 3
	.halfword 0x00F7,0x41F7,0x924A
	.halfword 0x80F7,0x0007,0x924C
	.halfword 0x4007,0x01F7,0x9270
ItemOrb_Frame3:
	.halfword 3
	.halfword 0x00F7,0x41F7,0x924D
	.halfword 0x80F7,0x0007,0x924F
	.halfword 0x4007,0x01F7,0x9252
	
.org 0x82B58B0  ;(original oam offset)	
	.align
ItemExposedOAM:
	.word ItemExposed_Frame1
	.word 0xA
	.word ItemExposed_Frame2
	.word 0xA
	.word ItemExposed_Frame3
	.word 0xA
	.word ItemExposed_Frame2
	.word 0xA
	.word 0,0

.org 0x82B5890  ;(original oam offset)
	.align
ItemShotOAM:
	.word ItemShot_Frame1
	.word 2
	.word ItemShot_Frame2
	.word 2
	.word ItemShot_Frame3
	.word 2
	.word 0,0
	
.org 0x82B5868  ;(original oam offset)
	.align
ItemOrbOAM:
	.word ItemOrb_Frame1
	.word 0xE
	.word ItemOrb_Frame2
	.word 0xE
	.word ItemOrb_Frame1
	.word 0xE
	.word ItemOrb_Frame3
	.word 0xE
	.word 0,0
	
;importing palettes (only unknown items are changed)
.org 0x82C2B24	;vanilla gravity palette
	.import "ItemGFX\gravity.palette"
	.align
.org 0x82C0A58	;vanilla space jump palette
	.import "ItemGFX\space.palette"
	.align
.org 0x82C40F4	;vanilla plasma beam palette
	.import "ItemGFX\plasma.palette"
	.align

;importing GFX
.org 0x82C15F0   ;vanilla gravity gfx 
	.import "ItemGFX\Gravity.gfx.lz"
	.align
.org 0x82BF534	;vanilla space jump gfx
	.import "ItemGFX\Space Jump.gfx.lz"
	.align
.org 0x82C2BC4	;vanilla plasma gfx
	.import "ItemGFX\Plasma B.gfx.lz"
	.align
	
.org 0x8760E00  ;freespace
LongBeamGFX:
	.import "ItemGFX\Long B.gfx.lz"
	.align
IceBeamGFX:	
	.import "ItemGFX\Ice B.gfx.lz"
	.align
WaveBeamGFX:
	.import "ItemGFX\Wave B.gfx.lz"
	.align
BombGFX:
	.import "ItemGFX\Bombs.gfx.lz"
	.align
SpeedBoosterGFX:
	.import "ItemGFX\Speed.gfx.lz"
	.align
HiJumpGFX:
	.import "ItemGFX\Hi-Jump.gfx.lz"
	.align
ScrewattackGFX:
	.import "ItemGFX\Screw.gfx.lz"
	.align
VariaSuitGFX:
	.import "ItemGFX\Varia.gfx.lz"
	.align

; chozo statue AI (only changes the chozo sprites that hold the item)
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
	
;graphics pointers (preserves chozo GFX so statues can still be used)
;unknown item statues are overwritten
.org SpriteGfxPointers + (0x23 - 0x10) * 4
    .word LongBeamGFX
.org SpriteGfxPointers + (0x25 - 0x10) * 4
    .word IceBeamGFX
.org SpriteGfxPointers + (0x27 - 0x10) * 4
    .word WaveBeamGFX
.org SpriteGfxPointers + (0x29 - 0x10) * 4
    .word BombGFX
.org SpriteGfxPointers + (0x2B - 0x10) * 4
    .word SpeedBoosterGFX
.org SpriteGfxPointers + (0x2D - 0x10) * 4
    .word HiJumpGFX
.org SpriteGfxPointers + (0x2F - 0x10) * 4
    .word ScrewAttackGFX
.org SpriteGfxPointers + (0x31 - 0x10) * 4
    .word VariaSuitGFX

	
; chozo statue weaknesses
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
.org 0x82B13AE				; space jump
	.byte 0x1A
.org 0x82B17D4				; plasma beam
	.byte 0x1A
	
	
; copy of chozo ball AI (place in bl range)
.org 0x8304054		; Crocomire graphics
Pose0:
    push    r4,r14
    ldr     r4,=CurrSpriteData
	; new code to check item collected
	ldrb    r0,[r4,1Dh]
	bl      CheckChozoItemCollected
	cmp     r0,0h
	beq     @@Initialize
	mov     r0,0h
	strh    r0,[r4]			; remove sprite
	b       @@Return
	; end of new code
@@Initialize:
	ldrh    r1,[r4]
    ldr     r0,=0FFFBh
    and     r0,r1
    mov     r2,0h
    mov     r3,0h
    strh    r0,[r4]			; status &= FFFB
	; new code to adjust height
	ldrh    r0,[r4,2h]
	sub     r0,20h
	strh    r0,[r4,2h]
	; end of new code
    ldr     r1,=0FFE4h
    strh    r1,[r4,0Ah]		; top boundary = FFE4
    mov     r0,1Ch
    strh    r0,[r4,0Ch]		; bottom boundary = 1C
    strh    r1,[r4,0Eh]		; left boundary = FFE4
    strh    r0,[r4,10h]		; right boundary = 1C
    mov     r0,r4
    add     r0,27h
    mov     r1,0Ch
    strb    r1,[r0]			; sprite[27] = C
    add     r0,1h
    strb    r1,[r0]			; sprite[28] = C
    add     r0,1h
    strb    r1,[r0]			; sprite[29] = C
    strb    r2,[r4,1Ch]		; animation counter = 0
    strh    r3,[r4,16h]		; animation = 0
	mov     r0,1h
    strh    r0,[r4,14h]		; health = 1
	ldr     r2,=PrimarySpriteStats 	                  
	ldrb    r1,[r4,1Dh]				;sprite ID                    
	lsl     r0,r1,3h                       
	add     r0,r0,r1                       
	lsl     r0,r0,1h                       
	add     r0,r0,r2                       
	ldrh    r0,[r0]					;sprite health
	mov     r1,r4
    add     r1,24h	
	cmp		r0,0h
	bne		@@PreventBall
	mov		r0,1h
	strb	r0,[r1,1h]			;makes sprite solid
	mov		r0,8h
	strb	r0,[r1]				;pose = 8
    ldr		r0,=ItemOrbOAM
	str		r0,[r4,18h]
	b		@@Return
@@PreventBall:
	mov		r0,9h
	strb	r0,[r1]				;pose = 9
	mov		r0,1Eh
	strb	r0,[r1,1h]			;ability collision
	mov		r2,r4
	add     r2,32h
    ldrb    r1,[r2]
    mov     r0,40h
    orr     r0,r1
    strb    r0,[r2]				;makes sprite immune to projectiles
	mov		r0,r4
	add     r0,34h
    ldrb    r1,[r0]
    sub     r0,14h
    strb    r1,[r0]				;changes sprite palette
    ldr		r0,=ItemExposedOAM
	str		r0,[r4,18h]
@@Return:
    pop     r4
    pop     r0
    bx      r0
.pool
	
Pose8:
    bx      r14
	
PoseDefault:
    push    r4,r14
    ldr     r4,=CurrSpriteData
    mov     r2,r4
    add     r2,32h
    ldrb    r1,[r2]
    mov     r0,40h
    mov     r3,0h
    orr     r0,r1
    strb    r0,[r2]			; sprite[32] |= 40
    mov     r2,0h
    mov     r0,1h
    mov     r1,r4
    strh    r0,[r1,14h]		; health = 1
    add     r1,25h
    mov     r0,1Eh
    strb    r0,[r1]			; sprite[25] = 1E
    sub     r1,1h
    mov     r0,67h
    strb    r0,[r1]			; pose = 67
    mov     r0,r4
    strb    r2,[r0,1Ch]		; animation counter = 0
    strh    r3,[r0,16h]		; animation = 0
    add     r0,34h
    ldrb    r1,[r0]
    sub     r0,14h
    strb    r1,[r0]			; collision -= 14
    mov     r2,r4
    add     r2,2Bh
    ldrb    r1,[r2]
    mov     r0,80h
    and     r0,r1
    strb    r0,[r2]			; sprite[2B] &= 80
    ; use own sprite ID
    ldr		r0,=ItemShotOAM
	str		r0,[r4,18h]
    ldr     r0,=11Dh
    bl      PlaySound
	pop		r4
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
    ldr		r0,=ItemExposedOAM
	str		r0,[r1,18h]
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


	
.close
