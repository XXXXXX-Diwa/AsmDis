    080509DC (T)  push    r4-r7,r14                               ;9  125
    080509DE (T)  mov     r7,r10                                  ;2  127
    080509E0 (T)  mov     r6,r9                                   ;2  129
    080509E2 (T)  mov     r5,r8                                   ;2  131
    080509E4 (T)  push    r5-r7                                   ;7  138
    080509E6 (T)  mov     r4,r0                                   ;2  140
    080509E8 (T)  mov     r7,r1                                   ;2  142
    080509EA (T)  lsl     r2,r2,10h                               ;2  144
    080509EC (T)  lsr     r5,r2,10h                               ;2  146
    080509EE (T)  mov     r10,r5                                  ;2  148
    080509F0 (T)  lsl     r3,r3,10h                               ;2  150
    080509F2 (T)  lsr     r6,r3,10h                               ;2  152
    080509F4 (T)  mov     r9,r6                                   ;2  154
    080509F6 (T)  add     r0,32h                                  ;2  156
    080509F8 (T)  ldrb    r1,[r0]                                 ;4  160
    080509FA (T)  mov     r0,8h                                   ;2  162
    080509FC (T)  mov     r8,r0                                   ;2  164
    080509FE (T)  and     r0,r1                                   ;2  166
    08050A00 (T)  cmp     r0,0h                                   ;2  168
    08050A02 (T)  beq     8050A0Ch                                ;8  176
    08050A04 (T)  mov     r0,r4                                   ;2  178
    08050A06 (T)  bl      80504CCh                                ;10 188
    08050A0A (T)  b       8050A36h                                ;8  196
    08050A0C (T)  mov     r0,40h                                  ;2  198
    08050A0E (T)  and     r0,r1                                   ;2  200
    08050A10 (T)  cmp     r0,0h                                   ;2  202
    08050A12 (T)  beq     8050A20h                                ;8  210
    08050A14 (T)  mov     r0,r4                                   ;2  212
    08050A16 (T)  bl      80504ACh                                ;10 222
    08050A1A (T)  mov     r0,r5                                   ;2  224
    08050A1C (T)  mov     r1,r6                                   ;2  226
    08050A1E (T)  b       8050A4Ch                                ;8  234
    08050A20 (T)  mov     r0,r4                                   ;2  236
    08050A22 (T)  bl      8050370h                                ;10 246
    08050A26 (T)  mov     r1,r8                                   ;2  248
    08050A28 (T)  and     r1,r0                                   ;2  250
    08050A2A (T)  cmp     r1,0h                                   ;2  252
    08050A2C (T)  beq     8050A42h                                ;8  260
    08050A2E (T)  mov     r0,r4                                   ;2  262
    08050A30 (T)  mov     r1,14h                                  ;2  264
    08050A32 (T)  bl      8050424h                                ;10 274
    08050A36 (T)  mov     r0,r5                                   ;2  276
    08050A38 (T)  mov     r1,r6                                   ;2  278
    08050A3A (T)  mov     r2,30h                                  ;2  280
    08050A3C (T)  bl      80540ECh                                ;10 290
    08050A40 (T)  b       8050A5Eh                                ;8  298
    08050A42 (T)  mov     r0,r4                                   ;2  300
    08050A44 (T)  bl      80504CCh                                ;10 310
    08050A48 (T)  mov     r0,r10                                  ;2  312
    08050A4A (T)  mov     r1,r9                                   ;2  314
    08050A4C (T)  mov     r2,2Fh                                  ;2  316
    08050A4E (T)  bl      80540ECh                                ;10 326
    08050A52 (T)  mov     r0,r4                                   ;2  328
    08050A54 (T)  mov     r1,r7                                   ;2  330
    08050A56 (T)  mov     r2,0Ch                                  ;2  332
    08050A58 (T)  bl      8050914h                                ;10 342
    08050A5C (T)  b       8050A6Eh                                ;8  350
    08050A5E (T)  ldrb    r0,[r7,11h]                             ;4  354
    08050A60 (T)  cmp     r0,0h                                   ;2  356
    08050A62 (T)  bne     8050A6Ah                                ;8  364
    08050A64 (T)  mov     r0,r7                                   ;2  366
    08050A66 (T)  bl      8051B74h                                ;10 376
    08050A6A (T)  mov     r0,0h                                   ;2  378
    08050A6C (T)  strb    r0,[r7]                                 ;5  383
    08050A6E (T)  pop     r3-r5                                   ;6  389
    08050A70 (T)  mov     r8,r3                                   ;2  391
    08050A72 (T)  mov     r9,r4                                   ;2  393
    08050A74 (T)  mov     r10,r5                                  ;2  395
    08050A76 (T)  pop     r4-r7                                   ;7  402
    08050A78 (T)  pop     r0                                      ;4  406
    08050A7A (T)  bx      r0                                      ;8  414
