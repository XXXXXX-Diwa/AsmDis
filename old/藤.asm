
;调用例程
08026E28 B530     push    r4,r5,r14                               
08026E2A 0400     lsl     r0,r0,10h                               
08026E2C 0C04     lsr     r4,r0,10h      ;1                             
08026E2E 0409     lsl     r1,r1,10h                               
08026E30 0C09     lsr     r1,r1,10h      ;1                         
08026E32 1C0A     mov     r2,r1                                   
08026E34 4B07     ldr     r3,=3000738h                            
08026E36 202E     mov     r0,2Eh                                  
08026E38 18C0     add     r0,r0,r3                                
08026E3A 4684     mov     r12,r0                                  
08026E3C 7800     ldrb    r0,[r0]         ;读取3000766                        
08026E3E 2800     cmp     r0,0h                                   
08026E40 D00C     beq     @@766is0                                
08026E42 8A5A     ldrh    r2,[r3,12h]     ;读取74A                        
08026E44 2080     mov     r0,80h                                  
08026E46 0040     lsl     r0,r0,1h                                
08026E48 1B00     sub     r0,r0,r4        ;100h减设定值                         
08026E4A 4282     cmp     r2,r0           ;比较74a是否小于等于           
08026E4C DD04     ble     @@74alessthan                ;基本都会成立的                
08026E4E 1A50     sub     r0,r2,r1        ;74a的值减去设定值2                        
08026E50 8258     strh    r0,[r3,12h]     ;再写入                        
08026E52 E00F     b       @@end                                

@@74alessthan:                              
08026E58 2000     mov     r0,0h                                   
08026E5A E009     b       @@Peer

@@766is0:                                
08026E5C 8A59     ldrh    r1,[r3,12h]    ;读取74a的值                           
08026E5E 2580     mov     r5,80h                                  
08026E60 006D     lsl     r5,r5,1h                                
08026E62 1960     add     r0,r4,r5       ;100加上设定值                         
08026E64 4281     cmp     r1,r0          ;比较74a是否大于或等于                         
08026E66 DA02     bge     @@Pass                                
08026E68 1850     add     r0,r2,r1       ;否则74a加设定值2再写入                         
08026E6A 8258     strh    r0,[r3,12h]                             
08026E6C E002     b       @@end  

@@Pass:                             
08026E6E 2001     mov     r0,1h  

@@Peer:                                 
08026E70 4661     mov     r1,r12                                  
08026E72 7008     strb    r0,[r1]   ;766写入

@@end                                
08026E74 BC30     pop     r4,r5                                   
08026E76 BC01     pop     r0                                      
08026E78 4700     bx      r0                                      

;4F主精灵pose 0
08026E7C B5F0     push    r4-r7,r14                               
08026E7E 4657     mov     r7,r10                                  
08026E80 464E     mov     r6,r9                                   
08026E82 4645     mov     r5,r8                                   
08026E84 B4E0     push    r5-r7                                   
08026E86 B083     add     sp,-0Ch                                 
08026E88 4D14     ldr     r5,=300070Ch                            
08026E8A 4815     ldr     r0,=3000738h                            
08026E8C 4682     mov     r10,r0                                  
08026E8E 8840     ldrh    r0,[r0,2h]    ;读取Y坐标                           
08026E90 2100     mov     r1,0h                                   
08026E92 4689     mov     r9,r1                                   
08026E94 2400     mov     r4,0h                                   
08026E96 80E8     strh    r0,[r5,6h]    ;写入712h                           
08026E98 4652     mov     r2,r10                                  
08026E9A 8890     ldrh    r0,[r2,4h]    ;读取X坐标                          
08026E9C 8128     strh    r0,[r5,8h]    ;写入714h                           
08026E9E 2003     mov     r0,3h                                   
08026EA0 2122     mov     r1,22h                                  
08026EA2 F039FD0B bl      80608BCh      ;检查事件22h                           
08026EA6 1C07     mov     r7,r0                                   
08026EA8 2F00     cmp     r7,0h                                   
08026EAA D05D     beq     @@NoActivation                                
08026EAC 4650     mov     r0,r10                                  
08026EAE 7FC2     ldrb    r2,[r0,1Fh]                             
08026EB0 3023     add     r0,23h                                  
08026EB2 7803     ldrb    r3,[r0]                                 
08026EB4 88E8     ldrh    r0,[r5,6h]                              
08026EB6 9000     str     r0,[sp]                                 
08026EB8 8928     ldrh    r0,[r5,8h]                              
08026EBA 9001     str     r0,[sp,4h]                              
08026EBC 9402     str     r4,[sp,8h]                              
08026EBE 202B     mov     r0,2Bh       ;产卵2B-0 大概是藤断掉剩下的蒂                          
08026EC0 2100     mov     r1,0h                                   
08026EC2 F7E7F9C9 bl      800E258h                                
08026EC6 2003     mov     r0,3h                                   
08026EC8 2105     mov     r1,5h                                   
08026ECA F039FCF7 bl      80608BCh     ;检查飞船来临动画事件                           
08026ECE 1C03     mov     r3,r0                                   
08026ED0 2B00     cmp     r3,0h                                   
08026ED2 D007     beq     NoMotherboat                                
08026ED4 4651     mov     r1,r10                                  
08026ED6 800C     strh    r4,[r1]      ;消除精灵                           
08026ED8 E111     b       @@end                                

@@NoMotherboat:                        ;但是激活了藤死事件     
08026EE4 4650     mov     r0,r10                                  
08026EE6 8802     ldrh    r2,[r0]                                 
08026EE8 2180     mov     r1,80h                                  
08026EEA 0209     lsl     r1,r1,8h                                
08026EEC 1C08     mov     r0,r1                                   
08026EEE 4302     orr     r2,r0        ;取向orr8000h                              
08026EF0 4650     mov     r0,r10                                  
08026EF2 3025     add     r0,25h                                  
08026EF4 4649     mov     r1,r9                                   
08026EF6 7001     strb    r1,[r0]      ;属性写入0                            
08026EF8 4651     mov     r1,r10                                  
08026EFA 3127     add     r1,27h                                  
08026EFC 2038     mov     r0,38h                                  
08026EFE 7008     strb    r0,[r1]      ;75f写入38h                           
08026F00 3101     add     r1,1h                                   
08026F02 2018     mov     r0,18h       ;760写入18h                           
08026F04 7008     strb    r0,[r1]                                 
08026F06 3101     add     r1,1h                                   
08026F08 2028     mov     r0,28h       ;761写入28h                           
08026F0A 7008     strb    r0,[r1]                                 
08026F0C 4650     mov     r0,r10                                  
08026F0E 8143     strh    r3,[r0,0Ah]                             
08026F10 8183     strh    r3,[r0,0Ch]                             
08026F12 81C3     strh    r3,[r0,0Eh]                             
08026F14 8203     strh    r3,[r0,10h]  ;四面分界为0h                           
08026F16 3022     add     r0,22h                                  
08026F18 2104     mov     r1,4h                                   
08026F1A 7001     strb    r1,[r0]      ;75a写入4h                            
08026F1C 2008     mov     r0,8h                                   
08026F1E 4302     orr     r2,r0        ;取向orr 8008                           
08026F20 4650     mov     r0,r10                                  
08026F22 8002     strh    r2,[r0]      ;再写入                           
08026F24 2080     mov     r0,80h                                  
08026F26 0040     lsl     r0,r0,1h                                
08026F28 4652     mov     r2,r10                                  
08026F2A 8250     strh    r0,[r2,12h]  ;74A写入100h                           
08026F2C 4650     mov     r0,r10                                  
08026F2E 302A     add     r0,2Ah                                  
08026F30 464A     mov     r2,r9                                   
08026F32 7002     strb    r2,[r0]      ;762写入0h                            
08026F34 4650     mov     r0,r10                                  
08026F36 7781     strb    r1,[r0,1Eh]  ;读取副精灵DATA                           
08026F38 4809     ldr     r0,=82DE418h                            
08026F3A 6028     str     r0,[r5]      ;OAM写入70C                           
08026F3C 732A     strb    r2,[r5,0Ch]                             
08026F3E 80AB     strh    r3,[r5,4h]   ;归零                           
08026F40 4808     ldr     r0,=82E0BC0h                            
08026F42 4651     mov     r1,r10                                  
08026F44 6188     str     r0,[r1,18h]  ;OAM写入                           
08026F46 770A     strb    r2,[r1,1Ch]                             
08026F48 82CB     strh    r3,[r1,16h]                             
08026F4A 3124     add     r1,24h                                  
08026F4C 2027     mov     r0,27h                                  
08026F4E 7008     strb    r0,[r1]      ;pose写入27h                            
08026F50 22F0     mov     r2,0F0h                                 
08026F52 0092     lsl     r2,r2,2h                                
08026F54 1C10     mov     r0,r2                                   
08026F56 88E9     ldrh    r1,[r5,6h]                              
08026F58 1840     add     r0,r0,r1     ;Y坐标加3C0再写入,等于向下十五格                            
08026F5A 80E8     strh    r0,[r5,6h]                              
08026F5C E0CF     b       @@end                                                              

@@NoActivation:                              
08026F68 88EE     ldrh    r6,[r5,6h]   ;读取70C的Y坐标                           
08026F6A 892A     ldrh    r2,[r5,8h]   ;读取70C的X坐标                           
08026F6C 4690     mov     r8,r2                                   
08026F6E 4650     mov     r0,r10                                  
08026F70 80C6     strh    r6,[r0,6h]   ;写入738的备用Y坐标                           
08026F72 4651     mov     r1,r10                                  
08026F74 3127     add     r1,27h                                  
08026F76 2038     mov     r0,38h                                  
08026F78 7008     strb    r0,[r1]      ;75F写入38h                           
08026F7A 3101     add     r1,1h                                   
08026F7C 2018     mov     r0,18h                                  
08026F7E 7008     strb    r0,[r1]      ;760写入18h                           
08026F80 3101     add     r1,1h                                   
08026F82 2028     mov     r0,28h                                  
08026F84 7008     strb    r0,[r1]      ;761写入28h                           
08026F86 4862     ldr     r0,=0FF60h                              
08026F88 4651     mov     r1,r10                                  
08026F8A 8148     strh    r0,[r1,0Ah]                             
08026F8C 818F     strh    r7,[r1,0Ch]                             
08026F8E 3040     add     r0,40h                                  
08026F90 81C8     strh    r0,[r1,0Eh]                             
08026F92 2060     mov     r0,60h                                  
08026F94 8208     strh    r0,[r1,10h]  ;四面分界                           
08026F96 4650     mov     r0,r10                                  
08026F98 3022     add     r0,22h                                  
08026F9A 2306     mov     r3,6h        ;75A写入6h                           
08026F9C 7003     strb    r3,[r0]                                 
08026F9E 3003     add     r0,3h                                   
08026FA0 2404     mov     r4,4h                                   
08026FA2 7004     strb    r4,[r0]      ;属性写入4h                            
08026FA4 4A5B     ldr     r2,=82B0D68h                            
08026FA6 7F49     ldrb    r1,[r1,1Dh]                             
08026FA8 00C8     lsl     r0,r1,3h                                
08026FAA 1840     add     r0,r0,r1                                
08026FAC 0040     lsl     r0,r0,1h                                
08026FAE 1880     add     r0,r0,r2                                
08026FB0 8800     ldrh    r0,[r0]      ;读取设定的最大血量                            
08026FB2 4652     mov     r2,r10                                  
08026FB4 8290     strh    r0,[r2,14h]  ;写入当前血量                            
08026FB6 8810     ldrh    r0,[r2]                                 
08026FB8 2208     mov     r2,8h                                   
08026FBA 4310     orr     r0,r2        ;取向orr8h                           
08026FBC 4651     mov     r1,r10                                  
08026FBE 8008     strh    r0,[r1]      ;再写入                           
08026FC0 2080     mov     r0,80h                                  
08026FC2 0040     lsl     r0,r0,1h                                
08026FC4 8248     strh    r0,[r1,12h]  ;74a写入100h                           
08026FC6 4650     mov     r0,r10                                  
08026FC8 302A     add     r0,2Ah                                   
08026FCA 4649     mov     r1,r9                                   
08026FCC 7001     strb    r1,[r0]      ;762写入0h                           
08026FCE 3004     add     r0,4h                                   
08026FD0 7001     strb    r1,[r0]      ;766写入0h                           
08026FD2 4851     ldr     r0,=82DE418h                            
08026FD4 6028     str     r0,[r5]                                 
08026FD6 7329     strb    r1,[r5,0Ch]  ;OAM写入70c                           
08026FD8 80AF     strh    r7,[r5,4h]                              
08026FDA 73A9     strb    r1,[r5,0Eh]  ;71A写入0h                           
08026FDC 7369     strb    r1,[r5,0Dh]  ;719写入0h                           
08026FDE 816B     strh    r3,[r5,0Ah]  ;716写入6h                           
08026FE0 494E     ldr     r1,=300007Bh                            
08026FE2 2001     mov     r0,1h                                   
08026FE4 7008     strb    r0,[r1]      ;关门TAG                           
08026FE6 4650     mov     r0,r10                                  
08026FE8 3024     add     r0,24h                                  
08026FEA 7002     strb    r2,[r0]      ;pose写入8h                           
08026FEC 4652     mov     r2,r10                                  
08026FEE 7794     strb    r4,[r2,1Eh]  ;副精灵data写入4h                           
08026FF0 7FD5     ldrb    r5,[r2,1Fh]  ;读取GFXROW                           
08026FF2 3801     sub     r0,1h                                   
08026FF4 7804     ldrb    r4,[r0]                                 
08026FF6 9600     str     r6,[sp]                                 
08026FF8 4640     mov     r0,r8                                   
08026FFA 9001     str     r0,[sp,4h]                              
08026FFC 9702     str     r7,[sp,8h]                              
08026FFE 2014     mov     r0,14h                                  
08027000 2101     mov     r1,1h                                   
08027002 1C2A     mov     r2,r5                                   
08027004 1C23     mov     r3,r4                                   
08027006 F7E7F927 bl      800E258h    ;产卵副精灵14-1                             
0802700A 9600     str     r6,[sp]                                 
0802700C 4641     mov     r1,r8                                   
0802700E 9101     str     r1,[sp,4h]                              
08027010 9702     str     r7,[sp,8h]                              
08027012 2014     mov     r0,14h                                  
08027014 2102     mov     r1,2h                                   
08027016 1C2A     mov     r2,r5                                   
08027018 1C23     mov     r3,r4                                   
0802701A F7E7F91D bl      800E258h    ;产卵副精灵14-2                            
0802701E 9600     str     r6,[sp]                                 
08027020 4642     mov     r2,r8                                   
08027022 9201     str     r2,[sp,4h]                              
08027024 9702     str     r7,[sp,8h]                              
08027026 2014     mov     r0,14h                                  
08027028 2100     mov     r1,0h                                   
0802702A 1C2A     mov     r2,r5                                   
0802702C 1C23     mov     r3,r4                                   
0802702E F7E7F913 bl      800E258h    ;产卵副精灵14-0                            
08027032 0600     lsl     r0,r0,18h                               
08027034 0E00     lsr     r0,r0,18h                               
08027036 493A     ldr     r1,=30001ACh                            
08027038 468A     mov     r10,r1                                  
0802703A 00C1     lsl     r1,r0,3h                                
0802703C 1A09     sub     r1,r1,r0                                
0802703E 00C9     lsl     r1,r1,3h                                
08027040 4451     add     r1,r10                                  
08027042 312D     add     r1,2Dh                                  
08027044 7008     strb    r0,[r1]     ;1ac处的副精灵数据765写入再生产次数                            
08027046 9600     str     r6,[sp]                                 
08027048 4642     mov     r2,r8                                   
0802704A 9201     str     r2,[sp,4h]                              
0802704C 9702     str     r7,[sp,8h]                              
0802704E 2014     mov     r0,14h                                  
08027050 2103     mov     r1,3h                                   
08027052 1C2A     mov     r2,r5                                   
08027054 1C23     mov     r3,r4                                   
08027056 F7E7F8FF bl      800E258h    ;产卵14-3                             
0802705A 9600     str     r6,[sp]                                 
0802705C 4640     mov     r0,r8                                   
0802705E 9001     str     r0,[sp,4h]                              
08027060 9702     str     r7,[sp,8h]                              
08027062 2014     mov     r0,14h                                  
08027064 2105     mov     r1,5h                                   
08027066 1C2A     mov     r2,r5                                   
08027068 1C23     mov     r3,r4                                   
0802706A F7E7F8F5 bl      800E258h    ;产卵14-5                             
0802706E 9600     str     r6,[sp]                                 
08027070 4641     mov     r1,r8                                   
08027072 9101     str     r1,[sp,4h]                              
08027074 9702     str     r7,[sp,8h]                              
08027076 2014     mov     r0,14h                                  
08027078 2106     mov     r1,6h                                   
0802707A 1C2A     mov     r2,r5                                   
0802707C 1C23     mov     r3,r4                                   
0802707E F7E7F8EB bl      800E258h    ;产卵14-6                             
08027082 9600     str     r6,[sp]                                 
08027084 4642     mov     r2,r8                                   
08027086 9201     str     r2,[sp,4h]                              
08027088 9702     str     r7,[sp,8h]                              
0802708A 2014     mov     r0,14h                                  
0802708C 2107     mov     r1,7h                                   
0802708E 1C2A     mov     r2,r5                                   
08027090 1C23     mov     r3,r4                                   
08027092 F7E7F8E1 bl      800E258h    ;产卵14-7                             
08027096 9600     str     r6,[sp]                                 
08027098 4640     mov     r0,r8                                   
0802709A 9001     str     r0,[sp,4h]                              
0802709C 9702     str     r7,[sp,8h]                              
0802709E 2014     mov     r0,14h                                  
080270A0 2108     mov     r1,8h                                   
080270A2 1C2A     mov     r2,r5                                   
080270A4 1C23     mov     r3,r4                                   
080270A6 F7E7F8D7 bl      800E258h    ;产卵14-8                             
080270AA 9600     str     r6,[sp]                                 
080270AC 4641     mov     r1,r8                                   
080270AE 9101     str     r1,[sp,4h]                              
080270B0 9702     str     r7,[sp,8h]                              
080270B2 2014     mov     r0,14h                                  
080270B4 2109     mov     r1,9h                                   
080270B6 1C2A     mov     r2,r5                                   
080270B8 1C23     mov     r3,r4                                   
080270BA F7E7F8CD bl      800E258h    ;产卵14-9                             
080270BE 2280     mov     r2,80h                                  
080270C0 0052     lsl     r2,r2,1h                                
080270C2 18B2     add     r2,r6,r2                                
080270C4 9200     str     r2,[sp]                                 
080270C6 4640     mov     r0,r8                                   
080270C8 9001     str     r0,[sp,4h]                              
080270CA 2040     mov     r0,40h                                  
080270CC 9002     str     r0,[sp,8h]                              
080270CE 2006     mov     r0,6h                                   
080270D0 2100     mov     r1,0h                                   
080270D2 1C2A     mov     r2,r5                                   
080270D4 1C23     mov     r3,r4                                   
080270D6 F7E7F8BF bl      800E258h    ;产卵6-0   乌龟                         
080270DA 0600     lsl     r0,r0,18h                               
080270DC 0E00     lsr     r0,r0,18h                               
080270DE 00C1     lsl     r1,r0,3h                                
080270E0 1A09     sub     r1,r1,r0                                
080270E2 00C9     lsl     r1,r1,3h                                
080270E4 4451     add     r1,r10                                  
080270E6 22C0     mov     r2,0C0h                                 
080270E8 0052     lsl     r2,r2,1h                                
080270EA 18B6     add     r6,r6,r2    ;180h加上备用Y坐标或者70c的Y坐标                            
080270EC 80CE     strh    r6,[r1,6h]  ;写入当前副备用坐标                            
080270EE 20C0     mov     r0,0C0h                                 
080270F0 4240     neg     r0,r0                                   
080270F2 4480     add     r8,r0       ;X坐标减去C0                            
080270F4 4642     mov     r2,r8                                   
080270F6 810A     strh    r2,[r1,8h]  ;写入当前副备用坐标                             
080270F8 490A     ldr     r1,=300080Ch                            
080270FA 2002     mov     r0,2h                                   
080270FC 8008     strh    r0,[r1]

