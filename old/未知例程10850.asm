

08010738 B5F0     push    r4-r7,r14                               
0801073A 0600     lsl     r0,r0,18h                               
0801073C 0E06     lsr     r6,r0,18h     ;1b                           
0801073E 2400     mov     r4,0h                                   
08010740 4813     ldr     r0,=3000738h                            
08010742 3023     add     r0,23h                                  
08010744 7805     ldrb    r5,[r0]       ;获取主精灵序号                          
08010746 4A13     ldr     r2,=30001ACh                            
08010748 21A8     mov     r1,0A8h                                 
0801074A 00C9     lsl     r1,r1,3h                                
0801074C 1850     add     r0,r2,r1                                
0801074E 4282     cmp     r2,r0                                   
08010750 D219     bcs     @@end      ;大于或等于跳转                          
08010752 1C07     mov     r7,r0                                   
08010754 1C13     mov     r3,r2                                   
08010756 3323     add     r3,23h 

@@Loop:                                 
08010758 8811     ldrh    r1,[r2]    ;范精灵取向                             
0801075A 2001     mov     r0,1h                                   
0801075C 4008     and     r0,r1      ;1and                             
0801075E 2800     cmp     r0,0h                                   
08010760 D00D     beq     @@Pass     ;检查是否存在这个精灵                           
08010762 7BD9     ldrb    r1,[r3,0Fh]                             
08010764 2080     mov     r0,80h                                  
08010766 4008     and     r0,r1      ;碰撞属性and80                             
08010768 2800     cmp     r0,0h                                   
0801076A D008     beq     @@Pass     ;检查是否是副精灵                           
0801076C 7F50     ldrb    r0,[r2,1Dh]                             
0801076E 42B0     cmp     r0,r6      ;检查副精灵的ID                             
08010770 D105     bne     @@Pass                                
08010772 7818     ldrb    r0,[r3]                                 
08010774 42A8     cmp     r0,r5      ;比较副精灵的主精灵序号                             
08010776 D102     bne     @@Pass                                
08010778 1C60     add     r0,r4,1                                 
0801077A 0600     lsl     r0,r0,18h                               
0801077C 0E04     lsr     r4,r0,18h  

@@Pass:                               
0801077E 3338     add     r3,38h                                  
08010780 3238     add     r2,38h                                  
08010782 42BA     cmp     r2,r7                                   
08010784 D3E8     bcc     @@Loop 

