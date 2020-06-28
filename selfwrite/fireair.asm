.gba
.open "MF.gba","Fireasm.gba",0x8000000

.definelabel CurrSpriteDataStrat,30006BCh
.definelabel SpriteRNG,30007F0h
.definelabel NoGfxOAM,833FEB8h
.definelabel WillShootOAM,833FE38h
.definelabel PlaySound,800270Ch 
.definelabel FireWillDeath,833FEC8h
.definelabel CheckAnimation,8011934h
.definelabel FireFlowerOAM,833FDE0h
.definelabel BitCountNum,3000BE5h
.definelabel SpriteID,5Fh
.definelabel SpriteAIAddressStart,879A29Ch

.org SpriteAIAddressStart + (SpriteID * 4)
    .word FireMain + 1   

.org 8365bd4h
PoseZero:              ;火气花的初始设定
    push    r4,lr
    bl      FireFlowerSetInital
	mov     r1,r12
	ldrh    r0,[r1,2h]
    add     r0,1Ch         ;Y坐标向下1C
    strh    r0,[r1,2h]     ;再写入
    strh    r0,[r1,6h]     ;写入备份的Y坐标
    pop     r4
    pop     r0
    bx      r0
.pool

PoseOne:                   ;火花气的全部过程
    push    lr
    ldr     r3,=CurrSpriteDataStrat
    mov     r0,r3
	add     r0,2Fh
	ldrb    r1,[r0]
	cmp     r1,0h
	bls     @@CheckAnimationEnd
	sub     r1,1h
	strb    r1,[r0]        ;设定值减1再写入
    ldr     r0,=BitCountNum
    ldrb    r0,[r0]        ;8 bit 循环数读取
    mov     r1,0Fh
    and     r1,r0
    cmp     r1,0h
    bne     @@end
    ldr     r0,=SpriteRNG
    ldrb    r0,[r0]
    cmp     r0,7h
    bls     @@OtherOAM
    ldr     r0,[r3,18h]
    ldr     r2,=833FE08h
    b       @@Peer

@@OtherOAM:
    ldr     r0,[r3,18h]
    ldr     r2,=833FDE0h

@@Peer:
    cmp     r0,r2
    beq     @@end
    str     r2,[r3,18h]
    strb    r1,[r3,1Ch]
    strh    r1,[r3,16h]
	b @@end
	
@@CheckAnimationEnd:
    bl CheckAnimation
    cmp     r0,0h
    beq     @@end
	bl      SetFireAirInital
@@end:
    pop     r0
    bx      r0
.pool

SetFireAirInital:;火气的初始设定
    ldr     r0,=CurrSpriteDataStrat
    mov     r12,r0
	mov     r1,r12
    mov     r0,100
    strh    r0,[r1,14h]    ;写入初始血量
    add     r1,25h
    mov     r0,4h
    strb    r0,[r1]        ;属性写入4
    mov     r2,r12
    add     r2,34h
    ldrb    r1,[r2]
    mov     r0,8h
    orr     r0,r1
    strb    r0,[r2]        ;不知道什么用途
    mov     r1,r12
    add     r1,27h
    mov     r0,8h
    strb    r0,[r1]        ;视野判定上写入8
    add     r1,1h
    mov     r0,68h         ;视野判定左右写入68
    strb    r0,[r1]
    mov     r0,r12
    add     r0,29h
    mov     r1,10h         
    strb    r1,[r0]        ;视野判定下写入10h
    mov     r2,r12
    strh    r3,[r2,0Ah]    ;上分界写入0
    mov     r0,0A0h
    strh    r0,[r2,0Ch]    ;下分界写入A0h
    ldr     r0,=0FFF0h
    strh    r0,[r2,0Eh]    ;左分界写入0FFF0h
    strh    r1,[r2,10h]    ;右分界写入10h
    ldrh    r0,[r2,4h]     
    strh    r0,[r2,8h]     ;备份X坐标
    mov     r1,r12
    add     r1,24h
    mov     r0,2h
    strb    r0,[r1]        ;pose写入2
    ldrh    r1,[r2]
    ldr     r2,=8004h
    mov     r0,r2
    mov     r2,0h
    orr     r0,r1          ;取向 orr 8004
    mov     r1,r12
    strh    r0,[r1]        ;再写入
    
    ldr     r0,=WillShootOAM   
    mov     r1,r12
    str     r0,[r1,18h]    ;写入OAM
    strb    r2,[r1,1Ch]    ;动画帧归零
    strh    r3,[r1,16h]    ;动画归零
	add     r1,2Eh
    mov     r0,1Eh         ;或许是自由内存,记录值
    strb    r0,[r1]
    bx      r14    
