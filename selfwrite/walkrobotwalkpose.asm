0802F968 B530     push    r4,r5,r14                               
0802F96A F7DFFE13 bl      800F594h     ;斜坡上检查                           
0802F96E 4817     ldr     r0,=30007F0h                            
0802F970 7800     ldrb    r0,[r0]                                 
0802F972 2800     cmp     r0,0h                                   
0802F974 D13A     bne     @@OnSlopeOrFloor
;---------------------未在斜坡上                                
0802F976 4C16     ldr     r4,=3000738h                            
0802F978 8860     ldrh    r0,[r4,2h]                              
0802F97A 88A1     ldrh    r1,[r4,4h]                              
0802F97C 3120     add     r1,20h                                  
0802F97E F7DFFECF bl      800F720h     ;检查右半身下方                             
0802F982 2800     cmp     r0,0h                                   
0802F984 D132     bne     @@OnSlopeOrFloor 
;---------------------右半身下方空                               
0802F986 8860     ldrh    r0,[r4,2h]                              
0802F988 88A1     ldrh    r1,[r4,4h]                              
0802F98A 3920     sub     r1,20h                                  
0802F98C F7DFFEC8 bl      800F720h     ;检查左半身下方                              
0802F990 1C02     mov     r2,r0                                   
0802F992 2A00     cmp     r2,0h                                   
0802F994 D12A     bne     @@OnSlopeOrFloor    
;---------------------下方空                            
0802F996 1C20     mov     r0,r4                                   
0802F998 3024     add     r0,24h                                  
0802F99A 211E     mov     r1,1Eh                                  
0802F99C 7001     strb    r1,[r0]      ;写入落下的pose                            
0802F99E 1C21     mov     r1,r4                                   
0802F9A0 312D     add     r1,2Dh                                  
0802F9A2 7808     ldrb    r0,[r1]      ;检查推力值是否为0                           
0802F9A4 2800     cmp     r0,0h                                   
0802F9A6 D100     bne     @@ThrustNoZero                                
0802F9A8 E104     b       @@end  
;---------------------推力值不为0
@@ThrustNoZero:                                                    
0802F9AA 700A     strb    r2,[r1]                                 
0802F9AC 8821     ldrh    r1,[r4]                                 
0802F9AE 2040     mov     r0,40h                                  
0802F9B0 4008     and     r0,r1                                   
0802F9B2 2800     cmp     r0,0h         ;检查面向                         
0802F9B4 D00E     beq     @@FaceLeft    ;面左跳转 
;-------------------------------面右                            
0802F9B6 2280     mov     r2,80h                                  
0802F9B8 0092     lsl     r2,r2,2h                                
0802F9BA 1C10     mov     r0,r2                                   
0802F9BC 4008     and     r0,r1                                   
0802F9BE 2800     cmp     r0,0h                                   
0802F9C0 D000     beq     @@CorrectTag  ;如果标记反                             
0802F9C2 E0F7     b       @@end  

@@CorrectTag:                              
0802F9C4 1C10     mov     r0,r2                                   
0802F9C6 4308     orr     r0,r1                                   
0802F9C8 8020     strh    r0,[r4]       ;再次更正                             
0802F9CA E0F3     b       @@end                                

@@FaceLeft:                             
0802F9D4 2080     mov     r0,80h                                  
0802F9D6 0080     lsl     r0,r0,2h                                
0802F9D8 4008     and     r0,r1                                   
0802F9DA 2800     cmp     r0,0h                                   
0802F9DC D100     bne     @@CorrectTag1  ;标记反                               
0802F9DE E0E9     b       @@end  

@@CorrectTag1:                              
0802F9E0 4801     ldr     r0,=0FDFFh                              
0802F9E2 4008     and     r0,r1                                   
0802F9E4 8020     strh    r0,[r4]        ;更正                           
0802F9E6 E0E5     b       @@end   
                              
