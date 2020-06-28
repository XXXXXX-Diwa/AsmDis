.definelabel playsound,8002B20h
.definelabel stunsprite,8011280h
.definelabel frozen,800FFE8h
.definelabel posetable,80405F4h
.definelabel spritedeath,8011084h
.definelabel PrimarySpriteStats,0x82B0D68
.definelabel checkpalette,8010798h
.definelabel checkpalette2,80108B0h 
.definelabel checkspritespawn,800FE48h
.definelabel changeoritation,800F8B0h

;pose 00
08040230 4B13     ldr     r3,=3000738h                            
08040232 4814     ldr     r0,=0FFE4h                              
08040234 8158     strh    r0,[r3,0Ah]                             
08040236 201C     mov     r0,1Ch                                  
08040238 8198     strh    r0,[r3,0Ch]                             
0804023A 4813     ldr     r0,=0FFE8h                              
0804023C 81D8     strh    r0,[r3,0Eh]                             
0804023E 2018     mov     r0,18h                                  
08040240 8218     strh    r0,[r3,10h]  ;四面分界                           
08040242 1C18     mov     r0,r3                                   
08040244 3027     add     r0,27h                                  
08040246 210A     mov     r1,0Ah       ;300075f写入ah                          
08040248 7001     strb    r1,[r0]                                 
0804024A 3001     add     r0,1h                                   
0804024C 7001     strb    r1,[r0]      ;3000760写入ah                             
0804024E 1C19     mov     r1,r3                                   
08040250 3129     add     r1,29h       ;3000761写入0ch                           
08040252 200C     mov     r0,0Ch                                  
08040254 7008     strb    r0,[r1]                                 
08040256 3104     add     r1,4h                                   
08040258 2001     mov     r0,1h        ;3000765写入1h 产卵次数 偏移2D                            
0804025A 7008     strb    r0,[r1]                                 
0804025C 4A0B     ldr     r2,=PrimarySpriteStats                            
0804025E 7F59     ldrb    r1,[r3,1Dh]                             
08040260 00C8     lsl     r0,r1,3h                                
08040262 1840     add     r0,r0,r1                                
08040264 0040     lsl     r0,r0,1h                                
08040266 1880     add     r0,r0,r2     ;ID的18倍加偏移值                            
08040268 8800     ldrh    r0,[r0]                                 
0804026A 8298     strh    r0,[r3,14h]   ;写入血量                          
0804026C 8859     ldrh    r1,[r3,2h]                              
0804026E 3920     sub     r1,20h        ;垂直坐标上移半格                          
08040270 8059     strh    r1,[r3,2h]                              
08040272 8898     ldrh    r0,[r3,4h]                              
08040274 3020     add     r0,20h        ;水平坐标右移半格                           
08040276 8098     strh    r0,[r3,4h]                              
08040278 80D9     strh    r1,[r3,6h]    ;备份XY坐标                         
0804027A 8118     strh    r0,[r3,8h]                              
0804027C 4770     bx      r14                                     

;pose 8h                               
08040290 4B0B     ldr     r3,=3000738h                            
08040292 1C18     mov     r0,r3                                   
08040294 3025     add     r0,25h                                  
08040296 2200     mov     r2,0h                                   
08040298 7002     strb    r2,[r0]       ;属性写入0                           
0804029A 1C19     mov     r1,r3                                   
0804029C 3124     add     r1,24h                                  
0804029E 2009     mov     r0,9h         ;pose写入9h                          
080402A0 7008     strb    r0,[r1]                                 
080402A2 4808     ldr     r0,=82FDA50h                            
080402A4 6198     str     r0,[r3,18h]                           
080402A6 2000     mov     r0,0h                                   
080402A8 82DA     strh    r2,[r3,16h]                             
080402AA 7718     strb    r0,[r3,1Ch]                             
080402AC 8818     ldrh    r0,[r3]                                 
080402AE 4A06     ldr     r2,=8004h                               
080402B0 1C11     mov     r1,r2                                   
080402B2 4308     orr     r0,r1         ;取向 orr 8004h  看不见                        
080402B4 8018     strh    r0,[r3]                                 
080402B6 1C19     mov     r1,r3                                   
080402B8 3121     add     r1,21h                                  
080402BA 2002     mov     r0,2h                                   
080402BC 7008     strb    r0,[r1]       ;偏移21,图层在砖图前-                        
080402BE 4770     bx      r14    
                                 
