.gba
.open "ZM.gba","TEST.gba",0x8000000

.definelabel SpriteAIAddressStart,0x875e8c0
.definelabel SpriteID,0x4D
.definelabel DeathActivationEvent,20h
.definelabel CheckEvent,80608BCh
.definelabel ChangeRoomMusic,80039F4h
.definelabel SpriteDateStart,2B0D68h
.definelabel SpawnNewSecondarySprite,800E258h
.definelabel PlaySound,8002A18h
.definelabel StoneEffects,8011E48h
.definelabel SetGraphicsEffects,80540ECh
.definelabel CheckScope,800FDE0h
.definelabel YVibration,8055344h
.definelabel SmallStoneDrop,8020E64h
.definelabel GFXEffect,80540ECh
.definelabel CheckFloor,800F47Ch
.definelabel MakeClip,8057E7Ch
;.definelabel CheckAnimation,800FD2Ch
.definelabel CheckAnimation,800FDACh
.definelabel EnemyBodyAnimation,8025A24h

.org SpriteAIAddressStart + (SpriteID * 4)
    .word BigMaggotMain + 1                  ;AI的地址改变

.org 8304054h
BigMaggotMain:
    push r4-r7,lr
    ldr r4,=3000738h
	ldr r6,=300070Ch
	mov r5,r4
	add r5,20h
	mov r0,1h
	strb r0,[r5,6h]      ;75E写入1,待机?
	ldrb r0,[r5,4h]      ;读取pose
	sub r0,1h
	lsl r0,18h
	lsr r0,18h
	cmp r0,60h
	Bhi @@PoseMoreThan61
    ldrb r0,[r5,12h]     ;读取碰撞属性
	mov r1,2h
	and r1,r0
	cmp r1,0h
	beq @@NoHitOrNoInScreen
	ldrh r0,[r4]
	mov r1,2h
	and r1,r0
	cmp r1,0h
	beq @@NoHitOrNoInScreen
	mov r0,0AFh
	bl PlaySound
@@NoHitOrNoInScreen:
    ldrh r0,[r4,14h]
    ldrh r1,[r6,0Ah]     ;读取两处血量
    cmp r0,r1
	beq @@PoseMoreThan61
	strh r0,[r6,0Ah]     ;738血量写入70c
	mov r0,42h
	strb r0,[r5,4h]      ;pose写入42
@@PoseMoreThan61:
    ldrb r0,[r5,4h]      ;读取pose
    cmp r0,68h
	bhi @@TransferStation
    cmp r0,0h
	beq @@Pose0BL
	cmp r0,1h
	beq @@Pose1BL
	cmp r0,2h
	beq @@Pose2BL
	cmp r0,3h
	beq @@Pose3BL
	cmp r0,4h
	beq @@Pose4BL
	cmp r0,5h
	beq @@Pose5BL
	cmp r0,6h
	beq @@Pose6BL
	cmp r0,7h
	beq @@Pose7BL
	cmp r0,8h
	beq @@Pose8BL
	cmp r0,9h
	beq @@Pose9BL
	cmp r0,0Ah
	beq @@PoseABL
	cmp r0,0Bh
	beq @@PoseBBL
	cmp r0,0Ch
	beq @@PoseCBL
	cmp r0,0Dh
	beq @@PoseDBL
	cmp r0,0Eh
	beq @@PoseEBL
	cmp r0,0Fh
	beq @@PoseFBL
	cmp r0,10h
	beq @@Pose10BL
	cmp r0,11h
	beq @@Pose11BL
	cmp r0,12h
	beq @@Pose12BL
	cmp r0,13h
	beq @@Pose13BL
	cmp r0,14h
	beq @@Pose14BL
	cmp r0,15h
	beq @@Pose15BL
	cmp r0,16h
	beq @@Pose16BL
	cmp r0,17h
	beq @@Pose17BL
	cmp r0,18h
	beq @@Pose18BL
	cmp r0,19h
	beq @@Pose19BL
	cmp r0,1Ah
	beq @@Pose1ABL
	cmp r0,1Bh
	beq @@Pose1BBL
	cmp r0,1Ch
	beq @@Pose1CBL
	cmp r0,1Dh
	beq @@Pose1DBL
	cmp r0,1Eh
	beq @@Pose1EBL
	cmp r0,1Fh
	beq @@Pose1FBL
	cmp r0,20h
	beq @@Pose20BL
	cmp r0,21h
	beq @@Pose21BL
	cmp r0,22h
	beq @@Pose22BL
	b @@OtherPose
