.gba
.open "OneDay.gba","OneDay1.gba",0x8000000

; Instructions: uncomment the chozo statue AI and weakness 
; below for each statue you want to be just the ball


.definelabel CurrSprite,0x3000738
.definelabel CheckEndSpriteAnimation,0x800FBC8
.definelabel FallOnFloorOAMAdd4,83104A0h
.definelabel JumpOAMAdd4,8310468h
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
.definelabel FallOnFloorOAM,831049Ch
.definelabel SpriteRNG,300083Ch
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel SpritePalPointers,0x875EEF0
.definelabel SpriteID,6Ch
.definelabel DeathFireWorks,8011084h
.definelabel StopRoomMusic,8003A98h
.definelabel SpriteDrop,800E3D4h
.definelabel GfxEffect,80540ECh
.definelabel SpawnNewPrimarySprite,800E31Ch
.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0

.org 830feb0h
     .import "newjumppal"
	 
.org FallOnFloorOAMAdd4
    .byte 3h

.org FallOnFloorOAMAdd4 + 8h
    .byte 3h
	
.org FallOnFloorOAMAdd4 + 10h
    .byte 3h
	
.org JumpOAMAdd4
    .byte 3h
	
.org JumpOAMAdd4 + 8h
    .byte 3h
	
.org JumpOAMAdd4 + 10h      ;提升起跳速度
    .byte 3h	
	
	  
.org SpriteAiStart +( SpriteID * 4 )       ;改写ai的地址
    .word JumpMain + 1
///
; reusable functions
.definelabel SetChozoEvent,0x80138D8
.definelabel CheckChozoItemCollected,0x8013DE0
.definelabel GetItem,0x80162B0
.definelabel SetPose0_OAM,0x8016344
.definelabel SetPose67_OAM,0x80163A8
.definelabel SetPose9_OAM,0x801640C

; chozo statue AI (uncomment ones you want as ball only)
;.org 0x875E94C				; long beam
;	.word ChozoBallAI + 1
;.org 0x875E954				; ice beam
;	.word ChozoBallAI + 1
.org 0x875E95C				; wave beam
	.word ChozoBallAI + 1
.org 0x875E964				; bombs
	.word ChozoBallAI + 1
;.org 0x875E96C				; speed booster
;	.word ChozoBallAI + 1
.org 0x875E974				; hi-jump
	.word ChozoBallAI + 1
;.org 0x875E97C				; screw attack
;	.word ChozoBallAI + 1
;.org 0x875E984				; varia
;	.word ChozoBallAI + 1
.org 0x875EA20				; gravity
	.word ChozoBallAI + 1
.org 0x875EA24				; space jump
	.word ChozoBallAI + 1
;.org 0x875EB10				; plasma beam
;	.word ChozoBallAI + 1
	
; chozo statue weakness (uncomment ones you want as ball only)
;.org 0x82B0FE2				; long beam
;	.byte 0x1A
;.org 0x82B1006				; ice beam
;	.byte 0x1A
.org 0x82B102A				; wave beam
	.byte 0x1A
.org 0x82B104E				; bombs
	.byte 0x10
;.org 0x82B1072				; speed booster
;	.byte 0x1A
.org 0x82B1096				; hi-jump
	.byte 0x1A
;.org 0x82B10BA				; screw attack
;	.byte 0x1A
;.org 0x82B10DE				; varia
;	.byte 0x1A
.org 0x82B139C				; gravity
	.byte 0x1A
;.org 0x82B13AE				; space jump
;	.byte 0x1A
;.org 0x82B17D4				; plasma beam
;	.byte 0x1A

; copy of chozo ball AI (place in bl range)
.org 0x83040c0		; Crocomire graphics
Pose0:
    push    r4,r14
    ldr     r0,=CurrSprite
    mov     r12,r0			; r12 = CurrSprite
	; new code to check item collected
	ldrb    r0,[r0,1Dh]
	bl      CheckChozoItemCollected         ;获取ID检查是否已经被得到
	cmp     r0,0h
	beq     @@Initialize
	mov     r1,r12
	mov     r0,0h
	strh    r0,[r1]			; remove sprite 清除精灵
	b       @@Return
	; end of new code
@@Initialize:                        ;初始化
	mov     r0,r12
	ldrh    r1,[r0]
    ldr     r0,=0FFFBh
    and     r0,r1
    mov     r2,0h
    mov     r3,0h
    mov     r1,r12
    strh    r0,[r1]			; status &= FFFB
	; new code to adjust height
	ldrh    r0,[r1,2h]               ;垂直坐标向上20h再写入
	sub     r0,20h
	strh    r0,[r1,2h]
	; end of new code
    ldr     r1,=0FFE4h
    mov     r4,r12			; r4 = CurrSprite
    strh    r1,[r4,0Ah]		; top boundary = FFE4
    mov     r0,1Ch
    strh    r0,[r4,0Ch]		; bottom boundary = 1C
    strh    r1,[r4,0Eh]		; left boundary = FFE4
    strh    r0,[r4,10h]		; right boundary = 1C         ;四面分界
    mov     r0,r12
    add     r0,27h
    mov     r1,0Ch
    strb    r1,[r0]			; sprite[27] = C
    add     r0,1h
    strb    r1,[r0]			; sprite[28] = C
    add     r0,1h
    strb    r1,[r0]			; sprite[29] = C
    strb    r2,[r4,1Ch]		; animation counter = 0
    strh    r3,[r4,16h]		; animation = 0
    mov     r1,r12
    add     r1,25h
    mov     r0,1h           ;属性写入1
    strb    r0,[r1]			; sprite[25] = 1
    strh    r0,[r4,14h]		; health = 1
    sub     r1,1h
    mov     r0,8h
    strb    r0,[r1]			; pose = 8
    ; use own sprite ID
    ldrb    r0,[r4,1Dh]		; r0 = sprite ID
    bl      SetPose0_OAM
