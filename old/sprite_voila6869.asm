
.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
.definelabel DirectionTag,800F8E0h       ;检查敌人与samus的左右位置
.definelabel MainSpriteDateStart,82b0d68h
.definelabel SamusDataStart,30013d4h
.definelabel CheckRange,800FDE0h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel CheckSloop,800F360h
.definelabel CheckAnimation,800FBC8h
.definelabel CheckAnimation2,800FC00h
.definelabel SpritesDataRAMStart,3000738h
.definelabel DeathFireWorks,8011084h
.definelabel SpriteDrop,800E3D4h
.definelabel FrozenRoutine,800FFE8h
.definelabel StunSprite,8011280h
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel SpriteID,93h
.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteRNG,300083Ch
.definelabel BGDataStart,300009Ch
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0
.definelabel UPOutWaterEffect,80116cch
.definelabel DropInWaterEffect,8011718h
.definelabel MakeWaterEffect,8011620h

;pose 00
0803743C B570     push    r4-r6,r14                               
0803743E F7D8FA01 bl      RNGdirection ;随机值定义方向                               
08037442 4C0C     ldr     r4,=SpritesDataRAMStart                           
08037444 8860     ldrh    r0,[r4,2h]                              
08037446 3820     sub     r0,20h       ;Y坐标Up20h                           
08037448 8060     strh    r0,[r4,2h]   ;再写入                             
0803744A 8860     ldrh    r0,[r4,2h]                              
0803744C 3020     add     r0,20h       ;Y坐标原值                             
0803744E 88A1     ldrh    r1,[r4,4h]                              
08037450 F7D8F91A bl      CheckClip    ;检查出生脚底                           
08037454 4D08     ldr     r5,=YTagRAM                           
08037456 7829     ldrb    r1,[r5]                                 
08037458 26F0     mov     r6,0F0h                                 
0803745A 1C30     mov     r0,r6                                   
0803745C 4008     and     r0,r1        ;F0 and 30007F1的值                                
0803745E 2800     cmp     r0,0h        ;仅当返回11才会不为0                           
08037460 D00C     beq     @@nodownblock ;                             
08037462 8860     ldrh    r0,[r4,2h]                              
08037464 3008     add     r0,8h        ;下方如果有砖则坐标UP18h                           
08037466 8060     strh    r0,[r4,2h]   ;再写入                           
08037468 1C21     mov     r1,r4                                   
0803746A 3124     add     r1,24h                                  
0803746C 2009     mov     r0,9h                                   
0803746E 7008     strb    r0,[r1]      ;pose写入9                            
08037470 E03C     b       @@pose0still                                


@@nodownblock:             ;下方无地面再次判断                           
0803747C 8860     ldrh    r0,[r4,2h]                              
0803747E 3824     sub     r0,24h       ;Y坐标原值Up44h                            
08037480 88A1     ldrh    r1,[r4,4h]                              
08037482 F7D8F901 bl      CheckClip    ;检查顶部砖块                             
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
080374A6 F7D8F8EF bl      CheckClip                                
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
080374CA F7D8F8DD bl      CheckClip                                
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
080374EC 4B13     ldr     r3,=SpritesDataRAMStart                           
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
08037564 4C0F     ldr     r4,=SpritesDataRAMStart                           
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
0803757E F7D8F883 bl      CheckClip   ;检查右边地面是否有砖块                            
08037582 4F09     ldr     r7,=YtagRAM                            
08037584 7838     ldrb    r0,[r7]                                 
08037586 2800     cmp     r0,0h                                   
08037588 D110     bne     @@downsideclip 
                      
