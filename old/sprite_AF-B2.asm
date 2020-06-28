
.definelabel checkclip,800F720h

.org 8049bd0h
08049BD0 B570     push    r4-r6,r14          ;探照灯主程序                      
08049BD2 4C07     ldr     r4,=3000738h                            
08049BD4 1C25     mov     r5,r4                                   
08049BD6 3524     add     r5,24h                                  
08049BD8 7829     ldrb    r1,[r5]                                 
08049BDA 2923     cmp     r1,23h             ;pose 23h                      
08049BDC D100     bne     8049BE0h           ;非的话跳转                     
08049BDE E0D9     b       8049D94h           

.org 8049be0h                                               
08049BE0 2923     cmp     r1,23h                                  
08049BE2 DC07     bgt     8049BF4h           ;大于跳转                     
08049BE4 2900     cmp     r1,0h                                   
08049BE6 D009     beq     8049BFCh           ;为0跳转                     
08049BE8 2909     cmp     r1,9h                                   
08049BEA D050     beq     8049C8Eh           ;为9跳转                     
08049BEC E0E9     b       @@end                      
08049BEE 0000     lsl     r0,r0,0h                                
08049BF0 0738     lsl     r0,r7,1Ch                               
08049BF2 0300     lsl     r0,r0,0Ch   

.org 8049bf4h                            
08049BF4 2925     cmp     r1,25h                                  
08049BF6 D100     bne     8049BFAh           ;非25跳转                     
08049BF8 E0DE     b       8049DB8h           ;pose 25?

.org 8049bfah                                ;非25跳转
08049BFA E0E2     b       @@end  

.org 8049bfch                                ;pose 0h   经历一次                           
08049BFC 4802     ldr     r0,=30001A8h                            
08049BFE 8802     ldrh    r2,[r0]                                 
08049C00 2A00     cmp     r2,0h                                   
08049C02 D003     beq     8049C0Ch                                
08049C04 8021     strh    r1,[r4]           ;警报不为0则取向写入0                      
08049C06 E0DC     b       @@end             ;结束                              

;pose 0时警报为0跳转                        ;默认经历1次
08049C0C 1C20     mov     r0,r4                                   
08049C0E 3027     add     r0,27h            ;300075f写入20h                      
08049C10 2120     mov     r1,20h                                  
08049C12 7001     strb    r1,[r0]                                 
08049C14 3001     add     r0,1h                                   
08049C16 7001     strb    r1,[r0]           ;3000760写入20h                      
08049C18 3001     add     r0,1h                                   
08049C1A 7001     strb    r1,[r0]           ;3000761写入20h                      
08049C1C 2300     mov     r3,0h                                   
08049C1E 4911     ldr     r1,=0FFD0h                              
08049C20 8161     strh    r1,[r4,0Ah]       ;顶部分界写入FFD0h 2f?                      
08049C22 2030     mov     r0,30h                                  
08049C24 81A0     strh    r0,[r4,0Ch]       ;下部分界写入30h                      
08049C26 81E1     strh    r1,[r4,0Eh]                             
08049C28 8220     strh    r0,[r4,10h]       ;同上                      
08049C2A 480F     ldr     r0,=83179D0h                            
08049C2C 61A0     str     r0,[r4,18h]       ;写入新图                      
08049C2E 7723     strb    r3,[r4,1Ch]                             
08049C30 82E2     strh    r2,[r4,16h]                             
08049C32 1C21     mov     r1,r4                                   
08049C34 3125     add     r1,25h                                  
08049C36 201E     mov     r0,1Eh            ;写入属性                      
08049C38 7008     strb    r0,[r1]                                 
08049C3A 2009     mov     r0,9h                                   
08049C3C 7028     strb    r0,[r5]           ;pose写入9                      
08049C3E 480B     ldr     r0,=3000088h                            
08049C40 7B01     ldrb    r1,[r0,0Ch]       ;3000094,在两个有探照灯的房间是4,其余房间是5                  
08049C42 2003     mov     r0,3h                                   
08049C44 4008     and     r0,r1             ;若是4得0,若是5的1                      
08049C46 1C21     mov     r1,r4                                   
08049C48 3121     add     r1,21h            ;调色板??                      
08049C4A 7008     strb    r0,[r1]                                 
08049C4C 3101     add     r1,1h                                   
08049C4E 2001     mov     r0,1h                                   
08049C50 7008     strb    r0,[r1]           ;调色板?                      
08049C52 7F60     ldrb    r0,[r4,1Dh]                             
08049C54 28AF     cmp     r0,0AFh                                 
08049C56 D10B     bne     8049C70h          ;ID非AF跳转                      
08049C58 8820     ldrh    r0,[r4]           ;R0得到取向                      
08049C5A 22C0     mov     r2,0C0h                                 
08049C5C 00D2     lsl     r2,r2,3h                                
08049C5E 1C11     mov     r1,r2                                   
08049C60 E08F     b       @@coverge         ;汇合处                      

