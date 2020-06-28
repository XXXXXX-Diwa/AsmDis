.org 800f80ch     ;面向控制
    push lr
    ldr r0,=300083ch     ;随机数地址
	ldrb r1,[r0]
	mov r0,1h
	and r0,r1
	cmp r0,0h
	beq 800f830h         ;跳向转向例程
	ldr r2,=3000738h
	ldrh r1,[r2]
	ldr r0,=0ffbfh
	and r0,r1
	b 800f838h
.pool

.org 800f830h
    ldr r2,=3000738h
	ldrh r1,[r2]    ;得到当前的方向
	mov r0,40h
	orr r0,r1
.pool
;接	
.org 800f838h
    strh r0,[r2]    ;重新写入方向值
    pop r0
    bx r0	
	
.org 800f688h       ;确认地板?
	push lr
	lsl r0,r0,10h
	lsr r0,r0,10h
	lsl r1,r1,10h
	lsr r1,r1,10h
	bl 8057e7ch
	mov r3,r0
	mov r2,80h
	lsl r2,r2,11h  ;得到01000000
	and r2,r3
	cmp r2,0h
	beq 800f6b0h
	ldr r1,=30007f1h
	mov r0,11h
	strb r0,[r1]
	mov r2,r1
	b 800f6b6h

.org 800f6b0h
    ldr r0,=30007f1h
    strb r2,[r0]
    mov r2,r0
;接	
.org 800f6b6h	
    mov r0,0ffh
    and r0,r3	
	sub r0,2h
	cmp r0,0ah
	bhi 800f71ch
	lsl r0,r0,2h
	ldr r1,=800f6d4h
	add r0,r0,r1
	ldr r0,[r0]
	mov r15,r0

.org 8057e7ch
    push r4-r7,lr
	mov r7,r8
	push r7
	add sp,-14h
	lsl r0,r0,10h
	lsr r7,r0,10h      ;下部坐标给r7
	lsl r1,r1,10h
	lsr r2,r1,10h      ;左部坐标给r2
    mov r8,r2
    mov r2,r13
    lsr r0,r0,16h      ;下部坐标除以0x40
    mov r4,0h
    mov r3,0h
    strh r0,[r2,12h]   ;写入3007df6,别处调用则不同大概
    mov r0,r13
    lsr r1,r1,16h    ;左部坐标除以64然后写入3007df4???
    strh r1,[r0,10h]
    ldr r2,=300009ch
    ldrh r0,[r2,1ch] ;读取30000b8的值 房间的宽度和高度
    cmp r1,r0
    bcs 8057eb0h    ;有进位跳转 r1>r0? 宽度大于等于房间宽度
    mov r0,r13
    ldrh r0,[r0,12h];3007df6    下部坐标
    ldrh r2,[r2,1eh];30000ba    房间高度
    cmp r0,r2
	bcc 8057ecch     ;无进位 r0<r1?  下部坐标小于房间高度
;接	
.org 8057eb0h	
	ldr r0,=30000dch
	strh r3,[r0]     ;30000dc归0
	strh r3,[r0,2h]  ;30000de归0
;接
.org 8057ecch	
	ldr r0,=3000079h
	strb r4,[r0]     ;Current clipdata affecting action
	mov r0,0h
	b 8057f5eh
.org 8057f5eh
    add sp,14h
    pop r3
    mov r8,r3
    pop	r3
	mov r8,r3
	pop r4-r7
	pop r1
	bx r1	
	
.org 800f71ch
    pop r0
    bx r0	
	
.org 800fbc8h   ;判断动画结束???例程
    push lr
    ldr r0,=3000738h
	ldrb r1,[r0,1ch]
	ldrh r2,[r0,16h]  ;读取动画和计数
	add r1,1h     ;计数加1
	lsl r1,r1,18h
	lsr r1,r1,18h
	ldr r3,[r0,18h] ;得到当前图片地址
	lsl r0,r2,3h   ;动画帧乘以8
	add r0,r0,r3   ;加上图片地址
	ldrb r0,[r0,4h]
	cmp r0,r1
	bcs @@pass   ;r0>r1跳转
	add r0,r2,1
	lsl r0,r0,10h
	lsr r0,r0,0dh ;动画帧乘以12
	add r0,r0,r3  ;加上图片地址
	ldrb r0,[r0,4h]
	cmp r0,0h
	bne @@pass
	mov r0,1h
	b @@pass2
	lsl r0,r7,1ch
	lsl r0,r0,0ch
@@pass:	
	mov r0,0h
@@pass2:
    pop r1
    bx r1	
.pool	


