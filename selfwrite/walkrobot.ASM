.gba
.open "ZM.gba","WalkROBOT.gba",0x8000000

.definelabel SpriteAIAddressStart,0x875e8c0
.definelabel SpriteID,0x5D
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
.definelabel CheckAnimation,800FBC8h
.definelabel EnemyBodyAnimation,8025A24h
.definelabel DeathDrop,8011084h
.definelabel FreedomRAM,3000720h
.definelabel CheckBlock,800F720h
.definelabel CheckAnimation2,800FC00h
.definelabel CrouchOAM,82E7BCCh
.definelabel TheInput,300137Ch
.definelabel WalkForwardOAM,82E7AE4h
.definelabel WalkBackwardOAM,82E7B2Ch
.definelabel WalkStopOAM,82E7B74h
.definelabel PlaySound2,8002B20h
.definelabel CheckSlope,800F594h

.org SpriteAIAddressStart + (SpriteID * 4)
    .word WalkRobotMain + 1   	;AI的地址改变
.org 8304054h	
WalkRobotMain:
    push r4-r7,lr
	mov r6,r8
	mov r7,r9
	push r6,r7
	add sp,-4h
    ldr r4,=3000738h
	mov r5,r4
	add r5,20h
	ldrb r0,[r5,4h]      ;读取pose
	cmp r0,61h
	bhi @@OtherPoseBL
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
@@OtherPoseBL:	
	b @@OtherPose
@@Pose0BL:
    bl RobotPose0
    b @@OtherPose
@@Pose1BL:
    bl RobotPose1
    b @@OtherPose	
@@Pose2BL:
    bl RobotPose2
    b @@OtherPose	
@@Pose3BL:
    bl RobotPose3
	b @@OtherPose
@@Pose4BL:
    bl RobotPose4
    b @@OtherPose
@@Pose5BL:
    bl RobotPose5
    b @@OtherPose
@@Pose6BL:
    bl RobotPose6
    b @@OtherPose
@@Pose7BL:
    bl RobotPose7
    b @@OtherPose
@@Pose8BL:
    bl RobotPose8
    b @@OtherPose
@@Pose9BL:
    bl RobotPose9
    b @@OtherPose
@@PoseABL:
    bl RobotPoseA
    b @@OtherPose
@@PoseBBL:
    bl RobotPoseB
    b @@OtherPose
@@PoseCBL:
    bl RobotPoseC
    b @@OtherPose
@@PoseDBL:
    bl RobotPoseD
    b @@OtherPose
@@PoseEBL:
    bl RobotPoseE
    b @@OtherPose
@@PoseFBL:
    bl RobotPoseF
    b @@OtherPose
@@Pose10BL:
    bl RobotPose10
    b @@OtherPose
@@Pose11BL:
    bl RobotPose11
    b @@OtherPose
@@Pose12BL:
    bl RobotPose12
    b @@OtherPose
@@Pose13BL:
    bl RobotPose13
    b @@OtherPose
@@Pose14BL:
    bl RobotPose14
    b @@OtherPose
@@Pose15BL:
    bl RobotPose15
    b @@OtherPose
@@Pose16BL:
    bl RobotPose16
    b @@OtherPose
@@Pose17BL:
    bl RobotPose17
    b @@OtherPose
@@Pose18BL:
    bl RobotPose18
    b @@OtherPose
@@Pose19BL:
    bl RobotPose19
    b @@OtherPose
@@Pose1ABL:
    bl RobotPose1A
    b @@OtherPose
@@Pose1BBL:
    bl RobotPose1B
    b @@OtherPose
@@Pose1CBL:
    bl RobotPose1C
    b @@OtherPose
@@Pose1DBL:
    bl RobotPose1D
    b @@OtherPose
@@Pose1EBL:
    bl RobotPose1E
    b @@OtherPose
@@Pose1FBL:
    bl RobotPose1F
    b @@OtherPose
@@Pose20BL:
    bl RobotPose20
    b @@OtherPose
@@Pose21BL:
    bl RobotPose21
    b @@OtherPose
@@Pose22BL:
    bl RobotPose22
    b @@OtherPose	
