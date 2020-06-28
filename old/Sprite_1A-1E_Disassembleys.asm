
.definelabel @@soundplay,8002a18h	
.definelabel @@table,8012b90h	
.definelabel @@powerbome,8012e00h	
.definelabel @@supermissle,8012e10h 	
.definelabel @@missle,8012e20h 	
.definelabel @@bigenergy,8012e30h	
.definelabel @@smallenergy,8012e6ch	
.definelabel @@Givetheform,8012e76h	
.definelabel @@tabletwo,8012ee4h 
	
.org 8012d14h	            ;pose 0 默认开始的例程,经历一次
     push    r14                                     	
     ldr     r0,=3000738h                            	
     mov     r12,r0                                  	
     mov     r1,r12                                  	
     add     r1,26h                                  	
     mov     r3,0h                                   	
     mov     r0,14h                                  	
     strb    r0,[r1]        ;300075e 计数写入14h  drop 无敌时间                       	
     mov     r2,r12                                  	
     ldrh    r1,[r2]                                 	
     mov     r2,80h                                  	
     lsl     r2,r2,8h       ;8000h                        	
     mov     r0,r2                                   	
     mov     r2,0h                                   	
     orr     r0,r1         ;3000738的值和8000h orr                          	
     mov     r1,r12                                  	
     strh    r0,[r1]                                 	
     add     r1,24h                                  	
     mov     r0,9h                                   	
     strb    r0,[r1]       ;pose写入9h                          	
     mov     r0,0C8h                                 	
     mov     r1,r12       `                           	
     strh    r0,[r1,6h]    ;弹丸Y轴写入C8h  用来当做消失的时间                       	
     strh    r3,[r1,8h]    ;弹丸X轴写入0                         	
     strb    r2,[r1,1Ch]                             	
     strh    r3,[r1,16h]   ;动画和计数归零                           	
     mov     r0,r12                                  	
     add     r0,27h                                  	
     mov     r1,8h                                   	
     strb    r1,[r0]       ;300075f写入8                          	
     add     r0,1h                                   	
     strb    r1,[r0]       ;3000760写入8                          	
     add     r0,1h                                   	
     strb    r1,[r0]       ;3000761写入8                          	
     ldr     r0,=3000088h                            	
     ldrb    r1,[r0,0Ch]   ;得到3000094的值                         	
     mov     r0,3h                                   	
     and     r0,r1         ;与3and                          	
     mov     r1,r12                                  	
     add     r1,21h                                  	
     strb    r0,[r1]       ;3写入3000759                           	
     add     r1,1h                                   	
     mov     r0,1h                                   	
     strb    r0,[r1]       ;300075a写入1                         	
     mov     r2,r12                                  	
     ldrb    r0,[r2,1Dh]   ;精灵ID                          	
     sub     r0,1Ah        ;减去1ah                          	
     cmp     r0,1Bh                                  	
     bls     @@pass          ;小于等于1B则跳转                          	
     b       @@smallenergy   ;异常情况给小血???  	
@@pass:                              	
     lsl     r0,r0,2h        ;再乘以8                        	
     ldr     r1,=@@table                            	
     add     r0,r0,r1                                	
     ldr     r0,[r0]                                 	
     mov     r15,r0 	
	
@@table:	
    .word 8012e30h  ;00	
	.word 8012e6ch  ;01
	.word 8012e20h  ;02
	.word 8012e10h  ;03
	.word 8012e00h  ;04
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch 
	.word 8012e40h  ;1bh
	
.org @@powerbome                              	
     ldr     r0,=82B27A8h                            	
     str     r0,[r2,18h]    ;写入OAM                           	
     mov     r1,r2                                   	
     add     r1,25h                                  	
     mov     r0,23h                                  	
     b       @@Givetheform                                	
.pool
	
.org @@supermissle                             	
     ldr     r0,=82B2790h                            	
     str     r0,[r2,18h]                             	
     mov     r1,r2                                   	
     add     r1,25h                                  	
     mov     r0,22h                                  	
     b       @@Givetheform                                	
.pool
 	
.org @@missle                              	
     ldr     r0,=82B2778h                            	
     str     r0,[r2,18h]                             	
     mov     r1,r2                                   	
     add     r1,25h                                  	
     mov     r0,21h                                  	
     b       @@Givetheform                                	
.pool
	
.org @@bigenergy                              	
     ldr     r0,=82B2750h                            	
     str     r0,[r2,18h]                             	
     mov     r1,r2                                   	
     add     r1,25h                                  	
     mov     r0,20h                                  	
     b       @@Givetheform                                	                      	
.pool
	
.org @@smallenergy                              	
     ldr     r0,=82B2728h                            	
     str     r0,[r2,18h]                             	
     mov     r1,r2                                   	
     add     r1,25h                                  	
     mov     r0,1Fh
.pool

.org @@Givetheform                                 	
     strb    r0,[r1]      ;写入属性                           	
     ldr     r0,=0FFDCh                              	
     strh    r0,[r2,0Ah]                              	
     mov     r0,24h                                  	
     strh    r0,[r2,0Ch]                             	
     ldr     r0,=0FFE0h                              	
     strh    r0,[r2,0Eh]                             	
     mov     r0,20h                                  	
     strh    r0,[r2,10h]  ;四面分界                           	
     pop     r0                                      	
     bx      r0  
.pool	
 //////////////////////////////////////////////
.org 8012e98h             ;pose 9                          	
     push    r14                                     	
     ldr     r2,=3000738h                            	
     mov     r0,r2                                   	
     add     r0,26h                                  	
     ldrb    r0,[r0]      ;读取300075e                            	
     cmp     r0,0h                                 	
     beq     @@zero       ;是0的话跳转 导致道具出现需要等10多帧才能吃                         	
     cmp     r0,1h                                   	
     bls     @@pass       ;小于等于1跳转,必然经历一次                          	
     b       @@endyes 	  ;end
@@pass:                   ;大概是防止drop停留时间太长导致的异常?            	
     ldrh    r1,[r2]                                 	
     ldr     r0,=0FFFBh   ;8007 <-> 8003                           	
     and     r0,r1                                   	
     b       @@willend                                	
.pool
	
@@zero:                   ;道具可以吃了                   	
     ldrh    r3,[r2]                                 	
     mov     r0,80h                                  	
     lsl     r0,r0,4h     ;800和800and                          	
     and     r0,r3                                   	
     cmp     r0,0h        ;只要没吃到都会是0                           	
     bne     8012ECAh     ;吃到                          	
     b       8012FC8h     ;没吃到                           	
.pool

.org 8012ecah             ;get
    mov r0,r2
	add r0,25h
	ldrb r0,[r0]          ;得到属性值
	sub r0,1fh            ;减去1fh
	cmp r0,5h             ;大于则跳转
	bhi 8012fb6h          ;异常??
	lsl r0,r0,2h
	ldr r1,=@@tabletwo
	add r0,r0,r1
	ldr r0,[r0]
	mov r15,r0
.pool
		
.org 8012fb6h
	ldr r1,=3000738h
	mov r0,0h
	strh r0,[r1]        ;3000738写入0然后结束
	b @@endyes
.pool
 
.org @@tabletwo:
    .word 8012efch
	.word 8012f1ch
	.word 8012f3ch
	.word 8012f5ch
	.word 8012f7ch
	.word 8012f9ch

.org 8012efch             ;add smallenergy
    ldr r1,=2001530h
    ldrh r0,[r1,6h]       ;当前血量
	add r0,5h             ;加5写入
	strh r0,[r1,6h]
	ldrh r2,[r1]          ;获得最大血量
	lsl r0,r0,10h       
	lsr r0,r0,10h
	cmp r0,r2             ;当前血量比最大血量
	bls 8012f10h          ;小于或等于跳转
	strh r2,[r1,6h]       ;写入最大血量到当前血量
	mov r0,86h            ;播放声音86
	bl @@soundplay
	b 8012fb6h
.pool

.org 8012f1ch            ;add bigenergy
    ldr r1,=2001530h
    ldrh r0,[r1,6h]
	add r0,14h
	strh r0,[r1,6h]
	ldrh r2,[r1]
	lsl r0,r0,10h
	lsr r0,r0,10h
	cmp r0,r2
	bls 8012f30h
	strh r2,[r1,6h]
	mov r0,87h
	bl @@soundplay
	b 8012fb6h
.pool

.org 8012f3ch
    ldr r1,=2001530h
    ldrh r0,[r1,8h]
	add r0,2h
	strh r0,[r1,8h]
	ldrh r2,[r1,2h]
	lsl r0,r0,10h
	lsr r0,r0,10h
	cmp r0,r2
	bls 8012f50h
	strh r2,[r1,6h]
	mov r0,88h
	bl @@soundplay
	b 8012fb6h
.pool

.org 8012f5ch
    ldr r1,=2001530h
    ldrh r0,[r1,0ah]
	add r0,2h
	strh r0,[r1,0ah]
	ldrh r2,[r1,4h]
	lsl r0,r0,18h
	lsr r0,r0,18h
	cmp r0,r2
	bls 8012f70h
	strh r2,[r1,0ah]
	mov r0,89h
	bl @@soundplay
	b 8012fb6h
.pool

.org 8012f7ch
    ldr r1,=2001530h
    ldrh r0,[r1,0bh]
	add r0,5h
	strh r0,[r1,0bh]
	ldrh r2,[r1,5h]
	lsl r0,r0,18h
	lsr r0,r0,18h
	cmp r0,r2
	bls 8012f90h
	strh r2,[r1,0bh]
	mov r0,8ah
	bl @@soundplay
	b 8012fb6h	
.pool
	
.org 8012f10h             ;if energy is max
    mov r0,86h
	bl @@soundplay
	b 8012fb6h

.org 8012f30h
    mov r0,87h
    bl @@soundplay
    b 8012fb6h	
	
.org 8012f50h
    mov r0,88h
    bl @@soundplay
    b 8012fb6h	
 
.org 8012f70h
    mov r0,89h
    bl @@soundplay
    b 8012fb6h

.org 8012f90h
    mov r0,8ah
    bl @@soundplay
    b 8012fb6h

.org 8012fb6
    ldr r1,=3000738h
    mov r0,0h
	strh r0,[r1]
	b @@endyes          ;end
.pool
    	
.org 8012fc8h           ;没吃到的时候	判断drop消失的例程 控制闪烁
    ldrb r0,[r2,8h]     ;读取弹丸x坐标值		
	mov r1,1h
	and r0,r1           ;r0和1
	cmp r0,0h
	beq @@endyes        ;是偶数的话跳转
	ldrh r0,[r2,6h]
	sub r0,1h
	strb r0,[r2,6h]     ;弹丸Y坐标减1
	lsl r0,r0,18h
	lsr r0,r0,18h
	cmp r0,0h
	beq @@willend        ;弹丸当前Y坐标如果是0跳转 这意味着此值是作为计数器的
	cmp r0,4fh          ;弹丸当前Y坐标如果大于4F跳转
	bhi @@endyes
	mov r0,4h
	eor r0,r3           ;8007 eor 4 =8003 ,8003 eor 4 =8007
.org @@willend	
	strh r0,[r2]        ;3000738写入8003正常,8007或0消失
.org @@endyes	
	pop r0
	bx r0
.pool
	
.org 8012ff0h	                ;主程序,每帧都经历
     push    r14                                     	
     ldr     r0,=3000738h                            	
     add     r0,24h                                  	
     ldrb    r0,[r0]                                 	
     cmp     r0,0h                                   	
     beq     @@posezero         ;pose为0跳转   默认第一次的跳转,也只跳转这一次                    	
     cmp     r0,9h                                   	
     beq     @@posenine         ;pose为9跳转                       	
     b       @@end                                	
     lsl     r0,r0,0h                                	
     lsl     r0,r7,1Ch                               	
     lsl     r0,r0,0Ch	
@@posezero:                               	
     bl      8012D14h           ;该默认例程会写入pose 9                      	
     b       @@end 	
@@posenine:                               	
     bl      8012E98h   	
@@end:                             	
     ldr     r1,=3000738h                            	
     ldrh    r0,[r1,8h]                              	
     add     r0,1h               ;弹丸x轴值每帧加1                    	
     strh    r0,[r1,8h]                              	
     pop     r0                                      	
     bx      r0 	
.pool