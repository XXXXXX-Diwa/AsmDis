


0800FE48 B570     push    r4-r6,r14                               
0800FE4A 0400     lsl     r0,r0,10h                               
0800FE4C 0C06     lsr     r6,r0,10h     ;140h                          
0800FE4E 0409     lsl     r1,r1,10h                               
0800FE50 0C0C     lsr     r4,r1,10h     ;140h                          
0800FE52 2500     mov     r5,0h                                   
0800FE54 4A09     ldr     r2,=30013D4h                            
0800FE56 480A     ldr     r0,=3001588h                            
0800FE58 3070     add     r0,70h                                  
0800FE5A 2100     mov     r1,0h                                   
0800FE5C 5E40     ldsh    r0,[r0,r1]   ;得到FFFFFFXX                           
0800FE5E 0FC1     lsr     r1,r0,1Fh                               
0800FE60 1840     add     r0,r0,r1     ;加1                           
0800FE62 1040     asr     r0,r0,1h     ;7FFFFFC2 or 7FFFFFD2                         
0800FE64 8A91     ldrh    r1,[r2,14h]  ;人物垂直坐标                           
0800FE66 1840     add     r0,r0,r1                                
0800FE68 0400     lsl     r0,r0,10h                               
0800FE6A 0C03     lsr     r3,r0,10h    ;加人物坐标结果给r3                           
0800FE6C 8A51     ldrh    r1,[r2,12h]  ;人物水平坐标                           
0800FE6E 4805     ldr     r0,=3000738h                            
0800FE70 8842     ldrh    r2,[r0,2h]   ;精灵垂直坐标                           
0800FE72 8880     ldrh    r0,[r0,4h]   ;精灵水平坐标                            
0800FE74 4288     cmp     r0,r1        ;精灵水平与人物水平比                           
0800FE76 D907     bls     @@leftsprite ;r0>=r1                                
0800FE78 1A40     sub     r0,r0,r1                                
0800FE7A E006     b       @@rightsprite                                


@@leftsprite:                              
0800FE88 1A08     sub     r0,r1,r0   
@@rightsprite:                             
0800FE8A 42A0     cmp     r0,r4                                   
0800FE8C DB01     blt     @@goto    ;小于140h跳转                             
0800FE8E 2000     mov     r0,0h                                   
0800FE90 E00B     b       @@end 

@@goto:                               
0800FE92 429A     cmp     r2,r3     ;精灵垂直坐标和r3比                              
0800FE94 D904     bls     @down     ;大于跳转                              
0800FE96 1AD0     sub     r0,r2,r3  ;精灵垂直坐标减去r3                              
0800FE98 42B0     cmp     r0,r6     ;大于或等于140h                              
0800FE9A DA05     bge     @@come    ;跳转                              
0800FE9C 2501     mov     r5,1h                                   
0800FE9E E003     b       @@come  

@@down:                              
0800FEA0 1A98     sub     r0,r3,r2  ;r3减去精灵坐标                              
0800FEA2 42B0     cmp     r0,r6                                   
0800FEA4 DA00     bge     @@come                                
0800FEA6 2502     mov     r5,2h   

@@come:                                
0800FEA8 1C28     mov     r0,r5
@@end:                                   
0800FEAA BC70     pop     r4-r6                                   
0800FEAC BC02     pop     r1                                      
0800FEAE 4708     bx      r1                                      
