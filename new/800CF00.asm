0800CF00 B5F0     push    r4-r7,lr
0800CF02 4657     mov     r7,r10
0800CF04 464E     mov     r6,r9
0800CF06 4645     mov     r5,r8
0800CF08 B4E0     push    r5-r7
0800CF0A B082     add     sp,-8h
0800CF0C 4E26     ldr     r6,=3000738h
0800CF0E 4827     ldr     r0,=3000C77h		;8bit 循环数
0800CF10 7800     ldrb    r0,[r0]
0800CF12 9000     str     r0,[sp]			;写入sp
0800CF14 4826     ldr     r0,=3000002h		;8bit 循环数
0800CF16 8800     ldrh    r0,[r0]			
0800CF18 0900     lsr     r0,r0,4h			;除以16h
0800CF1A 9001     str     r0,[sp,4h]		;写入sp 4
0800CF1C 4825     ldr     r0,=3000C72h
0800CF1E 2100     mov     r1,0h
0800CF20 5E40     ldsh    r0,[r0,r1]		;sub game mode 1
0800CF22 2802     cmp     r0,2h
0800CF24 D000     beq     @@subgamemode2
0800CF26 E107     b       800D138h

@@subgamemode2:
0800CF28 F004FEAE bl      8011C88h
0800CF2C F003FACE bl      80104CCh
0800CF30 2800     cmp     r0,0h
0800CF32 D179     bne     800D028h
0800CF34 F001FC08 bl      800E748h
0800CF38 2700     mov     r7,0h
0800CF3A 4D1F     ldr     r5,=30001ACh
0800CF3C 4C1F     ldr     r4,=40000D4h
0800CF3E 4820     ldr     r0,=300083Ch
0800CF40 4682     mov     r10,r0
0800CF42 4920     ldr     r1,=82B0CACh
0800CF44 4689     mov     r9,r1
0800CF46 00FA     lsl     r2,r7,3h
0800CF48 1BD0     sub     r0,r2,r7
0800CF4A 00C0     lsl     r0,r0,3h
0800CF4C 1943     add     r3,r0,r5
0800CF4E 8819     ldrh    r1,[r3]
0800CF50 2001     mov     r0,1h
0800CF52 4008     and     r0,r1
0800CF54 4690     mov     r8,r2
0800CF56 2800     cmp     r0,0h
0800CF58 D059     beq     800D00Eh
0800CF5A 6023     str     r3,[r4]
0800CF5C 4812     ldr     r0,=3000738h
0800CF5E 6060     str     r0,[r4,4h]
0800CF60 4819     ldr     r0,=8000001Ch
0800CF62 60A0     str     r0,[r4,8h]
0800CF64 68A0     ldr     r0,[r4,8h]
0800CF66 9900     ldr     r1,[sp]
0800CF68 19C8     add     r0,r1,r7
0800CF6A 9901     ldr     r1,[sp,4h]
0800CF6C 1840     add     r0,r0,r1
0800CF6E 88B1     ldrh    r1,[r6,4h]
0800CF70 1840     add     r0,r0,r1
0800CF72 8871     ldrh    r1,[r6,2h]
0800CF74 1840     add     r0,r0,r1
0800CF76 211F     mov     r1,1Fh
0800CF78 4008     and     r0,r1
0800CF7A 4448     add     r0,r9
0800CF7C 7800     ldrb    r0,[r0]
0800CF7E 4651     mov     r1,r10
0800CF80 7008     strb    r0,[r1]
0800CF82 1C30     mov     r0,r6
0800CF84 F003FEB4 bl      8010CF0h			;敌人被击打闪光
0800CF88 1C30     mov     r0,r6
0800CF8A 3032     add     r0,32h
0800CF8C 7801     ldrb    r1,[r0]
0800CF8E 2080     mov     r0,80h
0800CF90 4008     and     r0,r1
0800CF92 2800     cmp     r0,0h
0800CF94 D01C     beq     800CFD0h
0800CF96 480D     ldr     r0,=875F1E8h
0800CF98 7F71     ldrb    r1,[r6,1Dh]
0800CF9A 0089     lsl     r1,r1,2h
0800CF9C 1809     add     r1,r1,r0
0800CF9E 6808     ldr     r0,[r1]
0800CFA0 F07DFE2A bl      808ABF8h
0800CFA4 E01B     b       800CFDEh
0800CFA6 0000     lsl     r0,r0,0h
0800CFA8 0738     lsl     r0,r7,1Ch
0800CFAA 0300     lsl     r0,r0,0Ch
0800CFAC 0C77     lsr     r7,r6,11h
0800CFAE 0300     lsl     r0,r0,0Ch
0800CFB0 0002     lsl     r2,r0,0h
0800CFB2 0300     lsl     r0,r0,0Ch
0800CFB4 0C72     lsr     r2,r6,11h
0800CFB6 0300     lsl     r0,r0,0Ch
0800CFB8 01AC     lsl     r4,r5,6h
0800CFBA 0300     lsl     r0,r0,0Ch
0800CFBC 00D4     lsl     r4,r2,3h
0800CFBE 0400     lsl     r0,r0,10h
0800CFC0 083C     lsr     r4,r7,20h
0800CFC2 0300     lsl     r0,r0,0Ch
0800CFC4 0CAC     lsr     r4,r5,12h
0800CFC6 082B     lsr     r3,r5,20h
0800CFC8 001C     lsl     r4,r3,0h
0800CFCA 8000     strh    r0,[r0]
0800CFCC F1E80875 ????
0800CFCE 0875     lsr     r5,r6,1h
0800CFD0 4812     ldr     r0,=875E8C0h
0800CFD2 7F71     ldrb    r1,[r6,1Dh]
0800CFD4 0089     lsl     r1,r1,2h
0800CFD6 1809     add     r1,r1,r0
0800CFD8 6808     ldr     r0,[r1]
0800CFDA F07DFE0D bl      808ABF8h
0800CFDE 8831     ldrh    r1,[r6]
0800CFE0 2001     mov     r0,1h
0800CFE2 4008     and     r0,r1
0800CFE4 2800     cmp     r0,0h
0800CFE6 D008     beq     800CFFAh
0800CFE8 1C30     mov     r0,r6
0800CFEA F002FFB9 bl      800FF60h
0800CFEE 1C30     mov     r0,r6
0800CFF0 F000F99C bl      800D32Ch
0800CFF4 1C30     mov     r0,r6
0800CFF6 F000FEED bl      800DDD4h
0800CFFA 4809     ldr     r0,=3000738h
0800CFFC 6020     str     r0,[r4]
0800CFFE 4641     mov     r1,r8
0800D000 1BC8     sub     r0,r1,r7
0800D002 00C0     lsl     r0,r0,3h
0800D004 1940     add     r0,r0,r5
0800D006 6060     str     r0,[r4,4h]
0800D008 4806     ldr     r0,=8000001Ch
0800D00A 60A0     str     r0,[r4,8h]
0800D00C 68A0     ldr     r0,[r4,8h]
0800D00E 1C78     add     r0,r7,1
0800D010 0600     lsl     r0,r0,18h
0800D012 0E07     lsr     r7,r0,18h
0800D014 2F17     cmp     r7,17h
0800D016 D996     bls     800CF46h
0800D018 E0FC     b       800D214h
0800D01A 0000     lsl     r0,r0,0h
0800D01C E8C0     ????
0800D01E 0875     lsr     r5,r6,1h
0800D020 0738     lsl     r0,r7,1Ch
0800D022 0300     lsl     r0,r0,0Ch
0800D024 001C     lsl     r4,r3,0h
0800D026 8000     strh    r0,[r0]
0800D028 2700     mov     r7,0h
0800D02A 4D21     ldr     r5,=40000D4h
0800D02C 46B2     mov     r10,r6
0800D02E 4821     ldr     r0,=8000001Ch
0800D030 4681     mov     r9,r0
0800D032 00FA     lsl     r2,r7,3h
0800D034 1BD0     sub     r0,r2,r7
0800D036 00C0     lsl     r0,r0,3h
0800D038 491F     ldr     r1,=30001ACh
0800D03A 1844     add     r4,r0,r1
0800D03C 8821     ldrh    r1,[r4]
0800D03E 2001     mov     r0,1h
0800D040 4008     and     r0,r1
0800D042 4690     mov     r8,r2
0800D044 2800     cmp     r0,0h
0800D046 D070     beq     800D12Ah
0800D048 1C20     mov     r0,r4
0800D04A 3024     add     r0,24h
0800D04C 7800     ldrb    r0,[r0]
0800D04E 2800     cmp     r0,0h
0800D050 D006     beq     800D060h
0800D052 1C20     mov     r0,r4
0800D054 3032     add     r0,32h
0800D056 7801     ldrb    r1,[r0]
0800D058 2001     mov     r0,1h
0800D05A 4008     and     r0,r1
0800D05C 2800     cmp     r0,0h
0800D05E D055     beq     800D10Ch
0800D060 602C     str     r4,[r5]
0800D062 4650     mov     r0,r10
0800D064 6068     str     r0,[r5,4h]
0800D066 4649     mov     r1,r9
0800D068 60A9     str     r1,[r5,8h]
0800D06A 68A8     ldr     r0,[r5,8h]
0800D06C 4A13     ldr     r2,=82B0CACh
0800D06E 9900     ldr     r1,[sp]
0800D070 19C8     add     r0,r1,r7
0800D072 9901     ldr     r1,[sp,4h]
0800D074 1840     add     r0,r0,r1
0800D076 88B1     ldrh    r1,[r6,4h]
0800D078 1840     add     r0,r0,r1
0800D07A 8871     ldrh    r1,[r6,2h]
0800D07C 1840     add     r0,r0,r1
0800D07E 211F     mov     r1,1Fh
0800D080 4008     and     r0,r1
0800D082 1880     add     r0,r0,r2
0800D084 7800     ldrb    r0,[r0]
0800D086 490E     ldr     r1,=300083Ch
0800D088 7008     strb    r0,[r1]
0800D08A 1C30     mov     r0,r6
0800D08C F003FE30 bl      8010CF0h
0800D090 1C30     mov     r0,r6
0800D092 3032     add     r0,32h
0800D094 7801     ldrb    r1,[r0]
0800D096 2080     mov     r0,80h
0800D098 4008     and     r0,r1
0800D09A 2800     cmp     r0,0h
0800D09C D014     beq     800D0C8h
0800D09E 4809     ldr     r0,=875F1E8h
0800D0A0 7F71     ldrb    r1,[r6,1Dh]
0800D0A2 0089     lsl     r1,r1,2h
0800D0A4 1809     add     r1,r1,r0
0800D0A6 6808     ldr     r0,[r1]
0800D0A8 F07DFDA6 bl      808ABF8h
0800D0AC E013     b       800D0D6h
0800D0AE 0000     lsl     r0,r0,0h
0800D0B0 00D4     lsl     r4,r2,3h
0800D0B2 0400     lsl     r0,r0,10h
0800D0B4 001C     lsl     r4,r3,0h
0800D0B6 8000     strh    r0,[r0]
0800D0B8 01AC     lsl     r4,r5,6h
0800D0BA 0300     lsl     r0,r0,0Ch
0800D0BC 0CAC     lsr     r4,r5,12h
0800D0BE 082B     lsr     r3,r5,20h
0800D0C0 083C     lsr     r4,r7,20h
0800D0C2 0300     lsl     r0,r0,0Ch
0800D0C4 F1E80875 ????
0800D0C6 0875     lsr     r5,r6,1h
0800D0C8 480E     ldr     r0,=875E8C0h
0800D0CA 7F71     ldrb    r1,[r6,1Dh]
0800D0CC 0089     lsl     r1,r1,2h
0800D0CE 1809     add     r1,r1,r0
0800D0D0 6808     ldr     r0,[r1]
0800D0D2 F07DFD91 bl      808ABF8h
0800D0D6 8831     ldrh    r1,[r6]
0800D0D8 2001     mov     r0,1h
0800D0DA 4008     and     r0,r1
0800D0DC 2800     cmp     r0,0h
0800D0DE D008     beq     800D0F2h
0800D0E0 1C30     mov     r0,r6
0800D0E2 F002FF3D bl      800FF60h
0800D0E6 1C30     mov     r0,r6
0800D0E8 F000F920 bl      800D32Ch
0800D0EC 1C30     mov     r0,r6
0800D0EE F000FE71 bl      800DDD4h
0800D0F2 4650     mov     r0,r10
0800D0F4 6028     str     r0,[r5]
0800D0F6 4641     mov     r1,r8
0800D0F8 1BC8     sub     r0,r1,r7
0800D0FA 00C0     lsl     r0,r0,3h
0800D0FC 4902     ldr     r1,=30001ACh
0800D0FE 1840     add     r0,r0,r1
0800D100 6068     str     r0,[r5,4h]
0800D102 E00F     b       800D124h
0800D104 E8C0     ????
0800D106 0875     lsr     r5,r6,1h
0800D108 01AC     lsl     r4,r5,6h
0800D10A 0300     lsl     r0,r0,0Ch
0800D10C 602C     str     r4,[r5]
0800D10E 4651     mov     r1,r10
0800D110 6069     str     r1,[r5,4h]
0800D112 4648     mov     r0,r9
0800D114 60A8     str     r0,[r5,8h]
0800D116 68A8     ldr     r0,[r5,8h]
0800D118 1C30     mov     r0,r6
0800D11A F000FE5B bl      800DDD4h
0800D11E 4651     mov     r1,r10
0800D120 6029     str     r1,[r5]
0800D122 606C     str     r4,[r5,4h]
0800D124 4648     mov     r0,r9
0800D126 60A8     str     r0,[r5,8h]
0800D128 68A8     ldr     r0,[r5,8h]
0800D12A 1C78     add     r0,r7,1
0800D12C 0600     lsl     r0,r0,18h
0800D12E 0E07     lsr     r7,r0,18h
0800D130 2F17     cmp     r7,17h
0800D132 D800     bhi     800D136h
0800D134 E77D     b       800D032h
0800D136 E0E9     b       800D30Ch

