.gba
.open"zm.gba","thornpuyo.gba",0x8000000

.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel DirectionTag,800F8E0h       ;检查敌人与samus的左右位置
.definelabel SpriteDataPointers,82b0d68h
.definelabel SamusData,30013d4h
.definelabel CheckRange,800FDE0h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel CheckAnimation,800FBC8h
.definelabel CheckAnimation2,800FC00h
.definelabel CurrSprite,3000738h
.definelabel DeathFireWorks,8011084h
.definelabel SpriteDrop,800E3D4h
.definelabel FrozenRoutine,800FFE8h
.definelabel StunSprite,8011280h
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel ThornPuyoID,93h
.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteRNG,300083Ch
.definelabel BGDataStart,300009Ch
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0
.definelabel SetTheDirection,800F8B0h

.org SpriteAiStart +( ThornPuyoID * 4 )       ;改写ai的地址
    .word ThornpuyoMain + 1
/////////////////////////////////////////////////


.org SpriteGfxPointers + ( ThornPuyoID - 0x10 ) * 4
    .word ThornPuyoGfx

.org SpritePalPointers + ( ThornPuyoID - 0x10 ) * 4
    .word ThornPuyoPal
	
/////////////////////////////////////////////////	
.org 8304054h
ThornPuyo0:
    push    r4,lr	
    ldr     r0,=CurrSprite	
    mov     r12,r0	
    add     r0,27h	
    mov     r3,0h	
    mov     r1,10h	
    strb    r1,[r0]     ;上视界	
    mov     r0,r12	
    add     r0,28h	
    strb    r3,[r0]     ;左右视界	
    add     r0,1h	
    strb    r1,[r0]     ;下视界	
    mov     r2,0h	
    ldr     r1,=0FFE0h	
    mov     r4,r12	
    strh    r1,[r4,0Ah] ;上分界	
    mov     r0,4h	
    strh    r0,[r4,0Ch] ;下分界	
    strh    r1,[r4,0Eh] ;左分界	
    mov     r0,20h	
    strh    r0,[r4,10h] ;右分界	
    ldr     r0,=ThoronPuyoReMoveOAM ;remove 常态?
    str     r0,[r4,18h]	
    strb    r2,[r4,1Ch]	
    strh    r3,[r4,16h]	
    ldr     r2,=SpriteDataPointers;精灵基本数据起始	
    ldrb    r1,[r4,1Dh]	
    lsl     r0,r1,3h	
    add     r0,r0,r1	
    lsl     r0,r0,1h	
    add     r0,r0,r2	
    ldrh    r0,[r0]      ;读取设定血量写入	
    strh    r0,[r4,14h]	
    mov     r1,r12	
    add     r1,25h	
    mov     r0,4h	
    strb    r0,[r1]      ;属性写入4	
    sub     r1,1h	
    mov     r0,1h	
    strb    r0,[r1]	     ;pose写入1
	bl      SetTheDirection
@@end:	
    pop     r4	
    pop     r0	
    bx      r0	
.pool
	
////////////////////////////////////////////////	
ThornPuyo5:              ;非跳跃的下落	
    ldr     r3,=CurrSprite	
    mov     r2,r3	
    add     r2,24h	
    mov     r1,0h	
    mov     r0,6h	
    strb    r0,[r2]    ;pose写入6h	
    mov     r0,r3	
    add     r0,31h	
    strb    r1,[r0]    ;计数器清零	
    ldr     r0,=ThoronPuyoReMoveOAM  ;remove	
    str     r0,[r3,18h]	
    strb    r1,[r3,1Ch]	
    strh    r1,[r3,16h]	
    bx      r14	
.pool	

//////////////////////////////////////////////////////////////////	
ThornPuyo1:	
    ldr     r1,=CurrSprite	
    mov     r2,r1	
    add     r2,24h	
    mov     r3,0h	
    mov     r0,2h	
    strb    r0,[r2]     ;pose写入2h	
    ldr     r0,=ThoronPuyoMoveOAM  ;move	
    str     r0,[r1,18h]	
    strb    r3,[r1,1Ch]	
    strh    r3,[r1,16h]	
    bx      r14	
.pool	

