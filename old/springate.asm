
.definelabel otherall,0x802ef5e
.definelabel opengatetable, 0x802eea0
.definelabel @@set,0x802ec0c
.definelabel PlaySound,0x8002B20
.definelabel CheckSamusTouchEnemy,0x801157c
.definelabel closegatetable,0x802ef90
.definelabel addblock,0x8057e7c

.org 802ee78h   ;AI主程序,每帧都经历
    push lr
	ldr r0,=3000738h
	mov r2,r0
	add r2,26h
	mov r1,1h
	strb r1,[r2] ;300075e写入1,敌人冷却时间?
	add r0,24h
	ldrb r0,[r0] ;读取300075c,敌人pose
	cmp r0,27h
	bhi otherall ;大于27则跳转
	lsl r0,r0,2h ;pose值乘4
	ldr r1,=opengatetable
	add r0,r0,r1 ;相加得到偏移坐标
	ldr r0,[r0]  ;得到坐标地址
	mov r15,r0   ;转到坐标地址
.pool	
opengatetable:	
    .word 802ef40h ;00 bl 802ebc0h
    .word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh 
	.word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh
	.word 802ef46h ;09h
	.word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh
	.word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh
	.word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh 
	.word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh
	.word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh 
	.word 802ef5eh .word 802ef5eh .word 802ef5eh .word 802ef5eh
	.word 802ef5eh 
	.word 802ef4ch ;23h
	.word 802ef5eh
	.word 802ef52h ;25h
	.word 802ef5eh
	.word 802ef58h ;27h
.org 802ef40h
    bl 802ebc0h   ;00
    b @@end
    bl 802ec68h   ;09h
    b @@end
    bl 802ec80h   ;23h
    b @@end
    bl 802ecb8h   ;25h
    b @@end
    bl 802ed18h   ;27h
    b @@end
    bl 802ed40h   ;other all
@@end:	
	pop r0
	bx r0
.org 802ebc0h      ;AI初始化程序,只经历一次? pose 00
	push r4,lr
	ldr r0,=30001a8h
	ldrh r0,[r0]   ;读取警报时间
	cmp r0,0h      
	beq 802ebf4h   ;为0的话跳转
	ldr r1,=3000738h
	ldr r0,=82e6b98h ;图片坐标
	str r0,[r1,18h]  ;写入
	mov r2,r1
	add r2,24h
	mov r0,25h
	strb r0,[r2]     ;pose值写入25h
	add r1,2ch
	mov r0,1h
	strb r0,[r1]       ;3000764写入1
	mov r0,4h
	bl 802eaf8h
	b @@set ;802ec0ch	
.pool
.org 802eaf8h  ;人物与精灵不相交
    push r4-r7,lr
    mov r4,r0
    lsl r4,r4,18h
    lsr r4,r4,18h
    ldr r0,=3000738h
    ldrh r7,[r0,2h]  ;得到Y坐标
    ldrh r6,[r0,4h]  ;得到X坐标
    ldr r5,=3000079h
    strb r4,[r5]   ;响应动作?写入4
    mov r0,r7
    sub r0,20h     ;Y坐标上升20h
    mov r1,r6
    bl addblock
    strb r4,[r5]
    mov r0,r7
    sub r0,60h
    mov r1,r6
    bl addblock
    strb r4,[r5]
    mov r0,r7
    sub r0,a0h
    mov r1,r6
    bl addblock
    strb r4,[r5]
    mov r0,r7
    sub r0,e0h
	mov r1,r6
	bl addblock
	pop r4-r7
	pop r0
	bx r0
.pool
.org 802ebf4h     ;进入房间经历默认程序,确认无警报会经历的例程
    ldr r1,=3000738h
    ldrh r2,[r1]    ;初始为1
    mov r3,80h
    lsl r3,r3,8h    ;得到0x8000
    mov r0,r3
    orr r0,r2       ;得到0x8001
    strh r0,[r1]    ;写入3000738
    ldr r0,=82e6af8h ;无图 
    str r0,[r1,18h] ;写入图片地址
    add r1,24h
    mov r0,9h
    strb r0,[r1]    ;pose写入9h
