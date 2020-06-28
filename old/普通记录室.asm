08053968 B500     push    r14                                     
0805396A 2003     mov     r0,3h                                   
0805396C 2141     mov     r1,41h                                  
0805396E F00CFFA5 bl      80608BCh    ;检查第一次逃亡完成事件                            
08053972 2800     cmp     r0,0h                                   
08053974 D107     bne     @@EscapeOver                                
08053976 2003     mov     r0,3h       ;第一次逃亡没有激活                            
08053978 2127     mov     r1,27h                                  
0805397A F00CFF9F bl      80608BCh    ;检查母脑自爆事件                           
0805397E 2800     cmp     r0,0h                                   
08053980 D00F     beq     @@ReturnZero ;没有自爆则返回0                               
08053982 2001     mov     r0,1h        ;自爆则返回1                           
08053984 E00E     b       @@end

@@EscapeOver:                                
08053986 2003     mov     r0,3h                                   
08053988 214B     mov     r1,4Bh      ;检查第二次逃亡完成事件                            
0805398A F00CFF97 bl      80608BCh                                
0805398E 2800     cmp     r0,0h                                   
08053990 D107     bne     @@ReturnZero                                
08053992 2003     mov     r0,3h         ;第二次逃亡没有激活                          
08053994 214A     mov     r1,4Ah                                  
08053996 F00CFF91 bl      80608BCh      ;检查机鸟自爆事件                          
0805399A 2800     cmp     r0,0h                                   
0805399C D001     beq     @@ReturnZero  ;没有自爆则返回0                              
0805399E 2002     mov     r0,2h         ;自爆则返回2                          
080539A0 E000     b       @@end 

@@ReturnZero:                               
080539A2 2000     mov     r0,0h

@@end:                                   
080539A4 BC02     pop     r1                                      
080539A6 4708     bx      r1 

                                     
080539A8 B500     push    r14                                     
080539AA 2003     mov     r0,3h                                   
080539AC 214A     mov     r1,4Ah                                  
080539AE F00CFF85 bl      80608BCh     ;检查机鸟自爆事件                            
080539B2 2800     cmp     r0,0h                                   
080539B4 D002     beq     @@Pass                                
080539B6 2003     mov     r0,3h        ;机鸟已经自爆                            
080539B8 214B     mov     r1,4Bh       ;检查第二次逃亡事件是否完成                           
080539BA E007     b       @@Peer

@@Pass:                                
080539BC 2003     mov     r0,3h                                   
080539BE 2127     mov     r1,27h       ;检查母脑自爆事件                           
080539C0 F00CFF7C bl      80608BCh                                
080539C4 2800     cmp     r0,0h                                   
080539C6 D007     beq     @@ReturnZero                                
080539C8 2003     mov     r0,3h                                   
080539CA 2141     mov     r1,41h       ;检查第一次逃亡事件

@@Peer:                              
080539CC F00CFF76 bl      80608BCh                                
080539D0 2800     cmp     r0,0h                                   
080539D2 D001     beq     @@ReturnZero                                
080539D4 2001     mov     r0,1h                                   
080539D6 E000     b       @@end

@@ReturnZero:                                
080539D8 2000     mov     r0,0h 

@@end:                                  
080539DA BC02     pop     r1                                      
080539DC 4708     bx      r1                                      

;pose 00
0801F9E8 B510     push    r4,r14                                  
0801F9EA B083     add     sp,-0Ch                                 
0801F9EC 4B12     ldr     r3,=3000738h                            
0801F9EE 1C1C     mov     r4,r3                                   
0801F9F0 3432     add     r4,32h                                  
0801F9F2 7821     ldrb    r1,[r4]     ;读取碰撞属性                             
0801F9F4 2001     mov     r0,1h                                   
0801F9F6 2200     mov     r2,0h                                   
0801F9F8 4308     orr     r0,r1       ;1 orr                            
0801F9FA 7020     strb    r0,[r4]     ;再写入                            
0801F9FC 2400     mov     r4,0h                                   
0801F9FE 80DA     strh    r2,[r3,6h]  ;300073e写入0                             
0801FA00 1C18     mov     r0,r3                                   
0801FA02 3025     add     r0,25h                                  
0801FA04 7004     strb    r4,[r0]     ;属性写入0h                            
0801FA06 3002     add     r0,2h                                   
0801FA08 2110     mov     r1,10h                                  
0801FA0A 7001     strb    r1,[r0]     ;300075f写入10h                             
0801FA0C 3001     add     r0,1h                                   
0801FA0E 7001     strb    r1,[r0]     ;3000760写入10h                             
0801FA10 1C19     mov     r1,r3                                   
0801FA12 3129     add     r1,29h                                 
0801FA14 2028     mov     r0,28h                                  
0801FA16 7008     strb    r0,[r1]     ;3000761写入28h                             
0801FA18 4908     ldr     r1,=0FFFCh                              
0801FA1A 8159     strh    r1,[r3,0Ah] ;上部边界写入4                            
0801FA1C 2004     mov     r0,4h                                   
0801FA1E 8198     strh    r0,[r3,0Ch] ;下部边界写入4                           
0801FA20 81D9     strh    r1,[r3,0Eh] ;左部边界写入4                            
0801FA22 8218     strh    r0,[r3,10h] ;右部边界写入4                            
0801FA24 4806     ldr     r0,=30001A8h                            
0801FA26 8800     ldrh    r0,[r0]                                 
0801FA28 2800     cmp     r0,0h       ;警报时间                            
0801FA2A D00B     beq     @@alarmzero                                
0801FA2C 1C19     mov     r1,r3                                   
0801FA2E 312E     add     r1,2Eh                                  
0801FA30 2001     mov     r0,1h       ;警报不为0则                            
0801FA32 7008     strb    r0,[r1]     ;3000766写入1h                              
0801FA34 E009     b       @@Pass                                

@@alarmzero:                               
0801FA44 1C18     mov     r0,r3       ;警报为0则                              
0801FA46 302E     add     r0,2Eh      ;3000766写入0h                            
0801FA48 7004     strb    r4,[r0] 

@@Pass:                                
0801FA4A 4C0C     ldr     r4,=3000738h                            
0801FA4C 2000     mov     r0,0h                                   
0801FA4E 7720     strb    r0,[r4,1Ch]                             
0801FA50 82E0     strh    r0,[r4,16h] ;归零                            
0801FA52 1C21     mov     r1,r4                                   
0801FA54 312C     add     r1,2Ch                                  
0801FA56 200A     mov     r0,0Ah                                  
0801FA58 7008     strb    r0,[r1]     ;3000764写入ah                             
0801FA5A 1C20     mov     r0,r4                                   
0801FA5C 302E     add     r0,2Eh                                  
0801FA5E 7800     ldrb    r0,[r0]     ;读取3000766的值                                
0801FA60 2800     cmp     r0,0h                                   
0801FA62 D104     bne     @@alarmNozero                                
0801FA64 F033FF80 bl      8053968h    ;检查逃亡是否在进行                            
0801FA68 1C01     mov     r1,r0                                   
0801FA6A 2900     cmp     r1,0h                                   
0801FA6C D00A     beq     @@EscapeOver

@@alarmNozero:                                
0801FA6E 4804     ldr     r0,=82D4DF4h                            
0801FA70 61A0     str     r0,[r4,18h]  ;写入OAM                           
0801FA72 1C21     mov     r1,r4                                   
0801FA74 3124     add     r1,24h                                  
0801FA76 2051     mov     r0,51h       ;pose 写入51h                           
0801FA78 E02B     b       @@WritePose                                

