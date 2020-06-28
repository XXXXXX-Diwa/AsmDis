;量子球AI主程序
080448E0 B5F0     push    r4-r7,lr
080448E2 4657     mov     r7,r10
080448E4 464E     mov     r6,r9
080448E6 4645     mov     r5,r8
080448E8 B4E0     push    r5-r7
080448EA B081     add     sp,-4h
080448EC 4D0B     ldr     r5,=3000738h
080448EE 1C28     mov     r0,r5
080448F0 3026     add     r0,26h
080448F2 2600     mov     r6,0h
080448F4 2101     mov     r1,1h
080448F6 4688     mov     r8,r1
080448F8 4642     mov     r2,r8
080448FA 7002     strb    r2,[r0]      ;偏移26待机时间写入1
080448FC 1C2C     mov     r4,r5
080448FE 3424     add     r4,24h
08044900 7820     ldrb    r0,[r4]      ;读取pose
08044902 46A9     mov     r9,r5
08044904 2823     cmp     r0,23h
08044906 D100     bne     @@PoseNo23
08044908 E126     b       @@Pose23
.pool

@@PoseNo23:
0804490A 2823     cmp     r0,23h
0804490C DC08     bgt     @@PoseMore23
0804490E 2800     cmp     r0,0h
08044910 D00A     beq     @@PoseZero
08044912 2809     cmp     r0,9h
08044914 D100     bne     @@PoseNo9
08044916 E08D     b       @@Pose9

@@PoseNo9:
08044918 E179     b       @@end


@@PoseMore23:
08044920 2825     cmp     r0,25h
08044922 D100     bne     @@PoseNo25
08044924 E168     b       @@Pose25

@@PoseNo25:
08044926 E172     b       @@end

@@PoseZero:
08044928 2700     mov     r7,0h
0804492A 7F68     ldrb    r0,[r5,1Dh]     ;读取精灵的ID
0804492C 288C     cmp     r0,8Ch
0804492E D107     bne     @@ContinueCheck
08044930 2003     mov     r0,3h
08044932 212F     mov     r1,2Fh
08044934 F01BFFC2 bl      80608BCh        ;检查2F事件 8C球消失事件
08044938 4241     neg     r1,r0           ;1取反为FF  或者0 取反为0
0804493A 4301     orr     r1,r0           ;1 orr ff
0804493C 0FCF     lsr     r7,r1,1Fh       ;0
0804493E E01F     b       @@Goto

@@ContinueCheck:
08044940 288D     cmp     r0,8Dh
08044942 D108     bne     @@ContinueCheck1
08044944 2003     mov     r0,3h
08044946 2112     mov     r1,12h          
08044948 F01BFFB8 bl      80608BCh        ;检查12 高跳指引事件
0804494C 2800     cmp     r0,0h           ;高跳指引事件如果没有激活
0804494E D00E     beq     @@RemoveSprite  ;清除精灵
08044950 2003     mov     r0,3h
08044952 2130     mov     r1,30h          ;检查事件30 8d球的消失事件
08044954 E00F     b       @@Peer

@@ContinueCheck1:
08044956 288E     cmp     r0,8Eh
08044958 D102     bne     @@ContinueCheck2        
0804495A 2003     mov     r0,3h
0804495C 2131     mov     r1,31h          ;检查事件31 8E球的消失事件
0804495E E00A     b       @@Peer

@@ContinueCheck2:
08044960 288F     cmp     r0,8Fh
08044962 D102     bne     @@ContinueCheck3
08044964 2003     mov     r0,3h
08044966 2132     mov     r1,32h          ;检查事件32 8F球的消失事件
08044968 E005     b       @@Peer

@@ContinueCheck3:
0804496A 2890     cmp     r0,90h
0804496C D001     beq     @@SpriteID90

@@RemoveSprite:
0804496E 802E     strh    r6,[r5]
08044970 E14D     b       @@end

@@SpriteID90:
08044972 2003     mov     r0,3h
08044974 2133     mov     r1,33h          ;检查事件33 90球的消失事件

@@Peer:
08044976 F01BFFA1 bl      80608BCh
0804497A 2800     cmp     r0,0h
0804497C D000     beq     @@Goto
0804497E 2701     mov     r7,1h           ;激活则r7 = 1

