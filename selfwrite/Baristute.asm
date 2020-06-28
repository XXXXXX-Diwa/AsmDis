.gba
.open "zm.gba","Baristute.gba",0x8000000

.definelabel CurrSprite,0x3000738
.definelabel CheckEndSpriteAnimation,0x800FBC8
.definelabel BaristuteFallOnFloorOAMAdd4,83104A0h
.definelabel BaristuteJumpOAMAdd4,8310468h
.definelabel ReRooMusic,80039F4h
.definelabel CheckRange,800FDE0h
.definelabel DirectionTag,800F8E0h
.definelabel CheckAnimation,800FBC8h
.definelabel CheckAnimation2,800FC00h
.definelabel CheckEvent,80608bch
.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel MainSpriteDateStart,82b0d68h
.definelabel RandomDirection,800F80Ch
.definelabel CheckBlock3,800F720h
.definelabel XShake,8055378h
.definelabel YShake,8055344h
.definelabel FallDateStart,830f53ch
.definelabel JumpDateStart,830f54ch
.definelabel CheckBlock2,800F47Ch
.definelabel CheckBlock,800F688h
.definelabel DoorUnlockTimer,300007Bh
.definelabel CurrSprite,3000738h
.definelabel NormalOAM,831043ch
.definelabel SlowRunOAM,831052Ch
.definelabel FastRunOAM,8310564h
.definelabel PrepareJumpOAM,8310464h
.definelabel InAirOAM,8310484h
.definelabel BaristuteFallOnFloorOAM,831049Ch
.definelabel SpriteRNG,300083Ch
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel BaristuteID,6Ch
.definelabel DeathFireWorks,8011084h
.definelabel StopRoomMusic,8003A98h
.definelabel SpriteDrop,800E3D4h
.definelabel GfxEffect,80540ECh
.definelabel SpawnNewPrimarySprite,800E31Ch
.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0



.org 0x8760D38             ;freedata
.align
BaristuteGfx:
     .import "Baristute.gfx.lz"
	 
.align
BaristutePal:
     .import "Baristute.palette"
	 
.org SpriteAiStart + ( BaristuteID * 4 )       ;改写ai的地址
    .word BaristuteMain + 1
	
.org SpriteGfxPointers + (BaristuteID - 10h ) * 4 
    .word BaristuteGfx

.org SpritePalPointers + (BaristuteID - 10h ) * 4 
    .word BaristutePal 	

.org 0x8304054	            ;鳄鱼图
BaristuteMain:        
    push r4-r7,lr           ;主程序
	ldr r4,=CurrSprite
	mov r2,2h
	mov r5,r4
	add r5,20h
	ldrb r0,[r5]
	cmp r0,0Eh
	beq @@Pass
	ldrb r0,[r5,4h]
	cmp r0,1h
	beq @@Pass
	ldrb r0,[r4,6h]
	strb r0,[r5]
@@Pass:	
	ldrb r0,[r5,12h]
	and r0,r2
	cmp r0,0h
	beq @@NohitOrOver 
    ldrb r0,[r5,12h]	
	mov r1,0FDh
	and r0,r1               ;去掉碰撞属性2
	strb r0,[r5,12h]        
	ldrb r0,[r4]            ;检查是否在屏幕内
	and r0,r2
	cmp r0,0h
	beq @@NohitOrOver
	ldr r0,=259h
	bl PlaySound2
@@NohitOrOver:	
    mov r1,r4
	add r1,24h
	ldrb r0,[r1]            ;检查pose
	cmp r0,27h
	bhi DeathPoseBL
	lsl r0,2h
	ldr r1,=PoseTable
	add r0,r1
	ldr r0,[r0]
	mov r15,r0
.pool	
PoseTable:
    .word PoseZeroBL
	.word PoseSleepBL
	.word PoseAwakeBL
	.word PoseCommonBL
	.word PoseCheckBL
	.word PoseMoveBL
	.word ChangeColorPoseBL
	.word PoseCheckActBL
	.word PoseJumpStartBL
	.word PoseFallBL
	.word PoseJumpBL
	.word PoseFallOnFloorBL
PoseZeroBL:
    bl PoseZero
    b @end
PoseSleepBL:
    bl PoseSleep
    b @end
PoseAwakeBL:
    bl PoseAwake
    b @end
PoseCommonBL:
    bl PoseCommon
    b @end
PoseCheckBL:
    bl PoseCheck
    b @end
PoseMoveBL:
    bl PoseMove
    b @end
ChangeColorPoseBL:
    bl ChangeColorPose
    b @end
PoseCheckActBL:
    bl PoseCheckAct
    b @end
PoseJumpStartBL:
    bl PoseJumpStart
    b @end
PoseFallBL:
    bl PoseFall
    b @end
PoseJumpBL:
    bl PoseJump
    b @end
PoseFallOnFloorBL:
    bl PoseFallOnFloor
    b @end
DeathPoseBL:
    bl DeathPose
@end:	
	pop r4-r7
	pop r15
.pool	

