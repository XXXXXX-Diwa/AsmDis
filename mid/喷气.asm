0804A5E4 B570     push    r4-r6,lr
0804A5E6 4917     ldr     r1,=3000738h
0804A5E8 1C0A     mov     r2,r1
0804A5EA 3226     add     r2,26h
0804A5EC 2001     mov     r0,1h            ;待机值写入1
0804A5EE 7010     strb    r0,[r2]
0804A5F0 2600     mov     r6,0h
0804A5F2 3A02     sub     r2,2h
0804A5F4 7810     ldrb    r0,[r2]          ;读取pose
0804A5F6 1C0C     mov     r4,r1
0804A5F8 2800     cmp     r0,0h
0804A5FA D000     beq     @@PoseZero
0804A5FC E0D5     b       @@OtherPose

@@PoseZero:
0804A5FE 2009     mov     r0,9h
0804A600 7010     strb    r0,[r2]          ;Pose写入9
0804A602 7F60     ldrb    r0,[r4,1Dh]      ;读取ID
0804A604 28A8     cmp     r0,0A8h
0804A606 D100     bne     @@Pass
0804A608 2601     mov     r6,1h

@@Pass:
0804A60A 1C20     mov     r0,r4
0804A60C 302D     add     r0,2Dh
0804A60E 7006     strb    r6,[r0]          ;偏移2D写入1代表是A8非A9
0804A610 8860     ldrh    r0,[r4,2h]
0804A612 88A1     ldrh    r1,[r4,4h]       ;读取坐标
0804A614 F7C5F884 bl      800F720h         ;检查身下是否有砖
0804A618 25F0     mov     r5,0F0h
0804A61A 4028     and     r0,r5
0804A61C 2800     cmp     r0,0h
0804A61E D01C     beq     @@NoBlock
;身下有砖
0804A620 8821     ldrh    r1,[r4]
0804A622 4809     ldr     r0,=0FBFFh
0804A624 4008     and     r0,r1
0804A626 8020     strh    r0,[r4]     
0804A628 2E00     cmp     r6,0h            ;有砖块则去掉取向的400h
0804A62A D00F     beq     @@IDA9
0804A62C 1C21     mov     r1,r4
0804A62E 3127     add     r1,27h
0804A630 2048     mov     r0,48h
0804A632 7008     strb    r0,[r1]          ;上视界写入48h
0804A634 1C20     mov     r0,r4
0804A636 3028     add     r0,28h
0804A638 2108     mov     r1,8h
0804A63A 7001     strb    r1,[r0]          ;左右视界写入8
0804A63C 3001     add     r0,1h
0804A63E 7001     strb    r1,[r0]          ;下视界写入1
0804A640 E081     b       @@Peer
.pool

@@IDA9:
0804A64C 1C21     mov     r1,r4
0804A64E 3127     add     r1,27h
0804A650 2028     mov     r0,28h
0804A652 7008     strb    r0,[r1]          ;上视界写入28
0804A654 3101     add     r1,1h
0804A656 2004     mov     r0,4h
0804A658 E028     b       @@WriteSee

@@NoBlock:;身下无砖
0804A65A 8860     ldrh    r0,[r4,2h]
0804A65C 3844     sub     r0,44h
0804A65E 88A1     ldrh    r1,[r4,4h]
0804A660 F7C5F85E bl      800F720h
0804A664 4028     and     r0,r5
0804A666 2800     cmp     r0,0h
0804A668 D025     beq     @@NoBlock2
;上一格有砖
0804A66A 8821     ldrh    r1,[r4]
0804A66C 480B     ldr     r0,=0FBFFh
0804A66E 4008     and     r0,r1
0804A670 2280     mov     r2,80h
0804A672 0052     lsl     r2,r2,1h   ;取向去掉400加上100再写入
0804A674 1C11     mov     r1,r2
0804A676 4308     orr     r0,r1
0804A678 8020     strh    r0,[r4]
0804A67A 8860     ldrh    r0,[r4,2h]
0804A67C 3840     sub     r0,40h
0804A67E 8060     strh    r0,[r4,2h] ;Y坐标向上一格
0804A680 2E00     cmp     r6,0h
0804A682 D00D     beq     @@WriteSamllsee
0804A684 1C20     mov     r0,r4
0804A686 3027     add     r0,27h
0804A688 2208     mov     r2,8h
0804A68A 7002     strb    r2,[r0]    ;上视界写入8
0804A68C 1C21     mov     r1,r4
0804A68E 3128     add     r1,28h
0804A690 2048     mov     r0,48h
0804A692 7008     strb    r0,[r1]    ;左右视界写入48h
0804A694 1C20     mov     r0,r4
0804A696 3029     add     r0,29h
0804A698 7002     strb    r2,[r0]    ;下视界写入8
0804A69A E054     b       @@Peer
.pool