@@OtherPose:	
    ldr r0,=3000720h
    ldrb r1,[r0,11h]
	cmp r1,1h              ;曾骑乘以及下乘flag
	beq @Ted               ;不备份和检查所有
	ldr r1,[r4,18h]
	str r1,[r0]            ;备份OAM
	ldrh r1,[r4,16h]
	strh r1,[r0,4h]        ;备份动画
	ldrb r1,[r4,1Ch]
	strb r1,[r0,0Ch]       ;备份动画帧
	ldrh r1,[r4,2h]
	strh r1,[r0,6h]        ;备份Y坐标和备份X坐标
    ldrh r1,[r4,4h]
	strh r1,[r0,8h]
	ldrh r1,[r4]          
	strh r2,[r0,10h]       ;备份取向
	ldrb r1,[r5,4h]
	strb r1,[r0,0Fh]       ;备份POSE值
	mov r2,0Ah
	ldrh r3,[r4,r2]        
	strh r3,[r0,12h]       ;备份上部分界
	;ldr r2,=3000054h
	;ldrh r1,[r2]
	;strh r1,[r0,0Ah]      ;备份区号和房间号
	ldrb r1,[r5,0Dh]       ;备份765的值
	strb r1,[r0,0Dh]
	ldrb r1,[r0,0Eh]
	cmp r1,1h              ;检查乘坐flag
	bne @end               ;没有乘坐则结束
	ldr r2,=30013D4h
	ldrh r1,[r4,4h]
	strh r1,[r2,12h]       ;精灵X坐标写给saX
	ldrh r1,[r4,2h]        ;精灵Y坐标加上上部分界再加1
	add r1,r3
	add r1,1h
	strh r1,[r2,14h]       ;写入SaY坐标
	ldrb r1,[r2]
	cmp r1,13h	           ;检查pose是否是变回人
	beq @@Continue
	cmp r1,8h
	bne @end
@@Continue:	
	mov r3,r2
	add r3,20h
	ldrb r1,[r3]           ;是的话,pose写回变人之前的姿势
	strb r1,[r2]
    ;ldrh r1,[r4,2h]
	;sub r1,46h
	;ldrh r2,[r4,4h]
	;mov r0,22h
	;str r0,[sp]
	;mov r0,0h
	;mov r3,1h
	;bl DeathDrop
@end:	
    ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
	bl CheckBlock           ;检查是否在地面
	cmp r0,0h
	bne @Ted
;	mov r0,12h
;	strb r0,12h
@Ted:	
	add sp,4h
	pop r6,r7
	mov r8,r6
	mov r9,r7
    pop r4-r7
    pop r15
.pool	
/////////////////////////////////////////////////////////////////    	
RobotPose0:
    push lr
;	ldr r4,=3000738h
	mov r0,3h
	mov r1,DeathActivationEvent
	bl CheckEvent
	cmp r0,0h
	beq @@NoDeath          
@@Death:	               ;已经死过了
    mov r0,0h
	strh r0,[r4]
    b @@end
@@NoDeath:	
;	ldr r1,=0FFD0h
;    strh r1,[r4,0Ah]       ;上部分界写入-30h
	mov r0,0h
	strh r0,[r4,0Ch]       ;下部分界写入0h
	ldr r1,=0FFE4h
	strh r1,[r4,0Eh]
	mov r0,1Ch
	strh r0,[r4,10h]       ;左右分界各为1Ch
	mov r0,28h
	strb r0,[r5,7h]        ;上部视野检测范围写入28h
	mov r0,0h
	strb r0,[r5,8h]        
	mov r0,10h
	strb r0,[r5,9h]
	ldrb r0,[r5,12h]       ;读取碰撞属性
	mov r1,40h
	orr r0,r1              ;写入无敌
	strb r0,[r5,12h]
	mov r0,1h
	strb r0,[r5,5h]        ;属性写入1h	
	ldr r2,=FreedomRAM
	ldrb r1,[r2,0Eh]       ;乘坐Flag
	cmp r1,1h
	bne @@NoTake           ;出门没有乘坐
;-------------------------------------乘坐	
    ldrb r1,[r2,0Fh]       ;读取pose备份值
	strb r1,[r5,4h]        ;写入pose
	ldrb r0,[r2,0Dh]       ;读取765的值备份
	strb r0,[r5,0Dh]       ;写入765
	ldr r0,[r2]            ;读取备份的OAM
	str r0,[r4,18h]        ;写入当前的OAM
	ldrh r0,[r2,4h]        ;读取备份的动画值
	strh r0,[r4,16h]       ;写入当前的动画值
	ldrb r0,[r2,0Ch]       ;读取备份的动画帧值
	strb r0,[r4,1Ch]       ;写入当前的动画帧值
	ldrh r0,[r2,12h]       ;读取备份的上部分界
	strh r0,[r4,0Ah]       ;写入当前的上部分界
	ldrh r0,[r2,10h]       ;读取取向的备份
	strh r0,[r4]           ;直接写入取向
