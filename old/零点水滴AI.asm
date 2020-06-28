.gba
.open "zm.gba","BBdrop.gba",0x8000000


.org 80127ach
    push r4-r6,lr
	ldr r1,=3000738h
	mov r2,r1
	add r2,26h
	mov r0,1h
	strb r0,[r2]   ;300075e写入1
	mov r0,r1
	add r0,24h
	ldrb r0,[r0]   ;得到300075c的值,精灵pose
	mov r4,r1      
	cmp r0,1fh     ;pose<=1f则跳转
	bls @@one      ;80127c6h
	b @@end        ;8012a2eh
@@one:	
	lsl r0,r0,2h   ;pose乘以4
	ldr r1,=@@Table
	add r0,r0,r1
	ldr r0,[r0]    ;得到坐标8012858h
	mov r15,r0     ;转到坐标8012858h	80129c8h   80128ach  80127f4h	
.pool
.org 80127d8h
@@Table:
	.word 0x8012858    ;00
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e  
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e     
	.word 0x80128ac    ;09
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e       
	.word 0x8012970    ;0eh
	.word 0x8012984    ;0fh
	.word 0x8012a2e    
	.word 0x80129c8    ;11
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e 
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e   
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e     
	.word 0x8012a2e     
	.word 0x80128e0    ;1eh
.org 8012858h
    bl @@two        ;8012780h	
    ldr r0,=3000738h
	mov r12,r0
	ldrh r2,[r0,2h]   ;得到Y轴坐标
	sub r2,40h        ;向上提升40个单位
	mov r3,0h
	strh r2,[r0,2h]   ;重写入Y轴坐标
	add r0,27h
	mov r1,8h
	strb r1,[r0]    ;300075f写入8
	mov r0,r12
	add r0,28h      
	strb r1,[r0]    ;3000760写入8
	add r0,1h
	strb r1,[r0]    ;3000761写入8
	mov r1,r12
	strh r3,[r1,16h]  ;300074e动画帧数写入0
	ldr r0,=833bc54h
	str r0,[r1,18h]   ;3000750写入图像地址
	strh r2,[r2,6h]   ;Y轴坐标写入弹丸Y轴
	ldrh r0,[r1,4h]   ;得到X坐标
	strh r0,[r1,8h]   ;X轴坐标写入弹丸X轴
	ldrh r1,[r1]      ;得到方向
	mov r0,4h          
	orr r0,r1         ;结果上看水滴出现方向则为3,消失则为7
	mov r6,r12
	strh r0,[r6]      ;计算结果写入方向ram
	mov r1,r12
	add r1,24h
	mov r0,11h
	strb r0,[r1]     ;300075c 精灵pose写入11
	ldr r0,=300083ch 
	ldrb r0,[r0]
	lsl r0,r0,3h
	b @@three        ;80129b4h
@@two:
	ldr r3,=3000738h
	mov r2,0h
	ldr r1,=0fffch
	strh r1,[r3,0ah]  ;写入精灵顶部延展
	mov r0,4h
	strh r0,[r3,0ch]  ;写入精灵下部延展
	strh r1,[r3,0eh]  ;写入精灵左部延展
	strh r0,[r3,10h]  ;写入精灵右部延展
	mov r0,r3      
	add r0,25h        
	strb r2,[r0]      ;属性300075d写入0
	mov r1,r3
	add r1,22h
	mov r0,1h
	strb r0,[r1]      ;300075a写入1
	strb r2,[r3,1ch]  ;3000754动画帧数写入0
	bx r14
.pool

.org 80128ach         ;pose 9
    bl 800fbc8h     ;检查精灵动画结束?
    cmp r0,0h
	bne @@five      ;结束的话则执行
	b 8012a2eh
@@five:	
	ldr r2,=3000738h
	ldr r0,=833bc94h
	str r0,[r2,18h]      ;写入新图片
	mov r1,0h
	mov r0,0h
	strh r0,[r2,16h]
	strb r1,[r2,1ch]     ;清空动画和计数
	mov r0,r2
	add r0,2dh
	strb r1,[r0]         ;清空3000765 再生值
	add r0,2h
	strb r1,[r0]         ;清空3000767
	mov r1,r2
	add r1,24h
	mov r0,1fh
	strb r0,[r1]         ;pose值写入1f
	b @@end
	
.org 80128e0h       ;水滴下落 pose 1eh
    ldrh r0,[r4,2h] ;读取Y轴坐标
    ldrh r1,[r4,4h] ;读取X轴坐标
    bl 800f47ch     ;检查地面
    mov r2,r0
    ldr r0,=30000dch
    ldrh r1,[r0,2h]
    cmp r1,1h
    bne 801291ch
	ldr r0,=300006ch
	ldrh r0,[r0]
	cmp r0,0h
	beq 801290ch
	strh r0,[r4,2h]
	mov r0,r4
	add r0,2dh
	strb r1,[r0]
	b 801290eh
	

	
@@three:
    add r1,8h
    strb r0,[r1]      ;3000764写入1
    b @@end           ;8012a2eh 	
