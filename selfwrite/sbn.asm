.gba
.open "zm.gba","spiderBall.gba",0x8000000
;by : JumZhu.Diwa
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel CheckSlope,800F360h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel Division,808AC34h
.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
.definelabel SamusHeightStage,30015DFh	;站0 蹲1 球2
;实现蜘蛛球
;笔记:
;球形态按上/下/左/右+L,若上/下/左/右有墙面,则会激活蜘蛛球
;按下+L不单单可以黏住地面,同样可以黏住天花板
;按下+L(必须有一个是即时的按键)可以取消任意情况的蜘蛛球

;3001384为蜘蛛球Pose 1 地面接壤 2 天花板接壤 3 左墙接壤 4 右墙接壤
;3001385为蜘蛛球持续行动值详见下
;1385-8bit标明了持续的按键方向,具体为 右10 左20 上40 下80
;1385-4bit为当确认了按键方向按着,蜘蛛球时只有向下或向右移动时为1
;1385在蜘蛛球激活后会变成2,来控制必须即时按下+L才能取消激活蜘蛛球
;1385在蜘蛛球时被炸弹炸到会失去蜘蛛球并得到8这个数,从8每帧递减1,到2才能再次激活蜘蛛球

;球态 球滚 球空中三种检查
.org 800924Eh
	bl 		TheSpiderBall
	
.org 8009532h
	bl 		TheSpiderBall
	
.org 80093C2h
	bl		TheSpiderBall
	
.org 80077ACh					;更改合适的动画
	bl		BallAnimationControl
	
.org 800B4CAh					;更改全装+重力服调色板
	mov 	r3,2h
	bl		SpiderBallPaletteChanged
;正常游戏中,开启重力的前提就是全装	
.org 800B522h					;更改全装 无重力调色板
	mov		r3,3h
	bl		SpiderBallPaletteChanged
;正常游戏中真的有用到这一段吗!重力无法关闭,而全装后重力就开启
.org 800B57Eh					;更改非全装+隔热调色板
	mov		r3,1h
	bl		SpiderBallPaletteChanged
;mage的调试模式会改变一些调用,使全装+隔热成为可能		
.org 800B5CEh					;更改无全装无隔热调色板
	mov		r3,0h
	bl		SpiderBallPaletteChanged
;就是开始的服装啦!	

.org 8761D38h					;末尾无用数据
.align
SpiderBallPalette:
.import "spiderBall.palette"

;偏移0为基础服的蜘蛛球调色板
;偏移20为上面的残影调色
;偏移40为基础服的蜘蛛球金身调色板

;偏移A0为隔热服的蜘蛛球调色板
;偏移C0为上面的残影调色
;偏移E0为隔热服的蜘蛛球金身调色板

;偏移140为重力服的蜘蛛球调色板
;偏移160为上面的残影调色
;偏移180为重力服的蜘蛛球金身调色板

;偏移1E0为全力服的蜘蛛球调色板
;偏移200为上面的残影调色
;偏移220为全力服的蜘蛛球金身调色板
	
.org 8304054h					;无用数据的地址
TheSpiderBall:
	push	r0,lr
	mov		r2,0h
	ldr		r0,=3001542h		;当前的装甲
	ldrb	r0,[r0]
	cmp		r0,2h				;非零式服才会激活蜘蛛球
	beq		@@CorrectReturn
	bl		SpiderBallMain
@@CorrectReturn:
	pop		r0	
	ldr		r1,=30013D4h
	ldrb	r1,[r1]
	cmp		r2,0h				;标记了蜘蛛球的Pose
	bne		@@OtherCome
	cmp		r1,11h				;地面球
	beq		@@MorphNormalPose
	cmp		r1,12h				;滚动球
	beq		@@MorphRollingPose
	cmp		r1,14h				;空中球
	bne		@@end
	ldrh	r1,[r0]
	mov		r0,40h
	b 		@@end
.pool
@@MorphNormalPose:
	mov		r4,r0
	ldrb	r0,[r4,4h]
	b 		@@end
@@MorphRollingPose:
	ldrh	r1,[r0]
	mov		r2,1h
	b		@@end
@@OtherCome:
	pop		r3
	cmp		r1,11h
	beq		@@MorphNormalSpiderBallPose
	cmp		r1,12h
	beq		@@MorphRollingSpiderBallPose
	ldr		r3,=80095FAh
	b		@@SpiderBallRetrun
	.pool
@@MorphNormalSpiderBallPose:
	ldr		r3,=80093AAh
	b		@@SpiderBallRetrun
	.pool
@@MorphRollingSpiderBallPose:
	ldr		r3,=8009464h
	b		@@SpiderBallRetrun
	.pool
@@end:
	pop		r3
@@SpiderBallRetrun:	
	mov		r15,r3
.pool
	
SpiderBallMain:
	push	r4-r7,lr
	ldr		r0,=300137Ch		;输入
	ldr		r6,=XTagRAM
	mov		r7,0F0h
	mov		r4,r0
	mov		r5,r4
	add		r5,58h				;得到13d4
	bl		SpiderBallSuitableControl
	bl		SpiderBallCheckRemove
	bl		SpiderBallPreciseCoordinates
	ldrb	r0,[r4,8h]
	lsl		r0,r0,2h
	ldr		r1,=SpiderBallPoseTable
	add		r0,r1
	ldr		r0,[r0]
	mov		r15,r0
