
.definelabel CheckBlock,0x800F720
.definelabel allset,0x8037d7c
.definelabel allset2,0x8037e40
.definelabel PlaySound,0x8002A18
.definelabel CheckEndSpriteAnimation,0x800FBC8
.definelabel posetable,0x80381f0

;pose 00h
08037CBC B5F0     push    r4-r7,r14                               
08037CBE 4C10     ldr     r4,=3000738h                            
08037CC0 8865     ldrh    r5,[r4,2h]    ;垂直坐标                          
08037CC2 88A6     ldrh    r6,[r4,4h]    ;水平坐标                          
08037CC4 7F60     ldrb    r0,[r4,1Dh]   ;读取ID                          
08037CC6 2898     cmp     r0,98h                                  
08037CC8 D001     beq     @@verticalaser                                
08037CCA 289A     cmp     r0,9Ah                                  
08037CCC D16E     bne     @@transverselaser

@@verticalaser:                              
08037CCE 8821     ldrh    r1,[r4]                                 
08037CD0 2280     mov     r2,80h                                  
08037CD2 00D2     lsl     r2,r2,3h                                
08037CD4 1C10     mov     r0,r2                                   
08037CD6 2700     mov     r7,0h                                   
08037CD8 4308     orr     r0,r1                                   
08037CDA 8020     strh    r0,[r4]    ;取向 orr 400h 再写入                               
08037CDC 1C28     mov     r0,r5                                   
08037CDE 38A0     sub     r0,0A0h    ;垂直坐标向上提升2格半的高度  64+64+32                           
08037CE0 1C31     mov     r1,r6                                   
08037CE2 F7D7FD1D bl      CheckBlock                                
08037CE6 2800     cmp     r0,0h                                   
08037CE8 D010     beq     @@morethantwoblocklength                                
08037CEA 4806     ldr     r0,=82F08D0h                            
08037CEC 61A0     str     r0,[r4,18h] ;写入OAM                             
08037CEE 1C21     mov     r1,r4                                   
08037CF0 3127     add     r1,27h                                  
08037CF2 2020     mov     r0,20h                                  
08037CF4 7008     strb    r0,[r1]     ;300075f写入20h                            
08037CF6 4804     ldr     r0,=0FF9Ch                              
08037CF8 8160     strh    r0,[r4,0Ah] ;顶部分界写入FF9Ch 100                            
08037CFA 3106     add     r1,6h                                   
08037CFC 2082     mov     r0,82h                                  

@@morethantwoblocklength:                               
08037D0C 1C28     mov     r0,r5                                   
08037D0E 38E0     sub     r0,0E0h     ;垂直坐标相上提升3格半的高度                            
08037D10 1C31     mov     r1,r6                                   
08037D12 F7D7FD05 bl      CheckBlock                                
08037D16 2800     cmp     r0,0h                                   
08037D18 D00E     beq     @@morethanthreeblocklength                                
08037D1A 4805     ldr     r0,=82F0928h                            
08037D1C 61A0     str     r0,[r4,18h]                             
08037D1E 1C21     mov     r1,r4                                   
08037D20 3127     add     r1,27h                                  
08037D22 2030     mov     r0,30h     ;300075f写入30h                              
08037D24 7008     strb    r0,[r1]                                 
08037D26 4803     ldr     r0,=0FF5Ch                              
08037D28 8160     strh    r0,[r4,0Ah] ;顶部分界写入FF5Ch 164                             
08037D2A 3106     add     r1,6h                                   
08037D2C 2083     mov     r0,83h                                  
08037D2E E025     b       allset                                  

@@morethanthreeblocklength:                              
08037D38 4908     ldr     r1,=0FFFFFEE0h                          
08037D3A 1868     add     r0,r5,r1     ;垂直坐标向上提升4格半的高度                           
08037D3C 1C31     mov     r1,r6                                   
08037D3E F7D7FCEF bl      CheckBlock                                
08037D42 2800     cmp     r0,0h                                   
08037D44 D010     beq     @@morethanfourblocklength                                
08037D46 4806     ldr     r0,=82F0980h                            
08037D48 61A0     str     r0,[r4,18h]                             
08037D4A 1C21     mov     r1,r4                                   
08037D4C 3127     add     r1,27h                                  
08037D4E 2040     mov     r0,40h       ;300075f写入40h                           
08037D50 7008     strb    r0,[r1]                                 
08037D52 4804     ldr     r0,=0FF1Ch   ;顶部分界写入FF1Ch 228                           
08037D54 8160     strh    r0,[r4,0Ah]                             
08037D56 3106     add     r1,6h                                   
08037D58 2084     mov     r0,84h                                  
08037D5A E00F     b       allset                                 

