
;pose 0调用
083043A0 B530     push    r4,r5,r14                               
083043A2 4A09     ldr     r2,=3000738h                            
083043A4 1C10     mov     r0,r2                                   
083043A6 3032     add     r0,32h                                  
083043A8 7801     ldrb    r1,[r0]       ;获取碰撞属性                          
083043AA 2002     mov     r0,2h                                   
083043AC 4008     and     r0,r1         ;2 and                           
083043AE 2800     cmp     r0,0h                                   
083043B0 D00C     beq     @@Pass        
;----------------------------------被击打                       
083043B2 8811     ldrh    r1,[r2]                                 
083043B4 2080     mov     r0,80h                                  
083043B6 0180     lsl     r0,r0,6h      ;2000h                           
083043B8 4008     and     r0,r1         ;and 取向                          
083043BA 0400     lsl     r0,r0,10h                               
083043BC 0C00     lsr     r0,r0,10h                               
083043BE 2800     cmp     r0,0h                                   
083043C0 D104     bne     @@Pass                                
083043C2 8010     strh    r0,[r2]       ;取向归零                           
083043C4 E02E     b       @@end                                

@@Pass:                              
083043CC 4817     ldr     r0,=3000738h                            
083043CE 4684     mov     r12,r0                                  
083043D0 3027     add     r0,27h                                  
083043D2 2400     mov     r4,0h                                   
083043D4 2210     mov     r2,10h                                  
083043D6 7002     strb    r2,[r0]      ;300075f写入10h                           
083043D8 4661     mov     r1,r12                                  
083043DA 3128     add     r1,28h                                 
083043DC 2308     mov     r3,8h                                   
083043DE 2008     mov     r0,8h                                   
083043E0 7008     strb    r0,[r1]      ;3000760写入8h                           
083043E2 4660     mov     r0,r12                                  
083043E4 3029     add     r0,29h                                  
083043E6 7002     strb    r2,[r0]      ;3000761写入10h                           
083043E8 2500     mov     r5,0h                                   
083043EA 4811     ldr     r0,=0FFC0h                              
083043EC 4661     mov     r1,r12                                  
083043EE 8148     strh    r0,[r1,0Ah]                             
083043F0 818C     strh    r4,[r1,0Ch]                             
083043F2 3020     add     r0,20h                                  
083043F4 81C8     strh    r0,[r1,0Eh]                             
083043F6 2020     mov     r0,20h                                  
083043F8 8208     strh    r0,[r1,10h]  ;四面分界                           
083043FA 770D     strb    r5,[r1,1Ch]                             
083043FC 82CC     strh    r4,[r1,16h]                             
083043FE 4A0D     ldr     r2,=82B0D68h                            
08304400 7F49     ldrb    r1,[r1,1Dh]                             
08304402 0108     lsl     r0,r1,4h     ;ID乘以16h                           
08304404 1840     add     r0,r0,r1     ;加1                           
08304406 1840     add     r0,r0,r1     ;相当于乘以18h                           
08304408 1880     add     r0,r0,r2                                
0830440A 8800     ldrh    r0,[r0]                                 
0830440C 4661     mov     r1,r12                                  
0830440E 8288     strh    r0,[r1,14h]  ;写入血量                            
08304410 3132     add     r1,32h                                  
08304412 7808     ldrb    r0,[r1]      ;读取碰撞属性                           
08304414 4303     orr     r3,r0        ;8 orr                           
08304416 700B     strb    r3,[r1]      ;再写入  无敌                         
08304418 4660     mov     r0,r12                                  
0830441A 3025     add     r0,25h                                  
0830441C 7005     strb    r5,[r0]      ;属性写入0                            
0830441E 390E     sub     r1,0Eh                                  
08304420 2001     mov     r0,1h                                   
08304422 7008     strb    r0,[r1]      ;pose写入1

@@end:                                 
08304424 BC30     pop     r4,r5                                   
08304426 BC01     pop     r0                                      
08304428 4700     bx      r0   

                                   
;pose 1调用                              
08304438 4904     ldr     r1,=3000738h                            
0830443A 1C0B     mov     r3,r1                                   
0830443C 3324     add     r3,24h                                  
0830443E 2200     mov     r2,0h                                   
08304440 2002     mov     r0,2h                                   
08304442 7018     strb    r0,[r3]       ;pose写入2                          
08304444 770A     strb    r2,[r1,1Ch]                             
08304446 82CA     strh    r2,[r1,16h]                             
08304448 4770     bx      r14                                     


;pose 2调用                             
08304450 B510     push    r4,r14                                  
08304452 4C0A     ldr     r4,=3000738h                            
08304454 8821     ldrh    r1,[r4]                                 
08304456 2080     mov     r0,80h                                  
08304458 0180     lsl     r0,r0,6h                                
0830445A 4008     and     r0,r1         ;2000and取向                          
0830445C 2800     cmp     r0,0h                                   
0830445E D10A     bne     @@end         ;若取向有2000则结束                       
08304460 20C0     mov     r0,0C0h                                 
08304462 21C0     mov     r1,0C0h                                 
08304464 F50BFCBC bl      800FDE0h      ;检查是否在范围中                          
08304468 0600     lsl     r0,r0,18h                               
0830446A 2800     cmp     r0,0h                                   
0830446C D003     beq     @@end         ;不在范围则结束                       
0830446E 1C21     mov     r1,r4                                   
08304470 3124     add     r1,24h        ;否则pose写入17h                          
08304472 2017     mov     r0,17h                                  
08304474 7008     strb    r0,[r1]  

@@end                               
08304476 BC10     pop     r4                                      
08304478 BC01     pop     r0                                      
0830447A 4700     bx      r0                                      

;pose 17h                              ;被触发
08304480 4B0C     ldr     r3,=3000738h                            
08304482 1C1A     mov     r2,r3                                   
08304484 3224     add     r2,24h                                  
08304486 2100     mov     r1,0h                                   
08304488 2018     mov     r0,18h                                     
0830448A 7010     strb    r0,[r2]       ;pose写入18                          
0830448C 7719     strb    r1,[r3,1Ch]                             
0830448E 82D9     strh    r1,[r3,16h]                             
08304490 1C19     mov     r1,r3                                   
08304492 3125     add     r1,25h                                  
08304494 2004     mov     r0,4h         ;属性写入4                          
08304496 7008     strb    r0,[r1]                                 
08304498 320E     add     r2,0Eh                                  
0830449A 7811     ldrb    r1,[r2]       ;读取碰撞属性                          
0830449C 20F7     mov     r0,0F7h                                 
0830449E 4008     and     r0,r1         ;and F7                          
083044A0 7010     strb    r0,[r2]       ;再写入                          
083044A2 4805     ldr     r0,=3000088h                            
083044A4 7A81     ldrb    r1,[r0,0Ah]   ;读取3000092的值                          
083044A6 2003     mov     r0,3h                                   
083044A8 4008     and     r0,r1         ;and 3                          
083044AA 1C19     mov     r1,r3                                   
083044AC 3121     add     r1,21h                                  
083044AE 7008     strb    r0,[r1]       ;写入副精灵相关的数据..                            
083044B0 4770     bx      r14                                     


