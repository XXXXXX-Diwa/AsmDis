
;pose 0
08049EB8 B570     push    r4-r6,r14                               
08049EBA B083     add     sp,-0Ch                                 
08049EBC 4C07     ldr     r4,=3000738h                            
08049EBE 7F60     ldrb    r0,[r4,1Dh]                             
08049EC0 28AD     cmp     r0,0ADh                                 
08049EC2 D10D     bne     @@NoAD                                
08049EC4 2003     mov     r0,3h                                   
08049EC6 211D     mov     r1,1Dh                                  
08049EC8 F016FCF8 bl      80608BCh       ;检查事件1D                             
08049ECC 2800     cmp     r0,0h                                   
08049ECE D10F     bne     @@EventActivation                                
08049ED0 8821     ldrh    r1,[r4]                                 
08049ED2 2010     mov     r0,10h                                  
08049ED4 4308     orr     r0,r1          ;取向 orr 10                         
08049ED6 8020     strh    r0,[r4]                                 
08049ED8 E00D     b       @@Peer                                

@@NoAD:                             
08049EE0 28AE     cmp     r0,0AEh                                 
08049EE2 D108     bne     @@Peer                                
08049EE4 2003     mov     r0,3h                                   
08049EE6 2124     mov     r1,24h         ;检查事件24h                          
08049EE8 F016FCE8 bl      80608BCh                                
08049EEC 2800     cmp     r0,0h                                   
08049EEE D002     beq     @@Peer 

@@EventActivation:                               
08049EF0 2000     mov     r0,0h                                   
08049EF2 8020     strh    r0,[r4]        ;敌人消失                         
08049EF4 E06C     b       @@end  

@@Peer:                              
08049EF6 4C0B     ldr     r4,=3000738h                            
08049EF8 8821     ldrh    r1,[r4]                                 
08049EFA 2040     mov     r0,40h                                  
08049EFC 4308     orr     r0,r1          ;取向orr40  也就是反向                        
08049EFE 8020     strh    r0,[r4]                                 
08049F00 88A0     ldrh    r0,[r4,4h]     ;X坐标                         
08049F02 300C     add     r0,0Ch         ;向右 Ch                        
08049F04 80A0     strh    r0,[r4,4h]     ;再写入                         
08049F06 8866     ldrh    r6,[r4,2h]                              
08049F08 88A5     ldrh    r5,[r4,4h]                              
08049F0A 1C28     mov     r0,r5                                   
08049F0C 1C31     mov     r1,r6                                   
08049F0E 2200     mov     r2,0h                                   
08049F10 F00DFCFC bl      805790Ch       ;检查是否和门重合,似乎在这里没有用                          
08049F14 8821     ldrh    r1,[r4]                                 
08049F16 2040     mov     r0,40h                                  
08049F18 4008     and     r0,r1                                   
08049F1A 2800     cmp     r0,0h                                   
08049F1C D004     beq     @@Nofaceright                                
08049F1E 1C28     mov     r0,r5                                   
08049F20 3010     add     r0,10h        ;X坐标值向右10h                          
08049F22 E003     b       @@peer2                                

@@Nofaceright:                              
08049F28 1C28     mov     r0,r5                                   
08049F2A 3810     sub     r0,10h        ;或向左10h

@@peer2:                          
08049F2C 0400     lsl     r0,r0,10h                               
08049F2E 0C05     lsr     r5,r0,10h                               
08049F30 4C09     ldr     r4,=3000738h                            
08049F32 7FA1     ldrb    r1,[r4,1Eh]   ;读取序号                            
08049F34 7FE2     ldrb    r2,[r4,1Fh]   ;读取GFXROW                          
08049F36 1C20     mov     r0,r4                                   
08049F38 3023     add     r0,23h                                  
08049F3A 7803     ldrb    r3,[r0]       ;主精灵序号                          
08049F3C 9600     str     r6,[sp]                                 
08049F3E 9501     str     r5,[sp,4h]                              
08049F40 2500     mov     r5,0h                                   
08049F42 9502     str     r5,[sp,8h]                              
08049F44 2036     mov     r0,36h                                  
08049F46 F7C4F987 bl      800E258h      ;生产第二精灵                             
08049F4A 0600     lsl     r0,r0,18h                               
08049F4C 0E00     lsr     r0,r0,18h                               
08049F4E 28FF     cmp     r0,0FFh                                 
08049F50 D104     bne     @@NoCance                               
08049F52 8025     strh    r5,[r4]                                 
08049F54 E03C     b       @@end                                
.pool

