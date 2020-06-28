
;pose 00
08036EC4 4B0F     ldr     r3,=3000738h                            
08036EC6 2100     mov     r1,0h                                   
08036EC8 480F     ldr     r0,=0FFE8h                              
08036ECA 8158     strh    r0,[r3,0Ah]   ;上界延伸18h                             
08036ECC 8199     strh    r1,[r3,0Ch]   ;下界0                          
08036ECE 3820     sub     r0,20h                                  
08036ED0 81D8     strh    r0,[r3,0Eh]   ;左界延伸38h                           
08036ED2 2038     mov     r0,38h                                  
08036ED4 8218     strh    r0,[r3,10h]   ;右界延伸38h                          
08036ED6 1C18     mov     r0,r3                                   
08036ED8 3027     add     r0,27h                                  
08036EDA 2108     mov     r1,8h                                   
08036EDC 7001     strb    r1,[r0]       ;300075f写入8h                          
08036EDE 3001     add     r0,1h                                   
08036EE0 7001     strb    r1,[r0]       ;3000760写入8h                          
08036EE2 1C19     mov     r1,r3                                   
08036EE4 3129     add     r1,29h                                  
08036EE6 2010     mov     r0,10h                                  
08036EE8 7008     strb    r0,[r1]       ;3000761写入10h                          
08036EEA 3904     sub     r1,4h                                   
08036EEC 2007     mov     r0,7h                                   
08036EEE 7008     strb    r0,[r1]       ;属性写入7h                          
08036EF0 4A06     ldr     r2,=82B0D68h                            
08036EF2 7F59     ldrb    r1,[r3,1Dh]                             
08036EF4 00C8     lsl     r0,r1,3h                                
08036EF6 1840     add     r0,r0,r1                                
08036EF8 0040     lsl     r0,r0,1h      ;18倍                          
08036EFA 1880     add     r0,r0,r2                                
08036EFC 8800     ldrh    r0,[r0]                                 
08036EFE 8298     strh    r0,[r3,14h]   ;写入血量                           
08036F00 4770     bx      r14 

;pose 8h                                                                  
08036F10 4806     ldr     r0,=3000738h                            
08036F12 1C02     mov     r2,r0                                   
08036F14 3224     add     r2,24h                                  
08036F16 2300     mov     r3,0h                                   
08036F18 2109     mov     r1,9h                                   
08036F1A 7011     strb    r1,[r2]       ;pose写入9h                          
08036F1C 4904     ldr     r1,=82EEC8Ch                            
08036F1E 6181     str     r1,[r0,18h]   ;写入OAM                          
08036F20 7703     strb    r3,[r0,1Ch]                             
08036F22 82C3     strh    r3,[r0,16h]                             
08036F24 302C     add     r0,2Ch                                  
08036F26 2178     mov     r1,78h                                  
08036F28 7001     strb    r1,[r0]       ;3000764写入78h                          
08036F2A 4770     bx      r14                                     