;pose 18h                              
083044BC B500     push    r14                                     
083044BE F50BFB9F bl      800FC00h      ;检查动画结束                           
083044C2 2800     cmp     r0,0h                                   
083044C4 D003     beq     @@end                                
083044C6 4803     ldr     r0,=3000738h                            
083044C8 3024     add     r0,24h                                  
083044CA 2119     mov     r1,19h                                  
083044CC 7001     strb    r1,[r0]       ;pose写入19h

@@end:                                
083044CE BC01     pop     r0                                      
083044D0 4700     bx      r0                                      


;pose 19h                              
083044D8 4B08     ldr     r3,=3000738h                            
083044DA 1C1A     mov     r2,r3                                   
083044DC 3224     add     r2,24h                                  
083044DE 2100     mov     r1,0h                                   
083044E0 201A     mov     r0,1Ah        ;pose写入1ah                             
083044E2 7010     strb    r0,[r2]                                 
083044E4 1C18     mov     r0,r3                                   
083044E6 302F     add     r0,2Fh                                  
083044E8 7001     strb    r1,[r0]       ;3000767写入0                                 
083044EA 3208     add     r2,8h                                   
083044EC 203C     mov     r0,3Ch                                  
083044EE 7010     strb    r0,[r2]       ;3000764写入3C                          
083044F0 3201     add     r2,1h                                   
083044F2 7010     strb    r0,[r2]       ;765同样写入3C                          
083044F4 7719     strb    r1,[r3,1Ch]                             
083044F6 82D9     strh    r1,[r3,16h]                             
083044F8 4770     bx      r14                                     


;pose 1a                           向上升?                              
08304500 B570     push    r4-r6,r14                               
08304502 4A06     ldr     r2,=3000738h                            
08304504 1C11     mov     r1,r2                                   
08304506 312C     add     r1,2Ch                                  
08304508 7808     ldrb    r0,[r1]       ;读取764的值                            
0830450A 2800     cmp     r0,0h                                   
0830450C D008     beq     @@Pass                                
0830450E 3801     sub     r0,1h         ;764减1再写入                          
08304510 7008     strb    r0,[r1]                                 
08304512 8850     ldrh    r0,[r2,2h]    ;Y坐标减4再写入                          
08304514 3804     sub     r0,4h                                   
08304516 8050     strh    r0,[r2,2h]                              
08304518 E022     b       @@end                                


@@Pass:                               
08304520 202F     mov     r0,2Fh                                  
08304522 1880     add     r0,r0,r2                                
08304524 4684     mov     r12,r0        ;767给r12                           
08304526 7803     ldrb    r3,[r0]       ;读取767的值                          
08304528 4D0F     ldr     r5,=82CD604h                            
0830452A 0058     lsl     r0,r3,1h      ;乘以2                          
0830452C 1940     add     r0,r0,r5      ;加上偏移值                          
0830452E 8804     ldrh    r4,[r0]       ;读取数值                        
08304530 2600     mov     r6,0h                                   
08304532 5F81     ldsh    r1,[r0,r6]    ;读取数值                          
08304534 480D     ldr     r0,=7FFFh                               
08304536 4281     cmp     r1,r0         ;比较数据是否是7FFF                          
08304538 D101     bne     @@Pass1:                                
0830453A 882C     ldrh    r4,[r5]       ;数据如果是7FFF则读取最初始的数据                          
0830453C 2300     mov     r3,0h         ;并把R3归0

@@Pass1:                                  
0830453E 1C58     add     r0,r3,1       ;767的值加1                          
08304540 4661     mov     r1,r12                                  
08304542 7008     strb    r0,[r1]       ;再写入                          
08304544 8850     ldrh    r0,[r2,2h]    ;读取Y坐标                          
08304546 1900     add     r0,r0,r4      ;加上读取的数值                          
08304548 8050     strh    r0,[r2,2h]    ;再写入                          
0830454A 1C11     mov     r1,r2                                   
0830454C 312D     add     r1,2Dh                                  
0830454E 7808     ldrb    r0,[r1]       ;读取765的值                          
08304550 3801     sub     r0,1h         ;减1再写入                          
08304552 7008     strb    r0,[r1]                                 
08304554 0600     lsl     r0,r0,18h                               
08304556 2800     cmp     r0,0h         ;比较如果765的值不为0则结束                          
08304558 D102     bne     @@end                                
0830455A 3909     sub     r1,9h         ;为0则pose写入1Bh                          
0830455C 201B     mov     r0,1Bh        ;pose写入1Bh                            
0830455E 7008     strb    r0,[r1]

@@end:                                 
08304560 BC70     pop     r4-r6                                   
08304562 BC01     pop     r0                                      
08304564 4700     bx      r0                                      


;pose 1Bh                               
08304570 480B     ldr     r0,=3000738h                            
08304572 4684     mov     r12,r0                                  
08304574 4661     mov     r1,r12                                  
08304576 3124     add     r1,24h                                  
08304578 2200     mov     r2,0h                                   
0830457A 201C     mov     r0,1Ch                                  
0830457C 7008     strb    r0,[r1]      ;pose写入1c                            
0830457E 2300     mov     r3,0h                                   
08304580 2096     mov     r0,96h                                  
08304582 0040     lsl     r0,r0,1h     ;12ch                            
08304584 4661     mov     r1,r12                                  
08304586 80C8     strh    r0,[r1,6h]   ;12c写入备份Y坐标                           
08304588 810A     strh    r2,[r1,8h]   ;0写入备份X坐标                           
0830458A 4660     mov     r0,r12                                  
0830458C 302D     add     r0,2Dh       ;765归0                           
0830458E 7003     strb    r3,[r0]                                 
08304590 3001     add     r0,1h                                   
08304592 2101     mov     r1,1h                                   
08304594 7001     strb    r1,[r0]      ;766写入1                           
08304596 3802     sub     r0,2h                                   
08304598 7003     strb    r3,[r0]      ;764归零                           
0830459A 3003     add     r0,3h                                   
0830459C 7001     strb    r1,[r0]      ;767写入1                           
0830459E 4770     bx      r14                                     


