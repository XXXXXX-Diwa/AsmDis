
0805E6F8 B530     push    r4,r5,r14                               
0805E6FA B081     add     sp,-4h                                  
0805E6FC 0600     lsl     r0,r0,18h                               
0805E6FE 0E00     lsr     r0,r0,18h                               
0805E700 4A0F     ldr     r2,=30056F8h                            
0805E702 7951     ldrb    r1,[r2,5h]   ;读取56fd的值                            
0805E704 2900     cmp     r1,0h                                   
0805E706 D125     bne     @@ReturnZero ;不为0则结束并返回0                               
0805E708 28FF     cmp     r0,0FFh                                 
0805E70A D023     beq     @@ReturnZero ;设置值是FF则结束并返回0                               
0805E70C 7150     strb    r0,[r2,5h]   ;56FD写入5                          
0805E70E 7111     strb    r1,[r2,4h]   ;56FE写入0                           
0805E710 7191     strb    r1,[r2,6h]   ;56FF写入0                           
0805E712 2000     mov     r0,0h                                   
0805E714 8051     strh    r1,[r2,2h]   ;56FA-b写入0                           
0805E716 71D0     strb    r0,[r2,7h]   ;5700写入0                           
0805E718 490A     ldr     r1,=2035400h                            
0805E71A 4A0B     ldr     r2,=2035800h                            
0805E71C 2580     mov     r5,80h                                  
0805E71E 00AD     lsl     r5,r5,2h                                
0805E720 2410     mov     r4,10h                                  
0805E722 9400     str     r4,[sp]                                 
0805E724 2003     mov     r0,3h                                   
0805E726 1C2B     mov     r3,r5                                   
0805E728 F7A4FD5C bl      80031E4h                                
0805E72C 4907     ldr     r1,=2035600h                            
0805E72E 4A08     ldr     r2,=2035A00h                            
0805E730 9400     str     r4,[sp]                                 
0805E732 2003     mov     r0,3h                                   
0805E734 1C2B     mov     r3,r5                                   
0805E736 F7A4FD55 bl      80031E4h                                
0805E73A 2001     mov     r0,1h                                   
0805E73C E00B     b       @@end                                 

@@ReturnZero:                             
0805E754 2000     mov     r0,0h 

