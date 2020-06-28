.definelabel YTagRAM,30007F1h
.definelabel CheckSlope,800F360h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel RandomUpDown,800F844h
.definelabel FrozenRoutine,800FFE8h
.definelabel DeathFireWorks,8011084h
.definelabel StunSprite,8011280h
.definelabel PoseTable,8037BD4h
.definelabel PrimarySpriteStats,82B0D68h


;pose 00
0803743C B570     push    r4-r6,r14                               
0803743E F7D8FA01 bl      RandomUpDown ;随机值定义方向                               
08037442 4C0C     ldr     r4,=3000738h                            
08037444 8860     ldrh    r0,[r4,2h]                              
08037446 3820     sub     r0,20h       ;Y坐标Up20h                           
08037448 8060     strh    r0,[r4,2h]   ;再写入                             
0803744A 8860     ldrh    r0,[r4,2h]                              
0803744C 3020     add     r0,20h       ;Y坐标原值                             
0803744E 88A1     ldrh    r1,[r4,4h]                              
08037450 F7D8F91A bl      CheckBlock   ;检查出生脚底                           
08037454 4D08     ldr     r5,=30007F1h                           
08037456 7829     ldrb    r1,[r5]                                 
08037458 26F0     mov     r6,0F0h                                 
0803745A 1C30     mov     r0,r6                                   
0803745C 4008     and     r0,r1        ;F0 and 30007F1的值                                
0803745E 2800     cmp     r0,0h                                   
08037460 D00C     beq     @@nodownclip ;下方无接壤                              
08037462 8860     ldrh    r0,[r4,2h]                              
08037464 3008     add     r0,8h        ;Y坐标原值Up18h                           
08037466 8060     strh    r0,[r4,2h]   ;再写入                           
08037468 1C21     mov     r1,r4                                   
0803746A 3124     add     r1,24h                                  
0803746C 2009     mov     r0,9h                                   
0803746E 7008     strb    r0,[r1]      ;pose写入9                            
08037470 E03C     b       @@pose0still                                


@@nodownclip              ;下方无接壤再次判断                           
0803747C 8860     ldrh    r0,[r4,2h]                              
0803747E 3824     sub     r0,24h       ;Y坐标原值Up44h                            
08037480 88A1     ldrh    r1,[r4,4h]                              
08037482 F7D8F901 bl      CheckBlock    ;检查顶部砖块                             
08037486 7829     ldrb    r1,[r5]                                 
08037488 1C30     mov     r0,r6                                   
0803748A 4008     and     r0,r1                                   
0803748C 2800     cmp     r0,0h                                     
0803748E D007     beq     @@noupclip   ;上方无接壤                            
08037490 8860     ldrh    r0,[r4,2h]                              
08037492 3808     sub     r0,8h        ;Y坐标原值Up28h                           
08037494 8060     strh    r0,[r4,2h]   ;再写入                           
08037496 1C21     mov     r1,r4                                   
08037498 3124     add     r1,24h                                  
0803749A 2023     mov     r0,23h       ;pose写入23h                              
0803749C 7008     strb    r0,[r1]                                 
0803749E E025     b       @@pose0still  

@@noupclip:                  ;上方无接壤再次判断                             
080374A0 8860     ldrh    r0,[r4,2h]                              
080374A2 88A1     ldrh    r1,[r4,4h]                              
080374A4 3924     sub     r1,24h       ;X坐标Left24h                             
080374A6 F7D8F8EF bl      CheckBlock                                
080374AA 7829     ldrb    r1,[r5]                                 
080374AC 1C30     mov     r0,r6                                   
080374AE 4008     and     r0,r1                                   
080374B0 2800     cmp     r0,0h                                   
080374B2 D007     beq     @@noleftclip ;确认左无接壤                              
080374B4 88A0     ldrh    r0,[r4,4h]                              
080374B6 3808     sub     r0,8h        ;X坐标Left8h                           
080374B8 80A0     strh    r0,[r4,4h]   ;再写入                           
080374BA 1C21     mov     r1,r4                                   
080374BC 3124     add     r1,24h                                  
080374BE 2025     mov     r0,25h       ;pose写入25h                             
080374C0 7008     strb    r0,[r1]                                 
080374C2 E013     b       @@pose0still  

@@noleftclip                    ;左方无接壤                              
080374C4 8860     ldrh    r0,[r4,2h]                              
080374C6 88A1     ldrh    r1,[r4,4h]                              
080374C8 3120     add     r1,20h       ;X坐标Right20h                           
080374CA F7D8F8DD bl      CheckBlock                                
080374CE 7828     ldrb    r0,[r5]                                 
080374D0 1C32     mov     r2,r6                                   
080374D2 4002     and     r2,r0                                   
080374D4 2A00     cmp     r2,0h                                   
080374D6 D007     beq     @@norightclip ;全无接壤                             
080374D8 88A0     ldrh    r0,[r4,4h]                              
080374DA 3008     add     r0,8h        ;X坐标Right8h                          
080374DC 80A0     strh    r0,[r4,4h]   ;再写入                           
080374DE 1C21     mov     r1,r4                                   
080374E0 3124     add     r1,24h                                  
080374E2 2027     mov     r0,27h       ;pose写入27                              
080374E4 7008     strb    r0,[r1]                                 
080374E6 E001     b       @@pose0still    

@@norightclip:                            
080374E8 8022     strh    r2,[r4]      ;取向归0                               
080374EA E033     b       thend  

@@pose0still:               ;pose 00接续                               
080374EC 4B13     ldr     r3,=3000738h                            
080374EE 1C18     mov     r0,r3                                   
080374F0 3025     add     r0,25h                                  
080374F2 2100     mov     r1,0h                                   
080374F4 2404     mov     r4,4h                                   
080374F6 7004     strb    r4,[r0]        ;属性写入4h                        
080374F8 4811     ldr     r0,=82EF878h   ;写入OAM                         
080374FA 6198     str     r0,[r3,18h]                             
080374FC 7719     strb    r1,[r3,1Ch]                             
080374FE 82D9     strh    r1,[r3,16h]    ;归0                         
08037500 4A10     ldr     r2,=PrimarySpriteStats                            
08037502 7F59     ldrb    r1,[r3,1Dh]    ;获取ID                          
08037504 00C8     lsl     r0,r1,3h                                
08037506 1840     add     r0,r0,r1                                
08037508 0040     lsl     r0,r0,1h       ;18倍                          
0803750A 1880     add     r0,r0,r2       ;得到偏移值                         
0803750C 8800     ldrh    r0,[r0]                                 
0803750E 8298     strh    r0,[r3,14h]    ;写入血量                          
08037510 1C18     mov     r0,r3                                   
08037512 3027     add     r0,27h                                  
08037514 2110     mov     r1,10h                                  
08037516 7001     strb    r1,[r0]      ;300075f写入10h                           
08037518 3001     add     r0,1h                                   
0803751A 7001     strb    r1,[r0]      ;3000760写入10h                           
0803751C 3001     add     r0,1h                                   
0803751E 7001     strb    r1,[r0]      ;3000761写入10h                           
08037520 4909     ldr     r1,=0FFECh                              
08037522 8159     strh    r1,[r3,0Ah]  ;上部分界写入0FFECh                           
08037524 2014     mov     r0,14h                                  
08037526 8198     strh    r0,[r3,0Ch]  ;下部分界写入14h                           
08037528 81D9     strh    r1,[r3,0Eh]  ;左部分界写入0FFECh                           
0803752A 8218     strh    r0,[r3,10h]  ;右部分界写入14h                            
0803752C 7F58     ldrb    r0,[r3,1Dh]                           
0803752E 2869     cmp     r0,69h       ;判断是否是yollowball                           
08037530 D10C     bne     @@blueball   ;不是的话跳转                           
08037532 1C18     mov     r0,r3                                   
08037534 302E     add     r0,2Eh                                  
08037536 7004     strb    r4,[r0]      ;3000766写入4h                           
08037538 E00C     b       thend                                

@@blueball:                                                          
0803754C 1C19     mov     r1,r3                                   
0803754E 312E     add     r1,2Eh                                  
08037550 2002     mov     r0,2h        ;3000766写入2h                            
08037552 7008     strb    r0,[r1] 

thend:                                
08037554 BC70     pop     r4-r6                                   
08037556 BC01     pop     r0                                      
08037558 4700     bx      r0                                      
//////////////////////////////////////////////////////////////////////////////////
 
;pose 9h  下方接壤   Y坐标 Up18h
0803755C B5F0     push    r4-r7,r14                               
0803755E 464F     mov     r7,r9                                   
08037560 4646     mov     r6,r8                                   
08037562 B4C0     push    r6,r7                                   
08037564 4C0F     ldr     r4,=3000738h                            
08037566 1C20     mov     r0,r4                                   
08037568 302E     add     r0,2Eh                                  
0803756A 7800     ldrb    r0,[r0]                                 
0803756C 4681     mov     r9,r0       ;3000766的值                              
0803756E 8860     ldrh    r0,[r4,2h]                              
08037570 3018     add     r0,18h                                  
08037572 0400     lsl     r0,r0,10h                               
08037574 0C05     lsr     r5,r0,10h   ;Y坐标原值                            
08037576 88A6     ldrh    r6,[r4,4h]                              
08037578 1C31     mov     r1,r6                                   
0803757A 311C     add     r1,1Ch      ;X坐标Right1Ch                             
0803757C 1C28     mov     r0,r5                                   
0803757E F7D8F883 bl      CheckBlock                               
08037582 4F09     ldr     r7,=30007F1h                            
08037584 7838     ldrb    r0,[r7]                                 
08037586 2800     cmp     r0,0h                                   
08037588 D110     bne     @@downsideclip ;除非下右坡(下坡后的平面也算,但是upper斜坡不算),否则都跳转                          
0803758A 1C31     mov     r1,r6       ;也不包括上左墙转为左的转折,以及之后的延续                          
0803758C 3920     sub     r1,20h      ;X坐标Left20h                            
0803758E 1C28     mov     r0,r5                                   
08037590 F7D8F87A bl      CheckBlock                              
08037594 7838     ldrb    r0,[r7]                                 
08037596 2800     cmp     r0,0h                                   
08037598 D108     bne     @@downsideclip    ;正常情况就没发现过不成立过...                          
0803759A 1C21     mov     r1,r4                                   
0803759C 3124     add     r1,24h                                  
0803759E 201E     mov     r0,1Eh                                  
080375A0 7008     strb    r0,[r1]     	;pose写入1Eh                        
080375A2 E0A8     b       @@MainEnd                                

