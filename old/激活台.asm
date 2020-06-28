

;主程序
0802E4EC B500     push    r14                                     
0802E4EE 4805     ldr     r0,=3000738h                            
0802E4F0 3024     add     r0,24h                                  
0802E4F2 7800     ldrb    r0,[r0]                                 
0802E4F4 2809     cmp     r0,9h                                   
0802E4F6 D00D     beq     @@posenine                                
0802E4F8 2809     cmp     r0,9h                                   
0802E4FA DC05     bgt     @@morethanine                                
0802E4FC 2800     cmp     r0,0h                                   
0802E4FE D006     beq     @@posezero                               
0802E500 E00D     b       @@end                                

@@morethanine:                              
0802E508 280B     cmp     r0,0Bh                                  
0802E50A D006     beq     @@poseB                               
0802E50C E007     b       @@end 

@@posezero:                               
0802E50E F7FFFEA1 bl      802E254h    ;00                            
0802E512 E004     b       @@end

@@posenine:                                
0802E514 F7FFFF0E bl      802E334h    ;9h                            
0802E518 E001     b       @@end    

@@poseB:                            
0802E51A F7FFFF69 bl      802E3F0h    ;bh

@@end:                              
0802E51E BC01     pop     r0                                      
0802E520 4700     bx      r0 
/////////////////////////////////////////////////////////////////////////////////////////////
.definelabel spawnnewsecsprite,800E258h
.definelabel checkevent,80608BCh
.definelabel makeblock,8057E7Ch
.definelabel samusposechange,80074E8h

;pose 00调用例程用于制造激活台的砖块
0802E1F0 B570     push    r4-r6,r14                               
0802E1F2 4646     mov     r6,r8                                   
0802E1F4 B440     push    r6                                      
0802E1F6 1C05     mov     r5,r0                                   
0802E1F8 062D     lsl     r5,r5,18h                               
0802E1FA 0E2D     lsr     r5,r5,18h   ;一开始设置的数                            
0802E1FC 4813     ldr     r0,=3000738h                            
0802E1FE 8844     ldrh    r4,[r0,2h]                              
0802E200 3C20     sub     r4,20h      ;垂直高度上移20h的坐标                            
0802E202 0424     lsl     r4,r4,10h                               
0802E204 0C24     lsr     r4,r4,10h                               
0802E206 8886     ldrh    r6,[r0,4h]  ;水平坐标                            
0802E208 4811     ldr     r0,=3000079h                            
0802E20A 4680     mov     r8,r0                                   
0802E20C 7005     strb    r5,[r0]     ;要造的值写入3000079h                            
0802E20E 1C20     mov     r0,r4                                   
0802E210 1C31     mov     r1,r6                                   
0802E212 F029FE33 bl      @@makeblock    ;造砖                              
0802E216 4640     mov     r0,r8                                   
0802E218 7005     strb    r5,[r0]                                 
0802E21A 1C20     mov     r0,r4                                   
0802E21C 3840     sub     r0,40h      ;垂直坐标再次向上一格的高度坐标                            
0802E21E 1C31     mov     r1,r6                                   
0802E220 F029FE2C bl      @@makeblock                                
0802E224 4640     mov     r0,r8                                   
0802E226 7005     strb    r5,[r0]                                 
0802E228 3C80     sub     r4,80h      ;垂直坐标向上两个半的高度坐标                             
0802E22A 1C31     mov     r1,r6                                   
0802E22C 3140     add     r1,40h      ;水平坐标右边一格的坐标                            
0802E22E 1C20     mov     r0,r4                                   
0802E230 F029FE24 bl      @@makeblock                                
0802E234 4640     mov     r0,r8                                   
0802E236 7005     strb    r5,[r0]                                 
0802E238 3E40     sub     r6,40h      ;水平坐标左边一格的坐标                            
0802E23A 1C20     mov     r0,r4                                   
0802E23C 1C31     mov     r1,r6                                   
0802E23E F029FE1D bl      @@makeblock                                
0802E242 BC08     pop     r3                                      
0802E244 4698     mov     r8,r3                                   
0802E246 BC70     pop     r4-r6                                   
0802E248 BC01     pop     r0                                      
0802E24A 4700     bx      r0  

