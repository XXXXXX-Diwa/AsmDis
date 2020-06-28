
.definelabel playsound,8002B20h
.definelabel frozen,800FFE8h
.definelabel nofrozen,0801CB28
.definelabel stunsprite,8011280h 
.definelabel posetable,801CB4Ch
.definelabel thend,801CC68h
.definelabel otherpose,801CC54h
.definelabel spritedeath,8011084h
.definelabel PrimarySpriteStats,82B0D68h
.definelabel checkanimationend,800FC00h
.definelabel playsound2,8002a18h
.definelabel checkfloor,800F47Ch
.definelabel Gopose37,801c88ch
.definelabel PrimeSpeedTable,82CCA7Ch
.definelabel checkcilp,800F688h
.definelabel gravelanimation,8011E48h
.definelabel deathanimation,80540ECh
.definelabel spawnsecsprite,800E258h
.definelabel checkanimationend2,800fbc8h


.org 801c644h                      ;默认第一次经历的pose例程,仅经历一次
0801C644 4B10     ldr     r3,=3000738h                            
0801C646 1C19     mov     r1,r3                                   
0801C648 3125     add     r1,25h                                  
0801C64A 2200     mov     r2,0h                                   
0801C64C 2004     mov     r0,4h                                   
0801C64E 7008     strb    r0,[r1]        ;属性写入4                             
0801C650 1C18     mov     r0,r3                                   
0801C652 3027     add     r0,27h                                  
0801C654 7002     strb    r2,[r0]        ;300075f写入0                         
0801C656 3103     add     r1,3h                                   
0801C658 2020     mov     r0,20h                                  
0801C65A 7008     strb    r0,[r1]        ;3000760写入20h                         
0801C65C 3101     add     r1,1h                                   
0801C65E 2010     mov     r0,10h                                  
0801C660 7008     strb    r0,[r1]        ;3000761写入10h                         
0801C662 815A     strh    r2,[r3,0Ah]    ;顶部分界写入0                         
0801C664 2060     mov     r0,60h                                  
0801C666 8198     strh    r0,[r3,0Ch]    ;下部分界写入60h                         
0801C668 4808     ldr     r0,=0FFE8h                              
0801C66A 81D8     strh    r0,[r3,0Eh]    ;左部分界写入0ffe8h                        
0801C66C 2018     mov     r0,18h                                  
0801C66E 8218     strh    r0,[r3,10h]    ;右部分界写入18h                         
0801C670 4A07     ldr     r2,=PrimarySpriteStats                            
0801C672 7F59     ldrb    r1,[r3,1Dh]    ;获取ID                         
0801C674 00C8     lsl     r0,r1,3h                                
0801C676 1840     add     r0,r0,r1                                
0801C678 0040     lsl     r0,r0,1h       ;乘以18倍                         
0801C67A 1880     add     r0,r0,r2       ;偏移地址                         
0801C67C 8800     ldrh    r0,[r0]        ;读取HP                         
0801C67E 8298     strh    r0,[r3,14h]    ;写入sprite HP                         
0801C680 8858     ldrh    r0,[r3,2h]     ;读取Y坐标                         
0801C682 3840     sub     r0,40h         ;上升一格再次写入                       
0801C684 8058     strh    r0,[r3,2h]                              
0801C686 4770     bx      r14   
.pool
                                  
.org 801c694h                     ;pose 8h 0 pose后就会紧接着执行       
0801C694 4904     ldr     r1,=3000738h                            
0801C696 4805     ldr     r0,=82CD474h                            
0801C698 6188     str     r0,[r1,18h]     ;写入新图片                           
0801C69A 2000     mov     r0,0h                                   
0801C69C 7708     strb    r0,[r1,1Ch]                             
0801C69E 82C8     strh    r0,[r1,16h]     ;动画帧和计数归零                        
0801C6A0 3124     add     r1,24h                                  
0801C6A2 2009     mov     r0,9h                                   
0801C6A4 7008     strb    r0,[r1]         ;pose 写入9                        
0801C6A6 4770     bx      r14 
.pool
                                    
