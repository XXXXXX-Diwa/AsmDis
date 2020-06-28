
0800F8E0 B500     push    r14                                     
0800F8E2 4A05     ldr     r2,=3000738h                            
0800F8E4 4905     ldr     r1,=30013D4h                            
0800F8E6 8890     ldrh    r0,[r2,4h]    ;获取精灵X坐标                           
0800F8E8 8A49     ldrh    r1,[r1,12h]   ;获取人物X坐标                          
0800F8EA 4288     cmp     r0,r1         ;精灵和人物位置比较                          
0800F8EC D90A     bls     @@SpriteAtLeft  ;小于或等于跳转                          
0800F8EE 8811     ldrh    r1,[r2]                                 
0800F8F0 4803     ldr     r0,=0FDFFh                              
0800F8F2 4008     and     r0,r1         ;取向去除200h                          
0800F8F4 E00B     b       @@end                                

@@SpriteAtLeft:                              
0800F904 8811     ldrh    r1,[r2]                                 
0800F906 2380     mov     r3,80h                                  
0800F908 009B     lsl     r3,r3,2h                                
0800F90A 1C18     mov     r0,r3                                   
0800F90C 4308     orr     r0,r1        ;取向orr200h 

@@end:                              
0800F90E 8010     strh    r0,[r2]      ;再写入                           
0800F910 BC01     pop     r0                                      
0800F912 4700     bx      r0                                      


;pose 0
08047620 B510     push    r4,r14                                  
08047622 4808     ldr     r0,=3000738h                            
08047624 7F41     ldrb    r1,[r0,1Dh]                             
08047626 1C04     mov     r4,r0                                   
08047628 29C3     cmp     r1,0C3h       ;比较ID                             
0804762A D001     beq     @@Boss                                
0804762C 29C8     cmp     r1,0C8h                                 
0804762E D10E     bne     @@Noboss

@@Boss:                                
08047630 2003     mov     r0,3h                                   
08047632 2134     mov     r1,34h                                  
08047634 F019F942 bl      80608BCh      ;检查事件34h                             
08047638 2800     cmp     r0,0h                                   
0804763A D005     beq     @@Noactivation                                
0804763C 2000     mov     r0,0h                                   
0804763E 8020     strh    r0,[r4]       ;敌人消失                            
08047640 E02B     b       @@end                                

@@Noactivation:                              
08047648 4915     ldr     r1,=300007Bh                            
0804764A 2001     mov     r0,1h                                   
0804764C 7008     strb    r0,[r1]       ;锁门

@@Noboss:                               
0804764E 1C21     mov     r1,r4                                   
08047650 3124     add     r1,24h                                  
08047652 2200     mov     r2,0h                                   
08047654 200E     mov     r0,0Eh                                   
08047656 7008     strb    r0,[r1]       ;pose写入0Eh                            
08047658 4812     ldr     r0,=831043Ch                            
0804765A 61A0     str     r0,[r4,18h]   ;写入OAM                          
0804765C 7722     strb    r2,[r4,1Ch]                             
0804765E 82E2     strh    r2,[r4,16h]                             
08047660 3103     add     r1,3h                                   
08047662 2030     mov     r0,30h                                  
08047664 7008     strb    r0,[r1]       ;300075f写入30h                           
08047666 3101     add     r1,1h                                   
08047668 2008     mov     r0,8h         ;3000760写入8h                          
0804766A 7008     strb    r0,[r1]                                 
0804766C 3101     add     r1,1h                                   
0804766E 2028     mov     r0,28h        ;3000761写入28h                           
08047670 7008     strb    r0,[r1]                                 
08047672 480D     ldr     r0,=0FF60h                              
08047674 8160     strh    r0,[r4,0Ah]   ;上部分界写入FF60h a0                         
08047676 81A2     strh    r2,[r4,0Ch]   ;下部分界写入0                          
08047678 304C     add     r0,4Ch                                  
0804767A 81E0     strh    r0,[r4,0Eh]   ;左部分界写入FFAC 54h                         
0804767C 2054     mov     r0,54h                                  
0804767E 8220     strh    r0,[r4,10h]   ;右部分界写入54h                          
08047680 3904     sub     r1,4h                                   
08047682 2004     mov     r0,4h                                   
08047684 7008     strb    r0,[r1]       ;属性写入4h                          
08047686 4A09     ldr     r2,=82B0D68h                            
08047688 7F61     ldrb    r1,[r4,1Dh]                             
0804768A 00C8     lsl     r0,r1,3h                                
0804768C 1840     add     r0,r0,r1                                
0804768E 0040     lsl     r0,r0,1h                                
08047690 1880     add     r0,r0,r2                                
08047692 8800     ldrh    r0,[r0]       ;写入血量                          
08047694 82A0     strh    r0,[r4,14h]                             
08047696 F7C8F923 bl      800F8E0h      ;标记方向

@@end:                           
0804769A BC10     pop     r4                                      
0804769C BC01     pop     r0                                      
0804769E 4700     bx      r0  

                                    
;pose 8h								   ;起跳动作	
080476B0 B500     push    r14                                     
080476B2 490A     ldr     r1,=3000738h                            
080476B4 1C0B     mov     r3,r1                                   
080476B6 3324     add     r3,24h                                  
080476B8 2200     mov     r2,0h                                   
080476BA 2009     mov     r0,9h            ;pose写入9h                       
080476BC 7018     strb    r0,[r3]                                 
080476BE 770A     strb    r2,[r1,1Ch]                             
080476C0 82CA     strh    r2,[r1,16h]                             
080476C2 4807     ldr     r0,=8310464h                            
080476C4 6188     str     r0,[r1,18h]      ;写入新OAM                        
080476C6 8809     ldrh    r1,[r1]                                 
080476C8 2002     mov     r0,2h                                   
080476CA 4008     and     r0,r1            ;2 and 取向                       
080476CC 2800     cmp     r0,0h            ;在屏幕外                       
080476CE D003     beq     @@end                                
080476D0 20C6     mov     r0,0C6h          ;预跳音?                        
080476D2 0040     lsl     r0,r0,1h                                
080476D4 F7BBFA24 bl      8002B20h

@@end                                
080476D8 BC01     pop     r0                                      
080476DA 4700     bx      r0                                      

;pose 9                                    ;跳跃                              
080476E4 B570     push    r4-r6,r14                               
080476E6 4C0C     ldr     r4,=3000738h                            
080476E8 8866     ldrh    r6,[r4,2h]                              
080476EA 88A5     ldrh    r5,[r4,4h]       ;获取坐标                          
080476EC 2010     mov     r0,10h                                  
080476EE 5E21     ldsh    r1,[r4,r0]       ;读取右部边界                      
080476F0 1869     add     r1,r5,r1         ;加上X坐标的值                       
080476F2 1C30     mov     r0,r6                                   
080476F4 F7C8F814 bl      800F720h         ;检查砖块                        
080476F8 2800     cmp     r0,0h                                   
080476FA D10F     bne     @@Peer                                
080476FC 200E     mov     r0,0Eh                                  
080476FE 5E21     ldsh    r1,[r4,r0]       ;读取左部边界                       
08047700 1869     add     r1,r5,r1         ;加上X坐标的值                       
08047702 1C30     mov     r0,r6                                   
08047704 F7C8F80C bl      800F720h         ;检查砖块                       
08047708 2800     cmp     r0,0h                                   
0804770A D107     bne     @@Peer                                
0804770C 1C21     mov     r1,r4                                   
0804770E 3124     add     r1,24h           ;pose写入1Eh                       
08047710 201E     mov     r0,1Eh           ;wu砖块才会写入1E                       
08047712 7008     strb    r0,[r1]                                 
08047714 E01B     b       @@end                                

