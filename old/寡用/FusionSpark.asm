.gba
.open "fusion.gba","SparkControl.gba",0x8000000

.org 0x800C1F2
	bl Speed
.org 0x8009CC0
	b 8009CD6h	;disables diagonal spark
.org 0x80F9A28	;Unused sound
Speed:
	ldr r0,=3001244h
	ldr r3,=30011E8h	;button input
	mov r5,r0
	mov r7,r5
	add r7,21h
	ldrb r0,[r5,1h]
	cmp r0,24h		;checks if shinesparking
	beq @@SparkType
	b @@Return

@@SparkType:
	ldrb r0,[r5,3h]
	cmp r0,0h		;checks for upwards Shinespark
	beq @@UpwardSpark
	ldrb r0,[r5,12h]
	cmp r0,10h
	beq @@RightSpark
	b @@LeftSpark
@@UpwardSpark:
	ldrb r0,[r3]		;button input
	mov r2,10h
	and r2,r0
	cmp r2,0h		;checks if right is pressed
	bne @@ChangeRight
	mov r2,20h
	and r2,r0
	cmp r2,0h		;checks if left is pressed
	bne @@ChangeLeft
	b @@Return

@@RightSpark:
	ldrb r0,[r3]
	mov r2,50h
	and r2,r0
	cmp r2,50h	;checks if right and up are being pressed
	beq @@MoveUp
	mov r2,90h
	and r2,r0
	cmp r2,90h	;checks if right and down are being pressed
	beq @@MoveDown
	mov r2,40h
	and r2,r0
	cmp r2,0h	;checks if just up is being pressed
	bne @@ChangeUp
	mov r2,20h
	and r2,r0	;checks if left is pressed
	cmp r2,20h
	beq @@ChangeLeft
	b @@Return

@@LeftSpark:
	ldrb r0,[r3]
	mov r2,60h
	and r2,r0
	cmp r2,60h	;checks if left and up are being pressed
	beq @@MoveUp
	mov r2,0A0h
	and r2,r0
	cmp r2,0A0h	;checks if left and down are being pressed
	beq @@MoveDown
	mov r2,40h
	and r2,r0
	cmp r2,0h	;checks if just up is being pressed
	bne @@ChangeUp
	mov r2,10h
	and r2,r0	;checks if right is pressed
	cmp r2,0h
	bne @@ChangeRight
	b @@Return

@@ChangeUp:		 ;Sets upward spark
	mov r0,0h
	strb r0,[r5,3h]	 ;change spark type
	mov r0,0h
	strh r0,[r5,1Ah] ;stops X movement
	strb r0,[r7]
	mov r0,0C0h
	strh r0,[r5,1Ch] ;sets Y speed
	b @@Return

@@ChangeRight:
	mov r0,10h
	strb r0,[r5,12h]	;change direction
	mov r0,1h
	strb r0,[r5,3h]		;change spark type
	mov r0,0h
	strh r0,[r5,1Ch] ;resets Y speed
	strb r0,[r7]
	mov r0,0C0h
	strh r0,[r5,1Ah] ;sets X movement
	b @@Return

@@ChangeLeft:
	mov r0,20h
	strb r0,[r5,12h]		;change direction
	mov r0,1h
	strb r0,[r5,3h]			;change spark type
	mov r0,0h
	strh r0,[r5,1Ch] ;resets Y speed
	strb r0,[r7]		
	ldr r0,=0FF40h
	strh r0,[r5,1Ah] ;sets X movement
	b @@Return

@@MoveUp:			;moves player upwards but doesnt start up spark
	ldrh r2,[r5,18h]	
	sub r2,4h
	strh r2,[r5,18h]	;Changes Y position, makes it move player Upwards
	b @@Return
	
@@MoveDown:			;moves player down 
	ldrh r2,[r5,18h]
	add r2,4h
	strh r2,[r5,18h]	;Changes Y position, makes it move player downwards


@@Return:
	mov r0,r5
	ldrb r2,[r0,1h]
	bx r14

.pool
.close