@@Goto:
08044980 4B16     ldr     r3,=3000738h
08044982 1C18     mov     r0,r3
08044984 3027     add     r0,27h
08044986 2100     mov     r1,0h
08044988 2230     mov     r2,30h
0804498A 7002     strb    r2,[r0]         ;上视界写入30h
0804498C 3001     add     r0,1h
0804498E 7001     strb    r1,[r0]         ;左右视界写入0
08044990 1C1C     mov     r4,r3
08044992 3429     add     r4,29h
08044994 2014     mov     r0,14h
08044996 7020     strb    r0,[r4]         ;下视界写入14h
08044998 2400     mov     r4,0h
0804499A 4811     ldr     r0,=0FF40h
0804499C 8158     strh    r0,[r3,0Ah]     ;上分界写入0FF40h
0804499E 8199     strh    r1,[r3,0Ch]     ;下分界写入0
080449A0 3090     add     r0,90h
080449A2 81D8     strh    r0,[r3,0Eh]     ;左分界写入0FFD0h
080449A4 821A     strh    r2,[r3,10h]     ;右分界写入30h
080449A6 1C1A     mov     r2,r3
080449A8 3222     add     r2,22h
080449AA 2005     mov     r0,5h           ;图像相关写入5
080449AC 7010     strb    r0,[r2]
080449AE 82D9     strh    r1,[r3,16h]     
080449B0 771C     strb    r4,[r3,1Ch]     ;动画和动画帧写入0
080449B2 1C18     mov     r0,r3
080449B4 3025     add     r0,25h
080449B6 7004     strb    r4,[r0]         ;属性写入0
080449B8 300A     add     r0,0Ah
080449BA 7004     strb    r4,[r0]         ;偏移2F写入0
080449BC 2F00     cmp     r7,0h
080449BE D013     beq     @@EventNoActivation
080449C0 1C19     mov     r1,r3
080449C2 3124     add     r1,24h
080449C4 2061     mov     r0,61h
080449C6 7008     strb    r0,[r1]         ;pose写入61h
080449C8 8818     ldrh    r0,[r3]
080449CA 2680     mov     r6,80h
080449CC 0236     lsl     r6,r6,8h        
080449CE 1C31     mov     r1,r6
080449D0 4308     orr     r0,r1           ;取向orr8000h
080449D2 8018     strh    r0,[r3]         ;再写入
080449D4 4803     ldr     r0,=8309238h
080449D6 6198     str     r0,[r3,18h]     ;已经消失只留疤痕的OAM
080449D8 E119     b       @@end
.pool

@@EventNoActivation:
080449E8 1C19     mov     r1,r3
080449EA 3124     add     r1,24h
080449EC 2009     mov     r0,9h
080449EE 7008     strb    r0,[r1]         ;pose写入9h
080449F0 2001     mov     r0,1h
080449F2 8298     strh    r0,[r3,14h]     ;血量写入1h
080449F4 480D     ldr     r0,=83091E0h
080449F6 6198     str     r0,[r3,18h]     ;写入常态的OAM
080449F8 8858     ldrh    r0,[r3,2h]      ;Y坐标
080449FA 3820     sub     r0,20h          ;向上半格
080449FC 0400     lsl     r0,r0,10h
080449FE 0C06     lsr     r6,r0,10h       ;给r6
08044A00 889F     ldrh    r7,[r3,4h]      ;X坐标给r7
08044A02 2504     mov     r5,4h
08044A04 4C0A     ldr     r4,=3000079h
08044A06 7025     strb    r5,[r4]         ;制造砖块的标记
08044A08 1C30     mov     r0,r6
08044A0A 1C39     mov     r1,r7
08044A0C F013FA36 bl      8057E7Ch        ;造砖
08044A10 7025     strb    r5,[r4]
08044A12 1C30     mov     r0,r6
08044A14 3840     sub     r0,40h          ;再向上一格
08044A16 1C39     mov     r1,r7
08044A18 F013FA30 bl      8057E7Ch        ;造砖
08044A1C 7025     strb    r5,[r4]
08044A1E 1C30     mov     r0,r6
08044A20 3880     sub     r0,80h          ;向上两格
08044A22 1C39     mov     r1,r7   
08044A24 F013FA2A bl      8057E7Ch        ;造砖
08044A28 E0F1     b       @@end

