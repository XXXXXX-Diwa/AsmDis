


;r0=1h r1为垂直坐标 r2为水平坐标 r3=1h  SP=20h
08011084 B5F0     push    r4-r7,r14                               
08011086 4647     mov     r7,r8                                   
08011088 B480     push    r7                                      
0801108A B083     add     sp,-0Ch                                 
0801108C 9C09     ldr     r4,[sp,24h]                             
0801108E 0600     lsl     r0,r0,18h                               
08011090 0E00     lsr     r0,r0,18h                               
08011092 4680     mov     r8,r0        ;1h                         
08011094 0409     lsl     r1,r1,10h                               
08011096 0C0D     lsr     r5,r1,10h    ;垂直坐标                           
08011098 0412     lsl     r2,r2,10h                               
0801109A 0C16     lsr     r6,r2,10h    ;水平坐标                           
0801109C 061B     lsl     r3,r3,18h                               
0801109E 0E1F     lsr     r7,r3,18h    ;1h                           
080110A0 0624     lsl     r4,r4,18h                               
080110A2 0E22     lsr     r2,r4,18h    ;20h? 鱼21                          
080110A4 4804     ldr     r0,=3000738h                            
080110A6 3024     add     r0,24h                                  
080110A8 7800     ldrb    r0,[r0]                                 
080110AA 2864     cmp     r0,64h                                  
080110AC D01C     beq     @@pose64h    ;pose是64h跳转                           
080110AE 2864     cmp     r0,64h                                  
080110B0 DC04     bgt     @@than64h    ;pose大于64h                                
080110B2 2863     cmp     r0,63h                                  
080110B4 D007     beq     @@pose63h    ;pose是63h                            
080110B6 E049     b       @@otherpose                                

@@than64h:                             
080110BC 2865     cmp     r0,65h                                  
080110BE D025     beq     @@pose65h                                
080110C0 2866     cmp     r0,66h                                  
080110C2 D033     beq     @@pose66h                                
080110C4 E042     b       @@otherpose 

@@pose63h:                               
080110C6 1C28     mov     r0,r5                                   
080110C8 1C31     mov     r1,r6                                   
080110CA 2224     mov     r2,24h                                  
080110CC F043F80E bl      80540ECh                                
080110D0 2000     mov     r0,0h                                   
080110D2 2103     mov     r1,3h                                   
080110D4 1C2A     mov     r2,r5                                   
080110D6 1C33     mov     r3,r6                                   
080110D8 F7FFFE46 bl      8010D68h                                
080110DC 4801     ldr     r0,=131h    ;爆炸声                            
080110DE F7F1FC9B bl      8002A18h                                
080110E2 E079     b       @@samegoto                                

@@pose64h:                               
080110E8 1C28     mov     r0,r5                                   
080110EA 1C31     mov     r1,r6                                   
080110EC 2226     mov     r2,26h                                  
080110EE F042FFFD bl      80540ECh                                
080110F2 2000     mov     r0,0h                                   
080110F4 2103     mov     r1,3h                                   
080110F6 1C2A     mov     r2,r5                                   
080110F8 1C33     mov     r3,r6                                   
080110FA F7FFFE35 bl      8010D68h                                
080110FE 4802     ldr     r0,=133h    ;爆炸声                            
08011100 F7F1FC8A bl      8002A18h                                
08011104 E068     b       @@samegoto                                

@@pose65h:                               
0801110C 1C28     mov     r0,r5                                   
0801110E 1C31     mov     r1,r6                                   
08011110 2223     mov     r2,23h                                  
08011112 F042FFEB bl      80540ECh                                
08011116 2000     mov     r0,0h                                   
08011118 2103     mov     r1,3h                                   
0801111A 1C2A     mov     r2,r5                                   
0801111C 1C33     mov     r3,r6                                   
0801111E F7FFFE23 bl      8010D68h                               
08011122 2098     mov     r0,98h    ;旋转攻击爆炸声?                              
08011124 0040     lsl     r0,r0,1h                                
08011126 F7F1FC77 bl      8002A18h                                
0801112A E055     b       @@samegoto 