;-----------------------------------无乘	
@@NoTake:
    bl WipeOutMainThreeBlock
	ldr r0,=82E7BCCh       ;蹲下蜷缩的OAM
	str r0,[r4,18h]
	mov r0,0h
	strb r0,[r5,0Eh]       ;766写入0
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
    ldr r0,=0FF9Eh
	strh r0,[r4,0Ah]       ;上部分界写入
    ldr r3,=3000054h	
	ldr r2,=FreedomRAM
    ldrb r0,[r2,11h]	   ;读取曾骑乘flag
	cmp r0,1h
	beq @@OnceDrive
;-----------------------------------从未乘坐
;     ldrb r0,[r3]           ;读取当前的区号
;    cmp r0,0h	           ;比较是否是设定的区内
;	bne @@Death
	ldrb r0,[r3,1h]        ;读取当前的房间号
	cmp r0,0h             ;比较是否在设定的初始房间内
	bne @@Death            ;非设定的区和房间则不产卵
	mov r0,1h
	strb r0,[r5,4h]        ;写入正常产卵的pose 无乘待机
	b @@end
;-----------------------------------曾经乘坐	
@@OnceDrive:
;    ldrb r0,[r3]           ;读取当前的区号
;	ldrb r1,[r2,0Ah]       ;下乘区号的备份
;	cmp r0,r1
;	bne @@Death            ;如果异区则不产卵
	ldrb r0,[r3,1h]
	ldrb r1,[r2,0Bh]       ;下乘房间号的备份
	cmp r0,r1
	bne @@Death            ;如果房间不同则不产卵
    ldrh r0,[r2,6h]        ;读取备份的下乘Y坐标
	strh r0,[r4,2h]        ;写入当前的Y坐标
	ldrh r1,[r2,8h]        ;读取备份的下乘X坐标
	strh r1,[r4,4h]        ;写入当前的X坐标
;	bl CheckRobotInBlock
	mov r0,1h
	strb r0,[r5,4h]        ;写入无乘待机pose 
@@end:	
    pop r15	
.pool	
////////////////////////////////////////////////////////////////////////////
RobotPose1:           ;正常产卵的Pose 当Samus距离
    push lr
	ldrh r0,[r4]      ;读取取向
	mov r1,80h
	lsl r1,4h
	and r1,r0
	cmp r1,0h
	bne @@PassWipeOutBlock
	bl CheckRobotInBlock
@@PassWipeOutBlock:
    bl CheckBallOnRobotHeadTop
    cmp r0,0h
    beq	@@Return
	ldrb r0,[r5,0Eh]
	add r0,1h
	strb r0,[r5,0Eh]
	cmp r0,5h          ;在范围内的持续时间
	bls @@end
	mov r0,2h
	strb r0,[r5,4h]    ;pose写入2
@@Return:
    mov r0,0h
    strb r0,[r5,0Eh]
@@end:
    pop r15    	
.pool
	
///////////////////////////////////////////////////////////////////////////     	
RobotPose2:             ;确定了载入,固定X坐标下落
    ldr r1,=30013D4h
	ldr r2,=0F7FFh
	ldrh r0,[r4]
	and r0,r2
	strh r0,[r4]        ;取向的800标记去掉
	ldrh r0,[r4,4h]  
	strh r0,[r1,12h]    ;X坐标相同
	ldrh r0,[r4,0Ah]    ;读取上部分界
	add r0,4h           ;加上4再写入
	strh r0,[r4,0Ah]
	ldrb r2,[r1]        ;读取samus姿势
	cmp r2,13h          ;球变人姿势
	beq @@PoseToRewrite
	cmp r2,8h           ;空中人下落姿势
	bne @@Goto
@@PoseToRewrite:        ;重新把球形态写入
    add r1,20h
    ldrb r2,[r1]
    sub r1,20h
	strb r2,[r1]
@@Goto:	
	ldr r1,=0FFCEh
	cmp r0,r1
	bne @@end
	ldr r1,=3000720h
	mov r0,1h
	strb r0,[r1,0Eh]    ;乘坐flag写入1
	ldr r1,=82E7BCCh    ;蹲下的OAM
	str r1,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
	mov r0,3h
	strb r0,[r5,4h]     ;pose写入3
@@end:
    bx r14	
.pool
/////////////////////////////////////////////////////////////////////
RobotPose3:              ;蹲到底的蜷缩态
    push lr
	ldr r1,=300137Ch     ;输入的指令数据地址
	ldr r3,=3000720h
	ldrh r1,[r1]
	mov r0,1h
	and r0,r1
	cmp r0,1h            
	beq @@PressA
