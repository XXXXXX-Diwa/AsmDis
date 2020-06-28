
;调用例程  好像只调用一次,有必要跳转吗>_<
08012780 4B08     ldr     r3,=3000738h                            
08012782 2200     mov     r2,0h                                   
08012784 4908     ldr     r1,=0FFFCh                              
08012786 8159     strh    r1,[r3,0Ah]    ;上部分界写入FFFCh                         
08012788 2004     mov     r0,4h                                   
0801278A 8198     strh    r0,[r3,0Ch]    ;下部分界写入4                         
0801278C 81D9     strh    r1,[r3,0Eh]    ;左部分界写入FFFCh                         
0801278E 8218     strh    r0,[r3,10h]    ;右部分界写入4                         
08012790 1C18     mov     r0,r3                                   
08012792 3025     add     r0,25h                                  
08012794 7002     strb    r2,[r0]        ;属性写入0                         
08012796 1C19     mov     r1,r3                                   
08012798 3122     add     r1,22h                                  
0801279A 2001     mov     r0,1h                                   
0801279C 7008     strb    r0,[r1]        ;75A写入1                         
0801279E 771A     strb    r2,[r3,1Ch]    ;动画帧写入0                         
080127A0 4770     bx      r14                                     


;00--11--09--1F--0E--0F--11
;主程序
080127AC B570     push    r4-r6,r14                               
080127AE 4908     ldr     r1,=3000738h                            
080127B0 1C0A     mov     r2,r1                                   
080127B2 3226     add     r2,26h                                  
080127B4 2001     mov     r0,1h                                   
080127B6 7010     strb    r0,[r2]    ;75e写入1                             
080127B8 1C08     mov     r0,r1                                   
080127BA 3024     add     r0,24h                                  
080127BC 7800     ldrb    r0,[r0]    ;读取pose                             
080127BE 1C0C     mov     r4,r1                                   
080127C0 281F     cmp     r0,1Fh                                  
080127C2 D900     bls     @@Pass                                
080127C4 E133     b       @@end 

@@Pass:                               
080127C6 0080     lsl     r0,r0,2h                                
080127C8 4902     ldr     r1,=80127D8h  ;PoseTable                          
080127CA 1840     add     r0,r0,r1                                
080127CC 6800     ldr     r0,[r0]                                 
080127CE 4687     mov     r15,r0                                  

PoseTable:
    .word 0x8012858    ;00
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e  
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e     
	.word 0x80128ac    ;09
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e       
	.word 0x8012970    ;0eh
	.word 0x8012984    ;0fh
	.word 0x8012a2e    
	.word 0x80129c8    ;11
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e 
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e   
	.word 0x8012a2e .word 0x8012a2e .word 0x8012a2e .word 0x8012a2e     
	.word 0x8012a2e     
	.word 0x80128e0    ;1Fh  
	
;pose 0	
08012858 F7FFFF92 bl      8012780h                                 
0801285C 4810     ldr     r0,=3000738h                            
0801285E 4684     mov     r12,r0                                  
08012860 8842     ldrh    r2,[r0,2h]     ;读取Y坐标                         
08012862 3A40     sub     r2,40h         ;向上提升一格                         
08012864 2300     mov     r3,0h                                   
08012866 8042     strh    r2,[r0,2h]     ;再写入                         
08012868 3027     add     r0,27h                                  
0801286A 2108     mov     r1,8h                                   
0801286C 7001     strb    r1,[r0]        ;75F写入8h                         
0801286E 4660     mov     r0,r12                                  
08012870 3028     add     r0,28h                                  
08012872 7001     strb    r1,[r0]        ;760写入8h                         
08012874 3001     add     r0,1h                                   
08012876 7001     strb    r1,[r0]        ;761写入8h                         
08012878 4661     mov     r1,r12                                  
0801287A 82CB     strh    r3,[r1,16h]    ;动画写入0                         
0801287C 4809     ldr     r0,=833BC54h                            
0801287E 6188     str     r0,[r1,18h]    ;写入OAM                         
08012880 80CA     strh    r2,[r1,6h]     ;Y坐标写入再生Y坐标                      
08012882 8888     ldrh    r0,[r1,4h]     ;X坐标写入再生X坐标                         
08012884 8108     strh    r0,[r1,8h]                              
08012886 8809     ldrh    r1,[r1]                                 
08012888 2004     mov     r0,4h                                   
0801288A 4308     orr     r0,r1          ;取向Orr4                         
0801288C 4666     mov     r6,r12                                  
0801288E 8030     strh    r0,[r6]        ;再写入                         
08012890 4661     mov     r1,r12                                  
08012892 3124     add     r1,24h                                  
08012894 2011     mov     r0,11h                                  
08012896 7008     strb    r0,[r1]        ;pose写入11h                          
08012898 4803     ldr     r0,=300083Ch                            
0801289A 7800     ldrb    r0,[r0]        ;读取随机数                         
0801289C 00C0     lsl     r0,r0,3h       ;8倍                         
0801289E E089     b       @@Peer                                

