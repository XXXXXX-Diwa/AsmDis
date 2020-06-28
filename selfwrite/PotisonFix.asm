.gba
.open "zm.gba","PistonFix.gba",0x8000000

.org SpriteAiStart +( PistonID * 4 ) 
   .word PistonMain + 1   ;主程序地址
   
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

  
	
;.org 8031830h          ;pose 0和pose 8合并以及增加判断
.org 803175ch
makedownblock:
     push lr
	 mov r3,r0
	 ldr r1,=3000738h
	 ldrh r0,[r1,2h]
	 ldrh r1,[r1,4h]
	 ldr r2,=3000079h
	 strb r3,[r2]
	 sub r0,20h
	 bl 8057e7ch
	 pop r15
.pool

Pose0:
    push lr
	ldr r4,=3000738h
	mov r0,r4
	add r0,27h          
	mov r1,64h
	strb r1,[r0]       ;300075f=64h
	mov r5,0h
	strb r5,[r0,1h]    ;3000060=0
	mov r1,18h
	strb r1,[r0,2h]    ;3000061=18h
	ldr r3,=0FFDFh
	strh r3,[r4,0eh]   ;左部分界写入FE8
	mov r1,20h
	strh r1,[r4,10h]   ;右部分界写入18h
	sub r0,21h      
	mov r2,32h          
	strh r2,[r0]       ;300073e写入32h 回落计时
	mov r1,80h
	lsl r1,1
	strh r1,[r4,14h]   ;血量写入100h
	ldr r1,=0f7ffh
	ldrh r2,[r4]       
	and r1,r2          ;取向去掉800h
	strh r1,[r4]
	ldr r1,=3000088h
	ldrb r2,[r1,0ch]
	mov r1,3h
	and r1,r2          ;3000094的值 and 3
    add r0,01Bh
	strb r1,[r0]       ;写入30000759h
    mov r0,4h
	bl 8031708h  	;制造基础的四个砖块
	mov r5,1h
	bl CheckUpFallObs  ;全方位检查下方
	cmp r0,0h
	bne @@DOWNHAVE
	mov r0,4h
	bl makedownblock        ;制底砖
	mov r5,0h
	mov r1,8h          
	ldr r2,=82E8CE0h   ;正常OAM
	ldr r3,=0FF8Ch
	strh r3,[r4,0Ah]
	add r3,8h
	strh r3,[r4,0Ch]
    b @@Write   	
@@DOWNHAVE:
	mov r5,1h
	mov r1,11h
    ldr r2,=82E8D50h   ;已经升起OAM
	ldr r3,=0FE7Eh     
	strh r3,[r4,0Ah]
	mov r0,50h
	lsl r0,2h
	add r3,r0          ;向下延伸5格
	strh r3,[r4,0Ch]
@@Write:               ;写入数据
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
	
Pose8:                 ;完全下落
    push r4-r6,lr
	ldr r4,=3000738h
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
	lsl r1,1
	strh r1,[r4,14h]   ;血量写入100h
	mov r5,0h
	bl CheckUpFallObs  ;全方位检查上方
	cmp r0,0h
	bne @@end          ;如果上方有砖或者敌人则结束
	ldr r1,=82e8d08h       
	str r1,[r4,18h]    ;写入新的OAM
	strh r5,[r4,16h]
	strb r5,[r4,1Ch]
	mov r2,r4
	add r2,24h        
	mov r0,9h          ;pose写入9 
	strb r0,[r2]
	mov r0,1h
	strb r0,[r2,1h]    ;属性写入1h
	ldrh r0,[r4]
	lsl r6,4h          ;取向orr8000h
	orr r6,r0
	strh r0,[r4]
	ldr r1,=0FEBEh     
	strh r1,[r4,0Ah]
	mov r0,50h
	lsl r0,2h
	add r1,r0          ;向下延伸5格
	strh r1,[r4,0Ch]
	ldr r0,=173h
	bl 8002A18h
