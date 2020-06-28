08011EA4 B5F0     push    r4-r7,lr
08011EA6 4647     mov     r7,r8
08011EA8 B480     push    r7
08011EAA 0600     lsl     r0,r0,18h
08011EAC 0E07     lsr     r7,r0,18h					;10
08011EAE 0609     lsl     r1,r1,18h
08011EB0 0E0E     lsr     r6,r1,18h					;精灵序号
08011EB2 4821     ldr     r0,=30006BCh
08011EB4 1C01     mov     r1,r0
08011EB6 3132     add     r1,32h					;读取冰冻时间
08011EB8 7808     ldrb    r0,[r1]
08011EBA 2800     cmp     r0,0h						;没有被冰冻则结束
08011EBC D037     beq     @@end
08011EBE 2500     mov     r5,0h
08011EC0 481E     ldr     r0,=3000140h
08011EC2 4680     mov     r8,r0						;140给r8
08011EC4 468C     mov     r12,r1					;冰冻偏移给r12
08011EC6 00E8     lsl     r0,r5,3h
08011EC8 1B40     sub     r0,r0,r5
08011ECA 00C0     lsl     r0,r0,3h					;38h 56
08011ECC 4641     mov     r1,r8
08011ECE 1842     add     r2,r0,r1
08011ED0 8811     ldrh    r1,[r2]					;检查是否死亡
08011ED2 2001     mov     r0,1h
08011ED4 4008     and     r0,r1
08011ED6 2800     cmp     r0,0h
08011ED8 D024     beq     @@pass
08011EDA 1C10     mov     r0,r2
08011EDC 3034     add     r0,34h
08011EDE 7804     ldrb    r4,[r0]
08011EE0 2080     mov     r0,80h					;检查是否是副灵
08011EE2 4020     and     r0,r4
08011EE4 2800     cmp     r0,0h
08011EE6 D01D     beq     @@pass
08011EE8 7F50     ldrb    r0,[r2,1Dh]
08011EEA 42B8     cmp     r0,r7						;检查id是否是10 (翅膀)
08011EEC D11A     bne     @@pass
08011EEE 1C10     mov     r0,r2
08011EF0 3023     add     r0,23h					;检查主精灵序号是否相同
08011EF2 7800     ldrb    r0,[r0]
08011EF4 42B0     cmp     r0,r6
08011EF6 D115     bne     @@pass
08011EF8 1C13     mov     r3,r2
08011EFA 3332     add     r3,32h
08011EFC 4660     mov     r0,r12
08011EFE 7801     ldrb    r1,[r0]					;主灵的冰冻时间
08011F00 7818     ldrb    r0,[r3]					;副灵的冰冻时间
08011F02 4288     cmp     r0,r1						;副灵大于或等则跳过
08011F04 D20E     bcs     @@pass
08011F06 2010     mov     r0,10h
08011F08 4020     and     r0,r4						;检查副灵碰撞属性是否有10h
08011F0A 2800     cmp     r0,0h
08011F0C D10A     bne     @@pass
08011F0E 7019     strb    r1,[r3]					;主灵的冰冻时间写入副灵的冰冻时间
08011F10 1C10     mov     r0,r2
08011F12 3035     add     r0,35h
08011F14 7800     ldrb    r0,[r0]					;副灵偏移35
08011F16 7FD1     ldrb    r1,[r2,1Fh]
08011F18 1840     add     r0,r0,r1					;加上gfxrow
08011F1A 210F     mov     r1,0Fh
08011F1C 1A09     sub     r1,r1,r0					;减F
08011F1E 1C10     mov     r0,r2						
08011F20 3020     add     r0,20h
08011F22 7001     strb    r1,[r0]					;写进调色板号 冰冻色

@@pass:
08011F24 1C68     add     r0,r5,1
08011F26 0600     lsl     r0,r0,18h
08011F28 0E05     lsr     r5,r0,18h
08011F2A 2D17     cmp     r5,17h
08011F2C D9CB     bls     8011EC6h

@@end:
08011F2E BC08     pop     r3
08011F30 4698     mov     r8,r3
08011F32 BCF0     pop     r4-r7
08011F34 BC01     pop     r0
08011F36 4700     bx      r0