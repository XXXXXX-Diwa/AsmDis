
.definelabel checkclip,800f688h
.definelabel checkevent,80608BCh
.definelabel checkanimatinoholdnd2,800fbc8h

.org 801d318h
0801D318 B5F0     push    r4-r7,r14                               
0801D31A 4E0D     ldr     r6,=3000738h                            
0801D31C 8870     ldrh    r0,[r6,2h]                              
0801D31E 3820     sub     r0,20h  ;垂直坐标值减20h                               
0801D320 0400     lsl     r0,r0,10h                               
0801D322 0C05     lsr     r5,r0,10h                               
0801D324 1C2B     mov     r3,r5                                   
0801D326 88B4     ldrh    r4,[r6,4h]                              
0801D328 1C22     mov     r2,r4                                   
0801D32A 1C30     mov     r0,r6                                   
0801D32C 3024     add     r0,24h                                  
0801D32E 7800     ldrb    r0,[r0]                                 
0801D330 2800     cmp     r0,0h                                   
0801D332 D122     bne     @@posenozero                                
0801D334 1C21     mov     r1,r4     ;pose 0 时检查的代码                              
0801D336 312C     add     r1,2Ch    ;垂直坐标减20h用于判断砖块,水平坐标加2ch                               
0801D338 1C28     mov     r0,r5     ;分别为r0,r1                              
0801D33A F7F2F9A5 bl      checkclip                                
0801D33E 4F05     ldr     r7,=30000DCh                            
0801D340 8838     ldrh    r0,[r7]                                 
0801D342 2807     cmp     r0,7h     ;30000dc不等于7跳转                              
0801D344 D10A     bne     @@DCnoseven  ;只要传送右边有9砖,就会为7                              
0801D346 8831     ldrh    r1,[r6]       ;右边有9砖                          
0801D348 4803     ldr     r0,=0FDFFh                              
0801D34A 4008     and     r0,r1        ;FDFF and 取向                           
0801D34C 8030     strh    r0,[r6]      ;传送在右边写入的取向 ,0?                          
0801D34E E025     b       @@end                                
                              
@@DCnoseven:          ;右边无9砖                    
0801D35C 1C21     mov     r1,r4                                   
0801D35E 392C     sub     r1,2Ch    ;检查左边                               
0801D360 1C28     mov     r0,r5                                   
0801D362 F7F2F991 bl      checkclip                               
0801D366 8838     ldrh    r0,[r7]                                 
0801D368 2807     cmp     r0,7h                                   
0801D36A D117     bne     @@end     ;不在左边则结束                           
0801D36C 8831     ldrh    r1,[r6]                                 
0801D36E 2280     mov     r2,80h                                  
0801D370 0092     lsl     r2,r2,2h   ;200                                
0801D372 1C10     mov     r0,r2                                   
0801D374 4308     orr     r0,r1      ;200 orr 取向  在左边                             
0801D376 8030     strh    r0,[r6]    ;传送在左边写入的取向,200h?                             
0801D378 E010     b       @@end

@@posenozero:                       ;pose非0时会检验的         
0801D37A 8831     ldrh    r1,[r6]                                 
0801D37C 2080     mov     r0,80h                                  
0801D37E 0080     lsl     r0,r0,2h                                
0801D380 4008     and     r0,r1     ;200 and 取向                              
0801D382 2800     cmp     r0,0h                                   
0801D384 D005     beq     @@pass    ;利用取向检查在右边?                           
0801D386 1C21     mov     r1,r4     ;在左边                              
0801D388 312C     add     r1,2Ch                                  
0801D38A 1C28     mov     r0,r5     ;检查右边的砖块                              
0801D38C F7F2F97C bl      checkclip                                
0801D390 E004     b       @@end 
@@pass:                             ;在右边  
0801D392 1C11     mov     r1,r2                                   
0801D394 392C     sub     r1,2Ch                                  
0801D396 1C18     mov     r0,r3     ;检查左边的砖块                              
0801D398 F7F2F976 bl      checkclip
@@end:                               
0801D39C BCF0     pop     r4-r7                                   
0801D39E BC01     pop     r0                                      
0801D3A0 4700     bx      r0  

                                    
                                
0801D3A4 B570     push    r4-r6,r14     ;滑行经历程序                          
0801D3A6 2600     mov     r6,0h                                   
0801D3A8 2500     mov     r5,0h                                   
0801D3AA 4805     ldr     r0,=3000738h                            
0801D3AC 8801     ldrh    r1,[r0]                                 
0801D3AE 2080     mov     r0,80h                                  
0801D3B0 0100     lsl     r0,r0,4h                                
0801D3B2 4008     and     r0,r1                                   
0801D3B4 2800     cmp     r0,0h                                   
0801D3B6 D005     beq     @@nohold                                
0801D3B8 2501     mov     r5,1h                                   
0801D3BA 240C     mov     r4,0Ch                                  
0801D3BC E003     b       @@holding                                
@@nohold:                              
0801D3C4 2410     mov     r4,10h    ;滑动的速度
@@holding:                                 
0801D3C6 F7FFFFA7 bl      801D318h                                
0801D3CA 480A     ldr     r0,=30000DCh                            
0801D3CC 8800     ldrh    r0,[r0]                                 
0801D3CE 2807     cmp     r0,7h    ;检查滑动到头?                               
0801D3D0 D118     bne     801D404h                                
0801D3D2 1C70     add     r0,r6,1                                 
0801D3D4 0600     lsl     r0,r0,18h                               
0801D3D6 0E06     lsr     r6,r0,18h                               
0801D3D8 4907     ldr     r1,=3000738h                            
0801D3DA 888A     ldrh    r2,[r1,4h]                              
0801D3DC 4807     ldr     r0,=0FFC0h                              
0801D3DE 4010     and     r0,r2                                   
0801D3E0 1C03     mov     r3,r0                                   
0801D3E2 3320     add     r3,20h                                  
0801D3E4 808B     strh    r3,[r1,4h]                              
0801D3E6 1C0A     mov     r2,r1                                   
0801D3E8 2D00     cmp     r5,0h     ;人不在勾                              
0801D3EA D028     beq     801D43Eh                                
0801D3EC 4804     ldr     r0,=30013D4h                            
0801D3EE 8243     strh    r3,[r0,12h]                             
0801D3F0 E025     b       801D43Eh  

                              

                             
0801D404 4A07     ldr     r2,=3000738h                            
0801D406 8811     ldrh    r1,[r2]                                 
0801D408 2080     mov     r0,80h                                  
0801D40A 0080     lsl     r0,r0,2h                                
0801D40C 4008     and     r0,r1                                   
0801D40E 2800     cmp     r0,0h                                   
0801D410 D00C     beq     801D42Ch                                
0801D412 8890     ldrh    r0,[r2,4h]                              
0801D414 1820     add     r0,r4,r0                                
0801D416 8090     strh    r0,[r2,4h]                              
0801D418 2D00     cmp     r5,0h                                   
0801D41A D010     beq     801D43Eh                                
0801D41C 4902     ldr     r1,=30013D4h                            
0801D41E 8A48     ldrh    r0,[r1,12h]                             
0801D420 1820     add     r0,r4,r0                                
0801D422 E00B     b       801D43Ch                                
0801D424 0738     lsl     r0,r7,1Ch                               
0801D426 0300     lsl     r0,r0,0Ch                               
0801D428 13D4     asr     r4,r2,0Fh                               
0801D42A 0300     lsl     r0,r0,0Ch                               
0801D42C 8890     ldrh    r0,[r2,4h]                              
0801D42E 1B00     sub     r0,r0,r4                                
0801D430 8090     strh    r0,[r2,4h]                              
0801D432 2D00     cmp     r5,0h   ;若人在上则为1                                
0801D434 D003     beq     801D43Eh                                
0801D436 490B     ldr     r1,=30013D4h                            
0801D438 8A48     ldrh    r0,[r1,12h]                             
0801D43A 1B00     sub     r0,r0,r4                                
0801D43C 8248     strh    r0,[r1,12h]                             
0801D43E 2E00     cmp     r6,0h     ;滑动到头则为1?                              
0801D440 D00C     beq     @@end                                
0801D442 2D00     cmp     r5,0h                                   
0801D444 D00A     beq     @@end                                
0801D446 8811     ldrh    r1,[r2]                                 
0801D448 4807     ldr     r0,=0F7FFh                              
0801D44A 4008     and     r0,r1                                   
0801D44C 8010     strh    r0,[r2]                                 
0801D44E 1C11     mov     r1,r2                                   
0801D450 3126     add     r1,26h                                  
0801D452 200F     mov     r0,0Fh                                  
0801D454 7008     strb    r0,[r1]                                 
0801D456 20FE     mov     r0,0FEh                                 
0801D458 F7EAF846 bl      80074E8h  
@@end:                              
0801D45C 1C30     mov     r0,r6                                   
0801D45E BC70     pop     r4-r6                                   
0801D460 BC02     pop     r1                                      
0801D462 4708     bx      r1                                      

