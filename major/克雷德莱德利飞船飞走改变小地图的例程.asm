

0806CD84 B5F0     push    r4-r7,r14                               
0806CD86 0600     lsl     r0,r0,18h                               
0806CD88 0E02     lsr     r2,r0,18h      ;41h                         
0806CD8A 2400     mov     r4,0h                                   
0806CD8C 4821     ldr     r0,=840D200h                            
0806CD8E 1C01     mov     r1,r0                                   
0806CD90 7808     ldrb    r0,[r1]                                 
0806CD92 4282     cmp     r2,r0          ;r2为0跳转                          
0806CD94 D007     beq     @@Pass                                
0806CD96 1C08     mov     r0,r1 

@@Loop:                                  
0806CD98 3005     add     r0,5h                                   
0806CD9A 3401     add     r4,1h                                   
0806CD9C 2C06     cmp     r4,6h          ;循环了6次跳转                         
0806CD9E D802     bhi     @@Pass         ;经历克雷德死莱德利死逃进飞船????                      
0806CDA0 7803     ldrb    r3,[r0]                                 
0806CDA2 429A     cmp     r2,r3          ;等于或大于都跳出循环...                         
0806CDA4 D1F8     bne     @@Loop

@@Pass:                              
0806CDA6 2C06     cmp     r4,6h          ;小于或等于                         
0806CDA8 DD00     ble     @@Pass1                               
0806CDAA E09F     b       @@end 

@@Pass1:                               
0806CDAC 481A     ldr     r0,=3000054h                            
0806CDAE 7803     ldrb    r3,[r0]        ;得到当前区域号                           
0806CDB0 429C     cmp     r4,r3          ;应该为5相等的                           
0806CDB2 D000     beq     @@Pass2                                
0806CDB4 E09A     b       @@end   

@@Pass2:                             
0806CDB6 00A2     lsl     r2,r4,2h       ;区号的四倍                         
0806CDB8 1912     add     r2,r2,r4       ;5倍                         
0806CDBA 1CC8     add     r0,r1,3                                
0806CDBC 1810     add     r0,r2,r0       ;840d21c                         
0806CDBE 7800     ldrb    r0,[r0]        ;7h   要改变的地图块的高度                       
0806CDC0 3102     add     r1,2h                                   
0806CDC2 1852     add     r2,r2,r1       ;840d21b                         
0806CDC4 0140     lsl     r0,r0,5h       ;E0h  高度乘以32倍                       
0806CDC6 7812     ldrb    r2,[r2]        ;9h                         
0806CDC8 1884     add     r4,r0,r2       ;e9h  加上宽度的坐标                       
0806CDCA 0060     lsl     r0,r4,1h       ;1D2h  乘以2                       
0806CDCC 4913     ldr     r1,=2034800h   ;小地图内存数据                          
0806CDCE 1845     add     r5,r0,r1       ;20349d2h                         
0806CDD0 4913     ldr     r1,=2034000h                            
0806CDD2 1846     add     r6,r0,r1       ;20341d2h                         
0806CDD4 1C18     mov     r0,r3                                   
0806CDD6 2805     cmp     r0,5h          ;如果区号不等于5                         
0806CDD8 D128     bne     @@TwoBoss                                
0806CDDA 8828     ldrh    r0,[r5]        ;10d4h                         
0806CDDC 4911     ldr     r1,=3FFh                                
0806CDDE 4A12     ldr     r2,=840D224h   ;读取                         
0806CDE0 4001     and     r1,r0          ;d4h                          
0806CDE2 8892     ldrh    r2,[r2,4h]     ;d4h   比较已经探索的小地图和未探索的地图数据是否相等                      
0806CDE4 4291     cmp     r1,r2                                   
0806CDE6 D000     beq     @@Pass3                                
0806CDE8 E080     b       @@end  

@@Pass3:                              
0806CDEA 27F0     mov     r7,0F0h                                 
0806CDEC 023F     lsl     r7,r7,8h      ;F000h                             
0806CDEE 1C31     mov     r1,r6                                   
0806CDF0 1C2B     mov     r3,r5                                   
0806CDF2 2402     mov     r4,2h  

@@Loop1:                                 
0806CDF4 8818     ldrh    r0,[r3]       ;10d4h                          
0806CDF6 3001     add     r0,1h         ;加1                          
0806CDF8 8018     strh    r0,[r3]       ;再写入                          
0806CDFA 880A     ldrh    r2,[r1]       ;20341d2h 已经探索的小地图                          
0806CDFC 1C38     mov     r0,r7                                   
0806CDFE 4010     and     r0,r2         ;F000h and 已经探索的小地图                           
0806CE00 2800     cmp     r0,0h                                   
0806CE02 D001     beq     @@Noexplored                                
0806CE04 1C50     add     r0,r2,1       ;加1写入                          
0806CE06 8008     strh    r0,[r1] 

@@Noexplored:                                
0806CE08 3102     add     r1,2h         ;已经探索的小地图数据                          
0806CE0A 3302     add     r3,2h         ;未探索的小地图数据 各下一格                          
0806CE0C 3C01     sub     r4,1h                                   
0806CE0E 2C00     cmp     r4,0h                                   
0806CE10 DAF0     bge     @@Loop1       ;大于等于跳转                          
0806CE12 E066     b       @@Upmap                                
0806CE14 D200     bcs     806CE18h                                
0806CE16 0840     lsr     r0,r0,1h                                
0806CE18 0054     lsl     r4,r2,1h                                
0806CE1A 0300     lsl     r0,r0,0Ch                               
0806CE1C 4800     ldr     r0,=2034000h                            
0806CE1E 0203     lsl     r3,r0,8h                                
0806CE20 4000     and     r0,r0                                   
0806CE22 0203     lsl     r3,r0,8h                                
0806CE24 03FF     lsl     r7,r7,0Fh                               
0806CE26 0000     lsl     r0,r0,0h                                
0806CE28 D224     bcs     806CE74h                                
0806CE2A 0840     lsr     r0,r0,1h 