;Pose 9                               
080128AC F7FDF98C bl      800FBC8h                                
080128B0 2800     cmp     r0,0h                                   
080128B2 D100     bne     @@Pass         ;动画结束                       
080128B4 E0BB     b       @@end 

@@Pass:                               
080128B6 4A08     ldr     r2,=3000738h                            
080128B8 4808     ldr     r0,=833BC94h                            
080128BA 6190     str     r0,[r2,18h]    ;写入新OAM  下落过程中                        
080128BC 2100     mov     r1,0h                                   
080128BE 2000     mov     r0,0h                                   
080128C0 82D0     strh    r0,[r2,16h]    ;动画和帧归零                         
080128C2 7711     strb    r1,[r2,1Ch]                             
080128C4 1C10     mov     r0,r2                                   
080128C6 302D     add     r0,2Dh                                  
080128C8 7001     strb    r1,[r0]        ;765写入0                          
080128CA 3002     add     r0,2h                                   
080128CC 7001     strb    r1,[r0]        ;767写入0                          
080128CE 1C11     mov     r1,r2                                   
080128D0 3124     add     r1,24h                                  
080128D2 201F     mov     r0,1Fh         ;pose写入1Fh                         
080128D4 7008     strb    r0,[r1]                                 
080128D6 E0AA     b       @@end                                
080128D8 0738     lsl     r0,r7,1Ch                               
080128DA 0300     lsl     r0,r0,0Ch                               
080128DC BC94     pop     r2,r4,r7                                
080128DE 0833     lsr     r3,r6,20h 

;pose 1F                              
080128E0 8860     ldrh    r0,[r4,2h]     ;读取Y坐标                         
080128E2 88A1     ldrh    r1,[r4,4h]     ;读取X坐标                         
080128E4 F7FCFDCA bl      800F47Ch       ;检查是否是否碰到地面                         
080128E8 1C02     mov     r2,r0                                   
080128EA 4806     ldr     r0,=30000DCh                            
080128EC 8841     ldrh    r1,[r0,2h]     ;检查人物是否在水中                         
080128EE 2901     cmp     r1,1h          ;难道敌人也计算这个值?                         
080128F0 D114     bne     @@NoInWater                                
080128F2 4805     ldr     r0,=300006Ch   ;读取空气高度                        
080128F4 8800     ldrh    r0,[r0]                                  
080128F6 2800     cmp     r0,0h          ;如果空气高度为0                          
080128F8 D008     beq     @@AllWater                                
080128FA 8060     strh    r0,[r4,2h]     ;直接写入Y坐标                          
080128FC 1C20     mov     r0,r4                                   
080128FE 302D     add     r0,2Dh                                  
08012900 7001     strb    r1,[r0]        ;765写入1                         
08012902 E004     b       @@Peer                               

@@AllWater                               
0801290C 8062     strh    r2,[r4,2h]     ;直接写入Y坐标

@@Peer                             
0801290E 4802     ldr     r0,=3000738h                            
08012910 3024     add     r0,24h         ;pose写入E                          
08012912 210E     mov     r1,0Eh                                  
08012914 7001     strb    r1,[r0]                                  
08012916 E08A     b       @@end                                

