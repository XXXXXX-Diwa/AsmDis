.gba
.open "zm.gba","missilecontrol.gba",0x8000000
.definelabel CurrentPose,0x030013D4

.org 0x8304CE8
ImNotAWrapper:
	ldr		r0,=AddSpeeds
	mov		r15,r0
.pool

.org 0x804F9E4
	mov 	r0,r4
	ldrh	r0,[r0,2h]

; Supers
.org 0x8051D6A 
    bl      ImNotAWrapper  
.org 0x8051d18
    bl      ImNotAWrapper  

; Pistol
.org 0x805136E 
    bl      ImNotAWrapper  
.org 0x80513AA
    bl      ImNotAWrapper  

; Charged Pistol
.org 0x8051A96 
    bl      ImNotAWrapper  
.org 0x8051ADE
    bl      ImNotAWrapper  

; short
.org 0x8050B7E 
    bl      ImNotAWrapper  
.org 0x8050BBA
    bl      ImNotAWrapper  

; charged short
.org 0x805145A  
    bl      ImNotAWrapper  
.org 0x8051496
    bl      ImNotAWrapper  

; Charged Long
.org 0x8051552  
    bl      ImNotAWrapper  
.org 0x805159A 
    bl      ImNotAWrapper  

; Ice
.org 0x8050DBA 
    bl      ImNotAWrapper  
.org 0x8050D62
    bl      ImNotAWrapper  

; Charged Ice
.org 0x805164A 
    bl      ImNotAWrapper  
.org 0x80516B2
    bl      ImNotAWrapper  

 ; Wave
.org 0x8051078
    bl      ImNotAWrapper  
.org 0x80510B4
    bl      ImNotAWrapper  

; Charged Wave
.org 0x8051774 
    bl      ImNotAWrapper  
.org 0x80517BE
    bl      ImNotAWrapper  

; Plasma
.org 0x80511E2
    bl      ImNotAWrapper  
.org 0x8051224
    bl      ImNotAWrapper  

; Charged Plasma
.org 0x80518EA
    bl      ImNotAWrapper  
.org 0x805194A
    bl      ImNotAWrapper  

; Long beam Speed
.org 0x8050C76        
    bl      ImNotAWrapper
.org 0x8050CB2
	bl      ImNotAWrapper

;Missile Speed
.org 0x8051BC8
	bl      ImNotAWrapper
.org 0x8051C1A
	bl      ImNotAWrapper

.org 0x08760E50		;8043DF0 ; Unused Crocomire AI
AddSpeeds:
	push	r14

	mov 	r0,r4
	add 	r0,13h
	ldrb 	r0,[r0]
	cmp 	r0,2h
	bhi 	ResetReturn 	; Projectile initializing


; Add samus velocity to speed
	ldr     r0,=CurrentPose ;
    ldrh    r2,[r0,16h]     ;|
	add		r1,r4,2h		; Store Velocity to Projectile0 +0x2
    strh    r2,[r1]
	b		ResetReturn


ResetReturn:


;Get Base Speed for each ProjType
	mov 	r0,r4				
	add 	r0,0Fh
	ldrb 	r0,[r0]
	cmp 	r0,00h	; if short beam
	beq		ShortBeam
	cmp 	r0,01h	
	beq 	LongBeam  ; 1 for long beam
	cmp 	r0,02h	; for ice
	beq		IceBeam
	cmp 	r0,03h	; for wave
	beq		WaveBeam
	cmp 	r0,04	; if plasma
	beq		PlasmaBeam
	cmp 	r0,05h	; if pistol
	beq		Pistol
	cmp 	r0,06h	; if charged short
	beq		ChargedShort
	cmp 	r0,07h	; if charged long
	beq		ChargedLong
	cmp 	r0,08h	; if charged ice
	beq		ChargedIce
	cmp 	r0,09h	; if charged wave
	beq		ChargedWave
	cmp 	r0,0Ah	; if charged plasma
	beq		ChargedPlasma
	cmp 	r0,0Bh	; if charged pistol
	beq		ChargedPistol
	cmp 	r0,0Ch
	beq 	Missile
	cmp 	r0,0Dh	; if Super missile
	beq		SuperMissile
	b 		EndofCode

ShortBeam:
	mov 	r1,14h
	b 		EndofCode
LongBeam:
	mov 	r1,18h
	b 		EndofCode
IceBeam:
	mov 	r1,1Ah
	b 		EndofCode
WaveBeam:
	mov		r1,18h
	b		EndofCode
PlasmaBeam:
	mov		r1,20h
	b		EndofCode
Pistol:
	mov		r1,16h
	b		EndofCode
ChargedShort:
	mov		r1,14h
	b		EndofCode
ChargedLong:
	mov		r1,18h
	b		EndofCode
ChargedIce:
	mov		r1,1Ah
	b		EndofCode
ChargedWave:
	mov		r1,1Ch
	b		EndofCode
ChargedPlasma:
	mov		r1,20h
	b		EndofCode
ChargedPistol:
	mov		r1,16h
	b		EndofCode
SuperMissile:
	mov 	r0,r4
	bl		control
	cmp		r1,0h
	bne		EndofCode
	add 	r0,13h
	ldrb 	r0,[r0]
	add 	r0,0Ch
	mov 	r1,r0
	b		EndofCode
Missile:
	mov 	r0,r4
	bl		control
	cmp		r1,0h
	bne		EndofCode
	add 	r0,13h
	ldrb 	r0,[r0]
	add 	r0,8h
	mov 	r1,r0
	b 		EndofCode
EndofCode:
	mov 	r0,r4
	pop		r14
	bx 		r14
