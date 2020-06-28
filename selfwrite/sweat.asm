.gba
.open "sweat.gba","sweat1.gba",0x8000000

.definelabel CheckAnimation,800FBC8h
.definelabel CheckBlock2,800F47Ch
.definelabel PlaySound,8002A18h
.definelabel DropingSpeed,82B0D04h
.definelabel SamusData,0x30013D4
.definelabel CurrentArea,3000054h
.definelabel SpriteRNG,300083Ch
.definelabel SweatBombOAM,833BCA4h
.definelabel SweatDrawOAM,833BC54h
.definelabel SweatDropOAM,833BC94h

;水滴带伤害
.org SpriteAiStart +( SweatID * 4 )       ;改写ai的地址
    .word SweatMain + 1
	
.org 8304054h
	
;主程序
SweatMain:
    push r4-r7,lr
	ldr r4,=3000738h
	mov r5,r4
	add r5,20h
	ldrb r0,[r5,4h]
	cmp r0,0h
	beq SweatPose0BL
	cmp r0,8h
	beq SweatPose8BL
	cmp r0,9h
	beq SweatPose9BL
	cmp r0,0Eh
	beq SweatPoseEBL
	cmp r0,11h
	beq SweatPose11BL
	cmp r0,1Fh
	beq SweatPose1FBL
	mov r0,0h
	strh r0,[r4]            ;所有SweatPose都不是则消灭精灵
	b @end
.pool	
SweatPose0BL:
    bl SweatPose0
SweatPose8BL:
    bl SweatPose8	
SweatPose9BL:
    bl SweatPose9
	b @end
SweatPoseEBL:
    bl SweatPoseE
	b @end
SweatPose11BL:
    bl SweatPose11
    b @end
SweatPose1FBL:
    bl SweatPose1F
@end:
    pop r4-r7
    pop r15		
.pool

SweatPose0:
    mov r3,0h
	mov r2,4h
    ldr r1,=0FFFCh
	strh r1,[r4,0Ah]
	strh r2,[r4,0Ch]
	strh r1,[r4,0Eh]
	strh r2,[r4,10h]        ;四面分界
	ldr r1,=CurrentArea
    ldrb r0,[r1]
    cmp r0,0h
    bne @@Pass
	ldrb r0,[r1,1h]
	cmp r0,0h
	bne @@Pass
	mov r0,0h
	b @@Write
.pool	
@@Pass:	
	mov r0,1h
@@Write:
	strb r0,[r5]	        ;调色板
    mov r0,1h          
    strb r0,[r5,2h]         ;75A写入1
    ldrh r0,[r4,2h]
	sub r0,40h              ;Y坐标向上提升一格
	strh r0,[r4,2h]
    mov r0,8h
    strb r0,[r5,7h]         ;视界各8h
	strb r0,[r5,8h]
	strb r0,[r5,9h]
	ldrh r0,[r4,2h]
	strh r0,[r4,6h]          
	ldrh r0,[r4,4h]
	strh r0,[r4,8h]         ;备份坐标
	mov r0,8h               ;SweatPose写入8
	strb r0,[r5,4h]
    bx r14
.pool

SweatPose8:
    ldrb r0,[r5]
	cmp r0,0h
	beq @@Water
	mov r0,9h
	b @@Write
@@Water:	
    mov r0,0h
@@Write:
    strb r0,[r5,5h]	        ;写入属性
    ldr r1,=SpriteRNG
	ldrb r1,[r1]
    lsr r0,r1,1	
	cmp r0,0h
	bne @@WriteTimes
	mov r0,1h
@@WriteTimes:	
    strb r0,[r5,0Ch]        ;764写入计时
	mov r0,9h
	strb r0,[r5,4h]
	bx r14
.pool
	
SweatPose9:                 ;产生水滴
    ldrb r0,[r5,0Ch]
    sub r0,1h
    strb r0,[r5,0Ch]    
    lsl r0,18h
	lsr r0,18h
	cmp r0,0h               ;764不为0则结束
	bne @@end
	ldr r1,=SweatDrawOAM
	str r1,[r4,18h]         ;产生水滴的OAM
	mov r0,0h
	strh r0,[r4,16h]
    strb r0,[r4,1Ch]
    mov r0,0Eh
	strb r0,[r5,4h]         ;SweatPose写入0Eh
	ldrh r0,[r4]
	ldr r1,=0FFFBh
	and r0,r1
	strh r0,[r4]            ;去掉取向的4h
