
;Posezero
0802FF44 B5F0     push    r4-r7,lr
0802FF46 4647     mov     r7,r8
0802FF48 B480     push    r7
0802FF4A B083     add     sp,-0Ch
0802FF4C 1C06     mov     r6,r0
0802FF4E 2300     mov     r3,0h
0802FF50 2200     mov     r2,0h
0802FF52 4822     ldr     r0,=0FFFCh
0802FF54 8170     strh    r0,[r6,0Ah]
0802FF56 81B2     strh    r2,[r6,0Ch]
0802FF58 81F0     strh    r0,[r6,0Eh] 
0802FF5A 2104     mov     r1,4h
0802FF5C 2004     mov     r0,4h
0802FF5E 8230     strh    r0,[r6,10h]  ;四面分界
0802FF60 1C30     mov     r0,r6
0802FF62 3027     add     r0,27h
0802FF64 2508     mov     r5,8h
0802FF66 7005     strb    r5,[r0]      ;上视界写入8
0802FF68 3001     add     r0,1h
0802FF6A 7001     strb    r1,[r0]      ;左右视界写入4
0802FF6C 3001     add     r0,1h
0802FF6E 7005     strb    r5,[r0]      ;下视界写入8
0802FF70 481B     ldr     r0,=82E8318h
0802FF72 61B0     str     r0,[r6,18h]  ;OAM
0802FF74 7733     strb    r3,[r6,1Ch]
0802FF76 82F2     strh    r2,[r6,16h]
0802FF78 1C31     mov     r1,r6
0802FF7A 3125     add     r1,25h
0802FF7C 2017     mov     r0,17h
0802FF7E 7008     strb    r0,[r1]      ;属性写入17h
0802FF80 2001     mov     r0,1h
0802FF82 82B0     strh    r0,[r6,14h]  ;血量写入1h
0802FF84 4817     ldr     r0,=300070Ch
0802FF86 7383     strb    r3,[r0,0Eh]  ;动画帧备份到71A
0802FF88 F7DFFC40 bl      800F80Ch     ;随机方向设定
0802FF8C 1C30     mov     r0,r6
0802FF8E 3024     add     r0,24h
0802FF90 7005     strb    r5,[r0]      ;pose写入8h
0802FF92 7F70     ldrb    r0,[r6,1Dh]
0802FF94 4680     mov     r8,r0
0802FF96 285E     cmp     r0,5Eh       ;检查精灵ID
0802FF98 D163     bne     @@end
0802FF9A 4813     ldr     r0,=3001530h ;精灵是5e的话
0802FF9C 7B01     ldrb    r1,[r0,0Ch]  
0802FF9E 2080     mov     r0,80h
0802FFA0 4008     and     r0,r1
0802FFA2 2800     cmp     r0,0h        ;检查炸弹是否被得到
0802FFA4 D008     beq     @@NoDoorLock
0802FFA6 2003     mov     r0,3h
0802FFA8 212D     mov     r1,2Dh
0802FFAA F030FC87 bl      80608BCh     ;检查5E炸弹虫被消灭过的事件
0802FFAE 2800     cmp     r0,0h
0802FFB0 D102     bne     @@PassDoorLock
0802FFB2 490E     ldr     r1,=300007Bh
0802FFB4 2001     mov     r0,1h
0802FFB6 7008     strb    r0,[r1]      ;锁门flag

@@PassDoorLock:
0802FFB8 8831     ldrh    r1,[r6]
0802FFBA 2004     mov     r0,4h
0802FFBC 4008     and     r0,r1        ;取向 and 4
0802FFBE 0400     lsl     r0,r0,10h
0802FFC0 0C05     lsr     r5,r0,10h
0802FFC2 2D00     cmp     r5,0h        ;无隐形
0802FFC4 D018     beq     @@No4
0802FFC6 480A     ldr     r0,=300083Ch
0802FFC8 7807     ldrb    r7,[r0]      ;读取随机数
0802FFCA 480A     ldr     r0,=0FFFBh
0802FFCC 4008     and     r0,r1
0802FFCE 8030     strh    r0,[r6]      ;去掉隐形再写入
0802FFD0 1C38     mov     r0,r7
0802FFD2 4378     mul     r0,r7        ;随机数的平方
0802FFD4 88B1     ldrh    r1,[r6,4h]   
0802FFD6 1840     add     r0,r0,r1     ;加上X坐标再写入
0802FFD8 80B0     strh    r0,[r6,4h]
0802FFDA E042     b       @@end
.pool

@@No4:
0802FFF8 7FF7     ldrb    r7,[r6,1Fh]  ;读取gfx row
0802FFFA 7FB0     ldrb    r0,[r6,1Eh]  ;读取精灵序号
0802FFFC 9002     str     r0,[sp,8h]   ;备份到sp8
0802FFFE 8874     ldrh    r4,[r6,2h]
08030000 88B6     ldrh    r6,[r6,4h]
08030002 1C30     mov     r0,r6
08030004 3808     sub     r0,8h
08030006 9000     str     r0,[sp]
08030008 9501     str     r5,[sp,4h]
0803000A 4640     mov     r0,r8
0803000C 9902     ldr     r1,[sp,8h]
0803000E 1C3A     mov     r2,r7
08030010 1C23     mov     r3,r4
08030012 F7DEF983 bl      800E31Ch     ;生产第一精灵
08030016 1C30     mov     r0,r6
08030018 300C     add     r0,0Ch
0803001A 9000     str     r0,[sp]
0803001C 9501     str     r5,[sp,4h]
0803001E 4640     mov     r0,r8
08030020 9902     ldr     r1,[sp,8h]
08030022 1C3A     mov     r2,r7
08030024 1C23     mov     r3,r4
08030026 F7DEF979 bl      800E31Ch
0803002A 1C30     mov     r0,r6
0803002C 380C     sub     r0,0Ch
0803002E 9000     str     r0,[sp]
08030030 9501     str     r5,[sp,4h]
08030032 4640     mov     r0,r8
08030034 9902     ldr     r1,[sp,8h]
08030036 1C3A     mov     r2,r7
08030038 1C23     mov     r3,r4
0803003A F7DEF96F bl      800E31Ch
0803003E 1C30     mov     r0,r6
08030040 3008     add     r0,8h
08030042 9000     str     r0,[sp]
08030044 9501     str     r5,[sp,4h]
08030046 4640     mov     r0,r8
08030048 9902     ldr     r1,[sp,8h]
0803004A 1C3A     mov     r2,r7
0803004C 1C23     mov     r3,r4
0803004E F7DEF965 bl      800E31Ch
08030052 9600     str     r6,[sp]
08030054 9501     str     r5,[sp,4h]
08030056 4640     mov     r0,r8
08030058 9902     ldr     r1,[sp,8h]
0803005A 1C3A     mov     r2,r7
0803005C 1C23     mov     r3,r4
0803005E F7DEF95D bl      800E31Ch

@@end:
08030062 B003     add     sp,0Ch
08030064 BC08     pop     r3
08030066 4698     mov     r8,r3
08030068 BCF0     pop     r4-r7
0803006A BC01     pop     r0
0803006C 4700     bx      r0
.pool

08030070 B530     push    r4,r5,lr
08030072 1C03     mov     r3,r0
08030074 1C19     mov     r1,r3
08030076 3124     add     r1,24h
08030078 2500     mov     r5,0h
0803007A 2043     mov     r0,43h
0803007C 7008     strb    r0,[r1]
0803007E 480E     ldr     r0,=82E84E0h
08030080 6198     str     r0,[r3,18h]
08030082 2100     mov     r1,0h
08030084 82DD     strh    r5,[r3,16h]
08030086 7719     strb    r1,[r3,1Ch]
08030088 1C18     mov     r0,r3
0803008A 302C     add     r0,2Ch
0803008C 7001     strb    r1,[r0]
0803008E 4A0B     ldr     r2,=30013D4h
08030090 490B     ldr     r1,=3001588h
08030092 1C08     mov     r0,r1
08030094 3070     add     r0,70h
08030096 8800     ldrh    r0,[r0]
08030098 8A94     ldrh    r4,[r2,14h]
0803009A 1900     add     r0,r0,r4
0803009C 0400     lsl     r0,r0,10h
0803009E 0C04     lsr     r4,r0,10h
080300A0 316E     add     r1,6Eh
080300A2 8808     ldrh    r0,[r1]
080300A4 8A51     ldrh    r1,[r2,12h]
080300A6 1840     add     r0,r0,r1
080300A8 0400     lsl     r0,r0,10h
080300AA 0C01     lsr     r1,r0,10h
080300AC 8858     ldrh    r0,[r3,2h]
080300AE 42A0     cmp     r0,r4
080300B0 D208     bcs     80300C4h
080300B2 80DD     strh    r5,[r3,6h]
080300B4 E008     b       80300C8h
080300B6 0000     lsl     r0,r0,0h
080300B8 84E0     strh    r0,[r4,26h]
080300BA 082E     lsr     r6,r5,20h
080300BC 13D4     asr     r4,r2,0Fh
080300BE 0300     lsl     r0,r0,0Ch
080300C0 1588     asr     r0,r1,16h
080300C2 0300     lsl     r0,r0,0Ch
080300C4 1B00     sub     r0,r0,r4
080300C6 80D8     strh    r0,[r3,6h]
080300C8 8898     ldrh    r0,[r3,4h]
080300CA 4288     cmp     r0,r1
080300CC D201     bcs     80300D2h
080300CE 2000     mov     r0,0h
080300D0 E000     b       80300D4h
080300D2 1A40     sub     r0,r0,r1
080300D4 8118     strh    r0,[r3,8h]
080300D6 8859     ldrh    r1,[r3,2h]
080300D8 8A90     ldrh    r0,[r2,14h]
080300DA 3840     sub     r0,40h
080300DC 4281     cmp     r1,r0
080300DE DD05     ble     80300ECh
080300E0 8819     ldrh    r1,[r3]
080300E2 4801     ldr     r0,=0FEFFh
080300E4 4008     and     r0,r1
080300E6 E006     b       80300F6h
080300E8 FEFF0000 ????
080300EA 0000     lsl     r0,r0,0h
080300EC 8819     ldrh    r1,[r3]
080300EE 2280     mov     r2,80h
080300F0 0052     lsl     r2,r2,1h
080300F2 1C10     mov     r0,r2
080300F4 4308     orr     r0,r1
080300F6 8018     strh    r0,[r3]
080300F8 BC30     pop     r4,r5
080300FA BC01     pop     r0
080300FC 4700     bx      r0
.pool

;pose 43

08030100 B5F0     push    r4-r7,lr
08030102 1C03     mov     r3,r0
08030104 4808     ldr     r0,=30013D4h
08030106 7801     ldrb    r1,[r0]
08030108 1C06     mov     r6,r0
0803010A 290F     cmp     r1,0Fh        ;读取samus姿势是否是旋转攻击
0803010C D110     bne     @@NoScrew
0803010E 1C18     mov     r0,r3
08030110 3024     add     r0,24h
08030112 2144     mov     r1,44h        ;pose写入44h
08030114 7001     strb    r1,[r0]
08030116 4805     ldr     r0,=300083Ch
08030118 7802     ldrb    r2,[r0]       ;随机值如果大于5h
0803011A 2A05     cmp     r2,5h
0803011C D800     bhi     @@Pass
0803011E 2206     mov     r2,6h

@@Pass:
08030120 1C18     mov     r0,r3
08030122 302E     add     r0,2Eh
08030124 7002     strb    r2,[r0]       ;偏移2E写入不会大于6的随机值
08030126 E0AF     b       @@end
.pool

@@NoScrew:
08030130 490E     ldr     r1,=3000734h
08030132 7808     ldrb    r0,[r1]       ;读取循环数
08030134 2800     cmp     r0,0h
08030136 D101     bne     @@Pass1
08030138 205A     mov     r0,5Ah        ;为0的话则再次写入5A
0803013A 7008     strb    r0,[r1]

@@Pass1:
0803013C 881C     ldrh    r4,[r3]
0803013E 2580     mov     r5,80h
08030140 006D     lsl     r5,r5,1h
08030142 1C28     mov     r0,r5
08030144 4020     and     r0,r4         ;取向检查是否有100h  
08030146 2800     cmp     r0,0h
08030148 D016     beq     @@No100
0803014A 4A09     ldr     r2,=3001588h
0803014C 1C10     mov     r0,r2
0803014E 3074     add     r0,74h
08030150 2500     mov     r5,0h
08030152 5F41     ldsh    r1,[r0,r5]    ;下部分界
08030154 8AB7     ldrh    r7,[r6,14h]   ;读取Y坐标
08030156 19C9     add     r1,r1,r7      ;相加
08030158 8858     ldrh    r0,[r3,2h]    ;读取精灵的Y坐标
0803015A 3008     add     r0,8h         ;加上8h
0803015C 4694     mov     r12,r2
0803015E 1C1A     mov     r2,r3
08030160 322C     add     r2,2Ch
08030162 4281     cmp     r1,r0         ;大于等于
08030164 DA1C     bge     @@GoTo
08030166 4803     ldr     r0,=0FEFFh    ;否则的话去掉100
08030168 4020     and     r0,r4
0803016A E015     b       @@Peer2
.pool

@@No100:
08030178 4A12     ldr     r2,=3001588h
0803017A 1C10     mov     r0,r2
0803017C 3070     add     r0,70h
0803017E 2700     mov     r7,0h
08030180 5FC1     ldsh    r1,[r0,r7]    ;samus顶部分界
08030182 8AB0     ldrh    r0,[r6,14h]   ;Y坐标
08030184 1809     add     r1,r1,r0
08030186 8858     ldrh    r0,[r3,2h]
08030188 3808     sub     r0,8h
0803018A 4694     mov     r12,r2
0803018C 1C1A     mov     r2,r3
0803018E 322C     add     r2,2Ch
08030190 4281     cmp     r1,r0
08030192 DD05     ble     @@GoTo
08030194 1C28     mov     r0,r5
08030196 4320     orr     r0,r4

@@Peer2:
08030198 8018     strh    r0,[r3]
0803019A 480B     ldr     r0,=300083Ch
0803019C 7800     ldrb    r0,[r0]     ;读取随机值
0803019E 7010     strb    r0,[r2]     ;写入偏移2Ch