;激活台pose 9激活调用例程,r0是姿势
080074E8 B5F0     push    r4-r7,r14                               
080074EA 0600     lsl     r0,r0,18h                               
080074EC 4D0D     ldr     r5,=30013D4h                            
080074EE 4E0E     ldr     r6,=30013F4h                            
080074F0 4F0E     ldr     r7,=3001414h                            
080074F2 0E04     lsr     r4,r0,18h      ;将要成为的激活姿势                         
080074F4 21E0     mov     r1,0E0h                                 
080074F6 04C9     lsl     r1,r1,13h      ;7000000h                          
080074F8 1840     add     r0,r0,r1       ;47000000h                         
080074FA 0E00     lsr     r0,r0,18h      ;47h                         
080074FC 2801     cmp     r0,1h                                   
080074FE D801     bhi     8007504h                                
08007500 2000     mov     r0,0h                                   
08007502 70E8     strb    r0,[r5,3h]                              
08007504 1C28     mov     r0,r5                                   
08007506 F000F859 bl      80075BCh                                
0800750A 78B0     ldrb    r0,[r6,2h]                              
0800750C 2805     cmp     r0,5h                                   
0800750E D101     bne     8007514h                                
08007510 2000     mov     r0,0h                                   
08007512 70B0     strb    r0,[r6,2h]                              
08007514 7830     ldrb    r0,[r6]                                 
08007516 2822     cmp     r0,22h                                  
08007518 D012     beq     8007540h                                
0800751A 2822     cmp     r0,22h                                  
0800751C DC08     bgt     8007530h                                
0800751E 2821     cmp     r0,21h                                  
08007520 D00B     beq     800753Ah                                
08007522 E01E     b       8007562h                                
08007524 13D4     asr     r4,r2,0Fh                               
08007526 0300     lsl     r0,r0,0Ch                               
08007528 13F4     asr     r4,r6,0Fh                               
0800752A 0300     lsl     r0,r0,0Ch                               
0800752C 1414     asr     r4,r2,10h                               
0800752E 0300     lsl     r0,r0,0Ch                               
08007530 2825     cmp     r0,25h                                  
08007532 D00B     beq     800754Ch                                
08007534 2826     cmp     r0,26h                                  
08007536 D00F     beq     8007558h                                
08007538 E013     b       8007562h                                
0800753A 2C22     cmp     r4,22h                                  
0800753C D011     beq     8007562h                                
0800753E E001     b       8007544h                                
08007540 2C23     cmp     r4,23h                                  
08007542 D00E     beq     8007562h                                
08007544 208E     mov     r0,8Eh                                  
08007546 F7FBFA6F bl      8002A28h                                
0800754A E00A     b       8007562h                                
0800754C 2C26     cmp     r4,26h                                  
0800754E D008     beq     8007562h                                
08007550 208F     mov     r0,8Fh                                  
08007552 F7FBFA69 bl      8002A28h                                
08007556 E004     b       8007562h                                
08007558 2C27     cmp     r4,27h                                  
0800755A D002     beq     8007562h                                
0800755C 208F     mov     r0,8Fh                                  
0800755E F7FBFA63 bl      8002A28h                                
08007562 2CFA     cmp     r4,0FAh                                 
08007564 D014     beq     8007590h                                
08007566 2CFA     cmp     r4,0FAh                                 
08007568 DC02     bgt     8007570h                                
0800756A 2CF9     cmp     r4,0F9h                                 
0800756C D016     beq     800759Ch                                
0800756E E01B     b       80075A8h                                
08007570 2CFD     cmp     r4,0FDh                                 
08007572 D007     beq     8007584h                                
08007574 2CFE     cmp     r4,0FEh                                 
08007576 D117     bne     80075A8h                                
08007578 1C28     mov     r0,r5                                   
0800757A 1C31     mov     r1,r6                                   
0800757C 1C3A     mov     r2,r7                                   
0800757E F7FFF9E7 bl      8006950h                                
08007582 E017     b       80075B4h                                
08007584 1C28     mov     r0,r5                                   
08007586 1C31     mov     r1,r6                                   
08007588 1C3A     mov     r2,r7                                   
0800758A F7FFFB4F bl      8006C2Ch                                
0800758E E011     b       80075B4h                                
08007590 1C28     mov     r0,r5                                   
08007592 1C31     mov     r1,r6                                   
08007594 1C3A     mov     r2,r7                                   
08007596 F7FFFC89 bl      8006EACh                                
0800759A E00B     b       80075B4h                                
0800759C 1C28     mov     r0,r5                                   
0800759E 1C31     mov     r1,r6                                   
080075A0 1C3A     mov     r2,r7                                   
080075A2 F7FFFD51 bl      8007048h                                
080075A6 E005     b       80075B4h                                
080075A8 702C     strb    r4,[r5]                                 
080075AA 1C28     mov     r0,r5                                   
080075AC 1C31     mov     r1,r6                                   
080075AE 1C3A     mov     r2,r7                                   
080075B0 F7FFFDD8 bl      8007164h                                
080075B4 BCF0     pop     r4-r7                                   
080075B6 BC01     pop     r0                                      
080075B8 4700     bx      r0                                      
                                    

