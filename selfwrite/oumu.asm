.gba
.open "zm.gba",".gba",0x8000000
;by JumZhu.Diwa

.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteRNG,300083Ch
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel CheckSlope,800F360h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel RandomDirection2,800F844h
.definelabel RandomDirection,800F80Ch
.definelabel FrozenRoutine,800FFE8h
.definelabel MetroidFrozenRoutine,801004Ch
.definelabel MetroidFastFrozenRoutine,80100A4h
.definelabel DeathFireWorks,8011084h
.definelabel StunSprite,8011280h
.definelabel PrimarySpriteStats,82B0D68h
.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
.definelabel AreaHeaderDataOffset,0x875FAC4
.definelabel CurrentArea,3000054h
.definelabel CurrSprite,0x3000738
.definelabel CheckShakeScreen,80112C8h
.definelabel Modulo,808AD10h				;求余
.definelabel Division,808AC34h
;2C保存了属性值 随着属性值的增加而血量倍数,同时冰冻恢复时间加快
;2F记录坠落前的pose值
.definelabel OumuID,16h						;Which sprite to replace

.org SpriteAiStart + OumuID * 4
	.word OumuMain + 1
	
.org SpriteGfxPointers + ( OumuID - 10h ) * 4
	.word OumuGfxPointers
	
.org SpritePalPointers + ( OumuID - 10h ) * 4
	.word OumuPalPointers
	
.org 8304054h
OumuMain:
	push	r4-r7,lr
	add		sp,-4h
	ldr		r4,=CurrSprite
	mov		r5,r4
	add		r5,20h
	ldrb	r2,[r5,12h]
	mov		r0,2h
	mov		r1,r0
	and		r0,r2
	cmp		r0,0h
	beq		@@NoHit
	mov		r0,0FDh
	and		r0,r2
	strb	r0,[r5,12h]				;碰撞属性击打去除
	ldrh	r0,[r4]
	and		r1,r0
	cmp		r0,0h
	beq		@@NoHit					;检查是否在屏幕内
	mov		r0,0BCh
	lsl		r0,r0,1h
	bl		PlaySound2
@@NoHit:
	ldrb	r0,[r5,10h]
	cmp		r0,0h
	beq		@@NoFrozening
	bl		MetroidFrozenRoutine
	b		@Thend
@@NoFrozening:	
	bl		StunSprite
	cmp		r0,0h
	bne		@Thend
	ldrb	r0,[r5,4h]
	cmp		r0,7h
	bhi		@DeathPose
	cmp		r0,2h
	bcc		@@PassShakeDrop
	cmp		r0,4h
	bhi		@@PassShakeDrop
	bl		CheckShakeScreen
	cmp		r0,0h
	beq		@@PassShakeDrop
	ldrb	r0,[r5,04h]				
	strb	r0,[r5,0Fh]				;记录坠落前的pose是什么
	mov		r0,5h					;墜落準備pose 蜜汁繁體
	strb	r0,[r5,4h]
	mov		r0,0h
	strh	r0,[r4,16h]				;动画归零
	strb	r0,[r4,1Ch]
@@PassShakeDrop:	
	ldrb	r0,[r5,4h]
	lsl		r0,r0,2h
	ldr		r1,=OumuPoseTable
	add		r0,r0,r1
	ldr		r0,[r0]
	mov		r15,r0
.pool
OumuPoseTable:
	.dw	OumuInitialize
	.dw	OumuFloorWalker
	.dw OumuCeilingWalker
	.dw OumuLeftWallWalker
	.dw OumuRightWallWalker
	.dw OumuReDrop
	.dw OumuDrop
	
OumuInitialize:
	bl	OumuInitializePose
	b	@Thend
OumuFloorWalker:
	bl	OumuFloorWalkerPose
	b	@Thend
OumuCeilingWalker:
	bl	OumuCeilingWalkerPose
	b	@Thend
OumuLeftWallWalker:
	bl	OumuLeftWallWalkerPose
	b	@Thend
OumuRightWallWalker:	
	bl	OumuRightWallWalkerPose
	b	@Thend
OumuReDrop:
	bl	OumuReDropPose
	b	@Thend
OumuDrop:
	bl	OumuDropPose
	b	@Thend	