@@downsideclip:                              
080375AC 1F28     sub     r0,r5,4     	;Y坐标Up4h                            
080375AE 1C31     mov     r1,r6                                   
080375B0 F7D7FED6 bl      CheckSlope                            
080375B4 1C02     mov     r2,r0                                   
080375B6 4C23     ldr     r4,=30007F0h                            
080375B8 7821     ldrb    r1,[r4]                                 
080375BA 270F     mov     r7,0Fh                                  
080375BC 1C38     mov     r0,r7                                   
080375BE 4008     and     r0,r1                                   
080375C0 2801     cmp     r0,1h         ;在下斜坡的时候??                            
080375C2 D811     bhi     @@checkslope  ;在下upper斜坡的时候                          
080375C4 1C28     mov     r0,r5                                   
080375C6 1C31     mov     r1,r6                                   
080375C8 F7D7FECA bl      CheckSlope                                
080375CC 1C02     mov     r2,r0                                   
080375CE 7821     ldrb    r1,[r4]                                 
080375D0 1C38     mov     r0,r7                                   
080375D2 4008     and     r0,r1                                   
080375D4 2801     cmp     r0,1h         ;在上斜坡的时候??                        
080375D6 D807     bhi     @@checkslope  ;在横变upper斜转折的时候                         
080375D8 1D28     add     r0,r5,4                                 
080375DA 1C31     mov     r1,r6                                   
080375DC F7D7FEC0 bl      CheckSlope                                
080375E0 1C02     mov     r2,r0                                   
080375E2 7820     ldrb    r0,[r4]                                 
080375E4 2800     cmp     r0,0h                                   
080375E6 D003     beq     @@twist    ;在竖变横或横变竖转折的时候

@@checkslope:                              
080375E8 4917     ldr     r1,=3000738h                            
080375EA 1C10     mov     r0,r2                                   
080375EC 3818     sub     r0,18h                                  
080375EE 8048     strh    r0,[r1,2h]  ;判断Y坐标可能减4后再减

@@twist:                              
080375F0 4C15     ldr     r4,=3000738h                            
080375F2 8860     ldrh    r0,[r4,2h]                              
080375F4 3018     add     r0,18h      ;Y坐标如果在转折跳转则成了原值                            
080375F6 0400     lsl     r0,r0,10h   ;此段程序仅仅是为了让Y坐标Up18h?                            
080375F8 0C05     lsr     r5,r0,10h   ;当然未写入                            
080375FA 4812     ldr     r0,=30007F0h                            
080375FC 7801     ldrb    r1,[r0]                                 
080375FE 2900     cmp     r1,0h                                   
08037600 D003     beq     @@twist2    ;非斜坡也非平面上就会跳转??                          
08037602 20F0     mov     r0,0F0h                                 
08037604 4008     and     r0,r1       ;F0 and                            
08037606 2800     cmp     r0,0h                                   
08037608 D068     beq     @@NoSquare    ;是斜坡非平面上就会跳转??

@@twist2:                       ;平面下?  
0803760A 8821     ldrh    r1,[r4]                                 
0803760C 2080     mov     r0,80h                                  
0803760E 0080     lsl     r0,r0,2h                                
08037610 4680     mov     r8,r0                                   
08037612 4008     and     r0,r1     ;200 and 取向                             
08037614 2800     cmp     r0,0h     ;上和向上为0?                              
08037616 D030     beq     @@UP                               
08037618 1C31     mov     r1,r6                                   
0803761A 3918     sub     r1,18h    ;X坐标Left18h的值                             
0803761C 1C28     mov     r0,r5                                   
0803761E F7D8F833 bl      CheckBlock                                
08037622 4F0A     ldr     r7,=30007F1h                            
08037624 7838     ldrb    r0,[r7]                                 
08037626 2800     cmp     r0,0h                                   
08037628 D115     bne     @@LeftClip ;判断左边有砖块?                            
0803762A 1C31     mov     r1,r6                                   
0803762C 3118     add     r1,18h                                  
0803762E 1C28     mov     r0,r5                                   
08037630 F7D8F82A bl      CheckBlock                                
08037634 7838     ldrb    r0,[r7]                                 
08037636 2800     cmp     r0,0h                                   
08037638 D10A     bne     @@RightClip    ;判断右边有砖块                             
0803763A 8821     ldrh    r1,[r4]                                 
0803763C 4640     mov     r0,r8                                   
0803763E 4308     orr     r0,r1                                   
08037640 E043     b       80376CAh                                
  
@@RightClip:  
08037650 88A0     ldrh    r0,[r4,4h]                              
08037652 4448     add     r0,r9                                   
08037654 E04E     b       @@WriteX  

@@LeftClip:                  ;左边有砖                              
08037656 1F28     sub     r0,r5,4                                 
08037658 1C31     mov     r1,r6                                   
0803765A 3118     add     r1,18h                                  
0803765C F7D8F814 bl      CheckBlock                                
08037660 7838     ldrb    r0,[r7]                                 
08037662 2811     cmp     r0,11h                                  
08037664 D106     bne     @@norightmax   ;未贴合右砖跳转                             
08037666 8821     ldrh    r1,[r4]                                 
08037668 4801     ldr     r0,=0FDFFh                              
0803766A 4008     and     r0,r1      ;200变0,  一般右下移为2,左上为0                          
0803766C E019     b       @@upmove                                

@@norightmax:                               
08037674 88A0     ldrh    r0,[r4,4h]                              
08037676 4448     add     r0,r9                                   
08037678 E03C     b       @@WriteX

@@UP:                                
0803767A 1C31     mov     r1,r6                                   
0803767C 3114     add     r1,14h                                  
0803767E 1C28     mov     r0,r5                                   
08037680 F7D8F802 bl      CheckBlock                                
08037684 4F0A     ldr     r7,=30007F1h                            
08037686 7838     ldrb    r0,[r7]                                 
08037688 2800     cmp     r0,0h                                   
0803768A D113     bne     80376B4h     ;未在转折结束完全接壤墙面都不为0                                
0803768C 1C31     mov     r1,r6                                   
0803768E 391C     sub     r1,1Ch                                  
08037690 1C28     mov     r0,r5                                   
08037692 F7D7FFF9 bl      CheckBlock                                
08037696 7838     ldrb    r0,[r7]                                 
08037698 2800     cmp     r0,0h                                   
0803769A D128     bne     80376EEh                                
0803769C 8821     ldrh    r1,[r4]                                 
0803769E 4640     mov     r0,r8                                   
080376A0 4308     orr     r0,r1       ;200 orr

@@upmove:                                
080376A2 8020     strh    r0,[r4]                                 
080376A4 1C21     mov     r1,r4                                   
080376A6 3124     add     r1,24h                                  
080376A8 2027     mov     r0,27h   ;pose写入27h                               
080376AA 7008     strb    r0,[r1]                                 
080376AC E023     b       80376F6h                                
080376AE 0000     lsl     r0,r0,0h                                
080376B0 07F1     lsl     r1,r6,1Fh                               
080376B2 0300     lsl     r0,r0,0Ch 

                              
080376B4 1F28     sub     r0,r5,4                                 
080376B6 1C31     mov     r1,r6                                   
080376B8 391C     sub     r1,1Ch                                  
080376BA F7D7FFE5 bl      CheckBlock                                
080376BE 7838     ldrb    r0,[r7]                                 
080376C0 2811     cmp     r0,11h                                  
080376C2 D114     bne     80376EEh 

                               
080376C4 8821     ldrh    r1,[r4]                                 
080376C6 4804     ldr     r0,=0FDFFh                              
080376C8 4008     and     r0,r1    

                               
080376CA 8020     strh    r0,[r4]                                 
080376CC 1C21     mov     r1,r4                                   
080376CE 3124     add     r1,24h                                  
080376D0 2025     mov     r0,25h                                  
080376D2 7008     strb    r0,[r1]                                 
080376D4 E00F     b       80376F6h                                
.pool

@@NoSquare:                               
080376DC 8821     ldrh    r1,[r4]                                 
080376DE 2080     mov     r0,80h                                  
080376E0 0080     lsl     r0,r0,2h                                
080376E2 4008     and     r0,r1                                   
080376E4 2800     cmp     r0,0h                                   
080376E6 D002     beq     80376EEh                                
080376E8 88A0     ldrh    r0,[r4,4h]                              
080376EA 4448     add     r0,r9                                   
080376EC E002     b       @@WriteX  

                              
080376EE 88A0     ldrh    r0,[r4,4h]                              
080376F0 4649     mov     r1,r9                                   
080376F2 1A40     sub     r0,r0,r1  

