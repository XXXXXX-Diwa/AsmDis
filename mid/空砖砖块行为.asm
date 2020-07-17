0805A7A0>B5F0     push    r4-r7,lr
0805A7A2 4647     mov     r7,r8
0805A7A4 B480     push    r7
0805A7A6 4D2C     ldr     r5,=30013D4h
0805A7A8 2118     mov     r1,18h
0805A7AA 5E68     ldsh    r0,[r5,r1]     ;读取Y加速度
0805A7AC 0FC3     lsr     r3,r0,1Fh      ;只有下落的时候才为1
0805A7AE 4C2B     ldr     r4,=3001588h
0805A7B0 1C20     mov     r0,r4
0805A7B2 3056     add     r0,56h
0805A7B4 7800     ldrb    r0,[r0]        ;读取人物状态
0805A7B6 2803     cmp     r0,3h
0805A7B8 D100     bne     @@Pass
0805A7BA 3301     add     r3,1h

@@Pass:
0805A7BC 2B00     cmp     r3,0h          ;下落则跳过
0805A7BE D16E     bne     @@end
0805A7C0 8A69     ldrh    r1,[r5,12h]    ;读取X坐标
0805A7C2 1C20     mov     r0,r4
0805A7C4 3072     add     r0,72h      
0805A7C6 2200     mov     r2,0h
0805A7C8 5E80     ldsh    r0,[r0,r2]     ;人右分界
0805A7CA 180B     add     r3,r1,r0       ;加上X坐标
0805A7CC 0298     lsl     r0,r3,0Ah
0805A7CE 0C06     lsr     r6,r0,10h      ;得到右边接触的格数
0805A7D0 4A23     ldr     r2,=300009Ch
0805A7D2 8B93     ldrh    r3,[r2,1Ch]    ;读取房间最大宽度格数
0805A7D4 429E     cmp     r6,r3          ;检查右边接触的格数是否小于
0805A7D6 D900     bls     @@NoOut
0805A7D8 8B96     ldrh    r6,[r2,1Ch]    

@@NoOut:
0805A7DA 1C20     mov     r0,r4
0805A7DC 306E     add     r0,6Eh
0805A7DE 2300     mov     r3,0h
0805A7E0 5EC0     ldsh    r0,[r0,r3]     ;读取人物左分界
0805A7E2 180B     add     r3,r1,r0       ;加上X坐标
0805A7E4 2B00     cmp     r3,0h           
0805A7E6 DA00     bge     @@NoOut2      
0805A7E8 2300     mov     r3,0h

@@NoOut2:
0805A7EA 0298     lsl     r0,r3,0Ah
0805A7EC 0C01     lsr     r1,r0,10h      ;得到人物左部接触的格数
0805A7EE 1C20     mov     r0,r4
0805A7F0 3074     add     r0,74h
0805A7F2 2300     mov     r3,0h
0805A7F4 5EC0     ldsh    r0,[r0,r3]     ;读取人物下部分界
0805A7F6 8AAD     ldrh    r5,[r5,14h]    ;读取人物Y坐标
0805A7F8 1943     add     r3,r0,r5       
0805A7FA 1C98     add     r0,r3,2        ;下部分界再加2????
0805A7FC 0280     lsl     r0,r0,0Ah
0805A7FE 0C05     lsr     r5,r0,10h      ;得到站立的脚底格数?
0805A800 8BD0     ldrh    r0,[r2,1Eh]    ;房间最大高度格数
0805A802 4285     cmp     r5,r0
0805A804 D900     bls     @@NoOut3
0805A806 8BD5     ldrh    r5,[r2,1Eh]

@@NoOut3:
0805A808 1C0C     mov     r4,r1
0805A80A 42B4     cmp     r4,r6          ;人物左边接触的格数和右边相比
0805A80C D847     bhi     @@end          ;大于则结束 不可能大于吧...
0805A80E 4915     ldr     r1,=3005450h
0805A810 4688     mov     r8,r1
0805A812 4F15     ldr     r7,=401h

