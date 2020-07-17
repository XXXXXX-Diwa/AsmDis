.gba
.open "zm.gba",".gba",0x8000000
;SamusPhysical
.definelabel DivisionRoutine,0x808AC34
.definelabel Equipment,0x3001530


.org 0x8008F92
	bl CheckSpritesWallJump

.org 0x8008FC8
	bl CheckBlockWallAndSpriteWall
	
;.org 0x8006A8c
;	b 0x8006A98

	

.org 0x8008530        ;跑步的时候检查的二级加速累计值
	.db 17h           ;原先是77h
.org 0x8008534        ;二级加速给予的最大速度
	.db 78h			  ;原先是8Ch
	
.org 0x800851E        ;三级加速累计值
	.db 70h			  ;原先是8Bh 

.org 0x8006b4A        ;球滚跳调用速度,让速度减半...
    ;asr r0,r0,10h     ;改为保持原速
	bl RollBallJumpXSpeedKeep   ;球滚跳根据速度不同保持滚动的速度

.org 0x8006b54                  ;球滚跳根据速度不同增加球跳高度
	bl RollBallJumpYSpeedAdd

;跳跃中变成球 以及旋转跳射击不减向上的速度
.org 800A624h      ;Y值写入处
    bl AirMorphBallNoReturnYSpeed	 

.org 0x8009008    ;向前跳给予跳跃加速度和速度的最大值处
    bl NormalRunSpeedIntoJumpSpeed  ;跑步速度代入到跳跃中
    b 8009012h

.org 0x8008F02    ;姿势b,起跳相关的例程中,同时也是其它跳跃姿势的..
	bl RunXSpeedAddYSpeed	 ;根据跑步的速度增加跳跃的高度  

.org 0x8006A8E	  ;旋转跳变直立跳写入姿势处
	bl PoseDOneDownMorphBall    ;登墙跳中按一下下即可变成球
	
.org 0x80095D4	  ;空中球的速度写入处
	bl BallJumpKeepBallRollXSpeed

.org 0x8006DB8    ;球落地面变成正常球姿态写入处
	bl RollBallOrBall 
	
.org 0x8009446    ;空中球落到地面保持空中的速度
	bl BallDownFloorSpeedKeep

.org 0x8006D70
	b 8006D80h    ;可以防止一旦按住跳球落地既不弹跳也不跳跃
	
.org 0x8006D84
	bl XSpeedAffectsTheBallBounce 
.org 0x8006DAC    ;写入球落地弹跳的值处
    bl BallBounceNumberChange ;球落地弹跳根据下落的高度而算

.org 0x800A62E
	.dh 0xF000    ;下落累计值的最大限度
	
.org 0x8007704
	.db 0x0C0    ;下落速度最大值
	
;.org 0x800A60E
;	b 0x800A614
.org 0x8008F72   ;如果空间跳条件不成立则检测登墙跳
	bgt 0x8008F92
	
.org 0x8008F90   ;空间跳成立依然检测蹬墙跳
	nop

.org 0x8008F3C
	bl SpinJumpOneDownChangeMorph  ;旋转跳一键变球

.org 0x8009574
	bl AirBallChangeSpinJump       ;空中球直接变旋转跳

.org 0x8009534
	bl AirBallZeroSuitArmDirctionSet
	
.org 0x8009460
	bl ZeroSuitRollBallSpeedBooster

.org 0x80092F2            ;球pose11例程变回人处
	bl ZeroSuitBallPressRlCantUnMorphBallOnFloor
	cmp r0,0h        	;零式服球变人不会有过渡
	bne 0x80092FC
	b 8009386h
	
.org 0x8009308
	bl ZeroSuitBallUmMorphBallReturnBoosterFrames
	
.org 0x80093EE
	bl ZeroSuitRollingBallPressRlCantUnMorphBallOnFloor
	cmp r0,13h
	bne 0x8009432
	b 0x8009482
	
.org 0x827E9CC         ;让零式服的变球过渡调用1B不会有第二个动画
	.db 0              ;同时不会让有装甲的时候变球过渡死机
	
.org 8304054h
RollBallJumpXSpeedKeep:
	mov r2,16h
	ldsh r0,[r4,r2]
	mov r2,r0
	cmp r2,0h
	bge @@Pass
	neg r2,r2