@@end:                                 
080270FE B003     add     sp,0Ch                                  
08027100 BC38     pop     r3-r5                                   
08027102 4698     mov     r8,r3                                   
08027104 46A1     mov     r9,r4                                   
08027106 46AA     mov     r10,r5                                  
08027108 BCF0     pop     r4-r7                                   
0802710A BC01     pop     r0                                      
0802710C 4700     bx      r0                                      

                              
08027128 B500     push    r14                                     
0802712A 4808     ldr     r0,=3000738h                            
0802712C 1C01     mov     r1,r0                                   
0802712E 312F     add     r1,2Fh                                  
08027130 7808     ldrb    r0,[r1]                                 
08027132 282F     cmp     r0,2Fh                                  
08027134 D801     bhi     802713Ah                                
08027136 3001     add     r0,1h                                   
08027138 7008     strb    r0,[r1]                                 
0802713A 7808     ldrb    r0,[r1]                                 
0802713C 0880     lsr     r0,r0,2h                                
0802713E 4904     ldr     r1,=300070Ch                            
08027140 3008     add     r0,8h                                   
08027142 88CA     ldrh    r2,[r1,6h]                              
08027144 1880     add     r0,r0,r2                                
08027146 80C8     strh    r0,[r1,6h]                              
08027148 BC01     pop     r0                                      
0802714A 4700     bx      r0                                      


;4F pose 8                              
08027154 B530     push    r4,r5,r14                               
08027156 4C0E     ldr     r4,=300080Ch   ;读取80c   一开始是2,到了boss下面为1.然后改变音乐为0                       
08027158 8821     ldrh    r1,[r4]                                 
0802715A 2900     cmp     r1,0h                                   
0802715C D034     beq     @@Goto                                
0802715E 2902     cmp     r1,2h                                   
08027160 D11E     bne     @@80cNo2                                
08027162 480C     ldr     r0,=3000738h                            
08027164 8800     ldrh    r0,[r0]        ;读取取向                            
08027166 4001     and     r1,r0          ;和随机值and                         
08027168 2900     cmp     r1,0h                                   
0802716A D02D     beq     @@Goto                                
0802716C 4A0A     ldr     r2,=300070Ch                            
0802716E 490B     ldr     r1,=30013D4h                            
08027170 88D0     ldrh    r0,[r2,6h]     ;读取70C的Y坐标                          
08027172 8A8B     ldrh    r3,[r1,14h]    ;读取人物Y坐标                         
08027174 4298     cmp     r0,r3          ;如果大于则跳转                         
08027176 D227     bcs     @@Goto                                
08027178 8A88     ldrh    r0,[r1,14h]    ;读取人物Y坐标                         
0802717A 88D1     ldrh    r1,[r2,6h]     ;读取70C的Y坐标                         
0802717C 1A40     sub     r0,r0,r1       ;人物Y坐标减去70C的Y坐标                         
0802717E 2180     mov     r1,80h                                  
08027180 0089     lsl     r1,r1,2h                                
08027182 4288     cmp     r0,r1          ;比较是否这个距离是否小于等于100则跳转                        
08027184 DD20     ble     @@Goto                                
08027186 2050     mov     r0,50h                                  
08027188 F7DCFC86 bl      8003A98h       ;播放声音???  用来停止音乐???                       
0802718C 2001     mov     r0,1h                                   
0802718E E01A     b       @@Peer                                

@@80cNo2:                              
080271A0 2901     cmp     r1,1h          ;随机数不是1跳转                            
080271A2 D111     bne     @@Goto                                
080271A4 4A2F     ldr     r2,=300070Ch                            
080271A6 4930     ldr     r1,=30013D4h                            
080271A8 8910     ldrh    r0,[r2,8h]     ;读取70cX坐标                         
080271AA 8A4B     ldrh    r3,[r1,12h]    ;读取人物X坐标                         
080271AC 4298     cmp     r0,r3          ;70cX坐标大于人物坐标跳转                         
080271AE D20B     bcs     @@Goto                                
080271B0 8A48     ldrh    r0,[r1,12h]                             
080271B2 8911     ldrh    r1,[r2,8h]                              
080271B4 1A40     sub     r0,r0,r1       ;人物X坐标减去70CX坐标                         
080271B6 492D     ldr     r1,=1BFh                                
080271B8 4288     cmp     r0,r1          ;和1BF比较大于则跳转                          
080271BA DC05     bgt     @@Goto                                
080271BC 203F     mov     r0,3Fh                                  
080271BE 2100     mov     r1,0h                                   
080271C0 F7DCFC18 bl      80039F4h       ;播放boss音乐                            
080271C4 2000     mov     r0,0h  

@@Peer:                                 
080271C6 8020     strh    r0,[r4]        ;80C写入0

@@Goto:                                
080271C8 4829     ldr     r0,=3000738h                            
080271CA 8AC1     ldrh    r1,[r0,16h]    ;读取动画                         
080271CC 7F00     ldrb    r0,[r0,1Ch]    ;读取动画帧                         
080271CE 2801     cmp     r0,1h                                   
080271D0 D106     bne     @@AnimationFramesNo1OrAnimationNo2                                
080271D2 2900     cmp     r1,0h                                   
080271D4 D001     beq     @Animation0                                
080271D6 2902     cmp     r1,2h                                   
080271D8 D102     bne     @@AnimationFramesNo1OrAnimationNo2

@@Animation0:                                
080271DA 4826     ldr     r0,=19Fh                                
080271DC F7DBFC1C bl      8002A18h 

@@AnimationFramesNo1OrAnimationNo2:                               
080271E0 4820     ldr     r0,=300070Ch                            
080271E2 8940     ldrh    r0,[r0,0Ah]      ;读取716h                       
080271E4 2803     cmp     r0,3h                                   
080271E6 D810     bhi     @@Pass                                
080271E8 4821     ldr     r0,=3000738h                            
080271EA 1C01     mov     r1,r0                                   
080271EC 3120     add     r1,20h                                  
080271EE 2201     mov     r2,1h                                   
080271F0 700A     strb    r2,[r1]          ;758调色板写入1                            
080271F2 3034     add     r0,34h                                  
080271F4 7002     strb    r2,[r0]          ;击打变色值写入1                        
080271F6 4820     ldr     r0,=3000C77h                            
080271F8 7801     ldrb    r1,[r0]          ;读取1bit的循环数                       
080271FA 203F     mov     r0,3Fh                                  
080271FC 4008     and     r0,r1            ;和3F and                       
080271FE 2800     cmp     r0,0h                                   
08027200 D103     bne     @@Pass                                
08027202 2001     mov     r0,1h                                   
08027204 2101     mov     r1,1h                                   
08027206 F7FFFE0F bl      8026E28h         

@@Pass:                               
0802720A 4C16     ldr     r4,=300070Ch                            
0802720C 8965     ldrh    r5,[r4,0Ah]      ;读取716的值                       
0802720E 2D00     cmp     r5,0h            ;不为0则结束                       
08027210 D124     bne     @@end                                
08027212 4B17     ldr     r3,=3000738h                            
08027214 1C18     mov     r0,r3                                   
08027216 3020     add     r0,20h                                   
08027218 2102     mov     r1,2h                                   
0802721A 7001     strb    r1,[r0]          ;758写入2,调色板                          
0802721C 3014     add     r0,14h                                  
0802721E 7001     strb    r1,[r0]          ;血量写入2                       
08027220 881A     ldrh    r2,[r3]                                 
08027222 2180     mov     r1,80h                                  
08027224 0209     lsl     r1,r1,8h                                
08027226 1C08     mov     r0,r1                                   
08027228 2100     mov     r1,0h                                   
0802722A 4310     orr     r0,r2            ;取向orr8000h                       
0802722C 8018     strh    r0,[r3]          ;再写入                       
0802722E 1C18     mov     r0,r3                                   
08027230 3025     add     r0,25h                                  
08027232 7001     strb    r1,[r0]          ;属性写入0h                       
08027234 4811     ldr     r0,=82DE440h                            
08027236 6020     str     r0,[r4]                                 
08027238 7321     strb    r1,[r4,0Ch]                             
0802723A 80A5     strh    r5,[r4,4h]                              
0802723C 1C18     mov     r0,r3                                   
0802723E 302C     add     r0,2Ch                                  
08027240 7001     strb    r1,[r0]                                 
08027242 3003     add     r0,3h                                   
08027244 7001     strb    r1,[r0]                                 
08027246 1C19     mov     r1,r3                                   
08027248 3124     add     r1,24h                                  
0802724A 2009     mov     r0,9h                                   
0802724C 7008     strb    r0,[r1]                                 
0802724E 2001     mov     r0,1h                                   
08027250 2122     mov     r1,22h                                  
08027252 F039FB33 bl      80608BCh                                
08027256 480A     ldr     r0,=1A3h                                
08027258 F7DBFBDE bl      8002A18h

@@end:                                
0802725C BC30     pop     r4,r5                                   
0802725E BC01     pop     r0                                      
08027260 4700     bx      r0                                      


;pose 09                               
08027284 B5F0     push    r4-r7,r14                               
08027286 B083     add     sp,-0Ch                                 
08027288 481B     ldr     r0,=3000C77h                            
0802728A 7801     ldrb    r1,[r0]                                 
0802728C 201F     mov     r0,1Fh                                  
0802728E 4008     and     r0,r1                                   
08027290 2800     cmp     r0,0h                                   
08027292 D103     bne     802729Ch                                
08027294 2001     mov     r0,1h                                   
08027296 2101     mov     r1,1h                                   
08027298 F7FFFDC6 bl      8026E28h                                
0802729C 4C17     ldr     r4,=300070Ch                            
0802729E 88A0     ldrh    r0,[r4,4h]                              
080272A0 2807     cmp     r0,7h                                   
080272A2 D931     bls     8027308h                                
080272A4 F7FFFF40 bl      8027128h                                
080272A8 21C0     mov     r1,0C0h                                 
080272AA 0049     lsl     r1,r1,1h                                
080272AC 1C08     mov     r0,r1                                   
080272AE 88E1     ldrh    r1,[r4,6h]                              
080272B0 1840     add     r0,r0,r1                                
080272B2 0400     lsl     r0,r0,10h                               
080272B4 0C06     lsr     r6,r0,10h                               
080272B6 8925     ldrh    r5,[r4,8h]                              
080272B8 1C30     mov     r0,r6                                   
080272BA 1C29     mov     r1,r5                                   
080272BC F7E8F9E4 bl      800F688h                                
080272C0 480F     ldr     r0,=30007F1h                            
080272C2 7801     ldrb    r1,[r0]                                 
080272C4 20F0     mov     r0,0F0h                                 
080272C6 4008     and     r0,r1                                   
080272C8 2800     cmp     r0,0h                                   
080272CA D100     bne     80272CEh                                
080272CC E08F     b       80273EEh                                
080272CE 2001     mov     r0,1h                                   
080272D0 F7FFFCE6 bl      8026CA0h                                
080272D4 490B     ldr     r1,=3000738h                            
080272D6 1C0A     mov     r2,r1                                   
080272D8 3224     add     r2,24h                                  
080272DA 2300     mov     r3,0h                                   
080272DC 2023     mov     r0,23h                                  
080272DE 7010     strb    r0,[r2]                                 
080272E0 312C     add     r1,2Ch                                  
080272E2 700B     strb    r3,[r1]                                 
080272E4 2028     mov     r0,28h                                  
080272E6 2181     mov     r1,81h                                  
080272E8 F02EF82C bl      8055344h                                
080272EC 20D2     mov     r0,0D2h                                 
080272EE 0040     lsl     r0,r0,1h                                
080272F0 F7DBFB92 bl      8002A18h                                
080272F4 E07B     b       80273EEh                                
080272F6 0000     lsl     r0,r0,0h                                
080272F8 0C77     lsr     r7,r6,11h                               
080272FA 0300     lsl     r0,r0,0Ch                               
080272FC 070C     lsl     r4,r1,1Ch                               
080272FE 0300     lsl     r0,r0,0Ch                               
08027300 07F1     lsl     r1,r6,1Fh                               
08027302 0300     lsl     r0,r0,0Ch                               
08027304 0738     lsl     r0,r7,1Ch                               
08027306 0300     lsl     r0,r0,0Ch                               
08027308 2807     cmp     r0,7h                                   
0802730A D110     bne     802732Eh                                
0802730C 7B20     ldrb    r0,[r4,0Ch]                             
0802730E 2806     cmp     r0,6h                                   
08027310 D10D     bne     802732Eh                                
08027312 4817     ldr     r0,=3000738h                            
08027314 7FC2     ldrb    r2,[r0,1Fh]                             
08027316 3023     add     r0,23h                                  
08027318 7803     ldrb    r3,[r0]                                 
0802731A 88E0     ldrh    r0,[r4,6h]                              
0802731C 9000     str     r0,[sp]                                 
0802731E 8920     ldrh    r0,[r4,8h]                              
08027320 9001     str     r0,[sp,4h]                              
08027322 2000     mov     r0,0h                                   
08027324 9002     str     r0,[sp,8h]                              
08027326 202B     mov     r0,2Bh                                  
08027328 2100     mov     r1,0h                                   
0802732A F7E6FF95 bl      800E258h                                
0802732E 4811     ldr     r0,=30013BAh                            
08027330 8800     ldrh    r0,[r0]                                 
08027332 3840     sub     r0,40h                                  
08027334 0400     lsl     r0,r0,10h                               
08027336 0C06     lsr     r6,r0,10h                               
08027338 480F     ldr     r0,=300070Ch                            
0802733A 8905     ldrh    r5,[r0,8h]                              
0802733C 480F     ldr     r0,=300083Ch                            
0802733E 7804     ldrb    r4,[r0]                                 
08027340 490B     ldr     r1,=3000738h                            
08027342 312C     add     r1,2Ch                                  
08027344 7808     ldrb    r0,[r1]                                 
08027346 3001     add     r0,1h                                   
08027348 7008     strb    r0,[r1]                                 
0802734A 0600     lsl     r0,r0,18h                               
0802734C 0E07     lsr     r7,r0,18h                               
0802734E 201F     mov     r0,1Fh                                  
08027350 4038     and     r0,r7                                   
08027352 2800     cmp     r0,0h                                   
08027354 D11C     bne     8027390h                                
08027356 2020     mov     r0,20h                                  
08027358 4038     and     r0,r7                                   
0802735A 2800     cmp     r0,0h                                   
0802735C D010     beq     8027380h                                
0802735E 00E3     lsl     r3,r4,3h                                
08027360 3B5A     sub     r3,5Ah                                  
08027362 1AEB     sub     r3,r5,r3                                
08027364 2000     mov     r0,0h                                   
08027366 2105     mov     r1,5h                                   
08027368 1C32     mov     r2,r6                                   
0802736A F7EAFD6D bl      8011E48h                                
0802736E E00F     b       8027390h                                
08027370 0738     lsl     r0,r7,1Ch                               
08027372 0300     lsl     r0,r0,0Ch                               
08027374 13BA     asr     r2,r7,0Eh                               
08027376 0300     lsl     r0,r0,0Ch                               
08027378 070C     lsl     r4,r1,1Ch                               
0802737A 0300     lsl     r0,r0,0Ch                               
0802737C 083C     lsr     r4,r7,20h                               
0802737E 0300     lsl     r0,r0,0Ch                               
08027380 00E3     lsl     r3,r4,3h                                
08027382 3B46     sub     r3,46h                                  
08027384 18EB     add     r3,r5,r3                                
08027386 2000     mov     r0,0h                                   
08027388 2107     mov     r1,7h                                   
0802738A 1C32     mov     r2,r6                                   
0802738C F7EAFD5C bl      8011E48h                                
08027390 480D     ldr     r0,=300070Ch                            
08027392 8880     ldrh    r0,[r0,4h]                              
08027394 2803     cmp     r0,3h                                   
08027396 D92A     bls     80273EEh                                
08027398 2001     mov     r0,1h                                   
0802739A 4038     and     r0,r7                                   
0802739C 2800     cmp     r0,0h                                   
0802739E D126     bne     80273EEh                                
080273A0 2C07     cmp     r4,7h                                   
080273A2 D913     bls     80273CCh                                
080273A4 00A4     lsl     r4,r4,2h                                
080273A6 1C23     mov     r3,r4                                   
080273A8 3B96     sub     r3,96h                                  
080273AA 18EB     add     r3,r5,r3                                
080273AC 2000     mov     r0,0h                                   
080273AE 2108     mov     r1,8h                                   
080273B0 1C32     mov     r2,r6                                   
080273B2 F7EAFD49 bl      8011E48h                                
080273B6 3C20     sub     r4,20h                                  
080273B8 1B2C     sub     r4,r5,r4                                
080273BA 2000     mov     r0,0h                                   
080273BC 2106     mov     r1,6h                                   
080273BE 1C32     mov     r2,r6                                   
080273C0 1C23     mov     r3,r4                                   
080273C2 F7EAFD41 bl      8011E48h                                
080273C6 E012     b       80273EEh                                
080273C8 070C     lsl     r4,r1,1Ch                               
080273CA 0300     lsl     r0,r0,0Ch                               
080273CC 00A4     lsl     r4,r4,2h                                
080273CE 1C23     mov     r3,r4                                   
080273D0 3B82     sub     r3,82h                                  
080273D2 1AEB     sub     r3,r5,r3                                
080273D4 2000     mov     r0,0h                                   
080273D6 2106     mov     r1,6h                                   
080273D8 1C32     mov     r2,r6                                   
080273DA F7EAFD35 bl      8011E48h                                
080273DE 3C20     sub     r4,20h                                  
080273E0 192C     add     r4,r5,r4                                
080273E2 2000     mov     r0,0h                                   
080273E4 2108     mov     r1,8h                                   
080273E6 1C32     mov     r2,r6                                   
080273E8 1C23     mov     r3,r4                                   
080273EA F7EAFD2D bl      8011E48h                                
080273EE B003     add     sp,0Ch                                  
080273F0 BCF0     pop     r4-r7                                   
080273F2 BC01     pop     r0                                      
080273F4 4700     bx      r0                                      


;4F pose 23                               
080273F8 B570     push    r4-r6,r14                               
080273FA 480F     ldr     r0,=3000C77h                            
080273FC 7801     ldrb    r1,[r0]        ;读取1bit的循环数                         
080273FE 2001     mov     r0,1h                                   
08027400 4008     and     r0,r1                                   
08027402 2800     cmp     r0,0h          ;不是奇数则跳转                          
08027404 D103     bne     @@NooneNum                                
08027406 2001     mov     r0,1h                                   
08027408 2101     mov     r1,1h                                   
0802740A F7FFFD0D bl      8026E28h 

