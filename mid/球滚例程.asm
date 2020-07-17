080093BC B510     push    r4,r14                      
080093BE 1C04     mov     r4,r0                       
080093C0 4808     ldr     r0,=3001380h                
080093C2 8801     ldrh    r1,[r0]           ;读取即时输入          
080093C4 2201     mov     r2,1h                       
080093C6 1C10     mov     r0,r2                       
080093C8 4008     and     r0,r1                       
080093CA 2800     cmp     r0,0h                       
080093CC D00E     beq     @@NoPressJumping                   
080093CE 4806     ldr     r0,=3001530h                
080093D0 7BC1     ldrb    r1,[r0,0Fh]                 
080093D2 1C10     mov     r0,r2                       
080093D4 4008     and     r0,r1                       
080093D6 2800     cmp     r0,0h            ;检查高跳能力           
080093D8 D008     beq     @@NoPressJumping                   
080093DA 2001     mov     r0,1h                       
080093DC 7120     strb    r0,[r4,4h]       ;bounce flag写入1           
080093DE 20FE     mov     r0,0FEh          ;pose标记fe 起跳>           
080093E0 E04F     b       @@end                    
.pool

@@NoPressJumping:                   
080093EC 480B     ldr     r0,=823A554h                
080093EE 2204     mov     r2,4h                       
080093F0 5E81     ldsh    r1,[r0,r2]      ;0FF84 蹲下的上部分界            
080093F2 1C20     mov     r0,r4                       
080093F4 F7FCF9FA bl      80057ECh        ;检查是否会与砖块重合            
080093F8 0600     lsl     r0,r0,18h                   
080093FA 2800     cmp     r0,0h                       
080093FC D119     bne     @@StillBall                    
080093FE 4808     ldr     r0,=3001380h                
08009400 8801     ldrh    r1,[r0]                     
08009402 2040     mov     r0,40h                      
08009404 4008     and     r0,r1                       
08009406 2800     cmp     r0,0h          ;检查是否即时按上             
08009408 D013     beq     @@StillBall                    
0800940A 4806     ldr     r0,=3001588h                
0800940C 305B     add     r0,5Bh                      
0800940E 7800     ldrb    r0,[r0]        ;无重力在水flag             
08009410 2800     cmp     r0,0h                       
08009412 D009     beq     @@NoWaterFlag                    
08009414 2078     mov     r0,78h                      
08009416 F7F9FAFF bl      8002A18h                    
0800941A E008     b       @@Peer                   
.pool

@@NoWaterFlag:                  
08009428 2078     mov     r0,78h                      
0800942A F7F9FAF5 bl      8002A18h 

@@Peer:                   
0800942E 2013     mov     r0,13h        ;pose为球变人                
08009430 E027     b       @@end 

@@StillBall:                   
08009432 480D     ldr     r0,=300137Ch                
08009434 8802     ldrh    r2,[r0]       ;读取输入               
08009436 89E1     ldrh    r1,[r4,0Eh]   ;读取面向               
08009438 1C10     mov     r0,r2                       
0800943A 4008     and     r0,r1                       
0800943C 2800     cmp     r0,0h         ;检查是否按了前             
0800943E D017     beq     @@NoPressRun                    
08009440 4A0A     ldr     r2,=3001588h                
08009442 1C10     mov     r0,r2                       
08009444 3060     add     r0,60h                      
08009446 F2FAFEE7 bl      8304218h      ;r1为最大的X速度限制              
0800944A 7960     ldrb    r0,[r4,5h]    ;检查高速flag是否为1              
0800944C 2800     cmp     r0,0h                       
0800944E D002     beq     @@PassHighSpeedFlag                   
08009450 21A0     mov     r1,0A0h       ;高速的最大速度限制为A0              
08009452 2006     mov     r0,6h                       
08009454 7220     strb    r0,[r4,8h]    ;同时金身时间写入6

@@PassHighSpeedFlag:               
08009456 1C10     mov     r0,r2                       
08009458 305E     add     r0,5Eh                      
0800945A 2200     mov     r2,0h                       
0800945C 5E80     ldsh    r0,[r0,r2]    ;读取X加速值              
0800945E 1C22     mov     r2,r4                       
08009460 F7FEFF0A bl      8008278h                    
08009464 20FF     mov     r0,0FFh                     
08009466 E00C     b       @@end                    
.pool

@@NoPressRun:                  
08009470 2030     mov     r0,30h                      
08009472 4048     eor     r0,r1        ;30 eor 面向               
08009474 4010     and     r0,r2        ;然后相反的面向和输入and               
08009476 0400     lsl     r0,r0,10h                   
08009478 2800     cmp     r0,0h        ;是否按了相反的方向                
0800947A D001     beq     @@Peer2                    
0800947C 2001     mov     r0,1h                       
0800947E 70E0     strb    r0,[r4,3h]   ;转身flag写入1