@@EscapeOver:                              
0801FA84 480E     ldr     r0,=3000C1Dh                            
0801FA86 7800     ldrb    r0,[r0]                                 
0801FA88 0600     lsl     r0,r0,18h                               
0801FA8A 1600     asr     r0,r0,18h                               
0801FA8C 2800     cmp     r0,0h                                   
0801FA8E D01B     beq     @@C1DZERO                                
0801FA90 7FE2     ldrb    r2,[r4,1Fh]  ;gfx row                           
0801FA92 1C20     mov     r0,r4                                   
0801FA94 3023     add     r0,23h                                  
0801FA96 7803     ldrb    r3,[r0]      ;主精灵序号                           
0801FA98 8860     ldrh    r0,[r4,2h]                              
0801FA9A 9000     str     r0,[sp]                                 
0801FA9C 88A0     ldrh    r0,[r4,4h]                              
0801FA9E 9001     str     r0,[sp,4h]                              
0801FAA0 9102     str     r1,[sp,8h]                              
0801FAA2 200D     mov     r0,0Dh                                  
0801FAA4 2100     mov     r1,0h                                   
0801FAA6 F7EEFBD7 bl      800E258h     ;生产副精灵d-0h                             
0801FAAA 4806     ldr     r0,=82D4DC4h ;写入OAM                           
0801FAAC 61A0     str     r0,[r4,18h]                             
0801FAAE 1C21     mov     r1,r4                                   
0801FAB0 3124     add     r1,24h                                  
0801FAB2 2028     mov     r0,28h                                  
0801FAB4 7008     strb    r0,[r1]      ;pose写入28h                             
0801FAB6 20AA     mov     r0,0AAh                                 
0801FAB8 0040     lsl     r0,r0,1h                                
0801FABA 80E0     strh    r0,[r4,6h]   ;300073e写入154h                           
0801FABC E00A     b       @@Peer                                

@@C1DZERO:                               
0801FAC8 480E     ldr     r0,=82D4CFCh                            
0801FACA 61A0     str     r0,[r4,18h]                             
0801FACC 1C21     mov     r1,r4                                   
0801FACE 3124     add     r1,24h                                  
0801FAD0 2009     mov     r0,9h        ;pose写入9h

@@WritePose:                                  
0801FAD2 7008     strb    r0,[r1] 

@@Peer:                                
0801FAD4 4C0C     ldr     r4,=3000738h                            
0801FAD6 7FE2     ldrb    r2,[r4,1Fh]  ;读取gfx row                           
0801FAD8 1C20     mov     r0,r4                                   
0801FADA 3023     add     r0,23h                                  
0801FADC 7803     ldrb    r3,[r0]      ;读取主精灵序号                            
0801FADE 8860     ldrh    r0,[r4,2h]                              
0801FAE0 490A     ldr     r1,=0FFFFFE00h  ;200h  8格                      
0801FAE2 1840     add     r0,r0,r1                                
0801FAE4 9000     str     r0,[sp]                                 
0801FAE6 88A0     ldrh    r0,[r4,4h]                              
0801FAE8 9001     str     r0,[sp,4h]                              
0801FAEA 2000     mov     r0,0h                                   
0801FAEC 9002     str     r0,[sp,8h]                              
0801FAEE 200D     mov     r0,0Dh                                  
0801FAF0 2103     mov     r1,3h                                   
0801FAF2 F7EEFBB1 bl      800E258h     ;生产D-3副精灵                             
0801FAF6 342F     add     r4,2Fh                                  
0801FAF8 7020     strb    r0,[r4]                                 
0801FAFA B003     add     sp,0Ch                                  
0801FAFC BC10     pop     r4                                      
0801FAFE BC01     pop     r0                                      
0801FB00 4700     bx      r0                                      

;pose 9调用
0801F9B0 B510     push    r4,r14                                  
0801F9B2 2400     mov     r4,0h                                   
0801F9B4 480A     ldr     r0,=30013D4h                            
0801F9B6 8A82     ldrh    r2,[r0,14h]                             
0801F9B8 8A43     ldrh    r3,[r0,12h]     ;获取SA坐标                         
0801F9BA 490A     ldr     r1,=3000738h                            
0801F9BC 8848     ldrh    r0,[r1,2h]                              
0801F9BE 8889     ldrh    r1,[r1,4h]      ;获取精灵坐标                         
0801F9C0 3841     sub     r0,41h          ;精灵Y坐标向上提升41h                        
0801F9C2 4282     cmp     r2,r0           ;和SA Y坐标比较                        
0801F9C4 D107     bne     @@end                                
0801F9C6 1C08     mov     r0,r1                                   
0801F9C8 3840     sub     r0,40h          ;精灵X坐标向左移动一格                         
0801F9CA 4298     cmp     r0,r3           ;和SA X坐标比较                        
0801F9CC DA03     bge     @@end           ;大于或等于结束                     
0801F9CE 3080     add     r0,80h                                  
0801F9D0 4298     cmp     r0,r3                                   
0801F9D2 DD00     ble     @@end           ;小于或等于结束                     
0801F9D4 2401     mov     r4,1h 

@@end:                                  
0801F9D6 1C20     mov     r0,r4                                   
0801F9D8 BC10     pop     r4                                      
0801F9DA BC02     pop     r1                                      
0801F9DC 4708     bx      r1 

;pose 9 检查是否达到被吸的条件                               
0801FB10 B500     push    r14                                     
0801FB12 F7FFFF4D bl      801F9B0h                                
0801FB16 0600     lsl     r0,r0,18h                               
0801FB18 2800     cmp     r0,0h                                   
0801FB1A D01D     beq     @@OverScope                                
0801FB1C F7F0FC26 bl      801036Ch       ;区分姿势                          
0801FB20 2800     cmp     r0,0h                                   
0801FB22 D119     bne     @@OverScope                                
0801FB24 4B0A     ldr     r3,=3000738h                            
0801FB26 1C19     mov     r1,r3                                   
0801FB28 312C     add     r1,2Ch                                  
0801FB2A 7808     ldrb    r0,[r1]        ;读取3000764的值                            
0801FB2C 3801     sub     r0,1h                                   
0801FB2E 7008     strb    r0,[r1]        ;减1再写入                         
0801FB30 0600     lsl     r0,r0,18h                               
0801FB32 0E02     lsr     r2,r0,18h                               
0801FB34 2A00     cmp     r2,0h                                   
0801FB36 D113     bne     @@end                                
0801FB38 3908     sub     r1,8h                                   
0801FB3A 2023     mov     r0,23h                                  
0801FB3C 7008     strb    r0,[r1]        ;pose 写入23h                          
0801FB3E 4805     ldr     r0,=82D4D34h                            
0801FB40 6198     str     r0,[r3,18h]    ;写入OAM                          
0801FB42 771A     strb    r2,[r3,1Ch]                             
0801FB44 82DA     strh    r2,[r3,16h]                             
0801FB46 2089     mov     r0,89h                                  
0801FB48 0040     lsl     r0,r0,1h       ;台坐展开的声音                         
0801FB4A F7E2FF65 bl      8002A18h                                
0801FB4E E007     b       @@end                                

@@OverScope:                              
0801FB58 4802     ldr     r0,=3000738h                            
0801FB5A 302C     add     r0,2Ch                                  
0801FB5C 210A     mov     r1,0Ah                                  
0801FB5E 7001     strb    r1,[r0]        ;3000764写入Ah 恢复延迟值

@@end:                                 
0801FB60 BC01     pop     r0                                      
0801FB62 4700     bx      r0    
                                  
;pose 23h                               ;吸入过渡阶段
0801FB68 B500     push    r14                                     
0801FB6A F7F0F82D bl      800FBC8h      ;检查动画结束                          
0801FB6E 2800     cmp     r0,0h                                   
0801FB70 D009     beq     @@end                                
0801FB72 4906     ldr     r1,=3000738h                            
0801FB74 1C0A     mov     r2,r1                                   
0801FB76 3224     add     r2,24h                                  
0801FB78 2300     mov     r3,0h                                   
0801FB7A 2025     mov     r0,25h        ;pose写入25h                          
0801FB7C 7010     strb    r0,[r2]                                 
0801FB7E 4804     ldr     r0,=82D4D54h  ;写入新OAM                          
0801FB80 6188     str     r0,[r1,18h]                             
0801FB82 770B     strb    r3,[r1,1Ch]                             
0801FB84 82CB     strh    r3,[r1,16h] 

@@end:                            
0801FB86 BC01     pop     r0                                      
0801FB88 4700     bx      r0                                      