@DeathPose:
	ldrh	r1,[r4,2h]
	ldrh	r2,[r4,4h]
	mov		r0,20h
	str		r0,[sp]
	mov		r0,0h
	mov		r3,1h
	bl		DeathFireWorks
@Thend:
	bl		OumuGfxDirectionFix
	add		sp,4h
	pop		r4-r7
	pop		r1
	bx		r1
	.pool
	
OumuGfxDirectionFix:		;图形方向匯總整理 
	ldrb	r0,[r5,4h]
	cmp		r0,4h
	bhi		@@end
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h
	beq		@@Have140
	ldr		r1,=0FEBFh
	ldrh	r0,[r4]
	and		r0,r1
	b		@@Write
	.pool
@@Have140:
	mov		r1,50h
	lsl		r1,r1,2h
	ldrh	r0,[r4]
	orr		r0,r1
@@Write:
	strh	r0,[r4]
@@end:
	bx		lr
.pool	

OumuLevelSet:
	ldr		r0,=OumuLevelNormalOAM
	str		r0,[r4,18h]
	mov		r0,0h
	strh	r0,[r4,16h]
	strb	r0,[r4,1Ch]
	mov		r0,10h
	strb	r0,[r5,7h]				;上视界
	strb	r0,[r5,8h]				;下视界
	lsl		r0,r0,1h
	strb	r0,[r5,9h]				;左右视界
	ldr		r1,=0FFE0h	
	strh	r1,[r4,0Ah]				;上部分界
	strh	r0,[r4,0Ch]				;下部分界
	sub		r1,10h
	strh	r1,[r4,0Eh]				;左部分界
	add		r0,10h
	strh	r0,[r4,10h]				;右部分界
	bx		lr
	.pool
	
OumuVerticalSet:
	ldr		r0,=OumuVerticalNormalOAM
	str		r0,[r4,18h]
	mov		r0,0h
	strh	r0,[r4,16h]
	strb	r0,[r4,1Ch]
	mov		r0,20h
	strb	r0,[r5,7h]				;上视界
	strb	r0,[r5,8h]				;下视界
	lsr		r0,r0,1h	
	strb	r0,[r5,9h]				;左右视界
	ldr		r1,=0FFD0h
	strh	r1,[r4,0Ah]				;上部分界
	mov		r0,30h
	strh	r0,[r4,0Ch]				;下部分界
	add		r1,10h
	strh	r1,[r4,0Eh]				;左部分界
	sub		r0,10h
	strh	r0,[r4,10h]				;右部分界
	bx		lr
	.pool
	
OumuInitializePose:
	push	lr	
	ldrh	r0,[r4,2h]
	sub		r0,20h
	strh	r0,[r4,2h]			
	ldrh	r0,[r4,2h]
	add		r0,20h
	ldrh	r1,[r4,4h]				;检查出生的脚底
	bl		CheckBlock
	ldr		r6,=YTagRAM
	ldrb	r1,[r6]
	mov		r7,0F0h
	and		r1,r7
	cmp		r1,0h
	beq		@@DownNoSquareBlock	 	;无方形砖
	;------------------------下方有方形砖
	
	mov		r0,1h		   			;Pose写入下方接壤
	strb	r0,[r4,1Ch]				;纠正图形与移动不符
	mov		r0,1h
	b		@@UpDownPeer
	.pool
@@DownNoSquareBlock:
	ldrh	r0,[r4,2h]
	sub		r0,24h
	ldrh	r1,[r4,4h]
	bl		CheckBlock
	ldrb	r1,[r6]
	and		r1,r7
	cmp		r1,0h
	beq		@@UpNoSquareBlock
	;------------------------上方有方形砖
	mov		r0,0h
	strb	r0,[r4,1Ch]				;纠正图形与移动不符
	mov		r0,2h					;Pose写入上方接壤
@@UpDownPeer:
	strb	r0,[r5,4h]
	bl		OumuLevelSet
	b		@@AllPeer
	.pool
@@UpNoSquareBlock:
	ldrh	r0,[r4,2h]
	ldrh	r1,[r4,4h]
	sub		r1,24h
	bl		CheckBlock
	ldrb	r1,[r6]
	and		r1,r7
	cmp		r1,0h
	beq		@@NoLeftSquareBlock
	;--------------------------左边有方形砖
;	mov		r0,0h
;	strb	r0,[r4,1Ch]				;纠正图形与移动不符
	mov		r0,3h					;Pose写入左部接壤
	b		@@LeftRightPeer
