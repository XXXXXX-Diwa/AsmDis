
;r0 = 掉落ID;r1=3000756的值(再生产计时);r2=0;r3=主精灵序号;sp=Y坐标;sp4=X坐标;sp8=0;
0800E3D4 B5F0     push    r4-r7,r14                               
0800E3D6 4657     mov     r7,r10                                  
0800E3D8 464E     mov     r6,r9                                   
0800E3DA 4645     mov     r5,r8                                   
0800E3DC B4E0     push    r5-r7                                   
0800E3DE B081     add     sp,-4h                                  
0800E3E0 9C09     ldr     r4,[sp,24h] ;Y坐标                            
0800E3E2 9D0A     ldr     r5,[sp,28h] ;X坐标                            
0800E3E4 9E0B     ldr     r6,[sp,2Ch] ;0h                            
0800E3E6 0600     lsl     r0,r0,18h                               
0800E3E8 0E00     lsr     r0,r0,18h                               
0800E3EA 4681     mov     r9,r0       ;掉落ID                              
0800E3EC 0609     lsl     r1,r1,18h                               
0800E3EE 0E09     lsr     r1,r1,18h                               
0800E3F0 468A     mov     r10,r1      ;再生产计时                             
0800E3F2 0612     lsl     r2,r2,18h                               
0800E3F4 0E12     lsr     r2,r2,18h                               
0800E3F6 4690     mov     r8,r2       ;0h                             
0800E3F8 061B     lsl     r3,r3,18h                               
0800E3FA 0E1B     lsr     r3,r3,18h                               
0800E3FC 9300     str     r3,[sp]     ;主精灵序号                            
0800E3FE 0424     lsl     r4,r4,10h                               
0800E400 0C27     lsr     r7,r4,10h   ;Y坐标                            
0800E402 042D     lsl     r5,r5,10h                               
0800E404 0C2D     lsr     r5,r5,10h   ;X坐标                            
0800E406 0436     lsl     r6,r6,10h                               
0800E408 0C36     lsr     r6,r6,10h   ;0h                            
0800E40A 2400     mov     r4,0h                                   
0800E40C 4A17     ldr     r2,=30001ACh                            
0800E40E 21A8     mov     r1,0A8h                                 
0800E410 00C9     lsl     r1,r1,3h                                
0800E412 1850     add     r0,r2,r1    ;30006ECh                              
0800E414 4282     cmp     r2,r0                                   
0800E416 D234     bcs     @@DateOver    ;大于或等于                            
0800E418 2007     mov     r0,7h                                   
0800E41A 2100     mov     r1,0h                                   
0800E41C 4306     orr     r6,r0         ;0 orr 7                          
0800E41E 201D     mov     r0,1Dh                                  
0800E420 1880     add     r0,r0,r2                                
0800E422 4684     mov     r12,r0 

@@loop:                                 
0800E424 8810     ldrh    r0,[r2]       ;获取取向                          
0800E426 2301     mov     r3,1h                                   
0800E428 4003     and     r3,r0                                   
0800E42A 2B00     cmp     r3,0h                                   
0800E42C D120     bne     @@NOdeath     ;不为0                          
0800E42E 8016     strh    r6,[r2]       ;取向写入7h                          
0800E430 4666     mov     r6,r12                                  
0800E432 7571     strb    r1,[r6,15h]   ;碰撞属性为0h                          
0800E434 4640     mov     r0,r8                                   
0800E436 70B0     strb    r0,[r6,2h]    ;GFX row写入0                          
0800E438 4648     mov     r0,r9                                   
0800E43A 7030     strb    r0,[r6]       ;ID写入掉落ID                          
0800E43C 8057     strh    r7,[r2,2h]    ;Y坐标                          
0800E43E 8095     strh    r5,[r2,4h]    ;X坐标                          
0800E440 4655     mov     r5,r10                                  
0800E442 7075     strb    r5,[r6,1h]    ;再生产计时                         
0800E444 2002     mov     r0,2h                                   
0800E446 7130     strb    r0,[r6,4h]                              
0800E448 2004     mov     r0,4h                                   
0800E44A 7170     strb    r0,[r6,5h]                              
0800E44C 71F1     strb    r1,[r6,7h]    ;pose写入0                           
0800E44E 8293     strh    r3,[r2,14h]   ;血量0                          
0800E450 73B1     strb    r1,[r6,0Eh]   ;无敌时间0                          
0800E452 70F1     strb    r1,[r6,3h]    ;调色板 0                          
0800E454 75B1     strb    r1,[r6,16h]                             
0800E456 75F1     strb    r1,[r6,17h]                             
0800E458 2001     mov     r0,1h                                   
0800E45A 7270     strb    r0,[r6,9h]                              
0800E45C 466A     mov     r2,r13                                  
0800E45E 7812     ldrb    r2,[r2]       ;主精灵序号                           
0800E460 71B2     strb    r2,[r6,6h]    ;写入                          
0800E462 74F1     strb    r1,[r6,13h]   ;冰冻时间写入0                          
0800E464 7531     strb    r1,[r6,14h]   ;在敌人身上判定写入0                          
0800E466 1C20     mov     r0,r4                                   
0800E468 E00C     b       @@end                                

