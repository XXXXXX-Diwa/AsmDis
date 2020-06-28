.definelabel checkevent,8068bch
.definelabel CheckBlock,0x800F720
.definelabel spawnsecsprite,800E258h

;pose 0h
08044148 B530     push    r4,r5,r14                               
0804414A B083     add     sp,-0Ch                                 
0804414C 2003     mov     r0,3h                                   
0804414E 2143     mov     r1,43h     ;全装甲事件                            
08044150 F01CFBB4 bl      checkevent                                
08044154 2800     cmp     r0,0h                                   
08044156 D105     bne     @@avtication                                
08044158 481B     ldr     r0,=3000738h                            
0804415A 3032     add     r0,32h                                  
0804415C 7802     ldrb    r2,[r0]    ;读取300076a                             
0804415E 2140     mov     r1,40h                                  
08044160 4311     orr     r1,r2      ;40h orr                              
08044162 7001     strb    r1,[r0]    ;再写入  碰撞属性40=无敌

@@avtication:                               
08044164 4C18     ldr     r4,=3000738h                            
08044166 1C20     mov     r0,r4                                   
08044168 3027     add     r0,27h                                  
0804416A 2200     mov     r2,0h                                   
0804416C 210E     mov     r1,0Eh                                  
0804416E 7001     strb    r1,[r0]   ;300075f写入eh                              
08044170 3001     add     r0,1h                                   
08044172 7001     strb    r1,[r0]   ;3000760写入eh                               
08044174 3001     add     r0,1h                                   
08044176 210C     mov     r1,0Ch                                  
08044178 7001     strb    r1,[r0]   ;3000761写入ch                               
0804417A 2500     mov     r5,0h                                   
0804417C 4813     ldr     r0,=0FFE0h                              
0804417E 8160     strh    r0,[r4,0Ah] ;上部分界写入0ffe0h                            
08044180 2020     mov     r0,20h                                  
08044182 81A0     strh    r0,[r4,0Ch] ;下部分界写入20h                            
08044184 4812     ldr     r0,=0FFF4h                              
08044186 81E0     strh    r0,[r4,0Eh] ;左部分界写入0fff4h                            
08044188 8221     strh    r1,[r4,10h] ;右部分界写入ch                            
0804418A 1C21     mov     r1,r4                                   
0804418C 3121     add     r1,21h                                  
0804418E 2001     mov     r0,1h                                   
08044190 7008     strb    r0,[r1]     ;3000759写入1h                            
08044192 4810     ldr     r0,=8307574h ;写入默认OAM                           
08044194 61A0     str     r0,[r4,18h]                             
08044196 82E2     strh    r2,[r4,16h]                             
08044198 7725     strb    r5,[r4,1Ch]                             
0804419A 1C20     mov     r0,r4                                   
0804419C 3025     add     r0,25h      ;写入属性为0h                            
0804419E 7005     strb    r5,[r0]                                 
080441A0 4A0D     ldr     r2,=82B0D68h ;敌人基础数据起始                          
080441A2 7F61     ldrb    r1,[r4,1Dh]  ;得到精灵ID                           
080441A4 00C8     lsl     r0,r1,3h                                
080441A6 1840     add     r0,r0,r1                                
080441A8 0040     lsl     r0,r0,1h     ;18倍                           
080441AA 1880     add     r0,r0,r2     ;得到偏移地址                           
080441AC 8800     ldrh    r0,[r0]      ;读取血量                           
080441AE 82A0     strh    r0,[r4,14h]  ;写入精灵血量                           
080441B0 8860     ldrh    r0,[r4,2h]   ;读取Y坐标                           
080441B2 3820     sub     r0,20h       ;上移半格                           
080441B4 88A1     ldrh    r1,[r4,4h]   ;读取X坐标                           
080441B6 3140     add     r1,40h       ;右移一格的坐标                           
080441B8 F7CBFAB2 bl      CheckBlock                                
080441BC 2800     cmp     r0,0h                                   
080441BE D00D     beq     @@rightpeer                                
080441C0 88A0     ldrh    r0,[r4,4h]   ;X坐标向右半格                           
080441C2 3020     add     r0,20h                                  
080441C4 E010     b       @@peer                                
                                
@@rightpeer:                               
080441DC 8820     ldrh    r0,[r4]                                 
080441DE 2140     mov     r1,40h                                  
080441E0 4308     orr     r0,r1     ;取向 orr 40h  面向右边                            
080441E2 8020     strh    r0,[r4]   ;再写入                              
080441E4 88A0     ldrh    r0,[r4,4h];X坐标向左半格                             
080441E6 3820     sub     r0,20h    

@@peer:                                 
080441E8 80A0     strh    r0,[r4,4h]  ;写入新X坐标                            
080441EA 4C0B     ldr     r4,=3000738h                            
080441EC 7F60     ldrb    r0,[r4,1Dh]  ;获取ID                           
080441EE 28A6     cmp     r0,0A6h                                 
080441F0 D105     bne     @@IDNOA6                                
080441F2 8821     ldrh    r1,[r4]                                 
080441F4 2280     mov     r2,80h                                  
080441F6 00D2     lsl     r2,r2,3h                                
080441F8 1C10     mov     r0,r2                                   
080441FA 4308     orr     r0,r1       ;400h orr 取向                            
080441FC 8020     strh    r0,[r4]     ;再写入   --400是向下移动

