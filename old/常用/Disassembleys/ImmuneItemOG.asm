    080504AC (T)  push    r14                                     ;5  40
    080504AE (T)  mov     r1,r0                                   ;2  42
    080504B0 (T)  mov     r3,r1                                   ;2  44
    080504B2 (T)  add     r3,2Bh                                  ;2  46
    080504B4 (T)  ldrb    r2,[r3]                                 ;6  52
    080504B6 (T)  mov     r1,7Fh                                  ;2  54
    080504B8 (T)  and     r1,r2                                   ;2  56
    080504BA (T)  cmp     r1,2h                                   ;2  58
    080504BC (T)  bcs     80504C8h                                ;8  66
    080504BE (T)  mov     r1,80h                                  ;2  68
    080504C0 (T)  and     r1,r2                                   ;2  70
    080504C2 (T)  mov     r2,2h                                   ;2  72
    080504C4 (T)  orr     r1,r2                                   ;2  74
    080504C6 (T)  strb    r1,[r3]                                 ;7  81
    080504C8 (T)  pop     r1                                      ;9  90
    080504CA (T)  bx      r1                                      ;8  98