;-----------------------在地面或斜坡上的情况
@@OnSlopeOrFloor:                             
0802F9EC 2501     mov     r5,1h                                   
0802F9EE F7FFFEA1 bl      802F734h       ;检查是否被导弹击中                           
0802F9F2 4A11     ldr     r2,=3000738h                            
0802F9F4 1C10     mov     r0,r2                                   
0802F9F6 302D     add     r0,2Dh                                  
0802F9F8 7800     ldrb    r0,[r0]        ;检查推力值                            
0802F9FA 2800     cmp     r0,0h                                   
0802F9FC D04A     beq     @@NoThrust  
;--------------------------------------;有推力                             
0802F9FE 8811     ldrh    r1,[r2]                                 
0802FA00 2002     mov     r0,2h                                   
0802FA02 4008     and     r0,r1                                   
0802FA04 2800     cmp     r0,0h           ;检查是否在视野                           
0802FA06 D00A     beq     @@PassPlaySound ;不在跳过                               
0802FA08 8AD1     ldrh    r1,[r2,16h]                             
0802FA0A 2003     mov     r0,3h           ;检查动画是否被3整除                        
0802FA0C 4008     and     r0,r1                                   
0802FA0E 2803     cmp     r0,3h                                   
0802FA10 D105     bne     @@PassPlaySound ;不能跳过                               
0802FA12 7F10     ldrb    r0,[r2,1Ch]     ;检查动画帧是否是6                        
0802FA14 2806     cmp     r0,6h                                   
0802FA16 D102     bne     @@PassPlaySound ;不是跳过                               
0802FA18 4808     ldr     r0,=26Eh        ;播放脚步声                        
0802FA1A F7D3F881 bl      8002B20h     

@@PassPlaySound:                              
0802FA1E 4806     ldr     r0,=3000738h                            
0802FA20 7F01     ldrb    r1,[r0,1Ch]     ;动画帧加4再写入                        
0802FA22 3104     add     r1,4h           ;相当于提升动画帧的结束                        
0802FA24 7701     strb    r1,[r0,1Ch]                             
0802FA26 1C01     mov     r1,r0                                   
0802FA28 312D     add     r1,2Dh                                  
0802FA2A 7809     ldrb    r1,[r1]                                 
0802FA2C 088D     lsr     r5,r1,2h        ;推力值除以4                        
0802FA2E 1C03     mov     r3,r0                                   
0802FA30 2D08     cmp     r5,8h                                   
0802FA32 D905     bls     @@ThrustLessThan32  ;如果推理值小于32                                
0802FA34 2508     mov     r5,8h                                   
0802FA36 E006     b       @@Peer                                

@@ThrustLessThan32:                               
0802FA40 2D00     cmp     r5,0h           ;比较是否小于4                            
0802FA42 D100     bne     @@Peer                                
0802FA44 2501     mov     r5,1h           ;小于4则移动为1

@@Peer:                                 
0802FA46 1C19     mov     r1,r3                                   
0802FA48 1C0A     mov     r2,r1                                   
0802FA4A 322D     add     r2,2Dh                                  
0802FA4C 7810     ldrb    r0,[r2]                                 
0802FA4E 3801     sub     r0,1h           ;推力值减1再写入                             
0802FA50 7010     strb    r0,[r2]                                 
0802FA52 0600     lsl     r0,r0,18h                               
0802FA54 2800     cmp     r0,0h                                   
0802FA56 D13B     bne     @@ThrustBigThan1 ;原推力值大于1
;--------------------------------原推力值等于1,以下为更正推力标记                                
0802FA58 880A     ldrh    r2,[r1]                                 
0802FA5A 2040     mov     r0,40h                                  
0802FA5C 4010     and     r0,r2                                   
0802FA5E 2800     cmp     r0,0h                                   
0802FA60 D009     beq     @@FaceLeft2                               
0802FA62 2380     mov     r3,80h                                  
0802FA64 009B     lsl     r3,r3,2h                                
0802FA66 1C18     mov     r0,r3                                   
0802FA68 4010     and     r0,r2                                   
0802FA6A 2800     cmp     r0,0h                                   
0802FA6C D10C     bne     @@Peer2                                
0802FA6E 1C18     mov     r0,r3                                   
0802FA70 4310     orr     r0,r2                                   
0802FA72 8008     strh    r0,[r1]                                 
0802FA74 E008     b       @@Peer2 

@@FaceLeft2:                               
0802FA76 2080     mov     r0,80h                                  
0802FA78 0080     lsl     r0,r0,2h                                
0802FA7A 4010     and     r0,r2                                   
0802FA7C 2800     cmp     r0,0h                                   
0802FA7E D002     beq     @@NoTag                                
0802FA80 4803     ldr     r0,=0FDFFh                              
0802FA82 4010     and     r0,r2                                   
0802FA84 8008     strh    r0,[r1]

@@NoTag:                                 
0802FA86 1C19     mov     r1,r3   

@@Peer2:                                
0802FA88 3124     add     r1,24h                                  
0802FA8A 200E     mov     r0,0Eh                                  
0802FA8C 7008     strb    r0,[r1]                                 
0802FA8E E091     b       @@end                                