@@WriteSamllsee:
0804A6A0 1C21     mov     r1,r4
0804A6A2 3127     add     r1,27h
0804A6A4 2004     mov     r0,4h
0804A6A6 7008     strb    r0,[r1]    ;上视界写入4
0804A6A8 3101     add     r1,1h
0804A6AA 2028     mov     r0,28h

@@WriteSee:
0804A6AC 7008     strb    r0,[r1]
0804A6AE 3101     add     r1,1h
0804A6B0 2008     mov     r0,8h
0804A6B2 7008     strb    r0,[r1]
0804A6B4 E047     b       @@Peer

@@NoBlock2:                          ;身上身下都无砖
0804A6B6 2E00     cmp     r6,0h
0804A6B8 D009     beq     @@Small
0804A6BA 1C20     mov     r0,r4
0804A6BC 3027     add     r0,27h
0804A6BE 2108     mov     r1,8h
0804A6C0 7001     strb    r1,[r0]    ;上视界写入8
0804A6C2 3001     add     r0,1h
0804A6C4 7001     strb    r1,[r0]    ;左右视界写入8h
0804A6C6 1C21     mov     r1,r4
0804A6C8 3129     add     r1,29h
0804A6CA 2048     mov     r0,48h     ;下视界写入48h
0804A6CC E008     b       @@Peer2

@@Small:
0804A6CE 1C20     mov     r0,r4
0804A6D0 3027     add     r0,27h
0804A6D2 2108     mov     r1,8h
0804A6D4 7001     strb    r1,[r0]    ;上视界写入8h
0804A6D6 3001     add     r0,1h
0804A6D8 7001     strb    r1,[r0]    ;左右视界写入8h
0804A6DA 1C21     mov     r1,r4
0804A6DC 3129     add     r1,29h
0804A6DE 2030     mov     r0,30h     ;下视界写入30h

@@Peer2:
0804A6E0 7008     strb    r0,[r1]
0804A6E2 4C0B     ldr     r4,=3000738h
0804A6E4 8860     ldrh    r0,[r4,2h]
0804A6E6 3820     sub     r0,20h     ;检查左边是否有砖块
0804A6E8 88A1     ldrh    r1,[r4,4h]
0804A6EA 3924     sub     r1,24h
0804A6EC F7C5F818 bl      800F720h
0804A6F0 25F0     mov     r5,0F0h
0804A6F2 4028     and     r0,r5
0804A6F4 2800     cmp     r0,0h
0804A6F6 D00D     beq     @@NoBlock3

;左边有砖
0804A6F8 8821     ldrh    r1,[r4]
0804A6FA 2280     mov     r2,80h
0804A6FC 00D2     lsl     r2,r2,3h         ;取向加上400h
0804A6FE 1C10     mov     r0,r2
0804A700 4308     orr     r0,r1
0804A702 8020     strh    r0,[r4]          ;再写入
0804A704 8860     ldrh    r0,[r4,2h]
0804A706 3820     sub     r0,20h
0804A708 8060     strh    r0,[r4,2h]       ;Y坐标向上提升半格
0804A70A 88A0     ldrh    r0,[r4,4h]
0804A70C 3820     sub     r0,20h           ;X坐标向左半格
0804A70E E019     b       @@WriteX
.pool