//////////////////////////////////////////////////////////////////////////////////////////////////////////	     
PoseZero:                          
    push lr 
	mov r0,3h
	mov r1,29h
	bl CheckEvent             ;检查事件1eh
	cmp r0,0h
	beq @@NoActivation
	mov r0,0h
	strh r0,[r4]              ;事件已经激活则敌人消失
	b @@end
@@NoActivation:
    ldr r2,=DoorUnlockTimer
	mov r0,1h
	mov r3,0h
	strb r0,[r2]              ;门关闭flag
    mov r1,r4
	add r1,20h
    ldr r0,=BaristuteSleepOAM          ;写入睡眠的OAM
	str r0,[r4,18h]
	strh r3,[r4,16h]
	strb r3,[r4,1Ch]
	mov r0,1h
	strb r0,[r1,4h]           ;pose写入1h
	mov r0,4h
	strb r0,[r1,5h]           ;属性写入4h
	mov r0,30h
	strb r0,[r1,7h]           ;300075f写入30h
	mov r0,8h
	strb r0,[r1,8h]           ;3000760写入0h
	mov r0,28h                ;3000761写入28h
	strb r0,[r1,9h]
	mov r0,40h
	ldrb r2,[r1,12h]
	orr r0,r2
	strb r0,[r1,12h]          ;碰撞属性写入无敌
	mov r0,1h                 ;调色写入蓝色
	strb r0,[r1]
;	strb r0,[r4,6h]        
	ldr r0,=0FF88h
	strh r0,[r4,0Ah]
	strh r3,[r4,0Ch]
	add r0,24h
	strh r0,[r4,0Eh]
	mov r0,54h
	strh r0,[r4,10h]
	ldr r0,=MainSpriteDateStart
	ldrb r2,[r4,1Dh]
	lsl r1,r2,3h
	add r1,r2
	lsl r1,1h
	add r0,r1
	ldrh r0,[r0]
	strh r0,[r4,14h]         ;写入血量	
@@end:
    pop r15	
.pool

///////////////////////////////////////////////////////////////////////////////
PoseSleep:                   ;pose1    ;沉睡
    push lr
	mov r5,r4
	mov r6,0h
	strb r6,[r4,6h]
	add r5,20h
	mov r0,0C0h
	lsl r0,1h
	mov r1,r0
	bl CheckRange           ;检查是否在六格内
	cmp r0,0h
	beq @@end
	ldrb r0,[r5]
	cmp r0,0h
	bne @@end
	mov r0,2h
	strb r0,[r5,4h]            ;pose写入2 醒来
	ldr r2,=SleepToAwakeOAM
	str r2,[r4,18h]
	strh r6,[r4,16h]
	strb r6,[r4,1Ch]
	mov r0,0h
	mov r1,0h
	bl ReRooMusic             ;音乐停止
@@end:	
	pop r15
.pool


///////////////////////////////////////////////////////////////////////////////////////////////
PoseAwake:                  ;pose 2h  醒来
    push lr
	ldrh r0,[r4,16h]
	cmp r0,2h
	bne @@Pass
    ldrb r0,[r4,1Ch]
	cmp r0,14h
	bne @@Pass
	mov r0,4Bh
	mov r1,0h
	bl ReRooMusic 	         ;音乐改变为克雷德boss音乐	
@@Pass:	
    bl CheckAnimation2
	cmp r0,0h
	beq @@end
	mov r5,r4
	add r5,24h
	mov r0,3h
	strb r0,[r5]             ;写入pose3 归零pose
@@end:
    pop r15


/////////////////////////////////////////////////////////////////////////////////////////////////	
PoseCommon:                 ;正常状态的pose3
    push lr
    mov r3,0h
	mov r5,r4
	add r5,20h
    strb r3,[r5,6h]         ;300075e计数器清零 
	strb r3,[r5,0Ah]        ;3000762计数器清零
    strb r3,[r4,12h]	    ;300074A计数器清零
	strb r3,[r5,0Eh]        ;3000766计数器清零
	strb r3,[r5,0Fh]        ;3000767计数器清零
	ldr r2,=NormalOAM       ;写入正常的OAM
	str r2,[r4,18h]
	strh r3,[r4,16h]
	strb r3,[r4,1Ch]
	mov r0,4h
	strb r0,[r5,5h]         ;属性普通
	strb r0,[r5,4h]         ;pose写入4h
	ldrb r0,[r5,12h]
	mov r1,0BFh
	and r0,r1
	strb r0,[r5,12h]        ;去除无敌
@@end:	
    pop r15
.pool	
    	
////////////////////////////////////////////////////////////////////////////////////////////////////    	 
PoseCheck:                   ;检查是否给予变色pose 4
    push lr
    mov r5,r4
	add r5,20h
	ldrb r0,[r4]
	mov r2,2h
	and r0,r2
	cmp r0,0h                
	bne @@ChangeColorPose  	;在屏幕内就写入变色pose
	ldrb r1,[r5,0Ch]          ;3000764的值
	cmp r1,3Ch             
	beq @@Activation          ;累计达到3C则暴走
	add r1,1h
	strb r1,[r5,0Ch] 	     ;累积值加1
	cmp r1,13h
	beq @@PlaySound
	cmp r1,27h
	beq @@PlaySound
	cmp r1,3Ch
	bne @@end
