.gba
.open "zm.gba","SparkSteeringV1.gba",0x8000000

.definelabel Equipment,0x3001530
.definelabel SamusData,0x30013D4
.definelabel ButtonInput,0x300137C

;.org 0x80104D6
.org 0x80077C8
	bl Speed
.org 0x8007398
	b 80073B8h	;disables diagonal spark

;this version of steering allows one to resume speedboosting when hitting a solid floor

.org 0x8043DF0	;CrocoAI Unused
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
	beq 	@@SparkType
	b 		@@Return
.pool
@@SparkType:
	ldrh 	r0,[r4,4h]
	cmp 	r0,0h				;checks for upwards Shinespark
	beq 	@@Return
	b 		@@CheckInput

@@CheckInput:
	ldrh 	r0,[r3]
	mov 	r1,80h
	and 	r1,r0
	cmp 	r1,80h				;checks if down is being pressed
	beq 	@@MoveDown
	mov 	r1,40h
	and 	r1,r0
	cmp 	r1,0h				;checks if just up is being pressed
	bne 	@@MoveUp
	b 		@@Return

@@MoveUp:					;moves player upwards but doesnt start up spark
	ldrh	r1,[r4,14h]	
	sub	 	r1,4h
	strh	r1,[r4,14h]	;Changes Y position, makes it move player Upwards
	b	 	@@Return
	
@@MoveDown:					;moves player down 
	ldrh	r1,[r4,14h]
	add		r1,4h		
	strh	r1,[r4,14h]		;Changes Y position, makes it move player downwards

@@Return:
	pop 	r2
	mov 	r0,r4
	ldr		r1,=3001588h
	bx 		r14
.pool
.close