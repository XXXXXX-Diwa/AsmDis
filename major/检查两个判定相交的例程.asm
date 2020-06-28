                                   
0800E6F8 B5F0     push    r4-r7,r14                               
0800E6FA 4647     mov     r7,r8                                   
0800E6FC B480     push    r7                                      
0800E6FE 9C06     ldr     r4,[sp,18h]     ;读取最上界                        
0800E700 9D07     ldr     r5,[sp,1Ch]     ;读取最下界                        
0800E702 46A8     mov     r8,r5                                   
0800E704 9D08     ldr     r5,[sp,20h]     ;读取最左界                        
0800E706 9E09     ldr     r6,[sp,24h]     ;读取最右界                        
0800E708 0400     lsl     r0,r0,10h       ;2最上界                        
0800E70A 0409     lsl     r1,r1,10h                               
0800E70C 0C09     lsr     r1,r1,10h       ;2最下分界                           
0800E70E 0412     lsl     r2,r2,10h                               
0800E710 0C12     lsr     r2,r2,10h       ;2最左分界                        
0800E712 041B     lsl     r3,r3,10h                               
0800E714 0C1B     lsr     r3,r3,10h       ;2最右分界                        
0800E716 0424     lsl     r4,r4,10h                               
0800E718 0C24     lsr     r4,r4,10h                               
0800E71A 4647     mov     r7,r8                                   
0800E71C 043F     lsl     r7,r7,10h                               
0800E71E 46B8     mov     r8,r7                                   
0800E720 042D     lsl     r5,r5,10h                               
0800E722 0C2D     lsr     r5,r5,10h                               
0800E724 0436     lsl     r6,r6,10h                               
0800E726 0C36     lsr     r6,r6,10h                               
0800E728 4580     cmp     r8,r0          ;最下界和2最上界比较                         
0800E72A D307     bcc     @@ReturnZero   ;小于=仍在上,结束                             
0800E72C 428C     cmp     r4,r1          ;最上界和2最下界比较                         
0800E72E D205     bcs     @@ReturnZero   ;大于等于=仍在下,结束                             
0800E730 4296     cmp     r6,r2          ;最右界和2最左界比较                         
0800E732 D303     bcc     @@ReturnZero   ;小于=仍在左,结束                             
0800E734 429D     cmp     r5,r3          ;最左界和2最右界比较                          
0800E736 D201     bcs     @@ReturnZero   ;大于等于=仍在右,结束                             
0800E738 2001     mov     r0,1h                                   
0800E73A E000     b       @@ReturnOne    ;全部成立则返回1

@@ReturnZero:                              
0800E73C 2000     mov     r0,0h 

@@ReturnOne:                                  
0800E73E BC08     pop     r3                                      
0800E740 4698     mov     r8,r3                                   
0800E742 BCF0     pop     r4-r7                                   
0800E744 BC02     pop     r1                                      
0800E746 4708     bx      r1   