@@PlaySound:
	ldr r0,=147h
	bl PlaySound
	b @@end	
@@Activation:	
    bl OutBreak
	b @@end
@@ChangeColorPose:	
	mov r0,6h                ;在范围的话,pose写入6  变色
	strb r0,[r5,4h]
	bl RandomMoveOrJumpCall  ;设置变色行动数值
@@end:
    pop r15	
.pool	

/////////////////////////////////////////////////////////////////////////////////////////////////////////	
PoseMove:                  ;pose 5
    push lr
    mov r5,r4
	mov r3,0h
	add r5,20h
	ldrb r0,[r4,12h]
	cmp r0,0h
	bne @@FastSpeed
    ldrb r0,[r5,0Ah]        ;读取3000762的值
    mov r1,1h
    and r0,r1
    cmp r0,0h
	bne @@FastSpeed
	mov r0,0Ah
	b @@Peer
@@FastSpeed:
    mov r0,14h
@@Peer:	
    strb r0,[r5,0Eh]	  ;3000766写入奔跑值
	mov r1,80h
	lsl r1,2h             ;200h
	ldrh r0,[r4]          ;检查位置
	and r0,r1
	cmp r0,0h
	beq @@LeftMove        ;在右边向左移动
	ldrh r6,[r4,2h]       ;向右移动
	ldrh r7,[r4,4h]       ;读取坐标         
	mov r0,r6
	sub r0,3Ch            ;水平向上3Ch
    mov r2,10h
	ldsh r1,[r4,r2]       ;读取右部边界
	add r1,r7
    add r1,4h            ;加上X坐标再加4h
    bl CheckBlock3	      ;检查是否有墙
    cmp r0,0h
    beq @@NoRightWall
	ldrb r0,[r5,0Eh]
	sub r7,r0             ;因为右边有墙
	strh r7,[r4,4h]       ;减去速度值再写入X坐标
    bl OutBreakNumSubCall
    b @@end
@@NoRightWall:
    mov r0,r6
    mov r2,10h
	ldsh r1,[r4,r2]       ;右部分界
	add r1,r7
	add r1,4h             ;加X坐标再加4h
	bl CheckBlock3
	cmp r0,11h
	bne @@NoRightFloor
	ldrb r0,[r5,0Eh]      ;读取速度设定值
	add r0,r7             ;加上
	strh r0,[r4,4h]       ;写入新坐标
	ldrb r1,[r4,12h]      ;检查暴走来回值是否为0
	cmp r1,0h
	bne @@Pass            ;不为0跳过 因为是暴走不算距离
	ldrh r1,[r4,8h]       ;读取备份的坐标
	sub r0,r1             ;当前坐标减备份坐标
	ldrb r2,[r5,0Eh]      ;读取速度值
	mov r1,26h            ;和26相乘
	mul r1,r2             ;得出奔跑距离
	cmp r0,r1            
	bhi @@LenghOver
	b @@Pass
@@NoRightFloor:           ;这里也要有判断暴走值的设定????
    ldrb r0,[r5,0Eh]
    sub r7,r0
    strh r7,[r4,4h]
    b @@Pass
@@LeftMove:
    ldrh r6,[r4,2h]
	ldrh r7,[r4,4h]       ;读取坐标         
	mov r0,r6
	sub r0,3Ch            ;水平向上10h
    mov r2,0Eh
	ldsh r1,[r4,r2]       ;读取左部边界
	add r1,r7
    sub r1,4h             ;减去X坐标再减4h
    bl CheckBlock3	      ;检查是否有墙
    cmp r0,0h
    beq @@NoLeftWall
    ldrb r0,[r5,0Eh]       ;读取速度值
	add r7,r0              ;因为左有墙
	strh r7,[r4,4h]        ;加上速度值再写入
	bl OutBreakNumSubCall
    b @@end
@@NoLeftWall:
    mov r0,r6
    mov r2,0Eh
	ldsh r1,[r4,r2]       ;左部分界
	add r1,r7
	sub r1,4h             ;X坐标再减4h
	bl CheckBlock3
	cmp r0,11h
	bne @@NoLeftFloor
	ldrb r0,[r5,0Eh]      ;读取速度设定值
	sub r0,r7,r0             
	strh r0,[r4,4h]       ;向左偏移再写入
	ldrb r1,[r4,12h]      ;检查暴走来回值是否为0
	cmp r1,0h
	bne @@Pass           ;不为0结束
	ldrh r1,[r4,8h]       ;备份的坐标
	sub r1,r0             ;备份坐标减当前坐标
    ldrb r0,[r5,0Eh]      ;得到速度值
	mov r2,26h
	mul r0,r2             
	cmp r1,r0
	bhi @@LenghOver
	b @@Pass
@@NoLeftFloor:
    ldrb r0,[r5,0Eh]      ;左边没有地板了
    add r0,r7             
    strh r0,[r4,4h]
@@LenghOver:
    mov r0,3h
    strb r0,[r5,4h]       ;pose写入3 归零pose
