08060B7C>B5F0     push    r4-r7,lr
08060B7E 464F     mov     r7,r9
08060B80 4646     mov     r6,r8
08060B82 B4C0     push    r6,r7
08060B84 B081     add     sp,-4h
08060B86 4805     ldr     r0,=8060B15h
08060B88 F79FFFAC bl      8000AE4h
08060B8C 4D04     ldr     r5,=3000038h
08060B8E 78E8     ldrb    r0,[r5,3h]		;读取300003b
08060B90 21F0     mov     r1,0F0h
08060B92 4001     and     r1,r0
08060B94 2900     cmp     r1,0h				;检查高位是否为0
08060B96 D005     beq     @@HighZero
08060B98 782F     ldrb    r7,[r5]			;高位不为0则检查当前的demo号
08060B9A E00B     b       @@Pass
.pool

@@HighZero:
08060BA4 7828     ldrb    r0,[r5]
08060BA6 280F     cmp     r0,0Fh			;检查demo号是否小于等于0xF
08060BA8 D900     bls     @@NoReturn		
08060BAA 7029     strb    r1,[r5]			;大于则重新从0开始

@@NoReturn:
08060BAC 4917     ldr     r1,=8363CE8h
08060BAE 7828     ldrb    r0,[r5]			;读取demo号
08060BB0 1840     add     r0,r0,r1			;加上偏移地址
08060BB2 7807     ldrb    r7,[r0]			;读取demo号

@@Pass:
08060BB4 2001     mov     r0,1h
08060BB6 F014FE49 bl      807584Ch			;似乎是初始化一些内存数据
08060BBA 2000     mov     r0,0h
08060BBC 1C39     mov     r1,r7
08060BBE F014FBD1 bl      8075364h
08060BC2 4813     ldr     r0,=30013D2h
08060BC4 4681     mov     r9,r0
08060BC6 7800     ldrb    r0,[r0]			;读取demo状态
08060BC8 2803     cmp     r0,3h
08060BCA D118     bne     @@UnSwitch
08060BCC 4C11     ldr     r4,=8363BE8h
08060BCE 013D     lsl     r5,r7,4h
08060BD0 192E     add     r6,r5,r4
08060BD2 6831     ldr     r1,[r6]			;读取地址
08060BD4 4A10     ldr     r2,=3004FCAh
08060BD6 88B3     ldrh    r3,[r6,4h]		;读取长度
08060BD8 2010     mov     r0,10h
08060BDA 4680     mov     r8,r0
08060BDC 9000     str     r0,[sp]
08060BDE 2003     mov     r0,3h
08060BE0 F7A2FB00 bl      80031E4h
08060BE4 3408     add     r4,8h
08060BE6 192D     add     r5,r5,r4
08060BE8 6829     ldr     r1,[r5]			;读取地址
08060BEA 4A0C     ldr     r2,=30051CAh
08060BEC 89B3     ldrh    r3,[r6,0Ch]		;读取长度
08060BEE 4640     mov     r0,r8				
08060BF0 9000     str     r0,[sp]
08060BF2 2003     mov     r0,3h
08060BF4 F7A2FAF6 bl      80031E4h
08060BF8 2002     mov     r0,2h
08060BFA 4649     mov     r1,r9
08060BFC 7008     strb    r0,[r1]			;非切换写入

@@UnSwitch:
08060BFE 2F07     cmp     r7,7h				;检查Demo是否是7
08060C00 D020     beq     @@D7
08060C02 2F07     cmp     r7,7h
08060C04 DC0C     bgt     @@thanD7
08060C06 2F06     cmp     r7,6h
08060C08 D00F     beq     @@D6
08060C0A E02C     b       @@Peer
.pool

@@thanD7:
08060C20 2F0A     cmp     r7,0Ah
08060C22 D018     beq     @@DA
08060C24 2F0B     cmp     r7,0Bh
08060C26 D01B     beq     @@DB
08060C28 E01D     b       @@Peer

@@D6:
08060C2A 2001     mov     r0,1h
08060C2C 212E     mov     r1,2Eh		;吊索开启
08060C2E F7FFFE45 bl      80608BCh
08060C32 2001     mov     r0,1h
08060C34 2116     mov     r1,16h		;太空跳事件
08060C36 F7FFFE41 bl      80608BCh
08060C3A 2001     mov     r0,1h
08060C3C 211E     mov     r1,1Eh		;克雷的死
08060C3E F7FFFE3D bl      80608BCh
08060C42 E010     b       @@Peer

@@D7:
08060C44 2001     mov     r0,1h			;写入事件
08060C46 211E     mov     r1,1Eh		;克雷德死
08060C48 F7FFFE38 bl      80608BCh
08060C4C 2001     mov     r0,1h
08060C4E 2110     mov     r1,10h		;爪子能力事件
08060C50 F7FFFE34 bl      80608BCh
08060C54 E007     b       @@Peer

