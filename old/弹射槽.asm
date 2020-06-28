;生产5个砖块的例程
080268BC B570     push    r4-r6,r14                               
080268BE 4656     mov     r6,r10                                  
080268C0 464D     mov     r5,r9                                   
080268C2 4644     mov     r4,r8                                   
080268C4 B470     push    r4-r6                                   
080268C6 1C04     mov     r4,r0                                   
080268C8 0624     lsl     r4,r4,18h                               
080268CA 0E24     lsr     r4,r4,18h                               
080268CC 4816     ldr     r0,=3000738h                            
080268CE 8841     ldrh    r1,[r0,2h]                              
080268D0 4688     mov     r8,r1                                   
080268D2 8880     ldrh    r0,[r0,4h]                              
080268D4 4682     mov     r10,r0                                  
080268D6 4D15     ldr     r5,=3000079h                            
080268D8 702C     strb    r4,[r5]                                 
080268DA 2040     mov     r0,40h                                  
080268DC 4450     add     r0,r10                                  
080268DE 4681     mov     r9,r0                                   
080268E0 4640     mov     r0,r8                                   
080268E2 4649     mov     r1,r9                                   
080268E4 F031FACA bl      8057E7Ch                                
080268E8 702C     strb    r4,[r5]                                 
080268EA 4646     mov     r6,r8                                   
080268EC 3640     add     r6,40h                                  
080268EE 1C30     mov     r0,r6                                   
080268F0 4649     mov     r1,r9                                   
080268F2 F031FAC3 bl      8057E7Ch                                
080268F6 702C     strb    r4,[r5]                                 
080268F8 2140     mov     r1,40h                                  
080268FA 4249     neg     r1,r1                                   
080268FC 4451     add     r1,r10                                  
080268FE 4689     mov     r9,r1                                   
08026900 4640     mov     r0,r8                                   
08026902 F031FABB bl      8057E7Ch                                
08026906 702C     strb    r4,[r5]                                 
08026908 1C30     mov     r0,r6                                   
0802690A 4649     mov     r1,r9                                   
0802690C F031FAB6 bl      8057E7Ch                                
08026910 702C     strb    r4,[r5]                                 
08026912 1C30     mov     r0,r6                                   
08026914 4651     mov     r1,r10                                  
08026916 F031FAB1 bl      8057E7Ch                                
0802691A BC38     pop     r3-r5                                   
0802691C 4698     mov     r8,r3                                   
0802691E 46A1     mov     r9,r4                                   
08026920 46AA     mov     r10,r5                                  
08026922 BC70     pop     r4-r6                                   
08026924 BC01     pop     r0                                      
08026926 4700     bx      r0 



;pose 0
08026930 B510     push    r4,r14                                  
08026932 B083     add     sp,-0Ch                                 
08026934 4820     ldr     r0,=3000738h                            
08026936 4684     mov     r12,r0                                  
08026938 8840     ldrh    r0,[r0,2h]     ;读取Y坐标                         
0802693A 3820     sub     r0,20h         ;向上提升半格的高度                         
0802693C 2200     mov     r2,0h                                   
0802693E 2400     mov     r4,0h                                   
08026940 4661     mov     r1,r12                                  
08026942 8048     strh    r0,[r1,2h]     ;再写入                         
08026944 814C     strh    r4,[r1,0Ah]    ;上部分界为0                         
08026946 818C     strh    r4,[r1,0Ch]                             
08026948 81CC     strh    r4,[r1,0Eh]                             
0802694A 820C     strh    r4,[r1,10h]    ;四面分界都为0                         
0802694C 3127     add     r1,27h                                  
0802694E 2008     mov     r0,8h                                   
08026950 7008     strb    r0,[r1]        ;300075f写入8h                         
08026952 4660     mov     r0,r12                                  
08026954 3028     add     r0,28h                                  
08026956 2120     mov     r1,20h                                  
08026958 7001     strb    r1,[r0]        ;3000760写入20h                         
0802695A 3001     add     r0,1h                                   
0802695C 7001     strb    r1,[r0]        ;3000761写入20h                         
0802695E 3804     sub     r0,4h                                   
08026960 7002     strb    r2,[r0]        ;属性写入0                         
08026962 4816     ldr     r0,=82DE0F8h                            
08026964 4661     mov     r1,r12                                  
08026966 6188     str     r0,[r1,18h]    ;写入OAM                         
08026968 770A     strb    r2,[r1,1Ch]                             
0802696A 82CC     strh    r4,[r1,16h]                             
0802696C 3124     add     r1,24h         ;pose写入9h                         
0802696E 2009     mov     r0,9h                                   
08026970 7008     strb    r0,[r1]                                 
08026972 4813     ldr     r0,=3000088h                            
08026974 7B01     ldrb    r1,[r0,0Ch]    ;读取3000094的值                         
08026976 2203     mov     r2,3h                                   
08026978 2003     mov     r0,3h                                   
0802697A 4008     and     r0,r1          ;和3 and                          
0802697C 3001     add     r0,1h          ;加1                         
0802697E 4010     and     r0,r2          ;再和3 and                         
08026980 4661     mov     r1,r12                                  
08026982 3121     add     r1,21h                                  
08026984 7008     strb    r0,[r1]        ;写入3000759h                         
08026986 3101     add     r1,1h                                   
08026988 2002     mov     r0,2h                                   
0802698A 7008     strb    r0,[r1]        ;300075a写入2                          
0802698C 4660     mov     r0,r12                                  
0802698E 7FC2     ldrb    r2,[r0,1Fh]    ;读取gfx row                          
08026990 3023     add     r0,23h                                  
08026992 7803     ldrb    r3,[r0]        ;主精灵序号                          
08026994 4661     mov     r1,r12                                  
08026996 8848     ldrh    r0,[r1,2h]     ;Y坐标                         
08026998 9000     str     r0,[sp]                                 
0802699A 8888     ldrh    r0,[r1,4h]                              
0802699C 9001     str     r0,[sp,4h]                              
0802699E 9402     str     r4,[sp,8h]                              
080269A0 2024     mov     r0,24h                                  
080269A2 2100     mov     r1,0h                                   
080269A4 F7E7FC58 bl      800E258h       ;生产第二精灵                         
080269A8 2004     mov     r0,4h                                   
080269AA F7FFFF87 bl      80268BCh       ;生产砖块                         
080269AE B003     add     sp,0Ch                                  
080269B0 BC10     pop     r4                                      
080269B2 BC01     pop     r0                                      
080269B4 4700     bx      r0                                      

