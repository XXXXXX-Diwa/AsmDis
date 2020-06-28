
;咬住后调用的
08035360 B5F0     push    r4-r7,lr     ;检查被咬住后碰撞砖块
08035362 0400     lsl     r0,r0,10h
08035364 0C04     lsr     r4,r0,10h
08035366 1C26     mov     r6,r4        ;Y坐标
08035368 0409     lsl     r1,r1,10h
0803536A 0C09     lsr     r1,r1,10h    ;X坐标
0803536C 2700     mov     r7,0h
0803536E 480B     ldr     r0,=3001588h 
08035370 304E     add     r0,4Eh
08035372 7800     ldrb    r0,[r0]      ;读取按键方向的左右
08035374 2802     cmp     r0,2h        
08035376 D115     bne     @@CheckLeft
08035378 1C20     mov     r0,r4
0803537A 3830     sub     r0,30h       ;Y坐标向上30h
0803537C 1C0D     mov     r5,r1
0803537E 353C     add     r5,3Ch       ;X坐标向右3Ch
08035380 1C29     mov     r1,r5
08035382 F7DAF981 bl      800F688h     ;检查砖块
08035386 4E06     ldr     r6,=30007F1h
08035388 7830     ldrb    r0,[r6]
0803538A 2800     cmp     r0,0h
0803538C D11F     bne     @@HaveBlock
0803538E 1C20     mov     r0,r4
08035390 3010     add     r0,10h      ;Y坐标向下10h
08035392 1C29     mov     r1,r5       ;X坐标向右3Ch
08035394 F7DAF978 bl      800F688h    ;检查砖块
08035398 7830     ldrb    r0,[r6]
0803539A E016     b       80353CAh
.pool

@@CheckLeft:
080353A4 2801     cmp     r0,1h
080353A6 D113     bne     @@end       ;如果没有按左右方向则结束
080353A8 1C20     mov     r0,r4
080353AA 3830     sub     r0,30h
080353AC 1C0C     mov     r4,r1
080353AE 3C3C     sub     r4,3Ch
080353B0 1C21     mov     r1,r4
080353B2 F7DAF969 bl      800F688h
080353B6 4D08     ldr     r5,=30007F1h
080353B8 7828     ldrb    r0,[r5]
080353BA 2800     cmp     r0,0h
080353BC D107     bne     80353CEh
080353BE 1C30     mov     r0,r6
080353C0 3010     add     r0,10h
080353C2 1C21     mov     r1,r4
080353C4 F7DAF960 bl      800F688h
080353C8 7828     ldrb    r0,[r5]

@@NoBlock:
080353CA 2800     cmp     r0,0h
080353CC D000     beq     @@end

@@HaveBlock:
080353CE 2701     mov     r7,1h
@@end:
080353D0 1C38     mov     r0,r7
080353D2 BCF0     pop     r4-r7
080353D4 BC02     pop     r1
080353D6 4708     bx      r1

;PoseNineCall

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


;被咬住调用
080356E8 B5F0     push    r4-r7,lr
080356EA 4657     mov     r7,r10
080356EC 464E     mov     r6,r9
080356EE 4645     mov     r5,r8
080356F0 B4E0     push    r5-r7
080356F2 B085     add     sp,-14h
080356F4 4A22     ldr     r2,=3000738h
080356F6 8851     ldrh    r1,[r2,2h]
080356F8 8893     ldrh    r3,[r2,4h]       ;读取坐标
080356FA 8950     ldrh    r0,[r2,0Ah]      ;读取精灵上部分界
080356FC 1808     add     r0,r1,r0         ;加上Y坐标
080356FE 0400     lsl     r0,r0,10h
08035700 0C00     lsr     r0,r0,10h
08035702 9004     str     r0,[sp,10h]      ;写入sp 10
08035704 8990     ldrh    r0,[r2,0Ch]      ;读取下部分界
08035706 1809     add     r1,r1,r0         ;加上Y坐标
08035708 0409     lsl     r1,r1,10h
0803570A 0C09     lsr     r1,r1,10h
0803570C 468A     mov     r10,r1           ;给R10
0803570E 89D0     ldrh    r0,[r2,0Eh]      ;读取左部分界
08035710 1818     add     r0,r3,r0         ;加上X坐标
08035712 0400     lsl     r0,r0,10h
08035714 0C00     lsr     r0,r0,10h
08035716 4681     mov     r9,r0            ;给r9
08035718 8A10     ldrh    r0,[r2,10h]      ;读取右部分界
0803571A 181B     add     r3,r3,r0
0803571C 041B     lsl     r3,r3,10h
0803571E 0C1B     lsr     r3,r3,10h        ;加上X坐标
08035720 4698     mov     r8,r3            ;给r8
08035722 2711     mov     r7,11h           
08035724 2600     mov     r6,0h

@@Loop:
08035726 00F0     lsl     r0,r6,3h
08035728 1B80     sub     r0,r0,r6
0803572A 0080     lsl     r0,r0,2h         ;28倍 1C偏移下一个slot
0803572C 4915     ldr     r1,=3000A2Ch     ;弹丸数据
0803572E 1845     add     r5,r0,r1         ;弹丸数据加slot
08035730 7BE8     ldrb    r0,[r5,0Fh]      ;读取弹丸类型
08035732 280E     cmp     r0,0Eh
08035734 D128     bne     @@CheckNext         ;非炸弹
08035736 7828     ldrb    r0,[r5]
08035738 4038     and     r0,r7
0803573A 42B8     cmp     r0,r7               ;检查炸弹是否存在以及爆炸
0803573C D124     bne     @@CheckNext
0803573E 892B     ldrh    r3,[r5,8h]          ;炸弹Y坐标
08035740 896C     ldrh    r4,[r5,0Ah]         ;炸弹X坐标
08035742 8AAA     ldrh    r2,[r5,14h]         ;炸弹上部分界
08035744 189A     add     r2,r3,r2
08035746 0412     lsl     r2,r2,10h
08035748 0C12     lsr     r2,r2,10h
0803574A 8AE8     ldrh    r0,[r5,16h]
0803574C 181B     add     r3,r3,r0
0803574E 041B     lsl     r3,r3,10h
08035750 0C1B     lsr     r3,r3,10h
08035752 8B29     ldrh    r1,[r5,18h]
08035754 1861     add     r1,r4,r1
08035756 0409     lsl     r1,r1,10h
08035758 0C09     lsr     r1,r1,10h
0803575A 8B68     ldrh    r0,[r5,1Ah]
0803575C 1824     add     r4,r4,r0
0803575E 0424     lsl     r4,r4,10h
08035760 0C24     lsr     r4,r4,10h
08035762 9200     str     r2,[sp]
08035764 9301     str     r3,[sp,4h]
08035766 9102     str     r1,[sp,8h]
08035768 9403     str     r4,[sp,0Ch]
0803576A 9804     ldr     r0,[sp,10h]
0803576C 4651     mov     r1,r10
0803576E 464A     mov     r2,r9
08035770 4643     mov     r3,r8
08035772 F7D8FFC1 bl      800E6F8h        ;检查炸弹是否炸到敌人
08035776 2800     cmp     r0,0h
08035778 D006     beq     @@CheckNext
0803577A 2001     mov     r0,1h
0803577C E00A     b       8035794h
.pool

@@CheckNext:
08035788 1C70     add     r0,r6,1
0803578A 0600     lsl     r0,r0,18h
0803578C 0E06     lsr     r6,r0,18h
0803578E 2E0F     cmp     r6,0Fh
08035790 D9C9     bls     @@Loop
08035792 2000     mov     r0,0h
08035794 B005     add     sp,14h
08035796 BC38     pop     r3-r5
08035798 4698     mov     r8,r3
0803579A 46A1     mov     r9,r4
0803579C 46AA     mov     r10,r5
0803579E BCF0     pop     r4-r7
080357A0 BC02     pop     r1
080357A2 4708     bx      r1

MetroidPush:
080357A4 B5F0     push    r4-r7,lr
080357A6 4657     mov     r7,r10
080357A8 464E     mov     r6,r9
080357AA 4645     mov     r5,r8
080357AC B4E0     push    r5-r7
080357AE B081     add     sp,-4h
080357B0 0400     lsl     r0,r0,10h
080357B2 0C00     lsr     r0,r0,10h
080357B4 4680     mov     r8,r0
080357B6 490D     ldr     r1,=3000738h
080357B8 8848     ldrh    r0,[r1,2h]      ;读取Y坐标
080357BA 3810     sub     r0,10h          ;向上10h
080357BC 0400     lsl     r0,r0,10h
080357BE 0C03     lsr     r3,r0,10h       ;给R3
080357C0 8888     ldrh    r0,[r1,4h]      ;读取X坐标
080357C2 9000     str     r0,[sp]         ;给SP
080357C4 2720     mov     r7,20h
080357C6 2209     mov     r2,9h
080357C8 4694     mov     r12,r2
080357CA 1C08     mov     r0,r1
080357CC 3024     add     r0,24h
080357CE 7800     ldrb    r0,[r0]         ;读取pose
080357D0 2809     cmp     r0,9h
080357D2 D10D     bne     @@PoseNoNineOrFrozen
080357D4 1C08     mov     r0,r1
080357D6 3030     add     r0,30h
080357D8 7800     ldrb    r0,[r0]         ;读取冰冻时间
080357DA 2800     cmp     r0,0h
080357DC D108     bne     @@PoseNoNineOrFrozen
080357DE 1C08     mov     r0,r1
080357E0 3023     add     r0,23h
080357E2 7800     ldrb    r0,[r0]         ;读取主精灵序号
080357E4 3001     add     r0,1h
080357E6 0600     lsl     r0,r0,18h       ;加1给r5  之后检查该精灵之后的所有精灵?
080357E8 0E05     lsr     r5,r0,18h
080357EA E002     b       @@Goto
.pool

