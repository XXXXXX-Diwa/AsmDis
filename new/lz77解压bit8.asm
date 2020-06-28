;r0是lz77数据地址(跳4字节) r1是要写入的内存地址

00000BA4>E35C0000 cmp     r12,0h		;检查r12是否为0 也就是5-8字节
00000BA8 0A000003 beq     @@end
00000BAC E3CCC4FE bic     r12,r12,0FE000000h	;bic该值 去除8000000 但是本来就没有啊
00000BB0 E080C00C add     r12,r0,r12			;加上数据地址
00000BB4 E310040E tst     r0,0E000000h			;按位与不保存结果,改变标志
00000BB8 131C040E tstne   r12,0E000000h			;同上,相当于检查是否有0x8000000,没有则Z标记1

@@end:
00000BBC E12FFF1E bx      r14


00000BC0 467B     mov     r3,r15
00000BC2 4718     bx      r3
00000BC4 E92D47F0 stmfd   [r13]!,r4-r10,r14
00000BC8 E1A0A582 mov     r10,r2,lsl 0Bh
00000BCC E1B0C4AA movs    r12,r10,lsr 9h
00000BD0 EBFFFFF3 bl      0BA4h
00000BD4 0A000012 beq     0C24h
00000BD8 E081A4AA add     r10,r1,r10,lsr 9h
00000BDC E1B02CA2 movs    r2,r2,lsr 19h
00000BE0 3A00000B bcc     0C14h


000010FC>E92D4070 stmfd   [r13]!,r4-r6,r14	;压栈 保存寄存器
00001100 E4905004 ldr     r5,[r0],4h		;r5读取r0 r0+4h
00001104 E1A02425 mov     r2,r5,lsr 8h		;r5给r2并且右移8h	解压后的总长度
00001108 E1B0C002 movs    r12,r2			;给r12	解压后的总长度
0000110C EBFFFEA4 bl      0BA4h
00001110 0A00001D beq     @@end				;一般来说不会跳

@@loop:
00001114 E3520000 cmp     r2,0h				;检查减压长度
00001118 DA00001B ble     @@end
0000111C E4D0E001 ldrb    r14,[r0],1h		;读取lz77数据并指针下移
00001120 E3A04008 mov     r4,8h				;r4=8 默认数据读写的长度

@@loop2:
00001124 E2544001 subs    r4,r4,1h			;然后减1
00001128 BAFFFFF9 blt     @@loop			;只有小于0才会跳转
0000112C E31E0080 tst     r14,80h			;读取的数据与80按位与仅改变标记
00001130 1A000003 bne     @@hava80			;当与80不为0则跳转 零标志位不为0跳转
00001134 E4D06001 ldrb    r6,[r0],1h		;读取数据并指针下移
00001138 E4C16001 strb    r6,[r1],1h		;数据写入内存并指针下移
0000113C E2422001 sub     r2,r2,1h			;总长度减1
00001140 EA00000D b       @@goto

@@hava80:
00001144 E5D05000 ldrb    r5,[r0]			;读取数据
00001148 E3A06003 mov     r6,3h
0000114C E0863245 add     r3,r6,r5,asr 4h	;数据算术右移4然后加上3给r3
00001150 E4D06001 ldrb    r6,[r0],1h		;再次读取上一次的数据
00001154 E206500F and     r5,r6,0Fh			;数据and0F给r5
00001158 E1A0C405 mov     r12,r5,lsl 8h		;r5左移8h给r12
0000115C E4D06001 ldrb    r6,[r0],1h		;读取数据
00001160 E186500C orr     r5,r6,r12			;和r12 orr给 r5
00001164 E285C001 add     r12,r5,1h			;r5加1给r12
00001168 E0422003 sub     r2,r2,r3			;总数-r3

@@loop3:
0000116C E751500C ldrb    r5,[r1,-r12]		;读取内存地址给r5
00001170 E4C15001 strb    r5,[r1],1h		;写进当前的内存地址然后加1
00001174 E2533001 subs    r3,r3,1h			;r3递减
00001178 CAFFFFFB bgt     @@loop3			;r3不为0就会跳转

@@goto:
0000117C E3520000 cmp     r2,0h				;检查是否为零
00001180 C1A0E08E movgt   r14,r14,lsl 1h	;首字节左移1位
00001184 CAFFFFE6 bgt     @@loop2
00001188 EAFFFFE1 b       @@loop

@@end:
0000118C E8BD4070 ldmfd   [r13]!,r4-r6,r14
00001190 E12FFF1E bx      r14