@@NoLeftSquareBlock:
	ldrh	r0,[r4,2h]
	ldrh	r1,[r4,4h]
	add		r1,20h
	bl		CheckBlock
	ldrb	r1,[r6]
	and		r1,r7
	cmp		r1,0h
	beq		@@CancelSprite
	;--------------------------右边有方形砖
;	mov		r0,1h
;	strb	r0,[r4,1Ch]				;纠正图形与移动不符
	mov		r0,4h					;Pose写入右部接壤
	b		@@LeftRightPeer
@@CancelSprite:
	strh	r1,[r4]					;取消精灵
	b		@@end
@@LeftRightPeer:
	strb	r0,[r5,4h]
	bl		OumuVerticalSet
@@AllPeer:	
	mov		r0,4h
	strb	r0,[r5,5h]				;碰撞samus属性写入4h
	ldr		r2,=PrimarySpriteStats
	ldrb	r1,[r4,1Dh]
	lsl		r0,r1,3h
	add		r0,r0,r1
	lsl		r0,r0,1h
	add		r0,r0,r2
	ldrh	r0,[r0]
	strh	r0,[r4,14h]				;写入血量
	bl		OumuRandomDirection		;随机给予取向200h
@@end:
	pop	r1
	bx	r1
.pool

OumuRandomDirection:				;原设定方向太偏左的几率,现在自写偏右
	ldr		r0,=SpriteRNG
	ldrb	r1,[r0]
	mov		r0,1h
	and		r0,r1
	cmp		r0,0h
	bne		@@HaveFlag
	ldrh	r1,[r4]
	ldr		r0,=0FDFFh
	and		r0,r1
	b		@@Write
.pool
@@HaveFlag:
	mov		r1,80h
	lsl		r1,r1,2h
	ldrh	r0,[r4]
	orr		r0,r1
@@Write:
	strh	r0,[r4]
	bx		r14
.pool
	
OumuFloorWalkerPose:
	push	r4-r7,r14
	mov		r7,r9
	mov		r6,r8
	push	r6,r7
	ldrh	r0,[r4,2h]
	add		r0,20h
	mov		r8,r0					;Y原坐标
	ldrh	r6,[r4,4h]
	mov		r9,r6
	mov		r6,0F0h
	ldr		r7,=YTagRAM
	mov		r0,r8
	sub		r0,4h
	mov		r1,r9
	bl		CheckSlope
	mov		r2,r0					;返回的斜坡高度
	sub		r7,1h					;30007F0h
	ldrb	r1,[r7]
	mov		r3,0Fh
	and		r1,r3
	cmp		r1,1h
	bhi		@@OnSlope				;斜坡纠正坐标?
	mov		r0,r8
	mov		r1,r9
	bl		CheckSlope			
	mov		r2,r0
	ldrb	r0,[r7]
	mov		r3,0Fh
	and		r0,r3
	cmp		r0,1h
	bhi		@@OnSlope 				;纠正坐标?
	mov		r0,r8
	add		r0,4h
	mov		r1,r9
	bl		CheckSlope
	mov		r2,r0
	ldrb	r0,[r7]
	cmp		r0,0h				
	beq		@@PassSlopeYCorrect		;跳过纠正
@@OnSlope:
	sub		r2,20h					;使OAM矫正
	strh	r2,[r4,2h]				;写入正确的显示坐标
@@PassSlopeYCorrect:
	ldrh	r0,[r4,2h]
	add		r0,20h					;还原为检查的坐标
	mov		r8,r0
	ldrb	r1,[r7]
	add		r7,1h					;30007F1h
	cmp		r1,0h
	beq		@@NoOnSlope				;不在斜坡上?
	mov		r0,0F0h
	and		r1,r0
	cmp		r1,0h
	beq		@@NoOnSquareBlock		;确定了在斜坡?
@@NoOnSlope:						;非斜坡
	mov		r1,r9
	mov		r0,r8
	bl		CheckBlock
	ldrb	r0,[r7]
	cmp		r0,0h
	beq		@@DownNoBlock
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	beq		@@LeftWallCheck
	mov		r0,r8
	sub		r0,10h
	mov		r1,r9
	add		r1,20h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@NoOnSquareBlock
	ldrh	r0,[r4]				
	ldr		r1,=0FDFFh
	and		r0,r1					;去掉200h标记
	strh	r0,[r4]
	mov		r0,4h					;右墙接壤
	strb	r0,[r5,4h]
	b		@@SubY
	.pool