@@NoCance:                              
08049F5C 1C21     mov     r1,r4                                    
08049F5E 3124     add     r1,24h                                  
08049F60 2008     mov     r0,8h                                   
08049F62 7008     strb    r0,[r1]       ;pose写入8h                             
08049F64 1C20     mov     r0,r4                                   
08049F66 3027     add     r0,27h                                  
08049F68 2128     mov     r1,28h                                  
08049F6A 7001     strb    r1,[r0]       ;上视野写入28h                          
08049F6C 3001     add     r0,1h                                   
08049F6E 7001     strb    r1,[r0]       ;左右视野写入28h                          
08049F70 1C21     mov     r1,r4                                   
08049F72 3129     add     r1,29h                                  
08049F74 2010     mov     r0,10h                                  
08049F76 7008     strb    r0,[r1]       ;下视野写入10h                          
08049F78 2100     mov     r1,0h                                   
08049F7A 4817     ldr     r0,=0FF88h                              
08049F7C 8160     strh    r0,[r4,0Ah]   ;上部分界写入neg 78h                          
08049F7E 2078     mov     r0,78h                                  
08049F80 81A0     strh    r0,[r4,0Ch]   ;下部分界写入78h                          
08049F82 4816     ldr     r0,=0FFECh                              
08049F84 81E0     strh    r0,[r4,0Eh]   ;左部分界写入neg 14h                           
08049F86 2014     mov     r0,14h                                  
08049F88 8220     strh    r0,[r4,10h]   ;右部分界写入14h                          
08049F8A 4815     ldr     r0,=8318724h                            
08049F8C 61A0     str     r0,[r4,18h]                             
08049F8E 7721     strb    r1,[r4,1Ch]                             
08049F90 82E5     strh    r5,[r4,16h]   ;写入OAM                          
08049F92 1C21     mov     r1,r4                                   
08049F94 3125     add     r1,25h                                  
08049F96 2004     mov     r0,4h                                   
08049F98 7008     strb    r0,[r1]       ;写入属性4                            
08049F9A 3903     sub     r1,3h         ;绘图顺序写入5                             
08049F9C 2005     mov     r0,5h                                   
08049F9E 7008     strb    r0,[r1]                                 
08049FA0 4810     ldr     r0,=3000088h                            
08049FA2 7B01     ldrb    r1,[r0,0Ch]                             
08049FA4 2003     mov     r0,3h                                   
08049FA6 4008     and     r0,r1                                   
08049FA8 1C21     mov     r1,r4                                   
08049FAA 3121     add     r1,21h       ;写入图层优先级                            
08049FAC 7008     strb    r0,[r1]                                 
08049FAE 4A0E     ldr     r2,=82B0D68h                            
08049FB0 7F61     ldrb    r1,[r4,1Dh]                             
08049FB2 00C8     lsl     r0,r1,3h                                
08049FB4 1840     add     r0,r0,r1                                
08049FB6 0040     lsl     r0,r0,1h                                
08049FB8 1880     add     r0,r0,r2                                
08049FBA 8800     ldrh    r0,[r0]                                 
08049FBC 82A0     strh    r0,[r4,14h]  ;写入血量                           
08049FBE 1C08     mov     r0,r1                                   
08049FC0 28AE     cmp     r0,0AEh                                 
08049FC2 D105     bne     @@end                                
08049FC4 1C20     mov     r0,r4                                   
08049FC6 3034     add     r0,34h                                  
08049FC8 2101     mov     r1,1h                                   
08049FCA 7001     strb    r1,[r0]                                 
08049FCC 3814     sub     r0,14h                                  
08049FCE 7001     strb    r1,[r0]      ;ID AE的话用第二套调色板

@@end:                                 
08049FD0 B003     add     sp,0Ch                                  
08049FD2 BC70     pop     r4-r6                                   
08049FD4 BC01     pop     r0                                      
08049FD6 4700     bx      r0                                      

;pose 8                             
08049FEC 4908     ldr     r1,=3000738h                            
08049FEE 1C0A     mov     r2,r1                                   
08049FF0 3224     add     r2,24h                                  
08049FF2 2300     mov     r3,0h                                   
08049FF4 2009     mov     r0,9h                                   
08049FF6 7010     strb    r0,[r2]          ;pose写入9                             
08049FF8 4806     ldr     r0,=8318724h                            
08049FFA 6188     str     r0,[r1,18h]                             
08049FFC 770B     strb    r3,[r1,1Ch]                             
08049FFE 82CB     strh    r3,[r1,16h]                             
0804A000 4805     ldr     r0,=300083Ch                            
0804A002 7800     ldrb    r0,[r0]          ;读取随机值                       
0804A004 0080     lsl     r0,r0,2h                                
0804A006 303D     add     r0,3Dh                                  
0804A008 312C     add     r1,2Ch                                  
0804A00A 7008     strb    r0,[r1]          ;写入偏移2Ch                       
0804A00C 4770     bx      r14                                     
.pool

;pose 9                           
0804A01C B570     push    r4-r6,r14                               
0804A01E 4C0D     ldr     r4,=3000738h                            
0804A020 1C26     mov     r6,r4                                   
0804A022 362C     add     r6,2Ch                                  
0804A024 7830     ldrb    r0,[r6]          ;读取偏移值2C的值                        
0804A026 3801     sub     r0,1h                                   
0804A028 7030     strb    r0,[r6]          ;减1再写入                          
0804A02A 0600     lsl     r0,r0,18h                               
0804A02C 0E05     lsr     r5,r0,18h                               
0804A02E 2D00     cmp     r5,0h            ;查看是否是0                       
0804A030 D119     bne     @@end                                
0804A032 21E0     mov     r1,0E0h                                 
0804A034 0049     lsl     r1,r1,1h                                
0804A036 2080     mov     r0,80h                                  
0804A038 2200     mov     r2,0h                                   
0804A03A F7C5FF39 bl      800FEB0h         ;检查与萨姆斯的范围                           
0804A03E 2803     cmp     r0,3h                                   
0804A040 D10C     bne     @@NoInRange                                
0804A042 1C20     mov     r0,r4                                   
0804A044 3024     add     r0,24h                                  
0804A046 2123     mov     r1,23h                                  
0804A048 7001     strb    r1,[r0]          ;pose写入23                         
0804A04A 4803     ldr     r0,=831874Ch     ;新的OAM                       
0804A04C 61A0     str     r0,[r4,18h]                             
0804A04E 7725     strb    r5,[r4,1Ch]                             
0804A050 82E5     strh    r5,[r4,16h]                             
0804A052 E008     b       @@end                                
.pool  

@@NoInRange:                            
0804A05C 4803     ldr     r0,=300083Ch                            
0804A05E 7800     ldrb    r0,[r0]                                 
0804A060 0080     lsl     r0,r0,2h                                
0804A062 303D     add     r0,3Dh                                  
0804A064 7030     strb    r0,[r6]          ;再次随机值写入偏移2C

@@end:                               
0804A066 BC70     pop     r4-r6                                   
0804A068 BC01     pop     r0                                      
0804A06A 4700     bx      r0                                      
.pool
  
;pose 23  
0804A070 B500     push    r14                                     
0804A072 F7C5FDA9 bl      800FBC8h         ;检查动画                            
0804A076 2800     cmp     r0,0h                                   
0804A078 D00C     beq     @@end                                
0804A07A 4907     ldr     r1,=3000738h                            
0804A07C 1C0A     mov     r2,r1                                   
0804A07E 3224     add     r2,24h                                  
0804A080 2300     mov     r3,0h                                   
0804A082 2025     mov     r0,25h                                  
0804A084 7010     strb    r0,[r2]          ;pose写入25                          
0804A086 4805     ldr     r0,=8318784h     ;写入新OAM                       
0804A088 6188     str     r0,[r1,18h]                             
0804A08A 770B     strb    r3,[r1,1Ch]                             
0804A08C 82CB     strh    r3,[r1,16h]                             
0804A08E 4804     ldr     r0,=25Ah                                
0804A090 F7B8FCC2 bl      8002A18h         ;播放睁眼的声音