////////////////////////////////////////////////////////////////////	
ThornPuyo2:                  ;移动 检查
    push    r4-r6,lr	
    ldr     r4,=CurrSprite
    ldrh    r2,[r4]	
    ldrh    r0,[r4,16h]  ;读取精灵动画	
    cmp     r0,0h	
    bne     @@NoPlaySound	
    ldrb    r0,[r4,1Ch]  ;读取精灵动画帧	
    cmp     r0,1h	
    bne     @@NoPlaySound	
    mov     r0,2h	
    and     r0,r2	
    cmp     r0,0h        ;检查是否在屏幕	
    beq     @@NoPlaySound	
    mov     r0,99h
    lsl     r0,r0,2h	
    bl      PlaySound2     ;播放移动声音	
	
@@NoPlaySound:
    ldrh    r0,[r4,2h]
	add		r0,20h
    ldrh    r1,[r4,4h]	
    bl      CheckBlock2     ;检查下方是否有砖	
    ldr     r0,=XTagRAM	
    ldrb    r0,[r0]	
    cmp     r0,0h	
    bne     @@OnFloor	
    mov     r0,r4
    add     r0,24h	
    mov     r1,05h       ;pose写入下落的pose	
    b       @@WillEnd	
.pool
	
@@OnFloor:	
    ldrh    r1,[r4]	
    mov     r6,40h	
    mov     r0,40h	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@FaceLeft	
    ldrh    r0,[r4,2h]	
	sub     r0,10h
    ldrh    r1,[r4,4h]	
    add     r1,40h       ;检查右边一格是否有砖	
    bl      CheckBlock   ;检查砖块	
    ldr     r5,=YTagRAM	
    ldrb    r0,[r5]	
	mov     r1,10h
	and     r0,r1
    cmp     r0,0h	
    bne     @@HaveBlock	
    ldrh    r0,[r4,2h]	
    ldrh    r1,[r4,4h]	
    add     r1,40h	
    b       @@CountCheck	
.pool
	
@@FaceLeft:	
    ldrh    r0,[r4,2h]	
	sub     r0,10h
    ldrh    r1,[r4,4h]	
    sub     r1,40h      ;检查左边一格有没有砖	
    bl      CheckBlock	
    ldr     r5,=YTagRAM	
    ldrb    r0,[r5]	
	mov     r1,10h
	and     r0,r1
    cmp     r0,0h	
    bne     @@HaveBlock	
    ldrh    r0,[r4,2h]	
    ldrh    r1,[r4,4h]	
    sub     r1,40h	
	
@@CountCheck:	
    bl      CheckBlock     ;检查左右身下一格是否有砖	
    ldrb    r1,[r5]	
    mov     r0,0Fh	
    and     r0,r1	
    cmp     r0,0h	
    bne     @@CanMove	
	mov     r1,r4
	b       @@WriteJumpPose
.pool

@@HaveBlock:
    ldr     r1,=SpriteRNG
    ldrb    r1,[r1]
    mov     r0,1h
    and     r0,r1
    cmp     r0,0h
    beq     @@WriteJumpPose	
                	
    ldrh    r0,[r4]	
    eor     r0,r6	
    strh    r0,[r4]        ;换向	
    mov     r1,r4	
    add     r1,24h	
    mov     r0,3h	
    strb    r0,[r1]        ;pose 写入3	
    b       @@end	
.pool
	
@@CanMove:                ;可以移动
    ldr     r1,=SpriteRNG
	ldrb    r0,[r4,6h]    ;检查移动未完成的flag
	cmp     r0,0h
	bne     @@Move
	ldrb    r1,[r1]
	mov     r0,1h
	and     r0,r1
	strb    r0,[r4,6h]
	cmp     r0,0h
	bne     @@Move
	b       @@WriteJumpPose
;    ldr     r1,=CurrSprite
.pool

@@Move:	
    ldrh    r2,[r4,16h]	
    sub     r0,r2,4     ;动画减4	
    lsl     r0,r0,10h	
    lsr     r0,r0,10h	
;    mov     r4,r1	
    cmp     r0,1h       	
    bhi     @@AnimationLessSix	
    mov     r3,4h	
    b       @@WriteMove	
	
	
@@AnimationLessSix:	
    mov     r3,0h	
    cmp     r2,3h	
    bne     @@WriteMove	
    mov     r3,8h	
	
@@WriteMove:	
    ldrh    r1,[r4]     ;读取取向	
    mov     r0,40h	
    and     r0,r1	
    cmp     r0,0h     	
    beq     @@MoveLeft	
    ldrh    r0,[r4,4h]	
    add     r0,r3,r0	
    b       @@WriteNewPosition	
	
@@MoveLeft:	
    ldrh    r0,[r4,4h]	
    sub     r0,r0,r3	
	