@@NOdeath:                               
0800E470 1C60     add     r0,r4,1                                  
0800E472 0600     lsl     r0,r0,18h                               
0800E474 0E04     lsr     r4,r0,18h  ;r4+1                             
0800E476 2038     mov     r0,38h                                  
0800E478 4484     add     r12,r0     ;下一个精灵偏移ID的地址                             
0800E47A 3238     add     r2,38h                                  
0800E47C 4805     ldr     r0,=30006ECh                            
0800E47E 4282     cmp     r2,r0                                   
0800E480 D3D0     bcc     @@loop     ;小于跳转

@@DateOver:                               
0800E482 20FF     mov     r0,0FFh 

@@end:                                
0800E484 B001     add     sp,4h                                   
0800E486 BC38     pop     r3-r5                                   
0800E488 4698     mov     r8,r3                                   
0800E48A 46A1     mov     r9,r4                                   
0800E48C 46AA     mov     r10,r5                                  
0800E48E BCF0     pop     r4-r7                                   
0800E490 BC02     pop     r1                                      
0800E492 4708     bx      r1 


                                     
0800E494 06EC     lsl     r4,r5,1Bh                               
0800E496 0300     lsl     r0,r0,0Ch                               
0800E498 B510     push    r4,r14                                  
0800E49A F004F81F bl      80124DCh                                
0800E49E 0600     lsl     r0,r0,18h                               
0800E4A0 0E04     lsr     r4,r0,18h                               
0800E4A2 2C07     cmp     r4,7h                                   
0800E4A4 D82D     bhi     800E502h                                
0800E4A6 4818     ldr     r0,=30001ACh                            
0800E4A8 4684     mov     r12,r0                                  
0800E4AA 2200     mov     r2,0h                                   
0800E4AC 2300     mov     r3,0h                                   
0800E4AE 4817     ldr     r0,=8017h                               
0800E4B0 4661     mov     r1,r12                                  
0800E4B2 8008     strh    r0,[r1]                                 
0800E4B4 3132     add     r1,32h                                  
0800E4B6 2020     mov     r0,20h                                  
0800E4B8 7008     strb    r0,[r1]                                 
0800E4BA 4660     mov     r0,r12                                  
0800E4BC 77C4     strb    r4,[r0,1Fh]                             
0800E4BE 2074     mov     r0,74h                                  
0800E4C0 4661     mov     r1,r12                                  
0800E4C2 7748     strb    r0,[r1,1Dh]                             
0800E4C4 4912     ldr     r1,=30013D4h                            
0800E4C6 8A88     ldrh    r0,[r1,14h]                             
0800E4C8 4664     mov     r4,r12                                  
0800E4CA 8060     strh    r0,[r4,2h]                              
0800E4CC 8A48     ldrh    r0,[r1,12h]                             
0800E4CE 80A0     strh    r0,[r4,4h]                              
0800E4D0 4660     mov     r0,r12                                  
0800E4D2 3021     add     r0,21h                                  
0800E4D4 7002     strb    r2,[r0]                                 
0800E4D6 3001     add     r0,1h                                   
0800E4D8 2101     mov     r1,1h                                   
0800E4DA 7001     strb    r1,[r0]                                 
0800E4DC 3002     add     r0,2h                                   
0800E4DE 7002     strb    r2,[r0]                                 
0800E4E0 82A3     strh    r3,[r4,14h]                             
0800E4E2 3007     add     r0,7h                                   
0800E4E4 7002     strb    r2,[r0]                                 
0800E4E6 380B     sub     r0,0Bh                                  
0800E4E8 7002     strb    r2,[r0]                                 
0800E4EA 3013     add     r0,13h                                  
0800E4EC 7002     strb    r2,[r0]                                 
0800E4EE 3001     add     r0,1h                                   
0800E4F0 7002     strb    r2,[r0]                                 
0800E4F2 380E     sub     r0,0Eh                                  
0800E4F4 7001     strb    r1,[r0]                                 
0800E4F6 3803     sub     r0,3h                                   
0800E4F8 7002     strb    r2,[r0]                                 
0800E4FA 300D     add     r0,0Dh                                  
0800E4FC 7002     strb    r2,[r0]                                 
0800E4FE 3001     add     r0,1h                                   
0800E500 7002     strb    r2,[r0]                                 
0800E502 BC10     pop     r4                                      
0800E504 BC01     pop     r0                                      
0800E506 4700     bx      r0 


                                     
0800E508 01AC     lsl     r4,r5,6h                                
0800E50A 0300     lsl     r0,r0,0Ch                               
0800E50C 8017     strh    r7,[r2]                                 
0800E50E 0000     lsl     r0,r0,0h                                
0800E510 13D4     asr     r4,r2,0Fh                               
0800E512 0300     lsl     r0,r0,0Ch                               
0800E514 B5F0     push    r4-r7,r14                               
0800E516 464F     mov     r7,r9                                   
0800E518 4646     mov     r6,r8                                   
0800E51A B4C0     push    r6,r7                                   
0800E51C 0400     lsl     r0,r0,10h                               
0800E51E 0C05     lsr     r5,r0,10h                               
0800E520 0409     lsl     r1,r1,10h                               
0800E522 0C09     lsr     r1,r1,10h                               
0800E524 4A1B     ldr     r2,=3001588h                            
0800E526 1C10     mov     r0,r2                                   
0800E528 3072     add     r0,72h                                  
0800E52A 8800     ldrh    r0,[r0]                                 
0800E52C 1A09     sub     r1,r1,r0                                
0800E52E 0409     lsl     r1,r1,10h                               
0800E530 0C0C     lsr     r4,r1,10h                               
0800E532 46A1     mov     r9,r4                                   
0800E534 1C17     mov     r7,r2                                   
0800E536 376E     add     r7,6Eh                                  
0800E538 2000     mov     r0,0h                                   
0800E53A 5E39     ldsh    r1,[r7,r0]                              
0800E53C 1861     add     r1,r4,r1                                
0800E53E 1C28     mov     r0,r5                                   
0800E540 F001F8A2 bl      800F688h                                
0800E544 4E14     ldr     r6,=30007F1h                            
0800E546 7832     ldrb    r2,[r6]                                 
0800E548 4690     mov     r8,r2                                   
0800E54A 2A00     cmp     r2,0h                                   
0800E54C D11B     bne     800E586h                                
0800E54E 1C28     mov     r0,r5                                   
0800E550 3840     sub     r0,40h                                  
0800E552 2200     mov     r2,0h                                   
0800E554 5EB9     ldsh    r1,[r7,r2]                              
0800E556 1861     add     r1,r4,r1                                
0800E558 F001F896 bl      800F688h                                
0800E55C 7830     ldrb    r0,[r6]                                 
0800E55E 2800     cmp     r0,0h                                   
0800E560 D003     beq     800E56Ah                                
0800E562 F001FFA1 bl      80104A8h                                
0800E566 2800     cmp     r0,0h                                   
0800E568 D00D     beq     800E586h                                
0800E56A 4A0C     ldr     r2,=30013D4h                            
0800E56C 4648     mov     r0,r9                                   
0800E56E 8250     strh    r0,[r2,12h]                             
0800E570 89D1     ldrh    r1,[r2,0Eh]                             
0800E572 2010     mov     r0,10h                                  
0800E574 4008     and     r0,r1                                   
0800E576 2800     cmp     r0,0h                                   
0800E578 D005     beq     800E586h                                
0800E57A 4809     ldr     r0,=3001530h                            
0800E57C 88C0     ldrh    r0,[r0,6h]                              
0800E57E 2800     cmp     r0,0h                                   
0800E580 D001     beq     800E586h                                
0800E582 4640     mov     r0,r8                                   
0800E584 82D0     strh    r0,[r2,16h]                             
0800E586 BC18     pop     r3,r4                                   
0800E588 4698     mov     r8,r3                                   
0800E58A 46A1     mov     r9,r4                                   
0800E58C BCF0     pop     r4-r7                                   
0800E58E BC01     pop     r0                                      
0800E590 4700     bx      r0                                      
0800E592 0000     lsl     r0,r0,0h                                
0800E594 1588     asr     r0,r1,16h                               
0800E596 0300     lsl     r0,r0,0Ch                               
0800E598 07F1     lsl     r1,r6,1Fh                               
0800E59A 0300     lsl     r0,r0,0Ch                               
0800E59C 13D4     asr     r4,r2,0Fh                               
0800E59E 0300     lsl     r0,r0,0Ch                               
0800E5A0 1530     asr     r0,r6,14h                               
0800E5A2 0300     lsl     r0,r0,0Ch                               
0800E5A4 B5F0     push    r4-r7,r14                               
0800E5A6 464F     mov     r7,r9                                   
0800E5A8 4646     mov     r6,r8                                   
0800E5AA B4C0     push    r6,r7                                   
0800E5AC 0400     lsl     r0,r0,10h                               
0800E5AE 0C05     lsr     r5,r0,10h                               
0800E5B0 0409     lsl     r1,r1,10h                               
0800E5B2 0C09     lsr     r1,r1,10h                               
0800E5B4 4A1B     ldr     r2,=3001588h                            
0800E5B6 1C10     mov     r0,r2                                   
0800E5B8 306E     add     r0,6Eh                                  
0800E5BA 8800     ldrh    r0,[r0]                                 
0800E5BC 1A09     sub     r1,r1,r0                                
0800E5BE 0409     lsl     r1,r1,10h                               
0800E5C0 0C0C     lsr     r4,r1,10h                               
0800E5C2 46A1     mov     r9,r4                                   
0800E5C4 1C17     mov     r7,r2                                   
0800E5C6 3772     add     r7,72h                                  
0800E5C8 2000     mov     r0,0h                                   
0800E5CA 5E39     ldsh    r1,[r7,r0]                              
0800E5CC 1861     add     r1,r4,r1                                
0800E5CE 1C28     mov     r0,r5                                   
0800E5D0 F001F85A bl      800F688h                                