.org 801c6b0h
0801C6B0 B500     push    r14              ;pose 8 后紧接着就会执行                       
0801C6B2 4A10     ldr     r2,=30013D4h                            
0801C6B4 4B10     ldr     r3,=3000738h                            
0801C6B6 8A90     ldrh    r0,[r2,14h]      ;获取Y坐标                       
0801C6B8 8859     ldrh    r1,[r3,2h]       ;获取sprite Y坐标                       
0801C6BA 4288     cmp     r0,r1            ;如果Y坐标小于 sprite Y坐标则跳转                       
0801C6BC D917     bls     @@end                                
0801C6BE 8859     ldrh    r1,[r3,2h]       ; Y坐标大于 sprite Y坐标的情况下                     
0801C6C0 1A40     sub     r0,r0,r1         ; Y坐标减去sprite Y坐标                    
0801C6C2 490E     ldr     r1,=283h                                
0801C6C4 4288     cmp     r0,r1            ;这个值大于283h则跳转                       
0801C6C6 DC12     bgt     @@end                                
0801C6C8 8819     ldrh    r1,[r3]          ;2与取向 and                     
0801C6CA 2002     mov     r0,2h                                   
0801C6CC 4008     and     r0,r1                                   
0801C6CE 2800     cmp     r0,0h            ;结果为0跳转                       
0801C6D0 D00D     beq     @@end                                
0801C6D2 8A52     ldrh    r2,[r2,12h]      ;获取X坐标                       
0801C6D4 8899     ldrh    r1,[r3,4h]       ;获取精灵 X坐标                       
0801C6D6 1C08     mov     r0,r1                                   
0801C6D8 3896     sub     r0,96h           ;精灵 X坐标左移96h                       
0801C6DA 4282     cmp     r2,r0            ;X坐标比此值左则跳转  <=                     
0801C6DC DD07     ble     @@end                                
0801C6DE 1C08     mov     r0,r1                                   
0801C6E0 3096     add     r0,96h           ;精灵 X坐标右移96h                       
0801C6E2 4282     cmp     r2,r0            ;X坐标比此值右则跳转  >=                     
0801C6E4 DA03     bge     @@end                                
0801C6E6 1C19     mov     r1,r3                                   
0801C6E8 3124     add     r1,24h                                  
0801C6EA 2022     mov     r0,22h           ;pose写入22h                       
0801C6EC 7008     strb    r0,[r1]
@@end:                                 
0801C6EE BC01     pop     r0                                      
0801C6F0 4700     bx      r0 
.pool
                                     
.org 801c700h                             ;pose 22h  将要坠落
0801C700 4904     ldr     r1,=3000738h                            
0801C702 4805     ldr     r0,=82CD49Ch                            
0801C704 6188     str     r0,[r1,18h]     ;写入新OAM                        
0801C706 2000     mov     r0,0h                                   
0801C708 7708     strb    r0,[r1,1Ch]                             
0801C70A 82C8     strh    r0,[r1,16h]     ;动画帧和计数归零                        
0801C70C 3124     add     r1,24h                                  
0801C70E 2023     mov     r0,23h          ;pose 写入23h                        
0801C710 7008     strb    r0,[r1]                                 
0801C712 4770     bx      r14                                     
.pool

.org 801c71ch                             ;pose 23h 检查动画帧
0801C71C B500     push    r14                                     
0801C71E F7F3FA6F bl      checkanimationend      ;检查动画帧是否结束                        
0801C722 2800     cmp     r0,0h                                   
0801C724 D003     beq     @@end                  ;没结束的话跳过              
0801C726 4803     ldr     r0,=3000738h                            
0801C728 3024     add     r0,24h                 ;写入pose 34h                 
0801C72A 2134     mov     r1,34h                                  
0801C72C 7001     strb    r1,[r0]
@@end:                                 
0801C72E BC01     pop     r0                                      
0801C730 4700     bx      r0                                      
.pool

.org 801c738h                              ;pose 34h
0801C738 B500     push    r14                                     
0801C73A 4A0C     ldr     r2,=3000738h                            
0801C73C 480C     ldr     r0,=82CD4CCh                            
0801C73E 6190     str     r0,[r2,18h]      ;写入新OAM                       
0801C740 2000     mov     r0,0h                                   
0801C742 7710     strb    r0,[r2,1Ch]                             
0801C744 2300     mov     r3,0h                                   
0801C746 82D0     strh    r0,[r2,16h]      ;动画帧和计数归零                          
0801C748 1C10     mov     r0,r2                                   
0801C74A 302F     add     r0,2Fh                                  
0801C74C 7003     strb    r3,[r0]          ;3000767写入0                       
0801C74E 3801     sub     r0,1h                                   
0801C750 7003     strb    r3,[r0]          ;3000766写入0                       
0801C752 1C11     mov     r1,r2                                   
0801C754 3124     add     r1,24h                                  
0801C756 2035     mov     r0,35h                                  
0801C758 7008     strb    r0,[r1]          ;pose 写入35h                       
0801C75A 4906     ldr     r1,=30013D4h                            
0801C75C 8890     ldrh    r0,[r2,4h]       ;X坐标                       
0801C75E 8A49     ldrh    r1,[r1,12h]      ;精灵 X坐标                       
0801C760 4288     cmp     r0,r1            ;小于或等于的话则跳转                      
0801C762 D90B     bls     @@moreleft                                
0801C764 8811     ldrh    r1,[r2]                                 
0801C766 4804     ldr     r0,=0FDFFh                              
0801C768 4008     and     r0,r1            ;0FDFFh AND 0203 来改变取向                       
0801C76A E00C     b       @@moreright                                
 
@@moreleft:                                ;801c77ch
0801C77C 8810     ldrh    r0,[r2]          ;读取取向                    
0801C77E 2380     mov     r3,80h                                  
0801C780 009B     lsl     r3,r3,2h         ;得到200h                       
0801C782 1C19     mov     r1,r3                                   
0801C784 4308     orr     r0,r1            ;0003h orr 200h 来换向
@@moreright:                               ;801c786h 
0801C786 8010     strh    r0,[r2]          ;重新写入取向   反转                   
0801C788 8811     ldrh    r1,[r2]                                 
0801C78A 2002     mov     r0,2h                                   
0801C78C 4008     and     r0,r1            ;除非0000,否则都成立                     
0801C78E 2800     cmp     r0,0h                                  
0801C790 D002     beq     @@nosound                                
0801C792 4802     ldr     r0,=141h         ;坠落声                       
0801C794 F7E6F940 bl      playsound2 
@@nosound:                        ;801C798h   
0801C798 BC01     pop     r0                                      
0801C79A 4700     bx      r0                                      
.pool
 
