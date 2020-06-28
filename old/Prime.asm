.gba
.open "zm.gba","MP.gba",0x8000000

.org 0x8006A36
    mov r0,8h            ;Disables spinjump while moving left or right
.org 0x8008E64
    mov r0,8h           ;Disables midair-turning-spinjump
.org 0x8008EEC
    mov r0,8h            ;Disables spinjump
.org 0x8008D4C
    bl Timer             ;Disables respin, also double jump hijack
.org 0x8006BBC
    mov r0,8h            ;Disables initial spinjump pose
.org 0x80088B6
	mov r0,2h            ;Disables turn-crouch when speedboosting
.org 0x8008C88
	b 8008CF2h           ;Disables shinespark
.org 0x8009522
    mov r0,1h            ;Makes Samus stand up after unmorphing
.org 0x800879E
    b 80087ACh            ;makes crouch sound not play
.org 0x80087CE
    bl NoCrouch
.org 0x8005FD4        ;Double Jump routine run every frame
    bl Reset



.org 0x8043DF0            ;Croco AI, Unused
NoCrouch:    
    ldr r0,=300153Fh    ;Samus' active items
    ldrb r0,[r0]
    mov r1,40h
    and r0,r1
    cmp r0,0h            ;Checking for Morphball
    beq @@NoMorph
    mov r0,10h            ;If morphball is on, puts player in morph
    b @@CrouchReturn

@@NoMorph:
    mov r0,1h            ;If morphball is off, player stays in standing pose

@@CrouchReturn:
    ldr r1,=8008816h    ;Return to an overwritten branch
    mov r15,r1

Reset:
	ldr r0,=30013D4h	;Samus Current pose
	ldrb r0,[r0,1h]
	cmp r0,2h
	beq @@Return
	ldr r2,=3001530h	
	mov r0,0h		
	strb r0,[r2,1Fh]	;Resets timer if not in air

@@Return:
	ldrb r1,[r2,0Fh]
	bx r14	
	
Timer:
	push r1
	ldr r0,=3001530h	
	ldrb r1,[r0,0Fh]	;Checking for spacejump
	mov r7,4h
	and r7,r1
	cmp r7,0h
	beq @@NoJump
	ldrb r1,[r0,1Fh]	;Unused RAM? Used for jump timer
	cmp r1,1h		;Change 1h to allow for more jumps. I.E. 5h = 5 extra jumps ect.
	beq @@NoJump		;branches if max ammount of jumps is met
	add r1,1h
	strb r1,[r0,1Fh]	;adds 1 to jump timer
	b @@JumpReturn
@@NoJump:
	pop r1
 	bx r14
@@JumpReturn:
        mov r1,0C0h
        strh r1,[r4,18h]
	pop r1
	bx r14
    
.pool
.close
