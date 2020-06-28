
r0为被除数 0x4B0， r1为除数 0xA
    cmp r1,0h    ;检测除数是否为0，是的话就会跳转
	beq divisorzero
	push r4      ;保存r4
	mov r4,r0    ;给予r4被除数
	eor r4,r1    ;被除数是0的位数被除数填充
	mov r12,r4   ;结果为0x4BA，给予r12
	mov r3,1h    ;r3为1
	mov r2,0h    ;r2为0
	cmp r1,0h
	bpl nonegtive ;除数非负跳转
	neg r1,r1     ;取反+1
nonegtive：	
	cmp r0,0h 
	bpl negtiveless ;被除数非负跳转
	neg r0,r0     ;取反+1
negtiveless:
    cmp r0,r1	 ;被除数减除数
	bcc lessthan1st ;无进位，r0<r1跳转？直接结束
	mov r4,1h    ;r4为1
	lsl r4,r4,1Ch ;变成0x10000000
retocompare1st:	
	cmp r1,r4     ;除数减0x10000000
	bcs lessthansec  ;有进位，r1>r4跳转？
	cmp r1,r0     ;除数减被除数
	bcs lessthansec  ;有进位，r1>r0跳转？
	lsl r1,r1,4h   ;除数乘以16，相当于进一位
	lsl r3,r3,4h   ;1进一位，用于记录被除数和除数相差位数？
	b retocompare1st  ;一旦被除数大于0x10000000或除数，否则一直循环
lessthansec:
    lsl r4,r4,3h   ;r4乘8，结果为0x80000000
retocomparesec:
	cmp r1,r4      ;已经进位的除数和r4比较
	bcs lessthanthr ;有进位，r1>r4跳转？
	cmp r1,r0      ;已经进位的除数减被除数
	bcs lessthanthr ;有进位，r1>r0跳转？
	lsl r1,r1,1h    ;已经进位的除数乘以2
	lsl r3,r3,1h    ;已经进位的1乘以2
	b retocomparesec ;r1>r0,r1>r4满足一样就能跳出循环
lessthanthr: 
    cmp r0,r1       ;被除数比较已经进位的除数
    bcc lessthanfour  ;r0<r1跳转？
    sub r0,r0,r1    ;被除数减除数或除数倍数
	orr r2,r3       ;值给r2
lessthanfour:
	lsr r4,r1,1h    ;把除数除2的值给予r4
	cmp r0,r4       ;被除数余值和除数倍数的1/2比较
	bcc lessthanfiv ;r0<r4跳转？
	sub r0,r0,r4    ;被除数余值减去除数倍数1/2
	lsr r4,r3,1h    ;把r3的值的1/2给r4
	orr r2,r4       ;同位异数则相加给r2
lessthanfiv:
    lsr r4,r1,2h    ;除数的1/4给r4
    cmp r0,r4       ;被除数余值和除数倍数的1/4比较
	bcc lessthansix ;r0<r4跳转？
	sub r0,r0,r4    ;被除数余值减去除数倍数1/4
	lsr r4,r3,2h    ;把r3的值的1/4给r4
	orr r2,r4  	    ;同位异数则相加给r2
lessthansix: 
    lsr r4,r1,3h    ;除数的1/8给r4
	cmp r0,r4
	bcc lessthansev
	sub r0,r0,r4
	lsr r4,r3,3h    ;把r3的值的1/8给r4
	orr r2,r4       ;同位异数则相加给r2
lessthansev：
    cmp r0,0h       
    beq lessthan1st	;若被除数余值被减完跳转
	lsr r3,r3,4h    ;若被除数不为零则r3退一位
	beq lessthan1st 
	lsr r1,r1,4h    ;若被除数不为零则除数退一位
	b lessthanthr
lessthan1st:	    
	mov r0,r2       ;把r2（结果）的值给r0
	mov r4,r12      ;把原先被除数和除数的eor值给r4
	cmp r4,0h
	bpl unnegtive   ;非负跳转
	neg r0,r0
unnegtive:
    pop r4
    mov r15,r14     ;相当于bx r14?
divisorzero:	
    push 	
	