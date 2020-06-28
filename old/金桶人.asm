                             
0802F534 B5F0     push    r4-r7,r14                               
0802F536 4657     mov     r7,r10                                  
0802F538 464E     mov     r6,r9                                   
0802F53A 4645     mov     r5,r8                                   
0802F53C B4E0     push    r5-r7                                   
0802F53E B084     add     sp,-10h                                 
0802F540 4824     ldr     r0,=3000738h                            
0802F542 4682     mov     r10,r0                                  
0802F544 8801     ldrh    r1,[r0]      ;读取取向                            
0802F546 2080     mov     r0,80h                                  
0802F548 0140     lsl     r0,r0,5h     ;1000h                           
0802F54A 4008     and     r0,r1        ;and 取向                           
0802F54C 2800     cmp     r0,0h                                   
0802F54E D149     bne     @@ReturnZero                                
0802F550 4654     mov     r4,r10                                  
0802F552 8861     ldrh    r1,[r4,2h]   ;读取坐标                            
0802F554 88A5     ldrh    r5,[r4,4h]                              
0802F556 46A9     mov     r9,r5                                   
0802F558 1C08     mov     r0,r1                                   
0802F55A 38A4     sub     r0,0A4h      ;Y坐标减去两格半余                           
0802F55C 0400     lsl     r0,r0,10h                               
0802F55E 0C00     lsr     r0,r0,10h                               
0802F560 464A     mov     r2,r9                                   
0802F562 3A48     sub     r2,48h       ;X坐标减去一格余                           
0802F564 0412     lsl     r2,r2,10h                               
0802F566 0C12     lsr     r2,r2,10h                               
0802F568 464B     mov     r3,r9                                   
0802F56A 3348     add     r3,48h       ;X坐标加上1格余                           
0802F56C 041B     lsl     r3,r3,10h                               
0802F56E 0C1B     lsr     r3,r3,10h                               
0802F570 4C19     ldr     r4,=30013D4h                            
0802F572 8AA6     ldrh    r6,[r4,14h]  ;读取SaY坐标                           
0802F574 46B0     mov     r8,r6                                   
0802F576 8A67     ldrh    r7,[r4,12h]  ;读取SaX坐标                           
0802F578 4C18     ldr     r4,=3001588h                            
0802F57A 46A4     mov     r12,r4                                  
0802F57C 3470     add     r4,70h                                  
0802F57E 8826     ldrh    r6,[r4]      ;读取Sa上部分界                           
0802F580 4446     add     r6,r8        ;加上Y坐标                           
0802F582 0436     lsl     r6,r6,10h                               
0802F584 0C36     lsr     r6,r6,10h                               
0802F586 4664     mov     r4,r12                                  
0802F588 3474     add     r4,74h                                  
0802F58A 8824     ldrh    r4,[r4]      ;读取Sa下部分界                              
0802F58C 44A0     add     r8,r4        ;加上Y坐标                           
0802F58E 4645     mov     r5,r8                                   
0802F590 042D     lsl     r5,r5,10h                               
0802F592 0C2D     lsr     r5,r5,10h                               
0802F594 46A8     mov     r8,r5                                   
0802F596 4664     mov     r4,r12                                  
0802F598 346E     add     r4,6Eh       ;读取Sa左部分界                           
0802F59A 8825     ldrh    r5,[r4]                                 
0802F59C 197D     add     r5,r7,r5     ;加上X坐标                           
0802F59E 042D     lsl     r5,r5,10h                               
0802F5A0 0C2D     lsr     r5,r5,10h                               
0802F5A2 3404     add     r4,4h                                   
0802F5A4 8824     ldrh    r4,[r4]      ;读取Sa右部分界                           
0802F5A6 193C     add     r4,r7,r4     ;加上X坐标                           
0802F5A8 0424     lsl     r4,r4,10h                               
0802F5AA 0C24     lsr     r4,r4,10h                               
0802F5AC 9600     str     r6,[sp]                                 
0802F5AE 4646     mov     r6,r8                                   
0802F5B0 9601     str     r6,[sp,4h]                              
0802F5B2 9502     str     r5,[sp,8h]                              
0802F5B4 9403     str     r4,[sp,0Ch]                             
0802F5B6 F7DFF89F bl      800E6F8h     ;检查是否接触                           
0802F5BA 2800     cmp     r0,0h                                   
0802F5BC D012     beq     @@ReturnZero                                
0802F5BE 4650     mov     r0,r10       ;没有接触的话                           
0802F5C0 8801     ldrh    r1,[r0]                                 
0802F5C2 2040     mov     r0,40h       ;取向and40h                              
0802F5C4 4008     and     r0,r1                                   
0802F5C6 2800     cmp     r0,0h                                   
0802F5C8 D00A     beq     @@FaceLeft                                
0802F5CA 45B9     cmp     r9,r7        ;精灵X坐标比SaX坐标                           
0802F5CC D20A     bcs     @@ReturnZero ;大于等于,即在右,而又面右故返回0

@@Back:                               
0802F5CE 2001     mov     r0,1h                                   
0802F5D0 E009     b       @@end                                

@@FaceLeft:                              
0802F5E0 45B9     cmp     r9,r7                                   
0802F5E2 D8F4     bhi     @@Back

@@ReturnZero:                               
0802F5E4 2000     mov     r0,0h

@@end:                                   
0802F5E6 B004     add     sp,10h                                  
0802F5E8 BC38     pop     r3-r5                                   
0802F5EA 4698     mov     r8,r3                                   
0802F5EC 46A1     mov     r9,r4                                   
0802F5EE 46AA     mov     r10,r5                                  
0802F5F0 BCF0     pop     r4-r7                                   
0802F5F2 BC02     pop     r1                                      
0802F5F4 4708     bx      r1                                      


;pose 0                                 ;产卵
0802F5F8 B530     push    r4,r5,r14                               
0802F5FA 4C1F     ldr     r4,=3000738h                            
0802F5FC 2500     mov     r5,0h                                   
0802F5FE 2100     mov     r1,0h                                   
0802F600 481E     ldr     r0,=0FF8Ch                              
0802F602 8160     strh    r0,[r4,0Ah]   ;上部分界写入NEG 74                          
0802F604 81A1     strh    r1,[r4,0Ch]   ;下部分界写入0                          
0802F606 3058     add     r0,58h                                  
0802F608 81E0     strh    r0,[r4,0Eh]   ;左部分界写入NEG 1C                          
0802F60A 201C     mov     r0,1Ch                                  
0802F60C 8220     strh    r0,[r4,10h]   ;右部分界写入1C                          
0802F60E 1C22     mov     r2,r4                                   
0802F610 3227     add     r2,27h                                  
0802F612 2028     mov     r0,28h                                  
0802F614 7010     strb    r0,[r2]       ;75f写入28h                         
0802F616 1C20     mov     r0,r4                                   
0802F618 3028     add     r0,28h                                  
0802F61A 7005     strb    r5,[r0]       ;760写入0                          
0802F61C 3202     add     r2,2h                                   
0802F61E 2010     mov     r0,10h                                  
0802F620 7010     strb    r0,[r2]       ;761写入10                          
0802F622 4817     ldr     r0,=82E7BCCh                            
0802F624 61A0     str     r0,[r4,18h]   ;平时蜷缩不动的OAM                          
0802F626 7725     strb    r5,[r4,1Ch]                             
0802F628 82E1     strh    r1,[r4,16h]                             
0802F62A 3209     add     r2,9h                                   
0802F62C 7811     ldrb    r1,[r2]       ;读取碰撞属性                          
0802F62E 2040     mov     r0,40h                                  
0802F630 4308     orr     r0,r1         ;orr 40 无敌                           
0802F632 7010     strb    r0,[r2]       ;再写入                          
0802F634 1C20     mov     r0,r4                                   
0802F636 302D     add     r0,2Dh                                  
0802F638 7005     strb    r5,[r0]       ;765写入0                          
0802F63A 1C21     mov     r1,r4                                   
0802F63C 3125     add     r1,25h                                  
0802F63E 2001     mov     r0,1h                                   
0802F640 7008     strb    r0,[r1]       ;属性写入1                          
0802F642 4A10     ldr     r2,=82B0D68h                            
0802F644 7F61     ldrb    r1,[r4,1Dh]                             
0802F646 00C8     lsl     r0,r1,3h                                
0802F648 1840     add     r0,r0,r1                                
0802F64A 0040     lsl     r0,r0,1h                                
0802F64C 1880     add     r0,r0,r2                                
0802F64E 8800     ldrh    r0,[r0]                                 
0802F650 82A0     strh    r0,[r4,14h]   ;写入最高血量                          
0802F652 F7E0F95F bl      800F914h      ;判断面向的例程                          
0802F656 8821     ldrh    r1,[r4]                                 
0802F658 2040     mov     r0,40h        ;40and取向                          
0802F65A 4008     and     r0,r1                                   
0802F65C 2800     cmp     r0,0h                                   
0802F65E D004     beq     @@FaceLeft                                
0802F660 2280     mov     r2,80h                                  
0802F662 0092     lsl     r2,r2,2h                                
0802F664 1C10     mov     r0,r2                                   
0802F666 4308     orr     r0,r1         ;取向Orr200                          
0802F668 8020     strh    r0,[r4]       ;再写入

@@FaceLeft:                                 
0802F66A 1C21     mov     r1,r4                                   
0802F66C 3124     add     r1,24h                                  
0802F66E 2011     mov     r0,11h        ;pose写入11                           
0802F670 7008     strb    r0,[r1]                                 
0802F672 BC30     pop     r4,r5                                   
0802F674 BC01     pop     r0                                      
0802F676 4700     bx      r0                                      

;pose 10h       正常写入                
0802F688 4905     ldr     r1,=3000738h                            
0802F68A 1C0A     mov     r2,r1                                   
0802F68C 3224     add     r2,24h                                  
0802F68E 2300     mov     r3,0h                                   
0802F690 2011     mov     r0,11h                                  
0802F692 7010     strb    r0,[r2]       ;pose写入11h                            
0802F694 4803     ldr     r0,=82E7BCCh  ;蜷缩不动的OAM                          
0802F696 6188     str     r0,[r1,18h]                             
0802F698 2000     mov     r0,0h                                   
0802F69A 82CB     strh    r3,[r1,16h]                             
0802F69C 7708     strb    r0,[r1,1Ch]                             
0802F69E 4770     bx      r14                                     

;pose 11h            ;检查是否在空中,以及是否被击打
0802F6A8 B510     push    r4,r14                                  
0802F6AA 4C05     ldr     r4,=3000738h                            
0802F6AC 8860     ldrh    r0,[r4,2h]     ;读取Y坐标                          
0802F6AE 88A1     ldrh    r1,[r4,4h]     ;读取X坐标                         
0802F6B0 F7E0F836 bl      800F720h       ;检查砖块,脚下?                         
0802F6B4 2800     cmp     r0,0h                                   
0802F6B6 D105     bne     @@OnFloor                                
0802F6B8 1C21     mov     r1,r4                                   
0802F6BA 3124     add     r1,24h                                  
0802F6BC 2020     mov     r0,20h                                  
0802F6BE E00B     b       @@Write                                

@@OnFloor:                               
0802F6C4 1C20     mov     r0,r4                                   
0802F6C6 302B     add     r0,2Bh                                  
0802F6C8 7801     ldrb    r1,[r0]         ;读取无敌时间                          
0802F6CA 207F     mov     r0,7Fh                                  
0802F6CC 4008     and     r0,r1           ;7f and                        
0802F6CE 2800     cmp     r0,0h                                   
0802F6D0 D003     beq     @@end                                
0802F6D2 1C21     mov     r1,r4                                   
0802F6D4 3124     add     r1,24h          ;无敌时间不为0则pose写入12h                        
0802F6D6 2012     mov     r0,12h

@@Write:                                  
0802F6D8 7008     strb    r0,[r1]

@@end                                 
0802F6DA BC10     pop     r4                                      
0802F6DC BC01     pop     r0                                      
0802F6DE 4700     bx      r0

;pose 12           被击打站立                            
0802F6E0 B500     push    r14                                     
0802F6E2 490A     ldr     r1,=3000738h                            
0802F6E4 1C0A     mov     r2,r1                                   
0802F6E6 3224     add     r2,24h                                  
0802F6E8 2300     mov     r3,0h                                   
0802F6EA 2013     mov     r0,13h                                  
0802F6EC 7010     strb    r0,[r2]       ;pose写入13                             
0802F6EE 4808     ldr     r0,=82E7C0Ch  ;站立的OAM                          
0802F6F0 6188     str     r0,[r1,18h]                             
0802F6F2 2000     mov     r0,0h                                   
0802F6F4 82CB     strh    r3,[r1,16h]                             
0802F6F6 7708     strb    r0,[r1,1Ch]                             
0802F6F8 8809     ldrh    r1,[r1]                                 
0802F6FA 2002     mov     r0,2h                                   
0802F6FC 4008     and     r0,r1         ;取向AND2 检查是否在屏幕                           
0802F6FE 2800     cmp     r0,0h                                   
0802F700 D002     beq     @@end                                
0802F702 4804     ldr     r0,=26Fh                                
0802F704 F7D3FA0C bl      8002B20h      ;播放声音

@@end:                               
0802F708 BC01     pop     r0                                      
0802F70A 4700     bx      r0                                      

;pose 13                               
0802F718 B500     push    r14                                     
0802F71A F7E0FA71 bl      800FC00h      ;读取动画                          
0802F71E 2800     cmp     r0,0h                                   
0802F720 D003     beq     @@end                                
0802F722 4803     ldr     r0,=3000738h                            
0802F724 3024     add     r0,24h        ;pose写入0E                          
0802F726 210E     mov     r1,0Eh                                  
0802F728 7001     strb    r1,[r0] 

@@end:                                
0802F72A BC01     pop     r0                                      
0802F72C 4700     bx      r0                                      

;调用                              
0802F734 B5F0     push    r4-r7,r14                               
0802F736 4657     mov     r7,r10                                  
0802F738 464E     mov     r6,r9                                   
0802F73A 4645     mov     r5,r8                                   
0802F73C B4E0     push    r5-r7                                   
0802F73E B086     add     sp,-18h                                 
0802F740 2000     mov     r0,0h                                   
0802F742 4680     mov     r8,r0                                   
0802F744 4B38     ldr     r3,=3000738h                            
0802F746 8859     ldrh    r1,[r3,2h]      ;读取Y坐标                        
0802F748 889A     ldrh    r2,[r3,4h]      ;读取X坐标                        
0802F74A 8958     ldrh    r0,[r3,0Ah]     ;读取上部分界                        
0802F74C 1808     add     r0,r1,r0        ;加上Y坐标                        
0802F74E 0400     lsl     r0,r0,10h                               
0802F750 0C00     lsr     r0,r0,10h                               
0802F752 4681     mov     r9,r0           ;给R9    极上                     
0802F754 8998     ldrh    r0,[r3,0Ch]     ;读取下部分界                        
0802F756 1809     add     r1,r1,r0        ;加上Y坐标                        
0802F758 0409     lsl     r1,r1,10h                               
0802F75A 0C0F     lsr     r7,r1,10h       ;给R7    极下                    
0802F75C 89D8     ldrh    r0,[r3,0Eh]     ;读取左部分界                        
0802F75E 1810     add     r0,r2,r0        ;加上X坐标                        
0802F760 0400     lsl     r0,r0,10h                               
0802F762 0C00     lsr     r0,r0,10h       ;极左                        
0802F764 9005     str     r0,[sp,14h]     ;写入SP14                        
0802F766 8A18     ldrh    r0,[r3,10h]     ;读取右部分界                        
0802F768 1812     add     r2,r2,r0        ;加上X坐标                        
0802F76A 0412     lsl     r2,r2,10h                               
0802F76C 0C12     lsr     r2,r2,10h                               
0802F76E 4692     mov     r10,r2          ;极右写入 r10                        
0802F770 4C2E     ldr     r4,=3000A2Ch    ;弹丸数据起始                        
0802F772 21E0     mov     r1,0E0h                                 
0802F774 0049     lsl     r1,r1,1h        ;1C0                        
0802F776 1860     add     r0,r4,r1                                
0802F778 4284     cmp     r4,r0                                   
0802F77A D300     bcc     @@Loop                                
0802F77C E09D     b       @@end 

@@Loop:                               
0802F77E 7820     ldrb    r0,[r4]        ;检查射击????                         
0802F780 2111     mov     r1,11h                                  
0802F782 4008     and     r0,r1          ;如果是炸弹类的则继续循环检查                         
0802F784 2811     cmp     r0,11h                                  
0802F786 D000     beq     @@NoBome                               
0802F788 E092     b       @@ADD 

@@NoBome:                               
0802F78A 7BE0     ldrb    r0,[r4,0Fh]    ;读取弹丸属性???                          
0802F78C 9004     str     r0,[sp,10h]    ;写入SP10                         
0802F78E 380C     sub     r0,0Ch         ;减去0C                         
0802F790 0600     lsl     r0,r0,18h                               
0802F792 0E00     lsr     r0,r0,18h                               
0802F794 2801     cmp     r0,1h          ;比较是否小于等于1,是的话则是导弹类                        
0802F796 D900     bls     @@Missle                                
0802F798 E08A     b       @@ADD 

@@Missle:                               
0802F79A 8926     ldrh    r6,[r4,8h]     ;读取弹丸Y坐标                         
0802F79C 8965     ldrh    r5,[r4,0Ah]    ;读取弹丸X坐标                         
0802F79E 8AA3     ldrh    r3,[r4,14h]                             
0802F7A0 18F3     add     r3,r6,r3       ;上部分界加上Y坐标                         
0802F7A2 041B     lsl     r3,r3,10h                               
0802F7A4 0C1B     lsr     r3,r3,10h                               
0802F7A6 8AE2     ldrh    r2,[r4,16h]    ;下部分界加上Y坐标                         
0802F7A8 18B2     add     r2,r6,r2                                
0802F7AA 0412     lsl     r2,r2,10h                               
0802F7AC 0C12     lsr     r2,r2,10h                               
0802F7AE 8B21     ldrh    r1,[r4,18h]    ;左部分界加上X坐标                         
0802F7B0 1869     add     r1,r5,r1                                
0802F7B2 0409     lsl     r1,r1,10h                               
0802F7B4 0C09     lsr     r1,r1,10h                               
0802F7B6 8B60     ldrh    r0,[r4,1Ah]    ;右部分界加上X坐标                         
0802F7B8 1828     add     r0,r5,r0                                
0802F7BA 0400     lsl     r0,r0,10h                               
0802F7BC 0C00     lsr     r0,r0,10h                               
0802F7BE 9300     str     r3,[sp]                                 
0802F7C0 9201     str     r2,[sp,4h]                              
0802F7C2 9102     str     r1,[sp,8h]                              
0802F7C4 9003     str     r0,[sp,0Ch]                             
0802F7C6 4648     mov     r0,r9                                   
0802F7C8 1C39     mov     r1,r7                                   
0802F7CA 9A05     ldr     r2,[sp,14h]                             
0802F7CC 4653     mov     r3,r10                                  
0802F7CE F7DEFF93 bl      800E6F8h       ;检查是否相交                          
0802F7D2 2800     cmp     r0,0h                                   
0802F7D4 D06C     beq     @@ADD          ;如果没有相交则继续循环检查下一个                      
0802F7D6 7C20     ldrb    r0,[r4,10h]    ;如果相交读取弹丸方向                         
0802F7D8 2800     cmp     r0,0h                                   
0802F7DA D008     beq     @@HorDir       ;水平方向                                
0802F7DC 3801     sub     r0,1h                                    
0802F7DE 0600     lsl     r0,r0,18h                               
0802F7E0 0E00     lsr     r0,r0,18h                               
0802F7E2 2801     cmp     r0,1h                                   
0802F7E4 D808     bhi     @@Peer        ;上或下方向                        
0802F7E6 454E     cmp     r6,r9         ;弹丸Y坐标比极上                          
0802F7E8 D906     bls     @@Peer        ;小于等于 也就是说比极上还上                       
0802F7EA 42BE     cmp     r6,r7         ;弹丸Y坐标比极下                          
0802F7EC D204     bcs     @@Peer        ;大于等于 也就是说比极下还下

@@HorDir:                              
0802F7EE 4640     mov     r0,r8                                   
0802F7F0 3001     add     r0,1h                                   
0802F7F2 0600     lsl     r0,r0,18h                               
0802F7F4 0E00     lsr     r0,r0,18h                               
0802F7F6 4680     mov     r8,r0         ;r8加1 被导弹攻击的累计值

@@Peer:                                   
0802F7F8 4641     mov     r1,r8                                   
0802F7FA 2900     cmp     r1,0h         ;比较导类攻击累计值是否为0                           
0802F7FC D035     beq     @@MissleHitZero                                
0802F7FE 7821     ldrb    r1,[r4]                                 
0802F800 2340     mov     r3,40h                                  
0802F802 1C18     mov     r0,r3                                   
0802F804 4008     and     r0,r1         ;导弹取向and 40h                          
0802F806 2800     cmp     r0,0h         ;为0则代表是向左发射的                          
0802F808 D014     beq     @@MissleLeftDir                                
0802F80A 9D05     ldr     r5,[sp,14h]                             
0802F80C 4806     ldr     r0,=3000738h  ;导弹向右发射                          
0802F80E 8802     ldrh    r2,[r0]       ;读取取向                          
0802F810 2780     mov     r7,80h                                  
0802F812 00BF     lsl     r7,r7,2h                                
0802F814 1C39     mov     r1,r7                                   
0802F816 4311     orr     r1,r2         ;取向 orr 200                          
0802F818 8001     strh    r1,[r0]       ;再写入                          
0802F81A 4019     and     r1,r3         ;取向and 40                          
0802F81C 1C02     mov     r2,r0                                   
0802F81E 2900     cmp     r1,0h         ;非零则代表金桶向右                          
0802F820 D11C     bne     @@RobotFaceRight                                
0802F822 6990     ldr     r0,[r2,18h]   ;读取OAM                          
0802F824 4902     ldr     r1,=82E7B2Ch  ;导弹和机器异向                          
0802F826 E01B     b       @@Peer2                                

@@MissleLeftDir:                        ;导弹向左发射           
0802F834 4655     mov     r5,r10                                  
0802F836 4806     ldr     r0,=3000738h                            
0802F838 8801     ldrh    r1,[r0]       ;读取精灵取向                          
0802F83A 4F06     ldr     r7,=0FDFFh                              
0802F83C 1C3A     mov     r2,r7         ;取向去掉200h                          
0802F83E 4011     and     r1,r2                                   
0802F840 8001     strh    r1,[r0]       ;再写入                          
0802F842 4019     and     r1,r3         ;取向and 40                          
0802F844 1C02     mov     r2,r0                                   
0802F846 2900     cmp     r1,0h         ;如果为0则代表向左                          
0802F848 D008     beq     @@RobotFaceSameMissle                                
0802F84A 6990     ldr     r0,[r2,18h]                             
0802F84C 4902     ldr     r1,=82E7B2Ch  ;后退的OAM                          
0802F84E E007     b       @@Peer2                                

@@RobotFaceSameMissle:           ;导弹和机器都向右                    
0802F85C 6990     ldr     r0,[r2,18h]  ;读取OAM                           
0802F85E 490A     ldr     r1,=82E7AE4h ;击前进的OAM

@@Peer2:                           
0802F860 4288     cmp     r0,r1                                   
0802F862 D000     beq     @@Pass       ;OAM相等                           
0802F864 6191     str     r1,[r2,18h]  ;不等则重新写入

@@Pass:                           
0802F866 2000     mov     r0,0h                                   
0802F868 7710     strb    r0,[r2,1Ch]  ;动画帧写入0

@@MissleHitZero:                             
0802F86A 9804     ldr     r0,[sp,10h]  ;读取弹丸属性                           
0802F86C 280D     cmp     r0,0Dh                                  
0802F86E D10F     bne     @@NormalMissleHit                                
0802F870 1C30     mov     r0,r6        ;弹丸的坐标 ?                          
0802F872 1C29     mov     r1,r5                                    
0802F874 2231     mov     r2,31h                                  
0802F876 F024FC39 bl      80540ECh     ;超级导弹击打特效                            
0802F87A 4641     mov     r1,r8        ;打击累计值                           
0802F87C 2900     cmp     r1,0h                                   
0802F87E D012     beq     @@HitZero                                
0802F880 203C     mov     r0,3Ch                                  
0802F882 4F02     ldr     r7,=3000765h                            
0802F884 7038     strb    r0,[r7]      ;不为0的话765写入3Ch                           
0802F886 E00E     b       @@HitZero                                

@@NormalMissleHit:                              
0802F890 1C30     mov     r0,r6                                   
0802F892 1C29     mov     r1,r5                                   
0802F894 2230     mov     r2,30h       ;导弹击打的特效                             
0802F896 F024FC29 bl      80540ECh                                
0802F89A 4640     mov     r0,r8                                   
0802F89C 2800     cmp     r0,0h                                   
0802F89E D002     beq     @@HitZero                                
0802F8A0 201E     mov     r0,1Eh       ;击打值不为0的话                           
0802F8A2 4902     ldr     r1,=3000765h ;765写入1Eh                           
0802F8A4 7008     strb    r0,[r1] 

@@HitZero:                                
0802F8A6 2000     mov     r0,0h                                   
0802F8A8 7020     strb    r0,[r4]      ;导弹消失                             
0802F8AA E006     b       @@end                                 

@@ADD:                              
0802F8B0 341C     add     r4,1Ch                                  
0802F8B2 4806     ldr     r0,=3000BECh ;弹丸数值加1C比较                           
0802F8B4 4284     cmp     r4,r0                                   
0802F8B6 D200     bcs     @@end        ;如果超出了数据则结束                        
0802F8B8 E761     b       @@Loop       ;否则继续循环检验

@@end:                               
0802F8BA B006     add     sp,18h                                  
0802F8BC BC38     pop     r3-r5                                   
0802F8BE 4698     mov     r8,r3                                   
0802F8C0 46A1     mov     r9,r4                                   
0802F8C2 46AA     mov     r10,r5                                  
0802F8C4 BCF0     pop     r4-r7                                   
0802F8C6 BC01     pop     r0                                      
0802F8C8 4700     bx      r0                                      

