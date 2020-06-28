;pose1a(落地)调用--检查方位和砖块
08031CB0 B530     push    r4,r5,lr
08031CB2 2500     mov     r5,0h
08031CB4 4C04     ldr     r4,=30006BCh
08031CB6 8821     ldrh    r1,[r4]
08031CB8 2080     mov     r0,80h
08031CBA 0180     lsl     r0,r0,6h
08031CBC 4008     and     r0,r1			;检查是否半透明?或仅2000
08031CBE 2800     cmp     r0,0h
08031CC0 D004     beq     @@No2000
08031CC2 2000     mov     r0,0h
08031CC4 E01B     b       @@end
.pool

@@No2000:
08031CCC 2002     mov     r0,2h
08031CCE 4008     and     r0,r1			;检查是否在屏幕内
08031CD0 2800     cmp     r0,0h			;不再屏幕内
08031CD2 D013     beq     @@returnzero
08031CD4 8AA0     ldrh    r0,[r4,14h]
08031CD6 2800     cmp     r0,0h			;检查血量是否为0
08031CD8 D010     beq     @@returnzero
08031CDA 21B4     mov     r1,0B4h
08031CDC 0049     lsl     r1,r1,1h
08031CDE 2078     mov     r0,78h
08031CE0 F7DFFF20 bl      8011B24h		;检查敌人和samus的位置
08031CE4 1C02     mov     r2,r0
08031CE6 8821     ldrh    r1,[r4]
08031CE8 2040     mov     r0,40h		;检查面向
08031CEA 4008     and     r0,r1
08031CEC 2800     cmp     r0,0h
08031CEE D002     beq     @@faceLeft
08031CF0 2A08     cmp     r2,8h			;人在敌右范围内且敌面右返回1
08031CF2 D103     bne     @@returnzero
08031CF4 E001     b       @@returnone

@@faceLeft:
08031CF6 2A04     cmp     r2,4h			;人在敌左且敌面左返回1
08031CF8 D100     bne     @@returnzero

@@returnone:
08031CFA 2501     mov     r5,1h

@@returnzero:
08031CFC 1C28     mov     r0,r5

@@end:
08031CFE BC30     pop     r4,r5
08031D00 BC02     pop     r1
08031D02 4708     bx      r1

;不在敌前或屏幕内或范围内 --pose1A调用
08031D04 B530     push    r4,r5,lr
08031D06 2500     mov     r5,0h
08031D08 4C04     ldr     r4,=30006BCh
08031D0A 8822     ldrh    r2,[r4]
08031D0C 2080     mov     r0,80h
08031D0E 0180     lsl     r0,r0,6h
08031D10 4010     and     r0,r2
08031D12 2800     cmp     r0,0h				;检查是否有2000
08031D14 D004     beq     @@No2000
08031D16 2000     mov     r0,0h				;有则直接结束
08031D18 E04A     b       @@end
.pool

@@No2000:
08031D20 23F0     mov     r3,0F0h
08031D22 21FA     mov     r1,0FAh
08031D24 0049     lsl     r1,r1,1h			;1f4h
08031D26 2080     mov     r0,80h
08031D28 00C0     lsl     r0,r0,3h			;400h  超探索flag???
08031D2A 4010     and     r0,r2				;和取向and
08031D2C 2800     cmp     r0,0h				
08031D2E D004     beq     @@No400
08031D30 31C8     add     r1,0C8h			;2bc
08031D32 33C8     add     r3,0C8h			;1b8
08031D34 480A     ldr     r0,=0FBFFh
08031D36 4010     and     r0,r2				;取向去掉400再写入 去掉超探索
08031D38 8020     strh    r0,[r4]

@@No400;
08031D3A 8AA0     ldrh    r0,[r4,14h]		;读取血量
08031D3C 2800     cmp     r0,0h
08031D3E D036     beq     @@return
08031D40 1C18     mov     r0,r3
08031D42 F7DFFEEF bl      8011B24h			;检查精灵和samus的位置
08031D46 1C02     mov     r2,r0
08031D48 8821     ldrh    r1,[r4]			
08031D4A 2040     mov     r0,40h
08031D4C 4008     and     r0,r1
08031D4E 2800     cmp     r0,0h				;检查面向
08031D50 D00F     beq     @@faceLeft
08031D52 2A08     cmp     r2,8h				;在右且敌面右
08031D54 D106     bne     @@continue
08031D56 8860     ldrh    r0,[r4,2h]
08031D58 3880     sub     r0,80h			;Y向上两格
08031D5A 88A1     ldrh    r1,[r4,4h]
08031D5C 3148     add     r1,48h			;X向右48h
08031D5E E00E     b       @@checkBlock
.pool

@@continue:
08031D64 2A04     cmp     r2,4h				;在左敌面右...
08031D66 D122     bne     @@return
08031D68 8860     ldrh    r0,[r4,2h]
08031D6A 3880     sub     r0,80h			;Y向上两格
08031D6C 88A1     ldrh    r1,[r4,4h]
08031D6E 3948     sub     r1,48h			;X向左48h
08031D70 E016     b       @@peer

@@faceLeft:
08031D72 2A04     cmp     r2,4h				;在左且敌面左
08031D74 D10E     bne     @@continue2
08031D76 8860     ldrh    r0,[r4,2h]
08031D78 3880     sub     r0,80h			;Y向上两格
08031D7A 88A1     ldrh    r1,[r4,4h]
08031D7C 3948     sub     r1,48h			;X向左48h

@@checkBlock:
08031D7E F7DFFB07 bl      8011390h			;检查砖块
08031D82 4803     ldr     r0,=30007A5h
08031D84 7800     ldrb    r0,[r0]
08031D86 2811     cmp     r0,11h
08031D88 D011     beq     @@return
08031D8A 2501     mov     r5,1h				;无砖敌正向返回1
08031D8C E00F     b       @@return
.pool

@@continue2:
08031D94 2A08     cmp     r2,8h				;在右且敌面左
08031D96 D10A     bne     @@return
08031D98 8860     ldrh    r0,[r4,2h]
08031D9A 3880     sub     r0,80h			;Y向上两格
08031D9C 88A1     ldrh    r1,[r4,4h]
08031D9E 3148     add     r1,48h			;X向有48h

@@peer:
08031DA0 F7DFFAF6 bl      8011390h			;检查砖块
08031DA4 4804     ldr     r0,=30007A5h
08031DA6 7800     ldrb    r0,[r0]
08031DA8 2811     cmp     r0,11h
08031DAA D000     beq     @@return
08031DAC 2502     mov     r5,2h				;无砖敌背向返回2

@@return:
08031DAE 1C28     mov     r0,r5

@@end:
08031DB0 BC30     pop     r4,r5
08031DB2 BC02     pop     r1
08031DB4 4708     bx      r1
.pool

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Pose5B:				;产生新x
08031DBC B510     push    r4,lr
08031DBE B084     add     sp,-10h
08031DC0 4C0F     ldr     r4,=30006BCh
08031DC2 8821     ldrh    r1,[r4]
08031DC4 2240     mov     r2,40h
08031DC6 1C10     mov     r0,r2
08031DC8 4008     and     r0,r1
08031DCA 2800     cmp     r0,0h				;检查面向
08031DCC D01A     beq     @@faceLeft
08031DCE 7F61     ldrb    r1,[r4,1Dh]		;读取精灵id
08031DD0 1C20     mov     r0,r4
08031DD2 3023     add     r0,23h
08031DD4 7803     ldrb    r3,[r0]			;读取主灵序号
08031DD6 3007     add     r0,7h
08031DD8 7800     ldrb    r0,[r0]			;读取偏移7
08031DDA 9000     str     r0,[sp]
08031DDC 8860     ldrh    r0,[r4,2h]
08031DDE 381C     sub     r0,1Ch
08031DE0 9001     str     r0,[sp,4h]
08031DE2 88A0     ldrh    r0,[r4,4h]
08031DE4 3818     sub     r0,18h			;坐标调整后写入
08031DE6 9002     str     r0,[sp,8h]
08031DE8 9203     str     r2,[sp,0Ch]		;面向
08031DEA 2038     mov     r0,38h			;id  38
08031DEC 2200     mov     r2,0h				;gfxrow
08031DEE F7DDFF59 bl      800FCA4h			;产生一个新的x?
08031DF2 8860     ldrh    r0,[r4,2h]
08031DF4 3840     sub     r0,40h
08031DF6 8060     strh    r0,[r4,2h]
08031DF8 88A0     ldrh    r0,[r4,4h]
08031DFA 3018     add     r0,18h			;调整xy
08031DFC E019     b       @@writex
.pool

@@faceLeft:
08031E04 7F61     ldrb    r1,[r4,1Dh]
08031E06 1C20     mov     r0,r4
08031E08 3023     add     r0,23h
08031E0A 7803     ldrb    r3,[r0]
08031E0C 3007     add     r0,7h
08031E0E 7800     ldrb    r0,[r0]
08031E10 9000     str     r0,[sp]
08031E12 8860     ldrh    r0,[r4,2h]
08031E14 381C     sub     r0,1Ch
08031E16 9001     str     r0,[sp,4h]
08031E18 88A0     ldrh    r0,[r4,4h]
08031E1A 3018     add     r0,18h
08031E1C 9002     str     r0,[sp,8h]
08031E1E 9203     str     r2,[sp,0Ch]
08031E20 2038     mov     r0,38h
08031E22 2200     mov     r2,0h
08031E24 F7DDFF3E bl      800FCA4h
08031E28 8860     ldrh    r0,[r4,2h]
08031E2A 3840     sub     r0,40h
08031E2C 8060     strh    r0,[r4,2h]
08031E2E 88A0     ldrh    r0,[r4,4h]
08031E30 3818     sub     r0,18h

@@writex:
08031E32 80A0     strh    r0,[r4,4h]
08031E34 B004     add     sp,10h
08031E36 BC10     pop     r4
08031E38 BC01     pop     r0
08031E3A 4700     bx      r0

////////////////////////////////////////////////////////////////////////////////////

Pose_0:
08031E3C B510     push    r4,lr
08031E3E F7E0FCEB bl      8012818h		;预处理???
08031E42 4C07     ldr     r4,=30006BCh
08031E44 1C20     mov     r0,r4
08031E46 3034     add     r0,34h
08031E48 7801     ldrb    r1,[r0]
08031E4A 2302     mov     r3,2h
08031E4C 1C18     mov     r0,r3
08031E4E 4008     and     r0,r1
08031E50 0600     lsl     r0,r0,18h
08031E52 0E02     lsr     r2,r0,18h
08031E54 2A00     cmp     r2,0h			;检查碰撞属性;
08031E56 D005     beq     @@NoDeath
08031E58 2000     mov     r0,0h
08031E5A 8020     strh    r0,[r4]		;死亡
08031E5C E03E     b       @@end
.pool

@@NoDeath:
08031E64 1C20     mov     r0,r4
08031E66 302F     add     r0,2Fh
08031E68 7002     strb    r2,[r0]		;2F清零
08031E6A 1C21     mov     r1,r4
08031E6C 3127     add     r1,27h
08031E6E 2020     mov     r0,20h
08031E70 7008     strb    r0,[r1]		;视野判定上写20h
08031E72 3101     add     r1,1h
08031E74 2008     mov     r0,8h			;视野判定下写8h
08031E76 7008     strb    r0,[r1]
08031E78 3101     add     r1,1h			;视野判定左右写18h
08031E7A 2018     mov     r0,18h
08031E7C 7008     strb    r0,[r1]
08031E7E 2100     mov     r1,0h
08031E80 4812     ldr     r0,=0FFA0h
08031E82 8160     strh    r0,[r4,0Ah]	;上部判定写入FFA0h
08031E84 81A2     strh    r2,[r4,0Ch]	;下部判定写入0h
08031E86 3038     add     r0,38h
08031E88 81E0     strh    r0,[r4,0Eh]	;左部判定写入FFD8h
08031E8A 2028     mov     r0,28h
08031E8C 8220     strh    r0,[r4,10h]	;右部判定写入28h
08031E8E 4810     ldr     r0,=833E5B4h	;彷徨常态
08031E90 61A0     str     r0,[r4,18h]	;初始化OAM
08031E92 7721     strb    r1,[r4,1Ch]	;初始化动画帧
08031E94 82E2     strh    r2,[r4,16h]	;初始化动画
08031E96 8AA0     ldrh    r0,[r4,14h]
08031E98 2800     cmp     r0,0h			;血量检查是否为0
08031E9A D107     bne     @@PassHealth
08031E9C 4A0D     ldr     r2,=82E4D4Ch	;精灵数据偏移起始
08031E9E 7F61     ldrb    r1,[r4,1Dh]	;读取精灵id
08031EA0 00C8     lsl     r0,r1,3h
08031EA2 1A40     sub     r0,r0,r1
08031EA4 0040     lsl     r0,r0,1h		;乘以14加上偏移
08031EA6 1880     add     r0,r0,r2
08031EA8 8800     ldrh    r0,[r0]
08031EAA 82A0     strh    r0,[r4,14h]	;写入新血量

@@PassHealth:
08031EAC 1C20     mov     r0,r4
08031EAE 3025     add     r0,25h
08031EB0 7003     strb    r3,[r0]		;精灵属性写入2
08031EB2 F7DFFB43 bl      801153Ch		;??
08031EB6 1C21     mov     r1,r4
08031EB8 3124     add     r1,24h
08031EBA 7808     ldrb    r0,[r1]		;读取pose
08031EBC 2859     cmp     r0,59h
08031EBE D10B     bne     @@PoseNo59
08031EC0 205A     mov     r0,5Ah
08031EC2 7008     strb    r0,[r1]		;pose写入5Ah
08031EC4 202C     mov     r0,2Ch
08031EC6 80E0     strh    r0,[r4,6h]	;偏移6写入2Ch
08031EC8 E008     b       @@end
.pool

@@PoseNo59:
08031ED8 2001     mov     r0,1h
08031EDA 7008     strb    r0,[r1]		;pose写入1