@@Loop:
0805A814 4912     ldr     r1,=300009Ch
0805A816 8B88     ldrh    r0,[r1,1Ch]    ;读取房间最大宽度格数
0805A818 4368     mul     r0,r5          ;乘以脚底的高度格数
0805A81A 1900     add     r0,r0,r4       ;加上左部格数
0805A81C 6989     ldr     r1,[r1,18h]    ;得到指针
0805A81E 0040     lsl     r0,r0,1h       ;数据乘以2
0805A820 1840     add     r0,r0,r1       ;加上偏移
0805A822 8800     ldrh    r0,[r0]        ;读取砖块序号
0805A824 4642     mov     r2,r8          
0805A826 6891     ldr     r1,[r2,8h]     ;读取砖块行为指针
0805A828 0040     lsl     r0,r0,1h       ;序号乘以2
0805A82A 1840     add     r0,r0,r1       ;加上偏移
0805A82C 8803     ldrh    r3,[r0]        ;读取行为号
0805A82E 2B23     cmp     r3,23h         ;比较是否是23 空砖
0805A830 D11C     bne     @@NoAirBlock
0805A832 2300     mov     r3,0h
0805A834 4908     ldr     r1,=30013D4h
0805A836 7808     ldrb    r0,[r1]        ;读取姿势
0805A838 2800     cmp     r0,0h          ;奔跑姿势
0805A83A D001     beq     @@runing
0805A83C 2812     cmp     r0,12h         ;球滚姿势
0805A83E D103     bne     @@NoSparkingFlag      

@@runing:
0805A840 7948     ldrb    r0,[r1,5h]     ;检查金身flag
0805A842 2800     cmp     r0,0h
0805A844 D000     beq     @@NoSparkingFlag
0805A846 2301     mov     r3,1h

@@NoSparkingFlag:
0805A848 061B     lsl     r3,r3,18h
0805A84A 0E1B     lsr     r3,r3,18h
0805A84C 2004     mov     r0,4h
0805A84E 1C21     mov     r1,r4
0805A850 1C2A     mov     r2,r5
0805A852 F7FFFAA9 bl      8059DA8h    
0805A856 E01D     b       @@Peer

@@NoAirBlock:
0805A86C 2B2E     cmp     r3,2Eh      ;缓慢的空砖
0805A86E D111     bne     @@Peer
0805A870 2005     mov     r0,5h
0805A872 1C21     mov     r1,r4
0805A874 1C2A     mov     r2,r5
0805A876 2301     mov     r3,1h
0805A878 F7FFFA96 bl      8059DA8h
0805A87C 2800     cmp     r0,0h
0805A87E D009     beq     @@Peer
0805A880 1C38     mov     r0,r7
0805A882 1C29     mov     r1,r5
0805A884 1C22     mov     r2,r4
0805A886 F7FFFE69 bl      805A55Ch   ;生成新的图像
0805A88A 1C38     mov     r0,r7
0805A88C 1C29     mov     r1,r5
0805A88E 1C22     mov     r2,r4
0805A890 F7FFFEDC bl      805A64Ch   ;新的clip值

@@Peer:
0805A894 1C60     add     r0,r4,1
0805A896 0400     lsl     r0,r0,10h
0805A898 0C04     lsr     r4,r0,10h
0805A89A 42B4     cmp     r4,r6
0805A89C D9BA     bls     @@Loop

@@end:
0805A89E BC08     pop     r3
0805A8A0 4698     mov     r8,r3
0805A8A2 BCF0     pop     r4-r7
0805A8A4 BC01     pop     r0
0805A8A6 4700     bx      r0



08059DA8 B5F0     push    r4-r7,lr
08059DAA 4647     mov     r7,r8
08059DAC B480     push    r7
08059DAE 0600     lsl     r0,r0,18h
08059DB0 0E00     lsr     r0,r0,18h       ;砖块类型,快为3 慢为5
08059DB2 4684     mov     r12,r0
08059DB4 0409     lsl     r1,r1,10h
08059DB6 0C0E     lsr     r6,r1,10h		  ;Y格数
08059DB8 0412     lsl     r2,r2,10h
08059DBA 0C15     lsr     r5,r2,10h		  ;X格数
08059DBC 061B     lsl     r3,r3,18h       ;为0最快,1则是金身空砖,2则是缓慢空砖
08059DBE 0E1B     lsr     r3,r3,18h
08059DC0 4698     mov     r8,r3
08059DC2 2100     mov     r1,0h
08059DC4 4C01     ldr     r4,=3005528h
08059DC6 2300     mov     r3,0h
08059DC8 1C27     mov     r7,r4
08059DCA E00D     b       @@Goto
.pool