;ID非AF                              
08049C70 28B0     cmp     r0,0B0h                                 
08049C72 D104     bne     8049C7Eh         ;ID非B0跳转                       
08049C74 8820     ldrh    r0,[r4]                                 
08049C76 2380     mov     r3,80h                                  
08049C78 00DB     lsl     r3,r3,3h                                
08049C7A 1C19     mov     r1,r3                                   
08049C7C E081     b       @@coverge         

;ID非AF B0                       
08049C7E 28B1     cmp     r0,0B1h                                 
08049C80 D000     beq     8049C84h        ;ID是B1跳转                        
08049C82 E09E     b       @@end        ;结束
;ID B1                        
08049C84 8820     ldrh    r0,[r4]                                 
08049C86 2280     mov     r2,80h                                  
08049C88 0092     lsl     r2,r2,2h                                
08049C8A 1C11     mov     r1,r2                                   
08049C8C E079     b       @@coverge 

.org 8049c8eh                            ;pose 9h                               
08049C8E 8821     ldrh    r1,[r4]        ;读取取向写入的值  右下604 左下404 右上204 左上004?????                       
08049C90 2004     mov     r0,4h                                   
08049C92 4041     eor     r1,r0          ;eor 4h再写入                         
08049C94 2600     mov     r6,0h                                   
08049C96 8021     strh    r1,[r4]                                 
08049C98 2080     mov     r0,80h                                  
08049C9A 0100     lsl     r0,r0,4h                                
08049C9C 4008     and     r0,r1                                   
08049C9E 4A0A     ldr     r2,=30001A8h                            
08049CA0 2800     cmp     r0,0h                                   
08049CA2 D003     beq     8049CACh       ;警报为0跳转                          
08049CA4 23F0     mov     r3,0F0h                                 
08049CA6 005B     lsl     r3,r3,1h                                
08049CA8 1C18     mov     r0,r3                                   
08049CAA 8010     strh    r0,[r2]        ;警报续命

;pose9警报为0                                
08049CAC 8810     ldrh    r0,[r2]                                 
08049CAE 2800     cmp     r0,0h                                   
08049CB0 D00C     beq     8049CCCh       ;警报真为0跳转                         
08049CB2 2023     mov     r0,23h                                  
08049CB4 7028     strb    r0,[r5]        ;警报不为0 pose写入23h                         
08049CB6 1C21     mov     r1,r4                                   
08049CB8 312C     add     r1,2Ch                                  
08049CBA 200A     mov     r0,0Ah                                  
08049CBC 7008     strb    r0,[r1]        ;3000764写入ah                         
08049CBE 1C20     mov     r0,r4                                   
08049CC0 3025     add     r0,25h                                  
08049CC2 7006     strb    r6,[r0]        ;属性写入0                         
08049CC4 E07D     b       @@end                                
08049CC6 0000     lsl     r0,r0,0h                                
08049CC8 01A8     lsl     r0,r5,6h                                
08049CCA 0300     lsl     r0,r0,0Ch

;pose9警报为0第二次                               
08049CCC 2580     mov     r5,80h                                  
08049CCE 00AD     lsl     r5,r5,2h                                
08049CD0 4029     and     r1,r5                                   
08049CD2 2900     cmp     r1,0h                                   
08049CD4 D015     beq     8049D02h      ;r1 and 200为0跳转  B0和B2跳转,判定左方向?                          
08049CD6 8860     ldrh    r0,[r4,2h]    ;垂直坐标                          
08049CD8 88A1     ldrh    r1,[r4,4h]    ;得到坐标                          
08049CDA 3140     add     r1,40h        ;水平坐标左一格的坐标                          
08049CDC F7C5FD20 bl      checkclipX                                
08049CE0 4804     ldr     r0,=30000DCh                            
08049CE2 8800     ldrh    r0,[r0]                                 
08049CE4 2807     cmp     r0,7h                                   
08049CE6 D109     bne     8049CFCh      ;没有对敌砖块挡住跳转                          
08049CE8 8821     ldrh    r1,[r4]       ;否则得到取向                          
08049CEA 4803     ldr     r0,=0FDFFh    ;反转方向                          
08049CEC 4008     and     r0,r1         ;604变404 204变004  右变左?                       
08049CEE 8020     strh    r0,[r4]                                 
08049CF0 E01B     b       8049D2Ah                                   

;右向无挡                          
08049CFC 88A0     ldrh    r0,[r4,4h]   ; 得到X坐标                          
08049CFE 3002     add     r0,2h        ;右移2h 速度                           
08049D00 E012     b       8049D28h     ;写入速度

;B0 B2左方向?                               
08049D02 8860     ldrh    r0,[r4,2h]                              
08049D04 88A1     ldrh    r1,[r4,4h]                              
08049D06 3940     sub     r1,40h                                  
08049D08 F7C5FD0A bl      checkclip                                
08049D0C 4804     ldr     r0,=30000DCh                            
08049D0E 8800     ldrh    r0,[r0]                                 
08049D10 2807     cmp     r0,7h                                   
08049D12 D107     bne     8049D24h                                
08049D14 8821     ldrh    r1,[r4]                                 
08049D16 1C28     mov     r0,r5                                   
08049D18 4308     orr     r0,r1        ;404和004 orr 200结果为604和204                               
08049D1A 8020     strh    r0,[r4]                                 
08049D1C E005     b       8049D2Ah                                

