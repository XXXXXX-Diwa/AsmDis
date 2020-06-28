0804B604 B510     push    r4,r14                                  
0804B606 4808     ldr     r0,=3000055h                            
0804B608 7800     ldrb    r0,[r0]        
0804B60A 3001     add     r0,1h                                   
0804B60C 0600     lsl     r0,r0,18h                               
0804B60E 0E02     lsr     r2,r0,18h     ;房间号                           
0804B610 1C14     mov     r4,r2                                   
0804B612 4B06     ldr     r3,=3000738h                            
0804B614 1C18     mov     r0,r3                                   
0804B616 3024     add     r0,24h                                  
0804B618 7800     ldrb    r0,[r0]        
0804B61A 2809     cmp     r0,9h          
0804B61C D048     beq     @@Pose9                               
0804B61E 2809     cmp     r0,9h                                   
0804B620 DC06     bgt     @@PoseNoZero                                
0804B622 2800     cmp     r0,0h                                   
0804B624 D007     beq     @@PoseZero                                
0804B626 E0A5     b       @@end                                

@@PoseNoZero:                              
0804B630 2823     cmp     r0,23h                                  
0804B632 D065     beq     @@Pose23                                
0804B634 E09E     b       @@end 

@@PoseZero:                               
0804B636 2A21     cmp     r2,21h      ;检查是否在20房间                            
0804B638 D102     bne     @@RoomNo21                                
0804B63A 2003     mov     r0,3h                                   
0804B63C 2147     mov     r1,47h  ;检查第一次海盗托物的事件                                
0804B63E E003     b       @@Peer

@@RoomNo21:                               
0804B640 2A2F     cmp     r2,2Fh      ;检查是否在2E房间                              
0804B642 D106     bne     @@RoomError                                
0804B644 2003     mov     r0,3h                                   
0804B646 2148     mov     r1,48h  ;检查第二次海盗托物事件

@@Peer:                                 
0804B648 F015F938 bl      80608BCh  ;事件函数                               
0804B64C 0600     lsl     r0,r0,18h                               
0804B64E 0E03     lsr     r3,r0,18h                               
0804B650 E000     b       @@Peer2 

@@RoomError:                               
0804B652 2301     mov     r3,1h 

@@Peer2:                                  
0804B654 2B00     cmp     r3,0h                                   
0804B656 D005     beq     @@Continue                                
0804B658 4901     ldr     r1,=3000738h                            
0804B65A 2000     mov     r0,0h                                   
0804B65C 8008     strh    r0,[r1]   ;消除精灵                              
0804B65E E089     b       @@end                                

@@Continue:                             
0804B664 4A10     ldr     r2,=3000738h                            
0804B666 1C11     mov     r1,r2                                   
0804B668 3127     add     r1,27h                                  
0804B66A 2030     mov     r0,30h                                  
0804B66C 7008     strb    r0,[r1]   ;视野上写入30                               
0804B66E 1C10     mov     r0,r2                                   
0804B670 3028     add     r0,28h                                  
0804B672 7003     strb    r3,[r0]   ;视野左右写入0                              
0804B674 3102     add     r1,2h                                   
0804B676 2020     mov     r0,20h                                  
0804B678 7008     strb    r0,[r1]   ;视野下写入20                              
0804B67A 2100     mov     r1,0h                                   
0804B67C 8153     strh    r3,[r2,0Ah]                             
0804B67E 8193     strh    r3,[r2,0Ch]                             
0804B680 81D3     strh    r3,[r2,0Eh]                             
0804B682 8213     strh    r3,[r2,10h]  ;四面分界全为0                           
0804B684 4809     ldr     r0,=82E4970h ;海盗托物姿势?                          
0804B686 6190     str     r0,[r2,18h]                             
0804B688 7711     strb    r1,[r2,1Ch]                             
0804B68A 82D3     strh    r3,[r2,16h]                             
0804B68C 1C10     mov     r0,r2                                   
0804B68E 3025     add     r0,25h                                  
0804B690 7001     strb    r1,[r0]      ;属性写入0h                             
0804B692 1C11     mov     r1,r2                                   
0804B694 3124     add     r1,24h                                  
0804B696 2009     mov     r0,9h        ;pose写入9h                           
0804B698 7008     strb    r0,[r1]                                 
0804B69A 8810     ldrh    r0,[r2]      ;读取取向                           
0804B69C 2390     mov     r3,90h                                  
0804B69E 009B     lsl     r3,r3,2h     ;240h                           
0804B6A0 1C19     mov     r1,r3                                   
0804B6A2 4308     orr     r0,r1        ;加上取向                           
0804B6A4 8010     strh    r0,[r2]      ;写入取向                           
0804B6A6 E065     b       @@end                                


@@Pose9:                              
0804B6B0 8819     ldrh    r1,[r3]      ;读取取向                           
0804B6B2 2002     mov     r0,2h                                   
0804B6B4 4008     and     r0,r1                                   
0804B6B6 2800     cmp     r0,0h                                   
0804B6B8 D05C     beq     @@end        ;检查如果没在视野内则结束
;-----------------------------------在视野中                        
0804B6BA 2A21     cmp     r2,21h       ;检查是否在20号房间                           
0804B6BC D104     bne     @@RoomNo21s                               
0804B6BE 2001     mov     r0,1h                                   
0804B6C0 2147     mov     r1,47h       ;47事件                           
0804B6C2 F015F8FB bl      80608BCh     ;在20房间则事件写入                           
0804B6C6 E005     b       @@Peer3

