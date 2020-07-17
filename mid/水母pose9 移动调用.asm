MetroidMoveAI:
080353DC B5F0     push    r4-r7,lr
080353DE 4657     mov     r7,r10
080353E0 464E     mov     r6,r9
080353E2 4645     mov     r5,r8
080353E4 B4E0     push    r5-r7
080353E6 B085     add     sp,-14h
080353E8 9C0D     ldr     r4,[sp,34h]  ;读取2h
080353EA 0400     lsl     r0,r0,10h
080353EC 0C00     lsr     r0,r0,10h 
080353EE 9000     str     r0,[sp]      ;Y坐标 samus头顶
080353F0 0409     lsl     r1,r1,10h
080353F2 0C09     lsr     r1,r1,10h
080353F4 9101     str     r1,[sp,4h]   ;X坐标
080353F6 0612     lsl     r2,r2,18h    
080353F8 0E12     lsr     r2,r2,18h    ;1Eh
080353FA 9202     str     r2,[sp,8h]
080353FC 061B     lsl     r3,r3,18h
080353FE 0E1B     lsr     r3,r3,18h    ;28h
08035400 9303     str     r3,[sp,0Ch]
08035402 0624     lsl     r4,r4,18h
08035404 0E24     lsr     r4,r4,18h
08035406 46A1     mov     r9,r4
08035408 2000     mov     r0,0h
0803540A 9004     str     r0,[sp,10h]  ;碰到墙壁的flag
0803540C 4682     mov     r10,r0       ;r10归零
0803540E 4811     ldr     r0,=3000738h
08035410 8846     ldrh    r6,[r0,2h]   ;精灵 y
08035412 8887     ldrh    r7,[r0,4h]   ;精灵 x
08035414 8801     ldrh    r1,[r0]      ;取向
08035416 2080     mov     r0,80h
08035418 0080     lsl     r0,r0,2h
0803541A 4008     and     r0,r1        ;检查取向是否有200h
0803541C 2800     cmp     r0,0h
0803541E D01D     beq     @@LeftMove
;--------------------------------------有200h则检查右边
08035420 1C34     mov     r4,r6
08035422 3C30     sub     r4,30h       ;Y坐标向上30h
08035424 1C3D     mov     r5,r7
08035426 353C     add     r5,3Ch       ;X坐标向右3Ch
08035428 1C20     mov     r0,r4
0803542A 1C29     mov     r1,r5
0803542C F7DAF92C bl      800F688h     ;检查右上角是否碰触到砖块
08035430 4909     ldr     r1,=30007F1h
08035432 4688     mov     r8,r1
08035434 7808     ldrb    r0,[r1]
08035436 2800     cmp     r0,0h
08035438 D108     bne     @@RightHaveBlock
0803543A 1C30     mov     r0,r6
0803543C 3010     add     r0,10h       ;Y坐标向下10h
0803543E 1C29     mov     r1,r5
08035440 F7DAF922 bl      800F688h     ;检查右下角是否碰触到砖块
08035444 4641     mov     r1,r8
08035446 7808     ldrb    r0,[r1]
08035448 2800     cmp     r0,0h
0803544A D024     beq     @@Peer

@@RightHaveBlock:
0803544C 2301     mov     r3,1h
0803544E 9304     str     r3,[sp,10h]  ;碰砖flag写入1
08035450 E021     b       @@Peer
.pool

@@LeftMove:
0803545C 1C34     mov     r4,r6
0803545E 3C30     sub     r4,30h       ;Y坐标向上30h
08035460 1C3D     mov     r5,r7
08035462 3D3C     sub     r5,3Ch       ;X坐标向左3Ch
08035464 1C20     mov     r0,r4
08035466 1C29     mov     r1,r5
08035468 F7DAF90E bl      800F688h     ;检查砖块
0803546C 4803     ldr     r0,=30007F1h
0803546E 4680     mov     r8,r0
08035470 7800     ldrb    r0,[r0]
08035472 2800     cmp     r0,0h
08035474 D004     beq     @@ContinueCheck
08035476 2101     mov     r1,1h
08035478 9104     str     r1,[sp,10h]  ;左上有砖则flag写入1
0803547A E00C     b       @@Peer
.pool