@@LeftWallCheck:
	mov		r0,r8
	sub		r0,10h
	mov		r1,r9
	sub		r1,21h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@NoOnSquareBlock
	mov		r0,3h
	strb	r0,[r5,4h]				;左墙接壤pose
@@SubY:
	ldrh	r0,[r4,2h]
	sub		r0,4h
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	strh	r0,[r4,2h]
	b		@@WallBorderPeer
	.pool
@@NoOnSquareBlock:					;可以移动
	ldrb	r2,[r4,1h]
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@LeftGo
	ldrh	r0,[r4,16h]
	cmp		r0,5h
	bne		@@MovePeer
	b		@@end
@@LeftGo:
	ldrh	r0,[r4,16h]
	cmp		r0,0h
	beq		@@end
@@MovePeer:	
	mov		r3,r9
	ldrb	r0,[r4,1Ch]
	cmp		r0,4h
	bne		@@end
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@LeftMove
	add		r1,r3,4h
	b		@@WriteMove
@@LeftMove:
	sub		r1,r3,4h
@@WriteMove:
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	strh	r1,[r4,4h]				;写入移动后的X坐标
	b		@@end
@@DownNoBlock:
	mov		r3,r9
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@LeftFloorCheck
	add		r1,r3,4h
	b		@@FloorCheckPeer
@@LeftFloorCheck:
	sub		r1,r3,4h
@@FloorCheckPeer:
	mov		r0,r8
	bl		CheckBlock
	ldrb	r0,[r7]
	cmp		r0,0h					;之前的位置如果也无砖则掉落
	bne		@@NoDropPose
	mov		r0,5h
	strb	r0,[r5,4h]				;写入准备掉落的Pose
	b		@@end
@@NoDropPose:	
	ldrh	r0,[r4,2h]
	add		r0,20h					;Y多加一点
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	strh	r0,[r4,2h]	
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@RightMoveNoFloor
	mov		r0,4h
	strb	r0,[r5,4h]				;右墙接壤pose
	ldrh	r0,[r4,4h]
	sub		r0,1Fh
	b		@@WriteDownWallX
@@RightMoveNoFloor:
	mov		r0,3h
	strb	r0,[r5,4h]				;左墙接壤pose
	ldrh	r0,[r4,4h]
	add		r0,20h
@@WriteDownWallX:
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	lsl		r0,r0,10h
	lsr		r0,r0,10h
	strh	r0,[r4,4h]
	ldrb	r0,[r4,1h]
	mov		r1,2h
	orr		r0,r1
	strb	r0,[r4,1h]				;向下的flag
@@WallBorderPeer:	
	bl		OumuVerticalSet
@@end:
	pop		r6,r7
	mov		r9,r7
	mov		r8,r6
	pop		r4-r7
	pop		r1
	bx		r1
.pool	

OumuCeilingWalkerPose:				;天花板爬行
	push	r4-r7,r14
	mov		r7,r9
	mov		r6,r8
	push	r6,r7
	ldrh	r0,[r4,2h]
	add		r0,20h
	mov		r8,r0					;Y原坐标
	ldrh	r6,[r4,4h]
	mov		r9,r6
	mov		r6,0F0h
	ldr		r7,=YTagRAM
	mov		r1,r9
	mov		r0,r8
	sub		r0,44h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@UpNoBlock
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	beq		@@LeftWallCheck
	mov		r0,r8
	sub		r0,20h
	mov		r1,r9
	add		r1,20h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@MoveSpeedWrite
	;-------------------------------右边有方砖
	ldrh	r0,[r4]
	ldr		r1,=0FDFFh
	and		r0,r1					;去掉200h标记
	strh	r0,[r4]
	mov		r0,4h					;右墙接壤
	strb	r0,[r5,4h]
	b		@@DownFlag
	.pool
@@LeftWallCheck:
	mov		r0,r8
	sub		r0,20h
	mov		r1,r9
	sub		r1,21h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@MoveSpeedWrite
	mov		r0,3h
	strb	r0,[r5,4h]				;左墙接壤pose