.org 801c7a0h                              ;pose 35h
0801C7A0 B570     push    r4-r6,r14                               
0801C7A2 4C11     ldr     r4,=3000738h                            
0801C7A4 210C     mov     r1,0Ch                                  
0801C7A6 5E60     ldsh    r0,[r4,r1]       ;下部分界                       
0801C7A8 8866     ldrh    r6,[r4,2h]       ;精灵 Y坐标                       
0801C7AA 1980     add     r0,r0,r6         ;两者相加                       
0801C7AC 88A1     ldrh    r1,[r4,4h]       ;精灵 X坐标                      
0801C7AE F7F2FE65 bl      checkfloor       ;检查下部分界碰触地面                                
0801C7B2 1C01     mov     r1,r0                                   
0801C7B4 480D     ldr     r0,=30007F0h                            
0801C7B6 7800     ldrb    r0,[r0]          ;得到30007f0的值                       
0801C7B8 2800     cmp     r0,0h            ;为0则没有碰触                       
0801C7BA D019     beq     @@inair                                
0801C7BC 89A0     ldrh    r0,[r4,0Ch]      ;读取下部分界                       
0801C7BE 1A08     sub     r0,r1,r0         ;减去相加得到的坐标                       
0801C7C0 2200     mov     r2,0h                                   
0801C7C2 8060     strh    r0,[r4,2h]       ;重写入,返回原值                       
0801C7C4 1C21     mov     r1,r4                                   
0801C7C6 3124     add     r1,24h                                  
0801C7C8 2037     mov     r0,37h                                  
0801C7CA 7008     strb    r0,[r1]          ;pose 写入37h                       
0801C7CC 1C20     mov     r0,r4                                   
0801C7CE 302C     add     r0,2Ch                                  
0801C7D0 7002     strb    r2,[r0]          ;3000764写入0                       
0801C7D2 8821     ldrh    r1,[r4]                                 
0801C7D4 2002     mov     r0,2h                                   
0801C7D6 4008     and     r0,r1            ;再一次2 and 取向                       
0801C7D8 2800     cmp     r0,0h                                   
0801C7DA D057     beq     Gopose37         ;除非0000h,否则都成立 确认未死                      
0801C7DC 20A1     mov     r0,0A1h                                 
0801C7DE 0040     lsl     r0,r0,1h         ;触地声                       
0801C7E0 F7E6F91A bl      playsound2                                
0801C7E4 E052     b       Gopose37                              

@@inair:                               
0801C7F0 1C20     mov     r0,r4                                   
0801C7F2 302E     add     r0,2Eh                                  
0801C7F4 7800     ldrb    r0,[r0]         ;读取3000766的值                        
0801C7F6 0885     lsr     r5,r0,2h        ;除以4                        
0801C7F8 202F     mov     r0,2Fh                                  
0801C7FA 1900     add     r0,r0,r4                                
0801C7FC 4684     mov     r12,r0                                  
0801C7FE 7801     ldrb    r1,[r0]         ;读取3000767的值                        
0801C800 4B07     ldr     r3,=PrimeSpeedTable                            
0801C802 0048     lsl     r0,r1,1h        ;乘以2                        
0801C804 18C0     add     r0,r0,r3                                
0801C806 2600     mov     r6,0h                                   
0801C808 5F82     ldsh    r2,[r0,r6]      ;得到偏移地址的值                        
0801C80A 4806     ldr     r0,=7FFFh                               
0801C80C 4282     cmp     r2,r0           ;比较是否是7fffh                        
0801C80E D10B     bne     @@PrimeSpeed ;不是的话跳转                        
0801C810 1E48     sub     r0,r1,1         ;3000767取出的值减1                        
0801C812 0040     lsl     r0,r0,1h        ;乘以2                        
0801C814 18C0     add     r0,r0,r3        ;加上偏移值                        
0801C816 2100     mov     r1,0h                                   
0801C818 5E40     ldsh    r0,[r0,r1]      ;得到地址的值                        
0801C81A 8866     ldrh    r6,[r4,2h]      ;读取精灵 Y坐标                        
0801C81C 1980     add     r0,r0,r6        ;两者相加                        
0801C81E E008     b       @@MaxSpeed 
                               
@@PrimeSpeed:                           ;801c828h    
0801C828 1C48     add     r0,r1,1         ;3000767取出的值加1                        
0801C82A 4661     mov     r1,r12                                  
0801C82C 7008     strb    r0,[r1]         ;重新写入                        
0801C82E 8860     ldrh    r0,[r4,2h]      ;读取精灵 Y坐标                        
0801C830 1880     add     r0,r0,r2        ;加上偏移地址取出的值

