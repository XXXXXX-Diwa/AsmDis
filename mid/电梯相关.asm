080581A2 B4C0     push    r6,r7                                   
080581A4 480E     ldr     r0,=3000198h                            
080581A6 2100     mov     r1,0h                                   
080581A8 7081     strb    r1,[r0,2h]    ;电梯值写入0                          
080581AA 2200     mov     r2,0h                                   
080581AC 8001     strh    r1,[r0]                                 
080581AE 70C2     strb    r2,[r0,3h]    ;电梯的方向标记为0                          
080581B0 2400     mov     r4,0h                                   
080581B2 2508     mov     r5,8h                                   
080581B4 480B     ldr     r0,=3000054h                            
080581B6 4681     mov     r9,r0                                   
080581B8 490B     ldr     r1,=8345934h                            
080581BA 4688     mov     r8,r1                                   
080581BC 4646     mov     r6,r8                                   
080581BE 3644     add     r6,44h                                  
080581C0 2740     mov     r7,40h                                  
080581C2 4808     ldr     r0,=3000054h                            
080581C4 4908     ldr     r1,=8345934h                            
080581C6 1879     add     r1,r7,r1                                
080581C8 7800     ldrb    r0,[r0]       ;读取区号                            
080581CA 780A     ldrb    r2,[r1]       ;读取偏移数据 5                         
080581CC 4290     cmp     r0,r2         ;两者比较                          
080581CE D10F     bne     80581F0h                                
080581D0 4806     ldr     r0,=3000055h                            
080581D2 7800     ldrb    r0,[r0]                                 
080581D4 7849     ldrb    r1,[r1,1h]                              
080581D6 4288     cmp     r0,r1                                   
080581D8 D10A     bne     @@AreaNoFive                               
080581DA 2401     mov     r4,1h                                   
080581DC E016     b       @@Goto                               

;------------------------------------区域非5
@@AreaNoFive:                              
080581F0 4649     mov     r1,r9                                   
080581F2 7808     ldrb    r0,[r1]   ;区号                               
080581F4 7832     ldrb    r2,[r6]   ;读取偏移数据 4                              
080581F6 4290     cmp     r0,r2     ;两者比较                              
080581F8 D106     bne     @@Pass                                
080581FA 480B     ldr     r0,=3000055h                            
080581FC 7800     ldrb    r0,[r0]                                 
080581FE 7871     ldrb    r1,[r6,1h]  ;读取房间值数据比较                            
08058200 4288     cmp     r0,r1                                   
08058202 D101     bne     @@Pass    
;----------------------------------;如果是母脑区的8房间的电梯则r4取反..                            
08058204 2401     mov     r4,1h                                   
08058206 4264     neg     r4,r4   

