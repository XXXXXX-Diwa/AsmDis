
.definelabel PoseTable,0x8045E6C
.definelabel PlaySound,0x8002A18
.definelabel SpawnSecSprite,0x800E258
.definelabel CheckEvent,0x80608BC
.definelabel CheckEvenSecSprite,8010850h

0801036C B500     push    r14                                     
0801036E 4805     ldr     r0,=30013D4h                            
08010370 7800     ldrb    r0,[r0]         ;读取SA姿势                        
08010372 3804     sub     r0,4h           ;减去4h                        
08010374 2838     cmp     r0,38h                                  
08010376 D900     bls     @@Pass          ;小于或等于                        
08010378 E07C     b       @@MovZero

@@Pass:                                
0801037A 0080     lsl     r0,r0,2h                                
0801037C 4902     ldr     r1,=801038Ch                            
0801037E 1840     add     r0,r0,r1                                
08010380 6800     ldr     r0,[r0]                                 
08010382 4687     mov     r15,r0 

    .word 8010470h 
	.word 8010470h
	.word 8010470h
	
    .word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	
	.word 8010470h
	.word 8010470h
	.word 8010470h
	.word 8010470h
	.word 8010470h
	
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
    .word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	.word 8010474h
	
	.word 8010470h
	
	.word 8010474h
	.word 8010474h
	
	.word 8010470h
	.word 8010470h
	.word 8010470h
	.word 8010470h
	.word 8010470h
	.word 8010470h
	.word 8010470h
	
	.word 8010474h
	
	.word 8010470h
	
08010470 2001     mov     r0,1h                                   
08010472 E000     b       @@end

@@MovZero:                                
08010474 2000     mov     r0,0h

@@end:                                   
08010476 BC02     pop     r1                                      
08010478 4708     bx      r1 

                                     

;调用例程
08044D58 B530     push    r4,r5,r14                               
08044D5A F7CBFB07 bl      801036Ch     ;筛选姿势                              
08044D5E 2800     cmp     r0,0h                                   
08044D60 D128     bne     @@ReturnZero                                
08044D62 4D11     ldr     r5,=30013D4h                            
08044D64 8A6A     ldrh    r2,[r5,12h]                             
08044D66 4C11     ldr     r4,=3000738h                            
08044D68 88A1     ldrh    r1,[r4,4h]   ;读取两者的水平坐标                           
08044D6A 1C08     mov     r0,r1                                   
08044D6C 3830     sub     r0,30h       ;精灵的水平坐标左边30h                           
08044D6E 4290     cmp     r0,r2                                   
08044D70 DA20     bge     @@ReturnZero ;大于等于人物坐标跳转                               
08044D72 3060     add     r0,60h                                  
08044D74 4290     cmp     r0,r2        ;精灵的水平坐标右边30h                           
08044D76 DD1D     ble     @@ReturnZero ;大于等于人物坐标跳转                               
08044D78 201F     mov     r0,1Fh                                  
08044D7A F7C2FBB5 bl      80074E8h     ;改变pose为1F???                           
08044D7E 2001     mov     r0,1h                                   
08044D80 72A8     strb    r0,[r5,0Ah]  ;加速累计值写入1???                            
08044D82 7068     strb    r0,[r5,1h]   ;站立在敌人身上flag                           
08044D84 88A0     ldrh    r0,[r4,4h]                              
08044D86 2200     mov     r2,0h                                   
08044D88 8268     strh    r0,[r5,12h]  ;精灵X坐标写入人物X坐标                           
08044D8A 1C21     mov     r1,r4                                   
08044D8C 312C     add     r1,2Ch                                  
08044D8E 2038     mov     r0,38h       ;3000764写入38h                           
08044D90 7008     strb    r0,[r1]                                 
08044D92 1C20     mov     r0,r4                                   
08044D94 3025     add     r0,25h                                  
08044D96 7002     strb    r2,[r0]      ;属性写入0                           
08044D98 300C     add     r0,0Ch                                  
08044D9A 7002     strb    r2,[r0]      ;3000769写入0 站敌人身上应为2的说                           
08044D9C 8821     ldrh    r1,[r4]                                 
08044D9E 4804     ldr     r0,=0EFFFh                              
08044DA0 4008     and     r0,r1                                   
08044DA2 8020     strh    r0,[r4]      ;去掉取向的1000h                             
08044DA4 2001     mov     r0,1h                                   
08044DA6 E006     b       @@end                                

@@ReturnZero:                                
08044DB4 2000     mov     r0,0h  

@@end:                                 
08044DB6 BC30     pop     r4,r5                                   
08044DB8 BC02     pop     r1                                      
08044DBA 4708     bx      r1                                      

;pose 0 区分是否是从0门入(开场),以及生产舱盖
08044DBC B5F0     push    r4-r7,r14                               
08044DBE 4657     mov     r7,r10                                  
08044DC0 464E     mov     r6,r9                                   
08044DC2 4645     mov     r5,r8                                   
08044DC4 B4E0     push    r5-r7                                   
08044DC6 B083     add     sp,-0Ch                                 
08044DC8 2000     mov     r0,0h                                   
08044DCA 4682     mov     r10,r0                                  
08044DCC 483D     ldr     r0,=3000056h                            
08044DCE 7800     ldrb    r0,[r0]          ;当前或最后经过的门编号                            
08044DD0 2800     cmp     r0,0h                                   
08044DD2 D10A     bne     @@CurrentOrLastDoorIDNoZero                                
08044DD4 2101     mov     r1,1h                                   
08044DD6 468A     mov     r10,r1                                  
08044DD8 483B     ldr     r0,=3000738h                            
08044DDA 4A3C     ldr     r2,=0FFFFFE80h                          
08044DDC 1C11     mov     r1,r2                                   
08044DDE 8843     ldrh    r3,[r0,2h]       ;精灵垂直坐标                            
08044DE0 18C9     add     r1,r1,r3         ;上升180h高度                            
08044DE2 8041     strh    r1,[r0,2h]       ;再写入                            
08044DE4 483A     ldr     r0,=232h         ;播放降落的声音                            
08044DE6 F7BDFE17 bl      PlaySound        ;意味如果最后经过的门是0,则飞船设定浮空

@@CurrentOrLastDoorIDNoZero:                               
08044DEA 4D37     ldr     r5,=3000738h                            
08044DEC 1C2A     mov     r2,r5                                   
08044DEE 3232     add     r2,32h           ;读取碰撞属性                            
08044DF0 7811     ldrb    r1,[r2]                                 
08044DF2 2001     mov     r0,1h                                   
08044DF4 2300     mov     r3,0h                                   
08044DF6 4699     mov     r9,r3                                   
08044DF8 4308     orr     r0,r1            ;碰撞属性 orr 1                             
08044DFA 7010     strb    r0,[r2]          ;再写入                            
08044DFC 2400     mov     r4,0h                                   
08044DFE 4835     ldr     r0,=0FF3Ch                              
08044E00 8168     strh    r0,[r5,0Ah]      ;上部分界C4h                        
08044E02 4648     mov     r0,r9                                   
08044E04 81A8     strh    r0,[r5,0Ch]      ;下部分界0h                       
08044E06 4834     ldr     r0,=0FFC0h                              
08044E08 81E8     strh    r0,[r5,0Eh]      ;左部分界40h                       
08044E0A 2040     mov     r0,40h                                  
08044E0C 8228     strh    r0,[r5,10h]      ;右部分界40h                       
08044E0E 1C29     mov     r1,r5                                   
08044E10 3127     add     r1,27h                                  
08044E12 2030     mov     r0,30h           ;300075f写入30h                       
08044E14 7008     strb    r0,[r1]                                 
08044E16 1C28     mov     r0,r5                                   
08044E18 3028     add     r0,28h                                  
08044E1A 2108     mov     r1,8h            ;3000760写入8h                       
08044E1C 7001     strb    r1,[r0]                                 
08044E1E 3A09     sub     r2,9h                                   
08044E20 2078     mov     r0,78h                                  
08044E22 7010     strb    r0,[r2]          ;3000761写入78h                      
08044E24 482D     ldr     r0,=830AF90h     ;平常的OAM                       
08044E26 61A8     str     r0,[r5,18h]      ;写入OAM                       
08044E28 772C     strb    r4,[r5,1Ch]                             
08044E2A 464A     mov     r2,r9                                   
08044E2C 82EA     strh    r2,[r5,16h]                             
08044E2E 1C28     mov     r0,r5                                   
08044E30 302E     add     r0,2Eh                                  
08044E32 7001     strb    r1,[r0]          ;3000766写入8h                        
08044E34 3801     sub     r0,1h                                   
08044E36 7004     strb    r4,[r0]          ;3000765写入0h                       
08044E38 232C     mov     r3,2Ch                                  
08044E3A 195B     add     r3,r3,r5                                
08044E3C 4698     mov     r8,r3                                   
08044E3E 701C     strb    r4,[r3]          ;3000764写入0h                       
08044E40 3002     add     r0,2h                                   
08044E42 7004     strb    r4,[r0]          ;3000767写入0h                       
08044E44 4826     ldr     r0,=300070Ch                            
08044E46 73C4     strb    r4,[r0,0Fh]      ;300071b写入0h 控制飞船舱门                      
08044E48 7FEA     ldrb    r2,[r5,1Fh]      ;读取gfx row                       
08044E4A 1C2F     mov     r7,r5                                   
08044E4C 3723     add     r7,23h                                  
08044E4E 783B     ldrb    r3,[r7]          ;读取主精灵序号                       
08044E50 8868     ldrh    r0,[r5,2h]       ;读取垂直坐标写入SP                       
08044E52 9000     str     r0,[sp]                                 
08044E54 88A8     ldrh    r0,[r5,4h]       ;读取水平坐标写入SP4                       
08044E56 9001     str     r0,[sp,4h]                              
08044E58 4649     mov     r1,r9                                   
08044E5A 9102     str     r1,[sp,8h]       ;SP8写入0                       
08044E5C 2032     mov     r0,32h                                  
08044E5E 2101     mov     r1,1h                                   
08044E60 F7C9F9FA bl      SpawnSecSprite   ;生产副精灵32h                             
08044E64 7FEA     ldrb    r2,[r5,1Fh]                             
08044E66 783B     ldrb    r3,[r7]                                 
08044E68 8868     ldrh    r0,[r5,2h]                              
08044E6A 9000     str     r0,[sp]                                 
08044E6C 88A8     ldrh    r0,[r5,4h]                              
08044E6E 9001     str     r0,[sp,4h]                              
08044E70 4648     mov     r0,r9                                   
08044E72 9002     str     r0,[sp,8h]                              
08044E74 2032     mov     r0,32h                                  
08044E76 2102     mov     r1,2h                                   
08044E78 F7C9F9EE bl      SpawnSecSprite   ;生产副精灵32h                                
08044E7C 4E19     ldr     r6,=30013D4h                            
08044E7E 7830     ldrb    r0,[r6]          ;读取人物姿势                       
08044E80 282C     cmp     r0,2Ch                                  
08044E82 D131     bne     @@SaPoseNo2C                                
08044E84 1C28     mov     r0,r5                                   
08044E86 3025     add     r0,25h                                  
08044E88 7004     strb    r4,[r0]          ;属性写入0h                        
08044E8A 1C29     mov     r1,r5                                   
08044E8C 3124     add     r1,24h                                  
08044E8E 2025     mov     r0,25h                                  
08044E90 7008     strb    r0,[r1]          ;pose 写入25h                       
08044E92 201E     mov     r0,1Eh                                  
08044E94 4641     mov     r1,r8                                   
08044E96 7008     strb    r0,[r1]          ;3000764写入1eh                       
08044E98 72B4     strb    r4,[r6,0Ah]      ;30013de加速累计值归0                       
08044E9A 2101     mov     r1,1h                                   
08044E9C 2001     mov     r0,1h                                   
08044E9E 81B0     strh    r0,[r6,0Ch]      ;30013e0 写入1                      
08044EA0 20AA     mov     r0,0AAh                                 
08044EA2 0040     lsl     r0,r0,1h                                
08044EA4 80E8     strh    r0,[r5,6h]       ;300073E写入154h                       
08044EA6 4A0E     ldr     r2,=300070Ch                            
08044EA8 73D1     strb    r1,[r2,0Fh]      ;舱门关闭                       
08044EAA 7FEA     ldrb    r2,[r5,1Fh]      ;读取gfx row                       
08044EAC 783B     ldrb    r3,[r7]          ;读取主精灵序号                       
08044EAE 8868     ldrh    r0,[r5,2h]                              
08044EB0 9000     str     r0,[sp]                                 
08044EB2 88A8     ldrh    r0,[r5,4h]                              
08044EB4 9001     str     r0,[sp,4h]                              
08044EB6 4648     mov     r0,r9                                   
08044EB8 9002     str     r0,[sp,8h]                              
08044EBA 2032     mov     r0,32h                                  
08044EBC 2103     mov     r1,3h                                   
08044EBE F7C9F9CB bl      SpawnSecSprite                                
08044EC2 E060     b       @@end                                

@@SaPoseNo2C:                              
08044EE8 4651     mov     r1,r10                                  
08044EEA 2900     cmp     r1,0h       ;若为1则最后经过的门是0                             
08044EEC D026     beq     @@LastDoorNoZero                                
08044EEE 1C28     mov     r0,r5                                   
08044EF0 3025     add     r0,25h                                  
08044EF2 7004     strb    r4,[r0]     ;属性写入0                            
08044EF4 1C29     mov     r1,r5                                   
08044EF6 3124     add     r1,24h                                  
08044EF8 2055     mov     r0,55h                                  
08044EFA 7008     strb    r0,[r1]     ;pose 写入 55h                            
08044EFC 2340     mov     r3,40h                                  
08044EFE 425B     neg     r3,r3                                   
08044F00 4642     mov     r2,r8                                   
08044F02 7013     strb    r3,[r2]     ;3000764写入C0                            
08044F04 202C     mov     r0,2Ch                                  
08044F06 F7C2FAEF bl      80074E8h    ;改变pose?                            
08044F0A 2001     mov     r0,1h                                   
08044F0C 72B0     strb    r0,[r6,0Ah] ;加速累计值写入1????                            
08044F0E 2401     mov     r4,1h                                   
08044F10 81B0     strh    r0,[r6,0Ch] ;最后在空中接触的墙写入1???                            
08044F12 7FEA     ldrb    r2,[r5,1Fh]                             
08044F14 783B     ldrb    r3,[r7]                                 
08044F16 8868     ldrh    r0,[r5,2h]                              
08044F18 9000     str     r0,[sp]                                 
08044F1A 88A8     ldrh    r0,[r5,4h]                              
08044F1C 9001     str     r0,[sp,4h]                              
08044F1E 4648     mov     r0,r9                                   
08044F20 9002     str     r0,[sp,8h]                              
08044F22 2032     mov     r0,32h                                  
08044F24 2105     mov     r1,5h                                   
08044F26 F7C9F997 bl      SpawnSecSprite  ;合上的舱盖?                               
08044F2A 2000     mov     r0,0h                                   
08044F2C F7BEFF98 bl      8003E60h    ;音乐去掉持续的标记                          
08044F30 4801     ldr     r0,=300004Ah                            
08044F32 7004     strb    r4,[r0]     ;隐藏小小地图                             
08044F34 E027     b       @@end                                 

@@LastDoorNoZero:                             
08044F3C 7FEA     ldrb    r2,[r5,1Fh]                             
08044F3E 783B     ldrb    r3,[r7]                                 
08044F40 8868     ldrh    r0,[r5,2h]                              
08044F42 38A0     sub     r0,0A0h         ;Y坐标向上A0的高度                        
08044F44 9000     str     r0,[sp]                                 
08044F46 88A8     ldrh    r0,[r5,4h]                              
08044F48 9001     str     r0,[sp,4h]                              
08044F4A 4651     mov     r1,r10                                  
08044F4C 9102     str     r1,[sp,8h]                              
08044F4E 2032     mov     r0,32h                                  
08044F50 2103     mov     r1,3h                                   
08044F52 F7C9F981 bl      SpawnSecSprite                               
08044F56 4652     mov     r2,r10                                  
08044F58 80EA     strh    r2,[r5,6h]     ;300073E写入0                         
08044F5A 1C29     mov     r1,r5                                   
08044F5C 3125     add     r1,25h                                  
08044F5E 2002     mov     r0,2h                                   
08044F60 7008     strb    r0,[r1]        ;属性写入2h 顶部固体无伤害                         
08044F62 2003     mov     r0,3h                                   
08044F64 2127     mov     r1,27h         ;事件 母脑自爆                         
08044F66 F01BFCA9 bl      CheckEvent                                
08044F6A 2800     cmp     r0,0h                                   
08044F6C D003     beq     @@MBSave                                
08044F6E 1C29     mov     r1,r5         ;母脑死则Pose 写入Fh                          
08044F70 3124     add     r1,24h                                  
08044F72 200F     mov     r0,0Fh                                  
08044F74 E002     b       @@Peer2 

@@MBSave:                               
08044F76 1C29     mov     r1,r5                                   
08044F78 3124     add     r1,24h        ;pose 写入9h                          
08044F7A 2009     mov     r0,9h  

