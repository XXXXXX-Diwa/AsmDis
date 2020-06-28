


0800FDE0 B5F0     push    r4-r7,r14                               
0800FDE2 0400     lsl     r0,r0,10h                               
0800FDE4 0C05     lsr     r5,r0,10h    ;280h                           
0800FDE6 0409     lsl     r1,r1,10h                               
0800FDE8 0C0F     lsr     r7,r1,10h    ;340h                           
0800FDEA 2600     mov     r6,0h                                   
0800FDEC 4A09     ldr     r2,=30013D4h                            
0800FDEE 480A     ldr     r0,=3001588h                            
0800FDF0 3070     add     r0,70h                                  
0800FDF2 2100     mov     r1,0h                                   
0800FDF4 5E40     ldsh    r0,[r0,r1]   ;得到30015f8的值                           
0800FDF6 0FC1     lsr     r1,r0,1Fh                               
0800FDF8 1840     add     r0,r0,r1                                
0800FDFA 1040     asr     r0,r0,1h                                
0800FDFC 8A91     ldrh    r1,[r2,14h]                             
0800FDFE 1840     add     r0,r0,r1                                
0800FE00 0400     lsl     r0,r0,10h                               
0800FE02 0C03     lsr     r3,r0,10h                               
0800FE04 8A54     ldrh    r4,[r2,12h]                             
0800FE06 4805     ldr     r0,=3000738h                            
0800FE08 8841     ldrh    r1,[r0,2h]   ;精灵Y坐标                           
0800FE0A 8882     ldrh    r2,[r0,4h]   ;精灵X坐标                           
0800FE0C 4299     cmp     r1,r3                                   
0800FE0E D907     bls     800FE20h                                
0800FE10 1AC8     sub     r0,r1,r3                                
0800FE12 E006     b       800FE22h                                
0800FE14 13D4     asr     r4,r2,0Fh                               
0800FE16 0300     lsl     r0,r0,0Ch                               
0800FE18 1588     asr     r0,r1,16h                               
0800FE1A 0300     lsl     r0,r0,0Ch                               
0800FE1C 0738     lsl     r0,r7,1Ch                               
0800FE1E 0300     lsl     r0,r0,0Ch                               
0800FE20 1A58     sub     r0,r3,r1                                
0800FE22 42A8     cmp     r0,r5                                   
0800FE24 DB01     blt     800FE2Ah                                
0800FE26 2000     mov     r0,0h                                   
0800FE28 E00B     b       800FE42h                                
0800FE2A 42A2     cmp     r2,r4                                   
0800FE2C D904     bls     800FE38h                                
0800FE2E 1B10     sub     r0,r2,r4                                
0800FE30 42B8     cmp     r0,r7                                   
0800FE32 DA05     bge     800FE40h                                
0800FE34 2604     mov     r6,4h                                   
0800FE36 E003     b       800FE40h                                
0800FE38 1AA0     sub     r0,r4,r2                                
0800FE3A 42B8     cmp     r0,r7                                   
0800FE3C DA00     bge     800FE40h                                
0800FE3E 2608     mov     r6,8h                                   
0800FE40 1C30     mov     r0,r6                                   
0800FE42 BCF0     pop     r4-r7                                   
0800FE44 BC02     pop     r1                                      
0800FE46 4708     bx      r1                                      