@@Pass:   	
	mov r0,96h
	lsl r0,2h
	bl PlaySound2
@@end:
    pop r15	
.pool	

/////////////////////////////////////////////////////////////////////////////////////////    	
ChangeColorPose:            ;pose 6 改变颜色
    push lr
    mov r5,r4
	mov r3,0h
    add r5,20h
	ldrb r0,[r5,0Ch]         ;3000764h
	cmp r0,3Ch
	bhi @@PoseGo            ;计时超过3Ch则写入新Pose
    cmp r0,1Fh
	beq @@SpeedCheckRedOrGreen
	cmp r0,0h
	bhi @@AddTime
	ldrb r1,[r5,0Ah]         ;读取3000762的值
	mov r0,2h
	and r0,r1
	cmp r0,0h
	beq @@JumpYellow
	mov r0,1h	    ;写入蓝色
	b @@ChangColorSoundPeer
@@JumpYellow:
    mov r0,2h       ;写入黄色
    b @@ChangColorSoundPeer
@@SpeedCheckRedOrGreen:
    ldrb r1,[r5,0Ah]
    mov r0,1h
	and r0,r1
	cmp r0,0h
	beq @@SpeedSlowGreen
	mov r0,3h      ;写入红色  
	b @@ChangColorSoundPeer
@@SpeedSlowGreen:
    mov r0,0h      ;写入绿色
@@ChangColorSoundPeer:
    strb r0,[r5]    
	strb r0,[r4,6h]
    mov r0,0A3h
	lsl r0,1h
	bl PlaySound	
@@AddTime:
    ldrb r0,[r5,0Ch]
    add r0,1h
    strb r0,[r5,0Ch]
	b @@end
@@PoseGo:
    mov r0,7h
    strb r0,[r5,4h]      ;pose写入7,分配行动
	mov r0,0h
	strb r0,[r5,0Ch]     ;3000764计时归0
@@end:
    pop r15	
.pool


//////////////////////////////////////////////////////////////////////////////////////
PoseCheckAct:         ;pose 7
    push lr
    mov r5,r4         ;r4=3000738h
	add r5,20h
	mov r0,0A0h
	lsl r0,2h         ;10格距离检查
	mov r1,r0
	bl CheckRange
    cmp r0,0h
    bne @@NoOutBreak
	bl OutBreak
	ldr r0,=147h
	bl PlaySound
	b @@end
@@NoOutBreak:	
	ldrb r1,[r5,0Ah]   ;读取3000762的值
	mov r0,1h
	and r0,r1
	cmp r0,0h
    beq @@SlowSpeed	  
    mov r0,2h
    and r0,r1
    cmp r0,0h
    beq @@JumpOAM
@@FastRun:	
	ldr r2,=FastRunOAM   ;快速跑的OAM
	mov r0,5h            ;pose变5 跑
	b @@RespawnX
@@SlowSpeed:             ;弱形态
    mov r0,2h
    and r0,r1
    cmp r0,0h
    beq @@JumpOAM
    ldr r2,=SlowRunOAM   ;慢速跑的OAM
    mov r0,5h	         ;pose 变5 跑
@@RespawnX:
    ldrh r1,[r4,4h]
    strh r1,[r4,8h]	      ;备份X坐标
	b @@Peer
@@JumpOAM: 
 	mov r2,2h
	ldrb r0,[r4]
	and r0,r2
	cmp r0,0h
	beq @@JumpNoSound    
    mov r0,0C6h
	lsl r0,1h
	bl PlaySound2             ;播放预备起跳声音
@@JumpNoSound:	
	ldr r2,=PrepareJumpOAM   ;预备跳跃的OAM
	mov r0,8h                ;pose 变8 起跳
@@Peer:	
	str r2,[r4,18h]
	mov r3,0h
    strh r3,[r4,16h]
    strb r3,[r4,1Ch]
	strb r0,[r5,4h]            ;pose
	mov r0,0Dh
	strb r0,[r5,5h]          ;属性写入大反弹
	bl DirectionTag         ;标记方向	
@@end:	
    pop r15	
.pool    	

////////////////////////////////////////////////////////////////////////////////////////
PoseJumpStart:                ;pose 8h
     push r4-r6,lr
	 mov r5,r4           ;r4=3000738h
	 add r5,20h	 
	 ldrh r7,[r4,4h]     ;X坐标
	 mov r2,10h
	 ldsh r1,[r4,r2]     ;右部分界
	 add r1,r7,r1
	 ldrh r0,[r4,2h]
	 bl CheckBlock3
	 cmp r0,0h
	 bne @@Peer	 
	 mov r2,0Eh
	 ldsh r1,[r4,r2]
	 add r1,r7,r1
	 ldrh r0,[r4,2h]
	 bl CheckBlock3
	 cmp r0,0h
	 bne @@Peer
@@NoFloor:
     ldr r2,=InAirOAM
	 str r2,[r4,18h]
     mov r0,9h
     strb r0,[r5,4h]            ;pose写入9h
     b @@Peer2