@@end:
    bx r14
.pool

SweatPoseE:                      ;将要下落的
    push lr
	bl CheckAnimation
    cmp r0,0h
	beq @@end
	ldr r0,=SweatDropOAM
	str r0,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
	strb r0,[r5,6h]         ;不再待机
	mov r0,11h
	strb r0,[r5,4h]         ;SweatPose写入11
@@end:
    pop r15
.pool

SweatPose11:	                    ;下落中
    Push lr
	bl CheckCollisionNoUseSP
	cmp r0,0h
	bne @@CollisionFlag
	ldrh r0,[r4,2h]
	ldrh r1,[r4,4h]
	bl CheckBlock2
	mov r6,r0
	ldr r0,=30000DCh
	ldrh r1,[r0,2h]
	cmp r1,0h               ;检查精灵是否在空气中
	beq @@NoInWater         ;略过此项,水滴瞬间落水中
	cmp r1,6h
	bcs @@NoInWater         ;检查是否不在液体中
	ldr r0,=300006Ch
	ldrh r0,[r0]            ;读取空气高度
	cmp r0,0h
	beq @@NoEffect
	strh r0,[r4,2h]         ;空气高度写入Y坐标
	b @@Peer
.pool	
@@NoEffect:
    strh r6,[r4,2h]         ;写入砖块高度 
    b @@Peer
@@NoInWater:
    ldr r0,=30007F0h
    ldrb r0,[r0]
	cmp r0,0h
	beq @@NoFloor
	strh r6,[r4,2h]    	    ;有砖则直接写入砖块高度
	b @@Peer
.pool	
@@CollisionFlag:
    mov r0,1h
    mov r1,r4
    add r1,20h
    strb r0,[r1,0Eh]        ;标记了滴在samus身上	
@@Peer:
    mov r5,r4
	add r5,20h
	mov r1,1Fh              ;SweatPose写入1Fh
	strb r1,[r5,4h]
	ldr r0,=SweatBombOAM    ;写入落地的OAM
	str r0,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r1,[r4,1Ch]          ;归零
	mov r0,0FFh
	strb r0,[r5,6h]           ;待机
	ldrh r0,[r4]
	mov r1,2h
	and r0,r1
	cmp r0,0h
	beq @@end
	ldrb r0,[r5,5h]
	cmp r0,9h
	bne @@end
	mov r0,7Dh
	bl PlaySound  
    b @@end	
.pool	
@@NoFloor:
    mov r5,r4
	add r5,20h
	ldrb r3,[r5,0Fh]        ;读取767的值
	ldr r2,=DropingSpeed
	lsl r0,r3,1             ;767的值乘以2
	add r0,r2
	mov r1,0h
	ldsh r2,[r0,r1]
	ldr r1,=7FFFh
	cmp r1,r2
	bne @@DropSpeedNoMax
	sub r0,r3,1
	lsl r0,1
	add r0,r2
    mov r1,0h
    ldsh r0,[r0,r1]
	ldrh r1,[r4,2h]
	add r0,r1,r0
	strh r0,[r4,2h]
	b @@end
.pool
@@DropSpeedNoMax:
    add r0,r3,1h
    strb r0,[r5,0Fh]
    ldrh r0,[r4,2h]
	add r0,r2
	strh r0,[r4,2h]
@@end:
    pop r15
.pool

SweatPose1F:
    push r6,lr
	ldrb r0,[r5,0Eh]
	cmp r0,0h                         ;检查水滴在身上的flag
	beq @@Pass
    ldr r1,=SamusData
	ldrh r0,[r1,12h]                  ;读取samus当前的坐标
	ldr r1,=3001600h                  ;SamusXYCopy
    ldrh r6,[r1]                      ;读取samus之前的坐标
    cmp r0,r6
    beq @@Pass
    bhi @@RightMove
    sub r0,r6,r0
    ldrh r1,[r4,4h]                   ;读取精灵的X坐标
    sub r1,r1,r0
    strh r1,[r4,4h]
    b @@Pass
