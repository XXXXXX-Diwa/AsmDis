
;Pose 0
08012D14 B500     push    r14                                     
08012D16 481B     ldr     r0,=3000738h                            
08012D18 4684     mov     r12,r0                                  
08012D1A 4661     mov     r1,r12                                  
08012D1C 3126     add     r1,26h                                  
08012D1E 2300     mov     r3,0h                                   
08012D20 2014     mov     r0,14h                                  
08012D22 7008     strb    r0,[r1]       ;75E写入14h                               
08012D24 4662     mov     r2,r12                                  
08012D26 8811     ldrh    r1,[r2]       ;读取取向                          
08012D28 2280     mov     r2,80h                                  
08012D2A 0212     lsl     r2,r2,8h                                
08012D2C 1C10     mov     r0,r2                                   
08012D2E 2200     mov     r2,0h                                   
08012D30 4308     orr     r0,r1         ;orr8000h无敌再写入                           
08012D32 4661     mov     r1,r12                                  
08012D34 8008     strh    r0,[r1]                                 
08012D36 3124     add     r1,24h                                  
08012D38 2009     mov     r0,9h                                   
08012D3A 7008     strb    r0,[r1]       ;pose写入9h                            
08012D3C 20C8     mov     r0,0C8h                                 
08012D3E 4661     mov     r1,r12                                  
08012D40 80C8     strh    r0,[r1,6h]    ;再生Y坐标写入C8h                          
08012D42 810B     strh    r3,[r1,8h]    ;再生X坐标写入0h                          
08012D44 770A     strb    r2,[r1,1Ch]   ;动画和动画帧归零                          
08012D46 82CB     strh    r3,[r1,16h]                             
08012D48 4660     mov     r0,r12                                  
08012D4A 3027     add     r0,27h                                  
08012D4C 2108     mov     r1,8h                                   
08012D4E 7001     strb    r1,[r0]       ;75F写入8h                            
08012D50 3001     add     r0,1h                                   
08012D52 7001     strb    r1,[r0]       ;760写入8h                          
08012D54 3001     add     r0,1h                                   
08012D56 7001     strb    r1,[r0]       ;761写入8h                          
08012D58 480B     ldr     r0,=3000088h                            
08012D5A 7B01     ldrb    r1,[r0,0Ch]                             
08012D5C 2003     mov     r0,3h                                   
08012D5E 4008     and     r0,r1         ;3 and 3000094的值                          
08012D60 4661     mov     r1,r12                                  
08012D62 3121     add     r1,21h                                  
08012D64 7008     strb    r0,[r1]       ;写入759h                          
08012D66 3101     add     r1,1h                                   
08012D68 2001     mov     r0,1h                                   
08012D6A 7008     strb    r0,[r1]       ;75A写入1h                          
08012D6C 4662     mov     r2,r12                                  
08012D6E 7F50     ldrb    r0,[r2,1Dh]   ;读取ID                          
08012D70 381A     sub     r0,1Ah                                  
08012D72 281B     cmp     r0,1Bh                                  
08012D74 D900     bls     @@IDLessThan36                                
08012D76 E079     b       @@IDMoreThan35  

@@IDLessThan36:                              
08012D78 0080     lsl     r0,r0,2h                                
08012D7A 4904     ldr     r1,=8012D90h ;IDTable                         
08012D7C 1840     add     r0,r0,r1                                
08012D7E 6800     ldr     r0,[r0]                                 
08012D80 4687     mov     r15,r0                                  
    .word 8012e30h  ;00
	.word 8012e6ch  
	.word 8012e20h  ;02
	.word 8012e10h  ;03
	.word 8012e00h  ;04
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch .word 8012e6ch .word 8012e6ch
	.word 8012e6ch .word 8012e6ch
	.word 8012e40h  ;1B
;ID                             
08012E00 4802     ldr     r0,=82B27A8h     ;超炸OAM                        
08012E02 6190     str     r0,[r2,18h]                             
08012E04 1C11     mov     r1,r2                                   
08012E06 3125     add     r1,25h                                  
08012E08 2023     mov     r0,23h                                  
08012E0A E034     b       @@Peer                                

                               
08012E10 4802     ldr     r0,=82B2790h     ;超导OAM                          
08012E12 6190     str     r0,[r2,18h]                             
08012E14 1C11     mov     r1,r2                                   
08012E16 3125     add     r1,25h                                  
08012E18 2022     mov     r0,22h                                  
08012E1A E02C     b       @@Peer                                

                             
08012E20 4802     ldr     r0,=82B2778h     ;导弹的OAM                   
08012E22 6190     str     r0,[r2,18h]                             
08012E24 1C11     mov     r1,r2                                   
08012E26 3125     add     r1,25h                                  
08012E28 2021     mov     r0,21h                                  
08012E2A E024     b       @@Peer                                

                              
08012E30 4802     ldr     r0,=82B2750h     ;大血的OAM                         
08012E32 6190     str     r0,[r2,18h]                             
08012E34 1C11     mov     r1,r2                                   
08012E36 3125     add     r1,25h                                  
08012E38 2020     mov     r0,20h                                  
08012E3A E01C     b       @@Peer                                

                             
08012E40 7F90     ldrb    r0,[r2,1Eh]                             
08012E42 2801     cmp     r0,1h                                   
08012E44 D104     bne     @@DataNo1          ;读取副精灵data                      
08012E46 4801     ldr     r0,=82B27C0h       ;三片大血OAM                     
08012E48 E009     b       @@Write                                

@@DataNo1:                              
08012E50 2802     cmp     r0,2h                                   
08012E52 D103     bne     @@DataNo2                                
08012E54 4800     ldr     r0,=82B2810h       ;其他一种排列方式的打血                       
08012E56 E002     b       @@Write                                

@@DataNo2:                              
08012E5C 4802     ldr     r0,=82B27E8h       ;另一种排列方式的大血

@@Write:                           
08012E5E 6190     str     r0,[r2,18h]                             
08012E60 1C11     mov     r1,r2                                   
08012E62 3125     add     r1,25h                                  
08012E64 2024     mov     r0,24h                                  
08012E66 E006     b       @@Peer                                

@@IDMoreThan35:                             
08012E6C 4807     ldr     r0,=82B2728h      ;小血OAM                      
08012E6E 6190     str     r0,[r2,18h]       ;OAM写入8282728h                       
08012E70 1C11     mov     r1,r2                                   
08012E72 3125     add     r1,25h                                  
08012E74 201F     mov     r0,1Fh   

@@Peer:                               
08012E76 7008     strb    r0,[r1]           ;属性写入1F                      
08012E78 4805     ldr     r0,=0FFDCh                              
08012E7A 8150     strh    r0,[r2,0Ah]       ;上部分界写入NEG 24h                      
08012E7C 2024     mov     r0,24h                                  
08012E7E 8190     strh    r0,[r2,0Ch]       ;下部分界写入24h                      
08012E80 4804     ldr     r0,=0FFE0h                              
08012E82 81D0     strh    r0,[r2,0Eh]       ;左部分界写入NEG 20h                      
08012E84 2020     mov     r0,20h                                  
08012E86 8210     strh    r0,[r2,10h]       ;右部分界写入20h                      
08012E88 BC01     pop     r0                                      
08012E8A 4700     bx      r0                                      

;Pose 9                               
08012E98 B500     push    r14                                     
08012E9A 4A06     ldr     r2,=3000738h                            
08012E9C 1C10     mov     r0,r2                                   
08012E9E 3026     add     r0,26h                                  
08012EA0 7800     ldrb    r0,[r0]           ;读取75E                      
08012EA2 2800     cmp     r0,0h                                   
08012EA4 D00A     beq     @@75EZero                                
08012EA6 2801     cmp     r0,1h                                   
08012EA8 D900     bls     @@75EOne                                
08012EAA E09E     b       @@end 

@@75EOne:                               
08012EAC 8811     ldrh    r1,[r2]                                 
08012EAE 4802     ldr     r0,=0FFFBh                              
08012EB0 4008     and     r0,r1            ;取向去掉4h                       
08012EB2 E099     b       @@Write                                

@@75EZero:                               
08012EBC 8813     ldrh    r3,[r2]                                 
08012EBE 2080     mov     r0,80h                                  
08012EC0 0100     lsl     r0,r0,4h                                
08012EC2 4018     and     r0,r3           ;8000h and取向                         
08012EC4 2800     cmp     r0,0h                                   
08012EC6 D100     bne     @@Pass                                
08012EC8 E07E     b       @@Have8000 

@@Pass:                               
08012ECA 1C10     mov     r0,r2                                   
08012ECC 3025     add     r0,25h                                  
08012ECE 7800     ldrb    r0,[r0]         ;读取属性                            
08012ED0 381F     sub     r0,1Fh          ;减去1F                        
08012ED2 2805     cmp     r0,5h                                   
08012ED4 D86F     bhi     @@DataOver                                
08012ED6 0080     lsl     r0,r0,2h                                
08012ED8 4901     ldr     r1,=8012EE4h    ;DropTable                        
08012EDA 1840     add     r0,r0,r1                                
08012EDC 6800     ldr     r0,[r0]                                 
08012EDE 4687     mov     r15,r0                                  

DropTable:
    .word 8012efch    
	.word 8012f1ch    
	.word 8012f3ch
	.word 8012f5ch
	.word 8012f7ch
	.word 8012f9ch
	
        
