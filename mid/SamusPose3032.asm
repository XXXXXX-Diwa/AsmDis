0800A0AC B500     push    r14                                     ;10 236
0800A0AE 1C02     mov     r2,r0           ;13d4                        ;2  238
0800A0B0 7A90     ldrb    r0,[r2,0Ah]                             ;4  242
0800A0B2 280C     cmp     r0,0Ch          ;读取                       ;2  244
0800A0B4 D90C     bls     800A0D0h                                ;8  252
0800A0B6 2018     mov     r0,18h                                  ;2  254
0800A0B8 5E11     ldsh    r1,[r2,r0]                              ;4  258
0800A0BA 2020     mov     r0,20h                                  ;2  260
0800A0BC 4240     neg     r0,r0                                   ;2  262
0800A0BE 4281     cmp     r1,r0                                   ;2  264
0800A0C0 DA08     bge     800A0D4h                                ;8  272
0800A0C2 7810     ldrb    r0,[r2]                                 ;4  276
0800A0C4 2830     cmp     r0,30h                                  ;2  278
0800A0C6 D101     bne     800A0CCh                                ;8  286
0800A0C8 2008     mov     r0,8h                                   ;2  288
0800A0CA E004     b       800A0D6h                                ;8  296
0800A0CC 2014     mov     r0,14h                                  ;2  298
0800A0CE E002     b       800A0D6h        ;一定高度写入球空中pose                            ;8  306

@@
0800A0D0 3001     add     r0,1h                                   ;2  308
0800A0D2 7290     strb    r0,[r2,0Ah]                             ;5  313
0800A0D4 20FF     mov     r0,0FFh                                 ;2  315
0800A0D6 BC02     pop     r1                                      ;4  319
0800A0D8 4708     bx      r1                                      ;8  327
