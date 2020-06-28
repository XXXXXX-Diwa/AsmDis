.gba
.open "zm.gba","spritefix.gba",0x8000000


.org 0x80168CE   ;属性赋值地址
    bl zoomerorzeemer

;.org 0x80176CA
   ; bl zeelaoredzeela
	
;.org 0x801BDC0
    ;bl rippertwo

.org 0x08304054         ;无用数据
zoomerorzeemer:
    ldrb r3,[r4,1dh]    ;调用敌人ID(0x3000755)数值
	mov r0,4h           ;ID 12赋值
    cmp r3,13h          ;比较
	bne @@return        ;不等跳转
    mov r0,1h           ;ID 13赋值	
@@return:
	mov r3,0h           ;清空R3
    strb r0,[r1]        ;写入属性(0x30007D0)数值
    bx r14	            ;返回0x80168D2
.pool
.close
	
	
	
	
	
	
	
	
	

zeelaoredzeela:
    ldrb r3,[r4,1dh]
	mov r0,4h
	cmp r3,15h
	bne @@return1
	mov r0,1h
@@return1:
    mov r3,1h
    strb r0,[r1]        
    bx r14	     

rippertwo:
    ldrb r3,[r5,1dh]
    mov r0,4h
    cmp r3,17h
    bne @@return2
    mov r0,1h
@@return2:
    mov r3,0h
    strb r0,[r1]
	bx r14
.pool
.close
