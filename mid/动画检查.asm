
;门传送时候的动画检查
0805F744 B500     push    r14                                     
0805F746 0600     lsl     r0,r0,18h                               
0805F748 0E00     lsr     r0,r0,18h   ;当前区域的值                            
0805F74A 0609     lsl     r1,r1,18h                               
0805F74C 0E0A     lsr     r2,r1,18h   ;房间序号值加1                            
0805F74E 2806     cmp     r0,6h                                   
0805F750 D84B     bhi     @@end                                
0805F752 0080     lsl     r0,r0,2h                                
0805F754 4901     ldr     r1,=Table                            
0805F756 1840     add     r0,r0,r1                                
0805F758 6800     ldr     r0,[r0]                                 
0805F75A 4687     mov     r15,r0                                  

Table:
.word 805f7eah ;00
.word 805f77ch ;01
.word 805f7eah .word 805f7eah .word 805f7eah .word 805f7eah
.word 805f7a4h ;06

;区域1的时候,也就是克雷德                                                              
0805F77C 2A1F     cmp     r2,1Fh    ;房间序号加1                              
0805F77E D134     bne     @@end                                
0805F780 2003     mov     r0,3h                                   
0805F782 211E     mov     r1,1Eh                                  
0805F784 F001F89A bl      80608BCh  ;检查克雷德死亡事件                               
0805F788 2800     cmp     r0,0h                                   
0805F78A D12E     bne     @@end                                
0805F78C 200A     mov     r0,0Ah                                  
0805F78E F7A4F983 bl      8003A98h  ;音乐相关                              
0805F792 200A     mov     r0,0Ah                                  
0805F794 F7A3F99A bl      8002ACCh  ;音乐相关                              
0805F798 4901     ldr     r1,=300007Dh                            
0805F79A 2005     mov     r0,5h     ;动画5      克雷德出现动画                          
0805F79C E024     b       @@WriteCurrentCutscene ;同时之后播放boss战音乐                               

;区域6的时候,也就是最终区域                               
0805F7A4 2A2B     cmp     r2,2Bh    ;精灵壁画房间                              
0805F7A6 D10B     bne     @@Other                                
0805F7A8 2003     mov     r0,3h                                   
0805F7AA 2143     mov     r1,43h                                  
0805F7AC F001F886 bl      80608BCh  ;检查全装甲事件                              
0805F7B0 2800     cmp     r0,0h                                   
0805F7B2 D11A     bne     @@end                                
0805F7B4 4901     ldr     r1,=300007Dh                            
0805F7B6 200B     mov     r0,0Bh    ;见精灵壁画动画                              
0805F7B8 E016     b       @@WriteCurrentCutscene  ;之后没有音乐                              

@@Other:                             
0805F7C0 2A0B     cmp     r2,0Bh    ;机鸟睁眼触发房间                              
0805F7C2 D112     bne     @@end                                
0805F7C4 2003     mov     r0,3h                                   
0805F7C6 2106     mov     r1,6h                                   
0805F7C8 F001F878 bl      80608BCh  ;检查机鸟睁眼事件                                
0805F7CC 2800     cmp     r0,0h                                   
0805F7CE D10C     bne     @@end                                
0805F7D0 4807     ldr     r0,=3005518h                            
0805F7D2 8801     ldrh    r1,[r0]   ;读取雨声效果flag                              
0805F7D4 2002     mov     r0,2h                                   
0805F7D6 4008     and     r0,r1                                   
0805F7D8 2800     cmp     r0,0h                                   
0805F7DA D003     beq     805F7E4h                                
0805F7DC 4805     ldr     r0,=121h                                
0805F7DE 210A     mov     r1,0Ah                                  
0805F7E0 F7A3FA4E bl      8002C80h  ;播放一段时间雨声?

@@NoRainSoundFlag:                               
0805F7E4 4904     ldr     r1,=300007Dh                          
0805F7E6 200D     mov     r0,0Dh       

@@WriteCurrentCutscene:                           
0805F7E8 7008     strb    r0,[r1]  

@@end:                               
0805F7EA BC01     pop     r0                                      
0805F7EC 4700     bx      r0                                      