@@NoBlock3:                        ;上下左都无砖
0804A714 8860     ldrh    r0,[r4,2h]
0804A716 3820     sub     r0,20h
0804A718 88A1     ldrh    r1,[r4,4h]
0804A71A 3120     add     r1,20h
0804A71C F7C5F800 bl      800F720h     ;检查右边是否有砖
0804A720 4028     and     r0,r5
0804A722 2800     cmp     r0,0h
0804A724 D101     bne     @@HaveBlock
0804A726 8020     strh    r0,[r4]
0804A728 E05B     b       @@end

@@HaveBlock:                    ;右边有砖
0804A72A 8821     ldrh    r1,[r4]
0804A72C 2280     mov     r2,80h
0804A72E 00D2     lsl     r2,r2,3h   ;取向加上400h
0804A730 1C10     mov     r0,r2
0804A732 4308     orr     r0,r1
0804A734 2140     mov     r1,40h
0804A736 4308     orr     r0,r1
0804A738 8020     strh    r0,[r4]    ;再加上40h写入
0804A73A 8860     ldrh    r0,[r4,2h]
0804A73C 3820     sub     r0,20h
0804A73E 8060     strh    r0,[r4,2h] ;Y坐标向上半格
0804A740 88A0     ldrh    r0,[r4,4h] ;X坐标向右半格
0804A742 3020     add     r0,20h

@@WriteX:
0804A744 80A0     strh    r0,[r4,4h]

@@Peer:
0804A746 4A06     ldr     r2,=3000738h
0804A748 8811     ldrh    r1,[r2]
0804A74A 2080     mov     r0,80h
0804A74C 00C0     lsl     r0,r0,3h
0804A74E 4008     and     r0,r1
0804A750 1C14     mov     r4,r2	
0804A752 2800     cmp     r0,0h
0804A754 D00C     beq     @@UpDown				
0804A756 2E00     cmp     r6,0h
0804A758 D006     beq     @@LeftRightSmall
0804A75A 4802     ldr     r0,=831915Ch  ;左右的OAM
0804A75C E00F     b       @@WriteOAM
.pool

@@LeftRightSmall:
0804A768 4800     ldr     r0,=831921Ch  ;左右小的OAM
0804A76A E008     b       @@WriteOAM
.pool

@@UpDown:
0804A770 2E00     cmp     r6,0h
0804A772 D003     beq     @@UpDownSmall
0804A774 4800     ldr     r0,=83191BCh  ;上下的OAM
0804A776 E002     b       @@WriteOAM
.pool

@@UpDownSmall:
0804A77C 4815     ldr     r0,=831926Ch  ;上下的小OAM

@@WriteOAM:
0804A77E 61A0     str     r0,[r4,18h]
0804A780 2100     mov     r1,0h
0804A782 7721     strb    r1,[r4,1Ch]
0804A784 4814     ldr     r0,=300083Ch
0804A786 7802     ldrb    r2,[r0]       ;读取随机值
0804A788 2007     mov     r0,7h
0804A78A 4010     and     r0,r2         ;and 7
0804A78C 2200     mov     r2,0h
0804A78E 82E0     strh    r0,[r4,16h]   ;写入精灵动画
0804A790 8161     strh    r1,[r4,0Ah]   ;四面分界全部为0
0804A792 81A1     strh    r1,[r4,0Ch]
0804A794 81E1     strh    r1,[r4,0Eh]
0804A796 8221     strh    r1,[r4,10h]
0804A798 1C20     mov     r0,r4
0804A79A 3025     add     r0,25h
0804A79C 7002     strb    r2,[r0]       ;属性写入0
0804A79E 1C22     mov     r2,r4
0804A7A0 3232     add     r2,32h
0804A7A2 7811     ldrb    r1,[r2]       ;读取碰撞属性
0804A7A4 2001     mov     r0,1h
0804A7A6 4308     orr     r0,r1         ;和1orr
0804A7A8 7010     strb    r0,[r2]       ;碰撞属性写入