;pose 9h
08036F34 B530     push    r4,r5,r14                               
08036F36 4C15     ldr     r4,=3000738h                            
08036F38 1C21     mov     r1,r4                                   
08036F3A 312C     add     r1,2Ch        ;读取3000764的值                          
08036F3C 7808     ldrb    r0,[r1]                                 
08036F3E 3801     sub     r0,1h         ;减1再写入                          
08036F40 7008     strb    r0,[r1]                                 
08036F42 0600     lsl     r0,r0,18h                               
08036F44 2800     cmp     r0,0h                                   
08036F46 D129     bne     @@end         ;计时为0时                       
08036F48 8821     ldrh    r1,[r4]                                 
08036F4A 2502     mov     r5,2h                                   
08036F4C 1C28     mov     r0,r5                                   
08036F4E 4008     and     r0,r1         ;2 and 取向  确认敌人在屏幕中                         
08036F50 2800     cmp     r0,0h                                   
08036F52 D01F     beq     @@ReTime                                
08036F54 201B     mov     r0,1Bh                                  
08036F56 F7D9FBEF bl      8010738h      ;检查有主精灵序号副精灵1B是否在精灵槽并未死                          
08036F5A 2800     cmp     r0,0h                                   
08036F5C D11A     bne     @@ReTime                                
08036F5E F7D9FCA7 bl      80108B0h      ;判断是否有空闲的精灵槽存在?                           
08036F62 1C02     mov     r2,r0                                   
08036F64 2A00     cmp     r2,0h                                   
08036F66 D115     bne     @@ReTime                                
08036F68 1C21     mov     r1,r4                                   
08036F6A 3124     add     r1,24h                                  
08036F6C 2023     mov     r0,23h                                  
08036F6E 7008     strb    r0,[r1]       ;pose写入23h                           
08036F70 4807     ldr     r0,=82EECB4h                            
08036F72 61A0     str     r0,[r4,18h]   ;写入新的OAM                          
08036F74 7722     strb    r2,[r4,1Ch]                             
08036F76 82E2     strh    r2,[r4,16h]                             
08036F78 8821     ldrh    r1,[r4]                                 
08036F7A 1C28     mov     r0,r5                                   
08036F7C 4008     and     r0,r1                                   
08036F7E 2800     cmp     r0,0h                                   
08036F80 D00C     beq     @@end                                
08036F82 20BE     mov     r0,0BEh                                 
08036F84 0040     lsl     r0,r0,1h     ;抛球音                          
08036F86 F7CBFD47 bl      8002A18h                                
08036F8A E007     b       @@end                                 

@@ReTime:                             
08036F94 4803     ldr     r0,=3000738h                            
08036F96 302C     add     r0,2Ch        ;3000764再次写入78h                            
08036F98 2178     mov     r1,78h                                  
08036F9A 7001     strb    r1,[r0] 

@@end:                                
08036F9C BC30     pop     r4,r5                                   
08036F9E BC01     pop     r0                                      
08036FA0 4700     bx      r0                                      


;pose 23h                               
08036FA8 B500     push    r14                                     
08036FAA F7D8FE0D bl      800FBC8h      ;检查动画是否结束                           
08036FAE 2800     cmp     r0,0h                                   
08036FB0 D00C     beq     @@end                                
08036FB2 4807     ldr     r0,=3000738h                            
08036FB4 1C02     mov     r2,r0                                   
08036FB6 3224     add     r2,24h                                  
08036FB8 2300     mov     r3,0h                                   
08036FBA 2125     mov     r1,25h                                  
08036FBC 7011     strb    r1,[r2]       ;pose写入25h                           
08036FBE 4905     ldr     r1,=82EECDCh                            
08036FC0 6181     str     r1,[r0,18h]   ;写入新的OAM                          
08036FC2 7703     strb    r3,[r0,1Ch]                             
08036FC4 82C3     strh    r3,[r0,16h]                             
08036FC6 302C     add     r0,2Ch                                  
08036FC8 2114     mov     r1,14h        ;3000764写入14h                          
08036FCA 7001     strb    r1,[r0] 

@@end:                                
08036FCC BC01     pop     r0                                      
08036FCE 4700     bx      r0                                      


;pose 25h                               
08036FD8 B530     push    r4,r5,r14                               
08036FDA B083     add     sp,-0Ch                                 
08036FDC 4809     ldr     r0,=3000738h                            
08036FDE 4684     mov     r12,r0                                  
08036FE0 302C     add     r0,2Ch                                  
08036FE2 7801     ldrb    r1,[r0]      ;3000764的值                             
08036FE4 3901     sub     r1,1h        ;减1再写入                           
08036FE6 2400     mov     r4,0h                                   
08036FE8 7001     strb    r1,[r0]                                 
08036FEA 0608     lsl     r0,r1,18h                               
08036FEC 2800     cmp     r0,0h                                   
08036FEE D10D     bne     @@NoZero                                
08036FF0 4660     mov     r0,r12                                  
08036FF2 3024     add     r0,24h                                  
08036FF4 2127     mov     r1,27h                                  
08036FF6 7001     strb    r1,[r0]      ;pose写入27h                            
08036FF8 4803     ldr     r0,=82EECECh ;写入OAM                           
08036FFA 4661     mov     r1,r12                                  
08036FFC 6188     str     r0,[r1,18h]                             
08036FFE 770C     strb    r4,[r1,1Ch]                             
08037000 82CC     strh    r4,[r1,16h]                             
08037002 E016     b       @@end                                 