@@pose66h:                               
0801112C 1C28     mov     r0,r5                                   
0801112E 1C31     mov     r1,r6                                   
08011130 2225     mov     r2,25h                                  
08011132 F042FFDB bl      80540ECh                                
08011136 2000     mov     r0,0h                                   
08011138 2103     mov     r1,3h                                   
0801113A 1C2A     mov     r2,r5                                   
0801113C 1C33     mov     r3,r6                                   
0801113E F7FFFE13 bl      8010D68h                                
08011142 2099     mov     r0,99h                                  
08011144 0040     lsl     r0,r0,1h                                
08011146 F7F1FC67 bl      8002A18h   ;爆炸声                             
0801114A E045     b       @@samegoto  

@@otherpose:                              
0801114C 2A1F     cmp     r2,1Fh                                  
0801114E D10B     bne     @@spno1Fh                                
08011150 1C28     mov     r0,r5                                   
08011152 1C31     mov     r1,r6                                   
08011154 221F     mov     r2,1Fh                                  
08011156 F042FFC9 bl      80540ECh                                
0801115A 2F00     cmp     r7,0h                                   
0801115C D03C     beq     @@samegoto                                
0801115E 2096     mov     r0,96h                                  
08011160 0040     lsl     r0,r0,1h                                
08011162 F7F1FC59 bl      8002A18h                                
08011166 E037     b       @@spno20h 

@@spno1Fh:                              
08011168 2A20     cmp     r2,20h                                  
0801116A D10D     bne     8011188h                                
0801116C 1C28     mov     r0,r5                                   
0801116E 1C31     mov     r1,r6                                   
08011170 2220     mov     r2,20h                                  
08011172 F042FFBB bl      80540ECh                                
08011176 2F00     cmp     r7,0h                                   
08011178 D02E     beq     @@samegoto                                
0801117A 4802     ldr     r0,=12Dh                                
0801117C F7F1FC4C bl      8002A18h                                
08011180 E02A     b       @@samegoto                                

@@spno20h:                              
08011188 2A21     cmp     r2,21h                                  
0801118A D10B     bne     @@spno21h                                
0801118C 1C28     mov     r0,r5                                   
0801118E 1C31     mov     r1,r6                                   
08011190 2221     mov     r2,21h                                  
08011192 F042FFAB bl      80540ECh                                
08011196 2F00     cmp     r7,0h     ;判断是否在屏幕外?                              
08011198 D01E     beq     @@samegoto                                
0801119A 2097     mov     r0,97h                                  
0801119C 0040     lsl     r0,r0,1h                                
0801119E F7F1FC3B bl      8002A18h                                
080111A2 E019     b       @@samegoto  

@@spno21h:                              
080111A4 2A22     cmp     r2,22h                                  
080111A6 D10D     bne     @@spno22h                               
080111A8 1C28     mov     r0,r5                                   
080111AA 1C31     mov     r1,r6                                   
080111AC 2222     mov     r2,22h                                  
080111AE F042FF9D bl      80540ECh                                
080111B2 2F00     cmp     r7,0h                                   
080111B4 D010     beq     @@samegoto                                
080111B6 4802     ldr     r0,=12Fh                                
080111B8 F7F1FC2E bl      8002A18h                                
080111BC E00C     b       @@samegoto                                

@@spno22h:                               
080111C4 1C10     mov     r0,r2                                   
080111C6 3827     sub     r0,27h                                  
080111C8 0600     lsl     r0,r0,18h                               
080111CA 0E00     lsr     r0,r0,18h                               
080111CC 2802     cmp     r0,2h                                   
080111CE D803     bhi     @@samegoto                                
080111D0 1C28     mov     r0,r5                                   
080111D2 1C31     mov     r1,r6                                   
080111D4 F042FF8A bl      80540ECh