.org 801d46ch            ;传送默认会经历,滑行也经历                   
0801D46C B570     push    r4-r6,r14                               
0801D46E 4C0D     ldr     r4,=3000738h                            
0801D470 8821     ldrh    r1,[r4]                                 
0801D472 2080     mov     r0,80h                                  
0801D474 0100     lsl     r0,r0,4h                                
0801D476 4008     and     r0,r1     ;800h and                              
0801D478 0400     lsl     r0,r0,10h                               
0801D47A 0C06     lsr     r6,r0,10h                               
0801D47C 2E00     cmp     r6,0h                                   
0801D47E D100     bne     @@hold  ;上钩                              
0801D480 E07C     b       801D57Ch  ;未上钩

@@hold:                                
0801D482 2003     mov     r0,3h                                   
0801D484 212E     mov     r1,2Eh                                  
0801D486 F043FA19 bl      checkevent                                
0801D48A 1C05     mov     r5,r0                                   
0801D48C 2D00     cmp     r5,0h                                   
0801D48E D045     beq     @@inactive ;未激活                               
0801D490 1C25     mov     r5,r4      ;激活的例程                             
0801D492 352D     add     r5,2Dh     ;重产值                             
0801D494 7829     ldrb    r1,[r5]    ;抓瞬间为1,抓为2,松瞬间为3,然后其余为0                             
0801D496 2901     cmp     r1,1h      ;检查是否是1                             
0801D498 D014     beq     @@respawn1                                
0801D49A 2901     cmp     r1,1h                                   
0801D49C DC04     bgt     @@respawn1+                                
0801D49E 2900     cmp     r1,0h                                   
0801D4A0 D007     beq     @@respawn0                               
0801D4A2 E0CC     b       @@end                                

@@respawn1+:                               
0801D4A8 2902     cmp     r1,2h                                   
0801D4AA D02B     beq     @@respawn2                                
0801D4AC 2903     cmp     r1,3h                                   
0801D4AE D019     beq     @@respawn3                                
0801D4B0 E0C5     b       @@end        

@@respawn0:                        
0801D4B2 4803     ldr     r0,=82CE9B0h ;抓默认首经历的例程                           
0801D4B4 61A0     str     r0,[r4,18h]  ;写入新动画                           
0801D4B6 7721     strb    r1,[r4,1Ch]                             
0801D4B8 82E1     strh    r1,[r4,16h]                             
0801D4BA 2001     mov     r0,1h        ;重产写入1                           
0801D4BC 7028     strb    r0,[r5]                                 
0801D4BE E0BE     b       @@end                                 

@@respawn1:                          ;抓瞬间 
0801D4C4 F7F2FB80 bl      800FBC8h   ;检查动画                             
0801D4C8 2800     cmp     r0,0h                                   
0801D4CA D100     bne     @@animationend                              
0801D4CC E0B7     b       @@end  

@@animationend:                              
0801D4CE 4804     ldr     r0,=82CE9D0h                            
0801D4D0 61A0     str     r0,[r4,18h]                             
0801D4D2 2000     mov     r0,0h                                   
0801D4D4 7720     strb    r0,[r4,1Ch]                             
0801D4D6 82E0     strh    r0,[r4,16h] ;写入新图,以及清零                            
0801D4D8 2002     mov     r0,2h       ;重产写入2                            
0801D4DA 7028     strb    r0,[r5]                                 
0801D4DC 82A0     strh    r0,[r4,14h] ;血量写入2                            
0801D4DE E0AE     b       @@end                                

@@respawn3:                               
0801D4E4 F7F2FB70 bl      800FBC8h    ;检查动画结束                            
0801D4E8 2800     cmp     r0,0h                                   
0801D4EA D100     bne     @@animationend2                                   
0801D4EC E0A7     b       @@end   

@@animationend2:                             
0801D4EE 4804     ldr     r0,=82CE9D0h ;写入新图                           
0801D4F0 61A0     str     r0,[r4,18h]                             
0801D4F2 2000     mov     r0,0h                                   
0801D4F4 7720     strb    r0,[r4,1Ch]                             
0801D4F6 82E0     strh    r0,[r4,16h]                             
0801D4F8 2002     mov     r0,2h                                   
0801D4FA 7028     strb    r0,[r5]      ;重产写入2                           
0801D4FC E09F     b       @@end                                

@@respawn2:                              
0801D504 69A0     ldr     r0,[r4,18h]    ;读取OAM                         
0801D506 4904     ldr     r1,=82CE9D0h                            
0801D508 4288     cmp     r0,r1                                   
0801D50A D100     bne     @@OAMnosame    ;如果两者不同                        
0801D50C E097     b       @@end        

@@OAMnosame:                        
0801D50E 61A1     str     r1,[r4,18h]    ;写入相同                         
0801D510 2000     mov     r0,0h                                   
0801D512 7720     strb    r0,[r4,1Ch]                             
0801D514 82E0     strh    r0,[r4,16h]                             
0801D516 E092     b       @@end                                

@@inactive:                    ;未激活事件 holding       
0801D51C 1C26     mov     r6,r4                                   
0801D51E 362D     add     r6,2Dh                                  
0801D520 7830     ldrb    r0,[r6]  ;3000765的值                               
0801D522 2801     cmp     r0,1h                                   
0801D524 D012     beq     @respawn1                                
0801D526 2801     cmp     r0,1h                                   
0801D528 DC02     bgt     @respawn1+                                
0801D52A 2800     cmp     r0,0h                                   
0801D52C D005     beq     @respawn0                                
0801D52E E086     b       @@end  

@respawn1+:                              
0801D530 2802     cmp     r0,2h                                   
0801D532 D019     beq     @respawn2                                
0801D534 2803     cmp     r0,3h                                   
0801D536 D009     beq     @respawn1                                
0801D538 E081     b       @@end 