@@RoomNo21s:                                
0804B6C8 2C2F     cmp     r4,2Fh                                  
0804B6CA D103     bne     @@Peer3                                
0804B6CC 2001     mov     r0,1h                                   
0804B6CE 2148     mov     r1,48h       ;48事件                            
0804B6D0 F015F8F4 bl      80608BCh

@@Peer3:                                
0804B6D4 4A08     ldr     r2,=3000738h                            
0804B6D6 1C10     mov     r0,r2                                   
0804B6D8 3024     add     r0,24h                                  
0804B6DA 2123     mov     r1,23h      ;pose写入23                            
0804B6DC 7001     strb    r1,[r0]                                 
0804B6DE 7F10     ldrb    r0,[r2,1Ch] ;读取动画帧                            
0804B6E0 2805     cmp     r0,5h                                   
0804B6E2 D947     bls     @@end       ;小于5的话结束                         
0804B6E4 8AD1     ldrh    r1,[r2,16h] ;读取动画                            
0804B6E6 2003     mov     r0,3h                                   
0804B6E8 4008     and     r0,r1       ;与3 and                            
0804B6EA 2800     cmp     r0,0h                                   
0804B6EC D142     bne     @@end       ;不为0则结束                         
0804B6EE 4803     ldr     r0,=165h    ;海盗脚步声                            
0804B6F0 F7B7FA16 bl      8002B20h                                
0804B6F4 E03E     b       @@end                                

@@Pose23:                               
0804B700 7F18     ldrb    r0,[r3,1Ch]  ;读取动画帧                           
0804B702 2805     cmp     r0,5h                                   
0804B704 D90C     bls     @@PassSound                                
0804B706 8AD9     ldrh    r1,[r3,16h]                             
0804B708 2003     mov     r0,3h                                   
0804B70A 4008     and     r0,r1                                   
0804B70C 2800     cmp     r0,0h                                   
0804B70E D107     bne     @@PassSound                                
0804B710 8819     ldrh    r1,[r3]                                 
0804B712 2002     mov     r0,2h                                   
0804B714 4008     and     r0,r1        ;检查是否在视野中                          
0804B716 2800     cmp     r0,0h                                   
0804B718 D002     beq     @@PassSound                                
0804B71A 4809     ldr     r0,=165h     ;播放海盗脚部声                           
0804B71C F7B7FA00 bl      8002B20h 

@@PassSound:                               
0804B720 4A08     ldr     r2,=3000738h                            
0804B722 8811     ldrh    r1,[r2]                                 
0804B724 2080     mov     r0,80h                                  
0804B726 0080     lsl     r0,r0,2h                                
0804B728 4008     and     r0,r1        ;检查海盗的取向                            
0804B72A 1C14     mov     r4,r2                                   
0804B72C 2800     cmp     r0,0h        ;是否没有200                           
0804B72E D00B     beq     @@No200Flag                                
0804B730 88A1     ldrh    r1,[r4,4h]   ;读取X坐标                           
0804B732 1C08     mov     r0,r1                                   
0804B734 3040     add     r0,40h       ;向右一格                          
0804B736 0400     lsl     r0,r0,10h                               
0804B738 0C02     lsr     r2,r0,10h                               
0804B73A 3104     add     r1,4h        ;X坐标向右4h                           
0804B73C E00A     b       @@Peer4                               


@@No200Flag:                              
0804B748 88A1     ldrh    r1,[r4,4h]   ;读取X坐标                             
0804B74A 1C08     mov     r0,r1                                   
0804B74C 3840     sub     r0,40h       ;向左一格                           
0804B74E 0400     lsl     r0,r0,10h                               
0804B750 0C02     lsr     r2,r0,10h                               
0804B752 3904     sub     r1,4h        ;X坐标向左4h

@@Peer4:                                
0804B754 80A1     strh    r1,[r4,4h]   ;新坐标写入X坐标                           
0804B756 8860     ldrh    r0,[r4,2h]   ;读取Y坐标                           
0804B758 3840     sub     r0,40h       ;向上一格                           
0804B75A 1C11     mov     r1,r2                                   
0804B75C F7C3FF94 bl      800F688h     ;检查砖块                           
0804B760 4806     ldr     r0,=30007F1h                            
0804B762 7800     ldrb    r0,[r0]                                 
0804B764 2811     cmp     r0,11h                                  
0804B766 D105     bne     @@end        ;没有砖块则结束 
;--------------------------------------有砖块的情况                       
0804B768 4805     ldr     r0,=30000DCh                            
0804B76A 8800     ldrh    r0,[r0]                                 
0804B76C 2808     cmp     r0,8h                                   
0804B76E D101     bne     @@end                                
0804B770 2000     mov     r0,0h                                   
0804B772 8020     strh    r0,[r4] 

@@end:                                
0804B774 BC10     pop     r4                                      
0804B776 BC01     pop     r0                                      
0804B778 4700     bx      r0                                      


