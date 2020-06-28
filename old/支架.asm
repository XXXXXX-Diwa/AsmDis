;pose 0调用
08031708 B5F0     push    r4-r7,r14                               
0803170A 1C04     mov     r4,r0                                   
0803170C 0624     lsl     r4,r4,18h                               
0803170E 0E24     lsr     r4,r4,18h                               
08031710 480F     ldr     r0,=3000738h                            
08031712 8847     ldrh    r7,[r0,2h]     ;读取坐标                          
08031714 8886     ldrh    r6,[r0,4h]                              
08031716 4D0F     ldr     r5,=3000079h                            
08031718 702C     strb    r4,[r5]        ;写入要制造的砖块类型                         
0803171A 1C38     mov     r0,r7                                   
0803171C 3860     sub     r0,60h         ;Y坐标向上60h                         
0803171E 1C31     mov     r1,r6                                   
08031720 F026FBAC bl      8057E7Ch       ;上一格                         
08031724 702C     strb    r4,[r5]                                 
08031726 1C38     mov     r0,r7                                   
08031728 38A0     sub     r0,0A0h                                 
0803172A 1C31     mov     r1,r6                                   
0803172C F026FBA6 bl      8057E7Ch       ;上两格                         
08031730 702C     strb    r4,[r5]                                 
08031732 1C38     mov     r0,r7                                   
08031734 38E0     sub     r0,0E0h                                 
08031736 1C31     mov     r1,r6                                   
08031738 F026FBA0 bl      8057E7Ch       ;上三格                          
0803173C 702C     strb    r4,[r5]                                 
0803173E 4906     ldr     r1,=0FFFFFEE0h                          
08031740 1878     add     r0,r7,r1                                
08031742 1C31     mov     r1,r6                                   
08031744 F026FB9A bl      8057E7Ch       ;上四格                          
08031748 BCF0     pop     r4-r7                                   
0803174A BC01     pop     r0                                      
0803174C 4700     bx      r0  

;pose 9调用
0803175C B500     push    r14                                     
0803175E 1C03     mov     r3,r0                                   
08031760 4904     ldr     r1,=3000738h                            
08031762 8848     ldrh    r0,[r1,2h]                              
08031764 8889     ldrh    r1,[r1,4h]                              
08031766 4A04     ldr     r2,=3000079h                            
08031768 7013     strb    r3,[r2]                                 
0803176A 3820     sub     r0,20h                                  
0803176C F026FB86 bl      8057E7Ch     ;原地制造砖块                           
08031770 BC01     pop     r0                                      
08031772 4700     bx      r0                                      

;pose 25调用                            
0803177C B500     push    r14                                     
0803177E 1C03     mov     r3,r0                                   
08031780 4905     ldr     r1,=3000738h                            
08031782 8848     ldrh    r0,[r1,2h]                              
08031784 8889     ldrh    r1,[r1,4h]                              
08031786 4A05     ldr     r2,=3000079h                            
08031788 7013     strb    r3,[r2]                                 
0803178A 4A05     ldr     r2,=0FFFFFEA0h                          
0803178C 1880     add     r0,r0,r2                                
0803178E F026FB75 bl      8057E7Ch                                
08031792 BC01     pop     r0                                      
08031794 4700     bx      r0                                      


;pose 9调用                              
080317A4 B530     push    r4,r5,r14                               
080317A6 2500     mov     r5,0h                                   
080317A8 480C     ldr     r0,=30013D4h                            
080317AA 8A82     ldrh    r2,[r0,14h]                             
080317AC 8A44     ldrh    r4,[r0,12h]      ;获取坐标                        
080317AE 480C     ldr     r0,=3000738h                            
080317B0 8841     ldrh    r1,[r0,2h]                              
080317B2 8883     ldrh    r3,[r0,4h]       ;获取坐标                       
080317B4 1C08     mov     r0,r1                                   
080317B6 3830     sub     r0,30h           ;支架Y坐标上30h                       
080317B8 4290     cmp     r0,r2            ;和人物Y坐标相比                       
080317BA DA0A     bge     @@end            ;大于等于跳转                       
080317BC 3060     add     r0,60h           ;支架下30h                       
080317BE 4290     cmp     r0,r2            ;和人物Y坐标比较                       
080317C0 DD07     ble     @@end            ;小于或等于跳转                    
080317C2 1C18     mov     r0,r3                                   
080317C4 3830     sub     r0,30h           ;支架左30h                       
080317C6 42A0     cmp     r0,r4            ;和人物X坐标比较                       
080317C8 DA03     bge     @@end            ;大于等于跳转                    
080317CA 3060     add     r0,60h           ;支架右30h                      
080317CC 42A0     cmp     r0,r4            ;和人物X坐标比较                       
080317CE DD00     ble     @@end            ;小于等于跳转                    
080317D0 2501     mov     r5,1h 