@@GoTo:
080301A0 881C     ldrh    r4,[r3]
080301A2 2040     mov     r0,40h
080301A4 4020     and     r0,r4
080301A6 2800     cmp     r0,0h
080301A8 D012     beq     80301D0h
080301AA 4660     mov     r0,r12
080301AC 3072     add     r0,72h
080301AE 2500     mov     r5,0h
080301B0 5F41     ldsh    r1,[r0,r5]
080301B2 8A77     ldrh    r7,[r6,12h]
080301B4 19C9     add     r1,r1,r7
080301B6 8898     ldrh    r0,[r3,4h]
080301B8 3008     add     r0,8h
080301BA 4281     cmp     r1,r0
080301BC DA18     bge     80301F0h
080301BE 4803     ldr     r0,=0FFBFh
080301C0 4020     and     r0,r4
080301C2 E011     b       80301E8h
080301C4 1588     asr     r0,r1,16h
080301C6 0300     lsl     r0,r0,0Ch
080301C8 083C     lsr     r4,r7,20h
080301CA 0300     lsl     r0,r0,0Ch
080301CC FFBF0000 ????
080301CE 0000     lsl     r0,r0,0h
080301D0 4660     mov     r0,r12
080301D2 306E     add     r0,6Eh
080301D4 2500     mov     r5,0h
080301D6 5F41     ldsh    r1,[r0,r5]
080301D8 8A77     ldrh    r7,[r6,12h]
080301DA 19C9     add     r1,r1,r7
080301DC 8898     ldrh    r0,[r3,4h]
080301DE 3808     sub     r0,8h
080301E0 4281     cmp     r1,r0
080301E2 DD05     ble     80301F0h
080301E4 2040     mov     r0,40h
080301E6 4320     orr     r0,r4
080301E8 8018     strh    r0,[r3]
080301EA 480A     ldr     r0,=300083Ch
080301EC 7800     ldrb    r0,[r0]
080301EE 7010     strb    r0,[r2]
080301F0 7810     ldrb    r0,[r2]
080301F2 2800     cmp     r0,0h
080301F4 D132     bne     803025Ch
080301F6 8819     ldrh    r1,[r3]
080301F8 2080     mov     r0,80h
080301FA 0040     lsl     r0,r0,1h
080301FC 4008     and     r0,r1
080301FE 1C0C     mov     r4,r1
08030200 2800     cmp     r0,0h
08030202 D009     beq     8030218h
08030204 4803     ldr     r0,=300083Ch
08030206 7801     ldrb    r1,[r0]
08030208 1C02     mov     r2,r0
0803020A 2900     cmp     r1,0h
0803020C D00C     beq     8030228h
0803020E 88D8     ldrh    r0,[r3,6h]
08030210 3001     add     r0,1h
08030212 E008     b       8030226h
08030214 083C     lsr     r4,r7,20h
08030216 0300     lsl     r0,r0,0Ch
08030218 480A     ldr     r0,=300083Ch
0803021A 7801     ldrb    r1,[r0]
0803021C 1C02     mov     r2,r0
0803021E 2900     cmp     r1,0h
08030220 D002     beq     8030228h
08030222 88D8     ldrh    r0,[r3,6h]
08030224 3801     sub     r0,1h
08030226 80D8     strh    r0,[r3,6h]
08030228 2040     mov     r0,40h
0803022A 4020     and     r0,r4
0803022C 2800     cmp     r0,0h
0803022E D00B     beq     8030248h
08030230 1C19     mov     r1,r3
08030232 3123     add     r1,23h
08030234 7810     ldrb    r0,[r2]
08030236 7809     ldrb    r1,[r1]
08030238 4288     cmp     r0,r1
0803023A D011     beq     8030260h
0803023C 8918     ldrh    r0,[r3,8h]
0803023E 3001     add     r0,1h
08030240 8118     strh    r0,[r3,8h]
08030242 E00D     b       8030260h
08030244 083C     lsr     r4,r7,20h
08030246 0300     lsl     r0,r0,0Ch
08030248 1C19     mov     r1,r3
0803024A 3123     add     r1,23h
0803024C 7810     ldrb    r0,[r2]
0803024E 7809     ldrb    r1,[r1]
08030250 4288     cmp     r0,r1
08030252 D005     beq     8030260h
08030254 8918     ldrh    r0,[r3,8h]
08030256 3801     sub     r0,1h
08030258 8118     strh    r0,[r3,8h]
0803025A E001     b       8030260h
0803025C 3801     sub     r0,1h
0803025E 7010     strb    r0,[r2]
08030260 4660     mov     r0,r12
08030262 3070     add     r0,70h
08030264 8801     ldrh    r1,[r0]
08030266 8AB0     ldrh    r0,[r6,14h]
08030268 1809     add     r1,r1,r0
0803026A 0409     lsl     r1,r1,10h
0803026C 4660     mov     r0,r12
0803026E 306E     add     r0,6Eh
08030270 8800     ldrh    r0,[r0]
08030272 8A76     ldrh    r6,[r6,12h]
08030274 1980     add     r0,r0,r6
08030276 0400     lsl     r0,r0,10h
08030278 0C09     lsr     r1,r1,10h
0803027A 88DA     ldrh    r2,[r3,6h]
0803027C 1889     add     r1,r1,r2
0803027E 8059     strh    r1,[r3,2h]
08030280 0C00     lsr     r0,r0,10h
08030282 891D     ldrh    r5,[r3,8h]
08030284 1940     add     r0,r0,r5
08030286 8098     strh    r0,[r3,4h]

@@end:
08030288 BCF0     pop     r4-r7
0803028A BC01     pop     r0
0803028C 4700     bx      r0
.pool

;pose44
08030290 1C03     mov     r3,r0
08030292 1C19     mov     r1,r3
08030294 3124     add     r1,24h
08030296 2200     mov     r2,0h
08030298 2045     mov     r0,45h
0803029A 7008     strb    r0,[r1]
0803029C 4806     ldr     r0,=82E8528h
0803029E 6198     str     r0,[r3,18h]
080302A0 2000     mov     r0,0h
080302A2 82DA     strh    r2,[r3,16h]
080302A4 7718     strb    r0,[r3,1Ch]
080302A6 310B     add     r1,0Bh
080302A8 2008     mov     r0,8h
080302AA 7008     strb    r0,[r1]
080302AC 8819     ldrh    r1,[r3]
080302AE 4803     ldr     r0,=0FEFFh
080302B0 4008     and     r0,r1
080302B2 8018     strh    r0,[r3]
080302B4 4770     bx      r14