@@morethanfourblocklength:                              
08037D68 480C     ldr     r0,=82F09D8h                            
08037D6A 61A0     str     r0,[r4,18h]                             
08037D6C 1C21     mov     r1,r4                                   
08037D6E 3127     add     r1,27h                                  
08037D70 2050     mov     r0,50h                                  
08037D72 7008     strb    r0,[r1]                                 
08037D74 480A     ldr     r0,=0FEDCh                              
08037D76 8160     strh    r0,[r4,0Ah]  ;顶部分界写入FEDCh 292                          
08037D78 3106     add     r1,6h                                   
08037D7A 2085     mov     r0,85h  

allset:                                
08037D7C 7008     strb    r0,[r1]     ;3000765分别写入82h 83h 84h 85h                            
08037D7E 4B09     ldr     r3,=3000738h                            
08037D80 1C18     mov     r0,r3                                   
08037D82 3028     add     r0,28h                                  
08037D84 2100     mov     r1,0h                                   
08037D86 7001     strb    r1,[r0]     ;3000760写入0h                            
08037D88 3001     add     r0,1h                                   
08037D8A 2208     mov     r2,8h                                   
08037D8C 7002     strb    r2,[r0]     ;3000761写入8h  所有垂直的线宽度8h                          
08037D8E 8199     strh    r1,[r3,0Ch] ;下部分界写入0h                            
08037D90 4805     ldr     r0,=0FFF8h                              
08037D92 81D8     strh    r0,[r3,0Eh] ;左部分界写入0fff8h                           
08037D94 821A     strh    r2,[r3,10h] ;右部分界写入8h                            
08037D96 1C1C     mov     r4,r3                                   
08037D98 E063     b       @@totalset                                

@@transverselaser:                              
08037DAC 3D20     sub     r5,20h     ;垂直坐标向上提升半格    难道垂直坐标是从最下开始而水平是对半分                         
08037DAE 1C31     mov     r1,r6                                   
08037DB0 3180     add     r1,80h     ;水平坐标加80h的长度 128  2格                           
08037DB2 1C28     mov     r0,r5                                   
08037DB4 F7D7FCB4 bl      CheckBlock                                
08037DB8 2800     cmp     r0,0h                                   
08037DBA D00D     beq     @morethantwoblocklength                                
08037DBC 4805     ldr     r0,=82F0A30h                            
08037DBE 61A0     str     r0,[r4,18h]                             
08037DC0 1C21     mov     r1,r4                                   
08037DC2 3129     add     r1,29h                                  
08037DC4 2018     mov     r0,18h                                  
08037DC6 7008     strb    r0,[r1]    ;3000761写入18h                             
08037DC8 2044     mov     r0,44h                                  
08037DCA 8220     strh    r0,[r4,10h];向右长度写入44h 68                             
08037DCC 3104     add     r1,4h                                   
08037DCE 2002     mov     r0,2h                                   
08037DD0 E036     b       allset2                                

@morethantwoblocklength                               
08037DD8 1C31     mov     r1,r6                                   
08037DDA 31C0     add     r1,0C0h    ;水平坐标向右偏移3格的长度                             
08037DDC 1C28     mov     r0,r5                                   
08037DDE F7D7FC9F bl      CheckBlock                                
08037DE2 2800     cmp     r0,0h                                   
08037DE4 D00C     beq     @morethanthreeblocklength                                
08037DE6 4805     ldr     r0,=82F0A88h                            
08037DE8 61A0     str     r0,[r4,18h]                             
08037DEA 1C21     mov     r1,r4                                   
08037DEC 3129     add     r1,29h                                  
08037DEE 2028     mov     r0,28h                                 
08037DF0 7008     strb    r0,[r1]    ;3000761写入28h                              
08037DF2 2084     mov     r0,84h                                  
08037DF4 8220     strh    r0,[r4,10h] ;向右长度写入84h                            
08037DF6 3104     add     r1,4h                                   
08037DF8 2003     mov     r0,3h                                   
08037DFA E021     b       allset2                                