@@end:                               
08010786 1C20     mov     r0,r4                                   
08010788 BCF0     pop     r4-r7                                   
0801078A BC02     pop     r1                                      
0801078C 4708     bx      r1                                      


                               
08010798 B5F0     push    r4-r7,r14                               
0801079A 0600     lsl     r0,r0,18h                               
0801079C 0E06     lsr     r6,r0,18h                               
0801079E 2400     mov     r4,0h                                   
080107A0 4813     ldr     r0,=3000738h                            
080107A2 3023     add     r0,23h                                  
080107A4 7805     ldrb    r5,[r0]                                 
080107A6 4A13     ldr     r2,=30001ACh                            
080107A8 21A8     mov     r1,0A8h                                 
080107AA 00C9     lsl     r1,r1,3h                                
080107AC 1850     add     r0,r2,r1                                
080107AE 4282     cmp     r2,r0                                   
080107B0 D219     bcs     80107E6h                                
080107B2 1C07     mov     r7,r0                                   
080107B4 1C13     mov     r3,r2                                   
080107B6 3323     add     r3,23h                                  
080107B8 8811     ldrh    r1,[r2]                                 
080107BA 2001     mov     r0,1h                                   
080107BC 4008     and     r0,r1                                   
080107BE 2800     cmp     r0,0h                                   
080107C0 D00D     beq     80107DEh                                
080107C2 7BD9     ldrb    r1,[r3,0Fh]                             
080107C4 2080     mov     r0,80h                                  
080107C6 4008     and     r0,r1                                   
080107C8 2800     cmp     r0,0h                                   
080107CA D108     bne     80107DEh                                
080107CC 7F50     ldrb    r0,[r2,1Dh]                             
080107CE 42B0     cmp     r0,r6                                   
080107D0 D105     bne     80107DEh                                
080107D2 7818     ldrb    r0,[r3]                                 
080107D4 42A8     cmp     r0,r5                                   
080107D6 D102     bne     80107DEh                                
080107D8 1C60     add     r0,r4,1                                 
080107DA 0600     lsl     r0,r0,18h                               
080107DC 0E04     lsr     r4,r0,18h                               
080107DE 3338     add     r3,38h                                  
080107E0 3238     add     r2,38h                                  
080107E2 42BA     cmp     r2,r7                                   
080107E4 D3E8     bcc     80107B8h                                
080107E6 1C20     mov     r0,r4                                   
080107E8 BCF0     pop     r4-r7                                   
080107EA BC02     pop     r1                                      
080107EC 4708     bx      r1                                      
080107EE 0000     lsl     r0,r0,0h                                
080107F0 0738     lsl     r0,r7,1Ch                               
080107F2 0300     lsl     r0,r0,0Ch                               
080107F4 01AC     lsl     r4,r5,6h                                
080107F6 0300     lsl     r0,r0,0Ch                               
080107F8 B530     push    r4,r5,r14                               
080107FA 0600     lsl     r0,r0,18h                               
080107FC 0E05     lsr     r5,r0,18h                               
080107FE 2400     mov     r4,0h                                   
08010800 4A0B     ldr     r2,=30001ACh                            
08010802 21A8     mov     r1,0A8h                                 
08010804 00C9     lsl     r1,r1,3h                                
08010806 1850     add     r0,r2,r1                                
08010808 4282     cmp     r2,r0                                   
0801080A D21B     bcs     8010844h                                
0801080C 1C13     mov     r3,r2                                   
0801080E 331D     add     r3,1Dh                                  
08010810 8811     ldrh    r1,[r2]                                 
08010812 2001     mov     r0,1h                                   
08010814 4008     and     r0,r1                                   
08010816 2800     cmp     r0,0h                                   
08010818 D00C     beq     8010834h                                
0801081A 7D59     ldrb    r1,[r3,15h]                             
0801081C 2080     mov     r0,80h                                  
0801081E 4008     and     r0,r1                                   
08010820 2800     cmp     r0,0h                                   
08010822 D107     bne     8010834h                                
08010824 7818     ldrb    r0,[r3]                                 
08010826 42A8     cmp     r0,r5                                   
08010828 D104     bne     8010834h                                
0801082A 1C20     mov     r0,r4                                   
0801082C E00B     b       8010846h                                
0801082E 0000     lsl     r0,r0,0h                                
08010830 01AC     lsl     r4,r5,6h                                
08010832 0300     lsl     r0,r0,0Ch                               
08010834 1C60     add     r0,r4,1                                 
08010836 0600     lsl     r0,r0,18h                               
08010838 0E04     lsr     r4,r0,18h                               
0801083A 3338     add     r3,38h                                  
0801083C 3238     add     r2,38h                                  
0801083E 4803     ldr     r0,=30006ECh                            
08010840 4282     cmp     r2,r0                                   
08010842 D3E5     bcc     8010810h                                
08010844 20FF     mov     r0,0FFh                                 
08010846 BC30     pop     r4,r5                                   
08010848 BC02     pop     r1                                      
0801084A 4708     bx      r1                                      



08010850 B570     push    r4-r6,r14                               
08010852 0600     lsl     r0,r0,18h                               
08010854 0E06     lsr     r6,r0,18h       ;32                           
08010856 0609     lsl     r1,r1,18h                              
08010858 0E0D     lsr     r5,r1,18h       ;1                     
0801085A 2400     mov     r4,0h                                   
0801085C 4B0C     ldr     r3,=30001ACh                            
0801085E 21A8     mov     r1,0A8h                                 
08010860 00C9     lsl     r1,r1,3h                                
08010862 1858     add     r0,r3,r1                                
08010864 4283     cmp     r3,r0                                   
08010866 D21D     bcs     @@NoHave                                
08010868 1C1A     mov     r2,r3                                   
0801086A 321D     add     r2,1Dh 