@@ContinueCheck:
08035480 1C30     mov     r0,r6
08035482 3010     add     r0,10h       ;Y坐标向下10h
08035484 1C29     mov     r1,r5        ;X坐标向左3Ch
08035486 F7DAF8FF bl      800F688h
0803548A 4643     mov     r3,r8
0803548C 7818     ldrb    r0,[r3]
0803548E 2800     cmp     r0,0h
08035490 D001     beq     @@Peer
08035492 2001     mov     r0,1h
08035494 9004     str     r0,[sp,10h]  ;砖块flag

@@Peer:
08035496 481F     ldr     r0,=3000738h
08035498 8801     ldrh    r1,[r0]      ;读取取向
0803549A 2080     mov     r0,80h
0803549C 00C0     lsl     r0,r0,3h
0803549E 4008     and     r0,r1        ;检查是否有400h 
080354A0 2800     cmp     r0,0h
080354A2 D001     beq     @@NoDownMove
080354A4 1C34     mov     r4,r6
080354A6 3418     add     r4,18h       ;Y坐标向下18h

@@NoDownMove:
080354A8 1C39     mov     r1,r7
080354AA 3920     sub     r1,20h       ;X坐标向左20h 
080354AC 1C20     mov     r0,r4        ;Y坐标向上30h或向下18h
080354AE F7DAF8EB bl      800F688h     ;检查砖块
080354B2 4D19     ldr     r5,=30007F1h
080354B4 7828     ldrb    r0,[r5]
080354B6 2800     cmp     r0,0h
080354B8 D107     bne     @@UpDownBlock
080354BA 1C39     mov     r1,r7
080354BC 3120     add     r1,20h       ;X坐标向右20h
080354BE 1C20     mov     r0,r4
080354C0 F7DAF8E2 bl      800F688h     ;检查砖块
080354C4 7828     ldrb    r0,[r5]
080354C6 2800     cmp     r0,0h
080354C8 D004     beq     @@NoDownBlock

@@UpDownBlock:
080354CA 4650     mov     r0,r10
080354CC 3001     add     r0,1h
080354CE 0600     lsl     r0,r0,18h
080354D0 0E00     lsr     r0,r0,18h
080354D2 4682     mov     r10,r0       ;如果碰到天花板或地面则从0加1

@@NoDownBlock:
080354D4 2500     mov     r5,0h
080354D6 4A0F     ldr     r2,=3000738h
080354D8 8811     ldrh    r1,[r2]
080354DA 2080     mov     r0,80h
080354DC 0080     lsl     r0,r0,2h      ;检查取向是否有200h
080354DE 4008     and     r0,r1
080354E0 2800     cmp     r0,0h
080354E2 D031     beq     @@MoveLeft
080354E4 9904     ldr     r1,[sp,10h]   ;读取碰壁flag
080354E6 2900     cmp     r1,0h
080354E8 D12C     bne     @@RightMoveHaveBlock
080354EA 1C14     mov     r4,r2
080354EC 342D     add     r4,2Dh        ;读取偏移2D的值
080354EE 7823     ldrb    r3,[r4]       ;水平速度减速值
080354F0 2B00     cmp     r3,0h         ;在Pose 8写入0 故不减速
080354F2 D113     bne     @@WillDeccelRight
080354F4 8891     ldrh    r1,[r2,4h]    ;精灵X
080354F6 9801     ldr     r0,[sp,4h]    ;samus X
080354F8 3804     sub     r0,4h         ;samus X向左4h
080354FA 4281     cmp     r1,r0         ;两者相比
080354FC DC31     bgt     @@MetroidPassSamus     ;精灵在右边
080354FE 1C11     mov     r1,r2
08035500 312E     add     r1,2Eh
08035502 7808     ldrb    r0,[r1]       ;水平加速值 
08035504 9B03     ldr     r3,[sp,0Ch]   ;读取设定的水平限制速度28
08035506 4298     cmp     r0,r3
08035508 D201     bcs     @@PassAddXSpeed ;水平加速值大于限制值
0803550A 3001     add     r0,1h
0803550C 7008     strb    r0,[r1]       ;水平加速值再加1写入