@@Peer2:                                 
08044F7C 7008     strb    r0,[r1]                                 
08044F7E 4806     ldr     r0,=3000738h                            
08044F80 3022     add     r0,22h                                  
08044F82 210C     mov     r1,0Ch                                  
08044F84 7001     strb    r1,[r0]       ;300075a写入0Ch

@@end:                                
08044F86 B003     add     sp,0Ch                                  
08044F88 BC38     pop     r3-r5                                   
08044F8A 4698     mov     r8,r3                                   
08044F8C 46A1     mov     r9,r4                                   
08044F8E 46AA     mov     r10,r5                                  
08044F90 BCF0     pop     r4-r7                                   
08044F92 BC01     pop     r0                                      
08044F94 4700     bx      r0  

                                    
;pose 55h                             
08044F9C B510     push    r4,r14                                  
08044F9E 4C0F     ldr     r4,=3000738h                            
08044FA0 1C20     mov     r0,r4       ;读取3000764h  pose 0时写入c0                         
08044FA2 302C     add     r0,2Ch                                  
08044FA4 7802     ldrb    r2,[r0]                                 
08044FA6 2A00     cmp     r2,0h                                   
08044FA8 D014     beq     @@end                                
08044FAA 3A01     sub     r2,1h       ;减1再写入                            
08044FAC 7002     strb    r2,[r0]                                 
08044FAE 8860     ldrh    r0,[r4,2h]  ;读取Y坐标                            
08044FB0 1C81     add     r1,r0,2     ;下移2h                            
08044FB2 8061     strh    r1,[r4,2h]  ;再写入                            
08044FB4 490A     ldr     r1,=30013D4h                            
08044FB6 3802     sub     r0,2h                                   
08044FB8 8288     strh    r0,[r1,14h] ;人物坐标也                            
08044FBA 88A0     ldrh    r0,[r4,4h]  ;读取精灵水平坐标                            
08044FBC 8248     strh    r0,[r1,12h] ;人物水平坐标也写入相同的                            
08044FBE 0612     lsl     r2,r2,18h                               
08044FC0 0E12     lsr     r2,r2,18h                               
08044FC2 2A1E     cmp     r2,1Eh                                  
08044FC4 D106     bne     @@end                                
08044FC6 2007     mov     r0,7h                                   
08044FC8 F017F804 bl      805BFD4h    ;播放开始的字幕                             
08044FCC 8820     ldrh    r0,[r4]                                 
08044FCE 2120     mov     r1,20h      ;取向orr 20                            
08044FD0 4308     orr     r0,r1                                   
08044FD2 8020     strh    r0,[r4]     ;再写入

@@end:                                
08044FD4 BC10     pop     r4                                      
08044FD6 BC01     pop     r0                                      
08044FD8 4700     bx      r0                                      

;pose 9   正常情况下的飞船                          
08044FE4 B510     push    r4,r14                                  
08044FE6 4C0A     ldr     r4,=3000738h                            
08044FE8 8821     ldrh    r1,[r4]                                 
08044FEA 2080     mov     r0,80h                                  
08044FEC 0140     lsl     r0,r0,5h                                
08044FEE 4008     and     r0,r1     ;1000h and 取向                              
08044FF0 2800     cmp     r0,0h     ;如果是0的话                              
08044FF2 D00F     beq     @@No1000                                
08044FF4 1C21     mov     r1,r4      ;意味踩踏                             
08044FF6 3122     add     r1,22h                                  
08044FF8 2004     mov     r0,4h                                   
08044FFA 7008     strb    r0,[r1]     ;300075a写入4h                            
08044FFC F7FFFEAC bl      8044D58h    ;检查姿势和距离                            
08045000 0600     lsl     r0,r0,18h                               
08045002 2800     cmp     r0,0h                                   
08045004 D00A     beq     @@end                                
08045006 1C21     mov     r1,r4                                   
08045008 3124     add     r1,24h                                  
0804500A 2022     mov     r0,22h      ;pose写入22h                            
0804500C E005     b       @@Peer                                

@@No1000:                             
08045014 1C21     mov     r1,r4                                     
08045016 3122     add     r1,22h      ;300075a写入0Ch                            
08045018 200C     mov     r0,0Ch      ;正常情况下都是直接跳到No1000h

@@Peer:                                
0804501A 7008     strb    r0,[r1]

@@end:                                 
0804501C BC10     pop     r4                                      
0804501E BC01     pop     r0                                      
08045020 4700     bx      r0                                                                     
 
;pose 22h 在pose9 被舱盖到,并写入姿势1f??? 
08045024 B570     push    r4-r6,r14                               
08045026 4922     ldr     r1,=3000738h                            
08045028 1C0B     mov     r3,r1                                   
0804502A 332C     add     r3,2Ch                                  
0804502C 7818     ldrb    r0,[r3]                ;读取3000764h                              
0804502E 1E42     sub     r2,r0,1                ;pose 9时写入了38h                 
08045030 701A     strb    r2,[r3]                ;减1再写入                 
08045032 0610     lsl     r0,r2,18h                               
08045034 0E04     lsr     r4,r0,18h                               
08045036 2C00     cmp     r4,0h                                   
08045038 D144     bne     @@TimeNoZero                                
0804503A 3124     add     r1,24h                                  
0804503C 2023     mov     r0,23h                 ;时间为0的时候                 
0804503E 7008     strb    r0,[r1]                ;pose写入23h                  
08045040 2041     mov     r0,41h                                  
08045042 7018     strb    r0,[r3]                ;3000764再次写入41h                 
08045044 2032     mov     r0,32h                                  
08045046 2101     mov     r1,1h                                   
08045048 F7CBFC02 bl      CheckEvenSecSprite                                
0804504C 0600     lsl     r0,r0,18h                               
0804504E 0E01     lsr     r1,r0,18h                               
08045050 29FF     cmp     r1,0FFh                                 
08045052 D049     beq     @@end                                
08045054 4D17     ldr     r5,=30001ACh                            
08045056 00C8     lsl     r0,r1,3h                                
08045058 1A40     sub     r0,r0,r1                                
0804505A 00C0     lsl     r0,r0,3h                                
0804505C 1C2E     mov     r6,r5                                   
0804505E 3618     add     r6,18h                                  
08045060 1982     add     r2,r0,r6              ;副精灵的OAM                  
08045062 4915     ldr     r1,=830B070h                            
08045064 6011     str     r1,[r2]                                 
08045066 1940     add     r0,r0,r5                                
08045068 7704     strb    r4,[r0,1Ch]                             
0804506A 82C4     strh    r4,[r0,16h]                             
0804506C 3024     add     r0,24h                                  
0804506E 2109     mov     r1,9h                 ;有副精灵32-1                  
08045070 7001     strb    r1,[r0]               ;Pose继续9h                  
08045072 2032     mov     r0,32h                                  
08045074 2102     mov     r1,2h                 ;检查副精灵32-2                  
08045076 F7CBFBEB bl      CheckEvenSecSprite                                
0804507A 0600     lsl     r0,r0,18h                               
0804507C 0E01     lsr     r1,r0,18h                               
0804507E 29FF     cmp     r1,0FFh                                 
08045080 D032     beq     @@end                                
08045082 00C8     lsl     r0,r1,3h                                
08045084 1A40     sub     r0,r0,r1                                
08045086 00C0     lsl     r0,r0,3h                                
08045088 1982     add     r2,r0,r6                                
0804508A 490C     ldr     r1,=830B130h         ;写入新OAM                   
0804508C 6011     str     r1,[r2]                                 
0804508E 1940     add     r0,r0,r5                                
08045090 2100     mov     r1,0h                                   
08045092 7701     strb    r1,[r0,1Ch]                             
08045094 82C4     strh    r4,[r0,16h]                             
08045096 3024     add     r0,24h               ;有副精灵32-2                   
08045098 210F     mov     r1,0Fh               ;Pose写入Fh                     
0804509A 7001     strb    r1,[r0]                                 
0804509C 4808     ldr     r0,=119h             ;关舱盖声音??                    
0804509E F7BDFCBB bl      PlaySound                                
080450A2 208D     mov     r0,8Dh                                  
080450A4 0040     lsl     r0,r0,1h                                
080450A6 210A     mov     r1,0Ah               ;类似电梯的声音                   
080450A8 F7BDFDEA bl      8002C80h                                
080450AC E01C     b       @@end                                

@@TimeNoZero:                               
080450C4 0610     lsl     r0,r2,18h                               
080450C6 0E00     lsr     r0,r0,18h                               
080450C8 282B     cmp     r0,2Bh               ;比较3000764                   
080450CA D807     bhi     @@Check2C            ;大于2B                   
080450CC 4902     ldr     r1,=30013D4h                            
080450CE 8A88     ldrh    r0,[r1,14h]          ;12帧的下落时间??                  
080450D0 3004     add     r0,4h                ;SA Y坐标下4h                   
080450D2 8288     strh    r0,[r1,14h]                             
080450D4 E008     b       @@end                                

@@Check2C:                               
080450DC 282C     cmp     r0,2Ch                                  
080450DE D103     bne     @@end                                
080450E0 208D     mov     r0,8Dh               ;2C时播放进入飞船声音                   
080450E2 0040     lsl     r0,r0,1h                                
080450E4 F7BDFC98 bl      PlaySound 

@@end:                               
080450E8 BC70     pop     r4-r6                                   
080450EA BC01     pop     r0                                      
080450EC 4700     bx      r0                                      

;pose 23h              加血补道具并显示补满字幕                
080450F0 B530     push    r4,r5,r14                               
080450F2 B082     add     sp,-8h                                  
080450F4 4C0B     ldr     r4,=3000738h                            
080450F6 1C25     mov     r5,r4                                   
080450F8 352C     add     r5,2Ch                                  
080450FA 7829     ldrb    r1,[r5]          ;pose 22写入了41h                          
080450FC 1C0A     mov     r2,r1                                   
080450FE 2A06     cmp     r2,6h                                   
08045100 D916     bls     @@TimeLessThan7                                
08045102 1E48     sub     r0,r1,1          ;大于6经历                     
08045104 2100     mov     r1,0h                                   
08045106 7028     strb    r0,[r5]          ;减1再写入                       
08045108 0600     lsl     r0,r0,18h                               
0804510A 0E00     lsr     r0,r0,18h                               
0804510C 2806     cmp     r0,6h            ;因为减1再检查,所以等于7                       
0804510E D000     beq     @@TimeEqual6                                
08045110 E095     b       @@end    

@@TimeEqual6:                            
08045112 4805     ldr     r0,=830AFC8h                            
08045114 61A0     str     r0,[r4,18h]                             
08045116 7721     strb    r1,[r4,1Ch]                             
08045118 82E1     strh    r1,[r4,16h]                             
0804511A 4804     ldr     r0,=21Eh         ;补充能量和道具声音                        
0804511C F7BDFC7C bl      PlaySound                                
08045120 E08D     b       @@end 

@@TimeLessThan7:                               
08045130 2A05     cmp     r2,5h                                   
08045132 D10B     bne     @@TimeNoEqual5                                
08045134 F7CBF892 bl      801025Ch         ;回满血例程                        
08045138 2800     cmp     r0,0h            ;回满血返回0                       
0804513A D000     beq     @@Pass                                
0804513C E07F     b       @@end  

@@Pass:                              
0804513E 7828     ldrb    r0,[r5]         ;回满血3000764减1                        
08045140 3801     sub     r0,1h                                   
08045142 7028     strb    r0,[r5]         ;再写入                        
08045144 4900     ldr     r1,=3000996h                            
08045146 E04D     b       @@Const                                

@@TimeNoEqual5:                              
0804514C 2A04     cmp     r2,4h                                   
0804514E D117     bne     @@TimeNoEqual4                                
08045150 4908     ldr     r1,=3000996h                            
08045152 7808     ldrb    r0,[r1]                                 
08045154 2800     cmp     r0,0h                                   
08045156 D133     bne     @@Goto                                
08045158 F7CBF8A2 bl      80102A0h       ;回导弹的例程                         
0804515C 2800     cmp     r0,0h                                   
0804515E D16E     bne     @@end                                
08045160 7828     ldrb    r0,[r5]                                 
08045162 3801     sub     r0,1h          ;回满或没导弹3000764减1                         
08045164 7028     strb    r0,[r5]                                 
08045166 4804     ldr     r0,=3001530h                            
08045168 8840     ldrh    r0,[r0,2h]                              
0804516A 2800     cmp     r0,0h          ;检查如果最大导弹为0,则结束                         
0804516C D067     beq     @@end                                
0804516E 4903     ldr     r1,=3000997h                            
08045170 E038     b       @@Const                                

@@TimeNoEqual4:                              
08045180 2A03     cmp     r2,3h                                   
08045182 D117     bne     @@TimeNoEqual3                                
08045184 4908     ldr     r1,=3000997h                            
08045186 7808     ldrb    r0,[r1]                                 
08045188 2800     cmp     r0,0h                                   
0804518A D119     bne     @@TimeNoEqual3                               
0804518C F7CBF8AA bl      80102E4h                                
08045190 2800     cmp     r0,0h                                   
08045192 D154     bne     @@end                                
08045194 7828     ldrb    r0,[r5]                                 
08045196 3801     sub     r0,1h                                   
08045198 7028     strb    r0,[r5]                                 
0804519A 4804     ldr     r0,=3001530h                            
0804519C 7900     ldrb    r0,[r0,4h]                              
0804519E 2800     cmp     r0,0h                                   
080451A0 D04D     beq     @@end                                
080451A2 4903     ldr     r1,=3000998h                            
080451A4 E01E     b       @@Const                                

@@TimeNoEqual3:                              
080451B4 2A02     cmp     r2,2h                                   
080451B6 D11D     bne     @@TimeNoEqual2                                
080451B8 4903     ldr     r1,=3000998h                            
080451BA 7808     ldrb    r0,[r1]                                 
080451BC 2800     cmp     r0,0h                                   
080451BE D005     beq     @@ADDPB 

@@Goto:                               
080451C0 3801     sub     r0,1h                                   
080451C2 7008     strb    r0,[r1]                                 
080451C4 E03B     b       @@end                                

@@ADDPB:                               
080451CC F7CBF8AC bl      8010328h                                
080451D0 2800     cmp     r0,0h                                   
080451D2 D134     bne     @@end                                
080451D4 7828     ldrb    r0,[r5]                                 
080451D6 3801     sub     r0,1h                                   
080451D8 7028     strb    r0,[r5]                                 
080451DA 4804     ldr     r0,=3001530h                            
080451DC 7940     ldrb    r0,[r0,5h]                              
080451DE 2800     cmp     r0,0h                                   
080451E0 D02D     beq     @@end                                
080451E2 4903     ldr     r1,=3000999h 

@@Const:                           
080451E4 200D     mov     r0,0Dh                                  
080451E6 7008     strb    r0,[r1]                                 
080451E8 E029     b       @@end                                

@@TimeNoEqual2:                               
080451F4 4B03     ldr     r3,=3000999h                            
080451F6 7818     ldrb    r0,[r3]                                 
080451F8 2800     cmp     r0,0h                                   
080451FA D005     beq     @@Pass3                                
080451FC 3801     sub     r0,1h                                   
080451FE 7018     strb    r0,[r3]                                 
08045200 E01D     b       @@end                                 

@@Pass3:                            
08045208 2A00     cmp     r2,0h                                   
0804520A D002     beq     @@Pass2                                
0804520C 1E48     sub     r0,r1,1                                 
0804520E 7028     strb    r0,[r5]                                 
08045210 E015     b       @@end      

@@Pass2:                          
08045212 1C21     mov     r1,r4                                   
08045214 3124     add     r1,24h                                  
08045216 2024     mov     r0,24h       ;pose写入24h                              
08045218 7008     strb    r0,[r1]                                 
0804521A 201E     mov     r0,1Eh                                  
0804521C 7028     strb    r0,[r5]      ;3000764写入1eh                            
0804521E 8863     ldrh    r3,[r4,2h]                              
08045220 88A0     ldrh    r0,[r4,4h]                              
08045222 9000     str     r0,[sp]                                 
08045224 9201     str     r2,[sp,4h]                              
08045226 2011     mov     r0,11h       ;精灵ID                           
08045228 211A     mov     r1,1Ah       ;序号                           
0804522A 2206     mov     r2,6h        ;gfx row                                
0804522C F7C9F876 bl      800E31Ch     ;产生字幕 主精灵制造                           
08045230 1C21     mov     r1,r4                                   
08045232 312A     add     r1,2Ah                                  
08045234 7008     strb    r0,[r1]      ;3000762写入精灵槽序号                          
08045236 4804     ldr     r0,=21Eh     ;播放加血声音??                           
08045238 210F     mov     r1,0Fh                                  
0804523A F7BDFD21 bl      8002C80h 

