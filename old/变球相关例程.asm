800e6de转

080074E8 B5F0     push    r4-r7,r14          ;输入姿势                      
080074EA 0600     lsl     r0,r0,18h                               
080074EC 4D0D     ldr     r5,=30013D4h                            
080074EE 4E0E     ldr     r6,=30013F4h                            
080074F0 4F0E     ldr     r7,=3001414h                            
080074F2 0E04     lsr     r4,r0,18h                               
080074F4 21E0     mov     r1,0E0h                                 
080074F6 04C9     lsl     r1,r1,13h       ;得到7000000                           
080074F8 1840     add     r0,r0,r1                                
080074FA 0E00     lsr     r0,r0,18h       ;7加上姿势                         
080074FC 2801     cmp     r0,1h                                   
080074FE D801     bhi     @@posemorethan8        ;姿势大于8?                        
08007500 2000     mov     r0,0h                                   
08007502 70E8     strb    r0,[r5,3h]      ;转向flag写入0 

@@posemorethan8:                      
08007504 1C28     mov     r0,r5                                   
08007506 F000F859 bl      80075BCh                                
0800750A 78B0     ldrb    r0,[r6,2h]     ;肩炮方向                         
0800750C 2805     cmp     r0,5h          ;如果不为none 跳转                        
0800750E D101     bne     @@ArmCannonDirection                                
08007510 2000     mov     r0,0h                                   
08007512 70B0     strb    r0,[r6,2h]     ;肩炮写入向前

@@ArmCannonDirection:                             
08007514 7830     ldrb    r0,[r6]        ;读取之前的姿势                         
08007516 2822     cmp     r0,22h         ;冲刺中                         
08007518 D012     beq     @@Shinespaking       ;跳转                         
0800751A 2822     cmp     r0,22h         ;大于这个姿势跳转                         
0800751C DC08     bgt     @@morethan22                                
0800751E 2821     cmp     r0,21h         ;冲刺之前的延迟                         
08007520 D00B     beq     @@WillSpinespaking                               
08007522 E01E     b       @@Pass                                
 
@@morethan22: 
08007530 2825     cmp     r0,25h         ;球冲刺之前的延迟                                
08007532 D00B     beq     @@WillBallSp                                
08007534 2826     cmp     r0,26h         ;球冲刺                         
08007536 D00F     beq     @@BallSp                                
08007538 E013     b       @@Pass 

@@WillSpinespaking:                               
0800753A 2C22     cmp     r4,22h         ;如果当前是冲刺姿势                         
0800753C D011     beq     @@Pass                                
0800753E E001     b       @@Shinesparkingsound 

@@Shinespaking:                              
08007540 2C23     cmp     r4,23h                                  
08007542 D00E     beq     @@Pass 

@@Shinesparkingsound:                               
08007544 208E     mov     r0,8Eh                                  
08007546 F7FBFA6F bl      8002A28h                                
0800754A E00A     b       @@Pass

@@WillBallSp:                                
0800754C 2C26     cmp     r4,26h                                  
0800754E D008     beq     @@Pass                                
08007550 208F     mov     r0,8Fh         ;如果还没有达到球冲刺时                         
08007552 F7FBFA69 bl      8002A28h       ;播放球将要冲刺的声音                         
08007556 E004     b       @@Pass

@@BallSp:                                
08007558 2C27     cmp     r4,27h         ;如果姿势是球冲刺完结                          
0800755A D002     beq     @@Pass                                
0800755C 208F     mov     r0,8Fh         ;否则一直播放球冲刺的声音                         
0800755E F7FBFA63 bl      8002A28h 

@@Pass:                               
08007562 2CFA     cmp     r4,0FAh                                 
08007564 D014     beq     @@PoseFA                                
08007566 2CFA     cmp     r4,0FAh                                 
08007568 DC02     bgt     @@MoreThanFA                                
0800756A 2CF9     cmp     r4,0F9h                                 
0800756C D016     beq     @@PoseF9                                
0800756E E01B     b       @@Peer 

