.gba
.open "zm.gba","ProjectileSpeed.gba",0x8000000
.definelabel CurrentPose,0x030013D4
; Supers
.org 0x8051D6A 
    bl      AddSpeeds  
.org 0x8051d18
    bl      AddSpeeds  

; Pistol
.org 0x805136E 
    bl      AddSpeeds  
.org 0x80513AA
    bl      AddSpeeds  

; Charged Pistol
.org 0x8051A96 
    bl      AddSpeeds  
.org 0x8051ADE
    bl      AddSpeeds  

; short
.org 0x8050B7E 
    bl      AddSpeeds  
.org 0x8050BBA
    bl      AddSpeeds  

; charged short
.org 0x805145A  
    bl      AddSpeeds  
.org 0x8051496
    bl      AddSpeeds  

; Charged Long
.org 0x8051552  
    bl      AddSpeeds  
.org 0x805159A 
    bl      AddSpeeds  

; Ice
.org 0x8050DBA 
    bl      AddSpeeds  
.org 0x8050D62
    bl      AddSpeeds  

; Charged Ice
.org 0x805164A 
    bl      AddSpeeds  
.org 0x80516B2
    bl      AddSpeeds  

 ; Wave
.org 0x8051078
    bl      AddSpeeds  
.org 0x80510B4
    bl      AddSpeeds  

; Charged Wave
.org 0x8051774 
    bl      AddSpeeds  
.org 0x80517BE
    bl      AddSpeeds  

; Plasma
.org 0x80511E2
    bl      AddSpeeds  
.org 0x8051224
    bl      AddSpeeds  

; Charged Plasma
.org 0x80518EA
    bl      AddSpeeds  
.org 0x805194A
    bl      AddSpeeds  

; Long beam Speed
.org 0x8050C76        
    bl      AddSpeeds
.org 0x8050CB2
	bl      AddSpeeds

;Missile Speed
.org 0x8051BC8
	bl      AddSpeeds
.org 0x8051C1A
	bl      AddSpeeds

.org 0x8304054		;8043DF0 ; Unused Crocomire AI
AddSpeeds:
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
	add 	r0,13h
	ldrb 	r0,[r0]
	add 	r0,0Ch
	mov 	r1,r0
	b		EndofCode
Missile:
	mov 	r0,r4
	add 	r0,13h
	ldrb 	r0,[r0]
	add 	r0,8h
	mov 	r1,r0
	b 		EndofCode
EndofCode:
	mov 	r0,r4
	bx 		r14
.pool

.org 0x804F9E4
	mov 	r0,r4
	ldrh	r0,[r0,2h]
.close