@@PassAddXSpeed:
0803550E 7808     ldrb    r0,[r1]       ;读取水平加速值
08035510 E00F     b       @@GoRight
.pool

@@WillDeccelRight:
0803551C 4808     ldr     r0,=3000C77h   ;8bit循环数
0803551E 7801     ldrb    r1,[r0]
08035520 2001     mov     r0,1h
08035522 4008     and     r0,r1
08035524 2800     cmp     r0,0h          ;二分之一的可能
08035526 D101     bne     @@NoDeccel
08035528 1E58     sub     r0,r3,1
0803552A 7020     strb    r0,[r4]        ;水平减速增加

@@NoDeccel:        
0803552C 7820     ldrb    r0,[r4]
0803552E 2800     cmp     r0,0h          ;查看速度是否已经是零了
08035530 D03C     beq     @@DoneDeccel   ;减速已经完成

@@GoRight:
08035532 4649     mov     r1,r9          ;设定值2h
08035534 4108     asr     r0,r1          ;无论加速还是减速都除以4
08035536 8893     ldrh    r3,[r2,4h]     ;读取精灵X坐标
08035538 18C0     add     r0,r0,r3       ;加上计算得的值
0803553A 8090     strh    r0,[r2,4h]     ;再写入
0803553C E039     b       @@SwitchCheck
.pool

@@RightMoveHaveBlock:
08035544 2502     mov     r5,2h          ;2标记撞了墙
08035546 E036     b       @@SwitchDirection

@@MoveLeft:
08035548 9804     ldr     r0,[sp,10h]    ;读取撞墙flag是否为1
0803554A 2800     cmp     r0,0h
0803554C D130     bne     @@WallHit
0803554E 1C14     mov     r4,r2
08035550 342D     add     r4,2Dh
08035552 7823     ldrb    r3,[r4]        ;水平减速值
08035554 2B00     cmp     r3,0h
08035556 D115     bne     @@CheckDeccelLeft
08035558 8891     ldrh    r1,[r2,4h]     ;读取精灵X坐标
0803555A 9801     ldr     r0,[sp,4h]     ;读取samus x
0803555C 3004     add     r0,4h          ;samus x坐标向右4h
0803555E 4281     cmp     r1,r0
08035560 DA04     bge     @@RightSprite  ;精灵在右边 

@@MetroidPassSamus
08035562 1C10     mov     r0,r2          
08035564 302E     add     r0,2Eh
08035566 7800     ldrb    r0,[r0]        ;读取水平加速值
08035568 7020     strb    r0,[r4]        ;写入水平减速值
0803556A E022     b       @@SwitchCheck

@@RightSprite:
0803556C 1C11     mov     r1,r2
0803556E 312E     add     r1,2Eh
08035570 7808     ldrb    r0,[r1]        ;水平加速值
08035572 9B03     ldr     r3,[sp,0Ch]    ;设定的水平限制速度 28h
08035574 4298     cmp     r0,r3
08035576 D201     bcs     @@NoAccele
08035578 3001     add     r0,1h
0803557A 7008     strb    r0,[r1]        ;加速值再增加

@@NoAccele:
0803557C 7809     ldrb    r1,[r1]        ;读取加速值
0803557E 4648     mov     r0,r9
08035580 4101     asr     r1,r0          ;除法运算
08035582 E00D     b       @@MetroidMoveLeft

@@CheckDeccelLeft:
08035584 4808     ldr     r0,=3000C77h
08035586 7801     ldrb    r1,[r0]        ;8bit循环数
08035588 2001     mov     r0,1h
0803558A 4008     and     r0,r1
0803558C 2800     cmp     r0,0h          ;二分之一的可能减速
0803558E D101     bne     @@PassDeccel
08035590 1E58     sub     r0,r3,1
08035592 7020     strb    r0,[r4]

@@PassDeccel:
08035594 7820     ldrb    r0,[r4]
08035596 2800     cmp     r0,0h
08035598 D008     beq     @@DoneDeccel
0803559A 1C01     mov     r1,r0
0803559C 464B     mov     r3,r9
0803559E 4119     asr     r1,r3

@@MetroidMoveLeft:
080355A0 8890     ldrh    r0,[r2,4h]
080355A2 1A40     sub     r0,r0,r1
080355A4 8090     strh    r0,[r2,4h]     ;水平速度减然后再写入
080355A6 E004     b       @@SwitchCheck
.pool

