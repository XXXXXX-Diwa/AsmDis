

.definelabel checkevent,80608BCh
.definelabel blockmake,8057E7Ch
.definelabel PlaySound,8002A18h
.definelabel checkpowerbome,800E6F8h
.definelabel checkanimation,800FBC8h
.definelabel SetGraphicsEffect,80540ech

;pose 0
080463DC B510     push    r4,r14                                  
080463DE 4C15     ldr     r4,=3000738h                            
080463E0 1C20     mov     r0,r4                                   
080463E2 3027     add     r0,27h                                  
080463E4 2200     mov     r2,0h                                   
080463E6 2130     mov     r1,30h                                  
080463E8 7001     strb    r1,[r0]  ;300075f写入30h                               
080463EA 3001     add     r0,1h                                   
080463EC 7001     strb    r1,[r0]  ;3000760写入30h                                
080463EE 1C21     mov     r1,r4                                   
080463F0 3129     add     r1,29h                                  
080463F2 2070     mov     r0,70h                                  
080463F4 7008     strb    r0,[r1]  ;3000761写入70h                               
080463F6 2100     mov     r1,0h                                   
080463F8 480F     ldr     r0,=0FF80h                              
080463FA 8160     strh    r0,[r4,0Ah]  ;上部分界写入FF80h                           
080463FC 2080     mov     r0,80h                                  
080463FE 81A0     strh    r0,[r4,0Ch]  ;下部分界写入80h                           
08046400 20FF     mov     r0,0FFh                                 
08046402 0200     lsl     r0,r0,8h                                
08046404 81E0     strh    r0,[r4,0Eh]  ;左部分界写入ff00h                            
08046406 2080     mov     r0,80h                                  
08046408 0040     lsl     r0,r0,1h                                
0804640A 8220     strh    r0,[r4,10h]  ;右部分界写100h                           
0804640C 7721     strb    r1,[r4,1Ch]                             
0804640E 82E2     strh    r2,[r4,16h]  ;清零                           
08046410 1C20     mov     r0,r4                                   
08046412 3025     add     r0,25h                                  
08046414 7001     strb    r1,[r0]      ;属性0h                           
08046416 2003     mov     r0,3h                                   
08046418 2149     mov     r1,49h                                  
0804641A F01AFA4F bl      checkevent                                
0804641E 2800     cmp     r0,0h       ;检查事件49h 玻璃罩破事件                           
08046420 D00E     beq     @@eventNOactive                                
08046422 4806     ldr     r0,=830D664h ;罩破后的OAM                          
08046424 61A0     str     r0,[r4,18h]                             
08046426 1C21     mov     r1,r4                                   
08046428 3124     add     r1,24h                                  
0804642A 200F     mov     r0,0Fh       ;Pose写入Fh                             
0804642C 7008     strb    r0,[r1]                                 
0804642E F7FFFF25 bl      804627Ch     ;去除砖块                           
08046432 E00B     b       @@peer                                

@@eventNOactive:                             
08046440 4809     ldr     r0,=830D55Ch  ;写入OAM                          
08046442 61A0     str     r0,[r4,18h]                             
08046444 1C21     mov     r1,r4                                   
08046446 3124     add     r1,24h                                  
08046448 2009     mov     r0,9h         ;Pose写入9h                          
0804644A 7008     strb    r0,[r1]

@@peer:                                
0804644C 2003     mov     r0,3h                                   
0804644E 2143     mov     r1,43h       ;检查全装甲事件                          
08046450 F01AFA34 bl      checkevent                                
08046454 2800     cmp     r0,0h                                   
08046456 D103     bne     @@end        ;事件若激活则跳过                        
08046458 2091     mov     r0,91h       ;雨声持续不停                           
0804645A 0040     lsl     r0,r0,1h                                
0804645C F7BCFADC bl      PlaySound    ;一次设置,始终播放??因为音乐循环的

@@end:                               
08046460 BC10     pop     r4                                      
08046462 BC01     pop     r0                                      
08046464 4700     bx      r0                                      