@@loop:                            
0801086C 8819     ldrh    r1,[r3]                                 
0801086E 2001     mov     r0,1h                                   
08010870 4008     and     r0,r1           ;1 and id                           
08010872 2800     cmp     r0,0h           ;用于排除奇数ID??                        
08010874 D00E     beq     @@pass                                
08010876 7D51     ldrb    r1,[r2,15h]                             
08010878 2080     mov     r0,80h          ;读取碰撞属性                        
0801087A 4008     and     r0,r1           ;80 and                        
0801087C 2800     cmp     r0,0h           ;用于检测是否是副精灵                        
0801087E D009     beq     @@pass                                
08010880 7810     ldrb    r0,[r2]                                 
08010882 42B0     cmp     r0,r6           ;比较ID是否是32是否是32                        
08010884 D106     bne     @@pass                                
08010886 7850     ldrb    r0,[r2,1h]                              
08010888 42A8     cmp     r0,r5           ;比较精灵data设置的是否是1                         
0801088A D103     bne     @@pass                                
0801088C 1C20     mov     r0,r4                                   
0801088E E00A     b       @@end                                

@@pass:                               
08010894 1C60     add     r0,r4,1                                 
08010896 0600     lsl     r0,r0,18h                               
08010898 0E04     lsr     r4,r0,18h                               
0801089A 3238     add     r2,38h                                  
0801089C 3338     add     r3,38h                                  
0801089E 4803     ldr     r0,=30006ECh                            
080108A0 4283     cmp     r3,r0                                   
080108A2 D3E3     bcc     @@loop

@@NoHave:                                
080108A4 20FF     mov     r0,0FFh 

@@end:                                
080108A6 BC70     pop     r4-r6                                   
080108A8 BC02     pop     r1                                      
080108AA 4708     bx      r1                                      

                              
080108B0 B5F0     push    r4-r7,r14                               
080108B2 480D     ldr     r0,=3000738h                            
080108B4 3023     add     r0,23h                                  
080108B6 7804     ldrb    r4,[r0]       ;获取主精灵序号                             
080108B8 271F     mov     r7,1Fh                                  
080108BA 4A0C     ldr     r2,=30001ACh                            
080108BC 21A8     mov     r1,0A8h                                 
080108BE 00C9     lsl     r1,r1,3h                                
080108C0 1850     add     r0,r2,r1                                
080108C2 4282     cmp     r2,r0                                   
080108C4 D218     bcs     @@end                                
080108C6 2601     mov     r6,1h                                   
080108C8 1C13     mov     r3,r2                                   
080108CA 3323     add     r3,23h                                  
080108CC 1C05     mov     r5,r0  

@@Loop:                                 
080108CE 8811     ldrh    r1,[r2]      ;读取范精灵取向                           
080108D0 1C30     mov     r0,r6                                   
080108D2 4008     and     r0,r1        ;1 and 取向                           
080108D4 2800     cmp     r0,0h                                   
080108D6 D00B     beq     @@Pass                                
080108D8 7818     ldrb    r0,[r3]                                 
080108DA 42A0     cmp     r0,r4        ;比较两者的主序号                          
080108DC D108     bne     @@Pass                                
080108DE 7898     ldrb    r0,[r3,2h]                              
080108E0 42B8     cmp     r0,r7        ;比较属性如果小于1F不合格                           
080108E2 D305     bcc     @@Pass                                
080108E4 2001     mov     r0,1h                                   
080108E6 E008     b       @@return1                                  

@@Pass:                             
080108F0 3338     add     r3,38h                                  
080108F2 3238     add     r2,38h                                  
080108F4 42AA     cmp     r2,r5                                   
080108F6 D3EA     bcc     @@Loop 

@@end:                               
080108F8 2000     mov     r0,0h 