0803758A 1C31     mov     r1,r6       ;也不包括上左墙转为左的转折,以及之后的延续                          
0803758C 3920     sub     r1,20h      ;X坐标Left20h                            
0803758E 1C28     mov     r0,r5                                   
08037590 F7D8F87A bl      CheckClip   ;检查左边地面是否有砖块                           
08037594 7838     ldrb    r0,[r7]                                 
08037596 2800     cmp     r0,0h                                   
08037598 D108     bne     @@downsideclip                              
0803759A 1C21     mov     r1,r4                                   
0803759C 3124     add     r1,24h                                  
0803759E 201E     mov     r0,1Eh            ;掉落                      
080375A0 7008     strb    r0,[r1]           ;pose写入1Eh掉落                      
080375A2 E0A8     b       @@MainEnd                                
;确认脚下有砖块不会掉落
@@downsideclip:                        ;三次检查斜坡                 
080375AC 1F28     sub     r0,r5,4      ;Y坐标Up4h 检查坡                           
080375AE 1C31     mov     r1,r6                                   
080375B0 F7D7FED6 bl      CheckSlope                           
080375B4 1C02     mov     r2,r0                                   
080375B6 4C23     ldr     r4,=30007F0h                            
080375B8 7821     ldrb    r1,[r4]                                 
080375BA 270F     mov     r7,0Fh                                  
080375BC 1C38     mov     r0,r7                                   
080375BE 4008     and     r0,r1                                   
080375C0 2801     cmp     r0,1h         ;在下轻斜坡的时候为3 重为4                           
080375C2 D811     bhi     @@Onslope     ;在下斜坡的时候                          
080375C4 1C28     mov     r0,r5                                   
080375C6 1C31     mov     r1,r6                                   
080375C8 F7D7FECA bl      CheckSlope                                
080375CC 1C02     mov     r2,r0                                   
080375CE 7821     ldrb    r1,[r4]                                 
080375D0 1C38     mov     r0,r7                                   
080375D2 4008     and     r0,r1                                   
080375D4 2801     cmp     r0,1h         ;在上斜坡的时候??                        
080375D6 D807     bhi     @@Onslope  ;在横变upper斜转折的时候                         
080375D8 1D28     add     r0,r5,4                                 
080375DA 1C31     mov     r1,r6                                   
080375DC F7D7FEC0 bl      CheckSlope                                
080375E0 1C02     mov     r2,r0                                   
080375E2 7820     ldrb    r0,[r4]                                 
080375E4 2800     cmp     r0,0h      ;根本没在斜坡上                            
080375E6 D003     beq     @@twist    ;在竖变横或横变竖转折的时候

@@Onslope:                              
080375E8 4917     ldr     r1,=SpritesDataRAMStart                           
080375EA 1C10     mov     r0,r2       ;r2是返回的正确高度                            
080375EC 3818     sub     r0,18h      ;惯例Y向上18h                            
080375EE 8048     strh    r0,[r1,2h]  ;写入斜坡上该有的高度

@@twist:                              
080375F0 4C15     ldr     r4,=SpritesDataRAMStart                           
080375F2 8860     ldrh    r0,[r4,2h]                              
080375F4 3018     add     r0,18h      ;Y坐标原值                            
080375F6 0400     lsl     r0,r0,10h                            
080375F8 0C05     lsr     r5,r0,10h                             
080375FA 4812     ldr     r0,=30007F0h                            
080375FC 7801     ldrb    r1,[r0]                                 
080375FE 2900     cmp     r1,0h                                   
08037600 D003     beq     @@twist2    ;不在斜坡以及平台上就会跳转                          
08037602 20F0     mov     r0,0F0h                                 
08037604 4008     and     r0,r1       ;F0 and                            
08037606 2800     cmp     r0,0h                                   
08037608 D068     beq     Onslope2    ;在斜坡上而非平台上就会跳转

@@twist2:         ;也可能是平台 非斜坡 也非平台.转折处?  
0803760A 8821     ldrh    r1,[r4]                                 
0803760C 2080     mov     r0,80h                                  
0803760E 0080     lsl     r0,r0,2h                                
08037610 4680     mov     r8,r0                                   
08037612 4008     and     r0,r1     ;200 and 取向                             
08037614 2800     cmp     r0,0h     ;上和左移动为0?                              
08037616 D030     beq     @@LeftTwist      