@@samegoto:                                
080111D8 F7FFFE88 bl      8010EECh                                
080111DC 0600     lsl     r0,r0,18h                               
080111DE 0E02     lsr     r2,r0,18h                               
080111E0 1C13     mov     r3,r2                                   
080111E2 2A00     cmp     r2,0h                                   
080111E4 D03E     beq     @@nodrop                                
080111E6 4640     mov     r0,r8                                   
080111E8 2800     cmp     r0,0h                                   
080111EA D011     beq     @@pass                                
080111EC 2802     cmp     r0,2h                                   
080111EE D03E     beq     @@end                                
080111F0 4806     ldr     r0,=3000738h                            
080111F2 7F81     ldrb    r1,[r0,1Eh]  ;读取3000756的值                           
080111F4 3023     add     r0,23h                                  
080111F6 7803     ldrb    r3,[r0]      ;主精灵序号                           
080111F8 9500     str     r5,[sp]      ;Y坐标                           
080111FA 9601     str     r6,[sp,4h]   ;X坐标                           
080111FC 2000     mov     r0,0h                                   
080111FE 9002     str     r0,[sp,8h]                              
08011200 1C10     mov     r0,r2                                   
08011202 2200     mov     r2,0h                                   
08011204 F7FDF8E6 bl      800E3D4h                                
08011208 E031     b       @@end                                

@@pass:                                 
08011210 4A13     ldr     r2,=3000738h                            
08011212 2100     mov     r1,0h                                   
08011214 2007     mov     r0,7h                                   
08011216 8010     strh    r0,[r2] ;取向写入7h                                
08011218 1C10     mov     r0,r2                                   
0801121A 3032     add     r0,32h                                  
0801121C 7001     strb    r1,[r0] ;碰撞属性写入0                                
0801121E 77D1     strb    r1,[r2,1Fh] ;gfx row写入0                            
08011220 7753     strb    r3,[r2,1Dh] ;3000756写入掉落ID                       
08011222 8055     strh    r5,[r2,2h]  ;死时Y坐标                            
08011224 8096     strh    r6,[r2,4h]  ;死时X坐标                            
08011226 1C13     mov     r3,r2                                   
08011228 3321     add     r3,21h                                  
0801122A 2002     mov     r0,2h                                   
0801122C 7018     strb    r0,[r3]     ;3000759写入2h                            
0801122E 3301     add     r3,1h                                   
08011230 2004     mov     r0,4h                                   
08011232 7018     strb    r0,[r3]     ;300075a写入4h                            
08011234 1C10     mov     r0,r2                                   
08011236 3024     add     r0,24h                                  
08011238 7001     strb    r1,[r0]     ;pose写入0h                             
0801123A 4640     mov     r0,r8                                   
0801123C 8290     strh    r0,[r2,14h] ;血量写入0                            
0801123E 1C10     mov     r0,r2                                   
08011240 302B     add     r0,2Bh                                  
08011242 7001     strb    r1,[r0]     ;无敌数写入0                             
08011244 380B     sub     r0,0Bh                                   
08011246 7001     strb    r1,[r0]     ;调色板写入0                            
08011248 3013     add     r0,13h                                  
0801124A 7001     strb    r1,[r0]     ;300076b写入0                            
0801124C 3001     add     r0,1h                                   
0801124E 7001     strb    r1,[r0]     ;300076c写入0                            
08011250 3304     add     r3,4h                                   
08011252 2001     mov     r0,1h                                   
08011254 7018     strb    r0,[r3]     ;300075e写入1                            
08011256 1C10     mov     r0,r2                                   
08011258 3030     add     r0,30h                                  
0801125A 7001     strb    r1,[r0]     ;冰冻时写入0                            
0801125C E007     b       @@end                                

@@nodrop:                             
08011264 4641     mov     r1,r8                                   
08011266 2900     cmp     r1,0h                                   
08011268 D101     bne     @@end                                
0801126A 4804     ldr     r0,=3000738h                            
0801126C 8001     strh    r1,[r0] 