@@PoseNoNineOrFrozen:
080357F0 2500     mov     r5,0h

@@Goto:
080357F2 2D17     cmp     r5,17h
080357F4 D900     bls     @@Pass
080357F6 E0A9     b       @@end
.pool

@@Pass:
080357F8 4640     mov     r0,r8           ;设定值 1
080357FA 0100     lsl     r0,r0,4h        ;十六倍
080357FC 4681     mov     r9,r0           ;给r9

@@Loop:
080357FE 00E8     lsl     r0,r5,3h        ;主精灵序号序号加1的值的8倍
08035800 1B41     sub     r1,r0,r5        
08035802 00C9     lsl     r1,r1,3h        ;56倍
08035804 4A22     ldr     r2,=30001ACh
08035806 188C     add     r4,r1,r2        ;下一个精灵的内存地址
08035808 8821     ldrh    r1,[r4]         ;读取后续精灵的取向
0803580A 2201     mov     r2,1h
0803580C 4011     and     r1,r2
0803580E 4682     mov     r10,r0          ;检查是否是活的
08035810 2900     cmp     r1,0h
08035812 D100     bne     @@Alive
08035814 E094     b       @@CheckNext
.pool

@@Alive:
08035816 1C20     mov     r0,r4
08035818 3025     add     r0,25h
0803581A 7800     ldrb    r0,[r0]         ;读取属性
0803581C 2818     cmp     r0,18h          ;吸血伤害类型
0803581E D000     beq     @@ItIsMetroid
08035820 E08E     b       @@CheckNext
.pool

@@ItIsMetroid:
08035822 1C20     mov     r0,r4
08035824 3030     add     r0,30h
08035826 7800     ldrb    r0,[r0]         ;读取冰冻时间
08035828 2800     cmp     r0,0h
0803582A D000     beq     @@NoFrozenMetroid ;冰冻的M不会相撞...
0803582C E088     b       @@CheckNext
.pool

@@NoFrozenMetroid:
0803582E 1C20     mov     r0,r4
08035830 3024     add     r0,24h
08035832 7800     ldrb    r0,[r0]        ;读取后续M的Pose
08035834 4560     cmp     r0,r12         ;是否是9  大概是移动的pose
08035836 D000     beq     @@NoFrozenMetroidPoseNine
08035838 E082     b       @@CheckNext
.pool

@@NoFrozenMetroidPoseNine:
0803583A 8860     ldrh    r0,[r4,2h]     ;读取Y坐标
0803583C 2110     mov     r1,10h         ;向上10h
0803583E 1A40     sub     r0,r0,r1
08035840 0400     lsl     r0,r0,10h
08035842 0C02     lsr     r2,r0,10h
08035844 88A6     ldrh    r6,[r4,4h]     ;读取后续M X坐标
08035846 19D9     add     r1,r3,r7       ;当前M的Y坐标向下20
08035848 1BD0     sub     r0,r2,r7       ;后续M的Y坐标向上20
0803584A 4281     cmp     r1,r0          ;比较两者
0803584C DD78     ble     @@CheckNext    ;小于或等
0803584E 1BD9     sub     r1,r3,r7       ;当前M的Y坐标向上20
08035850 19D0     add     r0,r2,r7       ;后续M的Y坐标向下20
08035852 4281     cmp     r1,r0          
08035854 DA74     bge     @@CheckNext    ;大于或等
08035856 9800     ldr     r0,[sp]
08035858 19C1     add     r1,r0,r7       ;当前M的X坐标
0803585A 1BF0     sub     r0,r6,r7
0803585C 4281     cmp     r1,r0
0803585E DD6F     ble     @@CheckNext
08035860 9800     ldr     r0,[sp]
08035862 1BC1     sub     r1,r0,r7
08035864 19F0     add     r0,r6,r7
08035866 4281     cmp     r1,r0
08035868 DA6A     bge     @@CheckNext
;-----------------------------------------重合?
0803586A 4293     cmp     r3,r2
0803586C D914     bls     @@AtUp         ;当前M和后续M的Y坐标比较
;----------------------------------------当前M在后续M的下面
0803586E 8860     ldrh    r0,[r4,2h]     ;读取后续M Y坐标
08035870 1BC0     sub     r0,r0,r7       ;向上20h
08035872 1C31     mov     r1,r6          ;后续M的X坐标
08035874 F7D9FF54 bl      800F720h       ;检查砖块
08035878 2800     cmp     r0,0h          ;无砖
0803587A D124     bne     @@CheckTheHorizontal
0803587C 8860     ldrh    r0,[r4,2h]
0803587E 4641     mov     r1,r8          ;设定值的10h倍 也就是反弹值
08035880 1A40     sub     r0,r0,r1       ;向上反弹10h再写入
08035882 8060     strh    r0,[r4,2h]
08035884 8820     ldrh    r0,[r4]        ;读取后续M的取向
08035886 4A03     ldr     r2,=0FBFFh
08035888 1C11     mov     r1,r2
0803588A 4008     and     r0,r1          ;由向下变成向上>>?
0803588C E013     b       @@WriteFlipVerticalDirection
.pool

@@AtUp:
08035898 8860     ldrh    r0,[r4,2h]
0803589A 19C0     add     r0,r0,r7
0803589C 1C31     mov     r1,r6          ;检查后续碰撞M的向下是否有砖块
0803589E F7D9FF3F bl      800F720h
080358A2 2800     cmp     r0,0h
080358A4 D10F     bne     @@CheckTheHorizontal
080358A6 8860     ldrh    r0,[r4,2h]
080358A8 4440     add     r0,r8
080358AA 8060     strh    r0,[r4,2h]
080358AC 8820     ldrh    r0,[r4]
080358AE 2280     mov     r2,80h
080358B0 00D2     lsl     r2,r2,3h      ;orr 400
080358B2 1C11     mov     r1,r2
080358B4 4308     orr     r0,r1         ;向上变为向下

@@WriteFlipVerticalDirection:
080358B6 8020     strh    r0,[r4]
080358B8 1C20     mov     r0,r4
080358BA 302C     add     r0,2Ch
080358BC 2100     mov     r1,0h
080358BE 7001     strb    r1,[r0]       ;偏移2c写入0
080358C0 3003     add     r0,3h
080358C2 464A     mov     r2,r9          
080358C4 7002     strb    r2,[r0]       ;反弹速度写入偏移2Fh

@@CheckTheHorizontal:
080358C6 9800     ldr     r0,[sp]
080358C8 42B0     cmp     r0,r6         ;当前M和后续M的X坐标比较
080358CA D919     bls     @@AtLeft      ;当前M在后续M的左边则跳转
080358CC 4651     mov     r1,r10        ;后续主精灵序号的八倍
080358CE 1B48     sub     r0,r1,r5      
080358D0 00C0     lsl     r0,r0,3h      ;56倍
080358D2 4A09     ldr     r2,=30001ACh
080358D4 1884     add     r4,r0,r2
080358D6 8860     ldrh    r0,[r4,2h]    ;后续精灵坐标
080358D8 88A1     ldrh    r1,[r4,4h]
080358DA 1BC9     sub     r1,r1,r7
080358DC F7D9FF20 bl      800F720h      ;检查左边是否有砖
080358E0 2800     cmp     r0,0h
080358E2 D133     bne     @@end
080358E4 88A0     ldrh    r0,[r4,4h]
080358E6 4641     mov     r1,r8
080358E8 1A40     sub     r0,r0,r1
080358EA 80A0     strh    r0,[r4,4h]
080358EC 8820     ldrh    r0,[r4]
080358EE 4A03     ldr     r2,=0FDFFh
080358F0 1C11     mov     r1,r2
080358F2 4008     and     r0,r1         ;取向去掉200 也就是开始向左移动
080358F4 E018     b       @@WriteFlipHorizontalDirection
.pool

@@AtLeft:
08035900 4651     mov     r1,r10
08035902 1B48     sub     r0,r1,r5
08035904 00C0     lsl     r0,r0,3h
08035906 4A0D     ldr     r2,=30001ACh
08035908 1884     add     r4,r0,r2
0803590A 8860     ldrh    r0,[r4,2h]
0803590C 88A1     ldrh    r1,[r4,4h]
0803590E 19C9     add     r1,r1,r7
08035910 F7D9FF06 bl      800F720h
08035914 2800     cmp     r0,0h
08035916 D119     bne     @@end
08035918 88A0     ldrh    r0,[r4,4h]
0803591A 4440     add     r0,r8
0803591C 80A0     strh    r0,[r4,4h]
0803591E 8820     ldrh    r0,[r4]
08035920 2280     mov     r2,80h
08035922 0092     lsl     r2,r2,2h      ;后续M取向orr 200
08035924 1C11     mov     r1,r2
08035926 4308     orr     r0,r1