080302C0 B5F0     push    r4-r7,lr
080302C2 4647     mov     r7,r8
080302C4 B480     push    r7
080302C6 1C04     mov     r4,r0
080302C8 1C22     mov     r2,r4
080302CA 322F     add     r2,2Fh
080302CC 7810     ldrb    r0,[r2]
080302CE 1C01     mov     r1,r0
080302D0 31FF     add     r1,0FFh
080302D2 7011     strb    r1,[r2]
080302D4 0600     lsl     r0,r0,18h
080302D6 0E01     lsr     r1,r0,18h
080302D8 2900     cmp     r1,0h
080302DA D003     beq     80302E4h
080302DC 8860     ldrh    r0,[r4,2h]
080302DE 1A40     sub     r0,r0,r1
080302E0 8060     strh    r0,[r4,2h]
080302E2 E004     b       80302EEh
080302E4 7011     strb    r1,[r2]
080302E6 1C21     mov     r1,r4
080302E8 3124     add     r1,24h
080302EA 2047     mov     r0,47h
080302EC 7008     strb    r0,[r1]
080302EE 8865     ldrh    r5,[r4,2h]
080302F0 46A8     mov     r8,r5
080302F2 88A6     ldrh    r6,[r4,4h]
080302F4 1C37     mov     r7,r6
080302F6 1C28     mov     r0,r5
080302F8 3814     sub     r0,14h
080302FA 1C31     mov     r1,r6
080302FC F7DFFA10 bl      800F720h
08030300 2811     cmp     r0,11h
08030302 D103     bne     803030Ch
08030304 480B     ldr     r0,=0FFC0h
08030306 4028     and     r0,r5
08030308 3050     add     r0,50h
0803030A 8060     strh    r0,[r4,2h]
0803030C 8821     ldrh    r1,[r4]
0803030E 2040     mov     r0,40h
08030310 4008     and     r0,r1
08030312 2800     cmp     r0,0h
08030314 D010     beq     8030338h
08030316 1C31     mov     r1,r6
08030318 3110     add     r1,10h
0803031A 1C28     mov     r0,r5
0803031C F7DFFA00 bl      800F720h
08030320 21F0     mov     r1,0F0h
08030322 4001     and     r1,r0
08030324 2900     cmp     r1,0h
08030326 D116     bne     8030356h
08030328 1C21     mov     r1,r4
0803032A 312E     add     r1,2Eh
0803032C 88A0     ldrh    r0,[r4,4h]
0803032E 7809     ldrb    r1,[r1]
08030330 1840     add     r0,r0,r1
08030332 E00F     b       8030354h
08030334 FFC00000 ????
08030336 0000     lsl     r0,r0,0h
08030338 1C39     mov     r1,r7
0803033A 3910     sub     r1,10h
0803033C 4640     mov     r0,r8
0803033E F7DFF9EF bl      800F720h
08030342 21F0     mov     r1,0F0h
08030344 4001     and     r1,r0
08030346 2900     cmp     r1,0h
08030348 D105     bne     8030356h
0803034A 1C20     mov     r0,r4
0803034C 302E     add     r0,2Eh
0803034E 7801     ldrb    r1,[r0]
08030350 88A0     ldrh    r0,[r4,4h]
08030352 1A40     sub     r0,r0,r1
08030354 80A0     strh    r0,[r4,4h]
08030356 BC08     pop     r3
08030358 4698     mov     r8,r3
0803035A BCF0     pop     r4-r7
0803035C BC01     pop     r0
0803035E 4700     bx      r0
08030360 B5F0     push    r4-r7,lr
08030362 464F     mov     r7,r9
08030364 4646     mov     r6,r8
08030366 B4C0     push    r6,r7
08030368 1C04     mov     r4,r0
0803036A 1C22     mov     r2,r4
0803036C 322F     add     r2,2Fh
0803036E 7810     ldrb    r0,[r2]
08030370 1C01     mov     r1,r0
08030372 31FF     add     r1,0FFh
08030374 7011     strb    r1,[r2]
08030376 0600     lsl     r0,r0,18h
08030378 0E01     lsr     r1,r0,18h
0803037A 2900     cmp     r1,0h
0803037C D003     beq     8030386h
0803037E 8860     ldrh    r0,[r4,2h]
08030380 1A40     sub     r0,r0,r1
08030382 8060     strh    r0,[r4,2h]
08030384 E004     b       8030390h
08030386 7011     strb    r1,[r2]
08030388 1C21     mov     r1,r4
0803038A 3124     add     r1,24h
0803038C 2047     mov     r0,47h
0803038E 7008     strb    r0,[r1]
08030390 8865     ldrh    r5,[r4,2h]
08030392 46A9     mov     r9,r5
08030394 88A6     ldrh    r6,[r4,4h]
08030396 46B0     mov     r8,r6
08030398 1C28     mov     r0,r5
0803039A 3814     sub     r0,14h
0803039C 1C31     mov     r1,r6
0803039E F027FD6D bl      8057E7Ch
080303A2 2780     mov     r7,80h
080303A4 047F     lsl     r7,r7,11h
080303A6 4038     and     r0,r7
080303A8 2800     cmp     r0,0h
080303AA D003     beq     80303B4h
080303AC 480B     ldr     r0,=0FFC0h
080303AE 4028     and     r0,r5
080303B0 3050     add     r0,50h
080303B2 8060     strh    r0,[r4,2h]
080303B4 8821     ldrh    r1,[r4]
080303B6 2040     mov     r0,40h
080303B8 4008     and     r0,r1
080303BA 2800     cmp     r0,0h
080303BC D010     beq     80303E0h
080303BE 1C31     mov     r1,r6
080303C0 3110     add     r1,10h
080303C2 1C28     mov     r0,r5
080303C4 F027FD5A bl      8057E7Ch
080303C8 4038     and     r0,r7
080303CA 2800     cmp     r0,0h
080303CC D116     bne     80303FCh
080303CE 1C21     mov     r1,r4
080303D0 312E     add     r1,2Eh
080303D2 88A0     ldrh    r0,[r4,4h]
080303D4 7809     ldrb    r1,[r1]
080303D6 1840     add     r0,r0,r1
080303D8 E00F     b       80303FAh
080303DA 0000     lsl     r0,r0,0h
080303DC FFC00000 ????
080303DE 0000     lsl     r0,r0,0h
080303E0 4641     mov     r1,r8
080303E2 3910     sub     r1,10h
080303E4 4648     mov     r0,r9
080303E6 F027FD49 bl      8057E7Ch
080303EA 4038     and     r0,r7
080303EC 2800     cmp     r0,0h
080303EE D105     bne     80303FCh
080303F0 1C20     mov     r0,r4
080303F2 302E     add     r0,2Eh
080303F4 7801     ldrb    r1,[r0]
080303F6 88A0     ldrh    r0,[r4,4h]
080303F8 1A40     sub     r0,r0,r1
080303FA 80A0     strh    r0,[r4,4h]
080303FC BC18     pop     r3,r4
080303FE 4698     mov     r8,r3
08030400 46A1     mov     r9,r4
08030402 BCF0     pop     r4-r7
08030404 BC01     pop     r0
08030406 4700     bx      r0
08030408 B5F0     push    r4-r7,lr
0803040A 464F     mov     r7,r9
0803040C 4646     mov     r6,r8
0803040E B4C0     push    r6,r7
08030410 1C04     mov     r4,r0
08030412 8860     ldrh    r0,[r4,2h]
08030414 4681     mov     r9,r0
08030416 1C21     mov     r1,r4
08030418 312F     add     r1,2Fh
0803041A 7808     ldrb    r0,[r1]
0803041C 1C02     mov     r2,r0
0803041E 2813     cmp     r0,13h
08030420 DC01     bgt     8030426h
08030422 3002     add     r0,2h
08030424 7008     strb    r0,[r1]
08030426 8860     ldrh    r0,[r4,2h]
08030428 1880     add     r0,r0,r2
0803042A 2100     mov     r1,0h
0803042C 4688     mov     r8,r1
0803042E 2700     mov     r7,0h
08030430 8060     strh    r0,[r4,2h]
08030432 8865     ldrh    r5,[r4,2h]
08030434 88A6     ldrh    r6,[r4,4h]
08030436 1C28     mov     r0,r5
08030438 1C31     mov     r1,r6
0803043A F7DFF81F bl      800F47Ch
0803043E 1C02     mov     r2,r0
08030440 4806     ldr     r0,=30007F0h
08030442 7800     ldrb    r0,[r0]
08030444 2800     cmp     r0,0h
08030446 D023     beq     8030490h
08030448 4905     ldr     r1,=300083Ch
0803044A 7808     ldrb    r0,[r1]
0803044C 2808     cmp     r0,8h
0803044E D90B     bls     8030468h
08030450 4804     ldr     r0,=82E8378h
08030452 61A0     str     r0,[r4,18h]
08030454 82E7     strh    r7,[r4,16h]
08030456 4640     mov     r0,r8
08030458 7720     strb    r0,[r4,1Ch]
0803045A E010     b       803047Eh
0803045C 07F0     lsl     r0,r6,1Fh
0803045E 0300     lsl     r0,r0,0Ch
08030460 083C     lsr     r4,r7,20h
08030462 0300     lsl     r0,r0,0Ch
08030464 8378     strh    r0,[r7,1Ah]
08030466 082E     lsr     r6,r5,20h
08030468 4808     ldr     r0,=82E8398h
0803046A 61A0     str     r0,[r4,18h]
0803046C 82E7     strh    r7,[r4,16h]
0803046E 4640     mov     r0,r8
08030470 7720     strb    r0,[r4,1Ch]
08030472 7808     ldrb    r0,[r1]
08030474 0040     lsl     r0,r0,1h
08030476 3020     add     r0,20h
08030478 1C21     mov     r1,r4
0803047A 312C     add     r1,2Ch
0803047C 7008     strb    r0,[r1]
0803047E 1C21     mov     r1,r4
08030480 3124     add     r1,24h
08030482 200F     mov     r0,0Fh
08030484 7008     strb    r0,[r1]
08030486 8062     strh    r2,[r4,2h]
08030488 E02B     b       80304E2h
0803048A 0000     lsl     r0,r0,0h
0803048C 8398     strh    r0,[r3,1Ch]
0803048E 082E     lsr     r6,r5,20h
08030490 8821     ldrh    r1,[r4]
08030492 2040     mov     r0,40h
08030494 4008     and     r0,r1
08030496 2800     cmp     r0,0h
08030498 D00E     beq     80304B8h
0803049A 1C31     mov     r1,r6
0803049C 3110     add     r1,10h
0803049E 1C28     mov     r0,r5
080304A0 F7DFF93E bl      800F720h
080304A4 21F0     mov     r1,0F0h
080304A6 4001     and     r1,r0
080304A8 2900     cmp     r1,0h
080304AA D114     bne     80304D6h
080304AC 1C21     mov     r1,r4
080304AE 312E     add     r1,2Eh
080304B0 88A0     ldrh    r0,[r4,4h]
080304B2 7809     ldrb    r1,[r1]
080304B4 1840     add     r0,r0,r1
080304B6 E00D     b       80304D4h
080304B8 1C31     mov     r1,r6
080304BA 3910     sub     r1,10h
080304BC 1C28     mov     r0,r5
080304BE F7DFF92F bl      800F720h
080304C2 21F0     mov     r1,0F0h
080304C4 4001     and     r1,r0
080304C6 2900     cmp     r1,0h
080304C8 D105     bne     80304D6h
080304CA 1C20     mov     r0,r4
080304CC 302E     add     r0,2Eh
080304CE 7801     ldrb    r1,[r0]
080304D0 88A0     ldrh    r0,[r4,4h]
080304D2 1A40     sub     r0,r0,r1
080304D4 80A0     strh    r0,[r4,4h]
080304D6 4648     mov     r0,r9
080304D8 1C29     mov     r1,r5
080304DA 1C32     mov     r2,r6
080304DC 2301     mov     r3,1h
080304DE F7E1F91B bl      8011718h
080304E2 BC18     pop     r3,r4
080304E4 4698     mov     r8,r3
080304E6 46A1     mov     r9,r4
080304E8 BCF0     pop     r4-r7
080304EA BC01     pop     r0
080304EC 4700     bx      r0
080304EE 0000     lsl     r0,r0,0h
080304F0 B5F0     push    r4-r7,lr
080304F2 4647     mov     r7,r8
080304F4 B480     push    r7
080304F6 1C04     mov     r4,r0
080304F8 1C21     mov     r1,r4
080304FA 312F     add     r1,2Fh
080304FC 7808     ldrb    r0,[r1]
080304FE 1C02     mov     r2,r0
08030500 2813     cmp     r0,13h
08030502 DC01     bgt     8030508h
08030504 3002     add     r0,2h
08030506 7008     strb    r0,[r1]
08030508 8860     ldrh    r0,[r4,2h]
0803050A 1880     add     r0,r0,r2
0803050C 2100     mov     r1,0h
0803050E 4688     mov     r8,r1
08030510 2700     mov     r7,0h
08030512 8060     strh    r0,[r4,2h]
08030514 8865     ldrh    r5,[r4,2h]
08030516 88A6     ldrh    r6,[r4,4h]
08030518 1C28     mov     r0,r5
0803051A 1C31     mov     r1,r6
0803051C F027FCAE bl      8057E7Ch
08030520 2180     mov     r1,80h
08030522 0449     lsl     r1,r1,11h
08030524 4001     and     r1,r0
08030526 2900     cmp     r1,0h
08030528 D026     beq     8030578h
0803052A 4809     ldr     r0,=0FFC0h
0803052C 4028     and     r0,r5
0803052E 4285     cmp     r5,r0
08030530 D322     bcc     8030578h
08030532 8060     strh    r0,[r4,2h]
08030534 1C20     mov     r0,r4
08030536 3024     add     r0,24h
08030538 210F     mov     r1,0Fh
0803053A 7001     strb    r1,[r0]
0803053C 4905     ldr     r1,=300083Ch
0803053E 7808     ldrb    r0,[r1]
08030540 2808     cmp     r0,8h
08030542 D90B     bls     803055Ch
08030544 4804     ldr     r0,=82E8378h
08030546 61A0     str     r0,[r4,18h]
08030548 82E7     strh    r7,[r4,16h]
0803054A 4640     mov     r0,r8
0803054C 7720     strb    r0,[r4,1Ch]
0803054E E038     b       80305C2h
08030550 FFC00000 ????
08030552 0000     lsl     r0,r0,0h
08030554 083C     lsr     r4,r7,20h
08030556 0300     lsl     r0,r0,0Ch
08030558 8378     strh    r0,[r7,1Ah]
0803055A 082E     lsr     r6,r5,20h
0803055C 4805     ldr     r0,=82E8398h
0803055E 61A0     str     r0,[r4,18h]
08030560 82E7     strh    r7,[r4,16h]
08030562 4640     mov     r0,r8
08030564 7720     strb    r0,[r4,1Ch]
08030566 7808     ldrb    r0,[r1]
08030568 0040     lsl     r0,r0,1h
0803056A 3020     add     r0,20h
0803056C 1C21     mov     r1,r4
0803056E 312C     add     r1,2Ch
08030570 7008     strb    r0,[r1]
08030572 E026     b       80305C2h
08030574 8398     strh    r0,[r3,1Ch]
08030576 082E     lsr     r6,r5,20h
08030578 8821     ldrh    r1,[r4]
0803057A 2040     mov     r0,40h
0803057C 4008     and     r0,r1
0803057E 2800     cmp     r0,0h
08030580 D00F     beq     80305A2h
08030582 1C31     mov     r1,r6
08030584 3110     add     r1,10h
08030586 1C28     mov     r0,r5
08030588 F027FC78 bl      8057E7Ch
0803058C 2180     mov     r1,80h
0803058E 0449     lsl     r1,r1,11h
08030590 4001     and     r1,r0
08030592 2900     cmp     r1,0h
08030594 D115     bne     80305C2h
08030596 1C21     mov     r1,r4
08030598 312E     add     r1,2Eh
0803059A 88A0     ldrh    r0,[r4,4h]
0803059C 7809     ldrb    r1,[r1]
0803059E 1840     add     r0,r0,r1
080305A0 E00E     b       80305C0h
080305A2 1C31     mov     r1,r6
080305A4 3910     sub     r1,10h
080305A6 1C28     mov     r0,r5
080305A8 F027FC68 bl      8057E7Ch
080305AC 2180     mov     r1,80h
080305AE 0449     lsl     r1,r1,11h
080305B0 4001     and     r1,r0
080305B2 2900     cmp     r1,0h
080305B4 D105     bne     80305C2h
080305B6 1C20     mov     r0,r4
080305B8 302E     add     r0,2Eh
080305BA 7801     ldrb    r1,[r0]
080305BC 88A0     ldrh    r0,[r4,4h]
080305BE 1A40     sub     r0,r0,r1
080305C0 80A0     strh    r0,[r4,4h]
080305C2 BC08     pop     r3
080305C4 4698     mov     r8,r3
080305C6 BCF0     pop     r4-r7
080305C8 BC01     pop     r0
080305CA 4700     bx      r0
080305CC B5F0     push    r4-r7,lr
080305CE 4647     mov     r7,r8
080305D0 B480     push    r7
080305D2 1C04     mov     r4,r0
080305D4 8821     ldrh    r1,[r4]
080305D6 2080     mov     r0,80h
080305D8 0100     lsl     r0,r0,4h
080305DA 4008     and     r0,r1
080305DC 2800     cmp     r0,0h
080305DE D004     beq     80305EAh
080305E0 1C21     mov     r1,r4
080305E2 3124     add     r1,24h
080305E4 2042     mov     r0,42h
080305E6 7008     strb    r0,[r1]
080305E8 E047     b       803067Ah
080305EA 1C22     mov     r2,r4
080305EC 322F     add     r2,2Fh
080305EE 7810     ldrb    r0,[r2]
080305F0 1C01     mov     r1,r0
080305F2 31FF     add     r1,0FFh
080305F4 7011     strb    r1,[r2]
080305F6 0600     lsl     r0,r0,18h
080305F8 0E01     lsr     r1,r0,18h
080305FA 2900     cmp     r1,0h
080305FC D003     beq     8030606h
080305FE 8860     ldrh    r0,[r4,2h]
08030600 1A40     sub     r0,r0,r1
08030602 8060     strh    r0,[r4,2h]
08030604 E004     b       8030610h
08030606 7011     strb    r1,[r2]
08030608 1C21     mov     r1,r4
0803060A 3124     add     r1,24h
0803060C 204B     mov     r0,4Bh
0803060E 7008     strb    r0,[r1]
08030610 8865     ldrh    r5,[r4,2h]
08030612 46A8     mov     r8,r5
08030614 88A6     ldrh    r6,[r4,4h]
08030616 1C37     mov     r7,r6
08030618 1C28     mov     r0,r5
0803061A 3814     sub     r0,14h
0803061C 1C31     mov     r1,r6
0803061E F7DFF87F bl      800F720h
08030622 2811     cmp     r0,11h
08030624 D103     bne     803062Eh
08030626 480C     ldr     r0,=0FFC0h
08030628 4028     and     r0,r5
0803062A 3050     add     r0,50h
0803062C 8060     strh    r0,[r4,2h]
0803062E 8821     ldrh    r1,[r4]
08030630 2040     mov     r0,40h
08030632 4008     and     r0,r1
08030634 2800     cmp     r0,0h
08030636 D011     beq     803065Ch
08030638 1C31     mov     r1,r6
0803063A 3110     add     r1,10h
0803063C 1C28     mov     r0,r5
0803063E F7DFF86F bl      800F720h
08030642 21F0     mov     r1,0F0h
08030644 4001     and     r1,r0
08030646 2900     cmp     r1,0h
08030648 D117     bne     803067Ah
0803064A 1C21     mov     r1,r4
0803064C 312E     add     r1,2Eh
0803064E 88A0     ldrh    r0,[r4,4h]
08030650 7809     ldrb    r1,[r1]
08030652 1840     add     r0,r0,r1
08030654 E010     b       8030678h
08030656 0000     lsl     r0,r0,0h
08030658 FFC00000 ????
0803065A 0000     lsl     r0,r0,0h
0803065C 1C39     mov     r1,r7
0803065E 3910     sub     r1,10h
08030660 4640     mov     r0,r8
08030662 F7DFF85D bl      800F720h
08030666 21F0     mov     r1,0F0h
08030668 4001     and     r1,r0
0803066A 2900     cmp     r1,0h
0803066C D105     bne     803067Ah
0803066E 1C20     mov     r0,r4
08030670 302E     add     r0,2Eh
08030672 7801     ldrb    r1,[r0]
08030674 88A0     ldrh    r0,[r4,4h]
08030676 1A40     sub     r0,r0,r1
08030678 80A0     strh    r0,[r4,4h]
0803067A BC08     pop     r3
0803067C 4698     mov     r8,r3
0803067E BCF0     pop     r4-r7
08030680 BC01     pop     r0
08030682 4700     bx      r0
08030684 B5F0     push    r4-r7,lr
08030686 464F     mov     r7,r9
08030688 4646     mov     r6,r8
0803068A B4C0     push    r6,r7
0803068C 1C04     mov     r4,r0
0803068E 8821     ldrh    r1,[r4]
08030690 2080     mov     r0,80h
08030692 0100     lsl     r0,r0,4h
08030694 4008     and     r0,r1
08030696 2800     cmp     r0,0h
08030698 D004     beq     80306A4h
0803069A 1C21     mov     r1,r4
0803069C 3124     add     r1,24h
0803069E 2042     mov     r0,42h
080306A0 7008     strb    r0,[r1]
080306A2 E047     b       8030734h
080306A4 1C22     mov     r2,r4
080306A6 322F     add     r2,2Fh
080306A8 7810     ldrb    r0,[r2]
080306AA 1C01     mov     r1,r0
080306AC 31FF     add     r1,0FFh
080306AE 7011     strb    r1,[r2]
080306B0 0600     lsl     r0,r0,18h
080306B2 0E01     lsr     r1,r0,18h
080306B4 2900     cmp     r1,0h
080306B6 D003     beq     80306C0h
080306B8 8860     ldrh    r0,[r4,2h]
080306BA 1A40     sub     r0,r0,r1
080306BC 8060     strh    r0,[r4,2h]
080306BE E004     b       80306CAh
080306C0 7011     strb    r1,[r2]
080306C2 1C21     mov     r1,r4
080306C4 3124     add     r1,24h
080306C6 204B     mov     r0,4Bh
080306C8 7008     strb    r0,[r1]
080306CA 8865     ldrh    r5,[r4,2h]
080306CC 46A9     mov     r9,r5
080306CE 88A6     ldrh    r6,[r4,4h]
080306D0 46B0     mov     r8,r6
080306D2 1C28     mov     r0,r5
080306D4 3814     sub     r0,14h
080306D6 1C31     mov     r1,r6
080306D8 F027FBD0 bl      8057E7Ch
080306DC 2780     mov     r7,80h
080306DE 047F     lsl     r7,r7,11h
080306E0 4038     and     r0,r7
080306E2 2800     cmp     r0,0h
080306E4 D003     beq     80306EEh
080306E6 480B     ldr     r0,=0FFC0h
080306E8 4028     and     r0,r5
080306EA 3050     add     r0,50h
080306EC 8060     strh    r0,[r4,2h]
080306EE 8821     ldrh    r1,[r4]
080306F0 2040     mov     r0,40h
080306F2 4008     and     r0,r1
080306F4 2800     cmp     r0,0h
080306F6 D00F     beq     8030718h
080306F8 1C31     mov     r1,r6
080306FA 3110     add     r1,10h
080306FC 1C28     mov     r0,r5
080306FE F027FBBD bl      8057E7Ch
08030702 4038     and     r0,r7
08030704 2800     cmp     r0,0h
08030706 D115     bne     8030734h
08030708 1C21     mov     r1,r4
0803070A 312E     add     r1,2Eh
0803070C 88A0     ldrh    r0,[r4,4h]
0803070E 7809     ldrb    r1,[r1]
08030710 1840     add     r0,r0,r1
08030712 E00E     b       8030732h
08030714 FFC00000 ????
08030716 0000     lsl     r0,r0,0h
08030718 4641     mov     r1,r8
0803071A 3910     sub     r1,10h
0803071C 4648     mov     r0,r9
0803071E F027FBAD bl      8057E7Ch
08030722 4038     and     r0,r7
08030724 2800     cmp     r0,0h
08030726 D105     bne     8030734h
08030728 1C20     mov     r0,r4
0803072A 302E     add     r0,2Eh
0803072C 7801     ldrb    r1,[r0]
0803072E 88A0     ldrh    r0,[r4,4h]
08030730 1A40     sub     r0,r0,r1
08030732 80A0     strh    r0,[r4,4h]
08030734 BC18     pop     r3,r4
08030736 4698     mov     r8,r3
08030738 46A1     mov     r9,r4
0803073A BCF0     pop     r4-r7
0803073C BC01     pop     r0
0803073E 4700     bx      r0
08030740 B5F0     push    r4-r7,lr
08030742 4647     mov     r7,r8
08030744 B480     push    r7
08030746 1C04     mov     r4,r0
08030748 8860     ldrh    r0,[r4,2h]
0803074A 4680     mov     r8,r0
0803074C 8821     ldrh    r1,[r4]
0803074E 2080     mov     r0,80h
08030750 0100     lsl     r0,r0,4h
08030752 4008     and     r0,r1
08030754 0400     lsl     r0,r0,10h
08030756 0C07     lsr     r7,r0,10h
08030758 2F00     cmp     r7,0h
0803075A D004     beq     8030766h
0803075C 1C21     mov     r1,r4
0803075E 3124     add     r1,24h
08030760 2042     mov     r0,42h
08030762 7008     strb    r0,[r1]
08030764 E04D     b       8030802h
08030766 1C22     mov     r2,r4
08030768 322F     add     r2,2Fh
0803076A 7811     ldrb    r1,[r2]
0803076C 290F     cmp     r1,0Fh
0803076E DC01     bgt     8030774h
08030770 1C88     add     r0,r1,2
08030772 7010     strb    r0,[r2]
08030774 8860     ldrh    r0,[r4,2h]
08030776 1840     add     r0,r0,r1
08030778 8060     strh    r0,[r4,2h]
0803077A 8865     ldrh    r5,[r4,2h]
0803077C 88A6     ldrh    r6,[r4,4h]
0803077E 1C28     mov     r0,r5
08030780 1C31     mov     r1,r6
08030782 F7DEFE7B bl      800F47Ch
08030786 1C02     mov     r2,r0
08030788 4807     ldr     r0,=30007F0h
0803078A 7800     ldrb    r0,[r0]
0803078C 2800     cmp     r0,0h
0803078E D00F     beq     80307B0h
08030790 4806     ldr     r0,=82E8378h
08030792 61A0     str     r0,[r4,18h]
08030794 82E7     strh    r7,[r4,16h]
08030796 2000     mov     r0,0h
08030798 7720     strb    r0,[r4,1Ch]
0803079A 1C21     mov     r1,r4
0803079C 3124     add     r1,24h
0803079E 200F     mov     r0,0Fh
080307A0 7008     strb    r0,[r1]
080307A2 8062     strh    r2,[r4,2h]
080307A4 E02D     b       8030802h
080307A6 0000     lsl     r0,r0,0h
080307A8 07F0     lsl     r0,r6,1Fh
080307AA 0300     lsl     r0,r0,0Ch
080307AC 8378     strh    r0,[r7,1Ah]
080307AE 082E     lsr     r6,r5,20h
080307B0 8821     ldrh    r1,[r4]
080307B2 2040     mov     r0,40h
080307B4 4008     and     r0,r1
080307B6 2800     cmp     r0,0h
080307B8 D00E     beq     80307D8h
080307BA 1C31     mov     r1,r6
080307BC 3110     add     r1,10h
080307BE 1C28     mov     r0,r5
080307C0 F7DEFFAE bl      800F720h
080307C4 21F0     mov     r1,0F0h
080307C6 4001     and     r1,r0
080307C8 2900     cmp     r1,0h
080307CA D114     bne     80307F6h
080307CC 1C21     mov     r1,r4
080307CE 312E     add     r1,2Eh
080307D0 88A0     ldrh    r0,[r4,4h]
080307D2 7809     ldrb    r1,[r1]
080307D4 1840     add     r0,r0,r1
080307D6 E00D     b       80307F4h
080307D8 1C31     mov     r1,r6
080307DA 3910     sub     r1,10h
080307DC 1C28     mov     r0,r5
080307DE F7DEFF9F bl      800F720h
080307E2 21F0     mov     r1,0F0h
080307E4 4001     and     r1,r0
080307E6 2900     cmp     r1,0h
080307E8 D105     bne     80307F6h
080307EA 1C20     mov     r0,r4
080307EC 302E     add     r0,2Eh
080307EE 7801     ldrb    r1,[r0]
080307F0 88A0     ldrh    r0,[r4,4h]
080307F2 1A40     sub     r0,r0,r1
080307F4 80A0     strh    r0,[r4,4h]
080307F6 4640     mov     r0,r8
080307F8 1C29     mov     r1,r5
080307FA 1C32     mov     r2,r6
080307FC 2301     mov     r3,1h
080307FE F7E0FF8B bl      8011718h
08030802 BC08     pop     r3
08030804 4698     mov     r8,r3
08030806 BCF0     pop     r4-r7
08030808 BC01     pop     r0
0803080A 4700     bx      r0
0803080C B5F0     push    r4-r7,lr
0803080E 1C04     mov     r4,r0
08030810 8821     ldrh    r1,[r4]
08030812 2080     mov     r0,80h
08030814 0100     lsl     r0,r0,4h
08030816 4008     and     r0,r1
08030818 0400     lsl     r0,r0,10h
0803081A 0C07     lsr     r7,r0,10h
0803081C 2F00     cmp     r7,0h
0803081E D004     beq     803082Ah
08030820 1C21     mov     r1,r4
08030822 3124     add     r1,24h
08030824 2042     mov     r0,42h
08030826 7008     strb    r0,[r1]
08030828 E04D     b       80308C6h
0803082A 1C22     mov     r2,r4
0803082C 322F     add     r2,2Fh
0803082E 7811     ldrb    r1,[r2]
08030830 290F     cmp     r1,0Fh
08030832 DC01     bgt     8030838h
08030834 1C88     add     r0,r1,2
08030836 7010     strb    r0,[r2]
08030838 8860     ldrh    r0,[r4,2h]
0803083A 1840     add     r0,r0,r1
0803083C 8060     strh    r0,[r4,2h]
0803083E 8865     ldrh    r5,[r4,2h]
08030840 88A6     ldrh    r6,[r4,4h]
08030842 1C28     mov     r0,r5
08030844 1C31     mov     r1,r6
08030846 F027FB19 bl      8057E7Ch
0803084A 2180     mov     r1,80h
0803084C 0449     lsl     r1,r1,11h
0803084E 4001     and     r1,r0
08030850 2900     cmp     r1,0h
08030852 D013     beq     803087Ch
08030854 4A07     ldr     r2,=0FFC0h
08030856 402A     and     r2,r5
08030858 4295     cmp     r5,r2
0803085A DB0F     blt     803087Ch
0803085C 4806     ldr     r0,=82E8378h
0803085E 61A0     str     r0,[r4,18h]
08030860 82E7     strh    r7,[r4,16h]
08030862 2000     mov     r0,0h
08030864 7720     strb    r0,[r4,1Ch]
08030866 1C21     mov     r1,r4
08030868 3124     add     r1,24h
0803086A 200F     mov     r0,0Fh
0803086C 7008     strb    r0,[r1]
0803086E 8062     strh    r2,[r4,2h]
08030870 E029     b       80308C6h
08030872 0000     lsl     r0,r0,0h
08030874 FFC00000 ????
08030876 0000     lsl     r0,r0,0h
08030878 8378     strh    r0,[r7,1Ah]
0803087A 082E     lsr     r6,r5,20h
0803087C 8821     ldrh    r1,[r4]
0803087E 2040     mov     r0,40h
08030880 4008     and     r0,r1
08030882 2800     cmp     r0,0h
08030884 D00F     beq     80308A6h
08030886 1C31     mov     r1,r6
08030888 3110     add     r1,10h
0803088A 1C28     mov     r0,r5
0803088C F027FAF6 bl      8057E7Ch
08030890 2180     mov     r1,80h
08030892 0449     lsl     r1,r1,11h
08030894 4001     and     r1,r0
08030896 2900     cmp     r1,0h
08030898 D115     bne     80308C6h
0803089A 1C21     mov     r1,r4
0803089C 312E     add     r1,2Eh
0803089E 88A0     ldrh    r0,[r4,4h]
080308A0 7809     ldrb    r1,[r1]
080308A2 1840     add     r0,r0,r1
080308A4 E00E     b       80308C4h
080308A6 1C31     mov     r1,r6
080308A8 3910     sub     r1,10h
080308AA 1C28     mov     r0,r5
080308AC F027FAE6 bl      8057E7Ch
080308B0 2180     mov     r1,80h
080308B2 0449     lsl     r1,r1,11h
080308B4 4001     and     r1,r0
080308B6 2900     cmp     r1,0h
080308B8 D105     bne     80308C6h
080308BA 1C20     mov     r0,r4
080308BC 302E     add     r0,2Eh
080308BE 7801     ldrb    r1,[r0]
080308C0 88A0     ldrh    r0,[r4,4h]
080308C2 1A40     sub     r0,r0,r1
080308C4 80A0     strh    r0,[r4,4h]
080308C6 BCF0     pop     r4-r7
080308C8 BC01     pop     r0
080308CA 4700     bx      r0