@@Peer2:               
08009480 2011     mov     r0,11h	   ;pose为11

@@end:                    
08009482 BC10     pop     r4                          
08009484 BC02     pop     r1                          
08009486 4708     bx      r1


                          
08009488 B510     push    r4,r14                      
0800948A 1C04     mov     r4,r0                       
0800948C 2100     mov     r1,0h                       
0800948E F7FEFFF5 bl      800847Ch                    
08009492 0600     lsl     r0,r0,18h                   
08009494 0E00     lsr     r0,r0,18h                   
08009496 2802     cmp     r0,2h                       
08009498 D102     bne     80094A0h                    
0800949A 2000     mov     r0,0h                       
0800949C 7760     strb    r0,[r4,1Dh]                 
0800949E E00B     b       80094B8h                    
080094A0 2801     cmp     r0,1h                       
080094A2 D109     bne     80094B8h                    
080094A4 7F60     ldrb    r0,[r4,1Dh]                 
080094A6 2801     cmp     r0,1h                       
080094A8 D001     beq     80094AEh                    
080094AA 2805     cmp     r0,5h                       
080094AC D104     bne     80094B8h                    
080094AE 1C20     mov     r0,r4                       
080094B0 2100     mov     r1,0h                       
080094B2 2207     mov     r2,7h                       
080094B4 F7FCFEAE bl      8006214h                    
080094B8 20FF     mov     r0,0FFh                     
080094BA BC10     pop     r4                          
080094BC BC02     pop     r1                          
080094BE 4708     bx      r1                          
080094C0 B510     push    r4,r14                      
080094C2 1C04     mov     r4,r0                       
080094C4 4809     ldr     r0,=823A554h                
080094C6 2204     mov     r2,4h                       
080094C8 5E81     ldsh    r1,[r0,r2]                  
080094CA 1C20     mov     r0,r4                       
080094CC F7FCF98E bl      80057ECh                    
080094D0 0600     lsl     r0,r0,18h                   
080094D2 2800     cmp     r0,0h                       
080094D4 D112     bne     80094FCh                    
080094D6 4806     ldr     r0,=3001380h                
080094D8 8801     ldrh    r1,[r0]                     
080094DA 2001     mov     r0,1h                       
080094DC 4008     and     r0,r1                       
080094DE 2800     cmp     r0,0h                       
080094E0 D008     beq     80094F4h                    
080094E2 2001     mov     r0,1h                       
080094E4 7120     strb    r0,[r4,4h]                  
080094E6 20FE     mov     r0,0FEh                     
080094E8 E00B     b       8009502h                    
080094EA 0000     lsl     r0,r0,0h                    
080094EC A554     add     r5,=8009640h                
080094EE 0823     lsr     r3,r4,20h                   
080094F0 1380     asr     r0,r0,0Eh                   
080094F2 0300     lsl     r0,r0,0Ch                   
080094F4 2080     mov     r0,80h                      
080094F6 4008     and     r0,r1                       
080094F8 2800     cmp     r0,0h                       
080094FA D001     beq     8009500h                    
080094FC 2010     mov     r0,10h                      
080094FE 7020     strb    r0,[r4]                     
08009500 20FF     mov     r0,0FFh                     
08009502 BC10     pop     r4                          
08009504 BC02     pop     r1                          
08009506 4708     bx      r1                          
08009508 B510     push    r4,r14                      
0800950A 1C04     mov     r4,r0                       
0800950C 2100     mov     r1,0h                       
0800950E F7FEFFB5 bl      800847Ch                    
08009512 0600     lsl     r0,r0,18h                   
08009514 0E00     lsr     r0,r0,18h                   
08009516 2802     cmp     r0,2h                       
08009518 D001     beq     800951Eh                    
0800951A 20FF     mov     r0,0FFh                     
0800951C E002     b       8009524h                    
0800951E 200F     mov     r0,0Fh                      
08009520 7260     strb    r0,[r4,9h]                  
08009522 2004     mov     r0,4h                       
08009524 BC10     pop     r4                          
08009526 BC02     pop     r1                          
08009528 4708     bx      r1                          
0800952A 0000     lsl     r0,r0,0h                    
0800952C B510     push    r4,r14                      
0800952E 1C04     mov     r4,r0                       
08009530 480B     ldr     r0,=3001380h                
08009532 8801     ldrh    r1,[r0]                     
08009534 2040     mov     r0,40h                      
08009536 4008     and     r0,r1                       
08009538 2800     cmp     r0,0h                       
0800953A D01E     beq     800957Ah                    
0800953C 4809     ldr     r0,=823A554h                
0800953E 2204     mov     r2,4h                       
08009540 5E81     ldsh    r1,[r0,r2]                  
08009542 1C20     mov     r0,r4                       
08009544 F7FCF952 bl      80057ECh                    
08009548 0600     lsl     r0,r0,18h                   
0800954A 2800     cmp     r0,0h                       
0800954C D115     bne     800957Ah                    
0800954E 4806     ldr     r0,=3001588h                
08009550 305B     add     r0,5Bh                      
08009552 7800     ldrb    r0,[r0]                     
08009554 2801     cmp     r0,1h                       
08009556 D109     bne     800956Ch                    
08009558 2078     mov     r0,78h                      
0800955A F7F9FA5D bl      8002A18h                    
0800955E E008     b       8009572h                    
08009560 1380     asr     r0,r0,0Eh                   
08009562 0300     lsl     r0,r0,0Ch                   
08009564 A554     add     r5,=80096B8h                
08009566 0823     lsr     r3,r4,20h                   
08009568 1588     asr     r0,r1,16h                   
0800956A 0300     lsl     r0,r0,0Ch                   
0800956C 2078     mov     r0,78h                      
0800956E F7F9FA53 bl      8002A18h                    
08009572 200F     mov     r0,0Fh                      
08009574 F2FAFEAC bl      83042D0h                    
08009578 E040     b       80095FCh                    
0800957A 7920     ldrb    r0,[r4,4h]                  
0800957C 2800     cmp     r0,0h                       
0800957E D10D     bne     800959Ch                    
08009580 4805     ldr     r0,=300137Ch                
08009582 8800     ldrh    r0,[r0]                     
08009584 2101     mov     r1,1h                       
08009586 4001     and     r1,r0                       
08009588 2900     cmp     r1,0h                       
0800958A D10D     bne     80095A8h                    
0800958C 2218     mov     r2,18h                      
0800958E 5EA0     ldsh    r0,[r4,r2]                  
08009590 2800     cmp     r0,0h                       
08009592 DD09     ble     80095A8h                    
08009594 8321     strh    r1,[r4,18h]                 
08009596 E007     b       80095A8h                    
08009598 137C     asr     r4,r7,0Dh                   
0800959A 0300     lsl     r0,r0,0Ch                   
0800959C 2118     mov     r1,18h                      
0800959E 5E60     ldsh    r0,[r4,r1]                  
080095A0 2806     cmp     r0,6h                       
080095A2 DC01     bgt     80095A8h                    
080095A4 2000     mov     r0,0h                       
080095A6 7120     strb    r0,[r4,4h]                  
080095A8 2218     mov     r2,18h                      
080095AA 5EA0     ldsh    r0,[r4,r2]                  
080095AC 2800     cmp     r0,0h                       
080095AE DB03     blt     80095B8h                    
080095B0 2116     mov     r1,16h                      
080095B2 5E60     ldsh    r0,[r4,r1]                  
080095B4 2800     cmp     r0,0h                       
080095B6 D106     bne     80095C6h                    
080095B8 4809     ldr     r0,=300137Ch                
080095BA 8802     ldrh    r2,[r0]                     
080095BC 89E1     ldrh    r1,[r4,0Eh]                 
080095BE 1C13     mov     r3,r2                       
080095C0 400B     and     r3,r1                       
080095C2 2B00     cmp     r3,0h                       
080095C4 D010     beq     80095E8h                    
080095C6 4907     ldr     r1,=3001588h                
080095C8 1C08     mov     r0,r1                       
080095CA 3068     add     r0,68h                      
080095CC 2200     mov     r2,0h                       
080095CE 5E80     ldsh    r0,[r0,r2]                  
080095D0 316C     add     r1,6Ch                      
080095D2 2200     mov     r2,0h                       
080095D4 F2FAFDEE bl      83041B4h                    
080095D8 F7FEFE4E bl      8008278h                    
080095DC E00D     b       80095FAh                    
080095DE 0000     lsl     r0,r0,0h                    
080095E0 137C     asr     r4,r7,0Dh                   
080095E2 0300     lsl     r0,r0,0Ch                   
080095E4 1588     asr     r0,r1,16h                   
080095E6 0300     lsl     r0,r0,0Ch                   
080095E8 2030     mov     r0,30h                      
080095EA 4041     eor     r1,r0                       
080095EC 1C08     mov     r0,r1                       
080095EE 4010     and     r0,r2                       
080095F0 0400     lsl     r0,r0,10h                   
080095F2 2800     cmp     r0,0h                       
080095F4 D000     beq     80095F8h                    
080095F6 81E1     strh    r1,[r4,0Eh]                 
080095F8 82E3     strh    r3,[r4,16h]                 
080095FA 20FF     mov     r0,0FFh                     
080095FC BC10     pop     r4                          
080095FE BC02     pop     r1                          
08009600 4708     bx      r1                          
08009602 0000     lsl     r0,r0,0h                    
08009604 B570     push    r4-r6,r14                   
08009606 1C05     mov     r5,r0                       
08009608 4803     ldr     r0,=3000114h                
0800960A 7800     ldrb    r0,[r0]                     
0800960C 281D     cmp     r0,1Dh                      
0800960E D905     bls     800961Ch                    
08009610 2000     mov     r0,0h                       
08009612 7128     strb    r0,[r5,4h]                  
08009614 20FE     mov     r0,0FEh                     
08009616 E0A8     b       800976Ah                    
08009618 0114     lsl     r4,r2,4h                    
0800961A 0300     lsl     r0,r0,0Ch                   
0800961C 89E9     ldrh    r1,[r5,0Eh]                 
0800961E 2010     mov     r0,10h                      
08009620 4008     and     r0,r1                       
08009622 2800     cmp     r0,0h                       
08009624 D002     beq     800962Ch                    
08009626 8A68     ldrh    r0,[r5,12h]                 
08009628 3020     add     r0,20h                      
0800962A E001     b       8009630h                    
0800962C 8A68     ldrh    r0,[r5,12h]                 
0800962E 3820     sub     r0,20h                      
08009630 0400     lsl     r0,r0,10h                   
08009632 0C01     lsr     r1,r0,10h                   
08009634 8AA8     ldrh    r0,[r5,14h]                 
08009636 38D0     sub     r0,0D0h                     
08009638 0400     lsl     r0,r0,10h                   
0800963A 0C00     lsr     r0,r0,10h                   
0800963C F04EFBDC bl      8057DF8h                    
08009640 1C06     mov     r6,r0                       
08009642 2480     mov     r4,80h                      
08009644 0464     lsl     r4,r4,11h                   
08009646 4026     and     r6,r4                       
08009648 8AA8     ldrh    r0,[r5,14h]                 
0800964A 38D0     sub     r0,0D0h                     
0800964C 0400     lsl     r0,r0,10h                   
0800964E 0C00     lsr     r0,r0,10h                   
08009650 8A69     ldrh    r1,[r5,12h]                 
08009652 F04EFBD1 bl      8057DF8h                    
08009656 1C03     mov     r3,r0                       
08009658 4023     and     r3,r4                       
0800965A 4809     ldr     r0,=3001380h                
0800965C 8801     ldrh    r1,[r0]                     
0800965E 2001     mov     r0,1h                       
08009660 4008     and     r0,r1                       
08009662 2800     cmp     r0,0h                       
08009664 D02F     beq     80096C6h                    
08009666 4807     ldr     r0,=300137Ch                
08009668 8801     ldrh    r1,[r0]                     
0800966A 89EA     ldrh    r2,[r5,0Eh]                 
0800966C 4011     and     r1,r2                       
0800966E 1C04     mov     r4,r0                       
08009670 2900     cmp     r1,0h                       
08009672 D013     beq     800969Ch                    
08009674 2E00     cmp     r6,0h                       
08009676 D107     bne     8009688h                    
08009678 2B00     cmp     r3,0h                       
0800967A D105     bne     8009688h                    
0800967C 201A     mov     r0,1Ah                      
0800967E E074     b       800976Ah                    
08009680 1380     asr     r0,r0,0Eh                   
08009682 0300     lsl     r0,r0,0Ch                   
08009684 137C     asr     r4,r7,0Dh                   
08009686 0300     lsl     r0,r0,0Ch                   
08009688 4803     ldr     r0,=3001530h                
0800968A 7BC1     ldrb    r1,[r0,0Fh]                 
0800968C 2040     mov     r0,40h                      
0800968E 4008     and     r0,r1                       
08009690 2800     cmp     r0,0h                       
08009692 D003     beq     800969Ch                    
08009694 201C     mov     r0,1Ch                      
08009696 E068     b       800976Ah                    
08009698 1530     asr     r0,r6,14h                   
0800969A 0300     lsl     r0,r0,0Ch                   
0800969C 2030     mov     r0,30h                      
0800969E 4050     eor     r0,r2                       
080096A0 8823     ldrh    r3,[r4]                     
080096A2 1C01     mov     r1,r0                       
080096A4 4019     and     r1,r3                       
080096A6 2900     cmp     r1,0h                       
080096A8 D002     beq     80096B0h                    
080096AA 81E8     strh    r0,[r5,0Eh]                 
080096AC 2001     mov     r0,1h                       
080096AE E7B0     b       8009612h                    
080096B0 2080     mov     r0,80h                      
080096B2 4018     and     r0,r3                       
080096B4 2800     cmp     r0,0h                       
080096B6 D001     beq     80096BCh                    
080096B8 7129     strb    r1,[r5,4h]                  
080096BA E7AB     b       8009614h                    