@@return1:                                  
080108FA BCF0     pop     r4-r7                                   
080108FC BC02     pop     r1                                      
080108FE 4708     bx      r1  

                                    
08010900 B570     push    r4-r6,r14                               
08010902 2300     mov     r3,0h                                   
08010904 261F     mov     r6,1Fh                                  
08010906 4A0E     ldr     r2,=30001ACh                            
08010908 21A8     mov     r1,0A8h                                 
0801090A 00C9     lsl     r1,r1,3h                                
0801090C 1850     add     r0,r2,r1                                
0801090E 4282     cmp     r2,r0                                   
08010910 D211     bcs     8010936h                                
08010912 2501     mov     r5,1h                                   
08010914 1C04     mov     r4,r0                                   
08010916 8811     ldrh    r1,[r2]                                 
08010918 1C28     mov     r0,r5                                   
0801091A 4008     and     r0,r1                                   
0801091C 2800     cmp     r0,0h                                   
0801091E D007     beq     8010930h                                
08010920 1C10     mov     r0,r2                                   
08010922 3025     add     r0,25h                                  
08010924 7800     ldrb    r0,[r0]                                 
08010926 42B0     cmp     r0,r6                                   
08010928 D302     bcc     8010930h                                
0801092A 1C58     add     r0,r3,1                                 
0801092C 0600     lsl     r0,r0,18h                               
0801092E 0E03     lsr     r3,r0,18h                               
08010930 3238     add     r2,38h                                  
08010932 42A2     cmp     r2,r4                                   
08010934 D3EF     bcc     8010916h                                
08010936 1C18     mov     r0,r3                                   
08010938 BC70     pop     r4-r6                                   
0801093A BC02     pop     r1                                      
0801093C 4708     bx      r1                                      
0801093E 0000     lsl     r0,r0,0h                                
08010940 01AC     lsl     r4,r5,6h                                
08010942 0300     lsl     r0,r0,0Ch                               
08010944 B5F0     push    r4-r7,r14                               
08010946 4657     mov     r7,r10                                  
08010948 464E     mov     r6,r9                                   
0801094A 4645     mov     r5,r8                                   
0801094C B4E0     push    r5-r7                                   
0801094E B081     add     sp,-4h                                  
08010950 9C09     ldr     r4,[sp,24h]                             
08010952 0400     lsl     r0,r0,10h                               
08010954 0C00     lsr     r0,r0,10h                               
08010956 4682     mov     r10,r0                                  
08010958 0409     lsl     r1,r1,10h                               
0801095A 0C0D     lsr     r5,r1,10h                               
0801095C 1C2F     mov     r7,r5                                   
0801095E 0612     lsl     r2,r2,18h                               
08010960 0E12     lsr     r2,r2,18h                               
08010962 9200     str     r2,[sp]                                 
08010964 061B     lsl     r3,r3,18h                               
08010966 0E1B     lsr     r3,r3,18h                               
08010968 4698     mov     r8,r3                                   
0801096A 0624     lsl     r4,r4,18h                               
0801096C 0E24     lsr     r4,r4,18h                               
0801096E 2000     mov     r0,0h                                   
08010970 4681     mov     r9,r0                                   
08010972 4911     ldr     r1,=3000738h                            
08010974 468C     mov     r12,r1                                  
08010976 8809     ldrh    r1,[r1]                                 
08010978 2080     mov     r0,80h                                  
0801097A 0080     lsl     r0,r0,2h                                
0801097C 4008     and     r0,r1                                   
0801097E 0400     lsl     r0,r0,10h                               
08010980 0C06     lsr     r6,r0,10h                               
08010982 2E00     cmp     r6,0h                                   
08010984 D027     beq     80109D6h                                
08010986 4662     mov     r2,r12                                  
08010988 322D     add     r2,2Dh                                  
0801098A 7810     ldrb    r0,[r2]                                 
0801098C 2800     cmp     r0,0h                                   
0801098E D115     bne     80109BCh                                
08010990 4666     mov     r6,r12                                  
08010992 88B1     ldrh    r1,[r6,4h]                              
08010994 1F28     sub     r0,r5,4                                 
08010996 4281     cmp     r1,r0                                   
08010998 DC28     bgt     80109ECh                                
0801099A 4661     mov     r1,r12                                  
0801099C 312E     add     r1,2Eh                                  
0801099E 7808     ldrb    r0,[r1]                                 
080109A0 4298     cmp     r0,r3                                   
080109A2 D201     bcs     80109A8h                                
080109A4 3001     add     r0,1h                                   
080109A6 7008     strb    r0,[r1]                                 
080109A8 7808     ldrb    r0,[r1]                                 
080109AA 4120     asr     r0,r4                                   
080109AC 4661     mov     r1,r12                                  
080109AE 8889     ldrh    r1,[r1,4h]                              
080109B0 1840     add     r0,r0,r1                                
080109B2 4662     mov     r2,r12                                  
080109B4 8090     strh    r0,[r2,4h]                              
080109B6 E04D     b       8010A54h                                
080109B8 0738     lsl     r0,r7,1Ch                               
080109BA 0300     lsl     r0,r0,0Ch                               
080109BC 3801     sub     r0,1h                                   
080109BE 7010     strb    r0,[r2]                                 
080109C0 0600     lsl     r0,r0,18h                               
080109C2 2800     cmp     r0,0h                                   
080109C4 D049     beq     8010A5Ah                                
080109C6 7810     ldrb    r0,[r2]                                 
080109C8 4120     asr     r0,r4                                   
080109CA 4663     mov     r3,r12                                  
080109CC 889B     ldrh    r3,[r3,4h]                              
080109CE 18C0     add     r0,r0,r3                                
080109D0 4666     mov     r6,r12                                  
080109D2 80B0     strh    r0,[r6,4h]                              
080109D4 E03E     b       8010A54h                                
080109D6 4662     mov     r2,r12                                  
080109D8 322D     add     r2,2Dh                                  
080109DA 7810     ldrb    r0,[r2]                                 
080109DC 1C05     mov     r5,r0                                   
080109DE 2D00     cmp     r5,0h                                   
080109E0 D11E     bne     8010A20h                                
080109E2 4660     mov     r0,r12                                  
080109E4 8883     ldrh    r3,[r0,4h]                              
080109E6 1D38     add     r0,r7,4                                 
080109E8 4283     cmp     r3,r0                                   
080109EA DA04     bge     80109F6h                                
080109EC 4660     mov     r0,r12                                  
080109EE 302E     add     r0,2Eh                                  
080109F0 7800     ldrb    r0,[r0]                                 
080109F2 7010     strb    r0,[r2]                                 
080109F4 E02E     b       8010A54h                                
080109F6 4661     mov     r1,r12                                  
080109F8 312E     add     r1,2Eh                                  
080109FA 7808     ldrb    r0,[r1]                                 
080109FC 4540     cmp     r0,r8                                   
080109FE D201     bcs     8010A04h                                
08010A00 3001     add     r0,1h                                   
08010A02 7008     strb    r0,[r1]                                 
08010A04 7808     ldrb    r0,[r1]                                 
08010A06 4120     asr     r0,r4                                   
08010A08 0400     lsl     r0,r0,10h                               
08010A0A 0C01     lsr     r1,r0,10h                               
08010A0C 1A59     sub     r1,r3,r1                                
08010A0E 2080     mov     r0,80h                                  
08010A10 0200     lsl     r0,r0,8h                                
08010A12 4008     and     r0,r1                                   
08010A14 2800     cmp     r0,0h                                   
08010A16 D018     beq     8010A4Ah                                
08010A18 2101     mov     r1,1h                                   
08010A1A 4689     mov     r9,r1                                   
08010A1C 7015     strb    r5,[r2]                                 
08010A1E E019     b       8010A54h                                
08010A20 3801     sub     r0,1h                                   
08010A22 7010     strb    r0,[r2]                                 
08010A24 0600     lsl     r0,r0,18h                               
08010A26 2800     cmp     r0,0h                                   
08010A28 D012     beq     8010A50h                                
08010A2A 7810     ldrb    r0,[r2]                                 
08010A2C 4120     asr     r0,r4                                   
08010A2E 0400     lsl     r0,r0,10h                               
08010A30 0C01     lsr     r1,r0,10h                               
08010A32 4663     mov     r3,r12                                  
08010A34 8898     ldrh    r0,[r3,4h]                              
08010A36 1A41     sub     r1,r0,r1                                
08010A38 2080     mov     r0,80h                                  
08010A3A 0200     lsl     r0,r0,8h                                
08010A3C 4008     and     r0,r1                                   
08010A3E 2800     cmp     r0,0h                                   
08010A40 D003     beq     8010A4Ah                                
08010A42 2001     mov     r0,1h                                   
08010A44 4681     mov     r9,r0                                   
08010A46 7016     strb    r6,[r2]                                 
08010A48 E004     b       8010A54h                                
08010A4A 4662     mov     r2,r12                                  
08010A4C 8091     strh    r1,[r2,4h]                              
08010A4E E001     b       8010A54h                                

