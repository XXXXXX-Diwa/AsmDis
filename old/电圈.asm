.definelabel Frozen,800FFE8h
.definelabel PlaySound,8002B20h
.definelabel StunSprite,8011280h
.definelabel PoseTable,8049064h
.definelabel DeathFireworks,spritedeath
.definelabel PriSpriteDateStart,82B0D68h
.definelabel CheckClip,800F688h
.definelabel CheckSpriteScope,800FDE0h
.definelabel CheckAnimation,800FBC8h
.definelabel DeathCheck,80108B0h

;pose 0
0803630C B500     push    r14                                     
0803630E 4821     ldr     r0,=3000738h                            
08036310 4684     mov     r12,r0                                  
08036312 2300     mov     r3,0h                                   
08036314 4920     ldr     r1,=0FFECh                              
08036316 8141     strh    r1,[r0,0Ah]                             
08036318 2014     mov     r0,14h                                  
0803631A 4662     mov     r2,r12                                  
0803631C 8190     strh    r0,[r2,0Ch]                              
0803631E 81D1     strh    r1,[r2,0Eh]                             
08036320 8210     strh    r0,[r2,10h]  ;四面分界各14h                           
08036322 4660     mov     r0,r12                                  
08036324 3027     add     r0,27h                                  
08036326 2108     mov     r1,8h                                   
08036328 7001     strb    r1,[r0]      ;300075f写入8h                             
0803632A 3001     add     r0,1h                                   
0803632C 7001     strb    r1,[r0]      ;3000760写入8h                           
0803632E 3001     add     r0,1h                                   
08036330 7001     strb    r1,[r0]      ;3000761写入8h                           
08036332 4A1A     ldr     r2,=82B0D68h                            
08036334 4660     mov     r0,r12                                  
08036336 7F41     ldrb    r1,[r0,1Dh]                             
08036338 00C8     lsl     r0,r1,3h                                
0803633A 1840     add     r0,r0,r1                                
0803633C 0040     lsl     r0,r0,1h                                
0803633E 1880     add     r0,r0,r2                                
08036340 8800     ldrh    r0,[r0]                                   
08036342 4661     mov     r1,r12                                  
08036344 8288     strh    r0,[r1,14h]  ;写入血量                           
08036346 8848     ldrh    r0,[r1,2h]   ;Y坐标上抬半格                           
08036348 3820     sub     r0,20h                                  
0803634A 8048     strh    r0,[r1,2h]                              
0803634C 8848     ldrh    r0,[r1,2h]                              
0803634E 3820     sub     r0,20h                                  
08036350 1180     asr     r0,r0,6h                                
08036352 312F     add     r1,2Fh                                  
08036354 7008     strb    r0,[r1]      ;3000767写入Y坐标上一格的64分之一                           
08036356 4662     mov     r2,r12                                  
08036358 8890     ldrh    r0,[r2,4h]                              
0803635A 3820     sub     r0,20h                                  
0803635C 1180     asr     r0,r0,6h                                
0803635E 3901     sub     r1,1h                                   
08036360 7008     strb    r0,[r1]      ;3000766写入X坐标左半格的64分之一                            
08036362 3909     sub     r1,9h                                   
08036364 2004     mov     r0,4h                                   
08036366 7008     strb    r0,[r1]      ;属性写入4h                            
08036368 3903     sub     r1,3h                                   
0803636A 2003     mov     r0,3h                                   
0803636C 7008     strb    r0,[r1]      ;300075a写入3h                           
0803636E 490C     ldr     r1,=3000088h                            
08036370 7B09     ldrb    r1,[r1,0Ch]                             
08036372 4008     and     r0,r1        ;3 and 3000094                            
08036374 4661     mov     r1,r12                                  
08036376 3121     add     r1,21h                                  
08036378 7008     strb    r0,[r1]      ;写入3000759                           
0803637A 4660     mov     r0,r12                                  
0803637C 302D     add     r0,2Dh                                  
0803637E 7003     strb    r3,[r0]      ;再生产时间写入0                           
08036380 7F50     ldrb    r0,[r2,1Dh]                             
08036382 28A5     cmp     r0,0A5h                                 
08036384 D004     beq     @@end                                
08036386 2866     cmp     r0,66h                                  
08036388 D002     beq     @@end                                
0803638A 3112     add     r1,12h                                  
0803638C 2001     mov     r0,1h                                   
0803638E 7008     strb    r0,[r1]      ;300076b写入1h

@@end:                                 
08036390 BC01     pop     r0                                      
08036392 4700     bx      r0  

;pose 8h                                                                   
080363A4 B500     push    r14                                     
080363A6 4B09     ldr     r3,=3000738h                            
080363A8 1C19     mov     r1,r3                                   
080363AA 3124     add     r1,24h       ;pose写入9h                           
080363AC 2200     mov     r2,0h                                   
080363AE 2009     mov     r0,9h                                   
080363B0 7008     strb    r0,[r1]                                 
080363B2 2100     mov     r1,0h                                   
080363B4 82DA     strh    r2,[r3,16h] ;动画和帧归零                            
080363B6 7719     strb    r1,[r3,1Ch]                             
080363B8 7F58     ldrb    r0,[r3,1Dh]                             
080363BA 28A5     cmp     r0,0A5h                                 
080363BC D10A     bne     @@Nogreenmoon                                
080363BE 8818     ldrh    r0,[r3]                                 
080363C0 2120     mov     r1,20h                                  
080363C2 4308     orr     r0,r1       ;取向orr20                             
080363C4 8018     strh    r0,[r3]     ;再写入                            
080363C6 4802     ldr     r0,=82EE670h ;写入OAM                           
080363C8 E005     b       @@peer                                

@@Nogreenmoon:                              
080363D4 4801     ldr     r0,=82EE568h 

@@peer:                           
080363D6 6198     str     r0,[r3,18h]                             
080363D8 BC01     pop     r0                                      
080363DA 4700     bx      r0


;otherpose经历                              
080363E0 B530     push    r4,r5,r14                               
080363E2 4D18     ldr     r5,=3000738h                            
080363E4 1C28     mov     r0,r5                                   
080363E6 302F     add     r0,2Fh                                  
080363E8 7800     ldrb    r0,[r0]   ;读取3000767 之前写入的坐标                               
080363EA 0180     lsl     r0,r0,6h                                
080363EC 3020     add     r0,20h                                  
080363EE 2400     mov     r4,0h                                   
080363F0 8068     strh    r0,[r5,2h] ;重新写入                             
080363F2 1C28     mov     r0,r5                                   
080363F4 302E     add     r0,2Eh                                  
080363F6 7800     ldrb    r0,[r0]                                 
080363F8 0180     lsl     r0,r0,6h                                
080363FA 3020     add     r0,20h                                  
080363FC 80A8     strh    r0,[r5,4h] ;重新写入                             
080363FE F7FFFFD1 bl      80363A4h   ;pose 8h                             
08036402 4A11     ldr     r2,=82B0D68h                            
08036404 7F69     ldrb    r1,[r5,1Dh]                             
08036406 00C8     lsl     r0,r1,3h                                
08036408 1840     add     r0,r0,r1                                
0803640A 0040     lsl     r0,r0,1h                                
0803640C 1880     add     r0,r0,r2                                
0803640E 8800     ldrh    r0,[r0]                                 
08036410 82A8     strh    r0,[r5,14h] ;写入血量                            
08036412 1C28     mov     r0,r5                                   
08036414 302B     add     r0,2Bh                                  
08036416 7004     strb    r4,[r0]     ;无敌时间写入0                            
08036418 380B     sub     r0,0Bh                                  
0803641A 7004     strb    r4,[r0]     ;调色板写入0                             
0803641C 3013     add     r0,13h                                  
0803641E 7004     strb    r4,[r0]     ;300076b写入0                             
08036420 3001     add     r0,1h                                   
08036422 7004     strb    r4,[r0]     ;300076c写入0                            
08036424 1C29     mov     r1,r5                                   
08036426 3126     add     r1,26h                                  
08036428 2001     mov     r0,1h                                   
0803642A 7008     strb    r0,[r1]     ;300075e写入1                              
0803642C 1C28     mov     r0,r5                                   
0803642E 3030     add     r0,30h                                  
08036430 7004     strb    r4,[r0]     ;冰冻时间为0                            
08036432 8829     ldrh    r1,[r5]                                 
08036434 2020     mov     r0,20h                                  
08036436 4008     and     r0,r1       ;取向 and 20h                            
08036438 2800     cmp     r0,0h                                   
0803643A D007     beq     @@Nogreenmoon                                
0803643C 1C29     mov     r1,r5                                   
0803643E 312D     add     r1,2Dh                                  
08036440 2014     mov     r0,14h      ;再生产值                              
08036442 E006     b       @@peer                                

@@Nogreenmoon:                              
0803644C 1C29     mov     r1,r5                                   
0803644E 312D     add     r1,2Dh                                  
08036450 203C     mov     r0,3Ch      ;再生产值

@@peer:                                  
08036452 7008     strb    r0,[r1]                                 
08036454 4905     ldr     r1,=3000738h                            
08036456 880A     ldrh    r2,[r1]                                 
08036458 4B05     ldr     r3,=8004h                               
0803645A 1C18     mov     r0,r3                                   
0803645C 4310     orr     r0,r2       ;取向 orr 8004h  1 orr 4 为5                          
0803645E 8008     strh    r0,[r1]     ;再写入                            
08036460 3126     add     r1,26h                                  
08036462 2001     mov     r0,1h                                   
08036464 7008     strb    r0,[r1]     ;300075e写入1                             
08036466 BC30     pop     r4,r5                                   
08036468 BC01     pop     r0                                      
0803646A 4700     bx      r0  