@@DA:
08060C56 2001     mov     r0,1h
08060C58 212E     mov     r1,2Eh		;吊索开启
08060C5A F7FFFE2F bl      80608BCh
08060C5E E002     b       @@Peer

@@DB:
08060C60 4910     ldr     r1,=203383Ch
08060C62 2001     mov     r0,1h
08060C64 6008     str     r0,[r1]

@@Peer:
08060C66 4810     ldr     r0,=30053CAh
08060C68 2400     mov     r4,0h
08060C6A 8004     strh    r4,[r0]
08060C6C 4A0F     ldr     r2,=3000038h
08060C6E 7891     ldrb    r1,[r2,2h]
08060C70 200F     mov     r0,0Fh
08060C72 4008     and     r0,r1
08060C74 2110     mov     r1,10h
08060C76 4308     orr     r0,r1
08060C78 7090     strb    r0,[r2,2h]
08060C7A 2300     mov     r3,0h
08060C7C 2001     mov     r0,1h
08060C7E 7050     strb    r0,[r2,1h]
08060C80 78D1     ldrb    r1,[r2,3h]
08060C82 3811     sub     r0,11h
08060C84 4008     and     r0,r1
08060C86 70D0     strb    r0,[r2,3h]
08060C88 4809     ldr     r0,=3000C77h
08060C8A 7004     strb    r4,[r0]
08060C8C 4809     ldr     r0,=3000002h
08060C8E 8003     strh    r3,[r0]
08060C90 4809     ldr     r0,=8060B15h
08060C92 F79FFF27 bl      8000AE4h
08060C96 B001     add     sp,4h
08060C98 BC18     pop     r3,r4
08060C9A 4698     mov     r8,r3
08060C9C 46A1     mov     r9,r4
08060C9E BCF0     pop     r4-r7
08060CA0 BC01     pop     r0
08060CA2 4700     bx      r0

;demo状态信息写入
08075364 B570     push    r4-r6,lr
08075366 B081     add     sp,-4h
08075368 0600     lsl     r0,r0,18h			;0
0807536A 0E02     lsr     r2,r0,18h
0807536C 0609     lsl     r1,r1,18h			;demo号
0807536E 4816     ldr     r0,=875FDFCh
08075370 0D89     lsr     r1,r1,16h
08075372 1809     add     r1,r1,r0
08075374 680E     ldr     r6,[r1]			;读取地址
08075376 2A00     cmp     r2,0h
08075378 D132     bne     @@r1No0
0807537A 4C14     ldr     r4,=3000054h		;区号
0807537C 7830     ldrb    r0,[r6]
0807537E 7020     strb    r0,[r4]
08075380 4913     ldr     r1,=3000056h		;门号
08075382 7870     ldrb    r0,[r6,1h]
08075384 7008     strb    r0,[r1]
08075386 4913     ldr     r1,=300002Dh		;母舰门flag
08075388 2290     mov     r2,90h
0807538A 0092     lsl     r2,r2,2h
0807538C 18B0     add     r0,r6,r2
0807538E 7800     ldrb    r0,[r0]
08075390 7008     strb    r0,[r1]
08075392 23CC     mov     r3,0CCh
08075394 005B     lsl     r3,r3,1h
08075396 18F1     add     r1,r6,r3
08075398 7822     ldrb    r2,[r4]
0807539A 01D2     lsl     r2,r2,7h
0807539C 480E     ldr     r0,=2037400h
0807539E 1812     add     r2,r2,r0
080753A0 2510     mov     r5,10h
080753A2 9500     str     r5,[sp]
080753A4 2003     mov     r0,3h
080753A6 2380     mov     r3,80h
080753A8 F78DFF1C bl      80031E4h
080753AC 2286     mov     r2,86h
080753AE 0092     lsl     r2,r2,2h
080753B0 18B1     add     r1,r6,r2
080753B2 7822     ldrb    r2,[r4]
080753B4 0152     lsl     r2,r2,5h
080753B6 4B09     ldr     r3,=2037C00h
080753B8 18D2     add     r2,r2,r3
080753BA 9500     str     r5,[sp]
080753BC 2003     mov     r0,3h
080753BE 2320     mov     r3,20h
080753C0 F78DFF10 bl      80031E4h
080753C4 E054     b       @@end
.pool