@@Pose0BL:
    bl MaggotPose0
@@TransferStation:	
    b @@OtherPose
@@Pose1BL:
    bl MaggotPose1
    b @@OtherPose	
@@Pose2BL:
    bl MaggotPose2
    b @@OtherPose	
@@Pose3BL:
    bl MaggotPose3
	b @@OtherPose
@@Pose4BL:
    bl MaggotPose4
    b @@OtherPose
@@Pose5BL:
    bl MaggotPose5
    b @@OtherPose
@@Pose6BL:
    bl MaggotPose6
    b @@OtherPose
@@Pose7BL:
    bl MaggotPose7
    b @@OtherPose
@@Pose8BL:
    bl MaggotPose8
    b @@OtherPose
@@Pose9BL:
    bl MaggotPose9
    b @@OtherPose
@@PoseABL:
    bl MaggotPoseA
    b @@OtherPose
@@PoseBBL:
    bl MaggotPoseB
    b @@OtherPose
@@PoseCBL:
    bl MaggotPoseC
    b @@OtherPose
@@PoseDBL:
    bl MaggotPoseD
    b @@OtherPose
@@PoseEBL:
    bl MaggotPoseE
    b @@OtherPose
@@PoseFBL:
    bl MaggotPoseF
    b @@OtherPose
@@Pose10BL:
    bl MaggotPose10
    b @@OtherPose
@@Pose11BL:
    bl MaggotPose11
    b @@OtherPose
@@Pose12BL:
    bl MaggotPose12
    b @@OtherPose
@@Pose13BL:
    bl MaggotPose13
    b @@OtherPose
@@Pose14BL:
    bl MaggotPose14
    b @@OtherPose
@@Pose15BL:
    bl MaggotPose15
    b @@OtherPose
@@Pose16BL:
    bl MaggotPose16
    b @@OtherPose
@@Pose17BL:
    bl MaggotPose17
    b @@OtherPose
@@Pose18BL:
    bl MaggotPose18
    b @@OtherPose
@@Pose19BL:
    bl MaggotPose19
    b @@OtherPose
@@Pose1ABL:
    bl MaggotPose1A
    b @@OtherPose
@@Pose1BBL:
    bl MaggotPose1B
    b @@OtherPose
@@Pose1CBL:
    bl MaggotPose1C
    b @@OtherPose
@@Pose1DBL:
    bl MaggotPose1D
    b @@OtherPose
@@Pose1EBL:
    bl MaggotPose1E
    b @@OtherPose
@@Pose1FBL:
    bl MaggotPose1F
    b @@OtherPose
@@Pose20BL:
    bl MaggotPose20
    b @@OtherPose
@@Pose21BL:
    bl MaggotPose21
    b @@OtherPose
@@Pose22BL:
    bl MaggotPose22
    b @@OtherPose	
@@OtherPose:
    ldrh r0,[r4,14h]
	cmp r0,0h
	beq @@end
	mov r0,r6
	bl 80114ACh
	mov r0,r6
	bl 80259a0h
@@end:
    pop r4-r7
    pop r15
.pool	
    	
MaggotPose0:
    push r4-r7,lr
    mov r7,r8
    push r7
    add sp,-0Ch
	ldr r4,=3000738h
	mov r0,3h
	mov r1,DeathActivationEvent
	bl CheckEvent
	cmp r0,0h
	beq @@NoDeath       	;虫已经死过了
;	ldr r1,=300153Ch        ;检查是否吃到了炸弹
;	mov r0,80h
;	ldrb r1,[r1]
;	and r0,r1
;	cmp r0,0h
;	bne @@GetBomb           ;获得炸弹
;    beq @@GetBomb
@@Death:	
    mov r0,0h
	strh r0,[r4]
    b @@end