;pose 9h                                                                   
08036474 B570     push    r4-r6,r14                               
08036476 4C07     ldr     r4,=3000738h                            
08036478 1C23     mov     r3,r4                                   
0803647A 332D     add     r3,2Dh                                  
0803647C 781A     ldrb    r2,[r3]   ;读取再生产值                              
0803647E 1C15     mov     r5,r2                                   
08036480 2D00     cmp     r5,0h                                   
08036482 D009     beq     @@respawntimezero                                
08036484 1C20     mov     r0,r4                                   
08036486 3026     add     r0,26h                                  
08036488 2101     mov     r1,1h                                   
0803648A 7001     strb    r1,[r0]   ;300075e写入1                               
0803648C 1E50     sub     r0,r2,1                                 
0803648E 7018     strb    r0,[r3]   ;再生产值减1再写入                              
08036490 E078     b       @@end                                

@@respawntimezero:                               
08036498 8823     ldrh    r3,[r4]                                 
0803649A 2004     mov     r0,4h                                   
0803649C 4018     and     r0,r3    ;4 and 取向                               
0803649E 1C1A     mov     r2,r3                                   
080364A0 2800     cmp     r0,0h                                   
080364A2 D015     beq     @@small  ;第一次出现的电圈都会跳转                               
080364A4 1C21     mov     r1,r4    ;此后出现的电圈在取向变成3后也会跳转                               
080364A6 3126     add     r1,26h                                  
080364A8 2001     mov     r0,1h                                   
080364AA 7008     strb    r0,[r1] ;300075e写入1                                
080364AC 2002     mov     r0,2h                                   
080364AE 4010     and     r0,r2   ;2 and 取向                                
080364B0 2800     cmp     r0,0h                                   
080364B2 D067     beq     @@end   ;应该不会结束的吧                             
080364B4 4805     ldr     r0,=0FFFBh                              
080364B6 4010     and     r0,r2                                   
080364B8 2100     mov     r1,0h      ;取向7变成了3                             
080364BA 8020     strh    r0,[r4]                                 
080364BC 82E5     strh    r5,[r4,16h] ;动画和帧归零                            
080364BE 7721     strb    r1,[r4,1Ch]                             
080364C0 1C21     mov     r1,r4                                   
080364C2 312C     add     r1,2Ch                                  
080364C4 200B     mov     r0,0Bh                                  
080364C6 7008     strb    r0,[r1]    ;3000764写入bh                             
080364C8 E05C     b       @@end                                

@@small:                                
080364D0 1C25     mov     r5,r4                                   
080364D2 352C     add     r5,2Ch                                  
080364D4 7829     ldrb    r1,[r5]   ;3000764如果为0                               
080364D6 2900     cmp     r1,0h                                   
080364D8 D00E     beq     @@zero                                
080364DA 1C22     mov     r2,r4                                   
080364DC 3226     add     r2,26h                                  
080364DE 2001     mov     r0,1h                                   
080364E0 7010     strb    r0,[r2]  ;300075e写入1                                
080364E2 1E48     sub     r0,r1,1  ;3000764减1  控制                             
080364E4 7028     strb    r0,[r5]  ;再写入                               
080364E6 0600     lsl     r0,r0,18h                               
080364E8 2800     cmp     r0,0h                                   
080364EA D14B     bne     @@end    ;不为0结束                             
080364EC 4801     ldr     r0,=7FFFh                               
080364EE 4018     and     r0,r3    ;7fff and 取向                               
080364F0 8020     strh    r0,[r4]  ;再写入  去掉8?                               
080364F2 E047     b       @@end                                

@@zero:                                
080364F8 F7D9FB66 bl      CheckAnimation                                
080364FC 2800     cmp     r0,0h                                   
080364FE D041     beq     @@end    ;动画未结束结束                              
08036500 7F60     ldrb    r0,[r4,1Dh]                             
08036502 28A5     cmp     r0,0A5h                                 
08036504 D104     bne     @@redmoon                                
08036506 4801     ldr     r0,=82EE6F0h                            
08036508 E003     b       @@peer                               

@@redmoon:                              
08036510 480E     ldr     r0,=82EE5E8h

@@peer:                            
08036512 61A0     str     r0,[r4,18h]                             
08036514 490E     ldr     r1,=3000738h                            
08036516 1C0A     mov     r2,r1                                   
08036518 3224     add     r2,24h                                  
0803651A 2300     mov     r3,0h                                   
0803651C 2023     mov     r0,23h                                  
0803651E 7010     strb    r0,[r2]      ;pose写入23h                                
08036520 2600     mov     r6,0h                                   
08036522 82CB     strh    r3,[r1,16h]                             
08036524 770E     strb    r6,[r1,1Ch]                             
08036526 824B     strh    r3,[r1,12h]  ;300074a写入0                           
08036528 4A0A     ldr     r2,=30013D4h                            
0803652A 8A90     ldrh    r0,[r2,14h]                             
0803652C 383C     sub     r0,3Ch       ;SA Y坐标上3ch                           
0803652E 0400     lsl     r0,r0,10h                               
08036530 0C00     lsr     r0,r0,10h                               
08036532 8A54     ldrh    r4,[r2,12h]  ;SA X坐标                           
08036534 884A     ldrh    r2,[r1,2h]   ;Y坐标                           
08036536 888D     ldrh    r5,[r1,4h]   ;X坐标                           
08036538 80C8     strh    r0,[r1,6h]                              
0803653A 810C     strh    r4,[r1,8h]   ;SA坐标写入再生产坐标                           
0803653C 1C0B     mov     r3,r1                                   
0803653E 4290     cmp     r0,r2                                   
08036540 D20C     bcs     @@atspritedown                                
08036542 8819     ldrh    r1,[r3]                                 
08036544 4804     ldr     r0,=0FBFFh                              
08036546 4008     and     r0,r1       ;0FBFF and 取向 去掉400                           
08036548 E00D     b       @@write                                                               

@@atspritedown:                                
0803655C 8818     ldrh    r0,[r3]                                 
0803655E 2280     mov     r2,80h                                  
08036560 00D2     lsl     r2,r2,3h                                
08036562 1C11     mov     r1,r2                                   
08036564 4308     orr     r0,r1       ;取向 orr 400h

@@write:                                   
08036566 8018     strh    r0,[r3]                                 
08036568 42AC     cmp     r4,r5                                   
0803656A D205     bcs     @@atspriteright                                
0803656C 8819     ldrh    r1,[r3]                                 
0803656E 4801     ldr     r0,=0FDFFh  ;取向 and 0FDFF  去掉200                          
08036570 4008     and     r0,r1                                   
08036572 E006     b       @@willend                                

@@atspriteright:                                
08036578 8819     ldrh    r1,[r3]                                 
0803657A 2280     mov     r2,80h                                  
0803657C 0092     lsl     r2,r2,2h                                
0803657E 1C10     mov     r0,r2                                   
08036580 4308     orr     r0,r1       ;取向 orr 200h

@@willend:                                   
08036582 8018     strh    r0,[r3] 

@@end:                                
08036584 BC70     pop     r4-r6                                   
08036586 BC01     pop     r0                                      
08036588 4700     bx      r0 

;pose 23h                                                                      
0803658C B5F0     push    r4-r7,r14            ;定位攻击的范例                    
0803658E 4657     mov     r7,r10                                  
08036590 464E     mov     r6,r9                                   
08036592 4645     mov     r5,r8                                   
08036594 B4E0     push    r5-r7                                   
08036596 B083     add     sp,-0Ch                                 
08036598 2000     mov     r0,0h                                   
0803659A 9002     str     r0,[sp,8h]   ;SP8写入0h                            
0803659C 4915     ldr     r1,=3000738h                            
0803659E 880A     ldrh    r2,[r1]                                 
080365A0 2020     mov     r0,20h                                  
080365A2 4010     and     r0,r2     ;20 and 取向                               
080365A4 2304     mov     r3,4h                                   
080365A6 9300     str     r3,[sp]   ;SP 写入4h                              
080365A8 1C0B     mov     r3,r1                                   
080365AA 2800     cmp     r0,0h                                   
080365AC D001     beq     @@redmoon                                
080365AE 2005     mov     r0,5h                                   
080365B0 9000     str     r0,[sp]   ;SP写入5h  大概是移动值

@@redmoon:                                
080365B2 8A58     ldrh    r0,[r3,12h]                             
080365B4 3001     add     r0,1h       ;300074a加1再写入                            
080365B6 8258     strh    r0,[r3,12h]                             
080365B8 0400     lsl     r0,r0,10h                               
080365BA 0C00     lsr     r0,r0,10h                               
080365BC 9900     ldr     r1,[sp]                                 
080365BE 4348     mul     r0,r1       ;SP 乘以300074a的值                             
080365C0 0400     lsl     r0,r0,10h                               
080365C2 0C00     lsr     r0,r0,10h                               
080365C4 9000     str     r0,[sp]     ;再写入                            
080365C6 1C18     mov     r0,r3                                   
080365C8 302F     add     r0,2Fh                                  
080365CA 7800     ldrb    r0,[r0]     ;3000767的值                            
080365CC 0180     lsl     r0,r0,6h                                
080365CE 3020     add     r0,20h                                  
080365D0 4682     mov     r10,r0      ;初始Y坐标                            
080365D2 1C18     mov     r0,r3                                   
080365D4 302E     add     r0,2Eh      ;3000766h                            
080365D6 7800     ldrb    r0,[r0]                                 
080365D8 0180     lsl     r0,r0,6h                                
080365DA 3020     add     r0,20h                                  
080365DC 9001     str     r0,[sp,4h]  ;初始X坐标                            
080365DE 2080     mov     r0,80h                                  
080365E0 00C0     lsl     r0,r0,3h                                
080365E2 4010     and     r0,r2       ;400 and 取向                            
080365E4 2800     cmp     r0,0h                                   
080365E6 D007     beq     @@atspriteup                                
080365E8 88D8     ldrh    r0,[r3,6h]  ;读取之前写入的SA Y坐标                            
080365EA 4651     mov     r1,r10                                  
080365EC 1A40     sub     r0,r0,r1                                
080365EE 0400     lsl     r0,r0,10h                               
080365F0 0C06     lsr     r6,r0,10h   ;减去精灵Y坐标给r6                            
080365F2 E006     b       @@tocompare                                