@@WriteNewPosition:	
    strh    r0,[r4,4h]	
	ldrh 	r0,[r4,2h]
	sub		r0,20h
	ldrh	r1,[r4,4h]
	bl		CheckBlock3
	cmp		r0,0h
	beq		@@PassSlope
	cmp		r0,3h
	bls		@@CeilingSlope
	mov		r1,20h
	b		@@SubY
@@CeilingSlope:
	mov		r1,10h
@@SubY:	
	ldrh 	r0,[r4,2h]
	sub		r0,r0,r1
	strh 	r0,[r4,2h]
	
@@PassSlope:	

    bl CheckAnimation    ;检查动画是否结束	
    cmp     r0,0h	
    beq     @@end
	mov     r0,0h
	strb    r0,[r4,6h]   ;去掉移动未完成的标记
    ldr     r1,=SpriteRNG
    ldrb    r1,[r1]
    mov     r0,1h
    and     r0,r1
    cmp     r0,0h
    beq     @@WriteJumpPose	
    mov     r1,0C0h	
    lsl     r1,r1,1h	
    mov     r0,r1	
    bl      CheckRange    ;检查精灵与samus的位置,范围中	
    cmp     r0,4h	
    bne     @@SamusNoAtLeft		
    ldrh    r2,[r4]	
    ldr     r0,=0FFBFh   ;去掉向右的面向	
    and     r0,r2	
    b       @@WriteDirection	
.pool
	
@@SamusNoAtLeft:	
    cmp     r0,8h	
    beq     @@SamusNear
    ldr     r1,=SpriteRNG	
    mov     r0,1h
	ldrb    r1,[r1]
	and     r0,r1
	cmp     r0,0h
	beq     @@SamusNoNear
	bl      SetTheDirection
	b       @@WriteJumpPose
.pool
	
@@SamusNear:	
    ldrh    r2,[r4]	
    mov     r0,40h	
    orr     r0,r2       ;面向右	
	
@@WriteDirection:	
    strh    r0,[r4]
	
@@WriteJumpPose:
    mov     r1,r4	
    add     r1,24h	
    mov     r0,7h	
    strb    r0,[r1]     ;pose写入7h	
    b       @@end	
	
@@SamusNoNear:	
    mov     r0,r4	
    add     r0,24h	
    mov     r1,3h       ;pose写入3
	
@@WillEnd:	
    strb    r1,[r0]     	
	
@@end:	
    pop     r4-r6	
    pop     r0	
    bx      r0	
.pool
	
//////////////////////////////////////////////////////////////////////	
ThornPuyo3:	              ;要移动处脚下无砖或附近无人的待机
    ldr     r1,=CurrSprite	
    mov     r3,r1	
    add     r3,24h	
    mov     r2,0h	
    mov     r0,4h	
    strb    r0,[r3]       ;pose写入4h	
    strb    r2,[r1,1Ch]	
    strh    r2,[r1,16h]	
    ldr     r0,=ThoronPuyoReMoveOAM  ;remove	
    str     r0,[r1,18h]	
    ldr     r0,=SpriteRNG  ;随机值	
    ldrb    r0,[r0]	
    lsr     r0,r0,3h      ;乘4加1	
    add     r0,1h	
    add     r1,2Eh	
    strb    r0,[r1]       ;写入2E偏移	
    bx      r14	
.pool
	
////////////////////////////////////////////////////////////////	
ThornPuyo4:
    push    lr	
	ldr     r4,=CurrSprite
    ldrh    r0,[r4,2h]
	ldrh    r1,[r4,4h]
	bl      CheckBlock2
    ldr     r0,=XTagRAM	
    ldrb    r0,[r0]	
    cmp     r0,0h	
    bne     @@OnFloor	
    mov     r0,r4
    add     r0,24h	
    mov     r1,5h	
    strb    r1,[r0]       ;pose写入5  下落	
    b       @@end	
.pool
	
@@OnFloor:	
    bl CheckAnimation     ;检查动画	
    cmp     r0,0h	
    beq     @@end	
	bl      SetTheDirection
    ldr     r3,=CurrSprite	
    mov     r1,r3	
    add     r1,2Eh	
    ldrb    r0,[r1]       ;读取随机数设定的值	
    sub     r0,1h	
    strb    r0,[r1]       ;减一再写入	
    lsl     r0,r0,18h	
    lsr     r2,r0,18h	
    cmp     r2,0h	
    bne     @@end	
    mov     r0,r3	
    add     r0,24h	
    mov     r1,2h         ;计数器为0的时候	
    strb    r1,[r0]       ;pose写入2h	
    ldr     r0,=ThoronPuyoMoveOAM  ;move	
    str     r0,[r3,18h]	
    strb    r2,[r3,1Ch]	
    strh    r2,[r3,16h]	
	