@@end:                             
0804A094 BC01     pop     r0                                      
0804A096 4700     bx      r0                                      
.pool

;pose 25                               
0804A0A4 B530     push    r4,r5,r14                               
0804A0A6 B083     add     sp,-0Ch                                 
0804A0A8 F7C5FD8E bl      800FBC8h         ;检查动画结束                        
0804A0AC 2800     cmp     r0,0h                                   
0804A0AE D025     beq     @@end                                
0804A0B0 4814     ldr     r0,=3000738h                            
0804A0B2 4684     mov     r12,r0                                  
0804A0B4 4661     mov     r1,r12                                  
0804A0B6 3124     add     r1,24h                                  
0804A0B8 2200     mov     r2,0h                                   
0804A0BA 2027     mov     r0,27h           ;pose写入27h                              
0804A0BC 7008     strb    r0,[r1]                                 
0804A0BE 4812     ldr     r0,=831886Ch     ;写入新OAM                           
0804A0C0 4661     mov     r1,r12                                  
0804A0C2 6188     str     r0,[r1,18h]                             
0804A0C4 770A     strb    r2,[r1,1Ch]                             
0804A0C6 82CA     strh    r2,[r1,16h]                             
0804A0C8 312C     add     r1,2Ch                                  
0804A0CA 203C     mov     r0,3Ch                                  
0804A0CC 7008     strb    r0,[r1]          ;偏移2C写入3C                                  
0804A0CE 4662     mov     r2,r12                                  
0804A0D0 7F50     ldrb    r0,[r2,1Dh]                             
0804A0D2 28AE     cmp     r0,0AEh          ;检查ID                       
0804A0D4 D112     bne     @@end                                
0804A0D6 2058     mov     r0,58h                                  
0804A0D8 7008     strb    r0,[r1]          ;偏移2C写入58h                       
0804A0DA 8890     ldrh    r0,[r2,4h]       ;X坐标                       
0804A0DC 3010     add     r0,10h           ;向右10h                       
0804A0DE 0400     lsl     r0,r0,10h                               
0804A0E0 0C00     lsr     r0,r0,10h                               
0804A0E2 2440     mov     r4,40h                                  
0804A0E4 7FD2     ldrb    r2,[r2,1Fh]     ;gfxrow                        
0804A0E6 3909     sub     r1,9h                                   
0804A0E8 780B     ldrb    r3,[r1]         ;主精灵序号                          
0804A0EA 4665     mov     r5,r12                                  
0804A0EC 8869     ldrh    r1,[r5,2h]                              
0804A0EE 9100     str     r1,[sp]         ;Y坐标写入                        
0804A0F0 9001     str     r0,[sp,4h]      ;X坐标写入                        
0804A0F2 9402     str     r4,[sp,8h]      ;面向写入                        
0804A0F4 2037     mov     r0,37h          ;ID                        
0804A0F6 2100     mov     r1,0h           ;生产副灵37h                          
0804A0F8 F7C4F8AE bl      800E258h

@@end:                                
0804A0FC B003     add     sp,0Ch                                  
0804A0FE BC30     pop     r4,r5                                   
0804A100 BC01     pop     r0                                      
0804A102 4700     bx      r0                                      
.pool

;pose 27                           
0804A10C B530     push    r4,r5,r14                               
0804A10E 4C09     ldr     r4,=3000738h                            
0804A110 1C21     mov     r1,r4                                   
0804A112 312C     add     r1,2Ch                                  
0804A114 7808     ldrb    r0,[r1]        ;检查偏移2C的值                           
0804A116 1C02     mov     r2,r0                                   
0804A118 2A00     cmp     r2,0h                                   
0804A11A D111     bne     @@NoZero                               
0804A11C 3908     sub     r1,8h                                   
0804A11E 2029     mov     r0,29h                                  
0804A120 7008     strb    r0,[r1]        ;pose写入29h                           
0804A122 4805     ldr     r0,=831881Ch   ;写入闭眼阶段2 OAM                         
0804A124 61A0     str     r0,[r4,18h]                             
0804A126 7722     strb    r2,[r4,1Ch]                             
0804A128 82E2     strh    r2,[r4,16h]                             
0804A12A 4804     ldr     r0,=25Bh       ;播放睁眼的声音                          
0804A12C F7B8FC74 bl      8002A18h                                
0804A130 E020     b       @@end                                

@@NoZero:                              
0804A140 1E42     sub     r2,r0,1                                   
0804A142 2500     mov     r5,0h                                   
0804A144 700A     strb    r2,[r1]        ;偏移2C减1再写入                             
0804A146 69A1     ldr     r1,[r4,18h]                             
0804A148 4804     ldr     r0,=831886Ch                            
0804A14A 4281     cmp     r1,r0          ;检查当前的OAM是否是睁眼阶段2                         
0804A14C D10A     bne     @@OAMChange                                
0804A14E F7C5FD3B bl      800FBC8h                                
0804A152 2800     cmp     r0,0h                                   
0804A154 D00E     beq     @@end          ;检查动画是否结束                       
0804A156 4802     ldr     r0,=83187E4h   ;写入完全睁眼的OAM                         
0804A158 E009     b       @@Peer
.pool

@@OAMChange:                              
0804A164 0610     lsl     r0,r2,18h                               
0804A166 0E00     lsr     r0,r0,18h                               
0804A168 2807     cmp     r0,7h                                   
0804A16A D103     bne     @@end                                
0804A16C 4803     ldr     r0,=83188A4h  ;闭眼阶段1

@@Peer:                          
0804A16E 61A0     str     r0,[r4,18h]                             
0804A170 7725     strb    r5,[r4,1Ch]                             
0804A172 82E5     strh    r5,[r4,16h]  

@@end:                           
0804A174 BC30     pop     r4,r5                                   
0804A176 BC01     pop     r0                                      
0804A178 4700     bx      r0                                      
.pool