@@Peer:
     bl CheckAnimation2       ;CheckAnimation OAM 8310464h
     cmp r0,0h
     beq @@end
	 mov r0,0Ah
	 strb r0,[r5,4h]            ;pose写入0Ah
	 mov r0,0Dh
	 strb r0,[r5,5h]         ;属性写入大反弹
	 ldr r2,=InAirOAM        
	 str r2,[r4,18h]
	 mov r1,2h
	 ldrb r0,[r4]
	 and r0,r1
	 cmp r0,0h
	 beq @@Peer2
	 ldr r0,=18Dh
	 bl PlaySound2            ;起跳声音
@@Peer2:
     mov r0,0h
	 strh r0,[r4,16h]
	 strb r0,[r4,1Ch]
	 strb r0,[r5,0Fh]        ;3000767归0用于当做跳跃数据计	 
@@end:
     pop r4-r6
     pop r0
  	 bx r0 
.pool
      	 
///////////////////////////////////////////////////////////////////
PoseFall:                     ;pose 9	下坠 
	 push lr
	 ldr r4,=3000738h
	 mov r5,r4
	 add r5,20h
	 ldrh r1,[r4,4h]
	 ldrh r0,[r4,2h]          ;坐标
	 bl CheckBlock2
	 mov r1,r0
	 ldr r2,=XTagRAM
	 ldrb r0,[r2]
	 cmp r0,0h
	 bne @@OnFloor
	 ldrb r6,[r5,0Fh]         ;3000767的值
	 lsl r0,r6,1h
	 ldr r3,=FallDateStart
	 mov r2,r3
	 add r2,r0
	 mov r1,0h
	 ldsh r0,[r2,r1]
	 ldr r2,=7FFFh
	 cmp r0,r2
	 bne @@NoEqual
	 sub r6,1h
	 lsl r0,r6,1h
	 add r3,r0
	 ldsh r0,[r3,r1]
	 ldrh r1,[r4,2h]
	 add r1,r0
	 strh r1,[r4,2h]
	 b @@end
@@NoEqual:
     add r6,1h
	 strb r6,[r5,0Fh]
	 ldrh r1,[r4,2h]
	 add r1,r0
	 strh r1,[r4,2h]
	 b @@end
@@OnFloor:
     strh r1,[r4,2h]
	 ldr r2,=BaristuteFallOnFloorOAM
	 str r2,[r4,18h]
	 mov r0,0h
	 strh r0,[r4,16h]
	 strb r0,[r4,1Ch]
;	 mov r1,2h
;;	 ldrb r0,[r4]
;	 and r0,r1
;	 cmp r0,0h
;	 beq @@NoSoundOrShake
	 mov r0,0Ah
	 mov r1,81h
	 bl YShake             ;上下震动的屏幕
	 mov r0,0C7h
	 lsl r0,1h
	 bl PlaySound2
;@@NoSoundOrShake:	 
	 mov r0,0Bh
	 strb r0,[r5,4h]          ;pose写入0Bh	 
@@end:
     pop r15	 
.pool                     

////////////////////////////////////////////////////////////////////
PoseJump:                 ;pose 0Ah     跳跃在空中	 
     push lr
	 mov r5,r4
	 add r5,20h
	 ldrb r0,[r4,12h]
	 cmp r0,0h
	 beq @@NoOutBreakJump
	 mov r0,1Eh
	 b @@Peer
@@NoOutBreakJump:	 
	 ldrb r0,[r5,0Ah]       ;3000762的随机数值
	 mov r1,1h
	 and r0,r1
	 cmp r0,0h
	 beq @@SlowMove
	 mov r0,14h
	 b @@Peer
@@SlowMove:
     mov r0,7h
@@Peer:
     strb r0,[r5,0Eh]      ;X速度写入3000766h	
;@@PassRandom:	 
	 ldr r2,=JumpDateStart
	 ldrb r0,[r5,0Fh]      ;3000767跳跃数据计
	 lsr r0,2h
	 lsl r0,1h             ;乘以2
	 add r0,r2,r0
	 mov r1,0h
	 ldsh r0,[r0,r1]          ;得到跳跃Y速度
	 strh r0,[r4,8h]          ;写入3000740h
;	 ldrh r6,[r4,2h]          ;Y坐标
;	 ldrh r7,[r4,4h]
	 mov r0,80h
	 lsl r0,2h
	 ldrh r2,[r4]
	 and r0,r2
	 cmp r0,0h
	 beq @@LeftJump
	 ldrh r0,[r4,2h]
     sub r0,10h             ;垂直坐标判定上升多少
	 mov r1,10h
	 ldsh r2,[r4,r1]        ;得到右部分界
	 ldrh r1,[r4,4h]
	 add r1,r2              ;加上X坐标
	 add r1,4h              ;再加4h
	 bl CheckBlock         ;检查砖块
	 ldr r2,=YTagRAM
	 ldrb r0,[r2]
	 cmp r0,11h
	 bne @@NoRightWall
	 ldrb r1,[r5,0Eh]       ;读取设定的速度值
	 ldrh r0,[r4,4h]
	 sub r0,r1
	 sub r0,4h
	 strb r0,[r4,4h]        ;减去X速度再减4写入
	 ldr r2,=0FDFFh
	 ldrh r0,[r4]
	 and r0,r2
	 strh r0,[r4]           ;取向去掉200h
	 b @@PoseFall