;写入水平速度 
@@WriteX:                             
080376F4 80A0     strh    r0,[r4,4h] 
@@MainEndh2:                             
080376F6 BC18     pop     r3,r4                                   
080376F8 4698     mov     r8,r3                                   
080376FA 46A1     mov     r9,r4                                   
080376FC BCF0     pop     r4-r7                                   
080376FE BC01     pop     r0                                      
08037700 4700     bx      r0                                      
.pool

                             
08037704 B5F0     push    r4-r7,r14                               
08037706 464F     mov     r7,r9                                   
08037708 4646     mov     r6,r8                                   
0803770A B4C0     push    r6,r7                                   
0803770C 4E12     ldr     r6,=3000738h                            
0803770E 8871     ldrh    r1,[r6,2h]                              
08037710 4812     ldr     r0,=0FFC0h                              
08037712 4008     and     r0,r1                                   
08037714 1C01     mov     r1,r0                                   
08037716 3118     add     r1,18h                                  
08037718 8071     strh    r1,[r6,2h]                              
0803771A 1C31     mov     r1,r6                                   
0803771C 312E     add     r1,2Eh                                  
0803771E 7809     ldrb    r1,[r1]                                 
08037720 4688     mov     r8,r1                                   
08037722 3804     sub     r0,4h                                   
08037724 0400     lsl     r0,r0,10h                               
08037726 0C05     lsr     r5,r0,10h                               
08037728 88B4     ldrh    r4,[r6,4h]                              
0803772A 1C21     mov     r1,r4                                   
0803772C 311C     add     r1,1Ch                                  
0803772E 1C28     mov     r0,r5                                   
08037730 F7D7FFAA bl      CheckBlock                                
08037734 4F0A     ldr     r7,=30007F1h                            
08037736 7838     ldrb    r0,[r7]                                 
08037738 2800     cmp     r0,0h                                   
0803773A D113     bne     8037764h                                
0803773C 1C21     mov     r1,r4                                   
0803773E 3920     sub     r1,20h                                  
08037740 1C28     mov     r0,r5                                   
08037742 F7D7FFA1 bl      CheckBlock                                
08037746 7838     ldrb    r0,[r7]                                 
08037748 2800     cmp     r0,0h                                   
0803774A D10B     bne     8037764h                                
0803774C 1C31     mov     r1,r6                                   
0803774E 3124     add     r1,24h                                  
08037750 201E     mov     r0,1Eh                                  
08037752 7008     strb    r0,[r1]                                 
08037754 E073     b       803783Eh                                
08037756 0000     lsl     r0,r0,0h                                
08037758 0738     lsl     r0,r7,1Ch                               
0803775A 0300     lsl     r0,r0,0Ch                               
0803775C FFC0     bl      lr+0F80h                                
0803775E 0000     lsl     r0,r0,0h                                
08037760 07F1     lsl     r1,r6,1Fh                               
08037762 0300     lsl     r0,r0,0Ch                               
08037764 4E0F     ldr     r6,=3000738h                            
08037766 8831     ldrh    r1,[r6]                                 
08037768 2080     mov     r0,80h                                  
0803776A 0080     lsl     r0,r0,2h                                
0803776C 4681     mov     r9,r0                                   
0803776E 4008     and     r0,r1                                   
08037770 2800     cmp     r0,0h                                   
08037772 D02F     beq     80377D4h                                
08037774 1C21     mov     r1,r4                                   
08037776 3918     sub     r1,18h                                  
08037778 1C28     mov     r0,r5                                   
0803777A F7D7FF85 bl      CheckBlock                                
0803777E 4F0A     ldr     r7,=30007F1h                            
08037780 7839     ldrb    r1,[r7]                                 
08037782 200F     mov     r0,0Fh                                  
08037784 4008     and     r0,r1                                   
08037786 2800     cmp     r0,0h                                   
08037788 D115     bne     80377B6h                                
0803778A 1C21     mov     r1,r4                                   
0803778C 3118     add     r1,18h                                  
0803778E 1C28     mov     r0,r5                                   
08037790 F7D7FF7A bl      CheckBlock                                
08037794 7838     ldrb    r0,[r7]                                 
08037796 2800     cmp     r0,0h                                   
08037798 D10A     bne     80377B0h                                
0803779A 8831     ldrh    r1,[r6]                                 
0803779C 4803     ldr     r0,=0FDFFh                              
0803779E 4008     and     r0,r1                                   
080377A0 E043     b       803782Ah                                
080377A2 0000     lsl     r0,r0,0h                                
080377A4 0738     lsl     r0,r7,1Ch                               
080377A6 0300     lsl     r0,r0,0Ch                               
080377A8 07F1     lsl     r1,r6,1Fh                               
080377AA 0300     lsl     r0,r0,0Ch                               
080377AC FDFF     bl      lr+0BFEh                                
080377AE 0000     lsl     r0,r0,0h                                
080377B0 88B0     ldrh    r0,[r6,4h]                              
080377B2 4440     add     r0,r8                                   
080377B4 E042     b       803783Ch                                
080377B6 1D28     add     r0,r5,4                                 
080377B8 1C21     mov     r1,r4                                   
080377BA 3118     add     r1,18h                                  
080377BC F7D7FF64 bl      CheckBlock                                
080377C0 7838     ldrb    r0,[r7]                                 
080377C2 2811     cmp     r0,11h                                  
080377C4 D103     bne     80377CEh                                
080377C6 8831     ldrh    r1,[r6]                                 
080377C8 4648     mov     r0,r9                                   
080377CA 4308     orr     r0,r1                                   
080377CC E018     b       8037800h                                
080377CE 88B0     ldrh    r0,[r6,4h]                              
080377D0 4440     add     r0,r8                                   
080377D2 E033     b       803783Ch                                
080377D4 1C21     mov     r1,r4                                   
080377D6 3114     add     r1,14h                                  
080377D8 1C28     mov     r0,r5                                   
080377DA F7D7FF55 bl      CheckBlock                                
080377DE 4F0B     ldr     r7,=30007F1h                            
080377E0 7839     ldrb    r1,[r7]                                 
080377E2 200F     mov     r0,0Fh                                  
080377E4 4008     and     r0,r1                                   
080377E6 2800     cmp     r0,0h                                   
080377E8 D114     bne     8037814h                                
080377EA 1C21     mov     r1,r4                                   
080377EC 391C     sub     r1,1Ch                                  
080377EE 1C28     mov     r0,r5                                   
080377F0 F7D7FF4A bl      CheckBlock                                
080377F4 7838     ldrb    r0,[r7]                                 
080377F6 2800     cmp     r0,0h                                   
080377F8 D11D     bne     8037836h                                
080377FA 8831     ldrh    r1,[r6]                                 
080377FC 4804     ldr     r0,=0FDFFh                              
080377FE 4008     and     r0,r1                                   
08037800 8030     strh    r0,[r6]                                 
08037802 1C31     mov     r1,r6                                   
08037804 3124     add     r1,24h                                  
08037806 2027     mov     r0,27h                                  
08037808 7008     strb    r0,[r1]                                 
0803780A E018     b       803783Eh                                
0803780C 07F1     lsl     r1,r6,1Fh                               
0803780E 0300     lsl     r0,r0,0Ch                               
08037810 FDFF     bl      lr+0BFEh                                
08037812 0000     lsl     r0,r0,0h                                
08037814 1D28     add     r0,r5,4                                 
08037816 1C21     mov     r1,r4                                   
08037818 391C     sub     r1,1Ch                                  
0803781A F7D7FF35 bl      CheckBlock                                
0803781E 7838     ldrb    r0,[r7]                                 
08037820 2811     cmp     r0,11h                                  
08037822 D108     bne     8037836h                                
08037824 8831     ldrh    r1,[r6]                                 
08037826 4648     mov     r0,r9                                   
08037828 4308     orr     r0,r1                                   
0803782A 8030     strh    r0,[r6]                                 
0803782C 1C31     mov     r1,r6                                   
0803782E 3124     add     r1,24h                                  
08037830 2025     mov     r0,25h                                  
08037832 7008     strb    r0,[r1]                                 
08037834 E003     b       803783Eh                                
08037836 88B0     ldrh    r0,[r6,4h]                              
08037838 4641     mov     r1,r8                                   
0803783A 1A40     sub     r0,r0,r1                                
0803783C 80B0     strh    r0,[r6,4h]                              
0803783E BC18     pop     r3,r4                                   
08037840 4698     mov     r8,r3                                   
08037842 46A1     mov     r9,r4                                   
08037844 BCF0     pop     r4-r7                                   
08037846 BC01     pop     r0                                      
08037848 4700     bx      r0                                      
0803784A 0000     lsl     r0,r0,0h                                
0803784C B5F0     push    r4-r7,r14                               
0803784E 464F     mov     r7,r9                                   
08037850 4646     mov     r6,r8                                   
08037852 B4C0     push    r6,r7                                   
08037854 4E12     ldr     r6,=3000738h                            
08037856 88B1     ldrh    r1,[r6,4h]                              
08037858 4812     ldr     r0,=0FFC0h                              
0803785A 4008     and     r0,r1                                   
0803785C 1C01     mov     r1,r0                                   
0803785E 3118     add     r1,18h                                  
08037860 80B1     strh    r1,[r6,4h]                              
08037862 1C31     mov     r1,r6                                   
08037864 312E     add     r1,2Eh                                  
08037866 7809     ldrb    r1,[r1]                                 
08037868 4688     mov     r8,r1                                   
0803786A 8874     ldrh    r4,[r6,2h]                              
0803786C 3804     sub     r0,4h                                   
0803786E 0400     lsl     r0,r0,10h                               
08037870 0C05     lsr     r5,r0,10h                               
08037872 1C20     mov     r0,r4                                   
08037874 301C     add     r0,1Ch                                  
08037876 1C29     mov     r1,r5                                   
08037878 F7D7FF06 bl      CheckBlock                                
0803787C 4F0A     ldr     r7,=30007F1h                            
0803787E 7838     ldrb    r0,[r7]                                 
08037880 2800     cmp     r0,0h                                   
08037882 D113     bne     80378ACh                                
08037884 1C20     mov     r0,r4                                   
08037886 3820     sub     r0,20h                                  
08037888 1C29     mov     r1,r5                                   
0803788A F7D7FEFD bl      CheckBlock                                
0803788E 7838     ldrb    r0,[r7]                                 
08037890 2800     cmp     r0,0h                                   
08037892 D10B     bne     80378ACh                                
08037894 1C31     mov     r1,r6                                   
08037896 3124     add     r1,24h                                  
08037898 201E     mov     r0,1Eh                                  
0803789A 7008     strb    r0,[r1]                                 
0803789C E073     b       8037986h                                
0803789E 0000     lsl     r0,r0,0h                                
080378A0 0738     lsl     r0,r7,1Ch                               
080378A2 0300     lsl     r0,r0,0Ch                               
080378A4 FFC0     bl      lr+0F80h                                
080378A6 0000     lsl     r0,r0,0h                                
080378A8 07F1     lsl     r1,r6,1Fh                               
080378AA 0300     lsl     r0,r0,0Ch                               
080378AC 4E0F     ldr     r6,=3000738h                            
080378AE 8831     ldrh    r1,[r6]                                 
080378B0 2080     mov     r0,80h                                  
080378B2 0080     lsl     r0,r0,2h                                
080378B4 4681     mov     r9,r0                                   
080378B6 4008     and     r0,r1                                   
080378B8 2800     cmp     r0,0h                                   
080378BA D02F     beq     803791Ch                                
080378BC 1C20     mov     r0,r4                                   
080378BE 3818     sub     r0,18h                                  
080378C0 1C29     mov     r1,r5                                   
080378C2 F7D7FEE1 bl      CheckBlock                                
080378C6 4F0A     ldr     r7,=30007F1h                            
080378C8 7839     ldrb    r1,[r7]                                 
080378CA 20F0     mov     r0,0F0h                                 
080378CC 4008     and     r0,r1                                   
080378CE 2800     cmp     r0,0h                                   
080378D0 D115     bne     80378FEh                                
080378D2 1C20     mov     r0,r4                                   
080378D4 3018     add     r0,18h                                  
080378D6 1C29     mov     r1,r5                                   
080378D8 F7D7FED6 bl      CheckBlock                                
080378DC 7838     ldrb    r0,[r7]                                 
080378DE 2800     cmp     r0,0h                                   
080378E0 D10A     bne     80378F8h                                
080378E2 8831     ldrh    r1,[r6]                                 
080378E4 4803     ldr     r0,=0FDFFh                              
080378E6 4008     and     r0,r1                                   
080378E8 E043     b       8037972h                                
080378EA 0000     lsl     r0,r0,0h                                
080378EC 0738     lsl     r0,r7,1Ch                               
080378EE 0300     lsl     r0,r0,0Ch                               
080378F0 07F1     lsl     r1,r6,1Fh                               
080378F2 0300     lsl     r0,r0,0Ch                               
080378F4 FDFF     bl      lr+0BFEh                                
080378F6 0000     lsl     r0,r0,0h                                
080378F8 8870     ldrh    r0,[r6,2h]                              
080378FA 4440     add     r0,r8                                   
080378FC E042     b       8037984h                                
080378FE 1C20     mov     r0,r4                                   
08037900 3018     add     r0,18h                                  
08037902 1D29     add     r1,r5,4                                 
08037904 F7D7FEC0 bl      CheckBlock                                
08037908 7838     ldrb    r0,[r7]                                 
0803790A 2811     cmp     r0,11h                                  
0803790C D103     bne     8037916h                                
0803790E 8831     ldrh    r1,[r6]                                 
08037910 4648     mov     r0,r9                                   
08037912 4308     orr     r0,r1                                   
08037914 E018     b       8037948h                                
08037916 8870     ldrh    r0,[r6,2h]                              
08037918 4440     add     r0,r8                                   
0803791A E033     b       8037984h                                
0803791C 1C20     mov     r0,r4                                   
0803791E 3014     add     r0,14h                                  
08037920 1C29     mov     r1,r5                                   
08037922 F7D7FEB1 bl      CheckBlock                                
08037926 4F0B     ldr     r7,=30007F1h                            
08037928 7839     ldrb    r1,[r7]                                 
0803792A 20F0     mov     r0,0F0h                                 
0803792C 4008     and     r0,r1                                   
0803792E 2800     cmp     r0,0h                                   
08037930 D114     bne     803795Ch                                
08037932 1C20     mov     r0,r4                                   
08037934 381C     sub     r0,1Ch                                  
08037936 1C29     mov     r1,r5                                   
08037938 F7D7FEA6 bl      CheckBlock                                
0803793C 7838     ldrb    r0,[r7]                                 
0803793E 2800     cmp     r0,0h                                   
08037940 D11D     bne     803797Eh                                
08037942 8831     ldrh    r1,[r6]                                 
08037944 4804     ldr     r0,=0FDFFh                              
08037946 4008     and     r0,r1                                   
08037948 8030     strh    r0,[r6]                                 
0803794A 1C31     mov     r1,r6                                   
0803794C 3124     add     r1,24h                                  
0803794E 2009     mov     r0,9h                                   
08037950 7008     strb    r0,[r1]                                 
08037952 E018     b       8037986h                                
08037954 07F1     lsl     r1,r6,1Fh                               
08037956 0300     lsl     r0,r0,0Ch                               
08037958 FDFF     bl      lr+0BFEh                                
0803795A 0000     lsl     r0,r0,0h                                
0803795C 1C20     mov     r0,r4                                   
0803795E 381C     sub     r0,1Ch                                  
08037960 1D29     add     r1,r5,4                                 
08037962 F7D7FE91 bl      CheckBlock                                
08037966 7838     ldrb    r0,[r7]                                 
08037968 2811     cmp     r0,11h                                  
0803796A D108     bne     803797Eh                                
0803796C 8831     ldrh    r1,[r6]                                 
0803796E 4648     mov     r0,r9                                   
08037970 4308     orr     r0,r1                                   
08037972 8030     strh    r0,[r6]                                 
08037974 1C31     mov     r1,r6                                   
08037976 3124     add     r1,24h                                  
08037978 2023     mov     r0,23h                                  
0803797A 7008     strb    r0,[r1]                                 
0803797C E003     b       8037986h                                
0803797E 8870     ldrh    r0,[r6,2h]                              
08037980 4641     mov     r1,r8                                   
08037982 1A40     sub     r0,r0,r1                                
08037984 8070     strh    r0,[r6,2h]                              
08037986 BC18     pop     r3,r4                                   
08037988 4698     mov     r8,r3                                   
0803798A 46A1     mov     r9,r4                                   
0803798C BCF0     pop     r4-r7                                   
0803798E BC01     pop     r0                                      
08037990 4700     bx      r0                                      
08037992 0000     lsl     r0,r0,0h                                
08037994 B5F0     push    r4-r7,r14                               
08037996 464F     mov     r7,r9                                   
08037998 4646     mov     r6,r8                                   
0803799A B4C0     push    r6,r7                                   
0803799C 4E12     ldr     r6,=3000738h                            
0803799E 88B1     ldrh    r1,[r6,4h]                              
080379A0 4812     ldr     r0,=0FFC0h                              
080379A2 4008     and     r0,r1                                   
080379A4 1C01     mov     r1,r0                                   
080379A6 3128     add     r1,28h                                  
080379A8 80B1     strh    r1,[r6,4h]                              
080379AA 1C31     mov     r1,r6                                   
080379AC 312E     add     r1,2Eh                                  
080379AE 7809     ldrb    r1,[r1]                                 
080379B0 4688     mov     r8,r1                                   
080379B2 8874     ldrh    r4,[r6,2h]                              
080379B4 3040     add     r0,40h                                  
080379B6 0400     lsl     r0,r0,10h                               
080379B8 0C05     lsr     r5,r0,10h                               
080379BA 1C20     mov     r0,r4                                   
080379BC 301C     add     r0,1Ch                                  
080379BE 1C29     mov     r1,r5                                   
080379C0 F7D7FE62 bl      CheckBlock                                
080379C4 4F0A     ldr     r7,=30007F1h                            
080379C6 7838     ldrb    r0,[r7]                                 
080379C8 2800     cmp     r0,0h                                   
080379CA D113     bne     80379F4h                                
080379CC 1C20     mov     r0,r4                                   
080379CE 3820     sub     r0,20h                                  
080379D0 1C29     mov     r1,r5                                   
080379D2 F7D7FE59 bl      CheckBlock                                
080379D6 7838     ldrb    r0,[r7]                                 
080379D8 2800     cmp     r0,0h                                   
080379DA D10B     bne     80379F4h                                
080379DC 1C31     mov     r1,r6                                   
080379DE 3124     add     r1,24h                                  
080379E0 201E     mov     r0,1Eh                                  
080379E2 7008     strb    r0,[r1]                                 
080379E4 E076     b       8037AD4h                                
080379E6 0000     lsl     r0,r0,0h                                
080379E8 0738     lsl     r0,r7,1Ch                               
080379EA 0300     lsl     r0,r0,0Ch                               
080379EC FFC0     bl      lr+0F80h                                
080379EE 0000     lsl     r0,r0,0h                                
080379F0 07F1     lsl     r1,r6,1Fh                               
080379F2 0300     lsl     r0,r0,0Ch                               
080379F4 4E0F     ldr     r6,=3000738h                            
080379F6 8831     ldrh    r1,[r6]                                 
080379F8 2080     mov     r0,80h                                  
080379FA 0080     lsl     r0,r0,2h                                
080379FC 4681     mov     r9,r0                                   
080379FE 4008     and     r0,r1                                   
08037A00 2800     cmp     r0,0h                                   
08037A02 D030     beq     8037A66h                                
08037A04 1C20     mov     r0,r4                                   
08037A06 3818     sub     r0,18h                                  
08037A08 1C29     mov     r1,r5                                   
08037A0A F7D7FE3D bl      CheckBlock                                
08037A0E 4F0A     ldr     r7,=30007F1h                            
08037A10 7839     ldrb    r1,[r7]                                 
08037A12 20F0     mov     r0,0F0h                                 
08037A14 4008     and     r0,r1                                   
08037A16 2800     cmp     r0,0h                                   
08037A18 D113     bne     8037A42h                                
08037A1A 1C20     mov     r0,r4                                   
08037A1C 3018     add     r0,18h                                  
08037A1E 1C29     mov     r1,r5                                   
08037A20 F7D7FE32 bl      CheckBlock                                
08037A24 7838     ldrb    r0,[r7]                                 
08037A26 2800     cmp     r0,0h                                   
08037A28 D108     bne     8037A3Ch                                
08037A2A 8831     ldrh    r1,[r6]                                 
08037A2C 4648     mov     r0,r9                                   
08037A2E 4308     orr     r0,r1                                   
08037A30 E043     b       8037ABAh                                
08037A32 0000     lsl     r0,r0,0h                                
08037A34 0738     lsl     r0,r7,1Ch                               
08037A36 0300     lsl     r0,r0,0Ch                               
08037A38 07F1     lsl     r1,r6,1Fh                               
08037A3A 0300     lsl     r0,r0,0Ch                               
08037A3C 8870     ldrh    r0,[r6,2h]                              
08037A3E 4440     add     r0,r8                                   
08037A40 E047     b       8037AD2h                                
08037A42 1C20     mov     r0,r4                                   
08037A44 3018     add     r0,18h                                  
08037A46 1F29     sub     r1,r5,4                                 
08037A48 F7D7FE1E bl      CheckBlock                                
08037A4C 7838     ldrb    r0,[r7]                                 
08037A4E 2811     cmp     r0,11h                                  
08037A50 D106     bne     8037A60h                                
08037A52 8831     ldrh    r1,[r6]                                 
08037A54 4801     ldr     r0,=0FDFFh                              
08037A56 4008     and     r0,r1                                   
08037A58 E01B     b       8037A92h                                
08037A5A 0000     lsl     r0,r0,0h                                
08037A5C FDFF     bl      lr+0BFEh                                
08037A5E 0000     lsl     r0,r0,0h                                
08037A60 8870     ldrh    r0,[r6,2h]                              
08037A62 4440     add     r0,r8                                   
08037A64 E035     b       8037AD2h                                
08037A66 1C20     mov     r0,r4                                   
08037A68 3014     add     r0,14h                                  
08037A6A 1C29     mov     r1,r5                                   
08037A6C F7D7FE0C bl      CheckBlock                                
08037A70 4F0B     ldr     r7,=30007F1h                            
08037A72 7839     ldrb    r1,[r7]                                 
08037A74 20F0     mov     r0,0F0h                                 
08037A76 4008     and     r0,r1                                   
08037A78 2800     cmp     r0,0h                                   
08037A7A D113     bne     8037AA4h                                
08037A7C 1C20     mov     r0,r4                                   
08037A7E 381C     sub     r0,1Ch                                  
08037A80 1C29     mov     r1,r5                                   
08037A82 F7D7FE01 bl      CheckBlock                                
08037A86 7838     ldrb    r0,[r7]                                 
08037A88 2800     cmp     r0,0h                                   
08037A8A D11F     bne     8037ACCh                                
08037A8C 8831     ldrh    r1,[r6]                                 
08037A8E 4648     mov     r0,r9                                   
08037A90 4308     orr     r0,r1                                   
08037A92 8030     strh    r0,[r6]                                 
08037A94 1C31     mov     r1,r6                                   
08037A96 3124     add     r1,24h                                  
08037A98 2009     mov     r0,9h                                   
08037A9A 7008     strb    r0,[r1]                                 
08037A9C E01A     b       8037AD4h                                
08037A9E 0000     lsl     r0,r0,0h                                
08037AA0 07F1     lsl     r1,r6,1Fh                               
08037AA2 0300     lsl     r0,r0,0Ch                               
08037AA4 1C20     mov     r0,r4                                   
08037AA6 381C     sub     r0,1Ch                                  
08037AA8 1F29     sub     r1,r5,4                                 
08037AAA F7D7FDED bl      CheckBlock                                
08037AAE 7838     ldrb    r0,[r7]                                 
08037AB0 2811     cmp     r0,11h                                  
08037AB2 D10B     bne     8037ACCh                                
08037AB4 8831     ldrh    r1,[r6]                                 
08037AB6 4804     ldr     r0,=0FDFFh                              
08037AB8 4008     and     r0,r1                                   
08037ABA 8030     strh    r0,[r6]                                 
08037ABC 1C31     mov     r1,r6                                   
08037ABE 3124     add     r1,24h                                  
08037AC0 2023     mov     r0,23h                                  
08037AC2 7008     strb    r0,[r1]                                 
08037AC4 E006     b       8037AD4h                                
08037AC6 0000     lsl     r0,r0,0h                                
08037AC8 FDFF     bl      lr+0BFEh                                
08037ACA 0000     lsl     r0,r0,0h                                
08037ACC 8870     ldrh    r0,[r6,2h]                              
08037ACE 4641     mov     r1,r8                                   
08037AD0 1A40     sub     r0,r0,r1                                
08037AD2 8070     strh    r0,[r6,2h]                              
08037AD4 BC18     pop     r3,r4                                   
08037AD6 4698     mov     r8,r3                                   
08037AD8 46A1     mov     r9,r4                                   
08037ADA BCF0     pop     r4-r7                                   
08037ADC BC01     pop     r0                                      
08037ADE 4700     bx      r0                                      
08037AE0 4904     ldr     r1,=3000738h                            
08037AE2 1C0A     mov     r2,r1                                   
08037AE4 3224     add     r2,24h                                  
08037AE6 2300     mov     r3,0h                                   
08037AE8 201F     mov     r0,1Fh                                  
08037AEA 7010     strb    r0,[r2]                                 
08037AEC 312F     add     r1,2Fh                                  
08037AEE 700B     strb    r3,[r1]                                 
08037AF0 4770     bx      r14                                     
08037AF2 0000     lsl     r0,r0,0h                                
08037AF4 0738     lsl     r0,r7,1Ch                               
08037AF6 0300     lsl     r0,r0,0Ch                               
08037AF8 B530     push    r4,r5,r14                               
08037AFA 4C0A     ldr     r4,=3000738h                            
08037AFC 8860     ldrh    r0,[r4,2h]                              
08037AFE 3018     add     r0,18h                                  
08037B00 88A1     ldrh    r1,[r4,4h]                              
08037B02 F7D7FCBB bl      800F47Ch                                
08037B06 1C01     mov     r1,r0                                   
08037B08 4807     ldr     r0,=30007F0h                            
08037B0A 7800     ldrb    r0,[r0]                                 
08037B0C 2800     cmp     r0,0h                                   
08037B0E D00D     beq     8037B2Ch                                
08037B10 1C08     mov     r0,r1                                   
08037B12 3818     sub     r0,18h                                  
08037B14 8060     strh    r0,[r4,2h]                              
08037B16 1C21     mov     r1,r4                                   
08037B18 3124     add     r1,24h                                  
08037B1A 2009     mov     r0,9h                                   
08037B1C 7008     strb    r0,[r1]                                 
08037B1E F7D7FE91 bl      800F844h                                
08037B22 E021     b       8037B68h                                
08037B24 0738     lsl     r0,r7,1Ch                               
08037B26 0300     lsl     r0,r0,0Ch                               
08037B28 07F0     lsl     r0,r6,1Fh                               
08037B2A 0300     lsl     r0,r0,0Ch                               
08037B2C 202F     mov     r0,2Fh                                  
08037B2E 1900     add     r0,r0,r4                                
08037B30 4684     mov     r12,r0                                  
08037B32 7801     ldrb    r1,[r0]                                 
08037B34 4B07     ldr     r3,=82B0D04h                            
08037B36 0048     lsl     r0,r1,1h                                
08037B38 18C0     add     r0,r0,r3                                
08037B3A 2500     mov     r5,0h                                   
08037B3C 5F42     ldsh    r2,[r0,r5]                              
08037B3E 4806     ldr     r0,=7FFFh                               
08037B40 4282     cmp     r2,r0                                   
08037B42 D10B     bne     8037B5Ch                                
08037B44 1E48     sub     r0,r1,1                                 
08037B46 0040     lsl     r0,r0,1h                                
08037B48 18C0     add     r0,r0,r3                                
08037B4A 2100     mov     r1,0h                                   
08037B4C 5E40     ldsh    r0,[r0,r1]                              
08037B4E 8865     ldrh    r5,[r4,2h]                              
08037B50 1940     add     r0,r0,r5                                
08037B52 E008     b       8037B66h                                
08037B54 0D04     lsr     r4,r0,14h                               
08037B56 082B     lsr     r3,r5,20h                               
08037B58 7FFF     ldrb    r7,[r7,1Fh]                             
08037B5A 0000     lsl     r0,r0,0h                                
08037B5C 1C48     add     r0,r1,1                                 
08037B5E 4661     mov     r1,r12                                  
08037B60 7008     strb    r0,[r1]                                 
08037B62 8860     ldrh    r0,[r4,2h]                              
08037B64 1880     add     r0,r0,r2                                
08037B66 8060     strh    r0,[r4,2h]                              
08037B68 BC30     pop     r4,r5                                   
08037B6A BC01     pop     r0                                      
08037B6C 4700     bx      r0                                      
08037B6E 0000     lsl     r0,r0,0h                                