@@atspriteup:                              
080365F8 88D8     ldrh    r0,[r3,6h]                              
080365FA 4651     mov     r1,r10                                  
080365FC 1A08     sub     r0,r1,r0                                
080365FE 0400     lsl     r0,r0,10h                               
08036600 0C05     lsr     r5,r0,10h 

@@tocompare:                              
08036602 8819     ldrh    r1,[r3]                                 
08036604 2080     mov     r0,80h                                  
08036606 0080     lsl     r0,r0,2h                                
08036608 4008     and     r0,r1                                   
0803660A 2800     cmp     r0,0h                                   
0803660C D006     beq     @@spriteleft                               
0803660E 8918     ldrh    r0,[r3,8h]                              
08036610 9B01     ldr     r3,[sp,4h]                              
08036612 1AC0     sub     r0,r0,r3                                
08036614 0400     lsl     r0,r0,10h  ;SA X坐标减去精灵初始X坐标                             
08036616 0C00     lsr     r0,r0,10h                               
08036618 4680     mov     r8,r0                                   
0803661A E004     b       @@peer 

@@spriteleft:                               
0803661C 8918     ldrh    r0,[r3,8h]                              
0803661E 9901     ldr     r1,[sp,4h]                              
08036620 1A08     sub     r0,r1,r0                                
08036622 0400     lsl     r0,r0,10h                               
08036624 0C07     lsr     r7,r0,10h 

@@peer:                              
08036626 4B11     ldr     r3,=3000738h                            
08036628 4699     mov     r9,r3                                   
0803662A 8819     ldrh    r1,[r3]                                 
0803662C 2080     mov     r0,80h                                  
0803662E 0080     lsl     r0,r0,2h                                
08036630 4008     and     r0,r1                                   
08036632 2800     cmp     r0,0h                                   
08036634 D040     beq     @@spriteup                                
08036636 2080     mov     r0,80h                                  
08036638 00C0     lsl     r0,r0,3h                                
0803663A 4008     and     r0,r1                                   
0803663C 2800     cmp     r0,0h                                   
0803663E D017     beq     @@spritedownleft                                
08036640 4641     mov     r1,r8                                   
08036642 4640     mov     r0,r8                                   
08036644 4348     mul     r0,r1                                   
08036646 1C31     mov     r1,r6                                   
08036648 4371     mul     r1,r6                                   
0803664A 1840     add     r0,r0,r1   ;Y 坐标的距离的平方与X 距离的平方相加                             
0803664C F7CEFDBC bl      80051C8h   ;软件中断                             
08036650 0400     lsl     r0,r0,10h                               
08036652 0C04     lsr     r4,r0,10h                               
08036654 2C00     cmp     r4,0h                                   
08036656 D069     beq     @@allpeer                                
08036658 02B0     lsl     r0,r6,0Ah  ;Y相距距离乘以1024h                            
0803665A 1C21     mov     r1,r4      ;除以软件中断中断得数                            
0803665C F054FAEA bl      808AC34h                                
08036660 9B00     ldr     r3,[sp]                                 
08036662 4358     mul     r0,r3      ;结果乘以原设定数                              
08036664 1280     asr     r0,r0,0Ah  ;结果逻辑右移10位                             
08036666 4450     add     r0,r10     ;加精灵初始Y坐标                             
08036668 E017     b       803669Ah                                

@@spritedownleft:                               
08036670 4643     mov     r3,r8                                   
08036672 4640     mov     r0,r8                                   
08036674 4358     mul     r0,r3                                   
08036676 1C29     mov     r1,r5                                   
08036678 4369     mul     r1,r5                                   
0803667A 1840     add     r0,r0,r1                                
0803667C F7CEFDA4 bl      80051C8h                                
08036680 0400     lsl     r0,r0,10h                               
08036682 0C04     lsr     r4,r0,10h                               
08036684 2C00     cmp     r4,0h                                   
08036686 D051     beq     @@allpeer                                
08036688 02A8     lsl     r0,r5,0Ah                               
0803668A 1C21     mov     r1,r4                                   
0803668C F054FAD2 bl      808AC34h                                
08036690 9900     ldr     r1,[sp]                                 
08036692 4348     mul     r0,r1                                   
08036694 1280     asr     r0,r0,0Ah                               
08036696 4653     mov     r3,r10                                  
08036698 1A18     sub     r0,r3,r0 

                               
0803669A 4649     mov     r1,r9                                   
0803669C 8048     strh    r0,[r1,2h] ;写入当前Y坐标                              
0803669E 4643     mov     r3,r8                                   
080366A0 0298     lsl     r0,r3,0Ah                               
080366A2 1C21     mov     r1,r4                                   
080366A4 F054FAC6 bl      808AC34h                                
080366A8 9900     ldr     r1,[sp]                                 
080366AA 4348     mul     r0,r1                                   
080366AC 1280     asr     r0,r0,0Ah                               
080366AE 9B01     ldr     r3,[sp,4h]                              
080366B0 1818     add     r0,r3,r0                                
080366B2 4649     mov     r1,r9                                   
080366B4 8088     strh    r0,[r1,4h]                              
080366B6 E039     b       @@allpeer 

@@spriteup:                               
080366B8 2080     mov     r0,80h                                  
080366BA 00C0     lsl     r0,r0,3h                                
080366BC 4008     and     r0,r1                                   
080366BE 2800     cmp     r0,0h                                   
080366C0 D013     beq     @@spriteupleft                                
080366C2 1C38     mov     r0,r7                                   
080366C4 4378     mul     r0,r7                                   
080366C6 1C31     mov     r1,r6                                   
080366C8 4371     mul     r1,r6                                   
080366CA 1840     add     r0,r0,r1                                
080366CC F7CEFD7C bl      80051C8h                                
080366D0 0400     lsl     r0,r0,10h                               
080366D2 0C04     lsr     r4,r0,10h                               
080366D4 2C00     cmp     r4,0h                                   
080366D6 D029     beq     @@allpeer                                
080366D8 02B0     lsl     r0,r6,0Ah                               
080366DA 1C21     mov     r1,r4                                   
080366DC F054FAAA bl      808AC34h                                
080366E0 9B00     ldr     r3,[sp]                                 
080366E2 4358     mul     r0,r3                                   
080366E4 1280     asr     r0,r0,0Ah                               
080366E6 4450     add     r0,r10                                  
080366E8 E013     b       8036712h

@@spriteupleft:                                
080366EA 1C38     mov     r0,r7                                   
080366EC 4378     mul     r0,r7                                   
080366EE 1C29     mov     r1,r5                                   
080366F0 4369     mul     r1,r5                                   
080366F2 1840     add     r0,r0,r1                                
080366F4 F7CEFD68 bl      80051C8h                                
080366F8 0400     lsl     r0,r0,10h                               
080366FA 0C04     lsr     r4,r0,10h                               
080366FC 2C00     cmp     r4,0h                                   
080366FE D015     beq     @@allpeer                                
08036700 02A8     lsl     r0,r5,0Ah                               
08036702 1C21     mov     r1,r4                                   
08036704 F054FA96 bl      808AC34h                                
08036708 9900     ldr     r1,[sp]                                 
0803670A 4348     mul     r0,r1                                   
0803670C 1280     asr     r0,r0,0Ah                               
0803670E 4653     mov     r3,r10                                  
08036710 1A18     sub     r0,r3,r0                                
08036712 4649     mov     r1,r9                                   
08036714 8048     strh    r0,[r1,2h]                              
08036716 02B8     lsl     r0,r7,0Ah                               
08036718 1C21     mov     r1,r4                                   
0803671A F054FA8B bl      808AC34h                                
0803671E 9B00     ldr     r3,[sp]                                 
08036720 4358     mul     r0,r3                                   
08036722 1280     asr     r0,r0,0Ah                               
08036724 9901     ldr     r1,[sp,4h]                              
08036726 1A08     sub     r0,r1,r0                                
08036728 464B     mov     r3,r9                                   
0803672A 8098     strh    r0,[r3,4h]

@@allpeer:                              
0803672C 4907     ldr     r1,=3000738h                            
0803672E 888A     ldrh    r2,[r1,4h]                              
08036730 2080     mov     r0,80h                                  
08036732 0200     lsl     r0,r0,8h  ;8000h                               
08036734 4010     and     r0,r2     ;8000 and x坐标                            
08036736 1C0B     mov     r3,r1                                   
08036738 2800     cmp     r0,0h                                   
0803673A D112     bne     @@Ycheck                                
0803673C 4904     ldr     r1,=30013D4h                            
0803673E 8A48     ldrh    r0,[r1,12h] ;SA x坐标                            
08036740 4282     cmp     r2,r0       ;电圈 X坐标和sa x坐标比较                            
08036742 D907     bls     @@willleft                                
08036744 8898     ldrh    r0,[r3,4h]                              
08036746 8A49     ldrh    r1,[r1,12h]                             
08036748 E006     b       @@peer2                                

@@willleft:                               
08036754 8A48     ldrh    r0,[r1,12h]                             
08036756 8899     ldrh    r1,[r3,4h]