.pool
@@RightMove:
    sub r0,r0,r6
    ldrh r1,[r4,4h]
    add r1,r1,r0
    strh r1,[r4,4h]	
@@Pass:	
	bl CheckAnimation            ;检查动画
	cmp r0,0h
	beq @@end 
	mov r1,4
	ldrh r0,[r4]
	orr r0,r1
	strh r0,[r4]
	ldrh r0,[r4,6h]
	strh r0,[r4,2h]                   
    ldrh r0,[r4,8h]
    strh r0,[r4,4h]                   ;坐标归位	
	mov r0,8h
	strb r0,[r5,4h]                   ;pose写入8
	mov r0,0h
	strh r0,[r5,0Eh]         	
@@end:
    pop r6
    pop r15	
.pool
	
;自造例程	      	
CheckCollisionNoUseSP:
    push r4-r7,lr
    mov r0,r8
    mov r1,r9
    push r0,r1
    ldr r1,=30013D4h
	ldrh r2,[r1,14h]                  ;人物Y坐标
	ldrh r3,[r1,12h]                  ;人物X坐标
	ldr r5,=30015F0h
	mov r1,8h
	ldsh r0,[r5,r1]                   ;读取人物上部分界
	add r0,r2                         ;加上Y坐标
	mov r8,r0
	mov r1,0Ch                        
	ldsh r0,[r5,r1]                   ;读取人物下部分界
	add r0,r2                         ;加上Y坐标
	mov r9,r0                          
	mov r1,6h
	ldsh r0,[r5,r1]                   ;读取人物左部分界
	add r0,r3                         ;加上X坐标
	mov r6,r0
	mov r1,0Ah
	ldsh r0,[r5,r1]                   ;读取人物右部分界
	add r0,r3                         ;加上X坐标
    mov r7,r0
    ldsh r0,[r4,r1]                   ;读取精灵上部分界
    ldrh r2,[r4,2h]                   ;读取精灵Y坐标
	add r0,r2                         ;两者相加值给R0
	mov r5,0Ch
	ldsh r1,[r4,r5]                   ;读取精灵下部分界
	add r1,r2                         ;和Y坐标相加值给R1
	mov r5,0Eh
	ldsh r2,[r4,r5]                   ;读取精灵左部分界
	ldrh r3,[r4,4h]                   ;读取精灵X坐标
	add r2,r3                         ;两者相加只给R2
	mov r5,10h
	ldsh r5,[r4,r5]                   ;读取精灵右部分界
	add r3,r5                         ;和X坐标相加值给R3
	mov r4,r8
	mov r5,r9
	lsl r0,10h                        ;人极上
	lsl r1,10h                        ;人极下
	lsl r2,10h                        ;人极左 
	lsl r3,10h                        ;人极右
	lsl r4,10h                        ;精极上
    lsl r5,10h                        ;精极下
	lsl r6,10h                        ;精极左
	lsl r7,10h                        ;精极右
	cmp r1,r4                         ;人极下比精极上
	bcc @@ReturnZero                  ;仍在上返回0
    cmp r0,r5                         ;人极上比精极下
    bcs @@ReturnZero                  ;仍在下返回0
    cmp r3,r6                         ;人极右比精极左
    bcc @@ReturnZero                  ;仍在左返回0
    cmp r2,r7                         ;人极左比精极右
    bcs @@ReturnZero                  ;仍在右返回0
	mov r0,1h
	b @@end
@@ReturnZero:
    mov r0,0h
@@end:
    pop r1,r2
    mov r8,r1
    mov r9,r2
    pop r4-r7
    pop r15	
.pool

.align    	
ProduceSweat:
    .word 833b37eh     ;水滴产生1
	.word 4 
	.word 833b386h     ;水滴产生2
	.word 4
	.word 833b38eh     ;水滴产生3
	.word 4
	.word 833b396h     ;水滴将落
	.word 4
	.word 00000000h
	.word 00000000h
	
.align
SweatBursting:
    .word 833b3a6h
	.word 4
	.word 833b3b4h
	.word 4
	.word 833b3c2h
	.word 4
	.word 833b3d0h
	.word 4
	.word 833b3deh
	.word 4
	.word 00000000h
	.word 00000000h
   

.pool
.close
