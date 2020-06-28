



.org 80286b8h
     push    r4,r5,r14                               
     ldr     r3,=3000738h                            
     mov     r1,r3                                   
     add     r1,26h                                  
     mov     r0,1h                 ;300075e写入1             
     strb    r0,[r1]                                 
     mov     r5,r3                                   
     add     r5,24h                                  
     ldrb    r4,[r5]               ;得到pose值                  
     cmp     r4,0h                                   
     bne     @@posenozero          ;pose非0跳转                  
     add     r1,1h                                   
     mov     r0,30h                                  
     strb    r0,[r1]               ;300075f写入30                   
     add     r1,1h                                   
     mov     r0,10h                                  
     strb    r0,[r1]               ;3000760写入10h                  
     add     r1,1h                                   
     mov     r0,20h                                  
     strb    r0,[r1]               ;3000761写入20h                  
     mov     r2,0h                                   
     ldr     r1,=0FFFCh                              
     strh    r1,[r3,0Ah]           ;顶部分界写入0FFFCh                   
     mov     r0,4h                                   
     strh    r0,[r3,0Ch]           ;下部分界写入4                  
     strh    r1,[r3,0Eh]           ;左部分界写入0fffch                  
     strh    r0,[r3,10h]           ;右部分界写入4                  
     ldr     r0,=82E0D00h                            
     str     r0,[r3,18h]           ;写入OAM                 
     strb    r2,[r3,1Ch]                             
     strh    r4,[r3,16h]           ;动画和计数清空                  
     mov     r0,r3                                   
     add     r0,25h                ;属性写入0                  
     strb    r2,[r0]                                 
     mov     r0,9h                                   
     strb    r0,[r5]               ;pose 值写入9 
@@posenozero:                 
     ldrb    r0,[r3,1Ch]           ;得到动画计数,每帧自动加1,到某值就会返回1,但是某值并不固定               
     cmp     r0,1h                                   
     bne     @@nosound              ;计数不是1的话跳转                   
     ldrh    r1,[r3,16h]           ;得到动画  当动画计数返回1则会加1     
     cmp     r1,0h                                  
     beq     @@pass              ;动画帧数0的话跳转                  
     cmp     r1,4h                                  
     bne     @@nosound              ;动画不是4的话跳转 
@@pass:                 
     ldr     r0,=212h               ;同时满足计数1,动画帧0或4才会播放声音                 
     bl      8002A18h              ;播放声音212  
@@nosound:                
     pop     r4,r5                                   
     pop     r0                                      
     bx      r0 


;自动递增计数的方式
;动画帧乘以8加上OAM指针再右移4位的指针的数值和动画计数比较.大于结束  
;如果小于则动画计数写入1,动画帧则加1
;加1的动画帧乘以8加上OAM指针再右移4位的指针的数值和0比较.不等于0则结束
;等于0则动画帧为0