;电梯过渡动画检查                              
0805F7FC B500     push    r14                                     
0805F7FE 4805     ldr     r0,=3000198h                            
0805F800 7881     ldrb    r1,[r0,2h]  ;最近使用的电梯序号                             
0805F802 1C02     mov     r2,r0                                   
0805F804 2905     cmp     r1,5h                                   
0805F806 D871     bhi     @@end                                
0805F808 0088     lsl     r0,r1,2h                                
0805F80A 4903     ldr     r1,=Table                            
0805F80C 1840     add     r0,r0,r1                                
0805F80E 6800     ldr     r0,[r0]                                 
0805F810 4687     mov     r15,r0                                  
Table:
.word 805f8ech   ;电梯0
.word 805f8ech   ;电梯1
.word 805f834h   ;电梯2
.word 805f854h   ;电梯3
.word 805f884h   ;电梯4
.word 805f8bch   ;电梯5

;电梯2     布林连火区                   
0805F834 2003     mov     r0,3h                                   
0805F836 5610     ldsb    r0,[r2,r0]                              
0805F838 2801     cmp     r0,1h       ;电梯的方向标记                             
0805F83A D157     bne     @@end       ;非向下则结束                         
0805F83C 2003     mov     r0,3h                                   
0805F83E 2103     mov     r1,3h       ;检查母脑睁眼动画的事件                            
0805F840 F001F83C bl      80608BCh                                
0805F844 2800     cmp     r0,0h       ;没有激活则继续否则结束                            
0805F846 D151     bne     @@end                                
0805F848 4801     ldr     r0,=300007Dh                            
0805F84A 2104     mov     r1,4h       ;动画写入4,母脑睁眼动画                            
0805F84C E026     b       @@Write                                


;电梯3     布林连克雷德                             
0805F854 2103     mov     r1,3h                                   
0805F856 5651     ldsb    r1,[r2,r1]                              
0805F858 2001     mov     r0,1h                                   
0805F85A 4240     neg     r0,r0                                   
0805F85C 4281     cmp     r1,r0       ;检查电梯是否是向上的                            
0805F85E D145     bne     @@end       ;不是这结束                         
0805F860 2003     mov     r0,3h                                   
0805F862 211E     mov     r1,1Eh      ;检查克雷德是否死亡                            
0805F864 F001F82A bl      80608BCh                                
0805F868 2800     cmp     r0,0h                                   
0805F86A D03F     beq     @@end       ;否则结束                         
0805F86C 2003     mov     r0,3h                                   
0805F86E 2104     mov     r1,4h       ;检查宇宙飞船来临动画                            
0805F870 F001F824 bl      80608BCh                                
0805F874 2800     cmp     r0,0h                                   
0805F876 D139     bne     @@end       ;已经激活则结束                         
0805F878 4801     ldr     r0,=300007Dh                            
0805F87A 2107     mov     r1,7h       ;宇宙飞船来临动画                            
0805F87C E00E     b       @@Write                                

;电梯4                                   
0805F884 2003     mov     r0,3h                                   
0805F886 5610     ldsb    r0,[r2,r0]                              
0805F888 2801     cmp     r0,1h       ;检查是否是向下的电梯                            
0805F88A D12F     bne     @@end                                
0805F88C 2003     mov     r0,3h                                   
0805F88E 2105     mov     r1,5h       ;检查飞船落地的动画                            
0805F890 F001F814 bl      80608BCh                                
0805F894 2800     cmp     r0,0h       ;未激活则继续                            
0805F896 D129     bne     @@end                                
0805F898 4807     ldr     r0,=300007Dh                            
0805F89A 2108     mov     r1,8h       ;宇宙飞船降落的动画

@@Write:                            
0805F89C 7001     strb    r1,[r0]     ;写入动画序号                            
0805F89E 2002     mov     r0,2h                                   
0805F8A0 F7FCFBE8 bl      805C074h    ;一些数据的清空                            
0805F8A4 2087     mov     r0,87h                                  
0805F8A6 0040     lsl     r0,r0,1h                                
0805F8A8 210A     mov     r1,0Ah                                  
0805F8AA F7A3F9E9 bl      8002C80h    ;10E电梯声                             
0805F8AE 200A     mov     r0,0Ah                                  
0805F8B0 F7A4F8F2 bl      8003A98h    ;播放音乐还是停止音乐?                            
0805F8B4 E01A     b       @@end                                