;pose 9h                               
080402CC B530     push    r4,r5,r14                               
080402CE B083     add     sp,-0Ch                                 
080402D0 4C06     ldr     r4,=3000738h                            
080402D2 7F60     ldrb    r0,[r4,1Dh]                             
080402D4 28A0     cmp     r0,0A0h                                 
080402D6 D10D     bne     @@IDNOA0     ;ID不为A0跳转                           
080402D8 1C21     mov     r1,r4        ;为A0则自动写入pose 23                           
080402DA 3124     add     r1,24h                                  
080402DC 2023     mov     r0,23h       ;pose写入23h                           
080402DE 7008     strb    r0,[r1]                                 
080402E0 8821     ldrh    r1,[r4]                                 
080402E2 4803     ldr     r0,=7FFBh                               
080402E4 4008     and     r0,r1        ;7ffb and 8004=0 去掉8004                          
080402E6 8020     strh    r0,[r4]                                 
080402E8 E06E     b       @@end                                 

@@IDNOA0:                           ;ID不是A0跳转                              
080402F4 289F     cmp     r0,9Fh                                  
080402F6 D104     bne     @@IDNO9F                                
080402F8 20A0     mov     r0,0A0h      ;ID是9f的话检验是否有A0h                           
080402FA F7D0FA4D bl      checkpalette  ;检查A0这个精灵是否还活着                       
080402FE 2800     cmp     r0,0h         ;活着则结束                        
08040300 D162     bne     @@end        

@@IDNO9F:                              
08040302 F7D0FAD5 bl      checkpalette2 ;精灵的补给活着返回1                          
08040306 2800     cmp     r0,0h                                   
08040308 D15E     bne     @@end                                
0804030A 1C21     mov     r1,r4                                   
0804030C 312D     add     r1,2Dh                                  
0804030E 7808     ldrb    r0,[r1]                                 
08040310 2800     cmp     r0,0h      ;再生值为0跳转                            
08040312 D002     beq     @@respawn                               
08040314 3801     sub     r0,1h                                   
08040316 7008     strb    r0,[r1]    ;否则减1写入然后结束                             
08040318 E056     b       @@end      ;用来延迟精灵多久再生

@@respawn:                              
0804031A 4806     ldr     r0,=30013D4h                             
0804031C 8A81     ldrh    r1,[r0,14h]   ;人物垂直坐标                          
0804031E 8A43     ldrh    r3,[r0,12h]   ;人物水平坐标                          
08040320 8860     ldrh    r0,[r4,2h]    ;精灵垂直坐标                          
08040322 88A2     ldrh    r2,[r4,4h]    ;精灵水平坐标                          
08040324 381E     sub     r0,1Eh        ;人物垂直坐标大于精灵垂直坐标上IEh                          
08040326 4281     cmp     r1,r0         ;人物在精灵Y坐标加1E的下面                         
08040328 DC4E     bgt     @@end         ;大于则结束 也就是没有达到一定高度                      
0804032A 429A     cmp     r2,r3                                   
0804032C D904     bls     @@rightsprite ;如果人物在精灵右边则跳转                         
0804032E 1AD0     sub     r0,r2,r3      ;精灵与人物的距离                          
08040330 E003     b       @@leftsprite                                