@@DoneDeccel:
080355AC 2501     mov     r5,1h          ;"完成减速"
080355AE E002     b       @@SwitchDirection

@@WallHit:
080355B0 2502     mov     r5,2h          ;碰墙

@@SwitchCheck:
080355B2 2D00     cmp     r5,0h
080355B4 D012     beq     @@CheckVertical

@@SwitchDirection:
080355B6 8810     ldrh    r0,[r2]
080355B8 2380     mov     r3,80h
080355BA 009B     lsl     r3,r3,2h      
080355BC 1C19     mov     r1,r3
080355BE 4048     eor     r0,r1          ;左右方向标记转换
080355C0 8010     strh    r0,[r2]        ;再写入
080355C2 2D02     cmp     r5,2h
080355C4 D106     bne     @@NoHitWall
080355C6 1C11     mov     r1,r2
080355C8 312D     add     r1,2Dh
080355CA 2000     mov     r0,0h
080355CC 7008     strb    r0,[r1]        ;减速值归零
080355CE 3101     add     r1,1h          ;偏移2E写入10h 反弹
080355D0 2010     mov     r0,10h
080355D2 E002     b       @@Write

@@NoHitWall:
080355D4 1C11     mov     r1,r2
080355D6 312E     add     r1,2Eh         ;偏移2E写入1h
080355D8 2001     mov     r0,1h

@@Write:
080355DA 7008     strb    r0,[r1]

@@CheckVertical:
080355DC 2500     mov     r5,0h
080355DE 8811     ldrh    r1,[r2]
080355E0 2080     mov     r0,80h
080355E2 00C0     lsl     r0,r0,3h
080355E4 4008     and     r0,r1          ;取向检查是否有400
080355E6 2800     cmp     r0,0h
080355E8 D02C     beq     @@MoveUp
080355EA 4650     mov     r0,r10
080355EC 2800     cmp     r0,0h
080355EE D127     bne     @@HitFloorOrCeiling  ;碰到地面或天花板
080355F0 1C14     mov     r4,r2
080355F2 342C     add     r4,2Ch
080355F4 7823     ldrb    r3,[r4]              ;读取垂直减速值
080355F6 2B00     cmp     r3,0h
080355F8 D10E     bne     @@CheckDeccelDown
080355FA 8851     ldrh    r1,[r2,2h]           ;读取Y坐标
080355FC 9800     ldr     r0,[sp]              ;samus头部Y坐标
080355FE 3804     sub     r0,4h                ;向上4h
08035600 4281     cmp     r1,r0
08035602 DC2C     bgt     @@MetroidPassSamus2  ;水母在samus头部下面
08035604 1C11     mov     r1,r2
08035606 312F     add     r1,2Fh
08035608 7808     ldrb    r0,[r1]              ;垂直加速值
0803560A 9B02     ldr     r3,[sp,8h]           ;1E垂直速度限制
0803560C 4298     cmp     r0,r3
0803560E D201     bcs     @@PassYAccele
08035610 3001     add     r0,1h
08035612 7008     strb    r0,[r1]              ;垂直加速值加一再写入

@@PassYAccele:
08035614 7808     ldrb    r0,[r1]              ;读取垂直加速值
08035616 E00A     b       @@MoveDown

@@CheckDeccelDown:
08035618 4808     ldr     r0,=3000C77h         ;8bit循环数
0803561A 7801     ldrb    r1,[r0]
0803561C 2001     mov     r0,1h
0803561E 4008     and     r0,r1                ;一半的几率减速值减小
08035620 2800     cmp     r0,0h
08035622 D001     beq     @@PassDownDeccel
08035624 1E58     sub     r0,r3,1              ;减速值减1再写入
08035626 7020     strb    r0,[r4]              

@@PassDownDeccel
08035628 7820     ldrb    r0,[r4]
0803562A 2800     cmp     r0,0h                ;比较减速值是否为0
0803562C D03C     beq     @@DeccelDone

