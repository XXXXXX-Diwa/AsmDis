.gba
.open "merge.gba","weapons.gba",0x8000000


;.org 804f9e4h      ;弹丸射出后不会根据人物的水平移动而增加速度
;     b 804fa12h
	

.org 804ee36h           ;弹丸初始化处
    bl FlagXSpeed
	
.org 804f9e2h           ;弹丸并入人物速度处
	bl AddXSpeed
    b 804fa12h	
	
.org 8305000h
FlagXSpeed:              ;记录了弹丸初始化时的人物X速度
    strb r2,[r3]
	strb r4,[r3,0fh]
	ldr r2,=30013d4h
	mov r1,16h
	ldsh r0,[r2,r1]      ;读取人物X速度
	cmp r0,0h
	beq @@WriteX
	cmp r0,0h
	bge @@Right
	neg r0,r0
@@Right:	
	lsl r0,r0,10h
	lsr r0,r0,13h        ;除以八
@@WriteX:
    strb r0,[r3,2h]      ;写入X起速值
    mov r1,18h
	bx r14 
.pool

AddXSpeed:              ;根据人物射弹丸时候的速度来改变弹丸的速度
    strh r0,[r4,0Ah]
	ldrb r2,[r4,2h]      ;读取备份的X初始速度
	cmp r2,0h
	beq @@end
	mov r0,40h
	and r0,r1
	cmp r0,0h
	beq @@left
	ldrh r0,[r4,0Ah]
	add r0,r0,r2
	b @@WriteX
@@left:
    ldrh r0,[r4,0Ah]
    sub r0,r0,r2
@@WriteX:
	sub r2,1h
	strb r2,[r4,2h]	
    strh r0,[r4,0Ah]         ;写入弹丸X最终坐标
@@end:
    pop r4,r5
    pop r15
.pool	
	
.close