;pose 0E                              
0802F8D0 480B     ldr     r0,=3000738h                            
0802F8D2 4684     mov     r12,r0                                  
0802F8D4 4661     mov     r1,r12                                  
0802F8D6 3124     add     r1,24h         ;pose写入F                         
0802F8D8 2300     mov     r3,0h                                   
0802F8DA 200F     mov     r0,0Fh                                  
0802F8DC 7008     strb    r0,[r1]                                 
0802F8DE 4809     ldr     r0,=82E7B74h                            
0802F8E0 4661     mov     r1,r12                                  
0802F8E2 6188     str     r0,[r1,18h]    ;站立的OAM                         
0802F8E4 2200     mov     r2,0h                                   
0802F8E6 82CB     strh    r3,[r1,16h]                             
0802F8E8 770A     strb    r2,[r1,1Ch]                             
0802F8EA 312C     add     r1,2Ch                                  
0802F8EC 201E     mov     r0,1Eh                                  
0802F8EE 7008     strb    r0,[r1]        ;764写入1E                         
0802F8F0 4660     mov     r0,r12                                  
0802F8F2 302D     add     r0,2Dh                                  
0802F8F4 7002     strb    r2,[r0]        ;765写入0                         
0802F8F6 4804     ldr     r0,=0FF7Ch                              
0802F8F8 4661     mov     r1,r12                                  
0802F8FA 8148     strh    r0,[r1,0Ah]    ;上部分界写入NEG 84                        
0802F8FC 4770     bx      r14                                     

;pose F                                
0802F90C B500     push    r14                                     
0802F90E F7FFFF11 bl      802F734h       ;检查导弹类是否击中,并给765写入数值                         
0802F912 4A05     ldr     r2,=3000738h                            
0802F914 1C10     mov     r0,r2                                   
0802F916 302D     add     r0,2Dh                                  
0802F918 7800     ldrb    r0,[r0]        ;读取765的值                           
0802F91A 2800     cmp     r0,0h                                   
0802F91C D006     beq     @@765IsZero                                
0802F91E 1C11     mov     r1,r2                                   
0802F920 3124     add     r1,24h         ;不为0则Pose写入9                         
0802F922 2009     mov     r0,9h          ;同样一旦被攻击则写入9?                         
0802F924 E00C     b       @@End                                

@@765IsZero:                               
0802F92C 1C11     mov     r1,r2                                   
0802F92E 312C     add     r1,2Ch                                  
0802F930 7808     ldrb    r0,[r1]        ;读取764,站立行走的待机值                            
0802F932 3801     sub     r0,1h                                   
0802F934 7008     strb    r0,[r1]        ;减1再写入                         
0802F936 0600     lsl     r0,r0,18h                               
0802F938 2800     cmp     r0,0h                                   
0802F93A D102     bne     @@Thend        ;不为0则结束                        
0802F93C 3908     sub     r1,8h          ;为0则POSE写入8                         
0802F93E 2008     mov     r0,8h 

@@End:                                  
0802F940 7008     strb    r0,[r1] 

@@Thend:                                
0802F942 BC01     pop     r0                                      
0802F944 4700     bx      r0                                      

;pose 08                               
0802F948 4905     ldr     r1,=3000738h                            
0802F94A 1C0A     mov     r2,r1                                   
0802F94C 3224     add     r2,24h                                  
0802F94E 2300     mov     r3,0h                                   
0802F950 2009     mov     r0,9h                                   
0802F952 7010     strb    r0,[r2]         ;pose写入9h                         
0802F954 4803     ldr     r0,=82E7AE4h    ;前走的OAM                         
0802F956 6188     str     r0,[r1,18h]                             
0802F958 2000     mov     r0,0h                                   
0802F95A 82CB     strh    r3,[r1,16h]                             
0802F95C 7708     strb    r0,[r1,1Ch]                             
0802F95E 4770     bx      r14                                     

;pose 9h                             
0802F968 B530     push    r4,r5,r14                               
0802F96A F7DFFE13 bl      800F594h        ;斜坡行走的例程???                           
0802F96E 4817     ldr     r0,=30007F0h    ;并且判断头上部是否有砖块????                        
0802F970 7800     ldrb    r0,[r0]         ;读取7F0                        
0802F972 2800     cmp     r0,0h                                   
0802F974 D13A     bne     @@HaveBlock                                
0802F976 4C16     ldr     r4,=3000738h                            
0802F978 8860     ldrh    r0,[r4,2h]                              
0802F97A 88A1     ldrh    r1,[r4,4h]      ;读取坐标                        
0802F97C 3120     add     r1,20h          ;X坐标加20h                        
0802F97E F7DFFECF bl      800F720h        ;检查右半身下砖块                        
0802F982 2800     cmp     r0,0h                                   
0802F984 D132     bne     @@HaveBlock                                
0802F986 8860     ldrh    r0,[r4,2h]                              
0802F988 88A1     ldrh    r1,[r4,4h]                              
0802F98A 3920     sub     r1,20h                                  
0802F98C F7DFFEC8 bl      800F720h        ;检查左半身下砖块                        
0802F990 1C02     mov     r2,r0                                   
0802F992 2A00     cmp     r2,0h                                   
0802F994 D12A     bne     @@HaveBlock                                
0802F996 1C20     mov     r0,r4                                   
0802F998 3024     add     r0,24h                                  
0802F99A 211E     mov     r1,1Eh                                  
0802F99C 7001     strb    r1,[r0]         ;pose写入1Eh  下落准备                      
0802F99E 1C21     mov     r1,r4                                   
0802F9A0 312D     add     r1,2Dh                                  
0802F9A2 7808     ldrb    r0,[r1]         ;读取3000765                        
0802F9A4 2800     cmp     r0,0h                                   
0802F9A6 D100     bne     @@765NoZero                                
0802F9A8 E104     b       @@end
;-----------------------------------------这意味着脚下无砖块?并且765不是0
@@765NoZero:                                
0802F9AA 700A     strb    r2,[r1]         ;765写入0                         
0802F9AC 8821     ldrh    r1,[r4]         ;读取取向                        
0802F9AE 2040     mov     r0,40h                                  
0802F9B0 4008     and     r0,r1                                   
0802F9B2 2800     cmp     r0,0h                                   
0802F9B4 D00E     beq     @@FaceLeft
;-----------------------------------------面右脚下无砖                                
0802F9B6 2280     mov     r2,80h                                  
0802F9B8 0092     lsl     r2,r2,2h                                
0802F9BA 1C10     mov     r0,r2                                   
0802F9BC 4008     and     r0,r1                                   
0802F9BE 2800     cmp     r0,0h           ;取向and 200h                         
0802F9C0 D000     beq     @@Pass                                
0802F9C2 E0F7     b       @@end           

@@Pass:                     
0802F9C4 1C10     mov     r0,r2           ;取向如果没有200h则加上200h再写入                        
0802F9C6 4308     orr     r0,r1                                   
0802F9C8 8020     strh    r0,[r4]         ;取向orr200h                         
0802F9CA E0F3     b       @@end                                
;-----------------------------------------面左脚下无砖
@@FaceLeft:                              
0802F9D4 2080     mov     r0,80h                                  
0802F9D6 0080     lsl     r0,r0,2h                                
0802F9D8 4008     and     r0,r1                                   
0802F9DA 2800     cmp     r0,0h                                   
0802F9DC D100     bne     @@Pass2                                
0802F9DE E0E9     b       @@end    

@@Pass2                            
0802F9E0 4801     ldr     r0,=0FDFFh      ;取向如果有200h则去掉200h再写入                          
0802F9E2 4008     and     r0,r1                                   
0802F9E4 8020     strh    r0,[r4]         ;取向去掉200h                            
0802F9E6 E0E5     b       @@end                                
;-----------------------------------------脚下有砖
@@HaveBlock:                               
0802F9EC 2501     mov     r5,1h                                   
0802F9EE F7FFFEA1 bl      802F734h      ;检查导弹类射击                          
0802F9F2 4A11     ldr     r2,=3000738h                            
0802F9F4 1C10     mov     r0,r2                                   
0802F9F6 302D     add     r0,2Dh                                  
0802F9F8 7800     ldrb    r0,[r0]       ;读取765的值                          
0802F9FA 2800     cmp     r0,0h                                   
0802F9FC D04A     beq     @@765Zero    
;---------------------------------------765不为0                            
0802F9FE 8811     ldrh    r1,[r2]       ;读取取向                          
0802FA00 2002     mov     r0,2h                                   
0802FA02 4008     and     r0,r1         ;and 2h                          
0802FA04 2800     cmp     r0,0h                                   
0802FA06 D00A     beq     @@NoInScreenAnd??                                
0802FA08 8AD1     ldrh    r1,[r2,16h]   ;读取动画                          
0802FA0A 2003     mov     r0,3h                                   
0802FA0C 4008     and     r0,r1         ;and3                          
0802FA0E 2803     cmp     r0,3h                                   
0802FA10 D105     bne     @@NoInScreenAnd??                                
0802FA12 7F10     ldrb    r0,[r2,1Ch]   ;读取动画帧                          
0802FA14 2806     cmp     r0,6h                                   
0802FA16 D102     bne     @@NoInScreenAnd??                                
0802FA18 4808     ldr     r0,=26Eh      ;播放声音 金桶脚部声                         
0802FA1A F7D3F881 bl      8002B20h 

@@NoInScreenAnd??:                               
0802FA1E 4806     ldr     r0,=3000738h                            
0802FA20 7F01     ldrb    r1,[r0,1Ch]                             
0802FA22 3104     add     r1,4h         ;读取动画帧加4再写入                          
0802FA24 7701     strb    r1,[r0,1Ch]                             
0802FA26 1C01     mov     r1,r0                                   
0802FA28 312D     add     r1,2Dh                                  
0802FA2A 7809     ldrb    r1,[r1]       ;读取765的值                          
0802FA2C 088D     lsr     r5,r1,2h      ;除以4h                          
0802FA2E 1C03     mov     r3,r0                                   
0802FA30 2D08     cmp     r5,8h         ;比较是否小于8h                          
0802FA32 D905     bls     @@NoBhi8                                
0802FA34 2508     mov     r5,8h         ;如果大于8则给予8                          
0802FA36 E006     b       @@NoZeroOrBhi8                                

@@NoBhi8:                                
0802FA40 2D00     cmp     r5,0h         ;比较是否为0                           
0802FA42 D100     bne     @@NoZeroOrBhi8                                
0802FA44 2501     mov     r5,1h  

@@NoZeroOrBhi8:                                 
0802FA46 1C19     mov     r1,r3                                   
0802FA48 1C0A     mov     r2,r1                                   
0802FA4A 322D     add     r2,2Dh                                  
0802FA4C 7810     ldrb    r0,[r2]       ;读取765                              
0802FA4E 3801     sub     r0,1h         ;减1再写入                          
0802FA50 7010     strb    r0,[r2]                                 
0802FA52 0600     lsl     r0,r0,18h                               
0802FA54 2800     cmp     r0,0h                                   
0802FA56 D13B     bne     @@765NoZero2  
;---------------------------------------765减1为0                              
0802FA58 880A     ldrh    r2,[r1]       ;读取取向                           
0802FA5A 2040     mov     r0,40h                                  
0802FA5C 4010     and     r0,r2                                   
0802FA5E 2800     cmp     r0,0h                                   
0802FA60 D009     beq     @@FaceLeft2 
;---------------------------------------面右                               
0802FA62 2380     mov     r3,80h                                  
0802FA64 009B     lsl     r3,r3,2h                                
0802FA66 1C18     mov     r0,r3                                   
0802FA68 4010     and     r0,r2                                   
0802FA6A 2800     cmp     r0,0h         ;取向如果无200h则ORR200h                          
0802FA6C D10C     bne     @@Goto                                
0802FA6E 1C18     mov     r0,r3                                   
0802FA70 4310     orr     r0,r2                                   
0802FA72 8008     strh    r0,[r1]                                 
0802FA74 E008     b       @@Goto 
;---------------------------------------面左
@@FaceLeft2:                               
0802FA76 2080     mov     r0,80h                                  
0802FA78 0080     lsl     r0,r0,2h                                
0802FA7A 4010     and     r0,r2                                   
0802FA7C 2800     cmp     r0,0h                                   
0802FA7E D002     beq     @@Pass3                                
0802FA80 4803     ldr     r0,=0FDFFh                              
0802FA82 4010     and     r0,r2                                   
0802FA84 8008     strh    r0,[r1]       ;取向去掉200h

@@Pass3:                           
0802FA86 1C19     mov     r1,r3 

@@Goto:                                  
0802FA88 3124     add     r1,24h                                  
0802FA8A 200E     mov     r0,0Eh                                  
0802FA8C 7008     strb    r0,[r1]       ;写入站立的POSE                           
0802FA8E E091     b       @@end                                

@@765Zero:                               
0802FA94 8811     ldrh    r1,[r2]                                 
0802FA96 2002     mov     r0,2h                                   
0802FA98 4008     and     r0,r1                                   
0802FA9A 2800     cmp     r0,0h                                   
0802FA9C D00A     beq     @@Peer3                                
0802FA9E 8AD1     ldrh    r1,[r2,16h]   ;读取动画and3                          
0802FAA0 2003     mov     r0,3h                                   
0802FAA2 4008     and     r0,r1                                   
0802FAA4 2803     cmp     r0,3h                                   
0802FAA6 D105     bne     @@Peer3                                
0802FAA8 7F10     ldrb    r0,[r2,1Ch]                             
0802FAAA 2808     cmp     r0,8h                                   
0802FAAC D102     bne     @@Peer3       ;检查动画帧是否是8h                         
0802FAAE 4806     ldr     r0,=26Eh      ;脚部声                          
0802FAB0 F7D3F836 bl      8002B20h 

@@Peer3:                               
0802FAB4 F7FFFD3E bl      802F534h      ;检查与Sa是否碰撞的例程                          
0802FAB8 0600     lsl     r0,r0,18h                               
0802FABA 2800     cmp     r0,0h                                   
0802FABC D008     beq     @@765NoZero2                                
0802FABE 4803     ldr     r0,=3000738h                            
0802FAC0 3024     add     r0,24h        ;Pose写入Ah 闭眼蹲下预备                         
0802FAC2 210A     mov     r1,0Ah                                  
0802FAC4 7001     strb    r1,[r0]                                 
0802FAC6 E075     b       @@end                                

@@765NoZero2:                               
0802FAD0 4C18     ldr     r4,=3000738h                            
0802FAD2 8821     ldrh    r1,[r4]                                 
0802FAD4 2080     mov     r0,80h                                  
0802FAD6 0080     lsl     r0,r0,2h                                
0802FAD8 4008     and     r0,r1                                   
0802FADA 2800     cmp     r0,0h        ;取向and 200h                            
0802FADC D030     beq     @@取向无200h ;也就是说向左退???? 
;--------------------------------------取向有200h  向右移动                            
0802FADE 4816     ldr     r0,=30007F0h ;在平地上11,上斜坡小于10                           
0802FAE0 7801     ldrb    r1,[r0]                                 
0802FAE2 20F0     mov     r0,0F0h                                 
0802FAE4 4008     and     r0,r1                                   
0802FAE6 2800     cmp     r0,0h                                   
0802FAE8 D016     beq     @@7F0无10    ;在斜坡上???? 
;--------------------------------------不在斜坡上??                           
0802FAEA 1C20     mov     r0,r4                                   
0802FAEC 302D     add     r0,2Dh                                  
0802FAEE 7800     ldrb    r0,[r0]      ;读取765的值                             
0802FAF0 2800     cmp     r0,0h                                   
0802FAF2 D106     bne     @@765NoZero3                                
0802FAF4 8860     ldrh    r0,[r4,2h]                              
0802FAF6 88A1     ldrh    r1,[r4,4h]   ;读取X坐标                            
0802FAF8 3120     add     r1,20h       ;X坐标右半格                           
0802FAFA F7DFFE11 bl      800F720h     ;检查脚下右砖块                           
0802FAFE 2800     cmp     r0,0h                                   
0802FB00 D040     beq     @@NoBlock
;--------------------------------------脚下有砖或者765不为0
@@765NoZero3:                                
0802FB02 4C0C     ldr     r4,=3000738h                            
0802FB04 8860     ldrh    r0,[r4,2h]                              
0802FB06 3848     sub     r0,48h       ;Y坐标向上48h                           
0802FB08 88A1     ldrh    r1,[r4,4h]                              
0802FB0A 3128     add     r1,28h       ;X坐标向右28h                           
0802FB0C F7DFFE08 bl      800F720h     ;检查砖块                           
0802FB10 0600     lsl     r0,r0,18h                               
0802FB12 0E00     lsr     r0,r0,18h                               
0802FB14 2811     cmp     r0,11h                                  
0802FB16 D030     beq     @@Clip11?
;---------------------------------------前方砖块非11或在斜坡上
@@7F0无10:                               
0802FB18 4906     ldr     r1,=3000738h                            
0802FB1A 8888     ldrh    r0,[r1,4h]    ;读取X坐标                          
0802FB1C 1828     add     r0,r5,r0      ;加上移动值                          
0802FB1E 8088     strh    r0,[r1,4h]    ;再写入                          
0802FB20 8809     ldrh    r1,[r1]                                 
0802FB22 2080     mov     r0,80h                                  
0802FB24 0140     lsl     r0,r0,5h                                
0802FB26 4008     and     r0,r1                                   
0802FB28 2800     cmp     r0,0h         ;取向and 1000如果等于0则结束                          
0802FB2A D043     beq     @@end                                
0802FB2C 4903     ldr     r1,=30013D4h  ;否则读取SaX坐标                          
0802FB2E 8A48     ldrh    r0,[r1,12h]                             
0802FB30 1828     add     r0,r5,r0      ;同样加上移动值                          
0802FB32 E03E     b       @@Thend                                

@@取向无200h:                           ;导弹向左发射,也就是向左移动
0802FB40 4813     ldr     r0,=30007F0h                            
0802FB42 7801     ldrb    r1,[r0]                                 
0802FB44 20F0     mov     r0,0F0h                                 
0802FB46 4008     and     r0,r1                                   
0802FB48 2800     cmp     r0,0h                                   
0802FB4A D025     beq     802FB98h                                
0802FB4C 1C20     mov     r0,r4                                   
0802FB4E 302D     add     r0,2Dh                                  
0802FB50 7800     ldrb    r0,[r0]                                 
0802FB52 2800     cmp     r0,0h                                   
0802FB54 D106     bne     802FB64h                                
0802FB56 8860     ldrh    r0,[r4,2h]                              
0802FB58 88A1     ldrh    r1,[r4,4h]                              
0802FB5A 3920     sub     r1,20h                                  
0802FB5C F7DFFDE0 bl      800F720h                                
0802FB60 2800     cmp     r0,0h                                   
0802FB62 D00F     beq     802FB84h                                
0802FB64 4C0B     ldr     r4,=3000738h                            
0802FB66 8860     ldrh    r0,[r4,2h]                              
0802FB68 3848     sub     r0,48h                                  
0802FB6A 88A1     ldrh    r1,[r4,4h]                              
0802FB6C 3928     sub     r1,28h                                  
0802FB6E F7DFFDD7 bl      800F720h                                
0802FB72 0600     lsl     r0,r0,18h                               
0802FB74 0E00     lsr     r0,r0,18h                               
0802FB76 2811     cmp     r0,11h                                  
0802FB78 D10E     bne     802FB98h 

@@Clip11?:                               
0802FB7A 1C20     mov     r0,r4                                   
0802FB7C 302D     add     r0,2Dh                                  
0802FB7E 7800     ldrb    r0,[r0]                                 
0802FB80 2800     cmp     r0,0h                                   
0802FB82 D117     bne     @@end 
;-----------------------------------765为0或前方无砖
@@NoBlock:                               
0802FB84 1C21     mov     r1,r4                                   
0802FB86 3124     add     r1,24h                                  
0802FB88 200A     mov     r0,0Ah          ;为0则写入蹲下预备                        
0802FB8A 7008     strb    r0,[r1]         ;pose写入0Ah                               
0802FB8C E012     b       @@end                                

                         
0802FB98 4908     ldr     r1,=3000738h                            
0802FB9A 8888     ldrh    r0,[r1,4h]                              
0802FB9C 1B40     sub     r0,r0,r5                                
0802FB9E 8088     strh    r0,[r1,4h]                              
0802FBA0 8809     ldrh    r1,[r1]                                 
0802FBA2 2080     mov     r0,80h                                  
0802FBA4 0140     lsl     r0,r0,5h                                
0802FBA6 4008     and     r0,r1                                   
0802FBA8 2800     cmp     r0,0h                                   
0802FBAA D003     beq     @@end                                
0802FBAC 4904     ldr     r1,=30013D4h                            
0802FBAE 8A48     ldrh    r0,[r1,12h]                             
0802FBB0 1B40     sub     r0,r0,r5  

@@Thend:                              
0802FBB2 8248     strh    r0,[r1,12h]

@@end:                             
0802FBB4 BC30     pop     r4,r5                                   
0802FBB6 BC01     pop     r0                                      
0802FBB8 4700     bx      r0                                      


;pose A                            
0802FBC4 B500     push    r14                                     
0802FBC6 490B     ldr     r1,=3000738h                            
0802FBC8 1C0A     mov     r2,r1                                   
0802FBCA 3224     add     r2,24h                                  
0802FBCC 2300     mov     r3,0h                                   
0802FBCE 200B     mov     r0,0Bh                                  
0802FBD0 7010     strb    r0,[r2]       ;pose写入B                         
0802FBD2 4809     ldr     r0,=82E7B84h  ;新OAM                          
0802FBD4 6188     str     r0,[r1,18h]                             
0802FBD6 2000     mov     r0,0h                                   
0802FBD8 82CB     strh    r3,[r1,16h]                             
0802FBDA 7708     strb    r0,[r1,1Ch]                             
0802FBDC 8809     ldrh    r1,[r1]                                 
0802FBDE 2002     mov     r0,2h                                   
0802FBE0 4008     and     r0,r1                                   
0802FBE2 2800     cmp     r0,0h                                   
0802FBE4 D003     beq     802FBEEh                                
0802FBE6 209C     mov     r0,9Ch                                  
0802FBE8 0080     lsl     r0,r0,2h                                
0802FBEA F7D2FF99 bl      8002B20h                                
0802FBEE BC01     pop     r0                                      
0802FBF0 4700     bx      r0                                      


;pose B                            
0802FBFC B500     push    r14                                     
0802FBFE F7DFFFE3 bl      800FBC8h                                
0802FC02 2800     cmp     r0,0h                                   
0802FC04 D00B     beq     802FC1Eh                                
0802FC06 4907     ldr     r1,=3000738h                            
0802FC08 1C0A     mov     r2,r1                                   
0802FC0A 3224     add     r2,24h                                  
0802FC0C 2300     mov     r3,0h                                   
0802FC0E 200C     mov     r0,0Ch                                  
0802FC10 7010     strb    r0,[r2]                                 
0802FC12 4805     ldr     r0,=82E7BDCh                            
0802FC14 6188     str     r0,[r1,18h]                             
0802FC16 770B     strb    r3,[r1,1Ch]                             
0802FC18 82CB     strh    r3,[r1,16h]                             
0802FC1A 4804     ldr     r0,=0FF8Ch                              
0802FC1C 8148     strh    r0,[r1,0Ah]                             
0802FC1E BC01     pop     r0                                      
0802FC20 4700     bx      r0                                      


;pose C      
0802FC30 B500     push    r14                                     
0802FC32 F7DFFFC9 bl      800FBC8h        ;检查动画结束                        
0802FC36 2800     cmp     r0,0h                                   
0802FC38 D01C     beq     802FC74h                                
0802FC3A 4905     ldr     r1,=3000738h                            
0802FC3C 880A     ldrh    r2,[r1]                                 
0802FC3E 2040     mov     r0,40h          ;40and 取向                        
0802FC40 4010     and     r0,r2                                   
0802FC42 1C0B     mov     r3,r1                                   
0802FC44 2800     cmp     r0,0h                                   
0802FC46 D007     beq     @@FaceLeft                               
0802FC48 4802     ldr     r0,=0FDBFh   ;取向去掉240                        
0802FC4A 4010     and     r0,r2                                   
0802FC4C E008     b       802FC60h                                

@@FaceLeft:                               
0802FC58 2190     mov     r1,90h                                  
0802FC5A 0089     lsl     r1,r1,2h                                
0802FC5C 1C08     mov     r0,r1                                   
0802FC5E 4310     orr     r0,r2     ;取向ORR240h

@@Peer:                                 
0802FC60 8018     strh    r0,[r3]                                 
0802FC62 1C19     mov     r1,r3                                   
0802FC64 3124     add     r1,24h                                  
0802FC66 2200     mov     r2,0h                                   
0802FC68 200D     mov     r0,0Dh                                  
0802FC6A 7008     strb    r0,[r1]                                 
0802FC6C 4802     ldr     r0,=82E7BF4h                            
0802FC6E 6198     str     r0,[r3,18h]                             
0802FC70 771A     strb    r2,[r3,1Ch]                             
0802FC72 82DA     strh    r2,[r3,16h]                             
0802FC74 BC01     pop     r0                                      
0802FC76 4700     bx      r0                                      