.pool
SpiderBallPoseTable:
	.word	SpiderBallCheckFlag
	.word	SpiderBallOnFloor
	.word	SpiderBallOnCeiling
	.word 	SpiderBallOnLeftWall
	.word	SpiderBallOnRightWall
SpiderBallCheckFlag:
	bl		SpiderBallCheckFlagPose
	b		@Thend
SpiderBallOnFloor:
	bl		SpiderBallOnFloorPose
	b		@Thend
SpiderBallOnCeiling:
	bl		SpiderBallOnCeilingPose
	b 		@Thend
SpiderBallOnLeftWall:
	bl		SpiderBallOnLeftWallPose
	b		@Thend
SpiderBallOnRightWall:
	bl		SpiderBallOnRightWallPose
	
@Thend:	
	ldrb	r2,[r4,8h]
	pop		r4-r7
	pop		r1
	bx		r1
.pool
	
SpiderBallPreciseCoordinates:	;随时使蛛球贴墙修正门切换改动坐标
	ldrb	r1,[r4,8h]			;读取蜘蛛球Pose
	cmp		r1,1h				;如果大于1的话
	bls		@@end
	cmp		r1,2h
	bhi		@@NoCeilingPose
	ldrh	r0,[r5,14h]			;纠正Y坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]
	b 		@@end
@@NoCeilingPose:
	ldrh	r0,[r5,12h]			;纠正X坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	cmp		r1,3h
	bne		@@RightWallPose
	add		r0,1Ch
	b		@@WriteFixX
@@RightWallPose:
	add		r0,23h
@@WriteFixX:
	strh	r0,[r5,12h]
@@end:
	bx		r14
.pool	

SpiderBallCheckRemove:			;检查蜘蛛球的解除
	push	r4-r7,lr
	add		sp,-10h
	mov		r2,r5
	add		r2,20h				;13F4
	ldrb	r0,[r2]				;读取上一个姿势
	cmp		r0,31h				;球受伤1的话
	beq		@@AllReturnSpiderBallZero
	cmp		r0,32h				;球受伤2的话
	beq		@@AllReturnSpiderBallZero
	ldrb	r1,[r4,9h]
	cmp		r1,2h
	bne		@@PassAllReturnZero
	cmp		r0,27h				;球冲刺结束
	bne		@@end
	mov		r0,20h
	strb	r0,[r2]				;改变上一个Pose值防止反复
@@AllReturnSpiderBallZero:
	mov		r0,0h
	strh	r0,[r4,8h]			;全部归零
	b		@@end	
@@PassAllReturnZero:	
	ldrb	r0,[r4,8h]
	cmp		r0,0h				;检查蜘蛛球启动
	beq		@@end				;没有启动则结束
	ldrh	r0,[r4]				;读取输入
	mov		r1,0A0h
	lsl		r1,r1,2h
	and		r0,r1
	lsr		r0,r0,2h
	cmp		r0,0A0h
	bne		@@CheckBombContact				;检查是否按了下和L
	ldrh	r0,[r4,4h]			;读取即时输入
	and		r0,r1
	cmp		r0,0h				;有即时输入则取消蜘蛛球
	beq		@@CheckBombContact
	; beq		@@end
	mov		r0,0h				;而且要标记取消
	strb	r0,[r4,8h]
	mov		r0,1h
	strb	r0,[r4,9h]			;标记了取消的标记
	ldr		r0,=24Fh
	bl		PlaySound2
	b		@@end
	.pool
@@CheckBombContact:
	ldr		r7,=3000A2Ch		;弹药数据地址
	ldr		r6,=30015D8h		;人物判定地址
@@Loop:	
	ldrb	r0,[r7]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h				;检查是否是有效的弹丸
	beq		@@NextPro			;无效则检查下一个
	ldrb	r0,[r7,0Fh]
	cmp		r0,0Eh				;检查是否是炸弹
	bne		@@NextPro			;不是检查下一个
	ldrb	r0,[r7,11h]
	cmp		r0,3h				;检查炸弹的节奏是爆炸>
	bne		@@NextPro			;不是检查下一个
	ldrh	r0,[r7,8h]			;炸弹的Y坐标
	ldrh	r1,[r7,14h]			;炸弹的上部判定
	add		r1,r0
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	str		r1,[sp]				;蛋极上
	ldrh	r1,[r7,16h]			;炸弹的下部判定
	add		r1,r0
	str		r1,[sp,4h]			;蛋极下
	ldrh	r0,[r7,0Ah]			;炸弹的X坐标
	ldrh	r1,[r7,18h]			;炸弹的左部判定
	add		r1,r0
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	str		r1,[sp,8h]			;蛋极左
	ldrh	r1,[r7,1Ah]			;炸弹的右部判定
	add		r1,r0
	str		r1,[sp,0Ch]			;蛋极右
	ldrh	r1,[r5,12h]			;人物的X坐标
	ldrh	r2,[r6]				;人物的左部判定
	add		r2,r1
	lsl		r2,r2,10h
	lsr		r2,r2,10h			;人极左
	ldrh	r3,[r6,2h]			;人物的右部判定
	add		r3,r1				;人极右
	ldrh	r1,[r5,14h]			;人物的Y坐标 人极下
	ldrh	r0,[r6,4h]			;人物的上部判定
	add		r0,r1
	lsl		r0,r0,10h
	lsr		r0,r0,10h			;人极上
	bl		800E6F8h			;检查是否相交
	cmp		r0,0h
	beq		@@NextPro
	; b		@@AllReturnSpiderBallZero
	mov		r0,0h
	strb	r0,[r4,8h]
	mov		r0,8h
	strb	r0,[r4,9h]
	b		@@end