@@r1No0:
080753E0 2A01     cmp     r2,1h
080753E2 D145     bne     @@end
080753E4 4924     ldr     r1,=30013D4h
080753E6 1D30     add     r0,r6,4
080753E8 C81C     ldmia   [r0]!,r2-r4
080753EA C11C     stmia   [r1]!,r2-r4
080753EC C81C     ldmia   [r0]!,r2-r4
080753EE C11C     stmia   [r1]!,r2-r4
080753F0 C814     ldmia   [r0]!,r2,r4
080753F2 C114     stmia   [r1]!,r2,r4
080753F4 4A21     ldr     r2,=3001414h
080753F6 6A70     ldr     r0,[r6,24h]
080753F8 6AB1     ldr     r1,[r6,28h]
080753FA 6010     str     r0,[r2]
080753FC 6051     str     r1,[r2,4h]
080753FE 4820     ldr     r0,=300141Ch
08075400 1C31     mov     r1,r6
08075402 312C     add     r1,2Ch
08075404 2286     mov     r2,86h
08075406 0052     lsl     r2,r2,1h
08075408 F017F958 bl      808C6BCh
0807540C 4A1D     ldr     r2,=3001528h
0807540E 239C     mov     r3,09Ch
08075410 005B     lsl     r3,r3,1h
08075412 18F0     add     r0,r6,r3
08075414 6841     ldr     r1,[r0,4h]
08075416 6800     ldr     r0,[r0]
08075418 6010     str     r0,[r2]
0807541A 6051     str     r1,[r2,4h]
0807541C 491A     ldr     r1,=3001530h
0807541E 24A0     mov     r4,0A0h
08075420 0064     lsl     r4,r4,1h
08075422 1930     add     r0,r6,r4
08075424 C81C     ldmia   [r0]!,r2-r4
08075426 C11C     stmia   [r1]!,r2-r4
08075428 C80C     ldmia   [r0]!,r2,r3
0807542A C10C     stmia   [r1]!,r2,r3
0807542C 4A17     ldr     r2,=3001544h
0807542E 24AA     mov     r4,0AAh
08075430 0064     lsl     r4,r4,1h
08075432 1930     add     r0,r6,r4
08075434 6841     ldr     r1,[r0,4h]
08075436 6800     ldr     r0,[r0]
08075438 6010     str     r0,[r2]
0807543A 6051     str     r1,[r2,4h]
0807543C 4814     ldr     r0,=300154Ch
0807543E 22AE     mov     r2,0AEh
08075440 0052     lsl     r2,r2,1h
08075442 18B1     add     r1,r6,r2
08075444 C91C     ldmia   [r1]!,r2-r4
08075446 C01C     stmia   [r0]!,r2-r4
08075448 23B4     mov     r3,0B4h
0807544A 005B     lsl     r3,r3,1h
0807544C 18F1     add     r1,r6,r3
0807544E C91C     ldmia   [r1]!,r2-r4
08075450 C01C     stmia   [r0]!,r2-r4
08075452 24BA     mov     r4,0BAh
08075454 0064     lsl     r4,r4,1h
08075456 1931     add     r1,r6,r4
08075458 C91C     ldmia   [r1]!,r2-r4
0807545A C01C     stmia   [r0]!,r2-r4
0807545C 22C0     mov     r2,0C0h
0807545E 0052     lsl     r2,r2,1h
08075460 18B1     add     r1,r6,r2
08075462 C91C     ldmia   [r1]!,r2-r4
08075464 C01C     stmia   [r0]!,r2-r4
08075466 23C6     mov     r3,0C6h
08075468 005B     lsl     r3,r3,1h
0807546A 18F1     add     r1,r6,r3
0807546C C91C     ldmia   [r1]!,r2-r4
0807546E C01C     stmia   [r0]!,r2-r4

@@end:
08075470 B001     add     sp,4h
08075472 BC70     pop     r4-r6
08075474 BC01     pop     r0
08075476 4700     bx      r0