;pose 00h
0802E254 B5F0     push    r4-r7,r14                               
0802E256 4647     mov     r7,r8                                   
0802E258 B480     push    r7                                      
0802E25A B083     add     sp,-0Ch                                 
0802E25C 4C24     ldr     r4,=3000738h                            
0802E25E 8821     ldrh    r1,[r4]                                 
0802E260 2280     mov     r2,80h                                  
0802E262 0212     lsl     r2,r2,8h                                
0802E264 1C10     mov     r0,r2                                   
0802E266 2700     mov     r7,0h                                   
0802E268 2600     mov     r6,0h                                   
0802E26A 4308     orr     r0,r1    ;8000h orr 取向                               
0802E26C 8020     strh    r0,[r4]  ;再写入                               
0802E26E 1C21     mov     r1,r4                                   
0802E270 3127     add     r1,27h                                  
0802E272 2030     mov     r0,30h                                  
0802E274 7008     strb    r0,[r1]  ;300075f写入30                               
0802E276 1C20     mov     r0,r4                                   
0802E278 3028     add     r0,28h   ;3000760写入0h                               
0802E27A 7007     strb    r7,[r0]                                 
0802E27C 3102     add     r1,2h                                   
0802E27E 2018     mov     r0,18h                                  
0802E280 7008     strb    r0,[r1]  ;3000761写入18h                               
0802E282 8166     strh    r6,[r4,0Ah]                             
0802E284 81A6     strh    r6,[r4,0Ch]                             
0802E286 81E6     strh    r6,[r4,0Eh]                             
0802E288 8226     strh    r6,[r4,10h]  ;四面分界全为0h                           
0802E28A 1C20     mov     r0,r4                                   
0802E28C 3025     add     r0,25h                                  
0802E28E 7007     strb    r7,[r0]      ;属性写入0h                           
0802E290 82E6     strh    r6,[r4,16h]                             
0802E292 7727     strb    r7,[r4,1Ch]  ;动画帧全为0                           
0802E294 7FE2     ldrb    r2,[r4,1Fh]  ;读取gfx row    r2                       
0802E296 3802     sub     r0,2h                                   
0802E298 7803     ldrb    r3,[r0]      ;读取主精灵序号 r3                          
0802E29A 8860     ldrh    r0,[r4,2h]   ;读取Y坐标      sp                     
0802E29C 9000     str     r0,[sp]      ;写入SP                           
0802E29E 88A0     ldrh    r0,[r4,4h]                              
0802E2A0 9001     str     r0,[sp,4h]   ;X坐标写入SP4   sp4                        
0802E2A2 9602     str     r6,[sp,8h]   ;0写入sp8 副精灵状态设置                          
0802E2A4 201E     mov     r0,1Eh       ;副精灵ID                           
0802E2A6 2100     mov     r1,0h        ;精灵数据设置                           
0802E2A8 F7DFFFD6 bl      spawnnewsecsprite                                
0802E2AC 0600     lsl     r0,r0,18h                               
0802E2AE 0E01     lsr     r1,r0,18h    ;得到副精灵数据写入序号                          
0802E2B0 2917     cmp     r1,17h                                  
0802E2B2 D825     bhi     802E300h                                
0802E2B4 1C20     mov     r0,r4                                   
0802E2B6 302D     add     r0,2Dh                                  
0802E2B8 7001     strb    r1,[r0]     ;写入3000765                        
0802E2BA 480E     ldr     r0,=30001ACh                            
0802E2BC 4680     mov     r8,r0                                   
0802E2BE 00C8     lsl     r0,r1,3h                                
0802E2C0 1A40     sub     r0,r0,r1                                
0802E2C2 00C5     lsl     r5,r0,3h                                
0802E2C4 4641     mov     r1,r8                                   
0802E2C6 1868     add     r0,r5,r1    ;得到该重产的数据写入地址                          
0802E2C8 82C6     strh    r6,[r0,16h]                             
0802E2CA 7707     strb    r7,[r0,1Ch] ;动画和帧清零                            
0802E2CC 2003     mov     r0,3h                                   
0802E2CE 212E     mov     r1,2Eh                                  
0802E2D0 F032FAF4 bl      checkevent                                
0802E2D4 2800     cmp     r0,0h                                   
0802E2D6 D015     beq     @@eventNoactivation                                
0802E2D8 4807     ldr     r0,=82E5FF0h                            
0802E2DA 61A0     str     r0,[r4,18h] ;写入激活的OAM                            
0802E2DC 1C21     mov     r1,r4                                   
0802E2DE 3124     add     r1,24h                                  
0802E2E0 200F     mov     r0,0Fh      ;pose写入0F                            
0802E2E2 7008     strb    r0,[r1]                                 
0802E2E4 4640     mov     r0,r8                                   
0802E2E6 3018     add     r0,18h                                  
0802E2E8 1828     add     r0,r5,r0     ;得到副精灵OAM地址                           
0802E2EA 4904     ldr     r1,=82E5FB8h ;副精灵激活OAM                           
0802E2EC E014     b       @@intersection                                

@@Overdata:                           ;精灵数据已经占用了24个,无法写入新副精灵   
0802E300 8026     strh    r6,[r4]     ;取向归0,主精灵直接消失                            
0802E302 E00D     b       @@end    

@@eventNoactivation:                            
0802E304 4809     ldr     r0,=82E5F38h ;写入没有激活的OAM                           
0802E306 61A0     str     r0,[r4,18h]                             
0802E308 1C21     mov     r1,r4                                   
0802E30A 3124     add     r1,24h                                  
0802E30C 2009     mov     r0,9h        ;pose写入9h                           
0802E30E 7008     strb    r0,[r1]                                 
0802E310 4640     mov     r0,r8                                   
0802E312 3018     add     r0,18h                                  
0802E314 1828     add     r0,r5,r0                                
0802E316 4906     ldr     r1,=82E5F28h ;没有激活的副精灵OAM

@@intersection:                           
0802E318 6001     str     r1,[r0]                                 
0802E31A 2002     mov     r0,2h                                   
0802E31C F7FFFF68 bl      802E1F0h     ;激活台的砖块制造例程

@@end:                                
0802E320 B003     add     sp,0Ch                                  
0802E322 BC08     pop     r3                                      
0802E324 4698     mov     r8,r3                                   
0802E326 BCF0     pop     r4-r7                                   
0802E328 BC01     pop     r0                                      
0802E32A 4700     bx      r0                                      