;-------------------------没有按A
    ldrb r0,[r3,0Ah]     ;读取跳跃累计值
	cmp r0,0h
	beq @@CheckOtherPress
;-------------------------松开A并且跳跃累计值不为0
    mov r0,40h
	ldrb r2,[r4]         ;读取取向的备份
	and r0,r2
	cmp r0,0h
	beq @@FaceLeftJ
;-------------------------面向右的跳跃
    mov r0,10h
    and r0,r1
    cmp r0,0h
	bne @@LeapForward    ;向前跳
    b @@JumpStraight     ;直跳
@@FaceLeftJ:
    mov r0,20h
    and r0,r1
    cmp r0,0h
    beq @@JumpStraight
@@LeapForward:
    ldr r0,=ReLeapForwardOAM	;pose写入斜跳预备
	mov r6,6h
    b @@WritePose
@@JumpStraight:
    ldr r0,=ReJumpStraightOAM
    mov r6,7h	;pose写入直跳预备	
    b @@WritePose 
@@PressA:
    ldrb r0,[r3,0Ah]
	cmp r0,0FFh
	beq @@end
    add r0,1h	
    strb r0,[r3,0Ah]
    b @@end	
;-------------------------没有按A也没有跳跃累计值  
@@CheckOtherPress:	
	mov r6,4h            ;站立的pose值
	mov r0,40h          
	and r0,r1
	cmp r0,0h
	bne @@StandUp        ;按了上直接进入站立姿势
;-------------------------没有按上	
	mov r0,40h         
	ldrb r2,[r4]      
	and r0,r2          
	cmp r0,0h
	beq @@FaceLeft
;--------------------------面向右	
	mov r0,10h            ;检查是否按右
	and r0,r1
	cmp r0,0h
	bne @@StandUp         ;面右按右写入站立值
;--------------------------	
	mov r6,5h             ;转身的pose值
    mov r0,20h
    and r0,r1
    cmp r0,0h
	bne @@TurnAround
	b @@end
;--------------------------面左
@@FaceLeft:
    mov r0,20h  
    and r0,r1
    cmp r0,0h
    bne @@StandUp          ;如果按左了则写入站立
    mov r6,5h
    mov r0,10h
    and r0,r1
    cmp r0,0h
    beq @@end
@@TurnAround:
    ldr r0,=TurnAround1OAM
    b @@WritePose	
@@StandUp:
    ldr r0,=StandUpOAM
@@WritePose:
    str r0,[r4,18h]	
    mov r0,0h
    strh r0,[r4,16h]
    strb r0,[r4,1Ch]
    strb r6,[r5,4h]	        ;写入pose	
@@end:	
	pop r15
.pool

///////////////////////////////////////////////////////////////////
RobotPose4:                 ;蹲下向站立的过程
    push lr
	ldr r2,=3000720h
	ldrh r1,[r4,16h]
	ldrb r3,[r4,1Ch]
    cmp r1,0h
    beq @@Pass2	
	cmp r1,1h
	bne @@Pass
;----------------------------蹲起头前倾	
    mov r0,1h
	strb r0,[r2,0Bh]        ;1代表前倾,2代表后倾
	b @@Pass2
@@Pass:
    cmp r1,2h
	bhi @@Up
	mov r0,0h
	strb r0,[r2,0Bh]        ;倾斜偏移重写回0
@@Up:	
	cmp r3,1h
	bne @@Pass2
	mov r2,0Ah
	ldsh r0,[r4,r2]         ;读取上部分界
	sub r0,8h
	strh r0,[r4,0Ah]        ;减8重新写入
@@Pass2:	
	bl CheckAnimation
	cmp r0,0h
	beq @@end
	mov r0,9h
	strb r0,[r5,4h]         ;pose写入站立姿势
	ldr r0,=StandOAM
	str r0,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
@@end:
    pop r15	
.pool
///////////////////////////////////////////////////////////    	
RobotPose5:                 ;蹲下中转身1的过程
    push lr
	bl CheckAnimation
	cmp r0,0h
	beq @@end
	ldrh r2,[r4]
	mov r0,40h
	and r0,r2
	cmp r0,0h
	beq @@FaceLeft
	ldr r0,=0FDBFh
	and r0,r2
	b @@Write
@@FaceLeft:	
	mov r0,90h
	lsl r0,2h
	orr r0,r2
