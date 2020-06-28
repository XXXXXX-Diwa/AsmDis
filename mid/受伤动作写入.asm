08006EAC B570     push    r4-r6,lr
08006EAE 1C04     mov     r4,r0
08006EB0 1C0D     mov     r5,r1
08006EB2 1C16     mov     r6,r2
08006EB4 4807     ldr     r0,=3001530h
08006EB6 88C0     ldrh    r0,[r0,6h]
08006EB8 2800     cmp     r0,0h               ;检查当前血量
08006EBA D100     bne     @@NoDeath
08006EBC E090     b       @@HeatlhZero

@@NoDeath:
08006EBE 2200     mov     r2,0h
08006EC0 7828     ldrb    r0,[r5]             ;读取上一个姿势
08006EC2 3810     sub     r0,10h              ;减10
08006EC4 282A     cmp     r0,2Ah
08006EC6 D866     bhi     @@Pose3BBefore
08006EC8 0080     lsl     r0,r0,2h
08006ECA 4903     ldr     r1,=8006EDCh
08006ECC 1840     add     r0,r0,r1
08006ECE 6800     ldr     r0,[r0]
08006ED0 4687     mov     r15,r0
.pool
.word 0x8006F88	-0x10: Morphing	
.word 0x8006F88	-0x11: Morph Ball	
.word 0x8006F88	-0x12: Rolling	
.word 0x8006F96	-0x13: Unmorphing	
.word 0x8006F88	-0x14: Jumping/falling In Morphball	
.word 0x8006F96	-0x15: Hanging On A Ledge 向左抓住台子	
.word 0x8006F96	-0x16: Starting To Hold Your ArmCannon Out On A Ledge 向右抓住台子，炮口向斜下	
.word 0x8006F96	-0x17: Starting To Hold Your ArmCannon In On A Ledge	
.word 0x8006F96	-0x18: Holding Your ArmCannon Out On A Ledge	
.word 0x8006F96	-0x19: Shooting On A Ledge	
.word 0x8006F96	-0x1A: Pulling Yourself Up From Hanging 向上攀台	
.word 0x8006F96	-0x1B: Pulling Yourself Forward From Hanging 上面阶段2	
.word 0x8006F88	-0x1C: Pulling Yourself Into A Morphball Tunnel	
.word 0x8006F96	-0x1D: Using An Elevator	
.word 0x8006F96	-0x1E: Facing The Foreground	
.word 0x8006F96	-0x1F: Turning To/from The Foreground	
.word 0x8006F96	-0x20: Getting Held By Chozo 被雕像抓住	
.word 0x8006F96	-0x21: Delay Before Shinesparking	
.word 0x8006F96	-0x22: Shinesparking E124	
.word 0x8006F96	-0x23: Delay After Shinesparking	
.word 0x8006F96	-0x24: Spinning After Shinespark 冲刺后的旋转延迟	
.word 0x8006F88	-0x25: Delay Before Ballsparking	
.word 0x8006F96	-0x26: Ballsparking	
.word 0x8006F88	-0x27: Delay After Ballsparking	
.word 0x8006F96	-0x28: Hanging On A Zipline 抓住传送	
.word 0x8006F96	-0x29: Shooting On A Zipline	
.word 0x8006F96	-0x2A: Turning On A Zipline	
.word 0x8006F88	-0x2B: Hanging On A Zipline In Morphball	
.word 0x8006F96	-0x2C: On A Save Pad	
.word 0x8006F96	-0x2D: Downloading A Map	
.word 0x8006F96	-0x2E: Turning Around For A Map Station	
.word 0x8006F96	-0x2F: Getting Hurt	
.word 0x8006F96	-0x30: Getting Knocked Back	
.word 0x8006F88	-0x31: Getting Hurt In Morphball	
.word 0x8006F88	-0x32: Getting Knocked Back Morphball	
.word 0x8006F96	-0x33: Dying 死亡	
.word 0x8006F96	-0x34: Entering A Crawlspace 将要匍匐	
.word 0x8006F8C	-0x35: In ACrawlspace 匍匐	
.word 0x8006F8C	-0x36: Turned Around In ACrawlspace	
.word 0x8006F8C	-0x37: Crawling	
.word 0x8006F96	-0x38: Exiting A Crawlspace	
.word 0x8006F8C	-0x39: Turning Around In A Crawlspace	匍匐转身
.word 0x8006F8C	-0x3A: Shooting In A Crawlspace	



;写入球的受伤pose
08006F88 2031     mov     r0,31h
08006F8A E00D     b       WritePose