@@MoreThanFA:                               
08007570 2CFD     cmp     r4,0FDh                                 
08007572 D007     beq     8007584h                                
08007574 2CFE     cmp     r4,0FEh                                 
08007576 D117     bne     @@Peer                                
08007578 1C28     mov     r0,r5                                   
0800757A 1C31     mov     r1,r6                                   
0800757C 1C3A     mov     r2,r7                                   
0800757E F7FFF9E7 bl      8006950h                                
08007582 E017     b       80075B4h                                
08007584 1C28     mov     r0,r5                                   
08007586 1C31     mov     r1,r6                                   
08007588 1C3A     mov     r2,r7                                   
0800758A F7FFFB4F bl      8006C2Ch                                
0800758E E011     b       80075B4h 

@@PoseFA:                               
08007590 1C28     mov     r0,r5                                   
08007592 1C31     mov     r1,r6                                   
08007594 1C3A     mov     r2,r7                                   
08007596 F7FFFC89 bl      8006EACh                                
0800759A E00B     b       80075B4h 

@@PoseF9:                               
0800759C 1C28     mov     r0,r5                                   
0800759E 1C31     mov     r1,r6                                   
080075A0 1C3A     mov     r2,r7                                   
080075A2 F7FFFD51 bl      8007048h                                
080075A6 E005     b       80075B4h