@@subgamemodeno2:
0800D138 2806     cmp     r0,6h
0800D13A D000     beq     800D13Eh
0800D13C E07E     b       800D23Ch
0800D13E 2700     mov     r7,0h
0800D140 4D1A     ldr     r5,=30001ACh
0800D142 4C1B     ldr     r4,=40000D4h
0800D144 491B     ldr     r1,=300083Ch
0800D146 468A     mov     r10,r1
0800D148 481B     ldr     r0,=82B0CACh
0800D14A 4681     mov     r9,r0
0800D14C 00FA     lsl     r2,r7,3h
0800D14E 1BD0     sub     r0,r2,r7
0800D150 00C0     lsl     r0,r0,3h
0800D152 1943     add     r3,r0,r5
0800D154 8819     ldrh    r1,[r3]
0800D156 2001     mov     r0,1h
0800D158 4008     and     r0,r1
0800D15A 4690     mov     r8,r2
0800D15C 2800     cmp     r0,0h
0800D15E D054     beq     800D20Ah
0800D160 6023     str     r3,[r4]
0800D162 4816     ldr     r0,=3000738h
0800D164 6060     str     r0,[r4,4h]
0800D166 4816     ldr     r0,=8000001Ch
0800D168 60A0     str     r0,[r4,8h]
0800D16A 68A0     ldr     r0,[r4,8h]
0800D16C 9900     ldr     r1,[sp]
0800D16E 19C8     add     r0,r1,r7
0800D170 9901     ldr     r1,[sp,4h]
0800D172 1840     add     r0,r0,r1
0800D174 88B1     ldrh    r1,[r6,4h]
0800D176 1840     add     r0,r0,r1
0800D178 8871     ldrh    r1,[r6,2h]
0800D17A 1840     add     r0,r0,r1
0800D17C 211F     mov     r1,1Fh
0800D17E 4008     and     r0,r1
0800D180 4448     add     r0,r9
0800D182 7800     ldrb    r0,[r0]
0800D184 4651     mov     r1,r10
0800D186 7008     strb    r0,[r1]
0800D188 1C30     mov     r0,r6
0800D18A F003FDB1 bl      8010CF0h
0800D18E 1C30     mov     r0,r6
0800D190 3032     add     r0,32h
0800D192 7801     ldrb    r1,[r0]
0800D194 2080     mov     r0,80h
0800D196 4008     and     r0,r1
0800D198 2800     cmp     r0,0h
0800D19A D015     beq     800D1C8h
0800D19C 4809     ldr     r0,=875F1E8h
0800D19E 7F71     ldrb    r1,[r6,1Dh]
0800D1A0 0089     lsl     r1,r1,2h
0800D1A2 1809     add     r1,r1,r0
0800D1A4 6808     ldr     r0,[r1]
0800D1A6 F07DFD27 bl      808ABF8h
0800D1AA E014     b       800D1D6h
0800D1AC 01AC     lsl     r4,r5,6h
0800D1AE 0300     lsl     r0,r0,0Ch
0800D1B0 00D4     lsl     r4,r2,3h
0800D1B2 0400     lsl     r0,r0,10h
0800D1B4 083C     lsr     r4,r7,20h
0800D1B6 0300     lsl     r0,r0,0Ch
0800D1B8 0CAC     lsr     r4,r5,12h
0800D1BA 082B     lsr     r3,r5,20h
0800D1BC 0738     lsl     r0,r7,1Ch
0800D1BE 0300     lsl     r0,r0,0Ch
0800D1C0 001C     lsl     r4,r3,0h
0800D1C2 8000     strh    r0,[r0]
0800D1C4 F1E80875 ????
0800D1C6 0875     lsr     r5,r6,1h
0800D1C8 4817     ldr     r0,=875E8C0h
0800D1CA 7F71     ldrb    r1,[r6,1Dh]
0800D1CC 0089     lsl     r1,r1,2h
0800D1CE 1809     add     r1,r1,r0
0800D1D0 6808     ldr     r0,[r1]
0800D1D2 F07DFD11 bl      808ABF8h
0800D1D6 8831     ldrh    r1,[r6]
0800D1D8 2001     mov     r0,1h
0800D1DA 4008     and     r0,r1
0800D1DC 2800     cmp     r0,0h
0800D1DE D008     beq     800D1F2h
0800D1E0 1C30     mov     r0,r6
0800D1E2 F002FEBD bl      800FF60h
0800D1E6 1C30     mov     r0,r6
0800D1E8 F000F8A0 bl      800D32Ch
0800D1EC 1C30     mov     r0,r6
0800D1EE F000FDF1 bl      800DDD4h
0800D1F2 480E     ldr     r0,=3000738h
0800D1F4 6020     str     r0,[r4]
0800D1F6 4641     mov     r1,r8
0800D1F8 1BC8     sub     r0,r1,r7
0800D1FA 00C0     lsl     r0,r0,3h
0800D1FC 490C     ldr     r1,=30001ACh
0800D1FE 1840     add     r0,r0,r1
0800D200 6060     str     r0,[r4,4h]
0800D202 480C     ldr     r0,=8000001Ch
0800D204 60A0     str     r0,[r4,8h]
0800D206 68A0     ldr     r0,[r4,8h]
0800D208 1C0D     mov     r5,r1
0800D20A 1C78     add     r0,r7,1
0800D20C 0600     lsl     r0,r0,18h
0800D20E 0E07     lsr     r7,r0,18h
0800D210 2F17     cmp     r7,17h
0800D212 D99B     bls     800D14Ch
0800D214 F01BFB0C bl      8028830h
0800D218 4907     ldr     r1,=3000734h
0800D21A 7808     ldrb    r0,[r1]
0800D21C 2800     cmp     r0,0h
0800D21E D075     beq     800D30Ch
0800D220 3801     sub     r0,1h
0800D222 7008     strb    r0,[r1]
0800D224 E072     b       800D30Ch
0800D226 0000     lsl     r0,r0,0h
0800D228 E8C0     ????
0800D22A 0875     lsr     r5,r6,1h
0800D22C 0738     lsl     r0,r7,1Ch
0800D22E 0300     lsl     r0,r0,0Ch
0800D230 01AC     lsl     r4,r5,6h
0800D232 0300     lsl     r0,r0,0Ch
0800D234 001C     lsl     r4,r3,0h
0800D236 8000     strh    r0,[r0]
0800D238 0734     lsl     r4,r6,1Ch
0800D23A 0300     lsl     r0,r0,0Ch
0800D23C 2700     mov     r7,0h
0800D23E 4D1C     ldr     r5,=30001ACh
0800D240 4C1C     ldr     r4,=40000D4h
0800D242 481D     ldr     r0,=300083Ch
0800D244 4682     mov     r10,r0
0800D246 491D     ldr     r1,=82B0CACh
0800D248 4689     mov     r9,r1
0800D24A 00FA     lsl     r2,r7,3h
0800D24C 1BD0     sub     r0,r2,r7
0800D24E 00C0     lsl     r0,r0,3h
0800D250 1943     add     r3,r0,r5
0800D252 8819     ldrh    r1,[r3]
0800D254 2001     mov     r0,1h
0800D256 4008     and     r0,r1
0800D258 4690     mov     r8,r2
0800D25A 2800     cmp     r0,0h
0800D25C D051     beq     800D302h
0800D25E 6023     str     r3,[r4]
0800D260 4817     ldr     r0,=3000738h
0800D262 6060     str     r0,[r4,4h]
0800D264 4817     ldr     r0,=8000001Ch
0800D266 60A0     str     r0,[r4,8h]
0800D268 68A0     ldr     r0,[r4,8h]
0800D26A 9900     ldr     r1,[sp]
0800D26C 19C8     add     r0,r1,r7
0800D26E 9901     ldr     r1,[sp,4h]
0800D270 1840     add     r0,r0,r1
0800D272 88B1     ldrh    r1,[r6,4h]
0800D274 1840     add     r0,r0,r1
0800D276 8871     ldrh    r1,[r6,2h]
0800D278 1840     add     r0,r0,r1
0800D27A 211F     mov     r1,1Fh
0800D27C 4008     and     r0,r1
0800D27E 4448     add     r0,r9
0800D280 7800     ldrb    r0,[r0]
0800D282 4651     mov     r1,r10
0800D284 7008     strb    r0,[r1]
0800D286 1C30     mov     r0,r6
0800D288 3024     add     r0,24h
0800D28A 7800     ldrb    r0,[r0]
0800D28C 2800     cmp     r0,0h
0800D28E D124     bne     800D2DAh
0800D290 1C30     mov     r0,r6
0800D292 3032     add     r0,32h
0800D294 7801     ldrb    r1,[r0]
0800D296 2080     mov     r0,80h
0800D298 4008     and     r0,r1
0800D29A 2800     cmp     r0,0h
0800D29C D016     beq     800D2CCh
0800D29E 480A     ldr     r0,=875F1E8h
0800D2A0 7F71     ldrb    r1,[r6,1Dh]
0800D2A2 0089     lsl     r1,r1,2h
0800D2A4 1809     add     r1,r1,r0
0800D2A6 6808     ldr     r0,[r1]
0800D2A8 F07DFCA6 bl      808ABF8h
0800D2AC E015     b       800D2DAh
0800D2AE 0000     lsl     r0,r0,0h
0800D2B0 01AC     lsl     r4,r5,6h
0800D2B2 0300     lsl     r0,r0,0Ch
0800D2B4 00D4     lsl     r4,r2,3h
0800D2B6 0400     lsl     r0,r0,10h
0800D2B8 083C     lsr     r4,r7,20h
0800D2BA 0300     lsl     r0,r0,0Ch
0800D2BC 0CAC     lsr     r4,r5,12h
0800D2BE 082B     lsr     r3,r5,20h
0800D2C0 0738     lsl     r0,r7,1Ch
0800D2C2 0300     lsl     r0,r0,0Ch
0800D2C4 001C     lsl     r4,r3,0h
0800D2C6 8000     strh    r0,[r0]
0800D2C8 F1E80875 ????
0800D2CA 0875     lsr     r5,r6,1h
0800D2CC 4813     ldr     r0,=875E8C0h
0800D2CE 7F71     ldrb    r1,[r6,1Dh]
0800D2D0 0089     lsl     r1,r1,2h
0800D2D2 1809     add     r1,r1,r0
0800D2D4 6808     ldr     r0,[r1]
0800D2D6 F07DFC8F bl      808ABF8h
0800D2DA 8831     ldrh    r1,[r6]
0800D2DC 2001     mov     r0,1h
0800D2DE 4008     and     r0,r1
0800D2E0 2800     cmp     r0,0h
0800D2E2 D002     beq     800D2EAh
0800D2E4 1C30     mov     r0,r6
0800D2E6 F000FD75 bl      800DDD4h
0800D2EA 480D     ldr     r0,=3000738h
0800D2EC 6020     str     r0,[r4]
0800D2EE 4641     mov     r1,r8
0800D2F0 1BC8     sub     r0,r1,r7
0800D2F2 00C0     lsl     r0,r0,3h
0800D2F4 490B     ldr     r1,=30001ACh
0800D2F6 1840     add     r0,r0,r1
0800D2F8 6060     str     r0,[r4,4h]
0800D2FA 480B     ldr     r0,=8000001Ch
0800D2FC 60A0     str     r0,[r4,8h]
0800D2FE 68A0     ldr     r0,[r4,8h]
0800D300 1C0D     mov     r5,r1
0800D302 1C78     add     r0,r7,1
0800D304 0600     lsl     r0,r0,18h
0800D306 0E07     lsr     r7,r0,18h
0800D308 2F17     cmp     r7,17h
0800D30A D99E     bls     800D24Ah
0800D30C B002     add     sp,8h
0800D30E BC38     pop     r3-r5
0800D310 4698     mov     r8,r3
0800D312 46A1     mov     r9,r4
0800D314 46AA     mov     r10,r5
0800D316 BCF0     pop     r4-r7
0800D318 BC01     pop     r0
0800D31A 4700     bx      r0
0800D31C E8C0     ????
0800D31E 0875     lsr     r5,r6,1h
0800D320 0738     lsl     r0,r7,1Ch
0800D322 0300     lsl     r0,r0,0Ch
0800D324 01AC     lsl     r4,r5,6h
0800D326 0300     lsl     r0,r0,0Ch
0800D328 001C     lsl     r4,r3,0h
0800D32A 8000     strh    r0,[r0]
0800D32C B500     push    lr
0800D32E 1C02     mov     r2,r0
0800D330 3030     add     r0,30h
0800D332 7800     ldrb    r0,[r0]
0800D334 2800     cmp     r0,0h
0800D336 D117     bne     800D368h
0800D338 7F10     ldrb    r0,[r2,1Ch]
0800D33A 3001     add     r0,1h
0800D33C 7710     strb    r0,[r2,1Ch]
0800D33E 8AD1     ldrh    r1,[r2,16h]
0800D340 6993     ldr     r3,[r2,18h]
0800D342 00C9     lsl     r1,r1,3h
0800D344 18C9     add     r1,r1,r3
0800D346 7909     ldrb    r1,[r1,4h]
0800D348 0600     lsl     r0,r0,18h
0800D34A 0E00     lsr     r0,r0,18h
0800D34C 4281     cmp     r1,r0
0800D34E D20B     bcs     800D368h
0800D350 2001     mov     r0,1h
0800D352 7710     strb    r0,[r2,1Ch]
0800D354 8AD0     ldrh    r0,[r2,16h]
0800D356 3001     add     r0,1h
0800D358 82D0     strh    r0,[r2,16h]
0800D35A 8AD0     ldrh    r0,[r2,16h]
0800D35C 00C0     lsl     r0,r0,3h
0800D35E 18C0     add     r0,r0,r3
0800D360 7900     ldrb    r0,[r0,4h]
0800D362 2800     cmp     r0,0h
0800D364 D100     bne     800D368h
0800D366 82D0     strh    r0,[r2,16h]
0800D368 BC01     pop     r0
0800D36A 4700     bx      r0
0800D36C B5F0     push    r4-r7,lr
0800D36E 464F     mov     r7,r9
0800D370 4646     mov     r6,r8
0800D372 B4C0     push    r6,r7
0800D374 B082     add     sp,-8h
0800D376 4813     ldr     r0,=3000C72h
0800D378 2200     mov     r2,0h
0800D37A 5E81     ldsh    r1,[r0,r2]
0800D37C 2002     mov     r0,2h
0800D37E 4041     eor     r1,r0
0800D380 4248     neg     r0,r1
0800D382 4308     orr     r0,r1
0800D384 0FC0     lsr     r0,r0,1Fh
0800D386 4684     mov     r12,r0
0800D388 2017     mov     r0,17h
0800D38A 4681     mov     r9,r0
0800D38C 2113     mov     r1,13h
0800D38E 4688     mov     r8,r1
0800D390 480D     ldr     r0,=30001ACh
0800D392 2700     mov     r7,0h
0800D394 4B0D     ldr     r3,=30007F3h
0800D396 1C04     mov     r4,r0
0800D398 3422     add     r4,22h
0800D39A 1C06     mov     r6,r0
0800D39C 2517     mov     r5,17h
0800D39E 8830     ldrh    r0,[r6]
0800D3A0 464A     mov     r2,r9
0800D3A2 4010     and     r0,r2
0800D3A4 4540     cmp     r0,r8
0800D3A6 D113     bne     800D3D0h
0800D3A8 7822     ldrb    r2,[r4]
0800D3AA 2A08     cmp     r2,8h
0800D3AC D810     bhi     800D3D0h
0800D3AE 4660     mov     r0,r12
0800D3B0 2800     cmp     r0,0h
0800D3B2 D004     beq     800D3BEh
0800D3B4 7C21     ldrb    r1,[r4,10h]
0800D3B6 2020     mov     r0,20h
0800D3B8 4008     and     r0,r1
0800D3BA 2800     cmp     r0,0h
0800D3BC D108     bne     800D3D0h
0800D3BE 701A     strb    r2,[r3]
0800D3C0 E007     b       800D3D2h
0800D3C2 0000     lsl     r0,r0,0h
0800D3C4 0C72     lsr     r2,r6,11h
0800D3C6 0300     lsl     r0,r0,0Ch
0800D3C8 01AC     lsl     r4,r5,6h
0800D3CA 0300     lsl     r0,r0,0Ch
0800D3CC 07F3     lsl     r3,r6,1Fh
0800D3CE 0300     lsl     r0,r0,0Ch
0800D3D0 701F     strb    r7,[r3]
0800D3D2 3301     add     r3,1h
0800D3D4 3438     add     r4,38h
0800D3D6 3638     add     r6,38h
0800D3D8 3D01     sub     r5,1h
0800D3DA 2D00     cmp     r5,0h
0800D3DC DADF     bge     800D39Eh
0800D3DE 2601     mov     r6,1h
0800D3E0 4B10     ldr     r3,=30006ECh
0800D3E2 2500     mov     r5,0h
0800D3E4 4C10     ldr     r4,=30001ACh
0800D3E6 1C77     add     r7,r6,1
0800D3E8 429C     cmp     r4,r3
0800D3EA D210     bcs     800D40Eh
0800D3EC 4A0F     ldr     r2,=30007F3h
0800D3EE 18A8     add     r0,r5,r2
0800D3F0 7800     ldrb    r0,[r0]
0800D3F2 42B0     cmp     r0,r6
0800D3F4 D107     bne     800D406h
0800D3F6 1C20     mov     r0,r4
0800D3F8 1C29     mov     r1,r5
0800D3FA 9200     str     r2,[sp]
0800D3FC 9301     str     r3,[sp,4h]
0800D3FE F000F8A1 bl      800D544h
0800D402 9B01     ldr     r3,[sp,4h]
0800D404 9A00     ldr     r2,[sp]
0800D406 3501     add     r5,1h
0800D408 3438     add     r4,38h
0800D40A 429C     cmp     r4,r3
0800D40C D3EF     bcc     800D3EEh
0800D40E 1C3E     mov     r6,r7
0800D410 2E08     cmp     r6,8h
0800D412 DDE6     ble     800D3E2h
0800D414 B002     add     sp,8h
0800D416 BC18     pop     r3,r4
0800D418 4698     mov     r8,r3
0800D41A 46A1     mov     r9,r4
0800D41C BCF0     pop     r4-r7
0800D41E BC01     pop     r0
0800D420 4700     bx      r0
0800D422 0000     lsl     r0,r0,0h
0800D424 06EC     lsl     r4,r5,1Bh
0800D426 0300     lsl     r0,r0,0Ch
0800D428 01AC     lsl     r4,r5,6h
0800D42A 0300     lsl     r0,r0,0Ch
0800D42C 07F3     lsl     r3,r6,1Fh
0800D42E 0300     lsl     r0,r0,0Ch
0800D430 B5F0     push    r4-r7,lr
0800D432 B082     add     sp,-8h
0800D434 2717     mov     r7,17h
0800D436 2603     mov     r6,3h
0800D438 F004FCE4 bl      8011E04h
0800D43C 4807     ldr     r0,=30001ACh
0800D43E 2400     mov     r4,0h
0800D440 4907     ldr     r1,=30007F3h
0800D442 1C03     mov     r3,r0
0800D444 3322     add     r3,22h
0800D446 1C02     mov     r2,r0
0800D448 2517     mov     r5,17h
0800D44A 8810     ldrh    r0,[r2]
0800D44C 4038     and     r0,r7
0800D44E 42B0     cmp     r0,r6
0800D450 D108     bne     800D464h
0800D452 7818     ldrb    r0,[r3]
0800D454 2808     cmp     r0,8h
0800D456 D805     bhi     800D464h
0800D458 7008     strb    r0,[r1]
0800D45A E004     b       800D466h
0800D45C 01AC     lsl     r4,r5,6h
0800D45E 0300     lsl     r0,r0,0Ch
0800D460 07F3     lsl     r3,r6,1Fh
0800D462 0300     lsl     r0,r0,0Ch
0800D464 700C     strb    r4,[r1]
0800D466 3101     add     r1,1h
0800D468 3338     add     r3,38h
0800D46A 3238     add     r2,38h
0800D46C 3D01     sub     r5,1h
0800D46E 2D00     cmp     r5,0h
0800D470 DAEB     bge     800D44Ah
0800D472 2601     mov     r6,1h
0800D474 4B0E     ldr     r3,=30006ECh
0800D476 2500     mov     r5,0h
0800D478 4C0E     ldr     r4,=30001ACh
0800D47A 1C77     add     r7,r6,1
0800D47C 429C     cmp     r4,r3
0800D47E D210     bcs     800D4A2h
0800D480 4A0D     ldr     r2,=30007F3h
0800D482 18A8     add     r0,r5,r2
0800D484 7800     ldrb    r0,[r0]
0800D486 42B0     cmp     r0,r6
0800D488 D107     bne     800D49Ah
0800D48A 1C20     mov     r0,r4
0800D48C 1C29     mov     r1,r5
0800D48E 9200     str     r2,[sp]
0800D490 9301     str     r3,[sp,4h]
0800D492 F000F857 bl      800D544h
0800D496 9B01     ldr     r3,[sp,4h]
0800D498 9A00     ldr     r2,[sp]
0800D49A 3501     add     r5,1h
0800D49C 3438     add     r4,38h
0800D49E 429C     cmp     r4,r3
0800D4A0 D3EF     bcc     800D482h
0800D4A2 1C3E     mov     r6,r7
0800D4A4 2E08     cmp     r6,8h
0800D4A6 DDE6     ble     800D476h
0800D4A8 B002     add     sp,8h
0800D4AA BCF0     pop     r4-r7
0800D4AC BC01     pop     r0
0800D4AE 4700     bx      r0
0800D4B0 06EC     lsl     r4,r5,1Bh
0800D4B2 0300     lsl     r0,r0,0Ch
0800D4B4 01AC     lsl     r4,r5,6h
0800D4B6 0300     lsl     r0,r0,0Ch
0800D4B8 07F3     lsl     r3,r6,1Fh
0800D4BA 0300     lsl     r0,r0,0Ch
0800D4BC B5F0     push    r4-r7,lr
0800D4BE B082     add     sp,-8h
0800D4C0 2717     mov     r7,17h
0800D4C2 2603     mov     r6,3h
0800D4C4 4807     ldr     r0,=30001ACh
0800D4C6 2400     mov     r4,0h
0800D4C8 4907     ldr     r1,=30007F3h
0800D4CA 1C03     mov     r3,r0
0800D4CC 3322     add     r3,22h
0800D4CE 1C02     mov     r2,r0
0800D4D0 2517     mov     r5,17h
0800D4D2 8810     ldrh    r0,[r2]
0800D4D4 4038     and     r0,r7
0800D4D6 42B0     cmp     r0,r6
0800D4D8 D108     bne     800D4ECh
0800D4DA 7818     ldrb    r0,[r3]
0800D4DC 2808     cmp     r0,8h
0800D4DE D905     bls     800D4ECh
0800D4E0 7008     strb    r0,[r1]
0800D4E2 E004     b       800D4EEh
0800D4E4 01AC     lsl     r4,r5,6h
0800D4E6 0300     lsl     r0,r0,0Ch
0800D4E8 07F3     lsl     r3,r6,1Fh
0800D4EA 0300     lsl     r0,r0,0Ch
0800D4EC 700C     strb    r4,[r1]
0800D4EE 3101     add     r1,1h
0800D4F0 3338     add     r3,38h
0800D4F2 3238     add     r2,38h
0800D4F4 3D01     sub     r5,1h
0800D4F6 2D00     cmp     r5,0h
0800D4F8 DAEB     bge     800D4D2h
0800D4FA 2609     mov     r6,9h
0800D4FC 4B0E     ldr     r3,=30006ECh
0800D4FE 2500     mov     r5,0h
0800D500 4C0E     ldr     r4,=30001ACh
0800D502 1C77     add     r7,r6,1
0800D504 429C     cmp     r4,r3
0800D506 D210     bcs     800D52Ah
0800D508 4A0D     ldr     r2,=30007F3h
0800D50A 18A8     add     r0,r5,r2
0800D50C 7800     ldrb    r0,[r0]
0800D50E 42B0     cmp     r0,r6
0800D510 D107     bne     800D522h
0800D512 1C20     mov     r0,r4
0800D514 1C29     mov     r1,r5
0800D516 9200     str     r2,[sp]
0800D518 9301     str     r3,[sp,4h]
0800D51A F000F813 bl      800D544h
0800D51E 9B01     ldr     r3,[sp,4h]
0800D520 9A00     ldr     r2,[sp]
0800D522 3501     add     r5,1h
0800D524 3438     add     r4,38h
0800D526 429C     cmp     r4,r3
0800D528 D3EF     bcc     800D50Ah
0800D52A 1C3E     mov     r6,r7
0800D52C 2E10     cmp     r6,10h
0800D52E DDE6     ble     800D4FEh
0800D530 B002     add     sp,8h
0800D532 BCF0     pop     r4-r7
0800D534 BC01     pop     r0
0800D536 4700     bx      r0
0800D538 06EC     lsl     r4,r5,1Bh
0800D53A 0300     lsl     r0,r0,0Ch
0800D53C 01AC     lsl     r4,r5,6h
0800D53E 0300     lsl     r0,r0,0Ch
0800D540 07F3     lsl     r3,r6,1Fh
0800D542 0300     lsl     r0,r0,0Ch
0800D544 B5F0     push    r4-r7,lr
0800D546 4657     mov     r7,r10
0800D548 464E     mov     r6,r9
0800D54A 4645     mov     r5,r8
0800D54C B4E0     push    r5-r7
0800D54E B093     add     sp,-4Ch
0800D550 1C07     mov     r7,r0
0800D552 9100     str     r1,[sp]
0800D554 4A7F     ldr     r2,=3001382h
0800D556 7813     ldrb    r3,[r2]
0800D558 8AF8     ldrh    r0,[r7,16h]
0800D55A 69B9     ldr     r1,[r7,18h]
0800D55C 00C0     lsl     r0,r0,3h
0800D55E 1840     add     r0,r0,r1
0800D560 6800     ldr     r0,[r0]
0800D562 4682     mov     r10,r0
0800D564 8800     ldrh    r0,[r0]
0800D566 9002     str     r0,[sp,8h]
0800D568 2102     mov     r1,2h
0800D56A 448A     add     r10,r1
0800D56C 18C0     add     r0,r0,r3
0800D56E 287F     cmp     r0,7Fh
0800D570 DD01     ble     800D576h
0800D572 F000FC14 bl      800DD9Eh
0800D576 00D9     lsl     r1,r3,3h
0800D578 4877     ldr     r0,=3000E7Ch
0800D57A 1809     add     r1,r1,r0
0800D57C 4688     mov     r8,r1
0800D57E 8879     ldrh    r1,[r7,2h]
0800D580 0889     lsr     r1,r1,2h
0800D582 4876     ldr     r0,=30013BAh
0800D584 8800     ldrh    r0,[r0]
0800D586 0880     lsr     r0,r0,2h
0800D588 1A09     sub     r1,r1,r0
0800D58A 0409     lsl     r1,r1,10h
0800D58C 0C09     lsr     r1,r1,10h
0800D58E 910E     str     r1,[sp,38h]
0800D590 88B9     ldrh    r1,[r7,4h]
0800D592 0889     lsr     r1,r1,2h
0800D594 4872     ldr     r0,=30013B8h
0800D596 8800     ldrh    r0,[r0]
0800D598 0880     lsr     r0,r0,2h
0800D59A 1A09     sub     r1,r1,r0
0800D59C 0409     lsl     r1,r1,10h
0800D59E 0C09     lsr     r1,r1,10h
0800D5A0 910D     str     r1,[sp,34h]
0800D5A2 883A     ldrh    r2,[r7]
0800D5A4 2040     mov     r0,40h
0800D5A6 4010     and     r0,r2
0800D5A8 0400     lsl     r0,r0,10h
0800D5AA 0C00     lsr     r0,r0,10h
0800D5AC 9005     str     r0,[sp,14h]
0800D5AE 2080     mov     r0,80h
0800D5B0 4010     and     r0,r2
0800D5B2 0400     lsl     r0,r0,10h
0800D5B4 0C00     lsr     r0,r0,10h
0800D5B6 4684     mov     r12,r0
0800D5B8 2080     mov     r0,80h
0800D5BA 01C0     lsl     r0,r0,7h
0800D5BC 4010     and     r0,r2
0800D5BE 0400     lsl     r0,r0,10h
0800D5C0 0C00     lsr     r0,r0,10h
0800D5C2 9006     str     r0,[sp,18h]
0800D5C4 2080     mov     r0,80h
0800D5C6 0180     lsl     r0,r0,6h
0800D5C8 4010     and     r0,r2
0800D5CA 0400     lsl     r0,r0,10h
0800D5CC 0C00     lsr     r0,r0,10h
0800D5CE 9007     str     r0,[sp,1Ch]
0800D5D0 2080     mov     r0,80h
0800D5D2 0040     lsl     r0,r0,1h
0800D5D4 4010     and     r0,r2
0800D5D6 0400     lsl     r0,r0,10h
0800D5D8 0C00     lsr     r0,r0,10h
0800D5DA 9009     str     r0,[sp,24h]
0800D5DC 7FF9     ldrb    r1,[r7,1Fh]
0800D5DE 1C38     mov     r0,r7
0800D5E0 3020     add     r0,20h
0800D5E2 7800     ldrb    r0,[r0]
0800D5E4 1808     add     r0,r1,r0
0800D5E6 900B     str     r0,[sp,2Ch]
0800D5E8 0189     lsl     r1,r1,6h
0800D5EA 910C     str     r1,[sp,30h]
0800D5EC 1C38     mov     r0,r7
0800D5EE 3021     add     r0,21h
0800D5F0 7800     ldrb    r0,[r0]
0800D5F2 900A     str     r0,[sp,28h]
0800D5F4 485B     ldr     r0,=300002Bh
0800D5F6 7800     ldrb    r0,[r0]
0800D5F8 2800     cmp     r0,0h
0800D5FA D004     beq     800D606h
0800D5FC 9C0A     ldr     r4,[sp,28h]
0800D5FE 2C00     cmp     r4,0h
0800D600 D001     beq     800D606h
0800D602 3C01     sub     r4,1h
0800D604 940A     str     r4,[sp,28h]
0800D606 1C38     mov     r0,r7
0800D608 3032     add     r0,32h
0800D60A 7801     ldrb    r1,[r0]
0800D60C 2420     mov     r4,20h
0800D60E 1C20     mov     r0,r4
0800D610 4008     and     r0,r1
0800D612 2800     cmp     r0,0h
0800D614 D003     beq     800D61Eh
0800D616 887E     ldrh    r6,[r7,2h]
0800D618 960E     str     r6,[sp,38h]
0800D61A 88B8     ldrh    r0,[r7,4h]
0800D61C 900D     str     r0,[sp,34h]
0800D61E 2008     mov     r0,8h
0800D620 4010     and     r0,r2
0800D622 2800     cmp     r0,0h
0800D624 D000     beq     800D628h
0800D626 E189     b       800D93Ch
0800D628 9902     ldr     r1,[sp,8h]
0800D62A 18C9     add     r1,r1,r3
0800D62C 9112     str     r1,[sp,48h]
0800D62E 9A02     ldr     r2,[sp,8h]
0800D630 2A00     cmp     r2,0h
0800D632 D100     bne     800D636h
0800D634 E0D8     b       800D7E8h
0800D636 4948     ldr     r1,=3000E7Ch
0800D638 2401     mov     r4,1h
0800D63A 46A1     mov     r9,r4
0800D63C 00D8     lsl     r0,r3,3h
0800D63E 1845     add     r5,r0,r1
0800D640 9E0A     ldr     r6,[sp,28h]
0800D642 2003     mov     r0,3h
0800D644 4006     and     r6,r0
0800D646 00B1     lsl     r1,r6,2h
0800D648 9111     str     r1,[sp,44h]
0800D64A 9201     str     r2,[sp,4h]
0800D64C 4652     mov     r2,r10
0800D64E 8816     ldrh    r6,[r2]
0800D650 2302     mov     r3,2h
0800D652 449A     add     r10,r3
0800D654 4644     mov     r4,r8
0800D656 8026     strh    r6,[r4]
0800D658 4498     add     r8,r3
0800D65A 4650     mov     r0,r10
0800D65C 8803     ldrh    r3,[r0]
0800D65E 2102     mov     r1,2h
0800D660 448A     add     r10,r1
0800D662 4642     mov     r2,r8
0800D664 8013     strh    r3,[r2]
0800D666 4488     add     r8,r1
0800D668 4654     mov     r4,r10
0800D66A 8820     ldrh    r0,[r4]
0800D66C 4641     mov     r1,r8
0800D66E 8008     strh    r0,[r1]
0800D670 2202     mov     r2,2h
0800D672 4492     add     r10,r2
0800D674 4490     add     r8,r2
0800D676 9C0E     ldr     r4,[sp,38h]
0800D678 1930     add     r0,r6,r4
0800D67A 7028     strb    r0,[r5]
0800D67C 980D     ldr     r0,[sp,34h]
0800D67E 1819     add     r1,r3,r0
0800D680 4A39     ldr     r2,=1FFh
0800D682 4011     and     r1,r2
0800D684 886A     ldrh    r2,[r5,2h]
0800D686 4839     ldr     r0,=0FFFFFE00h
0800D688 4010     and     r0,r2
0800D68A 4308     orr     r0,r1
0800D68C 8068     strh    r0,[r5,2h]
0800D68E 7969     ldrb    r1,[r5,5h]
0800D690 200D     mov     r0,0Dh
0800D692 4240     neg     r0,r0
0800D694 4008     and     r0,r1
0800D696 9C11     ldr     r4,[sp,44h]
0800D698 4320     orr     r0,r4
0800D69A 0902     lsr     r2,r0,4h
0800D69C 990B     ldr     r1,[sp,2Ch]
0800D69E 1852     add     r2,r2,r1
0800D6A0 0112     lsl     r2,r2,4h
0800D6A2 210F     mov     r1,0Fh
0800D6A4 4008     and     r0,r1
0800D6A6 4310     orr     r0,r2
0800D6A8 7168     strb    r0,[r5,5h]
0800D6AA 88AA     ldrh    r2,[r5,4h]
0800D6AC 0591     lsl     r1,r2,16h
0800D6AE 0D89     lsr     r1,r1,16h
0800D6B0 9C0C     ldr     r4,[sp,30h]
0800D6B2 1909     add     r1,r1,r4
0800D6B4 4C2E     ldr     r4,=3FFh
0800D6B6 1C20     mov     r0,r4
0800D6B8 4001     and     r1,r0
0800D6BA 482E     ldr     r0,=0FFFFFC00h
0800D6BC 4010     and     r0,r2
0800D6BE 4308     orr     r0,r1
0800D6C0 80A8     strh    r0,[r5,4h]
0800D6C2 9805     ldr     r0,[sp,14h]
0800D6C4 2800     cmp     r0,0h
0800D6C6 D01E     beq     800D706h
0800D6C8 78EA     ldrb    r2,[r5,3h]
0800D6CA 06D0     lsl     r0,r2,1Bh
0800D6CC 0FC0     lsr     r0,r0,1Fh
0800D6CE 4649     mov     r1,r9
0800D6D0 4048     eor     r0,r1
0800D6D2 4008     and     r0,r1
0800D6D4 0100     lsl     r0,r0,4h
0800D6D6 2111     mov     r1,11h
0800D6D8 4249     neg     r1,r1
0800D6DA 4011     and     r1,r2
0800D6DC 4301     orr     r1,r0
0800D6DE 70E9     strb    r1,[r5,3h]
0800D6E0 7868     ldrb    r0,[r5,1h]
0800D6E2 0984     lsr     r4,r0,6h
0800D6E4 098A     lsr     r2,r1,6h
0800D6E6 00A0     lsl     r0,r4,2h
0800D6E8 1810     add     r0,r2,r0
0800D6EA 4A23     ldr     r2,=82B0C94h
0800D6EC 1880     add     r0,r0,r2
0800D6EE 7800     ldrb    r0,[r0]
0800D6F0 00C1     lsl     r1,r0,3h
0800D6F2 1859     add     r1,r3,r1
0800D6F4 9B0D     ldr     r3,[sp,34h]
0800D6F6 1A59     sub     r1,r3,r1
0800D6F8 4C1B     ldr     r4,=1FFh
0800D6FA 4021     and     r1,r4
0800D6FC 886A     ldrh    r2,[r5,2h]
0800D6FE 481B     ldr     r0,=0FFFFFE00h
