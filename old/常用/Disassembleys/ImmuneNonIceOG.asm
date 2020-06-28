    080504CC (T)  push    r14                                     ;10 143
    080504CE (T)  mov     r1,r0                                   ;2  145
    080504D0 (T)  mov     r3,r1                                   ;2  147
    080504D2 (T)  add     r3,2Bh                                  ;2  149
    080504D4 (T)  ldrb    r2,[r3]                                 ;4  153
    080504D6 (T)  mov     r1,7Fh                                  ;2  155
    080504D8 (T)  and     r1,r2                                   ;2  157
    080504DA (T)  cmp     r1,3h                                   ;2  159
    080504DC (T)  bcs     80504E8h                                ;8  167
    080504DE (T)  mov     r1,80h                                  ;2  169
    080504E0 (T)  and     r1,r2                                   ;2  171
    080504E2 (T)  mov     r2,3h                                   ;2  173
    080504E4 (T)  orr     r1,r2                                   ;2  175
    080504E6 (T)  strb    r1,[r3]                                 ;5  180
    080504E8 (T)  pop     r1                                      ;4  184
    080504EA (T)  bx      r1                                      ;8  192
