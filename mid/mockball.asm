.gba
.open "zm.gba","mockball.gba",0x8000000
;by Diwa.JumZhu
;注释
;奔跑的速度可以代入到跳跃中
;跳跃的速度可以代入到奔跑中
;跳起变成球保持向上的速度
;球跳变回人形保持向上的速度
;加速跑跳落地保持高速
;球滚动可以像奔跑一样获得加速
;球跳跃保持球滚动的速度
;向前跳炮管向下不会失去速度
;离地面很近的距离变成球可以保持空中的X速度
;sparkball可以释放炸弹
;spark动作加快
;speedboostingtime受伤不会丧失
;旋转跳中射击变直立不减向上的速度

////////////////////////////////////////////////////
.org 8007758h      ;下坡的时候速度限制处
    cmp r2,0E0h
.org 800775Ch
    mov r2,0E0h
.org 8007760h
    mov r0,0E0h	

////////////////////////////////////////////////////


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

	
.org 0x8304054
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
	mov r1,0Ch         ;帧数
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
		

	 
///////////////////////////////////////////////////////	
	
.org 0x8006b4c        ;球滚跳调用速度,让速度减半...
    asr r0,r0,10h     ;改为保持原速   

//////////////////////////////////////////////////////
.org 0x80075C4			;r0 = 30013F4,  r2 = 30013D4, r3 = 3001528 at hijack start
	ldr r1,=8762001h	;make r1 freespace, if used on vanilla rom the current offset is okay
	bl 808ABFCh		;branches directly to bx r1 to jump to code
	b 80075FEh		
.pool
.org 0x8007024      ;金身计数器不会在被击打后清零
    nop
;.org 0x8008464
;    nop	
.org 0x8762000		;Freespace
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
    cmp r0,0h       ;在地面加速跑可以随时跳起保持落地保持金身.而在敌人身上加速跑跳则会失去金身,但是落下则可以保持金身.
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
     .byte 02     ;冲刺起势第三阶段的帧数(常态)
	 
.org 824ffb4h     ;冲刺起势第四阶段的帧数(常态)
     .byte 02
	 
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
	 
;.org 0x8345b4A
;     .byte 05h	  ;缓慢空砖的消失帧数
	 
;.org 0x8345b3d   ;快速空砖在加速的时候的消失帧数
;     .byte 04    	 


	 
.close
