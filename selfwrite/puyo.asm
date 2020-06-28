/////////////////////////////////////////////////
;pose 00
0804B664 B510     push    r4,lr
0804B666 F7C7F8D7 bl      8012818h   ;AI一般都调用,未知
0804B66A 4A09     ldr     r2,=30006BCh
0804B66C 1C10     mov     r0,r2
0804B66E 3034     add     r0,34h
0804B670 7801     ldrb    r1,[r0]    ;读取碰撞属性零点32
0804B672 2002     mov     r0,2h
0804B674 4008     and     r0,r1
0804B676 2800     cmp     r0,0h
0804B678 D00C     beq     @@NoHitOrHidden
0804B67A 8811     ldrh    r1,[r2]
0804B67C 2080     mov     r0,80h
0804B67E 0180     lsl     r0,r0,6h
0804B680 4008     and     r0,r1      ;取向and2000
0804B682 0400     lsl     r0,r0,10h
0804B684 0C00     lsr     r0,r0,10h
0804B686 2800     cmp     r0,0h
0804B688 D104     bne     @@NoHitOrHidden
0804B68A 8010     strh    r0,[r2]
0804B68C E03C     b       @@end

@@NoHitOrHidden:
0804B694 F7C5FF52 bl      801153Ch    ;未知例程
0804B698 4816     ldr     r0,=30006BCh
0804B69A 4684     mov     r12,r0
0804B69C 3027     add     r0,27h
0804B69E 2300     mov     r3,0h
0804B6A0 2110     mov     r1,10h
0804B6A2 7001     strb    r1,[r0]     ;上视界
0804B6A4 4660     mov     r0,r12
0804B6A6 3028     add     r0,28h
0804B6A8 7003     strb    r3,[r0]     ;左右视界
0804B6AA 3001     add     r0,1h
0804B6AC 7001     strb    r1,[r0]     ;下视界
0804B6AE 2200     mov     r2,0h
0804B6B0 4911     ldr     r1,=0FFE0h
0804B6B2 4664     mov     r4,r12
0804B6B4 8161     strh    r1,[r4,0Ah] ;上分界
0804B6B6 2004     mov     r0,4h
0804B6B8 81A0     strh    r0,[r4,0Ch] ;下分界
0804B6BA 81E1     strh    r1,[r4,0Eh] ;左分界
0804B6BC 2020     mov     r0,20h
0804B6BE 8220     strh    r0,[r4,10h] ;右分界
0804B6C0 480E     ldr     r0,=837CE44h ;remove
0804B6C2 61A0     str     r0,[r4,18h]
0804B6C4 7722     strb    r2,[r4,1Ch]
0804B6C6 82E3     strh    r3,[r4,16h]
0804B6C8 4A0D     ldr     r2,=82E4D4Ch ;精灵基本数据起始
0804B6CA 7F61     ldrb    r1,[r4,1Dh]
0804B6CC 00C8     lsl     r0,r1,3h
0804B6CE 1A40     sub     r0,r0,r1
0804B6D0 0040     lsl     r0,r0,1h
0804B6D2 1880     add     r0,r0,r2
0804B6D4 8800     ldrh    r0,[r0]      ;读取设定血量写入
0804B6D6 82A0     strh    r0,[r4,14h]
0804B6D8 4661     mov     r1,r12
0804B6DA 3125     add     r1,25h
0804B6DC 2002     mov     r0,2h
0804B6DE 7008     strb    r0,[r1]      ;属性写入2
0804B6E0 3901     sub     r1,1h
0804B6E2 7808     ldrb    r0,[r1]      ;读取pose
0804B6E4 2859     cmp     r0,59h
0804B6E6 D10D     bne     @@Pass
0804B6E8 205A     mov     r0,5Ah       ;似乎是X?
0804B6EA 7008     strb    r0,[r1]
0804B6EC 202C     mov     r0,2Ch
0804B6EE 80E0     strh    r0,[r4,6h]   ;计数
0804B6F0 E00A     b       @@end

@@Pass:
0804B704 2001     mov     r0,1h
0804B706 7008     strb    r0,[r1]

@@end:
0804B708 BC10     pop     r4
0804B70A BC01     pop     r0
0804B70C 4700     bx      r0

////////////////////////////////////////////////
;pose 15h
0804B710 4B06     ldr     r3,=30006BCh
0804B712 1C1A     mov     r2,r3
0804B714 3224     add     r2,24h
0804B716 2100     mov     r1,0h
0804B718 2016     mov     r0,16h
0804B71A 7010     strb    r0,[r2]    ;pose写入16h
0804B71C 1C18     mov     r0,r3
0804B71E 3031     add     r0,31h
0804B720 7001     strb    r1,[r0]    ;计数器清零
0804B722 4803     ldr     r0,=837CE44h  ;remove
0804B724 6198     str     r0,[r3,18h]
0804B726 7719     strb    r1,[r3,1Ch]
0804B728 82D9     strh    r1,[r3,16h]
0804B72A 4770     bx      r14
.pool
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 01
0804B734 4905     ldr     r1,=30006BCh
0804B736 1C0A     mov     r2,r1
0804B738 3224     add     r2,24h
0804B73A 2300     mov     r3,0h
0804B73C 2002     mov     r0,2h
0804B73E 7010     strb    r0,[r2]     ;pose写入2h
0804B740 4803     ldr     r0,=837CE6Ch  ;move
0804B742 6188     str     r0,[r1,18h]
0804B744 770B     strb    r3,[r1,1Ch]
0804B746 82CB     strh    r3,[r1,16h]
0804B748 4770     bx      r14
.pool
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 02