@@Write:
    strh r0,[r4]
    mov r0,0Ah
    strb r0,[r5,4h]
    ldr r0,=TurnAround2OAM
    str r0,[r4,18h]
    mov r0,0h
    strh r0,[r4,16h]
    strb r0,[r4,1Ch]
@@end:	
    pop r15	
.pool
///////////////////////////////////////////////////////////	
RobotPose6:                 ;向前跳
    push lr
    pop r15	

RobotPose7:                 ;直跳
    push lr
    pop r15	

RobotPose8:                 ;向前走
    push r6,lr
	bl CheckSlope     ;检查斜坡或者砖块???
	ldr r0,=30007F0h
	ldrb r0,[r0]
	cmp r0,0h
	bne @@OnSlopeOrFloor
	ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
	add r1,20h
	bl CheckBlock     ;检查右半边是否有砖块
	cmp r0,0h
	bne @@OnSlopeOrFloor
	ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
	sub r1,20h
	bl CheckBlock     ;检查左半边是否有砖块
	cmp r0,0h
	bne @@OnSlopeOrFloor
;-------------------------脚下无砖	
	mov r0,0Dh        ;不换OAM的下落姿势
	strb r0,[r5,4h]   ;写入姿势
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	bne @@ThrustNoZero ;推力不为0时掉落,去掉推力标记
	b @@end
@@ThrustNoZero:
    mov r0,0h
    strb r0,[r5,0Dh]  ;765写入0
    ldrh r1,[r4]
	mov r0,40h
    and r0,r1
    cmp r0,0h
    beq @@FaceLeft
;--------------------------面右脚下无砖,取向标记值默认
    mov r2,80h
	lsl r2,2h          ;200
    orr r1,r2
	strh r1,[r4]       ;取向orr200
	b @@end
@@FaceLeft:
    ldr r0,=0FDFFh
    and r0,r1
    strh r0,[r4]
    b @@end
@@OnSlopeOrFloor:       ;脚下不空的部分,未掉落
;-----------------------非掉落部分
    bl CheckPiratesRay  ;自写,确定激光接触,并写入击打效果
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@NoThrust      ;脚下不空,无推力
;-------------------------有推力的部分
    ldrh r1,[r4,16h]    ;读取动画
    mov r0,3h
    and r0,r1
    cmp r0,3h
    bne @@NoPlaySound
    ldrb r0,[r4,1Ch]
    cmp r0,6h
    bne @@NoPlaySound
    ldr r0,=26Eh
    bl PlaySound2       ;播放金桶脚步声
@@NoPlaySound:
    ldrb r1,[r4,1Ch]    ;读取动画帧加四再写入
	add r1,4h           ;相当于提前结束动画帧
	strb r1,[r0,1Ch]
	ldrb r1,[r5,0Dh]    ;读取推力值
	lsr r6,r1,2h        ;除以4
	cmp r6,0h
	bne @@ThrustThanFour
	mov r6,4h           ;正常的移动力
@@ThrustThanFour:
    ldrb r0,[r5,0Dh]
    sub r0,1h
    strb r0,[r5,0Dh]    ;推力值减1再写入
    lsl r0,r0,18h
    cmp r0,0h
    bne ThrustSubOneNoZero
;-------------------------推力值减1为0时
    ldrh r2,[r4]
    mov r0,40h
    and r0,r2
    cmp r0,0h
    beq @@FaceLeft2
;-------------------------面右
    mov r3,80h
    lsl r3,r3,2h
    orr r2,r3
    strh r2,[r4]         ;取向orr200
    b @@Peer
@@FaceLeft2:
    ldr r0,=0FDFFh
    and r0,r2
    strh r0,[r4]         ;取向去200h
@@Peer:	                 
	mov r0,9h
	strb r0,[r5,4h]      ;姿势写入站立姿势
	ldr r0,=WalkStopOAM  ;和站立OAM一样....
	str r0,[r4,18h]
	mov r2,0h
	strh r2,[r4,16h]
	strb r2,[r4,1Ch]
	b @@end
@@NoThrust:
;-----------------------无推力在地面
    ldrh r1,[r4,16h]
    mov r0,3h
    and r0,r1
    cmp r0,3h
    bne @@NoPlaySound2
    ldrb r0,[r4,1Ch]
    cmp r0,8h
    bne @@NoPlaySound2
    ldr r0,=26Eh
    bl PlaySound2        ;播放平常的脚步声
@@NoPlaySound2:
    ldrh r1,[r4]         ;读取取向
    mov r0,80h
    lsl r0,r0,2h
    and r0,r1
    cmp r0,0h
    beq @@NoOrientationFlag ;也即是向左退