@@NoInWater:                              
0801291C 4804     ldr     r0,=30007F0h                            
0801291E 7800     ldrb    r0,[r0]        ;读取7F0                          
08012920 2800     cmp     r0,0h                                   
08012922 D007     beq     @@Nofloor                                 
08012924 8062     strh    r2,[r4,2h]     ;有地面则把地面高度直接写入Y坐标                         
08012926 1C21     mov     r1,r4                                   
08012928 3124     add     r1,24h                                  
0801292A 200E     mov     r0,0Eh         ;pose写入E                         
0801292C 7008     strb    r0,[r1]                                 
0801292E E07E     b       @@end                               

@@Nofloor:                              
08012934 1C25     mov     r5,r4                                   
08012936 352F     add     r5,2Fh                                  
08012938 7829     ldrb    r1,[r5]        ;读取767                          
0801293A 4B08     ldr     r3,=82B0D04h                            
0801293C 0048     lsl     r0,r1,1h       ;乘以2                         
0801293E 18C0     add     r0,r0,r3       ;加上偏移值                         
08012940 2600     mov     r6,0h                                   
08012942 5F82     ldsh    r2,[r0,r6]     ;读取下落速度值                         
08012944 4806     ldr     r0,=7FFFh                               
08012946 4282     cmp     r2,r0          ;比较是否是7FFF                          
08012948 D10C     bne     @@DropSpeedNo7FFF                                
0801294A 1E48     sub     r0,r1,1        ;767减1                         
0801294C 0040     lsl     r0,r0,1h       ;再乘以2                         
0801294E 18C0     add     r0,r0,r3       ;加上偏移值                         
08012950 2100     mov     r1,0h                                   
08012952 5E40     ldsh    r0,[r0,r1]     ;读取下落速度值                         
08012954 8866     ldrh    r6,[r4,2h]     ;读取Y坐标                         
08012956 1980     add     r0,r0,r6       ;加上下落速度值                         
08012958 8060     strh    r0,[r4,2h]     ;再写入Y坐标                         
0801295A E068     b       @@end                                  

@@DropSpeedNo7FFF:                            
08012964 1C48     add     r0,r1,1        ;767加1                         
08012966 7028     strb    r0,[r5]        ;再写入                         
08012968 8860     ldrh    r0,[r4,2h]     ;读取Y坐标                         
0801296A 1880     add     r0,r0,r2       ;加上下落速度                         
0801296C 8060     strh    r0,[r4,2h]     ;再写入                         
0801296E E05E     b       @@end  

;Pose E                              
08012970 4812     ldr     r0,=833BCA4h   ;落地或水                         
08012972 61A0     str     r0,[r4,18h]    ;写入OAM                         
08012974 2100     mov     r1,0h                                   
08012976 2000     mov     r0,0h                                   
08012978 82E0     strh    r0,[r4,16h]    ;归零                         
0801297A 7721     strb    r1,[r4,1Ch]                             
0801297C 1C21     mov     r1,r4                                   
0801297E 3124     add     r1,24h                                  
08012980 200F     mov     r0,0Fh         ;pose写入F                         
08012982 7008     strb    r0,[r1]                                 
08012984 1C20     mov     r0,r4                                   
08012986 302D     add     r0,2Dh                                  
08012988 7800     ldrb    r0,[r0]        ;读取765h                          
0801298A 2800     cmp     r0,0h                                   
0801298C D002     beq     @@765=0                                
0801298E 480C     ldr     r0,=300006Ch   ;读取空气最高低度                         
08012990 8800     ldrh    r0,[r0]                                 
08012992 8060     strh    r0,[r4,2h]     ;写入Y坐标