@@end:                                  
0805E756 B001     add     sp,4h                                   
0805E758 BC30     pop     r4,r5                                   
0805E75A BC02     pop     r1                                      
0805E75C 4708     bx      r1                                      
0805E75E 0000     lsl     r0,r0,0h                                
0805E760 B5F0     push    r4-r7,r14                               
0805E762 2700     mov     r7,0h                                   
0805E764 480E     ldr     r0,=300545Ch                            
0805E766 00FA     lsl     r2,r7,3h                                
0805E768 1813     add     r3,r2,r0                                
0805E76A 7819     ldrb    r1,[r3]                                 
0805E76C 07C9     lsl     r1,r1,1Fh                               
0805E76E 1C04     mov     r4,r0                                   
0805E770 1C16     mov     r6,r2                                   
0805E772 2900     cmp     r1,0h                                   
0805E774 D100     bne     805E778h                                
0805E776 E0B6     b       805E8E6h                                
0805E778 785A     ldrb    r2,[r3,1h]                              
0805E77A 0791     lsl     r1,r2,1Eh                               
0805E77C 0F88     lsr     r0,r1,1Eh                               
0805E77E 2801     cmp     r0,1h                                   
0805E780 D010     beq     805E7A4h                                
0805E782 2803     cmp     r0,3h                                   
0805E784 D00E     beq     805E7A4h                                
0805E786 0910     lsr     r0,r2,4h                                
0805E788 2800     cmp     r0,0h                                   
0805E78A D100     bne     805E78Eh                                
0805E78C E0AB     b       805E8E6h                                
0805E78E 78D8     ldrb    r0,[r3,3h]                              
0805E790 2803     cmp     r0,3h                                   
0805E792 D000     beq     805E796h                                
0805E794 E0A7     b       805E8E6h                                
0805E796 0638     lsl     r0,r7,18h                               
0805E798 0E00     lsr     r0,r0,18h                               
0805E79A F000F95B bl      805EA54h                                
0805E79E E0A2     b       805E8E6h                                
0805E7A0 545C     strb    r4,[r3,r1]                              
0805E7A2 0300     lsl     r0,r0,0Ch                               
0805E7A4 1935     add     r5,r6,r4                                
0805E7A6 7829     ldrb    r1,[r5]                                 
0805E7A8 070A     lsl     r2,r1,1Ch                               
0805E7AA 0F50     lsr     r0,r2,1Dh                               
0805E7AC 2800     cmp     r0,0h                                   
0805E7AE D141     bne     805E834h                                
0805E7B0 7868     ldrb    r0,[r5,1h]                              
0805E7B2 0780     lsl     r0,r0,1Eh                               
0805E7B4 0F80     lsr     r0,r0,1Eh                               
0805E7B6 2801     cmp     r0,1h                                   
0805E7B8 D104     bne     805E7C4h                                
0805E7BA 2086     mov     r0,86h                                  
0805E7BC 0040     lsl     r0,r0,1h                                
0805E7BE F7A4F92B bl      8002A18h                                
0805E7C2 E022     b       805E80Ah                                
0805E7C4 78E8     ldrb    r0,[r5,3h]                              
0805E7C6 2807     cmp     r0,7h                                   
0805E7C8 D81C     bhi     805E804h                                
0805E7CA 0080     lsl     r0,r0,2h                                
0805E7CC 4901     ldr     r1,=805E7D8h                            
0805E7CE 1840     add     r0,r0,r1                                
0805E7D0 6800     ldr     r0,[r0]                                 
0805E7D2 4687     mov     r15,r0                                  
0805E7D4 E7D8     b       805E788h                                
0805E7D6 0805     lsr     r5,r0,20h                               
0805E7D8 E804     ????                                            
0805E7DA 0805     lsr     r5,r0,20h                               
0805E7DC E804     ????                                            
0805E7DE 0805     lsr     r5,r0,20h                               
0805E7E0 E804     ????                                            
0805E7E2 0805     lsr     r5,r0,20h                               
0805E7E4 E804     ????                                            
0805E7E6 0805     lsr     r5,r0,20h                               
0805E7E8 E804     ????                                            
0805E7EA 0805     lsr     r5,r0,20h                               
0805E7EC E804     ????                                            
0805E7EE 0805     lsr     r5,r0,20h                               
0805E7F0 E7F8     b       805E7E4h                                
0805E7F2 0805     lsr     r5,r0,20h                               
0805E7F4 E7F8     b       805E7E8h                                
0805E7F6 0805     lsr     r5,r0,20h                               
0805E7F8 4801     ldr     r0,=117h                                
0805E7FA F7A4F90D bl      8002A18h                                
0805E7FE E004     b       805E80Ah                                
0805E800 0117     lsl     r7,r2,4h                                
0805E802 0000     lsl     r0,r0,0h                                
0805E804 4809     ldr     r0,=10Dh                                
0805E806 F7A4F907 bl      8002A18h                                
0805E80A 4A09     ldr     r2,=300545Ch                            
0805E80C 18B2     add     r2,r6,r2                                
0805E80E 2000     mov     r0,0h                                   
0805E810 7110     strb    r0,[r2,4h]                              
0805E812 7813     ldrb    r3,[r2]                                 
0805E814 0719     lsl     r1,r3,1Ch                               
0805E816 0F49     lsr     r1,r1,1Dh                               
0805E818 3101     add     r1,1h                                   
0805E81A 2007     mov     r0,7h                                   
0805E81C 4001     and     r1,r0                                   
0805E81E 0049     lsl     r1,r1,1h                                
0805E820 200F     mov     r0,0Fh                                  
0805E822 4240     neg     r0,r0                                   
0805E824 4018     and     r0,r3                                   
0805E826 4308     orr     r0,r1                                   
0805E828 7010     strb    r0,[r2]                                 
0805E82A E05C     b       805E8E6h                                
0805E82C 010D     lsl     r5,r1,4h                                
0805E82E 0000     lsl     r0,r0,0h                                
0805E830 545C     strb    r4,[r3,r1]                              
0805E832 0300     lsl     r0,r0,0Ch                               
0805E834 0F50     lsr     r0,r2,1Dh                               
0805E836 2807     cmp     r0,7h                                   
0805E838 D11A     bne     805E870h                                
0805E83A 7868     ldrb    r0,[r5,1h]                              
0805E83C 0780     lsl     r0,r0,1Eh                               
0805E83E 0F80     lsr     r0,r0,1Eh                               
0805E840 2801     cmp     r0,1h                                   
0805E842 D150     bne     805E8E6h                                
0805E844 240F     mov     r4,0Fh                                  
0805E846 4264     neg     r4,r4                                   
0805E848 1C20     mov     r0,r4                                   
0805E84A 4008     and     r0,r1                                   
0805E84C 2108     mov     r1,8h                                   
0805E84E 4308     orr     r0,r1                                   
0805E850 7028     strb    r0,[r5]                                 
0805E852 2001     mov     r0,1h                                   
0805E854 1C39     mov     r1,r7                                   
0805E856 F000F84F bl      805E8F8h                                
0805E85A 7869     ldrb    r1,[r5,1h]                              
0805E85C 2004     mov     r0,4h                                   
0805E85E 4240     neg     r0,r0                                   
0805E860 4008     and     r0,r1                                   
0805E862 2102     mov     r1,2h                                   
0805E864 4308     orr     r0,r1                                   
0805E866 7068     strb    r0,[r5,1h]                              
0805E868 7828     ldrb    r0,[r5]                                 
0805E86A 4004     and     r4,r0                                   
0805E86C 702C     strb    r4,[r5]                                 
0805E86E E03A     b       805E8E6h                                
0805E870 4904     ldr     r1,=83602C2h                            
0805E872 0F50     lsr     r0,r2,1Dh                               
0805E874 1840     add     r0,r0,r1                                
0805E876 7929     ldrb    r1,[r5,4h]                              
0805E878 7800     ldrb    r0,[r0]                                 
0805E87A 4281     cmp     r1,r0                                   
0805E87C D204     bcs     805E888h                                
0805E87E 1C48     add     r0,r1,1                                 
0805E880 7128     strb    r0,[r5,4h]                              
0805E882 E030     b       805E8E6h                                
0805E884 02C2     lsl     r2,r0,0Bh                               
0805E886 0836     lsr     r6,r6,20h                               
0805E888 2000     mov     r0,0h                                   
0805E88A 7128     strb    r0,[r5,4h]                              
0805E88C 2001     mov     r0,1h                                   
0805E88E 1C39     mov     r1,r7                                   
0805E890 F000F832 bl      805E8F8h                                
0805E894 782A     ldrb    r2,[r5]                                 
0805E896 0711     lsl     r1,r2,1Ch                               
0805E898 0F49     lsr     r1,r1,1Dh                               
0805E89A 3101     add     r1,1h                                   
0805E89C 2007     mov     r0,7h                                   
0805E89E 4001     and     r1,r0                                   
0805E8A0 0049     lsl     r1,r1,1h                                
0805E8A2 200F     mov     r0,0Fh                                  
0805E8A4 4240     neg     r0,r0                                   
0805E8A6 4010     and     r0,r2                                   
0805E8A8 4308     orr     r0,r1                                   
0805E8AA 7028     strb    r0,[r5]                                 
0805E8AC 0700     lsl     r0,r0,1Ch                               
0805E8AE 0F40     lsr     r0,r0,1Dh                               
0805E8B0 2805     cmp     r0,5h                                   
0805E8B2 D118     bne     805E8E6h                                
0805E8B4 786A     ldrb    r2,[r5,1h]                              
0805E8B6 0791     lsl     r1,r2,1Eh                               
0805E8B8 0F88     lsr     r0,r1,1Eh                               
0805E8BA 2801     cmp     r0,1h                                   
0805E8BC D105     bne     805E8CAh                                
0805E8BE 2004     mov     r0,4h                                   
0805E8C0 4240     neg     r0,r0                                   
0805E8C2 4010     and     r0,r2                                   
0805E8C4 2102     mov     r1,2h                                   
0805E8C6 4308     orr     r0,r1                                   
0805E8C8 E005     b       805E8D6h                                
0805E8CA 0F88     lsr     r0,r1,1Eh                               
0805E8CC 2803     cmp     r0,3h                                   
0805E8CE D103     bne     805E8D8h                                
0805E8D0 2004     mov     r0,4h                                   
0805E8D2 4240     neg     r0,r0                                   
0805E8D4 4010     and     r0,r2                                   
0805E8D6 7068     strb    r0,[r5,1h]                              
0805E8D8 4806     ldr     r0,=300545Ch                            
0805E8DA 1830     add     r0,r6,r0                                
0805E8DC 7802     ldrb    r2,[r0]                                 
0805E8DE 210F     mov     r1,0Fh                                  
0805E8E0 4249     neg     r1,r1                                   
0805E8E2 4011     and     r1,r2                                   
0805E8E4 7001     strb    r1,[r0]                                 
0805E8E6 3701     add     r7,1h                                   
0805E8E8 2F0F     cmp     r7,0Fh                                  
0805E8EA DC00     bgt     805E8EEh                                
0805E8EC E73A     b       805E764h                                
0805E8EE BCF0     pop     r4-r7                                   
0805E8F0 BC01     pop     r0                                      
0805E8F2 4700     bx      r0                                      
0805E8F4 545C     strb    r4,[r3,r1]                              
0805E8F6 0300     lsl     r0,r0,0Ch                               
0805E8F8 B5F0     push    r4-r7,r14                               
0805E8FA 4657     mov     r7,r10                                  
0805E8FC 464E     mov     r6,r9                                   
0805E8FE 4645     mov     r5,r8                                   
0805E900 B4E0     push    r5-r7                                   
0805E902 B081     add     sp,-4h                                  
0805E904 1C0D     mov     r5,r1                                   
0805E906 0600     lsl     r0,r0,18h                               
0805E908 0E06     lsr     r6,r0,18h                               
0805E90A 480F     ldr     r0,=300545Ch                            
0805E90C 00EC     lsl     r4,r5,3h                                
0805E90E 1821     add     r1,r4,r0                                
0805E910 780A     ldrb    r2,[r1]                                 
0805E912 06D3     lsl     r3,r2,1Bh                               
0805E914 4F0D     ldr     r7,=411h                                
0805E916 4680     mov     r8,r0                                   
0805E918 2B00     cmp     r3,0h                                   
0805E91A DA00     bge     805E91Eh                                
0805E91C 3705     add     r7,5h                                   
0805E91E 0710     lsl     r0,r2,1Ch                               
0805E920 0F40     lsr     r0,r0,1Dh                               
0805E922 1E42     sub     r2,r0,1                                 
0805E924 7848     ldrb    r0,[r1,1h]                              
0805E926 0780     lsl     r0,r0,1Eh                               
0805E928 0F80     lsr     r0,r0,1Eh                               
0805E92A 2803     cmp     r0,3h                                   
0805E92C D117     bne     805E95Eh                                
0805E92E 2002     mov     r0,2h                                   
0805E930 1A82     sub     r2,r0,r2                                
0805E932 2A00     cmp     r2,0h                                   
0805E934 DA0E     bge     805E954h                                
0805E936 2200     mov     r2,0h                                   
0805E938 4805     ldr     r0,=83602C8h                            
0805E93A 78C9     ldrb    r1,[r1,3h]                              
0805E93C 0049     lsl     r1,r1,1h                                
0805E93E 1809     add     r1,r1,r0                                
0805E940 0FD8     lsr     r0,r3,1Fh                               
0805E942 8809     ldrh    r1,[r1]                                 
0805E944 1847     add     r7,r0,r1                                
0805E946 E00A     b       805E95Eh                                
0805E948 545C     strb    r4,[r3,r1]                              
0805E94A 0300     lsl     r0,r0,0Ch                               
0805E94C 0411     lsl     r1,r2,10h                               
0805E94E 0000     lsl     r0,r0,0h                                
0805E950 02C8     lsl     r0,r1,0Bh                               
0805E952 0836     lsr     r6,r6,20h                               
0805E954 78C8     ldrb    r0,[r1,3h]                              
0805E956 46A2     mov     r10,r4                                  
0805E958 2800     cmp     r0,0h                                   
0805E95A D007     beq     805E96Ch                                
0805E95C 3240     add     r2,40h                                  
0805E95E 00E8     lsl     r0,r5,3h                                
0805E960 4643     mov     r3,r8                                   
0805E962 18C1     add     r1,r0,r3                                
0805E964 78C9     ldrb    r1,[r1,3h]                              
0805E966 4682     mov     r10,r0                                  
0805E968 2900     cmp     r1,0h                                   
0805E96A D100     bne     805E96Eh                                
0805E96C 3280     add     r2,80h                                  
0805E96E 18BF     add     r7,r7,r2                                
0805E970 2E00     cmp     r6,0h                                   
0805E972 D025     beq     805E9C0h                                
0805E974 4C11     ldr     r4,=300545Ch                            
0805E976 4454     add     r4,r10                                  
0805E978 79A1     ldrb    r1,[r4,6h]                              
0805E97A 7962     ldrb    r2,[r4,5h]                              
0805E97C 1C38     mov     r0,r7                                   
0805E97E F7FBFDED bl      805A55Ch                                
0805E982 2010     mov     r0,10h                                  
0805E984 19C0     add     r0,r0,r7                                
0805E986 4680     mov     r8,r0                                   
0805E988 79A1     ldrb    r1,[r4,6h]                              
0805E98A 3101     add     r1,1h                                   
0805E98C 7962     ldrb    r2,[r4,5h]                              
0805E98E F7FBFDE5 bl      805A55Ch                                
0805E992 1C39     mov     r1,r7                                   
0805E994 3120     add     r1,20h                                  
0805E996 9100     str     r1,[sp]                                 
0805E998 79A1     ldrb    r1,[r4,6h]                              
0805E99A 3102     add     r1,2h                                   
0805E99C 7962     ldrb    r2,[r4,5h]                              
0805E99E 9800     ldr     r0,[sp]                                 
0805E9A0 F7FBFDDC bl      805A55Ch                                
0805E9A4 1C3D     mov     r5,r7                                   
0805E9A6 3530     add     r5,30h                                  
0805E9A8 79A1     ldrb    r1,[r4,6h]                              
0805E9AA 3103     add     r1,3h                                   
0805E9AC 7962     ldrb    r2,[r4,5h]                              
0805E9AE 1C28     mov     r0,r5                                   
0805E9B0 F7FBFDD4 bl      805A55Ch                                
0805E9B4 4646     mov     r6,r8                                   
0805E9B6 9B00     ldr     r3,[sp]                                 
0805E9B8 4698     mov     r8,r3                                   
0805E9BA E023     b       805EA04h                                
0805E9BC 545C     strb    r4,[r3,r1]                              
0805E9BE 0300     lsl     r0,r0,0Ch                               
0805E9C0 4C23     ldr     r4,=300545Ch                            
0805E9C2 4454     add     r4,r10                                  
0805E9C4 79A1     ldrb    r1,[r4,6h]                              
0805E9C6 7962     ldrb    r2,[r4,5h]                              
0805E9C8 1C38     mov     r0,r7                                   
0805E9CA F7FBFE2D bl      805A628h                                
0805E9CE 2010     mov     r0,10h                                  
0805E9D0 19C0     add     r0,r0,r7                                
0805E9D2 4680     mov     r8,r0                                   
0805E9D4 79A1     ldrb    r1,[r4,6h]                              
0805E9D6 3101     add     r1,1h                                   
0805E9D8 7962     ldrb    r2,[r4,5h]                              
0805E9DA F7FBFE25 bl      805A628h                                
0805E9DE 2120     mov     r1,20h                                  
0805E9E0 19C9     add     r1,r1,r7                                
0805E9E2 4689     mov     r9,r1                                   
0805E9E4 79A1     ldrb    r1,[r4,6h]                              
0805E9E6 3102     add     r1,2h                                   
0805E9E8 7962     ldrb    r2,[r4,5h]                              
0805E9EA 4648     mov     r0,r9                                   
0805E9EC F7FBFE1C bl      805A628h                                
0805E9F0 1C3D     mov     r5,r7                                   
0805E9F2 3530     add     r5,30h                                  
0805E9F4 79A1     ldrb    r1,[r4,6h]                              
0805E9F6 3103     add     r1,3h                                   
0805E9F8 7962     ldrb    r2,[r4,5h]                              
0805E9FA 1C28     mov     r0,r5                                   
0805E9FC F7FBFE14 bl      805A628h                                
0805EA00 4646     mov     r6,r8                                   
0805EA02 46C8     mov     r8,r9                                   
0805EA04 0438     lsl     r0,r7,10h                               
0805EA06 0C00     lsr     r0,r0,10h                               
0805EA08 4C11     ldr     r4,=300545Ch                            
0805EA0A 4454     add     r4,r10                                  
0805EA0C 79A1     ldrb    r1,[r4,6h]                              
0805EA0E 7962     ldrb    r2,[r4,5h]                              
0805EA10 F7FBFE1C bl      805A64Ch                                
0805EA14 0430     lsl     r0,r6,10h                               
0805EA16 0C00     lsr     r0,r0,10h                               
0805EA18 79A1     ldrb    r1,[r4,6h]                              
0805EA1A 3101     add     r1,1h                                   
0805EA1C 7962     ldrb    r2,[r4,5h]                              
0805EA1E F7FBFE15 bl      805A64Ch                                
0805EA22 4643     mov     r3,r8                                   
0805EA24 0418     lsl     r0,r3,10h                               
0805EA26 0C00     lsr     r0,r0,10h                               
0805EA28 79A1     ldrb    r1,[r4,6h]                              
0805EA2A 3102     add     r1,2h                                   
0805EA2C 7962     ldrb    r2,[r4,5h]                              
0805EA2E F7FBFE0D bl      805A64Ch                                
0805EA32 0428     lsl     r0,r5,10h                               
0805EA34 0C00     lsr     r0,r0,10h                               
0805EA36 79A1     ldrb    r1,[r4,6h]                              
0805EA38 3103     add     r1,3h                                   
0805EA3A 7962     ldrb    r2,[r4,5h]                              
0805EA3C F7FBFE06 bl      805A64Ch                                
0805EA40 B001     add     sp,4h                                   
0805EA42 BC38     pop     r3-r5                                   
0805EA44 4698     mov     r8,r3                                   
0805EA46 46A1     mov     r9,r4                                   
0805EA48 46AA     mov     r10,r5                                  
0805EA4A BCF0     pop     r4-r7                                   
0805EA4C BC01     pop     r0                                      
0805EA4E 4700     bx      r0                                      
0805EA50 545C     strb    r4,[r3,r1]                              
0805EA52 0300     lsl     r0,r0,0Ch                               
0805EA54 B570     push    r4-r6,r14                               
0805EA56 0600     lsl     r0,r0,18h                               
0805EA58 0E04     lsr     r4,r0,18h                               
0805EA5A 490B     ldr     r1,=300545Ch                            
0805EA5C 00E0     lsl     r0,r4,3h                                
0805EA5E 1843     add     r3,r0,r1                                
0805EA60 789A     ldrb    r2,[r3,2h]                              
0805EA62 0710     lsl     r0,r2,1Ch                               
0805EA64 1C0E     mov     r6,r1                                   
0805EA66 2800     cmp     r0,0h                                   
0805EA68 D112     bne     805EA90h                                
0805EA6A 2010     mov     r0,10h                                  
0805EA6C 4240     neg     r0,r0                                   
0805EA6E 4010     and     r0,r2                                   
0805EA70 2104     mov     r1,4h                                   
0805EA72 4308     orr     r0,r1                                   
0805EA74 7098     strb    r0,[r3,2h]                              
0805EA76 7859     ldrb    r1,[r3,1h]                              
0805EA78 0909     lsr     r1,r1,4h                                
0805EA7A 2001     mov     r0,1h                                   
0805EA7C 4008     and     r0,r1                                   
0805EA7E 2800     cmp     r0,0h                                   
0805EA80 D010     beq     805EAA4h                                
0805EA82 4D02     ldr     r5,=49Ah                                
0805EA84 E013     b       805EAAEh                                
0805EA86 0000     lsl     r0,r0,0h                                
0805EA88 545C     strb    r4,[r3,r1]                              
0805EA8A 0300     lsl     r0,r0,0Ch                               
0805EA8C 049A     lsl     r2,r3,12h                               
0805EA8E 0000     lsl     r0,r0,0h                                
0805EA90 0F00     lsr     r0,r0,1Ch                               
0805EA92 3801     sub     r0,1h                                   
0805EA94 210F     mov     r1,0Fh                                  
0805EA96 4008     and     r0,r1                                   
0805EA98 2110     mov     r1,10h                                  
0805EA9A 4249     neg     r1,r1                                   
0805EA9C 4011     and     r1,r2                                   
0805EA9E 4301     orr     r1,r0                                   
0805EAA0 7099     strb    r1,[r3,2h]                              
0805EAA2 E036     b       805EB12h                                
0805EAA4 4916     ldr     r1,=83602C8h                            
0805EAA6 78D8     ldrb    r0,[r3,3h]                              
0805EAA8 0040     lsl     r0,r0,1h                                
0805EAAA 1840     add     r0,r0,r1                                
0805EAAC 8805     ldrh    r5,[r0]                                 
0805EAAE 00E0     lsl     r0,r4,3h                                
0805EAB0 1984     add     r4,r0,r6                                
0805EAB2 7820     ldrb    r0,[r4]                                 
0805EAB4 06C0     lsl     r0,r0,1Bh                               
0805EAB6 2800     cmp     r0,0h                                   
0805EAB8 DA00     bge     805EABCh                                
0805EABA 3501     add     r5,1h                                   
0805EABC 79A1     ldrb    r1,[r4,6h]                              
0805EABE 7962     ldrb    r2,[r4,5h]                              
0805EAC0 1C28     mov     r0,r5                                   
0805EAC2 F7FBFD4B bl      805A55Ch                                
0805EAC6 1C28     mov     r0,r5                                   
0805EAC8 3010     add     r0,10h                                  
0805EACA 79A1     ldrb    r1,[r4,6h]                              
0805EACC 3101     add     r1,1h                                   
0805EACE 7962     ldrb    r2,[r4,5h]                              
0805EAD0 F7FBFD44 bl      805A55Ch                                
0805EAD4 1C28     mov     r0,r5                                   
0805EAD6 3020     add     r0,20h                                  
0805EAD8 79A1     ldrb    r1,[r4,6h]                              
0805EADA 3102     add     r1,2h                                   
0805EADC 7962     ldrb    r2,[r4,5h]                              
0805EADE F7FBFD3D bl      805A55Ch                                
0805EAE2 1C28     mov     r0,r5                                   
0805EAE4 3030     add     r0,30h                                  
0805EAE6 79A1     ldrb    r1,[r4,6h]                              
0805EAE8 3103     add     r1,3h                                   
0805EAEA 7962     ldrb    r2,[r4,5h]                              
0805EAEC F7FBFD36 bl      805A55Ch                                
0805EAF0 7862     ldrb    r2,[r4,1h]                              
0805EAF2 0611     lsl     r1,r2,18h                               
0805EAF4 0F08     lsr     r0,r1,1Ch                               
0805EAF6 2803     cmp     r0,3h                                   