;pose 9h                              
0802E334 B5F0     push    r4-r7,r14                               
0802E336 B083     add     sp,-0Ch                                 
0802E338 4E23     ldr     r6,=30013D4h                            
0802E33A 8AB1     ldrh    r1,[r6,14h]  ;人物Y坐标                           
0802E33C 8A73     ldrh    r3,[r6,12h]  ;人物X坐标                           
0802E33E 4D23     ldr     r5,=3000738h                            
0802E340 8868     ldrh    r0,[r5,2h]                              
0802E342 88AA     ldrh    r2,[r5,4h]                              
0802E344 3881     sub     r0,81h       ;精灵水平坐标上两格余                           
0802E346 4281     cmp     r1,r0                                   
0802E348 D14C     bne     @@end     ;没有达到完全的入槽高度则结束                          
0802E34A 1C10     mov     r0,r2                                   
0802E34C 3840     sub     r0,40h    ;水平坐标左一格                              
0802E34E 4298     cmp     r0,r3                                   
0802E350 DA48     bge     @@end     ;如果人物没有达到左边一格的远度则结束                           
0802E352 3080     add     r0,80h    ;水平坐标右一格                              
0802E354 4298     cmp     r0,r3     ;如果人物没有达到右边一格的近度则结束                              
0802E356 DD45     ble     @@end                                
0802E358 7830     ldrb    r0,[r6]                                 
0802E35A 2811     cmp     r0,11h    ;如果姿势不是球则结束                              
0802E35C D142     bne     @@end                                
0802E35E 1C29     mov     r1,r5                                   
0802E360 3124     add     r1,24h                                  
0802E362 2700     mov     r7,0h                                   
0802E364 200B     mov     r0,0Bh    ;pose写入Bh                               
0802E366 7008     strb    r0,[r1]                                 
0802E368 3108     add     r1,8h                                   
0802E36A 2078     mov     r0,78h    ;3000764写入78h                              
0802E36C 7008     strb    r0,[r1]                                 
0802E36E 4818     ldr     r0,=82E5F80h  ;写入激活时的动画                          
0802E370 61A8     str     r0,[r5,18h]                             
0802E372 2400     mov     r4,0h                                   
0802E374 82EF     strh    r7,[r5,16h]                             
0802E376 772C     strb    r4,[r5,1Ch]   ;清零                          
0802E378 2040     mov     r0,40h        ;激活吊索的姿势                          
0802E37A F7D9F8B5 bl      samusposechange                                
0802E37E 1C28     mov     r0,r5                                   
0802E380 302D     add     r0,2Dh                                  
0802E382 7801     ldrb    r1,[r0]       ;3000765的值 在pose0记录的副精灵的序号                           
0802E384 4B13     ldr     r3,=30001ACh                            
0802E386 00C8     lsl     r0,r1,3h                                
0802E388 1A40     sub     r0,r0,r1                                
0802E38A 00C0     lsl     r0,r0,3h                                
0802E38C 1C19     mov     r1,r3                                   
0802E38E 3118     add     r1,18h                                  
0802E390 1841     add     r1,r0,r1                                
0802E392 4A11     ldr     r2,=82E5F48h                            
0802E394 600A     str     r2,[r1]                                 
0802E396 18C0     add     r0,r0,r3                                
0802E398 82C7     strh    r7,[r0,16h]                             
0802E39A 7704     strb    r4,[r0,1Ch]   ;清                           
0802E39C 7FEA     ldrb    r2,[r5,1Fh]   ;gfx row                         
0802E39E 1C28     mov     r0,r5                                   
0802E3A0 3023     add     r0,23h                                  
0802E3A2 7803     ldrb    r3,[r0]       ;主精灵序号                          
0802E3A4 8AB0     ldrh    r0,[r6,14h]   ;人物Y坐标                          
0802E3A6 3818     sub     r0,18h        ;向上提升18h写入SP                          
0802E3A8 9000     str     r0,[sp]                                 
0802E3AA 8A70     ldrh    r0,[r6,12h]   ;人物X坐标写入SP4                          
0802E3AC 9001     str     r0,[sp,4h]                              
0802E3AE 9702     str     r7,[sp,8h]    ;0h                          
0802E3B0 201E     mov     r0,1Eh                                  
0802E3B2 2101     mov     r1,1h         ;比之前的0更优先?                          
0802E3B4 F7DFFF50 bl      spawnnewsecsprite                                
0802E3B8 0600     lsl     r0,r0,18h                               
0802E3BA 0E02     lsr     r2,r0,18h                               
0802E3BC 2A17     cmp     r2,17h                                  
0802E3BE D80D     bhi     @@dataover                                
0802E3C0 1C28     mov     r0,r5                                   
0802E3C2 302E     add     r0,2Eh                                  
0802E3C4 7002     strb    r2,[r0]       ;3000766写入新副精灵数据序号                          
0802E3C6 E00A     b       @@playsound                                

@@dataover:                               
0802E3DC 802F     strh    r7,[r5]      ;主精灵消失 

@@playsound:                                
0802E3DE 4803     ldr     r0,=21Dh                                
0802E3E0 F7D4FB1A bl      8002A18h     ;激活声音

@@end:                               
0802E3E4 B003     add     sp,0Ch                                  
0802E3E6 BCF0     pop     r4-r7                                   
0802E3E8 BC01     pop     r0                                      
0802E3EA 4700     bx      r0   

;pose bh                                                                
0802E3F0 B570     push    r4-r6,r14                               
0802E3F2 B083     add     sp,-0Ch                                 
0802E3F4 4D18     ldr     r5,=3000738h                            
0802E3F6 1C28     mov     r0,r5                                   
0802E3F8 302C     add     r0,2Ch                                  
0802E3FA 7801     ldrb    r1,[r0]    ;读取3000764的值  pose9时写入78h                           
0802E3FC 3901     sub     r1,1h      ;减1                             
0802E3FE 2600     mov     r6,0h                                   
0802E400 7001     strb    r1,[r0]    ;再写入                            
0802E402 0608     lsl     r0,r1,18h                               
0802E404 2800     cmp     r0,0h                                   
0802E406 D12F     bne     @@NOzero                                
0802E408 4814     ldr     r0,=82E5FF0h  ;主精灵写入新OAM                          
0802E40A 61A8     str     r0,[r5,18h]                             
0802E40C 2400     mov     r4,0h                                   
0802E40E 82EE     strh    r6,[r5,16h]   ;清零                           
0802E410 772C     strb    r4,[r5,1Ch]                             
0802E412 1C29     mov     r1,r5                                   
0802E414 3124     add     r1,24h                                  
0802E416 200C     mov     r0,0Ch        ;pose写入Ch                           
0802E418 7008     strb    r0,[r1]                                 
0802E41A 2011     mov     r0,11h        ;重新写回球姿势                         
0802E41C F7D9F864 bl      samusposechange                                
0802E420 1C28     mov     r0,r5                                   
0802E422 302D     add     r0,2Dh                                  
0802E424 7801     ldrb    r1,[r0]       ;读取3000765的值 副精灵序号                          
0802E426 4B0E     ldr     r3,=30001ACh                            
0802E428 00C8     lsl     r0,r1,3h                                
0802E42A 1A40     sub     r0,r0,r1                                
0802E42C 00C0     lsl     r0,r0,3h                                
0802E42E 1C19     mov     r1,r3                                   
0802E430 3118     add     r1,18h                                  
0802E432 1841     add     r1,r0,r1                                
0802E434 4A0B     ldr     r2,=82E5FB8h  ;副精灵写新OAM                          
0802E436 600A     str     r2,[r1]                                 
0802E438 18C0     add     r0,r0,r3                                
0802E43A 82C6     strh    r6,[r0,16h]                             
0802E43C 7704     strb    r4,[r0,1Ch]   ;清零                           
0802E43E 1C28     mov     r0,r5                                   
0802E440 302F     add     r0,2Fh                                  
0802E442 7801     ldrb    r1,[r0]       ;读取3000767的值                           
0802E444 00C8     lsl     r0,r1,3h                                
0802E446 1A40     sub     r0,r0,r1                                
0802E448 00C0     lsl     r0,r0,3h                                
0802E44A 18C0     add     r0,r0,r3                                
0802E44C 8006     strh    r6,[r0]       ;新精灵消失                        
0802E44E 2001     mov     r0,1h                                   
0802E450 212E     mov     r1,2Eh                                  
0802E452 F032FA33 bl      checkevent    ;激活事件2eh                             
0802E456 E03E     b       @@end                                 

