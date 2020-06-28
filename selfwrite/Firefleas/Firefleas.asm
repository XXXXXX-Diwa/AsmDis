.gba
.open "zm.gba",".gba",0x8000000

.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteRNG,300083Ch
.definelabel BGDataStart,300009Ch
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0
.definelabel FireFleasID,0x70
.definelabel CurrSprite,0x3000738
.definelabel FrozenRoutine,800FFE8h	
.definelabel DeathFireWorks,8011084h
.definelabel AreaHeaderDataOffset,0x875FAC4
.definelabel CurrentArea,3000054h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel RandomDirection,800F80Ch
.definelabel SpriteData,0x30001AC
.definelabel SpriteDataEnd,0x30006EC
.definelabel CheckRange,800FDE0h
.definelabel BG0ControlRAM,0x30056C4
.definelabel BG0ControlRoutine,8055BD0h
.definelabel SamusData,0x30013D4

;2E  移动在圆的阶段数\
;2F  Pose备份值,Pose5以后无用\
;12  半径长度\
;2D  移动的速度\
;2A  临时加速帧数\
;35  已经检查过的标记\
;36  速度增加的值\
;当半径相同,同坐标的灯虫,会以同样的方向旋转,并稍微拉开间距
;1-7为横竖移动的灯虫
;9-F为绕圈的灯虫,并且数值越大则圈越大,顺逆时则随机
;firefleas
;房间的前景透明设置为1Ah

.org SpriteAiStart + ( FireFleasID * 4 )
    .word FireFleasMain + 1

.org SpriteGfxPointers + ( FireFleasID - 10h ) * 4
    .word FireFleasGfx
	
.org SpritePalPointers + ( FireFleasID - 10h ) * 4
    .word FireFleasPal
	

.org 0x8762D38
.align
FireFleasGfx:
.import "FireFleas.Gfx.lz"
.align
FireFleasPal:
.import "FireFleas.palette"

.align
FireFleasOAM:   
    .word FireFleasOAM1_2
	.word 0x2
	.word FireFleasOAM1_1
	.word 0x2
	.word FireFleasOAM1_2
	.word 0x2
	.word FireFleasOAM1_3
	.word 0x2
	.word FireFleasOAM2_2
	.word 0x2
	.word FireFleasOAM2_1
	.word 0x2
	.word FireFleasOAM2_2
	.word 0x2
	.word FireFleasOAM2_3
	.word 0x2
	.word FireFleasOAM3_2
	.word 0x2
	.word FireFleasOAM3_1
	.word 0x2
	.word FireFleasOAM3_2
	.word 0x2
	.word FireFleasOAM3_3
	.word 0x2
	.word FireFleasOAM4_2
	.word 0x2
	.word FireFleasOAM4_1
	.word 0x2
	.word FireFleasOAM4_2
	.word 0x2
	.word FireFleasOAM4_3
	.word 0x2
	.word FireFleasOAM5_2
	.word 0x2
	.word FireFleasOAM5_1
	.word 0x2
	.word FireFleasOAM5_2
	.word 0x2
	.word FireFleasOAM5_3
	.word 0x2
	.word FireFleasOAM6_2
	.word 0x2
	.word FireFleasOAM6_1
	.word 0x2
	.word FireFleasOAM6_2
	.word 0x2
	.word FireFleasOAM6_3
	.word 0x2
	.word FireFleasOAM7_2
	.word 0x2
	.word FireFleasOAM7_1
	.word 0x2
	.word FireFleasOAM7_2
	.word 0x2
	.word FireFleasOAM7_3
	.word 0x2
	.word FireFleasOAM6_2
	.word 0x2
	.word FireFleasOAM6_1
	.word 0x2
	.word FireFleasOAM6_2
	.word 0x2
	.word FireFleasOAM6_3
	.word 0x2
	.word FireFleasOAM5_2
	.word 0x2
	.word FireFleasOAM5_1
	.word 0x2
	.word FireFleasOAM5_2
	.word 0x2
	.word FireFleasOAM5_3
	.word 0x2
	.word FireFleasOAM4_2
	.word 0x2
	.word FireFleasOAM4_1
	.word 0x2
	.word FireFleasOAM4_2
	.word 0x2
	.word FireFleasOAM4_3
	.word 0x2
	.word FireFleasOAM3_2
	.word 0x2
	.word FireFleasOAM3_1
	.word 0x2
	.word FireFleasOAM3_2
	.word 0x2
	.word FireFleasOAM3_3
	.word 0x2	
	.word FireFleasOAM2_2
	.word 0x2
	.word FireFleasOAM2_1
	.word 0x2
	.word FireFleasOAM2_2
	.word 0x2
	.word FireFleasOAM2_3
	.word 0x2	
	.word 0x0,0