@@NoZero:                             
0803700C 0608     lsl     r0,r1,18h                               
0803700E 0E00     lsr     r0,r0,18h                               
08037010 2804     cmp     r0,4h                                   
08037012 D10E     bne     @@end                                
08037014 4665     mov     r5,r12                                  
08037016 7FA9     ldrb    r1,[r5,1Eh]  ;读取3000756的值                           
08037018 7FEA     ldrb    r2,[r5,1Fh]  ;读取gfx row                           
0803701A 4660     mov     r0,r12                                  
0803701C 3023     add     r0,23h                                  
0803701E 7803     ldrb    r3,[r0]      ;主精灵序号                           
08037020 8868     ldrh    r0,[r5,2h]                              
08037022 3820     sub     r0,20h                                  
08037024 9000     str     r0,[sp]                                 
08037026 88A8     ldrh    r0,[r5,4h]                              
08037028 9001     str     r0,[sp,4h]                              
0803702A 9402     str     r4,[sp,8h]                              
0803702C 201B     mov     r0,1Bh                                  
0803702E F7D7F913 bl      800E258h     ;生产副精灵

@@end:                               
08037032 B003     add     sp,0Ch                                  
08037034 BC30     pop     r4,r5                                   
08037036 BC01     pop     r0                                      
08037038 4700     bx      r0                                      


;pose 27h                              
0803703C B500     push    r14                                     
0803703E F7D8FDC3 bl      800FBC8h                                
08037042 2800     cmp     r0,0h                                   
08037044 D009     beq     @@end                               
08037046 4906     ldr     r1,=3000738h                            
08037048 1C0A     mov     r2,r1                                   
0803704A 3224     add     r2,24h                                  
0803704C 2300     mov     r3,0h                                   
0803704E 2029     mov     r0,29h        ;写入新pose29                          
08037050 7010     strb    r0,[r2]                                 
08037052 4804     ldr     r0,=82EED0Ch  ;写入OAM                          
08037054 6188     str     r0,[r1,18h]                             
08037056 770B     strb    r3,[r1,1Ch]                             
08037058 82CB     strh    r3,[r1,16h]  

@@end:                           
0803705A BC01     pop     r0                                      
0803705C 4700     bx      r0                                      

;pose 29h                             
08037068 B500     push    r14                                     
0803706A F7D8FDC9 bl      800FC00h      ;检查动画是否结束                            
0803706E 2800     cmp     r0,0h                                   
08037070 D003     beq     @@end                                
08037072 4803     ldr     r0,=3000738h                            
08037074 3024     add     r0,24h                                
08037076 2108     mov     r1,8h         ;pose写入8h                           
08037078 7001     strb    r1,[r0] 

@@end:                                
0803707A BC01     pop     r0                                      
0803707C 4700     bx      r0                                      