@@rightsprite:                           
08040338 1A98     sub     r0,r3,r2      ;精灵与人物的距离
@@leftsprite:                         
0804033A 2824     cmp     r0,24h                                  
0804033C DD44     ble     @@end         ;距离太近则结束 基本是在精灵上                       
0804033E 21A0     mov     r1,0A0h                                 
08040340 0049     lsl     r1,r1,1h                                
08040342 1C08     mov     r0,r1         ;140h                          
08040344 F7CFFD80 bl      checkspritespawn ;检查精灵是否这个范围内                               
08040348 2801     cmp     r0,1h                                   
0804034A D13D     bne     @@end         ;不为1结束                       
0804034C 4D20     ldr     r5,=3000738h                            
0804034E 4821     ldr     r0,=30013D4h                            
08040350 8A80     ldrh    r0,[r0,14h]   ;读取人物的Y坐标                          
08040352 8268     strh    r0,[r5,12h]   ;写入偏移12                          
08040354 1C29     mov     r1,r5                                   
08040356 3124     add     r1,24h                                  
08040358 2023     mov     r0,23h        ;pose写入23h                          
0804035A 7008     strb    r0,[r1]                                 
0804035C 1C28     mov     r0,r5                                   
0804035E 302C     add     r0,2Ch                                  
08040360 2402     mov     r4,2h         ;偏移2C写入2                         
08040362 7004     strb    r4,[r0]       ;3000764写入2h                          
08040364 8829     ldrh    r1,[r5]                                 
08040366 481C     ldr     r0,=7FFBh                               
08040368 4008     and     r0,r1         ;去掉精灵的不显示取向                         
0804036A 8028     strh    r0,[r5]                                 
0804036C F7CFFAA0 bl      changeoritation  ;根据人物位置而改变精灵的面向                              
08040370 8828     ldrh    r0,[r5]                                 
08040372 4004     and     r4,r0         ;检查是否在屏幕内                          
08040374 2C00     cmp     r4,0h                                   
08040376 D002     beq     @@pass                                
08040378 4818     ldr     r0,=183h                                
0804037A F7C2FB4D bl      8002A18h      ;播放嗡嗡声
 
@@pass: 
0804037E 7F68     ldrb    r0,[r5,1Dh]                             
08040380 289F     cmp     r0,9Fh      ;如果ID不是9f则结束                            
08040382 D121     bne     @@end                                
08040384 7FA9     ldrb    r1,[r5,1Eh] ;副精灵再生产计数                           
08040386 7FEA     ldrb    r2,[r5,1Fh] ;精灵gfx slot                            
08040388 1C28     mov     r0,r5                                   
0804038A 3023     add     r0,23h                                  
0804038C 7803     ldrb    r3,[r0]     ;主精灵序号                           
0804038E 8868     ldrh    r0,[r5,2h]  ;精灵垂直坐标                            
08040390 30A0     add     r0,0A0h                                 
08040392 9000     str     r0,[sp]     ;加a0h写入sp                            
08040394 88A8     ldrh    r0,[r5,4h]  ;精灵水平坐标                            
08040396 3820     sub     r0,20h                                  
08040398 9001     str     r0,[sp,4h]  ;减20h写入sp+4                            
0804039A 882C     ldrh    r4,[r5]                                 
0804039C 2040     mov     r0,40h                                  
0804039E 4020     and     r0,r4       ;40与取向and                            
080403A0 0400     lsl     r0,r0,10h                               
080403A2 0C00     lsr     r0,r0,10h                               
080403A4 9002     str     r0,[sp,8h]  ;写入sp+8,用于区分方向?                             
080403A6 20A0     mov     r0,0A0h                                 
080403A8 F7CEF814 bl      800E3D4h    ;生产A0精灵                            
080403AC 0600     lsl     r0,r0,18h                               
080403AE 0E02     lsr     r2,r0,18h                               
080403B0 2AFF     cmp     r2,0FFh     ;返回了生产的精灵的精灵槽序号                             
080403B2 D009     beq     @@end                                
080403B4 490A     ldr     r1,=30001ACh                            
080403B6 00D0     lsl     r0,r2,3h                                
080403B8 1A80     sub     r0,r0,r2                                
080403BA 00C0     lsl     r0,r0,3h                                
080403BC 1840     add     r0,r0,r1    ;56倍加偏移值                            
080403BE 8A69     ldrh    r1,[r5,12h] ;读取要上升的Y坐标                            
080403C0 8241     strh    r1,[r0,12h] ;写入同样的地方                            
080403C2 302C     add     r0,2Ch                                  
080403C4 2112     mov     r1,12h                                  
080403C6 7001     strb    r1,[r0] ;A0的偏移2C写入12h

@@end:                                
080403C8 B003     add     sp,0Ch  ;当然A0在pose9会直接写入POSE23                                
080403CA BC30     pop     r4,r5                                   
080403CC BC01     pop     r0                                      
080403CE 4700     bx      r0    