@@end:                                  
080317D2 1C28     mov     r0,r5            ;返回1则在范围内                      
080317D4 BC30     pop     r4,r5                                   
080317D6 BC02     pop     r1                                      
080317D8 4708     bx      r1                                      

;pose 25调用                               
080317E4 B530     push    r4,r5,r14                               
080317E6 2500     mov     r5,0h                                   
080317E8 480E     ldr     r0,=30013D4h                            
080317EA 8A83     ldrh    r3,[r0,14h]                             
080317EC 8A44     ldrh    r4,[r0,12h]                             
080317EE 490E     ldr     r1,=3000738h                            
080317F0 4A0E     ldr     r2,=0FFFFFEC0h                          
080317F2 1C10     mov     r0,r2                                   
080317F4 884A     ldrh    r2,[r1,2h]   ;精灵Y坐标                           
080317F6 1880     add     r0,r0,r2     ;上升五格                           
080317F8 0400     lsl     r0,r0,10h                               
080317FA 0C02     lsr     r2,r0,10h                               
080317FC 8889     ldrh    r1,[r1,4h]                              
080317FE 1C10     mov     r0,r2                                   
08031800 3830     sub     r0,30h       ;在上升30h                           
08031802 4298     cmp     r0,r3        ;和人物Y坐标比较                           
08031804 DA0A     bge     @@end        ;大于等于跳转                        
08031806 3060     add     r0,60h       ;下降30h                           
08031808 4298     cmp     r0,r3                                   
0803180A DD07     ble     @@end                                
0803180C 1C08     mov     r0,r1                                   
0803180E 3830     sub     r0,30h                                  
08031810 42A0     cmp     r0,r4                                   
08031812 DA03     bge     @@end                                
08031814 3060     add     r0,60h                                  
08031816 42A0     cmp     r0,r4                                   
08031818 DD00     ble     @@end                                
0803181A 2501     mov     r5,1h 

@@end:                                  
0803181C 1C28     mov     r0,r5                                   
0803181E BC30     pop     r4,r5                                   
08031820 BC02     pop     r1                                      
08031822 4708     bx      r1      

;pose 0
08031830 B500     push    r14                                     
08031832 4B13     ldr     r3,=3000738h                            
08031834 1C1A     mov     r2,r3                                   
08031836 3227     add     r2,27h                                  
08031838 2100     mov     r1,0h                                   
0803183A 2064     mov     r0,64h                                  
0803183C 7010     strb    r0,[r2]    ;300075f写入64h                              
0803183E 1C18     mov     r0,r3                                   
08031840 3028     add     r0,28h     ;3000760写入0                             
08031842 7001     strb    r1,[r0]                                 
08031844 3001     add     r0,1h                                   
08031846 2118     mov     r1,18h                                  
08031848 7001     strb    r1,[r0]    ;3000761写入18h                             
0803184A 2200     mov     r2,0h                                   
0803184C 480D     ldr     r0,=0FFE8h                              
0803184E 81D8     strh    r0,[r3,0Eh]  ;左部分界写入FFE8h                            
08031850 8219     strh    r1,[r3,10h]  ;右部分界写入18h                           
08031852 1C18     mov     r0,r3                                   
08031854 3025     add     r0,25h                                  
08031856 7002     strb    r2,[r0]      ;属性写入0                          
08031858 2080     mov     r0,80h                                  
0803185A 0040     lsl     r0,r0,1h                                
0803185C 8298     strh    r0,[r3,14h]  ;血量写入100h                           
0803185E 8819     ldrh    r1,[r3]                                 
08031860 4809     ldr     r0,=0F7FFh                              
08031862 4008     and     r0,r1        ;0F7FFh and 取向                           
08031864 8018     strh    r0,[r3]      ;再写入                           
08031866 4809     ldr     r0,=3000088h                            
08031868 7B01     ldrb    r1,[r0,0Ch]  ;读取3000094的值                           
0803186A 2003     mov     r0,3h        ;一般来说是3                           
0803186C 4008     and     r0,r1        ;3 and                           
0803186E 1C19     mov     r1,r3                                   
08031870 3121     add     r1,21h                                       
08031872 7008     strb    r0,[r1]      ;写入3000759                           
08031874 2004     mov     r0,4h                                   
08031876 F7FFFF47 bl      8031708h     ;上4格做砖块                           
0803187A BC01     pop     r0                                      
0803187C 4700     bx      r0

                                      
;pose 8h                               
08031890 4907     ldr     r1,=3000738h                            
08031892 4808     ldr     r0,=82E8CE0h                            
08031894 6188     str     r0,[r1,18h]  ;写入OAM                           
08031896 2000     mov     r0,0h                                   
08031898 7708     strb    r0,[r1,1Ch]                             
0803189A 82C8     strh    r0,[r1,16h]                             
0803189C 1C0A     mov     r2,r1                                   
0803189E 3224     add     r2,24h                                  
080318A0 2009     mov     r0,9h        ;pose写入9h                           
080318A2 7010     strb    r0,[r2]                                 
080318A4 4804     ldr     r0,=0FF8Ch                              
080318A6 8148     strh    r0,[r1,0Ah]  ;写入上部分界FF8c                           
080318A8 3008     add     r0,8h                                   
080318AA 8188     strh    r0,[r1,0Ch]  ;写入下部分界8h                           
080318AC 4770     bx      r14                                     