@@MaxSpeed:                               ;801c832h
0801C832 8060     strh    r0,[r4,2h]      ;重新写入 Y坐标                        
0801C834 4C09     ldr     r4,=3000738h                            
0801C836 8821     ldrh    r1,[r4]                                 
0801C838 2080     mov     r0,80h                                  
0801C83A 0080     lsl     r0,r0,2h                                
0801C83C 4008     and     r0,r1           ;200h and 取向                        
0801C83E 2800     cmp     r0,0h           ;在精灵左边才会为0                        
0801C840 D010     beq     @@atleft                                
0801C842 8860     ldrh    r0,[r4,2h]                             
0801C842 8860     ldrh    r0,[r4,2h]                              
0801C844 3040     add     r0,40h                                  
0801C846 88A1     ldrh    r1,[r4,4h]      ;Y坐标的值加40h                        
0801C848 3120     add     r1,20h          ;X坐标的值加20h                        
0801C84A F7F2FF1D bl      checkcilp       ;检查是否会碰到砖块                         
0801C84E 4804     ldr     r0,=30007F1h                            
0801C850 7800     ldrb    r0,[r0]                                 
0801C852 2811     cmp     r0,11h          ;如果是11的话则碰撞                        
0801C854 D01A     beq     Gopose37                               
0801C856 88A0     ldrh    r0,[r4,4h]      ;读取X 坐标                        
0801C858 1940     add     r0,r0,r5        ;加上3000766的值的1/4                        
0801C85A E00F     b       SpeedSet                                

@@atleft:                          ;801c864h
0801C864 8860     ldrh    r0,[r4,2h]                              
0801C866 3040     add     r0,40h          ;Y坐标的值下移一格                        
0801C868 88A1     ldrh    r1,[r4,4h]                              
0801C86A 3920     sub     r1,20h          ;X坐标的值左移半格                        
0801C86C F7F2FF0C bl      checkcilp       ;检查是否碰到砖块                         
0801C870 4808     ldr     r0,=30007F1h                            
0801C872 7800     ldrb    r0,[r0]                                 
0801C874 2811     cmp     r0,11h          ;等于11的话碰撞                       
0801C876 D009     beq     Gopose37                                
0801C878 88A0     ldrh    r0,[r4,4h]      ;读取X 坐标的值                        
0801C87A 1B40     sub     r0,r0,r5        ;向左移3000766的值1/4
@@SpeedSet:                        ;801c87ch     
0801C87C 80A0     strh    r0,[r4,4h]      ;写入X 位移                        
0801C87E 2D0F     cmp     r5,0Fh          ;比较3000766的值1/4                        
0801C880 D804     bhi     801C88Ch        ;大于F则跳转                        
0801C882 4905     ldr     r1,=3000738h                            
0801C884 312E     add     r1,2Eh                                  
0801C886 7808     ldrb    r0,[r1]                                
0801C888 3001     add     r0,1h                                   
0801C88A 7008     strb    r0,[r1]         ;3000766的值加1
.org Gopose37                                 
0801C88C BC70     pop     r4-r6                                   
0801C88E BC01     pop     r0                                      
0801C890 4700     bx      r0                                      
.pool

.org 801c89ch                             ;pose 37h 落地后 
0801C89C B5F0     push    r4-r7,r14                               
0801C89E 4657     mov     r7,r10                                  
0801C8A0 464E     mov     r6,r9                                   
0801C8A2 4645     mov     r5,r8                                   
0801C8A4 B4E0     push    r5-r7                                   
0801C8A6 B083     add     sp,-0Ch                                 
0801C8A8 4E07     ldr     r6,=3000738h                            
0801C8AA 8877     ldrh    r7,[r6,2h]      ;精灵 Y坐标                        
0801C8AC 88B5     ldrh    r5,[r6,4h]      ;精灵 X坐标                        
0801C8AE 1C31     mov     r1,r6                                   
0801C8B0 312C     add     r1,2Ch                                  
0801C8B2 7808     ldrb    r0,[r1]                                 
0801C8B4 3001     add     r0,1h                                   
0801C8B6 7008     strb    r0,[r1]         ;3000764的值加1,用于记录落地后的帧数                      
0801C8B8 7808     ldrb    r0,[r1]                                 
0801C8BA 2828     cmp     r0,28h          ;3000764的值等于28h                        
0801C8BC D02C     beq     @@equal_28      ;跳转                        
0801C8BE 2828     cmp     r0,28h          ;大于28h                        
0801C8C0 DC04     bgt     @@morethan28    ;跳转                        
0801C8C2 2801     cmp     r0,1h           ;等于1                        
0801C8C4 D005     beq     @@equal_1       ;跳转                        
0801C8C6 E074     b       @@end                                
.pool