.pool
;8760f06
control:
	push 	r0,r1
	ldr		r0,=30013F4h
	ldrb	r0,[r0]
	cmp		r0,4h
	bne		@@jumptoreturn

	ldr		r0,=0300137Ch
	ldrh	r0,[r0]
	mov		r1,2h
	and		r1,r0
	cmp		r1,0h
	beq		@@jumptoreturn


	ldr		r0,=30013D4h     ;set pose = 4
	mov		r1,4h
	strb	r1,[r0]
	ldr		r0,=030013D7h
	mov		r1,0h
	strb	r1,[r0]
	ldr		r0,=030013F7h
	strb	r1,[r0]

	
@@notlocked:
	ldrb	r0,[r4]
	mov 	r1,4h
	and 	r1,r0
	cmp 	r1,0h
	beq		@@notupdated
	sub		r0,04h
	strb	r0,[r4]
@@notupdated:


	ldr		r0,=03001380h
	ldrh	r0,[r0]
	mov 	r1,40h
	and		r1,r0
	cmp		r1,0h
	bne		@@up
	mov 	r1,80h
	and		r1,r0
	cmp		r1,0h
	bne		@@down
	ldr		r1,=030013E2h
	ldrb	r1,[r1]
	and		r1,r0
	cmp		r1,0h
	beq		@@returnslowspeed
	b		@@returnslowspeed
@@jumptoreturn:
	b		@@returncontrol
@@up:
	ldrb	r0,[r4,10h]
	cmp		r0,00h
	beq		@@setangleup
	cmp		r0,02h
	beq		@@setstraight
	cmp		r0,01h
	beq		@@setup
	cmp		r0,04h
	beq		@@setangledown
	b		@@returncontrol

@@down:
	ldrb	r0,[r4,10h]
	cmp		r0,00h
	beq		@@setangledown
	cmp		r0,02h
	beq		@@setdown
	cmp		r0,01h
	beq		@@setstraight
	cmp		r0,03h
	beq		@@setangleup
	b		@@returnslowspeed

@@setangledown:
	mov		r0,2h                   ;08326F40 straight
	strb	r0,[r4,10h]             ;08326f58 diagonal
	ldrb	r0,[r4]                 ;08326f70 up
	mov		r1,20h                  ;
	orr		r1,r0                    ;08326F88 straight
	strb	r1,[r4]

	ldrb		r0,[r4,0Fh]
	cmp		r0,0Ch
	beq		@@missileADown
	ldr		r0,=08326FA0h
	b		@@superADown
@@missileADown:								;08326FA0 diag
	ldr		r0,=08326F58h
@@superADown:			            ;08326FB8 vert
	ldr		r1,[r4,4h]
	str		r0,[r4,4h]
	cmp		r0,r1
	bne		@@updategraphics
	b		@@returnslowspeed



@@setdown:
	mov		r0,4h
	strb	r0,[r4,10h]
	ldrb	r0,[r4]
	mov		r1,20h
	orr		r1,r0
	strb	r1,[r4]
	ldrb	r0,[r4,0Fh]
	cmp		r0,0Ch
	beq		@@missiledown
	ldr		r0,=08326FB8h
	b		@@superdown
@@missiledown:
	ldr		r0,=08326f70h
@@superdown:
	ldr		r1,[r4,4h]
	str		r0,[r4,4h]
	cmp		r0,r1
	bne		@@updategraphics
	b		@@returnslowspeed



@@setstraight:
	mov		r0,0h
	strb	r0,[r4,10h]
	ldrb	r0,[r4,0Fh]
	cmp		r0,0Ch
	beq		@@missilestraight
	ldr		r0,=08326F88h
	b		@@superstraight
@@missilestraight:
	ldr		r0,=08326F40h
@@superstraight:
	ldr		r1,[r4,4h]
	str		r0,[r4,4h]
	cmp		r0,r1
	bne		@@updategraphics
	b		@@returnslowspeed



@@setangleup:
	mov		r0,1h
	strb	r0,[r4,10h]
	ldrb	r0,[r4]
	mov 	r1,20h
	and 	r1,r0
	cmp 	r1,0h
	beq		@@angleupreverseflip
	sub		r0,20h
	strb	r0,[r4]
@@angleupreverseflip:

	ldrb	r0,[r4,0Fh]
	cmp		r0,0Ch
	beq		@@missileAUp
	ldr		r0,=08326FA0h
	b		@@superAUp
@@missileAUp:
	ldr		r0,=08326F58h
@@superAUp:
	ldr		r1,[r4,4h]
	str		r0,[r4,4h]
	cmp		r0,r1
	bne		@@updategraphics
	b		@@returnslowspeed



@@setup:
	mov		r0,3h
	strb	r0,[r4,10h]
	ldrb	r0,[r4]
	mov 	r1,20h
	and 	r1,r0
	cmp 	r1,0h
	beq		@@upreverseflip
	sub		r0,20h
	strb	r0,[r4]
@@upreverseflip:

	ldrb	r0,[r4,0Fh]
	cmp		r0,0Ch
	beq		@@missileUp
	ldr		r0,=08326FB8h
	b		@@superUp
@@missileUp:
	ldr		r0,=08326f70h
@@superUp:
	ldr		r1,[r4,4h]
	str		r0,[r4,4h]
	cmp		r0,r1
	bne		@@updategraphics
	b		@@returnslowspeed





@@updategraphics:
	ldrb	r1,[r4]
	mov 	r0,04h
	orr		r0,r1
	strb	r0,[r4]
	b		@@returnslowspeed



@@returncontrol:
	pop		r0,r1
	mov		r1,0h
	bx		r14
@@returnslowspeed:
	pop		r0,r1
	mov		r0,r4
	add 	r0,13h
	ldrb 	r0,[r0]
	add 	r0,8h
	lsr		r1,r0,1h
	bx		r14
.pool



.close