;pose 23h                                                               
080403E4 B500     push    r14                                     
080403E6 4909     ldr     r1,=3000738h                            
080403E8 8848     ldrh    r0,[r1,2h]                              
080403EA 3808     sub     r0,8h                                   
080403EC 8048     strh    r0,[r1,2h]   ;垂直坐标上移8h                           
080403EE 1C0A     mov     r2,r1                                   
080403F0 322C     add     r2,2Ch                                  
080403F2 7810     ldrb    r0,[r2]      ;读取偏移的2C的值                           
080403F4 1C0B     mov     r3,r1                                   
080403F6 2800     cmp     r0,0h                                   
080403F8 D00A     beq     @@pass                               
080403FA 3801     sub     r0,1h        ;不为0则减1再写入                           
080403FC 7010     strb    r0,[r2]                                 
080403FE 0600     lsl     r0,r0,18h                               
08040400 2800     cmp     r0,0h        ;减1后不为0则结束                          
08040402 D12A     bne     @@end                                
08040404 3125     add     r1,25h       ;为0则属性写入4h                          
08040406 2004     mov     r0,4h                                   
08040408 E026     b       @@come                               

@@pass:                              
08040410 4806     ldr     r0,=30013D4h                            
08040412 8A59     ldrh    r1,[r3,12h]  ;读取要上升的Y坐标                         
08040414 1C02     mov     r2,r0                                   
08040416 8A90     ldrh    r0,[r2,14h]  ;读取人物的Y坐标                           
08040418 4281     cmp     r1,r0                                   
0804041A D209     bcs     8040430h     ;要上升的坐标仍然在人物的Y坐标之下则跳转
;--------------------------------------人物的当前坐标在定位Y坐标之下                       
0804041C 8A91     ldrh    r1,[r2,14h]  ;人物的Y坐标                           
0804041E 88D8     ldrh    r0,[r3,6h]   ;和精灵的备份Y坐标                           
08040420 3880     sub     r0,80h       ;精灵生产坐标处向上两格的高度                           
08040422 4281     cmp     r1,r0        ;人物的坐标比较精灵生产出向上两格                           
08040424 DD04     ble     8040430h     ;人物如果高于精灵原坐标向上两格                           
08040426 8A58     ldrh    r0,[r3,12h]  ;读取要上升的Y坐标                           
08040428 E003     b       8040432h                                

                              
08040430 8A90     ldrh    r0,[r2,14h]  ;读取人物的Y坐标                             
08040432 3864     sub     r0,64h       ;向上64h                           
08040434 8859     ldrh    r1,[r3,2h]   ;读取精灵的当前Y坐标                           
08040436 4288     cmp     r0,r1                                   
08040438 DD0F     ble     @@end        ;人物仍在上面则结束                               
0804043A 1C19     mov     r1,r3                                   
0804043C 3124     add     r1,24h       ;否则pose写入25                           
0804043E 2200     mov     r2,0h                                   
08040440 2025     mov     r0,25h                                  
08040442 7008     strb    r0,[r1]                                 
08040444 3108     add     r1,8h                                   
08040446 200A     mov     r0,0Ah                                  
08040448 7008     strb    r0,[r1]      ;偏移2c写入0Ah                            
0804044A 4805     ldr     r0,=82FDA78h ;写入向前飞行的OAM                           
0804044C 6198     str     r0,[r3,18h]                             
0804044E 2000     mov     r0,0h                                   
08040450 82DA     strh    r2,[r3,16h]                             
08040452 7718     strb    r0,[r3,1Ch]                             
08040454 390B     sub     r1,0Bh                                  
08040456 2001     mov     r0,1h        ;图层的先后写为1
@@come:                                 
08040458 7008     strb    r0,[r1]      ;属性写入4

@@end:                                
0804045A BC01     pop     r0                                      
0804045C 4700     bx      r0                                      


;pose25调用                          
08040464 B530     push    r4,r5,r14                               
08040466 4D03     ldr     r5,=3000738h                            
08040468 7F68     ldrb    r0,[r5,1Dh]                             
0804046A 28A0     cmp     r0,0A0h                                 
0804046C D104     bne     @@Normal
;===============================A0的设置                                
0804046E 2000     mov     r0,0h                                   
08040470 8028     strh    r0,[r5]      ;直接消失                          
08040472 E024     b       80404BEh                                