0804B754 B570     push    r4-r6,lr
0804B756 490F     ldr     r1,=30006BCh
0804B758 880A     ldrh    r2,[r1]    ;取向and2000
0804B75A 2080     mov     r0,80h
0804B75C 0180     lsl     r0,r0,6h
0804B75E 4010     and     r0,r2
0804B760 2800     cmp     r0,0h
0804B762 D000     beq     @@NoDeath    ;可能吧
0804B764 E096     b       @@end

@@NoDeath:
0804B766 8AC8     ldrh    r0,[r1,16h]  ;读取精灵动画
0804B768 2800     cmp     r0,0h
0804B76A D109     bne     @@NoPlaySound
0804B76C 7F08     ldrb    r0,[r1,1Ch]  ;读取精灵动画帧
0804B76E 2801     cmp     r0,1h
0804B770 D106     bne     @@NoPlaySound
0804B772 2002     mov     r0,2h
0804B774 4010     and     r0,r2
0804B776 2800     cmp     r0,0h        ;检查是否在屏幕
0804B778 D002     beq     @@NoPlaySound
0804B77A 4807     ldr     r0,=1C3h
0804B77C F7B7F86A bl      8002854h     ;播放声音

@@NoPlaySound:
0804B780 F7C5FD8C bl      801129Ch     ;未知例程 检查下方是否有砖?
0804B784 4805     ldr     r0,=30007A4h
0804B786 7800     ldrb    r0,[r0]
0804B788 2800     cmp     r0,0h
0804B78A D109     bne     @@OnFloor
0804B78C 4801     ldr     r0,=30006BCh
0804B78E 3024     add     r0,24h
0804B790 2115     mov     r1,15h       ;pose写入下落的pose
0804B792 E07E     b       @@WillEnd

@@OnFloor:
0804B7A0 4C0A     ldr     r4,=30006BCh
0804B7A2 8821     ldrh    r1,[r4]
0804B7A4 2640     mov     r6,40h
0804B7A6 2040     mov     r0,40h
0804B7A8 4008     and     r0,r1
0804B7AA 2800     cmp     r0,0h
0804B7AC D012     beq     @@FaceLeft
0804B7AE 8860     ldrh    r0,[r4,2h]
0804B7B0 88A1     ldrh    r1,[r4,4h]
0804B7B2 3140     add     r1,40h      ;检查右边一格是否有砖,脚下?
0804B7B4 F7C5FDEC bl      8011390h    ;检查砖块
0804B7B8 4D05     ldr     r5,=30007A5h
0804B7BA 7828     ldrb    r0,[r5]
0804B7BC 2800     cmp     r0,0h
0804B7BE D01D     beq     @@NoBlock
0804B7C0 8860     ldrh    r0,[r4,2h]
0804B7C2 3810     sub     r0,10h
0804B7C4 88A1     ldrh    r1,[r4,4h]
0804B7C6 3140     add     r1,40h
0804B7C8 E011     b       @@CountCheck

@@FaceLeft:
0804B7D4 8860     ldrh    r0,[r4,2h]
0804B7D6 88A1     ldrh    r1,[r4,4h]
0804B7D8 3940     sub     r1,40h      ;检查身下左边一格有没有砖
0804B7DA F7C5FDD9 bl      8011390h
0804B7DE 4D0B     ldr     r5,=30007A5h
0804B7E0 7828     ldrb    r0,[r5]
0804B7E2 2800     cmp     r0,0h
0804B7E4 D00A     beq     @@NoBlock
0804B7E6 8860     ldrh    r0,[r4,2h]
0804B7E8 3810     sub     r0,10h
0804B7EA 88A1     ldrh    r1,[r4,4h]
0804B7EC 3940     sub     r1,40h

@@CountCheck:
0804B7EE F7C5FDCF bl      8011390h     ;检查左右一格是否有砖
0804B7F2 7829     ldrb    r1,[r5]
0804B7F4 200F     mov     r0,0Fh
0804B7F6 4008     and     r0,r1
0804B7F8 2800     cmp     r0,0h
0804B7FA D009     beq     @@NoBlock2

@@NoBlock:        ;脚下
0804B7FC 8820     ldrh    r0,[r4]
0804B7FE 4070     eor     r0,r6
0804B800 8020     strh    r0,[r4]     ;换向
0804B802 1C21     mov     r1,r4
0804B804 3124     add     r1,24h
0804B806 2007     mov     r0,7h
0804B808 7008     strb    r0,[r1]     ;pose 写入7
0804B80A E043     b       @@end