@@end:                                
0801126E B003     add     sp,0Ch                                  
08011270 BC08     pop     r3                                      
08011272 4698     mov     r8,r3                                   
08011274 BCF0     pop     r4-r7                                   
08011276 BC01     pop     r0                                      
08011278 4700     bx      r0                                      
///////////////////////////////////////////////////////////////////////////////////////////////////////////

080540EC B5F0     push    r4-r7,r14    ;设置图片效果                           
080540EE 4647     mov     r7,r8                                   
080540F0 B480     push    r7                                      
080540F2 0400     lsl     r0,r0,10h                               
080540F4 0C00     lsr     r0,r0,10h                               
080540F6 4684     mov     r12,r0       ;垂直坐标                           
080540F8 0409     lsl     r1,r1,10h                               
080540FA 0C0F     lsr     r7,r1,10h    ;水平坐标                           
080540FC 0612     lsl     r2,r2,18h                               
080540FE 0E12     lsr     r2,r2,18h                               
08054100 4690     mov     r8,r2                                   
08054102 2200     mov     r2,0h                                   
08054104 4B1F     ldr     r3,=3000840h                            
08054106 1C18     mov     r0,r3                                   
08054108 30C0     add     r0,0C0h                                 
0805410A 1C19     mov     r1,r3                                   
0805410C 4283     cmp     r3,r0                                   
0805410E D20A     bcs     @@than900h                                
08054110 7818     ldrb    r0,[r3]                                 
08054112 2800     cmp     r0,0h                                   
08054114 D023     beq     @@statuszero 

@@statusnozero:                               
08054116 330C     add     r3,0Ch                                  
08054118 481B     ldr     r0,=3000900h                            
0805411A 4283     cmp     r3,r0                                   
0805411C D203     bcs     @@than900h                                
0805411E 7818     ldrb    r0,[r3]                                 
08054120 2800     cmp     r0,0h                                   
08054122 D1F8     bne     @@statusnozero                                
08054124 2201     mov     r2,1h     

@@than900h:                              
08054126 2A00     cmp     r2,0h                                   
08054128 D119     bne     @@statuszero                                
0805412A 2400     mov     r4,0h                                   
0805412C 1C0B     mov     r3,r1                                   
0805412E 1C1D     mov     r5,r3                                   
08054130 1C18     mov     r0,r3                                   
08054132 30C0     add     r0,0C0h                                 
08054134 4283     cmp     r3,r0                                   
08054136 D20F     bcs     @@than900h2                                
08054138 1C06     mov     r6,r0      

                             
0805413A 7898     ldrb    r0,[r3,2h]                              
0805413C 2100     mov     r1,0h                                   
0805413E 283A     cmp     r0,3Ah                                  
08054140 D800     bhi     8054144h                                
08054142 7919     ldrb    r1,[r3,4h]

                              
08054144 428A     cmp     r2,r1                                   
08054146 D204     bcs     8054152h                                
08054148 1C0A     mov     r2,r1                                   
0805414A 1C1D     mov     r5,r3                                   
0805414C 1C60     add     r0,r4,1                                 
0805414E 0600     lsl     r0,r0,18h                               
08054150 0E04     lsr     r4,r0,18h

                               
08054152 330C     add     r3,0Ch                                  
08054154 42B3     cmp     r3,r6                                   
08054156 D3F0     bcc     805413Ah  

@@than900h2:                              
08054158 2C00     cmp     r4,0h                                   
0805415A D00D     beq     @@end:                                
0805415C 1C2B     mov     r3,r5   

@@statuszero:                                
0805415E 2000     mov     r0,0h                                   
08054160 2101     mov     r1,1h                                   
08054162 7019     strb    r1,[r3]                                 
08054164 2100     mov     r1,0h                                   
08054166 4662     mov     r2,r12                                  
08054168 811A     strh    r2,[r3,8h]                              
0805416A 815F     strh    r7,[r3,0Ah]                             
0805416C 80D8     strh    r0,[r3,6h]                              
0805416E 7059     strb    r1,[r3,1h]                              
08054170 4640     mov     r0,r8                                   
08054172 7098     strb    r0,[r3,2h]                              
08054174 70D9     strb    r1,[r3,3h]                              
08054176 7119     strb    r1,[r3,4h]  