.org 8002b20h    ;播放声音
    push r4,lr
    lsl r0,r0,10h
    lsr r0,r0,10h
	mov r4,r0
	ldr r3,=808f254h
	ldr r0,=808f2c0h
	lsl r2,r4,3h   ;得到848h
	add r2,r2,r0   ;808fb08
	ldrh r1,[r2,4h];得到808fb1c的值 实际为6 但得到的是5
	lsl r0,r1,1h   
	add r0,r0,r1   
	lsl r0,r0,2h   ;总共乘以12
	add r0,r0,r3   ;得到808f290
	ldr r3,[r0]    ;得到3005910
	ldr r2,[r2]    ;得到820fbfc
	ldrb r1,[r3]   ;得到2
	mov r0,2h
	and r0,r1
	cmp r0,0h
	beq @@pass
	ldr r0,[r3,10h] ;得到820fc2c
	cmp r2,r0
	beq @@pass2
@@pass:
    mov r0,r4
    mov r1,0h
    bl 8003fach
@@pass2:	
    pop r4
    pop r0
    bx r0	
.pool   

.org 8057e7ch         ;弹簧门调用
    push r4-r7,lr
    mov r7,r8
    push r7
    add sp ,-14h
    lsl r0,r0,10h
    lsr r7,r0,10h   ;r7得到Y坐标上升20h
    lsl r1,r1,10h
    lsr r2,r1,10h   ;r2得到X坐标
    mov r8,r2       ;X坐标给r8
    mov r2,r13      
    lsr r0,r0,16h   ;Y坐标原值除以40h
    mov r4,0h
    mov r3,0h
    strh r0,[r2,12h] ;写入3007dde
    mov r0,r13
    lsr r1,r1,16h    ;X坐标原值除以64
    strh r1,[r0,10h] ;写入3007ddc
    ldr r2,=300009ch
    ldrh r0,[r2,1ch] ;读取30000b8的值,实体数据宽度
    cmp r1,r0
    bcs 8057eb0h  ;r1>r0跳转
    mov r0,r13
    ldrh r0,[r0,12h]  ;读取3007dde的值
    ldrh r2,[r2,1eh]  ;读取3007dea的值
    cmp r0,r2
    bcc 8057ecch   ;r0<r1跳转
    ldr r0,=30000dch
    strh r3,[r0]
    srth r3,[r0,2h]
    ldr r0,=3000079h
    strb r4,[r0]
    mov r0,0h
    b 8057f5eh
.org 8057eb0h
    ldr r0,=30000dch
	strh r3,[r0]
	strh r3,[r0,2h]
	ldr r0,=3000079h
	strb r4,[r0]
	mov r0,0h
	b 8057f5eh
.org 8057ecch
    ldr r2,=3000079h
	ldrb r1,[r2]
	cmp r1,0h
	bne 8057ef8h
	mov r0,2h
	str r0,[sp,0ch]
	ldr r0,=30000dch
	strh r1,[r0]
	strh r1,[r0,2h]
	mov r0,13h
	ldrh r1,[r0,12h]
	ldrh r2,[r0,10h]
	mov r0,r7
	mov r3,2h
	bl 80580c0h
	b @@pass2
.org 8057ef8h
    cmp r1,5h
	bls @@pass
	mov r0,1h
	str r0,[sp,0ch]
	cmp r1,6h
	bne @@pass2
	strb r4,[r2]
	b @@pass2
@@pass:
    mov r0,2h
    str r0,[sp,0ch]
@@pass2:	
	ldr r2,=300009ch
	mov r0,r13
	ldrh r5,[r0,12h]
	ldrh r0,[r2,1ch]
	mul r0,r5
	mov r1,r13
	ldrh r3,[r1,10h]
	add r0,r0,r3
	ldr r1,[r2,18h]
	lsl r0,r0,1h
	add r0,r0,r1
	ldrh r4,[r0]
	ldr r6,=3000079h
	ldrb r0,[r6]
	cmp r0,0h
	beq @@pass3
	mov r2,r4
	mov r0,r5
	mov r1,r3
	bl 805987ch
	mov r0,0h
	strb r0,[r6]
@@pass3:	
	ldr r0,=3005450h
	ldr r0,[r0,4h]
	ladd r0,r0,r4-r6
	ldrb r0,[r0]
	str r0,[sp]
	mov r1,3fh
	mov r0,r7
	and r0,r1
	str r0,[sp,8h]
	mov r0,r8
	and r0,r1
	str r0,[sp,4h]
	ldr r0,=3005704h
	ldr r1,[r0]
	mov r0,r13
	bl 808abfch
	mov r4,r0
	add sp,14h
	pop r3
	mov r8,r3
	pop r4-r7
	pop r1
	bx r1 
.pool	
.org 8057f5eh
    add sp,14h
    pop r3    ;Y坐标原地址弹出
    mov r8,r3 ;给予r8
 	pop r4-r7
	pop r1
	bx r1 