@@end:                               
0804523E B002     add     sp,8h                                   
08045240 BC30     pop     r4,r5                                   
08045242 BC01     pop     r0                                      
08045244 4700     bx      r0  

                                    
;pose 24h                  ;显出已经补满字幕和存档字幕 
0804524C B510     push    r4,r14                                  
0804524E B082     add     sp,-8h                                  
08045250 4812     ldr     r0,=3000738h                            
08045252 4684     mov     r12,r0                                  
08045254 4664     mov     r4,r12                                  
08045256 342A     add     r4,2Ah       ;得到字幕精灵槽序号                             
08045258 7821     ldrb    r1,[r4]                                 
0804525A 4A11     ldr     r2,=30001ACh                            
0804525C 00C8     lsl     r0,r1,3h                                
0804525E 1A40     sub     r0,r0,r1                                
08045260 00C0     lsl     r0,r0,3h                                
08045262 1881     add     r1,r0,r2                                
08045264 1C08     mov     r0,r1                                   
08045266 3024     add     r0,24h                                  
08045268 7803     ldrb    r3,[r0]                                 
0804526A 2B25     cmp     r3,25h       ;如果字幕pose不是25h 显示为23 按掉为24-25                          
0804526C D131     bne     @@end        ;结束,25估计是已经按掉的字幕pose                          
0804526E 4662     mov     r2,r12                                  
08045270 322C     add     r2,2Ch                                  
08045272 7810     ldrb    r0,[r2]                                 
08045274 2800     cmp     r0,0h        ;读取3000764的值为0跳转                           
08045276 D015     beq     @@TimeZero                                
08045278 3801     sub     r0,1h                                   
0804527A 7010     strb    r0,[r2]      ;3000764的值减1                           
0804527C 0600     lsl     r0,r0,18h                               
0804527E 0E01     lsr     r1,r0,18h                               
08045280 2900     cmp     r1,0h                                   
08045282 D126     bne     @@end        ;时间为大于1的时候                         
08045284 4662     mov     r2,r12       ;时间等于1的时候                          
08045286 8853     ldrh    r3,[r2,2h]                              
08045288 8890     ldrh    r0,[r2,4h]                              
0804528A 9000     str     r0,[sp]                                 
0804528C 9101     str     r1,[sp,4h]                              
0804528E 2011     mov     r0,11h                                  
08045290 2116     mov     r1,16h                                  
08045292 2206     mov     r2,6h                                   
08045294 F7C9F842 bl      800E31Ch     ;显示存档与否的字幕                           
08045298 7020     strb    r0,[r4]      ;精灵槽序号写入3000762                           
0804529A E01A     b       @@end                                

@@TimeZero:                               
080452A4 1C08     mov     r0,r1        ;字幕pose 25的时候检查                           
080452A6 302D     add     r0,2Dh       ;读取再生产值  为1则选了是?                          
080452A8 7800     ldrb    r0,[r0]                                 
080452AA 2801     cmp     r0,1h                                   
080452AC D10C     bne     @@ReSpawnTimesNo1                                
080452AE 4661     mov     r1,r12                                  
080452B0 3124     add     r1,24h                                  
080452B2 2042     mov     r0,42h       ;pose写入42h                           
080452B4 7008     strb    r0,[r1]      ;再写入                           
080452B6 201E     mov     r0,1Eh                                  
080452B8 7010     strb    r0,[r2]      ;3000764写入1Eh                           
080452BA 4802     ldr     r0,=21Fh     ;记录的声音                           
080452BC F7BDFBAC bl      PlaySound                                
080452C0 E007     b       @@end                                

@@ReSpawnTimesNo1:                                
080452C8 4660     mov     r0,r12                                  
080452CA 3024     add     r0,24h                                  
080452CC 7003     strb    r3,[r0]      ;pose写入25h                             
080452CE 201E     mov     r0,1Eh                                  
080452D0 7010     strb    r0,[r2]      ;时间写入1Eh

@@end:                                 
080452D2 B002     add     sp,8h                                   
080452D4 BC10     pop     r4                                      
080452D6 BC01     pop     r0                                      
080452D8 4700     bx      r0                                      

;pose 42h
080452DC B510     push    r4,r14                                  
080452DE B082     add     sp,-8h                                  
080452E0 4C0E     ldr     r4,=3000738h                            
080452E2 1C21     mov     r1,r4                                   
080452E4 312C     add     r1,2Ch       ;读取3000764的值 pose24写入1eh                           
080452E6 7808     ldrb    r0,[r1]                                 
080452E8 3801     sub     r0,1h        ;减1再写入                           
080452EA 7008     strb    r0,[r1]                                 
080452EC 0600     lsl     r0,r0,18h                               
080452EE 0E02     lsr     r2,r0,18h                               
080452F0 2A00     cmp     r2,0h                                   
080452F2 D10E     bne     @@end                                
080452F4 3908     sub     r1,8h                                   
080452F6 2043     mov     r0,43h                                  
080452F8 7008     strb    r0,[r1]      ;pose写入43h                           
080452FA 8863     ldrh    r3,[r4,2h]                              
080452FC 88A0     ldrh    r0,[r4,4h]                              
080452FE 9000     str     r0,[sp]                                 
08045300 9201     str     r2,[sp,4h]                              
08045302 2011     mov     r0,11h                                  
08045304 2117     mov     r1,17h                                  
08045306 2206     mov     r2,6h                                   
08045308 F7C9F808 bl      800E31Ch     ;显示存档结束的字幕                            
0804530C 1C21     mov     r1,r4                                   
0804530E 312A     add     r1,2Ah                                  
08045310 7008     strb    r0,[r1]      ;3000762写入精灵槽序号

@@end:                                
08045312 B002     add     sp,8h                                   
08045314 BC10     pop     r4                                      
08045316 BC01     pop     r0                                      
08045318 4700     bx      r0                                      


;pose 43h                              
08045320 B500     push    r14                                     
08045322 4B0B     ldr     r3,=3000738h                            
08045324 1C18     mov     r0,r3                                   
08045326 302A     add     r0,2Ah                                  
08045328 7800     ldrb    r0,[r0]       ;读取字幕精灵序号                          
0804532A 4A0A     ldr     r2,=30001ACh                            
0804532C 00C1     lsl     r1,r0,3h                                
0804532E 1A09     sub     r1,r1,r0                                
08045330 00C9     lsl     r1,r1,3h                                
08045332 1889     add     r1,r1,r2                                
08045334 3124     add     r1,24h                                  
08045336 7809     ldrb    r1,[r1]       ;读取字幕的pose                            
08045338 2925     cmp     r1,25h                                  
0804533A D106     bne     @@end                                
0804533C 1C18     mov     r0,r3                                   
0804533E 3024     add     r0,24h        ;记录字幕按掉                          
08045340 7001     strb    r1,[r0]       ;pose 写入25                          
08045342 1C19     mov     r1,r3                                   
08045344 312C     add     r1,2Ch                                  
08045346 201E     mov     r0,1Eh        ;3000764写入1eh                          
08045348 7008     strb    r0,[r1] 

@@end:                                
0804534A BC01     pop     r0                                      
0804534C 4700     bx      r0                                      

;pose 25h                              
08045358 B5F0     push    r4-r7,r14                               
0804535A 4647     mov     r7,r8                                   
0804535C B480     push    r7                                      
0804535E 4D0A     ldr     r5,=3000738h                            
08045360 1C2A     mov     r2,r5                                   
08045362 322C     add     r2,2Ch      ;在pose 24 写入1eh                            
08045364 7810     ldrb    r0,[r2]     ;时间减1再写入                            
08045366 1E41     sub     r1,r0,1                                 
08045368 2600     mov     r6,0h                                   
0804536A 7011     strb    r1,[r2]                                 
0804536C 0608     lsl     r0,r1,18h                               
0804536E 2800     cmp     r0,0h                                   
08045370 D10C     bne     @@TimeNoZero                               
08045372 1C29     mov     r1,r5                                   
08045374 3124     add     r1,24h                                  
08045376 2027     mov     r0,27h        ;时间为零写入pose 27h                          
08045378 7008     strb    r0,[r1]                                 
0804537A 202C     mov     r0,2Ch                                  
0804537C 7010     strb    r0,[r2]       ;时间写入2Ch                          
0804537E 30EE     add     r0,0EEh                                 
08045380 F7BDFB4A bl      PlaySound     ;282 出仓声                           
08045384 E036     b       @@end                                

@@TimeNoZero:                               
0804538C 0608     lsl     r0,r1,18h                               
0804538E 0E00     lsr     r0,r0,18h                               
08045390 280A     cmp     r0,0Ah                                    
08045392 D12F     bne     @@end                                
08045394 2032     mov     r0,32h       ;时间为A的时候                           
08045396 2101     mov     r1,1h                                   
08045398 F7CBFA5A bl      8010850h     ;检查副精灵32-1                           
0804539C 0600     lsl     r0,r0,18h                               
0804539E 0E01     lsr     r1,r0,18h                               
080453A0 29FF     cmp     r1,0FFh                                 
080453A2 D027     beq     @@end                                
080453A4 4C16     ldr     r4,=30001ACh                            
080453A6 00C8     lsl     r0,r1,3h                                
080453A8 1A40     sub     r0,r0,r1                                
080453AA 00C0     lsl     r0,r0,3h                                
080453AC 1C27     mov     r7,r4                                   
080453AE 3718     add     r7,18h                                  
080453B0 19C2     add     r2,r0,r7                                
080453B2 4914     ldr     r1,=830B010h  ;副精灵写入OAM                          
080453B4 6011     str     r1,[r2]                                 
080453B6 1900     add     r0,r0,r4                                
080453B8 7706     strb    r6,[r0,1Ch]                             
080453BA 2100     mov     r1,0h                                   
080453BC 4688     mov     r8,r1                                   
080453BE 82C6     strh    r6,[r0,16h]                             
080453C0 2032     mov     r0,32h                                  
080453C2 2102     mov     r1,2h                                   
080453C4 F7CBFA44 bl      8010850h      ;检查副精灵32-2                           
080453C8 0600     lsl     r0,r0,18h                               
080453CA 0E01     lsr     r1,r0,18h                               
080453CC 29FF     cmp     r1,0FFh                                 
080453CE D011     beq     @@end                                
080453D0 00C8     lsl     r0,r1,3h                                
080453D2 1A40     sub     r0,r0,r1                                
080453D4 00C0     lsl     r0,r0,3h                                
080453D6 19C2     add     r2,r0,r7                                
080453D8 490B     ldr     r1,=830B0B0h                            
080453DA 6011     str     r1,[r2]       ;写入新OAM                          
080453DC 1900     add     r0,r0,r4                                
080453DE 4641     mov     r1,r8                                   
080453E0 7701     strb    r1,[r0,1Ch]                             
080453E2 82C6     strh    r6,[r0,16h]                             
080453E4 4809     ldr     r0,=830AF90h  ;写入飞船OAM                           
080453E6 61A8     str     r0,[r5,18h]                             
080453E8 7729     strb    r1,[r5,1Ch]                             
080453EA 82EE     strh    r6,[r5,16h]                             
080453EC 208C     mov     r0,8Ch        ;刹步声???                         
080453EE 0040     lsl     r0,r0,1h      ;开舱门声                         
080453F0 F7BDFB12 bl      PlaySound 

@@end:                               
080453F4 BC08     pop     r3                                      
080453F6 4698     mov     r8,r3                                   
080453F8 BCF0     pop     r4-r7                                   
080453FA BC01     pop     r0                                      
080453FC 4700     bx      r0                                      

;pose 27h                              
08045410 B500     push    r14                                     
08045412 490A     ldr     r1,=3000738h                            
08045414 1C0A     mov     r2,r1                                   
08045416 322C     add     r2,2Ch                                  
08045418 7810     ldrb    r0,[r2]                                 
0804541A 3801     sub     r0,1h       ;时间减1再写入                           
0804541C 7010     strb    r0,[r2]                                 
0804541E 0600     lsl     r0,r0,18h                               
08045420 2800     cmp     r0,0h                                   
08045422 D118     bne     @@TimeNoZero                                
08045424 4806     ldr     r0,=300004Ah                            
08045426 7800     ldrb    r0,[r0]                                 
08045428 2800     cmp     r0,0h                                   
0804542A D00B     beq     @@NoHideMap                                
0804542C 1C08     mov     r0,r1                                   
0804542E 3024     add     r0,24h                                  
08045430 2159     mov     r1,59h                                  
08045432 7001     strb    r1,[r0]      ;pose写入59h                           
08045434 2032     mov     r0,32h                                  
08045436 7010     strb    r0,[r2]      ;时间写入32h                           
08045438 E007     b       @@Peer                                

@@NoHideMap:                              
08045444 3124     add     r1,24h       ;Pose写入28h                            
08045446 2028     mov     r0,28h                                  
08045448 7008     strb    r0,[r1] 

@@Peer:                                
0804544A 208D     mov     r0,8Dh       ;出仓声                              
0804544C 0040     lsl     r0,r0,1h                                
0804544E 210A     mov     r1,0Ah                                  
08045450 F7BDFC16 bl      8002C80h                                
08045454 E003     b       @@end   

@@TimeNoZero:                             
08045456 4903     ldr     r1,=30013D4h                            
08045458 8A88     ldrh    r0,[r1,14h]   ;SA Y坐标上4h                         
0804545A 3804     sub     r0,4h                                   
0804545C 8288     strh    r0,[r1,14h]  

@@end:                           
0804545E BC01     pop     r0                                      
08045460 4700     bx      r0 

                                     
;pose 28h                            完全出仓   
08045468 B510     push    r4,r14                                  
0804546A 4C07     ldr     r4,=3000738h                            
0804546C 88E0     ldrh    r0,[r4,6h]                              
0804546E 2800     cmp     r0,0h                                   
08045470 D106     bne     @@end      ;检查重产Y坐标值不为0h  09???                      
08045472 201E     mov     r0,1Eh                                  
08045474 F7C2F838 bl      80074E8h   ;改变pose><<                             
08045478 1C21     mov     r1,r4                                   
0804547A 3124     add     r1,24h                                  
0804547C 2029     mov     r0,29h                                  
0804547E 7008     strb    r0,[r1]    ;pose写入29h

@@end:                                
08045480 BC10     pop     r4                                      
08045482 BC01     pop     r0                                      
08045484 4700     bx      r0                                      

;pose 29h                              
0804548C B500     push    r14                                     
0804548E 4807     ldr     r0,=30013D4h                            
08045490 7800     ldrb    r0,[r0]                                 
08045492 281E     cmp     r0,1Eh                                  
08045494 D007     beq     @@end         ;检查SA pose是1e则结束                          
08045496 4906     ldr     r1,=3000738h                            
08045498 1C0A     mov     r2,r1                                   
0804549A 3224     add     r2,24h                                  
0804549C 202A     mov     r0,2Ah                                  
0804549E 7010     strb    r0,[r2]       ;如果不是1E则pose写入2Ah 也就是行动了                         
080454A0 3125     add     r1,25h                                  
080454A2 2002     mov     r0,2h         ;属性写入顶部固体,无伤害                          
080454A4 7008     strb    r0,[r1] 

@@end:                                
080454A6 BC01     pop     r0                                      
080454A8 4700     bx      r0 

                                     
;pose 2ah                               ;出仓并且改变了姿势          
080454B4 B500     push    r14                                     
080454B6 4A08     ldr     r2,=3000738h                            
080454B8 8811     ldrh    r1,[r2]                                 
080454BA 2080     mov     r0,80h                                  
080454BC 0140     lsl     r0,r0,5h      ;1000 and 取向                          
080454BE 4008     and     r0,r1                                   
080454C0 2800     cmp     r0,0h                                   
080454C2 D106     bne     @@end         ;一旦脚离开了舱盖,则pose写入9                       
080454C4 1C11     mov     r1,r2                                   
080454C6 3122     add     r1,22h                                  
080454C8 200C     mov     r0,0Ch        ;300075a写入0Ch                             
080454CA 7008     strb    r0,[r1]                                 
080454CC 3102     add     r1,2h                                   
080454CE 2009     mov     r0,9h         ;pose写入9h                          
080454D0 7008     strb    r0,[r1] 

@@end:                                
080454D2 BC01     pop     r0                                      
080454D4 4700     bx      r0                                      

;pose fh                    ;母脑死亡              
080454DC B510     push    r4,r14                                  
080454DE 4C12     ldr     r4,=3000738h                            
080454E0 8821     ldrh    r1,[r4]                                 
080454E2 2080     mov     r0,80h                                  
080454E4 0140     lsl     r0,r0,5h                                
080454E6 4008     and     r0,r1       ;1000 and 取向 确认是否在飞船上                             
080454E8 2800     cmp     r0,0h                                   
080454EA D01A     beq     @@end       ;否则结束                         
080454EC F7FFFC34 bl      8044D58h    ;检测在舱盖的姿势                            
080454F0 0600     lsl     r0,r0,18h                               
080454F2 2800     cmp     r0,0h                                   
080454F4 D015     beq     @@end                                
080454F6 1C21     mov     r1,r4                                   
080454F8 3122     add     r1,22h                                  
080454FA 2004     mov     r0,4h                                   
080454FC 7008     strb    r0,[r1]     ;300075a写入4h                            
080454FE 3102     add     r1,2h                                   
08045500 2011     mov     r0,11h                                  
08045502 7008     strb    r0,[r1]     ;pose写入11h                            
08045504 2001     mov     r0,1h                                   
08045506 2141     mov     r1,41h                                  
08045508 F01BF9D8 bl      80608BCh    ;激活逃进飞船事件                            
0804550C 2041     mov     r0,41h                                  
0804550E F027FC39 bl      806CD84h    ;去除小地图飞船标记                            
08045512 2090     mov     r0,90h                                  
08045514 0040     lsl     r0,r0,1h                                
08045516 213C     mov     r1,3Ch                                  
08045518 F7BDFBB2 bl      8002C80h    ;播放哔哔,逃亡声音                            
0804551C 2000     mov     r0,0h                                   
0804551E F7BEFC9F bl      8003E60h    ;去除音乐持续逃亡音标记

