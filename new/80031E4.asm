080031E4 B5F0     push    r4-r7,lr
080031E6 4657     mov     r7,r10
080031E8 464E     mov     r6,r9
080031EA 4645     mov     r5,r8
080031EC B4E0     push    r5-r7
080031EE B081     add     sp,-4h
080031F0 1C0D     mov     r5,r1			;数据源
080031F2 1C16     mov     r6,r2			;写入内存地址
080031F4 9909     ldr     r1,[sp,24h]	;bit size
080031F6 0600     lsl     r0,r0,18h
080031F8 0E04     lsr     r4,r0,18h		;DMA channl
080031FA 0609     lsl     r1,r1,18h
080031FC 0E09     lsr     r1,r1,18h		;bit size
080031FE 0060     lsl     r0,r4,1h		;两倍
08003200 1900     add     r0,r0,r4		;三倍
08003202 0080     lsl     r0,r0,2h		;十二倍
08003204 4F03     ldr     r7,=40000B0h
08003206 19C2     add     r2,r0,r7		;加上偏移
08003208 2920     cmp     r1,20h		;32bit size
0800320A D105     bne     @@No16bitsize
0800320C 2080     mov     r0,80h
0800320E 04C0     lsl     r0,r0,13h		;400 0000
08003210 E003     b       @@Peer
.pool

@@No16bitsize:
08003218 2000     mov     r0,0h

@@Peer:
0800321A 9000     str     r0,[sp]		;写入sp 0或400 0000
0800321C 0060     lsl     r0,r4,1h		;DMA 二倍
0800321E 2780     mov     r7,80h
08003220 013F     lsl     r7,r7,4h		;800h
08003222 46BC     mov     r12,r7		;给r12
08003224 0909     lsr     r1,r1,4h		;bit size除以16
08003226 468A     mov     r10,r1		;给r10
08003228 410F     asr     r7,r1			;800h右移 size值
0800322A 2180     mov     r1,80h
0800322C 0609     lsl     r1,r1,18h		;8000 0000
0800322E 4688     mov     r8,r1			;给r8
08003230 430F     orr     r7,r1			;8000 0800 或8000 0400
08003232 1900     add     r0,r0,r4		;DMA三倍
08003234 0080     lsl     r0,r0,2h		;DMA十二倍
08003236 4681     mov     r9,r0			;给r9
08003238 4563     cmp     r3,r12		;定义的长度和800h比较
0800323A D91B     bls     @@lessThan800
0800323C 6015     str     r5,[r2]		;数据源写入内存首地址
0800323E 6056     str     r6,[r2,4h]	;写入的内存地址写入
08003240 9800     ldr     r0,[sp]		;bit16 偏移
08003242 4338     orr     r0,r7			;orr偏移
08003244 6090     str     r0,[r2,8h]	;写入
08003246 6890     ldr     r0,[r2,8h]
08003248 4908     ldr     r1,=40000B0h
0800324A 4449     add     r1,r9			;DMA的十二倍加上40000B0
0800324C 6888     ldr     r0,[r1,8h]	;读取
0800324E 4644     mov     r4,r8
08003250 4020     and     r0,r4			;检查是否是地址???
08003252 2800     cmp     r0,0h
08003254 D005     beq     @@NAddress
08003256 2480     mov     r4,80h
08003258 0624     lsl     r4,r4,18h

@@Loop:
0800325A 6888     ldr     r0,[r1,8h]	;再次检查是否是地址
0800325C 4020     and     r0,r4
0800325E 2800     cmp     r0,0h
08003260 D1FB     bne     @@Loop

@@NoAddress:
08003262 4803     ldr     r0,=0FFFFF800h
08003264 181B     add     r3,r3,r0
08003266 4465     add     r5,r12
08003268 4466     add     r6,r12
0800326A E7E5     b       8003238h
.pool