@@WriteFlipHorizontalDirection:
08035928 8020     strh    r0,[r4]
0803592A 1C20     mov     r0,r4
0803592C 302D     add     r0,2Dh
0803592E 2100     mov     r1,0h
08035930 7001     strb    r1,[r0]       ;偏移2D写入0
08035932 3001     add     r0,1h
08035934 464A     mov     r2,r9
08035936 7002     strb    r2,[r0]       ;偏移2E写入反弹的速度?
08035938 E008     b       @@end
.pool

@@CheckNext:
08035940 1C68     add     r0,r5,1       ;主精灵序号再加1检查下一个
08035942 0600     lsl     r0,r0,18h
08035944 0E05     lsr     r5,r0,18h
08035946 2D17     cmp     r5,17h
08035948 D800     bhi     @@end
0803594A E758     b       @@Loop
.pool

@@end:
0803594C B001     add     sp,4h
0803594E BC38     pop     r3-r5
08035950 4698     mov     r8,r3
08035952 46A1     mov     r9,r4
08035954 46AA     mov     r10,r5
08035956 BCF0     pop     r4-r7
08035958 BC01     pop     r0
0803595A 4700     bx      r0
.pool

;MetroidPoseNineCall

0803595C B510     push    r4,lr
0803595E 2300     mov     r3,0h
08035960 4C0A     ldr     r4,=30001ACh

@@Loop:
08035962 00D8     lsl     r0,r3,3h
08035964 1AC0     sub     r0,r0,r3
08035966 00C0     lsl     r0,r0,3h
08035968 1902     add     r2,r0,r4
0803596A 8811     ldrh    r1,[r2]
0803596C 2001     mov     r0,1h
0803596E 4008     and     r0,r1
08035970 2800     cmp     r0,0h     ;检查是否是活物
08035972 D00D     beq     @@ContinueCheck
08035974 1C10     mov     r0,r2
08035976 3025     add     r0,25h
08035978 7800     ldrb    r0,[r0]
0803597A 2818     cmp     r0,18h    ;检查是否是M
0803597C D108     bne     @@ContinueCheck
0803597E 1C10     mov     r0,r2
08035980 3024     add     r0,24h
08035982 7800     ldrb    r0,[r0]
08035984 2809     cmp     r0,9h     ;检查Pose不是9
08035986 D003     beq     @@ContinueCheck
08035988 2001     mov     r0,1h
0803598A E007     b       @@end
.pool

@@ContinueCheck:
08035990 1C58     add     r0,r3,1
08035992 0600     lsl     r0,r0,18h
08035994 0E03     lsr     r3,r0,18h
08035996 2B17     cmp     r3,17h
08035998 D9E3     bls     @@Loop
0803599A 2000     mov     r0,0h

@@end:
0803599C BC10     pop     r4
0803599E BC02     pop     r1
080359A0 4708     bx      r1

;PoseNineCall
MetroidNormalVoice:
080359A4 B500     push    lr
080359A6 4909     ldr     r1,=3000738h
080359A8 8AC8     ldrh    r0,[r1,16h]
080359AA 2800     cmp     r0,0h        ;精灵动画
080359AC D10B     bne     @@end
080359AE 7F08     ldrb    r0,[r1,1Ch]
080359B0 2801     cmp     r0,1h        ;精灵动画帧
080359B2 D108     bne     @@end
080359B4 8809     ldrh    r1,[r1]
080359B6 2002     mov     r0,2h
080359B8 4008     and     r0,r1
080359BA 2800     cmp     r0,0h        ;检查在屏幕内
080359BC D003     beq     @@end
080359BE 20B8     mov     r0,0B8h
080359C0 0040     lsl     r0,r0,1h     ;播放水母声 368
080359C2 F7CDF8AD bl      8002B20h

@@end:
080359C6 BC01     pop     r0
080359C8 4700     bx      r0
.pool

;Pose0
MetroidInitialize:
080359D0 B570     push    r4-r6,lr
080359D2 B083     add     sp,-0Ch
080359D4 2400     mov     r4,0h
080359D6 4805     ldr     r0,=3000055h
080359D8 7800     ldrb    r0,[r0]           ;读取当前房间序号
080359DA 3801     sub     r0,1h             ;减1
080359DC 2812     cmp     r0,12h            ;房间号大于13则结束
080359DE D848     bhi     @@Pass
080359E0 0080     lsl     r0,r0,2h          ;房间号减1再乘以4
080359E2 4903     ldr     r1,=RoomTable
080359E4 1840     add     r0,r0,r1
080359E6 6800     ldr     r0,[r0]
080359E8 4687     mov     r15,r0
.pool

RoomTable:
    .word MetroidRoom1CheckEvent    ;0x8035A46   ;房1
    .word MetroidRoom2CheckEvent    ;0x8035A4C   ;房2
    .word @@PassRoomCheck
    .word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
	.word @@PassRoomCheck
    .word MetroidRoomECheckEvent    ;0x8035A40   ;房E
	.word MetroidRoomFCheckEvent    ;0x8035A52   ;房F
	.word MetroidRoom10CheckEvent   ;0x8035A58   ;房10
    .word @@PassRoomCheck
	.word @@PassRoomCheck
    .word MetroidRoom13CheckEvent   ;0x8035A5E   ;房13
MetroidRoomECheckEvent:	
08035A40 2003     mov     r0,3h
08035A42 2137     mov     r1,37h
08035A44 E00D     b       @@CheckEvent
MetroidRoom1CheckEvent:
08035A46 2003     mov     r0,3h
08035A48 2138     mov     r1,38h
08035A4A E00A     b       @@CheckEvent
MetroidRoom2CheckEvent:
08035A4C 2003     mov     r0,3h
08035A4E 2139     mov     r1,39h
08035A50 E007     b       @@CheckEvent
MetroidRoomFCheckEvent:
08035A52 2003     mov     r0,3h
08035A54 213A     mov     r1,3Ah
08035A56 E004     b       @@CheckEvent
MetroidRoom10CheckEvent:
08035A58 2003     mov     r0,3h
08035A5A 213B     mov     r1,3Bh
08035A5C E001     b       @@CheckEvent
MetroidRoom13CheckEvent:
08035A5E 2003     mov     r0,3h
08035A60 213C     mov     r1,3Ch

@@CheckEvent:
08035A62 F02AFF2B bl      80608BCh
08035A66 2800     cmp     r0,0h
08035A68 D104     bne     @@Peer
08035A6A 1C60     add     r0,r4,1
08035A6C 0600     lsl     r0,r0,18h
08035A6E 0E04     lsr     r4,r0,18h ;没有激活则为1
08035A70 E000     b       @@Peer

@@PassRoomCheck:
08035A72 2402     mov     r4,2h     ;不是该房间则为2

@@Peer:
08035A74 2C00     cmp     r4,0h     ;激活了则为0
08035A76 D105     bne     @@ContinueCheck
08035A78 4801     ldr     r0,=3000738h  ;激活的话精灵直接消除
08035A7A 8004     strh    r4,[r0]
08035A7C E05C     b       @@end
.pool

@@ContinueCheck:
08035A84 2C01     cmp     r4,1h
08035A86 D101     bne     @@PassDoorLock
08035A88 482D     ldr     r0,=300007Bh  ;是1的话门锁flag写入1
08035A8A 7004     strb    r4,[r0]