;pose 9h                               
0804646C B5F0     push    r4-r7,r14                               
0804646E 464F     mov     r7,r9                                   
08046470 4646     mov     r6,r8                                   
08046472 B4C0     push    r6,r7                                   
08046474 B084     add     sp,-10h                                 
08046476 2003     mov     r0,3h                                   
08046478 2143     mov     r1,43h                                  
0804647A F01AFA1F bl      checkevent                                
0804647E 2800     cmp     r0,0h                                   
08046480 D047     beq     @@end         ;事件未激活结束                            
08046482 4927     ldr     r1,=3000130h  ;超级炸弹未放                           
08046484 7808     ldrb    r0,[r1]                                 
08046486 2800     cmp     r0,0h                                   
08046488 D043     beq     @@end                                
0804648A 4826     ldr     r0,=3001530h  ;最大超级炸弹数量                          
0804648C 7940     ldrb    r0,[r0,5h]                              
0804648E 2800     cmp     r0,0h                                   
08046490 D03F     beq     @@end                                
08046492 88CE     ldrh    r6,[r1,6h]    ;超级炸弹爆炸的中心 Y坐标                          
08046494 8888     ldrh    r0,[r1,4h]    ;超级炸弹爆炸的中心 X坐标                          
08046496 4680     mov     r8,r0                                   
08046498 898C     ldrh    r4,[r1,0Ch]   ;超级炸弹扩展的X左范围                         
0804649A 46A1     mov     r9,r4                                   
0804649C 44B1     add     r9,r6                                   
0804649E 4648     mov     r0,r9                                   
080464A0 0400     lsl     r0,r0,10h                               
080464A2 0C00     lsr     r0,r0,10h     ;左范围 r9                          
080464A4 4681     mov     r9,r0                                   
080464A6 89C8     ldrh    r0,[r1,0Eh]   ;超级炸弹扩展的X右范围                          
080464A8 1836     add     r6,r6,r0                                
080464AA 0436     lsl     r6,r6,10h                               
080464AC 0C36     lsr     r6,r6,10h     ;右范围 r6                          
080464AE 890D     ldrh    r5,[r1,8h]    ;超级炸弹扩展的Y上范围                          
080464B0 4445     add     r5,r8                                   
080464B2 042D     lsl     r5,r5,10h                               
080464B4 0C2D     lsr     r5,r5,10h     ;上范围 r5                          
080464B6 8948     ldrh    r0,[r1,0Ah]   ;超级炸弹扩展的Y下范围                          
080464B8 4480     add     r8,r0                                   
080464BA 4644     mov     r4,r8                                  
080464BC 0424     lsl     r4,r4,10h                               
080464BE 0C24     lsr     r4,r4,10h                               
080464C0 46A0     mov     r8,r4         ;下范围 r8                           
080464C2 4F19     ldr     r7,=3000738h                            
080464C4 8879     ldrh    r1,[r7,2h]    ;精灵坐标                          
080464C6 88BB     ldrh    r3,[r7,4h]                              
080464C8 8978     ldrh    r0,[r7,0Ah]   ;上部分界                          
080464CA 1808     add     r0,r1,r0                                
080464CC 0400     lsl     r0,r0,10h                               
080464CE 0C00     lsr     r0,r0,10h                               
080464D0 89BA     ldrh    r2,[r7,0Ch]   ;下部分界                          
080464D2 1889     add     r1,r1,r2                                
080464D4 0409     lsl     r1,r1,10h                               
080464D6 0C09     lsr     r1,r1,10h                               
080464D8 89FA     ldrh    r2,[r7,0Eh]   ;左部分界                          
080464DA 189A     add     r2,r3,r2                                
080464DC 0412     lsl     r2,r2,10h                               
080464DE 0C12     lsr     r2,r2,10h                               
080464E0 8A3C     ldrh    r4,[r7,10h]   ;右部分界                          
080464E2 191B     add     r3,r3,r4                                
080464E4 041B     lsl     r3,r3,10h                               
080464E6 0C1B     lsr     r3,r3,10h                               
080464E8 464C     mov     r4,r9                                   
080464EA 9400     str     r4,[sp]       ;SP 炸左范围 SP4炸右范围 SP8炸上范围 SBC炸下范围 R0精上界 R1精下界 R2精左界 R3精右界                         
080464EC 9601     str     r6,[sp,4h]                              
080464EE 9502     str     r5,[sp,8h]                              
080464F0 4644     mov     r4,r8                                   
080464F2 9403     str     r4,[sp,0Ch]                             
080464F4 F7C8F900 bl      checkpowerbome                                
080464F8 2800     cmp     r0,0h                                   
080464FA D00A     beq     @@end         ;没有波及则结束                         
080464FC 1C39     mov     r1,r7                                   
080464FE 3124     add     r1,24h                                  
08046500 2023     mov     r0,23h        ;pose写入23h                          
08046502 7008     strb    r0,[r1]                                 
08046504 3108     add     r1,8h                                   
08046506 2078     mov     r0,78h                                  
08046508 7008     strb    r0,[r1]       ;3000764写入78h用于计数 延缓玻璃破碎                         
0804650A 2001     mov     r0,1h                                   
0804650C 2149     mov     r1,49h        ;49h事件激活                          
0804650E F01AF9D5 bl      checkevent