;pose 9                               
080269C4 B5F0     push    r4-r7,r14                               
080269C6 4647     mov     r7,r8                                   
080269C8 B480     push    r7                                      
080269CA 2600     mov     r6,0h                                   
080269CC 4916     ldr     r1,=3000738h                            
080269CE 8848     ldrh    r0,[r1,2h]      ;Y坐标                        
080269D0 3020     add     r0,20h          ;向下半格                        
080269D2 0400     lsl     r0,r0,10h                               
080269D4 0C05     lsr     r5,r0,10h                               
080269D6 8888     ldrh    r0,[r1,4h]      ;X坐标                        
080269D8 4684     mov     r12,r0                                  
080269DA 2400     mov     r4,0h                                   
080269DC 4688     mov     r8,r1                                   
080269DE 4F13     ldr     r7,=3000A2Ch    ;放了炸弹为B,炸弹爆炸F 

@@Loop:                          
080269E0 00E0     lsl     r0,r4,3h                                
080269E2 1B00     sub     r0,r0,r4                                
080269E4 0080     lsl     r0,r0,2h                                
080269E6 19C2     add     r2,r0,r7                                
080269E8 7811     ldrb    r1,[r2]                                 
080269EA 2001     mov     r0,1h                                   
080269EC 4008     and     r0,r1                                   
080269EE 2800     cmp     r0,0h                                   
080269F0 D01E     beq     @@Pass          ;没放炸弹???                      
080269F2 7BD0     ldrb    r0,[r2,0Fh]     ;3000a3b                        
080269F4 280E     cmp     r0,0Eh          ;如果放了超炸则为F                        
080269F6 D11B     bne     @@Pass                                
080269F8 7C50     ldrb    r0,[r2,11h]     ;3000a3d的值                        
080269FA 2801     cmp     r0,1h           ;炸弹的三个节奏,以此1-2-3递增                        
080269FC D118     bne     @@Pass                                
080269FE 8911     ldrh    r1,[r2,8h]      ;读取3000a34   炸弹Y坐标                     
08026A00 8953     ldrh    r3,[r2,0Ah]     ;读取3000a36   炸弹X坐标                    
08026A02 42A9     cmp     r1,r5           ;炸弹Y坐标和精灵Y坐标比较                        
08026A04 D214     bcs     @@Pass          ;如果大于等于跳过                      
08026A06 1C28     mov     r0,r5                                   
08026A08 3808     sub     r0,8h           ;和精灵Y坐标向上8h比较                        
08026A0A 4281     cmp     r1,r0                                   
08026A0C DD10     ble     @@Pass          ;小于等于跳过                      
08026A0E 4660     mov     r0,r12                                  
08026A10 3008     add     r0,8h           ;精灵X坐标加8h                        
08026A12 4283     cmp     r3,r0           ;炸弹坐与之比较                         
08026A14 DA0C     bge     @@Pass          ;大于等于跳过                      
08026A16 3810     sub     r0,10h                                  
08026A18 4283     cmp     r3,r0           ;炸弹X坐标和精灵X减8h坐标比较                         
08026A1A DD09     ble     @@Pass          ;小于等于跳过                      
08026A1C 2004     mov     r0,4h                                   
08026A1E 7450     strb    r0,[r2,11h]     ;3000a3d写入4h                        
08026A20 1C70     add     r0,r6,1         ;标记为1                        
08026A22 0600     lsl     r0,r0,18h                               
08026A24 0E06     lsr     r6,r0,18h                               
08026A26 E008     b       @@Peer                                