;pose D  转身2                           
0802FC7C B500     push    r14                                     
0802FC7E F7DFFFBF bl      800FC00h                                
0802FC82 2800     cmp     r0,0h                                   
0802FC84 D003     beq     802FC8Eh                                
0802FC86 4803     ldr     r0,=3000738h                            
0802FC88 3024     add     r0,24h                                  
0802FC8A 2110     mov     r1,10h                                  
0802FC8C 7001     strb    r1,[r0]                                 
0802FC8E BC01     pop     r0                                      
0802FC90 4700     bx      r0                                      
0802FC92 0000     lsl     r0,r0,0h                                
0802FC94 0738     lsl     r0,r7,1Ch                               
0802FC96 0300     lsl     r0,r0,0Ch                               
0802FC98 4B07     ldr     r3,=3000738h                            
0802FC9A 1C1A     mov     r2,r3                                   
0802FC9C 3224     add     r2,24h                                  
0802FC9E 2100     mov     r1,0h                                   
0802FCA0 201F     mov     r0,1Fh                                  
0802FCA2 7010     strb    r0,[r2]                                 
0802FCA4 1C18     mov     r0,r3                                   
0802FCA6 302F     add     r0,2Fh                                  
0802FCA8 7001     strb    r1,[r0]                                 
0802FCAA 3802     sub     r0,2h                                   
0802FCAC 7001     strb    r1,[r0]                                 
0802FCAE 4803     ldr     r0,=82E7AE4h                            
0802FCB0 6198     str     r0,[r3,18h]                             
0802FCB2 7719     strb    r1,[r3,1Ch]                             
0802FCB4 82D9     strh    r1,[r3,16h]                             
0802FCB6 4770     bx      r14                                     
0802FCB8 0738     lsl     r0,r7,1Ch                               
0802FCBA 0300     lsl     r0,r0,0Ch                               
0802FCBC 7AE4     ldrb    r4,[r4,0Bh]                             
0802FCBE 082E     lsr     r6,r5,20h  

                             
0802FCC0 B530     push    r4,r5,r14                               
0802FCC2 4C0B     ldr     r4,=3000738h                            
0802FCC4 7F20     ldrb    r0,[r4,1Ch]                             
0802FCC6 3002     add     r0,2h                                   
0802FCC8 7720     strb    r0,[r4,1Ch]                             
0802FCCA 8860     ldrh    r0,[r4,2h]                              
0802FCCC 88A1     ldrh    r1,[r4,4h]                              
0802FCCE F7DFFBD5 bl      800F47Ch                                
0802FCD2 1C01     mov     r1,r0                                   
0802FCD4 4807     ldr     r0,=30007F0h                            
0802FCD6 7800     ldrb    r0,[r0]                                 
0802FCD8 2800     cmp     r0,0h                                   
0802FCDA D00F     beq     802FCFCh                                
0802FCDC 8061     strh    r1,[r4,2h]                              
0802FCDE 1C20     mov     r0,r4                                   
0802FCE0 3024     add     r0,24h                                  
0802FCE2 210E     mov     r1,0Eh                                  
0802FCE4 7001     strb    r1,[r0]                                 
0802FCE6 4804     ldr     r0,=271h                                
0802FCE8 F7D2FE96 bl      8002A18h                                
0802FCEC E024     b       802FD38h                                
0802FCEE 0000     lsl     r0,r0,0h                                
0802FCF0 0738     lsl     r0,r7,1Ch                               
0802FCF2 0300     lsl     r0,r0,0Ch                               
0802FCF4 07F0     lsl     r0,r6,1Fh                               
0802FCF6 0300     lsl     r0,r0,0Ch                               
0802FCF8 0271     lsl     r1,r6,9h                                
0802FCFA 0000     lsl     r0,r0,0h                                
0802FCFC 202F     mov     r0,2Fh                                  
0802FCFE 1900     add     r0,r0,r4                                
0802FD00 4684     mov     r12,r0                                  
0802FD02 7801     ldrb    r1,[r0]                                 
0802FD04 4B07     ldr     r3,=82B0D04h                            
0802FD06 0048     lsl     r0,r1,1h                                
0802FD08 18C0     add     r0,r0,r3                                
0802FD0A 2500     mov     r5,0h                                   
0802FD0C 5F42     ldsh    r2,[r0,r5]                              
0802FD0E 4806     ldr     r0,=7FFFh                               
0802FD10 4282     cmp     r2,r0                                   
0802FD12 D10B     bne     802FD2Ch                                
0802FD14 1E48     sub     r0,r1,1                                 
0802FD16 0040     lsl     r0,r0,1h                                
0802FD18 18C0     add     r0,r0,r3                                
0802FD1A 2100     mov     r1,0h                                   
0802FD1C 5E40     ldsh    r0,[r0,r1]                              
0802FD1E 8865     ldrh    r5,[r4,2h]                              
0802FD20 1940     add     r0,r0,r5                                
0802FD22 E008     b       802FD36h                                
0802FD24 0D04     lsr     r4,r0,14h                               
0802FD26 082B     lsr     r3,r5,20h                               
0802FD28 7FFF     ldrb    r7,[r7,1Fh]                             
0802FD2A 0000     lsl     r0,r0,0h                                
0802FD2C 1C48     add     r0,r1,1                                 
0802FD2E 4661     mov     r1,r12                                  
0802FD30 7008     strb    r0,[r1]                                 
0802FD32 8860     ldrh    r0,[r4,2h]                              
0802FD34 1880     add     r0,r0,r2                                
0802FD36 8060     strh    r0,[r4,2h]                              
0802FD38 BC30     pop     r4,r5                                   
0802FD3A BC01     pop     r0                                      
0802FD3C 4700     bx      r0                                      
0802FD3E 0000     lsl     r0,r0,0h                                
0802FD40 4B05     ldr     r3,=3000738h                            
0802FD42 1C19     mov     r1,r3                                   
0802FD44 3124     add     r1,24h                                  
0802FD46 2200     mov     r2,0h                                   
0802FD48 2021     mov     r0,21h                                  
0802FD4A 7008     strb    r0,[r1]                                 
0802FD4C 1C18     mov     r0,r3                                   
0802FD4E 302F     add     r0,2Fh                                  
0802FD50 7002     strb    r2,[r0]                                 
0802FD52 3802     sub     r0,2h                                   
0802FD54 7002     strb    r2,[r0]                                 
0802FD56 4770     bx      r14                                     
0802FD58 0738     lsl     r0,r7,1Ch                               
0802FD5A 0300     lsl     r0,r0,0Ch                               
0802FD5C B530     push    r4,r5,r14                               
0802FD5E 4C09     ldr     r4,=3000738h                            
0802FD60 8860     ldrh    r0,[r4,2h]                              
0802FD62 88A1     ldrh    r1,[r4,4h]                              
0802FD64 F7DFFB8A bl      800F47Ch                                
0802FD68 1C01     mov     r1,r0                                   
0802FD6A 4807     ldr     r0,=30007F0h                            
0802FD6C 7800     ldrb    r0,[r0]                                 
0802FD6E 2800     cmp     r0,0h                                   
0802FD70 D00E     beq     802FD90h                                
0802FD72 8061     strh    r1,[r4,2h]                              
0802FD74 1C20     mov     r0,r4                                   
0802FD76 3024     add     r0,24h                                  
0802FD78 2110     mov     r1,10h                                  
0802FD7A 7001     strb    r1,[r0]                                 
0802FD7C 4803     ldr     r0,=271h                                
0802FD7E F7D2FE4B bl      8002A18h                                
0802FD82 E023     b       802FDCCh                                
0802FD84 0738     lsl     r0,r7,1Ch                               
0802FD86 0300     lsl     r0,r0,0Ch                               
0802FD88 07F0     lsl     r0,r6,1Fh                               
0802FD8A 0300     lsl     r0,r0,0Ch                               
0802FD8C 0271     lsl     r1,r6,9h                                
0802FD8E 0000     lsl     r0,r0,0h                                
0802FD90 202F     mov     r0,2Fh                                  
0802FD92 1900     add     r0,r0,r4                                
0802FD94 4684     mov     r12,r0                                  
0802FD96 7801     ldrb    r1,[r0]                                 
0802FD98 4B07     ldr     r3,=82B0D54h                            
0802FD9A 0048     lsl     r0,r1,1h                                
0802FD9C 18C0     add     r0,r0,r3                                
0802FD9E 2500     mov     r5,0h                                   
0802FDA0 5F42     ldsh    r2,[r0,r5]                              
0802FDA2 4806     ldr     r0,=7FFFh                               
0802FDA4 4282     cmp     r2,r0                                   
0802FDA6 D10B     bne     802FDC0h                                
0802FDA8 1E48     sub     r0,r1,1                                 
0802FDAA 0040     lsl     r0,r0,1h                                
0802FDAC 18C0     add     r0,r0,r3                                
0802FDAE 2100     mov     r1,0h                                   
0802FDB0 5E40     ldsh    r0,[r0,r1]                              
0802FDB2 8865     ldrh    r5,[r4,2h]                              
0802FDB4 1940     add     r0,r0,r5                                
0802FDB6 E008     b       802FDCAh                                
0802FDB8 0D54     lsr     r4,r2,15h                               
0802FDBA 082B     lsr     r3,r5,20h                               
0802FDBC 7FFF     ldrb    r7,[r7,1Fh]                             
0802FDBE 0000     lsl     r0,r0,0h                                
0802FDC0 1C48     add     r0,r1,1                                 
0802FDC2 4661     mov     r1,r12                                  
0802FDC4 7008     strb    r0,[r1]                                 
0802FDC6 8860     ldrh    r0,[r4,2h]                              
0802FDC8 1880     add     r0,r0,r2                                
0802FDCA 8060     strh    r0,[r4,2h]                              
0802FDCC BC30     pop     r4,r5                                   
0802FDCE BC01     pop     r0                                      
0802FDD0 4700     bx      r0                                      
/////////////////////////////////////////////////////////////////////////
;主程序                                  
0802FDD4 B500     push    r14                                     
0802FDD6 B081     add     sp,-4h                                  
0802FDD8 4905     ldr     r1,=3000738h                            
0802FDDA 1C08     mov     r0,r1                                   
0802FDDC 3024     add     r0,24h                                  
0802FDDE 7800     ldrb    r0,[r0]          ;读取POSE                          
0802FDE0 1C0A     mov     r2,r1                                   
0802FDE2 2821     cmp     r0,21h                                  
0802FDE4 D877     bhi     @@OtherPose                                
0802FDE6 0080     lsl     r0,r0,2h                                
0802FDE8 4902     ldr     r1,=802FDF8h     ;POSETable                       
0802FDEA 1840     add     r0,r0,r1                                
0802FDEC 6800     ldr     r0,[r0]                                 
0802FDEE 4687     mov     r15,r0                                  

PoseTable:
    .word 802fe80h  ;00
	.word 802fed6h .word 802fed6h .word 802fed6h .word 802fed6h
	.word 802fed6h .word 802fed6h .word 802fed6h
	.word 802fea2h  ;08
	.word 802fea6h  ;09
	.word 802feach  ;0a
	.word 802feb0h  ;0b
	.word 802feb6h  ;0c
	.word 802febch  ;0d
	.word 802fe98h  ;0e
	.word 802fe9ch  ;0f
	.word 802fe84h  ;10h
	.word 802fe88h  ;11h
	.word 802fe8eh  ;12h
	.word 802fe92h  ;13h
	.word 802fed6h .word 802fed6h .word 802fed6h .word 802fed6h
	.word 802fed6h .word 802fed6h .word 802fed6h .word 802fed6h
	.word 802fed6h .word 802fed6h 
	.word 802fec2h  ;1e
	.word 802fec6h  ;1f
	.word 802fecch  ;20h
	.word 802fed0h  ;21h
	
0802FE80 F7FFFBBA bl      802F5F8h   ;00                               
0802FE84 F7FFFC00 bl      802F688h   ;10                              
0802FE88 F7FFFC0E bl      802F6A8h   ;11                              
0802FE8C E02C     b       @@end                                
0802FE8E F7FFFC27 bl      802F6E0h   ;12                             
0802FE92 F7FFFC41 bl      802F718h   ;13                              
0802FE96 E027     b       @@end                                
0802FE98 F7FFFD1A bl      802F8D0h   ;0e                              
0802FE9C F7FFFD36 bl      802F90Ch   ;0f                              
0802FEA0 E022     b       @@end                                
0802FEA2 F7FFFD51 bl      802F948h   ;08                             
0802FEA6 F7FFFD5F bl      802F968h   ;09                             
0802FEAA E01D     b       @@end                                
0802FEAC F7FFFE8A bl      802FBC4h   ;0a                             
0802FEB0 F7FFFEA4 bl      802FBFCh   ;0b                              
0802FEB4 E018     b       @@end                                
0802FEB6 F7FFFEBB bl      802FC30h   ;0c                             
0802FEBA E015     b       @@end                                
0802FEBC F7FFFEDE bl      802FC7Ch   ;0d                             
0802FEC0 E012     b       @@end                                
0802FEC2 F7FFFEE9 bl      802FC98h   ;1e                             
0802FEC6 F7FFFEFB bl      802FCC0h   ;1f                             
0802FECA E00D     b       @@end                                
0802FECC F7FFFF38 bl      802FD40h   ;20                             
0802FED0 F7FFFF44 bl      802FD5Ch   ;21                             
0802FED4 E008     b       @@end 

@@OtherPose:                               
0802FED6 8851     ldrh    r1,[r2,2h]                              
0802FED8 3946     sub     r1,46h                                  
0802FEDA 8892     ldrh    r2,[r2,4h]                              
0802FEDC 2022     mov     r0,22h                                  
0802FEDE 9000     str     r0,[sp]                                 
0802FEE0 2000     mov     r0,0h                                   
0802FEE2 2301     mov     r3,1h                                   
0802FEE4 F7E1F8CE bl      8011084h   ;掉落例程