;pose 29h
0804A180 B500     push    r14                                     
0804A182 F7C5FD3D bl      800FC00h                                
0804A186 2800     cmp     r0,0h         ;检查动画结束                             
0804A188 D003     beq     @@end                               
0804A18A 4803     ldr     r0,=3000738h                            
0804A18C 3024     add     r0,24h                                  
0804A18E 2108     mov     r1,8h                                    
0804A190 7001     strb    r1,[r0]       ;pose写回8h  
@@end:                          
0804A192 BC01     pop     r0                                      
0804A194 4700     bx      r0                                      
.pool

;Other Pose                              
0804A19C 4809     ldr     r0,=3000738h                            
0804A19E 4684     mov     r12,r0                                  
0804A1A0 4661     mov     r1,r12                                  
0804A1A2 3124     add     r1,24h                                  
0804A1A4 2200     mov     r2,0h                                   
0804A1A6 2067     mov     r0,67h                                  
0804A1A8 7008     strb    r0,[r1]       ;pose写入67                          
0804A1AA 4807     ldr     r0,=8318844h  ;将要死亡的OAM                        
0804A1AC 4661     mov     r1,r12                                  
0804A1AE 6188     str     r0,[r1,18h]                             
0804A1B0 770A     strb    r2,[r1,1Ch]                             
0804A1B2 2300     mov     r3,0h                                   
0804A1B4 82CA     strh    r2,[r1,16h]                             
0804A1B6 312C     add     r1,2Ch                                  
0804A1B8 2028     mov     r0,28h                                  
0804A1BA 7008     strb    r0,[r1]       ;偏移2C写入28h                               
0804A1BC 4660     mov     r0,r12                                  
0804A1BE 3025     add     r0,25h                                  
0804A1C0 7003     strb    r3,[r0]       ;属性写入0                          
0804A1C2 4770     bx      r14                                     
.pool

;pose 67                              
0804A1CC B5F0     push    r4-r7,r14                               
0804A1CE B083     add     sp,-0Ch                                 
0804A1D0 4C0D     ldr     r4,=3000738h                            
0804A1D2 1C21     mov     r1,r4                                   
0804A1D4 312C     add     r1,2Ch                                  
0804A1D6 7808     ldrb    r0,[r1]       ;读取偏移2C的值                            
0804A1D8 3801     sub     r0,1h                                   
0804A1DA 7008     strb    r0,[r1]       ;减1再写入                          
0804A1DC 0600     lsl     r0,r0,18h                               
0804A1DE 0E01     lsr     r1,r0,18h                               
0804A1E0 1C0A     mov     r2,r1                                   
0804A1E2 2003     mov     r0,3h                                   
0804A1E4 4008     and     r0,r1                                   
0804A1E6 2800     cmp     r0,0h        ;检查该值是否被3and为0                            
0804A1E8 D152     bne     @@end                                
0804A1EA 2004     mov     r0,4h                                   
0804A1EC 4008     and     r0,r1                                   
0804A1EE 2800     cmp     r0,0h        ;检查该值是否被4and不为0                             
0804A1F0 D00C     beq     @@Pass                                
0804A1F2 1C20     mov     r0,r4                                   
0804A1F4 3033     add     r0,33h                                  
0804A1F6 7800     ldrb    r0,[r0]      ;读取偏移33的值                           
0804A1F8 7FE1     ldrb    r1,[r4,1Fh]  ;读取GfxRow                           
0804A1FA 1840     add     r0,r0,r1     ;相加                           
0804A1FC 210E     mov     r1,0Eh                                  
0804A1FE 1A09     sub     r1,r1,r0     ;减去0e                           
0804A200 1C20     mov     r0,r4                                   
0804A202 3020     add     r0,20h                                  
0804A204 7001     strb    r1,[r0]      ;写入调色板号                             
0804A206 E043     b       @@end                                
.pool 

@@Pass:                             
0804A20C 1C20     mov     r0,r4                                   
0804A20E 3034     add     r0,34h                                  
0804A210 7801     ldrb    r1,[r0]      ;读取偏移34的值                            
0804A212 3814     sub     r0,14h                                  
0804A214 7001     strb    r1,[r0]      ;写入调色板号                           
0804A216 2A00     cmp     r2,0h                                   
0804A218 D13A     bne     @@end                                
0804A21A 8866     ldrh    r6,[r4,2h]                              
0804A21C 88A5     ldrh    r5,[r4,4h]                              
0804A21E 1C28     mov     r0,r5                                   
0804A220 1C31     mov     r1,r6                                   
0804A222 2201     mov     r2,1h                                   
0804A224 F00DFB72 bl      805790Ch    ;取消门无法打开的flag                            
0804A228 7F60     ldrb    r0,[r4,1Dh]                             
0804A22A 28AD     cmp     r0,0ADh                                 
0804A22C D104     bne     @@OtherID                                
0804A22E 2001     mov     r0,1h                                   
0804A230 211D     mov     r1,1Dh                                  
0804A232 F016FB43 bl      80608BCh    ;激活事件                            
0804A236 E005     b       @@PassEvent

@@OtherID:                                
0804A238 28AE     cmp     r0,0AEh                                 
0804A23A D103     bne     @@PassEvent                                
0804A23C 2001     mov     r0,1h                                   
0804A23E 2124     mov     r1,24h                                  
0804A240 F016FB3C bl      80608BCh 