@@peer2:                              
08036758 1A40     sub     r0,r0,r1   ;两者间距                             
0803675A 2180     mov     r1,80h                                  
0803675C 00C9     lsl     r1,r1,3h   ;400h                             
0803675E 4288     cmp     r0,r1      ;小于等于                             
08036760 DD04     ble     @@Xcheck 

@@Ycheck:                               
08036762 9802     ldr     r0,[sp,8h]                              
08036764 3001     add     r0,1h                                   
08036766 0600     lsl     r0,r0,18h                               
08036768 0E00     lsr     r0,r0,18h                               
0803676A 9002     str     r0,[sp,8h]

@@Xcheck:                              
0803676C 1C1C     mov     r4,r3                                   
0803676E 8862     ldrh    r2,[r4,2h]                              
08036770 2080     mov     r0,80h                                  
08036772 0200     lsl     r0,r0,8h                                
08036774 4010     and     r0,r2      ;8000h and 当前Y坐标                                
08036776 2800     cmp     r0,0h                                   
08036778 D10F     bne     @@peer5                                
0803677A 4903     ldr     r1,=30013D4h                            
0803677C 8A88     ldrh    r0,[r1,14h]                             
0803677E 4282     cmp     r2,r0      ;当前Y坐标和Sa Y坐标比较                             
08036780 D904     bls     @@peer3   ;小于等于                             
08036782 8860     ldrh    r0,[r4,2h]                              
08036784 8A89     ldrh    r1,[r1,14h]                             
08036786 E003     b       @@peer4                                

@@peer3:                              
0803678C 8A88     ldrh    r0,[r1,14h]                             
0803678E 8859     ldrh    r1,[r3,2h]

@@peer4:                              
08036790 1A40     sub     r0,r0,r1                                
08036792 2180     mov     r1,80h                                  
08036794 00C9     lsl     r1,r1,3h ;400h                               
08036796 4288     cmp     r0,r1    ;Y间距小于400h                               
08036798 DD04     ble     @@pass 

@@peer5:                               
0803679A 9802     ldr     r0,[sp,8h]                              
0803679C 3001     add     r0,1h                                   
0803679E 0600     lsl     r0,r0,18h                               
080367A0 0E00     lsr     r0,r0,18h                               
080367A2 9002     str     r0,[sp,8h]

@@pass:                              
080367A4 9902     ldr     r1,[sp,8h]                              
080367A6 2900     cmp     r1,0h                                   
080367A8 D001     beq     @@end                                
080367AA F7FFFE19 bl      80363E0h  ;重新设定新电圈 otherpose经历

@@end:                               
080367AE B003     add     sp,0Ch                                  
080367B0 BC38     pop     r3-r5                                   
080367B2 4698     mov     r8,r3                                   
080367B4 46A1     mov     r9,r4                                   
080367B6 46AA     mov     r10,r5                                  
080367B8 BCF0     pop     r4-r7                                   
080367BA BC01     pop     r0                                      
080367BC 4700     bx      r0                                      


;雷卡电圈 pose 8h                               
080367C0 4905     ldr     r1,=3000738h                            
080367C2 1C0A     mov     r2,r1                                   
080367C4 3224     add     r2,24h                                  
080367C6 2300     mov     r3,0h                                   
080367C8 2009     mov     r0,9h                                   
080367CA 7010     strb    r0,[r2]                                 
080367CC 2000     mov     r0,0h                                   
080367CE 82CB     strh    r3,[r1,16h]                             
080367D0 7708     strb    r0,[r1,1Ch]                             
080367D2 4802     ldr     r0,=82FE8CCh                            
080367D4 6188     str     r0,[r1,18h]                             
080367D6 4770     bx      r14                                     

;雷卡电圈死亡后pose                              
080367E0 B570     push    r4-r6,r14                               
080367E2 490D     ldr     r1,=3000738h                            
080367E4 1C08     mov     r0,r1                                   
080367E6 302F     add     r0,2Fh                                  
080367E8 7800     ldrb    r0,[r0]                                 
080367EA 0180     lsl     r0,r0,6h                                
080367EC 3020     add     r0,20h                                  
080367EE 1C06     mov     r6,r0      ;原 Y坐标                               
080367F0 1C08     mov     r0,r1                                   
080367F2 302E     add     r0,2Eh                                  
080367F4 7800     ldrb    r0,[r0]                                 
080367F6 0180     lsl     r0,r0,6h                                
080367F8 3020     add     r0,20h                                  
080367FA 1C03     mov     r3,r0      ;原 X坐标                              
080367FC 4807     ldr     r0,=30013D4h                            
080367FE 8A42     ldrh    r2,[r0,12h] ;萨姆斯X坐标                            
08036800 7F48     ldrb    r0,[r1,1Dh] ;ID                            
08036802 38C9     sub     r0,0C9h                                 
08036804 1C0D     mov     r5,r1                                   
08036806 2804     cmp     r0,4h                                   
08036808 D900     bls     @@rikamoon                                
0803680A E07D     b       @@othersprite 

@@rikamoon:                               
0803680C 0080     lsl     r0,r0,2h                                
0803680E 4904     ldr     r1,=spritetable                            
08036810 1840     add     r0,r0,r1                                
08036812 6800     ldr     r0,[r0]                                 
08036814 4687     mov     r15,r0                                  

spritetable:                             
    .word 8036838h
	.word 8036864h
	.word 8036890h
	.word 80368b4h
	.word 80368d8h
;c9h    	
08036838 2028     mov     r0,28h                                  
0803683A 429A     cmp     r2,r3    	;S x坐标和电圈原坐标比较                               
0803683C D260     bcs     8036900h  ;大于跳转                              
0803683E 1A99     sub     r1,r3,r2                                
08036840 0140     lsl     r0,r0,5h                                
08036842 4281     cmp     r1,r0     ;坐标间距距离和500h比较                              
08036844 DD5C     ble     8036900h  ;小于跳转                              
08036846 8829     ldrh    r1,[r5]                                 
08036848 2280     mov     r2,80h                                  
0803684A 0112     lsl     r2,r2,4h                                
0803684C 1C10     mov     r0,r2                                   
0803684E 4308     orr     r0,r1     ;800 orr取向                              
08036850 8028     strh    r0,[r5]   ;再写入                              
08036852 1C30     mov     r0,r6                                   
08036854 3040     add     r0,40h    ;原Y坐标加40h                              
08036856 0400     lsl     r0,r0,10h                               
08036858 0C06     lsr     r6,r0,10h                               
0803685A 4C01     ldr     r4,=0FFFFF600h  ;a00h                        
0803685C E04A     b       80368F4h                                

;cah                               
08036864 2022     mov     r0,22h                                  
08036866 429A     cmp     r2,r3                                   
08036868 D24A     bcs     8036900h                                
0803686A 1A99     sub     r1,r3,r2                                
0803686C 0140     lsl     r0,r0,5h  ;和440h比较                              
0803686E 4281     cmp     r1,r0                                   
08036870 DD46     ble     8036900h                                
08036872 8829     ldrh    r1,[r5]                                 
08036874 2280     mov     r2,80h                                  
08036876 0112     lsl     r2,r2,4h                                
08036878 1C10     mov     r0,r2                                   
0803687A 4308     orr     r0,r1                                   
0803687C 8028     strh    r0,[r5]                                 
0803687E 1C30     mov     r0,r6                                   
08036880 3840     sub     r0,40h                                  
08036882 0400     lsl     r0,r0,10h                               
08036884 0C06     lsr     r6,r0,10h                               
08036886 4C01     ldr     r4,=0FFFFF780h  ;880h                        
08036888 E034     b       80368F4h                                
 

;cbh                              
08036890 2018     mov     r0,18h                                  
08036892 429A     cmp     r2,r3                                   
08036894 D234     bcs     8036900h                                
08036896 1A99     sub     r1,r3,r2                                
08036898 0140     lsl     r0,r0,5h  ;和300h比较                              
0803689A 4281     cmp     r1,r0                                   
0803689C DD30     ble     8036900h                                
0803689E 8828     ldrh    r0,[r5]                                 
080368A0 2280     mov     r2,80h                                  
080368A2 0112     lsl     r2,r2,4h                                
080368A4 1C11     mov     r1,r2                                   
080368A6 4301     orr     r1,r0                                   
080368A8 8029     strh    r1,[r5]                                 
080368AA 4C01     ldr     r4,=0FFFFFA00h                          
080368AC E022     b       80368F4h                                

                               
080368B4 201E     mov     r0,1Eh                                  
080368B6 429A     cmp     r2,r3                                   
080368B8 D222     bcs     8036900h                                
080368BA 1A99     sub     r1,r3,r2                                
080368BC 0140     lsl     r0,r0,5h                                
080368BE 4281     cmp     r1,r0                                   
080368C0 DD1E     ble     8036900h                                
080368C2 8828     ldrh    r0,[r5]                                 
080368C4 2280     mov     r2,80h                                  
080368C6 0112     lsl     r2,r2,4h                                
080368C8 1C11     mov     r1,r2                                   
080368CA 4301     orr     r1,r0                                   
080368CC 8029     strh    r1,[r5]                                 
080368CE 4C01     ldr     r4,=0FFFFF880h                          
080368D0 E010     b       80368F4h                                

                             
080368D8 2014     mov     r0,14h                                  
080368DA 429A     cmp     r2,r3                                   
080368DC D210     bcs     8036900h                                
080368DE 1A99     sub     r1,r3,r2                                
080368E0 0140     lsl     r0,r0,5h                                
080368E2 4281     cmp     r1,r0                                   
080368E4 DD0C     ble     8036900h                                
080368E6 8828     ldrh    r0,[r5]                                 
080368E8 2280     mov     r2,80h                                  
080368EA 0112     lsl     r2,r2,4h                                
080368EC 1C11     mov     r1,r2                                   
080368EE 4301     orr     r1,r0                                   
080368F0 8029     strh    r1,[r5]                                 
080368F2 4C02     ldr     r4,=0FFFFFB00h 

                         
080368F4 1918     add     r0,r3,r4                                
080368F6 0400     lsl     r0,r0,10h                               
080368F8 0C03     lsr     r3,r0,10h                               
080368FA E005     b       8036908h                                

                               
08036900 8829     ldrh    r1,[r5]                                 
08036902 4815     ldr     r0,=0F7FFh                              
08036904 4008     and     r0,r1                                   
08036906 8028     strh    r0,[r5] 