;匍匐中挨打还是匍匐
08006F8C 2100     mov     r1,0h
08006F8E 2035     mov     r0,35h
08006F90 7020     strb    r0,[r4]
08006F92 82E1     strh    r1,[r4,16h]   ;X速度写入0
08006F94 E009     b       @@Peer

@@Pose3BBefore:          
08006F96 4811     ldr     r0,=823A554h
08006F98 2204     mov     r2,4h
08006F9A 5E81     ldsh    r1,[r0,r2]
08006F9C 1C20     mov     r0,r4
08006F9E F7FEFC25 bl      80057ECh
08006FA2 0600     lsl     r0,r0,18h
08006FA4 0E02     lsr     r2,r0,18h
08006FA6 202F     mov     r0,2Fh

@@WritePose:
08006FA8 7020     strb    r0,[r4]

@@Peer:
08006FAA 2A00     cmp     r2,0h
08006FAC D003     beq     @@NoBlock
08006FAE 8AA1     ldrh    r1,[r4,14h]    ;如果上方有砖
08006FB0 203F     mov     r0,3Fh         ;Y坐标固定在3f
08006FB2 4308     orr     r0,r1
08006FB4 82A0     strh    r0,[r4,14h]

@@NoBlock:
08006FB6 7928     ldrb    r0,[r5,4h]
08006FB8 28FF     cmp     r0,0FFh
08006FBA D101     bne     @@Pass
08006FBC 2001     mov     r0,1h
08006FBE 7120     strb    r0,[r4,4h]     ;空中flag

@@Pass:
08006FC0 2070     mov     r0,70h
08006FC2 8320     strh    r0,[r4,18h]    ;Y速度写入70h
08006FC4 7868     ldrb    r0,[r5,1h]
08006FC6 2802     cmp     r0,2h          
08006FC8 D101     bne     8006FCEh
08006FCA 2038     mov     r0,38h
08006FCC 8320     strh    r0,[r4,18h]    ;之前的动作是落地或起跳则写入38Y速度
08006FCE 78A8     ldrb    r0,[r5,2h]     ;之前的炮口方向
08006FD0 70A0     strb    r0,[r4,2h]     ;写入当前的炮口方向
08006FD2 207C     mov     r0,7Ch
08006FD4 F7FBFD20 bl      8002A18h
08006FD8 E021     b       @@end
.pool

@@HeatlhZero:
08006FE0 4814     ldr     r0,=300003Dh
08006FE2 2101     mov     r1,1h
08006FE4 7001     strb    r1,[r0]
08006FE6 4814     ldr     r0,=3000029h
08006FE8 7001     strb    r1,[r0]
08006FEA 2033     mov     r0,33h
08006FEC 7020     strb    r0,[r4]
08006FEE 4913     ldr     r1,=30013B8h
08006FF0 22F0     mov     r2,0F0h
08006FF2 0052     lsl     r2,r2,1h
08006FF4 1C10     mov     r0,r2          ;1e0
08006FF6 8809     ldrh    r1,[r1]        ;读取卷轴相关 右框?
08006FF8 1840     add     r0,r0,r1       ;加上1E0
08006FFA 8A61     ldrh    r1,[r4,12h]
08006FFC 1A40     sub     r0,r0,r1       ;减去人物的X坐标,相当于人物的左边7格半?
08006FFE 0400     lsl     r0,r0,10h		 
08007000 1440     asr     r0,r0,11h		 ;除以2
08007002 82E0     strh    r0,[r4,16h]    ;写入X速度
08007004 490E     ldr     r1,=30013BAh	 
08007006 3A50     sub     r2,50h         
08007008 1C10     mov     r0,r2
0800700A 8809     ldrh    r1,[r1]
0800700C 1840     add     r0,r0,r1
0800700E 8AA1     ldrh    r1,[r4,14h]
08007010 1A40     sub     r0,r0,r1
08007012 0400     lsl     r0,r0,10h
08007014 1500     asr     r0,r0,14h
08007016 8320     strh    r0,[r4,18h]
08007018 490A     ldr     r1,=3000C72h
0800701A 2005     mov     r0,5h
0800701C 8008     strh    r0,[r1]

@@end:
0800701E 2000     mov     r0,0h
08007020 2130     mov     r1,30h
08007022 71A1     strb    r1,[r4,6h]   ;无敌时间写入30h
08007024 7220     strb    r0,[r4,8h]   ;金身时间清零
08007026 2102     mov     r1,2h
08007028 7061     strb    r1,[r4,1h]   ;空中flag
0800702A 7070     strb    r0,[r6,1h]   ;武器相关
0800702C 71B0     strb    r0,[r6,6h]   ;光束相关
0800702E BC70     pop     r4-r6
08007030 BC01     pop     r0
08007032 4700     bx      r0
.pool