;右移动在转折处                       
08037618 1C31     mov     r1,r6                                   
0803761A 3918     sub     r1,18h             ;X坐标Left18h的值                             
0803761C 1C28     mov     r0,r5                                   
0803761E F7D8F833 bl      CheckClip                                
08037622 4F0A     ldr     r7,=YtagRAM                            
08037624 7838     ldrb    r0,[r7]                                 
08037626 2800     cmp     r0,0h                                   
08037628 D115     bne     @@LeftDownclip     ;判断左下有砖块? 

;既然右移动在转折处,左边没有砖,意思为向左到了可以向下的阶段                           
0803762A 1C31     mov     r1,r6                                   
0803762C 3118     add     r1,18h                                  
0803762E 1C28     mov     r0,r5                                   
08037630 F7D8F82A bl      CheckClip                                
08037634 7838     ldrb    r0,[r7]                                 
08037636 2800     cmp     r0,0h                                   
08037638 D10A     bne     @@RightDownclip    ;判断右下有砖块

;左右都无砖块                             
0803763A 8821     ldrh    r1,[r4]                                 
0803763C 4640     mov     r0,r8                                   
0803763E 4308     orr     r0,r1              ;取向orr 200h                        
08037640 E043     b       @@LeftBorderPose   ;向下移动,写入左部接壤pose                         

@@RightDownclip:          ;到了向下的阶段,结果右边有砖,正常情况不太可能                        
08037650 88A0     ldrh    r0,[r4,4h]                              
08037652 4448     add     r0,r9         ;向右移动                          
08037654 E04E     b       WriteSpeed 

@@LeftDownclip:                           ;左边有砖                              
08037656 1F28     sub     r0,r5,4         ;检查同水平线的高度的砖块                          
08037658 1C31     mov     r1,r6                                   
0803765A 3118     add     r1,18h          ;向右18h                          
0803765C F7D8F814 bl      CheckClip                                
08037660 7838     ldrb    r0,[r7]                                 
08037662 2811     cmp     r0,11h                                  
08037664 D106     bne     @@norightmax    ;未贴合右砖跳转                             
08037666 8821     ldrh    r1,[r4]                                 
08037668 4801     ldr     r0,=0FDFFh                              
0803766A 4008     and     r0,r1           ;标记改为向上或左的                        
0803766C E019     b       @@RightBorderPose        ;变成向上移动的右部接壤                            

@@norightmax:                               
08037674 88A0     ldrh    r0,[r4,4h]                              
08037676 4448     add     r0,r9           ;继续向右移动                          
08037678 E03C     b       @@WriteSpeed

@@LeftTwist:                            ;左移动在转折处                            
0803767A 1C31     mov     r1,r6                                   
0803767C 3114     add     r1,14h          ;检查右边是否有砖块                          
0803767E 1C28     mov     r0,r5                                   
08037680 F7D8F802 bl      CheckClip                                
08037684 4F0A     ldr     r7,=YtagRAM                            
08037686 7838     ldrb    r0,[r7]                                 
08037688 2800     cmp     r0,0h                                   
0803768A D113     bne     RightDownclip2  ;右下有砖块,未到转折时

;右下无砖,到了向下转折的时刻                       
0803768C 1C31     mov     r1,r6                                   
0803768E 391C     sub     r1,1Ch                                  
08037690 1C28     mov     r0,r5                                   
08037692 F7D7FFF9 bl      CheckClip                                
08037696 7838     ldrb    r0,[r7]                                 
08037698 2800     cmp     r0,0h                                   
0803769A D128     bne     @@LeftDownclip2        ;左下有砖块 