@@Pose9:
08044A34 8869     ldrh    r1,[r5,2h]      ;Y坐标
08044A36 8968     ldrh    r0,[r5,0Ah]     ;读取上部分界
08044A38 1808     add     r0,r1,r0
08044A3A 0400     lsl     r0,r0,10h
08044A3C 0C00     lsr     r0,r0,10h
08044A3E 9000     str     r0,[sp]         ;精极上给[Sp]
08044A40 3108     add     r1,8h
08044A42 0409     lsl     r1,r1,10h
08044A44 0C09     lsr     r1,r1,10h
08044A46 468A     mov     r10,r1          ;精极下给r10 虽然向上提升8h
08044A48 88A9     ldrh    r1,[r5,4h]
08044A4A 89E8     ldrh    r0,[r5,0Eh]
08044A4C 1808     add     r0,r1,r0
08044A4E 0400     lsl     r0,r0,10h
08044A50 0C00     lsr     r0,r0,10h
08044A52 4684     mov     r12,r0          ;精极左给r12
08044A54 8A28     ldrh    r0,[r5,10h]
08044A56 1809     add     r1,r1,r0
08044A58 0409     lsl     r1,r1,10h
08044A5A 0C09     lsr     r1,r1,10h
08044A5C 4688     mov     r8,r1           ;精极右给r8
08044A5E 4A25     ldr     r2,=30001ACh
08044A60 21A8     mov     r1,0A8h
08044A62 00C9     lsl     r1,r1,3h
08044A64 1850     add     r0,r2,r1        ;精灵数据最大界限
08044A66 4282     cmp     r2,r0
08044A68 D22C     bcs     @@DataOver
08044A6A 1C2C     mov     r4,r5
08044A6C 352F     add     r5,2Fh         
08044A6E 1C13     mov     r3,r2
08044A70 3324     add     r3,24h

@@Loop:
08044A72 8811     ldrh    r1,[r2]        ;读取其它精灵的pose
08044A74 2001     mov     r0,1h
08044A76 4008     and     r0,r1          ;检查是否是奇数
08044A78 2800     cmp     r0,0h
08044A7A D01E     beq     @@NextCheck    ;不是奇数则结束
08044A7C 7858     ldrb    r0,[r3,1h]
08044A7E 2817     cmp     r0,17h         ;检查敌人的属性是否是17h
08044A80 D11B     bne     @@NextCheck    ;不是则结束
08044A82 8856     ldrh    r6,[r2,2h]
08044A84 8897     ldrh    r7,[r2,4h]     ;读取其它精灵的坐标
08044A86 45B2     cmp     r10,r6
08044A88 D917     bls     @@NextCheck
08044A8A 9800     ldr     r0,[sp]
08044A8C 42B0     cmp     r0,r6
08044A8E D214     bcs     @@NextCheck
08044A90 45B8     cmp     r8,r7
08044A92 D912     bls     @@NextCheck
08044A94 45BC     cmp     r12,r7
08044A96 D210     bcs     @@NextCheck
08044A98 1C20     mov     r0,r4
08044A9A 3023     add     r0,23h         ;当前主精灵序号
08044A9C 7800     ldrb    r0,[r0]        
08044A9E 7258     strb    r0,[r3,9h]     ;写入其它粘附精灵的偏移2Dh
08044AA0 204C     mov     r0,4Ch
08044AA2 7018     strb    r0,[r3]        ;其它粘附精灵的pose写入4Ch
08044AA4 8810     ldrh    r0,[r2]
08044AA6 2680     mov     r6,80h
08044AA8 0236     lsl     r6,r6,8h       
08044AAA 1C31     mov     r1,r6
08044AAC 4308     orr     r0,r1
08044AAE 8010     strh    r0,[r2]        ;其它粘附精灵的取向orr 8000h 无敌
08044AB0 2000     mov     r0,0h
08044AB2 7058     strb    r0,[r3,1h]     ;其它粘附精灵的属性写入0
08044AB4 7828     ldrb    r0,[r5]
08044AB6 3001     add     r0,1h
08044AB8 7028     strb    r0,[r5]        ;偏移2F加1

