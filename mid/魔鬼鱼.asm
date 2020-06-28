////////////////////////////////////////////////////////
;pose 0
0803F5BC B530     push    r4,r5,lr
0803F5BE F7D3F92B bl      8012818h   ;融合某例程..
0803F5C2 4A09     ldr     r2,=30006BCh
0803F5C4 1C10     mov     r0,r2
0803F5C6 3034     add     r0,34h     ;碰撞属性 零点偏移32
0803F5C8 7801     ldrb    r1,[r0]
0803F5CA 2002     mov     r0,2h
0803F5CC 4008     and     r0,r1
0803F5CE 2800     cmp     r0,0h
0803F5D0 D00C     beq     @@NoHitOrDeath
0803F5D2 8811     ldrh    r1,[r2]
0803F5D4 2080     mov     r0,80h
0803F5D6 0180     lsl     r0,r0,6h
0803F5D8 4008     and     r0,r1      ;取向and 2000
0803F5DA 0400     lsl     r0,r0,10h
0803F5DC 0C00     lsr     r0,r0,10h
0803F5DE 2800     cmp     r0,0h      ;不为0则消灭精灵
0803F5E0 D104     bne     @@NoHitOrDeath
0803F5E2 8010     strh    r0,[r2]
0803F5E4 E034     b       @@end

@@NoHitOrDeath:
0803F5EC F7D1FFA6 bl      801153Ch   ;又是不知道什么例程...
0803F5F0 4D13     ldr     r5,=30006BCh
0803F5F2 1C28     mov     r0,r5
0803F5F4 3027     add     r0,27h
0803F5F6 2400     mov     r4,0h
0803F5F8 2210     mov     r2,10h
0803F5FA 7002     strb    r2,[r0]    ;上视野写入10
0803F5FC 1C29     mov     r1,r5
0803F5FE 3128     add     r1,28h
0803F600 2008     mov     r0,8h
0803F602 7008     strb    r0,[r1]    ;左右视野写入8h
0803F604 1C28     mov     r0,r5
0803F606 3029     add     r0,29h
0803F608 7002     strb    r2,[r0]    ;下视野写入10
0803F60A F7FFFFB7 bl      803F57Ch   ;融合未知例程
0803F60E 480D     ldr     r0,=83598FCh
0803F610 61A8     str     r0,[r5,18h] ;写入普通趴地面的OAM
0803F612 772C     strb    r4,[r5,1Ch]
0803F614 82EC     strh    r4,[r5,16h]
0803F616 4A0C     ldr     r2,=82E4D4Ch ;精灵基础数据起始
0803F618 7F69     ldrb    r1,[r5,1Dh]  ;读取ID
0803F61A 00C8     lsl     r0,r1,3h
0803F61C 1A40     sub     r0,r0,r1
0803F61E 0040     lsl     r0,r0,1h     ;ID的14倍,零点好像是18倍
0803F620 1880     add     r0,r0,r2
0803F622 8800     ldrh    r0,[r0]      ;读取设定血量
0803F624 82A8     strh    r0,[r5,14h]  ;写入当前血量
0803F626 1C29     mov     r1,r5
0803F628 3125     add     r1,25h
0803F62A 2002     mov     r0,2h
0803F62C 7008     strb    r0,[r1]      ;属性写入2h 零点应该是4
0803F62E 3901     sub     r1,1h
0803F630 7808     ldrb    r0,[r1]      ;读取pose值
0803F632 2859     cmp     r0,59h       ;不为变X的姿势????
0803F634 D10A     bne     @@NoX
0803F636 205A     mov     r0,5Ah
0803F638 7008     strb    r0,[r1]      ;pose写入5A
0803F63A 202C     mov     r0,2Ch
0803F63C 80E8     strh    r0,[r5,6h]   ;备用Y坐标写入2C 计数?
0803F63E E007     b       @@end

@@NoX:
0803F64C 2001     mov     r0,1h
0803F64E 7008     strb    r0,[r1]      ;pose写入1

@@end:
0803F650 BC30     pop     r4,r5
0803F652 BC01     pop     r0
0803F654 4700     bx      r0

//////////////////////////////////////////////////////////
;pose 1 用于落下后的返回
0803F658 4905     ldr     r1,=30006BCh
0803F65A 1C0B     mov     r3,r1
0803F65C 3324     add     r3,24h
0803F65E 2200     mov     r2,0h
0803F660 2002     mov     r0,2h
0803F662 7018     strb    r0,[r3]       ;pose写入2
0803F664 770A     strb    r2,[r1,1Ch]
0803F666 82CA     strh    r2,[r1,16h]
0803F668 4802     ldr     r0,=83598FCh
0803F66A 6188     str     r0,[r1,18h]   ;再次写入普通的趴地OAM
0803F66C 4770     bx      r14

//////////////////////////////////////////////////////////
;pose 2 常态循环
0803F678 B530     push    r4,r5,lr
0803F67A 4C17     ldr     r4,=30006BCh
0803F67C 8821     ldrh    r1,[r4]
0803F67E 2080     mov     r0,80h
0803F680 0180     lsl     r0,r0,6h
0803F682 4008     and     r0,r1         ;取向与2000and
0803F684 2800     cmp     r0,0h
0803F686 D124     bne     @@end
;---------------------------------------为0的话
0803F688 8860     ldrh    r0,[r4,2h]
0803F68A 88A1     ldrh    r1,[r4,4h]
0803F68C 3930     sub     r1,30h        ;头顶的坐标
0803F68E F7D1FE7F bl      8011390h      ;检查砖块
0803F692 4D12     ldr     r5,=30007A5h  ;类似零点的7F0
0803F694 7828     ldrb    r0,[r5]       
0803F696 2811     cmp     r0,11h
0803F698 D007     beq     @@TopHaveBlock
;---------------------------------------头顶无砖的话
0803F69A 8860     ldrh    r0,[r4,2h]    
0803F69C 88A1     ldrh    r1,[r4,4h]
0803F69E 3130     add     r1,30h        ;检查身下的砖块
0803F6A0 F7D1FE76 bl      8011390h
0803F6A4 7828     ldrb    r0,[r5]
0803F6A6 2811     cmp     r0,11h
0803F6A8 D10F     bne     @@BottomNoBlock

@@TopHaveBlock:
0803F6AA 480D     ldr     r0,=3001244h  ;类似零点的13d4
0803F6AC 8B00     ldrh    r0,[r0,18h]   ;读取samus的Y坐标
0803F6AE 3848     sub     r0,48h        ;向上48h
0803F6B0 4C09     ldr     r4,=30006BCh
0803F6B2 8861     ldrh    r1,[r4,2h]    ;精灵的Y坐标
0803F6B4 4288     cmp     r0,r1         ;samus向上48的坐标大于精灵坐标则结束
0803F6B6 DC0C     bgt     @@end
0803F6B8 20A0     mov     r0,0A0h
0803F6BA 0040     lsl     r0,r0,1h      ;140h
0803F6BC 2180     mov     r1,80h
0803F6BE 0049     lsl     r1,r1,1h      ;100h
0803F6C0 F7D2FA30 bl      8011B24h      ;检查范围?samus附近的精灵
0803F6C4 0600     lsl     r0,r0,18h
0803F6C6 2800     cmp     r0,0h         ;一旦进入范围精灵上升准备
0803F6C8 D003     beq     @@end

@@BottomNoBlock:
0803F6CA 1C21     mov     r1,r4
0803F6CC 3124     add     r1,24h    ;pose写入29 上升准备
0803F6CE 2029     mov     r0,29h
0803F6D0 7008     strb    r0,[r1]

@@end:
0803F6D2 BC30     pop     r4,r5
0803F6D4 BC01     pop     r0
0803F6D6 4700     bx      r0

////////////////////////////////////////////////////////////
;pose 29
0803F6E4 4904     ldr     r1,=30006BCh
0803F6E6 2000     mov     r0,0h
0803F6E8 7708     strb    r0,[r1,1Ch]
0803F6EA 82C8     strh    r0,[r1,16h]
0803F6EC 4803     ldr     r0,=835990Ch   ;写入上升准备的OAM
0803F6EE 6188     str     r0,[r1,18h]
0803F6F0 3124     add     r1,24h
0803F6F2 202A     mov     r0,2Ah  
0803F6F4 7008     strb    r0,[r1]        ;pose写入2A
0803F6F6 4770     bx      r14

///////////////////////////////////////////////////////////
;pose 2A
0803F700 B500     push    lr
0803F702 F7D2F933 bl      801196Ch  ;检查动画是否结束
0803F706 2800     cmp     r0,0h
0803F708 D003     beq     @@end
0803F70A 4803     ldr     r0,=30006BCh
0803F70C 3024     add     r0,24h
0803F70E 212B     mov     r1,2Bh    ;pose 写入2Bh
0803F710 7001     strb    r1,[r0]

@@end:
0803F712 BC01     pop     r0
0803F714 4700     bx      r0

/////////////////////////////////////////////////////////////
;pose 2b
0803F71C B510     push    r4,lr
0803F71E 4C0E     ldr     r4,=30006BCh
0803F720 2000     mov     r0,0h
0803F722 7720     strb    r0,[r4,1Ch]
0803F724 2200     mov     r2,0h
0803F726 82E0     strh    r0,[r4,16h]
0803F728 480C     ldr     r0,=8359924h  ;上升的OAM
0803F72A 61A0     str     r0,[r4,18h]
0803F72C 1C21     mov     r1,r4
0803F72E 3124     add     r1,24h
0803F730 202C     mov     r0,2Ch
0803F732 7008     strb    r0,[r1]       ;pose写入2c
0803F734 1C20     mov     r0,r4
0803F736 3031     add     r0,31h        ;零点是踩敌相关的数据
0803F738 7002     strb    r2,[r0]       ;写入0
0803F73A F7FFFF2F bl      803F59Ch
0803F73E 8821     ldrh    r1,[r4]
0803F740 2002     mov     r0,2h
0803F742 4008     and     r0,r1
0803F744 2800     cmp     r0,0h         ;检查是否在屏幕内
0803F746 D003     beq     @@end
0803F748 20D1     mov     r0,0D1h
0803F74A 0040     lsl     r0,r0,1h      ;播放上升的声音
0803F74C F7C3F882 bl      8002854h

@@end:
0803F750 BC10     pop     r4
0803F752 BC01     pop     r0
0803F754 4700     bx      r0

///////////////////////////////////////////////////////////
;pose 2c
0803F760 B570     push    r4-r6,lr
0803F762 4C12     ldr     r4,=30006BCh
0803F764 8860     ldrh    r0,[r4,2h]
0803F766 3830     sub     r0,30h
0803F768 88A1     ldrh    r1,[r4,4h]
0803F76A 3930     sub     r1,30h        ;精灵上30 左30检查砖块
0803F76C F7D1FE10 bl      8011390h
0803F770 4D0F     ldr     r5,=30007A5h
0803F772 7828     ldrb    r0,[r5]
0803F774 2811     cmp     r0,11h
0803F776 D014     beq     @@TopHaveBlock
0803F778 8860     ldrh    r0,[r4,2h]
0803F77A 3830     sub     r0,30h
0803F77C 88A1     ldrh    r1,[r4,4h]
0803F77E 3130     add     r1,30h        ;精灵上30 有30检查砖块
0803F780 F7D1FE06 bl      8011390h
0803F784 7828     ldrb    r0,[r5]
0803F786 2811     cmp     r0,11h
0803F788 D00B     beq     @@TopHaveBlock