;左下无砖,变成右接壤向下移动                            
0803769C 8821     ldrh    r1,[r4]                ;左下右下都无砖                 
0803769E 4640     mov     r0,r8                                   
080376A0 4308     orr     r0,r1                  ;标记改为向下或右的

@@RightBorderPose:                                       
080376A2 8020     strh    r0,[r4]                                 
080376A4 1C21     mov     r1,r4                                   
080376A6 3124     add     r1,24h                                  
080376A8 2027     mov     r0,27h                 ;pose写入27h 右部接壤                              
080376AA 7008     strb    r0,[r1]                                 
080376AC E023     b       @@end                               

@@RightDownclip2:                     ;未到转折时        
080376B4 1F28     sub     r0,r5,4     ;同水平线                          
080376B6 1C31     mov     r1,r6                                   
080376B8 391C     sub     r1,1Ch      ;检查左边是否有砖                             
080376BA F7D7FFE5 bl      CheckClip                                
080376BE 7838     ldrb    r0,[r7]                                 
080376C0 2811     cmp     r0,11h                                  
080376C2 D114     bne     @@LeftDownclip2  ;正确来说是左边没有砖
 
;左移动,左边有砖,变成左接壤向上移动 
080376C4 8821     ldrh    r1,[r4]                                 
080376C6 4804     ldr     r0,=0FDFFh      ;去掉200h                         
080376C8 4008     and     r0,r1  


@@LeftBorderPose:                                 
080376CA 8020     strh    r0,[r4]                                 
080376CC 1C21     mov     r1,r4                                   
080376CE 3124     add     r1,24h                                  
080376D0 2025     mov     r0,25h      ;左部接壤pose                             
080376D2 7008     strb    r0,[r1]                                 
080376D4 E00F     b       @@end                                


@@Onslope2:                               
080376DC 8821     ldrh    r1,[r4]                                 
080376DE 2080     mov     r0,80h                                  
080376E0 0080     lsl     r0,r0,2h                                
080376E2 4008     and     r0,r1                                   
080376E4 2800     cmp     r0,0h            ;检查是否有200h                            
080376E6 D002     beq     @@LeftDownclip2  ;没有则向左移动                          
080376E8 88A0     ldrh    r0,[r4,4h]                              
080376EA 4448     add     r0,r9            ;X坐标向右移动                          
080376EC E002     b       @@WriteSpeed  

@@LeftDownclip2:                              
080376EE 88A0     ldrh    r0,[r4,4h]                              
080376F0 4649     mov     r1,r9            ;速度向左继续移动                       
080376F2 1A40     sub     r0,r0,r1  

@@WriteSpeed:                              
080376F4 80A0     strh    r0,[r4,4h] 

