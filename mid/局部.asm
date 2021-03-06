08006D82 5E29     ldsh    r1,[r5,r0]
08006D84>20C0     mov     r0,0C0h
08006D86 4240     neg     r0,r0        ;FF40H
08006D88 4281     cmp     r1,r0        ;当前Y加速度值比较
08006D8A DA15     bge     8006DB8h     ;大于或等于则跳过
08006D8C 4809     ldr     r0,=3001588h
08006D8E 305B     add     r0,5Bh
08006D90 7800     ldrb    r0,[r0]      ;读取15e3的值
08006D92 2800     cmp     r0,0h
08006D94 D110     bne     8006DB8h     ;无重力在水中的话
08006D96 8AA0     ldrh    r0,[r4,14h]  ;读取Y坐标
08006D98 3001     add     r0,1h        ;Y坐标加1
08006D9A 0400     lsl     r0,r0,10h
08006D9C 0C00     lsr     r0,r0,10h
08006D9E 8A61     ldrh    r1,[r4,12h]  ;读取X坐标
08006DA0 F051FA5E bl      8058260h
08006DA4 2803     cmp     r0,3h
08006DA6 D007     beq     8006DB8h 
08006DA8 2001     mov     r0,1h
08006DAA 7120     strb    r0,[r4,4h]
08006DAC 2032     mov     r0,32h
08006DAE 8320     strh    r0,[r4,18h]
08006DB0 E050     b       8006E54h
08006DB2 0000     lsl     r0,r0,0h
08006DB4 1588     asr     r0,r1,16h
08006DB6 0300     lsl     r0,r0,0Ch