@@IDNOA6:                                 
080441FE 4807     ldr     r0,=30001A8h                            
08044200 8800     ldrh    r0,[r0]                                 
08044202 2800     cmp     r0,0h                                   
08044204 D00C     beq     @@NOalarm                                
08044206 1C21     mov     r1,r4                                   
08044208 3124     add     r1,24h                                  
0804420A 2023     mov     r0,23h                                  
0804420C 7008     strb    r0,[r1]    ;有警报写入pose 23h                             
0804420E 3108     add     r1,8h                                   
08044210 2028     mov     r0,28h                                  
08044212 7008     strb    r0,[r1]    ;3000764写入28h                             
08044214 E02F     b       @@end                                


@@NOalarm:                               
08044220 1C21     mov     r1,r4                                   
08044222 3124     add     r1,24h     ;有警报则pose写入9h                             
08044224 2009     mov     r0,9h                                   
08044226 7008     strb    r0,[r1]                                 
08044228 8862     ldrh    r2,[r4,2h] ;Y坐标                             
0804422A 88A0     ldrh    r0,[r4,4h]                              
0804422C 4684     mov     r12,r0     ;X坐标                             
0804422E 7FE3     ldrb    r3,[r4,1Fh];GFX ROW                           
08044230 1C20     mov     r0,r4                                   
08044232 3023     add     r0,23h                                  
08044234 7805     ldrb    r5,[r0]    ;主精灵序号                            
08044236 8821     ldrh    r1,[r4]                                 
08044238 2440     mov     r4,40h                                  
0804423A 1C20     mov     r0,r4                                   
0804423C 4008     and     r0,r1      ;40h and 取向                             
0804423E 0400     lsl     r0,r0,10h                               
08044240 0C01     lsr     r1,r0,10h                               
08044242 2900     cmp     r1,0h                                   
08044244 D00C     beq     @@faceleft                                
08044246 9200     str     r2,[sp]                                 
08044248 20E0     mov     r0,0E0h                                 
0804424A 0040     lsl     r0,r0,1h                                
0804424C 4460     add     r0,r12     ;X坐标加上1C0                             
0804424E 9001     str     r0,[sp,4h]                              
08044250 9402     str     r4,[sp,8h] ;取向 40h                             
08044252 202C     mov     r0,2Ch                                  
08044254 2100     mov     r1,0h                                   
08044256 1C1A     mov     r2,r3                                   
08044258 1C2B     mov     r3,r5                                   
0804425A F7C9FFFD bl      spawnsecsprite ;制造副精灵眼光数据                               
0804425E E00A     b       @@end

@@faceleft:                                
08044260 9200     str     r2,[sp]                                 
08044262 4807     ldr     r0,=0FFFFFE40h                          
08044264 4460     add     r0,r12        ;X坐标相当于减1C0                          
08044266 9001     str     r0,[sp,4h]                              
08044268 9102     str     r1,[sp,8h]                              
0804426A 202C     mov     r0,2Ch                                  
0804426C 2100     mov     r1,0h                                   
0804426E 1C1A     mov     r2,r3                                   
08044270 1C2B     mov     r3,r5                                   
08044272 F7C9FFF1 bl      spawnsecsprite

@@end:                                
08044276 B003     add     sp,0Ch                                  
08044278 BC30     pop     r4,r5                                   
0804427A BC01     pop     r0                                      
0804427C 4700     bx      r0                                      

;共用的调用例程 用于眼睛的移动
08044284 B5F0     push    r4-r7,r14                               
08044286 4806     ldr     r0,=3000738h                            
08044288 8846     ldrh    r6,[r0,2h]                              
0804428A 8883     ldrh    r3,[r0,4h]                              
0804428C 8802     ldrh    r2,[r0]                                 
0804428E 2140     mov     r1,40h                                  
08044290 4011     and     r1,r2                                   
08044292 1C05     mov     r5,r0                                   
08044294 2900     cmp     r1,0h                                   
08044296 D005     beq     @@faceleft                                
08044298 1C18     mov     r0,r3                                   
0804429A 3810     sub     r0,10h    ;X坐标左移10h的坐标                                 
0804429C E004     b       @@peer                                 

@@faceleft:                              
080442A4 1C18     mov     r0,r3                                   
080442A6 3010     add     r0,10h    ;X坐标右移10h的坐标

@@peer:                                  
080442A8 0400     lsl     r0,r0,10h                               
080442AA 0C03     lsr     r3,r0,10h                               
080442AC 1C2C     mov     r4,r5                                   
080442AE 8821     ldrh    r1,[r4]                                 
080442B0 2780     mov     r7,80h                                  
080442B2 00FF     lsl     r7,r7,3h                                
080442B4 1C38     mov     r0,r7                                   
080442B6 4008     and     r0,r1    ;4000h and 取向                               
080442B8 2800     cmp     r0,0h                                   
080442BA D015     beq     @@goup                                
080442BC 8860     ldrh    r0,[r4,2h] ;Y坐标下移1h再写入                             
080442BE 3001     add     r0,1h                                   
080442C0 8060     strh    r0,[r4,2h]                              
080442C2 1C30     mov     r0,r6      ;原Y坐标下移半格                             
080442C4 3020     add     r0,20h                                  
080442C6 1C19     mov     r1,r3      ;X坐标移动10h的坐标                             
080442C8 F7CBFA2A bl      CheckBlock                                
080442CC 4804     ldr     r0,=30000DCh                            
080442CE 8800     ldrh    r0,[r0]                                 
080442D0 2807     cmp     r0,7h                                   
080442D2 D119     bne     @@end      ;未检测到clip 7结束                         
080442D4 8821     ldrh    r1,[r4]                                 
080442D6 4803     ldr     r0,=0FBFFh                              
080442D8 4008     and     r0,r1      ;结果为400h 为0 变向                            
080442DA 8020     strh    r0,[r4]                                 
080442DC E014     b       @@end                                

