.gba
.open "zm.gba",".gba",0x8000000

.definelabel SpriteAiStart,875e8c0h
.definelabel UpDownBigJetOAM,83191BCh
.definelabel UpDownSmallJetOAM,831926Ch
.definelabel LeftRightBigJetOAM,831915Ch
.definelabel LeftRightSmallJetOAM,831921Ch
.definelabel TheDiagonalBigJetOAM,83192BCh
.definelabel TheDiagonalSmallJetOAM,831931Ch
.definelabel CurrSprite,0x3000738
.definelabel CheckBlock3,800f720h
.definelabel SpriteRNG,300083Ch
.definelabel CheckAnimation,800FBC8h
.definelabel CheckAnimation2,800FC00h
.definelabel AreaHeaderDataOffset,0x875FAC4
.definelabel CurrentArea,3000054h
.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
;2D标记大小
;取向0   向上喷
;取向100 向下喷
;取向400 向右喷
;取向440 向左喷
;2E标记斜
;2F标记四种类型 上下左右 左上 左下 右上 右下  
;2C储存待机随机帧数值
;2A当前喷气的最末动画数
;06标记斜的下
.org SpriteAiStart + ( 0xA8 * 4 )       ;改写ai的地址
    .word NewTheJetMain + 1
	
.org 8304054h
NewTheJetMain:
	push r4-r7,lr
	ldr r4,=CurrSprite
	mov r5,r4
	add r5,20h
	ldrb r0,[r5,4h]
	lsl r0,r0,2h
	ldr r1,=NewTheJetPoseTable
	add r0,r0,r1
	ldr r0,[r0]
	mov r15,r0
.pool
NewTheJetPoseTable:
	.word NewTheJetPoseZeroBL
	.word NewTheJetRNGPoseBL
	.word NewTheJetAppearPoseBL        ;2
;	.word NewTheSmallJetPoseBL      ;3
;	.word NewTheDiagonalBigUpJetPoseBL ;4
;	.word NewTheDiagonalBigDownJetPoseBl ;5
;	.word NewTheDiagonalSmallUpJetPoseBL ;6
;	.word NewTheDiagonalSmallDownJetPoseBL ;7
NewTheJetPoseZeroBL:
	bl NewTheJetPoseZero
	b @Thend
NewTheJetRNGPoseBL:
	bl NewTheJetRNGPose
	b @Thend
NewTheJetAppearPoseBL:
	bl NewTheJetAppearPose
;	b @Thend
;NewTheSmallJetPoseBL:
;	bl NewTheSmallJetPose
;	b @Thend
;NewTheDiagonalBigUpJetPoseBL:
;	bl NewTheDiagonalBigUpJetPose
;	b @Thend
;NewTheDiagonalBigDownJetPoseBl:
;	bl NewTheDiagonalBigDownJetPoseBl
;	b @Thend
;NewTheDiagonalSmallUpJetPoseBL:
;	bl NewTheDiagonalSmallUpJetPose
;	b @Thend
;NewTheDiagonalSmallDownJetPoseBL:
;	bl NewTheDiagonalSmallDownJetPose
@Thend:
	pop r4-r7
	pop r1
	bx r1
	.pool
NewTheJetPoseZero:
	push lr
	ldrb r0,[r4,1h]
	mov r1,80h
	lsl r1,r1,8h
	orr r0,r1
	strb r0,[r4,1h]        ;被攻击判定无效flag
	ldrb r0,[r5,12h]
	mov r1,40h
	orr r0,r1
	strb r0,[r5,12h]	   ;无敌,防止旋转攻击和冲刺造成死机
	mov r0,2h
	strb r0,[r5,4h]        ;Pose写入2h
	bl CheckSpritePropertySet
	ldr r1,=NewTheJetType
	lsl r0,r0,2h
	add r0,r0,r1
	ldr r0,[r0]
	mov r15,r0
	.pool
NewTheJetType:
	.word 0x0               ;UnUse
	.word NewTheStraightBigJetType
	.word NewTheStraightSmallJetType    
	.word NewTheDiagonalUpBigJetType 
	.word NewTheDiagonalUpSmallJetType
	.word NewTheDiagonalDownBigJetType 
	.word NewTheDiagonalDownSmallJetType
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
	.word NewTheJetUnUse