;左向无挡                              
08049D24 88A0     ldrh    r0,[r4,4h]                              
08049D26 3802     sub     r0,2h        ;左移速度

;x速度写入处                             
08049D28 80A0     strh    r0,[r4,4h]   

;变向跳过了一次速度写入,取向改变后方向判定也改变                          
08049D2A 4C0B     ldr     r4,=3000738h                            
08049D2C 8821     ldrh    r1,[r4]                                 
08049D2E 2580     mov     r5,80h                                  
08049D30 00ED     lsl     r5,r5,3h                                
08049D32 1C28     mov     r0,r5                                   
08049D34 4008     and     r0,r1       ;400 and r1 204和004都为0                           
08049D36 2800     cmp     r0,0h                                   
08049D38 D018     beq     8049D6Ch    ;判定是否是B1 B2向上的                            
08049D3A 8860     ldrh    r0,[r4,2h]                              
08049D3C 3040     add     r0,40h      ;垂直坐标下移一格                            
08049D3E 88A1     ldrh    r1,[r4,4h]                              
08049D40 F7C5FCEE bl      checkclip                                
08049D44 4805     ldr     r0,=30000DCh                            
08049D46 8800     ldrh    r0,[r0]                                 
08049D48 2807     cmp     r0,7h                                  
08049D4A D10B     bne     8049D64h                                
08049D4C 8821     ldrh    r1,[r4]                                 
08049D4E 4804     ldr     r0,=0FBFFh  ;FBFFh and 604h 和404 结果为204和004                            
08049D50 4008     and     r0,r1                                   
08049D52 8020     strh    r0,[r4]     ;上下改变                            
08049D54 E035     b       @@end                                 

;下方无挡                               
08049D64 8860     ldrh    r0,[r4,2h]                              
08049D66 3002     add     r0,2h       ;垂直坐标下移2h                            
08049D68 8060     strh    r0,[r4,2h]                              
08049D6A E02A     b       @@end               

;B1 B2向上的类型                 
08049D6C 8860     ldrh    r0,[r4,2h]                              
08049D6E 3840     sub     r0,40h                                  
08049D70 88A1     ldrh    r1,[r4,4h]                              
08049D72 F7C5FCD5 bl      checkclip                                
08049D76 4804     ldr     r0,=30000DCh                            
08049D78 8800     ldrh    r0,[r0]                                 
08049D7A 2807     cmp     r0,7h                                   
08049D7C D106     bne     8049D8Ch   ;上方无挡                              
08049D7E 8821     ldrh    r1,[r4]                                 
08049D80 1C28     mov     r0,r5 

@@coverge:                           ;AF 600h B0 400h B1 200h B2 0       
08049D82 4308     orr     r0,r1      ;400 orr 204 和004结果为604和404                             
08049D84 8020     strh    r0,[r4]                                 
08049D86 E01C     b       @@end      ;结束                            

;上方无挡                              
08049D8C 8860     ldrh    r0,[r4,2h]                              
08049D8E 3802     sub     r0,2h      ;垂直坐标向上2h                             
08049D90 8060     strh    r0,[r4,2h]                              
08049D92 E016     b       @@end      ;结束

.org 8049d94h                        ;pose 23  警报不为0                      
08049D94 8820     ldrh    r0,[r4]                                 
08049D96 2304     mov     r3,4h                                   
08049D98 1C02     mov     r2,r0                                   
08049D9A 405A     eor     r2,r3                                   
08049D9C 8022     strh    r2,[r4]    ;取向字节为0                             
08049D9E 1C21     mov     r1,r4                                   
08049DA0 312C     add     r1,2Ch                                  
08049DA2 7808     ldrb    r0,[r1]    ;3000764减1                             
08049DA4 3801     sub     r0,1h                                   
08049DA6 7008     strb    r0,[r1]                                 
08049DA8 0600     lsl     r0,r0,18h                               
08049DAA 2800     cmp     r0,0h      ;如果不为0则结束                            
08049DAC D109     bne     @@end                                
08049DAE 431A     orr     r2,r3      ;为0的话重新写入判定???                             
08049DB0 8022     strh    r2,[r4]                                 
08049DB2 2025     mov     r0,25h                                  
08049DB4 7028     strb    r0,[r5]    ;pose写入25                             
08049DB6 E004     b       @@end   

.org 8049db8h                      ;pose 25?                             
08049DB8 4903     ldr     r1,=30001A8h                            
08049DBA 22F0     mov     r2,0F0h                                 
08049DBC 0052     lsl     r2,r2,1h                                
08049DBE 1C10     mov     r0,r2                                   
08049DC0 8008     strh    r0,[r1]  ;再次写入警报

@@end:                                
08049DC2 BC70     pop     r4-r6                                   
08049DC4 BC01     pop     r0                                      
08049DC6 4700     bx      r0

///////////////////////////////////////////////////////////////
