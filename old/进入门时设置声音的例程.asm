

080036D0 B5F0     push    r4-r7,r14                               
080036D2 4647     mov     r7,r8     ;3000056 当前/最后走的门                              
080036D4 B480     push    r7                                      
080036D6 0400     lsl     r0,r0,10h   ;是当前房间的音乐?                            
080036D8 0C04     lsr     r4,r0,10h                               
080036DA 4808     ldr     r0,=3001D00h                            
080036DC 4680     mov     r8,r0                                   
080036DE 3021     add     r0,21h      ;30001d21                            
080036E0 7801     ldrb    r1,[r0]     ;正常都是0h                            
080036E2 2004     mov     r0,4h                                   
080036E4 4008     and     r0,r1       ;4 and                            
080036E6 2800     cmp     r0,0h                                   
080036E8 D145     bne     @@end                                
080036EA 2070     mov     r0,70h                                  
080036EC 4008     and     r0,r1                                   
080036EE 2800     cmp     r0,0h                                   
080036F0 D006     beq     @@pass                                
080036F2 1C20     mov     r0,r4                                   
080036F4 F000F84A bl      800378Ch                                
080036F8 E03D     b       @@end                                

@@pass:                             
08003700 0608     lsl     r0,r1,18h                               
08003702 2800     cmp     r0,0h                                   
08003704 D137     bne     @@end                                
08003706 4641     mov     r1,r8                                   
08003708 784D     ldrb    r5,[r1,1h]                              
0800370A 2D00     cmp     r5,0h                                   
0800370C D133     bne     @@end                                
0800370E 2001     mov     r0,1h                                   
08003710 7048     strb    r0,[r1,1h]                              
08003712 4E1B     ldr     r6,=808F254h                            
08003714 6CB0     ldr     r0,[r6,48h]                             
08003716 210A     mov     r1,0Ah                                  
08003718 F7FFFABC bl      8002C94h                                
0800371C 6E30     ldr     r0,[r6,60h]                             
0800371E 210A     mov     r1,0Ah                                  
08003720 F7FFFAB8 bl      8002C94h                                
08003724 4B17     ldr     r3,=3003B44h                            
08003726 1C1A     mov     r2,r3                                   
08003728 3230     add     r2,30h                                  
0800372A 7811     ldrb    r1,[r2]                                 
0800372C 2703     mov     r7,3h                                   
0800372E 1C38     mov     r0,r7                                   
08003730 4008     and     r0,r1                                   
08003732 2800     cmp     r0,0h                                   
08003734 D000     beq     8003738h                                
08003736 7015     strb    r5,[r2]                                 
08003738 1C1A     mov     r2,r3                                   
0800373A 3240     add     r2,40h                                  
0800373C 7811     ldrb    r1,[r2]                                 
0800373E 1C38     mov     r0,r7                                   
08003740 4008     and     r0,r1                                   
08003742 2800     cmp     r0,0h                                   
08003744 D000     beq     8003748h                                
08003746 7015     strb    r5,[r2]                                 
08003748 6836     ldr     r6,[r6]                                 
0800374A 2C00     cmp     r4,0h                                   
0800374C D100     bne     8003750h                                
0800374E 24A9     mov     r4,0A9h                                 
08003750 1C20     mov     r0,r4                                   
08003752 F000F915 bl      8003980h                                
08003756 1C04     mov     r4,r0                                   
08003758 490B     ldr     r1,=808F2C0h                            
0800375A 00E0     lsl     r0,r4,3h                                
0800375C 1840     add     r0,r0,r1                                
0800375E 6801     ldr     r1,[r0]                                 
08003760 6930     ldr     r0,[r6,10h]                             
08003762 4281     cmp     r1,r0                                   
08003764 D005     beq     8003772h                                
08003766 1C30     mov     r0,r6                                   
08003768 211E     mov     r1,1Eh                                  
0800376A F7FFFA93 bl      8002C94h                                
0800376E 4640     mov     r0,r8                                   
08003770 8444     strh    r4,[r0,22h]   ;下一个房间的音乐写入                          
08003772 4641     mov     r1,r8                                   
08003774 704D     strb    r5,[r1,1h] 

