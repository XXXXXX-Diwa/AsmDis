080561E8>B570     push    r4-r6,lr
080561EA B086     add     sp,-18h
080561EC 4A18     ldr     r2,=833DFDCh			;Tileset起始指针
080561EE 4819     ldr     r0,=30000BCh			;ts号
080561F0 7801     ldrb    r1,[r0]				;读取ts号
080561F2 0088     lsl     r0,r1,2h				;四倍
080561F4 1840     add     r0,r0,r1				;五倍
080561F6 0080     lsl     r0,r0,2h				;20倍
080561F8 A901     add     r1,sp,4h				;r1=sp+4
080561FA 1880     add     r0,r0,r2				;加上偏移得到当前使用的ts数据位置
080561FC C81C     ldmia   [r0]!,r2-r4			;读取前三个
080561FE C11C     stmia   [r1]!,r2-r4			;写进sp的地址
08056200 C80C     ldmia   [r0]!,r2,r3			;读取后两个
08056202 C10C     stmia   [r1]!,r2,r3			;写进sp的地址
08056204 4814     ldr     r0,=3005450h			;存放tiletable数据指针的内存处
08056206 4A15     ldr     r2,=2004000h
08056208 6002     str     r2,[r0]				;存放指针 
0805620A 4D15     ldr     r5,=2002000h			
0805620C 6045     str     r5,[r0,4h]			;存放砖块碰撞类型数据指针
0805620E 4E15     ldr     r6,=2003000h
08056210 6086     str     r6,[r0,8h]			;存放砖块行为类型数据指针
08056212 9904     ldr     r1,[sp,10h]			;读取tiletable rom数据指针
08056214 3102     add     r1,2h					;加2为源
08056216 2380     mov     r3,80h
08056218 019B     lsl     r3,r3,6h				;2000h 长度
0805621A 2410     mov     r4,10h
0805621C 9400     str     r4,[sp]				;bit size 16字节???
0805621E 2003     mov     r0,3h
08056220 F7ACFFE0 bl      80031E4h				;数据移动
08056224 4810     ldr     r0,=3000054h
08056226 7800     ldrb    r0,[r0]				;读取区号
08056228 2807     cmp     r0,7h
0805622A D923     bls     @@NormalArea
0805622C 490F     ldr     r1,=8365C20h			;异常砖块碰撞数据地址(胡乱给个地址>?)
0805622E 2380     mov     r3,80h
08056230 00DB     lsl     r3,r3,3h				;400h
08056232 9400     str     r4,[sp]				;bit size
08056234 2003     mov     r0,3h					;DMA channl
08056236 1C2A     mov     r2,r5					;接受的内存地址
08056238 F7ACFFD4 bl      80031E4h
0805623C 490C     ldr     r1,=8365CC0h			;异常的砖块行为数据地址
0805623E 2380     mov     r3,80h
08056240 011B     lsl     r3,r3,4h				;800h
08056242 9400     str     r4,[sp]
08056244 2003     mov     r0,3h
08056246 1C32     mov     r2,r6
08056248 F7ACFFCC bl      80031E4h				;写入
0805624C E022     b       @@Peer
.pool

@@NormalArea:
08056274 4926     ldr     r1,=85D91FCh			;砖块碰撞类型数据
08056276 2380     mov     r3,80h
08056278 00DB     lsl     r3,r3,3h				;400h
0805627A 9400     str     r4,[sp]				;bit size
0805627C 2003     mov     r0,3h					
0805627E 1C2A     mov     r2,r5
08056280 F7ACFFB0 bl      80031E4h
08056284 4923     ldr     r1,=85D92ACh			;砖块行为类型数据
08056286 2380     mov     r3,80h
08056288 011B     lsl     r3,r3,4h				;800h
0805628A 9400     str     r4,[sp]
0805628C 2003     mov     r0,3h
0805628E 1C32     mov     r2,r6
08056290 F7ACFFA8 bl      80031E4h