;pose 写入1c                             
083045A4 B500     push    r14                                     
083045A6 B081     add     sp,-4h                                  
083045A8 4804     ldr     r0,=30013D4h                            
083045AA 8A83     ldrh    r3,[r0,14h]  ;读取人物Y坐标                           
083045AC 8A42     ldrh    r2,[r0,12h]  ;读取人物X坐标                           
083045AE 4904     ldr     r1,=3000738h                            
083045B0 8908     ldrh    r0,[r1,8h]   ;读取X备份坐标                           
083045B2 2801     cmp     r0,1h                                   
083045B4 D006     beq     @@X740=1                               
083045B6 2803     cmp     r0,3h                                   
083045B8 D011     beq     @@X740=3                               
083045BA E021     b       @@Other                                

@@X740=1:                  ;决定了            
083045C4 1C18     mov     r0,r3       ;人物Y坐标                            
083045C6 3848     sub     r0,48h      ;向上48h                            
083045C8 0400     lsl     r0,r0,10h                               
083045CA 0C03     lsr     r3,r0,10h                               
083045CC 8809     ldrh    r1,[r1]                                 
083045CE 2080     mov     r0,80h                                  
083045D0 0080     lsl     r0,r0,2h    ;200h                            
083045D2 4008     and     r0,r1       ;and 取向                            
083045D4 2800     cmp     r0,0h                                   
083045D6 D10F     bne     @@@@Pass                                
083045D8 1C10     mov     r0,r2                                   
083045DA 3848     sub     r0,48h      ;人物X坐标向左48h                            
083045DC E00E     b       @@Peer 

@@X740=3:                               
083045DE 1C18     mov     r0,r3       ;人物Y坐标向下48h                            
083045E0 3048     add     r0,48h                                  
083045E2 0400     lsl     r0,r0,10h                               
083045E4 0C03     lsr     r3,r0,10h                               
083045E6 8809     ldrh    r1,[r1]                                 
083045E8 2080     mov     r0,80h                                  
083045EA 0080     lsl     r0,r0,2h    ;200hand 取向                             
083045EC 4008     and     r0,r1                                   
083045EE 2800     cmp     r0,0h                                   
083045F0 D002     beq     @@Pass                                
083045F2 1C10     mov     r0,r2       ;人物X坐标向左48h                             
083045F4 3848     sub     r0,48h                                  
083045F6 E001     b       @@Peer 

@@@@Pass:                               
083045F8 1C10     mov     r0,r2                                   
083045FA 3048     add     r0,48h      ;人物X坐标向左48h

@@Peer:                                  
083045FC 0400     lsl     r0,r0,10h                               
083045FE 0C02     lsr     r2,r0,10h

@@Other:                               
08304600 2002     mov     r0,2h                                   
08304602 9000     str     r0,[sp]    ;SP写入2                              
08304604 1C18     mov     r0,r3      ;人物Y坐标                             
08304606 1C11     mov     r1,r2      ;人物X坐标                             
08304608 2210     mov     r2,10h                                  
0830460A 2318     mov     r3,18h                                  
0830460C F50CF99A bl      8010944h                                
08304610 4906     ldr     r1,=3000738h                            
08304612 88C8     ldrh    r0,[r1,6h] ;73e的值减1再写入                             
08304614 3801     sub     r0,1h                                   
08304616 80C8     strh    r0,[r1,6h]                              
08304618 0400     lsl     r0,r0,10h                               
0830461A 2800     cmp     r0,0h                                   
0830461C D102     bne     @@end                               
0830461E 3124     add     r1,24h                                  
08304620 201E     mov     r0,1Eh                                  
08304622 7008     strb    r0,[r1]

@@end:                                 
08304624 B001     add     sp,4h                                   
08304626 BC01     pop     r0                                      
08304628 4700     bx      r0                                      

;pose 1E                     
08304630 B510     push    r4,r14                                  
08304632 480A     ldr     r0,=3000738h                            
08304634 1C03     mov     r3,r0                                   
08304636 332E     add     r3,2Eh                                  
08304638 781A     ldrb    r2,[r3]   ;读取766的值                               
0830463A 1C04     mov     r4,r0                                   
0830463C 2AC7     cmp     r2,0C7h   ;大于C7的话                              
0830463E D801     bhi     8304644h  ;跳转                              
08304640 1C50     add     r0,r2,1   ;加1再写入                              
08304642 7018     strb    r0,[r3] 

@@PassAdd:                                
08304644 7818     ldrb    r0,[r3]   ;读取766的值                               
08304646 08C2     lsr     r2,r0,3h  ;除以8                              
08304648 8821     ldrh    r1,[r4]   ;读取取向                              
0830464A 2080     mov     r0,80h                                  
0830464C 0080     lsl     r0,r0,2h                                
0830464E 4008     and     r0,r1     ;200 and 取向                              
08304650 2800     cmp     r0,0h                                   
08304652 D005     beq     @@FaceLeft                                
08304654 88A0     ldrh    r0,[r4,4h] ;x坐标                             
08304656 1880     add     r0,r0,r2   ;加上766除以8的值为速度                             
08304658 E004     b       @@Peer                                


@@FaceLeft:                              
08304660 88A0     ldrh    r0,[r4,4h] ;X坐标                             
08304662 1A80     sub     r0,r0,r2   ;减去速度再写入 

@@Peer:                            
08304664 80A0     strh    r0,[r4,4h]                              
08304666 1C21     mov     r1,r4                                   
08304668 312F     add     r1,2Fh                                  
0830466A 7808     ldrb    r0,[r1]    ;读取767的值                              
0830466C 28C7     cmp     r0,0C7h                                 
0830466E D801     bhi     @@PassAdd                                
08304670 3001     add     r0,1h      ;767加1再写入                             
08304672 7008     strb    r0,[r1] 

@@PassAdd:                                
08304674 7808     ldrb    r0,[r1]    ;767的值除以8                             
08304676 08C2     lsr     r2,r0,3h                                
08304678 8821     ldrh    r1,[r4]                                 
0830467A 2080     mov     r0,80h                                  
0830467C 00C0     lsl     r0,r0,3h                                
0830467E 4008     and     r0,r1      ;400 and 取向                              
08304680 2800     cmp     r0,0h                                   
08304682 D002     beq     @@WillUp                                
08304684 8860     ldrh    r0,[r4,2h]                              
08304686 1880     add     r0,r0,r2                                
08304688 E001     b       @@Peer1