@@goup:                               
080442E8 8868     ldrh    r0,[r5,2h]                              
080442EA 3801     sub     r0,1h       ;Y坐标上移1h再写入                            
080442EC 8068     strh    r0,[r5,2h]                              
080442EE 1C30     mov     r0,r6                                   
080442F0 3820     sub     r0,20h                                  
080442F2 1C19     mov     r1,r3                                   
080442F4 F7CBFA14 bl      CheckBlock                                
080442F8 4805     ldr     r0,=30000DCh                            
080442FA 8800     ldrh    r0,[r0]                                 
080442FC 2807     cmp     r0,7h                                   
080442FE D103     bne     @@end                                
08044300 8829     ldrh    r1,[r5]                                 
08044302 1C38     mov     r0,r7      ;400h orr 变向                             
08044304 4308     orr     r0,r1                                   
08044306 8028     strh    r0,[r5]

@@end:                                 
08044308 BCF0     pop     r4-r7                                   
0804430A BC01     pop     r0                                      
0804430C 4700     bx      r0                                      

;pose 9h                               
08044314 B500     push    r14                                     
08044316 4806     ldr     r0,=30001A8h                            
08044318 8800     ldrh    r0,[r0]                                 
0804431A 2800     cmp     r0,0h                                   
0804431C D00C     beq     @@Noalarm                                
0804431E 4905     ldr     r1,=3000738h  ;警报没有停止的话                          
08044320 1C0A     mov     r2,r1                                   
08044322 3224     add     r2,24h                                  
08044324 2023     mov     r0,23h    ;pose写入23h                                
08044326 7010     strb    r0,[r2]                                 
08044328 312C     add     r1,2Ch                                  
0804432A 2028     mov     r0,28h                                  
0804432C 7008     strb    r0,[r1]   ;3000764继续写入28h                             
0804432E E005     b       804433Ch                                

@@Noalarm:                             
08044338 F7FFFFA4 bl      8044284h   ;警报停止调用例程

@@end:                                
0804433C BC01     pop     r0                                      
0804433E 4700     bx      r0 

;pose 23h     有警报                                
08044340 B500     push    r14                                     
08044342 4A07     ldr     r2,=3000738h                            
08044344 1C11     mov     r1,r2                                   
08044346 312C     add     r1,2Ch    ;3000764                              
08044348 7808     ldrb    r0,[r1]                                 
0804434A 3801     sub     r0,1h     ;的值减1再写入                               
0804434C 7008     strb    r0,[r1]                                 
0804434E 0600     lsl     r0,r0,18h                               
08044350 2800     cmp     r0,0h     ;当28帧过去后 从有警报到眼睛射波的计时                             
08044352 D102     bne     @@end                                
08044354 3908     sub     r1,8h     ;pose写入25h                              
08044356 2025     mov     r0,25h                                  
08044358 7008     strb    r0,[r1]

@@end:                                 
0804435A BC01     pop     r0                                      
0804435C 4700     bx      r0                                      

;pose 25h                               
08044364 B500     push    r14                                     
08044366 F7FFFF8D bl      8044284h  ;调用移动例程                               
0804436A 4908     ldr     r1,=3000738h                            
0804436C 1C0B     mov     r3,r1                                   
0804436E 332C     add     r3,2Ch                                  
08044370 7818     ldrb    r0,[r3]                                 
08044372 1C02     mov     r2,r0                                   
08044374 2A00     cmp     r2,0h     ;3000764不为0时                              
08044376 D10D     bne     @@NOzero                                
08044378 4805     ldr     r0,=830765Ch                            
0804437A 6188     str     r0,[r1,18h] ;写入新OAM                            
0804437C 2000     mov     r0,0h                                   
0804437E 82CA     strh    r2,[r1,16h]                             
08044380 7708     strb    r0,[r1,1Ch]                             
08044382 3124     add     r1,24h                                  
08044384 2027     mov     r0,27h                                  
08044386 7008     strb    r0,[r1]    ;pose写入27h                             
08044388 201E     mov     r0,1Eh                                  
0804438A E004     b       @@end                                

@@NOzero:                               
08044394 3801     sub     r0,1h 

@@end:                                  
08044396 7018     strb    r0,[r3]   ;写入3000764的新值                              
08044398 BC01     pop     r0                                      
0804439A 4700     bx      r0

;pose 27h                                      
0804439C B510     push    r4,r14                                  
0804439E B083     add     sp,-0Ch                                 
080443A0 F7FFFF70 bl      8044284h  ;移动例程                             
080443A4 481A     ldr     r0,=3000738h                            
080443A6 4684     mov     r12,r0                                  
080443A8 4662     mov     r2,r12                                  
080443AA 322C     add     r2,2Ch                                  
080443AC 7810     ldrb    r0,[r2]                                 
080443AE 1C01     mov     r1,r0                                   
080443B0 2900     cmp     r1,0h    ;读取3000764 不为 0跳转                               
080443B2 D133     bne     @@NOzero                                
080443B4 4817     ldr     r0,=8307574h                            
080443B6 4663     mov     r3,r12                                  
080443B8 6198     str     r0,[r3,18h] ;写入新OAM                            
080443BA 2000     mov     r0,0h                                   
080443BC 82D9     strh    r1,[r3,16h]                             
080443BE 7718     strb    r0,[r3,1Ch]                             
080443C0 4661     mov     r1,r12                                  
080443C2 3124     add     r1,24h                                  
080443C4 2025     mov     r0,25h      ;pose写回25h                             
080443C6 7008     strb    r0,[r1]                                 
080443C8 205A     mov     r0,5Ah                                  
080443CA 7010     strb    r0,[r2]     ;3000764写入5ah                            
080443CC 881A     ldrh    r2,[r3]                                 
080443CE 2002     mov     r0,2h                                   
080443D0 4010     and     r0,r2       ;2 and 取向  来确认眼睛是否在屏幕内?                          
080443D2 2800     cmp     r0,0h                                   
080443D4 D015     beq     outsidescreen                                
080443D6 2140     mov     r1,40h                                  
080443D8 1C08     mov     r0,r1                                   
080443DA 4010     and     r0,r2       ;40h and 取向                             
080443DC 0400     lsl     r0,r0,10h                               
080443DE 0C00     lsr     r0,r0,10h                               
080443E0 4240     neg     r0,r0       ;取反                            
080443E2 17C0     asr     r0,r0,1Fh                               
080443E4 4008     and     r0,r1       ;结果应该是0h                            
080443E6 7FDA     ldrb    r2,[r3,1Fh] ;GFX ROW                            
080443E8 4661     mov     r1,r12                                  
080443EA 3123     add     r1,23h                                  
080443EC 780B     ldrb    r3,[r1]    ;主序号                             
080443EE 4664     mov     r4,r12                                  
080443F0 8861     ldrh    r1,[r4,2h]                              
080443F2 9100     str     r1,[sp]                                 
080443F4 88A1     ldrh    r1,[r4,4h]                              
080443F6 9101     str     r1,[sp,4h]                              
080443F8 9002     str     r0,[sp,8h]                              
080443FA 2039     mov     r0,39h                                  
080443FC 2100     mov     r1,0h                                   
080443FE F7C9FF2B bl      spawnsecsprite ;制造副精灵波数据