;pose 25h                                ;吸入确认阶段
0801FB94 B510     push    r4,r14                                  
0801FB96 F7FFFF0B bl      801F9B0h       ;检查人是否在范围                             
0801FB9A 0600     lsl     r0,r0,18h                               
0801FB9C 0E03     lsr     r3,r0,18h                               
0801FB9E 2B00     cmp     r3,0h                                   
0801FBA0 D022     beq     @@OverScope                                
0801FBA2 F7F0FBE3 bl      801036Ch       ;检查姿势是否合适                         
0801FBA6 2800     cmp     r0,0h                                   
0801FBA8 D12A     bne     @@end                                
0801FBAA 4A0C     ldr     r2,=3000738h                            
0801FBAC 1C11     mov     r1,r2                                   
0801FBAE 3124     add     r1,24h                                  
0801FBB0 2042     mov     r0,42h         ;pose写入 42h                         
0801FBB2 7008     strb    r0,[r1]                                 
0801FBB4 3108     add     r1,8h                                   
0801FBB6 2004     mov     r0,4h                                   
0801FBB8 7008     strb    r0,[r1]        ;3000764写入4h                                
0801FBBA 4C09     ldr     r4,=30013D4h                            
0801FBBC 8890     ldrh    r0,[r2,4h]     ;读取X坐标                         
0801FBBE 8260     strh    r0,[r4,12h]    ;写入人物X坐标                         
0801FBC0 79A0     ldrb    r0,[r4,6h]     ;读取人物无敌时间                         
0801FBC2 2800     cmp     r0,0h                                   
0801FBC4 D001     beq     @@Pass                                
0801FBC6 2000     mov     r0,0h                                   
0801FBC8 71A0     strb    r0,[r4,6h]     ;否则无敌时间写入0 

@@Pass:                         
0801FBCA 201F     mov     r0,1Fh                                  
0801FBCC F7E7FC8C bl      80074E8h       ;改变pose                         
0801FBD0 2101     mov     r1,1h                                   
0801FBD2 72A1     strb    r1,[r4,0Ah]    ;加速累计值写入1                          
0801FBD4 4803     ldr     r0,=3000049h                            
0801FBD6 7001     strb    r1,[r0]        ;关闭暂停                         
0801FBD8 E012     b       @@end                                

@@OverScope:                               
0801FBE8 4907     ldr     r1,=3000738h                            
0801FBEA 1C0A     mov     r2,r1                                   
0801FBEC 3224     add     r2,24h         ;pose写入27h                         
0801FBEE 2027     mov     r0,27h                                  
0801FBF0 7010     strb    r0,[r2]                                 
0801FBF2 4806     ldr     r0,=82D4DD4h                            
0801FBF4 6188     str     r0,[r1,18h]    ;写入新OAM                         
0801FBF6 770B     strb    r3,[r1,1Ch]                             
0801FBF8 82CB     strh    r3,[r1,16h]                             
0801FBFA 4805     ldr     r0,=113h       ;台坐缩回声                        
0801FBFC F7E2FF0C bl      8002A18h 

@@end:                               
0801FC00 BC10     pop     r4                                      
0801FC02 BC01     pop     r0                                      
0801FC04 4700     bx      r0 

;pose 27h                                ;吸入失败                                                  
0801FC14 B500     push    r14                                     
0801FC16 F7EFFFD7 bl      800FBC8h       ;检查动画结束                            
0801FC1A 2800     cmp     r0,0h                                   
0801FC1C D00C     beq     @@end                                
0801FC1E 4807     ldr     r0,=3000738h                            
0801FC20 1C02     mov     r2,r0                                   
0801FC22 3224     add     r2,24h                                  
0801FC24 2300     mov     r3,0h                                   
0801FC26 2109     mov     r1,9h          ;pose 写回9h                          
0801FC28 7011     strb    r1,[r2]                                 
0801FC2A 4905     ldr     r1,=82D4CFCh   ;写入新的OAM                         
0801FC2C 6181     str     r1,[r0,18h]                             
0801FC2E 7703     strb    r3,[r0,1Ch]                             
0801FC30 82C3     strh    r3,[r0,16h]                             
0801FC32 302C     add     r0,2Ch         ;3000764写入Ah                          
0801FC34 210A     mov     r1,0Ah                                  
0801FC36 7001     strb    r1,[r0] 

@@end:                                
0801FC38 BC01     pop     r0                                      
0801FC3A 4700     bx      r0  

;pose 28h                             
0801FC44 B510     push    r4,r14                                  
0801FC46 4904     ldr     r1,=3000738h                            
0801FC48 88C8     ldrh    r0,[r1,6h]     ;读取300073eh 记录时间?                         
0801FC4A 1C04     mov     r4,r0                                   
0801FC4C 2C00     cmp     r4,0h                                   
0801FC4E D005     beq     @@zero                                
0801FC50 3801     sub     r0,1h          ;300073e的值减1再写入                          
0801FC52 80C8     strh    r0,[r1,6h]                              
0801FC54 E00B     b       @@end                                

@@zero:                               
0801FC5C 1C08     mov     r0,r1                                   
0801FC5E 3024     add     r0,24h                                  
0801FC60 2129     mov     r1,29h         ;pose写入29h                         
0801FC62 7001     strb    r1,[r0]                                 
0801FC64 201E     mov     r0,1Eh                                  
0801FC66 F7E7FC3F bl      80074E8h       ;SA pose改成1e                          
0801FC6A 4802     ldr     r0,=3000049h                            
0801FC6C 7004     strb    r4,[r0]        ;暂停开启

@@end:                                
0801FC6E BC10     pop     r4                                      
0801FC70 BC01     pop     r0                                      
0801FC72 4700     bx      r0 

;pose 29h                                                                  
0801FC78 B500     push    r14                                     
0801FC7A F7FFFE99 bl      801F9B0h       ;检查是否在被吸的范围                         
0801FC7E 0600     lsl     r0,r0,18h                               
0801FC80 0E03     lsr     r3,r0,18h                               
0801FC82 2B00     cmp     r3,0h                                   
0801FC84 D10B     bne     @@end                                
0801FC86 4907     ldr     r1,=3000738h                            
0801FC88 1C0A     mov     r2,r1                                   
0801FC8A 3224     add     r2,24h                                  
0801FC8C 2027     mov     r0,27h        ;一旦离开位置                          
0801FC8E 7010     strb    r0,[r2]       ;pose写入27                         
0801FC90 4805     ldr     r0,=82D4DD4h  ;写入新OAM                          
0801FC92 6188     str     r0,[r1,18h]                             
0801FC94 770B     strb    r3,[r1,1Ch]                             
0801FC96 82CB     strh    r3,[r1,16h]                             
0801FC98 4804     ldr     r0,=113h      ;台坐缩回声                          
0801FC9A F7E2FEBD bl      8002A18h  

@@end:                              
0801FC9E BC01     pop     r0                                      
0801FCA0 4700     bx      r0                                      

;pose 42h                               记录过程   
0801FCB0 B5F0     push    r4-r7,r14                               
0801FCB2 B083     add     sp,-0Ch                                 
0801FCB4 4D0C     ldr     r5,=3000738h                            
0801FCB6 1C2A     mov     r2,r5                                   
0801FCB8 322C     add     r2,2Ch                                  
0801FCBA 7810     ldrb    r0,[r2]       ;读取3000764的值                          
0801FCBC 1C06     mov     r6,r0                                   
0801FCBE 2E00     cmp     r6,0h                                   
0801FCC0 D014     beq     @@zero                                
0801FCC2 3801     sub     r0,1h                                   
0801FCC4 7010     strb    r0,[r2]       ;减1再写入                          
0801FCC6 0600     lsl     r0,r0,18h                               
0801FCC8 0E01     lsr     r1,r0,18h                               
0801FCCA 2900     cmp     r1,0h                                   
0801FCCC D154     bne     @@end                                
0801FCCE 886B     ldrh    r3,[r5,2h]    ;读取坐标                           
0801FCD0 88A8     ldrh    r0,[r5,4h]                              
0801FCD2 9000     str     r0,[sp]                                 
0801FCD4 9101     str     r1,[sp,4h]                              
0801FCD6 2011     mov     r0,11h                                  
0801FCD8 2116     mov     r1,16h                                  
0801FCDA 2206     mov     r2,6h                                   
0801FCDC F7EEFB1E bl      800E31Ch      ;生产存档字幕                            
0801FCE0 1C29     mov     r1,r5                                   
0801FCE2 312D     add     r1,2Dh                                  
0801FCE4 7008     strb    r0,[r1]       ;3000765写入精灵槽序号                          
0801FCE6 E047     b       @@end                                