.align
FireFleasOAM1_1:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8200
	 .dh 0x40F0,0x0000,0x8220
	 .dh 0x40F0,0x11F0,0x8220
.align
FireFleasOAM1_2:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8200
	 .dh 0x40F0,0x0000,0x8222
	 .dh 0x40F0,0x11F0,0x8222
.align
FireFleasOAM1_3:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8200
	 .dh 0x00E8,0x4000,0x820E
	 .dh 0x00E8,0x51F0,0x820E
.align
FireFleasOAM2_1:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8202
	 .dh 0x40F0,0x0000,0x8220
	 .dh 0x40F0,0x11F0,0x8220
.align
FireFleasOAM2_2:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8202
	 .dh 0x40F0,0x0000,0x8222
	 .dh 0x40F0,0x11F0,0x8222
.align
FireFleasOAM2_3:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8202
	 .dh 0x00E8,0x4000,0x820E
	 .dh 0x00E8,0x51F0,0x820E
.align
FireFleasOAM3_1:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8204
	 .dh 0x40F0,0x0000,0x8224
	 .dh 0x40F0,0x11F0,0x8224
.align
FireFleasOAM3_2:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8204
	 .dh 0x40F0,0x0000,0x8226
	 .dh 0x40F0,0x11F0,0x8226
.align
FireFleasOAM3_3:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8204
	 .dh 0x00E8,0x4000,0x8210
	 .dh 0x00E8,0x51F0,0x8210

.align
FireFleasOAM4_1:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8206
	 .dh 0x40F0,0x0000,0x8224
	 .dh 0x40F0,0x11F0,0x8224
.align
FireFleasOAM4_2:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8206
	 .dh 0x40F0,0x0000,0x8226
	 .dh 0x40F0,0x11F0,0x8226	 
	
.align
FireFleasOAM4_3:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8206
	 .dh 0x00E8,0x4000,0x8210
	 .dh 0x00E8,0x51F0,0x8210	
	
.align
FireFleasOAM5_1:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8208
	 .dh 0x40F0,0x0000,0x8224
	 .dh 0x40F0,0x11F0,0x8224
.align
FireFleasOAM5_2:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8208
	 .dh 0x40F0,0x0000,0x8226
	 .dh 0x40F0,0x11F0,0x8226	
.align
FireFleasOAM5_3:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x8208
	 .dh 0x00E8,0x4000,0x8210
	 .dh 0x00E8,0x51F0,0x8210	 
	 
.align
FireFleasOAM6_1:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x820A
	 .dh 0x40F0,0x0000,0x8228
	 .dh 0x40F0,0x11F0,0x8228
.align
FireFleasOAM6_2:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x820A
	 .dh 0x40F0,0x0000,0x822A
	 .dh 0x40F0,0x11F0,0x822A	
.align
FireFleasOAM6_3:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x820A
	 .dh 0x00E8,0x4000,0x8212
	 .dh 0x00E8,0x51F0,0x8212

.align
FireFleasOAM7_1:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x820C
	 .dh 0x40F0,0x0000,0x8228
	 .dh 0x40F0,0x11F0,0x8228
.align
FireFleasOAM7_2:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x820C
	 .dh 0x40F0,0x0000,0x822A
	 .dh 0x40F0,0x11F0,0x822A	
.align
FireFleasOAM7_3:
     .dh 0x03
	 .dh 0x40F8,0x01F8,0x820C
	 .dh 0x00E8,0x4000,0x8212
	 .dh 0x00E8,0x51F0,0x8212

.align
FireFleasCircleSpeed:
.import "SpriteCircleMoveData.spe"