@@NooneNum:                               
0802740E F7FFFE8B bl      8027128h                                
08027412 490A     ldr     r1,=300070Ch                            
08027414 88C8     ldrh    r0,[r1,6h]                              
08027416 30E8     add     r0,0E8h                                 
08027418 0400     lsl     r0,r0,10h                               
0802741A 0C06     lsr     r6,r0,10h                               
0802741C 890D     ldrh    r5,[r1,8h]                              
0802741E 4908     ldr     r1,=3000738h                            
08027420 312C     add     r1,2Ch                                  
08027422 7808     ldrb    r0,[r1]                                 
08027424 3001     add     r0,1h                                   
08027426 7008     strb    r0,[r1]                                 
08027428 0600     lsl     r0,r0,18h                               
0802742A 0E00     lsr     r0,r0,18h                               
0802742C 2804     cmp     r0,4h                                   
0802742E D109     bne     8027444h                                
08027430 2001     mov     r0,1h                                   
08027432 F7FFFC55 bl      8026CE0h                                
08027436 E020     b       802747Ah                                
08027438 0C77     lsr     r7,r6,11h                               
0802743A 0300     lsl     r0,r0,0Ch                               
0802743C 070C     lsl     r4,r1,1Ch                               
0802743E 0300     lsl     r0,r0,0Ch                               
08027440 0738     lsl     r0,r7,1Ch                               
08027442 0300     lsl     r0,r0,0Ch                               
08027444 2808     cmp     r0,8h                                   
08027446 D103     bne     8027450h                                
08027448 2001     mov     r0,1h                                   
0802744A F7FFFC81 bl      8026D50h                                
0802744E E014     b       802747Ah                                
08027450 280F     cmp     r0,0Fh                                  
08027452 D112     bne     802747Ah                                
08027454 1C34     mov     r4,r6                                   
08027456 34C0     add     r4,0C0h                                 
08027458 1C29     mov     r1,r5                                   
0802745A 3164     add     r1,64h                                  
0802745C 1C20     mov     r0,r4                                   
0802745E 2236     mov     r2,36h                                  
08027460 F02CFE44 bl      80540ECh                                
08027464 1C29     mov     r1,r5                                   
08027466 3964     sub     r1,64h                                  
08027468 1C20     mov     r0,r4                                   
0802746A 2236     mov     r2,36h                                  
0802746C F02CFE3E bl      80540ECh                                
08027470 1C20     mov     r0,r4                                   
08027472 1C29     mov     r1,r5                                   
08027474 221E     mov     r2,1Eh                                  
08027476 F02CFE39 bl      80540ECh                                
0802747A 1C30     mov     r0,r6                                   
0802747C 1C29     mov     r1,r5                                   
0802747E F7E7FFFD bl      800F47Ch       ;检查地面                           
08027482 1C02     mov     r2,r0                                   
08027484 4816     ldr     r0,=30007F0h                            
08027486 7800     ldrb    r0,[r0]                                 
08027488 2800     cmp     r0,0h                                   
0802748A D026     beq     80274DAh                                
0802748C 4D15     ldr     r5,=3000738h                            
0802748E 4816     ldr     r0,=82E0BC0h                            
08027490 61A8     str     r0,[r5,18h]                             
08027492 2000     mov     r0,0h                                   
08027494 7728     strb    r0,[r5,1Ch]                             
08027496 2400     mov     r4,0h                                   
08027498 82E8     strh    r0,[r5,16h]                             
0802749A 1C28     mov     r0,r5                                   
0802749C 3020     add     r0,20h                                  
0802749E 7004     strb    r4,[r0]                                 
080274A0 3014     add     r0,14h                                  
080274A2 7004     strb    r4,[r0]                                 
080274A4 4911     ldr     r1,=300070Ch                            
080274A6 1C10     mov     r0,r2                                   
080274A8 38E8     sub     r0,0E8h                                 
080274AA 80C8     strh    r0,[r1,6h]                              
080274AC 1C29     mov     r1,r5                                   
080274AE 3124     add     r1,24h                                  
080274B0 2025     mov     r0,25h                                  
080274B2 7008     strb    r0,[r1]                                 
080274B4 3108     add     r1,8h                                   
080274B6 205A     mov     r0,5Ah                                  
080274B8 7008     strb    r0,[r1]                                 
080274BA 2028     mov     r0,28h                                  
080274BC 2181     mov     r1,81h                                  
080274BE F02DFF41 bl      8055344h                                
080274C2 480B     ldr     r0,=1A5h                                
080274C4 F7DBFAA8 bl      8002A18h                                
080274C8 2080     mov     r0,80h                                  
080274CA 0040     lsl     r0,r0,1h                                
080274CC 8268     strh    r0,[r5,12h]                             
080274CE 1C28     mov     r0,r5                                   
080274D0 302E     add     r0,2Eh                                  
080274D2 7004     strb    r4,[r0]                                 
080274D4 2055     mov     r0,55h                                  
080274D6 F7DCFADF bl      8003A98h                                
080274DA BC70     pop     r4-r6                                   
080274DC BC01     pop     r0                                      
080274DE 4700     bx      r0                                      
080274E0 07F0     lsl     r0,r6,1Fh                               
080274E2 0300     lsl     r0,r0,0Ch                               
080274E4 0738     lsl     r0,r7,1Ch                               
080274E6 0300     lsl     r0,r0,0Ch                               
080274E8 0BC0     lsr     r0,r0,0Fh                               
080274EA 082E     lsr     r6,r5,20h                               
080274EC 070C     lsl     r4,r1,1Ch                               
080274EE 0300     lsl     r0,r0,0Ch                               
080274F0 01A5     lsl     r5,r4,6h                                
080274F2 0000     lsl     r0,r0,0h                                
080274F4 B500     push    r14                                     
080274F6 4A0F     ldr     r2,=3000738h                            
080274F8 8811     ldrh    r1,[r2]                                 
080274FA 2002     mov     r0,2h                                   
080274FC 4008     and     r0,r1                                   
080274FE 2800     cmp     r0,0h                                   
08027500 D016     beq     8027530h                                
08027502 1C11     mov     r1,r2                                   
08027504 312C     add     r1,2Ch                                  
08027506 7808     ldrb    r0,[r1]                                 
08027508 3801     sub     r0,1h                                   
0802750A 7008     strb    r0,[r1]                                 
0802750C 0600     lsl     r0,r0,18h                               
0802750E 2800     cmp     r0,0h                                   
08027510 D10E     bne     8027530h                                
08027512 3908     sub     r1,8h                                   
08027514 2027     mov     r0,27h                                  
08027516 7008     strb    r0,[r1]                                 
08027518 2001     mov     r0,1h                                   
0802751A F7FFFC57 bl      8026DCCh                                
0802751E 4906     ldr     r1,=300007Bh                            
08027520 223C     mov     r2,3Ch                                  
08027522 4252     neg     r2,r2                                   
08027524 1C10     mov     r0,r2                                   
08027526 7008     strb    r0,[r1]                                 
08027528 200B     mov     r0,0Bh                                  
0802752A 2100     mov     r1,0h                                   
0802752C F7DCFA62 bl      80039F4h                                
08027530 BC01     pop     r0                                      
08027532 4700     bx      r0                                      


;主精灵 4F pose 27                              
0802753C B500     push    r14                                     
0802753E 480B     ldr     r0,=3000C77h                            
08027540 7800     ldrb    r0,[r0]                                 
08027542 2103     mov     r1,3h                                   
08027544 4001     and     r1,r0                                   
08027546 2900     cmp     r1,0h                                   
08027548 D12E     bne     80275A8h                                
0802754A 4A09     ldr     r2,=3000738h                            
0802754C 1C13     mov     r3,r2                                   
0802754E 332E     add     r3,2Eh                                  
08027550 7818     ldrb    r0,[r3]                                 
08027552 2800     cmp     r0,0h                                   
08027554 D016     beq     8027584h                                
08027556 8A50     ldrh    r0,[r2,12h]                             
08027558 28FC     cmp     r0,0FCh                                 
0802755A D90D     bls     8027578h                                
0802755C 3801     sub     r0,1h                                   
0802755E 8250     strh    r0,[r2,12h]                             
08027560 4904     ldr     r1,=300070Ch                            
08027562 88C8     ldrh    r0,[r1,6h]                              
08027564 3801     sub     r0,1h                                   
08027566 80C8     strh    r0,[r1,6h]                              
08027568 E01E     b       80275A8h                                
0802756A 0000     lsl     r0,r0,0h                                
0802756C 0C77     lsr     r7,r6,11h                               
0802756E 0300     lsl     r0,r0,0Ch                               
08027570 0738     lsl     r0,r7,1Ch                               
08027572 0300     lsl     r0,r0,0Ch                               
08027574 070C     lsl     r4,r1,1Ch                               
08027576 0300     lsl     r0,r0,0Ch                               
08027578 7019     strb    r1,[r3]                                 
0802757A 20D3     mov     r0,0D3h                                 
0802757C 0040     lsl     r0,r0,1h                                
0802757E F7DBFA4B bl      8002A18h                                
08027582 E011     b       80275A8h                                
08027584 8A51     ldrh    r1,[r2,12h]                             
08027586 4805     ldr     r0,=103h                                
08027588 4281     cmp     r1,r0                                   
0802758A D80B     bhi     80275A4h                                
0802758C 1C48     add     r0,r1,1                                 
0802758E 8250     strh    r0,[r2,12h]                             
08027590 4903     ldr     r1,=300070Ch                            
08027592 88C8     ldrh    r0,[r1,6h]                              
08027594 3001     add     r0,1h                                   
08027596 80C8     strh    r0,[r1,6h]                              
08027598 E006     b       80275A8h                                
0802759A 0000     lsl     r0,r0,0h                                
0802759C 0103     lsl     r3,r0,4h                                
0802759E 0000     lsl     r0,r0,0h                                
080275A0 070C     lsl     r4,r1,1Ch                               
080275A2 0300     lsl     r0,r0,0Ch                               
080275A4 2001     mov     r0,1h                                   
080275A6 7018     strb    r0,[r3]                                 
080275A8 BC01     pop     r0                                      
080275AA 4700     bx      r0    


;副精灵14 pose 0                                  
080275AC B510     push    r4,r14                                  
080275AE 4A07     ldr     r2,=3000738h                            
080275B0 8811     ldrh    r1,[r2]                                 
080275B2 4807     ldr     r0,=0FFFBh                              
080275B4 4008     and     r0,r1                                   
080275B6 8010     strh    r0,[r2]         ;取向去4h 再写入                        
080275B8 7F90     ldrb    r0,[r2,1Eh]                             
080275BA 4694     mov     r12,r2          ;精灵data                         
080275BC 2809     cmp     r0,9h                                   
080275BE D900     bls     @@Pass                                
080275C0 E17E     b       @@DataOver9 

@@Pass:                               
080275C2 0080     lsl     r0,r0,2h                                
080275C4 4903     ldr     r1,=80275D8h                            
080275C6 1840     add     r0,r0,r1                                
080275C8 6800     ldr     r0,[r0]                                 
080275CA 4687     mov     r15,r0                                  
DataTable:
     .word 80277e4h
	 .word 8027600h
	 .word 802764ch
	 .word 8027868h
	 .word 80278c0h
	 .word 8027828h
	 .word 802769ch
	 .word 80276ech
	 .word 802773ch
	 .word 8027790h
;data1     	 
08027600 4660     mov     r0,r12                                  
08027602 3027     add     r0,27h                                  
08027604 2120     mov     r1,20h                                  
08027606 7001     strb    r1,[r0]    ;75F写入20h                             
08027608 3001     add     r0,1h      ;                             
0802760A 7001     strb    r1,[r0]                                 
0802760C 3001     add     r0,1h                                   
0802760E 2110     mov     r1,10h                                  
08027610 7001     strb    r1,[r0]                                 
08027612 480B     ldr     r0,=0FFA0h                              
08027614 4662     mov     r2,r12                                  
08027616 8150     strh    r0,[r2,0Ah]                             
08027618 2040     mov     r0,40h                                  
0802761A 8190     strh    r0,[r2,0Ch]                             
0802761C 4809     ldr     r0,=0FFF0h                              
0802761E 81D0     strh    r0,[r2,0Eh]                             
08027620 8211     strh    r1,[r2,10h]                             
08027622 4A09     ldr     r2,=82B1BE4h                            
08027624 4663     mov     r3,r12                                  
08027626 7F59     ldrb    r1,[r3,1Dh]                             
08027628 00C8     lsl     r0,r1,3h                                
0802762A 1840     add     r0,r0,r1                                
0802762C 0040     lsl     r0,r0,1h                                
0802762E 1880     add     r0,r0,r2                                
08027630 8800     ldrh    r0,[r0]                                 
08027632 8298     strh    r0,[r3,14h]                             
08027634 4661     mov     r1,r12                                  
08027636 3125     add     r1,25h                                  
08027638 2004     mov     r0,4h                                   
0802763A 7008     strb    r0,[r1]                                 
0802763C 3903     sub     r1,3h                                   
0802763E E09C     b       802777Ah                                
08027640 FFA0     bl      lr+0F40h                                
08027642 0000     lsl     r0,r0,0h                                
08027644 FFF0     bl      lr+0FE0h                                
08027646 0000     lsl     r0,r0,0h                                
08027648 1BE4     sub     r4,r4,r7                                
0802764A 082B     lsr     r3,r5,20h 

;data2                              
0802764C 4661     mov     r1,r12                                  
0802764E 3127     add     r1,27h                                  
08027650 2018     mov     r0,18h                                  
08027652 7008     strb    r0,[r1]                                 
08027654 3101     add     r1,1h                                   
08027656 2020     mov     r0,20h                                  
08027658 7008     strb    r0,[r1]                                 
0802765A 4660     mov     r0,r12                                  
0802765C 3029     add     r0,29h                                  
0802765E 2110     mov     r1,10h                                  
08027660 7001     strb    r1,[r0]                                 
08027662 480B     ldr     r0,=0FFA0h                              
08027664 4664     mov     r4,r12                                  
08027666 8160     strh    r0,[r4,0Ah]                             
08027668 2060     mov     r0,60h                                  
0802766A 81A0     strh    r0,[r4,0Ch]                             
0802766C 4809     ldr     r0,=0FFF0h                              
0802766E 81E0     strh    r0,[r4,0Eh]                             
08027670 8221     strh    r1,[r4,10h]                             
08027672 4A09     ldr     r2,=82B1BE4h                            
08027674 7F61     ldrb    r1,[r4,1Dh]                             
08027676 00C8     lsl     r0,r1,3h                                
08027678 1840     add     r0,r0,r1                                
0802767A 0040     lsl     r0,r0,1h                                
0802767C 1880     add     r0,r0,r2                                
0802767E 8800     ldrh    r0,[r0]                                 
08027680 82A0     strh    r0,[r4,14h]                             
08027682 4661     mov     r1,r12                                  
08027684 3125     add     r1,25h                                  
08027686 2004     mov     r0,4h                                   
08027688 7008     strb    r0,[r1]                                 
0802768A 3903     sub     r1,3h                                   
0802768C E075     b       802777Ah                                
0802768E 0000     lsl     r0,r0,0h                                
08027690 FFA0     bl      lr+0F40h                                
08027692 0000     lsl     r0,r0,0h                                
08027694 FFF0     bl      lr+0FE0h                                
08027696 0000     lsl     r0,r0,0h                                
08027698 1BE4     sub     r4,r4,r7                                
0802769A 082B     lsr     r3,r5,20h                               
0802769C 4661     mov     r1,r12                                  
0802769E 3127     add     r1,27h                                  
080276A0 2018     mov     r0,18h                                  
080276A2 7008     strb    r0,[r1]                                 
080276A4 3101     add     r1,1h                                   
080276A6 2020     mov     r0,20h                                  
080276A8 7008     strb    r0,[r1]                                 
080276AA 4660     mov     r0,r12                                  
080276AC 3029     add     r0,29h                                  
080276AE 2110     mov     r1,10h                                  
080276B0 7001     strb    r1,[r0]                                 
080276B2 480B     ldr     r0,=0FFC0h                              
080276B4 4662     mov     r2,r12                                  
080276B6 8150     strh    r0,[r2,0Ah]                             
080276B8 2060     mov     r0,60h                                  
080276BA 8190     strh    r0,[r2,0Ch]                             
080276BC 4809     ldr     r0,=0FFF0h                              
080276BE 81D0     strh    r0,[r2,0Eh]                             
080276C0 8211     strh    r1,[r2,10h]                             
080276C2 4A09     ldr     r2,=82B1BE4h                            
080276C4 4663     mov     r3,r12                                  
080276C6 7F59     ldrb    r1,[r3,1Dh]                             
080276C8 00C8     lsl     r0,r1,3h                                
080276CA 1840     add     r0,r0,r1                                
080276CC 0040     lsl     r0,r0,1h                                
080276CE 1880     add     r0,r0,r2                                
080276D0 8800     ldrh    r0,[r0]                                 
080276D2 8298     strh    r0,[r3,14h]                             
080276D4 4661     mov     r1,r12                                  
080276D6 3125     add     r1,25h                                  
080276D8 2004     mov     r0,4h                                   
080276DA 7008     strb    r0,[r1]                                 
080276DC 3903     sub     r1,3h                                   
080276DE E04C     b       802777Ah                                
080276E0 FFC0     bl      lr+0F80h                                
080276E2 0000     lsl     r0,r0,0h                                
080276E4 FFF0     bl      lr+0FE0h                                
080276E6 0000     lsl     r0,r0,0h                                
080276E8 1BE4     sub     r4,r4,r7                                
080276EA 082B     lsr     r3,r5,20h                               
080276EC 4661     mov     r1,r12                                  
080276EE 3127     add     r1,27h                                  
080276F0 2020     mov     r0,20h                                  
080276F2 7008     strb    r0,[r1]                                 
080276F4 3101     add     r1,1h                                   
080276F6 2028     mov     r0,28h                                  
080276F8 7008     strb    r0,[r1]                                 
080276FA 3101     add     r1,1h                                   
080276FC 2010     mov     r0,10h                                  
080276FE 7008     strb    r0,[r1]                                 
08027700 480B     ldr     r0,=0FFA0h                              
08027702 4664     mov     r4,r12                                  
08027704 8160     strh    r0,[r4,0Ah]                             
08027706 2080     mov     r0,80h                                  
08027708 81A0     strh    r0,[r4,0Ch]                             
0802770A 480A     ldr     r0,=0FFE8h                              
0802770C 81E0     strh    r0,[r4,0Eh]                             
0802770E 2018     mov     r0,18h                                  
08027710 8220     strh    r0,[r4,10h]                             
08027712 4A09     ldr     r2,=82B1BE4h                            
08027714 7F61     ldrb    r1,[r4,1Dh]                             
08027716 00C8     lsl     r0,r1,3h                                
08027718 1840     add     r0,r0,r1                                
0802771A 0040     lsl     r0,r0,1h                                
0802771C 1880     add     r0,r0,r2                                
0802771E 8800     ldrh    r0,[r0]                                 
08027720 82A0     strh    r0,[r4,14h]                             
08027722 4661     mov     r1,r12                                  
08027724 3125     add     r1,25h                                  
08027726 2004     mov     r0,4h                                   
08027728 7008     strb    r0,[r1]                                 
0802772A 3903     sub     r1,3h                                   
0802772C E025     b       802777Ah                                
0802772E 0000     lsl     r0,r0,0h                                
08027730 FFA0     bl      lr+0F40h                                
08027732 0000     lsl     r0,r0,0h                                
08027734 FFE8     bl      lr+0FD0h                                
08027736 0000     lsl     r0,r0,0h                                
08027738 1BE4     sub     r4,r4,r7                                
0802773A 082B     lsr     r3,r5,20h                               
0802773C 4660     mov     r0,r12                                  
0802773E 3027     add     r0,27h                                  
08027740 2110     mov     r1,10h                                  
08027742 7001     strb    r1,[r0]                                 
08027744 3001     add     r0,1h                                   
08027746 7001     strb    r1,[r0]                                 
08027748 3001     add     r0,1h                                   
0802774A 7001     strb    r1,[r0]                                 
0802774C 480D     ldr     r0,=0FFC8h                              
0802774E 4662     mov     r2,r12                                  
08027750 8150     strh    r0,[r2,0Ah]                             
08027752 2038     mov     r0,38h                                  
08027754 8190     strh    r0,[r2,0Ch]                             
08027756 480C     ldr     r0,=0FFF0h                              
08027758 81D0     strh    r0,[r2,0Eh]                             
0802775A 8211     strh    r1,[r2,10h]                             
0802775C 4A0B     ldr     r2,=82B1BE4h                            
0802775E 4663     mov     r3,r12                                  
08027760 7F59     ldrb    r1,[r3,1Dh]                             
08027762 00C8     lsl     r0,r1,3h                                
08027764 1840     add     r0,r0,r1                                
08027766 0040     lsl     r0,r0,1h                                
08027768 1880     add     r0,r0,r2                                
0802776A 8800     ldrh    r0,[r0]                                 
0802776C 8298     strh    r0,[r3,14h]                             
0802776E 4661     mov     r1,r12                                  
08027770 3125     add     r1,25h                                  
08027772 2004     mov     r0,4h                                   
08027774 7008     strb    r0,[r1]                                 
08027776 3903     sub     r1,3h                                   
08027778 2007     mov     r0,7h                                   
0802777A 7008     strb    r0,[r1]                                 
0802777C 3102     add     r1,2h                                   
0802777E 2008     mov     r0,8h                                   
08027780 7008     strb    r0,[r1]                                 
08027782 E0A0     b       80278C6h                                
08027784 FFC8     bl      lr+0F90h                                
08027786 0000     lsl     r0,r0,0h                                
08027788 FFF0     bl      lr+0FE0h                                
0802778A 0000     lsl     r0,r0,0h                                
0802778C 1BE4     sub     r4,r4,r7                                
0802778E 082B     lsr     r3,r5,20h                               
08027790 4660     mov     r0,r12                                  
08027792 3027     add     r0,27h                                  
08027794 2110     mov     r1,10h                                  
08027796 7001     strb    r1,[r0]                                 
08027798 3001     add     r0,1h                                   
0802779A 7001     strb    r1,[r0]                                 
0802779C 3001     add     r0,1h                                   
0802779E 2308     mov     r3,8h                                   
080277A0 7003     strb    r3,[r0]                                 
080277A2 480D     ldr     r0,=0FFC8h                              
080277A4 4664     mov     r4,r12                                  
080277A6 8160     strh    r0,[r4,0Ah]                             
080277A8 2038     mov     r0,38h                                  
080277AA 81A0     strh    r0,[r4,0Ch]                             
080277AC 480B     ldr     r0,=0FFF0h                              
080277AE 81E0     strh    r0,[r4,0Eh]                             
080277B0 8221     strh    r1,[r4,10h]                             
080277B2 4A0B     ldr     r2,=82B1BE4h                            
080277B4 7F61     ldrb    r1,[r4,1Dh]                             
080277B6 00C8     lsl     r0,r1,3h                                
080277B8 1840     add     r0,r0,r1                                
080277BA 0040     lsl     r0,r0,1h                                
080277BC 1880     add     r0,r0,r2                                
080277BE 8800     ldrh    r0,[r0]                                 
080277C0 82A0     strh    r0,[r4,14h]                             
080277C2 4661     mov     r1,r12                                  
080277C4 3125     add     r1,25h                                  
080277C6 2004     mov     r0,4h                                   
080277C8 7008     strb    r0,[r1]                                 
080277CA 3903     sub     r1,3h                                   
080277CC 2007     mov     r0,7h                                   
080277CE 7008     strb    r0,[r1]                                 
080277D0 4660     mov     r0,r12                                  
080277D2 3024     add     r0,24h                                  
080277D4 7003     strb    r3,[r0]                                 
080277D6 E076     b       80278C6h                                
080277D8 FFC8     bl      lr+0F90h                                
080277DA 0000     lsl     r0,r0,0h                                
080277DC FFF0     bl      lr+0FE0h                                
080277DE 0000     lsl     r0,r0,0h                                
080277E0 1BE4     sub     r4,r4,r7                                
080277E2 082B     lsr     r3,r5,20h                               
080277E4 4661     mov     r1,r12                                  
080277E6 3127     add     r1,27h                                  
080277E8 2300     mov     r3,0h                                   
080277EA 2038     mov     r0,38h                                  
080277EC 7008     strb    r0,[r1]                                 
080277EE 3101     add     r1,1h                                   
080277F0 2010     mov     r0,10h                                  
080277F2 7008     strb    r0,[r1]                                 
080277F4 3101     add     r1,1h                                   
080277F6 2020     mov     r0,20h                                  
080277F8 7008     strb    r0,[r1]                                 
080277FA 2200     mov     r2,0h                                   
080277FC 4909     ldr     r1,=0FFFCh                              
080277FE 4660     mov     r0,r12                                  
08027800 8141     strh    r1,[r0,0Ah]                             
08027802 2004     mov     r0,4h                                   
08027804 4664     mov     r4,r12                                  
08027806 81A0     strh    r0,[r4,0Ch]                             
08027808 81E1     strh    r1,[r4,0Eh]                             
0802780A 8220     strh    r0,[r4,10h]                             
0802780C 4660     mov     r0,r12                                  
0802780E 3025     add     r0,25h                                  
08027810 7002     strb    r2,[r0]                                 
08027812 4661     mov     r1,r12                                  
08027814 3122     add     r1,22h                                  
08027816 2003     mov     r0,3h                                   
08027818 7008     strb    r0,[r1]                                 
0802781A 3102     add     r1,2h                                   
0802781C 200E     mov     r0,0Eh                                  
0802781E 7008     strb    r0,[r1]                                 
08027820 80E3     strh    r3,[r4,6h]                              
08027822 E050     b       80278C6h                                
08027824 FFFC     bl      lr+0FF8h                                
08027826 0000     lsl     r0,r0,0h                                
08027828 4661     mov     r1,r12                                  
0802782A 3127     add     r1,27h                                  
0802782C 2038     mov     r0,38h                                  
0802782E 7008     strb    r0,[r1]                                 
08027830 3101     add     r1,1h                                   
08027832 2018     mov     r0,18h                                  
08027834 7008     strb    r0,[r1]                                 
08027836 3101     add     r1,1h                                   
08027838 2028     mov     r0,28h                                  
0802783A 7008     strb    r0,[r1]                                 
0802783C 2200     mov     r2,0h                                   
0802783E 4909     ldr     r1,=0FFFCh                              
08027840 4660     mov     r0,r12                                  
08027842 8141     strh    r1,[r0,0Ah]                             
08027844 2004     mov     r0,4h                                   
08027846 4663     mov     r3,r12                                  
08027848 8198     strh    r0,[r3,0Ch]                             
0802784A 81D9     strh    r1,[r3,0Eh]                             
0802784C 8218     strh    r0,[r3,10h]                             
0802784E 4660     mov     r0,r12                                  
08027850 3025     add     r0,25h                                  
08027852 7002     strb    r2,[r0]                                 
08027854 4661     mov     r1,r12                                  
08027856 3122     add     r1,22h                                  
08027858 2008     mov     r0,8h                                   
0802785A 7008     strb    r0,[r1]                                 
0802785C 3102     add     r1,2h                                   
0802785E 200E     mov     r0,0Eh                                  
08027860 7008     strb    r0,[r1]                                 
08027862 E030     b       80278C6h                                
08027864 FFFC     bl      lr+0FF8h                                
08027866 0000     lsl     r0,r0,0h                                
08027868 4661     mov     r1,r12                                  
0802786A 3127     add     r1,27h                                  
0802786C 2008     mov     r0,8h                                   
0802786E 7008     strb    r0,[r1]                                 
08027870 3101     add     r1,1h                                   
08027872 2028     mov     r0,28h                                  
08027874 7008     strb    r0,[r1]                                 
08027876 4660     mov     r0,r12                                  
08027878 3029     add     r0,29h                                  
0802787A 2220     mov     r2,20h                                  
0802787C 7002     strb    r2,[r0]                                 
0802787E 490F     ldr     r1,=0FFE0h                              
08027880 4664     mov     r4,r12                                  
08027882 8161     strh    r1,[r4,0Ah]                             
08027884 20A0     mov     r0,0A0h                                 
08027886 81A0     strh    r0,[r4,0Ch]                             
08027888 81E1     strh    r1,[r4,0Eh]                             
0802788A 8222     strh    r2,[r4,10h]                             
0802788C 2001     mov     r0,1h                                   
0802788E 82A0     strh    r0,[r4,14h]                             
08027890 4661     mov     r1,r12                                  
08027892 3125     add     r1,25h                                  
08027894 2004     mov     r0,4h                                   
08027896 7008     strb    r0,[r1]                                 
08027898 4660     mov     r0,r12                                  
0802789A 3022     add     r0,22h                                  
0802789C 2205     mov     r2,5h                                   
0802789E 7002     strb    r2,[r0]                                 
080278A0 3901     sub     r1,1h                                   
080278A2 2042     mov     r0,42h                                  
080278A4 7008     strb    r0,[r1]                                 
080278A6 4660     mov     r0,r12                                  
080278A8 3033     add     r0,33h                                  
080278AA 7002     strb    r2,[r0]                                 
080278AC 4662     mov     r2,r12                                  
080278AE 3232     add     r2,32h                                  
080278B0 7811     ldrb    r1,[r2]                                 
080278B2 2040     mov     r0,40h                                  
080278B4 4308     orr     r0,r1                                   
080278B6 7010     strb    r0,[r2]                                 
080278B8 E005     b       80278C6h                                
080278BA 0000     lsl     r0,r0,0h                                
080278BC FFE0     bl      lr+0FC0h                                
080278BE 0000     lsl     r0,r0,0h