@@end:                               
0802FEE8 B001     add     sp,4h                                   
0802FEEA BC01     pop     r0                                      
0802FEEC 4700     bx      r0                                      


                               
0802FEF0 B510     push    r4,r14                                  
0802FEF2 2400     mov     r4,0h                                   
0802FEF4 4A0C     ldr     r2,=30001ACh                            
0802FEF6 21A8     mov     r1,0A8h                                 
0802FEF8 00C9     lsl     r1,r1,3h                                
0802FEFA 1850     add     r0,r2,r1                                
0802FEFC 4282     cmp     r2,r0                                   
0802FEFE D21A     bcs     802FF36h                                
0802FF00 1C13     mov     r3,r2                                   
0802FF02 3324     add     r3,24h                                  
0802FF04 8811     ldrh    r1,[r2]                                 
0802FF06 2001     mov     r0,1h                                   
0802FF08 4008     and     r0,r1                                   
0802FF0A 2800     cmp     r0,0h                                   
0802FF0C D00E     beq     802FF2Ch                                
0802FF0E 7858     ldrb    r0,[r3,1h]                              
0802FF10 2817     cmp     r0,17h                                  
0802FF12 D10B     bne     802FF2Ch                                
0802FF14 7818     ldrb    r0,[r3]                                 
0802FF16 2843     cmp     r0,43h                                  
0802FF18 D102     bne     802FF20h                                
0802FF1A 1C60     add     r0,r4,1                                 
0802FF1C 0600     lsl     r0,r0,18h                               
0802FF1E 0E04     lsr     r4,r0,18h                               
0802FF20 2C03     cmp     r4,3h                                   
0802FF22 D903     bls     802FF2Ch                                
0802FF24 2001     mov     r0,1h                                   
0802FF26 E007     b       802FF38h                                
0802FF28 01AC     lsl     r4,r5,6h                                
0802FF2A 0300     lsl     r0,r0,0Ch                               
0802FF2C 3338     add     r3,38h                                  
0802FF2E 3238     add     r2,38h                                  
0802FF30 4803     ldr     r0,=30006ECh                            
0802FF32 4282     cmp     r2,r0                                   
0802FF34 D3E6     bcc     802FF04h                                
0802FF36 2000     mov     r0,0h                                   
0802FF38 BC10     pop     r4                                      
0802FF3A BC02     pop     r1                                      
0802FF3C 4708     bx      r1                                      
0802FF3E 0000     lsl     r0,r0,0h                                
0802FF40 06EC     lsl     r4,r5,1Bh                               
0802FF42 0300     lsl     r0,r0,0Ch                               
0802FF44 B5F0     push    r4-r7,r14                               
0802FF46 4647     mov     r7,r8                                   
0802FF48 B480     push    r7                                      
0802FF4A B083     add     sp,-0Ch                                 
0802FF4C 1C06     mov     r6,r0                                   
0802FF4E 2300     mov     r3,0h                                   
0802FF50 2200     mov     r2,0h                                   
0802FF52 4822     ldr     r0,=0FFFCh                              
0802FF54 8170     strh    r0,[r6,0Ah]                             
0802FF56 81B2     strh    r2,[r6,0Ch]                             
0802FF58 81F0     strh    r0,[r6,0Eh]                             
0802FF5A 2104     mov     r1,4h                                   
0802FF5C 2004     mov     r0,4h                                   
0802FF5E 8230     strh    r0,[r6,10h]                             
0802FF60 1C30     mov     r0,r6                                   
0802FF62 3027     add     r0,27h                                  
0802FF64 2508     mov     r5,8h                                   
0802FF66 7005     strb    r5,[r0]                                 
0802FF68 3001     add     r0,1h                                   
0802FF6A 7001     strb    r1,[r0]                                 
0802FF6C 3001     add     r0,1h                                   
0802FF6E 7005     strb    r5,[r0]                                 
0802FF70 481B     ldr     r0,=82E8318h                            
0802FF72 61B0     str     r0,[r6,18h]                             
0802FF74 7733     strb    r3,[r6,1Ch]                             
0802FF76 82F2     strh    r2,[r6,16h]                             
0802FF78 1C31     mov     r1,r6                                   
0802FF7A 3125     add     r1,25h                                  
0802FF7C 2017     mov     r0,17h                                  
0802FF7E 7008     strb    r0,[r1]                                 
0802FF80 2001     mov     r0,1h                                   
0802FF82 82B0     strh    r0,[r6,14h]                             
0802FF84 4817     ldr     r0,=300070Ch                            
0802FF86 7383     strb    r3,[r0,0Eh]                             
0802FF88 F7DFFC40 bl      800F80Ch                                
0802FF8C 1C30     mov     r0,r6                                   
0802FF8E 3024     add     r0,24h                                  
0802FF90 7005     strb    r5,[r0]                                 
0802FF92 7F70     ldrb    r0,[r6,1Dh]                             
0802FF94 4680     mov     r8,r0                                   
0802FF96 285E     cmp     r0,5Eh                                  
0802FF98 D163     bne     8030062h                                
0802FF9A 4813     ldr     r0,=3001530h                            
0802FF9C 7B01     ldrb    r1,[r0,0Ch]                             
0802FF9E 2080     mov     r0,80h                                  
0802FFA0 4008     and     r0,r1                                   
0802FFA2 2800     cmp     r0,0h                                   
0802FFA4 D008     beq     802FFB8h                                
0802FFA6 2003     mov     r0,3h                                   
0802FFA8 212D     mov     r1,2Dh                                  
0802FFAA F030FC87 bl      80608BCh                                
0802FFAE 2800     cmp     r0,0h                                   
0802FFB0 D102     bne     802FFB8h                                
0802FFB2 490E     ldr     r1,=300007Bh                            
0802FFB4 2001     mov     r0,1h                                   
0802FFB6 7008     strb    r0,[r1]                                 
0802FFB8 8831     ldrh    r1,[r6]                                 
0802FFBA 2004     mov     r0,4h                                   
0802FFBC 4008     and     r0,r1                                   
0802FFBE 0400     lsl     r0,r0,10h                               
0802FFC0 0C05     lsr     r5,r0,10h                               
0802FFC2 2D00     cmp     r5,0h                                   
0802FFC4 D018     beq     802FFF8h                                
0802FFC6 480A     ldr     r0,=300083Ch                            
0802FFC8 7807     ldrb    r7,[r0]                                 
0802FFCA 480A     ldr     r0,=0FFFBh                              
0802FFCC 4008     and     r0,r1                                   
0802FFCE 8030     strh    r0,[r6]                                 
0802FFD0 1C38     mov     r0,r7                                   
0802FFD2 4378     mul     r0,r7                                   
0802FFD4 88B1     ldrh    r1,[r6,4h]                              
0802FFD6 1840     add     r0,r0,r1                                
0802FFD8 80B0     strh    r0,[r6,4h]                              
0802FFDA E042     b       8030062h                                
0802FFDC FFFC     bl      lr+0FF8h                                
0802FFDE 0000     lsl     r0,r0,0h                                
0802FFE0 8318     strh    r0,[r3,18h]                             
0802FFE2 082E     lsr     r6,r5,20h                               
0802FFE4 070C     lsl     r4,r1,1Ch                               
0802FFE6 0300     lsl     r0,r0,0Ch                               
0802FFE8 1530     asr     r0,r6,14h                               
0802FFEA 0300     lsl     r0,r0,0Ch                               
0802FFEC 007B     lsl     r3,r7,1h                                
0802FFEE 0300     lsl     r0,r0,0Ch                               
0802FFF0 083C     lsr     r4,r7,20h                               
0802FFF2 0300     lsl     r0,r0,0Ch                               
0802FFF4 FFFB     bl      lr+0FF6h                                
0802FFF6 0000     lsl     r0,r0,0h                                
0802FFF8 7FF7     ldrb    r7,[r6,1Fh]                             
0802FFFA 7FB0     ldrb    r0,[r6,1Eh]                             
0802FFFC 9002     str     r0,[sp,8h]                              
0802FFFE 8874     ldrh    r4,[r6,2h]                              
08030000 88B6     ldrh    r6,[r6,4h]                              
08030002 1C30     mov     r0,r6                                   
08030004 3808     sub     r0,8h                                   
08030006 9000     str     r0,[sp]                                 
08030008 9501     str     r5,[sp,4h]                              
0803000A 4640     mov     r0,r8                                   
0803000C 9902     ldr     r1,[sp,8h]                              
0803000E 1C3A     mov     r2,r7                                   
08030010 1C23     mov     r3,r4                                   
08030012 F7DEF983 bl      800E31Ch                                
08030016 1C30     mov     r0,r6                                   
08030018 300C     add     r0,0Ch                                  
0803001A 9000     str     r0,[sp]                                 
0803001C 9501     str     r5,[sp,4h]                              
0803001E 4640     mov     r0,r8                                   
08030020 9902     ldr     r1,[sp,8h]                              
08030022 1C3A     mov     r2,r7                                   
08030024 1C23     mov     r3,r4                                   
08030026 F7DEF979 bl      800E31Ch                                
0803002A 1C30     mov     r0,r6                                   
0803002C 380C     sub     r0,0Ch                                  
0803002E 9000     str     r0,[sp]                                 
08030030 9501     str     r5,[sp,4h]                              
08030032 4640     mov     r0,r8                                   
08030034 9902     ldr     r1,[sp,8h]                              
08030036 1C3A     mov     r2,r7                                   
08030038 1C23     mov     r3,r4                                   
0803003A F7DEF96F bl      800E31Ch                                
0803003E 1C30     mov     r0,r6                                   
08030040 3008     add     r0,8h                                   
08030042 9000     str     r0,[sp]                                 
08030044 9501     str     r5,[sp,4h]                              
08030046 4640     mov     r0,r8                                   
08030048 9902     ldr     r1,[sp,8h]                              
0803004A 1C3A     mov     r2,r7                                   
0803004C 1C23     mov     r3,r4                                   
0803004E F7DEF965 bl      800E31Ch                                
08030052 9600     str     r6,[sp]                                 
08030054 9501     str     r5,[sp,4h]                              
08030056 4640     mov     r0,r8                                   
08030058 9902     ldr     r1,[sp,8h]                              
0803005A 1C3A     mov     r2,r7                                   
0803005C 1C23     mov     r3,r4                                   
0803005E F7DEF95D bl      800E31Ch                                
08030062 B003     add     sp,0Ch                                  
08030064 BC08     pop     r3                                      
08030066 4698     mov     r8,r3                                   
08030068 BCF0     pop     r4-r7                                   
0803006A BC01     pop     r0                                      
0803006C 4700     bx      r0                                      
0803006E 0000     lsl     r0,r0,0h                                
08030070 B530     push    r4,r5,r14                               
08030072 1C03     mov     r3,r0                                   
08030074 1C19     mov     r1,r3                                   
08030076 3124     add     r1,24h                                  
08030078 2500     mov     r5,0h                                   
0803007A 2043     mov     r0,43h                                  
0803007C 7008     strb    r0,[r1]                                 
0803007E 480E     ldr     r0,=82E84E0h                            
08030080 6198     str     r0,[r3,18h]                             
08030082 2100     mov     r1,0h                                   
08030084 82DD     strh    r5,[r3,16h]                             
08030086 7719     strb    r1,[r3,1Ch]                             
08030088 1C18     mov     r0,r3                                   
0803008A 302C     add     r0,2Ch                                  
0803008C 7001     strb    r1,[r0]                                 
0803008E 4A0B     ldr     r2,=30013D4h                            
08030090 490B     ldr     r1,=3001588h                            
08030092 1C08     mov     r0,r1                                   
08030094 3070     add     r0,70h                                  
08030096 8800     ldrh    r0,[r0]                                 
08030098 8A94     ldrh    r4,[r2,14h]                             
0803009A 1900     add     r0,r0,r4                                
0803009C 0400     lsl     r0,r0,10h                               
0803009E 0C04     lsr     r4,r0,10h                               
080300A0 316E     add     r1,6Eh                                  
080300A2 8808     ldrh    r0,[r1]                                 
080300A4 8A51     ldrh    r1,[r2,12h]                             
080300A6 1840     add     r0,r0,r1                                
080300A8 0400     lsl     r0,r0,10h                               
080300AA 0C01     lsr     r1,r0,10h                               
080300AC 8858     ldrh    r0,[r3,2h]                              
080300AE 42A0     cmp     r0,r4                                   
080300B0 D208     bcs     80300C4h                                
080300B2 80DD     strh    r5,[r3,6h]                              
080300B4 E008     b       80300C8h                                
080300B6 0000     lsl     r0,r0,0h                                
080300B8 84E0     strh    r0,[r4,26h]                             
080300BA 082E     lsr     r6,r5,20h                               
080300BC 13D4     asr     r4,r2,0Fh                               
080300BE 0300     lsl     r0,r0,0Ch                               
080300C0 1588     asr     r0,r1,16h                               
080300C2 0300     lsl     r0,r0,0Ch                               
080300C4 1B00     sub     r0,r0,r4                                
080300C6 80D8     strh    r0,[r3,6h]                              
080300C8 8898     ldrh    r0,[r3,4h]                              
080300CA 4288     cmp     r0,r1                                   
080300CC D201     bcs     80300D2h                                
080300CE 2000     mov     r0,0h                                   
080300D0 E000     b       80300D4h                                
080300D2 1A40     sub     r0,r0,r1                                
080300D4 8118     strh    r0,[r3,8h]                              
080300D6 8859     ldrh    r1,[r3,2h]                              
080300D8 8A90     ldrh    r0,[r2,14h]                             
080300DA 3840     sub     r0,40h                                  
080300DC 4281     cmp     r1,r0                                   
080300DE DD05     ble     80300ECh                                
080300E0 8819     ldrh    r1,[r3]                                 
080300E2 4801     ldr     r0,=0FEFFh                              
080300E4 4008     and     r0,r1                                   
080300E6 E006     b       80300F6h                                
080300E8 FEFF     bl      lr+0DFEh                                
080300EA 0000     lsl     r0,r0,0h                                
080300EC 8819     ldrh    r1,[r3]                                 
080300EE 2280     mov     r2,80h                                  
080300F0 0052     lsl     r2,r2,1h                                
080300F2 1C10     mov     r0,r2                                   
080300F4 4308     orr     r0,r1                                   
080300F6 8018     strh    r0,[r3]                                 
080300F8 BC30     pop     r4,r5                                   
080300FA BC01     pop     r0                                      
080300FC 4700     bx      r0                                      
080300FE 0000     lsl     r0,r0,0h                                
08030100 B5F0     push    r4-r7,r14                               
08030102 1C03     mov     r3,r0                                   
08030104 4808     ldr     r0,=30013D4h                            
08030106 7801     ldrb    r1,[r0]                                 
08030108 1C06     mov     r6,r0                                   
0803010A 290F     cmp     r1,0Fh                                  
0803010C D110     bne     8030130h                                
0803010E 1C18     mov     r0,r3                                   
08030110 3024     add     r0,24h                                  
08030112 2144     mov     r1,44h                                  
08030114 7001     strb    r1,[r0]                                 
08030116 4805     ldr     r0,=300083Ch                            
08030118 7802     ldrb    r2,[r0]                                 
0803011A 2A05     cmp     r2,5h                                   
0803011C D800     bhi     8030120h                                
0803011E 2206     mov     r2,6h                                   
08030120 1C18     mov     r0,r3                                   
08030122 302E     add     r0,2Eh                                  
08030124 7002     strb    r2,[r0]                                 
08030126 E0AF     b       8030288h                                
08030128 13D4     asr     r4,r2,0Fh                               
0803012A 0300     lsl     r0,r0,0Ch                               
0803012C 083C     lsr     r4,r7,20h                               
0803012E 0300     lsl     r0,r0,0Ch                               
08030130 490E     ldr     r1,=3000734h                            
08030132 7808     ldrb    r0,[r1]                                 
08030134 2800     cmp     r0,0h                                   
08030136 D101     bne     803013Ch                                
08030138 205A     mov     r0,5Ah                                  
0803013A 7008     strb    r0,[r1]                                 
0803013C 881C     ldrh    r4,[r3]                                 
0803013E 2580     mov     r5,80h                                  
08030140 006D     lsl     r5,r5,1h                                
08030142 1C28     mov     r0,r5                                   
08030144 4020     and     r0,r4                                   
08030146 2800     cmp     r0,0h                                   
08030148 D016     beq     8030178h                                
0803014A 4A09     ldr     r2,=3001588h                            
0803014C 1C10     mov     r0,r2                                   
0803014E 3074     add     r0,74h                                  
08030150 2500     mov     r5,0h                                   
08030152 5F41     ldsh    r1,[r0,r5]                              
08030154 8AB7     ldrh    r7,[r6,14h]                             
08030156 19C9     add     r1,r1,r7                                
08030158 8858     ldrh    r0,[r3,2h]                              
0803015A 3008     add     r0,8h                                   
0803015C 4694     mov     r12,r2                                  
0803015E 1C1A     mov     r2,r3                                   
08030160 322C     add     r2,2Ch                                  
08030162 4281     cmp     r1,r0                                   
08030164 DA1C     bge     80301A0h                                
08030166 4803     ldr     r0,=0FEFFh                              
08030168 4020     and     r0,r4                                   
0803016A E015     b       8030198h                                
0803016C 0734     lsl     r4,r6,1Ch                               
0803016E 0300     lsl     r0,r0,0Ch                               
08030170 1588     asr     r0,r1,16h                               
08030172 0300     lsl     r0,r0,0Ch                               
08030174 FEFF     bl      lr+0DFEh                                
08030176 0000     lsl     r0,r0,0h                                
08030178 4A12     ldr     r2,=3001588h                            
0803017A 1C10     mov     r0,r2                                   
0803017C 3070     add     r0,70h                                  
0803017E 2700     mov     r7,0h                                   
08030180 5FC1     ldsh    r1,[r0,r7]                              
08030182 8AB0     ldrh    r0,[r6,14h]                             
08030184 1809     add     r1,r1,r0                                
08030186 8858     ldrh    r0,[r3,2h]                              
08030188 3808     sub     r0,8h                                   
0803018A 4694     mov     r12,r2                                  
0803018C 1C1A     mov     r2,r3                                   
0803018E 322C     add     r2,2Ch                                  
08030190 4281     cmp     r1,r0                                   
08030192 DD05     ble     80301A0h                                
08030194 1C28     mov     r0,r5                                   
08030196 4320     orr     r0,r4                                   
08030198 8018     strh    r0,[r3]                                 
0803019A 480B     ldr     r0,=300083Ch                            
0803019C 7800     ldrb    r0,[r0]                                 
0803019E 7010     strb    r0,[r2]                                 
080301A0 881C     ldrh    r4,[r3]                                 
080301A2 2040     mov     r0,40h                                  
080301A4 4020     and     r0,r4                                   
080301A6 2800     cmp     r0,0h                                   
080301A8 D012     beq     80301D0h                                
080301AA 4660     mov     r0,r12                                  
080301AC 3072     add     r0,72h                                  
080301AE 2500     mov     r5,0h                                   
080301B0 5F41     ldsh    r1,[r0,r5]                              
080301B2 8A77     ldrh    r7,[r6,12h]                             
080301B4 19C9     add     r1,r1,r7                                
080301B6 8898     ldrh    r0,[r3,4h]                              
080301B8 3008     add     r0,8h                                   
080301BA 4281     cmp     r1,r0                                   
080301BC DA18     bge     80301F0h                                
080301BE 4803     ldr     r0,=0FFBFh                              
080301C0 4020     and     r0,r4                                   
080301C2 E011     b       80301E8h                                
080301C4 1588     asr     r0,r1,16h                               
080301C6 0300     lsl     r0,r0,0Ch                               
080301C8 083C     lsr     r4,r7,20h                               
080301CA 0300     lsl     r0,r0,0Ch                               
080301CC FFBF     bl      lr+0F7Eh                                
080301CE 0000     lsl     r0,r0,0h                                
080301D0 4660     mov     r0,r12                                  
080301D2 306E     add     r0,6Eh                                  
080301D4 2500     mov     r5,0h                                   
080301D6 5F41     ldsh    r1,[r0,r5]                              
080301D8 8A77     ldrh    r7,[r6,12h]                             
080301DA 19C9     add     r1,r1,r7                                
080301DC 8898     ldrh    r0,[r3,4h]                              
080301DE 3808     sub     r0,8h                                   
080301E0 4281     cmp     r1,r0                                   
080301E2 DD05     ble     80301F0h                                
080301E4 2040     mov     r0,40h                                  
080301E6 4320     orr     r0,r4                                   
080301E8 8018     strh    r0,[r3]                                 
080301EA 480A     ldr     r0,=300083Ch                            
080301EC 7800     ldrb    r0,[r0]                                 
080301EE 7010     strb    r0,[r2]                                 
080301F0 7810     ldrb    r0,[r2]                                 
080301F2 2800     cmp     r0,0h                                   
080301F4 D132     bne     803025Ch                                
080301F6 8819     ldrh    r1,[r3]                                 
080301F8 2080     mov     r0,80h                                  
080301FA 0040     lsl     r0,r0,1h                                
080301FC 4008     and     r0,r1                                   
080301FE 1C0C     mov     r4,r1                                   
08030200 2800     cmp     r0,0h                                   
08030202 D009     beq     8030218h                                
08030204 4803     ldr     r0,=300083Ch                            
08030206 7801     ldrb    r1,[r0]                                 
08030208 1C02     mov     r2,r0                                   
0803020A 2900     cmp     r1,0h                                   
0803020C D00C     beq     8030228h                                
0803020E 88D8     ldrh    r0,[r3,6h]                              
08030210 3001     add     r0,1h                                   
08030212 E008     b       8030226h                                
08030214 083C     lsr     r4,r7,20h                               
08030216 0300     lsl     r0,r0,0Ch                               
08030218 480A     ldr     r0,=300083Ch                            
0803021A 7801     ldrb    r1,[r0]                                 
0803021C 1C02     mov     r2,r0                                   
0803021E 2900     cmp     r1,0h                                   
08030220 D002     beq     8030228h                                
08030222 88D8     ldrh    r0,[r3,6h]                              
08030224 3801     sub     r0,1h                                   
08030226 80D8     strh    r0,[r3,6h]                              
08030228 2040     mov     r0,40h                                  
0803022A 4020     and     r0,r4                                   
0803022C 2800     cmp     r0,0h                                   
0803022E D00B     beq     8030248h                                
08030230 1C19     mov     r1,r3                                   
08030232 3123     add     r1,23h                                  
08030234 7810     ldrb    r0,[r2]                                 
08030236 7809     ldrb    r1,[r1]                                 
08030238 4288     cmp     r0,r1                                   
0803023A D011     beq     8030260h                                
0803023C 8918     ldrh    r0,[r3,8h]                              
0803023E 3001     add     r0,1h                                   
08030240 8118     strh    r0,[r3,8h]                              
08030242 E00D     b       8030260h                                
08030244 083C     lsr     r4,r7,20h                               
08030246 0300     lsl     r0,r0,0Ch                               
08030248 1C19     mov     r1,r3                                   
0803024A 3123     add     r1,23h                                  
0803024C 7810     ldrb    r0,[r2]                                 
0803024E 7809     ldrb    r1,[r1]                                 
08030250 4288     cmp     r0,r1                                   
08030252 D005     beq     8030260h                                
08030254 8918     ldrh    r0,[r3,8h]                              
08030256 3801     sub     r0,1h                                   
08030258 8118     strh    r0,[r3,8h]                              
0803025A E001     b       8030260h                                
0803025C 3801     sub     r0,1h                                   
0803025E 7010     strb    r0,[r2]                                 
08030260 4660     mov     r0,r12                                  
08030262 3070     add     r0,70h                                  
08030264 8801     ldrh    r1,[r0]                                 
08030266 8AB0     ldrh    r0,[r6,14h]                             
08030268 1809     add     r1,r1,r0                                
0803026A 0409     lsl     r1,r1,10h                               
0803026C 4660     mov     r0,r12                                  
0803026E 306E     add     r0,6Eh                                  
08030270 8800     ldrh    r0,[r0]                                 
08030272 8A76     ldrh    r6,[r6,12h]                             
08030274 1980     add     r0,r0,r6                                
08030276 0400     lsl     r0,r0,10h                               
08030278 0C09     lsr     r1,r1,10h                               
0803027A 88DA     ldrh    r2,[r3,6h]                              
0803027C 1889     add     r1,r1,r2                                
0803027E 8059     strh    r1,[r3,2h]                              
08030280 0C00     lsr     r0,r0,10h                               
08030282 891D     ldrh    r5,[r3,8h]                              
08030284 1940     add     r0,r0,r5                                
08030286 8098     strh    r0,[r3,4h]                              
08030288 BCF0     pop     r4-r7                                   
0803028A BC01     pop     r0                                      
0803028C 4700     bx      r0                                      
0803028E 0000     lsl     r0,r0,0h                                
08030290 1C03     mov     r3,r0                                   
08030292 1C19     mov     r1,r3                                   
08030294 3124     add     r1,24h                                  
08030296 2200     mov     r2,0h                                   
08030298 2045     mov     r0,45h                                  
0803029A 7008     strb    r0,[r1]                                 
0803029C 4806     ldr     r0,=82E8528h                            
0803029E 6198     str     r0,[r3,18h]                             
080302A0 2000     mov     r0,0h                                   
080302A2 82DA     strh    r2,[r3,16h]                             
080302A4 7718     strb    r0,[r3,1Ch]                             
080302A6 310B     add     r1,0Bh                                  
080302A8 2008     mov     r0,8h                                   
080302AA 7008     strb    r0,[r1]                                 
080302AC 8819     ldrh    r1,[r3]                                 
080302AE 4803     ldr     r0,=0FEFFh                              
080302B0 4008     and     r0,r1                                   
080302B2 8018     strh    r0,[r3]                                 
080302B4 4770     bx      r14                                     
080302B6 0000     lsl     r0,r0,0h                                
080302B8 8528     strh    r0,[r5,28h]                             
080302BA 082E     lsr     r6,r5,20h                               
080302BC FEFF     bl      lr+0DFEh                                
080302BE 0000     lsl     r0,r0,0h                                
080302C0 B5F0     push    r4-r7,r14                               
080302C2 4647     mov     r7,r8                                   
080302C4 B480     push    r7                                      
080302C6 1C04     mov     r4,r0                                   
080302C8 1C22     mov     r2,r4                                   
080302CA 322F     add     r2,2Fh                                  
080302CC 7810     ldrb    r0,[r2]                                 
080302CE 1C01     mov     r1,r0                                   
080302D0 31FF     add     r1,0FFh                                 
080302D2 7011     strb    r1,[r2]                                 
080302D4 0600     lsl     r0,r0,18h                               
080302D6 0E01     lsr     r1,r0,18h                               
080302D8 2900     cmp     r1,0h                                   
080302DA D003     beq     80302E4h                                
080302DC 8860     ldrh    r0,[r4,2h]                              
080302DE 1A40     sub     r0,r0,r1                                
080302E0 8060     strh    r0,[r4,2h]                              
080302E2 E004     b       80302EEh                                
080302E4 7011     strb    r1,[r2]                                 
080302E6 1C21     mov     r1,r4                                   
080302E8 3124     add     r1,24h                                  
080302EA 2047     mov     r0,47h                                  
080302EC 7008     strb    r0,[r1]                                 
080302EE 8865     ldrh    r5,[r4,2h]                              
080302F0 46A8     mov     r8,r5                                   
080302F2 88A6     ldrh    r6,[r4,4h]                              
080302F4 1C37     mov     r7,r6                                   
080302F6 1C28     mov     r0,r5                                   
080302F8 3814     sub     r0,14h                                  
080302FA 1C31     mov     r1,r6                                   
080302FC F7DFFA10 bl      800F720h                                
08030300 2811     cmp     r0,11h                                  
08030302 D103     bne     803030Ch                                
08030304 480B     ldr     r0,=0FFC0h                              
08030306 4028     and     r0,r5                                   
08030308 3050     add     r0,50h                                  
0803030A 8060     strh    r0,[r4,2h]                              
0803030C 8821     ldrh    r1,[r4]                                 
0803030E 2040     mov     r0,40h                                  
08030310 4008     and     r0,r1                                   
08030312 2800     cmp     r0,0h                                   
08030314 D010     beq     8030338h                                
08030316 1C31     mov     r1,r6                                   
08030318 3110     add     r1,10h                                  
0803031A 1C28     mov     r0,r5                                   
0803031C F7DFFA00 bl      800F720h                                
08030320 21F0     mov     r1,0F0h                                 
08030322 4001     and     r1,r0                                   
08030324 2900     cmp     r1,0h                                   
08030326 D116     bne     8030356h                                
08030328 1C21     mov     r1,r4                                   
0803032A 312E     add     r1,2Eh                                  
0803032C 88A0     ldrh    r0,[r4,4h]                              
0803032E 7809     ldrb    r1,[r1]                                 
08030330 1840     add     r0,r0,r1                                
08030332 E00F     b       8030354h                                
08030334 FFC0     bl      lr+0F80h                                
08030336 0000     lsl     r0,r0,0h                                
08030338 1C39     mov     r1,r7                                   
0803033A 3910     sub     r1,10h                                  
0803033C 4640     mov     r0,r8                                   
0803033E F7DFF9EF bl      800F720h                                
08030342 21F0     mov     r1,0F0h                                 
08030344 4001     and     r1,r0                                   
08030346 2900     cmp     r1,0h                                   
08030348 D105     bne     8030356h                                
0803034A 1C20     mov     r0,r4                                   
0803034C 302E     add     r0,2Eh                                  
0803034E 7801     ldrb    r1,[r0]                                 
08030350 88A0     ldrh    r0,[r4,4h]                              
08030352 1A40     sub     r0,r0,r1                                
08030354 80A0     strh    r0,[r4,4h]                              
08030356 BC08     pop     r3                                      
08030358 4698     mov     r8,r3                                   
0803035A BCF0     pop     r4-r7                                   
0803035C BC01     pop     r0                                      
0803035E 4700     bx      r0                                      
08030360 B5F0     push    r4-r7,r14                               
08030362 464F     mov     r7,r9                                   
08030364 4646     mov     r6,r8                                   
08030366 B4C0     push    r6,r7                                   
08030368 1C04     mov     r4,r0                                   
0803036A 1C22     mov     r2,r4                                   
0803036C 322F     add     r2,2Fh                                  
0803036E 7810     ldrb    r0,[r2]                                 
08030370 1C01     mov     r1,r0                                   
08030372 31FF     add     r1,0FFh                                 
08030374 7011     strb    r1,[r2]                                 
08030376 0600     lsl     r0,r0,18h                               
08030378 0E01     lsr     r1,r0,18h                               
0803037A 2900     cmp     r1,0h                                   
0803037C D003     beq     8030386h                                
0803037E 8860     ldrh    r0,[r4,2h]                              
08030380 1A40     sub     r0,r0,r1                                
08030382 8060     strh    r0,[r4,2h]                              
08030384 E004     b       8030390h                                
08030386 7011     strb    r1,[r2]                                 
08030388 1C21     mov     r1,r4                                   
0803038A 3124     add     r1,24h                                  
0803038C 2047     mov     r0,47h                                  
0803038E 7008     strb    r0,[r1]                                 
08030390 8865     ldrh    r5,[r4,2h]                              
08030392 46A9     mov     r9,r5                                   
08030394 88A6     ldrh    r6,[r4,4h]                              
08030396 46B0     mov     r8,r6                                   
08030398 1C28     mov     r0,r5                                   
0803039A 3814     sub     r0,14h                                  
0803039C 1C31     mov     r1,r6                                   
0803039E F027FD6D bl      8057E7Ch                                
080303A2 2780     mov     r7,80h                                  
080303A4 047F     lsl     r7,r7,11h                               
080303A6 4038     and     r0,r7                                   
080303A8 2800     cmp     r0,0h                                   
080303AA D003     beq     80303B4h                                
080303AC 480B     ldr     r0,=0FFC0h                              
080303AE 4028     and     r0,r5                                   
080303B0 3050     add     r0,50h                                  
080303B2 8060     strh    r0,[r4,2h]                              
080303B4 8821     ldrh    r1,[r4]                                 
080303B6 2040     mov     r0,40h                                  
080303B8 4008     and     r0,r1                                   
080303BA 2800     cmp     r0,0h                                   
080303BC D010     beq     80303E0h                                
080303BE 1C31     mov     r1,r6                                   
080303C0 3110     add     r1,10h                                  
080303C2 1C28     mov     r0,r5                                   
080303C4 F027FD5A bl      8057E7Ch                                
080303C8 4038     and     r0,r7                                   
080303CA 2800     cmp     r0,0h                                   
080303CC D116     bne     80303FCh                                
080303CE 1C21     mov     r1,r4                                   
080303D0 312E     add     r1,2Eh                                  
080303D2 88A0     ldrh    r0,[r4,4h]                              
080303D4 7809     ldrb    r1,[r1]                                 
080303D6 1840     add     r0,r0,r1                                
080303D8 E00F     b       80303FAh                                
080303DA 0000     lsl     r0,r0,0h                                
080303DC FFC0     bl      lr+0F80h                                
080303DE 0000     lsl     r0,r0,0h                                
080303E0 4641     mov     r1,r8                                   
080303E2 3910     sub     r1,10h                                  
080303E4 4648     mov     r0,r9                                   
080303E6 F027FD49 bl      8057E7Ch                                
080303EA 4038     and     r0,r7                                   
080303EC 2800     cmp     r0,0h                                   
080303EE D105     bne     80303FCh                                
080303F0 1C20     mov     r0,r4                                   
080303F2 302E     add     r0,2Eh                                  
080303F4 7801     ldrb    r1,[r0]                                 
080303F6 88A0     ldrh    r0,[r4,4h]                              
080303F8 1A40     sub     r0,r0,r1                                
080303FA 80A0     strh    r0,[r4,4h]                              
080303FC BC18     pop     r3,r4                                   
080303FE 4698     mov     r8,r3                                   
08030400 46A1     mov     r9,r4                                   
08030402 BCF0     pop     r4-r7                                   
08030404 BC01     pop     r0                                      
08030406 4700     bx      r0                                      
08030408 B5F0     push    r4-r7,r14                               
0803040A 464F     mov     r7,r9                                   
0803040C 4646     mov     r6,r8                                   
0803040E B4C0     push    r6,r7                                   
08030410 1C04     mov     r4,r0                                   
08030412 8860     ldrh    r0,[r4,2h]                              
08030414 4681     mov     r9,r0                                   
08030416 1C21     mov     r1,r4                                   
08030418 312F     add     r1,2Fh                                  
0803041A 7808     ldrb    r0,[r1]                                 
0803041C 1C02     mov     r2,r0                                   
0803041E 2813     cmp     r0,13h                                  
08030420 DC01     bgt     8030426h                                
08030422 3002     add     r0,2h                                   
08030424 7008     strb    r0,[r1]                                 
08030426 8860     ldrh    r0,[r4,2h]                              
08030428 1880     add     r0,r0,r2                                
0803042A 2100     mov     r1,0h                                   
0803042C 4688     mov     r8,r1                                   
0803042E 2700     mov     r7,0h                                   
08030430 8060     strh    r0,[r4,2h]                              
08030432 8865     ldrh    r5,[r4,2h]                              
08030434 88A6     ldrh    r6,[r4,4h]                              
08030436 1C28     mov     r0,r5                                   
08030438 1C31     mov     r1,r6                                   
0803043A F7DFF81F bl      800F47Ch                                
0803043E 1C02     mov     r2,r0                                   
08030440 4806     ldr     r0,=30007F0h                            
08030442 7800     ldrb    r0,[r0]                                 
08030444 2800     cmp     r0,0h                                   
08030446 D023     beq     8030490h                                
08030448 4905     ldr     r1,=300083Ch                            
0803044A 7808     ldrb    r0,[r1]                                 
0803044C 2808     cmp     r0,8h                                   
0803044E D90B     bls     8030468h                                
08030450 4804     ldr     r0,=82E8378h                            
08030452 61A0     str     r0,[r4,18h]                             
08030454 82E7     strh    r7,[r4,16h]                             
08030456 4640     mov     r0,r8                                   
08030458 7720     strb    r0,[r4,1Ch]                             
0803045A E010     b       803047Eh                                
0803045C 07F0     lsl     r0,r6,1Fh                               
0803045E 0300     lsl     r0,r0,0Ch                               
08030460 083C     lsr     r4,r7,20h                               
08030462 0300     lsl     r0,r0,0Ch                               
08030464 8378     strh    r0,[r7,1Ah]                             
08030466 082E     lsr     r6,r5,20h                               
08030468 4808     ldr     r0,=82E8398h                            
0803046A 61A0     str     r0,[r4,18h]                             
0803046C 82E7     strh    r7,[r4,16h]                             
0803046E 4640     mov     r0,r8                                   
08030470 7720     strb    r0,[r4,1Ch]                             
08030472 7808     ldrb    r0,[r1]                                 
08030474 0040     lsl     r0,r0,1h                                
08030476 3020     add     r0,20h                                  
08030478 1C21     mov     r1,r4                                   
0803047A 312C     add     r1,2Ch                                  
0803047C 7008     strb    r0,[r1]                                 
0803047E 1C21     mov     r1,r4                                   
08030480 3124     add     r1,24h                                  
08030482 200F     mov     r0,0Fh                                  
08030484 7008     strb    r0,[r1]                                 
08030486 8062     strh    r2,[r4,2h]                              
08030488 E02B     b       80304E2h                                
0803048A 0000     lsl     r0,r0,0h                                
0803048C 8398     strh    r0,[r3,1Ch]                             
0803048E 082E     lsr     r6,r5,20h                               
08030490 8821     ldrh    r1,[r4]                                 
08030492 2040     mov     r0,40h                                  
08030494 4008     and     r0,r1                                   
08030496 2800     cmp     r0,0h                                   
08030498 D00E     beq     80304B8h                                
0803049A 1C31     mov     r1,r6                                   
0803049C 3110     add     r1,10h                                  
0803049E 1C28     mov     r0,r5                                   
080304A0 F7DFF93E bl      800F720h                                
080304A4 21F0     mov     r1,0F0h                                 
080304A6 4001     and     r1,r0                                   
080304A8 2900     cmp     r1,0h                                   
080304AA D114     bne     80304D6h                                
080304AC 1C21     mov     r1,r4                                   
080304AE 312E     add     r1,2Eh                                  
080304B0 88A0     ldrh    r0,[r4,4h]                              
080304B2 7809     ldrb    r1,[r1]                                 
080304B4 1840     add     r0,r0,r1                                
080304B6 E00D     b       80304D4h                                
080304B8 1C31     mov     r1,r6                                   
080304BA 3910     sub     r1,10h                                  
080304BC 1C28     mov     r0,r5                                   
080304BE F7DFF92F bl      800F720h                                
080304C2 21F0     mov     r1,0F0h                                 
080304C4 4001     and     r1,r0                                   
080304C6 2900     cmp     r1,0h                                   
080304C8 D105     bne     80304D6h                                
080304CA 1C20     mov     r0,r4                                   
080304CC 302E     add     r0,2Eh                                  
080304CE 7801     ldrb    r1,[r0]                                 
080304D0 88A0     ldrh    r0,[r4,4h]                              
080304D2 1A40     sub     r0,r0,r1                                
080304D4 80A0     strh    r0,[r4,4h]                              
080304D6 4648     mov     r0,r9                                   
080304D8 1C29     mov     r1,r5                                   
080304DA 1C32     mov     r2,r6                                   
080304DC 2301     mov     r3,1h                                   
080304DE F7E1F91B bl      8011718h                                
080304E2 BC18     pop     r3,r4                                   
080304E4 4698     mov     r8,r3                                   
080304E6 46A1     mov     r9,r4                                   
080304E8 BCF0     pop     r4-r7                                   
080304EA BC01     pop     r0                                      
080304EC 4700     bx      r0                                      
080304EE 0000     lsl     r0,r0,0h                                
080304F0 B5F0     push    r4-r7,r14                               
080304F2 4647     mov     r7,r8                                   
080304F4 B480     push    r7                                      
080304F6 1C04     mov     r4,r0                                   
080304F8 1C21     mov     r1,r4                                   
080304FA 312F     add     r1,2Fh                                  
080304FC 7808     ldrb    r0,[r1]                                 
080304FE 1C02     mov     r2,r0                                   
08030500 2813     cmp     r0,13h                                  
08030502 DC01     bgt     8030508h                                
08030504 3002     add     r0,2h                                   
08030506 7008     strb    r0,[r1]                                 
08030508 8860     ldrh    r0,[r4,2h]                              
0803050A 1880     add     r0,r0,r2                                
0803050C 2100     mov     r1,0h                                   
0803050E 4688     mov     r8,r1                                   
08030510 2700     mov     r7,0h                                   
08030512 8060     strh    r0,[r4,2h]                              
08030514 8865     ldrh    r5,[r4,2h]                              
08030516 88A6     ldrh    r6,[r4,4h]                              
08030518 1C28     mov     r0,r5                                   
0803051A 1C31     mov     r1,r6                                   
0803051C F027FCAE bl      8057E7Ch                                
08030520 2180     mov     r1,80h                                  
08030522 0449     lsl     r1,r1,11h                               
08030524 4001     and     r1,r0                                   
08030526 2900     cmp     r1,0h                                   
08030528 D026     beq     8030578h                                
0803052A 4809     ldr     r0,=0FFC0h                              
0803052C 4028     and     r0,r5                                   
0803052E 4285     cmp     r5,r0                                   
08030530 D322     bcc     8030578h                                
08030532 8060     strh    r0,[r4,2h]                              
08030534 1C20     mov     r0,r4                                   
08030536 3024     add     r0,24h                                  
08030538 210F     mov     r1,0Fh                                  
0803053A 7001     strb    r1,[r0]                                 
0803053C 4905     ldr     r1,=300083Ch                            
0803053E 7808     ldrb    r0,[r1]                                 
08030540 2808     cmp     r0,8h                                   
08030542 D90B     bls     803055Ch                                
08030544 4804     ldr     r0,=82E8378h                            
08030546 61A0     str     r0,[r4,18h]                             
08030548 82E7     strh    r7,[r4,16h]                             
0803054A 4640     mov     r0,r8                                   
0803054C 7720     strb    r0,[r4,1Ch]                             
0803054E E038     b       80305C2h                                
08030550 FFC0     bl      lr+0F80h                                
08030552 0000     lsl     r0,r0,0h                                
08030554 083C     lsr     r4,r7,20h                               
08030556 0300     lsl     r0,r0,0Ch                               
08030558 8378     strh    r0,[r7,1Ah]                             
0803055A 082E     lsr     r6,r5,20h                               
0803055C 4805     ldr     r0,=82E8398h                            
0803055E 61A0     str     r0,[r4,18h]                             
08030560 82E7     strh    r7,[r4,16h]                             
08030562 4640     mov     r0,r8                                   
08030564 7720     strb    r0,[r4,1Ch]                             
08030566 7808     ldrb    r0,[r1]                                 
08030568 0040     lsl     r0,r0,1h                                
0803056A 3020     add     r0,20h                                  
0803056C 1C21     mov     r1,r4                                   
0803056E 312C     add     r1,2Ch                                  
08030570 7008     strb    r0,[r1]                                 
08030572 E026     b       80305C2h                                
08030574 8398     strh    r0,[r3,1Ch]                             
08030576 082E     lsr     r6,r5,20h                               
08030578 8821     ldrh    r1,[r4]                                 
0803057A 2040     mov     r0,40h                                  
0803057C 4008     and     r0,r1                                   
0803057E 2800     cmp     r0,0h                                   
08030580 D00F     beq     80305A2h                                
08030582 1C31     mov     r1,r6                                   
08030584 3110     add     r1,10h                                  
08030586 1C28     mov     r0,r5                                   
08030588 F027FC78 bl      8057E7Ch                                
0803058C 2180     mov     r1,80h                                  
0803058E 0449     lsl     r1,r1,11h                               
08030590 4001     and     r1,r0                                   
08030592 2900     cmp     r1,0h                                   
08030594 D115     bne     80305C2h                                
08030596 1C21     mov     r1,r4                                   
08030598 312E     add     r1,2Eh                                  
0803059A 88A0     ldrh    r0,[r4,4h]                              
0803059C 7809     ldrb    r1,[r1]                                 
0803059E 1840     add     r0,r0,r1                                
080305A0 E00E     b       80305C0h                                
080305A2 1C31     mov     r1,r6                                   
080305A4 3910     sub     r1,10h                                  
080305A6 1C28     mov     r0,r5                                   
080305A8 F027FC68 bl      8057E7Ch                                
080305AC 2180     mov     r1,80h                                  
080305AE 0449     lsl     r1,r1,11h                               
080305B0 4001     and     r1,r0                                   
080305B2 2900     cmp     r1,0h                                   
080305B4 D105     bne     80305C2h                                
080305B6 1C20     mov     r0,r4                                   
080305B8 302E     add     r0,2Eh                                  
080305BA 7801     ldrb    r1,[r0]                                 
080305BC 88A0     ldrh    r0,[r4,4h]                              
080305BE 1A40     sub     r0,r0,r1                                
080305C0 80A0     strh    r0,[r4,4h]                              
080305C2 BC08     pop     r3                                      
080305C4 4698     mov     r8,r3                                   
080305C6 BCF0     pop     r4-r7                                   
080305C8 BC01     pop     r0                                      
080305CA 4700     bx      r0                                      
080305CC B5F0     push    r4-r7,r14                               
080305CE 4647     mov     r7,r8                                   
080305D0 B480     push    r7                                      
080305D2 1C04     mov     r4,r0                                   
080305D4 8821     ldrh    r1,[r4]                                 
080305D6 2080     mov     r0,80h                                  
080305D8 0100     lsl     r0,r0,4h                                
080305DA 4008     and     r0,r1                                   
080305DC 2800     cmp     r0,0h                                   
080305DE D004     beq     80305EAh                                
080305E0 1C21     mov     r1,r4                                   
080305E2 3124     add     r1,24h                                  
080305E4 2042     mov     r0,42h                                  
080305E6 7008     strb    r0,[r1]                                 
080305E8 E047     b       803067Ah                                
080305EA 1C22     mov     r2,r4                                   
080305EC 322F     add     r2,2Fh                                  
080305EE 7810     ldrb    r0,[r2]                                 
080305F0 1C01     mov     r1,r0                                   
080305F2 31FF     add     r1,0FFh                                 
080305F4 7011     strb    r1,[r2]                                 
080305F6 0600     lsl     r0,r0,18h                               
080305F8 0E01     lsr     r1,r0,18h                               
080305FA 2900     cmp     r1,0h                                   
080305FC D003     beq     8030606h                                
080305FE 8860     ldrh    r0,[r4,2h]                              
08030600 1A40     sub     r0,r0,r1                                
08030602 8060     strh    r0,[r4,2h]                              
08030604 E004     b       8030610h                                
08030606 7011     strb    r1,[r2]                                 
08030608 1C21     mov     r1,r4                                   
0803060A 3124     add     r1,24h                                  
0803060C 204B     mov     r0,4Bh                                  
0803060E 7008     strb    r0,[r1]                                 
08030610 8865     ldrh    r5,[r4,2h]                              
08030612 46A8     mov     r8,r5                                   
08030614 88A6     ldrh    r6,[r4,4h]                              
08030616 1C37     mov     r7,r6                                   
08030618 1C28     mov     r0,r5                                   
0803061A 3814     sub     r0,14h                                  
0803061C 1C31     mov     r1,r6                                   
0803061E F7DFF87F bl      800F720h                                
08030622 2811     cmp     r0,11h                                  
08030624 D103     bne     803062Eh                                
08030626 480C     ldr     r0,=0FFC0h                              
08030628 4028     and     r0,r5                                   
0803062A 3050     add     r0,50h                                  
0803062C 8060     strh    r0,[r4,2h]                              
0803062E 8821     ldrh    r1,[r4]                                 
08030630 2040     mov     r0,40h                                  
08030632 4008     and     r0,r1                                   
08030634 2800     cmp     r0,0h                                   
08030636 D011     beq     803065Ch                                
08030638 1C31     mov     r1,r6                                   
0803063A 3110     add     r1,10h                                  
0803063C 1C28     mov     r0,r5                                   
0803063E F7DFF86F bl      800F720h                                
08030642 21F0     mov     r1,0F0h                                 
08030644 4001     and     r1,r0                                   
08030646 2900     cmp     r1,0h                                   
08030648 D117     bne     803067Ah                                
0803064A 1C21     mov     r1,r4                                   
0803064C 312E     add     r1,2Eh                                  
0803064E 88A0     ldrh    r0,[r4,4h]                              
08030650 7809     ldrb    r1,[r1]                                 
08030652 1840     add     r0,r0,r1                                
08030654 E010     b       8030678h                                
08030656 0000     lsl     r0,r0,0h                                
08030658 FFC0     bl      lr+0F80h                                
0803065A 0000     lsl     r0,r0,0h                                
0803065C 1C39     mov     r1,r7                                   
0803065E 3910     sub     r1,10h                                  
08030660 4640     mov     r0,r8                                   
08030662 F7DFF85D bl      800F720h                                
08030666 21F0     mov     r1,0F0h                                 
08030668 4001     and     r1,r0                                   
0803066A 2900     cmp     r1,0h                                   
0803066C D105     bne     803067Ah                                
0803066E 1C20     mov     r0,r4                                   
08030670 302E     add     r0,2Eh                                  
08030672 7801     ldrb    r1,[r0]                                 
08030674 88A0     ldrh    r0,[r4,4h]                              
08030676 1A40     sub     r0,r0,r1                                
08030678 80A0     strh    r0,[r4,4h]                              
0803067A BC08     pop     r3                                      
0803067C 4698     mov     r8,r3                                   
0803067E BCF0     pop     r4-r7                                   
08030680 BC01     pop     r0                                      
08030682 4700     bx      r0                                      
08030684 B5F0     push    r4-r7,r14                               
08030686 464F     mov     r7,r9                                   
08030688 4646     mov     r6,r8                                   
0803068A B4C0     push    r6,r7                                   
0803068C 1C04     mov     r4,r0                                   
0803068E 8821     ldrh    r1,[r4]                                 
08030690 2080     mov     r0,80h                                  
08030692 0100     lsl     r0,r0,4h                                
08030694 4008     and     r0,r1                                   
08030696 2800     cmp     r0,0h                                   
08030698 D004     beq     80306A4h                                
0803069A 1C21     mov     r1,r4                                   
0803069C 3124     add     r1,24h                                  
0803069E 2042     mov     r0,42h                                  
080306A0 7008     strb    r0,[r1]                                 
080306A2 E047     b       8030734h                                
080306A4 1C22     mov     r2,r4                                   
080306A6 322F     add     r2,2Fh                                  
080306A8 7810     ldrb    r0,[r2]                                 
080306AA 1C01     mov     r1,r0                                   
080306AC 31FF     add     r1,0FFh                                 
080306AE 7011     strb    r1,[r2]                                 
080306B0 0600     lsl     r0,r0,18h                               
080306B2 0E01     lsr     r1,r0,18h                               
080306B4 2900     cmp     r1,0h                                   
080306B6 D003     beq     80306C0h                                
080306B8 8860     ldrh    r0,[r4,2h]                              
080306BA 1A40     sub     r0,r0,r1                                
080306BC 8060     strh    r0,[r4,2h]                              
080306BE E004     b       80306CAh                                
080306C0 7011     strb    r1,[r2]                                 
080306C2 1C21     mov     r1,r4                                   
080306C4 3124     add     r1,24h                                  
080306C6 204B     mov     r0,4Bh                                  
080306C8 7008     strb    r0,[r1]                                 
080306CA 8865     ldrh    r5,[r4,2h]                              
080306CC 46A9     mov     r9,r5                                   
080306CE 88A6     ldrh    r6,[r4,4h]                              
080306D0 46B0     mov     r8,r6                                   
080306D2 1C28     mov     r0,r5                                   
080306D4 3814     sub     r0,14h                                  
080306D6 1C31     mov     r1,r6                                   
080306D8 F027FBD0 bl      8057E7Ch                                
080306DC 2780     mov     r7,80h                                  
080306DE 047F     lsl     r7,r7,11h                               
080306E0 4038     and     r0,r7                                   
080306E2 2800     cmp     r0,0h                                   
080306E4 D003     beq     80306EEh                                
080306E6 480B     ldr     r0,=0FFC0h                              
080306E8 4028     and     r0,r5                                   
080306EA 3050     add     r0,50h                                  
080306EC 8060     strh    r0,[r4,2h]                              
080306EE 8821     ldrh    r1,[r4]                                 
080306F0 2040     mov     r0,40h                                  
080306F2 4008     and     r0,r1                                   
080306F4 2800     cmp     r0,0h                                   
080306F6 D00F     beq     8030718h                                
080306F8 1C31     mov     r1,r6                                   
080306FA 3110     add     r1,10h                                  
080306FC 1C28     mov     r0,r5                                   
080306FE F027FBBD bl      8057E7Ch                                
08030702 4038     and     r0,r7                                   
08030704 2800     cmp     r0,0h                                   
08030706 D115     bne     8030734h                                
08030708 1C21     mov     r1,r4                                   
0803070A 312E     add     r1,2Eh                                  
0803070C 88A0     ldrh    r0,[r4,4h]                              
0803070E 7809     ldrb    r1,[r1]                                 
08030710 1840     add     r0,r0,r1                                
08030712 E00E     b       8030732h                                
08030714 FFC0     bl      lr+0F80h                                
08030716 0000     lsl     r0,r0,0h                                
08030718 4641     mov     r1,r8                                   
0803071A 3910     sub     r1,10h                                  
0803071C 4648     mov     r0,r9                                   
0803071E F027FBAD bl      8057E7Ch                                
08030722 4038     and     r0,r7                                   
08030724 2800     cmp     r0,0h                                   
08030726 D105     bne     8030734h                                
08030728 1C20     mov     r0,r4                                   
0803072A 302E     add     r0,2Eh                                  
0803072C 7801     ldrb    r1,[r0]                                 
0803072E 88A0     ldrh    r0,[r4,4h]                              
08030730 1A40     sub     r0,r0,r1                                
08030732 80A0     strh    r0,[r4,4h]                              
08030734 BC18     pop     r3,r4                                   
08030736 4698     mov     r8,r3                                   
08030738 46A1     mov     r9,r4                                   
0803073A BCF0     pop     r4-r7                                   
0803073C BC01     pop     r0                                      
0803073E 4700     bx      r0                                      
08030740 B5F0     push    r4-r7,r14                               
08030742 4647     mov     r7,r8                                   
08030744 B480     push    r7                                      
08030746 1C04     mov     r4,r0                                   
08030748 8860     ldrh    r0,[r4,2h]                              
0803074A 4680     mov     r8,r0                                   
0803074C 8821     ldrh    r1,[r4]                                 
0803074E 2080     mov     r0,80h                                  
08030750 0100     lsl     r0,r0,4h                                
08030752 4008     and     r0,r1                                   
08030754 0400     lsl     r0,r0,10h                               
08030756 0C07     lsr     r7,r0,10h                               
08030758 2F00     cmp     r7,0h                                   
0803075A D004     beq     8030766h                                
0803075C 1C21     mov     r1,r4                                   
0803075E 3124     add     r1,24h                                  
08030760 2042     mov     r0,42h                                  
08030762 7008     strb    r0,[r1]                                 
08030764 E04D     b       8030802h                                
08030766 1C22     mov     r2,r4                                   
08030768 322F     add     r2,2Fh                                  
0803076A 7811     ldrb    r1,[r2]                                 
0803076C 290F     cmp     r1,0Fh                                  
0803076E DC01     bgt     8030774h                                
08030770 1C88     add     r0,r1,2                                 
08030772 7010     strb    r0,[r2]                                 
08030774 8860     ldrh    r0,[r4,2h]                              
08030776 1840     add     r0,r0,r1                                
08030778 8060     strh    r0,[r4,2h]                              
0803077A 8865     ldrh    r5,[r4,2h]                              
0803077C 88A6     ldrh    r6,[r4,4h]                              
0803077E 1C28     mov     r0,r5                                   
08030780 1C31     mov     r1,r6                                   
08030782 F7DEFE7B bl      800F47Ch                                
08030786 1C02     mov     r2,r0                                   
08030788 4807     ldr     r0,=30007F0h                            
0803078A 7800     ldrb    r0,[r0]                                 
0803078C 2800     cmp     r0,0h                                   
0803078E D00F     beq     80307B0h                                
08030790 4806     ldr     r0,=82E8378h                            
08030792 61A0     str     r0,[r4,18h]                             
08030794 82E7     strh    r7,[r4,16h]                             
08030796 2000     mov     r0,0h                                   
08030798 7720     strb    r0,[r4,1Ch]                             
0803079A 1C21     mov     r1,r4                                   
0803079C 3124     add     r1,24h                                  
0803079E 200F     mov     r0,0Fh                                  
080307A0 7008     strb    r0,[r1]                                 
080307A2 8062     strh    r2,[r4,2h]                              
080307A4 E02D     b       8030802h                                
080307A6 0000     lsl     r0,r0,0h                                
080307A8 07F0     lsl     r0,r6,1Fh                               
080307AA 0300     lsl     r0,r0,0Ch                               
080307AC 8378     strh    r0,[r7,1Ah]                             
080307AE 082E     lsr     r6,r5,20h                               
080307B0 8821     ldrh    r1,[r4]                                 
080307B2 2040     mov     r0,40h                                  
080307B4 4008     and     r0,r1                                   
080307B6 2800     cmp     r0,0h                                   
080307B8 D00E     beq     80307D8h                                
080307BA 1C31     mov     r1,r6                                   
080307BC 3110     add     r1,10h                                  
080307BE 1C28     mov     r0,r5                                   
080307C0 F7DEFFAE bl      800F720h                                
080307C4 21F0     mov     r1,0F0h                                 
080307C6 4001     and     r1,r0                                   
080307C8 2900     cmp     r1,0h                                   
080307CA D114     bne     80307F6h                                
080307CC 1C21     mov     r1,r4                                   
080307CE 312E     add     r1,2Eh                                  
080307D0 88A0     ldrh    r0,[r4,4h]                              
080307D2 7809     ldrb    r1,[r1]                                 
080307D4 1840     add     r0,r0,r1                                
080307D6 E00D     b       80307F4h                                
080307D8 1C31     mov     r1,r6                                   
080307DA 3910     sub     r1,10h                                  
080307DC 1C28     mov     r0,r5                                   
080307DE F7DEFF9F bl      800F720h                                
080307E2 21F0     mov     r1,0F0h                                 
080307E4 4001     and     r1,r0                                   
080307E6 2900     cmp     r1,0h                                   
080307E8 D105     bne     80307F6h                                
080307EA 1C20     mov     r0,r4                                   
080307EC 302E     add     r0,2Eh                                  
080307EE 7801     ldrb    r1,[r0]                                 
080307F0 88A0     ldrh    r0,[r4,4h]                              
080307F2 1A40     sub     r0,r0,r1                                
080307F4 80A0     strh    r0,[r4,4h]                              
080307F6 4640     mov     r0,r8                                   
080307F8 1C29     mov     r1,r5                                   
080307FA 1C32     mov     r2,r6                                   
080307FC 2301     mov     r3,1h                                   
080307FE F7E0FF8B bl      8011718h                                
08030802 BC08     pop     r3                                      
08030804 4698     mov     r8,r3                                   
08030806 BCF0     pop     r4-r7                                   
08030808 BC01     pop     r0                                      
0803080A 4700     bx      r0                                      
0803080C B5F0     push    r4-r7,r14                               
0803080E 1C04     mov     r4,r0                                   
08030810 8821     ldrh    r1,[r4]                                 
08030812 2080     mov     r0,80h                                  
08030814 0100     lsl     r0,r0,4h                                
08030816 4008     and     r0,r1                                   
08030818 0400     lsl     r0,r0,10h                               
0803081A 0C07     lsr     r7,r0,10h                               
0803081C 2F00     cmp     r7,0h                                   
0803081E D004     beq     803082Ah                                
08030820 1C21     mov     r1,r4                                   
08030822 3124     add     r1,24h                                  
08030824 2042     mov     r0,42h                                  
08030826 7008     strb    r0,[r1]                                 
08030828 E04D     b       80308C6h                                
0803082A 1C22     mov     r2,r4                                   
0803082C 322F     add     r2,2Fh                                  
0803082E 7811     ldrb    r1,[r2]                                 
08030830 290F     cmp     r1,0Fh                                  
08030832 DC01     bgt     8030838h                                
08030834 1C88     add     r0,r1,2                                 
08030836 7010     strb    r0,[r2]                                 
08030838 8860     ldrh    r0,[r4,2h]                              
0803083A 1840     add     r0,r0,r1                                
0803083C 8060     strh    r0,[r4,2h]                              
0803083E 8865     ldrh    r5,[r4,2h]                              
08030840 88A6     ldrh    r6,[r4,4h]                              
08030842 1C28     mov     r0,r5                                   
08030844 1C31     mov     r1,r6                                   
08030846 F027FB19 bl      8057E7Ch                                
0803084A 2180     mov     r1,80h                                  
0803084C 0449     lsl     r1,r1,11h                               
0803084E 4001     and     r1,r0                                   
08030850 2900     cmp     r1,0h                                   
08030852 D013     beq     803087Ch                                
08030854 4A07     ldr     r2,=0FFC0h                              
08030856 402A     and     r2,r5                                   
08030858 4295     cmp     r5,r2                                   
0803085A DB0F     blt     803087Ch                                
0803085C 4806     ldr     r0,=82E8378h                            
0803085E 61A0     str     r0,[r4,18h]                             
08030860 82E7     strh    r7,[r4,16h]                             
08030862 2000     mov     r0,0h                                   
08030864 7720     strb    r0,[r4,1Ch]                             
08030866 1C21     mov     r1,r4                                   
08030868 3124     add     r1,24h                                  
0803086A 200F     mov     r0,0Fh                                  
0803086C 7008     strb    r0,[r1]                                 
0803086E 8062     strh    r2,[r4,2h]                              
08030870 E029     b       80308C6h                                
08030872 0000     lsl     r0,r0,0h                                
08030874 FFC0     bl      lr+0F80h                                
08030876 0000     lsl     r0,r0,0h                                
08030878 8378     strh    r0,[r7,1Ah]                             
0803087A 082E     lsr     r6,r5,20h                               
0803087C 8821     ldrh    r1,[r4]                                 
0803087E 2040     mov     r0,40h                                  
08030880 4008     and     r0,r1                                   
08030882 2800     cmp     r0,0h                                   
08030884 D00F     beq     80308A6h                                
08030886 1C31     mov     r1,r6                                   
08030888 3110     add     r1,10h                                  
0803088A 1C28     mov     r0,r5                                   
0803088C F027FAF6 bl      8057E7Ch                                
08030890 2180     mov     r1,80h                                  
08030892 0449     lsl     r1,r1,11h                               
08030894 4001     and     r1,r0                                   
08030896 2900     cmp     r1,0h                                   
08030898 D115     bne     80308C6h                                
0803089A 1C21     mov     r1,r4                                   
0803089C 312E     add     r1,2Eh                                  
0803089E 88A0     ldrh    r0,[r4,4h]                              
080308A0 7809     ldrb    r1,[r1]                                 
080308A2 1840     add     r0,r0,r1                                
080308A4 E00E     b       80308C4h                                
080308A6 1C31     mov     r1,r6                                   
080308A8 3910     sub     r1,10h                                  
080308AA 1C28     mov     r0,r5                                   
080308AC F027FAE6 bl      8057E7Ch                                
080308B0 2180     mov     r1,80h                                  
080308B2 0449     lsl     r1,r1,11h                               
080308B4 4001     and     r1,r0                                   
080308B6 2900     cmp     r1,0h                                   
080308B8 D105     bne     80308C6h                                
080308BA 1C20     mov     r0,r4                                   
080308BC 302E     add     r0,2Eh                                  
080308BE 7801     ldrb    r1,[r0]                                 
080308C0 88A0     ldrh    r0,[r4,4h]                              
080308C2 1A40     sub     r0,r0,r1                                
080308C4 80A0     strh    r0,[r4,4h]                              
080308C6 BCF0     pop     r4-r7                                   
080308C8 BC01     pop     r0                                      
080308CA 4700     bx      r0                                      
080308CC B510     push    r4,r14                                  
080308CE 1C03     mov     r3,r0                                   
080308D0 1C19     mov     r1,r3                                   
080308D2 3124     add     r1,24h                                  
080308D4 2200     mov     r2,0h                                   
080308D6 2009     mov     r0,9h                                   
080308D8 7008     strb    r0,[r1]                                 
080308DA 480E     ldr     r0,=82E8318h                            
080308DC 6198     str     r0,[r3,18h]                             
080308DE 2000     mov     r0,0h                                   
080308E0 82DA     strh    r2,[r3,16h]                             
080308E2 7718     strb    r0,[r3,1Ch]                             
080308E4 4C0C     ldr     r4,=300083Ch                            
080308E6 7820     ldrb    r0,[r4]                                 
080308E8 0840     lsr     r0,r0,1h                                
080308EA 2805     cmp     r0,5h                                   
080308EC D800     bhi     80308F0h                                
080308EE 2006     mov     r0,6h                                   
080308F0 1C19     mov     r1,r3                                   
080308F2 312E     add     r1,2Eh                                  
080308F4 7008     strb    r0,[r1]                                 
080308F6 8898     ldrh    r0,[r3,4h]                              
080308F8 0940     lsr     r0,r0,5h                                
080308FA 220F     mov     r2,0Fh                                  
080308FC 210F     mov     r1,0Fh                                  
080308FE 4008     and     r0,r1                                   
08030900 7824     ldrb    r4,[r4]                                 
08030902 1900     add     r0,r0,r4                                
08030904 4010     and     r0,r2                                   
08030906 1C19     mov     r1,r3                                   
08030908 312C     add     r1,2Ch                                  
0803090A 7008     strb    r0,[r1]                                 
0803090C BC10     pop     r4                                      
0803090E BC01     pop     r0                                      
08030910 4700     bx      r0                                      
08030912 0000     lsl     r0,r0,0h                                
08030914 8318     strh    r0,[r3,18h]                             
08030916 082E     lsr     r6,r5,20h                               
08030918 083C     lsr     r4,r7,20h                               
0803091A 0300     lsl     r0,r0,0Ch                               
0803091C B570     push    r4-r6,r14                               
0803091E 1C05     mov     r5,r0                                   
08030920 8829     ldrh    r1,[r5]                                 
08030922 2080     mov     r0,80h                                  
08030924 0100     lsl     r0,r0,4h                                
08030926 4008     and     r0,r1                                   
08030928 0400     lsl     r0,r0,10h                               
0803092A 0C06     lsr     r6,r0,10h                               
0803092C 2E00     cmp     r6,0h                                   
0803092E D004     beq     803093Ah                                
08030930 1C29     mov     r1,r5                                   
08030932 3124     add     r1,24h                                  
08030934 2042     mov     r0,42h                                  
08030936 7008     strb    r0,[r1]                                 
08030938 E0B9     b       8030AAEh                                
0803093A F7DEFE2B bl      800F594h                                
0803093E 4804     ldr     r0,=30007F0h                            
08030940 7800     ldrb    r0,[r0]                                 
08030942 2800     cmp     r0,0h                                   
08030944 D106     bne     8030954h                                
08030946 1C29     mov     r1,r5                                   
08030948 3124     add     r1,24h                                  
0803094A 201E     mov     r0,1Eh                                  
0803094C 7008     strb    r0,[r1]                                 
0803094E E0AE     b       8030AAEh                                
08030950 07F0     lsl     r0,r6,1Fh                               
08030952 0300     lsl     r0,r0,0Ch                               
08030954 8868     ldrh    r0,[r5,2h]                              
08030956 3810     sub     r0,10h                                  
08030958 88A9     ldrh    r1,[r5,4h]                              
0803095A F7DEFEE1 bl      800F720h                                
0803095E 2811     cmp     r0,11h                                  
08030960 D104     bne     803096Ch                                
08030962 1C29     mov     r1,r5                                   
08030964 3124     add     r1,24h                                  
08030966 2062     mov     r0,62h                                  
08030968 7008     strb    r0,[r1]                                 
0803096A E0A0     b       8030AAEh                                
0803096C 1C2A     mov     r2,r5                                   
0803096E 322C     add     r2,2Ch                                  
08030970 7814     ldrb    r4,[r2]                                 
08030972 480A     ldr     r0,=3000C77h                            
08030974 7800     ldrb    r0,[r0]                                 
08030976 0901     lsr     r1,r0,4h                                
08030978 42A1     cmp     r1,r4                                   
0803097A D115     bne     80309A8h                                
0803097C 4808     ldr     r0,=82E8350h                            
0803097E 61A8     str     r0,[r5,18h]                             
08030980 2000     mov     r0,0h                                   
08030982 82EE     strh    r6,[r5,16h]                             
08030984 7728     strb    r0,[r5,1Ch]                             
08030986 4807     ldr     r0,=300083Ch                            
08030988 7801     ldrb    r1,[r0]                                 
0803098A 0048     lsl     r0,r1,1h                                
0803098C 1840     add     r0,r0,r1                                
0803098E 7010     strb    r0,[r2]                                 
08030990 1C29     mov     r1,r5                                   
08030992 3124     add     r1,24h                                  
08030994 200F     mov     r0,0Fh                                  
08030996 7008     strb    r0,[r1]                                 
08030998 E089     b       8030AAEh                                
0803099A 0000     lsl     r0,r0,0h                                
0803099C 0C77     lsr     r7,r6,11h                               
0803099E 0300     lsl     r0,r0,0Ch                               
080309A0 8350     strh    r0,[r2,1Ah]                             
080309A2 082E     lsr     r6,r5,20h                               
080309A4 083C     lsr     r4,r7,20h                               
080309A6 0300     lsl     r0,r0,0Ch                               
080309A8 1C60     add     r0,r4,1                                 
080309AA 4281     cmp     r1,r0                                   
080309AC D002     beq     80309B4h                                
080309AE 1E60     sub     r0,r4,1                                 
080309B0 4281     cmp     r1,r0                                   
080309B2 D135     bne     8030A20h                                
080309B4 1C29     mov     r1,r5                                   
080309B6 3124     add     r1,24h                                  
080309B8 2049     mov     r0,49h                                  
080309BA 7008     strb    r0,[r1]                                 
080309BC 4807     ldr     r0,=82E8480h                            
080309BE 61A8     str     r0,[r5,18h]                             
080309C0 2000     mov     r0,0h                                   
080309C2 82EE     strh    r6,[r5,16h]                             
080309C4 7728     strb    r0,[r5,1Ch]                             
080309C6 4806     ldr     r0,=300083Ch                            
080309C8 7801     ldrb    r1,[r0]                                 
080309CA 2903     cmp     r1,3h                                   
080309CC D80A     bhi     80309E4h                                
080309CE 1C29     mov     r1,r5                                   
080309D0 312F     add     r1,2Fh                                  
080309D2 2004     mov     r0,4h                                   
080309D4 7008     strb    r0,[r1]                                 
080309D6 1C0A     mov     r2,r1                                   
080309D8 E008     b       80309ECh                                
080309DA 0000     lsl     r0,r0,0h                                
080309DC 8480     strh    r0,[r0,24h]                             
080309DE 082E     lsr     r6,r5,20h                               
080309E0 083C     lsr     r4,r7,20h                               
080309E2 0300     lsl     r0,r0,0Ch                               
080309E4 1C28     mov     r0,r5                                   
080309E6 302F     add     r0,2Fh                                  
080309E8 7001     strb    r1,[r0]                                 
080309EA 1C02     mov     r2,r0                                   
080309EC 8829     ldrh    r1,[r5]                                 
080309EE 2002     mov     r0,2h                                   
080309F0 4008     and     r0,r1                                   
080309F2 2800     cmp     r0,0h                                   
080309F4 D05B     beq     8030AAEh                                
080309F6 7814     ldrb    r4,[r2]                                 
080309F8 2C07     cmp     r4,7h                                   
080309FA D804     bhi     8030A06h                                
080309FC 20BA     mov     r0,0BAh                                 
080309FE 0040     lsl     r0,r0,1h                                
08030A00 F7D2F88E bl      8002B20h                                
08030A04 E053     b       8030AAEh                                
08030A06 2C0B     cmp     r4,0Bh                                  
08030A08 D904     bls     8030A14h                                
08030A0A 20BB     mov     r0,0BBh                                 
08030A0C 0040     lsl     r0,r0,1h                                
08030A0E F7D2F887 bl      8002B20h                                
08030A12 E04C     b       8030AAEh                                
08030A14 4801     ldr     r0,=175h                                
08030A16 F7D2F883 bl      8002B20h                                
08030A1A E048     b       8030AAEh                                
08030A1C 0175     lsl     r5,r6,5h                                
08030A1E 0000     lsl     r0,r0,0h                                
08030A20 4E07     ldr     r6,=3000734h                            
08030A22 7830     ldrb    r0,[r6]                                 
08030A24 2800     cmp     r0,0h                                   
08030A26 D10D     bne     8030A44h                                
08030A28 2060     mov     r0,60h                                  
08030A2A 2148     mov     r1,48h                                  
08030A2C F7DFF9D8 bl      800FDE0h                                
08030A30 2800     cmp     r0,0h                                   
08030A32 D001     beq     8030A38h                                
08030A34 205A     mov     r0,5Ah                                  
08030A36 7030     strb    r0,[r6]                                 
08030A38 2001     mov     r0,1h                                   
08030A3A 4004     and     r4,r0                                   
08030A3C 3401     add     r4,1h                                   
08030A3E E004     b       8030A4Ah                                
08030A40 0734     lsl     r4,r6,1Ch                               
08030A42 0300     lsl     r0,r0,0Ch                               
08030A44 1C28     mov     r0,r5                                   
08030A46 302E     add     r0,2Eh                                  
08030A48 7804     ldrb    r4,[r0]                                 
08030A4A 8829     ldrh    r1,[r5]                                 
08030A4C 2040     mov     r0,40h                                  
08030A4E 4008     and     r0,r1                                   
08030A50 2800     cmp     r0,0h                                   
08030A52 D013     beq     8030A7Ch                                
08030A54 4808     ldr     r0,=30007F0h                            
08030A56 7801     ldrb    r1,[r0]                                 
08030A58 20F0     mov     r0,0F0h                                 
08030A5A 4008     and     r0,r1                                   
08030A5C 2800     cmp     r0,0h                                   
08030A5E D007     beq     8030A70h                                
08030A60 8868     ldrh    r0,[r5,2h]                              
08030A62 3810     sub     r0,10h                                  
08030A64 88A9     ldrh    r1,[r5,4h]                              
08030A66 3110     add     r1,10h                                  
08030A68 F7DEFE5A bl      800F720h                                
08030A6C 2811     cmp     r0,11h                                  
08030A6E D013     beq     8030A98h                                
08030A70 88A8     ldrh    r0,[r5,4h]                              
08030A72 1820     add     r0,r4,r0                                
08030A74 E01A     b       8030AACh                                
08030A76 0000     lsl     r0,r0,0h                                
08030A78 07F0     lsl     r0,r6,1Fh                               
08030A7A 0300     lsl     r0,r0,0Ch                               
08030A7C 4809     ldr     r0,=30007F0h                            
08030A7E 7801     ldrb    r1,[r0]                                 
08030A80 20F0     mov     r0,0F0h                                 
08030A82 4008     and     r0,r1                                   
08030A84 2800     cmp     r0,0h                                   
08030A86 D00F     beq     8030AA8h                                
08030A88 8868     ldrh    r0,[r5,2h]                              
08030A8A 3810     sub     r0,10h                                  
08030A8C 88A9     ldrh    r1,[r5,4h]                              
08030A8E 3910     sub     r1,10h                                  
08030A90 F7DEFE46 bl      800F720h                                
08030A94 2811     cmp     r0,11h                                  
08030A96 D107     bne     8030AA8h                                
08030A98 1C29     mov     r1,r5                                   
08030A9A 3124     add     r1,24h                                  
08030A9C 200A     mov     r0,0Ah                                  
08030A9E 7008     strb    r0,[r1]                                 
08030AA0 E005     b       8030AAEh                                
08030AA2 0000     lsl     r0,r0,0h                                
08030AA4 07F0     lsl     r0,r6,1Fh                               
08030AA6 0300     lsl     r0,r0,0Ch                               
08030AA8 88A8     ldrh    r0,[r5,4h]                              
08030AAA 1B00     sub     r0,r0,r4                                
08030AAC 80A8     strh    r0,[r5,4h]                              
08030AAE BC70     pop     r4-r6                                   
08030AB0 BC01     pop     r0                                      
08030AB2 4700     bx      r0                                      
08030AB4 B570     push    r4-r6,r14                               
08030AB6 1C04     mov     r4,r0                                   
08030AB8 8821     ldrh    r1,[r4]                                 
08030ABA 2080     mov     r0,80h                                  
08030ABC 0100     lsl     r0,r0,4h                                
08030ABE 4008     and     r0,r1                                   
08030AC0 2800     cmp     r0,0h                                   
08030AC2 D004     beq     8030ACEh                                
08030AC4 1C21     mov     r1,r4                                   
08030AC6 3124     add     r1,24h                                  
08030AC8 2042     mov     r0,42h                                  
08030ACA 7008     strb    r0,[r1]                                 
08030ACC E0C1     b       8030C52h                                
08030ACE 1C20     mov     r0,r4                                   
08030AD0 3023     add     r0,23h                                  
08030AD2 7801     ldrb    r1,[r0]                                 
08030AD4 2201     mov     r2,1h                                   
08030AD6 1C10     mov     r0,r2                                   
08030AD8 4008     and     r0,r1                                   
08030ADA 2800     cmp     r0,0h                                   
08030ADC D008     beq     8030AF0h                                
08030ADE 4803     ldr     r0,=3000C77h                            
08030AE0 7801     ldrb    r1,[r0]                                 
08030AE2 1C10     mov     r0,r2                                   
08030AE4 4008     and     r0,r1                                   
08030AE6 2800     cmp     r0,0h                                   
08030AE8 D01A     beq     8030B20h                                
08030AEA E007     b       8030AFCh                                
08030AEC 0C77     lsr     r7,r6,11h                               
08030AEE 0300     lsl     r0,r0,0Ch                               
08030AF0 480A     ldr     r0,=3000C77h                            
08030AF2 7801     ldrb    r1,[r0]                                 
08030AF4 1C10     mov     r0,r2                                   
08030AF6 4008     and     r0,r1                                   
08030AF8 2800     cmp     r0,0h                                   
08030AFA D111     bne     8030B20h                                
08030AFC 8860     ldrh    r0,[r4,2h]                              
08030AFE 88A1     ldrh    r1,[r4,4h]                              
08030B00 F027F9BC bl      8057E7Ch                                
08030B04 1C01     mov     r1,r0                                   
08030B06 2080     mov     r0,80h                                  
08030B08 0440     lsl     r0,r0,11h                               
08030B0A 4008     and     r0,r1                                   
08030B0C 2800     cmp     r0,0h                                   
08030B0E D107     bne     8030B20h                                
08030B10 1C21     mov     r1,r4                                   
08030B12 3124     add     r1,24h                                  
08030B14 201E     mov     r0,1Eh                                  
08030B16 7008     strb    r0,[r1]                                 
08030B18 E09B     b       8030C52h                                
08030B1A 0000     lsl     r0,r0,0h                                
08030B1C 0C77     lsr     r7,r6,11h                               
08030B1E 0300     lsl     r0,r0,0Ch                               
08030B20 1C22     mov     r2,r4                                   
08030B22 322C     add     r2,2Ch                                  
08030B24 7815     ldrb    r5,[r2]                                 
08030B26 480B     ldr     r0,=3000C77h                            
08030B28 7800     ldrb    r0,[r0]                                 
08030B2A 0900     lsr     r0,r0,4h                                
08030B2C 1C01     mov     r1,r0                                   
08030B2E 42A9     cmp     r1,r5                                   
08030B30 D116     bne     8030B60h                                
08030B32 4809     ldr     r0,=82E8350h                            
08030B34 61A0     str     r0,[r4,18h]                             
08030B36 2100     mov     r1,0h                                   
08030B38 2000     mov     r0,0h                                   
08030B3A 82E0     strh    r0,[r4,16h]                             
08030B3C 7721     strb    r1,[r4,1Ch]                             
08030B3E 4807     ldr     r0,=300083Ch                            
08030B40 7801     ldrb    r1,[r0]                                 
08030B42 0048     lsl     r0,r1,1h                                
08030B44 1840     add     r0,r0,r1                                
08030B46 7010     strb    r0,[r2]                                 
08030B48 1C21     mov     r1,r4                                   
08030B4A 3124     add     r1,24h                                  
08030B4C 200F     mov     r0,0Fh                                  
08030B4E 7008     strb    r0,[r1]                                 
08030B50 E07F     b       8030C52h                                
08030B52 0000     lsl     r0,r0,0h                                
08030B54 0C77     lsr     r7,r6,11h                               
08030B56 0300     lsl     r0,r0,0Ch                               
08030B58 8350     strh    r0,[r2,1Ah]                             
08030B5A 082E     lsr     r6,r5,20h                               
08030B5C 083C     lsr     r4,r7,20h                               
08030B5E 0300     lsl     r0,r0,0Ch                               
08030B60 1C68     add     r0,r5,1                                 
08030B62 4281     cmp     r1,r0                                   
08030B64 D002     beq     8030B6Ch                                
08030B66 1E68     sub     r0,r5,1                                 
08030B68 4281     cmp     r1,r0                                   
08030B6A D135     bne     8030BD8h                                
08030B6C 1C21     mov     r1,r4                                   
08030B6E 3124     add     r1,24h                                  
08030B70 2200     mov     r2,0h                                   
08030B72 2049     mov     r0,49h                                  
08030B74 7008     strb    r0,[r1]                                 
08030B76 4807     ldr     r0,=82E8480h                            
08030B78 61A0     str     r0,[r4,18h]                             
08030B7A 2000     mov     r0,0h                                   
08030B7C 82E2     strh    r2,[r4,16h]                             
08030B7E 7720     strb    r0,[r4,1Ch]                             
08030B80 4805     ldr     r0,=300083Ch                            
08030B82 7801     ldrb    r1,[r0]                                 
08030B84 2903     cmp     r1,3h                                   
08030B86 D809     bhi     8030B9Ch                                
08030B88 1C21     mov     r1,r4                                   
08030B8A 312F     add     r1,2Fh                                  
08030B8C 2004     mov     r0,4h                                   
08030B8E 7008     strb    r0,[r1]                                 
08030B90 1C0A     mov     r2,r1                                   
08030B92 E007     b       8030BA4h                                
08030B94 8480     strh    r0,[r0,24h]                             
08030B96 082E     lsr     r6,r5,20h                               
08030B98 083C     lsr     r4,r7,20h                               
08030B9A 0300     lsl     r0,r0,0Ch                               
08030B9C 1C20     mov     r0,r4                                   
08030B9E 302F     add     r0,2Fh                                  
08030BA0 7001     strb    r1,[r0]                                 
08030BA2 1C02     mov     r2,r0                                   
08030BA4 8821     ldrh    r1,[r4]                                 
08030BA6 2002     mov     r0,2h                                   
08030BA8 4008     and     r0,r1                                   
08030BAA 2800     cmp     r0,0h                                   
08030BAC D051     beq     8030C52h                                
08030BAE 7815     ldrb    r5,[r2]                                 
08030BB0 2D07     cmp     r5,7h                                   
08030BB2 D804     bhi     8030BBEh                                
08030BB4 20BA     mov     r0,0BAh                                 
08030BB6 0040     lsl     r0,r0,1h                                
08030BB8 F7D1FFB2 bl      8002B20h                                
08030BBC E049     b       8030C52h                                
08030BBE 2D0B     cmp     r5,0Bh                                  
08030BC0 D904     bls     8030BCCh                                
08030BC2 20BB     mov     r0,0BBh                                 
08030BC4 0040     lsl     r0,r0,1h                                
08030BC6 F7D1FFAB bl      8002B20h                                
08030BCA E042     b       8030C52h                                
08030BCC 4801     ldr     r0,=175h                                
08030BCE F7D1FFA7 bl      8002B20h                                
08030BD2 E03E     b       8030C52h                                
08030BD4 0175     lsl     r5,r6,5h                                
08030BD6 0000     lsl     r0,r0,0h                                
08030BD8 4E07     ldr     r6,=3000734h                            
08030BDA 7830     ldrb    r0,[r6]                                 
08030BDC 2800     cmp     r0,0h                                   
08030BDE D10D     bne     8030BFCh                                
08030BE0 2060     mov     r0,60h                                  
08030BE2 2148     mov     r1,48h                                  
08030BE4 F7DFF8FC bl      800FDE0h                                
08030BE8 2800     cmp     r0,0h                                   
08030BEA D001     beq     8030BF0h                                
08030BEC 205A     mov     r0,5Ah                                  
08030BEE 7030     strb    r0,[r6]                                 
08030BF0 2001     mov     r0,1h                                   
08030BF2 4005     and     r5,r0                                   
08030BF4 3501     add     r5,1h                                   
08030BF6 E004     b       8030C02h                                
08030BF8 0734     lsl     r4,r6,1Ch                               
08030BFA 0300     lsl     r0,r0,0Ch                               
08030BFC 1C20     mov     r0,r4                                   
08030BFE 302E     add     r0,2Eh                                  
08030C00 7805     ldrb    r5,[r0]                                 
08030C02 8821     ldrh    r1,[r4]                                 
08030C04 2040     mov     r0,40h                                  
08030C06 4008     and     r0,r1                                   
08030C08 2800     cmp     r0,0h                                   
08030C0A D00E     beq     8030C2Ah                                
08030C0C 8860     ldrh    r0,[r4,2h]                              
08030C0E 3810     sub     r0,10h                                  
08030C10 88A1     ldrh    r1,[r4,4h]                              
08030C12 3110     add     r1,10h                                  
08030C14 F027F932 bl      8057E7Ch                                
08030C18 1C01     mov     r1,r0                                   
08030C1A 2080     mov     r0,80h                                  
08030C1C 0440     lsl     r0,r0,11h                               
08030C1E 4008     and     r0,r1                                   
08030C20 2800     cmp     r0,0h                                   
08030C22 D10E     bne     8030C42h                                
08030C24 88A0     ldrh    r0,[r4,4h]                              
08030C26 1828     add     r0,r5,r0                                
08030C28 E012     b       8030C50h                                
08030C2A 8860     ldrh    r0,[r4,2h]                              
08030C2C 3810     sub     r0,10h                                  
08030C2E 88A1     ldrh    r1,[r4,4h]                              
08030C30 3910     sub     r1,10h                                  
08030C32 F027F923 bl      8057E7Ch                                
08030C36 1C01     mov     r1,r0                                   
08030C38 2080     mov     r0,80h                                  
08030C3A 0440     lsl     r0,r0,11h                               
08030C3C 4008     and     r0,r1                                   
08030C3E 2800     cmp     r0,0h                                   
08030C40 D004     beq     8030C4Ch                                
08030C42 1C21     mov     r1,r4                                   
08030C44 3124     add     r1,24h                                  
08030C46 200A     mov     r0,0Ah                                  
08030C48 7008     strb    r0,[r1]                                 
08030C4A E002     b       8030C52h                                
08030C4C 88A0     ldrh    r0,[r4,4h]                              
08030C4E 1B40     sub     r0,r0,r5                                
08030C50 80A0     strh    r0,[r4,4h]                              
08030C52 BC70     pop     r4-r6                                   
08030C54 BC01     pop     r0                                      
08030C56 4700     bx      r0                                      
08030C58 1C02     mov     r2,r0                                   
08030C5A 3224     add     r2,24h                                  
08030C5C 2300     mov     r3,0h                                   
08030C5E 210B     mov     r1,0Bh                                  
08030C60 7011     strb    r1,[r2]                                 
08030C62 4903     ldr     r1,=82E8400h                            
08030C64 6181     str     r1,[r0,18h]                             
08030C66 2100     mov     r1,0h                                   
08030C68 82C3     strh    r3,[r0,16h]                             
08030C6A 7701     strb    r1,[r0,1Ch]                             
08030C6C 4770     bx      r14                                     
08030C6E 0000     lsl     r0,r0,0h                                
08030C70 8400     strh    r0,[r0,20h]                             
08030C72 082E     lsr     r6,r5,20h                               
08030C74 B510     push    r4,r14                                  
08030C76 1C04     mov     r4,r0                                   
08030C78 F7DEFFA6 bl      800FBC8h                                
08030C7C 2800     cmp     r0,0h                                   
08030C7E D007     beq     8030C90h                                
08030C80 8820     ldrh    r0,[r4]                                 
08030C82 2140     mov     r1,40h                                  
08030C84 4048     eor     r0,r1                                   
08030C86 8020     strh    r0,[r4]                                 
08030C88 1C21     mov     r1,r4                                   
08030C8A 3124     add     r1,24h                                  
08030C8C 200C     mov     r0,0Ch                                  
08030C8E 7008     strb    r0,[r1]                                 
08030C90 BC10     pop     r4                                      
08030C92 BC01     pop     r0                                      
08030C94 4700     bx      r0                                      
08030C96 0000     lsl     r0,r0,0h                                
08030C98 B510     push    r4,r14                                  
08030C9A 1C04     mov     r4,r0                                   
08030C9C F7DEFFB0 bl      800FC00h                                
08030CA0 2800     cmp     r0,0h                                   
08030CA2 D003     beq     8030CACh                                
08030CA4 1C21     mov     r1,r4                                   
08030CA6 3124     add     r1,24h                                  
08030CA8 2008     mov     r0,8h                                   
08030CAA 7008     strb    r0,[r1]                                 
08030CAC BC10     pop     r4                                      
08030CAE BC01     pop     r0                                      
08030CB0 4700     bx      r0                                      
08030CB2 0000     lsl     r0,r0,0h                                
08030CB4 1C02     mov     r2,r0                                   
08030CB6 3224     add     r2,24h                                  
08030CB8 2300     mov     r3,0h                                   
08030CBA 210F     mov     r1,0Fh                                  
08030CBC 7011     strb    r1,[r2]                                 
08030CBE 4904     ldr     r1,=82E8350h                            
08030CC0 6181     str     r1,[r0,18h]                             
08030CC2 2100     mov     r1,0h                                   
08030CC4 82C3     strh    r3,[r0,16h]                             
08030CC6 7701     strb    r1,[r0,1Ch]                             
08030CC8 302C     add     r0,2Ch                                  
08030CCA 211E     mov     r1,1Eh                                  
08030CCC 7001     strb    r1,[r0]                                 
08030CCE 4770     bx      r14                                     
08030CD0 8350     strh    r0,[r2,1Ah]                             
08030CD2 082E     lsr     r6,r5,20h                               
08030CD4 B530     push    r4,r5,r14                               
08030CD6 1C04     mov     r4,r0                                   
08030CD8 8860     ldrh    r0,[r4,2h]                              
08030CDA 88A1     ldrh    r1,[r4,4h]                              
08030CDC F027F8CE bl      8057E7Ch                                
08030CE0 2180     mov     r1,80h                                  
08030CE2 0449     lsl     r1,r1,11h                               
08030CE4 4001     and     r1,r0                                   
08030CE6 2900     cmp     r1,0h                                   
08030CE8 D103     bne     8030CF2h                                
08030CEA 1C21     mov     r1,r4                                   
08030CEC 3124     add     r1,24h                                  
08030CEE 201E     mov     r0,1Eh                                  
08030CF0 E03B     b       8030D6Ah                                
08030CF2 2500     mov     r5,0h                                   
08030CF4 69A1     ldr     r1,[r4,18h]                             
08030CF6 4806     ldr     r0,=82E8350h                            
08030CF8 4281     cmp     r1,r0                                   
08030CFA D10B     bne     8030D14h                                
08030CFC 1C21     mov     r1,r4                                   
08030CFE 312C     add     r1,2Ch                                  
08030D00 7808     ldrb    r0,[r1]                                 
08030D02 3801     sub     r0,1h                                   
08030D04 7008     strb    r0,[r1]                                 
08030D06 0600     lsl     r0,r0,18h                               
08030D08 2800     cmp     r0,0h                                   
08030D0A D11E     bne     8030D4Ah                                
08030D0C E01F     b       8030D4Eh                                
08030D0E 0000     lsl     r0,r0,0h                                
08030D10 8350     strh    r0,[r2,1Ah]                             
08030D12 082E     lsr     r6,r5,20h                               
08030D14 4808     ldr     r0,=82E8398h                            
08030D16 4281     cmp     r1,r0                                   
08030D18 D112     bne     8030D40h                                
08030D1A 1C21     mov     r1,r4                                   
08030D1C 312C     add     r1,2Ch                                  
08030D1E 7808     ldrb    r0,[r1]                                 
08030D20 3801     sub     r0,1h                                   
08030D22 7008     strb    r0,[r1]                                 
08030D24 0600     lsl     r0,r0,18h                               
08030D26 2800     cmp     r0,0h                                   
08030D28 D10F     bne     8030D4Ah                                
08030D2A 4804     ldr     r0,=82E83C0h                            
08030D2C 61A0     str     r0,[r4,18h]                             
08030D2E 2000     mov     r0,0h                                   
08030D30 82E5     strh    r5,[r4,16h]                             
08030D32 7720     strb    r0,[r4,1Ch]                             
08030D34 E009     b       8030D4Ah                                
08030D36 0000     lsl     r0,r0,0h                                
08030D38 8398     strh    r0,[r3,1Ch]                             
08030D3A 082E     lsr     r6,r5,20h                               
08030D3C 83C0     strh    r0,[r0,1Eh]                             
08030D3E 082E     lsr     r6,r5,20h                               
08030D40 F7DEFF5E bl      800FC00h                                
08030D44 2800     cmp     r0,0h                                   
08030D46 D000     beq     8030D4Ah                                
08030D48 2501     mov     r5,1h                                   
08030D4A 2D00     cmp     r5,0h                                   
08030D4C D00E     beq     8030D6Ch                                
08030D4E 4804     ldr     r0,=300083Ch                            
08030D50 7800     ldrb    r0,[r0]                                 
08030D52 2806     cmp     r0,6h                                   
08030D54 D906     bls     8030D64h                                
08030D56 1C21     mov     r1,r4                                   
08030D58 3124     add     r1,24h                                  
08030D5A 2008     mov     r0,8h                                   
08030D5C E005     b       8030D6Ah                                
08030D5E 0000     lsl     r0,r0,0h                                
08030D60 083C     lsr     r4,r7,20h                               
08030D62 0300     lsl     r0,r0,0Ch                               
08030D64 1C21     mov     r1,r4                                   
08030D66 3124     add     r1,24h                                  
08030D68 200A     mov     r0,0Ah                                  
08030D6A 7008     strb    r0,[r1]                                 
08030D6C BC30     pop     r4,r5                                   
08030D6E BC01     pop     r0                                      
08030D70 4700     bx      r0                                      
08030D72 0000     lsl     r0,r0,0h                                
08030D74 1C02     mov     r2,r0                                   
08030D76 3224     add     r2,24h                                  
08030D78 2300     mov     r3,0h                                   
08030D7A 211F     mov     r1,1Fh                                  
08030D7C 7011     strb    r1,[r2]                                 
08030D7E 302F     add     r0,2Fh                                  
08030D80 7003     strb    r3,[r0]                                 
08030D82 4770     bx      r14                                     
08030D84 B5F0     push    r4-r7,r14                               
08030D86 1C04     mov     r4,r0                                   
08030D88 8866     ldrh    r6,[r4,2h]                              
08030D8A 1C23     mov     r3,r4                                   
08030D8C 332F     add     r3,2Fh                                  
08030D8E 7819     ldrb    r1,[r3]                                 
08030D90 4D07     ldr     r5,=82B0D04h                            
08030D92 0048     lsl     r0,r1,1h                                
08030D94 1940     add     r0,r0,r5                                
08030D96 2700     mov     r7,0h                                   
08030D98 5FC2     ldsh    r2,[r0,r7]                              
08030D9A 4806     ldr     r0,=7FFFh                               
08030D9C 4282     cmp     r2,r0                                   
08030D9E D10B     bne     8030DB8h                                
08030DA0 1E48     sub     r0,r1,1                                 
08030DA2 0040     lsl     r0,r0,1h                                
08030DA4 1940     add     r0,r0,r5                                
08030DA6 2100     mov     r1,0h                                   
08030DA8 5E40     ldsh    r0,[r0,r1]                              
08030DAA 1830     add     r0,r6,r0                                
08030DAC E008     b       8030DC0h                                
08030DAE 0000     lsl     r0,r0,0h                                
08030DB0 0D04     lsr     r4,r0,14h                               
08030DB2 082B     lsr     r3,r5,20h                               
08030DB4 7FFF     ldrb    r7,[r7,1Fh]                             
08030DB6 0000     lsl     r0,r0,0h                                
08030DB8 1C48     add     r0,r1,1                                 
08030DBA 7018     strb    r0,[r3]                                 
08030DBC 8860     ldrh    r0,[r4,2h]                              
08030DBE 1880     add     r0,r0,r2                                
08030DC0 8060     strh    r0,[r4,2h]                              
08030DC2 8860     ldrh    r0,[r4,2h]                              
08030DC4 88A1     ldrh    r1,[r4,4h]                              
08030DC6 F7DEFB59 bl      800F47Ch                                
08030DCA 1C01     mov     r1,r0                                   
08030DCC 4804     ldr     r0,=30007F0h                            
08030DCE 7800     ldrb    r0,[r0]                                 
08030DD0 2800     cmp     r0,0h                                   
08030DD2 D007     beq     8030DE4h                                
08030DD4 8061     strh    r1,[r4,2h]                              
08030DD6 1C21     mov     r1,r4                                   
08030DD8 3124     add     r1,24h                                  
08030DDA 200E     mov     r0,0Eh                                  
08030DDC 7008     strb    r0,[r1]                                 
08030DDE E007     b       8030DF0h                                
08030DE0 07F0     lsl     r0,r6,1Fh                               
08030DE2 0300     lsl     r0,r0,0Ch                               
08030DE4 8861     ldrh    r1,[r4,2h]                              
08030DE6 88A2     ldrh    r2,[r4,4h]                              
08030DE8 1C30     mov     r0,r6                                   
08030DEA 2301     mov     r3,1h                                   
08030DEC F7E0FC94 bl      8011718h                                
08030DF0 BCF0     pop     r4-r7                                   
08030DF2 BC01     pop     r0                                      
08030DF4 4700     bx      r0                                      
08030DF6 0000     lsl     r0,r0,0h                                
08030DF8 B510     push    r4,r14                                  
08030DFA 8802     ldrh    r2,[r0]                                 
08030DFC 490A     ldr     r1,=0FE7Fh                              
08030DFE 4011     and     r1,r2                                   
08030E00 2400     mov     r4,0h                                   
08030E02 2300     mov     r3,0h                                   
08030E04 8001     strh    r1,[r0]                                 
08030E06 1C02     mov     r2,r0                                   
08030E08 3224     add     r2,24h                                  
08030E0A 2167     mov     r1,67h                                  
08030E0C 7011     strb    r1,[r2]                                 
08030E0E 4907     ldr     r1,=82E8598h                            
08030E10 6181     str     r1,[r0,18h]                             
08030E12 82C3     strh    r3,[r0,16h]                             
08030E14 7704     strb    r4,[r0,1Ch]                             
08030E16 4906     ldr     r1,=3000088h                            
08030E18 7B0A     ldrb    r2,[r1,0Ch]                             
08030E1A 2103     mov     r1,3h                                   
08030E1C 4011     and     r1,r2                                   
08030E1E 3021     add     r0,21h                                  
08030E20 7001     strb    r1,[r0]                                 
08030E22 BC10     pop     r4                                      
08030E24 BC01     pop     r0                                      
08030E26 4700     bx      r0                                      
08030E28 FE7F     bl      lr+0CFEh                                
08030E2A 0000     lsl     r0,r0,0h                                
08030E2C 8598     strh    r0,[r3,2Ch]                             
08030E2E 082E     lsr     r6,r5,20h                               
08030E30 0088     lsl     r0,r1,2h                                
08030E32 0300     lsl     r0,r0,0Ch                               
08030E34 B510     push    r4,r14                                  
08030E36 1C04     mov     r4,r0                                   
08030E38 1C21     mov     r1,r4                                   
08030E3A 3126     add     r1,26h                                  
08030E3C 2001     mov     r0,1h                                   
08030E3E 7008     strb    r0,[r1]                                 
08030E40 F7DEFEC2 bl      800FBC8h                                
08030E44 2800     cmp     r0,0h                                   
08030E46 D001     beq     8030E4Ch                                
08030E48 2000     mov     r0,0h                                   
08030E4A 8020     strh    r0,[r4]                                 
08030E4C BC10     pop     r4                                      
08030E4E BC01     pop     r0                                      
08030E50 4700     bx      r0                                      
08030E52 0000     lsl     r0,r0,0h                                
08030E54 B530     push    r4,r5,r14                               
08030E56 1C04     mov     r4,r0                                   
08030E58 1C21     mov     r1,r4                                   
08030E5A 3126     add     r1,26h                                  
08030E5C 2500     mov     r5,0h                                   
08030E5E 2001     mov     r0,1h                                   
08030E60 7008     strb    r0,[r1]                                 
08030E62 F7DEFEB1 bl      800FBC8h                                
08030E66 2800     cmp     r0,0h                                   
08030E68 D01D     beq     8030EA6h                                
08030E6A 8025     strh    r5,[r4]                                 
08030E6C 4A0F     ldr     r2,=30001ACh                            
08030E6E 1C20     mov     r0,r4                                   
08030E70 3023     add     r0,23h                                  
08030E72 7801     ldrb    r1,[r0]                                 
08030E74 00C8     lsl     r0,r1,3h                                
08030E76 1A40     sub     r0,r0,r1                                
08030E78 00C0     lsl     r0,r0,3h                                
08030E7A 1880     add     r0,r0,r2                                
08030E7C 8005     strh    r5,[r0]                                 
08030E7E 2003     mov     r0,3h                                   
08030E80 212D     mov     r1,2Dh                                  
08030E82 F02FFD1B bl      80608BCh                                
08030E86 2800     cmp     r0,0h                                   
08030E88 D10D     bne     8030EA6h                                
08030E8A 205E     mov     r0,5Eh                                  
08030E8C F7DFFC2C bl      80106E8h                                
08030E90 2800     cmp     r0,0h                                   
08030E92 D108     bne     8030EA6h                                
08030E94 2001     mov     r0,1h                                   
08030E96 212D     mov     r1,2Dh                                  
08030E98 F02FFD10 bl      80608BCh                                
08030E9C 4904     ldr     r1,=300007Bh                            
08030E9E 2214     mov     r2,14h                                  
08030EA0 4252     neg     r2,r2                                   
08030EA2 1C10     mov     r0,r2                                   
08030EA4 7008     strb    r0,[r1]                                 
08030EA6 BC30     pop     r4,r5                                   
08030EA8 BC01     pop     r0                                      
08030EAA 4700     bx      r0                                      
08030EAC 01AC     lsl     r4,r5,6h                                
08030EAE 0300     lsl     r0,r0,0Ch                               
08030EB0 007B     lsl     r3,r7,1h                                
08030EB2 0300     lsl     r0,r0,0Ch                               
08030EB4 B570     push    r4-r6,r14                               
08030EB6 1C03     mov     r3,r0                                   
08030EB8 1C19     mov     r1,r3                                   
08030EBA 3124     add     r1,24h                                  
08030EBC 2600     mov     r6,0h                                   
08030EBE 204D     mov     r0,4Dh                                  
08030EC0 7008     strb    r0,[r1]                                 
08030EC2 480F     ldr     r0,=82E84E0h                            
08030EC4 6198     str     r0,[r3,18h]                             
08030EC6 2100     mov     r1,0h                                   
08030EC8 82DE     strh    r6,[r3,16h]                             
08030ECA 7719     strb    r1,[r3,1Ch]                             
08030ECC 1C18     mov     r0,r3                                   
08030ECE 302C     add     r0,2Ch                                  
08030ED0 7001     strb    r1,[r0]                                 
08030ED2 3001     add     r0,1h                                   
08030ED4 7804     ldrb    r4,[r0]                                 
08030ED6 4A0B     ldr     r2,=30001ACh                            
08030ED8 00E1     lsl     r1,r4,3h                                
08030EDA 1B09     sub     r1,r1,r4                                
08030EDC 00C9     lsl     r1,r1,3h                                
08030EDE 1889     add     r1,r1,r2                                
08030EE0 8948     ldrh    r0,[r1,0Ah]                             
08030EE2 884D     ldrh    r5,[r1,2h]                              
08030EE4 1940     add     r0,r0,r5                                
08030EE6 0400     lsl     r0,r0,10h                               
08030EE8 0C05     lsr     r5,r0,10h                               
08030EEA 89C8     ldrh    r0,[r1,0Eh]                             
08030EEC 8889     ldrh    r1,[r1,4h]                              
08030EEE 1840     add     r0,r0,r1                                
08030EF0 0400     lsl     r0,r0,10h                               
08030EF2 0C01     lsr     r1,r0,10h                               
08030EF4 8858     ldrh    r0,[r3,2h]                              
08030EF6 42A8     cmp     r0,r5                                   
08030EF8 D206     bcs     8030F08h                                
08030EFA 80DE     strh    r6,[r3,6h]                              
08030EFC E006     b       8030F0Ch                                
08030EFE 0000     lsl     r0,r0,0h                                
08030F00 84E0     strh    r0,[r4,26h]                             
08030F02 082E     lsr     r6,r5,20h                               
08030F04 01AC     lsl     r4,r5,6h                                
08030F06 0300     lsl     r0,r0,0Ch                               
08030F08 1B40     sub     r0,r0,r5                                
08030F0A 80D8     strh    r0,[r3,6h]                              
08030F0C 8898     ldrh    r0,[r3,4h]                              
08030F0E 4288     cmp     r0,r1                                   
08030F10 D201     bcs     8030F16h                                
08030F12 2000     mov     r0,0h                                   
08030F14 E000     b       8030F18h                                
08030F16 1A40     sub     r0,r0,r1                                
08030F18 8118     strh    r0,[r3,8h]                              
08030F1A 8858     ldrh    r0,[r3,2h]                              
08030F1C 00E1     lsl     r1,r4,3h                                
08030F1E 1B09     sub     r1,r1,r4                                
08030F20 00C9     lsl     r1,r1,3h                                
08030F22 1889     add     r1,r1,r2                                
08030F24 8849     ldrh    r1,[r1,2h]                              
08030F26 3960     sub     r1,60h                                  
08030F28 4288     cmp     r0,r1                                   
08030F2A DD05     ble     8030F38h                                
08030F2C 8819     ldrh    r1,[r3]                                 
08030F2E 4801     ldr     r0,=0FEFFh                              
08030F30 4008     and     r0,r1                                   
08030F32 E006     b       8030F42h                                
08030F34 FEFF     bl      lr+0DFEh                                
08030F36 0000     lsl     r0,r0,0h                                
08030F38 8819     ldrh    r1,[r3]                                 
08030F3A 2280     mov     r2,80h                                  
08030F3C 0052     lsl     r2,r2,1h                                
08030F3E 1C10     mov     r0,r2                                   
08030F40 4308     orr     r0,r1                                   
08030F42 8018     strh    r0,[r3]                                 
08030F44 BC70     pop     r4-r6                                   
08030F46 BC01     pop     r0                                      
08030F48 4700     bx      r0                                      
08030F4A 0000     lsl     r0,r0,0h                                
08030F4C B5F0     push    r4-r7,r14                               
08030F4E 1C03     mov     r3,r0                                   
08030F50 302D     add     r0,2Dh                                  
08030F52 7806     ldrb    r6,[r0]                                 
08030F54 490F     ldr     r1,=30001ACh                            
08030F56 00F0     lsl     r0,r6,3h                                
08030F58 1B80     sub     r0,r0,r6                                
08030F5A 00C0     lsl     r0,r0,3h                                
08030F5C 1842     add     r2,r0,r1                                
08030F5E 1C10     mov     r0,r2                                   
08030F60 3024     add     r0,24h                                  
08030F62 7800     ldrb    r0,[r0]                                 
08030F64 468C     mov     r12,r1                                  
08030F66 2825     cmp     r0,25h                                  
08030F68 D11A     bne     8030FA0h                                
08030F6A 1C18     mov     r0,r3                                   
08030F6C 3024     add     r0,24h                                  
08030F6E 2144     mov     r1,44h                                  
08030F70 7001     strb    r1,[r0]                                 
08030F72 4809     ldr     r0,=300083Ch                            
08030F74 7800     ldrb    r0,[r0]                                 
08030F76 2805     cmp     r0,5h                                   
08030F78 D800     bhi     8030F7Ch                                
08030F7A 2006     mov     r0,6h                                   
08030F7C 1C19     mov     r1,r3                                   
08030F7E 312E     add     r1,2Eh                                  
08030F80 7008     strb    r0,[r1]                                 
08030F82 3909     sub     r1,9h                                   
08030F84 2017     mov     r0,17h                                  
08030F86 7008     strb    r0,[r1]                                 
08030F88 8819     ldrh    r1,[r3]                                 
08030F8A 4804     ldr     r0,=7FFFh                               
08030F8C 4008     and     r0,r1                                   
08030F8E 8018     strh    r0,[r3]                                 
08030F90 E0A7     b       80310E2h                                
08030F92 0000     lsl     r0,r0,0h                                
08030F94 01AC     lsl     r4,r5,6h                                
08030F96 0300     lsl     r0,r0,0Ch                               
08030F98 083C     lsr     r4,r7,20h                               
08030F9A 0300     lsl     r0,r0,0Ch                               
08030F9C 7FFF     ldrb    r7,[r7,1Fh]                             
08030F9E 0000     lsl     r0,r0,0h                                
08030FA0 490B     ldr     r1,=3000734h                            
08030FA2 7808     ldrb    r0,[r1]                                 
08030FA4 2800     cmp     r0,0h                                   
08030FA6 D101     bne     8030FACh                                
08030FA8 205A     mov     r0,5Ah                                  
08030FAA 7008     strb    r0,[r1]                                 
08030FAC 881D     ldrh    r5,[r3]                                 
08030FAE 2780     mov     r7,80h                                  
08030FB0 007F     lsl     r7,r7,1h                                
08030FB2 1C38     mov     r0,r7                                   
08030FB4 4028     and     r0,r5                                   
08030FB6 2800     cmp     r0,0h                                   
08030FB8 D00E     beq     8030FD8h                                
08030FBA 8851     ldrh    r1,[r2,2h]                              
08030FBC 8858     ldrh    r0,[r3,2h]                              
08030FBE 3008     add     r0,8h                                   
08030FC0 1C1C     mov     r4,r3                                   
08030FC2 342C     add     r4,2Ch                                  
08030FC4 4281     cmp     r1,r0                                   
08030FC6 DA17     bge     8030FF8h                                
08030FC8 4802     ldr     r0,=0FEFFh                              
08030FCA 4028     and     r0,r5                                   
08030FCC E010     b       8030FF0h                                
08030FCE 0000     lsl     r0,r0,0h                                
08030FD0 0734     lsl     r4,r6,1Ch                               
08030FD2 0300     lsl     r0,r0,0Ch                               
08030FD4 FEFF     bl      lr+0DFEh                                
08030FD6 0000     lsl     r0,r0,0h                                
08030FD8 200A     mov     r0,0Ah                                  
08030FDA 5E11     ldsh    r1,[r2,r0]                              
08030FDC 8852     ldrh    r2,[r2,2h]                              
08030FDE 1889     add     r1,r1,r2                                
08030FE0 8858     ldrh    r0,[r3,2h]                              
08030FE2 3808     sub     r0,8h                                   
08030FE4 1C1C     mov     r4,r3                                   
08030FE6 342C     add     r4,2Ch                                  
08030FE8 4281     cmp     r1,r0                                   
08030FEA DD05     ble     8030FF8h                                
08030FEC 1C38     mov     r0,r7                                   
08030FEE 4328     orr     r0,r5                                   
08030FF0 8018     strh    r0,[r3]                                 
08030FF2 480B     ldr     r0,=300083Ch                            
08030FF4 7800     ldrb    r0,[r0]                                 
08030FF6 7020     strb    r0,[r4]                                 
08030FF8 881D     ldrh    r5,[r3]                                 
08030FFA 2040     mov     r0,40h                                  
08030FFC 4028     and     r0,r5                                   
08030FFE 2800     cmp     r0,0h                                   
08031000 D012     beq     8031028h                                
08031002 00F2     lsl     r2,r6,3h                                
08031004 1B90     sub     r0,r2,r6                                
08031006 00C0     lsl     r0,r0,3h                                
08031008 4460     add     r0,r12                                  
0803100A 2710     mov     r7,10h                                  
0803100C 5FC1     ldsh    r1,[r0,r7]                              
0803100E 8880     ldrh    r0,[r0,4h]                              
08031010 1809     add     r1,r1,r0                                
08031012 8898     ldrh    r0,[r3,4h]                              
08031014 3008     add     r0,8h                                   
08031016 4281     cmp     r1,r0                                   
08031018 DA18     bge     803104Ch                                
0803101A 4802     ldr     r0,=0FFBFh                              
0803101C 4028     and     r0,r5                                   
0803101E E011     b       8031044h                                
08031020 083C     lsr     r4,r7,20h                               
08031022 0300     lsl     r0,r0,0Ch                               
08031024 FFBF     bl      lr+0F7Eh                                
08031026 0000     lsl     r0,r0,0h                                
08031028 00F2     lsl     r2,r6,3h                                
0803102A 1B90     sub     r0,r2,r6                                
0803102C 00C0     lsl     r0,r0,3h                                
0803102E 4460     add     r0,r12                                  
08031030 270E     mov     r7,0Eh                                  
08031032 5FC1     ldsh    r1,[r0,r7]                              
08031034 8880     ldrh    r0,[r0,4h]                              
08031036 1809     add     r1,r1,r0                                
08031038 8898     ldrh    r0,[r3,4h]                              
0803103A 3808     sub     r0,8h                                   
0803103C 4281     cmp     r1,r0                                   
0803103E DD05     ble     803104Ch                                
08031040 2040     mov     r0,40h                                  
08031042 4328     orr     r0,r5                                   
08031044 8018     strh    r0,[r3]                                 
08031046 480A     ldr     r0,=300083Ch                            
08031048 7800     ldrb    r0,[r0]                                 
0803104A 7020     strb    r0,[r4]                                 
0803104C 7820     ldrb    r0,[r4]                                 
0803104E 2800     cmp     r0,0h                                   
08031050 D132     bne     80310B8h                                
08031052 8819     ldrh    r1,[r3]                                 
08031054 2080     mov     r0,80h                                  
08031056 0040     lsl     r0,r0,1h                                
08031058 4008     and     r0,r1                                   
0803105A 1C0D     mov     r5,r1                                   
0803105C 2800     cmp     r0,0h                                   
0803105E D009     beq     8031074h                                
08031060 4803     ldr     r0,=300083Ch                            
08031062 7801     ldrb    r1,[r0]                                 
08031064 1C04     mov     r4,r0                                   
08031066 2900     cmp     r1,0h                                   
08031068 D00C     beq     8031084h                                
0803106A 88D8     ldrh    r0,[r3,6h]                              
0803106C 3001     add     r0,1h                                   
0803106E E008     b       8031082h                                
08031070 083C     lsr     r4,r7,20h                               
08031072 0300     lsl     r0,r0,0Ch                               
08031074 480A     ldr     r0,=300083Ch                            
08031076 7801     ldrb    r1,[r0]                                 
08031078 1C04     mov     r4,r0                                   
0803107A 2900     cmp     r1,0h                                   
0803107C D002     beq     8031084h                                
0803107E 88D8     ldrh    r0,[r3,6h]                              
08031080 3801     sub     r0,1h                                   
08031082 80D8     strh    r0,[r3,6h]                              
08031084 2040     mov     r0,40h                                  
08031086 4028     and     r0,r5                                   
08031088 2800     cmp     r0,0h                                   
0803108A D00B     beq     80310A4h                                
0803108C 1C19     mov     r1,r3                                   
0803108E 3123     add     r1,23h                                  
08031090 7820     ldrb    r0,[r4]                                 
08031092 7809     ldrb    r1,[r1]                                 
08031094 4288     cmp     r0,r1                                   
08031096 D011     beq     80310BCh                                
08031098 8918     ldrh    r0,[r3,8h]                              
0803109A 3001     add     r0,1h                                   
0803109C 8118     strh    r0,[r3,8h]                              
0803109E E00D     b       80310BCh                                
080310A0 083C     lsr     r4,r7,20h                               
080310A2 0300     lsl     r0,r0,0Ch                               
080310A4 1C19     mov     r1,r3                                   
080310A6 3123     add     r1,23h                                  
080310A8 7820     ldrb    r0,[r4]                                 
080310AA 7809     ldrb    r1,[r1]                                 
080310AC 4288     cmp     r0,r1                                   
080310AE D005     beq     80310BCh                                
080310B0 8918     ldrh    r0,[r3,8h]                              
080310B2 3801     sub     r0,1h                                   
080310B4 8118     strh    r0,[r3,8h]                              
080310B6 E001     b       80310BCh                                
080310B8 3801     sub     r0,1h                                   
080310BA 7020     strb    r0,[r4]                                 
080310BC 1B90     sub     r0,r2,r6                                
080310BE 00C0     lsl     r0,r0,3h                                
080310C0 4460     add     r0,r12                                  
080310C2 8941     ldrh    r1,[r0,0Ah]                             
080310C4 8842     ldrh    r2,[r0,2h]                              
080310C6 1889     add     r1,r1,r2                                
080310C8 0409     lsl     r1,r1,10h                               
080310CA 89C2     ldrh    r2,[r0,0Eh]                             
080310CC 8880     ldrh    r0,[r0,4h]                              
080310CE 1812     add     r2,r2,r0                                
080310D0 0412     lsl     r2,r2,10h                               
080310D2 0C09     lsr     r1,r1,10h                               
080310D4 88DF     ldrh    r7,[r3,6h]                              
080310D6 19C9     add     r1,r1,r7                                
080310D8 8059     strh    r1,[r3,2h]                              
080310DA 0C12     lsr     r2,r2,10h                               
080310DC 8918     ldrh    r0,[r3,8h]                              
080310DE 1812     add     r2,r2,r0                                
080310E0 809A     strh    r2,[r3,4h]                              
080310E2 BCF0     pop     r4-r7                                   
080310E4 BC01     pop     r0                                      
080310E6 4700     bx      r0                                      
080310E8 B5F0     push    r4-r7,r14                               
080310EA 4657     mov     r7,r10                                  
080310EC 464E     mov     r6,r9                                   
080310EE 4645     mov     r5,r8                                   
080310F0 B4E0     push    r5-r7                                   
080310F2 B086     add     sp,-18h                                 
080310F4 1C06     mov     r6,r0                                   
080310F6 302B     add     r0,2Bh                                  
080310F8 7801     ldrb    r1,[r0]                                 
080310FA 2080     mov     r0,80h                                  
080310FC 4008     and     r0,r1                                   
080310FE 2800     cmp     r0,0h                                   
08031100 D008     beq     8031114h                                
08031102 1C31     mov     r1,r6                                   
08031104 3124     add     r1,24h                                  
08031106 2062     mov     r0,62h                                  
08031108 7008     strb    r0,[r1]                                 
0803110A E06E     b       80311EAh                                
0803110C 1C78     add     r0,r7,1                                 
0803110E 0600     lsl     r0,r0,18h                               
08031110 0E07     lsr     r7,r0,18h                               
08031112 E04C     b       80311AEh                                
08031114 2700     mov     r7,0h                                   
08031116 8871     ldrh    r1,[r6,2h]                              
08031118 8970     ldrh    r0,[r6,0Ah]                             
0803111A 1808     add     r0,r1,r0                                
0803111C 0400     lsl     r0,r0,10h                               
0803111E 0C00     lsr     r0,r0,10h                               
08031120 9004     str     r0,[sp,10h]                             
08031122 89B0     ldrh    r0,[r6,0Ch]                             
08031124 1809     add     r1,r1,r0                                
08031126 0409     lsl     r1,r1,10h                               
08031128 0C09     lsr     r1,r1,10h                               
0803112A 9105     str     r1,[sp,14h]                             
0803112C 88B1     ldrh    r1,[r6,4h]                              
0803112E 89F0     ldrh    r0,[r6,0Eh]                             
08031130 1808     add     r0,r1,r0                                
08031132 0400     lsl     r0,r0,10h                               
08031134 0C00     lsr     r0,r0,10h                               
08031136 4681     mov     r9,r0                                   
08031138 8A30     ldrh    r0,[r6,10h]                             
0803113A 1809     add     r1,r1,r0                                
0803113C 0409     lsl     r1,r1,10h                               
0803113E 0C09     lsr     r1,r1,10h                               
08031140 4688     mov     r8,r1                                   
08031142 4D1E     ldr     r5,=3000A2Ch                            
08031144 21E0     mov     r1,0E0h                                 
08031146 0049     lsl     r1,r1,1h                                
08031148 1868     add     r0,r5,r1                                
0803114A 2124     mov     r1,24h                                  
0803114C 1989     add     r1,r1,r6                                
0803114E 468A     mov     r10,r1                                  
08031150 4285     cmp     r5,r0                                   
08031152 D22C     bcs     80311AEh                                
08031154 7828     ldrb    r0,[r5]                                 
08031156 2101     mov     r1,1h                                   
08031158 4008     and     r0,r1                                   
0803115A 2800     cmp     r0,0h                                   
0803115C D023     beq     80311A6h                                
0803115E 7BE8     ldrb    r0,[r5,0Fh]                             
08031160 280E     cmp     r0,0Eh                                  
08031162 D120     bne     80311A6h                                
08031164 7C68     ldrb    r0,[r5,11h]                             
08031166 2803     cmp     r0,3h                                   
08031168 D11D     bne     80311A6h                                
0803116A 892B     ldrh    r3,[r5,8h]                              
0803116C 8AAC     ldrh    r4,[r5,14h]                             
0803116E 191C     add     r4,r3,r4                                
08031170 0424     lsl     r4,r4,10h                               
08031172 0C24     lsr     r4,r4,10h                               
08031174 8AE8     ldrh    r0,[r5,16h]                             
08031176 181B     add     r3,r3,r0                                
08031178 041B     lsl     r3,r3,10h                               
0803117A 0C1B     lsr     r3,r3,10h                               
0803117C 896A     ldrh    r2,[r5,0Ah]                             
0803117E 8B29     ldrh    r1,[r5,18h]                             
08031180 1851     add     r1,r2,r1                                
08031182 0409     lsl     r1,r1,10h                               
08031184 0C09     lsr     r1,r1,10h                               
08031186 8B68     ldrh    r0,[r5,1Ah]                             
08031188 1812     add     r2,r2,r0                                
0803118A 0412     lsl     r2,r2,10h                               
0803118C 0C12     lsr     r2,r2,10h                               
0803118E 9400     str     r4,[sp]                                 
08031190 9301     str     r3,[sp,4h]                              
08031192 9102     str     r1,[sp,8h]                              
08031194 9203     str     r2,[sp,0Ch]                             
08031196 9804     ldr     r0,[sp,10h]                             
08031198 9905     ldr     r1,[sp,14h]                             
0803119A 464A     mov     r2,r9                                   
0803119C 4643     mov     r3,r8                                   
0803119E F7DDFAAB bl      800E6F8h                                
080311A2 2800     cmp     r0,0h                                   
080311A4 D1B2     bne     803110Ch                                
080311A6 351C     add     r5,1Ch                                  
080311A8 4805     ldr     r0,=3000BECh                            
080311AA 4285     cmp     r5,r0                                   
080311AC D3D2     bcc     8031154h                                
080311AE 2F00     cmp     r7,0h                                   
080311B0 D008     beq     80311C4h                                
080311B2 2062     mov     r0,62h                                  
080311B4 4651     mov     r1,r10                                  
080311B6 7008     strb    r0,[r1]                                 
080311B8 E017     b       80311EAh                                
080311BA 0000     lsl     r0,r0,0h                                
080311BC 0A2C     lsr     r4,r5,8h                                
080311BE 0300     lsl     r0,r0,0Ch                               
080311C0 0BEC     lsr     r4,r5,0Fh                               
080311C2 0300     lsl     r0,r0,0Ch                               
080311C4 1C30     mov     r0,r6                                   
080311C6 302B     add     r0,2Bh                                  
080311C8 7007     strb    r7,[r0]                                 
080311CA 2001     mov     r0,1h                                   
080311CC 82B0     strh    r0,[r6,14h]                             
080311CE 2044     mov     r0,44h                                  
080311D0 4651     mov     r1,r10                                  
080311D2 7008     strb    r0,[r1]                                 
080311D4 4809     ldr     r0,=300083Ch                            
080311D6 7800     ldrb    r0,[r0]                                 
080311D8 0847     lsr     r7,r0,1h                                
080311DA 2F08     cmp     r7,8h                                   
080311DC D800     bhi     80311E0h                                
080311DE 2709     mov     r7,9h                                   
080311E0 1C30     mov     r0,r6                                   
080311E2 302E     add     r0,2Eh                                  
080311E4 7007     strb    r7,[r0]                                 
080311E6 F7DEFBAD bl      800F944h                                
080311EA B006     add     sp,18h                                  
080311EC BC38     pop     r3-r5                                   
080311EE 4698     mov     r8,r3                                   
080311F0 46A1     mov     r9,r4                                   
080311F2 46AA     mov     r10,r5                                  
080311F4 BCF0     pop     r4-r7                                   
080311F6 BC01     pop     r0                                      
080311F8 4700     bx      r0                                      
080311FA 0000     lsl     r0,r0,0h                                
080311FC 083C     lsr     r4,r7,20h                               
080311FE 0300     lsl     r0,r0,0Ch                               
08031200 B510     push    r4,r14                                  
08031202 4C0D     ldr     r4,=3000738h                            
08031204 1C20     mov     r0,r4                                   
08031206 302B     add     r0,2Bh                                  
08031208 7801     ldrb    r1,[r0]                                 
0803120A 207F     mov     r0,7Fh                                  
0803120C 4008     and     r0,r1                                   
0803120E 2800     cmp     r0,0h                                   
08031210 D007     beq     8031222h                                
08031212 1C20     mov     r0,r4                                   
08031214 3024     add     r0,24h                                  
08031216 7800     ldrb    r0,[r0]                                 
08031218 2866     cmp     r0,66h                                  
0803121A D802     bhi     8031222h                                
0803121C 1C20     mov     r0,r4                                   
0803121E F7FFFF63 bl      80310E8h                                
08031222 1C20     mov     r0,r4                                   
08031224 3024     add     r0,24h                                  
08031226 7800     ldrb    r0,[r0]                                 
08031228 2867     cmp     r0,67h                                  
0803122A D900     bls     803122Eh                                
0803122C E11D     b       803146Ah                                
0803122E 0080     lsl     r0,r0,2h                                
08031230 4902     ldr     r1,=8031240h                            
08031232 1840     add     r0,r0,r1                                
08031234 6800     ldr     r0,[r0]                                 
08031236 4687     mov     r15,r0                                  
08031238 0738     lsl     r0,r7,1Ch                               
0803123A 0300     lsl     r0,r0,0Ch                               
0803123C 1240     asr     r0,r0,9h                                
0803123E 0803     lsr     r3,r0,20h                               
08031240 13E0     asr     r0,r4,0Fh                               
08031242 0803     lsr     r3,r0,20h                               
08031244 146A     asr     r2,r5,11h                               
08031246 0803     lsr     r3,r0,20h                               
08031248 146A     asr     r2,r5,11h                               
0803124A 0803     lsr     r3,r0,20h                               
0803124C 146A     asr     r2,r5,11h                               
0803124E 0803     lsr     r3,r0,20h                               
08031250 146A     asr     r2,r5,11h                               
08031252 0803     lsr     r3,r0,20h                               
08031254 146A     asr     r2,r5,11h                               
08031256 0803     lsr     r3,r0,20h                               
08031258 146A     asr     r2,r5,11h                               
0803125A 0803     lsr     r3,r0,20h                               
0803125C 146A     asr     r2,r5,11h                               
0803125E 0803     lsr     r3,r0,20h                               
08031260 13E8     asr     r0,r5,0Fh                               
08031262 0803     lsr     r3,r0,20h                               
08031264 13F0     asr     r0,r6,0Fh                               
08031266 0803     lsr     r3,r0,20h                               
08031268 13F8     asr     r0,r7,0Fh                               
0803126A 0803     lsr     r3,r0,20h                               
0803126C 13FE     asr     r6,r7,0Fh                               
0803126E 0803     lsr     r3,r0,20h                               
08031270 1406     asr     r6,r0,10h                               
08031272 0803     lsr     r3,r0,20h                               
08031274 146A     asr     r2,r5,11h                               
08031276 0803     lsr     r3,r0,20h                               
08031278 140E     asr     r6,r1,10h                               
0803127A 0803     lsr     r3,r0,20h                               
0803127C 1414     asr     r4,r2,10h                               
0803127E 0803     lsr     r3,r0,20h                               
08031280 146A     asr     r2,r5,11h                               
08031282 0803     lsr     r3,r0,20h                               
08031284 146A     asr     r2,r5,11h                               
08031286 0803     lsr     r3,r0,20h                               
08031288 146A     asr     r2,r5,11h                               
0803128A 0803     lsr     r3,r0,20h                               
0803128C 146A     asr     r2,r5,11h                               
0803128E 0803     lsr     r3,r0,20h                               
08031290 146A     asr     r2,r5,11h                               
08031292 0803     lsr     r3,r0,20h                               
08031294 146A     asr     r2,r5,11h                               
08031296 0803     lsr     r3,r0,20h                               
08031298 146A     asr     r2,r5,11h                               
0803129A 0803     lsr     r3,r0,20h                               
0803129C 146A     asr     r2,r5,11h                               
0803129E 0803     lsr     r3,r0,20h                               
080312A0 146A     asr     r2,r5,11h                               
080312A2 0803     lsr     r3,r0,20h                               
080312A4 146A     asr     r2,r5,11h                               
080312A6 0803     lsr     r3,r0,20h                               
080312A8 146A     asr     r2,r5,11h                               
080312AA 0803     lsr     r3,r0,20h                               
080312AC 146A     asr     r2,r5,11h                               
080312AE 0803     lsr     r3,r0,20h                               
080312B0 146A     asr     r2,r5,11h                               
080312B2 0803     lsr     r3,r0,20h                               
080312B4 146A     asr     r2,r5,11h                               
080312B6 0803     lsr     r3,r0,20h                               
080312B8 141C     asr     r4,r3,10h                               
080312BA 0803     lsr     r3,r0,20h                               
080312BC 1422     asr     r2,r4,10h                               
080312BE 0803     lsr     r3,r0,20h                               
080312C0 146A     asr     r2,r5,11h                               
080312C2 0803     lsr     r3,r0,20h                               
080312C4 146A     asr     r2,r5,11h                               
080312C6 0803     lsr     r3,r0,20h                               
080312C8 146A     asr     r2,r5,11h                               
080312CA 0803     lsr     r3,r0,20h                               
080312CC 146A     asr     r2,r5,11h                               
080312CE 0803     lsr     r3,r0,20h                               
080312D0 146A     asr     r2,r5,11h                               
080312D2 0803     lsr     r3,r0,20h                               
080312D4 146A     asr     r2,r5,11h                               
080312D6 0803     lsr     r3,r0,20h                               
080312D8 146A     asr     r2,r5,11h                               
080312DA 0803     lsr     r3,r0,20h                               
080312DC 146A     asr     r2,r5,11h                               
080312DE 0803     lsr     r3,r0,20h                               
080312E0 146A     asr     r2,r5,11h                               
080312E2 0803     lsr     r3,r0,20h                               
080312E4 146A     asr     r2,r5,11h                               
080312E6 0803     lsr     r3,r0,20h                               
080312E8 146A     asr     r2,r5,11h                               
080312EA 0803     lsr     r3,r0,20h                               
080312EC 146A     asr     r2,r5,11h                               
080312EE 0803     lsr     r3,r0,20h                               
080312F0 146A     asr     r2,r5,11h                               
080312F2 0803     lsr     r3,r0,20h                               
080312F4 146A     asr     r2,r5,11h                               
080312F6 0803     lsr     r3,r0,20h                               
080312F8 146A     asr     r2,r5,11h                               
080312FA 0803     lsr     r3,r0,20h                               
080312FC 146A     asr     r2,r5,11h                               
080312FE 0803     lsr     r3,r0,20h                               
08031300 146A     asr     r2,r5,11h                               
08031302 0803     lsr     r3,r0,20h                               
08031304 146A     asr     r2,r5,11h                               
08031306 0803     lsr     r3,r0,20h                               
08031308 146A     asr     r2,r5,11h                               
0803130A 0803     lsr     r3,r0,20h                               
0803130C 146A     asr     r2,r5,11h                               
0803130E 0803     lsr     r3,r0,20h                               
08031310 146A     asr     r2,r5,11h                               
08031312 0803     lsr     r3,r0,20h                               
08031314 146A     asr     r2,r5,11h                               
08031316 0803     lsr     r3,r0,20h                               
08031318 146A     asr     r2,r5,11h                               
0803131A 0803     lsr     r3,r0,20h                               
0803131C 146A     asr     r2,r5,11h                               
0803131E 0803     lsr     r3,r0,20h                               
08031320 146A     asr     r2,r5,11h                               
08031322 0803     lsr     r3,r0,20h                               
08031324 146A     asr     r2,r5,11h                               
08031326 0803     lsr     r3,r0,20h                               
08031328 146A     asr     r2,r5,11h                               
0803132A 0803     lsr     r3,r0,20h                               
0803132C 146A     asr     r2,r5,11h                               
0803132E 0803     lsr     r3,r0,20h                               
08031330 146A     asr     r2,r5,11h                               
08031332 0803     lsr     r3,r0,20h                               
08031334 146A     asr     r2,r5,11h                               
08031336 0803     lsr     r3,r0,20h                               
08031338 146A     asr     r2,r5,11h                               
0803133A 0803     lsr     r3,r0,20h                               
0803133C 146A     asr     r2,r5,11h                               
0803133E 0803     lsr     r3,r0,20h                               
08031340 146A     asr     r2,r5,11h                               
08031342 0803     lsr     r3,r0,20h                               
08031344 146A     asr     r2,r5,11h                               
08031346 0803     lsr     r3,r0,20h                               
08031348 142A     asr     r2,r5,10h                               
0803134A 0803     lsr     r3,r0,20h                               
0803134C 1430     asr     r0,r6,10h                               
0803134E 0803     lsr     r3,r0,20h                               
08031350 1438     asr     r0,r7,10h                               
08031352 0803     lsr     r3,r0,20h                               
08031354 143E     asr     r6,r7,10h                               
08031356 0803     lsr     r3,r0,20h                               
08031358 146A     asr     r2,r5,11h                               
0803135A 0803     lsr     r3,r0,20h                               
0803135C 1446     asr     r6,r0,11h                               
0803135E 0803     lsr     r3,r0,20h                               
08031360 146A     asr     r2,r5,11h                               
08031362 0803     lsr     r3,r0,20h                               
08031364 144E     asr     r6,r1,11h                               
08031366 0803     lsr     r3,r0,20h                               
08031368 146A     asr     r2,r5,11h                               
0803136A 0803     lsr     r3,r0,20h                               
0803136C 1456     asr     r6,r2,11h                               
0803136E 0803     lsr     r3,r0,20h                               
08031370 146A     asr     r2,r5,11h                               
08031372 0803     lsr     r3,r0,20h                               
08031374 146A     asr     r2,r5,11h                               
08031376 0803     lsr     r3,r0,20h                               
08031378 146A     asr     r2,r5,11h                               
0803137A 0803     lsr     r3,r0,20h                               
0803137C 146A     asr     r2,r5,11h                               
0803137E 0803     lsr     r3,r0,20h                               
08031380 146A     asr     r2,r5,11h                               
08031382 0803     lsr     r3,r0,20h                               
08031384 146A     asr     r2,r5,11h                               
08031386 0803     lsr     r3,r0,20h                               
08031388 146A     asr     r2,r5,11h                               
0803138A 0803     lsr     r3,r0,20h                               
0803138C 146A     asr     r2,r5,11h                               
0803138E 0803     lsr     r3,r0,20h                               
08031390 146A     asr     r2,r5,11h                               
08031392 0803     lsr     r3,r0,20h                               
08031394 146A     asr     r2,r5,11h                               
08031396 0803     lsr     r3,r0,20h                               
08031398 146A     asr     r2,r5,11h                               
0803139A 0803     lsr     r3,r0,20h                               
0803139C 146A     asr     r2,r5,11h                               
0803139E 0803     lsr     r3,r0,20h                               
080313A0 146A     asr     r2,r5,11h                               
080313A2 0803     lsr     r3,r0,20h                               
080313A4 146A     asr     r2,r5,11h                               
080313A6 0803     lsr     r3,r0,20h                               
080313A8 146A     asr     r2,r5,11h                               
080313AA 0803     lsr     r3,r0,20h                               
080313AC 146A     asr     r2,r5,11h                               
080313AE 0803     lsr     r3,r0,20h                               
080313B0 146A     asr     r2,r5,11h                               
080313B2 0803     lsr     r3,r0,20h                               
080313B4 146A     asr     r2,r5,11h                               
080313B6 0803     lsr     r3,r0,20h                               
080313B8 146A     asr     r2,r5,11h                               
080313BA 0803     lsr     r3,r0,20h                               
080313BC 146A     asr     r2,r5,11h                               
080313BE 0803     lsr     r3,r0,20h                               
080313C0 146A     asr     r2,r5,11h                               
080313C2 0803     lsr     r3,r0,20h                               
080313C4 146A     asr     r2,r5,11h                               
080313C6 0803     lsr     r3,r0,20h                               
080313C8 145E     asr     r6,r3,11h                               
080313CA 0803     lsr     r3,r0,20h                               
080313CC 146A     asr     r2,r5,11h                               
080313CE 0803     lsr     r3,r0,20h                               
080313D0 146A     asr     r2,r5,11h                               
080313D2 0803     lsr     r3,r0,20h                               
080313D4 146A     asr     r2,r5,11h                               
080313D6 0803     lsr     r3,r0,20h                               
080313D8 146A     asr     r2,r5,11h                               
080313DA 0803     lsr     r3,r0,20h                               
080313DC 1464     asr     r4,r4,11h                               
080313DE 0803     lsr     r3,r0,20h                               
080313E0 1C20     mov     r0,r4                                   
080313E2 F7FEFDAF bl      802FF44h                                
080313E6 E040     b       803146Ah                                
080313E8 1C20     mov     r0,r4                                   
080313EA F7FFFA6F bl      80308CCh                                
080313EE E03C     b       803146Ah                                
080313F0 1C20     mov     r0,r4                                   
080313F2 F7FFFB5F bl      8030AB4h                                
080313F6 E038     b       803146Ah                                
080313F8 1C20     mov     r0,r4                                   
080313FA F7FFFC2D bl      8030C58h                                
080313FE 1C20     mov     r0,r4                                   
08031400 F7FFFC38 bl      8030C74h                                
08031404 E031     b       803146Ah                                
08031406 1C20     mov     r0,r4                                   
08031408 F7FFFC46 bl      8030C98h                                
0803140C E02D     b       803146Ah                                
0803140E 1C20     mov     r0,r4                                   
08031410 F7FFFC50 bl      8030CB4h                                
08031414 1C20     mov     r0,r4                                   
08031416 F7FFFC5D bl      8030CD4h                                
0803141A E026     b       803146Ah                                
0803141C 1C20     mov     r0,r4                                   
0803141E F7FFFCA9 bl      8030D74h                                
08031422 1C20     mov     r0,r4                                   
08031424 F7FFFCAE bl      8030D84h                                
08031428 E01F     b       803146Ah                                
0803142A 1C20     mov     r0,r4                                   
0803142C F7FEFE20 bl      8030070h                                
08031430 1C20     mov     r0,r4                                   
08031432 F7FEFE65 bl      8030100h                                
08031436 E018     b       803146Ah                                
08031438 1C20     mov     r0,r4                                   
0803143A F7FEFF29 bl      8030290h                                
0803143E 1C20     mov     r0,r4                                   
08031440 F7FEFF8E bl      8030360h                                
08031444 E011     b       803146Ah                                
08031446 1C20     mov     r0,r4                                   
08031448 F7FFF852 bl      80304F0h                                
0803144C E00D     b       803146Ah                                
0803144E 1C20     mov     r0,r4                                   
08031450 F7FFF918 bl      8030684h                                
08031454 E009     b       803146Ah                                
08031456 1C20     mov     r0,r4                                   
08031458 F7FFF9D8 bl      803080Ch                                
0803145C E005     b       803146Ah                                
0803145E 1C20     mov     r0,r4                                   
08031460 F7FFFCCA bl      8030DF8h                                
08031464 1C20     mov     r0,r4                                   
08031466 F7FFFCF5 bl      8030E54h                                
0803146A 8821     ldrh    r1,[r4]                                 
0803146C 4802     ldr     r0,=0F7FFh                              
0803146E 4008     and     r0,r1                                   
08031470 8020     strh    r0,[r4]                                 
08031472 BC10     pop     r4                                      
08031474 BC01     pop     r0                                      
08031476 4700     bx      r0                                      
08031478 F7FF     ????                                            
0803147A 0000     lsl     r0,r0,0h                                
0803147C B510     push    r4,r14                                  
0803147E 4C0D     ldr     r4,=3000738h                            
08031480 1C20     mov     r0,r4                                   
08031482 302B     add     r0,2Bh                                  
08031484 7801     ldrb    r1,[r0]                                 
08031486 207F     mov     r0,7Fh                                  
08031488 4008     and     r0,r1                                   
0803148A 2800     cmp     r0,0h                                   
0803148C D007     beq     803149Eh                                
0803148E 1C20     mov     r0,r4                                   
08031490 3024     add     r0,24h                                  
08031492 7800     ldrb    r0,[r0]                                 
08031494 2866     cmp     r0,66h                                  
08031496 D802     bhi     803149Eh                                
08031498 1C20     mov     r0,r4                                   
0803149A F7FFFE25 bl      80310E8h                                
0803149E 1C20     mov     r0,r4                                   
080314A0 3024     add     r0,24h                                  
080314A2 7800     ldrb    r0,[r0]                                 
080314A4 2867     cmp     r0,67h                                  
080314A6 D900     bls     80314AAh                                
080314A8 E124     b       80316F4h                                
080314AA 0080     lsl     r0,r0,2h                                
080314AC 4902     ldr     r1,=80314BCh                            
080314AE 1840     add     r0,r0,r1                                
080314B0 6800     ldr     r0,[r0]                                 
080314B2 4687     mov     r15,r0                                  
080314B4 0738     lsl     r0,r7,1Ch                               
080314B6 0300     lsl     r0,r0,0Ch                               
080314B8 14BC     asr     r4,r7,12h                               
080314BA 0803     lsr     r3,r0,20h                               
080314BC 165C     asr     r4,r3,19h                               
080314BE 0803     lsr     r3,r0,20h                               
080314C0 16F4     asr     r4,r6,1Bh                               
080314C2 0803     lsr     r3,r0,20h                               
080314C4 16F4     asr     r4,r6,1Bh                               
080314C6 0803     lsr     r3,r0,20h                               
080314C8 16F4     asr     r4,r6,1Bh                               
080314CA 0803     lsr     r3,r0,20h                               
080314CC 16F4     asr     r4,r6,1Bh                               
080314CE 0803     lsr     r3,r0,20h                               
080314D0 16F4     asr     r4,r6,1Bh                               
080314D2 0803     lsr     r3,r0,20h                               
080314D4 16F4     asr     r4,r6,1Bh                               
080314D6 0803     lsr     r3,r0,20h                               
080314D8 16F4     asr     r4,r6,1Bh                               
080314DA 0803     lsr     r3,r0,20h                               
080314DC 1664     asr     r4,r4,19h                               
080314DE 0803     lsr     r3,r0,20h                               
080314E0 166A     asr     r2,r5,19h                               
080314E2 0803     lsr     r3,r0,20h                               
080314E4 1672     asr     r2,r6,19h                               
080314E6 0803     lsr     r3,r0,20h                               
080314E8 1678     asr     r0,r7,19h                               
080314EA 0803     lsr     r3,r0,20h                               
080314EC 1680     asr     r0,r0,1Ah                               
080314EE 0803     lsr     r3,r0,20h                               
080314F0 16F4     asr     r4,r6,1Bh                               
080314F2 0803     lsr     r3,r0,20h                               
080314F4 1688     asr     r0,r1,1Ah                               
080314F6 0803     lsr     r3,r0,20h                               
080314F8 168E     asr     r6,r1,1Ah                               
080314FA 0803     lsr     r3,r0,20h                               
080314FC 16F4     asr     r4,r6,1Bh                               
080314FE 0803     lsr     r3,r0,20h                               
08031500 16F4     asr     r4,r6,1Bh                               
08031502 0803     lsr     r3,r0,20h                               
08031504 16F4     asr     r4,r6,1Bh                               
08031506 0803     lsr     r3,r0,20h                               
08031508 16F4     asr     r4,r6,1Bh                               
0803150A 0803     lsr     r3,r0,20h                               
0803150C 16F4     asr     r4,r6,1Bh                               
0803150E 0803     lsr     r3,r0,20h                               
08031510 16F4     asr     r4,r6,1Bh                               
08031512 0803     lsr     r3,r0,20h                               
08031514 16F4     asr     r4,r6,1Bh                               
08031516 0803     lsr     r3,r0,20h                               