//////////////////////////////////////////////////////////////////////////////////////
;主程序
08037B70 B510     push    r4,r14                                  
08037B72 B081     add     sp,-4h                                  
08037B74 490E     ldr     r1,=3000738h                            
08037B76 1C0B     mov     r3,r1                                   
08037B78 3332     add     r3,32h                                  
08037B7A 781A     ldrb    r2,[r3]    ;得到300076a的值                             
08037B7C 2402     mov     r4,2h                                   
08037B7E 1C20     mov     r0,r4                                   
08037B80 4010     and     r0,r2      ;2 and                              
08037B82 2800     cmp     r0,0h                                   
08037B84 D00B     beq     8037B9Eh   ;也就是没有                        
08037B86 20FD     mov     r0,0FDh                                 
08037B88 4010     and     r0,r2      ;与FDh and 然后写入                             
08037B8A 7018     strb    r0,[r3]                                 
08037B8C 8809     ldrh    r1,[r1]                                 
08037B8E 1C20     mov     r0,r4                                   
08037B90 4008     and     r0,r1      ;2 and 3000738                             
08037B92 2800     cmp     r0,0h                                   
08037B94 D003     beq     8037B9Eh                                
08037B96 20BC     mov     r0,0BCh                                 
08037B98 0040     lsl     r0,r0,1h                                
08037B9A F7CAFFC1 bl      8002B20h   ;播放音乐178h

