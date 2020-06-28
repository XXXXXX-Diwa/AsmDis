;r0=1h,r1=rel压缩数据地址,r2=要写入的内存地址

08056D18 B570     push    r4-r6,lr
08056D1A B081     add     sp,-4h
08056D1C 1C0C     mov     r4,r1		;数据地址
08056D1E 1C15     mov     r5,r2		;内存地址
08056D20 0600     lsl     r0,r0,18h
08056D22 2600     mov     r6,0h
08056D24 23C0     mov     r3,0C0h
08056D26 019B     lsl     r3,r3,6h	;3000h
08056D28 2800     cmp     r0,0h
08056D2A D10D     bne     @@NoZero
08056D2C 7820     ldrb    r0,[r4]
08056D2E 2680     mov     r6,80h
08056D30 0136     lsl     r6,r6,4h	;800
08056D32 2800     cmp     r0,0h
08056D34 D005     beq     @@Zero
08056D36 2680     mov     r6,80h
08056D38 0176     lsl     r6,r6,5h	;1000
08056D3A 2803     cmp     r0,3h
08056D3C D101     bne     @@Zero
08056D3E 2680     mov     r6,80h
08056D40 01B6     lsl     r6,r6,6h	;2000

@@Zero:
08056D42 3401     add     r4,1h
08056D44 2380     mov     r3,80h
08056D46 019B     lsl     r3,r3,6h	;2000

@@NoZero:
08056D48 2010     mov     r0,10h
08056D4A 9000     str     r0,[sp]	;sp中写入10h bitsize?
08056D4C 2003     mov     r0,3h		;DMA channel
08056D4E 2100     mov     r1,0h		;值..
08056D50 1C2A     mov     r2,r5		;内存地址
08056D52 F7ACFAAF bl      80032B4h
08056D56 2300     mov     r3,0h

@@restart:
08056D58 1C2A     mov     r2,r5		;内存地址
08056D5A 2B00     cmp     r3,0h
08056D5C D000     beq     @@Pass
08056D5E 3201     add     r2,1h		;内存地址递进1??一般都是加2的

@@Pass:
08056D60 7820     ldrb    r0,[r4]	;读取压缩数据1
08056D62 3401     add     r4,1h		;地址递进  rel数据头都是01开始
08056D64 2801     cmp     r0,1h		;值不为1
08056D66 D126     bne     @@firstno1
08056D68 7821     ldrb    r1,[r4]	;读取压缩数据2
08056D6A 3401     add     r4,1h		;地址递进
08056D6C 3301     add     r3,1h		;若压缩数据第一个字节为1 r3加1
08056D6E 2900     cmp     r1,0h		;rel数据头第二个字节一般不为0
08056D70 D053     beq     @@secondzero ;基本相当于直接结束了

@@lastbecomesecond:
08056D72 2080     mov     r0,80h
08056D74 4008     and     r0,r1		;读取的数据检查是否有80
08056D76 2800     cmp     r0,0h
08056D78 D016     beq     @@secondNo80
08056D7A 207F     mov     r0,7Fh	;有80的话
08056D7C 4001     and     r1,r0		;只取小于80的部分
08056D7E 7820     ldrb    r0,[r4]	;读取第三个字节
08056D80 2800     cmp     r0,0h
08056D82 D008     beq     @@thirdzero
08056D84 2900     cmp     r1,0h		;第二字节只取小于80h的部分为0
08056D86 D008     beq     @@secondand7Fzero

@@loop:
08056D88 7820     ldrb    r0,[r4]	;再次读取第三个字节
08056D8A 7010     strb    r0,[r2]	;写入内存地址
08056D8C>3202     add     r2,2h		;内存地址递增2
08056D8E 3901     sub     r1,1h		;第二个字节and80后检查是否为1
08056D90 2900     cmp     r1,0h
08056D92 D1F9     bne     @@loop
08056D94 E001     b       @@secondand7Fzero

@@thirdzero:
08056D96 0048     lsl     r0,r1,1h	;第三个字节为0,则第二个字节(有80)代表跳过多少个内存
08056D98 1812     add     r2,r2,r0

@@secondand7Fzero:					;第二个字节有80但是仅仅只是80,没有其它的值
08056D9A 3401     add     r4,1h		;这样的话就递增到第四个值,然后第三个值如同第二个值一样被检查
08056D9C E006     b       @@secondpass