@respawn0:                               
0801D53A 4803     ldr     r0,=82CE928h                            
0801D53C 61A0     str     r0,[r4,18h]                             
0801D53E 7725     strb    r5,[r4,1Ch]                             
0801D540 82E5     strh    r5,[r4,16h]                             
0801D542 2001     mov     r0,1h                                   
0801D544 7030     strb    r0,[r6]      ;重产写入1                           
0801D546 E07A     b       @@end                                

@respawn1:                              
0801D54C F7F2FB3C bl      800FBC8h                                
0801D550 2800     cmp     r0,0h                                   
0801D552 D074     beq     @@end                                
0801D554 4803     ldr     r0,=82CE948h  ;写入新图                          
0801D556 61A0     str     r0,[r4,18h]                             
0801D558 7725     strb    r5,[r4,1Ch]                             
0801D55A 82E5     strh    r5,[r4,16h]                             
0801D55C 2002     mov     r0,2h                                   
0801D55E 7030     strb    r0,[r6]       ;重产写入2                            
0801D560 E06D     b       @@end                                

@respawn2:                              
0801D568 69A0     ldr     r0,[r4,18h]   ;比较两种图是否一样                       
0801D56A 4903     ldr     r1,=82CE948h                            
0801D56C 4288     cmp     r0,r1                                   
0801D56E D066     beq     @@end                                
0801D570 61A1     str     r1,[r4,18h]   ;不一样则重写                          
0801D572 7725     strb    r5,[r4,1Ch]                             
0801D574 82E5     strh    r5,[r4,16h]                             
0801D576 E062     b       @@end                                

.org 801d57ch                    ;未上钩                         
0801D57C 2003     mov     r0,3h                                   
0801D57E 212E     mov     r1,2Eh                                  
0801D580 F043F99C bl      checkevent     ;检查事件                           
0801D584 1C05     mov     r5,r0                                   
0801D586 2D00     cmp     r5,0h                                   
0801D588 D02C     beq     801D5E4h       ;未激活                         
0801D58A 1C25     mov     r5,r4          ;激活未上钩                         
0801D58C 352D     add     r5,2Dh                                  
0801D58E 7829     ldrb    r1,[r5]      ;读取3000765                           
0801D590 2901     cmp     r1,1h        ;人上去就为1                           
0801D592 D013     beq     @@respawn1or3                               
0801D594 2901     cmp     r1,1h        ;大于1,人上去并移动                           
0801D596 DC02     bgt     801D59Eh                                
0801D598 2900     cmp     r1,0h                                   
0801D59A D01D     beq     801D5D8h  ;默认经历,滑行也经历                              
0801D59C E04F     b       @@end  

;重产大于1的话                             
0801D59E 2902     cmp     r1,2h                                   
0801D5A0 D002     beq     801D5A8h                                
0801D5A2 2903     cmp     r1,3h                                   
0801D5A4 D00A     beq     @@respawn1or3                                
0801D5A6 E04A     b       @@end   

;重产是2                             
0801D5A8 4803     ldr     r0,=82CEA08h                            
0801D5AA 61A0     str     r0,[r4,18h]                             
0801D5AC 7726     strb    r6,[r4,1Ch]                             
0801D5AE 82E6     strh    r6,[r4,16h]                             
0801D5B0 2003     mov     r0,3h                                   
0801D5B2 7028     strb    r0,[r5]    ;重产写入3                             
0801D5B4 E043     b       @@end                                

@@respawn1or3:                              
0801D5BC F7F2FB04 bl      800FBC8h   ;检查动画结束                              
0801D5C0 2800     cmp     r0,0h                                   
0801D5C2 D03C     beq     @@end                                
0801D5C4 4803     ldr     r0,=82CE978h  ;写入新图                          
0801D5C6 61A0     str     r0,[r4,18h]                             
0801D5C8 7726     strb    r6,[r4,1Ch]                             
0801D5CA 2000     mov     r0,0h                                   
0801D5CC 82E6     strh    r6,[r4,16h]                             
0801D5CE 7028     strb    r0,[r5]       ;重产写入0                          
0801D5D0 E035     b       @@end 
@@end:
     pop r4-r6
	 pop r0
	 bx r0

                            

.org 801d5d8h           ;传送默认经历例程,未上钩都经历                              
0801D5D8 69A0     ldr     r0,[r4,18h]                             
0801D5DA 4A01     ldr     r2,=82CE978h                            
0801D5DC E02A     b       801D634h   


                             
;未激活未上钩待机状态                             
0801D5E4 1C26     mov     r6,r4                                   
0801D5E6 362D     add     r6,2Dh                                  
0801D5E8 7831     ldrb    r1,[r6]                                 
0801D5EA 2901     cmp     r1,1h                                   
0801D5EC D012     beq     801D614h                                
0801D5EE 2901     cmp     r1,1h                                   
0801D5F0 DC02     bgt     801D5F8h                                
0801D5F2 2900     cmp     r1,0h                                   
0801D5F4 D01C     beq     801D630h                                
0801D5F6 E022     b       @@end                                
0801D5F8 2902     cmp     r1,2h                                   
0801D5FA D002     beq     801D602h                                
0801D5FC 2903     cmp     r1,3h                                   
0801D5FE D009     beq     801D614h                                
0801D600 E01D     b       @@end                                
0801D602 4803     ldr     r0,=82CE958h                            
0801D604 61A0     str     r0,[r4,18h]                             
0801D606 7725     strb    r5,[r4,1Ch]                             
0801D608 82E5     strh    r5,[r4,16h]                             
0801D60A 2003     mov     r0,3h                                   
0801D60C 7030     strb    r0,[r6]                                 
0801D60E E016     b       @@end                                                             
0801D614 F7F2FAD8 bl      800FBC8h                               

.org 801d634h        ;默认经历例程
     cmp r0,r2       ;检查图像是否是相同的
	 beq @@end
	 str r2,[r4,18h]
	 strb r1,[r4,1ch]
@@end:
	 pop r4-r6
	 pop r0
	 bx r0

;30001ad的变化,传送在左则为2,在右则为0,有人情况下,向右滑行为A,向左滑行为8