@@NOzero:                             
0802E468 0608     lsl     r0,r1,18h                               
0802E46A 0E00     lsr     r0,r0,18h                               
0802E46C 285A     cmp     r0,5Ah                                  
0802E46E D11B     bne     @@NO5A                                
0802E470 7FEA     ldrb    r2,[r5,1Fh]   ;gfx row                          
0802E472 1C28     mov     r0,r5                                   
0802E474 3023     add     r0,23h                                  
0802E476 7803     ldrb    r3,[r0]       ;主精灵序号                          
0802E478 8868     ldrh    r0,[r5,2h]    ;Y轴坐标                          
0802E47A 4909     ldr     r1,=0FFFFFE80h ;Y轴上17fh高度? 上6格的高度                         
0802E47C 1840     add     r0,r0,r1                                
0802E47E 9000     str     r0,[sp]                                 
0802E480 88A8     ldrh    r0,[r5,4h]                              
0802E482 9001     str     r0,[sp,4h]                              
0802E484 9602     str     r6,[sp,8h]                              
0802E486 201E     mov     r0,1Eh                                  
0802E488 2102     mov     r1,2h         ;第三次了>_< 大概是激活后的闪电闪光                         
0802E48A F7DFFEE5 bl      spawnnewsecsprite                                
0802E48E 0600     lsl     r0,r0,18h                               
0802E490 0E01     lsr     r1,r0,18h                               
0802E492 2917     cmp     r1,17h                                  
0802E494 D806     bhi     @@dataover@                                
0802E496 1C28     mov     r0,r5                                   
0802E498 302F     add     r0,2Fh                                  
0802E49A 7001     strb    r1,[r0]       ;3000767写入新精灵序号                           
0802E49C E01B     b       @@end                                

@@dataover@:                                
0802E4A4 802E     strh    r6,[r5]       ;精灵消失                          
0802E4A6 E016     b       @@end 

@@NO5A:                               
0802E4A8 2810     cmp     r0,10h                                  
0802E4AA D114     bne     @@end                                
0802E4AC 1C28     mov     r0,r5                                   
0802E4AE 302E     add     r0,2Eh        ;3000765的值,第一次副精灵序号                               
0802E4B0 7801     ldrb    r1,[r0]                                 
0802E4B2 4B0B     ldr     r3,=30001ACh                            
0802E4B4 00C8     lsl     r0,r1,3h                                
0802E4B6 1A40     sub     r0,r0,r1                                
0802E4B8 00C0     lsl     r0,r0,3h                                
0802E4BA 1C19     mov     r1,r3                                   
0802E4BC 3118     add     r1,18h                                  
0802E4BE 1841     add     r1,r0,r1                                
0802E4C0 4A08     ldr     r2,=82E6060h  ;写入新OAM                          
0802E4C2 600A     str     r2,[r1]                                 
0802E4C4 18C0     add     r0,r0,r3                                
0802E4C6 2200     mov     r2,0h                                   
0802E4C8 82C6     strh    r6,[r0,16h]                             
0802E4CA 7702     strb    r2,[r0,1Ch]                             
0802E4CC 3024     add     r0,24h                                  
0802E4CE 210B     mov     r1,0Bh       ;副精灵pose写入Bh                           
0802E4D0 7001     strb    r1,[r0]                                 
0802E4D2 4805     ldr     r0,=300004Dh                            
0802E4D4 7002     strb    r2,[r0]      ;动画调色板闪光障碍清除

@@end:                                
0802E4D6 B003     add     sp,0Ch                                  
0802E4D8 BC70     pop     r4-r6                                   
0802E4DA BC01     pop     r0                                      
0802E4DC 4700     bx      r0                                      
/////////////////////////////////////////////////////////////////////////////////////
;弹丸主程序
0802E524 B530     push    r4,r5,r14                               
0802E526 4C04     ldr     r4,=3000738h                            
0802E528 1C23     mov     r3,r4                                   
0802E52A 3324     add     r3,24h                                  
0802E52C 781A     ldrb    r2,[r3]                                 
0802E52E 2A00     cmp     r2,0h                                   
0802E530 D004     beq     @@posezero                                
0802E532 2A0B     cmp     r2,0Bh                                  
0802E534 D062     beq     @@poseBh                                
0802E536 E067     b       @@end                                