@@end:                             
080376F6 BC18     pop     r3,r4                                   
080376F8 4698     mov     r8,r3                                   
080376FA 46A1     mov     r9,r4                                   
080376FC BCF0     pop     r4-r7                                   
080376FE BC01     pop     r0                                      
08037700 4700     bx      r0 

                                     
;pose 23 上部接壤                               
08037704 B5F0     push    r4-r7,r14                               
08037706 464F     mov     r7,r9                                   
08037708 4646     mov     r6,r8                                   
0803770A B4C0     push    r6,r7                                   
0803770C 4E12     ldr     r6,=SpritesDataRAMStart                           
0803770E 8871     ldrh    r1,[r6,2h]                              
08037710 4812     ldr     r0,=0FFC0h                              
08037712 4008     and     r0,r1                                   
08037714 1C01     mov     r1,r0        ;坐标向上固定一格                          
08037716 3118     add     r1,18h       ;再向下18h                           
08037718 8071     strh    r1,[r6,2h]   ;再写入                           
0803771A 1C31     mov     r1,r6                                   
0803771C 312E     add     r1,2Eh                                  
0803771E 7809     ldrb    r1,[r1]      ;读取速度                             
08037720 4688     mov     r8,r1                                   
08037722 3804     sub     r0,4h        ;向上一格的坐标再次向上4h                           
08037724 0400     lsl     r0,r0,10h                               
08037726 0C05     lsr     r5,r0,10h    ;作为贴合面的Y值?                           
08037728 88B4     ldrh    r4,[r6,4h]   ;读取X坐标                           
0803772A 1C21     mov     r1,r4                                   
0803772C 311C     add     r1,1Ch       ;向右1Ch                           
0803772E 1C28     mov     r0,r5                                   
08037730 F7D7FFAA bl      CheckClip                                
08037734 4F0A     ldr     r7,=YtagRAM                            
08037736 7838     ldrb    r0,[r7]                                 
08037738 2800     cmp     r0,0h        ;检查上右是否有砖块                            
0803773A D113     bne     @@NoDrop                                
0803773C 1C21     mov     r1,r4                                   
0803773E 3920     sub     r1,20h                                  
08037740 1C28     mov     r0,r5                                    
08037742 F7D7FFA1 bl      CheckClip                                
08037746 7838     ldrb    r0,[r7]                                 
08037748 2800     cmp     r0,0h        ;检查上左是否有砖块                           
0803774A D10B     bne     @@NoDrop                                
0803774C 1C31     mov     r1,r6                                   
0803774E 3124     add     r1,24h                                  
08037750 201E     mov     r0,1Eh       ;都无砖则掉落                           
08037752 7008     strb    r0,[r1]                                 
08037754 E073     b       @@end                               

@@NoDrop:                             
08037764 4E0F     ldr     r6,=SpritesDataRAMStart                           
08037766 8831     ldrh    r1,[r6]                                 
08037768 2080     mov     r0,80h                                  
0803776A 0080     lsl     r0,r0,2h                                
0803776C 4681     mov     r9,r0                                   
0803776E 4008     and     r0,r1        ;取向and200                             
08037770 2800     cmp     r0,0h                                   
08037772 D02F     beq     @@No200                                
08037774 1C21     mov     r1,r4                                   
08037776 3918     sub     r1,18h       ;再次的检查左上,只是左20改成了左18h                            
08037778 1C28     mov     r0,r5                                   
0803777A F7D7FF85 bl      CheckClip                                
0803777E 4F0A     ldr     r7,=YtagRAM                            
08037780 7839     ldrb    r1,[r7]                                 
08037782 200F     mov     r0,0Fh                                  
08037784 4008     and     r0,r1                                   
08037786 2800     cmp     r0,0h                                   
08037788 D115     bne     LeftUpclip                                
0803778A 1C21     mov     r1,r4                                   
0803778C 3118     add     r1,18h                                  
0803778E 1C28     mov     r0,r5                                   
08037790 F7D7FF7A bl      CheckClip                                
08037794 7838     ldrb    r0,[r7]                                 
08037796 2800     cmp     r0,0h                                   
08037798 D10A     bne     @@RightUpclip                               
0803779A 8831     ldrh    r1,[r6]      ;上左上右都没有砖                            
0803779C 4803     ldr     r0,=0FDFFh   ;取向去掉200h                           
0803779E 4008     and     r0,r1                                   
080377A0 E043     b       @@PoseWrite25   ;左部接壤的姿势???                                

@@RightUpclip:                              
080377B0 88B0     ldrh    r0,[r6,4h]                              
080377B2 4440     add     r0,r8                                   
080377B4 E042     b       @@WriteSpeed 

@@LeftUpclip:                               
080377B6 1D28     add     r0,r5,4                                 
080377B8 1C21     mov     r1,r4                                   
080377BA 3118     add     r1,18h      ;向下4h,检查右边是否右转                            
080377BC F7D7FF64 bl      CheckClip                                
080377C0 7838     ldrb    r0,[r7]                                 
080377C2 2811     cmp     r0,11h                                  
080377C4 D103     bne     @@RightNoBlock                               
080377C6 8831     ldrh    r1,[r6]     ;右边有砖的话                         
080377C8 4648     mov     r0,r9                                   
080377CA 4308     orr     r0,r1       ;取向orr200h                            
080377CC E018     b       @@PoseWrite27 

