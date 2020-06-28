.gba
.open "zm.gba","Frozen_Falling.gba",0x8000000

.definelabel SpriteSlot0,0x30001AC     ;精灵串0
.definelabel CurrSpriteData,0x3000738  ;当前敌人数据
.definelabel AccelRAM,0x3001610			;未使用内存用于下落加速

.definelabel GiveTopOfBlock,0x800F47C  
.definelabel CheckClip,0x800F688


.org 0x8010046						;hijack in main "frozen" function 
	bl	Frozen_Falling

.org 0x8304054			            ;Crocomire graphics
Frozen_Falling:
	push	r5-r7,r14
	add		sp,-4h
	mov		r0,r3 
	add		r0,30h
	ldrb	r0,[r0]					;得到3000768的值,查看冰冻时间是否为0
	cmp		r0,0h
	beq		@@Zero
	bl		CheckIfExcluded			;检查是否是设定了禁止下落的敌人
	cmp		r0,0h
	bne		@@Return                ;不是0就结束
	ldrh	r0,[r3,4h]				;sprite X
	ldrh	r1,[r3,2h]				;sprite Y
	ldrh	r2,[r3,0Ch]				;3000744 敌人下部分界
	add		r4,r1,r2				;得到敌人最下面的坐标
	mov 	r2,0Eh
	ldsh	r2,[r3,r2]	            ;FFFF+左部分界
	neg		r2,r2                   ;取反
	sub		r5,r0,r2				;最左坐标
	ldrh	r2,[r3,10h]				;得到右部分界
	add		r6,r0,r2				;最右坐标
	mov		r0,r4
	mov		r1,r5					;r0为下部,r1为左部,r6为右部
	bl		CheckClip               ;检查精灵是否在地板上 检查下左?
	ldr     r7,=30007F1h 
	ldrb	r0,[r7]                 
	cmp		r0,0h					;砖块与敌人左右碰撞则错
	bne		@@Zero
@@Loop:								;loop ensures all blocks under sprite are checked, regardless of sprite size
	add		r5,40h					;one block 
	mov		r1,r5
	cmp		r1,r6                   ;反复叠加加长的砖块尺寸大于最右坐标才能跳出循环继续执行
	blt		@@Continue	            
	mov		r1,r6					;rightmost position
	mov		r0,r4
	bl		CheckClip               ;检查下右是否碰触地面?
	ldrb	r0,[r7]
	cmp		r0,0h					;false if block is under sprite
	bne		@@Zero
	b		@@Accelerate
@@Continue:
	mov		r0,r4
	bl		CheckClip               ;从左边每一格都检查,是否有砖块在下面
	ldrb	r0,[r7]
	cmp		r0,0h					;false if block is under sprite
	bne		@@Zero
	b		@@Loop		
@@Accelerate: 
	ldr		r1,=CurrSpriteData
	ldrh	r0,[r1,4h]              ;得到精灵x坐标
	mov		r2,0Eh
	ldsh	r2,[r1,r2]              ;得到精灵FFFF+左部分界
	neg		r2,r2                   ;取反
	sub 	r5,r0,r2				;最左坐标
	ldrb	r0,[r1,1Eh]				;精灵串序号?
	ldr		r1,=AccelRAM
	add		r1,r0,r1                ;精灵串序号加上内存
	ldrb	r0,[r1]                 ;读取数值
	cmp		r0,24h					;max accel speed 最大加速
	bcs		@@FloorCheck            ;大于等于24跳转
	add		r0,1h                   ;每帧加1
	strb	r0,[r1]
@@FloorCheck:
	lsr		r0,r0,1h                ;除以2
	str		r0,[sp]                 ;写入内存
	add		r4,r0,r4                ;最下部坐标加下落速度
@@Loop2:
	mov		r0,r4					;loop ensures all blocks under sprite are checked, regardless of sprite size
	mov		r1,r5
	bl		GiveTopOfBlock			;function returns the Y position of the top of the block under sprite4 
	ldr		r7,=30007F0h            ;函数返回砖块顶Y坐标精灵下??
	ldrb	r1,[r7]
	cmp		r1,0h                   ;不为0则当前在最顶部
	bne		@@StoreOnTop		
	add		r5,40h					;one block 最左坐标反复叠加砖块的距离
	mov		r1,r5
	cmp		r1,r6                   ;最左坐标叠加值大于最右坐标则跳出循环???
	blt		@@Loop2
	mov		r0,r4
	mov		r1,r6
	bl		GiveTopOfBlock			;最后检查一次最下部坐标加下落速度与最右坐标是否碰撞clip?
	ldrb	r1,[r7]
	cmp		r1,0h
	bne		@@StoreOnTop            ;如果碰撞则跳转
	b		@@Fall                  ;不碰撞则下落
@@StoreOnTop:
	ldr		r2,=CurrSpriteData
	ldrh	r1,[r2,0Ch]             ;底部分界
	sub		r0,r0,r1				;最下部坐标加下落速度坐标减底部分界???
	strh	r0,[r2,2h]              ;写入新的Y坐标
	b		@@Return
@@Fall:
	ldr		r0,[sp]
	ldr		r1,=CurrSpriteData
	ldrh	r2,[r1,2h]              ;得到当前的Y坐标
	add		r0,r0,r2                ;加上内存记录的加速度
	strh	r0,[r1,2h]			    ;写入基于加速度的Y坐标
	b 		@@Return	
@@Zero:
	ldr		r3,=CurrSpriteData			;resetting acceleration
	ldrb	r0,[r3,1Eh]
	ldr		r1,=AccelRAM                 
	add		r0,r0,r1
	mov		r1,0h
	strb	r1,[r0]                   ;加速度写入0
@@Return:
	add		sp,4h
	pop		r5-r7
	pop		r1
	pop		r4
	pop		r0	
	bx		r1
.pool	
	
CheckIfExcluded:		
	mov		r0,r3
	add		r0,32h						;collision properties 
	ldrb	r0,[r0]                  ;得到300076a
	mov		r1,80h						;true if secondary sprite
	and		r0,r1
	cmp		r0,0h                    ;如果是80则不等于0,就是第二种敌人
	bne		@@Excluded               
	ldr		r4,=ExcludedTable
	ldrb	r1,[r3,1Dh]					;sprite ID
	mov		r2,0h
@@Loop:
	add		r0,r2,r4             ;序号加30416ch      
	ldrb	r0,[r0]              ;得到table的ID
	cmp		r0,r1                ;与当前ID比较
	beq		@@Excluded           ;如果为真则排除
	cmp		r2,0h			     ;这个值为排除在外的敌人数量-1
	bcs		@@NotExcluded        ;r2>0成立
	add		r2,1h
	b		@@Loop
.pool
@@Excluded:
	mov		r0,1h
	b		@@Return
@@NotExcluded:
	mov		r0,0h
@@Return:
	bx		r14
	
ExcludedTable:
	.byte	0x13,0x14,0x12							;add excluded sprite IDs here
.close