@@end:                                
08046512 B004     add     sp,10h                                  
08046514 BC18     pop     r3,r4                                   
08046516 4698     mov     r8,r3                                   
08046518 46A1     mov     r9,r4                                   
0804651A BCF0     pop     r4-r7                                   
0804651C BC01     pop     r0                                      
0804651E 4700     bx      r0                                      

;pose 23h                    
0804652C B500     push    r14                                     
0804652E 4B0B     ldr     r3,=3000738h                            
08046530 1C19     mov     r1,r3                                   
08046532 312C     add     r1,2Ch                                  
08046534 7808     ldrb    r0,[r1]    ;读取3000764                              
08046536 3801     sub     r0,1h      ;减1h                             
08046538 7008     strb    r0,[r1]    ;再写入                             
0804653A 0600     lsl     r0,r0,18h                               
0804653C 0E02     lsr     r2,r0,18h                               
0804653E 2A00     cmp     r2,0h                                   
08046540 D109     bne     @@end      ;如果计数未达0则结束                             
08046542 3908     sub     r1,8h                                   
08046544 2025     mov     r0,25h     ;如果计数为0则pose写入25h                             
08046546 7008     strb    r0,[r1]                                 
08046548 4805     ldr     r0,=830D56Ch  ;写入新OAM                          
0804654A 6198     str     r0,[r3,18h]                             
0804654C 771A     strb    r2,[r3,1Ch]                             
0804654E 82DA     strh    r2,[r3,16h]   ;清零                          
08046550 4804     ldr     r0,=27Ah                                
08046552 F7BCFA61 bl      PlaySound     ;玻璃罩破碎声音

@@end:                               
08046556 BC01     pop     r0                                      
08046558 4700     bx      r0                                      