;Pose 8  5E
080308CC B510     push    r4,lr
080308CE 1C03     mov     r3,r0
080308D0 1C19     mov     r1,r3
080308D2 3124     add     r1,24h
080308D4 2200     mov     r2,0h
080308D6 2009     mov     r0,9h
080308D8 7008     strb    r0,[r1]       ;pose写入9h
080308DA 480E     ldr     r0,=82E8318h
080308DC 6198     str     r0,[r3,18h]   ;再次写入基础的OAM
080308DE 2000     mov     r0,0h
080308E0 82DA     strh    r2,[r3,16h]
080308E2 7718     strb    r0,[r3,1Ch]
080308E4 4C0C     ldr     r4,=300083Ch  ;随机数
080308E6 7820     ldrb    r0,[r4]
080308E8 0840     lsr     r0,r0,1h      ;除以2
080308EA 2805     cmp     r0,5h
080308EC D800     bhi     @@Pass
080308EE 2006     mov     r0,6h

@@Pass:
080308F0 1C19     mov     r1,r3
080308F2 312E     add     r1,2Eh
080308F4 7008     strb    r0,[r1]       ;这随机数计算后的值给予偏移2Eh
080308F6 8898     ldrh    r0,[r3,4h]    ;读取x坐标
080308F8 0940     lsr     r0,r0,5h      ;得到X格数
080308FA 220F     mov     r2,0Fh
080308FC 210F     mov     r1,0Fh
080308FE 4008     and     r0,r1         ;只留末位
08030900 7824     ldrb    r4,[r4]       
08030902 1900     add     r0,r0,r4      ;读取随机数加上这个末位数
08030904 4010     and     r0,r2         ;再次只留末位数
08030906 1C19     mov     r1,r3
08030908 312C     add     r1,2Ch
0803090A 7008     strb    r0,[r1]       ;写入偏移2Ch
0803090C BC10     pop     r4
0803090E BC01     pop     r0
08030910 4700     bx      r0
.pool


0803091C B570     push    r4-r6,lr
0803091E 1C05     mov     r5,r0
08030920 8829     ldrh    r1,[r5]
08030922 2080     mov     r0,80h
08030924 0100     lsl     r0,r0,4h
08030926 4008     and     r0,r1
08030928 0400     lsl     r0,r0,10h
0803092A 0C06     lsr     r6,r0,10h
0803092C 2E00     cmp     r6,0h
0803092E D004     beq     803093Ah
08030930 1C29     mov     r1,r5
08030932 3124     add     r1,24h
08030934 2042     mov     r0,42h
08030936 7008     strb    r0,[r1]
08030938 E0B9     b       8030AAEh
0803093A F7DEFE2B bl      800F594h
0803093E 4804     ldr     r0,=30007F0h
08030940 7800     ldrb    r0,[r0]
08030942 2800     cmp     r0,0h
08030944 D106     bne     8030954h
08030946 1C29     mov     r1,r5
08030948 3124     add     r1,24h
0803094A 201E     mov     r0,1Eh
0803094C 7008     strb    r0,[r1]
0803094E E0AE     b       8030AAEh
08030950 07F0     lsl     r0,r6,1Fh
08030952 0300     lsl     r0,r0,0Ch
08030954 8868     ldrh    r0,[r5,2h]
08030956 3810     sub     r0,10h
08030958 88A9     ldrh    r1,[r5,4h]
0803095A F7DEFEE1 bl      800F720h
0803095E 2811     cmp     r0,11h
08030960 D104     bne     803096Ch
08030962 1C29     mov     r1,r5
08030964 3124     add     r1,24h
08030966 2062     mov     r0,62h
08030968 7008     strb    r0,[r1]
0803096A E0A0     b       8030AAEh
0803096C 1C2A     mov     r2,r5
0803096E 322C     add     r2,2Ch
08030970 7814     ldrb    r4,[r2]
08030972 480A     ldr     r0,=3000C77h
08030974 7800     ldrb    r0,[r0]
08030976 0901     lsr     r1,r0,4h
08030978 42A1     cmp     r1,r4
0803097A D115     bne     80309A8h
0803097C 4808     ldr     r0,=82E8350h
0803097E 61A8     str     r0,[r5,18h]
08030980 2000     mov     r0,0h
08030982 82EE     strh    r6,[r5,16h]
08030984 7728     strb    r0,[r5,1Ch]
08030986 4807     ldr     r0,=300083Ch
08030988 7801     ldrb    r1,[r0]
0803098A 0048     lsl     r0,r1,1h
0803098C 1840     add     r0,r0,r1
0803098E 7010     strb    r0,[r2]
08030990 1C29     mov     r1,r5
08030992 3124     add     r1,24h
08030994 200F     mov     r0,0Fh
08030996 7008     strb    r0,[r1]
08030998 E089     b       8030AAEh
0803099A 0000     lsl     r0,r0,0h
0803099C 0C77     lsr     r7,r6,11h
0803099E 0300     lsl     r0,r0,0Ch
080309A0 8350     strh    r0,[r2,1Ah]
080309A2 082E     lsr     r6,r5,20h
080309A4 083C     lsr     r4,r7,20h
080309A6 0300     lsl     r0,r0,0Ch
080309A8 1C60     add     r0,r4,1
080309AA 4281     cmp     r1,r0
080309AC D002     beq     80309B4h
080309AE 1E60     sub     r0,r4,1
080309B0 4281     cmp     r1,r0
080309B2 D135     bne     8030A20h
080309B4 1C29     mov     r1,r5
080309B6 3124     add     r1,24h
080309B8 2049     mov     r0,49h
080309BA 7008     strb    r0,[r1]
080309BC 4807     ldr     r0,=82E8480h
080309BE 61A8     str     r0,[r5,18h]
080309C0 2000     mov     r0,0h
080309C2 82EE     strh    r6,[r5,16h]
080309C4 7728     strb    r0,[r5,1Ch]
080309C6 4806     ldr     r0,=300083Ch
080309C8 7801     ldrb    r1,[r0]
080309CA 2903     cmp     r1,3h
080309CC D80A     bhi     80309E4h
080309CE 1C29     mov     r1,r5
080309D0 312F     add     r1,2Fh
080309D2 2004     mov     r0,4h
080309D4 7008     strb    r0,[r1]
080309D6 1C0A     mov     r2,r1
080309D8 E008     b       80309ECh
080309DA 0000     lsl     r0,r0,0h
080309DC 8480     strh    r0,[r0,24h]
080309DE 082E     lsr     r6,r5,20h
080309E0 083C     lsr     r4,r7,20h
080309E2 0300     lsl     r0,r0,0Ch
080309E4 1C28     mov     r0,r5
080309E6 302F     add     r0,2Fh
080309E8 7001     strb    r1,[r0]
080309EA 1C02     mov     r2,r0
080309EC 8829     ldrh    r1,[r5]
080309EE 2002     mov     r0,2h
080309F0 4008     and     r0,r1
080309F2 2800     cmp     r0,0h
080309F4 D05B     beq     8030AAEh
080309F6 7814     ldrb    r4,[r2]
080309F8 2C07     cmp     r4,7h
080309FA D804     bhi     8030A06h
080309FC 20BA     mov     r0,0BAh
080309FE 0040     lsl     r0,r0,1h
08030A00 F7D2F88E bl      8002B20h
08030A04 E053     b       8030AAEh
08030A06 2C0B     cmp     r4,0Bh
08030A08 D904     bls     8030A14h
08030A0A 20BB     mov     r0,0BBh
08030A0C 0040     lsl     r0,r0,1h
08030A0E F7D2F887 bl      8002B20h
08030A12 E04C     b       8030AAEh
08030A14 4801     ldr     r0,=175h
08030A16 F7D2F883 bl      8002B20h
08030A1A E048     b       8030AAEh
08030A1C 0175     lsl     r5,r6,5h
08030A1E 0000     lsl     r0,r0,0h
08030A20 4E07     ldr     r6,=3000734h
08030A22 7830     ldrb    r0,[r6]
08030A24 2800     cmp     r0,0h
08030A26 D10D     bne     8030A44h
08030A28 2060     mov     r0,60h
08030A2A 2148     mov     r1,48h
08030A2C F7DFF9D8 bl      800FDE0h
08030A30 2800     cmp     r0,0h
08030A32 D001     beq     8030A38h
08030A34 205A     mov     r0,5Ah
08030A36 7030     strb    r0,[r6]
08030A38 2001     mov     r0,1h
08030A3A 4004     and     r4,r0
08030A3C 3401     add     r4,1h
08030A3E E004     b       8030A4Ah
08030A40 0734     lsl     r4,r6,1Ch
08030A42 0300     lsl     r0,r0,0Ch
08030A44 1C28     mov     r0,r5
08030A46 302E     add     r0,2Eh
08030A48 7804     ldrb    r4,[r0]
08030A4A 8829     ldrh    r1,[r5]
08030A4C 2040     mov     r0,40h
08030A4E 4008     and     r0,r1
08030A50 2800     cmp     r0,0h
08030A52 D013     beq     8030A7Ch
08030A54 4808     ldr     r0,=30007F0h
08030A56 7801     ldrb    r1,[r0]
08030A58 20F0     mov     r0,0F0h
08030A5A 4008     and     r0,r1
08030A5C 2800     cmp     r0,0h
08030A5E D007     beq     8030A70h
08030A60 8868     ldrh    r0,[r5,2h]
08030A62 3810     sub     r0,10h
08030A64 88A9     ldrh    r1,[r5,4h]
08030A66 3110     add     r1,10h
08030A68 F7DEFE5A bl      800F720h
08030A6C 2811     cmp     r0,11h
08030A6E D013     beq     8030A98h
08030A70 88A8     ldrh    r0,[r5,4h]
08030A72 1820     add     r0,r4,r0
08030A74 E01A     b       8030AACh
08030A76 0000     lsl     r0,r0,0h
08030A78 07F0     lsl     r0,r6,1Fh
08030A7A 0300     lsl     r0,r0,0Ch
08030A7C 4809     ldr     r0,=30007F0h
08030A7E 7801     ldrb    r1,[r0]
08030A80 20F0     mov     r0,0F0h
08030A82 4008     and     r0,r1
08030A84 2800     cmp     r0,0h
08030A86 D00F     beq     8030AA8h
08030A88 8868     ldrh    r0,[r5,2h]
08030A8A 3810     sub     r0,10h
08030A8C 88A9     ldrh    r1,[r5,4h]
08030A8E 3910     sub     r1,10h
08030A90 F7DEFE46 bl      800F720h
08030A94 2811     cmp     r0,11h
08030A96 D107     bne     8030AA8h
08030A98 1C29     mov     r1,r5
08030A9A 3124     add     r1,24h
08030A9C 200A     mov     r0,0Ah
08030A9E 7008     strb    r0,[r1]
08030AA0 E005     b       8030AAEh
08030AA2 0000     lsl     r0,r0,0h
08030AA4 07F0     lsl     r0,r6,1Fh
08030AA6 0300     lsl     r0,r0,0Ch
08030AA8 88A8     ldrh    r0,[r5,4h]
08030AAA 1B00     sub     r0,r0,r4
08030AAC 80A8     strh    r0,[r5,4h]
08030AAE BC70     pop     r4-r6
08030AB0 BC01     pop     r0
08030AB2 4700     bx      r0