;小血   	
08012EFC 4906     ldr     r1,=3001530h                            
08012EFE 88C8     ldrh    r0,[r1,6h]                              
08012F00 3005     add     r0,5h                                   
08012F02 80C8     strh    r0,[r1,6h]       ;加五点血                         
08012F04 880A     ldrh    r2,[r1]                                 
08012F06 0400     lsl     r0,r0,10h                               
08012F08 0C00     lsr     r0,r0,10h                               
08012F0A 4290     cmp     r0,r2            ;当前血和最高血量比较                       
08012F0C D900     bls     @@PlaySound         ;小于等于则跳过                       
08012F0E 80CA     strh    r2,[r1,6h]       ;否则直接写入最高血量 

@@PlaySound:                      
08012F10 2086     mov     r0,86h           ;吃小血音                           
08012F12 F7EFFD81 bl      8002A18h                                
08012F16 E04E     b       @@DataOver                                
08012F18 1530     asr     r0,r6,14h                               
08012F1A 0300     lsl     r0,r0,0Ch                               
08012F1C 4906     ldr     r1,=3001530h                            
08012F1E 88C8     ldrh    r0,[r1,6h]                              
08012F20 3014     add     r0,14h                                  
08012F22 80C8     strh    r0,[r1,6h]                              
08012F24 880A     ldrh    r2,[r1]                                 
08012F26 0400     lsl     r0,r0,10h                               
08012F28 0C00     lsr     r0,r0,10h                               
08012F2A 4290     cmp     r0,r2                                   
08012F2C D900     bls     8012F30h                                
08012F2E 80CA     strh    r2,[r1,6h]                              
08012F30 2087     mov     r0,87h                                  
08012F32 F7EFFD71 bl      8002A18h                                
08012F36 E03E     b       @@DataOver                                
08012F38 1530     asr     r0,r6,14h                               
08012F3A 0300     lsl     r0,r0,0Ch                               
08012F3C 4906     ldr     r1,=3001530h                            
08012F3E 8908     ldrh    r0,[r1,8h]                              
08012F40 3002     add     r0,2h                                   
08012F42 8108     strh    r0,[r1,8h]                              
08012F44 884A     ldrh    r2,[r1,2h]                              
08012F46 0400     lsl     r0,r0,10h                               
08012F48 0C00     lsr     r0,r0,10h                               
08012F4A 4290     cmp     r0,r2                                   
08012F4C D900     bls     8012F50h                                
08012F4E 810A     strh    r2,[r1,8h]                              
08012F50 2088     mov     r0,88h           ;吃导弹音                       
08012F52 F7EFFD61 bl      8002A18h                                
08012F56 E02E     b       @@DataOver                                
08012F58 1530     asr     r0,r6,14h                               
08012F5A 0300     lsl     r0,r0,0Ch                               
08012F5C 4906     ldr     r1,=3001530h                            
08012F5E 7A88     ldrb    r0,[r1,0Ah]                             
08012F60 3002     add     r0,2h                                   
08012F62 7288     strb    r0,[r1,0Ah]                             
08012F64 790A     ldrb    r2,[r1,4h]                              
08012F66 0600     lsl     r0,r0,18h                               
08012F68 0E00     lsr     r0,r0,18h                               
08012F6A 4290     cmp     r0,r2                                   
08012F6C D900     bls     8012F70h                                
08012F6E 728A     strb    r2,[r1,0Ah]                             
08012F70 2089     mov     r0,89h           ;吃超导音                       
08012F72 F7EFFD51 bl      8002A18h                                
08012F76 E01E     b       @@DataOver                                
08012F78 1530     asr     r0,r6,14h                               
08012F7A 0300     lsl     r0,r0,0Ch                               
08012F7C 4906     ldr     r1,=3001530h                            
08012F7E 7AC8     ldrb    r0,[r1,0Bh]                             
08012F80 3001     add     r0,1h                                   
08012F82 72C8     strb    r0,[r1,0Bh]                             
08012F84 794A     ldrb    r2,[r1,5h]                              
08012F86 0600     lsl     r0,r0,18h                               
08012F88 0E00     lsr     r0,r0,18h                               
08012F8A 4290     cmp     r0,r2                                   
08012F8C D900     bls     8012F90h                                
08012F8E 72CA     strb    r2,[r1,0Bh]                             
08012F90 208A     mov     r0,8Ah          ;吃超炸音                          
08012F92 F7EFFD41 bl      8002A18h                                
08012F96 E00E     b       @@DataOver                                
08012F98 1530     asr     r0,r6,14h                               
08012F9A 0300     lsl     r0,r0,0Ch                               
08012F9C 4908     ldr     r1,=3001530h                            
08012F9E 88C8     ldrh    r0,[r1,6h]                              
08012FA0 303C     add     r0,3Ch                                  
08012FA2 80C8     strh    r0,[r1,6h]                              
08012FA4 880A     ldrh    r2,[r1]                                 
08012FA6 0400     lsl     r0,r0,10h                               
08012FA8 0C00     lsr     r0,r0,10h                               
08012FAA 4290     cmp     r0,r2                                   
08012FAC D900     bls     8012FB0h                                
08012FAE 80CA     strh    r2,[r1,6h]                              
08012FB0 2087     mov     r0,87h           ;吃血声                          
08012FB2 F7EFFD31 bl      8002A18h 

@@DataOver:                               
08012FB6 4903     ldr     r1,=3000738h                            
08012FB8 2000     mov     r0,0h            ;消灭精灵                       
08012FBA 8008     strh    r0,[r1]                                 
08012FBC E015     b       @@end                                

@@Have8000:                                ;意为未吃                   
08012FC8 7A10     ldrb    r0,[r2,8h]       ;读取再生X坐标                       
08012FCA 2101     mov     r1,1h                                   
08012FCC 4008     and     r0,r1            ;and 1                       
08012FCE 2800     cmp     r0,0h            ;如果是偶数则结束                        
08012FD0 D00B     beq     @@end                                
08012FD2 88D0     ldrh    r0,[r2,6h]       ;否则再生Y坐标减1再写入                       
08012FD4 3801     sub     r0,1h                                   
08012FD6 80D0     strh    r0,[r2,6h]                              
08012FD8 0600     lsl     r0,r0,18h                               
08012FDA 0E00     lsr     r0,r0,18h                               
08012FDC 2800     cmp     r0,0h            ;比较是否是0,达到0则写入消失                       
08012FDE D003     beq     @@Write                                
08012FE0 284F     cmp     r0,4Fh           ;比较是否大于4F                       
08012FE2 D802     bhi     @@end                                
08012FE4 2004     mov     r0,4h            ;小于4F则闪烁                       
08012FE6 4058     eor     r0,r3  

@@Write:                                 
08012FE8 8010     strh    r0,[r2]          

@@end:                                
08012FEA BC01     pop     r0                                      
08012FEC 4700     bx      r0                                      


;主程序                                
08012FF0 B500     push    r14                                     
08012FF2 4804     ldr     r0,=3000738h                            
08012FF4 3024     add     r0,24h                                  
08012FF6 7800     ldrb    r0,[r0]        ;读取pose                         
08012FF8 2800     cmp     r0,0h                                   
08012FFA D005     beq     @@PoseZero                                
08012FFC 2809     cmp     r0,9h                                   
08012FFE D006     beq     @@PoseNight                                
08013000 E007     b       @@end                                

@@PoseZero:                               
08013008 F7FFFE84 bl      8012D14h                                
0801300C E001     b       @@end 

@@PoseNight:                               
0801300E F7FFFF43 bl      8012E98h 

@@end:                               
08013012 4903     ldr     r1,=3000738h                            
08013014 8908     ldrh    r0,[r1,8h]     ;读取再生X坐标                         
08013016 3001     add     r0,1h                                   
08013018 8108     strh    r0,[r1,8h]     ;加1再写入                         
0801301A BC01     pop     r0                                      
0801301C 4700     bx      r0                                      
///////////////////////////////////////////////////////////////////////////////////////////////////
                              
                               
08013410 B530     push    r4,r5,r14                               
08013412 4B04     ldr     r3,=3000738h                            
08013414 1C1D     mov     r5,r3                                   
08013416 3524     add     r5,24h                                  
08013418 782C     ldrb    r4,[r5]                                 
0801341A 2C00     cmp     r4,0h                                   
0801341C D004     beq     8013428h                                
0801341E 2C09     cmp     r4,9h                                   
08013420 D026     beq     8013470h                                
08013422 E033     b       801348Ch                                
08013424 0738     lsl     r0,r7,1Ch                               
08013426 0300     lsl     r0,r0,0Ch                               
08013428 8819     ldrh    r1,[r3]                                 
0801342A 480F     ldr     r0,=0FFFBh                              
0801342C 4008     and     r0,r1                                   
0801342E 2200     mov     r2,0h                                   
08013430 8018     strh    r0,[r3]                                 
08013432 1C18     mov     r0,r3                                   
08013434 3027     add     r0,27h                                  
08013436 2110     mov     r1,10h                                  
08013438 7001     strb    r1,[r0]                                 
0801343A 3001     add     r0,1h                                   
0801343C 7001     strb    r1,[r0]                                 
0801343E 3001     add     r0,1h                                   
08013440 7001     strb    r1,[r0]                                 
08013442 815C     strh    r4,[r3,0Ah]                             
08013444 819C     strh    r4,[r3,0Ch]                             
08013446 81DC     strh    r4,[r3,0Eh]                             
08013448 821C     strh    r4,[r3,10h]                             
0801344A 4808     ldr     r0,=82B3134h                            
0801344C 6198     str     r0,[r3,18h]                             
0801344E 771A     strb    r2,[r3,1Ch]                             
08013450 82DC     strh    r4,[r3,16h]                             
08013452 1C18     mov     r0,r3                                   
08013454 3025     add     r0,25h                                  
08013456 7002     strb    r2,[r0]                                 
08013458 2009     mov     r0,9h                                   
0801345A 7028     strb    r0,[r5]                                 
0801345C 1C19     mov     r1,r3                                   
0801345E 3122     add     r1,22h                                  
08013460 2005     mov     r0,5h                                   
08013462 7008     strb    r0,[r1]                                 
08013464 E012     b       801348Ch                                
08013466 0000     lsl     r0,r0,0h                                
08013468 FFFB     bl      lr+0FF6h                                
0801346A 0000     lsl     r0,r0,0h                                
0801346C 3134     add     r1,34h                                  
0801346E 082B     lsr     r3,r5,20h                               
08013470 4A08     ldr     r2,=30001ACh                            
08013472 1C18     mov     r0,r3                                   
08013474 3023     add     r0,23h                                  
08013476 7801     ldrb    r1,[r0]                                 
08013478 00C8     lsl     r0,r1,3h                                
0801347A 1A40     sub     r0,r0,r1                                
0801347C 00C0     lsl     r0,r0,3h                                
0801347E 1880     add     r0,r0,r2                                
08013480 3024     add     r0,24h                                  
08013482 7800     ldrb    r0,[r0]                                 
08013484 2822     cmp     r0,22h                                  
08013486 D901     bls     801348Ch                                
08013488 2000     mov     r0,0h                                   
0801348A 8018     strh    r0,[r3]                                 
0801348C BC30     pop     r4,r5                                   
0801348E BC01     pop     r0                                      
08013490 4700     bx      r0                                      


