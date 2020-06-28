0800FBC8 B500     push    r14                                     ;5  163
0800FBCA 480A     ldr     r0,=3000738h                            ;9  172
0800FBCC 7F01     ldrb    r1,[r0,1Ch]                             ;4  176
0800FBCE 8AC2     ldrh    r2,[r0,16h]                             ;4  180
0800FBD0 3101     add     r1,1h           ;动画帧加1                        ;2  182
0800FBD2 0609     lsl     r1,r1,18h                               ;2  184
0800FBD4 0E09     lsr     r1,r1,18h                               ;2  186
0800FBD6 6983     ldr     r3,[r0,18h]     ;OAM 地址                       ;4  190
0800FBD8 00D0     lsl     r0,r2,3h        ;动画乘以8加上OAM 地址                      ;2  192
0800FBDA 18C0     add     r0,r0,r3                                ;2  194
0800FBDC 7900     ldrb    r0,[r0,4h]      ;读取OAM处的动画帧数                        ;4  198
0800FBDE 4288     cmp     r0,r1           ;最大动画帧数和当前的动画帧加1比较                        ;2  200
0800FBE0 D20A     bcs     800FBF8h        ;大于或等于则返回0结束   
;-------------------------------------这意味着这里动画帧已经达到了最大值                    ;8  208
0800FBE2 1C50     add     r0,r2,1         ;动画加1                        ;2  210
0800FBE4 0400     lsl     r0,r0,10h                               ;2  212
0800FBE6 0B40     lsr     r0,r0,0Dh       ;乘以8h                        ;2  214
0800FBE8 18C0     add     r0,r0,r3        ;加上OAM 地址                        ;2  216
0800FBEA 7900     ldrb    r0,[r0,4h]      ;读取下一个OAM处的最大动画帧数                        ;4  220
0800FBEC 2800     cmp     r0,0h                                   ;2  222
0800FBEE D103     bne     800FBF8h                                ;8  230
0800FBF0 2001     mov     r0,1h           ;为0的话则返回1                         ;2  232
0800FBF2 E002     b       800FBFAh                                ;8  240
0800FBF4 0738     lsl     r0,r7,1Ch                               ;2  242
0800FBF6 0300     lsl     r0,r0,0Ch                               ;2  244
0800FBF8 2000     mov     r0,0h                                   ;2  246
0800FBFA BC02     pop     r1                                      ;9  255
0800FBFC 4708     bx      r1                                      ;8  263
0800FBFE 0000     lsl     r0,r0,0h                                ;2  265


0800FC00 B500     push    r14                                     ;5  270
0800FC02 480B     ldr     r0,=3000738h                            ;9  279
0800FC04 7F01     ldrb    r1,[r0,1Ch]                             ;4  283
0800FC06 8AC3     ldrh    r3,[r0,16h]                             ;4  287
0800FC08 0609     lsl     r1,r1,18h                               ;2  289
0800FC0A 2280     mov     r2,80h                                  ;2  291
0800FC0C 0492     lsl     r2,r2,12h                               ;2  293
0800FC0E 1889     add     r1,r1,r2       ;动画帧数加2                          ;2  295
0800FC10 0E09     lsr     r1,r1,18h                               ;2  297
0800FC12 6982     ldr     r2,[r0,18h]    ;OAM                         ;4  301
0800FC14 00D8     lsl     r0,r3,3h       ;动画乘以8加OAM                         ;2  303
0800FC16 1880     add     r0,r0,r2                                ;2  305
0800FC18 7900     ldrb    r0,[r0,4h]     ;读取当前OAM出的动画最大帧数                          ;4  309
0800FC1A 4288     cmp     r0,r1          ;当前动画最大帧数和当前动画帧数加2相比                         ;2  311
0800FC1C D20A     bcs     800FC34h       ;大于等于则返回0结束                         ;8  319
0800FC1E 1C58     add     r0,r3,1        ;动画加1                         ;2  321
0800FC20 0400     lsl     r0,r0,10h                               ;2  323
0800FC22 0B40     lsr     r0,r0,0Dh                               ;2  325
0800FC24 1880     add     r0,r0,r2       ;加上OAM                         ;2  327
0800FC26 7900     ldrb    r0,[r0,4h]     ;读取下一个动画的最大帧数                         ;4  331
0800FC28 2800     cmp     r0,0h                                   ;2  333
0800FC2A D103     bne     800FC34h                                ;8  341
;----------------------------------------;如果是0的话返回1结束
0800FC2C 2001     mov     r0,1h                                   ;2  343
0800FC2E E002     b       800FC36h                                ;8  351
0800FC30 0738     lsl     r0,r7,1Ch                               ;2  353
0800FC32 0300     lsl     r0,r0,0Ch                               ;2  355
0800FC34 2000     mov     r0,0h                                   ;2  357
0800FC36 BC02     pop     r1                                      ;9  366
0800FC38 4708     bx      r1                                      ;8  374
0800FC3A 0000     lsl     r0,r0,0h                                ;2  376