@morethanthreeblocklength:                              
08037E00 2280     mov     r2,80h                                  
08037E02 0052     lsl     r2,r2,1h   ;100h                             
08037E04 18B1     add     r1,r6,r2   ;水平坐标向右偏移4格的长度                             
08037E06 1C28     mov     r0,r5                                   
08037E08 F7D7FC8A bl      CheckBlock                                
08037E0C 2800     cmp     r0,0h                                   
08037E0E D00D     beq     @morethanfourblocklength                                
08037E10 4805     ldr     r0,=82F0AE0h                            
08037E12 61A0     str     r0,[r4,18h]                             
08037E14 1C21     mov     r1,r4                                   
08037E16 3129     add     r1,29h                                  
08037E18 2038     mov     r0,38h                                  
08037E1A 7008     strb    r0,[r1]     ;3000761写入38h                               
08037E1C 20C4     mov     r0,0C4h                                 
08037E1E 8220     strh    r0,[r4,10h] ;向右长度写入c4h                             
08037E20 3104     add     r1,4h                                   
08037E22 2004     mov     r0,4h                                   
08037E24 E00C     b       allset2                                

@morethanfourblocklength:                              
08037E2C 481E     ldr     r0,=82F0B38h                            
08037E2E 61A0     str     r0,[r4,18h]                             
08037E30 1C21     mov     r1,r4                                   
08037E32 3129     add     r1,29h                                  
08037E34 2048     mov     r0,48h      ;3000761写入48h                             
08037E36 7008     strb    r0,[r1]                                 
08037E38 30BC     add     r0,0BCh                                 
08037E3A 8220     strh    r0,[r4,10h] ;向右长度写入104h                             
08037E3C 3104     add     r1,4h                                   
08037E3E 2005     mov     r0,5h                                   
08037E40 7008     strb    r0,[r1]     ;3000765分别写入 2 3 4 5                           
08037E42 4A1A     ldr     r2,=3000738h                            
08037E44 1C13     mov     r3,r2                                   
08037E46 3327     add     r3,27h                                  
08037E48 2100     mov     r1,0h                                   
08037E4A 2010     mov     r0,10h                                  
08037E4C 7018     strb    r0,[r3]     ;300075f写入10h 所有水平的线高度10h                           
08037E4E 1C10     mov     r0,r2                                   
08037E50 3028     add     r0,28h                                  
08037E52 7001     strb    r1,[r0]     ;3000760写入0h                            
08037E54 4816     ldr     r0,=0FFD8h                              
08037E56 8150     strh    r0,[r2,0Ah] ;上部分界写入ffd8h                            
08037E58 3010     add     r0,10h                                  
08037E5A 8190     strh    r0,[r2,0Ch] ;下部分界写入ffe8h 向上提18h?                            
08037E5C 3014     add     r0,14h                                  
08037E5E 81D0     strh    r0,[r2,0Eh] ;左部分界写入fffch                            
08037E60 1C14     mov     r4,r2  

@@totalset:                                 
08037E62 1C22     mov     r2,r4                                   
08037E64 3225     add     r2,25h                                  
08037E66 2100     mov     r1,0h                                   
08037E68 201E     mov     r0,1Eh                                  
08037E6A 7010     strb    r0,[r2]     ;属性写入1eh                               
08037E6C 3A03     sub     r2,3h                                   
08037E6E 2002     mov     r0,2h                                   
08037E70 7010     strb    r0,[r2]     ;300075a写入2 调色板?                            
08037E72 2500     mov     r5,0h                                   
08037E74 82E1     strh    r1,[r4,16h]                             
08037E76 7725     strb    r5,[r4,1Ch] ;动画和动画帧清零                             
08037E78 490E     ldr     r1,=0C41h                             
08037E7A 2001     mov     r0,1h                                   
08037E7C F01DFDE0 bl      8055A40h    ;unknow                            
08037E80 480D     ldr     r0,=30001A8h                            
08037E82 8800     ldrh    r0,[r0]                                 
08037E84 2800     cmp     r0,0h                                   
08037E86 D019     beq     @@alarmless                                
08037E88 1C21     mov     r1,r4                                   
08037E8A 3124     add     r1,24h                                  
08037E8C 2023     mov     r0,23h                                  
08037E8E 7008     strb    r0,[r1]    ;警报不为0的话写入pose23h                             
08037E90 8820     ldrh    r0,[r4]                                 
08037E92 2104     mov     r1,4h                                   
08037E94 4308     orr     r0,r1                                   
08037E96 8020     strh    r0,[r4]    ;取向与4and再写入 相当于归0                             
08037E98 1C20     mov     r0,r4                                   
08037E9A 302E     add     r0,2Eh                                  
08037E9C 7005     strb    r5,[r0]    ;3000766写入0h 有警报                           
08037E9E 1C21     mov     r1,r4                                   
08037EA0 312F     add     r1,2Fh                                  
08037EA2 2010     mov     r0,10h                                  
08037EA4 E013     b       @@public                               

