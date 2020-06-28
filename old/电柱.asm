
.definelabel EventCheck,0x80608BC
.definelabel Division,0x808AC34
.definelabel SetGFXEffect,0x80540EC

080406C8 B5F0     push    r4-r7,r14                               
080406CA 4909     ldr     r1,=3000738h                            
080406CC 1C08     mov     r0,r1                                   
080406CE 3024     add     r0,24h                                  
080406D0 7800     ldrb    r0,[r0]                                 
080406D2 1C0D     mov     r5,r1                                   
080406D4 2800     cmp     r0,0h                                   
080406D6 D000     beq     @@PoseZero                                
080406D8 E080     b       @@OtherPose 

@@PoseZero:                               
080406DA 2400     mov     r4,0h                                   
080406DC 8829     ldrh    r1,[r5]                 ;读取取向                         
080406DE 4805     ldr     r0,=0FFFBh                              
080406E0 4008     and     r0,r1                   ;FFFB and 1                         
080406E2 8028     strh    r0,[r5]                                 
080406E4 7F68     ldrb    r0,[r5,1Dh]                             
080406E6 287D     cmp     r0,7Dh                                  
080406E8 D006     beq     @@Sprite7D                               
080406EA 2887     cmp     r0,87h                                  
080406EC D018     beq     @@Sprite87                                
080406EE E02C     b       @@OtherSprite                                

@@Sprite7D:                               
080406F8 2003     mov     r0,3h                                   
080406FA 213D     mov     r1,3Dh                                  
080406FC F020F8DE bl      EventCheck              ;检查事件3D是否激活                            
08040700 2800     cmp     r0,0h                                   
08040702 D01F     beq     @@NoTrigger                                
08040704 4905     ldr     r1,=0FFFFFB00h          ;一旦3D事件激活                         
08040706 1C08     mov     r0,r1                                   
08040708 88A9     ldrh    r1,[r5,4h]              ;坐标向左偏移20格                         
0804070A 1840     add     r0,r0,r1                                
0804070C 80A8     strh    r0,[r5,4h]                              
0804070E 2003     mov     r0,3h                                   
08040710 213F     mov     r1,3Fh                                  
08040712 F020F8D3 bl      EventCheck              ;检查事件3F是否激活                           
08040716 2800     cmp     r0,0h                                   
08040718 D014     beq     @@NoTrigger                                
0804071A E016     b       @@OtherSprite                                

@@Sprite87:                                
08040720 2003     mov     r0,3h                                   
08040722 213E     mov     r1,3Eh                                  
08040724 F020F8CA bl      EventCheck              ;检查事件3E是否激活                           
08040728 2800     cmp     r0,0h                                   
0804072A D00B     beq     @@NoTrigger                                
0804072C 4908     ldr     r1,=0FFFFFB00h                          
0804072E 1C08     mov     r0,r1                                   
08040730 88A9     ldrh    r1,[r5,4h]                              
08040732 1840     add     r0,r0,r1                                
08040734 80A8     strh    r0,[r5,4h]              ;坐标向左偏移20格                          
08040736 2003     mov     r0,3h                                   
08040738 2140     mov     r1,40h                                  
0804073A F020F8BF bl      EventCheck              ;检查事件40是否激活                           
0804073E 2800     cmp     r0,0h                                   
08040740 D000     beq     @@NoTrigger                                
08040742 2401     mov     r4,1h          

@@NoTrigger:                                  
08040744 4D03     ldr     r5,=3000738h                             
08040746 2C00     cmp     r4,0h                                
08040748 D006     beq     @@NoDoubleTrigger       ;双激活则不跳转,非双激活则跳转

@@OtherSprite:                               
0804074A 2000     mov     r0,0h                                   
0804074C 8028     strh    r0,[r5]                 ;消失                  
0804074E E13E     b       @@end                                