@@DataOver9:                                
080278C0 2000     mov     r0,0h                                   
080278C2 4661     mov     r1,r12                                  
080278C4 8008     strh    r0,[r1]      ;精灵data写入0h                              
080278C6 BC10     pop     r4                                      
080278C8 BC01     pop     r0                                      
080278CA 4700     bx      r0                                      
080278CC B510     push    r4,r14                                  
080278CE 490C     ldr     r1,=3000738h                            
080278D0 1C0B     mov     r3,r1                                   
080278D2 3332     add     r3,32h                                  
080278D4 781A     ldrb    r2,[r3]                                 
080278D6 2402     mov     r4,2h                                   
080278D8 1C20     mov     r0,r4                                   
080278DA 4010     and     r0,r2                                   
080278DC 2800     cmp     r0,0h                                   
080278DE D00B     beq     80278F8h                                
080278E0 20FD     mov     r0,0FDh                                 
080278E2 4010     and     r0,r2                                   
080278E4 7018     strb    r0,[r3]                                 
080278E6 8809     ldrh    r1,[r1]                                 
080278E8 1C20     mov     r0,r4                                   
080278EA 4008     and     r0,r1                                   
080278EC 2800     cmp     r0,0h                                   
080278EE D003     beq     80278F8h                                
080278F0 20D1     mov     r0,0D1h                                 
080278F2 0040     lsl     r0,r0,1h                                
080278F4 F7DBF914 bl      8002B20h                                
080278F8 BC10     pop     r4                                      
080278FA BC01     pop     r0                                      
080278FC 4700     bx      r0                                      
080278FE 0000     lsl     r0,r0,0h                                
08027900 0738     lsl     r0,r7,1Ch                               
08027902 0300     lsl     r0,r0,0Ch                               
08027904 B510     push    r4,r14                                  
08027906 4806     ldr     r0,=3000738h                            
08027908 8842     ldrh    r2,[r0,2h]                              
0802790A 8883     ldrh    r3,[r0,4h]                              
0802790C 7F81     ldrb    r1,[r0,1Eh]                             
0802790E 3901     sub     r1,1h                                   
08027910 1C04     mov     r4,r0                                   
08027912 2908     cmp     r1,8h                                   
08027914 D822     bhi     802795Ch                                
08027916 0088     lsl     r0,r1,2h                                
08027918 4902     ldr     r1,=8027928h                            
0802791A 1840     add     r0,r0,r1                                
0802791C 6800     ldr     r0,[r0]                                 
0802791E 4687     mov     r15,r0                                  
08027920 0738     lsl     r0,r7,1Ch                               
08027922 0300     lsl     r0,r0,0Ch                               
08027924 7928     ldrb    r0,[r5,4h]                              
08027926 0802     lsr     r2,r0,20h                               
08027928 7962     ldrb    r2,[r4,5h]                              
0802792A 0802     lsr     r2,r0,20h                               
0802792C 794C     ldrb    r4,[r1,5h]                              
0802792E 0802     lsr     r2,r0,20h                               
08027930 795C     ldrb    r4,[r3,5h]                              
08027932 0802     lsr     r2,r0,20h                               
08027934 795C     ldrb    r4,[r3,5h]                              
08027936 0802     lsr     r2,r0,20h                               
08027938 795C     ldrb    r4,[r3,5h]                              
0802793A 0802     lsr     r2,r0,20h                               
0802793C 794C     ldrb    r4,[r1,5h]                              
0802793E 0802     lsr     r2,r0,20h                               
08027940 794C     ldrb    r4,[r1,5h]                              
08027942 0802     lsr     r2,r0,20h                               
08027944 7952     ldrb    r2,[r2,5h]                              
08027946 0802     lsr     r2,r0,20h                               
08027948 7952     ldrb    r2,[r2,5h]                              
0802794A 0802     lsr     r2,r0,20h                               
0802794C 1C10     mov     r0,r2                                   
0802794E 3020     add     r0,20h                                  
08027950 E001     b       8027956h                                
08027952 1C10     mov     r0,r2                                   
08027954 3010     add     r0,10h                                  
08027956 0400     lsl     r0,r0,10h                               
08027958 0C02     lsr     r2,r0,10h                               
0802795A E002     b       8027962h                                
0802795C 2000     mov     r0,0h                                   
0802795E 8020     strh    r0,[r4]                                 
08027960 E00D     b       802797Eh                                
08027962 1C10     mov     r0,r2                                   
08027964 1C19     mov     r1,r3                                   
08027966 221E     mov     r2,1Eh                                  
08027968 F02CFBC0 bl      80540ECh                                
0802796C 4905     ldr     r1,=300070Ch                            
0802796E 8948     ldrh    r0,[r1,0Ah]                             
08027970 2800     cmp     r0,0h                                   
08027972 D001     beq     8027978h                                
08027974 3801     sub     r0,1h                                   
08027976 8148     strh    r0,[r1,0Ah]                             
08027978 4903     ldr     r1,=3000738h                            
0802797A 2000     mov     r0,0h                                   
0802797C 8008     strh    r0,[r1]                                 
0802797E BC10     pop     r4                                      
08027980 BC01     pop     r0                                      
08027982 4700     bx      r0                                      
08027984 070C     lsl     r4,r1,1Ch                               
08027986 0300     lsl     r0,r0,0Ch                               
08027988 0738     lsl     r0,r7,1Ch                               
0802798A 0300     lsl     r0,r0,0Ch                               
0802798C B5F0     push    r4-r7,r14                               
0802798E 4647     mov     r7,r8                                   
08027990 B480     push    r7                                      
08027992 B083     add     sp,-0Ch                                 
08027994 4B09     ldr     r3,=3000738h                            
08027996 1C18     mov     r0,r3                                   
08027998 3023     add     r0,23h                                  
0802799A 7801     ldrb    r1,[r0]                                 
0802799C 4A08     ldr     r2,=30001ACh                            
0802799E 00C8     lsl     r0,r1,3h                                
080279A0 1A40     sub     r0,r0,r1                                
080279A2 00C0     lsl     r0,r0,3h                                
080279A4 1880     add     r0,r0,r2                                
080279A6 3024     add     r0,24h                                  
080279A8 7800     ldrb    r0,[r0]                                 
080279AA 2825     cmp     r0,25h                                  
080279AC D11A     bne     80279E4h                                
080279AE 885F     ldrh    r7,[r3,2h]                              
080279B0 7F98     ldrb    r0,[r3,1Eh]                             
080279B2 2800     cmp     r0,0h                                   
080279B4 D106     bne     80279C4h                                
080279B6 8898     ldrh    r0,[r3,4h]                              
080279B8 3040     add     r0,40h                                  
080279BA E005     b       80279C8h                                
080279BC 0738     lsl     r0,r7,1Ch                               
080279BE 0300     lsl     r0,r0,0Ch                               
080279C0 01AC     lsl     r4,r5,6h                                
080279C2 0300     lsl     r0,r0,0Ch                               
080279C4 8898     ldrh    r0,[r3,4h]                              
080279C6 3840     sub     r0,40h                                  
080279C8 0400     lsl     r0,r0,10h                               
080279CA 0C06     lsr     r6,r0,10h                               
080279CC 1C38     mov     r0,r7                                   
080279CE 3864     sub     r0,64h                                  
080279D0 1C31     mov     r1,r6                                   
080279D2 2236     mov     r2,36h                                  
080279D4 F02CFB8A bl      80540ECh                                
080279D8 4901     ldr     r1,=3000738h                            
080279DA 2000     mov     r0,0h                                   
080279DC 8008     strh    r0,[r1]                                 
080279DE E07F     b       8027AE0h                                
080279E0 0738     lsl     r0,r7,1Ch                               
080279E2 0300     lsl     r0,r0,0Ch                               
080279E4 480E     ldr     r0,=300070Ch                            
080279E6 8940     ldrh    r0,[r0,0Ah]                             
080279E8 2800     cmp     r0,0h                                   
080279EA D079     beq     8027AE0h                                
080279EC 7F98     ldrb    r0,[r3,1Eh]                             
080279EE 2800     cmp     r0,0h                                   
080279F0 D176     bne     8027AE0h                                
080279F2 88D8     ldrh    r0,[r3,6h]                              
080279F4 1C41     add     r1,r0,1                                 
080279F6 80D9     strh    r1,[r3,6h]                              
080279F8 20FF     mov     r0,0FFh                                 
080279FA 4008     and     r0,r1                                   
080279FC 2800     cmp     r0,0h                                   
080279FE D16F     bne     8027AE0h                                
08027A00 2080     mov     r0,80h                                  
08027A02 0040     lsl     r0,r0,1h                                
08027A04 4001     and     r1,r0                                   
08027A06 2900     cmp     r1,0h                                   
08027A08 D00C     beq     8027A24h                                
08027A0A 8858     ldrh    r0,[r3,2h]                              
08027A0C 3860     sub     r0,60h                                  
08027A0E 0400     lsl     r0,r0,10h                               
08027A10 0C07     lsr     r7,r0,10h                               
08027A12 8898     ldrh    r0,[r3,4h]                              
08027A14 3846     sub     r0,46h                                  
08027A16 0400     lsl     r0,r0,10h                               
08027A18 0C06     lsr     r6,r0,10h                               
08027A1A 2000     mov     r0,0h                                   
08027A1C E00B     b       8027A36h                                
08027A1E 0000     lsl     r0,r0,0h                                
08027A20 070C     lsl     r4,r1,1Ch                               
08027A22 0300     lsl     r0,r0,0Ch                               
08027A24 8858     ldrh    r0,[r3,2h]                              
08027A26 3890     sub     r0,90h                                  
08027A28 0400     lsl     r0,r0,10h                               
08027A2A 0C07     lsr     r7,r0,10h                               
08027A2C 8898     ldrh    r0,[r3,4h]                              
08027A2E 3064     add     r0,64h                                  
08027A30 0400     lsl     r0,r0,10h                               
08027A32 0C06     lsr     r6,r0,10h                               
08027A34 2040     mov     r0,40h                                  
08027A36 4680     mov     r8,r0                                   
08027A38 7FDC     ldrb    r4,[r3,1Fh]                             
08027A3A 1C18     mov     r0,r3                                   
08027A3C 302D     add     r0,2Dh                                  
08027A3E 7805     ldrb    r5,[r0]                                 
08027A40 9700     str     r7,[sp]                                 
08027A42 9601     str     r6,[sp,4h]                              
08027A44 4640     mov     r0,r8                                   
08027A46 9002     str     r0,[sp,8h]                              
08027A48 2015     mov     r0,15h                                  
08027A4A 2100     mov     r1,0h                                   
08027A4C 1C22     mov     r2,r4                                   
08027A4E 1C2B     mov     r3,r5                                   
08027A50 F7E6FC02 bl      800E258h                                
08027A54 9700     str     r7,[sp]                                 
08027A56 9601     str     r6,[sp,4h]                              
08027A58 4640     mov     r0,r8                                   
08027A5A 9002     str     r0,[sp,8h]                              
08027A5C 2015     mov     r0,15h                                  
08027A5E 2101     mov     r1,1h                                   
08027A60 1C22     mov     r2,r4                                   
08027A62 1C2B     mov     r3,r5                                   
08027A64 F7E6FBF8 bl      800E258h                                
08027A68 9700     str     r7,[sp]                                 
08027A6A 9601     str     r6,[sp,4h]                              
08027A6C 4640     mov     r0,r8                                   
08027A6E 9002     str     r0,[sp,8h]                              
08027A70 2015     mov     r0,15h                                  
08027A72 2102     mov     r1,2h                                   
08027A74 1C22     mov     r2,r4                                   
08027A76 1C2B     mov     r3,r5                                   
08027A78 F7E6FBEE bl      800E258h                                
08027A7C 9700     str     r7,[sp]                                 
08027A7E 9601     str     r6,[sp,4h]                              
08027A80 4640     mov     r0,r8                                   
08027A82 9002     str     r0,[sp,8h]                              
08027A84 2015     mov     r0,15h                                  
08027A86 2103     mov     r1,3h                                   
08027A88 1C22     mov     r2,r4                                   
08027A8A 1C2B     mov     r3,r5                                   
08027A8C F7E6FBE4 bl      800E258h                                
08027A90 9700     str     r7,[sp]                                 
08027A92 9601     str     r6,[sp,4h]                              
08027A94 4640     mov     r0,r8                                   
08027A96 9002     str     r0,[sp,8h]                              
08027A98 2015     mov     r0,15h                                  
08027A9A 2104     mov     r1,4h                                   
08027A9C 1C22     mov     r2,r4                                   
08027A9E 1C2B     mov     r3,r5                                   
08027AA0 F7E6FBDA bl      800E258h                                
08027AA4 9700     str     r7,[sp]                                 
08027AA6 9601     str     r6,[sp,4h]                              
08027AA8 4640     mov     r0,r8                                   
08027AAA 9002     str     r0,[sp,8h]                              
08027AAC 2015     mov     r0,15h                                  
08027AAE 2105     mov     r1,5h                                   
08027AB0 1C22     mov     r2,r4                                   
08027AB2 1C2B     mov     r3,r5                                   
08027AB4 F7E6FBD0 bl      800E258h                                
08027AB8 9700     str     r7,[sp]                                 
08027ABA 9601     str     r6,[sp,4h]                              
08027ABC 4640     mov     r0,r8                                   
08027ABE 9002     str     r0,[sp,8h]                              
08027AC0 2015     mov     r0,15h                                  
08027AC2 2106     mov     r1,6h                                   
08027AC4 1C22     mov     r2,r4                                   
08027AC6 1C2B     mov     r3,r5                                   
08027AC8 F7E6FBC6 bl      800E258h                                
08027ACC 9700     str     r7,[sp]                                 
08027ACE 9601     str     r6,[sp,4h]                              
08027AD0 4640     mov     r0,r8                                   
08027AD2 9002     str     r0,[sp,8h]                              
08027AD4 2015     mov     r0,15h                                  
08027AD6 2107     mov     r1,7h                                   
08027AD8 1C22     mov     r2,r4                                   
08027ADA 1C2B     mov     r3,r5                                   
08027ADC F7E6FBBC bl      800E258h                                
08027AE0 B003     add     sp,0Ch                                  
08027AE2 BC08     pop     r3                                      
08027AE4 4698     mov     r8,r3                                   
08027AE6 BCF0     pop     r4-r7                                   
08027AE8 BC01     pop     r0                                      
08027AEA 4700     bx      r0                                      
08027AEC B500     push    r14                                     
08027AEE 490E     ldr     r1,=300070Ch                            
08027AF0 8948     ldrh    r0,[r1,0Ah]                             
08027AF2 2800     cmp     r0,0h                                   
08027AF4 D115     bne     8027B22h                                
08027AF6 8888     ldrh    r0,[r1,4h]                              
08027AF8 2807     cmp     r0,7h                                   
08027AFA D912     bls     8027B22h                                
08027AFC 4B0B     ldr     r3,=3000738h                            
08027AFE 1C19     mov     r1,r3                                   
08027B00 3126     add     r1,26h                                  
08027B02 2001     mov     r0,1h                                   
08027B04 7008     strb    r0,[r1]                                 
08027B06 8819     ldrh    r1,[r3]                                 
08027B08 2280     mov     r2,80h                                  
08027B0A 0212     lsl     r2,r2,8h                                
08027B0C 1C10     mov     r0,r2                                   
08027B0E 2200     mov     r2,0h                                   
08027B10 4308     orr     r0,r1                                   
08027B12 8018     strh    r0,[r3]                                 
08027B14 1C18     mov     r0,r3                                   
08027B16 3025     add     r0,25h                                  
08027B18 7002     strb    r2,[r0]                                 
08027B1A 1C19     mov     r1,r3                                   
08027B1C 3124     add     r1,24h                                  
08027B1E 2043     mov     r0,43h                                  
08027B20 7008     strb    r0,[r1]                                 
08027B22 BC01     pop     r0                                      
08027B24 4700     bx      r0                                      
08027B26 0000     lsl     r0,r0,0h                                
08027B28 070C     lsl     r4,r1,1Ch                               
08027B2A 0300     lsl     r0,r0,0Ch                               
08027B2C 0738     lsl     r0,r7,1Ch                               
08027B2E 0300     lsl     r0,r0,0Ch                               
08027B30 B510     push    r4,r14                                  
08027B32 4C0E     ldr     r4,=3000738h                            
08027B34 1C21     mov     r1,r4                                   
08027B36 3126     add     r1,26h                                  
08027B38 2001     mov     r0,1h                                   
08027B3A 7008     strb    r0,[r1]                                 
08027B3C 1C20     mov     r0,r4                                   
08027B3E 3023     add     r0,23h                                  
08027B40 7801     ldrb    r1,[r0]                                 
08027B42 4A0B     ldr     r2,=30001ACh                            
08027B44 00C8     lsl     r0,r1,3h                                
08027B46 1A40     sub     r0,r0,r1                                
08027B48 00C0     lsl     r0,r0,3h                                
08027B4A 1880     add     r0,r0,r2                                
08027B4C 3024     add     r0,24h                                  
08027B4E 7800     ldrb    r0,[r0]                                 
08027B50 2825     cmp     r0,25h                                  
08027B52 D107     bne     8027B64h                                
08027B54 8860     ldrh    r0,[r4,2h]                              
08027B56 30A0     add     r0,0A0h                                 
08027B58 88A1     ldrh    r1,[r4,4h]                              
08027B5A 221E     mov     r2,1Eh                                  
08027B5C F02CFAC6 bl      80540ECh                                
08027B60 2000     mov     r0,0h                                   
08027B62 8020     strh    r0,[r4]                                 
08027B64 BC10     pop     r4                                      
08027B66 BC01     pop     r0                                      
08027B68 4700     bx      r0                                      


                              
08027B74 B500     push    r14                                     
08027B76 4B0A     ldr     r3,=3000738h                            
08027B78 1C18     mov     r0,r3                                   
08027B7A 3023     add     r0,23h                                  
08027B7C 7802     ldrb    r2,[r0]    ;读取主精灵序号                              
08027B7E 8819     ldrh    r1,[r3]                                 
08027B80 2040     mov     r0,40h                                  
08027B82 4008     and     r0,r1      ;取向and40                             
08027B84 2800     cmp     r0,0h                                   
08027B86 D00F     beq     @@FaceLeft                                
08027B88 4806     ldr     r0,=30001ACh                            
08027B8A 00D1     lsl     r1,r2,3h                                
08027B8C 1A89     sub     r1,r1,r2                                
08027B8E 00C9     lsl     r1,r1,3h                                
08027B90 1809     add     r1,r1,r0                                
08027B92 8848     ldrh    r0,[r1,2h]  ;读取主精灵的Y坐标                            
08027B94 3890     sub     r0,90h      ;减去90h                            
08027B96 8058     strh    r0,[r3,2h]  ;写入当前精灵Y坐标                            
08027B98 8888     ldrh    r0,[r1,4h]  ;读取主精灵X坐标                            
08027B9A 3064     add     r0,64h      ;加上64                            
08027B9C E00E     b       @@Peer                                