@@Peer:                             
0804771C F7C8FA54 bl      800FBC8h                                
08047720 2800     cmp     r0,0h                                   
08047722 D014     beq     @@end                                
08047724 4B0B     ldr     r3,=3000738h                            
08047726 1C19     mov     r1,r3                                   
08047728 3124     add     r1,24h                                  
0804772A 2200     mov     r2,0h                                   
0804772C 2023     mov     r0,23h          ;pose写入23h   跳起                     
0804772E 7008     strb    r0,[r1]                                 
08047730 771A     strb    r2,[r3,1Ch]                             
08047732 2000     mov     r0,0h                                   
08047734 82DA     strh    r2,[r3,16h]                             
08047736 310B     add     r1,0Bh                                  
08047738 7008     strb    r0,[r1]                                 
0804773A 4807     ldr     r0,=8310484h    ;写入新OAM                        
0804773C 6198     str     r0,[r3,18h]                             
0804773E 8819     ldrh    r1,[r3]                                 
08047740 2002     mov     r0,2h                                   
08047742 4008     and     r0,r1           ;屏幕内检查                        
08047744 2800     cmp     r0,0h                                   
08047746 D002     beq     @@end                                
08047748 4804     ldr     r0,=18Dh        ;跳音?                        
0804774A F7BBF9E9 bl      8002B20h

@@end:                                
0804774E BC70     pop     r4-r6                                   
08047750 BC01     pop     r0                                      
08047752 4700     bx      r0                                      


;pose 23h                                ;空中
08047760 B570     push    r4-r6,r14                               
08047762 4913     ldr     r1,=830F54Ch                            
08047764 4C13     ldr     r4,=3000738h                            
08047766 1C20     mov     r0,r4                                   
08047768 302F     add     r0,2Fh         ;读取3000767的值                              
0804776A 7800     ldrb    r0,[r0]                                 
0804776C 0880     lsr     r0,r0,2h       ;除以4                          
0804776E 0040     lsl     r0,r0,1h       ;乘2                         
08047770 1840     add     r0,r0,r1                                
08047772 2100     mov     r1,0h                                   
08047774 5E46     ldsh    r6,[r0,r1]     ;读取跳跃速度                         
08047776 8821     ldrh    r1,[r4]                                 
08047778 2580     mov     r5,80h                                  
0804777A 00AD     lsl     r5,r5,2h                                
0804777C 1C28     mov     r0,r5                                   
0804777E 4008     and     r0,r1          ;200 and 取向                           
08047780 2800     cmp     r0,0h                                   
08047782 D020     beq     @@SpriteAtRight                               
08047784 8860     ldrh    r0,[r4,2h]     ;读取Y坐标                         
08047786 3810     sub     r0,10h         ;向上10h                         
08047788 2210     mov     r2,10h                                  
0804778A 5EA1     ldsh    r1,[r4,r2]     ;获取右部分界                         
0804778C 88A2     ldrh    r2,[r4,4h]     ;X坐标                         
0804778E 1889     add     r1,r1,r2       ;性价                         
08047790 3104     add     r1,4h          ;再向右4h                         
08047792 F7C7FF79 bl      800F688h                                
08047796 4808     ldr     r0,=30007F1h                            
08047798 7800     ldrb    r0,[r0]                                 
0804779A 2811     cmp     r0,11h                                  
0804779C D110     bne     @@Noblock                               
0804779E 88A0     ldrh    r0,[r4,4h]                              
080477A0 380A     sub     r0,0Ah        ;如果有砖的话则向左移动0Ah                          
080477A2 80A0     strh    r0,[r4,4h]                              
080477A4 8821     ldrh    r1,[r4]                                 
080477A6 4805     ldr     r0,=0FDFFh    ;去掉取向的200h                          
080477A8 4008     and     r0,r1                                   
080477AA 8020     strh    r0,[r4]                                 
080477AC E04F     b       @@Peer5                                

@@Noblock:                               
080477C0 88A0     ldrh    r0,[r4,4h]      ;X坐标向右移动Ah                          
080477C2 300A     add     r0,0Ah                                  
080477C4 E018     b       @@Peer4 

@@SpriteAtRight:                              
080477C6 8860     ldrh    r0,[r4,2h]                              
080477C8 3810     sub     r0,10h                                  
080477CA 220E     mov     r2,0Eh                                  
080477CC 5EA1     ldsh    r1,[r4,r2]      ;读取左部分界                          
080477CE 88A2     ldrh    r2,[r4,4h]                              
080477D0 1889     add     r1,r1,r2        ;加上X坐标                         
080477D2 3904     sub     r1,4h           ;向左再延伸4h                        
080477D4 F7C7FF58 bl      800F688h        ;检查砖块                        
080477D8 4805     ldr     r0,=30007F1h                            
080477DA 7800     ldrb    r0,[r0]                                 
080477DC 2811     cmp     r0,11h                                  
080477DE D109     bne     @@Noblock2                                
080477E0 88A0     ldrh    r0,[r4,4h]      ;碰壁                         
080477E2 300A     add     r0,0Ah          ;向右0Ah                        
080477E4 80A0     strh    r0,[r4,4h]                              
080477E6 8821     ldrh    r1,[r4]                                 
080477E8 1C28     mov     r0,r5                                   
080477EA 4308     orr     r0,r1           ;取向orr200h                            
080477EC 8020     strh    r0,[r4]                                 
080477EE E02E     b       @@Peer5                                  

@@Noblock2:                             
080477F4 88A0     ldrh    r0,[r4,4h]                              
080477F6 380A     sub     r0,0Ah  

@@Peer4:                                  ;不碰壁
080477F8 80A0     strh    r0,[r4,4h]                              
080477FA 4C0D     ldr     r4,=3000738h                            
080477FC 8860     ldrh    r0,[r4,2h]                              
080477FE 1980     add     r0,r0,r6        ;读取Y坐标加上设定的跳跃高度                        
08047800 8060     strh    r0,[r4,2h]      ;再写入                        
08047802 1C21     mov     r1,r4                                   
08047804 312F     add     r1,2Fh                                  
08047806 7808     ldrb    r0,[r1]         ;读取3000767的值                        
08047808 2826     cmp     r0,26h          ;比较是否大于26h  也就是跳跃的Y速度最多停在26h                      
0804780A D801     bhi     @@SpeedAddStop                                
0804780C 3001     add     r0,1h           ;加1再写入                        
0804780E 7008     strb    r0,[r1]

