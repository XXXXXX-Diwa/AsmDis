

08013BE4 B500     push    r14                                     
08013BE6 4906     ldr     r1,=3000738h                            
08013BE8 7F48     ldrb    r0,[r1,1Dh]      ;检查ID                       
08013BEA 3822     sub     r0,22h           ;ID减22                       
08013BEC 1C0A     mov     r2,r1                                   
08013BEE 2872     cmp     r0,72h                                  
08013BF0 D900     bls     @@Pass                                
08013BF2 E0F3     b       @@end    

@@Pass:                            
08013BF4 0080     lsl     r0,r0,2h                                
08013BF6 4903     ldr     r1,=8013C08h                            
08013BF8 1840     add     r0,r0,r1                                
08013BFA 6800     ldr     r0,[r0]                                 
08013BFC 4687     mov     r15,r0                                  

Table:
     ;区分面向
    	
08013DD4 8811     ldrh    r1,[r2]                                 
08013DD6 2040     mov     r0,40h                                  
08013DD8 4308     orr     r0,r1                                   
08013DDA 8010     strh    r0,[r2] 

@@end:                                
08013DDC BC01     pop     r0                                      
08013DDE 4700     bx      r0   

                                   
08013DE0 B500     push    r14                                     
08013DE2 0600     lsl     r0,r0,18h                               
08013DE4 0E00     lsr     r0,r0,18h    ;精灵ID                           
08013DE6 2200     mov     r2,0h                                   
08013DE8 3822     sub     r0,22h                                  
08013DEA 2872     cmp     r0,72h                                  
08013DEC D900     bls     @@Pass                                
08013DEE E150     b       @@end  

@@Pass:                              
08013DF0 0080     lsl     r0,r0,2h                                
08013DF2 4902     ldr     r1,=8013E00h                            
08013DF4 1840     add     r0,r0,r1                                
08013DF6 6800     ldr     r0,[r0]                                 
08013DF8 4687     mov     r15,r0                                  

Table:
    .word 8013fcch ;00
	.word 8014008h ;01
	.word 8013fd2h ;02
	.word 8014014h ;03
	.word 8013fd8h ;04
	.word 8014020h ;05
	.word 8013fdeh ;06
	.word 8014038h ;07
	.word 8013fe4h ;08
	.word 8014044h ;09
	.word 8013feah ;0a
	.word 8014050h ;0b
	.word 8013ff0h ;0c
	.word 801405ch ;0d
	.word 8013ff6h ;0e
	.word 8014068h ;0f
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end 
	.word 8014080h ;36
	.word 8014074h ;37
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end
	.word @@end .word @@end .word @@end .word @@end	
	.word @@end .word @@end
	.word 801402ch ;72
	
08013FCC 2003     mov     r0,3h        ;指引雕像的事件检查                                
08013FCE 2108     mov     r1,8h                                   
08013FD0 E013     b       8013FFAh                                
08013FD2 2003     mov     r0,3h                                   
08013FD4 210A     mov     r1,0Ah                                  
08013FD6 E010     b       8013FFAh                                
08013FD8 2003     mov     r0,3h                                   
08013FDA 210E     mov     r1,0Eh                                  
08013FDC E00D     b       8013FFAh                                
08013FDE 2003     mov     r0,3h                                   
08013FE0 2109     mov     r1,9h                                   
08013FE2 E00A     b       8013FFAh                                
08013FE4 2003     mov     r0,3h                                   
08013FE6 210B     mov     r1,0Bh                                  
08013FE8 E007     b       8013FFAh                                
08013FEA 2003     mov     r0,3h                                   
08013FEC 210C     mov     r1,0Ch                                  
08013FEE E004     b       8013FFAh                                
08013FF0 2003     mov     r0,3h                                   
08013FF2 210F     mov     r1,0Fh                                  
08013FF4 E001     b       8013FFAh                                
08013FF6 2003     mov     r0,3h                                   
08013FF8 210D     mov     r1,0Dh  

                                
08013FFA F04CFC5F bl      80608BCh                                
08013FFE 2202     mov     r2,2h                                   
08014000 2800     cmp     r0,0h                                   
08014002 D046     beq     @@end      ;事件未激活则返回2.激活则返回3                               
08014004 2203     mov     r2,3h                                   
08014006 E044     b       @@end 

                               
08014008 4801     ldr     r0,=3001530h                            
0801400A 7B01     ldrb    r1,[r0,0Ch]  ;检查能力是否取得                           
0801400C 2001     mov     r0,1h                                   
0801400E E03A     b       @@Check                                
                              