@@Peer:                                
080075A8 702C     strb    r4,[r5]                                 
080075AA 1C28     mov     r0,r5                                   
080075AC 1C31     mov     r1,r6                                   
080075AE 1C3A     mov     r2,r7                                   
080075B0 F7FFFDD8 bl      8007164h                                
080075B4 BCF0     pop     r4-r7                                   
080075B6 BC01     pop     r0                                      
080075B8 4700     bx      r0                                      
080075BA 0000     lsl     r0,r0,0h 

                               
080075BC B570     push    r4-r6,r14                               
080075BE 4A14     ldr     r2,=30013D4h                            
080075C0 4B14     ldr     r3,=3001528h                            
080075C2 4815     ldr     r0,=30013F4h                            
080075C4 1C11     mov     r1,r2                                   
080075C6 C970     ldmia   [r1]!,r4-r6                             
080075C8 C070     stmia   [r0]!,r4-r6                             
080075CA C970     ldmia   [r1]!,r4-r6                             
080075CC C070     stmia   [r0]!,r4-r6                             
080075CE C930     ldmia   [r1]!,r4,r5                             
080075D0 C030     stmia   [r0]!,r4,r5                             
080075D2 78D0     ldrb    r0,[r2,3h]                              
080075D4 2800     cmp     r0,0h                                   
080075D6 D005     beq     80075E4h                                
080075D8 89D0     ldrh    r0,[r2,0Eh]                             
080075DA 2130     mov     r1,30h                                  
080075DC 4048     eor     r0,r1                                   
080075DE 2100     mov     r1,0h                                   
080075E0 81D0     strh    r0,[r2,0Eh]                             
080075E2 70D1     strb    r1,[r2,3h]                              
080075E4 2000     mov     r0,0h                                   
080075E6 7090     strb    r0,[r2,2h]                              
080075E8 7110     strb    r0,[r2,4h]                              
080075EA 7150     strb    r0,[r2,5h]                              
080075EC 71D0     strb    r0,[r2,7h]                              
080075EE 7290     strb    r0,[r2,0Ah]                             
080075F0 2100     mov     r1,0h                                   
080075F2 8190     strh    r0,[r2,0Ch]                             
080075F4 8210     strh    r0,[r2,10h]                             
080075F6 82D0     strh    r0,[r2,16h]                             
080075F8 8310     strh    r0,[r2,18h]                             
080075FA 7711     strb    r1,[r2,1Ch]                             
080075FC 7751     strb    r1,[r2,1Dh]                             
080075FE 7A10     ldrb    r0,[r2,8h]                              
08007600 28B4     cmp     r0,0B4h                                 
08007602 D000     beq     8007606h                                
08007604 7019     strb    r1,[r3]                                 
08007606 7059     strb    r1,[r3,1h]                              
08007608 7099     strb    r1,[r3,2h]                              
0800760A BC70     pop     r4-r6                                   
0800760C BC01     pop     r0                                      
0800760E 4700     bx      r0  

                                    
08007610 13D4     asr     r4,r2,0Fh                               
08007612 0300     lsl     r0,r0,0Ch                               
08007614 1528     asr     r0,r5,14h                               
08007616 0300     lsl     r0,r0,0Ch                               
08007618 13F4     asr     r4,r6,0Fh                               
0800761A 0300     lsl     r0,r0,0Ch                               
0800761C B5F0     push    r4-r7,r14                               
0800761E 4E09     ldr     r6,=30013D4h                            
08007620 4F09     ldr     r7,=3001530h                            
08007622 4C0A     ldr     r4,=3001588h                            
08007624 490A     ldr     r1,=3004FC9h                            
08007626 2000     mov     r0,0h                                   
08007628 7008     strb    r0,[r1]                                 
0800762A 7830     ldrb    r0,[r6]                                 
0800762C 2815     cmp     r0,15h                                  
0800762E DB11     blt     8007654h                                
08007630 281C     cmp     r0,1Ch                                  
08007632 DD01     ble     8007638h                                
08007634 283D     cmp     r0,3Dh                                  
08007636 D10D     bne     8007654h                                
08007638 8AB0     ldrh    r0,[r6,14h]                             
0800763A 3810     sub     r0,10h                                  
0800763C 0400     lsl     r0,r0,10h                               
0800763E 0C00     lsr     r0,r0,10h                               
08007640 E009     b       8007656h                                
08007642 0000     lsl     r0,r0,0h                                
08007644 13D4     asr     r4,r2,0Fh                               
08007646 0300     lsl     r0,r0,0Ch                               
08007648 1530     asr     r0,r6,14h                               
0800764A 0300     lsl     r0,r0,0Ch                               
0800764C 1588     asr     r0,r1,16h                               
0800764E 0300     lsl     r0,r0,0Ch                               
08007650 4FC9     ldr     r7,=2080DC04h                           
08007652 0300     lsl     r0,r0,0Ch                               
08007654 8AB0     ldrh    r0,[r6,14h]                             
08007656 2500     mov     r5,0h                                   
08007658 8A71     ldrh    r1,[r6,12h]                             
0800765A F050FD11 bl      8058080h                                
0800765E 1C01     mov     r1,r0                                   
08007660 20FF     mov     r0,0FFh                                 
08007662 4001     and     r1,r0                                   
08007664 2904     cmp     r1,4h                                   
08007666 DC08     bgt     800767Ah                                
08007668 2901     cmp     r1,1h                                   
0800766A DB06     blt     800767Ah                                
0800766C 7BF9     ldrb    r1,[r7,0Fh]                             
0800766E 2020     mov     r0,20h                                  
08007670 4008     and     r0,r1                                   
08007672 2800     cmp     r0,0h                                   
08007674 D106     bne     8007684h                                
08007676 2501     mov     r5,1h                                   
08007678 E004     b       8007684h                                
0800767A 4814     ldr     r0,=3001530h                            
0800767C 7CC0     ldrb    r0,[r0,13h]                             
0800767E 2800     cmp     r0,0h                                   
08007680 D000     beq     8007684h                                
08007682 3501     add     r5,1h                                   
08007684 1C20     mov     r0,r4                                   
08007686 305B     add     r0,5Bh                                  
08007688 7005     strb    r5,[r0]                                 
0800768A 2D00     cmp     r5,0h                                   
0800768C D020     beq     80076D0h                                
0800768E 3003     add     r0,3h                                   
08007690 2204     mov     r2,4h                                   
08007692 8002     strh    r2,[r0]                                 
08007694 1C21     mov     r1,r4                                   
08007696 3160     add     r1,60h                                  
08007698 2030     mov     r0,30h                                  
0800769A 8008     strh    r0,[r1]                                 
0800769C 310A     add     r1,0Ah                                  
0800769E 2020     mov     r0,20h                                  
080076A0 8008     strh    r0,[r1]                                 
080076A2 1C20     mov     r0,r4                                   
080076A4 3068     add     r0,68h                                  
080076A6 8002     strh    r2,[r0]                                 
080076A8 3102     add     r1,2h                                   
080076AA 2018     mov     r0,18h                                  
080076AC 8008     strh    r0,[r1]                                 
080076AE 390A     sub     r1,0Ah                                  
080076B0 2005     mov     r0,5h                                   
080076B2 8008     strh    r0,[r1]                                 
080076B4 1C20     mov     r0,r4                                   
080076B6 3064     add     r0,64h                                  
080076B8 2128     mov     r1,28h                                  
080076BA 8001     strh    r1,[r0]                                 
080076BC 3002     add     r0,2h                                   
080076BE 8001     strh    r1,[r0]                                 
080076C0 7970     ldrb    r0,[r6,5h]                              
080076C2 2800     cmp     r0,0h                                   
080076C4 D026     beq     8007714h                                
080076C6 2000     mov     r0,0h                                   
080076C8 7170     strb    r0,[r6,5h]                              
080076CA E023     b       8007714h                                
080076CC 1530     asr     r0,r6,14h                               
080076CE 0300     lsl     r0,r0,0Ch                               
080076D0 1C20     mov     r0,r4                                   
080076D2 305E     add     r0,5Eh                                  
080076D4 2108     mov     r1,8h                                   
080076D6 8001     strh    r1,[r0]                                 
080076D8 1C23     mov     r3,r4                                   
080076DA 3360     add     r3,60h                                  
080076DC 2060     mov     r0,60h                                  
080076DE 8018     strh    r0,[r3]                                 
080076E0 1C22     mov     r2,r4                                   
080076E2 326A     add     r2,6Ah                                  
080076E4 2040     mov     r0,40h                                  
080076E6 8010     strh    r0,[r2]                                 
//////////////////////////////////////////////////////////////////////