@@end:                             
08003776 BC08     pop     r3                                      
08003778 4698     mov     r8,r3                                   
0800377A BCF0     pop     r4-r7                                   
0800377C BC01     pop     r0                                      
0800377E 4700     bx      r0                                      
08003780 F254     ????                                            
08003782 0808     lsr     r0,r1,20h                               
08003784 3B44     sub     r3,44h                                  
08003786 0300     lsl     r0,r0,0Ch                               
08003788 F2C0     ????                                            
0800378A 0808     lsr     r0,r1,20h

                               
0800378C B5F0     push    r4-r7,r14                               
0800378E 0400     lsl     r0,r0,10h    ;当前房间的音乐?                           
08003790 0C05     lsr     r5,r0,10h                               
08003792 4F1D     ldr     r7,=3001D00h                            
08003794 787E     ldrb    r6,[r7,1h]                              
08003796 2E00     cmp     r6,0h        ;3001d01如果非0结束                           
08003798 D165     bne     @@end                                
0800379A 2001     mov     r0,1h                                   
0800379C 7078     strb    r0,[r7,1h]   ;3001d01写入1                           
0800379E 4C1B     ldr     r4,=808F254h                            
080037A0 6CA0     ldr     r0,[r4,48h]                             
080037A2 210A     mov     r1,0Ah                                  
080037A4 F7FFFA76 bl      8002C94h                                
080037A8 6E20     ldr     r0,[r4,60h]                             
080037AA 210A     mov     r1,0Ah                                  
080037AC F7FFFA72 bl      8002C94h                                
080037B0 4B17     ldr     r3,=3003B44h                            
080037B2 1C1A     mov     r2,r3                                   
080037B4 3230     add     r2,30h                                  
080037B6 7811     ldrb    r1,[r2]                                 
080037B8 2403     mov     r4,3h                                   
080037BA 1C20     mov     r0,r4                                   
080037BC 4008     and     r0,r1                                   
080037BE 2800     cmp     r0,0h                                   
080037C0 D000     beq     80037C4h                                
080037C2 7016     strb    r6,[r2]                                 
080037C4 1C1A     mov     r2,r3                                   
080037C6 3240     add     r2,40h                                  
080037C8 7811     ldrb    r1,[r2]                                 
080037CA 1C20     mov     r0,r4                                   
080037CC 4008     and     r0,r1                                   
080037CE 2800     cmp     r0,0h                                   
080037D0 D000     beq     80037D4h                                
080037D2 7016     strb    r6,[r2]                                 
080037D4 1C38     mov     r0,r7                                   
080037D6 3021     add     r0,21h                                  
080037D8 7801     ldrb    r1,[r0]                                 
080037DA 2030     mov     r0,30h                                  
080037DC 4008     and     r0,r1                                   
080037DE 2800     cmp     r0,0h                                   
080037E0 D01F     beq     8003822h                                
080037E2 8BB8     ldrh    r0,[r7,1Ch]                             
080037E4 385A     sub     r0,5Ah                                  
080037E6 0400     lsl     r0,r0,10h                               
080037E8 0C00     lsr     r0,r0,10h                               
080037EA 2809     cmp     r0,9h                                   
080037EC D812     bhi     8003814h                                
080037EE 1C28     mov     r0,r5                                   
080037F0 385A     sub     r0,5Ah                                  
080037F2 0400     lsl     r0,r0,10h                               
080037F4 0C00     lsr     r0,r0,10h                               
080037F6 2809     cmp     r0,9h                                   
080037F8 D91F     bls     800383Ah                                
080037FA 2010     mov     r0,10h                                  
080037FC 4008     and     r0,r1                                   
080037FE 2549     mov     r5,49h                                  
08003800 2800     cmp     r0,0h                                   
08003802 D01A     beq     800383Ah                                
08003804 2546     mov     r5,46h                                  
08003806 E018     b       800383Ah                                
08003808 1D00     add     r0,r0,4                                 
0800380A 0300     lsl     r0,r0,0Ch                               
0800380C F254     ????                                            
0800380E 0808     lsr     r0,r1,20h                               
08003810 3B44     sub     r3,44h                                  
08003812 0300     lsl     r0,r0,0Ch                               
08003814 1C28     mov     r0,r5                                   
08003816 385A     sub     r0,5Ah                                  
08003818 0400     lsl     r0,r0,10h                               
0800381A 0C00     lsr     r0,r0,10h                               
0800381C 2809     cmp     r0,9h                                   
0800381E D90C     bls     800383Ah                                
08003820 E01E     b       8003860h                                
08003822 2040     mov     r0,40h                                  
08003824 4008     and     r0,r1                                   
08003826 2800     cmp     r0,0h                                   
08003828 D007     beq     800383Ah                                
0800382A 1C28     mov     r0,r5                                   
0800382C 385A     sub     r0,5Ah                                  
0800382E 0400     lsl     r0,r0,10h                               
08003830 0C00     lsr     r0,r0,10h                               
08003832 2809     cmp     r0,9h                                   
08003834 D814     bhi     8003860h                                
08003836 847D     strh    r5,[r7,22h]                             
08003838 E012     b       8003860h                                
0800383A 480C     ldr     r0,=808F254h                            
0800383C 6806     ldr     r6,[r0]                                 
0800383E 4C0C     ldr     r4,=808F2C0h                            
08003840 1C28     mov     r0,r5                                   
08003842 F000F89D bl      8003980h                                
08003846 0400     lsl     r0,r0,10h                               
08003848 0B40     lsr     r0,r0,0Dh                               
0800384A 1900     add     r0,r0,r4                                
0800384C 6801     ldr     r1,[r0]                                 
0800384E 6930     ldr     r0,[r6,10h]                             
08003850 4281     cmp     r1,r0                                   
08003852 D005     beq     8003860h                                
08003854 1C30     mov     r0,r6                                   
08003856 211E     mov     r1,1Eh                                  
08003858 F7FFFA1C bl      8002C94h                                
0800385C 4805     ldr     r0,=3001D00h                            
0800385E 8445     strh    r5,[r0,22h]                             
08003860 4904     ldr     r1,=3001D00h                            
08003862 2000     mov     r0,0h                                   
08003864 7048     strb    r0,[r1,1h]