@@NoDeath:	
;@@GetBomb:
    ldr r1,=3001534h         ;超级导弹的MAX数量
	ldrb r0,[r1]
	strb r0,[r5,14h]         ;超级导弹的最大值写入76C
    ldrh r0,[r4,2h]
	mov r1,09Ch
	lsl r1,1
    sub r0,r1              
	cmp r0,0h
	blt @@Death            ;如果向上提升的坐标小于0则死亡
	strh r0,[r4,2h]        ;Y坐标向上138h
	strh r0,[r6,6h]        ;同样写入70C的Y坐标
	ldrh r0,[r4,4h]
	strh r0,[r6,8h]        ;X坐标炮制
	ldr r1,=0FFA8h
	strh r1,[r4,0Eh]
	mov r0,78h
	strh r0,[r4,10h]       ;左右分界
	mov r0,28h
	strb r0,[r5,7h]        ;75F和760写入28
    strb r0,[r5,8h]
	mov r0,18h
	strb r0,[r5,9h]        ;761写入18
	add r1,28h 
	strh r1,[r4,0Ah]       ;上部分界写入FFD0h
	mov r0,0h
	strh r0,[r4,0Ch]       ;下部分界写入0
	mov r0,1h
	strb r0,[r5,4h]        ;pose写入1h
;	mov r0,4Fh
;	mov r1,0h
;	bl ChangeRoomMusic
	ldr r1,=SpriteDateStart
	ldrb r0,[r4,1Dh]
	mov r2,12h
	mul r2,r0
	add r1,r2
	ldrh r0,[r1]           ;读取最大血量
	strh r0,[r4,14h]
	strh r0,[r6,0Ah]       ;两处血量都写入
	ldr r1,=82db100h
	str r1,[r6]            ;写入OAM
	mov r0,0h
	strb r0,[r6,0Ch]
	strh r0,[r6,4h]
	strb r0,[r6,0Eh]
	strb r0,[r6,0Dh]
	mov r0,6h
	strb r0,[r5,2h]        ;75A写入6
	mov r0,2h
	strb r0,[r5,13h]       ;76B写入2
	mov r0,5h
	strb r0,[r4,1Eh]       ;756写入5     以上意义不明
	ldrb r2,[r4,1Fh]       ;GFX ROW	
	ldrb r3,[r5,3h]        ;主精灵序号
	ldrh r0,[r4,2h]
	str r0,[sp]            ;Y坐标写入SP
	ldrh r0,[r4,4h]
	str r0,[sp,4h]         ;X坐标写入SP4
	mov r1,0h
	str r1,[sp,8h]         ;面向数据写入SP8
	mov r0,12h
    bl SpawnNewSecondarySprite
	ldrb r2,[r4,1Fh]       ;GFX ROW	
	ldrb r3,[r5,3h]        ;主精灵序号
	ldrh r0,[r4,2h]
	str r0,[sp]            ;Y坐标写入SP
	ldrh r0,[r4,4h]
	str r0,[sp,4h]         ;X坐标写入SP4
	mov r1,0h
	str r1,[sp,8h]         ;面向数据写入SP8
	mov r1,1h
	mov r0,12h
    bl SpawnNewSecondarySprite
	ldrb r2,[r4,1Fh]       ;GFX ROW	
	ldrb r3,[r5,3h]        ;主精灵序号
	ldrh r0,[r4,2h]
	str r0,[sp]            ;Y坐标写入SP
	ldrh r0,[r4,4h]
	str r0,[sp,4h]         ;X坐标写入SP4
	mov r1,0h
	str r1,[sp,8h]         ;面向数据写入SP8
	mov r1,2h
	mov r0,12h
    bl SpawnNewSecondarySprite
	ldrb r2,[r4,1Fh]       ;GFX ROW	
	ldrb r3,[r5,3h]        ;主精灵序号
	ldrh r0,[r4,2h]
	str r0,[sp]            ;Y坐标写入SP
	ldrh r0,[r4,4h]
	str r0,[sp,4h]         ;X坐标写入SP4
	mov r1,0h
	str r1,[sp,8h]         ;面向数据写入SP8
	mov r1,3h
	mov r0,12h
    bl SpawnNewSecondarySprite
	ldrb r2,[r4,1Fh]       ;GFX ROW	
	ldrb r3,[r5,3h]        ;主精灵序号
	ldrh r0,[r4,2h]
	str r0,[sp]            ;Y坐标写入SP
	ldrh r0,[r4,4h]
	str r0,[sp,4h]         ;X坐标写入SP4
	mov r1,0h
	str r1,[sp,8h]         ;面向数据写入SP8
	mov r1,4h
	mov r0,12h
    bl SpawnNewSecondarySprite
@@end:	
    add sp,0Ch
    pop r3
    mov r8,r3
    pop r4-r7
    pop r15	
.pool	