@@end:
08031EDC BC10     pop     r4
08031EDE BC01     pop     r0
08031EE0 4700     bx      r0
.align
///////////////////////////////////////////////////////////////////////////////////////
Pose1:
08031EE4 B500     push    lr
08031EE6 4B0D     ldr     r3,=30006BCh
08031EE8 1C1A     mov     r2,r3
08031EEA 3224     add     r2,24h
08031EEC 2100     mov     r1,0h
08031EEE 2002     mov     r0,2h
08031EF0 7010     strb    r0,[r2]		;pose写入2
08031EF2 7719     strb    r1,[r3,1Ch]	;动画帧写入0
08031EF4 82D9     strh    r1,[r3,16h]	;动画写入0
08031EF6 1C19     mov     r1,r3
08031EF8 312F     add     r1,2Fh
08031EFA 7808     ldrb    r0,[r1]		;读取偏移2F
08031EFC 3001     add     r0,1h
08031EFE 7008     strb    r0,[r1]		;加1再写入
08031F00 4807     ldr     r0,=30007F0h	;随机值
08031F02 7801     ldrb    r1,[r0]		;读取随机值
08031F04 2201     mov     r2,1h
08031F06 1C10     mov     r0,r2
08031F08 4008     and     r0,r1			;检查是否是偶数
08031F0A 2800     cmp     r0,0h
08031F0C D00C     beq     8031F28h
08031F0E 1C18     mov     r0,r3
08031F10 3030     add     r0,30h
08031F12 2100     mov     r1,0h
08031F14 7001     strb    r1,[r0]		;偏移30写入0
08031F16 4803     ldr     r0,=833E554h
08031F18 E00A     b       @@writeOam
.pool

08031F28 1C18     mov     r0,r3
08031F2A 3030     add     r0,30h
08031F2C 7002     strb    r2,[r0]			;偏移30写入1
08031F2E 4802     ldr     r0,=833E57Ch

@@writeOam:
08031F30 6198     str     r0,[r3,18h]
08031F32 BC01     pop     r0
08031F34 4700     bx      r0
.align
////////////////////////////////////////////////////////////////////////////////////
;左右脚下有砖并动画结束--pose2调用
08031F3C B500     push    lr
08031F3E 4B0A     ldr     r3,=30006BCh
08031F40 1C19     mov     r1,r3
08031F42 3124     add     r1,24h
08031F44 2200     mov     r2,0h
08031F46 2018     mov     r0,18h
08031F48 7008     strb    r0,[r1]		;pose写入18
08031F4A 771A     strb    r2,[r3,1Ch]
08031F4C 2000     mov     r0,0h
08031F4E 82DA     strh    r2,[r3,16h]	;动画和帧归零
08031F50 310D     add     r1,0Dh
08031F52 7008     strb    r0,[r1]		;偏移31写入0
08031F54 1C18     mov     r0,r3
08031F56 3030     add     r0,30h
08031F58 7800     ldrb    r0,[r0]		
08031F5A 2800     cmp     r0,0h			;偏移30检查是否为0 偏移30为大跳flag
08031F5C D008     beq     oft30zero
08031F5E 8858     ldrh    r0,[r3,2h]
08031F60 3830     sub     r0,30h		;读取Y坐标向上30h再写入
08031F62 8058     strh    r0,[r3,2h]
08031F64 4801     ldr     r0,=833E70Ch	;跳跃oam
08031F66 E007     b       @@writeOam

@@oft30zero:
08031F70 8858     ldrh    r0,[r3,2h]
08031F72 3820     sub     r0,20h		;Y坐标改变
08031F74 8058     strh    r0,[r3,2h]
08031F76 4803     ldr     r0,=833E6FCh	;小跳oam

@@writeOam:
08031F78 6198     str     r0,[r3,18h]
08031F7A 4803     ldr     r0,=175h
08031F7C F7D0FC6A bl      8002854h		;播放跳跃声音?
08031F80 BC01     pop     r0
08031F82 4700     bx      r0


;落地--Pose18调用
08031F8C 4905     ldr     r1,=30006BCh
08031F8E 1C0B     mov     r3,r1
08031F90 3324     add     r3,24h		
08031F92 2200     mov     r2,0h
08031F94 201A     mov     r0,1Ah
08031F96 7018     strb    r0,[r3]		;pose写入1Ah
08031F98 770A     strb    r2,[r1,1Ch]
08031F9A 82CA     strh    r2,[r1,16h]	;归零动画和帧
08031F9C 4802     ldr     r0,=833E5A4h	;落地OAM
08031F9E 6188     str     r0,[r1,18h]
08031FA0 4770     bx      r14
.pool


;pose1a调用
08031FAC 4905     ldr     r1,=30006BCh
08031FAE 1C0B     mov     r3,r1
08031FB0 3324     add     r3,24h
08031FB2 2200     mov     r2,0h
08031FB4 2008     mov     r0,8h
08031FB6 7018     strb    r0,[r3]			;pose写入8h
08031FB8 770A     strb    r2,[r1,1Ch]
08031FBA 82CA     strh    r2,[r1,16h]
08031FBC 4802     ldr     r0,=833E5B4h		;常态彷徨
08031FBE 6188     str     r0,[r1,18h]
08031FC0 4770     bx      r14
.align

;脚下无砖--pose2调用 pose3也调用 头碰壁后
08031FCC 4B06     ldr     r3,=30006BCh
08031FCE 1C1A     mov     r2,r3
08031FD0 3224     add     r2,24h
08031FD2 2100     mov     r1,0h
08031FD4 2016     mov     r0,16h
08031FD6 7010     strb    r0,[r2]		;pose写入16;
08031FD8 1C18     mov     r0,r3
08031FDA 3031     add     r0,31h
08031FDC 7001     strb    r1,[r0]		;偏移31清零
08031FDE 7719     strb    r1,[r3,1Ch]
08031FE0 82D9     strh    r1,[r3,16h]
08031FE2 4802     ldr     r0,=833E70Ch	;使用了大跳的oam
08031FE4 6198     str     r0,[r3,18h]	;写入新的oam
08031FE6 4770     bx      r14


;pose1a调用
08031FF0 4B06     ldr     r3,=30006BCh
08031FF2 1C19     mov     r1,r3
08031FF4 3124     add     r1,24h
08031FF6 2200     mov     r2,0h
08031FF8 2004     mov     r0,4h
08031FFA 7008     strb    r0,[r1]			;pose写入4
08031FFC 771A     strb    r2,[r3,1Ch]
08031FFE 2000     mov     r0,0h
08032000 82DA     strh    r2,[r3,16h]
08032002 310B     add     r1,0Bh
08032004 7008     strb    r0,[r1]
08032006 4802     ldr     r0,=833E5ECh
08032008 6198     str     r0,[r3,18h]
0803200A 4770     bx      r14
.pool

;pose1A调用
08032014 B500     push    lr
08032016 4B0A     ldr     r3,=30006BCh
08032018 1C19     mov     r1,r3
0803201A 3124     add     r1,24h
0803201C 2200     mov     r2,0h
0803201E 202A     mov     r0,2Ah
08032020 7008     strb    r0,[r1]			;pose 写入2a 吐酸
08032022 4808     ldr     r0,=833E684h
08032024 6198     str     r0,[r3,18h]
08032026 771A     strb    r2,[r3,1Ch]
08032028 82DA     strh    r2,[r3,16h]		;写入吐酸的oam
0803202A 4807     ldr     r0,=30007F0h		;读取随机值
0803202C 7801     ldrb    r1,[r0]			
0803202E 2201     mov     r2,1h
08032030 1C10     mov     r0,r2
08032032 4008     and     r0,r1
08032034 2800     cmp     r0,0h				;检查是否是偶数
08032036 D009     beq     @@bigflagPass
08032038 1C18     mov     r0,r3
0803203A 3030     add     r0,30h
0803203C 7002     strb    r2,[r0]			;大跳flag写入
0803203E E009     b       @@end
.pool

@@bigflagPass:
0803204C 1C19     mov     r1,r3
0803204E 3130     add     r1,30h
08032050 2002     mov     r0,2h
08032052 7008     strb    r0,[r1]

@@end:
08032054 BC01     pop     r0
08032056 4700     bx      r0
.align
//////////////////////////////////////////////////////////////////////////////////
Pose2:
08032058 B530     push    r4,r5,lr
0803205A 4C0C     ldr     r4,=30006BCh
0803205C 8860     ldrh    r0,[r4,2h]		;读取Y坐标
0803205E 2210     mov     r2,10h
08032060 5EA1     ldsh    r1,[r4,r2]		;读取右部分界
08032062 88A2     ldrh    r2,[r4,4h]		;读取X坐标
08032064 1889     add     r1,r1,r2			;右部分界加上X坐标
08032066 F7DFF993 bl      8011390h			;检查砖块
0803206A 4D09     ldr     r5,=30007A5h
0803206C 7828     ldrb    r0,[r5]
0803206E 2800     cmp     r0,0h
08032070 D110     bne     @@HaveBlock
08032072 8860     ldrh    r0,[r4,2h]		
08032074 220E     mov     r2,0Eh
08032076 5EA1     ldsh    r1,[r4,r2]		
08032078 88A4     ldrh    r4,[r4,4h]
0803207A 1909     add     r1,r1,r4
0803207C F7DFF988 bl      8011390h			;检查左边砖块
08032080 7828     ldrb    r0,[r5]
08032082 2800     cmp     r0,0h
08032084 D106     bne     @@HaveBlock
08032086 F7FFFFA1 bl      8031FCCh			;脚下左右都没有砖块 pose写入16 坠落
0803208A E009     b       @@end
.pool

@@HaveBlock:
08032094 F7DFFC4E bl      8011934h			;检查动画结束
08032098 2800     cmp     r0,0h
0803209A D001     beq     @@end
0803209C F7FFFF4E bl      8031F3Ch			;左右有砖并动画结束

@@end:
080320A0 BC30     pop     r4,r5
080320A2 BC01     pop     r0
080320A4 4700     bx      r0

///////////////////////////////////////////////////////////////////////////
Pose18:			;跳跃
080320A8 B570     push    r4-r6,lr
080320AA 2600     mov     r6,0h
080320AC 4A03     ldr     r2,=30006BCh
080320AE 1C10     mov     r0,r2
080320B0 3030     add     r0,30h
080320B2 7800     ldrb    r0,[r0]		;读取偏移30h 大跳flag
080320B4 2800     cmp     r0,0h
080320B6 D105     bne     @@bigJump
080320B8 4901     ldr     r1,=833C266h	;小跳的轨迹数据偏移值 貌似没有使用
080320BA E004     b       @@Goto
.pool

@@bigJump:
080320C4 4910     ldr     r1,=833C252h	;大跳的轨迹数据偏移地址 貌似没有使用...

@@Goto:
080320C6 1C10     mov     r0,r2
080320C8 3031     add     r0,31h
080320CA 7800     ldrb    r0,[r0]		;读取偏移31
080320CC 0880     lsr     r0,r0,2h
080320CE 0040     lsl     r0,r0,1h		;除以4再乘以2
080320D0 1840     add     r0,r0,r1		;加上偏移值
080320D2 8805     ldrh    r5,[r0]		;读取数据
080320D4 4C0D     ldr     r4,=30006BCh	
080320D6 8821     ldrh    r1,[r4]		
080320D8 2040     mov     r0,40h
080320DA 4008     and     r0,r1			;检查面向
080320DC 2800     cmp     r0,0h
080320DE D01C     beq     @@faceLeft
;向右跳
080320E0 8860     ldrh    r0,[r4,2h]	;读取Y坐标
080320E2 3810     sub     r0,10h		;向上20h 半格
080320E4 2210     mov     r2,10h
080320E6 5EA1     ldsh    r1,[r4,r2]	;读取右部分界
080320E8 88A2     ldrh    r2,[r4,4h]	;读取x坐标
080320EA 1889     add     r1,r1,r2		
080320EC 3104     add     r1,4h			;再加4
080320EE F7DFF94F bl      8011390h		;检查砖块
080320F2 4807     ldr     r0,=30007A5h
080320F4 7800     ldrb    r0,[r0]
080320F6 2811     cmp     r0,11h
080320F8 D10C     bne     @@RightNoBlock
080320FA 1C70     add     r0,r6,1		;r6+1
080320FC 0600     lsl     r0,r0,18h
080320FE 0E06     lsr     r6,r0,18h
08032100 88A0     ldrh    r0,[r4,4h]	;读取X坐标
08032102 3804     sub     r0,4h			;向左反弹4
08032104 E020     b       @@writeX

@@RightNoBlock:
08032114 88A0     ldrh    r0,[r4,4h]	;无砖竟然直接只加2....
08032116 3002     add     r0,2h
08032118 E016     b       @@writeX

@@faceLeft:
0803211A 8860     ldrh    r0,[r4,2h]	;读取Y坐标
0803211C 3810     sub     r0,10h		;向上10h
0803211E 220E     mov     r2,0Eh		
08032120 5EA1     ldsh    r1,[r4,r2]	;左部分界
08032122 88A2     ldrh    r2,[r4,4h]	;读取X坐标
08032124 1889     add     r1,r1,r2		;加上左部分界
08032126 3904     sub     r1,4h			;再减4h
08032128 F7DFF932 bl      8011390h		;检查是否有砖
0803212C 4804     ldr     r0,=30007A5h
0803212E 7800     ldrb    r0,[r0]
08032130 2811     cmp     r0,11h
08032132 D107     bne     @@leftNoBlock
08032134 1C70     add     r0,r6,1
08032136 0600     lsl     r0,r0,18h
08032138 0E06     lsr     r6,r0,18h
0803213A 88A0     ldrh    r0,[r4,4h]
0803213C 3004     add     r0,4h			;反弹4h
0803213E E003     b       @@writeX
.pool

@@leftNoBlock:
08032144 88A0     ldrh    r0,[r4,4h]
08032146 3802     sub     r0,2h

@@writeX:
08032148 80A0     strh    r0,[r4,4h]	;写入新X坐标
0803214A 4C0D     ldr     r4,=30006BCh
0803214C 8860     ldrh    r0,[r4,2h]	;读取Y坐标
0803214E 1940     add     r0,r0,r5		;加上跳跃轨迹数据
08032150 8060     strh    r0,[r4,2h]	;写入
08032152 1C21     mov     r1,r4
08032154 3131     add     r1,31h		;偏移31读取  偏移31记录跳跃的轨迹偏移值
08032156 7808     ldrb    r0,[r1]
08032158 2826     cmp     r0,26h		;如果大于26h
0803215A D801     bhi     @@31bhi26
0803215C 3001     add     r0,1h			;加1再写入
0803215E 7008     strb    r0,[r1]