NewTheJetUnUse:
	mov r0,0h
	strh r0,[r4]
	pop r1
	bx r1
NewTheStraightBigJetType:
	mov r0,1h
	strb r0,[r5,0Dh]        ;大标记
NewTheStraightSmallJetType:	
;	strb r0,[r5,0Eh]        ;横标记 0为横
	ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]         
	bl CheckBlock3
	mov r1,0F0h
	and r0,r1
	cmp r0,0h
	beq @@DownNoBlock
	;下方一格有砖
	ldrh r1,[r4]
	ldr r0,=0FBFFh
	and r0,r1
	strh r0,[r4]
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@UpStraightSmallJet
	mov r0,48h
	strb r0,[r5,7h]         ;上视界写入48h
	mov r0,8h
	strb r0,[r5,8h]         ;下视界写入8h
	strb r0,[r5,9h]         ;左右视界写入8h
	b @@Peer
.pool	
@@UpStraightSmallJet:
	mov r0,28h
	strb r0,[r5,7h]
	mov r0,4h
	strb r0,[r5,8h]
	mov r0,8h
	strb r0,[r5,9h]
	b @@Peer
@@DownNoBlock:
	ldrh r0,[r4,2h]
	sub r0,44h
	ldrh r1,[r4,4h]
	bl CheckBlock3           ;检查向上一格是否有砖
	mov r1,0F0h
	and r0,r1
	cmp r0,0h
	beq @@DownAndUpNoBlock
	;上一格有砖
	ldrh r1,[r4]
	ldr r0,=0FBFFh
	and r0,r1
	mov r2,80h
	lsl r2,r2,1h             ;取向去掉400加上100 倒立的
	orr r0,r2
	strh r0,[r4]
	ldrh r0,[r4,2h]
	sub r0,40h
	strh r0,[r4,2h]          ;Y坐标向上一格
	mov r0,1h  
	strb r0,[r5,0Fh]         ;标记向下的
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@DownStraightSmallJet
	mov r0,8h
	strb r0,[r5,7h]
	strb r0,[r5,9h]
	mov r0,48h
	strb r0,[r5,8h]
;	mov r0,48h
;	strb r0,[r5,8h]          ;左右视界写入48?????
	b @@Peer
@@DownStraightSmallJet:
	mov r0,4h
	strb r0,[r5,7h]
;	mov r0,28h
;	strb r0,[r5,8h]           ;左右视界写入28????
	strb r0,[r5,9h]
	mov r0,28h
	strb r0,[r5,8h]
	b @@Peer
@@DownAndUpNoBlock:
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@LevelStraightSmallJet
	mov r0,8h
	strb r0,[r5,7h]
	strb r0,[r5,8h]
	mov r0,48h
	strb r0,[r5,9h]
	b @@CheckLeftRightBlock
@@LevelStraightSmallJet:
	mov r0,4h
	strb r0,[r5,7h]
	strb r0,[r5,8h]
	mov r0,30h
	strb r0,[r5,9h]
;   b @@Peer
@@CheckLeftRightBlock:
    ldrh r0,[r4,2h]
	sub r0,20h
	ldrh r1,[r4,4h]
	sub r1,24h
	bl CheckBlock3            ;检查左边一格是否有砖
	mov r1,0F0h
	and r0,r1
	cmp r0,0h
	beq @@DownUpAndLeftNoBlock
	ldrh r1,[r4]
	mov r2,80h
	lsl r2,r2,3h
	orr r1,r2
	strh r1,[r4]               ;取向orr400h
	ldrh r0,[r4,2h]
	ldrb r1,[r5,0Dh]
	lsl r1,r1,4h
	add r1,10h
	sub r0,r0,r1
;	lsl r0,r0,10h
;	lsr r0,r0,10h
	strh r0,[r4,2h]            ;Y坐标向上半格
	ldrh r0,[r4,4h]
	sub r0,20h
	strh r0,[r4,4h]            ;X坐标向左半格
	mov r0,2h
	strb r0,[r5,0Fh]           ;标记向右喷
	b @@Peer
@@DownUpAndLeftNoBlock:
	ldrh r0,[r4,2h]
	sub r0,20h
	ldrh r1,[r4,4h]
	add r1,20h
	bl CheckBlock3
	mov r1,0F0h
	and r0,r1
	cmp r0,0h
	bne @@RightHaveBlock
	strh r0,[r4]
	b @@end