@@end:	
    pop     r0	
    bx      r0	
.pool
	
////////////////////////////////////////////////////////////////////	
ThornPuyo7:                        ;准备跳跃
    ldr     r1,=CurrSprite	
    mov     r3,r1	
    add     r3,24h	
    mov     r2,0h	
    mov     r0,8h	
    strb    r0,[r3]        ;pose写入8h	
    strb    r2,[r1,1Ch]	
    strh    r2,[r1,16h]	
    ldr     r0,=ReThoronPuyoJumpOAM   ;rejump	
    str     r0,[r1,18h]	
    bx      r14	
.pool
	
/////////////////////////////////////////////////////////////////////	
ThornPuyo8:                ;准备跳跃
    push    lr	
    bl CheckAnimation      ;检查动画	
    cmp     r0,0h	
    beq     @@end	
    ldr     r3,=CurrSprite	
    mov     r1,r3	
    add     r1,24h	
    mov     r2,0h	
    mov     r0,9h	
    strb    r0,[r1]        ;pose 写入9  跳跃	
    strb    r2,[r3,1Ch]	
    mov     r1,0h	
    strh    r2,[r3,16h]	
    ldr     r0,=ThoronPuyoJumpOAM   ;jump	
    str     r0,[r3,18h]	
    mov     r0,r3	
    add     r0,31h	
    strb    r1,[r0]        ;偏移31清零	
    ldrh    r1,[r3]	
    mov     r0,2h	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@end	
;	mov		r0,94h
	ldr	r0,=15Ah
    bl PlaySound2          ;播放跳跃声	
	
@@end:	
    pop     r0	
    bx      r0	
.pool
	
////////////////////////////////////////////////////////////////////////	
ThornPuyo9:             ;   跳跃	
    push    r4-r7,lr	
    ldr     r4,=CurrSprite	
    ldrh    r0,[r4,2h]	
    sub     r0,20h	
    ldrh    r1,[r4,4h]     ;检查上方是否有砖?	
    bl      CheckBlock	
    ldr     r0,=YTagRAM	
    ldrb    r0,[r0]	
    cmp     r0,11h	
    bne     @@NoBlock	
    mov     r1,r4	
    add     r1,24h	
    mov     r2,0h	
    mov     r0,0Ah         ;pose 写入0Ah 落?	
    strb    r0,[r1]	
    mov     r0,r4	
    add     r0,2Fh	
    strb    r2,[r0]        ;偏移2F清零	
    b       @@end	
.pool
	
@@NoBlock:	
    mov     r3,r4	
    add     r3,2Fh	
    ldrb    r0,[r3]        ;读取偏移2f的值	
    cmp     r0,1Eh	
    bls     @@JumPointless1F	
    mov     r0,r4	
    add     r0,24h	
    mov     r2,0h	
    mov     r1,0Ah         ;大于1F的时候pose写入0Ah	
    strb    r1,[r0]	
    strb    r2,[r3]        ;同时偏移2f归零	
    b       @@PassYMove	
	
@@JumPointless1F:	
    ldrb    r2,[r3]        ;读取偏移2f的值	
    ldr     r6,=ThoronPuyoJumpYSpeed   ;跳跃速度数值	
    lsl     r0,r2,1h	
    add     r0,r0,r6	
    ldrh    r5,[r0]        ;读取速度	
    mov     r7,0h	
    ldsh    r1,[r0,r7]     ;读取速度带负	
    ldr     r0,=7FFFh	
    cmp     r1,r0          ;比较是否到了尾端	
    bne     @@SpeedValueNoEnd	
    sub     r1,r2,1        ;跳跃累计值减1	
    lsl     r1,r1,1h       ;保持最大速度	
    add     r1,r1,r6       ;加上偏移	
    ldrh    r0,[r4,2h]     ;读取Y坐标	
    ldrh    r1,[r1]        ;读取速度	
    add     r0,r0,r1       ;下降的速度加入	
    b       @@WriteNewYPosition   ;写入新的Y坐标	
.pool
	
@@SpeedValueNoEnd:	
    add     r0,r2,1        ;速度累计值加1	
    strb    r0,[r3]        ;再写入	
    ldrh    r0,[r4,2h]	
    add     r0,r0,r5	
	
