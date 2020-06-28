
;备份的单独球加速例程
ZeroSuitRollBallSpeedBooster:
	push r4,r5,lr
	ldr r5,=3001588h
	cmp r1,9Fh              
	bhi @@SpeedBoostering
	ldr r3,=3001530h
	ldrb r2,[r3,0Fh]
	mov r0,2h
	and r0,r2
	cmp r0,0h               ;检查是否有加速能力
	beq @@NoSpeedBooster
	ldrb r0,[r3,12h]        ;检查是否是零式服
	cmp r0,2h
	bne @@NoSpeedBooster
	mov r0,r5
	add r0,5Bh
	ldrb r0,[r0]
	cmp r0,0h               ;无重力在水中flag
	bne @@NoSpeedBooster
	ldrb r2,[r4,0Ah]
	mov r0,16h
	ldsh r0,[r4,r0] 		;读取当前的X速度
	cmp r0,0h
	bge @@PassNeg
	neg r0,r0
@@PassNeg:
	cmp r0,60h              ;速度如果是大于60的基础速度
	bcc @@PassWriteNewBoosterTimes
	cmp r2,0h               ;然而加速累计却是0
	bne @@PassWriteNewBoosterTimes
	cmp r0,0A0h             ;速度不小于0A0
	bcc @@NextCheck
	mov r2,70h              ;则加速累计值写入70h
	b @@WriteNewBoosterTimes
.pool	
@@NoSpeedBooster:           ;没有的话则以默认的最大X速度限制
	mov r2,r5
	add r2,60h
	ldrh r1,[r2] 
	b @@SpeedBoostering
@@NextCheck:
	cmp r0,8Ch              ;速度不小于80h
	bcc @@NextCheck2
	mov r2,18h              ;则加速累计值写入18h
	b @@WriteNewBoosterTimes
@@NextCheck2:
	lsr r2,r0,3
@@WriteNewBoosterTimes:
	strb r0,[r4,0Ah]
@@PassWriteNewBoosterTimes:	
	cmp r2,70h      
	bls @@PassMaxSpeedCap
	mov r1,0A0h             ;一旦加速累计值达到70则最大速为A0
	b @@PassSecSpeedCap
@@PassMaxSpeedCap:
	cmp r2,17h
	bls @@PassSecSpeedCap
	mov r1,8Ch              ;一旦加速累计值达到18则最大速为8Ch
@@PassSecSpeedCap:
	ldrh r0,[r4,16h]        ;读取当前的X速度
	add r0,5Fh
	lsl r0,r0,10h
	lsr r0,r0,10h
	cmp r0,0BEh
	bls @@ReturnAddSpeedBooster
	cmp r2,9Fh
	bhi @@SpeedBoostering
	add r0,r2,1
	b @@SpeedBoosterNumberWrite
@@ReturnAddSpeedBooster:
	mov r0,0h
@@SpeedBoosterNumberWrite:
	strb r0,[r4,0Ah]	
@@SpeedBoostering:
	mov r2,r5
	add r2,5Eh
	mov r0,0h
	ldsh r0,[r2,r0]         ;加速值
	mov r2,r4
	bl 8008278h             ;X移动例程
	pop r4,r5
	pop r1
	bx r1
.pool