@@end:                              
08003866 BCF0     pop     r4-r7                                   
08003868 BC01     pop     r0                                      
0800386A 4700     bx      r0                                      
0800386C F254     ????                                            
0800386E 0808     lsr     r0,r1,20h                               
08003870 F2C0     ????                                            
08003872 0808     lsr     r0,r1,20h                               
08003874 1D00     add     r0,r0,4                                 
08003876 0300     lsl     r0,r0,0Ch 

;出门后声音例程                              
08003878 B530     push    r4,r5,r14                               
0800387A 4C07     ldr     r4,=3001D00h                            
0800387C 1C20     mov     r0,r4                                   
0800387E 3021     add     r0,21h                                  
08003880 7801     ldrb    r1,[r0]                                 
08003882 2004     mov     r0,4h                                   
08003884 4008     and     r0,r1                                   
08003886 2800     cmp     r0,0h                                   
08003888 D11E     bne     80038C8h                                
0800388A 2070     mov     r0,70h                                  
0800388C 4008     and     r0,r1                                   
0800388E 2800     cmp     r0,0h                                   
08003890 D004     beq     800389Ch                                
08003892 F000F821 bl      80038D8h                                
08003896 E017     b       80038C8h                                
08003898 1D00     add     r0,r0,4                                 
0800389A 0300     lsl     r0,r0,0Ch                               
0800389C 0608     lsl     r0,r1,18h                               
0800389E 0E05     lsr     r5,r0,18h                               
080038A0 2D00     cmp     r5,0h                                   
080038A2 D111     bne     80038C8h                                
080038A4 8C60     ldrh    r0,[r4,22h]                             
080038A6 2800     cmp     r0,0h                                   
080038A8 D00E     beq     80038C8h                                
080038AA 4809     ldr     r0,=808F254h                            
080038AC 6800     ldr     r0,[r0]                                 
080038AE 4A09     ldr     r2,=808F2C0h                            
080038B0 8C61     ldrh    r1,[r4,22h]                             
080038B2 00C9     lsl     r1,r1,3h                                
080038B4 1889     add     r1,r1,r2                                
080038B6 6809     ldr     r1,[r1]                                 
080038B8 F001F94A bl      8004B50h                                
080038BC 1C20     mov     r0,r4                                   
080038BE 3020     add     r0,20h                                  
080038C0 7005     strb    r5,[r0]                                 
080038C2 8C60     ldrh    r0,[r4,22h]                             
080038C4 83A0     strh    r0,[r4,1Ch]   ;写入新房间音乐                          
080038C6 8465     strh    r5,[r4,22h]                           
080038C8 BC30     pop     r4,r5                                   
080038CA BC01     pop     r0                                      
080038CC 4700     bx      r0                                      
080038CE 0000     lsl     r0,r0,0h                                