08014014 4801     ldr     r0,=3001530h                            
08014016 7B01     ldrb    r1,[r0,0Ch]                             
08014018 2002     mov     r0,2h                                   
0801401A E034     b       @@Check                                
                              
08014020 4801     ldr     r0,=3001530h                            
08014022 7B01     ldrb    r1,[r0,0Ch]                             
08014024 2004     mov     r0,4h                                   
08014026 E02E     b       @@Check                                
                             
0801402C 4801     ldr     r0,=3001530h                            
0801402E 7B01     ldrb    r1,[r0,0Ch]                             
08014030 2008     mov     r0,8h                                   
08014032 E028     b       @@Check                                
                             
08014038 4801     ldr     r0,=3001530h                            
0801403A 7B01     ldrb    r1,[r0,0Ch]                             
0801403C 2080     mov     r0,80h                                  
0801403E E022     b       @@Check                                
                              
08014044 4801     ldr     r0,=3001530h                            
08014046 7B81     ldrb    r1,[r0,0Eh]                             
08014048 2002     mov     r0,2h                                   
0801404A E01C     b       @@Check                                
                              
08014050 4801     ldr     r0,=3001530h                            
08014052 7B81     ldrb    r1,[r0,0Eh]                             
08014054 2001     mov     r0,1h                                   
08014056 E016     b       @@Check                                
                              
0801405C 4801     ldr     r0,=3001530h                            
0801405E 7B81     ldrb    r1,[r0,0Eh]                             
08014060 2008     mov     r0,8h                                   
08014062 E010     b       @@Check                                
                               
08014068 4801     ldr     r0,=3001530h                            
0801406A 7B81     ldrb    r1,[r0,0Eh]                             
0801406C 2010     mov     r0,10h                                  
0801406E E00A     b       @@Check                                
                              
08014074 4801     ldr     r0,=3001530h                            
08014076 7B81     ldrb    r1,[r0,0Eh]                             
08014078 2004     mov     r0,4h                                   
0801407A E004     b       @@Check                                
                               
08014080 4805     ldr     r0,=3001530h                            
08014082 7B81     ldrb    r1,[r0,0Eh]                             
08014084 2020     mov     r0,20h    

@@Check:                              
08014086 4008     and     r0,r1                                   
08014088 2800     cmp     r0,0h                                   
0801408A D002     beq     @@end                                
0801408C 1C50     add     r0,r2,1                                 
0801408E 0600     lsl     r0,r0,18h                               
08014090 0E02     lsr     r2,r0,18h

@@end:                               
08014092 1C10     mov     r0,r2                                   
08014094 BC02     pop     r1                                      
08014096 4708     bx      r1 
                                     


