    08050370 (T)  push    r14                                     ;10 133
    08050372 (T)  mov     r3,r0                                   ;2  135
    08050374 (T)  add     r0,32h                                  ;2  137
    08050376 (T)  ldrb    r1,[r0]                                 ;4  141
    08050378 (T)  mov     r0,80h                                  ;2  143
    0805037A (T)  and     r0,r1                                   ;2  145
    0805037C (T)  cmp     r0,0h                                   ;2  147
    0805037E (T)  beq     8050388h                                ;8  155
    08050380 (T)  ldr     r2,=82B1BE4h                            ;9  164
    08050382 (T)  b       805038Ah                                ;8  172
    08050384      dd      0082B1BE4h
    08050388 (T)  ldr     r2,=82B0D68h                            ;9  181
    0805038A (T)  ldrb    r1,[r3,1Dh]                             ;12 193
    0805038C (T)  lsl     r0,r1,3h                                ;2  195
    0805038E (T)  add     r0,r0,r1                                ;2  197
    08050390 (T)  lsl     r0,r0,1h                                ;2  199
    08050392 (T)  add     r2,4h                                   ;2  201
    08050394 (T)  add     r0,r0,r2                                ;2  203
    08050396 (T)  ldrh    r0,[r0]                                 ;4  207
    08050398 (T)  pop     r1                                      ;4  211
    0805039A (T)  bx      r1                                      ;8  219