@@RightNoBlock:                               
080377CE 88B0     ldrh    r0,[r6,4h]                              
080377D0 4440     add     r0,r8       ;右移动                            
080377D2 E033     b       @@WriteSpeed  

@@No200:                             ;地面(包括斜坡)和向下有200,天花板和向上没有      
080377D4 1C21     mov     r1,r4                                   
080377D6 3114     add     r1,14h     ;检查上右?                             
080377D8 1C28     mov     r0,r5                                   
080377DA F7D7FF55 bl      CheckClip                                
080377DE 4F0B     ldr     r7,=YtagRAM                            
080377E0 7839     ldrb    r1,[r7]                                 
080377E2 200F     mov     r0,0Fh                                  
080377E4 4008     and     r0,r1                                   
080377E6 2800     cmp     r0,0h                                   
080377E8 D114     bne     @@RightUpclip2                               
080377EA 1C21     mov     r1,r4                                   
080377EC 391C     sub     r1,1Ch    ;检查上左                              
080377EE 1C28     mov     r0,r5                                   
080377F0 F7D7FF4A bl      CheckClip                                
080377F4 7838     ldrb    r0,[r7]                                 
080377F6 2800     cmp     r0,0h                                   
080377F8 D11D     bne     @@LeftUpclip2                                
080377FA 8831     ldrh    r1,[r6]                                 
080377FC 4804     ldr     r0,=0FDFFh     ;否则去掉200h                          
080377FE 4008     and     r0,r1  

@@PoseWrite27:                      ;右部接壤pose写入?                                
08037800 8030     strh    r0,[r6]                                 
08037802 1C31     mov     r1,r6                                   
08037804 3124     add     r1,24h                                  
08037806 2027     mov     r0,27h                                  
08037808 7008     strb    r0,[r1]                                 
0803780A E018     b       @@end                               


@@RightUpclip2:                              
08037814 1D28     add     r0,r5,4                                 
08037816 1C21     mov     r1,r4                                   
08037818 391C     sub     r1,1Ch                                  
0803781A F7D7FF35 bl      CheckClip                                
0803781E 7838     ldrb    r0,[r7]                                 
08037820 2811     cmp     r0,11h                                  
08037822 D108     bne     8037836h                                
08037824 8831     ldrh    r1,[r6]                                 
08037826 4648     mov     r0,r9                                   
08037828 4308     orr     r0,r1 

@@PoseWrite25:                                  
0803782A 8030     strh    r0,[r6]                                 
0803782C 1C31     mov     r1,r6                                   
0803782E 3124     add     r1,24h                                  
08037830 2025     mov     r0,25h                                  
08037832 7008     strb    r0,[r1]                                 
08037834 E003     b       803783Eh 

@@LeftUpclip2:                               
08037836 88B0     ldrh    r0,[r6,4h]                              
08037838 4641     mov     r1,r8                                   
0803783A 1A40     sub     r0,r0,r1 

@@WriteSpeed:                              
0803783C 80B0     strh    r0,[r6,4h]  