@@31bhi26:
08032160 0428     lsl     r0,r5,10h		;检查跳跃轨迹数据是否小于或等于0
08032162 2800     cmp     r0,0h
08032164 DD32     ble     @@lessthan1
08032166 8860     ldrh    r0,[r4,2h]
08032168 88A1     ldrh    r1,[r4,4h]	;读取xy坐标
0803216A F7DFF803 bl      8011174h		;检查砖块,返回的是地面坐标
0803216E 1C01     mov     r1,r0
08032170 4D04     ldr     r5,=30007A4h
08032172 7828     ldrb    r0,[r5]
08032174 2800     cmp     r0,0h
08032176 D007     beq     @@air			;仍在空中
08032178 8061     strh    r1,[r4,2h]	;已经落地,坐标写入在地面
0803217A F7FFFF07 bl      8031F8Ch		;正常落地pose写入
0803217E E056     b       @@end
.pool

@@air:
08032188 2E00     cmp     r6,0h
0803218A D150     bne     @@end
0803218C 8860     ldrh    r0,[r4,2h]
0803218E 2210     mov     r2,10h
08032190 5EA1     ldsh    r1,[r4,r2]	;读取右部分界
08032192 88A2     ldrh    r2,[r4,4h]	;读取X坐标
08032194 1889     add     r1,r1,r2		;相加
08032196 F7DEFFED bl      8011174h		;检查落地情况
0803219A 1C01     mov     r1,r0			
0803219C 7828     ldrb    r0,[r5]		
0803219E 2800     cmp     r0,0h
080321A0 D10D     bne     @@downHaveBlock
080321A2 8860     ldrh    r0,[r4,2h]
080321A4 220E     mov     r2,0Eh
080321A6 5EA1     ldsh    r1,[r4,r2]
080321A8 88A4     ldrh    r4,[r4,4h]
080321AA 1909     add     r1,r1,r4
080321AC F7DEFFE2 bl      8011174h
080321B0 1C01     mov     r1,r0
080321B2 7828     ldrb    r0,[r5]
080321B4 2800     cmp     r0,0h
080321B6 D000     beq     @@downNoBlock
080321B8 2601     mov     r6,1h

@@downNoBlock:
080321BA 2E00     cmp     r6,0h
080321BC D037     beq     @@end

@@downHaveBlock:
080321BE 4802     ldr     r0,=30006BCh
080321C0 8041     strh    r1,[r0,2h]
080321C2 F7FFFEE3 bl      8031F8Ch			;正常落地pose1A写入
080321C6 E032     b       @@end
.pool

@@lessthan1:	;意思为上升的过程中
080321CC 2600     mov     r6,0h
080321CE 210A     mov     r1,0Ah
080321D0 5E60     ldsh    r0,[r4,r1]		;读取上部分界
080321D2 8862     ldrh    r2,[r4,2h]		;读取Y坐标
080321D4 1880     add     r0,r0,r2			;相加
080321D6 2210     mov     r2,10h			
080321D8 5EA1     ldsh    r1,[r4,r2]		;读取右部分界
080321DA 88A2     ldrh    r2,[r4,4h]		;读取X坐标
080321DC 1889     add     r1,r1,r2			;相加
080321DE F7DFF8D7 bl      8011390h			;检查砖块
080321E2 4D0E     ldr     r5,=30007A5h
080321E4 7828     ldrb    r0,[r5]
080321E6 2811     cmp     r0,11h
080321E8 D00F     beq     @@topHaveBlock
080321EA 210A     mov     r1,0Ah
080321EC 5E60     ldsh    r0,[r4,r1]		;读取上部分界
080321EE 8862     ldrh    r2,[r4,2h]		;读取Y坐标
080321F0 1880     add     r0,r0,r2			;相加
080321F2 220E     mov     r2,0Eh			
080321F4 5EA1     ldsh    r1,[r4,r2]		;读取左部分界
080321F6 88A4     ldrh    r4,[r4,4h]		;读取X坐标
080321F8 1909     add     r1,r1,r4			;相加
080321FA F7DFF8C9 bl      8011390h			;检查砖块
080321FE 7828     ldrb    r0,[r5]
08032200 2811     cmp     r0,11h
08032202 D100     bne     @@topNoBlock
08032204 2601     mov     r6,1h

@@topNoBlock:
08032206 2E00     cmp     r6,0h
08032208 D011     beq     @@end

@@topHaveBlock:
0803220A 4A05     ldr     r2,=30006BCh
0803220C 8811     ldrh    r1,[r2]
0803220E 2040     mov     r0,40h
08032210 4008     and     r0,r1
08032212 2800     cmp     r0,0h				;检查面向
08032214 D006     beq     @@faceLeft
08032216 8890     ldrh    r0,[r2,4h]
08032218 3804     sub     r0,4h				;X向左4h
0803221A E005     b       @@peer
.pool

@@faceLeft:
08032224 8890     ldrh    r0,[r2,4h]
08032226 3004     add     r0,4h				;X向右4h

@@peer:
08032228 8090     strh    r0,[r2,4h]
0803222A F7FFFECF bl      8031FCCh			;非正常坠落16写入

@@end:
0803222E BC70     pop     r4-r6
08032230 BC01     pop     r0
08032232 4700     bx      r0

///////////////////////////////////////////////////////////////////////////////
Pose1A:		;正常落地
08032234 B500     push    lr
08032236 F7DFFB7D bl      8011934h			;检查当前动画结束
0803223A 2800     cmp     r0,0h
0803223C D022     beq     @@end
0803223E F7FFFD37 bl      8031CB0h			;检查是否在敌前方并且在范围内
08032242 0600     lsl     r0,r0,18h
08032244 2800     cmp     r0,0h
08032246 D002     beq     @@No
08032248 F7FFFEE4 bl      8032014h			;吐酸以及设置大跳flag
0803224C E01A     b       @@end

@@No:
0803224E F7FFFD59 bl      8031D04h			;正向返回1 敌背向返回2
08032252 0600     lsl     r0,r0,18h
08032254 0E00     lsr     r0,r0,18h
08032256 2801     cmp     r0,1h
08032258 D102     bne     @@NoRight
0803225A F7FFFE6F bl      8031F3Ch			;跳跃
0803225E E011     b       @@end

@@NoRight:
08032260 2802     cmp     r0,2h
08032262 D102     bne     @@NoLeft
08032264 F7FFFEC4 bl      8031FF0h			;pose写入4
08032268 E00C     b       @@end

@@NoLeft:
0803226A 4804     ldr     r0,=30006BCh
0803226C 302F     add     r0,2Fh
0803226E 7800     ldrb    r0,[r0]			;读取偏移2F
08032270 2802     cmp     r0,2h
08032272 D905     bls     @@lessthan3
08032274 F7FFFE9A bl      8031FACh			;常态彷徨pose 8写入
08032278 E004     b       @@end

@@lessthan3:
08032280 F7FFFE30 bl      8031EE4h			;pose1调用...

@@end:
08032284 BC01     pop     r0
08032286 4700     bx      r0
//////////////////////////////////////////////////////////////////////////////

Pose16:			;非正常坠落
08032288 B5F0     push    r4-r7,lr
0803228A 2600     mov     r6,0h
0803228C 4C13     ldr     r4,=30006BCh
0803228E 8860     ldrh    r0,[r4,2h]
08032290 88A1     ldrh    r1,[r4,4h]
08032292 F7DEFF6F bl      8011174h			;检查落地
08032296 1C01     mov     r1,r0
08032298 4D11     ldr     r5,=30007A4h
0803229A 7828     ldrb    r0,[r5]
0803229C 2800     cmp     r0,0h
0803229E D118     bne     @@onFloor
080322A0 8860     ldrh    r0,[r4,2h]
080322A2 2210     mov     r2,10h
080322A4 5EA1     ldsh    r1,[r4,r2]		
080322A6 88A7     ldrh    r7,[r4,4h]
080322A8 19C9     add     r1,r1,r7			;右部判定
080322AA F7DEFF63 bl      8011174h			;检查落地
080322AE 1C01     mov     r1,r0
080322B0 7828     ldrb    r0,[r5]
080322B2 2800     cmp     r0,0h
080322B4 D10D     bne     @@onFloor
080322B6 8860     ldrh    r0,[r4,2h]
080322B8 220E     mov     r2,0Eh
080322BA 5EA1     ldsh    r1,[r4,r2]
080322BC 88A7     ldrh    r7,[r4,4h]
080322BE 19C9     add     r1,r1,r7			;左部判定
080322C0 F7DEFF58 bl      8011174h			;检查落地
080322C4 1C01     mov     r1,r0
080322C6 7828     ldrb    r0,[r5]
080322C8 2800     cmp     r0,0h
080322CA D000     beq     @@nofall
080322CC 2601     mov     r6,1h

@@nofall:
080322CE 2E00     cmp     r6,0h
080322D0 D008     beq     @@hell

@@nofloor:
080322D2 4802     ldr     r0,=30006BCh
080322D4 8041     strh    r1,[r0,2h]		;写入地面的坐标
080322D6 F7FFFE59 bl      8031F8Ch			;正常落地pose写入1a
080322DA E023     b       @@end
.pool

@@hell:
080322E4 1C23     mov     r3,r4
080322E6 2031     mov     r0,31h
080322E8 18C0     add     r0,r0,r3
080322EA 4684     mov     r12,r0
080322EC 7802     ldrb    r2,[r0]			;偏移31记录跳跃的轨迹偏移值
080322EE 4E08     ldr     r6,=82E49E0h
080322F0 0050     lsl     r0,r2,1h			;乘以2加上偏移值
080322F2 1980     add     r0,r0,r6
080322F4 8805     ldrh    r5,[r0]			;读取跳跃高度
080322F6 2700     mov     r7,0h
080322F8 5FC1     ldsh    r1,[r0,r7]		;读取负值的跳跃高度
080322FA 4806     ldr     r0,=7FFFh
080322FC 4281     cmp     r1,r0				;检查是否已经到了末尾
080322FE D10B     bne     @@no7fff
08032300 1E51     sub     r1,r2,1			;31偏移值减1
08032302 0049     lsl     r1,r1,1h
08032304 1989     add     r1,r1,r6
08032306 8858     ldrh    r0,[r3,2h]		;读取Y坐标
08032308 8809     ldrh    r1,[r1]			;读取结束前的跳跃高度
0803230A 1840     add     r0,r0,r1			;加上Y坐标写入
0803230C 8058     strh    r0,[r3,2h]
0803230E E009     b       @@end
.pool

@@no7fff:
08032318 1C50     add     r0,r2,1
0803231A 4661     mov     r1,r12
0803231C 7008     strb    r0,[r1]
0803231E 8860     ldrh    r0,[r4,2h]
08032320 1940     add     r0,r0,r5
08032322 8060     strh    r0,[r4,2h]		;写入y坐标

@@end:
08032324 BCF0     pop     r4-r7
08032326 BC01     pop     r0
08032328 4700     bx      r0
.pool
/////////////////////////////////////////////////////////////////////////////////////////////////

Pose8:
0803232C B530     push    r4,r5,lr
0803232E 4C0C     ldr     r4,=30006BCh
08032330 8860     ldrh    r0,[r4,2h]
08032332 2210     mov     r2,10h
08032334 5EA1     ldsh    r1,[r4,r2]		;读取右部分界
08032336 88A2     ldrh    r2,[r4,4h]		;X坐标
08032338 1889     add     r1,r1,r2			;相加
0803233A F7DFF829 bl      8011390h			;检查砖块
0803233E 4D09     ldr     r5,=30007A5h
08032340 7828     ldrb    r0,[r5]
08032342 2800     cmp     r0,0h
08032344 D110     bne     @@onFloor
08032346 8860     ldrh    r0,[r4,2h]
08032348 220E     mov     r2,0Eh
0803234A 5EA1     ldsh    r1,[r4,r2]
0803234C 88A4     ldrh    r4,[r4,4h]
0803234E 1909     add     r1,r1,r4
08032350 F7DFF81E bl      8011390h
08032354 7828     ldrb    r0,[r5]
08032356 2800     cmp     r0,0h
08032358 D106     bne     @@onFloor
0803235A F7FFFE37 bl      8031FCCh		;坠落,pose写入16
0803235E E01F     b       @@end
.pool

@@onFloor:
08032368 F7DFFAE4 bl      8011934h		;检查动画帧结束
0803236C 2800     cmp     r0,0h
0803236E D017     beq     @@end
08032370 F7FFFCC8 bl      8031D04h		;检查正背
08032374 0600     lsl     r0,r0,18h
08032376 0E00     lsr     r0,r0,18h
08032378 2801     cmp     r0,1h
0803237A D102     bne     @@no1
0803237C F7FFFDB2 bl      8031EE4h		;pose1
08032380 E00E     b       @@end

@@no1:
08032382 2802     cmp     r0,2h
08032384 D004     beq     @@is2
08032386 4804     ldr     r0,=30006BCh
08032388 302F     add     r0,2Fh		;检查偏移2F
0803238A 7800     ldrb    r0,[r0]
0803238C 2802     cmp     r0,2h
0803238E D905     bls     @@lessthan3

@@is2:
08032390 F7FFFE2E bl      8031FF0h		;pose写入4
08032394 E004     b       @@end
.pool

@@lessthan3:
0803239C F7FFFDA2 bl      8031EE4h		;pose1

@@end:
080323A0 BC30     pop     r4,r5
080323A2 BC01     pop     r0
080323A4 4700     bx      r0
.pool

Pose4:
080323A8 B510     push    r4,lr
080323AA 4C0E     ldr     r4,=30006BCh
080323AC 8AE0     ldrh    r0,[r4,16h]
080323AE 2800     cmp     r0,0h				;动画是否为0
080323B0 D002     beq     @@animationzero
080323B2 8860     ldrh    r0,[r4,2h]
080323B4 3804     sub     r0,4h				;y坐标向上4h
080323B6 8060     strh    r0,[r4,2h]