@@PassEvent:                               
0804A244 4814     ldr     r0,=300083Ch                            
0804A246 7804     ldrb    r4,[r0]     ;读取随机值                              
0804A248 1C28     mov     r0,r5                                   
0804A24A 3010     add     r0,10h                                  
0804A24C 0400     lsl     r0,r0,10h                               
0804A24E 0C05     lsr     r5,r0,10h                               
0804A250 1C21     mov     r1,r4                                   
0804A252 3948     sub     r1,48h                                  
0804A254 1A71     sub     r1,r6,r1                                
0804A256 1B2A     sub     r2,r5,r4                                
0804A258 2022     mov     r0,22h                                  
0804A25A 9000     str     r0,[sp]                                 
0804A25C 2000     mov     r0,0h                                   
0804A25E 2301     mov     r3,1h                                   
0804A260 F7C6FF10 bl      8011084h    ;死亡烟花                            
0804A264 4A0D     ldr     r2,=3000738h                            
0804A266 8810     ldrh    r0,[r2]                                 
0804A268 2800     cmp     r0,0h                                   
0804A26A D011     beq     @@end                                
0804A26C 2001     mov     r0,1h                                   
0804A26E 4004     and     r4,r0                                   
0804A270 271C     mov     r7,1Ch                                  
0804A272 2C00     cmp     r4,0h                                   
0804A274 D000     beq     @@Pass2                                
0804A276 271A     mov     r7,1Ah  

@@Pass2:                                
0804A278 7F91     ldrb    r1,[r2,1Eh]                             
0804A27A 1C10     mov     r0,r2                                   
0804A27C 3023     add     r0,23h                                  
0804A27E 7803     ldrb    r3,[r0]                                 
0804A280 9600     str     r6,[sp]                                 
0804A282 9501     str     r5,[sp,4h]                              
0804A284 2000     mov     r0,0h                                   
0804A286 9002     str     r0,[sp,8h]                              
0804A288 1C38     mov     r0,r7                                   
0804A28A 2200     mov     r2,0h                                   
0804A28C F7C4F8A2 bl      800E3D4h ;第二个掉落

@@end:                               
0804A290 B003     add     sp,0Ch                                  
0804A292 BCF0     pop     r4-r7                                   
0804A294 BC01     pop     r0                                      
0804A296 4700     bx      r0                                      

///////////////////////////////////////////////////////////////////////////////////////////
;主程序                              
0804A2A0 B500     push    r14                                     
0804A2A2 4809     ldr     r0,=3000738h                            
0804A2A4 3024     add     r0,24h                                  
0804A2A6 7800     ldrb    r0,[r0]      ;读取pose                                
0804A2A8 2827     cmp     r0,27h                                  
0804A2AA D028     beq     @@Pose27                               
0804A2AC 2827     cmp     r0,27h                                  
0804A2AE DC13     bgt     @@Posemore27                                
0804A2B0 2823     cmp     r0,23h                                  
0804A2B2 D01E     beq     @@Pose23                                
0804A2B4 2823     cmp     r0,23h                                  
0804A2B6 DC0C     bgt     @@Posemore23                                
0804A2B8 2808     cmp     r0,8h                                   
0804A2BA D015     beq     @@Pose8                                
0804A2BC 2808     cmp     r0,8h                                   
0804A2BE DC05     bgt     @@Posemore8                                
0804A2C0 2800     cmp     r0,0h                                   
0804A2C2 D00E     beq     @@Pose0                                
0804A2C4 E024     b       @@otherPose                                

@@Posemore8:                               
0804A2CC 2809     cmp     r0,9h                                   
0804A2CE D00D     beq     @@Pose9                                
0804A2D0 E01E     b       @@otherPose 

@@Posemore23:                               
0804A2D2 2825     cmp     r0,25h                                  
0804A2D4 D010     beq     @@Pose25                                
0804A2D6 E01B     b       @@otherPose 

@@Posemore27:                               
0804A2D8 2829     cmp     r0,29h                                  
0804A2DA D013     beq     @@Pose29                               
0804A2DC 2867     cmp     r0,67h                                  
0804A2DE D014     beq     @@Pose67                                
0804A2E0 E016     b       @@otherPose  

@@Pose0:                              
0804A2E2 F7FFFDE9 bl      8049EB8h                                
0804A2E6 E015     b       @@end 

@@Pose8:                               
0804A2E8 F7FFFE80 bl      8049FECh   

@@Pose9:                             
0804A2EC F7FFFE96 bl      804A01Ch   ;正常闭眼姿态                             
0804A2F0 E010     b       @@end

@@Pose23:                                
0804A2F2 F7FFFEBD bl      804A070h   ;将睁眼1                              
0804A2F6 E00D     b       @@end 

@@Pose25:                               
0804A2F8 F7FFFED4 bl      804A0A4h   ;将睁眼2                             
0804A2FC E00A     b       @@end 

@@Pose27:                               
0804A2FE F7FFFF05 bl      804A10Ch   ;睁眼                             
0804A302 E007     b       @@end 

@@Pose29:                               
0804A304 F7FFFF3C bl      804A180h   ;闭眼                             
0804A308 E004     b       @@end

@@Pose67:                                
0804A30A F7FFFF5F bl      804A1CCh                                
0804A30E E001     b       @@end  

@@otherPose:                              
0804A310 F7FFFF44 bl      804A19Ch

@@end                                
0804A314 BC01     pop     r0                                      
0804A316 4700     bx      r0  

//////////////////////////////////////////
;副精灵36主程序                                  
0804A318 B530     push    r4,r5,r14                               
0804A31A B081     add     sp,-4h                                  
0804A31C 4919     ldr     r1,=3000738h                            
0804A31E 1C0A     mov     r2,r1                                   
0804A320 3226     add     r2,26h                                  
0804A322 2001     mov     r0,1h                                   
0804A324 7010     strb    r0,[r2]    ;待机值写入1                              
0804A326 1C0B     mov     r3,r1                                   
0804A328 3332     add     r3,32h                                  
0804A32A 781A     ldrb    r2,[r3]    ;读取碰撞属性                             
0804A32C 2402     mov     r4,2h                                   
0804A32E 1C20     mov     r0,r4                                   
0804A330 4010     and     r0,r2      ;2 and                             
0804A332 2800     cmp     r0,0h                                   
0804A334 D00A     beq     @@NoHit                                
0804A336 20FD     mov     r0,0FDh                                 
0804A338 4010     and     r0,r2                                   
0804A33A 7018     strb    r0,[r3]                                 
0804A33C 8809     ldrh    r1,[r1]                                 
0804A33E 1C20     mov     r0,r4                                   
0804A340 4008     and     r0,r1      ;检查是否在屏幕内                              
0804A342 2800     cmp     r0,0h                                   
0804A344 D002     beq     @@NoHit                                
0804A346 4810     ldr     r0,=25Eh   ;眼睛被打的声音                              
0804A348 F7B8FB66 bl      8002A18h  