@@PassDoorLock:
08035A8C 4D2D     ldr     r5,=3000738h
08035A8E 8829     ldrh    r1,[r5]
08035A90 2020     mov     r0,20h
08035A92 2600     mov     r6,0h
08035A94 4308     orr     r0,r1         ;取向orr20
08035A96 2280     mov     r2,80h
08035A98 0212     lsl     r2,r2,8h      
08035A9A 1C11     mov     r1,r2
08035A9C 4308     orr     r0,r1         ;再orr8000再写入
08035A9E 2400     mov     r4,0h
08035AA0 2180     mov     r1,80h
08035AA2 4308     orr     r0,r1
08035AA4 8028     strh    r0,[r5]
08035AA6 2040     mov     r0,40h
08035AA8 8268     strh    r0,[r5,12h]   ;偏移12写入40
08035AAA 1C28     mov     r0,r5
08035AAC 302A     add     r0,2Ah
08035AAE 7004     strb    r4,[r0]       ;偏移2A归零
08035AB0 3803     sub     r0,3h
08035AB2 2106     mov     r1,6h
08035AB4 7001     strb    r1,[r0]       ;偏移27写入6 视野判定上
08035AB6 3001     add     r0,1h
08035AB8 7001     strb    r1,[r0]       ;偏移28写入6 视野判定左右
08035ABA 1C29     mov     r1,r5
08035ABC 3129     add     r1,29h
08035ABE 2005     mov     r0,5h 
08035AC0 7008     strb    r0,[r1]       ;偏移29写入5 视野判定下
08035AC2 4921     ldr     r1,=0FFD8h
08035AC4 8169     strh    r1,[r5,0Ah]
08035AC6 2020     mov     r0,20h
08035AC8 81A8     strh    r0,[r5,0Ch]
08035ACA 81E9     strh    r1,[r5,0Eh]
08035ACC 2028     mov     r0,28h
08035ACE 8228     strh    r0,[r5,10h]   ;正常M的上下左右分界
08035AD0 481E     ldr     r0,=82EDD20h
08035AD2 61A8     str     r0,[r5,18h]   ;写入oam
08035AD4 772C     strb    r4,[r5,1Ch]
08035AD6 82EE     strh    r6,[r5,16h]
08035AD8 4A1D     ldr     r2,=82B0D68h
08035ADA 7F69     ldrb    r1,[r5,1Dh]
08035ADC 00C8     lsl     r0,r1,3h
08035ADE 1840     add     r0,r0,r1
08035AE0 0040     lsl     r0,r0,1h
08035AE2 1880     add     r0,r0,r2
08035AE4 8800     ldrh    r0,[r0]
08035AE6 82A8     strh    r0,[r5,14h]   ;写入血量
08035AE8 80E8     strh    r0,[r5,6h]    ;同时在偏移6写入备份
08035AEA 1C28     mov     r0,r5
08035AEC 3025     add     r0,25h
08035AEE 7004     strb    r4,[r0]       ;属性写入0
08035AF0 F7D9FEF6 bl      800F8E0h      ;判断人物和精灵的左右位置,取向是否有200h
08035AF4 1C29     mov     r1,r5
08035AF6 3124     add     r1,24h
08035AF8 2001     mov     r0,1h
08035AFA 7008     strb    r0,[r1]       ;pose写入1
08035AFC 1C28     mov     r0,r5
08035AFE 302E     add     r0,2Eh
08035B00 7004     strb    r4,[r0]       ;偏移2E归零
08035B02 3001     add     r0,1h
08035B04 7004     strb    r4,[r0]       ;偏移2F归零
08035B06 3902     sub     r1,2h
08035B08 200C     mov     r0,0Ch
08035B0A 7008     strb    r0,[r1]       ;偏移22写入C
08035B0C 7FA9     ldrb    r1,[r5,1Eh]   ;精灵序号
08035B0E 7FEA     ldrb    r2,[r5,1Fh]   ;gfxrow
08035B10 1C28     mov     r0,r5
08035B12 3023     add     r0,23h        ;主精灵序号
08035B14 7803     ldrb    r3,[r0]
08035B16 8868     ldrh    r0,[r5,2h]    ;X坐标写入sp
08035B18 9000     str     r0,[sp]
08035B1A 88A8     ldrh    r0,[r5,4h]
08035B1C 9001     str     r0,[sp,4h]
08035B1E 9602     str     r6,[sp,8h]    ;状态写入0
08035B20 201A     mov     r0,1Ah        ;副精灵水母壳
08035B22 F7D8FB99 bl      800E258h      ;生产副精灵
08035B26 0600     lsl     r0,r0,18h
08035B28 0E00     lsr     r0,r0,18h
08035B2A 28FF     cmp     r0,0FFh
08035B2C D100     bne     @@NormalProduction
08035B2E 802E     strh    r6,[r5]       ;若没有空余槽,则消除主精灵

@@NormalProduction:
08035B30 1C29     mov     r1,r5
08035B32 3120     add     r1,20h
08035B34 2003     mov     r0,3h
08035B36 7008     strb    r0,[r1]       ;偏移20写入3 调色板号3

@@end:
08035B38 B003     add     sp,0Ch
08035B3A BC70     pop     r4-r6
08035B3C BC01     pop     r0
08035B3E 4700     bx      r0
.pool

;Pose1
MetroidInTheScreenCheck:
08035B54 B500     push    lr
08035B56 4A0E     ldr     r2,=3000738h
08035B58 8811     ldrh    r1,[r2]
08035B5A 2002     mov     r0,2h
08035B5C 4008     and     r0,r1
08035B5E 2800     cmp     r0,0h         ;检查是否在屏内
08035B60 D013     beq     @@end
08035B62 1C11     mov     r1,r2
08035B64 3124     add     r1,24h
08035B66 2002     mov     r0,2h
08035B68 7008     strb    r0,[r1]       ;在屏幕内则pose写入2
08035B6A 1C10     mov     r0,r2
08035B6C 3027     add     r0,27h
08035B6E 2118     mov     r1,18h
08035B70 7001     strb    r1,[r0]       ;偏移27写入18h 上视界
08035B72 3001     add     r0,1h
08035B74 7001     strb    r1,[r0]       ;偏移28写入18h 左右视界
08035B76 1C11     mov     r1,r2
08035B78 3129     add     r1,29h
08035B7A 2014     mov     r0,14h        ;偏移29写入14h 下视界
08035B7C 7008     strb    r0,[r1]
08035B7E 4805     ldr     r0,=300083Ch  ;读取随机值
08035B80 7800     ldrb    r0,[r0]
08035B82 0080     lsl     r0,r0,2h      ;乘以4
08035B84 3001     add     r0,1h         ;加1
08035B86 3103     add     r1,3h
08035B88 7008     strb    r0,[r1]       ;写入偏移2C

@@end:
08035B8A BC01     pop     r0
08035B8C 4700     bx      r0
.pool

;Pose2
MetroidShow:
08035B98 B5F0     push    r4-r7,lr
08035B9A 4B19     ldr     r3,=3000738h
08035B9C 202F     mov     r0,2Fh
08035B9E 18C0     add     r0,r0,r3     ;偏移2F给r12
08035BA0 4684     mov     r12,r0
08035BA2 7802     ldrb    r2,[r0]      ;偏移2F的值
08035BA4 4C17     ldr     r4,=82ECB60h ;垂直速度偏移地址
08035BA6 0050     lsl     r0,r2,1h     ;2F加1
08035BA8 1900     add     r0,r0,r4     ;加上速度偏移地址
08035BAA 2500     mov     r5,0h
08035BAC 5F41     ldsh    r1,[r0,r5]   ;读取数值
08035BAE 4D16     ldr     r5,=7FFFh
08035BB0 42A9     cmp     r1,r5        ;比较是否是7FFFh
08035BB2 D102     bne     @@PassReturnY
08035BB4 2700     mov     r7,0h
08035BB6 5FE1     ldsh    r1,[r4,r7]   ;速度到顶了则重新开始
08035BB8 2200     mov     r2,0h

@@PassReturnY:
08035BBA 1C50     add     r0,r2,1      
08035BBC 4662     mov     r2,r12
08035BBE 7010     strb    r0,[r2]      ;1写入偏移2F
08035BC0 8858     ldrh    r0,[r3,2h]   ;读取Y坐标
08035BC2 1840     add     r0,r0,r1     ;加上速度
08035BC4 2600     mov     r6,0h
08035BC6 8058     strh    r0,[r3,2h]   ;写入Y坐标
08035BC8 272E     mov     r7,2Eh
08035BCA 18FF     add     r7,r7,r3
08035BCC 46BC     mov     r12,r7       ;偏移2E给r12
08035BCE 783A     ldrb    r2,[r7]
08035BD0 4C0E     ldr     r4,=82ECBE2h ;水平速度偏移地址
08035BD2 0050     lsl     r0,r2,1h
08035BD4 1900     add     r0,r0,r4 
08035BD6 2700     mov     r7,0h  
08035BD8 5FC1     ldsh    r1,[r0,r7]   ;水平速度
08035BDA 42A9     cmp     r1,r5        ;比较是否是7FFFh
08035BDC D102     bne     @@PassReturnX
08035BDE 2000     mov     r0,0h
08035BE0 5E21     ldsh    r1,[r4,r0]   ;读取初始速度
08035BE2 2200     mov     r2,0h        ;2E也归零

@@PassReturnX:
08035BE4 1C50     add     r0,r2,1
08035BE6 4662     mov     r2,r12
08035BE8 7010     strb    r0,[r2]      ;2E写入1
08035BEA 8898     ldrh    r0,[r3,4h]   ;读取X坐标加上速度再写入
08035BEC 1840     add     r0,r0,r1
08035BEE 8098     strh    r0,[r3,4h]
08035BF0 1C19     mov     r1,r3
08035BF2 312C     add     r1,2Ch
08035BF4 7808     ldrb    r0,[r1]      ;读取偏移2C的值
08035BF6 1C04     mov     r4,r0
08035BF8 2C00     cmp     r4,0h
08035BFA D009     beq     @@NumReducedToZero
08035BFC 3801     sub     r0,1h
08035BFE E030     b       @@Writend
.pool

@@NumReducedToZero:
08035C10 8A58     ldrh    r0,[r3,12h]
08035C12 28FF     cmp     r0,0FFh      ;比较偏移12的值是否大于FF  
08035C14 D80F     bhi     @@NumMoreThanFF
08035C16 3004     add     r0,4h        ;加4再写入
08035C18 8258     strh    r0,[r3,12h]
08035C1A 0400     lsl     r0,r0,10h
08035C1C 0C00     lsr     r0,r0,10h
08035C1E 28D0     cmp     r0,0D0h
08035C20 D903     bls     @@NumBlsD0
08035C22 1C19     mov     r1,r3
08035C24 3120     add     r1,20h
08035C26 2001     mov     r0,1h        ;调色板写入1
08035C28 E01B     b       @@Writend

@@NumBlsD0:
08035C2A 28A0     cmp     r0,0A0h
08035C2C D91A     bls     @@end
08035C2E 1C19     mov     r1,r3
08035C30 3120     add     r1,20h
08035C32 2002     mov     r0,2h        ;调色板写入2
08035C34 E015     b       @@Writend