;Pose 25h                               
08046568 B510     push    r4,r14                                  
0804656A F7C9FB2D bl      checkanimation                                 
0804656E 2800     cmp     r0,0h                                   
08046570 D035     beq     @@end                                
08046572 4C1C     ldr     r4,=3000738h                            
08046574 1C21     mov     r1,r4                                   
08046576 3124     add     r1,24h                                  
08046578 2200     mov     r2,0h                                   
0804657A 2027     mov     r0,27h     ;pose写入27h                                
0804657C 7008     strb    r0,[r1]                                 
0804657E 481A     ldr     r0,=830D5CCh    ;写入新OAM                        
08046580 61A0     str     r0,[r4,18h]                             
08046582 7722     strb    r2,[r4,1Ch]                             
08046584 82E2     strh    r2,[r4,16h]                             
08046586 F7FFFE79 bl      804627Ch        ;去除砖块的例程                        
0804658A 8860     ldrh    r0,[r4,2h]                              
0804658C 381E     sub     r0,1Eh          ;Y坐标向上提1Eh                        
0804658E 88A1     ldrh    r1,[r4,4h]                              
08046590 4A16     ldr     r2,=0FFFFFED4h                          
08046592 1889     add     r1,r1,r2        ;向左12Ch                        
08046594 2235     mov     r2,35h          ;效果号                        
08046596 F00DFDA9 bl      SetGraphicsEffect                                
0804659A 8860     ldrh    r0,[r4,2h]                              
0804659C 30A0     add     r0,0A0h                                 
0804659E 88A1     ldrh    r1,[r4,4h]                              
080465A0 4A13     ldr     r2,=0FFFFFEC0h                          
080465A2 1889     add     r1,r1,r2                                
080465A4 2236     mov     r2,36h                                  
080465A6 F00DFDA1 bl      SetGraphicsEffect                                
080465AA 8860     ldrh    r0,[r4,2h]                              
080465AC 381E     sub     r0,1Eh                                  
080465AE 88A1     ldrh    r1,[r4,4h]                              
080465B0 2296     mov     r2,96h                                  
080465B2 0052     lsl     r2,r2,1h                                
080465B4 1889     add     r1,r1,r2                                
080465B6 2235     mov     r2,35h                                  
080465B8 F00DFD98 bl      SetGraphicsEffect                                
080465BC 8860     ldrh    r0,[r4,2h]                              
080465BE 30A0     add     r0,0A0h                                 
080465C0 88A1     ldrh    r1,[r4,4h]                              
080465C2 22A0     mov     r2,0A0h                                 
080465C4 0052     lsl     r2,r2,1h                                
080465C6 1889     add     r1,r1,r2                                
080465C8 2236     mov     r2,36h                                  
080465CA F00DFD8F bl      SetGraphicsEffect                                
080465CE 201E     mov     r0,1Eh                                  
080465D0 2181     mov     r1,81h                                  
080465D2 F00EFEB7 bl      8055344h     ;垂直震动                        
080465D6 201E     mov     r0,1Eh                                  
080465D8 2181     mov     r1,81h                                  
080465DA F00EFECD bl      8055378h     ;水平震动

@@end:                               
080465DE BC10     pop     r4                                      
080465E0 BC01     pop     r0                                      
080465E2 4700     bx      r0                                      

;pose 27h                               
080465F4 B500     push    r14                                     
080465F6 F7C9FAE7 bl      800FBC8h                                
080465FA 2800     cmp     r0,0h       ;检查动画是否结束                            
080465FC D009     beq     @@end                                
080465FE 4906     ldr     r1,=3000738h                            
08046600 1C0A     mov     r2,r1                                   
08046602 3224     add     r2,24h                                  
08046604 2300     mov     r3,0h                                   
08046606 200F     mov     r0,0Fh                                  
08046608 7010     strb    r0,[r2]     ;pose 写入Fh                              
0804660A 4804     ldr     r0,=830D664h  ;新OAM                          
0804660C 6188     str     r0,[r1,18h]                             
0804660E 770B     strb    r3,[r1,1Ch]                             
08046610 82CB     strh    r3,[r1,16h]  

@@end:                           
08046612 BC01     pop     r0                                      
08046614 4700     bx      r0                                      

////////////////////////////////////////////////////////////////////////////////////
;主程序                              
08046620 B500     push    r14                                     
08046622 4807     ldr     r0,=3000738h                            
08046624 1C02     mov     r2,r0                                   
08046626 3226     add     r2,26h                                  
08046628 2101     mov     r1,1h    ;300075e写入1h                               
0804662A 7011     strb    r1,[r2]                                 
0804662C 3024     add     r0,24h                                  
0804662E 7800     ldrb    r0,[r0]  ;pose值                               
08046630 2827     cmp     r0,27h                                  
08046632 D867     bhi     @@end                                
08046634 0080     lsl     r0,r0,2h                                
08046636 4903     ldr     r1,=PoseTable                           
08046638 1840     add     r0,r0,r1                                
0804663A 6800     ldr     r0,[r0]                                 
0804663C 4687     mov     r15,r0                                  
                              
PoseTable:
    .word 80466e8h ;00
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h
	.word 80466eeh ;09h
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h 
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h
	.word 8046704h .word 8046704h .word 8046704h .word 8046704h
	.word 8046704h 
    .word 80466f4h ;23h
    .word 8046704h 
	.word 80466fah ;25h
	.word 8046704h
	.word 8046700h ;27h
    	