@@NoHit:                              
0804A34C 490D     ldr     r1,=3000738h                            
0804A34E 1C08     mov     r0,r1                                   
0804A350 3023     add     r0,23h                                  
0804A352 7802     ldrb    r2,[r0]    ;主精灵序号                             
0804A354 8A88     ldrh    r0,[r1,14h];读取眼睛血量                             
0804A356 1C0B     mov     r3,r1                                   
0804A358 2800     cmp     r0,0h                                   
0804A35A D009     beq     @@SpriteDeath                                
0804A35C 490B     ldr     r1,=30001ACh                            
0804A35E 00D0     lsl     r0,r2,3h                                
0804A360 1A80     sub     r0,r0,r2                                
0804A362 00C0     lsl     r0,r0,3h                                
0804A364 1840     add     r0,r0,r1                                
0804A366 1C19     mov     r1,r3                                   
0804A368 3120     add     r1,20h                                  
0804A36A 7809     ldrb    r1,[r1]    ;读取调色板号                              
0804A36C 3020     add     r0,20h                                  
0804A36E 7001     strb    r1,[r0]    ;写入副精灵的调色板号

@@SpriteDeath:                                
0804A370 1C1D     mov     r5,r3                                   
0804A372 3524     add     r5,24h                                  
0804A374 782C     ldrb    r4,[r5]    ;读取pose                               
0804A376 2C62     cmp     r4,62h                                  
0804A378 D056     beq     @@Pose62                               
0804A37A 2C62     cmp     r4,62h                                  
0804A37C DC08     bgt     @@OtherDeathPose                                
0804A37E 2C00     cmp     r4,0h                                   
0804A380 D009     beq     @@PoseZero                                
0804A382 E089     b       @@OtherPose                                
.pool

@@OtherDeathPose:                              
0804A390 2C67     cmp     r4,67h                                  
0804A392 D067     beq     @@Pose67                               
0804A394 E080     b       @@OtherPose

@@PoseZero:                                
0804A396 4808     ldr     r0,=3000088h                            
0804A398 7B01     ldrb    r1,[r0,0Ch]                             
0804A39A 2003     mov     r0,3h                                   
0804A39C 4008     and     r0,r1                                   
0804A39E 1C19     mov     r1,r3                                   
0804A3A0 3121     add     r1,21h                                  
0804A3A2 7008     strb    r0,[r1]       ;写入图层优先级                           
0804A3A4 4905     ldr     r1,=30001ACh                            
0804A3A6 00D0     lsl     r0,r2,3h                                
0804A3A8 1A80     sub     r0,r0,r2                                
0804A3AA 00C0     lsl     r0,r0,3h                                
0804A3AC 1840     add     r0,r0,r1                                
0804A3AE 7F40     ldrb    r0,[r0,1Dh]   ;读取主精灵的ID                             
0804A3B0 28AD     cmp     r0,0ADh                                 
0804A3B2 D105     bne     @@NoAD2
0804A3B4 2001     mov     r0,1h                                   
0804A3B6 E010     b       @@Peer        ;AD为主精灵事,眼睛血量为1                                
.pool

@@NoAD2:                              
0804A3C0 1C18     mov     r0,r3                                   
0804A3C2 3034     add     r0,34h                                  
0804A3C4 2101     mov     r1,1h                                   
0804A3C6 7001     strb    r1,[r0]       ;击打变色值写入1                              
0804A3C8 3814     sub     r0,14h                                  
0804A3CA 7001     strb    r1,[r0]       ;调色板也写入1                          
0804A3CC 4A12     ldr     r2,=82B1BE4h                            
0804A3CE 7F59     ldrb    r1,[r3,1Dh]                             
0804A3D0 00C8     lsl     r0,r1,3h                                
0804A3D2 1840     add     r0,r0,r1                                
0804A3D4 0040     lsl     r0,r0,1h                                
0804A3D6 1880     add     r0,r0,r2                                
0804A3D8 8800     ldrh    r0,[r0] 

@@Peer:                                
0804A3DA 8298     strh    r0,[r3,14h]   ;写入血量                         
0804A3DC 1C18     mov     r0,r3                                   
0804A3DE 3027     add     r0,27h                                  
0804A3E0 2200     mov     r2,0h                                   
0804A3E2 2108     mov     r1,8h                                   
0804A3E4 7001     strb    r1,[r0]       ;上视界写入8h                           
0804A3E6 3001     add     r0,1h                                   
0804A3E8 7001     strb    r1,[r0]       ;左右视界写入8h                          
0804A3EA 3001     add     r0,1h                                   
0804A3EC 7001     strb    r1,[r0]       ;下视界写入8h                          
0804A3EE 2100     mov     r1,0h                                   
0804A3F0 480A     ldr     r0,=0FFD8h                              
0804A3F2 8158     strh    r0,[r3,0Ah]   ;上部分界写入neg 28                          
0804A3F4 2028     mov     r0,28h                                  
0804A3F6 8198     strh    r0,[r3,0Ch]   ;下部分界写入28                          
0804A3F8 4809     ldr     r0,=0FFF0h                              
0804A3FA 81D8     strh    r0,[r3,0Eh]   ;左部分界写入neg 10h                          
0804A3FC 2010     mov     r0,10h                                  
0804A3FE 8218     strh    r0,[r3,10h]   ;右部分界写入10h                          
0804A400 4808     ldr     r0,=82B2750h  ;写入OAM                          
0804A402 6198     str     r0,[r3,18h]                             
0804A404 7719     strb    r1,[r3,1Ch]                             
0804A406 82DA     strh    r2,[r3,16h]                             
0804A408 1C18     mov     r0,r3                                   
0804A40A 3025     add     r0,25h                                  
0804A40C 7001     strb    r1,[r0]       ;属性写入0h                               
0804A40E 1C19     mov     r1,r3                                   
0804A410 3124     add     r1,24h                                  
0804A412 2009     mov     r0,9h                                   
0804A414 7008     strb    r0,[r1]       ;pose写入9h                           
0804A416 E063     b       @@end                                
.pool 