@@posezero:                            ;弹丸pose 0h
0802E53C 8821     ldrh    r1,[r4]                                 
0802E53E 2580     mov     r5,80h                                  
0802E540 022D     lsl     r5,r5,8h                                
0802E542 1C28     mov     r0,r5                                   
0802E544 2500     mov     r5,0h                                   
0802E546 4308     orr     r0,r1       ;8000 orr 取向                            
0802E548 490F     ldr     r1,=0FFFBh                              
0802E54A 4008     and     r0,r1       ;结果还是8000h                           
0802E54C 8020     strh    r0,[r4]     ;再写入                            
0802E54E 1C20     mov     r0,r4                                   
0802E550 3025     add     r0,25h                                  
0802E552 2100     mov     r1,0h       ;属性写入0h                            
0802E554 7005     strb    r5,[r0]                                 
0802E556 82E2     strh    r2,[r4,16h]                             
0802E558 7725     strb    r5,[r4,1Ch] ;动画帧清零                            
0802E55A 8162     strh    r2,[r4,0Ah]                             
0802E55C 81A2     strh    r2,[r4,0Ch]                             
0802E55E 81E2     strh    r2,[r4,0Eh]                             
0802E560 8222     strh    r2,[r4,10h]  ;四面分界全为0h                           
0802E562 2061     mov     r0,61h                                  
0802E564 7018     strb    r0,[r3]      ;pose写入61h??                           
0802E566 7FA3     ldrb    r3,[r4,1Eh]  ;3000765                           
0802E568 2B00     cmp     r3,0h                                   
0802E56A D10F     bne     @@pass                                
0802E56C 1C21     mov     r1,r4                                   
0802E56E 3127     add     r1,27h                                  
0802E570 2060     mov     r0,60h                                  
0802E572 7008     strb    r0,[r1]     ;300075f写入60h                            
0802E574 1C20     mov     r0,r4                                   
0802E576 3028     add     r0,28h      ;3000760写入0h                            
0802E578 7005     strb    r5,[r0]                                 
0802E57A 3102     add     r1,2h                                   
0802E57C 2020     mov     r0,20h                                  
0802E57E 7008     strb    r0,[r1]     ;3000761写入20h                             
0802E580 3907     sub     r1,7h                                   
0802E582 200D     mov     r0,0Dh                                  
0802E584 7008     strb    r0,[r1]     ;300075a写入Dh                            
0802E586 E03F     b       @@end                                

@@pass:                               
0802E58C 2B01     cmp     r3,1h                                   
0802E58E D117     bne     802E5C0h                                
0802E590 480A     ldr     r0,=82E6028h                            
0802E592 61A0     str     r0,[r4,18h]                             
0802E594 1C20     mov     r0,r4                                   
0802E596 3027     add     r0,27h                                  
0802E598 2110     mov     r1,10h                                  
0802E59A 7001     strb    r1,[r0]                                 
0802E59C 3001     add     r0,1h                                   
0802E59E 7001     strb    r1,[r0]                                 
0802E5A0 3001     add     r0,1h                                   
0802E5A2 7001     strb    r1,[r0]                                 
0802E5A4 1C22     mov     r2,r4                                   
0802E5A6 3232     add     r2,32h                                  
0802E5A8 7810     ldrb    r0,[r2]                                 
0802E5AA 2101     mov     r1,1h                                   
0802E5AC 4308     orr     r0,r1                                   
0802E5AE 7010     strb    r0,[r2]                                 
0802E5B0 1C21     mov     r1,r4                                   
0802E5B2 3122     add     r1,22h                                  
0802E5B4 2003     mov     r0,3h                                   
0802E5B6 7008     strb    r0,[r1]                                 
0802E5B8 E026     b       @@end                                
0802E5BA 0000     lsl     r0,r0,0h                                
0802E5BC 6028     str     r0,[r5]                                 
0802E5BE 082E     lsr     r6,r5,20h                               
0802E5C0 2B02     cmp     r3,2h                                   
0802E5C2 D119     bne     802E5F8h                                
0802E5C4 480B     ldr     r0,=82E60A8h                            
0802E5C6 61A0     str     r0,[r4,18h]                             
0802E5C8 1C20     mov     r0,r4                                   
0802E5CA 3027     add     r0,27h                                  
0802E5CC 2110     mov     r1,10h                                  
0802E5CE 7001     strb    r1,[r0]                                 
0802E5D0 3001     add     r0,1h                                   
0802E5D2 7001     strb    r1,[r0]                                 
0802E5D4 3001     add     r0,1h                                   
0802E5D6 7001     strb    r1,[r0]                                 
0802E5D8 1C22     mov     r2,r4                                   
0802E5DA 3232     add     r2,32h                                  
0802E5DC 7810     ldrb    r0,[r2]                                 
0802E5DE 2101     mov     r1,1h                                   
0802E5E0 4308     orr     r0,r1                                   
0802E5E2 7010     strb    r0,[r2]                                 
0802E5E4 1C20     mov     r0,r4                                   
0802E5E6 3022     add     r0,22h                                  
0802E5E8 7003     strb    r3,[r0]                                 
0802E5EA 1C21     mov     r1,r4                                   
0802E5EC 3121     add     r1,21h                                  
0802E5EE 2001     mov     r0,1h                                   
0802E5F0 7008     strb    r0,[r1]                                 
0802E5F2 E009     b       @@end                                
0802E5F4 60A8     str     r0,[r5,8h]                              
0802E5F6 082E     lsr     r6,r5,20h                               
0802E5F8 8022     strh    r2,[r4]                                 
0802E5FA E005     b       @@end 

@@poseBh:                               
0802E5FC F7E1FAE4 bl      800FBC8h                                
0802E600 2800     cmp     r0,0h                                   
0802E602 D001     beq     @@end                                
0802E604 2000     mov     r0,0h                                   
0802E606 8020     strh    r0,[r4] 

