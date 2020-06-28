.gba
.open "zm.gba","hacksaw.gba",0x8000000

.org 8044480h
    bl attribute    ;眼光属性配置劫持
.org 80442eah
    bl upspeed      ;向上速度劫持
.org 80442beh
    bl downspeed	;向下速度劫持
.org 800e6ceh
    bl death        ;最终伤害劫持
	
.org 8304054h
attribute:
    ldr r2,=3000055h
	ldrb r2,[r2]
	mov r0,1eh
	strb r0,[r1]
	cmp r2,1eh     ;比较房间的值
	bne @@return
	mov r0,4h
	strb r0,[r1]
@@return:
    mov r2,0h
    bx r14	
.pool	

upspeed:
    push r2
    ldr r2,=3000055h
	ldrb r2,[r2]
    sub r0,1h
    strh r0,[r5,2h]
    cmp r2,1eh
    bne @@return1
    sub r0,2h
    strh r0,[r5,2h]
@@return1:
    pop r2
    bx r14
.pool	

downspeed:
    push r2
    ldr r2,=3000055h
	ldrb r2,[r2]
    add r0,1h
	strh r0,[r4,2h]
	cmp r2,1eh
	bne @@return2
	sub r0,1h
	strh r0,[r4,2h]
@@return2:
    pop r2
    bx r14
.pool

death:
    push r2
	ldr r2,=3000055h
	ldrb r2,[r2]
	cmp r2,1eh
	bne @@return3
	cmp r3,1h
	bne @@return3
	mov r3,64h
@@return3:
    pop	r2
	ldrh r0,[r6,6h]          
	cmp r0,r3    
	bx r14
	
.pool
.close	
	
	
	
	