@@set:	
    ldr r0,=3000738h
    mov r12,r0
	mov r4,0h
	mov r3,0h
	mov r0,0ffh
	lsl r0,r0,8h    ;得到0xff00
	mov r1,r12 
	strh r0,[r1,0ah] ;顶部边界写入0xff00
	strh r3,[r1,0ch] ;底部边界写入0
	add r0,e8h
	strh r0,[r1,0eh] ;左部边界写入0xe8
	mov r0,18h
	strh r0,[r1,10h] ;右部边界写入0x18
	add r1,27h
	mov r2,40h
	mov r0,40h
	strb r0,[r1]     ;300075f写入40h
	mov r0,r12
	add r0,28h
	mov r1,8h
	strb r1,[r0]     ;3000760写入8h
	add r0,1h
	strb r1,[r0]     ;3000761写入8h
	mov r0,r12
	strb r4,[r0,1ch]
	strh r3,[r0,16h] ;动画和计数归0
	add r0,25h
	strb r4,[r0]     ;属性为0
	mov r0,1h
	mov r1,r12
	strh r0,[r1,14h] ;血量写入1
	add r1,22h
	mov r0,3h
	strb r0,[r1]     ;300075a写入3,调色板...
	add r1,10h
	ldrb r0,[r1]     ;读取300076a的值,默认0
	orr r2,r0        ;or40重新写入
	strb r2,[r1]
	pop r4
	pop r0
	bx r0
.pool
.org 802ec68h   ;pose 9h,检查警报出现
	push lr 
	ldr r0,=30001a8h
	ldrh r0,[r0]
	cmp r0,0h
	beq @@pass
	bl 802eb88h   ;有警报跳转
@@pass:	
	pop r0
	bx r0
.pool	
.org 802eb88h   ;触发了警报
    push lr 
	ldr r0,=3000738h
	ldrh r2,[r0]
	ldr r1,=7fffh
	and r1,r2   ;7FFF and 8003=0003
	mov r2,0h
	mov r3,0h
	strh r1,[r0]
	ldr r1,=82e6b08h
	str r1,[r0,18h]  ;写入图片地址
	strb r2,[r0,1ch]
	strh r3,[r0,16h] ;动画和计数归0
	add r0,24h
	mov r1,23h
	strb r1,[r0]     ;pose 变成23h
	ldr r0,=109h
	bl PlaySound     ;门下落声音
	pop r0
	bx r0
.pool	

.org 802ec80h  ;pose 23h   这个过程弹簧门从头下落到底
    push lr
    bl 800fbc8h  ;检查结束敌人动画
	cmp r0,0h    ;为零的话,动画帧未完,直接跳过最后
	beq @@pass
	ldr r3,=3000738h
	ldr r0,=82e6b98h
	str r0,[r3,18h] ;写入新的图片地址
	mov r0,0h
	strh r0,[r3,1ch]
	mov r2,0h
	strh r0,[r3,16h] ;动画和计数归0
	mov r1,r3
	add r1,24h
	mov r0,25h
	strb r0,[r1]   ;pose写入25h
	mov r0,r3
	add r0,2ch
	strb r2,[r0]   ;3000764写入0
	add r0,3h
	strb r2,[r0]   ;3000767写入0
@@pass:	
	pop r0
	bx r0
.pool
.org 802ecb8h    ;pose 25 弹簧门向上反弹,关闭常态
    push r4,lr
    ldr r0,=3000738h
	mov r4,r0
	add r4,2ch
	ldrb r0,[r4]  ;得到3000764的值,在23的时候已经归0所以不会pass
	cmp r0,0h     ;经过了一次相交处理的例程,就会加1,直接pass
	bne @@pass    
	bl CheckSamusTouchEnemy
	cmp r0,0h
	bne @@pass   ;人物与精灵相交
	mov r0,4h
	bl 802eaf8h
	ldrb r0,[r4]
	add r0,1h
	strb r0,[r4] ;3000764的值加1