@@end:                                
0802E608 BC30     pop     r4,r5                                   
0802E60A BC01     pop     r0                                      
0802E60C 4700     bx      r0                                      
0802E60E 0000     lsl     r0,r0,0h                                
0802E610 4B13     ldr     r3,=3000738h                            
0802E612 4814     ldr     r0,=0FFE4h                              
0802E614 8158     strh    r0,[r3,0Ah]                             
0802E616 201C     mov     r0,1Ch                                  
0802E618 8198     strh    r0,[r3,0Ch]                             
0802E61A 4813     ldr     r0,=0FFE8h                              
0802E61C 81D8     strh    r0,[r3,0Eh]                             
0802E61E 2018     mov     r0,18h                                  
0802E620 8218     strh    r0,[r3,10h]                             
0802E622 1C18     mov     r0,r3                                   
0802E624 3027     add     r0,27h                                  
0802E626 2108     mov     r1,8h                                   
0802E628 7001     strb    r1,[r0]                                 
0802E62A 3001     add     r0,1h                                   
0802E62C 7001     strb    r1,[r0]                                 
0802E62E 1C19     mov     r1,r3                                   
0802E630 3129     add     r1,29h                                  
0802E632 2010     mov     r0,10h                                  
0802E634 7008     strb    r0,[r1]                                 
0802E636 3104     add     r1,4h                                   
0802E638 2001     mov     r0,1h                                   
0802E63A 7008     strb    r0,[r1]                                 
0802E63C 4A0B     ldr     r2,=82B0D68h                            
0802E63E 7F59     ldrb    r1,[r3,1Dh]                             
0802E640 00C8     lsl     r0,r1,3h                                
0802E642 1840     add     r0,r0,r1                                
0802E644 0040     lsl     r0,r0,1h                                
0802E646 1880     add     r0,r0,r2                                
0802E648 8800     ldrh    r0,[r0]                                 
0802E64A 8298     strh    r0,[r3,14h]                             
0802E64C 8859     ldrh    r1,[r3,2h]                              
0802E64E 3920     sub     r1,20h                                  
0802E650 8059     strh    r1,[r3,2h]                              
0802E652 8898     ldrh    r0,[r3,4h]                              
0802E654 3020     add     r0,20h                                  
0802E656 8098     strh    r0,[r3,4h]                              
0802E658 80D9     strh    r1,[r3,6h]                              
0802E65A 8118     strh    r0,[r3,8h]                              
0802E65C 4770     bx      r14                                     
0802E65E 0000     lsl     r0,r0,0h                                
0802E660 0738     lsl     r0,r7,1Ch                               
0802E662 0300     lsl     r0,r0,0Ch                               
0802E664 FFE4     bl      lr+0FC8h                                
0802E666 0000     lsl     r0,r0,0h                                
0802E668 FFE8     bl      lr+0FD0h                                
0802E66A 0000     lsl     r0,r0,0h                                
0802E66C 0D68     lsr     r0,r5,15h                               
0802E66E 082B     lsr     r3,r5,20h                               
0802E670 4B0B     ldr     r3,=3000738h                            
0802E672 1C18     mov     r0,r3                                   
0802E674 3025     add     r0,25h                                  
0802E676 2200     mov     r2,0h                                   
0802E678 7002     strb    r2,[r0]                                 
0802E67A 1C19     mov     r1,r3                                   
0802E67C 3124     add     r1,24h                                  
0802E67E 2009     mov     r0,9h                                   
0802E680 7008     strb    r0,[r1]                                 
0802E682 4808     ldr     r0,=82E6700h                            
0802E684 6198     str     r0,[r3,18h]                             
0802E686 2000     mov     r0,0h                                   
0802E688 82DA     strh    r2,[r3,16h]                             
0802E68A 7718     strb    r0,[r3,1Ch]                             
0802E68C 8818     ldrh    r0,[r3]                                 
0802E68E 4A06     ldr     r2,=8004h                               
0802E690 1C11     mov     r1,r2                                   
0802E692 4308     orr     r0,r1                                   
0802E694 8018     strh    r0,[r3]                                 
0802E696 1C19     mov     r1,r3                                   
0802E698 3121     add     r1,21h                                  
0802E69A 2002     mov     r0,2h                                   
0802E69C 7008     strb    r0,[r1]                                 
0802E69E 4770     bx      r14                                     
0802E6A0 0738     lsl     r0,r7,1Ch                               
0802E6A2 0300     lsl     r0,r0,0Ch                               
0802E6A4 6700     str     r0,[r0,70h]                             
0802E6A6 082E     lsr     r6,r5,20h                               
0802E6A8 8004     strh    r4,[r0]                                 
0802E6AA 0000     lsl     r0,r0,0h                                
0802E6AC B5F0     push    r4-r7,r14                               
0802E6AE 4647     mov     r7,r8                                   
0802E6B0 B480     push    r7                                      
0802E6B2 B083     add     sp,-0Ch                                 
0802E6B4 4C06     ldr     r4,=3000738h                            
0802E6B6 7F60     ldrb    r0,[r4,1Dh]                             
0802E6B8 289E     cmp     r0,9Eh                                  
0802E6BA D10D     bne     802E6D8h                                
0802E6BC 1C21     mov     r1,r4                                   
0802E6BE 3124     add     r1,24h                                  
0802E6C0 2023     mov     r0,23h                                  
0802E6C2 7008     strb    r0,[r1]                                 
0802E6C4 8821     ldrh    r1,[r4]                                 
0802E6C6 4803     ldr     r0,=7FFBh                               
0802E6C8 4008     and     r0,r1                                   
0802E6CA 8020     strh    r0,[r4]                                 
0802E6CC E091     b       802E7F2h                                
0802E6CE 0000     lsl     r0,r0,0h                                
0802E6D0 0738     lsl     r0,r7,1Ch                               
0802E6D2 0300     lsl     r0,r0,0Ch                               
0802E6D4 7FFB     ldrb    r3,[r7,1Fh]                             
0802E6D6 0000     lsl     r0,r0,0h                                
0802E6D8 289D     cmp     r0,9Dh                                  
0802E6DA D105     bne     802E6E8h                                
0802E6DC 209E     mov     r0,9Eh                                  
0802E6DE F7E2F85B bl      8010798h                                
0802E6E2 2800     cmp     r0,0h                                   
0802E6E4 D000     beq     802E6E8h                                
0802E6E6 E084     b       802E7F2h                                
0802E6E8 F7E2F8E2 bl      80108B0h                                
0802E6EC 2800     cmp     r0,0h                                   
0802E6EE D000     beq     802E6F2h                                
0802E6F0 E07F     b       802E7F2h                                
0802E6F2 1C21     mov     r1,r4                                   
0802E6F4 312D     add     r1,2Dh                                  
0802E6F6 7808     ldrb    r0,[r1]                                 
0802E6F8 2800     cmp     r0,0h                                   
0802E6FA D002     beq     802E702h                                
0802E6FC 3801     sub     r0,1h                                   
0802E6FE 7008     strb    r0,[r1]                                 
0802E700 E077     b       802E7F2h                                
0802E702 4806     ldr     r0,=30013D4h                            
0802E704 8A81     ldrh    r1,[r0,14h]                             
0802E706 8A43     ldrh    r3,[r0,12h]                             
0802E708 8860     ldrh    r0,[r4,2h]                              
0802E70A 88A2     ldrh    r2,[r4,4h]                              
0802E70C 381E     sub     r0,1Eh                                  
0802E70E 4281     cmp     r1,r0                                   
0802E710 DC6F     bgt     802E7F2h                                
0802E712 429A     cmp     r2,r3                                   
0802E714 D904     bls     802E720h                                
0802E716 1AD0     sub     r0,r2,r3                                
0802E718 E003     b       802E722h                                
0802E71A 0000     lsl     r0,r0,0h                                
0802E71C 13D4     asr     r4,r2,0Fh                               
0802E71E 0300     lsl     r0,r0,0Ch                               
0802E720 1A98     sub     r0,r3,r2                                
0802E722 2824     cmp     r0,24h                                  
0802E724 DD65     ble     802E7F2h                                
0802E726 21A0     mov     r1,0A0h                                 
0802E728 0049     lsl     r1,r1,1h                                
0802E72A 1C08     mov     r0,r1                                   
0802E72C F7E1FB8C bl      800FE48h                                
0802E730 2801     cmp     r0,1h                                   
0802E732 D15E     bne     802E7F2h                                
0802E734 4D32     ldr     r5,=3000738h                            
0802E736 4833     ldr     r0,=30013D4h                            
0802E738 8A80     ldrh    r0,[r0,14h]                             
0802E73A 8268     strh    r0,[r5,12h]                             
0802E73C 1C29     mov     r1,r5                                   
0802E73E 3124     add     r1,24h                                  
0802E740 2023     mov     r0,23h                                  
0802E742 7008     strb    r0,[r1]                                 
0802E744 1C28     mov     r0,r5                                   
0802E746 302C     add     r0,2Ch                                  
0802E748 2402     mov     r4,2h                                   
0802E74A 7004     strb    r4,[r0]                                 
0802E74C 8829     ldrh    r1,[r5]                                 
0802E74E 482E     ldr     r0,=7FFBh                               
0802E750 4008     and     r0,r1                                   
0802E752 8028     strh    r0,[r5]                                 
0802E754 F7E1F8AC bl      800F8B0h                                
0802E758 8828     ldrh    r0,[r5]                                 
0802E75A 4004     and     r4,r0                                   
0802E75C 2C00     cmp     r4,0h                                   
0802E75E D002     beq     802E766h                                
0802E760 482A     ldr     r0,=179h                                
0802E762 F7D4F959 bl      8002A18h                                
0802E766 7F68     ldrb    r0,[r5,1Dh]                             
0802E768 289D     cmp     r0,9Dh                                  
0802E76A D142     bne     802E7F2h                                
0802E76C 7FA9     ldrb    r1,[r5,1Eh]                             
0802E76E 7FEA     ldrb    r2,[r5,1Fh]                             
0802E770 1C2E     mov     r6,r5                                   
0802E772 3623     add     r6,23h                                  
0802E774 7833     ldrb    r3,[r6]                                 
0802E776 8868     ldrh    r0,[r5,2h]                              
0802E778 3060     add     r0,60h                                  
0802E77A 9000     str     r0,[sp]                                 
0802E77C 88A8     ldrh    r0,[r5,4h]                              
0802E77E 3820     sub     r0,20h                                  
0802E780 9001     str     r0,[sp,4h]                              
0802E782 882C     ldrh    r4,[r5]                                 
0802E784 2740     mov     r7,40h                                  
0802E786 1C38     mov     r0,r7                                   
0802E788 4020     and     r0,r4                                   
0802E78A 0400     lsl     r0,r0,10h                               
0802E78C 0C00     lsr     r0,r0,10h                               
0802E78E 9002     str     r0,[sp,8h]                              
0802E790 209E     mov     r0,9Eh                                  
0802E792 F7DFFE1F bl      800E3D4h                                
0802E796 0600     lsl     r0,r0,18h                               
0802E798 0E01     lsr     r1,r0,18h                               
0802E79A 29FF     cmp     r1,0FFh                                 
0802E79C D029     beq     802E7F2h                                
0802E79E 481C     ldr     r0,=30001ACh                            
0802E7A0 4680     mov     r8,r0                                   
0802E7A2 00C8     lsl     r0,r1,3h                                