@@lessThan800:
08003274 6015     str     r5,[r2]
08003276 6056     str     r6,[r2,4h]
08003278 4651     mov     r1,r10
0800327A 40CB     lsr     r3,r1
0800327C 4644     mov     r4,r8
0800327E 4323     orr     r3,r4
08003280 9800     ldr     r0,[sp]
08003282 4318     orr     r0,r3
08003284 6090     str     r0,[r2,8h]
08003286 6890     ldr     r0,[r2,8h]
08003288 4909     ldr     r1,=40000B0h
0800328A 4449     add     r1,r9
0800328C 6888     ldr     r0,[r1,8h]
0800328E 4020     and     r0,r4
08003290 2800     cmp     r0,0h
08003292 D005     beq     80032A0h
08003294 2280     mov     r2,80h
08003296 0612     lsl     r2,r2,18h
08003298 6888     ldr     r0,[r1,8h]
0800329A 4010     and     r0,r2
0800329C 2800     cmp     r0,0h
0800329E D1FB     bne     8003298h
080032A0 B001     add     sp,4h
080032A2 BC38     pop     r3-r5
080032A4 4698     mov     r8,r3
080032A6 46A1     mov     r9,r4
080032A8 46AA     mov     r10,r5
080032AA BCF0     pop     r4-r7
080032AC BC01     pop     r0
080032AE 4700     bx      r0