;pose 9 5E
08030AB4 B570     push    r4-r6,lr
08030AB6 1C04     mov     r4,r0
08030AB8 8821     ldrh    r1,[r4]
08030ABA 2080     mov     r0,80h
08030ABC 0100     lsl     r0,r0,4h
08030ABE 4008     and     r0,r1        ;取向 and 800
08030AC0 2800     cmp     r0,0h
08030AC2 D004     beq     @@NoTouch
08030AC4 1C21     mov     r1,r4
08030AC6 3124     add     r1,24h
08030AC8 2042     mov     r0,42h
08030ACA 7008     strb    r0,[r1]      ;如果被粘附则pose写入42h
08030ACC E0C1     b       @@end

@@NoTouch:
08030ACE 1C20     mov     r0,r4
08030AD0 3023     add     r0,23h       ;主精灵序号读取
08030AD2 7801     ldrb    r1,[r0]
08030AD4 2201     mov     r2,1h
08030AD6 1C10     mov     r0,r2
08030AD8 4008     and     r0,r1
08030ADA 2800     cmp     r0,0h        ;检查是否是奇数
08030ADC D008     beq     @@NoOdd
08030ADE 4803     ldr     r0,=3000C77h ;8bit循环数
08030AE0 7801     ldrb    r1,[r0]
08030AE2 1C10     mov     r0,r2
08030AE4 4008     and     r0,r1        ;检查是否是奇数
08030AE6 2800     cmp     r0,0h
08030AE8 D01A     beq     @@Peer
08030AEA E007     b       @@Odd
.pool

@@NoOdd:
08030AF0 480A     ldr     r0,=3000C77h
08030AF2 7801     ldrb    r1,[r0]
08030AF4 1C10     mov     r0,r2
08030AF6 4008     and     r0,r1
08030AF8 2800     cmp     r0,0h
08030AFA D111     bne     @@Peer

@@Odd:
08030AFC 8860     ldrh    r0,[r4,2h]
08030AFE 88A1     ldrh    r1,[r4,4h]
08030B00 F027F9BC bl      8057E7Ch      ;砖块相关 检查身下是否有砖?
08030B04 1C01     mov     r1,r0
08030B06 2080     mov     r0,80h
08030B08 0440     lsl     r0,r0,11h     ;100 0000
08030B0A 4008     and     r0,r1         ;和返回的数and
08030B0C 2800     cmp     r0,0h
08030B0E D107     bne     @@Peer
08030B10 1C21     mov     r1,r4
08030B12 3124     add     r1,24h
08030B14 201E     mov     r0,1Eh
08030B16 7008     strb    r0,[r1]       ;pose写入1Eh
08030B18 E09B     b       @@end
.pool

@@Peer:
08030B20 1C22     mov     r2,r4
08030B22 322C     add     r2,2Ch
08030B24 7815     ldrb    r5,[r2]       ;读取随机数设定的值
08030B26 480B     ldr     r0,=3000C77h
08030B28 7800     ldrb    r0,[r0]       ;读取循环数
08030B2A 0900     lsr     r0,r0,4h      ;除以8h
08030B2C 1C01     mov     r1,r0
08030B2E 42A9     cmp     r1,r5         ;和随机数设定的值相比
08030B30 D116     bne     @@NoF
08030B32 4809     ldr     r0,=82E8350h
08030B34 61A0     str     r0,[r4,18h]   ;写入新的OAM
08030B36 2100     mov     r1,0h
08030B38 2000     mov     r0,0h
08030B3A 82E0     strh    r0,[r4,16h]
08030B3C 7721     strb    r1,[r4,1Ch]
08030B3E 4807     ldr     r0,=300083Ch
08030B40 7801     ldrb    r1,[r0]
08030B42 0048     lsl     r0,r1,1h
08030B44 1840     add     r0,r0,r1
08030B46 7010     strb    r0,[r2]       ;2C重新写入新的随机数
08030B48 1C21     mov     r1,r4
08030B4A 3124     add     r1,24h
08030B4C 200F     mov     r0,0Fh
08030B4E 7008     strb    r0,[r1]       ;pose写入F
08030B50 E07F     b       @@end
.pool

@@NoF:
08030B60 1C68     add     r0,r5,1
08030B62 4281     cmp     r1,r0         
08030B64 D002     beq     @@Is49
08030B66 1E68     sub     r0,r5,1
08030B68 4281     cmp     r1,r0
08030B6A D135     bne     @@ContinueCheck

@@Is49:
08030B6C 1C21     mov     r1,r4
08030B6E 3124     add     r1,24h
08030B70 2200     mov     r2,0h
08030B72 2049     mov     r0,49h       ;pose写入49h
08030B74 7008     strb    r0,[r1]
08030B76 4807     ldr     r0,=82E8480h ;写入新的OAM
08030B78 61A0     str     r0,[r4,18h]  
08030B7A 2000     mov     r0,0h
08030B7C 82E2     strh    r2,[r4,16h]
08030B7E 7720     strb    r0,[r4,1Ch]
08030B80 4805     ldr     r0,=300083Ch
08030B82 7801     ldrb    r1,[r0]
08030B84 2903     cmp     r1,3h        ;随机数是否大于3
08030B86 D809     bhi     @@RNGMoreThree
08030B88 1C21     mov     r1,r4
08030B8A 312F     add     r1,2Fh
08030B8C 2004     mov     r0,4h
08030B8E 7008     strb    r0,[r1]      ;偏移2F写入4
08030B90 1C0A     mov     r2,r1
08030B92 E007     b       @@Peer2
.pool

@@RNGMoreThree:
08030B9C 1C20     mov     r0,r4
08030B9E 302F     add     r0,2Fh
08030BA0 7001     strb    r1,[r0]      ;偏移2F写入随机数小于3的值
08030BA2 1C02     mov     r2,r0

@@Peer2:
08030BA4 8821     ldrh    r1,[r4]
08030BA6 2002     mov     r0,2h
08030BA8 4008     and     r0,r1
08030BAA 2800     cmp     r0,0h        ;检查是否在屏幕内
08030BAC D051     beq     @@end
08030BAE 7815     ldrb    r5,[r2]      ;2F的值
08030BB0 2D07     cmp     r5,7h
08030BB2 D804     bhi     @@ContinueCheck2
08030BB4 20BA     mov     r0,0BAh
08030BB6 0040     lsl     r0,r0,1h
08030BB8 F7D1FFB2 bl      8002B20h     ;播放声音
08030BBC E049     b       @@end

@@ContinueCheck2:
08030BBE 2D0B     cmp     r5,0Bh
08030BC0 D904     bls     @@ContinueCheck3
08030BC2 20BB     mov     r0,0BBh
08030BC4 0040     lsl     r0,r0,1h
08030BC6 F7D1FFAB bl      8002B20h     ;播放声音
08030BCA E042     b       @@end

@@ContinueCheck3:
08030BCC 4801     ldr     r0,=175h
08030BCE F7D1FFA7 bl      8002B20h
08030BD2 E03E     b       @@end

@@ContinueCheck:
08030BD8 4E07     ldr     r6,=3000734h
08030BDA 7830     ldrb    r0,[r6]      ;读取循环数
08030BDC 2800     cmp     r0,0h
08030BDE D10D     bne     @@NoZero
08030BE0 2060     mov     r0,60h
08030BE2 2148     mov     r1,48h
08030BE4 F7DFF8FC bl      800FDE0h     ;检查范围和方位
08030BE8 2800     cmp     r0,0h
08030BEA D001     beq     @@NoIn
08030BEC 205A     mov     r0,5Ah
08030BEE 7030     strb    r0,[r6]      ;不在范围则循环数写入5A

@@NoIn:
08030BF0 2001     mov     r0,1h
08030BF2 4005     and     r5,r0
08030BF4 3501     add     r5,1h
08030BF6 E004     b       @@Peer3
.pool

@@NoZero:
08030BFC 1C20     mov     r0,r4
08030BFE 302E     add     r0,2Eh
08030C00 7805     ldrb    r5,[r0]      ;偏移2E写入新数

@@Peer3:
08030C02 8821     ldrh    r1,[r4]
08030C04 2040     mov     r0,40h
08030C06 4008     and     r0,r1
08030C08 2800     cmp     r0,0h
08030C0A D00E     beq     @@Left
08030C0C 8860     ldrh    r0,[r4,2h]
08030C0E 3810     sub     r0,10h       ;Y坐标向上10h
08030C10 88A1     ldrh    r1,[r4,4h]   ;X坐标左边10h
08030C12 3110     add     r1,10h
08030C14 F027F932 bl      8057E7Ch     ;检查砖块相关
08030C18 1C01     mov     r1,r0
08030C1A 2080     mov     r0,80h
08030C1C 0440     lsl     r0,r0,11h
08030C1E 4008     and     r0,r1
08030C20 2800     cmp     r0,0h
08030C22 D10E     bne     @@HaveBlock
08030C24 88A0     ldrh    r0,[r4,4h]
08030C26 1828     add     r0,r5,r0     ;X坐标向右移动随机数
08030C28 E012     b       @@Write

@@Left:
08030C2A 8860     ldrh    r0,[r4,2h]
08030C2C 3810     sub     r0,10h
08030C2E 88A1     ldrh    r1,[r4,4h]
08030C30 3910     sub     r1,10h
08030C32 F027F923 bl      8057E7Ch
08030C36 1C01     mov     r1,r0
08030C38 2080     mov     r0,80h
08030C3A 0440     lsl     r0,r0,11h
08030C3C 4008     and     r0,r1
08030C3E 2800     cmp     r0,0h
08030C40 D004     beq     @@MoveLeft

@@HaveBlock:
08030C42 1C21     mov     r1,r4
08030C44 3124     add     r1,24h
08030C46 200A     mov     r0,0Ah        ;pose写入0Ah
08030C48 7008     strb    r0,[r1]
08030C4A E002     b       @@end

@@MoveLeft:
08030C4C 88A0     ldrh    r0,[r4,4h]
08030C4E 1B40     sub     r0,r0,r5

@@Write:
08030C50 80A0     strh    r0,[r4,4h]

@@end:
08030C52 BC70     pop     r4-r6
08030C54 BC01     pop     r0
08030C56 4700     bx      r0