@@WriteNewYPosition:	
    strh    r0,[r4,2h]	
	
@@PassYMove:	
    mov     r4,0h	
    ldr     r2,=CurrSprite	
    ldrh    r1,[r2]	
    mov     r0,40h	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@MoveLeft	
    ldrh    r0,[r2,2h]	
    sub     r0,8h         	
    ldrh    r1,[r2,4h]	
    add     r1,40h	
    bl CheckBlock      ;检查右边是否有砖块	
    ldr     r0,=YTagRAM	
    ldrb    r0,[r0]       ;有砖一般为11	
    mov     r1,0Fh	
    and     r1,r0         ;1h	
    neg     r0,r1	
    orr     r0,r1         ;FFFFFFFF?	
    lsr     r4,r0,1Fh     ;只要7A5不为0都会为1	
    b       @@CheckBlock	
.pool
	
@@MoveLeft:                             ;检查左边是否有砖或者坡?	
    ldrh    r0,[r2,2h]	
    sub     r0,8h	
    ldrh    r1,[r2,4h]	
    sub     r1,40h	
    bl CheckBlock	
    ldr     r0,=YTagRAM	
    ldrb    r1,[r0]	
    mov     r0,0Fh	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@CheckBlock	
    mov     r4,1h	
	
@@CheckBlock:	
    cmp     r4,0h	
	bne     @@end
;    beq     @@NoBlock2	
;    ldr     r2,=CurrSprite	
;    ldrh    r0,[r2]	
;    mov     r1,40h	
;    eor     r0,r1      ;面向取反再写入	
;    mov     r3,0h	
;    strh    r0,[r2]	
;    mov     r1,r2	
;    add     r1,24h	
;    mov     r0,0Ah     ;pose写入0Ah	
;    strb    r0,[r1]	
;    add     r2,2Fh	
;    strb    r3,[r2]    ;偏移2F清零 	
;    b       @@end	
	
@@NoBlock2:	
    ldr     r2,=CurrSprite	
    ldrh    r1,[r2]	
    mov     r0,40h	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@LeftMove	
    ldrh    r0,[r2,4h]	
    add     r0,3h      ;X向右2	
    b       @@WriteNewXPostion	
.pool
	
@@LeftMove:	
    ldrh    r0,[r2,4h]	
    sub     r0,3h      ;X向左2	
	
@@WriteNewXPostion:	
    strh    r0,[r2,4h]	
	
@@end:	
    pop     r4-r7	
    pop     r0	
    bx      r0	
.pool
	
///////////////////////////////////////////////////////////////	
ThornPuyoA:                 ;跳跃中下落
    push    r4-r7,lr	
    ldr     r4,=CurrSprite	
	mov		r7,r4
	add		r7,2Ch
	ldrb	r0,[r7]
	cmp		r0,0h
	bne		@@NoPlaySound
	ldrh	r0,[r4,2h]
	add		r0,40h
	ldrh 	r1,[r4,4h]
	bl		CheckBlock3
	cmp		r0,11h
	bne 	@@NoPlaySound
    ldrh    r1,[r4]	
    mov     r0,2h	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@NoPlaySound		
	ldr		r0,=15bh
    bl      PlaySound2                  ;播放落地声音?
	mov		r0,1h
	strb	r0,[r7]						;标记声音已经播放
@@NoPlaySound:	
    ldrh    r0,[r4,2h]	
    ldrh    r1,[r4,4h]	
    bl CheckBlock2              ;检查身下砖块??	
    mov     r1,r0	
    ldr     r0,=XTagRAM	
    ldrb    r0,[r0]	
    cmp     r0,0h	
    beq     @@AtAir	
    mov     r2,0h	
    mov     r3,0h	
    strh    r1,[r4,2h]             ;坐标在地面上	
    mov     r1,r4	
    add     r1,24h	
    mov     r0,0Bh	
    strb    r0,[r1]                ;pose写入0B	
	add     r1,r0
	mov     r0,0h
	strb	r0,[r7]				   ;恢复声音已经播放的flag
	strb    r0,[r1]                ;偏移2f清零
    strb    r2,[r4,1Ch]   	
    strh    r3,[r4,16h]	
    ldr     r0,=ThoronPuyoNormalOAM          ;地面常态	
    str     r0,[r4,18h]	
	b @@Peer
.pool
	