@@zero:                               
0801FCEC 1C28     mov     r0,r5                                   
0801FCEE 302D     add     r0,2Dh                                  
0801FCF0 7801     ldrb    r1,[r0]       ;读取3000765的值  槽序号                        
0801FCF2 4F1B     ldr     r7,=30001ACh                            
0801FCF4 00C8     lsl     r0,r1,3h                                
0801FCF6 1A40     sub     r0,r0,r1                                
0801FCF8 00C0     lsl     r0,r0,3h                                
0801FCFA 19C1     add     r1,r0,r7                                
0801FCFC 1C08     mov     r0,r1                                   
0801FCFE 3024     add     r0,24h                                  
0801FD00 7800     ldrb    r0,[r0]                                 
0801FD02 2825     cmp     r0,25h        ;检查pose是否是25h                           
0801FD04 D138     bne     @@end         ;字幕未按掉                      
0801FD06 1C08     mov     r0,r1                                   
0801FD08 302D     add     r0,2Dh                                   
0801FD0A 7800     ldrb    r0,[r0]       ;读取                         
0801FD0C 2801     cmp     r0,1h         ;选择了存档                          
0801FD0E D12D     bne     @@NoSave                                
0801FD10 4814     ldr     r0,=82D4D8Ch                            
0801FD12 61A8     str     r0,[r5,18h]   ;写入新OAM                          
0801FD14 772E     strb    r6,[r5,1Ch]                             
0801FD16 2400     mov     r4,0h                                   
0801FD18 82EE     strh    r6,[r5,16h]                             
0801FD1A 1C29     mov     r1,r5                                   
0801FD1C 3124     add     r1,24h                                  
0801FD1E 2043     mov     r0,43h                                  
0801FD20 7008     strb    r0,[r1]       ;Pose写入43h                             
0801FD22 7FEA     ldrb    r2,[r5,1Fh]   ;gfxrow                          
0801FD24 1C28     mov     r0,r5                                   
0801FD26 3023     add     r0,23h                                  
0801FD28 7803     ldrb    r3,[r0]                                 
0801FD2A 8868     ldrh    r0,[r5,2h]                              
0801FD2C 9000     str     r0,[sp]                                 
0801FD2E 88A8     ldrh    r0,[r5,4h]                              
0801FD30 9001     str     r0,[sp,4h]                              
0801FD32 9602     str     r6,[sp,8h]                              
0801FD34 200D     mov     r0,0Dh                                  
0801FD36 2100     mov     r1,0h                                   
0801FD38 F7EEFA8E bl      800E258h      ;生产D-0副精灵                          
0801FD3C 1C28     mov     r0,r5                                   
0801FD3E 302F     add     r0,2Fh                                  
0801FD40 7801     ldrb    r1,[r0]       ;读取3000767的值                          
0801FD42 00C8     lsl     r0,r1,3h                                
0801FD44 1A40     sub     r0,r0,r1                                
0801FD46 00C0     lsl     r0,r0,3h      ;56倍                          
0801FD48 19C0     add     r0,r0,r7                                
0801FD4A 3024     add     r0,24h                                  
0801FD4C 2144     mov     r1,44h        ;副精灵pose写入44h??                           
0801FD4E 7001     strb    r1,[r0]                                 
0801FD50 4805     ldr     r0,=30013D4h                            
0801FD52 7284     strb    r4,[r0,0Ah]   ;加速累计值写入0                          
0801FD54 208A     mov     r0,8Ah        ;存档声音                          
0801FD56 0040     lsl     r0,r0,1h                                
0801FD58 F7E2FE5E bl      8002A18h                                
0801FD5C E00C     b       @@end                                

@@NoSave:                             
0801FD6C 1C28     mov     r0,r5                                   
0801FD6E 3024     add     r0,24h                                  
0801FD70 214B     mov     r1,4Bh        ;pose写4bh                           
0801FD72 7001     strb    r1,[r0]                                 
0801FD74 200A     mov     r0,0Ah                                  
0801FD76 7010     strb    r0,[r2]       ;3000764写入0ah

@@end:                                 
0801FD78 B003     add     sp,0Ch                                  
0801FD7A BCF0     pop     r4-r7                                   
0801FD7C BC01     pop     r0                                      
0801FD7E 4700     bx      r0 



;pose 43h                                     
0801FD80 B500     push    r14                                     
0801FD82 4A06     ldr     r2,=3000738h                            
0801FD84 1C10     mov     r0,r2                                   
0801FD86 302F     add     r0,2Fh                                  
0801FD88 7803     ldrb    r3,[r0]         ;读取3000767的值                              
0801FD8A 8AD1     ldrh    r1,[r2,16h]     ;获取动画                        
0801FD8C 2001     mov     r0,1h           ;1 and                        
0801FD8E 4008     and     r0,r1                                   
0801FD90 2800     cmp     r0,0h                                   
0801FD92 D005     beq     @@Pass                                
0801FD94 1C10     mov     r0,r2                                   
0801FD96 3020     add     r0,20h                                  
0801FD98 2200     mov     r2,0h                                   
0801FD9A E004     b       @@Pass2                                


@@Pass:                              
0801FDA0 1C10     mov     r0,r2                                   
0801FDA2 3020     add     r0,20h                                  
0801FDA4 2202     mov     r2,2h 