@@Return:
    pop     r4
    pop     r0
    bx      r0
    .pool
	
Pose8:
    bx      r14
	.align
	
PoseDefault:
    push    r14
    ldr     r0,=CurrSprite
    mov     r12,r0
    mov     r2,r12
    add     r2,32h
    ldrb    r1,[r2]         ;读取碰撞属性
    mov     r0,40h
    mov     r3,0h
    orr     r0,r1           ; 写入40h
    strb    r0,[r2]			; sprite[32] |= 40
    mov     r2,0h
    mov     r0,1h
    mov     r1,r12
    strh    r0,[r1,14h]		; health = 1
    add     r1,25h
    mov     r0,1Eh
    strb    r0,[r1]			; sprite[25] = 1E 属性写入1E,可以获取?
    sub     r1,1h
    mov     r0,67h
    strb    r0,[r1]			; pose = 67
    mov     r0,r12
    strb    r2,[r0,1Ch]		; animation counter = 0
    strh    r3,[r0,16h]		; animation = 0
    add     r0,34h
    ldrb    r1,[r0]
    sub     r0,14h
    strb    r1,[r0]			; collision -= 14
    mov     r2,r12
    add     r2,2Bh
    ldrb    r1,[r2]
    mov     r0,80h
    and     r0,r1
    strb    r0,[r2]			; sprite[2B] &= 80
    ; use own sprite ID
    ldrb    r0,[r2,1Dh]		; r0 = sprite ID
    bl      SetPose67_OAM
    ldr     r0,=11Dh
    bl      PlaySound
    pop     r0
    bx      r0
    .pool
	
	
Pose67:
    push    r14
    bl      CheckEndSpriteAnimation
    cmp     r0,0h
    beq     @@Return
    ldr     r1,=CurrSprite
    mov     r3,r1
    add     r3,24h
    mov     r2,0h
    mov     r0,9h
    strb    r0,[r3]			; pose = 9
    strb    r2,[r1,1Ch]		; animation counter = 0
    strh    r2,[r1,16h]		; animation = 0
    ; use own sprite ID
    ldrb    r0,[r1,1Dh]		; r0 = sprite ID
    bl      SetPose9_OAM
@@Return:
    pop     r0
    bx      r0
    .pool
	
	
Pose9:
    push    r4,r14
    ldr     r3,=CurrSprite
    ldrh    r1,[r3]
    mov     r0,80h
    lsl     r0,r0,4h
    and     r0,r1
    cmp     r0,0h
    beq     @@Return		; return if status doesn't have 800
    ldr     r1,=3001606h	; ???
    mov     r2,0FAh
    lsl     r2,r2,2h
    mov     r0,r2
    strh    r0,[r1]			; [3001606] = 3E8
    mov     r4,r3
    add     r4,32h
    ldrb    r1,[r4]
    mov     r0,1h
    mov     r2,0h
    orr     r0,r1
    strb    r0,[r4]			; freeze timer |= 1
    mov     r1,r3
    add     r1,26h
    mov     r0,1h
    strb    r0,[r1]			; sprite[26] = 1
    sub     r1,2h
    mov     r0,23h
    strb    r0,[r1]			; pose = 23
    mov     r0,r3
    add     r0,2Ch
    strb    r2,[r0]			; sprite[2C] = 0
	; use own sprite ID
    ldrb    r4,[r3,1Dh]
    mov     r0,r4			; r0 = sprite ID
    bl      SetChozoEvent
    mov     r0,r4			; r0 = sprite ID
    bl      GetItem
@@Return:
    pop     r4
    pop     r0
    bx      r0
    .pool

	
Pose23:
    push    r14
    ldr     r2,=CurrSprite
    mov     r1,r2
    add     r1,26h
    mov     r0,1h
    strb    r0,[r1]			; sprite[26] = 1
    add     r1,6h
    ldrb    r1,[r1]			; r1 = sprite[2C]
    and     r0,r1
    cmp     r0,0h
    bne     @@SkipToggle	; skip if sprite[2C] has 1
    ldrh    r0,[r2]
    mov     r1,4h
    eor     r0,r1
    strh    r0,[r2]			; status ^= 2
@@SkipToggle:
    ldr     r0,=3001606h
    ldrh    r1,[r0]
    ldr     r0,=3E6h
    cmp     r1,r0
    bhi     @@Return		; return if [3001606] > 3E6
    mov     r0,0h
    strh    r0,[r2]			; status = 0 (remove sprite)
@@Return:
    pop     r0
    bx      r0
    .pool


ChozoBallAI:
	push    r14
    ldr     r0,=CurrSprite
    add     r0,24h
    ldrb    r0,[r0]			; r0 = sprite pose 检查pose值
    cmp     r0,23h
    beq     @@Pose23
    cmp     r0,23h
    bgt     @@Pose24_plus
    cmp     r0,8h
    beq     @@Pose8
    cmp     r0,8h
    bgt     @@Pose9_plus
    cmp     r0,0h
    beq     @@Pose0
    b       @@PoseDefault
@@Pose9_plus:
    cmp     r0,9h
    beq     @@Pose9
    b       @@PoseDefault
@@Pose24_plus:
    cmp     r0,67h
    beq     @@Pose67
    b       @@PoseDefault
@@Pose0:
    bl      Pose0
    b       @@Return
@@Pose8:
    bl      Pose8
    b       @@Return
@@Pose67:
    bl      Pose67
    b       @@Return
@@Pose9:
    bl      Pose9
    b       @@Return
@@Pose23:
	bl      Pose23
    b       @@Return
@@PoseDefault:
	bl      PoseDefault
@@Return:
    pop     r0
    bx      r0
.pool


AirBallNoStopSpeed:   ;空中变球和旋转射击变直立不减向上的速度
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
	