@@FreeSpace:
08059DD0 2280     mov     r2,80h
08059DD2 1C08     mov     r0,r1
08059DD4 4010     and     r0,r2
08059DD6 2800     cmp     r0,0h
08059DD8 D104     bne     @@Pass
08059DDA 7860     ldrb    r0,[r4,1h]     ;读取阶段
08059DDC 2800     cmp     r0,0h
08059DDE D101     bne     @@Pass
08059DE0 1C19     mov     r1,r3
08059DE2 4311     orr     r1,r2

@@Pass:
08059DE4 3301     add     r3,1h
08059DE6 3408     add     r4,8h

@@Goto:
08059DE8 2B2F     cmp     r3,2Fh
08059DEA DC0A     bgt     8059E02h
08059DEC 78E0     ldrb    r0,[r4,3h]	
08059DEE 42B0     cmp     r0,r6
08059DF0 D1EE     bne     @@FreeSpace
08059DF2 7920     ldrb    r0,[r4,4h]
08059DF4 42A8     cmp     r0,r5
08059DF6 D1EB     bne     @@FreeSpace
08059DF8 7860     ldrb    r0,[r4,1h]
08059DFA 2100     mov     r1,0h
08059DFC 2800     cmp     r0,0h
08059DFE D100     bne     8059E02h
08059E00 2101     mov     r1,1h

@@
08059E02 2900     cmp     r1,0h
08059E04 D020     beq     8059E48h
08059E06 2901     cmp     r1,1h
08059E08 D001     beq     8059E0Eh
08059E0A 237F     mov     r3,7Fh
08059E0C 400B     and     r3,r1
08059E0E 00D8     lsl     r0,r3,3h
08059E10 19C4     add     r4,r0,r7
08059E12 2000     mov     r0,0h
08059E14 2201     mov     r2,1h
08059E16 7022     strb    r2,[r4]
08059E18 4663     mov     r3,r12
08059E1A 70A3     strb    r3,[r4,2h]
08059E1C 80E0     strh    r0,[r4,6h]
08059E1E 2080     mov     r0,80h
08059E20 4001     and     r1,r0
08059E22 2900     cmp     r1,0h
08059E24 D001     beq     8059E2Ah
08059E26 70E6     strb    r6,[r4,3h]
08059E28 7125     strb    r5,[r4,4h]
08059E2A 4640     mov     r0,r8
08059E2C 2800     cmp     r0,0h
08059E2E D109     bne     8059E44h
08059E30 2002     mov     r0,2h
08059E32 7060     strb    r0,[r4,1h]
08059E34 1C28     mov     r0,r5
08059E36 1C31     mov     r1,r6
08059E38 F000FAD2 bl      805A3E0h
08059E3C 1C20     mov     r0,r4
08059E3E F7FFFF19 bl      8059C74h
08059E42 E000     b       8059E46h
08059E44 7062     strb    r2,[r4,1h]
08059E46 2101     mov     r1,1h
08059E48 1C08     mov     r0,r1
08059E4A BC08     pop     r3
08059E4C 4698     mov     r8,r3
08059E4E BCF0     pop     r4-r7
08059E50 BC02     pop     r1
08059E52 4708     bx      r1