@@Pass:
	cmp r2,60h                ;球滚速大于60则保持原速
	bhi @@end
	cmp r2,50h
	bcc @@Half
	mov r2,r0
	lsr r2,r2,1h
	lsr r0,r0,2h
	add r0,r2
	b @@end
@@Half:
	lsr r0,r0,1h
@@end:
	lsl r0,r0,10h
	lsr r0,r0,10h
	bx lr
.pool	
	
RollBallJumpYSpeedAdd:   
	push lr
	mov r2,16h
	ldsh r1,[r4,r2]  ;读取当前的X速度
	cmp r1,0h         
	bge @@Pass
	neg r1,r1
@@Pass:
	mov r0,0D4h
	sub r1,60h       ;X速度减去60
	cmp r1,0h        ;检查是否小于60
	blt @@end
	mov r2,60h
	mov r3,r0
	mul r0,r2       ;跳跃值乘以60h
	mul r1,r3       ;速度减去60的值乘以跳跃值
	add r0,r1
	mov r1,60h
	bl DivisionRoutine
@@end:
    strh r0,[r4,18h]
	pop r0
	bx r0
.pool	
	
AirMorphBallNoReturnYSpeed:   ;空中变球和旋转射击变直立不减向上的速度
    push r0-r3																																										
    ldrb r1,[r4]
	cmp r1,14h        ;检查姿势是否是空中球
	beq @@CheckJumpPress
	cmp r1,8h         ;检查姿势是否是空中直立
	bne @@Return
@@CheckJumpPress:	
    mov r1,r4         ;13d4
	sub r1,58h
	ldrh r2,[r1]      ;读取输入指令
	mov r3,1h
	and r3,r2
	cmp r3,0h
	beq @@Return
;------------------------如果按着跳的话	
    ldrh r2,[r1,4h]    ;更新的输入
	mov r3,80h
	and r3,r2          ;有下的话
	cmp r3,0h
	bne @@Goto
    mov r3,2h
    and r3,r2          ;有射击的话
    cmp r3,0h          
    beq @@Return	
@@Goto:	
	ldrh r3,[r4,18h]   ;读取当前的跳跃速度值是否等于0
	cmp r3,0h          ;PS:如果跳跃最大值能够被减速值整除会有问题
	bne @@Return
	add r1,90h
	mov r0,0h
	ldsh r5,[r1,r0]    ;读取备份的跳跃值
	strh r0,[r1]       ;让备份的跳跃值只能用一次
	mov r0,0Ah         ;跳跃高度减少值
@@Return:
    sub r0,r5,r0
	strh r0,[r4,18h]
	pop r0-r3
	bx r14
.pool
	
NormalRunSpeedIntoJumpSpeed:                    ;正常跑步速度代入到跳跃中
;	push r2
;	ldr r2,=30015e3h                   ;无重力在水中flag
    mov r0,16h
    ldsh r1,[r4,r0]  ;行走速度
	ldrh r0,[r4,0Eh]  ;面向
	cmp r0,10h
	beq @@FaceRight
;------------------------面左
    neg r1,r1
@@FaceRight:
    cmp r1,40h        ;如果值小于40h则默认最大为40h
    bcs @@NoDefault
    mov r1,40h
	b @@end
@@NoDefault:
	ldrb r0,[r4]
	cmp r0,0Bh        ;起跳姿势 竟然持续了两帧
	bne @@end
	ldrb r0,[r4,1Ch]
	cmp r0,1h
	bne @@end         ;检查是否是第一帧
	mov r0,r1
	sub r0,40h
	cmp r0,38h		  ;速度达到78则跑步的速度全保持
	bcs @@end
	lsr r1,r0,1h      ;没有达到78则多于40的全部减半
	add r1,40h
@@end:
	mov r0,8h         ;加速度
;	pop r2
    bx r14	
.pool

RunXSpeedAddYSpeed:
	push r0,lr
	ldrb r1,[r4]
	cmp r1,0Bh       
	bne @@CheckAirBallSpeedKeep
	ldrb r1,[r4,1Ch]
	cmp r1,1h        ;检查动画是否是1
	bne @@end         
	mov r2,16h
	ldsh r1,[r4,r2]
	cmp r1,0h         
	bge @@Pass
	neg r1,r1