@@Pose62:                                                            
0804A428 490D     ldr     r1,=30001ACh                            
0804A42A 00D0     lsl     r0,r2,3h                                
0804A42C 1A80     sub     r0,r0,r2                                
0804A42E 00C0     lsl     r0,r0,3h                                
0804A430 1842     add     r2,r0,r1                                
0804A432 1C10     mov     r0,r2                                   
0804A434 3024     add     r0,24h                                  
0804A436 2100     mov     r1,0h                                   
0804A438 7004     strb    r4,[r0]       ;主精灵的pose写入62h                             
0804A43A 1C14     mov     r4,r2                                   
0804A43C 3426     add     r4,26h                                  
0804A43E 2001     mov     r0,1h                                   
0804A440 7020     strb    r0,[r4]       ;主精灵待机值写入1h                          
0804A442 8291     strh    r1,[r2,14h]   ;主精灵血量写入0                          
0804A444 2067     mov     r0,67h                                  
0804A446 7028     strb    r0,[r5]       ;pose写入 67h                           
0804A448 8819     ldrh    r1,[r3]                                 
0804A44A 2280     mov     r2,80h                                  
0804A44C 0212     lsl     r2,r2,8h                                
0804A44E 1C10     mov     r0,r2                                   
0804A450 4308     orr     r0,r1                                   
0804A452 8018     strh    r0,[r3]       ;取向写入无敌                          
0804A454 1C19     mov     r1,r3                                   
0804A456 312C     add     r1,2Ch                                  
0804A458 2028     mov     r0,28h                                  
0804A45A 7008     strb    r0,[r1]       ;偏移2C写入28h
0804A45C E040     b       @@end                                
.pool 

@@Pose67:                             
0804A464 1C19     mov     r1,r3                                   
0804A466 312C     add     r1,2Ch                                  
0804A468 7808     ldrb    r0,[r1]       ;读取偏移2C的值                          
0804A46A 3801     sub     r0,1h         ;减1再写入                          
0804A46C 7008     strb    r0,[r1]                                 
0804A46E 0600     lsl     r0,r0,18h                               
0804A470 2800     cmp     r0,0h                                   
0804A472 D135     bne     @@end                                
0804A474 4807     ldr     r0,=300083Ch                            
0804A476 7802     ldrb    r2,[r0]       ;读取随机值                          
0804A478 1C11     mov     r1,r2                                   
0804A47A 3944     sub     r1,44h        ;减去44h                          
0804A47C 8858     ldrh    r0,[r3,2h]    ;读取坐标                          
0804A47E 1809     add     r1,r1,r0                                
0804A480 3210     add     r2,10h                                  
0804A482 889B     ldrh    r3,[r3,4h]                              
0804A484 18D2     add     r2,r2,r3                                
0804A486 2022     mov     r0,22h                                  
0804A488 9000     str     r0,[sp]                                 
0804A48A 2000     mov     r0,0h                                   
0804A48C 2301     mov     r3,1h                                   
0804A48E F7C6FDF9 bl      8011084h      ;死亡烟花                              
0804A492 E025     b       @@end                                 
.pool

@@OtherPose:                             
0804A498 490C     ldr     r1,=30001ACh                            
0804A49A 00D0     lsl     r0,r2,3h                                
0804A49C 1A80     sub     r0,r0,r2                                
0804A49E 00C0     lsl     r0,r0,3h                                
0804A4A0 1842     add     r2,r0,r1                                
0804A4A2 1C10     mov     r0,r2                                   
0804A4A4 3024     add     r0,24h                                  
0804A4A6 7800     ldrb    r0,[r0]       ;读取主精灵的POSE                            
0804A4A8 2827     cmp     r0,27h                                  
0804A4AA D113     bne     @@NoOpenEye                                
0804A4AC 8819     ldrh    r1,[r3]                                 
0804A4AE 4808     ldr     r0,=7FFFh                               
0804A4B0 4008     and     r0,r1                                   
0804A4B2 8018     strh    r0,[r3]       ;眼睛若是打开的则取向去掉8000无敌效果                            
0804A4B4 1C18     mov     r0,r3                                   
0804A4B6 302B     add     r0,2Bh                                  
0804A4B8 7801     ldrb    r1,[r0]       ;读取击晕时间                            
0804A4BA 207F     mov     r0,7Fh                                  
0804A4BC 4008     and     r0,r1                                   
0804A4BE 2810     cmp     r0,10h        ;比较是否是10h                          
0804A4C0 D10E     bne     @@end                                
0804A4C2 1C11     mov     r1,r2                                   
0804A4C4 312C     add     r1,2Ch                                  
0804A4C6 2000     mov     r0,0h                                   
0804A4C8 7008     strb    r0,[r1]       ;主精灵的2C偏移值写为0,立即闭眼>                           
0804A4CA E009     b       @@end                                
.pool

@@NoOpenEye:                              
0804A4D4 8819     ldrh    r1,[r3]                                 
0804A4D6 2280     mov     r2,80h                                  
0804A4D8 0212     lsl     r2,r2,8h      ;眼睛的取向orr8000 无敌                              
0804A4DA 1C10     mov     r0,r2                                   
0804A4DC 4308     orr     r0,r1                                   
0804A4DE 8018     strh    r0,[r3]

@@end:                                 
0804A4E0 B001     add     sp,4h                                   
0804A4E2 BC30     pop     r4,r5                                   
0804A4E4 BC01     pop     r0                                      
0804A4E6 4700     bx      r0 


;副灵37 光束的主程序                                     
0804A4E8 B570     push    r4-r6,r14                               
0804A4EA 4805     ldr     r0,=3000738h                            
0804A4EC 1C06     mov     r6,r0                                   
0804A4EE 3624     add     r6,24h                                  
0804A4F0 7834     ldrb    r4,[r6]      ;读取pose                           
0804A4F2 1C05     mov     r5,r0                                   
0804A4F4 2C00     cmp     r4,0h                                   
0804A4F6 D005     beq     @@Pose0                                
0804A4F8 2C09     cmp     r4,9h                                   
0804A4FA D036     beq     @@Pose9                                
0804A4FC E06A     b       @@end                                
.pool 