@@FaceLeft:                              
08027BA8 4806     ldr     r0,=30001ACh                            
08027BAA 00D1     lsl     r1,r2,3h                                
08027BAC 1A89     sub     r1,r1,r2                                
08027BAE 00C9     lsl     r1,r1,3h                                
08027BB0 1809     add     r1,r1,r0                                
08027BB2 8848     ldrh    r0,[r1,2h]  ;读取主精灵的Y坐标                            
08027BB4 3860     sub     r0,60h      ;减去60h                            
08027BB6 8058     strh    r0,[r3,2h]  ;写入当前精灵Y坐标                            
08027BB8 8888     ldrh    r0,[r1,4h]  ;读取主精灵X坐标                            
08027BBA 3846     sub     r0,46h      ;减去46h

@@peer:                                
08027BBC 8098     strh    r0,[r3,4h]  ;写入当前精灵X坐标                            
08027BBE BC01     pop     r0                                      
08027BC0 4700     bx      r0                                      


;袍子 pose 0                              
08027BC8 B510     push    r4,r14                                  
08027BCA 4823     ldr     r0,=3000738h                            
08027BCC 4684     mov     r12,r0                                  
08027BCE 7F80     ldrb    r0,[r0,1Eh]    ;读取副精灵data                         
08027BD0 2800     cmp     r0,0h                                   
08027BD2 D104     bne     @@DataNo0                                
08027BD4 4662     mov     r2,r12                                  
08027BD6 8811     ldrh    r1,[r2]                                 
08027BD8 4820     ldr     r0,=0FFFBh                              
08027BDA 4008     and     r0,r1         ;取向7则为3,保留3或1               
08027BDC 8010     strh    r0,[r2]       ;再写入

@@DataNo0:                                 
08027BDE 4660     mov     r0,r12                                  
08027BE0 3027     add     r0,27h                                  
08027BE2 2300     mov     r3,0h                                   
08027BE4 210C     mov     r1,0Ch                                  
08027BE6 7001     strb    r1,[r0]       ;300075C写入0C                             
08027BE8 3001     add     r0,1h                                   
08027BEA 7001     strb    r1,[r0]       ;3000760写入0C                          
08027BEC 3001     add     r0,1h                                   
08027BEE 7001     strb    r1,[r0]       ;3000761写入0C                          
08027BF0 2200     mov     r2,0h                                   
08027BF2 491B     ldr     r1,=0FFF8h                              
08027BF4 4664     mov     r4,r12                                  
08027BF6 8161     strh    r1,[r4,0Ah]                             
08027BF8 2008     mov     r0,8h                                   
08027BFA 81A0     strh    r0,[r4,0Ch]                             
08027BFC 81E1     strh    r1,[r4,0Eh]                             
08027BFE 8220     strh    r0,[r4,10h]   ;写入四面分界                         
08027C00 4818     ldr     r0,=82E0BD0h                            
08027C02 61A0     str     r0,[r4,18h]   ;写入OAM                          
08027C04 7722     strb    r2,[r4,1Ch]                             
08027C06 82E3     strh    r3,[r4,16h]                             
08027C08 4661     mov     r1,r12                                  
08027C0A 3124     add     r1,24h                                  
08027C0C 2009     mov     r0,9h                                   
08027C0E 7008     strb    r0,[r1]       ;pose写入9h                            
08027C10 4660     mov     r0,r12                                  
08027C12 3025     add     r0,25h                                  
08027C14 7002     strb    r2,[r0]       ;属性写入0                          
08027C16 3902     sub     r1,2h                                   
08027C18 2003     mov     r0,3h                                   
08027C1A 7008     strb    r0,[r1]       ;75A写入3                           
08027C1C 4912     ldr     r1,=3000088h                            
08027C1E 7B09     ldrb    r1,[r1,0Ch]   ;读取3000094                          
08027C20 4008     and     r0,r1         ;And3                          
08027C22 4661     mov     r1,r12                                  
08027C24 3121     add     r1,21h                                  
08027C26 7008     strb    r0,[r1]       ;写入759                          
08027C28 4A10     ldr     r2,=82B1BE4h                            
08027C2A 7F61     ldrb    r1,[r4,1Dh]                             
08027C2C 00C8     lsl     r0,r1,3h                                
08027C2E 1840     add     r0,r0,r1                                
08027C30 0040     lsl     r0,r0,1h                                
08027C32 1880     add     r0,r0,r2                                
08027C34 8800     ldrh    r0,[r0]                                 
08027C36 82A0     strh    r0,[r4,14h]   ;写入血量                           
08027C38 8820     ldrh    r0,[r4]                                 
08027C3A 2280     mov     r2,80h                                  
08027C3C 0212     lsl     r2,r2,8h                                
08027C3E 1C11     mov     r1,r2         ;取向ORR8000 无敌                           
08027C40 4308     orr     r0,r1                                   
08027C42 8020     strh    r0,[r4]       ;再写入                          
08027C44 4661     mov     r1,r12                                  
08027C46 3126     add     r1,26h                                  
08027C48 2001     mov     r0,1h                                   
08027C4A 7008     strb    r0,[r1]       ;75E写入1                           
08027C4C F7FFFF92 bl      8027B74h      ;出生地点设定                          
08027C50 BC10     pop     r4                                      
08027C52 BC01     pop     r0                                      
08027C54 4700     bx      r0                                      


;pose 9                              
08027C70 B500     push    r14                                     
08027C72 F7FFFF7F bl      8027B74h      ;出生地点设定                           
08027C76 4804     ldr     r0,=300070Ch                            
08027C78 8940     ldrh    r0,[r0,0Ah]   ;读取712的值,血量???                          
08027C7A 2800     cmp     r0,0h                                   
08027C7C D108     bne     @@712No0                                
08027C7E 4803     ldr     r0,=3000738h                            
08027C80 3024     add     r0,24h                                  
08027C82 2142     mov     r1,42h        ;pose写入42h                           
08027C84 E027     b       @@Poseend                                 

@@712No0:                              
08027C90 4A12     ldr     r2,=3000738h                            
08027C92 7F90     ldrb    r0,[r2,1Eh]   ;读取精灵data                          
08027C94 2800     cmp     r0,0h                                   
08027C96 D10E     bne     @@Pass      ;不为0跳转                          
08027C98 8811     ldrh    r1,[r2]     ;读取取向                            
08027C9A 2002     mov     r0,2h                                   
08027C9C 4008     and     r0,r1                                   
08027C9E 2800     cmp     r0,0h       ;在屏幕外跳转                            
08027CA0 D009     beq     @@Pass                                
08027CA2 8AD0     ldrh    r0,[r2,16h] ;读取精灵动画                            
08027CA4 2800     cmp     r0,0h                                   
08027CA6 D106     bne     @@Pass      ;不为0跳转                          
08027CA8 7F10     ldrb    r0,[r2,1Ch] ;读取精灵动画帧                            
08027CAA 2801     cmp     r0,1h                                   
08027CAC D103     bne     @@Pass      ;不为1跳转                          
08027CAE 20D0     mov     r0,0D0h                                 
08027CB0 0040     lsl     r0,r0,1h                                
08027CB2 F7DAFEB1 bl      8002A18h 

@@Pass:                               
08027CB6 F7E7FF87 bl      800FBC8h    ;检查动画结束                           
08027CBA 2800     cmp     r0,0h                                   
08027CBC D00C     beq     @@end                                
08027CBE 4807     ldr     r0,=3000738h                            
08027CC0 4907     ldr     r1,=82E0BF8h                            
08027CC2 6181     str     r1,[r0,18h]  ;写入新pose                           
08027CC4 2100     mov     r1,0h                                   
08027CC6 7701     strb    r1,[r0,1Ch]                             
08027CC8 82C1     strh    r1,[r0,16h]                             
08027CCA 1C02     mov     r2,r0                                   
08027CCC 3224     add     r2,24h       ;pose写入23h                           
08027CCE 2123     mov     r1,23h                                  
08027CD0 7011     strb    r1,[r2]                                 
08027CD2 302C     add     r0,2Ch                                  
08027CD4 213C     mov     r1,3Ch       ;764写入3C 

@@Posend:                                 
08027CD6 7001     strb    r1,[r0] 

@@end:                                
08027CD8 BC01     pop     r0                                      
08027CDA 4700     bx      r0                                      


;袍子 pose 23                               
08027CE4 B510     push    r4,r14                                  
08027CE6 F7FFFF45 bl      8027B74h     ;位置设定                            
08027CEA 4804     ldr     r0,=300070Ch                            
08027CEC 8940     ldrh    r0,[r0,0Ah]  ;读取血量                           
08027CEE 2800     cmp     r0,0h                                   
08027CF0 D108     bne     @@712No0                                
08027CF2 4803     ldr     r0,=3000738h                            
08027CF4 3024     add     r0,24h                                  
08027CF6 2142     mov     r1,42h       ;pose写入42h                            
08027CF8 7001     strb    r1,[r0]                                 
08027CFA E02D     b       @@end                                  

@@712No0:                             
08027D04 4A16     ldr     r2,=3000738h                            
08027D06 1C11     mov     r1,r2                                   
08027D08 312C     add     r1,2Ch                                  
08027D0A 7808     ldrb    r0,[r1]                                 
08027D0C 3801     sub     r0,1h                                   
08027D0E 7008     strb    r0,[r1]                                 
08027D10 0600     lsl     r0,r0,18h                               
08027D12 0E03     lsr     r3,r0,18h                               
08027D14 2B00     cmp     r3,0h                                   
08027D16 D11F     bne     @@end                                
08027D18 8810     ldrh    r0,[r2]                                 
08027D1A 4C12     ldr     r4,=7FFBh                               
08027D1C 4004     and     r4,r0          ;取向去掉无敌和4h                         
08027D1E 2100     mov     r1,0h                                   
08027D20 8014     strh    r4,[r2]        ;再写入                        
08027D22 4811     ldr     r0,=82E0C18h                            
08027D24 6190     str     r0,[r2,18h]    ;写入新OAM                         
08027D26 7711     strb    r1,[r2,1Ch]                             
08027D28 82D3     strh    r3,[r2,16h]                             
08027D2A 1C13     mov     r3,r2                                   
08027D2C 3332     add     r3,32h                                  
08027D2E 7818     ldrb    r0,[r3]        ;读取碰撞属性                         
08027D30 2104     mov     r1,4h                                   
08027D32 4308     orr     r0,r1                                   
08027D34 7018     strb    r0,[r3]        ;orr 4再写入                         
08027D36 1C11     mov     r1,r2                                   
08027D38 3125     add     r1,25h                                  
08027D3A 2006     mov     r0,6h                                   
08027D3C 7008     strb    r0,[r1]        ;属性写入6h                         
08027D3E 3901     sub     r1,1h                                   
08027D40 2025     mov     r0,25h                                  
08027D42 7008     strb    r0,[r1]        ;pose写入25h                         
08027D44 7F90     ldrb    r0,[r2,1Eh]    ;读取精灵data                         
08027D46 2800     cmp     r0,0h          ;不为0则结束                         
08027D48 D106     bne     @@end                                
08027D4A 2002     mov     r0,2h                                   
08027D4C 4020     and     r0,r4          ;精灵data与2and                          
08027D4E 2800     cmp     r0,0h          ;如果为奇数结束                         
08027D50 D002     beq     @@end                                
08027D52 4806     ldr     r0,=1A1h       ;袍子音                           
08027D54 F7DAFE60 bl      8002A18h 

@@end:                               
08027D58 BC10     pop     r4                                      
08027D5A BC01     pop     r0                                      
08027D5C 4700     bx      r0                                      


;袍子 pose 25                                
08027D70 B510     push    r4,r14                                  
08027D72 2204     mov     r2,4h                                   
08027D74 4905     ldr     r1,=3000738h                            
08027D76 7F88     ldrb    r0,[r1,1Eh]    ;读取精灵data                           
08027D78 3801     sub     r0,1h                                   
08027D7A 1C0C     mov     r4,r1          ;减去1                         
08027D7C 2806     cmp     r0,6h                                   
08027D7E D86B     bhi     8027E58h                                
08027D80 0080     lsl     r0,r0,2h                                
08027D82 4903     ldr     r1,=8027D94h   ;Table                          
08027D84 1840     add     r0,r0,r1                                
08027D86 6800     ldr     r0,[r0]                                 
08027D88 4687     mov     r15,r0                                  

Table:
    .word 8027db0h
    .word 8027df0h
	.word 8027dd4h
	.word 8027e00h
	.word 8027e06h
	.word 8027e48h
	.word 8027e2ch
    	
;data1    	                               
08027DB0 1C10     mov     r0,r2         ;4h                           
08027DB2 F063FEBD bl      808BB30h      ;斜方向的袍子调用的例程                           
08027DB6 4B06     ldr     r3,=9999999Ah                           
08027DB8 4A04     ldr     r2,=3FE99999h                           
08027DBA F063FB27 bl      808B40Ch      ;斜方向的袍子速度调整使之轨迹是个圆                          
08027DBE F062FF85 bl      808ACCCh      ;斜方向的袍子调用的例程                          
08027DC2 0400     lsl     r0,r0,10h                               
08027DC4 0C02     lsr     r2,r0,10h                               
08027DC6 8860     ldrh    r0,[r4,2h]    ;Y坐标                          
08027DC8 1A80     sub     r0,r0,r2                                
08027DCA E010     b       @@Peer                                

;data3                           
08027DD4 1C10     mov     r0,r2                                   
08027DD6 F063FEAB bl      808BB30h                                
08027DDA 4B08     ldr     r3,=9999999Ah                           
08027DDC 4A06     ldr     r2,=3FE99999h                           
08027DDE F063FB15 bl      808B40Ch                                
08027DE2 F062FF73 bl      808ACCCh                                
08027DE6 0400     lsl     r0,r0,10h                               
08027DE8 0C02     lsr     r2,r0,10h                               
08027DEA 8860     ldrh    r0,[r4,2h]                              
08027DEC 1810     add     r0,r2,r0 

@@Peer:                               
08027DEE 8060     strh    r0,[r4,2h] 

;data2                             
08027DF0 88A0     ldrh    r0,[r4,4h]                              
08027DF2 1810     add     r0,r2,r0                                
08027DF4 80A0     strh    r0,[r4,4h]                              
08027DF6 E032     b       @@Peer5                                

;data4                           
08027E00 8860     ldrh    r0,[r4,2h]                              
08027E02 1A80     sub     r0,r0,r2                                
08027E04 E02A     b       @@Peer3 

;data5                               
08027E06 1C10     mov     r0,r2                                   
08027E08 F063FE92 bl      808BB30h                                
08027E0C 4B06     ldr     r3,=9999999Ah                           
08027E0E 4A05     ldr     r2,=3FE99999h                           
08027E10 F063FAFC bl      808B40Ch                                
08027E14 F062FF5A bl      808ACCCh                                
08027E18 0400     lsl     r0,r0,10h                               
08027E1A 0C02     lsr     r2,r0,10h                               
08027E1C 8860     ldrh    r0,[r4,2h]                              
08027E1E 1810     add     r0,r2,r0                                
08027E20 E011     b       @@Peer2                                

;data7                           
08027E2C 1C10     mov     r0,r2                                   
08027E2E F063FE7F bl      808BB30h                                
08027E32 4B08     ldr     r3,=9999999Ah                           
08027E34 4A06     ldr     r2,=3FE99999h                           
08027E36 F063FAE9 bl      808B40Ch                                
08027E3A F062FF47 bl      808ACCCh                                
08027E3E 0400     lsl     r0,r0,10h                               
08027E40 0C02     lsr     r2,r0,10h                               
08027E42 8860     ldrh    r0,[r4,2h]                              
08027E44 1A80     sub     r0,r0,r2  

@@Peer2:                              
08027E46 8060     strh    r0,[r4,2h] 