;.org 0x80286b8
.org 0x8304054
FireFleasMain:
     push r4-r7,lr
	 add sp,-4h
	 ldr r4,=CurrSprite
	 mov r5,r4
	 add r5,20h
	 bl CheckTheNumberOfFireFleasInTheRangeChangeBG0
     ldrb r0,[r5,10h]        ;冰冻时间
	 cmp r0,0h
	 beq @@NoFrozening
	 bl FrozenRoutine
	 b @Thend
	 .pool
@@NoFrozening: 
	 ldrb r0,[r5,4h]
	 cmp r0,5h
	 bhi @DeathPose
	 lsl r0,r0,2h
	 ldr r1,=FireFleasPoseTable
	 add r0,r1
	 ldr r0,[r0]
	 mov r15,r0
	.pool
FireFleasPoseTable:
    .word FireFleaPose0
    .word FireFleaPose1
	.word FireFleaPose2
	.word FireFleaPose3
	.word FireFleaPose4
	.word FireFleaPose5
FireFleaPose0:
    bl FireFleasPose0
    b @Thend
FireFleaPose1:
    bl FireFleasPose1
    b @Thend
FireFleaPose2:
    bl FireFleasPose2
    b @Thend
FireFleaPose3:
    bl FireFleasPose3
    b @Thend
FireFleaPose4:
    bl FireFleasPose4
    b @Thend
FireFleaPose5:
    bl FireFleasPose5
    b @Thend	
@DeathPose:
    ldrh r1,[r4,2h]
	sub r1,20h
	ldrh r2,[r4,4h]
	mov r0,21h
	str r0,[sp]
	mov r0,0h
	mov r3,1h
	bl DeathFireWorks
@Thend:
    add sp,4
    pop r4-r7
    pop r0
    bx r0
.pool	

CheckTheNumberOfFireFleasInTheRangeChangeBG0:
	push r5,lr
	ldr r5,=BG0ControlRAM          
	ldr r2,=SpriteData 
	mov r7,0h                   ;初始化
	mov r6,r2
@@Loop:	
	mov r3,r6
	add r3,20h
	ldrb r0,[r6,1Dh]            ;检查精灵的ID是否相同
	cmp r0,FireFleasID
	bne @@NextSpriteDataCheck
	ldrb r0,[r6]                ;检查是否是活着的精灵
	mov r1,1h
	and r0,r1
	cmp r0,0h
	beq @@NextSpriteDataCheck
	ldrb r0,[r3,4h]             ;检查pose不是死亡的
	cmp r0,5h
	bhi @@NextSpriteDataCheck
	ldrb r0,[r3,10h]            ;检查是否是没有被冰冻
	cmp r0,0h
	bne @@NextSpriteDataCheck
;	mov r0,28h
;	lsl r0,r0,4                 ;上下十格范围内
;	mov r1,3Ch
;	lsl r1,r1,4                 ;左右15格范围内
;	ldrb r3,[r5,0Bh]            ;检查前景的透明度是否小于2
;	cmp r3,1h
;	bhi @@PassAddRange
;	lsl r0,r0,1h
;	lsl r1,r1,1h                ;Y20格 X30格检查
;@@PassAddRange:
;	bl CheckFireFleasRange
;	cmp r0,0h                   ;检查是否在范围内
;	beq @@NextSpriteDataCheck
	add r7,1h                   ;每有一个则加一
@@NextSpriteDataCheck:
	add r6,38h
	ldr r0,=SpriteDataEnd
	cmp r6,r0
	bcc @@Loop
	cmp r7,0h                   ;如果为零则让背景恢复原值
	beq @@AllFireFleasNoInRange
	ldrb r0,[r5,0Ah]            ;检查改变前景flag不为零则直接跳过
	cmp r0,0h
	bne @@end  	
	cmp r7,6h
	bcc @@LessSixNumber         ;大于等于6都按6算
	mov r7,6h
@@LessSixNumber:	
	sub r7,1h   
	ldrb r0,[r4,1Ch]            ;读取动画帧
	cmp r0,1h                   ;不为1则跳过
	bne @@end
	ldrh r0,[r4,16h]            ;读取动画0-2F
	add r0,1h
	lsr r0,r0,2h                ;除4
	lsl r7,r7,1
	cmp r0,6h
	bls @@NormalNumber
	mov r1,0Ch
	sub r0,r1,r0