@@NoRightWall:
     ldrb r1,[r5,0Eh]       ;读取X速度
	 ldrh r0,[r4,4h]
	 add r0,r1
	 strh r0,[r4,4h]        ;写入新X坐标
	 b @@Peer2
@@LeftJump:
	 ldrh r0,[r4,2h]
     sub r0,10h          ;Y坐标向上10h
     mov r1,0Eh
     ldsh r2,[r4,r1]        ;读取左部分界
	 ldrh r1,[r4,4h]
	 add r1,r2           ;加X坐标再减8h
	 sub r1,4h
	 bl CheckBlock
     ldr r2,=YTagRAM
     ldrb r0,[r2]
     cmp r0,11h
     bne @@NoLeftWall
     ldrb r1,[r5,0Eh]       ;得到设定的速度值
	 add r1,4h
	 ldrh r0,[r4,4h]
     add r0,r1              ;加上X坐标
	 strh r0,[r4,4h]        ;重写入坐标
	 ldrh r0,[r4]
	 mov r1,80h
	 lsl r1,2h
	 orr r0,r1
	 strh r0,[r4]
	 b @@PoseFall
@@NoLeftWall:
     ldrb r1,[r5,0Eh]       ;读取空中X速度
	 ldrh r0,[r4,4h]
	 sub r0,r1
	 strh r0,[r4,4h]
@@Peer2:
     mov r1,8h	 
     ldsh r1,[r4,r1]        ;Y跳跃数据
	 ldrh r0,[r4,2h]
	 add r0,r1            ;Y坐标加上跳跃数据
	 strh r0,[r4,2h]        ;写入新坐标
     ldrb r0,[r5,0Fh]       ;读取3000767的计数
	 cmp r0,26h
	 bhi @@NoAdd
	 add r0,1h
	 strb r0,[r5,0Fh]
@@NoAdd: 
     ldsh r0,[r4,r1]        ;读取Y跳跃数据值
     cmp r0,0h              ;比较跳跃数据是否大于零
	 bgt @@Fall             ;有符号数大于
	 mov r1,0Ah
	 ldsh r1,[r4,r1]        ;读取上部分界
	 ldrh r0,[r4,2h]        ;读取当前Y坐标
	 add r0,r1
	 sub r0,28h             ;实验
	 ldrh r1,[r4,4h]
	 bl CheckBlock
	 ldr r2,=YTagRAM
	 ldrb r0,[r2]
	 cmp r0,11h
	 bne @@end              ;未碰天花板
	 b @@PoseFall           ;否则写入下落的pose
@@Fall:
     ldrh r0,[r4,2h]
	 ldrh r1,[r4,4h]
	 bl CheckBlock2
	 ldr r2,=XTagRAM
	 ldrb r1,[r2]
	 cmp r1,0h
	 beq @@end
	 strh r0,[r4,2h]        
	 ldr r2,=BaristuteFallOnFloorOAM       ;落地的OAM
	 str r2,[r4,18h]
	 mov r0,0h
	 strh r0,[r4,16h]
	 strb r0,[r4,1Ch]
;	 ldrb r0,[r4]
;	 mov r1,2h
;	 and r0,r1
;	 cmp r0,0h
;	 beq @@NoSoundOrShake
	 mov r0,0Ah
	 mov r1,81h
	 bl YShake
	 mov r0,0C7h
	 lsl r0,1h
	 bl PlaySound2          ;播放落地声音
;@@NoSoundOrShake:	 
     mov r0,0Bh             ;pose写入落地
     b @@PoseWrite	 
@@PoseFall:
     ldrb r0,[r4,12h]
	 cmp r0,0h
	 beq @@NoImpact
     mov r0,0F8h           ;撞击声
	 bl PlaySound2
	 mov r0,10h
	 mov r1,8h
	 bl XShake             ;屏幕晃动	
@@NoImpact:	 
     mov r0,0h
	 strb r0,[r5,0Fh]       ;3000767归零
     mov r0,9h              ;pose写入坠落 
@@PoseWrite:	 
	 strb r0,[r5,4h]           
@@end:	 
     pop r15  	 
.pool
     
///////////////////////////////////////////////////////////////////////////       	 

PoseFallOnFloor:          ;pose OBh	    跳跃落地
	 push lr
	 mov r5,r4
	 add r5,20h
	 ldrb r0,[r5]         
	 bl CheckAnimation2
	 cmp r0,0h
	 beq @@end
	 mov r0,3h
	 strb r0,[r5,4h]         ;pose写入归零pose
@@end: 
     pop r15	 	  	