@@end:                            
08054178 BC08     pop     r3                                      
0805417A 4698     mov     r8,r3                                   
0805417C BCF0     pop     r4-r7                                   
0805417E BC01     pop     r0                                      
08054180 4700     bx      r0                                      
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

08010EEC B5F0     push    r4-r7,r14                               
08010EEE 464F     mov     r7,r9                                   
08010EF0 4646     mov     r6,r8                                   
08010EF2 B4C0     push    r6,r7                                   
08010EF4 2700     mov     r7,0h                                   
08010EF6 2000     mov     r0,0h                                   
08010EF8 4681     mov     r9,r0                                   
08010EFA 4810     ldr     r0,=3001530h                            
08010EFC 88C1     ldrh    r1,[r0,6h]     ;当前血量                         
08010EFE 4680     mov     r8,r0                                   
08010F00 8802     ldrh    r2,[r0]        ;最大血量                         
08010F02 4291     cmp     r1,r2                                   
08010F04 D101     bne     @@energyless   ;不等跳转                         
08010F06 2001     mov     r0,1h                                   
08010F08 4681     mov     r9,r0          ;血量满 r9为1

@@energyless:                                
08010F0A 480D     ldr     r0,=300083Ch                            
08010F0C 7804     ldrb    r4,[r0]                                 
08010F0E 0224     lsl     r4,r4,8h    ;随机数的256倍,移动一字节                             
08010F10 490C     ldr     r1,=3000C77h                            
08010F12 480D     ldr     r0,=3000002h                            
08010F14 8800     ldrh    r0,[r0]     ;1字节的帧计数                            
08010F16 7809     ldrb    r1,[r1]     ;同上                            
08010F18 1840     add     r0,r0,r1                                
08010F1A 1820     add     r0,r4,r0    ;两个帧计数之和加随机数256倍                            
08010F1C 0580     lsl     r0,r0,16h                               
08010F1E 0D84     lsr     r4,r0,16h                               
08010F20 2C00     cmp     r4,0h                                   
08010F22 D100     bne     @@nozero                                
08010F24 2401     mov     r4,1h  

@@nozero:                                 
08010F26 4809     ldr     r0,=3000738h                            
08010F28 7F43     ldrb    r3,[r0,1Dh]  ;得到精灵ID                           
08010F2A 3032     add     r0,32h                                  
08010F2C 7801     ldrb    r1,[r0]      ;碰撞属性                           
08010F2E 2080     mov     r0,80h                                  
08010F30 4008     and     r0,r1                                   
08010F32 2800     cmp     r0,0h                                   
08010F34 D00E     beq     @@firstkindsprite                                
08010F36 4A06     ldr     r2,=82B1BE4h                            
08010F38 E00D     b       @@secondkindsprite                                   