@@animationzero:
080323B8 F7DFFABC bl      8011934h			;检查动画
080323BC 2800     cmp     r0,0h
080323BE D00D     beq     @@end
080323C0 8821     ldrh    r1,[r4]
080323C2 2040     mov     r0,40h
080323C4 4041     eor     r1,r0				;改变面向
080323C6 2200     mov     r2,0h
080323C8 2300     mov     r3,0h
080323CA 8021     strh    r1,[r4]
080323CC 1C21     mov     r1,r4
080323CE 3124     add     r1,24h
080323D0 2005     mov     r0,5h				;pose写入5
080323D2 7008     strb    r0,[r1]
080323D4 7722     strb    r2,[r4,1Ch]
080323D6 82E3     strh    r3,[r4,16h]
080323D8 4803     ldr     r0,=833E604h		;写入新的oam
080323DA 61A0     str     r0,[r4,18h]

@@end:
080323DC BC10     pop     r4
080323DE BC01     pop     r0
080323E0 4700     bx      r0
.pool

Pose5:
080323EC B510     push    r4,lr
080323EE 4C0E     ldr     r4,=30006BCh
080323F0 8AE0     ldrh    r0,[r4,16h]
080323F2 2800     cmp     r0,0h
080323F4 D002     beq     @@AnimationZero
080323F6 8860     ldrh    r0,[r4,2h]
080323F8 3004     add     r0,4h			;动画为0时下降4
080323FA 8060     strh    r0,[r4,2h]

@@AnimationZero:
080323FC 8821     ldrh    r1,[r4]
080323FE 2040     mov     r0,40h
08032400 4008     and     r0,r1
08032402 2800     cmp     r0,0h			;检查面向
08032404 D014     beq     @@faceLeft
08032406 8860     ldrh    r0,[r4,2h]
08032408 3810     sub     r0,10h
0803240A 2210     mov     r2,10h
0803240C 5EA1     ldsh    r1,[r4,r2]	
0803240E 88A2     ldrh    r2,[r4,4h]
08032410 1889     add     r1,r1,r2		;右部判定再加4h
08032412 3104     add     r1,4h
08032414 F7DEFFBC bl      8011390h		;检查是否有砖
08032418 4804     ldr     r0,=30007A5h
0803241A 7800     ldrb    r0,[r0]
0803241C 2811     cmp     r0,11h
0803241E D117     bne     @@noBlock
08032420 88A0     ldrh    r0,[r4,4h]
08032422 3804     sub     r0,4h			;右边有砖则向左移动4h
08032424 E013     b       @@writex
.pool

@@faceLeft:
08032430 8860     ldrh    r0,[r4,2h]
08032432 3810     sub     r0,10h
08032434 220E     mov     r2,0Eh
08032436 5EA1     ldsh    r1,[r4,r2]
08032438 88A2     ldrh    r2,[r4,4h]
0803243A 1889     add     r1,r1,r2
0803243C 3904     sub     r1,4h			;左判定向左4h检查砖块
0803243E F7DEFFA7 bl      8011390h
08032442 4808     ldr     r0,=30007A5h
08032444 7800     ldrb    r0,[r0]
08032446 2811     cmp     r0,11h
08032448 D102     bne     @@noBlock
0803244A 88A0     ldrh    r0,[r4,4h]
0803244C 3004     add     r0,4h			;左边有砖向右4h

@@writeX:
0803244E 80A0     strh    r0,[r4,4h]

@@noBlock:
08032450 F7DFFA70 bl      8011934h		;检查动画结束
08032454 2800     cmp     r0,0h
08032456 D001     beq     @@end
08032458 F7FFFDA8 bl      8031FACh		;pose写入8 常态彷徨?

@@end:
0803245C BC10     pop     r4
0803245E BC01     pop     r0
08032460 4700     bx      r0
///////////////////////////////////////////////////////////////////////////////////

Pose2A:			;吐酸
08032468 B530     push    r4,r5,lr
0803246A B083     add     sp,-0Ch
0803246C 4810     ldr     r0,=30006BCh
0803246E 4684     mov     r12,r0
08032470 8AC0     ldrh    r0,[r0,16h]
08032472 280B     cmp     r0,0Bh			;检查动画是否到了0b
08032474 D132     bne     80324DCh
08032476 4661     mov     r1,r12
08032478 7F08     ldrb    r0,[r1,1Ch]			
0803247A 2803     cmp     r0,3h				;检查动画帧是否到了3
0803247C D12E     bne     80324DCh
0803247E 8809     ldrh    r1,[r1]
08032480 2540     mov     r5,40h
08032482 1C28     mov     r0,r5
08032484 4008     and     r0,r1
08032486 0400     lsl     r0,r0,10h
08032488 0C04     lsr     r4,r0,10h
0803248A 2C00     cmp     r4,0h				;检查面向
0803248C D012     beq     @@faceLeft			
0803248E 4664     mov     r4,r12
08032490 7FA1     ldrb    r1,[r4,1Eh]		;读取副灵data
08032492 7FE2     ldrb    r2,[r4,1Fh]		;gfxrow
08032494 4660     mov     r0,r12
08032496 3023     add     r0,23h			;主精灵序号
08032498 7803     ldrb    r3,[r0]
0803249A 8860     ldrh    r0,[r4,2h]		
0803249C 3858     sub     r0,58h			;Y坐标向上58h
0803249E 9000     str     r0,[sp]
080324A0 88A0     ldrh    r0,[r4,4h]
080324A2 3060     add     r0,60h			;X坐标加60h
080324A4 9001     str     r0,[sp,4h]
080324A6 9502     str     r5,[sp,8h]		;面向
080324A8 2011     mov     r0,11h			;副灵11
080324AA F7DDFB19 bl      800FAE0h			;生产副灵
080324AE E011     b       @@peer
.pool

@@faceLeft:
080324B4 4665     mov     r5,r12
080324B6 7FA9     ldrb    r1,[r5,1Eh]		;副灵data序号
080324B8 7FEA     ldrb    r2,[r5,1Fh]		;gfxrow
080324BA 4660     mov     r0,r12
080324BC 3023     add     r0,23h			;主灵序号
080324BE 7803     ldrb    r3,[r0]
080324C0 8868     ldrh    r0,[r5,2h]
080324C2 3858     sub     r0,58h			;y向上58
080324C4 9000     str     r0,[sp]
080324C6 88A8     ldrh    r0,[r5,4h]
080324C8 3860     sub     r0,60h			;x向左60h
080324CA 9001     str     r0,[sp,4h]
080324CC 9402     str     r4,[sp,8h]		;面向
080324CE 2011     mov     r0,11h			;副灵11
080324D0 F7DDFB06 bl      800FAE0h

@@peer:
080324D4 20BC     mov     r0,0BCh
080324D6 0040     lsl     r0,r0,1h
080324D8 F7D0F9BC bl      8002854h			;播放178h 376

@@CheckAnimation:
080324DC F7DFFA2A bl      8011934h			;检查动画的结束
080324E0 2800     cmp     r0,0h
080324E2 D009     beq     @@end
080324E4 4906     ldr     r1,=30006BCh
080324E6 3130     add     r1,30h
080324E8 7808     ldrb    r0,[r1]			;读取偏移30
080324EA 3801     sub     r0,1h				;减1再写入
080324EC 7008     strb    r0,[r1]
080324EE 0600     lsl     r0,r0,18h			
080324F0 2800     cmp     r0,0h				;不是0的话就结束
080324F2 D101     bne     @@end
080324F4 F7FFFCF6 bl      8031EE4h			;是0则调用pose1

@@end:
080324F8 B003     add     sp,0Ch
080324FA BC30     pop     r4,r5
080324FC BC01     pop     r0
080324FE 4700     bx      r0


;airpose2调用 移动例程   r0为移动速度 有砖块返回1,否则返回0
08032504 B570     push    r4-r6,lr
08032506 0400     lsl     r0,r0,10h
08032508 0C05     lsr     r5,r0,10h
0803250A 1C2E     mov     r6,r5
0803250C 4C09     ldr     r4,=30006BCh
0803250E 8821     ldrh    r1,[r4]
08032510 2040     mov     r0,40h
08032512 4008     and     r0,r1
08032514 2800     cmp     r0,0h				;检查面向
08032516 D011     beq     @@faceLeft
08032518 8860     ldrh    r0,[r4,2h]
0803251A 3810     sub     r0,10h
0803251C 88A1     ldrh    r1,[r4,4h]
0803251E 3130     add     r1,30h			;检查右侧的砖块
08032520 F7DEFF36 bl      8011390h
08032524 4804     ldr     r0,=30007A5h
08032526 7800     ldrb    r0,[r0]
08032528 2811     cmp     r0,11h
0803252A D011     beq     8032550h
0803252C 88A0     ldrh    r0,[r4,4h]
0803252E 1828     add     r0,r5,r0			;向右移动2h
08032530 E014     b       @@writeX
.pool

@@faceLeft:
0803253C 8860     ldrh    r0,[r4,2h]
0803253E 3810     sub     r0,10h
08032540 88A1     ldrh    r1,[r4,4h]
08032542 3930     sub     r1,30h
08032544 F7DEFF24 bl      8011390h
08032548 4802     ldr     r0,=30007A5h
0803254A 7800     ldrb    r0,[r0]
0803254C 2811     cmp     r0,11h
0803254E D103     bne     @@NoBlock

@@haveblock:
08032550 2001     mov     r0,1h
08032552 E005     b       @@end
.pool

@@NoBlock:
08032558 88A0     ldrh    r0,[r4,4h]
0803255A 1B80     sub     r0,r0,r6			;向左移动2h

@@writeX:
0803255C 80A0     strh    r0,[r4,4h]
0803255E 2000     mov     r0,0h

@@end:
08032560 BC70     pop     r4-r6
08032562 BC02     pop     r1
08032564 4708     bx      r1
.align

airPose0:
08032568 B530     push    r4,r5,lr
0803256A B083     add     sp,-0Ch
0803256C F7E0F954 bl      8012818h			;判断是否要碰撞属性orr2
08032570 4C06     ldr     r4,=30006BCh
08032572 1C20     mov     r0,r4
08032574 3034     add     r0,34h
08032576 7801     ldrb    r1,[r0]			;读取碰撞属性
08032578 2302     mov     r3,2h
0803257A 1C18     mov     r0,r3
0803257C 4008     and     r0,r1
0803257E 0600     lsl     r0,r0,18h
08032580 0E02     lsr     r2,r0,18h
08032582 2A00     cmp     r2,0h				;检查是否有2
08032584 D004     beq     @@no2
08032586 2000     mov     r0,0h
08032588 8020     strh    r0,[r4]			;没有就直接取消精灵..
0803258A E05C     b       @@end
.pool

@@no2:
08032590 1C21     mov     r1,r4
08032592 3127     add     r1,27h
08032594 2020     mov     r0,20h
08032596 7008     strb    r0,[r1]			;视野判定上写入20h
08032598 3101     add     r1,1h
0803259A 2008     mov     r0,8h
0803259C 7008     strb    r0,[r1]			;视野判定下写入8h
0803259E 3101     add     r1,1h
080325A0 2018     mov     r0,18h
080325A2 7008     strb    r0,[r1]			;视野左右判定写入18h
080325A4 2100     mov     r1,0h
080325A6 4815     ldr     r0,=0FFA0h
080325A8 8160     strh    r0,[r4,0Ah]		;上部判定写入0FFA0h
080325AA 81A2     strh    r2,[r4,0Ch]		;下部判定写入0
080325AC 3038     add     r0,38h
080325AE 81E0     strh    r0,[r4,0Eh]		;左部判定写入0FFD8h
080325B0 2028     mov     r0,28h
080325B2 8220     strh    r0,[r4,10h]		;右部判定写入28h
080325B4 4812     ldr     r0,=833E454h
080325B6 61A0     str     r0,[r4,18h]
080325B8 7721     strb    r1,[r4,1Ch]
080325BA 82E2     strh    r2,[r4,16h]		;基础OAM写入
080325BC 1C20     mov     r0,r4
080325BE 302E     add     r0,2Eh
080325C0 7001     strb    r1,[r0]			;偏移2E写入0
080325C2 3003     add     r0,3h
080325C4 7001     strb    r1,[r0]			;偏移31写入0
080325C6 4A0F     ldr     r2,=82E4D4Ch
080325C8 7F61     ldrb    r1,[r4,1Dh]
080325CA 00C8     lsl     r0,r1,3h
080325CC 1A40     sub     r0,r0,r1
080325CE 0040     lsl     r0,r0,1h			;读取血量
080325D0 1880     add     r0,r0,r2
080325D2 8800     ldrh    r0,[r0]
080325D4 82A0     strh    r0,[r4,14h]		;写入血量
080325D6 1C20     mov     r0,r4
080325D8 3025     add     r0,25h
080325DA 7003     strb    r3,[r0]			;属性写入2
080325DC F7DEFFAE bl      801153Ch			;使敌面向samus例程
080325E0 1C21     mov     r1,r4
080325E2 3124     add     r1,24h
080325E4 7808     ldrb    r0,[r1]			;读取pose
080325E6 2859     cmp     r0,59h
080325E8 D110     bne     @@poseNo59
080325EA 205A     mov     r0,5Ah			;pose如果是59
080325EC 7008     strb    r0,[r1]			;pose写入5Ah
080325EE 202C     mov     r0,2Ch
080325F0 80E0     strh    r0,[r4,6h]		;偏移6写入2Ch
080325F2 8821     ldrh    r1,[r4]
080325F4 4804     ldr     r0,=0FFFBh
080325F6 4008     and     r0,r1				;去掉隐形
080325F8 8020     strh    r0,[r4]			;写入
080325FA E009     b       @@Peer
.pool

@@poseNo59?:
0803260C 2001     mov     r0,1h
0803260E 7008     strb    r0,[r1]			;pose写入1