;似乎是初始化一些东东
0807584C>B5F0     push    r4-r7,lr
0807584E 0600     lsl     r0,r0,18h
08075850 0E04     lsr     r4,r0,18h
08075852 4A0B     ldr     r2,=300168Ch		;按键号内存存储处
08075854 480B     ldr     r0,=8411510h		;按键号约定数据
08075856 6841     ldr     r1,[r0,4h]
08075858 6800     ldr     r0,[r0]
0807585A 6010     str     r0,[r2]
0807585C 6051     str     r1,[r2,4h]		;数据写入内存
0807585E 4F0A     ldr     r7,=300014Ch
08075860 2100     mov     r1,0h
08075862 7039     strb    r1,[r7]
08075864 4809     ldr     r0,=300004Bh
08075866 7001     strb    r1,[r0]			;禁用暂停归零
08075868 4809     ldr     r0,=3005520h
0807586A 2500     mov     r5,0h
0807586C 2602     mov     r6,2h
0807586E 7006     strb    r6,[r0]			
08075870 2C01     cmp     r4,1h
08075872 D01F     beq     80758B4h
08075874 2C01     cmp     r4,1h
08075876 DC0D     bgt     8075894h
08075878 2C00     cmp     r4,0h
0807587A D010     beq     807589Eh
0807587C E04C     b       8075918h
0807587E 0000     lsl     r0,r0,0h
08075880 168C     asr     r4,r1,1Ah
08075882 0300     lsl     r0,r0,0Ch
08075884 1510     asr     r0,r2,14h
08075886 0841     lsr     r1,r0,1h
08075888 014C     lsl     r4,r1,5h
0807588A 0300     lsl     r0,r0,0Ch
0807588C 004B     lsl     r3,r1,1h
0807588E 0300     lsl     r0,r0,0Ch
08075890 5520     strb    r0,[r4,r4]
08075892 0300     lsl     r0,r0,0Ch
08075894 2C02     cmp     r4,2h
08075896 D03F     beq     8075918h
08075898 2C03     cmp     r4,3h
0807589A D02B     beq     80758F4h
0807589C E03C     b       8075918h
0807589E 4903     ldr     r1,=3000C6Ch
080758A0 4803     ldr     r0,=8411524h
080758A2 6800     ldr     r0,[r0]
080758A4 6008     str     r0,[r1]
080758A6 F000F861 bl      807596Ch
080758AA E033     b       8075914h
080758AC 0C6C     lsr     r4,r5,11h
080758AE 0300     lsl     r0,r0,0Ch
080758B0 1524     asr     r4,r4,14h
080758B2 0841     lsr     r1,r0,1h
080758B4 4908     ldr     r1,=3000C6Ch
080758B6 4809     ldr     r0,=8411524h
080758B8 6800     ldr     r0,[r0]
080758BA 6008     str     r0,[r1]
080758BC F000F8EA bl      8075A94h
080758C0 4807     ldr     r0,=3000055h
080758C2 7005     strb    r5,[r0]
080758C4 4807     ldr     r0,=3000056h
080758C6 7005     strb    r5,[r0]
080758C8 703C     strb    r4,[r7]
080758CA 4807     ldr     r0,=3000042h
080758CC 7005     strb    r5,[r0]
080758CE 4807     ldr     r0,=3000000h
080758D0 7005     strb    r5,[r0]
080758D2 4807     ldr     r0,=3000020h
080758D4 7006     strb    r6,[r0]
080758D6 E01D     b       @@Pass2
080758D8 0C6C     lsr     r4,r5,11h
080758DA 0300     lsl     r0,r0,0Ch
080758DC 1524     asr     r4,r4,14h
080758DE 0841     lsr     r1,r0,1h
080758E0 0055     lsl     r5,r2,1h
080758E2 0300     lsl     r0,r0,0Ch
080758E4 0056     lsl     r6,r2,1h
080758E6 0300     lsl     r0,r0,0Ch
080758E8 0042     lsl     r2,r0,1h
080758EA 0300     lsl     r0,r0,0Ch
080758EC 0000     lsl     r0,r0,0h
080758EE 0300     lsl     r0,r0,0Ch
080758F0 0020     lsl     r0,r4,0h
080758F2 0300     lsl     r0,r0,0Ch
080758F4 4B12     ldr     r3,=3000C1Dh
080758F6 4A13     ldr     r2,=3000C24h
080758F8 4813     ldr     r0,=3000C1Eh
080758FA 2100     mov     r1,0h
080758FC 5641     ldsb    r1,[r0,r1]
080758FE 0048     lsl     r0,r1,1h
08075900 1840     add     r0,r0,r1
08075902 00C0     lsl     r0,r0,3h
08075904 1880     add     r0,r0,r2
08075906 7800     ldrb    r0,[r0]
08075908 7018     strb    r0,[r3]
0807590A 0600     lsl     r0,r0,18h
0807590C 2800     cmp     r0,0h
0807590E D001     beq     @@Pass2
08075910 F7FEFF3C bl      807478Ch

@@Pass2:
08075914 480D     ldr     r0,=300007Dh
08075916 7005     strb    r5,[r0]
08075918 480D     ldr     r0,=3000C75h
0807591A 2100     mov     r1,0h
0807591C 7001     strb    r1,[r0]
0807591E 480D     ldr     r0,=3000029h
08075920 7001     strb    r1,[r0]
08075922 480D     ldr     r0,=3000043h
08075924 7001     strb    r1,[r0]
08075926 480D     ldr     r0,=3000005h
08075928 7001     strb    r1,[r0]
0807592A 480D     ldr     r0,=3000BF0h
0807592C 7001     strb    r1,[r0]
0807592E 480D     ldr     r0,=3000049h
08075930 7001     strb    r1,[r0]
08075932 490D     ldr     r1,=300550Ch
08075934 2000     mov     r0,0h
08075936 8008     strh    r0,[r1]
08075938 BCF0     pop     r4-r7
0807593A BC01     pop     r0
0807593C 4700     bx      r0