@@AtAir:	
    mov     r0,2Fh	
    add     r0,r0,r4	
    mov     r12,r0	
    ldrb    r2,[r0]               ;读取偏移31的值	
    ldr     r5,=ThoronPuyoDropYSpeed          ;掉落的速度值	
    lsl     r0,r2,1h	
    add     r0,r0,r5	
    ldrh    r3,[r0]               ;读取速度	
    mov     r6,0h	
    ldsh    r1,[r0,r6]	
    ldr     r0,=7FFFh             ;比较是否到了尾数	
    cmp     r1,r0	
    bne     @@DropSpeedNoEnd	
    sub     r1,r2,1	
    lsl     r1,r1,1h	
    add     r1,r1,r5	
    ldrh    r0,[r4,2h]            ;读取Y坐标	
    ldrh    r1,[r1]               ;读取之前的速度值	
    add     r0,r0,r1              ;相加	
    b       @@WriteNewDropPostion	
.pool
	
@@DropSpeedNoEnd:	
    add     r0,r2,1	
    mov     r1,r12	
    strb    r0,[r1]               ;累计值加一再写入	
    ldrh    r0,[r4,2h]            ;读取Y坐标加上当前的速度值	
    add     r0,r0,r3	
	
@@WriteNewDropPostion:	
    strh    r0,[r4,2h]	
	
@@Peer:	
    mov     r4,0h	
    ldr     r2,=CurrSprite	
    ldrh    r1,[r2]	
    mov     r0,40h	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@FaceLeft	
    ldrh    r0,[r2,2h]	
    sub     r0,8h	
    ldrh    r1,[r2,4h]	
    add     r1,40h               ;检查右边的砖块	
    bl CheckBlock	
    ldr     r0,=YTagRAM	
    ldrb    r0,[r0]	
    mov     r1,0Fh	
    and     r1,r0	
    neg     r0,r1	
    orr     r0,r1	
    lsr     r4,r0,1Fh	
    b       @@CheckBlock	
.pool
	
@@FaceLeft:	
    ldrh    r0,[r2,2h]	
    sub     r0,8h	
    ldrh    r1,[r2,4h]	
    sub     r1,40h	
    bl CheckBlock	
    ldr     r0,=YTagRAM	
    ldrb    r1,[r0]	
    mov     r0,0Fh	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@CheckBlock	
    mov     r4,1h	
	
@@CheckBlock:	
    ldr     r2,=CurrSprite	
    cmp     r4,0h	
    beq     @@NoBlock	
    ldrh    r0,[r2]	
    mov     r1,40h	
    eor     r0,r1       ;换面	
    strh    r0,[r2]	
	
@@NoBlock:	
    ldrh    r1,[r2]     ;读取取向	
    mov     r0,40h	
    and     r0,r1	
    cmp     r0,0h	
    beq     @@LeftDropMove	
    ldrh    r0,[r2,4h]	
    add     r0,2h       ;X坐标向右2	
    b       @@WriteDropXNewPostion	
.pool
	
@@LeftDropMove:	
    ldrh    r0,[r2,4h]	
    sub     r0,2h	
	
@@WriteDropXNewPostion:	
    strh    r0,[r2,4h]	
    pop     r4-r7	
    pop     r0	
    bx      r0	
.pool
	
//////////////////////////////////////////////////////////////////////////////	
ThornPuyoB:              ;落地动画结束就转入待机pose
    push    lr	
    bl CheckAnimation      ;检查动画结束	
    cmp     r0,0h	
    beq     @@end	
    ldr     r0,=CurrSprite	
    add     r0,24h	
    mov     r1,3h         ;pose写入3h	
    strb    r1,[r0]	
	
@@end:	
    pop     r0	
    bx      r0	
.pool
////////////////////////////////////////////////////////////
ThornPuyo6:               ;意外下落的速度
    push    r4-r6,lr
    ldr     r4,=CurrSprite
	ldrh    r0,[r4,2h]
	ldrh    r1,[r4,4h]
	bl      CheckBlock2
    mov     r1,r0
    ldr     r0,=XTagRAM
    ldrh    r0,[r0]
    cmp     r0,0h
    beq     @@NoFloor
	strh    r1,[r4,2h]
	mov     r1,r4
	add     r1,24h
	mov     r0,3h          ;彷徨的pose
	strb    r0,[r1]
	add     r1,0Bh
	mov     r0,0h
	strb    r0,[r1]        ;偏移2F清零
	b       @@end
.pool
	
