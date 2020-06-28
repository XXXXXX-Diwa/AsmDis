.gba
.open "zm.gba",".gba",0x8000000

.definelabel AreaHeaderDataOffset,0x875FAC4
.definelabel CurrentArea,3000054h
.definelabel CurrSprite,0x3000738
.definelabel CheckEvent,80608bch

;把7E 88 89三个炮台按照属性区别,并增加了不会因为母脑死而死的属性
;把7C C9 CA CB CC CD六种电圈按照属性区别,同样同上
;把98 99 9A 9B 四种触发激光按照属性区别
;把9F B0 B1 B2 四种探照灯按照属性区别

.org 8040b18h       ;炮台检查母脑死亡事件处
    bl NoDeathCannonAndBullet

.org 8040bb6h       ;区分炮台的ID处
    bl NewCannonRespectively  
    cmp r0,2h       ;对应原版的ID 88
	
.org 8040bbeh       ;修改检查的ID号
    .db 2
.org 8040bc2h
    .db 1
.org 8040bcch
    .db 3	

.org 804112ah       ;子弹的检查母脑死亡事件处
    bl NoDeathCannonAndBullet

.org 80367feh       ;电圈检查ID处
    bl NewRinkaRespectively

.org 8036dd8h       ;电圈检查母脑死亡事件处
    bl NoDeathRinkaCheck
	
.org 80381d4h       ;触发激光的AI开始处
    bl NewLaserRespectively
	
.org 8037cc4h
    ldrb r0,[r4,14h] ;读取ID改为读取血量
.org 803829eh
    ldrb r0,[r1,14h] ;同上

.org 8049c50h        ;探照灯检查ID的位置
    bl NewSearchlightRespectively	
	
///////////////////////////////////////////  
.org 8304054h
NewSearchlightRespectively:
    push lr
	strb r0,[r1]
	bl CheckSpritePropertySet
	add r0,0AEh
	pop r15
.pool
	
NewLaserRespectively:
    push lr
    bl CheckSpritePropertySet
	mov r1,r0
	ldr r0,=CurrSprite
	add r1,97h
	strb r1,[r0,14h]
	add r0,24h
    ldrb r0,[r0]
	pop r15
.pool	


NoDeathRinkaCheck:
    push lr
	bl CheckEvent
	cmp r0,0h
	beq @@end
	bl CheckSpritePropertySet
	cmp r0,6
	bls @@end
	mov r0,0h
@@end:
    pop r15
.pool	

NewRinkaRespectively:
    push lr
	ldrh r2,[r0,12h]
	bl CheckSpritePropertySet
	add r0,0C7h
	cmp r0,0CDh
	bls @@end
	sub r0,6h
@@end:	
	pop r15
.pool	

NewCannonRespectively:
    push lr
	ldrh r1,[r0,12h]
	bl CheckSpritePropertySet
	cmp r0,3h
	bls @@end
	sub r0,3h
@@end:	
	pop r15
.pool	
	
NoDeathCannonAndBullet:
    push lr
    bl CheckEvent
    cmp r0,0h
    beq @@end
    bl CheckSpritePropertySet
	mov r1,r0
	mov r0,0h
    cmp r1,3h           ;属性如果大于三则固定不死
    bhi @@end
    mov r0,1h
@@end:
    pop r15 	
.pool

CheckSpritePropertySet:
    push r4-r6
	ldr r4,=AreaHeaderDataOffset
	ldr r5,=CurrentArea  	
	ldrb r0,[r5]      ;区号
	lsl r0,r0,2h
	add r4,r4,r0      ;加上偏移值
	ldr r4,[r4]       ;获得当前区HeaderDATA地址
	ldrb r0,[r5,1h]    ;房间号
	lsl r6,r0,4
	sub r6,r0          ;十五倍
	lsl r6,r6,2        ;60倍
	add r4,r6
	add r5,26h
	ldrb r0,[r5]       ;精灵set激活号
	lsl r0,r0,3        ;乘以8
	add r4,20h
	add r4,r0          ;得到当前房间激活的精灵set数据坐标
	ldr r4,[r4]
	ldr r5,=CurrSprite
    add r5,23h
	ldrb r0,[r5]       ;得到主精灵序号
	lsl r6,r0,1
	add r6,r0          ;三倍
	add r4,r6
	ldrb r0,[r4,2h]    ;读取设置的属性
	mov r6,0F0h
	and r0,r6          ;去掉序号
	lsr r0,r0,4        ;去掉末位 
	pop r4-r6
	bx r14
.pool	

.close