@@copy:
08056D9E 7820     ldrb    r0,[r4]	;读取第三个字节
08056DA0 7010     strb    r0,[r2]	;写进内存
08056DA2 3401     add     r4,1h		;数据地址递增
08056DA4 3202     add     r2,2h		;内存+2
08056DA6 3901     sub     r1,1h		;第二个字节减1

@@secondNo80:
08056DA8 2900     cmp     r1,0h		;检查没有80的第二个字节是否为0
08056DAA D1F8     bne     @@copy

@@secondpass:
08056DAC 7821     ldrb    r1,[r4]	;为0的话读取第三个字节
08056DAE 3401     add     r4,1h		;数据递增
08056DB0 2900     cmp     r1,0h		;检查第三个字节是否为0
08056DB2 D1DE     bne     @@lastbecomesecond	;像检查第二个字节一样检查第三个字节是否有80
08056DB4 E031     b       @@secondzero

@@firstno1:
08056DB6 7821     ldrb    r1,[r4]		;读取第二个字节
08056DB8 3401     add     r4,1h			;数据递增
08056DBA 0209     lsl     r1,r1,8h		;向左移位8bit
08056DBC 7820     ldrb    r0,[r4]		;读取第三个字节
08056DBE 4301     orr     r1,r0			;第二个字节高位和第三个字节低位合并为16bit
08056DC0 3401     add     r4,1h			;数据递增
08056DC2 3301     add     r3,1h			;若进行了2字节的读取,r3也递增
08056DC4 2900     cmp     r1,0h			;两者若都为0
08056DC6 D028     beq     @@secondzero	;基本相当于直接结束了
08056DC8 2080     mov     r0,80h
08056DCA 0200     lsl     r0,r0,8h		;8000
08056DCC 4008     and     r0,r1			;第二个字节是否有80
08056DCE 2800     cmp     r0,0h
08056DD0 D019     beq     @@SecondNo802
08056DD2 4807     ldr     r0,=7FFFh
08056DD4 4001     and     r1,r0			;去掉第二个字节的80
08056DD6 7820     ldrb    r0,[r4]		;读取第四个字节
08056DD8 2800     cmp     r0,0h
08056DDA D00B     beq     @@fourthzero
08056DDC 2900     cmp     r1,0h			;合并的去掉8000若为0
08056DDE D00B     beq     @@secondandthirdorr7Fzero

@@bit16loop:
08056DE0 7820     ldrb    r0,[r4]		;读取第四个字节
08056DE2 7010     strb    r0,[r2]		;写进内存
08056DE4 3202     add     r2,2h			;内存+2
08056DE6 3901     sub     r1,1h			;合并的数递减
08056DE8 2900     cmp     r1,0h
08056DEA D1F9     bne     @@bit16loop
08056DEC E004     b       @@secondandthirdorr7Fzero
.pool

@@fourthzero:
08056DF4 0048     lsl     r0,r1,1h
08056DF6 1812     add     r2,r2,r0

@@secondandthirdorr7Fzero:
08056DF8 3401     add     r4,1h
08056DFA E006     b       8056E0Ah
08056DFC 7820     ldrb    r0,[r4]
08056DFE 7010     strb    r0,[r2]
08056E00 3401     add     r4,1h
08056E02 3202     add     r2,2h
08056E04 3901     sub     r1,1h

@@SecondNo802:
08056E06 2900     cmp     r1,0h
08056E08 D1F8     bne     8056DFCh
08056E0A 7821     ldrb    r1,[r4]
08056E0C 3401     add     r4,1h
08056E0E 0209     lsl     r1,r1,8h
08056E10 7820     ldrb    r0,[r4]
08056E12 4301     orr     r1,r0
08056E14 3401     add     r4,1h
08056E16 2900     cmp     r1,0h
08056E18 D1D6     bne     8056DC8h

@@secondzero:
08056E1A 2B01     cmp     r3,1h		;如果中途切换了单字节和双字节则结束
08056E1C DD9C     ble     @@restart
08056E1E 1C30     mov     r0,r6
08056E20 B001     add     sp,4h
08056E22 BC70     pop     r4-r6
08056E24 BC02     pop     r1
08056E26 4708     bx      r1
