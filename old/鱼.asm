

.definelabel Frozen,800FFE8h
.definelabel PlaySound,8002B20h
.definelabel StunSprite,8011280h
.definelabel PoseTable,8049064h
.definelabel DeathFireworks,8011084h
.definelabel PriSpriteDateStart,82B0D68h
.definelabel CheckClip,800F688h
.definelabel CheckSpriteScope,800FDE0h
.definelabel CheckAnimation,800FBC8h

;左右转身判定设定
08048C7C B500     push    r14                                     
08048C7E 4A05     ldr     r2,=3000738h                            
08048C80 8811     ldrh    r1,[r2]                                 
08048C82 2040     mov     r0,40h                                  
08048C84 4008     and     r0,r1     ;40 and 取向                                
08048C86 2800     cmp     r0,0h                                   
08048C88 D008     beq     @@faceleft                                
08048C8A 4803     ldr     r0,=0FFE8h                              
08048C8C 81D0     strh    r0,[r2,0Eh] ;左部分界写入FFE8h                            
08048C8E 2028     mov     r0,28h                                  
08048C90 E007     b       @@end                                

@@faceleft:                                
08048C9C 4802     ldr     r0,=0FFD8h  ;左部分界写入FFD8                            
08048C9E 81D0     strh    r0,[r2,0Eh]                             
08048CA0 2018     mov     r0,18h    

@@end:                              
08048CA2 8210     strh    r0,[r2,10h] ;右部分界写入28h 或 18h                           
08048CA4 BC01     pop     r0                                      
08048CA6 4700     bx      r0   

;左右移动例程
08048CAC B570     push    r4-r6,r14                               
08048CAE 0400     lsl     r0,r0,10h                               
08048CB0 0C05     lsr     r5,r0,10h  ;4h                              
08048CB2 1C2E     mov     r6,r5                                   
08048CB4 4C09     ldr     r4,=3000738h                            
08048CB6 8821     ldrh    r1,[r4]                                 
08048CB8 2040     mov     r0,40h                                  
08048CBA 4008     and     r0,r1                                   
08048CBC 2800     cmp     r0,0h                                   
08048CBE D011     beq     @@faceleft                                
08048CC0 8860     ldrh    r0,[r4,2h]  ;面右                            
08048CC2 3820     sub     r0,20h    ;Y坐标上半格坐标                              
08048CC4 88A1     ldrh    r1,[r4,4h]                              
08048CC6 3138     add     r1,38h    ;X坐标右移38h                              
08048CC8 F7C6FCDE bl      CheckClip                                
08048CCC 4804     ldr     r0,=30007F1h                            
08048CCE 7800     ldrb    r0,[r0]                                 
08048CD0 2811     cmp     r0,11h                                  
08048CD2 D011     beq     @@HaveBlock                                
08048CD4 88A0     ldrh    r0,[r4,4h]                              
08048CD6 1828     add     r0,r5,r0  ;右移4h                             
08048CD8 E014     b       @@peer                                

@@faceleft:                              
08048CE4 8860     ldrh    r0,[r4,2h] ;面左                             
08048CE6 3820     sub     r0,20h     ;Y坐标上半格坐标                             
08048CE8 88A1     ldrh    r1,[r4,4h]                              
08048CEA 3938     sub     r1,38h     ;X坐标左移38h                             
08048CEC F7C6FCCC bl      CheckClip                                
08048CF0 4802     ldr     r0,=30007F1h                            
08048CF2 7800     ldrb    r0,[r0]                                 
08048CF4 2811     cmp     r0,11h                                  
08048CF6 D103     bne     @@NoBlock

@@HaveBlock:                                
08048CF8 2001     mov     r0,1h                                   
08048CFA E005     b       @@end                                

@@NoBlock:                              
08048D00 88A0     ldrh    r0,[r4,4h]                              
08048D02 1B80     sub     r0,r0,r6   ;左移4h

@@peer:                              
08048D04 80A0     strh    r0,[r4,4h] ;写入新X坐标                             
08048D06 2000     mov     r0,0h 