@@othersprite:                                
08036908 2400     mov     r4,0h                                   
0803690A 806E     strh    r6,[r5,2h]   ;原坐标写入                           
0803690C 80AB     strh    r3,[r5,4h]                              
0803690E F7FFFF57 bl      80367C0h     ;雷卡pose 8                            
08036912 4A12     ldr     r2,=82B0D68h                            
08036914 7F69     ldrb    r1,[r5,1Dh]                             
08036916 00C8     lsl     r0,r1,3h                                
08036918 1840     add     r0,r0,r1                                
0803691A 0040     lsl     r0,r0,1h                                
0803691C 1880     add     r0,r0,r2                                
0803691E 8800     ldrh    r0,[r0]                                 
08036920 82A8     strh    r0,[r5,14h]                             
08036922 1C28     mov     r0,r5                                   
08036924 302B     add     r0,2Bh                                  
08036926 7004     strb    r4,[r0]                                 
08036928 380B     sub     r0,0Bh                                  
0803692A 7004     strb    r4,[r0]                                 
0803692C 3013     add     r0,13h                                  
0803692E 2201     mov     r2,1h                                   
08036930 7002     strb    r2,[r0]                                 
08036932 3001     add     r0,1h                                   
08036934 7004     strb    r4,[r0]                                 
08036936 1C2B     mov     r3,r5                                   
08036938 3326     add     r3,26h                                  
0803693A 3804     sub     r0,4h                                   
0803693C 7004     strb    r4,[r0]                                 
0803693E 1C29     mov     r1,r5                                   
08036940 312D     add     r1,2Dh                                  
08036942 203C     mov     r0,3Ch                                  
08036944 7008     strb    r0,[r1]                                 
08036946 8828     ldrh    r0,[r5]                                 
08036948 4C05     ldr     r4,=8004h                               
0803694A 1C21     mov     r1,r4                                   
0803694C 4308     orr     r0,r1                                   
0803694E 8028     strh    r0,[r5]                                 
08036950 701A     strb    r2,[r3]                                 
08036952 BC70     pop     r4-r6                                   
08036954 BC01     pop     r0                                      
08036956 4700     bx      r0 

                                     
08036958 F7FF     ????                                            
0803695A 0000     lsl     r0,r0,0h                                
0803695C 0D68     lsr     r0,r5,15h                               
0803695E 082B     lsr     r3,r5,20h                               
08036960 8004     strh    r4,[r0]                                 
08036962 0000     lsl     r0,r0,0h                                
08036964 B570     push    r4-r6,r14                               
08036966 4C07     ldr     r4,=3000738h                            
08036968 1C23     mov     r3,r4                                   
0803696A 332D     add     r3,2Dh                                  
0803696C 781A     ldrb    r2,[r3]                                 
0803696E 1C15     mov     r5,r2                                   
08036970 2D00     cmp     r5,0h                                   
08036972 D009     beq     8036988h                                
08036974 1C20     mov     r0,r4                                   
08036976 3026     add     r0,26h                                  
08036978 2101     mov     r1,1h                                   
0803697A 7001     strb    r1,[r0]                                 
0803697C 1E50     sub     r0,r2,1                                 
0803697E 7018     strb    r0,[r3]                                 
08036980 E073     b       8036A6Ah                                
08036982 0000     lsl     r0,r0,0h                                
08036984 0738     lsl     r0,r7,1Ch                               
08036986 0300     lsl     r0,r0,0Ch                               
08036988 8823     ldrh    r3,[r4]                                 
0803698A 2004     mov     r0,4h                                   
0803698C 4018     and     r0,r3                                   
0803698E 1C1A     mov     r2,r3                                   
08036990 2800     cmp     r0,0h                                   
08036992 D018     beq     80369C6h                                
08036994 1C21     mov     r1,r4                                   
08036996 3126     add     r1,26h                                  
08036998 2001     mov     r0,1h                                   
0803699A 7008     strb    r0,[r1]                                 
0803699C 2002     mov     r0,2h                                   
0803699E 4010     and     r0,r2                                   
080369A0 2800     cmp     r0,0h                                   
080369A2 D00D     beq     80369C0h                                
080369A4 4805     ldr     r0,=0FFFBh                              
080369A6 4010     and     r0,r2                                   
080369A8 2100     mov     r1,0h                                   
080369AA 8020     strh    r0,[r4]                                 
080369AC 82E5     strh    r5,[r4,16h]                             
080369AE 7721     strb    r1,[r4,1Ch]                             
080369B0 1C21     mov     r1,r4                                   
080369B2 312C     add     r1,2Ch                                  
080369B4 200B     mov     r0,0Bh                                  
080369B6 7008     strb    r0,[r1]                                 
080369B8 E057     b       8036A6Ah                                
080369BA 0000     lsl     r0,r0,0h                                
080369BC FFFB     bl      lr+0FF6h                                
080369BE 0000     lsl     r0,r0,0h                                
080369C0 F7FFFF0E bl      80367E0h                                
080369C4 E051     b       8036A6Ah                                
080369C6 1C26     mov     r6,r4                                   
080369C8 362C     add     r6,2Ch                                  
080369CA 7831     ldrb    r1,[r6]                                 
080369CC 1C0D     mov     r5,r1                                   
080369CE 2D00     cmp     r5,0h                                   
080369D0 D00E     beq     80369F0h                                
080369D2 1C22     mov     r2,r4                                   
080369D4 3226     add     r2,26h                                  
080369D6 2001     mov     r0,1h                                   
080369D8 7010     strb    r0,[r2]                                 
080369DA 1E48     sub     r0,r1,1                                 
080369DC 7030     strb    r0,[r6]                                 
080369DE 0600     lsl     r0,r0,18h                               
080369E0 2800     cmp     r0,0h                                   
080369E2 D142     bne     8036A6Ah                                
080369E4 4801     ldr     r0,=7FFFh                               
080369E6 4018     and     r0,r3                                   
080369E8 8020     strh    r0,[r4]                                 
080369EA E03E     b       8036A6Ah                                
080369EC 7FFF     ldrb    r7,[r7,1Fh]                             
080369EE 0000     lsl     r0,r0,0h                                
080369F0 F7D9F8EA bl      800FBC8h                                
080369F4 2800     cmp     r0,0h                                   
080369F6 D038     beq     8036A6Ah                                
080369F8 480C     ldr     r0,=82FE94Ch                            
080369FA 61A0     str     r0,[r4,18h]                             
080369FC 1C21     mov     r1,r4                                   
080369FE 3124     add     r1,24h                                  
08036A00 2023     mov     r0,23h                                  
08036A02 7008     strb    r0,[r1]                                 
08036A04 2600     mov     r6,0h                                   
08036A06 82E5     strh    r5,[r4,16h]                             
08036A08 7726     strb    r6,[r4,1Ch]                             
08036A0A 8265     strh    r5,[r4,12h]                             
08036A0C 4908     ldr     r1,=30013D4h                            
08036A0E 8A88     ldrh    r0,[r1,14h]                             
08036A10 383C     sub     r0,3Ch                                  
08036A12 0400     lsl     r0,r0,10h                               
08036A14 0C00     lsr     r0,r0,10h                               
08036A16 8A4A     ldrh    r2,[r1,12h]                             
08036A18 8861     ldrh    r1,[r4,2h]                              
08036A1A 88A3     ldrh    r3,[r4,4h]                              
08036A1C 80E0     strh    r0,[r4,6h]                              
08036A1E 8122     strh    r2,[r4,8h]                              
08036A20 4288     cmp     r0,r1                                   
08036A22 D209     bcs     8036A38h                                
08036A24 8821     ldrh    r1,[r4]                                 
08036A26 4803     ldr     r0,=0FBFFh                              
08036A28 4008     and     r0,r1                                   
08036A2A E00A     b       8036A42h                                
08036A2C E94C     ????                                            
08036A2E 082F     lsr     r7,r5,20h                               
08036A30 13D4     asr     r4,r2,0Fh                               
08036A32 0300     lsl     r0,r0,0Ch                               
08036A34 FBFF     bl      lr+7FEh                                 
08036A36 0000     lsl     r0,r0,0h                                
08036A38 8820     ldrh    r0,[r4]                                 
08036A3A 2580     mov     r5,80h                                  
08036A3C 00ED     lsl     r5,r5,3h                                
08036A3E 1C29     mov     r1,r5                                   
08036A40 4308     orr     r0,r1                                   
08036A42 8020     strh    r0,[r4]                                 
08036A44 429A     cmp     r2,r3                                   
08036A46 D209     bcs     8036A5Ch                                
08036A48 4A02     ldr     r2,=3000738h                            
08036A4A 8811     ldrh    r1,[r2]                                 
08036A4C 4802     ldr     r0,=0FDFFh                              
08036A4E 4008     and     r0,r1                                   
08036A50 E00A     b       8036A68h                                
08036A52 0000     lsl     r0,r0,0h                                
08036A54 0738     lsl     r0,r7,1Ch                               
08036A56 0300     lsl     r0,r0,0Ch                               
08036A58 FDFF     bl      lr+0BFEh                                
08036A5A 0000     lsl     r0,r0,0h                                
08036A5C 4A04     ldr     r2,=3000738h                            
08036A5E 8811     ldrh    r1,[r2]                                 
08036A60 2380     mov     r3,80h                                  
08036A62 009B     lsl     r3,r3,2h                                
08036A64 1C18     mov     r0,r3                                   
08036A66 4308     orr     r0,r1                                   
08036A68 8010     strh    r0,[r2]                                 
08036A6A BC70     pop     r4-r6                                   
08036A6C BC01     pop     r0                                      
08036A6E 4700     bx      r0                                      
08036A70 0738     lsl     r0,r7,1Ch                               
08036A72 0300     lsl     r0,r0,0Ch                               
08036A74 B5F0     push    r4-r7,r14                               
08036A76 4657     mov     r7,r10                                  
08036A78 464E     mov     r6,r9                                   
08036A7A 4645     mov     r5,r8                                   
08036A7C B4E0     push    r5-r7                                   
08036A7E B083     add     sp,-0Ch                                 
08036A80 2000     mov     r0,0h                                   
08036A82 9002     str     r0,[sp,8h]                              
08036A84 480A     ldr     r0,=3000738h                            
08036A86 8A41     ldrh    r1,[r0,12h]                             
08036A88 3101     add     r1,1h                                   
08036A8A 8241     strh    r1,[r0,12h]                             
08036A8C 0489     lsl     r1,r1,12h                               
08036A8E 0C0E     lsr     r6,r1,10h                               
08036A90 1C01     mov     r1,r0                                   
08036A92 312E     add     r1,2Eh                                  
08036A94 780A     ldrb    r2,[r1]                                 
08036A96 3101     add     r1,1h                                   
08036A98 780B     ldrb    r3,[r1]                                 
08036A9A 7F41     ldrb    r1,[r0,1Dh]                             
08036A9C 39C9     sub     r1,0C9h                                 
08036A9E 1C04     mov     r4,r0                                   
08036AA0 2904     cmp     r1,4h                                   
08036AA2 D849     bhi     8036B38h                                
08036AA4 0088     lsl     r0,r1,2h                                
08036AA6 4903     ldr     r1,=8036AB8h                            
08036AA8 1840     add     r0,r0,r1                                
08036AAA 6800     ldr     r0,[r0]                                 
08036AAC 4687     mov     r15,r0                                  
08036AAE 0000     lsl     r0,r0,0h                                
08036AB0 0738     lsl     r0,r7,1Ch                               
08036AB2 0300     lsl     r0,r0,0Ch                               
08036AB4 6AB8     ldr     r0,[r7,28h]                             
08036AB6 0803     lsr     r3,r0,20h                               
08036AB8 6ACC     ldr     r4,[r1,2Ch]                             
08036ABA 0803     lsr     r3,r0,20h                               
08036ABC 6AE4     ldr     r4,[r4,2Ch]                             
08036ABE 0803     lsr     r3,r0,20h                               
08036AC0 6B00     ldr     r0,[r0,30h]                             
08036AC2 0803     lsr     r3,r0,20h                               
08036AC4 6B12     ldr     r2,[r2,30h]                             
08036AC6 0803     lsr     r3,r0,20h                               
08036AC8 6B24     ldr     r4,[r4,30h]                             
08036ACA 0803     lsr     r3,r0,20h                               
08036ACC 8821     ldrh    r1,[r4]                                 
08036ACE 2080     mov     r0,80h                                  
08036AD0 0100     lsl     r0,r0,4h                                
08036AD2 4008     and     r0,r1                                   
08036AD4 2800     cmp     r0,0h                                   
08036AD6 D02F     beq     8036B38h                                
08036AD8 1C10     mov     r0,r2                                   
08036ADA 3828     sub     r0,28h                                  
08036ADC 0600     lsl     r0,r0,18h                               
08036ADE 0E02     lsr     r2,r0,18h                               
08036AE0 1C58     add     r0,r3,1                                 
08036AE2 E00A     b       8036AFAh                                
08036AE4 8821     ldrh    r1,[r4]                                 
08036AE6 2080     mov     r0,80h                                  
08036AE8 0100     lsl     r0,r0,4h                                
08036AEA 4008     and     r0,r1                                   
08036AEC 2800     cmp     r0,0h                                   
08036AEE D023     beq     8036B38h                                
08036AF0 1C10     mov     r0,r2                                   
08036AF2 3822     sub     r0,22h                                  
08036AF4 0600     lsl     r0,r0,18h                               
08036AF6 0E02     lsr     r2,r0,18h                               
08036AF8 1E58     sub     r0,r3,1                                 
08036AFA 0600     lsl     r0,r0,18h                               
08036AFC 0E03     lsr     r3,r0,18h                               
08036AFE E01B     b       8036B38h                                
08036B00 8821     ldrh    r1,[r4]                                 
08036B02 2080     mov     r0,80h                                  
08036B04 0100     lsl     r0,r0,4h                                
08036B06 4008     and     r0,r1                                   
08036B08 2800     cmp     r0,0h                                   
08036B0A D015     beq     8036B38h                                
08036B0C 1C10     mov     r0,r2                                   
08036B0E 3818     sub     r0,18h                                  
08036B10 E010     b       8036B34h                                
08036B12 8821     ldrh    r1,[r4]                                 
08036B14 2080     mov     r0,80h                                  
08036B16 0100     lsl     r0,r0,4h                                
08036B18 4008     and     r0,r1                                   
08036B1A 2800     cmp     r0,0h                                   
08036B1C D00C     beq     8036B38h                                
08036B1E 1C10     mov     r0,r2                                   
08036B20 381E     sub     r0,1Eh                                  
08036B22 E007     b       8036B34h                                
08036B24 8821     ldrh    r1,[r4]                                 
08036B26 2080     mov     r0,80h                                  
08036B28 0100     lsl     r0,r0,4h                                
08036B2A 4008     and     r0,r1                                   
08036B2C 2800     cmp     r0,0h                                   
08036B2E D003     beq     8036B38h                                
08036B30 1C10     mov     r0,r2                                   
08036B32 3814     sub     r0,14h                                  
08036B34 0600     lsl     r0,r0,18h                               
08036B36 0E02     lsr     r2,r0,18h                               
08036B38 0198     lsl     r0,r3,6h                                
08036B3A 3020     add     r0,20h                                  
08036B3C 0400     lsl     r0,r0,10h                               
08036B3E 0C07     lsr     r7,r0,10h                               
08036B40 0190     lsl     r0,r2,6h                                
08036B42 3020     add     r0,20h                                  
08036B44 0400     lsl     r0,r0,10h                               
08036B46 0C00     lsr     r0,r0,10h                               
08036B48 4680     mov     r8,r0                                   
08036B4A 8821     ldrh    r1,[r4]                                 
08036B4C 2080     mov     r0,80h                                  
08036B4E 00C0     lsl     r0,r0,3h                                
08036B50 4008     and     r0,r1                                   
08036B52 2800     cmp     r0,0h                                   
08036B54 D005     beq     8036B62h                                
08036B56 88E0     ldrh    r0,[r4,6h]                              
08036B58 1BC0     sub     r0,r0,r7                                
08036B5A 0400     lsl     r0,r0,10h                               
08036B5C 0C00     lsr     r0,r0,10h                               
08036B5E 4682     mov     r10,r0                                  
08036B60 E004     b       8036B6Ch                                
08036B62 88E0     ldrh    r0,[r4,6h]                              
08036B64 1A38     sub     r0,r7,r0                                
08036B66 0400     lsl     r0,r0,10h                               
08036B68 0C00     lsr     r0,r0,10h                               
08036B6A 4681     mov     r9,r0                                   
08036B6C 8821     ldrh    r1,[r4]                                 
08036B6E 2080     mov     r0,80h                                  
08036B70 0080     lsl     r0,r0,2h                                
08036B72 4008     and     r0,r1                                   
08036B74 2800     cmp     r0,0h                                   
08036B76 D006     beq     8036B86h                                
08036B78 8920     ldrh    r0,[r4,8h]                              
08036B7A 4641     mov     r1,r8                                   
08036B7C 1A40     sub     r0,r0,r1                                
08036B7E 0400     lsl     r0,r0,10h                               
08036B80 0C00     lsr     r0,r0,10h                               
08036B82 9001     str     r0,[sp,4h]                              
08036B84 E005     b       8036B92h                                
08036B86 8920     ldrh    r0,[r4,8h]                              
08036B88 4642     mov     r2,r8                                   
08036B8A 1A10     sub     r0,r2,r0                                
08036B8C 0400     lsl     r0,r0,10h                               
08036B8E 0C00     lsr     r0,r0,10h                               
08036B90 9000     str     r0,[sp]                                 
08036B92 4D15     ldr     r5,=3000738h                            
08036B94 8829     ldrh    r1,[r5]                                 
08036B96 2080     mov     r0,80h                                  
08036B98 0080     lsl     r0,r0,2h                                
08036B9A 4008     and     r0,r1                                   
08036B9C 2800     cmp     r0,0h                                   
08036B9E D044     beq     8036C2Ah                                
08036BA0 2080     mov     r0,80h                                  
08036BA2 00C0     lsl     r0,r0,3h                                
08036BA4 4008     and     r0,r1                                   
08036BA6 2800     cmp     r0,0h                                   
08036BA8 D020     beq     8036BECh                                
08036BAA 9901     ldr     r1,[sp,4h]                              
08036BAC 1C08     mov     r0,r1                                   
08036BAE 4348     mul     r0,r1                                   
08036BB0 4652     mov     r2,r10                                  
08036BB2 4651     mov     r1,r10                                  
08036BB4 4351     mul     r1,r2                                   
08036BB6 1840     add     r0,r0,r1                                
08036BB8 F7CEFB06 bl      80051C8h                                
08036BBC 0400     lsl     r0,r0,10h                               
08036BBE 0C04     lsr     r4,r0,10h                               
08036BC0 2C00     cmp     r4,0h                                   
08036BC2 D06D     beq     8036CA0h                                
08036BC4 4651     mov     r1,r10                                  
08036BC6 0288     lsl     r0,r1,0Ah                               
08036BC8 1C21     mov     r1,r4                                   
08036BCA F054F833 bl      808AC34h                                
08036BCE 4370     mul     r0,r6                                   
08036BD0 1280     asr     r0,r0,0Ah                               
08036BD2 1838     add     r0,r7,r0                                
08036BD4 8068     strh    r0,[r5,2h]                              
08036BD6 9A01     ldr     r2,[sp,4h]                              
08036BD8 0290     lsl     r0,r2,0Ah                               
08036BDA 1C21     mov     r1,r4                                   
08036BDC F054F82A bl      808AC34h                                
08036BE0 4370     mul     r0,r6                                   
08036BE2 1280     asr     r0,r0,0Ah                               
08036BE4 4440     add     r0,r8                                   
08036BE6 E05A     b       8036C9Eh                                
08036BE8 0738     lsl     r0,r7,1Ch                               
08036BEA 0300     lsl     r0,r0,0Ch                               
08036BEC 9901     ldr     r1,[sp,4h]                              
08036BEE 1C08     mov     r0,r1                                   
08036BF0 4348     mul     r0,r1                                   
08036BF2 464A     mov     r2,r9                                   
08036BF4 4649     mov     r1,r9                                   
08036BF6 4351     mul     r1,r2                                   
08036BF8 1840     add     r0,r0,r1                                
08036BFA F7CEFAE5 bl      80051C8h                                
08036BFE 0400     lsl     r0,r0,10h                               
08036C00 0C04     lsr     r4,r0,10h                               
08036C02 2C00     cmp     r4,0h                                   
08036C04 D04C     beq     8036CA0h                                
08036C06 4649     mov     r1,r9                                   
08036C08 0288     lsl     r0,r1,0Ah                               
08036C0A 1C21     mov     r1,r4                                   
08036C0C F054F812 bl      808AC34h                                
08036C10 4370     mul     r0,r6                                   
08036C12 1280     asr     r0,r0,0Ah                               
08036C14 1A38     sub     r0,r7,r0                                
08036C16 8068     strh    r0,[r5,2h]                              
08036C18 9A01     ldr     r2,[sp,4h]                              
08036C1A 0290     lsl     r0,r2,0Ah                               
08036C1C 1C21     mov     r1,r4                                   
08036C1E F054F809 bl      808AC34h                                
08036C22 4370     mul     r0,r6                                   
08036C24 1280     asr     r0,r0,0Ah                               
08036C26 4440     add     r0,r8                                   
08036C28 E039     b       8036C9Eh                                
08036C2A 2080     mov     r0,80h                                  
08036C2C 00C0     lsl     r0,r0,3h                                
08036C2E 4008     and     r0,r1                                   
08036C30 2800     cmp     r0,0h                                   
08036C32 D015     beq     8036C60h                                
08036C34 9900     ldr     r1,[sp]                                 
08036C36 1C08     mov     r0,r1                                   
08036C38 4348     mul     r0,r1                                   
08036C3A 4652     mov     r2,r10                                  
08036C3C 4651     mov     r1,r10                                  
08036C3E 4351     mul     r1,r2                                   
08036C40 1840     add     r0,r0,r1                                
08036C42 F7CEFAC1 bl      80051C8h                                
08036C46 0400     lsl     r0,r0,10h                               
08036C48 0C04     lsr     r4,r0,10h                               
08036C4A 2C00     cmp     r4,0h                                   
08036C4C D028     beq     8036CA0h                                
08036C4E 4651     mov     r1,r10                                  
08036C50 0288     lsl     r0,r1,0Ah                               
08036C52 1C21     mov     r1,r4                                   
08036C54 F053FFEE bl      808AC34h                                
08036C58 4370     mul     r0,r6                                   
08036C5A 1280     asr     r0,r0,0Ah                               
08036C5C 1838     add     r0,r7,r0                                
08036C5E E014     b       8036C8Ah                                
08036C60 9A00     ldr     r2,[sp]                                 
08036C62 1C10     mov     r0,r2                                   
08036C64 4350     mul     r0,r2                                   
08036C66 464A     mov     r2,r9                                   
08036C68 4649     mov     r1,r9                                   
08036C6A 4351     mul     r1,r2                                   
08036C6C 1840     add     r0,r0,r1                                
08036C6E F7CEFAAB bl      80051C8h                                
08036C72 0400     lsl     r0,r0,10h                               
08036C74 0C04     lsr     r4,r0,10h                               
08036C76 2C00     cmp     r4,0h                                   
08036C78 D012     beq     8036CA0h                                
08036C7A 4649     mov     r1,r9                                   
08036C7C 0288     lsl     r0,r1,0Ah                               
08036C7E 1C21     mov     r1,r4                                   
08036C80 F053FFD8 bl      808AC34h                                
08036C84 4370     mul     r0,r6                                   
08036C86 1280     asr     r0,r0,0Ah                               
08036C88 1A38     sub     r0,r7,r0                                
08036C8A 8068     strh    r0,[r5,2h]                              
08036C8C 9A00     ldr     r2,[sp]                                 
08036C8E 0290     lsl     r0,r2,0Ah                               
08036C90 1C21     mov     r1,r4                                   
08036C92 F053FFCF bl      808AC34h                                
08036C96 4370     mul     r0,r6                                   
08036C98 1280     asr     r0,r0,0Ah                               
08036C9A 4641     mov     r1,r8                                   
08036C9C 1A08     sub     r0,r1,r0                                
08036C9E 80A8     strh    r0,[r5,4h]                              
08036CA0 4907     ldr     r1,=3000738h                            
08036CA2 888A     ldrh    r2,[r1,4h]                              
08036CA4 2080     mov     r0,80h                                  
08036CA6 0200     lsl     r0,r0,8h                                
08036CA8 4010     and     r0,r2                                   
08036CAA 1C0C     mov     r4,r1                                   
08036CAC 2800     cmp     r0,0h                                   
08036CAE D112     bne     8036CD6h                                
08036CB0 4904     ldr     r1,=30013D4h                            
08036CB2 8A48     ldrh    r0,[r1,12h]                             
08036CB4 4282     cmp     r2,r0                                   
08036CB6 D907     bls     8036CC8h                                
08036CB8 88A0     ldrh    r0,[r4,4h]                              
08036CBA 8A49     ldrh    r1,[r1,12h]                             
08036CBC E006     b       8036CCCh                                
08036CBE 0000     lsl     r0,r0,0h                                
08036CC0 0738     lsl     r0,r7,1Ch                               
08036CC2 0300     lsl     r0,r0,0Ch                               
08036CC4 13D4     asr     r4,r2,0Fh                               
08036CC6 0300     lsl     r0,r0,0Ch                               
08036CC8 8A48     ldrh    r0,[r1,12h]                             
08036CCA 88A1     ldrh    r1,[r4,4h]                              
08036CCC 1A40     sub     r0,r0,r1                                
08036CCE 2180     mov     r1,80h                                  
08036CD0 00C9     lsl     r1,r1,3h                                
08036CD2 4288     cmp     r0,r1                                   
08036CD4 DD04     ble     8036CE0h                                
08036CD6 9802     ldr     r0,[sp,8h]                              
08036CD8 3001     add     r0,1h                                   
08036CDA 0600     lsl     r0,r0,18h                               
08036CDC 0E00     lsr     r0,r0,18h                               
08036CDE 9002     str     r0,[sp,8h]                              
08036CE0 1C23     mov     r3,r4                                   
08036CE2 885A     ldrh    r2,[r3,2h]                              
08036CE4 2080     mov     r0,80h                                  
08036CE6 0200     lsl     r0,r0,8h                                
08036CE8 4010     and     r0,r2                                   
08036CEA 2800     cmp     r0,0h                                   
08036CEC D10F     bne     8036D0Eh                                
08036CEE 4903     ldr     r1,=30013D4h                            
08036CF0 8A88     ldrh    r0,[r1,14h]                             
08036CF2 4282     cmp     r2,r0                                   
08036CF4 D904     bls     8036D00h                                
08036CF6 8858     ldrh    r0,[r3,2h]                              
08036CF8 8A89     ldrh    r1,[r1,14h]                             
08036CFA E003     b       8036D04h                                
08036CFC 13D4     asr     r4,r2,0Fh                               
08036CFE 0300     lsl     r0,r0,0Ch                               
08036D00 8A88     ldrh    r0,[r1,14h]                             
08036D02 8861     ldrh    r1,[r4,2h]                              
08036D04 1A40     sub     r0,r0,r1                                
08036D06 2180     mov     r1,80h                                  
08036D08 00C9     lsl     r1,r1,3h                                
08036D0A 4288     cmp     r0,r1                                   
08036D0C DD04     ble     8036D18h                                
08036D0E 9802     ldr     r0,[sp,8h]                              
08036D10 3001     add     r0,1h                                   
08036D12 0600     lsl     r0,r0,18h                               
08036D14 0E00     lsr     r0,r0,18h                               
08036D16 9002     str     r0,[sp,8h]                              
08036D18 9902     ldr     r1,[sp,8h]                              
08036D1A 2900     cmp     r1,0h                                   
08036D1C D001     beq     8036D22h                                
08036D1E F7FFFD5F bl      80367E0h                                
08036D22 B003     add     sp,0Ch                                  
08036D24 BC38     pop     r3-r5                                   
08036D26 4698     mov     r8,r3                                   
08036D28 46A1     mov     r9,r4                                   
08036D2A 46AA     mov     r10,r5                                  
08036D2C BCF0     pop     r4-r7                                   
08036D2E BC01     pop     r0                                      
08036D30 4700     bx      r0                                      
08036D32 0000     lsl     r0,r0,0h 