;---------------------------------------顶部无砖
0803F78A 1C25     mov     r5,r4
0803F78C 3531     add     r5,31h
0803F78E 782A     ldrb    r2,[r5]       ;读取偏移31的值上升就从1开始增加
0803F790 4908     ldr     r1,=8358F64h  ;应该是敌人的速度值
0803F792 0050     lsl     r0,r2,1h      ;乘以2
0803F794 1840     add     r0,r0,r1      ;加上偏移值
0803F796 8803     ldrh    r3,[r0]       ;读取上升速度值
0803F798 2600     mov     r6,0h
0803F79A 5F81     ldsh    r1,[r0,r6]    ;带负数的形式读取
0803F79C 4806     ldr     r0,=7FFFh
0803F79E 4281     cmp     r1,r0         ;检查是否到了尾端
0803F7A0 D10C     bne     @@Continue

@@TopHaveBlock:
0803F7A2 1C21     mov     r1,r4
0803F7A4 3124     add     r1,24h
0803F7A6 202D     mov     r0,2Dh
0803F7A8 7008     strb    r0,[r1]
0803F7AA E00C     b       @@end

@@Continue:
0803F7BC 1C50     add     r0,r2,1       ;上升累计值加1
0803F7BE 7028     strb    r0,[r5]       ;再写入
0803F7C0 8860     ldrh    r0,[r4,2h]    ;读取Y坐标
0803F7C2 18C0     add     r0,r0,r3      ;加上上升速度值
0803F7C4 8060     strh    r0,[r4,2h]    ;再写入

@@end:
0803F7C6 BC70     pop     r4-r6
0803F7C8 BC01     pop     r0
0803F7CA 4700     bx      r0

/////////////////////////////////////////////////////////////
;pose 2d         下落准备
0803F7CC B500     push    lr
0803F7CE 4906     ldr     r1,=30006BCh
0803F7D0 2000     mov     r0,0h
0803F7D2 7708     strb    r0,[r1,1Ch]
0803F7D4 82C8     strh    r0,[r1,16h]
0803F7D6 4805     ldr     r0,=8359934h  ;下落准备OAM
0803F7D8 6188     str     r0,[r1,18h]
0803F7DA 3124     add     r1,24h
0803F7DC 202E     mov     r0,2Eh        ;pose写入2Eh
0803F7DE 7008     strb    r0,[r1]
0803F7E0 F7FFFECC bl      803F57Ch      ;未知例程
0803F7E4 BC01     pop     r0
0803F7E6 4700     bx      r0

//////////////////////////////////////////////////////////
;pose 2e
0803F7F0 B500     push    lr
0803F7F2 F7D2F8BB bl      801196Ch      ;检查动画
0803F7F6 2800     cmp     r0,0h
0803F7F8 D003     beq     @@end
0803F7FA 4803     ldr     r0,=30006BCh
0803F7FC 3024     add     r0,24h
0803F7FE 212F     mov     r1,2Fh
0803F800 7001     strb    r1,[r0]       ;pose写入2Fh  

@@end:
0803F802 BC01     pop     r0
0803F804 4700     bx      r0

//////////////////////////////////////////////////////////
;pose 2f
0803F80C 4806     ldr     r0,=30006BCh
0803F80E 2100     mov     r1,0h
0803F810 7701     strb    r1,[r0,1Ch]
0803F812 2300     mov     r3,0h
0803F814 82C1     strh    r1,[r0,16h]
0803F816 4905     ldr     r1,=835995Ch ;写入下落的OAM
0803F818 6181     str     r1,[r0,18h]
0803F81A 1C02     mov     r2,r0
0803F81C 3224     add     r2,24h
0803F81E 2130     mov     r1,30h       ;pose写入30h
0803F820 7011     strb    r1,[r2]
0803F822 302E     add     r0,2Eh       ;Enemy attached enemy slot?
0803F824 7003     strb    r3,[r0]      ;归零 仅仅是为了初始化
0803F826 4770     bx      r14

/////////////////////////////////////////////////////////////
;pose 30
0803F830 B530     push    r4,r5,lr
0803F832 B083     add     sp,-0Ch
0803F834 4C06     ldr     r4,=30006BCh
0803F836 8860     ldrh    r0,[r4,2h]
0803F838 88A1     ldrh    r1,[r4,4h]
0803F83A 3930     sub     r1,30h       ;检查左边(身下?)的砖块
0803F83C F7D1FDA8 bl      8011390h
0803F840 4D04     ldr     r5,=30007A5h
0803F842 7828     ldrb    r0,[r5]
0803F844 2811     cmp     r0,11h
0803F846 D107     bne     @@BottomNoBlock
0803F848 1C21     mov     r1,r4
0803F84A 3124     add     r1,24h
0803F84C 2001     mov     r0,1h        ;pose再次写回1
0803F84E E033     b       803F8B8h

@@BottomNoBlock:
0803F858 8860     ldrh    r0,[r4,2h]
0803F85A 88A1     ldrh    r1,[r4,4h]
0803F85C 3130     add     r1,30h       ;同样的炮制右边
0803F85E F7D1FD97 bl      8011390h
0803F862 7828     ldrb    r0,[r5]
0803F864 2811     cmp     r0,11h
0803F866 D103     bne     @@BottomAllNoBlock
0803F868 1C21     mov     r1,r4
0803F86A 3124     add     r1,24h
0803F86C 2001     mov     r0,1h
0803F86E E023     b       @@WillEnd

@@BottomAllNoBlock:
0803F870 8860     ldrh    r0,[r4,2h]
0803F872 3001     add     r0,1h       ;坐标向下1再写入
0803F874 8060     strh    r0,[r4,2h]
0803F876 1C20     mov     r0,r4
0803F878 302E     add     r0,2Eh
0803F87A 7800     ldrb    r0,[r0]     ;比较偏移2e的值是否是0
0803F87C 213F     mov     r1,3Fh
0803F87E 4001     and     r1,r0
0803F880 2900     cmp     r1,0h
0803F882 D115     bne     @@ADD
;-----------只有等于0的时候也就是初始值或者达到40的时候会屙屎
0803F884 7FE2     ldrb    r2,[r4,1Fh]
0803F886 1C20     mov     r0,r4
0803F888 3023     add     r0,23h
0803F88A 7803     ldrb    r3,[r0]
0803F88C 8860     ldrh    r0,[r4,2h]
0803F88E 3020     add     r0,20h
0803F890 9000     str     r0,[sp]
0803F892 88A0     ldrh    r0,[r4,4h]
0803F894 9001     str     r0,[sp,4h]
0803F896 9102     str     r1,[sp,8h]
0803F898 203E     mov     r0,3Eh
0803F89A 2100     mov     r1,0h
0803F89C F7D0F920 bl      800FAE0h    ;生产副精灵,屙屎
0803F8A0 8821     ldrh    r1,[r4]
0803F8A2 2002     mov     r0,2h
0803F8A4 4008     and     r0,r1
0803F8A6 2800     cmp     r0,0h       ;检查是否在屏幕内
0803F8A8 D002     beq     @@ADD
0803F8AA 4806     ldr     r0,=1A3h
0803F8AC F7C2FFD2 bl      8002854h    ;播放屙屎的声音

@@ADD:
0803F8B0 4905     ldr     r1,=30006BCh
0803F8B2 312E     add     r1,2Eh
0803F8B4 7808     ldrb    r0,[r1]
0803F8B6 3001     add     r0,1h

@@WillEnd:
0803F8B8 7008     strb    r0,[r1]
0803F8BA B003     add     sp,0Ch
0803F8BC BC30     pop     r4,r5
0803F8BE BC01     pop     r0
0803F8C0 4700     bx      r0