@@Pass2:                                  
0801FDA6 7002     strb    r2,[r0]         ;调色板写入0 or 2                         
0801FDA8 4904     ldr     r1,=30001ACh                            
0801FDAA 00D8     lsl     r0,r3,3h                                
0801FDAC 1AC0     sub     r0,r0,r3                                
0801FDAE 00C0     lsl     r0,r0,3h                                
0801FDB0 1840     add     r0,r0,r1                                
0801FDB2 3020     add     r0,20h                                  
0801FDB4 7002     strb    r2,[r0]        ;副精灵写入同样的调色板                        
0801FDB6 BC01     pop     r0                                      
0801FDB8 4700     bx      r0

                                      
;pose 45h                              
0801FDC0 480D     ldr     r0,=3000738h                            
0801FDC2 4684     mov     r12,r0                                  
0801FDC4 480D     ldr     r0,=82D4DC4h                            
0801FDC6 4661     mov     r1,r12                                  
0801FDC8 6188     str     r0,[r1,18h]                             
0801FDCA 2000     mov     r0,0h                                   
0801FDCC 7708     strb    r0,[r1,1Ch]                             
0801FDCE 2300     mov     r3,0h                                   
0801FDD0 82C8     strh    r0,[r1,16h]                             
0801FDD2 3124     add     r1,24h                                  
0801FDD4 2047     mov     r0,47h                                  
0801FDD6 7008     strb    r0,[r1]                                 
0801FDD8 3108     add     r1,8h                                   
0801FDDA 203C     mov     r0,3Ch                                  
0801FDDC 7008     strb    r0,[r1]                                 
0801FDDE 4660     mov     r0,r12                                  
0801FDE0 3020     add     r0,20h                                  
0801FDE2 7003     strb    r3,[r0]                                 
0801FDE4 4A06     ldr     r2,=30001ACh                            
0801FDE6 300F     add     r0,0Fh                                  
0801FDE8 7801     ldrb    r1,[r0]                                 
0801FDEA 00C8     lsl     r0,r1,3h                                
0801FDEC 1A40     sub     r0,r0,r1                                
0801FDEE 00C0     lsl     r0,r0,3h                                
0801FDF0 1880     add     r0,r0,r2                                
0801FDF2 3020     add     r0,20h                                  
0801FDF4 7003     strb    r3,[r0]                                 
0801FDF6 4770     bx      r14                                     
0801FDF8 0738     lsl     r0,r7,1Ch                               
0801FDFA 0300     lsl     r0,r0,0Ch                               
0801FDFC 4DC4     ldr     r5,=46844811h                           
0801FDFE 082D     lsr     r5,r5,20h                               
0801FE00 01AC     lsl     r4,r5,6h                                
0801FE02 0300     lsl     r0,r0,0Ch                               
0801FE04 B510     push    r4,r14                                  
0801FE06 B082     add     sp,-8h                                  
0801FE08 4C0E     ldr     r4,=3000738h                            
0801FE0A 1C21     mov     r1,r4                                   
0801FE0C 312C     add     r1,2Ch                                  
0801FE0E 7808     ldrb    r0,[r1]                                 
0801FE10 3801     sub     r0,1h                                   
0801FE12 7008     strb    r0,[r1]                                 
0801FE14 0600     lsl     r0,r0,18h                               
0801FE16 0E02     lsr     r2,r0,18h                               
0801FE18 2A00     cmp     r2,0h                                   
0801FE1A D10E     bne     801FE3Ah                                
0801FE1C 3908     sub     r1,8h                                   
0801FE1E 2049     mov     r0,49h                                  
0801FE20 7008     strb    r0,[r1]                                 
0801FE22 8863     ldrh    r3,[r4,2h]                              
0801FE24 88A0     ldrh    r0,[r4,4h]                              
0801FE26 9000     str     r0,[sp]                                 
0801FE28 9201     str     r2,[sp,4h]                              
0801FE2A 2011     mov     r0,11h                                  
0801FE2C 2117     mov     r1,17h                                  
0801FE2E 2206     mov     r2,6h                                   
0801FE30 F7EEFA74 bl      800E31Ch                                
0801FE34 1C21     mov     r1,r4                                   
0801FE36 312D     add     r1,2Dh                                  
0801FE38 7008     strb    r0,[r1]                                 
0801FE3A B002     add     sp,8h                                   
0801FE3C BC10     pop     r4                                      
0801FE3E BC01     pop     r0                                      
0801FE40 4700     bx      r0                                      
0801FE42 0000     lsl     r0,r0,0h                                
0801FE44 0738     lsl     r0,r7,1Ch                               
0801FE46 0300     lsl     r0,r0,0Ch                               
0801FE48 B500     push    r14                                     
0801FE4A 4B0B     ldr     r3,=3000738h                            
0801FE4C 1C18     mov     r0,r3                                   
0801FE4E 302D     add     r0,2Dh                                  
0801FE50 7801     ldrb    r1,[r0]                                 
0801FE52 4A0A     ldr     r2,=30001ACh                            
0801FE54 00C8     lsl     r0,r1,3h                                
0801FE56 1A40     sub     r0,r0,r1                                
0801FE58 00C0     lsl     r0,r0,3h                                
0801FE5A 1880     add     r0,r0,r2                                
0801FE5C 3024     add     r0,24h                                  
0801FE5E 7800     ldrb    r0,[r0]                                 
0801FE60 2825     cmp     r0,25h                                  
0801FE62 D106     bne     801FE72h                                
0801FE64 1C19     mov     r1,r3                                   
0801FE66 3124     add     r1,24h                                  
0801FE68 204B     mov     r0,4Bh                                  
0801FE6A 7008     strb    r0,[r1]                                 
0801FE6C 3108     add     r1,8h                                   
0801FE6E 200A     mov     r0,0Ah                                  
0801FE70 7008     strb    r0,[r1]                                 
0801FE72 BC01     pop     r0                                      
0801FE74 4700     bx      r0                                      