@@NoThrust: 
;-----------------------以下为给予脚步声以及检查是否顶到samus停止                             
0802FA94 8811     ldrh    r1,[r2]                                 
0802FA96 2002     mov     r0,2h                                   
0802FA98 4008     and     r0,r1                                   
0802FA9A 2800     cmp     r0,0h                                   
0802FA9C D00A     beq     @@PassPlaySound2                                
0802FA9E 8AD1     ldrh    r1,[r2,16h]                             
0802FAA0 2003     mov     r0,3h                                   
0802FAA2 4008     and     r0,r1                                   
0802FAA4 2803     cmp     r0,3h                                   
0802FAA6 D105     bne     @@PassPlaySound2                                
0802FAA8 7F10     ldrb    r0,[r2,1Ch]                             
0802FAAA 2808     cmp     r0,8h                                   
0802FAAC D102     bne     @@PassPlaySound2                                
0802FAAE 4806     ldr     r0,=26Eh                                
0802FAB0 F7D3F836 bl      8002B20h 

@@PassPlaySound2:                               
0802FAB4 F7FFFD3E bl      802F534h     ;检查金桶是否顶到samus                           
0802FAB8 0600     lsl     r0,r0,18h                               
0802FABA 2800     cmp     r0,0h                                   
0802FABC D008     beq     @@ThrustBigThan1;没有顶到                               
0802FABE 4803     ldr     r0,=3000738h                            
0802FAC0 3024     add     r0,24h                                  
0802FAC2 210A     mov     r1,0Ah                                  
0802FAC4 7001     strb    r1,[r0]                                 
0802FAC6 E075     b       @@end                                

@@ThrustBigThan1:   
;----------------推力值不为0也不为1或普通移动没有顶到人                          
0802FAD0 4C18     ldr     r4,=3000738h                            
0802FAD2 8821     ldrh    r1,[r4]                                 
0802FAD4 2080     mov     r0,80h                                  
0802FAD6 0080     lsl     r0,r0,2h                                
0802FAD8 4008     and     r0,r1                                   
0802FADA 2800     cmp     r0,0h                                   
0802FADC D030     beq     @@ThrustToLeft ;推力向左 

;------------------------------推力向右的移动                               
0802FADE 4816     ldr     r0,=30007F0h                            
0802FAE0 7801     ldrb    r1,[r0]                                 
0802FAE2 20F0     mov     r0,0F0h                                 
0802FAE4 4008     and     r0,r1                                   
0802FAE6 2800     cmp     r0,0h                                   
0802FAE8 D016     beq     @@OnSlope      ;不在平地?  

;------------------------------非斜坡                             
0802FAEA 1C20     mov     r0,r4                                   
0802FAEC 302D     add     r0,2Dh                                  
0802FAEE 7800     ldrb    r0,[r0]                                 
0802FAF0 2800     cmp     r0,0h                                   
0802FAF2 D106     bne     @@HaveThrustRightMoveCheck 

;------------------------------没有推力的向右移动                               
0802FAF4 8860     ldrh    r0,[r4,2h]                              
0802FAF6 88A1     ldrh    r1,[r4,4h]                              
0802FAF8 3120     add     r1,20h                                  
0802FAFA F7DFFE11 bl      800F720h      ;检查右半身下方地面                          
0802FAFE 2800     cmp     r0,0h                                   
0802FB00 D040     beq     @@NoThrustMoveNoFloor

@@HaveThrustRightMoveCheck:
;-----------------------有推力移动或无推力有地面右移动检查                                
0802FB02 4C0C     ldr     r4,=3000738h                            
0802FB04 8860     ldrh    r0,[r4,2h]                              
0802FB06 3848     sub     r0,48h                                  
0802FB08 88A1     ldrh    r1,[r4,4h]                              
0802FB0A 3128     add     r1,28h                                  
0802FB0C F7DFFE08 bl      800F720h     ;检查前方上一格是否有砖                           
0802FB10 0600     lsl     r0,r0,18h                               
0802FB12 0E00     lsr     r0,r0,18h                               
0802FB14 2800     cmp     r0,11h                                   
0802FB16 D030     beq     @@MoveToBlock ;有砖跳转 