MaggotPose1:          ;检查超导最大值在这个房间是否得到增加
	ldr r1,=3001534h
	ldrb r1,[r1]      ;当前超导最大值
	ldrb r0,[r5,14h]  ;一开始的超导最大值
	cmp r0,r1
	bne @@end
	mov r0,2h
	strb r0,[r5,4h]   ;pose写入2h
;	ldr r1,=300007Bh
;	mov r0,1h
;	strb r0,[r1]      ;门关闭flag
	mov r0,0h
	strb r0,[r5,14h]  ;76C写入0h
@@end:
    bx r14	
     	
MaggotPose2:          ;根据距离让屏幕震动,并在距离达到一定的时候下落.
    push r6,lr
	mov r0,0A0h
	lsl r0,2h
	mov r1,80h
	lsl r1,2h
	bl CheckScope
	cmp r0,0h
	beq @@ReCheck
    mov r0,3h
    strb r0,[r5,4h]   ;pose写入3
    mov r0,0h
    strb r0,[r5,14h]  ;76C写入0h
	mov r0,4Fh
	mov r1,0h
	bl ChangeRoomMusic   ;改变房间的音乐
    b @@end
@@ReCheck:	
;    bl EnemyBodyAnimartion      ;腹部调色变化
    mov r0,0A0h       
	lsl r0,2h         ;垂直坐标十格范围
	mov r1,0F0h       
	lsl r1,3h         ;水平坐标十5格范围
	bl CheckScope
	cmp r0,0h
	beq @@end
    ldrb r0,[r5,14h]  ;读取76C的值
	add r0,1h
	strb r0,[r5,14h]
	ldr r6,=300083Ch
	ldrb r0,[r6]      ;读取随机值
	cmp r0,0h
	bne @@RNGNo0
	mov r0,0Ah
	mov r1,81h
	bl YVibration     ;垂直震动
@@RNGNo0:
    ldrb r1,[r5,14h]
	mov r0,1Fh
	and r0,r1
	cmp r0,0h
	bne @@Pass
	mov r0,0C8h
    lsl r0,1h
	bl PlaySound      ;播放震动的声音	
	b @@end
@@Pass:
;    ldrb r0,[r5,14h]
;    bl SmallStoneDrop
    mov r0,4h
    and r0,r1
    cmp r0,0h
    bne @@Pass1
    ldrb r1,[r6]
    ldrh r2,[r4,2h]
	ldrh r3,[r4,4h]
    ldrb r0,[r5,14h]
    sub r3,r0
	lsl r0,r1,5h
	sub r3,r0
	mov r0,0h
    bl StoneEffects
    b @@end	
@@Pass1:
    mov r0,8h
	and r0,r1
	cmp r0,0h
	bne @@Pass2
    ldrb r1,[r6]
    ldrh r2,[r4,2h]
    ldrh r3,[r4,4h]
    ldrb r0,[r5,14h]
    sub r3,r0
	lsl r0,r1,5h
	sub r3,r0
    mov r0,0h
    bl StoneEffects
	b @@end
@@Pass2:
    mov r0,1h
	and r0,r1
	cmp r0,0h
	bne @@end
	ldrb r1,[r6]
	ldrh r2,[r4,2h]
	ldrh r3,[r4,4h]
	lsl r0,r1,5h
	sub r3,r0
	mov r0,0h
    bl StoneEffects
@@end:
    pop r6	
	pop r15
.pool

MaggotPose3:           ;墙壁爆炸,烟雾飞扬,大蛆出现
    push r5-r7,lr
    ldr r7,=3000079h	
	bl DownNoBlockDrop
	ldr r0,=30007F0h
	ldrb r0,[r0]      
	cmp r0,0h        
	beq @@end          ;如果没有碰到地板则结束
	ldrb r0,[r5,14h]
	add r0,1h
	strb r0,[r5,14h]   ;如果碰到地板则76C加1
	cmp r0,3h          ;如果落到了第三层地板上,则
	bne @@UnThreeFloor
	mov r0,0h
	strb r0,[r5,14h]   ;76C归零
	mov r0,4h
	strb r0,[r5,4h]    ;Pose写入4h 
	mov r0,0C7h
	lsl r0,1h
	bl PlaySound       ;播放落地声音
	b @@end