.pool

PoseTwo:
    push    r4,lr
    ldr     r4,=CurrSpriteDataStrat
    mov     r1,r4
    add     r1,2Eh
    ldrb    r0,[r1]        ;读取设定的值
    cmp     r0,0h
    beq     @@NumZero
    sub     r0,1h
    strb    r0,[r1]        ;减1再写入
    lsl     r0,r0,18h
    lsr     r0,r0,18h
    cmp     r0,0h
    bne     @@end
    strb    r0,[r4,1Ch]    ;动画帧归零
    strh    r0,[r4,16h]    ;动画归零
    ldrh    r0,[r4]        
    ldr     r1,=7FFBh
    and     r1,r0
    strh    r1,[r4]        ;取向and 7FFb再写入
    mov     r0,2h 
    and     r0,r1          ;取向 and 2
    cmp     r0,0h
    beq     @@end

;在屏幕内
    mov     r0,0C2h
    lsl     r0,r0,1h
    bl      PlaySound       ;播放声音
    b       @@end

@@NumZero:
    ldrh    r0,[r4,6h]      ;读取备用Y坐标
    sub     r0,40h          ;减40 等于向上一格
    ldrh    r2,[r4,2h]      ;读取Y坐标
    cmp     r0,r2           ;比较
    ble     @@Here          ;每格检查一次是否碰砖
    ldrh    r1,[r4,4h]
    mov     r0,r2
    bl      8011390h        ;clip相关
    ldr     r0,=30007A5h
    ldrb    r0,[r0]
    cmp     r0,11h
    beq     @@HaveBlock
	
@@Here:	
    ldr     r4,=CurrSpriteDataStrat
    ldrh    r0,[r4,2h]      ;读取Y坐标
    sub     r0,0Eh          ;向上OE
    strh    r0,[r4,2h]      ;再写入
    bl      CheckAnimation        ;检查动画结束     
    cmp     r0,0h
    beq     @@end

@@HaveBlock:
    mov     r1,r4
    add     r1,24h
    mov     r0,3h          ;上喷结束pose写入3
    strb    r0,[r1]

@@end:
    pop     r4
    pop     r0
    bx      r0
.pool


PoseThree:
    push    lr
    mov     r0,0C2h
    lsl     r0,r0,1h
    bl      8002738h        ;播放声音
    pop     r0
    bx      r0
.pool

PoseThx2:
    push    lr
    ldr     r1,=CurrSpriteDataStrat
    ldr     r0,=FireWillDeath    ;喷火消失特效
    str     r0,[r1,18h]     ;写入OAM
    mov     r0,0h
    strb    r0,[r1,1Ch]
    strh    r0,[r1,16h]
    mov     r2,r1
    add     r2,24h
    mov     r0,4h
    strb    r0,[r2]         ;pose写入4
    ldrh    r2,[r1]
    mov     r3,80h
    lsl     r3,r3,8h
    mov     r0,r3
    orr     r0,r2
    strh    r0,[r1]         ;取向ORR 800再写入
    mov     r1,2h
    and     r0,r1
    cmp     r0,0h           ;检查是否在屏幕内
    beq     @@end
    ldr     r0,=185h
    bl      PlaySound

@@end:
    pop     r0
    bx      r0
.pool

PoseFour:
    push    r4,lr
    ldr     r4,=CurrSpriteDataStrat
    mov     r1,r4
    add     r1,26h
    mov     r0,1h
    strb    r0,[r1]        ;待机时间写入1
    bl      CheckAnimation
    cmp     r0,0h
    beq     @@end
    mov     r1,r4
    add     r1,24h
    mov     r0,5h
    strb    r0,[r1]        ;pose写入5
    ldrh    r1,[r4]
    mov     r0,4h
    mov     r2,0h
    orr     r0,r1
    strh    r0,[r4]        ;取向ORR4 图像消失
    ldr     r0,=SpriteRNG
    ldrb    r0,[r0]    
    lsl     r0,r0,2h
    add     r0,78h
    mov     r1,r4
    add     r1,2Fh
    strb    r0,[r1]        ;随机数再次写入
    ldr     r0,=NoGfxOAM
    str     r0,[r4,18h]
    strb    r2,[r4,1Ch]
    mov     r0,0h
    strh    r0,[r4,16h]