080466E8 F7FFFE78 bl      80463DCh ;00                               
080466EC E00A     b       @@end                                
080466EE F7FFFEBD bl      804646Ch ;09h                               
080466F2 E007     b       @@end                                
080466F4 F7FFFF1A bl      804652Ch ;23h                               
080466F8 E004     b       @@end                                
080466FA F7FFFF35 bl      8046568h ;25h                              
080466FE E001     b       @@end                                
08046700 F7FFFF78 bl      80465F4h ;27h

@@end:                                
08046704 BC01     pop     r0                                      
bx r0
///////////////////////////////////////////////////////////////////////////////////////////

;管道已经破了经历的程序
0804627C B5F0     push    r4-r7,r14                               
0804627E 4657     mov     r7,r10                                  
08046280 464E     mov     r6,r9                                   
08046282 4645     mov     r5,r8                                   
08046284 B4E0     push    r5-r7                                   
08046286 B088     add     sp,-20h                                 
08046288 4850     ldr     r0,=3000738h                            
0804628A 8846     ldrh    r6,[r0,2h]                              
0804628C 3E20     sub     r6,20h       ;垂直坐标上抬半格                           
0804628E 0436     lsl     r6,r6,10h                               
08046290 0C36     lsr     r6,r6,10h                               
08046292 8887     ldrh    r7,[r0,4h]   ;水平坐标                           
08046294 2501     mov     r5,1h                                   
08046296 4C4E     ldr     r4,=3000079h ;1是写入空气?                           
08046298 7025     strb    r5,[r4]                                 
0804629A 2040     mov     r0,40h                                  
0804629C 4240     neg     r0,r0        ;FFC0h                           
0804629E 1980     add     r0,r0,r6     ;相当于下3格                           
080462A0 4680     mov     r8,r0                                   
080462A2 1C39     mov     r1,r7                                   
080462A4 F011FDEA bl      blockmake                                
080462A8 7025     strb    r5,[r4]                                 
080462AA 1C38     mov     r0,r7                                   
080462AC 3840     sub     r0,40h                                  
080462AE 9000     str     r0,[sp]                                 
080462B0 4640     mov     r0,r8                                   
080462B2 9900     ldr     r1,[sp]                                 
080462B4 F011FDE2 bl      blockmake                                
080462B8 7025     strb    r5,[r4]                                 
080462BA 1C38     mov     r0,r7                                   
080462BC 3880     sub     r0,80h                                  
080462BE 9001     str     r0,[sp,4h]                              
080462C0 4640     mov     r0,r8                                   
080462C2 9901     ldr     r1,[sp,4h]                              
080462C4 F011FDDA bl      blockmake                                
080462C8 7025     strb    r5,[r4]                                 
080462CA 1C38     mov     r0,r7                                   
080462CC 38C0     sub     r0,0C0h                                 
080462CE 9002     str     r0,[sp,8h]                              
080462D0 4640     mov     r0,r8                                   
080462D2 9902     ldr     r1,[sp,8h]                              
080462D4 F011FDD2 bl      blockmake                                
080462D8 7025     strb    r5,[r4]                                 
080462DA 483E     ldr     r0,=0FFFFFF00h                          
080462DC 1838     add     r0,r7,r0                                
080462DE 9003     str     r0,[sp,0Ch]                             
080462E0 4640     mov     r0,r8                                   
080462E2 9903     ldr     r1,[sp,0Ch]                             
080462E4 F011FDCA bl      blockmake                                
080462E8 7025     strb    r5,[r4]                                 
080462EA 483B     ldr     r0,=0FFFFFEC0h                          
080462EC 1838     add     r0,r7,r0                                
080462EE 9004     str     r0,[sp,10h]                             
080462F0 4640     mov     r0,r8                                   
080462F2 9904     ldr     r1,[sp,10h]                             
080462F4 F011FDC2 bl      blockmake                                
080462F8 7025     strb    r5,[r4]                                 
080462FA 1C38     mov     r0,r7                                   
080462FC 3040     add     r0,40h                                  
080462FE 9005     str     r0,[sp,14h]                             
08046300 4640     mov     r0,r8                                   
08046302 9905     ldr     r1,[sp,14h]                             
08046304 F011FDBA bl      blockmake                                
08046308 7025     strb    r5,[r4]                                 
0804630A 1C38     mov     r0,r7                                   
0804630C 3080     add     r0,80h                                  
0804630E 9006     str     r0,[sp,18h]                             
08046310 4640     mov     r0,r8                                   
08046312 9906     ldr     r1,[sp,18h]                             
08046314 F011FDB2 bl      blockmake                                
08046318 7025     strb    r5,[r4]                                 
0804631A 1C38     mov     r0,r7                                   
0804631C 30C0     add     r0,0C0h                                 
0804631E 9007     str     r0,[sp,1Ch]                             
08046320 4640     mov     r0,r8                                   
08046322 9907     ldr     r1,[sp,1Ch]                             
08046324 F011FDAA bl      blockmake                                
08046328 7025     strb    r5,[r4]                                 
0804632A 2080     mov     r0,80h                                  
0804632C 0040     lsl     r0,r0,1h                                
0804632E 19C0     add     r0,r0,r7                                
08046330 4682     mov     r10,r0                                  
08046332 4640     mov     r0,r8                                   
08046334 4651     mov     r1,r10                                  
08046336 F011FDA1 bl      blockmake                                
0804633A 7025     strb    r5,[r4]                                 
0804633C 20A0     mov     r0,0A0h                                 
0804633E 0040     lsl     r0,r0,1h                                
08046340 19C0     add     r0,r0,r7                                
08046342 4681     mov     r9,r0                                   
08046344 4640     mov     r0,r8                                   
08046346 4649     mov     r1,r9                                   
08046348 F011FD98 bl      blockmake                                
0804634C 7025     strb    r5,[r4]                                 
0804634E 36C0     add     r6,0C0h                                 
08046350 1C30     mov     r0,r6                                   
08046352 1C39     mov     r1,r7                                   
08046354 F011FD92 bl      blockmake                                
08046358 7025     strb    r5,[r4]                                 
0804635A 1C30     mov     r0,r6                                   
0804635C 9900     ldr     r1,[sp]                                 
0804635E F011FD8D bl      blockmake                                
08046362 7025     strb    r5,[r4]                                 
08046364 1C30     mov     r0,r6                                   
08046366 9901     ldr     r1,[sp,4h]                              
08046368 F011FD88 bl      blockmake                                
0804636C 7025     strb    r5,[r4]                                 
0804636E 1C30     mov     r0,r6                                   
08046370 9902     ldr     r1,[sp,8h]                              
08046372 F011FD83 bl      blockmake                                
08046376 7025     strb    r5,[r4]                                 
08046378 1C30     mov     r0,r6                                   
0804637A 9903     ldr     r1,[sp,0Ch]                             
0804637C F011FD7E bl      blockmake                                
08046380 7025     strb    r5,[r4]                                 
08046382 1C30     mov     r0,r6                                   
08046384 9904     ldr     r1,[sp,10h]                             
08046386 F011FD79 bl      blockmake                                
0804638A 7025     strb    r5,[r4]                                 
0804638C 1C30     mov     r0,r6                                   
0804638E 9905     ldr     r1,[sp,14h]                             
08046390 F011FD74 bl      blockmake                                
08046394 7025     strb    r5,[r4]                                 
08046396 1C30     mov     r0,r6                                   
08046398 9906     ldr     r1,[sp,18h]                             
0804639A F011FD6F bl      blockmake                                
0804639E 7025     strb    r5,[r4]                                 
080463A0 1C30     mov     r0,r6                                   
080463A2 9907     ldr     r1,[sp,1Ch]                             
080463A4 F011FD6A bl      blockmake                                
080463A8 7025     strb    r5,[r4]                                 
080463AA 1C30     mov     r0,r6                                   
080463AC 4651     mov     r1,r10                                  
080463AE F011FD65 bl      blockmake                                
080463B2 7025     strb    r5,[r4]                                 
080463B4 1C30     mov     r0,r6                                   
080463B6 4649     mov     r1,r9                                   
080463B8 F011FD60 bl      blockmake                                
080463BC B008     add     sp,20h                                  
080463BE BC38     pop     r3-r5                                   
080463C0 4698     mov     r8,r3                                   
080463C2 46A1     mov     r9,r4                                   
080463C4 46AA     mov     r10,r5                                  
080463C6 BCF0     pop     r4-r7                                   
080463C8 BC01     pop     r0                                      
080463CA 4700     bx      r0                                      