@@outsidescreen:                               
08044402 4905     ldr     r1,=30001A8h                            
08044404 22F0     mov     r2,0F0h                                 
08044406 0052     lsl     r2,r2,1h                                
08044408 1C10     mov     r0,r2                                   
0804440A 8008     strh    r0,[r1]   ;警报写入1e0h                              
0804440C E008     b       @@end                                

@@Nozero:                              
0804441C 3801     sub     r0,1h                                   
0804441E 7010     strb    r0,[r2]

@@end:                                 
08044420 B003     add     sp,0Ch                                  
08044422 BC10     pop     r4                                      
08044424 BC01     pop     r0                                      
08044426 4700     bx      r0

;副精灵pose 0h                                      
08044428 B510     push    r4,r14                                  
0804442A 4818     ldr     r0,=3000738h                            
0804442C 4684     mov     r12,r0                                  
0804442E 8801     ldrh    r1,[r0]                                 
08044430 4817     ldr     r0,=0FFFBh                              
08044432 4008     and     r0,r1                                   
08044434 2300     mov     r3,0h                                   
08044436 2200     mov     r2,0h                                   
08044438 4661     mov     r1,r12                                  
0804443A 8008     strh    r0,[r1]  ;取向再写入                                
0804443C 4660     mov     r0,r12                                  
0804443E 3027     add     r0,27h                                  
08044440 2108     mov     r1,8h                                   
08044442 7001     strb    r1,[r0]  ;300075f写入8h                               
08044444 3001     add     r0,1h                                   
08044446 7001     strb    r1,[r0]  ;3000760写入8h                               
08044448 4664     mov     r4,r12                                  
0804444A 3429     add     r4,29h                                  
0804444C 2070     mov     r0,70h                                  
0804444E 7020     strb    r0,[r4]  ;3000761写入70                               
08044450 4810     ldr     r0,=0FFF8h                              
08044452 4664     mov     r4,r12                                  
08044454 8160     strh    r0,[r4,0Ah] ;上部分界写入fff8h                            
08044456 81A1     strh    r1,[r4,0Ch] ;下部分界写入8h                            
08044458 480F     ldr     r0,=0FE40h                              
0804445A 81E0     strh    r0,[r4,0Eh] ;左部分界写入fe40h   1c0h                          
0804445C 20E0     mov     r0,0E0h                                 
0804445E 0040     lsl     r0,r0,1h                                
08044460 8220     strh    r0,[r4,10h] ;右部分界写入1c0h                           
08044462 4661     mov     r1,r12                                  
08044464 3121     add     r1,21h                                  
08044466 2003     mov     r0,3h                                   
08044468 7008     strb    r0,[r1]     ;3000759写入3h                            
0804446A 3101     add     r1,1h                                   
0804446C 200C     mov     r0,0Ch                                  
0804446E 7008     strb    r0,[r1]     ;300075a写入0ch                            
08044470 480A     ldr     r0,=83075DCh  ;写入OAM                          
08044472 61A0     str     r0,[r4,18h]                             
08044474 82E2     strh    r2,[r4,16h]                             
08044476 7723     strb    r3,[r4,1Ch]                             
08044478 3102     add     r1,2h                                   
0804447A 2009     mov     r0,9h                                   
0804447C 7008     strb    r0,[r1]   ;pose写入9h                              
0804447E 3101     add     r1,1h                                   
08044480 201E     mov     r0,1Eh    ;属性1Eh                              
08044482 7008     strb    r0,[r1]                                 
08044484 BC10     pop     r4                                      
08044486 BC01     pop     r0                                      
08044488 4700     bx      r0 
                                     
;pose 9h                              
080444A0 B5F0     push    r4-r7,r14                               
080444A2 4A09     ldr     r2,=3000738h                            
080444A4 4B09     ldr     r3,=30001ACh                            
080444A6 1C10     mov     r0,r2                                   
080444A8 3023     add     r0,23h    ;主精灵序号                              
080444AA 7801     ldrb    r1,[r0]                                 
080444AC 00C8     lsl     r0,r1,3h                                
080444AE 1A40     sub     r0,r0,r1                                
080444B0 00C0     lsl     r0,r0,3h    ;得到副精灵数据地址                            
080444B2 18C0     add     r0,r0,r3                                
080444B4 8840     ldrh    r0,[r0,2h]  ;副精灵Y坐标                            
080444B6 8050     strh    r0,[r2,2h]  ;写入公共坐标                            
080444B8 4805     ldr     r0,=30001A8h                            
080444BA 8800     ldrh    r0,[r0]                                 
080444BC 1C13     mov     r3,r2                                   
080444BE 2800     cmp     r0,0h                                   
080444C0 D008     beq     @@alarmzero                                
080444C2 2000     mov     r0,0h       ;有警报则取向写入0                            
080444C4 8018     strh    r0,[r3]                                 
080444C6 E09A     b       @@end                                