@@SpeedAddStop:                                 
08047810 2E00     cmp     r6,0h                                   
08047812 DD11     ble     @@Speednothan0        ;小于等于0                         
08047814 8860     ldrh    r0,[r4,2h]            ;一旦大于0则代表到了下落的数值                  
08047816 88A1     ldrh    r1,[r4,4h]            ;读取坐标                     
08047818 F7C7FE30 bl      800F47Ch                                
0804781C 1C01     mov     r1,r0                                   
0804781E 4805     ldr     r0,=30007F0h                            
08047820 7800     ldrb    r0,[r0]                                 
08047822 2800     cmp     r0,0h                                   
08047824 D017     beq     @@end                                
08047826 8061     strh    r1,[r4,2h]          ;写入Y坐标                    
08047828 1C21     mov     r1,r4                                   
0804782A 3124     add     r1,24h              ;pose写入24h  碰顶下落                  
0804782C 2024     mov     r0,24h                                  
0804782E E011     b       @@Peer6                                

@@Speednothan0:                              
08047838 210A     mov     r1,0Ah                                  
0804783A 5E60     ldsh    r0,[r4,r1]          ;检查上部分界                     
0804783C 8862     ldrh    r2,[r4,2h]          ;加上Y坐标                    
0804783E 1880     add     r0,r0,r2                                
08047840 88A1     ldrh    r1,[r4,4h]                              
08047842 F7C7FF21 bl      800F688h                                
08047846 4805     ldr     r0,=30007F1h                            
08047848 7800     ldrb    r0,[r0]                                 
0804784A 2811     cmp     r0,11h                                  
0804784C D103     bne     @@end               ;未碰顶

@@Peer5:                               
0804784E 1C21     mov     r1,r4                                   
08047850 3124     add     r1,24h                                  
08047852 201E     mov     r0,1Eh              ;pose写入1eh 碰壁?

@@Peer6:                                  
08047854 7008     strb    r0,[r1] 

@@end:                                
08047856 BC70     pop     r4-r6                                   
08047858 BC01     pop     r0                                      
0804785A 4700     bx      r0                                      


;pose 24h                                  ;快落地                 
08047860 B500     push    r14                                     
08047862 490C     ldr     r1,=3000738h                            
08047864 1C0B     mov     r3,r1                                   
08047866 3324     add     r3,24h                                  
08047868 2200     mov     r2,0h                                   
0804786A 2025     mov     r0,25h              ;pose写入25h                          
0804786C 7018     strb    r0,[r3]                                 
0804786E 770A     strb    r2,[r1,1Ch]                             
08047870 82CA     strh    r2,[r1,16h]                             
08047872 4809     ldr     r0,=831049Ch                            
08047874 6188     str     r0,[r1,18h]         ;写入新OAM                     
08047876 8809     ldrh    r1,[r1]                                 
08047878 2002     mov     r0,2h                                   
0804787A 4008     and     r0,r1               ;2 and 取向                    
0804787C 2800     cmp     r0,0h                                   
0804787E D007     beq     @@OutScreen                                
08047880 200A     mov     r0,0Ah                                  
08047882 2181     mov     r1,81h                                  
08047884 F00DFD5E bl      8055344h            ;垂直震动                    
08047888 20C7     mov     r0,0C7h                                 
0804788A 0040     lsl     r0,r0,1h            ;砸地声                    
0804788C F7BBF948 bl      8002B20h 

@@OutScreen:                               
08047890 BC01     pop     r0                                      
08047892 4700     bx      r0                                      

;pose 25h                             
0804789C B500     push    r14                                     
0804789E F7C8F9AF bl      800FC00h                                
080478A2 2800     cmp     r0,0h             ;检查动画结束                      
080478A4 D003     beq     @@end                                
080478A6 4803     ldr     r0,=3000738h                            
080478A8 3024     add     r0,24h                                  
080478AA 210E     mov     r1,0Eh            ;pose写入0Eh                       
080478AC 7001     strb    r1,[r0]

@@end:                                 
080478AE BC01     pop     r0                                      
080478B0 4700     bx      r0                                      

;Pose 0eh             ;写入OAM以及设定随机                  
080478B8 4908     ldr     r1,=3000738h                            
080478BA 1C0A     mov     r2,r1                                   
080478BC 3224     add     r2,24h                                  
080478BE 2300     mov     r3,0h                                   
080478C0 200F     mov     r0,0Fh                                  
080478C2 7010     strb    r0,[r2]           ;pose写入0Fh                       
080478C4 4806     ldr     r0,=831043Ch      ;写入新OAM                      
080478C6 6188     str     r0,[r1,18h]                             
080478C8 770B     strb    r3,[r1,1Ch]                             
080478CA 82CB     strh    r3,[r1,16h]                             
080478CC 4805     ldr     r0,=300083Ch                            
080478CE 7802     ldrb    r2,[r0]           ;读取随机数                       
080478D0 2003     mov     r0,3h                                   
080478D2 4010     and     r0,r2             ;3and 随机数                      
080478D4 312D     add     r1,2Dh                                  
080478D6 7008     strb    r0,[r1]           ;写入3000765h                      
080478D8 4770     bx      r14                                     

;pose 0Fh               ;给予相应的POSE           
080478E8 B570     push    r4-r6,r14                               
080478EA 4C0B     ldr     r4,=3000738h                            
080478EC 8865     ldrh    r5,[r4,2h]                              
080478EE 88A6     ldrh    r6,[r4,4h]        ;读取坐标                          
080478F0 2010     mov     r0,10h                                  
080478F2 5E21     ldsh    r1,[r4,r0]        ;读取右部分界 54h                       
080478F4 1871     add     r1,r6,r1          ;加上X坐标                      
080478F6 1C28     mov     r0,r5                                   
080478F8 F7C7FF12 bl      800F720h          ;检查砖块                      
080478FC 2800     cmp     r0,0h                                   
080478FE D10D     bne     @@Peer                                
08047900 230E     mov     r3,0Eh            ;读取左部分界                      
08047902 5EE1     ldsh    r1,[r4,r3]                              
08047904 1871     add     r1,r6,r1                                
08047906 1C28     mov     r0,r5             ;检查砖块                      
08047908 F7C7FF0A bl      800F720h                                
0804790C 2800     cmp     r0,0h                                   
0804790E D105     bne     @@Peer                                
08047910 1C21     mov     r1,r4                                   
08047912 3124     add     r1,24h            ;如果左右都没有砖                      
08047914 201E     mov     r0,1Eh            ;Pose写入1Eh                      
08047916 E049     b       @@end                                  

@@Peer:                             
0804791C F7C8F970 bl      800FC00h          ;检查动画                      
08047920 2800     cmp     r0,0h                                   
08047922 D044     beq     @@Return                                
08047924 F7C7FFDC bl      800F8E0h          ;判断位置                       
08047928 4A04     ldr     r2,=3000738h                            
0804792A 8811     ldrh    r1,[r2]                                 
0804792C 2080     mov     r0,80h                                  
0804792E 0080     lsl     r0,r0,2h                                
08047930 4008     and     r0,r1                                   
08047932 2800     cmp     r0,0h            ;检查取向的方向                              
08047934 D004     beq     @@SpriteAtRight                                
08047936 2040     mov     r0,40h           ;敌在左                       
08047938 4308     orr     r0,r1            ;取向 orr 40h 面右                       
0804793A E003     b       @@Peer2                                