.pool
@@NextPro:
	add		r7,1Ch
	ldr		r0,=3000BECh		;弹药数据结束地址
	cmp		r7,r0
	bcc		@@Loop
@@end:
	add		sp,10h
	pop		r4-r7
	pop		r1
	bx		r1
.pool	
	
SpiderBallSuitableControl:		;用于处在两璧间的改变Pose
	push	lr
	ldrb	r0,[r4,9h]
	cmp		r0,0h
	bne		@@EndTransferStation				;如果是持续按键则结束
	ldrb	r2,[r4,8h]
	cmp		r2,0h
	beq		@@EndTransferStation				;没有开启蜘蛛球则结束
	cmp		r2,2h
	bhi		@@LeftAndRightWallPose
	ldrb	r3,[r4]				;读取输入
	mov		r1,30h				;检查上下接壤的是否按了左右
	and		r1,r3
	cmp		r1,0h
	bne		@@EndTransferStation				;如果按了左右则结束
	mov		r1,0C0h				;没有按左右则检查是否按了上下
	and		r1,r3
	cmp		r1,0h
	beq		@@EndTransferStation				;没有按上下则结束
	cmp		r2,1h
	bne		@@CeilingPose		;检查是否是地面接壤
	mov		r1,40h
	and		r1,r3				;检查是否按的上
	cmp		r1,0h				;按了上的话
	bne		@@CheckInSide		;检查内角
	ldrh	r0,[r5,14h]			;检查外角
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@FloorLeftDownNoBlock
	ldrh	r0,[r5,14h]			;右外角判断
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@EndTransferStation				;如果两边都有砖则结束
	mov		r0,81h				;按下的向右移动
	b 		@@WriteNewStillingPress
@@FloorLeftDownNoBlock:			
	mov		r0,80h				;按下的向左移动
	b		@@WriteNewStillingPress	
@@CeilingPose:
	mov		r1,80h
	and		r1,r3
	cmp		r1,0h				;天花板按了下的话
	bne		@@CheckInSide		;检查内角
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,60h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@CeilingRightUpNoBlock
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,60h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@EndTransferStation				;两边都有砖块则结束
	mov		r0,40h				;按上的向左移动
	b		@@WriteNewStillingPress
@@CeilingRightUpNoBlock:		;如果右上没有砖的话
	mov		r0,41h				;按上的向右移动
	b		@@WriteNewStillingPress
@@CheckInSide:	
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	sub		r1,3Ch				;多减半格像素			
	bl		CheckBlock			;检查是否左边有接壤
	ldrb	r0,[r6,1h]
	and		r0,r7				
	cmp		r0,0h
	beq		@@CheckRightWall	;左边没有接壤则检查右边
	; ldrh	r0,[r5,12h]			;纠正坐标
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; add		r0,1Ch
	; strh	r0,[r5,12h]
	ldrb	r0,[r4,8h]
	cmp		r0,1h
	bne		@@CeilingPoseInsideLeft
	mov		r0,40h
	b		@@WriteNewStillingPress	;地面接壤按上的向左移动
@@CeilingPoseInsideLeft:
	mov		r0,80h
	b		@@WriteNewStillingPress	;天花板按下向左移动
	; mov		r2,3h				;左边接壤则写入新Pose
	; b		@@WriteNewPose
@@EndTransferStation:
	b		@@end
	
@@CheckRightWall:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	add		r1,3Ch				;多加半格像素
	bl		CheckBlock			;检查右边是否有接壤
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h	
	beq		@@end				;右边没有接壤则结束
	; ldrh	r0,[r5,12h]			;纠正坐标
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; add		r0,23h
	; strh	r0,[r5,12h]
	ldrb	r0,[r4,8h]
	cmp		r0,1h
	beq		@@FloorPoseInsideRight
	mov		r0,81h
	b		@@WriteNewStillingPress
@@FloorPoseInsideRight:
	mov		r0,41h
	b		@@WriteNewStillingPress
	; mov		r2,4h
	; b		@@WriteNewPose		;右边接壤则写入新Pose	