@@RightHaveBlock:
	ldrh r1,[r4]
	mov r2,80h
	lsl r2,r2,3h
	orr r1,r2
	mov r0,40h
	orr r0,r1
	strh r0,[r4]          ;取向orr 440
	ldrh r0,[r4,2h]
	ldrb r1,[r5,0Dh]
	lsl r1,r1,4h
	add r1,10h
	sub r0,r0,r1
;	lsl r0,r0,10h
;	lsr r0,r0,10h
	strh r0,[r4,2h]       ;Y坐标向上半格
	ldrh r0,[r4,4h]
	add r0,20h
	strh r0,[r4,4h]       ;X坐标向右半格
	mov r0,3h
	strb r0,[r5,0Fh]      ;标记向左喷
@@Peer:
	ldrh r0,[r4]
	mov r1,80h
	lsl r1,r1,3h
	and r0,r1
	cmp r0,0h
	beq @@UpDownType
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@LeftRightTypeSmall
	ldr r0,=LeftRightBigJetOAM
	b @@WriteOAM
.pool
@@LeftRightTypeSmall:
	ldr r0,=LeftRightSmallJetOAM
	b @@WriteOAM
.pool
@@UpDownType:
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@UpDownTypeSmall
	ldr r0,=UpDownBigJetOAM
	b @@WriteOAM
.pool	
@@UpDownTypeSmall:
	ldr r0,=UpDownSmallJetOAM
@@WriteOAM:
	str r0,[r4,18h]
	mov r0,0h
	strb r0,[r4,1Ch]
	ldr r0,=SpriteRNG
	ldrb r2,[r0]
	mov r0,7h
	and r0,r2
	strh r0,[r4,16h]
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@SmallKnockBack
	mov r0,0Dh
	b @@WriteKnockBackType
.pool	
@@SmallKnockBack:
	mov r0,4h
@@WriteKnockBackType:
	strb r0,[r5,5h]
	mov r0,0h
	strh r0,[r4,0Ah]
	strh r0,[r4,0Ch]
	strh r0,[r4,0Eh]
	strh r0,[r4,10h]
@@end:
	pop r1
	bx r1
.pool
NewTheDiagonalDownSmallJetType:
	mov r0,1h
	strb r0,[r4,06h]     ;标记为下
	b NewTheDiagonalUpSmallJetType
NewTheDiagonalDownBigJetType:
	mov r0,1h
	strb r0,[r4,6h]     ;标记为下
NewTheDiagonalUpBigJetType:
	mov r0,1h
	strb r0,[r5,0Dh]     ;标记为大	
NewTheDiagonalUpSmallJetType:
	mov r0,1h
	strb r0,[r5,0Eh]     ;标记为斜
	mov r0,2h
	strb r0,[r5,04h]	 ;Pose写入2
	ldrh r0,[r4,2h]
	sub r0,20h
	ldrh r1,[r4,4h]
	sub r1,24h
	bl CheckBlock3       ;检查左边一格是否有砖
	mov r1,0F0h
	and r1,r0
	cmp r1,0h
	bne @@LeftHaveBlock
	ldrh r1,[r4]
	mov r0,40h
	orr r0,r1
	strh r0,[r4]         ;向左喷
	mov r0,1h
	strb r0,[r4,7h]      ;标记向左喷
@@LeftHaveBlock:
	ldrb r0,[r4,6h]      ;检查是否是向下的
	cmp r0,0h
	bne @@DownType
	ldrb r0,[r5,0Dh]     ;检查粗细
	cmp r0,0h
	beq @@SmallType
	ldrh r0,[r4,2h]
	sub r0,20h
;	lsl r0,r0,10h
;	lsr r0,r0,10h
	strh r0,[r4,2h]
	mov r0,40h
	strb r0,[r5,7h]
	mov r0,8h
	b @@Write
@@SmallType:	
    mov r1,10h
	ldrb r0,[r4,7h]
	cmp r0,0h
	bne @@LeftSmallJet
	neg r1,r1
@@leftSmallJet:
	ldrh r0,[r4,4h]
	add r0,r1,r0
	lsl r0,r0,10h
	lsr r0,r0,10h
	strh r0,[r4,4h]
	mov r0,28h
	strb r0,[r5,7h]
	mov r0,4h
	b @@WriteSmall
