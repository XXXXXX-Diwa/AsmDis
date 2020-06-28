.gba
.open "ZM.gba","PistonFix.gba",0x8000000

.definelabel ClipdataRelated,8057E7Ch
.definelabel MainFourBlock,8031708h
.definelabel SpriteData,0x30001AC
.definelabel CurrSprite,0x3000738
.definelabel PlaySound,8002A18h
.definelabel SpriteAiStart,875e8c0h
.definelabel PistonID,0x60
.definelabel CheckAnimation,800FBC8h
.definelabel CurrClipdataAffectingAction,3000079h
.definelabel SamusData,0x30013D4
.definelabel SpriteGfxPointers,0x875EBF8   
;精灵60升起架,可以回落,而且如果下方有砖块或者敌人则无法回落.

.org SpriteAiStart + ( PistonID * 4 )
   .word PistonMainprogram + 1   ;主程序地址
   
.org 0x82E85F0  
   .align
PistonGfx:
   .import "Piston.gfx.lz"       ;导入最上面扁平的图
   
.org 82E8D0Ch   ;上升OAM的帧数减少
   .byte 02h
   
.org 82E8D14h
   .byte 02h

.org 82E8D1Ch
   .byte 02h

.org 82E8D24h
   .byte 02h

.org 82E8D2Ch
   .byte 02h

.org 82E8D34h
   .byte 02h

.org 82E8D3Ch
   .byte 02h

.org 82E8D44h
  .byte 02h   

  
	
;.org 8031830h          ;PistonPose 0和PistonPose 8合并以及增加判断
.org 803175ch           ;AI的原地址利用
PistonMakedownblock:
     push lr
	 mov r3,r0
	 ldrh r0,[r4,2h]
	 ldrh r1,[r4,4h]
	 ldr r2,=CurrClipdataAffectingAction
	 strb r3,[r2]
	 sub r0,20h
	 bl ClipdataRelated        ;生产底部砖块
	 pop r15
.pool

PistonPose0:
    push lr
    ldr r4,=CurrSprite
	mov r5,r4
    add r5,20h
	mov r0,64h
	strb r0,[r5,7h]     ;75F写入64h
	mov r0,0h
	strb r0,[r5,8h]     ;760写入0
	mov r0,18h
	strb r0,[r5,9h]     ;761写入18h
	ldr r1,=0FFDEh
	strh r1,[r4,0Eh]    ;左部分界写入FFDE
	mov r0,20h
	strh r0,[r4,10h]    ;右部分界写入20h
	mov r0,32h
	strh r0,[r4,6h]     ;再生Y坐标写入32,回落计时
	mov r0,80h
	lsl r0,6
	strh r0,[r4,14h]    ;血量写入2000h
	ldr r1,=3000088h
	ldrb r2,[r1,0Ch]    ;3000094的值 and 3  不懂何意
	mov r0,3h
	and r0,r2
	strb r0,[r5,1h]     ;值给759h
	mov r0,4h
	bl MainFourBlock    ;制造基础的4个砖块
	mov r6,1h
    bl PistonCheckUpOrDownBlock  ;检查下方是否有砖块
	cmp r0,0h
	bne @@StartUp
	bl PistonCheckSpriteCoincide ;检查人物或其它精灵是否在下面
	cmp r0,0h
	bne @@StartUp          ;有的话则开始给予上升的PistonPose
	mov r0,4h
	bl PistonMakedownblock    ;如果下方无砖则制作底部砖意为落下
	mov r5,0h
	ldr r2,=82E8CE0h    ;已经落下的OAM
	ldr r1,=0FF8Ch
	strh r1,[r4,0Ah]    ;击打关节的上部分界 
	add r1,8h
	strh r1,[r4,0Ch]    ;击打关节的下部分界
	mov r1,8h
    b @@Write 
.pool  	
@@StartUp:
;	strh r0,[r4,10h]
	mov r5,1h
	mov r1,11h
    ldr r2,=82E8D50h    ;已经升起的OAM
	ldr r3,=0FE7Eh     
	strh r3,[r4,0Ah]    ;上部分界
	mov r0,50h
	lsl r0,2h
	add r3,r0           ;向下延伸5格
	strh r3,[r4,0Ch]
@@Write:
    ldr r4,=CurrSprite	;写入数据
    mov r0,r4
	add r0,24h
	strb r1,[r0]        
	strb r5,[r0,1h]
	str r2,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
	pop r15