;pose 4b                              
0801FE80 B500     push    r14                                     
0801FE82 4A07     ldr     r2,=3000738h                            
0801FE84 1C11     mov     r1,r2                                   
0801FE86 312C     add     r1,2Ch                                  
0801FE88 7808     ldrb    r0,[r1]                                 
0801FE8A 3801     sub     r0,1h                                   
0801FE8C 7008     strb    r0,[r1]                                 
0801FE8E 0600     lsl     r0,r0,18h                               
0801FE90 2800     cmp     r0,0h                                   
0801FE92 D102     bne     801FE9Ah                                
0801FE94 3908     sub     r1,8h                                   
0801FE96 2028     mov     r0,28h                                  
0801FE98 7008     strb    r0,[r1]                                 
0801FE9A BC01     pop     r0                                      
0801FE9C 4700     bx      r0                                      
0801FE9E 0000     lsl     r0,r0,0h                                
0801FEA0 0738     lsl     r0,r7,1Ch                               
0801FEA2 0300     lsl     r0,r0,0Ch                               
0801FEA4 B530     push    r4,r5,r14                               
0801FEA6 4B12     ldr     r3,=3000738h                            
0801FEA8 1C18     mov     r0,r3                                   
0801FEAA 3023     add     r0,23h                                  
0801FEAC 7804     ldrb    r4,[r0]                                 
0801FEAE 8819     ldrh    r1,[r3]                                 
0801FEB0 4810     ldr     r0,=0FFFBh                              
0801FEB2 4008     and     r0,r1                                   
0801FEB4 2500     mov     r5,0h                                   
0801FEB6 2200     mov     r2,0h                                   
0801FEB8 8018     strh    r0,[r3]                                 
0801FEBA 2032     mov     r0,32h                                  
0801FEBC 18C0     add     r0,r0,r3                                
0801FEBE 4684     mov     r12,r0                                  
0801FEC0 7801     ldrb    r1,[r0]                                 
0801FEC2 2001     mov     r0,1h                                   
0801FEC4 4308     orr     r0,r1                                   
0801FEC6 4661     mov     r1,r12                                  
0801FEC8 7008     strb    r0,[r1]                                 
0801FECA 1C18     mov     r0,r3                                   
0801FECC 3025     add     r0,25h                                  
0801FECE 7005     strb    r5,[r0]                                 
0801FED0 4909     ldr     r1,=0FFFCh                              
0801FED2 8159     strh    r1,[r3,0Ah]                             
0801FED4 2004     mov     r0,4h                                   
0801FED6 8198     strh    r0,[r3,0Ch]                             
0801FED8 81D9     strh    r1,[r3,0Eh]                             
0801FEDA 8218     strh    r0,[r3,10h]                             
0801FEDC 771D     strb    r5,[r3,1Ch]                             
0801FEDE 82DA     strh    r2,[r3,16h]                             
0801FEE0 7F98     ldrb    r0,[r3,1Eh]                             
0801FEE2 2801     cmp     r0,1h                                   
0801FEE4 D03A     beq     801FF5Ch                                
0801FEE6 2801     cmp     r0,1h                                   
0801FEE8 DC08     bgt     801FEFCh                                
0801FEEA 2800     cmp     r0,0h                                   
0801FEEC D00B     beq     801FF06h                                
0801FEEE E089     b       8020004h                                
0801FEF0 0738     lsl     r0,r7,1Ch                               
0801FEF2 0300     lsl     r0,r0,0Ch                               
0801FEF4 FFFB     bl      lr+0FF6h                                
0801FEF6 0000     lsl     r0,r0,0h                                
0801FEF8 FFFC     bl      lr+0FF8h                                
0801FEFA 0000     lsl     r0,r0,0h                                
0801FEFC 2802     cmp     r0,2h                                   
0801FEFE D043     beq     801FF88h                                
0801FF00 2803     cmp     r0,3h                                   
0801FF02 D059     beq     801FFB8h                                
0801FF04 E07E     b       8020004h                                
0801FF06 1C19     mov     r1,r3                                   
0801FF08 3127     add     r1,27h                                  
0801FF0A 2050     mov     r0,50h                                  
0801FF0C 7008     strb    r0,[r1]                                 
0801FF0E 1C18     mov     r0,r3                                   
0801FF10 3028     add     r0,28h                                  
0801FF12 7005     strb    r5,[r0]                                 
0801FF14 3102     add     r1,2h                                   
0801FF16 2018     mov     r0,18h                                  
0801FF18 7008     strb    r0,[r1]                                 
0801FF1A 4909     ldr     r1,=30001ACh                            
0801FF1C 00E0     lsl     r0,r4,3h                                
0801FF1E 1B00     sub     r0,r0,r4                                
0801FF20 00C0     lsl     r0,r0,3h                                
0801FF22 1840     add     r0,r0,r1                                
0801FF24 3024     add     r0,24h                                  
0801FF26 7800     ldrb    r0,[r0]                                 
0801FF28 2828     cmp     r0,28h                                  
0801FF2A D10D     bne     801FF48h                                
0801FF2C 4805     ldr     r0,=82D5024h                            
0801FF2E 6198     str     r0,[r3,18h]                             
0801FF30 209B     mov     r0,9Bh                                  
0801FF32 0040     lsl     r0,r0,1h                                
0801FF34 80D8     strh    r0,[r3,6h]                              
0801FF36 1C19     mov     r1,r3                                   
0801FF38 3124     add     r1,24h                                  
0801FF3A 2025     mov     r0,25h                                  
0801FF3C 7008     strb    r0,[r1]                                 
0801FF3E E063     b       8020008h                                
0801FF40 01AC     lsl     r4,r5,6h                                
0801FF42 0300     lsl     r0,r0,0Ch                               
0801FF44 5024     str     r4,[r4,r0]                              
0801FF46 082D     lsr     r5,r5,20h                               
0801FF48 4803     ldr     r0,=82D4E84h                            
0801FF4A 6198     str     r0,[r3,18h]                             
0801FF4C 1C19     mov     r1,r3                                   
0801FF4E 3124     add     r1,24h                                  
0801FF50 2009     mov     r0,9h                                   
0801FF52 7008     strb    r0,[r1]                                 
0801FF54 E058     b       8020008h                                
0801FF56 0000     lsl     r0,r0,0h                                
0801FF58 4E84     ldr     r6,=2B000C03h                           
0801FF5A 082D     lsr     r5,r5,20h                               
0801FF5C 1C19     mov     r1,r3                                   
0801FF5E 3122     add     r1,22h                                  
0801FF60 200C     mov     r0,0Ch                                  
0801FF62 7008     strb    r0,[r1]                                 
0801FF64 4807     ldr     r0,=82D4FBCh                            
0801FF66 6198     str     r0,[r3,18h]                             
0801FF68 3105     add     r1,5h                                   
0801FF6A 2050     mov     r0,50h                                  
0801FF6C 7008     strb    r0,[r1]                                 
0801FF6E 1C18     mov     r0,r3                                   
0801FF70 3028     add     r0,28h                                  
0801FF72 7005     strb    r5,[r0]                                 
0801FF74 3102     add     r1,2h                                   
0801FF76 2018     mov     r0,18h                                  
0801FF78 7008     strb    r0,[r1]                                 
0801FF7A 3905     sub     r1,5h                                   
0801FF7C 2029     mov     r0,29h                                  
0801FF7E 7008     strb    r0,[r1]                                 
0801FF80 E042     b       8020008h                                
0801FF82 0000     lsl     r0,r0,0h                                
0801FF84 4FBC     ldr     r7,=80203CCh                            
0801FF86 082D     lsr     r5,r5,20h                               
0801FF88 1C19     mov     r1,r3                                   
0801FF8A 3122     add     r1,22h                                  
0801FF8C 2005     mov     r0,5h                                   
0801FF8E 7008     strb    r0,[r1]                                 
0801FF90 4808     ldr     r0,=82D50ECh                            
0801FF92 6198     str     r0,[r3,18h]                             
0801FF94 3105     add     r1,5h                                   
0801FF96 2008     mov     r0,8h                                   
0801FF98 7008     strb    r0,[r1]                                 
0801FF9A 1C18     mov     r0,r3                                   
0801FF9C 3028     add     r0,28h                                  
0801FF9E 7005     strb    r5,[r0]                                 
0801FFA0 3102     add     r1,2h                                   
0801FFA2 2018     mov     r0,18h                                  
0801FFA4 7008     strb    r0,[r1]                                 
0801FFA6 3905     sub     r1,5h                                   
0801FFA8 202B     mov     r0,2Bh                                  
0801FFAA 7008     strb    r0,[r1]                                 
0801FFAC 3108     add     r1,8h                                   
0801FFAE 2060     mov     r0,60h                                  
0801FFB0 7008     strb    r0,[r1]                                 
0801FFB2 E029     b       8020008h                                
0801FFB4 50EC     str     r4,[r5,r3]                              
0801FFB6 082D     lsr     r5,r5,20h                               
0801FFB8 1C19     mov     r1,r3                                   
0801FFBA 3122     add     r1,22h                                  
0801FFBC 7008     strb    r0,[r1]                                 
0801FFBE 1C18     mov     r0,r3                                   
0801FFC0 3027     add     r0,27h                                  
0801FFC2 2220     mov     r2,20h                                  
0801FFC4 7002     strb    r2,[r0]                                 
0801FFC6 3106     add     r1,6h                                   
0801FFC8 2040     mov     r0,40h                                  
0801FFCA 7008     strb    r0,[r1]                                 
0801FFCC 1C18     mov     r0,r3                                   
0801FFCE 3029     add     r0,29h                                  
0801FFD0 7002     strb    r2,[r0]                                 
0801FFD2 3904     sub     r1,4h                                   
0801FFD4 2043     mov     r0,43h                                  
0801FFD6 7008     strb    r0,[r1]                                 
0801FFD8 4905     ldr     r1,=30001ACh                            
0801FFDA 00E0     lsl     r0,r4,3h                                
0801FFDC 1B00     sub     r0,r0,r4                                
0801FFDE 00C0     lsl     r0,r0,3h                                
0801FFE0 1840     add     r0,r0,r1                                
0801FFE2 3024     add     r0,24h                                  
0801FFE4 7800     ldrb    r0,[r0]                                 
0801FFE6 2828     cmp     r0,28h                                  
0801FFE8 D106     bne     801FFF8h                                
0801FFEA 4802     ldr     r0,=82D4E44h                            
0801FFEC 6198     str     r0,[r3,18h]                             
0801FFEE E00B     b       8020008h                                
0801FFF0 01AC     lsl     r4,r5,6h                                
0801FFF2 0300     lsl     r0,r0,0Ch                               
0801FFF4 4E44     ldr     r6,=82D5024h                            
0801FFF6 082D     lsr     r5,r5,20h                               
0801FFF8 4801     ldr     r0,=82D4E04h                            
0801FFFA 6198     str     r0,[r3,18h]                             
0801FFFC E004     b       8020008h                                
0801FFFE 0000     lsl     r0,r0,0h                                
08020000 4E04     ldr     r6,=48054904h                           
08020002 082D     lsr     r5,r5,20h                               
08020004 2000     mov     r0,0h                                   
08020006 8018     strh    r0,[r3]                                 
08020008 BC30     pop     r4,r5                                   
0802000A BC01     pop     r0                                      
0802000C 4700     bx      r0                                      
0802000E 0000     lsl     r0,r0,0h                                
08020010 4770     bx      r14                                     
08020012 0000     lsl     r0,r0,0h                                
08020014 4904     ldr     r1,=3000738h                            
08020016 4805     ldr     r0,=82D4E14h                            
08020018 6188     str     r0,[r1,18h]                             
0802001A 2000     mov     r0,0h                                   
0802001C 7708     strb    r0,[r1,1Ch]                             
0802001E 82C8     strh    r0,[r1,16h]                             
08020020 3124     add     r1,24h                                  
08020022 2045     mov     r0,45h                                  
08020024 7008     strb    r0,[r1]                                 
08020026 4770     bx      r14                                     
08020028 0738     lsl     r0,r7,1Ch                               
0802002A 0300     lsl     r0,r0,0Ch                               
0802002C 4E14     ldr     r6,=3000738h                            
0802002E 082D     lsr     r5,r5,20h                               
08020030 B500     push    r14                                     
08020032 F7EFFDC9 bl      800FBC8h                                
08020036 2800     cmp     r0,0h                                   
08020038 D009     beq     802004Eh                                
0802003A 4906     ldr     r1,=3000738h                            
0802003C 1C0A     mov     r2,r1                                   
0802003E 3224     add     r2,24h                                  
08020040 2300     mov     r3,0h                                   
08020042 2043     mov     r0,43h                                  
08020044 7010     strb    r0,[r2]                                 
08020046 4804     ldr     r0,=82D4E44h                            
08020048 6188     str     r0,[r1,18h]                             
0802004A 770B     strb    r3,[r1,1Ch]                             
0802004C 82CB     strh    r3,[r1,16h]                             
0802004E BC01     pop     r0                                      
08020050 4700     bx      r0                                      
08020052 0000     lsl     r0,r0,0h                                
08020054 0738     lsl     r0,r7,1Ch                               
08020056 0300     lsl     r0,r0,0Ch                               
08020058 4E44     ldr     r6,=2B000C03h                           
0802005A 082D     lsr     r5,r5,20h                               
0802005C B500     push    r14                                     
0802005E 4908     ldr     r1,=3000738h                            
08020060 4808     ldr     r0,=82D4E54h                            
08020062 6188     str     r0,[r1,18h]                             
08020064 2000     mov     r0,0h                                   
08020066 7708     strb    r0,[r1,1Ch]                             
08020068 82C8     strh    r0,[r1,16h]                             
0802006A 3124     add     r1,24h                                  
0802006C 2047     mov     r0,47h                                  
0802006E 7008     strb    r0,[r1]                                 
08020070 4905     ldr     r1,=30013D4h                            
08020072 2001     mov     r0,1h                                   
08020074 7288     strb    r0,[r1,0Ah]                             
08020076 4805     ldr     r0,=115h                                
08020078 F7E2FCCE bl      8002A18h                                
0802007C BC01     pop     r0                                      
0802007E 4700     bx      r0                                      
08020080 0738     lsl     r0,r7,1Ch                               
08020082 0300     lsl     r0,r0,0Ch                               
08020084 4E54     ldr     r6,=80082000h                           
08020086 082D     lsr     r5,r5,20h                               
08020088 13D4     asr     r4,r2,0Fh                               
0802008A 0300     lsl     r0,r0,0Ch                               
0802008C 0115     lsl     r5,r2,4h                                
0802008E 0000     lsl     r0,r0,0h                                
08020090 B500     push    r14                                     
08020092 F7EFFD99 bl      800FBC8h                                
08020096 2800     cmp     r0,0h                                   
08020098 D009     beq     80200AEh                                
0802009A 4906     ldr     r1,=3000738h                            
0802009C 1C0A     mov     r2,r1                                   
0802009E 3224     add     r2,24h                                  
080200A0 2300     mov     r3,0h                                   
080200A2 2043     mov     r0,43h                                  
080200A4 7010     strb    r0,[r2]                                 
080200A6 4804     ldr     r0,=82D4E04h                            
080200A8 6188     str     r0,[r1,18h]                             
080200AA 770B     strb    r3,[r1,1Ch]                             
080200AC 82CB     strh    r3,[r1,16h]                             
080200AE BC01     pop     r0                                      
080200B0 4700     bx      r0                                      
080200B2 0000     lsl     r0,r0,0h                                
080200B4 0738     lsl     r0,r7,1Ch                               
080200B6 0300     lsl     r0,r0,0Ch                               
080200B8 4E04     ldr     r6,=24003124h                           
080200BA 082D     lsr     r5,r5,20h                               
080200BC B530     push    r4,r5,r14                               
080200BE B083     add     sp,-0Ch                                 
080200C0 F7EFFD82 bl      800FBC8h                                
080200C4 2800     cmp     r0,0h                                   
080200C6 D019     beq     80200FCh                                
080200C8 4D0E     ldr     r5,=3000738h                            
080200CA 1C29     mov     r1,r5                                   
080200CC 3124     add     r1,24h                                  
080200CE 2400     mov     r4,0h                                   
080200D0 2023     mov     r0,23h                                  
080200D2 7008     strb    r0,[r1]                                 
080200D4 480C     ldr     r0,=82D5024h                            
080200D6 61A8     str     r0,[r5,18h]                             
080200D8 772C     strb    r4,[r5,1Ch]                             
080200DA 82EC     strh    r4,[r5,16h]                             
080200DC 7FEA     ldrb    r2,[r5,1Fh]                             
080200DE 1C28     mov     r0,r5                                   
080200E0 3023     add     r0,23h                                  
080200E2 7803     ldrb    r3,[r0]                                 
080200E4 8868     ldrh    r0,[r5,2h]                              
080200E6 9000     str     r0,[sp]                                 
080200E8 88A8     ldrh    r0,[r5,4h]                              
080200EA 9001     str     r0,[sp,4h]                              
080200EC 9402     str     r4,[sp,8h]                              
080200EE 200D     mov     r0,0Dh                                  
080200F0 2101     mov     r1,1h                                   
080200F2 F7EEF8B1 bl      800E258h                                
080200F6 1C29     mov     r1,r5                                   
080200F8 312D     add     r1,2Dh                                  
080200FA 7008     strb    r0,[r1]                                 
080200FC B003     add     sp,0Ch                                  
080200FE BC30     pop     r4,r5                                   
08020100 BC01     pop     r0                                      
08020102 4700     bx      r0                                      
08020104 0738     lsl     r0,r7,1Ch                               
08020106 0300     lsl     r0,r0,0Ch                               
08020108 5024     str     r4,[r4,r0]                              
0802010A 082D     lsr     r5,r5,20h                               
0802010C B510     push    r4,r14                                  
0802010E B083     add     sp,-0Ch                                 
08020110 4811     ldr     r0,=3000738h                            
08020112 4684     mov     r12,r0                                  
08020114 302D     add     r0,2Dh                                  
08020116 7800     ldrb    r0,[r0]                                 
08020118 4A10     ldr     r2,=30001ACh                            
0802011A 00C1     lsl     r1,r0,3h                                
0802011C 1A09     sub     r1,r1,r0                                
0802011E 00C9     lsl     r1,r1,3h                                
08020120 1889     add     r1,r1,r2                                
08020122 880C     ldrh    r4,[r1]                                 
08020124 2C00     cmp     r4,0h                                   
08020126 D113     bne     8020150h                                
08020128 4661     mov     r1,r12                                  
0802012A 3124     add     r1,24h                                  
0802012C 2025     mov     r0,25h                                  
0802012E 7008     strb    r0,[r1]                                 
08020130 2078     mov     r0,78h                                  
08020132 4661     mov     r1,r12                                  
08020134 80C8     strh    r0,[r1,6h]                              
08020136 7FCA     ldrb    r2,[r1,1Fh]                             
08020138 4660     mov     r0,r12                                  
0802013A 3023     add     r0,23h                                  
0802013C 7803     ldrb    r3,[r0]                                 
0802013E 8848     ldrh    r0,[r1,2h]                              
08020140 9000     str     r0,[sp]                                 
08020142 8888     ldrh    r0,[r1,4h]                              
08020144 9001     str     r0,[sp,4h]                              
08020146 9402     str     r4,[sp,8h]                              
08020148 200D     mov     r0,0Dh                                  
0802014A 2102     mov     r1,2h                                   
0802014C F7EEF884 bl      800E258h                                
08020150 B003     add     sp,0Ch                                  
08020152 BC10     pop     r4                                      
08020154 BC01     pop     r0                                      
08020156 4700     bx      r0                                      
08020158 0738     lsl     r0,r7,1Ch                               
0802015A 0300     lsl     r0,r0,0Ch                               
0802015C 01AC     lsl     r4,r5,6h                                
0802015E 0300     lsl     r0,r0,0Ch                               
08020160 B500     push    r14                                     
08020162 4A09     ldr     r2,=3000738h                            
08020164 88D0     ldrh    r0,[r2,6h]                              
08020166 3801     sub     r0,1h                                   
08020168 80D0     strh    r0,[r2,6h]                              
0802016A 0400     lsl     r0,r0,10h                               
0802016C 0C03     lsr     r3,r0,10h                               
0802016E 2B00     cmp     r3,0h                                   
08020170 D108     bne     8020184h                                
08020172 1C11     mov     r1,r2                                   
08020174 3124     add     r1,24h                                  
08020176 2027     mov     r0,27h                                  
08020178 7008     strb    r0,[r1]                                 
0802017A 4804     ldr     r0,=82D5064h                            
0802017C 6190     str     r0,[r2,18h]                             
0802017E 2000     mov     r0,0h                                   
08020180 7710     strb    r0,[r2,1Ch]                             
08020182 82D3     strh    r3,[r2,16h]                             
08020184 BC01     pop     r0                                      
08020186 4700     bx      r0                                      
08020188 0738     lsl     r0,r7,1Ch                               
0802018A 0300     lsl     r0,r0,0Ch                               
0802018C 5064     str     r4,[r4,r1]                              
0802018E 082D     lsr     r5,r5,20h                               
08020190 B500     push    r14                                     
08020192 F7EFFD19 bl      800FBC8h                                
08020196 2800     cmp     r0,0h                                   
08020198 D012     beq     80201C0h                                
0802019A 480A     ldr     r0,=3000738h                            
0802019C 2100     mov     r1,0h                                   
0802019E 8001     strh    r1,[r0]                                 
080201A0 4A09     ldr     r2,=30001ACh                            
080201A2 3023     add     r0,23h                                  
080201A4 7801     ldrb    r1,[r0]                                 
080201A6 00C8     lsl     r0,r1,3h                                
080201A8 1A40     sub     r0,r0,r1                                
080201AA 00C0     lsl     r0,r0,3h                                
080201AC 1880     add     r0,r0,r2                                
080201AE 302F     add     r0,2Fh                                  
080201B0 7801     ldrb    r1,[r0]                                 
080201B2 00C8     lsl     r0,r1,3h                                
080201B4 1A40     sub     r0,r0,r1                                
080201B6 00C0     lsl     r0,r0,3h                                
080201B8 1880     add     r0,r0,r2                                
080201BA 3024     add     r0,24h                                  
080201BC 2146     mov     r1,46h                                  
080201BE 7001     strb    r1,[r0]                                 
080201C0 BC01     pop     r0                                      
080201C2 4700     bx      r0                                      
080201C4 0738     lsl     r0,r7,1Ch                               
080201C6 0300     lsl     r0,r0,0Ch                               
080201C8 01AC     lsl     r4,r5,6h                                
080201CA 0300     lsl     r0,r0,0Ch                               
080201CC B500     push    r14                                     
080201CE F7EFFCFB bl      800FBC8h                                
080201D2 2800     cmp     r0,0h                                   
080201D4 D002     beq     80201DCh                                
080201D6 4902     ldr     r1,=3000738h                            
080201D8 2000     mov     r0,0h                                   
080201DA 8008     strh    r0,[r1]                                 
080201DC BC01     pop     r0                                      
080201DE 4700     bx      r0                                      
080201E0 0738     lsl     r0,r7,1Ch                               
080201E2 0300     lsl     r0,r0,0Ch                               
080201E4 B510     push    r4,r14                                  
080201E6 4B0E     ldr     r3,=3000738h                            
080201E8 8858     ldrh    r0,[r3,2h]                              
080201EA 3804     sub     r0,4h                                   
080201EC 8058     strh    r0,[r3,2h]                              
080201EE 1C19     mov     r1,r3                                   
080201F0 312C     add     r1,2Ch                                  
080201F2 7808     ldrb    r0,[r1]                                 
080201F4 3801     sub     r0,1h                                   
080201F6 7008     strb    r0,[r1]                                 
080201F8 0600     lsl     r0,r0,18h                               
080201FA 0E04     lsr     r4,r0,18h                               
080201FC 2C00     cmp     r4,0h                                   
080201FE D10B     bne     8020218h                                
08020200 4A08     ldr     r2,=30001ACh                            
08020202 1C18     mov     r0,r3                                   
08020204 3023     add     r0,23h                                  
08020206 7801     ldrb    r1,[r0]                                 
08020208 00C8     lsl     r0,r1,3h                                
0802020A 1A40     sub     r0,r0,r1                                
0802020C 00C0     lsl     r0,r0,3h                                
0802020E 1880     add     r0,r0,r2                                
08020210 3024     add     r0,24h                                  
08020212 2145     mov     r1,45h                                  
08020214 7001     strb    r1,[r0]                                 
08020216 801C     strh    r4,[r3]                                 
08020218 BC10     pop     r4                                      
0802021A BC01     pop     r0                                      
0802021C 4700     bx      r0                                      