@@Pass:
	ldrh r0,[r4,18h]
	sub r1,60h       ;X速度减去60
	cmp r1,0h        ;检查是否小于60
	blt @@end
	mov r2,60h
	mov r3,r0
	mul r0,r2       ;跳跃值乘以60h
	mul r1,r3       ;速度减去60的值乘以跳跃值
	add r0,r1
	mov r1,60h
	bl DivisionRoutine
	strh r0,[r4,18h]
@@CheckAirBallSpeedKeep:
	mov r3,r4
	add r3,20h
	ldrb r0,[r3]
	cmp r0,14h      ;检查上一个姿势是否是空中球
	bne @@end
	mov r1,16h
	ldrh r0,[r3,r1]
	strh r0,[r4,16h] ;空中球的XY速度都写入旋转跳
	mov r1,18h
	ldrh r0,[r3,r1]
	strh r0,[r4,18h]
	mov r0,0Bh
	strb r0,[r3]
@@end:
	pop r0
	add r0,5Ch
	ldrb r0,[r0]
	pop r1
	bx r1
.pool

PoseDOneDownMorphBall:         ;旋转跳按下直立写入处
	push lr
	ldrb r0,[r2,12h]
	cmp r0,2h
	beq @@NoOneDownMorph ;零式服无法使用登墙一键变球
	ldrb r0,[r4]
	cmp r0,0Dh		;当前姿势如果是蹬墙跳的话
	bne @@NoOneDownMorph
	mov r1,r4
	sub r1,58h
	ldrh r0,[r1]
	mov r1,80h
	and r1,r0
	cmp r1,0h
	beq @@NoOneDownMorph
;	mov r0,0h
;	strh r0,[r4,16h]      ;X速度归零
	ldr r1,=Equipment
	ldrb r0,[r1,0Fh]
	mov r1,1h
	and r1,r0
	cmp r1,0h
	beq @@NoHighJump
	mov r0,0E8h
	b @@WriteJumpNumber
@@NoHighJump:
	mov r0,0C0h
@@WriteJumpNumber:
	strh r0,[r4,18h]     ;Y速度
	mov r0,77h
	bl 0x8002A18
	mov r1,14h
	b @@WritePose
@@NoOneDownMorph:
	mov r1,8h
@@WritePose:
	strb r1,[r4]
	pop r15 
	.pool

BallJumpKeepBallRollXSpeed:      ;球跳保持球滚的速度
	push r4,lr                      ;同时旋转跳变球保持跑步速度
	mov r3,r4
	add r3,20h
	ldrh r2,[r3]		;上一个姿势
	cmp r2,12h          ;如果是球滚的话
	beq @@CountureCheck
	cmp r2,0h           ;如果是奔跑的话
	bne @@PassBallRollSpeedKeep
@@CountureCheck:	
	mov r2,16h
	ldsh r4,[r4,r2]     ;当前球的X速度
	mov r2,r4
	cmp r4,0h
	bge @@Pass
	neg r2,r2
@@Pass:
	cmp r2,30h
	bcc @@PassBallRollSpeedKeep ;保证了空中球的最低最大速度限制也有30h
	mov r2,16h
	ldsh r2,[r3,r2]	    ;上个姿势时球的X速度
	cmp r4,r2           ;如果奔跑速度没有达到78则人形无法保持空中速度和奔跑速度一样
	beq @@AirBallKeepBeforeSpeed ;也就是只有达到78才能继承地面速度
	mov r1,r4           ;没达到就继承空中的人形速度
	b @@Peer
@@AirBallKeepBeforeSpeed:
	mov r1,r2
@@Peer:	
	cmp r1,0h
	beq @@ReturnNormalSpeed
	bge @@end
	neg r1,r1
	b @@end
@@ReturnNormalSpeed:    ;一旦撞墙
	mov r1,30h
	strh r1,[r3,16h]	;上一个姿势的球的X速度写入30h
	b @@end
@@PassBallRollSpeedKeep:
	mov r2,0h
	ldsh r1,[r1,r2]     ;正常球空中的最大速度30h
@@end:
	pop r4
;	mov r2,0h
;	strh r2,[r4,0Ah]    ;归零加速值
	mov r2,r4
	pop r15
	.pool

RollBallOrBall:         ;仅仅是根据按不按方向是否给予球滚pose
	mov r0,r4
	sub r0,58h
	ldrh r0,[r0]
	mov r2,31h
	and r2,r0
	cmp r2,0h
	beq @@NoPressDirctionOrJump
	mov r0,12h
	b @@end