;抛球pose 0                               
08037084 B530     push    r4,r5,r14                               
08037086 4C21     ldr     r4,=3000738h                            
08037088 8821     ldrh    r1,[r4]                                 
0803708A 4821     ldr     r0,=0FFFBh     ;去除3以上????                         
0803708C 4008     and     r0,r1          ;FFFB and 取向                            
0803708E 2500     mov     r5,0h                                   
08037090 2300     mov     r3,0h                                   
08037092 2280     mov     r2,80h                                  
08037094 0212     lsl     r2,r2,8h       ;8000h                         
08037096 1C11     mov     r1,r2                                   
08037098 4308     orr     r0,r1          ;8000 orr 取向                         
0803709A 8020     strh    r0,[r4]        ;写入取向                         
0803709C 1C22     mov     r2,r4                                   
0803709E 3232     add     r2,32h                                  
080370A0 7811     ldrb    r1,[r2]        ;读取碰撞属性                         
080370A2 2004     mov     r0,4h                                   
080370A4 4308     orr     r0,r1          ;orr 4                         
080370A6 7010     strb    r0,[r2]        ;再写入                         
080370A8 1C20     mov     r0,r4                                   
080370AA 3027     add     r0,27h                                  
080370AC 2208     mov     r2,8h          ;300075f写入8h                         
080370AE 7002     strb    r2,[r0]                                 
080370B0 3001     add     r0,1h                                   
080370B2 7002     strb    r2,[r0]        ;3000760写入8h                          
080370B4 3001     add     r0,1h                                   
080370B6 7002     strb    r2,[r0]        ;3000761写入8h                         
080370B8 4916     ldr     r1,=0FFF0h                              
080370BA 8161     strh    r1,[r4,0Ah]                             
080370BC 2010     mov     r0,10h                                  
080370BE 81A0     strh    r0,[r4,0Ch]                             
080370C0 81E1     strh    r1,[r4,0Eh]                             
080370C2 8220     strh    r0,[r4,10h]    ;四面分界各10h--                          
080370C4 7725     strb    r5,[r4,1Ch]    ;动画帧归零                         
080370C6 82E3     strh    r3,[r4,16h]                             
080370C8 1C20     mov     r0,r4                                   
080370CA 3024     add     r0,24h                                  
080370CC 7002     strb    r2,[r0]        ;pose写入8h                          
080370CE 1C21     mov     r1,r4                                   
080370D0 3125     add     r1,25h                                  
080370D2 2004     mov     r0,4h          ;属性写入4h                          
080370D4 7008     strb    r0,[r1]                                 
080370D6 3903     sub     r1,3h                                   
080370D8 2005     mov     r0,5h                                   
080370DA 7008     strb    r0,[r1]        ;300075a写入5                         
080370DC 4A0E     ldr     r2,=82B1BE4h                            
080370DE 7F61     ldrb    r1,[r4,1Dh]                             
080370E0 00C8     lsl     r0,r1,3h                                
080370E2 1840     add     r0,r0,r1                                
080370E4 0040     lsl     r0,r0,1h                                
080370E6 1880     add     r0,r0,r2                                
080370E8 8800     ldrh    r0,[r0]                                 
080370EA 82A0     strh    r0,[r4,14h]    ;写入血量                        
080370EC 20A0     mov     r0,0A0h                                 
080370EE 0040     lsl     r0,r0,1h       ;上下五格                         
080370F0 490A     ldr     r1,=226h       ;左右八格多                         
080370F2 F7D8FE75 bl      800FDE0h       ;检查和人物范围                         
080370F6 0600     lsl     r0,r0,18h                               
080370F8 0E00     lsr     r0,r0,18h                               
080370FA 2808     cmp     r0,8h                                   
080370FC D110     bne     @@LeftSpriteCheck                                
080370FE 8820     ldrh    r0,[r4]                                 
08037100 2280     mov     r2,80h                                  
08037102 0092     lsl     r2,r2,2h                                
08037104 1C11     mov     r1,r2                                   
08037106 4308     orr     r0,r1          ;取向orr200h再写入                             
08037108 8020     strh    r0,[r4]                                 
0803710A E00D     b       @@Peer                                

@@LeftSpriteCheck:                                
08037120 2804     cmp     r0,4h                                   
08037122 D001     beq     @@Peer                               
08037124 F7D8FB8E bl      800F844h         ;随机方向设定