;假道具例程                          
0804B784 B570     push    r4-r6,r14                               
0804B786 4C07     ldr     r4,=3000738h                            
0804B788 1C26     mov     r6,r4                                   
0804B78A 3624     add     r6,24h                                  
0804B78C 7835     ldrb    r5,[r6]    ;读取pose                             
0804B78E 2D00     cmp     r5,0h                                   
0804B790 D129     bne     @@end                                
0804B792 2003     mov     r0,3h                                   
0804B794 2146     mov     r1,46h     ;检查超炸发现事件                             
0804B796 F015F891 bl      80608BCh                                
0804B79A 1C02     mov     r2,r0                                   
0804B79C 2A00     cmp     r2,0h                                   
0804B79E D003     beq     @@PowerBomeHave                                
0804B7A0 8025     strh    r5,[r4]    ;精灵消失                             
0804B7A2 E020     b       @@end                                

@@PowerBomeHave:                             
0804B7A8 1C21     mov     r1,r4                                   
0804B7AA 3127     add     r1,27h     ;视野上写入10                              
0804B7AC 2010     mov     r0,10h                                  
0804B7AE 7008     strb    r0,[r1]                                 
0804B7B0 1C20     mov     r0,r4                                   
0804B7B2 3028     add     r0,28h     ;视野左右写入8                              
0804B7B4 2108     mov     r1,8h                                   
0804B7B6 7001     strb    r1,[r0]                                 
0804B7B8 3001     add     r0,1h                                   
0804B7BA 7001     strb    r1,[r0]    ;视野下写入8                             
0804B7BC 2100     mov     r1,0h                                   
0804B7BE 8162     strh    r2,[r4,0Ah]                             
0804B7C0 81A2     strh    r2,[r4,0Ch]                             
0804B7C2 81E2     strh    r2,[r4,0Eh]                             
0804B7C4 8222     strh    r2,[r4,10h]  ;四面分界全为0                           
0804B7C6 4809     ldr     r0,=831C76Ch                            
0804B7C8 61A0     str     r0,[r4,18h]                             
0804B7CA 7721     strb    r1,[r4,1Ch]                             
0804B7CC 82E2     strh    r2,[r4,16h]                             
0804B7CE 1C20     mov     r0,r4                                   
0804B7D0 3025     add     r0,25h                                  
0804B7D2 7001     strb    r1,[r0]      ;属性写入0                             
0804B7D4 2009     mov     r0,9h                                   
0804B7D6 7030     strb    r0,[r6]      ;pose写入9                           
0804B7D8 1C21     mov     r1,r4                                   
0804B7DA 3122     add     r1,22h                                  
0804B7DC 2005     mov     r0,5h                                   
0804B7DE 7008     strb    r0,[r1]      ;75a写入5                           
0804B7E0 88A0     ldrh    r0,[r4,4h]                              
0804B7E2 3010     add     r0,10h       ;X坐标向右10h                           
0804B7E4 80A0     strh    r0,[r4,4h]