BeforeJumpSpeed:                    ;跑步速度代入到跳跃中
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
@@NoDefault:
    mov r0,8h         ;加速度
    bx r14	
.pool

BallAir1:
    mov r0,r4
	sub r0,58h
	ldrb r3,[r0,9h]        ;之前旋转跳变直立的flag
	ldrh r1,[r4,0eh]       ;读取面向
	ldrh r2,[r0]           ;读取输入
	cmp r3,0h
	beq @@CheckPressLeftOrRight
	mov r3,80h
	and r3,r2
	cmp r3,0h              ;检查输入如果有下
    bne @@HavePressDown
	mov r3,r1
	and r3,r2              ;没有按下检查方向是否和面相一致
	b @@end
@@HavePressDown:
    mov r3,30h
	mov r0,r1
	eor r0,r3              ;得到面向相反的方向
	and r0,r2              ;和输入and
	cmp r0,0h              ;为0代表没有输入相反的方向
    beq @@end
	mov r3,0h              ;否则给予0 代表没有按左右方向
	b @@end
@@CheckPressLeftOrRight:
	mov r3,30h
	and r3,r2
@@end:
    bx r14  
.pool
	
BallAir2:
    push lr
	mov r0,16h
	mov r2,r4
    sub r2,58h
	ldrb r1,[r2,9h]   ;检查是否是旋转跳变球
	cmp r1,0h
	beq @@PassReturnSpeed ;直立跳直接掉用正常的球空中移动
	ldrb r1,[r2,8h]   ;检查空中可变球保速flag
	cmp r1,0h
	bhi @@ReturnSpeed
	mov r0,16h
	ldsh r1,[r4,r0]
	cmp r1,0h
	bge @@Right
	add r1,1h
	strh r1,[r4,16h]
	neg r1,r1
	b @@PassReturnSpeed
@@Right:
    cmp r1,0h
    beq @@PassReturnSpeed	
	sub r1,1h
@@Write:	
    strh r1,[r4,16h]
	b @@PassReturnSpeed
@@ReturnSpeed:	
    sub r1,1h
	strb r1,[r2,8h]    ;空中可变球flag值减1
	mov r1,r4
	add r1,20h
	ldsh r1,[r1,r0]
	strh r1,[r4,16h]  ;备份的速度
@@PassReturnSpeed:
    ldsh r1,[r4,r0]   ;当前速度
	ldrh r0,[r4,0Eh]  ;面向
	cmp r0,10h
	beq @@FaceRight1
;------------------------面左
    neg r1,r1
@@FaceRight1:
    cmp r1,30h        ;如果值小于30h则默认最大为30h
    bcs @@NoDefault1
    mov r1,30h
@@NoDefault1:
    ldrh r2,[r2]      ;读取输入
	mov r3,30h
	and r2,r3         
	cmp r2,0h
    beq @@PassReversing ;如果没有按方向则跳过	
    and r2,r0         ;看按的左右和面向是否相符	
	cmp r2,0h
	bne @@PassReversing  ;跳过换向
	mov r2,0h
	strh r2,[r4,16h]      ;球在空中速度归0
	mov r2,30h
	eor r2,r0
	strb r2,[r4,0Eh]
@@PassReversing:	
    mov r0,8h         ;加速度  
	mov r2,r4
	bl 8008278h
    pop r15	
.pool


CheckDownKeepSpeed:    ;直立跳例程经历处
    mov r0,r4
	add r0,20h
	ldrb r1,[r0]       ;检查上一个姿势
	sub r0,78h
	cmp r1,0Ch         ;旋转跳
	beq @@SpinJumpFlag
	cmp r1,0Eh         ;太空跳
	beq @@SpinJumpFlag
	cmp r1,0Fh         ;旋转击跳
	beq @@SpinJumpFlag
	cmp r1,22h         ;旋转跳空中开枪变直立会有的上一个姿势
	bne @@ReturnSpinJumpFlag
@@SpinJumpFlag:
    mov r1,1h
    strb r1,[r0,9h]   ;旋转跳变直立flag
    b @@ContinueCheck
@@ReturnSpinJumpFlag:
    mov r1,0h
    strb r1,[r0,9h] 	
@@ContinueCheck:	
	mov r1,14h         ;帧数
	strb r1,[r0,8h]    ;写入空中可变球flag
	ldrh r0,[r0]       ;读取输入
	mov r1,81h         ;下 跳 任意一个都可以保持速度
	and r1,r0
	cmp r1,0h
	bne @@NoReturnSpeed0
	ldrb r0,[r4,2h]    ;读取炮口方向
	cmp r0,4h          ;如果向下
	beq @@NoReturnSpeed0		
    ldrh r0,[r4,16h]   ;读取速度
    mov r3,16h
	ldsh r1,[r4,r3]    ;读取速度,带负数
	cmp r1,0h
	ble @@LessThanOrQ0
;---------------------;速度是正数则减	
	sub r0,r0,r2
	strh r0,[r4,16h]
    lsl r0,r0,10h
    cmp r0,0h
	bge @@NoReturnSpeed0
    b @@ReturnSpeed0
@@LessThanOrQ0:       ;速度是负数
    cmp r1,0h
    bge @@NoReturnSpeed0  
    add r0,r2,r0
	strh r0,[r4,16h]
	lsl r0,r0,10h
	cmp r0,0h
	ble @@NoReturnSpeed0  ;已经加的数,如果依然小于等于0则不归0
@@ReturnSpeed0:    
	strh r6,[r4,16h]
@@NoReturnSpeed0:	
	bx r14
.pool