;蓄力光束pose 0                              
08013498 B530     push    r4,r5,r14                               
0801349A 4806     ldr     r0,=3001530h                            
0801349C 7B01     ldrb    r1,[r0,0Ch]        ;读取153C的值                     
0801349E 2010     mov     r0,10h             ;10and                     
080134A0 4008     and     r0,r1                                   
080134A2 0600     lsl     r0,r0,18h                               
080134A4 0E04     lsr     r4,r0,18h                               
080134A6 2C00     cmp     r4,0h                                    
080134A8 D008     beq     @@NoGet                                
080134AA 4903     ldr     r1,=3000738h                            
080134AC 2000     mov     r0,0h             ;如果激活则让蓄力光束消失                      
080134AE 8008     strh    r0,[r1]                                 
080134B0 E039     b       8013526h                                

@@NoGet:                             
080134BC 481B     ldr     r0,=3000738h                            
080134BE 4684     mov     r12,r0                                  
080134C0 4662     mov     r2,r12                                  
080134C2 3232     add     r2,32h                                  
080134C4 7811     ldrb    r1,[r2]           ;读取碰撞属性                       
080134C6 2040     mov     r0,40h                                  
080134C8 4308     orr     r0,r1             ;orr 40h 无敌                     
080134CA 7010     strb    r0,[r2]           ;再写入                      
080134CC 4661     mov     r1,r12                                  
080134CE 8808     ldrh    r0,[r1]                                 
080134D0 4A17     ldr     r2,=0FFFBh                              
080134D2 4002     and     r2,r0             ;取向去掉4h                      
080134D4 2300     mov     r3,0h                                   
080134D6 4917     ldr     r1,=0FFE4h                              
080134D8 4665     mov     r5,r12                                  
080134DA 8169     strh    r1,[r5,0Ah]       ;上部分界写入NEG 1C                       
080134DC 201C     mov     r0,1Ch                                  
080134DE 81A8     strh    r0,[r5,0Ch]       ;下部分界写入1C                      
080134E0 81E9     strh    r1,[r5,0Eh]       ;左部分界写入NEG 1C                      
080134E2 8228     strh    r0,[r5,10h]       ;右部分界写入1C                      
080134E4 4660     mov     r0,r12                                  
080134E6 3027     add     r0,27h                                  
080134E8 2120     mov     r1,20h                                  
080134EA 7001     strb    r1,[r0]           ;75F写入20h                      
080134EC 3001     add     r0,1h                                   
080134EE 7001     strb    r1,[r0]           ;760写入20h                      
080134F0 3001     add     r0,1h                                   
080134F2 7001     strb    r1,[r0]           ;761写入20h                      
080134F4 4810     ldr     r0,=82B3920h                            
080134F6 61A8     str     r0,[r5,18h]       ;OAM                      
080134F8 772B     strb    r3,[r5,1Ch]                             
080134FA 82EC     strh    r4,[r5,16h]                             
080134FC 4660     mov     r0,r12                                  
080134FE 3025     add     r0,25h                                  
08013500 7003     strb    r3,[r0]           ;属性写入0                      
08013502 2001     mov     r0,1h                                   
08013504 82A8     strh    r0,[r5,14h]       ;血量写入1                      
08013506 4660     mov     r0,r12                                  
08013508 302F     add     r0,2Fh                                  
0801350A 7003     strb    r3,[r0]           ;767写入0                      
0801350C 4661     mov     r1,r12                                  
0801350E 3124     add     r1,24h                                  
08013510 200A     mov     r0,0Ah                                  
08013512 7008     strb    r0,[r1]           ;pose写入0A                      
08013514 2180     mov     r1,80h                                  
08013516 0209     lsl     r1,r1,8h                                
08013518 1C08     mov     r0,r1                                   
0801351A 4302     orr     r2,r0             ;取向去4后在ORR8000h再写入                        
0801351C 802A     strh    r2,[r5]                                 
0801351E 4661     mov     r1,r12                                  
08013520 3122     add     r1,22h                                  
08013522 2002     mov     r0,2h                                   
08013524 7008     strb    r0,[r1]           ;75A写入2h                      
08013526 BC30     pop     r4,r5                                   
08013528 BC01     pop     r0                                      
0801352A 4700     bx      r0                                      

;pose 0A                               
0801353C B510     push    r4,r14                                  
0801353E B083     add     sp,-0Ch                                 
08013540 4C10     ldr     r4,=3000738h                            
08013542 1C21     mov     r1,r4                                   
08013544 3126     add     r1,26h                                 
08013546 2001     mov     r0,1h                                   
08013548 7008     strb    r0,[r1]           ;75E写入1h                         
0801354A F7FCFB59 bl      800FC00h                                
0801354E 2800     cmp     r0,0h             ;检查动画                      
08013550 D014     beq     @@end                                
08013552 1C21     mov     r1,r4                                   
08013554 3124     add     r1,24h                                  
08013556 200B     mov     r0,0Bh            ;pose写入B                      
08013558 7008     strb    r0,[r1]                                 
0801355A 7FE2     ldrb    r2,[r4,1Fh]       ;读取gfxrow                      
0801355C 1C20     mov     r0,r4                                   
0801355E 3023     add     r0,23h                                  
08013560 7803     ldrb    r3,[r0]                                 
08013562 8860     ldrh    r0,[r4,2h]                              
08013564 9000     str     r0,[sp]                                 
08013566 88A0     ldrh    r0,[r4,4h]                              
08013568 9001     str     r0,[sp,4h]                              
0801356A 2000     mov     r0,0h                                   
0801356C 9002     str     r0,[sp,8h]                              
0801356E 2005     mov     r0,5h                                   
08013570 2100     mov     r1,0h                                   
08013572 F7FAFE71 bl      800E258h                                
08013576 1C21     mov     r1,r4                                   
08013578 312D     add     r1,2Dh                                  
0801357A 7008     strb    r0,[r1]          ;765写入产卵序号 

@@end:                                
0801357C B003     add     sp,0Ch                                  
0801357E BC10     pop     r4                                      
08013580 BC01     pop     r0                                      
08013582 4700     bx      r0                                      
08013584 0738     lsl     r0,r7,1Ch                               
08013586 0300     lsl     r0,r0,0Ch                               
08013588 480D     ldr     r0,=3000738h                            
0801358A 4684     mov     r12,r0                                  
0801358C 4661     mov     r1,r12                                  
0801358E 3126     add     r1,26h                                  
08013590 2200     mov     r2,0h                                   
08013592 2001     mov     r0,1h                                   
08013594 7008     strb    r0,[r1]                                 
08013596 3902     sub     r1,2h                                   
08013598 2009     mov     r0,9h                                   
0801359A 7008     strb    r0,[r1]                                 
0801359C 4809     ldr     r0,=82B38F8h                            
0801359E 4661     mov     r1,r12                                  
080135A0 6188     str     r0,[r1,18h]                             
080135A2 770A     strb    r2,[r1,1Ch]                             
080135A4 2300     mov     r3,0h                                   
080135A6 82CA     strh    r2,[r1,16h]                             
080135A8 8809     ldrh    r1,[r1]                                 
080135AA 4807     ldr     r0,=7FFFh                               
080135AC 4008     and     r0,r1                                   
080135AE 4661     mov     r1,r12                                  
080135B0 8008     strh    r0,[r1]                                 
080135B2 3125     add     r1,25h                                  
080135B4 201E     mov     r0,1Eh                                  
080135B6 7008     strb    r0,[r1]                                 
080135B8 4660     mov     r0,r12                                  
080135BA 302F     add     r0,2Fh                                  
080135BC 7003     strb    r3,[r0]                                 
080135BE 4770     bx      r14                                     