EE54转

;获取精灵伤害例程 r0 = Knockback flag; r1 = Sprite data pointer; r2 = Damage multiplier
0800E634 B5F0     push    r4-r7,r14                               
0800E636 1C0B     mov     r3,r1       ;伤害sa精灵的数据起始                            
0800E638 0600     lsl     r0,r0,18h                               
0800E63A 0E07     lsr     r7,r0,18h   ;确认是否反弹 1                            
0800E63C 0412     lsl     r2,r2,10h                               
0800E63E 0C14     lsr     r4,r2,10h   ;正常情况下是1,也许困难是2                            
0800E640 1C18     mov     r0,r3                                   
0800E642 3032     add     r0,32h                                  
0800E644 7801     ldrb    r1,[r0]                                 
0800E646 2080     mov     r0,80h                                  
0800E648 4008     and     r0,r1                                   
0800E64A 2800     cmp     r0,0h       ;检查是否是副精灵                            
0800E64C D004     beq     @@PriSpriteDamage                                
0800E64E 4A01     ldr     r2,=82B1BE4h                            
0800E650 E003     b       @@Peer                               


@@PriSpriteDamage:                              
0800E658 4A0A     ldr     r2,=82B0D68h 

@@Peer:                           
0800E65A 7F59     ldrb    r1,[r3,1Dh] ;读取精灵ID                            
0800E65C 00C8     lsl     r0,r1,3h                                
0800E65E 1840     add     r0,r0,r1                                
0800E660 0040     lsl     r0,r0,1h    ;18倍                             
0800E662 3202     add     r2,2h                                   
0800E664 1880     add     r0,r0,r2                                
0800E666 8803     ldrh    r3,[r0]     ;读取伤害                            
0800E668 1C18     mov     r0,r3                                   
0800E66A 4360     mul     r0,r4                                   
0800E66C 0405     lsl     r5,r0,10h                               
0800E66E 0C2B     lsr     r3,r5,10h   ;防止伤害溢出                            
0800E670 4905     ldr     r1,=3001530h                            
0800E672 7BCA     ldrb    r2,[r1,0Fh] ;读取激活的能力值                            
0800E674 1C14     mov     r4,r2                                   
0800E676 2030     mov     r0,30h                                  
0800E678 4010     and     r0,r2       ;检查两套服装是否都有                            
0800E67A 1C0E     mov     r6,r1                                   
0800E67C 2830     cmp     r0,30h                                  
0800E67E D105     bne    @@NobothSuit                                
0800E680 0C6B     lsr     r3,r5,11h   ;伤害减倍                            
0800E682 E014     b       @@DamageConst                                