@@Pose0:                              
0804A504 8829     ldrh    r1,[r5]                                 
0804A506 4821     ldr     r0,=0FFFBh                              
0804A508 4008     and     r0,r1        ;取向and FB 去掉4                            
0804A50A 2300     mov     r3,0h                                   
0804A50C 8028     strh    r0,[r5]      ;再写入                             
0804A50E 1C2A     mov     r2,r5                                   
0804A510 3232     add     r2,32h                                  
0804A512 7811     ldrb    r1,[r2]      ;读取碰撞属性                           
0804A514 2004     mov     r0,4h                                   
0804A516 4308     orr     r0,r1        ;orr 4 无敌?                           
0804A518 7010     strb    r0,[r2]      ;再写入                           
0804A51A 1C28     mov     r0,r5                                   
0804A51C 3027     add     r0,27h                                  
0804A51E 2210     mov     r2,10h                                  
0804A520 7002     strb    r2,[r0]      ;上视界写入10h                           
0804A522 3001     add     r0,1h                                   
0804A524 7002     strb    r2,[r0]      ;左右视界写入10h                           
0804A526 3001     add     r0,1h                                   
0804A528 7002     strb    r2,[r0]      ;下视界写入10h                           
0804A52A 4819     ldr     r0,=0FFD0h                              
0804A52C 8168     strh    r0,[r5,0Ah]  ;上部分界写入neg 30h                            
0804A52E 2030     mov     r0,30h                                  
0804A530 81A8     strh    r0,[r5,0Ch]  ;下部分界写入30h                           
0804A532 4818     ldr     r0,=83187BCh ;写入OAM                           
0804A534 61A8     str     r0,[r5,18h]                             
0804A536 772B     strb    r3,[r5,1Ch]                             
0804A538 82EC     strh    r4,[r5,16h]                             
0804A53A 2009     mov     r0,9h                                   
0804A53C 7030     strb    r0,[r6]      ;pose写入9h                             
0804A53E 1C29     mov     r1,r5                                   
0804A540 3125     add     r1,25h                                  
0804A542 2004     mov     r0,4h                                   
0804A544 7008     strb    r0,[r1]      ;属性写入4h                           
0804A546 3903     sub     r1,3h                                   
0804A548 2003     mov     r0,3h                                   
0804A54A 7008     strb    r0,[r1]      ;绘图顺序写入3h                           
0804A54C 4912     ldr     r1,=3000088h                            
0804A54E 7B09     ldrb    r1,[r1,0Ch]                             
0804A550 4008     and     r0,r1                                   
0804A552 1C29     mov     r1,r5                                   
0804A554 3121     add     r1,21h                                  
0804A556 7008     strb    r0,[r1]      ;写入图层优先级 最优先?                           
0804A558 2001     mov     r0,1h                                   
0804A55A 82A8     strh    r0,[r5,14h]  ;血量写入1                           
0804A55C 1C28     mov     r0,r5                                   
0804A55E 302C     add     r0,2Ch                                  
0804A560 7002     strb    r2,[r0]      ;偏移2C写入10h                           
0804A562 480E     ldr     r0,=0FFFCh                              
0804A564 81E8     strh    r0,[r5,0Eh]  ;左部分界写入neg 4h                           
0804A566 2018     mov     r0,18h                                  
0804A568 8228     strh    r0,[r5,10h]  ;右部分界写入18h

@@Pose9:                            
0804A56A 1C2C     mov     r4,r5                                   
0804A56C 1C21     mov     r1,r4                                   
0804A56E 312C     add     r1,2Ch                                  
0804A570 7808     ldrb    r0,[r1]      ;读取偏移2C的值                              
0804A572 1C06     mov     r6,r0                                   
0804A574 2E00     cmp     r6,0h                                   
0804A576 D013     beq     @@Zero                                
0804A578 3801     sub     r0,1h                                   
0804A57A 7008     strb    r0,[r1]      ;减1再写入                              
0804A57C 0600     lsl     r0,r0,18h                               
0804A57E 2800     cmp     r0,0h                                   
0804A580 D128     bne     @@end                                
0804A582 2097     mov     r0,97h                                  
0804A584 0080     lsl     r0,r0,2h     ;发射的声音                           
0804A586 F7B8FA47 bl      8002A18h                                
0804A58A E023     b       @@end                                
.pool

@@Zero:                              
0804A5A0 88A0     ldrh    r0,[r4,4h]                              
0804A5A2 300C     add     r0,0Ch                                  
0804A5A4 80A0     strh    r0,[r4,4h]   ;X坐标加上0C再写入                             
0804A5A6 8860     ldrh    r0,[r4,2h]                              
0804A5A8 88A1     ldrh    r1,[r4,4h]                              
0804A5AA F7C5F86D bl      800F688h     ;检查砖块                          
0804A5AE 480B     ldr     r0,=30007F1h                            
0804A5B0 7800     ldrb    r0,[r0]      ;检查是否有砖                           
0804A5B2 2800     cmp     r0,0h                                   
0804A5B4 D00E     beq     @@end                                
0804A5B6 8860     ldrh    r0,[r4,2h]                              
0804A5B8 301C     add     r0,1Ch       ;y坐标向上1Ch                           
0804A5BA 88A1     ldrh    r1,[r4,4h]                              
0804A5BC 2221     mov     r2,21h                                  
0804A5BE F009FD95 bl      80540ECh     ;特效                           
0804A5C2 8821     ldrh    r1,[r4]                                 
0804A5C4 2002     mov     r0,2h                                   
0804A5C6 4008     and     r0,r1                                   
0804A5C8 2800     cmp     r0,0h        ;检查是否在屏幕内                            
0804A5CA D002     beq     @@NoPlaySound                                
0804A5CC 4804     ldr     r0,=25Dh                                
0804A5CE F7B8FA23 bl      8002A18h 

@@NoPlaySound:                               
0804A5D2 802E     strh    r6,[r5]

@@end:                                 
0804A5D4 BC70     pop     r4-r6                                   
0804A5D6 BC01     pop     r0                                      
0804A5D8 4700     bx      r0
.pool                                      