@@NextCheck:
08044ABA 3338     add     r3,38h
08044ABC 3238     add     r2,38h
08044ABE 490E     ldr     r1,=30006ECh
08044AC0 428A     cmp     r2,r1
08044AC2 D3D6     bcc     @@Loop

@@DataOver:
08044AC4 464B     mov     r3,r9
08044AC6 1C18     mov     r0,r3
08044AC8 302F     add     r0,2Fh
08044ACA 7800     ldrb    r0,[r0]        ;读取偏移2Fh
08044ACC 2803     cmp     r0,3h          ;虫数
08044ACE D917     bls     @@LessFourBug  ;检查是否小于等于3
08044AD0 1C19     mov     r1,r3
08044AD2 3124     add     r1,24h
08044AD4 2200     mov     r2,0h
08044AD6 2023     mov     r0,23h
08044AD8 7008     strb    r0,[r1]        ;pose写入23 要被吸干
08044ADA 4808     ldr     r0,=8309248h
08044ADC 6198     str     r0,[r3,18h]
08044ADE 2000     mov     r0,0h
08044AE0 82DA     strh    r2,[r3,16h]
08044AE2 7718     strb    r0,[r3,1Ch]    ;新oam
08044AE4 3108     add     r1,8h
08044AE6 20C8     mov     r0,0C8h
08044AE8 7008     strb    r0,[r1]        ;偏移2C写入C8h
08044AEA 209B     mov     r0,09Bh
08044AEC 0080     lsl     r0,r0,2h
08044AEE F7BEF817 bl      8002B20h       ;球被腐蚀以及坏掉的声音
08044AF2 E08C     b       @@end
.pool

@@LessFourBug:
08044B00 1C18     mov     r0,r3
08044B02 302B     add     r0,2Bh
08044B04 7800     ldrb    r0,[r0]        ;读取击晕时间
08044B06 247F     mov     r4,7Fh
08044B08 4004     and     r4,r0
08044B0A 2C00     cmp     r4,0h          ;检查是否被攻击
08044B0C D010     beq     @@NoHit
08044B0E 2C02     cmp     r4,2h
08044B10 D000     beq     @@PassEnd
08044B12 E07C     b       @@end

@@PassEnd:
08044B14 4804     ldr     r0,=8309348h
08044B16 6198     str     r0,[r3,18h]    ;写入被击打的晃动OAM
08044B18 2100     mov     r1,0h
08044B1A 2000     mov     r0,0h
08044B1C 82D8     strh    r0,[r3,16h]
08044B1E 7719     strb    r1,[r3,1Ch]
08044B20 4802     ldr     r0,=26Bh
08044B22 F7BDFFFD bl      8002B20h       ;晃动声
08044B26 E072     b       @@end
.pool

@@NoHit:
08044B30 464A     mov     r2,r9
08044B32 6991     ldr     r1,[r2,18h]
08044B34 4806     ldr     r0,=8309348h
08044B36 4281     cmp     r1,r0         ;检查OAM是否是晃动的
08044B38 D169     bne     @@end
08044B3A F7CBF845 bl      800FBC8h      ;检查动画循环
08044B3E 2800     cmp     r0,0h
08044B40 D065     beq     @@end         ;晃动的动画完成循环
08044B42 4804     ldr     r0,=83091E0h
08044B44 464E     mov     r6,r9
08044B46 61B0     str     r0,[r6,18h]   ;再次写入普通的OAM
08044B48 2000     mov     r0,0h
08044B4A 82F4     strh    r4,[r6,16h]
08044B4C 7730     strb    r0,[r6,1Ch]
08044B4E E05E     b       @@end
.pool