@@TwoBoss:                               
0806CE2C 2801     cmp     r0,1h                                   
0806CE2E D129     bne     806CE84h                                
0806CE30 8828     ldrh    r0,[r5]                                 
0806CE32 4912     ldr     r1,=3FFh                                
0806CE34 4A12     ldr     r2,=840D224h                            
0806CE36 4001     and     r1,r0                                   
0806CE38 8812     ldrh    r2,[r2]                                 
0806CE3A 4291     cmp     r1,r2                                   
0806CE3C D156     bne     @@end                                
0806CE3E 1C33     mov     r3,r6                                   
0806CE40 1C2A     mov     r2,r5                                   
0806CE42 2401     mov     r4,1h                                   
0806CE44 8810     ldrh    r0,[r2]                                 
0806CE46 3020     add     r0,20h                                  
0806CE48 8010     strh    r0,[r2]                                 
0806CE4A 8818     ldrh    r0,[r3]                                 
0806CE4C 3020     add     r0,20h                                  
0806CE4E 8018     strh    r0,[r3]                                 
0806CE50 3302     add     r3,2h                                   
0806CE52 3202     add     r2,2h                                   
0806CE54 3C01     sub     r4,1h                                   
0806CE56 2C00     cmp     r4,0h                                   
0806CE58 DAF4     bge     806CE44h                                
0806CE5A 1C33     mov     r3,r6                                   
0806CE5C 3340     add     r3,40h                                  
0806CE5E 1C2A     mov     r2,r5                                   
0806CE60 3240     add     r2,40h                                  
0806CE62 2401     mov     r4,1h                                   
0806CE64 8810     ldrh    r0,[r2]                                 
0806CE66 3020     add     r0,20h                                  
0806CE68 8010     strh    r0,[r2]                                 
0806CE6A 8818     ldrh    r0,[r3]                                 
0806CE6C 3020     add     r0,20h                                  
0806CE6E 8018     strh    r0,[r3]                                 
0806CE70 3302     add     r3,2h                                   
0806CE72 3202     add     r2,2h                                   
0806CE74 3C01     sub     r4,1h                                   
0806CE76 2C00     cmp     r4,0h                                   
0806CE78 DAF4     bge     806CE64h                                
0806CE7A E032     b       806CEE2h                                
0806CE7C 03FF     lsl     r7,r7,0Fh                               
0806CE7E 0000     lsl     r0,r0,0h                                
0806CE80 D224     bcs     806CECCh                                
0806CE82 0840     lsr     r0,r0,1h                                
0806CE84 2803     cmp     r0,3h                                   
0806CE86 D12A     bne     806CEDEh                                
0806CE88 8828     ldrh    r0,[r5]                                 
0806CE8A 4912     ldr     r1,=3FFh                                
0806CE8C 4A12     ldr     r2,=840D224h                            
0806CE8E 4001     and     r1,r0                                   
0806CE90 8852     ldrh    r2,[r2,2h]                              
0806CE92 4291     cmp     r1,r2                                   
0806CE94 D122     bne     806CEDCh                                
0806CE96 1C33     mov     r3,r6                                   
0806CE98 1C2A     mov     r2,r5                                   
0806CE9A 2401     mov     r4,1h                                   
0806CE9C 8810     ldrh    r0,[r2]                                 
0806CE9E 3020     add     r0,20h                                  
0806CEA0 8010     strh    r0,[r2]                                 
0806CEA2 8818     ldrh    r0,[r3]                                 
0806CEA4 3020     add     r0,20h                                  
0806CEA6 8018     strh    r0,[r3]                                 
0806CEA8 3302     add     r3,2h                                   
0806CEAA 3202     add     r2,2h                                   
0806CEAC 3C01     sub     r4,1h                                   
0806CEAE 2C00     cmp     r4,0h                                   
0806CEB0 DAF4     bge     806CE9Ch                                
0806CEB2 1C33     mov     r3,r6                                   
0806CEB4 3340     add     r3,40h                                  
0806CEB6 1C2A     mov     r2,r5                                   
0806CEB8 3240     add     r2,40h                                  
0806CEBA 2401     mov     r4,1h                                   
0806CEBC 8810     ldrh    r0,[r2]                                 
0806CEBE 3020     add     r0,20h                                  
0806CEC0 8010     strh    r0,[r2]                                 
0806CEC2 8818     ldrh    r0,[r3]                                 
0806CEC4 3020     add     r0,20h                                  
0806CEC6 8018     strh    r0,[r3]                                 
0806CEC8 3302     add     r3,2h                                   
0806CECA 3202     add     r2,2h                                   
0806CECC 3C01     sub     r4,1h                                   
0806CECE 2C00     cmp     r4,0h                                   
0806CED0 DAF4     bge     806CEBCh                                
0806CED2 E006     b       806CEE2h                                
0806CED4 03FF     lsl     r7,r7,0Fh                               
0806CED6 0000     lsl     r0,r0,0h                                
0806CED8 D224     bcs     806CF24h                                
0806CEDA 0840     lsr     r0,r0,1h                                
0806CEDC 2401     mov     r4,1h                                   
0806CEDE 2C00     cmp     r4,0h                                   
0806CEE0 D104     bne     @@end  

@@Upmap:                              
0806CEE2 4904     ldr     r1,=3000903h   ;更新地图flag???                         
0806CEE4 2003     mov     r0,3h                                   
0806CEE6 7008     strb    r0,[r1]                                 
0806CEE8 F7FFFB64 bl      806C5B4h  

@@end:                              
0806CEEC BCF0     pop     r4-r7                                   
0806CEEE BC01     pop     r0                                      
0806CEF0 4700     bx      r0 
//////////////////////////////////////////////////////////////////////
                                     
0806C5B4 B5F0     push    r4-r7,r14                               
0806C5B6 464F     mov     r7,r9                                   
0806C5B8 4646     mov     r6,r8                                   
0806C5BA B4C0     push    r6,r7                                   
0806C5BC B081     add     sp,-4h                                  
0806C5BE 4B09     ldr     r3,=3000903h                            
0806C5C0 7818     ldrb    r0,[r3]        ;读取地图更新flag写入的设定值                         
0806C5C2 2800     cmp     r0,0h                                   
0806C5C4 D064     beq     @@end          ;为0则结束                      
0806C5C6 4808     ldr     r0,=2034000h   ;已经探索的地图坐标起始                         
0806C5C8 4680     mov     r8,r0                                   
0806C5CA 781A     ldrb    r2,[r3]                                 
0806C5CC 1E51     sub     r1,r2,1        ;设定值减1                         
0806C5CE 0048     lsl     r0,r1,1h       ;乘以2                          
0806C5D0 1840     add     r0,r0,r1       ;三倍                         
0806C5D2 0140     lsl     r0,r0,5h       ;96倍                         
0806C5D4 4905     ldr     r1,=2037E20h   ;每60h偏移代表一个地址范围?                         
0806C5D6 1846     add     r6,r0,r1       ;设定值为3则为2037ee0                          
0806C5D8 2A03     cmp     r2,3h          ;设定值                         
0806C5DA D109     bne     @@No3       ;不为3跳转                         
0806C5DC 2701     mov     r7,1h                                   
0806C5DE 46B9     mov     r9,r7     ;r9=1                            
0806C5E0 E013     b       @@Peer                                

@@No3:                              
0806C5F0 2A02     cmp     r2,2h                                   
0806C5F2 D102     bne     @@No2                                
0806C5F4 2000     mov     r0,0h                                   
0806C5F6 4681     mov     r9,r0     ;r9=0                              
0806C5F8 E007     b       @@Peer

@@No2:                                
0806C5FA 2A01     cmp     r2,1h                                   
0806C5FC D002     beq     @@No0                                
0806C5FE 2000     mov     r0,0h                                   
0806C600 7018     strb    r0,[r3] ;flag重新写入0然后结束...                                
0806C602 E045     b       @@end  