@@DownType:
	mov r1,80h
	lsl r1,r1,1h
	ldrh r0,[r4]
	orr r1,r0
	strh r1,[r4]         ;取向写入倒立
	ldrb r0,[r5,0Dh]     ;斜下的粗细
	cmp r0,0h
	beq @@SmallDownType
	ldrh r0,[r4,2h]
	sub r0,20h
;	lsl r0,r0,10h
;	lsr r0,r0,10h
	strh r0,[r4,2h]
	mov r0,8h
	strb r0,[r5,7h]
	mov r0,40h
@@Write:
	strb r0,[r5,8h]
	mov r0,50h
	strb r0,[r5,9h]
	ldr r0,=TheDiagonalBigJetOAM  ;斜的大
	str r0,[r4,18h]
	b @@DiagonalPeer
.pool	
@@SmallDownType:
	ldrh r0,[r4,2h]
	sub r0,38h
;	lsl r0,r0,10h
;	lsr r0,r0,10h
	strh r0,[r4,2h]
	mov r1,10h
	ldrb r0,[r4,7h]
	cmp r0,0h
	bne @@LeftDownSmallJet
	neg r1,r1
@@leftDownSmallJet:
	ldrh r0,[r4,4h]
	add r0,r1,r0
	lsl r0,r0,10h
	lsr r0,r0,10h
	strh r0,[r4,4h]
	mov r0,4h
	strb r0,[r5,7h]
	mov r0,28h
@@WriteSmall:
	strb r0,[r5,8h]
	mov r0,30h
	strb r0,[r5,9h]
	ldr r0,=TheDiagonalSmallJetOAM  ;斜的小
	str r0,[r4,18h]
	b @@DiagonalPeer
.pool
@@DiagonalPeer:
	ldrh r0,[r4]
	mov r2,r0
	mov r1,40h
	and r0,r1
	cmp r0,0h
	beq @@RightJetFlag
	lsl r1,r1,2h
	and r2,r1
	cmp r2,0h
	bne @@LeftDownJetFlag
	mov r0,0h                    ;类型左上
	b @@WriteType
@@LeftDownJetFlag:
	mov r0,1h 					 ;类型左下
	b @@WriteType
@@RightJetFlag:
	lsl r1,r1,2h
	and r2,r1
	cmp r2,0h
	bne @@RightDownJetFlag
	mov r0,2h                    ;类型右上
	b @@WriteType
@@RightDownJetFlag:
	mov r0,3h                    ;类型右下
@@WriteType:
	strb r0,[r5,0Fh]               
	mov r0,0h
	strb r0,[r4,1Ch]
	ldr r0,=SpriteRNG
	ldrb r2,[r0]
	mov r0,7h
	and r0,r2
	strh r0,[r4,16h]
	mov r0,0h
	strh r0,[r4,0Ah]
	strh r0,[r4,0Ch]
	strh r0,[r4,0Eh]
	strh r0,[r4,10h]
	mov r1,4h
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@PassAdd
	add r1,9h
@@PassAdd:
	strb r1,[r5,5h]	
	pop r1
	bx r1
.pool	
	
NewTheJetRNGPose:
	ldrb r0,[r5,0Ch]
	cmp r0,0h
	bne @@JetKeepAppearless
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
	mov r0,2h
	strb r0,[r5,4h]
	ldr r1,=0FFFBh
	ldrh r0,[r4]
	and r0,r1
	strh r0,[r4]               ;显形
	b @@end
@@JetKeepAppearless:	
	sub r0,1h
	strb r0,[r5,0Ch]
	ldrb r0,[r5,0Ah]
	strh r0,[r4,16h]
	ldrh r0,[r4]
	mov r1,4h
	orr r0,r1
	strh r0,[r4]               ;隐形
	mov r0,1h
	strb r0,[r5,6h]            ;待机
@@end:
	bx lr
.pool

NewTheJetAppearPose:
	push lr
	bl CheckAnimation2
	cmp r0,1h
	bne @@AnimationNoEnd
	strb r0,[r5,4h]
	ldr r0,=SpriteRNG
	ldrb r0,[r0]
	mov r1,7h
	and r0,r1
	mov r1,3h
	orr r0,r1
	lsl r0,r0,3h	
	strb r0,[r5,0Ch]  ;下一次出现的帧数
	ldrb r0,[r4,16h]
	strb r0,[r5,0Ah]  ;保存当前喷气的最末的动画数
	b @end
