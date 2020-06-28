
.definelabel @@end,0x8012D00

.org 8012a38h
    push r4-r7,lr
	mov r7,r9
	mov r6,r8
	push r6,r7
	mov r3,0h
	ldr r0,=3000738h
	mov r12,r0
	mov r4,r12
	add r4,24h
	ldrb r0,[r4]     ;得到pose
	cmp r0,0h
	bne 8012aa8h     ;不为零的话执行
	mov r2,r12
	ldrh r1,[r2]
	mov r0,4h
	mov r2,0h
	orr r0,r1        
	mov r1,r12
	strh r0,[r1]    ;3000738 orr 4
	mov r0,r12
	add r0,27h
	mov r1,1h
	strb r1,[r0]    ;300075f写入1
	add r0,1h
	strb r1,[r0]    ;3000760写入1
	add r0,1h
	strb r1,[r0]    ;3000761写入1
	mov r0,r12
	strh r3,[r0,0ah] ;顶部分界0
	strh r3,[r0,0ch] ;下部分界0
	strh r3,[r0,0eh] ;左部分界0
	strh r3,[r0,10h] ;右部分界0
	add r0,25h
	strb r2,[r0]     ;属性0
	ldr r0,=82b2750h
	mov r1,r12
	str r0,[r1,18h]  ;写入OAM
	strb r2,[r1,1ch] ;动画和计数归0
	strh r3,[r1,16h]
	mov r0,9h
	strb r0,[r4]     ;pose写入9
	mov r0,r12
	add r0,2fh
	strb r2,[r0]     ;3000767 0
	add r1,2eh
	mov r0,7h
	strb r0,[r1]     ;3000766 0
	mov r2,r12
	ldrh r0,[r2,2h]  ;Y轴坐标写入弹丸Y轴坐标
	strh r0,[r2,6h]
	ldrh r0,[r2,4h]
	strh r0,[r2,8h]  ;X轴坐标写入弹丸X轴坐标
	b @@end
	
.org 8012aa8h        ;pose9 ?
    mov r0,r12
    ldrh r5,[r0,6h]   ;得到弹丸Y轴坐标
	ldr r1,=30013b8h
	mov r2,0f0h
	lsl r2,r2,1h
	mov r0,r2
	ldrh r1,[r1]     ;30013b8的值
	add r0,r0,r1     ;加1e0h
	lsl r0,r0,10h
	lsr r6,r0,10h
	ldr r0,=300083ch
	ldrb r4,[r0]     ;精灵的随机数发生值
	mov r7,3h
	and r7,r4
	mov r2,r12
	add r2,2fh
	ldrb r0,[r2]
	add r1,r0,1      ;3000767的值加1
	strb r1,[r2]
	lsl r0,r0,18h
	lsr r0,r0,18h
	mov r8,r0        ;原值给r8
	sub r2,1h
	ldrb r0,[r2]
	add r1,r0,1     ;3000766的值加1
	strb r1,[r2]
	lsl r0,r0,18h
	lsr r0,r0,18h
	mov r9,r0        ;原值给r9
	ldr r0,=30013d4h
	ldrh r1,[r0,14h] ;垂直坐标
	mov r0,r5
	sub r0,0a0h      ;弹丸垂直坐标减A0h
	cmp r1,r0        ;垂直坐标比较
	bge @@goto                 ;8012af6h 大于等于跳转
	mov r0,r1
	add r0,64h       ;垂直坐标加64h
	lsl r0,r0,10h
	lsr r5,r0,10h    ;;给r5
@@goto:	
	mov r0,0fh
	mov r1,r8
	and r0,r1       ;f和r8比较
	cmp r0,0h       ;前3000767为0fh才成立
	beq @@pass                 ;8012b02h
	b 8012c2ah
@@pass:	
	cmp r4,7h       ;随机数大于7h成立
	bhi @@come                 ;8012b08h
	b 8012c2ah
@@come:	
	mov r0,10h
	and r0,r1      ;前3000767的值不为10才成立
	cmp r0,0h
	beq 8012b8ch
	cmp r4,0bh     ;随机数小于0bh成立
	bls @@8012b48h
	mov r0,1h
	and r0,r4      ;随机数为奇数成立
	cmp r0,0h
	beq 8012b38h
	lsl r0,r4,3h   ;随机数乘以8
	sub r0,0dch    ;减去DCh
	add r0,r5,r0   ;加上垂直坐标
	mov r1,r4
	lsl r1,r7      ;随机数的随机倍
	add r1,0a0h    ;在加上AOh
	add r1,r6,r1   ;加1e0h
	b @@8012b5ch
	
.org 8012b38h
    lsl r0,r4,3h
	sub r0,0e6h
	add r0,r5,r0
	mov r1,r4
	lsl r1,r7
	add r1,r6,r1
	mov r2,22h
	b @@8012b7ah