;红蓝普通电圈  主程序                             
08036D34 B510     push    r4,r14                                  
08036D36 B081     add     sp,-4h                                  
08036D38 4C04     ldr     r4,=3000738h                            
08036D3A 1C20     mov     r0,r4                                   
08036D3C 3030     add     r0,30h                                  
08036D3E 7800     ldrb    r0,[r0]                                 
08036D40 2800     cmp     r0,0h                                   
08036D42 D005     beq     @@NoFrozen  ;冰冻时间为0                              
08036D44 F7D9F950 bl      Frozen                                
08036D48 E03B     b       @@end                                

@@NoFrozen:                              
08036D50 F7DAFA96 bl      StunSprite                                
08036D54 2800     cmp     r0,0h                                   
08036D56 D134     bne     @@end                                
08036D58 1C20     mov     r0,r4                                   
08036D5A 3024     add     r0,24h                                  
08036D5C 7800     ldrb    r0,[r0]                                 
08036D5E 2809     cmp     r0,9h                                   
08036D60 D00D     beq     @@posenine                                
08036D62 2809     cmp     r0,9h                                   
08036D64 DC04     bgt     @@morethanine                                
08036D66 2800     cmp     r0,0h                                   
08036D68 D005     beq     @@posezero                                
08036D6A 2808     cmp     r0,8h                                   
08036D6C D005     beq     @@poseight                                
08036D6E E00C     b       @@otherpose