@@NoBlock2:       ;左右
0804B810 4904     ldr     r1,=30006BCh
0804B812 8ACA     ldrh    r2,[r1,16h]
0804B814 1F10     sub     r0,r2,4     ;动画减4
0804B816 0400     lsl     r0,r0,10h
0804B818 0C00     lsr     r0,r0,10h
0804B81A 1C0C     mov     r4,r1
0804B81C 2801     cmp     r0,1h       
0804B81E D803     bhi     @@AnimationLessSix
0804B820 2304     mov     r3,4h
0804B822 E005     b       @@WriteMove


@@AnimationLessSix:
0804B828 2300     mov     r3,0h
0804B82A 2A03     cmp     r2,3h
0804B82C D100     bne     @@WriteMove
0804B82E 2308     mov     r3,8h

@@WriteMove:
0804B830 8821     ldrh    r1,[r4]     ;读取取向
0804B832 2040     mov     r0,40h
0804B834 4008     and     r0,r1
0804B836 2800     cmp     r0,0h     
0804B838 D002     beq     @@MoveLeft
0804B83A 88A0     ldrh    r0,[r4,4h]
0804B83C 1818     add     r0,r3,r0
0804B83E E001     b       @@WriteNewPosition

@@MoveLeft:
0804B840 88A0     ldrh    r0,[r4,4h]
0804B842 1AC0     sub     r0,r0,r3

@@WriteNewPosition:
0804B844 80A0     strh    r0,[r4,4h]
0804B846 F7C6F891 bl      801196Ch    ;检查动画是否结束
0804B84A 2800     cmp     r0,0h
0804B84C D022     beq     @@end
0804B84E 21C0     mov     r1,0C0h
0804B850 0049     lsl     r1,r1,1h
0804B852 1C08     mov     r0,r1
0804B854 F7C6F966 bl      8011B24h    ;检查精灵与samus的位置,范围中
0804B858 2804     cmp     r0,4h
0804B85A D109     bne     @@SamusNoAtLeft
0804B85C 4902     ldr     r1,=30006BCh
0804B85E 880A     ldrh    r2,[r1]
0804B860 4802     ldr     r0,=0FFBFh   ;去掉向右的面向
0804B862 4010     and     r0,r2
0804B864 E00A     b       @@WritePose

@@SamusNoAtLeft;
0804B870 2808     cmp     r0,8h
0804B872 D10B     bne     @@SamusNoNear
0804B874 4904     ldr     r1,=30006BCh
0804B876 880A     ldrh    r2,[r1]
0804B878 2040     mov     r0,40h
0804B87A 4310     orr     r0,r2       ;面向右

@@WritePose:
0804B87C 8008     strh    r0,[r1]
0804B87E 3124     add     r1,24h
0804B880 2029     mov     r0,29h
0804B882 7008     strb    r0,[r1]     ;pose写入29h
0804B884 E006     b       @@end

@@SamusNoNear:
0804B88C 4803     ldr     r0,=30006BCh
0804B88E 3024     add     r0,24h
0804B890 2107     mov     r1,7h       ;pose写入7

@@WillEnd:
0804B892 7001     strb    r1,[r0]     

@@end:
0804B894 BC70     pop     r4-r6
0804B896 BC01     pop     r0
0804B898 4700     bx      r0

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 07

0804B8A0 4908     ldr     r1,=30006BCh
0804B8A2 1C0B     mov     r3,r1
0804B8A4 3324     add     r3,24h
0804B8A6 2200     mov     r2,0h
0804B8A8 2008     mov     r0,8h
0804B8AA 7018     strb    r0,[r3]       ;pose写入8h
0804B8AC 770A     strb    r2,[r1,1Ch]
0804B8AE 82CA     strh    r2,[r1,16h]
0804B8B0 4805     ldr     r0,=837CE44h  ;remove
0804B8B2 6188     str     r0,[r1,18h]
0804B8B4 4805     ldr     r0,=30007F0h  ;随机值
0804B8B6 7800     ldrb    r0,[r0]
0804B8B8 0880     lsr     r0,r0,2h      ;乘4加1
0804B8BA 3001     add     r0,1h
0804B8BC 312E     add     r1,2Eh
0804B8BE 7008     strb    r0,[r1]       ;写入2E偏移
0804B8C0 4770     bx      r14

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 8

0804B8D0 B500     push    lr
0804B8D2 F7C5FCE3 bl      801129Ch      ;检查上下砖块?
0804B8D6 4804     ldr     r0,=30007A4h
0804B8D8 7800     ldrb    r0,[r0]
0804B8DA 2800     cmp     r0,0h
0804B8DC D108     bne     @@OnFloor
0804B8DE 4803     ldr     r0,=30006BCh
0804B8E0 3024     add     r0,24h
0804B8E2 2115     mov     r1,15h
0804B8E4 7001     strb    r1,[r0]       ;pose写入15  下落
0804B8E6 E019     b       @@end