@@Normal:                              
08040478 88E8     ldrh    r0,[r5,6h]   ;读取备份的Y坐标                            
0804047A 2400     mov     r4,0h                                   
0804047C 8068     strh    r0,[r5,2h]   ;写入当前的Y坐标                            
0804047E 8928     ldrh    r0,[r5,8h]   ;读取备份的x坐标                         
08040480 80A8     strh    r0,[r5,4h]   ;同样                           
08040482 F7FFFF05 bl      8040290h     ;调用pose 8初始化不显示的精灵                           
08040486 1C29     mov     r1,r5                                   
08040488 312D     add     r1,2Dh                                  
0804048A 203C     mov     r0,3Ch                                  
0804048C 7008     strb    r0,[r1]      ;偏移2D写入3C                            
0804048E 4A0D     ldr     r2,=82B0D68h                            
08040490 7F69     ldrb    r1,[r5,1Dh]                             
08040492 00C8     lsl     r0,r1,3h                                
08040494 1840     add     r0,r0,r1                                
08040496 0040     lsl     r0,r0,1h                                
08040498 1880     add     r0,r0,r2                                
0804049A 8800     ldrh    r0,[r0]                                 
0804049C 82A8     strh    r0,[r5,14h]  ;重新写入满血量                           
0804049E 1C28     mov     r0,r5                                   
080404A0 302B     add     r0,2Bh                                  
080404A2 7004     strb    r4,[r0]      ;击晕时间写入0>>>                            
080404A4 380B     sub     r0,0Bh                                  
080404A6 7004     strb    r4,[r0]      ;调色板写入0号                           
080404A8 3013     add     r0,13h                                  
080404AA 7004     strb    r4,[r0]      ;偏移33写入0:>>>>                           
080404AC 3001     add     r0,1h                                   
080404AE 7004     strb    r4,[r0]      ;击打变色值写入1                           
080404B0 1C29     mov     r1,r5                                   
080404B2 3126     add     r1,26h                                  
080404B4 2001     mov     r0,1h                                   
080404B6 7008     strb    r0,[r1]      ;待机值写入1 自动减                           
080404B8 1C28     mov     r0,r5                                   
080404BA 3030     add     r0,30h       ;冰冻时间写入0                           
080404BC 7004     strb    r4,[r0] 

@@end:                                
080404BE BC30     pop     r4,r5                                   
080404C0 BC01     pop     r0                                      
080404C2 4700     bx      r0                                      

;pose 25h                              
080404C8 B530     push    r4,r5,r14                               
080404CA 490D     ldr     r1,=3000738h                            
080404CC 1C0A     mov     r2,r1                                   
080404CE 322C     add     r2,2Ch     ;读取偏移2C的值                            
080404D0 7810     ldrb    r0,[r2]                                 
080404D2 1C0C     mov     r4,r1                                   
080404D4 2800     cmp     r0,0h                                   
080404D6 D015     beq     @@764=zero                                
080404D8 3801     sub     r0,1h      ;不为0的话减1再写入                            
080404DA 7010     strb    r0,[r2]                                 
080404DC 0600     lsl     r0,r0,18h                               
080404DE 0E05     lsr     r5,r0,18h                               
080404E0 2D00     cmp     r5,0h                                   
080404E2 D150     bne     @@end      

;为1的时候                          
080404E4 8821     ldrh    r1,[r4]                                    
080404E6 2002     mov     r0,2h                                   
080404E8 4008     and     r0,r1                                   
080404EA 2800     cmp     r0,0h      ;检查是否在屏幕内                               
080404EC D003     beq     @@NoPlaySound                               
080404EE 20C2     mov     r0,0C2h                                 
080404F0 0040     lsl     r0,r0,1h                                
080404F2 F7C2FA91 bl      8002A18h   ;播放飞行的声音

@@NoPlaySound:                              
080404F6 1C20     mov     r0,r4                                   
080404F8 302D     add     r0,2Dh                                  
080404FA 7005     strb    r5,[r0]    ;偏移2D写入0                               
080404FC E043     b       @@end                                
 