;蓄力能力 pose 9                              
080135CC B530     push    r4,r5,r14                               
080135CE B082     add     sp,-8h                                  
080135D0 4C2A     ldr     r4,=3000738h                            
080135D2 202F     mov     r0,2Fh                                  
080135D4 1900     add     r0,r0,r4                                
080135D6 4684     mov     r12,r0                                  
080135D8 7802     ldrb    r2,[r0]          ;读取767的值                       
080135DA 4B29     ldr     r3,=82B31ACh                            
080135DC 0050     lsl     r0,r2,1h         ;乘以2加偏移值                       
080135DE 18C0     add     r0,r0,r3                                
080135E0 2500     mov     r5,0h                                   
080135E2 5F41     ldsh    r1,[r0,r5]       ;读取速度值                       
080135E4 4827     ldr     r0,=7FFFh                               
080135E6 4281     cmp     r1,r0                                   
080135E8 D102     bne     @@SpeedNoMax                               
080135EA 2000     mov     r0,0h            ;如果速度为7FFF                       
080135EC 5E19     ldsh    r1,[r3,r0]       ;则直接读取初始值                       
080135EE 2200     mov     r2,0h            ;767的值也返回0

@@SpeedNoMax:                                 
080135F0 1C50     add     r0,r2,1          ;767或0加1                       
080135F2 2500     mov     r5,0h                                   
080135F4 4662     mov     r2,r12                                  
080135F6 7010     strb    r0,[r2]          ;再次写入767                       
080135F8 8860     ldrh    r0,[r4,2h]       ;读取当前Y坐标                       
080135FA 1840     add     r0,r0,r1         ;加上上下浮动速度                       
080135FC 2300     mov     r3,0h                                   
080135FE 8060     strh    r0,[r4,2h]       ;写入坐标                       
08013600 8821     ldrh    r1,[r4]                                 
08013602 2080     mov     r0,80h                                  
08013604 0100     lsl     r0,r0,4h                                
08013606 4008     and     r0,r1            ;800 and 取向                          
08013608 2800     cmp     r0,0h                                   
0801360A D033     beq     @@end                                
0801360C 1C20     mov     r0,r4                                   
0801360E 302D     add     r0,2Dh                                  
08013610 7802     ldrb    r2,[r0]          ;读取765副精灵序号                       
08013612 2A17     cmp     r2,17h                                  
08013614 D805     bhi     8013622h         ;如果大于17                       
08013616 491C     ldr     r1,=30001ACh                              
08013618 00D0     lsl     r0,r2,3h                                
0801361A 1A80     sub     r0,r0,r2                                
0801361C 00C0     lsl     r0,r0,3h                                
0801361E 1840     add     r0,r0,r1                                
08013620 8005     strh    r5,[r0]          ;读取副精灵取向

@@                               
08013622 491A     ldr     r1,=3001606h                            
08013624 22FA     mov     r2,0FAh                                 
08013626 0092     lsl     r2,r2,2h                                
08013628 1C10     mov     r0,r2                                   
0801362A 8008     strh    r0,[r1]          ;3E8写入1606                       
0801362C 1C22     mov     r2,r4                                   
0801362E 3232     add     r2,32h                                  
08013630 7810     ldrb    r0,[r2]          ;读取碰撞属性                        
08013632 2101     mov     r1,1h                                   
08013634 4308     orr     r0,r1            ;ORR1再写入                       
08013636 7010     strb    r0,[r2]                                 
08013638 1C21     mov     r1,r4                                   
0801363A 3126     add     r1,26h                                  
0801363C 2001     mov     r0,1h                                   
0801363E 7008     strb    r0,[r1]          ;75E写入1                       
08013640 3902     sub     r1,2h                                   
08013642 2023     mov     r0,23h                                  
08013644 7008     strb    r0,[r1]          ;pose写入23                       
08013646 1C20     mov     r0,r4                                   
08013648 302C     add     r0,2Ch                                  
0801364A 7003     strb    r3,[r0]          ;764写入0                       
0801364C 7723     strb    r3,[r4,1Ch]                             
0801364E 82E5     strh    r5,[r4,16h]                             
08013650 4A0F     ldr     r2,=3001530h                            
08013652 7B10     ldrb    r0,[r2,0Ch]                             
08013654 2110     mov     r1,10h                                  
08013656 4308     orr     r0,r1                                   
08013658 7310     strb    r0,[r2,0Ch]      ;能力写入                       
0801365A 2001     mov     r0,1h                                   
0801365C 2114     mov     r1,14h                                  
0801365E F04DF92D bl      80608BCh         ;事件激活                       
08013662 8863     ldrh    r3,[r4,2h]                              
08013664 88A0     ldrh    r0,[r4,4h]                              
08013666 9000     str     r0,[sp]                                 
08013668 9501     str     r5,[sp,4h]                              
0801366A 2011     mov     r0,11h                                  
0801366C 2109     mov     r1,9h                                   
0801366E 2206     mov     r2,6h                                   
08013670 F7FAFE54 bl      800E31Ch         ;字幕精灵

@@end:                               
08013674 B002     add     sp,8h                                   
08013676 BC30     pop     r4,r5                                   
08013678 BC01     pop     r0                                      
0801367A 4700     bx      r0                                      

;蓄力能力pose 23                               
08013694 B500     push    r14                                     
08013696 4A0D     ldr     r2,=3000738h                            
08013698 1C10     mov     r0,r2                                   
0801369A 3026     add     r0,26h                                  
0801369C 2101     mov     r1,1h                                   
0801369E 7001     strb    r1,[r0]          ;75E写入1                       
080136A0 7F10     ldrb    r0,[r2,1Ch]                             
080136A2 3801     sub     r0,1h            ;动画帧减1再写入                       
080136A4 7710     strb    r0,[r2,1Ch]                             
080136A6 1C10     mov     r0,r2                                   
080136A8 302C     add     r0,2Ch                                  
080136AA 7800     ldrb    r0,[r0]          ;读取764                       
080136AC 4001     and     r1,r0            ;和1and                       
080136AE 2900     cmp     r1,0h                                   
080136B0 D103     bne     80136BAh                                
080136B2 8810     ldrh    r0,[r2]                                 
080136B4 2104     mov     r1,4h                                   
080136B6 4048     eor     r0,r1                                   
080136B8 8010     strh    r0,[r2]

                                 
080136BA 4805     ldr     r0,=3001606h                            
080136BC 8801     ldrh    r1,[r0]                                 
080136BE 4805     ldr     r0,=3E6h                                
080136C0 4281     cmp     r1,r0                                   
080136C2 D801     bhi     80136C8h                                
080136C4 2000     mov     r0,0h                                   
080136C6 8010     strh    r0,[r2]                                 
080136C8 BC01     pop     r0                                      
080136CA 4700     bx      r0                                      
080136CC 0738     lsl     r0,r7,1Ch                               
080136CE 0300     lsl     r0,r0,0Ch                               
080136D0 1606     asr     r6,r0,18h                               
080136D2 0300     lsl     r0,r0,0Ch                               
080136D4 03E6     lsl     r6,r4,0Fh                               
080136D6 0000     lsl     r0,r0,0h                                
080136D8 B510     push    r4,r14                                  
080136DA 4814     ldr     r0,=3000738h                            
080136DC 4684     mov     r12,r0                                  
080136DE 8801     ldrh    r1,[r0]                                 
080136E0 4813     ldr     r0,=0FFFBh                              
080136E2 4008     and     r0,r1                                   
080136E4 2200     mov     r2,0h                                   
080136E6 2300     mov     r3,0h                                   
080136E8 4661     mov     r1,r12                                  
080136EA 8008     strh    r0,[r1]                                 
080136EC 3122     add     r1,22h                                  
080136EE 2003     mov     r0,3h                                   
080136F0 7008     strb    r0,[r1]                                 
080136F2 4660     mov     r0,r12                                  
080136F4 3027     add     r0,27h                                  
080136F6 2110     mov     r1,10h                                  
080136F8 7001     strb    r1,[r0]                                 
080136FA 3001     add     r0,1h                                   
080136FC 7001     strb    r1,[r0]                                 
080136FE 3001     add     r0,1h                                   
08013700 7001     strb    r1,[r0]                                 
08013702 490C     ldr     r1,=0FFE0h                              
08013704 4664     mov     r4,r12                                  
08013706 8161     strh    r1,[r4,0Ah]                             
08013708 2020     mov     r0,20h                                  
0801370A 81A0     strh    r0,[r4,0Ch]                             
0801370C 81E1     strh    r1,[r4,0Eh]                             
0801370E 8220     strh    r0,[r4,10h]                             
08013710 4809     ldr     r0,=82B3988h                            
08013712 61A0     str     r0,[r4,18h]                             
08013714 7722     strb    r2,[r4,1Ch]                             
08013716 82E3     strh    r3,[r4,16h]                             
08013718 4660     mov     r0,r12                                  
0801371A 3025     add     r0,25h                                  
0801371C 7002     strb    r2,[r0]                                 
0801371E 4661     mov     r1,r12                                  
08013720 3124     add     r1,24h                                  
08013722 2009     mov     r0,9h                                   
08013724 7008     strb    r0,[r1]                                 
08013726 BC10     pop     r4                                      
08013728 BC01     pop     r0                                      
0801372A 4700     bx      r0                                      
0801372C 0738     lsl     r0,r7,1Ch                               
0801372E 0300     lsl     r0,r0,0Ch                               
08013730 FFFB     bl      lr+0FF6h                                
08013732 0000     lsl     r0,r0,0h                                
08013734 FFE0     bl      lr+0FC0h                                
08013736 0000     lsl     r0,r0,0h                                
08013738 3988     sub     r1,88h                                  
0801373A 082B     lsr     r3,r5,20h                               
0801373C 4B05     ldr     r3,=3000738h                            
0801373E 1C18     mov     r0,r3                                   
08013740 3023     add     r0,23h                                  
08013742 7801     ldrb    r1,[r0]                                 
08013744 4A04     ldr     r2,=30001ACh                            
08013746 00C8     lsl     r0,r1,3h                                
08013748 1A40     sub     r0,r0,r1                                
0801374A 00C0     lsl     r0,r0,3h                                
0801374C 1880     add     r0,r0,r2                                
0801374E 8840     ldrh    r0,[r0,2h]                              
08013750 8058     strh    r0,[r3,2h]                              
08013752 4770     bx      r14                                     
///////////////////////////////////////////////////////////////////////////////////////////////////////
;蓄力光束主程序                              
0801375C B500     push    r14                                     
0801375E 4805     ldr     r0,=3000738h                            
08013760 3024     add     r0,24h                                  
08013762 7800     ldrb    r0,[r0]                                 
08013764 2823     cmp     r0,23h           ;pose如果大于23h                          
08013766 D85F     bhi     @@end                                
08013768 0080     lsl     r0,r0,2h                                
0801376A 4903     ldr     r1,=801377Ch    ;PoseTable                         
0801376C 1840     add     r0,r0,r1                                
0801376E 6800     ldr     r0,[r0]                                 
08013770 4687     mov     r15,r0                                  
PoseTable:
    .word 801380ch  ;00
	.word 8013828h .word 8013828h .word 8013828h .word 8013828h
	.word 8013828h .word 8013828h .word 8013828h .word 8013828h
    .word 801381eh  ;09
	.word 8013812h  ;0Ah
	.word 8013818h  ;0Bh
	.word 8013828h .word 8013828h .word 8013828h .word 8013828h
	.word 8013828h .word 8013828h .word 8013828h .word 8013828h
	.word 8013828h .word 8013828h .word 8013828h .word 8013828h
	.word 8013828h .word 8013828h .word 8013828h .word 8013828h
	.word 8013828h .word 8013828h .word 8013828h .word 8013828h\
	.word 8013828h .word 8013828h .word 8013828h
	.word 8013824h  ;23h