@@OnFloor:
0804B8F0 F7C6F820 bl      8011934h      ;检查动画
0804B8F4 2800     cmp     r0,0h
0804B8F6 D011     beq     @@end
0804B8F8 4B09     ldr     r3,=30006BCh
0804B8FA 1C19     mov     r1,r3
0804B8FC 312E     add     r1,2Eh
0804B8FE 7808     ldrb    r0,[r1]       ;读取随机数设定的值
0804B900 3801     sub     r0,1h
0804B902 7008     strb    r0,[r1]       ;减一再写入
0804B904 0600     lsl     r0,r0,18h
0804B906 0E02     lsr     r2,r0,18h
0804B908 2A00     cmp     r2,0h
0804B90A D107     bne     @@end
0804B90C 1C18     mov     r0,r3
0804B90E 3024     add     r0,24h
0804B910 2102     mov     r1,2h         ;计数器为0的时候
0804B912 7001     strb    r1,[r0]       ;pose写入2h
0804B914 4803     ldr     r0,=837CE6Ch  ;move
0804B916 6198     str     r0,[r3,18h]
0804B918 771A     strb    r2,[r3,1Ch]
0804B91A 82DA     strh    r2,[r3,16h]

@@end:
0804B91C BC01     pop     r0
0804B91E 4700     bx      r0

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 29h

0804B928 4905     ldr     r1,=30006BCh
0804B92A 1C0B     mov     r3,r1
0804B92C 3324     add     r3,24h
0804B92E 2200     mov     r2,0h
0804B930 202A     mov     r0,2Ah
0804B932 7018     strb    r0,[r3]        ;pose写入2ah
0804B934 770A     strb    r2,[r1,1Ch]
0804B936 82CA     strh    r2,[r1,16h]
0804B938 4802     ldr     r0,=837CEA4h   ;rejump
0804B93A 6188     str     r0,[r1,18h]
0804B93C 4770     bx      r14

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 2ah

0804B948 B500     push    lr
0804B94A F7C5FFF3 bl      8011934h       ;检查动画
0804B94E 2800     cmp     r0,0h
0804B950 D016     beq     @@end
0804B952 4B0C     ldr     r3,=30006BCh
0804B954 1C19     mov     r1,r3
0804B956 3124     add     r1,24h
0804B958 2200     mov     r2,0h
0804B95A 202C     mov     r0,2Ch
0804B95C 7008     strb    r0,[r1]        ;pose 写入2c  跳跃
0804B95E 771A     strb    r2,[r3,1Ch]
0804B960 2100     mov     r1,0h
0804B962 82DA     strh    r2,[r3,16h]
0804B964 4808     ldr     r0,=837CEC4h   ;jump
0804B966 6198     str     r0,[r3,18h]
0804B968 1C18     mov     r0,r3
0804B96A 3031     add     r0,31h
0804B96C 7001     strb    r1,[r0]        ;偏移31清零
0804B96E 8819     ldrh    r1,[r3]
0804B970 2002     mov     r0,2h
0804B972 4008     and     r0,r1
0804B974 2800     cmp     r0,0h
0804B976 D003     beq     @@end
0804B978 20E2     mov     r0,0E2h
0804B97A 0040     lsl     r0,r0,1h
0804B97C F7B6FF6A bl      8002854h       ;播放跳跃声

@@end:
0804B980 BC01     pop     r0
0804B982 4700     bx      r0

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 2Ch   跳跃
0804B98C B5F0     push    r4-r7,lr
0804B98E 4C09     ldr     r4,=30006BCh
0804B990 8860     ldrh    r0,[r4,2h]
0804B992 3820     sub     r0,20h
0804B994 88A1     ldrh    r1,[r4,4h]     ;检查上方是否有砖?
0804B996 F7C5FCFB bl      8011390h
0804B99A 4807     ldr     r0,=30007A5h
0804B99C 7800     ldrb    r0,[r0]
0804B99E 2811     cmp     r0,11h
0804B9A0 D10C     bne     @@NoBlock
0804B9A2 1C21     mov     r1,r4
0804B9A4 3124     add     r1,24h
0804B9A6 2200     mov     r2,0h
0804B9A8 202E     mov     r0,2Eh         ;pose 写入2Eh 落?
0804B9AA 7008     strb    r0,[r1]
0804B9AC 1C20     mov     r0,r4
0804B9AE 3031     add     r0,31h
0804B9B0 7002     strb    r2,[r0]        ;偏移31清零
0804B9B2 E072     b       @@end

@@NoBlock:
0804B9BC 1C23     mov     r3,r4
0804B9BE 3331     add     r3,31h
0804B9C0 7818     ldrb    r0,[r3]        ;读取偏移31的值
0804B9C2 281E     cmp     r0,1Eh
0804B9C4 D906     bls     @@JumPointless1F
0804B9C6 1C20     mov     r0,r4
0804B9C8 3024     add     r0,24h
0804B9CA 2200     mov     r2,0h
0804B9CC 212E     mov     r1,2Eh         ;大于1F的时候pose写入2Eh
0804B9CE 7001     strb    r1,[r0]
0804B9D0 701A     strb    r2,[r3]        ;同时偏移31归零
0804B9D2 E01A     b       @@PassYMove