0803F8CC B510     push    r4,lr
0803F8CE 4819     ldr     r0,=30006BCh
0803F8D0 4684     mov     r12,r0
0803F8D2 8801     ldrh    r1,[r0]
0803F8D4 4818     ldr     r0,=0FFFBh
0803F8D6 4008     and     r0,r1
0803F8D8 2300     mov     r3,0h
0803F8DA 2400     mov     r4,0h
0803F8DC 4661     mov     r1,r12
0803F8DE 8008     strh    r0,[r1]
0803F8E0 4662     mov     r2,r12
0803F8E2 3234     add     r2,34h
0803F8E4 7811     ldrb    r1,[r2]
0803F8E6 2004     mov     r0,4h
0803F8E8 4308     orr     r0,r1
0803F8EA 7010     strb    r0,[r2]
0803F8EC 4660     mov     r0,r12
0803F8EE 3027     add     r0,27h
0803F8F0 2110     mov     r1,10h
0803F8F2 7001     strb    r1,[r0]
0803F8F4 3001     add     r0,1h
0803F8F6 7003     strb    r3,[r0]
0803F8F8 3001     add     r0,1h
0803F8FA 7001     strb    r1,[r0]
0803F8FC 480F     ldr     r0,=0FFE0h
0803F8FE 4662     mov     r2,r12
0803F900 8150     strh    r0,[r2,0Ah]
0803F902 8194     strh    r4,[r2,0Ch]
0803F904 3010     add     r0,10h
0803F906 81D0     strh    r0,[r2,0Eh]
0803F908 8211     strh    r1,[r2,10h]
0803F90A 4661     mov     r1,r12
0803F90C 3125     add     r1,25h
0803F90E 2004     mov     r0,4h
0803F910 7008     strb    r0,[r1]
0803F912 3903     sub     r1,3h
0803F914 2003     mov     r0,3h
0803F916 7008     strb    r0,[r1]
0803F918 7713     strb    r3,[r2,1Ch]
0803F91A 82D4     strh    r4,[r2,16h]
0803F91C 4808     ldr     r0,=8359984h
0803F91E 6190     str     r0,[r2,18h]
0803F920 310C     add     r1,0Ch
0803F922 2008     mov     r0,8h
0803F924 7008     strb    r0,[r1]
0803F926 390A     sub     r1,0Ah
0803F928 2002     mov     r0,2h
0803F92A 7008     strb    r0,[r1]
0803F92C BC10     pop     r4
0803F92E BC01     pop     r0
0803F930 4700     bx      r0
0803F932 0000     lsl     r0,r0,0h
0803F934 06BC     lsl     r4,r7,1Ah
0803F936 0300     lsl     r0,r0,0Ch
0803F938 FFFB0000 ????
0803F93A 0000     lsl     r0,r0,0h
0803F93C FFE00000 ????
0803F93E 0000     lsl     r0,r0,0h
0803F940 9984     ldr     r1,[sp,210h]
0803F942 0835     lsr     r5,r6,20h
0803F944 B500     push    lr
0803F946 4A0D     ldr     r2,=30006BCh
0803F948 8850     ldrh    r0,[r2,2h]
0803F94A 3001     add     r0,1h
0803F94C 2300     mov     r3,0h
0803F94E 8050     strh    r0,[r2,2h]
0803F950 1C11     mov     r1,r2
0803F952 312E     add     r1,2Eh
0803F954 7808     ldrb    r0,[r1]
0803F956 3801     sub     r0,1h
0803F958 7008     strb    r0,[r1]
0803F95A 0600     lsl     r0,r0,18h
0803F95C 0E00     lsr     r0,r0,18h
0803F95E 2800     cmp     r0,0h
0803F960 D109     bne     803F976h
0803F962 7713     strb    r3,[r2,1Ch]
0803F964 82D0     strh    r0,[r2,16h]
0803F966 4806     ldr     r0,=8359994h
0803F968 6190     str     r0,[r2,18h]
0803F96A 390A     sub     r1,0Ah
0803F96C 2016     mov     r0,16h
0803F96E 7008     strb    r0,[r1]
0803F970 1C10     mov     r0,r2
0803F972 3031     add     r0,31h
0803F974 7003     strb    r3,[r0]
0803F976 BC01     pop     r0
0803F978 4700     bx      r0
0803F97A 0000     lsl     r0,r0,0h
0803F97C 06BC     lsl     r4,r7,1Ah
0803F97E 0300     lsl     r0,r0,0Ch
0803F980 9994     ldr     r1,[sp,250h]
0803F982 0835     lsr     r5,r6,20h
0803F984 B510     push    r4,lr
0803F986 4C07     ldr     r4,=30006BCh
0803F988 8860     ldrh    r0,[r4,2h]
0803F98A 88A1     ldrh    r1,[r4,4h]
0803F98C 3940     sub     r1,40h
0803F98E F7D1FCFF bl      8011390h
0803F992 4805     ldr     r0,=30007A5h
0803F994 7801     ldrb    r1,[r0]
0803F996 20F0     mov     r0,0F0h
0803F998 4008     and     r0,r1
0803F99A 2800     cmp     r0,0h
0803F99C D008     beq     803F9B0h
0803F99E 4803     ldr     r0,=83599CCh
0803F9A0 E007     b       803F9B2h
0803F9A2 0000     lsl     r0,r0,0h
0803F9A4 06BC     lsl     r4,r7,1Ah
0803F9A6 0300     lsl     r0,r0,0Ch
0803F9A8 07A5     lsl     r5,r4,1Eh
0803F9AA 0300     lsl     r0,r0,0Ch
0803F9AC 99CC     ldr     r1,[sp,330h]
0803F9AE 0835     lsr     r5,r6,20h
0803F9B0 4805     ldr     r0,=83599A4h
0803F9B2 61A0     str     r0,[r4,18h]
0803F9B4 4805     ldr     r0,=30006BCh
0803F9B6 2100     mov     r1,0h
0803F9B8 7701     strb    r1,[r0,1Ch]
0803F9BA 82C1     strh    r1,[r0,16h]
0803F9BC 3024     add     r0,24h
0803F9BE 2108     mov     r1,8h
0803F9C0 7001     strb    r1,[r0]
0803F9C2 BC10     pop     r4
0803F9C4 BC01     pop     r0
0803F9C6 4700     bx      r0
0803F9C8 99A4     ldr     r1,[sp,290h]
0803F9CA 0835     lsr     r5,r6,20h
0803F9CC 06BC     lsl     r4,r7,1Ah
0803F9CE 0300     lsl     r0,r0,0Ch
0803F9D0 B510     push    r4,lr
0803F9D2 4C07     ldr     r4,=30006BCh
0803F9D4 1C21     mov     r1,r4
0803F9D6 3126     add     r1,26h
0803F9D8 2001     mov     r0,1h
0803F9DA 7008     strb    r0,[r1]
0803F9DC F7D1FFAA bl      8011934h
0803F9E0 2800     cmp     r0,0h
0803F9E2 D001     beq     803F9E8h
0803F9E4 2000     mov     r0,0h
0803F9E6 8020     strh    r0,[r4]
0803F9E8 BC10     pop     r4
0803F9EA BC01     pop     r0
0803F9EC 4700     bx      r0

//////////////////////////////////////////////////////////////////////////
;主程序
0803F9F4 B510     push    r4,lr
0803F9F6 4C0A     ldr     r4,=30006BCh
0803F9F8 1C20     mov     r0,r4
0803F9FA 302C     add     r0,2Ch
0803F9FC 7801     ldrb    r1,[r0]           ;一旦被冻住的瞬间就会是4
0803F9FE 207F     mov     r0,7Fh            
0803FA00 4008     and     r0,r1
0803FA02 2804     cmp     r0,4h
0803FA04 D103     bne     @@NoFrozen
0803FA06 20D2     mov     r0,0D2h
0803FA08 0040     lsl     r0,r0,1h
0803FA0A F7C2FF23 bl      8002854h          ;播放冻住的声音?

@@NoFrozen:
0803FA0E 1C20     mov     r0,r4
0803FA10 3032     add     r0,32h            
0803FA12 7800     ldrb    r0,[r0]           ;冰冻时间 零点是偏移30
0803FA14 2800     cmp     r0,0h
0803FA16 D005     beq     @@NoFrozening
0803FA18 F7D2FA14 bl      8011E44h          ;冰冻例程
0803FA1C E0F0     b       @@Thend

@@NoFrozening:
0803FA24 1C20     mov     r0,r4
0803FA26 3024     add     r0,24h
0803FA28 7800     ldrb    r0,[r0]           ;读取pose
0803FA2A 285B     cmp     r0,5Bh
0803FA2C D900     bls     @@NoDeath
0803FA2E E0E7     b       @@Thend

@@NoDeath:
0803FA30 0080     lsl     r0,r0,2h
0803FA32 4902     ldr     r1,=803FA40h
0803FA34 1840     add     r0,r0,r1
0803FA36 6800     ldr     r0,[r0]
0803FA38 4687     mov     r15,r0

PoseTable:
    .word 803fbb0h  ;00
	.word 803fbb6h  ;01
	.word 803fbbah  ;02
	.word @@Thend   ;03
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word 803fbc0h  ;29
	.word 803fbc4h  ;2Ah
	.word 803fbcah  ;2b
	.word 803fbceh  ;2c
	.word 803fbd4h  ;2d
	.word 803fbd8h  ;2e
	.word 803fbdeh  ;2f
	.word 803fbe2h  ;30
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word @@Thend
	.word 803fbe8h  ;57
	.word 803fbech  ;58
	.word 803fbf2h  ;59
	.word 803fbf6h  ;5a
	.word 803fbfch  ;5b
	

0803FBB0 F7FFFD04 bl      803F5BCh  ;pose 0
0803FBB4 E024     b       @@Thend
0803FBB6 F7FFFD4F bl      803F658h  ;pose 1    
0803FBBA F7FFFD5D bl      803F678h  ;pose 2 0-2然后在2循环为普通态
0803FBBE E01F     b       @@Thend
0803FBC0 F7FFFD90 bl      803F6E4h  ;pose 29  
0803FBC4 F7FFFD9C bl      803F700h  ;pose 2a 29-2a为触发
0803FBC8 E01A     b       @@Thend
0803FBCA F7FFFDA7 bl      803F71Ch  ;pose 2b 
0803FBCE F7FFFDC7 bl      803F760h  ;pose 2c 2b-2c为上升在2c循环上升
0803FBD2 E015     b       @@Thend
0803FBD4 F7FFFDFA bl      803F7CCh  ;pose 2d 
0803FBD8 F7FFFE0A bl      803F7F0h  ;pose 2e 2d-2e为上升停止
0803FBDC E010     b       @@Thend
0803FBDE F7FFFE15 bl      803F80Ch  ;pose 2f 
0803FBE2 F7FFFE25 bl      803F830h  ;pose 30 下落并屙屎,落地返回1
0803FBE6 E00B     b       @@Thend
0803FBE8 F021FD6A bl      80616C0h  ;pose 57 以下应该是死亡出X
0803FBEC F021FD7E bl      80616ECh  ;pose 58
0803FBF0 E006     b       @@Thend
0803FBF2 F7FFFCE3 bl      803F5BCh  ;pose 59
0803FBF6 F022FB6D bl      80622D4h  ;pose 5a
0803FBFA E001     b       @@Thend
0803FBFC F021FE9C bl      8061938h  ;pose 5b

@@Thend:
0803FC00 BC10     pop     r4
0803FC02 BC01     pop     r0
0803FC04 4700     bx      r0