@@LeftAndRightWallPose:	
	ldrb	r3,[r4]
	mov		r1,0C0h				;检查是否按了上下
	and		r1,r3
	cmp		r1,0h
	bne		@@end				;按了上下则结束
	mov		r1,30h				
	and		r1,r3				;检查是否按了左右
	beq		@@end				;没有按左右则结束
	mov		r1,20h
	and		r1,r3				;检查是否按了左
	cmp		r1,0h
	beq		@@PressRight
	ldrb	r0,[r4,8h]			;蛛球Pose
	cmp		r0,4h				;是否是左墙接壤
	beq		@@LeftAndRightWallInside ;右墙按左是内角
	ldrh	r0,[r5,14h]			;左接壤按左
	ldrh	r1,[r5,12h]
	add		r0,4h				
	sub		r1,20h				
	bl		CheckBlock			;检查下左
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@LeftWallDownLeftNoBlock
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,20h				;检查上左
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@end				;上下都有砖则结束
	mov		r0,20h				;左按键上移动
	b		@@WriteNewStillingPress
@@LeftWallDownLeftNoBlock:		;左接壤左下没有砖
	mov		r0,21h				;左按键下移动
	b 		@@WriteNewStillingPress
@@PressRight:
	ldrb	r0,[r4,8h]			
	cmp		r0,4h				;检查是否不是右墙接壤
	bne		@@LeftAndRightWallInside	;不是则内角检查
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,20h
	bl		CheckBlock			;右墙接壤右按键检查右上
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@RightWallPoseRightUpNoBlock
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,4h
	add		r1,20h
	bl		CheckBlock			;检查右下
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@end				;右墙接壤上下都有砖则结束
	mov		r0,11h				;右接壤按右下移动
	b		@@WriteNewStillingPress
@@RightWallPoseRightUpNoBlock:
	mov		r0,10h				;右接壤按右上移动
	b		@@WriteNewStillingPress
@@LeftAndRightWallInside:	
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h				;向下半格像素			
	bl		CheckBlock			;检查地面是否接壤
	ldrb	r0,[r6,1h]			
	cmp		r0,0h
	beq		@@CheckCeiling		;地面没有接壤则检查天花板
	; ldrh	r0,[r5,14h]			;纠正坐标
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; add		r0,3Fh
	; strh	r0,[r5,14h]
	ldrb	r0,[r4,8h]
	cmp		r0,3h
	bne		@@RightWallPressLeftMoveDown
	mov		r0,11h				;左墙按右向下移动
	b		@@WriteNewStillingPress
@@RightWallPressLeftMoveDown:	
	mov		r0,21h				;右墙按左向下移动
	b		@@WriteNewStillingPress
@@CheckCeiling:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,5Ch				;向上半格像素
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@end				;天花板也没有接壤则结束
	; ldrh	r0,[r5,14h]			;纠正坐标
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; sub		r0,4h
	; strh	r0,[r5,14h]
	ldrb	r0,[r4,8h]
	cmp		r0,4h
	bne		@@LeftWallPosePressRightUpMove
	mov		r0,20h				;右墙接壤左按向上移动
	b		@@WriteNewStillingPress
@@LeftWallPosePressRightUpMove:	
	mov		r0,10h				;左墙接壤右按向上移动
@@WriteNewStillingPress:
	strb	r0,[r4,9h]
@@end:	
	pop		r1
	bx		r1
.pool		
	
SpiderBallCheckFlagPose:		;检查是否要开启蜘蛛球
	push	lr
	ldrb	r0,[r4,9h]
	cmp		r0,3h
	bcc		@@CanSpiderBall
	sub		r0,1h
	strb	r0,[r4,9h]
	b 		@@end
@@CanSpiderBall:	
	ldrh	r0,[r4]
	mov		r1,88h
	lsl		r1,r1,2h
	and		r1,r0
	lsr		r1,r1,2h
	cmp		r1,88h				;检查是否按了左+L
	beq		@@LeftWallCheck
	mov		r1,84h
	lsl		r1,r1,2h
	and		r0,r1
	cmp		r0,r1				;检查是否按了右+L
	beq		@@RightWallCheck
@@UpDownCheck:	
	ldrh	r0,[r4]				;读取输入
	mov		r1,0A0h
	lsl		r1,r1,2h
	and		r0,r1				;检查是否按了下+L
	cmp		r0,r1
	beq		@@DisFlagCheck
	ldrh	r0,[r4]
	mov		r1,90h				;检查是否按了上+L
	lsl		r1,r1,2h
	and		r0,r1
	cmp		r0,r1
	; beq		@@InstantUPOrLCheck
	beq		@@CeilingCheck
	b 		@@end
; @@InstantUPOrLCheck:	
	; ldrh	r0,[r4,4h]			;检查即时输入L或上
	; and		r0,r1
	; cmp		r0,0h				
	; bne		@@CeilingCheck
	; b		@@end
@@DisFlagCheck:
	ldrb	r0,[r4,9h]			;检查刚刚取消的标记
	cmp		r0,0h				;如果刚刚取消则为1
	beq		@@CheckUpDown
	cmp		r0,1h				
	bhi		@@CheckPressing		;大于1才会继续检查即时输入
	add		r0,1h
	strb	r0,[r4,9h]			;+1 让即时输入检查在下一帧开始,防止激活后立马又关闭
	b 		@@end
@@CheckPressing:
	ldrh	r0,[r4,4h]						
	and		r1,r0				;检查下或L是否有即时输入的
	cmp		r1,0h
	bne		@@DisFlagReturnZero
	b 		@@end