.org 801157ch      ;弹簧门调用
    push r4-r6,lr
	mov r6,r9
	mov r5,r8
	push r5,r6
	add sp,-10h
	ldr r4,=3000738h
	ldrh r1,[r4,2h]  ;读取垂直坐标
	ldrh r3,[r4,4h]  ;读取水平坐标
	ldrh r0,[r4,0ah] ;读取顶部分界
	add r0,r1,r0     ;垂直坐标加顶部分界
	lsl r0,r0,10h
	lsr r0,r0,10h
	ldrh r2,[r4,0ch] ;读取底部分界
	add r1,r1,r2     ;与垂直坐标相加 
	lsl r1,r1,10h
	lsr r1,r1,10h
	ldrh r2,[r4,0eh] ;读取左部分界
	add r2,r3,r2     ;和水平坐标相加
	lsl r2,r2,10h
	lsr r2,r2,10h
	ldrh r4,[r4,10h] ;读取右部分界
	add r3,r3,r4     ;和水平坐标相加
	lsl r3,r3,10h
	lsr r3,r3,10h
	ldr r4,=30013d4h ;读取人物垂直坐标
	ldrh r5,[r4,14h]
	mov r8,r5
	ldrh r4,[r4,12h] ;读取人物水平坐标
	mov r9,r4
	ldr r5,=3001588h
	mov r4,r5
	add r4,70h
	ldrh r6,[r4]  ;得到30015f8的值,人物顶部分界???
	add r6,r8     ;和垂直坐标相加
	lsl r6,r6,10h
	lsr r6,r6,10h
	add r4,4h
	ldrh r4,[r4]  ;得到30015fc的值,人物下部分界???
	add r8,r4     ;和垂直坐标相加
	mov r4,r8
	lsl r4,r4,10h
	lsr r4,r4,10h
	mov r8,r4
	mov r4,r5
	add r4,6eh    
	ldrh r4,[r4]  ;得到30015f6的值,人物左部分界???
	add r4,r9     ;和水平坐标相加
	lsl r4,r4,10h
	lsr r4,r4,10h
	add r5,72h
	ldrh r5,[r5]  ;得到30015fa的值,人物右部分界???
	add r9,r5     ;和水平坐标相加
	mov r5,r9
	lsl r5,r5,10h
	lsr r5,r5,10h
	mov r9,r5
	str r6,[sp]    ;sp 3007df8
	mov r5,r8
	str r5,[sp,4h]
	str r4,[sp,8h]
	mov r4,r9
	str r4,[sp,0ch]
	bl 800e6f8h
	cmp r0,0h
	bne @@pass   ;r0=1h
	mov r0,0h
	b @@pass2
@@pass:
    mov r0,1h
@@pass2:
    add sp,10h
    pop r3,r4
	mov r8,r3
	mov r9,r4
	pop r4-r6
	pop r1
	bx r1
.pool
.org 800e6f8h      ;判断人物与精灵分界是否相交??
    push r4-r7,lr
    mov r7,r8
	push r7
	ldr r4,[sp,18h] ;人顶
	ldr r5,[sp,1ch]
	mov r8,r5       ;人底
	ldr r5,[sp,20h] ;人左
	ldr r6,[sp,24h] ;人右
	lsl r0,r0,10h
	lsl r1,r1,10h
	lsr r1,r1,10h
	lsl r2,r2,10h
	lsr r2,r2,10h
	lsl r3,r3,10h
	lsr r3,r3,10h
	lsl r4,r4,10h
	lsr r4,r4,10h
	mov r7,r8
	lsl r7,r7,10h
	mov r8,r7
	lsl r5,r5,10h
	lsr r5,r5,10h
	lsl r6,r6,10h
	lsr r6,r6,10h
	cmp r8,r0    ;人底对门顶
	bcc @@pass   ;小于
	cmp r4,r1    ;人顶对门底
	bcs @@pass   ;大于
	cmp r6,r2    ;人右对门左
	bcc @@pass   ;小于
	cmp r5,r3    ;人左对门右
	bcs @@pass   ;大于
    mov r0,1h    ;相接r0=1h??
    b @@pass2
@@pass:
    mov r0,0h
@@pass2:
    pop r3
    mov r8,r3
	pop r4-r7
	pop r1
	bx r1
      	
.org 8055b24h
	push r4-r6,r14
	lsl r0,r0,18h
	lsr r0,r0,18h
	mov r4,r0
	lsl r1,r1,18h
	lsr r1,r1,18h
	mov r6,r1
	lsl r2,r2,18h
	asr r5,r2,18h
	lsl r3,r3,18h
	lsr r3,r3,18h
	mov r0,0h
	cmp r4,10h
	bls @@pass
	mov r0,1h
