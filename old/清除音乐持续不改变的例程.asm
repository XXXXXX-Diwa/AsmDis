

08003E60 B510     push    r4,r14                                  
08003E62 0600     lsl     r0,r0,18h                               
08003E64 0E02     lsr     r2,r0,18h   ;0h                            
08003E66 1C14     mov     r4,r2                                   
08003E68 4907     ldr     r1,=3001D00h                            
08003E6A 7848     ldrb    r0,[r1,1h]                              
08003E6C 1C0B     mov     r3,r1                                   
08003E6E 2800     cmp     r0,0h                                   
08003E70 D11E     bne     @@end                                
08003E72 2001     mov     r0,1h       ;不是0的话写入1                            
08003E74 7058     strb    r0,[r3,1h]                              
08003E76 2A80     cmp     r2,80h                                  
08003E78 D108     bne     @@No80                                
08003E7A 1C1C     mov     r4,r3                                   
08003E7C 3421     add     r4,21h                                  
08003E7E 7821     ldrb    r1,[r4]     ;读取3001d21h                            
08003E80 1C10     mov     r0,r2                                   
08003E82 4308     orr     r0,r1       ;80 orr                            
08003E84 7020     strb    r0,[r4]     ;再写入                            
08003E86 E011     b       @@returnzero                                

@@No80:                              
08003E8C 2AFF     cmp     r2,0FFh                                 
08003E8E D106     bne     @@NoFF                                
08003E90 1C1A     mov     r2,r3                                   
08003E92 3221     add     r2,21h                                  
08003E94 7811     ldrb    r1,[r2]    ;3001d21                             
08003E96 207F     mov     r0,7Fh                                  
08003E98 4008     and     r0,r1      ;7F and                              
08003E9A 7010     strb    r0,[r2]                                 
08003E9C E006     b       @@returnzero

@@NoFF:                                
08003E9E 1C1A     mov     r2,r3                                   
08003EA0 3221     add     r2,21h                                  
08003EA2 7811     ldrb    r1,[r2]                                 
08003EA4 2080     mov     r0,80h                                  
08003EA6 4008     and     r0,r1     ;80 and                              
08003EA8 4304     orr     r4,r0                                   
08003EAA 7014     strb    r4,[r2] 

@@returnzero:                                
08003EAC 2000     mov     r0,0h                                   
08003EAE 7058     strb    r0,[r3,1h] 