0803FC06 0000     lsl     r0,r0,0h
0803FC08 B500     push    lr
0803FC0A 4805     ldr     r0,=30006BCh
0803FC0C 3024     add     r0,24h
0803FC0E 7800     ldrb    r0,[r0]
0803FC10 2837     cmp     r0,37h
0803FC12 D900     bls     803FC16h
0803FC14 E085     b       803FD22h
0803FC16 0080     lsl     r0,r0,2h
0803FC18 4902     ldr     r1,=803FC28h
0803FC1A 1840     add     r0,r0,r1
0803FC1C 6800     ldr     r0,[r0]
0803FC1E 4687     mov     r15,r0
0803FC20 06BC     lsl     r4,r7,1Ah
0803FC22 0300     lsl     r0,r0,0Ch
0803FC24 FC280803 ????
0803FC26 0803     lsr     r3,r0,20h
0803FC28 FD080803 ????
0803FC2A 0803     lsr     r3,r0,20h
0803FC2C FD220803 ????
0803FC2E 0803     lsr     r3,r0,20h
0803FC30 FD0E0803 ????
0803FC32 0803     lsr     r3,r0,20h
0803FC34 FD220803 ????
0803FC36 0803     lsr     r3,r0,20h
0803FC38 FD220803 ????
0803FC3A 0803     lsr     r3,r0,20h
0803FC3C FD220803 ????
0803FC3E 0803     lsr     r3,r0,20h
0803FC40 FD220803 ????
0803FC42 0803     lsr     r3,r0,20h
0803FC44 FD140803 ????
0803FC46 0803     lsr     r3,r0,20h
0803FC48 FD180803 ????
0803FC4A 0803     lsr     r3,r0,20h
0803FC4C FD220803 ????
0803FC4E 0803     lsr     r3,r0,20h
0803FC50 FD220803 ????
0803FC52 0803     lsr     r3,r0,20h
0803FC54 FD220803 ????
0803FC56 0803     lsr     r3,r0,20h
0803FC58 FD220803 ????
0803FC5A 0803     lsr     r3,r0,20h
0803FC5C FD220803 ????
0803FC5E 0803     lsr     r3,r0,20h
0803FC60 FD220803 ????
0803FC62 0803     lsr     r3,r0,20h
0803FC64 FD220803 ????
0803FC66 0803     lsr     r3,r0,20h
0803FC68 FD220803 ????
0803FC6A 0803     lsr     r3,r0,20h
0803FC6C FD220803 ????
0803FC6E 0803     lsr     r3,r0,20h
0803FC70 FD220803 ????
0803FC72 0803     lsr     r3,r0,20h
0803FC74 FD220803 ????
0803FC76 0803     lsr     r3,r0,20h
0803FC78 FD220803 ????
0803FC7A 0803     lsr     r3,r0,20h
0803FC7C FD220803 ????
0803FC7E 0803     lsr     r3,r0,20h
0803FC80 FD1E0803 ????
0803FC82 0803     lsr     r3,r0,20h
0803FC84 FD220803 ????
0803FC86 0803     lsr     r3,r0,20h
0803FC88 FD220803 ????
0803FC8A 0803     lsr     r3,r0,20h
0803FC8C FD220803 ????
0803FC8E 0803     lsr     r3,r0,20h
0803FC90 FD220803 ????
0803FC92 0803     lsr     r3,r0,20h
0803FC94 FD220803 ????
0803FC96 0803     lsr     r3,r0,20h
0803FC98 FD220803 ????
0803FC9A 0803     lsr     r3,r0,20h
0803FC9C FD220803 ????
0803FC9E 0803     lsr     r3,r0,20h
0803FCA0 FD220803 ????
0803FCA2 0803     lsr     r3,r0,20h
0803FCA4 FD220803 ????
0803FCA6 0803     lsr     r3,r0,20h
0803FCA8 FD220803 ????
0803FCAA 0803     lsr     r3,r0,20h
0803FCAC FD220803 ????
0803FCAE 0803     lsr     r3,r0,20h
0803FCB0 FD220803 ????
0803FCB2 0803     lsr     r3,r0,20h
0803FCB4 FD220803 ????
0803FCB6 0803     lsr     r3,r0,20h
0803FCB8 FD220803 ????
0803FCBA 0803     lsr     r3,r0,20h
0803FCBC FD220803 ????
0803FCBE 0803     lsr     r3,r0,20h
0803FCC0 FD220803 ????
0803FCC2 0803     lsr     r3,r0,20h
0803FCC4 FD220803 ????
0803FCC6 0803     lsr     r3,r0,20h
0803FCC8 FD220803 ????
0803FCCA 0803     lsr     r3,r0,20h
0803FCCC FD220803 ????
0803FCCE 0803     lsr     r3,r0,20h
0803FCD0 FD220803 ????
0803FCD2 0803     lsr     r3,r0,20h
0803FCD4 FD220803 ????
0803FCD6 0803     lsr     r3,r0,20h
0803FCD8 FD220803 ????
0803FCDA 0803     lsr     r3,r0,20h
0803FCDC FD220803 ????
0803FCDE 0803     lsr     r3,r0,20h
0803FCE0 FD220803 ????
0803FCE2 0803     lsr     r3,r0,20h
0803FCE4 FD220803 ????
0803FCE6 0803     lsr     r3,r0,20h
0803FCE8 FD220803 ????
0803FCEA 0803     lsr     r3,r0,20h
0803FCEC FD220803 ????
0803FCEE 0803     lsr     r3,r0,20h
0803FCF0 FD220803 ????
0803FCF2 0803     lsr     r3,r0,20h
0803FCF4 FD220803 ????
0803FCF6 0803     lsr     r3,r0,20h
0803FCF8 FD220803 ????
0803FCFA 0803     lsr     r3,r0,20h
0803FCFC FD220803 ????
0803FCFE 0803     lsr     r3,r0,20h
0803FD00 FD220803 ????
0803FD02 0803     lsr     r3,r0,20h
0803FD04 FD140803 ????
0803FD06 0803     lsr     r3,r0,20h
0803FD08 F7FFFDE0 bl      803F8CCh
0803FD0C E009     b       803FD22h
0803FD0E F7FFFE19 bl      803F944h
0803FD12 E006     b       803FD22h
0803FD14 F7FFFE36 bl      803F984h
0803FD18 F7FFFE5A bl      803F9D0h
0803FD1C E001     b       803FD22h
0803FD1E F7D1FB83 bl      8011428h
0803FD22 BC01     pop     r0
0803FD24 4700     bx      r0
0803FD26 0000     lsl     r0,r0,0h
0803FD28 B510     push    r4,lr
0803FD2A 4811     ldr     r0,=3001244h
0803FD2C 2226     mov     r2,26h
0803FD2E 5E81     ldsh    r1,[r0,r2]
0803FD30 0FCA     lsr     r2,r1,1Fh
0803FD32 1889     add     r1,r1,r2
0803FD34 1049     asr     r1,r1,1h
0803FD36 8B00     ldrh    r0,[r0,18h]
0803FD38 1809     add     r1,r1,r0
0803FD3A 4C0E     ldr     r4,=30006BCh
0803FD3C 8860     ldrh    r0,[r4,2h]
0803FD3E 4281     cmp     r1,r0
0803FD40 DC24     bgt     803FD8Ch
0803FD42 2180     mov     r1,80h
0803FD44 0049     lsl     r1,r1,1h
0803FD46 22D0     mov     r2,0D0h
0803FD48 0092     lsl     r2,r2,2h
0803FD4A 20C0     mov     r0,0C0h
0803FD4C F7D1FF4A bl      8011BE4h
0803FD50 1C03     mov     r3,r0
0803FD52 2B03     cmp     r3,3h
0803FD54 D110     bne     803FD78h
0803FD56 1C21     mov     r1,r4
0803FD58 3124     add     r1,24h
0803FD5A 2200     mov     r2,0h
0803FD5C 2017     mov     r0,17h
0803FD5E 7008     strb    r0,[r1]
0803FD60 1C20     mov     r0,r4
0803FD62 302F     add     r0,2Fh
0803FD64 7002     strb    r2,[r0]
0803FD66 3801     sub     r0,1h
0803FD68 7002     strb    r2,[r0]
0803FD6A 2003     mov     r0,3h
0803FD6C E02E     b       803FDCCh
0803FD6E 0000     lsl     r0,r0,0h
0803FD70 1244     asr     r4,r0,9h
0803FD72 0300     lsl     r0,r0,0Ch
0803FD74 06BC     lsl     r4,r7,1Ah
0803FD76 0300     lsl     r0,r0,0Ch
0803FD78 1C21     mov     r1,r4
0803FD7A 312E     add     r1,2Eh
0803FD7C 7808     ldrb    r0,[r1]
0803FD7E 2800     cmp     r0,0h
0803FD80 D006     beq     803FD90h
0803FD82 3801     sub     r0,1h
0803FD84 7008     strb    r0,[r1]
0803FD86 0600     lsl     r0,r0,18h
0803FD88 2800     cmp     r0,0h
0803FD8A D001     beq     803FD90h
0803FD8C 2000     mov     r0,0h
0803FD8E E01D     b       803FDCCh
0803FD90 20C0     mov     r0,0C0h
0803FD92 0040     lsl     r0,r0,1h
0803FD94 22D0     mov     r2,0D0h
0803FD96 0092     lsl     r2,r2,2h
0803FD98 1C11     mov     r1,r2
0803FD9A F7D1FF23 bl      8011BE4h
0803FD9E 1C03     mov     r3,r0
0803FDA0 2B03     cmp     r3,3h
0803FDA2 D107     bne     803FDB4h
0803FDA4 4802     ldr     r0,=30006BCh
0803FDA6 3024     add     r0,24h
0803FDA8 2129     mov     r1,29h
0803FDAA 7001     strb    r1,[r0]
0803FDAC E00C     b       803FDC8h
0803FDAE 0000     lsl     r0,r0,0h
0803FDB0 06BC     lsl     r4,r7,1Ah
0803FDB2 0300     lsl     r0,r0,0Ch
0803FDB4 2B0C     cmp     r3,0Ch
0803FDB6 D107     bne     803FDC8h
0803FDB8 4906     ldr     r1,=30006BCh
0803FDBA 1C0A     mov     r2,r1
0803FDBC 3224     add     r2,24h
0803FDBE 2003     mov     r0,3h
0803FDC0 7010     strb    r0,[r2]
0803FDC2 312F     add     r1,2Fh
0803FDC4 2001     mov     r0,1h
0803FDC6 7008     strb    r0,[r1]
0803FDC8 0618     lsl     r0,r3,18h
0803FDCA 0E00     lsr     r0,r0,18h
0803FDCC BC10     pop     r4
0803FDCE BC02     pop     r1
0803FDD0 4708     bx      r1
0803FDD2 0000     lsl     r0,r0,0h
0803FDD4 06BC     lsl     r4,r7,1Ah
0803FDD6 0300     lsl     r0,r0,0Ch
0803FDD8 B570     push    r4-r6,lr
0803FDDA 2600     mov     r6,0h
0803FDDC 4C0B     ldr     r4,=30006BCh
0803FDDE 8860     ldrh    r0,[r4,2h]
0803FDE0 88A1     ldrh    r1,[r4,4h]
0803FDE2 3924     sub     r1,24h
0803FDE4 F7D1FAD4 bl      8011390h
0803FDE8 4D09     ldr     r5,=30007A5h
0803FDEA 7828     ldrb    r0,[r5]
0803FDEC 2800     cmp     r0,0h
0803FDEE D108     bne     803FE02h
0803FDF0 8860     ldrh    r0,[r4,2h]
0803FDF2 88A1     ldrh    r1,[r4,4h]
0803FDF4 3124     add     r1,24h
0803FDF6 F7D1FACB bl      8011390h
0803FDFA 7828     ldrb    r0,[r5]
0803FDFC 2800     cmp     r0,0h
0803FDFE D100     bne     803FE02h
0803FE00 2601     mov     r6,1h
0803FE02 1C30     mov     r0,r6
0803FE04 BC70     pop     r4-r6
0803FE06 BC02     pop     r1
0803FE08 4708     bx      r1
0803FE0A 0000     lsl     r0,r0,0h
0803FE0C 06BC     lsl     r4,r7,1Ah
0803FE0E 0300     lsl     r0,r0,0Ch
0803FE10 07A5     lsl     r5,r4,1Eh
0803FE12 0300     lsl     r0,r0,0Ch
0803FE14 B500     push    lr
0803FE16 4A07     ldr     r2,=30006BCh
0803FE18 2300     mov     r3,0h
0803FE1A 2100     mov     r1,0h
0803FE1C 4806     ldr     r0,=0FF40h
0803FE1E 8150     strh    r0,[r2,0Ah]
0803FE20 8191     strh    r1,[r2,0Ch]
0803FE22 8811     ldrh    r1,[r2]
0803FE24 2040     mov     r0,40h
0803FE26 4008     and     r0,r1
0803FE28 2800     cmp     r0,0h
0803FE2A D009     beq     803FE40h
0803FE2C 4803     ldr     r0,=0FFE0h
0803FE2E 81D0     strh    r0,[r2,0Eh]
0803FE30 2038     mov     r0,38h
0803FE32 E008     b       803FE46h
0803FE34 06BC     lsl     r4,r7,1Ah
0803FE36 0300     lsl     r0,r0,0Ch
0803FE38 FF400000 ????
0803FE3A 0000     lsl     r0,r0,0h
0803FE3C FFE00000 ????
0803FE3E 0000     lsl     r0,r0,0h
0803FE40 4802     ldr     r0,=0FFC8h
0803FE42 81D0     strh    r0,[r2,0Eh]
0803FE44 2020     mov     r0,20h
0803FE46 8210     strh    r0,[r2,10h]
0803FE48 BC01     pop     r0
0803FE4A 4700     bx      r0
0803FE4C FFC80000 ????
0803FE4E 0000     lsl     r0,r0,0h
0803FE50 B500     push    lr
0803FE52 4804     ldr     r0,=30006BCh
0803FE54 1C01     mov     r1,r0
0803FE56 312F     add     r1,2Fh
0803FE58 7809     ldrb    r1,[r1]
0803FE5A 1C02     mov     r2,r0
0803FE5C 2900     cmp     r1,0h
0803FE5E D005     beq     803FE6Ch
0803FE60 4801     ldr     r0,=0FF80h
0803FE62 E004     b       803FE6Eh
0803FE64 06BC     lsl     r4,r7,1Ah
0803FE66 0300     lsl     r0,r0,0Ch
0803FE68 FF800000 ????
0803FE6A 0000     lsl     r0,r0,0h
0803FE6C 4806     ldr     r0,=0FF40h
0803FE6E 8150     strh    r0,[r2,0Ah]
0803FE70 2300     mov     r3,0h
0803FE72 2000     mov     r0,0h
0803FE74 8190     strh    r0,[r2,0Ch]
0803FE76 8811     ldrh    r1,[r2]
0803FE78 2040     mov     r0,40h
0803FE7A 4008     and     r0,r1
0803FE7C 2800     cmp     r0,0h
0803FE7E D007     beq     803FE90h
0803FE80 4802     ldr     r0,=0FFE0h
0803FE82 81D0     strh    r0,[r2,0Eh]
0803FE84 2070     mov     r0,70h
0803FE86 E006     b       803FE96h
0803FE88 FF400000 ????
0803FE8A 0000     lsl     r0,r0,0h
0803FE8C FFE00000 ????
0803FE8E 0000     lsl     r0,r0,0h
0803FE90 4802     ldr     r0,=0FF90h
0803FE92 81D0     strh    r0,[r2,0Eh]
0803FE94 2020     mov     r0,20h
0803FE96 8210     strh    r0,[r2,10h]
0803FE98 BC01     pop     r0
0803FE9A 4700     bx      r0
0803FE9C FF900000 ????
0803FE9E 0000     lsl     r0,r0,0h
0803FEA0 B510     push    r4,lr
0803FEA2 4C05     ldr     r4,=30006BCh
0803FEA4 1C21     mov     r1,r4
0803FEA6 3124     add     r1,24h
0803FEA8 7808     ldrb    r0,[r1]
0803FEAA 2859     cmp     r0,59h
0803FEAC D106     bne     803FEBCh
0803FEAE 205A     mov     r0,5Ah
0803FEB0 7008     strb    r0,[r1]
0803FEB2 310A     add     r1,0Ah
0803FEB4 202C     mov     r0,2Ch
0803FEB6 E034     b       803FF22h
0803FEB8 06BC     lsl     r4,r7,1Ah
0803FEBA 0300     lsl     r0,r0,0Ch
0803FEBC 7F60     ldrb    r0,[r4,1Dh]
0803FEBE 28B4     cmp     r0,0B4h
0803FEC0 D10F     bne     803FEE2h
0803FEC2 8821     ldrh    r1,[r4]
0803FEC4 2080     mov     r0,80h
0803FEC6 0180     lsl     r0,r0,6h
0803FEC8 4008     and     r0,r1
0803FECA 2800     cmp     r0,0h
0803FECC D002     beq     803FED4h
0803FECE 2000     mov     r0,0h
0803FED0 8020     strh    r0,[r4]
0803FED2 E04C     b       803FF6Eh
0803FED4 1C22     mov     r2,r4
0803FED6 3234     add     r2,34h
0803FED8 7811     ldrb    r1,[r2]
0803FEDA 2002     mov     r0,2h
0803FEDC 4308     orr     r0,r1
0803FEDE 7010     strb    r0,[r2]
0803FEE0 E016     b       803FF10h
0803FEE2 F7D2FC99 bl      8012818h
0803FEE6 1C20     mov     r0,r4
0803FEE8 3034     add     r0,34h
0803FEEA 7801     ldrb    r1,[r0]
0803FEEC 2202     mov     r2,2h
0803FEEE 1C10     mov     r0,r2
0803FEF0 4008     and     r0,r1
0803FEF2 2800     cmp     r0,0h
0803FEF4 D00C     beq     803FF10h
0803FEF6 8821     ldrh    r1,[r4]
0803FEF8 2080     mov     r0,80h
0803FEFA 0180     lsl     r0,r0,6h
0803FEFC 4008     and     r0,r1
0803FEFE 0400     lsl     r0,r0,10h
0803FF00 0C00     lsr     r0,r0,10h
0803FF02 2800     cmp     r0,0h
0803FF04 D101     bne     803FF0Ah
0803FF06 8020     strh    r0,[r4]
0803FF08 E031     b       803FF6Eh
0803FF0A 1C20     mov     r0,r4
0803FF0C 3036     add     r0,36h
0803FF0E 7002     strb    r2,[r0]
0803FF10 F7D1FAC2 bl      8011498h
0803FF14 4917     ldr     r1,=30006BCh
0803FF16 1C0A     mov     r2,r1
0803FF18 3224     add     r2,24h
0803FF1A 2002     mov     r0,2h
0803FF1C 7010     strb    r0,[r2]
0803FF1E 312E     add     r1,2Eh
0803FF20 201E     mov     r0,1Eh
0803FF22 7008     strb    r0,[r1]
0803FF24 4813     ldr     r0,=30006BCh
0803FF26 4684     mov     r12,r0
0803FF28 4661     mov     r1,r12
0803FF2A 3125     add     r1,25h
0803FF2C 2300     mov     r3,0h
0803FF2E 2002     mov     r0,2h
0803FF30 7008     strb    r0,[r1]
0803FF32 4A11     ldr     r2,=82E4D4Ch
0803FF34 4660     mov     r0,r12
0803FF36 7F41     ldrb    r1,[r0,1Dh]
0803FF38 00C8     lsl     r0,r1,3h
0803FF3A 1A40     sub     r0,r0,r1
0803FF3C 0040     lsl     r0,r0,1h
0803FF3E 1880     add     r0,r0,r2
0803FF40 8800     ldrh    r0,[r0]
0803FF42 2100     mov     r1,0h
0803FF44 4662     mov     r2,r12
0803FF46 8290     strh    r0,[r2,14h]
0803FF48 3227     add     r2,27h
0803FF4A 2038     mov     r0,38h
0803FF4C 7010     strb    r0,[r2]
0803FF4E 4660     mov     r0,r12
0803FF50 3028     add     r0,28h
0803FF52 7001     strb    r1,[r0]
0803FF54 3202     add     r2,2h
0803FF56 2020     mov     r0,20h
0803FF58 7010     strb    r0,[r2]
0803FF5A 4808     ldr     r0,=835C190h
0803FF5C 4662     mov     r2,r12
0803FF5E 6190     str     r0,[r2,18h]
0803FF60 7711     strb    r1,[r2,1Ch]
0803FF62 82D3     strh    r3,[r2,16h]
0803FF64 4660     mov     r0,r12
0803FF66 302F     add     r0,2Fh
0803FF68 7001     strb    r1,[r0]
0803FF6A F7FFFF53 bl      803FE14h
0803FF6E BC10     pop     r4
0803FF70 BC01     pop     r0
0803FF72 4700     bx      r0
0803FF74 06BC     lsl     r4,r7,1Ah
0803FF76 0300     lsl     r0,r0,0Ch
0803FF78 4D4C     ldr     r5,=0FDFAF7CFh
0803FF7A 082E     lsr     r6,r5,20h
0803FF7C C190     stmia   [r1]!,r4,r7
0803FF7E 0835     lsr     r5,r6,20h
0803FF80 B500     push    lr
0803FF82 4B0C     ldr     r3,=30006BCh
0803FF84 1C19     mov     r1,r3
0803FF86 3126     add     r1,26h
0803FF88 2001     mov     r0,1h
0803FF8A 7008     strb    r0,[r1]
0803FF8C 202E     mov     r0,2Eh
0803FF8E 18C0     add     r0,r0,r3
0803FF90 4684     mov     r12,r0
0803FF92 7800     ldrb    r0,[r0]
0803FF94 3801     sub     r0,1h
0803FF96 4661     mov     r1,r12
0803FF98 7008     strb    r0,[r1]
0803FF9A 0600     lsl     r0,r0,18h
0803FF9C 0E01     lsr     r1,r0,18h
0803FF9E 2900     cmp     r1,0h
0803FFA0 D00E     beq     803FFC0h
0803FFA2 4A05     ldr     r2,=300120Ch
0803FFA4 4905     ldr     r1,=83BDED6h
0803FFA6 4663     mov     r3,r12
0803FFA8 7818     ldrb    r0,[r3]
0803FFAA 0040     lsl     r0,r0,1h
0803FFAC 1840     add     r0,r0,r1
0803FFAE 8800     ldrh    r0,[r0]
0803FFB0 8010     strh    r0,[r2]
0803FFB2 E023     b       803FFFCh
0803FFB4 06BC     lsl     r4,r7,1Ah
0803FFB6 0300     lsl     r0,r0,0Ch
0803FFB8 120C     asr     r4,r1,8h
0803FFBA 0300     lsl     r0,r0,0Ch
0803FFBC DED6     ????
0803FFBE 083B     lsr     r3,r7,20h
0803FFC0 7F58     ldrb    r0,[r3,1Dh]
0803FFC2 28B4     cmp     r0,0B4h
0803FFC4 D110     bne     803FFE8h
0803FFC6 77D9     strb    r1,[r3,1Fh]
0803FFC8 20B3     mov     r0,0B3h
0803FFCA 7758     strb    r0,[r3,1Dh]
0803FFCC 1C1A     mov     r2,r3
0803FFCE 3234     add     r2,34h
0803FFD0 7811     ldrb    r1,[r2]
0803FFD2 20FD     mov     r0,0FDh
0803FFD4 4008     and     r0,r1
0803FFD6 7010     strb    r0,[r2]
0803FFD8 1C19     mov     r1,r3
0803FFDA 3124     add     r1,24h
0803FFDC 2059     mov     r0,59h
0803FFDE 7008     strb    r0,[r1]
0803FFE0 8858     ldrh    r0,[r3,2h]
0803FFE2 3840     sub     r0,40h
0803FFE4 8058     strh    r0,[r3,2h]
0803FFE6 E009     b       803FFFCh
0803FFE8 1C19     mov     r1,r3
0803FFEA 3124     add     r1,24h
0803FFEC 2002     mov     r0,2h
0803FFEE 7008     strb    r0,[r1]
0803FFF0 8819     ldrh    r1,[r3]
0803FFF2 4803     ldr     r0,=0FFDFh
0803FFF4 4008     and     r0,r1
0803FFF6 4903     ldr     r1,=7FFFh
0803FFF8 4008     and     r0,r1
0803FFFA 8018     strh    r0,[r3]
0803FFFC BC01     pop     r0
0803FFFE 4700     bx      r0
08040000 FFDF0000 ????
08040002 0000     lsl     r0,r0,0h
08040004 7FFF     ldrb    r7,[r7,1Fh]
08040006 0000     lsl     r0,r0,0h
08040008 B5F0     push    r4-r7,lr
0804000A B084     add     sp,-10h
0804000C 4C16     ldr     r4,=30006BCh
0804000E 8821     ldrh    r1,[r4]
08040010 2240     mov     r2,40h
08040012 1C10     mov     r0,r2
08040014 4008     and     r0,r1
08040016 0400     lsl     r0,r0,10h
08040018 0C05     lsr     r5,r0,10h
0804001A 2D00     cmp     r5,0h
0804001C D026     beq     804006Ch
0804001E 7F61     ldrb    r1,[r4,1Dh]
08040020 1C26     mov     r6,r4
08040022 3623     add     r6,23h
08040024 7833     ldrb    r3,[r6]
08040026 1C25     mov     r5,r4
08040028 352A     add     r5,2Ah
0804002A 7828     ldrb    r0,[r5]
0804002C 9000     str     r0,[sp]
0804002E 8860     ldrh    r0,[r4,2h]
08040030 3860     sub     r0,60h
08040032 9001     str     r0,[sp,4h]
08040034 88A0     ldrh    r0,[r4,4h]
08040036 3020     add     r0,20h
08040038 9002     str     r0,[sp,8h]
0804003A 9203     str     r2,[sp,0Ch]
0804003C 20B9     mov     r0,0B9h
0804003E 2200     mov     r2,0h
08040040 F7CFFE30 bl      800FCA4h
08040044 7F61     ldrb    r1,[r4,1Dh]
08040046 7833     ldrb    r3,[r6]
08040048 7828     ldrb    r0,[r5]
0804004A 9000     str     r0,[sp]
0804004C 8860     ldrh    r0,[r4,2h]
0804004E 3898     sub     r0,098h
08040050 9001     str     r0,[sp,4h]
08040052 88A0     ldrh    r0,[r4,4h]
08040054 3810     sub     r0,10h
08040056 9002     str     r0,[sp,8h]
08040058 2000     mov     r0,0h
0804005A 9003     str     r0,[sp,0Ch]
0804005C 20B9     mov     r0,0B9h
0804005E 2200     mov     r2,0h
08040060 F7CFFE20 bl      800FCA4h
08040064 E024     b       80400B0h
08040066 0000     lsl     r0,r0,0h
08040068 06BC     lsl     r4,r7,1Ah
0804006A 0300     lsl     r0,r0,0Ch
0804006C 7F61     ldrb    r1,[r4,1Dh]
0804006E 1C27     mov     r7,r4
08040070 3723     add     r7,23h
08040072 783B     ldrb    r3,[r7]
08040074 1C26     mov     r6,r4
08040076 362A     add     r6,2Ah
08040078 7830     ldrb    r0,[r6]
0804007A 9000     str     r0,[sp]
0804007C 8860     ldrh    r0,[r4,2h]
0804007E 3860     sub     r0,60h
08040080 9001     str     r0,[sp,4h]
08040082 88A0     ldrh    r0,[r4,4h]
08040084 3820     sub     r0,20h
08040086 9002     str     r0,[sp,8h]
08040088 9203     str     r2,[sp,0Ch]
0804008A 20B9     mov     r0,0B9h
0804008C 2200     mov     r2,0h
0804008E F7CFFE09 bl      800FCA4h
08040092 7F61     ldrb    r1,[r4,1Dh]
08040094 783B     ldrb    r3,[r7]
08040096 7830     ldrb    r0,[r6]
08040098 9000     str     r0,[sp]
0804009A 8860     ldrh    r0,[r4,2h]
0804009C 3898     sub     r0,098h
0804009E 9001     str     r0,[sp,4h]
080400A0 88A0     ldrh    r0,[r4,4h]
080400A2 3010     add     r0,10h
080400A4 9002     str     r0,[sp,8h]
080400A6 9503     str     r5,[sp,0Ch]
080400A8 20B9     mov     r0,0B9h
080400AA 2200     mov     r2,0h
080400AC F7CFFDFA bl      800FCA4h
080400B0 4903     ldr     r1,=30006BCh
080400B2 2000     mov     r0,0h
080400B4 8008     strh    r0,[r1]
080400B6 B004     add     sp,10h
080400B8 BCF0     pop     r4-r7
080400BA BC01     pop     r0
080400BC 4700     bx      r0
080400BE 0000     lsl     r0,r0,0h
080400C0 06BC     lsl     r4,r7,1Ah
080400C2 0300     lsl     r0,r0,0Ch
080400C4 B5F0     push    r4-r7,lr
080400C6 4647     mov     r7,r8
080400C8 B480     push    r7
080400CA B084     add     sp,-10h
080400CC 4E26     ldr     r6,=30006BCh
080400CE 7F70     ldrb    r0,[r6,1Dh]
080400D0 28A2     cmp     r0,0A2h
080400D2 D14B     bne     804016Ch
080400D4 1C01     mov     r1,r0
080400D6 2023     mov     r0,23h
080400D8 1980     add     r0,r0,r6
080400DA 4680     mov     r8,r0
080400DC 7803     ldrb    r3,[r0]
080400DE 1C37     mov     r7,r6
080400E0 372A     add     r7,2Ah
080400E2 7838     ldrb    r0,[r7]
080400E4 9000     str     r0,[sp]
080400E6 8870     ldrh    r0,[r6,2h]
080400E8 381C     sub     r0,1Ch
080400EA 9001     str     r0,[sp,4h]
080400EC 88B0     ldrh    r0,[r6,4h]
080400EE 3818     sub     r0,18h
080400F0 9002     str     r0,[sp,8h]
080400F2 2540     mov     r5,40h
080400F4 9503     str     r5,[sp,0Ch]
080400F6 2038     mov     r0,38h
080400F8 2200     mov     r2,0h
080400FA F7CFFDD3 bl      800FCA4h
080400FE 7F71     ldrb    r1,[r6,1Dh]
08040100 4640     mov     r0,r8
08040102 7803     ldrb    r3,[r0]
08040104 7838     ldrb    r0,[r7]
08040106 9000     str     r0,[sp]
08040108 8870     ldrh    r0,[r6,2h]
0804010A 3838     sub     r0,38h
0804010C 9001     str     r0,[sp,4h]
0804010E 88B0     ldrh    r0,[r6,4h]
08040110 3018     add     r0,18h
08040112 9002     str     r0,[sp,8h]
08040114 2400     mov     r4,0h
08040116 9403     str     r4,[sp,0Ch]
08040118 2038     mov     r0,38h
0804011A 2200     mov     r2,0h
0804011C F7CFFDC2 bl      800FCA4h
08040120 7F71     ldrb    r1,[r6,1Dh]
08040122 4640     mov     r0,r8
08040124 7803     ldrb    r3,[r0]
08040126 7838     ldrb    r0,[r7]
08040128 9000     str     r0,[sp]
0804012A 8870     ldrh    r0,[r6,2h]
0804012C 3854     sub     r0,54h
0804012E 9001     str     r0,[sp,4h]
08040130 88B0     ldrh    r0,[r6,4h]
08040132 380C     sub     r0,0Ch
08040134 9002     str     r0,[sp,8h]
08040136 9503     str     r5,[sp,0Ch]
08040138 2038     mov     r0,38h
0804013A 2200     mov     r2,0h
0804013C F7CFFDB2 bl      800FCA4h
08040140 7F71     ldrb    r1,[r6,1Dh]
08040142 4640     mov     r0,r8
08040144 7803     ldrb    r3,[r0]
08040146 7838     ldrb    r0,[r7]
08040148 9000     str     r0,[sp]
0804014A 8870     ldrh    r0,[r6,2h]
0804014C 3870     sub     r0,70h
0804014E 9001     str     r0,[sp,4h]
08040150 88B0     ldrh    r0,[r6,4h]
08040152 300C     add     r0,0Ch
08040154 9002     str     r0,[sp,8h]
08040156 9403     str     r4,[sp,0Ch]
08040158 2038     mov     r0,38h
0804015A 2200     mov     r2,0h
0804015C F7CFFDA2 bl      800FCA4h
08040160 8870     ldrh    r0,[r6,2h]
08040162 388C     sub     r0,8Ch
08040164 8070     strh    r0,[r6,2h]
08040166 E035     b       80401D4h
08040168 06BC     lsl     r4,r7,1Ah
0804016A 0300     lsl     r0,r0,0Ch
0804016C 8831     ldrh    r1,[r6]
0804016E 2240     mov     r2,40h
08040170 1C10     mov     r0,r2
08040172 4008     and     r0,r1
08040174 2800     cmp     r0,0h
08040176 D014     beq     80401A2h
08040178 7F71     ldrb    r1,[r6,1Dh]
0804017A 1C30     mov     r0,r6
0804017C 3023     add     r0,23h
0804017E 7803     ldrb    r3,[r0]
08040180 3007     add     r0,7h
08040182 7800     ldrb    r0,[r0]
08040184 9000     str     r0,[sp]
08040186 8870     ldrh    r0,[r6,2h]
08040188 3860     sub     r0,60h
0804018A 9001     str     r0,[sp,4h]
0804018C 88B0     ldrh    r0,[r6,4h]
0804018E 3020     add     r0,20h
08040190 9002     str     r0,[sp,8h]
08040192 9203     str     r2,[sp,0Ch]
08040194 2038     mov     r0,38h
08040196 2200     mov     r2,0h
08040198 F7CFFD84 bl      800FCA4h
0804019C 88B0     ldrh    r0,[r6,4h]
0804019E 3810     sub     r0,10h
080401A0 E013     b       80401CAh
080401A2 7F71     ldrb    r1,[r6,1Dh]
080401A4 1C30     mov     r0,r6
080401A6 3023     add     r0,23h
080401A8 7803     ldrb    r3,[r0]
080401AA 3007     add     r0,7h
080401AC 7800     ldrb    r0,[r0]
080401AE 9000     str     r0,[sp]
080401B0 8870     ldrh    r0,[r6,2h]
080401B2 3860     sub     r0,60h
080401B4 9001     str     r0,[sp,4h]
080401B6 88B0     ldrh    r0,[r6,4h]
080401B8 3820     sub     r0,20h
080401BA 9002     str     r0,[sp,8h]
080401BC 9203     str     r2,[sp,0Ch]
080401BE 2038     mov     r0,38h
080401C0 2200     mov     r2,0h
080401C2 F7CFFD6F bl      800FCA4h
080401C6 88B0     ldrh    r0,[r6,4h]
080401C8 3010     add     r0,10h
080401CA 80B0     strh    r0,[r6,4h]
080401CC 4904     ldr     r1,=30006BCh
080401CE 8848     ldrh    r0,[r1,2h]
080401D0 3898     sub     r0,098h
080401D2 8048     strh    r0,[r1,2h]
080401D4 B004     add     sp,10h
080401D6 BC08     pop     r3
080401D8 4698     mov     r8,r3
080401DA BCF0     pop     r4-r7
080401DC BC01     pop     r0
080401DE 4700     bx      r0
080401E0 06BC     lsl     r4,r7,1Ah
080401E2 0300     lsl     r0,r0,0Ch
080401E4 B500     push    lr
080401E6 4B08     ldr     r3,=30006BCh
080401E8 1C1A     mov     r2,r3
080401EA 3224     add     r2,24h
080401EC 2100     mov     r1,0h
080401EE 2016     mov     r0,16h
080401F0 7010     strb    r0,[r2]
080401F2 1C18     mov     r0,r3
080401F4 3031     add     r0,31h
080401F6 7001     strb    r1,[r0]
080401F8 4804     ldr     r0,=835C200h
080401FA 6198     str     r0,[r3,18h]
080401FC 7719     strb    r1,[r3,1Ch]
080401FE 82D9     strh    r1,[r3,16h]
08040200 F7FFFE08 bl      803FE14h
08040204 BC01     pop     r0
08040206 4700     bx      r0
08040208 06BC     lsl     r4,r7,1Ah
0804020A 0300     lsl     r0,r0,0Ch
0804020C C200     stmia   [r2]!,
0804020E 0835     lsr     r5,r6,20h
08040210 B510     push    r4,lr
08040212 4C08     ldr     r4,=30006BCh
08040214 4808     ldr     r0,=835C190h
08040216 61A0     str     r0,[r4,18h]
08040218 2000     mov     r0,0h
0804021A 7720     strb    r0,[r4,1Ch]
0804021C 82E0     strh    r0,[r4,16h]
0804021E 1C21     mov     r1,r4
08040220 3124     add     r1,24h
08040222 2002     mov     r0,2h
08040224 7008     strb    r0,[r1]
08040226 F7FFFDF5 bl      803FE14h
0804022A 88A0     ldrh    r0,[r4,4h]
0804022C 8120     strh    r0,[r4,8h]
0804022E BC10     pop     r4
08040230 BC01     pop     r0
08040232 4700     bx      r0
08040234 06BC     lsl     r4,r7,1Ah
08040236 0300     lsl     r0,r0,0Ch
08040238 C190     stmia   [r1]!,r4,r7
0804023A 0835     lsr     r5,r6,20h
0804023C B5F0     push    r4-r7,lr
0804023E 4C09     ldr     r4,=30006BCh
08040240 8821     ldrh    r1,[r4]
08040242 2080     mov     r0,80h
08040244 0180     lsl     r0,r0,6h
08040246 4008     and     r0,r1
08040248 2800     cmp     r0,0h
0804024A D000     beq     804024Eh
0804024C E0E0     b       8040410h
0804024E 2700     mov     r7,0h
08040250 F7FFFDC2 bl      803FDD8h
08040254 0600     lsl     r0,r0,18h
08040256 2800     cmp     r0,0h
08040258 D006     beq     8040268h
0804025A 1C21     mov     r1,r4
0804025C 3124     add     r1,24h
0804025E 2015     mov     r0,15h
08040260 E0D5     b       804040Eh
08040262 0000     lsl     r0,r0,0h
08040264 06BC     lsl     r4,r7,1Ah
08040266 0300     lsl     r0,r0,0Ch
08040268 F7D1F818 bl      801129Ch
0804026C 480D     ldr     r0,=30007A4h
0804026E 7801     ldrb    r1,[r0]
08040270 26F0     mov     r6,0F0h
08040272 1C30     mov     r0,r6
08040274 4008     and     r0,r1
08040276 2800     cmp     r0,0h
08040278 D064     beq     8040344h
0804027A 8821     ldrh    r1,[r4]
0804027C 2040     mov     r0,40h
0804027E 4008     and     r0,r1
08040280 2800     cmp     r0,0h
08040282 D02D     beq     80402E0h
08040284 8860     ldrh    r0,[r4,2h]
08040286 88A1     ldrh    r1,[r4,4h]
08040288 3120     add     r1,20h
0804028A F7D1F881 bl      8011390h
0804028E 4D06     ldr     r5,=30007A5h
08040290 7829     ldrb    r1,[r5]
08040292 1C30     mov     r0,r6
08040294 4008     and     r0,r1
08040296 2800     cmp     r0,0h
08040298 D108     bne     80402ACh
0804029A 8860     ldrh    r0,[r4,2h]
0804029C 88A1     ldrh    r1,[r4,4h]
0804029E 3160     add     r1,60h
080402A0 E02C     b       80402FCh
080402A2 0000     lsl     r0,r0,0h
080402A4 07A4     lsl     r4,r4,1Eh
080402A6 0300     lsl     r0,r0,0Ch
080402A8 07A5     lsl     r5,r4,1Eh
080402AA 0300     lsl     r0,r0,0Ch
080402AC 8860     ldrh    r0,[r4,2h]
080402AE 3804     sub     r0,4h
080402B0 88A1     ldrh    r1,[r4,4h]
080402B2 3140     add     r1,40h
080402B4 F7D1F86C bl      8011390h
080402B8 7829     ldrb    r1,[r5]
080402BA 260F     mov     r6,0Fh
080402BC 1C30     mov     r0,r6
080402BE 4008     and     r0,r1
080402C0 2800     cmp     r0,0h
080402C2 D123     bne     804030Ch
080402C4 8860     ldrh    r0,[r4,2h]
080402C6 38A0     sub     r0,0A0h
080402C8 88A1     ldrh    r1,[r4,4h]
080402CA 3140     add     r1,40h
080402CC F7D1F860 bl      8011390h
080402D0 7829     ldrb    r1,[r5]
080402D2 1C30     mov     r0,r6
080402D4 4008     and     r0,r1
080402D6 2800     cmp     r0,0h
080402D8 D118     bne     804030Ch
080402DA 88A0     ldrh    r0,[r4,4h]
080402DC 3004     add     r0,4h
080402DE E03B     b       8040358h
080402E0 8860     ldrh    r0,[r4,2h]
080402E2 88A1     ldrh    r1,[r4,4h]
080402E4 3920     sub     r1,20h
080402E6 F7D1F853 bl      8011390h
080402EA 4D09     ldr     r5,=30007A5h
080402EC 7829     ldrb    r1,[r5]
080402EE 1C30     mov     r0,r6
080402F0 4008     and     r0,r1
080402F2 2800     cmp     r0,0h
080402F4 D10E     bne     8040314h
080402F6 8860     ldrh    r0,[r4,2h]
080402F8 88A1     ldrh    r1,[r4,4h]
080402FA 3960     sub     r1,60h
080402FC F7D1F848 bl      8011390h
08040300 7829     ldrb    r1,[r5]
08040302 1C30     mov     r0,r6
08040304 4008     and     r0,r1
08040306 2702     mov     r7,2h
08040308 2800     cmp     r0,0h
0804030A D126     bne     804035Ah
0804030C 2701     mov     r7,1h
0804030E E024     b       804035Ah
08040310 07A5     lsl     r5,r4,1Eh
08040312 0300     lsl     r0,r0,0Ch
08040314 8860     ldrh    r0,[r4,2h]
08040316 3804     sub     r0,4h
08040318 88A1     ldrh    r1,[r4,4h]
0804031A 3940     sub     r1,40h
0804031C F7D1F838 bl      8011390h
08040320 7829     ldrb    r1,[r5]
08040322 260F     mov     r6,0Fh
08040324 1C30     mov     r0,r6
08040326 4008     and     r0,r1
08040328 2800     cmp     r0,0h
0804032A D1EF     bne     804030Ch
0804032C 8860     ldrh    r0,[r4,2h]
0804032E 38A0     sub     r0,0A0h
08040330 88A1     ldrh    r1,[r4,4h]
08040332 3940     sub     r1,40h
08040334 F7D1F82C bl      8011390h
08040338 7829     ldrb    r1,[r5]
0804033A 1C30     mov     r0,r6
0804033C 4008     and     r0,r1
0804033E 2800     cmp     r0,0h
08040340 D1E4     bne     804030Ch
08040342 E007     b       8040354h
08040344 8821     ldrh    r1,[r4]
08040346 2040     mov     r0,40h
08040348 4008     and     r0,r1
0804034A 2800     cmp     r0,0h
0804034C D002     beq     8040354h
0804034E 88A0     ldrh    r0,[r4,4h]
08040350 3004     add     r0,4h
08040352 E001     b       8040358h
08040354 88A0     ldrh    r0,[r4,4h]
08040356 3804     sub     r0,4h
08040358 80A0     strh    r0,[r4,4h]
0804035A 4A08     ldr     r2,=30006BCh
0804035C 8811     ldrh    r1,[r2]
0804035E 2002     mov     r0,2h
08040360 4008     and     r0,r1
08040362 2800     cmp     r0,0h
08040364 D017     beq     8040396h
08040366 8AD0     ldrh    r0,[r2,16h]
08040368 2802     cmp     r0,2h
0804036A D10B     bne     8040384h
0804036C 7F10     ldrb    r0,[r2,1Ch]
0804036E 2801     cmp     r0,1h
08040370 D108     bne     8040384h
08040372 4803     ldr     r0,=1AFh
08040374 F7C2F9CA bl      800270Ch
08040378 E00D     b       8040396h
0804037A 0000     lsl     r0,r0,0h
0804037C 06BC     lsl     r4,r7,1Ah
0804037E 0300     lsl     r0,r0,0Ch
08040380 01AF     lsl     r7,r5,6h
08040382 0000     lsl     r0,r0,0h
08040384 8AD0     ldrh    r0,[r2,16h]
08040386 2806     cmp     r0,6h
08040388 D105     bne     8040396h
0804038A 7F10     ldrb    r0,[r2,1Ch]
0804038C 2801     cmp     r0,1h
0804038E D102     bne     8040396h
08040390 4807     ldr     r0,=1AFh
08040392 F7C2F9BB bl      800270Ch
08040396 F7FFFCC7 bl      803FD28h
0804039A 0600     lsl     r0,r0,18h
0804039C 2800     cmp     r0,0h
0804039E D137     bne     8040410h
080403A0 2F01     cmp     r7,1h
080403A2 D109     bne     80403B8h
080403A4 4803     ldr     r0,=30006BCh
080403A6 3024     add     r0,24h
080403A8 2109     mov     r1,9h
080403AA 7001     strb    r1,[r0]
080403AC E030     b       8040410h
080403AE 0000     lsl     r0,r0,0h
080403B0 01AF     lsl     r7,r5,6h
080403B2 0000     lsl     r0,r0,0h
080403B4 06BC     lsl     r4,r7,1Ah
080403B6 0300     lsl     r0,r0,0Ch
080403B8 2F02     cmp     r7,2h
080403BA D109     bne     80403D0h
080403BC 4903     ldr     r1,=30006BCh
080403BE 1C0A     mov     r2,r1
080403C0 3224     add     r2,24h
080403C2 2017     mov     r0,17h
080403C4 7010     strb    r0,[r2]
080403C6 312F     add     r1,2Fh
080403C8 2001     mov     r0,1h
080403CA E020     b       804040Eh
080403CC 06BC     lsl     r4,r7,1Ah
080403CE 0300     lsl     r0,r0,0Ch
080403D0 4A09     ldr     r2,=30006BCh
080403D2 1C10     mov     r0,r2
080403D4 302E     add     r0,2Eh
080403D6 7800     ldrb    r0,[r0]
080403D8 2800     cmp     r0,0h
080403DA D119     bne     8040410h
080403DC 8811     ldrh    r1,[r2]
080403DE 2040     mov     r0,40h
080403E0 4008     and     r0,r1
080403E2 2800     cmp     r0,0h
080403E4 D00A     beq     80403FCh
080403E6 8910     ldrh    r0,[r2,8h]
080403E8 2180     mov     r1,80h
080403EA 0049     lsl     r1,r1,1h
080403EC 1840     add     r0,r0,r1
080403EE 8891     ldrh    r1,[r2,4h]
080403F0 4288     cmp     r0,r1
080403F2 DA0D     bge     8040410h
080403F4 E008     b       8040408h
080403F6 0000     lsl     r0,r0,0h
080403F8 06BC     lsl     r4,r7,1Ah
080403FA 0300     lsl     r0,r0,0Ch
080403FC 8910     ldrh    r0,[r2,8h]
080403FE 4906     ldr     r1,=0FFFFFF00h
08040400 1840     add     r0,r0,r1
08040402 8891     ldrh    r1,[r2,4h]
08040404 4288     cmp     r0,r1
08040406 DD03     ble     8040410h
08040408 1C11     mov     r1,r2
0804040A 3124     add     r1,24h
0804040C 2009     mov     r0,9h
0804040E 7008     strb    r0,[r1]
08040410 BCF0     pop     r4-r7
08040412 BC01     pop     r0
08040414 4700     bx      r0
08040416 0000     lsl     r0,r0,0h
08040418 FF00FFFF ????
0804041A FFFF4905 ????
0804041C 4905     ldr     r1,=30006BCh
0804041E 1C0A     mov     r2,r1
08040420 3224     add     r2,24h
08040422 2300     mov     r3,0h
08040424 2004     mov     r0,4h
08040426 7010     strb    r0,[r2]
08040428 4803     ldr     r0,=835C328h
0804042A 6188     str     r0,[r1,18h]
0804042C 770B     strb    r3,[r1,1Ch]
0804042E 82CB     strh    r3,[r1,16h]
08040430 4770     bx      r14
08040432 0000     lsl     r0,r0,0h
08040434 06BC     lsl     r4,r7,1Ah
08040436 0300     lsl     r0,r0,0Ch
08040438 C328     stmia   [r3]!,r3,r5
0804043A 0835     lsr     r5,r6,20h
0804043C B500     push    lr
0804043E F7D1FA79 bl      8011934h
08040442 2800     cmp     r0,0h
08040444 D00D     beq     8040462h
08040446 4A08     ldr     r2,=30006BCh
08040448 1C11     mov     r1,r2
0804044A 3124     add     r1,24h
0804044C 2300     mov     r3,0h
0804044E 2005     mov     r0,5h
08040450 7008     strb    r0,[r1]
08040452 4806     ldr     r0,=835C348h
08040454 6190     str     r0,[r2,18h]
08040456 7713     strb    r3,[r2,1Ch]
08040458 82D3     strh    r3,[r2,16h]
0804045A 8810     ldrh    r0,[r2]
0804045C 2140     mov     r1,40h
0804045E 4048     eor     r0,r1
08040460 8010     strh    r0,[r2]
08040462 BC01     pop     r0
08040464 4700     bx      r0
08040466 0000     lsl     r0,r0,0h
08040468 06BC     lsl     r4,r7,1Ah
0804046A 0300     lsl     r0,r0,0Ch
0804046C C348     stmia   [r3]!,r3,r6
0804046E 0835     lsr     r5,r6,20h
08040470 B500     push    lr
08040472 F7D1FA7B bl      801196Ch
08040476 2800     cmp     r0,0h
08040478 D00F     beq     804049Ah
0804047A 4905     ldr     r1,=30006BCh
0804047C 1C0A     mov     r2,r1
0804047E 322F     add     r2,2Fh
08040480 7810     ldrb    r0,[r2]
08040482 2800     cmp     r0,0h
08040484 D006     beq     8040494h
08040486 2000     mov     r0,0h
08040488 7010     strb    r0,[r2]
0804048A 3124     add     r1,24h
0804048C 2029     mov     r0,29h
0804048E E003     b       8040498h
08040490 06BC     lsl     r4,r7,1Ah
08040492 0300     lsl     r0,r0,0Ch
08040494 3124     add     r1,24h
08040496 2001     mov     r0,1h
08040498 7008     strb    r0,[r1]
0804049A BC01     pop     r0
0804049C 4700     bx      r0
0804049E 0000     lsl     r0,r0,0h
080404A0 4904     ldr     r1,=30006BCh
080404A2 4805     ldr     r0,=835C2D8h
080404A4 6188     str     r0,[r1,18h]
080404A6 2000     mov     r0,0h
080404A8 7708     strb    r0,[r1,1Ch]
080404AA 82C8     strh    r0,[r1,16h]
080404AC 3124     add     r1,24h
080404AE 2018     mov     r0,18h
080404B0 7008     strb    r0,[r1]
080404B2 4770     bx      r14
080404B4 06BC     lsl     r4,r7,1Ah
080404B6 0300     lsl     r0,r0,0Ch
080404B8 C2D8     stmia   [r2]!,r3,r4,r6,r7
080404BA 0835     lsr     r5,r6,20h
080404BC B500     push    lr
080404BE F7D1FA55 bl      801196Ch
080404C2 2800     cmp     r0,0h
080404C4 D017     beq     80404F6h
080404C6 4B0D     ldr     r3,=30006BCh
080404C8 480D     ldr     r0,=835C300h
080404CA 6198     str     r0,[r3,18h]
080404CC 2000     mov     r0,0h
080404CE 7718     strb    r0,[r3,1Ch]
080404D0 2200     mov     r2,0h
080404D2 82D8     strh    r0,[r3,16h]
080404D4 1C19     mov     r1,r3
080404D6 3124     add     r1,24h
080404D8 201A     mov     r0,1Ah
080404DA 7008     strb    r0,[r1]
080404DC 1C18     mov     r0,r3
080404DE 3031     add     r0,31h
080404E0 7002     strb    r2,[r0]
080404E2 4808     ldr     r0,=0FF60h
080404E4 8158     strh    r0,[r3,0Ah]
080404E6 8819     ldrh    r1,[r3]
080404E8 2002     mov     r0,2h
080404EA 4008     and     r0,r1
080404EC 2800     cmp     r0,0h
080404EE D002     beq     80404F6h
080404F0 4805     ldr     r0,=1ADh
080404F2 F7C2F9AF bl      8002854h
080404F6 BC01     pop     r0
080404F8 4700     bx      r0
080404FA 0000     lsl     r0,r0,0h
080404FC 06BC     lsl     r4,r7,1Ah
080404FE 0300     lsl     r0,r0,0Ch
08040500 C300     stmia   [r3]!,
08040502 0835     lsr     r5,r6,20h
08040504 FF600000 ????
08040506 0000     lsl     r0,r0,0h
08040508 01AD     lsl     r5,r5,6h
0804050A 0000     lsl     r0,r0,0h
0804050C B570     push    r4-r6,lr
0804050E 2600     mov     r6,0h
08040510 4C0D     ldr     r4,=30006BCh
08040512 8821     ldrh    r1,[r4]
08040514 2040     mov     r0,40h
08040516 4008     and     r0,r1
08040518 2800     cmp     r0,0h
0804051A D019     beq     8040550h
0804051C 8860     ldrh    r0,[r4,2h]
0804051E 3810     sub     r0,10h
08040520 88A1     ldrh    r1,[r4,4h]
08040522 3140     add     r1,40h
08040524 F7D0FF34 bl      8011390h
08040528 4D08     ldr     r5,=30007A5h
0804052A 7828     ldrb    r0,[r5]
0804052C 2811     cmp     r0,11h
0804052E D022     beq     8040576h
08040530 8860     ldrh    r0,[r4,2h]
08040532 3850     sub     r0,50h
08040534 88A1     ldrh    r1,[r4,4h]
08040536 3140     add     r1,40h
08040538 F7D0FF2A bl      8011390h
0804053C 7828     ldrb    r0,[r5]
0804053E 2811     cmp     r0,11h
08040540 D019     beq     8040576h
08040542 88A0     ldrh    r0,[r4,4h]
08040544 300A     add     r0,0Ah
08040546 E01D     b       8040584h
08040548 06BC     lsl     r4,r7,1Ah
0804054A 0300     lsl     r0,r0,0Ch
0804054C 07A5     lsl     r5,r4,1Eh
0804054E 0300     lsl     r0,r0,0Ch
08040550 8860     ldrh    r0,[r4,2h]
08040552 3810     sub     r0,10h
08040554 88A1     ldrh    r1,[r4,4h]
08040556 3940     sub     r1,40h
08040558 F7D0FF1A bl      8011390h
0804055C 4D07     ldr     r5,=30007A5h
0804055E 7828     ldrb    r0,[r5]
08040560 2811     cmp     r0,11h
08040562 D008     beq     8040576h
08040564 8860     ldrh    r0,[r4,2h]
08040566 3850     sub     r0,50h
08040568 88A1     ldrh    r1,[r4,4h]
0804056A 3940     sub     r1,40h
0804056C F7D0FF10 bl      8011390h
08040570 7828     ldrb    r0,[r5]
08040572 2811     cmp     r0,11h
08040574 D104     bne     8040580h
08040576 2601     mov     r6,1h
08040578 E005     b       8040586h
0804057A 0000     lsl     r0,r0,0h
0804057C 07A5     lsl     r5,r4,1Eh
0804057E 0300     lsl     r0,r0,0Ch
08040580 88A0     ldrh    r0,[r4,4h]
08040582 380A     sub     r0,0Ah
08040584 80A0     strh    r0,[r4,4h]
08040586 490B     ldr     r1,=30006BCh
08040588 1C08     mov     r0,r1
0804058A 302F     add     r0,2Fh
0804058C 7800     ldrb    r0,[r0]
0804058E 1C0C     mov     r4,r1
08040590 2800     cmp     r0,0h
08040592 D013     beq     80405BCh
08040594 4808     ldr     r0,=8359A10h
08040596 1C22     mov     r2,r4
08040598 3231     add     r2,31h
0804059A 7811     ldrb    r1,[r2]
0804059C 0849     lsr     r1,r1,1h
0804059E 0049     lsl     r1,r1,1h
080405A0 1809     add     r1,r1,r0
080405A2 8809     ldrh    r1,[r1]
080405A4 8860     ldrh    r0,[r4,2h]
080405A6 1840     add     r0,r0,r1
080405A8 8060     strh    r0,[r4,2h]
080405AA 7810     ldrb    r0,[r2]
080405AC 2812     cmp     r0,12h
080405AE D815     bhi     80405DCh
080405B0 E012     b       80405D8h
080405B2 0000     lsl     r0,r0,0h
080405B4 06BC     lsl     r4,r7,1Ah
080405B6 0300     lsl     r0,r0,0Ch
080405B8 9A10     ldr     r2,[sp,40h]
080405BA 0835     lsr     r5,r6,20h