0800FC3C B510     push    r4,r14                                  ;6  382
0800FC3E 0600     lsl     r0,r0,18h        ;大致可以猜出是精灵的槽位                       ;2  384
0800FC40 0E00     lsr     r0,r0,18h                               ;2  386
0800FC42 4B0D     ldr     r3,=30001ACh                            ;9  395
0800FC44 00C1     lsl     r1,r0,3h                                  ;2  397
0800FC46 1A09     sub     r1,r1,r0                                ;2  399
0800FC48 00C9     lsl     r1,r1,3h         ;五十六倍                       ;2  401
0800FC4A 18C8     add     r0,r1,r3         ;加上精灵数据地址起始                       ;2  403
0800FC4C 7F02     ldrb    r2,[r0,1Ch]                             ;4  407
0800FC4E 8AC4     ldrh    r4,[r0,16h]                              ;4  411
0800FC50 3201     add     r2,1h                                   ;2  413
0800FC52 0612     lsl     r2,r2,18h                               ;2  415
0800FC54 0E12     lsr     r2,r2,18h                               ;2  417
0800FC56 3318     add     r3,18h                                  ;2  419
0800FC58 18C9     add     r1,r1,r3         ;得到当前精灵数据的OAM 地址                      ;2  421
0800FC5A 6809     ldr     r1,[r1]          ;读取OAM                       ;4  425
0800FC5C 00E0     lsl     r0,r4,3h         ;动画乘以8                       ;2  427
0800FC5E 1840     add     r0,r0,r1         ;加上OAM                       ;2  429
0800FC60 7900     ldrb    r0,[r0,4h]                              ;4  433
0800FC62 4290     cmp     r0,r2                                   ;2  435
0800FC64 D20A     bcs     800FC7Ch                                ;8  443
0800FC66 1C60     add     r0,r4,1                                 ;2  445
0800FC68 0400     lsl     r0,r0,10h                               ;2  447
0800FC6A 0B40     lsr     r0,r0,0Dh                               ;2  449
0800FC6C 1840     add     r0,r0,r1                                ;2  451
0800FC6E 7900     ldrb    r0,[r0,4h]                              ;4  455
0800FC70 2800     cmp     r0,0h                                   ;2  457
0800FC72 D103     bne     800FC7Ch                                ;8  465
0800FC74 2001     mov     r0,1h                                   ;2  467
0800FC76 E002     b       800FC7Eh                                ;8  475
0800FC78 01AC     lsl     r4,r5,6h                                ;2  477
0800FC7A 0300     lsl     r0,r0,0Ch                               ;2  479
0800FC7C 2000     mov     r0,0h                                   ;2  481
0800FC7E BC10     pop     r4                                      ;9  490
0800FC80 BC02     pop     r1                                      ;9  499
0800FC82 4708     bx      r1                                      ;8  507