;主程序                              
08020228 B500     push    r14                                     
0802022A 4807     ldr     r0,=3000738h                            
0802022C 1C02     mov     r2,r0                                   
0802022E 3226     add     r2,26h                                  
08020230 2101     mov     r1,1h                                   
08020232 7011     strb    r1,[r2]        ;300075e写入1                              
08020234 3024     add     r0,24h                                  
08020236 7800     ldrb    r0,[r0]                                 
08020238 284B     cmp     r0,4Bh                                  
0802023A D900     bls     @@Pass                                
0802023C E0C6     b       @@end

@@Pass:                                
0802023E 0080     lsl     r0,r0,2h                                
08020240 4902     ldr     r1,=8020250h   ;PoseTable                          
08020242 1840     add     r0,r0,r1                                
08020244 6800     ldr     r0,[r0]                                 
08020246 4687     mov     r15,r0                                  

PoseTable:                               
    .word 8020380h   ;00
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 8020386h   ;09
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch    
	.word 802038ch   ;23h
	.word 80203cch
	.word 8020392h   ;25h
	.word 80203cch
	.word 8020398h   ;27h
	.word 802039eh   ;28h
	.word 80203a4h   ;29h
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203cch .word 80203cch .word 80203cch .word 80203cch
	.word 80203aah   ;42h
	.word 80203b0h   ;43h
	.word 80203cch
	.word 80203b6h   ;45h
	.word 80203cch
	.word 80203bch   ;47h
	.word 80203cch
	.word 80203c2h   ;49h
	.word 80203cch  
	.word 80203c8h   ;4bh
    	