@@JumPointless1F:
0804B9D4 781A     ldrb    r2,[r3]        ;读取偏移31的值
0804B9D6 4E08     ldr     r6,=837C578h   ;跳跃速度数值
0804B9D8 0050     lsl     r0,r2,1h
0804B9DA 1980     add     r0,r0,r6
0804B9DC 8805     ldrh    r5,[r0]        ;读取速度
0804B9DE 2700     mov     r7,0h
0804B9E0 5FC1     ldsh    r1,[r0,r7]     ;读取速度带负
0804B9E2 4806     ldr     r0,=7FFFh
0804B9E4 4281     cmp     r1,r0          ;比较是否到了尾端
0804B9E6 D10B     bne     @@SpeedValueNoEnd
0804B9E8 1E51     sub     r1,r2,1        ;跳跃累计值减1
0804B9EA 0049     lsl     r1,r1,1h       ;保持最大速度
0804B9EC 1989     add     r1,r1,r6       ;加上偏移
0804B9EE 8860     ldrh    r0,[r4,2h]     ;读取Y坐标
0804B9F0 8809     ldrh    r1,[r1]        ;读取速度
0804B9F2 1840     add     r0,r0,r1       ;下降的速度加入
0804B9F4 E008     b       @@WriteNewYPosition   ;写入新的Y坐标

@@SpeedValueNoEnd:
0804BA00 1C50     add     r0,r2,1        ;速度累计值加1
0804BA02 7018     strb    r0,[r3]        ;再写入
0804BA04 8860     ldrh    r0,[r4,2h]
0804BA06 1940     add     r0,r0,r5

@@WriteNewYPosition:
0804BA08 8060     strh    r0,[r4,2h]

@@PassYMove:
0804BA0A 2400     mov     r4,0h
0804BA0C 4A09     ldr     r2,=30006BCh
0804BA0E 8811     ldrh    r1,[r2]
0804BA10 2040     mov     r0,40h
0804BA12 4008     and     r0,r1
0804BA14 2800     cmp     r0,0h
0804BA16 D011     beq     @@MoveLeft
0804BA18 8850     ldrh    r0,[r2,2h]
0804BA1A 3808     sub     r0,8h         
0804BA1C 8891     ldrh    r1,[r2,4h]
0804BA1E 3140     add     r1,40h
0804BA20 F7C5FCB6 bl      8011390h      ;检查右边是否有砖块
0804BA24 4804     ldr     r0,=30007A5h
0804BA26 7800     ldrb    r0,[r0]       ;有砖一般为11
0804BA28 210F     mov     r1,0Fh
0804BA2A 4001     and     r1,r0         ;1h
0804BA2C 4248     neg     r0,r1
0804BA2E 4308     orr     r0,r1         ;FFFFFFFF?
0804BA30 0FC4     lsr     r4,r0,1Fh     ;只要7A5不为0都会为1
0804BA32 E010     b       @@CheckBlock

@@MoveLeft:                             ;检查左边是否有砖或者坡?
0804BA3C 8850     ldrh    r0,[r2,2h]
0804BA3E 3808     sub     r0,8h
0804BA40 8891     ldrh    r1,[r2,4h]
0804BA42 3940     sub     r1,40h
0804BA44 F7C5FCA4 bl      8011390h
0804BA48 480A     ldr     r0,=30007A5h
0804BA4A 7801     ldrb    r1,[r0]
0804BA4C 200F     mov     r0,0Fh
0804BA4E 4008     and     r0,r1
0804BA50 2800     cmp     r0,0h
0804BA52 D000     beq     @@CheckBlock
0804BA54 2401     mov     r4,1h

@@CheckBlock:
0804BA56 2C00     cmp     r4,0h
0804BA58 D010     beq     @@NoBlock
0804BA5A 4A07     ldr     r2,=30006BCh
0804BA5C 8810     ldrh    r0,[r2]
0804BA5E 2140     mov     r1,40h
0804BA60 4048     eor     r0,r1      ;面向取反再写入
0804BA62 2300     mov     r3,0h
0804BA64 8010     strh    r0,[r2]
0804BA66 1C11     mov     r1,r2
0804BA68 3124     add     r1,24h
0804BA6A 202E     mov     r0,2Eh     ;pose写入2Eh
0804BA6C 7008     strb    r0,[r1]
0804BA6E 3231     add     r2,31h
0804BA70 7013     strb    r3,[r2]    ;偏移31清零 
0804BA72 E012     b       804BA9Ah

@@NoBlock:
0804BA7C 4A04     ldr     r2,=30006BCh
0804BA7E 8811     ldrh    r1,[r2]
0804BA80 2040     mov     r0,40h
0804BA82 4008     and     r0,r1
0804BA84 2800     cmp     r0,0h
0804BA86 D005     beq     @@LeftMove
0804BA88 8890     ldrh    r0,[r2,4h]
0804BA8A 3002     add     r0,2h      ;X向右2
0804BA8C E004     b       @@WriteNewXPostion