0800FC84 B510     push    r4,r14                                  ;6  513
0800FC86 0600     lsl     r0,r0,18h                               ;2  515
0800FC88 0E00     lsr     r0,r0,18h                               ;2  517
0800FC8A 4B0E     ldr     r3,=30001ACh                            ;9  526
0800FC8C 00C1     lsl     r1,r0,3h                                ;2  528
0800FC8E 1A09     sub     r1,r1,r0                                ;2  530
0800FC90 00C9     lsl     r1,r1,3h                                ;2  532
0800FC92 18C8     add     r0,r1,r3                                ;2  534
0800FC94 7F02     ldrb    r2,[r0,1Ch]                             ;4  538
0800FC96 8AC4     ldrh    r4,[r0,16h]                             ;4  542
0800FC98 0612     lsl     r2,r2,18h                               ;2  544
0800FC9A 2080     mov     r0,80h                                  ;2  546
0800FC9C 0480     lsl     r0,r0,12h                               ;2  548
0800FC9E 1812     add     r2,r2,r0                                ;2  550
0800FCA0 0E12     lsr     r2,r2,18h                               ;2  552
0800FCA2 3318     add     r3,18h                                  ;2  554
0800FCA4 18C9     add     r1,r1,r3                                ;2  556
0800FCA6 6809     ldr     r1,[r1]                                 ;4  560
0800FCA8 00E0     lsl     r0,r4,3h                                ;2  562
0800FCAA 1840     add     r0,r0,r1                                ;2  564
0800FCAC 7900     ldrb    r0,[r0,4h]                              ;4  568
0800FCAE 4290     cmp     r0,r2                                   ;2  570
0800FCB0 D20A     bcs     800FCC8h                                ;8  578
0800FCB2 1C60     add     r0,r4,1                                 ;2  580
0800FCB4 0400     lsl     r0,r0,10h                               ;2  582
0800FCB6 0B40     lsr     r0,r0,0Dh                               ;2  584
0800FCB8 1840     add     r0,r0,r1                                ;2  586
0800FCBA 7900     ldrb    r0,[r0,4h]                              ;4  590
0800FCBC 2800     cmp     r0,0h                                   ;2  592
0800FCBE D103     bne     800FCC8h                                ;8  600
0800FCC0 2001     mov     r0,1h                                   ;2  602
0800FCC2 E002     b       800FCCAh                                ;8  610
0800FCC4 01AC     lsl     r4,r5,6h                                ;2  612
0800FCC6 0300     lsl     r0,r0,0Ch                               ;2  614
0800FCC8 2000     mov     r0,0h                                   ;2  616
0800FCCA BC10     pop     r4                                      ;9  625
0800FCCC BC02     pop     r1                                      ;9  634
0800FCCE 4708     bx      r1                                      ;8  642
0800FCD0 B500     push    r14                                     ;5  647
0800FCD2 480A     ldr     r0,=300070Ch                            ;9  656
0800FCD4 7B01     ldrb    r1,[r0,0Ch]                             ;4  660
0800FCD6 8882     ldrh    r2,[r0,4h]                              ;4  664
0800FCD8 3101     add     r1,1h                                   ;2  666
0800FCDA 0609     lsl     r1,r1,18h                               ;2  668
0800FCDC 0E09     lsr     r1,r1,18h                               ;2  670
0800FCDE 6803     ldr     r3,[r0]                                 ;4  674
0800FCE0 00D0     lsl     r0,r2,3h                                ;2  676
0800FCE2 18C0     add     r0,r0,r3                                ;2  678
0800FCE4 7900     ldrb    r0,[r0,4h]                              ;4  682
0800FCE6 4288     cmp     r0,r1                                   ;2  684
0800FCE8 D20A     bcs     800FD00h                                ;8  692
0800FCEA 1C50     add     r0,r2,1                                 ;2  694
0800FCEC 0400     lsl     r0,r0,10h                               ;2  696
0800FCEE 0B40     lsr     r0,r0,0Dh                               ;2  698
0800FCF0 18C0     add     r0,r0,r3                                ;2  700
0800FCF2 7900     ldrb    r0,[r0,4h]                              ;4  704
0800FCF4 2800     cmp     r0,0h                                   ;2  706
0800FCF6 D103     bne     800FD00h                                ;8  714
0800FCF8 2001     mov     r0,1h                                   ;2  716
0800FCFA E002     b       800FD02h                                ;8  724
0800FCFC 070C     lsl     r4,r1,1Ch                               ;2  726
0800FCFE 0300     lsl     r0,r0,0Ch                               ;2  728
0800FD00 2000     mov     r0,0h                                   ;2  730
0800FD02 BC02     pop     r1                                      ;9  739
0800FD04 4708     bx      r1                                      ;8  747
0800FD06 0000     lsl     r0,r0,0h 

                               ;2  749