@@DownFlag:	
	ldrb	r0,[r4,1h]
	mov		r1,2h
	orr		r0,r1
	strb	r0,[r4,1h]				;有200標記
	ldrh	r0,[r4,2h]
	add		r0,4h
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	strh	r0,[r4,2h]				;Y多加一点
	b		@@WallBorderPeer
	.pool
@@MoveSpeedWrite:					;可以移动
	ldrb	r2,[r4,1h]
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@LeftGo
	ldrh	r0,[r4,16h]
	cmp		r0,0h
	bne		@@MovePeer
	b		@@end
@@LeftGo:
	ldrh	r0,[r4,16h]
	cmp		r0,5h
	beq		@@end
@@MovePeer:	
	mov		r3,r9
	ldrb	r0,[r4,1Ch]
	cmp		r0,4h
	bne		@@end
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@LeftMove
	add		r1,r3,4h
	b		@@WriteMove
@@LeftMove:
	sub		r1,r3,4h
@@WriteMove:
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	strh	r1,[r4,4h]				;写入移动后的X坐标
	b		@@end
@@UpNoBlock:
	mov		r3,r9
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@LeftCeilingCheck
	add		r1,r3,4h
	b 		@@CeilingCheckPeer
@@LeftCeilingCheck:
	sub		r1,r3,4h
@@CeilingCheckPeer:
	mov		r0,r8
	sub		r0,44h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	bne		@@NoDropPose
	mov		r0,5h					;Pose写入准备掉落
	strb	r0,[r5,4h]
	b		@@end
@@NoDropPose:	
	ldrh	r0,[r4,2h]
	sub		r0,24h					;Y多减一点防止下一个pose检查不到脚下的砖块
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	strh	r0,[r4,2h]	
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@RightMoveNoFloor
	mov		r0,4h
	strb	r0,[r5,4h]				;右墙接壤pose
	ldrh	r0,[r4,4h]
	sub		r0,1Fh
	b		@@WriteDownWallX
@@RightMoveNoFloor:
	ldrb	r0,[r4,1h]
	mov		r1,0FDh
	and		r0,r1
	strb	r0,[r4,1h]				;去掉200h
	mov		r0,3h
	strb	r0,[r5,4h]				;左墙接壤pose
	ldrh	r0,[r4,4h]
	add		r0,20h
@@WriteDownWallX:
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	lsl		r0,r0,10h
	lsr		r0,r0,10h
	strh	r0,[r4,4h]
@@WallBorderPeer:	
	bl		OumuVerticalSet
@@end:
	pop		r6,r7
	mov		r9,r7
	mov		r8,r6
	pop		r4-r7
	pop		r1
	bx		r1
.pool
	
OumuLeftWallWalkerPose:				;左墙爬行
	push	r4-r7,r14
	mov		r7,r9
	mov		r6,r8
	push	r6,r7
	ldrh	r0,[r4,2h]
	add		r0,20h
	mov		r8,r0					;Y原坐标
	ldrh	r6,[r4,4h]
	mov		r9,r6
	mov		r6,0F0h
	ldr		r7,=YTagRAM
	mov		r1,r9
	sub		r1,24h			
	mov		r0,r8
	sub		r0,20h
	bl		CheckBlock				;检查左墙之砖
	ldrb	r0,[r7]
	cmp		r0,0h
	beq		@@LeftWallNoBlock
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	beq		@@CelingCheck
	mov		r0,r8
	mov		r1,r9
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@MoveSpeedWrite
	;-------------------------------下面有方砖
	mov		r0,1h					;地板接壤
	strb	r0,[r5,4h]
	b		@@RightFlag
	.pool
@@CelingCheck:
	mov		r0,r8
	sub		r0,41h
	mov		r1,r9
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@MoveSpeedWrite
	mov		r0,2h
	strb	r0,[r5,4h]				;天花板接壤
@@RightFlag:
	ldrh	r0,[r4,4h]
	add		r0,4h
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	strh	r0,[r4,4h]				;多加一点
	ldrb	r0,[r4,1h]
	mov		r1,2h
	orr		r0,r1
	strb	r0,[r4,1h]				;取向200h標記哦
	b		@@WallBorderPeer
	.pool
@@MoveSpeedWrite:					;可以移动
	ldrb	r2,[r4,1h]
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@LeftGo
	ldrh	r0,[r4,16h]
	cmp		r0,0h
	bne		@@MovePeer
	b		@@end