NoEasySpeedBoosterJumpDuck:   ;防止只要加速跑中跳起按下就能很简单的落地得到加速蓄力
	cmp r1,0h
	bne @@end
	mov r0,r4             ;13d4
	add r0,20h
	ldrb r1,[r0,2h]       ;检查上个姿势的炮口方向
	cmp r1,4h
	bne @@end             ;不向下的话直接结束
	ldrb r1,[r0]
	cmp r1,8h             ;上个姿势是空中直立
	bne @@end             ;不是则结束
	mov r1,4h
@@end:
    strb r1,[r4]
    mov  r0,1
    bx   r14
.pool	

 FlagXYSpeed:              ;记录了弹丸初始化时的人物X速度
    strb r2,[r3]
	strb r4,[r3,0fh]
	ldr r2,=30013d4h
	mov r1,16h
	ldsh r0,[r2,r1]      ;读取X速度
	cmp r0,0h
	beq @@WriteX
	cmp r0,0h
	bge @@Right
	neg r0,r0
@@Right:	
	lsl r0,r0,10h
	lsr r0,r0,13h        ;除以八
@@WriteX:
    strb r0,[r3,2h]      ;写入X起速值
    mov r1,18h
    ldsh r0,[r2,r1]      ;读取Y速度	
	cmp r0,0h            ;不动标记
	beq @@WriteY
	cmp r0,0h       
	bge @@Up
	mov r0,0Ah            ;向下标记
	b @@WriteY
@@Up:
    mov r0,0F6h            ;向上标记
@@WriteY:	
    strb r0,[r3,3h]     	
	bx r14 
.pool

AddXYSpeed:              ;根据人物射弹丸时候的速度来改变弹丸的速度
    strh r0,[r4,0Ah]
	ldrb r2,[r4,2h]      ;读取备份的X初始速度
	cmp r2,0h
	beq @@PassWriteXPosition
	mov r0,40h
	and r0,r1
	cmp r0,0h
	beq @@left
	ldrh r0,[r4,0Ah]
	add r0,r0,r2
	b @@WriteX
@@left:
    ldrh r0,[r4,0Ah]
    sub r0,r0,r2
@@WriteX:
	sub r2,1h
	strb r2,[r4,2h]	
    strh r0,[r4,0Ah]         ;写入弹丸X最终坐标
@@PassWriteXPosition:
	ldrb r0,[r4,3h]          ;读取Y备份的初始速度
	cmp r0,0h
	beq @@end
	mov r2,0F0h
	and r2,r0
	cmp r2,0F0h
	bne @@Up
	mov r2,0FFh
	lsl r2,r2,8h
	add r2,r2,r0
	add r0,r0,1h
	lsl r0,r0,18h
	lsr r0,r0,18h
	b @@WriteY
@@Up:
    mov r2,r0	
	sub r0,r0,1h
@@WriteY:
    strb r0,[r4,3h]
	ldrh r0,[r4,8h]	;读取弹丸Y坐标
    add r0,r0,r2
    lsl r0,r0,10h
    lsr r0,r0,10h
    strh r0,[r4,8h]	
@@end:
    pop r4,r5
    pop r15
.pool	 

PoseCCheckPoseF:
    mov r0,8h
    and r0,r1
    cmp r0,0h
    beq @@end
	ldrb r0,[r4,12h]
	cmp r0,0h        ;全装甲则旋转攻击正常
	bhi @@end
	mov r0,r4
	add r0,0A7h
	ldrb r0,[r0]
	cmp r0,1h        ;只有上升的时候才有旋转攻击
	beq @@end
	mov r0,0h        ;返回零的话则没有旋转攻击
@@end:
    bx r14	
.pool

CanUsePlasma:            ;可以使用离子但是屏蔽波动
     push lr
     mov r0,3h
	 mov r1,25h          ;检查莱德利是否死亡
	 bl 80608bch
	 cmp r0,0h
	 bne @@Return        ;死了就跳过
	 ldr r2,=3001530h
	 ldrb r0,[r2,12h]    ;检查服装
	 cmp r0,0h
	 bhi @@Return           ;大于零则结束
	 mov r0,4h
	 ldrb r1,[r2,0Ch]    
	 and r0,r1           ;检查是否有波动光束
	 cmp r0,0h
	 beq @@PassCanceWave
	 eor r1,r0	         ;有的话取消掉
@@PassCanceWave:	 
	 mov r0,08h
	 orr r1,r0
     strb r1,[r2,0Dh]    ;激活离子光束 	 
@@Return:	 
	 mov r0,1h
	 mov r1,18h
	 pop r15
.pool	
 
CanceUsePlasma:
     push lr
     ldr r4,=3001530h
	 ldrb r1,[r4,0Ch]
	 mov r0,04h
	 and r0,r1
	 cmp r0,0h        ;检查波动光束是否存在
	 beq @@CheckPlasma
	 ldrb r1,[r4,0Dh] ;检查波动光束是否激活
	 and r0,r1
	 cmp r0,0h
	 bne @@CheckPlasma ;激活了则检查离子
	 mov r0,4h
	 orr r1,r0
	 strb r1,[r4,0Dh]  ;没有激活则激活
@@CheckPlasma:	
     ldrb r0,[r4,12h]
	 cmp r0,0h
	 bhi @@end         ;服装是全装甲则结束
     strb r1,[r4,0Ch] 
	 mov r0,8h
	 and r0,r1        ;检查是否有离子光束
	 cmp r0,0h
	 beq @@end        ;没有则结束	 
	 eor r1,r0
	 strb r1,[r4,0Dh] ;有的话则屏蔽
@@end:	 
	 bl 0x804F670     ;刷新光束图片
	 mov r0,0Bh
	 mov r1,0h
	 pop r15
.pool  	