;电梯5                                  
0805F8BC 2003     mov     r0,3h                                   
0805F8BE 5610     ldsb    r0,[r2,r0]                              
0805F8C0 2801     cmp     r0,1h       ;检查是否是向下的电梯                            
0805F8C2 D113     bne     @@end                                
0805F8C4 2003     mov     r0,3h                                   
0805F8C6 2107     mov     r1,7h       ;m失控动画                            
0805F8C8 F000FFF8 bl      80608BCh                                
0805F8CC 2800     cmp     r0,0h                                   
0805F8CE D10D     bne     @@end                                
0805F8D0 4807     ldr     r0,=300007Dh                            
0805F8D2 210A     mov     r1,0Ah      ;小M喝血动画                            
0805F8D4 7001     strb    r1,[r0]                                 
0805F8D6 2002     mov     r0,2h                                   
0805F8D8 F7FCFBCC bl      805C074h    ;以下同样的套路和配方                            
0805F8DC 2087     mov     r0,87h                                  
0805F8DE 0040     lsl     r0,r0,1h                                
0805F8E0 210A     mov     r1,0Ah                                  
0805F8E2 F7A3F9CD bl      8002C80h                                
0805F8E6 200A     mov     r0,0Ah                                  
0805F8E8 F7A4F8D6 bl      8003A98h  