08020380 F7FFFB32 bl      801F9E8h   ;00                             
08020384 E022     b       80203CCh                                
08020386 F7FFFBC3 bl      801FB10h   ;09h                              
0802038A E01F     b       80203CCh                                
0802038C F7FFFBEC bl      801FB68h   ;23h                               
08020390 E01C     b       80203CCh                                
08020392 F7FFFBFF bl      801FB94h   ;25h                             
08020396 E019     b       80203CCh                                
08020398 F7FFFC3C bl      801FC14h   ;27h                             
0802039C E016     b       80203CCh                                
0802039E F7FFFC51 bl      801FC44h   ;28h                             
080203A2 E013     b       80203CCh                                
080203A4 F7FFFC68 bl      801FC78h   ;29h                             
080203A8 E010     b       80203CCh                                
080203AA F7FFFC81 bl      801FCB0h   ;42h                             
080203AE E00D     b       80203CCh                                
080203B0 F7FFFCE6 bl      801FD80h   ;43h                             
080203B4 E00A     b       80203CCh                                
080203B6 F7FFFD03 bl      801FDC0h   ;45h                             
080203BA E007     b       80203CCh                                
080203BC F7FFFD22 bl      801FE04h   ;47h                             
080203C0 E004     b       80203CCh                                
080203C2 F7FFFD41 bl      801FE48h   ;49h                             
080203C6 E001     b       80203CCh                                
080203C8 F7FFFD5A bl      801FE80h   ;4bh

@@end:                               
080203CC BC01     pop     r0                                      
080203CE 4700     bx      r0  

                                    
080203D0 B500     push    r14                                     
080203D2 4807     ldr     r0,=3000738h                            
080203D4 1C02     mov     r2,r0                                   
080203D6 3226     add     r2,26h                                  
080203D8 2101     mov     r1,1h                                   
080203DA 7011     strb    r1,[r2]                                 
080203DC 3024     add     r0,24h                                  
080203DE 7800     ldrb    r0,[r0]                                 
080203E0 2847     cmp     r0,47h                                  
080203E2 D900     bls     80203E6h                                
080203E4 E0BB     b       802055Eh                                
080203E6 0080     lsl     r0,r0,2h                                