.pool
	
PistonPose8:                 ;完全下落
    push r4-r6,lr
	ldr r4,=CurrSprite
	mov r2,r4            
	add r2,2Bh
	ldrb r0,[r2]       ;读取无敌时间
	mov r1,7Fh
	and r1,r0          ;7F and
	cmp r1,10h
	bne @@end          ;无无敌结束
	mov r1,80h
	and r0,r1          ;无敌时间清零
	strb r0,[r2]       ;再写入
	lsl r1,6
	strh r1,[r4,14h]   ;血量写入2000h
	mov r6,0h
	bl PistonCheckUpOrDownBlock  ;检查上方
	cmp r0,0h
	bne @@end          ;如果上方有砖则结束
	ldr r1,=82e8d08h       
	str r1,[r4,18h]    ;写入新的OAM
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
	mov r2,r4
	add r2,24h        
	mov r0,9h          ;PistonPose写入9 
	strb r0,[r2]
	mov r0,1h
	strb r0,[r2,1h]    ;属性写入1h
	ldrh r0,[r4]
	lsl r6,4h          ;取向orr8000h 变得无敌
	orr r6,r0
	strh r0,[r4]
	ldr r1,=0FEBEh     
	strh r1,[r4,0Ah]   ;判定变大
	mov r0,50h
	lsl r0,2h
	add r1,r0          ;向下延伸5格
	strh r1,[r4,0Ch]
	ldr r0,=173h       ;播放上升的声音
	bl PlaySound
@@end:
    pop r4-r6
    pop r15	
.pool

PistonPose9:                   ;上升过程
    push r4,lr
	mov r0,1h
	bl PistonMakedownblock     ;消灭底部砖
	ldr r4,=CurrSprite
	mov r5,0h
	ldrh r2,[r4,16h]
    cmp r2,3h
    bhi @@Pass	
	ldrb r2,[r4,1Ch]
	cmp r2,1h
	bne @@Pass
	ldrh r1,[r4,0Ah]
	sub r1,10h
	strh r1,[r4,0Ah]
	mov r0,50h
	lsl r0,2h
	add r1,r0
	strh r1,[r4,0Ch]
@@Pass:
    bl CheckAnimation
    cmp r0,0h           ;检查动画是否结束
	beq @@end
	ldr r2,=82E8D50h    ;写入完全上升PistonPose的OAM
	str r2,[r4,18h]
	strh r5,[r4,16h]
	strb r5,[r4,1Ch]
	mov r0,r4
	add r0,24h
	mov r1,11h          ;写入PistonPose11
	strb r1,[r0]
@@end:
    pop r4
    pop r15	
.pool

   	
PistonPose11:                ;完全升顶
    push r4,r5,lr
	ldr r4,=CurrSprite	
	mov r1,80h
	lsl r1,8h
	ldrh r0,[r4]
    orr r1,r0
	strh r1,[r4]       ;取向写入无敌
	ldrh r0,[r4,6h]
	sub r0,1h
	strh r0,[r4,6h]
	lsl r0,18
	lsr r0,18
	cmp r0,0h
	bne @@end
	mov r6,1h
    bl PistonCheckUpOrDownBlock 	 ;检查下面是否有砖块
	cmp r0,0h
	bne @@end
	bl PistonCheckSpriteCoincide
	cmp r0,0h
    beq @@Down
	mov r1,0Fh               ;如果下方有物则判定下落计时再次写入F
	strh r1,[r4,6h]
	b @@end
@@Down:	
    mov r0,r4
    add r0,24h
	mov r1,13h
	strb r1,[r0]
	ldr r1,=PistonDownActionOAM
	str r1,[r4,18h]
	mov r0,0h
	strh r0,[r4,16h]
	strb r0,[r4,1Ch]
	mov r0,32h
	strh r0,[r4,6h]      ;重新写入下落的计时
@@end:
    pop r4,r5
    pop r15	
.pool
	

