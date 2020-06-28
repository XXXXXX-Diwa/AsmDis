0804EDE4 B5F0     push    r4-r7,lr
0804EDE6 464F     mov     r7,r9
0804EDE8 4646     mov     r6,r8
0804EDEA B4C0     push    r6,r7
0804EDEC 0600     lsl     r0,r0,18h
0804EDEE 0E04     lsr     r4,r0,18h   ;弹丸类型
0804EDF0 0409     lsl     r1,r1,10h
0804EDF2 0C09     lsr     r1,r1,10h   ;弹丸Y
0804EDF4 4689     mov     r9,r1
0804EDF6 0412     lsl     r2,r2,10h
0804EDF8 0C12     lsr     r2,r2,10h   ;弹丸X
0804EDFA 4690     mov     r8,r2
0804EDFC 4B18     ldr     r3,=3000A2Ch
0804EDFE 21E0     mov     r1,0E0h
0804EE00 0049     lsl     r1,r1,1h
0804EE02 1858     add     r0,r3,r1    ;3000bech
0804EE04 4283     cmp     r3,r0
0804EE06 D235     bcs     @@DataOver
0804EE08 2501     mov     r5,1h
0804EE0A 4816     ldr     r0,=30013D4h
0804EE0C 4684     mov     r12,r0
0804EE0E 2700     mov     r7,0h
0804EE10 4915     ldr     r1,=0FFFFh
0804EE12 1C0E     mov     r6,r1

@@Loop:
0804EE14 7819     ldrb    r1,[r3]     ;读取弹丸类型
0804EE16 1C28     mov     r0,r5
0804EE18 4008     and     r0,r1       ;and 1
0804EE1A 2800     cmp     r0,0h
0804EE1C D126     bne     @@NextCheck
0804EE1E 2217     mov     r2,17h
0804EE20 2C0D     cmp     r4,0Dh
0804EE22 D900     bls     @@Pass
0804EE24 2207     mov     r2,7h

@@Pass:
0804EE26 4660     mov     r0,r12
0804EE28 89C1     ldrh    r1,[r0,0Eh] ;读取面向
0804EE2A 2010     mov     r0,10h
0804EE2C 4008     and     r0,r1
0804EE2E 2800     cmp     r0,0h
0804EE30 D001     beq     @@Left
0804EE32 2040     mov     r0,40h
0804EE34 4302     orr     r2,r0

@@Left:
0804EE36 701A     strb    r2,[r3]     ;写入属性 取向>?
0804EE38 73DC     strb    r4,[r3,0Fh]
0804EE3A 4649     mov     r1,r9
0804EE3C 8119     strh    r1,[r3,8h]  ;弹丸Y坐标写入
0804EE3E 4640     mov     r0,r8
0804EE40 8158     strh    r0,[r3,0Ah] ;弹丸X坐标写入
0804EE42 8A98     ldrh    r0,[r3,14h] ;读取上部分界
0804EE44 4330     orr     r0,r6
0804EE46 8298     strh    r0,[r3,14h]
0804EE48 82DD     strh    r5,[r3,16h]
0804EE4A 8B18     ldrh    r0,[r3,18h]
0804EE4C 4330     orr     r0,r6
0804EE4E 8318     strh    r0,[r3,18h]
0804EE50 835D     strh    r5,[r3,1Ah]
0804EE52 745F     strb    r7,[r3,11h]
0804EE54 74DF     strb    r7,[r3,13h]
0804EE56 4661     mov     r1,r12
0804EE58 7888     ldrb    r0,[r1,2h]
0804EE5A 7418     strb    r0,[r3,10h]
0804EE5C 2001     mov     r0,1h
0804EE5E E00A     b       804EE76h
0804EE60 0A2C     lsr     r4,r5,8h
0804EE62 0300     lsl     r0,r0,0Ch
0804EE64 13D4     asr     r4,r2,0Fh
0804EE66 0300     lsl     r0,r0,0Ch
0804EE68 FFFF0000 ????
0804EE6A 0000     lsl     r0,r0,0h

@@NextCheck:
0804EE6C 331C     add     r3,1Ch
0804EE6E 4805     ldr     r0,=3000BECh
0804EE70 4283     cmp     r3,r0
0804EE72 D3CF     bcc     @@Loop    

