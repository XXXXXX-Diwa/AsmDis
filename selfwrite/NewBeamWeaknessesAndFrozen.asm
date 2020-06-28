.gba
.open "zm.gba",".gba",0x8000000



.org 8050794h        ;冰光束击中敌人的检查光束弱点处
    bl CheckBeamWeaknesses

.org 80507A8h        ;冰光束检查冰冻系数是否可以冰冻敌人
    bl CheckBeamCanFrozenSprite
	
.org 80507bah        ;冰光束伤害敌人的冰冻时间写入
    lsr r0,r0,19h    ;缩小一半
	
.org 80507d8h        ;无伤害冰光束检查冰冻处
    bl IceBeamDamagelessFrozenCheck	
    cmp r0,0h
	bne 80507F0h
	mov r0,40h       ;冰冻帧数仅仅4分之一
	
.org 8050896h        ;蓄力冰光束检查处
    bl ChargedBeamCheckWeaknesses  
    beq 80508c4h
    mov r0,r1
    and r0,r5
    cmp r0,0h
    beq 80508bah
    bl ChargedBeamCheckFrozen  ;蓄力冰光束同样检查冰冻系数
    bne 80508bah               ;而且冰冻几率提升一倍
.org 80508b4h
    mov r0,0FFh                ;蓄力光束伤害的冰冻时间为满的
	
.org 80508c4h
    bl ChargedIceBeamDamagelessFrozenCheck   ;无伤害蓄力冰冻光束检查冰冻系数
    cmp r0,0h
	bne 80508dch
	mov r1,0C0h                 ;冰冻帧数为变成四分之三
	
.org 80503A8h                   ;冰光束伤害例程
    bl CheckChargedIceBeamDeathSprite ;只让蓄力冰可以直接打死敌人而非冻住

.org 80506feh                   ;根据敌人已经冻住的情况继续增加冰冻时间
    bl CheckIceBeamAddFrozenTime	
;普通光束跳转到冰冻伤害例程的r14 80507b9h
;普通光束跳转到冰冻时间例程的r14 805080fh	
;蓄力光束跳转到冰冻伤害例程的r14 80508b3h
;蓄力光束跳转到冰冻时间例程的r14 80508fbh
.org 8050618h                   ;普通光束检查敌人弱点处
    bl NewNormalBeamWeaknessesCheck
	
.org 80506bch
    bl NewNormalChargedBeamWeaknessesCheck ;蓄力光束检查敌人弱点处
	b 80506c4h
///////////////////////////////////////////////	
.org 8304054h              
NewNormalChargedBeamWeaknessesCheck:
    lsr r0,r0,8h
	lsl r0,r0,1Ch
	lsr r0,r0,1Ch
	mov r1,r0
	cmp r1,0Fh
	beq @@end
	ldr r1,=3001530h
	ldrb r1,[r1,0Dh]      ;读取弱点
	and r1,r0
@@end:	
	bx r14
.pool	
	 
NewNormalBeamWeaknessesCheck:
	ldr r1,=3001530h
	ldrb r1,[r1,0Dh]      ;检查当前激活的枪能力
	lsr r0,r0,8h          ;弱点去掉低八位
	lsl r0,r0,1Ch         ;弱点去掉高28位
	lsr r0,r0,1Ch
	cmp r0,0Fh
	beq @@end	
	and r0,r1
@@end:	
	bx r14
.pool

CheckIceBeamAddFrozenTime:
    mov r2,r0
	add r0,30h
	ldrb r0,[r0]
	cmp r0,0h             ;如果冰冻时间为0则直接结束
	beq @@end
    cmp r1,80h            ;如果要写入的冰冻时间小于等于80则不是蓄力
	bls @@NoChargedFrozenTimes
	add r0,28h            ;蓄力冰光束增加的冰冻时间
	b @@CheckNumberOverData
@@NoChargedFrozenTimes:
    add r0,08h            ;普通冰光束增加的冰冻时间
@@CheckNumberOverData:	
	mov r1,r0
	cmp r1,0FFh
	bls @@end
    mov r1,0FFh	
