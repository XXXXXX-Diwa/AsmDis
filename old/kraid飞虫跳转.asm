


08010798 B5F0     push    r4-r7,r14         ;ID 9F时的跳转                      
0801079A 0600     lsl     r0,r0,18h                               
0801079C 0E06     lsr     r6,r0,18h         ;r6=A0h                      
0801079E 2400     mov     r4,0h                                   
080107A0 4813     ldr     r0,=3000738h                            
080107A2 3023     add     r0,23h                                  
080107A4 7805     ldrb    r5,[r0]           ;主精灵序号                     
080107A6 4A13     ldr     r2,=30001ACh                            
080107A8 21A8     mov     r1,0A8h                                 
080107AA 00C9     lsl     r1,r1,3h                                
080107AC 1850     add     r0,r2,r1                                
080107AE 4282     cmp     r2,r0                                   
080107B0 D219     bcs     @@end             ;循环在某范围内进行                     
080107B2 1C07     mov     r7,r0             ;范围最大值给r7                      
080107B4 1C13     mov     r3,r2                                   
080107B6 3323     add     r3,23h 

@@loop:                                
080107B8 8811     ldrh    r1,[r2]           ;得到精灵的取向                      
080107BA 2001     mov     r0,1h                                   
080107BC 4008     and     r0,r1             ;1 and 精灵取向                      
080107BE 2800     cmp     r0,0h             ;范围中为845,远为847,近为843,基本都不会跳转啊                     
080107C0 D00D     beq     @@nosprite        ;精灵死了跳转,也就是9F未出现则不出现?                        
080107C2 7BD9     ldrb    r1,[r3,0Fh]                             
080107C4 2080     mov     r0,80h                                  
080107C6 4008     and     r0,r1             ;80 and 精灵的碰撞属性                      
080107C8 2800     cmp     r0,0h             ;这样排除了副精灵?                     
080107CA D108     bne     @@nosprite        ;基本都会等于0的,所以不跳转                        
080107CC 7F50     ldrb    r0,[r2,1Dh]                             
080107CE 42B0     cmp     r0,r6             ;检查Id是否有A0,不是的话跳转                      
080107D0 D105     bne     @@nosprite                                
080107D2 7818     ldrb    r0,[r3]                                 
080107D4 42A8     cmp     r0,r5             ;比较主精灵序号是否相同                     
080107D6 D102     bne     @@nosprite        ;不相同则跳转                        
080107D8 1C60     add     r0,r4,1           ;序号+1                      
080107DA 0600     lsl     r0,r0,18h                               
080107DC 0E04     lsr     r4,r0,18h 

@@nosprite:                              
080107DE 3338     add     r3,38h                                 
080107E0 3238     add     r2,38h            ;下一个精灵数据起始值                      
080107E2 42BA     cmp     r2,r7             ;比较范围是否超出                      
080107E4 D3E8     bcc     @@loop          ;未超出则前跳循环

@@end:                               
080107E6 1C20     mov     r0,r4             ;这段代码是检验游戏中是否已经出现了A0?                      
080107E8 BCF0     pop     r4-r7                                   
080107EA BC02     pop     r1                                      
080107EC 4708     bx      r1                                      


                         
080108B0 B5F0     push    r4-r7,r14                               
080108B2 480D     ldr     r0,=3000738h                            
080108B4 3023     add     r0,23h                                  
080108B6 7804     ldrb    r4,[r0]           ;得到主精灵序号                      
080108B8 271F     mov     r7,1Fh                                  
080108BA 4A0C     ldr     r2,=30001ACh                            
080108BC 21A8     mov     r1,0A8h                                 
080108BE 00C9     lsl     r1,r1,3h                                
080108C0 1850     add     r0,r2,r1                                
080108C2 4282     cmp     r2,r0             ;当前值与最大值                      
080108C4 D218     bcs     @@end                               
080108C6 2601     mov     r6,1h                                   
080108C8 1C13     mov     r3,r2                                   
080108CA 3323     add     r3,23h                                  
080108CC 1C05     mov     r5,r0             ;最大值给r5  

@@loop:                    
080108CE 8811     ldrh    r1,[r2]           ;精灵取向                     
080108D0 1C30     mov     r0,r6                                   
080108D2 4008     and     r0,r1             ;1 and 精灵取向                     
080108D4 2800     cmp     r0,0h                                   
080108D6 D00B     beq     @@pass            ;死亡继续循环                     
080108D8 7818     ldrb    r0,[r3]                                 
080108DA 42A0     cmp     r0,r4                                   
080108DC D108     bne     @@pass            ;不等于主精灵序号继续循环                    
080108DE 7898     ldrb    r0,[r3,2h]                              
080108E0 42B8     cmp     r0,r7             ;属性小于1F则继续循环                      
080108E2 D305     bcc     @@pass                                
080108E4 2001     mov     r0,1h                                   
080108E6 E008     b       @@end2                                

@@pass:                               
080108F0 3338     add     r3,38h                                  
080108F2 3238     add     r2,38h                                  
080108F4 42AA     cmp     r2,r5                                   
080108F6 D3EA     bcc     @@loop  

@@end:                              
080108F8 2000     mov     r0,0h

@@end2:                                   
080108FA BCF0     pop     r4-r7                                   
080108FC BC02     pop     r1                                      
080108FE 4708     bx      r1                                      