@@DisFlagReturnZero:
	mov		r0,0h
	strb	r0,[r4,9h]			;刚刚取消标记去除
@@CheckUpDown:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	sub		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	; and		r0,r7
	cmp		r0,0h
	bne		@@FloorBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	add		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	; and		r0,r7
	cmp		r0,0h
	beq		@@CeilingCheck
@@FloorBorder:
	mov		r0,1h
	b 		@@WritePose
@@CeilingCheck:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@CeilingBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@CeilingBorder
	b 		@@end
@@CeilingBorder:
	ldrh	r0,[r5,14h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]				;纠正Y
	mov		r0,2h
	b 		@@WritePose
@@LeftWallCheck:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@LeftWallBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@UpDownCheck
@@LeftWallBorder:
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]				;纠正X
	mov		r0,3h
	b 		@@WritePose
@@RightWallCheck:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightWallBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightWallBorder
	b 		@@UpDownCheck
@@RightWallBorder:
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	mov		r0,4h
@@WritePose:
	strb	r0,[r4,8h]
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;速度全归零
	strb	r0,[r4,9h]				;取消标记归零
	ldr		r0,=24Fh
	bl		PlaySound
@@end:
	pop		r1
	bx		r1
.pool	
	
SpiderBallOnFloorPose:				;地面行
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]				;X速度归零
	ldrb	r1,[r4,9h]				;读取pose切换按键持续flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;去掉多余的数据
	ldrh	r0,[r4]
	and		r0,r1					;检查是否按了标记的方向
	cmp		r0,0h
	bne		@@StillingPress
@@PressStillingReturnZero:
	mov		r0,0h
	strb	r0,[r4,9h]				;持续标记归零
	b		@@NoPressStilling
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;检查左右移动
	beq		@@LeftMove
	b		@@RightMove
@@NoPressStilling:
	ldrh	r0,[r4]					;读取输入
	mov		r1,30h
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
;	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
;	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero	
	b      	@@end
@@NoEnd:	
	strb	r0,[r5,0Eh]				;面向纠正
	cmp		r0,10h
	beq		@@RightMove
@@LeftMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@LeftNoBlock
	ldrh	r0,[r5,12h]				;纠正X坐标
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]				;检查按键持续是否依然按着
	cmp		r1,0h
	bne		@@FloorToLeftWallOldPressStilling
	mov		r0,3h					;左墙接壤Pose			
	mov		r1,20h					;向左输入和向上移动
	b		@@WriteNewPose
@@FloorToLeftWallOldPressStilling:
	and		r1,r7					;去除多余的数据保留最初的按键
	mov		r0,3h
	b		@@WriteNewPose
@@LeftNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	sub		r1,4h
	bl		CheckBlock				;检查最边上是否已经离开了砖块
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,20h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:
	strh	r0,[r4,8h]
	b 		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,12h]				;纠正要右墙向下的坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@FloorToRightWallOldPressStilling
	mov		r0,4h					;右墙接壤
	mov		r1,21h					;向左输入和向下移动
	b		@@WriteNewY
@@FloorToRightWallOldPressStilling:
	mov		r0,1h
	orr		r1,r0
	mov		r0,4h
	b		@@WriteNewY
@@RightMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@RightNoBlock
	ldrh	r0,[r5,12h]				;纠正要右墙上的坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@FloorToRightWallOldPressStilling2
	mov		r0,4h					;右墙接壤Pose	
	mov		r1,10h					;按右和向上移动标记
	b		@@WriteNewPose			
@@FloorToRightWallOldPressStilling2:
	and		r1,r7
	mov		r0,4h
	b		@@WriteNewPose
@@RightNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]					;检查悬空
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,21h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@FloorToLeftWallOldPressStilling2
	mov		r0,3h					;左墙接壤Pose
	mov		r1,11h					;按右和下移动标记
	b 		@@WriteNewY
@@FloorToLeftWallOldPressStilling2:
	mov		r0,1h
	orr		r1,r0
	mov		r0,3h
@@WriteNewY:
	ldrh	r2,[r5,14h]				;让Y降低一点
	add		r2,8h
	strh	r2,[r5,14h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@LeftMoveX:
	ldrh	r1,[r5,12h]
	sub		r1,4h
	b		@@WriteNewX
@@RightMoveX:
	ldrh	r1,[r5,12h]
	add		r1,4h
@@WriteNewX:	
	strh	r1,[r5,12h]
@@end:	
	pop		r1
	bx		r1
.pool

SpiderBallOnCeilingPose:			;天花板行
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;归零所有的速度		
	ldrb	r1,[r4,9h]				;读取pose切换按键持续flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;去掉多余的数据	
	ldrh	r0,[r4]
	and		r0,r1					;检查是否按着持续的按键
	cmp		r0,0h
	beq		@@PressStillingReturnZero		
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;检查左右移动
	beq		@@LeftMove
	b		@@RightMove
@@PressStillingReturnZero:
	mov		r0,0h
	strb	r0,[r4,9h]				;持续标记归零
@@NoPressStilling:
	ldrh	r0,[r4]					;读取输入
	mov		r1,30h
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]				;检查是否无接壤坠落
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	sub		r0,40h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	b		@@end
@@NoEnd:	
	mov		r1,30h
	eor		r1,r0
	strb	r1,[r5,0Eh]				;面向纠正
	cmp		r0,10h
	beq		@@RightMove