@@LeftGo:
	ldrh	r0,[r4,16h]
	cmp		r0,5h
	beq		@@end
@@MovePeer:	
	ldrb	r0,[r4,1Ch]
	cmp		r0,4h
	bne		@@end
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@UpMove
	ldrh	r0,[r4,2h]
	add		r1,r0,4h
	b		@@WriteMove
@@UpMove:
	ldrh	r0,[r4,2h]
	sub		r1,r0,4h
@@WriteMove:
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	strh	r1,[r4,2h]				;写入移动后的X坐标
	b		@@end
@@LeftWallNoBlock:
	mov		r3,r8
	sub		r3,20h
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@LeftUpBlockCheck
	add		r0,r3,4h
	b		@@LeftWallCheckPeer
@@LeftUpBlockCheck:	
	sub		r0,r3,4h
@@LeftWallCheckPeer:
	mov		r1,r9
	sub		r1,24h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	bne		@@NoDropPose
	mov		r0,5h
	strb	r0,[r5,4h]
	b 		@@end
@@NoDropPose:	
	ldrh	r0,[r4,4h]
	sub		r0,24h					;X多减一点
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	strh	r0,[r4,4h]	
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@DownMoveNoFloor
	mov		r0,1h
	strb	r0,[r5,4h]				;地板接壤pose
	ldrh	r0,[r4,2h]
	sub		r0,1Fh
	b		@@WriteDownWallX
	.pool
@@DownMoveNoFloor:
	ldrh	r0,[r4]
	ldr		r1,=0FDFFh
	and		r0,r1
	strh	r0,[r4]					;去掉200h
	mov		r0,2h
	strb	r0,[r5,4h]				;天花板接壤pose
	ldrh	r0,[r4,2h]
	add		r0,20h
@@WriteDownWallX:
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	lsl		r0,r0,10h
	lsr		r0,r0,10h
	strh	r0,[r4,2h]
@@WallBorderPeer:	
	bl		OumuLevelSet
@@end:
	pop		r6,r7
	mov		r9,r7
	mov		r8,r6
	pop		r4-r7
	pop		r1
	bx		r1
.pool	
		
OumuRightWallWalkerPose:
	push	r4-r7,r14
	mov		r7,r9
	mov		r6,r8
	push	r6,r7
	ldrh	r0,[r4,2h]
	add		r0,20h
	mov		r8,r0					;Y原坐标
	ldrh	r6,[r4,4h]
	mov		r9,r6
	mov		r6,0F0h
	ldr		r7,=YTagRAM
	mov		r1,r9
	add		r1,24h			
	mov		r0,r8
	sub		r0,20h
	bl		CheckBlock				;检查右墙之砖
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@RightWallNoBlock
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	beq		@@CelingCheck
	mov		r0,r8
	mov		r1,r9
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	beq		@@MoveSpeedWrite
	;-------------------------------下面有方砖
	ldrb	r0,[r4,1h]
	mov		r1,0FDh
	and		r0,r1
	strb	r0,[r4,1h]				;取向去掉200h
	mov		r0,1h					;地板接壤
	strb	r0,[r5,4h]
	b		@@SubX
	.pool
@@CelingCheck:
	mov		r0,r8
	sub		r0,41h
	mov		r1,r9
	bl		CheckBlock
	ldrb	r0,[r7]
	cmp		r0,0h
	and		r0,r6
	beq		@@MoveSpeedWrite
	mov		r0,2h
	strb	r0,[r5,4h]				;天花板接壤
@@SubX:	
	ldrh	r0,[r4,4h]
	sub		r0,4h					;X多减一点
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	strh	r0,[r4,4h]
	b		@@WallBorderPeer
	.pool
@@MoveSpeedWrite:					;可以移动
	ldrb	r2,[r4,1h]
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@LeftGo
	ldrh	r0,[r4,16h]
	cmp		r0,5h
	bne		@@MovePeer
	b		@@end
@@LeftGo:
	ldrh	r0,[r4,16h]
	cmp		r0,0h
	beq		@@end
@@MovePeer:	
	ldrb	r0,[r4,1Ch]
	cmp		r0,4h
	bne		@@end
	mov		r1,2h
	and		r1,r2
	cmp		r1,0h
	beq		@@UpMove
	ldrh	r0,[r4,2h]
	add		r1,r0,4h
	b		@@WriteMove