@@764=zero:                             
08040504 1C21     mov     r1,r4                                   
08040506 312D     add     r1,2Dh                                   
08040508 7808     ldrb    r0,[r1]    ;读取偏移2D的值                             
0804050A 3001     add     r0,1h                                   
0804050C 7008     strb    r0,[r1]    ;再生值加1写入                                
0804050E 8821     ldrh    r1,[r4]                                 
08040510 2040     mov     r0,40h                                  
08040512 4008     and     r0,r1                                   
08040514 2800     cmp     r0,0h         ;检查面向                            
08040516 D011     beq     @@left                                
08040518 88A2     ldrh    r2,[r4,4h]    ;精灵水平                          
0804051A 4807     ldr     r0,=30013D4h                            
0804051C 8A40     ldrh    r0,[r0,12h]   ;人物水平                          
0804051E 1A10     sub     r0,r2,r0      ;人物水平减去精灵水平                          
08040520 2180     mov     r1,80h                                  
08040522 00C9     lsl     r1,r1,3h                                
08040524 4288     cmp     r0,r1         ;和400h相比,ah格?                              
08040526 DC16     bgt     @@goto        ;两者的距离大于10格                        
08040528 2080     mov     r0,80h                                  
0804052A 0200     lsl     r0,r0,8h                                
0804052C 4010     and     r0,r2         ;精灵水平坐标达到了8000h?                          
0804052E 2800     cmp     r0,0h                                   
08040530 D111     bne     @@goto                               
08040532 1C10     mov     r0,r2                                   
08040534 300C     add     r0,0Ch         ;移动速度加                          
08040536 E015     b       @@SpeedWrite                                


@@left:                              
0804053C 4807     ldr     r0,=30013D4h                            
0804053E 8A40     ldrh    r0,[r0,12h]    ;人物水平坐标                         
08040540 88A2     ldrh    r2,[r4,4h]     ;精灵水平坐标                         
08040542 1A80     sub     r0,r0,r2                                
08040544 2180     mov     r1,80h                                  
08040546 00C9     lsl     r1,r1,3h                                
08040548 4288     cmp     r0,r1                                   
0804054A DC04     bgt     @@goto                               
0804054C 2080     mov     r0,80h                                  
0804054E 0200     lsl     r0,r0,8h                                
08040550 4010     and     r0,r2                                   
08040552 2800     cmp     r0,0h                                   
08040554 D004     beq     @@Pass 

@@goto:                               
08040556 F7FFFF85 bl      8040464h                                
0804055A E014     b       @@end                                

@@Pass:                              
08040560 1C10     mov     r0,r2                                   
08040562 380C     sub     r0,0Ch      ;移动速度?

@@SpeedWrite:                               
08040564 80A0     strh    r0,[r4,4h]  ;写入移动的速度                            
08040566 1C20     mov     r0,r4                                   
08040568 302D     add     r0,2Dh                                  
0804056A 7801     ldrb    r1,[r0]     ;读取偏移2D的值                               
0804056C 200F     mov     r0,0Fh                                  
0804056E 4008     and     r0,r1                                   
08040570 2800     cmp     r0,0h       ;只有当尾数为0的时候才不会结束                              
08040572 D108     bne     @@end                                
08040574 8821     ldrh    r1,[r4]                                 
08040576 2002     mov     r0,2h                                   
08040578 4008     and     r0,r1                                   
0804057A 2800     cmp     r0,0h                                   
0804057C D003     beq     @@end       ;不再屏幕内则积水                         
0804057E 20C2     mov     r0,0C2h                                 
08040580 0040     lsl     r0,r0,1h                                
08040582 F7C2FA49 bl      8002A18h    ;播放飞行的声音

@@end:                                
08040586 BC30     pop     r4,r5                                   
08040588 BC01     pop     r0                                      
0804058A 4700     bx      r0                 

/////////////////////////////////////////////////////////////////////////////////////////
;主程序
0804058C B510     push    r4,r14                                  
0804058E B081     add     sp,-4h                                  
08040590 490E     ldr     r1,=3000738h                            
08040592 1C0B     mov     r3,r1                                   
08040594 3332     add     r3,32h      ;300076a                            
08040596 781A     ldrb    r2,[r3]                                 
08040598 2402     mov     r4,2h                                   
0804059A 1C20     mov     r0,r4                                   
0804059C 4010     and     r0,r2       ;检查碰撞属性是否为0                            
0804059E 2800     cmp     r0,0h                                   
080405A0 D00A     beq     @@frozencheck                                
080405A2 20FD     mov     r0,0FDh                                 
080405A4 4010     and     r0,r2                                   
080405A6 7018     strb    r0,[r3]     ;不为0的话说清0?                            
080405A8 8809     ldrh    r1,[r1]                                 
080405AA 1C20     mov     r0,r4                                   
080405AC 4008     and     r0,r1       ;2 and 3000738                            
080405AE 2800     cmp     r0,0h                                   
080405B0 D002     beq     @@frozencheck                                
080405B2 4807     ldr     r0,=185h    ;翅膀嗡嗡声                            
080405B4 F7C2FAB4 bl      playsound    