;---------------------------;取向有200h,向右推动
    ldr r0,=30007F0h
    ldrb r1,[r0]
    mov r0,0F0h
    and r0,r1
    cmp r0,0h
    beq @@OnSlope           ;不是在平地上,斜坡?
;    ldrb r0,[r5,0Dh]
;    cmp r0,0h
;    bne @@MoveWithRightThrust
;	ldrh r0,[r4,2h]
;	ldrh r1,[r4,4h]
;	add r1,20h             
;	bl CheckBlock
;	cmp r0,0h
;	beq @@MoveNoRightBlock
;--------------------------脚下有砖,推力非0
;@@MoveWithRightThrust:          ;检查右边上下两格是否有砖
    ldrh r0,[r4,2h]        ;旦有一则停止
    sub r0,48h
    ldrh r1,[r4,4h]
    add r1,28h	
    bl CheckBlock
    lsl r0,r0,18h
	lsr r0,18h
    cmp r0,11h
    beq @@HaveBlockStopMove	
    ldrh r0,[r4,2h]
	sub r0,38h
	ldrh r1,[r4,2h]
	add r1,28h
	bl CheckBlock
    lsl r0,18h
    lsr r0,18h	
	cmp r0,11h
	beq @@HaveBlockStopMove
@@OnSlope:
;------------------------在斜坡上不检查前方是否有砖块
    ldrh r0,[r4,4h]      ;X坐标
    add r0,r6,r0         ;加上推力值	
	strh r0,[r4,4h]      ;再写入
	b @@end
@@NoOrientationFlag:
;------------------------向左推动
    ldr r0,=30007F0h
    ldrb r1,[r0]
    mov r0,0F0h
    and r0,r1
    cmp r0,0h
    beq @@OnSlope2
;    ldrb r0,[r5,0Dh]
;    cmp r0,0h
;    bne MoveWithLeftThrust
;	ldrh r0,[r4,2h]
;	ldrh r1,[r4,4h]
;	sub r1,20h
;	bl CheckBlock
;	cmp r0,0h
    ldrh r0,[r4,2h]
	sub r0,48h
	ldrh r1,[r4,4h]
	sub r1,28h
	bl CheckBlock
	lsl r0,18h
	lsr r0,18h
	cmp r0,11h
	beq HaveBlockStopMove
	ldrh r0,[r4,2h]
	sub r0,38h
	ldrh r1,[r4,4h]
	sub r1,28h
	bl CheckBlock
	lsl r0,18h
	lsr r0,18h
	cmp r0,11h
	
    	
@@end:	
    pop r6	
	pop r15
	
	
RobotPose9:                 ;站立姿态
    push lr
    ldr r2,=TheInput
	ldrh r2,[r2]            ;输入数据
	mov r0,80h              ;按下检查
	and r0,r2
	cmp r0,0h
	bne @@SitDown
	mov r0,1h               ;按A检查
	and r0,r2
	cmp r0,0h
	beq @@UpOrAPass           
;-------------------------------按了下或跳
@@SitDown:
    ldr r0,=SitDownOAM
    mov r1,0Bh
    b @@Write
@@UpOrAPass:	
	mov r0,40h
	ldrb r1,[r4]
	and r0,r1
	cmp r0,0h
	beq @@FaceLeft
;-------------------------------面右时
    mov r0,10h                 ;按右检查
    and r0,r2
    cmp r0,0h
    bne @@WalkForward          ;向前走
    mov r0,20h
    and r0,r2
    cmp r0,0h
    beq @@end
	b @@WalkBackward           ;后退走
@@FaceLeft:
    mov r0,20h
    and r0,r2
    cmp r0,0h
    bne @@WalkForward          ;向前走
    mov r0,10h
    and r0,r2
    cmp r0,0h
    beq @@end
@@WalkBackward:
    ldr r0,=WalkBackwardOAM
    mov r1,0Ch                 ;后退走的pose值	
	b @@Write
@@WalkForward:
    ldr r0,=WalkForwardOAM
    mov r1,8h
@@Write:
    str r0,[r4,18h]
    strb r1,[r5,4h]
    mov r1,0h
    strh r1,[r4,16h]
    strb r1,[r4,1Ch]
@@end:    	
    pop r15	
.pool	
///////////////////////////////////////////////////////////
RobotPoseA:                 ;转身过程2  
    push lr
	bl CheckAnimation2
	cmp r0,0h
	beq @@end
	mov r0,3h
	strb r0,[r5,4h]         ;pose写回蹲下蜷缩态
	ldr r0,=CrouchOAM
	str r0,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