@@UpMove:
	ldrh	r0,[r4,2h]
	sub		r1,r0,4h
@@WriteMove:
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	strh	r1,[r4,2h]				;写入移动后的X坐标
	b		@@end
@@RightWallNoBlock:
	mov		r3,r8
	sub		r3,20h
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@RightWallUpBlockCheck
	add		r0,r3,4h
	b		@@RightWallBlockCheckPeer
@@RightWallUpBlockCheck:	
	sub		r0,r3,4h
@@RightWallBlockCheckPeer:
	mov		r1,r9
	add		r1,24h
	bl		CheckBlock
	ldrb	r0,[r7]
	and		r0,r6
	cmp		r0,0h
	bne		@@NoDropPose
	mov		r0,5h
	strb	r0,[r5,4h]
	b		@@end
@@NoDropPose:	
	ldrh	r0,[r4,4h]
	add		r0,24h					;X多加一点
	lsr		r0,r0,2h
	lsl		r0,r0,2h
	strh	r0,[r4,4h]	
	ldrb	r0,[r4,1h]
	mov		r1,2h
	and		r0,r1
	cmp		r0,0h
	bne		@@DownMoveNoFloor
	mov		r0,1h
	strb	r0,[r5,4h]				;地板接壤pose
	ldrh	r0,[r4,2h]
	sub		r0,1Fh
	b		@@WriteDownWallX
@@DownMoveNoFloor:
	ldrh	r0,[r4]
	mov		r1,50h
	lsl		r1,r1,2h
	orr		r0,r1					;orr140
	ldr		r1,=0FDFFh
	and		r0,r1
	strh	r0,[r4]					;去掉200h
	mov		r0,2h
	strb	r0,[r5,4h]				;天花板接壤pose
	ldrh	r0,[r4,2h]
	add		r0,20h
@@WriteDownWallX:
	ldr		r1,=0FFE0h
	and		r0,r1
	mov		r1,20h
	orr		r0,r1
	lsl		r0,r0,10h
	lsr		r0,r0,10h
	strh	r0,[r4,2h]
	ldrb	r0,[r4,1h]
	mov		r1,2h
	orr		r0,r1
	strb	r0,[r4,1h]				;向右移动flag
@@WallBorderPeer:	
	bl		OumuLevelSet
@@end:
	pop		r6,r7
	mov		r9,r7
	mov		r8,r6
	pop		r4-r7
	pop		r1
	bx		r1
.pool

OumuReDropPose:
	ldrb	r0,[r5,0Fh]
	cmp		r0,2h
	bne		@@end						;检查是否是天花板的类型
	ldrh	r0,[r4]
	mov		r1,50h
	lsl		r1,r1,2h
	eor		r0,r1
	strh	r0,[r4]						;在空中就纠正反的图像
@@end:
	mov		r0,6h
	strb	r0,[r5,4h]					;pose写入下落
	bx		lr
.pool
	
OumuDropPose:
	push	lr
	ldrh	r0,[r4,2h]
	add		r0,30h
	ldrh	r1,[r4,4h]					;检查身下是否有砖块
	bl		CheckBlock2
	ldr		r6,=XTagRAM
	mov		r2,r0
	ldrb	r3,[r6]
	cmp		r3,0h
	beq		@@NoFloor
	; ldrb	r0,[r5,0Fh]					;检查掉落前的Pose
	; cmp		r0,2h
	; bls		@@LevelPose
	; mov		r1,0F0h
	; and		r3,r1
	; cmp		r3,0h						;检查不是斜坡
	; beq		@@NoFloor	
; @@LevelPose:	
	sub		r2,20h
	strh	r2,[r4,2h]
	mov		r0,1h
	strb	r0,[r5,4h]					;写入地板pose
	bl		OumuLevelSet
	ldrb	r0,[r5,0Fh]
	cmp		r0,4h
	bcc		@@Pass
	mov		r1,80h
	lsl		r1,r1,2h
	ldrh	r0,[r4]
	eor		r0,r1
	strh	r0,[r4]
@@Pass:	
	mov		r0,0h
	strb	r0,[r5,0Fh]					;归零Pose记录
	b		@@end