@@Peer:
08056294 4920     ldr     r1,=83655A0h			;tiletable(>400)?
08056296 4A21     ldr     r2,=2006000h
08056298 2580     mov     r5,80h
0805629A 016D     lsl     r5,r5,5h				;1000h
0805629C 2410     mov     r4,10h
0805629E 9400     str     r4,[sp]				;bit size
080562A0 2003     mov     r0,3h
080562A2 1C2B     mov     r3,r5					
080562A4 F7ACFF9E bl      80031E4h
080562A8 491D     ldr     r1,=83654D0h			;砖块碰撞类型(>400)
080562AA 4A1E     ldr     r2,=2002400h
080562AC 2380     mov     r3,80h
080562AE 009B     lsl     r3,r3,2h				;200h
080562B0 9400     str     r4,[sp]
080562B2 2003     mov     r0,3h
080562B4 F7ACFF96 bl      80031E4h
080562B8 491B     ldr     r1,=8365330h			;砖块行为类型(>400)
080562BA 4A1C     ldr     r2,=2003800h
080562BC 2380     mov     r3,80h
080562BE 00DB     lsl     r3,r3,3h
080562C0 9400     str     r4,[sp]
080562C2 2003     mov     r0,3h
080562C4 F7ACFF8E bl      80031E4h
080562C8 9801     ldr     r0,[sp,4h]			;得到tile gfx指针
080562CA 4919     ldr     r1,=6005800h			;内存写入地址
080562CC F7AAFB1E bl      800090Ch
080562D0 9902     ldr     r1,[sp,8h]			;tile gfx调色板指针
080562D2 3120     add     r1,20h
080562D4 4A17     ldr     r2,=5000060h			;调色板地址
080562D6 23D0     mov     r3,0D0h
080562D8 005B     lsl     r3,r3,1h				;1A0
080562DA 9400     str     r4,[sp]
080562DC 2003     mov     r0,3h
080562DE F7ACFF81 bl      80031E4h
080562E2 21A0     mov     r1,0A0h
080562E4 04C9     lsl     r1,r1,13h				;500 0000
080562E6 2000     mov     r0,0h
080562E8 8008     strh    r0,[r1]				;砖块调色板(应该是公共砖块调色)
080562EA 4813     ldr     r0,=300002Dh
080562EC 7800     ldrb    r0,[r0]				;读取母舰的门flag
080562EE 2801     cmp     r0,1h
080562F0 D12C     bne     @@NoMotherShip
080562F2 4912     ldr     r1,=85DA40Ch			;母舰砖块图像数据地址?
080562F4 4A12     ldr     r2,=6004800h
080562F6 9400     str     r4,[sp]
080562F8 2003     mov     r0,3h
080562FA 1C2B     mov     r3,r5
080562FC F7ACFF72 bl      80031E4h
08056300 4910     ldr     r1,=85E0022h			;母舰砖块调色数据地址
08056302 4A11     ldr     r2,=5000002h
08056304 9400     str     r4,[sp]
08056306 2003     mov     r0,3h
08056308 235E     mov     r3,5Eh
0805630A F7ACFF6B bl      80031E4h
0805630E E02B     b       @@Peer2
.pool

@@NoMotherShip:
0805634C 4922     ldr     r1,=85D940Ch			;普通公共砖块图像数据地址
0805634E 4A23     ldr     r2,=6004800h
08056350 9400     str     r4,[sp]
08056352 2003     mov     r0,3h
08056354 1C2B     mov     r3,r5
08056356 F7ACFF45 bl      80031E4h
0805635A 4921     ldr     r1,=85DFE22h			;普通公共砖块调色数据地址
0805635C 4A21     ldr     r2,=5000002h
0805635E 9400     str     r4,[sp]
08056360 2003     mov     r0,3h
08056362 235E     mov     r3,5Eh
08056364 F7ACFF3E bl      80031E4h

