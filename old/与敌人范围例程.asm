


0800FDE0 B5F0     push    r4-r7,r14                               
0800FDE2 0400     lsl     r0,r0,10h                               
0800FDE4 0C05     lsr     r5,r0,10h  ;r0                              
0800FDE6 0409     lsl     r1,r1,10h                               
0800FDE8 0C0F     lsr     r7,r1,10h  ;r1                             
0800FDEA 2600     mov     r6,0h                                   
0800FDEC 4A09     ldr     r2,=30013D4h                            
0800FDEE 480A     ldr     r0,=3001588h                            
0800FDF0 3070     add     r0,70h                                  
0800FDF2 2100     mov     r1,0h                                   
0800FDF4 5E40     ldsh    r0,[r0,r1]  ;samus的高度?  FFFFFF84h                          
0800FDF6 0FC1     lsr     r1,r0,1Fh   ;1h                            
0800FDF8 1840     add     r0,r0,r1    ;FFFFFF85h                            
0800FDFA 1040     asr     r0,r0,1h    ;FFFFFFC2h                            
0800FDFC 8A91     ldrh    r1,[r2,14h] ;sa垂直坐标                            
0800FDFE 1840     add     r0,r0,r1    ;站立的话减3eh  变球的话1eh                          
0800FE00 0400     lsl     r0,r0,10h                               
0800FE02 0C03     lsr     r3,r0,10h                               
0800FE04 8A54     ldrh    r4,[r2,12h] ;sa水平坐标                            
0800FE06 4805     ldr     r0,=3000738h                            
0800FE08 8841     ldrh    r1,[r0,2h]  ;精灵垂直坐标                            
0800FE0A 8882     ldrh    r2,[r0,4h]  ;精灵水平坐标                            
0800FE0C 4299     cmp     r1,r3                                   
0800FE0E D907     bls     @@SADownSp                                
0800FE10 1AC8     sub     r0,r1,r3                                
0800FE12 E006     b       @@Peer                                

@@SADownSp:                              
0800FE20 1A58     sub     r0,r3,r1

@@Peer:                                
0800FE22 42A8     cmp     r0,r5                                   
0800FE24 DB01     blt     @@CheckY    ;在范围中                             
0800FE26 2000     mov     r0,0h                                   
0800FE28 E00B     b       @@end 

@@CheckY:                               
0800FE2A 42A2     cmp     r2,r4                                   
0800FE2C D904     bls     @@SARightSp                                
0800FE2E 1B10     sub     r0,r2,r4                                
0800FE30 42B8     cmp     r0,r7                                   
0800FE32 DA05     bge     @@peer1                                
0800FE34 2604     mov     r6,4h                                   
0800FE36 E003     b       @@peer1

@@SARightSp:                                
0800FE38 1AA0     sub     r0,r4,r2                                
0800FE3A 42B8     cmp     r0,r7                                   
0800FE3C DA00     bge     @@peer1                                
0800FE3E 2608     mov     r6,8h

@@peer1:                                   
0800FE40 1C30     mov     r0,r6 

