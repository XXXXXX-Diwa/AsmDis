;海盗发现闪光,与吊索激活闪光

0805E424 B510     push    r4,r14                                  
0805E426 4A11     ldr     r2,=30056ECh ;动画调色板连续                           
0805E428 4811     ldr     r0,=835FBF8h ;00 00 00 00                           
0805E42A 6801     ldr     r1,[r0]                                 
0805E42C 6011     str     r1,[r2]                                 
0805E42E 4811     ldr     r0,=30056F0h                            
0805E430 6001     str     r1,[r0]                                 
0805E432 4911     ldr     r1,=300004Dh                            
0805E434 2000     mov     r0,0h                                   
0805E436 7008     strb    r0,[r1]                                 
0805E438 4B10     ldr     r3,=30056F4h  ;动画调色板序号                          
0805E43A 7818     ldrb    r0,[r3]                                 
0805E43C 1C0C     mov     r4,r1                                   
0805E43E 2800     cmp     r0,0h                                   
0805E440 D058     beq     @@end         ;如果为0则结束                       
0805E442 4A0F     ldr     r2,=40000D4h                            
0805E444 490F     ldr     r1,=835FBFCh                            
0805E446 00C0     lsl     r0,r0,3h                                
0805E448 3104     add     r1,4h                                   
0805E44A 1840     add     r0,r0,r1                                
0805E44C 6800     ldr     r0,[r0]                                 
0805E44E 6010     str     r0,[r2]                                 
0805E450 480D     ldr     r0,=50001E0h                            
0805E452 6050     str     r0,[r2,4h]                              
0805E454 480D     ldr     r0,=80000010h                           
0805E456 6090     str     r0,[r2,8h]                              
0805E458 6890     ldr     r0,[r2,8h]                              
0805E45A 7818     ldrb    r0,[r3]                                 
0805E45C 3803     sub     r0,3h                                   
0805E45E 280E     cmp     r0,0Eh                                  
0805E460 D848     bhi     @@end                                
0805E462 0080     lsl     r0,r0,2h                                
0805E464 490A     ldr     r1,=Table                            
0805E466 1840     add     r0,r0,r1                                
0805E468 6800     ldr     r0,[r0]                                 
0805E46A 4687     mov     r15,r0                                  

Table:
    .word 805e4d0h ;03
	.word 805e4e8h ;04
	.word @@end    ;05
	.word 805e4e8h ;06
	.word @@end    ;07
	.word 805e4e8h ;08
	.word 805e4e8h ;09
	.word 805e4e8h ;0a
	.word 805e4e8h ;0b
	.word 805e4e8h ;0c
	.word @@end    ;0d
	.word @@end    ;0e
	.word @@end    ;0f
	.word 805e4e8h ;10
	.word 805e4e8h ;11
	
    	
0805E4D0 2003     mov     r0,3h                                   
0805E4D2 212E     mov     r1,2Eh                                  
0805E4D4 F002F9F2 bl      80608BCh                                
0805E4D8 2800     cmp     r0,0h                                   
0805E4DA D10B     bne     @@end                                
0805E4DC 4901     ldr     r1,=300004Dh                            
0805E4DE 2001     mov     r0,1h                                   
0805E4E0 7008     strb    r0,[r1]                                 
0805E4E2 E007     b       @@end                                
0805E4E4 004D     lsl     r5,r1,1h                                
0805E4E6 0300     lsl     r0,r0,0Ch                               
0805E4E8 4804     ldr     r0,=30001A8h                            
0805E4EA 8800     ldrh    r0,[r0]                                 
0805E4EC 2800     cmp     r0,0h                                   
0805E4EE D101     bne     @@end                                
0805E4F0 2001     mov     r0,1h                                   
0805E4F2 7020     strb    r0,[r4] 

@@end:                                
0805E4F4 BC10     pop     r4                                      
0805E4F6 BC01     pop     r0                                      
0805E4F8 4700     bx      r0 