@@alarmless:                               
08037EBC 1C21     mov     r1,r4                                   
08037EBE 3124     add     r1,24h                                  
08037EC0 2009     mov     r0,9h                                   
08037EC2 7008     strb    r0,[r1]   ;警报为0的话写入pose9h                              
08037EC4 310A     add     r1,0Ah                                  
08037EC6 2001     mov     r0,1h     ;3000766写入1h 无警报                              
08037EC8 7008     strb    r0,[r1]                                 
08037ECA 3101     add     r1,1h                                   
08037ECC 2008     mov     r0,8h 

@@public:                                  
08037ECE 7008     strb    r0,[r1]   ;3000767有警报写入10h,无警报写入8h                              
08037ED0 BCF0     pop     r4-r7                                   
08037ED2 BC01     pop     r0                                      
08037ED4 4700     bx      r0                                      
 

;POSE 9h 
08037ED8 B5F0     push    r4-r7,r14                               
08037EDA 4A14     ldr     r2,=3000738h                            
08037EDC 8811     ldrh    r1,[r2]                                 
08037EDE 2080     mov     r0,80h                                  
08037EE0 0100     lsl     r0,r0,4h                                
08037EE2 4008     and     r0,r1     ;800 and 取向                              
08037EE4 1C13     mov     r3,r2                                   
08037EE6 2800     cmp     r0,0h                                   
08037EE8 D026     beq     @@pass                                
08037EEA 4911     ldr     r1,=30001A8h                            
08037EEC 22F0     mov     r2,0F0h                                 
08037EEE 0052     lsl     r2,r2,1h                                
08037EF0 1C10     mov     r0,r2                                   
08037EF2 8008     strh    r0,[r1]   ;警报帧数写入1e0h                              
08037EF4 4A0F     ldr     r2,=30001ACh                            
08037EF6 24A8     mov     r4,0A8h                                 
08037EF8 00E4     lsl     r4,r4,3h                                
08037EFA 1910     add     r0,r2,r4  ;加540h                              
08037EFC 4282     cmp     r2,r0                                   
08037EFE D21F     bcs     @@over                                
08037F00 2601     mov     r6,1h                                   
08037F02 2520     mov     r5,20h                                  
08037F04 2700     mov     r7,0h                                   
08037F06 1C04     mov     r4,r0     ;最大范围给r4 

@@loop:                             
08037F08 8811     ldrh    r1,[r2]                                 
08037F0A 1C30     mov     r0,r6                                   
08037F0C 4008     and     r0,r1    ;1 and 取向                               
08037F0E 2800     cmp     r0,0h                                   
08037F10 D007     beq     @@come                                
08037F12 1C10     mov     r0,r2                                   
08037F14 3025     add     r0,25h   ;读取属性                               
08037F16 7800     ldrb    r0,[r0]                                 
08037F18 2814     cmp     r0,14h   ;海盗属性?                              
08037F1A D102     bne     @@come   ;不是的话跳转                             
08037F1C 1C08     mov     r0,r1                                   
08037F1E 4328     orr     r0,r5    ;取向 orr 20h                               
08037F20 8010     strh    r0,[r2]  ;再写入

@@come:                                 
08037F22 3238     add     r2,38h   ;下一个敌人数据偏移                               
08037F24 42A2     cmp     r2,r4                                   
08037F26 D3EF     bcc     @@loop   ;小于则继续循环                                
08037F28 E00A     b       @@over                                

@@pass:                              
08037F38 4811     ldr     r0,=30001A8h                            
08037F3A 8800     ldrh    r0,[r0]                                 
08037F3C 2800     cmp     r0,0h                                   
08037F3E D066     beq     @@end    ;警报为0则结束  

@@over:                              
08037F40 1C19     mov     r1,r3                                   
08037F42 3124     add     r1,24h                                  
08037F44 2200     mov     r2,0h                                   
08037F46 200B     mov     r0,0Bh                                  
08037F48 7008     strb    r0,[r1]  ;pose写入0bh                               
08037F4A 8819     ldrh    r1,[r3]                                 
08037F4C 480D     ldr     r0,=0F7FFh                              
08037F4E 4008     and     r0,r1    ;f7ffh and 取向                               
08037F50 2100     mov     r1,0h                                   
08037F52 8018     strh    r0,[r3]  ;再写入                               
08037F54 2026     mov     r0,26h                                  
08037F56 18C0     add     r0,r0,r3                                
08037F58 4684     mov     r12,r0   ;300075e                               
08037F5A 2001     mov     r0,1h                                   
08037F5C 4664     mov     r4,r12                                  
08037F5E 7020     strb    r0,[r4]  ;写入1h                               
08037F60 82DA     strh    r2,[r3,16h]                             
08037F62 7719     strb    r1,[r3,1Ch] ;动画和动画帧清零                           
08037F64 1C18     mov     r0,r3                                   
08037F66 302D     add     r0,2Dh                                  
08037F68 7800     ldrb    r0,[r0]     ;3000765的值                            
08037F6A 2805     cmp     r0,5h                                   
08037F6C D02A     beq     @@Hfiveblock                                
08037F6E 2805     cmp     r0,5h                                   
08037F70 DC0A     bgt     @@verticalaser2                                
08037F72 2803     cmp     r0,3h                                   
08037F74 D01A     beq     @@Hthreeblock                                
08037F76 2803     cmp     r0,3h                                   
08037F78 DC1E     bgt     @@Hfourblock                                
08037F7A 2802     cmp     r0,2h                                   
08037F7C D010     beq     @@Htwoblock                                
08037F7E E03F     b       @@otherpossible                                