@@Pass:                               
08026A30 1C60     add     r0,r4,1         ;累计值加1                        
08026A32 0600     lsl     r0,r0,18h                               
08026A34 0E04     lsr     r4,r0,18h                               
08026A36 2C0F     cmp     r4,0Fh          ;如果炸弹没有超过15个则继续循环                        
08026A38 D9D2     bls     @@Loop 

@@Peer:                               
08026A3A 2E00     cmp     r6,0h                                   
08026A3C D006     beq     @@end                                
08026A3E 4641     mov     r1,r8                                   
08026A40 3124     add     r1,24h          ;pose写入OBh                         
08026A42 200B     mov     r0,0Bh                                  
08026A44 7008     strb    r0,[r1]                                 
08026A46 3108     add     r1,8h                                   
08026A48 2020     mov     r0,20h                                  
08026A4A 7008     strb    r0,[r1]         ;3000764写入20h

@@end:                                
08026A4C BC08     pop     r3                                      
08026A4E 4698     mov     r8,r3                                   
08026A50 BCF0     pop     r4-r7                                   
08026A52 BC01     pop     r0                                      
08026A54 4700     bx      r0                                      


;pose b                               
08026A58 B510     push    r4,r14                                  
08026A5A 4B0D     ldr     r3,=3000738h                            
08026A5C 1C1C     mov     r4,r3                                   
08026A5E 342C     add     r4,2Ch                                  
08026A60 7820     ldrb    r0,[r4]        ;读取3000764的值                             
08026A62 3801     sub     r0,1h          ;减1                         
08026A64 7020     strb    r0,[r4]        ;再写入                         
08026A66 0600     lsl     r0,r0,18h                               
08026A68 0E01     lsr     r1,r0,18h                               
08026A6A 2900     cmp     r1,0h                                   
08026A6C D10D     bne     @@end                                
08026A6E 4809     ldr     r0,=82DE120h                            
08026A70 6198     str     r0,[r3,18h]    ;写入新OAM                         
08026A72 7719     strb    r1,[r3,1Ch]                             
08026A74 2200     mov     r2,0h                                   
08026A76 82D9     strh    r1,[r3,16h]                             
08026A78 1C19     mov     r1,r3                                   
08026A7A 3124     add     r1,24h         ;Pose写入0Ch                          
08026A7C 200C     mov     r0,0Ch                                  
08026A7E 7008     strb    r0,[r1]                                 
08026A80 203C     mov     r0,3Ch                                  
08026A82 7020     strb    r0,[r4]       ;3000764写入3Ch                          
08026A84 1C18     mov     r0,r3                                   
08026A86 302D     add     r0,2Dh                                  
08026A88 7002     strb    r2,[r0]       ;3000765写入0h

@@end:                                
08026A8A BC10     pop     r4                                      
08026A8C BC01     pop     r0                                      
08026A8E 4700     bx      r0                                      


;pose C                              
08026A98 B530     push    r4,r5,r14                               
08026A9A B083     add     sp,-0Ch                                 
08026A9C 4B17     ldr     r3,=3000738h                            
08026A9E 1C1D     mov     r5,r3                                   
08026AA0 352D     add     r5,2Dh       ;读取3000765的值                           
08026AA2 782C     ldrb    r4,[r5]                                 
08026AA4 2C00     cmp     r4,0h                                   
08026AA6 D113     bne     @@Pass       ;不为零跳转                         
08026AA8 4915     ldr     r1,=30013D4h                            
08026AAA 7808     ldrb    r0,[r1]                                 
08026AAC 2825     cmp     r0,25h       ;读取pose 是否是25h 球冲刺之前的动作                           
08026AAE D10F     bne     @@Pass       ;如果不是则跳转                         
08026AB0 7FDA     ldrb    r2,[r3,1Fh]  ;读取GFX                           
08026AB2 1C18     mov     r0,r3                                   
08026AB4 3023     add     r0,23h                                  
08026AB6 7803     ldrb    r3,[r0]                                 
08026AB8 8A88     ldrh    r0,[r1,14h]                             
08026ABA 3810     sub     r0,10h                                  
08026ABC 9000     str     r0,[sp]                                 
08026ABE 8A48     ldrh    r0,[r1,12h]                             
08026AC0 9001     str     r0,[sp,4h]                              
08026AC2 9402     str     r4,[sp,8h]                              
08026AC4 2024     mov     r0,24h                                  
08026AC6 2101     mov     r1,1h                                   
08026AC8 F7E7FBC6 bl      800E258h    ;生产副精灵24-2                             
08026ACC 2001     mov     r0,1h                                   
08026ACE 7028     strb    r0,[r5]     ;3000765写入1h