;
08055344 B510     push    r4,r14                                  
08055346 0600     lsl     r0,r0,18h                               
08055348 0E02     lsr     r2,r0,18h  ;1Eh                             
0805534A 0609     lsl     r1,r1,18h                               
0805534C 0E0C     lsr     r4,r1,18h  ;81h                             
0805534E 4B08     ldr     r3,=3000110h                            
08055350 2A00     cmp     r2,0h                                   
08055352 D009     beq     @@end                                
08055354 7818     ldrb    r0,[r3]                                 
08055356 4282     cmp     r2,r0                                   
08055358 D906     bls     @@end                                
0805535A 2100     mov     r1,0h                                   
0805535C 701A     strb    r2,[r3]                                 
0805535E 7059     strb    r1,[r3,1h]                              
08055360 709C     strb    r4,[r3,2h]                              
08055362 70D9     strb    r1,[r3,3h]                              
08055364 4803     ldr     r0,=3000072h                            
08055366 7001     strb    r1,[r0]  

@@end:                               
08055368 7818     ldrb    r0,[r3]                                 
0805536A BC10     pop     r4                                      
0805536C BC02     pop     r1                                      
0805536E 4708     bx      r1                                      

;                               
08055378 B510     push    r4,r14                                  
0805537A 0600     lsl     r0,r0,18h                               
0805537C 0E02     lsr     r2,r0,18h                               
0805537E 0609     lsl     r1,r1,18h                               
08055380 0E0C     lsr     r4,r1,18h                               
08055382 4B08     ldr     r3,=3000114h                            
08055384 2A00     cmp     r2,0h                                   
08055386 D009     beq     805539Ch                                
08055388 7818     ldrb    r0,[r3]                                 
0805538A 4282     cmp     r2,r0                                   
0805538C D906     bls     805539Ch                                
0805538E 2100     mov     r1,0h                                   
08055390 701A     strb    r2,[r3]                                 
08055392 7059     strb    r1,[r3,1h]                              
08055394 709C     strb    r4,[r3,2h]                              
08055396 70D9     strb    r1,[r3,3h]                              
08055398 4803     ldr     r0,=3000071h                            
0805539A 7001     strb    r1,[r0]                                 
0805539C 7818     ldrb    r0,[r3]                                 
0805539E BC10     pop     r4                                      
080553A0 BC02     pop     r1                                      
080553A2 4708     bx      r1                                      
                              
