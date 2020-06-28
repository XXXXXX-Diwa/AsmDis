.gba
.open "zm.gba","verdoorfix.gba",0x8000000

;修复上下的门在出门的时候,X坐标与进门时并不对应的问题
;使用300550Ah这个游戏中未发现有用到的内存
.org 805eceeh			;将要写入门过渡Y高度差值处
	bl		addDoorTransitionXGap
	
.org 8056838h
	strh	r1,[r2,4h]	;原先固定归零4个字节
	;而又找不到游戏中有任何地方用过这个内存
	;故借用高2位
; .org 8056a80h			;纠正高度和归零Y高度差值处
	; bl		ZeroDoorTransitonXFix
.org 80568E2h			;写入出门X坐标处
	bl		DoorTransitionXFix
;以上满足了普通的门,事件门,但是却无法实现区门的X差值
.org 8056A6Eh
	b		8056A76h	;不检查是否是超过了4格高的门	

.org 805EEE8h			;区门的Y差值高度写入处
	bl		AreaDoorTransitionXFix
	
;基本上除了以坐电梯姿势经过区门,而区门还没有设定x偏移会有问题外,都解决了	

.org 8304054h			;无用的图片地址
addDoorTransitionXGap:	;把X差值也备份
	push	r1-r3
	sub		r2,2h		;得到300550Ah
	ldrb	r3,[r4,2h]	;得到进入的门的X起始格
	lsl		r3,r3,6h	;得到确切门最左的坐标
	ldrh	r1,[r1,12h]	;得到人物的X坐标
	sub		r1,r3		;人物坐标减去门最左
	strh	r1,[r2]		;备份到550Ah
	pop		r1-r3
	ldrh	r1,[r1,14h]
	sub		r0,r1		
	bx		r14
.pool	

DoorTransitionXFix:		
	push	r2,r3
	cmp		r0,0h		;检查出门X偏移是否为0
	bne		@@NoXFix
	ldr		r3,=300550Ah
	mov		r2,0h
	ldsh	r0,[r3,r2]
	strh	r2,[r3]		;归零
	b		@@end
	.pool
@@NoXFix:				;不为零还按原先的出门距离算
	add		r0,8h
	lsl		r0,r0,2h
@@end:
	pop		r2,r3
	bx		r14
.pool	
	
AreaDoorTransitionXFix:
	push	r0-r3
	sub		r0,2h		;得到300550Ah
	ldrb	r1,[r5,2h]	;得到进入的门的X起始格
	lsl		r1,r1,6h	;得到确切的门最左坐标
	ldrh	r3,[r2,12h]	;得到人物的X坐标
	sub		r3,r1		;人物X坐标减去门最左
	strh	r3,[r0]		;备份到550Ah
	pop		r0-r3
	ldrh	r2,[r2,14h]
	sub		r1,r2
	bx		r14
.pool		




.close