@@end:                               
08045522 BC10     pop     r4                                      
08045524 BC01     pop     r0                                      
08045526 4700     bx      r0                                      

;pose 11  继pose f后飞船飞走例程                             
0804552C B570     push    r4-r6,r14                               
0804552E 4928     ldr     r1,=3000738h                            
08045530 1C0B     mov     r3,r1                                   
08045532 332C     add     r3,2Ch     ;3000764                             
08045534 7818     ldrb    r0,[r3]    ;读取之前写入的计数 37                              
08045536 1E42     sub     r2,r0,1                                 
08045538 701A     strb    r2,[r3]    ;减1再写入                             
0804553A 0610     lsl     r0,r2,18h                               
0804553C 0E04     lsr     r4,r0,18h                               
0804553E 2C00     cmp     r4,0h                                   
08045540 D150     bne     @@TimeN01:                                
08045542 3124     add     r1,24h                                  
08045544 2013     mov     r0,13h                                  
08045546 7008     strb    r0,[r1]    ;pose写入13h                             
08045548 2078     mov     r0,78h                                  
0804554A 7018     strb    r0,[r3]    ;3000764写入78h                              
0804554C 2032     mov     r0,32h                                  
0804554E 2101     mov     r1,1h                                   
08045550 F7CBF97E bl      8010850h   ;检查32-1副精灵是否存在                             
08045554 0600     lsl     r0,r0,18h                               
08045556 0E01     lsr     r1,r0,18h                               
08045558 29FF     cmp     r1,0FFh                                 
0804555A D055     beq     @@end      ;不存在                          
0804555C 4D1D     ldr     r5,=30001ACh                            
0804555E 00C8     lsl     r0,r1,3h                                
08045560 1A40     sub     r0,r0,r1                                
08045562 00C0     lsl     r0,r0,3h   ;56倍                              
08045564 1C2E     mov     r6,r5                                   
08045566 3618     add     r6,18h                                  
08045568 1982     add     r2,r0,r6   ;OAM地址                             
0804556A 491B     ldr     r1,=830B070h                            
0804556C 6011     str     r1,[r2]    ;写入OAM                             
0804556E 1940     add     r0,r0,r5                                
08045570 7704     strb    r4,[r0,1Ch] ;归0                            
08045572 82C4     strh    r4,[r0,16h]                             
08045574 3024     add     r0,24h                                  
08045576 2109     mov     r1,9h       ;副精灵pose写入9                            
08045578 7001     strb    r1,[r0]                                 
0804557A 2032     mov     r0,32h                                  
0804557C 2102     mov     r1,2h                                   
0804557E F7CBF967 bl      8010850h    ;检查精灵32-2的槽                           
08045582 0600     lsl     r0,r0,18h                               
08045584 0E01     lsr     r1,r0,18h                               
08045586 29FF     cmp     r1,0FFh                                 
08045588 D03E     beq     @@end                                
0804558A 00C8     lsl     r0,r1,3h                                
0804558C 1A40     sub     r0,r0,r1                                
0804558E 00C0     lsl     r0,r0,3h                                
08045590 1982     add     r2,r0,r6                                
08045592 4912     ldr     r1,=830B130h                            
08045594 6011     str     r1,[r2]    ;写入OAM                             
08045596 1940     add     r0,r0,r5                                
08045598 2100     mov     r1,0h                                   
0804559A 7701     strb    r1,[r0,1Ch]                             
0804559C 82C4     strh    r4,[r0,16h] ;归0                            
0804559E 3024     add     r0,24h                                  
080455A0 210F     mov     r1,0Fh                                  
080455A2 7001     strb    r1,[r0]     ;pose写入F                            
080455A4 2032     mov     r0,32h                                  
080455A6 2103     mov     r1,3h                                   
080455A8 F7CBF952 bl      8010850h    ;检查32-3的精灵槽                            
080455AC 0600     lsl     r0,r0,18h                               
080455AE 0E01     lsr     r1,r0,18h                               
080455B0 29FF     cmp     r1,0FFh                                 
080455B2 D029     beq     @@end                                
080455B4 00C8     lsl     r0,r1,3h                                
080455B6 1A40     sub     r0,r0,r1                                
080455B8 00C0     lsl     r0,r0,3h                                
080455BA 1940     add     r0,r0,r5                                
080455BC 8004     strh    r4,[r0]     ;消除精灵                            
080455BE 4808     ldr     r0,=119h                                
080455C0 F7BDFA2A bl      PlaySound                                
080455C4 208D     mov     r0,8Dh                                  
080455C6 0040     lsl     r0,r0,1h                                
080455C8 210A     mov     r1,0Ah                                  
080455CA F7BDFB59 bl      8002C80h   ;播放进入飞船声音                            
080455CE E01B     b       @@end                                


@@TimeN01:                               
080455E4 0610     lsl     r0,r2,18h                               
080455E6 0E00     lsr     r0,r0,18h                               
080455E8 282B     cmp     r0,2Bh                                  
080455EA D807     bhi     @@MoreThan2b                               
080455EC 4902     ldr     r1,=30013D4h                            
080455EE 8A88     ldrh    r0,[r1,14h]   ;人物Y坐标向下移动                          
080455F0 3004     add     r0,4h                                   
080455F2 8288     strh    r0,[r1,14h]                             
080455F4 E008     b       @@end                                

@@MoreThan2b:                              
080455FC 282C     cmp     r0,2Ch                                  
080455FE D103     bne     @@end                                
08045600 208D     mov     r0,8Dh       ;进入飞船舱声音                            
08045602 0040     lsl     r0,r0,1h                                
08045604 F7BDFA08 bl      PlaySound 

@@end:                               
08045608 BC70     pop     r4-r6                                   
0804560A BC01     pop     r0                                      
0804560C 4700     bx      r0                                      

;pose 13h                          ;起飞合盖阶段     
08045610 B510     push    r4,r14                                  
08045612 B083     add     sp,-0Ch                                 
08045614 4811     ldr     r0,=3000738h                            
08045616 4684     mov     r12,r0                                  
08045618 4662     mov     r2,r12                                  
0804561A 322C     add     r2,2Ch                                  
0804561C 7810     ldrb    r0,[r2]     ;读取3000764h的值 写入了78h                             
0804561E 1E41     sub     r1,r0,1                                 
08045620 2400     mov     r4,0h                                   
08045622 7011     strb    r1,[r2]     ;减1再写入                            
08045624 0608     lsl     r0,r1,18h                               
08045626 2800     cmp     r0,0h                                   
08045628 D11A     bne     @@TimeN01                                
0804562A 4661     mov     r1,r12                                  
0804562C 3124     add     r1,24h                                  
0804562E 2015     mov     r0,15h                                  
08045630 7008     strb    r0,[r1]     ;pose写入15h                            
08045632 2098     mov     r0,98h                                  
08045634 7010     strb    r0,[r2]     ;3000764写入98h                            
08045636 4660     mov     r0,r12                                  
08045638 302F     add     r0,2Fh                                  
0804563A 7004     strb    r4,[r0]     ;3000767归0                           
0804563C 4661     mov     r1,r12                                  
0804563E 824C     strh    r4,[r1,12h] ;血量归0                            
08045640 7FCA     ldrb    r2,[r1,1Fh] ;读取GFX ROW                            
08045642 380C     sub     r0,0Ch                                  
08045644 7803     ldrb    r3,[r0]     ;读取主精灵序号                            
08045646 8848     ldrh    r0,[r1,2h]  ;读取Y坐标                            
08045648 9000     str     r0,[sp]                                 
0804564A 8888     ldrh    r0,[r1,4h]  ;读取X坐标                            
0804564C 9001     str     r0,[sp,4h]                              
0804564E 9402     str     r4,[sp,8h]                              
08045650 2032     mov     r0,32h                                  
08045652 2104     mov     r1,4h                                   
08045654 F7C8FE00 bl      800E258h    ;生产32-4                             
08045658 E00F     b       @@end                                

@@TimeN01:                               
08045660 0608     lsl     r0,r1,18h                               
08045662 0E00     lsr     r0,r0,18h                               
08045664 2804     cmp     r0,4h                                   
08045666 D108     bne     @@end                                
08045668 4806     ldr     r0,=830B1A0h                            
0804566A 4661     mov     r1,r12                                  
0804566C 6188     str     r0,[r1,18h]  ;写入OAM                           
0804566E 770C     strb    r4,[r1,1Ch]                             
08045670 82CC     strh    r4,[r1,16h]                             
08045672 208D     mov     r0,8Dh                                  
08045674 0080     lsl     r0,r0,2h                                
08045676 F7BDF9CF bl      PlaySound    ;播放起飞声音

@@end:                                
0804567A B003     add     sp,0Ch                                  
0804567C BC10     pop     r4                                      
0804567E BC01     pop     r0                                      
08045680 4700     bx      r0  

;Pose 15和17调用
08044C24 B510     push    r4,r14                                  
08044C26 4A0E     ldr     r2,=3000738h                            
08044C28 8811     ldrh    r1,[r2]                                 
08044C2A 2020     mov     r0,20h                                  
08044C2C 4008     and     r0,r1      ;20 and 取向                             
08044C2E 0400     lsl     r0,r0,10h                               
08044C30 0C04     lsr     r4,r0,10h                               
08044C32 2C00     cmp     r4,0h                                   
08044C34 D12D     bne     @@end                                
08044C36 1C10     mov     r0,r2                                   
08044C38 302E     add     r0,2Eh                                  
08044C3A 7800     ldrb    r0,[r0]                                 
08044C3C 2804     cmp     r0,4h      ;3000766的值                              
08044C3E D128     bne     @@end                                
08044C40 8A53     ldrh    r3,[r2,12h]                             
08044C42 7C91     ldrb    r1,[r2,12h]                             
08044C44 2080     mov     r0,80h                                  
08044C46 4008     and     r0,r1      ;80 and 血量                             
08044C48 2800     cmp     r0,0h                                   
08044C4A D00B     beq     @@Pass                               
08044C4C 2980     cmp     r1,80h                                  
08044C4E D901     bls     @@Pass2                                
08044C50 1E58     sub     r0,r3,1                                 
08044C52 8250     strh    r0,[r2,12h] ;血量-1再写入

@@Pass2                            
08044C54 8A50     ldrh    r0,[r2,12h]                             
08044C56 2880     cmp     r0,80h                                  
08044C58 D10E     bne     @@Peer                                
08044C5A 8254     strh    r4,[r2,12h]  ;血量是80则写入0h                           
08044C5C E00C     b       @@Peer                                
 

@@Pass:                             
08044C64 2901     cmp     r1,1h                                   
08044C66 D801     bhi     @@MoreThan1                                
08044C68 1C58     add     r0,r3,1                                 
08044C6A 8250     strh    r0,[r2,12h] ;血量加1再写入

@@MoreThan1:                             
08044C6C 8A51     ldrh    r1,[r2,12h]                             
08044C6E 2902     cmp     r1,2h                                   
08044C70 D102     bne     @@Peer                                
08044C72 2080     mov     r0,80h      ;血量为2则orr 80                            
08044C74 4308     orr     r0,r1       ;再写入                            
08044C76 8250     strh    r0,[r2,12h] 

@@Peer:                            
08044C78 7C91     ldrb    r1,[r2,12h]                             
08044C7A 207F     mov     r0,7Fh                                  
08044C7C 4008     and     r0,r1        ;血量和7F and                           
08044C7E 4A06     ldr     r2,=40000D4h                            
08044C80 0140     lsl     r0,r0,5h     ;乘以32倍                           
08044C82 4906     ldr     r1,=830A63Ch                            
08044C84 1840     add     r0,r0,r1     ;加上830a63ch                           
08044C86 6010     str     r0,[r2]      ;写入40000d4                           
08044C88 4805     ldr     r0,=5000340h                            
08044C8A 6050     str     r0,[r2,4h]   ;写入40000d8                           
08044C8C 4805     ldr     r0,=80000010h                           
08044C8E 6090     str     r0,[r2,8h]   ;写入40000dc                           
08044C90 6890     ldr     r0,[r2,8h] 

@@end:                             
08044C92 BC10     pop     r4                                      
08044C94 BC01     pop     r0                                      
08044C96 4700     bx      r0

;OtherPose调用                      
08044CA8 B500     push    r14                                     
08044CAA 4A0A     ldr     r2,=3000738h                            
08044CAC 8811     ldrh    r1,[r2]                                 
08044CAE 2020     mov     r0,20h       ;读取取向                            
08044CB0 4008     and     r0,r1        ;20 and                           
08044CB2 1C13     mov     r3,r2                                   
08044CB4 2800     cmp     r0,0h        ;如果之前orr 20 比如经历pose 55                         
08044CB6 D144     bne     @@end                                
08044CB8 322E     add     r2,2Eh                                  
08044CBA 7810     ldrb    r0,[r2]      ;3000766减1再写入                           
08044CBC 3801     sub     r0,1h                                   
08044CBE 7010     strb    r0,[r2]                                 
08044CC0 0600     lsl     r0,r0,18h                               
08044CC2 2800     cmp     r0,0h                                   
08044CC4 D13D     bne     @@end        ;不为0则结束                       
08044CC6 6999     ldr     r1,[r3,18h]                             
08044CC8 4803     ldr     r0,=830AFC8h ;读取OAM                           
08044CCA 4281     cmp     r1,r0        ;比较OAM                           
08044CCC D106     bne     @@OAMNoSame                                
08044CCE 2002     mov     r0,2h        ;3000766写入2                           
08044CD0 E00D     b       @@Peer                                

@@OAMNoSame:                              
08044CDC 4802     ldr     r0,=830B1A0h                            
08044CDE 4281     cmp     r1,r0        ;比较OAM                           
08044CE0 D104     bne     @@OAMNoSame2                                
08044CE2 2004     mov     r0,4h                                   
08044CE4 E003     b       @@Peer                                

@@OAMNoSame2:                               
08044CEC 2008     mov     r0,8h        ;3000766写入8h

@@Peer:                                  
08044CEE 7010     strb    r0,[r2]                                 
08044CF0 1C1A     mov     r2,r3                                   
08044CF2 322D     add     r2,2Dh                                  
08044CF4 7811     ldrb    r1,[r2]      ;读取3000765的值                            
08044CF6 2080     mov     r0,80h                                  
08044CF8 4008     and     r0,r1        ;80 and                           
08044CFA 2800     cmp     r0,0h                                   
08044CFC D008     beq     @@Equal80                                
08044CFE 2980     cmp     r1,80h                                  
08044D00 D901     bls     @@LessThan81h                                
08044D02 1E48     sub     r0,r1,1                                 
08044D04 7010     strb    r0,[r2]      ;减1再写入

@@LessThan81h:                                
08044D06 7810     ldrb    r0,[r2]      ;读取3000765的值                           
08044D08 2880     cmp     r0,80h                                  
08044D0A D10B     bne     8044D24h                                
08044D0C 2000     mov     r0,0h                                   
08044D0E E008     b       8044D22h

@@Equal80:                                
08044D10 2903     cmp     r1,3h                                   
08044D12 D801     bhi     8044D18h                                
08044D14 1C48     add     r0,r1,1                                 
08044D16 7010     strb    r0,[r2]                                 
08044D18 7811     ldrb    r1,[r2]                                 
08044D1A 2904     cmp     r1,4h                                   
08044D1C D102     bne     8044D24h                                
08044D1E 2080     mov     r0,80h                                  
08044D20 4308     orr     r0,r1                                   
08044D22 7010     strb    r0,[r2]                                 
08044D24 1C18     mov     r0,r3                                   
08044D26 302D     add     r0,2Dh                                  
08044D28 7801     ldrb    r1,[r0]                                 
08044D2A 207F     mov     r0,7Fh                                  
08044D2C 4008     and     r0,r1                                   
08044D2E 4A06     ldr     r2,=40000D4h                            
08044D30 0140     lsl     r0,r0,5h                                
08044D32 4906     ldr     r1,=830A6ACh                            
08044D34 1840     add     r0,r0,r1                                
08044D36 6010     str     r0,[r2]                                 
08044D38 4805     ldr     r0,=5000330h                            
08044D3A 6050     str     r0,[r2,4h]                              
08044D3C 4805     ldr     r0,=80000008h                           
08044D3E 6090     str     r0,[r2,8h]                              
08044D40 6890     ldr     r0,[r2,8h] 

@@end:                             
08044D42 BC01     pop     r0                                      
08044D44 4700     bx      r0                 

;pose 15h                     ;起飞并浮空阶段           
08045688 B530     push    r4,r5,r14                               
0804568A F7FFFACB bl      8044C24h                                
0804568E 4A0A     ldr     r2,=3000738h                            
08045690 1C14     mov     r4,r2                                   
08045692 342C     add     r4,2Ch                                  
08045694 7820     ldrb    r0,[r4]     ;读取3000764h  之前写入98h                              
08045696 3801     sub     r0,1h       ;减1在写入                            
08045698 7020     strb    r0,[r4]                                 
0804569A 0600     lsl     r0,r0,18h                               
0804569C 0E03     lsr     r3,r0,18h                               
0804569E 2B00     cmp     r3,0h                                   
080456A0 D10C     bne     @@TimeN01                                
080456A2 1C11     mov     r1,r2                                   
080456A4 3124     add     r1,24h      ;pose 写入17h                              
080456A6 2017     mov     r0,17h                                  
080456A8 7008     strb    r0,[r1]                                 
080456AA 20A0     mov     r0,0A0h                                 
080456AC 7020     strb    r0,[r4]     ;3000764写入A0                            
080456AE 1C10     mov     r0,r2                                   
080456B0 302F     add     r0,2Fh                                  
080456B2 7003     strb    r3,[r0]     ;3000767写入0h                              
080456B4 E022     b       @@end                                