@@LeftMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Fh
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@LeftNoBlock
	ldrh	r0,[r5,12h]				;纠正X坐标
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToLeftWallPressStilling
	mov		r0,3h					;左墙接壤
	mov		r1,21h					;输入左和向下移动
	b		@@WriteNewPose
@@CeilingToLeftWallPressStilling:
	mov		r0,1h
	orr		r1,r0
	mov		r0,3h
	b 		@@WriteNewPose
@@LeftNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Dh
	sub		r1,4h
	bl		CheckBlock				;检查最边上是否已经离开了砖块
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]				;检查是否无接壤坠落
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,20h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:
	mov		r0,0h
	strh	r0,[r4,8h]
	b		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,12h]				;纠正要右墙向上的坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToRightWallPressStilling
	mov		r0,4h					;右墙接壤Pose
	mov		r1,20h					;左按键和上移动标记
	b		@@WriteNewY
@@CeilingToRightWallPressStilling:
	and		r1,r7
	mov		r0,4h
	b 		@@WriteNewY
@@RightMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Fh
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@RightNoBlock
	ldrh	r0,[r5,12h]				;纠正要右墙向下的坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToRightWallPressStilling2
	mov		r0,4h					;右墙接壤Pose
	mov		r1,11h					;按右和下移动标记
	b		@@WriteNewPose
@@CeilingToRightWallPressStilling2:
	mov		r0,1h
	orr		r1,r0
	mov		r0,4h
	b 		@@WriteNewPose
@@RightNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]					;检查悬空
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,21h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToLeftWallPressStilling2
	mov		r0,3h					;左墙接壤Pose
	mov		r1,10h					;按右和上移动标记
	b 		@@WriteNewY
@@CeilingToLeftWallPressStilling2:
	and		r1,r7
	mov		r0,3h
@@WriteNewY:
	ldrh	r2,[r5,14h]				;使Y坐标向上一点
	sub		r2,8h
	strh	r2,[r5,14h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@LeftMoveX:
	ldrh	r1,[r5,12h]
	sub		r1,4h
	b		@@WriteNewX
@@RightMoveX:
	ldrh	r1,[r5,12h]
	add		r1,4h
@@WriteNewX:	
	strh	r1,[r5,12h]
@@end:	
	pop		r1
	bx		r1
.pool

SpiderBallOnLeftWallPose:
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;归零所有的速度		
	ldrb	r1,[r4,9h]				;读取按键持续flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;去掉多余的数据
	ldrh	r0,[r4]
	and		r0,r1					;检查是否持续按着
	cmp		r0,0h
	beq		@@PressStillingReturnZero		
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;检查上下移动
	beq		@@UpMove
	b		@@DownMove
@@PressStillingReturnZero:			;一旦松开按键则持续按键标记归零
	mov		r0,0h
	strb	r0,[r4,9h]				;持续标记归零
@@NoPressStilling:
	ldrh	r0,[r4]					;读取输入
	mov		r1,0C0h					;检查是否按了上下
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	sub		r0,3Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	b 		@@end
@@NoEnd:	
	mov		r1,r0
	lsr		r1,r1,2h				
	mov		r2,30h
	eor		r1,r2
	strb	r1,[r5,0Eh]				;面向纠正
	cmp		r0,80h
	beq		@@DownMove
@@UpMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@UpNoBlock
	ldrh	r0,[r5,14h]				;纠正Y坐标
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	sub		r0,4h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToCeilingPressStilling
	mov		r0,2h					;天花板接壤
	mov		r1,41h					;输入上和向右移动
	b		@@WriteNewPose
@@LeftWallToCeilingPressStilling:
	mov		r0,1h
	orr		r1,r0
	mov		r0,2h
	b 		@@WriteNewPose
@@UpNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	sub		r1,1Dh					;检查将要行至部是否出界
	bl		CheckBlock				;检查左墙壁的凹陷
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
;	add		r0,1h
	sub		r0,4h					;检查将要行低部是否出界
	sub		r1,1Dh					
	bl		CheckBlock				;继续检查左墙壁的凹陷
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]				;检查是否已经悬空
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:	
	mov		r0,0h
	strh	r0,[r4,8h]
	b		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,14h]				;纠正Y坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	sub		r0,1h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToFloorPressStilling
	mov		r0,1h					;地面接壤Pose
	mov		r1,40h					;上按键和左移动标记
	b		@@WriteNewX
@@LeftWallToFloorPressStilling:
	and		r1,r7
	mov		r0,1h
	b		@@WriteNewX
@@DownMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	bl		CheckBlock				;检查下方是否有地面
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@DownNoBlock			
	ldrh	r0,[r5,14h]				;纠正Y坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Fh
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToFloorPressStilling2
	mov		r0,1h					;地面接壤Pose
	mov		r1,81h					;按下和右移动标记
	b		@@WriteNewPose