@@end:                                  
08048D08 BC70     pop     r4-r6                                   
08048D0A BC02     pop     r1                                      
08048D0C 4708     bx      r1  

;pose 0h
08048D10 B570     push    r4-r6,r14                               
08048D12 F7C6FD7B bl      800F80Ch                                
08048D16 4E14     ldr     r6,=3000738h                            
08048D18 1C31     mov     r1,r6                                   
08048D1A 3127     add     r1,27h                                  
08048D1C 2400     mov     r4,0h                                   
08048D1E 2020     mov     r0,20h                                  
08048D20 7008     strb    r0,[r1]  ;300075f写入20h                               
08048D22 1C30     mov     r0,r6                                   
08048D24 3028     add     r0,28h                                  
08048D26 7004     strb    r4,[r0]  ;3000760写入0                               
08048D28 3102     add     r1,2h                                   
08048D2A 2018     mov     r0,18h                                  
08048D2C 7008     strb    r0,[r1]  ;3000761写入18h                               
08048D2E 2500     mov     r5,0h                                   
08048D30 480E     ldr     r0,=0FFA0h                              
08048D32 8170     strh    r0,[r6,0Ah] ;上部分界写入FFA0h                            
08048D34 81B4     strh    r4,[r6,0Ch] ;下部分界写入0                           
08048D36 F7FFFFA1 bl      8048C7Ch    ;设置面向与身体宽度的区别                            
08048D3A 1C31     mov     r1,r6                                   
08048D3C 3124     add     r1,24h                                  
08048D3E 2008     mov     r0,8h                                   
08048D40 7008     strb    r0,[r1]     ;pose写入8h                            
08048D42 3101     add     r1,1h                                   
08048D44 2004     mov     r0,4h                                   
08048D46 7008     strb    r0,[r1]     ;属性写入4h                             
08048D48 4809     ldr     r0,=831426Ch                            
08048D4A 61B0     str     r0,[r6,18h]  ;写入OAM                           
08048D4C 7735     strb    r5,[r6,1Ch]                             
08048D4E 82F4     strh    r4,[r6,16h]                             
08048D50 4A08     ldr     r2,=PriSpriteDateStart                            
08048D52 7F71     ldrb    r1,[r6,1Dh]                             
08048D54 00C8     lsl     r0,r1,3h                                
08048D56 1840     add     r0,r0,r1                                
08048D58 0040     lsl     r0,r0,1h                                
08048D5A 1880     add     r0,r0,r2                                
08048D5C 8800     ldrh    r0,[r0]                                 
08048D5E 82B0     strh    r0,[r6,14h] ;写入血量                            
08048D60 BC70     pop     r4-r6                                   
08048D62 BC01     pop     r0                                      
08048D64 4700     bx      r0                                      

;pose 8h                               
08048D78 B510     push    r4,r14                                  
08048D7A 4809     ldr     r0,=3000738h                            
08048D7C 8881     ldrh    r1,[r0,4h]                              
08048D7E 2300     mov     r3,0h                                   
08048D80 2400     mov     r4,0h                                   
08048D82 8101     strh    r1,[r0,8h]  ;X坐标写入弹丸X坐标>                            
08048D84 1C02     mov     r2,r0                                   
08048D86 3224     add     r2,24h                                  
08048D88 2109     mov     r1,9h                                   
08048D8A 7011     strb    r1,[r2]     ;pose写入9h                             
08048D8C 4905     ldr     r1,=831426Ch                            
08048D8E 6181     str     r1,[r0,18h] ;写入新OAM                            
08048D90 7703     strb    r3,[r0,1Ch]                             
08048D92 82C4     strh    r4,[r0,16h]                             
08048D94 302C     add     r0,2Ch                                  
08048D96 2103     mov     r1,3h                                   
08048D98 7001     strb    r1,[r0]    ;3000764 写入3h                             
08048D9A BC10     pop     r4                                      
08048D9C BC01     pop     r0                                      
08048D9E 4700     bx      r0                                      