;生产站立雕像砖块
08016128 B5F0     push    r4-r7,r14                               
0801612A 464F     mov     r7,r9                                   
0801612C 4646     mov     r6,r8                                   
0801612E B4C0     push    r6,r7                                   
08016130 0600     lsl     r0,r0,18h                               
08016132 0E00     lsr     r0,r0,18h     ;4                          
08016134 4680     mov     r8,r0                                   
08016136 0609     lsl     r1,r1,18h                               
08016138 0E0A     lsr     r2,r1,18h     ;2 激活台砖                              
0801613A 4813     ldr     r0,=300070Ch                            
0801613C 88C1     ldrh    r1,[r0,6h]                              
0801613E 4689     mov     r9,r1         ;Y坐标                          
08016140 8907     ldrh    r7,[r0,8h]    ;X坐标偏移                          
08016142 4812     ldr     r0,=3000738h                            
08016144 8801     ldrh    r1,[r0]                                 
08016146 2040     mov     r0,40h                                  
08016148 4008     and     r0,r1                                   
0801614A 2800     cmp     r0,0h                                   
0801614C D024     beq     @@faceleft                                
0801614E 1C38     mov     r0,r7                                   
08016150 3020     add     r0,20h                                  
08016152 0400     lsl     r0,r0,10h                               
08016154 0C07     lsr     r7,r0,10h    ;原坐标向右一格                           
08016156 4C0E     ldr     r4,=3000079h                            
08016158 7022     strb    r2,[r4]                                 
0801615A 464D     mov     r5,r9                                   
0801615C 3DA0     sub     r5,0A0h      ;向上2格                            
0801615E 1C39     mov     r1,r7                                   
08016160 3180     add     r1,80h       ;向右3格                           
08016162 1C28     mov     r0,r5                                   
08016164 F041FE8A bl      8057E7Ch     ;生产手背砖                           
08016168 4640     mov     r0,r8                                   
0801616A 7020     strb    r0,[r4]                                 
0801616C 4809     ldr     r0,=0FFFFFEE0h                          
0801616E 4448     add     r0,r9                                   
08016170 1C3E     mov     r6,r7                                   
08016172 3640     add     r6,40h       ;向上四格生产砖                            
08016174 1C31     mov     r1,r6                                   
08016176 F041FE81 bl      8057E7Ch                                
0801617A 4641     mov     r1,r8                                   
0801617C 7021     strb    r1,[r4]                                 
0801617E 1C28     mov     r0,r5                                   
08016180 1C31     mov     r1,r6                                   
08016182 F041FE7B bl      8057E7Ch                                
08016186 E023     b       80161D0h                                

@@faceleft:                               
08016198 1C38     mov     r0,r7                                   
0801619A 3820     sub     r0,20h                                  
0801619C 0400     lsl     r0,r0,10h                               
0801619E 0C07     lsr     r7,r0,10h                               
080161A0 4C20     ldr     r4,=3000079h                            
080161A2 7022     strb    r2,[r4]                                 
080161A4 464D     mov     r5,r9                                   
080161A6 3DA0     sub     r5,0A0h                                 
080161A8 1C39     mov     r1,r7                                   
080161AA 3980     sub     r1,80h                                  
080161AC 1C28     mov     r0,r5                                   
080161AE F041FE65 bl      8057E7Ch                                
080161B2 4640     mov     r0,r8                                   
080161B4 7020     strb    r0,[r4]                                 
080161B6 481C     ldr     r0,=0FFFFFEE0h                          
080161B8 4448     add     r0,r9                                   
080161BA 1C3E     mov     r6,r7                                   
080161BC 3E40     sub     r6,40h                                  
080161BE 1C31     mov     r1,r6                                   
080161C0 F041FE5C bl      8057E7Ch                                
080161C4 4641     mov     r1,r8                                   
080161C6 7021     strb    r1,[r4]                                 
080161C8 1C28     mov     r0,r5                                   
080161CA 1C31     mov     r1,r6                                   
080161CC F041FE56 bl      8057E7Ch                                
080161D0 4C14     ldr     r4,=3000079h                            
080161D2 4640     mov     r0,r8                                   
080161D4 7020     strb    r0,[r4]                                 
080161D6 4648     mov     r0,r9                                   
080161D8 3820     sub     r0,20h                                  
080161DA 1C39     mov     r1,r7                                   
080161DC F041FE4E bl      8057E7Ch                                
080161E0 4641     mov     r1,r8                                   
080161E2 7021     strb    r1,[r4]                                 
080161E4 4648     mov     r0,r9                                   
080161E6 3860     sub     r0,60h                                  
080161E8 1C39     mov     r1,r7                                   
080161EA F041FE47 bl      8057E7Ch                                
080161EE 4640     mov     r0,r8                                   
080161F0 7020     strb    r0,[r4]                                 
080161F2 1C28     mov     r0,r5                                   
080161F4 1C39     mov     r1,r7                                   
080161F6 F041FE41 bl      8057E7Ch                                
080161FA 4641     mov     r1,r8                                   
080161FC 7021     strb    r1,[r4]                                 
080161FE 4648     mov     r0,r9                                   
08016200 38E0     sub     r0,0E0h                                 
08016202 1C39     mov     r1,r7                                   
08016204 F041FE3A bl      8057E7Ch                                
08016208 4640     mov     r0,r8                                   
0801620A 7020     strb    r0,[r4]                                 
0801620C 4806     ldr     r0,=0FFFFFEE0h                          
0801620E 4448     add     r0,r9                                   
08016210 1C39     mov     r1,r7                                   
08016212 F041FE33 bl      8057E7Ch                                
08016216 BC18     pop     r3,r4                                   
08016218 4698     mov     r8,r3                                   
0801621A 46A1     mov     r9,r4                                   
0801621C BCF0     pop     r4-r7                                   
0801621E BC01     pop     r0                                      
08016220 4700     bx      r0                                      