@@firstkindsprite:                           
08010F54 4A19     ldr     r2,=82B0D68h 
@@secondkindsprite:                           
08010F56 00D9     lsl     r1,r3,3h                                
08010F58 18C9     add     r1,r1,r3                                
08010F5A 0049     lsl     r1,r1,1h     ;18倍                           
08010F5C 1C10     mov     r0,r2                                   
08010F5E 3008     add     r0,8h                                   
08010F60 1808     add     r0,r1,r0                                
08010F62 8800     ldrh    r0,[r0]                                 
08010F64 4684     mov     r12,r0       ;small energy drop                           
08010F66 1C10     mov     r0,r2                                   
08010F68 300A     add     r0,0Ah                                  
08010F6A 1808     add     r0,r1,r0                                
08010F6C 8806     ldrh    r6,[r0]      ;large energy drop                          
08010F6E 1C10     mov     r0,r2                                   
08010F70 300C     add     r0,0Ch                                  
08010F72 1808     add     r0,r1,r0                                
08010F74 8805     ldrh    r5,[r0]      ;missile drop                            
08010F76 1C10     mov     r0,r2                                   
08010F78 300E     add     r0,0Eh                                  
08010F7A 1808     add     r0,r1,r0                                
08010F7C 8803     ldrh    r3,[r0]      ;super missile drop                          
08010F7E 1C10     mov     r0,r2                                   
08010F80 3010     add     r0,10h                                  
08010F82 1809     add     r1,r1,r0                                
08010F84 880A     ldrh    r2,[r1]      ;power bome drop                          
08010F86 2A00     cmp     r2,0h                                   
08010F88 D01A     beq     @@PBDzero                                
08010F8A 2080     mov     r0,80h                                  
08010F8C 00C0     lsl     r0,r0,3h                                
08010F8E 1C01     mov     r1,r0        ;400h                           
08010F90 1A88     sub     r0,r1,r2     ;总值减去超炸掉落率                          
08010F92 0400     lsl     r0,r0,10h                               
08010F94 0C02     lsr     r2,r0,10h    ;给r2                           
08010F96 0409     lsl     r1,r1,10h                               
08010F98 0C09     lsr     r1,r1,10h                               
08010F9A 428C     cmp     r4,r1        ;随机数和400h相比                           
08010F9C D812     bhi     @@RNGthan400hornothanr2                                
08010F9E 4294     cmp     r4,r2                                   
08010FA0 D910     bls     @@RNGthan400hornothanr2                                
08010FA2 4641     mov     r1,r8                                   
08010FA4 7948     ldrb    r0,[r1,5h]     ;最大超炸数                         
08010FA6 7ACA     ldrb    r2,[r1,0Bh]    ;当前超炸数                         
08010FA8 4290     cmp     r0,r2                                   
08010FAA D805     bhi     @@PBless       ;如果不满则跳转                        
08010FAC 4649     mov     r1,r9                                   
08010FAE 2900     cmp     r1,0h                                   
08010FB0 D034     beq     @@PBALLorEnergyless                                
08010FB2 271B     mov     r7,1Bh                                  
08010FB4 2800     cmp     r0,0h                                   
08010FB6 D05D     beq     @@end  

@@PBless:                              
08010FB8 271E     mov     r7,1Eh                                  
08010FBA E05B     b       @@end                                

@@PBDzero:                              
08010FC0 2280     mov     r2,80h                                  
08010FC2 00D2     lsl     r2,r2,3h  

@@RNGthan400hornothanr2:                              
08010FC4 2B00     cmp     r3,0h                                   
08010FC6 D013     beq     @@SPDzero                                
08010FC8 1AD0     sub     r0,r2,r3    ;总掉落率减去超炸掉落率再减超导掉落率                            
08010FCA 0400     lsl     r0,r0,10h                               
08010FCC 0C03     lsr     r3,r0,10h   ;给r3                            
08010FCE 42A2     cmp     r2,r4       ;减去超炸掉落率的总掉落率和随机数相比                            
08010FD0 D30F     bcc     @@RNGthan400-PBDdropornothanr3                                
08010FD2 429C     cmp     r4,r3                                   
08010FD4 D90D     bls     @@RNGthan400-PBDdropornothanr3                               
08010FD6 4642     mov     r2,r8                                   
08010FD8 7910     ldrb    r0,[r2,4h]    ;最大超导数                          
08010FDA 7A91     ldrb    r1,[r2,0Ah]   ;当前超导数                          
08010FDC 4288     cmp     r0,r1                                   
08010FDE D805     bhi     @@SMless                                
08010FE0 464A     mov     r2,r9                                   
08010FE2 2A00     cmp     r2,0h                                   
08010FE4 D01A     beq     801101Ch                                
08010FE6 271B     mov     r7,1Bh                                  
08010FE8 2800     cmp     r0,0h                                   
08010FEA D043     beq     @@end 