0801380C F7FFFE44 bl      8013498h                                
08013810 E00A     b       @@end                                
08013812 F7FFFE93 bl      801353Ch                                
08013816 E007     b       @@end                                
08013818 F7FFFEB6 bl      8013588h                                
0801381C E004     b       @@end                                
0801381E F7FFFED5 bl      80135CCh                                
08013822 E001     b       @@end                                
08013824 F7FFFF36 bl      8013694h  

@@end:                              
08013828 BC01     pop     r0                                      
0801382A 4700     bx      r0 

                                     
0801382C B500     push    r14                                     
0801382E 4804     ldr     r0,=3000738h                            
08013830 3024     add     r0,24h                                  
08013832 7800     ldrb    r0,[r0]                                 
08013834 2800     cmp     r0,0h                                   
08013836 D005     beq     8013844h                                
08013838 2809     cmp     r0,9h                                   
0801383A D005     beq     8013848h                                
0801383C E006     b       801384Ch                                
0801383E 0000     lsl     r0,r0,0h                                
08013840 0738     lsl     r0,r7,1Ch                               
08013842 0300     lsl     r0,r0,0Ch                               
08013844 F7FFFF48 bl      80136D8h                                
08013848 F7FFFF78 bl      801373Ch                                
0801384C BC01     pop     r0                                      
0801384E 4700     bx      r0                                      
08013850 B510     push    r4,r14                                  
08013852 4C18     ldr     r4,=300070Ch                            
08013854 88A0     ldrh    r0,[r4,4h]                              
08013856 6821     ldr     r1,[r4]                                 
08013858 00C0     lsl     r0,r0,3h                                
0801385A 1840     add     r0,r0,r1                                
0801385C 6803     ldr     r3,[r0]                                 
0801385E 4A16     ldr     r2,=3000738h                            
08013860 7F91     ldrb    r1,[r2,1Eh]                             
08013862 0048     lsl     r0,r1,1h                                
08013864 1840     add     r0,r0,r1                                
08013866 0040     lsl     r0,r0,1h                                
08013868 18C0     add     r0,r0,r3                                
0801386A 8800     ldrh    r0,[r0]                                 
0801386C 4913     ldr     r1,=875F4E4h                            
0801386E 0080     lsl     r0,r0,2h                                
08013870 1840     add     r0,r0,r1                                
08013872 6991     ldr     r1,[r2,18h]                             
08013874 6800     ldr     r0,[r0]                                 
08013876 4281     cmp     r1,r0                                   
08013878 D003     beq     8013882h                                
0801387A 6190     str     r0,[r2,18h]                             
0801387C 2000     mov     r0,0h                                   
0801387E 7710     strb    r0,[r2,1Ch]                             
08013880 82D0     strh    r0,[r2,16h]                             
08013882 7F91     ldrb    r1,[r2,1Eh]                             
08013884 0048     lsl     r0,r1,1h                                
08013886 1840     add     r0,r0,r1                                
08013888 0040     lsl     r0,r0,1h                                
0801388A 18C0     add     r0,r0,r3                                
0801388C 8840     ldrh    r0,[r0,2h]                              
0801388E 88E1     ldrh    r1,[r4,6h]                              
08013890 1840     add     r0,r0,r1                                
08013892 8050     strh    r0,[r2,2h]                              
08013894 8811     ldrh    r1,[r2]                                 
08013896 2040     mov     r0,40h                                  
08013898 4008     and     r0,r1                                   
0801389A 7F91     ldrb    r1,[r2,1Eh]                             
0801389C 2800     cmp     r0,0h                                   
0801389E D00F     beq     80138C0h                                
080138A0 0048     lsl     r0,r1,1h                                
080138A2 1840     add     r0,r0,r1                                
080138A4 0040     lsl     r0,r0,1h                                
080138A6 18C0     add     r0,r0,r3                                
080138A8 8921     ldrh    r1,[r4,8h]                              
080138AA 8880     ldrh    r0,[r0,4h]                              
080138AC 1A09     sub     r1,r1,r0                                
080138AE 8091     strh    r1,[r2,4h]                              
080138B0 E00E     b       80138D0h                                
080138B2 0000     lsl     r0,r0,0h                                
080138B4 070C     lsl     r4,r1,1Ch                               
080138B6 0300     lsl     r0,r0,0Ch                               
080138B8 0738     lsl     r0,r7,1Ch                               
080138BA 0300     lsl     r0,r0,0Ch                               
080138BC F4E4     ????                                            
080138BE 0875     lsr     r5,r6,1h                                
080138C0 0048     lsl     r0,r1,1h                                
080138C2 1840     add     r0,r0,r1                                
080138C4 0040     lsl     r0,r0,1h                                
080138C6 18C0     add     r0,r0,r3                                
080138C8 8880     ldrh    r0,[r0,4h]                              
080138CA 8924     ldrh    r4,[r4,8h]                              
080138CC 1900     add     r0,r0,r4                                
080138CE 8090     strh    r0,[r2,4h]                              
080138D0 BC10     pop     r4                                      
080138D2 BC01     pop     r0                                      
080138D4 4700     bx      r0                                      
080138D6 0000     lsl     r0,r0,0h                                
080138D8 B500     push    r14                                     
080138DA 0600     lsl     r0,r0,18h                               
080138DC 0E00     lsr     r0,r0,18h                               
080138DE 3822     sub     r0,22h                                  
080138E0 2872     cmp     r0,72h                                  
080138E2 D900     bls     80138E6h                                
080138E4 E179     b       8013BDAh                                
080138E6 0080     lsl     r0,r0,2h                                
080138E8 4901     ldr     r1,=80138F4h                            
080138EA 1840     add     r0,r0,r1                                
080138EC 6800     ldr     r0,[r0]                                 
080138EE 4687     mov     r15,r0                                  
080138F0 38F4     sub     r0,0F4h                                 
080138F2 0801     lsr     r1,r0,20h                               
080138F4 3ACA     sub     r2,0CAh                                 
080138F6 0801     lsr     r1,r0,20h                               
080138F8 3AC0     sub     r2,0C0h                                 
080138FA 0801     lsr     r1,r0,20h                               
080138FC 3AE2     sub     r2,0E2h                                 
080138FE 0801     lsr     r1,r0,20h                               
08013900 3AD8     sub     r2,0D8h                                 
08013902 0801     lsr     r1,r0,20h                               
08013904 3AFA     sub     r2,0FAh                                 
08013906 0801     lsr     r1,r0,20h                               
08013908 3AF0     sub     r2,0F0h                                 
0801390A 0801     lsr     r1,r0,20h                               
0801390C 3B12     sub     r3,12h                                  
0801390E 0801     lsr     r1,r0,20h                               
08013910 3B08     sub     r3,8h                                   
08013912 0801     lsr     r1,r0,20h                               
08013914 3B2A     sub     r3,2Ah                                  
08013916 0801     lsr     r1,r0,20h                               
08013918 3B20     sub     r3,20h                                  
0801391A 0801     lsr     r1,r0,20h                               
0801391C 3B4A     sub     r3,4Ah                                  
0801391E 0801     lsr     r1,r0,20h                               
08013920 3B38     sub     r3,38h                                  
08013922 0801     lsr     r1,r0,20h                               
08013924 3B6A     sub     r3,6Ah                                  
08013926 0801     lsr     r1,r0,20h                               
08013928 3B58     sub     r3,58h                                  
0801392A 0801     lsr     r1,r0,20h                               
0801392C 3B8A     sub     r3,8Ah                                  
0801392E 0801     lsr     r1,r0,20h                               
08013930 3B78     sub     r3,78h                                  
08013932 0801     lsr     r1,r0,20h                               
08013934 3BDA     sub     r3,0DAh                                 
08013936 0801     lsr     r1,r0,20h                               
08013938 3BDA     sub     r3,0DAh                                 
0801393A 0801     lsr     r1,r0,20h                               
0801393C 3BDA     sub     r3,0DAh                                 
0801393E 0801     lsr     r1,r0,20h                               
08013940 3BDA     sub     r3,0DAh                                 
08013942 0801     lsr     r1,r0,20h                               
08013944 3BDA     sub     r3,0DAh                                 
08013946 0801     lsr     r1,r0,20h                               
08013948 3BDA     sub     r3,0DAh                                 
0801394A 0801     lsr     r1,r0,20h                               
0801394C 3BDA     sub     r3,0DAh                                 
0801394E 0801     lsr     r1,r0,20h                               
08013950 3BDA     sub     r3,0DAh                                 
08013952 0801     lsr     r1,r0,20h                               
08013954 3BDA     sub     r3,0DAh                                 
08013956 0801     lsr     r1,r0,20h                               
08013958 3BDA     sub     r3,0DAh                                 
0801395A 0801     lsr     r1,r0,20h                               
0801395C 3BDA     sub     r3,0DAh                                 
0801395E 0801     lsr     r1,r0,20h                               
08013960 3BDA     sub     r3,0DAh                                 
08013962 0801     lsr     r1,r0,20h                               
08013964 3BDA     sub     r3,0DAh                                 
08013966 0801     lsr     r1,r0,20h                               
08013968 3BDA     sub     r3,0DAh                                 
0801396A 0801     lsr     r1,r0,20h                               
0801396C 3BDA     sub     r3,0DAh                                 
0801396E 0801     lsr     r1,r0,20h                               
08013970 3BDA     sub     r3,0DAh                                 
08013972 0801     lsr     r1,r0,20h                               
08013974 3BDA     sub     r3,0DAh                                 
08013976 0801     lsr     r1,r0,20h                               
08013978 3BDA     sub     r3,0DAh                                 
0801397A 0801     lsr     r1,r0,20h                               
0801397C 3BDA     sub     r3,0DAh                                 
0801397E 0801     lsr     r1,r0,20h                               
08013980 3BDA     sub     r3,0DAh                                 
08013982 0801     lsr     r1,r0,20h                               
08013984 3BDA     sub     r3,0DAh                                 
08013986 0801     lsr     r1,r0,20h                               
08013988 3BDA     sub     r3,0DAh                                 
0801398A 0801     lsr     r1,r0,20h                               
0801398C 3BDA     sub     r3,0DAh                                 
0801398E 0801     lsr     r1,r0,20h                               
08013990 3BDA     sub     r3,0DAh                                 
08013992 0801     lsr     r1,r0,20h                               
08013994 3BDA     sub     r3,0DAh                                 
08013996 0801     lsr     r1,r0,20h                               
08013998 3BDA     sub     r3,0DAh                                 
0801399A 0801     lsr     r1,r0,20h                               
0801399C 3BDA     sub     r3,0DAh                                 
0801399E 0801     lsr     r1,r0,20h                               
080139A0 3BDA     sub     r3,0DAh                                 
080139A2 0801     lsr     r1,r0,20h                               
080139A4 3BDA     sub     r3,0DAh                                 
080139A6 0801     lsr     r1,r0,20h                               
080139A8 3BDA     sub     r3,0DAh                                 
080139AA 0801     lsr     r1,r0,20h                               
080139AC 3BDA     sub     r3,0DAh                                 
080139AE 0801     lsr     r1,r0,20h                               
080139B0 3BDA     sub     r3,0DAh                                 
080139B2 0801     lsr     r1,r0,20h                               
080139B4 3BDA     sub     r3,0DAh                                 
080139B6 0801     lsr     r1,r0,20h                               
080139B8 3BDA     sub     r3,0DAh                                 
080139BA 0801     lsr     r1,r0,20h                               
080139BC 3BDA     sub     r3,0DAh                                 
080139BE 0801     lsr     r1,r0,20h                               
080139C0 3BDA     sub     r3,0DAh                                 
080139C2 0801     lsr     r1,r0,20h                               
080139C4 3BDA     sub     r3,0DAh                                 
080139C6 0801     lsr     r1,r0,20h                               
080139C8 3BDA     sub     r3,0DAh                                 
080139CA 0801     lsr     r1,r0,20h                               
080139CC 3BB0     sub     r3,0B0h                                 
080139CE 0801     lsr     r1,r0,20h                               
080139D0 3B98     sub     r3,98h                                  
080139D2 0801     lsr     r1,r0,20h                               
080139D4 3BDA     sub     r3,0DAh                                 
080139D6 0801     lsr     r1,r0,20h                               
080139D8 3BDA     sub     r3,0DAh                                 
080139DA 0801     lsr     r1,r0,20h                               
080139DC 3BDA     sub     r3,0DAh                                 
080139DE 0801     lsr     r1,r0,20h                               
080139E0 3BDA     sub     r3,0DAh                                 
080139E2 0801     lsr     r1,r0,20h                               
080139E4 3BDA     sub     r3,0DAh                                 
080139E6 0801     lsr     r1,r0,20h                               
080139E8 3BDA     sub     r3,0DAh                                 
080139EA 0801     lsr     r1,r0,20h                               
080139EC 3BDA     sub     r3,0DAh                                 
080139EE 0801     lsr     r1,r0,20h                               
080139F0 3BDA     sub     r3,0DAh                                 
080139F2 0801     lsr     r1,r0,20h                               
080139F4 3BDA     sub     r3,0DAh                                 
080139F6 0801     lsr     r1,r0,20h                               
080139F8 3BDA     sub     r3,0DAh                                 
080139FA 0801     lsr     r1,r0,20h                               
080139FC 3BDA     sub     r3,0DAh                                 
080139FE 0801     lsr     r1,r0,20h                               
08013A00 3BDA     sub     r3,0DAh                                 
08013A02 0801     lsr     r1,r0,20h                               
08013A04 3BDA     sub     r3,0DAh                                 
08013A06 0801     lsr     r1,r0,20h                               
08013A08 3BDA     sub     r3,0DAh                                 
08013A0A 0801     lsr     r1,r0,20h                               
08013A0C 3BDA     sub     r3,0DAh                                 
08013A0E 0801     lsr     r1,r0,20h                               
08013A10 3BDA     sub     r3,0DAh                                 
08013A12 0801     lsr     r1,r0,20h                               
08013A14 3BDA     sub     r3,0DAh                                 
08013A16 0801     lsr     r1,r0,20h                               
08013A18 3BDA     sub     r3,0DAh                                 
08013A1A 0801     lsr     r1,r0,20h                               
08013A1C 3BDA     sub     r3,0DAh                                 
08013A1E 0801     lsr     r1,r0,20h                               
08013A20 3BDA     sub     r3,0DAh                                 
08013A22 0801     lsr     r1,r0,20h                               
08013A24 3BDA     sub     r3,0DAh                                 
08013A26 0801     lsr     r1,r0,20h                               
08013A28 3BDA     sub     r3,0DAh                                 
08013A2A 0801     lsr     r1,r0,20h                               
08013A2C 3BDA     sub     r3,0DAh                                 
08013A2E 0801     lsr     r1,r0,20h                               
08013A30 3BDA     sub     r3,0DAh                                 
08013A32 0801     lsr     r1,r0,20h                               
08013A34 3BDA     sub     r3,0DAh                                 
08013A36 0801     lsr     r1,r0,20h                               
08013A38 3BDA     sub     r3,0DAh                                 
08013A3A 0801     lsr     r1,r0,20h                               
08013A3C 3BDA     sub     r3,0DAh                                 
08013A3E 0801     lsr     r1,r0,20h                               
08013A40 3BDA     sub     r3,0DAh                                 
08013A42 0801     lsr     r1,r0,20h                               
08013A44 3BDA     sub     r3,0DAh                                 
08013A46 0801     lsr     r1,r0,20h                               
08013A48 3BDA     sub     r3,0DAh                                 
08013A4A 0801     lsr     r1,r0,20h                               
08013A4C 3BDA     sub     r3,0DAh                                 
08013A4E 0801     lsr     r1,r0,20h                               
08013A50 3BDA     sub     r3,0DAh                                 
08013A52 0801     lsr     r1,r0,20h                               
08013A54 3BDA     sub     r3,0DAh                                 
08013A56 0801     lsr     r1,r0,20h                               
08013A58 3BDA     sub     r3,0DAh                                 
08013A5A 0801     lsr     r1,r0,20h                               
08013A5C 3BDA     sub     r3,0DAh                                 
08013A5E 0801     lsr     r1,r0,20h                               
08013A60 3BDA     sub     r3,0DAh                                 
08013A62 0801     lsr     r1,r0,20h                               
08013A64 3BDA     sub     r3,0DAh                                 
08013A66 0801     lsr     r1,r0,20h                               
08013A68 3BDA     sub     r3,0DAh                                 
08013A6A 0801     lsr     r1,r0,20h                               
08013A6C 3BDA     sub     r3,0DAh                                 
08013A6E 0801     lsr     r1,r0,20h                               
08013A70 3BDA     sub     r3,0DAh                                 
08013A72 0801     lsr     r1,r0,20h                               
08013A74 3BDA     sub     r3,0DAh                                 
08013A76 0801     lsr     r1,r0,20h                               
08013A78 3BDA     sub     r3,0DAh                                 
08013A7A 0801     lsr     r1,r0,20h                               
08013A7C 3BDA     sub     r3,0DAh                                 
08013A7E 0801     lsr     r1,r0,20h                               
08013A80 3BDA     sub     r3,0DAh                                 
08013A82 0801     lsr     r1,r0,20h                               
08013A84 3BDA     sub     r3,0DAh                                 
08013A86 0801     lsr     r1,r0,20h                               
08013A88 3BDA     sub     r3,0DAh                                 
08013A8A 0801     lsr     r1,r0,20h                               
08013A8C 3BDA     sub     r3,0DAh                                 
08013A8E 0801     lsr     r1,r0,20h                               
08013A90 3BDA     sub     r3,0DAh                                 
08013A92 0801     lsr     r1,r0,20h                               
08013A94 3BDA     sub     r3,0DAh                                 
08013A96 0801     lsr     r1,r0,20h                               
08013A98 3BDA     sub     r3,0DAh                                 
08013A9A 0801     lsr     r1,r0,20h                               
08013A9C 3BDA     sub     r3,0DAh                                 
08013A9E 0801     lsr     r1,r0,20h                               
08013AA0 3BDA     sub     r3,0DAh                                 
08013AA2 0801     lsr     r1,r0,20h                               
08013AA4 3BDA     sub     r3,0DAh                                 
08013AA6 0801     lsr     r1,r0,20h                               
08013AA8 3BDA     sub     r3,0DAh                                 
08013AAA 0801     lsr     r1,r0,20h                               
08013AAC 3BDA     sub     r3,0DAh                                 
08013AAE 0801     lsr     r1,r0,20h                               
08013AB0 3BDA     sub     r3,0DAh                                 
08013AB2 0801     lsr     r1,r0,20h                               
08013AB4 3BDA     sub     r3,0DAh                                 
08013AB6 0801     lsr     r1,r0,20h                               
08013AB8 3BDA     sub     r3,0DAh                                 
08013ABA 0801     lsr     r1,r0,20h                               
08013ABC 3BC8     sub     r3,0C8h                                 
08013ABE 0801     lsr     r1,r0,20h                               
08013AC0 4A04     ldr     r2,=3001530h                            
08013AC2 7B11     ldrb    r1,[r2,0Ch]                             
08013AC4 2001     mov     r0,1h                                   
08013AC6 4308     orr     r0,r1                                   
08013AC8 7310     strb    r0,[r2,0Ch]                             
08013ACA 2001     mov     r0,1h                                   
08013ACC 2108     mov     r1,8h                                   
08013ACE F04CFEF5 bl      80608BCh                                
08013AD2 E082     b       8013BDAh                                
08013AD4 1530     asr     r0,r6,14h                               
08013AD6 0300     lsl     r0,r0,0Ch                               
08013AD8 4A04     ldr     r2,=3001530h                            
08013ADA 7B11     ldrb    r1,[r2,0Ch]                             
08013ADC 2002     mov     r0,2h                                   
08013ADE 4308     orr     r0,r1                                   
08013AE0 7310     strb    r0,[r2,0Ch]                             
08013AE2 2001     mov     r0,1h                                   
08013AE4 210A     mov     r1,0Ah                                  
08013AE6 F04CFEE9 bl      80608BCh                                
08013AEA E076     b       8013BDAh                                
08013AEC 1530     asr     r0,r6,14h                               
08013AEE 0300     lsl     r0,r0,0Ch                               
08013AF0 4A04     ldr     r2,=3001530h                            
08013AF2 7B11     ldrb    r1,[r2,0Ch]                             
08013AF4 2004     mov     r0,4h                                   
08013AF6 4308     orr     r0,r1                                   
08013AF8 7310     strb    r0,[r2,0Ch]                             
08013AFA 2001     mov     r0,1h                                   
08013AFC 210E     mov     r1,0Eh                                  
08013AFE F04CFEDD bl      80608BCh                                
08013B02 E06A     b       8013BDAh                                
08013B04 1530     asr     r0,r6,14h                               
08013B06 0300     lsl     r0,r0,0Ch                               
08013B08 4A04     ldr     r2,=3001530h                            
08013B0A 7B11     ldrb    r1,[r2,0Ch]                             
08013B0C 2080     mov     r0,80h                                  
08013B0E 4308     orr     r0,r1                                   
08013B10 7310     strb    r0,[r2,0Ch]                             
08013B12 2001     mov     r0,1h                                   
08013B14 2109     mov     r1,9h                                   
08013B16 F04CFED1 bl      80608BCh                                
08013B1A E05E     b       8013BDAh                                
08013B1C 1530     asr     r0,r6,14h                               
08013B1E 0300     lsl     r0,r0,0Ch                               
08013B20 4A04     ldr     r2,=3001530h                            
08013B22 7B91     ldrb    r1,[r2,0Eh]                             
08013B24 2002     mov     r0,2h                                   
08013B26 4308     orr     r0,r1                                   
08013B28 7390     strb    r0,[r2,0Eh]                             
08013B2A 2001     mov     r0,1h                                   
08013B2C 210B     mov     r1,0Bh                                  
08013B2E F04CFEC5 bl      80608BCh                                
08013B32 E052     b       8013BDAh                                
08013B34 1530     asr     r0,r6,14h                               
08013B36 0300     lsl     r0,r0,0Ch                               
08013B38 4A06     ldr     r2,=3001530h                            
08013B3A 7B91     ldrb    r1,[r2,0Eh]                             
08013B3C 2001     mov     r0,1h                                   
08013B3E 4308     orr     r0,r1                                   
08013B40 7390     strb    r0,[r2,0Eh]                             
08013B42 2001     mov     r0,1h                                   
08013B44 2112     mov     r1,12h                                  
08013B46 F04CFEB9 bl      80608BCh                                
08013B4A 2001     mov     r0,1h                                   
08013B4C 210C     mov     r1,0Ch                                  
08013B4E F04CFEB5 bl      80608BCh                                
08013B52 E042     b       8013BDAh                                
08013B54 1530     asr     r0,r6,14h                               
08013B56 0300     lsl     r0,r0,0Ch                               
08013B58 4A06     ldr     r2,=3001530h                            
08013B5A 7B91     ldrb    r1,[r2,0Eh]                             
08013B5C 2008     mov     r0,8h                                   
08013B5E 4308     orr     r0,r1                                   
08013B60 7390     strb    r0,[r2,0Eh]                             
08013B62 2001     mov     r0,1h                                   
08013B64 2115     mov     r1,15h                                  
08013B66 F04CFEA9 bl      80608BCh                                
08013B6A 2001     mov     r0,1h                                   
08013B6C 210F     mov     r1,0Fh                                  
08013B6E F04CFEA5 bl      80608BCh                                
08013B72 E032     b       8013BDAh                                
08013B74 1530     asr     r0,r6,14h                               
08013B76 0300     lsl     r0,r0,0Ch                               
08013B78 4A06     ldr     r2,=3001530h                            
08013B7A 7B91     ldrb    r1,[r2,0Eh]                             
08013B7C 2010     mov     r0,10h                                  
08013B7E 4308     orr     r0,r1                                   
08013B80 7390     strb    r0,[r2,0Eh]                             
08013B82 2001     mov     r0,1h                                   
08013B84 2113     mov     r1,13h                                  
08013B86 F04CFE99 bl      80608BCh                                
08013B8A 2001     mov     r0,1h                                   
08013B8C 210D     mov     r1,0Dh                                  
08013B8E F04CFE95 bl      80608BCh                                
08013B92 E022     b       8013BDAh                                
08013B94 1530     asr     r0,r6,14h                               
08013B96 0300     lsl     r0,r0,0Ch                               
08013B98 4A04     ldr     r2,=3001530h                            
08013B9A 7B91     ldrb    r1,[r2,0Eh]                             
08013B9C 2004     mov     r0,4h                                   
08013B9E 4308     orr     r0,r1                                   
08013BA0 7390     strb    r0,[r2,0Eh]                             
08013BA2 2001     mov     r0,1h                                   
08013BA4 2116     mov     r1,16h                                  
08013BA6 F04CFE89 bl      80608BCh                                
08013BAA E016     b       8013BDAh                                
08013BAC 1530     asr     r0,r6,14h                               
08013BAE 0300     lsl     r0,r0,0Ch                               
08013BB0 4A04     ldr     r2,=3001530h                            
08013BB2 7B91     ldrb    r1,[r2,0Eh]                             
08013BB4 2020     mov     r0,20h                                  
08013BB6 4308     orr     r0,r1                                   
08013BB8 7390     strb    r0,[r2,0Eh]                             
08013BBA 2001     mov     r0,1h                                   
08013BBC 2117     mov     r1,17h                                  
08013BBE F04CFE7D bl      80608BCh                                
08013BC2 E00A     b       8013BDAh                                
08013BC4 1530     asr     r0,r6,14h                               
08013BC6 0300     lsl     r0,r0,0Ch                               
08013BC8 4A05     ldr     r2,=3001530h                            
08013BCA 7B11     ldrb    r1,[r2,0Ch]                             
08013BCC 2008     mov     r0,8h                                   
08013BCE 4308     orr     r0,r1                                   
08013BD0 7310     strb    r0,[r2,0Ch]                             
08013BD2 2001     mov     r0,1h                                   
08013BD4 2118     mov     r1,18h                                  
08013BD6 F04CFE71 bl      80608BCh                                
08013BDA BC01     pop     r0                                      
08013BDC 4700     bx      r0                                      
08013BDE 0000     lsl     r0,r0,0h                                
08013BE0 1530     asr     r0,r6,14h                               
08013BE2 0300     lsl     r0,r0,0Ch                               
08013BE4 B500     push    r14                                     
08013BE6 4906     ldr     r1,=3000738h                            
08013BE8 7F48     ldrb    r0,[r1,1Dh]                             
08013BEA 3822     sub     r0,22h                                  
08013BEC 1C0A     mov     r2,r1                                   
08013BEE 2872     cmp     r0,72h                                  
08013BF0 D900     bls     8013BF4h                                
08013BF2 E0F3     b       8013DDCh                                
08013BF4 0080     lsl     r0,r0,2h                                
08013BF6 4903     ldr     r1,=8013C08h                            
08013BF8 1840     add     r0,r0,r1                                
08013BFA 6800     ldr     r0,[r0]                                 
08013BFC 4687     mov     r15,r0                                  
08013BFE 0000     lsl     r0,r0,0h                                
08013C00 0738     lsl     r0,r7,1Ch                               
08013C02 0300     lsl     r0,r0,0Ch                               
08013C04 3C08     sub     r4,8h                                   
08013C06 0801     lsr     r1,r0,20h                               
08013C08 3DDC     sub     r5,0DCh                                 
08013C0A 0801     lsr     r1,r0,20h                               
08013C0C 3DD4     sub     r5,0D4h                                 
08013C0E 0801     lsr     r1,r0,20h                               
08013C10 3DD4     sub     r5,0D4h                                 
08013C12 0801     lsr     r1,r0,20h                               
08013C14 3DD4     sub     r5,0D4h                                 
08013C16 0801     lsr     r1,r0,20h                               
08013C18 3DD4     sub     r5,0D4h                                 
08013C1A 0801     lsr     r1,r0,20h                               
08013C1C 3DD4     sub     r5,0D4h                                 
08013C1E 0801     lsr     r1,r0,20h                               
08013C20 3DDC     sub     r5,0DCh                                 
08013C22 0801     lsr     r1,r0,20h                               
08013C24 3DD4     sub     r5,0D4h                                 
08013C26 0801     lsr     r1,r0,20h                               
08013C28 3DDC     sub     r5,0DCh                                 
08013C2A 0801     lsr     r1,r0,20h                               
08013C2C 3DD4     sub     r5,0D4h                                 
08013C2E 0801     lsr     r1,r0,20h                               
08013C30 3DDC     sub     r5,0DCh                                 
08013C32 0801     lsr     r1,r0,20h                               
08013C34 3DD4     sub     r5,0D4h                                 
08013C36 0801     lsr     r1,r0,20h                               
08013C38 3DDC     sub     r5,0DCh                                 
08013C3A 0801     lsr     r1,r0,20h                               
08013C3C 3DD4     sub     r5,0D4h                                 
08013C3E 0801     lsr     r1,r0,20h                               
08013C40 3DD4     sub     r5,0D4h                                 
08013C42 0801     lsr     r1,r0,20h                               
08013C44 3DD4     sub     r5,0D4h                                 
08013C46 0801     lsr     r1,r0,20h                               
08013C48 3DDC     sub     r5,0DCh                                 
08013C4A 0801     lsr     r1,r0,20h                               
08013C4C 3DDC     sub     r5,0DCh                                 
08013C4E 0801     lsr     r1,r0,20h                               
08013C50 3DDC     sub     r5,0DCh                                 
08013C52 0801     lsr     r1,r0,20h                               
08013C54 3DDC     sub     r5,0DCh                                 
08013C56 0801     lsr     r1,r0,20h                               
08013C58 3DDC     sub     r5,0DCh                                 
08013C5A 0801     lsr     r1,r0,20h                               
08013C5C 3DDC     sub     r5,0DCh                                 
08013C5E 0801     lsr     r1,r0,20h                               
08013C60 3DDC     sub     r5,0DCh                                 
08013C62 0801     lsr     r1,r0,20h                               
08013C64 3DDC     sub     r5,0DCh                                 
08013C66 0801     lsr     r1,r0,20h                               
08013C68 3DDC     sub     r5,0DCh                                 
08013C6A 0801     lsr     r1,r0,20h                               
08013C6C 3DDC     sub     r5,0DCh                                 
08013C6E 0801     lsr     r1,r0,20h                               
08013C70 3DDC     sub     r5,0DCh                                 
08013C72 0801     lsr     r1,r0,20h                               
08013C74 3DDC     sub     r5,0DCh                                 
08013C76 0801     lsr     r1,r0,20h                               
08013C78 3DDC     sub     r5,0DCh                                 
08013C7A 0801     lsr     r1,r0,20h                               
08013C7C 3DDC     sub     r5,0DCh                                 
08013C7E 0801     lsr     r1,r0,20h                               
08013C80 3DDC     sub     r5,0DCh                                 
08013C82 0801     lsr     r1,r0,20h                               
08013C84 3DDC     sub     r5,0DCh                                 
08013C86 0801     lsr     r1,r0,20h                               
08013C88 3DDC     sub     r5,0DCh                                 
08013C8A 0801     lsr     r1,r0,20h                               
08013C8C 3DDC     sub     r5,0DCh                                 
08013C8E 0801     lsr     r1,r0,20h                               
08013C90 3DDC     sub     r5,0DCh                                 
08013C92 0801     lsr     r1,r0,20h                               
08013C94 3DDC     sub     r5,0DCh                                 
08013C96 0801     lsr     r1,r0,20h                               
08013C98 3DDC     sub     r5,0DCh                                 
08013C9A 0801     lsr     r1,r0,20h                               
08013C9C 3DDC     sub     r5,0DCh                                 
08013C9E 0801     lsr     r1,r0,20h                               
08013CA0 3DDC     sub     r5,0DCh                                 
08013CA2 0801     lsr     r1,r0,20h                               
08013CA4 3DDC     sub     r5,0DCh                                 
08013CA6 0801     lsr     r1,r0,20h                               
08013CA8 3DDC     sub     r5,0DCh                                 
08013CAA 0801     lsr     r1,r0,20h                               
08013CAC 3DDC     sub     r5,0DCh                                 
08013CAE 0801     lsr     r1,r0,20h                               
08013CB0 3DDC     sub     r5,0DCh                                 
08013CB2 0801     lsr     r1,r0,20h                               
08013CB4 3DDC     sub     r5,0DCh                                 
08013CB6 0801     lsr     r1,r0,20h                               
08013CB8 3DDC     sub     r5,0DCh                                 
08013CBA 0801     lsr     r1,r0,20h                               
08013CBC 3DDC     sub     r5,0DCh                                 
08013CBE 0801     lsr     r1,r0,20h                               
08013CC0 3DDC     sub     r5,0DCh                                 
08013CC2 0801     lsr     r1,r0,20h                               
08013CC4 3DDC     sub     r5,0DCh                                 
08013CC6 0801     lsr     r1,r0,20h                               
08013CC8 3DDC     sub     r5,0DCh                                 
08013CCA 0801     lsr     r1,r0,20h                               
08013CCC 3DDC     sub     r5,0DCh                                 
08013CCE 0801     lsr     r1,r0,20h                               
08013CD0 3DDC     sub     r5,0DCh                                 
08013CD2 0801     lsr     r1,r0,20h                               
08013CD4 3DDC     sub     r5,0DCh                                 
08013CD6 0801     lsr     r1,r0,20h                               
08013CD8 3DDC     sub     r5,0DCh                                 
08013CDA 0801     lsr     r1,r0,20h                               
08013CDC 3DDC     sub     r5,0DCh                                 
08013CDE 0801     lsr     r1,r0,20h                               
08013CE0 3DD4     sub     r5,0D4h                                 
08013CE2 0801     lsr     r1,r0,20h                               
08013CE4 3DDC     sub     r5,0DCh                                 
08013CE6 0801     lsr     r1,r0,20h                               
08013CE8 3DDC     sub     r5,0DCh                                 
08013CEA 0801     lsr     r1,r0,20h                               
08013CEC 3DDC     sub     r5,0DCh                                 
08013CEE 0801     lsr     r1,r0,20h                               
08013CF0 3DDC     sub     r5,0DCh                                 
08013CF2 0801     lsr     r1,r0,20h                               
08013CF4 3DDC     sub     r5,0DCh                                 
08013CF6 0801     lsr     r1,r0,20h                               
08013CF8 3DDC     sub     r5,0DCh                                 
08013CFA 0801     lsr     r1,r0,20h                               
08013CFC 3DDC     sub     r5,0DCh                                 
08013CFE 0801     lsr     r1,r0,20h                               
08013D00 3DDC     sub     r5,0DCh                                 
08013D02 0801     lsr     r1,r0,20h                               
08013D04 3DDC     sub     r5,0DCh                                 
08013D06 0801     lsr     r1,r0,20h                               
08013D08 3DDC     sub     r5,0DCh                                 
08013D0A 0801     lsr     r1,r0,20h                               
08013D0C 3DDC     sub     r5,0DCh                                 
08013D0E 0801     lsr     r1,r0,20h                               
08013D10 3DDC     sub     r5,0DCh                                 
08013D12 0801     lsr     r1,r0,20h                               