.pool
@@NoFloor:
	ldrb	r0,[r5,0Fh]					;检查是否是竖向掉落的
	cmp		r0,2h
	bls		@@DropSpeed
	bl		CheckShakeScreen
	cmp		r0,0h
	bne		@@DropSpeed
	ldrb	r0,[r5,0Fh]					;检查靠向的墙面
	cmp		r0,3h
	beq		@@LeftWallType
	ldrh	r0,[r4,2h]
	ldrh	r1,[r4,4h]
	add		r1,24h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	mov		r1,0F0h
	and		r0,r1
	cmp		r0,0h
	beq		@@DropSpeed
	mov		r0,4h
	b		@@WritePose
@@LeftWallType:
	ldrh	r0,[r4,2h]
	ldrh	r1,[r4,4h]
	sub		r1,24h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	mov		r1,0F0h
	and		r0,r1
	cmp		r0,0h
	beq		@@DropSpeed
	mov		r0,3h
@@WritePose:
	strb	r0,[r5,4h]
	b		@@end
@@DropSpeed:
	ldrh	r0,[r4,2h]
	add		r0,10h
	strh	r0,[r4,2h]
@@end:
	pop		r1
	bx		r1
.pool	
		
.org 0x8761d38
.align
OumuGfxPointers:
.import "Oumu.Gfx.lz"	
.align
OumuPalPointers:
.import "Oumu.Palette"

.align
OumuLevelNormalOAM:
	.word OumuLevelNormalOAM1
	.word 0x4
	.word OumuLevelNormalOAM2
	.word 0x4
	.word OumuLevelNormalOAM3
	.word 0x4
	.word OumuLevelNormalOAM4
	.word 0x4
	.word OumuLevelNormalOAM3
	.word 0x4
	.word OumuLevelNormalOAM2
	.word 0x4
	.word 0,0
.align	
OumuVerticalNormalOAM:
	.word OumuVerticalNormalOAM1
	.word 0x4
	.word OumuVerticalNormalOAM2
	.word 0x4
	.word OumuVerticalNormalOAM3
	.word 0x4
	.word OumuVerticalNormalOAM4
	.word 0x4
	.word OumuVerticalNormalOAM3
	.word 0x4
	.word OumuVerticalNormalOAM2
	.word 0x4
	.word 0,0
.align	
OumuVerticalNormalOAM1:	
	.dh 0x3						
	.dh 0x00FE,0x41F8,0x820A	;头  
	.dh 0x00F8,0x41F8,0x8208	;躯
	.dh 0x00EF,0x41F8,0x8206	;尾
OumuVerticalNormalOAM2:	
	.dh 0x3						
	.dh 0x00FF,0x41F8,0x820A	;头  1
	.dh 0x00F8,0x41F8,0x8208	;躯
	.dh 0x00EF,0x41F8,0x8206	;尾
OumuVerticalNormalOAM3:	
	.dh 0x3						
	.dh 0x0000,0x41F8,0x820A	;头  2
	.dh 0x00F8,0x41F8,0x8208	;躯
	.dh 0x00EE,0x41F8,0x8206	;尾  1
OumuVerticalNormalOAM4:	
	.dh 0x3						
	.dh 0x0001,0x41F8,0x820A	;头  3
	.dh 0x00F8,0x41F8,0x8208	;躯
	.dh 0x00ED,0x41F8,0x8206	;尾  2

.align
OumuLevelNormalOAM1:               
	.dh 0x3						
	.dh 0X00F8,0x41FE,0x8204	;头  
	.dh 0X00F8,0x41F8,0x8202	;躯
	.dh 0X00F8,0x41EF,0x8200	;尾
OumuLevelNormalOAM2:	            
	.dh 0x3						
	.dh 0X00F8,0x41FE,0x8204	;头 
	.dh 0X00F8,0x41F8,0x8202	;躯
	.dh 0X00F8,0x41EE,0x8200	;尾 1
OumuLevelNormalOAM3:	
	.dh 0x3						
	.dh 0X00F8,0x41FF,0x8204	;头 1
	.dh 0X00F8,0x41F8,0x8202	;躯
	.dh 0X00F8,0x41ED,0x8200	;尾 2
OumuLevelNormalOAM4:	
	.dh 0x3						
	.dh 0X00F8,0x4000,0x8204	;头 2
	.dh 0X00F8,0x41F8,0x8202	;躯
	.dh 0X00F8,0x41EC,0x8200	;尾	3

	
.close