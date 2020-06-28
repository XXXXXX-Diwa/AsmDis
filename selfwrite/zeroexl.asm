.gba
.open "zm.gba","zeroexl.gba",0x8000000

.definelabel RoomWidth,0x30000B8
.definelabel SuitType,0x3001542
.definelabel DecompClipdata,0x2027800
.definelabel ElevatorUpSpeed,0x8007464
.definelabel ElevatorDownSpeed,0x8007478

.org 80075a8h
    bl PoseIf1D             ;检查姿势是1D
	
.org 8028796h
    bl ElevatorSpeed	    ;电梯精灵控制人物的移动
	nop
	nop
	
.org 8304054h
PoseIf1D:
    cmp r4,1dh              ;检查姿势是1D
    bne @@return            ;不是的话结束
	ldrb r0,[r3,1ah]        ;检查服装是否是2
	cmp r0,2h
	bne @@return            ;不是的话结束
	mov r4,1eh              ;是的话姿势改写成1eh
@@return:
    strb r4,[r5]
    mov r0,r5
    bx r14	
.pool	

ElevatorSpeed:
    push r2-r4,lr
	ldr r4,=ElevatorUpSpeed
	ldr r2,=SuitType       
	ldrb r2,[r2]            ;检测当前服装是否为2
	cmp r2,2h
	bne @@NomberWrite            ;不是的话结束
	ldrh r2,[r1]            ;读取当前姿势
	cmp r2,1fh              ;不是1F的话
	bne @@CheckPose1E       ;检查姿势是否1eh
	mov r0,10h              ;是的话
	strb r0,[r3,12h]        ;300074a写入10h
@@CheckPose1E:
    cmp r2,1eh              ;比较姿势是否是1eh
	bne @@return            ;不是的话结束
    ldrb r2,[r3,12h]        ;读取300074a的值
	cmp r2,0h               ;为0的话结束
	beq @@return
	cmp r2,10h              ;不为10
	bne @@CheckNumberChange ;检查数字改变
	bl CheckBottomClip      ;检查脚底的砖块clip
	cmp r0,29h
	bne @@CheckClip2A       ;不是29检查是否是2ah
	mov r2,13h              ;如果是29则写入13h
	strb r2,[r3,12h]
	b @@CheckNumberChange   ;检查数字改变
@@CheckClip2A:
    cmp r0,2Ah             
    bne @@return            ;也不是2a的话则结束
	mov r2,14h              ;是2a写入14h
	strb r2,[r3,12h]
@@CheckNumberChange:
    bl CheckBottomClip      ;得到脚底砖块clip
	cmp r0,29h
	bne @@CheckDownClip     ;不是29的话检查是否是2a
    ldrb r2,[r3,12h]        ;是29的话检查是否是14
	cmp r2,14h
	bne @@AddUpSpeed        ;不是14则速度向上
    b @@WriteZero           ;是14则写入0
@@CheckDownClip
    cmp r0,2Ah            
    bne @@CheckUpDownNumber ;检查不是2a则检查是上是下
    ldrb r2,[r3,12h]        
    cmp r2,13h              ;是2a则检查是否不是13
    bne @@AddDownSpeed      ;不是13则速度向下
@@WriteZero:	            ;是13则写入0
	mov r2,0h
	strb r2,[r3,12h]
	b @@return
@@CheckUpDownNumber:        ;区分速度是上还是下
    cmp r2,14h
    beq @@AddDownSpeed      ;不是下就是上
@@AddUpSpeed:
    ldrb r0,[r4]
	b @@Count               ;重新设定坐标
@@AddDownSpeed:
    ldrh r0,[r4,14h]	
@@Count:	
	ldrh r4,[r1,14h]
	add r4,r0              ;人物Y坐标根据速度值移动
	strh r4,[r1,14h]
	ldrh r4,[r3,2h]        
	add r4,r0              ;精灵Y坐标根据速度值移动
	strh r4,[r3,2h]
@@NomberWrite:
    ldrh r0,[r1,14h]
    strh r0,[r3,2h]
	ldrh r0,[r1,12h]
	strh r0,[r3,4h]
@@return:
    pop r2-r4
    pop r14	
.pool	

CheckBottomClip:
    ldrh r0,[r1,14h] 	   ;读取人物Y坐标
	ldrh r2,[r3,2h]
	add r2,8h              ;获取精灵Y坐标
	cmp r0,r2              
	bne @@return           ;不等的话结束
	lsr r0,6h              ;Y坐标除以64得到高度格数
	ldr r2,=RoomWidth
	ldrh r2,[r2]           ;得到房间宽度格数
	mul r2,r0              ;高乘宽
	ldrh r0,[r1,12h]       ;得到人物X坐标
	lsr r0,6h              ;X坐标除以64得到宽度格数
	add r0,r2              ;加上当前之前高乘宽
	lsl r0,1h              ;结果乘以2
	ldr r2,=DecompClipdata
	add r0,r2              ;加上砖块clip偏移值
	ldrh r0,[r0]           ;得到当前脚下的砖块clip
	bx r14
	
.pool
.close