@@NormalNumber:	
	mov r1,6h
	sub r1,r0
	add r1,r1,r7
	ldrb r0,[r5,0Bh]
	cmp r0,r1
	beq @@end
	mov r0,10h
	sub r0,r1
	mov r2,1h
	mov r3,1h	
	bl BG0ControlRoutine
	b @@end
	.pool
@@AllFireFleasNoInRange:
	ldrb r0,[r5,3h]
	ldrb r1,[r5,2h]
	mov r2,1h
	mov r3,1h
	bl BG0ControlRoutine
@@end:
	pop r5
	pop r0
	bx r0
.pool	
	
CheckFireFleasRange:
	Push r4-r7
	lsl r0,r0,10h
	lsr r5,r0,10h
	lsl r1,r1,10h
	lsr r4,r1,10h
	mov r7,0h
	ldr r2,=SamusData
	ldr r0,=3001588h
	add r0,70h
	mov r1,0h
	ldsh r0,[r0,r1]        ;sa上分界
	lsr r1,r0,1fh
	add r0,r0,r1
	asr r0,r0,1h           ;除以2?
	ldrh r1,[r2,14h]
	add r0,r0,r1           ;加上Sa坐标
	lsl r0,r0,10h
	lsr r3,r0,10h
	ldrh r2,[r2,12h]       ;sa x坐标
	ldrh r1,[r6,2h]
	cmp r1,r3              ;精灵Y坐标和Samus的中心高度比较
	bls @@SpriteUpSamus
	sub r0,r1,r3           
	b @@Peer
	.pool
@@SpriteUpSamus:
	sub r0,r3,r1
@@Peer:	
	cmp r0,r5
	blt @@CheckX
	mov r0,0h
	b @@end
@@CheckX:
	ldrh r0,[r6,4h]
	cmp r0,r2
	bls @@SpriteLeftSamus
	sub r0,r0,r2
	cmp r0,r4
	bge @@Willend
	mov r7,4h
	b @@Willend
@@SpriteLeftSamus:
	sub r0,r2,r0
	cmp r0,r4
	bge @@Willend
	mov r7,8h
@@Willend:
	mov r0,r7
@@end:	
	pop r4-r7
	bx r14
	.pool
	
	
	
	
FireFleasPose0:
     push lr
	 mov r0,0h
	 strb r0,[r5,15h]  ;归零
	 strb r0,[r5,16h]
	 mov r0,1h
	 strb r0,[r4,14h]  ;血量写入1
	 mov r0,6h
	 strb r0,[r5,5h]   ;属性写入碰触自爆
	 mov r0,40h
	 neg r0,r0
	 strh r0,[r4,0Ah]  ;上部分界写入
	 mov r0,0h
	 strh r0,[r4,0Ch]  ;下部分界写入
	 mov r0,20h
	 strh r0,[r4,10h]  ;右部分界写入
	 neg r0,r0
	 strh r0,[r4,0Eh]  ;左部分界写入
	 mov r0,10h
	 strb r0,[r5,7h]   ;上视界写入10h
	 mov r0,8h
     strb r0,[r5,8h]   ;左右视界写入8h
     strb r0,[r5,9h]   ;下视界写入8h
     ldr r0,=FireFleasOAM
	 str r0,[r4,18h]
	 mov r0,0h
	 strb r0,[r4,1Ch]
	 strh r0,[r4,16h]
	 strb r0,[r5,0Ch]  ;归零
	 ldrh r0,[r4,2h]
	 strh r0,[r4,6h]
	 ldrh r0,[r4,4h]
	 strh r0,[r4,8h]   ;备份坐标
	 bl CheckSpritePropertySet
	 mov r6,r0
	 mov r1,8h
	 and r1,r0
	 cmp r1,0h
	 beq @@NoCircle
	 ;-------------圆周运动系列
     bl RandomDirection   ;随机逆顺
     sub r6,7h
	 mov r1,r6
	 lsr r6,r6,1h         ;速度减倍
	 strb r6,[r5,0Dh]     ;速度
	 mov r2,40h
	 add r1,1h
	 mul r1,r2
	 strh r1,[r4,12h]     ;半径的长度
	 ldrh r0,[r4,6h]
	 add r0,r0,r1
	 strh r0,[r4,2h]
	 mov r1,3h
	 b @@WritePose
	 .pool 
@@NoCircle:
     mov r1,4h
     and r1,r0
     cmp r1,0h
     beq @@UpDownMove
     ;-------------左右移动系列	
     mov r1,2h
     b @@WritePose