;data6                             
08027E48 88A0     ldrh    r0,[r4,4h]                              
08027E4A 1A80     sub     r0,r0,r2                                
08027E4C 80A0     strh    r0,[r4,4h]                              
08027E4E E006     b       @@Peer5                                

@@Data8:                           
08027E58 8860     ldrh    r0,[r4,2h]                              
08027E5A 3004     add     r0,4h   

@@Peer3                                
08027E5C 8060     strh    r0,[r4,2h]

@@Peer5                              
08027E5E 8860     ldrh    r0,[r4,2h]                              
08027E60 88A1     ldrh    r1,[r4,4h]                              
08027E62 F7E7FC11 bl      800F688h                                
08027E66 4806     ldr     r0,=30007F1h                            
08027E68 7801     ldrb    r1,[r0]                                 
08027E6A 20F0     mov     r0,0F0h                                 
08027E6C 4008     and     r0,r1                                   
08027E6E 2800     cmp     r0,0h                                   
08027E70 D003     beq     @@end                                
08027E72 1C21     mov     r1,r4                                   
08027E74 3124     add     r1,24h                                  
08027E76 2042     mov     r0,42h                                  
08027E78 7008     strb    r0,[r1]

@@end:                                                                 
08027E7A BC10     pop     r4                                      
08027E7C BC01     pop     r0                                      
08027E7E 4700     bx      r0                                      


;袍子 pose 42             袍子碰壁或碰到敌人                
08027E84 4A0A     ldr     r2,=3000738h                            
08027E86 1C13     mov     r3,r2                                   
08027E88 3326     add     r3,26h                                  
08027E8A 2100     mov     r1,0h                                   
08027E8C 2001     mov     r0,1h                                   
08027E8E 7018     strb    r0,[r3]         ;75E写入1,变得判定无效                        
08027E90 4808     ldr     r0,=82E0C38h                            
08027E92 6190     str     r0,[r2,18h]     ;写入碎掉的OAM                         
08027E94 7711     strb    r1,[r2,1Ch]                             
08027E96 82D1     strh    r1,[r2,16h]                             
08027E98 1C11     mov     r1,r2                                   
08027E9A 3124     add     r1,24h                                  
08027E9C 2043     mov     r0,43h                                  
08027E9E 7008     strb    r0,[r1]         ;pose写入43h                        
08027EA0 8811     ldrh    r1,[r2]         ;读取取向                         
08027EA2 2380     mov     r3,80h                                  
08027EA4 021B     lsl     r3,r3,8h                                
08027EA6 1C18     mov     r0,r3                                   
08027EA8 4308     orr     r0,r1           ;orr8000h再写入 无敌                         
08027EAA 8010     strh    r0,[r2]                                 
08027EAC 4770     bx      r14                                     


;袍子 pose 43h                             
08027EB8 B510     push    r4,r14                                  
08027EBA 4C07     ldr     r4,=3000738h                            
08027EBC 1C21     mov     r1,r4                                   
08027EBE 3126     add     r1,26h                                  
08027EC0 2001     mov     r0,1h                                   
08027EC2 7008     strb    r0,[r1]         ;75E写入1                        
08027EC4 F7E7FE80 bl      800FBC8h        ;检查动画                        
08027EC8 2800     cmp     r0,0h                                   
08027ECA D001     beq     @@end                        
08027ECC 2000     mov     r0,0h                                   
08027ECE 8020     strh    r0,[r4]         ;动画结束精灵消失

@@end                                
08027ED0 BC10     pop     r4                                      
08027ED2 BC01     pop     r0                                      
08027ED4 4700     bx      r0                                      


;副精灵 6 翅膀乌龟调用例程                             
08027EDC B5F0     push    r4-r7,r14                               
08027EDE 4657     mov     r7,r10                                  
08027EE0 464E     mov     r6,r9                                   
08027EE2 4645     mov     r5,r8                                   
08027EE4 B4E0     push    r5-r7                                   
08027EE6 B084     add     sp,-10h                                 
08027EE8 2000     mov     r0,0h                                   
08027EEA 4682     mov     r10,r0                                  
08027EEC 4F2A     ldr     r7,=3000738h                            
08027EEE 1C38     mov     r0,r7                                   
08027EF0 3023     add     r0,23h          ;查看主序号                         
08027EF2 7801     ldrb    r1,[r0]                                 
08027EF4 4A29     ldr     r2,=30001ACh                            
08027EF6 00C8     lsl     r0,r1,3h                                
08027EF8 1A40     sub     r0,r0,r1                                
08027EFA 00C0     lsl     r0,r0,3h                                
08027EFC 1885     add     r5,r0,r2                                
08027EFE 1C28     mov     r0,r5                                   
08027F00 3024     add     r0,24h                                  
08027F02 7800     ldrb    r0,[r0]         ;检查主精灵的POSE                         
08027F04 2809     cmp     r0,9h           ;不为9跳转                        
08027F06 D13E     bne     @@Pass                                
08027F08 1C28     mov     r0,r5                                   
08027F0A 302F     add     r0,2Fh                                  
08027F0C 7800     ldrb    r0,[r0]         ;读取主精灵767的值                        
08027F0E 2810     cmp     r0,10h                                  
08027F10 D939     bls     @@Pass          ;小于等于跳转                        
08027F12 8879     ldrh    r1,[r7,2h]      ;读取Y坐标                        
08027F14 88BB     ldrh    r3,[r7,4h]      ;读取X坐标                        
08027F16 8978     ldrh    r0,[r7,0Ah]     ;读取上部分界                        
08027F18 1808     add     r0,r1,r0        ;加上Y坐标                        
08027F1A 0400     lsl     r0,r0,10h                               
08027F1C 0C00     lsr     r0,r0,10h       ;值给R0                        
08027F1E 89BA     ldrh    r2,[r7,0Ch]     ;读取下部分界                        
08027F20 1889     add     r1,r1,r2        ;加上Y坐标                        
08027F22 0409     lsl     r1,r1,10h                               
08027F24 0C09     lsr     r1,r1,10h       ;值给R1                        
08027F26 89FA     ldrh    r2,[r7,0Eh]     ;读取左部分界                        
08027F28 189A     add     r2,r3,r2        ;加上X坐标                        
08027F2A 0412     lsl     r2,r2,10h                               
08027F2C 0C12     lsr     r2,r2,10h       ;值给R2                        
08027F2E 8A3C     ldrh    r4,[r7,10h]     ;读取右部分界                        
08027F30 191B     add     r3,r3,r4        ;加上X坐标                        
08027F32 041B     lsl     r3,r3,10h                               
08027F34 0C1B     lsr     r3,r3,10h       ;值给R3                        
08027F36 886C     ldrh    r4,[r5,2h]      ;读取主精灵Y坐标                        
08027F38 46A0     mov     r8,r4                                   
08027F3A 88AC     ldrh    r4,[r5,4h]      ;读取主精灵X坐标                        
08027F3C 46A1     mov     r9,r4                                   
08027F3E 896E     ldrh    r6,[r5,0Ah]     ;读取主精灵上部分界                        
08027F40 4446     add     r6,r8           ;加上Y坐标                        
08027F42 0436     lsl     r6,r6,10h                               
08027F44 0C36     lsr     r6,r6,10h       ;值给R6                        
08027F46 89AC     ldrh    r4,[r5,0Ch]     ;读取主精灵下部分界                        
08027F48 44A0     add     r8,r4                                   
08027F4A 4644     mov     r4,r8           ;加上Y坐标                        
08027F4C 0424     lsl     r4,r4,10h                               
08027F4E 0C24     lsr     r4,r4,10h                               
08027F50 46A0     mov     r8,r4           ;值给R4                        
08027F52 89EC     ldrh    r4,[r5,0Eh]     ;读取主精灵左部分界                        
08027F54 444C     add     r4,r9           ;加上X坐标                        
08027F56 0424     lsl     r4,r4,10h                               
08027F58 0C24     lsr     r4,r4,10h       ;值给R4                        
08027F5A 8A2D     ldrh    r5,[r5,10h]     ;读取主精灵右部分界                        
08027F5C 44A9     add     r9,r5           ;加上X坐标                        
08027F5E 464D     mov     r5,r9                                   
08027F60 042D     lsl     r5,r5,10h                               
08027F62 0C2D     lsr     r5,r5,10h                               
08027F64 46A9     mov     r9,r5           ;值给R9                        
08027F66 9600     str     r6,[sp]                                 
08027F68 4645     mov     r5,r8                                   
08027F6A 9501     str     r5,[sp,4h]                              
08027F6C 9402     str     r4,[sp,8h]                              
08027F6E 464C     mov     r4,r9                                   
08027F70 9403     str     r4,[sp,0Ch]                             
08027F72 F7E6FBC1 bl      800E6F8h        ;超炸的检查重合例程                        
08027F76 2800     cmp     r0,0h                                   
08027F78 D005     beq     @@Pass                                
08027F7A 1C39     mov     r1,r7                                   
08027F7C 3124     add     r1,24h                                  
08027F7E 2062     mov     r0,62h                                   
08027F80 7008     strb    r0,[r1]         ;如果相交则pose写入62h 死亡pose                        
08027F82 2501     mov     r5,1h                                   
08027F84 46AA     mov     r10,r5

@@Pass:                                  
08027F86 4650     mov     r0,r10          ;相交则返回1                        
08027F88 B004     add     sp,10h                                  
08027F8A BC38     pop     r3-r5                                   
08027F8C 4698     mov     r8,r3                                   
08027F8E 46A1     mov     r9,r4                                   
08027F90 46AA     mov     r10,r5                                  
08027F92 BCF0     pop     r4-r7                                   
08027F94 BC02     pop     r1                                      
08027F96 4708     bx      r1                                      


;副精灵6 飞龟 pose 0                             
08027FA0 B570     push    r4-r6,r14                               
08027FA2 4822     ldr     r0,=3000738h                            
08027FA4 4684     mov     r12,r0                                  
08027FA6 8800     ldrh    r0,[r0]      ;读取取向                            
08027FA8 4A21     ldr     r2,=0FFFBh                              
08027FAA 4002     and     r2,r0        ;去掉4h                            
08027FAC 2600     mov     r6,0h                                   
08027FAE 2300     mov     r3,0h                                   
08027FB0 4661     mov     r1,r12                                  
08027FB2 800A     strh    r2,[r1]      ;再写入                           
08027FB4 491F     ldr     r1,=0FFE0h                              
08027FB6 4664     mov     r4,r12                                  
08027FB8 8161     strh    r1,[r4,0Ah]  ;上部分界                           
08027FBA 2504     mov     r5,4h                                   
08027FBC 2004     mov     r0,4h                                   
08027FBE 81A0     strh    r0,[r4,0Ch]                             
08027FC0 81E1     strh    r1,[r4,0Eh]                             
08027FC2 2020     mov     r0,20h                                  
08027FC4 8220     strh    r0,[r4,10h]  ;四面分界                           
08027FC6 4661     mov     r1,r12                                  
08027FC8 3127     add     r1,27h                                  
08027FCA 200C     mov     r0,0Ch                                  
08027FCC 7008     strb    r0,[r1]      ;75F写入0Ch                           
08027FCE 4660     mov     r0,r12                                  
08027FD0 3028     add     r0,28h                                  
08027FD2 2408     mov     r4,8h                                   
08027FD4 7004     strb    r4,[r0]      ;760写入8h                           
08027FD6 3102     add     r1,2h                                   
08027FD8 2010     mov     r0,10h                                  
08027FDA 7008     strb    r0,[r1]      ;761写入10h                           
08027FDC 4816     ldr     r0,=82E0C60h                            
08027FDE 4661     mov     r1,r12                                  
08027FE0 6188     str     r0,[r1,18h]  ;写入OAM                           
08027FE2 770E     strb    r6,[r1,1Ch]                             
08027FE4 82CB     strh    r3,[r1,16h]                             
08027FE6 4660     mov     r0,r12                                  
08027FE8 3025     add     r0,25h                                  
08027FEA 7005     strb    r5,[r0]      ;属性写入4                           
08027FEC 4B13     ldr     r3,=82B1BE4h                            
08027FEE 7F49     ldrb    r1,[r1,1Dh]                             
08027FF0 00C8     lsl     r0,r1,3h                                
08027FF2 1840     add     r0,r0,r1                                
08027FF4 0040     lsl     r0,r0,1h                                
08027FF6 18C0     add     r0,r0,r3                                
08027FF8 8800     ldrh    r0,[r0]                                 
08027FFA 4661     mov     r1,r12                                  
08027FFC 8288     strh    r0,[r1,14h]  ;写入血量                           
08027FFE 4660     mov     r0,r12                                  
08028000 3022     add     r0,22h                                  
08028002 7004     strb    r4,[r0]      ;75A写入8h                           
08028004 3002     add     r0,2h                                   
08028006 7004     strb    r4,[r0]      ;pose写入8h                            
08028008 20C0     mov     r0,0C0h                                 
0802800A 8248     strh    r0,[r1,12h]  ;74A写入C0h                           
0802800C 312D     add     r1,2Dh                                  
0802800E 2080     mov     r0,80h                                  
08028010 7008     strb    r0,[r1]      ;765写入80h                           
08028012 2480     mov     r4,80h                                  
08028014 00A4     lsl     r4,r4,2h                                
08028016 1C20     mov     r0,r4                                   
08028018 4302     orr     r2,r0        ;取向ORR200h                            
0802801A 4660     mov     r0,r12                                  
0802801C 8002     strh    r2,[r0]      ;写入取向                           
0802801E 302F     add     r0,2Fh                                  
08028020 7006     strb    r6,[r0]      ;767写入0                           
08028022 3004     add     r0,4h                                   
08028024 7005     strb    r5,[r0]      ;76b写入4h                           
08028026 BC70     pop     r4-r6                                   
08028028 BC01     pop     r0                                      
0802802A 4700     bx      r0                                      


;副精灵 6 飞龟 pose 8h                              
08028040 4905     ldr     r1,=3000738h                            
08028042 1C0A     mov     r2,r1                                   
08028044 3224     add     r2,24h                                  
08028046 2300     mov     r3,0h                                   
08028048 2009     mov     r0,9h                                   
0802804A 7010     strb    r0,[r2]       ;pose写入9h                          
0802804C 4803     ldr     r0,=82E0C60h                            
0802804E 6188     str     r0,[r1,18h]   ;写入OAM                          
08028050 2000     mov     r0,0h                                   
08028052 82CB     strh    r3,[r1,16h]                             
08028054 7708     strb    r0,[r1,1Ch]                             
08028056 4770     bx      r14                                     


;副精灵6 飞龟 pose 9h                               
08028060 B5F0     push    r4-r7,r14                               
08028062 4C0C     ldr     r4,=3000738h                            
08028064 8822     ldrh    r2,[r4]       ;读取取向                           
08028066 2580     mov     r5,80h                                  
08028068 00AD     lsl     r5,r5,2h                                 
0802806A 1C28     mov     r0,r5                                   
0802806C 4010     and     r0,r2         ;and 8000h                           
0802806E 2800     cmp     r0,0h                                   
08028070 D03A     beq     @@No8000                                
08028072 1C21     mov     r1,r4                                   
08028074 312D     add     r1,2Dh                                  
08028076 7808     ldrb    r0,[r1]       ;765的值                          
08028078 2800     cmp     r0,0h                                   
0802807A D10F     bne     @@765No0                                
0802807C 23C0     mov     r3,0C0h                                 
0802807E 005B     lsl     r3,r3,1h                                
08028080 1C18     mov     r0,r3                                   
08028082 8926     ldrh    r6,[r4,8h]    ;读取备用X坐标                           
08028084 1980     add     r0,r0,r6      ;加上180h                          
08028086 8120     strh    r0,[r4,8h]    ;再写入                          
08028088 4803     ldr     r0,=0FDFFh                              
0802808A 4010     and     r0,r2                                   
0802808C 8020     strh    r0,[r4]       ;去掉取向的200h再写入                           
0802808E 207F     mov     r0,7Fh                                  
08028090 7008     strb    r0,[r1]       ;765写入7F                          
08028092 E062     b       @@Peer                                 

@@765No0:                              
0802809C 2880     cmp     r0,80h                                  
0802809E D107     bne     @@765No80                                
080280A0 69A0     ldr     r0,[r4,18h]                             
080280A2 4902     ldr     r1,=82E0CB0h  ;比较OAM是否相等                           
080280A4 4288     cmp     r0,r1                                   
080280A6 D058     beq     @@Peer                                
080280A8 61A1     str     r1,[r4,18h]   ;否则写入OAM                          
080280AA E010     b       80280CEh                                 

@@765No80:                             
080280B0 69A1     ldr     r1,[r4,18h]                             
080280B2 4809     ldr     r0,=82E0CB0h                            
080280B4 4281     cmp     r1,r0         ;比较OAM是否不相等                          
080280B6 D150     bne     @@Peer                                
080280B8 F7E7FD86 bl      800FBC8h      ;相等的话检查动画是否结束                          
080280BC 2800     cmp     r0,0h                                   
080280BE D04C     beq     @@Peer        ;不结束则继续                        
080280C0 8821     ldrh    r1,[r4]       ;读取取向                          
080280C2 2040     mov     r0,40h                                  
080280C4 4008     and     r0,r1         ;与40and                          
080280C6 2800     cmp     r0,0h                                   
080280C8 D00A     beq     @@FaceLeft                                
080280CA 4804     ldr     r0,=82E0C60h                            
080280CC 61A0     str     r0,[r4,18h]   ;新OAM写入

@@Peer2:                            
080280CE 2100     mov     r1,0h                                   
080280D0 2000     mov     r0,0h                                   
080280D2 82E0     strh    r0,[r4,16h]                             
080280D4 7721     strb    r1,[r4,1Ch]                             
080280D6 E040     b       @@Peer                                

@@FaceLeft:                               
080280E0 2040     mov     r0,40h                                  
080280E2 4308     orr     r0,r1        ;取向orr40再写入                            
080280E4 8020     strh    r0,[r4]                                 
080280E6 E038     b       @@Peer

@@No8000:                                
080280E8 1C23     mov     r3,r4                                   
080280EA 332D     add     r3,2Dh                                  
080280EC 7819     ldrb    r1,[r3]     ;读取765                             
080280EE 2980     cmp     r1,80h                                  
080280F0 D10C     bne     @@765Not80                                
080280F2 4905     ldr     r1,=0FFFFFE80h                          
080280F4 1C08     mov     r0,r1                                   
080280F6 8926     ldrh    r6,[r4,8h]  ;读取备用X坐标                            
080280F8 1980     add     r0,r0,r6    ;减去180h再写入                            
080280FA 8120     strh    r0,[r4,8h]                              
080280FC 1C28     mov     r0,r5                                   
080280FE 4310     orr     r0,r2        ;取向orr8000h再写入                           
08028100 8020     strh    r0,[r4]                                 
08028102 2001     mov     r0,1h                                   
08028104 7018     strb    r0,[r3]      ;765写入1h                            
08028106 E028     b       @@Peer                                

@@765Not80:                               
0802810C 2900     cmp     r1,0h                                   
0802810E D107     bne     @@765Not0                                
08028110 69A0     ldr     r0,[r4,18h]                             
08028112 4A02     ldr     r2,=82E0CB0h                            
08028114 4290     cmp     r0,r2        ;比较OAM是否相等                            
08028116 D020     beq     @@Peer                                
08028118 61A2     str     r2,[r4,18h]                             
0802811A E01B     b       @@Peer3      ;不等写入OAM                            

@@765Not0:                             
08028120 69A1     ldr     r1,[r4,18h]                             
08028122 4809     ldr     r0,=82E0CB0h                            
08028124 4281     cmp     r1,r0                                   
08028126 D118     bne     @@Peer                                
08028128 F7E7FD4E bl      800FBC8h     ;检查动画是否结束                           
0802812C 2800     cmp     r0,0h                                   
0802812E D014     beq     @@Peer       ;不结束跳转                         
08028130 8822     ldrh    r2,[r4]                                 
08028132 2040     mov     r0,40h                                  
08028134 4010     and     r0,r2        ;取向and40h                           
08028136 0400     lsl     r0,r0,10h                               
08028138 0C01     lsr     r1,r0,10h                               
0802813A 2900     cmp     r1,0h                                   
0802813C D008     beq     @@FaceLeft2                                
0802813E 4803     ldr     r0,=0FFBFh                              
08028140 4010     and     r0,r2       ;取向去掉40h                            
08028142 8020     strh    r0,[r4]     ;再写入                            
08028144 E009     b       @@Peer                                 

@@FaceLeft2:                               
08028150 480C     ldr     r0,=82E0C60h                            
08028152 61A0     str     r0,[r4,18h] 