@@LeftWallToFloorPressStilling2:
	mov		r0,1h
	orr		r1,r0
	b 		@@WriteNewPose
@@DownNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	sub		r1,1Dh					;检查将行最下部是否越界
	bl		CheckBlock				;检查做左下的凹陷
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch					;检查将行最上部是否越界
	add		r0,4h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]				;检查是否坠落
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	sub		r0,3Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,14h]				;纠正Y坐标	
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToCeilingPressStilling2
	mov		r0,2h					;天花板接壤
	mov		r1,80h					;按下和左移动标记
	b 		@@WriteNewX
@@LeftWallToCeilingPressStilling2:
	and		r1,r7
	mov		r0,2h
@@WriteNewX:
	ldrh	r2,[r5,12h]
	sub		r2,8h
	strh	r2,[r5,12h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@UpMoveY:
	ldrh	r1,[r5,14h]
	sub		r1,4h
	b		@@WriteNewY
@@DownMoveY:
	ldrh	r1,[r5,14h]
	add		r1,4h
@@WriteNewY:	
	strh	r1,[r5,14h]
@@end:	
	pop		r1
	bx		r1
.pool

SpiderBallOnRightWallPose:			;右墙接壤Pose
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;归零所有的速度		
	ldrb	r1,[r4,9h]				;读取按键持续flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;去掉多余的数据
	ldrh	r0,[r4]
	and		r0,r1					;检查是否持续按着
	cmp		r0,0h
	beq		@@PressStillingReturnZero		
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;检查上下移动
	beq		@@UpMove
	b		@@DownMove
@@PressStillingReturnZero:			;一旦松开按键则持续按键标记归零
	mov		r0,0h
	strb	r0,[r4,9h]				;持续标记归零
@@NoPressStilling:
	ldrh	r0,[r4]					;读取输入
	mov		r1,0C0h					;检查是否按了上下
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]				;检查是否坠落
	ldrh	r1,[r5,12h]
	add		r1,1Dh
	sub		r0,3Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	b 		@@end
@@NoEnd:	
	mov		r1,r0
	lsr		r1,r1,2h				
	mov		r2,30h
	strb	r1,[r5,0Eh]				;面向纠正
	cmp		r0,80h
	beq		@@DownMove
@@UpMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@UpNoBlock
	ldrh	r0,[r5,14h]				;纠正Y坐标
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	sub		r0,4h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToCeilingPressStilling
	mov		r0,2h					;天花板接壤
	mov		r1,40h					;输入上和向左移动
	b		@@WriteNewPose
@@RightWallToCeilingPressStilling:
	and		r1,r7
	mov		r0,2h
	b 		@@WriteNewPose
@@UpNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	add		r1,1Dh					;检查将行处是否出界
	bl		CheckBlock				;检查左墙壁的凹陷
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
;	add		r0,1h
	sub		r0,4h					;检查将行低部是否出界
	add		r1,1Dh					
	bl		CheckBlock				;继续检查左墙壁的凹陷
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]				;检查是否坠落
	ldrh	r1,[r5,12h]
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:
	mov		r0,0h
	strh	r0,[r4,8h]
	b		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,14h]				;纠正Y坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	sub		r0,1h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToFloorPressStilling
	mov		r0,1h					;地面接壤Pose
	mov		r1,41h					;上按键和右移动标记
	b		@@WriteNewX
@@RightWallToFloorPressStilling:
	mov		r0,1h
	orr		r1,r0
	b		@@WriteNewX
@@DownMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	bl		CheckBlock				;检查下方是否有地面
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@DownNoBlock			
	ldrh	r0,[r5,14h]				;纠正Y坐标
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Fh
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToFloorPressStilling2
	mov		r0,1h					;地面接壤Pose
	mov		r1,80h					;按下和左移动标记
	b		@@WriteNewPose
@@RightWallToFloorPressStilling2:
	mov		r0,1h
	and		r1,r7
	b 		@@WriteNewPose
@@DownNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	add		r1,1Dh					;;检查将要移动的最下
	bl		CheckBlock				;检查做左下的凹陷				
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch					;检查最下部是否越界
	add		r0,4h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]				;检查是否坠落
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,14h]				;纠正Y坐标	
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToCeilingPressStilling2
	mov		r0,2h					;天花板接壤
	mov		r1,81h					;按下和右移动标记
	b 		@@WriteNewX
@@RightWallToCeilingPressStilling2:
	mov		r0,1h
	orr		r1,r0
	add		r0,1h