.org 801d648h                 ;传送 默认pose 0
0801D648 B570     push    r4-r6,r14                               
0801D64A 4D1D     ldr     r5,=3000738h                            
0801D64C 2300     mov     r3,0h                                   
0801D64E 2400     mov     r4,0h                                   
0801D650 481C     ldr     r0,=0FFC0h                              
0801D652 8168     strh    r0,[r5,0Ah]                             
0801D654 2110     mov     r1,10h                                  
0801D656 2010     mov     r0,10h                                  
0801D658 81A8     strh    r0,[r5,0Ch]                             
0801D65A 481B     ldr     r0,=0FFFCh                              
0801D65C 81E8     strh    r0,[r5,0Eh]                             
0801D65E 2004     mov     r0,4h                                   
0801D660 8228     strh    r0,[r5,10h]   ;四面分界写入                          
0801D662 1C28     mov     r0,r5                                   
0801D664 3027     add     r0,27h                                  
0801D666 7001     strb    r1,[r0]   ;300075f写入10h                              
0801D668 1C29     mov     r1,r5                                   
0801D66A 3128     add     r1,28h    ;3000760写入10h                              
0801D66C 2208     mov     r2,8h                                   
0801D66E 2008     mov     r0,8h                                   
0801D670 7008     strb    r0,[r1]                                 
0801D672 3101     add     r1,1h                                   
0801D674 7008     strb    r0,[r1]   ;3000761写入8h                              
0801D676 3904     sub     r1,4h                                   
0801D678 201A     mov     r0,1Ah                                  
0801D67A 7008     strb    r0,[r1]   ;属性写入1ah                              
0801D67C 2101     mov     r1,1h                                   
0801D67E 2001     mov     r0,1h                                   
0801D680 82A8     strh    r0,[r5,14h]  ;血量写入1                           
0801D682 2032     mov     r0,32h                                  
0801D684 1940     add     r0,r0,r5                                
0801D686 4684     mov     r12,r0                                  
0801D688 7800     ldrb    r0,[r0]   ;读取300076a                              
0801D68A 4302     orr     r2,r0     ;8 orr                             
0801D68C 4666     mov     r6,r12                                  
0801D68E 7032     strb    r2,[r6]   ;再写入                              
0801D690 1C2A     mov     r2,r5                                   
0801D692 3222     add     r2,22h                                  
0801D694 2003     mov     r0,3h                                   
0801D696 7010     strb    r0,[r2]   ;300075a写入3   调色板?                            
0801D698 1C28     mov     r0,r5                                   
0801D69A 3021     add     r0,21h                                  
0801D69C 7001     strb    r1,[r0]   ;3000759写入1  调色板?                             
0801D69E 772B     strb    r3,[r5,1Ch]                             
0801D6A0 82EC     strh    r4,[r5,16h]  ;动画帧和计数归零                           
0801D6A2 300B     add     r0,0Bh                                  
0801D6A4 7003     strb    r3,[r0]      ;3000764写入0                           
0801D6A6 3001     add     r0,1h                                   
0801D6A8 7003     strb    r3,[r0]      ;3000765写入0                           
0801D6AA F7FFFE35 bl      801D318h     ;检查砖块,写入各自的取向                          
0801D6AE 2003     mov     r0,3h                                   
0801D6B0 212E     mov     r1,2Eh                                  
0801D6B2 F043F903 bl      checkevent                                
0801D6B6 2800     cmp     r0,0h                                   
0801D6B8 D00A     beq     @@eventpass   ;根据事件是否激活而图像各异                              
0801D6BA 4804     ldr     r0,=82CE978h                            
0801D6BC E009     b       @@eventgo                                
@@eventpass:                              
0801D6D0 4804     ldr     r0,=82CE918h 
@@eventgo:                           
0801D6D2 61A8     str     r0,[r5,18h]   ;写入新的图像                          
0801D6D4 4804     ldr     r0,=3000738h                            
0801D6D6 3024     add     r0,24h                                  
0801D6D8 2109     mov     r1,9h                                   
0801D6DA 7001     strb    r1,[r0]  ;pose写入9                               
0801D6DC BC70     pop     r4-r6                                   
0801D6DE BC01     pop     r0                                      
0801D6E0 4700     bx      r0                                      

.org 801d6ech                       ;传送 pose 9        
0801D6EC B530     push    r4,r5,r14                               
0801D6EE F7F2FFEB bl      80106C8h      ;检查人物是否在传送上                       
0801D6F2 2800     cmp     r0,0h                                   
0801D6F4 D10C     bne     @@hanging                                
0801D6F6 491C     ldr     r1,=3000738h  ;人物不在传送上经历的例程                          
0801D6F8 880A     ldrh    r2,[r1]                                 
0801D6FA 2080     mov     r0,80h                                  
0801D6FC 0100     lsl     r0,r0,4h                                
0801D6FE 4010     and     r0,r2         ;800h and  只要在传送上就不会为0                          
0801D700 2800     cmp     r0,0h         ;检查3000738是否为0                          
0801D702 D005     beq     @@hanging     ;默认什么都没做就会跳转的,滑行也跳转                           
0801D704 4819     ldr     r0,=0F7FFh    ;否则把800变成0                          
0801D706 4010     and     r0,r2                                   
0801D708 8008     strh    r0,[r1]                                 
0801D70A 3126     add     r1,26h                                  
0801D70C 200F     mov     r0,0Fh                                  
0801D70E 7008     strb    r0,[r1]       ;300075e写入0Fh
@@hanging:                                
0801D710 F7FFFEAC bl      801D46Ch                                
0801D714 4C14     ldr     r4,=3000738h                            
0801D716 8AA0     ldrh    r0,[r4,14h]  ;检查血量                         
0801D718 2802     cmp     r0,2h                                   
0801D71A D121     bne     @@end       ;非2跳转,默认跳转,若滑行则2,不跳转                        
0801D71C 1C25     mov     r5,r4                                   
0801D71E 352C     add     r5,2Ch                                  
0801D720 7829     ldrb    r1,[r5]   ;得到3000764的值,每帧加1                              
0801D722 200F     mov     r0,0Fh                                  
0801D724 4008     and     r0,r1     ;r1为X0播放声音                            
0801D726 2800     cmp     r0,0h                                   
0801D728 D103     bne     @@nosound   ;不为0跳转                             
0801D72A 2088     mov     r0,88h                                  
0801D72C 0040     lsl     r0,r0,1h                                
0801D72E F7E5F973 bl      8002A18h  
@@nosound:                              
0801D732 7828     ldrb    r0,[r5]   ;3000764加1                              
0801D734 3001     add     r0,1h                                   
0801D736 7028     strb    r0,[r5]                                 
0801D738 F7FFFE34 bl      801D3A4h                                
0801D73C 0600     lsl     r0,r0,18h                               
0801D73E 2800     cmp     r0,0h                                   
0801D740 D00E     beq     @@end                                
0801D742 2200     mov     r2,0h                                   
0801D744 2001     mov     r0,1h                                   
0801D746 82A0     strh    r0,[r4,14h]                             
0801D748 8820     ldrh    r0,[r4]                                 
0801D74A 2380     mov     r3,80h                                  
0801D74C 009B     lsl     r3,r3,2h                                
0801D74E 1C19     mov     r1,r3                                   
0801D750 4048     eor     r0,r1                                   
0801D752 8020     strh    r0,[r4]                                 
0801D754 702A     strb    r2,[r5]                                 
0801D756 2088     mov     r0,88h                                  
0801D758 0040     lsl     r0,r0,1h                                
0801D75A 2104     mov     r1,4h                                   
0801D75C F7E5FA90 bl      8002C80h
@@end:                                
0801D760 BC30     pop     r4,r5                                   
0801D762 BC01     pop     r0                                      
0801D764 4700     bx      r0                                      

/////////////////////////////////////////////////////////
080106C8 B500     push    r14         ;检查人物在传送上的例程                            
080106CA 4804     ldr     r0,=30013D4h                            
080106CC 7800     ldrb    r0,[r0]                                 
080106CE 282B     cmp     r0,2Bh                                  
080106D0 DC06     bgt     80106E0h    ;人物pose大于2bh跳转                              
080106D2 2828     cmp     r0,28h                                  
080106D4 DB04     blt     80106E0h    ;人物pose小于28h跳转                            
080106D6 2001     mov     r0,1h                                   
080106D8 E003     b       80106E2h                                                            
080106E0 2000     mov     r0,0h                                   
080106E2 BC02     pop     r1                                      
080106E4 4708     bx      r1                                      
///////////////////////////////////////////////////////