;pose 9h                              
08048DA8 B510     push    r4,r14                                  
08048DAA 4C0A     ldr     r4,=3000738h                            
08048DAC 1C21     mov     r1,r4                                   
08048DAE 312C     add     r1,2Ch                                  
08048DB0 7808     ldrb    r0,[r1]                                 
08048DB2 3801     sub     r0,1h      ;3000764 减1                              
08048DB4 7008     strb    r0,[r1]    ;再写入                             
08048DB6 0600     lsl     r0,r0,18h                               
08048DB8 2800     cmp     r0,0h                                   
08048DBA D128     bne     @@pass                                
08048DBC 2004     mov     r0,4h                                   
08048DBE F7FFFF75 bl      8048CACh   ;左右移动                              
08048DC2 0600     lsl     r0,r0,18h                               
08048DC4 2800     cmp     r0,0h                                   
08048DC6 D007     beq     @@NoBlock                                
08048DC8 1C21     mov     r1,r4      ;如果有砖块                             
08048DCA 3124     add     r1,24h     ;pose写入Ah转身                             
08048DCC 200A     mov     r0,0Ah                                  
08048DCE 7008     strb    r0,[r1]                                 
08048DD0 E01D     b       @@pass                                

@@NoBlock:                               
08048DD8 8821     ldrh    r1,[r4]                                 
08048DDA 2040     mov     r0,40h                                  
08048DDC 4008     and     r0,r1                                   
08048DDE 2800     cmp     r0,0h                                   
08048DE0 D007     beq     @@faceleft                                
08048DE2 8920     ldrh    r0,[r4,8h] ;原先复制的X坐标                             
08048DE4 2180     mov     r1,80h                                  
08048DE6 0089     lsl     r1,r1,2h                                
08048DE8 1840     add     r0,r0,r1   ;加上200h                             
08048DEA 88A1     ldrh    r1,[r4,4h]                              
08048DEC 4288     cmp     r0,r1      ;向右200h的坐标是否                            
08048DEE DA0A     bge     @@inside   ;大于或等于                             
08048DF0 E005     b       @@outside 

@@faceleft:                               
08048DF2 8920     ldrh    r0,[r4,8h]                              
08048DF4 4912     ldr     r1,=0FFFFFE00h                          
08048DF6 1840     add     r0,r0,r1    ;向左200h的坐标                           
08048DF8 88A1     ldrh    r1,[r4,4h]                              
08048DFA 4288     cmp     r0,r1                                   
08048DFC DD03     ble     @@inside    ;小于或等于  

@@outside:                          
08048DFE 1C21     mov     r1,r4                                   
08048E00 3124     add     r1,24h                                  
08048E02 200A     mov     r0,0Ah      ;pose 写入0ah                                
08048E04 7008     strb    r0,[r1]

@@inside:                                 
08048E06 480F     ldr     r0,=3000738h                            
08048E08 302C     add     r0,2Ch                                  
08048E0A 2103     mov     r1,3h      ;3000764再写入3h                                
08048E0C 7001     strb    r1,[r0]    ;用于移动的暂歇?

@@pass:                                 
08048E0E 20A0     mov     r0,0A0h                                 
08048E10 0080     lsl     r0,r0,2h   ;280h                              
08048E12 2140     mov     r1,40h     ;垂直10格,水平1格                             
08048E14 F7C6FFE4 bl      CheckSpriteScope                                
08048E18 2800     cmp     r0,0h                                   
08048E1A D124     bne     @@end                                
08048E1C 21A0     mov     r1,0A0h                                 
08048E1E 0049     lsl     r1,r1,1h   ;水平5格                             
08048E20 20C0     mov     r0,0C0h    ;垂直3格                             
08048E22 F7C6FFDD bl      CheckSpriteScope                                
08048E26 1C02     mov     r2,r0                                   
08048E28 4B06     ldr     r3,=3000738h                            
08048E2A 8819     ldrh    r1,[r3]                                 
08048E2C 2040     mov     r0,40h                                  
08048E2E 4008     and     r0,r1                                   
08048E30 2800     cmp     r0,0h                                   
08048E32 D00C     beq     @@faceleft2                                
08048E34 2A08     cmp     r2,8h                                   
08048E36 D107     bne     @@spritenoright                               
08048E38 1C19     mov     r1,r3      ;面右人在右                             
08048E3A 3124     add     r1,24h                                  
08048E3C 2034     mov     r0,34h     ;pose写入34h                               
08048E3E E011     b       @@peer2                                