@@NumMoreThanFF:
08035C36 1C18     mov     r0,r3
08035C38 3020     add     r0,20h
08035C3A 7006     strb    r6,[r0]      ;调色板写入0
08035C3C 8818     ldrh    r0,[r3]      ;取向and
08035C3E 490B     ldr     r1,=0FF7Fh   ;去掉80
08035C40 4001     and     r1,r0
08035C42 1C1A     mov     r2,r3
08035C44 3224     add     r2,24h
08035C46 2008     mov     r0,8h        ;pose写入8
08035C48 7010     strb    r0,[r2]
08035C4A 4809     ldr     r0,=82EDC20h ;正常情况下的OAM
08035C4C 6198     str     r0,[r3,18h]
08035C4E 771E     strb    r6,[r3,1Ch]
08035C50 82DC     strh    r4,[r3,16h]
08035C52 4029     and     r1,r5        ;and 7fff
08035C54 8019     strh    r1,[r3]      ;去掉8000再写入
08035C56 1C19     mov     r1,r3
08035C58 3125     add     r1,25h
08035C5A 2018     mov     r0,18h
08035C5C 7008     strb    r0,[r1]      ;属性写入可以吸血
08035C5E 3903     sub     r1,3h
08035C60 2004     mov     r0,4h        ;偏移22写入4 与图像相关内胆在后层

@@Writend:
08035C62 7008     strb    r0,[r1]      

@@end:
08035C64 BCF0     pop     r4-r7
08035C66 BC01     pop     r0
08035C68 4700     bx      r0
.pool

;Pose 8
MetroidTheTransition:
08035C74 4B0A     ldr     r3,=3000738h
08035C76 1C19     mov     r1,r3
08035C78 3124     add     r1,24h
08035C7A 2200     mov     r2,0h
08035C7C 2009     mov     r0,9h
08035C7E 7008     strb    r0,[r1]   ;pose写入9
08035C80 1C18     mov     r0,r3
08035C82 302D     add     r0,2Dh
08035C84 7002     strb    r2,[r0]   ;偏移2D写入0
08035C86 3001     add     r0,1h
08035C88 2101     mov     r1,1h
08035C8A 7001     strb    r1,[r0]   ;偏移2E写入1
08035C8C 3802     sub     r0,2h
08035C8E 7002     strb    r2,[r0]   ;偏移2C写入0
08035C90 3003     add     r0,3h
08035C92 7001     strb    r1,[r0]   ;偏移2F写入1
08035C94 4803     ldr     r0,=82EDC20h ;正常情况下的OAM
08035C96 6198     str     r0,[r3,18h]
08035C98 771A     strb    r2,[r3,1Ch]
08035C9A 82DA     strh    r2,[r3,16h]
08035C9C 4770     bx      r14
.pool

;Pose 9
MetroidNormal:                       ;主要智能,追samus跑
08035CA8 B510     push    r4,lr
08035CAA B081     add     sp,-4h
08035CAC F7FFFE7A bl      80359A4h   ;MetroidNormalVoice
08035CB0 4C08     ldr     r4,=3000738h
08035CB2 8821     ldrh    r1,[r4]    ;读取取向
08035CB4 2080     mov     r0,80h
08035CB6 0100     lsl     r0,r0,4h
08035CB8 4008     and     r0,r1      ;and 800
08035CBA 2800     cmp     r0,0h      ;取向无800则跳转
08035CBC D019     beq     @@NoLatchAndMove
08035CBE F7FFFE4D bl      803595Ch   ;检查是否有活着的pose非9的M 锁定的AI?
08035CC2 0600     lsl     r0,r0,18h
08035CC4 2800     cmp     r0,0h      ;没有的话
08035CC6 D009     beq     @@NoMetroidNoPoseNine
08035CC8 8821     ldrh    r1,[r4]    ;有咬住Samus的M
08035CCA 4803     ldr     r0,=0F7FFh
08035CCC 4008     and     r0,r1      ;取向去掉800
08035CCE 8020     strh    r0,[r4]    ;再写入
08035CD0 E00F     b       @@NoLatchAndMove
.pool

@@NoMetroidNoPoseNine:
08035CDC 1C21     mov     r1,r4
08035CDE 3124     add     r1,24h
08035CE0 2042     mov     r0,42h
08035CE2 7008     strb    r0,[r1]    ;pose写入42  咬住的pose>?
08035CE4 8821     ldrh    r1,[r4]
08035CE6 2280     mov     r2,80h
08035CE8 0212     lsl     r2,r2,8h
08035CEA 1C10     mov     r0,r2
08035CEC 4308     orr     r0,r1      ;取向orr8000再写入
08035CEE 8020     strh    r0,[r4]
08035CF0 E011     b       @@end

@@NoLatchAndMove:
08035CF2 2001     mov     r0,1h
08035CF4 F7FFFD56 bl      80357A4h   ;MetroidPush 被推掉
08035CF8 4909     ldr     r1,=30013D4h
08035CFA 480A     ldr     r0,=3001588h
08035CFC 3070     add     r0,70h
08035CFE 8800     ldrh    r0,[r0]    ;读取15f8   samus 上部分界
08035D00 8A8A     ldrh    r2,[r1,14h];读取Samus y坐标
08035D02 1880     add     r0,r0,r2   ;加上坐标
08035D04 0400     lsl     r0,r0,10h
08035D06 0C00     lsr     r0,r0,10h
08035D08 8A49     ldrh    r1,[r1,12h];读取samus X坐标
08035D0A 2202     mov     r2,2h
08035D0C 9200     str     r2,[sp]    ;sp写入2
08035D0E 221E     mov     r2,1Eh
08035D10 2328     mov     r3,28h
08035D12 F7FFFB63 bl      80353DCh   ;MetroidMoveAI

@@end:
08035D16 B001     add     sp,4h
08035D18 BC10     pop     r4
08035D1A BC01     pop     r0
08035D1C 4700     bx      r0
.pool

;Pose42

08035D28 480D     ldr     r0,=3000738h
08035D2A 4684     mov     r12,r0
08035D2C 4661     mov     r1,r12
08035D2E 3124     add     r1,24h
08035D30 2200     mov     r2,0h
08035D32 2043     mov     r0,43h
08035D34 7008     strb    r0,[r1]       ;pose写入43
08035D36 480B     ldr     r0,=82EDCA8h
08035D38 4661     mov     r1,r12
08035D3A 6188     str     r0,[r1,18h]
08035D3C 770A     strb    r2,[r1,1Ch]
08035D3E 2300     mov     r3,0h
08035D40 82CA     strh    r2,[r1,16h]
08035D42 312C     add     r1,2Ch
08035D44 2004     mov     r0,4h         ;偏移2C写入4h
08035D46 7008     strb    r0,[r1]
08035D48 3101     add     r1,1h
08035D4A 7008     strb    r0,[r1]       ;偏移2D写入4h
08035D4C 3106     add     r1,6h
08035D4E 7008     strb    r0,[r1]       ;偏移33写入4h
08035D50 4660     mov     r0,r12
08035D52 302A     add     r0,2Ah        ;偏移2A写入0
08035D54 7003     strb    r3,[r0]
08035D56 4904     ldr     r1,=3001530h
08035D58 2001     mov     r0,1h
08035D5A 74C8     strb    r0,[r1,13h]   ;被咬住flag写入1
08035D5C 4770     bx      r14
.pool

;Pose43

08035D6C B530     push    r4,r5,lr
08035D6E F7FFFE19 bl      80359A4h      ;Metroid喝血声音
08035D72 2002     mov     r0,2h
08035D74 F7FFFD16 bl      80357A4h      ;Metroid互相推挤
08035D78 4B15     ldr     r3,=3000738h  
08035D7A 1C19     mov     r1,r3
08035D7C 312C     add     r1,2Ch
08035D7E 7808     ldrb    r0,[r1]       ;读取偏移2C的值 用来改变颜色
08035D80 3801     sub     r0,1h
08035D82 7008     strb    r0,[r1]       ;减1再写入
08035D84 0600     lsl     r0,r0,18h
08035D86 0E02     lsr     r2,r0,18h
08035D88 2A00     cmp     r2,0h
08035D8A D115     bne     @@2CZero      ;如果为0则改变颜色
08035D8C 2004     mov     r0,4h
08035D8E 7008     strb    r0,[r1]       ;为0则再次写入4
08035D90 3101     add     r1,1h
08035D92 7808     ldrb    r0,[r1]       ;2D加1再写入
08035D94 3001     add     r0,1h
08035D96 7008     strb    r0,[r1]
08035D98 0600     lsl     r0,r0,18h
08035D9A 0E00     lsr     r0,r0,18h
08035D9C 2804     cmp     r0,4h
08035D9E D900     bls     @@2DMore4
08035DA0 700A     strb    r2,[r1]       ;2D大于4则归零

@@2DMore4:
08035DA2 4A0C     ldr     r2,=40000D4h
08035DA4 7808     ldrb    r0,[r1]
08035DA6 0140     lsl     r0,r0,5h      ;计算得到调色板
08035DA8 490B     ldr     r1,=82ED988h  ;数据值
08035DAA 1840     add     r0,r0,r1
08035DAC 6010     str     r0,[r2]
08035DAE 480B     ldr     r0,=5000380h  
08035DB0 6050     str     r0,[r2,4h]
08035DB2 480B     ldr     r0,=80000008h
08035DB4 6090     str     r0,[r2,8h]
08035DB6 6890     ldr     r0,[r2,8h]

@@2CZero:
08035DB8 4C05     ldr     r4,=3000738h
08035DBA 8860     ldrh    r0,[r4,2h]    ;读取坐标
08035DBC 88A1     ldrh    r1,[r4,4h]
08035DBE F7FFFACF bl      8035360h      ;检查头上的帽子的判定是否碰砖
08035DC2 0600     lsl     r0,r0,18h
08035DC4 2800     cmp     r0,0h
08035DC6 D00F     beq     @@NoBlock
08035DC8 4906     ldr     r1,=30013D4h
08035DCA 88A0     ldrh    r0,[r4,4h]    ;读取精灵的X坐标
08035DCC 8248     strh    r0,[r1,12h]   ;写入Samus X坐标
08035DCE E00E     b       @@Peer
.pool