@@Peer3:                            
08028154 2000     mov     r0,0h                                   
08028156 82E1     strh    r1,[r4,16h]                             
08028158 7720     strb    r0,[r4,1Ch] 

@@Peer:                            
0802815A 4A0B     ldr     r2,=3000738h                            
0802815C 1C10     mov     r0,r2                                   
0802815E 302F     add     r0,2Fh                                  
08028160 7801     ldrb    r1,[r0]    ;读取767                              
08028162 2001     mov     r0,1h                                   
08028164 4008     and     r0,r1      ;检查是否是奇数                             
08028166 1C13     mov     r3,r2                                   
08028168 2800     cmp     r0,0h                                   
0802816A D014     beq     @@767isNum2 ;是偶数                                
0802816C 8819     ldrh    r1,[r3]                                 
0802816E 2080     mov     r0,80h                                  
08028170 0080     lsl     r0,r0,2h                                
08028172 4008     and     r0,r1       ;取向and 8000h                            
08028174 2800     cmp     r0,0h                                   
08028176 D009     beq     @@738No8000                                
08028178 1C19     mov     r1,r3                                   
0802817A 312D     add     r1,2Dh                                  
0802817C 7808     ldrb    r0,[r1]     ;765加1                            
0802817E 3001     add     r0,1h       ;再写入                            
08028180 E008     b       @@Peer4                                

@@738No8000:                               
0802818C 1C19     mov     r1,r3                                   
0802818E 312D     add     r1,2Dh                                  
08028190 7808     ldrb    r0,[r1]     ;读取765减1再写入                             
08028192 3801     sub     r0,1h   

@@Peer4:                                
08028194 7008     strb    r0,[r1]

@@767isNum2:                                 
08028196 2012     mov     r0,12h                                  
08028198 5E1D     ldsh    r5,[r3,r0]   ;得到74a的值                           
0802819A 1C18     mov     r0,r3                                   
0802819C 302D     add     r0,2Dh                                  
0802819E 7804     ldrb    r4,[r0]      ;读取765的值                           
080281A0 4909     ldr     r1,=808C71Ch                            
080281A2 0060     lsl     r0,r4,1h     ;765的值乘以2                           
080281A4 1840     add     r0,r0,r1     ;加上偏移值                           
080281A6 2600     mov     r6,0h                                   
080281A8 5F82     ldsh    r2,[r0,r6]   ;读取地址的数值                           
080281AA 2002     mov     r0,2h                                   
080281AC 5E1F     ldsh    r7,[r3,r0]   ;读取Y坐标数值                           
080281AE 2A00     cmp     r2,0h        ;地址数值                           
080281B0 DA0C     bge     @@NumoreThan0     ;大于等于0跳转                           
080281B2 4250     neg     r0,r2        ;取负                           
080281B4 4368     mul     r0,r5        ;乘以74A的值                           
080281B6 2800     cmp     r0,0h                                   
080281B8 DA00     bge     @@Pass                                
080281BA 30FF     add     r0,0FFh      ;小于0则加上FFh

@@Pass:                               
080281BC 0200     lsl     r0,r0,8h                                
080281BE 1402     asr     r2,r0,10h    ;相当于除以4?                            
080281C0 88D8     ldrh    r0,[r3,6h]   ;读取备用Y坐标                           
080281C2 1A80     sub     r0,r0,r2     ;减去该值                           
080281C4 E00B     b       @@Peer5                                

@@NumoreThan0:                              
080281CC 1C10     mov     r0,r2                                   
080281CE 4368     mul     r0,r5                                   
080281D0 2800     cmp     r0,0h                                   
080281D2 DA00     bge     @@Pass2                                
080281D4 30FF     add     r0,0FFh 

@@Pass2:                                
080281D6 0200     lsl     r0,r0,8h                                
080281D8 1400     asr     r0,r0,10h                               
080281DA 88DA     ldrh    r2,[r3,6h]                              
080281DC 1880     add     r0,r0,r2   

@@Peer5:                             
080281DE 8058     strh    r0,[r3,2h]                              
080281E0 1C20     mov     r0,r4                                   
080281E2 3040     add     r0,40h                                  
080281E4 0040     lsl     r0,r0,1h                                
080281E6 1840     add     r0,r0,r1                                
080281E8 2600     mov     r6,0h                                   
080281EA 5F84     ldsh    r4,[r0,r6]                              
080281EC 2004     mov     r0,4h                                   
080281EE 5E1E     ldsh    r6,[r3,r0]                              
080281F0 2C00     cmp     r4,0h                                   
080281F2 DA09     bge     8028208h                                
080281F4 4260     neg     r0,r4                                   
080281F6 4368     mul     r0,r5                                   
080281F8 2800     cmp     r0,0h                                   
080281FA DA00     bge     80281FEh                                
080281FC 30FF     add     r0,0FFh                                 
080281FE 0200     lsl     r0,r0,8h                                
08028200 1404     asr     r4,r0,10h                               
08028202 8918     ldrh    r0,[r3,8h]                              
08028204 1B00     sub     r0,r0,r4                                
08028206 E008     b       802821Ah                                
08028208 1C20     mov     r0,r4                                   
0802820A 4368     mul     r0,r5                                   
0802820C 2800     cmp     r0,0h                                   
0802820E DA00     bge     8028212h                                
08028210 30FF     add     r0,0FFh                                 
08028212 0200     lsl     r0,r0,8h                                
08028214 1400     asr     r0,r0,10h                               
08028216 8919     ldrh    r1,[r3,8h]                              
08028218 1840     add     r0,r0,r1                                
0802821A 8098     strh    r0,[r3,4h]                              
0802821C 2002     mov     r0,2h                                   
0802821E 5E1A     ldsh    r2,[r3,r0]                              
08028220 2104     mov     r1,4h                                   
08028222 5E5C     ldsh    r4,[r3,r1]                              
08028224 8819     ldrh    r1,[r3]                                 
08028226 2080     mov     r0,80h                                  
08028228 0140     lsl     r0,r0,5h                                
0802822A 4008     and     r0,r1                                   
0802822C 2800     cmp     r0,0h                                   
0802822E D023     beq     8028278h                                
08028230 42BA     cmp     r2,r7                                   
08028232 DD09     ble     8028248h                                
08028234 1BD0     sub     r0,r2,r7                                
08028236 0400     lsl     r0,r0,10h                               
08028238 4902     ldr     r1,=30013D4h                            
0802823A 1400     asr     r0,r0,10h                               
0802823C 8A8A     ldrh    r2,[r1,14h]                             
0802823E 1880     add     r0,r0,r2                                
08028240 E008     b       8028254h                                
08028242 0000     lsl     r0,r0,0h                                
08028244 13D4     asr     r4,r2,0Fh                               
08028246 0300     lsl     r0,r0,0Ch                               
08028248 1AB8     sub     r0,r7,r2                                
0802824A 0400     lsl     r0,r0,10h                               
0802824C 1407     asr     r7,r0,10h                               
0802824E 4906     ldr     r1,=30013D4h                            
08028250 8A88     ldrh    r0,[r1,14h]                             
08028252 1BC0     sub     r0,r0,r7                                
08028254 8288     strh    r0,[r1,14h]                             
08028256 42B4     cmp     r4,r6                                   
08028258 DD08     ble     802826Ch                                
0802825A 1BA0     sub     r0,r4,r6                                
0802825C 0400     lsl     r0,r0,10h                               
0802825E 1400     asr     r0,r0,10h                               
08028260 8A4B     ldrh    r3,[r1,12h]                             
08028262 18C0     add     r0,r0,r3                                
08028264 E007     b       8028276h                                
08028266 0000     lsl     r0,r0,0h                                
08028268 13D4     asr     r4,r2,0Fh                               
0802826A 0300     lsl     r0,r0,0Ch                               
0802826C 1B30     sub     r0,r6,r4                                
0802826E 0400     lsl     r0,r0,10h                               
08028270 1406     asr     r6,r0,10h                               
08028272 8A48     ldrh    r0,[r1,12h]                             
08028274 1B80     sub     r0,r0,r6                                
08028276 8248     strh    r0,[r1,12h]                             
08028278 F7FFFE30 bl      8027EDCh                                
0802827C BCF0     pop     r4-r7                                   
0802827E BC01     pop     r0                                      
08028280 4700     bx      r0                                      
08028282 0000     lsl     r0,r0,0h                                
08028284 B500     push    r14                                     
08028286 B081     add     sp,-4h                                  
08028288 480D     ldr     r0,=3000738h                            
0802828A 1C03     mov     r3,r0                                   
0802828C 3331     add     r3,31h                                  
0802828E 7819     ldrb    r1,[r3]                                 
08028290 1C02     mov     r2,r0                                   
08028292 2900     cmp     r1,0h                                   
08028294 D007     beq     80282A6h                                
08028296 490B     ldr     r1,=30013D4h                            
08028298 7848     ldrb    r0,[r1,1h]                              
0802829A 2801     cmp     r0,1h                                   
0802829C D101     bne     80282A2h                                
0802829E 2002     mov     r0,2h                                   
080282A0 7048     strb    r0,[r1,1h]                              
080282A2 2000     mov     r0,0h                                   
080282A4 7018     strb    r0,[r3]                                 
080282A6 8851     ldrh    r1,[r2,2h]                              
080282A8 3108     add     r1,8h                                   
080282AA 8892     ldrh    r2,[r2,4h]                              
080282AC 2020     mov     r0,20h                                  
080282AE 9000     str     r0,[sp]                                 
080282B0 2000     mov     r0,0h                                   
080282B2 2301     mov     r3,1h                                   
080282B4 F7E8FEE6 bl      8011084h                                
080282B8 B001     add     sp,4h                                   
080282BA BC01     pop     r0                                      
080282BC 4700     bx      r0                                      
080282BE 0000     lsl     r0,r0,0h                                
080282C0 0738     lsl     r0,r7,1Ch                               
080282C2 0300     lsl     r0,r0,0Ch                               
080282C4 13D4     asr     r4,r2,0Fh                               
080282C6 0300     lsl     r0,r0,0Ch
///////////////////////////////////////////////////////////////////////////////////////
;4F主程序                               
080282C8 B500     push    r14                                     
080282CA 4805     ldr     r0,=3000738h                            
080282CC 3024     add     r0,24h                                  
080282CE 7800     ldrb    r0,[r0]         ;读取pose                            
080282D0 2827     cmp     r0,27h                                  
080282D2 D86A     bhi     @@OtherPose                                
080282D4 0080     lsl     r0,r0,2h                                
080282D6 4903     ldr     r1,=80282E8h                            
080282D8 1840     add     r0,r0,r1                                
080282DA 6800     ldr     r0,[r0]                                 
080282DC 4687     mov     r15,r0    

PoseTable:
    .word 8028388h   ;00
	.word 80283aah .word 80283aah .word 80283aah .word 80283aah
    .word 80283aah .word 80283aah .word 80283aah
	.word 802838eh   ;08
	.word 8028394h   ;09
	.word 80283aah .word 80283aah .word 80283aah .word 80283aah
	.word 80283aah .word 80283aah .word 80283aah .word 80283aah
	.word 80283aah .word 80283aah .word 80283aah .word 80283aah
	.word 80283aah .word 80283aah .word 80283aah .word 80283aah
	.word 80283aah .word 80283aah .word 80283aah .word 80283aah
	.word 80283aah .word 80283aah .word 80283aah .word 80283aah
    .word 80283aah   
    .word 802839ah   ;23h
	.word 80283aah   
	.word 80283a0h   ;25h
	.word 80283aah
	.word 80283a6h   ;27h
                             
08028388 F7FEFD78 bl      8026E7Ch    ;00                             
0802838C E00D     b       @@OtherPose                                
0802838E F7FEFEE1 bl      8027154h    ;08                            
08028392 E00A     b       @@OtherPose                                
08028394 F7FEFF76 bl      8027284h    ;09                             
08028398 E007     b       @@OtherPose                                
0802839A F7FFF82D bl      80273F8h    ;23h                             
0802839E E004     b       @@OtherPose                                
080283A0 F7FFF8A8 bl      80274F4h    ;25h                            
080283A4 E001     b       @@OtherPose                                
080283A6 F7FFF8C9 bl      802753Ch    ;27h

@@OtherPose:                                
080283AA F7E8FFC1 bl      8011330h                                
080283AE 4804     ldr     r0,=3000738h                            
080283B0 3024     add     r0,24h                                  
080283B2 7800     ldrb    r0,[r0]                                 
080283B4 2824     cmp     r0,24h                                  
080283B6 D905     bls     80283C4h                                
080283B8 F7E8FFD8 bl      801136Ch                                
080283BC E004     b       80283C8h                                
080283BE 0000     lsl     r0,r0,0h                                
080283C0 0738     lsl     r0,r7,1Ch                               
080283C2 0300     lsl     r0,r0,0Ch                               
080283C4 F7FEFC38 bl      8026C38h                                
080283C8 BC01     pop     r0                                      
080283CA 4700     bx      r0  
/////////////////////////////////////////////////////////////////////////////////////////////////////
;---------------------------------------------------------------------------------------------------
;副精灵 14的主程序                                    
080283CC B500     push    r14                                     
080283CE 4806     ldr     r0,=3000738h                            
080283D0 3024     add     r0,24h                                  
080283D2 7800     ldrb    r0,[r0]    ;读取pose                             
080283D4 280E     cmp     r0,0Eh                                  
080283D6 D01B     beq     @@PoseE                               
080283D8 280E     cmp     r0,0Eh                                  
080283DA DC07     bgt     @@PoseMoreThanE                                
080283DC 2800     cmp     r0,0h                                   
080283DE D00F     beq     @@Pose0                                
080283E0 2808     cmp     r0,8h                                   
080283E2 D012     beq     @@Pose8                                
080283E4 E01C     b       @@Peer                                

@@PoseMoreThanE:                              
080283EC 2843     cmp     r0,43h                                  
080283EE D015     beq     @@Pose43                                
080283F0 2843     cmp     r0,43h                                  
080283F2 DC02     bgt     @@PoseMoreThan43                                
080283F4 2842     cmp     r0,42h                                  
080283F6 D00E     beq     @@Pose42                                
080283F8 E012     b       @@Peer

@@PoseMoreThan43:                                
080283FA 2862     cmp     r0,62h                                  
080283FC D003     beq     @@Pose62                                
080283FE E00F     b       @@Peer 

@@Pose0:                               
08028400 F7FFF8D4 bl      80275ACh                                
08028404 E00C     b       @@Peer 

@@Pose62:                               
08028406 F7FFFA7D bl      8027904h 

@@Pose8:                               
0802840A F7FFFA5F bl      80278CCh                                
0802840E E007     b       @@Peer 

@@PoseE:                               
08028410 F7FFFABC bl      802798Ch        ;生产袍子的例程                             
08028414 E004     b       @@Peer

@@Pose42:                                
08028416 F7FFFB69 bl      8027AECh                                
0802841A E001     b       @@Peer 

@@Pose43:                               
0802841C F7FFFB88 bl      8027B30h 

@@Peer:                               
08028420 4803     ldr     r0,=3000738h                            
08028422 3024     add     r0,24h                                  
08028424 7800     ldrb    r0,[r0]                                 
08028426 2867     cmp     r0,67h                                  
08028428 D104     bne     @@PoseNo67                                
0802842A F7E8FF9F bl      801136Ch                                
0802842E E003     b       @@end:                                 

@@PoseNo67:                              
08028434 F7FEFC00 bl      8026C38h 

@@end:                               
08028438 BC01     pop     r0                                      
0802843A 4700     bx      r0 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
;副精灵15 袍子主程序                                     
0802843C B510     push    r4,r14                                  
0802843E B081     add     sp,-4h                                  
08028440 4908     ldr     r1,=3000738h                            
08028442 1C08     mov     r0,r1                                   
08028444 3024     add     r0,24h                                  
08028446 7800     ldrb    r0,[r0]     ;读取pose                              
08028448 1C0C     mov     r4,r1                                   
0802844A 2842     cmp     r0,42h                                  
0802844C D01E     beq     @@Pose42                                
0802844E 2842     cmp     r0,42h                                  
08028450 DC0D     bgt     @@PoseMoreThan42                                
08028452 2823     cmp     r0,23h                                  
08028454 D014     beq     @@Pose23                                
08028456 2823     cmp     r0,23h                                  
08028458 DC06     bgt     @@PoseMoreThan23                                
0802845A 2800     cmp     r0,0h                                   
0802845C D00A     beq     @@Pose0                                
0802845E 2809     cmp     r0,9h                                   
08028460 D00B     beq     @@Pose9                                
08028462 E019     b       OtherPose                                

@@PoseMoreThan23:                              
08028468 2825     cmp     r0,25h                                  
0802846A D00C     beq     @@Pose25                                
0802846C E014     b       OtherPose 

@@PoseMoreThan42:                               
0802846E 2843     cmp     r0,43h                                  
08028470 D00F     beq     @@Pose43                                
08028472 E011     b       OtherPose

@@Pose0:                                
08028474 F7FFFBA8 bl      8027BC8h                                
08028478 E021     b       @@end 

@@Pose9:                               
0802847A F7FFFBF9 bl      8027C70h                                
0802847E E01E     b       @@end

@@Pose23:                                
08028480 F7FFFC30 bl      8027CE4h                                
08028484 E01B     b       @@end  

@@Pose25:                              
08028486 F7FFFC73 bl      8027D70h                                
0802848A E018     b       @@end

@@Pose42:                                
0802848C F7FFFCFA bl      8027E84h                                
08028490 E015     b       @@end 

@@Pose43:                               
08028492 F7FFFD11 bl      8027EB8h                                
08028496 E012     b       @@end  

OtherPose:                              
08028498 8861     ldrh    r1,[r4,2h]                              
0802849A 88A2     ldrh    r2,[r4,4h]                              
0802849C 2020     mov     r0,20h                                  
0802849E 9000     str     r0,[sp]                                 
080284A0 2000     mov     r0,0h                                   
080284A2 2301     mov     r3,1h                                   
080284A4 F7E8FDEE bl      8011084h                                
080284A8 8821     ldrh    r1,[r4]                                 
080284AA 2001     mov     r0,1h                                   
080284AC 4008     and     r0,r1                                   
080284AE 2800     cmp     r0,0h                                   
080284B0 D005     beq     @@end                                
080284B2 F7E8FA25 bl      8010900h                                
080284B6 2801     cmp     r0,1h                                   
080284B8 DD01     ble     @@end                                
080284BA 2000     mov     r0,0h                                   
080284BC 8020     strh    r0,[r4]

@@end:                                 
080284BE B001     add     sp,4h                                   
080284C0 BC10     pop     r4                                      
080284C2 BC01     pop     r0                                      
080284C4 4700     bx      r0                                      


;副精灵 6 翅膀乌龟 主程序                               
080284C8 B510     push    r4,r14                                  
080284CA 4C0D     ldr     r4,=3000738h                            
080284CC 1C20     mov     r0,r4                                   
080284CE 3030     add     r0,30h                                  
080284D0 7800     ldrb    r0,[r0]    ;读取冰冻时间                             
080284D2 2800     cmp     r0,0h                                   
080284D4 D006     beq     80284E4h                                
080284D6 F7E7FDB9 bl      801004Ch   ;冰冻例程                             
080284DA F7FFFCFF bl      8027EDCh   ;检查是否和主精灵重合以及                             
080284DE 0600     lsl     r0,r0,18h                               
080284E0 2800     cmp     r0,0h      ;为0则没有相交                             
080284E2 D021     beq     @@end                                
080284E4 F7E8FECC bl      8011280h   ;击晕例程                             
080284E8 2800     cmp     r0,0h                                   
080284EA D11D     bne     @@end                                
080284EC 1C20     mov     r0,r4                                   
080284EE 3024     add     r0,24h     ;读取pose                              
080284F0 7800     ldrb    r0,[r0]                                 
080284F2 2808     cmp     r0,8h                                   
080284F4 D00C     beq     @@Pose8                                
080284F6 2808     cmp     r0,8h                                   
080284F8 DC04     bgt     @@PoseMoreThan8                                
080284FA 2800     cmp     r0,0h                                   
080284FC D005     beq     @@Pose0                                
080284FE E00C     b       @@Otherend                                 

@@PoseMoreThan8:                              
08028504 2809     cmp     r0,9h                                   
08028506 D005     beq     @@Pose9                                
08028508 E007     b       @@Otherend

@@Pose0:                                
0802850A F7FFFD49 bl      8027FA0h                                
0802850E E006     b       @@Thend 

@@Pose8:                               
08028510 F7FFFD96 bl      8028040h 

@@Pose9:                               
08028514 F7FFFDA4 bl      8028060h                                
08028518 E001     b       @@Thend 

