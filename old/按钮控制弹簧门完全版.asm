.gba
.open "zm.gba","control_switch.gba",0x8000000
;按钮3e控制5a,62门开关.无需3D存在
;use sprite 3e control sprite 5a,62
.definelabel unusedRAM,3007eb0h
.definelabel checksprite,80107F8h
 
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

.org 801D82Ah
    mov r0,0h
    b 801d844h	        ;按钮出现无需传送
   
.org 802ebc2h
    bl general
.org 802ecdah
    bl general
.org 802ec6ah
    bl general
	
.org 802ed82h
    bl general
.org 802ee26h
    bl general
.org 802ee5eh 
    bl general	   
	
.org 802eceeh
    bl time

.org 801d8aeh
    bl Buttonstart
	
.org 801D914h
    bl Buttonend	
   	
.org 8304054h
Buttonend:
    push r0-r2,lr
	mov r0,5ah
    bl checksprite      ;判断是否有弹簧门,来决策是否给内存写入数值
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	bne @@have
	mov r0,62h
    bl checksprite      ;判断是否有弹簧门,来决策是否给内存写入数值
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh
    beq @@nohave
@@have:	
    pop r0-r2
    ldr r2,=unusedRAM
	ldrb r1,[r2,1h]
	sub r1,1h
	strb r1,[r2,1h]
	mov r0,1h
    cmp r1,0h	
	beq @@end
    mov r0,2h
	b @@end
@@nohave:	
	pop r0-r2
    add r0,r0,r2	
    ldrh r0,[r0,14h]
@@end:
    pop r14	
.pool	   		
	
Buttonstart:
    push r0-r2,lr
	mov r0,5ah
    bl checksprite      ;判断是否有弹簧门,来决策是否给内存写入数值
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	bne @@have
	mov r0,62h
    bl checksprite      ;判断是否有弹簧门,来决策是否给内存写入数值
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh
    beq @@nohave
@@have:	
    ldr r0,=unusedRAM
	ldrb r2,[r0]
	mov r1,2h
	eor r1,r2
	strb r1,[r0]
	mov r1,18h
	strb r1,[r0,1h]
    pop r0-r2
    b @@end	
@@nohave:	
	pop r0-r2	                            
    mov r1,2h
	strh r1,[r0,14h]
@@end:
    pop r14	
.pool

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
.close