@@end:
    pop     r4
    pop     r0
    bx      r0

PoseFive:
    push    lr
    ldr     r1,=CurrSpriteDataStrat
    mov     r0,r1
    add     r0,26h
    mov     r3,1h
    strb    r3,[r0]         ;待机时间写入1
    mov     r2,r1
    add     r2,2Fh
    ldrb    r0,[r2]         ;读取设定值
    sub     r0,1h
    strb    r0,[r2]         ;减1再写入
    lsl     r0,r0,18h
    cmp     r0,0h
    bne     @@end
    mov     r0,r1
    add     r0,24h
	mov     r3,6h           ;pose写6
    strb    r3,[r0]
    ldrh    r0,[r1,6h]      ;备份的坐标再次写入
    strh    r0,[r1,2h]
    ldrh    r0,[r1,8h]
    strh    r0,[r1,4h]    
	
@@end:
    pop     r0
    bx      r0
.pool

PoseSix:
    push    r4,lr
	bl      FireFlowerSetInital
	mov     r1,r12
    ldrh    r0,[r1,2h]
    strh    r0,[r1,6h]     ;写入备份的Y坐标
	pop     r4
	pop     r0
	bx      r0
.pool
	
FireFlowerSetInital:	
    ldr     r0,=CurrSpriteDataStrat
    mov     r12,r0
    ldrh    r1,[r0]
    ldr     r0,=0FFFBh
    and     r0,r1
    mov     r2,0h
    mov     r3,0h      ;取向AND FFFB 去四
    mov     r1,r12
    strh    r0,[r1]    ;再写入
    add     r1,22h
    mov     r0,3h
    strb    r0,[r1]    ;可能是自由内存写入设定值3
    mov     r0,r12
    add     r0,25h
    strb    r2,[r0]    ;属性写入0
    add     r1,5h
    mov     r0,10h
    strb    r0,[r1]    ;上部视界写入10h
    add     r1,1h
    mov     r0,8h
    strb    r0,[r1]    ;左右视界写入8h
    add     r1,1h
    mov     r0,18h
    strb    r0,[r1]    ;下部视界写入18h
    ldr     r1,=0FFFCh
    mov     r4,r12
    strh    r1,[r4,0Ah] ;上分界
    mov     r0,4h
    strh    r0,[r4,0Ch]
    strh    r1,[r4,0Eh]
    strh    r0,[r4,10h] ;四面分界
    mov     r1,r12
    add     r1,24h
    mov     r0,1h
    strb    r0,[r1]     ;pose写入1
    ldr     r0,=FireFlowerOAM
    str     r0,[r4,18h]
    strb    r2,[r4,1Ch]
    strh    r3,[r4,16h]
	ldr     r0,=SpriteRNG
    ldrb    r0,[r0]        ;读取随机数 
    lsl     r0,r0,2h       ;乘以4
    add     r0,78h         ;加上78h
    add     r4,2Fh
    strb    r0,[r4]        ;数值备份到自由内存
    bx      r14
.pool
	
;主程序
FireMain:
    push    lr
    ldr     r0,=CurrSpriteDataStrat
    add     r0,24h
    ldrb    r0,[r0]         ;读取POSE
    cmp     r0,36h
    bls     @@Pass
    b       PoseSixBl

@@Pass:
    lsl     r0,r0,2h
    ldr     r1,=PoseTable
    add     r0,r0,r1
    ldr     r0,[r0]
    mov     r15,r0
.pool

PoseTable:
   .word PoseZeroBl
   .Word PoseOneBl
   .word PoseTwoBl
   .word PoseThreeBl
;   .word PoseThx2Bl
   .word PoseFourBl
   .word PoseFiveBl
   .word PoseSixBl
.pool
   
PoseZeroBl:   
    bl      PoseZero
    b       @Return
PoseOneBl:
    bl      PoseOne
    b       @Return
PoseTwoBl:
    bl      PoseTwo
    b       @Return
PoseThreeBl:
    bl      PoseThree
;PoseThx2Bl:
    bl      PoseThx2

PoseFourBl:
    bl      PoseFour
    b       @Return
PoseFiveBl:
    bl      PoseFive
	b       @Return
PoseSixBl:
    bl      PoseSix	

@Return:
    pop     r0
    bx      r0

.pool

.Close