@@alarmzero:                               
080444D4 8819     ldrh    r1,[r3]                                 
080444D6 2080     mov     r0,80h                                  
080444D8 0100     lsl     r0,r0,4h                                
080444DA 4008     and     r0,r1       ;800 and 取向                            
080444DC 2800     cmp     r0,0h                                   
080444DE D100     bne     @@pass      ;不为0则是在光线范围内                          
080444E0 E08D     b       @@end  

@@pass:                              
080444E2 885F     ldrh    r7,[r3,2h]  ;副精灵Y坐标                            
080444E4 2600     mov     r6,0h                                   
080444E6 2040     mov     r0,40h                                  
080444E8 4008     and     r0,r1       ;40 and 取向                             
080444EA 2800     cmp     r0,0h                                   
080444EC D030     beq     @@faceleft                                
080444EE 4904     ldr     r1,=0FE64h                              
080444F0 1C08     mov     r0,r1                                   
080444F2 889B     ldrh    r3,[r3,4h] ;副精灵X坐标                             
080444F4 18C0     add     r0,r0,r3   ;加上FE64h   相当于减19ch                          
080444F6 0400     lsl     r0,r0,10h                               
080444F8 0C04     lsr     r4,r0,10h                               
080444FA 2500     mov     r5,0h                                   
080444FC E009     b       @@come                                

@@loop:                                
08044504 1C20     mov     r0,r4                                   
08044506 3040     add     r0,40h     ;加一个砖块的距离                               
08044508 0400     lsl     r0,r0,10h                               
0804450A 0C04     lsr     r4,r0,10h                               
0804450C 1C68     add     r0,r5,1    ;r5+1                             
0804450E 0600     lsl     r0,r0,18h                               
08044510 0E05     lsr     r5,r0,18h

@@come:                               
08044512 2D07     cmp     r5,7h                                   
08044514 D808     bhi     @@overdata                                
08044516 1C38     mov     r0,r7                                   
08044518 1C21     mov     r1,r4                                   
0804451A F7CBF901 bl      CheckBlock                                
0804451E 2800     cmp     r0,0h        ;没有砖块则继续检查,最多8次循环                           
08044520 D0F0     beq     @@loop                                
08044522 1C70     add     r0,r6,1                                 
08044524 0600     lsl     r0,r0,18h                               
08044526 0E06     lsr     r6,r0,18h

@@overdata:                               
08044528 4B06     ldr     r3,=3000738h                            
0804452A 2E00     cmp     r6,0h        ;如果循环8次都没有检查到砖块则为0                            
0804452C D038     beq     @@peer                                
0804452E 4806     ldr     r0,=0FFC0h   ;以下为在有砖块的坐标跳出的循环                           
08044530 4004     and     r4,r0        ;用来取整?                           
08044532 1C20     mov     r0,r4                                   
08044534 3040     add     r0,40h       ;在此基础上再加一格                           
08044536 0400     lsl     r0,r0,10h                               
08044538 0C04     lsr     r4,r0,10h                               
0804453A 4804     ldr     r0,=30013D4h                            
0804453C 8A40     ldrh    r0,[r0,12h]  ;得到人物的X坐标                           
0804453E 42A0     cmp     r0,r4                                   
08044540 D92E     bls     @@peer       ;小于则跳转,也就是在光线范围内                         
08044542 E029     b       @@Notouch                                

@@faceleft:                               
08044550 22CE     mov     r2,0CEh                                 
08044552 0052     lsl     r2,r2,1h                                
08044554 1C10     mov     r0,r2                                   
08044556 889B     ldrh    r3,[r3,4h]                              
08044558 18C0     add     r0,r0,r3     ;X坐标加上19ch                           
0804455A 0400     lsl     r0,r0,10h                               
0804455C 0C04     lsr     r4,r0,10h                               
0804455E 2500     mov     r5,0h                                   
08044560 E006     b       8044570h                                
08044562 1C20     mov     r0,r4                                   
08044564 3840     sub     r0,40h                                  
08044566 0400     lsl     r0,r0,10h                               
08044568 0C04     lsr     r4,r0,10h                               
0804456A 1C68     add     r0,r5,1                                 
0804456C 0600     lsl     r0,r0,18h                               
0804456E 0E05     lsr     r5,r0,18h                               
08044570 2D07     cmp     r5,7h                                   
08044572 D808     bhi     8044586h                                
08044574 1C38     mov     r0,r7                                   
08044576 1C21     mov     r1,r4                                   
08044578 F7CBF8D2 bl      800F720h                                
0804457C 2800     cmp     r0,0h                                   
0804457E D0F0     beq     8044562h                                
08044580 1C70     add     r0,r6,1                                 
08044582 0600     lsl     r0,r0,18h                               
08044584 0E06     lsr     r6,r0,18h                               
08044586 4B1F     ldr     r3,=3000738h                            
08044588 2E00     cmp     r6,0h                                   
0804458A D009     beq     @@peer                                
0804458C 481E     ldr     r0,=0FFC0h                              
0804458E 4004     and     r4,r0                                   
08044590 481E     ldr     r0,=30013D4h                            
08044592 8A40     ldrh    r0,[r0,12h]                             
08044594 42A0     cmp     r0,r4                                   
08044596 D203     bcs     @@peer  