;2 and 300076a=0  或 2 and 3000738=0                           
08037B9E 4C04     ldr     r4,=3000738h                            
08037BA0 1C20     mov     r0,r4                                   
08037BA2 3030     add     r0,30h                                  
08037BA4 7800     ldrb    r0,[r0]                                 
08037BA6 2800     cmp     r0,0h       ;3000768为0跳转                            
08037BA8 D004     beq     8037BB4h                                
08037BAA F7D8FA1D bl      FrozenRoutine      ;冰冻例程                       
08037BAE E07E     b       @@MainEndh                                
                              
08037BB4 F7D9FB64 bl      StunSprite  ;击晕敌人例程                                
08037BB8 2800     cmp     r0,0h                                   
08037BBA D178     bne     @@MainEndh                                
08037BBC 1C20     mov     r0,r4                                   
08037BBE 3024     add     r0,24h                                  
08037BC0 7800     ldrb    r0,[r0]                                 
08037BC2 2827     cmp     r0,27h                                  
08037BC4 D86A     bhi     8037C9Ch    ;pose如果大于27跳转                            
08037BC6 0080     lsl     r0,r0,2h                                
08037BC8 4901     ldr     r1,=PoseTable                            
08037BCA 1840     add     r0,r0,r1                                
08037BCC 6800     ldr     r0,[r0]                                 
08037BCE 4687     mov     r15,r0  