@@SpriteAtRight:                              
08047940 4808     ldr     r0,=0FFBFh                              
08047942 4008     and     r0,r1            ;取向去掉40h

@@Peer2                                   
08047944 8010     strh    r0,[r2]          ;写入                        
08047946 4A08     ldr     r2,=3000738h                            
08047948 8811     ldrh    r1,[r2]                                 
0804794A 2080     mov     r0,80h                                  
0804794C 0080     lsl     r0,r0,2h                                
0804794E 4008     and     r0,r1            ;取向再次and 200h                       
08047950 2800     cmp     r0,0h                                   
08047952 D00B     beq     @@SpriteAtRight2                                
08047954 1C28     mov     r0,r5            ;敌在左                       
08047956 3810     sub     r0,10h           ;垂直坐标向上10h                       
08047958 2310     mov     r3,10h                                  
0804795A 5ED1     ldsh    r1,[r2,r3]       ;得到右部分界                       
0804795C 1871     add     r1,r6,r1         ;加上X坐标                       
0804795E 3110     add     r1,10h           ;加10h                      
08047960 E00A     b       @@Peer3                                

@@SpriteAtRight2:                               
0804796C 1C28     mov     r0,r5                                   
0804796E 3810     sub     r0,10h                                  
08047970 230E     mov     r3,0Eh                                  
08047972 5ED1     ldsh    r1,[r2,r3]       ;左部分界加X坐标加减10                         
08047974 1871     add     r1,r6,r1                                
08047976 3910     sub     r1,10h  

@@@@Peer3:                                
08047978 F7C7FED2 bl      800F720h          ;检查砖块                             
0804797C 2800     cmp     r0,0h                                   
0804797E D116     bne     @@Return                                
08047980 4903     ldr     r1,=3000738h                            
08047982 7F48     ldrb    r0,[r1,1Dh]                             
08047984 28C3     cmp     r0,0C3h                                 
08047986 D105     bne     @@IDNOc3                                
08047988 3124     add     r1,24h            ;C3                      
0804798A 2026     mov     r0,26h            ;pose写入26h                      
0804798C E00E     b       @@end                                

@@IDNOc3:                              
08047994 28C8     cmp     r0,0C8h                                 
08047996 D007     beq     @@IDc8                                
08047998 1C08     mov     r0,r1                                   
0804799A 302D     add     r0,2Dh                                  
0804799C 7800     ldrb    r0,[r0]           ;读取3000765的值                         
0804799E 2801     cmp     r0,1h                                   
080479A0 D902     bls     @@IDc8            ;小于等于1                    
080479A2 3124     add     r1,24h            ;大于1则写入26h                      
080479A4 2026     mov     r0,26h                                  
080479A6 E001     b       @@end 

@@IDc8:                               
080479A8 3124     add     r1,24h           ;C8                           
080479AA 2008     mov     r0,8h            ;pose写入8h

@@end:                                 
080479AC 7008     strb    r0,[r1]

@@Return:                                 
080479AE BC70     pop     r4-r6                                   
080479B0 BC01     pop     r0                                      
080479B2 4700     bx      r0  

;pose 26                                    
080479B4 B500     push    r14                                     
080479B6 4B0B     ldr     r3,=3000738h                            
080479B8 1C1A     mov     r2,r3                                   
080479BA 3224     add     r2,24h                                  
080479BC 2100     mov     r1,0h                                   
080479BE 2027     mov     r0,27h           ;pose写入27h                       
080479C0 7010     strb    r0,[r2]                                 
080479C2 7719     strb    r1,[r3,1Ch]                             
080479C4 82D9     strh    r1,[r3,16h]                             
080479C6 8898     ldrh    r0,[r3,4h]       ;读取X坐标                       
080479C8 8118     strh    r0,[r3,8h]       ;写入备份X坐标                       
080479CA 1C18     mov     r0,r3                                   
080479CC 3034     add     r0,34h                                  
080479CE 7800     ldrb    r0,[r0]          ;读取300076c的值                        
080479D0 1C01     mov     r1,r0                                   
080479D2 2801     cmp     r0,1h                                   
080479D4 D10A     bne     @@76cnO1                                
080479D6 4804     ldr     r0,=83104F4h                            
080479D8 6198     str     r0,[r3,18h]      ;写入新OAM                        
080479DA 1C19     mov     r1,r3                                   
080479DC 312E     add     r1,2Eh                                  
080479DE 2006     mov     r0,6h            ;3000766写入6h   设定移动速度                     
080479E0 E01D     b       @@end                                

@@76cnO1:                              
080479EC 2802     cmp     r0,2h                                   
080479EE D107     bne     @@76cnO2                                
080479F0 4802     ldr     r0,=831052Ch     ;写入新OAM                       
080479F2 6198     str     r0,[r3,18h]                             
080479F4 1C19     mov     r1,r3                                   
080479F6 312E     add     r1,2Eh                                  
080479F8 2008     mov     r0,8h            ;3000766写入8h                       
080479FA E010     b       @@end                                

@@76cnO2:                              
08047A00 2903     cmp     r1,3h                                   
08047A02 D107     bne     @@76cnO3                                
08047A04 4802     ldr     r0,=8310564h                            
08047A06 6198     str     r0,[r3,18h]                             
08047A08 1C19     mov     r1,r3                                   
08047A0A 312E     add     r1,2Eh           ;3000766写入Ah                       
08047A0C 200A     mov     r0,0Ah                                  
08047A0E E006     b       @@end                                

@@76cnO3:                               
08047A14 4803     ldr     r0,=83104BCh                            
08047A16 6198     str     r0,[r3,18h]                             
08047A18 1C19     mov     r1,r3                                   
08047A1A 312E     add     r1,2Eh          ;3000766写入3h                        
08047A1C 2003     mov     r0,3h 

@@end:                                  
08047A1E 7008     strb    r0,[r1]                                 
08047A20 BC01     pop     r0                                      
08047A22 4700     bx      r0                                      


;pose 27 调用    用于跳虫脚步声                          
08047A28 B500     push    r14                                     
08047A2A 490B     ldr     r1,=3000738h                            
08047A2C 7F08     ldrb    r0,[r1,1Ch]     ;读取动画帧                  
08047A2E 2801     cmp     r0,1h           ;不等于结束                        
08047A30 D11F     bne     @@end                                
08047A32 8AC8     ldrh    r0,[r1,16h]     ;读取动画                        
08047A34 2801     cmp     r0,1h                                   
08047A36 D001     beq     @@Animation1                                
08047A38 2804     cmp     r0,4h           ;不是1也不是4则结束                        
08047A3A D11A     bne     @@end  

@@Animation1:                              
08047A3C 1C08     mov     r0,r1                                   
08047A3E 302E     add     r0,2Eh                                  
08047A40 7800     ldrb    r0,[r0]         ;读取3000766的值 设定速度                         
08047A42 2806     cmp     r0,6h                                   
08047A44 D80C     bhi     @@766morethan6                                
08047A46 8809     ldrh    r1,[r1]                                 
08047A48 2002     mov     r0,2h                                   
08047A4A 4008     and     r0,r1          ;检查是否在屏幕内                          
08047A4C 2800     cmp     r0,0h                                   
08047A4E D010     beq     @@end                                
08047A50 4802     ldr     r0,=18Fh       ;走音                          
08047A52 F7BBF865 bl      8002B20h                                
08047A56 E00C     b       @@end                                