@@WillUp:                                
0830468A 8860     ldrh    r0,[r4,2h]                              
0830468C 1A80     sub     r0,r0,r2   

@@Peer1:                             
0830468E 8060     strh    r0,[r4,2h] ;写入新Y坐标                             
08304690 8821     ldrh    r1,[r4]    ;读取取向                             
08304692 2002     mov     r0,2h      ;and 2                             
08304694 4008     and     r0,r1                                   
08304696 0400     lsl     r0,r0,10h                               
08304698 0C00     lsr     r0,r0,10h                               
0830469A 2800     cmp     r0,0h                                   
0830469C D100     bne     @@end      ;仍在视野内则结束                           
0830469E 8020     strh    r0,[r4]    ;离开视野则死亡

@@end:                                
083046A0 BC10     pop     r4                                      
083046A2 BC01     pop     r0                                      
083046A4 4700     bx      r0                                      


;主程序
083046A6 B500     push    r14                                     
083046A8 B081     add     sp,-4h                                  
083046AA 4806     ldr     r0,=3000738h                            
083046AC 1C02     mov     r2,r0                                   
083046AE 3024     add     r0,24h                                  
083046B0 7800     ldrb    r0,[r0]                                 
083046B2 2820     cmp     r0,20h                                  
083046B4 D900     bls     83046B8h                                
083046B6 E077     b       83047A8h                                
083046B8 0080     lsl     r0,r0,2h                                
083046BA 4903     ldr     r1,=83046CCh                            
083046BC 1840     add     r0,r0,r1                                
083046BE 6800     ldr     r0,[r0]                                 
083046C0 4687     mov     r15,r0                                  
                               
PoseTable:
    .word 8304748h  ;00
	.word 830475ch  ;01
	.word 8304764h  ;02
	.word 83047bch .word 83047bch .word 83047bch .word 83047bch
	.word 83047bch .word 83047bch .word 83047bch .word 83047bch
	.word 83047bch .word 83047bch .word 83047bch .word 83047bch
	.word 83047bch .word 83047bch .word 83047bch .word 83047bch
	.word 83047bch .word 83047bch .word 83047bch .word 83047bch
	.word 8304770h  ;17h
	.word 8304778h  ;18h
	.word 8304784h  ;19h
	.word 830478ch  ;1ah
	.word 8304798h  ;1bh
	.word 830479ch  ;1ch
	.word 83047bch
	.word 83047a2h  ;1eh

;pose 0h	
08304748 F7FFFE2A bl      83043A0h                                
0830474C 4901     ldr     r1,=3000738h                            
0830474E 4802     ldr     r0,=8304C18h                            
08304750 6188     str     r0,[r1,18h]                             
08304752 E033     b       83047BCh                                

;pose 1                           
0830475C 4803     ldr     r0,=8304C18h                            
0830475E 6190     str     r0,[r2,18h]                             
08304760 F7FFFE6A bl      8304438h  

;pose 2                              
08304764 F7FFFE74 bl      8304450h                                
08304768 E028     b       83047BCh                                

;pose 17                              
08304770 4803     ldr     r0,=8304C40h                            
08304772 6190     str     r0,[r2,18h]                             
08304774 F7FFFE84 bl      8304480h 

;pose 18                               
08304778 F7FFFEA0 bl      83044BCh                                
0830477C E01E     b       83047BCh                                

;pose 19                             
08304784 4803     ldr     r0,=8304C78h                            
08304786 6190     str     r0,[r2,18h]                             
08304788 F7FFFEA6 bl      83044D8h 

;pose 1a                               
0830478C F7FFFEB8 bl      8304500h                                
08304790 E014     b       83047BCh                                

;pose 1b                              
08304798 F7FFFEEA bl      8304570h  

;pose 1C                              
0830479C F7FFFF02 bl      83045A4h                                
083047A0 E00C     b       83047BCh