PoseTable:
    .word 8037c74h  ;00
    .word 8037c9ch .word 8037c9ch .word 8037c9ch .word 8037c9ch
	.word 8037c9ch .word 8037c9ch .word 8037c9ch .word 8037c9ch
	.word 8037c7ah  ;09h
	.word 8037c9ch .word 8037c9ch .word 8037c9ch .word 8037c9ch
	.word 8037c9ch .word 8037c9ch .word 8037c9ch .word 8037c9ch
	.word 8037c9ch .word 8037c9ch .word 8037c9ch .word 8037c9ch
	.word 8037c9ch .word 8037c9ch .word 8037c9ch .word 8037c9ch
	.word 8037c9ch .word 8037c9ch .word 8037c9ch .word 8037c9ch
	.word 8037c92h ;1eh
	.word 8037c96h ;1fh
	.word 8037c9ch .word 8037c9ch .word 8037c9ch 
	.word 8037c80h ;23h
	.word 8037c9ch 
	.word 8037c86h ;25h
	.word 8037c9ch
	.word 8037c8ch ;27h
    	                      
08037C74 F7FFFBE2 bl      803743Ch    ;00                            
08037C78 E019     b       @@MainEndh                                
08037C7A F7FFFC6F bl      803755Ch    ;09h   地行                        
08037C7E E016     b       @@MainEndh                                
08037C80 F7FFFD40 bl      8037704h    ;23h   天花板行                         
08037C84 E013     b       @@MainEndh                                
08037C86 F7FFFDE1 bl      803784Ch    ;25h   左侧壁行                         
08037C8A E010     b       @@MainEndh                                
08037C8C F7FFFE82 bl      8037994h    ;27h   右侧壁行                         
08037C90 E00D     b       @@MainEndh                                
08037C92 F7FFFF25 bl      8037AE0h    ;1eh   坠落准备                         
08037C96 F7FFFF2F bl      8037AF8h    ;1fh   坠落                         
08037C9A E008     b       @@MainEndh 

;pose大于27                               
08037C9C 4806     ldr     r0,=3000738h                            
08037C9E 8841     ldrh    r1,[r0,2h]                              
08037CA0 8882     ldrh    r2,[r0,4h]                              
08037CA2 2020     mov     r0,20h                                  
08037CA4 9000     str     r0,[sp]                                 
08037CA6 2000     mov     r0,0h                                   
08037CA8 2301     mov     r3,1h                                   
08037CAA F7D9F9EB bl      DeathFireWorks  