@@AnimationNoEnd:
	ldrb r0,[r5,0Eh]  ;检查是否是斜的喷气
	lsl r2,r0,5h  
	ldrb r0,[r5,0Fh]  ;读取蒸汽的类型
	ldrb r1,[r5,0Dh]  ;读取蒸汽的大小类型
	lsl r1,r1,4h
	lsl r0,r0,2h
	add r0,r0,r1
	ldr r1,=JetTypeTable
	add r0,r0,r1
	add r0,r0,r2
	ldr r0,[r0]
	mov r15,r0
.pool
JetTypeTable:
	.word StraightUpSmallJetType
	.word StraightDownSmallJetType
	.word StraightRightSmallJetType
	.word StraightLeftSmallJetType
	.word StraightUpBigJetType
	.word StraightDownBigJetType
	.word StraightRightBigJetType
	.word StraightLeftBigJetType
	.word DiagonalUpLeftSmallJetType
	.word DiagonalDownLeftSmallJetType
	.word DiagonalUpRightSmallJetType
	.word DiagonalDownRightSmallJetType
	.word DiagonalUpLeftBigJetType
	.word DiagonalDownLeftBigJetType
	.word DiagonalUpRightBigJetType
	.word DiagonalDownRightBigJetType
StraightUpSmallJetType:
	bl StraightUpSmallJetTypeG
	b @end
StraightDownSmallJetType:
	bl StraightDownSmallJetTypeG
	b @end
StraightRightSmallJetType:
	bl StraightRightSmallJetTypeG
	b @end	
StraightLeftSmallJetType:
	bl StraightLeftSmallJetTypeG
	b @end
StraightUpBigJetType:
	bl StraightUpBigJetTypeG
	b @end
StraightDownBigJetType:
	bl StraightDownBigJetTypeG
	b @end
StraightRightBigJetType:
	bl StraightRightBigJetTypeG
	b @end
StraightLeftBigJetType:
	bl StraightLeftBigJetTypeG
	b @end
DiagonalUpRightSmallJetType:
	bl DiagonalUpRightSmallJetTypeG
	b @end
DiagonalUpRightBigJetType:
    bl DiagonalUpRightBigJetTypeG
	b @end
DiagonalDownRightSmallJetType:
	bl DiagonalDownRightSmallJetTypeG
	b @end
DiagonalDownRightBigJetType:
	bl DiagonalDownRightBigJetTypeG
	b @end
DiagonalUpLeftSmallJetType:
	bl DiagonalUpLeftSmallJetTypeG
	b @end
DiagonalUpLeftBigJetType:
	bl DiagonalUpLeftBigJetTypeG
	b @end
DiagonalDownLeftSmallJetType:
	bl DiagonalDownLeftSmallJetTypeG
	b @end
DiagonalDownLeftBigJetType:
	bl DiagonalDownLeftBigJetTypeG
	b @end
@end:
	ldrh r0,[r4,16h]
	cmp r0,0h
	bne @@NoPlaySound
	ldrb r1,[r4,1Ch]
	cmp r1,1h
	bne @@NoPlaySound
	ldrh r0,[r4]
	mov r1,2h
	and r0,r1
	cmp r0,0h
	beq @@NoPlaySound
	ldrb r0,[r5,0Dh]
	cmp r0,0h
	beq @@SmallJetSound
	mov r0,09Eh
	lsl r0,r0,2h
	bl PlaySound2
	b @@NoPlaySound
@@SmallJetSound:
	ldr r0,=279h
	bl PlaySound2
@@NoPlaySound:	
	pop r1
	bx r1
.pool	
;r0=上部分界
;r1=下部分界
;r2=左部分界
;r3=右部分界
StraightUpSmallJetTypeG:
	ldrh r0,[r4,16h]
	cmp r0,6h
	bcs @@ZeroDecide
	mov r1,20h
	mul r0,r1
	add r0,8h
	neg r0,r0
	mov r3,10h
	neg r2,r3
	mov r1,0h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,0h
	mov r1,0h
	mov r2,0h
	mov r3,0h