@@spritenoright:  ;面右 人不在右                             
08048E48 2A04     cmp     r2,4h                                   
08048E4A D10C     bne     @@end                                
08048E4C E007     b       @@spriteleft ;面右人在左

@@faceleft2:                                
08048E4E 2A04     cmp     r2,4h                                   
08048E50 D103     bne     @@spritenoleft                                
08048E52 1C19     mov     r1,r3                                   
08048E54 3124     add     r1,24h                                  
08048E56 2034     mov     r0,34h                                  
08048E58 E004     b       @@peer2 

@@spritenoleft:                                  
08048E5A 2A08     cmp     r2,8h                                   
08048E5C D103     bne     @@end 

@@spriteleft:                               
08048E5E 1C19     mov     r1,r3     ;面左人在右 面右人在左                             
08048E60 3124     add     r1,24h    ;pose写入 0ah                                
08048E62 200A     mov     r0,0Ah    ;故0a是转身

@@peer2:                                 
08048E64 7008     strb    r0,[r1]

@@end:                                 
08048E66 BC10     pop     r4                                      
08048E68 BC01     pop     r0                                      
08048E6A 4700     bx      r0

;pose 34h                                      
08048E6C 4905     ldr     r1,=3000738h                            
08048E6E 1C0A     mov     r2,r1                                   
08048E70 3224     add     r2,24h                                  
08048E72 2300     mov     r3,0h                                   
08048E74 2035     mov     r0,35h     ;pose写入35h                              
08048E76 7010     strb    r0,[r2]                                 
08048E78 4803     ldr     r0,=83142DCh ;写入新OAM                           
08048E7A 6188     str     r0,[r1,18h]                             
08048E7C 770B     strb    r3,[r1,1Ch]                             
08048E7E 82CB     strh    r3,[r1,16h]  ;完事...                           
08048E80 4770     bx      r14                                     

;pose 35h                               
08048E8C B530     push    r4,r5,r14                               
08048E8E 4A12     ldr     r2,=30013D4h                            
08048E90 4812     ldr     r0,=3001588h                            
08048E92 3070     add     r0,70h                                  
08048E94 2100     mov     r1,0h                                   
08048E96 5E40     ldsh    r0,[r0,r1] ;人物长度84负数                              
08048E98 0FC1     lsr     r1,r0,1Fh                               
08048E9A 1840     add     r0,r0,r1                                
08048E9C 1040     asr     r0,r0,1h   ;站立为C2负数                              
08048E9E 8A92     ldrh    r2,[r2,14h] ;SA Y坐标                            
08048EA0 1880     add     r0,r0,r2                                
08048EA2 0400     lsl     r0,r0,10h                               
08048EA4 0C02     lsr     r2,r0,10h   ;两者相加                            
08048EA6 4C0E     ldr     r4,=3000738h                            
08048EA8 8860     ldrh    r0,[r4,2h]  ;精灵Y坐标                           
08048EAA 3820     sub     r0,20h                                 
08048EAC 0400     lsl     r0,r0,10h                               
08048EAE 0C01     lsr     r1,r0,10h   ;上升半格的坐标                            
08048EB0 1C08     mov     r0,r1                                   
08048EB2 3840     sub     r0,40h      ;上升一格半的坐标                            
08048EB4 4290     cmp     r0,r2                                   
08048EB6 DD19     ble     @@spriteup  ;小于或等于,敌在上?                             
08048EB8 8860     ldrh    r0,[r4,2h]  ;敌在下                            
08048EBA 3860     sub     r0,60h      ;Y坐标上升一格半                            
08048EBC 88A1     ldrh    r1,[r4,4h]                              
08048EBE F7C6FBE3 bl      CheckClip                                
08048EC2 4808     ldr     r0,=30007F1h                            
08048EC4 7800     ldrb    r0,[r0]                                 
08048EC6 2800     cmp     r0,0h                                   
08048EC8 D11F     bne     @@haveblock                                
08048ECA 4807     ldr     r0,=30000DCh ;检查空气?                           
08048ECC 8840     ldrh    r0,[r0,2h]                              
08048ECE 2801     cmp     r0,1h                                   
08048ED0 D11B     bne     @@haveblock                                
08048ED2 8860     ldrh    r0,[r4,2h]                              
08048ED4 3802     sub     r0,2h      ;Y坐标上升2h                              
08048ED6 E017     b       @@peer                                