@@MainEndh:                             
08037CAE B001     add     sp,4h                                   
08037CB0 BC10     pop     r4                                      
08037CB2 BC01     pop     r0                                      
08037CB4 4700     bx      r0 

                                     
08037CB6 0000     lsl     r0,r0,0h                                
08037CB8 0738     lsl     r0,r7,1Ch                               
08037CBA 0300     lsl     r0,r0,0Ch                               
08037CBC B5F0     push    r4-r7,r14                               
08037CBE 4C10     ldr     r4,=3000738h                            
08037CC0 8865     ldrh    r5,[r4,2h]                              
08037CC2 88A6     ldrh    r6,[r4,4h]                              
08037CC4 7F60     ldrb    r0,[r4,1Dh]                             
08037CC6 2898     cmp     r0,98h                                  
08037CC8 D001     beq     8037CCEh                                
08037CCA 289A     cmp     r0,9Ah                                  
08037CCC D16E     bne     8037DACh                                
08037CCE 8821     ldrh    r1,[r4]                                 
08037CD0 2280     mov     r2,80h                                  
08037CD2 00D2     lsl     r2,r2,3h                                
08037CD4 1C10     mov     r0,r2                                   
08037CD6 2700     mov     r7,0h                                   
08037CD8 4308     orr     r0,r1                                   
08037CDA 8020     strh    r0,[r4]                                 
08037CDC 1C28     mov     r0,r5                                   
08037CDE 38A0     sub     r0,0A0h                                 
08037CE0 1C31     mov     r1,r6                                   
08037CE2 F7D7FD1D bl      800F720h                                
08037CE6 2800     cmp     r0,0h                                   
08037CE8 D010     beq     8037D0Ch                                
08037CEA 4806     ldr     r0,=82F08D0h                            
08037CEC 61A0     str     r0,[r4,18h]                             
08037CEE 1C21     mov     r1,r4                                   
08037CF0 3127     add     r1,27h                                  
08037CF2 2020     mov     r0,20h                                  
08037CF4 7008     strb    r0,[r1]                                 
08037CF6 4804     ldr     r0,=0FF9Ch                              
08037CF8 8160     strh    r0,[r4,0Ah]                             
08037CFA 3106     add     r1,6h                                   
08037CFC 2082     mov     r0,82h                                  
08037CFE E03D     b       8037D7Ch                                
08037D00 0738     lsl     r0,r7,1Ch                               
08037D02 0300     lsl     r0,r0,0Ch                               
08037D04 08D0     lsr     r0,r2,3h                                
08037D06 082F     lsr     r7,r5,20h                               
08037D08 FF9C     bl      lr+0F38h                                
08037D0A 0000     lsl     r0,r0,0h                                
08037D0C 1C28     mov     r0,r5                                   
08037D0E 38E0     sub     r0,0E0h                                 
08037D10 1C31     mov     r1,r6                                   
08037D12 F7D7FD05 bl      800F720h                                
08037D16 2800     cmp     r0,0h                                   
08037D18 D00E     beq     8037D38h                                
08037D1A 4805     ldr     r0,=82F0928h                            
08037D1C 61A0     str     r0,[r4,18h]                             
08037D1E 1C21     mov     r1,r4                                   
08037D20 3127     add     r1,27h                                  
08037D22 2030     mov     r0,30h                                  
08037D24 7008     strb    r0,[r1]                                 
08037D26 4803     ldr     r0,=0FF5Ch                              
08037D28 8160     strh    r0,[r4,0Ah]                             
08037D2A 3106     add     r1,6h                                   
08037D2C 2083     mov     r0,83h                                  
08037D2E E025     b       8037D7Ch                                
08037D30 0928     lsr     r0,r5,4h                                
08037D32 082F     lsr     r7,r5,20h                               
08037D34 FF5C     bl      lr+0EB8h                                
08037D36 0000     lsl     r0,r0,0h                                
08037D38 4908     ldr     r1,=0FFFFFEE0h                          
08037D3A 1868     add     r0,r5,r1                                
08037D3C 1C31     mov     r1,r6                                   
08037D3E F7D7FCEF bl      800F720h                                
08037D42 2800     cmp     r0,0h                                   
08037D44 D010     beq     8037D68h                                
08037D46 4806     ldr     r0,=82F0980h                            
08037D48 61A0     str     r0,[r4,18h]                             
08037D4A 1C21     mov     r1,r4                                   
08037D4C 3127     add     r1,27h                                  
08037D4E 2040     mov     r0,40h                                  
08037D50 7008     strb    r0,[r1]                                 
08037D52 4804     ldr     r0,=0FF1Ch                              
08037D54 8160     strh    r0,[r4,0Ah]                             
08037D56 3106     add     r1,6h                                   
08037D58 2084     mov     r0,84h                                  
08037D5A E00F     b       8037D7Ch                                
08037D5C FEE0     bl      lr+0DC0h                                
08037D5E FFFF     bl      lr+0FFEh                                
08037D60 0980     lsr     r0,r0,6h                                
08037D62 082F     lsr     r7,r5,20h                               
08037D64 FF1C     bl      lr+0E38h                                
08037D66 0000     lsl     r0,r0,0h                                
08037D68 480C     ldr     r0,=82F09D8h                            
08037D6A 61A0     str     r0,[r4,18h]                             
08037D6C 1C21     mov     r1,r4                                   
08037D6E 3127     add     r1,27h                                  
08037D70 2050     mov     r0,50h                                  
08037D72 7008     strb    r0,[r1]                                 
08037D74 480A     ldr     r0,=0FEDCh                              
08037D76 8160     strh    r0,[r4,0Ah]                             
08037D78 3106     add     r1,6h                                   
08037D7A 2085     mov     r0,85h                                  
08037D7C 7008     strb    r0,[r1]                                 
08037D7E 4B09     ldr     r3,=3000738h                            
08037D80 1C18     mov     r0,r3                                   
08037D82 3028     add     r0,28h                                  
08037D84 2100     mov     r1,0h                                   
08037D86 7001     strb    r1,[r0]                                 
08037D88 3001     add     r0,1h                                   
08037D8A 2208     mov     r2,8h                                   
08037D8C 7002     strb    r2,[r0]                                 
08037D8E 8199     strh    r1,[r3,0Ch]                             
08037D90 4805     ldr     r0,=0FFF8h                              
08037D92 81D8     strh    r0,[r3,0Eh]                             
08037D94 821A     strh    r2,[r3,10h]                             
08037D96 1C1C     mov     r4,r3                                   
08037D98 E063     b       8037E62h                                
08037D9A 0000     lsl     r0,r0,0h                                
08037D9C 09D8     lsr     r0,r3,7h                                
08037D9E 082F     lsr     r7,r5,20h                               
08037DA0 FEDC     bl      lr+0DB8h                                
08037DA2 0000     lsl     r0,r0,0h                                
08037DA4 0738     lsl     r0,r7,1Ch                               
08037DA6 0300     lsl     r0,r0,0Ch                               
08037DA8 FFF8     bl      lr+0FF0h                                
08037DAA 0000     lsl     r0,r0,0h                                
08037DAC 3D20     sub     r5,20h                                  
08037DAE 1C31     mov     r1,r6                                   
08037DB0 3180     add     r1,80h                                  
08037DB2 1C28     mov     r0,r5                                   
08037DB4 F7D7FCB4 bl      800F720h                                
08037DB8 2800     cmp     r0,0h                                   
08037DBA D00D     beq     8037DD8h                                
08037DBC 4805     ldr     r0,=82F0A30h                            
08037DBE 61A0     str     r0,[r4,18h]                             
08037DC0 1C21     mov     r1,r4                                   
08037DC2 3129     add     r1,29h                                  
08037DC4 2018     mov     r0,18h                                  
08037DC6 7008     strb    r0,[r1]                                 
08037DC8 2044     mov     r0,44h                                  
08037DCA 8220     strh    r0,[r4,10h]                             
08037DCC 3104     add     r1,4h                                   
08037DCE 2002     mov     r0,2h                                   
08037DD0 E036     b       8037E40h                                
08037DD2 0000     lsl     r0,r0,0h                                
08037DD4 0A30     lsr     r0,r6,8h                                
08037DD6 082F     lsr     r7,r5,20h                               
08037DD8 1C31     mov     r1,r6                                   
08037DDA 31C0     add     r1,0C0h                                 
08037DDC 1C28     mov     r0,r5                                   
08037DDE F7D7FC9F bl      800F720h                                
08037DE2 2800     cmp     r0,0h                                   
08037DE4 D00C     beq     8037E00h                                
08037DE6 4805     ldr     r0,=82F0A88h                            
08037DE8 61A0     str     r0,[r4,18h]                             
08037DEA 1C21     mov     r1,r4                                   
08037DEC 3129     add     r1,29h                                  
08037DEE 2028     mov     r0,28h                                  
08037DF0 7008     strb    r0,[r1]                                 
08037DF2 2084     mov     r0,84h                                  
08037DF4 8220     strh    r0,[r4,10h]                             
08037DF6 3104     add     r1,4h                                   
08037DF8 2003     mov     r0,3h                                   
08037DFA E021     b       8037E40h                                
08037DFC 0A88     lsr     r0,r1,0Ah                               
08037DFE 082F     lsr     r7,r5,20h                               
08037E00 2280     mov     r2,80h                                  
08037E02 0052     lsl     r2,r2,1h                                
08037E04 18B1     add     r1,r6,r2                                
08037E06 1C28     mov     r0,r5                                   
08037E08 F7D7FC8A bl      800F720h                                
08037E0C 2800     cmp     r0,0h                                   
08037E0E D00D     beq     8037E2Ch                                
08037E10 4805     ldr     r0,=82F0AE0h                            
08037E12 61A0     str     r0,[r4,18h]                             
08037E14 1C21     mov     r1,r4                                   
08037E16 3129     add     r1,29h                                  
08037E18 2038     mov     r0,38h                                  
08037E1A 7008     strb    r0,[r1]                                 
08037E1C 20C4     mov     r0,0C4h                                 
08037E1E 8220     strh    r0,[r4,10h]                             
08037E20 3104     add     r1,4h                                   
08037E22 2004     mov     r0,4h                                   
08037E24 E00C     b       8037E40h                                
08037E26 0000     lsl     r0,r0,0h                                
08037E28 0AE0     lsr     r0,r4,0Bh                               
08037E2A 082F     lsr     r7,r5,20h                               
08037E2C 481E     ldr     r0,=82F0B38h                            
08037E2E 61A0     str     r0,[r4,18h]                             
08037E30 1C21     mov     r1,r4                                   
08037E32 3129     add     r1,29h                                  
08037E34 2048     mov     r0,48h                                  
08037E36 7008     strb    r0,[r1]                                 
08037E38 30BC     add     r0,0BCh                                 
08037E3A 8220     strh    r0,[r4,10h]                             
08037E3C 3104     add     r1,4h                                   
08037E3E 2005     mov     r0,5h                                   
08037E40 7008     strb    r0,[r1]                                 
08037E42 4A1A     ldr     r2,=3000738h                            
08037E44 1C13     mov     r3,r2                                   
08037E46 3327     add     r3,27h                                  
08037E48 2100     mov     r1,0h                                   
08037E4A 2010     mov     r0,10h                                  
08037E4C 7018     strb    r0,[r3]                                 
08037E4E 1C10     mov     r0,r2                                   
08037E50 3028     add     r0,28h                                  
08037E52 7001     strb    r1,[r0]                                 
08037E54 4816     ldr     r0,=0FFD8h                              
08037E56 8150     strh    r0,[r2,0Ah]                             
08037E58 3010     add     r0,10h                                  
08037E5A 8190     strh    r0,[r2,0Ch]                             
08037E5C 3014     add     r0,14h                                  
08037E5E 81D0     strh    r0,[r2,0Eh]                             
08037E60 1C14     mov     r4,r2                                   
08037E62 1C22     mov     r2,r4                                   
08037E64 3225     add     r2,25h                                  
08037E66 2100     mov     r1,0h                                   
08037E68 201E     mov     r0,1Eh                                  
08037E6A 7010     strb    r0,[r2]                                 
08037E6C 3A03     sub     r2,3h                                   
08037E6E 2002     mov     r0,2h                                   
08037E70 7010     strb    r0,[r2]                                 
08037E72 2500     mov     r5,0h                                   
08037E74 82E1     strh    r1,[r4,16h]                             
08037E76 7725     strb    r5,[r4,1Ch]                             
08037E78 490E     ldr     r1,=0C41h                               
08037E7A 2001     mov     r0,1h                                   
08037E7C F01DFDE0 bl      8055A40h                                
08037E80 480D     ldr     r0,=30001A8h                            
08037E82 8800     ldrh    r0,[r0]                                 
08037E84 2800     cmp     r0,0h                                   
08037E86 D019     beq     8037EBCh                                
08037E88 1C21     mov     r1,r4                                   
08037E8A 3124     add     r1,24h                                  
08037E8C 2023     mov     r0,23h                                  
08037E8E 7008     strb    r0,[r1]                                 
08037E90 8820     ldrh    r0,[r4]                                 
08037E92 2104     mov     r1,4h                                   
08037E94 4308     orr     r0,r1                                   
08037E96 8020     strh    r0,[r4]                                 
08037E98 1C20     mov     r0,r4                                   
08037E9A 302E     add     r0,2Eh                                  
08037E9C 7005     strb    r5,[r0]                                 
08037E9E 1C21     mov     r1,r4                                   
08037EA0 312F     add     r1,2Fh                                  
08037EA2 2010     mov     r0,10h                                  
08037EA4 E013     b       8037ECEh                                
08037EA6 0000     lsl     r0,r0,0h                                
08037EA8 0B38     lsr     r0,r7,0Ch                               
08037EAA 082F     lsr     r7,r5,20h                               
08037EAC 0738     lsl     r0,r7,1Ch                               
08037EAE 0300     lsl     r0,r0,0Ch                               
08037EB0 FFD8     bl      lr+0FB0h                                
08037EB2 0000     lsl     r0,r0,0h                                
08037EB4 0C41     lsr     r1,r0,11h                               
08037EB6 0000     lsl     r0,r0,0h                                
08037EB8 01A8     lsl     r0,r5,6h                                
08037EBA 0300     lsl     r0,r0,0Ch                               
08037EBC 1C21     mov     r1,r4                                   
08037EBE 3124     add     r1,24h                                  
08037EC0 2009     mov     r0,9h                                   
08037EC2 7008     strb    r0,[r1]                                 
08037EC4 310A     add     r1,0Ah                                  
08037EC6 2001     mov     r0,1h                                   
08037EC8 7008     strb    r0,[r1]                                 
08037ECA 3101     add     r1,1h                                   
08037ECC 2008     mov     r0,8h                                   
08037ECE 7008     strb    r0,[r1]                                 
08037ED0 BCF0     pop     r4-r7                                   
08037ED2 BC01     pop     r0                                      
08037ED4 4700     bx      r0                                      
08037ED6 0000     lsl     r0,r0,0h                                
08037ED8 B5F0     push    r4-r7,r14                               
08037EDA 4A14     ldr     r2,=3000738h                            
08037EDC 8811     ldrh    r1,[r2]                                 
08037EDE 2080     mov     r0,80h                                  
08037EE0 0100     lsl     r0,r0,4h                                
08037EE2 4008     and     r0,r1                                   
08037EE4 1C13     mov     r3,r2                                   
08037EE6 2800     cmp     r0,0h                                   
08037EE8 D026     beq     8037F38h                                
08037EEA 4911     ldr     r1,=30001A8h                            
08037EEC 22F0     mov     r2,0F0h                                 
08037EEE 0052     lsl     r2,r2,1h                                
08037EF0 1C10     mov     r0,r2                                   
08037EF2 8008     strh    r0,[r1]                                 
08037EF4 4A0F     ldr     r2,=30001ACh                            
08037EF6 24A8     mov     r4,0A8h                                 
08037EF8 00E4     lsl     r4,r4,3h                                
08037EFA 1910     add     r0,r2,r4                                
08037EFC 4282     cmp     r2,r0                                   
08037EFE D21F     bcs     8037F40h                                
08037F00 2601     mov     r6,1h                                   
08037F02 2520     mov     r5,20h                                  
08037F04 2700     mov     r7,0h                                   
08037F06 1C04     mov     r4,r0                                   
08037F08 8811     ldrh    r1,[r2]                                 
08037F0A 1C30     mov     r0,r6                                   
08037F0C 4008     and     r0,r1                                   
08037F0E 2800     cmp     r0,0h                                   
08037F10 D007     beq     8037F22h                                
08037F12 1C10     mov     r0,r2                                   
08037F14 3025     add     r0,25h                                  
08037F16 7800     ldrb    r0,[r0]                                 
08037F18 2814     cmp     r0,14h                                  
08037F1A D102     bne     8037F22h                                
08037F1C 1C08     mov     r0,r1                                   
08037F1E 4328     orr     r0,r5                                   
08037F20 8010     strh    r0,[r2]                                 
08037F22 3238     add     r2,38h                                  
08037F24 42A2     cmp     r2,r4                                   
08037F26 D3EF     bcc     8037F08h                                
08037F28 E00A     b       8037F40h                                
08037F2A 0000     lsl     r0,r0,0h                                
08037F2C 0738     lsl     r0,r7,1Ch                               
08037F2E 0300     lsl     r0,r0,0Ch                               
08037F30 01A8     lsl     r0,r5,6h                                
08037F32 0300     lsl     r0,r0,0Ch                               
08037F34 01AC     lsl     r4,r5,6h                                
08037F36 0300     lsl     r0,r0,0Ch                               
08037F38 4811     ldr     r0,=30001A8h                            
08037F3A 8800     ldrh    r0,[r0]                                 
08037F3C 2800     cmp     r0,0h                                   
08037F3E D066     beq     803800Eh                                
08037F40 1C19     mov     r1,r3                                   
08037F42 3124     add     r1,24h                                  
08037F44 2200     mov     r2,0h                                   
08037F46 200B     mov     r0,0Bh                                  
08037F48 7008     strb    r0,[r1]                                 
08037F4A 8819     ldrh    r1,[r3]                                 
08037F4C 480D     ldr     r0,=0F7FFh                              
08037F4E 4008     and     r0,r1                                   
08037F50 2100     mov     r1,0h                                   
08037F52 8018     strh    r0,[r3]                                 
08037F54 2026     mov     r0,26h                                  
08037F56 18C0     add     r0,r0,r3                                
08037F58 4684     mov     r12,r0                                  
08037F5A 2001     mov     r0,1h                                   
08037F5C 4664     mov     r4,r12                                  
08037F5E 7020     strb    r0,[r4]                                 
08037F60 82DA     strh    r2,[r3,16h]                             
08037F62 7719     strb    r1,[r3,1Ch]                             
08037F64 1C18     mov     r0,r3                                   
08037F66 302D     add     r0,2Dh                                  
08037F68 7800     ldrb    r0,[r0]                                 
08037F6A 2805     cmp     r0,5h                                   
08037F6C D02A     beq     8037FC4h                                
08037F6E 2805     cmp     r0,5h                                   
08037F70 DC0A     bgt     8037F88h                                
08037F72 2803     cmp     r0,3h                                   
08037F74 D01A     beq     8037FACh                                
08037F76 2803     cmp     r0,3h                                   
08037F78 DC1E     bgt     8037FB8h                                
08037F7A 2802     cmp     r0,2h                                   
08037F7C D010     beq     8037FA0h                                
08037F7E E03F     b       8038000h                                
08037F80 01A8     lsl     r0,r5,6h                                
08037F82 0300     lsl     r0,r0,0Ch                               
08037F84 F7FF     ????                                            
08037F86 0000     lsl     r0,r0,0h                                
08037F88 2883     cmp     r0,83h                                  
08037F8A D027     beq     8037FDCh                                
08037F8C 2883     cmp     r0,83h                                  
08037F8E DC02     bgt     8037F96h                                
08037F90 2882     cmp     r0,82h                                  
08037F92 D01D     beq     8037FD0h                                
08037F94 E034     b       8038000h                                
08037F96 2884     cmp     r0,84h                                  
08037F98 D026     beq     8037FE8h                                
08037F9A 2885     cmp     r0,85h                                  
08037F9C D02A     beq     8037FF4h                                
08037F9E E02F     b       8038000h                                
08037FA0 4801     ldr     r0,=82F0C70h                            
08037FA2 6198     str     r0,[r3,18h]                             
08037FA4 E02F     b       8038006h                                
08037FA6 0000     lsl     r0,r0,0h                                
08037FA8 0C70     lsr     r0,r6,11h                               
08037FAA 082F     lsr     r7,r5,20h                               
08037FAC 4801     ldr     r0,=82F0CA8h                            
08037FAE 6198     str     r0,[r3,18h]                             
08037FB0 E029     b       8038006h                                
08037FB2 0000     lsl     r0,r0,0h                                
08037FB4 0CA8     lsr     r0,r5,12h                               
08037FB6 082F     lsr     r7,r5,20h                               
08037FB8 4801     ldr     r0,=82F0CE0h                            
08037FBA 6198     str     r0,[r3,18h]                             
08037FBC E023     b       8038006h                                
08037FBE 0000     lsl     r0,r0,0h                                
08037FC0 0CE0     lsr     r0,r4,13h                               
08037FC2 082F     lsr     r7,r5,20h                               
08037FC4 4801     ldr     r0,=82F0D18h                            
08037FC6 6198     str     r0,[r3,18h]                             
08037FC8 E01D     b       8038006h                                
08037FCA 0000     lsl     r0,r0,0h                                
08037FCC 0D18     lsr     r0,r3,14h                               
08037FCE 082F     lsr     r7,r5,20h                               
08037FD0 4801     ldr     r0,=82F0B90h                            
08037FD2 6198     str     r0,[r3,18h]                             
08037FD4 E017     b       8038006h                                
08037FD6 0000     lsl     r0,r0,0h                                
08037FD8 0B90     lsr     r0,r2,0Eh                               
08037FDA 082F     lsr     r7,r5,20h                               
08037FDC 4801     ldr     r0,=82F0BC8h                            
08037FDE 6198     str     r0,[r3,18h]                             
08037FE0 E011     b       8038006h                                
08037FE2 0000     lsl     r0,r0,0h                                
08037FE4 0BC8     lsr     r0,r1,0Fh                               
08037FE6 082F     lsr     r7,r5,20h                               
08037FE8 4801     ldr     r0,=82F0C00h                            
08037FEA 6198     str     r0,[r3,18h]                             
08037FEC E00B     b       8038006h                                
08037FEE 0000     lsl     r0,r0,0h                                
08037FF0 0C00     lsr     r0,r0,10h                               
08037FF2 082F     lsr     r7,r5,20h                               
08037FF4 4801     ldr     r0,=82F0C38h                            
08037FF6 6198     str     r0,[r3,18h]                             
08037FF8 E005     b       8038006h                                
08037FFA 0000     lsl     r0,r0,0h                                
08037FFC 0C38     lsr     r0,r7,10h                               
08037FFE 082F     lsr     r7,r5,20h                               
08038000 2000     mov     r0,0h                                   
08038002 8018     strh    r0,[r3]                                 
08038004 E003     b       803800Eh                                
08038006 2085     mov     r0,85h                                  
08038008 0040     lsl     r0,r0,1h                                
0803800A F7CAFD05 bl      8002A18h                                
0803800E BCF0     pop     r4-r7                                   
08038010 BC01     pop     r0                                      
08038012 4700     bx      r0                                      
08038014 B510     push    r4,r14                                  
08038016 4C11     ldr     r4,=3000738h                            
08038018 1C21     mov     r1,r4                                   
0803801A 3126     add     r1,26h                                  
0803801C 2001     mov     r0,1h                                   
0803801E 7008     strb    r0,[r1]                                 
08038020 F7D7FDD2 bl      800FBC8h                                
08038024 2800     cmp     r0,0h                                   
08038026 D05A     beq     80380DEh                                
08038028 1C21     mov     r1,r4                                   
0803802A 3124     add     r1,24h                                  
0803802C 2023     mov     r0,23h                                  
0803802E 7008     strb    r0,[r1]                                 
08038030 2100     mov     r1,0h                                   
08038032 2000     mov     r0,0h                                   
08038034 82E0     strh    r0,[r4,16h]                             
08038036 7721     strb    r1,[r4,1Ch]                             
08038038 8820     ldrh    r0,[r4]                                 
0803803A 2104     mov     r1,4h                                   
0803803C 4308     orr     r0,r1                                   
0803803E 8020     strh    r0,[r4]                                 
08038040 1C20     mov     r0,r4                                   
08038042 302D     add     r0,2Dh                                  
08038044 7800     ldrb    r0,[r0]                                 
08038046 2805     cmp     r0,5h                                   
08038048 D028     beq     803809Ch                                
0803804A 2805     cmp     r0,5h                                   
0803804C DC08     bgt     8038060h                                
0803804E 2803     cmp     r0,3h                                   
08038050 D018     beq     8038084h                                
08038052 2803     cmp     r0,3h                                   
08038054 DC1C     bgt     8038090h                                
08038056 2802     cmp     r0,2h                                   
08038058 D00E     beq     8038078h                                
0803805A E03D     b       80380D8h                                
0803805C 0738     lsl     r0,r7,1Ch                               
0803805E 0300     lsl     r0,r0,0Ch                               
08038060 2883     cmp     r0,83h                                  
08038062 D027     beq     80380B4h                                
08038064 2883     cmp     r0,83h                                  
08038066 DC02     bgt     803806Eh                                
08038068 2882     cmp     r0,82h                                  
0803806A D01D     beq     80380A8h                                
0803806C E034     b       80380D8h                                
0803806E 2884     cmp     r0,84h                                  