@@UpDownMove:
     mov r1,1h
     b @@WritePose	 
@@WritePose:	 
	 strb r1,[r5,0Fh]        ;pose标记
	 mov r1,5h
	 strb r1,[r5,4h]         ;pose写入5
	 mov r1,2h
	 and r1,r0
	 cmp r1,0h
	 beq @@StartNoDown
	 ;-------------先向下或右系列
	 mov r1,1h
	 ldrb r2,[r5,0Ch]
	 orr r2,r1
	 strb r2,[r5,0Ch]
@@StartNoDown:
     mov r1,1h	 
	 and r1,r0
	 cmp r1,0h
	 beq @@end
	 ;-------------运动轨迹大系列
	 mov r1,10h
	 ldrb r2,[r5,0Ch]
	 orr r2,r1
	 strb r2,[r5,0Ch]
@@end:
     pop r0
	 bx r0
.pool	 
	 
FireFleasPose1:         ;上下移动
     push lr
	 ldrb r0,[r5,0Eh]
	 cmp r0,0h
	 bne @@Pass
 	 mov r0,0B4h
	 strb r0,[r5,0Eh]
	 ldrb r0,[r5,0Ch]
	 mov r1,1h
	 eor r0,r1
	 strb r0,[r5,0Ch]  ;换向
	 b @@end           ;直接结束停顿一帧
@@Pass:
	 ldrh r6,[r4,2h]
	 ldrh r7,[r4,4h]
     ldrb r0,[r5,0Ch]
	 mov r1,1h
	 and r1,r0
	 cmp r1,0h
	 beq @@UpMove
	 ;-----------------下移动
	 mov r0,r6
	 add r0,2h
	 mov r1,r7
	 bl CheckBlock2    ;检查身下
	 ldr r0,=XTagRAM
	 ldrb r0,[r0]
	 add r6,2h
	 cmp r0,11h
	 beq @@HaveBlock
	 b @@Peer
.pool
@@UpMove:
     mov r0,r6
     sub r0,42h
     mov r1,r7
     bl CheckBlock
     ldr r0,=YTagRAM
     ldrb r0,[r0]
	 sub r6,2h
     cmp r0,11h
     bne @@Peer	
@@HaveBlock:
     mov r0,0h
     strb r0,[r5,0Eh]
     b @@end	
.pool	 
@@Peer:  	 
	 strh r6,[r4,2h]
	 ldrb r0,[r5,0Ch]
	 ldrb r2,[r5,0Eh]
	 mov r1,10h
	 and r1,r0
	 cmp r1,0h
	 beq @@ShortMove
	 sub r2,1h
	 b @@Write
@@ShortMove:
     sub r2,2h
@@Write:
     strb r2,[r5,0Eh]
@@end:	 
     pop r0
     bx r0	 
.pool
	 
FireFleasPose2:               ;左右移动
	 push lr
	 ldrb r0,[r5,0Eh]
	 cmp r0,0h
	 bne @@Pass
 	 mov r0,0B4h
	 strb r0,[r5,0Eh]
	 ldrb r0,[r5,0Ch]
	 mov r1,1h
	 eor r0,r1
	 strb r0,[r5,0Ch]  ;换向
	 b @@end           ;直接结束停顿一帧
@@Pass:
	 ldrh r6,[r4,2h]
	 ldrh r7,[r4,4h]
     ldrb r0,[r5,0Ch]
	 mov r1,1h
	 and r1,r0
	 cmp r1,0h
	 beq @@LeftMove
	 ;-----------------下移动
	 mov r0,r6
	 sub r0,20h
	 mov r1,r7
	 add r1,22h
	 bl CheckBlock3    ;检查左右
	 add r7,2h
	 cmp r0,0h
	 bne @@HaveBlock
	 b @@Peer
@@LeftMove:
     mov r0,r6
	 sub r0,20h
     mov r1,r7
	 sub r1,22h
     bl CheckBlock3
	 sub r7,2h
     cmp r0,0h
     beq @@Peer	
@@HaveBlock:
     mov r0,0h
     strb r0,[r5,0Eh]
     b @@end	 