;pose 9h                               
080318BC B570     push    r4-r6,r14                               
080318BE 4C14     ldr     r4,=3000738h                            
080318C0 8825     ldrh    r5,[r4]                                 
080318C2 2680     mov     r6,80h                                  
080318C4 0136     lsl     r6,r6,4h     ;800h                              
080318C6 1C30     mov     r0,r6                                   
080318C8 4028     and     r0,r5        ;800 and 取向                             
080318CA 2800     cmp     r0,0h                                   
080318CC D026     beq     @@Noactivation                                
080318CE 1C23     mov     r3,r4                                   
080318D0 332B     add     r3,2Bh                                  
080318D2 7819     ldrb    r1,[r3]      ;读取3000763h  无敌时间                            
080318D4 207F     mov     r0,7Fh                                  
080318D6 4008     and     r0,r1        ;7F and                           
080318D8 2810     cmp     r0,10h       ;如果不为10则跳转                           
080318DA D12D     bne     @@end                               
080318DC 2080     mov     r0,80h                                  
080318DE 4008     and     r0,r1        ;80 and                           
080318E0 2200     mov     r2,0h                                   
080318E2 7018     strb    r0,[r3]      ;再写入 清零?                           
080318E4 2100     mov     r1,0h                                   
080318E6 2080     mov     r0,80h                                  
080318E8 0040     lsl     r0,r0,1h                                
080318EA 82A0     strh    r0,[r4,14h]  ;血量写入100h                           
080318EC 4809     ldr     r0,=82E8D08h                            
080318EE 61A0     str     r0,[r4,18h]  ;写入新OAM                           
080318F0 7721     strb    r1,[r4,1Ch]                             
080318F2 82E2     strh    r2,[r4,16h]                             
080318F4 1C21     mov     r1,r4                                   
080318F6 3124     add     r1,24h                                  
080318F8 2023     mov     r0,23h       ;pose写入23h                            
080318FA 7008     strb    r0,[r1]                                 
080318FC 2180     mov     r1,80h                                  
080318FE 0209     lsl     r1,r1,8h                                
08031900 1C08     mov     r0,r1                                   
08031902 4328     orr     r0,r5        ;8000 orr取向                           
08031904 8020     strh    r0,[r4]      ;再写入                           
08031906 4804     ldr     r0,=173h                                
08031908 F7D1F886 bl      8002A18h     ;支架升起音                           
0803190C E014     b       @@end                                

@@Noactivation:                               
0803191C F7FFFF42 bl      80317A4h     ;检查范围????                           
08031920 0600     lsl     r0,r0,18h                               
08031922 2800     cmp     r0,0h                                   
08031924 D108     bne     @@end        ;范围外则结束                        
08031926 2004     mov     r0,4h                                   
08031928 F7FFFF18 bl      803175Ch     ;制造底部砖块                            
0803192C 8820     ldrh    r0,[r4]                                 
0803192E 1C31     mov     r1,r6        ;800h                           
08031930 4301     orr     r1,r0        ;orr 取向                           
08031932 4803     ldr     r0,=7FFFh                               
08031934 4001     and     r1,r0        ;在and 7fffh写入                           
08031936 8021     strh    r1,[r4] 

@@end:                                
08031938 BC70     pop     r4-r6                                   
0803193A BC01     pop     r0                                      
0803193C 4700     bx      r0                                      


