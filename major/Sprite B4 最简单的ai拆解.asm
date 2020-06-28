;JumZhu.Diwa:此AI仅仅为触发AI,唯一的作用就是接触后就激活了事件.

.definelabel CheckEvent,0x80608bc
  
;主程序  每帧都经历
08028628 B570     push    r4-r6,r14                               
0802862A 4808     ldr     r0,=3000738h                            
0802862C 1C06     mov     r6,r0                                   
0802862E 3624     add     r6,24h                                  
08028630 7835     ldrb    r5,[r6]                                 
08028632 1C04     mov     r4,r0                                   
08028634 2D00     cmp     r5,0h       ;pose不为0跳转,默认第2帧跳转                              
08028636 D12A     bne     @@PoseNoZero                                
08028638 2003     mov     r0,3h                                   
0802863A 2121     mov     r1,21h                                  
0802863C F038F93E bl      CheckEvent  ;检查21h事件是否激活                               
08028640 1C03     mov     r3,r0                                   
08028642 2B00     cmp     r3,0h                                   
08028644 D004     beq     @@NoTrigger ;事件没有触发                                
08028646 8025     strh    r5,[r4]     ;事件触发则精灵取向归0(消失)                            
08028648 E02D     b       @@end                                

@@NoTrigger:                               
08028650 8821     ldrh    r1,[r4]     ;读取取向值xxxx                              
08028652 4A16     ldr     r2,=8004h                               
08028654 1C10     mov     r0,r2                                   
08028656 2200     mov     r2,0h                                   
08028658 4308     orr     r0,r1       ;8004h orr 取向值                             
0802865A 8020     strh    r0,[r4]     ;再次写入 8005h                            
0802865C 1C21     mov     r1,r4                                   
0802865E 3125     add     r1,25h                                  
08028660 201E     mov     r0,1Eh                                  
08028662 7008     strb    r0,[r1]     ;属性写入1Eh,为道具属性                            
08028664 3102     add     r1,2h                                   
08028666 2010     mov     r0,10h                                     
08028668 7008     strb    r0,[r1]     ;300075F写入10h                            
0802866A 1C20     mov     r0,r4       ;触发高度?一格                            
0802866C 3028     add     r0,28h                                  
0802866E 7002     strb    r2,[r0]     ;3000760写入0h                            
08028670 3001     add     r0,1h                                   
08028672 2108     mov     r1,8h       ;3000761写入8h                            
08028674 7001     strb    r1,[r0]     ;触发宽度?左右各半格                            
08028676 480E     ldr     r0,=0FFC0h                              
08028678 8160     strh    r0,[r4,0Ah] ;上部分界写入一格                            
0802867A 81A3     strh    r3,[r4,0Ch] ;下部分界写入0                            
0802867C 3020     add     r0,20h                                  
0802867E 81E0     strh    r0,[r4,0Eh] ;左部分界写入半格                            
08028680 2020     mov     r0,20h                                  
08028682 8220     strh    r0,[r4,10h] ;右部分界写入半格                            
08028684 7031     strb    r1,[r6]                                 
08028686 480B     ldr     r0,=82B2750h                            
08028688 61A0     str     r0,[r4,18h]  ;写入OAM                           
0802868A 7722     strb    r2,[r4,1Ch]                             
0802868C 82E3     strh    r3,[r4,16h]  ;动画和帧归0

@@PoseNoZero:                             
0802868E 8821     ldrh    r1,[r4]                                 
08028690 2080     mov     r0,80h                                  
08028692 0100     lsl     r0,r0,4h                                
08028694 4008     and     r0,r1        ;800h and 取向                               
08028696 2800     cmp     r0,0h        ;默认触发即orr 800h                              
08028698 D005     beq     @@end                                
0802869A 2000     mov     r0,0h        ;以下为触碰到触发点                              
0802869C 8020     strh    r0,[r4]      ;消失                              
0802869E 2001     mov     r0,1h                                   
080286A0 2121     mov     r1,21h                                  
080286A2 F038F90B bl      CheckEvent   ;事件21h激活