@@NoFloor:
    mov     r0,2Fh
    add     r0,r0,r4
    mov     r12,r0
    ldrh    r2,[r0]
	ldr     r5,=NoJumpThoronPuyoDropYSpeed
	lsl     r0,r2,1h
	add     r0,r0,r5
	ldrh    r3,[r0]
	mov     r6,0h
	ldsh    r1,[r0,r6]
	ldr     r0,=7FFFh
	cmp     r1,r0
	bne     @@NoMaxDropYSpeed
    sub     r1,r2,1h
    lsl     r1,r1,1h
	add     r1,r1,r5
	ldrh    r0,[r4,2h]
	ldrh    r1,[r1]
	add     r0,r0,r1
	b       @@WillEnd
.pool

@@NoMaxDropYSpeed:
    add     r0,r2,1h
    mov     r1,r12
	strb    r0,[r1]
    ldrh    r0,[r4,2h]
    add     r0,r0,r3
@@WillEnd:	
	strh    r0,[r4,2h]
@@end:
    pop     r4-r6
    pop     r0
    bx      r0
.pool	
    	
	
//////////////////////////////////////////////////////////////////	
;主程序	
ThornpuyoMain:
    push    r4,lr
    add     sp,-4h	
    ldr     r4,=CurrSprite	
    mov     r0,r4	
	add     r0,32h
	ldrb    r2,[r0]       ;读取碰撞属性零点32
	mov     r1,2h
	and     r1,r2
	cmp     r1,0h
	beq     @@NoHit
	mov     r1,0FDh
	and     r1,r2
	strb    r1,[r0]
	ldrb    r0,[r4]
	mov     r1,2h
	and     r1,r0         ;检查是否在屏幕
	cmp     r1,0h
	beq     @@NoHit
	ldr     r0,=26Bh      ;挨打声
	bl      PlaySound2
@@NoHit:
    mov     r0,r4
    add     r0,30h
	ldrb    r0,[r0]       ;冰冻时间
	cmp     r0,0
	beq     @@NoFrozening
	bl      FrozenRoutine
	b       @Thend
.pool

@@NoFrozening:
    bl      StunSprite     ;检查击晕程度
    cmp     r0,0h
	beq     @@NoStun
	b       @Thend
@@NoStun:
    mov     r0,r4
    add     r0,24h
    ldrb    r0,[r0]
	cmp     r0,0Bh
	bls     @@NoDeath
	b       @OtherPose
@@NoDeath:
    lsl     r0,r0,2h
    ldr     r1,=ThornPuyoPoseTable
    add     r0,r0,r1
    ldr     r0,[r0]
    mov     r15,r0
.pool

ThornPuyoPoseTable:	
    .word @@PuyoPose0  ;00	
	.word @@PuyoPose1  ;01
	.word @@PuyoPose2  ;02
	.word @@PuyoPose3  ;03
	.word @@PuyoPose4
	.word @@PuyoPose5
	.word @@PuyoPose6
	.word @@PuyoPose7
	.word @@PuyoPose8
	.word @@PuyoPose9
	.word @@PuyoPoseA
    .word @@PuyoPoseB	
@@PuyoPose0:
    bl ThornPuyo0
	b @Thend
@@PuyoPose1:
    bl ThornPuyo1
@@PuyoPose2:	
	bl ThornPuyo2
	b @Thend
@@PuyoPose3:
    bl ThornPuyo3
@@PuyoPose4:
    bl ThornPuyo4
    b @Thend
@@PuyoPose7:
    bl ThornPuyo7
@@PuyoPose8:
    bl ThornPuyo8
    b @Thend
@@PuyoPose9:
    bl ThornPuyo9
    b @Thend
@@PuyoPoseA:
    bl ThornPuyoA
    b @Thend
@@PuyoPoseB:
    bl ThornPuyoB
    b @Thend
@@PuyoPose5:
    bl ThornPuyo5
@@PuyoPose6:
    bl ThornPuyo6
    b @Thend
@OtherPose:
    ldr     r0,=CurrSprite
    ldrh    r1,[r0,2h]
    sub     r1,20h
    ldrh    r2,[r0,4h]
    mov     r0,20h
	str     r0,[sp]
	mov     r0,0h
	mov     r3,1h
	bl      DeathFireWorks
@Thend:	
    add     sp,4h
    pop     r4	
    pop     r0	
    bx      r0	
.pool