@@Pass:                                
08058208 2C00     cmp     r4,0h                                   
0805820A D019     beq     8058240h 
;----------------------------------区域5
@@Goto:                               
0805820C 2D08     cmp     r5,8h                                   
0805820E D10E     bne     805822Eh                                
08058210 2003     mov     r0,3h                                   
08058212 2141     mov     r1,41h                                  
08058214 F008FB52 bl      80608BCh                                
08058218 2800     cmp     r0,0h                                   
0805821A D007     beq     805822Ch                                
0805821C 4646     mov     r6,r8                                   
0805821E 3634     add     r6,34h                                  
08058220 2730     mov     r7,30h                                  
08058222 2506     mov     r5,6h                                   
08058224 E003     b       805822Eh                                
08058226 0000     lsl     r0,r0,0h                                
08058228 0055     lsl     r5,r2,1h                                
0805822A 0300     lsl     r0,r0,0Ch                               
0805822C 2400     mov     r4,0h                                   
0805822E 2C00     cmp     r4,0h                                   
08058230 D006     beq     8058240h                                
08058232 4802     ldr     r0,=3000198h                            
08058234 7085     strb    r5,[r0,2h]    ;写入电梯序号                            
08058236 70C4     strb    r4,[r0,3h]                              
08058238 E007     b       805824Ah                                
0805823A 0000     lsl     r0,r0,0h                                
0805823C 0198     lsl     r0,r3,6h                                
0805823E 0300     lsl     r0,r0,0Ch                               
08058240 3E08     sub     r6,8h                                   
08058242 3F08     sub     r7,8h                                   
08058244 3D01     sub     r5,1h                                   
08058246 2D00     cmp     r5,0h                                   
08058248 DCBB     bgt     80581C2h                                
0805824A 2000     mov     r0,0h                                   
0805824C 2C00     cmp     r4,0h                                   
0805824E D100     bne     8058252h                                
08058250 2001     mov     r0,1h                                   
08058252 1C04     mov     r4,r0                                   
08058254 BC18     pop     r3,r4                                   
08058256 4698     mov     r8,r3                                   
08058258 46A1     mov     r9,r4                                   
0805825A BCF0     pop     r4-r7                                   
0805825C BC02     pop     r1                                      
0805825E 4708     bx      r1                                      
08058260 B500     push    r14                                     
08058262 0400     lsl     r0,r0,10h                               
08058264 0409     lsl     r1,r1,10h                               
08058266 0D83     lsr     r3,r0,16h                               
08058268 0D89     lsr     r1,r1,16h                               
0805826A 4A04     ldr     r2,=300009Ch                            
0805826C 8BD0     ldrh    r0,[r2,1Eh]                             
0805826E 4283     cmp     r3,r0                                   
08058270 DA02     bge     8058278h                                
08058272 8B90     ldrh    r0,[r2,1Ch]                             
08058274 4281     cmp     r1,r0                                   
08058276 DB03     blt     8058280h                                
08058278 2000     mov     r0,0h                                   
0805827A E021     b       80582C0h                                
0805827C 009C     lsl     r4,r3,2h                                
0805827E 0300     lsl     r0,r0,0Ch                               
08058280 4358     mul     r0,r3                                   
08058282 1840     add     r0,r0,r1                                
08058284 6991     ldr     r1,[r2,18h]                             
08058286 0040     lsl     r0,r0,1h                                
08058288 1840     add     r0,r0,r1                                
0805828A 8802     ldrh    r2,[r0]                                 
0805828C 2080     mov     r0,80h                                  
0805828E 00C0     lsl     r0,r0,3h                                
08058290 4010     and     r0,r2                                   
08058292 2800     cmp     r0,0h                                   
08058294 D001     beq     805829Ah                                
08058296 2200     mov     r2,0h                                   
08058298 E004     b       80582A4h                                
0805829A 4806     ldr     r0,=3005450h                            
0805829C 6881     ldr     r1,[r0,8h]                              
0805829E 0050     lsl     r0,r2,1h                                
080582A0 1840     add     r0,r0,r1                                
080582A2 8802     ldrh    r2,[r0]                                 
080582A4 1C11     mov     r1,r2                                   
080582A6 3950     sub     r1,50h                                  
080582A8 2904     cmp     r1,4h                                   
080582AA D807     bhi     80582BCh                                
080582AC 4802     ldr     r0,=834592Ch                            
080582AE 1808     add     r0,r1,r0                                
080582B0 7802     ldrb    r2,[r0]                                 
080582B2 E004     b       80582BEh                                
080582B4 5450     strb    r0,[r2,r1]                              
080582B6 0300     lsl     r0,r0,0Ch                               
080582B8 592C     ldr     r4,[r5,r4]                              
080582BA 0834     lsr     r4,r6,20h                               
080582BC 2200     mov     r2,0h                                   
080582BE 1C10     mov     r0,r2                                   
080582C0 BC02     pop     r1                                      
080582C2 4708     bx      r1                                      
080582C4 B5F0     push    r4-r7,r14                               
080582C6 1C05     mov     r5,r0                                   
080582C8 F000F906 bl      80584D8h                                
080582CC 4814     ldr     r0,=3000144h                            
080582CE 8807     ldrh    r7,[r0]                                 
080582D0 8846     ldrh    r6,[r0,2h]                              
080582D2 4C14     ldr     r4,=3000118h                            
080582D4 7820     ldrb    r0,[r4]                                 
080582D6 2800     cmp     r0,0h                                   
080582D8 D009     beq     80582EEh                                
080582DA 1C20     mov     r0,r4                                   
080582DC 1C29     mov     r1,r5                                   
080582DE F000F881 bl      80583E4h                                
080582E2 1C07     mov     r7,r0                                   
080582E4 1C20     mov     r0,r4                                   
080582E6 1C29     mov     r1,r5                                   
080582E8 F000F89C bl      8058424h                                
080582EC 1C06     mov     r6,r0                                   
080582EE 340C     add     r4,0Ch                                  
080582F0 7820     ldrb    r0,[r4]                                 
080582F2 2800     cmp     r0,0h                                   
080582F4 D00B     beq     805830Eh                                
080582F6 1C20     mov     r0,r4                                   
080582F8 1C29     mov     r1,r5                                   
080582FA F000F873 bl      80583E4h                                
080582FE 1838     add     r0,r7,r0                                
08058300 1047     asr     r7,r0,1h                                
08058302 1C20     mov     r0,r4                                   
08058304 1C29     mov     r1,r5                                   
08058306 F000F88D bl      8058424h                                
0805830A 1830     add     r0,r6,r0                                
0805830C 1046     asr     r6,r0,1h                                
0805830E 0438     lsl     r0,r7,10h                               
08058310 0C00     lsr     r0,r0,10h                               
08058312 0431     lsl     r1,r6,10h                               
08058314 0C09     lsr     r1,r1,10h                               
08058316 F000F807 bl      8058328h                                
0805831A BCF0     pop     r4-r7                                   
0805831C BC01     pop     r0                                      
0805831E 4700     bx      r0                                      
08058320 0144     lsl     r4,r0,5h                                
08058322 0300     lsl     r0,r0,0Ch                               
08058324 0118     lsl     r0,r3,4h                                
08058326 0300     lsl     r0,r0,0Ch                               
08058328 B530     push    r4,r5,r14                               
0805832A 0400     lsl     r0,r0,10h                               
0805832C 0C04     lsr     r4,r0,10h                               
0805832E 0409     lsl     r1,r1,10h                               
08058330 0C0A     lsr     r2,r1,10h                               
08058332 490C     ldr     r1,=3000144h                            
08058334 800C     strh    r4,[r1]                                 
08058336 804A     strh    r2,[r1,2h]                              
08058338 480B     ldr     r0,=3000C72h                            
0805833A 2300     mov     r3,0h                                   
0805833C 5EC0     ldsh    r0,[r0,r3]                              
0805833E 1C0D     mov     r5,r1                                   
08058340 2800     cmp     r0,0h                                   
08058342 D04B     beq     80583DCh                                
08058344 4809     ldr     r0,=30013BAh                            
08058346 1C03     mov     r3,r0                                   
08058348 8818     ldrh    r0,[r3]                                 
0805834A 4282     cmp     r2,r0                                   
0805834C D020     beq     8058390h                                
0805834E 8818     ldrh    r0,[r3]                                 
08058350 1A11     sub     r1,r2,r0                                
08058352 2900     cmp     r1,0h                                   
08058354 DD0E     ble     8058374h                                
08058356 4806     ldr     r0,=3005714h                            
08058358 2206     mov     r2,6h                                   
0805835A 5E80     ldsh    r0,[r0,r2]                              
0805835C 4288     cmp     r0,r1                                   
0805835E DA0F     bge     8058380h                                
08058360 E00D     b       805837Eh                                
08058362 0000     lsl     r0,r0,0h                                
08058364 0144     lsl     r4,r0,5h                                
08058366 0300     lsl     r0,r0,0Ch                               
08058368 0C72     lsr     r2,r6,11h                               
0805836A 0300     lsl     r0,r0,0Ch                               
0805836C 13BA     asr     r2,r7,0Eh                               
0805836E 0300     lsl     r0,r0,0Ch                               
08058370 5714     ldsb    r4,[r2,r4]                              
08058372 0300     lsl     r0,r0,0Ch                               
08058374 4805     ldr     r0,=3005714h                            
08058376 2204     mov     r2,4h                                   
08058378 5E80     ldsh    r0,[r0,r2]                              
0805837A 4288     cmp     r0,r1                                   
0805837C DD00     ble     8058380h                                
0805837E 1C01     mov     r1,r0                                   
08058380 7169     strb    r1,[r5,5h]                              
08058382 8818     ldrh    r0,[r3]                                 
08058384 1840     add     r0,r0,r1                                
08058386 8018     strh    r0,[r3]                                 
08058388 E004     b       8058394h                                
0805838A 0000     lsl     r0,r0,0h                                
0805838C 5714     ldsb    r4,[r2,r4]                              
0805838E 0300     lsl     r0,r0,0Ch                               
08058390 2000     mov     r0,0h                                   
08058392 7168     strb    r0,[r5,5h]                              
08058394 4807     ldr     r0,=30013B8h                            
08058396 1C02     mov     r2,r0                                   
08058398 8813     ldrh    r3,[r2]                                 
0805839A 429C     cmp     r4,r3                                   
0805839C D01C     beq     80583D8h                                
0805839E 8810     ldrh    r0,[r2]                                 
080583A0 1A21     sub     r1,r4,r0                                
080583A2 2900     cmp     r1,0h                                   
080583A4 DD0A     ble     80583BCh                                
080583A6 4804     ldr     r0,=3005714h                            
080583A8 2302     mov     r3,2h                                   
080583AA 5EC0     ldsh    r0,[r0,r3]                              
080583AC 4288     cmp     r0,r1                                   
080583AE DA0B     bge     80583C8h                                
080583B0 E009     b       80583C6h                                
080583B2 0000     lsl     r0,r0,0h                                
080583B4 13B8     asr     r0,r7,0Eh                               
080583B6 0300     lsl     r0,r0,0Ch                               
080583B8 5714     ldsb    r4,[r2,r4]                              
080583BA 0300     lsl     r0,r0,0Ch                               
080583BC 4805     ldr     r0,=3005714h                            
080583BE 2300     mov     r3,0h                                   
080583C0 5EC0     ldsh    r0,[r0,r3]                              
080583C2 4288     cmp     r0,r1                                   
080583C4 DD00     ble     80583C8h                                
080583C6 1C01     mov     r1,r0                                   
080583C8 7129     strb    r1,[r5,4h]                              
080583CA 8810     ldrh    r0,[r2]                                 
080583CC 1840     add     r0,r0,r1                                
080583CE 8010     strh    r0,[r2]                                 
080583D0 E004     b       80583DCh                                
080583D2 0000     lsl     r0,r0,0h                                
080583D4 5714     ldsb    r4,[r2,r4]                              
080583D6 0300     lsl     r0,r0,0Ch                               
080583D8 2000     mov     r0,0h                                   
080583DA 7128     strb    r0,[r5,4h]                              
080583DC BC30     pop     r4,r5                                   
080583DE BC01     pop     r0                                      
080583E0 4700     bx      r0                                      
080583E2 0000     lsl     r0,r0,0h                                
080583E4 B510     push    r4,r14                                  
080583E6 1C03     mov     r3,r0                                   
080583E8 8809     ldrh    r1,[r1]                                 
080583EA 889A     ldrh    r2,[r3,4h]                              
080583EC 24F0     mov     r4,0F0h                                 
080583EE 0064     lsl     r4,r4,1h                                
080583F0 1910     add     r0,r2,r4                                
080583F2 4281     cmp     r1,r0                                   
080583F4 DA01     bge     80583FAh                                
080583F6 1C10     mov     r0,r2                                   
080583F8 E00E     b       8058418h                                
080583FA 885A     ldrh    r2,[r3,2h]                              
080583FC 4B03     ldr     r3,=0FFFFFE20h                          
080583FE 18D0     add     r0,r2,r3                                
08058400 4281     cmp     r1,r0                                   
08058402 DD07     ble     8058414h                                
08058404 4C02     ldr     r4,=0FFFFFC40h                          
08058406 1910     add     r0,r2,r4                                
08058408 E006     b       8058418h                                
0805840A 0000     lsl     r0,r0,0h                                
0805840C FE20     bl      lr+0C40h                                
0805840E FFFF     bl      lr+0FFEh                                
08058410 FC40     bl      lr+880h                                 
08058412 FFFF     bl      lr+0FFEh                                
08058414 4A02     ldr     r2,=0FFFFFE20h                          
08058416 1888     add     r0,r1,r2                                
08058418 BC10     pop     r4                                      
0805841A BC02     pop     r1                                      
0805841C 4708     bx      r1                                      
0805841E 0000     lsl     r0,r0,0h                                
08058420 FE20     bl      lr+0C40h                                
08058422 FFFF     bl      lr+0FFEh                                
08058424 B510     push    r4,r14                                  
08058426 1C02     mov     r2,r0                                   
08058428 7810     ldrb    r0,[r2]                                 
0805842A 2802     cmp     r0,2h                                   
0805842C D11C     bne     8058468h                                
0805842E 8849     ldrh    r1,[r1,2h]                              
08058430 88D3     ldrh    r3,[r2,6h]                              
08058432 24C0     mov     r4,0C0h                                 
08058434 0064     lsl     r4,r4,1h                                
08058436 1918     add     r0,r3,r4                                
08058438 4281     cmp     r1,r0                                   
0805843A DB08     blt     805844Eh                                
0805843C 8912     ldrh    r2,[r2,8h]                              
0805843E 4C05     ldr     r4,=0FFFFFF00h                          
08058440 1910     add     r0,r2,r4                                
08058442 4281     cmp     r1,r0                                   
08058444 DD0A     ble     805845Ch                                
08058446 4904     ldr     r1,=0FFFFFD80h                          
08058448 1850     add     r0,r2,r1                                
0805844A 4298     cmp     r0,r3                                   
0805844C DA0F     bge     805846Eh                                
0805844E 1C18     mov     r0,r3                                   
08058450 E00D     b       805846Eh                                
08058452 0000     lsl     r0,r0,0h                                
08058454 FF00     bl      lr+0E00h                                
08058456 FFFF     bl      lr+0FFEh                                
08058458 FD80     bl      lr+0B00h                                
0805845A FFFF     bl      lr+0FFEh                                
0805845C 4A01     ldr     r2,=0FFFFFE80h                          
0805845E 1888     add     r0,r1,r2                                
08058460 E005     b       805846Eh                                
08058462 0000     lsl     r0,r0,0h                                
08058464 FE80     bl      lr+0D00h                                
08058466 FFFF     bl      lr+0FFEh                                
08058468 8910     ldrh    r0,[r2,8h]                              
0805846A 4C02     ldr     r4,=0FFFFFD80h                          
0805846C 1900     add     r0,r0,r4                                
0805846E BC10     pop     r4                                      
08058470 BC02     pop     r1                                      
08058472 4708     bx      r1                                      
08058474 FD80     bl      lr+0B00h                                
08058476 FFFF     bl      lr+0FFEh                                
08058478 B530     push    r4,r5,r14                               
0805847A 4908     ldr     r1,=875FD28h                            
0805847C 4808     ldr     r0,=3000054h                            
0805847E 7800     ldrb    r0,[r0]                                 
08058480 0080     lsl     r0,r0,2h                                
08058482 1840     add     r0,r0,r1                                
08058484 6802     ldr     r2,[r0]                                 
08058486 6813     ldr     r3,[r2]                                 
08058488 4806     ldr     r0,=3000055h                            
0805848A 7819     ldrb    r1,[r3]                                 
0805848C 1C05     mov     r5,r0                                   
0805848E 4C06     ldr     r4,=3005708h                            
08058490 7828     ldrb    r0,[r5]                                 
08058492 4281     cmp     r1,r0                                   
08058494 D10C     bne     80584B0h                                
08058496 6023     str     r3,[r4]                                 
08058498 E015     b       80584C6h                                
0805849A 0000     lsl     r0,r0,0h                                
0805849C FD28     bl      lr+0A50h                                
0805849E 0875     lsr     r5,r6,1h                                
080584A0 0054     lsl     r4,r2,1h                                
080584A2 0300     lsl     r0,r0,0Ch                               
080584A4 0055     lsl     r5,r2,1h                                
080584A6 0300     lsl     r0,r0,0Ch                               
080584A8 5708     ldsb    r0,[r1,r4]                              
080584AA 0300     lsl     r0,r0,0Ch                               
080584AC 6021     str     r1,[r4]                                 
080584AE E00D     b       80584CCh                                
080584B0 6811     ldr     r1,[r2]                                 
080584B2 7808     ldrb    r0,[r1]                                 
080584B4 28FF     cmp     r0,0FFh                                 
080584B6 D0F9     beq     80584ACh                                
080584B8 3204     add     r2,4h                                   
080584BA 6811     ldr     r1,[r2]                                 
080584BC 7808     ldrb    r0,[r1]                                 
080584BE 782B     ldrb    r3,[r5]                                 
080584C0 4298     cmp     r0,r3                                   
080584C2 D1F5     bne     80584B0h                                
080584C4 6021     str     r1,[r4]                                 
080584C6 4903     ldr     r1,=30000BCh                            
080584C8 2003     mov     r0,3h                                   
080584CA 7148     strb    r0,[r1,5h]                              
080584CC BC30     pop     r4,r5                                   
080584CE BC01     pop     r0                                      
080584D0 4700     bx      r0                                      
080584D2 0000     lsl     r0,r0,0h                                
080584D4 00BC     lsl     r4,r7,2h                                
080584D6 0300     lsl     r0,r0,0Ch                               
080584D8 B5F0     push    r4-r7,r14                               
080584DA 464F     mov     r7,r9                                   
080584DC 4646     mov     r6,r8                                   
080584DE B4C0     push    r6,r7                                   
080584E0 B084     add     sp,-10h                                 
080584E2 4A1C     ldr     r2,=3000118h                            
080584E4 2100     mov     r1,0h                                   
080584E6 7011     strb    r1,[r2]                                 
080584E8 7311     strb    r1,[r2,0Ch]                             
080584EA 8801     ldrh    r1,[r0]                                 
080584EC 0989     lsr     r1,r1,6h                                
080584EE 4688     mov     r8,r1                                   
080584F0 8840     ldrh    r0,[r0,2h]                              
080584F2 3801     sub     r0,1h                                   
080584F4 0280     lsl     r0,r0,0Ah                               
080584F6 0C00     lsr     r0,r0,10h                               
080584F8 4684     mov     r12,r0                                  
080584FA 4817     ldr     r0,=3005708h                            
080584FC 6800     ldr     r0,[r0]                                 
080584FE 3001     add     r0,1h                                   
08058500 7805     ldrb    r5,[r0]                                 
08058502 1C44     add     r4,r0,1                                 
08058504 1C17     mov     r7,r2                                   
08058506 2D00     cmp     r5,0h                                   
08058508 D100     bne     805850Ch                                
0805850A E084     b       8058616h                                
0805850C 4E13     ldr     r6,=300009Ch                            
0805850E 46B9     mov     r9,r7                                   
08058510 4648     mov     r0,r9                                   
08058512 3018     add     r0,18h                                  
08058514 4282     cmp     r2,r0                                   
08058516 D100     bne     805851Ah                                
08058518 E088     b       805862Ch                                
0805851A 2000     mov     r0,0h                                   
0805851C 9000     str     r0,[sp]                                 
0805851E 2001     mov     r0,1h                                   
08058520 9001     str     r0,[sp,4h]                              
08058522 2002     mov     r0,2h                                   
08058524 9002     str     r0,[sp,8h]                              
08058526 2003     mov     r0,3h                                   
08058528 9003     str     r0,[sp,0Ch]                             
0805852A 7920     ldrb    r0,[r4,4h]                              
0805852C 28FF     cmp     r0,0FFh                                 
0805852E D017     beq     8058560h                                
08058530 79E0     ldrb    r0,[r4,7h]                              
08058532 28FF     cmp     r0,0FFh                                 
08058534 D014     beq     8058560h                                
08058536 7961     ldrb    r1,[r4,5h]                              
08058538 8BB0     ldrh    r0,[r6,1Ch]                             
0805853A 4348     mul     r0,r1                                   
0805853C 7921     ldrb    r1,[r4,4h]                              
0805853E 1843     add     r3,r0,r1                                
08058540 69B1     ldr     r1,[r6,18h]                             
08058542 0058     lsl     r0,r3,1h                                
08058544 1840     add     r0,r0,r1                                
08058546 8800     ldrh    r0,[r0]                                 
08058548 2800     cmp     r0,0h                                   
0805854A D11C     bne     8058586h                                
0805854C 79A0     ldrb    r0,[r4,6h]                              
0805854E 28FF     cmp     r0,0FFh                                 
08058550 D019     beq     8058586h                                
08058552 E013     b       805857Ch                                
08058554 0118     lsl     r0,r3,4h                                
08058556 0300     lsl     r0,r0,0Ch                               
08058558 5708     ldsb    r0,[r1,r4]                              
0805855A 0300     lsl     r0,r0,0Ch                               
0805855C 009C     lsl     r4,r3,2h                                
0805855E 0300     lsl     r0,r0,0Ch                               
08058560 4836     ldr     r0,=30013D4h                            
08058562 7800     ldrb    r0,[r0]                                 
08058564 281D     cmp     r0,1Dh                                  
08058566 D10E     bne     8058586h                                
08058568 79E0     ldrb    r0,[r4,7h]                              
0805856A 28FF     cmp     r0,0FFh                                 
0805856C D00B     beq     8058586h                                
0805856E 79A0     ldrb    r0,[r4,6h]                              
08058570 3802     sub     r0,2h                                   
08058572 0600     lsl     r0,r0,18h                               
08058574 0E00     lsr     r0,r0,18h                               
08058576 2801     cmp     r0,1h                                   
08058578 D805     bhi     8058586h                                
0805857A 79A0     ldrb    r0,[r4,6h]                              
0805857C 0080     lsl     r0,r0,2h                                
0805857E 466B     mov     r3,r13                                  
08058580 1819     add     r1,r3,r0                                
08058582 2007     mov     r0,7h                                   
08058584 6008     str     r0,[r1]                                 
08058586 9800     ldr     r0,[sp]                                 
08058588 1820     add     r0,r4,r0                                
0805858A 7801     ldrb    r1,[r0]                                 
0805858C 4541     cmp     r1,r8                                   
0805858E D83D     bhi     805860Ch                                
08058590 9801     ldr     r0,[sp,4h]                              
08058592 1820     add     r0,r4,r0                                
08058594 7800     ldrb    r0,[r0]                                 
08058596 4580     cmp     r8,r0                                   
08058598 D838     bhi     805860Ch                                
0805859A 9802     ldr     r0,[sp,8h]                              
0805859C 1820     add     r0,r4,r0                                
0805859E 7800     ldrb    r0,[r0]                                 
080585A0 4560     cmp     r0,r12                                  