0805A8A8 B5F0     push    r4-r7,lr
0805A8AA 4A0E     ldr     r2,=30013D4h
0805A8AC 8A11     ldrh    r1,[r2,10h]
0805A8AE 2040     mov     r0,40h
0805A8B0 4041     eor     r1,r0
0805A8B2 4248     neg     r0,r1
0805A8B4 4308     orr     r0,r1
0805A8B6 0FC7     lsr     r7,r0,1Fh
0805A8B8 8A53     ldrh    r3,[r2,12h]
0805A8BA 490B     ldr     r1,=300009Ch
0805A8BC 8B88     ldrh    r0,[r1,1Ch]
0805A8BE 0180     lsl     r0,r0,6h
0805A8C0 1C0E     mov     r6,r1
0805A8C2 4283     cmp     r3,r0
0805A8C4 DD00     ble     805A8C8h
0805A8C6 1C03     mov     r3,r0
0805A8C8 0298     lsl     r0,r3,0Ah
0805A8CA 0C05     lsr     r5,r0,10h
0805A8CC 2F00     cmp     r7,0h
0805A8CE D10F     bne     805A8F0h
0805A8D0 4806     ldr     r0,=3001588h
0805A8D2 3074     add     r0,74h
0805A8D4 2100     mov     r1,0h
0805A8D6 5E40     ldsh    r0,[r0,r1]
0805A8D8 8A92     ldrh    r2,[r2,14h]
0805A8DA 1880     add     r0,r0,r2
0805A8DC 1C03     mov     r3,r0
0805A8DE 3380     add     r3,80h
0805A8E0 E00E     b       805A900h
0805A8E2 0000     lsl     r0,r0,0h
0805A8E4 13D4     asr     r4,r2,0Fh
0805A8E6 0300     lsl     r0,r0,0Ch
0805A8E8 009C     lsl     r4,r3,2h
0805A8EA 0300     lsl     r0,r0,0Ch
0805A8EC 1588     asr     r0,r1,16h
0805A8EE 0300     lsl     r0,r0,0Ch
0805A8F0 4806     ldr     r0,=3001588h
0805A8F2 3070     add     r0,70h
0805A8F4 2100     mov     r1,0h
0805A8F6 5E40     ldsh    r0,[r0,r1]
0805A8F8 8A92     ldrh    r2,[r2,14h]
0805A8FA 1880     add     r0,r0,r2
0805A8FC 1C03     mov     r3,r0
0805A8FE 3B80     sub     r3,80h
0805A900 0418     lsl     r0,r3,10h
0805A902 0C01     lsr     r1,r0,10h
0805A904 2B00     cmp     r3,0h
0805A906 DA03     bge     805A910h
0805A908 2100     mov     r1,0h
0805A90A E007     b       805A91Ch
0805A90C 1588     asr     r0,r1,16h
0805A90E 0300     lsl     r0,r0,0Ch
0805A910 8BF2     ldrh    r2,[r6,1Eh]
0805A912 0190     lsl     r0,r2,6h
0805A914 4281     cmp     r1,r0
0805A916 DD01     ble     805A91Ch
0805A918 0590     lsl     r0,r2,16h
0805A91A 0C01     lsr     r1,r0,10h
0805A91C 098C     lsr     r4,r1,6h
0805A91E 8BB0     ldrh    r0,[r6,1Ch]
0805A920 4360     mul     r0,r4
0805A922 1940     add     r0,r0,r5
0805A924 69B1     ldr     r1,[r6,18h]
0805A926 0040     lsl     r0,r0,1h
0805A928 1840     add     r0,r0,r1
0805A92A 8803     ldrh    r3,[r0]
0805A92C 4805     ldr     r0,=3005450h
0805A92E 6881     ldr     r1,[r0,8h]
0805A930 0058     lsl     r0,r3,1h
0805A932 1840     add     r0,r0,r1
0805A934 8801     ldrh    r1,[r0]
0805A936 2300     mov     r3,0h
0805A938 2F00     cmp     r7,0h
0805A93A D105     bne     805A948h
0805A93C 2904     cmp     r1,4h
0805A93E D106     bne     805A94Eh
0805A940 E007     b       805A952h
0805A942 0000     lsl     r0,r0,0h
0805A944 5450     strb    r0,[r2,r1]
0805A946 0300     lsl     r0,r0,0Ch
0805A948 2905     cmp     r1,5h
0805A94A D100     bne     805A94Eh
0805A94C 2301     mov     r3,1h
0805A94E 2B00     cmp     r3,0h
0805A950 D009     beq     805A966h
0805A952 1C20     mov     r0,r4
0805A954 1C29     mov     r1,r5
0805A956 F004FA1D bl      805ED94h
0805A95A 2800     cmp     r0,0h
0805A95C D103     bne     805A966h
0805A95E 1C20     mov     r0,r4
0805A960 1C29     mov     r1,r5
0805A962 F004F945 bl      805EBF0h
0805A966 BCF0     pop     r4-r7
0805A968 BC01     pop     r0
0805A96A 4700     bx      r0
0805A96C B5F0     push    r4-r7,lr
0805A96E 4657     mov     r7,r10
0805A970 464E     mov     r6,r9
0805A972 4645     mov     r5,r8
0805A974 B4E0     push    r5-r7
0805A976 B08C     add     sp,-30h
0805A978 4A07     ldr     r2,=3001588h
0805A97A 1C10     mov     r0,r2
0805A97C 3072     add     r0,72h
0805A97E 8800     ldrh    r0,[r0]
0805A980 0400     lsl     r0,r0,10h
0805A982 4906     ldr     r1,=30013D4h
0805A984 1440     asr     r0,r0,11h
0805A986 8A4B     ldrh    r3,[r1,12h]
0805A988 18C4     add     r4,r0,r3
0805A98A 1C13     mov     r3,r2
0805A98C 1C0D     mov     r5,r1
0805A98E 2C00     cmp     r4,0h
0805A990 DA08     bge     805A9A4h
0805A992 2400     mov     r4,0h
0805A994 4E02     ldr     r6,=300009Ch
0805A996 E00C     b       805A9B2h
0805A998 1588     asr     r0,r1,16h
0805A99A 0300     lsl     r0,r0,0Ch
0805A99C 13D4     asr     r4,r2,0Fh
0805A99E 0300     lsl     r0,r0,0Ch
0805A9A0 009C     lsl     r4,r3,2h
0805A9A2 0300     lsl     r0,r0,0Ch
0805A9A4 4909     ldr     r1,=300009Ch
0805A9A6 8B88     ldrh    r0,[r1,1Ch]
0805A9A8 0180     lsl     r0,r0,6h
0805A9AA 1C0E     mov     r6,r1
0805A9AC 4284     cmp     r4,r0
0805A9AE DD00     ble     805A9B2h
0805A9B0 1C04     mov     r4,r0
0805A9B2 11A0     asr     r0,r4,6h
0805A9B4 9009     str     r0,[sp,24h]
0805A9B6 1C18     mov     r0,r3
0805A9B8 306E     add     r0,6Eh
0805A9BA 8800     ldrh    r0,[r0]
0805A9BC 0400     lsl     r0,r0,10h
0805A9BE 1440     asr     r0,r0,11h
0805A9C0 8A69     ldrh    r1,[r5,12h]
0805A9C2 1844     add     r4,r0,r1
0805A9C4 2C00     cmp     r4,0h
0805A9C6 DA03     bge     805A9D0h
0805A9C8 2400     mov     r4,0h
0805A9CA E006     b       805A9DAh
0805A9CC 009C     lsl     r4,r3,2h
0805A9CE 0300     lsl     r0,r0,0Ch
0805A9D0 8BB0     ldrh    r0,[r6,1Ch]
0805A9D2 0180     lsl     r0,r0,6h
0805A9D4 4284     cmp     r4,r0
0805A9D6 DD00     ble     805A9DAh
0805A9D8 1C04     mov     r4,r0
0805A9DA A909     add     r1,sp,24h
0805A9DC 11A0     asr     r0,r4,6h
0805A9DE 6048     str     r0,[r1,4h]
0805A9E0 8A6C     ldrh    r4,[r5,12h]
0805A9E2 8BB0     ldrh    r0,[r6,1Ch]
0805A9E4 0180     lsl     r0,r0,6h
0805A9E6 4284     cmp     r4,r0
0805A9E8 DD00     ble     805A9ECh
0805A9EA 1C04     mov     r4,r0
0805A9EC 11A0     asr     r0,r4,6h
0805A9EE 900B     str     r0,[sp,2Ch]
0805A9F0 1C18     mov     r0,r3
0805A9F2 3070     add     r0,70h
0805A9F4 8800     ldrh    r0,[r0]
0805A9F6 0400     lsl     r0,r0,10h
0805A9F8 1440     asr     r0,r0,11h
0805A9FA 8AAA     ldrh    r2,[r5,14h]
0805A9FC 1884     add     r4,r0,r2
0805A9FE 2C00     cmp     r4,0h
0805AA00 DA01     bge     805AA06h
0805AA02 2400     mov     r4,0h
0805AA04 E004     b       805AA10h
0805AA06 8BF0     ldrh    r0,[r6,1Eh]
0805AA08 0180     lsl     r0,r0,6h
0805AA0A 4284     cmp     r4,r0
0805AA0C DD00     ble     805AA10h
0805AA0E 1C04     mov     r4,r0
0805AA10 11A0     asr     r0,r4,6h
0805AA12 9006     str     r0,[sp,18h]
0805AA14 1C18     mov     r0,r3
0805AA16 3070     add     r0,70h
0805AA18 8800     ldrh    r0,[r0]
0805AA1A 0400     lsl     r0,r0,10h
0805AA1C 1480     asr     r0,r0,12h
0805AA1E 8AA9     ldrh    r1,[r5,14h]
0805AA20 1844     add     r4,r0,r1
0805AA22 2C00     cmp     r4,0h
0805AA24 DA01     bge     805AA2Ah
0805AA26 2400     mov     r4,0h
0805AA28 E004     b       805AA34h
0805AA2A 8BF0     ldrh    r0,[r6,1Eh]
0805AA2C 0180     lsl     r0,r0,6h
0805AA2E 4284     cmp     r4,r0
0805AA30 DD00     ble     805AA34h
0805AA32 1C04     mov     r4,r0
0805AA34 AA06     add     r2,sp,18h
0805AA36 11A0     asr     r0,r4,6h
0805AA38 6050     str     r0,[r2,4h]
0805AA3A 1C18     mov     r0,r3
0805AA3C 3070     add     r0,70h
0805AA3E 8800     ldrh    r0,[r0]
0805AA40 0400     lsl     r0,r0,10h
0805AA42 1481     asr     r1,r0,12h
0805AA44 1440     asr     r0,r0,11h
0805AA46 1809     add     r1,r1,r0
0805AA48 8AAD     ldrh    r5,[r5,14h]
0805AA4A 194C     add     r4,r1,r5
0805AA4C 2C00     cmp     r4,0h
0805AA4E DA01     bge     805AA54h
0805AA50 2400     mov     r4,0h
0805AA52 E004     b       805AA5Eh
0805AA54 8BF0     ldrh    r0,[r6,1Eh]
0805AA56 0180     lsl     r0,r0,6h
0805AA58 4284     cmp     r4,r0
0805AA5A DD00     ble     805AA5Eh
0805AA5C 1C04     mov     r4,r0
0805AA5E 11A0     asr     r0,r4,6h
0805AA60 9008     str     r0,[sp,20h]
0805AA62 4822     ldr     r0,=300009Ch
0805AA64 8B82     ldrh    r2,[r0,1Ch]
0805AA66 4690     mov     r8,r2
0805AA68 6987     ldr     r7,[r0,18h]
0805AA6A 4821     ldr     r0,=3005450h
0805AA6C 6883     ldr     r3,[r0,8h]
0805AA6E AE02     add     r6,sp,8h
0805AA70 AA09     add     r2,sp,24h
0805AA72 2501     mov     r5,1h
0805AA74 9806     ldr     r0,[sp,18h]
0805AA76 4641     mov     r1,r8
0805AA78 4341     mul     r1,r0
0805AA7A 1C08     mov     r0,r1
0805AA7C CA02     ldmia   [r2]!,r1
0805AA7E 1840     add     r0,r0,r1
0805AA80 0040     lsl     r0,r0,1h
0805AA82 19C0     add     r0,r0,r7
0805AA84 8804     ldrh    r4,[r0]
0805AA86 0060     lsl     r0,r4,1h
0805AA88 18C0     add     r0,r0,r3
0805AA8A 8800     ldrh    r0,[r0]
0805AA8C C601     stmia   [r6]!,r0
0805AA8E 3D01     sub     r5,1h
0805AA90 2D00     cmp     r5,0h
0805AA92 DAEF     bge     805AA74h
0805AA94 2500     mov     r5,0h
0805AA96 4815     ldr     r0,=300009Ch
0805AA98 8B82     ldrh    r2,[r0,1Ch]
0805AA9A 4694     mov     r12,r2
0805AA9C 6980     ldr     r0,[r0,18h]
0805AA9E 4680     mov     r8,r0