@@TimeNo1:                               
080456BC 202F     mov     r0,2Fh                                  
080456BE 1880     add     r0,r0,r2                                
080456C0 4684     mov     r12,r0                                  
080456C2 7801     ldrb    r1,[r0]     ;读取3000767的值                             
080456C4 4C06     ldr     r4,=8309470h                            
080456C6 0048     lsl     r0,r1,1h    ;乘以2                             
080456C8 1900     add     r0,r0,r4    ;加上8039470h                             
080456CA 2500     mov     r5,0h                                   
080456CC 5F43     ldsh    r3,[r0,r5]  ;读取地址的值的负数                           
080456CE 4805     ldr     r0,=7FFFh                               
080456D0 4283     cmp     r3,r0       ;比较是否是7fff                            
080456D2 D109     bne     @@No7FFF                                
080456D4 1E48     sub     r0,r1,1     ;原值-1                            
080456D6 0040     lsl     r0,r0,1h    ;再乘2加                            
080456D8 1900     add     r0,r0,r4                                
080456DA 2100     mov     r1,0h                                   
080456DC 5E43     ldsh    r3,[r0,r1]  ;读取地址的值的负数                            
080456DE E006     b       @@Peer                                

@@No7FFF:                               
080456E8 1C48     add     r0,r1,1                                 
080456EA 4665     mov     r5,r12      ;值+1                            
080456EC 7028     strb    r0,[r5]     ;写入3000767

@@Peer:                                 
080456EE 8850     ldrh    r0,[r2,2h]                              
080456F0 18C0     add     r0,r0,r3    ;读取Y坐标+数字                            
080456F2 8050     strh    r0,[r2,2h]  ;再写入                            
080456F4 4903     ldr     r1,=30013D4h                            
080456F6 8A88     ldrh    r0,[r1,14h]                             
080456F8 18C0     add     r0,r0,r3    ;人物的Y坐标同样也移动                            
080456FA 8288     strh    r0,[r1,14h] 

@@end:                            
080456FC BC30     pop     r4,r5                                   
080456FE BC01     pop     r0                                      
08045700 4700     bx      r0                                      

;pose 17h                             ;飞船上升突破顶峰 
08045708 B530     push    r4,r5,r14                               
0804570A 4C07     ldr     r4,=3000738h                            
0804570C 1C20     mov     r0,r4                                   
0804570E 302C     add     r0,2Ch                                  
08045710 7801     ldrb    r1,[r0]     ;读取3000764的值,之前写入A0h                            
08045712 3901     sub     r1,1h       ;减1再写入                            
08045714 7001     strb    r1,[r0]                                 
08045716 0608     lsl     r0,r1,18h                               
08045718 2800     cmp     r0,0h                                   
0804571A D107     bne     @@TimeNo1                                
0804571C 1C21     mov     r1,r4                                   
0804571E 3124     add     r1,24h                                  
08045720 2019     mov     r0,19h      ;pose写入19结束                             
08045722 7008     strb    r0,[r1]                                 
08045724 E030     b       @@end                                

@@TimeNo1:                               
0804572C 0608     lsl     r0,r1,18h                               
0804572E 0E00     lsr     r0,r0,18h                               
08045730 2832     cmp     r0,32h                                  
08045732 D106     bne     @@TimeNoless32                                
08045734 2003     mov     r0,3h                                   
08045736 F016FC4D bl      805BFD4h                                
0804573A 8821     ldrh    r1,[r4]                                 
0804573C 2020     mov     r0,20h                                  
0804573E 4308     orr     r0,r1     ;取向orr 20再写入                              
08045740 8020     strh    r0,[r4]

@@TimeNoless32:                                 
08045742 F7FFFA6F bl      8044C24h                                
08045746 202F     mov     r0,2Fh                                  
08045748 1900     add     r0,r0,r4                                
0804574A 4684     mov     r12,r0                                  
0804574C 7801     ldrb    r1,[r0]      ;读取3000767的值                           
0804574E 4B07     ldr     r3,=83095A2h                            
08045750 0048     lsl     r0,r1,1h     ;乘以2                           
08045752 18C0     add     r0,r0,r3     ;加上偏移值                           
08045754 2500     mov     r5,0h                                   
08045756 5F42     ldsh    r2,[r0,r5]   ;读取负数                           
08045758 4805     ldr     r0,=7FFFh                               
0804575A 4282     cmp     r2,r0                                   
0804575C D10A     bne     @@No7FFF                                
0804575E 1E48     sub     r0,r1,1      ;减1                           
08045760 0040     lsl     r0,r0,1h     ;乘以2                           
08045762 18C0     add     r0,r0,r3     ;加偏移值                           
08045764 2100     mov     r1,0h                                   
08045766 5E42     ldsh    r2,[r0,r1]   ;读取负数                           
08045768 E007     b       @@UpSpeed                                

@@No7FFF:                               
08045774 1C48     add     r0,r1,1      ;加1                           
08045776 4665     mov     r5,r12                                  
08045778 7028     strb    r0,[r5]      ;再写入

@@UpSpeed:                                
0804577A 8860     ldrh    r0,[r4,2h]   ;得到Y坐标                            
0804577C 1880     add     r0,r0,r2     ;加上速度值再写入                           
0804577E 8060     strh    r0,[r4,2h]                              
08045780 4903     ldr     r1,=30013D4h                            
08045782 8A88     ldrh    r0,[r1,14h]                             
08045784 1880     add     r0,r0,r2                                
08045786 8288     strh    r0,[r1,14h]