@@Yes1:                                
0806C604 2101     mov     r1,1h                                   
0806C606 4249     neg     r1,r1                                   
0806C608 4689     mov     r9,r1   ;r9=FFh

@@Peer:                                 
0806C60A 2501     mov     r5,1h                                   
0806C60C 426D     neg     r5,r5                                   
0806C60E 466C     mov     r4,r13     ;3007DE8h                             
0806C610 4823     ldr     r0,=3000059h                            
0806C612 7800     ldrb    r0,[r0]    ;当前小地图X坐标                             
0806C614 1941     add     r1,r0,r5   ;相当于减1                             
0806C616 291F     cmp     r1,1Fh     ;是否小于1F                             
0806C618 D901     bls     @@NoOverData                                
0806C61A 2101     mov     r1,1h                                   
0806C61C 4249     neg     r1,r1      ;FFFFFFFF

@@NoOverData:                                 
0806C61E 4821     ldr     r0,=300005Ah                            
0806C620 7800     ldrb    r0,[r0]    ;当前小地图Y坐标                             
0806C622 4448     add     r0,r9      ;加上设定的值                            
0806C624 281F     cmp     r0,1Fh                                  
0806C626 D901     bls     @@NoOverData1                                
0806C628 2001     mov     r0,1h                                   
0806C62A 4240     neg     r0,r0      ;负数

@@NoOverData1:                                 
0806C62C 2800     cmp     r0,0h                                  
0806C62E DB01     blt     @@YOverData   ;小于0                             
0806C630 2900     cmp     r1,0h                                   
0806C632 DA01     bge     @@NoOverData2   ;大于等于0

@@YOverData:                                
0806C634 211F     mov     r1,1Fh                                  
0806C636 201F     mov     r0,1Fh 

@@NoOverData2:                                 
0806C638 0140     lsl     r0,r0,5h    ;Y坐标下一格的32倍                             
0806C63A 1840     add     r0,r0,r1    ;加上X坐标                            
0806C63C 0040     lsl     r0,r0,1h    ;乘以2                            
0806C63E 4440     add     r0,r8       ;加上已经探索地图的内存起始地址                            
0806C640 27C0     mov     r7,0C0h                                 
0806C642 013F     lsl     r7,r7,4h    ;C00h                            
0806C644 1C3A     mov     r2,r7                                   
0806C646 8801     ldrh    r1,[r0]                                 
0806C648 1C08     mov     r0,r1                                   
0806C64A 4010     and     r0,r2                                   
0806C64C 0A83     lsr     r3,r0,0Ah   ;400h以下都为0                            
0806C64E 0B0A     lsr     r2,r1,0Ch   ;去掉后3位                            
0806C650 4F15     ldr     r7,=3FFh                                
0806C652 1C38     mov     r0,r7                                   
0806C654 4001     and     r1,r0                                   
0806C656 8021     strh    r1,[r4]     ;计算得出的坐标的地图AND 3FFh写入3007de8                            
0806C658 4814     ldr     r0,=3000020h                            
0806C65A 7800     ldrb    r0,[r0]                                 
0806C65C 0600     lsl     r0,r0,18h                               
0806C65E 1600     asr     r0,r0,18h                               
0806C660 2801     cmp     r0,1h       ;语言如果不是平假名跳转                            
0806C662 D106     bne     @@Pass4                                
0806C664 20A0     mov     r0,0A0h                                 
0806C666 0040     lsl     r0,r0,1h    ;140h                            
0806C668 4281     cmp     r1,r0                                   
0806C66A D902     bls     @@Pass4    ;小于等于跳转                            
0806C66C 1C08     mov     r0,r1                                   
0806C66E 3020     add     r0,20h      ;坐标偏移20h再写入                            
0806C670 8020     strh    r0,[r4] 

@@Pass4:                                
0806C672 8820     ldrh    r0,[r4]                                 
0806C674 0140     lsl     r0,r0,5h    ;读取地图数据乘以32再写入                            
0806C676 8020     strh    r0,[r4]                                 
0806C678 490D     ldr     r1,=8760298h                            
0806C67A 0098     lsl     r0,r3,2h                                
0806C67C 1840     add     r0,r0,r1                                
0806C67E 6803     ldr     r3,[r0]                                 
0806C680 1C30     mov     r0,r6                                   
0806C682 4669     mov     r1,r13                                  
0806C684 F01EFABE bl      808AC04h    ;BX r3                               
0806C688 3501     add     r5,1h                                   
0806C68A 3620     add     r6,20h                                  
0806C68C 2D01     cmp     r5,1h                                   
0806C68E DDBF     ble     806C610h 

@@end:                               
0806C690 B001     add     sp,4h                                   
0806C692 BC18     pop     r3,r4                                   
0806C694 4698     mov     r8,r3                                   
0806C696 46A1     mov     r9,r4                                   
0806C698 BCF0     pop     r4-r7                                   
0806C69A BC01     pop     r0                                      
0806C69C 4700     bx      r0 
//////////////////////////////////////////////////////////////////////////