@@end:
    pop r4-r6
    pop r15	
.pool

Pose9:                   ;上升过程
    push r4,lr
	mov r0,1h
	bl makedownblock          ;消灭底部砖
	ldr r4,=3000738h
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
    bl 800FBC8h
    cmp r0,0h
	beq @@end
	ldr r2,=82E8D50h    ;写入下一个pose的OAM
	str r2,[r4,18h]
	strh r5,[r4,16h]
	strb r5,[r4,1Ch]
	mov r0,r4
	add r0,24h
	mov r1,11h          ;写入pose11
	strb r1,[r0]
@@end:
    pop r4
    pop r15	
.pool

   	
Pose11:                ;完全升顶
    push r4,r5,lr
	ldr r4,=3000738h	
	mov r1,80h
	lsl r1,8h
	ldrh r0,[r4]
    orr r1,r0
	strh r1,[r4]
	ldrh r0,[r4,6h]
	sub r0,1h
	strh r0,[r4,6h]
	cmp r0,0h
	bne @@end
	mov r5,1h
    bl CheckUpFallObs 	 ;全方位检查下面
	cmp r0,0h
    beq @@Down
	mov r1,0fh
	strh r1,[r4,6h]
	cmp r0,5h
	bne @@end
	mov r0,80h
	lsl r0,2h
	strh r0,[r4,6]
	b @@end
@@Down:	
	mov r0,4h
	bl makedownblock          ;生产底部砖块
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
	strh r0,[r4,6h]
@@end:
    pop r4,r5
    pop r15	
.pool
	

Pose13:                  ;下落过程
    push r4,lr
	ldr r4,=3000738h
    ldrh r5,[r4,16h]
	cmp r5,4h
	bcc @@Pass
	ldrb r6,[r4,1Ch]
	cmp r6,1h
	bne @@Pass
	ldrh r1,[r4,0Ah]
	add r1,10h
	strh r1,[r4,0Ah]
	mov r0,50h
	lsl r0,2h
	add r1,r0
	strh r1,[r4,0Ch]	
    cmp r5,7h
	bne @@Pass	
	cmp r6,2h
	bne @@Pass2
	ldr r3,=0FF8Ch
	strh r3,[r4,0Ah]
	add r3,8h
	strh r3,[r4,0Ch]
@@Pass2:
	cmp r6,3h
	bne @@Pass
	mov r0,r4
	add r0,31h
	ldrb r0,[r0]
	cmp r0,0h
	beq @@Pass
	ldr r1,=30013d4h
	ldr r2,=141h
	ldrh r0,[r4,2h]
	sub r0,r2
	strh r0,[r1,14h]
@@Pass:
    cmp r5,5h
	bne @@Pass3
	cmp r6,1h
	bne @@Pass3
	ldr r0,=173h
    bl 8002a18h
@@Pass3:	
    bl 800FBC8h
    cmp r0,0h
	beq @@end
	ldr r2,=82E8CE0h
	str r2,[r4,18h]
	mov r5,0h
	strh r5,[r4,16h]
	strb r5,[r4,1Ch]
	;ldr r1,=0F7FFh
    ldr r2,=07FFFh		
	ldrh r0,[r4]
	;and r1,r0
	and r2,r1
	strh r2,[r4]
	mov r0,r4
	add r0,24h
	mov r1,8h
	strb r1,[r0]
	strb r5,[r0,1h]
@@end:
    pop r4
    pop r15
.pool

PistonMain:
    push r4-r6,lr      ;主程序push关键寄存器
    ldr r4,=3000738h
	mov r0,r4
	add r0,24h
	ldrb r0,[r0]
	cmp r0,0h
	beq @@Pose0Address
	cmp r0,8h
	beq @@Pose8Address
	cmp r0,9h
	beq @@Pose9Address
	cmp r0,11h
	beq @@Pose11Address
	cmp r0,13h
	beq @@Pose13Address
	b @@end
