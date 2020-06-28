


0802872C B570     push    r4-r6,r14                               
0802872E 4B20     ldr     r3,=3000738h                            
08028730 1C18     mov     r0,r3                                   
08028732 3026     add     r0,26h                                  
08028734 2500     mov     r5,0h                                   
08028736 2601     mov     r6,1h                                   
08028738 7006     strb    r6,[r0]       ;300075e写入1                             
0802873A 1C1C     mov     r4,r3                                   
0802873C 3424     add     r4,24h                                  
0802873E 7820     ldrb    r0,[r4]                                 
08028740 2800     cmp     r0,0h                                   
08028742 D124     bne     @@PoseNoZero                                
08028744 8858     ldrh    r0,[r3,2h]                              
08028746 3808     sub     r0,8h         ;垂直坐标上升半格                          
08028748 2200     mov     r2,0h                                   
0802874A 8058     strh    r0,[r3,2h]    ;再写入                          
0802874C 2032     mov     r0,32h                                  
0802874E 18C0     add     r0,r0,r3                                
08028750 4684     mov     r12,r0                                  
08028752 7800     ldrb    r0,[r0]       ;读取碰撞属性                          
08028754 2101     mov     r1,1h                                   
08028756 4308     orr     r0,r1         ;碰撞属性 orr 1                          
08028758 4661     mov     r1,r12                                  
0802875A 7008     strb    r0,[r1]       ;再写入                          
0802875C 1C18     mov     r0,r3                                   
0802875E 3025     add     r0,25h                                  
08028760 7002     strb    r2,[r0]       ;属性写入0                          
08028762 2009     mov     r0,9h                                   
08028764 7020     strb    r0,[r4]       ;pose写入9                          
08028766 1C18     mov     r0,r3                                   
08028768 3027     add     r0,27h                                  
0802876A 7006     strb    r6,[r0]       ;300075f写入1                          
0802876C 1C19     mov     r1,r3                                   
0802876E 3128     add     r1,28h                                  
08028770 2008     mov     r0,8h                                   
08028772 7008     strb    r0,[r1]       ;3000760写入8h                          
08028774 3101     add     r1,1h                                   
08028776 2010     mov     r0,10h                                  
08028778 7008     strb    r0,[r1]       ;3000761写入10h                          
0802877A 490E     ldr     r1,=0FFFCh                              
0802877C 8159     strh    r1,[r3,0Ah]   ;上部分界写入4h                          
0802877E 2004     mov     r0,4h         ;下部分界写入4h                          
08028780 8198     strh    r0,[r3,0Ch]                             
08028782 81D9     strh    r1,[r3,0Eh]   ;左部分界写入4h                          
08028784 8218     strh    r0,[r3,10h]   ;右部分界写入4h                          
08028786 480C     ldr     r0,=82E0FE8h  ;写入OAM                          
08028788 6198     str     r0,[r3,18h]                             
0802878A 771A     strb    r2,[r3,1Ch]                             
0802878C 82DD     strh    r5,[r3,16h] 

@@PoseNoZero:                            
0802878E 490B     ldr     r1,=30013D4h                            
08028790 7808     ldrb    r0,[r1]                                 
08028792 281D     cmp     r0,1Dh        ;使用电梯的姿势                           
08028794 D116     bne     @@UnUseElevator                                
08028796 8A88     ldrh    r0,[r1,14h]   ;读取SA Y坐标                          
08028798 8058     strh    r0,[r3,2h]    ;写入电梯Y坐标                          
0802879A 8A48     ldrh    r0,[r1,12h]   ;读取SA X坐标                          
0802879C 8098     strh    r0,[r3,4h]    ;写入电梯X坐标                          
0802879E 6999     ldr     r1,[r3,18h]   ;读取OAM                          
080287A0 4805     ldr     r0,=82E0FE8h                            
080287A2 4281     cmp     r1,r0                                   
080287A4 D116     bne     @@end                                
080287A6 4806     ldr     r0,=82E0FC0h                            
080287A8 6198     str     r0,[r3,18h]                             
080287AA 2000     mov     r0,0h                                   
080287AC 7718     strb    r0,[r3,1Ch]                             
080287AE E010     b       @@Peer                               

@@UnUseElevator:                              
080287C4 6999     ldr     r1,[r3,18h]                             
080287C6 4805     ldr     r0,=82E0FC0h                            
080287C8 4281     cmp     r1,r0                                   
080287CA D103     bne     @@end                                
080287CC 4804     ldr     r0,=82E0FE8h                            
080287CE 6198     str     r0,[r3,18h]                             
080287D0 771D     strb    r5,[r3,1Ch]

@@Peer:                             
080287D2 82DD     strh    r5,[r3,16h]

@@end:                             
080287D4 BC70     pop     r4-r6                                   
080287D6 BC01     pop     r0                                      
080287D8 4700     bx      r0