08030C58 1C02     mov     r2,r0
08030C5A 3224     add     r2,24h
08030C5C 2300     mov     r3,0h
08030C5E 210B     mov     r1,0Bh
08030C60 7011     strb    r1,[r2]
08030C62 4903     ldr     r1,=82E8400h
08030C64 6181     str     r1,[r0,18h]
08030C66 2100     mov     r1,0h
08030C68 82C3     strh    r3,[r0,16h]
08030C6A 7701     strb    r1,[r0,1Ch]
08030C6C 4770     bx      r14
08030C6E 0000     lsl     r0,r0,0h
08030C70 8400     strh    r0,[r0,20h]
08030C72 082E     lsr     r6,r5,20h
08030C74 B510     push    r4,lr
08030C76 1C04     mov     r4,r0
08030C78 F7DEFFA6 bl      800FBC8h
08030C7C 2800     cmp     r0,0h
08030C7E D007     beq     8030C90h
08030C80 8820     ldrh    r0,[r4]
08030C82 2140     mov     r1,40h
08030C84 4048     eor     r0,r1
08030C86 8020     strh    r0,[r4]
08030C88 1C21     mov     r1,r4
08030C8A 3124     add     r1,24h
08030C8C 200C     mov     r0,0Ch
08030C8E 7008     strb    r0,[r1]
08030C90 BC10     pop     r4
08030C92 BC01     pop     r0
08030C94 4700     bx      r0
08030C96 0000     lsl     r0,r0,0h
08030C98 B510     push    r4,lr
08030C9A 1C04     mov     r4,r0
08030C9C F7DEFFB0 bl      800FC00h
08030CA0 2800     cmp     r0,0h
08030CA2 D003     beq     8030CACh
08030CA4 1C21     mov     r1,r4
08030CA6 3124     add     r1,24h
08030CA8 2008     mov     r0,8h
08030CAA 7008     strb    r0,[r1]
08030CAC BC10     pop     r4
08030CAE BC01     pop     r0
08030CB0 4700     bx      r0
08030CB2 0000     lsl     r0,r0,0h
08030CB4 1C02     mov     r2,r0
08030CB6 3224     add     r2,24h
08030CB8 2300     mov     r3,0h
08030CBA 210F     mov     r1,0Fh
08030CBC 7011     strb    r1,[r2]
08030CBE 4904     ldr     r1,=82E8350h
08030CC0 6181     str     r1,[r0,18h]
08030CC2 2100     mov     r1,0h
08030CC4 82C3     strh    r3,[r0,16h]
08030CC6 7701     strb    r1,[r0,1Ch]
08030CC8 302C     add     r0,2Ch
08030CCA 211E     mov     r1,1Eh
08030CCC 7001     strb    r1,[r0]
08030CCE 4770     bx      r14
08030CD0 8350     strh    r0,[r2,1Ah]
08030CD2 082E     lsr     r6,r5,20h
08030CD4 B530     push    r4,r5,lr
08030CD6 1C04     mov     r4,r0
08030CD8 8860     ldrh    r0,[r4,2h]
08030CDA 88A1     ldrh    r1,[r4,4h]
08030CDC F027F8CE bl      8057E7Ch
08030CE0 2180     mov     r1,80h
08030CE2 0449     lsl     r1,r1,11h
08030CE4 4001     and     r1,r0
08030CE6 2900     cmp     r1,0h
08030CE8 D103     bne     8030CF2h
08030CEA 1C21     mov     r1,r4
08030CEC 3124     add     r1,24h
08030CEE 201E     mov     r0,1Eh
08030CF0 E03B     b       8030D6Ah
08030CF2 2500     mov     r5,0h
08030CF4 69A1     ldr     r1,[r4,18h]
08030CF6 4806     ldr     r0,=82E8350h
08030CF8 4281     cmp     r1,r0
08030CFA D10B     bne     8030D14h
08030CFC 1C21     mov     r1,r4
08030CFE 312C     add     r1,2Ch
08030D00 7808     ldrb    r0,[r1]
08030D02 3801     sub     r0,1h
08030D04 7008     strb    r0,[r1]
08030D06 0600     lsl     r0,r0,18h
08030D08 2800     cmp     r0,0h
08030D0A D11E     bne     8030D4Ah
08030D0C E01F     b       8030D4Eh
08030D0E 0000     lsl     r0,r0,0h
08030D10 8350     strh    r0,[r2,1Ah]
08030D12 082E     lsr     r6,r5,20h
08030D14 4808     ldr     r0,=82E8398h
08030D16 4281     cmp     r1,r0
08030D18 D112     bne     8030D40h
08030D1A 1C21     mov     r1,r4
08030D1C 312C     add     r1,2Ch
08030D1E 7808     ldrb    r0,[r1]
08030D20 3801     sub     r0,1h
08030D22 7008     strb    r0,[r1]
08030D24 0600     lsl     r0,r0,18h
08030D26 2800     cmp     r0,0h
08030D28 D10F     bne     8030D4Ah
08030D2A 4804     ldr     r0,=82E83C0h
08030D2C 61A0     str     r0,[r4,18h]
08030D2E 2000     mov     r0,0h
08030D30 82E5     strh    r5,[r4,16h]
08030D32 7720     strb    r0,[r4,1Ch]
08030D34 E009     b       8030D4Ah
08030D36 0000     lsl     r0,r0,0h
08030D38 8398     strh    r0,[r3,1Ch]
08030D3A 082E     lsr     r6,r5,20h
08030D3C 83C0     strh    r0,[r0,1Eh]
08030D3E 082E     lsr     r6,r5,20h
08030D40 F7DEFF5E bl      800FC00h
08030D44 2800     cmp     r0,0h
08030D46 D000     beq     8030D4Ah
08030D48 2501     mov     r5,1h
08030D4A 2D00     cmp     r5,0h
08030D4C D00E     beq     8030D6Ch
08030D4E 4804     ldr     r0,=300083Ch
08030D50 7800     ldrb    r0,[r0]
08030D52 2806     cmp     r0,6h
08030D54 D906     bls     8030D64h
08030D56 1C21     mov     r1,r4
08030D58 3124     add     r1,24h
08030D5A 2008     mov     r0,8h
08030D5C E005     b       8030D6Ah
08030D5E 0000     lsl     r0,r0,0h
08030D60 083C     lsr     r4,r7,20h
08030D62 0300     lsl     r0,r0,0Ch
08030D64 1C21     mov     r1,r4
08030D66 3124     add     r1,24h
08030D68 200A     mov     r0,0Ah
08030D6A 7008     strb    r0,[r1]
08030D6C BC30     pop     r4,r5
08030D6E BC01     pop     r0
08030D70 4700     bx      r0
08030D72 0000     lsl     r0,r0,0h
08030D74 1C02     mov     r2,r0
08030D76 3224     add     r2,24h
08030D78 2300     mov     r3,0h
08030D7A 211F     mov     r1,1Fh
08030D7C 7011     strb    r1,[r2]
08030D7E 302F     add     r0,2Fh
08030D80 7003     strb    r3,[r0]
08030D82 4770     bx      r14
08030D84 B5F0     push    r4-r7,lr
08030D86 1C04     mov     r4,r0
08030D88 8866     ldrh    r6,[r4,2h]
08030D8A 1C23     mov     r3,r4
08030D8C 332F     add     r3,2Fh
08030D8E 7819     ldrb    r1,[r3]
08030D90 4D07     ldr     r5,=82B0D04h
08030D92 0048     lsl     r0,r1,1h
08030D94 1940     add     r0,r0,r5
08030D96 2700     mov     r7,0h
08030D98 5FC2     ldsh    r2,[r0,r7]
08030D9A 4806     ldr     r0,=7FFFh
08030D9C 4282     cmp     r2,r0
08030D9E D10B     bne     8030DB8h
08030DA0 1E48     sub     r0,r1,1
08030DA2 0040     lsl     r0,r0,1h
08030DA4 1940     add     r0,r0,r5
08030DA6 2100     mov     r1,0h
08030DA8 5E40     ldsh    r0,[r0,r1]
08030DAA 1830     add     r0,r6,r0
08030DAC E008     b       8030DC0h
08030DAE 0000     lsl     r0,r0,0h
08030DB0 0D04     lsr     r4,r0,14h
08030DB2 082B     lsr     r3,r5,20h
08030DB4 7FFF     ldrb    r7,[r7,1Fh]
08030DB6 0000     lsl     r0,r0,0h
08030DB8 1C48     add     r0,r1,1
08030DBA 7018     strb    r0,[r3]
08030DBC 8860     ldrh    r0,[r4,2h]
08030DBE 1880     add     r0,r0,r2
08030DC0 8060     strh    r0,[r4,2h]
08030DC2 8860     ldrh    r0,[r4,2h]
08030DC4 88A1     ldrh    r1,[r4,4h]
08030DC6 F7DEFB59 bl      800F47Ch
08030DCA 1C01     mov     r1,r0
08030DCC 4804     ldr     r0,=30007F0h
08030DCE 7800     ldrb    r0,[r0]
08030DD0 2800     cmp     r0,0h
08030DD2 D007     beq     8030DE4h
08030DD4 8061     strh    r1,[r4,2h]
08030DD6 1C21     mov     r1,r4
08030DD8 3124     add     r1,24h
08030DDA 200E     mov     r0,0Eh
08030DDC 7008     strb    r0,[r1]
08030DDE E007     b       8030DF0h
08030DE0 07F0     lsl     r0,r6,1Fh
08030DE2 0300     lsl     r0,r0,0Ch
08030DE4 8861     ldrh    r1,[r4,2h]
08030DE6 88A2     ldrh    r2,[r4,4h]
08030DE8 1C30     mov     r0,r6
08030DEA 2301     mov     r3,1h
08030DEC F7E0FC94 bl      8011718h
08030DF0 BCF0     pop     r4-r7
08030DF2 BC01     pop     r0
08030DF4 4700     bx      r0
08030DF6 0000     lsl     r0,r0,0h
08030DF8 B510     push    r4,lr
08030DFA 8802     ldrh    r2,[r0]
08030DFC 490A     ldr     r1,=0FE7Fh
08030DFE 4011     and     r1,r2
08030E00 2400     mov     r4,0h
08030E02 2300     mov     r3,0h
08030E04 8001     strh    r1,[r0]
08030E06 1C02     mov     r2,r0
08030E08 3224     add     r2,24h
08030E0A 2167     mov     r1,67h
08030E0C 7011     strb    r1,[r2]
08030E0E 4907     ldr     r1,=82E8598h
08030E10 6181     str     r1,[r0,18h]
08030E12 82C3     strh    r3,[r0,16h]
08030E14 7704     strb    r4,[r0,1Ch]
08030E16 4906     ldr     r1,=3000088h
08030E18 7B0A     ldrb    r2,[r1,0Ch]
08030E1A 2103     mov     r1,3h
08030E1C 4011     and     r1,r2
08030E1E 3021     add     r0,21h
08030E20 7001     strb    r1,[r0]
08030E22 BC10     pop     r4
08030E24 BC01     pop     r0
08030E26 4700     bx      r0
08030E28 FE7F0000 ????
08030E2A 0000     lsl     r0,r0,0h
08030E2C 8598     strh    r0,[r3,2Ch]
08030E2E 082E     lsr     r6,r5,20h
08030E30 0088     lsl     r0,r1,2h
08030E32 0300     lsl     r0,r0,0Ch
08030E34 B510     push    r4,lr
08030E36 1C04     mov     r4,r0
08030E38 1C21     mov     r1,r4
08030E3A 3126     add     r1,26h
08030E3C 2001     mov     r0,1h
08030E3E 7008     strb    r0,[r1]
08030E40 F7DEFEC2 bl      800FBC8h
08030E44 2800     cmp     r0,0h
08030E46 D001     beq     8030E4Ch
08030E48 2000     mov     r0,0h
08030E4A 8020     strh    r0,[r4]
08030E4C BC10     pop     r4
08030E4E BC01     pop     r0
08030E50 4700     bx      r0
08030E52 0000     lsl     r0,r0,0h
08030E54 B530     push    r4,r5,lr
08030E56 1C04     mov     r4,r0
08030E58 1C21     mov     r1,r4
08030E5A 3126     add     r1,26h
08030E5C 2500     mov     r5,0h
08030E5E 2001     mov     r0,1h
08030E60 7008     strb    r0,[r1]
08030E62 F7DEFEB1 bl      800FBC8h
08030E66 2800     cmp     r0,0h
08030E68 D01D     beq     8030EA6h
08030E6A 8025     strh    r5,[r4]
08030E6C 4A0F     ldr     r2,=30001ACh
08030E6E 1C20     mov     r0,r4
08030E70 3023     add     r0,23h
08030E72 7801     ldrb    r1,[r0]
08030E74 00C8     lsl     r0,r1,3h
08030E76 1A40     sub     r0,r0,r1
08030E78 00C0     lsl     r0,r0,3h
08030E7A 1880     add     r0,r0,r2
08030E7C 8005     strh    r5,[r0]
08030E7E 2003     mov     r0,3h
08030E80 212D     mov     r1,2Dh
08030E82 F02FFD1B bl      80608BCh
08030E86 2800     cmp     r0,0h
08030E88 D10D     bne     8030EA6h
08030E8A 205E     mov     r0,5Eh
08030E8C F7DFFC2C bl      80106E8h
08030E90 2800     cmp     r0,0h
08030E92 D108     bne     8030EA6h
08030E94 2001     mov     r0,1h
08030E96 212D     mov     r1,2Dh
08030E98 F02FFD10 bl      80608BCh
08030E9C 4904     ldr     r1,=300007Bh
08030E9E 2214     mov     r2,14h
08030EA0 4252     neg     r2,r2
08030EA2 1C10     mov     r0,r2
08030EA4 7008     strb    r0,[r1]
08030EA6 BC30     pop     r4,r5
08030EA8 BC01     pop     r0
08030EAA 4700     bx      r0
08030EAC 01AC     lsl     r4,r5,6h
08030EAE 0300     lsl     r0,r0,0Ch
08030EB0 007B     lsl     r3,r7,1h
08030EB2 0300     lsl     r0,r0,0Ch
08030EB4 B570     push    r4-r6,lr
08030EB6 1C03     mov     r3,r0
08030EB8 1C19     mov     r1,r3
08030EBA 3124     add     r1,24h
08030EBC 2600     mov     r6,0h
08030EBE 204D     mov     r0,4Dh
08030EC0 7008     strb    r0,[r1]
08030EC2 480F     ldr     r0,=82E84E0h
08030EC4 6198     str     r0,[r3,18h]
08030EC6 2100     mov     r1,0h
08030EC8 82DE     strh    r6,[r3,16h]
08030ECA 7719     strb    r1,[r3,1Ch]
08030ECC 1C18     mov     r0,r3
08030ECE 302C     add     r0,2Ch
08030ED0 7001     strb    r1,[r0]
08030ED2 3001     add     r0,1h
08030ED4 7804     ldrb    r4,[r0]
08030ED6 4A0B     ldr     r2,=30001ACh
08030ED8 00E1     lsl     r1,r4,3h
08030EDA 1B09     sub     r1,r1,r4
08030EDC 00C9     lsl     r1,r1,3h
08030EDE 1889     add     r1,r1,r2
08030EE0 8948     ldrh    r0,[r1,0Ah]
08030EE2 884D     ldrh    r5,[r1,2h]
08030EE4 1940     add     r0,r0,r5
08030EE6 0400     lsl     r0,r0,10h
08030EE8 0C05     lsr     r5,r0,10h
08030EEA 89C8     ldrh    r0,[r1,0Eh]
08030EEC 8889     ldrh    r1,[r1,4h]
08030EEE 1840     add     r0,r0,r1
08030EF0 0400     lsl     r0,r0,10h
08030EF2 0C01     lsr     r1,r0,10h
08030EF4 8858     ldrh    r0,[r3,2h]
08030EF6 42A8     cmp     r0,r5
08030EF8 D206     bcs     8030F08h
08030EFA 80DE     strh    r6,[r3,6h]
08030EFC E006     b       8030F0Ch
08030EFE 0000     lsl     r0,r0,0h
08030F00 84E0     strh    r0,[r4,26h]
08030F02 082E     lsr     r6,r5,20h
08030F04 01AC     lsl     r4,r5,6h
08030F06 0300     lsl     r0,r0,0Ch
08030F08 1B40     sub     r0,r0,r5
08030F0A 80D8     strh    r0,[r3,6h]
08030F0C 8898     ldrh    r0,[r3,4h]
08030F0E 4288     cmp     r0,r1
08030F10 D201     bcs     8030F16h
08030F12 2000     mov     r0,0h
08030F14 E000     b       8030F18h
08030F16 1A40     sub     r0,r0,r1
08030F18 8118     strh    r0,[r3,8h]
08030F1A 8858     ldrh    r0,[r3,2h]
08030F1C 00E1     lsl     r1,r4,3h
08030F1E 1B09     sub     r1,r1,r4
08030F20 00C9     lsl     r1,r1,3h
08030F22 1889     add     r1,r1,r2
08030F24 8849     ldrh    r1,[r1,2h]
08030F26 3960     sub     r1,60h
08030F28 4288     cmp     r0,r1
08030F2A DD05     ble     8030F38h
08030F2C 8819     ldrh    r1,[r3]
08030F2E 4801     ldr     r0,=0FEFFh
08030F30 4008     and     r0,r1
08030F32 E006     b       8030F42h
08030F34 FEFF0000 ????
08030F36 0000     lsl     r0,r0,0h
08030F38 8819     ldrh    r1,[r3]
08030F3A 2280     mov     r2,80h
08030F3C 0052     lsl     r2,r2,1h
08030F3E 1C10     mov     r0,r2
08030F40 4308     orr     r0,r1
08030F42 8018     strh    r0,[r3]
08030F44 BC70     pop     r4-r6
08030F46 BC01     pop     r0
08030F48 4700     bx      r0
08030F4A 0000     lsl     r0,r0,0h
08030F4C B5F0     push    r4-r7,lr
08030F4E 1C03     mov     r3,r0
08030F50 302D     add     r0,2Dh
08030F52 7806     ldrb    r6,[r0]
08030F54 490F     ldr     r1,=30001ACh
08030F56 00F0     lsl     r0,r6,3h
08030F58 1B80     sub     r0,r0,r6
08030F5A 00C0     lsl     r0,r0,3h
08030F5C 1842     add     r2,r0,r1
08030F5E 1C10     mov     r0,r2
08030F60 3024     add     r0,24h
08030F62 7800     ldrb    r0,[r0]
08030F64 468C     mov     r12,r1
08030F66 2825     cmp     r0,25h
08030F68 D11A     bne     8030FA0h
08030F6A 1C18     mov     r0,r3
08030F6C 3024     add     r0,24h
08030F6E 2144     mov     r1,44h
08030F70 7001     strb    r1,[r0]
08030F72 4809     ldr     r0,=300083Ch
08030F74 7800     ldrb    r0,[r0]
08030F76 2805     cmp     r0,5h
08030F78 D800     bhi     8030F7Ch
08030F7A 2006     mov     r0,6h
08030F7C 1C19     mov     r1,r3
08030F7E 312E     add     r1,2Eh
08030F80 7008     strb    r0,[r1]
08030F82 3909     sub     r1,9h
08030F84 2017     mov     r0,17h
08030F86 7008     strb    r0,[r1]
08030F88 8819     ldrh    r1,[r3]
08030F8A 4804     ldr     r0,=7FFFh
08030F8C 4008     and     r0,r1
08030F8E 8018     strh    r0,[r3]
08030F90 E0A7     b       80310E2h
08030F92 0000     lsl     r0,r0,0h
08030F94 01AC     lsl     r4,r5,6h
08030F96 0300     lsl     r0,r0,0Ch
08030F98 083C     lsr     r4,r7,20h
08030F9A 0300     lsl     r0,r0,0Ch
08030F9C 7FFF     ldrb    r7,[r7,1Fh]
08030F9E 0000     lsl     r0,r0,0h
08030FA0 490B     ldr     r1,=3000734h
08030FA2 7808     ldrb    r0,[r1]
08030FA4 2800     cmp     r0,0h
08030FA6 D101     bne     8030FACh
08030FA8 205A     mov     r0,5Ah
08030FAA 7008     strb    r0,[r1]
08030FAC 881D     ldrh    r5,[r3]
08030FAE 2780     mov     r7,80h
08030FB0 007F     lsl     r7,r7,1h
08030FB2 1C38     mov     r0,r7
08030FB4 4028     and     r0,r5
08030FB6 2800     cmp     r0,0h
08030FB8 D00E     beq     8030FD8h
08030FBA 8851     ldrh    r1,[r2,2h]
08030FBC 8858     ldrh    r0,[r3,2h]
08030FBE 3008     add     r0,8h
08030FC0 1C1C     mov     r4,r3
08030FC2 342C     add     r4,2Ch
08030FC4 4281     cmp     r1,r0
08030FC6 DA17     bge     8030FF8h
08030FC8 4802     ldr     r0,=0FEFFh
08030FCA 4028     and     r0,r5
08030FCC E010     b       8030FF0h
08030FCE 0000     lsl     r0,r0,0h
08030FD0 0734     lsl     r4,r6,1Ch
08030FD2 0300     lsl     r0,r0,0Ch
08030FD4 FEFF0000 ????
08030FD6 0000     lsl     r0,r0,0h
08030FD8 200A     mov     r0,0Ah
08030FDA 5E11     ldsh    r1,[r2,r0]
08030FDC 8852     ldrh    r2,[r2,2h]
08030FDE 1889     add     r1,r1,r2
08030FE0 8858     ldrh    r0,[r3,2h]
08030FE2 3808     sub     r0,8h
08030FE4 1C1C     mov     r4,r3
08030FE6 342C     add     r4,2Ch
08030FE8 4281     cmp     r1,r0
08030FEA DD05     ble     8030FF8h
08030FEC 1C38     mov     r0,r7
08030FEE 4328     orr     r0,r5
08030FF0 8018     strh    r0,[r3]
08030FF2 480B     ldr     r0,=300083Ch
08030FF4 7800     ldrb    r0,[r0]
08030FF6 7020     strb    r0,[r4]
08030FF8 881D     ldrh    r5,[r3]
08030FFA 2040     mov     r0,40h
08030FFC 4028     and     r0,r5
08030FFE 2800     cmp     r0,0h
08031000 D012     beq     8031028h
08031002 00F2     lsl     r2,r6,3h
08031004 1B90     sub     r0,r2,r6
08031006 00C0     lsl     r0,r0,3h
08031008 4460     add     r0,r12
0803100A 2710     mov     r7,10h
0803100C 5FC1     ldsh    r1,[r0,r7]
0803100E 8880     ldrh    r0,[r0,4h]
08031010 1809     add     r1,r1,r0
08031012 8898     ldrh    r0,[r3,4h]
08031014 3008     add     r0,8h
08031016 4281     cmp     r1,r0
08031018 DA18     bge     803104Ch
0803101A 4802     ldr     r0,=0FFBFh
0803101C 4028     and     r0,r5
0803101E E011     b       8031044h
08031020 083C     lsr     r4,r7,20h
08031022 0300     lsl     r0,r0,0Ch
08031024 FFBF0000 ????
08031026 0000     lsl     r0,r0,0h
08031028 00F2     lsl     r2,r6,3h
0803102A 1B90     sub     r0,r2,r6
0803102C 00C0     lsl     r0,r0,3h
0803102E 4460     add     r0,r12
08031030 270E     mov     r7,0Eh
08031032 5FC1     ldsh    r1,[r0,r7]
08031034 8880     ldrh    r0,[r0,4h]
08031036 1809     add     r1,r1,r0
08031038 8898     ldrh    r0,[r3,4h]
0803103A 3808     sub     r0,8h
0803103C 4281     cmp     r1,r0
0803103E DD05     ble     803104Ch
08031040 2040     mov     r0,40h
08031042 4328     orr     r0,r5
08031044 8018     strh    r0,[r3]
08031046 480A     ldr     r0,=300083Ch
08031048 7800     ldrb    r0,[r0]
0803104A 7020     strb    r0,[r4]
0803104C 7820     ldrb    r0,[r4]
0803104E 2800     cmp     r0,0h
08031050 D132     bne     80310B8h
08031052 8819     ldrh    r1,[r3]
08031054 2080     mov     r0,80h
08031056 0040     lsl     r0,r0,1h
08031058 4008     and     r0,r1
0803105A 1C0D     mov     r5,r1
0803105C 2800     cmp     r0,0h
0803105E D009     beq     8031074h
08031060 4803     ldr     r0,=300083Ch
08031062 7801     ldrb    r1,[r0]
08031064 1C04     mov     r4,r0
08031066 2900     cmp     r1,0h
08031068 D00C     beq     8031084h
0803106A 88D8     ldrh    r0,[r3,6h]
0803106C 3001     add     r0,1h
0803106E E008     b       8031082h
08031070 083C     lsr     r4,r7,20h
08031072 0300     lsl     r0,r0,0Ch
08031074 480A     ldr     r0,=300083Ch
08031076 7801     ldrb    r1,[r0]
08031078 1C04     mov     r4,r0
0803107A 2900     cmp     r1,0h
0803107C D002     beq     8031084h
0803107E 88D8     ldrh    r0,[r3,6h]
08031080 3801     sub     r0,1h
08031082 80D8     strh    r0,[r3,6h]
08031084 2040     mov     r0,40h
08031086 4028     and     r0,r5
08031088 2800     cmp     r0,0h
0803108A D00B     beq     80310A4h
0803108C 1C19     mov     r1,r3
0803108E 3123     add     r1,23h
08031090 7820     ldrb    r0,[r4]
08031092 7809     ldrb    r1,[r1]
08031094 4288     cmp     r0,r1
08031096 D011     beq     80310BCh
08031098 8918     ldrh    r0,[r3,8h]
0803109A 3001     add     r0,1h
0803109C 8118     strh    r0,[r3,8h]
0803109E E00D     b       80310BCh
080310A0 083C     lsr     r4,r7,20h
080310A2 0300     lsl     r0,r0,0Ch
080310A4 1C19     mov     r1,r3
080310A6 3123     add     r1,23h
080310A8 7820     ldrb    r0,[r4]
080310AA 7809     ldrb    r1,[r1]
080310AC 4288     cmp     r0,r1
080310AE D005     beq     80310BCh
080310B0 8918     ldrh    r0,[r3,8h]
080310B2 3801     sub     r0,1h
080310B4 8118     strh    r0,[r3,8h]
080310B6 E001     b       80310BCh
080310B8 3801     sub     r0,1h
080310BA 7020     strb    r0,[r4]
080310BC 1B90     sub     r0,r2,r6
080310BE 00C0     lsl     r0,r0,3h
080310C0 4460     add     r0,r12
080310C2 8941     ldrh    r1,[r0,0Ah]
080310C4 8842     ldrh    r2,[r0,2h]
080310C6 1889     add     r1,r1,r2
080310C8 0409     lsl     r1,r1,10h
080310CA 89C2     ldrh    r2,[r0,0Eh]
080310CC 8880     ldrh    r0,[r0,4h]
080310CE 1812     add     r2,r2,r0
080310D0 0412     lsl     r2,r2,10h
080310D2 0C09     lsr     r1,r1,10h
080310D4 88DF     ldrh    r7,[r3,6h]
080310D6 19C9     add     r1,r1,r7
080310D8 8059     strh    r1,[r3,2h]
080310DA 0C12     lsr     r2,r2,10h
080310DC 8918     ldrh    r0,[r3,8h]
080310DE 1812     add     r2,r2,r0
080310E0 809A     strh    r2,[r3,4h]
080310E2 BCF0     pop     r4-r7
080310E4 BC01     pop     r0
080310E6 4700     bx      r0

