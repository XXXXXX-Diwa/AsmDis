.gba
.open "zm.gba","zmphysic.gba",0x8000000

.definelabel ButtonInput,0x300137C
.definelabel SamusData,0x30013D4
.definelabel SamusDataCopy,0x30013F4
.definelabel ScrewAttackFlag,0x3001528

.definelabel WrapperR2,0x808AC00

;FIX BOMBA

;Speedball jumping 
.org 0x8006B48
	.halfword 0xE002
.org 0x80095D0
	.byte	0x6A

;part of keeping speed when landing from a jump
.org 0x8006E50
	.byte 0

.org 0x8007504	;preserves value used to check reset condition
	nop	
.org 0x80075BE ;slightly rewrites original function to have a hijack
	ldr		r2,=BetterPhysic + 1
	bl		WrapperR2
	cmp		r1,0h
	beq		@@Return
	mov		r1,r2     
	ldmia   [r1]!,r4-r6 
	stmia   [r0]!,r4-r6 
	ldmia   [r1]!,r4-r6 
	stmia   [r0]!,r4-r6 
	ldmia   [r1]!,r4,r5 
	stmia   [r0]!,r4,r5 
	ldrb    r0,[r2,3h]  
	cmp     r0,0h       
	beq     @@ResetFlags    
	ldrh    r0,[r2,0Eh] 
	mov    	r1,30h      
	eor    	r0,r1       
	mov    	r1,0h       
	strh    r0,[r2,0Eh] 
	strb    r1,[r2,3h]
@@ResetFlags:	
	mov    	r0,0h       
	strb    r0,[r2,2h]  
	strb    r0,[r2,4h]  
	strb    r0,[r2,5h]  
	strb    r0,[r2,7h]  
	strb    r0,[r2,0Ah] 
	mov    	r1,0h       
	strh    r0,[r2,0Ch] 
	strh    r0,[r2,10h] 
	strh    r0,[r2,16h] 
	strh    r0,[r2,18h] 
	strb    r1,[r2,1Ch] 
	strb    r1,[r2,1Dh] 
	ldrb    r0,[r2,8h]  
	cmp     r0,0B4h     
	beq     @@ZeroFlags   
	strb    r1,[r3]
@@ZeroFlags:	
	strb    r1,[r3,1h]  
	strb    r1,[r3,2h]
@@Return:	
	pop     r4-r6       
	pop     r0          
	bx      r0 
.pool



.org 0x8760D40
BetterPhysic:
	push	r14
	mov		r1,r0
	ldr		r0,=SamusDataCopy
	ldr		r2,=SamusData
	ldr		r3,=ScrewAttackFlag
	cmp		r1,4h
	beq		@@Landing
	cmp		r1,7h
	beq 	@@Landing
	cmp		r1,18h
	beq		@@Landing
	cmp		r1,19h
	beq		@@Landing
	cmp		r1,0Fh
	beq		@@MAMorph
	cmp		r1,1Bh
	bne		@@Return1
@@MAMorph:
	bl		MidAirMorph
	b		@@Return
@@Landing:
	bl		Land
	b		@@Return
@@Return1:
	mov		r1,1h
@@Return:
	pop		r5
	bx		r5
.pool

Land:			;prevents X speed reset when landing
	ldr		r1,=ButtonInput
	ldrh	r1,[r1]
	ldrb	r4,[r2,0Eh]
	and		r1,r4
	cmp		r1,r4
	bne		@@Fail   ;checks if direction held and direction facing is the same
	ldrb	r1,[r2]
	cmp		r1,22h
	beq		@@Fail
	cmp		r1,26h
	beq		@@Fail
	ldrb	r1,[r2,5h]
	cmp		r1,1h		;speedboost flag
	bne		@@Next
	mov		r1,0A0h		;should be max speedboost value
	strb	r1,[r2,0Ah]	;sets speedboost timer to max (speedboost will restart otherwise)
@@Next:
	mov		r1,r2
	ldmia   [r1]!,r4-r6 
	stmia   [r0]!,r4-r6 
	ldmia   [r1]!,r4-r6 
	stmia   [r0]!,r4-r6 
	ldmia   [r1]!,r4,r5 
	stmia   [r0]!,r4,r5 
	ldrb    r0,[r2,3h]  
	cmp     r0,0h       
	beq     @@ResetFlags    
	ldrh    r0,[r2,0Eh] 
	mov    	r1,30h      
	eor    	r0,r1       
	mov    	r1,0h       
	strh    r0,[r2,0Eh] 
	strb    r1,[r2,3h]
@@ResetFlags:	
	mov    	r0,0h       
	strb    r0,[r2,2h]  
	strb    r0,[r2,4h]    
	strb    r0,[r2,7h]  
	mov    	r1,0h       
	strh    r0,[r2,0Ch] 
	strh    r0,[r2,10h] 
	strh    r0,[r2,18h] 
	strb    r1,[r2,1Ch] 
	strb    r1,[r2,1Dh] 
	ldrb    r0,[r2,8h]  
	cmp     r0,0B4h     
	beq     @@ZeroFlags   
	strb    r1,[r3]
@@ZeroFlags:	
	strb    r1,[r3,1h]  
	strb    r1,[r3,2h]
	b 		@@Return
@@Fail:
	mov		r1,1h ;fail flag
@@Return:	
	bx		r14
.pool

MidAirMorph:    ;prevents Y and X velocity and speedboost flag reset when midair morph/unmorphing
	mov		r1,r2     
	ldmia   [r1]!,r4-r6 
	stmia   [r0]!,r4-r6 
	ldmia   [r1]!,r4-r6 
	stmia   [r0]!,r4-r6 
	ldmia   [r1]!,r4,r5 
	stmia   [r0]!,r4,r5 
	ldrb    r0,[r2,3h]  
	cmp     r0,0h       
	beq     @@ResetFlags    
	ldrh    r0,[r2,0Eh] 
	mov    	r1,30h      
	eor    	r0,r1       
	mov    	r1,0h       
	strh    r0,[r2,0Eh] 
	strb    r1,[r2,3h]
@@ResetFlags:	
	mov    	r0,0h       
	strb    r0,[r2,2h]  
	strb    r0,[r2,4h]    
	strb    r0,[r2,7h]  
	strb    r0,[r2,0Ah] 
	mov    	r1,0h       
	strh    r0,[r2,0Ch] 
	strh    r0,[r2,10h]  
	strb    r1,[r2,1Ch] 
	strb    r1,[r2,1Dh] 
	ldrb    r0,[r2,8h]  
	cmp     r0,0B4h     
	beq     @@Return   
	strb    r1,[r3]
@@Return:	
	strb    r1,[r3,1h]  
	strb    r1,[r3,2h]
	bx     	r14
      
.close