@@Peer:  	 
	 strh r7,[r4,4h]
	 ldrb r0,[r5,0Ch]
	 ldrb r2,[r5,0Eh]
	 mov r1,10h
	 and r1,r0
	 cmp r1,0h
	 beq @@ShortMove
	 sub r2,1h
	 b @@Write
@@ShortMove:
     sub r2,2h
@@Write:
     strb r2,[r5,0Eh]
@@end:	 
     pop r0
     bx r0	 
.pool

FireFleasPose3:               ;转圈
    push r4-r7,lr
	add sp,-8h
	ldrb r0,[r5,16h]         ;检查速度增加值是否为0
	cmp r0,0h
	beq @@Pass
	ldrb r0,[r5,0Ah]         ;读取速度增加的帧数
	cmp r0,0h
	bne @@SubTimes
	ldrb r0,[r5,16h]
	ldrb r1,[r5,0Dh]
	cmp r0,r1
	sub r1,r0
	cmp r1,0h
	bge @@GoTo
	Neg r1,r1
	b @@GoTo
@@SubTimes:
	sub r0,1h
	strb r0,[r5,0Ah]
	b @@Pass
@@GoTo:	
	strb r1,[r5,0Dh]
	mov r0,0h
	strb r0,[r5,16h]         ;速度增加值写入0
@@Pass:
	ldrh r1,[r4]
	mov r0,40h
	and r0,r1
	cmp r0,0h
	beq @@FaceLeft
	ldrb r0,[r5,0Eh]
	ldrb r2,[r5,0Dh]
	sub r0,r2
	b @@WriteTimes
@@FaceLeft:
	ldrb r0,[r5,0Eh]
	ldrb r2,[r5,0Dh]
	add r0,r2
@@WriteTimes:
	strb r0,[r5,0Eh]
	ldrh r7,[r4,12h]         ;半径?
	ldrb r6,[r5,0Eh]         ;计数值
	ldr r3,=FireFleasCircleSpeed
	str r3,[sp]
	lsl r0,r6,1h
	add r0,r3,r0
	mov r1,0h
	ldsh r2,[r0,r1]
	cmp r2,0h
	bge @@YNegativeless
	neg r2,r2
	mov r0,r7
	mul r0,r2
	cmp r0,0h
	bge @@YNegativeless1
	add r0,0FFh
@@YNegativeless1:
	lsl r0,r0,8h
	lsr r2,r0,10h
	ldrh r0,[r4,6h]
	sub r0,r0,r2
	b @@WriteY
.pool
@@YNegativeless:
    mov r0,r7
	mul r0,r2
	cmp r0,0h
	bge @@YNegativeless2
	add r0,0FFh
@@YNegativeless2:
	lsl r0,r0,8h
	lsr r2,r0,10h
	ldrh r0,[r4,6h]
	add r0,r0,r2
@@WriteY:
    str r0,[sp,4h]
	mov r0,r6
	add r0,40h
	lsl r0,r0,1
	ldr r3,[sp]
	add r0,r0,r3
	mov r2,0h
	ldsh r1,[r0,r2]
	cmp r1,0h
	bge @@XNegativeless
	neg r1,r1
	mov r0,r7
	mul r0,r1
	cmp r0,0h
	bge @@XNegativeless1
	add r0,0FFh
@@XNegativeless1:
	lsl r0,r0,8h
	lsr r1,r0,10h
	ldrh r0,[r4,8h]
	sub r1,r0,r1
	b @@BlockCheck
@@XNegativeless:
	mov r0,r7
	mul r0,r1
	cmp r0,0h
	bge @@XNegativeless2
	add r0,0FFh
@@XNegativeless2:
	lsl r0,r0,8h
	lsr r0,r0,10h
	ldrh r1,[r4,8h]
	add r1,r1,r0
@@BlockCheck:
	mov r7,r1
	ldr r6,[sp,4h]
	mov r0,r6
	ldrh r2,[r4,2h]
	cmp r2,r6              ;原坐标和当前坐标相比
	bhi @@UpMove
	mov r0,r6
	sub r0,4h
	;----------------------下移动
	ldrh r2,[r4,4h]
	cmp r2,r7              
	bhi @@LeftMove
	;----------------------右移动
	mov r1,r7
	add r1,1Ch
	b @@CheckBlock
@@LeftMove:
    mov r1,r7
	sub r1,1Ch
	b @@CheckBlock