@@NoDoubleTrigger:                               
08040758 1C29     mov     r1,r5                                   
0804075A 3127     add     r1,27h                                  
0804075C 2030     mov     r0,30h                                  
0804075E 7008     strb    r0,[r1]                 ;300075F写入30h                
08040760 1C28     mov     r0,r5                                   
08040762 3028     add     r0,28h                                  
08040764 7004     strb    r4,[r0]                 ;3000760写入0h                
08040766 3102     add     r1,2h                                   
08040768 2008     mov     r0,8h                                   
0804076A 7008     strb    r0,[r1]                 ;3000761写入8h                
0804076C 2100     mov     r1,0h                                   
0804076E 4815     ldr     r0,=0FF40h                              
08040770 8168     strh    r0,[r5,0Ah]             ;上部分界C0h                
08040772 81AC     strh    r4,[r5,0Ch]             ;下部分界0h                
08040774 30A0     add     r0,0A0h                                 
08040776 81E8     strh    r0,[r5,0Eh]             ;左部分界60h                
08040778 2020     mov     r0,20h                                  
0804077A 8228     strh    r0,[r5,10h]             ;右部分界20h                
0804077C 1C2A     mov     r2,r5                                   
0804077E 3233     add     r2,33h                                  
08040780 2001     mov     r0,1h                                   
08040782 7010     strb    r0,[r2]                 ;300076b写入1                
08040784 3A0E     sub     r2,0Eh                                  
08040786 200C     mov     r0,0Ch                                  
08040788 7010     strb    r0,[r2]                 ;属性写入Ch                
0804078A 480F     ldr     r0,=82FE974h                            
0804078C 61A8     str     r0,[r5,18h]             ;写入OAM                
0804078E 7729     strb    r1,[r5,1Ch]                             
08040790 82EC     strh    r4,[r5,16h]                             
08040792 1C29     mov     r1,r5                                   
08040794 3122     add     r1,22h                                  
08040796 2005     mov     r0,5h                                   
08040798 7008     strb    r0,[r1]                 ;300075a写入5h                
0804079A 4A0C     ldr     r2,=82B0D68h                            
0804079C 7F69     ldrb    r1,[r5,1Dh]                             
0804079E 00C8     lsl     r0,r1,3h                                
080407A0 1840     add     r0,r0,r1                                
080407A2 0040     lsl     r0,r0,1h                                
080407A4 1880     add     r0,r0,r2                                
080407A6 8800     ldrh    r0,[r0]                                 
080407A8 82A8     strh    r0,[r5,14h]             ;写入血量                
080407AA 8268     strh    r0,[r5,12h]             ;备份到300074a                
080407AC 1C29     mov     r1,r5                                   
080407AE 3124     add     r1,24h                                  
080407B0 2009     mov     r0,9h                                   
080407B2 7008     strb    r0,[r1]                 ;Pose写入9h                 
080407B4 4806     ldr     r0,=300002Ch                            
080407B6 7800     ldrb    r0,[r0]                                 
080407B8 2800     cmp     r0,0h                   ;读取难度                
080407BA D10B     bne     @@NoEasy                                
080407BC 3108     add     r1,8h                                   
080407BE 203C     mov     r0,3Ch                                  
080407C0 E00B     b       @@Peer                                

@@NoEasy:                              
080407D4 1C29     mov     r1,r5                                   
080407D6 312C     add     r1,2Ch                                  
080407D8 201E     mov     r0,1Eh  

@@Peer:                                
080407DA 7008     strb    r0,[r1]                 ;3000764写入计时帧数

@@OtherPose:                                
080407DC 4A0F     ldr     r2,=82B0D68h                            
080407DE 7F69     ldrb    r1,[r5,1Dh]                             
080407E0 00C8     lsl     r0,r1,3h                                
080407E2 1840     add     r0,r0,r1                                
080407E4 0040     lsl     r0,r0,1h                                
080407E6 1880     add     r0,r0,r2                                
080407E8 8806     ldrh    r6,[r0]                 ;最初血量                
080407EA 8AAC     ldrh    r4,[r5,14h]             ;当前血量                
080407EC 1B30     sub     r0,r6,r4                ;减去最初                
080407EE 2114     mov     r1,14h                                  
080407F0 F04AFA20 bl      Division                ;已经打击掉的血量和20除,计算                
080407F4 1C02     mov     r2,r0                   ;已经打了几发导弹               
080407F6 8A68     ldrh    r0,[r5,12h]             ;得到备份的血量值                
080407F8 4284     cmp     r4,r0                   ;和当前血量比                
080407FA D111     bne     @@HpChange                                
080407FC 2A00     cmp     r2,0h                   ;打的伤害                
080407FE D100     bne     @@DamageMoreThan20      ;足20跳转                
08040800 E0E5     b       @@end  

@@DamageMoreThan20:                              
08040802 1C29     mov     r1,r5                                   
08040804 312C     add     r1,2Ch                                  
08040806 7808     ldrb    r0,[r1]                 ;读取计数值                 
08040808 3801     sub     r0,1h                                   
0804080A 7008     strb    r0,[r1]                 ;减1写入                
0804080C 0600     lsl     r0,r0,18h                               
0804080E 2800     cmp     r0,0h                                   
08040810 D000     beq     @@TimeZero                                
08040812 E0DC     b       @@end  

@@TimeZero:                              
08040814 8AA8     ldrh    r0,[r5,14h]                             
08040816 3014     add     r0,14h                  ;当前血量加20                 
08040818 82A8     strh    r0,[r5,14h]                             
0804081A E0D8     b       @@end                                