CheckPlasmaWave:
     push lr
	 ldr r0,=300153Dh ;检查是否检查的是第一序列的能力
	 cmp r0,r5
	 bne @@Return
	 cmp r6,4h        ;检查要激活的能力是否是波动
	 bne @@Return     
	 ldrb r0,[r5,5h]
	 cmp r0,0h
	 bhi @@Return     ;如果全装甲则直接激活
     mov r0,3h
	 mov r1,25h
	 bl 80608bch      ;检查莱德利是否死亡
	 cmp r0,0h
	 bne @@Return     ;死亡则激活
	 ldrb r0,[r5]
	 mov r1,8h
	 and r0,r1
	 cmp r0,0h        ;检查离子光束是否是激活的
	 beq @@Return     ;离子没有激活则波动激活
	 b @@end          ;离子激活了则直接结束不激活波动
@@Return:
     ldrb r1,[r5]
     mov r0,r6
     eor r0,r1
	 strb r0,[r5]
@@end:	 
     pop r15
.pool
///////////////////////////////////////////////////////////
LeaveRoomMissMetroidFlag: ;当被M吸的flag没有为零时经过
     push lr
	 cmp r0,0h
	 beq @@Return      ;没有被吸则直接返回
	 ;被吸检查是否有64精灵
	 mov r0,64h
	 bl 80107F8h       ;检查metroid是否存在房间内
	 cmp r0,0FFh
	 beq @@NoMetroidInRoom
	 ;没有则同样结束
@@Return:	 
	 mov r0,r4
	 add r0,5Bh
	 b @@end
@@NoMetroidInRoom:
     mov r2,0h
     mov r0,r4
     sub r0,45h
     strb r2,[r0]      ;被M吸效果归零
     add r0,0A0h	 
@@end:
     pop r15
.pool	

AllMissileCheck:
     push r1
	 ldrh r1,[r0,2h]   ;检查最大导弹数
	 cmp r1,0h
	 bne @@end         ;不为零则触发结束
	 ldrb r1,[r0,4h]   ;检查最大超导数
@@end:
     mov r0,r1
     pop r1
	 cmp r0,0h
     bx r14 	
.pool	 
     	 
CheckBallSpeed:
     ldrb r0,[r4,8h]    ;检查是否球滚高速
	 cmp r0,6h
	 bne @@NoBallSpeed
	 mov r0,0A0h
	 strb r0,[r4,0Ah]
@@NoBallSpeed:
     ldrb r0,[r4,0Ah]
     mov r1,r0
     bx r14
.pool	 
     
////////////////////////////////////////////////////////
;.org 8043df0h               ;鳄鱼的AI地址	 
JumpMain:        
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
    ldr r0,=SleepOAM          ;写入睡眠的OAM
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
	mov r0,1Dh
	mov r1,0h
	bl ReRooMusic 	         ;音乐改变为sm克雷德boss音乐	
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
	 ldr r2,=FallOnFloorOAM
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
	 ldr r2,=FallOnFloorOAM       ;落地的OAM
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
   	
SleepOAM:
     .word 8310222h
	 .word 0fh
	 .word 00000000h
	 .word 00000000h
	 
SleepToAwakeOAM:	
     .word 8310222h
	 .word 15h 
	 .word 83101b4h
	 .word 09h
	 .word 830ff50h
	 .word 28h
	 .word 000000000h
	 .word 000000000h
.pool
//////
////////////////////////////////////////////////////
.org 8007758h      ;下坡的时候速度限制处
    cmp r2,0E0h
.org 800775Ch
    mov r2,0E0h
.org 8007760h
    mov r0,0E0h	

////////////////////////////////////////////////////

.org 80081E6h               ;普通旋转跳检查旋转攻击
    bl PoseCCheckPoseF
.org 800824Eh               ;旋转攻击跳检查旋转攻击
    bl PoseCCheckPoseF
.org 8008202h               ;太空跳检查旋转攻击
    bl PoseCCheckPoseF	
/////////////////////////////////////////////////////

.org 8013bd2h     ;离子光束能力写入处
     bl CanUsePlasma
.org 8070138h     ;离子吃到后进入菜单再次取消处
     nop          ;strb r2,r0
.org 8033ce8h          ;莱德利死处
     bl CanceUsePlasma   	
.org 8071c6ah     ;get波动光束激活处 也是能力取消处
     bl CheckPlasmaWave    
.org 80482bch      ;莱德利电梯头墙崩落触发事件
     .byte 23h     ;改成苍蝇死
	 
.org 8025ADCh
     nop
     nop           ;二蛆处锁门	

.org 8035A8Ah
     nop           ;Metroid处锁门	
	 
.org 8023b82h      ;落虫触发的事件直接pass
     b 8023b98h	 

.org 8007684h      ;被M吸水中flag写入处
     bl LeaveRoomMissMetroidFlag   ;Metoird吸附减速不带到别的房间
	 
.org 8021294h             ;蜈蚣两种导弹都检查
     bl AllMissileCheck
	 
.org 8014158h
     .byte 02      ;雕像可以抓
	 
	 
; allow laying PBs before bombs
.org 0x8008022
	ldrb    r1,[r3,2]
	mov     r0,4
	and     r0,r1
	cmp     r0,0	
	beq     @@TryLayBomb
	mov     r0,5  ; power bomb
	b       LayBomb
@@TryLayBomb:
	ldrb    r1,[r2,0Dh]
	mov     r0,80h
	and     r0,r1
	cmp     r0,0h
	beq     8008046h
	mov     r0,4h  ; normal bomb
	b       LayBomb

.org 0x8008044          ;超炸可以不用炸弹使用,防卡死
LayBomb:
	strb    r0,[r3,1h]


; fix status screen

; check PBs if no bombs   
.org 0x80709F2
    beq     0x8070A08
.org 0x8070A02
	b       0x8070A08
.org 0x8070A24
	b       0x8070BFE  ; return if not any bombs

; if PBs and no bombs, gray bombs out
.org 0x8070A9E
	beq     0x8070B66

; make PB activation not depend on bomb activation
.org 0x8070B1A
	b       0x8070B28

