.gba
.open "zm.gba","MP2.gba",0x8000000

.org 0x8006A36
    mov r0,8h            ;Disables spinjump while moving left or right
.org 0x8008E64
    mov r0,8h           ;Disables midair-turning-spinjump
;.org 0x8008EEC
   ; mov r0,8h            ;Disables spinjump
.org 0x8008D4C
    bl Timer             ;Disables respin, also double jump hijack
.org 0x8006BBC
    mov r0,8h            ;Disables initial spinjump pose
.org 0x80077AC        	 ;Reset routine run every frame
    bl Reset
.org 0x8008F68		;ran when space jumping
    bl Timer2		;makes it so you can do 5 screw attack jumps after the initial double jump

.org 0x8043DF0            ;Croco AI, Unused

Reset:
	push r0
	ldrb r0,[r4,1h]
	cmp r0,2h
	beq @@Return
	ldr r1,=3001530h	
	mov r0,0h		
	strb r0,[r1,1Fh]	;Resets timer if not in air

@@Return:
	pop r0
	add r0,1h
	strb r0,[r4,1Ch]
	bx r14	
	
Timer:
	push r1
	ldr r0,=3001530h	
	ldrb r1,[r0,0Fh]	;Checking for spacejump
	mov r7,4h		;Space jump value on this line
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
    	ldrb r0,[r0,0Fh]
    	mov r1,8h 		;screw attack value, checking for screw attack on this line
    	and r0,r1
        cmp r0,0h
        beq @@NoScrewAttack 	;if you don't have the screw attack it will branch and wont let you have extra jumps
	mov r1,0C0h 
        strh r1,[r4,18h] 	;this line and the line bellow is what makes the extra jumps work. without them you fall 
	mov r0,0Ch
	strb r0,[r4]
	pop r1
 	bx r14

@@NoScrewAttack:
	pop r1
 	bx r14
        
@@JumpReturn:
        mov r1,0C0h 
        strh r1,[r4,18h] 
	pop r1 
	bx r14 



Timer2: ;this exists to make a double jump possible before the screw attack jumps. this one checks for screw attack
	push r1
	ldr r0,=3001530h	
	ldrb r1,[r0,0Fh]	;Checking for screwattack
	mov r7,8h
	and r7,r1
	cmp r7,0h
	beq @@NoJump
	ldrb r1,[r0,1Fh]	;Unused RAM? Used for jump timer
	cmp r1,5h		;Change 1h to allow for more jumps. I.E. 5h = 5 extra jumps ect.
	beq @@NoJump		;branches if max ammount of jumps is met
	add r1,1h
	strb r1,[r0,1Fh]	;adds 1 to jump timer
	b @@JumpReturn
@@NoJump:
	pop r1
 	bx r14
@@JumpReturn: ;this allows more jumps with the screw attack one, the other jump return is not the same
        mov r1,0C0h
        strh r1,[r4,18h]
	mov r0,0Ch
	strb r0,[r4]
	pop r1
	bx r14
    
.pool
.close