@@spriteup:                              
08048EEC 1C08     mov     r0,r1                                   
08048EEE 3040     add     r0,40h    ;上升半格的坐标                              
08048EF0 4290     cmp     r0,r2                                   
08048EF2 DA0A     bge     @@haveblock ;大于或等于,敌在下                              
08048EF4 8860     ldrh    r0,[r4,2h]                              
08048EF6 88A1     ldrh    r1,[r4,4h]                              
08048EF8 F7C6FBC6 bl      CheckClip                                
08048EFC 480D     ldr     r0,=30007F1h                            
08048EFE 7800     ldrb    r0,[r0]                                 
08048F00 2800     cmp     r0,0h                                   
08048F02 D102     bne     @@haveblock                                
08048F04 8860     ldrh    r0,[r4,2h]                              
08048F06 3002     add     r0,2h       ;Y坐标下降2h

@@peer:                                 
08048F08 8060     strh    r0,[r4,2h] 

@@haveblock:                             
08048F0A 4D0B     ldr     r5,=3000738h                            
08048F0C 1C2C     mov     r4,r5                                   
08048F0E 342C     add     r4,2Ch                                  
08048F10 7820     ldrb    r0,[r4]    ;3000764减1h                               
08048F12 3801     sub     r0,1h                                   
08048F14 7020     strb    r0,[r4]    ;再写入                             
08048F16 0600     lsl     r0,r0,18h                               
08048F18 2800     cmp     r0,0h                                   
08048F1A D111     bne     @@nozero                                
08048F1C 2004     mov     r0,4h      ;速度                             
08048F1E F7FFFEC5 bl      8048CACh   ;水平移动的例程                               
08048F22 0600     lsl     r0,r0,18h                               
08048F24 2800     cmp     r0,0h                                   
08048F26 D009     beq     @@noblock                                
08048F28 1C29     mov     r1,r5                                   
08048F2A 3124     add     r1,24h                                  
08048F2C 200A     mov     r0,0Ah                                  
08048F2E 7008     strb    r0,[r1]                                 
08048F30 E006     b       @@nozero                                                          

@@noblock:                               
08048F3C 2002     mov     r0,2h   ;若移动无砖块                               
08048F3E 7020     strb    r0,[r4] ;则30000764写入2h来延迟

@@nozero:                                
08048F40 20A0     mov     r0,0A0h                                 
08048F42 0080     lsl     r0,r0,2h   ;垂直10格                             
08048F44 2140     mov     r1,40h     ;左右1格                             
08048F46 F7C6FF4B bl      CheckSpriteScope                                
08048F4A 2800     cmp     r0,0h      ;只要在左右一格内则结束                             
08048F4C D122     bne     @@end      ;的意思??                          
08048F4E 21A0     mov     r1,0A0h    ;水平5格                             
08048F50 0049     lsl     r1,r1,1h                                
08048F52 20C0     mov     r0,0C0h    ;上下3格                             
08048F54 F7C6FF44 bl      CheckSpriteScope                                
08048F58 1C02     mov     r2,r0                                   
08048F5A 4B07     ldr     r3,=3000738h                            
08048F5C 8819     ldrh    r1,[r3]                                 
08048F5E 2040     mov     r0,40h                                  
08048F60 4008     and     r0,r1                                   
08048F62 2800     cmp     r0,0h                                   
08048F64 D00A     beq     @@faceleft                               
08048F66 2A08     cmp     r2,8h                                   
08048F68 D014     beq     @@end     ;面右在右则结束                           
08048F6A 2A04     cmp     r2,4h                                   
08048F6C D10E     bne     @@outside                                
08048F6E 1C19     mov     r1,r3     ;面右在左                              
08048F70 3124     add     r1,24h                                  
08048F72 200A     mov     r0,0Ah    ;pose写入Ah                              
08048F74 E00D     b       @@peer                                