@@NobothSuit:                               
0800E68C 2020     mov     r0,20h                                  
0800E68E 4002     and     r2,r0       ;检查是否有重力服                            
0800E690 2A00     cmp     r2,0h                                    
0800E692 D002     beq     @@CheckVaria                                
0800E694 00D8     lsl     r0,r3,3h                                
0800E696 1AC0     sub     r0,r0,r3    ;伤害乘以7                            
0800E698 E004     b       @@Division 

@@CheckVaria:                               
0800E69A 2010     mov     r0,10h                                  
0800E69C 4004     and     r4,r0                                   
0800E69E 2C00     cmp     r4,0h                                   
0800E6A0 D005     beq     @@DamageConst                                
0800E6A2 00D8     lsl     r0,r3,3h    ;伤害乘以8        

@@Division:                    
0800E6A4 210A     mov     r1,0Ah                                  
0800E6A6 F07CFAC5 bl      808AC34h    ;除法例程                            
0800E6AA 0400     lsl     r0,r0,10h                               
0800E6AC 0C03     lsr     r3,r0,10h  

@@DamageConst:                             
0800E6AE 4803     ldr     r0,=300002Ch                            
0800E6B0 7800     ldrb    r0,[r0]     ;获取难度                            
0800E6B2 2800     cmp     r0,0h                                   
0800E6B4 D104     bne     @@NoEasyMode                                
0800E6B6 085B     lsr     r3,r3,1h    ;容易模式伤害除以2                            
0800E6B8 E006     b       @@AtLastDamage                                

@@NoEasyMode:                               
0800E6C0 2802     cmp     r0,2h                                   
0800E6C2 D101     bne     @@AtLastDamage ;也不是困难模式                               
0800E6C4 0458     lsl     r0,r3,11h      ;伤害乘以2                         
0800E6C6 0C03     lsr     r3,r0,10h

@@AtLastDamage:                              
0800E6C8 2B00     cmp     r3,0h                                   
0800E6CA D100     bne     @@Pass       ;如果伤害不为0                          
0800E6CC 2301     mov     r3,1h          ;自动写1  

@@Pass:                       
0800E6CE 88F0     ldrh    r0,[r6,6h]                              
0800E6D0 4298     cmp     r0,r3        ;比较当前血量和伤害                            
0800E6D2 D908     bls     @@Death                                
0800E6D4 1AC0     sub     r0,r0,r3                                
0800E6D6 80F0     strh    r0,[r6,6h]   ;减去后再写入                            
0800E6D8 2F00     cmp     r7,0h        ;检查是否反弹                           
0800E6DA D002     beq     Noknockback                                
0800E6DC 20FA     mov     r0,0FAh                                 
0800E6DE F7F8FF03 bl      80074E8h

@@Noknockback:                                
0800E6E2 2001     mov     r0,1h                                   
0800E6E4 E005     b       @@end  

@@Death:                              
0800E6E6 2000     mov     r0,0h                                   
0800E6E8 80F0     strh    r0,[r6,6h]                              
0800E6EA 20FA     mov     r0,0FAh                                 
0800E6EC F7F8FEFC bl      80074E8h                                
0800E6F0 2000     mov     r0,0h  