@@frozencheck:                            
080405B8 4C04     ldr     r4,=3000738h                            
080405BA 1C20     mov     r0,r4                                   
080405BC 3030     add     r0,30h     ;3000768                             
080405BE 7800     ldrb    r0,[r0]                                 
080405C0 2800     cmp     r0,0h      ;检查冰冻是否成立                             
080405C2 D007     beq     @@nofrozen                                
080405C4 F7CFFD10 bl      frozen                                
080405C8 E078     b       @@end                                 

@@nofrozen:                               
080405D4 F7D0FE54 bl      stunsprite                                
080405D8 2800     cmp     r0,0h                                   
080405DA D16F     bne     @@end                                
080405DC 1C20     mov     r0,r4                                   
080405DE 3024     add     r0,24h                                  
080405E0 7800     ldrb    r0,[r0]                                 
080405E2 2825     cmp     r0,25h                                  
080405E4 D85F     bhi     @@otherpose   ;pose如果大于25跳转                             
080405E6 0080     lsl     r0,r0,2h                                
080405E8 4901     ldr     r1,=posetable                            
080405EA 1840     add     r0,r0,r1                                
080405EC 6800     ldr     r0,[r0]                                 
080405EE 4687     mov     r15,r0 

posetable: 
    .word 804068ch ;00
    .word 80406a6h .word 80406a6h .word 80406a6h .word 80406a6h
	.word 80406a6h .word 80406a6h .word 80406a6h
	.word 8040690h ;8h
    .word 8040694h ;9h
    .word 80406a6h .word 80406a6h .word 80406a6h .word 80406a6h
	.word 80406a6h .word 80406a6h .word 80406a6h .word 80406a6h
	.word 80406a6h .word 80406a6h .word 80406a6h .word 80406a6h
	.word 80406a6h .word 80406a6h .word 80406a6h .word 80406a6h
	.word 80406a6h .word 80406a6h .word 80406a6h .word 80406a6h
	.word 80406a6h .word 80406a6h .word 80406a6h .word 80406a6h
	.word 80406a6h 
	.word 804069ah ;23h
    .word 80406a6h 
	.word 80406a0h ;25h
	
0804068C F7FFFDD0 bl      8040230h  ;00                              
08040690 F7FFFDFE bl      8040290h  ;8h                              
08040694 F7FFFE1A bl      80402CCh  ;9h    消失后                           
08040698 E010     b       @@end                                
0804069A F7FFFEA3 bl      80403E4h  ;23h   上升                         
0804069E E00D     b       @@end                                
080406A0 F7FFFF12 bl      80404C8h  ;25h   前行                           
080406A4 E00A     b       @@end  

@@otherpose:                              
080406A6 4807     ldr     r0,=3000738h                            
080406A8 8841     ldrh    r1,[r0,2h]                              
080406AA 8882     ldrh    r2,[r0,4h]                              
080406AC 2020     mov     r0,20h                                  
080406AE 9000     str     r0,[sp]                                 
080406B0 2001     mov     r0,1h                                   
080406B2 2301     mov     r3,1h                                   
080406B4 F7D0FCE6 bl      spritedeath                                
080406B8 F7FFFED4 bl      8040464h

@@end:                                
080406BC B001     add     sp,4h                                   
080406BE BC10     pop     r4                                      
080406C0 BC01     pop     r0                                      
080406C2 4700     bx      r0                                      


.align
UpMoveOAM:
    .word UpMoveOAM1
    .word 0x3
	.word UpMoveOAM2
	.word 0x3
	.word UpMoveOAM3
	.word 0x3
	.word 0,0
	
UpMoveOAM1:
    .halfword 0x1
	.halfword 0xf8,0x41f8,0x8200

UpMoveOAM2:
    .halfword 0x1	
    .halfword 0xf8,0x41f8,0x8202

UpMoveOAM3:
    .halfword 0x1	
    .halfword 0xf8,0x41f8,0x8204

.align
MoveOAM:
    .word UpMoveOAM2          ;正常移动
    .word 0x80
	.word WillAccOAM
	.word 0xf
	.word FastSpeedMoveOAM 
    .word 0x40	
    .word 0,0

WillAccOAM:
    .halfword 0x1
	.halfword 0xf8,0x41f8,0x8206
	
FastSpeedMoveOAM:
    .halfword 0x1
    .halfword 0xf8,0x41f8,0x8208	
	