PistonPose13:                  ;下落过程
    push r4,lr
	ldr r4,=CurrSprite
    ldrh r5,[r4,16h]
	cmp r5,4h            ;检查下落的第一帧
	bcc @@end            ;动画小于4h跳过
	ldrb r6,[r4,1Ch]
	cmp r6,1h            ;动画帧不为1跳过
	bne @@CheckSound
	ldrh r1,[r4,0Ah]     ;上部分界下移10h
	add r1,10h
	strh r1,[r4,0Ah]     ;再写入
	mov r0,50h
	lsl r0,2h
	add r1,r0
	strh r1,[r4,0Ch]	 ;上部分界下5格写入下部分界
	bl PistonCheckSpriteCoincide
	cmp r1,19h
	bne @@CheckSound
	mov r0,0Dh
	mov r2,r4
	add r2,25h
	strb r0,[r2]
@@CheckSound:
    cmp r5,4h            ;动画不为4跳过
	bne @@CheckActivetion
	cmp r6,2h            ;动画帧不为2跳过
	bne @@end
	ldr r0,=173h
    bl PlaySound          ;播放音乐
    b @@end
@@CheckActivetion:	
    bl CheckAnimation
    cmp r0,0h
	beq @@end
    mov r0,r4
	add r0,31h
	ldrb r0,[r0]
	cmp r0,0h            ;如果人物在精灵上则继续循环
	bne @@Loop
	ldr r0,=0FF8Ch       
	strh r0,[r4,0Ah]     ;再次写入击打关节的判定
	add r0,8h
	strh r0,[r4,0Ch]     ;同样下部分界也是
	ldr r2,=82E8CE0h
	str r2,[r4,18h]      ;写入完全下降的OAM
	mov r3,0h
	strh r3,[r4,16h]
	strb r3,[r4,1Ch]
	;ldr r1,=0F7FFh
    ldr r2,=07FFFh		
	ldrh r0,[r4]
	;and r1,r0
	and r2,r0            ;去除取向的无敌
	strh r2,[r4]
	mov r0,r4
	add r0,24h
	mov r1,8h
	strb r1,[r0]         ;PistonPose写入8
	strb r3,[r0,1h]      ;属性写入0h
	mov r0,4h
	bl PistonMakedownblock     ;制造底部砖
    b @@end	
.pool	
@@Loop:
    mov r0,2h
    strb r0,[r4,1Ch]     ;动画帧持续2	
@@end:
    pop r4
    pop r15
.pool

PistonMainprogram:
    push r4-r7,lr      ;主程序push关键寄存器
    ldr r4,=CurrSprite
	mov r5,r4
	add r5,20h
	ldrb r0,[r5,4h]
	cmp r0,0h
	beq @@PistonPose0Address
	cmp r0,8h
	beq @@PistonPose8Address
	cmp r0,9h
	beq @@PistonPose9Address
	cmp r0,11h
	beq @@PistonPose11Address
	cmp r0,13h
	beq @@PistonPose13Address
	b @@end
.pool	
@@PistonPose0Address:
    bl PistonPose0
    b @@end
@@PistonPose8Address:	
    bl PistonPose8
    b @@end
@@PistonPose9Address:	
    bl PistonPose9
	b @@end
@@PistonPose11Address:	
	bl PistonPose11
	b @@end
@@PistonPose13Address:	
	bl PistonPose13
@@end:	
    pop r4-r7          ;主程序pop关键寄存器
    pop r15	 	
	
.pool    

PistonCheckUpOrDownBlock:    ;检查上或下是否有砖块
    push r4-r7,lr		
	ldrh r2,[r4,2h]    ;读取Y坐标
	cmp r6,0h          ;0为检查上部 1为检查下部
	bne @@Noup
	ldr r0,=140h
	sub r2,r0          ;Y坐标高度向上提升5格
@@Noup:	
	ldrh r1,[r4,4h]    ;读取X坐标
	sub r2,20h       
	lsr r2,6h          ;得到确切高度格数	
	lsr r1,6h          ;得到水平格数
	ldr r3,=30000b0h
	ldrh r0,[r3,8h]    ;得到房间宽度
	mul r2,r0          ;高乘宽
	add r2,r1          ;加水平格数
	lsl r2,1h          ;乘以2
	ldr r0,[r3,4h]     ;得到Cilp指针
	add r0,r2           
	ldrb r0,[r0]       ;得到精灵处的Cilp序号
	cmp r0,0h
	beq @@equalAir
	cmp r0,1Bh         ;水
    beq @@equalAir
    cmp r0,0A0h        ;酸
    beq @@equalAir
    cmp r0,0A1h
	beq @@equalAir
	cmp r0,0A2h
	beq @@equalAir
    cmp r0,5Ch
    bcc @@NormalTime
    cmp r0,5Fh
    bls @@addDownTime
    cmp r0,6Ch
	bcc @@NormalTime
    cmp r0,6Fh
    bls @@addDownTime
	cmp r0,7Ch
	bcc @@NormalTime
    cmp r0,7Fh
    bhi @@NormalTime