/////////////////////////////////////////////////////////////////

;5E主程序调用 Pose小于66时
080310E8 B5F0     push    r4-r7,lr
080310EA 4657     mov     r7,r10
080310EC 464E     mov     r6,r9
080310EE 4645     mov     r5,r8
080310F0 B4E0     push    r5-r7
080310F2 B086     add     sp,-18h
080310F4 1C06     mov     r6,r0
080310F6 302B     add     r0,2Bh
080310F8 7801     ldrb    r1,[r0]
080310FA 2080     mov     r0,80h
080310FC 4008     and     r0,r1     	    ;读取击晕值
080310FE 2800     cmp     r0,0h      	 	;是否有80
08031100 D008     beq     @@2BNo80  
08031102 1C31     mov     r1,r6
08031104 3124     add     r1,24h
08031106 2062     mov     r0,62h
08031108 7008     strb    r0,[r1]     		;如果有80则pose写入62h 超炸炸死
0803110A E06E     b       @@end
.pool

@@BomeDamage:
0803110C		  add	  r0,r7,1h
0803110E		  lsl	  r0,r0,18h
08031110		  lsr	  r7,r0,18h
08031112		  b		  @@OverData
@@2BNo80:
08031114 2700     mov     r7,0h
08031116 8871     ldrh    r1,[r6,2h]    	;Y坐标
08031118 8970     ldrh    r0,[r6,0Ah]   	;上部分界
0803111A 1808     add     r0,r1,r0		
0803111C 0400     lsl     r0,r0,10h
0803111E 0C00     lsr     r0,r0,10h
08031120 9004     str     r0,[sp,10h]
08031122 89B0     ldrh    r0,[r6,0Ch]
08031124 1809     add     r1,r1,r0
08031126 0409     lsl     r1,r1,10h
08031128 0C09     lsr     r1,r1,10h
0803112A 9105     str     r1,[sp,14h]
0803112C 88B1     ldrh    r1,[r6,4h]
0803112E 89F0     ldrh    r0,[r6,0Eh]
08031130 1808     add     r0,r1,r0
08031132 0400     lsl     r0,r0,10h
08031134 0C00     lsr     r0,r0,10h
08031136 4681     mov     r9,r0
08031138 8A30     ldrh    r0,[r6,10h]
0803113A 1809     add     r1,r1,r0
0803113C 0409     lsl     r1,r1,10h
0803113E 0C09     lsr     r1,r1,10h
08031140 4688     mov     r8,r1
08031142 4D1E     ldr     r5,=3000A2Ch
08031144 21E0     mov     r1,0E0h
08031146 0049     lsl     r1,r1,1h
08031148 1868     add     r0,r5,r1			;最大的范围
0803114A 2124     mov     r1,24h
0803114C 1989     add     r1,r1,r6			;pose值地址
0803114E 468A     mov     r10,r1
08031150 4285     cmp     r5,r0
08031152 D22C     bcs     @@OverData

@@Loop:
08031154 7828     ldrb    r0,[r5]
08031156 2101     mov     r1,1h
08031158 4008     and     r0,r1
0803115A 2800     cmp     r0,0h				;检查是否有弹丸	
0803115C D023     beq     @@NextPro
0803115E 7BE8     ldrb    r0,[r5,0Fh]
08031160 280E     cmp     r0,0Eh			;检查弹丸类型是否是炸弹
08031162 D120     bne     @@NextPro
08031164 7C68     ldrb    r0,[r5,11h]
08031166 2803     cmp     r0,3h				;检查炸弹的节奏
08031168 D11D     bne     @@NextPro
0803116A 892B     ldrh    r3,[r5,8h]
0803116C 8AAC     ldrh    r4,[r5,14h]
0803116E 191C     add     r4,r3,r4			;蛋极上
08031170 0424     lsl     r4,r4,10h
08031172 0C24     lsr     r4,r4,10h
08031174 8AE8     ldrh    r0,[r5,16h]
08031176 181B     add     r3,r3,r0
08031178 041B     lsl     r3,r3,10h
0803117A 0C1B     lsr     r3,r3,10h
0803117C 896A     ldrh    r2,[r5,0Ah]
0803117E 8B29     ldrh    r1,[r5,18h]
08031180 1851     add     r1,r2,r1
08031182 0409     lsl     r1,r1,10h
08031184 0C09     lsr     r1,r1,10h
08031186 8B68     ldrh    r0,[r5,1Ah]
08031188 1812     add     r2,r2,r0
0803118A 0412     lsl     r2,r2,10h
0803118C 0C12     lsr     r2,r2,10h
0803118E 9400     str     r4,[sp]
08031190 9301     str     r3,[sp,4h]
08031192 9102     str     r1,[sp,8h]
08031194 9203     str     r2,[sp,0Ch]
08031196 9804     ldr     r0,[sp,10h]
08031198 9905     ldr     r1,[sp,14h]
0803119A 464A     mov     r2,r9
0803119C 4643     mov     r3,r8
0803119E F7DDFAAB bl      800E6F8h			;检查是否被炸弹炸到
080311A2 2800     cmp     r0,0h
080311A4 D1B2     bne     @@BomeDamage

@@NextPro:
080311A6 351C     add     r5,1Ch
080311A8 4805     ldr     r0,=3000BECh
080311AA 4285     cmp     r5,r0
080311AC D3D2     bcc     @@Loop

@@OverData:
080311AE 2F00     cmp     r7,0h
080311B0 D008     beq     @@NoBomeDamage
080311B2 2062     mov     r0,62h
080311B4 4651     mov     r1,r10
080311B6 7008     strb    r0,[r1]
080311B8 E017     b       @@end
.pool

@@NoBomeDamage:
080311C4 1C30     mov     r0,r6
080311C6 302B     add     r0,2Bh
080311C8 7007     strb    r7,[r0]		;击晕值写入0
080311CA 2001     mov     r0,1h
080311CC 82B0     strh    r0,[r6,14h]	;血量写入1
080311CE 2044     mov     r0,44h
080311D0 4651     mov     r1,r10
080311D2 7008     strb    r0,[r1]		;pose写入44h
080311D4 4809     ldr     r0,=300083Ch
080311D6 7800     ldrb    r0,[r0]
080311D8 0847     lsr     r7,r0,1h
080311DA 2F08     cmp     r7,8h
080311DC D800     bhi     80311E0h
080311DE 2709     mov     r7,9h

@@Pass:
080311E0 1C30     mov     r0,r6
080311E2 302E     add     r0,2Eh
080311E4 7007     strb    r7,[r0]		;偏移2E写入随机值或9
080311E6 F7DEFBAD bl      800F944h

@@end:
080311EA B006     add     sp,18h
080311EC BC38     pop     r3-r5
080311EE 4698     mov     r8,r3
080311F0 46A1     mov     r9,r4
080311F2 46AA     mov     r10,r5
080311F4 BCF0     pop     r4-r7
080311F6 BC01     pop     r0
080311F8 4700     bx      r0

;5E bug虫主程序
08031200 B510     push    r4,lr
08031202 4C0D     ldr     r4,=3000738h
08031204 1C20     mov     r0,r4
08031206 302B     add     r0,2Bh
08031208 7801     ldrb    r1,[r0]   ;读取击晕值  
0803120A 207F     mov     r0,7Fh
0803120C 4008     and     r0,r1
0803120E 2800     cmp     r0,0h
08031210 D007     beq     @@Peer
08031212 1C20     mov     r0,r4
08031214 3024     add     r0,24h
08031216 7800     ldrb    r0,[r0]   ;读取pose
08031218 2866     cmp     r0,66h    ;大于66h
0803121A D802     bhi     @@Peer
0803121C 1C20     mov     r0,r4
0803121E F7FFFF63 bl      80310E8h  ;检查炸弹

@@Peer:
08031222 1C20     mov     r0,r4
08031224 3024     add     r0,24h
08031226 7800     ldrb    r0,[r0]   ;读取pose
08031228 2867     cmp     r0,67h
0803122A D900     bls     @@Pass
0803122C E11D     b       @@RemoveFlag

@@Pass:
0803122E 0080     lsl     r0,r0,2h
08031230 4902     ldr     r1,=8031240h
08031232 1840     add     r0,r0,r1
08031234 6800     ldr     r0,[r0]
08031236 4687     mov     r15,r0
.pool

    .word @@PoseZeroBL
    .word @@RemoveFlag 
    .word @@RemoveFlag     
    .word @@RemoveFlag     
    .word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
    .word @@Pose8BL 
	.word @@Pose9BL
	.word @@PoseABL
	.word @@PoseBBL
	.word @@PoseCBL
	.word @@RemoveFlag
	.word @@PoseEBL 
	.word @@PoseFBL
	.word @@RemoveFlag
	.word @@RemoveFlag     
    .word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
    .word @@Pose1EBL
	.word @@Pose1FBL
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
    .word @@Pose42BL
	.word @@Pose43BL
	.word @@Pose44BL
	.word @@RemoveFlag 
	.word @@Pose46BL
	.word @@RemoveFlag
    .word @@Pose48BL
	.word @@RemoveFlag
	.word @@Pose4ABL
	.word @@RemoveFlag
	.word @@Pose4CBL
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
    .word @@Pose61BL
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
	.word @@RemoveFlag
    .word @@Pose66BL
	
@@PoseZeroBL:	
080313E0 1C20     mov     r0,r4
080313E2 F7FEFDAF bl      802FF44h
080313E6 E040     b       @@RemoveFlag

@@Pose8BL:
080313E8 1C20     mov     r0,r4
080313EA F7FFFA6F bl      80308CCh
080313EE E03C     b       @@RemoveFlag

@@Pose9BL:
080313F0 1C20     mov     r0,r4
080313F2 F7FFFB5F bl      8030AB4h
080313F6 E038     b       @@RemoveFlag

@@PoseABL:
080313F8 1C20     mov     r0,r4
080313FA F7FFFC2D bl      8030C58h

@@PoseBBL:
080313FE 1C20     mov     r0,r4
08031400 F7FFFC38 bl      8030C74h
08031404 E031     b       @@RemoveFlag

@@PoseCBL:
08031406 1C20     mov     r0,r4
08031408 F7FFFC46 bl      8030C98h
0803140C E02D     b       @@RemoveFlag

@@PoseEBL:
0803140E 1C20     mov     r0,r4
08031410 F7FFFC50 bl      8030CB4h

@@PoseFBL:
08031414 1C20     mov     r0,r4
08031416 F7FFFC5D bl      8030CD4h
0803141A E026     b       @@RemoveFlag

@@Pose1EBL:
0803141C 1C20     mov     r0,r4
0803141E F7FFFCA9 bl      8030D74h

@@Pose1FBL:
08031422 1C20     mov     r0,r4
08031424 F7FFFCAE bl      8030D84h
08031428 E01F     b       @@RemoveFlag

@@Pose42BL:
0803142A 1C20     mov     r0,r4
0803142C F7FEFE20 bl      8030070h

@@Pose43BL:
08031430 1C20     mov     r0,r4
08031432 F7FEFE65 bl      8030100h
08031436 E018     b       @@RemoveFlag

@@Pose44BL:
08031438 1C20     mov     r0,r4
0803143A F7FEFF29 bl      8030290h