@@OnSlope:                               
0802FB18 4906     ldr     r1,=3000738h                            
0802FB1A 8888     ldrh    r0,[r1,4h]                              
0802FB1C 1828     add     r0,r5,r0     ;X坐标加上移动值再写入                           
0802FB1E 8088     strh    r0,[r1,4h]                              
0802FB20 8809     ldrh    r1,[r1]                                 
0802FB22 2080     mov     r0,80h                                  
0802FB24 0140     lsl     r0,r0,5h                                
0802FB26 4008     and     r0,r1        ;检查人是否站在敌人身上                           
0802FB28 2800     cmp     r0,0h                                   
0802FB2A D043     beq     @@end                                
0802FB2C 4903     ldr     r1,=30013D4h                            
0802FB2E 8A48     ldrh    r0,[r1,12h]  ;人物坐标同样加上移动值                           
0802FB30 1828     add     r0,r5,r0                                
0802FB32 E03E     b       @@WriteSamusOnWalkRobotMove                                

@@ThrustToLeft:  
;--------------------------推力标记向左或普通移动向左                            
0802FB40 4813     ldr     r0,=30007F0h                            
0802FB42 7801     ldrb    r1,[r0]                                 
0802FB44 20F0     mov     r0,0F0h                                 
0802FB46 4008     and     r0,r1                                   
0802FB48 2800     cmp     r0,0h                                   
0802FB4A D025     beq     @@OnSlope2                                
0802FB4C 1C20     mov     r0,r4                                   
0802FB4E 302D     add     r0,2Dh                                  
0802FB50 7800     ldrb    r0,[r0]      ;读取推力值                             
0802FB52 2800     cmp     r0,0h                                   
0802FB54 D106     bne     @@HaveThrustLeftMoveCheck                                
0802FB56 8860     ldrh    r0,[r4,2h]                              
0802FB58 88A1     ldrh    r1,[r4,4h]                              
0802FB5A 3920     sub     r1,20h                                  
0802FB5C F7DFFDE0 bl      800F720h                                
0802FB60 2800     cmp     r0,0h                                   
0802FB62 D00F     beq     @@NoThrustMoveNoFloor  

@@HaveThrustLeftMoveCheck: 
;------------------------检查左边移动上一格的砖块                             
0802FB64 4C0B     ldr     r4,=3000738h                            
0802FB66 8860     ldrh    r0,[r4,2h]                              
0802FB68 3848     sub     r0,48h                                  
0802FB6A 88A1     ldrh    r1,[r4,4h]                              
0802FB6C 3928     sub     r1,28h                                  
0802FB6E F7DFFDD7 bl      800F720h                                
0802FB72 0600     lsl     r0,r0,18h                               
0802FB74 0E00     lsr     r0,r0,18h                               
0802FB76 2811     cmp     r0,11h                                  
0802FB78 D10E     bne     @@OnSlope2 ;没有砖的话 

@@MoveToBlock:
;-------------------前方有砖                              
0802FB7A 1C20     mov     r0,r4                                     
0802FB7C 302D     add     r0,2Dh                                  
0802FB7E 7800     ldrb    r0,[r0]    ;读取推力值                             
0802FB80 2800     cmp     r0,0h      
;---------------------------不为0则结束                             
0802FB82 D117     bne     @@end 

@@NoThrustMoveNoFloor:
;--------------------------没有推力移动时无地板给予的姿势                               
0802FB84 1C21     mov     r1,r4                                   
0802FB86 3124     add     r1,24h                                  
0802FB88 200A     mov     r0,0Ah                                  
0802FB8A 7008     strb    r0,[r1]                                 
0802FB8C E012     b       @@end                                

@@OnSlope2:                               
0802FB98 4908     ldr     r1,=3000738h                            
0802FB9A 8888     ldrh    r0,[r1,4h]      ;X坐标减去移动值                        
0802FB9C 1B40     sub     r0,r0,r5                                
0802FB9E 8088     strh    r0,[r1,4h]                              
0802FBA0 8809     ldrh    r1,[r1]                                 
0802FBA2 2080     mov     r0,80h                                  
0802FBA4 0140     lsl     r0,r0,5h                                
0802FBA6 4008     and     r0,r1           ;检查人物是否踩在金桶上                          
0802FBA8 2800     cmp     r0,0h                                   
0802FBAA D003     beq     @@end                                
0802FBAC 4904     ldr     r1,=30013D4h                            
0802FBAE 8A48     ldrh    r0,[r1,12h]     ;若踩在上面则给予人物X相同移动                        
0802FBB0 1B40     sub     r0,r0,r5  

@@WriteSamusOnWalkRobotMove:                              
0802FBB2 8248     strh    r0,[r1,12h]

@@end:                             
0802FBB4 BC30     pop     r4,r5                                   
0802FBB6 BC01     pop     r0                                      
0802FBB8 4700     bx      r0  