@@MoveDown:
0803562E 4649     mov     r1,r9
08035630 4108     asr     r0,r1                ;速度除4再写入
08035632 8853     ldrh    r3,[r2,2h]           ;向下移动坐标写入
08035634 18C0     add     r0,r0,r3
08035636 8050     strh    r0,[r2,2h]
08035638 E039     b       @@HitCheck
.pool

@@HitFloorOrCeiling:
08035640 2502     mov     r5,2h
08035642 E036     b       @@SwitchDirection2

@@MoveUp:
08035644 4650     mov     r0,r10
08035646 2800     cmp     r0,0h
08035648 D130     bne     @@HitFloorOrCeiling2   ;是否碰上下壁flag
0803564A 1C14     mov     r4,r2
0803564C 342C     add     r4,2Ch                 ;减速值
0803564E 7823     ldrb    r3,[r4]
08035650 2B00     cmp     r3,0h
08035652 D115     bne     8035680h
08035654 8851     ldrh    r1,[r2,2h]
08035656 9800     ldr     r0,[sp]
08035658 3004     add     r0,4h
0803565A 4281     cmp     r1,r0
0803565C DA04     bge     8035668h

@@MetroidPassSamus2:
0803565E 1C10     mov     r0,r2
08035660 302F     add     r0,2Fh
08035662 7800     ldrb    r0,[r0]
08035664 7020     strb    r0,[r4]
08035666 E022     b       @@HitCheck
08035668 1C11     mov     r1,r2
0803566A 312F     add     r1,2Fh
0803566C 7808     ldrb    r0,[r1]
0803566E 9B02     ldr     r3,[sp,8h]
08035670 4298     cmp     r0,r3
08035672 D201     bcs     8035678h
08035674 3001     add     r0,1h
08035676 7008     strb    r0,[r1]
08035678 7809     ldrb    r1,[r1]
0803567A 4648     mov     r0,r9
0803567C 4101     asr     r1,r0
0803567E E00D     b       803569Ch


08035680 4808     ldr     r0,=3000C77h
08035682 7801     ldrb    r1,[r0]
08035684 2001     mov     r0,1h
08035686 4008     and     r0,r1
08035688 2800     cmp     r0,0h
0803568A D001     beq     8035690h
0803568C 1E58     sub     r0,r3,1
0803568E 7020     strb    r0,[r4]
08035690 7820     ldrb    r0,[r4]
08035692 2800     cmp     r0,0h
08035694 D008     beq     80356A8h
08035696 1C01     mov     r1,r0
08035698 464B     mov     r3,r9
0803569A 4119     asr     r1,r3
0803569C 8850     ldrh    r0,[r2,2h]
0803569E 1A40     sub     r0,r0,r1
080356A0 8050     strh    r0,[r2,2h]
080356A2 E004     b       @@HitCheck
.pool

@@DeccelDone:
080356A8 2501     mov     r5,1h
080356AA E002     b       @@SwitchDirection2

@@HitFloorOrCeiling2:
080356AC 2502     mov     r5,2h

@@HitCheck:
080356AE 2D00     cmp     r5,0h
080356B0 D012     beq     80356D8h

@@SwitchDirection2:
080356B2 8810     ldrh    r0,[r2]
080356B4 2380     mov     r3,80h
080356B6 00DB     lsl     r3,r3,3h
080356B8 1C19     mov     r1,r3
080356BA 4048     eor     r0,r1
080356BC 8010     strh    r0,[r2]
080356BE 2D02     cmp     r5,2h
080356C0 D106     bne     80356D0h
080356C2 1C11     mov     r1,r2
080356C4 312C     add     r1,2Ch
080356C6 2000     mov     r0,0h
080356C8 7008     strb    r0,[r1]
080356CA 3103     add     r1,3h
080356CC 2010     mov     r0,10h
080356CE E002     b       80356D6h
080356D0 1C11     mov     r1,r2
080356D2 312F     add     r1,2Fh
080356D4 2001     mov     r0,1h
080356D6 7008     strb    r0,[r1]
080356D8 B005     add     sp,14h
080356DA BC38     pop     r3-r5
080356DC 4698     mov     r8,r3
080356DE 46A1     mov     r9,r4
080356E0 46AA     mov     r10,r5
080356E2 BCF0     pop     r4-r7
080356E4 BC01     pop     r0
080356E6 4700     bx      r0
.pool