@@Pose23:
08044B58 1C29     mov     r1,r5
08044B5A 312C     add     r1,2Ch
08044B5C 7808     ldrb    r0,[r1]
08044B5E 3801     sub     r0,1h
08044B60 7008     strb    r0,[r1]       ;偏移2C写入的C8减1再写入
08044B62 0600     lsl     r0,r0,18h
08044B64 2800     cmp     r0,0h
08044B66 D152     bne     @@end         ;没有达到零就结束
08044B68 8829     ldrh    r1,[r5]
08044B6A 2280     mov     r2,80h
08044B6C 0212     lsl     r2,r2,8h        
08044B6E 1C10     mov     r0,r2
08044B70 4308     orr     r0,r1         ;取向orr 8000h再写入
08044B72 8028     strh    r0,[r5]
08044B74 2025     mov     r0,25h
08044B76 7020     strb    r0,[r4]       ;pose写入25h
08044B78 8868     ldrh    r0,[r5,2h]
08044B7A 3820     sub     r0,20h        ;Y坐标
08044B7C 0400     lsl     r0,r0,10h
08044B7E 0C06     lsr     r6,r0,10h     ;向上半格给r6
08044B80 88AF     ldrh    r7,[r5,4h]    ;X坐标给r7
08044B82 4C0E     ldr     r4,=3000079h
08044B84 4640     mov     r0,r8
08044B86 7020     strb    r0,[r4]       ;1
08044B88 1C30     mov     r0,r6
08044B8A 1C39     mov     r1,r7
08044B8C F013F976 bl      8057E7Ch      ;砖消失
08044B90 4641     mov     r1,r8
08044B92 7021     strb    r1,[r4]
08044B94 1C30     mov     r0,r6
08044B96 3840     sub     r0,40h
08044B98 1C39     mov     r1,r7
08044B9A F013F96F bl      8057E7Ch
08044B9E 4642     mov     r2,r8
08044BA0 7022     strb    r2,[r4]
08044BA2 1C30     mov     r0,r6
08044BA4 3880     sub     r0,80h
08044BA6 1C39     mov     r1,r7
08044BA8 F013F968 bl      8057E7Ch      ;三块砖消失
08044BAC 7F69     ldrb    r1,[r5,1Dh]   ;检查ID给予消失的事件激活
08044BAE 298C     cmp     r1,8Ch
08044BB0 D106     bne     8044BC0h
08044BB2 2001     mov     r0,1h
08044BB4 212F     mov     r1,2Fh
08044BB6 F01BFE81 bl      80608BCh
08044BBA E028     b       @@end
08044BBC 0079     lsl     r1,r7,1h
08044BBE 0300     lsl     r0,r0,0Ch
08044BC0 298D     cmp     r1,8Dh
08044BC2 D104     bne     8044BCEh
08044BC4 2001     mov     r0,1h
08044BC6 2130     mov     r1,30h
08044BC8 F01BFE78 bl      80608BCh
08044BCC E01F     b       @@end
08044BCE 298E     cmp     r1,8Eh
08044BD0 D104     bne     8044BDCh
08044BD2 2001     mov     r0,1h
08044BD4 2131     mov     r1,31h
08044BD6 F01BFE71 bl      80608BCh
08044BDA E018     b       @@end
08044BDC 298F     cmp     r1,8Fh
08044BDE D104     bne     8044BEAh
08044BE0 2001     mov     r0,1h
08044BE2 2132     mov     r1,32h
08044BE4 F01BFE6A bl      80608BCh
08044BE8 E011     b       @@end
08044BEA 2990     cmp     r1,90h
08044BEC D10F     bne     @@end
08044BEE 2001     mov     r0,1h
08044BF0 2133     mov     r1,33h
08044BF2 F01BFE63 bl      80608BCh
08044BF6 E00A     b       @@end

@@Pose25:
08044BF8 F7CAFFE6 bl      800FBC8h
08044BFC 2800     cmp     r0,0h
08044BFE D006     beq     @@end          ;完全毁灭动画结束循环
08044C00 2061     mov     r0,61h
08044C02 7020     strb    r0,[r4]        ;pose写入61h
08044C04 4806     ldr     r0,=8309238h
08044C06 61A8     str     r0,[r5,18h]    ;新Oam
08044C08 2000     mov     r0,0h
08044C0A 82EE     strh    r6,[r5,16h]
08044C0C 7728     strb    r0,[r5,1Ch]

@@end:
08044C0E B001     add     sp,4h
08044C10 BC38     pop     r3-r5
08044C12 4698     mov     r8,r3
08044C14 46A1     mov     r9,r4
08044C16 46AA     mov     r10,r5
08044C18 BCF0     pop     r4-r7
08044C1A BC01     pop     r0
08044C1C 4700     bx      r0
.pool