///////////////////////////////////////////////////////
;837C578h 
ThoronPuyoJumpYSpeed:
    .halfword 0xfff0,0xfff0
	.halfword 0xfff1,0xfff1
	.halfword 0xfff2,0xfff2
	.halfword 0xfff3,0xfff3
	.halfword 0xfff4,0xfff4
	.halfword 0xfff5,0xfff5
	.halfword 0xfff6,0xfff6
	.halfword 0xfff7,0xfff7
	.halfword 0xfff8,0xfff8
	.halfword 0xfff9,0xfff9
	.halfword 0xfffa,0xfffa
	.halfword 0xfffb,0xfffb
	.halfword 0xfffc,0xfffc
	.halfword 0xfffd,0xfffd
	.halfword 0xfffe,0xfffe
	.halfword 0xffff
	.halfword 0x7fff

;837C5B8h 
ThoronPuyoDropYSpeed:
    .halfword 0,0
	.halfword 1,1
	.halfword 2,2
	.halfword 3,3
	.halfword 4,4
	.halfword 5,5
	.halfword 6
	.halfword 7
	.halfword 8
	.halfword 0x7fff

;82E49E0h
NoJumpThoronPuyoDropYSpeed:
    .halfword 4,4,4,4,4,4
	.halfword 8,8,8
	.halfword 0xc,0xc,0xc,0xc,0xc
	.halfword 0x10
	.halfword 0x7fff
	
.align
ThoronPuyoNormalOAM:      ;Pose 30   37ced4
    .word ThoronPuyoNormalOAM1
	.word 0x7
	.word ThoronPuyoNormalOAM2
	.word 0x7
	.word 0,0
	
ThoronPuyoNormalOAM1:     ;37ce2e
    .halfword 0x2
	.halfword 00f0h,51fch,8208h
	.halfword 00f8h,11f4h,822ah
	
ThoronPuyoNormalOAM2:     ;37ce3c
    .halfword 0x1
	.halfword 00f0h,51f8h,8206h
	
.align    	
ThoronPuyoReMoveOAM:      ;Pose 8    37ce44
     .word ThoronPuyoReMoveOAM1
	 .word 0x8
	 .word ThoronPuyoReMoveOAM2
	 .word 0x8
	 .word ThoronPuyoReMoveOAM3
	 .word 0x8
	 .word ThoronPuyoReMoveOAM2
	 .word 0x8
	 .word 0,0

ThoronPuyoReMoveOAM1:     ;37cdf8
     .halfword 0x1
	 .halfword 00f0h,41f8h,8200h
	 
ThoronPuyoReMoveOAM2:     ;37ce00
     .halfword 0x1
	 .halfword 40f8h,01f8h,8202h
	 
ThoronPuyoReMoveOAM3:     ;37Ce08
     .halfword 0x1
	 .halfword 40f8h,01f8h,8204h
	 
.align	 
ThoronPuyoMoveOAM:        ;pose 2    37ce6c
    .word ThoronPuyoReMoveOAM1
    .word 0x7
    .word ThoronPuyoMoveOAM2
    .word 0x7
    .word ThoronPuyoMoveOAM3
	.word 0x7
	.word ThoronPuyoMoveOAM4
	.word 0x7
	.word ThoronPuyoMoveOAM5
	.word 0x7
	.word ThoronPuyoMoveOAM6
	.word 0x7
	.word 0,0
	
ThoronPuyoMoveOAM2:     ;37ce10
    .halfword 0x1
	.halfword 00f0h,41f8h,8206h
	
ThoronPuyoMoveOAM3:     ;37ce18
    .halfword 0x2
	.halfword 00f0h,41f4h,8208h
	.halfword 00f8h,0004h,822ah
	
ThoronPuyoMoveOAM4:     ;37ce26
    .halfword 0x1
	.halfword 40f8h,41f0h,8222h
	
ThoronPuyoMoveOAM5:     ;37ce2e
    .halfword 0x2
	.halfword 00f0h,51fch,8208h
	.halfword 00f8h,11f4h,822ah
	
ThoronPuyoMoveOAM6:     ;37ce3c
    .halfword 0x1
	.halfword 00f0h,51f8h,8206h
	
 
.align       
ReThoronPuyoJumpOAM:      ;pose29    37cea4
    .word ThoronPuyoReMoveOAM1
	.word 0x7
	.word ThoronPuyoMoveOAM2
	.word 0x7
	.word ThoronPuyoMoveOAM3
	.word 0x7
	.word 0,0
	
.align	
ThoronPuyoJumpOAM:        ;pose 2C   37cec4 2E落 16未准备落
    .word ThoronPuyoMoveOAM4
	.word 0xff
	.word 0,0
.align


ThornPuyoGfx:	
.import "ThornPuyo.gfx.lz"

.align
ThornPuyoPal:
.import "ThornPuyo.palette"

.pool
.close