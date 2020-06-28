.gba
.open "ZM.gba","ZM_U_unkItems.gba",0x8000000

.definelabel MessageInfo,0x3000C0C
.definelabel Equipment,0x3001530
.definelabel PlaySound,0x8002A18

;----------
; New Code
;----------
.org 0x8304054		; crocomire graphics
StartFullSuit:
	strh    r0,[r1]
	strh    r0,[r1,6]
	mov     r0,1
	strb    r0,[r1,0x12]
	bx      r14

ChangeSuit:
	ldr     r6,=Equipment
	ldrb    r0,[r6,0x12]
	push    r0
	cmp     r0,1
	bne     @@Return
	; if full suit
	ldrb    r0,[r6,0xF]
	mov     r1,0x20
	and     r0,r1
	cmp     r0,0
	bne     @@Return
	; and not have gravity
	strb    r0,[r6,0x12]
@@Return:
	add     sp,-4h
	bx      r14
	.pool
	
RestoreSuit:
	add     sp,4h
	pop     r0
	ldr     r1,=Equipment
	strb    r0,[r1,0x12]
    pop     r3-r5
	bx      r14
	.pool

StatusScreen:
	ldr     r0,=Equipment
	ldrb    r2,[r0,0x12]
	cmp     r2,2
	beq     @@Return		; return r2 = 2 if suitless
	ldrb    r2,[r0,0xF]
	mov     r1,0x20
	and     r2,r1
	cmp     r2,0
	beq     @@Return		; return r2 = 0 if no gravity
	; if have gravity
	mov     r2,1			; return r2 = 1 if gravity
@@Return:
	bx      r14
	.pool

SwitchText:
	push    r14
	; check for full suit
	ldr     r0,=Equipment
	ldrb    r0,[r0,0x12]
	cmp     r0,1
	beq     @@ReplacedCode
	; check if unknown item
	mov     r0,r8
	cmp     r0,0xC
	beq     @@IsUnknown
	cmp     r0,0xF
	beq     @@IsUnknown
	cmp     r0,0x14
	bne     @@ReplacedCode
@@IsUnknown:
	ldr     r0,=MessageInfo
	ldrb    r1,[r0,0xC]
	cmp     r1,2
	bne     @@ReplacedCode
	mov     r1,0x23
	strb    r1,[r0,0xA]
@@ReplacedCode:
	bl      0x806F28C
	ldr     r1,=MessageInfo
	mov     r2,r8
	strb    r2,[r1,0xA]
	pop     r1
	bx      r1
	.pool

GetJingleNumber:
	ldr     r0,=Equipment
	ldrb    r0,[r0,0x12]
	cmp     r0,1
	beq     @@FullSuit
	mov     r0,0x42
	b       @@Return
@@FullSuit:
	mov     r0,0x37
@@Return:
	bx      r14
	.pool

GetSoundNumber:
	ldr     r0,=Equipment
	ldrb    r0,[r0,0x12]
	cmp     r0,1
	beq     @@FullSuit
	ldr     r0,=0x20F
	b       @@Return
@@FullSuit:
	ldr     r0,=0x1F7
@@Return:
	bx      r14
	.pool

	
;-----------
; Full Suit
;-----------
; start with full suit
.org 0x800BD7E
	bl      StartFullSuit
	
; display correct graphics
.org 0x800A692
	mov     r9,r0
	mov     r4,r1
	bl      ChangeSuit
.org 0x800B452
	bl      RestoreSuit
	
; display correct palette
.org 0x800B4AE
	beq     0x800B558

; status screen graphics
.org 0x8068DE0
	bl      StatusScreen


;-------
; Items
;-------
; display correct text
.org 0x801B84C
	bl      SwitchText

; play correct jingle
.org 0x801B886
	bl      GetJingleNumber
	b       0x801B8CA
	
; play correct sound
.org 0x8071118
	bl      GetSoundNumber
	bl      PlaySound
	b       0x8071144

	
;----------------
; Obtaining Suit
;----------------
; skip adding varia
.org 0x805CA36
	mov     r0,1
	b       0x805CA52
	
; only activate gravity if obtained
.org 0x80600EC
	ldrb    r1,[r2,0xE]
	strb    r1,[r2,0xF]
	b       0x8060318
	
	
;------
; Text
;------
	
.org 0x844284C		; Plasma Beam
	.halfword 0x804E,0x8105,0x90,0xCC,0xC1,0xD3,0xCD,0xC1,0x40,0x82,0xC5,0xC1,0xCD,0xFE00,0x806E,0xFF00
	
.org 0x844289E		; Gravity Suit
	.halfword 0x8050,0x8105,0x87,0xD2,0xC1,0xD6,0xC9,0xD4,0xD9,0x40,0x93,0xD5,0xC9,0xD4,0xFE00,0x806E,0xFF00
	
.org 0x844293C		; Space Jump
	.halfword 0x804E,0x8105,0x93,0xD0,0xC1,0xC3,0xC5,0x40,0x8A,0xD5,0xCD,0xD0,0xFE00,0x806E,0xFF00
	
.org 0x8442D22		; Unknown Item
	.halfword 0x804A,0x8105,0x0095,0x00CE,0x00CB,0x00CE,0x00CF,0x00D7,0x00CE,0x0040,0x0089,0x00D4,0x00C5,0x00CD,0xFE00,0x806E,0xFF00
	

.close