;生产撤销坐下雕像砖块
0801622C B5F0     push    r4-r7,r14                               
0801622E 0600     lsl     r0,r0,18h                               
08016230 0E06     lsr     r6,r0,18h                               
08016232 480A     ldr     r0,=300070Ch                            
08016234 88C7     ldrh    r7,[r0,6h]     ;读取雕像Y坐标                         
08016236 8905     ldrh    r5,[r0,8h]     ;读取雕像X坐标                         
08016238 4809     ldr     r0,=3000738h                            
0801623A 8801     ldrh    r1,[r0]        ;读取取向                         
0801623C 2040     mov     r0,40h                                  
0801623E 4008     and     r0,r1                                   
08016240 2800     cmp     r0,0h                                   
08016242 D011     beq     @@faceleft     ;减20的类型                            
08016244 4807     ldr     r0,=3000079h                            
08016246 7006     strb    r6,[r0]        ;读取制砖设置值                           
08016248 1C3C     mov     r4,r7          ;Y坐标减20                         
0801624A 3C20     sub     r4,20h                                  
0801624C 1C29     mov     r1,r5                                   
0801624E 3120     add     r1,20h         ;X坐标向右一格生产砖                        
08016250 1C20     mov     r0,r4                                   
08016252 F041FE13 bl      8057E7Ch       ;原地产砖                         
08016256 1C28     mov     r0,r5                                   
08016258 3820     sub     r0,20h         ;X坐标向左20                         
0801625A E010     b       @@Peer                                

@@faceleft:                              
08016268 4810     ldr     r0,=3000079h                            
0801626A 7006     strb    r6,[r0]                                 
0801626C 1C3C     mov     r4,r7                                   
0801626E 3C20     sub     r4,20h                                  
08016270 1C29     mov     r1,r5                                   
08016272 3920     sub     r1,20h                                  
08016274 1C20     mov     r0,r4                                   
08016276 F041FE01 bl      8057E7Ch       ;X坐标向左一格生产砖                          
0801627A 1C28     mov     r0,r5                                   
0801627C 3020     add     r0,20h         ;原X坐标