@@faceleft:                              
08048F7C 2A04     cmp     r2,4h     ;面左在左则结束                               
08048F7E D009     beq     @@end                                
08048F80 2A08     cmp     r2,8h                                   
08048F82 D103     bne     @@outside                                
08048F84 1C19     mov     r1,r3     ;面左在右                              
08048F86 3124     add     r1,24h                                  
08048F88 200A     mov     r0,0Ah                                  
08048F8A E002     b       @@peer

@@outside:                                
08048F8C 1C19     mov     r1,r3                                   
08048F8E 3124     add     r1,24h                                  
08048F90 2008     mov     r0,8h

@@peer:                                   
08048F92 7008     strb    r0,[r1] 

@@end:                                
08048F94 BC30     pop     r4,r5                                   
08048F96 BC01     pop     r0                                      
08048F98 4700     bx      r0                                       

;pose 0ah                               
08048F9C B500     push    r14                                     
08048F9E 490A     ldr     r1,=3000738h                            
08048FA0 1C0A     mov     r2,r1                                   
08048FA2 3224     add     r2,24h                                  
08048FA4 2300     mov     r3,0h                                   
08048FA6 200B     mov     r0,0Bh     ;pose写入0bh                               
08048FA8 7010     strb    r0,[r2]                                 
08048FAA 4808     ldr     r0,=8314294h ;新图片                           
08048FAC 6188     str     r0,[r1,18h]                             
08048FAE 770B     strb    r3,[r1,1Ch]                             
08048FB0 82CB     strh    r3,[r1,16h]                             
08048FB2 8809     ldrh    r1,[r1]                                 
08048FB4 2002     mov     r0,2h                                   
08048FB6 4008     and     r0,r1    ;2 and 取向                               
08048FB8 2800     cmp     r0,0h    ;检查是否在屏幕外                               
08048FBA D002     beq     @@end                                
08048FBC 4804     ldr     r0,=269h  ;转身的水声                              
08048FBE F7B9FDAF bl      PlaySound

@@end:                               
08048FC2 BC01     pop     r0                                      
08048FC4 4700     bx      r0

;pose 0bh                                                                    
08048FD4 B500     push    r14                                     
08048FD6 F7C6FDF7 bl      CheckAnimation                                
08048FDA 2800     cmp     r0,0h                                   
08048FDC D008     beq     @@end                                
08048FDE F7FFFECB bl      8048D78h    ;pose 8h 例程中pose写9h                               
08048FE2 4804     ldr     r0,=3000738h                            
08048FE4 8801     ldrh    r1,[r0]                                 
08048FE6 2240     mov     r2,40h                                  
08048FE8 4051     eor     r1,r2       ;40h eor 取向 换向                              
08048FEA 8001     strh    r1,[r0]                                 
08048FEC F7FFFE46 bl      8048C7Ch    ;左右判定重设 

@@end:                              
08048FF0 BC01     pop     r0                                      
08048FF2 4700     bx      r0                                      