@@8012b48h:	
    mov r0,1h
	and r0,r4
	cmp r0,0h
	beq @@8012b6ah
	lsl r0,r4,3h
	sub r0,0dch
	add r0,r5,r0
	mov r1,r4
	lsl r1,r7
	sub r1,r6,r1
@@8012b5ch:	
	mov r2,1eh
	bl 80540ech
	mov r0,0a4h
	bl 8002b20h
	b 8012c2ah
@@8012b6ah:
    lsl r0,r4,3h
    sub r0,0e6h
	add r0,r5,r0
	mov r1,r4
	lsl r1,r7
    add r1,0a0h
	sub r1,r6,r1
	mov r2,21h
@@8012b7ah:	
	bl 80540ech
	
.org 8012b8ch
    mov r0,0ah
	mov r1,81h
	bl 8055344h
	mov r0,0ah
	mov r1,81h
	bl 8055378h
	cmp r4,0bh
	bls 8012be0h
	mov r0,1h
	and r0,r4-r7
	cmp r0,0h
	beq 8012bcch
	lsl r0,r4,4h
	ldr r2,=0fffffec0h
	add r0,r0,r2
	add r0,r5,r0
	mov r1,r4
	lsl r1,r7
	add r1,0c0h
	add r1,r6,r1
	mov r2,36h
	bl 80540ech
	mov r0,0a5h
	bl 8002b20h
	b 8012c2ah
	
.org 8012bcch
    lsl r0,r4,4h
	ldr r1,=0fffffee8h
	add r0,r0,r1
	add r0,r5,r0
	mov r1,r4
	lsl r1,r7
	add r1,r6,r1
	b @@8012bf8h
	
.org 8012be0h
    mov r0,1h
    and r0,r4
	cmp r0,0h
	beq 8012c10h
	lsl r0,r4,4h
	ldr r2,=0fffffe98h
	add r0,r0,r2
	add r0,r5,r0
	mov r1,r4
	lsl r1,r7
	add r1,0c0h
	sub r1,r6,r1
@@8012bf8h:	
	mov r2,35h
	bl 80540ech
	ldr r0,=277h
	bl 8002b20h
	b 8012c2ah
    	
.org 8012c2ah
    ldr r0,=30013bah
    ldrh r0,[r0]
	sub r0,40h
	lsl r0,r0,10h
	lsr r5,r0,10h
	mov r0,1fh
	mov r2,r9
	and r0,r2
	cmp r0,0h
	bne 8012c9ah
	mov r0,20h
	and r0,r2
	cmp r0,0h
	beq 8012c78h
	lsl r3,r4,4h
	sub r3,78h
	sub r3,r6,r3
	mov r0,0h
	mov r1,5h
	mov r2,r5
	bl 8011e48h
	lsl r3,r4,3h
	ldr r0,=0fffffe70h
	add r3,r3,r0
	add r3,r6,r3
	mov r0,0h
	mov r1,8h
	mov r2,r5
	bl 8011e48h
	b 8012c9ah
     	
.org 8012c9ah
    mov r0,0fh
	mov r2,r8
	and r0,r2
	cmp r0,0h               
    bne     @@end                ;8  110
	cmp     r4,7h                   ;2  112
    bls     @@pass                ;8012CDCh                ;8  120
    lsl     r4,r4,5h                ;2  122
    ldr     r0,=0FFFFFE3Eh          ;9  131
    add     r3,r4,r0                ;2  133
    add     r3,r6,r3                ;2  135
    mov     r0,0h                   ;2  137
    mov     r1,8h                   ;2  139
    mov     r2,r5                   ;2  141
    bl      8011E48h                ;10 151
    ldr     r1,=0FFFFFDB2h          ;9  160
    add     r4,r4,r1                ;2  162
    sub     r4,r6,r4                ;2  164
    mov     r0,0h                   ;2  166
    mov     r1,6h                   ;2  168
    mov     r2,r5                   ;2  170
    mov     r3,r4                   ;2  172
    bl      8011E48h                ;10 182
    b       @@end                ;8  190
@@pass:
    lsl     r3,r4,5h                ;2  254
    ldr     r2,=0FFFFFE84h          ;9  263
    add     r3,r3,r2                ;2  265
    sub     r3,r6,r3                ;2  267 
    mov     r0,0h                   ;2  269
    mov     r1,6h                   ;2  271
    mov     r2,r5                   ;2  273
    bl      8011E48h                ;10 283
    lsl     r3,r4,3h                ;2  285
    ldr     r0,=0FFFFFD88h          ;9  294
    add     r3,r3,r0                ;2  296
    add     r3,r6,r3                ;2  298
    mov     r0,0h                   ;2  300
    mov     r1,8h                   ;2  302
    mov     r2,r5                   ;2  304
    bl      8011E48h                ;10 314
@@end:	
    pop     r3,r4                   ;13 327
    mov     r8,r3                   ;2  329
    mov     r9,r4                   ;2  331
    pop     r4-r7                   ;21 352
    pop     r0                      ;9  361
    bx      r0                      ;8  369