@@end:	
	mov r0,r2
	add r0,30h
    bx r14
.pool	

CheckChargedIceBeamDeathSprite:
    push r4,r5
    mov r6,0h
    ldrh r0,[r3,14h]  ;读取敌人血量
	mov r4,r3
	add r4,30h
	ldrb r4,[r4]      ;检查是否是已经冻住的精灵
	cmp r4,0h
	bne @@end         ;已经冻住的话则直接结束
	cmp r0,r1         ;和伤害相比
	bhi @@end         ;大于则直接结束
	ldr r5,=82b0d6ch
	cmp r2,r5         ;检查是否是蓄力冰冻光束
	beq @@end         ;是蓄力的话直接结束
    ldr r5,=3000C77h
	ldrb r5,[r5]
	mov r4,r2
	lsr r4,r4,0Ch
	and r5,r4
	cmp r5,0h
	bne @@end
	add r0,r1,1       ;会被冰冻的话,则让血量写入比伤害多1hp
@@end:
    pop r4,r5
    bx r14
.pool
	
IceBeamDamagelessFrozenCheck:
    push r5
    mov r0,r2
	and r0,r5
	cmp r0,0h
	beq @@CantFrozen
	ldr r0,=3000c77h
	ldrb r0,[r0]
	mov r5,r2
	lsr r5,r5,0Ch              ;去掉低12位
	lsl r5,r5,1h               ;冰冻难度系数再乘以2
	and r0,r5
	b @@end
@@CantFrozen:
    mov r0,1
@@end:	
    pop r5
    bx r14
.pool	
	
ChargedIceBeamDamagelessFrozenCheck:
    push r5
    mov r0,r1
	and r0,r5
	cmp r0,0h
	beq @@CantFrozen          ;如果没有冰冻的弱点,无法冰冻
    ldr r0,=3000C77h
	ldrb r0,[r0]
	mov r5,r1
	lsr r5,r5,0Dh             ;去掉低八位再除以2
	and r0,r5
	b @@end
@@CantFrozen:
    mov r0,1h
@@end:
    pop r5
    bx r14    	
.pool	
ChargedBeamCheckFrozen:
    push r5
    ldr r0,=3000c77h
	ldrb r0,[r0]
	mov r5,r1
	lsr r5,r5,0Dh
	and r0,r5
	cmp r0,0h
    pop r5
    bx r14	
.pool	
	
ChargedBeamCheckWeaknesses:
    push r5
    lsl r0,r0,10h
	lsr r1,r0,10h
	mov r0,1h              ;只检查是否有蓄力弱点
	and r0,r1
	cmp r0,0h
	beq @@end
	ldr r0,=3001530h
	ldrb r0,[r0,0Dh]
	mov r5,r1
	lsr r5,r5,8h           ;去掉低8位
	lsl r5,r5,1Ch          
	lsr r5,r5,1Ch          ;去掉高28位
	cmp r5,0Fh             ;当敌人怕所有光束的时候,可以被普通光束打
	bne @@CheckBeam
	mov r0,1h
	cmp r0,0h
	b @@end
@@CheckBeam:	
	and r0,r5
	cmp r0,0h
@@end:	
	pop r5
	bx r14
.pool
CheckBeamWeaknesses:
    push r4,r5
    ldr r4,=3001530h
	ldrb r4,[r4,0Dh] ;枪能力激活情况  
    mov r5,r2        ;弱点	
	lsr r5,r5,8h     ;去掉低8位
	lsl r5,r5,1Ch   
	lsr r5,r5,1Ch    ;去掉高28位
	cmp r5,0Fh       ;当敌人的弱点是所有的光束的时候,则可以被普通光束打
	bne @@CheckBeam
	mov r0,1h
	b @@end
@@CheckBeam:	
	and r4,r5	
    mov r0,r4
@@end:	
    pop r4,r5
	bx r14
.pool    	

CheckBeamCanFrozenSprite:
    push r5
    ldrb r0,[r0]
    mov r5,r2
	lsr r5,r5,0Ch    ;去掉后12位
	and r0,r5
	pop r5
	bx r14
.pool	
 

.close