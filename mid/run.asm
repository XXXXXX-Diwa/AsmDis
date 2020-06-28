.gba
.open "zm.gba","run.gba",0x8000000
;by Diwa.JumZhu


.org 875E6A8h                ;奔跑时调用
    .word 8304055h
;.org 875E6ACh                ;站立不停调用?
	
.org 8304054h	
   push    r4,r5,lr
   mov     r4,r0
   ldr     r0,=3001380h
   ldrh    r1,[r0]       ;读取改变的输入
   mov     r0,1h
   and     r0,r1
   cmp     r0,0h         
   beq     @@NoPressA
;---------------------------------;如果按了跳
   mov     r0,1h
   strb    r0,[r4,4h]   ;13d8写入1h
   mov     r0,0FEh
   b       @@end
   asr     r0,r0,0Eh
   lsl     r0,r0,0Ch

@@NoPressA:
   ldr     r2,=3001588h
   mov     r0,r2
   add     r0,60h       
   mov     r1,0h        
   ldsh    r5,[r0,r1]   ;读取行走最大速
;   mov     r11,r5   
   ldr     r0,=3001530h
   ldrb    r1,[r0,0Fh]  ;读取能力
   mov     r0,2h
   and     r0,r1
   cmp     r0,0h
   beq     @@NoSpeedBoot     ;检查是否有加速
;-----------------------------------有加速的情况
   ldrb    r0,[r4,0Ah]  ;读取加速跑累计值
   mov     r1,r0
   mov     r3,r0
   cmp     r1,8Bh
   bls     @@PassMaxSpeed
   mov     r5,08Ch      ;一旦加速累计值达到8C则最大速为A0
   b       @@PassSecSpeed

@@PassMaxSpeed:
   cmp     r1,77h
   bls     @@PassSecSpeed
   mov     r5,8Ch       ;一旦加速累计值达到77则最大速为8Ch

@@PassSecSpeed:

   mov     r1,r2
   add     r1,5Bh
   ldrb    r1,[r1]
   cmp     r1,0h               ;无重力在水flag
   beq     @@PassMaxSpeedSub
   ldrb    r1,[r4,1Ah]
   cmp     r1,0h               ;检查是否在斜坡
   beq     @@NoOnSloop
   ldrb    r0,[r4,0Eh]         ;面向
   and     r0,r1               ;检查是否是上坡
   cmp     r0,0h
   beq     @@NoOnSloop         ;如果不上坡则不减速
   mov     r5,30h              ;在斜坡则最大速30h
   b       @@PassSpeedBootAdd
@@NoOnSloop:  
   ldrh    r0,[r4,16h]  ;读取当前的速度值 
   add     r0,17h
   mov     r1,2Eh
   lsr     r5,r5,1h
   b       @@Check   
@@PassMaxSpeedSub:
   ldrh    r0,[r4,16h]  ;读取当前的速度值
   add     r0,5Fh
   mov     r1,5Fh
@@Check: 
   lsl     r0,r0,10h
   lsr     r0,r0,10h
   cmp     r0,r1  
   bls     @@NoSpeedBoot     ;比较是否小于等于5F
;---------------------------------------------当前速度值达到了60h
   lsl     r0,r3,18h
   lsr     r0,r0,18h 
   cmp     r0,09Fh           ;加速累计值
   bhi     @@PassSpeedBootAdd         ;大于9F则跳转
   add     r0,r3,1           ;否则加1再写入
   b       @@SpeedBootAdd

@@NoSpeedBoot:
   mov     r0,0h

@@SpeedBootAdd:
   strb    r0,[r4,0Ah]

@@PassSpeedBootAdd:
   ldr     r0,=300137Ch
   ldrh    r3,[r0]           ;读取输入
   ldrh    r1,[r4,0Eh]       ;读取面向
   mov     r0,r3
   and     r0,r1
   cmp     r0,0h
   beq     @@NoPressDirection  ;没有按住方向键
   mov     r0,r2
   add     r0,5Eh
   mov     r1,0h
   ldsh    r0,[r0,r1]       ;15e6加速值
   mov     r1,r5
   mov     r2,r4
   bl      8008278h         ;速度写入地址
   mov     r0,r4
   bl      80079A4h
   mov     r0,0FFh
   b       @@end

@@NoPressDirection:
   ldrb    r0,[r4,5h]
   cmp     r0,0h      ;读取金身flag
   beq     @@NoSparkFlag
   mov     r0,7h      ;若有姿势写入7 刹车
   b       @@end

@@NoSparkFlag:
   mov     r0,r2
   add     r0,5Ch
   ldrb    r0,[r0]    ;13e4的值
   cmp     r0,0h
   beq     @@Noshooting
   mov     r0,3h      ;写入射击的姿势
   b       @@end

@@Noshooting:
   mov     r0,30h
   eor     r0,r1      ;30 eor 面向 再 and 输入
   and     r0,r3      ;获取相反的方向
   lsl     r0,r0,10h
   cmp     r0,0h
   beq     @@NoChangeDiriction
   mov     r0,2h      ;写入换向姿势
   b       @@end

@@NoChangeDiriction:
   mov     r0,1h      ;写入站立姿势

@@end:
   pop     r4,r5
   pop     r1
   bx      r1

.pool
.close	
	
    	
	
    	
    	
	
        
    	
	