.org 801d770h       ;按钮pose 0             
0801D770 B510     push    r4,r14                                  
0801D772 2003     mov     r0,3h                                   
0801D774 212E     mov     r1,2Eh                                  
0801D776 F043F8A1 bl      checkevent  ;检查事件                              
0801D77A 2800     cmp     r0,0h                                   
0801D77C D006     beq     @@eventNo    ;未激活跳转                            
0801D77E 4901     ldr     r1,=3000738h                            
0801D780 4801     ldr     r0,=82CEA38h                            
0801D782 E005     b       @@write                               
@@eventNo:                              
0801D78C 491B     ldr     r1,=3000738h                            
0801D78E 481C     ldr     r0,=82CEA28h 
@@write:                           
0801D790 6188     str     r0,[r1,18h] ;写入不同的图像                          
0801D792 468C     mov     r12,r1                                  
0801D794 4661     mov     r1,r12                                  
0801D796 8848     ldrh    r0,[r1,2h]                              
0801D798 3880     sub     r0,80h     ;Y坐标向上升80h                             
0801D79A 2200     mov     r2,0h                                   
0801D79C 2300     mov     r3,0h                                   
0801D79E 8048     strh    r0,[r1,2h]                              
0801D7A0 4660     mov     r0,r12                                  
0801D7A2 3027     add     r0,27h                                  
0801D7A4 7002     strb    r2,[r0]   ;300075F写入0                                
0801D7A6 3128     add     r1,28h                                  
0801D7A8 2018     mov     r0,18h                                  
0801D7AA 7008     strb    r0,[r1]   ;3000760写入18h                              
0801D7AC 4664     mov     r4,r12                                  
0801D7AE 3429     add     r4,29h                                  
0801D7B0 2108     mov     r1,8h                                   
0801D7B2 2008     mov     r0,8h                                   
0801D7B4 7020     strb    r0,[r4]   ;3000761写入8h                              
0801D7B6 4664     mov     r4,r12                                  
0801D7B8 8163     strh    r3,[r4,0Ah]  ;上部边界写入0                           
0801D7BA 2050     mov     r0,50h                                  
0801D7BC 81A0     strh    r0,[r4,0Ch]  ;下部边界写入50h                           
0801D7BE 4811     ldr     r0,=0FFECh                              
0801D7C0 81E0     strh    r0,[r4,0Eh]  ;左部边界写入FFECh                          
0801D7C2 2014     mov     r0,14h                                  
0801D7C4 8220     strh    r0,[r4,10h]  ;右部边界写入14h                           
0801D7C6 7722     strb    r2,[r4,1Ch]                             
0801D7C8 82E3     strh    r3,[r4,16h]  ;动画帧和计数归零                           
0801D7CA 4660     mov     r0,r12                                  
0801D7CC 3025     add     r0,25h                                  
0801D7CE 7002     strb    r2,[r0]   ;属性写入0                              
0801D7D0 2201     mov     r2,1h                                   
0801D7D2 2001     mov     r0,1h                                   
0801D7D4 82A0     strh    r0,[r4,14h]  ;血量写入1                           
0801D7D6 4663     mov     r3,r12                                  
0801D7D8 3332     add     r3,32h                                  
0801D7DA 7818     ldrb    r0,[r3]   ;读取300076a                              
0801D7DC 4301     orr     r1,r0     ;8 orr 0                              
0801D7DE 7019     strb    r1,[r3]   ;写入                              
0801D7E0 4660     mov     r0,r12                                  
0801D7E2 3024     add     r0,24h                                  
0801D7E4 7002     strb    r2,[r0]   ;pose写入1                              
0801D7E6 4661     mov     r1,r12                                  
0801D7E8 3122     add     r1,22h                                  
0801D7EA 2003     mov     r0,3h                                   
0801D7EC 7008     strb    r0,[r1]   ;300075a写入3,调色板?                              
0801D7EE 4660     mov     r0,r12                                  
0801D7F0 3021     add     r0,21h                                  
0801D7F2 7002     strb    r2,[r0]   ;3000759写入1,调色板?                              
0801D7F4 BC10     pop     r4                                      
0801D7F6 BC01     pop     r0                                      
0801D7F8 4700     bx      r0  
                                    
.org 801d808h     ;按钮重写pose 9                               
0801D808 4905     ldr     r1,=3000738h                            
0801D80A 1C0B     mov     r3,r1                                   
0801D80C 3324     add     r3,24h                                  
0801D80E 2200     mov     r2,0h                                   
0801D810 2009     mov     r0,9h                                   
0801D812 7018     strb    r0,[r3]  ;pose 写入9h                               
0801D814 770A     strb    r2,[r1,1Ch]                             
0801D816 82CA     strh    r2,[r1,16h]  ;动画帧和计数归零                           
0801D818 4802     ldr     r0,=82CEA38h                            
0801D81A 6188     str     r0,[r1,18h]                             
0801D81C 4770     bx      r14                                     


.org 801d828h        ;按钮pose 1h     仅经历一次?                         
0801D828 B510     push    r4,r14                                  
0801D82A 203D     mov     r0,3Dh                                  
0801D82C F7F2FFE4 bl      80107F8h    ;检查是否有传送?                            
0801D830 0600     lsl     r0,r0,18h                               
0801D832 0E00     lsr     r0,r0,18h                               
0801D834 28FF     cmp     r0,0FFh                                 
0801D836 D105     bne     @@have                                
0801D838 4901     ldr     r1,=3000738h                            
0801D83A 2000     mov     r0,0h                                   
0801D83C 8008     strh    r0,[r1]                                 
0801D83E E015     b       @@end                                
@@have:                              
0801D844 4C06     ldr     r4,=3000738h                            
0801D846 1C21     mov     r1,r4                                   
0801D848 312D     add     r1,2Dh   ;3000765写入0h                               
0801D84A 7008     strb    r0,[r1]                                 
0801D84C 2003     mov     r0,3h                                   
0801D84E 212E     mov     r1,2Eh                                  
0801D850 F043F834 bl      checkevent                                
0801D854 2800     cmp     r0,0h                                   
0801D856 D005     beq     @@eventpass                                
0801D858 F7FFFFD6 bl      801D808h     ;写入pose9                                
0801D85C E006     b       @@end                                
@@eventpass:                              
0801D864 1C21     mov     r1,r4                                   
0801D866 3124     add     r1,24h                                  
0801D868 200F     mov     r0,0Fh                                  
0801D86A 7008     strb    r0,[r1]     ;写入pose fh
@@end:                                 
0801D86C BC10     pop     r4                                      
0801D86E BC01     pop     r0                                      
0801D870 4700     bx      r0  
                                    
                               
0801D874 B500     push    r14                                     
0801D876 2003     mov     r0,3h                                   
0801D878 212E     mov     r1,2Eh                                  
0801D87A F043F81F bl      checkevent                                
0801D87E 2800     cmp     r0,0h                                   
0801D880 D001     beq     @@end                               
0801D882 F7FFFFC1 bl      801D808h   ;写入pose 9h
@@end:                                
0801D886 BC01     pop     r0                                      
0801D888 4700     bx      r0                                      
     