@@end:	
    pop r15		
.pool
/////////////////////////////////////////////////////////////	
RobotPoseB:                         ;下蹲过程
    push lr
	ldr r2,=FreedomRAM
	ldrh r1,[r4,16h]
	ldrb r3,[r4,1Ch]
	cmp r1,0h
	beq @@Pass2
	cmp r1,1h
	bne @@Pass
	mov r0,2h                       ;头部后倾
	strb r0,[r2,0Bh]
@@Pass:
    cmp r3,1h
	bne @@Pass2
    mov r2,0Ah
	ldsh r0,[r4,r2]
	add r0,8h
	strh r0,[r4,0Ah]                ;上部分界减低
@@Pass2:	
	bl CheckAnimation
	cmp r0,0h
	beq @@end
	ldr r0,=CrouchOAM
	str r0,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
	mov r0,3h
	strb r0,[r5,4h]                 ;写入蹲下的OAM
@@end:	
    pop r15	
.pool
RobotPoseC:                         ;后退走
    push lr
    pop r15	

RobotPoseD:
    push lr
    pop r15	

RobotPoseE:
    push lr
    pop r15	

RobotPoseF:
    push lr
    pop r15	

RobotPose10:
    push lr
    pop r15	

RobotPose11:
    push lr
    pop r15	

RobotPose12:
    push lr
    pop r15	

RobotPose13:
    push lr
    pop r15	

RobotPose14:
    push lr
    pop r15	

RobotPose15:
    push lr
    pop r15	

RobotPose16:
    push lr
    pop r15	

RobotPose17:
    push lr
    pop r15	

RobotPose18:
    push lr
    pop r15	

RobotPose19:
    push lr
    pop r15	

RobotPose1A:
    push lr
    pop r15	

RobotPose1B:
    push lr
    pop r15	

RobotPose1C:
    push lr
    pop r15	

RobotPose1D:
    push lr
    pop r15	

RobotPose1E:
    push lr
    pop r15	

RobotPose1F:
    push lr
    pop r15	

RobotPose20:
    push lr
    pop r15	

RobotPose21:
    push lr
    pop r15	

RobotPose22:
    push lr
	mov r0,5h
	strb r0,[r5,4h]
    pop r15		
;*----------------------------------------------------------
WipeOutMainThreeBlock:   ;消灭金桶身轴向上三格的砖块
    push lr
    ldr r6,=3000079h     ;制造砖块的标记
	mov r0,1h
	strb r0,[r6]
    ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
	sub r0,20h
	bl CheckClip
	cmp r3,0h
	bne @@Pass
    bl MakeClip
@@Pass:		
	mov r0,1h
	strb r0,[r6]
    ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
    sub r0,60h
	bl CheckClip
	cmp r3,0h
	bne @@Pass1
    bl MakeClip
@@Pass1:	
	mov r0,1h
	strb r0,[r6]
    ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
    sub r0,0A0h
	bl CheckClip
	cmp r3,0h
	bne @@end
    bl MakeClip
@@end:	
    pop r15	
.pool	

CheckRobotInBlock:   ;根据samus的位置检查左右的砖块,去除一边的砖块.
    push r4-r7,lr    ;返回r0和r1为这个空气的坐标
    mov r0,80h       ;Y2格范围内
	mov r1,0C0h      ;3格内
	bl CheckScope    ;检查范围
	cmp r0,0h
	beq @@end
	cmp r0,4h
	bne @@SaAtSpriteRight
	ldr r7,=0FFC0h
	b @@Peer
@@SaAtSpriteRight:
    mov r7,40h
@@Peer:
    mov r6,0h
	ldrh r5,[r4,4h]	 ;X坐标
	add r5,r7
    ldrh r7,[r4,2h]  ;Y坐标		
	lsl r5,10h
	lsr r5,10h
	add r7,30h
@@Loop:
	mov r1,r5
	sub r7,40h
	mov r0,r7
	bl CheckBlock
	cmp r0,0h
	bne @@HaveBlock
@@Add:
    add r6,1h
	cmp r6,2h
    bhi @@OrientationRecord ;一旦砖块检查完毕则取向写入800标记
    b @@Loop
@@HaveBlock:
    ldr r0,=3000079h
    mov r1,1h
    strb r1,[r0]     ;写入砖块生成标记
	mov r0,r7
	mov r1,r5
	bl CheckClip
	cmp r3,0h
	bne @@OrientationRecord
	;bne @@Add
	bl MakeClip
	mov r0,r7
	mov r1,r5
	mov r2,1Fh       ;一格爆炸特效
	bl GFXEffect     
	ldr r0,=1A4h
	bl PlaySound
    b @@Add