@@Peer:                                 
0801627E 0400     lsl     r0,r0,10h                               
08016280 0C05     lsr     r5,r0,10h                               
08016282 1C20     mov     r0,r4                                   
08016284 4C09     ldr     r4,=3000079h                            
08016286 7026     strb    r6,[r4]                                 
08016288 1C29     mov     r1,r5                                   
0801628A F041FDF7 bl      8057E7Ch       ;原地产砖                         
0801628E 7026     strb    r6,[r4]                                 
08016290 1C38     mov     r0,r7                                   
08016292 3860     sub     r0,60h                                  
08016294 1C29     mov     r1,r5         ;原地向上一格产砖                          
08016296 F041FDF1 bl      8057E7Ch                                
0801629A 7026     strb    r6,[r4]                                 
0801629C 1C38     mov     r0,r7                                   
0801629E 38A0     sub     r0,0A0h       ;原地向上两格产砖                          
080162A0 1C29     mov     r1,r5                                   
080162A2 F041FDEB bl      8057E7Ch                                
080162A6 BCF0     pop     r4-r7                                   
080162A8 BC01     pop     r0                                      
080162AA 4700     bx      r0                                      


                               
080162B0 B500     push    r14                                     
080162B2 B082     add     sp,-8h                                  
080162B4 0600     lsl     r0,r0,18h                               
080162B6 0E00     lsr     r0,r0,18h                               
080162B8 1C02     mov     r2,r0                                   
080162BA 282D     cmp     r0,2Dh                                  
080162BC D029     beq     8016312h                                
080162BE 282D     cmp     r0,2Dh                                  
080162C0 DC0D     bgt     80162DEh                                
080162C2 2827     cmp     r0,27h                                  
080162C4 D01D     beq     8016302h                                
080162C6 2827     cmp     r0,27h                                  
080162C8 DC04     bgt     80162D4h                                
080162CA 2823     cmp     r0,23h                                  
080162CC D015     beq     80162FAh                                
080162CE 2825     cmp     r0,25h                                  
080162D0 D015     beq     80162FEh                                
080162D2 E027     b       8016324h                                
080162D4 2829     cmp     r0,29h                                  
080162D6 D018     beq     801630Ah                                
080162D8 282B     cmp     r0,2Bh                                  
080162DA D018     beq     801630Eh                                
080162DC E022     b       8016324h                                
080162DE 2858     cmp     r0,58h                                  
080162E0 D01F     beq     8016322h                                
080162E2 2858     cmp     r0,58h                                  
080162E4 DC04     bgt     80162F0h                                
080162E6 282F     cmp     r0,2Fh                                  
080162E8 D015     beq     8016316h                                
080162EA 2831     cmp     r0,31h                                  
080162EC D015     beq     801631Ah                                
080162EE E019     b       8016324h                                
080162F0 2A59     cmp     r2,59h                                  
080162F2 D014     beq     801631Eh                                
080162F4 2A94     cmp     r2,94h                                  
080162F6 D006     beq     8016306h                                
080162F8 E014     b       8016324h                                
080162FA 2108     mov     r1,8h                                   
080162FC E012     b       8016324h                                
080162FE 210A     mov     r1,0Ah                                  
08016300 E010     b       8016324h                                
08016302 210B     mov     r1,0Bh                                  
08016304 E00E     b       8016324h                                
08016306 210C     mov     r1,0Ch                                  
08016308 E00C     b       8016324h                                
0801630A 210D     mov     r1,0Dh                                  
0801630C E00A     b       8016324h                                
0801630E 2111     mov     r1,11h                                  
08016310 E008     b       8016324h                                
08016312 2112     mov     r1,12h                                  
08016314 E006     b       8016324h                                
08016316 2113     mov     r1,13h                                  
08016318 E004     b       8016324h                                
0801631A 210E     mov     r1,0Eh                                  
0801631C E002     b       8016324h                                
0801631E 2114     mov     r1,14h                                  
08016320 E000     b       8016324h                                
08016322 210F     mov     r1,0Fh                                  
08016324 4806     ldr     r0,=3000738h                            
08016326 8843     ldrh    r3,[r0,2h]                              
08016328 8880     ldrh    r0,[r0,4h]                              
0801632A 9000     str     r0,[sp]                                 
0801632C 2000     mov     r0,0h                                   
0801632E 9001     str     r0,[sp,4h]                              
08016330 2011     mov     r0,11h                                  
08016332 2206     mov     r2,6h                                   
08016334 F7F7FFF2 bl      800E31Ch                                
08016338 B002     add     sp,8h                                   
0801633A BC01     pop     r0                                      
0801633C 4700     bx      r0                                      
0801633E 0000     lsl     r0,r0,0h                                
08016340 0738     lsl     r0,r7,1Ch                               
08016342 0300     lsl     r0,r0,0Ch                               
08016344 B500     push    r14                                     
08016346 0600     lsl     r0,r0,18h                               
08016348 0E00     lsr     r0,r0,18h                               
0801634A 1C01     mov     r1,r0                                   
0801634C 282D     cmp     r0,2Dh                                  
0801634E D021     beq     8016394h                                
08016350 282D     cmp     r0,2Dh                                  
08016352 DD1F     ble     8016394h                                
08016354 2858     cmp     r0,58h                                  
08016356 D015     beq     8016384h                                
08016358 2858     cmp     r0,58h                                  
0801635A DD1B     ble     8016394h                                
0801635C 2959     cmp     r1,59h                                  
0801635E D009     beq     8016374h                                
08016360 2994     cmp     r1,94h                                  
08016362 D117     bne     8016394h                                
08016364 4901     ldr     r1,=3000738h                            
08016366 4802     ldr     r0,=82C12F0h                            
08016368 E016     b       8016398h                                
0801636A 0000     lsl     r0,r0,0h                                
0801636C 0738     lsl     r0,r7,1Ch                               
0801636E 0300     lsl     r0,r0,0Ch                               
08016370 12F0     asr     r0,r6,0Bh                               
08016372 082C     lsr     r4,r5,20h                               
08016374 4901     ldr     r1,=3000738h                            
08016376 4802     ldr     r0,=82C12F0h                            
08016378 E00E     b       8016398h                                
0801637A 0000     lsl     r0,r0,0h                                
0801637C 0738     lsl     r0,r7,1Ch                               
0801637E 0300     lsl     r0,r0,0Ch                               
08016380 12F0     asr     r0,r6,0Bh                               
08016382 082C     lsr     r4,r5,20h                               
08016384 4901     ldr     r1,=3000738h                            
08016386 4802     ldr     r0,=82C12F0h                            
08016388 E006     b       8016398h                                
0801638A 0000     lsl     r0,r0,0h                                
0801638C 0738     lsl     r0,r7,1Ch                               
0801638E 0300     lsl     r0,r0,0Ch                               
08016390 12F0     asr     r0,r6,0Bh                               
08016392 082C     lsr     r4,r5,20h                               
08016394 4902     ldr     r1,=3000738h                            
08016396 4803     ldr     r0,=82B5868h                            
08016398 6188     str     r0,[r1,18h]                             
0801639A BC01     pop     r0                                      
0801639C 4700     bx      r0                                      
0801639E 0000     lsl     r0,r0,0h                                
080163A0 0738     lsl     r0,r7,1Ch                               
080163A2 0300     lsl     r0,r0,0Ch                               
080163A4 5868     ldr     r0,[r5,r1]                              
080163A6 082B     lsr     r3,r5,20h                               
080163A8 B500     push    r14                                     
080163AA 0600     lsl     r0,r0,18h                               
080163AC 0E00     lsr     r0,r0,18h                               
080163AE 1C01     mov     r1,r0                                   
080163B0 282D     cmp     r0,2Dh                                  
080163B2 D021     beq     80163F8h                                
080163B4 282D     cmp     r0,2Dh                                  
080163B6 DD1F     ble     80163F8h                                
080163B8 2858     cmp     r0,58h                                  
080163BA D015     beq     80163E8h                                
080163BC 2858     cmp     r0,58h                                  
080163BE DD1B     ble     80163F8h                                
080163C0 2959     cmp     r1,59h                                  
080163C2 D009     beq     80163D8h                                
080163C4 2994     cmp     r1,94h                                  
080163C6 D117     bne     80163F8h                                
080163C8 4901     ldr     r1,=3000738h                            
080163CA 4802     ldr     r0,=82C1318h                            
080163CC E016     b       80163FCh                                
080163CE 0000     lsl     r0,r0,0h                                
080163D0 0738     lsl     r0,r7,1Ch                               
080163D2 0300     lsl     r0,r0,0Ch                               
080163D4 1318     asr     r0,r3,0Ch                               
080163D6 082C     lsr     r4,r5,20h                               
080163D8 4901     ldr     r1,=3000738h                            
080163DA 4802     ldr     r0,=82C1318h                            
080163DC E00E     b       80163FCh                                
080163DE 0000     lsl     r0,r0,0h                                
080163E0 0738     lsl     r0,r7,1Ch                               
080163E2 0300     lsl     r0,r0,0Ch                               
080163E4 1318     asr     r0,r3,0Ch                               
080163E6 082C     lsr     r4,r5,20h                               
080163E8 4901     ldr     r1,=3000738h                            
080163EA 4802     ldr     r0,=82C1318h                            
080163EC E006     b       80163FCh                                
080163EE 0000     lsl     r0,r0,0h                                
080163F0 0738     lsl     r0,r7,1Ch                               
080163F2 0300     lsl     r0,r0,0Ch                               
080163F4 1318     asr     r0,r3,0Ch                               
080163F6 082C     lsr     r4,r5,20h                               
080163F8 4902     ldr     r1,=3000738h                            
080163FA 4803     ldr     r0,=82B5890h                            
080163FC 6188     str     r0,[r1,18h]                             
080163FE BC01     pop     r0                                      
08016400 4700     bx      r0                                      