@@Peer:                               
08037128 4A04     ldr     r2,=3000738h                            
0803712A 8811     ldrh    r1,[r2]                                 
0803712C 2080     mov     r0,80h                                  
0803712E 0080     lsl     r0,r0,2h         ;200h                        
08037130 4008     and     r0,r1                                   
08037132 1C13     mov     r3,r2                                   
08037134 2800     cmp     r0,0h                                   
08037136 D005     beq     @@LeftSprite                                
08037138 4801     ldr     r0,=82EED24h                            
0803713A E004     b       @@Peer2                                

@@LeftSprite:                              
08037144 4806     ldr     r0,=82EED4Ch 

@@Peer2:                           
08037146 6198     str     r0,[r3,18h]                             
08037148 1C19     mov     r1,r3                                   
0803714A 312C     add     r1,2Ch                                  
0803714C 2200     mov     r2,0h                                   
0803714E 2004     mov     r0,4h                                   
08037150 7008     strb    r0,[r1]        ;3000764写入4                          
08037152 1C18     mov     r0,r3                                   
08037154 302F     add     r0,2Fh                                  
08037156 7002     strb    r2,[r0]        ;3000767写入0                          
08037158 BC30     pop     r4,r5                                   
0803715A BC01     pop     r0                                      
0803715C 4700     bx      r0                                      


;抛球pose 8                               
08037164 B500     push    r14                                     
08037166 4A0E     ldr     r2,=3000738h                            
08037168 1C11     mov     r1,r2                                   
0803716A 312C     add     r1,2Ch                                  
0803716C 7808     ldrb    r0,[r1]        ;读取3000764的值                              
0803716E 3801     sub     r0,1h          ;减1再写入                         
08037170 7008     strb    r0,[r1]                                 
08037172 0600     lsl     r0,r0,18h                               
08037174 2800     cmp     r0,0h                                   
08037176 D110     bne     @@end                                
08037178 3908     sub     r1,8h                                   
0803717A 2009     mov     r0,9h                                   
0803717C 7008     strb    r0,[r1]        ;pose写入9h                          
0803717E 3101     add     r1,1h                                   
08037180 2006     mov     r0,6h                                   
08037182 7008     strb    r0,[r1]        ;属性写入6h                         
08037184 8810     ldrh    r0,[r2]                                 
08037186 4907     ldr     r1,=7FFFh                               
08037188 4001     and     r1,r0          ;取向and 7FFF                         
0803718A 8011     strh    r1,[r2]        ;再写入                         
0803718C 2002     mov     r0,2h                                   
0803718E 4008     and     r0,r1          ;2 and 取向                         
08037190 2800     cmp     r0,0h                                   
08037192 D002     beq     @@end          ;如果为0代表不再屏幕内                      
08037194 4804     ldr     r0,=17Dh       ;播放弹球音                         
08037196 F7CBFC3F bl      8002A18h 

@@end:                               
0803719A BC01     pop     r0                                      
0803719C 4700     bx      r0                                      

;pose 9
080371AC B570     push    r4-r6,r14                               
080371AE 2604     mov     r6,4h                                   
080371B0 480A     ldr     r0,=3000738h                            
080371B2 212F     mov     r1,2Fh                                  
080371B4 1809     add     r1,r1,r0                                
080371B6 468C     mov     r12,r1                                  
080371B8 780A     ldrb    r2,[r1]        ;读取3000767的值                       
080371BA 4D09     ldr     r5,=82EE718h                            
080371BC 0051     lsl     r1,r2,1h       ;乘以2                         
080371BE 1949     add     r1,r1,r5       ;加上偏移值                         
080371C0 2400     mov     r4,0h                                   
080371C2 5F0B     ldsh    r3,[r1,r4]     ;得到反数                         
080371C4 4907     ldr     r1,=7FFFh                               
080371C6 1C04     mov     r4,r0                                   
080371C8 428B     cmp     r3,r1                                   
080371CA D10D     bne     @@NoSame                                
080371CC 1E50     sub     r0,r2,1        ;3000767的值减1                         
080371CE 0040     lsl     r0,r0,1h       ;乘以2                         
080371D0 1940     add     r0,r0,r5       ;加上偏移地址                        
080371D2 2100     mov     r1,0h                                   
080371D4 5E40     ldsh    r0,[r0,r1]     ;得到反数                          
080371D6 8861     ldrh    r1,[r4,2h]     ;读取Y坐标                         
080371D8 1840     add     r0,r0,r1       ;相加                         
080371DA E00A     b       @@Peer                                 