.org 801d88ch      ;按钮pose 9h	 
0801D88C B510     push    r4,r14                                  
0801D88E 2400     mov     r4,0h                                   
0801D890 480A     ldr     r0,=3000738h                            
0801D892 1C01     mov     r1,r0                                   
0801D894 312D     add     r1,2Dh                                  
0801D896 780A     ldrb    r2,[r1]  ;读取3000765, 重产                            
0801D898 302B     add     r0,2Bh                                  
0801D89A 7801     ldrb    r1,[r0]  ;读取3000763,无敌                             
0801D89C 207F     mov     r0,7Fh                                  
0801D89E 4008     and     r0,r1                                   
0801D8A0 2800     cmp     r0,0h    ;无敌时间为0                              
0801D8A2 D011     beq     801D8C8h                                
0801D8A4 4906     ldr     r1,=30001ACh  ;无敌时经历,也就是被击打了                         
0801D8A6 00D0     lsl     r0,r2,3h                                
0801D8A8 1A80     sub     r0,r0,r2                                
0801D8AA 00C0     lsl     r0,r0,3h     ;重产值的56倍加30001ac                           
0801D8AC 1840     add     r0,r0,r1                               
0801D8AE 2102     mov     r1,2h                                   
0801D8B0 8281     strh    r1,[r0,14h] ;血量写入2h                            
0801D8B2 2401     mov     r4,1h                                   
0801D8B4 4803     ldr     r0,=111h    ;启动音                            
0801D8B6 F7E5F8AF bl      8002A18h                                
0801D8BA E00E     b       801D8DAh                                
                                
0801D8C8 480B     ldr     r0,=30001ACh  ;非无敌时经历的例程                          
0801D8CA 00D1     lsl     r1,r2,3h                                
0801D8CC 1A89     sub     r1,r1,r2                                
0801D8CE 00C9     lsl     r1,r1,3h                                
0801D8D0 1809     add     r1,r1,r0   ;r2的56倍加30001ac                             
0801D8D2 8A88     ldrh    r0,[r1,14h]  ;得到血量值                             
0801D8D4 2802     cmp     r0,2h       ;判断是否击中                          
0801D8D6 D100     bne     @@nohit                               
0801D8D8 2401     mov     r4,1h       ;击中则r4写入1
@@nohit:                                   
0801D8DA 2C00     cmp     r4,0h                                   
0801D8DC D009     beq     @@end   
                             
0801D8DE 4907     ldr     r1,=3000738h                            
0801D8E0 1C0B     mov     r3,r1                                   
0801D8E2 3324     add     r3,24h                                  
0801D8E4 2200     mov     r2,0h                                   
0801D8E6 2023     mov     r0,23h                                  
0801D8E8 7018     strb    r0,[r3]   ;pose值写入23                              
0801D8EA 770A     strb    r2,[r1,1Ch]                             
0801D8EC 82CA     strh    r2,[r1,16h]  ;动画帧和计数归零                           
0801D8EE 4804     ldr     r0,=82CEA70h                            
0801D8F0 6188     str     r0,[r1,18h] ;写入新的图片
@@end:                            
0801D8F2 BC10     pop     r4                                      
0801D8F4 BC01     pop     r0                                      
0801D8F6 4700     bx      r0  

                                    
.org 801d904h          ;按钮pose 23h                             
0801D904 B500     push    r14                                     
0801D906 4807     ldr     r0,=3000738h                            
0801D908 302D     add     r0,2Dh                                  
0801D90A 7801     ldrb    r1,[r0]  ;得到3000765的值                               
0801D90C 4A06     ldr     r2,=30001ACh                            
0801D90E 00C8     lsl     r0,r1,3h                                
0801D910 1A40     sub     r0,r0,r1                                
0801D912 00C0     lsl     r0,r0,3h                                
0801D914 1880     add     r0,r0,r2                                
0801D916 8A80     ldrh    r0,[r0,14h]  ;检查传送是否停止                          
0801D918 2801     cmp     r0,1h        ;如果血量不为1则结束而不写入pose9                          
0801D91A D101     bne     @@end                                
0801D91C F7FFFF74 bl      801D808h  ;重新写入pose 9  
@@end:                            
0801D920 BC01     pop     r0                                      
0801D922 4700     bx      r0                                      
////////////////////////////////////////////////////////////////////////////
.org 801d92ch         ;传送主程序                               
0801D92C B500     push    r14                                     
0801D92E 4804     ldr     r0,=3000738h                            
0801D930 3024     add     r0,24h                                  
0801D932 7800     ldrb    r0,[r0]                                 
0801D934 2800     cmp     r0,0h                                   
0801D936 D005     beq     @@posezero                                
0801D938 2809     cmp     r0,9h                                   
0801D93A D006     beq     @@posenine                                
0801D93C E007     b       @@end                               
0801D93E 0000     lsl     r0,r0,0h                                
0801D940 0738     lsl     r0,r7,1Ch                               
0801D942 0300     lsl     r0,r0,0Ch
@@posezero:                               
0801D944 F7FFFE80 bl      801D648h   ;00                             
0801D948 E001     b       @@end 
@@posenine:                               
0801D94A F7FFFECF bl      801D6ECh   ;09h
@@end:                              
0801D94E BC01     pop     r0                                      
0801D950 4700     bx      r0 

                                     
.org 801d954h             ;按钮主程序                               
0801D954 B500     push    r14                                     
0801D956 4805     ldr     r0,=3000738h                            
0801D958 3024     add     r0,24h                                  
0801D95A 7800     ldrb    r0,[r0]                                 
0801D95C 2823     cmp     r0,23h                                  
0801D95E D85F     bhi     801DA20h  ;比较POSE值如果大于23h跳转                              
0801D960 0080     lsl     r0,r0,2h                                
0801D962 4903     ldr     r1,=poseTable                            
0801D964 1840     add     r0,r0,r1                                
0801D966 6800     ldr     r0,[r0]                                 
0801D968 4687     mov     r15,r0 
                                 
poseTable:  
     .word 801da04h ;00
     .word 801da0ah ;01
	 .word 801da20h .word 801da20h .word 801da20h .word 801da20h
	 .word 801da20h .word 801da20h .word 801da20h
	 .word 801da10h ;09h
	 .word 801da20h .word 801da20h .word 801da20h .word 801da20h 
	 .word 801da20h
	 .word 801da1ch ;0fh
	 .word 801da20h .word 801da20h .word 801da20h .word 801da20h 
	 .word 801da20h .word 801da20h .word 801da20h .word 801da20h
	 .word 801da20h .word 801da20h .word 801da20h .word 801da20h
	 .word 801da20h .word 801da20h .word 801da20h .word 801da20h
	 .word 801da20h .word 801da20h .word 801da20h
	 .word 801da16h ;23h
                            
0801DA04 F7FFFEB4 bl      801D770h    ;00                            
0801DA08 E00A     b       @@end                                
0801DA0A F7FFFF0D bl      801D828h    ;01                            
0801DA0E E007     b       @@end                                
0801DA10 F7FFFF3C bl      801D88Ch    ;09h                            
0801DA14 E004     b       @@end                                
0801DA16 F7FFFF75 bl      801D904h    ;23h                            
0801DA1A E001     b       @@end                              
0801DA1C F7FFFF2A bl      801D874h    ;0fh        
@@end:                    
0801DA20 BC01     pop     r0                                      
0801DA22 4700     bx      r0 
                                     