@@765=0:                             
08012994 F7FDF918 bl      800FBC8h                                
08012998 2800     cmp     r0,0h          ;检查动画结束                          
0801299A D048     beq     @@end                                
0801299C 8821     ldrh    r1,[r4]                                 
0801299E 2004     mov     r0,4h                                   
080129A0 4308     orr     r0,r1          ;取向Orr4再写入 颜色消失                         
080129A2 8020     strh    r0,[r4]                                 
080129A4 1C21     mov     r1,r4                                   
080129A6 3124     add     r1,24h                                  
080129A8 2011     mov     r0,11h         ;pose写入11h                         
080129AA 7008     strb    r0,[r1]                                 
080129AC 4805     ldr     r0,=300083Ch                            
080129AE 7800     ldrb    r0,[r0]                                 
080129B0 00C0     lsl     r0,r0,3h       ;随机值乘以8再加64                         
080129B2 3064     add     r0,64h 

@@Peer:                                 
080129B4 3108     add     r1,8h                                   
080129B6 7008     strb    r0,[r1]        ;764写入随机数的八倍 以及可能加64                            
080129B8 E039     b       @@end                                

;pose 11                              
080129C8 1C22     mov     r2,r4                                   
080129CA 1C11     mov     r1,r2                                   
080129CC 312C     add     r1,2Ch      ;读取764的值                            
080129CE 7808     ldrb    r0,[r1]                                 
080129D0 3801     sub     r0,1h                                   
080129D2 7008     strb    r0,[r1]     ;减1再写入                            
080129D4 0600     lsl     r0,r0,18h                               
080129D6 0E01     lsr     r1,r0,18h                               
080129D8 2900     cmp     r1,0h       ;比较是否是0                            
080129DA D128     bne     @@end       ;不为0则结束                                
080129DC 480E     ldr     r0,=833BC54h                            
080129DE 6190     str     r0,[r2,18h] ;写入新OAM    将落未落时刻                        
080129E0 2000     mov     r0,0h                                   
080129E2 82D1     strh    r1,[r2,16h] ;动画和帧归零                            
080129E4 7710     strb    r0,[r2,1Ch]                             
080129E6 1C11     mov     r1,r2                                   
080129E8 3124     add     r1,24h                                  
080129EA 2009     mov     r0,9h                                   
080129EC 7008     strb    r0,[r1]     ;pose写入9                             
080129EE 8811     ldrh    r1,[r2]                                 
080129F0 480A     ldr     r0,=0FFFBh                              
080129F2 4008     and     r0,r1       ;取向AND FFFB去掉4                            
080129F4 8010     strh    r0,[r2]                                 
080129F6 88D0     ldrh    r0,[r2,6h]  ;读取再生Y坐标                            
080129F8 8050     strh    r0,[r2,2h]  ;写入Y坐标                            
080129FA 8913     ldrh    r3,[r2,8h]  ;读取再生X坐标                            
080129FC 8093     strh    r3,[r2,4h]  ;写入X坐标                            
080129FE 4D08     ldr     r5,=300083Ch                            
08012A00 7829     ldrb    r1,[r5]     ;读取随机数                            
08012A02 2001     mov     r0,1h                                   
08012A04 4008     and     r0,r1       ;1 and                            
08012A06 2800     cmp     r0,0h       ;是否是奇数                            
08012A08 D00C     beq     @@NoOneNum                                
08012A0A 7828     ldrb    r0,[r5]     ;读取随机数                            
08012A0C 3001     add     r0,1h       ;加一                            
08012A0E 1040     asr     r0,r0,1h    ;算术右移                            
08012A10 1818     add     r0,r3,r0    ;加上X坐标                            
08012A12 8090     strh    r0,[r2,4h]  ;写入X坐标                            
08012A14 E00B     b       @@end                                

@@NoOneNum:                              
08012A24 7828     ldrb    r0,[r5]     ;读取随机数                            
08012A26 3001     add     r0,1h       ;加1                            
08012A28 1040     asr     r0,r0,1h    ;算术右移                            
08012A2A 1A18     sub     r0,r3,r0    ;减去X坐标                            
08012A2C 80A0     strh    r0,[r4,4h]  ;再写入

@@end:                             
08012A2E BC70     pop     r4-r6                                   
08012A30 BC01     pop     r0                                      
08012A32 4700     bx      r0  