; skip assigning cursor position (avoid selecting bombs)
.org 0x8070BEC
	b       0x8070BFE

.org 0x8012d20
    .byte 02             ;掉落可以吃的延迟时间
/////////////////////////////////////////////////////
;跳跃中变成球 以及旋转跳射击不减向上的速度
.org 800A624h      ;Y值写入处
    bl AirBallNoStopSpeed	 
;.org 0x80076e4    ;空中移动最大速度(非金身,默认为40h)
;     .byte 9Fh
//////////////////////////////////////////////////////
.org 0x8009008    ;向前跳给予跳跃加速度和速度的最大值处
    bl BeforeJumpSpeed  ;跑步速度代入到跳跃中
    b 8009012h

/////////////////////////////////////////////////	
/////////////////////////////////////////////////
;球滚加速
.org 0x8009456              ;球写入加速度地点调用
    mov r0,r4
	bl 		80084DCh		;加速时间例程
	mov 	r0,0h
	strb	r0,[r4,4h]		;防止没有球跳能力的时候球跳
	b 8009464h
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
;球跳
.org 0x80095ba           ;球在空中
    bl BallAir1          ;只按下可以保证球依然保持速度
	b 80095c2h
	                      ;同上,接上
.org 0x80095d2            ;球前跳加速和速最大值写入处
    bl BallAir2           ;把变球时去掉的速度重新写入
	b 80095dch
/////////////////////////////////////////////////////
;.org 0x80075a8
.org 0x8006d2c            ;跳跃空中落地变奔跑处
    bl NoEasySpeedBoosterJumpDuck
/////////////////////////////////////////////////////


////////////////////////////////////////////////////
.org 804ee36h           ;弹丸初始化处
    bl FlagXYSpeed
	
.org 804f9e2h           ;弹丸并入人物速度处
	bl AddXYSpeed
    b 804fa12h	
	
;.org 0x8304054
.org 8008518h           ;防止慰球高速的时候依然计算加速累计值，于是失去金身
    bl CheckBallSpeed
	
///////////////////////////////////////////////////////	
	
.org 0x8006b4c        ;球滚跳调用速度,让速度减半...
    asr r0,r0,10h     ;改为保持原速   

//////////////////////////////////////////////////////
.org 0x80075C4			;r0 = 30013F4,  r2 = 30013D4, r3 = 3001528 at hijack start
	ldr r1,=8777001h	;make r1 freespace, if used on vanilla rom the current offset is okay
	bl 808ABFCh		;branches directly to bx r1 to jump to code
	b 80075FEh		
.pool
.org 0x8007024      ;金身计数器不会在被击打后清零
    nop
;.org 0x8008464
;    nop	
.org 0x8777000		;Freespace
	push r14	
	mov r1,r2	;moves 30013D4 into r1
	sub r1,58h	;subtracts r1 by 58 to get 300137C, (Button Input Address)
	ldrh r0,[r1]	;loads current input to r0
	ldrh r1,[r2,0Eh];loads Samus'current direction to r1. 10=right 20=left 30013e2是当前的方向
	and r1,r0
	cmp r1,0h	;检查输入的方向和人物方向是否一致 无论是站立不动还是方向相反，都会不一致？？？
	beq @@NormalLandThansferStation
	mov r1,r2	;moves 30013D4 into r1
	add r1,20h	;adds 20 to get 30013F4 samus上一个姿势
	ldrb r0,[r1,1h]	;loads 30013F5 into r0 得到数据 似乎是之前在地面还是空中或者是敌人身上
    cmp r0,1h       ;在地面加速跑可以随时跳起保持落地保持金身.而在敌人身上加速跑跳则会失去金身,但是落下则可以保持金身.
	;cmp r0,2h         ;利用敌人变加速跑,在敌人身上跑一段(边缘)跳能在落地保持金身,并且可以在空中无限次变直立而不失金身
	beq @@LandingCheck   ;是的话跳转
	ldrb r0,[r2,1h]	;mid-air flag 30013d5的数据 0为地面，1为敌人身，2为半空 1跳转为球冲遇斜坡变成人加速跑 2则是球无法跳，一旦跳就会失去金身
	cmp r0,2h	;checking if grounded 检查当前处于何种状态
	bne @@LandingCheck ;只要在地面或敌人身上就跳转
////	
	ldrb r0,[r2]
	cmp r0,14h         ;检查姿势是否是下落球
	bne @@NormalLandThansferStation
	mov r1,r2
	sub r1,58h
	ldrb r0,[r1,8h]    ;检查空中变球某值
	cmp r0,0h          ;为0则取消速度
	beq @@NormalLandThansferStation
////
@@LandingCheck:	
	mov r1,r13	;r13为3007e24   7DFC
	add r1,4h   ;r1为3007e28    7E00
	ldrb r0,[r1]
	cmp r0,0FDh	;只有跳跃落地才是正确的,包括球
	bne @@MorphJump
	ldrb r0,[r2]	;loads current pose 得到当前的姿势
	cmp r0,14h	;checks if falling/landing in morphball mode 球形态跳跃或下落中
	bne @@MorphChecks ;不是则跳转
	mov r0,12h
	strb r0,[r1]  	;sets r1 t0 12, which has to do with morphball 和变形球有什么关系
	b @@BoostCheck
@@MorphJump:
	cmp r0,0FEh	;seems to be true when jumping in morphball mode 就算普通起跳也经过这里
	bne @@NormalLandThansferStation ;不是则跳转
    b @@CheckNoBall
	
@@MorphChecks: ;球形态检查 正常起跳也调用,落地则也许调用
	ldrb r0,[r2]	;loads current pose 得到当前的姿势
	cmp r0,31h	;checks if getting hurt in morphball 检查球形态受伤姿势
	beq @@NormalLandThansferStation
	cmp r0,32h	;checks if knocked back while in morphball 检查球形态受创反弹姿势
	beq @@NormalLandThansferStation
	
    mov r0,0h
  	strb r0,[r1]  ;清空3007e00的值？