@@Otherend:                               
0802851A F7FFFEB3 bl      8028284h 

@@Thend:                               
0802851E 4904     ldr     r1,=3000738h                            
08028520 312F     add     r1,2Fh                                  
08028522 7808     ldrb    r0,[r1]      ;读取767                            
08028524 3001     add     r0,1h        ;加1再写入                           
08028526 7008     strb    r0,[r1] 

@@end:                                
08028528 BC10     pop     r4                                      
0802852A BC01     pop     r0                                      
0802852C 4700     bx      r0                                      


;副精灵 2A 裸虫 主程序                              
08028534 B570     push    r4-r6,r14                               
08028536 4B19     ldr     r3,=3000738h                            
08028538 1C19     mov     r1,r3                                   
0802853A 3126     add     r1,26h                                  
0802853C 2001     mov     r0,1h                                   
0802853E 7008     strb    r0,[r1]    ;75e写入1                             
08028540 1C1D     mov     r5,r3                                   
08028542 3524     add     r5,24h                                  
08028544 782C     ldrb    r4,[r5]    ;读取pose                              
08028546 2C00     cmp     r4,0h                                   
08028548 D125     bne     @@end                                
0802854A 8819     ldrh    r1,[r3]                                 
0802854C 4814     ldr     r0,=0FFFBh                              
0802854E 4008     and     r0,r1      ;取向去掉4h                              
08028550 2200     mov     r2,0h                                   
08028552 2680     mov     r6,80h                                  
08028554 0236     lsl     r6,r6,8h                                
08028556 1C31     mov     r1,r6                                   
08028558 4308     orr     r0,r1      ;orr8000h再写入                              
0802855A 8018     strh    r0,[r3]                                 
0802855C 1C19     mov     r1,r3                                   
0802855E 3127     add     r1,27h                                  
08028560 200C     mov     r0,0Ch                                  
08028562 7008     strb    r0,[r1]    ;75f写入0Ch                             
08028564 3101     add     r1,1h                                   
08028566 2028     mov     r0,28h                                  
08028568 7008     strb    r0,[r1]    ;760写入28h                              
0802856A 3101     add     r1,1h                                   
0802856C 2030     mov     r0,30h                                  
0802856E 7008     strb    r0,[r1]    ;761写入30h                             
08028570 490C     ldr     r1,=0FFFCh                              
08028572 8159     strh    r1,[r3,0Ah]                             
08028574 2004     mov     r0,4h                                   
08028576 8198     strh    r0,[r3,0Ch]                             
08028578 81D9     strh    r1,[r3,0Eh]                             
0802857A 8218     strh    r0,[r3,10h]  ;四面分界                           
0802857C 480A     ldr     r0,=82E0D00h                            
0802857E 6198     str     r0,[r3,18h]  ;写入新OAM                           
08028580 771A     strb    r2,[r3,1Ch]                             
08028582 82DC     strh    r4,[r3,16h]                             
08028584 1C18     mov     r0,r3                                   
08028586 3025     add     r0,25h                                  
08028588 7002     strb    r2,[r0]      ;属性写入0                            
0802858A 2009     mov     r0,9h                                   
0802858C 7028     strb    r0,[r5]      ;pose写入9h                           
0802858E 1C19     mov     r1,r3                                   
08028590 3133     add     r1,33h                                  
08028592 2005     mov     r0,5h                                   
08028594 7008     strb    r0,[r1]      ;75b写入5h

@@end:                                
08028596 BC70     pop     r4-r6                                   
08028598 BC01     pop     r0                                      
0802859A 4700     bx      r0                                      

//////////////////////////////////////////////////////////////////////////////////////////////////////////
;副精灵 2B 藤蒂 主程序                             
080285AC B570     push    r4-r6,r14                               
080285AE 4B1A     ldr     r3,=3000738h                            
080285B0 1C19     mov     r1,r3                                   
080285B2 3126     add     r1,26h                                  
080285B4 2001     mov     r0,1h                                   
080285B6 7008     strb    r0,[r1]     ;75e写入1                            
080285B8 1C1D     mov     r5,r3                                   
080285BA 3524     add     r5,24h                                  
080285BC 782C     ldrb    r4,[r5]     ;读取pose                            
080285BE 2C00     cmp     r4,0h                                   
080285C0 D127     bne     @@end       ;pose不为0则直接结束                                
080285C2 8819     ldrh    r1,[r3]                                 
080285C4 4815     ldr     r0,=0FFFBh                              
080285C6 4008     and     r0,r1       ;取向去掉4h                            
080285C8 2200     mov     r2,0h                                   
080285CA 2680     mov     r6,80h                                  
080285CC 0236     lsl     r6,r6,8h                                
080285CE 1C31     mov     r1,r6                                   
080285D0 4308     orr     r0,r1       ;orr8000h再写入                             
080285D2 8018     strh    r0,[r3]                                 
080285D4 1C19     mov     r1,r3                                   
080285D6 3127     add     r1,27h                                  
080285D8 200C     mov     r0,0Ch                                  
080285DA 7008     strb    r0,[r1]     ;75F写入0Ch                             
080285DC 3101     add     r1,1h                                   
080285DE 2028     mov     r0,28h                                  
080285E0 7008     strb    r0,[r1]     ;760写入28h                            
080285E2 3101     add     r1,1h                                   
080285E4 2030     mov     r0,30h                                  
080285E6 7008     strb    r0,[r1]     ;761写入30h                            
080285E8 490D     ldr     r1,=0FFFCh                              
080285EA 8159     strh    r1,[r3,0Ah]                             
080285EC 2004     mov     r0,4h                                   
080285EE 8198     strh    r0,[r3,0Ch]                             
080285F0 81D9     strh    r1,[r3,0Eh]                             
080285F2 8218     strh    r0,[r3,10h] ;四面分界                             
080285F4 480B     ldr     r0,=82E0A28h                            
080285F6 6198     str     r0,[r3,18h] ;写入OAM                            
080285F8 771A     strb    r2,[r3,1Ch]                             
080285FA 82DC     strh    r4,[r3,16h]                             
080285FC 1C18     mov     r0,r3                                   
080285FE 3025     add     r0,25h                                  
08028600 7002     strb    r2,[r0]     ;属性写入0h                             
08028602 3803     sub     r0,3h                                   
08028604 2105     mov     r1,5h                                   
08028606 7001     strb    r1,[r0]     ;75A写入5h                            
08028608 2009     mov     r0,9h                                   
0802860A 7028     strb    r0,[r5]     ;pose写入9h                            
0802860C 1C18     mov     r0,r3                                   
0802860E 3033     add     r0,33h                                  
08028610 7001     strb    r1,[r0]     ;76b写入5h

@@end:                                 
08028612 BC70     pop     r4-r6                                   
08028614 BC01     pop     r0                                      
08028616 4700     bx      r0                                      



                              
08028628 B570     push    r4-r6,r14                               
0802862A 4808     ldr     r0,=3000738h                            
0802862C 1C06     mov     r6,r0                                   
0802862E 3624     add     r6,24h                                  
08028630 7835     ldrb    r5,[r6]                                 
08028632 1C04     mov     r4,r0                                   
08028634 2D00     cmp     r5,0h                                   
08028636 D12A     bne     802868Eh                                
08028638 2003     mov     r0,3h                                   
0802863A 2121     mov     r1,21h                                  
0802863C F038F93E bl      80608BCh                                
08028640 1C03     mov     r3,r0                                   
08028642 2B00     cmp     r3,0h                                   
08028644 D004     beq     8028650h                                
08028646 8025     strh    r5,[r4]                                 
08028648 E02D     b       80286A6h                                
0802864A 0000     lsl     r0,r0,0h                                
0802864C 0738     lsl     r0,r7,1Ch                               
0802864E 0300     lsl     r0,r0,0Ch                               
08028650 8821     ldrh    r1,[r4]                                 
08028652 4A16     ldr     r2,=8004h                               
08028654 1C10     mov     r0,r2                                   
08028656 2200     mov     r2,0h                                   
08028658 4308     orr     r0,r1                                   
0802865A 8020     strh    r0,[r4]                                 
0802865C 1C21     mov     r1,r4                                   
0802865E 3125     add     r1,25h                                  
08028660 201E     mov     r0,1Eh                                  
08028662 7008     strb    r0,[r1]                                 
08028664 3102     add     r1,2h                                   
08028666 2010     mov     r0,10h                                  
08028668 7008     strb    r0,[r1]                                 
0802866A 1C20     mov     r0,r4                                   
0802866C 3028     add     r0,28h                                  
0802866E 7002     strb    r2,[r0]                                 
08028670 3001     add     r0,1h                                   
08028672 2108     mov     r1,8h                                   
08028674 7001     strb    r1,[r0]                                 
08028676 480E     ldr     r0,=0FFC0h                              
08028678 8160     strh    r0,[r4,0Ah]                             
0802867A 81A3     strh    r3,[r4,0Ch]                             
0802867C 3020     add     r0,20h                                  
0802867E 81E0     strh    r0,[r4,0Eh]                             
08028680 2020     mov     r0,20h                                  
08028682 8220     strh    r0,[r4,10h]                             
08028684 7031     strb    r1,[r6]                                 
08028686 480B     ldr     r0,=82B2750h                            
08028688 61A0     str     r0,[r4,18h]                             
0802868A 7722     strb    r2,[r4,1Ch]                             
0802868C 82E3     strh    r3,[r4,16h]                             
0802868E 8821     ldrh    r1,[r4]                                 
08028690 2080     mov     r0,80h                                  
08028692 0100     lsl     r0,r0,4h                                
08028694 4008     and     r0,r1                                   
08028696 2800     cmp     r0,0h                                   
08028698 D005     beq     80286A6h                                
0802869A 2000     mov     r0,0h                                   
0802869C 8020     strh    r0,[r4]                                 
0802869E 2001     mov     r0,1h                                   
080286A0 2121     mov     r1,21h                                  
080286A2 F038F90B bl      80608BCh                                
080286A6 BC70     pop     r4-r6                                   
080286A8 BC01     pop     r0                                      
080286AA 4700     bx      r0                                      
080286AC 8004     strh    r4,[r0]                                 
080286AE 0000     lsl     r0,r0,0h                                
080286B0 FFC0     bl      lr+0F80h                                
080286B2 0000     lsl     r0,r0,0h                                
080286B4 2750     mov     r7,50h                                  
080286B6 082B     lsr     r3,r5,20h 

;主精灵 70 蛹                              
080286B8 B530     push    r4,r5,r14                               
080286BA 4B18     ldr     r3,=3000738h                            
080286BC 1C19     mov     r1,r3                                   
080286BE 3126     add     r1,26h                                   
080286C0 2001     mov     r0,1h                                   
080286C2 7008     strb    r0,[r1]     ;300075e写入1h                            
080286C4 1C1D     mov     r5,r3                                   
080286C6 3524     add     r5,24h                                  
080286C8 782C     ldrb    r4,[r5]     ;读取pose                            
080286CA 2C00     cmp     r4,0h                                   
080286CC D118     bne     @@PoseNo0                                
080286CE 3101     add     r1,1h                                   
080286D0 2030     mov     r0,30h                                  
080286D2 7008     strb    r0,[r1]     ;75F写入30                              
080286D4 3101     add     r1,1h                                   
080286D6 2010     mov     r0,10h                                  
080286D8 7008     strb    r0,[r1]     ;760写入10                             
080286DA 3101     add     r1,1h                                   
080286DC 2020     mov     r0,20h                                  
080286DE 7008     strb    r0,[r1]     ;761写入20h                             
080286E0 2200     mov     r2,0h                                   
080286E2 490F     ldr     r1,=0FFFCh                              
080286E4 8159     strh    r1,[r3,0Ah]                             
080286E6 2004     mov     r0,4h                                   
080286E8 8198     strh    r0,[r3,0Ch]                             
080286EA 81D9     strh    r1,[r3,0Eh]                             
080286EC 8218     strh    r0,[r3,10h]                             
080286EE 480D     ldr     r0,=82E0D00h                            
080286F0 6198     str     r0,[r3,18h] ;OAM写入                            
080286F2 771A     strb    r2,[r3,1Ch]                             
080286F4 82DC     strh    r4,[r3,16h]                             
080286F6 1C18     mov     r0,r3                                   
080286F8 3025     add     r0,25h                                  
080286FA 7002     strb    r2,[r0]    ;属性写入0                               
080286FC 2009     mov     r0,9h                                   
080286FE 7028     strb    r0,[r5]    ;pose写入9h

@@PoseNo0:                                
08028700 7F18     ldrb    r0,[r3,1Ch]                             
08028702 2801     cmp     r0,1h                                   
08028704 D107     bne     8028716h                                
08028706 8AD9     ldrh    r1,[r3,16h]                             
08028708 2900     cmp     r1,0h                                   
0802870A D001     beq     8028710h                                
0802870C 2904     cmp     r1,4h                                   
0802870E D102     bne     8028716h                                
08028710 4805     ldr     r0,=212h                                
08028712 F7DAF981 bl      8002A18h                                
08028716 BC30     pop     r4,r5                                   
08028718 BC01     pop     r0                                      
0802871A 4700     bx      r0                                      

                       
0802872C B570     push    r4-r6,r14                               
0802872E 4B20     ldr     r3,=3000738h                            
08028730 1C18     mov     r0,r3                                   
08028732 3026     add     r0,26h                                  
08028734 2500     mov     r5,0h                                   
08028736 2601     mov     r6,1h                                   
08028738 7006     strb    r6,[r0]                                 
0802873A 1C1C     mov     r4,r3                                   
0802873C 3424     add     r4,24h                                  
0802873E 7820     ldrb    r0,[r4]                                 
08028740 2800     cmp     r0,0h                                   
08028742 D124     bne     802878Eh                                
08028744 8858     ldrh    r0,[r3,2h]                              
08028746 3808     sub     r0,8h                                   
08028748 2200     mov     r2,0h                                   
0802874A 8058     strh    r0,[r3,2h]                              
0802874C 2032     mov     r0,32h                                  
0802874E 18C0     add     r0,r0,r3                                
08028750 4684     mov     r12,r0                                  
08028752 7800     ldrb    r0,[r0]                                 
08028754 2101     mov     r1,1h                                   
08028756 4308     orr     r0,r1                                   
08028758 4661     mov     r1,r12                                  
0802875A 7008     strb    r0,[r1]                                 
0802875C 1C18     mov     r0,r3                                   
0802875E 3025     add     r0,25h                                  
08028760 7002     strb    r2,[r0]                                 
08028762 2009     mov     r0,9h                                   
08028764 7020     strb    r0,[r4]                                 
08028766 1C18     mov     r0,r3                                   
08028768 3027     add     r0,27h                                  
0802876A 7006     strb    r6,[r0]                                 
0802876C 1C19     mov     r1,r3                                   
0802876E 3128     add     r1,28h                                  
08028770 2008     mov     r0,8h                                   
08028772 7008     strb    r0,[r1]                                 
08028774 3101     add     r1,1h                                   
08028776 2010     mov     r0,10h                                  
08028778 7008     strb    r0,[r1]                                 
0802877A 490E     ldr     r1,=0FFFCh                              
0802877C 8159     strh    r1,[r3,0Ah]                             
0802877E 2004     mov     r0,4h                                   
08028780 8198     strh    r0,[r3,0Ch]                             
08028782 81D9     strh    r1,[r3,0Eh]                             
08028784 8218     strh    r0,[r3,10h]                             
08028786 480C     ldr     r0,=82E0FE8h                            
08028788 6198     str     r0,[r3,18h]                             
0802878A 771A     strb    r2,[r3,1Ch]                             
0802878C 82DD     strh    r5,[r3,16h]                             
0802878E 490B     ldr     r1,=30013D4h                            
08028790 7808     ldrb    r0,[r1]                                 
08028792 281D     cmp     r0,1Dh                                  
08028794 D116     bne     80287C4h                                
08028796 8A88     ldrh    r0,[r1,14h]                             
08028798 8058     strh    r0,[r3,2h]                              
0802879A 8A48     ldrh    r0,[r1,12h]                             
0802879C 8098     strh    r0,[r3,4h]                              
0802879E 6999     ldr     r1,[r3,18h]                             
080287A0 4805     ldr     r0,=82E0FE8h                            
080287A2 4281     cmp     r1,r0                                   
080287A4 D116     bne     80287D4h                                
080287A6 4806     ldr     r0,=82E0FC0h                            
080287A8 6198     str     r0,[r3,18h]                             
080287AA 2000     mov     r0,0h                                   
080287AC 7718     strb    r0,[r3,1Ch]                             
080287AE E010     b       80287D2h                                
080287B0 0738     lsl     r0,r7,1Ch                               
080287B2 0300     lsl     r0,r0,0Ch                               
080287B4 FFFC     bl      lr+0FF8h                                
080287B6 0000     lsl     r0,r0,0h                                
080287B8 0FE8     lsr     r0,r5,1Fh                               
080287BA 082E     lsr     r6,r5,20h                               
080287BC 13D4     asr     r4,r2,0Fh                               
080287BE 0300     lsl     r0,r0,0Ch                               
080287C0 0FC0     lsr     r0,r0,1Fh                               
080287C2 082E     lsr     r6,r5,20h                               
080287C4 6999     ldr     r1,[r3,18h]                             
080287C6 4805     ldr     r0,=82E0FC0h                            
080287C8 4281     cmp     r1,r0                                   
080287CA D103     bne     80287D4h                                
080287CC 4804     ldr     r0,=82E0FE8h                            
080287CE 6198     str     r0,[r3,18h]                             
080287D0 771D     strb    r5,[r3,1Ch]                             
080287D2 82DD     strh    r5,[r3,16h]                             
080287D4 BC70     pop     r4-r6                                   
080287D6 BC01     pop     r0                                      
080287D8 4700     bx      r0                                      
080287DA 0000     lsl     r0,r0,0h                                
080287DC 0FC0     lsr     r0,r0,1Fh                               
080287DE 082E     lsr     r6,r5,20h                               
080287E0 0FE8     lsr     r0,r5,1Fh                               
080287E2 082E     lsr     r6,r5,20h                               
080287E4 B500     push    r14                                     
080287E6 2003     mov     r0,3h                                   
080287E8 214A     mov     r1,4Ah                                  
080287EA F038F867 bl      80608BCh                                
080287EE 1C01     mov     r1,r0                                   
080287F0 2900     cmp     r1,0h                                   
080287F2 D007     beq     8028804h                                
080287F4 4902     ldr     r1,=30001A8h                            
080287F6 22F0     mov     r2,0F0h                                 
080287F8 0052     lsl     r2,r2,1h                                
080287FA 1C10     mov     r0,r2                                   
080287FC 8008     strh    r0,[r1]                                 
080287FE E010     b       8028822h                                
08028800 01A8     lsl     r0,r5,6h                                
08028802 0300     lsl     r0,r0,0Ch                               
08028804 4808     ldr     r0,=30001A8h                            
08028806 8001     strh    r1,[r0]                                 
08028808 4908     ldr     r1,=300004Dh                            
0802880A 2201     mov     r2,1h                                   
0802880C 4252     neg     r2,r2                                   
0802880E 1C10     mov     r0,r2                                   
08028810 7008     strb    r0,[r1]                                 
08028812 2003     mov     r0,3h                                   
08028814 2143     mov     r1,43h                                  
08028816 F038F851 bl      80608BCh                                
0802881A 2800     cmp     r0,0h                                   
0802881C D101     bne     8028822h                                
0802881E F7DBF887 bl      8003930h                                
08028822 BC01     pop     r0                                      
08028824 4700     bx      r0                                      
08028826 0000     lsl     r0,r0,0h                                
08028828 01A8     lsl     r0,r5,6h                                
0802882A 0300     lsl     r0,r0,0Ch                               
0802882C 004D     lsl     r5,r1,1h                                
0802882E 0300     lsl     r0,r0,0Ch                               
08028830 B500     push    r14                                     
08028832 4906     ldr     r1,=30001A8h                            
08028834 8808     ldrh    r0,[r1]                                 
08028836 2800     cmp     r0,0h                                   
08028838 D017     beq     802886Ah                                
0802883A 3801     sub     r0,1h                                   
0802883C 8008     strh    r0,[r1]                                 
0802883E 0400     lsl     r0,r0,10h                               
08028840 2800     cmp     r0,0h                                   
08028842 D105     bne     8028850h                                
08028844 F7FFFFCE bl      80287E4h                                
08028848 E00F     b       802886Ah                                
0802884A 0000     lsl     r0,r0,0h                                
0802884C 01A8     lsl     r0,r5,6h                                
0802884E 0300     lsl     r0,r0,0Ch                               
08028850 4807     ldr     r0,=300004Dh                            
08028852 2100     mov     r1,0h                                   