@@Peer:
08032610 4D0F     ldr     r5,=30006BCh
08032612 8868     ldrh    r0,[r5,2h]
08032614 8128     strh    r0,[r5,8h]		;Y高度备份到偏移8
08032616 7FA9     ldrb    r1,[r5,1Eh]		;副灵data
08032618 7FEA     ldrb    r2,[r5,1Fh]		;gfxrow
0803261A 1C28     mov     r0,r5
0803261C 3023     add     r0,23h
0803261E 7803     ldrb    r3,[r0]			;主灵序号
08032620 8868     ldrh    r0,[r5,2h]
08032622 9000     str     r0,[sp]
08032624 88A8     ldrh    r0,[r5,4h]
08032626 9001     str     r0,[sp,4h]		;坐标
08032628 882C     ldrh    r4,[r5]
0803262A 2040     mov     r0,40h
0803262C 4020     and     r0,r4				;面向写入
0803262E 0400     lsl     r0,r0,10h
08032630 0C00     lsr     r0,r0,10h
08032632 9002     str     r0,[sp,8h]
08032634 2010     mov     r0,10h			;生产副灵翅膀
08032636 F7DDFA53 bl      800FAE0h
0803263A 0600     lsl     r0,r0,18h
0803263C 0E00     lsr     r0,r0,18h
0803263E 28FF     cmp     r0,0FFh
08032640 D101     bne     @@end				;如果生产成功则结束
08032642 2000     mov     r0,0h
08032644 8028     strh    r0,[r5]			;失败则主灵也消失

@@end:
08032646 B003     add     sp,0Ch
08032648 BC30     pop     r4,r5
0803264A BC01     pop     r0
0803264C 4700     bx      r0
.pool

////////////////////////////////////////////////////////////////////////////////////
airPose1:
08032654 4B08     ldr     r3,=30006BCh
08032656 1C19     mov     r1,r3
08032658 3124     add     r1,24h
0803265A 2200     mov     r2,0h
0803265C 2002     mov     r0,2h
0803265E 7008     strb    r0,[r1]			;pose写入2h
08032660 771A     strb    r2,[r3,1Ch]		;动画帧归零
08032662 2100     mov     r1,0h
08032664 82DA     strh    r2,[r3,16h]		;动画归零
08032666 4805     ldr     r0,=833E454h
08032668 6198     str     r0,[r3,18h]		;写入常态oam
0803266A 1C18     mov     r0,r3
0803266C 302E     add     r0,2Eh
0803266E 7001     strb    r1,[r0]			;偏移2E写入0
08032670 3003     add     r0,3h
08032672 7001     strb    r1,[r0]			;偏移31写入0
08032674 4770     bx      r14
///////////////////////////////////////////////////////////////////////////////////
airPose3:		;转身
08032680 4905     ldr     r1,=30006BCh
08032682 1C0B     mov     r3,r1
08032684 3324     add     r3,24h
08032686 2200     mov     r2,0h
08032688 2004     mov     r0,4h				;pose写入4
0803268A 7018     strb    r0,[r3]
0803268C 770A     strb    r2,[r1,1Ch]
0803268E 82CA     strh    r2,[r1,16h]
08032690 4802     ldr     r0,=833E5ECh		;转身的oam
08032692 6188     str     r0,[r1,18h]
08032694 4770     bx      r14
.pool
//////////////////////////////////////////////////////////////////////////////////

airPose2:
080326A0 B5F0     push    r4-r7,lr
080326A2 4647     mov     r7,r8
080326A4 B480     push    r7
080326A6 4B0C     ldr     r3,=30006BCh
080326A8 1C1E     mov     r6,r3
080326AA 3631     add     r6,31h
080326AC 7832     ldrb    r2,[r6]			;读取偏移31h
080326AE 4D0B     ldr     r5,=833C27Ah		;移动偏移值??
080326B0 0050     lsl     r0,r2,1h			;31乘以2
080326B2 1940     add     r0,r0,r5			;加上偏移
080326B4 8804     ldrh    r4,[r0]			;读取值
080326B6 2700     mov     r7,0h
080326B8 5FC1     ldsh    r1,[r0,r7]		;读取有符号值
080326BA 4809     ldr     r0,=7FFFh			
080326BC 4281     cmp     r1,r0				;比较是否到末尾
080326BE D101     bne     @@no7FFF
080326C0 882C     ldrh    r4,[r5]
080326C2 2200     mov     r2,0h

@@no7FFF:
080326C4 1C50     add     r0,r2,1
080326C6 7030     strb    r0,[r6]			;偏移31递增再写入
080326C8 0420     lsl     r0,r4,10h
080326CA 2800     cmp     r0,0h				;检查是否大于零
080326CC DD0A     ble     @@lessthanzero	;小于则为上升??
080326CE 8858     ldrh    r0,[r3,2h]		;大于则为下降??
080326D0 8899     ldrh    r1,[r3,4h]		;检查身下砖块
080326D2 F7DEFE5D bl      8011390h
080326D6 E00A     b       @@peer			
.pool

@@lessthanzero:
080326E4 8858     ldrh    r0,[r3,2h]
080326E6 3860     sub     r0,60h			
080326E8 8899     ldrh    r1,[r3,4h]
080326EA F7DEFE51 bl      8011390h			;检查身上砖块

@@peer:
080326EE 4809     ldr     r0,=30007A5h
080326F0 7800     ldrb    r0,[r0]
080326F2 2811     cmp     r0,11h
080326F4 D003     beq     @@haveblock
080326F6 4908     ldr     r1,=30006BCh
080326F8 8848     ldrh    r0,[r1,2h]
080326FA 1900     add     r0,r0,r4
080326FC 8048     strh    r0,[r1,2h]		;写入新Y坐标

@@haveblock:
080326FE 2002     mov     r0,2h
08032700 F7FFFF00 bl      8032504h			;移动函数
08032704 0600     lsl     r0,r0,18h
08032706 2800     cmp     r0,0h
08032708 D008     beq     @@movesuccess		
0803270A 4803     ldr     r0,=30006BCh
0803270C 3024     add     r0,24h
0803270E 2103     mov     r1,3h
08032710 7001     strb    r1,[r0]			;移动失败则pose 写入3
08032712 E049     b       @@end
.pool

@@movesuccess:
0803271C 4E18     ldr     r6,=30006BCh
0803271E 1C30     mov     r0,r6
08032720 3031     add     r0,31h
08032722 7800     ldrb    r0,[r0]			;读取偏移31
08032724 282F     cmp     r0,2Fh			;检查是否是2Fh
08032726 D13F     bne     @@end
08032728 202E     mov     r0,2Eh
0803272A 1980     add     r0,r0,r6			;读取偏移2E
0803272C 4680     mov     r8,r0
0803272E 7800     ldrb    r0,[r0]			
08032730 3001     add     r0,1h				;加1再写入
08032732 4641     mov     r1,r8
08032734 7008     strb    r0,[r1]
08032736 4F13     ldr     r7,=3001244h
08032738 8B3D     ldrh    r5,[r7,18h]		;读取sa的Y坐标
0803273A 8874     ldrh    r4,[r6,2h]		;读取敌人Y坐标
0803273C 3C60     sub     r4,60h			;敌人Y坐标向上一格半
0803273E 0424     lsl     r4,r4,10h
08032740 0C24     lsr     r4,r4,10h
08032742 20A0     mov     r0,0A0h			;上下十格内
08032744 0080     lsl     r0,r0,2h
08032746 21F0     mov     r1,0F0h			;左右15格内
08032748 0089     lsl     r1,r1,2h
0803274A F7DFF9EB bl      8011B24h			;只要在屏幕内就不会返回0的检查敌人方位
0803274E 0600     lsl     r0,r0,18h
08032750 0E00     lsr     r0,r0,18h
08032752 42A5     cmp     r5,r4				;sa脚底高度和敌人头顶比较
08032754 D200     bcs     @@spritetopdown	;sa的脚底在敌人的头顶下
08032756 2000     mov     r0,0h				;sa的脚底在敌人的头顶上则直接结束

@@spritetopdown:
08032758 2800     cmp     r0,0h
0803275A D025     beq     @@end
0803275C 8831     ldrh    r1,[r6]
0803275E 2040     mov     r0,40h
08032760 4008     and     r0,r1
08032762 2800     cmp     r0,0h				;检查方向
08032764 D010     beq     @@faceLeft
08032766 88B0     ldrh    r0,[r6,4h]		;读取敌人的X坐标
08032768 8AFF     ldrh    r7,[r7,16h]		;读取sa的x坐标
0803276A 42B8     cmp     r0,r7				;敌人x坐标和sa的x坐标比较
0803276C D918     bls     @@faceman			;敌面右在人左边	也是面向人
0803276E 4647     mov     r7,r8
08032770 7838     ldrb    r0,[r7]
08032772 2801     cmp     r0,1h
08032774 D918     bls     @@end
08032776 1C31     mov     r1,r6
08032778 3124     add     r1,24h
0803277A 2003     mov     r0,3h				;不单单碰壁,背向也转身
0803277C E013     b       @@writepose
.pool

@@faceLeft:
08032788 88B0     ldrh    r0,[r6,4h]
0803278A 8AFF     ldrh    r7,[r7,16h]
0803278C 42B8     cmp     r0,r7
0803278E D207     bcs     @@faceman
08032790 4641     mov     r1,r8
08032792 7808     ldrb    r0,[r1]
08032794 2801     cmp     r0,1h
08032796 D907     bls     @@end
08032798 1C31     mov     r1,r6
0803279A 3124     add     r1,24h
0803279C 2003     mov     r0,3h				;背向转身pose
0803279E E002     b       @@writepose

@@faceman:
080327A0 1C31     mov     r1,r6
080327A2 3124     add     r1,24h
080327A4 2029     mov     r0,29h		;pose写入扑

@@writepose:
080327A6 7008     strb    r0,[r1]

@@end:
080327A8 BC08     pop     r3
080327AA 4698     mov     r8,r3
080327AC BCF0     pop     r4-r7
080327AE BC01     pop     r0
080327B0 4700     bx      r0
.pool
///////////////////////////////////////////////////////////////////////////////

airPose4:			;转身过程
080327B4 B510     push    r4,lr
080327B6 F7DFF8BD bl      8011934h
080327BA 2800     cmp     r0,0h				;检查动画是否结束
080327BC D00E     beq     @@end
080327BE 4A09     ldr     r2,=30006BCh
080327C0 8811     ldrh    r1,[r2]
080327C2 2040     mov     r0,40h
080327C4 4041     eor     r1,r0				;面向改变
080327C6 2300     mov     r3,0h
080327C8 2400     mov     r4,0h
080327CA 8011     strh    r1,[r2]
080327CC 1C11     mov     r1,r2
080327CE 3124     add     r1,24h
080327D0 2005     mov     r0,5h				;Pose写入5
080327D2 7008     strb    r0,[r1]
080327D4 7713     strb    r3,[r2,1Ch]
080327D6 82D4     strh    r4,[r2,16h]
080327D8 4803     ldr     r0,=833E604h		;写入新的OAM
080327DA 6190     str     r0,[r2,18h]

@@end:
080327DC BC10     pop     r4
080327DE BC01     pop     r0
080327E0 4700     bx      r0
.pool
///////////////////////////////////////////////////////////////////////////////////

airPose5:		;转身完成
080327EC B500     push    lr
080327EE F7DFF8A1 bl      8011934h
080327F2 2800     cmp     r0,0h
080327F4 D001     beq     @@end			;检查动画是否结束
080327F6 F7FFFF2D bl      8032654h		;Pose1调用

@@end:
080327FA BC01     pop     r0
080327FC 4700     bx      r0


;airPose2A调用
08032800 B510     push    r4,lr
08032802 4C0B     ldr     r4,=30006BCh
08032804 1C20     mov     r0,r4
08032806 3025     add     r0,25h
08032808 7800     ldrb    r0,[r0]
0803280A 2803     cmp     r0,3h			;检查属性是否为3
0803280C D037     beq     @@end			;为3则结束
0803280E 20A0     mov     r0,0A0h		;两格半高度范围和两格水平范围
08032810 2180     mov     r1,80h		;检查范围
08032812 F7DFF987 bl      8011B24h
08032816 0600     lsl     r0,r0,18h
08032818 2800     cmp     r0,0h
0803281A D018     beq     @@nodamage
0803281C 69A0     ldr     r0,[r4,18h]
0803281E 4905     ldr     r1,=833E50Ch 
08032820 4288     cmp     r0,r1			;检查oam是否是这个 扑手?
08032822 D009     beq     @@oamdown
08032824 61A1     str     r1,[r4,18h]	;不是的话则写入oam
08032826 2000     mov     r0,0h
08032828 7720     strb    r0,[r4,1Ch]
0803282A 82E0     strh    r0,[r4,16h]
0803282C E027     b       @@end
.pool

@@oamdown:
08032838 8AE0     ldrh    r0,[r4,16h]
0803283A 2802     cmp     r0,2h			;检查动画是否为2
0803283C D11F     bne     @@end		
0803283E 7F20     ldrb    r0,[r4,1Ch]
08032840 2804     cmp     r0,4h			;检查动画帧是否为4
08032842 D11C     bne     @@end
08032844 20BB     mov     r0,0BBh
08032846 0040     lsl     r0,r0,1h		;播放176h 374
08032848 F7D0F804 bl      8002854h
0803284C E017     b       @@end

@@nodamage:
0803284E 69A1     ldr     r1,[r4,18h]
08032850 480C     ldr     r0,=833E50Ch
08032852 4281     cmp     r1,r0			;检查oam是否是扑手?
08032854 D113     bne     @@end
08032856 8AE0     ldrh    r0,[r4,16h]
08032858 2802     cmp     r0,2h			;检查动画是否为2
0803285A D106     bne     @@noplaysound
0803285C 7F20     ldrb    r0,[r4,1Ch]
0803285E 2804     cmp     r0,4h			;检查动画是否为4
08032860 D103     bne     @@noplaysound
08032862 20BB     mov     r0,0BBh
08032864 0040     lsl     r0,r0,1h		;播放176h
08032866 F7CFFFF5 bl      8002854h