/////  
@@CheckNoBall:
    mov r0,r2
    add r0,20h
    ldrb r0,[r0]	
	cmp r0,11h
	beq @@CheckMochBall
	cmp r0,14h
	beq @@CheckMochBall
	cmp r0,22h
	bne @@BoostCheck
	b @@CheckMochBall
@@NormalLandThansferStation:
    b @@NormalLand		
@@CheckMochBall:
    ldrb r0,[r2,0Eh]
	mov r1,10h
	and r0,r1
	cmp r0,0h
	beq @@FaceLeft
;==============面右
    mov r1,16h
	ldsh r0,[r2,r1]       ;获取X速度
	lsr r5,r0,3
	b @@CheckBlock
@@FaceLeft:
	mov r1,16h
	ldsh r0,[r2,r1]       ;获取X速度
	neg r0,r0
	lsr r0,r0,3           ;速度除以8为移动距离
	neg r5,r0
@@CheckBlock:
    bl CheckTopBlock
	cmp r0,0h
	beq @@BoostCheck
@@HaveBlock:	
	mov r0,14h
	strb r0,[r2]
	b @@SmoothLand
////
@@BoostCheck:
	ldrb r0,[r2,5h]	;checking if speedboosting 30013d9若为1则进入金身
	cmp r0,0h       ;若没有金身
	beq @@SmoothLand ;则跳转	
	mov r0,22h       ;写入冲刺？？？？只要加速跳起就会变成的姿态
	strb r0,[r2]	;sets samus in shinespark pose, seems to cause samus 写入冲刺，似乎导致萨在球形态中变成旋转
			;to pop out of morphball in the spinjump pose rather than 跳优先于制造她冲刺。同时也在推进跳跃中读
			;make her shinespark. Also read when jumping while boosting
@@SmoothLand:
	bl Return	
	b @@ResetNormal
@@NormalLand:	
	bl Return	
@@SpeedReset:		;overwritten instructions that store 0 to speed related 与速度有关的都写入0
	mov r0,0h	;offsets. Skipped when keeping speed
	strh r0,[r2,16h]   ;30013ea X轴动量为0
	strb r0,[r2,5h]    ;30013d9 金身失去
	strb r0,[r2,2h]	   ;30013d6 炮口方向变成前
	strb r0,[r2,0Ah]   ;30013de 速度助推时间为0
@@ResetNormal:		;overwritten instructions that store 0, always read 总是读
////                ;用于球跳时变成人,不会失去向上的速度
    ldrb r0,[r2]
	cmp r0,14h
	bne @@ResetY
	mov r0,r2
	sub r0,58h
	ldrh r0,[r0,4h]
	mov r1,40h
	and r0,r1
	cmp r0,0h
	beq @@ResetY
	mov r0,r2
	sub r0,58h
	ldrh r0,[r0]
	mov r1,1h
	and r0,r1
	cmp r0,0h
	bne @@SkipResetY
@@ResetY:
////	
	mov r0,0h	
    strh r0,[r2,18h]   ;30013ec 垂直动量
@@SkipResetY:	
    mov r0,0h	
	strh r0,[r2,0Ch]   ;30013e0 空中最后接触的墙面方向
	strh r0,[r2,10h]   ;30013e4 电梯上下
	strb r0,[r2,1Ch]   ;30013f0 动画计数器 人物？
	strb r0,[r2,1Dh]   ;30013f1 动画状态
	;mov r0,0h            多余代码
	strb r0,[r2,4h]    ;30013e8 >?>?.
	strb r0,[r2,7h]    ;30013eb 墙跳时间
	pop r0
	mov r1,0h
	bx r0
Return:		;overwritten and skipped routine being replaced
	push r14	
	mov r0,r2
	add r0,20h
	mov r1,r2
	ldmia [r1]!,r4-r6
	stmia [r0]!,r4-r6
	ldmia [r1]!,r4-r6
	stmia [r0]!,r4-r6
	ldmia [r1]!,r4,r5
	stmia [r0]!,r4,r5
	ldrb r0,[r2,3h] ;检查是否回头
	cmp r0,0h       ;不回头的话
	beq @@SubReturn
	ldrh r0,[r2,0Eh];方向
	mov r1,30h
	eor r0,r1       ;换向
	mov r1,0h
	strh r0,[r2,0Eh]
	strb r1,[r2,3h]
@@SubReturn:		;overwritten and skipped routine being replaced
	pop r0		;8760E1C
	bx r0
	
.pool