@@766morethan6:                               
08047A60 8809     ldrh    r1,[r1]                                 
08047A62 2002     mov     r0,2h                                   
08047A64 4008     and     r0,r1          ;检查是否在屏幕内                        
08047A66 2800     cmp     r0,0h                                   
08047A68 D003     beq     @@end                                
08047A6A 2096     mov     r0,96h         ;跑音?                          
08047A6C 0080     lsl     r0,r0,2h                                
08047A6E F7BBF857 bl      8002B20h

@@end:                                
08047A72 BC01     pop     r0                                      
08047A74 4700     bx      r0                                      

;pose 27h                                
08047A78 B570     push    r4-r6,r14                               
08047A7A 4C17     ldr     r4,=3000738h                            
08047A7C 1C20     mov     r0,r4                                   
08047A7E 302E     add     r0,2Eh                                  
08047A80 7805     ldrb    r5,[r0]      ;3000766h                            
08047A82 26C0     mov     r6,0C0h                                 
08047A84 0076     lsl     r6,r6,1h     ;180h                           
08047A86 3801     sub     r0,1h                                   
08047A88 7800     ldrb    r0,[r0]      ;读取3000765                           
08047A8A 2803     cmp     r0,3h                                   
08047A8C D100     bne     @@765No3     ;用于区分爬行长度?                           
08047A8E 0076     lsl     r6,r6,1h     ;300h

@@765No3:                               
08047A90 8821     ldrh    r1,[r4]                                 
08047A92 2080     mov     r0,80h                                  
08047A94 0080     lsl     r0,r0,2h                                
08047A96 4008     and     r0,r1                                   
08047A98 2800     cmp     r0,0h        ;200and取向                           
08047A9A D025     beq     @@SpriteAtRight                                
08047A9C 8860     ldrh    r0,[r4,2h]   ;读取Y坐标        敌人在左向右移动                   
08047A9E 3810     sub     r0,10h       ;Y坐标向上10h                           
08047AA0 2210     mov     r2,10h                                  
08047AA2 5EA1     ldsh    r1,[r4,r2]   ;读取右部分界                          
08047AA4 88A2     ldrh    r2,[r4,4h]   ;读取X坐标                           
08047AA6 1889     add     r1,r1,r2     ;右部分界加X坐标                          
08047AA8 3104     add     r1,4h        ;再加4h                           
08047AAA F7C7FE39 bl      800F720h     ;检查砖块                           
08047AAE 2800     cmp     r0,0h                                   
08047AB0 D114     bne     @@Returnspeed                                
08047AB2 8860     ldrh    r0,[r4,2h]   ;读取Y坐标                           
08047AB4 2210     mov     r2,10h                                  
08047AB6 5EA1     ldsh    r1,[r4,r2]   ;读取右部分界                           
08047AB8 88A2     ldrh    r2,[r4,4h]   ;读取X坐标                           
08047ABA 1889     add     r1,r1,r2     ;右部分界加X坐标                           
08047ABC 3104     add     r1,4h        ;再加4h                           
08047ABE F7C7FE2F bl      800F720h                                
08047AC2 2811     cmp     r0,11h                                  
08047AC4 D10A     bne     @@Returnspeed                                
08047AC6 88A1     ldrh    r1,[r4,4h]   ;读取当前X坐标                          
08047AC8 8920     ldrh    r0,[r4,8h]   ;读取备份X坐标                           
08047ACA 1A08     sub     r0,r1,r0     ;当前X坐标减去备份X坐标                           
08047ACC 0400     lsl     r0,r0,10h                               
08047ACE 0C00     lsr     r0,r0,10h                               
08047AD0 42B0     cmp     r0,r6        ;这个值和180h或300h比较                           
08047AD2 D825     bhi     @@lenghover                                
08047AD4 1868     add     r0,r5,r1     ;X坐标加上766设定速度                          
08047AD6 E029     b       @@SpeedWrite                                 

@@Returnspeed:                              
08047ADC 4801     ldr     r0,=3000738h                            
08047ADE 8881     ldrh    r1,[r0,4h]   ;获取X坐标                           
08047AE0 1B49     sub     r1,r1,r5     ;X坐标减去766设定速度                           
08047AE2 E02A     b       @@Peer                                

@@SpriteAtRight:                               
08047AE8 8860     ldrh    r0,[r4,2h]   ;Y坐标              敌人从右向左             
08047AEA 3810     sub     r0,10h       ;向上10h                           
08047AEC 220E     mov     r2,0Eh                                  
08047AEE 5EA1     ldsh    r1,[r4,r2]   ;获得左部边界                           
08047AF0 88A2     ldrh    r2,[r4,4h]   ;X坐标                           
08047AF2 1889     add     r1,r1,r2     ;X坐标加上左部边界                           
08047AF4 3904     sub     r1,4h        ;再减4                           
08047AF6 F7C7FE13 bl      800F720h     ;检查砖块                           
08047AFA 2800     cmp     r0,0h                                   
08047AFC D11A     bne     @@Returnspeed2                                
08047AFE 8860     ldrh    r0,[r4,2h]   ;获得Y坐标                           
08047B00 220E     mov     r2,0Eh                                  
08047B02 5EA1     ldsh    r1,[r4,r2]   ;获得左部边界                           
08047B04 88A2     ldrh    r2,[r4,4h]   ;获得X坐标                           
08047B06 1889     add     r1,r1,r2     ;相加                           
08047B08 3904     sub     r1,4h        ;在减4                           
08047B0A F7C7FE09 bl      800F720h     ;检查砖块                           
08047B0E 2811     cmp     r0,11h                                  
08047B10 D110     bne     @@Returnspeed2                                
08047B12 8920     ldrh    r0,[r4,8h]   ;得到备份的x坐标                           
08047B14 88A1     ldrh    r1,[r4,4h]   ;当前X坐标                           
08047B16 1A40     sub     r0,r0,r1     ;备份坐标减去当前X坐标                           
08047B18 0400     lsl     r0,r0,10h                               
08047B1A 0C00     lsr     r0,r0,10h                               
08047B1C 42B0     cmp     r0,r6        ;和180或300比较                           
08047B1E D904     bls     @@Move       ;小于或等于

@@lenghover:                                
08047B20 1C21     mov     r1,r4                                   
08047B22 3124     add     r1,24h       ;pose写入0Eh                            
08047B24 200E     mov     r0,0Eh                                  
08047B26 7008     strb    r0,[r1]                                 
08047B28 E00B     b       @@end 

@@Move:                               
08047B2A 1B48     sub     r0,r1,r5     ;那么速度向左写入设定的值

@@SpeedWrite:                               
08047B2C 80A0     strh    r0,[r4,4h]                              
08047B2E F7FFFF7B bl      8047A28h                                
08047B32 E006     b       @@end  