@@NoSame:                              
080371E8 1C50     add     r0,r2,1        ;3000767的值加1                         
080371EA 4661     mov     r1,r12                                  
080371EC 7008     strb    r0,[r1]        ;再写入                         
080371EE 8860     ldrh    r0,[r4,2h]     ;读取Y坐标                         
080371F0 18C0     add     r0,r0,r3       ;相加

@@Peer:                              
080371F2 8060     strh    r0,[r4,2h]     ;Y坐标更新                         
080371F4 8821     ldrh    r1,[r4]                                 
080371F6 2080     mov     r0,80h                                  
080371F8 0080     lsl     r0,r0,2h                                
080371FA 4008     and     r0,r1          ;200 and 取向                         
080371FC 2800     cmp     r0,0h                                   
080371FE D002     beq     @@Left                                
08037200 88A0     ldrh    r0,[r4,4h]                              
08037202 1830     add     r0,r6,r0       ;水平坐标加4                         
08037204 E001     b       @@Peer2

@@Left:                                
08037206 88A0     ldrh    r0,[r4,4h]                              
08037208 1B80     sub     r0,r0,r6  

@@Peer2:                              
0803720A 80A0     strh    r0,[r4,4h]     ;更新水平坐标                          
0803720C 8860     ldrh    r0,[r4,2h]                              
0803720E 88A1     ldrh    r1,[r4,4h]                              
08037210 F7D8FA3A bl      800F688h       ;检查砖块                         
08037214 4806     ldr     r0,=30007F1h                            
08037216 7801     ldrb    r1,[r0]                                 
08037218 20F0     mov     r0,0F0h                                 
0803721A 4008     and     r0,r1                                   
0803721C 2800     cmp     r0,0h                                   
0803721E D003     beq     @@end         ;未接触砖块                       
08037220 1C21     mov     r1,r4                                   
08037222 3124     add     r1,24h        ;pose写入42h                           
08037224 2042     mov     r0,42h                                  
08037226 7008     strb    r0,[r1] 

@@end:                                
08037228 BC70     pop     r4-r6                                   
0803722A BC01     pop     r0                                      
0803722C 4700     bx      r0                                      


;pose 42h                               
08037234 B500     push    r14                                     
08037236 4A10     ldr     r2,=3000738h                            
08037238 4810     ldr     r0,=82EED74h   ;写入新的OAM                         
0803723A 6190     str     r0,[r2,18h]                             
0803723C 2000     mov     r0,0h                                   
0803723E 7710     strb    r0,[r2,1Ch]                             
08037240 82D0     strh    r0,[r2,16h]                             
08037242 1C11     mov     r1,r2                                   
08037244 3124     add     r1,24h         ;pose写入43h                          
08037246 2043     mov     r0,43h                                  
08037248 7008     strb    r0,[r1]                                 
0803724A 480D     ldr     r0,=3000088h                            
0803724C 7B01     ldrb    r1,[r0,0Ch]                             
0803724E 2003     mov     r0,3h                                   
08037250 4008     and     r0,r1          ;3000094的值 and 3                              
08037252 1C11     mov     r1,r2                                   
08037254 3121     add     r1,21h                                  
08037256 7008     strb    r0,[r1]        ;写入3000759h                          
08037258 8811     ldrh    r1,[r2]                                 
0803725A 2380     mov     r3,80h                                  
0803725C 021B     lsl     r3,r3,8h                                
0803725E 1C18     mov     r0,r3                                   
08037260 4308     orr     r0,r1         ;取向orr 8000                          
08037262 8010     strh    r0,[r2]                                 
08037264 2102     mov     r1,2h                                   
08037266 4008     and     r0,r1         ;2 and 取向                              
08037268 2800     cmp     r0,0h                                   
0803726A D003     beq     @@end                               
0803726C 20BF     mov     r0,0BFh       ;播放爆炸声音                          
0803726E 0040     lsl     r0,r0,1h                                
08037270 F7CBFBD2 bl      8002A18h

