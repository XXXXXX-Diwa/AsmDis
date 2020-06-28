;被金桶的POSE 9 行走调用
0800F594 B5F0     push    r4-r7,r14                               
0800F596 4657     mov     r7,r10                                  
0800F598 464E     mov     r6,r9                                   
0800F59A 4645     mov     r5,r8                                   
0800F59C B4E0     push    r5-r7                                   
0800F59E 4F18     ldr     r7,=3000738h                            
0800F5A0 887D     ldrh    r5,[r7,2h]     ;精灵的Y坐标                          
0800F5A2 46A9     mov     r9,r5          ;给R9                         
0800F5A4 88BC     ldrh    r4,[r7,4h]     ;精灵的X坐标                         
0800F5A6 46A2     mov     r10,r4         ;给R10                         
0800F5A8 1F28     sub     r0,r5,4        ;Y坐标上升4格的高度                         
0800F5AA 0400     lsl     r0,r0,10h                               
0800F5AC 0C00     lsr     r0,r0,10h                               
0800F5AE 1C21     mov     r1,r4                                   
0800F5B0 F7FFFED6 bl      800F360h       ;检查砖块,斜坡?                        
0800F5B4 1C02     mov     r2,r0                                   
0800F5B6 4E13     ldr     r6,=30007F0h                            
0800F5B8 7831     ldrb    r1,[r6]                                 
0800F5BA 200F     mov     r0,0Fh                                  
0800F5BC 4680     mov     r8,r0                                   
0800F5BE 4008     and     r0,r1          ;0F and 检查值                         
0800F5C0 2801     cmp     r0,1h          ;比较是否大于1                         
0800F5C2 D814     bhi     800F5EEh                                
0800F5C4 1C28     mov     r0,r5                                   
0800F5C6 1C21     mov     r1,r4                                   
0800F5C8 F7FFFECA bl      800F360h       ;使用原坐标检查砖块                         
0800F5CC 1C02     mov     r2,r0                                   
0800F5CE 7831     ldrb    r1,[r6]                                 
0800F5D0 4640     mov     r0,r8                                   
0800F5D2 4008     and     r0,r1                                   
0800F5D4 2801     cmp     r0,1h                                   
0800F5D6 D80A     bhi     800F5EEh       ;如果大于1则代表遇到轻度的斜坡?                         
0800F5D8 4648     mov     r0,r9                                   
0800F5DA 3004     add     r0,4h          ;把原Y坐标向下4h                         
0800F5DC 0400     lsl     r0,r0,10h                               
0800F5DE 0C00     lsr     r0,r0,10h                               
0800F5E0 4651     mov     r1,r10                                  
0800F5E2 F7FFFEBD bl      800F360h       ;检查砖块                         
0800F5E6 1C02     mov     r2,r0                                   
0800F5E8 7830     ldrb    r0,[r6]                                 
0800F5EA 2800     cmp     r0,0h          ;如果等于0则代表脚下没有砖块?                         
0800F5EC D000     beq     @@end 

@@7F0MoreThan1:                              
0800F5EE 807A     strh    r2,[r7,2h]     ;把斜坡的高度写入Y坐标 