@@pass:	
	ldr r0,=30001a8h
	ldrh r0,[r0]
	cmp r0,0h
	bne 802ed04h
	ldr r1,=3000738h
	add r1,2fh
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]   ;3000767的值加1
	lsl r0,r0,18h
	lsr r0,r0,18h
	cmp r0,28h     ;如果3000767的值小于等于28,pass
	bls @@pass2
	bl 802eb48h    ;3000767大于28才会跳转,似乎算是控制警报灭后门关闭的响应时间
	b @@pass2

.org 802ed04h      ;警报不为0
    ldr r0,=3000738h
    add r0,2fh
	mov r1,0h
	strb r1,[r0]  ;警报时间不为0则3000767归零
@@pass2:	
	pop r4
	pop r0 
	bx r0
	 
.org 802eb48h     ;警报为0,且3000767大于28帧就会经历
    push r4,lr
    ldr r0,=3000738h
	ldrh r2,[r0]
	mov r3,80h
	lsl r3,r3,8h
	mov r1,r3
	mov r3,0h
	mov r4,0h
	orr r1,r2   ;和8000h or再写入
	strh r1,[r0]
	ldr r1,=82e6bb8h
	str r1,[r0,18h] ;写入图片地址
	strb r3,[r0,1ch] 
	strh r4,[r0,16h];动画和计数归0
	add r0,24h
	mov r1,27h
	strb r1,[r0]    ;pose写入27h
	mov r0,1h
	bl 802eaf8h
	ldr r0,=225h
	bl PlaySound   ;门上升声音
	pop r4-r7
	pop r0
	bx r0
    
.org 802ed18h   ;pose 27h	
    push lr
	bl 800fbc8h   ;检查结束动画
	cmp r0,0h
	beq @@pass    ;未完,pass
	ldr r1,=3000738h
	ldr r0,=82e6af8h ;无图
	str r0,[r1,18] ;写入图片地址
	mov r0,0h
	strb r0,[r1,1ch]
	strh r0,[r1,16h] ;动画和计数归0
	add r1,24h
	mov r0,9h
	strb r0,[r1]     ;pose改为9
@@pass:	
	pop r0
	bx r0
.pool	
.org 802ed40h   ;根本不经过的例程??62也以此为防bug例程
    push r4,r5,r14
    add sp,-4h
	mov r0,1h
	bl 802eaf8h
	ldr r0,=3000738h
	ldrh r4,[r0,2h]
	sub r4,40h    
	lsl r4,r4,10h
	lsr r4,r4,10h
	ldrh r5,[r0,4h]
	mov r0,r4
	mov r1,r5
	mov r2,1eh
	bl 80540ech
	sub r4,60h
	mov r0,21h
	str r0,[sp]
	mov r0,0h
	mov r1,r4
	mov r2,r5
	mov r3,1h
	bl 8011084h
	add sp,4h
	pop r4,r5
	pop r0
	bx r0
    	
;以下为62门的数据
.org 802ef68h     ;主程序,每帧经过
    push lr
    ldr r0,=3000738h
	mov r2,r0
	add r2,26h
	mov r1,1h  
	strb r1,[r2] ;300075e给1
	add r0,24h
	ldrb r0,[r0]
	cmp r0,27h    ;pose 大于27则跳转
	bhi 802f04eh   ;同样导向802ed40h
	lsl r0,r0,2h
	ldr r1,=closegatetable
	add r0,r0,r1
	ldr r0,[r0]
	mov r15,r0
.pool
closegatetable:
    .word 802f030h ;00
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f036h ;09h
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f04eh .word 802f04eh .word 802f04eh .word 802f04eh
	.word 802f04eh 
	.word 802f03ch ;23h
	.word 802f04eh 
	.word 802f042h ;25h
	.word 802f04eh 
	.word 802f048h ;27h
	
;802ed80处确认警报	初始确认
;802ee24处确认警报  pose 9h确认
;802ee5e处确认警报  pose 25 检查警报结束  	