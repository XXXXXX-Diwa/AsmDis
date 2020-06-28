.gba
.open "zm.gba","M1.gba",0x8000000


.org 0x8007AF0
	mov r0,0h	;no upward diagonal aiming by the L button
.org 0x8007C12
	mov r0,0h	;no upward diagonal aiming when running
.org 0x8007C7C
	mov r0,0h	;no upward diagonal aiming when falling
.org 0x8007ADA
	mov r0,0h	;no downward diagonal aiming by L button
.org 0x8007CD0
	mov r0,0h	;no downward diagonal aiming when falling
.org 0x8007C24
	mov r0,0h	;no downward diagonal aiming while running
.org 0x8009522
	mov r0,1h	;Makes Samus stand up after unmorphing
.org 0x800879E
	b 80087ACh	;makes crouch sound not play
.org 0x80087CE
	bl NoCrouch
.org 0x800B496
	bl MissilePalette


.org 0x8043DF0 ; Croco AI, Unused
NoCrouch:	
	ldr r0,=300153Fh	;Samus' active items
	ldrb r0,[r0]
	mov r1,40h
	and r0,r1
	cmp r0,0h		;checking for Morphball
	beq @@NoMorph
	mov r0,10h		;If morphball is on, puts player in morph
	b @@CrouchReturn

@@NoMorph:
	mov r0,1h		;If morphball is off, player stays in standing pose
@@CrouchReturn:
	ldr r1,=8008816h	;return to an overwritten branch
	mov r15,r1

MissilePalette:
	ldr r0,=03001416h	;missile selected
	ldrb r0,[r0]
	cmp r0,0h
	beq @@MissileOff	;checks if no missiles are selected
	ldr r0,=800B600h	;changes palette
	mov r15,r0

@@MissileOff:
	ldr r2,=3001530h	;overwritten things
	ldrb r0,[r2,12h]
	bx r14
	
.pool
.close