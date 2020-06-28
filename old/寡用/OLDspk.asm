.gba
.open "zm.gba","SparkControl.gba",0x8000000

.org 0x80104D6
	bl Speed
.org 0x8007398
	b 80073B8h	;disables diagonal spark
.org 0x8043DF0	;CrocoAI Unused
Speed:
	ldr r1,=3001530h
	ldr r3,=300137Ch	;button input
	ldr r4,=30013D4h
	mov r7,r0
	ldrb r0,[r4]
	cmp r0,23h		;checks for spark collision
	beq @@ClipFix
	cmp r0,27h		;checks for ballspark collision
	beq @@ClipFix
	cmp r0,22h		;checks if shinesparking
	beq @@SparkType
	cmp r0,26h		;checks if ballsparking
	beq @@SparkType
	mov r0,0h
	strb r0,[r1,1Fh]
	b @@Return

@@SparkType:
	ldrb r0,[r4,4h]
	cmp r0,0h		;checks for upwards Shinespark
	beq @@UpwardSpark
	ldrb r0,[r4,0Eh]
	cmp r0,10h
	beq @@RightSpark
	b @@LeftSpark

@@ClipFix:		;fixes clipping issue when downward diagonal sparking
	ldrb r0,[r1,1Fh]		
	cmp r0,1h
	beq @@Return
	mov r0,1h
	strb r0,[r1,1Fh]
	ldrh r0,[r4,14h]	
	sub r0,0Bh
	strh r0,[r4,14h]	
	b @@Return

@@UpwardSpark:
	ldrb r0,[r3]		;button input
	mov r1,10h
	and r1,r0
	cmp r1,0h		;checks if right is pressed
	bne @@ChangeRight
	mov r1,20h
	and r1,r0
	cmp r1,0h		;checks if left is pressed
	bne @@ChangeLeft
	b @@Return

@@RightSpark:
	ldrb r0,[r3]
	mov r1,50h
	and r1,r0
	cmp r1,50h	;checks if right and up are being pressed
	beq @@MoveUp
	mov r1,90h
	and r1,r0
	cmp r1,90h	;checks if right and down are being pressed
	beq @@MoveDown
	mov r1,40h
	and r1,r0
	cmp r1,0h	;checks if just up is being pressed
	bne @@ChangeUp
	mov r1,20h
	and r1,r0	;checks if left is pressed
	cmp r1,20h
	beq @@ChangeLeft
	b @@Return

@@LeftSpark:
	ldrb r0,[r3]
	mov r1,60h
	and r1,r0
	cmp r1,60h	;checks if left and up are being pressed
	beq @@MoveUp
	mov r1,0A0h
	and r1,r0
	cmp r1,0A0h	;checks if left and down are being pressed
	beq @@MoveDown
	mov r1,40h
	and r1,r0
	cmp r1,0h	;checks if just up is being pressed
	bne @@ChangeUp
	mov r1,10h
	and r1,r0	;checks if right is pressed
	cmp r1,0h
	bne @@ChangeRight
	b @@Return

@@ChangeUp:		 ;Sets upward spark
	mov r0,0h
	strb r0,[r4,4h]	 ;change spark type
	mov r0,0h
	strh r0,[r4,16h] ;stops X movement
	strh r0,[r4,1Ch]
	mov r0,0C0h
	strh r0,[r4,18h] ;sets Y speed
	b @@Return

@@ChangeRight:
	mov r0,10h
	strb r0,[r4,0Eh]	;change direction
	mov r0,1h
	strb r0,[r4,4h]		;change spark type
	mov r0,0h
	strh r0,[r4,18h] ;resets Y speed
	strh r0,[r4,1Ch]
	mov r0,0C0h
	strh r0,[r4,16h] ;sets X movement
	b @@Return

@@ChangeLeft:
	mov r0,20h
	strb r0,[r4,0Eh]		;change direction
	mov r0,1h
	strb r0,[r4,4h]			;change spark type
	mov r0,0h
	strh r0,[r4,18h] ;resets Y speed
	strh r0,[r4,1Ch]		
	ldr r0,=0FF40h
	strh r0,[r4,16h] ;sets X movement
	b @@Return

@@MoveUp:			;moves player upwards but doesnt start up spark
	ldrh r1,[r4,14h]	
	sub r1,4h
	strh r1,[r4,14h]	;Changes Y position, makes it move player Upwards
	b @@Return
	
@@MoveDown:			;moves player down 
	ldrh r1,[r4,14h]
	add r1,4h
	strh r1,[r4,14h]	;Changes Y position, makes it move player downwards


@@Return:
	mov r0,r4
	ldrb r0,[r0]
	bx r14

.pool
.close