@@morethan28:                               
0801C8CC 283C     cmp     r0,3Ch          ;3000764的值等于3c                        
0801C8CE D029     beq     @@equal_3c      ;跳转                          
0801C8D0 E06F     b       @@end 
@@equal_1:                               
0801C8D2 1C38     mov     r0,r7                                   
0801C8D4 3048     add     r0,48h          ;Y坐标值加48h                        
0801C8D6 0400     lsl     r0,r0,10h                               
0801C8D8 0C07     lsr     r7,r0,10h                               
0801C8DA 1C3A     mov     r2,r7                                   
0801C8DC 3A10     sub     r2,10h          ;再减10h                        
0801C8DE 2000     mov     r0,0h                                   
0801C8E0 2111     mov     r1,11h                                  
0801C8E2 1C2B     mov     r3,r5           ;r0=0,r1=11h,r2=Y+38h,r3=X                        
0801C8E4 F7F5FAB0 bl      gravelanimation ;返回后 r7=Y+38h,r5=X  碎石动画                            
0801C8E8 1C2B     mov     r3,r5                                   
0801C8EA 330C     add     r3,0Ch          ;X坐标值加Ch                        
0801C8EC 2000     mov     r0,0h                                   
0801C8EE 2112     mov     r1,12h                                  
0801C8F0 1C3A     mov     r2,r7                                   
0801C8F2 F7F5FAA9 bl      gravelanimation                                
0801C8F6 1C3A     mov     r2,r7                                   
0801C8F8 3A2A     sub     r2,2Ah          ;Y坐标值+48h-2ah                        
0801C8FA 1C2B     mov     r3,r5                                   
0801C8FC 3314     add     r3,14h          ;X坐标值加14h                        
0801C8FE 2000     mov     r0,0h                                   
0801C900 2113     mov     r1,13h                                  
0801C902 F7F5FAA1 bl      gravelanimation                                
0801C906 1C3A     mov     r2,r7                                   
0801C908 3A18     sub     r2,18h                                  
0801C90A 1C2B     mov     r3,r5                                   
0801C90C 3B1E     sub     r3,1Eh                                  
0801C90E 2000     mov     r0,0h                                   
0801C910 2104     mov     r1,4h                                   
0801C912 F7F5FA99 bl      gravelanimation ;总共四个碎石                              
0801C916 E04C     b       @@end
@@equal_28:                                
0801C918 4801     ldr     r0,=82CD4F4h   ;写入新OAM 旋转速度加快一倍                        
0801C91A 61B0     str     r0,[r6,18h]                             
0801C91C E049     b       @@end                                
@@equal_3c:                              ;爆炸 
0801C924 7FF0     ldrb    r0,[r6,1Fh]    ;获取精灵图片槽                         
0801C926 4681     mov     r9,r0                                   
0801C928 1C30     mov     r0,r6                                   
0801C92A 3023     add     r0,23h                                  
0801C92C 7800     ldrb    r0,[r0]        ;得到300075B的值,调色板                         
0801C92E 4680     mov     r8,r0                                   
0801C930 7F70     ldrb    r0,[r6,1Dh]    ;获取精灵ID                         
0801C932 210C     mov     r1,0Ch         ;默认弹丸ID                         
0801C934 468A     mov     r10,r1                                  
0801C936 2820     cmp     r0,20h         ;ID和20h比较                         
0801C938 D101     bne     @@Greenskree                                
0801C93A 200F     mov     r0,0Fh         ;弹丸 ID                         
0801C93C 4682     mov     r10,r0         ;ID 20h则0Fh,ID 1Fh则0Ch
@@Greenskree:                            ;r9精灵图片slot,r8调色板,r10弹丸ID      
0801C93E 1C3C     mov     r4,r7                                   
0801C940 3C08     sub     r4,8h          ;Y 坐标减8                         
0801C942 9400     str     r4,[sp]        ;写入sp                         
0801C944 9501     str     r5,[sp,4h]     ;X 坐标写入                         
0801C946 2100     mov     r1,0h                                   
0801C948 9102     str     r1,[sp,8h]                              
0801C94A 4650     mov     r0,r10                                  
0801C94C 464A     mov     r2,r9                                   
0801C94E 4643     mov     r3,r8          ;r0弹丸ID,r2精灵图片slot,r3调色板                        
0801C950 F7F1FC82 bl      spawnsecsprite       ;调用弹丸精灵的例程 r1也有用                        
0801C954 9400     str     r4,[sp]        ;3007df4                         
0801C956 9501     str     r5,[sp,4h]                              
0801C958 2040     mov     r0,40h                                  
0801C95A 9002     str     r0,[sp,8h]                              
0801C95C 4650     mov     r0,r10                                  
0801C95E 2100     mov     r1,0h                                   
0801C960 464A     mov     r2,r9                                   
0801C962 4643     mov     r3,r8                                   
0801C964 F7F1FC78 bl      spawnsecsprite                                
0801C968 3410     add     r4,10h                                  
0801C96A 9400     str     r4,[sp]                                 
0801C96C 1C28     mov     r0,r5                                   
0801C96E 380C     sub     r0,0Ch                                  
0801C970 9001     str     r0,[sp,4h]                              
0801C972 2100     mov     r1,0h                                   
0801C974 9102     str     r1,[sp,8h]                              
0801C976 4650     mov     r0,r10                                  
0801C978 2101     mov     r1,1h                                   
0801C97A 464A     mov     r2,r9                                   
0801C97C 4643     mov     r3,r8                                   
0801C97E F7F1FC6B bl      spawnsecsprite                                
0801C982 9400     str     r4,[sp]                                 
0801C984 1C28     mov     r0,r5                                   
0801C986 300C     add     r0,0Ch                                  
0801C988 9001     str     r0,[sp,4h]                              
0801C98A 2040     mov     r0,40h                                  
0801C98C 9002     str     r0,[sp,8h]                              
0801C98E 4650     mov     r0,r10                                  
0801C990 2101     mov     r1,1h                                   
0801C992 464A     mov     r2,r9                                   
0801C994 4643     mov     r3,r8                                   
0801C996 F7F1FC5F bl      spawnsecsprite                                
0801C99A 2100     mov     r1,0h                                   
0801C99C 8031     strh    r1,[r6]                                 
0801C99E 1C38     mov     r0,r7                                   
0801C9A0 3024     add     r0,24h                                  
0801C9A2 1C29     mov     r1,r5                                   
0801C9A4 221E     mov     r2,1Eh                                  
0801C9A6 F037FBA1 bl      deathanimation       ;死亡烟幕                            
0801C9AA 209A     mov     r0,9Ah               ;爆炸声音                   
0801C9AC 0040     lsl     r0,r0,1h                                
0801C9AE F7E6F833 bl      playsound2
@@end:                                
0801C9B2 B003     add     sp,0Ch                                  
0801C9B4 BC38     pop     r3-r5                                   
0801C9B6 4698     mov     r8,r3                                   
0801C9B8 46A1     mov     r9,r4                                   
0801C9BA 46AA     mov     r10,r5                                  
0801C9BC BCF0     pop     r4-r7                                   
0801C9BE BC01     pop     r0                                      
0801C9C0 4700     bx      r0
.pool                                      