@@noplaysound:
0803286A F7DFF863 bl      8011934h
0803286E 2800     cmp     r0,0h
08032870 D005     beq     @@end			;检查动画结束
08032872 4805     ldr     r0,=30006BCh
08032874 4905     ldr     r1,=833E454h
08032876 6181     str     r1,[r0,18h]	;oam写入平常
08032878 2100     mov     r1,0h
0803287A 7701     strb    r1,[r0,1Ch]
0803287C 82C1     strh    r1,[r0,16h]

@@end:
0803287E BC10     pop     r4
08032880 BC01     pop     r0
08032882 4700     bx      r0
.pool
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

airPose29:
08032890 B510     push    r4,lr
08032892 4B16     ldr     r3,=30006BCh
08032894 1C19     mov     r1,r3
08032896 312E     add     r1,2Eh
08032898 2400     mov     r4,0h
0803289A 2010     mov     r0,10h
0803289C 7008     strb    r0,[r1]			;偏移2E写入10
0803289E 1C18     mov     r0,r3
080328A0 3031     add     r0,31h			;偏移31写入0
080328A2 7004     strb    r4,[r0]
080328A4 390A     sub     r1,0Ah			;偏移24
080328A6 202A     mov     r0,2Ah
080328A8 7008     strb    r0,[r1]			;pose写入2Ah
080328AA 4A11     ldr     r2,=3001244h
080328AC 2126     mov     r1,26h
080328AE 5E50     ldsh    r0,[r2,r1]		;读取人物的头顶判定
080328B0 0FC1     lsr     r1,r0,1Fh
080328B2 1840     add     r0,r0,r1
080328B4 1040     asr     r0,r0,1h			;获取人体中间高度?
080328B6 8B12     ldrh    r2,[r2,18h]		;读取人物的Y坐标
080328B8 1880     add     r0,r0,r2			;定位到中间值
080328BA 0400     lsl     r0,r0,10h
080328BC 0C00     lsr     r0,r0,10h
080328BE 8859     ldrh    r1,[r3,2h]		;读取敌人的Y坐标
080328C0 1A40     sub     r0,r0,r1			;人物中间高度减去敌人的Y坐标
080328C2 21B4     mov     r1,0B4h
080328C4 0049     lsl     r1,r1,1h
080328C6 4288     cmp     r0,r1				;高度差和168h比较,大概5格半高度
080328C8 DC03     bgt     @@than5.5			;高度差大于5格半
080328CA 480A     ldr     r0,=30007F0h
080328CC 7800     ldrb    r0,[r0]	
080328CE 280A     cmp     r0,0Ah			;随机数如果小于等于0Ah
080328D0 D916     bls     @@playsound

@@than5.5:
080328D2 4809     ldr     r0,=833E4A4h		;高度过大,则写入新的oam
080328D4 6198     str     r0,[r3,18h]		;应该是用尾巴刺的oam
080328D6 771C     strb    r4,[r3,1Ch]
080328D8 82DC     strh    r4,[r3,16h]
080328DA 1C19     mov     r1,r3
080328DC 3125     add     r1,25h
080328DE 2003     mov     r0,3h				;属性写入3h
080328E0 7008     strb    r0,[r1]
080328E2 4806     ldr     r0,=177h
080328E4 F7CFFFB6 bl      8002854h			;播放声音
080328E8 E00D     b       @@end
.pool

@@playsound:
08032900 4802     ldr     r0,=179h
08032902 F7CFFFA7 bl      8002854h

@@end:
08032906 BC10     pop     r4
08032908 BC01     pop     r0
0803290A 4700     bx      r0
///////////////////////////////////////////////////////////////////////

airPose2A:			;俯冲
08032910 B570     push    r4-r6,lr
08032912 F7FFFF75 bl      8032800h			;俯冲的声音和oam,非属性3的
08032916 4C10     ldr     r4,=30006BCh
08032918 8860     ldrh    r0,[r4,2h]
0803291A 3010     add     r0,10h			
0803291C 88A1     ldrh    r1,[r4,4h]
0803291E F7DEFD37 bl      8011390h			
08032922 480E     ldr     r0,=30007A5h
08032924 7800     ldrb    r0,[r0]
08032926 2811     cmp     r0,11h
08032928 D11A     bne     @@NoBlock
0803292A 2006     mov     r0,6h
0803292C F7FFFDEA bl      8032504h			;移动函数
08032930 0600     lsl     r0,r0,18h
08032932 2800     cmp     r0,0h
08032934 D003     beq     @@movesuccess
08032936 1C21     mov     r1,r4
08032938 3124     add     r1,24h
0803293A 202D     mov     r0,2Dh			;移动失败则pose改为2D
0803293C 7008     strb    r0,[r1]

@@movesuccess:
0803293E 1C21     mov     r1,r4
08032940 312E     add     r1,2Eh
08032942 7808     ldrb    r0,[r1]
08032944 3801     sub     r0,1h				;偏移2E-1再写入
08032946 7008     strb    r0,[r1]			;持续时间???
08032948 0600     lsl     r0,r0,18h
0803294A 2800     cmp     r0,0h
0803294C D14E     bne     @@end
0803294E 390A     sub     r1,0Ah
08032950 202D     mov     r0,2Dh			;持续时间终了则pose写入2Dh
08032952 7008     strb    r0,[r1]
08032954 E04A     b       @@end
.pool

@@NoBlock:
08032960 1C20     mov     r0,r4
08032962 3025     add     r0,25h
08032964 7800     ldrb    r0,[r0]
08032966 2803     cmp     r0,3h				;读取属性是否为3h
08032968 D106     bne     @@no3
0803296A 1C20     mov     r0,r4
0803296C 3031     add     r0,31h
0803296E 7800     ldrb    r0,[r0]			;读取偏移31  除以4是移动速度??
08032970 0880     lsr     r0,r0,2h			;除以4
08032972 2804     cmp     r0,4h				;比较是否小于或等于4
08032974 D907     bls     @@lessthan4or8
08032976 E005     b       @@bigthan4

@@no3:
08032978 1C20     mov     r0,r4
0803297A 3031     add     r0,31h
0803297C 7800     ldrb    r0,[r0]			;读取偏移31
0803297E 0840     lsr     r0,r0,1h			;除以2
08032980 2808     cmp     r0,8h				;比较是否小于或等于8
08032982 D900     bls     @@lessthan4or8

@@bigthan4:
08032984 2008     mov     r0,8h

@@lessthan4or8:
08032986 F7FFFDBD bl      8032504h			;移动例程
0803298A 4C07     ldr     r4,=30006BCh
0803298C 8860     ldrh    r0,[r4,2h]
0803298E 3080     add     r0,80h			;身下两格是否有砖
08032990 88A1     ldrh    r1,[r4,4h]
08032992 F7DEFCFD bl      8011390h
08032996 4805     ldr     r0,=30007A5h		;检查砖块
08032998 7800     ldrb    r0,[r0]
0803299A 2811     cmp     r0,11h
0803299C D108     bne     @@downNoBlock
0803299E 1C21     mov     r1,r4
080329A0 3124     add     r1,24h
080329A2 202B     mov     r0,2Bh			;头顶有砖块的话,则pose写入2b
080329A4 7008     strb    r0,[r1]
080329A6 E021     b       @@end
.pool

@@downNoblock:
080329B0 2031     mov     r0,31h
080329B2 1900     add     r0,r0,r4
080329B4 4684     mov     r12,r0
080329B6 7802     ldrb    r2,[r0]			;偏移31读取
080329B8 4D07     ldr     r5,=833C2DCh
080329BA 0050     lsl     r0,r2,1h
080329BC 1940     add     r0,r0,r5			;加上偏移数据
080329BE 8803     ldrh    r3,[r0]
080329C0 2600     mov     r6,0h
080329C2 5F81     ldsh    r1,[r0,r6]
080329C4 4805     ldr     r0,=7FFFh			;检查是否是末尾
080329C6 4281     cmp     r1,r0
080329C8 D10A     bne     @@ynoend
080329CA 1E51     sub     r1,r2,1			;减一
080329CC 0049     lsl     r1,r1,1h
080329CE 1949     add     r1,r1,r5
080329D0 8860     ldrh    r0,[r4,2h]
080329D2 8809     ldrh    r1,[r1]
080329D4 1840     add     r0,r0,r1			;数据相加再写入
080329D6 E008     b       @@writey
.pool

@@ynoend:
080329E0 1C50     add     r0,r2,1
080329E2 4661     mov     r1,r12
080329E4 7008     strb    r0,[r1]			;偏移31递增写入
080329E6 8860     ldrh    r0,[r4,2h]
080329E8 18C0     add     r0,r0,r3			;y值相加写入

@@writey:
080329EA 8060     strh    r0,[r4,2h]

@@end:
080329EC BC70     pop     r4-r6
080329EE BC01     pop     r0
080329F0 4700     bx      r0
/////////////////////////////////////////////////////////////////////////////

airPose2B:
080329F4 4A06     ldr     r2,=30006BCh
080329F6 1C13     mov     r3,r2
080329F8 332E     add     r3,2Eh
080329FA 2100     mov     r1,0h
080329FC 2014     mov     r0,14h
080329FE 7018     strb    r0,[r3]			;偏移2E写入14h
08032A00 1C10     mov     r0,r2
08032A02 3031     add     r0,31h
08032A04 7001     strb    r1,[r0]			;偏移31写入0
08032A06 1C11     mov     r1,r2
08032A08 3124     add     r1,24h
08032A0A 202C     mov     r0,2Ch			;pose写入2Ch
08032A0C 7008     strb    r0,[r1]
08032A0E 4770     bx      r14
.pool
////////////////////////////////////////////////////////////////////////

airPose2C:
08032A14 B5F0     push    r4-r7,lr
08032A16 F7FFFEF3 bl      8032800h			;俯冲的oam和声音,非属性3的
08032A1A 2008     mov     r0,8h
08032A1C F7FFFD72 bl      8032504h			;移动8h
08032A20 0600     lsl     r0,r0,18h
08032A22 0E05     lsr     r5,r0,18h
08032A24 4C0D     ldr     r4,=30006BCh
08032A26 8860     ldrh    r0,[r4,2h]
08032A28 3010     add     r0,10h
08032A2A 88A1     ldrh    r1,[r4,4h]
08032A2C F7DEFCB0 bl      8011390h			;检查身处的砖块
08032A30 4E0B     ldr     r6,=30007A5h
08032A32 7830     ldrb    r0,[r6]
08032A34 2811     cmp     r0,11h
08032A36 D115     bne     @@noblock
08032A38 2D00     cmp     r5,0h				;检查移动是否碰壁
08032A3A D003     beq     @@movesuccess
08032A3C 1C21     mov     r1,r4
08032A3E 3124     add     r1,24h
08032A40 202D     mov     r0,2Dh			;移动碰壁则pose写入2Dh
08032A42 7008     strb    r0,[r1]

@@movesuccess:
08032A44 1C21     mov     r1,r4
08032A46 312E     add     r1,2Eh
08032A48 7808     ldrb    r0,[r1]			;读取2Eh  转变pose的计时器
08032A4A 3801     sub     r0,1h				;递减写入
08032A4C 7008     strb    r0,[r1]
08032A4E 0600     lsl     r0,r0,18h
08032A50 2800     cmp     r0,0h
08032A52 D136     bne     @@end
08032A54 390A     sub     r1,0Ah
08032A56 202D     mov     r0,2Dh			;pose写入2dh
08032A58 E032     b       @@write
.pool

@@noblock:
08032A64 8860     ldrh    r0,[r4,2h]
08032A66 3080     add     r0,80h
08032A68 88A1     ldrh    r1,[r4,4h]
08032A6A F7DEFC91 bl      8011390h			;检查身下两格是否有砖
08032A6E 7830     ldrb    r0,[r6]
08032A70 2811     cmp     r0,11h
08032A72 D11D     bne     @@downNoBlock
08032A74 1C26     mov     r6,r4
08032A76 3631     add     r6,31h
08032A78 7832     ldrb    r2,[r6]			;读取偏移31h
08032A7A 4D08     ldr     r5,=833C2FCh
08032A7C 0050     lsl     r0,r2,1h			;乘以2
08032A7E 1940     add     r0,r0,r5			;加上数据偏移
08032A80 8803     ldrh    r3,[r0]
08032A82 2700     mov     r7,0h
08032A84 5FC1     ldsh    r1,[r0,r7]		;读取带符号位的
08032A86 4806     ldr     r0,=7FFFh			;检查是否是末尾
08032A88 4281     cmp     r1,r0
08032A8A D10B     bne     @@nolast
08032A8C 1E51     sub     r1,r2,1			;减1
08032A8E 0049     lsl     r1,r1,1h			;乘2
08032A90 1949     add     r1,r1,r5			;再加偏移数据
08032A92 8860     ldrh    r0,[r4,2h]		;y坐标
08032A94 8809     ldrh    r1,[r1]			;读取偏移速度
08032A96 1840     add     r0,r0,r1			;与y坐标相加
08032A98 8060     strh    r0,[r4,2h]		;写入
08032A9A E012     b       @@end
.pool

@@nolast:
08032AA4 1C50     add     r0,r2,1
08032AA6 7030     strb    r0,[r6]
08032AA8 8860     ldrh    r0,[r4,2h]
08032AAA 18C0     add     r0,r0,r3			;写入匹配的y坐标
08032AAC 8060     strh    r0,[r4,2h]
08032AAE E008     b       @@end

@@downnoblock:
08032AB0 1C21     mov     r1,r4
08032AB2 312E     add     r1,2Eh
08032AB4 2000     mov     r0,0h
08032AB6 7008     strb    r0,[r1]		;偏移2E写入0
08032AB8 3103     add     r1,3h
08032ABA 7008     strb    r0,[r1]		;偏移31写入0
08032ABC 390D     sub     r1,0Dh
08032ABE 202A     mov     r0,2Ah		;pose写入2dh

@@write:
08032AC0 7008     strb    r0,[r1]

@@end:
08032AC2 BCF0     pop     r4-r7
08032AC4 BC01     pop     r0
08032AC6 4700     bx      r0
/////////////////////////////////////////////////////////////////////////////////