@@end:                            
0803783E BC18     pop     r3,r4                                   
08037840 4698     mov     r8,r3                                   
08037842 46A1     mov     r9,r4                                   
08037844 BCF0     pop     r4-r7                                   
08037846 BC01     pop     r0                                      
08037848 4700     bx      r0    

                                  
;pose 25                        ;左部接壤   
0803784C B5F0     push    r4-r7,r14                               
0803784E 464F     mov     r7,r9                                   
08037850 4646     mov     r6,r8                                   
08037852 B4C0     push    r6,r7                                   
08037854 4E12     ldr     r6,=SpritesDataRAMStart                           
08037856 88B1     ldrh    r1,[r6,4h]                              
08037858 4812     ldr     r0,=0FFC0h                              
0803785A 4008     and     r0,r1       ;固位一格                            
0803785C 1C01     mov     r1,r0                                   
0803785E 3118     add     r1,18h      ;向右18h                            
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
08037878 F7D7FF06 bl      CheckClip                                
0803787C 4F0A     ldr     r7,=YtagRAM                            
0803787E 7838     ldrb    r0,[r7]                                 
08037880 2800     cmp     r0,0h                                   
08037882 D113     bne     80378ACh                                
08037884 1C20     mov     r0,r4                                   
08037886 3820     sub     r0,20h                                  
08037888 1C29     mov     r1,r5                                   
0803788A F7D7FEFD bl      CheckClip                                
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
080378AC 4E0F     ldr     r6,=SpritesDataRAMStart                           
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
080378C2 F7D7FEE1 bl      CheckClip                                
080378C6 4F0A     ldr     r7,=YtagRAM                            
080378C8 7839     ldrb    r1,[r7]                                 
080378CA 20F0     mov     r0,0F0h                                 
080378CC 4008     and     r0,r1                                   
080378CE 2800     cmp     r0,0h                                   
080378D0 D115     bne     80378FEh                                
080378D2 1C20     mov     r0,r4                                   
080378D4 3018     add     r0,18h                                  
080378D6 1C29     mov     r1,r5                                   
080378D8 F7D7FED6 bl      CheckClip                                
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
08037904 F7D7FEC0 bl      CheckClip                                
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
08037922 F7D7FEB1 bl      CheckClip                                
08037926 4F0B     ldr     r7,=YtagRAM                            
08037928 7839     ldrb    r1,[r7]                                 
0803792A 20F0     mov     r0,0F0h                                 
0803792C 4008     and     r0,r1                                   
0803792E 2800     cmp     r0,0h                                   
08037930 D114     bne     803795Ch                                
08037932 1C20     mov     r0,r4                                   
08037934 381C     sub     r0,1Ch                                  
08037936 1C29     mov     r1,r5                                   
08037938 F7D7FEA6 bl      CheckClip                                
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
08037962 F7D7FE91 bl      CheckClip                                
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
0803799C 4E12     ldr     r6,=SpritesDataRAMStart                           
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
080379C0 F7D7FE62 bl      CheckClip                                
080379C4 4F0A     ldr     r7,=YtagRAM                            
080379C6 7838     ldrb    r0,[r7]                                 
080379C8 2800     cmp     r0,0h                                   
080379CA D113     bne     80379F4h                                
080379CC 1C20     mov     r0,r4                                   
080379CE 3820     sub     r0,20h                                  
080379D0 1C29     mov     r1,r5                                   
080379D2 F7D7FE59 bl      CheckClip                                
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
080379F4 4E0F     ldr     r6,=SpritesDataRAMStart                           
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
08037A0A F7D7FE3D bl      CheckClip                                
08037A0E 4F0A     ldr     r7,=YtagRAM                            
08037A10 7839     ldrb    r1,[r7]                                 
08037A12 20F0     mov     r0,0F0h                                 
08037A14 4008     and     r0,r1                                   
08037A16 2800     cmp     r0,0h                                   
08037A18 D113     bne     8037A42h                                
08037A1A 1C20     mov     r0,r4                                   
08037A1C 3018     add     r0,18h                                  
08037A1E 1C29     mov     r1,r5                                   
08037A20 F7D7FE32 bl      CheckClip                                
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
08037A48 F7D7FE1E bl      CheckClip                                
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
08037A6C F7D7FE0C bl      CheckClip                                
08037A70 4F0B     ldr     r7,=YtagRAM                            
08037A72 7839     ldrb    r1,[r7]                                 
08037A74 20F0     mov     r0,0F0h                                 
08037A76 4008     and     r0,r1                                   
08037A78 2800     cmp     r0,0h                                   
08037A7A D113     bne     8037AA4h                                
08037A7C 1C20     mov     r0,r4                                   
08037A7E 381C     sub     r0,1Ch                                  
08037A80 1C29     mov     r1,r5                                   
08037A82 F7D7FE01 bl      CheckClip                                
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
08037AAA F7D7FDED bl      CheckClip                                
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
08037AE0 4904     ldr     r1,=SpritesDataRAMStart                           
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
08037AFA 4C0A     ldr     r4,=SpritesDataRAMStart                           
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
08037B74 490E     ldr     r1,=SpritesDataRAMStart                            
08037B76 1C0B     mov     r3,r1                                   
08037B78 3332     add     r3,32h                                  
08037B7A 781A     ldrb    r2,[r3]    ;读取碰撞属性                            
08037B7C 2402     mov     r4,2h                                   
08037B7E 1C20     mov     r0,r4                                   
08037B80 4010     and     r0,r2      ;2 and                              
08037B82 2800     cmp     r0,0h                                   
08037B84 D00B     beq     @@NoHit   ;也就是没有被击打                       
08037B86 20FD     mov     r0,0FDh                                 
08037B88 4010     and     r0,r2      ;与FDh and 然后写入                             
08037B8A 7018     strb    r0,[r3]    ;被击打后去掉击打值                             
08037B8C 8809     ldrh    r1,[r1]                                 
08037B8E 1C20     mov     r0,r4                                   
08037B90 4008     and     r0,r1      ;2 and 3000738                             
08037B92 2800     cmp     r0,0h                                   
08037B94 D003     beq     @@NoHit    ;不播放音乐                               
08037B96 20BC     mov     r0,0BCh                                 
08037B98 0040     lsl     r0,r0,1h                                
08037B9A F7CAFFC1 bl      PlaySound2   ;播放音乐178h