@@HpChange:                              
08040820 42B4     cmp     r4,r6                   ;当前血量和满血相比                 
08040822 D20D     bcs     @@PassReTimes           ;大于或等于                
08040824 4803     ldr     r0,=300002Ch                            
08040826 7800     ldrb    r0,[r0]                                 
08040828 2800     cmp     r0,0h                                   
0804082A D105     bne     @@NoEasy2                                
0804082C 1C29     mov     r1,r5                                   
0804082E 312C     add     r1,2Ch                                  
08040830 203C     mov     r0,3Ch                                  
08040832 E004     b       @@Peer2                                

@@NoEasy2:                               
08040838 1C29     mov     r1,r5                                   
0804083A 312C     add     r1,2Ch                                  
0804083C 201E     mov     r0,1Eh 

@@Peer2:                                 
0804083E 7008     strb    r0,[r1]                 ;写入新的计数值

@@PassReTimes:                                
08040840 1C2C     mov     r4,r5                                   
08040842 8AA0     ldrh    r0,[r4,14h]                             
08040844 2700     mov     r7,0h                                   
08040846 2600     mov     r6,0h                                   
08040848 8260     strh    r0,[r4,12h]             ;当前血量备份                
0804084A 2A06     cmp     r2,6h                   ;比较击打血量值累计小于6h                
0804084C D900     bls     @@MissileHitNo7                                
0804084E E07D     b       @@MIssileHit7

@@MissileHitNo7:                                
08040850 0090     lsl     r0,r2,2h                ;通过被击打次数写入不同的OAM                
08040852 4902     ldr     r1,=OAMTable                            
08040854 1840     add     r0,r0,r1                                
08040856 6800     ldr     r0,[r0]                                 
08040858 4687     mov     r15,r0                                  

OAMTable:
    .word 804807ch
	.word 8048094h
	.word 8048094h
	.word 80480dch
	.word 80480dch
	.word 804902ch
	.word 804902ch

;要写入满血OAM	
0804087C 69A8     ldr     r0,[r5,18h]                             
0804087E 4C03     ldr     r4,=82FE974h           ;满血OAM                 
08040880 42A0     cmp     r0,r4                  ;比较当前OAM是否一样                 
08040882 D100     bne     @@OAMNoFullHp                                
08040884 E0A3     b       @@end 

@@OAMNoFullHp:                               
08040886 4802     ldr     r0,=266h               ;发出恢复声音                 
08040888 E055     b       @@Peer3                                

;要写入1-2血OAM                               
08040894 69A9     ldr     r1,[r5,18h]                             
08040896 4805     ldr     r0,=82FE9ACh           ;比较第1-2血OAM                  
08040898 4281     cmp     r1,r0                                   
0804089A D100     bne     @@NoSameOneHit                                
0804089C E097     b       @@end  

@@NoSameOneHit:                              
0804089E 4804     ldr     r0,=82FE974h           ;比较满血OAM                 
080408A0 4281     cmp     r1,r0                                   
080408A2 D109     bne     @@NoSameFullHp2                                
080408A4 4803     ldr     r0,=265h                                
080408A6 F7C2F93B bl      8002B20h                                
080408AA E00B     b       @@NoFullOrNoSameOneHitAndNoSame34Hit                               

@@NoSameFullHp2:                                
080408B8 4804     ldr     r0,=82FE9E4h           ;比较是否是3-4血OAM                
080408BA 4281     cmp     r1,r0                                   
080408BC D102     bne     @@NoFullOrNoSameOneHitAndNoSame34Hit                                
080408BE 4804     ldr     r0,=266h                                
080408C0 F7C2F92E bl      8002B20h 

@@NoFullOrNoSameOneHitAndNoSame34Hit:                               
080408C4 4803     ldr     r0,=3000738h                            
080408C6 4904     ldr     r1,=82FE9ACh           ;写入第1-2血OAM                 
080408C8 E022     b       @@Peer4                                

;要写入3-4血OAM                              
080408DC 69A9     ldr     r1,[r5,18h]                             
080408DE 4805     ldr     r0,=82FE9E4h           ;比较是否是3-4血OAM                 
080408E0 4281     cmp     r1,r0                                   
080408E2 D074     beq     @@end                  ;是则结束              
080408E4 4804     ldr     r0,=82FE9ACh                            
080408E6 4281     cmp     r1,r0                  ;比较是否是1-2血OAM                  
080408E8 D10A     bne     @@NoSame12Hit                                
080408EA 4804     ldr     r0,=265h               ;是则播放恢复声音                 
080408EC F7C2F918 bl      8002B20h                                
080408F0 E00C     b       @@Write34HitOAM                                 

@@NoSame12Hit:                               
08040900 4806     ldr     r0,=82FEA1Ch           ;比较是否是5-6血OAM                 
08040902 4281     cmp     r1,r0                                   
08040904 D102     bne     @@Write34HitOAM                                
08040906 4806     ldr     r0,=266h               ;是则播放伤害声音                  
08040908 F7C2F90A bl      8002B20h 