@@addDownTime:
    cmp r6,0h
	beq @@NormalTime   ;如果检查的是上部则写入正常回落时间
    mov r1,0FFh
	strb r1,[r4,6h]    ;如果是道具在下面则回落时间写入FF
	b @@HaveBlock
@@NormalTime:
    mov r1,64h         ;正常情况下的回落时间
    strb r1,[r4,6h]
@@HaveBlock:	
	mov r0,1h
	b @@end
@@equalAir:	
	mov r0,0h          ;是液体等都等同空气算
@@end:
    pop r4-r7
    pop r15	
.pool	

.org 8304054h
PistonCheckSpriteCoincide:   ;检查是否有精灵在下面 
    push r4-r7,lr
	ldr r3,=SamusData
	ldrh r1,[r3,14h]   ;得到人物Y坐标
    ldrh r2,[r3,12h]   ;得到人物X坐标
	bl PistonCheckObs        ;检查人物是否和精灵下部相交
	cmp r0,1h	
	beq @@SamusAtDown  ;如果下部有人r1返回19 
	mov r5,r4
	add r5,20h
	ldrb r3,[r5,3h]    ;得到当前精灵主序号
	lsl r3,18h
	ldr r4,=SpriteData
	mov r5,0h 
@@loop:	
    ldrh r0,[r4]
	cmp r0,0h
	beq @@pass         ;死去的精灵跳过
	mov r0,r4                   
	add r0,23h
	ldrb r0,[r0]       ;得到精灵序号
	lsl r0,18h
	cmp r0,r3          ;和当前精灵序号相比
	beq @@pass         ;相等则跳过
	ldrh r1,[r4,2h]    ;获取精灵Y坐标
	ldrh r2,[r4,4h]    ;获取精灵X坐标
	bl PistonCheckObs        ;检查精灵是否相交
	cmp r0,0h          
	bne @@end          ;相交的话结束返回非0
@@pass:	
	add r5,1h          ;循环累计值加1
	add r4,38h         ;精灵数据起始加38h
	cmp r5,17h         ;比较当前的累计值
	bls @@loop         ;小于等于继续循环
	mov r0,0h          ;循环到最后都没有则直接返回0	
	b @@end
@@SamusAtDown:
    mov r1,19h	       ;标记Samus在下面
@@end:
    pop r4-r7
	pop r15
.pool  	 		

	
	
PistonCheckObs:             ;检查范围
    push lr 
	ldr r4,=CurrSprite
    mov r0,0h
    ldrh r6,[r4,2h]   ;读取精灵Y坐标
	ldrh r7,[r4,4h]	  
	sub r6,30h
	cmp r6,r1
	bge @@end        ;精灵坐标向上30h和人物坐标比,大于或等也就是仍在下
	add r6,60h       
	cmp r6,r1
	ble @@end        ;精灵坐标向下30h和人物坐标比,小于或等也就是仍在上
	sub r7,30h       
	cmp r7,r2        
	bge @@end        ;精灵坐标向左30h和人物坐标比,大于或等也就是仍在右
	add r7,60h
	cmp r7,r2
	ble @@end        ;精灵坐标向右30h和人物坐标比,小于或等也就是仍在左
	mov r0,1h
@@end:	
	pop r15
.pool   

.org 8760d38h


.align
PistonDownActionOAM:          ;下落的OAM,把原本上升的OAM倒叙
    .word 82e8c34h      ;节点恢复红亮色
    .word 3
    .word 82e8bdeh      ;节点红亮色变
    .word 3
	.word 82e8b88h      ;节点红亮色变
	.word 3
	.word 82e8b32h      ;正常升起的高度
	.word 3
    ;.word 82e8c8ah      ;节点暗
	;.word 3
	.word 82e8a92h      ;下落4分之一
	.word 3
	;.word 82e8adch     ;向上一点的动作
	;.word 3	
	.word 82e8a48h      ;再次下落4分之一
	.word 3
	.word 82e89feh      ;再次下落4分之一
	.word 3  	
    .word 82e88dch      ;完全下落
    .word 3	
	.word 00000000h
	.word 00000000h
.pool	
.close