080504EC B570     push    r4-r6,lr
080504EE>1C04     mov     r4,r0         ;当前精灵数据起始
080504F0 1C25     mov     r5,r4
080504F2 3532     add     r5,32h   
080504F4 7829     ldrb    r1,[r5]       ;读取碰撞属性
080504F6 2040     mov     r0,40h
080504F8 4008     and     r0,r1
080504FA 2800     cmp     r0,0h         ;检查是否是无敌属性
080504FC D003     beq     @@NoInvincible
080504FE 1C20     mov     r0,r4
08050500 F7FFFFD4 bl      80504ACh      ;弹丸攻击在无敌的敌人身上例程
08050504 E04F     b       @@end

@@NoInvincible:
08050506 2008     mov     r0,8h
08050508 4008     and     r0,r1
0805050A 0600     lsl     r0,r0,18h
0805050C 0E06     lsr     r6,r0,18h
0805050E 2E00     cmp     r6,0h
08050510 D003     beq     @@NoInvincible1
08050512 1C20     mov     r0,r4
08050514 F7FFFFDA bl      80504CCh      ;另一种无敌的例程
08050518 E045     b       @@end

@@NoInvincible1:
0805051A 1C20     mov     r0,r4
0805051C F7FFFF28 bl      8050370h      ;获取精灵的弱点
08050520 2110     mov     r1,10h
08050522 4001     and     r1,r0         ;检查是否有超炸弱点
08050524 2900     cmp     r1,0h
08050526 D029     beq     @@ImmunePowerBome
08050528 8AA0     ldrh    r0,[r4,14h]   ;读取敌人血量
0805052A 2832     cmp     r0,32h        ;比较是否小于32h
0805052C D902     bls     @@SpriteWillDeath
0805052E 3832     sub     r0,32h        ;大于则减32再写入
08050530 82A0     strh    r0,[r4,14h]
08050532 E01E     b       @@Goto

@@SpriteWillDeath:
08050534 2300     mov     r3,0h
08050536 82A6     strh    r6,[r4,14h]   ;血量写入0
08050538 7829     ldrb    r1,[r5]       ;读取碰撞属性
0805053A 2010     mov     r0,10h
0805053C 4308     orr     r0,r1
0805053E 7028     strb    r0,[r5]       ;加上10再写入
08050540 1C20     mov     r0,r4
08050542 3030     add     r0,30h
08050544 7003     strb    r3,[r0]       ;冰冻时间归零
08050546 3810     sub     r0,10h
08050548 7003     strb    r3,[r0]       ;调色板号归零
0805054A 1C21     mov     r1,r4
0805054C 3131     add     r1,31h
0805054E 7808     ldrb    r0,[r1]       ;读取踩敌数据
08050550 2800     cmp     r0,0h
08050552 D006     beq     @@Pass        ;没有踩敌则跳过
08050554 4A08     ldr     r2,=30013D4h
08050556 7850     ldrb    r0,[r2,1h]
08050558 2801     cmp     r0,1h         ;同样检查敌数据
0805055A D102     bne     @@Pass
0805055C 2002     mov     r0,2h
0805055E 7050     strb    r0,[r2,1h]    ;写入2
08050560 700B     strb    r3,[r1]       ;踩敌数据归零

@@Pass:
08050562 1C20     mov     r0,r4
08050564 3024     add     r0,24h
08050566 2162     mov     r1,62h
08050568 7001     strb    r1,[r0]       ;死亡pose
0805056A 1C21     mov     r1,r4
0805056C 3126     add     r1,26h
0805056E 2001     mov     r0,1h
08050570 7008     strb    r0,[r1]       ;待机时间写入1

@@Goto:
08050572 2211     mov     r2,11h
08050574 E003     b       @@Peer
08050576 0000     lsl     r0,r0,0h
08050578 13D4     asr     r4,r2,0Fh
0805057A 0300     lsl     r0,r0,0Ch