080553AC B500     push    r14                                     
080553AE 0600     lsl     r0,r0,18h                               
080553B0 0E02     lsr     r2,r0,18h                               
080553B2 4B08     ldr     r3,=3000114h                            
080553B4 2A00     cmp     r2,0h                                   
080553B6 D009     beq     80553CCh                                
080553B8 7818     ldrb    r0,[r3]                                 
080553BA 4282     cmp     r2,r0                                   
080553BC D906     bls     80553CCh                                
080553BE 2100     mov     r1,0h                                   
080553C0 701A     strb    r2,[r3]                                 
080553C2 7059     strb    r1,[r3,1h]                              
080553C4 7099     strb    r1,[r3,2h]                              
080553C6 70D9     strb    r1,[r3,3h]                              
080553C8 4803     ldr     r0,=3000071h                            
080553CA 7001     strb    r1,[r0]                                 
080553CC 7818     ldrb    r0,[r3]                                 
080553CE BC02     pop     r1                                      
080553D0 4708     bx      r1                                      

;
080540EC B5F0     push    r4-r7,r14                               
080540EE 4647     mov     r7,r8                                   
080540F0 B480     push    r7                                      
080540F2 0400     lsl     r0,r0,10h                               
080540F4 0C00     lsr     r0,r0,10h                               
080540F6 4684     mov     r12,r0         ;Y坐标                         
080540F8 0409     lsl     r1,r1,10h                               
080540FA 0C0F     lsr     r7,r1,10h      ;X坐标                         
080540FC 0612     lsl     r2,r2,18h                               
080540FE 0E12     lsr     r2,r2,18h                               
08054100 4690     mov     r8,r2          ;效果                          
08054102 2200     mov     r2,0h                                   
08054104 4B1F     ldr     r3,=3000840h                            
08054106 1C18     mov     r0,r3                                   
08054108 30C0     add     r0,0C0h        ;3000900h                          
0805410A 1C19     mov     r1,r3                                   
0805410C 4283     cmp     r3,r0                                   
0805410E D20A     bcs     @@dataover                                
08054110 7818     ldrb    r0,[r3]                                 
08054112 2800     cmp     r0,0h                                   
08054114 D023     beq     @@statuszero