@@UnThreeFloor:    
	;ldrh r0,[r4,2h]
	;ldrh r1,[r4,4h]
	;add r0,18h
	;mov r2,25h
	;bl GFXEffect
	mov r0,0D2h
	lsl r0,1h
	bl PlaySound
	mov r0,1h
	strb r0,[r7]
    ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	bl MakeClip
	ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	mov r2,25h
	bl GFXEffect
	mov r0,1h
	strb r0,[r7]
	ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	add r1,40h
	bl MakeClip
	ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	add r1,40h
	mov r2,25h
	bl GFXEffect
    mov r0,1h
	strb r0,[r7]
	ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	add r1,80h
	bl MakeClip	
	;ldrh r0,[r4,2h]
	;add r0,18h
	;ldrh r1,[r4,4h]
	;add r1,80h
	;mov r2,25h
	;bl GFXEffect
	mov r0,1h
	strb r0,[r7]
	ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	sub r1,40h
	bl MakeClip
	ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	sub r1,40h
	mov r2,25h
	bl GFXEffect
	mov r0,1h
	strb r0,[r7]
	ldrh r0,[r4,2h]
	add r0,18h
	ldrh r1,[r4,4h]
	sub r1,80h
	bl MakeClip	
	;ldrh r0,[r4,2h]
	;add r0,18h
	;ldrh r1,[r4,4h]
	;sub r1,80h
	;mov r2,25h
	;bl GFXEffect
@@end:
    pop r5-r7	
	pop r15
.pool

MaggotPose4:         ;落地声音,崩落石块
    push lr
;	bl EnemyBodyAnimartion      ;腹部调色变化
    ldrb r0,[r5,14h]
	add r0,1h
	strb r0,[r5,14h]
	cmp r0,6h
	bne @@NoSix
	ldrh r2,[r4,2h]
	ldrh r3,[r4,4h]
	add r3,0D0h
	mov r0,0h
	mov r1,2h
	bl StoneEffects
	mov r0,5h
	strb r0,[r5,4h]      ;pose写入5h
	mov r0,0C8h
	strb r0,[r5,14h]     ;76C写入C8h
	b @@end
@@NoSix:
    cmp r0,5h
    bne @@NoFive
	ldrh r2,[r4,2h]
    ldrh r3,[r4,4h]
    sub r3,0A8h	
	mov r0,0h
	mov r1,1h
	bl StoneEffects
    b @@end
@@NoFive:
    cmp r0,4h
    bne @@NoFour
    ldrh r2,[r4,2h]
    ldrh r3,[r4,4h]
    add r3,0D0h
    mov r0,0h
    mov r1,3h
    bl StoneEffects	
	b @@end
@@NoFour:
    cmp r0,3h
	bne @@NoThree
    ldrh r2,[r4,2h]
    ldrh r3,[r4,4h]
    sub r3,0A8h
    mov r0,0h
    mov r1,4h
    bl StoneEffects
    b @@end
@@NoThree:
    cmp r0,2h
    bne @@NoTwo
    ldrh r2,[r4,2h]
    ldrh r3,[r4,4h]
    add r3,0D0h
    mov r0,0h
    mov r1,13h
    bl StoneEffects
    b @@end
@@NoTwo:
    ldrh r2,[r4,2h]
    ldrh r3,[r4,4h]
    sub r3,0A8h
    mov r0,0h
    mov r1,11h
    bl StoneEffects	
	mov r0,0Ah
	mov r1,81h
	bl YVibration      ;垂直震动
@@end:    	
	pop r15
    	
MaggotPose5:                 ;正常的姿势
    push lr
	ldrb r0,[r5,14h]
	sub r0,1h
	strb r0,[r5,14h]         ;76C减1再写入
	cmp r0,0h
	bne @@Pass
	mov r0,0Ah
	strb r0,[r5,4h]
@@Pass:	
	bl EnemyBodyAnimation
    bl ScollControl          ;2C0 11格内合适
    cmp r0,0h
    bne @@Pass
	mov r0,6h
	strb r0,[r5,4h]
	b @@end
@@Pass:
    cmp r0,2h
    bne @@end
    mov r0,0Bh
    strb r0,[r5,4h]	
@@end:	
    pop r15	
	
MaggotPose6:               ;距离超出11格,大虫前冲预备姿势
    push lr
	ldr r0,=82DB1D0h
	str r0,[r6]
	mov r0,0h
	strh r0,[r6,4h]
	strb r0,[r6,0Ch]
	mov r0,0ADh
	bl PlaySound            ;翘头叫声
	mov r0,7h
	strb r0,[r5,4h]
    pop r15	