@@morethanine:                                
08036D70 2823     cmp     r0,23h                                  
08036D72 D007     beq     @@pose23                                
08036D74 E009     b       @@otherpose
 -
@@posezero:                               
08036D76 F7FFFAC9 bl      803630Ch  ;00  

@@poseight:                                
08036D7A F7FFFB13 bl      80363A4h  ;08h 

@@posenine:                                
08036D7E F7FFFB79 bl      8036474h  ;09h                               
08036D82 E01E     b       @@end  

@@pose23:                              
08036D84 F7FFFC02 bl      803658Ch  ;23h                                
08036D88 E01B     b       @@end 
 
@@otherpose:                              
08036D8A F7D9FD91 bl      DeathCheck                                
08036D8E 2800     cmp     r0,0h                                   
08036D90 D00C     beq     @@Nodrop                                
08036D92 4805     ldr     r0,=3000738h                            
08036D94 8841     ldrh    r1,[r0,2h]                              
08036D96 8882     ldrh    r2,[r0,4h]                              
08036D98 2020     mov     r0,20h                                  
08036D9A 9000     str     r0,[sp]                                 
08036D9C 2002     mov     r0,2h                                   
08036D9E 2301     mov     r3,1h                                   
08036DA0 F7DAF970 bl      DeathFireworks                                
08036DA4 E00B     b       @@peer                                

