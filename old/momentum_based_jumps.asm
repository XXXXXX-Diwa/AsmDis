.gba
.open "zm.gba","jump.gba",0x8000000

.org 0x8006A36
    mov r0,8h            ;Disables spinjump while moving left or right
.org 0x8008E64
    mov r0,8h           ;Disables midair-turning-spinjump

.org 0x8008D4C           ;hijack
    bl Timer
    mov r0,0Ch ;my code starts
    strb r0,[r4]
    strb r1,[r4,1Dh]
    strb r1,[r4,1Ch]
    b 8008DEAh
    lsl r0,r0,0h
    asr r4,r7,0Dh
    lsl r0,r0,0Ch
    mov r6,0h
    ldr r5,=3001588h
    mov r0,r5
    mov r1,0h ;my code ends

.pool
.org 0x8006BBC

    mov r0,8h            ;Disables initial spinjump pose

.org 0x8005FD4        ;Double Jump routine run every frame
    bl Reset
.org 0x8008F68		;ran when space jumping
    b 8008FE6h		;disables spacejumping set

.org 0x8043DF0            ;Croco AI, Unused

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
	mov r0,0Ch
	strb r0,[r4]
	pop r1
	bx r14
    
.pool
.close