@@end:                              
0805F8EC BC01     pop     r0                                      
0805F8EE 4700     bx      r0                                      


                              
0805F8F4 B570     push    r4-r6,r14                               
0805F8F6 464E     mov     r6,r9                                   
0805F8F8 4645     mov     r5,r8                                   
0805F8FA B460     push    r5,r6                                   
0805F8FC B081     add     sp,-4h                                  
0805F8FE 2500     mov     r5,0h                                   
0805F900 4805     ldr     r0,=300019Ch                            
0805F902 7881     ldrb    r1,[r0,2h]                              
0805F904 1C02     mov     r2,r0                                   
0805F906 290E     cmp     r1,0Eh                                  
0805F908 D900     bls     805F90Ch                                
0805F90A E218     b       805FD3Eh                                
0805F90C 0088     lsl     r0,r1,2h                                
0805F90E 4903     ldr     r1,=805F920h                            
0805F910 1840     add     r0,r0,r1                                
0805F912 6800     ldr     r0,[r0]                                 
0805F914 4687     mov     r15,r0                                  
0805F916 0000     lsl     r0,r0,0h                                
0805F918 019C     lsl     r4,r3,6h                                
0805F91A 0300     lsl     r0,r0,0Ch                               
0805F91C F920     bl      lr+240h                                 
0805F91E 0805     lsr     r5,r0,20h                               
0805F920 F95C     bl      lr+2B8h                                 
0805F922 0805     lsr     r5,r0,20h                               
0805F924 F970     bl      lr+2E0h                                 
0805F926 0805     lsr     r5,r0,20h                               
0805F928 F97A     bl      lr+2F4h                                 
0805F92A 0805     lsr     r5,r0,20h                               
0805F92C F998     bl      lr+330h                                 
0805F92E 0805     lsr     r5,r0,20h                               
0805F930 F9A4     bl      lr+348h                                 
0805F932 0805     lsr     r5,r0,20h                               
0805F934 F98C     bl      lr+318h                                 
0805F936 0805     lsr     r5,r0,20h                               
0805F938 FAA8     bl      lr+550h                                 
0805F93A 0805     lsr     r5,r0,20h                               
0805F93C F98C     bl      lr+318h                                 
0805F93E 0805     lsr     r5,r0,20h                               
0805F940 FBAC     bl      lr+758h                                 
0805F942 0805     lsr     r5,r0,20h                               
0805F944 F998     bl      lr+330h                                 
0805F946 0805     lsr     r5,r0,20h                               
0805F948 FCC4     bl      lr+988h                                 
0805F94A 0805     lsr     r5,r0,20h                               
0805F94C FCD4     bl      lr+9A8h                                 
0805F94E 0805     lsr     r5,r0,20h                               
0805F950 FCEC     bl      lr+9D8h                                 
0805F952 0805     lsr     r5,r0,20h                               
0805F954 FD14     bl      lr+0A28h                                
0805F956 0805     lsr     r5,r0,20h                               
0805F958 FD24     bl      lr+0A48h                                
0805F95A 0805     lsr     r5,r0,20h                               
0805F95C 8810     ldrh    r0,[r2]                                 
0805F95E 2800     cmp     r0,0h                                   
0805F960 D100     bne     805F964h                                
0805F962 E1EC     b       805FD3Eh                                
0805F964 2501     mov     r5,1h                                   
0805F966 2001     mov     r0,1h                                   
0805F968 2104     mov     r1,4h                                   
0805F96A F000FF87 bl      806087Ch                                
0805F96E E1E6     b       805FD3Eh                                
0805F970 2010     mov     r0,10h                                  
0805F972 2100     mov     r1,0h                                   
0805F974 2207     mov     r2,7h                                   
0805F976 2301     mov     r3,1h                                   
0805F978 E1A8     b       805FCCCh                                
0805F97A 4803     ldr     r0,=3000088h                            
0805F97C 8880     ldrh    r0,[r0,4h]                              
0805F97E 2810     cmp     r0,10h                                  
0805F980 D000     beq     805F984h                                
0805F982 E1DC     b       805FD3Eh                                
0805F984 2501     mov     r5,1h                                   
0805F986 E1DA     b       805FD3Eh                                
0805F988 0088     lsl     r0,r1,2h                                
0805F98A 0300     lsl     r0,r0,0Ch                               
0805F98C 8810     ldrh    r0,[r2]                                 
0805F98E 2802     cmp     r0,2h                                   
0805F990 D800     bhi     805F994h                                
0805F992 E1D4     b       805FD3Eh                                
0805F994 2501     mov     r5,1h                                   
0805F996 E1D2     b       805FD3Eh                                
0805F998 8810     ldrh    r0,[r2]                                 
0805F99A 2866     cmp     r0,66h                                  
0805F99C D800     bhi     805F9A0h                                
0805F99E E1CE     b       805FD3Eh                                
0805F9A0 2501     mov     r5,1h                                   
0805F9A2 E1CC     b       805FD3Eh                                
0805F9A4 4D2E     ldr     r5,=8369E20h                            
0805F9A6 4A2F     ldr     r2,=600B940h                            
0805F9A8 26A0     mov     r6,0A0h                                 
0805F9AA 0076     lsl     r6,r6,1h                                
0805F9AC 2410     mov     r4,10h                                  
0805F9AE 9400     str     r4,[sp]                                 
0805F9B0 2003     mov     r0,3h                                   
0805F9B2 1C29     mov     r1,r5                                   
0805F9B4 1C33     mov     r3,r6                                   
0805F9B6 F7A3FC15 bl      80031E4h                                
0805F9BA 492B     ldr     r1,=202B000h                            
0805F9BC 4A2B     ldr     r2,=6000294h                            
0805F9BE 9400     str     r4,[sp]                                 
0805F9C0 2003     mov     r0,3h                                   
0805F9C2 2314     mov     r3,14h                                  
0805F9C4 F7A3FC0E bl      80031E4h                                
0805F9C8 2080     mov     r0,80h                                  
0805F9CA 00C0     lsl     r0,r0,3h                                
0805F9CC 1829     add     r1,r5,r0                                
0805F9CE 4A28     ldr     r2,=600BD40h                            
0805F9D0 9400     str     r4,[sp]                                 
0805F9D2 2003     mov     r0,3h                                   
0805F9D4 1C33     mov     r3,r6                                   
0805F9D6 F7A3FC05 bl      80031E4h                                
0805F9DA 4926     ldr     r1,=202B040h                            
0805F9DC 4A26     ldr     r2,=60002D4h                            
0805F9DE 9400     str     r4,[sp]                                 
0805F9E0 2003     mov     r0,3h                                   
0805F9E2 2314     mov     r3,14h                                  
0805F9E4 F7A3FBFE bl      80031E4h                                
0805F9E8 2080     mov     r0,80h                                  
0805F9EA 0100     lsl     r0,r0,4h                                
0805F9EC 1829     add     r1,r5,r0                                
0805F9EE 4A23     ldr     r2,=600C140h                            
0805F9F0 9400     str     r4,[sp]                                 
0805F9F2 2003     mov     r0,3h                                   
0805F9F4 1C33     mov     r3,r6                                   
0805F9F6 F7A3FBF5 bl      80031E4h                                
0805F9FA 4921     ldr     r1,=202B080h                            
0805F9FC 4A21     ldr     r2,=6000314h                            
0805F9FE 9400     str     r4,[sp]                                 
0805FA00 2003     mov     r0,3h                                   
0805FA02 2314     mov     r3,14h                                  
0805FA04 F7A3FBEE bl      80031E4h                                
0805FA08 20C0     mov     r0,0C0h                                 
0805FA0A 0100     lsl     r0,r0,4h                                
0805FA0C 1829     add     r1,r5,r0                                
0805FA0E 4A1E     ldr     r2,=600C540h                            
0805FA10 9400     str     r4,[sp]                                 
0805FA12 2003     mov     r0,3h                                   
0805FA14 1C33     mov     r3,r6                                   
0805FA16 F7A3FBE5 bl      80031E4h                                
0805FA1A 491C     ldr     r1,=202B0C0h                            
0805FA1C 4A1C     ldr     r2,=6000354h                            
0805FA1E 9400     str     r4,[sp]                                 
0805FA20 2003     mov     r0,3h                                   
0805FA22 2314     mov     r3,14h                                  
0805FA24 F7A3FBDE bl      80031E4h                                
0805FA28 2080     mov     r0,80h                                  
0805FA2A 0140     lsl     r0,r0,5h                                
0805FA2C 1829     add     r1,r5,r0                                
0805FA2E 4A19     ldr     r2,=600C940h                            
0805FA30 9400     str     r4,[sp]                                 
0805FA32 2003     mov     r0,3h                                   
0805FA34 1C33     mov     r3,r6                                   
0805FA36 F7A3FBD5 bl      80031E4h                                
0805FA3A 4917     ldr     r1,=202B100h                            
0805FA3C 4A17     ldr     r2,=6000394h                            
0805FA3E 9400     str     r4,[sp]                                 
0805FA40 2003     mov     r0,3h                                   
0805FA42 2314     mov     r3,14h                                  
0805FA44 F7A3FBCE bl      80031E4h                                
0805FA48 20A0     mov     r0,0A0h                                 
0805FA4A 0140     lsl     r0,r0,5h                                
0805FA4C 182D     add     r5,r5,r0                                
0805FA4E 4A14     ldr     r2,=600CD40h                            
0805FA50 9400     str     r4,[sp]                                 
0805FA52 2003     mov     r0,3h                                   
0805FA54 1C29     mov     r1,r5                                   
0805FA56 1C33     mov     r3,r6                                   
0805FA58 F7A3FBC4 bl      80031E4h                                
0805FA5C 4911     ldr     r1,=202B140h                            
0805FA5E E102     b       805FC66h                                
0805FA60 9E20     ldr     r6,[sp,80h]                             
0805FA62 0836     lsr     r6,r6,20h                               
0805FA64 B940     ????                                            
0805FA66 0600     lsl     r0,r0,18h                               
0805FA68 B000     add     sp,0h                                   
0805FA6A 0202     lsl     r2,r0,8h                                
0805FA6C 0294     lsl     r4,r2,0Ah                               
0805FA6E 0600     lsl     r0,r0,18h                               
0805FA70 BD40     pop     r6,r15                                  
0805FA72 0600     lsl     r0,r0,18h                               
0805FA74 B040     add     sp,100h                                 
0805FA76 0202     lsl     r2,r0,8h                                
0805FA78 02D4     lsl     r4,r2,0Bh                               
0805FA7A 0600     lsl     r0,r0,18h                               
0805FA7C C140     stmia   [r1]!,r6                                
0805FA7E 0600     lsl     r0,r0,18h                               
0805FA80 B080     add     sp,-0h                                  
0805FA82 0202     lsl     r2,r0,8h                                
0805FA84 0314     lsl     r4,r2,0Ch                               
0805FA86 0600     lsl     r0,r0,18h                               
0805FA88 C540     stmia   [r5]!,r6                                
0805FA8A 0600     lsl     r0,r0,18h                               
0805FA8C B0C0     add     sp,-100h                                
0805FA8E 0202     lsl     r2,r0,8h                                
0805FA90 0354     lsl     r4,r2,0Dh                               
0805FA92 0600     lsl     r0,r0,18h                               
0805FA94 C940     ldmia   [r1]!,r6                                
0805FA96 0600     lsl     r0,r0,18h                               
0805FA98 B100     ????                                            
0805FA9A 0202     lsl     r2,r0,8h                                
0805FA9C 0394     lsl     r4,r2,0Eh                               
0805FA9E 0600     lsl     r0,r0,18h                               
0805FAA0 CD40     ldmia   [r5]!,r6                                
0805FAA2 0600     lsl     r0,r0,18h                               
0805FAA4 B140     ????                                            
0805FAA6 0202     lsl     r2,r0,8h                                
0805FAA8 4D30     ldr     r5,=8369F60h                            
0805FAAA 4A31     ldr     r2,=600B940h                            
0805FAAC 26A0     mov     r6,0A0h                                 
0805FAAE 0076     lsl     r6,r6,1h                                
0805FAB0 2410     mov     r4,10h                                  
0805FAB2 9400     str     r4,[sp]                                 
0805FAB4 2003     mov     r0,3h                                   
0805FAB6 1C29     mov     r1,r5                                   
0805FAB8 1C33     mov     r3,r6                                   
0805FABA F7A3FB93 bl      80031E4h                                
0805FABE 482D     ldr     r0,=202B014h                            
0805FAC0 4680     mov     r8,r0                                   
0805FAC2 482D     ldr     r0,=6000294h                            
0805FAC4 4681     mov     r9,r0                                   
0805FAC6 9400     str     r4,[sp]                                 
0805FAC8 2003     mov     r0,3h                                   
0805FACA 4641     mov     r1,r8                                   
0805FACC 464A     mov     r2,r9                                   
0805FACE 2314     mov     r3,14h                                  
0805FAD0 F7A3FB88 bl      80031E4h                                
0805FAD4 2080     mov     r0,80h                                  
0805FAD6 00C0     lsl     r0,r0,3h                                
0805FAD8 1829     add     r1,r5,r0                                
0805FADA 4A28     ldr     r2,=600BD40h                            
0805FADC 9400     str     r4,[sp]                                 
0805FADE 2003     mov     r0,3h                                   
0805FAE0 1C33     mov     r3,r6                                   
0805FAE2 F7A3FB7F bl      80031E4h                                
0805FAE6 9400     str     r4,[sp]                                 
0805FAE8 2003     mov     r0,3h                                   
0805FAEA 4641     mov     r1,r8                                   
0805FAEC 464A     mov     r2,r9                                   
0805FAEE 2314     mov     r3,14h                                  
0805FAF0 F7A3FB78 bl      80031E4h                                
0805FAF4 2080     mov     r0,80h                                  
0805FAF6 0100     lsl     r0,r0,4h                                
0805FAF8 1829     add     r1,r5,r0                                
0805FAFA 4A21     ldr     r2,=600C140h                            
0805FAFC 9400     str     r4,[sp]                                 
0805FAFE 2003     mov     r0,3h                                   
0805FB00 1C33     mov     r3,r6                                   
0805FB02 F7A3FB6F bl      80031E4h                                
0805FB06 491F     ldr     r1,=202B094h                            
0805FB08 4A1F     ldr     r2,=6000314h                            
0805FB0A 9400     str     r4,[sp]                                 
0805FB0C 2003     mov     r0,3h                                   
0805FB0E 2314     mov     r3,14h                                  
0805FB10 F7A3FB68 bl      80031E4h                                
0805FB14 20C0     mov     r0,0C0h                                 
0805FB16 0100     lsl     r0,r0,4h                                
0805FB18 1829     add     r1,r5,r0                                
0805FB1A 4A1C     ldr     r2,=600C540h                            
0805FB1C 9400     str     r4,[sp]                                 
0805FB1E 2003     mov     r0,3h                                   
0805FB20 1C33     mov     r3,r6                                   
0805FB22 F7A3FB5F bl      80031E4h                                
0805FB26 491A     ldr     r1,=202B0D4h                            
0805FB28 4A1A     ldr     r2,=6000354h                            
0805FB2A 9400     str     r4,[sp]                                 
0805FB2C 2003     mov     r0,3h                                   
0805FB2E 2314     mov     r3,14h                                  
0805FB30 F7A3FB58 bl      80031E4h                                
0805FB34 2080     mov     r0,80h                                  
0805FB36 0140     lsl     r0,r0,5h                                
0805FB38 1829     add     r1,r5,r0                                
0805FB3A 4A17     ldr     r2,=600C940h                            
0805FB3C 9400     str     r4,[sp]                                 
0805FB3E 2003     mov     r0,3h                                   
0805FB40 1C33     mov     r3,r6                                   
0805FB42 F7A3FB4F bl      80031E4h                                

