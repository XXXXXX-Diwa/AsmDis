
;头球跟着头蠕动例程
080114AC B500     push    r14                                     
080114AE 1C02     mov     r2,r0                                   
080114B0 7B10     ldrb    r0,[r2,0Ch]                             
080114B2 3001     add     r0,1h         ;动画帧加1                           
080114B4 7310     strb    r0,[r2,0Ch]   ;再写入                          
080114B6 8891     ldrh    r1,[r2,4h]    ;动画                          
080114B8 6813     ldr     r3,[r2]       ;OAM                          
080114BA 00C9     lsl     r1,r1,3h      ;动画乘以8                          
080114BC 18C9     add     r1,r1,r3      ;加上OAM                          
080114BE 7909     ldrb    r1,[r1,4h]    ;读取动画帧                          
080114C0 0600     lsl     r0,r0,18h                               
080114C2 0E00     lsr     r0,r0,18h                               
080114C4 4281     cmp     r1,r0         ;OAM动画帧比较当前动画帧                          
080114C6 D20B     bcs     @@end         ;大于等于则结束                       
080114C8 2001     mov     r0,1h         ;当前动画帧大于OAM动画帧则                          
080114CA 7310     strb    r0,[r2,0Ch]   ;动画帧写入1                          
080114CC 8890     ldrh    r0,[r2,4h]    ;动画                          
080114CE 3001     add     r0,1h         ;加1                          
080114D0 8090     strh    r0,[r2,4h]    ;再写入                          
080114D2 8890     ldrh    r0,[r2,4h]    ;读取动画                          
080114D4 00C0     lsl     r0,r0,3h      ;乘以8                          
080114D6 18C0     add     r0,r0,r3      ;加上OAM                          
080114D8 7900     ldrb    r0,[r0,4h]    ;读取动画                          
080114DA 2800     cmp     r0,0h         ;不等于0则结束                          
080114DC D100     bne     @@end                                
080114DE 8090     strh    r0,[r2,4h]    ;等于零则动画帧写入0

@@end:                              
080114E0 BC01     pop     r0                                      
080114E2 4700     bx      r0

;副精灵pose非67调用
08011520 B510     push    r4,r14                                  
08011522 1C02     mov     r2,r0                                   
08011524 8890     ldrh    r0,[r2,4h]   ;读取70C动画                            
08011526 6811     ldr     r1,[r2]      ;去读70C OAM                           
08011528 00C0     lsl     r0,r0,3h     ;8倍                           
0801152A 1840     add     r0,r0,r1     ;加OAM偏移                           
0801152C 6804     ldr     r4,[r0]      ;读取OAM                           
0801152E 4B0C     ldr     r3,=3000738h                            
08011530 7F99     ldrb    r1,[r3,1Eh]  ;读取副精灵Date                           
08011532 0048     lsl     r0,r1,1h                                
08011534 1840     add     r0,r0,r1                                
08011536 0040     lsl     r0,r0,1h     ;六倍                           
08011538 1900     add     r0,r0,r4     ;加上OAM                           
0801153A 8840     ldrh    r0,[r0,2h]   ;读取OAM附近的数值                           
0801153C 88D1     ldrh    r1,[r2,6h]   ;读取70c的Y坐标                           
0801153E 1840     add     r0,r0,r1     ;两者相加                           
08011540 8058     strh    r0,[r3,2h]   ;写入Y坐标                           
08011542 8819     ldrh    r1,[r3]      ;读取取向                           
08011544 2040     mov     r0,40h                                  
08011546 4008     and     r0,r1        ;and 40h                           
08011548 2800     cmp     r0,0h                                   
0801154A D00B     beq     @@LeftFace                                
0801154C 7F99     ldrb    r1,[r3,1Eh]  ;读取精灵Date                           
0801154E 0048     lsl     r0,r1,1h                                
08011550 1840     add     r0,r0,r1                                
08011552 0040     lsl     r0,r0,1h     ;六倍                           
08011554 1900     add     r0,r0,r4     ;加上OAM坐标                           
08011556 8911     ldrh    r1,[r2,8h]   ;读取X坐标                           
08011558 8880     ldrh    r0,[r0,4h]   ;读取OAM附近的数值                           
0801155A 1A09     sub     r1,r1,r0     ;相减                           
0801155C 8099     strh    r1,[r3,4h]   ;写入X坐标                          
0801155E E00A     b       @@end                                 

