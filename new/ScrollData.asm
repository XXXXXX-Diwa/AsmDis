08058478 B530     push    r4,r5,lr
0805847A 4908     ldr     r1,=875FD28h		;卷轴区指针table
0805847C 4808     ldr     r0,=3000054h
0805847E 7800     ldrb    r0,[r0]			;读取区号
08058480 0080     lsl     r0,r0,2h			;乘以4
08058482 1840     add     r0,r0,r1			;加上偏移
08058484 6802     ldr     r2,[r0]			;读取卷轴区数据指针
08058486 6813     ldr     r3,[r2]			;读取区第一个卷轴指针
08058488 4806     ldr     r0,=3000055h
0805848A 7819     ldrb    r1,[r3]			;读取第一个卷轴的房间号
0805848C 1C05     mov     r5,r0
0805848E 4C06     ldr     r4,=3005708h
08058490 7828     ldrb    r0,[r5]			;读取当前房间号
08058492 4281     cmp     r1,r0
08058494 D10C     bne     @@NoCurRoom
08058496 6023     str     r3,[r4]
08058498 E015     b       80584C6h
.pool

@@FF:
080584AC 6021     str     r1,[r4]
080584AE E00D     b       @@end

@@NoCurRoom:
080584B0 6811     ldr     r1,[r2]			;读取数据指针
080584B2 7808     ldrb    r0,[r1]			;房间号
080584B4 28FF     cmp     r0,0FFh			;是FF的话
080584B6 D0F9     beq     @@FF
080584B8 3204     add     r2,4h				;数据指针+4
080584BA 6811     ldr     r1,[r2]	
080584BC 7808     ldrb    r0,[r1]			;读取房间号
080584BE 782B     ldrb    r3,[r5]			
080584C0 4298     cmp     r0,r3
080584C2 D1F5     bne     @@NoCurRoom
080584C4 6021     str     r1,[r4]
080584C6 4903     ldr     r1,=30000BCh
080584C8 2003     mov     r0,3h
080584CA 7148     strb    r0,[r1,5h]

@@end:
080584CC BC30     pop     r4,r5
080584CE BC01     pop     r0
080584D0 4700     bx      r0
