.gba
.open "zm.gba","Chozo_Reborn.gba",0x8000000
.definelabel CharlieHealth,0x256	;Charlie's health. I suggest this be a multiple of 4, match health in MAGE
.definelabel SetNewSong,0x80039F4
.definelabel PlaySound,0x8002A18
;//Charlie can be fought like a normal boss, and is actually quite difficult
;//There are 4 phases, 2 of which can be skipped if the player is allowed to kill him quick enough



.org 0x8038D7E
	bl NewAI
.org 0x8038DA0
	bl FixPose
.org 0x803908A				;disables forced pose and movement lock
	b 803909Ah
;.org 0x803972A
	;mov r2,0h
	;strb r2,[r1]			;kills sprite
	;mov r0,19h			;song after fight
	;mov r1,0h
	;bl SetNewSong
	;b 803973Ch			;makes event set
;.org 0x8039758
	;b 803975Eh			;skips cutscenes
.org 0x8039026				
	bl SetHealth
.org 0x8038D9A				;nops a stupid part of his AI that sets a new health value again			
	nop
	nop
.org 0x803A024				;prevents softlock
	.word 0x803A078




.org 0x8304B12				; Crocomire graphics
SetHealth:				;sets Charilie's health and stores his "previous health" value
	ldr r0,=CharlieHealth
	strh r0,[r7,14h]
	ldr r1,=30007B0h
	strh r0,[r1]
	bx r14 
	

NewAI:
	push r3-r5
	ldr r5,=30007B0h		;charlie's previous health
	ldrh r1,[r5]
	ldrh r2,[r4,14h]
	cmp r2,r1
	beq @@Return
	strh r2,[r5]
	ldr r0,=1D9h
	bl PlaySound
	ldr r0,=CharlieHealth
	ldrh r1,[r4,14h]		;current health
	ldr r3,=3000716h		;charlie phase counter
	cmp r1,0h
	beq @@Dead
	ldrb r3,[r3]
	cmp r3,0h			;starts phase 1 on first sign of damage
	beq @@Phase1Check
	lsr r2,r0,2h			;checks if 3/4th of health
	sub r2,r0,r2
	cmp r1,r2
	bgt @@Return			;otherwise continue with phase 1
	lsr r2,r0,1h			;checks for half health
	cmp r1,r2
	bgt @@Phase2Check
@@Phase3Check:
	cmp r3,2h
	beq @@PhaseChange
	b @@Return
@@Phase2Check:
	cmp r3,1h
	beq @@PhaseChange
	b @@Return
@@Phase1Check:
	cmp r3,0h
	beq @@PhaseChange
	b @@Return
@@Dead:
	ldrh r0,[r3]
	cmp r0,0h
	beq @@CantKill		;adds 1 health to prevent softlock when insta-killing boss...it's hacky, but it works
	mov r0,3h
	strh r0,[r3]
	b @@PhaseChange
@@CantKill:
	add r1,1h
	strh r1,[r4,14h]
	strh r1,[r5]
@@PhaseChange:			;only returns here when changing phase
	pop r3-r5
	ldr r0,=8038D8Ah
	mov r15,r0
@@Return:			;returns here otherwise
	pop r3-r5
	ldr r1,=8038DeCh
	mov r15,r1
	
FixPose:			;routine fixes issues cause by killing the boss before all 4 phases were executed
	push r1,r2		;this forces all four phases to happen no matter what to prevent softlock
	ldrh r0,[r3,0Ah]
	add r0,1h
	ldr r1,=PoseTable
	mov r2,0h
@@Loop:
	add r2,1h
	cmp r2,r0
	blt @@Loop
	add r1,r1,r0
	ldrb r1,[r1]
	mov r2,r4
	add r2,24h
	strb r1,[r2]
	pop r1,r2
	bx r14
PoseTable:
	.byte 0x0
	.byte 0x9
	.byte 0x23
	.byte 0x25
	.byte 0x67
.pool				
.close