@@end:                           
0800F5F0 BC38     pop     r3-r5                                   
0800F5F2 4698     mov     r8,r3                                   
0800F5F4 46A1     mov     r9,r4                                   
0800F5F6 46AA     mov     r10,r5                                  
0800F5F8 BCF0     pop     r4-r7                                   
0800F5FA BC01     pop     r0                                      
0800F5FC 4700     bx      r0                                      


                          
0800F608 B5F0     push    r4-r7,r14                               
0800F60A 4657     mov     r7,r10                                  
0800F60C 464E     mov     r6,r9                                   
0800F60E 4645     mov     r5,r8                                   
0800F610 B4E0     push    r5-r7                                   
0800F612 4E1B     ldr     r6,=3000738h                            
0800F614 89B0     ldrh    r0,[r6,0Ch]                             
0800F616 8871     ldrh    r1,[r6,2h]                              
0800F618 1840     add     r0,r0,r1                                
0800F61A 0400     lsl     r0,r0,10h                               
0800F61C 0C05     lsr     r5,r0,10h                               
0800F61E 46A9     mov     r9,r5                                   
0800F620 88B4     ldrh    r4,[r6,4h]                              
0800F622 46A2     mov     r10,r4                                  
0800F624 1F28     sub     r0,r5,4                                 
0800F626 0400     lsl     r0,r0,10h                               
0800F628 0C00     lsr     r0,r0,10h                               
0800F62A 1C21     mov     r1,r4                                   
0800F62C F7FFFE98 bl      800F360h                                
0800F630 1C02     mov     r2,r0                                   
0800F632 4F14     ldr     r7,=30007F0h                            
0800F634 7839     ldrb    r1,[r7]                                 
0800F636 200F     mov     r0,0Fh                                  
0800F638 4680     mov     r8,r0                                   
0800F63A 4008     and     r0,r1                                   
0800F63C 2801     cmp     r0,1h                                   
0800F63E D814     bhi     800F66Ah                                
0800F640 1C28     mov     r0,r5                                   
0800F642 1C21     mov     r1,r4                                   
0800F644 F7FFFE8C bl      800F360h                                
0800F648 1C02     mov     r2,r0                                   
0800F64A 7839     ldrb    r1,[r7]                                 
0800F64C 4640     mov     r0,r8                                   
0800F64E 4008     and     r0,r1                                   
0800F650 2801     cmp     r0,1h                                   
0800F652 D80A     bhi     800F66Ah                                
0800F654 4648     mov     r0,r9                                   
0800F656 3004     add     r0,4h                                   
0800F658 0400     lsl     r0,r0,10h                               
0800F65A 0C00     lsr     r0,r0,10h                               
0800F65C 4651     mov     r1,r10                                  
0800F65E F7FFFE7F bl      800F360h                                
0800F662 1C02     mov     r2,r0                                   
0800F664 7838     ldrb    r0,[r7]                                 
0800F666 2800     cmp     r0,0h                                   
0800F668 D002     beq     800F670h                                
0800F66A 89B0     ldrh    r0,[r6,0Ch]                             
0800F66C 1A10     sub     r0,r2,r0                                
0800F66E 8070     strh    r0,[r6,2h]                              
0800F670 BC38     pop     r3-r5                                   
0800F672 4698     mov     r8,r3                                   
0800F674 46A1     mov     r9,r4                                   
0800F676 46AA     mov     r10,r5                                  
0800F678 BCF0     pop     r4-r7                                   
0800F67A BC01     pop     r0                                      
0800F67C 4700     bx      r0                                      
0800F67E 0000     lsl     r0,r0,0h                                
0800F680 0738     lsl     r0,r7,1Ch                               
0800F682 0300     lsl     r0,r0,0Ch                               
0800F684 07F0     lsl     r0,r6,1Fh                               
0800F686 0300     lsl     r0,r0,0Ch                               
0800F688 B500     push    r14                                     
0800F68A 0400     lsl     r0,r0,10h                               
0800F68C 0C00     lsr     r0,r0,10h                               
0800F68E 0409     lsl     r1,r1,10h                               
0800F690 0C09     lsr     r1,r1,10h                               
0800F692 F048FBF3 bl      8057E7Ch                                
0800F696 1C03     mov     r3,r0                                   
0800F698 2280     mov     r2,80h                                  
0800F69A 0452     lsl     r2,r2,11h                               
0800F69C 401A     and     r2,r3                                   
0800F69E 2A00     cmp     r2,0h                                   
0800F6A0 D006     beq     800F6B0h                                
0800F6A2 4902     ldr     r1,=30007F1h                            
0800F6A4 2011     mov     r0,11h                                  
0800F6A6 7008     strb    r0,[r1]                                 
0800F6A8 1C0A     mov     r2,r1                                   
0800F6AA E004     b       800F6B6h                                
0800F6AC 07F1     lsl     r1,r6,1Fh                               
0800F6AE 0300     lsl     r0,r0,0Ch                               
0800F6B0 4806     ldr     r0,=30007F1h                            
0800F6B2 7002     strb    r2,[r0]                                 
0800F6B4 1C02     mov     r2,r0                                   
0800F6B6 20FF     mov     r0,0FFh                                 
0800F6B8 4018     and     r0,r3                                   
0800F6BA 3802     sub     r0,2h                                   
0800F6BC 280A     cmp     r0,0Ah                                  
0800F6BE D82D     bhi     800F71Ch                                
0800F6C0 0080     lsl     r0,r0,2h                                
0800F6C2 4903     ldr     r1,=800F6D4h                            
0800F6C4 1840     add     r0,r0,r1                                
0800F6C6 6800     ldr     r0,[r0]                                 
0800F6C8 4687     mov     r15,r0                                  
0800F6CA 0000     lsl     r0,r0,0h                                
0800F6CC 07F1     lsl     r1,r6,1Fh                               
0800F6CE 0300     lsl     r0,r0,0Ch                               
0800F6D0 F6D4     ????                                            
0800F6D2 0800     lsr     r0,r0,20h                               
0800F6D4 F70C     ????                                            
0800F6D6 0800     lsr     r0,r0,20h                               
0800F6D8 F700     ????                                            
0800F6DA 0800     lsr     r0,r0,20h                               
0800F6DC F714     ????                                            
0800F6DE 0800     lsr     r0,r0,20h                               
0800F6E0 F710     ????                                            
0800F6E2 0800     lsr     r0,r0,20h                               
0800F6E4 F704     ????                                            
0800F6E6 0800     lsr     r0,r0,20h                               
0800F6E8 F708     ????                                            
0800F6EA 0800     lsr     r0,r0,20h                               
0800F6EC F71C     ????                                            
0800F6EE 0800     lsr     r0,r0,20h                               
0800F6F0 F71C     ????                                            
0800F6F2 0800     lsr     r0,r0,20h                               
0800F6F4 F71C     ????                                            
0800F6F6 0800     lsr     r0,r0,20h                               
0800F6F8 F71C     ????                                            
0800F6FA 0800     lsr     r0,r0,20h                               
0800F6FC F718     ????                                            
0800F6FE 0800     lsr     r0,r0,20h                               
0800F700 2005     mov     r0,5h                                   
0800F702 E00A     b       800F71Ah                                
0800F704 2003     mov     r0,3h                                   
0800F706 E008     b       800F71Ah                                
0800F708 2003     mov     r0,3h                                   
0800F70A E006     b       800F71Ah                                
0800F70C 2004     mov     r0,4h                                   
0800F70E E004     b       800F71Ah                                
0800F710 2002     mov     r0,2h                                   
0800F712 E002     b       800F71Ah                                
0800F714 2002     mov     r0,2h                                   
0800F716 E000     b       800F71Ah                                
0800F718 2010     mov     r0,10h                                  
0800F71A 7010     strb    r0,[r2]                                 
0800F71C BC01     pop     r0                                      
0800F71E 4700     bx      r0                                      
0800F720 B500     push    r14                                     
0800F722 0400     lsl     r0,r0,10h                               
0800F724 0C00     lsr     r0,r0,10h                               
0800F726 0409     lsl     r1,r1,10h                               
0800F728 0C09     lsr     r1,r1,10h                               
0800F72A F048FBA7 bl      8057E7Ch                                
0800F72E 1C01     mov     r1,r0                                   
0800F730 2080     mov     r0,80h                                  
0800F732 0440     lsl     r0,r0,11h                               
0800F734 4008     and     r0,r1                                   
0800F736 2200     mov     r2,0h                                   
0800F738 2800     cmp     r0,0h                                   
0800F73A D000     beq     800F73Eh                                
0800F73C 2211     mov     r2,11h                                  
0800F73E 20FF     mov     r0,0FFh                                 
0800F740 4008     and     r0,r1                                   
0800F742 3802     sub     r0,2h                                   
0800F744 280A     cmp     r0,0Ah                                  
0800F746 D826     bhi     800F796h                                
0800F748 0080     lsl     r0,r0,2h                                
0800F74A 4902     ldr     r1,=800F758h                            
0800F74C 1840     add     r0,r0,r1                                
0800F74E 6800     ldr     r0,[r0]                                 
0800F750 4687     mov     r15,r0                                  
0800F752 0000     lsl     r0,r0,0h                                
0800F754 F758     ????                                            
0800F756 0800     lsr     r0,r0,20h                               
0800F758 F78C     ????                                            
0800F75A 0800     lsr     r0,r0,20h                               
0800F75C F784     ????                                            
0800F75E 0800     lsr     r0,r0,20h                               
0800F760 F790     ????                                            
0800F762 0800     lsr     r0,r0,20h                               
0800F764 F790     ????                                            
0800F766 0800     lsr     r0,r0,20h                               
0800F768 F788     ????                                            
0800F76A 0800     lsr     r0,r0,20h                               
0800F76C F788     ????                                            
0800F76E 0800     lsr     r0,r0,20h                               
0800F770 F796     ????                                            
0800F772 0800     lsr     r0,r0,20h                               
0800F774 F796     ????                                            
0800F776 0800     lsr     r0,r0,20h                               
0800F778 F796     ????                                            
0800F77A 0800     lsr     r0,r0,20h                               
0800F77C F796     ????                                            
0800F77E 0800     lsr     r0,r0,20h                               
0800F780 F794     ????                                            
0800F782 0800     lsr     r0,r0,20h                               
0800F784 2205     mov     r2,5h                                   
0800F786 E006     b       800F796h                                
0800F788 2203     mov     r2,3h                                   
0800F78A E004     b       800F796h                                
0800F78C 2204     mov     r2,4h                                   
0800F78E E002     b       800F796h                                
0800F790 2202     mov     r2,2h                                   
0800F792 E000     b       800F796h                                