//////////////////////////////////////////////////////////////////////////
DeathPose:                ;pose 0Ch
     push lr
	 add sp,-0Ch
	 mov r5,r4
	 add r5,20h
	 ldrh r1,[r4,4h]
	 ldrh r0,[r4,2h]          ;坐标
	 bl CheckBlock2
	 mov r1,r0
	 ldr r2,=XTagRAM          ;检查是否到地面
	 ldrb r0,[r2]
	 cmp r0,0h
	 bne @@OnFloor
	 ldrb r6,[r4,13h]         ;300074B的值,如果敌人跳在空中本就是0
	 lsl r0,r6,1h
	 ldr r3,=FallDateStart    
	 mov r2,r3
	 add r2,r0
	 mov r1,0h
	 ldsh r0,[r2,r1]          ;读取跳跃数据
	 ldr r2,=7FFFh
	 cmp r0,r2
	 bne @@NoEqual
	 sub r6,1h                
	 lsl r0,r6,1h
	 add r3,r0
	 ldsh r0,[r3,r1]
	 ldrh r1,[r4,2h]
	 add r1,r0
;	 strh r1,[r4,2h]
	 b @@OnFloor
@@NoEqual:
     add r6,1h
	 strb r6,[r4,13h]
	 ldrh r1,[r4,2h]
	 add r1,r0
@@OnFloor:
     strh r1,[r4,2h]      ;在地面则写入正确的地面坐标
	 mov r3,80h
	 lsl r3,8h
	 mov r0,r3
	 ldrh r1,[r4]          
	 and r0,r1
	 cmp r0,0h            ;检查取向是否有8000h
	 bne @@Pass
	 orr r1,r3            
	 strh r1,[r4]         ;取向写入8000h无敌
	 mov r0,7Dh
	 strb r0,[r5,0Eh]      ;766写入64h
	 ldr r2,=PrepareJumpOAM ;写入新OAM
	 str r2,[r4,18h]	 
	 mov r0,0h
	 strh r0,[r4,16h]
	 strb r0,[r4,1Ch]
	 mov r0,0B0h
	 bl PlaySound2         ;播放死亡声音
	 mov r0,0Ah
	 bl StopRoomMusic
	 b @@end
@@Pass:
     ldrh r2,[r4,2h]
	 sub r2,20h
	 ldrh r3,[r4,4h]      ;读取坐标
     ldrb r0,[r5,0Eh]
     sub r0,1h
	 strb r0,[r5,0Eh]
     cmp r0,64h
	 bhi @@end	 
	 cmp r0,4Bh
	 bhi @@Green
	 cmp r0,32h
	 bhi @@Blue
	 cmp r0,25h
	 bhi @@Yollow
	 cmp r0,15h
	 bhi @@Red
	 cmp r0,0h
     beq @@Death
     mov r1,4h
     b @@Peer
@@Green:
     cmp r0,63h
	 bne @@PassEffect
     mov r0,r2
     sub r0,20h	 
	 mov r1,r3
	 mov r2,27h
	 bl GfxEffect
@@PassEffect:	 
     mov r1,0h
     b @@Peer
@@Blue:
     cmp r0,4Ah
	 bne @@PassEffect1
	 mov r0,r2
	 mov r1,r3
	 sub r1,20h
	 mov r2,27h
	 bl GfxEffect
@@PassEffect1:	 
     mov r1,1h
     b @@Peer
@@Yollow:
     cmp r0,31h
	 bne @@PassEffect2
	 mov r0,r2
	 mov r1,r3
	 add r1,20h
	 mov r2,27h
	 bl GfxEffect
@@PassEffect2:	 
     mov r1,2h
	 b @@Peer
@@Red:
     cmp r0,24h
	 bne @@PassEffect3
	 mov r0,r2
	 mov r1,r3
	 mov r2,27h
	 bl GfxEffect
@@PassEffect3:	 
     mov r1,3h	 
@@Peer:
     mov r2,2h
     and r2,r0
     cmp r2,0h
     bne @@PalRone
	 mov r2,3h
	 and r2,r0
	 cmp r2,0h
	 bne @@PalRone
	 mov r1,0Eh
@@PalRone:
     strb r1,[r5]
     strb r1,[r5,14h]	 
	 b @@end
@@Death:
	 ;mov r0,0h
	 ;strh r0,[r4]
     mov r0,0Bh
	 mov r1,0h
	 bl ReRooMusic           ;播放boss死亡的房间音乐
	 ldrh r5,[r4,2h]
	 ;sub r5,40h
	 ldrh r6,[r4,4h]
	 mov r1,r5
	 sub r1,80h
	 mov r2,r6
	 mov r0,22h
	 str r0,[sp]
	 mov r0,0h
	 mov r3,0h
	 bl DeathFireWorks
	 mov r3,r5
	 sub r3,40h
	 str r6,[sp]
	 mov r0,0h
	 str r0,[sp,4h]
	 mov r1,1h
	 ldrb r2,[r4,1Fh]   ;GFXROW
	 mov r0,35h         ;大血ID
	 bl SpawnNewPrimarySprite
	 ldr r1,=300007Bh
	 mov r0,14h
	 neg r0,r0
	 mov r2,r0
	 strb r2,[r1]       ;写入门开锁
	 mov r0,1h
	 mov r1,29h
	 bl CheckEvent      ;激活事件1e
