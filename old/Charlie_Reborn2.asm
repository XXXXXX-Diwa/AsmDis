.gba
.open "zm.gba","Chozo_Reborn.gba",0x8000000
.definelabel CharlieHealth,0x100		;Charlie's health, make higher than all damage thresholds
.definelabel SetNewSong,0x80039F4
.definelabel PlaySound,0x8002A18
.definelabel LockDoors,0x0300007B
.definelabel PrimarySpriteStats,0x82B0D68	
;//Charlie can be fought like a normal boss, and is actually quite difficult

.org PrimarySpriteStats + 0x6D * 0x12
    .halfword CharlieHealth; health
	
.org 0x8038D7E
	bl NewAI
	b	8038DEAh
.org 0x803908A				;disables forced pose and movement lock
	b 803909Ah
.org 0x803972A
	mov r2,0h
	strb r2,[r1]			;kills sprite
	mov r0,19h			;song after fight
	mov r1,0h
	bl SetNewSong
	bl UnlockDoor			;makes event set
.org 0x8039758
	b 803975Eh			;skips cutscenes
.org 0x8039026				
	bl SetHealth
.org 0x8038D9A				;nops a part of his AI that sets a new health value again			
	nop
	nop



.org 0x8304054				; Crocomire graphics
SetHealth:				;sets Charilie's health 
	push	r2
	ldr     r2,=PrimarySpriteStats
	ldrb    r1,[r7,1Dh]		;sprite ID                             
	lsl     r0,r1,3h                                
	add     r0,r0,r1                                
	lsl     r0,r0,1h                                
	add     r0,r0,r2                                
	ldrh    r0,[r0]			;r0 = health
	strh	r0,[r7,14h]
	pop		r2
	bx r14 
	

NewAI:
	mov		r1,7Fh			;removes 80 froms tun flag caused by Power bombs
	and		r0,r1
	strb	r0,[r5]
	ldr     r2,=PrimarySpriteStats
	ldrb    r1,[r4,1Dh]		;sprite ID                             
	lsl     r0,r1,3h                                
	add     r0,r0,r1                                
	lsl     r0,r0,1h                                
	add     r0,r0,r2                                
	ldrh    r0,[r0]			;r0 = health
	ldrh	r2,[r4,14h]		;charlie curr health
	ldr 	r1,=3000716h		;charlie phase counter
	ldrb	r1,[r1]
	cmp		r1,0h
	bgt		@@PhaseChecks
	cmp		r2,r0			;if damaged at all, advance phase
	blt		@@True
	b		@@Return
@@PhaseChecks:
	cmp		r0,1h
	bne		@@NextCheck
	sub		r2,r0,r2
	cmp		r2,19h			;if 25+ damage dealt, advance phase
	bgt		@@True
	b		@@Return
@@NextCheck:
	cmp		r0,2h
	bne		@@Final
	sub		r2,r0,r2
	cmp		r2,32h			;after 50+ damage, advance phase
	bgt		@@True
	b		@@Return
@@Final:
	sub		r2,r0,r2
	cmp		r2,64h			;after 100+ damage, defeated
	bgt		@@True
	b		@@Return
@@True:
	strh	r0,[r4,14h]		;restores health of charlie
	ldr		r0,=8038D84h
	mov		r15,r0
@@Return:
	bx		r14
	
	
UnlockDoor:
	push r1
	ldr r0,=LockDoors
	mov r1,20h
	neg	r1,r1
	strb r1,[r0]
	pop r1
	bx r14	
.pool		
.close