@@SMless:                               
08010FEC 271D     mov     r7,1Dh                                  
08010FEE E041     b       @@end

@@SPDzero:                                
08010FF0 1C13     mov     r3,r2  

@@RNGthan400-PBDdropornothanr3:                                 
08010FF2 2D00     cmp     r5,0h                                   
08010FF4 D014     beq     8011020h                                
08010FF6 1B58     sub     r0,r3,r5                                
08010FF8 0400     lsl     r0,r0,10h                               
08010FFA 0C05     lsr     r5,r0,10h                               
08010FFC 42A3     cmp     r3,r4                                   
08010FFE D310     bcc     8011022h                                
08011000 42AC     cmp     r4,r5                                   
08011002 D90E     bls     8011022h                                
08011004 4641     mov     r1,r8                                   
08011006 8848     ldrh    r0,[r1,2h]                              
08011008 890A     ldrh    r2,[r1,8h]                              
0801100A 4290     cmp     r0,r2                                   
0801100C D831     bhi     8011072h                                
0801100E 4649     mov     r1,r9                                   
08011010 2900     cmp     r1,0h                                   
08011012 D003     beq     801101Ch                                
08011014 271B     mov     r7,1Bh                                  
08011016 2800     cmp     r0,0h                                   
08011018 D02C     beq     @@end                                
0801101A E02A     b       8011072h  

@@PBALLorEnergyless:                              
0801101C 271A     mov     r7,1Ah                                  
0801101E E029     b       @@end                                
08011020 1C1D     mov     r5,r3                                   
08011022 2E00     cmp     r6,0h                                   
08011024 D010     beq     8011048h                                
08011026 1BA8     sub     r0,r5,r6                                
08011028 0400     lsl     r0,r0,10h                               
0801102A 0C06     lsr     r6,r0,10h                               
0801102C 42A5     cmp     r5,r4                                   
0801102E D30C     bcc     801104Ah                                
08011030 42B4     cmp     r4,r6                                   
08011032 D90A     bls     801104Ah                                
08011034 271A     mov     r7,1Ah                                  
08011036 464A     mov     r2,r9                                   
08011038 2A00     cmp     r2,0h                                   
0801103A D01B     beq     @@end                                
0801103C 4641     mov     r1,r8                                   
0801103E 8848     ldrh    r0,[r1,2h]                              
08011040 890A     ldrh    r2,[r1,8h]                              
08011042 4290     cmp     r0,r2                                   
08011044 D916     bls     @@end                                
08011046 E014     b       8011072h                                
08011048 1C2E     mov     r6,r5                                   
0801104A 4660     mov     r0,r12                                  
0801104C 2800     cmp     r0,0h                                   
0801104E D011     beq     @@end                                
08011050 1A30     sub     r0,r6,r0                                
08011052 0400     lsl     r0,r0,10h                               
08011054 0C00     lsr     r0,r0,10h                               
08011056 4684     mov     r12,r0                                  
08011058 42A6     cmp     r6,r4                                   
0801105A D30B     bcc     @@end                                
0801105C 4564     cmp     r4,r12                                  
0801105E D909     bls     @@end                                
08011060 271B     mov     r7,1Bh                                  
08011062 4649     mov     r1,r9                                   
08011064 2900     cmp     r1,0h                                   
08011066 D005     beq     @@end                                
08011068 4642     mov     r2,r8                                   
0801106A 8850     ldrh    r0,[r2,2h]                              
0801106C 8911     ldrh    r1,[r2,8h]                              
0801106E 4288     cmp     r0,r1                                   
08011070 D900     bls     @@end                                
08011072 271C     mov     r7,1Ch 

@@end0:                                 
08011074 1C38     mov     r0,r7                                   
08011076 BC18     pop     r3,r4                                   
08011078 4698     mov     r8,r3                                   
0801107A 46A1     mov     r9,r4                                   
0801107C BCF0     pop     r4-r7                                   
0801107E BC02     pop     r1                                      
08011080 4708     bx      r1                                      