///////////////////////////////////////////////////////////////////////////////////////////////
;主程序
08048FF8 B510     push    r4,r14                                  
08048FFA B081     add     sp,-4h                                  
08048FFC 490E     ldr     r1,=3000738h                            
08048FFE 1C0B     mov     r3,r1                                   
08049000 3332     add     r3,32h                                  
08049002 781A     ldrb    r2,[r3]   ;读取碰撞属性                                
08049004 2402     mov     r4,2h                                   
08049006 1C20     mov     r0,r4                                   
08049008 4010     and     r0,r2     ;2 and                                
0804900A 2800     cmp     r0,0h     ;击中则为2                              
0804900C D00A     beq     @@nohit                                
0804900E 20FD     mov     r0,0FDh                                 
08049010 4010     and     r0,r2     ;FD and 碰撞属性                              
08049012 7018     strb    r0,[r3]                                 
08049014 8809     ldrh    r1,[r1]                                 
08049016 1C20     mov     r0,r4                                   
08049018 4008     and     r0,r1     ;2 and 取向 确认是否在屏幕内                             
0804901A 2800     cmp     r0,0h                                   
0804901C D002     beq     @@nohit                                
0804901E 4807     ldr     r0,=26Ah  ;挨打声                               
08049020 F7B9FD7E bl      PlaySound 

@@nohit:                               
08049024 4C04     ldr     r4,=3000738h                            
08049026 1C20     mov     r0,r4                                   
08049028 3030     add     r0,30h                                  
0804902A 7800     ldrb    r0,[r0]   ;读取冰冻时间                              
0804902C 2800     cmp     r0,0h                                   
0804902E D007     beq     @@nofrozen                                
08049030 F7C6FFDA bl      Frozen                                
08049034 E09F     b       @@end                                

@@nofrozen:                               
08049040 F7C8F91E bl      StunSprite                                
08049044 2800     cmp     r0,0h                                   
08049046 D000     beq     @@nostun                                
08049048 E095     b       @@end 

@@nostun:                               
0804904A 1C20     mov     r0,r4                                   
0804904C 3024     add     r0,24h                                  
0804904E 7800     ldrb    r0,[r0]                                 
08049050 2835     cmp     r0,35h   ;pose如果小于或等于35h跳转                               
08049052 D900     bls     @@nodeath                                
08049054 E085     b       @@overpose  

@@nodeath:                              
08049056 0080     lsl     r0,r0,2h                                
08049058 4901     ldr     r1,=PoseTable                            
0804905A 1840     add     r0,r0,r1                                
0804905C 6800     ldr     r0,[r0]                                 
0804905E 4687     mov     r15,r0 

PoseTable:
    .word 804913ch ;00
    .word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h
	.word 8049142h ;08h
	.word 8049148h ;09h
	.word 804914eh ;0ah
    .word 8049152h ;0bh
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049162h .word 8049162h .word 8049162h .word 8049162h
	.word 8049158h ;34h
	.word 804915ch ;35h
    	                 
0804913C F7FFFDE8 bl      8048D10h  ;00	                              
08049140 E019     b       @@end                                
08049142 F7FFFE19 bl      8048D78h  ;08h                              
08049146 E016     b       @@end                                
08049148 F7FFFE2E bl      8048DA8h  ;09h                              
0804914C E013     b       @@end                                
0804914E F7FFFF25 bl      8048F9Ch  ;0ah                              
08049152 F7FFFF3F bl      8048FD4h  ;0bh                              
08049156 E00E     b       @@end                                
08049158 F7FFFE88 bl      8048E6Ch  ;34h                              
0804915C F7FFFE96 bl      8048E8Ch  ;35h                              
08049160 E009     b       @@end

@@overpose:                                
08049162 4807     ldr     r0,=3000738h                            
08049164 8841     ldrh    r1,[r0,2h]                              
08049166 3920     sub     r1,20h      ;Y坐标上移半格的坐标                            
08049168 8882     ldrh    r2,[r0,4h]                              
0804916A 2021     mov     r0,21h                                  
0804916C 9000     str     r0,[sp]                                 
0804916E 2000     mov     r0,0h                                   
08049170 2301     mov     r3,1h                                   
08049172 F7C7FF87 bl      DeathFireworks 

@@end:                               
08049176 B001     add     sp,4h                                   
08049178 BC10     pop     r4                                      
0804917A BC01     pop     r0                                      
0804917C 4700     bx      r0