@@ImmunePowerBome:
0805057C 2203     mov     r2,3h

@@Peer:
0805057E 1C21     mov     r1,r4
08050580 312B     add     r1,2Bh
08050582 780B     ldrb    r3,[r1]   ;读取击晕时间?
08050584 207F     mov     r0,7Fh
08050586 4018     and     r0,r3
08050588 4290     cmp     r0,r2     ;去掉80和3或者11比较
0805058A D203     bcs     @@Noorr   ;大于或等于则跳过
0805058C 2080     mov     r0,80h
0805058E 4302     orr     r2,r0
08050590 700A     strb    r2,[r1]   ;否则自设时间加上80再写入
08050592 E002     b       @@Peer2

@@Noorr:                            ;这个代码没有使用?
08050594 2080     mov     r0,80h
08050596 4318     orr     r0,r3
08050598 7008     strb    r0,[r1]   

@@Peer2:
0805059A 1C22     mov     r2,r4
0805059C 3232     add     r2,32h
0805059E 7811     ldrb    r1,[r2]
080505A0 2002     mov     r0,2h
080505A2 4308     orr     r0,r1     ;碰撞属性orr2再写入
080505A4 7010     strb    r0,[r2]

@@end:
080505A6 BC70     pop     r4-r6
080505A8 BC01     pop     r0
080505AA 4700     bx      r0



