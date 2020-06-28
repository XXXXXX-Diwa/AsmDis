.gba
.open "zm.gba","speedmanball.gba",0x8000000

.definelabel Equipment,0x3001530
.definelabel ButtonInput,0x300137C
.definelabel SamusData,0x30013D4
.definelabel CollisionTypes,0x02002000
.definelabel RoomWidth,0x30000B8
.definelabel DecompClipdata,0x2027800

.org 0x80077C8
	bl Speed
;.org 0x8007398
	;b 80073B8h	;disables diagonal spark

.org 0x8304680      ;CrocoAI Unused
Speed:
	push	r2
	ldr 	r1,=Equipment
	ldr 	r3,=ButtonInput
	ldr 	r4,=SamusData
	mov 	r7,r0
	ldrb	r0,[r4]
	cmp 	r0,22h		;checks if shinesparking
	beq 	@@SparkType
	cmp 	r0,26h		;checks if ballsparking
	beq 	@@SparkType1
	b 		@@Return
.pool
@@SparkType:
	ldrh 	r0,[r4,4h]
	cmp 	r0,0h				;checks for upwards Shinespark
	beq 	@@Return
	b 		@@CheckInput

@@SparkType1:
	ldrh 	r0,[r4,4h]
	cmp 	r0,0h				;checks for upwards Shinespark
	beq 	@@Return
	b 		@@CheckInput1

@@CheckInput:
	ldrh 	r0,[r3]
	mov 	r1,1h
	and 	r1,r0
	cmp 	r1,0h				;checks if just up is being pressed
	bne 	@@MoveUp
	b 		@@Return

@@CheckInput1:
	ldrh 	r0,[r3]
	mov 	r1,80h
	and 	r1,r0
	cmp 	r1,80h				;checks if down is being pressed
	beq 	@@MoveDown
	mov 	r1,1h
	and 	r1,r0
	cmp 	r1,0h				;checks if just up is being pressed
	bne 	@@MoveUp1
	b 		@@Return

@@MoveUp:					;moves player upwards but doesnt start up spark
	ldrh	r1,[r4,14h]	
	sub	 	r1,09h
	strh	r1,[r4,14h]	;Changes Y position, makes it move player Upwards
	b	 	@@Return

@@MoveUp1:					;moves player upwards but doesnt start up spark
	ldrh	r1,[r4,14h]	
	sub	 	r1,2h
	strh	r1,[r4,14h]	;Changes Y position, makes it move player Upwards
	b	 	@@Return

@@MoveDown:					;moves player down 
	ldrh	r0,[r4,14h]		;Y pos
	ldrh	r1,[r4,12h]		;X pos
	add		r1,0Ah				;set values to same value on the line marked with **
	lsr 	r0,r0,6 
	mov		r3,r0
	lsr 	r1,r1,6        
	ldr 	r2,=RoomWidth
	ldrh 	r2,[r2]        
	mul 	r2,r0
	add 	r2,r2,r1
	lsl 	r2,r2,1
	ldr     r0,=DecompClipdata
	add     r1,r0,r2
	ldrh    r0,[r1]			;clipdata under Samus
	ldr		r2,=CollisionTypes
	add		r0,r2,r0
	ldrb	r0,[r0]
	cmp		r0,1h				;checks for solid blocks under Samus
	beq	@@SetBoost
	cmp		r0,0Ch				;checks for platform block under Samus
	beq	@@SetBoost
	ldrh	r1,[r4,14h]
	add		r1,0Ah		;**
	strh	r1,[r4,14h]		;Changes Y position, makes it move player downwards
	b	 @@Return
.pool
@@SetBoost:
	ldrb	r0,[r4]
	;cmp	r0,22h
	;beq	@@NotBall
	mov	r0,12h
	;b	@@Store
;@@NotBall:
	;mov 	r0,0h
;@@Store:
	strb 	r0,[r4]		;pose
	strb	r0,[r4,1h]	;standing flag
	strb	r0,[r4,4h]	;spark angle/bouncing flag
	mov		r0,0A0h
	strb	r0,[r4,0Ah]	;speedboost timer
	lsl		r3,r3,6
	sub		r3,1		;puts Samus on top of block
	strh	r3,[r4,14h]
@@Return:
	pop 	r2
	mov 	r0,r4
	ldr		r1,=3001588h
	bx 		r14
.pool
.close