08006DB8 2011     mov     r0,11h
08006DBA E04A     b       8006E52h
08006DBC 4805     ldr     r0,=300137Ch
08006DBE 8800     ldrh    r0,[r0]
08006DC0 89E1     ldrh    r1,[r4,0Eh]
08006DC2 4008     and     r0,r1
08006DC4 2800     cmp     r0,0h
08006DC6 D01D     beq     8006E04h
08006DC8 2010     mov     r0,10h
08006DCA 4008     and     r0,r1
08006DCC 2800     cmp     r0,0h
08006DCE D003     beq     8006DD8h
08006DD0 20A0     mov     r0,0A0h
08006DD2 E002     b       8006DDAh
08006DD4 137C     asr     r4,r7,0Dh
08006DD6 0300     lsl     r0,r0,0Ch
08006DD8 4803     ldr     r0,=0FF60h
08006DDA 82E0     strh    r0,[r4,16h]
08006DDC 7828     ldrb    r0,[r5]
08006DDE 2822     cmp     r0,22h
08006DE0 D104     bne     8006DECh
08006DE2 2000     mov     r0,0h
08006DE4 7020     strb    r0,[r4]
08006DE6 E005     b       8006DF4h
08006DE8 FF600000 ????
08006DEA 0000     lsl     r0,r0,0h
08006DEC 2012     mov     r0,12h
08006DEE 7020     strb    r0,[r4]
08006DF0 2006     mov     r0,6h
08006DF2 7220     strb    r0,[r4,8h]
08006DF4 2001     mov     r0,1h
08006DF6 7160     strb    r0,[r4,5h]
08006DF8 20A0     mov     r0,0A0h
08006DFA 72A0     strb    r0,[r4,0Ah]
08006DFC 208B     mov     r0,8Bh
08006DFE F7FBFE0B bl      8002A18h
08006E02 E027     b       8006E54h
08006E04 201E     mov     r0,1Eh
08006E06 2101     mov     r1,1h
08006E08 F04EFAB6 bl      8055378h
08006E0C 7828     ldrb    r0,[r5]
08006E0E 2822     cmp     r0,22h
08006E10 D101     bne     8006E16h
08006E12 2023     mov     r0,23h
08006E14 E000     b       8006E18h
08006E16 2027     mov     r0,27h
08006E18 7020     strb    r0,[r4]
08006E1A 7928     ldrb    r0,[r5,4h]
08006E1C 7120     strb    r0,[r4,4h]
08006E1E 2001     mov     r0,1h
08006E20 7760     strb    r0,[r4,1Dh]
08006E22 2090     mov     r0,90h
08006E24 F7FBFDF8 bl      8002A18h
08006E28 E014     b       8006E54h
08006E2A 4805     ldr     r0,=823A554h
08006E2C 2204     mov     r2,4h
08006E2E 5E81     ldsh    r1,[r0,r2]
08006E30 1C20     mov     r0,r4
08006E32 F7FEFCDB bl      80057ECh
08006E36 0600     lsl     r0,r0,18h
08006E38 2800     cmp     r0,0h
08006E3A D003     beq     8006E44h
08006E3C 2004     mov     r0,4h
08006E3E E008     b       8006E52h
08006E40 A554     add     r5,=8006F94h
08006E42 0823     lsr     r3,r4,20h
08006E44 2116     mov     r1,16h
08006E46 5E68     ldsh    r0,[r5,r1]
08006E48 2800     cmp     r0,0h
08006E4A D101     bne     8006E50h
08006E4C 200A     mov     r0,0Ah
08006E4E E000     b       8006E52h
08006E50 2001     mov     r0,1h
08006E52 7020     strb    r0,[r4]
08006E54 78A8     ldrb    r0,[r5,2h]
08006E56 70A0     strb    r0,[r4,2h]
08006E58 7822     ldrb    r2,[r4]
08006E5A 1C01     mov     r1,r0
08006E5C 2A01     cmp     r2,1h
08006E5E D017     beq     8006E90h
08006E60 2A01     cmp     r2,1h
08006E62 DC02     bgt     8006E6Ah
08006E64 2A00     cmp     r2,0h
08006E66 D00D     beq     8006E84h
08006E68 E018     b       8006E9Ch
08006E6A 2A0A     cmp     r2,0Ah
08006E6C D116     bne     8006E9Ch
08006E6E 4804     ldr     r0,=3001588h
08006E70 305C     add     r0,5Ch
08006E72 7800     ldrb    r0,[r0]
08006E74 2800     cmp     r0,0h
08006E76 D00B     beq     8006E90h
08006E78 2001     mov     r0,1h
08006E7A 7760     strb    r0,[r4,1Dh]
08006E7C E008     b       8006E90h
08006E7E 0000     lsl     r0,r0,0h
08006E80 1588     asr     r0,r1,16h
08006E82 0300     lsl     r0,r0,0Ch
08006E84 0608     lsl     r0,r1,18h
08006E86 0E00     lsr     r0,r0,18h
08006E88 2803     cmp     r0,3h
08006E8A D101     bne     8006E90h
08006E8C 2001     mov     r0,1h
08006E8E 70A0     strb    r0,[r4,2h]
08006E90 0608     lsl     r0,r1,18h
08006E92 0E00     lsr     r0,r0,18h
08006E94 2804     cmp     r0,4h
08006E96 D101     bne     8006E9Ch
08006E98 2002     mov     r0,2h
08006E9A 70A0     strb    r0,[r4,2h]
08006E9C 1C20     mov     r0,r4
08006E9E 2100     mov     r1,0h
08006EA0 2202     mov     r2,2h
08006EA2 F7FFF9B7 bl      8006214h
08006EA6 BC30     pop     r4,r5
08006EA8 BC01     pop     r0
08006EAA 4700     bx      r0
08006EAC B570     push    r4-r6,lr
08006EAE 1C04     mov     r4,r0
08006EB0 1C0D     mov     r5,r1
08006EB2 1C16     mov     r6,r2
08006EB4 4807     ldr     r0,=3001530h
08006EB6 88C0     ldrh    r0,[r0,6h]
08006EB8 2800     cmp     r0,0h
08006EBA D100     bne     8006EBEh
08006EBC E090     b       8006FE0h
08006EBE 2200     mov     r2,0h
08006EC0 7828     ldrb    r0,[r5]
08006EC2 3810     sub     r0,10h
08006EC4 282A     cmp     r0,2Ah
08006EC6 D866     bhi     8006F96h
08006EC8 0080     lsl     r0,r0,2h
08006ECA 4903     ldr     r1,=8006EDCh
08006ECC 1840     add     r0,r0,r1
08006ECE 6800     ldr     r0,[r0]
08006ED0 4687     mov     r15,r0
08006ED2 0000     lsl     r0,r0,0h
08006ED4 1530     asr     r0,r6,14h
08006ED6 0300     lsl     r0,r0,0Ch
08006ED8 6EDC     ldr     r4,[r3,6Ch]
08006EDA 0800     lsr     r0,r0,20h
08006EDC 6F88     ldr     r0,[r1,78h]
08006EDE 0800     lsr     r0,r0,20h
08006EE0 6F88     ldr     r0,[r1,78h]
08006EE2 0800     lsr     r0,r0,20h
08006EE4 6F88     ldr     r0,[r1,78h]
08006EE6 0800     lsr     r0,r0,20h
08006EE8 6F96     ldr     r6,[r2,78h]
08006EEA 0800     lsr     r0,r0,20h
08006EEC 6F88     ldr     r0,[r1,78h]
08006EEE 0800     lsr     r0,r0,20h
08006EF0 6F96     ldr     r6,[r2,78h]
08006EF2 0800     lsr     r0,r0,20h
08006EF4 6F96     ldr     r6,[r2,78h]
08006EF6 0800     lsr     r0,r0,20h
08006EF8 6F96     ldr     r6,[r2,78h]
08006EFA 0800     lsr     r0,r0,20h
08006EFC 6F96     ldr     r6,[r2,78h]
08006EFE 0800     lsr     r0,r0,20h
08006F00 6F96     ldr     r6,[r2,78h]
08006F02 0800     lsr     r0,r0,20h
08006F04 6F96     ldr     r6,[r2,78h]
08006F06 0800     lsr     r0,r0,20h
08006F08 6F96     ldr     r6,[r2,78h]
08006F0A 0800     lsr     r0,r0,20h
08006F0C 6F88     ldr     r0,[r1,78h]
08006F0E 0800     lsr     r0,r0,20h
08006F10 6F96     ldr     r6,[r2,78h]
08006F12 0800     lsr     r0,r0,20h
08006F14 6F96     ldr     r6,[r2,78h]
08006F16 0800     lsr     r0,r0,20h
08006F18 6F96     ldr     r6,[r2,78h]
08006F1A 0800     lsr     r0,r0,20h
08006F1C 6F96     ldr     r6,[r2,78h]
08006F1E 0800     lsr     r0,r0,20h
08006F20 6F96     ldr     r6,[r2,78h]
08006F22 0800     lsr     r0,r0,20h
08006F24 6F96     ldr     r6,[r2,78h]
08006F26 0800     lsr     r0,r0,20h
08006F28 6F96     ldr     r6,[r2,78h]
08006F2A 0800     lsr     r0,r0,20h
08006F2C 6F96     ldr     r6,[r2,78h]
08006F2E 0800     lsr     r0,r0,20h
08006F30 6F88     ldr     r0,[r1,78h]
08006F32 0800     lsr     r0,r0,20h
08006F34 6F96     ldr     r6,[r2,78h]
08006F36 0800     lsr     r0,r0,20h
08006F38 6F88     ldr     r0,[r1,78h]
08006F3A 0800     lsr     r0,r0,20h
08006F3C 6F96     ldr     r6,[r2,78h]
08006F3E 0800     lsr     r0,r0,20h
08006F40 6F96     ldr     r6,[r2,78h]
08006F42 0800     lsr     r0,r0,20h
08006F44 6F96     ldr     r6,[r2,78h]
08006F46 0800     lsr     r0,r0,20h
08006F48 6F88     ldr     r0,[r1,78h]
08006F4A 0800     lsr     r0,r0,20h
08006F4C 6F96     ldr     r6,[r2,78h]
08006F4E 0800     lsr     r0,r0,20h
08006F50 6F96     ldr     r6,[r2,78h]
08006F52 0800     lsr     r0,r0,20h
08006F54 6F96     ldr     r6,[r2,78h]
08006F56 0800     lsr     r0,r0,20h
08006F58 6F96     ldr     r6,[r2,78h]
08006F5A 0800     lsr     r0,r0,20h
08006F5C 6F96     ldr     r6,[r2,78h]
08006F5E 0800     lsr     r0,r0,20h
08006F60 6F88     ldr     r0,[r1,78h]
08006F62 0800     lsr     r0,r0,20h
08006F64 6F88     ldr     r0,[r1,78h]
08006F66 0800     lsr     r0,r0,20h
08006F68 6F96     ldr     r6,[r2,78h]
08006F6A 0800     lsr     r0,r0,20h
08006F6C 6F96     ldr     r6,[r2,78h]
08006F6E 0800     lsr     r0,r0,20h
08006F70 6F8C     ldr     r4,[r1,78h]
08006F72 0800     lsr     r0,r0,20h
08006F74 6F8C     ldr     r4,[r1,78h]
08006F76 0800     lsr     r0,r0,20h
08006F78 6F8C     ldr     r4,[r1,78h]
08006F7A 0800     lsr     r0,r0,20h
08006F7C 6F96     ldr     r6,[r2,78h]
08006F7E 0800     lsr     r0,r0,20h
08006F80 6F8C     ldr     r4,[r1,78h]