@@OrientationRecord:
    mov r0,80h
    lsl r0,4h        ;800h
	ldrh r1,[r4]
	orr r1,r0
	strh r1,[r4]     ;取向orr800再写入	
@@end:
    pop r4-r7
    pop r15
.pool	
    	
CheckBallOnRobotHeadTop:
    push r5,lr
	mov r5,0h
	ldr r6,=30013D4h
	ldrb r0,[r6]
	cmp r0,11h          ;检查是否是球非滚姿势
	bne @@end
	ldrh r2,[r6,14h]    ;获取SX坐标
	ldrh r3,[r6,12h]    ;获取SY坐标
	ldrh r0,[r4,2h]     ;精灵Y坐标
	ldrh r1,[r4,4h]     ;精灵X坐标
	sub r0,61h
	cmp r2,r0
	bne @@end
	sub r1,20h          ;精灵X坐标左边20h
	cmp r1,r3           ;和sa坐标比较
	bge @@end           ;大于则结束
	add r1,40h
	cmp r1,r3
	ble @@end
	ldrb r0,[r6]
	cmp r0,11h          ;检查姿势是否是球
	bne @@end
	mov r5,1h
@@end:
    mov r0,r5
    pop r5
    pop r15
.pool	
	
CheckClip:
    push r4-r7          ;返回零则坐标位置的砖块不是门
    ldr r4,=30000B4h
    lsr r5,r0,6h        ;垂直格数
	lsr r6,r1,6h        ;水平格数
	ldrb r7,[r4,4h]     ;房间最大宽度格数
	mul r5,r7
	ldr r7,[r4]         ;Clip数据起始
	add r5,r6
	lsl r5,1h
	add r7,r5
	ldrb r5,[r7]
	cmp r5,20h
	beq @@Return1
	cmp r5,30h
	beq @@Return1
	cmp r5,36h
	beq @@Return1
	cmp r5,40h
	beq @@Return1
	cmp r5,46h
	beq @@Return1
	cmp r5,4Ch
	bne @@ZZK
@@Return1:
    mov r3,1h
	b @@Ted
@@ZZK:
    mov r3,0h
@@Ted:
    pop r4-r7
    bx r14	    	
.pool	
	
    
;--------------------------------OAM    	
 StandUpOAM:
.word 82E79D2h      ;蹲坐态
.word 02h
.word 82E7A7Ah      ;后边向上挺身体倾斜     
.word 04h
.word 82E7A42h      ;前后都挺起来 
.word 04h
.word 82E7962h      ;完全站立起来
.word 0Fh
.word 00000000h
.word 00000000h

StandOAM:
.word 82E7962h      ;完全站立起来
.word 0FFh
.word 00000000h
.word 00000000h

SitDownOAM:
.word 82E7962h      ;完全竖直用来下蹲
.word 0Fh
.word 82E799Ah      ;后边向下蹲头后倾
.word 08h
.word 82E79D2h      ;完全蹲下去
.word 08h         
.word 00000000h
.word 00000000h

TurnAround2OAM:
.word 82E7AB2h      ;转1 取向改变方向代表转2
.word 04h
.word 82E79D2h      ;转3
.word 04h
.word 00000000h
.word 00000000h

TurnAround1OAM:
.word 82e79d2h      ;转2 
.word 04h
.word 82E7AB2h      ;转3 蹲下蜷缩态
.word 04h
.word 00000000h
.word 00000000h

ReLeapForwardOAM:
.word 82e79d2h      ;蹲坐态
.word 02h
.word 82E7A7Ah      ;后边向上挺头前倾   
.word 04h
.word 82e782ah      ;行走头部前倾
.word 08h       
.word 00000000h
.word 00000000h

LeapForwardOAM:
.word 82e782ah      ;行走头部前倾
.word 08h       
.word 00000000h
.word 00000000h

ReJumpStraightOAM:
.word 82e79d2h      ;蹲坐态
.word 02h
.word 82E7A42h      ;前后都挺起来 
.word 04h
.word 82E7962h      ;完全站立起来
.word 0Fh
.word 00000000h
.word 00000000h

JumpStraightOAM:
.word 82E7962h      ;完全站立起来
.word 0Fh
.word 00000000h
.word 00000000h
   	
	
    	
    	
     	
    	
     

.pool
.close