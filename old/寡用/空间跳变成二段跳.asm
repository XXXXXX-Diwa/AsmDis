.gba
.open "zm.gba","DoubleJump.gba",0x8000000

.org 0x8005FD4		;routine run every frame
	bl Reset
.org 0x8008F68		;hijack only ran when space jumping
	bl Timer

.org 0x8043DF0	;CrocoAI Unused
Reset:
	ldr r0,=30013D4h	;Samus Current pose
	ldrb r0,[r0]
	cmp r0,0Fh
	beq @@Return 
	cmp r0,0Eh
	beq @@Return		; checks to see if player is currently space jumping
	ldr r2,=3001530h	
	mov r0,0h		
	strb r0,[r2,1Fh]	;Resets timer if not in air/space juming

@@Return:
	bx r14	
	
Timer:
	ldr r0,=3001530h	
	ldrb r1,[r0,1Fh]	;Unused RAM? Used for jump timer
	cmp r1,1h		;Change 1h to allow for more jumps. I.E. 5h = 5 extra jumps ect.
	beq @@NoJump		;branches if max ammount of jumps is met
	add r1,1h
	strb r1,[r0,1Fh]	;adds 1 to jump timer
	b @@JumpReturn
@@NoJump:
	ldr r0,=8008FE6h	;jumps past Y velocity set for space jumping, canceling the jump
	mov r15,r0
@@JumpReturn:	
	mov r0,18h	;overwritten instructions
	ldsh r1,[r4,r0]
	bx r14
.pool
.close