0806C6B4 B5F0     push    r4-r7,r14                               
0806C6B6 4657     mov     r7,r10                                  
0806C6B8 464E     mov     r6,r9                                   
0806C6BA 4645     mov     r5,r8                                   
0806C6BC B4E0     push    r5-r7                                   
0806C6BE 4682     mov     r10,r0                                  
0806C6C0 1C0D     mov     r5,r1                                   
0806C6C2 0612     lsl     r2,r2,18h                               
0806C6C4 482E     ldr     r0,=840E0C4h                            
0806C6C6 4680     mov     r8,r0                                   
0806C6C8 492E     ldr     r1,=840D74Ch                            
0806C6CA 468C     mov     r12,r1                                  
0806C6CC 0D14     lsr     r4,r2,14h     ;得到地图数据第一位加0h                            
0806C6CE 4F2E     ldr     r7,=840D6FCh                            
0806C6D0 260F     mov     r6,0Fh                                  
0806C6D2 2007     mov     r0,7h                                   
0806C6D4 4681     mov     r9,r0                                   
0806C6D6 882A     ldrh    r2,[r5]       ;得到之前sp的地图数据的32倍 140为2800                          
0806C6D8 4641     mov     r1,r8                                   
0806C6DA 1850     add     r0,r2,r1      ;840E0C4h  + 地图数据的32倍                        
0806C6DC 7800     ldrb    r0,[r0]       ;读取数据是字节 44                          
0806C6DE 0901     lsr     r1,r0,4h      ;去掉末位  4                         
0806C6E0 1909     add     r1,r1,r4      ;加上地图数据第一位加0                          
0806C6E2 4461     add     r1,r12        ;再加上840d74ch                          
0806C6E4 4030     and     r0,r6         ;44 and 0f等于去掉前位                          
0806C6E6 1900     add     r0,r0,r4      ;加上地图数据第一位加0                         
0806C6E8 19C0     add     r0,r0,r7      ;再加上840d6fch                          
0806C6EA 7809     ldrb    r1,[r1]                                 
0806C6EC 7803     ldrb    r3,[r0]       ;读取双方的值                          
0806C6EE 430B     orr     r3,r1         ;两者orr                          
0806C6F0 3201     add     r2,1h         ;                          
0806C6F2 802A     strh    r2,[r5]                                 
0806C6F4 882A     ldrh    r2,[r5]                                 
0806C6F6 4641     mov     r1,r8       ;840e0c4h                            
0806C6F8 1850     add     r0,r2,r1    ;84108c4h                            
0806C6FA 7800     ldrb    r0,[r0]                                 
0806C6FC 0901     lsr     r1,r0,4h                                
0806C6FE 1909     add     r1,r1,r4                                
0806C700 4461     add     r1,r12                                  
0806C702 4030     and     r0,r6                                   
0806C704 1900     add     r0,r0,r4                                
0806C706 19C0     add     r0,r0,r7                                
0806C708 7809     ldrb    r1,[r1]                                 
0806C70A 7800     ldrb    r0,[r0]                                 
0806C70C 4308     orr     r0,r1                                   
0806C70E 0200     lsl     r0,r0,8h                                
0806C710 4303     orr     r3,r0                                   
0806C712 3201     add     r2,1h                                   
0806C714 802A     strh    r2,[r5]                                 
0806C716 882A     ldrh    r2,[r5]                                 
0806C718 4641     mov     r1,r8                                   
0806C71A 1850     add     r0,r2,r1                                
0806C71C 7800     ldrb    r0,[r0]                                 
0806C71E 0901     lsr     r1,r0,4h                                
0806C720 1909     add     r1,r1,r4                                
0806C722 4461     add     r1,r12                                  
0806C724 4030     and     r0,r6                                   
0806C726 1900     add     r0,r0,r4                                
0806C728 19C0     add     r0,r0,r7                                
0806C72A 7809     ldrb    r1,[r1]                                 
0806C72C 7800     ldrb    r0,[r0]                                 
0806C72E 4308     orr     r0,r1                                   
0806C730 0400     lsl     r0,r0,10h                               
0806C732 4303     orr     r3,r0                                   
0806C734 3201     add     r2,1h                                   
0806C736 802A     strh    r2,[r5]                                 
0806C738 882A     ldrh    r2,[r5]                                 
0806C73A 4641     mov     r1,r8                                   
0806C73C 1850     add     r0,r2,r1                                
0806C73E 7800     ldrb    r0,[r0]                                 
0806C740 0901     lsr     r1,r0,4h                                
0806C742 1909     add     r1,r1,r4                                
0806C744 4461     add     r1,r12                                  
0806C746 4030     and     r0,r6                                   
0806C748 1900     add     r0,r0,r4                                
0806C74A 19C0     add     r0,r0,r7                                
0806C74C 7809     ldrb    r1,[r1]                                 
0806C74E 7800     ldrb    r0,[r0]                                 
0806C750 4308     orr     r0,r1                                   
0806C752 0600     lsl     r0,r0,18h                               
0806C754 4303     orr     r3,r0                                   
0806C756 3201     add     r2,1h                                   
0806C758 802A     strh    r2,[r5]                                 
0806C75A 4650     mov     r0,r10                                  
0806C75C 3004     add     r0,4h                                   
0806C75E 4682     mov     r10,r0                                  
0806C760 3804     sub     r0,4h                                   
0806C762 C008     stmia   [r0]!,r3                                
0806C764 2101     mov     r1,1h                                   
0806C766 4249     neg     r1,r1                                   
0806C768 4489     add     r9,r1                                   
0806C76A 4648     mov     r0,r9                                   
0806C76C 2800     cmp     r0,0h                                   
0806C76E DAB2     bge     806C6D6h                                
0806C770 BC38     pop     r3-r5                                   
0806C772 4698     mov     r8,r3                                   
0806C774 46A1     mov     r9,r4                                   
0806C776 46AA     mov     r10,r5                                  
0806C778 BCF0     pop     r4-r7                                   
0806C77A BC01     pop     r0                                      
0806C77C 4700     bx      r0 
                                     