@@Returnspeed2:                              
08047B34 4804     ldr     r0,=3000738h                            
08047B36 8881     ldrh    r1,[r0,4h]     ;X坐标                          
08047B38 1869     add     r1,r5,r1       ;加上设定速度

@@Peer:                               
08047B3A 8081     strh    r1,[r0,4h]     ;pose写入0Eh                          
08047B3C 3024     add     r0,24h                                  
08047B3E 210E     mov     r1,0Eh                                  
08047B40 7001     strb    r1,[r0]      

@@end:                           
08047B42 BC70     pop     r4-r6                                   
08047B44 BC01     pop     r0                                      
08047B46 4700     bx      r0                                      


;pose 1Eh                             
08047B4C 4B06     ldr     r3,=3000738h                            
08047B4E 1C19     mov     r1,r3                                   
08047B50 3124     add     r1,24h                                  
08047B52 2200     mov     r2,0h                                   
08047B54 201F     mov     r0,1Fh         ;pose写入1Fh                          
08047B56 7008     strb    r0,[r1]                                 
08047B58 771A     strb    r2,[r3,1Ch]                            
08047B5A 2000     mov     r0,0h                                   
08047B5C 82DA     strh    r2,[r3,16h]                             
08047B5E 310B     add     r1,0Bh                                  
08047B60 7008     strb    r0,[r1]        ;3000767写入0h                         
08047B62 4802     ldr     r0,=8310484h                            
08047B64 6198     str     r0,[r3,18h]    ;写入新OAM                         
08047B66 4770     bx      r14                                     


;pose 1Fh                             
08047B70 B530     push    r4,r5,r14                               
08047B72 4C08     ldr     r4,=3000738h                            
08047B74 8860     ldrh    r0,[r4,2h]                              
08047B76 88A1     ldrh    r1,[r4,4h]    ;读取坐标                          
08047B78 F7C7FC80 bl      800F47Ch      ;检查砖块                          
08047B7C 1C01     mov     r1,r0                                   
08047B7E 4806     ldr     r0,=30007F0h                            
08047B80 7800     ldrb    r0,[r0]                                 
08047B82 2800     cmp     r0,0h         ;检查是否落地???                          
08047B84 D00A     beq     @@NoOnland                                
08047B86 8061     strh    r1,[r4,2h]    ;写入Y坐标                           
08047B88 1C21     mov     r1,r4                                   
08047B8A 3124     add     r1,24h                                  
08047B8C 2024     mov     r0,24h        ;pose写入24h                          
08047B8E 7008     strb    r0,[r1]                                 
08047B90 E022     b       @@end                                

@@NoOnland:                               
08047B9C 202F     mov     r0,2Fh                                  
08047B9E 1900     add     r0,r0,r4                                
08047BA0 4684     mov     r12,r0                                  
08047BA2 7801     ldrb    r1,[r0]       ;3000767的值  记录速度的地址格                          
08047BA4 4B07     ldr     r3,=830F53Ch                            
08047BA6 0048     lsl     r0,r1,1h      ;乘以2                          
08047BA8 18C0     add     r0,r0,r3      ;加上偏移量                          
08047BAA 2500     mov     r5,0h                                   
08047BAC 5F42     ldsh    r2,[r0,r5]    ;得到数值                          
08047BAE 4806     ldr     r0,=7FFFh                               
08047BB0 4282     cmp     r2,r0         ;数值和7FFF比较                          
08047BB2 D10B     bne     @@Noequal                                
08047BB4 1E48     sub     r0,r1,1       ;3000767的值减1                          
08047BB6 0040     lsl     r0,r0,1h      ;乘以2                          
08047BB8 18C0     add     r0,r0,r3      ;加上偏移量                          
08047BBA 2100     mov     r1,0h                                   
08047BBC 5E40     ldsh    r0,[r0,r1]    ;读取速度数值                          
08047BBE 8865     ldrh    r5,[r4,2h]    ;读取Y坐标值                          
08047BC0 1940     add     r0,r0,r5      ;两者相加                          
08047BC2 E008     b       @@WriteSpeed                                

@@Noequal:                              
08047BCC 1C48     add     r0,r1,1       ;3000767的值加1                          
08047BCE 4661     mov     r1,r12                                  
08047BD0 7008     strb    r0,[r1]       ;再写入                          
08047BD2 8860     ldrh    r0,[r4,2h]    ;读取Y坐标                          
08047BD4 1880     add     r0,r0,r2      ;加上数值

@@WriteSpeed:                               
08047BD6 8060     strh    r0,[r4,2h]    ;写入

@@end:                             
08047BD8 BC30     pop     r4,r5                                   
08047BDA BC01     pop     r0                                      
08047BDC 4700     bx      r0 

                                     
;OtherPose                               
08047BE0 B5F0     push    r4-r7,r14                               
08047BE2 4657     mov     r7,r10                                  
08047BE4 464E     mov     r6,r9                                   
08047BE6 4645     mov     r5,r8                                   
08047BE8 B4E0     push    r5-r7                                   
08047BEA B085     add     sp,-14h                                 
08047BEC 2600     mov     r6,0h                                   
08047BEE 4803     ldr     r0,=3000738h                            
08047BF0 7F40     ldrb    r0,[r0,1Dh]    ;读取ID                         
08047BF2 28C3     cmp     r0,0C3h                                 
08047BF4 D104     bne     @@NoC3                                
08047BF6 26C8     mov     r6,0C8h        ;设定检查C8                          
08047BF8 E007     b       @@CheckDoor                                


@@NoC3:                              
08047C00 28C8     cmp     r0,0C8h                                 
08047C02 D100     bne     @@NoBoss                                
08047C04 26C3     mov     r6,0C3h        ;设定检查C3

@@NoBoss:                                
08047C06 2E00     cmp     r6,0h                                   
08047C08 D02A     beq     @@Pass 

@@CheckDoor:                               
08047C0A 2300     mov     r3,0h                                   
08047C0C 4A42     ldr     r2,=30001ACh                            
08047C0E 21A8     mov     r1,0A8h                                 
08047C10 00C9     lsl     r1,r1,3h                                
08047C12 1850     add     r0,r2,r1                                
08047C14 4282     cmp     r2,r0                                   
08047C16 D218     bcs     @@DateOver                                
08047C18 1C04     mov     r4,r0          ;最大值给r4 

@@Loop:                            
08047C1A 8811     ldrh    r1,[r2]        ;读取取向                         
08047C1C 2001     mov     r0,1h                                   
08047C1E 4008     and     r0,r1          ;1AND取向                        
08047C20 2800     cmp     r0,0h                                   
08047C22 D00F     beq     @@Pass2        ;敌人死亡                        
08047C24 1C10     mov     r0,r2                                   
08047C26 3032     add     r0,32h         ;读取碰撞属性                         
08047C28 7801     ldrb    r1,[r0]                                 
08047C2A 2080     mov     r0,80h         ;80h and                         
08047C2C 4008     and     r0,r1                                   
08047C2E 2800     cmp     r0,0h                                   
08047C30 D108     bne     @@Pass2        ;是副精灵                        
08047C32 7F50     ldrb    r0,[r2,1Dh]    ;读取ID                         
08047C34 42B0     cmp     r0,r6          ;和R6比较                         
08047C36 D105     bne     @@Pass2        ;没有则pass                        
08047C38 8A90     ldrh    r0,[r2,14h]    ;读取血量                          
08047C3A 2800     cmp     r0,0h          ;为0则pass                         
08047C3C D002     beq     @@Pass2                                
08047C3E 1C58     add     r0,r3,1        ;累计值加1                         
08047C40 0600     lsl     r0,r0,18h                               
08047C42 0E03     lsr     r3,r0,18h