@@verticalaser2:                              
08037F88 2883     cmp     r0,83h                                  
08037F8A D027     beq     @@Vthreeblock                                
08037F8C 2883     cmp     r0,83h                                  
08037F8E DC02     bgt     @@morethanthree                                
08037F90 2882     cmp     r0,82h                                  
08037F92 D01D     beq     @@Vtwoblock                                
08037F94 E034     b       @@otherpossible 

@@morethanthree:                               
08037F96 2884     cmp     r0,84h                                  
08037F98 D026     beq     @@Vfourblock                                
08037F9A 2885     cmp     r0,85h                                  
08037F9C D02A     beq     @@Vfiveblock                                
08037F9E E02F     b       @@otherpossible

@@Htwoblock:                                
08037FA0 4801     ldr     r0,=82F0C70h                            
08037FA2 6198     str     r0,[r3,18h]                             
08037FA4 E02F     b       @@sound                                

@@Hthreeblock:                              
08037FAC 4801     ldr     r0,=82F0CA8h                            
08037FAE 6198     str     r0,[r3,18h]                             
08037FB0 E029     b       @@sound                                

@@Hfourblock:                               
08037FB8 4801     ldr     r0,=82F0CE0h                            
08037FBA 6198     str     r0,[r3,18h]                             
08037FBC E023     b       @@sound                                
  
@@Hfiveblock:                            
08037FC4 4801     ldr     r0,=82F0D18h                            
08037FC6 6198     str     r0,[r3,18h]                             
08037FC8 E01D     b       @@sound                                

@@Vtwoblock:                               
08037FD0 4801     ldr     r0,=82F0B90h                            
08037FD2 6198     str     r0,[r3,18h]                             
08037FD4 E017     b       @@sound                                

@@Vthreeblock:                             
08037FDC 4801     ldr     r0,=82F0BC8h                            
08037FDE 6198     str     r0,[r3,18h]                             
08037FE0 E011     b       @@sound                                 

@@Vfourblock:                             
08037FE8 4801     ldr     r0,=82F0C00h                            
08037FEA 6198     str     r0,[r3,18h]                             
08037FEC E00B     b       @@sound                                

@@Vfiveblock:                             
08037FF4 4801     ldr     r0,=82F0C38h                            
08037FF6 6198     str     r0,[r3,18h]                             
08037FF8 E005     b       @@sound                                
 
@@otherpossible: 
08038000 2000     mov     r0,0h                                   
08038002 8018     strh    r0,[r3]   ;取向写入0h                               
08038004 E003     b       @@end 

@@sound:                               
08038006 2085     mov     r0,85h                                  
08038008 0040     lsl     r0,r0,1h   ;266 激光触发叮声                             
0803800A F7CAFD05 bl      PlaySound  

@@end:                              
0803800E BCF0     pop     r4-r7                                   
08038010 BC01     pop     r0                                      
08038012 4700     bx      r0  