@@end:                             
08045788 BC30     pop     r4,r5                                   
0804578A BC01     pop     r0
                                      

                               
08045794 B510     push    r4,r14                                  
08045796 4B12     ldr     r3,=3000738h                            
08045798 1C1A     mov     r2,r3                                   
0804579A 3232     add     r2,32h                                  
0804579C 7811     ldrb    r1,[r2]                                 
0804579E 2001     mov     r0,1h                                   
080457A0 2400     mov     r4,0h                                   
080457A2 4308     orr     r0,r1                                   
080457A4 7010     strb    r0,[r2]                                 
080457A6 8818     ldrh    r0,[r3]                                 
080457A8 490E     ldr     r1,=0FFFBh                              
080457AA 4001     and     r1,r0                                   
080457AC 2000     mov     r0,0h                                   
080457AE 7718     strb    r0,[r3,1Ch]                             
080457B0 82DC     strh    r4,[r3,16h]                             
080457B2 3A0D     sub     r2,0Dh                                  
080457B4 7010     strb    r0,[r2]                                 
080457B6 2280     mov     r2,80h                                  
080457B8 0212     lsl     r2,r2,8h                                
080457BA 1C10     mov     r0,r2                                   
080457BC 4301     orr     r1,r0                                   
080457BE 8019     strh    r1,[r3]                                 
080457C0 815C     strh    r4,[r3,0Ah]                             
080457C2 819C     strh    r4,[r3,0Ch]                             
080457C4 81DC     strh    r4,[r3,0Eh]                             
080457C6 821C     strh    r4,[r3,10h]                             
080457C8 7F98     ldrb    r0,[r3,1Eh]                             
080457CA 3801     sub     r0,1h                                   
080457CC 1C1A     mov     r2,r3                                   
080457CE 2804     cmp     r0,4h                                   
080457D0 D900     bls     80457D4h                                
080457D2 E0AB     b       804592Ch                                
080457D4 0080     lsl     r0,r0,2h                                
080457D6 4904     ldr     r1,=80457ECh                            
080457D8 1840     add     r0,r0,r1                                
080457DA 6800     ldr     r0,[r0]                                 
080457DC 4687     mov     r15,r0                                  
080457DE 0000     lsl     r0,r0,0h                                
080457E0 0738     lsl     r0,r7,1Ch                               
080457E2 0300     lsl     r0,r0,0Ch                               
080457E4 FFFB     bl      lr+0FF6h                                
080457E6 0000     lsl     r0,r0,0h                                
080457E8 57EC     ldsb    r4,[r5,r7]                              
080457EA 0804     lsr     r4,r0,20h                               
080457EC 5800     ldr     r0,[r0,r0]                              
080457EE 0804     lsr     r4,r0,20h                               
080457F0 583E     ldr     r6,[r7,r0]                              
080457F2 0804     lsr     r4,r0,20h                               
080457F4 5884     ldr     r4,[r0,r2]                              
080457F6 0804     lsr     r4,r0,20h                               
080457F8 58D2     ldr     r2,[r2,r3]                              
080457FA 0804     lsr     r4,r0,20h                               
080457FC 58FC     ldr     r4,[r7,r3]                              
080457FE 0804     lsr     r4,r0,20h                               
08045800 1C13     mov     r3,r2                                   
08045802 3327     add     r3,27h                                  
08045804 2100     mov     r1,0h                                   
08045806 2038     mov     r0,38h                                  
08045808 7018     strb    r0,[r3]                                 
0804580A 1C10     mov     r0,r2                                   
0804580C 3028     add     r0,28h                                  
0804580E 7001     strb    r1,[r0]                                 
08045810 1C11     mov     r1,r2                                   
08045812 3129     add     r1,29h                                  
08045814 2028     mov     r0,28h                                  
08045816 7008     strb    r0,[r1]                                 
08045818 4804     ldr     r0,=830B000h                            
0804581A 6190     str     r0,[r2,18h]                             
0804581C 4804     ldr     r0,=30013D4h                            
0804581E 7800     ldrb    r0,[r0]                                 
08045820 282C     cmp     r0,2Ch                                  
08045822 D107     bne     8045834h                                
08045824 3905     sub     r1,5h                                   
08045826 2009     mov     r0,9h                                   
08045828 7008     strb    r0,[r1]                                 
0804582A E080     b       804592Eh                                
0804582C B000     add     sp,0h                                   
0804582E 0830     lsr     r0,r6,20h                               
08045830 13D4     asr     r4,r2,0Fh                               
08045832 0300     lsl     r0,r0,0Ch                               
08045834 1C11     mov     r1,r2                                   
08045836 3124     add     r1,24h                                  
08045838 2008     mov     r0,8h                                   
0804583A 7008     strb    r0,[r1]                                 
0804583C E077     b       804592Eh                                
0804583E 1C13     mov     r3,r2                                   
08045840 3327     add     r3,27h                                  
08045842 2100     mov     r1,0h                                   
08045844 2040     mov     r0,40h                                  
08045846 7018     strb    r0,[r3]                                 
08045848 1C10     mov     r0,r2                                   
0804584A 3028     add     r0,28h                                  
0804584C 7001     strb    r1,[r0]                                 
0804584E 1C11     mov     r1,r2                                   
08045850 3129     add     r1,29h                                  
08045852 2020     mov     r0,20h                                  
08045854 7008     strb    r0,[r1]                                 
08045856 1C10     mov     r0,r2                                   
08045858 3022     add     r0,22h                                  
0804585A 210E     mov     r1,0Eh                                  
0804585C 7001     strb    r1,[r0]                                 
0804585E 4805     ldr     r0,=830B0A0h                            
08045860 6190     str     r0,[r2,18h]                             
08045862 4805     ldr     r0,=30013D4h                            
08045864 7800     ldrb    r0,[r0]                                 
08045866 282C     cmp     r0,2Ch                                  
08045868 D108     bne     804587Ch                                
0804586A 1C11     mov     r1,r2                                   
0804586C 3124     add     r1,24h                                  
0804586E 200F     mov     r0,0Fh                                  
08045870 7008     strb    r0,[r1]                                 
08045872 E05C     b       804592Eh                                
08045874 B0A0     add     sp,-80h                                 
08045876 0830     lsr     r0,r6,20h                               
08045878 13D4     asr     r4,r2,0Fh                               
0804587A 0300     lsl     r0,r0,0Ch                               
0804587C 1C10     mov     r0,r2                                   
0804587E 3024     add     r0,24h                                  
08045880 7001     strb    r1,[r0]                                 
08045882 E054     b       804592Eh                                
08045884 1C11     mov     r1,r2                                   
08045886 3127     add     r1,27h                                  
08045888 2000     mov     r0,0h                                   
0804588A 7008     strb    r0,[r1]                                 
0804588C 3101     add     r1,1h                                   
0804588E 2008     mov     r0,8h                                   
08045890 7008     strb    r0,[r1]                                 
08045892 3101     add     r1,1h                                   
08045894 2010     mov     r0,10h                                  
08045896 7008     strb    r0,[r1]                                 
08045898 3907     sub     r1,7h                                   
0804589A 200D     mov     r0,0Dh                                  
0804589C 7008     strb    r0,[r1]                                 
0804589E 4807     ldr     r0,=830B178h                            
080458A0 6190     str     r0,[r2,18h]                             
080458A2 4807     ldr     r0,=30013D4h                            
080458A4 7800     ldrb    r0,[r0]                                 
080458A6 282C     cmp     r0,2Ch                                  
080458A8 D10E     bne     80458C8h                                
080458AA 3102     add     r1,2h                                   
080458AC 2044     mov     r0,44h                                  
080458AE 7008     strb    r0,[r1]                                 
080458B0 4904     ldr     r1,=0FFE8h                              
080458B2 1C08     mov     r0,r1                                   
080458B4 8851     ldrh    r1,[r2,2h]                              
080458B6 1840     add     r0,r0,r1                                
080458B8 8050     strh    r0,[r2,2h]                              
080458BA E038     b       804592Eh                                
080458BC B178     ????                                            
080458BE 0830     lsr     r0,r6,20h                               
080458C0 13D4     asr     r4,r2,0Fh                               
080458C2 0300     lsl     r0,r0,0Ch                               
080458C4 FFE8     bl      lr+0FD0h                                
080458C6 0000     lsl     r0,r0,0h                                
080458C8 1C11     mov     r1,r2                                   
080458CA 3124     add     r1,24h                                  
080458CC 2042     mov     r0,42h                                  
080458CE 7008     strb    r0,[r1]                                 
080458D0 E02D     b       804592Eh                                
080458D2 1C11     mov     r1,r2                                   
080458D4 3127     add     r1,27h                                  
080458D6 2018     mov     r0,18h                                  
080458D8 7008     strb    r0,[r1]                                 
080458DA 3101     add     r1,1h                                   
080458DC 2030     mov     r0,30h                                  
080458DE 7008     strb    r0,[r1]                                 
080458E0 3101     add     r1,1h                                   
080458E2 2060     mov     r0,60h                                  
080458E4 7008     strb    r0,[r1]                                 
080458E6 3907     sub     r1,7h                                   
080458E8 200F     mov     r0,0Fh                                  
080458EA 7008     strb    r0,[r1]                                 
080458EC 4802     ldr     r0,=830B1D8h                            
080458EE 6190     str     r0,[r2,18h]                             
080458F0 3102     add     r1,2h                                   
080458F2 2032     mov     r0,32h                                  
080458F4 7008     strb    r0,[r1]                                 
080458F6 E01A     b       804592Eh                                
080458F8 B1D8     ????                                            
080458FA 0830     lsr     r0,r6,20h                               
080458FC 1C11     mov     r1,r2                                   
080458FE 3127     add     r1,27h                                  
08045900 2018     mov     r0,18h                                  
08045902 7008     strb    r0,[r1]                                 
08045904 3101     add     r1,1h                                   
08045906 2030     mov     r0,30h                                  
08045908 7008     strb    r0,[r1]                                 
0804590A 3101     add     r1,1h                                   
0804590C 2060     mov     r0,60h                                  
0804590E 7008     strb    r0,[r1]                                 
08045910 3907     sub     r1,7h                                   
08045912 200F     mov     r0,0Fh                                  
08045914 7008     strb    r0,[r1]                                 
08045916 4804     ldr     r0,=830B1F8h                            
08045918 6190     str     r0,[r2,18h]                             
0804591A 3102     add     r1,2h                                   
0804591C 2034     mov     r0,34h                                  
0804591E 7008     strb    r0,[r1]                                 
08045920 3108     add     r1,8h                                   
08045922 2050     mov     r0,50h                                  
08045924 7008     strb    r0,[r1]                                 
08045926 E002     b       804592Eh                                
08045928 B1F8     ????                                            
0804592A 0830     lsr     r0,r6,20h                               
0804592C 801C     strh    r4,[r3]                                 
0804592E BC10     pop     r4                                      
08045930 BC01     pop     r0                                      
08045932 4700     bx      r0                                      
08045934 B500     push    r14                                     
08045936 4B0C     ldr     r3,=3000738h                            
08045938 1C18     mov     r0,r3                                   
0804593A 3023     add     r0,23h                                  
0804593C 7801     ldrb    r1,[r0]                                 
0804593E 4A0B     ldr     r2,=30001ACh                            
08045940 00C8     lsl     r0,r1,3h                                
08045942 1A40     sub     r0,r0,r1                                
08045944 00C0     lsl     r0,r0,3h                                
08045946 1880     add     r0,r0,r2                                
08045948 3024     add     r0,24h                                  
0804594A 7800     ldrb    r0,[r0]                                 
0804594C 2817     cmp     r0,17h                                  
0804594E D108     bne     8045962h                                
08045950 4807     ldr     r0,=830B1F8h                            
08045952 6198     str     r0,[r3,18h]                             
08045954 2000     mov     r0,0h                                   
08045956 7718     strb    r0,[r3,1Ch]                             
08045958 82D8     strh    r0,[r3,16h]                             
0804595A 1C19     mov     r1,r3                                   
0804595C 3124     add     r1,24h                                  
0804595E 2033     mov     r0,33h                                  
08045960 7008     strb    r0,[r1]                                 
08045962 BC01     pop     r0                                      
08045964 4700     bx      r0                                      
08045966 0000     lsl     r0,r0,0h                                
08045968 0738     lsl     r0,r7,1Ch                               
0804596A 0300     lsl     r0,r0,0Ch                               
0804596C 01AC     lsl     r4,r5,6h                                
0804596E 0300     lsl     r0,r0,0Ch                               
08045970 B1F8     ????                                            
08045972 0830     lsr     r0,r6,20h                               
08045974 B500     push    r14                                     
08045976 490B     ldr     r1,=3000738h                            
08045978 1C0B     mov     r3,r1                                   
0804597A 332C     add     r3,2Ch                                  
0804597C 7818     ldrb    r0,[r3]                                 
0804597E 2800     cmp     r0,0h                                   
08045980 D00E     beq     80459A0h                                
08045982 3801     sub     r0,1h                                   
08045984 7018     strb    r0,[r3]                                 
08045986 0600     lsl     r0,r0,18h                               
08045988 0E02     lsr     r2,r0,18h                               
0804598A 2A00     cmp     r2,0h                                   
0804598C D108     bne     80459A0h                                
0804598E 4806     ldr     r0,=830B1D8h                            
08045990 6188     str     r0,[r1,18h]                             
08045992 770A     strb    r2,[r1,1Ch]                             
08045994 82CA     strh    r2,[r1,16h]                             
08045996 200F     mov     r0,0Fh                                  
08045998 7018     strb    r0,[r3]                                 
0804599A 3124     add     r1,24h                                  
0804599C 2035     mov     r0,35h                                  
0804599E 7008     strb    r0,[r1]                                 
080459A0 BC01     pop     r0                                      
080459A2 4700     bx      r0                                      
080459A4 0738     lsl     r0,r7,1Ch                               
080459A6 0300     lsl     r0,r0,0Ch                               
080459A8 B1D8     ????                                            
080459AA 0830     lsr     r0,r6,20h                               
080459AC B500     push    r14                                     
080459AE 490B     ldr     r1,=3000738h                            
080459B0 1C0B     mov     r3,r1                                   
080459B2 332C     add     r3,2Ch                                  
080459B4 7818     ldrb    r0,[r3]                                 
080459B6 2800     cmp     r0,0h                                   
080459B8 D00E     beq     80459D8h                                
080459BA 3801     sub     r0,1h                                   
080459BC 7018     strb    r0,[r3]                                 
080459BE 0600     lsl     r0,r0,18h                               
080459C0 0E02     lsr     r2,r0,18h                               
080459C2 2A00     cmp     r2,0h                                   
080459C4 D108     bne     80459D8h                                
080459C6 4806     ldr     r0,=830B1F8h                            
080459C8 6188     str     r0,[r1,18h]                             
080459CA 770A     strb    r2,[r1,1Ch]                             
080459CC 82CA     strh    r2,[r1,16h]                             
080459CE 200A     mov     r0,0Ah                                  
080459D0 7018     strb    r0,[r3]                                 
080459D2 3124     add     r1,24h                                  
080459D4 2036     mov     r0,36h                                  
080459D6 7008     strb    r0,[r1]                                 
080459D8 BC01     pop     r0                                      
080459DA 4700     bx      r0                                      
080459DC 0738     lsl     r0,r7,1Ch                               
080459DE 0300     lsl     r0,r0,0Ch                               
080459E0 B1F8     ????                                            
080459E2 0830     lsr     r0,r6,20h                               
080459E4 B510     push    r4,r14                                  
080459E6 4813     ldr     r0,=3000738h                            
080459E8 1C01     mov     r1,r0                                   
080459EA 3123     add     r1,23h                                  
080459EC 780C     ldrb    r4,[r1]                                 
080459EE 1C03     mov     r3,r0                                   
080459F0 332C     add     r3,2Ch                                  
080459F2 7819     ldrb    r1,[r3]                                 
080459F4 1C02     mov     r2,r0                                   
080459F6 2900     cmp     r1,0h                                   
080459F8 D009     beq     8045A0Eh                                
080459FA 1E48     sub     r0,r1,1                                 
080459FC 7018     strb    r0,[r3]                                 
080459FE 0600     lsl     r0,r0,18h                               
08045A00 0E01     lsr     r1,r0,18h                               
08045A02 2900     cmp     r1,0h                                   
08045A04 D103     bne     8045A0Eh                                
08045A06 480C     ldr     r0,=830B1D8h                            
08045A08 6190     str     r0,[r2,18h]                             
08045A0A 7711     strb    r1,[r2,1Ch]                             
08045A0C 82D1     strh    r1,[r2,16h]                             
08045A0E 480B     ldr     r0,=30001ACh                            
08045A10 00E1     lsl     r1,r4,3h                                
08045A12 1B09     sub     r1,r1,r4                                
08045A14 00C9     lsl     r1,r1,3h                                
08045A16 1809     add     r1,r1,r0                                
08045A18 3124     add     r1,24h                                  
08045A1A 7808     ldrb    r0,[r1]                                 
08045A1C 2857     cmp     r0,57h                                  
08045A1E D106     bne     8045A2Eh                                
08045A20 1C11     mov     r1,r2                                   
08045A22 3124     add     r1,24h                                  
08045A24 2037     mov     r0,37h                                  
08045A26 7008     strb    r0,[r1]                                 
08045A28 3108     add     r1,8h                                   
08045A2A 203C     mov     r0,3Ch                                  
08045A2C 7008     strb    r0,[r1]                                 
08045A2E BC10     pop     r4                                      
08045A30 BC01     pop     r0                                      
08045A32 4700     bx      r0                                      
08045A34 0738     lsl     r0,r7,1Ch                               
08045A36 0300     lsl     r0,r0,0Ch                               
08045A38 B1D8     ????                                            
08045A3A 0830     lsr     r0,r6,20h                               
08045A3C 01AC     lsl     r4,r5,6h                                
08045A3E 0300     lsl     r0,r0,0Ch                               
08045A40 B500     push    r14                                     
08045A42 4A08     ldr     r2,=3000738h                            
08045A44 8810     ldrh    r0,[r2]                                 
08045A46 2104     mov     r1,4h                                   
08045A48 4048     eor     r0,r1                                   
08045A4A 8010     strh    r0,[r2]                                 
08045A4C 1C11     mov     r1,r2                                   
08045A4E 312C     add     r1,2Ch                                  
08045A50 7808     ldrb    r0,[r1]                                 
08045A52 3801     sub     r0,1h                                   
08045A54 7008     strb    r0,[r1]                                 
08045A56 0600     lsl     r0,r0,18h                               
08045A58 0E00     lsr     r0,r0,18h                               
08045A5A 2800     cmp     r0,0h                                   
08045A5C D100     bne     8045A60h                                
08045A5E 8010     strh    r0,[r2]                                 
08045A60 BC01     pop     r0                                      
08045A62 4700     bx      r0                                      
08045A64 0738     lsl     r0,r7,1Ch                               
08045A66 0300     lsl     r0,r0,0Ch                               
08045A68 B530     push    r4,r5,r14                               
08045A6A 4806     ldr     r0,=300070Ch                            
08045A6C 7BC0     ldrb    r0,[r0,0Fh]                             
08045A6E 2801     cmp     r0,1h                                   
08045A70 D122     bne     8045AB8h                                
08045A72 4C05     ldr     r4,=3000738h                            
08045A74 69A1     ldr     r1,[r4,18h]                             
08045A76 4805     ldr     r0,=830B000h                            
08045A78 4281     cmp     r1,r0                                   
08045A7A D10B     bne     8045A94h                                
08045A7C 4804     ldr     r0,=830B010h                            
08045A7E 61A0     str     r0,[r4,18h]                             
08045A80 E03E     b       8045B00h                                
08045A82 0000     lsl     r0,r0,0h                                
08045A84 070C     lsl     r4,r1,1Ch                               
08045A86 0300     lsl     r0,r0,0Ch                               
08045A88 0738     lsl     r0,r7,1Ch                               
08045A8A 0300     lsl     r0,r0,0Ch                               
08045A8C B000     add     sp,0h                                   
08045A8E 0830     lsr     r0,r6,20h                               
08045A90 B010     add     sp,40h                                  
08045A92 0830     lsr     r0,r6,20h                               
08045A94 4D04     ldr     r5,=830B010h                            
08045A96 42A9     cmp     r1,r5                                   
08045A98 D10A     bne     8045AB0h                                
08045A9A F7CAF895 bl      800FBC8h                                
08045A9E 2800     cmp     r0,0h                                   
08045AA0 D031     beq     8045B06h                                
08045AA2 4802     ldr     r0,=830B038h                            
08045AA4 61A0     str     r0,[r4,18h]                             
08045AA6 E02B     b       8045B00h                                
08045AA8 B010     add     sp,40h                                  
08045AAA 0830     lsr     r0,r6,20h                               
08045AAC B038     add     sp,0E0h                                 
08045AAE 0830     lsr     r0,r6,20h                               
08045AB0 4800     ldr     r0,=830B070h                            
08045AB2 E01E     b       8045AF2h                                
08045AB4 B070     add     sp,1C0h                                 
08045AB6 0830     lsr     r0,r6,20h                               
08045AB8 4C03     ldr     r4,=3000738h                            
08045ABA 69A1     ldr     r1,[r4,18h]                             
08045ABC 4803     ldr     r0,=830B038h                            
08045ABE 4281     cmp     r1,r0                                   
08045AC0 D108     bne     8045AD4h                                
08045AC2 4803     ldr     r0,=830B070h                            
08045AC4 61A0     str     r0,[r4,18h]                             
08045AC6 E01B     b       8045B00h                                
08045AC8 0738     lsl     r0,r7,1Ch                               
08045ACA 0300     lsl     r0,r0,0Ch                               
08045ACC B038     add     sp,0E0h                                 
08045ACE 0830     lsr     r0,r6,20h                               
08045AD0 B070     add     sp,1C0h                                 
08045AD2 0830     lsr     r0,r6,20h                               
08045AD4 4D04     ldr     r5,=830B070h                            
08045AD6 42A9     cmp     r1,r5                                   
08045AD8 D10A     bne     8045AF0h                                
08045ADA F7CAF875 bl      800FBC8h                                
08045ADE 2800     cmp     r0,0h                                   
08045AE0 D011     beq     8045B06h                                
08045AE2 4802     ldr     r0,=830B000h                            
08045AE4 61A0     str     r0,[r4,18h]                             
08045AE6 E00B     b       8045B00h                                
08045AE8 B070     add     sp,1C0h                                 
08045AEA 0830     lsr     r0,r6,20h                               
08045AEC B000     add     sp,0h                                   
08045AEE 0830     lsr     r0,r6,20h                               
08045AF0 4806     ldr     r0,=830B010h                            
08045AF2 4281     cmp     r1,r0                                   
08045AF4 D107     bne     8045B06h                                
08045AF6 F7CAF867 bl      800FBC8h                                
08045AFA 2800     cmp     r0,0h                                   
08045AFC D003     beq     8045B06h                                
08045AFE 61A5     str     r5,[r4,18h]                             
08045B00 2000     mov     r0,0h                                   
08045B02 7720     strb    r0,[r4,1Ch]                             
08045B04 82E0     strh    r0,[r4,16h]                             
08045B06 BC30     pop     r4,r5                                   
08045B08 BC01     pop     r0                                      
08045B0A 4700     bx      r0                                      
08045B0C B010     add     sp,40h                                  
08045B0E 0830     lsr     r0,r6,20h                               
08045B10 B510     push    r4,r14                                  
08045B12 4C07     ldr     r4,=3000738h                            
08045B14 69A1     ldr     r1,[r4,18h]                             
08045B16 4807     ldr     r0,=830B070h                            
08045B18 4281     cmp     r1,r0                                   
08045B1A D10F     bne     8045B3Ch                                
08045B1C F7CAF854 bl      800FBC8h                                
08045B20 2800     cmp     r0,0h                                   
08045B22 D01B     beq     8045B5Ch                                
08045B24 4804     ldr     r0,=830B000h                            
08045B26 61A0     str     r0,[r4,18h]                             
08045B28 2000     mov     r0,0h                                   
08045B2A 7720     strb    r0,[r4,1Ch]                             
08045B2C 82E0     strh    r0,[r4,16h]                             
08045B2E E015     b       8045B5Ch                                
08045B30 0738     lsl     r0,r7,1Ch                               
08045B32 0300     lsl     r0,r0,0Ch                               
08045B34 B070     add     sp,1C0h                                 
08045B36 0830     lsr     r0,r6,20h                               
08045B38 B000     add     sp,0h                                   
08045B3A 0830     lsr     r0,r6,20h                               
08045B3C 4809     ldr     r0,=830B010h                            
08045B3E 4281     cmp     r1,r0                                   
08045B40 D10C     bne     8045B5Ch                                
08045B42 F7CAF841 bl      800FBC8h                                
08045B46 2800     cmp     r0,0h                                   
08045B48 D008     beq     8045B5Ch                                
08045B4A 4807     ldr     r0,=830B038h                            
08045B4C 61A0     str     r0,[r4,18h]                             
08045B4E 2000     mov     r0,0h                                   
08045B50 7720     strb    r0,[r4,1Ch]                             
08045B52 82E0     strh    r0,[r4,16h]                             
08045B54 1C21     mov     r1,r4                                   
08045B56 3124     add     r1,24h                                  
08045B58 2008     mov     r0,8h                                   
08045B5A 7008     strb    r0,[r1]                                 
08045B5C BC10     pop     r4                                      
08045B5E BC01     pop     r0                                      
08045B60 4700     bx      r0                                      
08045B62 0000     lsl     r0,r0,0h                                
08045B64 B010     add     sp,40h                                  
08045B66 0830     lsr     r0,r6,20h                               
08045B68 B038     add     sp,0E0h                                 
08045B6A 0830     lsr     r0,r6,20h                               
08045B6C B530     push    r4,r5,r14                               
08045B6E 480A     ldr     r0,=300070Ch                            
08045B70 7BC0     ldrb    r0,[r0,0Fh]                             
08045B72 2801     cmp     r0,1h                                   
08045B74 D138     bne     8045BE8h                                
08045B76 4C09     ldr     r4,=3000738h                            
08045B78 69A1     ldr     r1,[r4,18h]                             
08045B7A 4809     ldr     r0,=830B0A0h                            
08045B7C 4281     cmp     r1,r0                                   
08045B7E D113     bne     8045BA8h                                
08045B80 4808     ldr     r0,=830B0B0h                            
08045B82 61A0     str     r0,[r4,18h]                             
08045B84 2000     mov     r0,0h                                   
08045B86 7720     strb    r0,[r4,1Ch]                             
08045B88 82E0     strh    r0,[r4,16h]                             
08045B8A 8821     ldrh    r1,[r4]                                 
08045B8C 2002     mov     r0,2h                                   
08045B8E 4008     and     r0,r1                                   
08045B90 2800     cmp     r0,0h                                   
08045B92 D05F     beq     8045C54h                                
08045B94 E021     b       8045BDAh                                
08045B96 0000     lsl     r0,r0,0h                                
08045B98 070C     lsl     r4,r1,1Ch                               
08045B9A 0300     lsl     r0,r0,0Ch                               
08045B9C 0738     lsl     r0,r7,1Ch                               
08045B9E 0300     lsl     r0,r0,0Ch                               
08045BA0 B0A0     add     sp,-80h                                 
08045BA2 0830     lsr     r0,r6,20h                               
08045BA4 B0B0     add     sp,-0C0h                                
08045BA6 0830     lsr     r0,r6,20h                               
08045BA8 4D04     ldr     r5,=830B0B0h                            
08045BAA 42A9     cmp     r1,r5                                   
08045BAC D10A     bne     8045BC4h                                
08045BAE F7CAF80B bl      800FBC8h                                
08045BB2 2800     cmp     r0,0h                                   
08045BB4 D04E     beq     8045C54h                                
08045BB6 4802     ldr     r0,=830B0F8h                            
08045BB8 E034     b       8045C24h                                
08045BBA 0000     lsl     r0,r0,0h                                
08045BBC B0B0     add     sp,-0C0h                                
08045BBE 0830     lsr     r0,r6,20h                               
08045BC0 B0F8     add     sp,-1E0h                                
08045BC2 0830     lsr     r0,r6,20h                               
08045BC4 4807     ldr     r0,=830B130h                            
08045BC6 4281     cmp     r1,r0                                   
08045BC8 D144     bne     8045C54h                                
08045BCA F7C9FFFD bl      800FBC8h                                
08045BCE 2800     cmp     r0,0h                                   
08045BD0 D040     beq     8045C54h                                
08045BD2 61A5     str     r5,[r4,18h]                             
08045BD4 2000     mov     r0,0h                                   
08045BD6 7720     strb    r0,[r4,1Ch]                             
08045BD8 82E0     strh    r0,[r4,16h]                             
08045BDA 208C     mov     r0,8Ch                                  
08045BDC 0040     lsl     r0,r0,1h                                
08045BDE F7BCFF1B bl      PlaySound                                
08045BE2 E037     b       8045C54h                                
08045BE4 B130     ????                                            
08045BE6 0830     lsr     r0,r6,20h                               
08045BE8 4C06     ldr     r4,=3000738h                            
08045BEA 69A1     ldr     r1,[r4,18h]                             
08045BEC 4806     ldr     r0,=830B0F8h                            
08045BEE 4281     cmp     r1,r0                                   
08045BF0 D110     bne     8045C14h                                
08045BF2 4806     ldr     r0,=830B130h                            
08045BF4 61A0     str     r0,[r4,18h]                             
08045BF6 2000     mov     r0,0h                                   
08045BF8 7720     strb    r0,[r4,1Ch]                             
08045BFA 82E0     strh    r0,[r4,16h]                             
08045BFC 4804     ldr     r0,=119h                                
08045BFE F7BCFF0B bl      PlaySound                                
08045C02 E027     b       8045C54h                                
08045C04 0738     lsl     r0,r7,1Ch                               
08045C06 0300     lsl     r0,r0,0Ch                               
08045C08 B0F8     add     sp,-1E0h                                
08045C0A 0830     lsr     r0,r6,20h                               
08045C0C B130     ????                                            
08045C0E 0830     lsr     r0,r6,20h                               
08045C10 0119     lsl     r1,r3,4h                                
08045C12 0000     lsl     r0,r0,0h                                
08045C14 4D06     ldr     r5,=830B130h                            
08045C16 42A9     cmp     r1,r5                                   
08045C18 D10E     bne     8045C38h                                
08045C1A F7C9FFD5 bl      800FBC8h                                
08045C1E 2800     cmp     r0,0h                                   
08045C20 D018     beq     8045C54h                                
08045C22 4804     ldr     r0,=830B0A0h                            
08045C24 61A0     str     r0,[r4,18h]                             
08045C26 2000     mov     r0,0h                                   
08045C28 7720     strb    r0,[r4,1Ch]                             
08045C2A 82E0     strh    r0,[r4,16h]                             
08045C2C E012     b       8045C54h                                
08045C2E 0000     lsl     r0,r0,0h                                
08045C30 B130     ????                                            
08045C32 0830     lsr     r0,r6,20h                               
08045C34 B0A0     add     sp,-80h                                 
08045C36 0830     lsr     r0,r6,20h                               
08045C38 4808     ldr     r0,=830B0B0h                            
08045C3A 4281     cmp     r1,r0                                   
08045C3C D10A     bne     8045C54h                                
08045C3E F7C9FFC3 bl      800FBC8h                                
08045C42 2800     cmp     r0,0h                                   
08045C44 D006     beq     8045C54h                                
08045C46 61A5     str     r5,[r4,18h]                             
08045C48 2000     mov     r0,0h                                   
08045C4A 7720     strb    r0,[r4,1Ch]                             
08045C4C 82E0     strh    r0,[r4,16h]                             
08045C4E 4804     ldr     r0,=119h                                
08045C50 F7BCFEE2 bl      PlaySound                                
08045C54 BC30     pop     r4,r5                                   
08045C56 BC01     pop     r0                                      
08045C58 4700     bx      r0                                      
08045C5A 0000     lsl     r0,r0,0h                                
08045C5C B0B0     add     sp,-0C0h                                
08045C5E 0830     lsr     r0,r6,20h                               
08045C60 0119     lsl     r1,r3,4h                                
08045C62 0000     lsl     r0,r0,0h                                
08045C64 B510     push    r4,r14                                  
08045C66 4C07     ldr     r4,=3000738h                            
08045C68 69A1     ldr     r1,[r4,18h]                             
08045C6A 4807     ldr     r0,=830B130h                            
08045C6C 4281     cmp     r1,r0                                   
08045C6E D10F     bne     8045C90h                                
08045C70 F7C9FFAA bl      800FBC8h                                
08045C74 2800     cmp     r0,0h                                   
08045C76 D01B     beq     8045CB0h                                
08045C78 4804     ldr     r0,=830B0A0h                            
08045C7A 61A0     str     r0,[r4,18h]                             
08045C7C 2000     mov     r0,0h                                   
08045C7E 7720     strb    r0,[r4,1Ch]                             
08045C80 82E0     strh    r0,[r4,16h]                             
08045C82 E015     b       8045CB0h                                
08045C84 0738     lsl     r0,r7,1Ch                               
08045C86 0300     lsl     r0,r0,0Ch                               
08045C88 B130     ????                                            
08045C8A 0830     lsr     r0,r6,20h                               
08045C8C B0A0     add     sp,-80h                                 
08045C8E 0830     lsr     r0,r6,20h                               
08045C90 4809     ldr     r0,=830B0B0h                            
08045C92 4281     cmp     r1,r0                                   
08045C94 D10C     bne     8045CB0h                                
08045C96 F7C9FF97 bl      800FBC8h                                
08045C9A 2800     cmp     r0,0h                                   
08045C9C D008     beq     8045CB0h                                
08045C9E 4807     ldr     r0,=830B0F8h                            
08045CA0 61A0     str     r0,[r4,18h]                             
08045CA2 2000     mov     r0,0h                                   
08045CA4 7720     strb    r0,[r4,1Ch]                             
08045CA6 82E0     strh    r0,[r4,16h]                             
08045CA8 1C21     mov     r1,r4                                   
08045CAA 3124     add     r1,24h                                  
08045CAC 200E     mov     r0,0Eh                                  
08045CAE 7008     strb    r0,[r1]                                 
08045CB0 BC10     pop     r4                                      
08045CB2 BC01     pop     r0                                      
08045CB4 4700     bx      r0                                      
08045CB6 0000     lsl     r0,r0,0h                                
08045CB8 B0B0     add     sp,-0C0h                                
08045CBA 0830     lsr     r0,r6,20h                               
08045CBC B0F8     add     sp,-1E0h                                
08045CBE 0830     lsr     r0,r6,20h                               
08045CC0 B500     push    r14                                     
08045CC2 2032     mov     r0,32h                                  
08045CC4 2102     mov     r1,2h                                   
08045CC6 F7CAFDC3 bl      8010850h                                
08045CCA 0600     lsl     r0,r0,18h                               
08045CCC 0E02     lsr     r2,r0,18h                               
08045CCE 2AFF     cmp     r2,0FFh                                 
08045CD0 D015     beq     8045CFEh                                
08045CD2 480C     ldr     r0,=300070Ch                            
08045CD4 7BC0     ldrb    r0,[r0,0Fh]                             
08045CD6 2801     cmp     r0,1h                                   
08045CD8 D111     bne     8045CFEh                                
08045CDA 490B     ldr     r1,=30001ACh                            
08045CDC 00D0     lsl     r0,r2,3h                                
08045CDE 1A80     sub     r0,r0,r2                                
08045CE0 00C0     lsl     r0,r0,3h                                
08045CE2 3118     add     r1,18h                                  
08045CE4 1840     add     r0,r0,r1                                
08045CE6 6801     ldr     r1,[r0]                                 
08045CE8 4808     ldr     r0,=830B0B0h                            
08045CEA 4281     cmp     r1,r0                                   
08045CEC D107     bne     8045CFEh                                
08045CEE 4908     ldr     r1,=3000738h                            
08045CF0 1C0A     mov     r2,r1                                   
08045CF2 3224     add     r2,24h                                  
08045CF4 2043     mov     r0,43h                                  
08045CF6 7010     strb    r0,[r2]                                 
08045CF8 312C     add     r1,2Ch                                  
08045CFA 2008     mov     r0,8h                                   
08045CFC 7008     strb    r0,[r1]                                 
08045CFE BC01     pop     r0                                      
08045D00 4700     bx      r0                                      
08045D02 0000     lsl     r0,r0,0h                                
08045D04 070C     lsl     r4,r1,1Ch                               
08045D06 0300     lsl     r0,r0,0Ch                               
08045D08 01AC     lsl     r4,r5,6h                                
08045D0A 0300     lsl     r0,r0,0Ch                               
08045D0C B0B0     add     sp,-0C0h                                
08045D0E 0830     lsr     r0,r6,20h                               
08045D10 0738     lsl     r0,r7,1Ch                               
08045D12 0300     lsl     r0,r0,0Ch                               
08045D14 B500     push    r14                                     
08045D16 4A06     ldr     r2,=3000738h                            
08045D18 1C10     mov     r0,r2                                   
08045D1A 3023     add     r0,23h                                  
08045D1C 7803     ldrb    r3,[r0]                                 
08045D1E 1C11     mov     r1,r2                                   
08045D20 312C     add     r1,2Ch                                  
08045D22 7808     ldrb    r0,[r1]                                 
08045D24 2800     cmp     r0,0h                                   
08045D26 D005     beq     8045D34h                                
08045D28 3801     sub     r0,1h                                   
08045D2A 7008     strb    r0,[r1]                                 
08045D2C E018     b       8045D60h                                
08045D2E 0000     lsl     r0,r0,0h                                
08045D30 0738     lsl     r0,r7,1Ch                               
08045D32 0300     lsl     r0,r0,0Ch                               
08045D34 4808     ldr     r0,=30001ACh                            
08045D36 00D9     lsl     r1,r3,3h                                
08045D38 1AC9     sub     r1,r1,r3                                
08045D3A 00C9     lsl     r1,r1,3h                                
08045D3C 1809     add     r1,r1,r0                                
08045D3E 8848     ldrh    r0,[r1,2h]                              
08045D40 1C01     mov     r1,r0                                   
08045D42 39C4     sub     r1,0C4h                                 
08045D44 8850     ldrh    r0,[r2,2h]                              
08045D46 4281     cmp     r1,r0                                   
08045D48 DD08     ble     8045D5Ch                                
08045D4A 8051     strh    r1,[r2,2h]                              
08045D4C 1C11     mov     r1,r2                                   
08045D4E 3124     add     r1,24h                                  
08045D50 2044     mov     r0,44h                                  
08045D52 7008     strb    r0,[r1]                                 
08045D54 E004     b       8045D60h                                
08045D56 0000     lsl     r0,r0,0h                                
08045D58 01AC     lsl     r4,r5,6h                                
08045D5A 0300     lsl     r0,r0,0Ch                               
08045D5C 3804     sub     r0,4h                                   
08045D5E 8050     strh    r0,[r2,2h]                              
08045D60 BC01     pop     r0                                      
08045D62 4700     bx      r0                                      
08045D64 B530     push    r4,r5,r14                               
08045D66 4808     ldr     r0,=3000738h                            
08045D68 1C01     mov     r1,r0                                   
08045D6A 3123     add     r1,23h                                  
08045D6C 780C     ldrb    r4,[r1]                                 
08045D6E 4907     ldr     r1,=300070Ch                            
08045D70 7BC9     ldrb    r1,[r1,0Fh]                             
08045D72 1C05     mov     r5,r0                                   
08045D74 2900     cmp     r1,0h                                   
08045D76 D10B     bne     8045D90h                                
08045D78 1C29     mov     r1,r5                                   
08045D7A 3124     add     r1,24h                                  
08045D7C 2045     mov     r0,45h                                  
08045D7E 7008     strb    r0,[r1]                                 
08045D80 3108     add     r1,8h                                   
08045D82 2008     mov     r0,8h                                   
08045D84 7008     strb    r0,[r1]                                 
08045D86 E035     b       8045DF4h                                
08045D88 0738     lsl     r0,r7,1Ch                               
08045D8A 0300     lsl     r0,r0,0Ch                               
08045D8C 070C     lsl     r4,r1,1Ch                               
08045D8E 0300     lsl     r0,r0,0Ch                               
08045D90 490F     ldr     r1,=30001ACh                            
08045D92 00E2     lsl     r2,r4,3h                                
08045D94 1B10     sub     r0,r2,r4                                
08045D96 00C0     lsl     r0,r0,3h                                
08045D98 1843     add     r3,r0,r1                                
08045D9A 1C18     mov     r0,r3                                   
08045D9C 3024     add     r0,24h                                  
08045D9E 7800     ldrb    r0,[r0]                                 
08045DA0 2822     cmp     r0,22h                                  
08045DA2 D104     bne     8045DAEh                                
08045DA4 1C18     mov     r0,r3                                   
08045DA6 302C     add     r0,2Ch                                  
08045DA8 7800     ldrb    r0,[r0]                                 
08045DAA 282B     cmp     r0,2Bh                                  
08045DAC D91F     bls     8045DEEh                                
08045DAE 1B10     sub     r0,r2,r4                                
08045DB0 00C0     lsl     r0,r0,3h                                
08045DB2 1843     add     r3,r0,r1                                
08045DB4 1C18     mov     r0,r3                                   
08045DB6 3024     add     r0,24h                                  
08045DB8 7800     ldrb    r0,[r0]                                 
08045DBA 2827     cmp     r0,27h                                  
08045DBC D10A     bne     8045DD4h                                
08045DBE 1C18     mov     r0,r3                                   
08045DC0 302C     add     r0,2Ch                                  
08045DC2 7800     ldrb    r0,[r0]                                 
08045DC4 282B     cmp     r0,2Bh                                  
08045DC6 D805     bhi     8045DD4h                                
08045DC8 8868     ldrh    r0,[r5,2h]                              
08045DCA 3804     sub     r0,4h                                   
08045DCC E011     b       8045DF2h                                
08045DCE 0000     lsl     r0,r0,0h                                
08045DD0 01AC     lsl     r4,r5,6h                                
08045DD2 0300     lsl     r0,r0,0Ch                               
08045DD4 1B10     sub     r0,r2,r4                                
08045DD6 00C0     lsl     r0,r0,3h                                
08045DD8 1841     add     r1,r0,r1                                
08045DDA 1C08     mov     r0,r1                                   
08045DDC 3024     add     r0,24h                                  
08045DDE 7800     ldrb    r0,[r0]                                 
08045DE0 2811     cmp     r0,11h                                  
08045DE2 D107     bne     8045DF4h                                
08045DE4 1C08     mov     r0,r1                                   
08045DE6 302C     add     r0,2Ch                                  
08045DE8 7800     ldrb    r0,[r0]                                 
08045DEA 282B     cmp     r0,2Bh                                  
08045DEC D802     bhi     8045DF4h                                
08045DEE 8868     ldrh    r0,[r5,2h]                              
08045DF0 3004     add     r0,4h                                   
08045DF2 8068     strh    r0,[r5,2h]                              
08045DF4 BC30     pop     r4,r5                                   
08045DF6 BC01     pop     r0                                      
08045DF8 4700     bx      r0                                      
08045DFA 0000     lsl     r0,r0,0h                                
08045DFC B500     push    r14                                     
08045DFE 4A06     ldr     r2,=3000738h                            
08045E00 1C10     mov     r0,r2                                   
08045E02 3023     add     r0,23h                                  
08045E04 7803     ldrb    r3,[r0]                                 
08045E06 1C11     mov     r1,r2                                   
08045E08 312C     add     r1,2Ch                                  
08045E0A 7808     ldrb    r0,[r1]                                 
08045E0C 2800     cmp     r0,0h                                   
08045E0E D005     beq     8045E1Ch                                
08045E10 3801     sub     r0,1h                                   
08045E12 7008     strb    r0,[r1]                                 
08045E14 E018     b       8045E48h                                
08045E16 0000     lsl     r0,r0,0h                                
08045E18 0738     lsl     r0,r7,1Ch                               
08045E1A 0300     lsl     r0,r0,0Ch                               
08045E1C 4808     ldr     r0,=30001ACh                            
08045E1E 00D9     lsl     r1,r3,3h                                
08045E20 1AC9     sub     r1,r1,r3                                
08045E22 00C9     lsl     r1,r1,3h                                
08045E24 1809     add     r1,r1,r0                                
08045E26 8848     ldrh    r0,[r1,2h]                              
08045E28 1C01     mov     r1,r0                                   
08045E2A 39A0     sub     r1,0A0h                                 
08045E2C 8850     ldrh    r0,[r2,2h]                              
08045E2E 4281     cmp     r1,r0                                   
08045E30 DA08     bge     8045E44h                                
08045E32 8051     strh    r1,[r2,2h]                              
08045E34 1C11     mov     r1,r2                                   
08045E36 3124     add     r1,24h                                  
08045E38 2042     mov     r0,42h                                  
08045E3A 7008     strb    r0,[r1]                                 
08045E3C E004     b       8045E48h                                
08045E3E 0000     lsl     r0,r0,0h                                
08045E40 01AC     lsl     r4,r5,6h                                
08045E42 0300     lsl     r0,r0,0Ch                               
08045E44 3004     add     r0,4h                                   
08045E46 8050     strh    r0,[r2,2h]                              
08045E48 BC01     pop     r0                                      
08045E4A 4700     bx      r0   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;主程序                                   
08045E4C B510     push    r4,r14                                  
08045E4E 4805     ldr     r0,=3000738h                            
08045E50 3024     add     r0,24h                                  
08045E52 7800     ldrb    r0,[r0]                                 
08045E54 2855     cmp     r0,55h                                  
08045E56 D900     bls     @@Pass                                
08045E58 E0E9     b       @@OtherPose 