@@end:
     add sp,0Ch
	 pop r15
.pool     	 
//////////////////////////////////////////////////////////////////////////////////////////      


     	 
     
;-------------------------------------------------
OutBreak:
    push lr
    ldr r0,=SpriteRNG
	ldrb r0,[r0]
	mov r1,1h
	and r0,r1
	cmp r0,0h
	bne @@OutBMove
	mov r3,1h
	ldr r2,=PrepareJumpOAM
	mov r0,8h
	b @@Peer
@@OutBMove:
    mov r3,3h
	ldr r2,=FastRunOAM        ;写入疾跑的OAM
	mov r0,5h
@@Peer:	
    strb r0,[r5,4h]          ;写入暴走pose
	str r2,[r4,18h]          ;写入OAM
	bl RandomCall
	strb r0,[r4,12h]         ;写入暴走循环次数
	mov r3,0h
	strb r3,[r5,0Ch]
	strh r3,[r4,16h]
	strb r3,[r4,1Ch]
    mov r0,4h
	strb r0,[r5]              ;颜色变紫色
	strb r0,[r4,6h]           ;颜色备份
	mov r0,0Dh
	strb r0,[r5,5h]           ;属性写入大反弹
    mov r0,40h
	ldrb r1,[r5,12h]
	orr r0,r1
	strb r0,[r5,12h]         ;写入无敌
	bl DirectionTag 
    pop r15
;-------------------------------------------------------------------------------------	
	
RandomCall:
    ldr r0,=SpriteRNG
    ldrb r0,[r0]
	cmp r0,8h
	bhi @@div4
	lsr r0,1h
	b @@end
@@div4:	
	lsr r0,2h
@@end:	
    bx r14
.pool    	
;-------------------------------------------------
OutBreakNumSubCall:       ;撞墙时暴走值减少例程
    push lr
    ldrb r0,[r4,12h]      ;读取暴走来回值
	cmp r0,0h
	bne @@OutBreak        ;不为0则是暴走跳过读取奔跑长度值
	ldrh r0,[r5,0Eh]      ;为0的话读取奔跑长度值
	cmp r0,0h             ;如果是0则代表是暴走最后一轮
	beq @@OutBreakJustEnd
	mov r0,3h
	strb r0,[r5,4h]          ;pose写入3 归零pose
@@OutBreak:	
	sub r0,1h             ;暴走值未用完则继续减
	strb r0,[r4,12h]      ;暴走来回值减1
	mov r1,80h
	lsl r0,r1,2h
	mov r1,r0
	ldrh r2,[r4]
	and r0,r2
	cmp r0,0h
	beq @@Orr200
    ldr r1,=0FDFFh
	and r2,r1
	strh r2,[r4]          ;自动换向
	b @@Pass3
@@Orr200:
    orr r2,r1
    strh r2,[r4] 	
	b @@Pass3
@@OutBreakJustEnd:	
	bl DirectionTag       ;重新设定方向
    mov r0,14h	
	strb r0,[r5,0Eh]      ;3000766写入奔跑值
	ldrh r0,[r4,4h]
	strh r0,[r4,8h]       ;备份X坐标 
@@Pass3:
	mov r0,0F8h           ;撞击声
	bl PlaySound2
	mov r0,10h
	mov r1,8h
	bl XShake             ;屏幕晃动	
@@end:	
    pop r15
.pool
;------------------------------------	
RandomMoveOrJumpCall:
    push lr
    ldr r2,=SpriteRNG
	ldrb r2,[r2]
	cmp r2,7h           ;慢移动几率
	bls @@PassStrong    ;小于等于7则跳过ORR1h
	mov r0,1h
	strb r0,[r5,0Ah]     ;有1则壮
@@PassStrong:	
    mov r0,1h
	and r0,r2
	cmp r0,0h
	bne @@PassMove
	ldrh r0,[r4,4h]
	strh r0,[r4,8h]     ;X坐标备份
	ldrb r1,[r5,0Ah]
    mov r0,2h
	orr r1,r0           ;默认是跳 有2则跑?
	strb r1,[r5,0Ah]     ;3000762写入行动方式
@@PassMove:	
	pop r15
.pool 
;--------------------------------------     	 
.align   	
BaristuteSleepOAM:
     .word 8310222h
	 .word 0fh
	 .word 00000000h
	 .word 00000000h
.align	 
SleepToAwakeOAM:	
     .word 8310222h
	 .word 15h 
	 .word 83101b4h
	 .word 09h
	 .word 830ff50h
	 .word 28h
	 .word 000000000h
	 .word 000000000h
	 
	 
.org BaristuteFallOnFloorOAMAdd4
    .byte 3h

.org BaristuteFallOnFloorOAMAdd4 + 8h
    .byte 3h
	
.org BaristuteFallOnFloorOAMAdd4 + 10h
    .byte 3h
	
.org BaristuteJumpOAMAdd4
    .byte 3h
	
.org BaristuteJumpOAMAdd4 + 8h
    .byte 3h
	
.org BaristuteJumpOAMAdd4 + 10h      ;提升起跳速度
    .byte 3h

.close	