@@end:                                
08037274 BC01     pop     r0                                      
08037276 4700     bx      r0                                      


;pose 43                              
08037284 B510     push    r4,r14                                  
08037286 4C07     ldr     r4,=3000738h                            
08037288 1C21     mov     r1,r4                                   
0803728A 3126     add     r1,26h                                  
0803728C 2001     mov     r0,1h                                   
0803728E 7008     strb    r0,[r1]      ;300075E写入1h                            
08037290 F7D8FC9A bl      800FBC8h     ;检查动画                           
08037294 2800     cmp     r0,0h                                   
08037296 D001     beq     @@end                                
08037298 2000     mov     r0,0h                                   
0803729A 8020     strh    r0,[r4]  

@@end:                               
0803729C BC10     pop     r4                                      
0803729E BC01     pop     r0                                      
080372A0 4700     bx      r0                                      

/////////////////////////////////////////////////////////////////////////////////
;主程序                           
080372A8 B500     push    r14                                     
080372AA B081     add     sp,-4h                                  
080372AC 4804     ldr     r0,=3000738h                            
080372AE 1C01     mov     r1,r0                                   
080372B0 3130     add     r1,30h                                  
080372B2 7809     ldrb    r1,[r1]     ;读取冰冻时间                              
080372B4 1C02     mov     r2,r0                                   
080372B6 2900     cmp     r1,0h                                        
080372B8 D004     beq     @@NoFrozen                                
080372BA F7D8FE95 bl      800FFE8h    ;冰冻例程                          
080372BE E07D     b       @@end                                

@@NoFrozen:                             
080372C4 1C10     mov     r0,r2                                   
080372C6 3024     add     r0,24h                                  
080372C8 7800     ldrb    r0,[r0]     ;读取pose                            
080372CA 2829     cmp     r0,29h                                  
080372CC D86D     bhi     @@Death                             
080372CE 0080     lsl     r0,r0,2h                                
080372D0 4901     ldr     r1,=80372DCh  ;PoseTable                           
080372D2 1840     add     r0,r0,r1                                
080372D4 6800     ldr     r0,[r0]                                 
080372D6 4687     mov     r15,r0                                  

PoseTable:                            
     .word 8037384h  ;00
	 .word 80373aah .word 80373aah .word 80373aah .word 80373aah
	 .word 80373aah .word 80373aah .word 80373aah
	 .word 8037388h  ;08
	 .word 803738ch  ;09
	 .word 80373aah .word 80373aah .word 80373aah .word 80373aah
	 .word 80373aah .word 80373aah .word 80373aah .word 80373aah
	 .word 80373aah .word 80373aah .word 80373aah .word 80373aah
	 .word 80373aah .word 80373aah .word 80373aah .word 80373aah
	 .word 80373aah .word 80373aah .word 80373aah .word 80373aah
	 .word 80373aah .word 80373aah .word 80373aah .word 80373aah
	 .word 80373aah
	 .word 8037392h  ;23h
	 .word 80373aah
	 .word 8037398h  ;25h
	 .word 80373aah 
	 .word 803739eh  ;27h
	 .word 80373aah
	 .word 80373a4h  ;29h
	     	 