@@Pass:                               
08045E5A 0080     lsl     r0,r0,2h                                
08045E5C 4902     ldr     r1,=PoseTable                            
08045E5E 1840     add     r0,r0,r1                                
08045E60 6800     ldr     r0,[r0]                                 
08045E62 4687     mov     r15,r0                                  

PoseTable:                             
    .word 8045fc4h ;00
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word 8045fcah ;09h   正常情况下的飞船
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose
	.word 804600ch ;0Fh
	.word @@OtherPose
	.word 8046012h ;11h
	.word @@OtherPose
	.word 8046018h ;13h
	.word @@OtherPose
	.word 804601eh ;15h
	.word @@OtherPose
	.word 8046024h ;17h
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose
	.word 8045fd0h ;22h
	.word 8045fd6h ;23h
	.word 8045fdch ;24h
	.word 8045fe2h ;25h   2C姿势在飞船
	.word @@OtherPose
	.word 8045fe8h ;27h
	.word 8045feeh ;28h
	.word 8045ff4h ;29h
	.word 8045ffah ;2ah
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose 
	.word 8046000h ;42h
	.word 8046006h ;43h
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose .word @@OtherPose .word @@OtherPose .word @@OtherPose
	.word @@OtherPose
    .word 804602ah ;55h	  开场降落的飞船
	     
