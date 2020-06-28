.gba
.open "zm.gba",".gba",0x8000000

.definelabel PrimarySpriteStats,0x82B0D68
	
.org 80104F8h
    push r4-r7,lr
	mov r4,r0        ;敌人数据坐标
	mov r3,r1        ;samusdata
	mov r5,0h
	mov r2,r0
	add r2,20h       ;方便偏移
	ldrb r1,[r2,12h] ;读取敌人的碰撞属性
	mov r0,48h
	and r0,r1
	cmp r0,0h
	bne @@PassDamage ;检查是否无敌
	ldrh r1,[r4]
	mov r0,80h
	lsl r0,r0,8h
	and r0,r1
	cmp r0,0h  
	beq @@CanDamage
@@ReturnZero:
	mov r5,0h
@@PassDamage:
	mov r0,r5
    pop r4-r7
	pop r1
	bx r1	
@@CanDamage:	
	ldrb r0,[r3,5h] 
	cmp r0,0h
	beq @@PassHighSpeed ;检查是否处于金身高速	
    mov r5,80h             ;金身标记
@@PassHighSpeed:
    ldrb r1,[r3]           ;检查samuspose
	cmp r1,22h             ;是冲刺的话
	beq @@Peer
	cmp r1,26h             ;是球冲刺的话
	beq @@Peer    
	cmp r1,0Fh
	bne @@PassSreawAttackFlag
	mov r0,20h             ;旋转攻击标记20
	orr r5,r0
@@PassSreawAttackFlag:
    cmp r1,0Bh
    blt @@Peer
	cmp r1,0Fh
	bhi @@Peer	
    ldr r0,=3001414h        
	ldrb r0,[r0,5h] 
	cmp r0,3Fh             ;检查蓄力时间
	bls @@Peer
	mov r0,1h              ;蓄力flag
	orr r5,r0
@@Peer:
    ldrb r1,[r2,12h]
    mov r0,80h
    and r0,r1
	cmp r0,0h             ;检查是否是副精灵
	beq @@NoSecondSprite
	ldr r2,=82B1BE4h
	b @@Goto
.pool	
@@NoSecondSprite:
    ldr r2,=82B0D68h
@@Goto:
    ldrb r1,[r4,1Dh]
    lsl r0,r1,3h
    add r0,r0,r1
	lsl r0,r0,1h
	add r0,r0,r2
	ldrh r1,[r0,4h]       ;读取弱点
	mov r2,0h             ;伤害值初始
	mov r6,r1             ;弱点原数据
	and r1,r5
	mov r7,r1             ;弱点与攻击方式相同的部分
	cmp r1,0h
	beq @@ReturnZero	
	mov r0,80h
	and r0,r1 
	cmp r0,0h             ;检查高速flag
	beq @@HighSpeedDamagePass
	mov r2,64h
	lsl r2,r2,2h
	ldr r0,=3001530h
	ldrb r0,[r0,12h]
	cmp r0,2h
	beq @@ZeroSuit
	cmp r0,1h
	beq @@HighSpeedDamagePass ;全装甲直接跳过伤害除法
	lsr r2,r2,1h          ;普通装甲伤害减倍
	b @@HighSpeedDamagePass
.pool	
@@ZeroSuit:
    lsr r2,r2,2h          ;零式服伤害减四分之三
@@HighSpeedDamagePass:
    mov r0,20h
	mov r1,r7          
    and r0,r1             ;检查旋转攻击
	cmp r0,0h
	beq ScrewAttackDamagePass
	mov r0,0FAh
	lsl r0,r0,1h
	add r2,r2,r0
ScrewAttackDamagePass:
    mov r0,1h
    mov r1,r7
	and r0,r1
	cmp r0,0h
	beq @@DamageCalculation
    mov r0,1h
	and r0,r5
	cmp r0,0h
	beq @@DamageCalculation
	and r0,r6
	cmp r0,0h
	beq @@DamageCalculation
	lsr r6,r6,8h         ;去掉低8位 弱点原数据
	lsl r6,r6,1Ch
	lsr r6,r6,1Ch        ;去掉高28位
	ldr r0,=3001530h
    ldrb r0,[r0,0Dh]     ;检查武器的激活情况
    and r6,r0            ;武器激活和弱点的重合
	mov r0,1h
	and r0,r6            ;检查长枪是否既激活又是弱点
	cmp r0,0h
	beq @@LongBeamDamagePass
	add r2,0Ch        ;长枪的话攻击加12
@@LongBeamDamagePass:
	mov r0,4h
	and r0,r6
	cmp r0,0h
	beq @@WaveBeamDamagePass
	add r2,0Ch        ;波动枪的的话攻击力加12
@@WaveBeamDamagePass:
	mov r0,8h
	and r0,r6
	cmp r0,0h
	beq @@PlasmaBeamDamagePass
	add r2,30h           ;离子枪的话攻击力加48
@@PlasmaBeamDamagePass:	
    mov r0,2h
    and r0,r6            ;检查冰枪
    cmp r0,0h
	beq @@DamageCalculation
	add r2,0Ch          ;冰枪的话攻击力加12
@@DamageCalculation:
    cmp r2,0h
	beq @@ReturnZero2           ;伤害值为零则结束
	mov r1,r2
	mov r0,r4
	bl 8050424h          ;弹丸对敌人的伤害例程
	cmp r0,0h            
	beq @@SpriteNoDeath
	mov r0,80h
	and r0,r7            ;检查弱点与攻击相同的数据是否有高速
	cmp r0,0h
	beq @@PassHighSpeedDeathFlag
	ldrb r0,[r3]
	cmp r0,22h           ;检查是否是冲刺
	bne @@PassSparkingFlag
	cmp r0,26h           ;检查是否是球冲刺
	bne @@PassSparkingFlag
	mov r0,63h
	b @@WritePose
.pool
@@PassSparkingFlag:
    mov r0,64h
    b @@WritePose	
@@PassHighSpeedDeathFlag:
    mov r0,20h
    and r0,r7
    cmp r0,0h	
	beq @@PassSreawAttackDeathFlag
	mov r0,65h
	b @@WritePose
@@PassSreawAttackDeathFlag:
	mov r0,66h
@@WritePose:
    mov r1,r4
    add r1,20h
	strb r0,[r1,4h]          ;敌人的死亡pose写入
	cmp r0,66h
	bne @@NoChargedBeamDeathPose
	ldr r0,=3001414h
	mov r1,0h
	strb r1,[r0,5h]
	b @@NoChargedBeamDeathPose
@@SpriteNoDeath:
    mov r5,0h	
@@NoChargedBeamDeathPose:
	mov r0,1h
	strb r0,[r1,6h]          ;待机值写入1
	ldrb r2,[r1,0Bh]         ;击晕值读取
	mov r0,80h
	and r0,r2
	mov r2,11h
	orr r0,r2
	strb r0,[r1,0Bh]
	ldrb r2,[r1,12h]         ;碰撞属性
	mov r0,2h
	orr r0,r2
	strb r0,[r1,12h]
	b @@end
@@ReturnZero2:
    mov r5,0h
@@end:	
    mov r0,r5
    pop r4-r7
	pop r1
	bx r1
.pool   	
    	
.org PrimarySpriteStats + (12h * 1Fh ) + 4
    .dh 0FFFh    	



.close