;pose 1E                                
083047A2 F7FFFF45 bl      8304630h                                
083047A6 E009     b       83047BCh                                
083047A8 4806     ldr     r0,=3000738h                            
083047AA 8841     ldrh    r1,[r0,2h]                              
083047AC 3920     sub     r1,20h                                  
083047AE 8882     ldrh    r2,[r0,4h]                              
083047B0 2020     mov     r0,20h                                  
083047B2 9000     str     r0,[sp]                                 
083047B4 2000     mov     r0,0h                                   
083047B6 2301     mov     r3,1h                                   
083047B8 F50CFC64 bl      8011084h                                
083047BC B001     add     sp,4h                                   
083047BE BC01     pop     r0                                      
083047C0 4700     bx      r0  


                                    
083047C2 0000     lsl     r0,r0,0h                                
083047C4 0738     lsl     r0,r7,1Ch                               
083047C6 0300     lsl     r0,r0,0Ch                               
083047C8 0010     lsl     r0,r2,0h                                
083047CA 0008     lsl     r0,r1,0h                                
083047CC 0000     lsl     r0,r0,0h                                
083047CE 3300     add     r3,0h                                   
083047D0 0033     lsl     r3,r6,0h                                
083047D2 4333     orr     r3,r6                                   
083047D4 0054     lsl     r4,r2,1h                                
083047D6 2330     mov     r3,30h                                  
083047D8 0002     lsl     r2,r0,0h                                
083047DA 2430     mov     r4,30h                                  
083047DC 0002     lsl     r2,r0,0h                                
083047DE 3300     add     r3,0h                                   
083047E0 0000     lsl     r0,r0,0h                                
083047E2 4355     mul     r5,r2                                   
083047E4 B000     add     sp,0h                                   
083047E6 0024     lsl     r4,r4,0h                                
083047E8 0043     lsl     r3,r0,1h                                
083047EA 33A5     add     r3,0A5h                                 
083047EC 0043     lsl     r3,r0,1h                                
083047EE 2372     mov     r3,72h                                  
083047F0 3328     add     r3,28h                                  
083047F2 0044     lsl     r4,r0,1h                                
083047F4 5510     strb    r0,[r2,r4]                              
083047F6 0400     lsl     r0,r0,10h                               
083047F8 5500     strb    r0,[r0,r4]                              
083047FA 0004     lsl     r4,r0,0h                                
083047FC 0000     lsl     r0,r0,0h                                
083047FE 0450     lsl     r0,r2,11h                               
08304800 0055     lsl     r5,r2,1h                                
08304802 4500     cmp_??? r0,r0                                   
08304804 4202     tst     r2,r0                                   
08304806 000B     lsl     r3,r1,0h                                
08304808 3445     add     r4,45h                                  
0830480A 005A     lsl     r2,r3,1h                                
0830480C 2707     mov     r7,7h                                   
0830480E 0020     lsl     r0,r4,0h                                
08304810 F045     ????                                            
08304812 003F     lsl     r7,r7,0h                                
08304814 4344     mul     r4,r0                                   
08304816 A000     add     r0,=8304818h                            
08304818 2305     mov     r3,5h                                   
0830481A 0043     lsl     r3,r0,1h                                
0830481C 2274     mov     r2,74h                                  
0830481E 3F00     sub     r7,0h                                   
08304820 D022     beq     8304868h                                
08304822 803F     strh    r7,[r7]                                 
08304824 4E00     ldr     r6,=2345000Ah                           
08304826 3245     add     r2,45h                                  
08304828 000A     lsl     r2,r1,0h                                
0830482A 2345     mov     r3,45h                                  
0830482C F547     ????                                            
0830482E 0700     lsl     r0,r0,1Ch                               
08304830 3FF0     sub     r7,0F0h                                 
08304832 7F10     ldrb    r0,[r2,1Ch]                             
08304834 7700     strb    r0,[r0,1Ch]                             
08304836 00A0     lsl     r0,r4,2h                                
08304838 733B     strb    r3,[r7,0Ch]                             
0830483A 3F00     sub     r7,0h                                   
0830483C 6264     str     r4,[r4,24h]                             
0830483E 3FE0     sub     r7,0E0h                                 
08304840 9F00     ldr     r7,[sp]                                 
08304842 2245     mov     r2,45h                                  
08304844 3F00     sub     r7,0h                                   
08304846 3722     add     r7,22h                                  
08304848 00A4     lsl     r4,r4,2h                                
0830484A 2607     mov     r6,7h                                   
0830484C 7FE0     ldrb    r0,[r4,1Fh]                             
0830484E 3355     add     r3,55h                                  
08304850 BB60     ????                                            
08304852 1110     asr     r0,r2,4h                                
08304854 00AC     lsl     r4,r5,2h                                
08304856 1403     asr     r3,r0,10h                               
08304858 BF90     ????                                            
0830485A 0055     lsl     r5,r2,1h                                
0830485C 50BF     str     r7,[r7,r2]                              
0830485E 11BB     asr     r3,r7,6h                                
08304860 1801     add     r1,r0,r0                                
08304862 4500     cmp_??? r0,r0                                   
08304864 0041     lsl     r1,r0,1h                                
08304866 8003     strh    r3,[r0]                                 
08304868 55FF     strb    r7,[r7,r7]                              
0830486A 2430     mov     r4,30h                                  
0830486C B214     ????                                            
0830486E 3324     add     r3,24h                                  
08304870 3B60     sub     r3,60h                                  
08304872 0040     lsl     r0,r0,1h                                
08304874 40C7     lsr     r7,r0                                   
08304876 A143     add     r1,=8304984h                            
08304878 FF50     bl      lr+0EA0h                                
0830487A 0055     lsl     r5,r2,1h                                
0830487C 42FF     cmn     r7,r7                                   
0830487E 500B     str     r3,[r1,r0]                              
08304880 5004     str     r4,[r0,r0]                              
08304882 3D3B     sub     r5,3Bh                                  
08304884 0444     lsl     r4,r0,11h                               
08304886 0301     lsl     r1,r0,0Ch                               
08304888 0300     lsl     r0,r0,0Ch                               
0830488A 3FF0     sub     r7,0F0h                                 
0830488C 3F60     sub     r7,60h                                  
0830488E 0014     lsl     r4,r2,0h                                
08304890 7643     strb    r3,[r0,19h]                             
08304892 F046     ????                                            
08304894 403F     and     r7,r7                                   
08304896 007B     lsl     r3,r7,1h                                
08304898 643F     str     r7,[r7,40h]                             
0830489A 3FF0     sub     r7,0F0h                                 
0830489C 7F80     ldrb    r0,[r0,1Eh]                             
0830489E B241     ????                                            
083048A0 BF00     ????                                            
083048A2 6064     str     r4,[r4,4h]                              
083048A4 D0BF     beq     8304826h                                
083048A6 117F     asr     r7,r7,5h                                
083048A8 0014     lsl     r4,r2,0h                                
083048AA 46BF     mov     r15,r7                                  
083048AC 11FF     asr     r7,r7,7h                                
083048AE F07F     ????                                            
083048B0 F001     ????                                            
083048B2 F013     ????                                            
083048B4 F025     ????                                            
083048B6 F037     ????                                            
083048B8 F049     ????                                            
083048BA F05BFF6D bl      8360798h                                
083048BE 7FF0     ldrb    r0,[r6,1Fh]                             
083048C0 91F0     str     r1,[sp,3C0h]                            
083048C2 A3F0     add     r3,=8304C84h                            
083048C4 B5F0     push    r4-r7,r14                               
083048C6 C7F0     stmia   [r7]!,r4-r7                             
083048C8 D9F0     bls     83048ACh                                
083048CA EBF0     ????                                            
083048CC FDF0     bl      lr+0BE0h                                
083048CE F1FC     ????                                            
083048D0 F10F     ????                                            
083048D2 F121     ????                                            
083048D4 F133     ????                                            
083048D6 C145     stmia   [r1]!,r0,r2,r6                          
083048D8 0257     lsl     r7,r2,9h                                
083048DA 00FB     lsl     r3,r7,3h                                
083048DC 0852     lsr     r2,r2,1h                                
083048DE 0000     lsl     r0,r0,0h                                
083048E0 2240     mov     r2,40h                                  
083048E2 0300     lsl     r0,r0,0Ch                               
083048E4 00A2     lsl     r2,r4,2h                                
083048E6 7B00     ldrb    r0,[r0,0Ch]                             
083048E8 10A0     asr     r0,r4,2h                                
083048EA 0003     lsl     r3,r0,0h                                
083048EC 020F     lsl     r7,r1,8h                                
083048EE 3116     add     r1,16h                                  
083048F0 4080     lsl     r0,r0                                   
083048F2 2003     mov     r0,3h                                   
083048F4 1B40     sub     r0,r0,r5                                
083048F6 2005     mov     r0,5h                                   
083048F8 005A     lsl     r2,r3,1h                                
083048FA 2500     mov     r5,0h                                   
083048FC 0350     lsl     r0,r2,0Dh                               
083048FE 2055     mov     r0,55h                                  
08304900 2219     mov     r2,19h                                  
08304902 0524     lsl     r4,r4,14h                               
08304904 0320     lsl     r0,r4,0Ch                               
08304906 5240     strh    r0,[r0,r1]                              
08304908 205A     mov     r0,5Ah                                  
0830490A 5003     str     r3,[r0,r0]                              
0830490C A25E     add     r2,=8304A88h                            
0830490E 0310     lsl     r0,r2,0Ch                               
08304910 20A5     mov     r0,0A5h                                 
08304912 8003     strh    r3,[r0]                                 
08304914 203F     mov     r0,3Fh                                  
08304916 3029     add     r0,29h                                  
08304918 5063     str     r3,[r4,r1]                              
0830491A 00A4     lsl     r4,r4,2h                                
0830491C 256B     mov     r5,6Bh                                  
0830491E 6700     str     r0,[r0,70h]                             
08304920 A525     add     r5,=83049B8h                            
08304922 7840     ldrb    r0,[r0,1h]                              
08304924 2200     mov     r2,0h                                   
08304926 0090     lsl     r0,r2,2h                                
08304928 5242     strh    r2,[r0,r1]                              
0830492A 0002     lsl     r2,r0,0h                                
0830492C 5484     strb    r4,[r0,r2]                              
0830492E 0000     lsl     r0,r0,0h                                
08304930 00A2     lsl     r2,r4,2h                                
08304932 043A     lsl     r2,r7,10h                               
08304934 A200     add     r2,=8304938h                            
08304936 05A5     lsl     r5,r4,16h                               
08304938 5200     strh    r0,[r0,r0]                              
0830493A A02C     add     r0,=83049ECh                            
0830493C 800A     strh    r2,[r1]                                 
0830493E 403F     and     r7,r7                                   
08304940 3B00     sub     r3,0h                                   
08304942 3300     add     r3,0h                                   
08304944 4250     neg     r0,r2                                   
08304946 AA40     add     r2,sp,100h                              
08304948 3600     add     r6,0h                                   
0830494A 50AA     str     r2,[r5,r2]                              
0830494C AA52     add     r2,sp,148h                              
0830494E 502A     str     r2,[r5,r0]                              
08304950 020C     lsl     r4,r1,8h                                
08304952 2500     mov     r5,0h                                   
08304954 0340     lsl     r0,r0,0Dh                               
08304956 03B5     lsl     r5,r6,0Eh                               
08304958 00D6     lsl     r6,r2,3h                                
0830495A 9022     str     r0,[sp,88h]                             
0830495C BD00     pop     r15                                     
0830495E 2552     mov     r5,52h                                  
08304960 3300     add     r3,0h                                   
08304962 525A     strh    r2,[r3,r1]                              
08304964 A200     add     r2,=8304968h                            
08304966 AA00     add     r2,sp,0h                                
08304968 0025     lsl     r5,r4,0h                                
0830496A AAA5     add     r2,sp,294h                              
0830496C 002A     lsl     r2,r5,0h                                
0830496E 01AA     lsl     r2,r5,6h                                
08304970 AAAA     add     r2,sp,2A8h                              
08304972 4300     orr     r0,r0                                   
08304974 A300     add     r3,=8304978h                            
08304976 0353     lsl     r3,r2,0Dh                               
08304978 82EB     strh    r3,[r5,16h]                             
0830497A EF03     ????                                            
0830497C 45B0     cmp     r8,r6                                   
0830497E 0043     lsl     r3,r0,1h                                
08304980 0300     lsl     r0,r0,0Ch                               
08304982 0033     lsl     r3,r6,0h                                
08304984 5140     str     r0,[r0,r5]                              
08304986 0700     lsl     r0,r0,1Ch                               
08304988 2245     mov     r2,45h                                  
0830498A 2222     mov     r2,22h                                  
0830498C 6666     str     r6,[r4,64h]                             
0830498E 6600     str     r0,[r0,60h]                             
08304990 7766     strb    r6,[r4,1Dh]                             
08304992 3A45     sub     r2,45h                                  
08304994 4500     cmp_??? r0,r0                                   
08304996 AB43     add     r3,sp,10Ch                              
08304998 EB03     ????                                            
0830499A 0354     lsl     r4,r2,0Dh                               
0830499C 11F3     asr     r3,r6,7h                                
0830499E FB03     bl      lr+606h                                 
083049A0 0415     lsl     r5,r2,10h                               
083049A2 001F     lsl     r7,r3,0h                                
083049A4 0082     lsl     r2,r0,2h                                
083049A6 6655     str     r5,[r2,64h]                             
083049A8 7776     strb    r6,[r6,1Dh]                             
083049AA 77AA     strb    r2,[r5,1Eh]                             
083049AC AAA7     add     r2,sp,29Ch                              
083049AE AA42     add     r2,sp,108h                              
083049B0 2304     mov     r3,4h                                   
083049B2 4342     mul     r2,r0                                   
083049B4 A400     add     r4,=83049B8h                            
083049B6 EF03     ????                                            
083049B8 55B0     strb    r0,[r6,r6]                              
083049BA 4034     and     r4,r6                                   
083049BC 413F     asr     r7,r7                                   
083049BE 4700     bx      r0                                      
083049C0 5034     str     r4,[r6,r0]                              
083049C2 343F     add     r4,3Fh                                  
083049C4 2304     mov     r3,4h                                   
083049C6 3236     add     r2,36h                                  
083049C8 004A     lsl     r2,r1,1h                                
083049CA 4043     eor     r3,r0                                   
083049CC 143F     asr     r7,r7,10h                               
083049CE 5F24     ldsh    r4,[r4,r4]                              
083049D0 3F90     sub     r7,90h                                  
083049D2 7562     strb    r2,[r4,15h]                             
083049D4 3332     add     r3,32h                                  
083049D6 14EB     asr     r3,r5,13h                               
083049D8 2033     mov     r0,33h                                  
083049DA 317F     add     r1,7Fh                                  
083049DC 8700     strh    r0,[r0,38h]                             
083049DE 5023     str     r3,[r4,r0]                              
083049E0 7A7F     ldrb    r7,[r7,9h]                              
083049E2 0323     lsl     r3,r4,0Ch                               
083049E4 13E3     asr     r3,r4,0Fh                               
083049E6 14EB     asr     r3,r5,13h                               
083049E8 1033     asr     r3,r6,20h                               
083049EA 137F     asr     r7,r7,0Dh                               
083049EC 9F04     ldr     r7,[sp,10h]                             
083049EE FA32     bl      lr+464h                                 
083049F0 7FA0     ldrb    r0,[r4,1Eh]                             
083049F2 BFF0     ????                                            
083049F4 BFF0     ????                                            
083049F6 BFF0     ????                                            
083049F8 BF70     ????                                            
083049FA 0310     lsl     r0,r2,0Ch                               
083049FC 13A7     asr     r7,r4,0Eh                               
083049FE 04F3     lsl     r3,r6,13h                               
08304A00 A12B     add     r1,=8304AB0h                            
08304A02 6003     str     r3,[r0]                                 
08304A04 14FF     asr     r7,r7,13h                               
08304A06 1123     asr     r3,r4,4h                                
08304A08 A131     add     r1,=8304AD0h                            
08304A0A C003     stmia   [r0]!,r0,r1                             
08304A0C FDFF     bl      lr+0BFEh                                
08304A0E E713     b       8304838h                                
08304A10 3FF0     sub     r7,0F0h                                 
08304A12 3F60     sub     r7,60h                                  
08304A14 2704     mov     r7,4h                                   
08304A16 3FF0     sub     r7,0F0h                                 
08304A18 3F91     sub     r7,91h                                  
08304A1A 0141     lsl     r1,r0,5h                                
08304A1C 752F     strb    r7,[r5,14h]                             
08304A1E 0113     lsl     r3,r2,4h                                
08304A20 F033     ????                                            
08304A22 117F     asr     r7,r7,5h                                
08304A24 147F     asr     r7,r7,11h                               
08304A26 E703     b       8304830h                                
08304A28 F014FF7F bl      831992Ah                                
08304A2C 7F61     ldrb    r1,[r4,1Dh]                             
08304A2E FFF3     bl      lr+0FE6h                                
08304A30 11F4     asr     r4,r6,7h                                
08304A32 23F4     mov     r3,0F4h                                 
08304A34 35F4     add     r5,0F4h                                 
08304A36 47F4     blx (ARMv5) r12 ???,r14                         
08304A38 59F4     ldr     r4,[r6,r7]                              
08304A3A 6BF4     ldr     r4,[r6,3Ch]                             
08304A3C F4FF     ????                                            
08304A3E F47D     ????                                            
08304A40 F48F     ????                                            
08304A42 F4A1     ????                                            
08304A44 F4B3     ????                                            
08304A46 F4C5     ????                                            
08304A48 F4D7     ????                                            
08304A4A F4E9FFFB bl      7FEEA44h                                
08304A4E 0DF5     lsr     r5,r6,17h                               
08304A50 1FF5     sub     r5,r6,7                                 
08304A52 31F5     add     r1,0F5h                                 
08304A54 4365     mul     r5,r4                                   
08304A56 4E13     ldr     r6,=42E0h                               
08304A58 5111     str     r1,[r2,r4]                              
08304A5A 5663     ldsb    r3,[r4,r1]                              
08304A5C 1FF0     sub     r0,r6,7                                 
08304A5E 20A6     mov     r0,0A6h                                 
08304A60 5A1F     ldrh    r7,[r3,r0]                              
08304A62 7703     strb    r3,[r0,1Ch]                             
08304A64 A00A     add     r0,=8304A90h                            
08304A66 7A45     ldrb    r5,[r0,9h]                              
08304A68 E303     b       8305072h                                
08304A6A 5E00     ldsh    r0,[r0,r0]                              
08304A6C 0350     lsl     r0,r2,0Dh                               
08304A6E 50F3     str     r3,[r6,r3]                              
08304A70 8C13     ldrh    r3,[r2,20h]                             
08304A72 E803     ????                                            
08304A74 91B5     str     r1,[sp,2D4h]                            
08304A76 E723     b       83048C0h                                
08304A78 BB52     ????                                            
08304A7A A703     add     r7,=8304A88h                            
08304A7C 1055     asr     r5,r2,1h                                
08304A7E F503     ????                                            
08304A80 03AD     lsl     r5,r5,0Eh                               
08304A82 AAEA     add     r2,sp,3A8h                              
08304A84 EE23     ????                                            
08304A86 0320     lsl     r0,r4,0Ch                               
08304A88 03AF     lsl     r7,r5,0Eh                               
08304A8A 50E0     str     r0,[r4,r3]                              
08304A8C D1B5     bne     83049FAh                                
08304A8E 7305     strb    r5,[r0,0Ch]                             
08304A90 F5E3     ????                                            
08304A92 40EA     lsr     r2,r5                                   
08304A94 1080     asr     r0,r0,2h                                
08304A96 DC66     bgt     8304B66h                                
08304A98 07F6     lsl     r6,r6,1Fh                               
08304A9A 1936     add     r6,r6,r4                                
08304A9C 20AA     mov     r0,0AAh                                 
08304A9E F6D0     ????                                            
08304AA0 5625     ldsb    r5,[r4,r0]                              
08304AA2 0037     lsl     r7,r6,0h                                
08304AA4 42E0     cmn     r0,r4                                   
08304AA6 0000     lsl     r0,r0,0h                                
08304AA8 7FFF     ldrb    r7,[r7,1Fh]                             
08304AAA 56B5     ldsb    r5,[r6,r2]                              
08304AAC 39CE     sub     r1,0CEh                                 
08304AAE 2108     mov     r1,8h                                   
08304AB0 0BDE     lsr     r6,r3,0Fh                               
08304AB2 069F     lsl     r7,r3,1Ah                               
08304AB4 03E0     lsl     r0,r4,0Fh                               
08304AB6 0222     lsl     r2,r4,8h                                
08304AB8 381D     sub     r0,1Dh                                  
08304ABA 0810     lsr     r0,r2,20h                               
08304ABC 7FAA     ldrb    r2,[r5,1Eh]                             
08304ABE 7AE4     ldrb    r4,[r4,0Bh]                             
08304AC0 6D63     ldr     r3,[r4,54h]                             
08304AC2 6000     str     r0,[r0]                                 
08304AC4 0001     lsl     r1,r0,0h                                
08304AC6 00F0     lsl     r0,r6,3h                                
08304AC8 41F8     ror     r0,r7                                   
08304ACA 8200     strh    r0,[r0,10h]                             
08304ACC 0001     lsl     r1,r0,0h                                
08304ACE 00F0     lsl     r0,r6,3h                                
08304AD0 41F8     ror     r0,r7                                   
08304AD2 8202     strh    r2,[r0,10h]                             
08304AD4 0001     lsl     r1,r0,0h                                
08304AD6 00F0     lsl     r0,r6,3h                                
08304AD8 41F8     ror     r0,r7                                   
08304ADA 8204     strh    r4,[r0,10h]                             
08304ADC 0001     lsl     r1,r0,0h                                
08304ADE 00F0     lsl     r0,r6,3h                                
08304AE0 41F8     ror     r0,r7                                   
08304AE2 8202     strh    r2,[r0,10h]                             
08304AE4 0003     lsl     r3,r0,0h                                
08304AE6 00F0     lsl     r0,r6,3h                                
08304AE8 41F8     ror     r0,r7                                   
08304AEA 8206     strh    r6,[r0,10h]                             
08304AEC 00F2     lsl     r2,r6,3h                                
08304AEE 01F1     lsl     r1,r6,7h                                
08304AF0 8219     strh    r1,[r3,10h]                             
08304AF2 00F2     lsl     r2,r6,3h                                
08304AF4 1007     asr     r7,r0,20h                               
08304AF6 8219     strh    r1,[r3,10h]                             
08304AF8 0005     lsl     r5,r0,0h                                
08304AFA 00FA     lsl     r2,r7,3h                                
08304AFC 01F8     lsl     r0,r7,7h                                
08304AFE 8238     strh    r0,[r7,10h]                             
08304B00 00FA     lsl     r2,r7,3h                                
08304B02 1000     asr     r0,r0,20h                               
08304B04 8238     strh    r0,[r7,10h]                             
08304B06 00F0     lsl     r0,r6,3h                                
08304B08 41F8     ror     r0,r7                                   
08304B0A 8208     strh    r0,[r1,10h]                             
08304B0C 80F1     strh    r1,[r6,6h]                              
08304B0E 01F1     lsl     r1,r6,7h                                
08304B10 821A     strh    r2,[r3,10h]                             
08304B12 80F1     strh    r1,[r6,6h]                              
08304B14 1007     asr     r7,r0,20h                               
08304B16 821A     strh    r2,[r3,10h]                             
08304B18 0005     lsl     r5,r0,0h                                
08304B1A 00FA     lsl     r2,r7,3h                                
08304B1C 01F8     lsl     r0,r7,7h                                
08304B1E 8239     strh    r1,[r7,10h]                             
08304B20 00FA     lsl     r2,r7,3h                                
08304B22 1000     asr     r0,r0,20h                               
08304B24 8239     strh    r1,[r7,10h]                             
08304B26 00F0     lsl     r0,r6,3h                                
08304B28 41F8     ror     r0,r7                                   
08304B2A 820A     strh    r2,[r1,10h]                             
08304B2C 80EF     strh    r7,[r5,6h]                              
08304B2E 01F3     lsl     r3,r6,7h                                
08304B30 821B     strh    r3,[r3,10h]                             
08304B32 80EF     strh    r7,[r5,6h]                              
08304B34 1005     asr     r5,r0,20h                               
08304B36 821B     strh    r3,[r3,10h]                             
08304B38 0005     lsl     r5,r0,0h                                
08304B3A 00FA     lsl     r2,r7,3h                                
08304B3C 01F8     lsl     r0,r7,7h                                
08304B3E 8239     strh    r1,[r7,10h]                             
08304B40 00FA     lsl     r2,r7,3h                                
08304B42 1000     asr     r0,r0,20h                               
08304B44 8239     strh    r1,[r7,10h]                             
08304B46 00F0     lsl     r0,r6,3h                                
08304B48 41F8     ror     r0,r7                                   
08304B4A 820A     strh    r2,[r1,10h]                             
08304B4C 80F0     strh    r0,[r6,6h]                              
08304B4E 01F2     lsl     r2,r6,7h                                
08304B50 821B     strh    r3,[r3,10h]                             
08304B52 80F0     strh    r0,[r6,6h]                              
08304B54 1006     asr     r6,r0,20h                               
08304B56 821B     strh    r3,[r3,10h]                             
08304B58 0005     lsl     r5,r0,0h                                
08304B5A 00FA     lsl     r2,r7,3h                                
08304B5C 01F8     lsl     r0,r7,7h                                
08304B5E 8239     strh    r1,[r7,10h]                             
08304B60 00FA     lsl     r2,r7,3h                                
08304B62 1000     asr     r0,r0,20h                               
08304B64 8239     strh    r1,[r7,10h]                             
08304B66 00F0     lsl     r0,r6,3h                                
08304B68 41F8     ror     r0,r7                                   
08304B6A 820A     strh    r2,[r1,10h]                             
08304B6C 00F0     lsl     r0,r6,3h                                
08304B6E 41EB     ror     r3,r5                                   
08304B70 821C     strh    r4,[r3,10h]                             
08304B72 00F0     lsl     r0,r6,3h                                
08304B74 5005     str     r5,[r0,r0]                              
08304B76 821C     strh    r4,[r3,10h]                             
08304B78 0005     lsl     r5,r0,0h                                
08304B7A 00FA     lsl     r2,r7,3h                                
08304B7C 01F8     lsl     r0,r7,7h                                
08304B7E 8239     strh    r1,[r7,10h]                             
08304B80 00FA     lsl     r2,r7,3h                                
08304B82 1000     asr     r0,r0,20h                               
08304B84 8239     strh    r1,[r7,10h]                             
08304B86 00F0     lsl     r0,r6,3h                                
08304B88 41F8     ror     r0,r7                                   
08304B8A 820A     strh    r2,[r1,10h]                             
08304B8C 00F0     lsl     r0,r6,3h                                
08304B8E 41EA     ror     r2,r5                                   
08304B90 821E     strh    r6,[r3,10h]                             
08304B92 00F0     lsl     r0,r6,3h                                
08304B94 5006     str     r6,[r0,r0]                              
08304B96 821E     strh    r6,[r3,10h]                             
08304B98 0005     lsl     r5,r0,0h                                
08304B9A 00FA     lsl     r2,r7,3h                                
08304B9C 01F8     lsl     r0,r7,7h                                
08304B9E 8239     strh    r1,[r7,10h]                             
08304BA0 00FA     lsl     r2,r7,3h                                
08304BA2 1000     asr     r0,r0,20h                               
08304BA4 8239     strh    r1,[r7,10h]                             