080032B4 B5F0     push    r4-r7,lr
080032B6 4657     mov     r7,r10
080032B8 464E     mov     r6,r9
080032BA 4645     mov     r5,r8
080032BC B4E0     push    r5-r7
080032BE B082     add     sp,-8h
080032C0 9101     str     r1,[sp,4h]
080032C2 1C16     mov     r6,r2
080032C4 990A     ldr     r1,[sp,28h]
080032C6 0600     lsl     r0,r0,18h
080032C8 0E04     lsr     r4,r0,18h
080032CA 0609     lsl     r1,r1,18h
080032CC 0E09     lsr     r1,r1,18h
080032CE 0060     lsl     r0,r4,1h
080032D0 1900     add     r0,r0,r4
080032D2 0080     lsl     r0,r0,2h
080032D4 4D03     ldr     r5,=40000B0h
080032D6 1942     add     r2,r0,r5
080032D8 2920     cmp     r1,20h
080032DA D105     bne     80032E8h
080032DC 2080     mov     r0,80h
080032DE 04C0     lsl     r0,r0,13h
080032E0 E003     b       80032EAh
080032E2 0000     lsl     r0,r0,0h
080032E4 00B0     lsl     r0,r6,2h
080032E6 0400     lsl     r0,r0,10h
080032E8 2000     mov     r0,0h
080032EA 9000     str     r0,[sp]
080032EC 0060     lsl     r0,r4,1h
080032EE 2580     mov     r5,80h
080032F0 012D     lsl     r5,r5,4h
080032F2 46A9     mov     r9,r5
080032F4 AF01     add     r7,sp,4h
080032F6 0909     lsr     r1,r1,4h
080032F8 4688     mov     r8,r1
080032FA 410D     asr     r5,r1
080032FC 2181     mov     r1,81h
080032FE 0609     lsl     r1,r1,18h
08003300 430D     orr     r5,r1
08003302 1900     add     r0,r0,r4
08003304 0080     lsl     r0,r0,2h
08003306 4684     mov     r12,r0
08003308 4C07     ldr     r4,=40000B0h
0800330A 46A2     mov     r10,r4
0800330C 454B     cmp     r3,r9
0800330E D917     bls     8003340h
08003310 6017     str     r7,[r2]
08003312 6056     str     r6,[r2,4h]
08003314 9800     ldr     r0,[sp]
08003316 4328     orr     r0,r5
08003318 6090     str     r0,[r2,8h]
0800331A 6890     ldr     r0,[r2,8h]
0800331C 4661     mov     r1,r12
0800331E 4451     add     r1,r10
08003320 6888     ldr     r0,[r1,8h]
08003322 2480     mov     r4,80h
08003324 0624     lsl     r4,r4,18h
08003326 E002     b       800332Eh
08003328 00B0     lsl     r0,r6,2h
0800332A 0400     lsl     r0,r0,10h
0800332C 6888     ldr     r0,[r1,8h]
0800332E 4020     and     r0,r4
08003330 2800     cmp     r0,0h
08003332 D1FB     bne     800332Ch
08003334 4801     ldr     r0,=0FFFFF800h
08003336 181B     add     r3,r3,r0
08003338 444E     add     r6,r9
0800333A E7E7     b       800330Ch
0800333C F800FFFF ????
0800333E FFFF6017 ????
08003340 6017     str     r7,[r2]
08003342 6056     str     r6,[r2,4h]
08003344 4641     mov     r1,r8
08003346 40CB     lsr     r3,r1
08003348 2481     mov     r4,81h
0800334A 0624     lsl     r4,r4,18h
0800334C 4323     orr     r3,r4
0800334E 9800     ldr     r0,[sp]
08003350 4318     orr     r0,r3
08003352 6090     str     r0,[r2,8h]
08003354 6890     ldr     r0,[r2,8h]
08003356 4661     mov     r1,r12
08003358 4451     add     r1,r10
0800335A 6888     ldr     r0,[r1,8h]
0800335C 2580     mov     r5,80h
0800335E 062D     lsl     r5,r5,18h
08003360 4028     and     r0,r5
08003362 2800     cmp     r0,0h
08003364 D004     beq     8003370h
08003366 1C2A     mov     r2,r5
08003368 6888     ldr     r0,[r1,8h]
0800336A 4010     and     r0,r2
0800336C 2800     cmp     r0,0h
0800336E D1FB     bne     8003368h
08003370 B002     add     sp,8h
08003372 BC38     pop     r3-r5
08003374 4698     mov     r8,r3
08003376 46A1     mov     r9,r4
08003378 46AA     mov     r10,r5
0800337A BCF0     pop     r4-r7
0800337C BC01     pop     r0
0800337E 4700     bx      r0
08003380 B510     push    r4,lr
08003382 4B11     ldr     r3,=3001D00h
08003384 7C18     ldrb    r0,[r3,10h]
08003386 3001     add     r0,1h
08003388 7418     strb    r0,[r3,10h]
0800338A 0600     lsl     r0,r0,18h
0800338C 0E00     lsr     r0,r0,18h
0800338E 7B99     ldrb    r1,[r3,0Eh]
08003390 4288     cmp     r0,r1
08003392 D115     bne     80033C0h
08003394 480D     ldr     r0,=40000C4h
08003396 490E     ldr     r1,=84400004h
08003398 6001     str     r1,[r0]
0800339A 300C     add     r0,0Ch
0800339C 6001     str     r1,[r0]
0800339E 4A0D     ldr     r2,=40000C6h
080033A0 24A0     mov     r4,0A0h
080033A2 00E4     lsl     r4,r4,3h
080033A4 1C20     mov     r0,r4
080033A6 8010     strh    r0,[r2]
080033A8 490B     ldr     r1,=40000D2h
080033AA 8008     strh    r0,[r1]
080033AC 24B6     mov     r4,0B6h
080033AE 0224     lsl     r4,r4,8h
080033B0 1C20     mov     r0,r4
080033B2 8010     strh    r0,[r2]
080033B4 22F6     mov     r2,0F6h
080033B6 0212     lsl     r2,r2,8h
080033B8 1C10     mov     r0,r2
080033BA 8008     strh    r0,[r1]
080033BC 2000     mov     r0,0h
080033BE 7418     strb    r0,[r3,10h]
080033C0 BC10     pop     r4
080033C2 BC01     pop     r0
080033C4 4700     bx      r0
080033C6 0000     lsl     r0,r0,0h
080033C8 1D00     add     r0,r0,4
080033CA 0300     lsl     r0,r0,0Ch
080033CC 00C4     lsl     r4,r0,3h
080033CE 0400     lsl     r0,r0,10h
080033D0 0004     lsl     r4,r0,0h
080033D2 8440     strh    r0,[r0,22h]
080033D4 00C6     lsl     r6,r0,3h
080033D6 0400     lsl     r0,r0,10h
080033D8 00D2     lsl     r2,r2,3h
080033DA 0400     lsl     r0,r0,10h
080033DC B530     push    r4,r5,lr
080033DE B081     add     sp,-4h
080033E0 4D17     ldr     r5,=3001D00h
080033E2 786C     ldrb    r4,[r5,1h]
080033E4 2C00     cmp     r4,0h
080033E6 D127     bne     8003438h
080033E8 2001     mov     r0,1h
080033EA 7068     strb    r0,[r5,1h]
080033EC 4815     ldr     r0,=4000064h
080033EE 2280     mov     r2,80h
080033F0 0212     lsl     r2,r2,8h
080033F2 1C11     mov     r1,r2
080033F4 8001     strh    r1,[r0]
080033F6 3005     add     r0,5h
080033F8 2208     mov     r2,8h
080033FA 7002     strb    r2,[r0]
080033FC 3003     add     r0,3h
080033FE 8001     strh    r1,[r0]
08003400 3004     add     r0,4h
08003402 7004     strb    r4,[r0]
08003404 3009     add     r0,9h
08003406 7002     strb    r2,[r0]
08003408 3003     add     r0,3h
0800340A 8001     strh    r1,[r0]
0800340C 3048     add     r0,48h
0800340E 490E     ldr     r1,=84400004h
08003410 6001     str     r1,[r0]
08003412 300C     add     r0,0Ch
08003414 6001     str     r1,[r0]
08003416 380A     sub     r0,0Ah
08003418 22A0     mov     r2,0A0h
0800341A 00D2     lsl     r2,r2,3h
0800341C 1C11     mov     r1,r2
0800341E 8001     strh    r1,[r0]
08003420 300C     add     r0,0Ch
08003422 8001     strh    r1,[r0]
08003424 9400     str     r4,[sp]
08003426 4809     ldr     r0,=0C24h
08003428 1829     add     r1,r5,r0
0800342A 4A09     ldr     r2,=5000300h
0800342C 4668     mov     r0,r13
0800342E F001FEB1 bl      8005194h
08003432 4808     ldr     r0,=4000084h
08003434 7004     strb    r4,[r0]
08003436 706C     strb    r4,[r5,1h]
08003438 B001     add     sp,4h
0800343A BC30     pop     r4,r5
0800343C BC01     pop     r0
0800343E 4700     bx      r0
08003440 1D00     add     r0,r0,4
08003442 0300     lsl     r0,r0,0Ch
08003444 0064     lsl     r4,r4,1h
08003446 0400     lsl     r0,r0,10h
08003448 0004     lsl     r4,r0,0h
0800344A 8440     strh    r0,[r0,22h]
0800344C 0C24     lsr     r4,r4,10h
0800344E 0000     lsl     r0,r0,0h
08003450 0300     lsl     r0,r0,0Ch
08003452 0500     lsl     r0,r0,14h
08003454 0084     lsl     r4,r0,2h
08003456 0400     lsl     r0,r0,10h
08003458 B530     push    r4,r5,lr
0800345A B081     add     sp,-4h
0800345C 4D0E     ldr     r5,=3001D00h
0800345E 786C     ldrb    r4,[r5,1h]
08003460 2C00     cmp     r4,0h
08003462 D115     bne     8003490h
08003464 2001     mov     r0,1h
08003466 7068     strb    r0,[r5,1h]
08003468 480C     ldr     r0,=40000C4h
0800346A 490D     ldr     r1,=84400004h
0800346C 6001     str     r1,[r0]
0800346E 300C     add     r0,0Ch
08003470 6001     str     r1,[r0]
08003472 380A     sub     r0,0Ah
08003474 22A0     mov     r2,0A0h
08003476 00D2     lsl     r2,r2,3h
08003478 1C11     mov     r1,r2
0800347A 8001     strh    r1,[r0]
0800347C 300C     add     r0,0Ch
0800347E 8001     strh    r1,[r0]
08003480 9400     str     r4,[sp]
08003482 4808     ldr     r0,=0C24h
08003484 1829     add     r1,r5,r0
08003486 4A08     ldr     r2,=5000300h
08003488 4668     mov     r0,r13
0800348A F001FE83 bl      8005194h
0800348E 706C     strb    r4,[r5,1h]
08003490 B001     add     sp,4h
08003492 BC30     pop     r4,r5
08003494 BC01     pop     r0
08003496 4700     bx      r0
08003498 1D00     add     r0,r0,4
0800349A 0300     lsl     r0,r0,0Ch
0800349C 00C4     lsl     r4,r0,3h
0800349E 0400     lsl     r0,r0,10h
080034A0 0004     lsl     r4,r0,0h
080034A2 8440     strh    r0,[r0,22h]
080034A4 0C24     lsr     r4,r4,10h
080034A6 0000     lsl     r0,r0,0h
080034A8 0300     lsl     r0,r0,0Ch
080034AA 0500     lsl     r0,r0,14h
080034AC B5F0     push    r4-r7,lr
080034AE 4657     mov     r7,r10
080034B0 464E     mov     r6,r9
080034B2 4645     mov     r5,r8
080034B4 B4E0     push    r5-r7
080034B6 B083     add     sp,-0Ch
080034B8 0600     lsl     r0,r0,18h
080034BA 0E00     lsr     r0,r0,18h
080034BC 9000     str     r0,[sp]
080034BE 2300     mov     r3,0h
080034C0 2001     mov     r0,1h
080034C2 9900     ldr     r1,[sp]
080034C4 2900     cmp     r1,0h
080034C6 D100     bne     80034CAh
080034C8 2002     mov     r0,2h
080034CA 1C02     mov     r2,r0
080034CC 4817     ldr     r0,=9h
080034CE 0400     lsl     r0,r0,10h
080034D0 0C00     lsr     r0,r0,10h
080034D2 4282     cmp     r2,r0
080034D4 D271     bcs     80035BAh
080034D6 9001     str     r0,[sp,4h]
080034D8 2A02     cmp     r2,2h
080034DA D102     bne     80034E2h
080034DC 9800     ldr     r0,[sp]
080034DE 2800     cmp     r0,0h
080034E0 D008     beq     80034F4h
080034E2 21A5     mov     r1,0A5h
080034E4 0049     lsl     r1,r1,1h
080034E6 4111     asr     r1,r2
080034E8 2001     mov     r0,1h
080034EA 4001     and     r1,r0
080034EC 1C50     add     r0,r2,1
080034EE 4682     mov     r10,r0
080034F0 2900     cmp     r1,0h
080034F2 D05C     beq     80035AEh
080034F4 480E     ldr     r0,=808F254h
080034F6 0051     lsl     r1,r2,1h
080034F8 1889     add     r1,r1,r2
080034FA 0089     lsl     r1,r1,2h
080034FC 1809     add     r1,r1,r0
080034FE 680E     ldr     r6,[r1]
08003500 7F30     ldrb    r0,[r6,1Ch]
08003502 3201     add     r2,1h
08003504 4692     mov     r10,r2
08003506 2800     cmp     r0,0h
08003508 D151     bne     80035AEh
0800350A 2201     mov     r2,1h
0800350C 7732     strb    r2,[r6,1Ch]
0800350E 7FB1     ldrb    r1,[r6,1Eh]
08003510 1C10     mov     r0,r2
08003512 4008     and     r0,r1
08003514 2800     cmp     r0,0h
08003516 D148     bne     80035AAh
08003518 7831     ldrb    r1,[r6]
0800351A 2002     mov     r0,2h
0800351C 4008     and     r0,r1
0800351E 2800     cmp     r0,0h
08003520 D043     beq     80035AAh
08003522 77B2     strb    r2,[r6,1Eh]
08003524 2100     mov     r1,0h
08003526 69B4     ldr     r4,[r6,18h]
08003528 E03C     b       80035A4h
0800352A 0000     lsl     r0,r0,0h
0800352C 0009     lsl     r1,r1,0h
0800352E 0000     lsl     r0,r0,0h
08003530 F2540808 ????
08003532 0808     lsr     r0,r1,20h
08003534 1C20     mov     r0,r4
08003536 3034     add     r0,34h
08003538 7802     ldrb    r2,[r0]
0800353A 20C0     mov     r0,0C0h
0800353C 4010     and     r0,r2
0800353E 3101     add     r1,1h
08003540 4688     mov     r8,r1
08003542 2150     mov     r1,50h
08003544 1909     add     r1,r1,r4
08003546 4689     mov     r9,r1
08003548 2800     cmp     r0,0h
0800354A D127     bne     800359Ch
0800354C 6CE0     ldr     r0,[r4,4Ch]
0800354E 2800     cmp     r0,0h
08003550 D008     beq     8003564h
08003552 2107     mov     r1,7h
08003554 4011     and     r1,r2
08003556 3901     sub     r1,1h
08003558 0609     lsl     r1,r1,18h
0800355A 0E09     lsr     r1,r1,18h
0800355C 9302     str     r3,[sp,8h]
0800355E F7FEFFAF bl      80024C0h
08003562 9B02     ldr     r3,[sp,8h]
08003564 6CA0     ldr     r0,[r4,48h]
08003566 2800     cmp     r0,0h
08003568 D018     beq     800359Ch
0800356A 1C04     mov     r4,r0
0800356C 4F17     ldr     r7,=3003834h
0800356E 2500     mov     r5,0h
08003570 00D8     lsl     r0,r3,3h
08003572 1AC0     sub     r0,r0,r3
08003574 00C0     lsl     r0,r0,3h
08003576 19C0     add     r0,r0,r7
08003578 C010     stmia   [r0]!,r4
0800357A 1C21     mov     r1,r4
0800357C 2234     mov     r2,34h
0800357E 9302     str     r3,[sp,8h]
08003580 F089F89C bl      808C6BCh
08003584 9B02     ldr     r3,[sp,8h]
08003586 1C58     add     r0,r3,1
08003588 0600     lsl     r0,r0,18h
0800358A 0E03     lsr     r3,r0,18h
0800358C 7025     strb    r5,[r4]
0800358E 62A5     str     r5,[r4,28h]
08003590 6B20     ldr     r0,[r4,30h]
08003592 6325     str     r5,[r4,30h]
08003594 62E5     str     r5,[r4,2Ch]
08003596 1C04     mov     r4,r0
08003598 2C00     cmp     r4,0h
0800359A D1E9     bne     8003570h
0800359C 4641     mov     r1,r8
0800359E 0608     lsl     r0,r1,18h
080035A0 0E01     lsr     r1,r0,18h
080035A2 464C     mov     r4,r9
080035A4 7870     ldrb    r0,[r6,1h]
080035A6 4281     cmp     r1,r0
080035A8 D3C4     bcc     8003534h
080035AA 2000     mov     r0,0h
080035AC 7730     strb    r0,[r6,1Ch]
080035AE 4651     mov     r1,r10
080035B0 0608     lsl     r0,r1,18h
080035B2 0E02     lsr     r2,r0,18h
080035B4 9801     ldr     r0,[sp,4h]
080035B6 4282     cmp     r2,r0
080035B8 D38E     bcc     80034D8h
080035BA B003     add     sp,0Ch
080035BC BC38     pop     r3-r5
080035BE 4698     mov     r8,r3
080035C0 46A1     mov     r9,r4
080035C2 46AA     mov     r10,r5
080035C4 BCF0     pop     r4-r7
080035C6 BC01     pop     r0
080035C8 4700     bx      r0
080035CA 0000     lsl     r0,r0,0h
080035CC 3834     sub     r0,34h
080035CE 0300     lsl     r0,r0,0Ch
080035D0 B5F0     push    r4-r7,lr
080035D2 4657     mov     r7,r10
080035D4 464E     mov     r6,r9
080035D6 4645     mov     r5,r8
080035D8 B4E0     push    r5-r7
080035DA B082     add     sp,-8h
080035DC 0600     lsl     r0,r0,18h
080035DE 0E00     lsr     r0,r0,18h
080035E0 9000     str     r0,[sp]
080035E2 2000     mov     r0,0h
080035E4 4681     mov     r9,r0
080035E6 2001     mov     r0,1h
080035E8 9900     ldr     r1,[sp]
080035EA 2900     cmp     r1,0h
080035EC D100     bne     80035F0h
080035EE 2002     mov     r0,2h
080035F0 1C02     mov     r2,r0
080035F2 4816     ldr     r0,=9h
080035F4 0400     lsl     r0,r0,10h
080035F6 0C00     lsr     r0,r0,10h
080035F8 4282     cmp     r2,r0
080035FA D25E     bcs     80036BAh
080035FC 9001     str     r0,[sp,4h]
080035FE 2A02     cmp     r2,2h
08003600 D102     bne     8003608h
08003602 9800     ldr     r0,[sp]
08003604 2800     cmp     r0,0h
08003606 D008     beq     800361Ah
08003608 20A5     mov     r0,0A5h
0800360A 0040     lsl     r0,r0,1h
0800360C 4110     asr     r0,r2
0800360E 2101     mov     r1,1h
08003610 4008     and     r0,r1
08003612 1C51     add     r1,r2,1
08003614 468A     mov     r10,r1
08003616 2800     cmp     r0,0h
08003618 D049     beq     80036AEh
0800361A 480D     ldr     r0,=808F254h
0800361C 0051     lsl     r1,r2,1h
0800361E 1889     add     r1,r1,r2
08003620 0089     lsl     r1,r1,2h
08003622 1809     add     r1,r1,r0
08003624 680D     ldr     r5,[r1]
08003626 7F28     ldrb    r0,[r5,1Ch]
08003628 3201     add     r2,1h
0800362A 4692     mov     r10,r2
0800362C 2800     cmp     r0,0h
0800362E D13E     bne     80036AEh
08003630 2001     mov     r0,1h
08003632 7728     strb    r0,[r5,1Ch]
08003634 7FA9     ldrb    r1,[r5,1Eh]
08003636 2001     mov     r0,1h
08003638 4008     and     r0,r1
0800363A 2800     cmp     r0,0h
0800363C D035     beq     80036AAh
0800363E 20FE     mov     r0,0FEh
08003640 4008     and     r0,r1
08003642 77A8     strb    r0,[r5,1Eh]
08003644 2300     mov     r3,0h
08003646 69AA     ldr     r2,[r5,18h]
08003648 E02C     b       80036A4h
0800364A 0000     lsl     r0,r0,0h
0800364C 0009     lsl     r1,r1,0h
0800364E 0000     lsl     r0,r0,0h
08003650 F2540808 ????
08003652 0808     lsr     r0,r1,20h
08003654 1C10     mov     r0,r2
08003656 3034     add     r0,34h
08003658 7801     ldrb    r1,[r0]
0800365A 20C0     mov     r0,0C0h
0800365C 4008     and     r0,r1
0800365E 1C5E     add     r6,r3,1
08003660 1C17     mov     r7,r2
08003662 3750     add     r7,50h
08003664 2800     cmp     r0,0h
08003666 D11A     bne     800369Eh
08003668 6C90     ldr     r0,[r2,48h]
0800366A 2800     cmp     r0,0h
0800366C D017     beq     800369Eh
0800366E 1C04     mov     r4,r0
08003670 4816     ldr     r0,=3003834h
08003672 4680     mov     r8,r0
08003674 1C20     mov     r0,r4
08003676 F7FEFD15 bl      80020A4h
0800367A 4648     mov     r0,r9
0800367C 00C1     lsl     r1,r0,3h
0800367E 1A09     sub     r1,r1,r0
08003680 00C9     lsl     r1,r1,3h
08003682 4441     add     r1,r8
08003684 3104     add     r1,4h
08003686 1C20     mov     r0,r4
08003688 2234     mov     r2,34h
0800368A F089F817 bl      808C6BCh
0800368E 4648     mov     r0,r9
08003690 3001     add     r0,1h
08003692 0600     lsl     r0,r0,18h
08003694 0E00     lsr     r0,r0,18h
08003696 4681     mov     r9,r0
08003698 6B24     ldr     r4,[r4,30h]
0800369A 2C00     cmp     r4,0h
0800369C D1EA     bne     8003674h
0800369E 0630     lsl     r0,r6,18h
080036A0 0E03     lsr     r3,r0,18h
080036A2 1C3A     mov     r2,r7
080036A4 7869     ldrb    r1,[r5,1h]
080036A6 428B     cmp     r3,r1
080036A8 D3D4     bcc     8003654h
080036AA 2000     mov     r0,0h
080036AC 7728     strb    r0,[r5,1Ch]
080036AE 4651     mov     r1,r10
080036B0 0608     lsl     r0,r1,18h
080036B2 0E02     lsr     r2,r0,18h
080036B4 9801     ldr     r0,[sp,4h]
080036B6 4282     cmp     r2,r0
080036B8 D3A1     bcc     80035FEh
080036BA B002     add     sp,8h
080036BC BC38     pop     r3-r5
080036BE 4698     mov     r8,r3
080036C0 46A1     mov     r9,r4
080036C2 46AA     mov     r10,r5
080036C4 BCF0     pop     r4-r7
080036C6 BC01     pop     r0
080036C8 4700     bx      r0
080036CA 0000     lsl     r0,r0,0h
080036CC 3834     sub     r0,34h
080036CE 0300     lsl     r0,r0,0Ch
080036D0 B5F0     push    r4-r7,lr
080036D2 4647     mov     r7,r8
080036D4 B480     push    r7
080036D6 0400     lsl     r0,r0,10h
080036D8 0C04     lsr     r4,r0,10h
080036DA 4808     ldr     r0,=3001D00h
080036DC 4680     mov     r8,r0
080036DE 3021     add     r0,21h
080036E0 7801     ldrb    r1,[r0]
080036E2 2004     mov     r0,4h
