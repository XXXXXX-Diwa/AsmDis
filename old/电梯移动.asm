

08009B28 B570     push    r4-r6,r14                               
08009B2A 1C04     mov     r4,r0                                   
08009B2C 7F60     ldrb    r0,[r4,1Dh]                             
08009B2E 2800     cmp     r0,0h          ;当前动画不等于0的话跳转                         
08009B30 D139     bne     @@end                                
08009B32 2600     mov     r6,0h                                   
08009B34 8AA0     ldrh    r0,[r4,14h]    ;读取Y坐标和Y速度                         
08009B36 8B21     ldrh    r1,[r4,18h]                             
08009B38 1A40     sub     r0,r0,r1                                
08009B3A 82A0     strh    r0,[r4,14h]    ;写入Y坐标                         
08009B3C 8AA0     ldrh    r0,[r4,14h]                             
08009B3E 8A61     ldrh    r1,[r4,12h]                             
08009B40 F04EFA9E bl      8058080h                                
08009B44 1405     asr     r5,r0,10h                               
08009B46 8A21     ldrh    r1,[r4,10h]                             
08009B48 2040     mov     r0,40h                                  
08009B4A 4008     and     r0,r1                                   
08009B4C 2800     cmp     r0,0h                                   
08009B4E D011     beq     8009B74h                                
08009B50 4807     ldr     r0,=3001602h                            
08009B52 8800     ldrh    r0,[r0]                                 
08009B54 8A61     ldrh    r1,[r4,12h]                             
08009B56 F04EFA93 bl      8058080h                                
08009B5A 1400     asr     r0,r0,10h                               
08009B5C 2D01     cmp     r5,1h                                   
08009B5E D015     beq     8009B8Ch                                
08009B60 2801     cmp     r0,1h                                   
08009B62 D113     bne     8009B8Ch                                
08009B64 8AA1     ldrh    r1,[r4,14h]                             
08009B66 203F     mov     r0,3Fh                                  
08009B68 4308     orr     r0,r1                                   
08009B6A 82A0     strh    r0,[r4,14h]                             
08009B6C E010     b       8009B90h                                
08009B6E 0000     lsl     r0,r0,0h                                
08009B70 1602     asr     r2,r0,18h                               
08009B72 0300     lsl     r0,r0,0Ch                               
08009B74 2080     mov     r0,80h                                  
08009B76 4008     and     r0,r1                                   
08009B78 2800     cmp     r0,0h                                   
08009B7A D007     beq     8009B8Ch                                
08009B7C 2D02     cmp     r5,2h                                   
08009B7E D105     bne     8009B8Ch                                
08009B80 8AA1     ldrh    r1,[r4,14h]                             
08009B82 480B     ldr     r0,=0FFC0h                              
08009B84 4008     and     r0,r1                                   
08009B86 3801     sub     r0,1h                                   
08009B88 82A0     strh    r0,[r4,14h]                             
08009B8A 2601     mov     r6,1h                                   
08009B8C 2E00     cmp     r6,0h                                   
08009B8E D00A     beq     8009BA6h                                
08009B90 7F60     ldrb    r0,[r4,1Dh]                             
08009B92 3001     add     r0,1h                                   
08009B94 2100     mov     r1,0h                                   
08009B96 7760     strb    r0,[r4,1Dh]                             
08009B98 7721     strb    r1,[r4,1Ch]                             
08009B9A 8321     strh    r1,[r4,18h]                             
08009B9C 2087     mov     r0,87h                                  
08009B9E 0040     lsl     r0,r0,1h                                
08009BA0 210A     mov     r1,0Ah       ;坐电梯声音                              
08009BA2 F7F9F86D bl      8002C80h 

@@end:                               
08009BA6 20FF     mov     r0,0FFh                                 
08009BA8 BC70     pop     r4-r6                                   
08009BAA BC02     pop     r1                                      
08009BAC 4708     bx      r1  

/////////////////////////////////////////////////////////////////////////////

08058080 B510     push    r4,r14                                  
08058082 0400     lsl     r0,r0,10h                               
08058084 0C04     lsr     r4,r0,10h      ;Y要移动的坐标	                         
08058086 0409     lsl     r1,r1,10h      ;X                         
08058088 4B07     ldr     r3,=30000DCh                            
0805808A 2200     mov     r2,0h                                   
0805808C 801A     strh    r2,[r3]                                 
0805808E 805A     strh    r2,[r3,2h]                              
08058090 0D83     lsr     r3,r0,16h      ;Y要移动的格数                         
08058092 0D8A     lsr     r2,r1,16h      ;X的格数                         
08058094 4805     ldr     r0,=300009Ch                            
08058096 8BC1     ldrh    r1,[r0,1Eh]                             
08058098 428B     cmp     r3,r1          ;当前要移动的Y格数                          
0805809A D202     bcs     @@Miss       ;和房间最高格数相比,如果大于等于                         
0805809C 8B80     ldrh    r0,[r0,1Ch]                             
0805809E 4282     cmp     r2,r0          ;当前要移动的X格数                        
080580A0 D306     bcc     @@InRoom       ;和房间最高宽度相比,如果小于等于

