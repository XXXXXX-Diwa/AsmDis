

0805B24C B530     push    r4,r5,r14                               
0805B24E B081     add     sp,-4h                                  
0805B250 21A0     mov     r1,0A0h                                 
0805B252 04C9     lsl     r1,r1,13h   ;5000000                            
0805B254 4A09     ldr     r2,=2035400h                            
0805B256 2580     mov     r5,80h                                  
0805B258 00AD     lsl     r5,r5,2h    ;200                             
0805B25A 2410     mov     r4,10h                                  
0805B25C 9400     str     r4,[sp]     ;10h                            
0805B25E 2003     mov     r0,3h                                   
0805B260 1C2B     mov     r3,r5       ;200h                             
0805B262 F7A7FFBF bl      80031E4h    ;直接存储器存取转让                            
0805B266 4906     ldr     r1,=5000200h                            
0805B268 4A06     ldr     r2,=2035600h                            
0805B26A 9400     str     r4,[sp]                                 
0805B26C 2003     mov     r0,3h                                   
0805B26E 1C2B     mov     r3,r5                                   
0805B270 F7A7FFB8 bl      80031E4h                                
0805B274 B001     add     sp,4h                                   
0805B276 BC30     pop     r4,r5                                   
0805B278 BC01     pop     r0                                      
0805B27A 4700     bx      r0                                      


0805B288 B530     push    r4,r5,r14                               
0805B28A B081     add     sp,-4h                                  
0805B28C 21A0     mov     r1,0A0h                                 
0805B28E 04C9     lsl     r1,r1,13h                               
0805B290 4A09     ldr     r2,=2035000h                            
0805B292 2580     mov     r5,80h                                  
0805B294 00AD     lsl     r5,r5,2h                                
0805B296 2410     mov     r4,10h                                  
0805B298 9400     str     r4,[sp]                                 
0805B29A 2003     mov     r0,3h                                   
0805B29C 1C2B     mov     r3,r5                                   
0805B29E F7A7FFA1 bl      80031E4h                                
0805B2A2 4906     ldr     r1,=5000200h                            
0805B2A4 4A06     ldr     r2,=2035200h                            
0805B2A6 9400     str     r4,[sp]                                 
0805B2A8 2003     mov     r0,3h                                   
0805B2AA 1C2B     mov     r3,r5                                   
0805B2AC F7A7FF9A bl      80031E4h                                
0805B2B0 B001     add     sp,4h                                   
0805B2B2 BC30     pop     r4,r5                                   
0805B2B4 BC01     pop     r0                                      
0805B2B6 4700     bx      r0 



0805BFD4 B500     push    r14                                     
0805BFD6 0600     lsl     r0,r0,18h                               
0805BFD8 0E00     lsr     r0,r0,18h                               
0805BFDA 3801     sub     r0,1h                                   
0805BFDC 2807     cmp     r0,7h                                   
0805BFDE D845     bhi     @@end                                
0805BFE0 0080     lsl     r0,r0,2h                                
0805BFE2 4902     ldr     r1,=805BFF0h  ;CutsceneTable                          
0805BFE4 1840     add     r0,r0,r1                                
0805BFE6 6800     ldr     r0,[r0]                                 
0805BFE8 4687     mov     r15,r0                                  

CutsceneTable:
    .word 805c010h  ;00
	.word 805c02ch  ;01
	.word 805c034h  ;02
	.word 805c03ch  ;03
	.word 805c044h  ;04
	.word 805c04ch  ;05
	.word 805c054h  ;06
	.word 805c05ch  ;07

;动画1	逃离母舰结束动画
0805C010 4904     ldr     r1,=3000043h                            
0805C012 2001     mov     r0,1h                                   
0805C014 7008     strb    r0,[r1]                                 
0805C016 4904     ldr     r1,=3000C21h                            
0805C018 2000     mov     r0,0h                                   
0805C01A 7008     strb    r0,[r1]                                 
0805C01C F7FFF990 bl      805B340h  ;数据转移???                              
0805C020 200F     mov     r0,0Fh                                  
0805C022 E01E     b       @@Peer                                

;动画2  game over界面                             
0805C02C F7FFF988 bl      805B340h  ;数据转移???                              
0805C030 200C     mov     r0,0Ch                                  
0805C032 E016     b       @@Peer 

;动画3   逃离泽贝尔被海盗击落动画                           
0805C034 2004     mov     r0,4h                                   
0805C036 F002FB5F bl      805E6F8h                                
0805C03A E017     b       @@end  

;动画4   获取全装甲动画                            
0805C03C F7FFF980 bl      805B340h  ;数据转移???                               
0805C040 2011     mov     r0,11h                                  
0805C042 E00E     b       @@Peer 

;动画5   samus遭遇莱德利动画                             
0805C044 F7FFF97C bl      805B340h  ;数据转移???                              
0805C048 2012     mov     r0,12h                                  
0805C04A E00A     b       @@Peer

;动画6   莱德利和克雷德死亡后展示母脑区通道开启的动画                             
0805C04C F7FFF978 bl      805B340h  ;数据转移???                               
0805C050 2013     mov     r0,13h                                  
0805C052 E006     b       @@Peer 

;动画7   游戏一开始显示文字,从第一区的第一个门落下                            
0805C054 2005     mov     r0,5h                                   
0805C056 F002FB4F bl      805E6F8h                                
0805C05A E007     b       @@end 

;动画8   开启三叶虫动画                            
0805C05C F7FFF970 bl      805B340h  ;数据转移???                              
0805C060 2016     mov     r0,16h 

@@Peer:                                
0805C062 F000F807 bl      805C074h                                
0805C066 4902     ldr     r1,=3000C72h                            
0805C068 2003     mov     r0,3h                                   
0805C06A 8008     strh    r0,[r1]    ;黑屏暂停

@@end:                                
0805C06C BC01     pop     r0                                      
0805C06E 4700     bx      r0                                      

                             
0805C074 4904     ldr     r1,=3005520h                            
0805C076 2200     mov     r2,0h                                   
0805C078 7008     strb    r0,[r1]                                 
0805C07A 704A     strb    r2,[r1,1h]                              
0805C07C 708A     strb    r2,[r1,2h]                              
0805C07E 70CA     strb    r2,[r1,3h]                              
0805C080 710A     strb    r2,[r1,4h]                              
0805C082 714A     strb    r2,[r1,5h]                              
0805C084 80CA     strh    r2,[r1,6h]                              
0805C086 4770     bx      r14                                     


0805E6F8 B530     push    r4,r5,r14                               
0805E6FA B081     add     sp,-4h                                  
0805E6FC 0600     lsl     r0,r0,18h                               
0805E6FE 0E00     lsr     r0,r0,18h                               
0805E700 4A0F     ldr     r2,=30056F8h                            
0805E702 7951     ldrb    r1,[r2,5h]                              
0805E704 2900     cmp     r1,0h                                   
0805E706 D125     bne     @@Nowork                                
0805E708 28FF     cmp     r0,0FFh                                 
0805E70A D023     beq     @@Nowork                                
0805E70C 7150     strb    r0,[r2,5h]                              
0805E70E 7111     strb    r1,[r2,4h]                              
0805E710 7191     strb    r1,[r2,6h]                              
0805E712 2000     mov     r0,0h                                   
0805E714 8051     strh    r1,[r2,2h]                              
0805E716 71D0     strb    r0,[r2,7h]                              
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

@@Nowork:                               
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