@@NoBlock:
08035DE8 491C     ldr     r1,=30013D4h
08035DEA 8A48     ldrh    r0,[r1,12h]     ;读取人物X坐标
08035DEC 80A0     strh    r0,[r4,4h]      ;写入精灵X坐标

@@Peer:
08035DEE 4C1C     ldr     r4,=3000738h
08035DF0 481C     ldr     r0,=3001588h
08035DF2 3070     add     r0,70h
08035DF4 8800     ldrh    r0,[r0]         ;读取人物顶部分界
08035DF6 8A89     ldrh    r1,[r1,14h]
08035DF8 1840     add     r0,r0,r1        ;加上人物Y坐标
08035DFA 2500     mov     r5,0h
08035DFC 8060     strh    r0,[r4,2h]      ;写入精灵的Y坐标
08035DFE F7FFFC73 bl      80356E8h        ;检查炸弹是否炸到精灵
08035E02 0600     lsl     r0,r0,18h
08035E04 2800     cmp     r0,0h
08035E06 D037     beq     @@ContinueLatch
08035E08 4817     ldr     r0,=300083Ch
08035E0A 7801     ldrb    r1,[r0]         ;读取随机数
08035E0C 2001     mov     r0,1h
08035E0E 4008     and     r0,r1           ;检查是否是奇数
08035E10 2210     mov     r2,10h
08035E12 2800     cmp     r0,0h
08035E14 D000     beq     @@UnLatch
08035E16 221C     mov     r2,1Ch

@@UnLatch:
08035E18 1C21     mov     r1,r4
08035E1A 3124     add     r1,24h
08035E1C 2009     mov     r0,9h
08035E1E 7008     strb    r0,[r1]         ;pose写回9
08035E20 1C20     mov     r0,r4
08035E22 3020     add     r0,20h
08035E24 7005     strb    r5,[r0]         ;调色板写回0
08035E26 3102     add     r1,2h
08035E28 200F     mov     r0,0Fh
08035E2A 7008     strb    r0,[r1]         ;偏移26写入0Fh 待机时间
08035E2C 8821     ldrh    r1,[r4]
08035E2E 480F     ldr     r0,=7BFFh
08035E30 4008     and     r0,r1
08035E32 8020     strh    r0,[r4]         ;取向去掉8000和400
08035E34 1C20     mov     r0,r4
08035E36 302C     add     r0,2Ch
08035E38 7005     strb    r5,[r0]         ;偏移2C归零
08035E3A 3003     add     r0,3h
08035E3C 7002     strb    r2,[r0]         ;偏移2F写入设定值10或者1C 垂直加速值
08035E3E 3802     sub     r0,2h
08035E40 7005     strb    r5,[r0]         ;偏移2D归零
08035E42 3001     add     r0,1h
08035E44 7002     strb    r2,[r0]         ;偏移2E写入设定值10或者1C 水平加速值
08035E46 480A     ldr     r0,=82EDC20h
08035E48 61A0     str     r0,[r4,18h]
08035E4A 7725     strb    r5,[r4,1Ch]
08035E4C 2000     mov     r0,0h
08035E4E 82E0     strh    r0,[r4,16h]     ;写回普通的OAM
08035E50 1C20     mov     r0,r4
08035E52 3033     add     r0,33h
08035E54 7005     strb    r5,[r0]         ;偏移33归零
08035E56 4807     ldr     r0,=3001530h
08035E58 74C5     strb    r5,[r0,13h]     ;被咬flag归零
08035E5A E036     b       8035ECAh
.pool

@@ContinueLatch:
08035E78 1C20     mov     r0,r4
08035E7A 302A     add     r0,2Ah
08035E7C 7801     ldrb    r1,[r0]         ;被咬住就会在0~FF循环
08035E7E 201F     mov     r0,1Fh
08035E80 4008     and     r0,r1
08035E82 2800     cmp     r0,0h
08035E84 D11C     bne     @@Add2A
08035E86 2081     mov     r0,81h
08035E88 F7CCFE4A bl      8002B20h
08035E8C 4804     ldr     r0,=3001530h
08035E8E 7BC0     ldrb    r0,[r0,0Fh]
08035E90 2230     mov     r2,30h
08035E92 4002     and     r2,r0           ;检查是否有衣服
08035E94 2A00     cmp     r2,0h
08035E96 D107     bne     @@CheckIfBoth
08035E98 4802     ldr     r0,=16Dh		  ;喝血声
08035E9A F7CCFDBD bl      8002A18h
08035E9E E00F     b       @@Add2A
.pool

@@CheckIfBoth:
08035EA8 2A30     cmp     r2,30h
08035EAA D105     bne     @@OneSuit
08035EAC 4801     ldr     r0,=16Fh
08035EAE F7CCFDB3 bl      8002A18h
08035EB2 E005     b       @@Add2A
08035EB4 016F     lsl     r7,r5,5h
08035EB6 0000     lsl     r0,r0,0h

@@OneSuit:
08035EB8 20B7     mov     r0,0B7h
08035EBA 0040     lsl     r0,r0,1h
08035EBC F7CCFDAC bl      8002A18h

@@Add2A:
08035EC0 4903     ldr     r1,=3000738h
08035EC2 312A     add     r1,2Ah
08035EC4 7808     ldrb    r0,[r1]      ;偏移2A加1
08035EC6 3001     add     r0,1h
08035EC8 7008     strb    r0,[r1]

@@end:
08035ECA BC30     pop     r4,r5
08035ECC BC01     pop     r0
08035ECE 4700     bx      r0
.pool

;Pose62