@@NoHit:                      
08037B9E 4C04     ldr     r4,=SpritesDataRAMStart                           
08037BA0 1C20     mov     r0,r4                                   
08037BA2 3030     add     r0,30h                                  
08037BA4 7800     ldrb    r0,[r0]                                 
08037BA6 2800     cmp     r0,0h       ;检查是否被冰冻                            
08037BA8 D004     beq     @@NoFrozened                               
08037BAA F7D8FA1D bl      FrozenRoutine      ;冰冻例程                       
08037BAE E07E     b       @@MainEndh                                
 
@@NoFrozened 
08037BB4 F7D9FB64 bl      StunSprite  ;击晕敌人例程                                
08037BB8 2800     cmp     r0,0h                                   
08037BBA D178     bne     @@MainEndh  ;不为0结束                               
08037BBC 1C20     mov     r0,r4                                   
08037BBE 3024     add     r0,24h                                  
08037BC0 7800     ldrb    r0,[r0]                                 
08037BC2 2827     cmp     r0,27h                                  
08037BC4 D86A     bhi     @OtherPose    ;pose如果大于27跳转                            
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
08037C7A F7FFFC6F bl      803755Ch    ;09h                            
08037C7E E016     b       @@MainEndh                                
08037C80 F7FFFD40 bl      8037704h    ;23h                            
08037C84 E013     b       @@MainEndh                                
08037C86 F7FFFDE1 bl      803784Ch    ;25h                            
08037C8A E010     b       @@MainEndh                                
08037C8C F7FFFE82 bl      8037994h    ;27h                            
08037C90 E00D     b       @@MainEndh                                
08037C92 F7FFFF25 bl      8037AE0h    ;1eh                            
08037C96 F7FFFF2F bl      8037AF8h    ;1fh                            
08037C9A E008     b       @@MainEndh 

@OtherPose:                             
08037C9C 4806     ldr     r0,=SpritesDataRAMStart                           
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

                                     