@@pass:	
	cmp r1,10h
	bls @@pass2
    add r0,1h
    cmp r0,0h
	beq @@pass3
	ldr r2,=30056c4h
	ldr r1,=30056cch
	ldrb r0,[r1,4h]
	ldrb r1,[r1,3h]
	add r0,r0,r1
	mov r1,10h
	eor r0,r1
	neg r0,r0
	lsr r0,r0,1fh
	strb r0,[r2,1h]
	b @@pass4
@@pass2:
    ldsb r4,[r0,r3]
	lsl r0,r0,0ch
	ldsb r4,[r1,r3]
	lsl r0,r0,0ch
@@pass3:	
	ldr r2,=30056d4h
	strb r5,[r2,5h]
	strb r3,[r2,7h]
	strb r4,[r2,4h]
	strb r6,[r2,3h]
	strb r0,[r2,6h]
	ldr r3,=30056c4h
	add r0,r4,r6
	mov r1,10h
	eor r0,r1
	neg r0,r0
	lsr r0,r0,1fh
	strb r0,[r3,1h]
	mov r0,1h?
	strb r0,[r2,2h]
	bl 8055c24h
@@pass4:
    pop r4-r6
    pop r0
    bx r0	
.pool

.org 8055c24h
    push r14
	ldr r0,=20056c4h
	ldrb r0,[r0]
	cmp r0,0h
	beq 8055c6ch
	ldr r3,=30056e4h
	ldrb r2,[r3,2h]
	mov r1,1h
	mov r0,r1
	and r0,r2
	strb r0,[r3,2h]
	ldr r3,=30056d4h
	ldrb r2,[r3,2h]
	mov r0,r1
	and r0,r2
	strb r0,[r3,2h]
	ldr r3,=30056dch
	ldrb r2,[r3,2h]
	mov r0,r1
	and r0,r2
	strb r0,[r3,2h]
	ldr r2,=30056cch
	ldrb r0,[r2,2h]
	and r1,r0
	strb r1,[r2,2h]
	b 8055cc2h
.pool

.org 8055cc2h
    ldr r0,=30056c0h
    ldrb r0,[r0]
    cmp r0,0h	
    beq @@pass 
	bl 8055e60h
@@pass:	
	pop r0
	bx r0
.pool

.org 8055e60h
    push r4,r14
	ldr r0,=3000130h
	ldrb r3,[r0]
	cmp r3,0h
	beq 8055e9ch
	cmp r3,1h
	bne 8055f5eh
	ldr r1,=30056c0h
	mov r0,0h
	strb r0,[r1,2h]
	mov r0,2h
	strb r0,[r1,1h]
	ldr r0,=3000088h
	ldrb r0,[r0,5h]
	add r3,r0,2
	ldr r2,=3000006h
	lsl r1,r3,8h
	mov r0,10h
	sub r0,r0,r3
	orr r1,r0
	strh r1,[r2]
	b 8055f5eh
.pool
	
.org 8055e9ch
    ldr r2,=30056c0h
	ldrb r0,[r2,2h]
	add r1,r0,1h
	strb r1,[r2,2h]
	ldrb r0,[r2]
	mov r4,r2
	cmp r0,2h
	beq 8055f06h
	lsl r0,r1,18h
	lsr r0,r0,18h
	cmp r0,13h
	bls 8055f5eh
	strb r3,[r2,2h]
	ldrb r0,[r2,1h]
	add r0,1h
	mov r1,7h
	and r0,r1
	strb r0,[r2,1h]
	mov r3,3h
	and r3,r0
	cmp r3,0h
	beq @@pass2
	mov r0,1h
	and r0,r3
    mov r3,2h
    cmp r0,0h
	beq @@pass2
	mov r3,1h
@@pass2:	
	ldrb r1,[r4,1h]
	mov r0,4h
	and r0,r1
	cmp r0,0h
	beq @@pass3
	neg r3,r3
@@pass3:	
	ldr r0,=3000088h
	ldrb r2,[r0,4h]
	ldrb r0,[r0,5h]
	add r0,r0,r3
	cmp r0,0h
	bge 8055ef8h
	mov r0,0h
	b @@pass4
.pool
.org 8055ef8h
    cmp r0,10h
    ble @@pass4
	mov r0,10h
	sub r2,r2,r3
	cmp r2,0h
	blt @@pass6
	b @@pass5
@@pass4:
    sub r2,r2,r3
    cmp r2,0h
	bge @pass5    		  
@@pass6:
    mov r2,0h
    b @@pass
@@pass5:	
	cmp r2,10h
	ble @@pass
	mov r2,10h
@@pass:	
	ldr r1,=3000006h
	lsl r0,r0,8h
	orr r0,r2
	strh r0,[r1]
	pop r4
	pop r0
	bx r0
     	

    		
     	
    	
		