@@loop:                                
08054116 330C     add     r3,0Ch                                  
08054118 481B     ldr     r0,=3000900h                            
0805411A 4283     cmp     r3,r0                                   
0805411C D203     bcs     @@dataover                                
0805411E 7818     ldrb    r0,[r3]                                 
08054120 2800     cmp     r0,0h                                          
08054122 D1F8     bne     @@loop       ;状态非0则继续循环                       
08054124 2201     mov     r2,1h        

@@dataover:                               
08054126 2A00     cmp     r2,0h         ;状态是0则r2为1,跳转                           
08054128 D119     bne     @@statuszero                                
0805412A 2400     mov     r4,0h                                   
0805412C 1C0B     mov     r3,r1                                   
0805412E 1C1D     mov     r5,r3                                   
08054130 1C18     mov     r0,r3                                   
08054132 30C0     add     r0,0C0h                                 
08054134 4283     cmp     r3,r0                                   
08054136 D20F     bcs     @@overdata                                
08054138 1C06     mov     r6,r0         ;900h                            
0805413A 7898     ldrb    r0,[r3,2h]                              
0805413C 2100     mov     r1,0h                                   
0805413E 283A     cmp     r0,3Ah        ;效果号比较                          
08054140 D800     bhi     @@morethan3a                                
08054142 7919     ldrb    r1,[r3,4h]    ;帧数

@@morethan3a:                              
08054144 428A     cmp     r2,r1                                   
08054146 D204     bcs     @@next                                
08054148 1C0A     mov     r2,r1                                   
0805414A 1C1D     mov     r5,r3                                   
0805414C 1C60     add     r0,r4,1                                 
0805414E 0600     lsl     r0,r0,18h                               
08054150 0E04     lsr     r4,r0,18h 

@@next:                              
08054152 330C     add     r3,0Ch                                  
08054154 42B3     cmp     r3,r6                                   
08054156 D3F0     bcc     805413Ah 

@@overdata:                               
08054158 2C00     cmp     r4,0h                                   
0805415A D00D     beq     @@end                                
0805415C 1C2B     mov     r3,r5 

@@statuszero:                                  
0805415E 2000     mov     r0,0h                                   
08054160 2101     mov     r1,1h                                   
08054162 7019     strb    r1,[r3]                                 
08054164 2100     mov     r1,0h                                   
08054166 4662     mov     r2,r12                                  
08054168 811A     strh    r2,[r3,8h]                              
0805416A 815F     strh    r7,[r3,0Ah]                             
0805416C 80D8     strh    r0,[r3,6h]                              
0805416E 7059     strb    r1,[r3,1h]                              
08054170 4640     mov     r0,r8                                   
08054172 7098     strb    r0,[r3,2h]                              
08054174 70D9     strb    r1,[r3,3h]                              
08054176 7119     strb    r1,[r3,4h] 

@@end:                             
08054178 BC08     pop     r3                                      
0805417A 4698     mov     r8,r3                                   
0805417C BCF0     pop     r4-r7                                   
0805417E BC01     pop     r0                                      
08054180 4700     bx      r0                                      