@@Peer2:
08056368 4A1F     ldr     r2,=30054FCh			;和门相关的调色内存地址???
0805636A 9802     ldr     r0,[sp,8h]			;tile 调色板指针
0805636C 8800     ldrh    r0,[r0]				;读取前16bit
0805636E 2100     mov     r1,0h					
08056370 8010     strh    r0,[r2]				;写进公共调色板内存开始处
08056372 8051     strh    r1,[r2,2h]			;置零
08056374 9803     ldr     r0,[sp,0Ch]			;读取tile gfx lz77数据指针
08056376 7882     ldrb    r2,[r0,2h]			;读取第3个字节
08056378 0212     lsl     r2,r2,8h				;100h倍
0805637A 7841     ldrb    r1,[r0,1h]			;读取第2个字节
0805637C 430A     orr     r2,r1					;和刚才的数据orr(大概因为数据不与2对齐)
0805637E 491B     ldr     r1,=600FDE0h			;内存极限范围??
08056380 1A89     sub     r1,r1,r2				;减去长度
08056382 F7AAFAC3 bl      800090Ch
08056386 4A1A     ldr     r2,=600FFE0h
08056388 2020     mov     r0,20h
0805638A 9000     str     r0,[sp]				;bit size 4字节
0805638C 2003     mov     r0,3h
0805638E 2100     mov     r1,0h
08056390 2320     mov     r3,20h
08056392 F7ACFF8F bl      80032B4h				;填充
08056396 4817     ldr     r0,=3000BF0h
08056398 7800     ldrb    r0,[r0]
0805639A 0600     lsl     r0,r0,18h
0805639C 1600     asr     r0,r0,18h
0805639E 2800     cmp     r0,0h
080563A0 D115     bne     @@end					;暂停游戏flag
080563A2 4915     ldr     r1,=30000BCh			;ts号
080563A4 4A15     ldr     r2,=30056F4h
080563A6 A801     add     r0,sp,4h
080563A8 7C00     ldrb    r0,[r0,10h]			;读取动画tileset
080563AA 7050     strb    r0,[r2,1h]			;写入内存
080563AC 76C8     strb    r0,[r1,1Bh]			;写入内存
080563AE A801     add     r0,sp,4h
080563B0 7C40     ldrb    r0,[r0,11h]			;读取动画palette
080563B2 7010     strb    r0,[r2]				;写入内存
080563B4 7708     strb    r0,[r1,1Ch]			;同
080563B6 78C8     ldrb    r0,[r1,3h]
080563B8 2831     cmp     r0,31h				;BG2的属性是否为31(移动的BG2类型)
080563BA D108     bne     @@end
080563BC 4A10     ldr     r2,=6002000h
080563BE 2380     mov     r3,80h
080563C0 015B     lsl     r3,r3,5h				;1000h
080563C2 2010     mov     r0,10h
080563C4 9000     str     r0,[sp]
080563C6 2003     mov     r0,3h
080563C8 2140     mov     r1,40h
080563CA F7ACFF73 bl      80032B4h				;填充40h

@@end:
080563CE B006     add     sp,18h
080563D0 BC70     pop     r4-r6
080563D2 BC01     pop     r0
080563D4 4700     bx      r0

;lz77 bit16类型  r0源 r1写入处  (除了写入是按16bit,其他与8bit没有实质区别)
00001194>E92D47F0 stmfd   [r13]!,r4-r10,r14		;保存寄存器
00001198 E3A03000 mov     r3,0h
0000119C E4908004 ldr     r8,[r0],4h			;r8读取r0,并r0加4
000011A0 E1A0A428 mov     r10,r8,lsr 8h			;r8给r10并右移8h 解压总长度
000011A4 E3A02000 mov     r2,0h
000011A8 E1B0C00A movs    r12,r10				
000011AC EBFFFE7C bl      0BA4h					;检查是否是地址
000011B0 0A00002E beq     @@end