08037384 F7FFFD9E bl      8036EC4h    ;00                            
08037388 F7FFFDC2 bl      8036F10h    ;08                            
0803738C F7FFFDD2 bl      8036F34h    ;09                           
08037390 E014     b       @@end                                
08037392 F7FFFE09 bl      8036FA8h    ;23h                            
08037396 E011     b       @@end                                
08037398 F7FFFE1E bl      8036FD8h    ;25h                            
0803739C E00E     b       @@end                                
0803739E F7FFFE4D bl      803703Ch    ;27h                            
080373A2 E00B     b       @@end                                
080373A4 F7FFFE60 bl      8037068h    ;29h                            
080373A8 E008     b       @@end  

@@Death:                              
080373AA 8851     ldrh    r1,[r2,2h]                              
080373AC 3910     sub     r1,10h                                  
080373AE 8892     ldrh    r2,[r2,4h]                              
080373B0 2021     mov     r0,21h                                  
080373B2 9000     str     r0,[sp]                                 
080373B4 2000     mov     r0,0h                                   
080373B6 2301     mov     r3,1h                                   
080373B8 F7D9FE64 bl      8011084h    ;死亡例程

@@end:                                
080373BC B001     add     sp,4h                                   
080373BE BC01     pop     r0                                      
080373C0 4700     bx      r0                                      


////////////////////////////////////////////////////////////////////////////////////////////////////                               

;抛球主例程
080373C4 B500     push    r14                                     
080373C6 B081     add     sp,-4h                                  
080373C8 4804     ldr     r0,=3000738h                            
080373CA 1C01     mov     r1,r0                                   
080373CC 3130     add     r1,30h                                  
080373CE 7809     ldrb    r1,[r1]      ;检查冰冻                           
080373D0 1C02     mov     r2,r0                                   
080373D2 2900     cmp     r1,0h                                   
080373D4 D004     beq     @@NoFrozen                                
080373D6 F7D8FE07 bl      800FFE8h     ;冰冻例程                           
080373DA E02B     b       @@end                                

@@NoFrozen:                              
080373E0 1C10     mov     r0,r2                                   
080373E2 3024     add     r0,24h                                  
080373E4 7800     ldrb    r0,[r0]      ;读取pose                             
080373E6 2842     cmp     r0,42h       ;如果是42的话                           
080373E8 D017     beq     @@Pose42                                
080373EA 2842     cmp     r0,42h                                  
080373EC DC09     bgt     @@Posemore42                                
080373EE 2808     cmp     r0,8h                                   
080373F0 D00D     beq     @@Pose8                                
080373F2 2808     cmp     r0,8h                                   
080373F4 DC02     bgt     @@Posemore8                               
080373F6 2800     cmp     r0,0h                                   
080373F8 D006     beq     @@Pose0                                
080373FA E013     b       @@Death 

@@Posemore8:                               
080373FC 2809     cmp     r0,9h                                   
080373FE D009     beq     @@Pose9                               
08037400 E010     b       @@Death 

@@Posemore42:                               
08037402 2843     cmp     r0,43h                                  
08037404 D00B     beq     @@Pose43                                
08037406 E00D     b       @@Death

@@Pose0:                                
08037408 F7FFFE3C bl      8037084h                                
0803740C E012     b       @@end 

@@Pose8:                               
0803740E F7FFFEA9 bl      8037164h                                
08037412 E00F     b       @@end 

@@Pose9:                               
08037414 F7FFFECA bl      80371ACh                                
08037418 E00C     b       @@end  

@@Pose42:                              
0803741A F7FFFF0B bl      8037234h  

@@Pose43:                              
0803741E F7FFFF31 bl      8037284h                                
08037422 E007     b       @@end 

@@Death:                               
08037424 8851     ldrh    r1,[r2,2h]                              
08037426 8892     ldrh    r2,[r2,4h]                              
08037428 201F     mov     r0,1Fh                                  
0803742A 9000     str     r0,[sp]                                 
0803742C 2000     mov     r0,0h                                   
0803742E 2301     mov     r3,1h                                   
08037430 F7D9FE28 bl      8011084h 

@@end:                               
08037434 B001     add     sp,4h                                   
08037436 BC01     pop     r0                                      
08037438 4700     bx      r0                                      