;pose 0bh                                    
08038014 B510     push    r4,r14                                  
08038016 4C11     ldr     r4,=3000738h                            
08038018 1C21     mov     r1,r4                                   
0803801A 3126     add     r1,26h                                  
0803801C 2001     mov     r0,1h                                   
0803801E 7008     strb    r0,[r1]      ;300075e写入1h                           
08038020 F7D7FDD2 bl      CheckEndSpriteAnimation                                
08038024 2800     cmp     r0,0h                                   
08038026 D05A     beq     @@end2                                
08038028 1C21     mov     r1,r4                                   
0803802A 3124     add     r1,24h                                  
0803802C 2023     mov     r0,23h       ;pose写入23h                            
0803802E 7008     strb    r0,[r1]                                 
08038030 2100     mov     r1,0h                                   
08038032 2000     mov     r0,0h                                   
08038034 82E0     strh    r0,[r4,16h]                             
08038036 7721     strb    r1,[r4,1Ch]  ;动画和动画帧清零                            
08038038 8820     ldrh    r0,[r4]                                 
0803803A 2104     mov     r1,4h                                   
0803803C 4308     orr     r0,r1        ;取向 orr 4h   7h?                        
0803803E 8020     strh    r0,[r4]                                 
08038040 1C20     mov     r0,r4                                   
08038042 302D     add     r0,2Dh                                  
08038044 7800     ldrb    r0,[r0]      ;3000765的值                           
08038046 2805     cmp     r0,5h                                   
08038048 D028     beq     @@Hfiveblock2                                
0803804A 2805     cmp     r0,5h                                   
0803804C DC08     bgt     @@verticalaser3                                
0803804E 2803     cmp     r0,3h                                   
08038050 D018     beq     @@Hthreeblock2                                
08038052 2803     cmp     r0,3h                                   
08038054 DC1C     bgt     @@Hfourblock2                                
08038056 2802     cmp     r0,2h                                   
08038058 D00E     beq     @@Htwoblock2                                
0803805A E03D     b       @@otherpossible2                                

@@verticalaser3:                              
08038060 2883     cmp     r0,83h                                  
08038062 D027     beq     @@Vthreeblock2                                
08038064 2883     cmp     r0,83h                                  
08038066 DC02     bgt     @@morethanthree2                                
08038068 2882     cmp     r0,82h                                  
0803806A D01D     beq     @@Vtwoblock2                                
0803806C E034     b       @@otherpossible2

@@morethanthree2:                                
0803806E 2884     cmp     r0,84h                                  
08038070 D026     beq     @@Vfourblock2                                
08038072 2885     cmp     r0,85h                                  
08038074 D02A     beq     @@Vfiveblock2                                
08038076 E02F     b       @@otherpossible2

@@Htwoblock2:                                
08038078 4801     ldr     r0,=82F0A30h                            
0803807A 61A0     str     r0,[r4,18h]                             
0803807C E02F     b       @@end2                                

@@Hthreeblock2:                              
08038084 4801     ldr     r0,=82F0A88h                            
08038086 61A0     str     r0,[r4,18h]                             
08038088 E029     b       @@end2                                

@@Hfourblock2:                               
08038090 4801     ldr     r0,=82F0AE0h                            
08038092 61A0     str     r0,[r4,18h]                             
08038094 E023     b       @@end2                                

@@Hfiveblock2:                               
0803809C 4801     ldr     r0,=82F0B38h                            
0803809E 61A0     str     r0,[r4,18h]                             
080380A0 E01D     b       @@end2                                

@@Vtwoblock2:                              
080380A8 4801     ldr     r0,=82F08D0h                            
080380AA 61A0     str     r0,[r4,18h]                             
080380AC E017     b       @@end2                                

@@Vthreeblock2:                               
080380B4 4801     ldr     r0,=82F0928h                            
080380B6 61A0     str     r0,[r4,18h]                             
080380B8 E011     b       @@end2                                

@@Vfourblock2:                               
080380C0 4801     ldr     r0,=82F0980h                            
080380C2 61A0     str     r0,[r4,18h]                             
080380C4 E00B     b       @@end2                                

@@Vfiveblock2:                               
080380CC 4801     ldr     r0,=82F09D8h                            
080380CE 61A0     str     r0,[r4,18h]                             
080380D0 E005     b       @@end2                                

@@otherpossible2:                              
080380D8 4902     ldr     r1,=3000738h                            
080380DA 2000     mov     r0,0h                                   
080380DC 8008     strh    r0,[r1] 

@@end2:                                
080380DE BC10     pop     r4                                      
080380E0 BC01     pop     r0                                      
080380E2 4700     bx      r0  

;pose 23h                              
080380E8 4804     ldr     r0,=3000738h                            
080380EA 3026     add     r0,26h                                  
080380EC 2101     mov     r1,1h                                   
080380EE 7001     strb    r1,[r0]         ;300075e写入1h                        
080380F0 4903     ldr     r1,=30001A8h                            
080380F2 22F0     mov     r2,0F0h                                 
080380F4 0052     lsl     r2,r2,1h                                
080380F6 1C10     mov     r0,r2                                   
080380F8 8008     strh    r0,[r1]         ;警报时间写入1e0h                        
080380FA 4770     bx      r14                                     

