.gba
.open "zm.gba","HUD.gba",0x8000000

.definelabel HideHUD,0x300004A
.definelabel OneByteFrameCounter,0x3000C77 
.definelabel OAMData,0x3000E7C
.definelabel NextOAMSlot,0x3001382
.definelabel SamusEquipment,0x3001530
;重写Draw Hub,节省200-300字节...by船长

.org 0x8052308 ; rewritten draw hud function 429 lines or less
	push	r4
	mov		r2,0h			;used OAM slot counter
	ldr		r0,=HideHUD
	ldrb	r0,[r0]
	cmp		r0,0h
	bne		@@Return
	add		r2,2h
	ldr		r4,=OAMData		;drawing first part of energy HUD
	ldr		r0,=0x40004002  ; size and flips = 0x40, X pos = 0, shape = 0x40 ,Y pos = 02
	str		r0,[r4]
	add		r4,4h
	ldr		r0,=0x4050		; 0x40 = pal, 0x50 = tile number
	str		r0,[r4]
	add		r4,4h			;second part of Energy HUD
	ldr		r0,=0x40204002	; size and flips = 0x40, X pos = 0x20, shape = 0x40 ,Y pos = 02
	str		r0,[r4]
	add		r4,4h
	ldr		r0,=0x4054		; 0x40 = pal, 0x54 = tile number
	str		r0,[r4]
	add		r4,4h
	ldr		r3,=SamusEquipment
	ldrb	r0,[r3,12h]		;check if needing to draw zero suit HUD
	cmp		r0,2h
	bne		@@DrawMissiles
	add		r2,2h
	ldr		r0,=0x4001400A  ; size and flips = 0x40, X pos = 1, shape = 0x40 ,Y pos = 0xA
	str		r0,[r4]			;drawing first part of Zero suit HUD
	add		r4,4h
	ldr		r0,=0x4088		; 0x40 = pal, 0x88 = tile number
	str		r0,[r4]
	add		r4,4h		
	ldr		r0,=0x4021400A  ; size and flips = 0x40, X pos = 0x21, shape = 0x40 ,Y pos = 0xA
	str		r0,[r4]			;drawing second part of Zero suit HUD
	add		r4,4h
	ldr		r0,=0x408C		; 0x40 = pal, 0x8C = tile number 
	str		r0,[r4]
	add		r4,4h
	b 		@@DrawMap
.pool
@@DrawMissiles:
	ldrh	r0,[r3,2h]
	cmp		r0,0h
	beq		@@DrawSupers
	add		r2,1h
	ldr		r0,=0x40364002  ; size and flips = 0x40, X pos = 0x36, shape = 0x40 ,Y pos = 2
	str		r0,[r4]			;drawing missiles icon
	add		r4,4h
	ldr		r0,=0x4070		; 0x40 = pal, 0x70 = tile number
	str		r0,[r4]
	add		r4,4h
@@DrawSupers:
	ldrb	r0,[r3,4h]
	cmp		r0,0h
	beq		@@DrawPBs
	add		r2,1h
	ldr		r0,=0x40504002  ; size and flips = 0x40, X pos = 0x50, shape = 0x40 ,Y pos = 2
	str		r0,[r4]			;drawing Supers icon
	add		r4,4h
	ldr		r0,=0x4074		; 0x40 = pal, 0x74 = tile number 
	str		r0,[r4]
	add		r4,4h
@@DrawPBs:
	ldrb	r0,[r3,5h]
	cmp		r0,0h
	beq		@@DrawMap
	add		r2,1h
	ldr		r0,=0x406A4002  ; size and flips = 0x40, X pos = 0x6A, shape = 0x40 ,Y pos = 2
	str		r0,[r4]			;drawing power bomb icon
	add		r4,4h
	ldr		r0,=0x4058		; 0x40 = pal, 0x58 = tile number 
	str		r0,[r4]
	add		r4,4h
@@DrawMap:
	ldr		r0,=0x00DE000A  ; size and flips = 0, X pos = 0xDE, shape = 0 ,Y pos = 0xA
	str		r0,[r4]			;drawing blinking map square
	add		r4,4h
	ldr		r0,=OneByteFrameCounter
	ldrb	r0,[r0]
	mov		r1,8h
	and		r0,r1
	cmp		r0,0h
	beq		@@BlinkOff
	ldr		r0,=0x50BF		 ;0x50 = pal, 0xBF = tile number
	b 		@@DrawBlinkingTile
.pool
@@BlinkOff:
	ldr		r0,=0x5140 ;0x5 = pal, 0x140 = tile number
@@DrawBlinkingTile:
	str		r0,[r4]	
	add		r4,4h
	ldr		r0,=0x80D600FA  ; size and flips = 0x80, X pos = 0xD6, shape = 0 ,Y pos = 0xFA
	str		r0,[r4]			;drawing mini-map icon
	add		r4,4h
	ldr		r0,=0x50DC		; 0x50 = pal, 0xDC = tile number 
	str		r0,[r4]
	add		r2,2h
@@Return:
	ldr		r0,=NextOAMSlot
	strb	r2,[r0]
	pop		r4
	bx		r14
.pool

.close