@@Write34HitOAM:                               
0804090C 4805     ldr     r0,=3000738h                            
0804090E 4906     ldr     r1,=82FE9E4h 

@@Peer4:                           
08040910 6181     str     r1,[r0,18h]                             
08040912 2100     mov     r1,0h                                   
08040914 7701     strb    r1,[r0,1Ch]                             
08040916 82C1     strh    r1,[r0,16h]                             
08040918 E059     b       @@end                                

;要写入5-6血OAM                              
0804092C 69A8     ldr     r0,[r5,18h]                             
0804092E 4C05     ldr     r4,=82FEA1Ch                            
08040930 42A0     cmp     r0,r4                                   
08040932 D04C     beq     @@end                ;是5-6血OAM跳转                    
08040934 4804     ldr     r0,=265h             ;不是的话写入5-6血OAM

@@Peer3:                               
08040936 F7C2F8F3 bl      8002B20h                                
0804093A 61AC     str     r4,[r5,18h]    ;播放声音和写回满血OAM                          
0804093C 2000     mov     r0,0h                                   
0804093E 7728     strb    r0,[r5,1Ch]                             
08040940 82E8     strh    r0,[r5,16h]    ;动画和帧归零结束                          
08040942 E044     b       @@end                                

@@MissileHit7:                                
0804094C 8860     ldrh    r0,[r4,2h]                              
0804094E 3848     sub     r0,48h                                  
08040950 88A1     ldrh    r1,[r4,4h]                              
08040952 2222     mov     r2,22h                                  
08040954 F013FBCA bl      SetGFXEffect   ;播放爆炸动画                             
08040958 4804     ldr     r0,=12Fh       ;以及声音                         
0804095A F7C2F85D bl      8002A18h                                
0804095E 7F60     ldrb    r0,[r4,1Dh]                             
08040960 287D     cmp     r0,7Dh                                  
08040962 D005     beq     @@Sprite7D2                                
08040964 2887     cmp     r0,87h                                  
08040966 D01B     beq     80409A0h                                
08040968 8026     strh    r6,[r4]        ;其他ID则消失                          
0804096A E030     b       @@end                                 

@@Sprite7D2:                               
08040970 2003     mov     r0,3h                                   
08040972 213D     mov     r1,3Dh                                  
08040974 F01FFFA2 bl      EventCheck                                
08040978 2800     cmp     r0,0h                                   
0804097A D10B     bne     @@3DTrigger                                
0804097C 8820     ldrh    r0,[r4]                                 
0804097E 2104     mov     r1,4h                                   
08040980 4308     orr     r0,r1         ;取向 orr 4 再写入                           
08040982 8020     strh    r0,[r4]       ;为了在pose0时偏移后再次出现                          
08040984 1C20     mov     r0,r4                                   
08040986 3024     add     r0,24h                                  
08040988 7007     strb    r7,[r0]       ;pose写回0                          
0804098A 2001     mov     r0,1h         ;激活3D事件                          
0804098C 213D     mov     r1,3Dh                                  
0804098E F01FFF95 bl      EventCheck                                
08040992 E01C     b       @@end    

@@3DTrigger:                            
08040994 8026     strh    r6,[r4]       ;彻底消失                          
08040996 2001     mov     r0,1h         ;并激活3F事件                          
08040998 213F     mov     r1,3Fh                                  
0804099A F01FFF8F bl      EventCheck                                
0804099E E016     b       @@end   

@@Sprite872:                             
080409A0 2003     mov     r0,3h                                   
080409A2 213E     mov     r1,3Eh                                  
080409A4 F01FFF8A bl      EventCheck                                
080409A8 2800     cmp     r0,0h                                   
080409AA D10B     bne     @@3ETrigger                                
080409AC 8820     ldrh    r0,[r4]                                 
080409AE 2104     mov     r1,4h                                   
080409B0 4308     orr     r0,r1                                   
080409B2 8020     strh    r0,[r4]                                 
080409B4 1C20     mov     r0,r4                                   
080409B6 3024     add     r0,24h                                  
080409B8 7007     strb    r7,[r0]                                 
080409BA 2001     mov     r0,1h                                   
080409BC 213E     mov     r1,3Eh                                  
080409BE F01FFF7D bl      EventCheck                                
080409C2 E004     b       @@end  

@@3ETrigger:                              
080409C4 802E     strh    r6,[r5]                                 
080409C6 2001     mov     r0,1h                                   
080409C8 2140     mov     r1,40h                                  
080409CA F01FFF77 bl      EventCheck 

@@end:                               
080409CE BCF0     pop     r4-r7                                   
080409D0 BC01     pop     r0                                      
080409D2 4700     bx      r0 