@@LeftMove:
0804BA94 8890     ldrh    r0,[r2,4h]
0804BA96 3802     sub     r0,2h      ;X向左2

@@WriteNewXPostion
0804BA98 8090     strh    r0,[r2,4h]

@@end:
0804BA9A BCF0     pop     r4-r7
0804BA9C BC01     pop     r0
0804BA9E 4700     bx      r0

///////////////////////////////////////////////////////////////
;pose 2e

0804BAA0 B570     push    r4-r6,lr
0804BAA2 4C0F     ldr     r4,=30006BCh
0804BAA4 8860     ldrh    r0,[r4,2h]
0804BAA6 88A1     ldrh    r1,[r4,4h]
0804BAA8 F7C5FB64 bl      8011174h               ;检查身下砖块??
0804BAAC 1C01     mov     r1,r0
0804BAAE 480D     ldr     r0,=30007A4h
0804BAB0 7800     ldrb    r0,[r0]
0804BAB2 2800     cmp     r0,0h
0804BAB4 D01C     beq     @@AtAir
0804BAB6 2200     mov     r2,0h
0804BAB8 2300     mov     r3,0h
0804BABA 8061     strh    r1,[r4,2h]             ;坐标在地面上????
0804BABC 1C21     mov     r1,r4
0804BABE 3124     add     r1,24h
0804BAC0 2030     mov     r0,30h
0804BAC2 7008     strb    r0,[r1]                ;pose写入30
0804BAC4 7722     strb    r2,[r4,1Ch]   
0804BAC6 82E3     strh    r3,[r4,16h]
0804BAC8 4807     ldr     r0,=837CED4h           ;地面常态
0804BACA 61A0     str     r0,[r4,18h]
0804BACC 8821     ldrh    r1,[r4]
0804BACE 2002     mov     r0,2h
0804BAD0 4008     and     r0,r1
0804BAD2 2800     cmp     r0,0h
0804BAD4 D02A     beq     @@NoPlaySound
0804BAD6 4805     ldr     r0,=1C5h
0804BAD8 F7B6FEBC bl      8002854h               ;播放落地声音?
0804BADC E026     b       @@NoPlaySound

@@AtAir:
0804BAF0 2031     mov     r0,31h
0804BAF2 1900     add     r0,r0,r4
0804BAF4 4684     mov     r12,r0
0804BAF6 7802     ldrb    r2,[r0]               ;读取偏移31的值
0804BAF8 4D07     ldr     r5,=837C5B8h          ;掉落的速度值
0804BAFA 0050     lsl     r0,r2,1h
0804BAFC 1940     add     r0,r0,r5
0804BAFE 8803     ldrh    r3,[r0]               ;读取速度
0804BB00 2600     mov     r6,0h
0804BB02 5F81     ldsh    r1,[r0,r6]
0804BB04 4805     ldr     r0,=7FFFh             ;比较是否到了尾数
0804BB06 4281     cmp     r1,r0
0804BB08 D10A     bne     @@DropSpeedNoEnd
0804BB0A 1E51     sub     r1,r2,1
0804BB0C 0049     lsl     r1,r1,1h
0804BB0E 1949     add     r1,r1,r5
0804BB10 8860     ldrh    r0,[r4,2h]            ;读取Y坐标
0804BB12 8809     ldrh    r1,[r1]               ;读取之前的速度值
0804BB14 1840     add     r0,r0,r1              ;相加
0804BB16 E008     b       @@WriteNewDropPostion

@@DropSpeedNoEnd:
0804BB20 1C50     add     r0,r2,1
0804BB22 4661     mov     r1,r12
0804BB24 7008     strb    r0,[r1]               ;累计值加一再写入
0804BB26 8860     ldrh    r0,[r4,2h]            ;读取Y坐标加上当前的速度值
0804BB28 18C0     add     r0,r0,r3

@@WriteNewDropPostion:
0804BB2A 8060     strh    r0,[r4,2h]

@@NoPlaySound:
0804BB2C 2400     mov     r4,0h
0804BB2E 4A0A     ldr     r2,=30006BCh
0804BB30 8811     ldrh    r1,[r2]
0804BB32 2040     mov     r0,40h
0804BB34 4008     and     r0,r1
0804BB36 2800     cmp     r0,0h
0804BB38 D012     beq     @@FaceLeft
0804BB3A 8850     ldrh    r0,[r2,2h]
0804BB3C 3808     sub     r0,8h
0804BB3E 8891     ldrh    r1,[r2,4h]
0804BB40 3140     add     r1,40h               ;检查右边的砖块
0804BB42 F7C5FC25 bl      8011390h
0804BB46 4805     ldr     r0,=30007A5h
0804BB48 7800     ldrb    r0,[r0]
0804BB4A 210F     mov     r1,0Fh
0804BB4C 4001     and     r1,r0
0804BB4E 4248     neg     r0,r1
0804BB50 4308     orr     r0,r1
0804BB52 0FC4     lsr     r4,r0,1Fh
0804BB54 E011     b       @@CheckBlock

