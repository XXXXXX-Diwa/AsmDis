0804B604 B510     push    r4,r14                                  ;14 36
0804B606 4808     ldr     r0,=3000055h                            ;9  45
0804B608 7800     ldrb    r0,[r0]                                 ;7  52
0804B60A 3001     add     r0,1h                                   ;2  54
0804B60C 0600     lsl     r0,r0,18h                               ;2  56
0804B60E 0E02     lsr     r2,r0,18h                               ;2  58
0804B610 1C14     mov     r4,r2                                   ;2  60
0804B612 4B06     ldr     r3,=3000738h                            ;9  69
0804B614 1C18     mov     r0,r3                                   ;2  71
0804B616 3024     add     r0,24h                                  ;2  73
0804B618 7800     ldrb    r0,[r0]                                 ;7  80
0804B61A 2809     cmp     r0,9h                                   ;2  82
0804B61C D048     beq     804B6B0h                                ;8  90
0804B61E 2809     cmp     r0,9h                                   ;2  92
0804B620 DC06     bgt     804B630h                                ;8  100
0804B622 2800     cmp     r0,0h                                   ;2  102
0804B624 D007     beq     804B636h                                ;8  110
0804B626 E0A5     b       804B774h                                ;8  118
0804B628 0055     lsl     r5,r2,1h                                ;2  120
0804B62A 0300     lsl     r0,r0,0Ch                               ;2  122
0804B62C 0738     lsl     r0,r7,1Ch                               ;2  124
0804B62E 0300     lsl     r0,r0,0Ch                               ;2  126
0804B630 2823     cmp     r0,23h                                  ;2  128
0804B632 D065     beq     804B700h                                ;8  136
0804B634 E09E     b       804B774h                                ;8  144
0804B636 2A21     cmp     r2,21h                                  ;2  146
0804B638 D102     bne     804B640h                                ;8  154
0804B63A 2003     mov     r0,3h                                   ;2  156
0804B63C 2147     mov     r1,47h                                  ;2  158
0804B63E E003     b       804B648h                                ;8  166
0804B640 2A2F     cmp     r2,2Fh                                  ;2  168
0804B642 D106     bne     804B652h                                ;8  176
0804B644 2003     mov     r0,3h                                   ;2  178
0804B646 2148     mov     r1,48h                                  ;2  180
0804B648 F015F938 bl      80608BCh                                ;10 190
0804B64C 0600     lsl     r0,r0,18h                               ;2  192
0804B64E 0E03     lsr     r3,r0,18h                               ;2  194
0804B650 E000     b       804B654h                                ;8  202
0804B652 2301     mov     r3,1h                                   ;2  204
0804B654 2B00     cmp     r3,0h                                   ;2  206
0804B656 D005     beq     804B664h                                ;8  214
0804B658 4901     ldr     r1,=3000738h                            ;9  223
0804B65A 2000     mov     r0,0h                                   ;2  225
0804B65C 8008     strh    r0,[r1]                                 ;8  233
0804B65E E089     b       804B774h                                ;8  241
0804B660 0738     lsl     r0,r7,1Ch                               ;2  243
0804B662 0300     lsl     r0,r0,0Ch                               ;2  245
0804B664 4A10     ldr     r2,=3000738h                            ;9  254
0804B666 1C11     mov     r1,r2                                   ;2  256
0804B668 3127     add     r1,27h                                  ;2  258
0804B66A 2030     mov     r0,30h                                  ;2  260
0804B66C 7008     strb    r0,[r1]                                 ;8  268
0804B66E 1C10     mov     r0,r2                                   ;2  270
0804B670 3028     add     r0,28h                                  ;2  272
0804B672 7003     strb    r3,[r0]                                 ;8  280
0804B674 3102     add     r1,2h                                   ;2  282
0804B676 2020     mov     r0,20h                                  ;2  284
0804B678 7008     strb    r0,[r1]                                 ;8  292
0804B67A 2100     mov     r1,0h                                   ;2  294
0804B67C 8153     strh    r3,[r2,0Ah]                             ;5  299
0804B67E 8193     strh    r3,[r2,0Ch]                             ;5  304
0804B680 81D3     strh    r3,[r2,0Eh]                             ;5  309
0804B682 8213     strh    r3,[r2,10h]                             ;5  314
0804B684 4809     ldr     r0,=82E4970h                            ;9  323
0804B686 6190     str     r0,[r2,18h]                             ;5  328
0804B688 7711     strb    r1,[r2,1Ch]                             ;5  333
0804B68A 82D3     strh    r3,[r2,16h]                             ;5  338
0804B68C 1C10     mov     r0,r2                                   ;2  340
0804B68E 3025     add     r0,25h                                  ;2  342
0804B690 7001     strb    r1,[r0]                                 ;8  350
0804B692 1C11     mov     r1,r2                                   ;2  352
0804B694 3124     add     r1,24h                                  ;2  354
0804B696 2009     mov     r0,9h                                   ;2  356
0804B698 7008     strb    r0,[r1]                                 ;8  364
0804B69A 8810     ldrh    r0,[r2]                                 ;4  368
0804B69C 2390     mov     r3,90h                                  ;2  370
0804B69E 009B     lsl     r3,r3,2h                                ;2  372
0804B6A0 1C19     mov     r1,r3                                   ;2  374
0804B6A2 4308     orr     r0,r1                                   ;2  376
0804B6A4 8010     strh    r0,[r2]                                 ;5  381
0804B6A6 E065     b       804B774h                                ;8  389
0804B6A8 0738     lsl     r0,r7,1Ch                               ;2  391
0804B6AA 0300     lsl     r0,r0,0Ch                               ;2  393
0804B6AC 4970     ldr     r1,=0BC01BC70h                          ;9  402
0804B6AE 082E     lsr     r6,r5,20h                               ;2  404
0804B6B0 8819     ldrh    r1,[r3]                                 ;4  408
0804B6B2 2002     mov     r0,2h                                   ;2  410
0804B6B4 4008     and     r0,r1                                   ;2  412
0804B6B6 2800     cmp     r0,0h                                   ;2  414
0804B6B8 D05C     beq     804B774h                                ;8  422
0804B6BA 2A21     cmp     r2,21h                                  ;2  424
0804B6BC D104     bne     804B6C8h                                ;8  432
0804B6BE 2001     mov     r0,1h                                   ;2  434
0804B6C0 2147     mov     r1,47h                                  ;2  436
0804B6C2 F015F8FB bl      80608BCh                                ;10 446
0804B6C6 E005     b       804B6D4h                                ;8  454
0804B6C8 2C2F     cmp     r4,2Fh                                  ;2  456
0804B6CA D103     bne     804B6D4h                                ;8  464
0804B6CC 2001     mov     r0,1h                                   ;2  466
0804B6CE 2148     mov     r1,48h                                  ;2  468
0804B6D0 F015F8F4 bl      80608BCh                                ;10 478
0804B6D4 4A08     ldr     r2,=3000738h                            ;9  487
0804B6D6 1C10     mov     r0,r2                                   ;2  489
0804B6D8 3024     add     r0,24h                                  ;2  491
0804B6DA 2123     mov     r1,23h                                  ;2  493
0804B6DC 7001     strb    r1,[r0]                                 ;8  501
0804B6DE 7F10     ldrb    r0,[r2,1Ch]                             ;4  505
0804B6E0 2805     cmp     r0,5h                                   ;2  507
0804B6E2 D947     bls     804B774h                                ;8  515
0804B6E4 8AD1     ldrh    r1,[r2,16h]                             ;4  519
0804B6E6 2003     mov     r0,3h                                   ;2  521
0804B6E8 4008     and     r0,r1                                   ;2  523
0804B6EA 2800     cmp     r0,0h                                   ;2  525
0804B6EC D142     bne     804B774h                                ;8  533
0804B6EE 4803     ldr     r0,=165h                                ;9  542
0804B6F0 F7B7FA16 bl      8002B20h                                ;10 552
0804B6F4 E03E     b       804B774h                                ;8  560
0804B6F6 0000     lsl     r0,r0,0h                                ;2  562
0804B6F8 0738     lsl     r0,r7,1Ch                               ;2  564
0804B6FA 0300     lsl     r0,r0,0Ch                               ;2  566
0804B6FC 0165     lsl     r5,r4,5h                                ;2  568
0804B6FE 0000     lsl     r0,r0,0h                                ;2  570
0804B700 7F18     ldrb    r0,[r3,1Ch]                             ;4  574
0804B702 2805     cmp     r0,5h                                   ;2  576
0804B704 D90C     bls     804B720h                                ;8  584
0804B706 8AD9     ldrh    r1,[r3,16h]                             ;4  588
0804B708 2003     mov     r0,3h                                   ;2  590
0804B70A 4008     and     r0,r1                                   ;2  592
0804B70C 2800     cmp     r0,0h                                   ;2  594
0804B70E D107     bne     804B720h                                ;8  602
0804B710 8819     ldrh    r1,[r3]                                 ;4  606
0804B712 2002     mov     r0,2h                                   ;2  608
0804B714 4008     and     r0,r1                                   ;2  610
0804B716 2800     cmp     r0,0h                                   ;2  612
0804B718 D002     beq     804B720h                                ;8  620
0804B71A 4809     ldr     r0,=165h                                ;9  629
0804B71C F7B7FA00 bl      8002B20h                                ;10 639
0804B720 4A08     ldr     r2,=3000738h                            ;9  648
0804B722 8811     ldrh    r1,[r2]                                 ;4  652
0804B724 2080     mov     r0,80h                                  ;2  654
0804B726 0080     lsl     r0,r0,2h                                ;2  656
0804B728 4008     and     r0,r1                                   ;2  658
0804B72A 1C14     mov     r4,r2                                   ;2  660
0804B72C 2800     cmp     r0,0h                                   ;2  662
0804B72E D00B     beq     804B748h                                ;8  670
0804B730 88A1     ldrh    r1,[r4,4h]                              ;4  674
0804B732 1C08     mov     r0,r1                                   ;2  676
0804B734 3040     add     r0,40h                                  ;2  678
0804B736 0400     lsl     r0,r0,10h                               ;2  680
0804B738 0C02     lsr     r2,r0,10h                               ;2  682
0804B73A 3104     add     r1,4h                                   ;2  684
0804B73C E00A     b       804B754h                                ;8  692
0804B73E 0000     lsl     r0,r0,0h                                ;2  694
0804B740 0165     lsl     r5,r4,5h                                ;2  696
0804B742 0000     lsl     r0,r0,0h                                ;2  698
0804B744 0738     lsl     r0,r7,1Ch                               ;2  700
0804B746 0300     lsl     r0,r0,0Ch                               ;2  702
0804B748 88A1     ldrh    r1,[r4,4h]                              ;4  706
0804B74A 1C08     mov     r0,r1                                   ;2  708
0804B74C 3840     sub     r0,40h                                  ;2  710
0804B74E 0400     lsl     r0,r0,10h                               ;2  712
0804B750 0C02     lsr     r2,r0,10h                               ;2  714
0804B752 3904     sub     r1,4h                                   ;2  716
0804B754 80A1     strh    r1,[r4,4h]                              ;5  721
0804B756 8860     ldrh    r0,[r4,2h]                              ;4  725
0804B758 3840     sub     r0,40h                                  ;2  727
0804B75A 1C11     mov     r1,r2                                   ;2  729
0804B75C F7C3FF94 bl      800F688h                                ;10 739
0804B760 4806     ldr     r0,=30007F1h                            ;9  748
0804B762 7800     ldrb    r0,[r0]                                 ;7  755
0804B764 2811     cmp     r0,11h                                  ;2  757
0804B766 D105     bne     804B774h                                ;8  765
0804B768 4805     ldr     r0,=30000DCh                            ;9  774
0804B76A 8800     ldrh    r0,[r0]                                 ;7  781
0804B76C 2808     cmp     r0,8h                                   ;2  783
0804B76E D101     bne     804B774h                                ;8  791
0804B770 2000     mov     r0,0h                                   ;2  793
0804B772 8020     strh    r0,[r4]                                 ;5  798
0804B774 BC10     pop     r4                                      ;4  802
0804B776 BC01     pop     r0                                      ;4  806
0804B778 4700     bx      r0                                      ;8  814