08035ED4 B5F0     push    r4-r7,lr
08035ED6 B081     add     sp,-4h
08035ED8 4805     ldr     r0,=300083Ch
08035EDA 7802     ldrb    r2,[r0]
08035EDC 4805     ldr     r0,=3000738h
08035EDE 8843     ldrh    r3,[r0,2h]
08035EE0 8884     ldrh    r4,[r0,4h]
08035EE2 8801     ldrh    r1,[r0]
08035EE4 2040     mov     r0,40h
08035EE6 4008     and     r0,r1
08035EE8 2800     cmp     r0,0h
08035EEA D009     beq     8035F00h
08035EEC 1898     add     r0,r3,r2
08035EEE E008     b       8035F02h
08035EF0 083C     lsr     r4,r7,20h
08035EF2 0300     lsl     r0,r0,0Ch
08035EF4 0738     lsl     r0,r7,1Ch
08035EF6 0300     lsl     r0,r0,0Ch
08035EF8 1C58     add     r0,r3,1
08035EFA 0600     lsl     r0,r0,18h
08035EFC 0E03     lsr     r3,r0,18h
08035EFE E02F     b       8035F60h
08035F00 1A98     sub     r0,r3,r2
08035F02 0400     lsl     r0,r0,10h
08035F04 0C03     lsr     r3,r0,10h
08035F06 1C22     mov     r2,r4
08035F08 3224     add     r2,24h
08035F0A 2029     mov     r0,29h
08035F0C 9000     str     r0,[sp]
08035F0E 2000     mov     r0,0h
08035F10 1C19     mov     r1,r3
08035F12 2301     mov     r3,1h
08035F14 F7DBF8B6 bl      8011084h
08035F18 2064     mov     r0,64h
08035F1A 4684     mov     r12,r0
08035F1C 2765     mov     r7,65h
08035F1E 2662     mov     r6,62h
08035F20 2501     mov     r5,1h
08035F22 2480     mov     r4,80h
08035F24 2300     mov     r3,0h
08035F26 4914     ldr     r1,=30001ACh
08035F28 22A8     mov     r2,0A8h
08035F2A 00D2     lsl     r2,r2,3h
08035F2C 1888     add     r0,r1,r2
08035F2E 4281     cmp     r1,r0
08035F30 D216     bcs     8035F60h
08035F32 1C0A     mov     r2,r1
08035F34 3224     add     r2,24h
08035F36 8808     ldrh    r0,[r1]
08035F38 4028     and     r0,r5
08035F3A 2800     cmp     r0,0h
08035F3C D00B     beq     8035F56h
08035F3E 7B90     ldrb    r0,[r2,0Eh]
08035F40 4020     and     r0,r4
08035F42 2800     cmp     r0,0h
08035F44 D107     bne     8035F56h
08035F46 7F48     ldrb    r0,[r1,1Dh]
08035F48 4560     cmp     r0,r12
08035F4A D001     beq     8035F50h
08035F4C 42B8     cmp     r0,r7
08035F4E D102     bne     8035F56h
08035F50 7810     ldrb    r0,[r2]
08035F52 42B0     cmp     r0,r6
08035F54 D3D0     bcc     8035EF8h
08035F56 3238     add     r2,38h
08035F58 3138     add     r1,38h
08035F5A 4808     ldr     r0,=30006ECh
08035F5C 4281     cmp     r1,r0
08035F5E D3EA     bcc     8035F36h
08035F60 2B00     cmp     r3,0h
08035F62 D14F     bne     8036004h
08035F64 4806     ldr     r0,=3000055h
08035F66 7800     ldrb    r0,[r0]
08035F68 3801     sub     r0,1h
08035F6A 2812     cmp     r0,12h
08035F6C D84A     bhi     8036004h
08035F6E 0080     lsl     r0,r0,2h
08035F70 4904     ldr     r1,=8035F88h
08035F72 1840     add     r0,r0,r1
08035F74 6800     ldr     r0,[r0]
08035F76 4687     mov     r15,r0
08035F78 01AC     lsl     r4,r5,6h
08035F7A 0300     lsl     r0,r0,0Ch
08035F7C 06EC     lsl     r4,r5,1Bh
08035F7E 0300     lsl     r0,r0,0Ch
08035F80 0055     lsl     r5,r2,1h
08035F82 0300     lsl     r0,r0,0Ch
08035F84 5F88     ldsh    r0,[r1,r6]
08035F86 0803     lsr     r3,r0,20h
08035F88 5FDA     ldsh    r2,[r3,r7]
08035F8A 0803     lsr     r3,r0,20h
08035F8C 5FE0     ldsh    r0,[r4,r7]
08035F8E 0803     lsr     r3,r0,20h
08035F90 6004     str     r4,[r0]
08035F92 0803     lsr     r3,r0,20h
08035F94 6004     str     r4,[r0]
08035F96 0803     lsr     r3,r0,20h
08035F98 6004     str     r4,[r0]
08035F9A 0803     lsr     r3,r0,20h
08035F9C 6004     str     r4,[r0]
08035F9E 0803     lsr     r3,r0,20h
08035FA0 6004     str     r4,[r0]
08035FA2 0803     lsr     r3,r0,20h
08035FA4 6004     str     r4,[r0]
08035FA6 0803     lsr     r3,r0,20h
08035FA8 6004     str     r4,[r0]
08035FAA 0803     lsr     r3,r0,20h
08035FAC 6004     str     r4,[r0]
08035FAE 0803     lsr     r3,r0,20h
08035FB0 6004     str     r4,[r0]
08035FB2 0803     lsr     r3,r0,20h
08035FB4 6004     str     r4,[r0]
08035FB6 0803     lsr     r3,r0,20h
08035FB8 6004     str     r4,[r0]
08035FBA 0803     lsr     r3,r0,20h
08035FBC 5FD4     ldsh    r4,[r2,r7]
08035FBE 0803     lsr     r3,r0,20h
08035FC0 5FE6     ldsh    r6,[r4,r7]
08035FC2 0803     lsr     r3,r0,20h
08035FC4 5FEC     ldsh    r4,[r5,r7]
08035FC6 0803     lsr     r3,r0,20h
08035FC8 6004     str     r4,[r0]
08035FCA 0803     lsr     r3,r0,20h
08035FCC 6004     str     r4,[r0]
08035FCE 0803     lsr     r3,r0,20h
08035FD0 5FF2     ldsh    r2,[r6,r7]
08035FD2 0803     lsr     r3,r0,20h
08035FD4 2001     mov     r0,1h
08035FD6 2137     mov     r1,37h
08035FD8 E00D     b       8035FF6h
08035FDA 2001     mov     r0,1h
08035FDC 2138     mov     r1,38h
08035FDE E00A     b       8035FF6h
08035FE0 2001     mov     r0,1h
08035FE2 2139     mov     r1,39h
08035FE4 E007     b       8035FF6h
08035FE6 2001     mov     r0,1h
08035FE8 213A     mov     r1,3Ah
08035FEA E004     b       8035FF6h
08035FEC 2001     mov     r0,1h
08035FEE 213B     mov     r1,3Bh
08035FF0 E001     b       8035FF6h
08035FF2 2001     mov     r0,1h
08035FF4 213C     mov     r1,3Ch
08035FF6 F02AFC61 bl      80608BCh
08035FFA 4904     ldr     r1,=300007Bh
08035FFC 2214     mov     r2,14h
08035FFE 4252     neg     r2,r2
08036000 1C10     mov     r0,r2
08036002 7008     strb    r0,[r1]
08036004 B001     add     sp,4h
08036006 BCF0     pop     r4-r7
08036008 BC01     pop     r0
0803600A 4700     bx      r0


MetroidMain:
08036010 B510     push    r4,lr
08036012 490B     ldr     r1,=3000738h
08036014 1C0B     mov     r3,r1
08036016 3332     add     r3,32h
08036018 781A     ldrb    r2,[r3]           ;读取碰撞属性
0803601A 2402     mov     r4,2h
0803601C 1C20     mov     r0,r4
0803601E 4010     and     r0,r2
08036020 2800     cmp     r0,0h
08036022 D00F     beq     @@NoHurt          ;只有受到伤害才为假
08036024 20FD     mov     r0,0FDh
08036026 4010     and     r0,r2
08036028 7018     strb    r0,[r3]           ;去除攻击的标记
0803602A 8809     ldrh    r1,[r1]
0803602C 1C20     mov     r0,r4
0803602E 4008     and     r0,r1             ;读取取向和2 and
08036030 2800     cmp     r0,0h
08036032 D01E     beq     @@FrozenCheck
08036034 20B9     mov     r0,0B9h
08036036 0040     lsl     r0,r0,1h          ;370 水母饥渴声 被打?
08036038 F7CCFD72 bl      8002B20h          ;播放声音
0803603C E019     b       @@FrozenCheck
.pool

@@NoHurt:                                   ;没有被击打到
08036044 1C08     mov     r0,r1
08036046 302B     add     r0,2Bh
08036048 7800     ldrb    r0,[r0]           ;读取击晕时间
0803604A 227F     mov     r2,7Fh
0803604C 4002     and     r2,r0
0803604E 2A02     cmp     r2,2h
08036050 D10F     bne     @@FrozenCheck
08036052 8A88     ldrh    r0,[r1,14h]       ;读取血量
08036054 88CB     ldrh    r3,[r1,6h]        ;读取备份的血量
08036056 4298     cmp     r0,r3
08036058 D10A     bne     @@UpdatePreviousHealth
0803605A 8808     ldrh    r0,[r1]
0803605C 4002     and     r2,r0
0803605E 2A00     cmp     r2,0h
08036060 D007     beq     @@FrozenCheck     
08036062 4802     ldr     r0,=171h
08036064 F7CCFD5C bl      8002B20h          ;播放水母的声音 369
08036068 E003     b       @@FrozenCheck
.pool

@@UpdatePreviousHealth:
08036070 80C8     strh    r0,[r1,6h]

@@FrozenCheck:
08036072 4A0C     ldr     r2,=3000738h
08036074 1C10     mov     r0,r2
08036076 3030     add     r0,30h
08036078 7800     ldrb    r0,[r0]           ;读取冰冻时间
0803607A 2800     cmp     r0,0h
0803607C D022     beq     @@NoFrozen
;-------------------------------------------冰冻的设置
0803607E 480A     ldr     r0,=0FFD0h
08036080 8150     strh    r0,[r2,0Ah]       ;上部分界
08036082 2028     mov     r0,28h
08036084 8190     strh    r0,[r2,0Ch]       ;下部分界
08036086 4809     ldr     r0,=0FFC0h   
08036088 81D0     strh    r0,[r2,0Eh]       ;左部分界
0803608A 2040     mov     r0,40h
0803608C 8210     strh    r0,[r2,10h]       ;右部分界
0803608E 2001     mov     r0,1h
08036090 F7FFFB88 bl      MetroidPush
08036094 4806     ldr     r0,=300002Ch
08036096 7800     ldrb    r0,[r0]           ;检查难度
08036098 2800     cmp     r0,0h             ;如果是简单难度的话
0803609A D10B     bne     @@FastThaw
0803609C F7D9FFD6 bl      801004Ch          ;普通解冻例程
080360A0 E00A     b       @@Goto1
.pool

@@FastThaw:
080360B4 F7D9FFF6 bl      80100A4h          ;快速解冻例程

@@Goto1:
080360B8 4901     ldr     r1,=3000738h      ;冰冻的M的精灵ID写为65h
080360BA 2065     mov     r0,65h
080360BC 7748     strb    r0,[r1,1Dh]
080360BE E050     b       @@Thend
.pool

@@NoFrozen:
080360C4 7F50     ldrb    r0,[r2,1Dh]
080360C6 2865     cmp     r0,65h            ;检查精灵序号是否是65h
080360C8 D10F     bne     @@Goto2          
080360CA 490F     ldr     r1,=0FFD8h        ;没被冰冻还是65则写回判定
080360CC 8151     strh    r1,[r2,0Ah]
080360CE 2020     mov     r0,20h
080360D0 8190     strh    r0,[r2,0Ch]
080360D2 81D1     strh    r1,[r2,0Eh]
080360D4 2028     mov     r0,28h
080360D6 8210     strh    r0,[r2,10h]
080360D8 2064     mov     r0,64h
080360DA 7750     strb    r0,[r2,1Dh]       ;精灵ID再次写回64h
080360DC 1C11     mov     r1,r2
080360DE 3124     add     r1,24h
080360E0 7808     ldrb    r0,[r1]           ;读取pose
080360E2 2861     cmp     r0,61h
080360E4 D801     bhi     @@Goto2           ;大于61则跳过
080360E6 2008     mov     r0,8h
080360E8 7008     strb    r0,[r1]           ;否则pose写入8h等于解冻后的第一个pose