.org 801cae0h
0801CAE0 B510     push    r4,r14                      ;主程序,每帧都经历            
0801CAE2 B081     add     sp,-4h                                  
0801CAE4 490E     ldr     r1,=3000738h                            
0801CAE6 1C0B     mov     r3,r1                                   
0801CAE8 3332     add     r3,32h                                  
0801CAEA 781A     ldrb    r2,[r3]                     ;得到300076a的值            
0801CAEC 2402     mov     r4,2h                       ;当被打击的时候值是2            
0801CAEE 1C20     mov     r0,r4                                   
0801CAF0 4010     and     r0,r2                       ;2 and N           
0801CAF2 2800     cmp     r0,0h                                   
0801CAF4 D00A     beq     @@passound                                
0801CAF6 20FD     mov     r0,0FDh                                 
0801CAF8 4010     and     r0,r2                       ;与fdh and  之前为2 结果为0           
0801CAFA 7018     strb    r0,[r3]                     ;重新写入300076a            
0801CAFC 8809     ldrh    r1,[r1]                     ;得到3000738的值            
0801CAFE 1C20     mov     r0,r4                                   
0801CB00 4008     and     r0,r1                       ;只要没死就会是2 and 3 不会为0        
0801CB02 2800     cmp     r0,0h                                
0801CB04 D002     beq     @@passound                                
0801CB06 4807     ldr     r0,=143h                                
0801CB08 F7E6F80A bl      playsound                   ;播放击打声
@@passound:                               
0801CB0C 4C04     ldr     r4,=3000738h                            
0801CB0E 1C20     mov     r0,r4                                   
0801CB10 3030     add     r0,30h                                  
0801CB12 7800     ldrb    r0,[r0]                   ;读取冰冻时间            
0801CB14 2800     cmp     r0,0h                                   
0801CB16 D007     beq     nofrozen                  ;为零跳转            
0801CB18 F7F3FA66 bl      frozen                               
                  b       thend
.org nofrozen:                                
0801CB28 F7F4FBAA bl      stunsprite                                
0801CB2C 2800     cmp     r0,0h                                   
0801CB2E D000     beq     @@nostun                                
0801CB30 E09A     b       thend  
@@nostun:                              
0801CB32 1C20     mov     r0,r4                                   
0801CB34 3024     add     r0,24h                                  
0801CB36 7800     ldrb    r0,[r0]                                 
0801CB38 2837     cmp     r0,37h                                  
0801CB3A D900     bls     @@posenover                ;pose小于38                  
0801CB3C E08A     b       otherpose                 
@@posenover:               
0801CB3E 0080     lsl     r0,r0,2h                   ;乘4相加             
0801CB40 4901     ldr     r1,=posetable                            
0801CB42 1840     add     r0,r0,r1                                
0801CB44 6800     ldr     r0,[r0]                                 
0801CB46 4687     mov     r15,r0 
.pool
                                
.org posetable:
     .word 801cc2ch   ;00
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc30h   ;8
	 .word 801cc34h   ;9
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc3ah  ;22h
	 .word 801cc3eh  ;23h
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc54h .word 801cc54h .word 801cc54h .word 801cc54h 
	 .word 801cc44h  ;34h
	 .word 801cc48h  ;35h
	 .word 801cc54h
	 .word 801cc4eh  ;37h

.org 801cc2ch	 
0801CC2C F7FFFD0A bl      801C644h    ;00                            
0801CC30 F7FFFD30 bl      801C694h    ;8                            
0801CC34 F7FFFD3C bl      801C6B0h    ;9                            
0801CC38 E016     b       801CC68h                                
0801CC3A F7FFFD61 bl      801C700h    ;22h                            
0801CC3E F7FFFD6D bl      801C71Ch    ;23h                            
0801CC42 E011     b       801CC68h                                
0801CC44 F7FFFD78 bl      801C738h    ;34h                            
0801CC48 F7FFFDAA bl      801C7A0h    ;35h                            
0801CC4C E00C     b       801CC68h                                
0801CC4E F7FFFE25 bl      801C89Ch    ;37h                            
0801CC52 E009     b       801CC68h  
.org otherpose                              
0801CC54 4806     ldr     r0,=3000738h                            
0801CC56 8841     ldrh    r1,[r0,2h]         ;Y坐标 +34h                    
0801CC58 3134     add     r1,34h                                  
0801CC5A 8882     ldrh    r2,[r0,4h]         ;X坐标                     
0801CC5C 2020     mov     r0,20h                                  
0801CC5E 9000     str     r0,[sp]            ;20写入sp地址                     
0801CC60 2000     mov     r0,0h                                   
0801CC62 2301     mov     r3,1h              ;r0=0,r1=Y+34h,r2=X,r3=1                     
0801CC64 F7F4FA0E bl      spritedeath        ;进入死亡例程
.pool