@@Notouch:                              
08044598 8819     ldrh    r1,[r3]                                 
0804459A 481D     ldr     r0,=0F7FFh                              
0804459C 4008     and     r0,r1     ;F7FF and 取向   去掉800h                           
0804459E 8018     strh    r0,[r3]    

@@peer:                                 
080445A0 8819     ldrh    r1,[r3]                                 
080445A2 2080     mov     r0,80h                                  
080445A4 0100     lsl     r0,r0,4h                                
080445A6 4008     and     r0,r1     ;800 and 取向  判断是否触发                            
080445A8 2800     cmp     r0,0h                                   
080445AA D028     beq     @@end                                
080445AC 1C19     mov     r1,r3     ;以下为触发                              
080445AE 3124     add     r1,24h                                  
080445B0 2200     mov     r2,0h                                   
080445B2 2023     mov     r0,23h    ;pose 写入23h                              
080445B4 7008     strb    r0,[r1]                                 
080445B6 3108     add     r1,8h                                   
080445B8 2028     mov     r0,28h    ;3000764写入28h                              
080445BA 7008     strb    r0,[r1]                                 
080445BC 1C18     mov     r0,r3                                   
080445BE 3025     add     r0,25h                                  
080445C0 7002     strb    r2,[r0]   ;属性写0h                               
080445C2 4914     ldr     r1,=30001A8h                            
080445C4 22F0     mov     r2,0F0h                                 
080445C6 0052     lsl     r2,r2,1h                                
080445C8 1C10     mov     r0,r2                                   
080445CA 8008     strh    r0,[r1]    ;警报写入1e0h                             
080445CC 4A12     ldr     r2,=30001ACh                            
080445CE 21A8     mov     r1,0A8h                                 
080445D0 00C9     lsl     r1,r1,3h                                
080445D2 1850     add     r0,r2,r1                                
080445D4 4282     cmp     r2,r0      ;防止数据超出                             
080445D6 D212     bcs     @@end                                
080445D8 2501     mov     r5,1h                                   
080445DA 2420     mov     r4,20h                                  
080445DC 1C03     mov     r3,r0

@@loop2:                                   
080445DE 8811     ldrh    r1,[r2]    ;得到取向                             
080445E0 1C28     mov     r0,r5                                   
080445E2 4008     and     r0,r1      ;1 and 取向                             
080445E4 2800     cmp     r0,0h                                   
080445E6 D007     beq     @@next   ;判断是否是活着的精灵数据                             
080445E8 1C10     mov     r0,r2                                   
080445EA 3025     add     r0,25h                                  
080445EC 7800     ldrb    r0,[r0]                                 
080445EE 2814     cmp     r0,14h     ;读取属性,如果不是海盗属性的话?                             
080445F0 D102     bne     @@next                                
080445F2 1C08     mov     r0,r1                                   
080445F4 4320     orr     r0,r4      ;是海盗属性的话 取向 orr 20 触发就会如此?                            
080445F6 8010     strh    r0,[r2]

@@next:                                 
080445F8 3238     add     r2,38h                                  
080445FA 429A     cmp     r2,r3                                   
080445FC D3EF     bcc     @@loop2

@@end:                                
080445FE BCF0     pop     r4-r7                                   
08044600 BC01     pop     r0                                      
08044602 4700     bx      r0                                      

;副精灵pose23h                              
0804461C B500     push    r14                                     
0804461E 4A0D     ldr     r2,=3000738h                            
08044620 1C11     mov     r1,r2                                   
08044622 3126     add     r1,26h                                  
08044624 2001     mov     r0,1h                                   
08044626 7008     strb    r0,[r1] ;300075e写入1h                                
08044628 1C13     mov     r3,r2                                   
0804462A 332C     add     r3,2Ch                                  
0804462C 7819     ldrb    r1,[r3] ;读取3000764的值.之前触发写了28h                                
0804462E 2003     mov     r0,3h                                   
08044630 4008     and     r0,r1                                   
08044632 2800     cmp     r0,0h                                   
08044634 D103     bne     @@nozero                                
08044636 8810     ldrh    r0,[r2]                                 
08044638 2104     mov     r1,4h                                   
0804463A 4048     eor     r0,r1   ;取向 eor 4                               
0804463C 8010     strh    r0,[r2] 

@@nozero:                                
0804463E 7818     ldrb    r0,[r3]                                 
08044640 3801     sub     r0,1h    ;3000764减1                               
08044642 7018     strb    r0,[r3]                                 
08044644 0600     lsl     r0,r0,18h                               
08044646 0E00     lsr     r0,r0,18h                               
08044648 2800     cmp     r0,0h                                   
0804464A D100     bne     @@end                                
0804464C 8010     strh    r0,[r2]  ;彻底清空

@@end:                                
0804464E BC01     pop     r0                                      
08044650 4700     bx      r0                                      

/////////////////////////////////////////////////////////////////////////////////////////
.definelabel PoseTable,8044684h
.definelabel Deadth,8011084h