CheckTopBlock:
    ldrh r1,[r2,12h]      ;X坐标
	add r1,r5             ;加上速度
	lsl r1,r1,10h
	lsr r1,r1,16h
	ldrh r0,[r2,14h]      ;Y坐标
	mov r5,60h
	neg r5,r5
	add r0,r5
	lsl r0,r0,10h
	lsr r0,r0,16h
	ldr r6,=300009Ch
	ldrh r5,[r6,1Ch]      ;房间最大宽度
	mul r5,r0             ;乘以高度
	add r5,r1             ;加上X坐标
	lsl r5,r5,1
	ldr r1,[r6,18h]
	add r1,r5
	ldrh r0,[r1]          ;检查砖块编号	
	cmp r0,0h                   ;空气
    beq @@ContinueCheckNextBlock
	cmp r0,3h                   
	beq @@ContinueCheckNextBlock
	cmp r0,17h
	beq @@ContinueCheckNextBlock	
    cmp r0,1Bh
    beq @@ContinueCheckNextBlock
    cmp r0,20h
    bcc @@HaveBlock
    cmp r0,29h	
	bcc @@ContinueCheckNextBlock
    cmp r0,50h
	bcc @@HaveBlock
	cmp r0,57h
	beq @@ContinueCheckNextBlock
    cmp r0,5Ah                   ;加速砖1
	beq @@ContinueCheckNextBlock
	cmp r0,5Ch
	bcc @@HaveBlock
	cmp r0,66h
	bcc @@ContinueCheckNextBlock
	cmp r0,67h
	beq @@ContinueCheckNextBlock
	cmp r0,6Ah                   ;加速砖2
	beq @@ContinueCheckNextBlock
	cmp r0,7Ch
	bcc @@HaveBlock
	cmp r0,8Ch
	bcc @@ContinueCheckNextBlock
	cmp r0,0A0h
	bcc @@HaveBlock
	cmp r0,0A3h
	bcc @@ContinueCheckNextBlock
    lsl r0,r0,18h
	lsr r0,r0,18h
	cmp r0,1Ch                   ;1C-1F 隐藏的道具被打出
	bcc @@HaveBlock
	cmp r0,20h
	bcc @@ContinueCheckNextBlock
	cmp r0,3Ch                   ;吃完水中道具的水
	beq @@ContinueCheckNextBlock
    lsl r0,r0,1Ch
	lsr r0,r0,1Ch
	cmp r0,5h
	beq @@HaveBlock  
@@ContinueCheckNextBlock:
	ldrh r1,[r2,12h]      ;X坐标 
	lsl r1,r1,10h
	lsr r1,r1,16h 
	ldrh r0,[r2,14h]
	mov r5,60h
	neg r5,r5
	add r0,r5
	lsl r0,r0,10h
	lsr r0,r0,16h
	ldr r6,=300009Ch
	ldrh r5,[r6,1Ch]      ;房间最大宽度
	mul r5,r0             ;乘以高度
	add r5,r1             ;加上X坐标
	lsl r5,r5,1
	ldr r1,[r6,18h]
	add r1,r5
	ldrh r0,[r1]          ;检查砖块编号	
 	cmp r0,0h                   ;空气
    beq @@ReturnZero
	cmp r0,3h                   
	beq @@ReturnZero
	cmp r0,17h
	beq @@ReturnZero	
    cmp r0,1Bh
    beq @@ReturnZero
    cmp r0,20h
    bcc @@HaveBlock
    cmp r0,29h	
	bcc @@ReturnZero
    cmp r0,50h
	bcc @@HaveBlock
	cmp r0,57h
	beq @@ReturnZero
    cmp r0,5Ah                   ;加速砖1
	beq @@ReturnZero
	cmp r0,5Ch
	bcc @@HaveBlock
	cmp r0,66h
	bcc @@ReturnZero
	cmp r0,67h
	beq @@ReturnZero
	cmp r0,6Ah                   ;加速砖2
	beq @@ReturnZero
	cmp r0,7Ch
	bcc @@HaveBlock
	cmp r0,8Ch
	bcc @@ReturnZero
	cmp r0,0A0h
	bcc @@HaveBlock
	cmp r0,0A3h
	bcc @@ReturnZero
    lsl r0,r0,18h
	lsr r0,r0,18h
	cmp r0,1Ch                   ;1C-1F 隐藏的道具被打出
	bcc @@HaveBlock
	cmp r0,20h
	bcc @@ReturnZero
	cmp r0,3Ch                   ;吃完水中道具的水
	beq @@ReturnZero
    lsl r0,r0,1Ch
	lsr r0,r0,1Ch
	cmp r0,5h
	beq @@HaveBlock              ;所有门的4xx砖只要是尾数是5就是砖块
@@ReturnZero:
    mov r0,0h
@@HaveBlock:
    bx r14
.pool	
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
;跳起按下后的姿势和X速度清零处 附近也写入了姿势8
.org 8006a5ah
    nop
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
;跳起不按前,速度减少的写入处
.org 8008da0h               ;直立跳例程经历处
    bl CheckDownKeepSpeed
	b 8008dc6h	
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
;.org 80095f8h   ;空中变球X速度归0处
 ;   nop	
/////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
.org 824ffa4h
     .byte 08     ;冲刺起势第三阶段的帧数(常态)
	 
.org 824ffb4h     ;冲刺起势第四阶段的帧数(常态)
     .byte 03
	 
.org 0x8007f88    ;球冲准备中可以放炸弹
     .byte 10h
.org 0x8007f8c    ;球冲中可以放炸弹
     .byte 10
.org 0x8007f90    ;球冲碰壁也可以放炸弹
     .byte 10 	 
.org 0x8007f74
     .byte 10     ;被雕像抓住后可以放炸弹 超炸不能 
.org 0x8007ff4	 
	 .byte 10
	 
	
.org 0x80076d4    ;地面行走加速度
     .byte 8h
.org 0x80076dc    ;地面行走最大速度(非加速跑,默认为60h)
     .byte 60h    ;A0则会进入金身
	 
;.org 8013fceh     ;长枪指引事件检查
    ; .byte 8h
	 
;.org 8013fd4h     ;冰枪指引事件检查
     ;.byte 0Ah

;.org 8013fdah     ;波动指引事件检查
     ;.byte 0Eh

;.org 8013fe0h     ;炸弹指引事件检查
     ;.byte 09h

;.org 8013fe6h     ;加速指引事件检查
     
	 ;.byte 0bh
	 
;.org 8014048h     ;加速能力检查
     ;.byte 02 
	 
;.org 8013fech     ;高跳指引事件检查
     ;.byte 0Ch

;.org 8013ff2h     ;旋转指引事件检查
     ;.byte 0Fh

;.org 8013ff8h     ;隔热指引事件检查
     ;.byte 0Dh

;指引雕像位置变化
;长枪换波动
;炸弹换旋转
;加速换长枪
;隔热换冰枪
;高跳换炸弹
;波动换隔热
;冰枪换加速能力
	 
.close	
	
	