@@Pass2:                               
08047C44 3238     add     r2,38h         ;偏移值加38h                          
08047C46 42A2     cmp     r2,r4          ;和最大值比较                         
08047C48 D3E7     bcc     @@Loop         ;小于则继续循环

@@DateOver:                               
08047C4A 2B00     cmp     r3,0h          ;累计值等于0,代表没有一个                         
08047C4C D108     bne     @@Pass                                
08047C4E 2001     mov     r0,1h                                   
08047C50 2134     mov     r1,34h                                  
08047C52 F018FE33 bl      80608BCh       ;事件值激活                         
08047C56 4931     ldr     r1,=300007Bh                            
08047C58 2214     mov     r2,14h                                  
08047C5A 4252     neg     r2,r2                                   
08047C5C 1C10     mov     r0,r2                                   
08047C5E 7008     strb    r0,[r1]        ;门锁时间值写入BCh 

@@Pass:                                
08047C60 482F     ldr     r0,=3000738h                            
08047C62 4680     mov     r8,r0                                   
08047C64 8840     ldrh    r0,[r0,2h]     ;得到Y坐标                         
08047C66 3860     sub     r0,60h         ;向上60h                         
08047C68 0400     lsl     r0,r0,10h                               
08047C6A 0C05     lsr     r5,r0,10h                               
08047C6C 9503     str     r5,[sp,0Ch]    ;写入SPC                          
08047C6E 4641     mov     r1,r8                                   
08047C70 888F     ldrh    r7,[r1,4h]     ;得到X坐标                         
08047C72 9704     str     r7,[sp,10h]    ;写入SP10                          
08047C74 4A2B     ldr     r2,=300083Ch                            
08047C76 4691     mov     r9,r2                                   
08047C78 7810     ldrb    r0,[r2]        ;随机数                         
08047C7A 0640     lsl     r0,r0,19h                               
08047C7C 0E04     lsr     r4,r0,18h      ;乘以2                         
08047C7E 46A2     mov     r10,r4                                  
08047C80 2022     mov     r0,22h                                  
08047C82 9000     str     r0,[sp]        ;22给SP                         
08047C84 2000     mov     r0,0h                                   
08047C86 1C29     mov     r1,r5                                   
08047C88 1C3A     mov     r2,r7                                   
08047C8A 2301     mov     r3,1h                                   
08047C8C F7C9F9FA bl      8011084h       ;死亡烟花例程                         
08047C90 4641     mov     r1,r8                                   
08047C92 8808     ldrh    r0,[r1]        ;读取取向                          
08047C94 2800     cmp     r0,0h          ;如果已经死亡                         
08047C96 D037     beq     @@end          ;结束                      
08047C98 464A     mov     r2,r9                                   
08047C9A 7811     ldrb    r1,[r2]        ;随机数                         
08047C9C 2001     mov     r0,1h                                   
08047C9E 4008     and     r0,r1          ;1 and                         
08047CA0 261C     mov     r6,1Ch                                  
08047CA2 2800     cmp     r0,0h                                   
08047CA4 D000     beq     @@Pass3                                
08047CA6 261A     mov     r6,1Ah   

@@Pass3:                                
08047CA8 4640     mov     r0,r8                                 
08047CAA 7F81     ldrb    r1,[r0,1Eh]    ;读取3000756 副精灵次数???                         
08047CAC 4A1E     ldr     r2,=300075Bh                            
08047CAE 7813     ldrb    r3,[r2]        ;得到主精灵序号                         
08047CB0 1C20     mov     r0,r4                                   
08047CB2 3818     sub     r0,18h         ;随机数减18h                         
08047CB4 1828     add     r0,r5,r0       ;加上Y坐标                        
08047CB6 9000     str     r0,[sp]        ;写入SP                         
08047CB8 1C20     mov     r0,r4                                   
08047CBA 384C     sub     r0,4Ch                                  
08047CBC 1A38     sub     r0,r7,r0                                
08047CBE 9001     str     r0,[sp,4h]                              
08047CC0 2400     mov     r4,0h                                   
08047CC2 9402     str     r4,[sp,8h]                              
08047CC4 1C30     mov     r0,r6                                   
08047CC6 2200     mov     r2,0h                                   
08047CC8 F7C6FB84 bl      800E3D4h       ;掉落生成例程                         
08047CCC 4917     ldr     r1,=808C99Ch                            
08047CCE 464A     mov     r2,r9                                   
08047CD0 7810     ldrb    r0,[r2]                                 
08047CD2 1840     add     r0,r0,r1                                
08047CD4 7801     ldrb    r1,[r0]                                 
08047CD6 2001     mov     r0,1h                                   
08047CD8 4008     and     r0,r1                                   
08047CDA 261C     mov     r6,1Ch                                  
08047CDC 2800     cmp     r0,0h                                   
08047CDE D000     beq     @@Pass4                                
08047CE0 261A     mov     r6,1Ah 

@@Pass4:                                 
08047CE2 4640     mov     r0,r8                                   
08047CE4 7F81     ldrb    r1,[r0,1Eh]                             
08047CE6 4A10     ldr     r2,=300075Bh                            
08047CE8 7813     ldrb    r3,[r2]                                 
08047CEA 4650     mov     r0,r10                                  
08047CEC 3814     sub     r0,14h                                  
08047CEE 9A03     ldr     r2,[sp,0Ch]                             
08047CF0 1A10     sub     r0,r2,r0                                
08047CF2 9000     str     r0,[sp]                                 
08047CF4 4650     mov     r0,r10                                  
08047CF6 3848     sub     r0,48h                                  
08047CF8 9A04     ldr     r2,[sp,10h]                             
08047CFA 1810     add     r0,r2,r0                                
08047CFC 9001     str     r0,[sp,4h]                              
08047CFE 9402     str     r4,[sp,8h]                              
08047D00 1C30     mov     r0,r6                                   
08047D02 2200     mov     r2,0h                                   
08047D04 F7C6FB66 bl      800E3D4h