@@OtherPose:
0804A7AA 8AE0     ldrh    r0,[r4,16h]
0804A7AC 2800     cmp     r0,0h
0804A7AE D118     bne     @@end         ;动画如果不为0则结束
0804A7B0 7F21     ldrb    r1,[r4,1Ch]
0804A7B2 2902     cmp     r1,2h
0804A7B4 D115     bne     @@end         ;动画帧不为2则结束
0804A7B6 8820     ldrh    r0,[r4]       ;读取取向
0804A7B8 4001     and     r1,r0         ;检查是否在屏幕内
0804A7BA 2900     cmp     r1,0h
0804A7BC D011     beq     @@end
0804A7BE 1C20     mov     r0,r4
0804A7C0 302D     add     r0,2Dh
0804A7C2 7800     ldrb    r0,[r0]      ;检查大小
0804A7C4 2800     cmp     r0,0h
0804A7C6 D009     beq     @@SmallSound
0804A7C8 209E     mov     r0,09Eh
0804A7CA 0080     lsl     r0,r0,2h
0804A7CC F7B8F9A8 bl      8002B20h
0804A7D0 E007     b       @@end
.pool

@@SmallSound:
0804A7DC 4802     ldr     r0,=279h
0804A7DE F7B8F99F bl      8002B20h

@@end:
0804A7E2 BC70     pop     r4-r6
0804A7E4 BC01     pop     r0
0804A7E6 4700     bx      r0
.pool

;斜蒸汽
0804A7EC B5F0     push    r4-r7,lr
0804A7EE 4815     ldr     r0,=3000738h
0804A7F0 1C01     mov     r1,r0
0804A7F2 3126     add     r1,26h
0804A7F4 2701     mov     r7,1h
0804A7F6 700F     strb    r7,[r1]       ;待机值写入1
0804A7F8 3902     sub     r1,2h
0804A7FA 780D     ldrb    r5,[r1]       ;读取pose
0804A7FC 1C04     mov     r4,r0
0804A7FE 2D00     cmp     r5,0h
0804A800 D175     bne     @@PoseNoZero
0804A802 2009     mov     r0,9h
0804A804 7008     strb    r0,[r1]       ;Pose写入9
0804A806 1C26     mov     r6,r4
0804A808 362D     add     r6,2Dh
0804A80A 7035     strb    r5,[r6]       ;偏移2D写入0
0804A80C 8860     ldrh    r0,[r4,2h]
0804A80E 3820     sub     r0,20h        ;向上半格
0804A810 88A1     ldrh    r1,[r4,4h]
0804A812 3924     sub     r1,24h        ;向左24h
0804A814 F7C4FF84 bl      800F720h      ;检查左边一格是否有砖
0804A818 0600     lsl     r0,r0,18h  
0804A81A 21F0     mov     r1,0F0h
0804A81C 0609     lsl     r1,r1,18h
0804A81E 4001     and     r1,r0
0804A820 2900     cmp     r1,0h
0804A822 D103     bne     @@LeftHaveBlock
0804A824 8821     ldrh    r1,[r4]
0804A826 2040     mov     r0,40h
0804A828 4308     orr     r0,r1
0804A82A 8020     strh    r0,[r4]       ;向右的话取向orr40

@@LeftHaveBlock:
0804A82C 7F60     ldrb    r0,[r4,1Dh]
0804A82E 28BF     cmp     r0,0BFh
0804A830 D10A     bne     @@PassBF
0804A832 7037     strb    r7,[r6]      ;偏移2D写入1 代表大
0804A834 1C21     mov     r1,r4
0804A836 3127     add     r1,27h
0804A838 2040     mov     r0,40h       ;上视界写入40h
0804A83A 7008     strb    r0,[r1]
0804A83C 3101     add     r1,1h
0804A83E 2008     mov     r0,8h        ;左右视界写入8h
0804A840 E01A     b       @@Write
.pool

@@PassBF:
0804A848 28C0     cmp     r0,0C0h
0804A84A D106     bne     @@PassC0
0804A84C 1C21     mov     r1,r4
0804A84E 3127     add     r1,27h
0804A850 2028     mov     r0,28h
0804A852 7008     strb    r0,[r1]      ;上视界写入28h
0804A854 3101     add     r1,1h
0804A856 2004     mov     r0,4h        ;左右视界写入4
0804A858 E026     b       @@WriteSmall