@@Pass:                                
08026AD0 4A0A     ldr     r2,=3000738h                            
08026AD2 1C11     mov     r1,r2                                   
08026AD4 312C     add     r1,2Ch                                  
08026AD6 7808     ldrb    r0,[r1]     ;读取3000764的值                             
08026AD8 3801     sub     r0,1h       ;减1再写入                            
08026ADA 7008     strb    r0,[r1]                                 
08026ADC 0600     lsl     r0,r0,18h                               
08026ADE 0E01     lsr     r1,r0,18h                               
08026AE0 2900     cmp     r1,0h                                   
08026AE2 D107     bne     @@end                                
08026AE4 4807     ldr     r0,=82DE0F8h                            
08026AE6 6190     str     r0,[r2,18h]  ;写入新的OAM                           
08026AE8 7711     strb    r1,[r2,1Ch]                             
08026AEA 82D1     strh    r1,[r2,16h]                             
08026AEC 1C11     mov     r1,r2                                   
08026AEE 3124     add     r1,24h       ;pose返回9h                             
08026AF0 2009     mov     r0,9h                                   
08026AF2 7008     strb    r0,[r1]  

@@end:                               
08026AF4 B003     add     sp,0Ch                                  
08026AF6 BC30     pop     r4,r5                                   
08026AF8 BC01     pop     r0                                      
08026AFA 4700     bx      r0                                      



;主程序                              
08026B08 B500     push    r14                                     
08026B0A 4807     ldr     r0,=3000738h                            
08026B0C 1C02     mov     r2,r0                                   
08026B0E 3226     add     r2,26h                                  
08026B10 2101     mov     r1,1h                                   
08026B12 7011     strb    r1,[r2]      ;300075e写入1                               
08026B14 3024     add     r0,24h                                  
08026B16 7800     ldrb    r0,[r0]      ;读取pose                           
08026B18 2809     cmp     r0,9h                                   
08026B1A D00F     beq     @@Pose9                                
08026B1C 2809     cmp     r0,9h                                   
08026B1E DC05     bgt     @@MoreThan9                                
08026B20 2800     cmp     r0,0h                                   
08026B22 D008     beq     @@Pose0                                
08026B24 E012     b       @@end                                

@@MoreThan9:                               
08026B2C 280B     cmp     r0,0Bh                                  
08026B2E D008     beq     @@Poseb                                
08026B30 280C     cmp     r0,0Ch                                  
08026B32 D009     beq     @@Posec                                
08026B34 E00A     b       @@end

@@Pose0:                                
08026B36 F7FFFEFB bl      8026930h                                
08026B3A E007     b       @@end  

@@Pose9:                              
08026B3C F7FFFF42 bl      80269C4h                                
08026B40 E004     b       @@end   

@@Poseb:                             
08026B42 F7FFFF89 bl      8026A58h                                
08026B46 E001     b       @@end  

@@Posec:                              
08026B48 F7FFFFA6 bl      8026A98h 

@@end:                               
08026B4C BC01     pop     r0                                      
08026B4E 4700     bx      r0 
////////////////////////////////////////////////////////////////////////////
;副精灵主程序                                     
08026B50 B570     push    r4-r6,r14                               
08026B52 4B04     ldr     r3,=3000738h                            
08026B54 1C1E     mov     r6,r3                                   
08026B56 3624     add     r6,24h                                  
08026B58 7832     ldrb    r2,[r6]        ;读取pose                          
08026B5A 2A00     cmp     r2,0h                                   
08026B5C D004     beq     @@Pose0                                
08026B5E 2A0B     cmp     r2,0Bh                                  
08026B60 D05C     beq     @@PoseB                                
08026B62 E065     b       @@end                                