@@WriteNewX:
	ldrh	r2,[r5,12h]
	add		r2,8h
	strh	r2,[r5,12h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@UpMoveY:
	ldrh	r1,[r5,14h]
	sub		r1,4h
	b		@@WriteNewY
@@DownMoveY:
	ldrh	r1,[r5,14h]
	add		r1,4h
@@WriteNewY:	
	strh	r1,[r5,14h]
@@end:	
	pop		r1
	bx		r1
.pool

BallAnimationControl:
	push	r4-r6
	mov		r5,r0
	ldrb	r0,[r4]
	cmp		r0,11h
	beq		@@IsBall
	cmp		r0,12h
	beq		@@IsBall
	cmp		r0,14h
	bne		@@NoBall
@@IsBall:
	ldr		r6,=300137Ch
	ldrh	r1,[r6]				;读取输入
	ldrb	r2,[r6,8h]			;检查是否有蜘蛛球的Pose
	cmp		r2,0h
	beq		@@NoBall			;蜘蛛球没有激活则结束
	; mov		r0,80h
	; lsl		r0,r0,2h
	; and		r0,r1
	; cmp		r0,0h				;检查是否按了L
	; beq		@@NoPressL
	; mov		r0,7h
	; b		@@OnlyChange1D
; @@NoPressL:	
	ldrb	r0,[r6,9h]			
	cmp		r0,0h
	bne		@@SlowAnimation				;如果是持续移动则动画减慢一倍
	cmp		r2,2h
	bhi		@@LeftAndRightWallPose
	ldrh	r1,[r6]
	mov		r0,30h
	and		r0,r1
	cmp		r0,0h
	bne		@@SlowAnimation		;如果按了左右则缓慢的动画
	cmp		r2,1h
	bne		@@CeilingPose
	ldrb	r0,[r4,1Dh]			;检查地面的蜘蛛球停止动画
	cmp		r0,2h
	bcc		@@OnlyChange1D
	cmp		r0,7h
	beq		@@OnlyChange1D
	mov		r1,2h
	eor		r0,r1
	cmp		r0,2h
	bcc		@@OnlyChange1D
	cmp		r0,7h
	beq		@@OnlyChange1D
	mov		r1,4h
	eor		r0,r1
	b		@@OnlyChange1D
@@CeilingPose:
	ldrb	r0,[r4,1Dh]
	cmp		r0,0h
	bne		@@CeilingNextCheck
	mov		r0,1h
	b		@@OnlyChange1D
@@CeilingNextCheck:
	cmp		r0,3h
	bcc		@@OnlyChange1D
	cmp		r0,5h
	bhi		@@OnlyChange1D
	mov		r1,2h
	eor		r0,r1
	b 		@@OnlyChange1D
@@ChangedNewAnimation:
	mov		r1,0h
	strb	r1,[r4,1Ch]			;动画帧为0
@@OnlyChange1D:	
	strb	r0,[r4,1Dh]
	b 		@@end
@@LeftAndRightWallPose:	
	ldrh	r1,[r6]				;读取输入
	mov		r0,0C0h				;检查是否按了上下
	and		r0,r1
	cmp		r0,0h				;没有的话则结束
	bne		@@SlowAnimation
	ldrb	r0,[r4,1Dh]			;读取动画
	cmp		r0,5h
	bne		@@WallPoseAnimationNextCheck
	ldrb	r1,[r4,1Ch]
	cmp		r1,1h
	bhi		@@OnlyChange1D
	b		@@WallChangePeer
@@WallPoseAnimationNextCheck:
	cmp		r0,2h
	bcc		@@OnlyChange1D
	cmp		r0,4h
	bhi		@@OnlyChange1D
@@WallChangePeer:
	mov		r1,2h
	eor		r0,r1
	b		@@OnlyChange1D
@@SlowAnimation:	
	ldr		r0,=3000002h
	ldrb	r0,[r0]
	mov		r6,1h
	and		r0,r6
	cmp		r0,0h				;蜘蛛球时候的移动,动画递进变慢
	beq		@@end
@@NoBall:
	add		r5,1h
	strb	r5,[r4,1Ch]
@@end:
	pop		r4-r6
	bx		r14
.pool	

SpiderBallPaletteChanged:
	push	r0,r1
	ldr		r1,=SamusHeightStage
	ldrb	r0,[r1]
	cmp		r0,2h				;如果不是球阶段则结束	
	bne		@@end
	ldrb	r0,[r5]
	cmp		r0,10h				;检查是否是变球中
	beq		@@end
	cmp		r0,13h				;检查是否是变人中
	beq		@@end
	cmp		r0,1Ch
	beq		@@end				;排除了将变球式上攀
	cmp		r0,2Bh				;吊索球
	beq		@@CheckSpiderBall
	cmp		r0,20h				;20是被雕像抓住,So
	bhi		@@end
	
@@CheckSpiderBall:				;全是可能是蜘蛛球的球
	mov		r0,0h
	strb	r0,[r5,9h]			;归零变人闪光
	mov		r1,r5
	sub		r1,58h				
	ldrb	r0,[r1,8h]			;检查是否是蜘蛛球
	cmp		r0,0h
	beq		@@end
	mov		r0,0h
	strb	r0,[r5,6h]			;去除无敌的时间
	ldr		r0,=SpiderBallPalette
	mov		r1,0A0h
	mul		r1,r3
	add		r0,r1
	mov		r8,r0
	ldrb	r0,[r5,8h]			;金身时间
	cmp		r0,0h
	beq		@@end
	ldr		r0,=SpiderBallPalette + 40h
	mov		r1,0A0h
	mul		r1,r3
	add		r0,r1
	mov		r10,r0
	
@@end:
	pop		r0,r1
	lsl		r1,r1,2h
	add		r0,r1,r0
	ldr		r3,[r0]
	bx		r14
.pool

.close	