@@PassC0:
0804A85A 28C1     cmp     r0,0C1h
0804A85C D116     bne     @@PassC1
0804A85E 7037     strb    r7,[r6]	   ;2D写入1代表大
0804A860 8821     ldrh    r1,[r4]
0804A862 2280     mov     r2,80h
0804A864 0052     lsl     r2,r2,1h
0804A866 1C10     mov     r0,r2
0804A868 4308     orr     r0,r1
0804A86A 8020     strh    r0,[r4]      ;取向ORR 100h 倒立
0804A86C 1C21     mov     r1,r4
0804A86E 3127     add     r1,27h
0804A870 2008     mov     r0,8h        
0804A872 7008     strb    r0,[r1]      ;上视界写入8h
0804A874 3101     add     r1,1h
0804A876 2040     mov     r0,40h

@@Write:
0804A878 7008     strb    r0,[r1]      ;左右视界写入40
0804A87A 3101     add     r1,1h
0804A87C 2050     mov     r0,50h
0804A87E 7008     strb    r0,[r1]      ;下视界写入50
0804A880 4801     ldr     r0,=83192BCh ;斜的大
0804A882 61A0     str     r0,[r4,18h]
0804A884 E01C     b       @@Peer
.pool

@@PassC1:
0804A88C 28C2     cmp     r0,0C2h
0804A88E D115     bne     @@PassC2
0804A890 8821     ldrh    r1,[r4]
0804A892 2280     mov     r2,80h
0804A894 0052     lsl     r2,r2,1h
0804A896 1C10     mov     r0,r2
0804A898 4308     orr     r0,r1
0804A89A 8020     strh    r0,[r4]       ;取向orr100倒
0804A89C 1C21     mov     r1,r4
0804A89E 3127     add     r1,27h
0804A8A0 2004     mov     r0,4h         ;上视界写入4
0804A8A2 7008     strb    r0,[r1]
0804A8A4 3101     add     r1,1h
0804A8A6 2028     mov     r0,28h        ;左右视界写入28

@@WriteSmall:
0804A8A8 7008     strb    r0,[r1]
0804A8AA 3101     add     r1,1h
0804A8AC 2030     mov     r0,30h
0804A8AE 7008     strb    r0,[r1]       ;下视界写入30h
0804A8B0 4801     ldr     r0,=831931Ch  ;斜向的小
0804A8B2 61A0     str     r0,[r4,18h]
0804A8B4 E004     b       @@Peer
.pool

@@PassC2:
0804A8BC 8025     strh    r5,[r4]          ;取消精灵
0804A8BE E032     b       @@end

@@Peer:
0804A8C0 4B15     ldr     r3,=3000738h
0804A8C2 2100     mov     r1,0h
0804A8C4 7719     strb    r1,[r3,1Ch]      ;动画帧写入0h
0804A8C6 4815     ldr     r0,=300083Ch
0804A8C8 7802     ldrb    r2,[r0]
0804A8CA 2007     mov     r0,7h
0804A8CC 4010     and     r0,r2
0804A8CE 2200     mov     r2,0h            ;随机给予动画
0804A8D0 82D8     strh    r0,[r3,16h]
0804A8D2 8159     strh    r1,[r3,0Ah]
0804A8D4 8199     strh    r1,[r3,0Ch]
0804A8D6 81D9     strh    r1,[r3,0Eh]
0804A8D8 8219     strh    r1,[r3,10h]      ;四面分界全部为0
0804A8DA 1C18     mov     r0,r3
0804A8DC 3025     add     r0,25h
0804A8DE 7002     strb    r2,[r0]          ;属性写入0
0804A8E0 1C1A     mov     r2,r3
0804A8E2 3232     add     r2,32h
0804A8E4 7811     ldrb    r1,[r2]
0804A8E6 2001     mov     r0,1h
0804A8E8 4308     orr     r0,r1
0804A8EA 7010     strb    r0,[r2]          ;碰撞属性写入1
0804A8EC 1C1C     mov     r4,r3