@@end:                                 
0800E6F2 BCF0     pop     r4-r7                                   
0800E6F4 BC02     pop     r1                                      
0800E6F6 4708     bx      r1  


                                    
0800E6F8 B5F0     push    r4-r7,r14                               
0800E6FA 4647     mov     r7,r8                                   
0800E6FC B480     push    r7                                      
0800E6FE 9C06     ldr     r4,[sp,18h]                             
0800E700 9D07     ldr     r5,[sp,1Ch]                             
0800E702 46A8     mov     r8,r5                                   
0800E704 9D08     ldr     r5,[sp,20h]                             
0800E706 9E09     ldr     r6,[sp,24h]                             
0800E708 0400     lsl     r0,r0,10h                               
0800E70A 0409     lsl     r1,r1,10h                               
0800E70C 0C09     lsr     r1,r1,10h                               
0800E70E 0412     lsl     r2,r2,10h                               
0800E710 0C12     lsr     r2,r2,10h                               
0800E712 041B     lsl     r3,r3,10h                               
0800E714 0C1B     lsr     r3,r3,10h                               
0800E716 0424     lsl     r4,r4,10h                               
0800E718 0C24     lsr     r4,r4,10h                               
0800E71A 4647     mov     r7,r8                                   
0800E71C 043F     lsl     r7,r7,10h                               
0800E71E 46B8     mov     r8,r7                                   
0800E720 042D     lsl     r5,r5,10h                               
0800E722 0C2D     lsr     r5,r5,10h                               
0800E724 0436     lsl     r6,r6,10h                               
0800E726 0C36     lsr     r6,r6,10h                               
0800E728 4580     cmp     r8,r0                                   
0800E72A D307     bcc     800E73Ch                                
0800E72C 428C     cmp     r4,r1                                   
0800E72E D205     bcs     800E73Ch                                
0800E730 4296     cmp     r6,r2                                   
0800E732 D303     bcc     800E73Ch                                
0800E734 429D     cmp     r5,r3                                   
0800E736 D201     bcs     800E73Ch                                
0800E738 2001     mov     r0,1h                                   
0800E73A E000     b       800E73Eh                                
0800E73C 2000     mov     r0,0h                                   
0800E73E BC08     pop     r3                                      
0800E740 4698     mov     r8,r3                                   
0800E742 BCF0     pop     r4-r7                                   
0800E744 BC02     pop     r1                                      
0800E746 4708     bx      r1                                      
0800E748 B5F0     push    r4-r7,r14                               
0800E74A 4657     mov     r7,r10                                  
0800E74C 464E     mov     r6,r9                                   
0800E74E 4645     mov     r5,r8                                   
0800E750 B4E0     push    r5-r7                                   
0800E752 B090     add     sp,-40h                                 
0800E754 481C     ldr     r0,=30013D4h                            
0800E756 4682     mov     r10,r0                                  
0800E758 2100     mov     r1,0h                                   
0800E75A 9104     str     r1,[sp,10h]                             
0800E75C 8A82     ldrh    r2,[r0,14h]                             
0800E75E 9205     str     r2,[sp,14h]                             
0800E760 8A43     ldrh    r3,[r0,12h]                             
0800E762 9306     str     r3,[sp,18h]                             
0800E764 4819     ldr     r0,=3001600h                            
0800E766 8800     ldrh    r0,[r0]                                 
0800E768 900B     str     r0,[sp,2Ch]                             
0800E76A 4919     ldr     r1,=3001588h                            
0800E76C 1C08     mov     r0,r1                                   
0800E76E 3070     add     r0,70h                                  
0800E770 8800     ldrh    r0,[r0]                                 
0800E772 1810     add     r0,r2,r0                                
0800E774 0400     lsl     r0,r0,10h                               
0800E776 0C00     lsr     r0,r0,10h                               
0800E778 9007     str     r0,[sp,1Ch]                             
0800E77A 1C08     mov     r0,r1                                   
0800E77C 3074     add     r0,74h                                  
0800E77E 8800     ldrh    r0,[r0]                                 
0800E780 1810     add     r0,r2,r0                                
0800E782 0400     lsl     r0,r0,10h                               
0800E784 0C00     lsr     r0,r0,10h                               
0800E786 9008     str     r0,[sp,20h]                             
0800E788 1C08     mov     r0,r1                                   
0800E78A 306E     add     r0,6Eh                                  
0800E78C 8800     ldrh    r0,[r0]                                 
0800E78E 1818     add     r0,r3,r0                                
0800E790 0400     lsl     r0,r0,10h                               
0800E792 0C00     lsr     r0,r0,10h                               
0800E794 9009     str     r0,[sp,24h]                             
0800E796 1C08     mov     r0,r1                                   
0800E798 3072     add     r0,72h                                  
0800E79A 8800     ldrh    r0,[r0]                                 
0800E79C 1818     add     r0,r3,r0                                
0800E79E 0400     lsl     r0,r0,10h                               
0800E7A0 0C00     lsr     r0,r0,10h                               
0800E7A2 900A     str     r0,[sp,28h]                             
0800E7A4 4651     mov     r1,r10                                  
0800E7A6 7808     ldrb    r0,[r1]                                 
0800E7A8 2826     cmp     r0,26h                                  
0800E7AA D128     bne     800E7FEh                                
0800E7AC 7908     ldrb    r0,[r1,4h]                              
0800E7AE 2800     cmp     r0,0h                                   
0800E7B0 D02B     beq     800E80Ah                                
0800E7B2 2801     cmp     r0,1h                                   
0800E7B4 D10E     bne     800E7D4h                                
0800E7B6 9807     ldr     r0,[sp,1Ch]                             
0800E7B8 3820     sub     r0,20h                                  
0800E7BA 0400     lsl     r0,r0,10h                               
0800E7BC 0C00     lsr     r0,r0,10h                               
0800E7BE 9007     str     r0,[sp,1Ch]                             
0800E7C0 9808     ldr     r0,[sp,20h]                             
0800E7C2 3020     add     r0,20h                                  
0800E7C4 E017     b       800E7F6h                                
0800E7C6 0000     lsl     r0,r0,0h                                
0800E7C8 13D4     asr     r4,r2,0Fh                               
0800E7CA 0300     lsl     r0,r0,0Ch                               
0800E7CC 1600     asr     r0,r0,18h                               
0800E7CE 0300     lsl     r0,r0,0Ch                               
0800E7D0 1588     asr     r0,r1,16h                               
0800E7D2 0300     lsl     r0,r0,0Ch                               
0800E7D4 9809     ldr     r0,[sp,24h]                             
0800E7D6 3818     sub     r0,18h                                  
0800E7D8 0400     lsl     r0,r0,10h                               
0800E7DA 0C00     lsr     r0,r0,10h                               
0800E7DC 9009     str     r0,[sp,24h]                             
0800E7DE 980A     ldr     r0,[sp,28h]                             
0800E7E0 3018     add     r0,18h                                  
0800E7E2 0400     lsl     r0,r0,10h                               
0800E7E4 0C00     lsr     r0,r0,10h                               
0800E7E6 900A     str     r0,[sp,28h]                             
0800E7E8 9807     ldr     r0,[sp,1Ch]                             
0800E7EA 3818     sub     r0,18h                                  
0800E7EC 0400     lsl     r0,r0,10h                               
0800E7EE 0C00     lsr     r0,r0,10h                               
0800E7F0 9007     str     r0,[sp,1Ch]                             
0800E7F2 9808     ldr     r0,[sp,20h]                             
0800E7F4 3018     add     r0,18h                                  
0800E7F6 0400     lsl     r0,r0,10h                               
0800E7F8 0C00     lsr     r0,r0,10h                               
0800E7FA 9008     str     r0,[sp,20h]                             
0800E7FC E00F     b       800E81Eh                                
0800E7FE 2822     cmp     r0,22h                                  
0800E800 D10D     bne     800E81Eh                                
0800E802 4652     mov     r2,r10                                  
0800E804 7910     ldrb    r0,[r2,4h]                              
0800E806 2800     cmp     r0,0h                                   
0800E808 D109     bne     800E81Eh                                
0800E80A 9809     ldr     r0,[sp,24h]                             
0800E80C 3820     sub     r0,20h                                  
0800E80E 0400     lsl     r0,r0,10h                               
0800E810 0C00     lsr     r0,r0,10h                               
0800E812 9009     str     r0,[sp,24h]                             
0800E814 980A     ldr     r0,[sp,28h]                             
0800E816 3020     add     r0,20h                                  
0800E818 0400     lsl     r0,r0,10h                               
0800E81A 0C00     lsr     r0,r0,10h                               
0800E81C 900A     str     r0,[sp,28h]                             
0800E81E 4E33     ldr     r6,=30001ACh                            
0800E820 23A8     mov     r3,0A8h                                 
0800E822 00DB     lsl     r3,r3,3h                                
0800E824 18F0     add     r0,r6,r3                                
0800E826 4286     cmp     r6,r0                                   
0800E828 D301     bcc     800E82Eh                                
0800E82A F000FD73 bl      800F314h                                
0800E82E 8830     ldrh    r0,[r6]                                 
0800E830 2103     mov     r1,3h                                   
0800E832 4008     and     r0,r1                                   