airPose2D:
08032AC8 B500     push    lr
08032ACA 4A0B     ldr     r2,=30006BCh
08032ACC 1C10     mov     r0,r2
08032ACE 302E     add     r0,2Eh
08032AD0 2300     mov     r3,0h
08032AD2 7003     strb    r3,[r0]			;偏移2E写入0
08032AD4 3003     add     r0,3h
08032AD6 7003     strb    r3,[r0]			;偏移31归零
08032AD8 380D     sub     r0,0Dh
08032ADA 212E     mov     r1,2Eh
08032ADC 7001     strb    r1,[r0]			;pose写入2Eh
08032ADE 1C11     mov     r1,r2
08032AE0 3125     add     r1,25h
08032AE2 7808     ldrb    r0,[r1]
08032AE4 2803     cmp     r0,3h				;检查属性是否是3h
08032AE6 D105     bne     @@end
08032AE8 4804     ldr     r0,=833E454h		;针刺的oam收起
08032AEA 6190     str     r0,[r2,18h]
08032AEC 7713     strb    r3,[r2,1Ch]
08032AEE 82D3     strh    r3,[r2,16h]
08032AF0 2002     mov     r0,2h				;属性写回2
08032AF2 7008     strb    r0,[r1]

@@end:
08032AF4 BC01     pop     r0
08032AF6 4700     bx      r0
.pool
/////////////////////////////////////////////////////////////////////////////////////////

airPose2E:
08032B00 B5F0     push    r4-r7,lr
08032B02 464F     mov     r7,r9
08032B04 4646     mov     r6,r8
08032B06 B4C0     push    r6,r7
08032B08 2700     mov     r7,0h
08032B0A F7DEFF13 bl      8011934h			;检查动画结束
08032B0E 2800     cmp     r0,0h
08032B10 D008     beq     @@animationnoend
08032B12 4A1A     ldr     r2,=30006BCh
08032B14 6991     ldr     r1,[r2,18h]
08032B16 481A     ldr     r0,=833E50Ch		;检查oam
08032B18 4281     cmp     r1,r0
08032B1A D103     bne     @@animationnoend
08032B1C 4819     ldr     r0,=833E454h		;同的话写入新oam
08032B1E 6190     str     r0,[r2,18h]
08032B20 7717     strb    r7,[r2,1Ch]
08032B22 82D7     strh    r7,[r2,16h]

@@animationnoend:
08032B24 2006     mov     r0,6h
08032B26 F7FFFCED bl      8032504h			;速度6h
08032B2A 4C14     ldr     r4,=30006BCh
08032B2C 8860     ldrh    r0,[r4,2h]
08032B2E 3880     sub     r0,80h
08032B30 88A1     ldrh    r1,[r4,4h]
08032B32 F7DEFC2D bl      8011390h			;检查身上2格的砖块
08032B36 4814     ldr     r0,=30007A5h
08032B38 7800     ldrb    r0,[r0]
08032B3A 2811     cmp     r0,11h
08032B3C D05D     beq     @@Over2			;topnoblock
08032B3E 1C22     mov     r2,r4
08032B40 322E     add     r2,2Eh
08032B42 7811     ldrb    r1,[r2]			;读取偏移2e
08032B44 2900     cmp     r1,0h
08032B46 D132     bne     @@nozero2e
08032B48 8920     ldrh    r0,[r4,8h]
08032B4A 3040     add     r0,40h			;读取偏移8加40h
08032B4C 8865     ldrh    r5,[r4,2h]		;读取y
08032B4E 42A8     cmp     r0,r5				;偏移8下一格比较y
08032B50 DA27     bge     @@yOnoft8			;大于或等
08032B52 2031     mov     r0,31h
08032B54 1900     add     r0,r0,r4
08032B56 4684     mov     r12,r0
08032B58 7802     ldrb    r2,[r0]			;读取偏移31h
08032B5A 490C     ldr     r1,=833C30Ch
08032B5C 4688     mov     r8,r1
08032B5E 0050     lsl     r0,r2,1h
08032B60 4440     add     r0,r8
08032B62 8803     ldrh    r3,[r0]
08032B64 2600     mov     r6,0h
08032B66 5F81     ldsh    r1,[r0,r6]
08032B68 4809     ldr     r0,=7FFFh			;检查数据是否到了末尾
08032B6A 4281     cmp     r1,r0
08032B6C D112     bne     @@nolast
08032B6E 1E50     sub     r0,r2,1
08032B70 0040     lsl     r0,r0,1h			
08032B72 4440     add     r0,r8
08032B74 8803     ldrh    r3,[r0]
08032B76 18E8     add     r0,r5,r3
08032B78 8060     strh    r0,[r4,2h]		;写入新的y坐标
08032B7A E041     b       @@peer
.pool

@@nolast:
08032B94 1C50     add     r0,r2,1
08032B96 4661     mov     r1,r12
08032B98 7008     strb    r0,[r1]			;递增写入
08032B9A 8860     ldrh    r0,[r4,2h]
08032B9C 18C0     add     r0,r0,r3
08032B9E 8060     strh    r0,[r4,2h]		;写入新的y坐标
08032BA0 E02E     b       @@peer

@@yOnoft8:									;y高度在备份的偏移8高度的下一格之上
08032BA2 2001     mov     r0,1h
08032BA4 7010     strb    r0,[r2]			;偏移2E写入1
08032BA6 1C20     mov     r0,r4
08032BA8 3031     add     r0,31h
08032BAA 7001     strb    r1,[r0]			;偏移31写入0	
08032BAC E028     b       @@peer

@@nozero2e:
08032BAE 8863     ldrh    r3,[r4,2h]		;读取y
08032BB0 8920     ldrh    r0,[r4,8h]		;读取偏移8
08032BB2 469C     mov     r12,r3
08032BB4 4298     cmp     r0,r3
08032BB6 D220     bcs     @@Over2
08032BB8 2531     mov     r5,31h
08032BBA 192D     add     r5,r5,r4			
08032BBC 46A8     mov     r8,r5
08032BBE 782A     ldrb    r2,[r5]			;读取偏移31
08032BC0 4E08     ldr     r6,=833C324h
08032BC2 0050     lsl     r0,r2,1h
08032BC4 1980     add     r0,r0,r6
08032BC6 8801     ldrh    r1,[r0]
08032BC8 4689     mov     r9,r1
08032BCA 2500     mov     r5,0h
08032BCC 5F41     ldsh    r1,[r0,r5]		;检查数据是否到了末尾
08032BCE 4806     ldr     r0,=7FFFh
08032BD0 4281     cmp     r1,r0
08032BD2 D10B     bne     @@nolast2
08032BD4 1E50     sub     r0,r2,1
08032BD6 0040     lsl     r0,r0,1h
08032BD8 1980     add     r0,r0,r6
08032BDA 8800     ldrh    r0,[r0]
08032BDC 4460     add     r0,r12
08032BDE 8060     strh    r0,[r4,2h]		;写入新的y
08032BE0 E00E     b       @@peer
.pool

@@nolast2:
08032BEC 1C50     add     r0,r2,1
08032BEE 4646     mov     r6,r8
08032BF0 7030     strb    r0,[r6]
08032BF2 4649     mov     r1,r9
08032BF4 1858     add     r0,r3,r1
08032BF6 8060     strh    r0,[r4,2h]		;写入新的y
08032BF8 E002     b       @@peer

@@Over2:
08032BFA 1C78     add     r0,r7,1			;头部无砖flag
08032BFC 0600     lsl     r0,r0,18h
08032BFE 0E07     lsr     r7,r0,18h

@@peer:
08032C00 2F00     cmp     r7,0h
08032C02 D027     beq     @@end
08032C04 4A09     ldr     r2,=30006BCh
08032C06 1C11     mov     r1,r2
08032C08 3125     add     r1,25h
08032C0A 2002     mov     r0,2h
08032C0C 7008     strb    r0,[r1]			;属性写入2
08032C0E 8811     ldrh    r1,[r2]
08032C10 2040     mov     r0,40h
08032C12 4008     and     r0,r1
08032C14 2800     cmp     r0,0h				;检查面向
08032C16 D00D     beq     @@faceLeft
08032C18 4905     ldr     r1,=3001244h
08032C1A 8890     ldrh    r0,[r2,4h]
08032C1C 8AC9     ldrh    r1,[r1,16h]		;读取敌人和人物的x
08032C1E 4288     cmp     r0,r1				;敌人如果面右在左
08032C20 D914     bls     @@re1
08032C22 1C11     mov     r1,r2				;敌人面右在右
08032C24 3124     add     r1,24h
08032C26 2003     mov     r0,3h				;pose写入3 碰壁转身..
08032C28 E013     b       @@writepose
.pool

@@faceLeft:
08032C34 4904     ldr     r1,=3001244h
08032C36 8890     ldrh    r0,[r2,4h]		;敌x
08032C38 8AC9     ldrh    r1,[r1,16h]		;人x
08032C3A 4288     cmp     r0,r1				;敌面左在右
08032C3C D206     bcs     @@re1
08032C3E 1C11     mov     r1,r2				;敌面左在左
08032C40 3124     add     r1,24h
08032C42 2003     mov     r0,3h				;pose写入转身
08032C44 E005     b       @@writepose
.pool

@@re1:
08032C4C 1C11     mov     r1,r2
08032C4E 3124     add     r1,24h
08032C50 2001     mov     r0,1h				;pose写入1

@@writePose:
08032C52 7008     strb    r0,[r1]

@@end:
08032C54 BC18     pop     r3,r4
08032C56 4698     mov     r8,r3
08032C58 46A1     mov     r9,r4
08032C5A BCF0     pop     r4-r7
08032C5C BC01     pop     r0
08032C5E 4700     bx      r0
//////////////////////////////////////////////////////////////////////////////////

kihunterwingPose0:
08032C60 B510     push    r4,lr
08032C62 481E     ldr     r0,=30006BCh
08032C64 4684     mov     r12,r0
08032C66 3023     add     r0,23h
08032C68 7801     ldrb    r1,[r0]				;读取主序号
08032C6A 4A1D     ldr     r2,=3000140h
08032C6C 00C8     lsl     r0,r1,3h
08032C6E 1A40     sub     r0,r0,r1
08032C70 00C0     lsl     r0,r0,3h
08032C72 1880     add     r0,r0,r2
08032C74 8801     ldrh    r1,[r0]				;读取主精灵的取向
08032C76 2020     mov     r0,20h			
08032C78 4008     and     r0,r1					;检查马赛克flag?
08032C7A 2800     cmp     r0,0h
08032C7C D004     beq     @@no20
08032C7E 4664     mov     r4,r12
08032C80 8821     ldrh    r1,[r4]
08032C82 2020     mov     r0,20h
08032C84 4308     orr     r0,r1					;同样也加上如此的标记
08032C86 8020     strh    r0,[r4]

@@no20:
08032C88 4660     mov     r0,r12
08032C8A 8801     ldrh    r1,[r0]				;读取取向
08032C8C 4815     ldr     r0,=0FFFBh
08032C8E 4008     and     r0,r1					;去掉隐形flag
08032C90 2200     mov     r2,0h
08032C92 2300     mov     r3,0h
08032C94 4661     mov     r1,r12
08032C96 8008     strh    r0,[r1]				;写入取向
08032C98 4660     mov     r0,r12
08032C9A 3025     add     r0,25h				;属性写入0
08032C9C 7002     strb    r2,[r0]
08032C9E 3127     add     r1,27h
08032CA0 2028     mov     r0,28h
08032CA2 7008     strb    r0,[r1]				;上视界写入28h
08032CA4 3101     add     r1,1h
08032CA6 2008     mov     r0,8h
08032CA8 7008     strb    r0,[r1]				;下视界写入8h
08032CAA 3101     add     r1,1h
08032CAC 2018     mov     r0,18h				;左右视界写入18h
08032CAE 7008     strb    r0,[r1]
08032CB0 490D     ldr     r1,=0FFFCh
08032CB2 4664     mov     r4,r12
08032CB4 8161     strh    r1,[r4,0Ah]			;上分界写入FFFCh
08032CB6 2004     mov     r0,4h
08032CB8 81A0     strh    r0,[r4,0Ch]			;下分界写入4h
08032CBA 81E1     strh    r1,[r4,0Eh]			;左分界写入FFFCh
08032CBC 8220     strh    r0,[r4,10h]			;右分界写入4h
08032CBE 4661     mov     r1,r12
08032CC0 3124     add     r1,24h
08032CC2 2002     mov     r0,2h
08032CC4 7008     strb    r0,[r1]				;pose写入2h
08032CC6 3902     sub     r1,2h
08032CC8 2003     mov     r0,3h					;绘图顺序写入3h
08032CCA 7008     strb    r0,[r1]				
08032CCC 4807     ldr     r0,=833E474h
08032CCE 61A0     str     r0,[r4,18h]			;写入oam
08032CD0 7722     strb    r2,[r4,1Ch]
08032CD2 82E3     strh    r3,[r4,16h]
08032CD4 BC10     pop     r4
08032CD6 BC01     pop     r0
08032CD8 4700     bx      r0
.pool
//////////////////////////////////////////////////////////////////////////////

kihunterwingPose2:			;常态
08032CF0 B530     push    r4,r5,lr
08032CF2 4B0D     ldr     r3,=30006BCh
08032CF4 1C18     mov     r0,r3
08032CF6 3023     add     r0,23h
08032CF8 7804     ldrb    r4,[r0]				;读取主精灵序号
08032CFA 490C     ldr     r1,=3000140h
08032CFC 00E0     lsl     r0,r4,3h
08032CFE 1B00     sub     r0,r0,r4
08032D00 00C0     lsl     r0,r0,3h
08032D02 1842     add     r2,r0,r1				;找到地址
08032D04 8850     ldrh    r0,[r2,2h]
08032D06 8058     strh    r0,[r3,2h]			;读取主精灵坐标写入坐标
08032D08 8890     ldrh    r0,[r2,4h]
08032D0A 8098     strh    r0,[r3,4h]			
08032D0C 1C10     mov     r0,r2
08032D0E 3024     add     r0,24h
08032D10 7800     ldrb    r0,[r0]				;读取pose
08032D12 3857     sub     r0,57h
08032D14 0600     lsl     r0,r0,18h
08032D16 0E00     lsr     r0,r0,18h
08032D18 1C0D     mov     r5,r1
08032D1A 2801     cmp     r0,1h
08032D1C D808     bhi     @@than58
08032D1E F02EFCCF bl      80616C0h
08032D22 F02EFCE3 bl      80616ECh
08032D26 E048     b       @@end
.pool

