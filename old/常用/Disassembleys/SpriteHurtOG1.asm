    08050424 (T)  push    r4-r6,r14                               ;8  40
    08050426 (T)  mov     r3,r0                                   ;2  42
    08050428 (T)  lsl     r1,r1,10h                               ;2  44
    0805042A (T)  lsr     r1,r1,10h                               ;2  46
    0805042C (T)  mov     r6,0h                                   ;2  48
    0805042E (T)  ldrh    r0,[r3,14h]                             ;4  52
    08050430 (T)  cmp     r0,r1                                   ;2  54
    08050432 (T)  bls     805043Eh                                ;8  62
    08050434 (T)  sub     r0,r0,r1                                ;2  64
    08050436 (T)  strh    r0,[r3,14h]                             ;5  69
    08050438 (T)  mov     r4,r3                                   ;2  71
    0805043A (T)  add     r4,32h                                  ;2  73
    0805043C (T)  b       8050486h                                ;8  81
    0805043E (T)  mov     r5,0h                                   ;2  83
    08050440 (T)  strh    r6,[r3,14h]                             ;5  88
    08050442 (T)  mov     r2,r3                                   ;2  90
    08050444 (T)  add     r2,32h                                  ;2  92
    08050446 (T)  ldrb    r1,[r2]                                 ;4  96
    08050448 (T)  mov     r0,10h                                  ;2  98
    0805044A (T)  orr     r0,r1                                   ;2  100
    0805044C (T)  strb    r0,[r2]                                 ;5  105
    0805044E (T)  mov     r0,r3                                   ;2  107
    08050450 (T)  add     r0,30h                                  ;2  109
    08050452 (T)  strb    r5,[r0]                                 ;5  114
    08050454 (T)  sub     r0,10h                                  ;2  116
    08050456 (T)  strb    r5,[r0]                                 ;5  121
    08050458 (T)  mov     r1,r3                                   ;2  123
    0805045A (T)  add     r1,31h                                  ;2  125
    0805045C (T)  ldrb    r0,[r1]                                 ;4  129
    0805045E (T)  mov     r4,r2                                   ;2  131
    08050460 (T)  cmp     r0,0h                                   ;2  133
    08050462 (T)  beq     8050472h                                ;8  141
    08050464 (T)  ldr     r2,=SamusData                           ;9  150
    08050466 (T)  ldrb    r0,[r2,1h]                              ;4  154
    08050468 (T)  cmp     r0,1h                                   ;2  156
    0805046A (T)  bne     8050472h                                ;8  164
    0805046C (T)  mov     r0,2h                                   ;2  166
    0805046E (T)  strb    r0,[r2,1h]                              ;5  171
    08050470 (T)  strb    r5,[r1]                                 ;5  176
    08050472 (T)  mov     r1,r3                                   ;2  178
    08050474 (T)  add     r1,24h                                  ;2  180
    08050476 (T)  mov     r0,62h                                  ;2  182
    08050478 (T)  strb    r0,[r1]                                 ;5  187
    0805047A (T)  add     r1,2h                                   ;2  189
    0805047C (T)  mov     r0,1h                                   ;2  191
    0805047E (T)  strb    r0,[r1]                                 ;5  196
    08050480 (T)  add     r0,r6,1                                 ;2  198
    08050482 (T)  lsl     r0,r0,18h                               ;2  200
    08050484 (T)  lsr     r6,r0,18h                               ;2  202
    08050486 (T)  mov     r2,r3                                   ;2  204
    08050488 (T)  add     r2,2Bh                                  ;2  206
    0805048A (T)  ldrb    r1,[r2]                                 ;4  210
    0805048C (T)  mov     r0,80h                                  ;2  212
    0805048E (T)  and     r0,r1                                   ;2  214
    08050490 (T)  mov     r1,11h                                  ;2  216
    08050492 (T)  orr     r0,r1                                   ;2  218
    08050494 (T)  strb    r0,[r2]                                 ;5  223
    08050496 (T)  ldrb    r1,[r4]                                 ;4  227
    08050498 (T)  mov     r0,2h                                   ;2  229
    0805049A (T)  orr     r0,r1                                   ;2  231
    0805049C (T)  strb    r0,[r4]                                 ;5  236
    0805049E (T)  mov     r0,r6                                   ;2  238
    080504A0 (T)  pop     r4-r6                                   ;6  244
    080504A2 (T)  pop     r1                                      ;4  248