@@WriteBoundary:
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14
.pool
StraightUpBigJetTypeG:
	mov r3,1Fh
	neg r2,r3
	ldrh r0,[r4,16h]
	cmp r0,6h
	bcs @@ZeroDecide
	cmp r0,3h
	bcs @@Other
	lsl r0,r0,6h
	b @@WriteBoundary
@@Other:
	sub r0,2h
	mov r1,30h
	mul r0,r1
	add r0,80h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,0h
	mov r2,0h
	mov r3,0h
@@WriteBoundary:
	neg r0,r0
	mov r1,0h
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14
.pool	
StraightDownSmallJetTypeG:
    ldrh r0,[r4,16h]
	cmp r0,6h
	bcs @@ZeroDecide
	mov r1,20h
	mul r1,r0
	add r1,8h
	mov r3,10h
	neg r2,r3
	mov r0,0h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,0h
	mov r1,10h
	neg r1,r1
	mov r2,0h
	mov r3,0h
@@WriteBoundary:
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14
.pool
StraightDownBigJetTypeG:
	mov r3,1Fh
	neg r2,r3
	ldrh r1,[r4,16h]
	cmp r1,6h
	bcs @@ZeroDecide
	cmp r1,3h
	bcs @@Other
	lsl r1,r1,6h
	b @@WriteBoundary
@@Other:
	sub r1,2h
	mov r0,30h
	mul r1,r0
	add r1,80h
	b @@WriteBoundary
@@ZeroDecide:
	mov r1,10h
	neg r1,r1
	mov r2,0h
	mov r3,0h
@@WriteBoundary:
	mov r0,0h
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14
.pool
StraightRightSmallJetTypeG:
    ldrh r0,[r4,16h]
	cmp r0,6h
	bcs @@ZeroDecide
	mov r3,20h
	mul r3,r0
	add r3,8h
	mov r1,10h
	neg r0,r1
	mov r2,r0
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,0h
	mov r1,0h
	mov r2,0h
	mov r3,10h
	neg r3,r3
@@WriteBoundary:
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14	
.pool
StraightRightBigJetTypeG:
	mov r1,1Fh
	neg r0,r1
	ldrh r3,[r4,16h]
	cmp r3,6h
	bcs @@ZeroDecide
	cmp r3,3h
	bcs @@Other
	lsl r3,r3,6h
	b @@WriteBoundary
@@Other:
	sub r3,2h
	mov r2,30h
	mul r3,r2
	add r3,80h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,0h
	mov r1,0h
	mov r3,10h
	neg r3,r3
@@WriteBoundary:
	mov r2,0h
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14
.pool
StraightLeftSmallJetTypeG:
    ldrh r0,[r4,16h]
	cmp r0,6h
	bcs @@ZeroDecide
	mov r2,20h
	mul r2,r0
	add r2,8h
	neg r2,r2
	mov r1,10h
	neg r0,r1
	mov r3,0h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,0h
	mov r1,0h
	mov r2,0h
	mov r3,0h
@@WriteBoundary:
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14	
.pool
StraightLeftBigJetTypeG:
    mov r1,1Fh
	neg r0,r1
	ldrh r2,[r4,16h]
	cmp r2,6h
	bcs @@ZeroDecide
	cmp r2,3h
	bcs @@Other
	lsl r2,r2,6h
	b @@WriteBoundary
@@Other:
	sub r2,2h
	mov r3,30h
	mul r2,r3
	add r2,80h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,0h
	mov r1,0h
	mov r2,0h
@@WriteBoundary:
	neg r2,r2
	mov r3,0h
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	bx r14
.pool
	
DiagonalUpRightSmallJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,7h
	bcs @@ZeroDecide
	bl DistributionDiagonalSmallJetXYDecide
	mov r3,r1
	neg r0,r0
	mov r1,r0
	add r1,20h
	mov r2,r3
	sub r2,20h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool
	
DiagonalUpRightBigJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,8h
	bcs @@ZeroDecide
	bl DistributionDiagonalBigJetXYDecide
	mov r3,r1
	neg r0,r0
	mov r1,r0
	add r1,40h
	mov r2,r3
	sub r2,40h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool
	
DiagonalDownRightSmallJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,7h
	bcs @@ZeroDecide
	bl DistributionDiagonalSmallJetXYDecide
	mov r3,r1
	mov r1,r0
	sub r0,20h
	mov r2,r3
	sub r2,20h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool
	
DiagonalDownRightBigJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,8h
	bcs @@ZeroDecide
	bl DistributionDiagonalBigJetXYDecide
	mov r3,r1
	mov r1,r0
	sub r0,40h
	mov r2,r3
	sub r2,40h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool
	
DiagonalUpLeftSmallJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,7h
	bcs @@ZeroDecide
	bl DistributionDiagonalSmallJetXYDecide
	mov r2,r1
	neg r0,r0
	mov r1,r0
	add r1,20h
	neg r2,r2
	mov r3,r2
	add r3,20h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool
	
DiagonalUpLeftBigJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,8h
	bcs @@ZeroDecide
	bl DistributionDiagonalBigJetXYDecide
	mov r2,r1
	neg r0,r0
	mov r1,r0
	add r1,40h
	neg r2,r2
	mov r3,r2
	add r3,40h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool
	
DiagonalDownLeftSmallJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,7h
	bcs @@ZeroDecide
	bl DistributionDiagonalSmallJetXYDecide
	mov r2,r1
	mov r1,r0
	sub r0,20h
	neg r2,r2
	mov r3,r2
	add r3,20h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool
	
DiagonalDownLeftBigJetTypeG:
	push lr
	ldrh r0,[r4,16h]
	cmp r0,8h
	bcs @@ZeroDecide
	bl DistributionDiagonalBigJetXYDecide
	mov r2,r1
	mov r1,r0
	sub r0,40h
	neg r2,r2
	mov r3,r2
	add r3,40h
	b @@WriteBoundary
@@ZeroDecide:
	mov r0,1h
	strb r0,[r5,6h]
@@WriteBoundary:	
	strh r0,[r4,0Ah]
	strh r1,[r4,0Ch]
	strh r2,[r4,0Eh]
	strh r3,[r4,10h]
	pop r1
	bx r1
.pool

DistributionDiagonalSmallJetXYDecide:	
	cmp r0,0h
	bne @@NextCheck
	mov r0,20h
	mov r1,18h
	b @@end
@@NextCheck:
	cmp r0,1h
	bne @@NextCheck1
	mov r0,40h
	mov r1,38h
	b @@end
@@NextCheck1:
	cmp r0,2h
	bne @@NextCheck2
	mov r0,60h
	mov r1,58h
	b @@end	
@@NextCheck2:
	cmp r0,3h
	bne @@NextCheck3
	mov r0,80h
	mov r1,70h
	b @@end
@@NextCheck3:
	cmp r0,4h
	bne @@NextCheck4
	mov r0,90h
	mov r1,80h
	b @@end
@@NextCheck4:
	cmp r0,5h
	bne @@Finall
	mov r0,0A0h
	mov r1,80h
	b @@end
@@Finall:
	mov r0,0C0h
	mov r1,90h
@@end:
	bx lr
.pool	
	
DistributionDiagonalBigJetXYDecide:
	cmp r0,0h
	bne @@NextCheck
	mov r0,40h
	mov r1,40h
	b @@end
@@NextCheck:
	cmp r0,1h
	bne @@NextCheck1
	mov r0,60h
	mov r1,60h
	b @@end
@@NextCheck1:
	cmp r0,2h
	bne @@NextCheck2
	mov r0,90h
	mov r1,80h
	b @@end	
@@NextCheck2:
	cmp r0,3h
	bne @@NextCheck3
	mov r0,0C0h
	mov r1,0A0h
	b @@end
@@NextCheck3:
	cmp r0,4h
	bne @@NextCheck4
	mov r0,80h
	lsl r0,r0,1h
	mov r1,0C0h
	b @@end
@@NextCheck4:
	cmp r0,5h
	bne @@NextCheck5
	mov r0,88h
	lsl r0,r0,1h
	mov r1,0E0h
	b @@end
@@NextCheck5:
	cmp r0,6h
	bne @@Finall
	mov r0,90h
	lsl r0,r0,1h
	mov r1,0F0h
	b @@end
@@Finall:
	mov r0,0A0h
	mov r1,80h
	lsl r0,r0,1h
	lsl r1,r1,1h
@@end:
	bx lr
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