@@than58:
08032D30 8811     ldrh    r1,[r2]
08032D32 2020     mov     r0,20h
08032D34 4008     and     r0,r1					;读取主精灵取向检查马赛克flag
08032D36 2800     cmp     r0,0h
08032D38 D003     beq     @@no20
08032D3A 8818     ldrh    r0,[r3]
08032D3C 2120     mov     r1,20h				;有的话也orr
08032D3E 4308     orr     r0,r1
08032D40 E002     b       @@write

@@no20:
08032D42 8819     ldrh    r1,[r3]
08032D44 4807     ldr     r0,=0FFDFh			;没有的话去除flag
08032D46 4008     and     r0,r1

@@write:
08032D48 8018     strh    r0,[r3]
08032D4A 00E2     lsl     r2,r4,3h
08032D4C 1B10     sub     r0,r2,r4
08032D4E 00C0     lsl     r0,r0,3h
08032D50 1940     add     r0,r0,r5
08032D52 8801     ldrh    r1,[r0]				;读取主精灵取向
08032D54 2040     mov     r0,40h
08032D56 4008     and     r0,r1					;检查面向
08032D58 2800     cmp     r0,0h
08032D5A D005     beq     @@faceLeft
08032D5C 8819     ldrh    r1,[r3]
08032D5E 2040     mov     r0,40h				;面向纠正
08032D60 4308     orr     r0,r1
08032D62 E004     b       @@writedirection
.pool

@@faceLeft:
08032D68 8819     ldrh    r1,[r3]
08032D6A 4810     ldr     r0,=0FFBFh			;面向纠正
08032D6C 4008     and     r0,r1

@@writedirection:
08032D6E 8018     strh    r0,[r3]
08032D70 1B10     sub     r0,r2,r4
08032D72 00C0     lsl     r0,r0,3h
08032D74 1940     add     r0,r0,r5
08032D76 8A80     ldrh    r0,[r0,14h]			;读取主精灵的血量
08032D78 2806     cmp     r0,6h					;血量是否到了没有翅膀的时候
08032D7A D81E     bhi     @@end
08032D7C 1C19     mov     r1,r3					;掉翅膀
08032D7E 3124     add     r1,24h
08032D80 2200     mov     r2,0h
08032D82 2038     mov     r0,38h
08032D84 7008     strb    r0,[r1]				;pose写入38h
08032D86 480A     ldr     r0,=833E4C4h
08032D88 6198     str     r0,[r3,18h]			;写入翅膀飘落oam
08032D8A 771A     strb    r2,[r3,1Ch]
08032D8C 2100     mov     r1,0h
08032D8E 82DA     strh    r2,[r3,16h]
08032D90 1C18     mov     r0,r3
08032D92 3020     add     r0,20h
08032D94 7001     strb    r1,[r0]				;调色板号写入0??
08032D96 8858     ldrh    r0,[r3,2h]
08032D98 3860     sub     r0,60h				;x坐标向上提升一格半
08032D9A 8058     strh    r0,[r3,2h]			;再写入
08032D9C 8819     ldrh    r1,[r3]
08032D9E 2040     mov     r0,40h
08032DA0 4008     and     r0,r1
08032DA2 2800     cmp     r0,0h					;检查检查面向
08032DA4 D006     beq     @@faceLeft2
08032DA6 8898     ldrh    r0,[r3,4h]
08032DA8 3820     sub     r0,20h				;面右则x向左半格
08032DAA E005     b       @@writex
.pool

@@faceLeft2:
08032DB4 8898     ldrh    r0,[r3,4h]
08032DB6 3020     add     r0,20h				;面左则x向右半格

@@writex:
08032DB8 8098     strh    r0,[r3,4h]

@@end:
08032DBA BC30     pop     r4,r5
08032DBC BC01     pop     r0
08032DBE 4700     bx      r0
///////////////////////////////////////////////////////////////////////

kihunterwingPose38:
08032DC0 B510     push    r4,lr
08032DC2 4C09     ldr     r4,=30006BCh
08032DC4 8860     ldrh    r0,[r4,2h]
08032DC6 88A1     ldrh    r1,[r4,4h]			;读取坐标
08032DC8 F7DEF9D4 bl      8011174h				;检查地面
08032DCC 1C01     mov     r1,r0
08032DCE 4807     ldr     r0,=30007A4h
08032DD0 7800     ldrb    r0,[r0]
08032DD2 2800     cmp     r0,0h
08032DD4 D00C     beq     @@Noonfloor
08032DD6 8061     strh    r1,[r4,2h]			;写入地面的高度
08032DD8 1C21     mov     r1,r4
08032DDA 3124     add     r1,24h
08032DDC 203A     mov     r0,3Ah				;pose写入3ah
08032DDE 7008     strb    r0,[r1]
08032DE0 310A     add     r1,0Ah
08032DE2 2028     mov     r0,28h
08032DE4 7008     strb    r0,[r1]				;偏移2E写入28h
08032DE6 E006     b       @@end
.pool

@@Noonfloor:
08032DF0 8860     ldrh    r0,[r4,2h]
08032DF2 3002     add     r0,2h					;坐标继续下降
08032DF4 8060     strh    r0,[r4,2h]

@@end:
08032DF6 BC10     pop     r4
08032DF8 BC01     pop     r0
08032DFA 4700     bx      r0
/////////////////////////////////////////////////////////////////////

kihunterwingPose3a:
08032DFC B500     push    lr
08032DFE 480B     ldr     r0,=3000BE5h			;8bit数
08032E00 7801     ldrb    r1,[r0]
08032E02 2003     mov     r0,3h
08032E04 4008     and     r0,r1					;与3and
08032E06 4A0A     ldr     r2,=30006BCh
08032E08 2800     cmp     r0,0h
08032E0A D103     bne     @@have3
08032E0C 8810     ldrh    r0,[r2]
08032E0E 2104     mov     r1,4h
08032E10 4048     eor     r0,r1					;隐身和不隐身之间切换
08032E12 8010     strh    r0,[r2]

@@have3:
08032E14 1C11     mov     r1,r2
08032E16 312E     add     r1,2Eh
08032E18 7808     ldrb    r0,[r1]				;读取偏移2E
08032E1A 3801     sub     r0,1h					;递减再写入
08032E1C 7008     strb    r0,[r1]
08032E1E 0600     lsl     r0,r0,18h
08032E20 0E00     lsr     r0,r0,18h
08032E22 2800     cmp     r0,0h
08032E24 D100     bne     @@end
08032E26 8010     strh    r0,[r2]				;时辰到则死亡

@@end:
08032E28 BC01     pop     r0
08032E2A 4700     bx      r0
.pool
////////////////////////////////////////////////////////////////////////////

kihunterspitpose0:
08032E34 B510     push    r4,lr
08032E36 4817     ldr     r0,=30006BCh
08032E38 4684     mov     r12,r0
08032E3A 8801     ldrh    r1,[r0]
08032E3C 4816     ldr     r0,=0FFFBh
08032E3E 4008     and     r0,r1
08032E40 2300     mov     r3,0h
08032E42 2400     mov     r4,0h
08032E44 4661     mov     r1,r12
08032E46 8008     strh    r0,[r1]				;去除隐形效果
08032E48 4662     mov     r2,r12
08032E4A 3234     add     r2,34h
08032E4C 7811     ldrb    r1,[r2]					
08032E4E 2004     mov     r0,4h
08032E50 4308     orr     r0,r1					;碰撞属性orr4
08032E52 7010     strb    r0,[r2]				;再写入
08032E54 4660     mov     r0,r12
08032E56 3027     add     r0,27h
08032E58 2108     mov     r1,8h
08032E5A 7001     strb    r1,[r0]				;上视界写入8h
08032E5C 3001     add     r0,1h
08032E5E 7001     strb    r1,[r0]				;下世界写入8
08032E60 3001     add     r0,1h
08032E62 7001     strb    r1,[r0]				;左右视界写入8
08032E64 480D     ldr     r0,=0FFF8h
08032E66 4662     mov     r2,r12
08032E68 8150     strh    r0,[r2,0Ah]			;上分界写入0FFF8h
08032E6A 8191     strh    r1,[r2,0Ch]			;下分界写入8h
08032E6C 81D0     strh    r0,[r2,0Eh]			;左分界写入0FFF8h
08032E6E 8211     strh    r1,[r2,10h]			;右分界写入8h
08032E70 480B     ldr     r0,=833E64Ch
08032E72 6190     str     r0,[r2,18h]			;写入oam
08032E74 7713     strb    r3,[r2,1Ch]
08032E76 82D4     strh    r4,[r2,16h]
08032E78 4660     mov     r0,r12
08032E7A 3031     add     r0,31h
08032E7C 7003     strb    r3,[r0]				;偏移31写入0
08032E7E 4661     mov     r1,r12
08032E80 3124     add     r1,24h
08032E82 2002     mov     r0,2h					;pose写入2h
08032E84 7008     strb    r0,[r1]
08032E86 3101     add     r1,1h
08032E88 2004     mov     r0,4h					;属性写入4h
08032E8A 7008     strb    r0,[r1]
08032E8C BC10     pop     r4
08032E8E BC01     pop     r0
08032E90 4700     bx      r0
.pool

kihunterspitpose2:
08032EA4 B570     push    r4-r6,lr
08032EA6 4C08     ldr     r4,=30006BCh
08032EA8 8860     ldrh    r0,[r4,2h]
08032EAA 88A1     ldrh    r1,[r4,4h]			;检查落地
08032EAC F7DEF962 bl      8011174h
08032EB0 1C01     mov     r1,r0
08032EB2 4806     ldr     r0,=30007A4h
08032EB4 7800     ldrb    r0,[r0]
08032EB6 2800     cmp     r0,0h
08032EB8 D00A     beq     @@noOnfloor
08032EBA 8061     strh    r1,[r4,2h]			;地面高度写入
08032EBC 1C21     mov     r1,r4
08032EBE 3124     add     r1,24h
08032EC0 2037     mov     r0,37h				;pose写入37h
08032EC2 7008     strb    r0,[r1]
08032EC4 E031     b       @@end
.pool

@@noOnfloor:
08032ED0 2031     mov     r0,31h
08032ED2 1900     add     r0,r0,r4
08032ED4 4684     mov     r12,r0
08032ED6 7802     ldrb    r2,[r0]				;读取偏移31
08032ED8 4D07     ldr     r5,=833C228h
08032EDA 0050     lsl     r0,r2,1h				;乘以2
08032EDC 1940     add     r0,r0,r5				;加上轨迹值
08032EDE 8803     ldrh    r3,[r0]
08032EE0 2600     mov     r6,0h
08032EE2 5F81     ldsh    r1,[r0,r6]
08032EE4 4805     ldr     r0,=7FFFh				;检查是否到了末尾
08032EE6 4281     cmp     r1,r0
08032EE8 D10A     bne     @@nolast
08032EEA 1E51     sub     r1,r2,1
08032EEC 0049     lsl     r1,r1,1h
08032EEE 1949     add     r1,r1,r5
08032EF0 8860     ldrh    r0,[r4,2h]			;前高度写入
08032EF2 8809     ldrh    r1,[r1]
08032EF4 1840     add     r0,r0,r1
08032EF6 E008     b       @@writey
.pool

@@nolast:
08032F00 1C50     add     r0,r2,1
08032F02 4661     mov     r1,r12
08032F04 7008     strb    r0,[r1]
08032F06 8860     ldrh    r0,[r4,2h]
08032F08 18C0     add     r0,r0,r3

@@writey:
08032F0A 8060     strh    r0,[r4,2h]
08032F0C 4A04     ldr     r2,=30006BCh
08032F0E 8811     ldrh    r1,[r2]
08032F10 2040     mov     r0,40h
08032F12 4008     and     r0,r1
08032F14 2800     cmp     r0,0h					;读取面向
08032F16 D005     beq     @@faceLeft
08032F18 8890     ldrh    r0,[r2,4h]
08032F1A 300C     add     r0,0Ch				;向右速度
08032F1C E004     b       @@writex
.pool

@@faceLeft:
08032F24 8890     ldrh    r0,[r2,4h]
08032F26 380C     sub     r0,0Ch				;向左速度

@@writex:
08032F28 8090     strh    r0,[r2,4h]

@@end:
08032F2A BC70     pop     r4-r6
08032F2C BC01     pop     r0
08032F2E 4700     bx      r0

///////////////////////////////////////////////////////////////////////////////

kihunterspitpose37:				;落地了
08032F30 4B06     ldr     r3,=30006BCh
08032F32 1C1A     mov     r2,r3
08032F34 3224     add     r2,24h
08032F36 2100     mov     r1,0h
08032F38 2038     mov     r0,38h
08032F3A 7010     strb    r0,[r2]					;pose写入38h
08032F3C 1C18     mov     r0,r3
08032F3E 3025     add     r0,25h
08032F40 7001     strb    r1,[r0]					;属性写入0
08032F42 4803     ldr     r0,=833E664h				;落地的oam
08032F44 6198     str     r0,[r3,18h]
08032F46 7719     strb    r1,[r3,1Ch]
08032F48 82D9     strh    r1,[r3,16h]
08032F4A 4770     bx      r14
.pool

kihunterspitpose38:
08032F54 B510     push    r4,lr
08032F56 4C07     ldr     r4,=30006BCh
08032F58 1C21     mov     r1,r4
08032F5A 3126     add     r1,26h					;判定消失
08032F5C 2001     mov     r0,1h
08032F5E 7008     strb    r0,[r1]
08032F60 F7DEFCE8 bl      8011934h					;检查动画结束
08032F64 2800     cmp     r0,0h
08032F66 D001     beq     @@end
08032F68 2000     mov     r0,0h
08032F6A 8020     strh    r0,[r4]					;kill

@@end:
08032F6C BC10     pop     r4
08032F6E BC01     pop     r0
08032F70 4700     bx      r0