@@Miss:                              
080580A2 2000     mov     r0,0h                                   
080580A4 E009     b       @@end                                

@@InRoom:                               
080580B0 1C20     mov     r0,r4          ;Y要移动的坐标                         
080580B2 1C19     mov     r1,r3          ;Y要移动的格数                         
080580B4 2300     mov     r3,0h                                   
080580B6 F000F803 bl      80580C0h

@@end:                                
080580BA BC10     pop     r4                                      
080580BC BC02     pop     r1                                      
080580BE 4708     bx      r1

                                      
080580C0 B5F0     push    r4-r7,r14                               
080580C2 0400     lsl     r0,r0,10h                               
080580C4 0C07     lsr     r7,r0,10h     ;Y要移动的坐标                           
080580C6 0409     lsl     r1,r1,10h                               
080580C8 0C09     lsr     r1,r1,10h     ;Y要移动的格数                          
080580CA 0412     lsl     r2,r2,10h                               
080580CC 0C12     lsr     r2,r2,10h     ;X要移动的格数                          
080580CE 061B     lsl     r3,r3,18h                               
080580D0 0E1E     lsr     r6,r3,18h     ;设置值 0                          
080580D2 4C0B     ldr     r4,=3005450h                            
080580D4 4B0B     ldr     r3,=300009Ch                            
080580D6 8B98     ldrh    r0,[r3,1Ch]   ;最大宽度格数                          
080580D8 4348     mul     r0,r1         ;要移动的格数                          
080580DA 1880     add     r0,r0,r2      ;加上X的格数                          
080580DC 6999     ldr     r1,[r3,18h]   ;得到clip偏移指针                          
080580DE 0040     lsl     r0,r0,1h      ;总值乘以2                          
080580E0 1840     add     r0,r0,r1      ;加上偏移值                          
080580E2 8800     ldrh    r0,[r0]       ;读取Clip值                          
080580E4 68A1     ldr     r1,[r4,8h]    ;读取clip行为偏移指针                          
080580E6 0040     lsl     r0,r0,1h      ;CLIP序号乘以2                          
080580E8 1840     add     r0,r0,r1      ;加上clip行为偏移指针                          
080580EA 8805     ldrh    r5,[r0]       ;读取clip的行为值                          
080580EC 2D00     cmp     r5,0h                                   
080580EE D00D     beq     @@ClipBehaviorZero                                
080580F0 2D0F     cmp     r5,0Fh                                  
080580F2 DC0B     bgt     @@ClipBehaviorZero                                
080580F4 4904     ldr     r1,=83458E4h                            
080580F6 0068     lsl     r0,r5,1h      ;行为值乘以2                           
080580F8 1840     add     r0,r0,r1      ;加上偏移值                          
080580FA 8804     ldrh    r4,[r0]                                 
080580FC E007     b       805810Eh                                
080580FE 0000     lsl     r0,r0,0h                                
08058100 5450     strb    r0,[r2,r1]                              
08058102 0300     lsl     r0,r0,0Ch                               
08058104 009C     lsl     r4,r3,2h                                
08058106 0300     lsl     r0,r0,0Ch                               
08058108 58E4     ldr     r4,[r4,r3]                              
0805810A 0834     lsr     r4,r6,20h  

@@ClipBehaviorZero:                             
0805810C 2400     mov     r4,0h                                   
0805810E 2E00     cmp     r6,0h         ;设置值                          
08058110 D10C     bne     @@Pass                                
08058112 1E60     sub     r0,r4,1                                 
08058114 2801     cmp     r0,1h                                   
08058116 D809     bhi     @@Pass                                
08058118 480A     ldr     r0,=30013D4h                            
0805811A 7800     ldrb    r0,[r0]                                 
0805811C 281D     cmp     r0,1Dh        ;姿势是1Dh                            
0805811E D005     beq     @@Pass                                
08058120 1C20     mov     r0,r4                                   
08058122 F000F83B bl      805819Ch                                
08058126 2800     cmp     r0,0h                                   
08058128 D000     beq     @@Pass                                
0805812A 2400     mov     r4,0h       

