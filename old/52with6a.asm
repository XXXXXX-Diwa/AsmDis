.gba
.open "zm.gba","6awith62.gba",0x8000000

.definelabel checkevent,0x80608bc
.definelabel originalOAM,0x82e6b98
.definelabel checksprite,0x80107F8

.org 875ea68h
    .word 0x0802ef69   ;6a AI地址与62相同
.org 875ed60h
    .word 0x082e6750   ;GFX地址
.org 875f058h		
    .word 0x082e6938   ;PAL地址
	
.org 802ed82h
    bl general
.org 802ee26h
    bl general
.org 802ee5eh 
    bl general	 

.org 802ebcch	
    bl OAMchange
.org 802ec8ch
    bl OAMchange	
.org 802edb2h
    bl OAMchange

.org 8304054h
newOAM:	
.import "6A62GATEOAM"
.align

OAMchange:                ;如果有精灵55,则5a,62,6a播放慢图像
    push r1-r3,lr
	mov r0,52h
    bl checksprite
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	bne @@fusion
@@original:
    ldr r0,=originalOAM
	b @@end
@@fusion:
    ldr r0,=newOAM
@@end:
    ldr r2,=3000738h
    str r0,[r2,18h] 
    pop r1-r3	
    pop r14 	
.pool
	
general:              
    push r1-r4,lr
    ldr r2,=3000738h
	ldrb r0,[r2,1dh]
	cmp r0,6ah         ;判断当前精灵是6ah则跳过警报检查
    beq @@continue	
	ldr r0,=30001a8h
	ldrh r0,[r0]
    b @@end	
@@continue:
    mov r0,3h
	mov r1,3h         
	bl checkevent      ;判断事件10h是否成立来继续
	cmp r0,0h
	beq @@end
    ldr r1,=30013d4h
	ldr r2,=3000738h
	ldrh r0,[r1,14h]   ;得到人物垂直坐标
	ldrh r3,[r2,2h]    ;得到精灵垂直坐标
	ldr r4,=100h
	add r3,r4         ;精灵下半格坐标
    cmp r0,r3
	bhi @@close          ;大于结束
	lsl r4,1h
	sub r3,r4            ;精灵上4格半坐标
	cmp r0,r3
	bls @@close          ;小于等于结束
	ldrh r0,[r1,12h]     ;得到人物水平坐标
	ldrh r3,[r2,4h]      ;得到精灵水平坐标
	ldr r4,=140h
	add r3,r4            ;水平坐标右5格 
	cmp r0,r3
	bhi @@close
	lsl r4,r4,1h	     ;水平坐标左6格
	sub r3,r4   	
	cmp r0,r3
	bls @@close
	mov r0,1h
	b @@end
@@close:
    mov r0,0h
@@end:
    pop r1-r4
	pop r14	
.pool	
.close