@@FaceLeft:
0804BB60 8850     ldrh    r0,[r2,2h]
0804BB62 3808     sub     r0,8h
0804BB64 8891     ldrh    r1,[r2,4h]
0804BB66 3940     sub     r1,40h
0804BB68 F7C5FC12 bl      8011390h
0804BB6C 480A     ldr     r0,=30007A5h
0804BB6E 7801     ldrb    r1,[r0]
0804BB70 200F     mov     r0,0Fh
0804BB72 4008     and     r0,r1
0804BB74 2800     cmp     r0,0h
0804BB76 D000     beq     @@CheckBlock
0804BB78 2401     mov     r4,1h

@@CheckBlock:
0804BB7A 4A08     ldr     r2,=30006BCh
0804BB7C 2C00     cmp     r4,0h
0804BB7E D003     beq     @@NoBlock
0804BB80 8810     ldrh    r0,[r2]
0804BB82 2140     mov     r1,40h
0804BB84 4048     eor     r0,r1       ;换面
0804BB86 8010     strh    r0,[r2]

@@NoBlock:
0804BB88 8811     ldrh    r1,[r2]     ;读取取向
0804BB8A 2040     mov     r0,40h
0804BB8C 4008     and     r0,r1
0804BB8E 2800     cmp     r0,0h
0804BB90 D006     beq     @@LeftDropMove
0804BB92 8890     ldrh    r0,[r2,4h]
0804BB94 3002     add     r0,2h       ;X坐标向右2
0804BB96 E005     b       @@WriteDropXNewPostion

@@LeftDropMove:
0804BBA0 8890     ldrh    r0,[r2,4h]
0804BBA2 3802     sub     r0,2h

@@WriteDropXNewPostion:
0804BBA4 8090     strh    r0,[r2,4h]
0804BBA6 BC70     pop     r4-r6
0804BBA8 BC01     pop     r0
0804BBAA 4700     bx      r0

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;pose 30h
0804BBAC B500     push    lr
0804BBAE F7C5FEDD bl      801196Ch      ;检查动画结束
0804BBB2 2800     cmp     r0,0h
0804BBB4 D003     beq     @@end
0804BBB6 4803     ldr     r0,=30006BCh
0804BBB8 3024     add     r0,24h
0804BBBA 2107     mov     r1,7h         ;pose写入7h
0804BBBC 7001     strb    r1,[r0]

@@end:
0804BBBE BC01     pop     r0
0804BBC0 4700     bx      r0

//////////////////////////////////////////////////////////////////
;主程序
0804BBC8 B510     push    r4,lr
0804BBCA 4C0A     ldr     r4,=30006BCh
0804BBCC 1C20     mov     r0,r4
0804BBCE 302C     add     r0,2Ch
0804BBD0 7801     ldrb    r1,[r0]       ;检查是否被冻住的瞬间
0804BBD2 207F     mov     r0,7Fh
0804BBD4 4008     and     r0,r1
0804BBD6 2804     cmp     r0,4h
0804BBD8 D103     bne     @@NoFrozen
0804BBDA 20E3     mov     r0,0E3h
0804BBDC 0040     lsl     r0,r0,1h
0804BBDE F7B6FE39 bl      8002854h      ;播放冻住的声音

@@NoFrozen:
0804BBE2 1C20     mov     r0,r4
0804BBE4 3032     add     r0,32h
0804BBE6 7800     ldrb    r0,[r0]       ;读取冰冻时间零点为30
0804BBE8 2800     cmp     r0,0h
0804BBEA D005     beq     @@NoFrozening
0804BBEC F7C6F92A bl      8011E44h      ;冰冻例程?
0804BBF0 E0F8     b       @Thend


@@NoFrozening:
0804BBF8 1C20     mov     r0,r4
0804BBFA 3024     add     r0,24h
0804BBFC 7800     ldrb    r0,[r0]
0804BBFE 285B     cmp     r0,5Bh
0804BC00 D900     bls     @@NoDeath     ;检查姿势是否小于5B
0804BC02 E0EF     b       @Thend

@@NoDeath:
0804BC04 0080     lsl     r0,r0,2h
0804BC06 4902     ldr     r1,=804BC14h
0804BC08 1840     add     r0,r0,r1
0804BC0A 6800     ldr     r0,[r0]
0804BC0C 4687     mov     r15,r0

PoseTable:
    .word 804BD84h  ;00
    .word 804BD8Ah  ;01
    .word 804BD8Eh  ;02
    .word @Thend,@Thend,@Thend,@Thend
    .word 804BD94h  ;07 
    .word 804BD98h  ;08
    .word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word 804BDBAh  ;15h
	.word 804BDBEh  ;16h
    .word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend
    .word 804BD9Eh  ;29h
	.word 804BDA2h  ;2Ah
    .word @Thend  
    .word 804BDA8h  ;2Ch
	.word @Thend  
    .word 804BDAEh  ;2Eh
	.word @Thend
    .word 804BDB4h  ;30h
    .word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend,@Thend,@Thend
	.word @Thend,@Thend
	.word 804BDC4h  ;57h
	.word 804BDC8h  ;58h
	.word 804BDCEh  ;59h
	.word 804BDD2h  ;5Ah
	.word 804BDD8h  ;5Bh