@@end:                               
080286A6 BC70     pop     r4-r6                                   
080286A8 BC01     pop     r0                                      
080286AA 4700     bx      r0 

///////////////////////////////////////////////////////////////

;事件例程
080608BC B570     push    r4-r6,r14                               
080608BE 0600     lsl     r0,r0,18h                               
080608C0 0E04     lsr     r4,r0,18h     ;指令                               
080608C2 0609     lsl     r1,r1,18h                               
080608C4 0E0B     lsr     r3,r1,18h     ;事件                            
080608C6 22FF     mov     r2,0FFh                                 
080608C8 0612     lsl     r2,r2,18h                               
080608CA 1888     add     r0,r1,r2                                  
080608CC 0E00     lsr     r0,r0,18h     ;事件加FFh                          
080608CE 284D     cmp     r0,4Dh        ;如果不大于4Dh,事件最大值                          
080608D0 D901     bls     @@DataNoOver                                
080608D2 2000     mov     r0,0h         ;否则返回0并结束                         
080608D4 E025     b       @@end 

@@DataNoOver:                           ;事件计数从2开始,事件1为2    
080608D6 4D0B     ldr     r5,=2037E00h                            
080608D8 0F48     lsr     r0,r1,1Dh     ;事件除以20h 相当于每32个事件用4个字节记录                          
080608DA 0080     lsl     r0,r0,2h      ;再乘以4h                          
080608DC 1945     add     r5,r0,r5      ;相加得到事件适合的偏移地址                          
080608DE 201F     mov     r0,1Fh                                  
080608E0 4003     and     r3,r0         ;事件值 and 1F                          
080608E2 2601     mov     r6,1h                                   
080608E4 1C32     mov     r2,r6                                   
080608E6 409A     lsl     r2,r3         ;lsl r2,r2,r3.最大为80000000h                          
080608E8 6829     ldr     r1,[r5]       ;读取事件值                          
080608EA 1C08     mov     r0,r1                                   
080608EC 4010     and     r0,r2         ;and 当前的事件                          
080608EE 2800     cmp     r0,0h                                   
080608F0 D000     beq     @@EventNoTrigger                                
080608F2 2001     mov     r0,1h         ;如果触发r0=1

@@EventNoTrigger:                                 
080608F4 2C01     cmp     r4,1h         ;指令为1跳转                           
080608F6 D00D     beq     @@ToTrigger   ;激活事件                          
080608F8 2C01     cmp     r4,1h                                   
080608FA DC05     bgt     @@InstructionMoreThan1                                
080608FC 2C00     cmp     r4,0h                                   
080608FE D006     beq     @@InstructionZero                                
08060900 E00F     b       @@end                                

@@InstructionMoreThan1:                               
08060908 2C02     cmp     r4,2h                                   
0806090A D007     beq     @@Instruction2                                
0806090C E009     b       @@end        ;如果不是2是其它的数则结束返回1

@@InstructionZero:                             
0806090E 4391     bic     r1,r2        ;事件值 bic 当前的事件值                           
08060910 6029     str     r1,[r5]      ;再写入 取消事件                          
08060912 E006     b       @@end        ;r0返回0

@@ToTrigger:                                
08060914 4311     orr     r1,r2        ;事件值 orr 当前的事件值                            
08060916 6029     str     r1,[r5]      ;再写入 激活事件                          
08060918 4070     eor     r0,r6        ;r0返回1                            
0806091A E002     b       @@end 

@@Instruction2:                               
0806091C 4051     eor     r1,r2        ;事件值 eor 当前的事件值                            
0806091E 6029     str     r1,[r5]      ;再写入 取消事件                            
08060920 4070     eor     r0,r6        ;r0返回1

@@end:                                   
08060922 BC70     pop     r4-r6                                   
08060924 BC02     pop     r1                                      
08060926 4708     bx      r1                                      