MaggotPose7:                 ;翘头动画过程
    push lr
	bl EnemyBodyAnimation
	mov r0,r6
	bl CheckAnimation
	cmp r0,0h
	beq @@end
	mov r0,8h
	strb r0,[r5,4h]
@@end:
    pop r15	

MaggotPose8:                 ;前冲准备
    push lr
	ldr r0,=82DB0A0h         ;前冲OAM
	str r0,[r6]
	mov r0,0h
	strh r0,[r6,4h]
	strb r0,[r6,0Ch]
	mov r0,0AEh
	bl PlaySound             ;前冲声
	mov r0,9h
	strb r0,[r5,4h]          ;pose写入9
	pop r15
	
	
MaggotPose9:                 ;前冲过程
    push lr
	bl EnemyBodyAnimation
	ldrh r0,[r6,8h]          ;读取70C的X坐标
	sub r0,8h
	strh r0,[r6,8h]
	mov r0,0A0h
	lsl r0,2h
	mov r1,0FFh
	bl CheckScope
	cmp r0,0h
	beq @@end
	ldr r0,=82DB100h
    str r0,[r6]
	mov r0,0h
	strh r0,[r6,4h]
	strb r0,[r6,0Ch]
	mov r0,5h
	strb r0,[r5,4h]
@@end:
    pop r15	

MaggotPoseA:               ;扔头球
    push lr
	
    pop r15		
	
MaggotPoseB:
    push lr
    pop r15	

MaggotPoseC:
    push lr
    pop r15	

MaggotPoseD:
    push lr
    pop r15	

MaggotPoseE:
    push lr
    pop r15	

MaggotPoseF:
    push lr
    pop r15	

MaggotPose10:
    push lr
    pop r15	

MaggotPose11:
    push lr
    pop r15	

MaggotPose12:
    push lr
    pop r15	

MaggotPose13:
    push lr
    pop r15	

MaggotPose14:
    push lr
    pop r15	

MaggotPose15:
    push lr
    pop r15	

MaggotPose16:
    push lr
    pop r15	

MaggotPose17:
    push lr
    pop r15	

MaggotPose18:
    push lr
    pop r15	

MaggotPose19:
    push lr
    pop r15	

MaggotPose1A:
    push lr
    pop r15	

MaggotPose1B:
    push lr
    pop r15	

MaggotPose1C:
    push lr
    pop r15	

MaggotPose1D:
    push lr
    pop r15	

MaggotPose1E:
    push lr
    pop r15	

MaggotPose1F:
    push lr
    pop r15	

MaggotPose20:
    push lr
    pop r15	

MaggotPose21:
    push lr
    pop r15	

MaggotPose22:
    push lr
	mov r0,5h
	strb r0,[r5,4h]
    pop r15		
;*----------------------------------------------------------
DownNoBlockDrop:
    push lr
    ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
	bl CheckFloor
	mov r1,r0
	ldr r0,=30007F0h
	ldrb r0,[r0]
	cmp r0,0h
	bne @@OnFloor
	ldrh r0,[r6,6h]
	add r0,10h           ;下落速度
	strh r0,[r6,6h]
	b @@end
@@OnFloor:
    strh r1,[r6,6h]
@@end:	
	pop r15
;*------------------------------------------------------------
ScollControl:
    push lr
    mov r0,0A0h
	lsl r0,2h
	mov r1,0B0h
	lsl r1,2h
	bl CheckScope
	;cmp r0,8h	        ;检查只要相距11格内就固定屏幕
	;beq @@Death
	cmp r0,4h
	beq @@FixedScorll
	mov r0,0h
	b @@WriteScorllFlag
@@FixedScorll:	
	mov r0,1h
@@WriteScorllFlag:	
    ldr r1,=3000100h
	strb r0,[r1]        ;卷轴固定flag
	cmp r0,0h
	beq @@Return
    ldrh r0,[r6,8h]     
	sub r0,0FFh
	strh r0,[r1,2h]
    ldrh r0,[r6,6h]	
	strh r0,[r1,4h]
	b @@Return
;@@Death:
 ;   mov r0,0bh
  ;  strb r0,[r5,4h]	
@@Return:	
	pop r15
.pool	
	
    
    	
    	
	
    	
    	
     	
    	
     

.pool
.close