;23h                               
08031944 B510     push    r4,r14                                  
08031946 4C11     ldr     r4,=3000738h                            
08031948 8AE0     ldrh    r0,[r4,16h]                             
0803194A 2802     cmp     r0,2h        ;读取动画                           
0803194C D109     bne     @@Pass                                
0803194E 7F20     ldrb    r0,[r4,1Ch]  ;读取动画帧                           
08031950 2801     cmp     r0,1h                                   
08031952 D106     bne     @@Pass                                
08031954 2001     mov     r0,1h                                   
08031956 F7FFFF01 bl      803175Ch     ;去掉底部砖块                           
0803195A 8821     ldrh    r1,[r4]      ;读取取向                           
0803195C 480C     ldr     r0,=0F7FFh                              
0803195E 4008     and     r0,r1        ;and 0f7ff再写入                           
08031960 8020     strh    r0,[r4]      ;等于去掉800h

@@Pass:                                 
08031962 F7DEF931 bl      800FBC8h                                
08031966 2800     cmp     r0,0h         ;检查动画是否结束                           
08031968 D00D     beq     @@end                                
0803196A 4908     ldr     r1,=3000738h  ;写入新的OAM                          
0803196C 4809     ldr     r0,=82E8D50h                            
0803196E 6188     str     r0,[r1,18h]                             
08031970 2000     mov     r0,0h                                   
08031972 7708     strb    r0,[r1,1Ch]                             
08031974 82C8     strh    r0,[r1,16h]                             
08031976 1C0A     mov     r2,r1                                   
08031978 3224     add     r2,24h                                  
0803197A 2025     mov     r0,25h        ;pose写入25h                          
0803197C 7010     strb    r0,[r2]                                 
0803197E 4806     ldr     r0,=0FF4Ch                              
08031980 8148     strh    r0,[r1,0Ah]   ;上部分界向上提升一格                          
08031982 3008     add     r0,8h                                   
08031984 8188     strh    r0,[r1,0Ch]   ;下部分界

@@end:                            
08031986 BC10     pop     r4                                      
08031988 BC01     pop     r0                                      
0803198A 4700     bx      r0                                      

;pose 25h
0803199C B530     push    r4,r5,r14                               
0803199E 4C0B     ldr     r4,=3000738h                            
080319A0 8821     ldrh    r1,[r4]                                 
080319A2 2580     mov     r5,80h                                  
080319A4 012D     lsl     r5,r5,4h                                
080319A6 1C28     mov     r0,r5                                   
080319A8 4008     and     r0,r1       ;800 AND 取向                            
080319AA 2800     cmp     r0,0h                                   
080319AC D10B     bne     @@end                                
080319AE F7FFFF19 bl      80317E4h    ;检查是否在要造砖块范围内                             
080319B2 0600     lsl     r0,r0,18h                               
080319B4 2800     cmp     r0,0h                                   
080319B6 D106     bne     @@end                                
080319B8 2004     mov     r0,4h                                   
080319BA F7FFFEDF bl      803177Ch    ;造顶部砖                            
080319BE 8821     ldrh    r1,[r4]     ;读取取向                            
080319C0 1C28     mov     r0,r5                                   
080319C2 4308     orr     r0,r1       ;orr 800h                            
080319C4 8020     strh    r0,[r4]

@@end:                                 
080319C6 BC30     pop     r4,r5                                   
080319C8 BC01     pop     r0                                      
080319CA 4700     bx      r0                                      

;主程序
080319D0 B500     push    r14                                     
080319D2 4805     ldr     r0,=3000738h                            
080319D4 3024     add     r0,24h                                  
080319D6 7800     ldrb    r0,[r0]      ;查看pose不要大于25h                           
080319D8 2825     cmp     r0,25h                                  
080319DA D861     bhi     @@end                                
080319DC 0080     lsl     r0,r0,2h                                
080319DE 4903     ldr     r1,=80319F0h   ;PoseTable                         
080319E0 1840     add     r0,r0,r1                                
080319E2 6800     ldr     r0,[r0]                                 
080319E4 4687     mov     r15,r0                                  

PoseTable:                               
    .word 8031a88h  ;00
	.word 8031aa0h .word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031a8ch  ;08
	.word 8031a90h  ;09
	.word 8031aa0h .word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031aa0h .word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031aa0h .word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031aa0h .word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031aa0h .word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031aa0h .word 8031aa0h .word 8031aa0h .word 8031aa0h
	.word 8031aa0h  
	.word 8031a96h  ;23h
	.word 8031aa0h  
	.word 8031a9ch  ;25h
    	
08031A88 F7FFFED2 bl      8031830h    ;00                            
08031A8C F7FFFF00 bl      8031890h    ;8h                            
08031A90 F7FFFF14 bl      80318BCh    ;09                            
08031A94 E004     b       8031AA0h                                
08031A96 F7FFFF55 bl      8031944h    ;23h                            
08031A9A E001     b       8031AA0h                                
08031A9C F7FFFF7E bl      803199Ch    ;25h

@@end:                               
08031AA0 BC01     pop     r0                                      
08031AA2 4700     bx      r0  