@@LeftFace:                              
08011564 7F98     ldrb    r0,[r3,1Eh]                             
08011566 0041     lsl     r1,r0,1h                                
08011568 1809     add     r1,r1,r0                                
0801156A 0049     lsl     r1,r1,1h                                
0801156C 1909     add     r1,r1,r4                                
0801156E 8888     ldrh    r0,[r1,4h]                              
08011570 8912     ldrh    r2,[r2,8h]                              
08011572 1880     add     r0,r0,r2                                
08011574 8098     strh    r0,[r3,4h] 

@@end:                             
08011576 BC10     pop     r4                                      
08011578 BC01     pop     r0                                      
0801157A 4700     bx      r0                                      


                                      
080259A0 B510     push    r4,r14                                  
080259A2 1C03     mov     r3,r0                                   
080259A4 8898     ldrh    r0,[r3,4h]    ;读取70C动画                           
080259A6 6819     ldr     r1,[r3]       ;读取70C的OAM                          
080259A8 00C0     lsl     r0,r0,3h      ;动画乘以8                          
080259AA 1840     add     r0,r0,r1      ;加OAM 偏移起始                         
080259AC 6804     ldr     r4,[r0]       ;读取OAM  也即当前位的OAM                         
080259AE 4A15     ldr     r2,=3000738h                            
080259B0 7F91     ldrb    r1,[r2,1Eh]   ;Data值                          
080259B2 0048     lsl     r0,r1,1h      ;乘以2                          
080259B4 1840     add     r0,r0,r1      ;再加                          
080259B6 0040     lsl     r0,r0,1h      ;六倍                          
080259B8 1900     add     r0,r0,r4      ;加上OAM指向的偏移                          
080259BA 8800     ldrh    r0,[r0]       ;读取数值                          
080259BC 4912     ldr     r1,=875F5FCh                            
080259BE 0080     lsl     r0,r0,2h      ;乘以四加偏移值                          
080259C0 1840     add     r0,r0,r1                                
080259C2 6991     ldr     r1,[r2,18h]   ;读取3000738处OAM                          
080259C4 6800     ldr     r0,[r0]                                 
080259C6 4281     cmp     r1,r0         ;如果两个OAM相等则跳过                          
080259C8 D003     beq     @@Pass                                
080259CA 6190     str     r0,[r2,18h]   ;否则3000738的OAM被覆盖                          
080259CC 2000     mov     r0,0h                                   
080259CE 7710     strb    r0,[r2,1Ch]                             
080259D0 82D0     strh    r0,[r2,16h] 

@@Pass:                            
080259D2 7F91     ldrb    r1,[r2,1Eh]   ;读取DAta                          
080259D4 0048     lsl     r0,r1,1h                                
080259D6 1840     add     r0,r0,r1                                
080259D8 0040     lsl     r0,r0,1h      ;六倍                          
080259DA 1900     add     r0,r0,r4      ;加上OAM指向的偏移数值                          
080259DC 8840     ldrh    r0,[r0,2h]    ;读取数值                           
080259DE 88D9     ldrh    r1,[r3,6h]    ;读取70C的Y坐标                          
080259E0 1840     add     r0,r0,r1      ;数值加上70C的Y坐标                          
080259E2 8050     strh    r0,[r2,2h]    ;写入738的Y坐标                          
080259E4 8811     ldrh    r1,[r2]       ;读取取向                          
080259E6 2040     mov     r0,40h        ;and 40h                          
080259E8 4008     and     r0,r1                                   
080259EA 7F91     ldrb    r1,[r2,1Eh]   ;读取DAta                          
080259EC 2800     cmp     r0,0h                                   
080259EE D00D     beq     @@LeftFace                                
080259F0 0048     lsl     r0,r1,1h                                
080259F2 1840     add     r0,r0,r1                                
080259F4 0040     lsl     r0,r0,1h      ;六倍                           
080259F6 1900     add     r0,r0,r4      ;加上OAM指向的偏移数值                          
080259F8 8919     ldrh    r1,[r3,8h]    ;读取300070C的X坐标                          
080259FA 8880     ldrh    r0,[r0,4h]    ;读取最大动画延迟数                          
080259FC 1A09     sub     r1,r1,r0                                
080259FE 8091     strh    r1,[r2,4h]                              
08025A00 E00C     b       @@end                                

@@LeftFace:
08025A0C 0048     lsl     r0,r1,1h                                
08025A0E 1840     add     r0,r0,r1                                
08025A10 0040     lsl     r0,r0,1h                                
08025A12 1900     add     r0,r0,r4                                
08025A14 8880     ldrh    r0,[r0,4h]                              
08025A16 891B     ldrh    r3,[r3,8h]                              
08025A18 18C0     add     r0,r0,r3                                
08025A1A 8090     strh    r0,[r2,4h]  

@@end:                            
08025A1C BC10     pop     r4                                      
08025A1E BC01     pop     r0                                      