@@Pose46BL:
0803143E 1C20     mov     r0,r4
08031440 F7FEFF8E bl      8030360h
08031444 E011     b       @@RemoveFlag

@@Pose48BL:
08031446 1C20     mov     r0,r4
08031448 F7FFF852 bl      80304F0h
0803144C E00D     b       @@RemoveFlag

@@Pose4ABL:
0803144E 1C20     mov     r0,r4
08031450 F7FFF918 bl      8030684h
08031454 E009     b       @@RemoveFlag

@@Pose4CBL:
08031456 1C20     mov     r0,r4
08031458 F7FFF9D8 bl      803080Ch
0803145C E005     b       @@RemoveFlag

@@Pose61BL:
0803145E 1C20     mov     r0,r4
08031460 F7FFFCCA bl      8030DF8h

@@Pose66BL:
08031464 1C20     mov     r0,r4
08031466 F7FFFCF5 bl      8030E54h

@@RemoveFlag:
0803146A 8821     ldrh    r1,[r4]
0803146C 4802     ldr     r0,=0F7FFh
0803146E 4008     and     r0,r1
08031470 8020     strh    r0,[r4]
08031472 BC10     pop     r4
08031474 BC01     pop     r0
08031476 4700     bx      r0
.pool

;bug虫主程序 5F
0803147C B510     push    r4,lr
0803147E 4C0D     ldr     r4,=3000738h
08031480 1C20     mov     r0,r4
08031482 302B     add     r0,2Bh
08031484 7801     ldrb    r1,[r0]
08031486 207F     mov     r0,7Fh
08031488 4008     and     r0,r1
0803148A 2800     cmp     r0,0h
0803148C D007     beq     803149Eh
0803148E 1C20     mov     r0,r4
08031490 3024     add     r0,24h
08031492 7800     ldrb    r0,[r0]
08031494 2866     cmp     r0,66h
08031496 D802     bhi     803149Eh
08031498 1C20     mov     r0,r4
0803149A F7FFFE25 bl      80310E8h
0803149E 1C20     mov     r0,r4
080314A0 3024     add     r0,24h
080314A2 7800     ldrb    r0,[r0]
080314A4 2867     cmp     r0,67h
080314A6 D900     bls     80314AAh
080314A8 E124     b       80316F4h
080314AA 0080     lsl     r0,r0,2h
080314AC 4902     ldr     r1,=80314BCh
080314AE 1840     add     r0,r0,r1
080314B0 6800     ldr     r0,[r0]
080314B2 4687     mov     r15,r0
080314B4 0738     lsl     r0,r7,1Ch
080314B6 0300     lsl     r0,r0,0Ch
080314B8 14BC     asr     r4,r7,12h
080314BA 0803     lsr     r3,r0,20h
080314BC 165C     asr     r4,r3,19h
080314BE 0803     lsr     r3,r0,20h
080314C0 16F4     asr     r4,r6,1Bh
080314C2 0803     lsr     r3,r0,20h
080314C4 16F4     asr     r4,r6,1Bh
080314C6 0803     lsr     r3,r0,20h
080314C8 16F4     asr     r4,r6,1Bh
080314CA 0803     lsr     r3,r0,20h
080314CC 16F4     asr     r4,r6,1Bh
080314CE 0803     lsr     r3,r0,20h
080314D0 16F4     asr     r4,r6,1Bh
080314D2 0803     lsr     r3,r0,20h
080314D4 16F4     asr     r4,r6,1Bh
080314D6 0803     lsr     r3,r0,20h
080314D8 16F4     asr     r4,r6,1Bh
080314DA 0803     lsr     r3,r0,20h
080314DC 1664     asr     r4,r4,19h
080314DE 0803     lsr     r3,r0,20h
080314E0 166A     asr     r2,r5,19h
080314E2 0803     lsr     r3,r0,20h
080314E4 1672     asr     r2,r6,19h
080314E6 0803     lsr     r3,r0,20h
080314E8 1678     asr     r0,r7,19h
080314EA 0803     lsr     r3,r0,20h
080314EC 1680     asr     r0,r0,1Ah
080314EE 0803     lsr     r3,r0,20h
080314F0 16F4     asr     r4,r6,1Bh
080314F2 0803     lsr     r3,r0,20h
080314F4 1688     asr     r0,r1,1Ah
080314F6 0803     lsr     r3,r0,20h
080314F8 168E     asr     r6,r1,1Ah
080314FA 0803     lsr     r3,r0,20h
080314FC 16F4     asr     r4,r6,1Bh
080314FE 0803     lsr     r3,r0,20h
08031500 16F4     asr     r4,r6,1Bh
08031502 0803     lsr     r3,r0,20h
08031504 16F4     asr     r4,r6,1Bh
08031506 0803     lsr     r3,r0,20h
08031508 16F4     asr     r4,r6,1Bh
0803150A 0803     lsr     r3,r0,20h
0803150C 16F4     asr     r4,r6,1Bh
0803150E 0803     lsr     r3,r0,20h
08031510 16F4     asr     r4,r6,1Bh
08031512 0803     lsr     r3,r0,20h
08031514 16F4     asr     r4,r6,1Bh
08031516 0803     lsr     r3,r0,20h
08031518 16F4     asr     r4,r6,1Bh
0803151A 0803     lsr     r3,r0,20h
0803151C 16F4     asr     r4,r6,1Bh
0803151E 0803     lsr     r3,r0,20h
08031520 16F4     asr     r4,r6,1Bh
08031522 0803     lsr     r3,r0,20h
08031524 16F4     asr     r4,r6,1Bh
08031526 0803     lsr     r3,r0,20h
08031528 16F4     asr     r4,r6,1Bh
0803152A 0803     lsr     r3,r0,20h
0803152C 16F4     asr     r4,r6,1Bh
0803152E 0803     lsr     r3,r0,20h
08031530 16F4     asr     r4,r6,1Bh
08031532 0803     lsr     r3,r0,20h
08031534 1696     asr     r6,r2,1Ah
08031536 0803     lsr     r3,r0,20h
08031538 169C     asr     r4,r3,1Ah
0803153A 0803     lsr     r3,r0,20h
0803153C 16F4     asr     r4,r6,1Bh
0803153E 0803     lsr     r3,r0,20h
08031540 16F4     asr     r4,r6,1Bh
08031542 0803     lsr     r3,r0,20h
08031544 16F4     asr     r4,r6,1Bh
08031546 0803     lsr     r3,r0,20h
08031548 16F4     asr     r4,r6,1Bh
0803154A 0803     lsr     r3,r0,20h
0803154C 16F4     asr     r4,r6,1Bh
0803154E 0803     lsr     r3,r0,20h
08031550 16F4     asr     r4,r6,1Bh
08031552 0803     lsr     r3,r0,20h
08031554 16F4     asr     r4,r6,1Bh
08031556 0803     lsr     r3,r0,20h
08031558 16F4     asr     r4,r6,1Bh
0803155A 0803     lsr     r3,r0,20h
0803155C 16F4     asr     r4,r6,1Bh
0803155E 0803     lsr     r3,r0,20h
08031560 16F4     asr     r4,r6,1Bh
08031562 0803     lsr     r3,r0,20h
08031564 16F4     asr     r4,r6,1Bh
08031566 0803     lsr     r3,r0,20h
08031568 16F4     asr     r4,r6,1Bh
0803156A 0803     lsr     r3,r0,20h
0803156C 16F4     asr     r4,r6,1Bh
0803156E 0803     lsr     r3,r0,20h
08031570 16F4     asr     r4,r6,1Bh
08031572 0803     lsr     r3,r0,20h
08031574 16F4     asr     r4,r6,1Bh
08031576 0803     lsr     r3,r0,20h
08031578 16F4     asr     r4,r6,1Bh
0803157A 0803     lsr     r3,r0,20h
0803157C 16F4     asr     r4,r6,1Bh
0803157E 0803     lsr     r3,r0,20h
08031580 16F4     asr     r4,r6,1Bh
08031582 0803     lsr     r3,r0,20h
08031584 16F4     asr     r4,r6,1Bh
08031586 0803     lsr     r3,r0,20h
08031588 16F4     asr     r4,r6,1Bh
0803158A 0803     lsr     r3,r0,20h
0803158C 16F4     asr     r4,r6,1Bh
0803158E 0803     lsr     r3,r0,20h
08031590 16F4     asr     r4,r6,1Bh
08031592 0803     lsr     r3,r0,20h
08031594 16F4     asr     r4,r6,1Bh
08031596 0803     lsr     r3,r0,20h
08031598 16F4     asr     r4,r6,1Bh
0803159A 0803     lsr     r3,r0,20h
0803159C 16F4     asr     r4,r6,1Bh
0803159E 0803     lsr     r3,r0,20h
080315A0 16F4     asr     r4,r6,1Bh
080315A2 0803     lsr     r3,r0,20h
080315A4 16F4     asr     r4,r6,1Bh
080315A6 0803     lsr     r3,r0,20h
080315A8 16F4     asr     r4,r6,1Bh
080315AA 0803     lsr     r3,r0,20h
080315AC 16F4     asr     r4,r6,1Bh
080315AE 0803     lsr     r3,r0,20h
080315B0 16F4     asr     r4,r6,1Bh
080315B2 0803     lsr     r3,r0,20h
080315B4 16F4     asr     r4,r6,1Bh
080315B6 0803     lsr     r3,r0,20h
080315B8 16F4     asr     r4,r6,1Bh
080315BA 0803     lsr     r3,r0,20h
080315BC 16F4     asr     r4,r6,1Bh
080315BE 0803     lsr     r3,r0,20h
080315C0 16F4     asr     r4,r6,1Bh
080315C2 0803     lsr     r3,r0,20h
080315C4 16A4     asr     r4,r4,1Ah
080315C6 0803     lsr     r3,r0,20h
080315C8 16AA     asr     r2,r5,1Ah
080315CA 0803     lsr     r3,r0,20h
080315CC 16B2     asr     r2,r6,1Ah
080315CE 0803     lsr     r3,r0,20h
080315D0 16B8     asr     r0,r7,1Ah
080315D2 0803     lsr     r3,r0,20h
080315D4 16F4     asr     r4,r6,1Bh
080315D6 0803     lsr     r3,r0,20h
080315D8 16C0     asr     r0,r0,1Bh
080315DA 0803     lsr     r3,r0,20h
080315DC 16F4     asr     r4,r6,1Bh
080315DE 0803     lsr     r3,r0,20h
080315E0 16C8     asr     r0,r1,1Bh
080315E2 0803     lsr     r3,r0,20h
080315E4 16F4     asr     r4,r6,1Bh
080315E6 0803     lsr     r3,r0,20h
080315E8 16D0     asr     r0,r2,1Bh
080315EA 0803     lsr     r3,r0,20h
080315EC 16D8     asr     r0,r3,1Bh
080315EE 0803     lsr     r3,r0,20h
080315F0 16E0     asr     r0,r4,1Bh
080315F2 0803     lsr     r3,r0,20h
080315F4 16F4     asr     r4,r6,1Bh
080315F6 0803     lsr     r3,r0,20h
080315F8 16F4     asr     r4,r6,1Bh
080315FA 0803     lsr     r3,r0,20h
080315FC 16F4     asr     r4,r6,1Bh
080315FE 0803     lsr     r3,r0,20h
08031600 16F4     asr     r4,r6,1Bh
08031602 0803     lsr     r3,r0,20h
08031604 16F4     asr     r4,r6,1Bh
08031606 0803     lsr     r3,r0,20h
08031608 16F4     asr     r4,r6,1Bh
0803160A 0803     lsr     r3,r0,20h
0803160C 16F4     asr     r4,r6,1Bh
0803160E 0803     lsr     r3,r0,20h
08031610 16F4     asr     r4,r6,1Bh
08031612 0803     lsr     r3,r0,20h
08031614 16F4     asr     r4,r6,1Bh
08031616 0803     lsr     r3,r0,20h
08031618 16F4     asr     r4,r6,1Bh
0803161A 0803     lsr     r3,r0,20h
0803161C 16F4     asr     r4,r6,1Bh
0803161E 0803     lsr     r3,r0,20h
08031620 16F4     asr     r4,r6,1Bh
08031622 0803     lsr     r3,r0,20h
08031624 16F4     asr     r4,r6,1Bh
08031626 0803     lsr     r3,r0,20h
08031628 16F4     asr     r4,r6,1Bh
0803162A 0803     lsr     r3,r0,20h
0803162C 16F4     asr     r4,r6,1Bh
0803162E 0803     lsr     r3,r0,20h
08031630 16F4     asr     r4,r6,1Bh
08031632 0803     lsr     r3,r0,20h
08031634 16F4     asr     r4,r6,1Bh
08031636 0803     lsr     r3,r0,20h
08031638 16F4     asr     r4,r6,1Bh
0803163A 0803     lsr     r3,r0,20h
0803163C 16F4     asr     r4,r6,1Bh
0803163E 0803     lsr     r3,r0,20h
08031640 16F4     asr     r4,r6,1Bh
08031642 0803     lsr     r3,r0,20h
08031644 16E8     asr     r0,r5,1Bh
08031646 0803     lsr     r3,r0,20h
08031648 16F4     asr     r4,r6,1Bh
0803164A 0803     lsr     r3,r0,20h
0803164C 16F4     asr     r4,r6,1Bh
0803164E 0803     lsr     r3,r0,20h
08031650 16F4     asr     r4,r6,1Bh
08031652 0803     lsr     r3,r0,20h
08031654 16F4     asr     r4,r6,1Bh
08031656 0803     lsr     r3,r0,20h
08031658 16EE     asr     r6,r5,1Bh
0803165A 0803     lsr     r3,r0,20h
0803165C 1C20     mov     r0,r4
0803165E F7FEFC71 bl      802FF44h
08031662 E047     b       80316F4h
08031664 1C20     mov     r0,r4
08031666 F7FFF931 bl      80308CCh
0803166A 1C20     mov     r0,r4
0803166C F7FFF956 bl      803091Ch
08031670 E040     b       80316F4h
08031672 1C20     mov     r0,r4
08031674 F7FFFAF0 bl      8030C58h
08031678 1C20     mov     r0,r4
0803167A F7FFFAFB bl      8030C74h
0803167E E039     b       80316F4h
08031680 1C20     mov     r0,r4
08031682 F7FFFB09 bl      8030C98h
08031686 E035     b       80316F4h
08031688 1C20     mov     r0,r4
0803168A F7FFFB13 bl      8030CB4h
0803168E 1C20     mov     r0,r4
08031690 F7FFFB20 bl      8030CD4h
08031694 E02E     b       80316F4h
08031696 1C20     mov     r0,r4
08031698 F7FFFB6C bl      8030D74h
0803169C 1C20     mov     r0,r4
0803169E F7FFFB71 bl      8030D84h
080316A2 E027     b       80316F4h
080316A4 1C20     mov     r0,r4
080316A6 F7FEFCE3 bl      8030070h
080316AA 1C20     mov     r0,r4
080316AC F7FEFD28 bl      8030100h
080316B0 E020     b       80316F4h
080316B2 1C20     mov     r0,r4
080316B4 F7FEFDEC bl      8030290h
080316B8 1C20     mov     r0,r4
080316BA F7FEFE01 bl      80302C0h
080316BE E019     b       80316F4h
080316C0 1C20     mov     r0,r4
080316C2 F7FEFEA1 bl      8030408h
080316C6 E015     b       80316F4h
080316C8 1C20     mov     r0,r4
080316CA F7FEFF7F bl      80305CCh
080316CE E011     b       80316F4h
080316D0 1C20     mov     r0,r4
080316D2 F7FFF835 bl      8030740h
080316D6 E00D     b       80316F4h
080316D8 1C20     mov     r0,r4
080316DA F7FFFBEB bl      8030EB4h
080316DE E009     b       80316F4h
080316E0 1C20     mov     r0,r4
080316E2 F7FFFC33 bl      8030F4Ch
080316E6 E005     b       80316F4h
080316E8 1C20     mov     r0,r4
080316EA F7FFFB85 bl      8030DF8h
080316EE 1C20     mov     r0,r4
080316F0 F7FFFBA0 bl      8030E34h
080316F4 8821     ldrh    r1,[r4]
080316F6 4803     ldr     r0,=0F7FFh
080316F8 4008     and     r0,r1
080316FA 8020     strh    r0,[r4]
080316FC BC10     pop     r4
080316FE BC01     pop     r0
.pool