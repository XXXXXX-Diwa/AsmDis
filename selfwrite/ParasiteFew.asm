.gba
.open "zm.gba","ParasiteFew.gba",0x8000000
;寄生虫只有旋转和波动光束才能从身上摘掉
.definelabel SpriteData,0x30001AC
.definelabel SpriteDataEnd,0x30006EC

.org 0x8030158      ;下部
    bl ParasiteDownScope
;.org 0x8030188      ;顶部  

;.org 0x80301b8      ;右部
   ; add r0,8h
;.org 0x80301de      ;左部
;    sub r0,8h
	
.org 0x800F1A6    ;被寄生时检查服装
;    ldr r0,=3001530h
	ldrb r1,[r0,0Fh]
	mov r2,30h
	and r2,r1
	cmp r2,30h     ;两种衣服都有则不检查了
	beq 800F1EEh
    bl ParasiteFew
	
;.org 0x802FEF0    ;寄生虫的数量计算
.org 0x8304054
ParasiteDownScope:
    mov r0,r2
	add r0,57h
	ldrb r0,[r0]
	cmp r0,0h
	bne @@NoStanding
    ldrh r0,[r3,2h]
;	add r0,40h     ;站立则不让它可以被向下射击打到.
    add r0,38h
	b @@end
@@NoStanding:
    cmp r0,1h
    bne @@NoBall
    ldrh r0,[r3,2h]
    add r0,20h
    b @@end
@@NoBall:
    ldrh r0,[r3,2h]
    add r0,8h
@@end:
    bx r14
.pool		
    	
ParasiteFew:
    push r4-r7,lr
	mov r5,r0
	mov r4,0h
	ldr r2,=SpriteData
	ldr r6,=SpriteDataEnd
	mov r3,r2
	add r3,24h
@@Loop:	
	ldrb r0,[r3]
	cmp r0,43h
	bne @@NextCheck
	ldrb r0,[r3,1h]
	cmp r0,17h
	bne @@NextCheck
	add r4,1h
@@NextCheck:	
    add r3,38h
    add r2,38h
    cmp r2,r6
    bcc @@Loop             ;全部的敌人检查完毕才会跳出循环
	ldrb r1,[r5,0Fh]
	mov r7,10h
	and r7,r1
	cmp r7,0h
	beq @@NoVaria
	mov r7,3h
	b @@CheckParasite
.pool

@@NoVaria:
    mov r7,20h
    and r7,r1
    cmp r7,0h
    beq @@NoAdditionalSuit	
	mov r7,1h
	b @@CheckParasite
@@NoAdditionalSuit:
    mov r7,0h
@@CheckParasite:
    sub r4,r7
	cmp r4,0h
    ble @@end
	lsl r0,r4,3h
	str r0,[sp,24h]        ;伤害倍数
    mov r0,1h
    b @@end
@@end:
    pop r4-r7
    pop r15	
.pool	

.close	