@@Pose0:                              
08026B68 8818     ldrh    r0,[r3]                                 
08026B6A 2480     mov     r4,80h                                  
08026B6C 0224     lsl     r4,r4,8h       ;8000h                          
08026B6E 1C21     mov     r1,r4                                   
08026B70 2500     mov     r5,0h                                   
08026B72 4301     orr     r1,r0          ;orr 取向                            
08026B74 4815     ldr     r0,=0FFFBh                              
08026B76 4001     and     r1,r0          ;再去掉4                         
08026B78 8019     strh    r1,[r3]        ;再写入                         
08026B7A 1C18     mov     r0,r3                                   
08026B7C 3025     add     r0,25h                                  
08026B7E 7005     strb    r5,[r0]        ;属性写入0h                          
08026B80 82DA     strh    r2,[r3,16h]                             
08026B82 771D     strb    r5,[r3,1Ch]                             
08026B84 815A     strh    r2,[r3,0Ah]                             
08026B86 819A     strh    r2,[r3,0Ch]                             
08026B88 81DA     strh    r2,[r3,0Eh]                             
08026B8A 821A     strh    r2,[r3,10h]    ;四面分界都为0                            
08026B8C 7F9C     ldrb    r4,[r3,1Eh]    ;读取3000756的值                         
08026B8E 2C00     cmp     r4,0h                                   
08026B90 D122     bne     @@756No0                                
08026B92 480F     ldr     r0,=82DE168h                            
08026B94 6198     str     r0,[r3,18h]    ;写入OAM                         
08026B96 1C19     mov     r1,r3                                   
08026B98 3127     add     r1,27h                                  
08026B9A 2008     mov     r0,8h                                   
08026B9C 7008     strb    r0,[r1]        ;300075F写入8h                         
08026B9E 1C18     mov     r0,r3                                   
08026BA0 3028     add     r0,28h                                  
08026BA2 7005     strb    r5,[r0]        ;3000760写入0h                         
08026BA4 3102     add     r1,2h                                   
08026BA6 2010     mov     r0,10h                                  
08026BA8 7008     strb    r0,[r1]        ;3000761写入10h                         
08026BAA 480A     ldr     r0,=3000088h                            
08026BAC 7B01     ldrb    r1,[r0,0Ch]    ;读取3000094h的值                         
08026BAE 2203     mov     r2,3h                                   
08026BB0 2003     mov     r0,3h                                   
08026BB2 4008     and     r0,r1          ;and 3h                         
08026BB4 3001     add     r0,1h          ;加1                         
08026BB6 4010     and     r0,r2          ;再and 3                         
08026BB8 1C19     mov     r1,r3                                   
08026BBA 3121     add     r1,21h                                  
08026BBC 7008     strb    r0,[r1]        ;写入3000759h                         
08026BBE 3101     add     r1,1h                                   
08026BC0 200C     mov     r0,0Ch                                  
08026BC2 7008     strb    r0,[r1]        ;300075a写入OCh                          
08026BC4 2061     mov     r0,61h                                  
08026BC6 7030     strb    r0,[r6]        ;pose写入61h                         
08026BC8 E032     b       @@end                                

@@756No0:                               
08026BD8 2C01     cmp     r4,1h                                   
08026BDA D11D     bne     @@756No0or1                                
08026BDC 480C     ldr     r0,=82DE178h  ;写入OAM                          
08026BDE 6198     str     r0,[r3,18h]                             
08026BE0 1C18     mov     r0,r3                                   
08026BE2 3027     add     r0,27h                                  
08026BE4 2118     mov     r1,18h        ;300075F写入18h                          
08026BE6 7001     strb    r1,[r0]                                 
08026BE8 3001     add     r0,1h                                   
08026BEA 7001     strb    r1,[r0]       ;3000760写入18h                           
08026BEC 3001     add     r0,1h                                   
08026BEE 7001     strb    r1,[r0]       ;3000761写入18h                          
08026BF0 4808     ldr     r0,=3000088h                            
08026BF2 7B01     ldrb    r1,[r0,0Ch]   ;读取3000094h的值                          
08026BF4 2003     mov     r0,3h                                   
08026BF6 4008     and     r0,r1         ;与3and                          
08026BF8 1C19     mov     r1,r3                                   
08026BFA 3121     add     r1,21h                                  
08026BFC 7008     strb    r0,[r1]       ;写入3000759                          
08026BFE 1C18     mov     r0,r3                                   
08026C00 3022     add     r0,22h                                  
08026C02 7004     strb    r4,[r0]       ;300075a写入1                          
08026C04 200B     mov     r0,0Bh                                  
08026C06 7030     strb    r0,[r6]       ;pose写入b                          
08026C08 310B     add     r1,0Bh                                  
08026C0A 203C     mov     r0,3Ch                                  
08026C0C 7008     strb    r0,[r1]       ;3000764写入3Ch                          
08026C0E E00F     b       @@end                                

@@756No0or1:                               
08026C18 801A     strh    r2,[r3]       ;消失????                          
08026C1A E009     b       @@end 