0806C77E 0000     lsl     r0,r0,0h                                
0806C780 E0C4     b       806C90Ch                                
0806C782 0840     lsr     r0,r0,1h                                
0806C784 D74C     bvc     806C820h                                
0806C786 0840     lsr     r0,r0,1h                                
0806C788 D6FC     bvs     806C784h                                
0806C78A 0840     lsr     r0,r0,1h                                
0806C78C B5F0     push    r4-r7,r14                               
0806C78E 4657     mov     r7,r10                                  
0806C790 464E     mov     r6,r9                                   
0806C792 4645     mov     r5,r8                                   
0806C794 B4E0     push    r5-r7                                   
0806C796 B081     add     sp,-4h                                  
0806C798 9000     str     r0,[sp]                                 
0806C79A 1C0D     mov     r5,r1                                   
0806C79C 0612     lsl     r2,r2,18h                               
0806C79E 4833     ldr     r0,=840E0C4h                            
0806C7A0 4681     mov     r9,r0                                   
0806C7A2 4933     ldr     r1,=840D74Ch                            
0806C7A4 4688     mov     r8,r1                                   
0806C7A6 230F     mov     r3,0Fh                                  
0806C7A8 469C     mov     r12,r3                                  
0806C7AA 0D16     lsr     r6,r2,14h                               
0806C7AC 4F31     ldr     r7,=840D6FCh                            
0806C7AE 2007     mov     r0,7h                                   
0806C7B0 4682     mov     r10,r0                                  
0806C7B2 8828     ldrh    r0,[r5]                                 
0806C7B4 3003     add     r0,3h                                   
0806C7B6 8028     strh    r0,[r5]                                 
0806C7B8 882A     ldrh    r2,[r5]                                 
0806C7BA 4649     mov     r1,r9                                   
0806C7BC 1850     add     r0,r2,r1                                
0806C7BE 7801     ldrb    r1,[r0]                                 
0806C7C0 1C08     mov     r0,r1                                   
0806C7C2 4663     mov     r3,r12                                  
0806C7C4 4018     and     r0,r3                                   
0806C7C6 1980     add     r0,r0,r6                                
0806C7C8 4440     add     r0,r8                                   
0806C7CA 0909     lsr     r1,r1,4h                                
0806C7CC 1989     add     r1,r1,r6                                
0806C7CE 19C9     add     r1,r1,r7                                
0806C7D0 7800     ldrb    r0,[r0]                                 
0806C7D2 780C     ldrb    r4,[r1]                                 
0806C7D4 4304     orr     r4,r0                                   
0806C7D6 3A01     sub     r2,1h                                   
0806C7D8 802A     strh    r2,[r5]                                 
0806C7DA 882B     ldrh    r3,[r5]                                 
0806C7DC 4649     mov     r1,r9                                   
0806C7DE 1858     add     r0,r3,r1                                
0806C7E0 7801     ldrb    r1,[r0]                                 
0806C7E2 1C08     mov     r0,r1                                   
0806C7E4 4662     mov     r2,r12                                  
0806C7E6 4010     and     r0,r2                                   
0806C7E8 1980     add     r0,r0,r6                                
0806C7EA 4440     add     r0,r8                                   
0806C7EC 0909     lsr     r1,r1,4h                                
0806C7EE 1989     add     r1,r1,r6                                
0806C7F0 19C9     add     r1,r1,r7                                
0806C7F2 7802     ldrb    r2,[r0]                                 
0806C7F4 7808     ldrb    r0,[r1]                                 
0806C7F6 4310     orr     r0,r2                                   
0806C7F8 0200     lsl     r0,r0,8h                                
0806C7FA 4304     orr     r4,r0                                   
0806C7FC 3B01     sub     r3,1h                                   
0806C7FE 802B     strh    r3,[r5]                                 
0806C800 882B     ldrh    r3,[r5]                                 
0806C802 4649     mov     r1,r9                                   
0806C804 1858     add     r0,r3,r1                                
0806C806 7801     ldrb    r1,[r0]                                 
0806C808 1C08     mov     r0,r1                                   
0806C80A 4662     mov     r2,r12                                  
0806C80C 4010     and     r0,r2                                   
0806C80E 1980     add     r0,r0,r6                                
0806C810 4440     add     r0,r8                                   
0806C812 0909     lsr     r1,r1,4h                                
0806C814 1989     add     r1,r1,r6                                
0806C816 19C9     add     r1,r1,r7                                
0806C818 7802     ldrb    r2,[r0]                                 
0806C81A 7808     ldrb    r0,[r1]                                 
0806C81C 4310     orr     r0,r2                                   
0806C81E 0400     lsl     r0,r0,10h                               
0806C820 4304     orr     r4,r0                                   
0806C822 1E58     sub     r0,r3,1                                 
0806C824 8028     strh    r0,[r5]                                 
0806C826 8828     ldrh    r0,[r5]                                 
0806C828 4448     add     r0,r9                                   
0806C82A 7801     ldrb    r1,[r0]                                 
0806C82C 1C08     mov     r0,r1                                   
0806C82E 4662     mov     r2,r12                                  
0806C830 4010     and     r0,r2                                   
0806C832 1980     add     r0,r0,r6                                
0806C834 4440     add     r0,r8                                   
0806C836 0909     lsr     r1,r1,4h                                
0806C838 1989     add     r1,r1,r6                                
0806C83A 19C9     add     r1,r1,r7                                
0806C83C 7802     ldrb    r2,[r0]                                 
0806C83E 7808     ldrb    r0,[r1]                                 
0806C840 4310     orr     r0,r2                                   
0806C842 0600     lsl     r0,r0,18h                               
0806C844 4304     orr     r4,r0                                   
0806C846 9800     ldr     r0,[sp]                                 
0806C848 C010     stmia   [r0]!,r4                                
0806C84A 9000     str     r0,[sp]                                 
0806C84C 3303     add     r3,3h                                   
0806C84E 802B     strh    r3,[r5]                                 
0806C850 2101     mov     r1,1h                                   
0806C852 4249     neg     r1,r1                                   
0806C854 448A     add     r10,r1                                  
0806C856 4652     mov     r2,r10                                  
0806C858 2A00     cmp     r2,0h                                   
0806C85A DAAA     bge     806C7B2h                                
0806C85C B001     add     sp,4h                                   
0806C85E BC38     pop     r3-r5                                   
0806C860 4698     mov     r8,r3                                   
0806C862 46A1     mov     r9,r4                                   
0806C864 46AA     mov     r10,r5                                  
0806C866 BCF0     pop     r4-r7                                   
0806C868 BC01     pop     r0                                      
0806C86A 4700     bx      r0                                      
0806C86C E0C4     b       806C9F8h                                
0806C86E 0840     lsr     r0,r0,1h                                
0806C870 D74C     bvc     806C90Ch                                
0806C872 0840     lsr     r0,r0,1h                                
0806C874 D6FC     bvs     806C870h                                
0806C876 0840     lsr     r0,r0,1h                                
0806C878 B5F0     push    r4-r7,r14                               
0806C87A 4657     mov     r7,r10                                  
0806C87C 464E     mov     r6,r9                                   
0806C87E 4645     mov     r5,r8                                   
0806C880 B4E0     push    r5-r7                                   
0806C882 4682     mov     r10,r0                                  
0806C884 1C0C     mov     r4,r1                                   
0806C886 0612     lsl     r2,r2,18h                               
0806C888 8820     ldrh    r0,[r4]                                 
0806C88A 301C     add     r0,1Ch                                  
0806C88C 8020     strh    r0,[r4]                                 
0806C88E 482E     ldr     r0,=840E0C4h                            
0806C890 4680     mov     r8,r0                                   
0806C892 492E     ldr     r1,=840D74Ch                            
0806C894 468C     mov     r12,r1                                  
0806C896 0D15     lsr     r5,r2,14h                               
0806C898 4F2D     ldr     r7,=840D6FCh                            
0806C89A 260F     mov     r6,0Fh                                  
0806C89C 2007     mov     r0,7h                                   
0806C89E 4681     mov     r9,r0                                   
0806C8A0 8822     ldrh    r2,[r4]                                 
0806C8A2 4641     mov     r1,r8                                   
0806C8A4 1850     add     r0,r2,r1                                
0806C8A6 7800     ldrb    r0,[r0]                                 
0806C8A8 0901     lsr     r1,r0,4h                                
0806C8AA 1949     add     r1,r1,r5                                
0806C8AC 4461     add     r1,r12                                  
0806C8AE 4030     and     r0,r6                                   
0806C8B0 1940     add     r0,r0,r5                                
0806C8B2 19C0     add     r0,r0,r7                                
0806C8B4 7809     ldrb    r1,[r1]                                 
0806C8B6 7803     ldrb    r3,[r0]                                 
0806C8B8 430B     orr     r3,r1                                   
0806C8BA 3201     add     r2,1h                                   
0806C8BC 8022     strh    r2,[r4]                                 
0806C8BE 8822     ldrh    r2,[r4]                                 
0806C8C0 4641     mov     r1,r8                                   
0806C8C2 1850     add     r0,r2,r1                                
0806C8C4 7800     ldrb    r0,[r0]                                 
0806C8C6 0901     lsr     r1,r0,4h                                
0806C8C8 1949     add     r1,r1,r5                                
0806C8CA 4461     add     r1,r12                                  
0806C8CC 4030     and     r0,r6                                   
0806C8CE 1940     add     r0,r0,r5                                
0806C8D0 19C0     add     r0,r0,r7                                
0806C8D2 7809     ldrb    r1,[r1]                                 
0806C8D4 7800     ldrb    r0,[r0]                                 
0806C8D6 4308     orr     r0,r1                                   
0806C8D8 0200     lsl     r0,r0,8h                                
0806C8DA 4303     orr     r3,r0                                   
0806C8DC 3201     add     r2,1h                                   
0806C8DE 8022     strh    r2,[r4]                                 
0806C8E0 8822     ldrh    r2,[r4]                                 
0806C8E2 4641     mov     r1,r8                                   
0806C8E4 1850     add     r0,r2,r1                                
0806C8E6 7800     ldrb    r0,[r0]                                 
0806C8E8 0901     lsr     r1,r0,4h                                
0806C8EA 1949     add     r1,r1,r5                                
0806C8EC 4461     add     r1,r12                                  
0806C8EE 4030     and     r0,r6                                   
0806C8F0 1940     add     r0,r0,r5                                
0806C8F2 19C0     add     r0,r0,r7                                
0806C8F4 7809     ldrb    r1,[r1]                                 
0806C8F6 7800     ldrb    r0,[r0]                                 
0806C8F8 4308     orr     r0,r1                                   
0806C8FA 0400     lsl     r0,r0,10h                               
0806C8FC 4303     orr     r3,r0                                   
0806C8FE 1C50     add     r0,r2,1                                 
0806C900 8020     strh    r0,[r4]                                 
0806C902 8820     ldrh    r0,[r4]                                 
0806C904 4440     add     r0,r8                                   
0806C906 7800     ldrb    r0,[r0]                                 
0806C908 0901     lsr     r1,r0,4h                                
0806C90A 1949     add     r1,r1,r5                                
0806C90C 4461     add     r1,r12                                  
0806C90E 4030     and     r0,r6                                   
0806C910 1940     add     r0,r0,r5                                
0806C912 19C0     add     r0,r0,r7                                
0806C914 7809     ldrb    r1,[r1]                                 
0806C916 7800     ldrb    r0,[r0]                                 
0806C918 4308     orr     r0,r1                                   
0806C91A 0600     lsl     r0,r0,18h                               
0806C91C 4303     orr     r3,r0                                   
0806C91E 4650     mov     r0,r10                                  
0806C920 3004     add     r0,4h                                   
0806C922 4682     mov     r10,r0                                  
0806C924 3804     sub     r0,4h                                   
0806C926 C008     stmia   [r0]!,r3                                
0806C928 3A06     sub     r2,6h                                   
0806C92A 8022     strh    r2,[r4]                                 
0806C92C 2101     mov     r1,1h                                   
0806C92E 4249     neg     r1,r1                                   
0806C930 4489     add     r9,r1                                   
0806C932 4648     mov     r0,r9                                   
0806C934 2800     cmp     r0,0h                                   
0806C936 DAB3     bge     806C8A0h                                
0806C938 BC38     pop     r3-r5                                   
0806C93A 4698     mov     r8,r3                                   
0806C93C 46A1     mov     r9,r4                                   
0806C93E 46AA     mov     r10,r5                                  
0806C940 BCF0     pop     r4-r7                                   
0806C942 BC01     pop     r0                                      
0806C944 4700     bx      r0                                      
0806C946 0000     lsl     r0,r0,0h                                
0806C948 E0C4     b       806CAD4h                                
0806C94A 0840     lsr     r0,r0,1h                                
0806C94C D74C     bvc     806C9E8h                                
0806C94E 0840     lsr     r0,r0,1h                                
0806C950 D6FC     bvs     806C94Ch                                
0806C952 0840     lsr     r0,r0,1h                                
0806C954 B5F0     push    r4-r7,r14                               
0806C956 4657     mov     r7,r10                                  
0806C958 464E     mov     r6,r9                                   
0806C95A 4645     mov     r5,r8                                   
0806C95C B4E0     push    r5-r7                                   
0806C95E B081     add     sp,-4h                                  
0806C960 9000     str     r0,[sp]                                 
0806C962 1C0D     mov     r5,r1                                   
0806C964 0612     lsl     r2,r2,18h                               
0806C966 8828     ldrh    r0,[r5]                                 
0806C968 301F     add     r0,1Fh                                  
0806C96A 8028     strh    r0,[r5]                                 
0806C96C 4832     ldr     r0,=840E0C4h                            
0806C96E 4681     mov     r9,r0                                   
0806C970 4932     ldr     r1,=840D74Ch                            
0806C972 4688     mov     r8,r1                                   
0806C974 230F     mov     r3,0Fh                                  
0806C976 469C     mov     r12,r3                                  
0806C978 0D16     lsr     r6,r2,14h                               
0806C97A 4F31     ldr     r7,=840D6FCh                            
0806C97C 2007     mov     r0,7h                                   
0806C97E 4682     mov     r10,r0                                  
0806C980 882A     ldrh    r2,[r5]                                 
0806C982 4649     mov     r1,r9                                   
0806C984 1850     add     r0,r2,r1                                
0806C986 7801     ldrb    r1,[r0]                                 
0806C988 1C08     mov     r0,r1                                   
0806C98A 4663     mov     r3,r12                                  
0806C98C 4018     and     r0,r3                                   
0806C98E 1980     add     r0,r0,r6                                
0806C990 4440     add     r0,r8                                   
0806C992 0909     lsr     r1,r1,4h                                
0806C994 1989     add     r1,r1,r6                                
0806C996 19C9     add     r1,r1,r7                                
0806C998 7800     ldrb    r0,[r0]                                 
0806C99A 780C     ldrb    r4,[r1]                                 
0806C99C 4304     orr     r4,r0                                   
0806C99E 3A01     sub     r2,1h                                   
0806C9A0 802A     strh    r2,[r5]                                 
0806C9A2 882B     ldrh    r3,[r5]                                 
0806C9A4 4649     mov     r1,r9                                   
0806C9A6 1858     add     r0,r3,r1                                
0806C9A8 7801     ldrb    r1,[r0]                                 
0806C9AA 1C08     mov     r0,r1                                   
0806C9AC 4662     mov     r2,r12                                  
0806C9AE 4010     and     r0,r2                                   
0806C9B0 1980     add     r0,r0,r6                                
0806C9B2 4440     add     r0,r8                                   
0806C9B4 0909     lsr     r1,r1,4h                                
0806C9B6 1989     add     r1,r1,r6                                
0806C9B8 19C9     add     r1,r1,r7                                
0806C9BA 7802     ldrb    r2,[r0]                                 
0806C9BC 7808     ldrb    r0,[r1]                                 
0806C9BE 4310     orr     r0,r2                                   
0806C9C0 0200     lsl     r0,r0,8h                                
0806C9C2 4304     orr     r4,r0                                   
0806C9C4 3B01     sub     r3,1h                                   
0806C9C6 802B     strh    r3,[r5]                                 
0806C9C8 882B     ldrh    r3,[r5]                                 
0806C9CA 4649     mov     r1,r9                                   
0806C9CC 1858     add     r0,r3,r1                                
0806C9CE 7801     ldrb    r1,[r0]                                 
0806C9D0 1C08     mov     r0,r1                                   
0806C9D2 4662     mov     r2,r12                                  
0806C9D4 4010     and     r0,r2                                   
0806C9D6 1980     add     r0,r0,r6                                
0806C9D8 4440     add     r0,r8                                   
0806C9DA 0909     lsr     r1,r1,4h                                
0806C9DC 1989     add     r1,r1,r6                                
0806C9DE 19C9     add     r1,r1,r7                                
0806C9E0 7802     ldrb    r2,[r0]                                 
0806C9E2 7808     ldrb    r0,[r1]                                 
0806C9E4 4310     orr     r0,r2                                   
0806C9E6 0400     lsl     r0,r0,10h                               
0806C9E8 4304     orr     r4,r0                                   
0806C9EA 3B01     sub     r3,1h                                   
0806C9EC 802B     strh    r3,[r5]                                 
0806C9EE 882B     ldrh    r3,[r5]                                 
0806C9F0 4649     mov     r1,r9                                   
0806C9F2 1858     add     r0,r3,r1                                
0806C9F4 7801     ldrb    r1,[r0]                                 
0806C9F6 1C08     mov     r0,r1                                   
0806C9F8 4662     mov     r2,r12                                  
0806C9FA 4010     and     r0,r2                                   
0806C9FC 1980     add     r0,r0,r6                                
0806C9FE 4440     add     r0,r8                                   
0806CA00 0909     lsr     r1,r1,4h                                
0806CA02 1989     add     r1,r1,r6                                
0806CA04 19C9     add     r1,r1,r7                                
0806CA06 7802     ldrb    r2,[r0]                                 
0806CA08 7808     ldrb    r0,[r1]                                 
0806CA0A 4310     orr     r0,r2                                   
0806CA0C 0600     lsl     r0,r0,18h                               
0806CA0E 4304     orr     r4,r0                                   
0806CA10 3B01     sub     r3,1h                                   
0806CA12 802B     strh    r3,[r5]                                 
0806CA14 9B00     ldr     r3,[sp]                                 
0806CA16 C310     stmia   [r3]!,r4                                
0806CA18 9300     str     r3,[sp]                                 
0806CA1A 2001     mov     r0,1h                                   
0806CA1C 4240     neg     r0,r0                                   
0806CA1E 4482     add     r10,r0                                  
0806CA20 4651     mov     r1,r10                                  
0806CA22 2900     cmp     r1,0h                                   
0806CA24 DAAC     bge     806C980h                                
0806CA26 B001     add     sp,4h                                   
0806CA28 BC38     pop     r3-r5                                   
0806CA2A 4698     mov     r8,r3                                   
0806CA2C 46A1     mov     r9,r4                                   
0806CA2E 46AA     mov     r10,r5                                  
0806CA30 BCF0     pop     r4-r7                                   
0806CA32 BC01     pop     r0                                      
0806CA34 4700     bx      r0                                      
0806CA36 0000     lsl     r0,r0,0h                                
0806CA38 E0C4     b       806CBC4h                                
0806CA3A 0840     lsr     r0,r0,1h                                
0806CA3C D74C     bvc     806CAD8h                                
0806CA3E 0840     lsr     r0,r0,1h                                
0806CA40 D6FC     bvs     806CA3Ch                                
0806CA42 0840     lsr     r0,r0,1h                                
0806CA44 B5F0     push    r4-r7,r14                               
0806CA46 4647     mov     r7,r8                                   
0806CA48 B480     push    r7                                      
0806CA4A 468C     mov     r12,r1                                  
0806CA4C 0600     lsl     r0,r0,18h                               
0806CA4E 0E00     lsr     r0,r0,18h                               
0806CA50 2807     cmp     r0,7h                                   
0806CA52 D824     bhi     806CA9Eh                                
0806CA54 01C0     lsl     r0,r0,7h                                
0806CA56 4914     ldr     r1,=2033800h                            
0806CA58 1842     add     r2,r0,r1                                
0806CA5A 2300     mov     r3,0h                                   
0806CA5C 4813     ldr     r0,=8760218h                            
0806CA5E 4680     mov     r8,r0                                   
0806CA60 CA01     ldmia   [r2]!,r0                                
0806CA62 1C5E     add     r6,r3,1                                 
0806CA64 1C17     mov     r7,r2                                   
0806CA66 2800     cmp     r0,0h                                   
0806CA68 D015     beq     806CA96h                                
0806CA6A 1C04     mov     r4,r0                                   
0806CA6C 2500     mov     r5,0h                                   
0806CA6E 0198     lsl     r0,r3,6h                                
0806CA70 4661     mov     r1,r12                                  
0806CA72 1843     add     r3,r0,r1                                
0806CA74 4641     mov     r1,r8                                   
0806CA76 680A     ldr     r2,[r1]                                 
0806CA78 1C20     mov     r0,r4                                   
0806CA7A 4010     and     r0,r2                                   
0806CA7C 2800     cmp     r0,0h                                   
0806CA7E D003     beq     806CA88h                                
0806CA80 4054     eor     r4,r2                                   
0806CA82 8818     ldrh    r0,[r3]                                 
0806CA84 3001     add     r0,1h                                   
0806CA86 8018     strh    r0,[r3]                                 
0806CA88 3302     add     r3,2h                                   
0806CA8A 3104     add     r1,4h                                   
0806CA8C 3501     add     r5,1h                                   
0806CA8E 2D1F     cmp     r5,1Fh                                  
0806CA90 DC01     bgt     806CA96h                                
0806CA92 2C00     cmp     r4,0h                                   
0806CA94 D1EF     bne     806CA76h                                
0806CA96 1C33     mov     r3,r6                                   
0806CA98 1C3A     mov     r2,r7                                   
0806CA9A 2B1F     cmp     r3,1Fh                                  
0806CA9C DDE0     ble     806CA60h                                
0806CA9E BC08     pop     r3                                      
0806CAA0 4698     mov     r8,r3                                   
0806CAA2 BCF0     pop     r4-r7                                   
0806CAA4 BC01     pop     r0                                      
0806CAA6 4700     bx      r0                                      
0806CAA8 3800     sub     r0,0h                                   
0806CAAA 0203     lsl     r3,r0,8h                                
0806CAAC 0218     lsl     r0,r3,8h                                
0806CAAE 0876     lsr     r6,r6,1h                                
0806CAB0 B5F0     push    r4-r7,r14                               
0806CAB2 4657     mov     r7,r10                                  
0806CAB4 464E     mov     r6,r9                                   
0806CAB6 4645     mov     r5,r8                                   
0806CAB8 B4E0     push    r5-r7                                   
0806CABA B081     add     sp,-4h                                  
0806CABC 1C0A     mov     r2,r1                                   
0806CABE 0600     lsl     r0,r0,18h                               
0806CAC0 0E04     lsr     r4,r0,18h                               
0806CAC2 4818     ldr     r0,=8754BC0h                            
0806CAC4 01E1     lsl     r1,r4,7h                                
0806CAC6 6800     ldr     r0,[r0]                                 
0806CAC8 1843     add     r3,r0,r1                                
0806CACA 4817     ldr     r0,=3001530h                            
0806CACC 7C00     ldrb    r0,[r0,10h]                             
0806CACE 4120     asr     r0,r4                                   
0806CAD0 2101     mov     r1,1h                                   
0806CAD2 4008     and     r0,r1                                   
0806CAD4 2800     cmp     r0,0h                                   
0806CAD6 D105     bne     806CAE4h                                
0806CAD8 1C20     mov     r0,r4                                   
0806CADA 3808     sub     r0,8h                                   
0806CADC 0600     lsl     r0,r0,18h                               
0806CADE 0E00     lsr     r0,r0,18h                               
0806CAE0 2802     cmp     r0,2h                                   
0806CAE2 D841     bhi     806CB68h                                
0806CAE4 2100     mov     r1,0h                                   
0806CAE6 20F0     mov     r0,0F0h                                 
0806CAE8 0200     lsl     r0,r0,8h                                
0806CAEA 4682     mov     r10,r0                                  
0806CAEC 4D0F     ldr     r5,=2FFFh                               
0806CAEE 46A8     mov     r8,r5                                   
0806CAF0 20C0     mov     r0,0C0h                                 
0806CAF2 0180     lsl     r0,r0,6h                                
0806CAF4 4681     mov     r9,r0                                   
0806CAF6 4D0E     ldr     r5,=0FFFh                               
0806CAF8 46AC     mov     r12,r5                                  
0806CAFA CB01     ldmia   [r3]!,r0                                
0806CAFC 1C4E     add     r6,r1,1                                 
0806CAFE 1C1F     mov     r7,r3                                   
0806CB00 9000     str     r0,[sp]                                 
0806CB02 4B0C     ldr     r3,=8760218h                            
0806CB04 241F     mov     r4,1Fh                                  
0806CB06 6818     ldr     r0,[r3]                                 
0806CB08 9900     ldr     r1,[sp]                                 
0806CB0A 4008     and     r0,r1                                   
0806CB0C 2800     cmp     r0,0h                                   
0806CB0E D013     beq     806CB38h                                
0806CB10 8811     ldrh    r1,[r2]                                 
0806CB12 4650     mov     r0,r10                                  
0806CB14 4008     and     r0,r1                                   
0806CB16 2800     cmp     r0,0h                                   
0806CB18 D11C     bne     806CB54h                                
0806CB1A 2580     mov     r5,80h                                  
0806CB1C 016D     lsl     r5,r5,5h                                
0806CB1E 1C28     mov     r0,r5                                   
0806CB20 4308     orr     r0,r1                                   
0806CB22 E016     b       806CB52h                                
0806CB24 4BC0     ldr     r3,=840D224h                            
0806CB26 0875     lsr     r5,r6,1h                                
0806CB28 1530     asr     r0,r6,14h                               
0806CB2A 0300     lsl     r0,r0,0Ch                               
0806CB2C 2FFF     cmp     r7,0FFh                                 
0806CB2E 0000     lsl     r0,r0,0h                                
0806CB30 0FFF     lsr     r7,r7,1Fh                               
0806CB32 0000     lsl     r0,r0,0h                                
0806CB34 0218     lsl     r0,r3,8h                                
0806CB36 0876     lsr     r6,r6,1h                                
0806CB38 8811     ldrh    r1,[r2]                                 
0806CB3A 4541     cmp     r1,r8                                   
0806CB3C D903     bls     806CB46h                                
0806CB3E 21A0     mov     r1,0A0h                                 
0806CB40 0049     lsl     r1,r1,1h                                
0806CB42 1C08     mov     r0,r1                                   
0806CB44 E005     b       806CB52h                                
0806CB46 4648     mov     r0,r9                                   
0806CB48 4008     and     r0,r1                                   
0806CB4A 2800     cmp     r0,0h                                   
0806CB4C D002     beq     806CB54h                                
0806CB4E 4660     mov     r0,r12                                  
0806CB50 4008     and     r0,r1                                   
0806CB52 8010     strh    r0,[r2]                                 
0806CB54 3304     add     r3,4h                                   
0806CB56 3C01     sub     r4,1h                                   
0806CB58 3202     add     r2,2h                                   
0806CB5A 2C00     cmp     r4,0h                                   
0806CB5C DAD3     bge     806CB06h                                
0806CB5E 1C31     mov     r1,r6                                   
0806CB60 1C3B     mov     r3,r7                                   
0806CB62 291F     cmp     r1,1Fh                                  
0806CB64 DDC9     ble     806CAFAh                                
0806CB66 E02F     b       806CBC8h                                
0806CB68 2100     mov     r1,0h                                   
0806CB6A 4D0D     ldr     r5,=8760218h                            
0806CB6C 46A8     mov     r8,r5                                   
0806CB6E 20F0     mov     r0,0F0h                                 
0806CB70 0200     lsl     r0,r0,8h                                
0806CB72 4684     mov     r12,r0                                  
0806CB74 CB01     ldmia   [r3]!,r0                                
0806CB76 1C4E     add     r6,r1,1                                 
0806CB78 1C1F     mov     r7,r3                                   
0806CB7A 4681     mov     r9,r0                                   
0806CB7C 4643     mov     r3,r8                                   
0806CB7E 241F     mov     r4,1Fh                                  
0806CB80 6818     ldr     r0,[r3]                                 
0806CB82 4649     mov     r1,r9                                   
0806CB84 4008     and     r0,r1                                   
0806CB86 2800     cmp     r0,0h                                   
0806CB88 D00C     beq     806CBA4h                                
0806CB8A 8811     ldrh    r1,[r2]                                 
0806CB8C 4660     mov     r0,r12                                  
0806CB8E 4008     and     r0,r1                                   
0806CB90 2800     cmp     r0,0h                                   
0806CB92 D110     bne     806CBB6h                                
0806CB94 2580     mov     r5,80h                                  
0806CB96 016D     lsl     r5,r5,5h                                
0806CB98 1C28     mov     r0,r5                                   
0806CB9A 4308     orr     r0,r1                                   
0806CB9C E00A     b       806CBB4h                                
0806CB9E 0000     lsl     r0,r0,0h                                
0806CBA0 0218     lsl     r0,r3,8h                                
0806CBA2 0876     lsr     r6,r6,1h                                
0806CBA4 8811     ldrh    r1,[r2]                                 
0806CBA6 4660     mov     r0,r12                                  
0806CBA8 4008     and     r0,r1                                   
0806CBAA 2800     cmp     r0,0h                                   
0806CBAC D003     beq     806CBB6h                                
0806CBAE 21A0     mov     r1,0A0h                                 
0806CBB0 0049     lsl     r1,r1,1h                                
0806CBB2 1C08     mov     r0,r1                                   



                                     