@@Pass:                            
0805812C 4806     ldr     r0,=30000DCh                            
0805812E 8004     strh    r4,[r0]                                 
08058130 2400     mov     r4,0h                                   
08058132 1C2A     mov     r2,r5                                   
08058134 3A40     sub     r2,40h                                  
08058136 1C05     mov     r5,r0                                   
08058138 2A03     cmp     r2,3h                                   
0805813A D809     bhi     8058150h                                
0805813C 4903     ldr     r1,=8345924h                            
0805813E 0050     lsl     r0,r2,1h                                
08058140 1840     add     r0,r0,r1                                
08058142 E022     b       805818Ah                                
08058144 13D4     asr     r4,r2,0Fh                               
08058146 0300     lsl     r0,r0,0Ch                               
08058148 00DC     lsl     r4,r3,3h                                
0805814A 0300     lsl     r0,r0,0Ch                               
0805814C 5924     ldr     r4,[r4,r4]                              
0805814E 0834     lsr     r4,r6,20h                               
08058150 490A     ldr     r1,=30000BCh                            
08058152 7848     ldrb    r0,[r1,1h]                              
08058154 2800     cmp     r0,0h                                   
08058156 D019     beq     805818Ch                                
08058158 7D08     ldrb    r0,[r1,14h]                             
0805815A 2800     cmp     r0,0h                                   
0805815C D016     beq     805818Ch                                
0805815E 2807     cmp     r0,7h                                   
08058160 D814     bhi     805818Ch                                
08058162 4B07     ldr     r3,=8345904h                            
08058164 0081     lsl     r1,r0,2h                                
08058166 1C98     add     r0,r3,2                                 
08058168 180A     add     r2,r1,r0                                
0805816A 8810     ldrh    r0,[r2]                                 
0805816C 2800     cmp     r0,0h                                   
0805816E D00B     beq     8058188h                                
08058170 4804     ldr     r0,=300006Ch                            
08058172 8800     ldrh    r0,[r0]                                 
08058174 42B8     cmp     r0,r7                                   
08058176 D807     bhi     8058188h                                
08058178 8814     ldrh    r4,[r2]                                 
0805817A E007     b       805818Ch                                
0805817C 00BC     lsl     r4,r7,2h                                
0805817E 0300     lsl     r0,r0,0Ch                               
08058180 5904     ldr     r4,[r0,r4]                              
08058182 0834     lsr     r4,r6,20h                               
08058184 006C     lsl     r4,r5,1h                                
08058186 0300     lsl     r0,r0,0Ch                               
08058188 18C8     add     r0,r1,r3                                
0805818A 8804     ldrh    r4,[r0]                                 
0805818C 806C     strh    r4,[r5,2h]                              
0805818E 8828     ldrh    r0,[r5]                                 
08058190 0400     lsl     r0,r0,10h                               
08058192 8869     ldrh    r1,[r5,2h]                              
08058194 4308     orr     r0,r1                                   
08058196 BCF0     pop     r4-r7                                   
08058198 BC02     pop     r1                                      
0805819A 4708     bx      r1 

                                     
0805819C B5F0     push    r4-r7,r14                               
0805819E 464F     mov     r7,r9                                   
080581A0 4646     mov     r6,r8                                   
080581A2 B4C0     push    r6,r7                                   
080581A4 480E     ldr     r0,=3000198h                            
080581A6 2100     mov     r1,0h                                   
080581A8 7081     strb    r1,[r0,2h]                              
080581AA 2200     mov     r2,0h                                   
080581AC 8001     strh    r1,[r0]                                 
080581AE 70C2     strb    r2,[r0,3h]                              
080581B0 2400     mov     r4,0h                                   
080581B2 2508     mov     r5,8h                                   
080581B4 480B     ldr     r0,=3000054h                            
080581B6 4681     mov     r9,r0                                   
080581B8 490B     ldr     r1,=8345934h                            
080581BA 4688     mov     r8,r1                                   
080581BC 4646     mov     r6,r8                                   
080581BE 3644     add     r6,44h                                  
080581C0 2740     mov     r7,40h                                  
080581C2 4808     ldr     r0,=3000054h                            
080581C4 4908     ldr     r1,=8345934h                            
080581C6 1879     add     r1,r7,r1                                
080581C8 7800     ldrb    r0,[r0]                                 
080581CA 780A     ldrb    r2,[r1]                                 
080581CC 4290     cmp     r0,r2                                   
080581CE D10F     bne     80581F0h                                
080581D0 4806     ldr     r0,=3000055h                            
080581D2 7800     ldrb    r0,[r0]                                 
080581D4 7849     ldrb    r1,[r1,1h]                              
080581D6 4288     cmp     r0,r1                                   
080581D8 D10A     bne     80581F0h                                
080581DA 2401     mov     r4,1h                                   
080581DC E016     b       805820Ch                                
080581DE 0000     lsl     r0,r0,0h                                
080581E0 0198     lsl     r0,r3,6h                                
080581E2 0300     lsl     r0,r0,0Ch                               
080581E4 0054     lsl     r4,r2,1h                                
080581E6 0300     lsl     r0,r0,0Ch                               
080581E8 5934     ldr     r4,[r6,r4]                              
080581EA 0834     lsr     r4,r6,20h                               
080581EC 0055     lsl     r5,r2,1h                                
080581EE 0300     lsl     r0,r0,0Ch                               
080581F0 4649     mov     r1,r9                                   
080581F2 7808     ldrb    r0,[r1]                                 
080581F4 7832     ldrb    r2,[r6]                                 
080581F6 4290     cmp     r0,r2                                   
080581F8 D106     bne     8058208h                                
080581FA 480B     ldr     r0,=3000055h                            
080581FC 7800     ldrb    r0,[r0]                                 
080581FE 7871     ldrb    r1,[r6,1h]                              
08058200 4288     cmp     r0,r1                                   
08058202 D101     bne     8058208h                                
08058204 2401     mov     r4,1h                                   
08058206 4264     neg     r4,r4                                   
08058208 2C00     cmp     r4,0h                                   
0805820A D019     beq     8058240h                                
0805820C 2D08     cmp     r5,8h                                   
0805820E D10E     bne     805822Eh                                
08058210 2003     mov     r0,3h                                   
08058212 2141     mov     r1,41h                                  
08058214 F008FB52 bl      80608BCh                                
08058218 2800     cmp     r0,0h                                   
0805821A D007     beq     805822Ch                                
0805821C 4646     mov     r6,r8                                   
0805821E 3634     add     r6,34h                                  
08058220 2730     mov     r7,30h                                  
08058222 2506     mov     r5,6h                                   
08058224 E003     b       805822Eh                                
08058226 0000     lsl     r0,r0,0h                                
08058228 0055     lsl     r5,r2,1h                                
0805822A 0300     lsl     r0,r0,0Ch                               
0805822C 2400     mov     r4,0h                                   
0805822E 2C00     cmp     r4,0h                                   
08058230 D006     beq     8058240h                                
08058232 4802     ldr     r0,=3000198h                            
08058234 7085     strb    r5,[r0,2h]                              
08058236 70C4     strb    r4,[r0,3h]                              
08058238 E007     b       805824Ah                                
0805823A 0000     lsl     r0,r0,0h                                
0805823C 0198     lsl     r0,r3,6h                                
0805823E 0300     lsl     r0,r0,0Ch                               
08058240 3E08     sub     r6,8h                                   
08058242 3F08     sub     r7,8h                                   
08058244 3D01     sub     r5,1h                                   
08058246 2D00     cmp     r5,0h                                   
08058248 DCBB     bgt     80581C2h                                
0805824A 2000     mov     r0,0h                                   
0805824C 2C00     cmp     r4,0h                                   
0805824E D100     bne     8058252h                                
08058250 2001     mov     r0,1h                                   
08058252 1C04     mov     r4,r0                                   
08058254 BC18     pop     r3,r4                                   
08058256 4698     mov     r8,r3                                   
08058258 46A1     mov     r9,r4                                   
0805825A BCF0     pop     r4-r7                                   
0805825C BC02     pop     r1                                      
0805825E 4708     bx      r1                                      
08058260 B500     push    r14                                     
08058262 0400     lsl     r0,r0,10h                               
08058264 0409     lsl     r1,r1,10h                               
08058266 0D83     lsr     r3,r0,16h                               
08058268 0D89     lsr     r1,r1,16h                               
0805826A 4A04     ldr     r2,=300009Ch                            
0805826C 8BD0     ldrh    r0,[r2,1Eh]                             
0805826E 4283     cmp     r3,r0                                   
08058270 DA02     bge     8058278h                                
08058272 8B90     ldrh    r0,[r2,1Ch]                             
08058274 4281     cmp     r1,r0                                   
08058276 DB03     blt     8058280h                                
08058278 2000     mov     r0,0h                                   
0805827A E021     b       80582C0h                                
0805827C 009C     lsl     r4,r3,2h                                
0805827E 0300     lsl     r0,r0,0Ch                               