;pose 0ch  游戏中未用到?
08038104 B510     push    r4,r14                                  
08038106 4C0F     ldr     r4,=3000738h                            
08038108 1C21     mov     r1,r4                                   
0803810A 3126     add     r1,26h                                  
0803810C 2001     mov     r0,1h                                   
0803810E 7008     strb    r0,[r1]         ;300075e写入1h                        
08038110 F7D7FD5A bl      CheckEndSpriteAnimation                                
08038114 2800     cmp     r0,0h                                   
08038116 D056     beq     @@end3                                
08038118 1C21     mov     r1,r4                                   
0803811A 3124     add     r1,24h                                  
0803811C 2009     mov     r0,9h           ;pose写入9h                        
0803811E 7008     strb    r0,[r1]                                 
08038120 2100     mov     r1,0h                                   
08038122 2000     mov     r0,0h                                   
08038124 82E0     strh    r0,[r4,16h]                             
08038126 7721     strb    r1,[r4,1Ch]     ;动画和动画帧清零                        
08038128 1C20     mov     r0,r4                                   
0803812A 302D     add     r0,2Dh                                  
0803812C 7800     ldrb    r0,[r0]         ;3000765的值                        
0803812E 2805     cmp     r0,5h                                   
08038130 D028     beq     @@Hfiveblock3                                
08038132 2805     cmp     r0,5h                                   
08038134 DC08     bgt     @@verticalaser4                                
08038136 2803     cmp     r0,3h                                   
08038138 D018     beq     @@Hthreeblock3                                
0803813A 2803     cmp     r0,3h                                   
0803813C DC1C     bgt     @@Hfourblock3                                
0803813E 2802     cmp     r0,2h                                   
08038140 D00E     beq     @@Htwoblock3                               
08038142 E03D     b       @@otherpossible3                               

@@verticalaser4:                              
08038148 2883     cmp     r0,83h                                  
0803814A D027     beq     @@Vthreeblock3                                
0803814C 2883     cmp     r0,83h                                  
0803814E DC02     bgt     @@morethanthree3                               
08038150 2882     cmp     r0,82h                                  
08038152 D01D     beq     @@Vtwoblock3                                
08038154 E034     b       @@otherpossible3   

@@morethanthree3:                            
08038156 2884     cmp     r0,84h                                  
08038158 D026     beq     @@Vfourblock3                                
0803815A 2885     cmp     r0,85h                                  
0803815C D02A     beq     @@Vfiveblock3                                
0803815E E02F     b       @@otherpossible3

@@Htwoblock3:                               
08038160 4801     ldr     r0,=82F0A30h                            
08038162 61A0     str     r0,[r4,18h]                             
08038164 E02F     b       @@end3                                

@@Hthreeblock3:                            
0803816C 4801     ldr     r0,=82F0A88h                            
0803816E 61A0     str     r0,[r4,18h]                             
08038170 E029     b       @@end3                                

@@Hfourblock3:                              
08038178 4801     ldr     r0,=82F0AE0h                            
0803817A 61A0     str     r0,[r4,18h]                             
0803817C E023     b       @@end3                                

@@Hfiveblock3:                              
08038184 4801     ldr     r0,=82F0B38h                            
08038186 61A0     str     r0,[r4,18h]                             
08038188 E01D     b       @@end3                                

@@Vtwoblock3:                              
08038190 4801     ldr     r0,=82F08D0h                            
08038192 61A0     str     r0,[r4,18h]                             
08038194 E017     b       @@end3                                

@@Vthreeblock3:                               
0803819C 4801     ldr     r0,=82F0928h                            
0803819E 61A0     str     r0,[r4,18h]                             
080381A0 E011     b       @@end3                                

@@Vfourblock3:                               
080381A8 4801     ldr     r0,=82F0980h                            
080381AA 61A0     str     r0,[r4,18h]                             
080381AC E00B     b       @@end3                                

@@Vfiveblock3:                              
080381B4 4801     ldr     r0,=82F09D8h                            
080381B6 61A0     str     r0,[r4,18h]                             
080381B8 E005     b       @@end3                                

@@otherpossible3:                              
080381C0 4902     ldr     r1,=3000738h                            
080381C2 2000     mov     r0,0h                                   
080381C4 8008     strh    r0,[r1] 

@@end3:                                
080381C6 BC10     pop     r4                                      
080381C8 BC01     pop     r0                                      
080381CA 4700     bx      r0                                                                   

;主程序
080381D0 B500     push    r14                                     
080381D2 4805     ldr     r0,=3000738h                            
080381D4 3024     add     r0,24h                                  
080381D6 7800     ldrb    r0,[r0]                                 
080381D8 2823     cmp     r0,23h                                  
080381DA D85F     bhi     803829Ch    ;pose大于23h则跳转到pose 0ah                            
080381DC 0080     lsl     r0,r0,2h                                
080381DE 4903     ldr     r1,=posetable                           
080381E0 1840     add     r0,r0,r1                                
080381E2 6800     ldr     r0,[r0]                                 
080381E4 4687     mov     r15,r0                                  
                             