@@PoseNoZero:
0804A8EE 8AE0     ldrh    r0,[r4,16h]
0804A8F0 2800     cmp     r0,0h            ;检查动画是否为0
0804A8F2 D118     bne     @@end
0804A8F4 7F21     ldrb    r1,[r4,1Ch]
0804A8F6 2902     cmp     r1,2h            ;检查动画帧是否为2
0804A8F8 D115     bne     @@end
0804A8FA 8820     ldrh    r0,[r4]
0804A8FC 4001     and     r1,r0
0804A8FE 2900     cmp     r1,0h            ;检查是否在屏幕内
0804A900 D011     beq     @@end
0804A902 1C20     mov     r0,r4
0804A904 302D     add     r0,2Dh
0804A906 7800     ldrb    r0,[r0]          ;检查是大是小
0804A908 2800     cmp     r0,0h
0804A90A D009     beq     @@SmallSound
0804A90C 209E     mov     r0,09Eh
0804A90E 0080     lsl     r0,r0,2h
0804A910 F7B8F906 bl      8002B20h
0804A914 E007     b       @@end
.pool

@@SmallSound:
0804A920 4802     ldr     r0,=279h
0804A922 F7B8F8FD bl      8002B20h

@@end:
0804A926 BCF0     pop     r4-r7
0804A928 BC01     pop     r0
0804A92A 4700     bx      r0
.pool