@@end:                              
0804B7E6 BC70     pop     r4-r6                                   
0804B7E8 BC01     pop     r0                                      
0804B7EA 4700     bx      r0                                      


                              
0804B7F0 B570     push    r4-r6,r14                               
0804B7F2 4808     ldr     r0,=3000738h                            
0804B7F4 1C06     mov     r6,r0                                   
0804B7F6 3624     add     r6,24h                                  
0804B7F8 7835     ldrb    r5,[r6]                                 
0804B7FA 1C04     mov     r4,r0                                   
0804B7FC 2D00     cmp     r5,0h                                   
0804B7FE D12B     bne     804B858h                                
0804B800 2003     mov     r0,3h                                   
0804B802 2146     mov     r1,46h                                  
0804B804 F015F85A bl      80608BCh                                
0804B808 1C03     mov     r3,r0                                   
0804B80A 2B00     cmp     r3,0h                                   
0804B80C D004     beq     804B818h                                
0804B80E 8025     strh    r5,[r4]                                 
0804B810 E02E     b       804B870h                                
0804B812 0000     lsl     r0,r0,0h                                
0804B814 0738     lsl     r0,r7,1Ch                               
0804B816 0300     lsl     r0,r0,0Ch                               
0804B818 8821     ldrh    r1,[r4]                                 
0804B81A 4A17     ldr     r2,=8004h                               
0804B81C 1C10     mov     r0,r2                                   
0804B81E 2200     mov     r2,0h                                   
0804B820 4308     orr     r0,r1                                   
0804B822 8020     strh    r0,[r4]                                 
0804B824 1C21     mov     r1,r4                                   
0804B826 3125     add     r1,25h                                  
0804B828 201E     mov     r0,1Eh                                  
0804B82A 7008     strb    r0,[r1]                                 
0804B82C 3102     add     r1,2h                                   
0804B82E 2010     mov     r0,10h                                  
0804B830 7008     strb    r0,[r1]                                 
0804B832 1C20     mov     r0,r4                                   
0804B834 3028     add     r0,28h                                  
0804B836 7002     strb    r2,[r0]                                 
0804B838 3102     add     r1,2h                                   
0804B83A 2018     mov     r0,18h                                  
0804B83C 7008     strb    r0,[r1]                                 
0804B83E 480F     ldr     r0,=0FFC0h                              
0804B840 8160     strh    r0,[r4,0Ah]                             
0804B842 81A3     strh    r3,[r4,0Ch]                             
0804B844 3820     sub     r0,20h                                  
0804B846 81E0     strh    r0,[r4,0Eh]                             
0804B848 2060     mov     r0,60h                                  
0804B84A 8220     strh    r0,[r4,10h]                             
0804B84C 2008     mov     r0,8h                                   
0804B84E 7030     strb    r0,[r6]                                 
0804B850 480B     ldr     r0,=82B2750h                            
0804B852 61A0     str     r0,[r4,18h]                             
0804B854 7722     strb    r2,[r4,1Ch]                             
0804B856 82E3     strh    r3,[r4,16h]                             
0804B858 8821     ldrh    r1,[r4]                                 
0804B85A 2080     mov     r0,80h                                  
0804B85C 0100     lsl     r0,r0,4h                                
0804B85E 4008     and     r0,r1                                   
0804B860 2800     cmp     r0,0h                                   
0804B862 D005     beq     804B870h                                
0804B864 2000     mov     r0,0h                                   
0804B866 8020     strh    r0,[r4]                                 
0804B868 2001     mov     r0,1h                                   
0804B86A 2146     mov     r1,46h                                  
0804B86C F015F826 bl      80608BCh                                
0804B870 BC70     pop     r4-r6                                   
0804B872 BC01     pop     r0                                      
0804B874 4700     bx      r0                                      
0804B876 0000     lsl     r0,r0,0h                                
0804B878 8004     strh    r4,[r0]                                 
0804B87A 0000     lsl     r0,r0,0h                                
0804B87C FFC0     bl      lr+0F80h                                
0804B87E 0000     lsl     r0,r0,0h                                
0804B880 2750     mov     r7,50h                                  
0804B882 082B     lsr     r3,r5,20h                               
0804B884 B510     push    r4,r14                                  
0804B886 4906     ldr     r1,=3000738h                            
0804B888 1C08     mov     r0,r1                                   
0804B88A 3024     add     r0,24h                                  
0804B88C 7800     ldrb    r0,[r0]                                 
0804B88E 1C0C     mov     r4,r1                                   
0804B890 2827     cmp     r0,27h                                  
0804B892 D900     bls     804B896h                                
0804B894 E0FF     b       804BA96h                                
0804B896 0080     lsl     r0,r0,2h                                
0804B898 4902     ldr     r1,=804B8A8h                            
0804B89A 1840     add     r0,r0,r1                                
0804B89C 6800     ldr     r0,[r0]                                 
0804B89E 4687     mov     r15,r0                                  
0804B8A0 0738     lsl     r0,r7,1Ch                               
0804B8A2 0300     lsl     r0,r0,0Ch                               
0804B8A4 B8A8     ????                                            
0804B8A6 0804     lsr     r4,r0,20h                               
0804B8A8 B948     ????                                            
0804B8AA 0804     lsr     r4,r0,20h                               
0804B8AC BA96     ????                                            
0804B8AE 0804     lsr     r4,r0,20h                               
0804B8B0 BA96     ????                                            
0804B8B2 0804     lsr     r4,r0,20h                               
0804B8B4 BA96     ????                                            
0804B8B6 0804     lsr     r4,r0,20h                               
0804B8B8 BA96     ????                                            
0804B8BA 0804     lsr     r4,r0,20h                               
0804B8BC BA96     ????                                            
0804B8BE 0804     lsr     r4,r0,20h                               
0804B8C0 BA96     ????                                            
0804B8C2 0804     lsr     r4,r0,20h                               
0804B8C4 BA96     ????                                            
0804B8C6 0804     lsr     r4,r0,20h                               
0804B8C8 BA96     ????                                            
0804B8CA 0804     lsr     r4,r0,20h                               
0804B8CC B9B4     ????                                            
0804B8CE 0804     lsr     r4,r0,20h                               
0804B8D0 BA96     ????                                            
0804B8D2 0804     lsr     r4,r0,20h                               
0804B8D4 BA96     ????                                            
0804B8D6 0804     lsr     r4,r0,20h                               
0804B8D8 BA96     ????                                            
0804B8DA 0804     lsr     r4,r0,20h                               
0804B8DC BA96     ????                                            
0804B8DE 0804     lsr     r4,r0,20h                               
0804B8E0 BA96     ????                                            
0804B8E2 0804     lsr     r4,r0,20h                               
0804B8E4 BA96     ????                                            
0804B8E6 0804     lsr     r4,r0,20h                               
0804B8E8 BA96     ????                                            
0804B8EA 0804     lsr     r4,r0,20h                               
0804B8EC BA96     ????                                            
0804B8EE 0804     lsr     r4,r0,20h                               
0804B8F0 BA96     ????                                            
0804B8F2 0804     lsr     r4,r0,20h                               
0804B8F4 BA96     ????                                            
0804B8F6 0804     lsr     r4,r0,20h                               
0804B8F8 BA96     ????                                            
0804B8FA 0804     lsr     r4,r0,20h                               
0804B8FC BA96     ????                                            
0804B8FE 0804     lsr     r4,r0,20h                               
0804B900 BA96     ????                                            
0804B902 0804     lsr     r4,r0,20h                               
0804B904 BA96     ????                                            
0804B906 0804     lsr     r4,r0,20h                               
0804B908 BA96     ????                                            
0804B90A 0804     lsr     r4,r0,20h                               
0804B90C BA96     ????                                            
0804B90E 0804     lsr     r4,r0,20h                               
0804B910 BA96     ????                                            
0804B912 0804     lsr     r4,r0,20h                               
0804B914 BA96     ????                                            
0804B916 0804     lsr     r4,r0,20h                               
0804B918 BA96     ????                                            
0804B91A 0804     lsr     r4,r0,20h                               
0804B91C BA96     ????                                            
0804B91E 0804     lsr     r4,r0,20h                               
0804B920 BA96     ????                                            
0804B922 0804     lsr     r4,r0,20h                               
0804B924 BA96     ????                                            
0804B926 0804     lsr     r4,r0,20h                               
0804B928 BA96     ????                                            
0804B92A 0804     lsr     r4,r0,20h                               
0804B92C BA96     ????                                            
0804B92E 0804     lsr     r4,r0,20h                               
0804B930 BA96     ????                                            
0804B932 0804     lsr     r4,r0,20h                               
0804B934 B9D8     ????                                            
0804B936 0804     lsr     r4,r0,20h                               
0804B938 BA96     ????                                            
0804B93A 0804     lsr     r4,r0,20h                               
0804B93C B9F8     ????                                            
0804B93E 0804     lsr     r4,r0,20h                               
0804B940 BA96     ????                                            
0804B942 0804     lsr     r4,r0,20h                               
0804B944 BA7A     ????                                            
0804B946 0804     lsr     r4,r0,20h                               
0804B948 8821     ldrh    r1,[r4]                                 
0804B94A 2004     mov     r0,4h                                   
0804B94C 2200     mov     r2,0h                                   
0804B94E 2300     mov     r3,0h                                   
0804B950 4308     orr     r0,r1                                   
0804B952 8020     strh    r0,[r4]                                 
0804B954 88A0     ldrh    r0,[r4,4h]                              
0804B956 3020     add     r0,20h                                  
0804B958 80A0     strh    r0,[r4,4h]                              
0804B95A 20FF     mov     r0,0FFh                                 
0804B95C 0200     lsl     r0,r0,8h                                
0804B95E 8160     strh    r0,[r4,0Ah]                             
0804B960 81A3     strh    r3,[r4,0Ch]                             
0804B962 3080     add     r0,80h                                  
0804B964 81E0     strh    r0,[r4,0Eh]                             
0804B966 2080     mov     r0,80h                                  
0804B968 8220     strh    r0,[r4,10h]                             
0804B96A 1C21     mov     r1,r4                                   
0804B96C 3127     add     r1,27h                                  
0804B96E 2040     mov     r0,40h                                  
0804B970 7008     strb    r0,[r1]                                 
0804B972 1C20     mov     r0,r4                                   
0804B974 3028     add     r0,28h                                  
0804B976 7002     strb    r2,[r0]                                 
0804B978 3102     add     r1,2h                                   
0804B97A 2020     mov     r0,20h                                  
0804B97C 7008     strb    r0,[r1]                                 
0804B97E 1C20     mov     r0,r4                                   
0804B980 3025     add     r0,25h                                  
0804B982 7002     strb    r2,[r0]                                 
0804B984 4809     ldr     r0,=3000088h                            
0804B986 7B01     ldrb    r1,[r0,0Ch]                             
0804B988 2003     mov     r0,3h                                   
0804B98A 4008     and     r0,r1                                   
0804B98C 1C21     mov     r1,r4                                   
0804B98E 3121     add     r1,21h                                  
0804B990 7008     strb    r0,[r1]                                 
0804B992 4807     ldr     r0,=831CB54h                            
0804B994 61A0     str     r0,[r4,18h]                             
0804B996 82E3     strh    r3,[r4,16h]                             
0804B998 7722     strb    r2,[r4,1Ch]                             
0804B99A 3103     add     r1,3h                                   
0804B99C 2009     mov     r0,9h                                   
0804B99E 7008     strb    r0,[r1]                                 
0804B9A0 30F7     add     r0,0F7h                                 
0804B9A2 80E0     strh    r0,[r4,6h]                              
0804B9A4 1C20     mov     r0,r4                                   
0804B9A6 302C     add     r0,2Ch                                  
0804B9A8 7002     strb    r2,[r0]                                 
0804B9AA E074     b       804BA96h                                
0804B9AC 0088     lsl     r0,r1,2h                                
0804B9AE 0300     lsl     r0,r0,0Ch                               
0804B9B0 CB54     ldmia   [r3]!,r2,r4,r6                          
0804B9B2 0831     lsr     r1,r6,20h                               
0804B9B4 4806     ldr     r0,=300070Ch                            
0804B9B6 7BC0     ldrb    r0,[r0,0Fh]                             
0804B9B8 2808     cmp     r0,8h                                   
0804B9BA D16C     bne     804BA96h                                
0804B9BC 8821     ldrh    r1,[r4]                                 
0804B9BE 4805     ldr     r0,=0FFFBh                              
0804B9C0 4008     and     r0,r1                                   
0804B9C2 8020     strh    r0,[r4]                                 
0804B9C4 1C21     mov     r1,r4                                   
0804B9C6 3124     add     r1,24h                                  
0804B9C8 2023     mov     r0,23h                                  
0804B9CA 7008     strb    r0,[r1]                                 
0804B9CC E063     b       804BA96h                                
0804B9CE 0000     lsl     r0,r0,0h                                
0804B9D0 070C     lsl     r4,r1,1Ch                               
0804B9D2 0300     lsl     r0,r0,0Ch                               
0804B9D4 FFFB     bl      lr+0FF6h                                
0804B9D6 0000     lsl     r0,r0,0h                                
0804B9D8 8821     ldrh    r1,[r4]                                 
0804B9DA 2002     mov     r0,2h                                   
0804B9DC 4008     and     r0,r1                                   
0804B9DE 2800     cmp     r0,0h                                   
0804B9E0 D059     beq     804BA96h                                
0804B9E2 1C20     mov     r0,r4                                   
0804B9E4 3024     add     r0,24h                                  
0804B9E6 2125     mov     r1,25h                                  
0804B9E8 7001     strb    r1,[r0]                                 
0804B9EA 4802     ldr     r0,=10Bh                                
0804B9EC F7B7F814 bl      8002A18h                                
0804B9F0 E051     b       804BA96h                                
0804B9F2 0000     lsl     r0,r0,0h                                
0804B9F4 010B     lsl     r3,r1,4h                                
0804B9F6 0000     lsl     r0,r0,0h                                
0804B9F8 88E0     ldrh    r0,[r4,6h]                              
0804B9FA 2800     cmp     r0,0h                                   
0804B9FC D030     beq     804BA60h                                
0804B9FE 1C21     mov     r1,r4                                   
0804BA00 312C     add     r1,2Ch                                  
0804BA02 780A     ldrb    r2,[r1]                                 
0804BA04 1C50     add     r0,r2,1                                 
0804BA06 7008     strb    r0,[r1]                                 
0804BA08 200F     mov     r0,0Fh                                  
0804BA0A 4010     and     r0,r2                                   
0804BA0C 2800     cmp     r0,0h                                   
0804BA0E D116     bne     804BA3Eh                                
0804BA10 2014     mov     r0,14h                                  
0804BA12 2181     mov     r1,81h                                  
0804BA14 F009FC96 bl      8055344h                                
0804BA18 480D     ldr     r0,=3000C77h                            
0804BA1A 7801     ldrb    r1,[r0]                                 
0804BA1C 2001     mov     r0,1h                                   
0804BA1E 4008     and     r0,r1                                   
0804BA20 2239     mov     r2,39h                                  
0804BA22 2800     cmp     r0,0h                                   
0804BA24 D000     beq     804BA28h                                
0804BA26 2238     mov     r2,38h                                  
0804BA28 8860     ldrh    r0,[r4,2h]                              
0804BA2A 490A     ldr     r1,=0FFFFFF00h                          
0804BA2C 1840     add     r0,r0,r1                                
0804BA2E 490A     ldr     r1,=300083Ch                            
0804BA30 7809     ldrb    r1,[r1]                                 
0804BA32 00C9     lsl     r1,r1,3h                                
0804BA34 3938     sub     r1,38h                                  
0804BA36 88A4     ldrh    r4,[r4,4h]                              
0804BA38 1909     add     r1,r1,r4                                
0804BA3A F008FB57 bl      80540ECh                                
0804BA3E 4807     ldr     r0,=3000738h                            
0804BA40 88C1     ldrh    r1,[r0,6h]                              
0804BA42 3901     sub     r1,1h                                   
0804BA44 80C1     strh    r1,[r0,6h]                              
0804BA46 8841     ldrh    r1,[r0,2h]                              
0804BA48 3101     add     r1,1h                                   
0804BA4A 8041     strh    r1,[r0,2h]                              
0804BA4C E023     b       804BA96h                                
0804BA4E 0000     lsl     r0,r0,0h                                
0804BA50 0C77     lsr     r7,r6,11h                               
0804BA52 0300     lsl     r0,r0,0Ch                               
0804BA54 FF00     bl      lr+0E00h                                
0804BA56 FFFF     bl      lr+0FFEh                                
0804BA58 083C     lsr     r4,r7,20h                               
0804BA5A 0300     lsl     r0,r0,0Ch                               
0804BA5C 0738     lsl     r0,r7,1Ch                               
0804BA5E 0300     lsl     r0,r0,0Ch                               
0804BA60 1C21     mov     r1,r4                                   
0804BA62 3124     add     r1,24h                                  
0804BA64 2027     mov     r0,27h                                  
0804BA66 7008     strb    r0,[r1]                                 
0804BA68 203C     mov     r0,3Ch                                  
0804BA6A 2181     mov     r1,81h                                  
0804BA6C F009FC6A bl      8055344h                                
0804BA70 1C21     mov     r1,r4                                   
0804BA72 312C     add     r1,2Ch                                  
0804BA74 2028     mov     r0,28h                                  
0804BA76 7008     strb    r0,[r1]                                 
0804BA78 E00D     b       804BA96h                                
0804BA7A 1C21     mov     r1,r4                                   
0804BA7C 312C     add     r1,2Ch                                  
0804BA7E 7808     ldrb    r0,[r1]                                 
0804BA80 3801     sub     r0,1h                                   
0804BA82 7008     strb    r0,[r1]                                 
0804BA84 0600     lsl     r0,r0,18h                               
0804BA86 2800     cmp     r0,0h                                   
0804BA88 D105     bne     804BA96h                                
0804BA8A 3908     sub     r1,8h                                   
0804BA8C 2029     mov     r0,29h                                  
0804BA8E 7008     strb    r0,[r1]                                 
0804BA90 20A7     mov     r0,0A7h                                 
0804BA92 F7B6FFC1 bl      8002A18h                                
0804BA96 BC10     pop     r4                                      
0804BA98 BC01     pop     r0                                      
0804BA9A 4700     bx      r0                                      
0804BA9C B510     push    r4,r14                                  
0804BA9E 4C16     ldr     r4,=300070Ch                            
0804BAA0 88A0     ldrh    r0,[r4,4h]                              
0804BAA2 6821     ldr     r1,[r4]                                 
0804BAA4 00C0     lsl     r0,r0,3h                                
0804BAA6 1840     add     r0,r0,r1                                
0804BAA8 6803     ldr     r3,[r0]                                 
0804BAAA 4A14     ldr     r2,=3000738h                            
0804BAAC 7F91     ldrb    r1,[r2,1Eh]                             
0804BAAE 0048     lsl     r0,r1,1h                                
0804BAB0 1840     add     r0,r0,r1                                
0804BAB2 0040     lsl     r0,r0,1h                                
0804BAB4 18C0     add     r0,r0,r3                                
0804BAB6 8800     ldrh    r0,[r0]                                 
0804BAB8 4911     ldr     r1,=875F878h                            
0804BABA 0080     lsl     r0,r0,2h                                
0804BABC 1840     add     r0,r0,r1                                
0804BABE 6991     ldr     r1,[r2,18h]                             
0804BAC0 6800     ldr     r0,[r0]                                 
0804BAC2 4281     cmp     r1,r0                                   
0804BAC4 D003     beq     804BACEh                                
0804BAC6 6190     str     r0,[r2,18h]                             
0804BAC8 2000     mov     r0,0h                                   
0804BACA 7710     strb    r0,[r2,1Ch]                             
0804BACC 82D0     strh    r0,[r2,16h]                             
0804BACE 7F91     ldrb    r1,[r2,1Eh]                             
0804BAD0 0048     lsl     r0,r1,1h                                
0804BAD2 1840     add     r0,r0,r1                                
0804BAD4 0040     lsl     r0,r0,1h                                
0804BAD6 18C0     add     r0,r0,r3                                
0804BAD8 8840     ldrh    r0,[r0,2h]                              
0804BADA 88E1     ldrh    r1,[r4,6h]                              
0804BADC 1840     add     r0,r0,r1                                
0804BADE 8050     strh    r0,[r2,2h]                              
0804BAE0 7F91     ldrb    r1,[r2,1Eh]                             
0804BAE2 0048     lsl     r0,r1,1h                                
0804BAE4 1840     add     r0,r0,r1                                
0804BAE6 0040     lsl     r0,r0,1h                                
0804BAE8 18C0     add     r0,r0,r3                                
0804BAEA 8880     ldrh    r0,[r0,4h]                              
0804BAEC 8924     ldrh    r4,[r4,8h]                              
0804BAEE 1900     add     r0,r0,r4                                
0804BAF0 8090     strh    r0,[r2,4h]                              
0804BAF2 BC10     pop     r4                                      
0804BAF4 BC01     pop     r0                                      
0804BAF6 4700     bx      r0                                      
0804BAF8 070C     lsl     r4,r1,1Ch                               
0804BAFA 0300     lsl     r0,r0,0Ch                               
0804BAFC 0738     lsl     r0,r7,1Ch                               
0804BAFE 0300     lsl     r0,r0,0Ch                               
0804BB00 F878     bl      lr+0F0h                                 
0804BB02 0875     lsr     r5,r6,1h                                
0804BB04 B530     push    r4,r5,r14                               
0804BB06 4C04     ldr     r4,=3000738h                            
0804BB08 1C25     mov     r5,r4                                   
0804BB0A 352C     add     r5,2Ch                                  
0804BB0C 7828     ldrb    r0,[r5]                                 
0804BB0E 2800     cmp     r0,0h                                   
0804BB10 D004     beq     804BB1Ch                                
0804BB12 3801     sub     r0,1h                                   
0804BB14 7028     strb    r0,[r5]                                 
0804BB16 E029     b       804BB6Ch                                
0804BB18 0738     lsl     r0,r7,1Ch                               
0804BB1A 0300     lsl     r0,r0,0Ch                               
0804BB1C 202D     mov     r0,2Dh                                  
0804BB1E 1900     add     r0,r0,r4                                
0804BB20 4684     mov     r12,r0                                  
0804BB22 7800     ldrb    r0,[r0]                                 
0804BB24 1C41     add     r1,r0,1                                 
0804BB26 4662     mov     r2,r12                                  
0804BB28 7011     strb    r1,[r2]                                 
0804BB2A 0600     lsl     r0,r0,18h                               
0804BB2C 0E02     lsr     r2,r0,18h                               
0804BB2E 4911     ldr     r1,=831FCE4h                            
0804BB30 0050     lsl     r0,r2,1h                                
0804BB32 1840     add     r0,r0,r1                                
0804BB34 7803     ldrb    r3,[r0]                                 
0804BB36 2B80     cmp     r3,80h                                  
0804BB38 D104     bne     804BB44h                                
0804BB3A 2001     mov     r0,1h                                   
0804BB3C 4662     mov     r2,r12                                  
0804BB3E 7010     strb    r0,[r2]                                 
0804BB40 2200     mov     r2,0h                                   
0804BB42 780B     ldrb    r3,[r1]                                 
0804BB44 0050     lsl     r0,r2,1h                                
0804BB46 3101     add     r1,1h                                   
0804BB48 1840     add     r0,r0,r1                                
0804BB4A 7800     ldrb    r0,[r0]                                 
0804BB4C 7028     strb    r0,[r5]                                 
0804BB4E 4A0A     ldr     r2,=40000D4h                            
0804BB50 0158     lsl     r0,r3,5h                                
0804BB52 490A     ldr     r1,=8323AC2h                            
0804BB54 1840     add     r0,r0,r1                                
0804BB56 6010     str     r0,[r2]                                 
0804BB58 1C20     mov     r0,r4                                   
0804BB5A 3034     add     r0,34h                                  
0804BB5C 7800     ldrb    r0,[r0]                                 
0804BB5E 0140     lsl     r0,r0,5h                                
0804BB60 4907     ldr     r1,=500031Ah                            
0804BB62 1840     add     r0,r0,r1                                
0804BB64 6050     str     r0,[r2,4h]                              
0804BB66 4807     ldr     r0,=80000003h                           
0804BB68 6090     str     r0,[r2,8h]                              
0804BB6A 6890     ldr     r0,[r2,8h]                              
0804BB6C BC30     pop     r4,r5                                   
0804BB6E BC01     pop     r0                                      
0804BB70 4700     bx      r0                                      
0804BB72 0000     lsl     r0,r0,0h                                
0804BB74 FCE4     bl      lr+9C8h                                 
0804BB76 0831     lsr     r1,r6,20h                               
0804BB78 00D4     lsl     r4,r2,3h                                
0804BB7A 0400     lsl     r0,r0,10h                               
0804BB7C 3AC2     sub     r2,0C2h                                 
0804BB7E 0832     lsr     r2,r6,20h                               
0804BB80 031A     lsl     r2,r3,0Ch                               
0804BB82 0500     lsl     r0,r0,14h                               
0804BB84 0003     lsl     r3,r0,0h                                
0804BB86 8000     strh    r0,[r0]                                 
0804BB88 B530     push    r4,r5,r14                               
0804BB8A 481F     ldr     r0,=300080Ch                            
0804BB8C 8943     ldrh    r3,[r0,0Ah]                             
0804BB8E 2B00     cmp     r3,0h                                   
0804BB90 D137     bne     804BC02h                                
0804BB92 89C0     ldrh    r0,[r0,0Eh]                             
0804BB94 2800     cmp     r0,0h                                   
0804BB96 D034     beq     804BC02h                                
0804BB98 491C     ldr     r1,=3000738h                            
0804BB9A 1C0A     mov     r2,r1                                   
0804BB9C 322E     add     r2,2Eh                                  
0804BB9E 7810     ldrb    r0,[r2]                                 
0804BBA0 3001     add     r0,1h                                   
0804BBA2 7010     strb    r0,[r2]                                 
0804BBA4 312F     add     r1,2Fh                                  
0804BBA6 7808     ldrb    r0,[r1]                                 
0804BBA8 3001     add     r0,1h                                   
0804BBAA 7008     strb    r0,[r1]                                 
0804BBAC 0600     lsl     r0,r0,18h                               
0804BBAE 0E00     lsr     r0,r0,18h                               
0804BBB0 2803     cmp     r0,3h                                   
0804BBB2 D900     bls     804BBB6h                                
0804BBB4 700B     strb    r3,[r1]                                 
0804BBB6 780A     ldrb    r2,[r1]                                 
0804BBB8 4915     ldr     r1,=40000D4h                            
0804BBBA 01D2     lsl     r2,r2,7h                                
0804BBBC 4B15     ldr     r3,=83225E8h                            
0804BBBE 18D0     add     r0,r2,r3                                
0804BBC0 6008     str     r0,[r1]                                 
0804BBC2 4815     ldr     r0,=6014280h                            
0804BBC4 6048     str     r0,[r1,4h]                              
0804BBC6 4C15     ldr     r4,=80000040h                           
0804BBC8 608C     str     r4,[r1,8h]                              
0804BBCA 6888     ldr     r0,[r1,8h]                              
0804BBCC 2580     mov     r5,80h                                  
0804BBCE 00ED     lsl     r5,r5,3h                                
0804BBD0 1958     add     r0,r3,r5                                
0804BBD2 1810     add     r0,r2,r0                                
0804BBD4 6008     str     r0,[r1]                                 
0804BBD6 4812     ldr     r0,=6014680h                            
0804BBD8 6048     str     r0,[r1,4h]                              
0804BBDA 608C     str     r4,[r1,8h]                              
0804BBDC 6888     ldr     r0,[r1,8h]                              
0804BBDE 2580     mov     r5,80h                                  
0804BBE0 012D     lsl     r5,r5,4h                                
0804BBE2 1958     add     r0,r3,r5                                
0804BBE4 1810     add     r0,r2,r0                                
0804BBE6 6008     str     r0,[r1]                                 
0804BBE8 480E     ldr     r0,=6014A80h                            
0804BBEA 6048     str     r0,[r1,4h]                              
0804BBEC 608C     str     r4,[r1,8h]                              
0804BBEE 6888     ldr     r0,[r1,8h]                              
0804BBF0 20C0     mov     r0,0C0h                                 
0804BBF2 0100     lsl     r0,r0,4h                                
0804BBF4 181B     add     r3,r3,r0                                
0804BBF6 18D2     add     r2,r2,r3                                
0804BBF8 600A     str     r2,[r1]                                 
0804BBFA 480B     ldr     r0,=6014E80h                            
0804BBFC 6048     str     r0,[r1,4h]                              
0804BBFE 608C     str     r4,[r1,8h]                              
0804BC00 6888     ldr     r0,[r1,8h]                              
0804BC02 BC30     pop     r4,r5                                   