@@Nodrop:                               
08036DAC 4807     ldr     r0,=3000738h                            
08036DAE 8841     ldrh    r1,[r0,2h]                              
08036DB0 8882     ldrh    r2,[r0,4h]                              
08036DB2 2020     mov     r0,20h                                  
08036DB4 9000     str     r0,[sp]                                 
08036DB6 2001     mov     r0,1h                                   
08036DB8 2301     mov     r3,1h                                   
08036DBA F7DAF963 bl      DeathFireworks 

@@peer:                               
08036DBE F7FFFB0F bl      80363E0h ;再生产

@@end:                               
08036DC2 B001     add     sp,4h                                   
08036DC4 BC10     pop     r4                                      
08036DC6 BC01     pop     r0                                      
08036DC8 4700     bx      r0                                      

;最后五种电圈  主程序                             
08036DD0 B510     push    r4,r14                                  
08036DD2 B081     add     sp,-4h                                  
08036DD4 2003     mov     r0,3h                                   
08036DD6 2127     mov     r1,27h                                  
08036DD8 F029FD70 bl      EventCheck                                
08036DDC 2800     cmp     r0,0h                                   
08036DDE D025     beq     @@eventnotrigger                                
08036DE0 4A10     ldr     r2,=3000738h                            
08036DE2 8811     ldrh    r1,[r2]                                 
08036DE4 2002     mov     r0,2h                                   
08036DE6 4008     and     r0,r1                                   
08036DE8 2800     cmp     r0,0h                                   
08036DEA D008     beq     @@fireworksless     ;未在屏内                           
08036DEC 2004     mov     r0,4h                                   
08036DEE 4008     and     r0,r1                                   
08036DF0 2800     cmp     r0,0h                                   
08036DF2 D104     bne     @@fireworksless     ;消失?                           
08036DF4 8850     ldrh    r0,[r2,2h]                              
08036DF6 8891     ldrh    r1,[r2,4h]                              
08036DF8 221F     mov     r2,1Fh                                  
08036DFA F01DF977 bl      setfireworksgfx 

@@fireworksless:                               
08036DFE 4809     ldr     r0,=3000738h                            
08036E00 1C03     mov     r3,r0                                   
08036E02 3331     add     r3,31h                                  
08036E04 7819     ldrb    r1,[r3]                                 
08036E06 1C04     mov     r4,r0                                   
08036E08 2900     cmp     r1,0h                                   
08036E0A D007     beq     @@NOONsprite        ;检查不在敌人身上                         
08036E0C 4A06     ldr     r2,=30013D4h                            
08036E0E 7850     ldrb    r0,[r2,1h]                              
08036E10 2801     cmp     r0,1h                                   
08036E12 D103     bne     @@NOONsprite        ;检查不在敌人身上                        
08036E14 2100     mov     r1,0h                                   
08036E16 2002     mov     r0,2h                                   
08036E18 7050     strb    r0,[r2,1h]          ;变得在空中                    
08036E1A 7019     strb    r1,[r3]             ;不在敌人身上

@@NOONsprite:                                
08036E1C 2000     mov     r0,0h                                   
08036E1E 8020     strh    r0,[r4]             ;消失结束                    
08036E20 E049     b       @@end                                

@@eventnotrigger:                              
08036E2C 4C04     ldr     r4,=3000738h                            
08036E2E 1C20     mov     r0,r4                                   
08036E30 3030     add     r0,30h                                  
08036E32 7800     ldrb    r0,[r0]                                 
08036E34 2800     cmp     r0,0h                                   
08036E36 D005     beq     @@nofrozen                                
08036E38 F7D9F8D6 bl      frozen                                
08036E3C E03B     b       @@end                                

@@nofrozen:                              
08036E44 F7DAFA1C bl      stunsprite                                
08036E48 2800     cmp     r0,0h                                   
08036E4A D134     bne     @@end                                
08036E4C 1C20     mov     r0,r4                                   
08036E4E 3024     add     r0,24h                                  
08036E50 7800     ldrb    r0,[r0]                                 
08036E52 2809     cmp     r0,9h                                   
08036E54 D00D     beq     @@posenine                                
08036E56 2809     cmp     r0,9h                                   
08036E58 DC04     bgt     @@morethanine                                
08036E5A 2800     cmp     r0,0h                                   
08036E5C D005     beq     @@posezero                                
08036E5E 2808     cmp     r0,8h                                   
08036E60 D005     beq     @@poseight                                
08036E62 E00C     b       @@otherpose

@@morethanine:                                
08036E64 2823     cmp     r0,23h                                  
08036E66 D007     beq     @@pose23                                
08036E68 E009     b       @@otherpose 

@@posezero:                               
08036E6A F7FFFA4F bl      803630Ch 

@@poseight:                               
08036E6E F7FFFCA7 bl      80367C0h 

@@posenine:                               
08036E72 F7FFFD77 bl      8036964h                                
08036E76 E01E     b       @@end    

@@pose23:                            
08036E78 F7FFFDFC bl      8036A74h                                
08036E7C E01B     b       @@end   

@@otherpose:                             
08036E7E F7D9FD17 bl      80108B0h                                
08036E82 2800     cmp     r0,0h                                   
08036E84 D00C     beq     @@nodrop                                
08036E86 4805     ldr     r0,=3000738h                            
08036E88 8841     ldrh    r1,[r0,2h]                              
08036E8A 8882     ldrh    r2,[r0,4h]                              
08036E8C 2020     mov     r0,20h                                  
08036E8E 9000     str     r0,[sp]                                 
08036E90 2002     mov     r0,2h                                   
08036E92 2301     mov     r3,1h                                   
08036E94 F7DAF8F6 bl      spritedeath                                
08036E98 E00B     b       8036EB2h                                
 
@@nodrop: 
08036EA0 4807     ldr     r0,=3000738h                            
08036EA2 8841     ldrh    r1,[r0,2h]                              
08036EA4 8882     ldrh    r2,[r0,4h]                              
08036EA6 2020     mov     r0,20h                                  
08036EA8 9000     str     r0,[sp]                                 
08036EAA 2001     mov     r0,1h                                   
08036EAC 2301     mov     r3,1h                                   
08036EAE F7DAF8E9 bl      spritedeath

                                
08036EB2 F7FFFC95 bl      80367E0h 

@@end:                               
08036EB6 B001     add     sp,4h                                   
08036EB8 BC10     pop     r4                                      
08036EBA BC01     pop     r0                                      
08036EBC 4700     bx      r0                                      