0801DA24 B570     push    r4-r6,r14                               
0801DA26 2600     mov     r6,0h                                   
0801DA28 4C0B     ldr     r4,=3000738h                            
0801DA2A 8821     ldrh    r1,[r4]                                 
0801DA2C 2080     mov     r0,80h                                  
0801DA2E 00C0     lsl     r0,r0,3h                                
0801DA30 4008     and     r0,r1                                   
0801DA32 2800     cmp     r0,0h                                   
0801DA34 D026     beq     801DA84h                                
0801DA36 2040     mov     r0,40h                                  
0801DA38 4008     and     r0,r1                                   
0801DA3A 2800     cmp     r0,0h                                   
0801DA3C D010     beq     801DA60h                                
0801DA3E 8860     ldrh    r0,[r4,2h]                              
0801DA40 3820     sub     r0,20h                                  
0801DA42 88A1     ldrh    r1,[r4,4h]                              
0801DA44 F7F1FE20 bl      800F688h                                
0801DA48 4D04     ldr     r5,=30007F1h                            
0801DA4A 7828     ldrb    r0,[r5]                                 
0801DA4C 2800     cmp     r0,0h                                   
0801DA4E D13F     bne     801DAD0h                                
0801DA50 8860     ldrh    r0,[r4,2h]                              
0801DA52 3020     add     r0,20h                                  
0801DA54 88A1     ldrh    r1,[r4,4h]                              
0801DA56 E035     b       801DAC4h                                
0801DA58 0738     lsl     r0,r7,1Ch                               
0801DA5A 0300     lsl     r0,r0,0Ch                               
0801DA5C 07F1     lsl     r1,r6,1Fh                               
0801DA5E 0300     lsl     r0,r0,0Ch                               
0801DA60 8860     ldrh    r0,[r4,2h]                              
0801DA62 3820     sub     r0,20h                                  
0801DA64 88A1     ldrh    r1,[r4,4h]                              
0801DA66 3904     sub     r1,4h                                   
0801DA68 F7F1FE0E bl      800F688h                                
0801DA6C 4D04     ldr     r5,=30007F1h                            
0801DA6E 7828     ldrb    r0,[r5]                                 
0801DA70 2800     cmp     r0,0h                                   
0801DA72 D12D     bne     801DAD0h                                
0801DA74 8860     ldrh    r0,[r4,2h]                              
0801DA76 3020     add     r0,20h                                  
0801DA78 88A1     ldrh    r1,[r4,4h]                              
0801DA7A 3904     sub     r1,4h                                   
0801DA7C E022     b       801DAC4h                                
0801DA7E 0000     lsl     r0,r0,0h                                
0801DA80 07F1     lsl     r1,r6,1Fh                               
0801DA82 0300     lsl     r0,r0,0Ch                               
0801DA84 1C20     mov     r0,r4                                   
0801DA86 302E     add     r0,2Eh                                  
0801DA88 7800     ldrb    r0,[r0]                                 
0801DA8A 2800     cmp     r0,0h                                   
0801DA8C D00E     beq     801DAACh                                
0801DA8E 8860     ldrh    r0,[r4,2h]                              
0801DA90 3804     sub     r0,4h                                   
0801DA92 88A1     ldrh    r1,[r4,4h]                              
0801DA94 3920     sub     r1,20h                                  
0801DA96 F7F1FDF7 bl      800F688h                                
0801DA9A 4D03     ldr     r5,=30007F1h                            
0801DA9C 7828     ldrb    r0,[r5]                                 
0801DA9E 2800     cmp     r0,0h                                   
0801DAA0 D116     bne     801DAD0h                                
0801DAA2 8860     ldrh    r0,[r4,2h]                              
0801DAA4 3804     sub     r0,4h                                   
0801DAA6 E00B     b       801DAC0h                                
0801DAA8 07F1     lsl     r1,r6,1Fh                               
0801DAAA 0300     lsl     r0,r0,0Ch                               
0801DAAC 8860     ldrh    r0,[r4,2h]                              
0801DAAE 88A1     ldrh    r1,[r4,4h]                              
0801DAB0 3920     sub     r1,20h                                  
0801DAB2 F7F1FDE9 bl      800F688h                                
0801DAB6 4D08     ldr     r5,=30007F1h                            
0801DAB8 7828     ldrb    r0,[r5]                                 
0801DABA 2800     cmp     r0,0h                                   
0801DABC D108     bne     801DAD0h                                
0801DABE 8860     ldrh    r0,[r4,2h]                              
0801DAC0 88A1     ldrh    r1,[r4,4h]                              
0801DAC2 3120     add     r1,20h                                  
0801DAC4 F7F1FDE0 bl      800F688h                                
0801DAC8 7828     ldrb    r0,[r5]                                 
0801DACA 2800     cmp     r0,0h                                   
0801DACC D100     bne     801DAD0h                                
0801DACE 2601     mov     r6,1h                                   
0801DAD0 1C30     mov     r0,r6                                   
0801DAD2 BC70     pop     r4-r6                                   
0801DAD4 BC02     pop     r1                                      
0801DAD6 4708     bx      r1                                      
0801DAD8 07F1     lsl     r1,r6,1Fh                               
0801DADA 0300     lsl     r0,r0,0Ch                               
0801DADC B500     push    r14                                     
0801DADE 4909     ldr     r1,=3000738h                            
0801DAE0 880A     ldrh    r2,[r1]                                 
0801DAE2 2080     mov     r0,80h                                  
0801DAE4 00C0     lsl     r0,r0,3h                                
0801DAE6 4010     and     r0,r2                                   
0801DAE8 2800     cmp     r0,0h                                   
0801DAEA D01D     beq     801DB28h                                
0801DAEC 2040     mov     r0,40h                                  
0801DAEE 4010     and     r0,r2                                   
0801DAF0 2800     cmp     r0,0h                                   
0801DAF2 D00D     beq     801DB10h                                
0801DAF4 4804     ldr     r0,=0FFE4h                              
0801DAF6 8148     strh    r0,[r1,0Ah]                             
0801DAF8 201C     mov     r0,1Ch                                  
0801DAFA 8188     strh    r0,[r1,0Ch]                             
0801DAFC 4803     ldr     r0,=0FFCCh                              
0801DAFE 81C8     strh    r0,[r1,0Eh]                             
0801DB00 2004     mov     r0,4h                                   
0801DB02 E024     b       801DB4Eh                                
0801DB04 0738     lsl     r0,r7,1Ch                               
0801DB06 0300     lsl     r0,r0,0Ch                               
0801DB08 FFE4     bl      lr+0FC8h                                
0801DB0A 0000     lsl     r0,r0,0h                                
0801DB0C FFCC     bl      lr+0F98h                                
0801DB0E 0000     lsl     r0,r0,0h                                
0801DB10 4803     ldr     r0,=0FFE4h                              
0801DB12 8148     strh    r0,[r1,0Ah]                             
0801DB14 201C     mov     r0,1Ch                                  
0801DB16 8188     strh    r0,[r1,0Ch]                             
0801DB18 4802     ldr     r0,=0FFFCh                              
0801DB1A 81C8     strh    r0,[r1,0Eh]                             
0801DB1C 2034     mov     r0,34h                                  
0801DB1E E016     b       801DB4Eh                                
0801DB20 FFE4     bl      lr+0FC8h                                
0801DB22 0000     lsl     r0,r0,0h                                
0801DB24 FFFC     bl      lr+0FF8h                                
0801DB26 0000     lsl     r0,r0,0h                                
0801DB28 1C08     mov     r0,r1                                   
0801DB2A 302E     add     r0,2Eh                                  
0801DB2C 7800     ldrb    r0,[r0]                                 
0801DB2E 2800     cmp     r0,0h                                   
0801DB30 D006     beq     801DB40h                                
0801DB32 4802     ldr     r0,=0FFFCh                              
0801DB34 8148     strh    r0,[r1,0Ah]                             
0801DB36 2034     mov     r0,34h                                  
0801DB38 E005     b       801DB46h                                
0801DB3A 0000     lsl     r0,r0,0h                                
0801DB3C FFFC     bl      lr+0FF8h                                
0801DB3E 0000     lsl     r0,r0,0h                                
0801DB40 4804     ldr     r0,=0FFCCh                              
0801DB42 8148     strh    r0,[r1,0Ah]                             
0801DB44 2004     mov     r0,4h                                   
0801DB46 8188     strh    r0,[r1,0Ch]                             
0801DB48 4803     ldr     r0,=0FFE4h                              
0801DB4A 81C8     strh    r0,[r1,0Eh]                             
0801DB4C 201C     mov     r0,1Ch                                  
0801DB4E 8208     strh    r0,[r1,10h]                             
0801DB50 BC01     pop     r0                                      
0801DB52 4700     bx      r0                                      
0801DB54 FFCC     bl      lr+0F98h                                
0801DB56 0000     lsl     r0,r0,0h                                
0801DB58 FFE4     bl      lr+0FC8h                                
0801DB5A 0000     lsl     r0,r0,0h                                
0801DB5C B500     push    r14                                     
0801DB5E 4907     ldr     r1,=3000738h                            
0801DB60 880A     ldrh    r2,[r1]                                 
0801DB62 2080     mov     r0,80h                                  
0801DB64 00C0     lsl     r0,r0,3h                                
0801DB66 4010     and     r0,r2                                   
0801DB68 2800     cmp     r0,0h                                   
0801DB6A D011     beq     801DB90h                                
0801DB6C 2080     mov     r0,80h                                  
0801DB6E 0080     lsl     r0,r0,2h                                
0801DB70 4010     and     r0,r2                                   
0801DB72 2800     cmp     r0,0h                                   
0801DB74 D006     beq     801DB84h                                
0801DB76 4802     ldr     r0,=82CFC78h                            
0801DB78 6188     str     r0,[r1,18h]                             
0801DB7A E024     b       801DBC6h                                
0801DB7C 0738     lsl     r0,r7,1Ch                               
0801DB7E 0300     lsl     r0,r0,0Ch                               
0801DB80 FC78     bl      lr+8F0h                                 
0801DB82 082C     lsr     r4,r5,20h                               
0801DB84 4801     ldr     r0,=82CFC40h                            
0801DB86 6188     str     r0,[r1,18h]                             
0801DB88 E01D     b       801DBC6h                                
0801DB8A 0000     lsl     r0,r0,0h                                
0801DB8C FC40     bl      lr+880h                                 
0801DB8E 082C     lsr     r4,r5,20h                               
0801DB90 1C08     mov     r0,r1                                   
0801DB92 302E     add     r0,2Eh                                  
0801DB94 7800     ldrb    r0,[r0]                                 
0801DB96 2800     cmp     r0,0h                                   