@@end:                             
08003EB0 BC10     pop     r4                                      
08003EB2 BC01     pop     r0                                      
08003EB4 4700     bx      r0                                      


                               
08003EB8 B570     push    r4-r6,r14                               
08003EBA 490D     ldr     r1,=3001D00h                            
08003EBC 784A     ldrb    r2,[r1,1h]                              
08003EBE 2A00     cmp     r2,0h                                   
08003EC0 D127     bne     8003F12h                                
08003EC2 2001     mov     r0,1h                                   
08003EC4 7048     strb    r0,[r1,1h]                              
08003EC6 480B     ldr     r0,=808F254h                            
08003EC8 6806     ldr     r6,[r0]                                 
08003ECA 1C08     mov     r0,r1                                   
08003ECC 3020     add     r0,20h                                  
08003ECE 7002     strb    r2,[r0]                                 
08003ED0 8B8A     ldrh    r2,[r1,1Ch]                             
08003ED2 1C10     mov     r0,r2                                   
08003ED4 385A     sub     r0,5Ah                                  
08003ED6 0400     lsl     r0,r0,10h                               
08003ED8 0C00     lsr     r0,r0,10h                               
08003EDA 2809     cmp     r0,9h                                   
08003EDC D80E     bhi     8003EFCh                                
08003EDE 4C06     ldr     r4,=808F2C0h                            
08003EE0 1C10     mov     r0,r2                                   
08003EE2 F7FFFD4D bl      8003980h                                
08003EE6 0400     lsl     r0,r0,10h                               
08003EE8 0B40     lsr     r0,r0,0Dh                               
08003EEA 1900     add     r0,r0,r4                                
08003EEC E009     b       8003F02h                                
08003EEE 0000     lsl     r0,r0,0h                                
08003EF0 1D00     add     r0,r0,4                                 
08003EF2 0300     lsl     r0,r0,0Ch                               
08003EF4 F254     ????                                            
08003EF6 0808     lsr     r0,r1,20h                               
08003EF8 F2C0     ????                                            
08003EFA 0808     lsr     r0,r1,20h                               
08003EFC 4906     ldr     r1,=808F2C0h                            
08003EFE 00D0     lsl     r0,r2,3h                                
08003F00 1840     add     r0,r0,r1                                
08003F02 6801     ldr     r1,[r0]                                 
08003F04 4D05     ldr     r5,=3001D00h                            
08003F06 2400     mov     r4,0h                                   
08003F08 706C     strb    r4,[r5,1h]                              
08003F0A 1C30     mov     r0,r6                                   
08003F0C F000FE20 bl      8004B50h                                
08003F10 706C     strb    r4,[r5,1h]                              
08003F12 BC70     pop     r4-r6                                   
08003F14 BC01     pop     r0                                      
08003F16 4700     bx      r0                                      
08003F18 F2C0     ????                                            
08003F1A 0808     lsr     r0,r1,20h                               
08003F1C 1D00     add     r0,r0,4                                 
08003F1E 0300     lsl     r0,r0,0Ch                               
08003F20 B570     push    r4-r6,r14                               
08003F22 2063     mov     r0,63h                                  
08003F24 F7FEFD78 bl      8002A18h                                
08003F28 2000     mov     r0,0h                                   
08003F2A F7FFFABF bl      80034ACh                                
08003F2E 4A0B     ldr     r2,=3001D00h                            
08003F30 7AD1     ldrb    r1,[r2,0Bh]                             
08003F32 2080     mov     r0,80h                                  
08003F34 4308     orr     r0,r1                                   
08003F36 72D0     strb    r0,[r2,0Bh]                             
08003F38 4D09     ldr     r5,=808F254h                            
08003F3A 6828     ldr     r0,[r5]                                 
08003F3C 4E09     ldr     r6,=0FFFFh                              
08003F3E 4C0A     ldr     r4,=50h                                 
08003F40 0424     lsl     r4,r4,10h                               
08003F42 0C24     lsr     r4,r4,10h                               
08003F44 1C31     mov     r1,r6                                   
08003F46 1C22     mov     r2,r4                                   
08003F48 F7FFF886 bl      8003058h                                
08003F4C 68E8     ldr     r0,[r5,0Ch]                             
08003F4E 1C31     mov     r1,r6                                   
08003F50 1C22     mov     r2,r4                                   
08003F52 F7FFF881 bl      8003058h                                
08003F56 BC70     pop     r4-r6                                   
08003F58 BC01     pop     r0                                      
08003F5A 4700     bx      r0                                      
08003F5C 1D00     add     r0,r0,4                                 
08003F5E 0300     lsl     r0,r0,0Ch                               
08003F60 F254     ????                                            
08003F62 0808     lsr     r0,r1,20h                               
08003F64 FFFF     bl      lr+0FFEh                                
08003F66 0000     lsl     r0,r0,0h                                
08003F68 0050     lsl     r0,r2,1h                                
08003F6A 0000     lsl     r0,r0,0h                                
08003F6C B570     push    r4-r6,r14                               
08003F6E 4C0C     ldr     r4,=808F254h                            
08003F70 6820     ldr     r0,[r4]                                 
08003F72 4D0C     ldr     r5,=0FFFFh                              
08003F74 2680     mov     r6,80h                                  
08003F76 0076     lsl     r6,r6,1h                                
08003F78 1C29     mov     r1,r5                                   
08003F7A 1C32     mov     r2,r6                                   
08003F7C F7FFF86C bl      8003058h                                
08003F80 68E0     ldr     r0,[r4,0Ch]                             
08003F82 1C29     mov     r1,r5                                   
08003F84 1C32     mov     r2,r6                                   
08003F86 F7FFF867 bl      8003058h                                
08003F8A 4A07     ldr     r2,=3001D00h                            
08003F8C 7AD1     ldrb    r1,[r2,0Bh]                             
08003F8E 207F     mov     r0,7Fh                                  
08003F90 4008     and     r0,r1                                   
08003F92 72D0     strb    r0,[r2,0Bh]                             
08003F94 2000     mov     r0,0h                                   
08003F96 F7FFFB1B bl      80035D0h                                
08003F9A BC70     pop     r4-r6                                   
08003F9C BC01     pop     r0                                      
08003F9E 4700     bx      r0                                      
08003FA0 F254     ????                                            
08003FA2 0808     lsr     r0,r1,20h                               
08003FA4 FFFF     bl      lr+0FFEh                                
08003FA6 0000     lsl     r0,r0,0h                                
08003FA8 1D00     add     r0,r0,4                                 
08003FAA 0300     lsl     r0,r0,0Ch                               
08003FAC B570     push    r4-r6,r14                               
08003FAE 0400     lsl     r0,r0,10h                               
08003FB0 0409     lsl     r1,r1,10h                               
08003FB2 0C0C     lsr     r4,r1,10h                               
08003FB4 490D     ldr     r1,=808F2C0h                            
08003FB6 0B40     lsr     r0,r0,0Dh                               
08003FB8 1840     add     r0,r0,r1                                
08003FBA 7902     ldrb    r2,[r0,4h]                              
08003FBC 6805     ldr     r5,[r0]                                 
08003FBE 480C     ldr     r0,=808CEE2h                            
08003FC0 1810     add     r0,r2,r0                                
08003FC2 7800     ldrb    r0,[r0]                                 
08003FC4 4E0B     ldr     r6,=3003B44h                            
08003FC6 2800     cmp     r0,0h                                   
08003FC8 D00A     beq     8003FE0h                                
08003FCA 00D0     lsl     r0,r2,3h                                
08003FCC 1983     add     r3,r0,r6                                
08003FCE 7819     ldrb    r1,[r3]                                 
08003FD0 2003     mov     r0,3h                                   
08003FD2 4008     and     r0,r1                                   
08003FD4 2800     cmp     r0,0h                                   
08003FD6 D003     beq     8003FE0h                                
08003FD8 7858     ldrb    r0,[r3,1h]                              
08003FDA 78A9     ldrb    r1,[r5,2h]                              
08003FDC 4288     cmp     r0,r1                                   
08003FDE D816     bhi     800400Eh                                
08003FE0 2C00     cmp     r4,0h                                   
08003FE2 D109     bne     8003FF8h                                
08003FE4 00D2     lsl     r2,r2,3h                                
08003FE6 1991     add     r1,r2,r6                                
08003FE8 2001     mov     r0,1h                                   
08003FEA E008     b       8003FFEh                                
08003FEC F2C0     ????                                            
08003FEE 0808     lsr     r0,r1,20h                               
08003FF0 CEE2     ldmia   [r6]!,r1,r5-r7                          
08003FF2 0808     lsr     r0,r1,20h                               
08003FF4 3B44     sub     r3,44h                                  
08003FF6 0300     lsl     r0,r0,0Ch                               
08003FF8 00D2     lsl     r2,r2,3h                                
08003FFA 1991     add     r1,r2,r6                                
08003FFC 2002     mov     r0,2h                                   
08003FFE 7008     strb    r0,[r1]                                 
08004000 804C     strh    r4,[r1,2h]                              
08004002 1991     add     r1,r2,r6                                
08004004 78A8     ldrb    r0,[r5,2h]                              
08004006 7048     strb    r0,[r1,1h]                              
08004008 1D30     add     r0,r6,4                                 
0800400A 1810     add     r0,r2,r0                                
0800400C 6005     str     r5,[r0]                                 
0800400E BC70     pop     r4-r6                                   
08004010 BC01     pop     r0                                      
08004012 4700     bx      r0                                      
08004014 B5F0     push    r4-r7,r14                               
08004016 0400     lsl     r0,r0,10h                               
08004018 0409     lsl     r1,r1,10h                               
0800401A 0C0F     lsr     r7,r1,10h                               
0800401C 490A     ldr     r1,=808F2C0h                            
0800401E 0B40     lsr     r0,r0,0Dh                               
08004020 1840     add     r0,r0,r1                                
08004022 7902     ldrb    r2,[r0,4h]                              
08004024 6806     ldr     r6,[r0]                                 
08004026 4D09     ldr     r5,=3003B44h                            
08004028 00D3     lsl     r3,r2,3h                                
0800402A 195C     add     r4,r3,r5                                
0800402C 7821     ldrb    r1,[r4]                                 
0800402E 2003     mov     r0,3h                                   
08004030 4008     and     r0,r1                                   
08004032 2800     cmp     r0,0h                                   
08004034 D00C     beq     8004050h                                
08004036 1D28     add     r0,r5,4                                 
08004038 1818     add     r0,r3,r0                                
0800403A 6800     ldr     r0,[r0]                                 
0800403C 4286     cmp     r6,r0                                   
0800403E D107     bne     8004050h                                
08004040 2000     mov     r0,0h                                   
08004042 7020     strb    r0,[r4]                                 
08004044 E01A     b       800407Ch                                
08004046 0000     lsl     r0,r0,0h                                
08004048 F2C0     ????                                            
0800404A 0808     lsr     r0,r1,20h                               
0800404C 3B44     sub     r3,44h                                  
0800404E 0300     lsl     r0,r0,0Ch                               
08004050 4807     ldr     r0,=808F254h                            
08004052 0051     lsl     r1,r2,1h                                
08004054 1889     add     r1,r1,r2                                
08004056 0089     lsl     r1,r1,2h                                
08004058 1809     add     r1,r1,r0                                
0800405A 6809     ldr     r1,[r1]                                 
0800405C 6908     ldr     r0,[r1,10h]                             
0800405E 4286     cmp     r6,r0                                   