posetable:
    .word 8038280h ;00
	.word 803829ch .word 803829ch .word 803829ch .word 803829ch
	.word 803829ch .word 803829ch .word 803829ch .word 803829ch
	.word 8038286h ;09h
	.word 803829ch ;0ah
	.word 803828ch ;0bh
	.word 8038298h ;0ch
	.word 803829ch .word 803829ch .word 803829ch .word 803829ch
	.word 803829ch .word 803829ch .word 803829ch .word 803829ch
	.word 803829ch .word 803829ch .word 803829ch .word 803829ch
	.word 803829ch .word 803829ch .word 803829ch .word 803829ch
	.word 803829ch .word 803829ch .word 803829ch .word 803829ch
	.word 803829ch .word 803829ch 
	.word 8038292h ;23h
	
08038280 F7FFFD1C bl      8037CBCh   ;00                             
08038284 E00A     b       803829Ch                               
08038286 F7FFFE27 bl      8037ED8h   ;09h                             
0803828A E007     b       803829Ch                               
0803828C F7FFFEC2 bl      8038014h   ;0bh                             
08038290 E004     b       803829Ch                                
08038292 F7FFFF29 bl      80380E8h   ;23h                               
08038296 E001     b       803829Ch                                
08038298 F7FFFF34 bl      8038104h   ;0ch  

;pose 0ah                           
0803829C 490F     ldr     r1,=3000738h                            
0803829E 7F48     ldrb    r0,[r1,1Dh]                             
080382A0 3068     add     r0,68h                                  
080382A2 0600     lsl     r0,r0,18h                               
080382A4 0E00     lsr     r0,r0,18h                               
080382A6 1C0A     mov     r2,r1                                   
080382A8 2801     cmp     r0,1h                                   
080382AA D82D     bhi     @@secondlaser ;精灵如果是9a 9b则直接结束.                                
080382AC 480C     ldr     r0,=30001A8h                            
080382AE 8800     ldrh    r0,[r0]                                 
080382B0 2800     cmp     r0,0h                                   
080382B2 D017     beq     @@alarmless2                                
080382B4 1C13     mov     r3,r2                                   
080382B6 332E     add     r3,2Eh                                  
080382B8 7818     ldrb    r0,[r3]       ;读取3000766的值                          
080382BA 2800     cmp     r0,0h         ;如果为0则是有警报的标志                          
080382BC D01C     beq     @@public2                                
080382BE 3801     sub     r0,1h                                   
080382C0 7018     strb    r0,[r3]       ;3000766减1再写入                          
080382C2 0600     lsl     r0,r0,18h     ;该值逻辑右移18h                          
080382C4 2800     cmp     r0,0h                                   
080382C6 D117     bne     @@public2     ;如果不为0则跳转                           
080382C8 312F     add     r1,2Fh                                  
080382CA 7808     ldrb    r0,[r1]                                 
080382CC 280F     cmp     r0,0Fh        ;3000767的值                          
080382CE D813     bhi     @@public2     ;大于0F则跳转,有警报大于0F                           
080382D0 3001     add     r0,1h                                   
080382D2 7008     strb    r0,[r1]       ;3000767的值加1再写入                          
080382D4 2001     mov     r0,1h                                   
080382D6 7018     strb    r0,[r3]       ;同时3000766写入1h                          
080382D8 E00E     b       @@public2                                

@@alarmless2:                              
080382E4 1C11     mov     r1,r2                                   
080382E6 312F     add     r1,2Fh                                  
080382E8 7808     ldrb    r0,[r1]                                 
080382EA 2808     cmp     r0,8h         ;读取3000767的值,如果是8,无警报则跳转                          
080382EC D004     beq     @@public2                                
080382EE 2008     mov     r0,8h                                   
080382F0 7008     strb    r0,[r1]       ;否则的话写入8h                          
080382F2 3901     sub     r1,1h                                   
080382F4 2001     mov     r0,1h                                   
080382F6 7008     strb    r0,[r1]       ;同时3000766写入1h

@@public2:                                
080382F8 1C10     mov     r0,r2                                   
080382FA 302F     add     r0,2Fh                                  
080382FC 7801     ldrb    r1,[r0]                                 
080382FE 2000     mov     r0,0h                                   
08038300 2200     mov     r2,0h                                   
08038302 2310     mov     r3,10h                                  
08038304 F01DFC0E bl      8055B24h      ;unknow

@@secondlaser:                              
08038308 BC01     pop     r0                                      
0803830A 4700     bx      r0  