@@DataOver:
0804EE74 2000     mov     r0,0h
0804EE76 BC18     pop     r3,r4
0804EE78 4698     mov     r8,r3
0804EE7A 46A1     mov     r9,r4
0804EE7C BCF0     pop     r4-r7
0804EE7E BC02     pop     r1
0804EE80 4708     bx      r1
0804EE82 0000     lsl     r0,r0,0h
0804EE84 0BEC     lsr     r4,r5,0Fh
0804EE86 0300     lsl     r0,r0,0Ch
0804EE88 B530     push    r4,r5,lr
0804EE8A 4823     ldr     r0,=3000C72h
0804EE8C 2100     mov     r1,0h
0804EE8E 5E40     ldsh    r0,[r0,r1]
0804EE90 2802     cmp     r0,2h
0804EE92 D000     beq     804EE96h
0804EE94 E227     b       804F2E6h
0804EE96 F7B8FD47 bl      8007928h
0804EE9A 4C20     ldr     r4,=3000BECh
0804EE9C 4B20     ldr     r3,=30013D4h
0804EE9E 8A98     ldrh    r0,[r3,14h]
0804EEA0 4920     ldr     r1,=3001588h
0804EEA2 1C0A     mov     r2,r1
0804EEA4 324C     add     r2,4Ch
0804EEA6 0880     lsr     r0,r0,2h
0804EEA8 8812     ldrh    r2,[r2]
0804EEAA 1880     add     r0,r0,r2
0804EEAC 0080     lsl     r0,r0,2h
0804EEAE 8020     strh    r0,[r4]
0804EEB0 4A1D     ldr     r2,=3000BEEh
0804EEB2 8A58     ldrh    r0,[r3,12h]
0804EEB4 314A     add     r1,4Ah
0804EEB6 0880     lsr     r0,r0,2h
0804EEB8 8809     ldrh    r1,[r1]
0804EEBA 1840     add     r0,r0,r1
0804EEBC 0080     lsl     r0,r0,2h
0804EEBE 8010     strh    r0,[r2]
0804EEC0 481A     ldr     r0,=3001414h
0804EEC2 7940     ldrb    r0,[r0,5h]
0804EEC4 2810     cmp     r0,10h
0804EEC6 D11C     bne     804EF02h
0804EEC8 4819     ldr     r0,=3001530h
0804EECA 7C80     ldrb    r0,[r0,12h]
0804EECC 2802     cmp     r0,2h
0804EECE D018     beq     804EF02h
0804EED0 2400     mov     r4,0h
0804EED2 2300     mov     r3,0h
0804EED4 2501     mov     r5,1h
0804EED6 4A17     ldr     r2,=3000840h
0804EED8 7811     ldrb    r1,[r2]
0804EEDA 1C28     mov     r0,r5
0804EEDC 4008     and     r0,r1
0804EEDE 2800     cmp     r0,0h
0804EEE0 D002     beq     804EEE8h
0804EEE2 7890     ldrb    r0,[r2,2h]
0804EEE4 283B     cmp     r0,3Bh
0804EEE6 D035     beq     804EF54h
0804EEE8 320C     add     r2,0Ch
0804EEEA 3301     add     r3,1h
0804EEEC 2B0F     cmp     r3,0Fh
0804EEEE DDF3     ble     804EED8h
0804EEF0 2C00     cmp     r4,0h
0804EEF2 D106     bne     804EF02h
0804EEF4 4809     ldr     r0,=3000BECh
0804EEF6 8800     ldrh    r0,[r0]
0804EEF8 490B     ldr     r1,=3000BEEh
0804EEFA 8809     ldrh    r1,[r1]
0804EEFC 223B     mov     r2,3Bh
0804EEFE F005F8F5 bl      80540ECh
0804EF02 480A     ldr     r0,=3001414h
0804EF04 7840     ldrb    r0,[r0,1h]
0804EF06 3801     sub     r0,1h
0804EF08 2805     cmp     r0,5h
0804EF0A D900     bls     804EF0Eh
0804EF0C E1CC     b       804F2A8h
0804EF0E 0080     lsl     r0,r0,2h
0804EF10 4909     ldr     r1,=804EF3Ch
0804EF12 1840     add     r0,r0,r1
0804EF14 6800     ldr     r0,[r0]
0804EF16 4687     mov     r15,r0
0804EF18 0C72     lsr     r2,r6,11h
0804EF1A 0300     lsl     r0,r0,0Ch
0804EF1C 0BEC     lsr     r4,r5,0Fh
0804EF1E 0300     lsl     r0,r0,0Ch
0804EF20 13D4     asr     r4,r2,0Fh
0804EF22 0300     lsl     r0,r0,0Ch
0804EF24 1588     asr     r0,r1,16h
0804EF26 0300     lsl     r0,r0,0Ch
0804EF28 0BEE     lsr     r6,r5,0Fh
0804EF2A 0300     lsl     r0,r0,0Ch
0804EF2C 1414     asr     r4,r2,10h
0804EF2E 0300     lsl     r0,r0,0Ch
0804EF30 1530     asr     r0,r6,14h
0804EF32 0300     lsl     r0,r0,0Ch
0804EF34 0840     lsr     r0,r0,1h
0804EF36 0300     lsl     r0,r0,0Ch
0804EF38 EF3C     ????
0804EF3A 0804     lsr     r4,r0,20h
0804EF3C F06A0804 ????
0804EF3E 0804     lsr     r4,r0,20h
0804EF40 F1BC0804 ????
0804EF42 0804     lsr     r4,r0,20h
0804EF44 F2000804 ????
0804EF46 0804     lsr     r4,r0,20h
0804EF48 F2440804 ????
0804EF4A 0804     lsr     r4,r0,20h
0804EF4C F2740804 ????
0804EF4E 0804     lsr     r4,r0,20h
0804EF50 EF5C     ????
0804EF52 0804     lsr     r4,r0,20h
0804EF54 1C60     add     r0,r4,1
0804EF56 0600     lsl     r0,r0,18h
0804EF58 0E04     lsr     r4,r0,18h
0804EF5A E7C9     b       804EEF0h
0804EF5C 4910     ldr     r1,=3001530h
0804EF5E 7C88     ldrb    r0,[r1,12h]
0804EF60 2802     cmp     r0,2h
0804EF62 D125     bne     804EFB0h
0804EF64 200B     mov     r0,0Bh
0804EF66 2102     mov     r1,2h
0804EF68 F7FFFF14 bl      804ED94h
0804EF6C 0600     lsl     r0,r0,18h
0804EF6E 2800     cmp     r0,0h
0804EF70 D100     bne     804EF74h
0804EF72 E196     b       804F2A2h
0804EF74 480B     ldr     r0,=3000BECh
0804EF76 8801     ldrh    r1,[r0]
0804EF78 480B     ldr     r0,=3000BEEh
0804EF7A 8802     ldrh    r2,[r0]
0804EF7C 200B     mov     r0,0Bh
0804EF7E F7FFFF31 bl      804EDE4h
0804EF82 0600     lsl     r0,r0,18h
0804EF84 2800     cmp     r0,0h
0804EF86 D100     bne     804EF8Ah
0804EF88 E18B     b       804F2A2h
0804EF8A 4C08     ldr     r4,=3001414h
0804EF8C 2007     mov     r0,7h
0804EF8E 7120     strb    r0,[r4,4h]
0804EF90 F7FFFEBA bl      804ED08h
0804EF94 2004     mov     r0,4h
0804EF96 71A0     strb    r0,[r4,6h]
0804EF98 20A0     mov     r0,0A0h
0804EF9A F7B3FD3D bl      8002A18h
0804EF9E E180     b       804F2A2h
0804EFA0 1530     asr     r0,r6,14h
0804EFA2 0300     lsl     r0,r0,0Ch
0804EFA4 0BEC     lsr     r4,r5,0Fh
0804EFA6 0300     lsl     r0,r0,0Ch
0804EFA8 0BEE     lsr     r6,r5,0Fh
0804EFAA 0300     lsl     r0,r0,0Ch
0804EFAC 1414     asr     r4,r2,10h
0804EFAE 0300     lsl     r0,r0,0Ch
0804EFB0 7B49     ldrb    r1,[r1,0Dh]
0804EFB2 2008     mov     r0,8h
0804EFB4 4008     and     r0,r1
0804EFB6 2800     cmp     r0,0h
0804EFB8 D028     beq     804F00Ch
0804EFBA 240A     mov     r4,0Ah
0804EFBC 2004     mov     r0,4h
0804EFBE 4008     and     r0,r1
0804EFC0 2800     cmp     r0,0h
0804EFC2 D011     beq     804EFE8h
0804EFC4 2001     mov     r0,1h
0804EFC6 4008     and     r0,r1
0804EFC8 2800     cmp     r0,0h
0804EFCA D006     beq     804EFDAh
0804EFCC 2002     mov     r0,2h
0804EFCE 4001     and     r1,r0
0804EFD0 25F5     mov     r5,0F5h
0804EFD2 2900     cmp     r1,0h
0804EFD4 D046     beq     804F064h
0804EFD6 25F7     mov     r5,0F7h
0804EFD8 E044     b       804F064h
0804EFDA 2002     mov     r0,2h
0804EFDC 4001     and     r1,r0
0804EFDE 25F4     mov     r5,0F4h
0804EFE0 2900     cmp     r1,0h
0804EFE2 D03F     beq     804F064h