@@Pose0Address:
    bl Pose0
    b @@end
@@Pose8Address:	
    bl Pose8
    b @@end
@@Pose9Address:	
    bl Pose9
	b @@end
@@Pose11Address:	
	bl Pose11
	b @@end
@@Pose13Address:	
	bl Pose13
@@end:	
    pop r4-r6          ;主程序pop关键寄存器
    pop r15	 	
	
.pool    

;.org 8304054h
CheckUpFallObs:
    push r5-r7,lr	 
	ldrh r3,[r4,2h]    ;读取Y坐标
	cmp r5,0h
	bne @@Noup
	ldr r0,=140h
	sub r3,r0
@@Noup:	
	ldrh r6,[r4,4h]    ;读取X坐标
	sub r3,20h       
	lsr r3,6h          ;得到确切高度格数	
	lsr r6,6h          ;得到水平格数
	ldr r7,=30000b0h
	ldrh r0,[r7,8h]    ;得到房间宽度
	mul r3,r0          ;高乘宽
	add r3,r6          ;加水平格数
	lsl r3,1h          ;乘以2
	ldr r0,[r7,4h]     ;得到Cilp指针
	add r0,r3           
	ldrb r0,[r0]       ;得到精灵处的Cilp序号
    cmp r0,0h          
    bne @@ClipX          ;不为空气的话跳转
	ldr r6,=30013d4h
	ldrh r0,[r6,14h]
	ldrh r0,[r6,12h]
	bl CheckObs       ;检查人物是否在精灵处
	cmp r0,0h
	bne @@end          ;在的话跳转
	mov r7,r4          
	add r7,23h         
	ldrb r7,[r7]       ;得到精灵主序号
	lsl r7,18h
	ldr r3,=30001ach
	mov r2,0h 
@@loop:	
	mov r6,r3          
	add r6,23h
	ldrb r6,[r6]       ;得到精灵序号
	lsl r6,18h
	cmp r6,r7          ;和当前精灵序号相比
	beq @@pass         ;相等则跳过
	ldrh r0,[r3,2h]    ;获取精灵Y坐标
	ldrh r1,[r3,4h]    ;获取精灵X坐标
	mov r6,1h          ;检查下部标记
	bl CheckObs        ;检查是否在当前精灵处
	cmp r0,0h          
	bne @@end          ;在的话跳转
@@pass:	
	add r2,1h          ;循环累计值加1
	add r3,38h         ;精灵数据起始加38h
	cmp r2,17h         ;比较当前的累计值
	bls @@loop         ;小于等于继续循环
	mov r0,0h
	b @@end
@@ClipX:
    mov r0,5h	
@@end:
    pop r5-r7
	pop r15
.pool    	
    		
	
.org 8304054h	
CheckObs:
    mov r7,0h	
    ldrh r2,[r4,2h]
	cmp r5,0h
    bne @@Noup
    ldr r0,=140h
    sub r2,r0
@@Noup:	
	ldrh r3,[r4,4h]	
	sub r2,30h
	cmp r2,r0
	bge @@end
	add r2,60h
	cmp r2,r0
	ble @@end
	sub r3,30h
	cmp r3,r1
	bge @@end
	add r3,60h
	cmp r3,r1
	ble @@end
	mov r7,1h
@@end:	
	mov r0,r7
	bx r14
.pool   


PistonDownActionOAM:          ;下落的OAM,把原本上升的OAM倒叙
    .word 82e8c34h
    .word 3
    .word 82e8bdeh
    .word 3
	.word 82e8b88h
	.word 3
	.word 82e8b32h
	.word 3
	;.word 82e8adch     ;取消的动作
	;.word 3
	.word 82e8a92h
	.word 3
	.word 82e8a48h
	.word 3
	.word 82e89feh
	.word 3  	
    .word 82e88dch
    .word 3	
	.word 00000000h
	.word 00000000h
.pool	
.close