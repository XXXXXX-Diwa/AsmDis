;|
;|ANGLE RELATED
;|


AngleCheck:
	ldrh r1,[r2]		;button input
	ldrb r0,[r4]
	cmp r0,1h		;checks if Samus is standing still
	bne @@LCheck
	ldr r0,=300h		;only checked if Samus is idle 	
	mov r7,r0		;checks L + R
	and r0,r1
	cmp r0,r7
	beq @@NoAngle
@@Lcheck:
	ldr r0,=200h		;L
	and r1,r0
	mov r7,r1		;used for a rountine later 
	cmp r1,r0
	beq @@Lpressed
	ldr r0,=300168Ch
	ldrh r1,[r2]
	bx r14
@@LPressed:
	ldr r0,=80079BAh
	mov r15,r0
@@NoAngle:
	ldr r0,=8007AFCh	;makes the arm cannon not angled if R & L pressed is true
	mov r15,r0
.pool

RLCheck:
	push r4	
	ldr r0,=300h		;checks if L + R is pressed
	mov r4,r1
	and r1,r0
	cmp r1,r0
	bne @@Return
	pop r4
	ldr r0,=800C593h	;used to check where the code was run from
	mov r1,r14
	cmp r0,r1
	beq @@C58E_Return
	ldr r0,=8007C82h	
	mov r15,r0
@@C58E_Return:
	ldr r0,=800C59Ch
	mov r15,r0
@@Return:
	mov r0,40h		;return if R + L isn't pressed
	and r0,r4
	pop r4
	bx r14



SwitchWeapons:
	mov r5,r2
	mov r2,0h		;used to check to not play switch sound
	cmp r0,0h
	beq @@Missile
	cmp r0,1h
	beq @@Super
	b @@PowerBomb		;checks which item to arm
@@Missile:
	ldrh r0,[r5,8h]
	cmp r0,0h		;checks if missile count is 0
	beq @@PreSuper
	mov r0,0h
	mov r1,1h
	strb r1,[r4,2h]
	strb r0,[r4,3h]
	mov r0,0h		;turns on missiles
	b @@Return
@@PreSuper:
	add r2,1h
@@Super:
	ldrb r0,[r5,0Ah]
	cmp r0,0h		;checks if super missile count is 0	
	beq @@PrePB
	mov r0,1h
	mov r1,2h
	strb r1,[r4,2h]
	strb r0,[r4,3h]
	mov r0,0h		;turns on Supers
	b @@Return
@@PrePB:
	add r2,1h
@@PowerBomb:
	ldrb r0,[r5,0Bh]
	cmp r0,0h		;checks if PB count is 0	
	beq @@Off
	mov r0,2h
	mov r1,4h
	strb r1,[r4,2h]
	strb r0,[r4,3h]
	mov r0,0h		;turns on PBs
	b @@Return
@@Off:
	add r2,1h
	mov r0,1h		;return value to unarm all ammo based weapons
@@Return:
	bx r14



.pool