@@loop:
000011B4 E35A0000 cmp     r10,0h				;长度如果小于等于0也结束
000011B8 DA00002C ble     @@end					;(去掉地址后第5个字节当做第一个字节看待)
000011BC E4D06001 ldrb    r6,[r0],1h			;读取第1个字节并指针移动到第2个字节
000011C0 E3A07008 mov     r7,8h					

@@loop2:
000011C4 E2577001 subs    r7,r7,1h				;要循环8次
000011C8 BAFFFFF9 blt     @@loop
000011CC E3160080 tst     r6,80h				;读取的字节按位与仅改变标志位
000011D0 1A000006 bne     @@first80
000011D4 E4D09001 ldrb    r9,[r0],1h			;读取第2个字节并指针移动到第2个字节
000011D8 E1833219 orr     r3,r3,r9,lsl r2		;左移r2然后orr r3 (r2,r3)首次皆为0
000011DC E24AA001 sub     r10,r10,1h			;长度减1
000011E0 E2322008 eors    r2,r2,8h				;r2 亦或 8
000011E4 00C130B2 streqh  r3,[r1],2h			;若r3有高位的值,写入并且内存地址加2
000011E8 03A03000 moveq   r3,0h					;r3不为0则给予0
000011EC EA00001B b       @@Go

@@first80:
000011F0 E5D09000 ldrb    r9,[r0]				;读取第二个字节
000011F4 E3A08003 mov     r8,3h
000011F8 E0885249 add     r5,r8,r9,asr 4h		;右移4h然后加3
000011FC E4D09001 ldrb    r9,[r0],1h			;再次读取第二个字节,指针后移
00001200 E209800F and     r8,r9,0Fh				;保留低位
00001204 E1A04408 mov     r4,r8,lsl 8h			;向左移一个字节
00001208 E4D09001 ldrb    r9,[r0],1h			;读取第三个字节
0000120C E1898004 orr     r8,r9,r4				;与第二个字节的低位orr
00001210 E2884001 add     r4,r8,1h				;加1
00001214 E2628008 rsb     r8,r2,8h				;8-r2给r8
00001218 E2049001 and     r9,r4,1h				;r4 and1 给r9
0000121C E028E189 eor     r14,r8,r9,lsl 3h		;r9乘8 eor r8给r14
00001220 E04AA005 sub     r10,r10,r5			;r10减r5 r5是要写入的长度?

@@loop3:
00001224 E22EE008 eor     r14,r14,8h			;r14 eor 8
00001228 E2628008 rsb     r8,r2,8h				;r2-8给r8
0000122C E08481A8 add     r8,r4,r8,lsr 3h		;r8除8加r4给r8
00001230 E1A080A8 mov     r8,r8,lsr 1h			;r8除二
00001234 E1A08088 mov     r8,r8,lsl 1h			;r8乘2
00001238 E11190B8 ldrh    r9,[r1,-r8]			;读取内存r8前偏移的值
0000123C E3A080FF mov     r8,0FFh				;r8给0FFh
00001240 E0098E18 and     r8,r9,r8,lsl r14		;r8lsl r14
00001244 E1A08E58 mov     r8,r8,asr r14
00001248 E1833218 orr     r3,r3,r8,lsl r2
0000124C E2322008 eors    r2,r2,8h
00001250 00C130B2 streqh  r3,[r1],2h
00001254 03A03000 moveq   r3,0h
00001258 E2555001 subs    r5,r5,1h
0000125C CAFFFFF0 bgt     @@loop3				;r5不为0跳转

@@Go:
00001260 E35A0000 cmp     r10,0h
00001264 C1A06086 movgt   r6,r6,lsl 1h		;r6乘以2?
00001268 CAFFFFD5 bgt     @@loop2			;有负大于??
0000126C EAFFFFD0 b       @@loop

@@end:
00001270 E8BD47F0 ldmfd   [r13]!,r4-r10,r14
00001274 E12FFF1E bx      r14