.org thend                            ;pose>8后基本每个pose执行完毕都会执行这个例程来结束   
0801CC68 B001     add     sp,4h                                   
0801CC6A BC10     pop     r4                                      
0801CC6C BC01     pop     r0                                      
0801CC6E 4700     bx      r0                                      
/////////////////////////////////////////////////////////////////////////////////////////////////
;弹丸部分
.org 801c9c4h                         ;pose 0  默认执行一次
0801C9C4 B530     push    r4,r5,r14                                           
0801C9C6 4822     ldr     r0,=3000738h                                        
0801C9C8 4684     mov     r12,r0                                              
0801C9CA 8800     ldrh    r0,[r0]                                             
0801C9CC 4A21     ldr     r2,=0FFFBh         ;0FFFBh and 0007 结果3                                
0801C9CE 4002     and     r2,r0                                               
0801C9D0 2300     mov     r3,0h                                               
0801C9D2 2400     mov     r4,0h                                               
0801C9D4 2180     mov     r1,80h                                              
0801C9D6 0209     lsl     r1,r1,8h           ;得到8000h                                 
0801C9D8 1C08     mov     r0,r1                                               
0801C9DA 4302     orr     r2,r0              ;结果8003                               
0801C9DC 431A     orr     r2,r3                                               
0801C9DE 4665     mov     r5,r12                                              
0801C9E0 3532     add     r5,32h                                              
0801C9E2 7829     ldrb    r1,[r5]            ;读取300076a的值 为80h                                 
0801C9E4 2004     mov     r0,4h                                               
0801C9E6 4308     orr     r0,r1              ;结果为84h                                 
0801C9E8 7028     strb    r0,[r5]            ;重新写入                                 
0801C9EA 4660     mov     r0,r12                                              
0801C9EC 3027     add     r0,27h                                              
0801C9EE 2110     mov     r1,10h                                              
0801C9F0 7001     strb    r1,[r0]            ;300075f写入10h                                 
0801C9F2 3001     add     r0,1h                                               
0801C9F4 7001     strb    r1,[r0]            ;3000760写入10h                                 
0801C9F6 3001     add     r0,1h                                               
0801C9F8 7001     strb    r1,[r0]            ;3000761写入10h                                 
0801C9FA 4917     ldr     r1,=0FFF4h                                          
0801C9FC 4665     mov     r5,r12                                              
0801C9FE 8169     strh    r1,[r5,0Ah]                                         
0801CA00 200C     mov     r0,0Ch                                              
0801CA02 81A8     strh    r0,[r5,0Ch]                                         
0801CA04 81E9     strh    r1,[r5,0Eh]                                         
0801CA06 8228     strh    r0,[r5,10h]        ;四面分界                                 
0801CA08 772B     strb    r3,[r5,1Ch]                                         
0801CA0A 82EC     strh    r4,[r5,16h]        ;动画帧和计数归零                                 
0801CA0C 4661     mov     r1,r12                                              
0801CA0E 3124     add     r1,24h                                              
0801CA10 2009     mov     r0,9h              ;pose写入9                                 
0801CA12 7008     strb    r0,[r1]                                             
0801CA14 3101     add     r1,1h                                               
0801CA16 2004     mov     r0,4h              ;属性写入4                                 
0801CA18 7008     strb    r0,[r1]                                             
0801CA1A 3903     sub     r1,3h                                               
0801CA1C 2003     mov     r0,3h              ;300075a写入3                                 
0801CA1E 7008     strb    r0,[r1]                                             
0801CA20 490E     ldr     r1,=3000088h                                        
0801CA22 7B09     ldrb    r1,[r1,0Ch]        ;3000094的值                                 
0801CA24 4008     and     r0,r1              ;3 and 5 结果为1                                 
0801CA26 4661     mov     r1,r12                                              
0801CA28 3121     add     r1,21h                                              
0801CA2A 7008     strb    r0,[r1]            ;3000759写入1                                 
0801CA2C 8868     ldrh    r0,[r5,2h]         ;读取Y坐标                                 
0801CA2E 3028     add     r0,28h             ;加28h再写入                                 
0801CA30 8068     strh    r0,[r5,2h]                                          
0801CA32 490B     ldr     r1,=4008h                                           
0801CA34 1C08     mov     r0,r1                                               
0801CA36 4302     orr     r2,r0              ;80x3h orr 4008h = c0xbh                                 
0801CA38 802A     strh    r2,[r5]            ;x = 0 or 4                                 
0801CA3A 2080     mov     r0,80h                                              
0801CA3C 0040     lsl     r0,r0,1h                                            
0801CA3E 8268     strh    r0,[r5,12h]        ;300073a写入100h                                 
0801CA40 4660     mov     r0,r12                                              
0801CA42 302A     add     r0,2Ah                                              
0801CA44 7003     strb    r3,[r0]            ;3000762写入动画计数                                 
0801CA46 7FA8     ldrb    r0,[r5,1Eh]        ;获取精灵串序号值                                 
0801CA48 2800     cmp     r0,0h                                               
0801CA4A D00D     beq     @@slotzero                                            
0801CA4C 4805     ldr     r0,=82CD5C4h                                        
0801CA4E E00D     b       @@other                                            
@@slotzero:
0801CA68 4802     ldr     r0,=82CD5E4h                                        
0801CA6A 4665     mov     r5,r12  
@@other:                                            
0801CA6C 61A8     str     r0,[r5,18h]                                         
0801CA6E BC30     pop     r4,r5                                               
0801CA70 BC01     pop     r0                                                  
0801CA72 4700     bx      r0 
.pool
                                                 