;主程序                             
08044658 B500     push    r14                                     
0804465A B081     add     sp,-4h                                  
0804465C 4807     ldr     r0,=3000738h                            
0804465E 1C02     mov     r2,r0                                   
08044660 3226     add     r2,26h                                  
08044662 2101     mov     r1,1h                                   
08044664 7011     strb    r1,[r2]                                 
08044666 1C01     mov     r1,r0                                   
08044668 3124     add     r1,24h                                  
0804466A 7809     ldrb    r1,[r1]                                 
0804466C 1C02     mov     r2,r0                                   
0804466E 2927     cmp     r1,27h                                  
08044670 D867     bhi     @@otherpose                                
08044672 0088     lsl     r0,r1,2h                                
08044674 4902     ldr     r1,=PoseTable                           
08044676 1840     add     r0,r0,r1                                
08044678 6800     ldr     r0,[r0]                                 
0804467A 4687     mov     r15,r0                                  
PoseTable:
    .word 8044724h  ;00
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 804472ah  ;09h
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 8044742h .word 8044742h .word 8044742h .word 8044742h
	.word 8044742h  
	.word 8044730h  ;23h
	.word 8044742h
	.word 8044736h  ;25h
	.word 8044742h
	.word 804473ch  ;27h
	
08044724 F7FFFD10 bl      8044148h  ;00                               
08044728 E014     b       @@end                                
0804472A F7FFFDF3 bl      8044314h  ;09h                               
0804472E E011     b       @@end                                
08044730 F7FFFE06 bl      8044340h  ;23h                              
08044734 E00E     b       @@end                                
08044736 F7FFFE15 bl      8044364h  ;25h                              
0804473A E00B     b       @@end                                
0804473C F7FFFE2E bl      804439Ch  ;27h                              
08044740 E008     b       @@end     

@@otherpose:                           
08044742 8851     ldrh    r1,[r2,2h]                              
08044744 3110     add     r1,10h                                  
08044746 8892     ldrh    r2,[r2,4h]                              
08044748 2021     mov     r0,21h                                  
0804474A 9000     str     r0,[sp]                                 
0804474C 2000     mov     r0,0h                                   
0804474E 2301     mov     r3,1h                                   
08044750 F7CCFC98 bl      Deadth  ;>>>死亡例程

@@end:                               
08044754 B001     add     sp,4h                                   
08044756 BC01     pop     r0                                      
08044758 4700     bx      r0                                      


;副精灵光线主程序                                
0804475C B500     push    r14                                     
0804475E 4B08     ldr     r3,=3000738h                            
08044760 1C18     mov     r0,r3                                   
08044762 3023     add     r0,23h      ;主精灵序号                            
08044764 7801     ldrb    r1,[r0]                                 
08044766 4A07     ldr     r2,=30001ACh                            
08044768 00C8     lsl     r0,r1,3h                                
0804476A 1A40     sub     r0,r0,r1                                
0804476C 00C0     lsl     r0,r0,3h                                
0804476E 1880     add     r0,r0,r2    ;得到副精灵数据地址                            
08044770 8800     ldrh    r0,[r0]                                 
08044772 2101     mov     r1,1h                                   
08044774 4001     and     r1,r0       ;1 and 取向                              
08044776 2900     cmp     r1,0h                                   
08044778 D106     bne     @@NOzero                                
0804477A 8019     strh    r1,[r3]     ;0? 写入 取向                            
0804477C E019     b       @@end                                

@@NOzero                              
08044788 1C18     mov     r0,r3                                   
0804478A 3024     add     r0,24h                                  
0804478C 7800     ldrb    r0,[r0]     ;读取取向                            
0804478E 2809     cmp     r0,9h                                   
08044790 D00A     beq     @@posenine                                
08044792 2809     cmp     r0,9h                                   
08044794 DC02     bgt     @@morethanine                                
08044796 2800     cmp     r0,0h                                   
08044798 D003     beq     @@posezero                                
0804479A E00A     b       @@end

@@morethanine:                                
0804479C 2823     cmp     r0,23h                                  
0804479E D006     beq     @@pose23H                                
080447A0 E007     b       @@end  

@@posezero:                              
080447A2 F7FFFE41 bl      8044428h                                
080447A6 E004     b       @@end   

@@posenine:                             
080447A8 F7FFFE7A bl      80444A0h                                
080447AC E001     b       @@end   

@@pose23H:                             
080447AE F7FFFF35 bl      804461Ch 

@end:                               
080447B2 BC01     pop     r0                                      
080447B4 4700     bx      r0                                      
////////////////////////////////////////////////////////////////////////////////
                          
;波副精灵主例程
080447B8 B5F0     push    r4-r7,r14                               
080447BA 4647     mov     r7,r8                                   
080447BC B480     push    r7                                      
080447BE 4C0B     ldr     r4,=3000738h                            
080447C0 1C23     mov     r3,r4                                   
080447C2 3324     add     r3,24h                                  
080447C4 781D     ldrb    r5,[r3]                                 
080447C6 2D00     cmp     r5,0h                                   
080447C8 D014     beq     @@posezero                                
080447CA 2D09     cmp     r5,9h                                   
080447CC D05D     beq     @@posenine 

;其他pose,撞墙                               
080447CE 8860     ldrh    r0,[r4,2h]                              
080447D0 3018     add     r0,18h                                  
080447D2 88A1     ldrh    r1,[r4,4h]                              
080447D4 2220     mov     r2,20h                                  
080447D6 F00FFC89 bl      80540ECh  ;设置爆炸效果                              
080447DA 8821     ldrh    r1,[r4]                                 
080447DC 2002     mov     r0,2h                                   
080447DE 4008     and     r0,r1     ;2 and 取向                                
080447E0 2800     cmp     r0,0h                                   
080447E2 D073     beq     @@outsidescreen                                
080447E4 4802     ldr     r0,=12Dh                                
080447E6 F7BEF917 bl      8002A18h  ;爆炸声                              
080447EA E06F     b       @@outsidescreen                                