080505AC B5F0     push    r4-r7,lr
080505AE 4657     mov     r7,r10
080505B0 464E     mov     r6,r9
080505B2 4645     mov     r5,r8
080505B4 B4E0     push    r5-r7
080505B6 B081     add     sp,-4h
080505B8 1C04     mov     r4,r0
080505BA 9809     ldr     r0,[sp,24h]
080505BC 0409     lsl     r1,r1,10h
080505BE 0C0D     lsr     r5,r1,10h
080505C0 9500     str     r5,[sp]
080505C2 0412     lsl     r2,r2,10h
080505C4 0C16     lsr     r6,r2,10h
080505C6 46B2     mov     r10,r6
080505C8 041B     lsl     r3,r3,10h
080505CA 0C1B     lsr     r3,r3,10h
080505CC 4698     mov     r8,r3
080505CE 0600     lsl     r0,r0,18h
080505D0 0E07     lsr     r7,r0,18h
080505D2 46B9     mov     r9,r7
080505D4 1C20     mov     r0,r4
080505D6 3032     add     r0,32h
080505D8 7801     ldrb    r1,[r0]
080505DA 2008     mov     r0,8h
080505DC 4008     and     r0,r1
080505DE 2800     cmp     r0,0h
080505E0 D008     beq     80505F4h
080505E2 1C20     mov     r0,r4
080505E4 F7FFFF72 bl      80504CCh
080505E8 1C28     mov     r0,r5
080505EA 1C31     mov     r1,r6
080505EC 1C3A     mov     r2,r7
080505EE F003FD7D bl      80540ECh
080505F2 E027     b       8050644h
080505F4 2040     mov     r0,40h
080505F6 4008     and     r0,r1
080505F8 2800     cmp     r0,0h
080505FA D008     beq     805060Eh
080505FC 1C20     mov     r0,r4
080505FE F7FFFF55 bl      80504ACh
08050602 1C28     mov     r0,r5
08050604 1C31     mov     r1,r6
08050606 222F     mov     r2,2Fh
08050608 F003FD70 bl      80540ECh
0805060C E01A     b       8050644h
0805060E 1C20     mov     r0,r4
08050610 F7FFFEAE bl      8050370h
08050614 0400     lsl     r0,r0,10h
08050616 0C00     lsr     r0,r0,10h
08050618 2102     mov     r1,2h
0805061A 4008     and     r0,r1
0805061C 2800     cmp     r0,0h
0805061E D009     beq     8050634h
08050620 1C20     mov     r0,r4
08050622 4641     mov     r1,r8
08050624 F7FFFEFE bl      8050424h
08050628 1C28     mov     r0,r5
0805062A 1C31     mov     r1,r6
0805062C 464A     mov     r2,r9
0805062E F003FD5D bl      80540ECh
08050632 E007     b       8050644h
08050634 1C20     mov     r0,r4
08050636 F7FFFF49 bl      80504CCh
0805063A 9800     ldr     r0,[sp]
0805063C 4651     mov     r1,r10
0805063E 222F     mov     r2,2Fh
08050640 F003FD54 bl      80540ECh
08050644 B001     add     sp,4h
08050646 BC38     pop     r3-r5
08050648 4698     mov     r8,r3
0805064A 46A1     mov     r9,r4
0805064C 46AA     mov     r10,r5
0805064E BCF0     pop     r4-r7
08050650 BC01     pop     r0
08050652 4700     bx      r0
08050654 B5F0     push    r4-r7,lr
08050656 4657     mov     r7,r10
08050658 464E     mov     r6,r9
0805065A 4645     mov     r5,r8
0805065C B4E0     push    r5-r7
0805065E B081     add     sp,-4h
08050660 1C04     mov     r4,r0
08050662 9809     ldr     r0,[sp,24h]
08050664 0409     lsl     r1,r1,10h
08050666 0C0D     lsr     r5,r1,10h
08050668 9500     str     r5,[sp]
0805066A 0412     lsl     r2,r2,10h
0805066C 0C16     lsr     r6,r2,10h
0805066E 46B2     mov     r10,r6
08050670 041B     lsl     r3,r3,10h
08050672 0C1B     lsr     r3,r3,10h
08050674 4698     mov     r8,r3
08050676 0600     lsl     r0,r0,18h
08050678 0E07     lsr     r7,r0,18h
0805067A 46B9     mov     r9,r7
0805067C 1C20     mov     r0,r4
0805067E 3032     add     r0,32h
08050680 7801     ldrb    r1,[r0]
08050682 2008     mov     r0,8h
08050684 4008     and     r0,r1
08050686 2800     cmp     r0,0h
08050688 D008     beq     805069Ch
0805068A 1C20     mov     r0,r4
0805068C F7FFFF1E bl      80504CCh
08050690 1C28     mov     r0,r5
08050692 1C31     mov     r1,r6
08050694 1C3A     mov     r2,r7
08050696 F003FD29 bl      80540ECh
0805069A E027     b       80506ECh
0805069C 2040     mov     r0,40h
0805069E 4008     and     r0,r1
080506A0 2800     cmp     r0,0h
080506A2 D008     beq     80506B6h
080506A4 1C20     mov     r0,r4
080506A6 F7FFFF01 bl      80504ACh
080506AA 1C28     mov     r0,r5
080506AC 1C31     mov     r1,r6
080506AE 222F     mov     r2,2Fh
080506B0 F003FD1C bl      80540ECh
080506B4 E01A     b       80506ECh
080506B6 1C20     mov     r0,r4
080506B8 F7FFFE5A bl      8050370h
080506BC 0400     lsl     r0,r0,10h
080506BE 21C0     mov     r1,0C0h
080506C0 0289     lsl     r1,r1,0Ah
080506C2 4001     and     r1,r0
080506C4 2900     cmp     r1,0h
080506C6 D009     beq     80506DCh
080506C8 1C20     mov     r0,r4
080506CA 4641     mov     r1,r8
080506CC F7FFFEAA bl      8050424h
080506D0 1C28     mov     r0,r5
080506D2 1C31     mov     r1,r6
080506D4 464A     mov     r2,r9
080506D6 F003FD09 bl      80540ECh
080506DA E007     b       80506ECh
080506DC 1C20     mov     r0,r4
080506DE F7FFFEF5 bl      80504CCh
080506E2 9800     ldr     r0,[sp]
080506E4 4651     mov     r1,r10
080506E6 222F     mov     r2,2Fh
080506E8 F003FD00 bl      80540ECh