.org 80129c8h                            ;pose 11h
    mov r2,r4         ;3000738给r2
	mov r1,r2
	add r1,2ch       
	ldrb r0,[r1]       ;读取3000764的值减1再写入
	sub r0,1h
	strb r0,[r1]
	lsl r0,r0,18h
	lsr r1,r0,18h
	cmp r1,0h          ;比较此值若不为0则end
	bne @@end          ;8012a2eh
	ldr r0,=833bc54h
	str r0,[r2,18h]    ;3000750写入图像地址
	mov r0,0h
	strh r1,[r2,16h]   ;300074e写入动画帧数0
	strb r0,[r2,1ch]   ;3000754写入动画连续0
	mov r1,r2          
	add r1,24h
	mov r0,9h
	strb r0,[r1]        ;300075c精灵pose写入9
	ldrh r1,[r2]        
	ldr r0,=0fffbh
	and r0,r1           ;r1若为7,则结果为3
	strh r0,[r2]        ;重写入
	ldrh r0,[r2,6h]     ;读取300073e弹丸Y轴坐标
	strh r0,[r2,2h]     ;写入300073a精灵Y轴坐标
	ldrh r3,[r2,8h]     ;读取3000740弹丸X轴坐标
	strh r3,[r2,4h]     ;写入300073c精灵X轴坐标  
	ldr r5,=300083ch
	ldrb r1,[r5]
	mov r0,1h
	and r0,r1           ;1和随机数and,奇数不跳转
	cmp r0,0h           
	beq @@four          ;8012a24h
	ldrb r0,[r5]
	add r0,1h           ;随机数+1
	asr r0,r0,1h        ;算术右移
	add r0,r3,r0        ;加上精灵X轴坐标写入
	strh r0,[r2,4h]
	b @@end
	lsl r0,r0,0h
	pop r2,r4,r6
	lsr r3,r6,20h
	.word 0000fbffh
	lsl r0,r0,0h
	lsr r4,r7,20h
	lsl r0,r0,0ch
@@four:	
	ldrb r0,[r5]
	add r0,1h      ;随机数+1
	asr r0,r0,1h   ;为f的时候,结果为7,E也大概如此
	sub r0,r3,r0   ;减去精灵X轴坐标后,再写入
	strh r0,[r4,4h]
@@end:
	pop r4-r6
	pop r0
	bx r0

.org 800FBC8h          ;检查精灵动画结束例程
    push lr
	ldr r0,=3000738h
	ldrb r1,[r0,1ch]   ;获取3000754的动画连续 每帧加1?
	ldrh r2,[r0,16h]   ;获取300074e的动画
	add r1,1h          ;动画连续加1
	lsl r1,r1,18h
	lsr r1,r1,18h
	ldr r3,[r0,18h]    ;获取3000750的图片地址
	lsl r0,r2,3h       ;动画乘以8
	add r0,r0,r3       ;加上图片地址
	ldrb r0,[r0,4h]    
	cmp r0,r1          ;比较如果有进位则跳转,小于?
	bcs @@six           ;800fbf8h
	add r0,r2,1
	lsl r0,r0,10h
	lsr r0,r0,r3        ;动画加1然后乘以8,再加动画图片地址
	ldrb r0,[r0,4h]
	cmp r0,0h
	bne @@six           ;800fbf8h
	mov r0,1h
	b @@seven           ;800fbfah
	lsl r0,r7,1ch
	lsl r0,r0,0ch
@@six:	
	mov r0,0h
@@seven:	
	pop r1
	bx r1
.org 800f47ch       ;检查地面
	push r4,r5,lr
	lsl r0,r0,10h
	lsr r5,r0,10h   ;Y轴坐标给r5
	lsl r1,r1,10h
	lsr r4,r1,10h   ;X轴坐标给r4
	mov r0,r5
	mov r1,r4
	bl 8057e7ch     
	mov r1,r0
	mov r0,80h
	lsl r0,r0,11h
	and r0,r1
	mov r3,0h
	cmp r0,0h
	beq 800f49eh
	mov r3,11h
	mov r0,0ffh
	and r0,r1
	sub r0,2h
	cmp r0,0ah
	bhi 800f56ah
	lsl r0,r0,2h
	ldr r1,=800f4b8h
	add r0,r0,r1
	ldr r0,[r0]
	mov r15,r0
.org 8057e7ch
    push r4-r7,lr
	mov r7,r8
	push r7
	add sp,-14h
	lsl r0,r0,10h
	lsr r7,r0,10h
	lsl r1,r1,10h
	lsr r2,r1,10h
    mov r8,r2
    mov r2,r13
    lsr r0,r0,16h
    mov r4,0h
    mov r3,0h
    strh r0,[r2,12h]
    mov r0,r13
    lsr r1,r1,16h    ;X轴坐标除以64然后写入7de4???
    strh r1,[r0,10h]
    ldr r2,=300009ch
    ldrh r0,[r2,1ch]
    cmp r1,r0
    bcs 8057eb0h
    mov r0,r13
    ldrh r0,[r0,12h]
    ldrh r2,[r2,1eh]
    cmp r0,r2
	bcc 8057ecch
	ldr r0,=30000dch
	strh r3,[r0]
	strh r3,[r0,2h]
	ldr r0,=3000079h
	strb r4,[r0]
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
	