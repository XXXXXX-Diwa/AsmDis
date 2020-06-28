08010CF0 B500     push    lr
08010CF2 1C02     mov     r2,r0
08010CF4 1C13     mov     r3,r2			
08010CF6 332B     add     r3,2Bh
08010CF8 7819     ldrb    r1,[r3]			;读取击晕值
08010CFA 207F     mov     r0,7Fh
08010CFC 4008     and     r0,r1
08010CFE 2800     cmp     r0,0h
08010D00 D02F     beq     @@end
08010D02 1E48     sub     r0,r1,1
08010D04 7018     strb    r0,[r3]			;减1再写入
08010D06 0600     lsl     r0,r0,18h
08010D08 0E01     lsr     r1,r0,18h
08010D0A 2003     mov     r0,3h
08010D0C 4008     and     r0,r1
08010D0E 2800     cmp     r0,0h				;检查击晕值是否不被3and
08010D10 D127     bne     @@end
08010D12 2004     mov     r0,4h
08010D14 4008     and     r0,r1				;检查是否不被4and
08010D16 2800     cmp     r0,0h
08010D18 D00C     beq     @@Pass			
08010D1A 8A90     ldrh    r0,[r2,14h]
08010D1C 2800     cmp     r0,0h				;检查血量是否为0
08010D1E D020     beq     @@end				;为零结束
08010D20 1C10     mov     r0,r2
08010D22 3033     add     r0,33h
08010D24 7800     ldrb    r0,[r0]			;不为零检查
08010D26 7FD1     ldrb    r1,[r2,1Fh]		;读取调色板值
08010D28 1840     add     r0,r0,r1			;两者想旧爱
08010D2A 210E     mov     r1,0Eh
08010D2C 1A09     sub     r1,r1,r0			;E减
08010D2E 1C10     mov     r0,r2
08010D30 3020     add     r0,20h			
08010D32 E015     b       @@Write

@@Pass:
08010D34 8A90     ldrh    r0,[r2,14h]
08010D36 2800     cmp     r0,0h
08010D38 D013     beq     @@end				;检查血如果为0则结束
08010D3A 1C10     mov     r0,r2
08010D3C 3030     add     r0,30h
08010D3E 7800     ldrb    r0,[r0]
08010D40 2800     cmp     r0,0h
08010D42 D009     beq     @@NoFrozen		;检查冰冻值
08010D44 1C10     mov     r0,r2
08010D46 3033     add     r0,33h
08010D48 7800     ldrb    r0,[r0]			;被冰冻则读取offset33
08010D4A 7FD1     ldrb    r1,[r2,1Fh]		;读取调色板号
08010D4C 1840     add     r0,r0,r1			;两者相加
08010D4E 210F     mov     r1,0Fh
08010D50 1A09     sub     r1,r1,r0			;F减
08010D52 1C10     mov     r0,r2
08010D54 3020     add     r0,20h			;写入调色板
08010D56 E003     b       @@Wirte

@@NoFrozen:
08010D58 1C10     mov     r0,r2				;其实就是击打变色值写入地址
08010D5A 3034     add     r0,34h
08010D5C 7801     ldrb    r1,[r0]			;读取offset34	
08010D5E 3814     sub     r0,14h			

@@Write:
08010D60 7001     strb    r1,[r0]			;写入offset20

@@end:
08010D62 BC01     pop     r0
08010D64 4700     bx      r0