@@end:                                  
0800FE42 BCF0     pop     r4-r7                                   
0800FE44 BC02     pop     r1                                      
0800FE46 4708     bx      r1


                                      
0800FE48 B570     push    r4-r6,r14                               
0800FE4A 0400     lsl     r0,r0,10h                               
0800FE4C 0C06     lsr     r6,r0,10h                               
0800FE4E 0409     lsl     r1,r1,10h                               
0800FE50 0C0C     lsr     r4,r1,10h                               
0800FE52 2500     mov     r5,0h                                   
0800FE54 4A09     ldr     r2,=30013D4h                            
0800FE56 480A     ldr     r0,=3001588h                            
0800FE58 3070     add     r0,70h                                  
0800FE5A 2100     mov     r1,0h                                   
0800FE5C 5E40     ldsh    r0,[r0,r1]                              
0800FE5E 0FC1     lsr     r1,r0,1Fh                               
0800FE60 1840     add     r0,r0,r1                                
0800FE62 1040     asr     r0,r0,1h                                
0800FE64 8A91     ldrh    r1,[r2,14h]                             
0800FE66 1840     add     r0,r0,r1                                
0800FE68 0400     lsl     r0,r0,10h                               
0800FE6A 0C03     lsr     r3,r0,10h                               
0800FE6C 8A51     ldrh    r1,[r2,12h]                             
0800FE6E 4805     ldr     r0,=3000738h                            
0800FE70 8842     ldrh    r2,[r0,2h]                              
0800FE72 8880     ldrh    r0,[r0,4h]                              
0800FE74 4288     cmp     r0,r1                                   
0800FE76 D907     bls     800FE88h                                
0800FE78 1A40     sub     r0,r0,r1                                
0800FE7A E006     b       800FE8Ah                                
0800FE7C 13D4     asr     r4,r2,0Fh                               
0800FE7E 0300     lsl     r0,r0,0Ch                               
0800FE80 1588     asr     r0,r1,16h                               
0800FE82 0300     lsl     r0,r0,0Ch                               
0800FE84 0738     lsl     r0,r7,1Ch                               
0800FE86 0300     lsl     r0,r0,0Ch                               
0800FE88 1A08     sub     r0,r1,r0                                
0800FE8A 42A0     cmp     r0,r4                                   
0800FE8C DB01     blt     800FE92h                                
0800FE8E 2000     mov     r0,0h                                   
0800FE90 E00B     b       800FEAAh                                
0800FE92 429A     cmp     r2,r3                                   
0800FE94 D904     bls     800FEA0h                                
0800FE96 1AD0     sub     r0,r2,r3                                
0800FE98 42B0     cmp     r0,r6                                   
0800FE9A DA05     bge     800FEA8h                                
0800FE9C 2501     mov     r5,1h                                   
0800FE9E E003     b       800FEA8h                                
0800FEA0 1A98     sub     r0,r3,r2                                
0800FEA2 42B0     cmp     r0,r6                                   
0800FEA4 DA00     bge     800FEA8h                                
0800FEA6 2502     mov     r5,2h                                   
0800FEA8 1C28     mov     r0,r5                                   
0800FEAA BC70     pop     r4-r6                                   
0800FEAC BC02     pop     r1                                      
0800FEAE 4708     bx      r1                                      
0800FEB0 B5F0     push    r4-r7,r14                               
0800FEB2 464F     mov     r7,r9                                   
0800FEB4 4646     mov     r6,r8                                   
0800FEB6 B4C0     push    r6,r7                                   
0800FEB8 0400     lsl     r0,r0,10h                               
0800FEBA 0C07     lsr     r7,r0,10h                               
0800FEBC 0409     lsl     r1,r1,10h                               
0800FEBE 0C09     lsr     r1,r1,10h                               
0800FEC0 4689     mov     r9,r1                                   
0800FEC2 0412     lsl     r2,r2,10h                               
0800FEC4 0C12     lsr     r2,r2,10h                               
0800FEC6 4690     mov     r8,r2                                   
0800FEC8 2000     mov     r0,0h                                   
0800FECA 4684     mov     r12,r0                                  
0800FECC 2600     mov     r6,0h                                   
0800FECE 4A0A     ldr     r2,=30013D4h                            
0800FED0 480A     ldr     r0,=3001588h                            
0800FED2 3070     add     r0,70h                                  
0800FED4 2100     mov     r1,0h                                   
0800FED6 5E40     ldsh    r0,[r0,r1]                              
0800FED8 0FC1     lsr     r1,r0,1Fh                               
0800FEDA 1840     add     r0,r0,r1                                
0800FEDC 1040     asr     r0,r0,1h                                
0800FEDE 8A91     ldrh    r1,[r2,14h]                             
0800FEE0 1840     add     r0,r0,r1                                
0800FEE2 0400     lsl     r0,r0,10h                               
0800FEE4 0C03     lsr     r3,r0,10h                               
0800FEE6 8A55     ldrh    r5,[r2,12h]                             
0800FEE8 4805     ldr     r0,=3000738h                            
0800FEEA 8842     ldrh    r2,[r0,2h]                              
0800FEEC 8884     ldrh    r4,[r0,4h]                              
0800FEEE 1C01     mov     r1,r0                                   
0800FEF0 429A     cmp     r2,r3                                   
0800FEF2 D907     bls     800FF04h                                
0800FEF4 1AD0     sub     r0,r2,r3                                
0800FEF6 E006     b       800FF06h                                
0800FEF8 13D4     asr     r4,r2,0Fh                               
0800FEFA 0300     lsl     r0,r0,0Ch                               
0800FEFC 1588     asr     r0,r1,16h                               
0800FEFE 0300     lsl     r0,r0,0Ch                               