@@Goto2:
080360EA 4808     ldr     r0,=3000738h
080360EC 3024     add     r0,24h
080360EE 7800     ldrb    r0,[r0]           ;读取pose值
080360F0 2808     cmp     r0,8h
080360F2 D025     beq     @@MetroidPose8
080360F4 2808     cmp     r0,8h
080360F6 DC0E     bgt     @@MetroidPoseMoreThan8
080360F8 2801     cmp     r0,1h
080360FA D01B     beq     @@MetroidPose1
080360FC 2801     cmp     r0,1h
080360FE DC07     bgt     @@MetroidPoseMoreThan1
08036100 2800     cmp     r0,0h
08036102 D014     beq     @@MetroidPose0
08036104 E028     b       @@WillEnd
.pool

@@MetroidPoseMoreThan1:
08036110 2802     cmp     r0,2h
08036112 D012     beq     @@MetroidPose2
08036114 E020     b       @@WillEnd

@@MetroidPoseMoreThan8:
08036116 2842     cmp     r0,42h
08036118 D017     beq     @@MetroidPose42
0803611A 2842     cmp     r0,42h
0803611C DC02     bgt     @@MetroidPoseMoreThan42
0803611E 2809     cmp     r0,9h
08036120 D010     beq     @@MetroidPose9
08036122 E019     b       @@WillEnd

@@MetroidPoseMoreThan42:
08036124 2843     cmp     r0,43h
08036126 D012     beq     @@MetroidPose43
08036128 2862     cmp     r0,62h
0803612A D013     beq     @@MetroidPose62
0803612C E014     b       @@WillEnd

@@MetroidPose0:
0803612E F7FFFC4F bl      80359D0h
08036132 E011     b       @@WillEnd

@@MetroidPose1:
08036134 F7FFFD0E bl      8035B54h
08036138 E00E     b       @@WillEnd

@@MetroidPose2:
0803613A F7FFFD2D bl      8035B98h
0803613E E00B     b       @@WillEnd

@@MetroidPose8:
08036140 F7FFFD98 bl      8035C74h

@@MetroidPose9:
08036144 F7FFFDB0 bl      8035CA8h
08036148 E006     b       @@WillEnd

@@MetroidPose42:
0803614A F7FFFDED bl      8035D28h

@@MetroidPose43:
0803614E F7FFFE0D bl      8035D6Ch
08036152 E001     b       @@WillEnd

@@MetroidPose62:
08036154 F7FFFEBE bl      8035ED4h

@@WillEnd:
08036158 4A03     ldr     r2,=3000738h
0803615A 8811     ldrh    r1,[r2]
0803615C 4803     ldr     r0,=0F7FFh
0803615E 4008     and     r0,r1
08036160 8010     strh    r0,[r2]

@@Thend:
08036162 BC10     pop     r4
08036164 BC01     pop     r0
08036166 4700     bx      r0
.pool

;水母壳

08036170 B5F0     push    r4-r7,lr
08036172 B081     add     sp,-4h
08036174 4B10     ldr     r3,=3000738h
08036176 1C18     mov     r0,r3
08036178 3023     add     r0,23h
0803617A 7806     ldrb    r6,[r0]            ;读取主精灵序号
0803617C 1C19     mov     r1,r3
0803617E 3126     add     r1,26h
08036180 2001     mov     r0,1h
08036182 7008     strb    r0,[r1]            ;待机写入1
08036184 4A0D     ldr     r2,=30001ACh
08036186 00F0     lsl     r0,r6,3h
08036188 1B80     sub     r0,r0,r6
0803618A 00C0     lsl     r0,r0,3h
0803618C 1885     add     r5,r0,r2           ;得到主精灵的数据起始
0803618E 1C28     mov     r0,r5
08036190 3020     add     r0,20h
08036192 7801     ldrb    r1,[r0]            ;读取调色板
08036194 1C18     mov     r0,r3
08036196 3020     add     r0,20h        
08036198 7001     strb    r1,[r0]            ;写入当前副精灵的调色板
0803619A 8AA8     ldrh    r0,[r5,14h]        ;读取主精灵的血量
0803619C 4694     mov     r12,r2
0803619E 2800     cmp     r0,0h
080361A0 D125     bne     @@NoDie
080361A2 4807     ldr     r0,=300083Ch
080361A4 7802     ldrb    r2,[r0]            ;读取随机数
080361A6 885C     ldrh    r4,[r3,2h]
080361A8 889E     ldrh    r6,[r3,4h]         ;当前副精灵的坐标
080361AA 8829     ldrh    r1,[r5]            ;读取主精灵的取向
080361AC 2040     mov     r0,40h
080361AE 4008     and     r0,r1
080361B0 2800     cmp     r0,0h              ;检查是否有40h
080361B2 D007     beq     @@Pass
080361B4 1AA0     sub     r0,r4,r2           ;Y坐标减去随机数
080361B6 E006     b       @@Peer

@@Pass:
080361C4 18A0     add     r0,r4,r2           ;Y坐标加上随机数

@@Peer:
080361C6 0400     lsl     r0,r0,10h
080361C8 0C04     lsr     r4,r0,10h
080361CA 2064     mov     r0,64h
080361CC 7758     strb    r0,[r3,1Dh]        ;当前副精灵ID写入64h
080361CE 1C1A     mov     r2,r3
080361D0 3232     add     r2,32h
080361D2 7811     ldrb    r1,[r2]            ;读取碰撞属性
080361D4 207F     mov     r0,7Fh
080361D6 4008     and     r0,r1
080361D8 7010     strb    r0,[r2]            ;去掉80再写入
080361DA 1C32     mov     r2,r6              ;X坐标
080361DC 3A24     sub     r2,24h             ;减24
080361DE 2029     mov     r0,29h
080361E0 9000     str     r0,[sp]            ;类型写入29
080361E2 2000     mov     r0,0h              ;在原精灵数据上写入掉落
080361E4 1C21     mov     r1,r4              ;Y坐标
080361E6 2301     mov     r3,1h              ;有声
080361E8 F7DAFF4C bl      8011084h           ;死亡烟花以及掉落
080361EC E037     b       803625Eh

@@NoDie:
080361EE 1C1F     mov     r7,r3
080361F0 3724     add     r7,24h
080361F2 783C     ldrb    r4,[r7]            ;读取当前副精灵的pose
080361F4 2C00     cmp     r4,0h
080361F6 D11D     bne     PoseNoZero
080361F8 1C18     mov     r0,r3
080361FA 3025     add     r0,25h
080361FC 7004     strb    r4,[r0]            ;属性写入0
080361FE 1C19     mov     r1,r3
08036200 3127     add     r1,27h
08036202 2014     mov     r0,14h             ;上视界写入14h
08036204 7008     strb    r0,[r1]            ;左右视界写入0Ah
08036206 3101     add     r1,1h
08036208 200A     mov     r0,0Ah
0803620A 7008     strb    r0,[r1]
0803620C 3101     add     r1,1h
0803620E 2018     mov     r0,18h             ;下视界写入18h
08036210 7008     strb    r0,[r1]
08036212 2200     mov     r2,0h
08036214 4914     ldr     r1,=0FFFCh
08036216 8159     strh    r1,[r3,0Ah]        ;上分界写入FFFC
08036218 2004     mov     r0,4h 
0803621A 8198     strh    r0,[r3,0Ch]        ;下分界写入4
0803621C 81D9     strh    r1,[r3,0Eh]        ;左分界写入0Eh
0803621E 8218     strh    r0,[r3,10h]        ;右分界写入4
08036220 2009     mov     r0,9h
08036222 7038     strb    r0,[r7]            ;pose写入9h
08036224 1C19     mov     r1,r3
08036226 3122     add     r1,22h
08036228 2003     mov     r0,3h
0803622A 7008     strb    r0,[r1]            ;副精灵相关调用写入3
0803622C 480F     ldr     r0,=82EDC08h
0803622E 6198     str     r0,[r3,18h]        ;OAM写入
08036230 771A     strb    r2,[r3,1Ch]
08036232 82DC     strh    r4,[r3,16h]

@@PoseNoZero:
08036234 881A     ldrh    r2,[r3]
08036236 2004     mov     r0,4h
08036238 4010     and     r0,r2
0803623A 2800     cmp     r0,0h              ;取向检查是否有4 隐色
0803623C D007     beq     @@NoShow
0803623E 8829     ldrh    r1,[r5]
08036240 2080     mov     r0,80h
08036242 4008     and     r0,r1              ;读取主精灵的取向
08036244 2800     cmp     r0,0h              ;检查是否有80
08036246 D102     bne     @@Show             ;有80则结束 无则显示副精灵色
08036248 4809     ldr     r0,=0FFFBh
0803624A 4010     and     r0,r2              ;去掉隐色
0803624C 8018     strh    r0,[r3]

@@NoShow:
0803624E 00F0     lsl     r0,r6,3h
08036250 1B80     sub     r0,r0,r6
08036252 00C0     lsl     r0,r0,3h           ;主精灵序号的顺位
08036254 4460     add     r0,r12             ;加上起始坐标
08036256 8841     ldrh    r1,[r0,2h]         ;读取主精灵的Y坐标
08036258 8059     strh    r1,[r3,2h]         ;写入当前副精灵的Y坐标
0803625A 8880     ldrh    r0,[r0,4h]
0803625C 8098     strh    r0,[r3,4h]

@@end:
0803625E B001     add     sp,4h
08036260 BCF0     pop     r4-r7
08036262 BC01     pop     r0
08036264 4700     bx      r0
.pool