.org 801ca78h                                         
0801CA78 B500     push    r14                                                 
0801CA7A 490A     ldr     r1,=3000738h                                        
0801CA7C 8AC8     ldrh    r0,[r1,16h]      ;读取动画帧                                   
0801CA7E 1C0A     mov     r2,r1                                               
0801CA80 2801     cmp     r0,1h            ;小于或等于1的话跳转                                   
0801CA82 D902     bls     @@animationnothanone                                            
0801CA84 3126     add     r1,26h                                              
0801CA86 2001     mov     r0,1h                                               
0801CA88 7008     strb    r0,[r1]          ;300075e写入1
@@animationnothanone:                                            
0801CA8A 8811     ldrh    r1,[r2]                                             
0801CA8C 2040     mov     r0,40h                                              
0801CA8E 4008     and     r0,r1            ;40h and c0xbh                                   
0801CA90 2800     cmp     r0,0h            ;结果不定                                   
0801CA92 D009     beq     @@resultzero                                            
0801CA94 8890     ldrh    r0,[r2,4h]                                          
0801CA96 3008     add     r0,8h            ;X坐标右移8h                                   
0801CA98 8090     strh    r0,[r2,4h]                                          
0801CA9A 1C11     mov     r1,r2                                               
0801CA9C 312A     add     r1,2Ah                                              
0801CA9E 7808     ldrb    r0,[r1]          ;3000762的值减少20h再写入                                   
0801CAA0 3020     add     r0,20h                                              
0801CAA2 E008     b       @@joni                                            
@@resultzero:                                          
0801CAA8 8890     ldrh    r0,[r2,4h]                                          
0801CAAA 3808     sub     r0,8h            ;X坐标左移8h                                   
0801CAAC 8090     strh    r0,[r2,4h]                                          
0801CAAE 1C11     mov     r1,r2                                               
0801CAB0 312A     add     r1,2Ah                                              
0801CAB2 7808     ldrb    r0,[r1]          ;3000762的值减少20h再写入                                   
0801CAB4 3820     sub     r0,20h  
@@joni:                                            
0801CAB6 7008     strb    r0,[r1]                                             
0801CAB8 7F90     ldrb    r0,[r2,1Eh]      ;精灵串序号值                                   
0801CABA 2800     cmp     r0,0h                                               
0801CABC D002     beq     @@slotzero                                           
0801CABE 8850     ldrh    r0,[r2,2h]                                          
0801CAC0 3004     add     r0,4h            ;Y坐标下移4                                  
0801CAC2 E001     b       @@goto 
@@slotzero:                                          
0801CAC4 8850     ldrh    r0,[r2,2h]       ;Y坐标上移4                                   
0801CAC6 3804     sub     r0,4h            
@@goto:                                   
0801CAC8 8050     strh    r0,[r2,2h]                                          
0801CACA F7F3F87D bl      checkanimationend2   ;检查动画是否结束
0801CACE 2800     cmp     r0,0h                                               
0801CAD0 D002     beq     @@end                                              
0801CAD2 4902     ldr     r1,=3000738h                                        
0801CAD4 2000     mov     r0,0h                                               
0801CAD6 8008     strh    r0,[r1]              ;写入0,死亡 
@@end:                                             
0801CAD8 BC01     pop     r0                                                  
0801CADA 4700     bx      r0                                                  





.org 801cc74h
0801CC74 B500     push    r14             ;主程序                                    
0801CC76 4804     ldr     r0,=3000738h                                        
0801CC78 3024     add     r0,24h                                              
0801CC7A 7800     ldrb    r0,[r0]         ;读取pose                                    
0801CC7C 2800     cmp     r0,0h                                               
0801CC7E D005     beq     @@goto                                            
0801CC80 2809     cmp     r0,9h                                               
0801CC82 D005     beq     @@come                                           
0801CC84 E006     b       @@end                                            
0801CC86 0000     lsl     r0,r0,0h                                            
0801CC88 0738     lsl     r0,r7,1Ch                                           
0801CC8A 0300     lsl     r0,r0,0Ch
@@goto:                                           
0801CC8C F7FFFE9A bl      801C9C4h       ;弹丸pose0
@@come:                                           
0801CC90 F7FFFEF2 bl      801CA78h       ;弹丸pose9
@@end:                                           
0801CC94 BC01     pop     r0                                                  
0801CC96 4700     bx      r0  
