.gba
.open "zm.gba","control_switch.gba",0x8000000
;按钮3e控制5a 62门开关.保证要有3d吊索存在
;Not perfect, ensure Sprite 3D 3E in one room.
.definelabel unusedRAM,3007eb0h
;.definelabel unusedRAM,0x3001610
;.definelabel checkevent,0x80608bc
.definelabel checksprite,80107F8h
 
.org 801D836h	;按钮始终出现
	b 801D844h

;.org 801d850h
   ; bl 801D808h
   ; b 801D86Ch
	
;.org 801d87ah
    ;bl 801D808h
    ;b 0801D886h
	
;.org 801d776h
    ;b 801D77Eh	
		
;.org 801d48eh
   ; nop
.org 801d482h
    .halfword 0xe005
.org 801d57ch
    .halfword 0xe005
.org 801d6aeh
    .halfword 0xe004
.org 801d772h
    .halfword 0xe004
.org 801d84ch
    .halfword 0xe004	;传送开启无需事件
///////////////////////////////////////   
.org 802ebc2h
    bl general
.org 802ecdah
    bl general
.org 802ec6ah
    bl general          ;5a门劫持
///////////////////////////////////////	
.org 802ed82h
    bl general
.org 802ee26h
    bl general
.org 802ee5eh 
    bl general	        ;62门劫持
/////////////////////////////////////////
.org 802ece2h
    bl endwrite    ;5a门确认非关后的eor3
.org 802ed04h
    bl endwrite2   ;5a门确认关闭后的eor3
/////////////////////////////////////////	
.org 801D914h	
    bl checkswitch

.org 801d8b2h
    bl make
	
;.org 801d906h
   ; bl pose
.org 802eceeh
    bl time
	
.org 8304054h
checkswitch:       ;检查传送停止的例程
    push r0-r1,lr
    mov r0,5ah
    bl checksprite    ;检查是否有弹簧门                           
    lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	beq @@nohave
    mov r0,62h
    bl checksprite    ;检查是否有弹簧门                            
    lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	beq @@nohave	
    ldr r0,=unusedRAM
    ldrb r0,[r0]
	cmp r0,4h         ;判断是否是4,也就是门已经关闭
	bne @@nofour
	pop r0-r1
	mov r0,1h 	
	strh r0,[r0,14h]
	b @@end
@@nofour:             ;判断是否是3
    cmp r0,3h
	bne @@nothree
	ldr r0,=unusedRAM
	mov r1,0h
	strb r1,[r0]      ;是3写入0
	pop r0-r1
	mov r0,1h
	strh r0,[r0,14h]
	b @@end
@@nothree:	
    pop r0-r1	          ;不是的话则不结束
	b @@end
@@nohave:
    pop r0-r1
    add r0,r0,r2 
    ldrh r0,[r0,14h]
@@end:	
	pop r14
.pool

make:
    push r0-r2,lr       ;确认击打
	mov r0,5ah
    bl checksprite      ;判断是否有弹簧门,来决策是否给内存写入数值
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	bne @@have
	b @@nohave
@@have:
	mov r0,62h
    bl checksprite      ;判断是否有弹簧门,来决策是否给内存写入数值
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	beq @@nohave
    ldr r0,=unusedRAM
	ldrb r2,[r0]
	cmp r2,0h
	bne @@writezero
	mov r1,7h
	strb r1,[r0]	   ;是0写入7
    b @@nohave
@@writezero:	       ;非0写入0
	mov r1,0h
	strb r1,[r0]	
@@nohave:	
	pop r0-r2	                            
    mov r4,1h
	ldr r0,=111h
    pop r14	
.pool

;pose:
    ;push lr
	;mov r0,3dh
   ; bl checksprite      ;判断是否有传送
	;lsl r0,r0,18h                               
   ; lsr r0,r0,18h                               
   ; cmp r0,0FFh  
	;bne @@have
	;mov r0,1h
;	b @@end
;@@have:	
   ; ldr r0,=3000738h
	;add r0,2Dh
;@@end:
  ;  pop r14	
;.pool

general:               ;判断房间中有按钮则警报失效
    push r1,lr
    mov r0,3eh         
    bl checksprite
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh
    bne @@have	
	ldr r0,=30001a8h
	ldrh r0,[r0]
    b @@end	
@@have:
    ldr r1,=unusedRAM
	ldrb r0,[r1]
@@end:
    pop r1
	pop r14	
.pool

time:               ;有按钮情况下,减少门返回默认状态的周期
    push r1,lr
	mov r1,r0
	mov r0,3eh
    bl checksprite      
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	bne @@have
    mov r0,r1	
    lsr r0,r0,18h   
	cmp r0,28h 
    b @@end
@@have:
    mov r0,r1
    lsr r0,r0,18h
    cmp r0,1h	
@@end:
    pop r1
    pop r14	
.pool

endwrite:
    push r1-r2,lr       ;确认房间中有按钮
    mov r0,3eh         
    bl checksprite
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh
    beq @@nohave
    ldr r0,=unusedRAM
    ldrb r1,[r0]
    cmp r1,7h
	beq @@sevenandzero
	cmp r1,0h
    bne @@nohave
@@sevenandzero:
    mov r2,3h
    eor r1,r2
	strb r1,[r0]
@@nohave:
    pop r1-r2	
    ldr r1,=3000738h
	add r1,2fh
    pop r14
.pool

endwrite2:
    push r1-r2,lr       ;确认房间中有按钮
    mov r0,3eh         
    bl checksprite
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh
    beq @@nohave
    ldr r0,=unusedRAM
    ldrb r1,[r0]
    cmp r1,7h
	beq @@sevenandzero
	cmp r1,0h
    bne @@nohave
@@sevenandzero:
    mov r2,3h
    eor r1,r2
	strb r1,[r0]
@@nohave:
    pop r1-r2	
    ldr r0,=3000738h
    add r0,2fh
    pop r14	
	
;未使用内存的变化情况

;击打开关,判定是否是0,如果是0则写入7

;如果不是0,则写入0

;门给予的数

;判定是否是7,如果是7则eor3
;如果不是7,则跳过

;开关结束判定,判定是否是4,如果是4则结束
;如果不是4则继续
.pool	
.close