@@UpMove:
    mov r0,r6
	sub r0,40h
	ldrh r2,[r4,4h]
	cmp r2,r7
	bls @@RightMove
	mov r1,r7
	sub r1,1Ch
	b @@CheckBlock
@@RightMove:
    mov r1,r7
	add r1,1Ch
@@CheckBlock:
	bl CheckBlock3
	cmp r0,0h
	beq @@WirteXY
	ldrh r0,[r4]
	mov r1,40h
	eor r0,r1
	strh r0,[r4]
	b @@end
@@WirteXY:	
	strh r6,[r4,2h]
	strh r7,[r4,4h]
@@end:	
	add sp,8h
	pop r4-r7
	pop r0
	bx r0
.pool

FireFleasPose4:               
	bx lr
.pool

FireFleasPose5:               ;分配初期运行的帧数
	push lr
	ldrb r0,[r5,0Fh]
	strb r0,[r5,4h]	         ;写入pose
	cmp r0,1h
	beq @@UpDownMove
	cmp r0,2h
	beq @@LeftRightMove
	cmp r0,3h
	bne @@end
	;==================绕圈运动系列
    mov r1,40h               ;首先在下面
	strb r1,[r5,0Eh]         ;圆最下
	ldrb r0,[r5,15h]
	cmp r0,1h
	beq @@end
	bl FireFleasAvoidOverlapSettings
	b @@end
@@UpDownMove:
    mov r1,5Ah
	b @@Write
@@LeftRightMove:
    mov r1,5Ah	
@@Write:	
    strb r1,[r5,0Eh]         ;移动帧数
@@end:
	pop r0
    bx r0
.pool	

FireFleasAvoidOverlapSettings:
	add sp,-0Ch
	ldrb r7,[r5,3h]          ;当前精灵的主精灵序号
	ldrh r6,[r4,12h]         ;当前精灵的旋转半径
	ldrh r0,[r4,6h]          ;当前精灵的原Y坐标
	str r0,[sp,8h]
	ldrh r0,[r4,8h]          ;当前精灵的原X坐标
	str r0,[sp]
	ldrb r0,[r5,0Dh]         ;读取速度值
	str r0,[sp,4h]
	ldr r2,=SpriteData
@@Loop:	
	mov r3,r2
	add r3,20h
	ldrb r0,[r3,3h]
	cmp r0,r7
	beq @@NextSpriteData
	ldrb r0,[r2,1Dh]         ;检查ID是否一样
	cmp r0,FireFleasID
	bne @@NextSpriteData
	ldrb r0,[r2]
	mov r1,1h
	and r0,r1                ;检查是否活着
	cmp r0,0h
	beq @@NextSpriteData
	ldrb r0,[r3,0Fh]
	cmp r0,3h                ;检查备份的Pose值是否一样
	bne @@NextSpriteData
	ldrh r0,[r2,6h]
	ldr r1,[sp,8h]
	cmp r0,r1
	bne @@NextSpriteData
	ldrh r0,[r2,8h]
	ldr r1,[sp]
	cmp r0,r1
	bne @@NextSpriteData
	ldrh r0,[r2,12h]         ;读取旋转半径
	cmp r0,r6
	bne @@NextSpriteData
	ldrh r0,[r4]
	mov r1,40h
	and r0,r1
	cmp r0,0h
	bne @@RightFace
	ldr r1,=0FFBFh
	ldrh r0,[r2]
	and r0,r1
	strh r0,[r2]
	b @@Peer
	.pool
@@RightFace:
	ldrh r0,[r2]
	orr r1,r0
	strh r1,[r2]
@@Peer:
	ldr r0,[sp,4h]
	add r0,1
	str r0,[sp,4h]
	ldrb r1,[r3,0Dh]   
	strb r0,[r3,0Dh]         ;增加后的速度值
	sub r0,r1
	strb r0,[r3,16h]          ;速度增加值
	mov r1,2h
	mul r0,r1
	strb r0,[r3,0Ah]         ;临时加速值的运行帧数
	mov r0,1h
	strb r0,[r5,15h]         ;标记已经检查过
	strb r0,[r3,15h]
@@NextSpriteData:
	add r2,38h
	ldr r1,=SpriteDataEnd
	cmp r2,r1
	bcc @@Loop
    add sp,0Ch
	bx lr
.pool 

.close