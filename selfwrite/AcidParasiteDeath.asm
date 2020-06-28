.gba
.open "zm.gba",".gba",0x8000000

.definelabel BGDataStart,300009Ch
.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
;控制5F寄生虫在强酸中一段时间后会自爆
.org 8031480h       ;5F主程序初
    bl AcidParasiteDeath 
    	
.org 8304054h
AcidParasiteDeath:
    push r4,r5,lr
	mov r1,r4
	add r1,20h
	ldrb r5,[r1,0Ah]
	cmp r5,3Fh
	beq @@Death
	ldr r3,=30000CCh
	ldrb r0,[r3]        
	cmp r0,5h
	bne @@CheckAcidClip
	ldrh r0,[r3,2h]
	ldrh r2,[r4,2h]
	cmp r0,r2
	bhi @@CheckAcidClip
@@AddNumber:	
	add r5,r5,1h
	strb r5,[r1,0Ah]
	b @@end
.pool	
@@CheckAcidClip:
    ldr r3,=BGDataStart
    ldrh r0,[r3,1Ch]      ;最大宽度格数
    ldrh r2,[r4,2h]
    lsr r2,r2,6
    mul r0,r2
    ldrh r2,[r4,4h]
    lsr r2,r2,6
    add r0,r0,r2
    lsl r0,r0,10h
    lsr r0,r0,0Fh
	ldr r2,[r3,18h]
	add r2,r0
	ldrb r0,[r2]
	cmp r0,0A2h           ;强酸
	beq @@AddNumber
	cmp r5,0h
	beq @@end
	sub r5,r5,1h
	strb r5,[r1,0Ah]
    b @@end	
.pool	
@@Death:
    mov r0,62h
    strb r0,[r1,4h]
	mov r0,0h
	strb r0,[r1,0Ah]
	strb r0,[r1,10h]
	ldrb r0,[r4]
	mov r2,2h
	and r0,r2
	cmp r0,0h
    beq @@end	
	mov r0,04Bh
	lsl r0,r0,2
	bl PlaySound2
@@end:
    mov r0,r4
	add r0,2Bh
	pop r4,r5
	pop r15

	


.close