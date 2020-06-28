.gba
.open "zm.gba","cool.gba",0x8000000
;用于做到一些更快的解冻的敌人冰冻程序跳转

.org 8304054h	 
    push lr
	ldr r2,=3000738h
	mov r0,r2
	add r0,30h   ;得到3000768,为敌人冰冻计时数
	ldrb r1,[r0]
	sub r1,2h    ;计时数减2
	strb r1,[r0]  ;重写计时数
	ldrb r0,[r0] 
	mov r1,r0
    cmp r1,0h     ;如果计时为0的话
	bne @@frozentimer   ;非0则跳转
	ldrb r0,[r2,1Ch]   ;得到3000754的值
	sub r0,1h
	strb r0,[r2,1Ch]
@@frozentimer:	
	cmp r1,78
	bhi @@noflashing    ;如果计时大于78就跳转
	mov r0,2h       
	and r0,r1
	cmp r0,0h      
	bne @@noflashing
	mov r0,4h
	and r0,r1
	cmp r0,0h
	beq @@end
	mov r0,r2
	add r0,33h   ;得到300076b
	ldrb r0,[r0]
	ldrb r1,[r2,1fh] ;得到3000757
	add r0,r0,r1
	mov r1,0xf
	sub r1,r1,r0
	mov r0,r2
	add r0,20h   ;得到3000758
	b @@return
@@end:	
	mov r0,r2
	add r0,34h  ;得到300076c
	ldrb r1,[r0]
	sub r0,14h
@@return:	
	strb r1,[r0];写入3000758h
@@noflashing:	
	pop r0
	bx r0