08045FC4 F7FEFEFA bl      8044DBCh  ;00h                              
08045FC8 E031     b       @@OtherPose                                
08045FCA F7FFF80B bl      8044FE4h  ;09h                              
08045FCE E02E     b       @@OtherPose                                
08045FD0 F7FFF828 bl      8045024h  ;22h                              
08045FD4 E02B     b       @@OtherPose                                
08045FD6 F7FFF88B bl      80450F0h  ;23h                              
08045FDA E028     b       @@OtherPose                                
08045FDC F7FFF936 bl      804524Ch  ;24h                              
08045FE0 E025     b       @@OtherPose                                
08045FE2 F7FFF9B9 bl      8045358h  ;25h                              
08045FE6 E022     b       @@OtherPose                                
08045FE8 F7FFFA12 bl      8045410h  ;27h                              
08045FEC E01F     b       @@OtherPose                                
08045FEE F7FFFA3B bl      8045468h  ;28h                              
08045FF2 E01C     b       @@OtherPose                                
08045FF4 F7FFFA4A bl      804548Ch  ;29h                              
08045FF8 E019     b       @@OtherPose                                
08045FFA F7FFFA5B bl      80454B4h  ;2ah                              
08045FFE E016     b       @@OtherPose                                
08046000 F7FFF96C bl      80452DCh  ;42h                              
08046004 E013     b       @@OtherPose                                
08046006 F7FFF98B bl      8045320h  ;43h                              
0804600A E010     b       @@OtherPose                                
0804600C F7FFFA66 bl      80454DCh  ;0fh                               
08046010 E00D     b       @@OtherPose                                
08046012 F7FFFA8B bl      804552Ch  ;11h                               
08046016 E00A     b       @@OtherPose                                
08046018 F7FFFAFA bl      8045610h  ;13h                              
0804601C E007     b       @@OtherPose                                
0804601E F7FFFB33 bl      8045688h  ;15h                              
08046022 E004     b       @@OtherPose                                
08046024 F7FFFB70 bl      8045708h  ;17h                              
08046028 E001     b       @@OtherPose                                
0804602A F7FEFFB7 bl      8044F9Ch  ;55h

@@OtherPose:                              
0804602E 4C07     ldr     r4,=300070Ch                            
08046030 7BE0     ldrb    r0,[r4,0Fh]                             
08046032 2800     cmp     r0,0h         ;检查舱门是开是关                           
08046034 D10C     bne     @@Open                                
08046036 20A0     mov     r0,0A0h       ;此为舱门关闭经历                          
08046038 00C0     lsl     r0,r0,3h      ;500h  上下14格                       
0804603A 21E0     mov     r1,0E0h                                 
0804603C 0049     lsl     r1,r1,1h      ;1C0h  左右7格                         
0804603E F7C9FECF bl      800FDE0h                                
08046042 2800     cmp     r0,0h                                 
08046044 D00D     beq     @@OutOfRange  ;范围外跳转                              
08046046 2001     mov     r0,1h         ;范围内开盖                           
08046048 E00A     b       @@Peer2                                

@@Open:                              
08046050 20A0     mov     r0,0A0h                                 
08046052 00C0     lsl     r0,r0,3h      ;上下14格                          
08046054 2190     mov     r1,90h                                  
08046056 0089     lsl     r1,r1,2h      ;左右9格                          
08046058 F7C9FEC2 bl      800FDE0h                                
0804605C 2800     cmp     r0,0h         ;范围外合盖                          
0804605E D100     bne     @@OutOfRange  ;在范围直接结束

@@Peer2:                               
08046060 73E0     strb    r0,[r4,0Fh]  

@@OutOfRange:                           
08046062 F7FEFE21 bl      8044CA8h                                
08046066 2003     mov     r0,3h                                   
08046068 2141     mov     r1,41h                                  
0804606A F01AFC27 bl      80608BCh     ;检查事件41                           
0804606E 2800     cmp     r0,0h                                   
08046070 D10B     bne     @@end        ;没有激活                        
08046072 4907     ldr     r1,=3000738h                            
08046074 88C8     ldrh    r0,[r1,6h]   ;300073e的值                           
08046076 2800     cmp     r0,0h        ;如果为0则结束                           
08046078 D007     beq     @@end                                
0804607A 3801     sub     r0,1h        ;减1再写入                           
0804607C 80C8     strh    r0,[r1,6h]                              
0804607E 0400     lsl     r0,r0,10h                               
08046080 2800     cmp     r0,0h        ;如果不为0则结束                           
08046082 D102     bne     @@end                                
08046084 4903     ldr     r1,=3000049h                            
08046086 2000     mov     r0,0h        ;禁用暂停开启                           
08046088 7008     strb    r0,[r1]

@@end:                                 
0804608A BC10     pop     r4                                      
0804608C BC01     pop     r0                                      
0804608E 4700     bx      r0                                      

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;飞船舱盖的精灵   
;32-1显示的是舱盖外圈
;32-2显示的舱盖与内部
;32-3显示的是舱内类似电梯的站立闪光盘
                           
08046098 B510     push    r4,r14                                  
0804609A 480A     ldr     r0,=3000738h                            
0804609C 1C01     mov     r1,r0                                   
0804609E 3123     add     r1,23h                                  
080460A0 780A     ldrb    r2,[r1]        ;主精灵序号                         
080460A2 7F81     ldrb    r1,[r0,1Eh]    ;读取3000756h  副精灵data号                        
080460A4 1C04     mov     r4,r0                                   
080460A6 2901     cmp     r1,1h                                   
080460A8 D114     bne     @@Pass                                
080460AA 4807     ldr     r0,=30001ACh                            
080460AC 00D1     lsl     r1,r2,3h                                
080460AE 1A89     sub     r1,r1,r2                                
080460B0 00C9     lsl     r1,r1,3h                                
080460B2 1809     add     r1,r1,r0                                
080460B4 3122     add     r1,22h                                  
080460B6 7808     ldrb    r0,[r1]        ;读取类似300075a的值                         
080460B8 2804     cmp     r0,4h                                   
080460BA D107     bne     @@Pass2                               
080460BC 1C21     mov     r1,r4                                   
080460BE 3122     add     r1,22h                                  
080460C0 2003     mov     r0,3h          ;重新写入3h                        
080460C2 E006     b       @@Peer                                

@@Pass2:                              
080460CC 1C21     mov     r1,r4                                   
080460CE 3122     add     r1,22h                                   
080460D0 200B     mov     r0,0Bh         ;重新写入B

@@Peer:                                 
080460D2 7008     strb    r0,[r1]

@@Pass:                                 
080460D4 1C23     mov     r3,r4                                   
080460D6 7F98     ldrb    r0,[r3,1Eh]    ;检查精灵data号                          
080460D8 2803     cmp     r0,3h                                   
080460DA D008     beq     @@Data3                                
080460DC 4909     ldr     r1,=30001ACh                            
080460DE 00D0     lsl     r0,r2,3h                                
080460E0 1A80     sub     r0,r0,r2                                
080460E2 00C0     lsl     r0,r0,3h                                
080460E4 1840     add     r0,r0,r1                                
080460E6 8841     ldrh    r1,[r0,2h]                               
080460E8 8059     strh    r1,[r3,2h]                              
080460EA 8880     ldrh    r0,[r0,4h]                              
080460EC 8098     strh    r0,[r3,4h]     ;坐标迁移???

@@Data3:                              
080460EE 1C20     mov     r0,r4                                   
080460F0 3024     add     r0,24h                                  
080460F2 7800     ldrb    r0,[r0]                                 
080460F4 2845     cmp     r0,45h                                  
080460F6 D900     bls     80460FAh                                
080460F8 E0BD     b       8046276h                                
080460FA 0080     lsl     r0,r0,2h                                
080460FC 4902     ldr     r1,=804610Ch                            
080460FE 1840     add     r0,r0,r1                                
08046100 6800     ldr     r0,[r0]                                 
08046102 4687     mov     r15,r0                                  
08046104 01AC     lsl     r4,r5,6h                                
08046106 0300     lsl     r0,r0,0Ch                               
08046108 610C     str     r4,[r1,10h]                             
0804610A 0804     lsr     r4,r0,20h                               
0804610C 6224     str     r4,[r4,20h]                             
0804610E 0804     lsr     r4,r0,20h                               
08046110 6276     str     r6,[r6,24h]                             
08046112 0804     lsr     r4,r0,20h                               
08046114 6276     str     r6,[r6,24h]                             
08046116 0804     lsr     r4,r0,20h                               
08046118 6276     str     r6,[r6,24h]                             
0804611A 0804     lsr     r4,r0,20h                               
0804611C 6276     str     r6,[r6,24h]                             
0804611E 0804     lsr     r4,r0,20h                               
08046120 6276     str     r6,[r6,24h]                             
08046122 0804     lsr     r4,r0,20h                               
08046124 6276     str     r6,[r6,24h]                             
08046126 0804     lsr     r4,r0,20h                               
08046128 6276     str     r6,[r6,24h]                             
0804612A 0804     lsr     r4,r0,20h                               
0804612C 622A     str     r2,[r5,20h]                             
0804612E 0804     lsr     r4,r0,20h                               
08046130 6230     str     r0,[r6,20h]                             
08046132 0804     lsr     r4,r0,20h                               
08046134 6276     str     r6,[r6,24h]                             
08046136 0804     lsr     r4,r0,20h                               
08046138 6276     str     r6,[r6,24h]                             
0804613A 0804     lsr     r4,r0,20h                               
0804613C 6276     str     r6,[r6,24h]                             
0804613E 0804     lsr     r4,r0,20h                               
08046140 6276     str     r6,[r6,24h]                             
08046142 0804     lsr     r4,r0,20h                               
08046144 6236     str     r6,[r6,20h]                             
08046146 0804     lsr     r4,r0,20h                               
08046148 623C     str     r4,[r7,20h]                             
0804614A 0804     lsr     r4,r0,20h                               
0804614C 6276     str     r6,[r6,24h]                             
0804614E 0804     lsr     r4,r0,20h                               
08046150 6276     str     r6,[r6,24h]                             
08046152 0804     lsr     r4,r0,20h                               
08046154 6276     str     r6,[r6,24h]                             
08046156 0804     lsr     r4,r0,20h                               
08046158 6276     str     r6,[r6,24h]                             
0804615A 0804     lsr     r4,r0,20h                               
0804615C 6276     str     r6,[r6,24h]                             
0804615E 0804     lsr     r4,r0,20h                               
08046160 6276     str     r6,[r6,24h]                             
08046162 0804     lsr     r4,r0,20h                               
08046164 6276     str     r6,[r6,24h]                             
08046166 0804     lsr     r4,r0,20h                               
08046168 6276     str     r6,[r6,24h]                             
0804616A 0804     lsr     r4,r0,20h                               
0804616C 6276     str     r6,[r6,24h]                             
0804616E 0804     lsr     r4,r0,20h                               
08046170 6276     str     r6,[r6,24h]                             
08046172 0804     lsr     r4,r0,20h                               
08046174 6276     str     r6,[r6,24h]                             
08046176 0804     lsr     r4,r0,20h                               
08046178 6276     str     r6,[r6,24h]                             
0804617A 0804     lsr     r4,r0,20h                               
0804617C 6276     str     r6,[r6,24h]                             
0804617E 0804     lsr     r4,r0,20h                               
08046180 6276     str     r6,[r6,24h]                             
08046182 0804     lsr     r4,r0,20h                               
08046184 6276     str     r6,[r6,24h]                             
08046186 0804     lsr     r4,r0,20h                               
08046188 6276     str     r6,[r6,24h]                             
0804618A 0804     lsr     r4,r0,20h                               
0804618C 6276     str     r6,[r6,24h]                             
0804618E 0804     lsr     r4,r0,20h                               
08046190 6276     str     r6,[r6,24h]                             
08046192 0804     lsr     r4,r0,20h                               
08046194 6276     str     r6,[r6,24h]                             
08046196 0804     lsr     r4,r0,20h                               
08046198 6276     str     r6,[r6,24h]                             
0804619A 0804     lsr     r4,r0,20h                               
0804619C 6276     str     r6,[r6,24h]                             
0804619E 0804     lsr     r4,r0,20h                               
080461A0 6276     str     r6,[r6,24h]                             
080461A2 0804     lsr     r4,r0,20h                               
080461A4 6276     str     r6,[r6,24h]                             
080461A6 0804     lsr     r4,r0,20h                               
080461A8 6276     str     r6,[r6,24h]                             
080461AA 0804     lsr     r4,r0,20h                               
080461AC 6276     str     r6,[r6,24h]                             
080461AE 0804     lsr     r4,r0,20h                               
080461B0 6276     str     r6,[r6,24h]                             
080461B2 0804     lsr     r4,r0,20h                               
080461B4 6276     str     r6,[r6,24h]                             
080461B6 0804     lsr     r4,r0,20h                               
080461B8 6276     str     r6,[r6,24h]                             
080461BA 0804     lsr     r4,r0,20h                               
080461BC 6276     str     r6,[r6,24h]                             
080461BE 0804     lsr     r4,r0,20h                               
080461C0 6276     str     r6,[r6,24h]                             
080461C2 0804     lsr     r4,r0,20h                               
080461C4 6276     str     r6,[r6,24h]                             
080461C6 0804     lsr     r4,r0,20h                               
080461C8 6276     str     r6,[r6,24h]                             
080461CA 0804     lsr     r4,r0,20h                               
080461CC 6276     str     r6,[r6,24h]                             
080461CE 0804     lsr     r4,r0,20h                               
080461D0 6276     str     r6,[r6,24h]                             
080461D2 0804     lsr     r4,r0,20h                               
080461D4 625A     str     r2,[r3,24h]                             
080461D6 0804     lsr     r4,r0,20h                               
080461D8 6276     str     r6,[r6,24h]                             
080461DA 0804     lsr     r4,r0,20h                               
080461DC 6260     str     r0,[r4,24h]                             
080461DE 0804     lsr     r4,r0,20h                               
080461E0 6266     str     r6,[r4,24h]                             
080461E2 0804     lsr     r4,r0,20h                               
080461E4 626C     str     r4,[r5,24h]                             
080461E6 0804     lsr     r4,r0,20h                               
080461E8 6272     str     r2,[r6,24h]                             
080461EA 0804     lsr     r4,r0,20h                               
080461EC 6276     str     r6,[r6,24h]                             
080461EE 0804     lsr     r4,r0,20h                               
080461F0 6276     str     r6,[r6,24h]                             
080461F2 0804     lsr     r4,r0,20h                               
080461F4 6276     str     r6,[r6,24h]                             
080461F6 0804     lsr     r4,r0,20h                               
080461F8 6276     str     r6,[r6,24h]                             
080461FA 0804     lsr     r4,r0,20h                               
080461FC 6276     str     r6,[r6,24h]                             
080461FE 0804     lsr     r4,r0,20h                               
08046200 6276     str     r6,[r6,24h]                             
08046202 0804     lsr     r4,r0,20h                               
08046204 6276     str     r6,[r6,24h]                             
08046206 0804     lsr     r4,r0,20h                               
08046208 6276     str     r6,[r6,24h]                             
0804620A 0804     lsr     r4,r0,20h                               
0804620C 6276     str     r6,[r6,24h]                             
0804620E 0804     lsr     r4,r0,20h                               
08046210 6276     str     r6,[r6,24h]                             
08046212 0804     lsr     r4,r0,20h                               
08046214 6242     str     r2,[r0,24h]                             
08046216 0804     lsr     r4,r0,20h                               
08046218 6248     str     r0,[r1,24h]                             
0804621A 0804     lsr     r4,r0,20h                               
0804621C 624E     str     r6,[r1,24h]                             
0804621E 0804     lsr     r4,r0,20h                               
08046220 6254     str     r4,[r2,24h]                             
08046222 0804     lsr     r4,r0,20h                               