0804A930 B570     push    r4-r6,lr
0804A932 464E     mov     r6,r9
0804A934 4645     mov     r5,r8
0804A936 B460     push    r5,r6
0804A938 1C06     mov     r6,r0
0804A93A 0636     lsl     r6,r6,18h
0804A93C 0E36     lsr     r6,r6,18h
0804A93E 4816     ldr     r0,=3000738h
0804A940 8845     ldrh    r5,[r0,2h]
0804A942 3D20     sub     r5,20h
0804A944 042D     lsl     r5,r5,10h
0804A946 0C2D     lsr     r5,r5,10h
0804A948 8884     ldrh    r4,[r0,4h]
0804A94A 3C20     sub     r4,20h
0804A94C 0424     lsl     r4,r4,10h
0804A94E 0C24     lsr     r4,r4,10h
0804A950 4812     ldr     r0,=3000079h
0804A952 4680     mov     r8,r0
0804A954 7006     strb    r6,[r0]
0804A956 1C28     mov     r0,r5
0804A958 1C21     mov     r1,r4
0804A95A F00DFA8F bl      8057E7Ch
0804A95E 4640     mov     r0,r8
0804A960 7006     strb    r6,[r0]
0804A962 2040     mov     r0,40h
0804A964 1900     add     r0,r0,r4
0804A966 4681     mov     r9,r0
0804A968 1C28     mov     r0,r5
0804A96A 4649     mov     r1,r9
0804A96C F00DFA86 bl      8057E7Ch
0804A970 4640     mov     r0,r8
0804A972 7006     strb    r6,[r0]
0804A974 3540     add     r5,40h
0804A976 1C28     mov     r0,r5
0804A978 1C21     mov     r1,r4
0804A97A F00DFA7F bl      8057E7Ch
0804A97E 4640     mov     r0,r8
0804A980 7006     strb    r6,[r0]
0804A982 1C28     mov     r0,r5
0804A984 4649     mov     r1,r9
0804A986 F00DFA79 bl      8057E7Ch
0804A98A BC18     pop     r3,r4
0804A98C 4698     mov     r8,r3
0804A98E 46A1     mov     r9,r4
0804A990 BC70     pop     r4-r6
0804A992 BC01     pop     r0
0804A994 4700     bx      r0
0804A996 0000     lsl     r0,r0,0h
0804A998 0738     lsl     r0,r7,1Ch
0804A99A 0300     lsl     r0,r0,0Ch
0804A99C 0079     lsl     r1,r7,1h
0804A99E 0300     lsl     r0,r0,0Ch
0804A9A0 B5F0     push    r4-r7,lr
0804A9A2 B083     add     sp,-0Ch
0804A9A4 490B     ldr     r1,=3000738h
0804A9A6 1C08     mov     r0,r1
0804A9A8 3026     add     r0,26h
0804A9AA 2701     mov     r7,1h
0804A9AC 7007     strb    r7,[r0]
0804A9AE 2600     mov     r6,0h
0804A9B0 7F4D     ldrb    r5,[r1,1Dh]
0804A9B2 1C0B     mov     r3,r1
0804A9B4 3324     add     r3,24h
0804A9B6 7818     ldrb    r0,[r3]
0804A9B8 1C0C     mov     r4,r1
0804A9BA 2867     cmp     r0,67h
0804A9BC D06C     beq     804AA98h
0804A9BE 2867     cmp     r0,67h
0804A9C0 DD00     ble     804A9C4h
0804A9C2 E0D3     b       804AB6Ch
0804A9C4 2809     cmp     r0,9h
0804A9C6 D036     beq     804AA36h
0804A9C8 2809     cmp     r0,9h
0804A9CA DC05     bgt     804A9D8h
0804A9CC 2800     cmp     r0,0h
0804A9CE D007     beq     804A9E0h
0804A9D0 E0CC     b       804AB6Ch
0804A9D2 0000     lsl     r0,r0,0h
0804A9D4 0738     lsl     r0,r7,1Ch
0804A9D6 0300     lsl     r0,r0,0Ch
0804A9D8 280B     cmp     r0,0Bh
0804A9DA D100     bne     804A9DEh
0804A9DC E0EF     b       804ABBEh
0804A9DE E0C5     b       804AB6Ch
0804A9E0 8821     ldrh    r1,[r4]
0804A9E2 2280     mov     r2,80h
0804A9E4 0212     lsl     r2,r2,8h
0804A9E6 1C10     mov     r0,r2
0804A9E8 2200     mov     r2,0h
0804A9EA 4308     orr     r0,r1
0804A9EC 8020     strh    r0,[r4]
0804A9EE 1C20     mov     r0,r4
0804A9F0 3022     add     r0,22h
0804A9F2 7007     strb    r7,[r0]
0804A9F4 4912     ldr     r1,=0FFBCh
0804A9F6 8161     strh    r1,[r4,0Ah]
0804A9F8 2044     mov     r0,44h
0804A9FA 81A0     strh    r0,[r4,0Ch]
0804A9FC 81E1     strh    r1,[r4,0Eh]
0804A9FE 8220     strh    r0,[r4,10h]
0804AA00 1C20     mov     r0,r4
0804AA02 3027     add     r0,27h
0804AA04 2110     mov     r1,10h
0804AA06 7001     strb    r1,[r0]
0804AA08 3001     add     r0,1h
0804AA0A 7001     strb    r1,[r0]
0804AA0C 3001     add     r0,1h
0804AA0E 7001     strb    r1,[r0]
0804AA10 480C     ldr     r0,=831A490h
0804AA12 61A0     str     r0,[r4,18h]
0804AA14 7722     strb    r2,[r4,1Ch]
0804AA16 82E6     strh    r6,[r4,16h]
0804AA18 1C20     mov     r0,r4
0804AA1A 3025     add     r0,25h
0804AA1C 7002     strb    r2,[r0]
0804AA1E 82A7     strh    r7,[r4,14h]
0804AA20 2009     mov     r0,9h
0804AA22 7018     strb    r0,[r3]
0804AA24 8860     ldrh    r0,[r4,2h]
0804AA26 3840     sub     r0,40h
0804AA28 8060     strh    r0,[r4,2h]
0804AA2A 88A0     ldrh    r0,[r4,4h]
0804AA2C 3020     add     r0,20h
0804AA2E 80A0     strh    r0,[r4,4h]
0804AA30 2002     mov     r0,2h
0804AA32 F7FFFF7D bl      804A930h
0804AA36 2DAA     cmp     r5,0AAh
0804AA38 D106     bne     804AA48h
0804AA3A 2003     mov     r0,3h
0804AA3C 2118     mov     r1,18h
0804AA3E E00C     b       804AA5Ah
0804AA40 FFBC0000 ????
0804AA42 0000     lsl     r0,r0,0h
0804AA44 A490     add     r4,=804AC88h
0804AA46 0831     lsr     r1,r6,20h
0804AA48 2DAB     cmp     r5,0ABh
0804AA4A D102     bne     804AA52h
0804AA4C 2003     mov     r0,3h
0804AA4E 2117     mov     r1,17h
0804AA50 E003     b       804AA5Ah
0804AA52 2DAC     cmp     r5,0ACh
0804AA54 D108     bne     804AA68h
0804AA56 2003     mov     r0,3h
0804AA58 2116     mov     r1,16h
0804AA5A F015FF2F bl      80608BCh
0804AA5E 2800     cmp     r0,0h
0804AA60 D002     beq     804AA68h
0804AA62 1C70     add     r0,r6,1
0804AA64 0600     lsl     r0,r0,18h
0804AA66 0E06     lsr     r6,r0,18h
0804AA68 2E00     cmp     r6,0h
0804AA6A D100     bne     804AA6Eh
0804AA6C E0A7     b       804ABBEh
0804AA6E 4907     ldr     r1,=3000738h
0804AA70 4807     ldr     r0,=831A4A0h
0804AA72 6188     str     r0,[r1,18h]
0804AA74 2000     mov     r0,0h
0804AA76 7708     strb    r0,[r1,1Ch]
0804AA78 82C8     strh    r0,[r1,16h]
0804AA7A 880A     ldrh    r2,[r1]
0804AA7C 4805     ldr     r0,=7FFFh
0804AA7E 4010     and     r0,r2
0804AA80 8008     strh    r0,[r1]
0804AA82 3124     add     r1,24h
0804AA84 200B     mov     r0,0Bh
0804AA86 7008     strb    r0,[r1]
0804AA88 E099     b       804ABBEh
0804AA8A 0000     lsl     r0,r0,0h
0804AA8C 0738     lsl     r0,r7,1Ch
0804AA8E 0300     lsl     r0,r0,0Ch
0804AA90 A4A0     add     r4,=804AD14h
0804AA92 0831     lsr     r1,r6,20h
0804AA94 7FFF     ldrb    r7,[r7,1Fh]
0804AA96 0000     lsl     r0,r0,0h
0804AA98 F7C5F896 bl      800FBC8h
0804AA9C 1C05     mov     r5,r0
0804AA9E 2D00     cmp     r5,0h
0804AAA0 D001     beq     804AAA6h
0804AAA2 8026     strh    r6,[r4]
0804AAA4 E08B     b       804ABBEh
0804AAA6 8AE0     ldrh    r0,[r4,16h]
0804AAA8 2801     cmp     r0,1h
0804AAAA D106     bne     804AABAh
0804AAAC 1C20     mov     r0,r4
0804AAAE 3027     add     r0,27h
0804AAB0 2130     mov     r1,30h
0804AAB2 7001     strb    r1,[r0]
0804AAB4 3001     add     r0,1h
0804AAB6 7001     strb    r1,[r0]
0804AAB8 E081     b       804ABBEh
0804AABA 2808     cmp     r0,8h
0804AABC D107     bne     804AACEh
0804AABE 1C21     mov     r1,r4
0804AAC0 3127     add     r1,27h
0804AAC2 2060     mov     r0,60h
0804AAC4 7008     strb    r0,[r1]
0804AAC6 1C20     mov     r0,r4
0804AAC8 3028     add     r0,28h
0804AACA 7005     strb    r5,[r0]
0804AACC E077     b       804ABBEh
0804AACE 2807     cmp     r0,7h
0804AAD0 D175     bne     804ABBEh
0804AAD2 7F20     ldrb    r0,[r4,1Ch]
0804AAD4 2802     cmp     r0,2h
0804AAD6 D172     bne     804ABBEh
0804AAD8 7FE2     ldrb    r2,[r4,1Fh]
0804AADA 1C20     mov     r0,r4
0804AADC 3023     add     r0,23h
0804AADE 7803     ldrb    r3,[r0]
0804AAE0 8860     ldrh    r0,[r4,2h]
0804AAE2 9000     str     r0,[sp]