@@PoseB:                               
08026C1C 1C19     mov     r1,r3                                   
08026C1E 312C     add     r1,2Ch                                  
08026C20 7808     ldrb    r0,[r1]       ;读取3000764的值                             
08026C22 3801     sub     r0,1h                                   
08026C24 7008     strb    r0,[r1]       ;减1再写入                          
08026C26 0600     lsl     r0,r0,18h                               
08026C28 0E00     lsr     r0,r0,18h                               
08026C2A 2800     cmp     r0,0h                                   
08026C2C D100     bne     @@end                                
08026C2E 8018     strh    r0,[r3]       ;消失????

@@end:                                 
08026C30 BC70     pop     r4-r6                                   
08026C32 BC01     pop     r0                                      
08026C34 4700     bx      r0 

                                     
08026C36 0000     lsl     r0,r0,0h                                
08026C38 B510     push    r4,r14                                  
08026C3A 4C16     ldr     r4,=300070Ch                            
08026C3C 88A0     ldrh    r0,[r4,4h]                              
08026C3E 6821     ldr     r1,[r4]                                 
08026C40 00C0     lsl     r0,r0,3h                                
08026C42 1840     add     r0,r0,r1                                
08026C44 6803     ldr     r3,[r0]                                 
08026C46 4A14     ldr     r2,=3000738h                            
08026C48 7F91     ldrb    r1,[r2,1Eh]                             
08026C4A 0048     lsl     r0,r1,1h                                
08026C4C 1840     add     r0,r0,r1                                
08026C4E 0040     lsl     r0,r0,1h                                
08026C50 18C0     add     r0,r0,r3                                
08026C52 8800     ldrh    r0,[r0]                                 
08026C54 4911     ldr     r1,=875F658h                            
08026C56 0080     lsl     r0,r0,2h                                
08026C58 1840     add     r0,r0,r1                                
08026C5A 6991     ldr     r1,[r2,18h]                             
08026C5C 6800     ldr     r0,[r0]                                 
08026C5E 4281     cmp     r1,r0                                   
08026C60 D003     beq     8026C6Ah                                
08026C62 6190     str     r0,[r2,18h]                             
08026C64 2000     mov     r0,0h                                   
08026C66 7710     strb    r0,[r2,1Ch]                             
08026C68 82D0     strh    r0,[r2,16h]                             
08026C6A 7F91     ldrb    r1,[r2,1Eh]                             
08026C6C 0048     lsl     r0,r1,1h                                
08026C6E 1840     add     r0,r0,r1                                
08026C70 0040     lsl     r0,r0,1h                                
08026C72 18C0     add     r0,r0,r3                                
08026C74 8840     ldrh    r0,[r0,2h]                              
08026C76 88E1     ldrh    r1,[r4,6h]                              
08026C78 1840     add     r0,r0,r1                                
08026C7A 8050     strh    r0,[r2,2h]                              
08026C7C 7F91     ldrb    r1,[r2,1Eh]                             
08026C7E 0048     lsl     r0,r1,1h                                
08026C80 1840     add     r0,r0,r1                                
08026C82 0040     lsl     r0,r0,1h                                
08026C84 18C0     add     r0,r0,r3                                
08026C86 8880     ldrh    r0,[r0,4h]                              
08026C88 8924     ldrh    r4,[r4,8h]                              
08026C8A 1900     add     r0,r0,r4                                
08026C8C 8090     strh    r0,[r2,4h]                              
08026C8E BC10     pop     r4                                      
08026C90 BC01     pop     r0                                      
08026C92 4700     bx      r0                                      
08026C94 070C     lsl     r4,r1,1Ch                               
08026C96 0300     lsl     r0,r0,0Ch                               
08026C98 0738     lsl     r0,r7,1Ch                               
08026C9A 0300     lsl     r0,r0,0Ch                               
08026C9C F658     ????                                            
08026C9E 0875     lsr     r5,r6,1h                                
08026CA0 B530     push    r4,r5,r14                               
08026CA2 490C     ldr     r1,=3000738h                            
08026CA4 22B0     mov     r2,0B0h                                 
08026CA6 0092     lsl     r2,r2,2h                                
08026CA8 1C14     mov     r4,r2                                   
08026CAA 88C9     ldrh    r1,[r1,6h]                              
08026CAC 1864     add     r4,r4,r1                                
08026CAE 0424     lsl     r4,r4,10h                               
08026CB0 0C24     lsr     r4,r4,10h                               
08026CB2 4909     ldr     r1,=300070Ch                            
08026CB4 890D     ldrh    r5,[r1,8h]                              
08026CB6 4909     ldr     r1,=3000079h                            
08026CB8 7008     strb    r0,[r1]                                 
08026CBA 3C20     sub     r4,20h                                  
08026CBC 1C20     mov     r0,r4                                   
08026CBE 1C29     mov     r1,r5                                   
08026CC0 F031F8DC bl      8057E7Ch                                
08026CC4 1C20     mov     r0,r4                                   
08026CC6 1C29     mov     r1,r5                                   
08026CC8 221E     mov     r2,1Eh                                  
08026CCA F02DFA0F bl      80540ECh                                
08026CCE BC30     pop     r4,r5                                   
08026CD0 BC01     pop     r0                                      
08026CD2 4700     bx      r0                                      
08026CD4 0738     lsl     r0,r7,1Ch                               
08026CD6 0300     lsl     r0,r0,0Ch                               
08026CD8 070C     lsl     r4,r1,1Ch                               
08026CDA 0300     lsl     r0,r0,0Ch                               
08026CDC 0079     lsl     r1,r7,1h                                
08026CDE 0300     lsl     r0,r0,0Ch                               
08026CE0 B5F0     push    r4-r7,r14                               
08026CE2 4647     mov     r7,r8                                   
08026CE4 B480     push    r7                                      
08026CE6 1C05     mov     r5,r0                                   
08026CE8 062D     lsl     r5,r5,18h                               
08026CEA 0E2D     lsr     r5,r5,18h                               
08026CEC 4815     ldr     r0,=3000738h                            
08026CEE 21B0     mov     r1,0B0h                                 
08026CF0 0089     lsl     r1,r1,2h                                
08026CF2 1C0C     mov     r4,r1                                   
08026CF4 88C0     ldrh    r0,[r0,6h]                              
08026CF6 1824     add     r4,r4,r0                                
08026CF8 0424     lsl     r4,r4,10h                               
08026CFA 0C24     lsr     r4,r4,10h                               
08026CFC 4812     ldr     r0,=300070Ch                            
08026CFE 8907     ldrh    r7,[r0,8h]                              
08026D00 4E12     ldr     r6,=3000079h                            
08026D02 7035     strb    r5,[r6]                                 
08026D04 2020     mov     r0,20h                                  
08026D06 4240     neg     r0,r0                                   
08026D08 1900     add     r0,r0,r4                                
08026D0A 4680     mov     r8,r0                                   
08026D0C 1C39     mov     r1,r7                                   
08026D0E 3140     add     r1,40h                                  
08026D10 F031F8B4 bl      8057E7Ch                                
08026D14 7035     strb    r5,[r6]                                 
08026D16 1C39     mov     r1,r7                                   
08026D18 3940     sub     r1,40h                                  
08026D1A 4640     mov     r0,r8                                   
08026D1C F031F8AE bl      8057E7Ch                                
08026D20 1C39     mov     r1,r7                                   
08026D22 3148     add     r1,48h                                  
08026D24 1C20     mov     r0,r4                                   
08026D26 221E     mov     r2,1Eh                                  
08026D28 F02DF9E0 bl      80540ECh                                
08026D2C 1C39     mov     r1,r7                                   
08026D2E 3948     sub     r1,48h                                  
08026D30 1C20     mov     r0,r4                                   
08026D32 221E     mov     r2,1Eh                                  
08026D34 F02DF9DA bl      80540ECh                                
08026D38 BC08     pop     r3                                      
08026D3A 4698     mov     r8,r3                                   
08026D3C BCF0     pop     r4-r7                                   
08026D3E BC01     pop     r0                                      
08026D40 4700     bx      r0                                      
08026D42 0000     lsl     r0,r0,0h                                
08026D44 0738     lsl     r0,r7,1Ch                               
08026D46 0300     lsl     r0,r0,0Ch                               
08026D48 070C     lsl     r4,r1,1Ch                               
08026D4A 0300     lsl     r0,r0,0Ch                               
08026D4C 0079     lsl     r1,r7,1h                                
08026D4E 0300     lsl     r0,r0,0Ch                               
08026D50 B570     push    r4-r6,r14                               
08026D52 4656     mov     r6,r10                                  
08026D54 464D     mov     r5,r9                                   
08026D56 4644     mov     r4,r8                                   
08026D58 B470     push    r4-r6                                   
08026D5A 1C05     mov     r5,r0                                   
08026D5C 062D     lsl     r5,r5,18h                               
08026D5E 0E2D     lsr     r5,r5,18h                               
08026D60 4817     ldr     r0,=3000738h                            
08026D62 21B0     mov     r1,0B0h                                 
08026D64 0089     lsl     r1,r1,2h                                
08026D66 1C0C     mov     r4,r1                                   
08026D68 88C0     ldrh    r0,[r0,6h]                              
08026D6A 1824     add     r4,r4,r0                                
08026D6C 0424     lsl     r4,r4,10h                               
08026D6E 0C24     lsr     r4,r4,10h                               
08026D70 4814     ldr     r0,=300070Ch                            
08026D72 8906     ldrh    r6,[r0,8h]                              
08026D74 4814     ldr     r0,=3000079h                            
08026D76 4680     mov     r8,r0                                   
08026D78 7005     strb    r5,[r0]                                 
08026D7A 2120     mov     r1,20h                                  
08026D7C 4249     neg     r1,r1                                   
08026D7E 1909     add     r1,r1,r4                                
08026D80 4689     mov     r9,r1                                   
08026D82 2080     mov     r0,80h                                  
08026D84 1980     add     r0,r0,r6                                
08026D86 4682     mov     r10,r0                                  
08026D88 4648     mov     r0,r9                                   
08026D8A 4651     mov     r1,r10                                  
08026D8C F031F876 bl      8057E7Ch                                
08026D90 4641     mov     r1,r8                                   
08026D92 700D     strb    r5,[r1]                                 
08026D94 3E80     sub     r6,80h                                  
08026D96 4648     mov     r0,r9                                   
08026D98 1C31     mov     r1,r6                                   
08026D9A F031F86F bl      8057E7Ch                                
08026D9E 1C20     mov     r0,r4                                   
08026DA0 4651     mov     r1,r10                                  
08026DA2 221E     mov     r2,1Eh                                  
08026DA4 F02DF9A2 bl      80540ECh                                
08026DA8 1C20     mov     r0,r4                                   
08026DAA 1C31     mov     r1,r6                                   
08026DAC 221E     mov     r2,1Eh                                  
08026DAE F02DF99D bl      80540ECh                                
08026DB2 BC38     pop     r3-r5                                   
08026DB4 4698     mov     r8,r3                                   
08026DB6 46A1     mov     r9,r4                                   
08026DB8 46AA     mov     r10,r5                                  
08026DBA BC70     pop     r4-r6                                   
08026DBC BC01     pop     r0                                      
08026DBE 4700     bx      r0                                      
08026DC0 0738     lsl     r0,r7,1Ch                               
08026DC2 0300     lsl     r0,r0,0Ch                               
08026DC4 070C     lsl     r4,r1,1Ch                               
08026DC6 0300     lsl     r0,r0,0Ch                               
08026DC8 0079     lsl     r1,r7,1h                                
08026DCA 0300     lsl     r0,r0,0Ch                               
08026DCC B570     push    r4-r6,r14                               
08026DCE 4646     mov     r6,r8                                   
08026DD0 B440     push    r6                                      
08026DD2 1C06     mov     r6,r0                                   
08026DD4 0636     lsl     r6,r6,18h                               
08026DD6 0E36     lsr     r6,r6,18h                               
08026DD8 4810     ldr     r0,=3000738h                            
08026DDA 21D0     mov     r1,0D0h                                 
08026DDC 0089     lsl     r1,r1,2h                                
08026DDE 1C0C     mov     r4,r1                                   
08026DE0 88C0     ldrh    r0,[r0,6h]                              
08026DE2 1824     add     r4,r4,r0                                
08026DE4 0424     lsl     r4,r4,10h                               
08026DE6 0C24     lsr     r4,r4,10h                               
08026DE8 480D     ldr     r0,=300070Ch                            
08026DEA 8905     ldrh    r5,[r0,8h]                              
08026DEC 480D     ldr     r0,=3000079h                            
08026DEE 4680     mov     r8,r0                                   
08026DF0 7006     strb    r6,[r0]                                 
08026DF2 1C20     mov     r0,r4                                   
08026DF4 3020     add     r0,20h                                  
08026DF6 2190     mov     r1,90h                                  
08026DF8 0089     lsl     r1,r1,2h                                
08026DFA 186D     add     r5,r5,r1                                
08026DFC 1C29     mov     r1,r5                                   
08026DFE F031F83D bl      8057E7Ch                                
08026E02 4640     mov     r0,r8                                   
08026E04 7006     strb    r6,[r0]                                 
08026E06 3460     add     r4,60h                                  
08026E08 1C20     mov     r0,r4                                   
08026E0A 1C29     mov     r1,r5                                   
08026E0C F031F836 bl      8057E7Ch                                
08026E10 BC08     pop     r3                                      
08026E12 4698     mov     r8,r3                                   
08026E14 BC70     pop     r4-r6                                   
08026E16 BC01     pop     r0                                      
08026E18 4700     bx      r0                                      
08026E1A 0000     lsl     r0,r0,0h                                
08026E1C 0738     lsl     r0,r7,1Ch                               
08026E1E 0300     lsl     r0,r0,0Ch                               
08026E20 070C     lsl     r4,r1,1Ch                               
08026E22 0300     lsl     r0,r0,0Ch                               
08026E24 0079     lsl     r1,r7,1h                                
08026E26 0300     lsl     r0,r0,0Ch                               
08026E28 B530     push    r4,r5,r14                               
08026E2A 0400     lsl     r0,r0,10h                               
08026E2C 0C04     lsr     r4,r0,10h                               
08026E2E 0409     lsl     r1,r1,10h                               

