.gba
.open "zm.gba","SmoothLanding.gba",0x8000000


.org 0x80075C4			;r0 = 30013F4,  r2 = 30013D4, r3 = 3001528 at hijack start
	ldr r1,=8760d39h	;make r1 freespace, if used on vanilla rom the current offset is okay
	bl 808ABFCh		;branches directly to bx r1 to jump to code
	b 80075FEh		
.pool
.org 0x8007024  ;金身计数器不会在被击打后清零
    nop
.org 0x8008464
    nop	
.org 0x8760d38		;Freespace
	push r14	
	mov r1,r2	;moves 30013D4 into r1
	sub r1,58h	;subtracts r1 by 58 to get 300137C, (Button Input Address)
	ldrh r0,[r1]	;loads current input to r0
	ldrh r1,[r2,0Eh];loads Samus'current direction to r1. 10=right 20=left 30013e2是当前的方向
	and r0,r1
	cmp r0,0h	;检查输入的方向和人物方向是否一致 无论是站立不动还是方向相反，都会不一致？？？
	beq @@NormalLand
	mov r1,r2	;moves 30013D4 into r1
	add r1,20h	;adds 20 to get 30013F4 samus上一个姿势
	ldrb r0,[r1,1h]	;loads 30013F5 into r0 得到数据 似乎是之前在地面还是空中或者是敌人身上
	;cmp r0,22h      ;金身空中旋转跳转直立立马失去速度,但是金身从高处落下有一帧蓄力的机会
	;cmp r0,0xF      ;同上
	;cmp r0,1h        ;利用敌人变加速跑,在敌人身上跳则能在落地保持金身,其他任何跳直立落地都是1帧机会,第二次直立失去速度.
    cmp r0,0h       ;在地面加速跑可以随时跳起保持落地保持金身.而在敌人身上加速跑跳则会失去金身,但是落下则可以保持金身.
	;cmp r0,2h         ;利用敌人变加速跑,在敌人身上跑一段(边缘)跳能在落地保持金身,并且可以在空中无限次变直立而不失金身
	beq @@LandingCheck   ;是的话跳转
	ldrb r0,[r2,1h]	;mid-air flag 30013d5的数据 0为地面，1为敌人身，2为半空 1跳转为球冲遇斜坡变成人加速跑 2则是球无法跳，一旦跳就会失去金身
	cmp r0,2h	;checking if grounded 检查当前处于何种状态
	bne @@LandingCheck ;只要在地面或敌人身上就跳转
	b @@NormalLand
@@LandingCheck:	
	mov r1,r13	;r13为3007e24
	add r1,4h   ;r1为3007e28
	ldrb r0,[r1]
	cmp r0,0FDh	;seems to only be true if landing from a jump 只有跳跃落地才是正确的
	bne @@MorphJump
	ldrb r0,[r2]	;loads current pose 得到当前的姿势
	cmp r0,14h	;checks if falling/landing in morphball mode 确认球形态跳跃或下落中
	bne @@MorphChecks ;不是则跳转
	mov r0,12h
	strb r0,[r1]  	;sets r1 t0 12, which has to do with morphball 和变形球有什么关系
	b @@BoostCheck
@@MorphJump:
	cmp r0,0FEh	;seems to be true when jumping in morphball mode 只有球形态跳跃才是正确的，然而没找到过
	bne @@NormalLand ;不是则跳转
	b @@BoostCheck
@@MorphChecks: ;球形态检查
	ldrb r0,[r2]	;loads current pose 得到当前的姿势
	cmp r0,31h	;checks if getting hurt in morphball 检查球形态受伤姿势
	beq @@NormalLand
	cmp r0,32h	;checks if knocked back while in morphball 检查球形态受创反弹姿势
	beq @@NormalLand
	mov r0,0h
	strb r0,[r1]  ;清空3007e28的值？
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
	;b @@SpeedReset	多余代码
@@SpeedReset:		;overwritten instructions that store 0 to speed related 与速度有关的都写入0
	mov r0,0h	;offsets. Skipped when keeping speed
	strh r0,[r2,16h]   ;30013ea X轴动量为0
	strb r0,[r2,5h]    ;30013d9 金身失去
	strb r0,[r2,2h]	   ;30013d6 炮口方向变成前
	strb r0,[r2,0Ah]   ;30013de 速度助推时间为0
@@ResetNormal:		;overwritten instructions that store 0, always read 总是读
	mov r0,0h	
	strh r0,[r2,0Ch]   ;30013e0 
	strh r0,[r2,10h]   ;30013e4 电梯上下？？？？？
	strh r0,[r2,18h]   ;30013ec 垂直动量
	strb r0,[r2,1Ch]   ;30013f0 动画计数器 人物？
	strb r0,[r2,1Dh]   ;30013f1 动画状态
	;mov r0,0h            多余代码
	strb r0,[r2,4h]    ;30013e8 垂直定位
	strb r0,[r2,7h]    ;30013eb
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
.close