@@NoPressDirctionOrJump:
	mov r0,11h
@@end:
	ldr r2,=8006E52h
	mov r15,r2
	.pool
	
BallDownFloorSpeedKeep:  
	push r2
	mov r3,r4            
	add r3,20h
	ldrb r1,[r3]       ;上一个姿势
	cmp r1,14h         ;空中球
	bne @@NoAirBallDownFloor	
	mov r2,16h
	ldsh r1,[r3,r2]   ;读取空中球X速度
	strh r1,[r4,16h]  ;写入当前的X速度 同时作为最大速限制
@@CheckSpeedLessNormalSpeedCap:	
	cmp r1,0h
	bge @@Pass
	neg r1,r1
@@Pass:	
	mov r2,26h
	strh r2,[r3]      ;上一个姿势写入球冲
	cmp r1,60h        ;如果空中的速度小于60h则按60算
	bcc @@ReturnNormalSpeedCap
	b @@end
@@NoAirBallDownFloor:
	mov r2,16h
	ldsh r1,[r4,r2]
	b @@CheckSpeedLessNormalSpeedCap
@@ReturnNormalSpeedCap:
	mov r3,0h
	ldsh r1,[r0,r3]
@@end:
	pop r2
	bx lr
	.pool
	
XSpeedAffectsTheBallBounce:
	mov r0,r4
	sub r0,58h
	ldrh r0,[r0]
	mov r2,30h
	and r2,r0          ;检查是否按了左右方向
	mov r0,0C0h
	cmp r2,0h
	beq @@end
	mov r0,r4
	add r0,20h
	mov r2,16h         ;读取上一个姿势的速度
	ldsh r0,[r0,r2]
	cmp r0,0h
	bge @@Pass
	neg r0,r0
@@Pass:
	lsr r0,r0,2h       ;速度除以4
	sub r0,0C0h
	neg r0,r0
@@end:
	neg r0,r0
	bx lr
.pool

BallBounceNumberChange:  ;球弹高度设置
	mov r0,r4
	add r0,20h
	mov r1,18h
	ldsh r0,[r0,r1]
	neg r0,r0
	lsr r0,r0,2h
	cmp r0,32h
	bhi @@Pass
	mov r0,32h
@@Pass:	
	strh r0,[r4,18h]
	bx lr
	.pool
	
SpinJumpOneDownChangeMorph:
	push lr
	mov r0,r4
	add r0,20h
	ldrb r0,[r0,2h]  ;检测上一个姿势的炮管方向
	cmp r0,2h        ;是否是斜下
	bne @@end
	ldrh r0,[r2]
	mov r3,80h
	lsl r3,r3,2h     ;检测是否按了L键
	and r3,r0
	cmp r3,0h
	beq @@end
	mov r3,30h
	and r3,r0
	cmp r3,0h        ;检测是否按了左右方向
	beq @@end
	ldrh r0,[r2,4h]  ;读取即时输入
	mov r3,80h
	and r3,r0
	cmp r3,0h        ;是否按了下
	beq @@end
	mov r0,14h
	strh r0,[r4]     ;Pose 写入空中球	
	push r1
	mov r0,77h       ;播放变球的声音
	bl 8002A18h
	pop r1
	mov r0,r1
	add r0,4Fh
	ldrb r0,[r0]
	cmp r0,1h        ;只有是上升的时候才会归零
	beq @@end
	mov r0,0h
	strh r0,[r4,18h] ;Y速度归零防止弹跳
@@end:
	mov r0,r1
	add r0,68h
	pop r15
    .pool

AirBallChangeSpinJump: ;空中球变人处
	mov r0,8h          ;默认直立
	mov r3,r4
	sub r3,58h         ;按键输入RAM
	ldr r1,=3001542h
	ldrb r1,[r1]       ;检查是否是零式服
	cmp r1,2h
	bne @@NoZeroSuit   ;是的话变直立	
	mov r1,0h
	strb r1,[r4,8h]   ;去除金身蓄力
	b @@end
@@NoZeroSuit:
	ldrh r2,[r3]	
	mov r1,80h
	lsl r1,r1,2h
	and r1,r2
	cmp r1,0h          ;检查是否按着L键
	beq @@Pal
	mov r1,30h
	and r1,r2
	cmp r1,0h          ;检查是否按着方向
	beq @@Pal
	mov r0,0Ch