@@posezero:                                
080447F4 8820     ldrh    r0,[r4]                                 
080447F6 4A1B     ldr     r2,=0FFFBh                              
080447F8 4002     and     r2,r0    ;fffb and 取向                               
080447FA 2000     mov     r0,0h                                   
080447FC 4680     mov     r8,r0                                   
080447FE 8022     strh    r2,[r4]  ;再写入                               
08044800 2132     mov     r1,32h                                  
08044802 1909     add     r1,r1,r4                                
08044804 468C     mov     r12,r1                                  
08044806 7809     ldrb    r1,[r1]                                 
08044808 2004     mov     r0,4h                                   
0804480A 4308     orr     r0,r1   ;4   orr 300076a的值                           
0804480C 4661     mov     r1,r12                                  
0804480E 7008     strb    r0,[r1]  ;再写入                               
08044810 1C20     mov     r0,r4                                   
08044812 3027     add     r0,27h                                  
08044814 2108     mov     r1,8h                                   
08044816 7001     strb    r1,[r0]  ;300075f写入8h                               
08044818 3001     add     r0,1h                                   
0804481A 7001     strb    r1,[r0]  ;3000760写入8h                               
0804481C 3001     add     r0,1h                                   
0804481E 2618     mov     r6,18h                                  
08044820 7006     strb    r6,[r0]  ;3000761写入18h                               
08044822 4F11     ldr     r7,=0FFE8h                              
08044824 8167     strh    r7,[r4,0Ah]  ;上部分界写入 fffe8h                          
08044826 81A6     strh    r6,[r4,0Ch]  ;下部分界写入18h                           
08044828 4810     ldr     r0,=8307614h                            
0804482A 61A0     str     r0,[r4,18h]  ;写入新OAM                           
0804482C 4640     mov     r0,r8                                   
0804482E 7720     strb    r0,[r4,1Ch]                             
08044830 82E5     strh    r5,[r4,16h]                             
08044832 2009     mov     r0,9h                                   
08044834 7018     strb    r0,[r3]      ;pose写入9h                           
08044836 1C21     mov     r1,r4                                   
08044838 3125     add     r1,25h                                  
0804483A 2006     mov     r0,6h                                   
0804483C 7008     strb    r0,[r1]     ;属性写入6h                            
0804483E 3903     sub     r1,3h                                   
08044840 2003     mov     r0,3h                                   
08044842 7008     strb    r0,[r1]     ;300075a写入3h                             
08044844 490A     ldr     r1,=3000088h                            
08044846 7B09     ldrb    r1,[r1,0Ch]  ;3000094的值                           
08044848 4008     and     r0,r1        ;3 and                           
0804484A 1C21     mov     r1,r4                                   
0804484C 3121     add     r1,21h                                  
0804484E 7008     strb    r0,[r1]     ;3000759写入新值                            
08044850 2040     mov     r0,40h                                  
08044852 4010     and     r0,r2       ;40 and 取向                            
08044854 0400     lsl     r0,r0,10h                               
08044856 0C00     lsr     r0,r0,10h                               
08044858 2800     cmp     r0,0h                                   
0804485A D00B     beq     @@faceleft                                
0804485C 81E5     strh    r5,[r4,0Eh] ;左部分界写入0                            
0804485E 8226     strh    r6,[r4,10h] ;右部分界写入18h                            
08044860 E00A     b       @@peer                                

@@faceleft:                              
08044874 81E7     strh    r7,[r4,0Eh]                             
08044876 8220     strh    r0,[r4,10h] 

@@peer:                            
08044878 4809     ldr     r0,=3000738h                            
0804487A 8801     ldrh    r1,[r0]                                 
0804487C 2002     mov     r0,2h                                   
0804487E 4008     and     r0,r1   ;2 and 取向                                
08044880 2800     cmp     r0,0h                                   
08044882 D002     beq     @@posenine                                
08044884 4807     ldr     r0,=26Dh  ;射光波声                              
08044886 F7BEF8C7 bl      8002A18h 

@@posenine:                               
0804488A 4A05     ldr     r2,=3000738h                            
0804488C 8811     ldrh    r1,[r2]                                 
0804488E 2040     mov     r0,40h                                  
08044890 4008     and     r0,r1   ;40 and 取向                                
08044892 1C14     mov     r4,r2                                   
08044894 2800     cmp     r0,0h                                   
08044896 D007     beq     @@faceleft                                
08044898 88A0     ldrh    r0,[r4,4h]  ;坐标加0Ch                            
0804489A 300C     add     r0,0Ch                                  
0804489C E006     b       @@peer                                

@@faceleft:                               
080448A8 88A0     ldrh    r0,[r4,4h]                              
080448AA 380C     sub     r0,0Ch  

@@peer:                                
080448AC 80A0     strh    r0,[r4,4h]                              
080448AE 8860     ldrh    r0,[r4,2h]   ;读取坐标                           
080448B0 88A1     ldrh    r1,[r4,4h]                              
080448B2 F7CAFEE9 bl      800F688h     ;检查砖块                           
080448B6 4804     ldr     r0,=30007F1h                            
080448B8 7800     ldrb    r0,[r0]                                 
080448BA 2800     cmp     r0,0h                                   
080448BC D009     beq     @@end                                
080448BE 1C21     mov     r1,r4                                   
080448C0 3124     add     r1,24h                                  
080448C2 2042     mov     r0,42h                                  
080448C4 7008     strb    r0,[r1]      ;pose写入42h                              
080448C6 E004     b       @@end                                

@@outsidescreen:                              
080448CC 4903     ldr     r1,=3000738h                            
080448CE 2000     mov     r0,0h                                   
080448D0 8008     strh    r0,[r1]   ;消失不见

@@end:                              
080448D2 BC08     pop     r3                                      
080448D4 4698     mov     r8,r3                                   
080448D6 BCF0     pop     r4-r7                                   
080448D8 BC01     pop     r0                                      
080448DA 4700     bx      r0 