0801D89E 4008     and     r0,r1                                   
0801D8A0 2800     cmp     r0,0h                                   
0801D8A2 D011     beq     801D8C8h                                
0801D8A4 4906     ldr     r1,=30001ACh                            
0801D8A6 00D0     lsl     r0,r2,3h                                
0801D8A8 1A80     sub     r0,r0,r2                                
0801D8AA 00C0     lsl     r0,r0,3h                                
0801D8AC 1840     add     r0,r0,r1                                
0801D8AE 2102     mov     r1,2h                                   
0801D8B0 8281     strh    r1,[r0,14h]                             
0801D8B2 2401     mov     r4,1h                                   
0801D8B4 4803     ldr     r0,=111h                                
0801D8B6 F7E5F8AF bl      8002A18h                                
0801D8BA E00E     b       801D8DAh                                
0801D8BC 0738     lsl     r0,r7,1Ch                               
0801D8BE 0300     lsl     r0,r0,0Ch                               
0801D8C0 01AC     lsl     r4,r5,6h                                
0801D8C2 0300     lsl     r0,r0,0Ch                               
0801D8C4 0111     lsl     r1,r2,4h                                
0801D8C6 0000     lsl     r0,r0,0h                                
0801D8C8 480B     ldr     r0,=30001ACh                            
0801D8CA 00D1     lsl     r1,r2,3h                                
0801D8CC 1A89     sub     r1,r1,r2                                
0801D8CE 00C9     lsl     r1,r1,3h                                
0801D8D0 1809     add     r1,r1,r0                                
0801D8D2 8A88     ldrh    r0,[r1,14h]                             
0801D8D4 2802     cmp     r0,2h                                   
0801D8D6 D100     bne     801D8DAh                                
0801D8D8 2401     mov     r4,1h                                   
0801D8DA 2C00     cmp     r4,0h                                   
0801D8DC D009     beq     801D8F2h                                
0801D8DE 4907     ldr     r1,=3000738h                            
0801D8E0 1C0B     mov     r3,r1                                   
0801D8E2 3324     add     r3,24h                                  
0801D8E4 2200     mov     r2,0h                                   
0801D8E6 2023     mov     r0,23h                                  
0801D8E8 7018     strb    r0,[r3]                                 
0801D8EA 770A     strb    r2,[r1,1Ch]                             
0801D8EC 82CA     strh    r2,[r1,16h]                             
0801D8EE 4804     ldr     r0,=82CEA70h                            
0801D8F0 6188     str     r0,[r1,18h]                             
0801D8F2 BC10     pop     r4                                      
0801D8F4 BC01     pop     r0                                      
0801D8F6 4700     bx      r0                                      
0801D8F8 01AC     lsl     r4,r5,6h                                
0801D8FA 0300     lsl     r0,r0,0Ch                               
0801D8FC 0738     lsl     r0,r7,1Ch                               
0801D8FE 0300     lsl     r0,r0,0Ch                               
0801D900 EA70     ????                                            
0801D902 082C     lsr     r4,r5,20h                               
0801D904 B500     push    r14                                     
0801D906 4807     ldr     r0,=3000738h                            
0801D908 302D     add     r0,2Dh                                  
0801D90A 7801     ldrb    r1,[r0]                                 
0801D90C 4A06     ldr     r2,=30001ACh                            
0801D90E 00C8     lsl     r0,r1,3h                                
0801D910 1A40     sub     r0,r0,r1                                
0801D912 00C0     lsl     r0,r0,3h                                
0801D914 1880     add     r0,r0,r2                                
0801D916 8A80     ldrh    r0,[r0,14h]                             
0801D918 2801     cmp     r0,1h                                   
0801D91A D101     bne     801D920h                                
0801D91C F7FFFF74 bl      801D808h                                
0801D920 BC01     pop     r0                                      
0801D922 4700     bx      r0                                      
0801D924 0738     lsl     r0,r7,1Ch                               
0801D926 0300     lsl     r0,r0,0Ch                               
0801D928 01AC     lsl     r4,r5,6h                                
0801D92A 0300     lsl     r0,r0,0Ch                               
0801D92C B500     push    r14                                     
0801D92E 4804     ldr     r0,=3000738h                            
0801D930 3024     add     r0,24h                                  
0801D932 7800     ldrb    r0,[r0]                                 
0801D934 2800     cmp     r0,0h                                   
0801D936 D005     beq     801D944h                                
0801D938 2809     cmp     r0,9h                                   
0801D93A D006     beq     801D94Ah                                
0801D93C E007     b       801D94Eh                                
0801D93E 0000     lsl     r0,r0,0h                                
0801D940 0738     lsl     r0,r7,1Ch                               
0801D942 0300     lsl     r0,r0,0Ch                               
0801D944 F7FFFE80 bl      801D648h                                


