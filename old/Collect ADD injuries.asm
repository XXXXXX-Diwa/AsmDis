.gba
.open "zm.gba","spritedamageAdd.gba",0x8000000
.definelabel Division,0x808AC34
;This asm increases the damage done to samus by all enemies based on your current collection rate. 
;The collection rate >=10%, damage increased by 20%, and then each additional 10%, damage increased
; by 10%, collection rate >=90%, damage doubled, collection rate 100%, damage tripled.
.org 800e6ceh
    bl addamage
.org 8304054h
addamage:
    push r0-r2
	mov r0,r3
	push r4-r5
    ldr r2,=3000063h
    ldrb r1,[r2]      ;区域1收集
    ldrb r4,[r2,1h]   ;区域2收集
    add r1,r4
    ldrb r4,[r2,2h]   ;区域3收集
    add r1,r4	
	ldrb r4,[r2,3h]   ;区域4收集
    add r1,r4	
	ldrb r4,[r2,4h]   ;区域5收集
    add r1,r4	
	ldrb r4,[r2,5h]   ;区域6收集
    add r1,r4	
	ldrb r4,[r2,6h]   ;区域7收集
    add r1,r4	      ;全部区域收集总值
	lsl r1,18h
	lsr r1,18h        
	cmp r1,64h
	bne @@no100
	lsl r0,2h
	sub r0,r3        ;伤害3倍
	b @@return
.pool	
@@no100:
    lsl r0,4h   ;伤害值16倍
	lsl r3,2h   ;伤害值4倍
    add r0,r3   ;伤害值20倍
	lsr r3,2h   ;返回原值
    cmp r1,5ah   
	bhs @@division   ;收集90以上跳转
	sub r0,r3
	cmp r1,50h
	bhs @@division   ;收集80以上跳转
	sub r0,r3
	cmp r1,46h
	bhs @@division   ;收集70以上跳转
	sub r0,r3
	cmp r1,3ch
	bhs @@division   ;收集60以上跳转
	sub r0,r3
	cmp r1,32h
	bhs @@division   ;收集50以上跳转
	sub r0,r3
	cmp r1,28h
	bhs @@division   ;收集40以上跳转
	sub r0,r3
	cmp r1,1eh
	bhs @@division   ;收集30以上跳转
	sub r0,r3
	cmp r1,14h
	bhs @@division   ;收集20以上跳转
	sub r0,r3
	cmp r1,0xA
	bhs @@division   ;收集10以上跳转
@@division:
    mov r1,0xA
    bl Division	
@@return:
    lsl r0,10h
	lsr r3,10h
	pop r0-r2
    pop r4-r5
	ldrh r0,[r6,6h]          
	cmp r0,r3    
	bx r14
.pool
.close