@@Pal:
	mov r1,0Fh
	strb r1,[r4,9h]    ;变色调色板
@@end:	
	bx lr
	.pool

AirBallZeroSuitArmDirctionSet:
	sub r3,r0,4
	ldr r2,=Equipment
	ldrb r1,[r2,12h]
	cmp r1,2h
	bne @@NoZeroSuit
	ldrh r1,[r3]
	mov r0,40h
	and r0,r1
	cmp r0,0h
	bne @@PressUp
	mov r0,80h
	and r0,r1
	cmp r0,0h
	bne @@PressDown
	;----------------上下皆无
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	bne @@PressL
	mov r0,0h
	b @@WriteArmDicrtion
	.pool
@@PressL:
	mov r0,1h
	b @@WriteArmDicrtion	
@@PressUp:
	ldrh r1,[r3,4h]
	mov r0,40h
	and r0,r1
	cmp r0,0h
	beq @@PassCheckHoldR
	ldrh r1,[r3]
	mov r0,80h
	lsl r0,r0,1
	and r0,r1
	cmp r0,0h
	beq @@OnceAgainUmMorphCheck
@@PassCheckHoldR:
	ldrh r1,[r3]
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	bne @@PressL
	mov r0,3h
	b @@WriteArmDicrtion
@@PressDown:
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	beq @@OnlyDown
	mov r0,2h
	b @@WriteArmDicrtion
@@OnlyDown:
	mov r0,4h
@@WriteArmDicrtion:
	strb r0,[r4,2h]	
	mov r0,0h
	b @@end	
@@OnceAgainUmMorphCheck:
	mov r0,1h
	b @@end
@@NoZeroSuit:	
	mov r0,40h
	and r0,r1
@@end:
	bx lr
	.pool
	
ZeroSuitRollBallSpeedBooster:
	push r4,r5,lr
	ldr r5,=3001588h        
	ldr r3,=3001530h
	ldrb r0,[r3,12h]        ;检查是否是零式服
	cmp r0,2h
	bne @@SpeedBoostering   ;不是的话直接把当前的r1当做最大限度
	ldrb r2,[r3,0Fh]
	mov r0,2h
	and r0,r2
	cmp r0,0h               ;检查是否有加速能力
	beq @@SpeedBoostering
	mov r0,r5
	add r0,5Bh
	ldrb r0,[r0]
	cmp r0,0h               ;无重力在水中flag
	bne @@SpeedBoostering
	ldrb r2,[r4,0Ah]        ;读取加速累计值
	cmp r2,70h      
	bls @@PassMaxSpeedCap
	mov r1,0A0h             ;一旦加速累计值达到70则最大速为A0
	b @@PassSecSpeedCap
@@PassMaxSpeedCap:
	cmp r2,17h
	bls @@PassSecSpeedCap
	mov r1,78h              ;一旦加速累计值达到18则最大速为8Ch
@@PassSecSpeedCap:
	ldrh r0,[r4,16h]        ;读取当前的X速度
	add r0,5Fh
	lsl r0,r0,10h
	lsr r0,r0,10h
	cmp r0,0BEh
	bls @@ReturnAddSpeedBooster
	cmp r2,9Fh
	bhi @@SpeedBoostering
	add r0,r2,1
	b @@SpeedBoosterNumberWrite
@@ReturnAddSpeedBooster:
	mov r0,0h
@@SpeedBoosterNumberWrite:
	strb r0,[r4,0Ah]	
@@SpeedBoostering:
	mov r2,r5
	add r2,5Eh
	mov r0,0h
	ldsh r0,[r2,r0]         ;加速值
	mov r2,r4
	bl 8008278h             ;X移动例程
	pop r4,r5
	pop r1
	bx r1
.pool

ZeroSuitBallPressRlCantUnMorphBallOnFloor:   ;地面零式球按住R则不会变成人形
	push r5
	ldr r1,=3001530h
	ldrh r1,[r1,12h]
	cmp r1,2h
	bne @@NoZeroSuit
	sub r0,4h
	mov r5,r0
	ldrh r1,[r0]
	mov r0,40h
	and r0,r1
	cmp r0,0h
	bne @@PressUp
	mov r0,80h
	and r0,r1
	cmp r0,0h
	bne @@PressDown
	;----------------上下皆无
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	bne @@PressL
	mov r0,0h
	b @@WriteArmDicrtion