0800FD08 B500     push    r14                                     ;5  754
0800FD0A 480B     ldr     r0,=300070Ch                            ;9  763
0800FD0C 7B01     ldrb    r1,[r0,0Ch]                             ;4  767
0800FD0E 8883     ldrh    r3,[r0,4h]                              ;4  771
0800FD10 0609     lsl     r1,r1,18h                               ;2  773
0800FD12 2280     mov     r2,80h                                  ;2  775
0800FD14 0492     lsl     r2,r2,12h                               ;2  777
0800FD16 1889     add     r1,r1,r2                                ;2  779
0800FD18 0E09     lsr     r1,r1,18h                               ;2  781
0800FD1A 6802     ldr     r2,[r0]                                 ;4  785
0800FD1C 00D8     lsl     r0,r3,3h                                ;2  787
0800FD1E 1880     add     r0,r0,r2                                ;2  789
0800FD20 7900     ldrb    r0,[r0,4h]                              ;4  793
0800FD22 4288     cmp     r0,r1                                   ;2  795
0800FD24 D20A     bcs     800FD3Ch                                ;8  803
0800FD26 1C58     add     r0,r3,1                                 ;2  805
0800FD28 0400     lsl     r0,r0,10h                               ;2  807
0800FD2A 0B40     lsr     r0,r0,0Dh                               ;2  809
0800FD2C 1880     add     r0,r0,r2                                ;2  811
0800FD2E 7900     ldrb    r0,[r0,4h]                              ;4  815
0800FD30 2800     cmp     r0,0h                                   ;2  817
0800FD32 D103     bne     800FD3Ch                                ;8  825
0800FD34 2001     mov     r0,1h                                   ;2  827
0800FD36 E002     b       800FD3Eh                                ;8  835
0800FD38 070C     lsl     r4,r1,1Ch                               ;2  837
0800FD3A 0300     lsl     r0,r0,0Ch                               ;2  839
0800FD3C 2000     mov     r0,0h                                   ;2  841
0800FD3E BC02     pop     r1                                      ;9  850
0800FD40 4708     bx      r1                                      ;8  858
0800FD42 0000     lsl     r0,r0,0h                                ;2  860
0800FD44 B500     push    r14                                     ;5  865
0800FD46 480A     ldr     r0,=3000720h                            ;9  874
0800FD48 7B01     ldrb    r1,[r0,0Ch]                             ;4  878
0800FD4A 8882     ldrh    r2,[r0,4h]                              ;4  882
0800FD4C 3101     add     r1,1h                                   ;2  884
0800FD4E 0609     lsl     r1,r1,18h                               ;2  886
0800FD50 0E09     lsr     r1,r1,18h                               ;2  888
0800FD52 6803     ldr     r3,[r0]                                 ;4  892
0800FD54 00D0     lsl     r0,r2,3h                                ;2  894
0800FD56 18C0     add     r0,r0,r3                                ;2  896
0800FD58 7900     ldrb    r0,[r0,4h]                              ;4  900
0800FD5A 4288     cmp     r0,r1                                   ;2  902
0800FD5C D20A     bcs     800FD74h                                ;8  910
0800FD5E 1C50     add     r0,r2,1                                 ;2  912
0800FD60 0400     lsl     r0,r0,10h                               ;2  914
0800FD62 0B40     lsr     r0,r0,0Dh                               ;2  916
0800FD64 18C0     add     r0,r0,r3                                ;2  918
0800FD66 7900     ldrb    r0,[r0,4h]                              ;4  922
0800FD68 2800     cmp     r0,0h                                   ;2  924
0800FD6A D103     bne     800FD74h                                ;8  932
0800FD6C 2001     mov     r0,1h                                   ;2  934
0800FD6E E002     b       800FD76h                                ;8  942
0800FD70 0720     lsl     r0,r4,1Ch                               ;2  944
0800FD72 0300     lsl     r0,r0,0Ch                               ;2  946
0800FD74 2000     mov     r0,0h                                   ;2  948
0800FD76 BC02     pop     r1                                      ;9  957
0800FD78 4708     bx      r1                                      ;8  965
0800FD7A 0000     lsl     r0,r0,0h                                ;2  967
0800FD7C B500     push    r14                                     ;5  972
0800FD7E 7B01     ldrb    r1,[r0,0Ch]                             ;4  976
0800FD80 8882     ldrh    r2,[r0,4h]                              ;4  980
0800FD82 3101     add     r1,1h                                   ;2  982
0800FD84 0609     lsl     r1,r1,18h                               ;2  984
0800FD86 0E09     lsr     r1,r1,18h                               ;2  986
0800FD88 6803     ldr     r3,[r0]                                 ;4  990
0800FD8A 00D0     lsl     r0,r2,3h                                ;2  992
0800FD8C 18C0     add     r0,r0,r3                                ;2  994
0800FD8E 7900     ldrb    r0,[r0,4h]                              ;4  998
0800FD90 4288     cmp     r0,r1                                   ;2  1000
0800FD92 D208     bcs     800FDA6h                                ;8  1008
0800FD94 1C50     add     r0,r2,1                                 ;2  1010
0800FD96 0400     lsl     r0,r0,10h                               ;2  1012
0800FD98 0B40     lsr     r0,r0,0Dh                               ;2  1014
0800FD9A 18C0     add     r0,r0,r3                                ;2  1016
0800FD9C 7900     ldrb    r0,[r0,4h]                              ;4  1020
0800FD9E 2800     cmp     r0,0h                                   ;2  1022
0800FDA0 D101     bne     800FDA6h                                ;8  1030
0800FDA2 2001     mov     r0,1h                                   ;2  1032
0800FDA4 E000     b       800FDA8h                                ;8  1040
0800FDA6 2000     mov     r0,0h                                   ;2  1042
0800FDA8 BC02     pop     r1                                      ;9  1051
0800FDAA 4708     bx      r1                                      ;8  1059
0800FDAC B500     push    r14                                     ;5  1064
0800FDAE 7B01     ldrb    r1,[r0,0Ch]                             ;4  1068
0800FDB0 8883     ldrh    r3,[r0,4h]                              ;4  1072
0800FDB2 0609     lsl     r1,r1,18h                               ;2  1074
0800FDB4 2280     mov     r2,80h                                  ;2  1076
0800FDB6 0492     lsl     r2,r2,12h                               ;2  1078
0800FDB8 1889     add     r1,r1,r2                                ;2  1080
0800FDBA 0E09     lsr     r1,r1,18h                               ;2  1082
0800FDBC 6802     ldr     r2,[r0]                                 ;4  1086
0800FDBE 00D8     lsl     r0,r3,3h                                ;2  1088
0800FDC0 1880     add     r0,r0,r2                                ;2  1090
0800FDC2 7900     ldrb    r0,[r0,4h]                              ;4  1094
0800FDC4 4288     cmp     r0,r1                                   ;2  1096
0800FDC6 D208     bcs     800FDDAh                                ;8  1104