@@end:                                
08047D08 B005     add     sp,14h                                  
08047D0A BC38     pop     r3-r5                                   
08047D0C 4698     mov     r8,r3                                   
08047D0E 46A1     mov     r9,r4                                   
08047D10 46AA     mov     r10,r5                                  
08047D12 BCF0     pop     r4-r7                                   
08047D14 BC01     pop     r0                                      
08047D16 4700     bx      r0                                       
////////////////////////////////////////////////////////////////////////////////
;主程序                             
08047D30 B530     push    r4,r5,r14                               
08047D32 4917     ldr     r1,=3000738h                            
08047D34 1C0B     mov     r3,r1                                   
08047D36 3332     add     r3,32h                                  
08047D38 781A     ldrb    r2,[r3]     ;读取碰撞属性                             
08047D3A 2402     mov     r4,2h                                   
08047D3C 1C20     mov     r0,r4                                   
08047D3E 4010     and     r0,r2                                   
08047D40 2800     cmp     r0,0h                                   
08047D42 D00A     beq     @@NoHitorOver                                
08047D44 20FD     mov     r0,0FDh                                 
08047D46 4010     and     r0,r2                                   
08047D48 7018     strb    r0,[r3]     ;碰撞属性清零                             
08047D4A 8809     ldrh    r1,[r1]                                 
08047D4C 1C20     mov     r0,r4                                   
08047D4E 4008     and     r0,r1                                   
08047D50 2800     cmp     r0,0h                                    
08047D52 D002     beq     @@NoHitorOver                                
08047D54 480F     ldr     r0,=259h    ;播放受创音                            
08047D56 F7BAFEE3 bl      8002B20h  

@@NoHitorOver:                              
08047D5A 4A0D     ldr     r2,=3000738h                            
08047D5C 1C10     mov     r0,r2                                   
08047D5E 302B     add     r0,2Bh                                  
08047D60 7801     ldrb    r1,[r0]     ;无敌时间                               
08047D62 207F     mov     r0,7Fh                                  
08047D64 4008     and     r0,r1                                   
08047D66 1C13     mov     r3,r2                                   
08047D68 2800     cmp     r0,0h                                   
08047D6A D027     beq     @@Pass                                
08047D6C 4A0A     ldr     r2,=82B0D68h                            
08047D6E 7F59     ldrb    r1,[r3,1Dh]                             
08047D70 00C8     lsl     r0,r1,3h                                
08047D72 1840     add     r0,r0,r1                                
08047D74 0040     lsl     r0,r0,1h                                
08047D76 1880     add     r0,r0,r2                                
08047D78 8801     ldrh    r1,[r0]      ;读取设定血量                           
08047D7A 1C0C     mov     r4,r1                                   
08047D7C 8A9A     ldrh    r2,[r3,14h]  ;读取当前血量                           
08047D7E 1C15     mov     r5,r2                                   
08047D80 0888     lsr     r0,r1,2h     ;设定血量除以4                           
08047D82 4282     cmp     r2,r0        ;当前血量比较 设定血量1/4                          
08047D84 D80A     bhi     @@MoreThan1v4                                
08047D86 1C19     mov     r1,r3                                   
08047D88 3134     add     r1,34h                                  
08047D8A 2003     mov     r0,3h        ;300076c写入3                           
08047D8C E015     b       @@Peer                                

@@MoreThan1v4:                               
08047D9C 0848     lsr     r0,r1,1h     ;设定血量的1/2                           
08047D9E 4282     cmp     r2,r0        ;当前血量比较                            
08047DA0 D803     bhi     @@MoreThan1v2                                
08047DA2 1C19     mov     r1,r3                                   
08047DA4 3134     add     r1,34h                                  
08047DA6 2002     mov     r0,2h        ;300076c写入2                           
08047DA8 E007     b       @@Peer 

@@MoreThan1v2:                               
08047DAA 0060     lsl     r0,r4,1h     ;设定血量的乘以2                           
08047DAC 1900     add     r0,r0,r4     ;加上设定血量                           
08047DAE 1080     asr     r0,r0,2h     ;除以4                           
08047DB0 4285     cmp     r5,r0        ;当前血量比设定血量3/4                           
08047DB2 DC03     bgt     @@Pass                                
08047DB4 1C19     mov     r1,r3                                   
08047DB6 3134     add     r1,34h       ;300076c写入1                           
08047DB8 2001     mov     r0,1h  

@@Peer:                                 
08047DBA 7008     strb    r0,[r1]

@@Pass:                                 
08047DBC 1C18     mov     r0,r3                                   
08047DBE 3024     add     r0,24h                                  
08047DC0 7800     ldrb    r0,[r0]                                 
08047DC2 2827     cmp     r0,27h                                  
08047DC4 D875     bhi     @@OtherPose                                
08047DC6 0080     lsl     r0,r0,2h                                
08047DC8 4901     ldr     r1,=8047DD4h  ;PoseTable                            
08047DCA 1840     add     r0,r0,r1                                
08047DCC 6800     ldr     r0,[r0]                                 
08047DCE 4687     mov     r15,r0                                  

PoseTable:                              
     .word 8047e74h  ;00
	 .word 8047eb2h .word 8047eb2h .word 8047eb2h .word 8047eb2h
	 .word 8047eb2h .word 8047eb2h .word 8047eb2h
	 .word 8047e7ah  ;08
	 .word 8047e7eh  ;09
	 .word 8047eb2h .word 8047eb2h .word 8047eb2h .word 8047eb2h
	 .word 8047e9eh  ;0eh
	 .word 8047ea2h  ;0fh
	 .word 8047eb2h .word 8047eb2h .word 8047eb2h .word 8047eb2h
	 .word 8047eb2h .word 8047eb2h .word 8047eb2h .word 8047eb2h
	 .word 8047eb2h .word 8047eb2h .word 8047eb2h .word 8047eb2h
	 .word 8047eb2h .word 8047eb2h
	 .word 8047ea8h  ;1eh 
	 .word 8047each  ;1fh
	 .word 8047eb2h .word 8047eb2h .word 8047eb2h
	 .word 8047e84h  ;23h
	 .word 8047e8ah  ;24h
	 .word 8047e8eh  ;25h
	 .word 8047e94h  ;26h
	 .word 8047e98h  ;27h
    	 
08047E74 F7FFFBD4 bl      8047620h   ;00                                
08047E78 E01D     b       @@end                                
08047E7A F7FFFC19 bl      80476B0h   ;08      跳跃前                        
08047E7E F7FFFC31 bl      80476E4h   ;09      跳跃前                       
08047E82 E018     b       @@end                                
08047E84 F7FFFC6C bl      8047760h   ;23h     跳起                         
08047E88 E015     b       @@end                                
08047E8A F7FFFCE9 bl      8047860h   ;24h     下落 碰顶也                        
08047E8E F7FFFD05 bl      804789Ch   ;25h     落地缓冲                         
08047E92 E010     b       @@end                                
08047E94 F7FFFD8E bl      80479B4h   ;26h     行走前?                         
08047E98 F7FFFDEE bl      8047A78h   ;27h     行走                         
08047E9C E00B     b       @@end                                
08047E9E F7FFFD0B bl      80478B8h   ;0eh     pose 0后                        
08047EA2 F7FFFD21 bl      80478E8h   ;0fh     给予不同的pose                        
08047EA6 E006     b       @@end                                
08047EA8 F7FFFE50 bl      8047B4Ch   ;1eh     碰壁                           
08047EAC F7FFFE60 bl      8047B70h   ;1fh                             
08047EB0 E001     b       @@end 

@@OtherPose:                               
08047EB2 F7FFFE95 bl      8047BE0h  

@@end:                              
08047EB6 BC30     pop     r4,r5                                   
08047EB8 BC01     pop     r0                                      
08047EBA 4700     bx      r0 