0804BD84 F7FFFC6E bl      804B664h  ;00
0804BD88 E02C     b       @Thend
0804BD8A F7FFFCD3 bl      804B734h  ;01
0804BD8E F7FFFCE1 bl      804B754h  ;02  移动
0804BD92 E027     b       @Thend
0804BD94 F7FFFD84 bl      804B8A0h  ;07
0804BD98 F7FFFD9A bl      804B8D0h  ;08  准备移动
0804BD9C E022     b       @Thend
0804BD9E F7FFFDC3 bl      804B928h  ;29h 准备跳跃
0804BDA2 F7FFFDD1 bl      804B948h  ;2Ah
0804BDA6 E01D     b       @Thend
0804BDA8 F7FFFDF0 bl      804B98Ch  ;2Ch 跳跃
0804BDAC E01A     b       @Thend
0804BDAE F7FFFE77 bl      804BAA0h  ;2Eh 落
0804BDB2 E017     b       @Thend
0804BDB4 F7FFFEFA bl      804BBACh  ;30h 常态
0804BDB8 E014     b       @Thend
0804BDBA F7FFFCA9 bl      804B710h  ;15h
0804BDBE F7C5FB33 bl      8011428h  ;16h 掉落
0804BDC2 E00F     b       @Thend
0804BDC4 F015FC7C bl      80616C0h
0804BDC8 F015FC90 bl      80616ECh
0804BDCC E00A     b       @Thend
0804BDCE F7FFFC49 bl      804B664h
0804BDD2 F016FA7F bl      80622D4h
0804BDD6 E005     b       @Thend
0804BDD8 F015FDAE bl      8061938h
0804BDDC 4903     ldr     r1,=30006BCh
0804BDDE 8848     ldrh    r0,[r1,2h]
0804BDE0 3820     sub     r0,20h
0804BDE2 8048     strh    r0,[r1,2h]

@Thend:
0804BDE4 BC10     pop     r4
0804BDE6 BC01     pop     r0
0804BDE8 4700     bx      r0



08011428 B570     push    r4-r6,lr
0801142A 4C08     ldr     r4,=30006BCh
0801142C 8860     ldrh    r0,[r4,2h]
0801142E 88A1     ldrh    r1,[r4,4h]
08011430 F7FFFEA0 bl      8011174h
08011434 1C01     mov     r1,r0
08011436 4806     ldr     r0,=30007A4h
08011438 7800     ldrb    r0,[r0]
0801143A 2800     cmp     r0,0h
0801143C D00A     beq     8011454h
0801143E 8061     strh    r1,[r4,2h]
08011440 1C21     mov     r1,r4
08011442 3124     add     r1,24h
08011444 2007     mov     r0,7h
08011446 7008     strb    r0,[r1]
08011448 E022     b       8011490h
0801144A 0000     lsl     r0,r0,0h
0801144C 06BC     lsl     r4,r7,1Ah
0801144E 0300     lsl     r0,r0,0Ch
08011450 07A4     lsl     r4,r4,1Eh
08011452 0300     lsl     r0,r0,0Ch
08011454 2031     mov     r0,31h
08011456 1900     add     r0,r0,r4
08011458 4684     mov     r12,r0
0801145A 7802     ldrb    r2,[r0]
0801145C 4D07     ldr     r5,=82E49E0h
0801145E 0050     lsl     r0,r2,1h
08011460 1940     add     r0,r0,r5
08011462 8803     ldrh    r3,[r0]
08011464 2600     mov     r6,0h
08011466 5F81     ldsh    r1,[r0,r6]
08011468 4805     ldr     r0,=7FFFh
0801146A 4281     cmp     r1,r0
0801146C D10A     bne     8011484h
0801146E 1E51     sub     r1,r2,1
08011470 0049     lsl     r1,r1,1h
08011472 1949     add     r1,r1,r5
08011474 8860     ldrh    r0,[r4,2h]
08011476 8809     ldrh    r1,[r1]
08011478 1840     add     r0,r0,r1
0801147A E008     b       801148Eh
0801147C 49E0     ldr     r1,=0E08D1A68h
0801147E 082E     lsr     r6,r5,20h
08011480 7FFF     ldrb    r7,[r7,1Fh]
08011482 0000     lsl     r0,r0,0h
08011484 1C50     add     r0,r2,1
08011486 4661     mov     r1,r12
08011488 7008     strb    r0,[r1]
0801148A 8860     ldrh    r0,[r4,2h]
0801148C 18C0     add     r0,r0,r3
0801148E 8060     strh    r0,[r4,2h]
08011490 BC70     pop     r4-r6
08011492 BC01     pop     r0
08011494 4700     bx      r0