@@PressL:
	mov r0,1h
	b @@WriteArmDicrtion	
@@PressUp:
	ldrh r1,[r5,4h]
	mov r0,40h
	and r0,r1
	cmp r0,0h
	beq @@PassCheckHoldR
	ldrh r1,[r5]
	mov r0,80h
	lsl r0,r0,1
	and r0,r1
	cmp r0,0h
	beq @@OnceAgainUmMorphCheck
@@PassCheckHoldR:
	ldrh r1,[r5]
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	bne @@PressL
	mov r0,3h
	b @@WriteArmDicrtion
@@PressDown:
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	beq @@OnlyDown
	mov r0,2h
	b @@WriteArmDicrtion
@@OnlyDown:
	mov r0,4h
@@WriteArmDicrtion:
	strb r0,[r4,2h]
@@PoseZero:	
	mov r0,0h
	b @@end	
@@OnceAgainUmMorphCheck:
	add r0,r5,4
@@NoZeroSuit:
	ldrh r1,[r0]
	mov r0,40h
	and r0,r1
@@end:
	pop r5
	bx r14
.pool

ZeroSuitBallUmMorphBallReturnBoosterFrames:
	lsl r0,r0,18h
	lsr r0,r0,18h
	ldr r1,=Equipment
	ldrb r1,[r1,12h]
	cmp r1,2h
	bne @@end
	cmp r0,0h
	beq @@ReturnBoosterFrames
	cmp r0,1h
	beq @@ReturnBoosterFrames
	cmp r0,8h
	bne @@end
@@ReturnBoosterFrames:
	mov r1,0h
	strb r1,[r4,8h]
@@end:
	bx lr
.pool	
	
ZeroSuitRollingBallPressRlCantUnMorphBallOnFloor:
	push r5,lr
	ldr r3,=300137Ch
	ldr r0,=3001530h
	mov r5,r0
	ldrb r0,[r0,12h]
	cmp r0,2h
	beq @@ZeroSuit	
	ldrh r1,[r3,4h]
	mov r0,40h
	and r0,r1
	cmp r0,0h
	beq @@PoseFF
@@OnceAgainUmMorphCheck:	
	ldr r0,=823A554h
	mov r2,4h
	ldsh r1,[r0,r2]
	mov r0,r4
	bl 80057ECh
	cmp r0,0h
	bne @@PoseFF
	ldrb r0,[r5,12h]
	cmp r0,2h
	bne @@PassBoosterFramesReturn
	mov r0,0h
	strb r0,[r4,8h]
@@PassBoosterFramesReturn:	
	mov r0,78h
	bl 8002A18h
	mov r0,13h
	b @@end
	.pool
@@ZeroSuit:
	ldrh r1,[r3]
	mov r0,40h
	and r0,r1
	cmp r0,0h
	bne @@PressUp
	mov r0,80h
	and r0,r1
	cmp r0,0h
	bne @@PressDown
	;----------------上下皆无
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	bne @@PressL
	mov r0,0h
	b @@WriteArmDicrtion
@@PressL:
	mov r0,1h
	b @@WriteArmDicrtion	
@@PressUp:
	ldrh r1,[r3,4h]
	mov r0,40h           ;检查是否即时输入了up
	and r0,r1
	cmp r0,0h
	beq @@PassRHoldCheck
	ldrh r1,[r3]
	mov r0,80h
	lsl r0,r0,1h
	and r0,r1
	cmp r0,0h
	beq @@OnceAgainUmMorphCheck
@@PassRHoldCheck:
	ldrh r1,[r3]
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	bne @@PressL
	mov r0,3h
	b @@WriteArmDicrtion
@@PressDown:
	mov r0,80h
	lsl r0,r0,2h
	and r0,r1
	cmp r0,0h
	beq @@OnlyDown
	mov r0,2h
	b @@WriteArmDicrtion
@@OnlyDown:
	mov r0,4h
@@WriteArmDicrtion:
	strb r0,[r4,2h]
@@PoseFF:	
	mov r0,0FFh
@@end:
	pop r5
	pop r1
	bx r1
.pool


	
.org 0x8345b4A
     .byte 05h	  ;缓慢空砖的阶段1帧数	test
	 ;为5则速度78h即可通过
	 ;为4则速度需要A0....
.close