;主程序调用
080259A0 B510     push    r4,r14                                  
080259A2 1C03     mov     r3,r0                                   
080259A4 8898     ldrh    r0,[r3,4h]     ;动画                             
080259A6 6819     ldr     r1,[r3]        ;OAM                         
080259A8 00C0     lsl     r0,r0,3h       ;乘以8                         
080259AA 1840     add     r0,r0,r1       ;加上OAM                          
080259AC 6804     ldr     r4,[r0]        ;读取当前动画指针                         
080259AE 4A15     ldr     r2,=3000738h                            
080259B0 7F91     ldrb    r1,[r2,1Eh]    ;副精灵data                          
080259B2 0048     lsl     r0,r1,1h                                
080259B4 1840     add     r0,r0,r1                                
080259B6 0040     lsl     r0,r0,1h       ;6倍                         
080259B8 1900     add     r0,r0,r4       ;加上当前动画指针                         
080259BA 8800     ldrh    r0,[r0]        ;读取数值                         
080259BC 4912     ldr     r1,=875F5FCh                            
080259BE 0080     lsl     r0,r0,2h       ;乘以4                         
080259C0 1840     add     r0,r0,r1       ;加上偏移值                         
080259C2 6991     ldr     r1,[r2,18h]    ;读取OAM                         
080259C4 6800     ldr     r0,[r0]        ;读取偏移值地址的OAM                         
080259C6 4281     cmp     r1,r0          ;比较                         
080259C8 D003     beq     @@OAMSame                                
080259CA 6190     str     r0,[r2,18h]                             
080259CC 2000     mov     r0,0h                                   
080259CE 7710     strb    r0,[r2,1Ch]                             
080259D0 82D0     strh    r0,[r2,16h] 

@@OAMSame:                            
080259D2 7F91     ldrb    r1,[r2,1Eh]    ;读取副精灵DATA                         
080259D4 0048     lsl     r0,r1,1h                                
080259D6 1840     add     r0,r0,r1                                
080259D8 0040     lsl     r0,r0,1h       ;六倍                         
080259DA 1900     add     r0,r0,r4       ;加上当前动画指针                         
080259DC 8840     ldrh    r0,[r0,2h]     ;读取下一个数据                         
080259DE 88D9     ldrh    r1,[r3,6h]     ;读取Y坐标                         
080259E0 1840     add     r0,r0,r1       ;加上下一个数据                         
080259E2 8050     strh    r0,[r2,2h]     ;写入Y坐标                        
080259E4 8811     ldrh    r1,[r2]                                 
080259E6 2040     mov     r0,40h                                  
080259E8 4008     and     r0,r1                                   
080259EA 7F91     ldrb    r1,[r2,1Eh]                             
080259EC 2800     cmp     r0,0h                                   
080259EE D00D     beq     @@SpriteDataZero                                
080259F0 0048     lsl     r0,r1,1h                                
080259F2 1840     add     r0,r0,r1                                
080259F4 0040     lsl     r0,r0,1h                                
080259F6 1900     add     r0,r0,r4                                
080259F8 8919     ldrh    r1,[r3,8h]                              
080259FA 8880     ldrh    r0,[r0,4h]                              
080259FC 1A09     sub     r1,r1,r0                                
080259FE 8091     strh    r1,[r2,4h]                              
08025A00 E00C     b       8025A1Ch                                

@@SpriteDataZero:                                
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
08025A20 4700     bx      r0  


;多处调用 调色改变?????? 
08025A24 B500     push    r14                                     
08025A26 4914     ldr     r1,=3000738h                            
08025A28 1C08     mov     r0,r1                                   
08025A2A 302B     add     r0,2Bh                                  
08025A2C 7800     ldrb    r0,[r0]    ;读取无敌值                             
08025A2E 237F     mov     r3,7Fh                                  
08025A30 4003     and     r3,r0      ;去除80                             
08025A32 1C0A     mov     r2,r1                                   
08025A34 2B00     cmp     r3,0h                                   
08025A36 D11C     bne     @@end      ;如果无敌中则结束                          
08025A38 312E     add     r1,2Eh                                  
08025A3A 7808     ldrb    r0,[r1]    ;读取3000766                             
08025A3C 3001     add     r0,1h      ;加1再写入                             
08025A3E 7008     strb    r0,[r1]                                 
08025A40 7808     ldrb    r0,[r1]    ;读取3000766                              
08025A42 280A     cmp     r0,0Ah                                  
08025A44 D30A     bcc     @@Pass     ;小于A                             
08025A46 700B     strb    r3,[r1]    ;大于等于A则写入0                             
08025A48 1C11     mov     r1,r2                                   
08025A4A 312F     add     r1,2Fh                                  
08025A4C 7808     ldrb    r0,[r1]    ;读取3000767                             
08025A4E 3001     add     r0,1h                                   
08025A50 7008     strb    r0,[r1]    ;加1再写入                             
08025A52 0600     lsl     r0,r0,18h                               
08025A54 0E00     lsr     r0,r0,18h                               
08025A56 2803     cmp     r0,3h                                   
08025A58 D900     bls     @@Pass     ;小于等于3跳转                             
08025A5A 700B     strb    r3,[r1]    ;大于3则写入0

@@Pass:                               
08025A5C 4907     ldr     r1,=82DB248h                            
08025A5E 1C10     mov     r0,r2                                   
08025A60 302F     add     r0,2Fh                                  
08025A62 7800     ldrb    r0,[r0]    ;读取3000767                               
08025A64 1840     add     r0,r0,r1   ;加上偏移值                             
08025A66 7801     ldrb    r1,[r0]    ;读取数据                             
08025A68 1C10     mov     r0,r2                                   
08025A6A 3034     add     r0,34h                                  
08025A6C 7001     strb    r1,[r0]    ;写入击打调色                        
08025A6E 3814     sub     r0,14h                                  
08025A70 7001     strb    r1,[r0]    ;同样写入调色

@@end:                                
08025A72 BC01     pop     r0                                      
08025A74 4700     bx      r0                                      



;POSE 0
08025A80 B5F0     push    r4-r7,r14                               
08025A82 4647     mov     r7,r8                                   
08025A84 B480     push    r7                                      
08025A86 B083     add     sp,-0Ch                                 
08025A88 1C05     mov     r5,r0      ;300070C 或 3000720                             
08025A8A 2003     mov     r0,3h                                   
08025A8C 2120     mov     r1,20h                                  
08025A8E F03AFF15 bl      80608BCh   ;检查二蛆死事件                             
08025A92 2800     cmp     r0,0h                                   
08025A94 D006     beq     @@EventNoActivation                                
08025A96 4902     ldr     r1,=3000738h                            
08025A98 2000     mov     r0,0h                                   
08025A9A 8008     strh    r0,[r1]    ;取向写入0                             
08025A9C E0AA     b       @@end                                 

@@EventNoActivation:                              
08025AA4 4A11     ldr     r2,=3000738h                            
08025AA6 8850     ldrh    r0,[r2,2h]   ;Y坐标                           
08025AA8 3008     add     r0,8h        ;Y坐标向下8h再写入                           
08025AAA 2300     mov     r3,0h                                   
08025AAC 8050     strh    r0,[r2,2h]                              
08025AAE 80E8     strh    r0,[r5,6h]   ;同样也写入70C或720的偏移                           
08025AB0 8891     ldrh    r1,[r2,4h]   ;读取X坐标                           
08025AB2 8129     strh    r1,[r5,8h]   ;同样写入                           
08025AB4 88E8     ldrh    r0,[r5,6h]                              
08025AB6 4680     mov     r8,r0        ;Y坐标给R8                           
08025AB8 892F     ldrh    r7,[r5,8h]   ;读取X坐标                           
08025ABA 8117     strh    r7,[r2,8h]   ;给备份X坐标                           
08025ABC 7F56     ldrb    r6,[r2,1Dh]  ;读取ID                           
08025ABE 2E8B     cmp     r6,8Bh                                  
08025AC0 D11A     bne     @@ID4D2                                
08025AC2 8810     ldrh    r0,[r2]                                 
08025AC4 2140     mov     r1,40h                                  
08025AC6 4308     orr     r0,r1       ;面向反转                            
08025AC8 8010     strh    r0,[r2]                                 
08025ACA 4809     ldr     r0,=0FF88h                              
08025ACC 81D0     strh    r0,[r2,0Eh] ;左部分界写入FF88                           
08025ACE 2058     mov     r0,58h                                  
08025AD0 8210     strh    r0,[r2,10h] ;右部分界写入58h                            
08025AD2 1C11     mov     r1,r2                                   
08025AD4 3124     add     r1,24h                                  
08025AD6 2009     mov     r0,9h                                   
08025AD8 7008     strb    r0,[r1]     ;pose写入9h                            
08025ADA 4906     ldr     r1,=300007Bh                            
08025ADC 2001     mov     r0,1h                                   
08025ADE 7008     strb    r0,[r1]     ;锁门flag                             
08025AE0 204F     mov     r0,4Fh                                  
08025AE2 2100     mov     r1,0h                                   
08025AE4 F7DDFF86 bl      80039F4h    ;改变房间音乐                            
08025AE8 E016     b       @@Peer                                

@@ID4D2:                              
08025AF8 4841     ldr     r0,=0FFA8h                              
08025AFA 81D0     strh    r0,[r2,0Eh]  ;写入左部分界                             
08025AFC 2078     mov     r0,78h                                  
08025AFE 8210     strh    r0,[r2,10h]  ;写入右部分界                           
08025B00 23B0     mov     r3,0B0h                                 
08025B02 009B     lsl     r3,r3,2h     ;2C0h                           
08025B04 1C18     mov     r0,r3                                   
08025B06 1809     add     r1,r1,r0     ;X坐标加上2C0h                            
08025B08 8129     strh    r1,[r5,8h]   ;写入70C或720处                           
08025B0A 1838     add     r0,r7,r0                                
08025B0C 0400     lsl     r0,r0,10h                               
08025B0E 0C07     lsr     r7,r0,10h    ;X坐标加上2C0的值                            
08025B10 1C11     mov     r1,r2                                   
08025B12 3124     add     r1,24h                                  
08025B14 200F     mov     r0,0Fh       ;pose写入Fh                            
08025B16 7008     strb    r0,[r1] 

@@Peer:                                
08025B18 4C3A     ldr     r4,=3000738h                            
08025B1A 1C20     mov     r0,r4                                   
08025B1C 3027     add     r0,27h                                  
08025B1E 2300     mov     r3,0h                                   
08025B20 2128     mov     r1,28h                                  
08025B22 7001     strb    r1,[r0]      ;75f写入28h                            
08025B24 3001     add     r0,1h                                   
08025B26 7001     strb    r1,[r0]      ;760写入28h                            
08025B28 1C21     mov     r1,r4                                   
08025B2A 3129     add     r1,29h                                  
08025B2C 2018     mov     r0,18h                                  
08025B2E 7008     strb    r0,[r1]      ;761写入18h                           
08025B30 2100     mov     r1,0h                                   
08025B32 4835     ldr     r0,=0FFD0h                              
08025B34 8160     strh    r0,[r4,0Ah]  ;写入上部分界                           
08025B36 81A3     strh    r3,[r4,0Ch]  ;0写入下部分界                           
08025B38 1C20     mov     r0,r4                                   
08025B3A 302E     add     r0,2Eh                                  
08025B3C 7001     strb    r1,[r0]      ;3000766写入0                           
08025B3E 3001     add     r0,1h                                   
08025B40 7001     strb    r1,[r0]      ;3000767写入0                            
08025B42 3803     sub     r0,3h                                   
08025B44 7001     strb    r1,[r0]      ;3000764写入0                            
08025B46 3001     add     r0,1h                                   
08025B48 7001     strb    r1,[r0]      ;3000765写入0                           
08025B4A 80E3     strh    r3,[r4,6h]   ;备份Y坐标写入0                           
08025B4C 3808     sub     r0,8h                                   
08025B4E 7001     strb    r1,[r0]      ;属性写入0h                            
08025B50 4A2E     ldr     r2,=82B0D68h                            
08025B52 00F0     lsl     r0,r6,3h                                
08025B54 1980     add     r0,r0,r6                                
08025B56 0040     lsl     r0,r0,1h                                
08025B58 1880     add     r0,r0,r2                                
08025B5A 8800     ldrh    r0,[r0]      ;得出血量写入血量                           
08025B5C 82A0     strh    r0,[r4,14h]                             
08025B5E 8168     strh    r0,[r5,0Ah]  ;同样也写入70C或720处                           
08025B60 482B     ldr     r0,=82DB100h                            
08025B62 6028     str     r0,[r5]      ;写入70C或720                           
08025B64 7329     strb    r1,[r5,0Ch]  ;718或72C写入0                           
08025B66 80AB     strh    r3,[r5,4h]   ;710或724写入0                           
08025B68 73A9     strb    r1,[r5,0Eh]  ;71A或72E写入0                           
08025B6A 7369     strb    r1,[r5,0Dh]  ;719或72D写入0                           
08025B6C 1C21     mov     r1,r4                                   
08025B6E 3122     add     r1,22h                                  
08025B70 2006     mov     r0,6h        ;300075A写入6h                           
08025B72 7008     strb    r0,[r1]                                 
08025B74 3111     add     r1,11h                                  
08025B76 2002     mov     r0,2h        ;300076B写入2h                           
08025B78 7008     strb    r0,[r1]                                 
08025B7A 2005     mov     r0,5h                                   
08025B7C 77A0     strb    r0,[r4,1Eh]  ;3000756写入5h                           
08025B7E 7FE6     ldrb    r6,[r4,1Fh]  ;读取3000757h                           
08025B80 1C20     mov     r0,r4                                   
08025B82 3023     add     r0,23h                                  
08025B84 7805     ldrb    r5,[r0]      ;读取300075B                           
08025B86 8820     ldrh    r0,[r4]      ;读取取向                           
08025B88 2440     mov     r4,40h                                  
08025B8A 4004     and     r4,r0        ;and 40h                           
08025B8C 0424     lsl     r4,r4,10h                               
08025B8E 0C24     lsr     r4,r4,10h                               
08025B90 4640     mov     r0,r8        ;Y坐标                            
08025B92 9000     str     r0,[sp]                                 
08025B94 9701     str     r7,[sp,4h]   ;X坐标加上某值写入                           
08025B96 9402     str     r4,[sp,8h]   ;状态写入40h                           
08025B98 2012     mov     r0,12h                                  
08025B9A 2100     mov     r1,0h                                   
08025B9C 1C32     mov     r2,r6        ;GFX row                           
08025B9E 1C2B     mov     r3,r5        ;主精灵序号   主体是内胆                       
08025BA0 F7E8FB5A bl      800E258h     ;生产第二精灵12-0  前颚小脚                         
08025BA4 4643     mov     r3,r8                                   
08025BA6 9300     str     r3,[sp]                                 
08025BA8 9701     str     r7,[sp,4h]                              
08025BAA 9402     str     r4,[sp,8h]                              
08025BAC 2012     mov     r0,12h                                  
08025BAE 2101     mov     r1,1h                                   
08025BB0 1C32     mov     r2,r6                                   
08025BB2 1C2B     mov     r3,r5                                   
08025BB4 F7E8FB50 bl      800E258h    ;生产第二精灵12-1   头球3                         
08025BB8 4640     mov     r0,r8                                   
08025BBA 9000     str     r0,[sp]                                 
08025BBC 9701     str     r7,[sp,4h]                              
08025BBE 9402     str     r4,[sp,8h]                              
08025BC0 2012     mov     r0,12h                                  
08025BC2 2102     mov     r1,2h                                   
08025BC4 1C32     mov     r2,r6                                   
08025BC6 1C2B     mov     r3,r5       ;生产第二精灵12-2  头球2                           
08025BC8 F7E8FB46 bl      800E258h                                
08025BCC 4643     mov     r3,r8                                   
08025BCE 9300     str     r3,[sp]                                 
08025BD0 9701     str     r7,[sp,4h]                              
08025BD2 9402     str     r4,[sp,8h]                              
08025BD4 2012     mov     r0,12h                                  
08025BD6 2103     mov     r1,3h                                   
08025BD8 1C32     mov     r2,r6                                   
08025BDA 1C2B     mov     r3,r5                                   
08025BDC F7E8FB3C bl      800E258h    ;生产第二精灵12-3 头球1                           
08025BE0 4640     mov     r0,r8                                   
08025BE2 9000     str     r0,[sp]                                 
08025BE4 9701     str     r7,[sp,4h]                              
08025BE6 9402     str     r4,[sp,8h]                              
08025BE8 2012     mov     r0,12h                                  
08025BEA 2104     mov     r1,4h                                   
08025BEC 1C32     mov     r2,r6                                   
08025BEE 1C2B     mov     r3,r5                                   
08025BF0 F7E8FB32 bl      800E258h    ;生产第二精灵12-4 壳

@@end:                               
08025BF4 B003     add     sp,0Ch                                  
08025BF6 BC08     pop     r3                                      
08025BF8 4698     mov     r8,r3                                   
08025BFA BCF0     pop     r4-r7                                   
08025BFC BC01     pop     r0                                      
08025BFE 4700     bx      r0                                      
////////////////////////////////////////////////////////////////////////////////////

;pose F                                 ;正常pose 待机
08025C14 B510     push    r4,r14                                  
08025C16 1C04     mov     r4,r0                                   
08025C18 F7FFFF04 bl      8025A24h      ;腹部大脑调色变化???                             
08025C1C 4908     ldr     r1,=30013D4h                            
08025C1E 8920     ldrh    r0,[r4,8h]    ;精灵X坐标                          
08025C20 8A4A     ldrh    r2,[r1,12h]   ;S X坐标                          
08025C22 4290     cmp     r0,r2         ;如果精灵在S的左边                          
08025C24 D908     bls     @@end                                
08025C26 8A49     ldrh    r1,[r1,12h]   ;精灵坐标减去 S X坐标                          
08025C28 1A40     sub     r0,r0,r1                                
08025C2A 4906     ldr     r1,=13Fh                                
08025C2C 4288     cmp     r0,r1                                   
08025C2E DC03     bgt     @@end         ;如果距离大于13Fh结束                        
08025C30 4805     ldr     r0,=3000738h                            
08025C32 3024     add     r0,24h                                  
08025C34 2126     mov     r1,26h                                  
08025C36 7001     strb    r1,[r0]       ;pose写入26h

@@end                               
08025C38 BC10     pop     r4                                      
08025C3A BC01     pop     r0                                      
08025C3C 4700     bx      r0                                      


;pose 8h                              ;前冲结束
08025C4C 4904     ldr     r1,=82DB100h                            
08025C4E 6001     str     r1,[r0]                                 
08025C50 2100     mov     r1,0h                                   
08025C52 7301     strb    r1,[r0,0Ch] ;718写入0                           
08025C54 8081     strh    r1,[r0,4h]  ;710写入0                            
08025C56 4803     ldr     r0,=3000738h                            
08025C58 3024     add     r0,24h                                  
08025C5A 2109     mov     r1,9h        ;pose写入9h                             
08025C5C 7001     strb    r1,[r0]                                 
08025C5E 4770     bx      r14                                     


;pose 9h                                ;待机
08025C68 B500     push    r14                                     
08025C6A F7FFFEDB bl      8025A24h      ;调色变化??                            
08025C6E BC01     pop     r0                                      
08025C70 4700     bx      r0                                     


;pose 22h                               ;击退准备
08025C74 B500     push    r14                                     
08025C76 1C01     mov     r1,r0                                   
08025C78 6808     ldr     r0,[r1]       ;读取70c处OAM                             
08025C7A 4A06     ldr     r2,=82DB128h                            
08025C7C 4290     cmp     r0,r2         ;如果等于2DB128h 后退的OAM                         
08025C7E D003     beq     @@Pass                                
08025C80 600A     str     r2,[r1]       ;写入新OAM                          
08025C82 2000     mov     r0,0h                                   
08025C84 7308     strb    r0,[r1,0Ch]   ;归零                          
08025C86 8088     strh    r0,[r1,4h] 

@@Pass:                             
08025C88 4803     ldr     r0,=3000738h                            
08025C8A 3024     add     r0,24h                                  
08025C8C 2123     mov     r1,23h                                  
08025C8E 7001     strb    r1,[r0]       ;pose写入23h                            
08025C90 BC01     pop     r0                                      
08025C92 4700     bx      r0                                      


;pose 23h                              ;后退过程 
08025C9C B510     push    r4,r14                                  
08025C9E 1C04     mov     r4,r0                                   
08025CA0 F7FFFEC0 bl      8025A24h     ;调色变化                           
08025CA4 4A0C     ldr     r2,=3000738h                            
08025CA6 1C11     mov     r1,r2                                   
08025CA8 312C     add     r1,2Ch                                  
08025CAA 7808     ldrb    r0,[r1]      ;读取3000764的值  在壳的地方写入了10h?                            
08025CAC 3801     sub     r0,1h        ;减1再写入                           
08025CAE 7008     strb    r0,[r1]                                 
08025CB0 0600     lsl     r0,r0,18h                               
08025CB2 0E00     lsr     r0,r0,18h                               
08025CB4 28FF     cmp     r0,0FFh                                 
08025CB6 D01E     beq     @@764FF                                
08025CB8 8811     ldrh    r1,[r2]      ;读取取向                            
08025CBA 2040     mov     r0,40h                                  
08025CBC 4008     and     r0,r1        ;和40 and                           
08025CBE 2800     cmp     r0,0h                                   
08025CC0 D00E     beq     @@764FFOrLeftFace                                
08025CC2 8921     ldrh    r1,[r4,8h]   ;当前的坐标                           
08025CC4 8910     ldrh    r0,[r2,8h]   ;备份的X原坐标                           
08025CC6 4B05     ldr     r3,=0FFFFFEC0h                          
08025CC8 18C0     add     r0,r0,r3     ;原坐标减去140h的感觉                           
08025CCA 4281     cmp     r1,r0        ;当前坐标小于原坐标减去140h的坐标.原坐标左边5格                           
08025CCC DB17     blt     @@end                                
08025CCE 88D0     ldrh    r0,[r2,6h]   ;读取在壳写入的打击狠度值                           
08025CD0 1A08     sub     r0,r1,r0     ;减去当前坐标                           
08025CD2 8120     strh    r0,[r4,8h]   ;再写入当前坐标                           
08025CD4 E013     b       @@end                                

@@764FFOrLeftFace:                               
08025CE0 8921     ldrh    r1,[r4,8h]   ;读取当前坐标                           
08025CE2 8910     ldrh    r0,[r2,8h]   ;读取备份的原坐标                           
08025CE4 23B0     mov     r3,0B0h                                 
08025CE6 009B     lsl     r3,r3,2h     ;2C0h  = 11格                         
08025CE8 18C0     add     r0,r0,r3     ;加上原坐标                           
08025CEA 4281     cmp     r1,r0        ;当前坐标比较是否到了原坐标的右11格                           
08025CEC DC07     bgt     @@end        ;大于则结束    意味着无法后退了                    
08025CEE 88D0     ldrh    r0,[r2,6h]   ;读取打击狠度值                           
08025CF0 1808     add     r0,r1,r0     ;加上当前坐标   向后被击退                         
08025CF2 8120     strh    r0,[r4,8h]   ;写入当前坐标                           
08025CF4 E003     b       @@end

@@764FF:                                
08025CF6 1C11     mov     r1,r2                                   
08025CF8 3124     add     r1,24h                                  
08025CFA 2024     mov     r0,24h       ;光束击退1/4格 导弹1格,超导2格则结束                           
08025CFC 7008     strb    r0,[r1]      ;pose 写入24h

@@end:                                
08025CFE BC10     pop     r4                                      
08025D00 BC01     pop     r0                                      
08025D02 4700     bx      r0  

;pose 24h                                 ;前冲准备   
08025D04 4904     ldr     r1,=82DB100h    ;正常的OAM                        
08025D06 6001     str     r1,[r0]         ;写入70C                        
08025D08 2100     mov     r1,0h                                   
08025D0A 7301     strb    r1,[r0,0Ch]                             
08025D0C 8081     strh    r1,[r0,4h]      ;归零                        
08025D0E 4803     ldr     r0,=3000738h                            
08025D10 3024     add     r0,24h                                  
08025D12 2125     mov     r1,25h          ;pose写入25h                        
08025D14 7001     strb    r1,[r0]                                 
08025D16 4770     bx      r14                                     


;pose 25h                                 ;前冲待机
08025D20 B500     push    r14                                     
08025D22 F7FFFE7F bl      8025A24h        ;调色板变化                          
08025D26 4907     ldr     r1,=3000738h                            
08025D28 1C0A     mov     r2,r1                                   
08025D2A 322D     add     r2,2Dh          ;读取在壳时写入的打击次数8倍,原次数上限8                        
08025D2C 7810     ldrb    r0,[r2]                                 
08025D2E 3801     sub     r0,1h                                   
08025D30 7010     strb    r0,[r2]         ;减1再写入                        
08025D32 0600     lsl     r0,r0,18h                               
08025D34 0E00     lsr     r0,r0,18h                               
08025D36 28FF     cmp     r0,0FFh         ;当被减完                        
08025D38 D102     bne     @@end                                
08025D3A 3124     add     r1,24h                                  
08025D3C 2026     mov     r0,26h          ;pose写入26h                         
08025D3E 7008     strb    r0,[r1]

@@end:                                 
08025D40 BC01     pop     r0                                      
08025D42 4700     bx      r0                                      


;pose 26h                                ;翘头
08025D48 B510     push    r4,r14                                  
08025D4A 490A     ldr     r1,=82DB1D0h   ;前冲翘头OAM                         
08025D4C 6001     str     r1,[r0]        ;写入70C                         
08025D4E 2100     mov     r1,0h                                   
08025D50 7301     strb    r1,[r0,0Ch]                             
08025D52 2400     mov     r4,0h                                   
08025D54 8081     strh    r1,[r0,4h]     ;归零                         
08025D56 4A08     ldr     r2,=3000738h                            
08025D58 1C13     mov     r3,r2                                   
08025D5A 3324     add     r3,24h                                  
08025D5C 2127     mov     r1,27h                                  
08025D5E 7019     strb    r1,[r3]        ;pose 写入27h                           
08025D60 322C     add     r2,2Ch                                  
08025D62 213C     mov     r1,3Ch                                  
08025D64 7011     strb    r1,[r2]        ;3000764写入3Ch                           
08025D66 7344     strb    r4,[r0,0Dh]    ;3000719写入0,打击值                        
08025D68 20AD     mov     r0,0ADh        ;翘头叫声                         
08025D6A F7DCFE55 bl      8002A18h                                
08025D6E BC10     pop     r4                                      
08025D70 BC01     pop     r0                                      
08025D72 4700     bx      r0                                      

;pose 27h                                ;翘头待机
08025D7C B510     push    r4,r14                                  
08025D7E 1C04     mov     r4,r0                                   
08025D80 F7FFFE50 bl      8025A24h       ;调色板改变                             
08025D84 1C20     mov     r0,r4                                   
08025D86 F7EAF811 bl      800FDACh       ;检查动画结束                         
08025D8A 2800     cmp     r0,0h                                   
08025D8C D003     beq     @@end                                
08025D8E 4803     ldr     r0,=3000738h                            
08025D90 3024     add     r0,24h                                  
08025D92 2128     mov     r1,28h                                  
08025D94 7001     strb    r1,[r0]        ;pose写入28h

@@end:                                
08025D96 BC10     pop     r4                                      
08025D98 BC01     pop     r0                                      
08025D9A 4700     bx      r0                                      


;pose 28h                  
08025DA0 B500     push    r14                                     
08025DA2 4907     ldr     r1,=82DB0A0h   ;前冲OAM                         
08025DA4 6001     str     r1,[r0]        ;写入300070C                         
08025DA6 2100     mov     r1,0h                                   
08025DA8 7301     strb    r1,[r0,0Ch]                             
08025DAA 8081     strh    r1,[r0,4h]     ;归零                         
08025DAC 4805     ldr     r0,=3000738h                            
08025DAE 3024     add     r0,24h                                  
08025DB0 2129     mov     r1,29h         ;pose写入29h                         
08025DB2 7001     strb    r1,[r0]                                 
08025DB4 20AE     mov     r0,0AEh        ;前冲声                         
08025DB6 F7DCFE2F bl      8002A18h                                
08025DBA BC01     pop     r0                                      
08025DBC 4700     bx      r0                                      


;pose 29h                               ;前冲过程
08025DC8 B510     push    r4,r14                                  
08025DCA 1C04     mov     r4,r0                                   
08025DCC F7FFFE2A bl      8025A24h                                
08025DD0 4A0B     ldr     r2,=3000738h                            
08025DD2 8811     ldrh    r1,[r2]                                 
08025DD4 2040     mov     r0,40h                                  
08025DD6 4008     and     r0,r1         ;取向 and 40                           
08025DD8 2800     cmp     r0,0h                                   
08025DDA D013     beq     @@FaceLeft                                
08025DDC 8920     ldrh    r0,[r4,8h]    ;读取当前X坐标                          
08025DDE 3008     add     r0,8h         ;加上8h        //////////////                  
08025DE0 8120     strh    r0,[r4,8h]    ;再写入                          
08025DE2 8911     ldrh    r1,[r2,8h]    ;读取备份的原X坐标                          
08025DE4 0400     lsl     r0,r0,10h                               
08025DE6 0C00     lsr     r0,r0,10h                               
08025DE8 4288     cmp     r0,r1         ;比较当前坐标是否小于原X坐标                          
08025DEA D31C     bcc     @@end                                
08025DEC 8121     strh    r1,[r4,8h]    ;大于则写入原X坐标                          
08025DEE 1C11     mov     r1,r2                                   
08025DF0 3124     add     r1,24h                                  
08025DF2 2008     mov     r0,8h                                   
08025DF4 7008     strb    r0,[r1]       ;pose写入8h                           
08025DF6 20AE     mov     r0,0AEh       ;奔走声                          
08025DF8 210A     mov     r1,0Ah        ;继续播放0A帧                          
08025DFA F7DCFF41 bl      8002C80h                                
08025DFE E012     b       @@end                                

@@FaceLeft:                              
08025E04 8920     ldrh    r0,[r4,8h]                              
08025E06 3808     sub     r0,8h                                   
08025E08 8120     strh    r0,[r4,8h]                              
08025E0A 8911     ldrh    r1,[r2,8h]                              
08025E0C 0400     lsl     r0,r0,10h                               
08025E0E 0C00     lsr     r0,r0,10h                               
08025E10 4288     cmp     r0,r1                                   
08025E12 D808     bhi     @@end                                
08025E14 8121     strh    r1,[r4,8h]                              
08025E16 1C11     mov     r1,r2                                   
08025E18 3124     add     r1,24h                                  
08025E1A 2008     mov     r0,8h                                   
08025E1C 7008     strb    r0,[r1]                                 
08025E1E 20AE     mov     r0,0AEh                                 
08025E20 210A     mov     r1,0Ah                                  
08025E22 F7DCFF2D bl      8002C80h  

@@end:                              
08025E26 BC10     pop     r4                                      
08025E28 BC01     pop     r0                                      
08025E2A 4700     bx      r0 

;pose 42h                                     
08025E2C B510     push    r4,r14                                  
08025E2E 490B     ldr     r1,=82DB220h   ;受创OAM                         
08025E30 6001     str     r1,[r0]                                 
08025E32 2100     mov     r1,0h                                   
08025E34 7301     strb    r1,[r0,0Ch]                             
08025E36 2400     mov     r4,0h                                   
08025E38 8081     strh    r1,[r0,4h]                              
08025E3A 4A09     ldr     r2,=3000738h                            
08025E3C 1C13     mov     r3,r2                                   
08025E3E 3324     add     r3,24h                                  
08025E40 2143     mov     r1,43h        ;pose写入43h                           
08025E42 7019     strb    r1,[r3]                                 
08025E44 322C     add     r2,2Ch                                  
08025E46 212F     mov     r1,2Fh                                  
08025E48 7011     strb    r1,[r2]       ;3000764写入2Fh                          
08025E4A 7344     strb    r4,[r0,0Dh]   ;打击次数写入0                          
08025E4C 20AE     mov     r0,0AEh                                 
08025E4E 210A     mov     r1,0Ah                                  
08025E50 F7DCFF16 bl      8002C80h      ;前冲音继续播放A帧                          
08025E54 BC10     pop     r4                                      
08025E56 BC01     pop     r0                                      
08025E58 4700     bx      r0                                      


;pose 43h                              ;受创待机
08025E64 B500     push    r14                                     
08025E66 4A07     ldr     r2,=3000738h                            
08025E68 1C11     mov     r1,r2                                   
08025E6A 312C     add     r1,2Ch                                  
08025E6C 7808     ldrb    r0,[r1]                                 
08025E6E 3801     sub     r0,1h                                   
08025E70 7008     strb    r0,[r1]      ;读取3000764减1再写入                            
08025E72 0600     lsl     r0,r0,18h                               
08025E74 2800     cmp     r0,0h                                   
08025E76 D102     bne     @@end                                
08025E78 3908     sub     r1,8h                                   
08025E7A 2028     mov     r0,28h       ;pose写入28h                            
08025E7C 7008     strb    r0,[r1]

@@end:                                 
08025E7E BC01     pop     r0                                      
08025E80 4700     bx      r0                                      


;pose 62h                      
08025E88 B510     push    r4,r14                                  
08025E8A 4916     ldr     r1,=82DB188h   ;死亡OAM                        
08025E8C 6001     str     r1,[r0]                                 
08025E8E 2100     mov     r1,0h                                   
08025E90 7301     strb    r1,[r0,0Ch]                             
08025E92 8081     strh    r1,[r0,4h]                              
08025E94 4C14     ldr     r4,=3000738h                            
08025E96 1C21     mov     r1,r4                                   
08025E98 3124     add     r1,24h                                  
08025E9A 2067     mov     r0,67h        ;pose写入67h                          
08025E9C 7008     strb    r0,[r1]                                 
08025E9E 3108     add     r1,8h                                   
08025EA0 2064     mov     r0,64h                                  
08025EA2 7008     strb    r0,[r1]       ;3000764写入64h                          
08025EA4 1C22     mov     r2,r4                                   
08025EA6 322B     add     r2,2Bh                                  
08025EA8 7811     ldrb    r1,[r2]                                 
08025EAA 2080     mov     r0,80h                                  
08025EAC 4008     and     r0,r1         ;无敌时间80 and 清零                           
08025EAE 2164     mov     r1,64h                                  
08025EB0 4308     orr     r0,r1         ;再orr64写入                          
08025EB2 7010     strb    r0,[r2]                                
08025EB4 8821     ldrh    r1,[r4]                                 
08025EB6 2280     mov     r2,80h                                  
08025EB8 0212     lsl     r2,r2,8h                                
08025EBA 1C10     mov     r0,r2                                   
08025EBC 4308     orr     r0,r1         ;取向orr8000 =无敌                           
08025EBE 8020     strh    r0,[r4]       ;再写入                          
08025EC0 2001     mov     r0,1h         ;血量写入1                          
08025EC2 82A0     strh    r0,[r4,14h]                             
08025EC4 20AE     mov     r0,0AEh       ;前冲声???                          
08025EC6 210A     mov     r1,0Ah                                  
08025EC8 F7DCFEDA bl      8002C80h                                
08025ECC 20B0     mov     r0,0B0h       ;死亡音                            
08025ECE F7DCFDA3 bl      8002A18h                                
08025ED2 7F60     ldrb    r0,[r4,1Dh]                             
08025ED4 284D     cmp     r0,4Dh                                 
08025ED6 D102     bne     @@No4D                                
08025ED8 200A     mov     r0,0Ah        ;房间声音,反正很快就变了                          
08025EDA F7DDFDDD bl      8003A98h

@@No4D:                                
08025EDE BC10     pop     r4                                      
08025EE0 BC01     pop     r0                                      
08025EE2 4700     bx      r0                                      


;pose 67h                             
08025EEC B500     push    r14           ;死亡爆炸待机                          
08025EEE 4908     ldr     r1,=3000738h                            
08025EF0 1C0A     mov     r2,r1                                   
08025EF2 322C     add     r2,2Ch                                  
08025EF4 7810     ldrb    r0,[r2]       ;764的值减1再写入                          
08025EF6 3801     sub     r0,1h                                   
08025EF8 7010     strb    r0,[r2]                                 
08025EFA 0600     lsl     r0,r0,18h                               
08025EFC 2800     cmp     r0,0h                                   
08025EFE D105     bne     @@end                                
08025F00 1C08     mov     r0,r1                                   
08025F02 3024     add     r0,24h        ;pose写入68h                           
08025F04 2168     mov     r1,68h                                  
08025F06 7001     strb    r1,[r0]                                 
08025F08 2002     mov     r0,2h                                   
08025F0A 7010     strb    r0,[r2]       ;764写入2h

@end:                                
08025F0C BC01     pop     r0                                      
08025F0E 4700     bx      r0                                      


;pose 68h                             
08025F14 B510     push    r4,r14                                  
08025F16 B081     add     sp,-4h                                  
08025F18 4C13     ldr     r4,=3000738h                            
08025F1A 1C21     mov     r1,r4                                   
08025F1C 312C     add     r1,2Ch                                  
08025F1E 7808     ldrb    r0,[r1]     ;764减1再写入                            
08025F20 3801     sub     r0,1h                                   
08025F22 7008     strb    r0,[r1]                                 
08025F24 0600     lsl     r0,r0,18h                               
08025F26 2800     cmp     r0,0h                                   
08025F28 D11A     bne     @@end                                
08025F2A 7F60     ldrb    r0,[r4,1Dh]                             
08025F2C 284D     cmp     r0,4Dh                                  
08025F2E D10C     bne     @@SpriteNo4D                                
08025F30 2001     mov     r0,1h                                   
08025F32 2120     mov     r1,20h                                  
08025F34 F03AFCC2 bl      80608BCh    ;虫死事件写入                           
08025F38 490C     ldr     r1,=300007Bh                            
08025F3A 223C     mov     r2,3Ch                                  
08025F3C 4252     neg     r2,r2                                   
08025F3E 1C10     mov     r0,r2                                   
08025F40 7008     strb    r0,[r1]     ;写入门开计时                             
08025F42 200B     mov     r0,0Bh                                  
08025F44 2100     mov     r1,0h                                   
08025F46 F7DDFD55 bl      80039F4h    ;boss死后的房间声音

@@SpriteNo4D:                               
08025F4A 8861     ldrh    r1,[r4,2h]                              
08025F4C 3924     sub     r1,24h      ;Y坐标减去24h                            
08025F4E 0409     lsl     r1,r1,10h                               
08025F50 0C09     lsr     r1,r1,10h                               
08025F52 88A2     ldrh    r2,[r4,4h]  ;X坐标                            
08025F54 2022     mov     r0,22h                                  
08025F56 9000     str     r0,[sp]                                 
08025F58 2000     mov     r0,0h                                   
08025F5A 2300     mov     r3,0h                                   
08025F5C F7EBF892 bl      8011084h    ;掉落例程

@@end:                                
08025F60 B001     add     sp,4h                                   
08025F62 BC10     pop     r4                                      
08025F64 BC01     pop     r0                                      
08025F66 4700     bx      r0                                      
////////////////////////////////////////////////////////////////////////////////////////////////////////
;副精灵pose0                              
08025F70 B510     push    r4,r14                                  
08025F72 4A08     ldr     r2,=3000738h                            
08025F74 8810     ldrh    r0,[r2]                                 
08025F76 4908     ldr     r1,=0FFFBh                              
08025F78 4001     and     r1,r0                                   
08025F7A 8011     strh    r1,[r2]       ;取向去4h 再写入                          
08025F7C 2001     mov     r0,1h                                   
08025F7E 8290     strh    r0,[r2,14h]   ;血量写入1                           
08025F80 7F90     ldrb    r0,[r2,1Eh]   ;读取副精灵data                          
08025F82 4694     mov     r12,r2                                  
08025F84 2804     cmp     r0,4h                                   
08025F86 D900     bls     @@Pass                                
08025F88 E0D2     b       @@Death

@@Pass:                                
08025F8A 0080     lsl     r0,r0,2h      ;精灵date乘以4                          
08025F8C 4903     ldr     r1,=8025FA0h  ;TimesTable                          
08025F8E 1840     add     r0,r0,r1      ;加上偏移值                          
08025F90 6800     ldr     r0,[r0]                                 
08025F92 4687     mov     r15,r0  

TimesTable:
    .word 80260e4h
	.word 8025fb4h
	.word 8025ff0h
	.word 802602ch
	.word 802607ch
	                             
;Times1                          
08025FB4 4660     mov     r0,r12                                  
08025FB6 8801     ldrh    r1,[r0]     ;读取取向                            
08025FB8 2280     mov     r2,80h                                  
08025FBA 0212     lsl     r2,r2,8h    ;8000h                             
08025FBC 1C10     mov     r0,r2                                   
08025FBE 2200     mov     r2,0h                                   
08025FC0 2300     mov     r3,0h                                   
08025FC2 4308     orr     r0,r1       ;取向orr8000h                            
08025FC4 4664     mov     r4,r12                                  
08025FC6 8020     strh    r0,[r4]     ;再写入                            
08025FC8 4660     mov     r0,r12                                  
08025FCA 3027     add     r0,27h                                  
08025FCC 2110     mov     r1,10h                                  
08025FCE 7001     strb    r1,[r0]     ;300075f写入10                            
08025FD0 3001     add     r0,1h                                   
08025FD2 7001     strb    r1,[r0]     ;3000760写入10                            
08025FD4 3001     add     r0,1h                                   
08025FD6 7001     strb    r1,[r0]     ;3000761写入10                            
08025FD8 4903     ldr     r1,=0FFFCh                             
08025FDA 8161     strh    r1,[r4,0Ah]                             
08025FDC 2004     mov     r0,4h                                   
08025FDE 81A0     strh    r0,[r4,0Ch]                             
08025FE0 81E1     strh    r1,[r4,0Eh]                             
08025FE2 8220     strh    r0,[r4,10h]  ;四面分界                            
08025FE4 4801     ldr     r0,=82DD670h                            
08025FE6 E03A     b       @@Goto                                

;Times2                              
08025FF0 4660     mov     r0,r12                                  
08025FF2 8801     ldrh    r1,[r0]                                 
08025FF4 2280     mov     r2,80h                                  
08025FF6 0212     lsl     r2,r2,8h                                
08025FF8 1C10     mov     r0,r2                                   
08025FFA 2200     mov     r2,0h                                   
08025FFC 2300     mov     r3,0h                                   
08025FFE 4308     orr     r0,r1         ;取向orr8000再写入                            
08026000 4664     mov     r4,r12                                  
08026002 8020     strh    r0,[r4]                                 
08026004 4660     mov     r0,r12                                  
08026006 3027     add     r0,27h                                  
08026008 2110     mov     r1,10h                                  
0802600A 7001     strb    r1,[r0]       ;视野判定写入                            
0802600C 3001     add     r0,1h                                   
0802600E 7001     strb    r1,[r0]                                  
08026010 3001     add     r0,1h                                   
08026012 7001     strb    r1,[r0]                                 
08026014 4903     ldr     r1,=0FFFCh                              
08026016 8161     strh    r1,[r4,0Ah]                             
08026018 2004     mov     r0,4h                                   
0802601A 81A0     strh    r0,[r4,0Ch]                             
0802601C 81E1     strh    r1,[r4,0Eh]                             
0802601E 8220     strh    r0,[r4,10h]  ;四面分界写入                           
08026020 4801     ldr     r0,=82DD660h                            
08026022 E01C     b       @@Goto                                

;Times3                              
0802602C 4660     mov     r0,r12                                  
0802602E 8801     ldrh    r1,[r0]                                 
08026030 2280     mov     r2,80h                                  
08026032 0212     lsl     r2,r2,8h                                
08026034 1C10     mov     r0,r2                                   
08026036 2200     mov     r2,0h                                   
08026038 2300     mov     r3,0h                                   
0802603A 4308     orr     r0,r1                                   
0802603C 4664     mov     r4,r12                                  
0802603E 8020     strh    r0,[r4]     ;取向写入无敌                              
08026040 4660     mov     r0,r12                                  
08026042 3027     add     r0,27h                                  
08026044 2110     mov     r1,10h                                  
08026046 7001     strb    r1,[r0]                                 
08026048 3001     add     r0,1h                                   
0802604A 7001     strb    r1,[r0]                                 
0802604C 3001     add     r0,1h                                   
0802604E 7001     strb    r1,[r0]     ;视野判定写入                            
08026050 4908     ldr     r1,=0FFFCh                              
08026052 8161     strh    r1,[r4,0Ah]                             
08026054 2004     mov     r0,4h                                   
08026056 81A0     strh    r0,[r4,0Ch]                             
08026058 81E1     strh    r1,[r4,0Eh]                             
0802605A 8220     strh    r0,[r4,10h] ;四面分界写入                            
0802605C 4806     ldr     r0,=82DD650h 

@@Goto:                           
0802605E 61A0     str     r0,[r4,18h]   ;写入OAM                          
08026060 7722     strb    r2,[r4,1Ch]                             
08026062 82E3     strh    r3,[r4,16h]                             
08026064 4660     mov     r0,r12                                  
08026066 3025     add     r0,25h                                  
08026068 7002     strb    r2,[r0]       ;属性写入0h                           
0802606A 4661     mov     r1,r12                                  
0802606C 3124     add     r1,24h        ;pose写入9h                           
0802606E 2009     mov     r0,9h                                   
08026070 7008     strb    r0,[r1]                                 
08026072 E05F     b       @@end                                

;Times4 壳                             
0802607C 4662     mov     r2,r12                                  
0802607E 3227     add     r2,27h                                  
08026080 2100     mov     r1,0h                                   
08026082 2030     mov     r0,30h                                  
08026084 7010     strb    r0,[r2]      ;300075f写入30h                            
08026086 4660     mov     r0,r12                                  
08026088 3028     add     r0,28h                                  
0802608A 7001     strb    r1,[r0]      ;3000760写入0h                            
0802608C 3202     add     r2,2h                                   
0802608E 2038     mov     r0,38h                                  
08026090 7010     strb    r0,[r2]      ;3000761写入38h                           
08026092 2200     mov     r2,0h                                   
08026094 4806     ldr     r0,=0FF50h                              
08026096 4663     mov     r3,r12                                  
08026098 8158     strh    r0,[r3,0Ah]  ;上部分界写入FF50h                           
0802609A 8199     strh    r1,[r3,0Ch]  ;下部分界写入0                           
0802609C 8819     ldrh    r1,[r3]                                 
0802609E 2040     mov     r0,40h                                  
080260A0 4008     and     r0,r1                                   
080260A2 2800     cmp     r0,0h                                   
080260A4 D008     beq     @@LeftFace                                
080260A6 4803     ldr     r0,=0FF58h                              
080260A8 81D8     strh    r0,[r3,0Eh]                             
080260AA 2098     mov     r0,98h                                  
080260AC 8218     strh    r0,[r3,10h]  ;四面分界                           
080260AE E008     b       @@Peer                                

@@LeftFace:                               
080260B8 4809     ldr     r0,=0FF68h                              
080260BA 4664     mov     r4,r12                                  
080260BC 81E0     strh    r0,[r4,0Eh]                             
080260BE 20A8     mov     r0,0A8h                                 
080260C0 8220     strh    r0,[r4,10h] 

@@Peer:                            
080260C2 4661     mov     r1,r12                                  
080260C4 3125     add     r1,25h                                  
080260C6 200A     mov     r0,0Ah                                  
080260C8 7008     strb    r0,[r1]     ;属性写入Ah                              
080260CA 3903     sub     r1,3h                                   
080260CC 2005     mov     r0,5h                                   
080260CE 7008     strb    r0,[r1]     ;300075A写入5h                            
080260D0 3102     add     r1,2h                                   
080260D2 2042     mov     r0,42h                                  
080260D4 7008     strb    r0,[r1]     ;pose写入42h                            
080260D6 20FF     mov     r0,0FFh                                 
080260D8 4661     mov     r1,r12                                  
080260DA 8288     strh    r0,[r1,14h] ;写入写入FFh                            
080260DC E02A     b       @@end                                

;Times0           小脚                     
080260E4 4662     mov     r2,r12                                  
080260E6 8811     ldrh    r1,[r2]                                 
080260E8 2380     mov     r3,80h                                  
080260EA 021B     lsl     r3,r3,8h                                
080260EC 1C18     mov     r0,r3                                   
080260EE 2200     mov     r2,0h                                   
080260F0 4308     orr     r0,r1                                   
080260F2 4664     mov     r4,r12                                  
080260F4 8020     strh    r0,[r4]     ;取向写入无敌                            
080260F6 4661     mov     r1,r12                                  
080260F8 3127     add     r1,27h                                  
080260FA 2018     mov     r0,18h                                  
080260FC 7008     strb    r0,[r1]     ;300075f写入18h                            
080260FE 4660     mov     r0,r12                                  
08026100 3028     add     r0,28h                                  
08026102 7002     strb    r2,[r0]     ;3000760写入0                            
08026104 3102     add     r1,2h                                   
08026106 2028     mov     r0,28h      ;3000761写入28h                           
08026108 7008     strb    r0,[r1]                                 
0802610A 4908     ldr     r1,=0FFFCh                              
0802610C 8161     strh    r1,[r4,0Ah]                             
0802610E 2004     mov     r0,4h                                   
08026110 81A0     strh    r0,[r4,0Ch]                             
08026112 81E1     strh    r1,[r4,0Eh]                             
08026114 8220     strh    r0,[r4,10h] ;四面分界                            
08026116 4660     mov     r0,r12                                  
08026118 3025     add     r0,25h                                  
0802611A 7002     strb    r2,[r0]     ;属性写入0                            
0802611C 4661     mov     r1,r12                                  
0802611E 3122     add     r1,22h                                  
08026120 2003     mov     r0,3h       ;300075A写入3h                            
08026122 7008     strb    r0,[r1]                                 
08026124 3102     add     r1,2h                                   
08026126 2060     mov     r0,60h                                  
08026128 7008     strb    r0,[r1]     ;pose写入60h                             
0802612A E003     b       @@end                                

@@Death:                                
08026130 2000     mov     r0,0h                                   
08026132 8010     strh    r0,[r2]     ;取消精灵

@@end:                                
08026134 BC10     pop     r4                                      
08026136 BC01     pop     r0                                      
08026138 4700     bx      r0                                      

;副精灵pose42  壳                              
0802613C B5F0     push    r4-r7,r14                               
0802613E 1C05     mov     r5,r0                                   
08026140 481B     ldr     r0,=3000738h                            
08026142 3023     add     r0,23h                                  
08026144 7806     ldrb    r6,[r0]       ;读取主精灵序号                          
08026146 491B     ldr     r1,=30001ACh                            
08026148 00F0     lsl     r0,r6,3h                                
0802614A 1B80     sub     r0,r0,r6                                
0802614C 00C0     lsl     r0,r0,3h                                
0802614E 1840     add     r0,r0,r1                                
08026150 3024     add     r0,24h                                  
08026152 7800     ldrb    r0,[r0]      ;读取主精灵pose                           
08026154 2809     cmp     r0,9h                                   
08026156 D003     beq     @@MainSpritePose9or25                                
08026158 2825     cmp     r0,25h                                  
0802615A D001     beq     @@MainSpritePose9or25                                
0802615C 280F     cmp     r0,0Fh                                  
0802615E D110     bne     @@Pass  

@@MainSpritePose9or25:                              
08026160 4A13     ldr     r2,=3000738h                            
08026162 8AD1     ldrh    r1,[r2,16h]  ;读取动画                            
08026164 2001     mov     r0,1h                                   
08026166 4008     and     r0,r1                                   
08026168 2800     cmp     r0,0h        ;查看是否是奇数?                           
0802616A D00A     beq     @@Pass       ;不是则跳过                         
0802616C 7F10     ldrb    r0,[r2,1Ch]  ;读取动画帧                           
0802616E 2801     cmp     r0,1h        ;查看是否是1                           
08026170 D107     bne     @@Pass       ;不是则跳过                        
08026172 8811     ldrh    r1,[r2]      ;读取取向                           
08026174 2002     mov     r0,2h                                   
08026176 4008     and     r0,r1                                   
08026178 2800     cmp     r0,0h                                   
0802617A D002     beq     @@Pass       ;不在视野内则结束                         
0802617C 20AA     mov     r0,0AAh                                 
0802617E F7DCFC4B bl      8002A18h     ;播放虫的声音

@@Pass:                              
08026182 4A0C     ldr     r2,=30001ACh                            
08026184 00F1     lsl     r1,r6,3h                                
08026186 1B88     sub     r0,r1,r6                                
08026188 00C0     lsl     r0,r0,3h     ;序号的56倍                           
0802618A 1880     add     r0,r0,r2                                
0802618C 7F40     ldrb    r0,[r0,1Dh]  ;读取主精灵的ID                           
0802618E 1C0F     mov     r7,r1                                   
08026190 288B     cmp     r0,8Bh                                  
08026192 D12B     bne     @@Sprite4D                                
08026194 892B     ldrh    r3,[r5,8h]   ;读取X坐标                           
08026196 1C19     mov     r1,r3                                   
08026198 39D0     sub     r1,0D0h      ;减去0D0h                           
0802619A 4807     ldr     r0,=30013D4h                            
0802619C 8A42     ldrh    r2,[r0,12h]  ;读取人物X坐标                           
0802619E 4291     cmp     r1,r2        ;虫左边0D0距离坐标和人物X坐标比较                           
080261A0 DA0E     bge     @@Come       ;大于等于跳转  不在虫脸前  ?                       
080261A2 1C18     mov     r0,r3                                   
080261A4 3060     add     r0,60h       ;X坐标加60h                           
080261A6 4290     cmp     r0,r2        ;虫右边60距离坐标和人物X坐标比较                           
080261A8 DD0A     ble     @@Come       ;小于或等于跳转  在虫后 ?                          
080261AA 4901     ldr     r1,=3000738h                            
080261AC 4803     ldr     r0,=0FFE0h                              
080261AE E009     b       @@Peer                                

@@Come:                                
080261C0 4909     ldr     r1,=3000738h                            
080261C2 2000     mov     r0,0h        

@@Peer:                                 
080261C4 8188     strh    r0,[r1,0Ch]  ;下部分界写入数值  基本上和虫身体重合就会写入FFE0h                          
080261C6 1C0A     mov     r2,r1                                   
080261C8 1C14     mov     r4,r2                                   
080261CA 342B     add     r4,2Bh                                  
080261CC 7823     ldrb    r3,[r4]      ;读取无敌时间                           
080261CE 207F     mov     r0,7Fh                                  
080261D0 4018     and     r0,r3                                   
080261D2 2800     cmp     r0,0h        ;如果没有无敌                            
080261D4 D06B     beq     @@end        ;跳转                           
080261D6 1C10     mov     r0,r2                                   
080261D8 3034     add     r0,34h                                  
080261DA 7801     ldrb    r1,[r0]      ;读取打击变色值                           
080261DC 3814     sub     r0,14h                                  
080261DE 7001     strb    r1,[r0]      ;写入调色板                            
080261E0 2080     mov     r0,80h                                  
080261E2 4018     and     r0,r3        ;无敌时间 and 80 =清零                           
080261E4 7020     strb    r0,[r4]      ;再写入                           
080261E6 E060     b       @@HpFullWrite                                

@@Sprite4D:                              
080261EC 490A     ldr     r1,=30013D4h                            
080261EE 8928     ldrh    r0,[r5,8h]   ;X坐标                           
080261F0 8A49     ldrh    r1,[r1,12h]  ;人物X做个表                           
080261F2 4288     cmp     r0,r1                                   
080261F4 D214     bcs     @@Right      ;在人物右边                           
080261F6 4A09     ldr     r2,=3000738h                            
080261F8 1C14     mov     r4,r2                                   
080261FA 342B     add     r4,2Bh       ;读取无敌时间                           
080261FC 7823     ldrb    r3,[r4]                                     
080261FE 207F     mov     r0,7Fh                                  
08026200 4018     and     r0,r3                                   
08026202 2800     cmp     r0,0h                                   
08026204 D053     beq     @@end        ;没有被击打则结束                         
08026206 1C10     mov     r0,r2                                   
08026208 3034     add     r0,34h                                  
0802620A 7801     ldrb    r1,[r0]      ;读取打击调色值                            
0802620C 3814     sub     r0,14h                                  
0802620E 7001     strb    r1,[r0]      ;写入调色板                           
08026210 2080     mov     r0,80h                                  
08026212 4018     and     r0,r3                                   
08026214 7020     strb    r0,[r4]      ;无敌时间清零                           
08026216 E048     b       @@HpFullWrite                                

@@Right:                               ;在人物右边实现被击退的代码???
08026220 4A0E     ldr     r2,=3000738h                            
08026222 1C10     mov     r0,r2                                   
08026224 302B     add     r0,2Bh                                  
08026226 7801     ldrb    r1,[r0]      ;读取无敌时间                           
08026228 207F     mov     r0,7Fh                                  
0802622A 4008     and     r0,r1                                   
0802622C 2800     cmp     r0,0h                                   
0802622E D03E     beq     @@end                                
08026230 7BA8     ldrb    r0,[r5,0Eh]  ;该值在冲撞的时候会为1                           
08026232 2800     cmp     r0,0h                                   
08026234 D12E     bne     @@NoBackTime                                
08026236 8A91     ldrh    r1,[r2,14h]  ;读取血量                           
08026238 20FF     mov     r0,0FFh                                 
0802623A 1A40     sub     r0,r0,r1     ;最大血量减去当前血量                           
0802623C 0400     lsl     r0,r0,10h                               
0802623E 0C00     lsr     r0,r0,10h                               
08026240 2408     mov     r4,8h                                   
08026242 2863     cmp     r0,63h                                  
08026244 D803     bhi     @@Peer2     ;伤血大于63,也就是吃了超导                           
08026246 2401     mov     r4,1h                                   
08026248 2813     cmp     r0,13h                                  
0802624A D900     bls     @@Peer2     ;小于等于14,也就是不是超导也非导弹                           
0802624C 2404     mov     r4,4h        

@@Peer2:                           
0802624E 2C01     cmp     r4,1h                                   
08026250 D906     bls     @@BeamHit                                
08026252 20AC     mov     r0,0ACh     ;导类击中的叫声                            
08026254 F7DCFBE0 bl      8002A18h                                
08026258 E005     b       @@Goto2                                

@@BeamHit:                              
08026260 20AB     mov     r0,0ABh     ;光束类击中退声                            
08026262 F7DCFBD9 bl      8002A18h       

@@Goto2:                         
08026266 7B68     ldrb    r0,[r5,0Dh] ;读取打击值                            
08026268 2807     cmp     r0,7h       ;如果大于7则跳过                            
0802626A D801     bhi     @@Pass                                
0802626C 3001     add     r0,1h       ;否则则继续增加                             
0802626E 7368     strb    r0,[r5,0Dh] ;再写入

@@Pass:                            
08026270 4910     ldr     r1,=30001ACh                            
08026272 1BB8     sub     r0,r7,r6                                
08026274 00C0     lsl     r0,r0,3h    ;主序号的56倍                            
08026276 1842     add     r2,r0,r1    ;加上偏移值                            
08026278 1C11     mov     r1,r2                                   
0802627A 312C     add     r1,2Ch                                  
0802627C 2010     mov     r0,10h                                  
0802627E 7008     strb    r0,[r1]     ;3000764写入10h                            
08026280 7B68     ldrb    r0,[r5,0Dh] ;读取打击值                            
08026282 00C0     lsl     r0,r0,3h    ;乘以8                            
08026284 1C13     mov     r3,r2                                   
08026286 332D     add     r3,2Dh      ;3000765 再生次数或时间????                            
08026288 7018     strb    r0,[r3]     ;打击值的8倍写入                            
0802628A 80D4     strh    r4,[r2,6h]  ;打击狠度写入Y再生坐标                            
0802628C 3908     sub     r1,8h                                   
0802628E 2022     mov     r0,22h                                  
08026290 7008     strb    r0,[r1]     ;主精灵pose 写入22h                        
08026292 4A09     ldr     r2,=3000738h   

@@NoBackTime:                         
08026294 1C10     mov     r0,r2                                   
08026296 3034     add     r0,34h                                  
08026298 7801     ldrb    r1,[r0]     ;打击变色值                            
0802629A 3814     sub     r0,14h                                  
0802629C 7001     strb    r1,[r0]     ;写入调色板                            
0802629E 1C13     mov     r3,r2                                   
080262A0 332B     add     r3,2Bh                                  
080262A2 7819     ldrb    r1,[r3]                                 
080262A4 2080     mov     r0,80h      ;无敌时间清零                            
080262A6 4008     and     r0,r1                                   
080262A8 7018     strb    r0,[r3]     ;再写入

@@HpFullWrite:                                 
080262AA 20FF     mov     r0,0FFh                                 
080262AC 8290     strh    r0,[r2,14h]

@@end:                             
080262AE BCF0     pop     r4-r7                                   
080262B0 BC01     pop     r0                                      
080262B2 4700     bx      r0                                      

;pose 9 头球                              
080262BC B510     push    r4,r14                                  
080262BE 1C04     mov     r4,r0                                   
080262C0 4B08     ldr     r3,=3000738h                            
080262C2 1C18     mov     r0,r3                                   
080262C4 3023     add     r0,23h                                  
080262C6 7801     ldrb    r1,[r0]      ;读取主序号                           
080262C8 4A07     ldr     r2,=30001ACh                            
080262CA 00C8     lsl     r0,r1,3h                                
080262CC 1A40     sub     r0,r0,r1                                
080262CE 00C0     lsl     r0,r0,3h                                
080262D0 1880     add     r0,r0,r2                                
080262D2 3024     add     r0,24h                                  
080262D4 7800     ldrb    r0,[r0]      ;读取主精灵POSE                            
080262D6 2827     cmp     r0,27h                                  
080262D8 D11B     bne     @@end        ;不是27则结束                        
080262DA 7F98     ldrb    r0,[r3,1Eh]                             
080262DC 2801     cmp     r0,1h        ;读取副精灵date                           
080262DE D107     bne     @@CounCheck                                
080262E0 4802     ldr     r0,=82DD6C0h ;头球3                           
080262E2 E00C     b       @@Peer                                

@@CounCheck:                               
080262F0 2802     cmp     r0,2h                                   
080262F2 D103     bne     @@CounCheck2                                
080262F4 4800     ldr     r0,=82DD6A0h  ;头球2                          
080262F6 E002     b       @@Peer                                

@@CounCheck2:                              
080262FC 4806     ldr     r0,=82DD680h  ;头球1 

@@Peer:                         
080262FE 6198     str     r0,[r3,18h]   ;写入OAM                           
08026300 2000     mov     r0,0h                                   
08026302 7718     strb    r0,[r3,1Ch]                             
08026304 82D8     strh    r0,[r3,16h]                             
08026306 1C19     mov     r1,r3                                   
08026308 3124     add     r1,24h                                  
0802630A 2023     mov     r0,23h       ;Pose写入23h                           
0802630C 7008     strb    r0,[r1]                                 
0802630E 2001     mov     r0,1h                                   
08026310 73A0     strb    r0,[r4,0Eh]  ;300071A写入1 为1则不会被击退

@@end                            
08026312 BC10     pop     r4                                      
08026314 BC01     pop     r0                                      
08026316 4700     bx      r0                                      


;pose 23 头球                              
0802631C B500     push    r14                                     
0802631E F7E9FC53 bl      800FBC8h      ;检查动画结束 头球缩小消失                          
08026322 2800     cmp     r0,0h                                   
08026324 D01D     beq     @@end                                
08026326 4803     ldr     r0,=3000738h                            
08026328 7F82     ldrb    r2,[r0,1Eh]   ;检查副精灵DATA                          
0802632A 1C03     mov     r3,r0                                   
0802632C 2A01     cmp     r2,1h                                   
0802632E D105     bne     @@CounCheck                                
08026330 4801     ldr     r0,=82DD670h                            
08026332 E00A     b       @@Peer                                 

@@CounCheck:                              
0802633C 2A02     cmp     r2,2h                                   
0802633E D103     bne     @@CounCheck2                                
08026340 4800     ldr     r0,=82DD660h                            

@@CounCheck2:                              
08026348 4807     ldr     r0,=82DD650h 

@@Peer:                           
0802634A 6198     str     r0,[r3,18h]   ;写入OAM                          
0802634C 2000     mov     r0,0h                                   
0802634E 7718     strb    r0,[r3,1Ch]                              
08026350 82D8     strh    r0,[r3,16h]                             
08026352 1C19     mov     r1,r3                                   
08026354 3124     add     r1,24h                                  
08026356 2025     mov     r0,25h                                  
08026358 7008     strb    r0,[r1]       ;pose写入25h                            
0802635A 8819     ldrh    r1,[r3]                                 
0802635C 2004     mov     r0,4h                                   
0802635E 4308     orr     r0,r1         ;取向orr 4h                          
08026360 8018     strh    r0,[r3]       ;再写入

@@end:                                
08026362 BC01     pop     r0                                      
08026364 4700     bx      r0                                      

;pose 25 头球                              
0802636C B500     push    r14                                     
0802636E 4B09     ldr     r3,=3000738h                            
08026370 1C18     mov     r0,r3                                   
08026372 3023     add     r0,23h                                  
08026374 7801     ldrb    r1,[r0]       ;读取主精灵序号                           
08026376 4A08     ldr     r2,=30001ACh                            
08026378 00C8     lsl     r0,r1,3h                                
0802637A 1A40     sub     r0,r0,r1                                
0802637C 00C0     lsl     r0,r0,3h                                
0802637E 1880     add     r0,r0,r2                                
08026380 3024     add     r0,24h                                  
08026382 7800     ldrb    r0,[r0]       ;读取主精灵POSE                           
08026384 2809     cmp     r0,9h                                   
08026386 D11F     bne     @@end                                
08026388 7F98     ldrb    r0,[r3,1Eh]                             
0802638A 2801     cmp     r0,1h                                   
0802638C D108     bne     80263A0h                                
0802638E 4803     ldr     r0,=82DD630h                            
08026390 E00D     b       80263AEh                                

                              
080263A0 2802     cmp     r0,2h                                   
080263A2 D103     bne     80263ACh                                
080263A4 4800     ldr     r0,=82DD610h                            
080263A6 E002     b       80263AEh                                


                             
080263AC 4807     ldr     r0,=82DD5F0h 

@@Peer:                           
080263AE 6198     str     r0,[r3,18h]                             
080263B0 8819     ldrh    r1,[r3]                                 
080263B2 4807     ldr     r0,=0FFFBh                              
080263B4 4008     and     r0,r1       ;取向7变回3                              
080263B6 2100     mov     r1,0h                                   
080263B8 2200     mov     r2,0h                                   
080263BA 8018     strh    r0,[r3]     ;再写入                            
080263BC 7719     strb    r1,[r3,1Ch]                             
080263BE 82DA     strh    r2,[r3,16h]                             
080263C0 1C19     mov     r1,r3                                   
080263C2 3124     add     r1,24h                                  
080263C4 2027     mov     r0,27h      ;pose写入27h                            
080263C6 7008     strb    r0,[r1]

@@end:                                 
080263C8 BC01     pop     r0                                      
080263CA 4700     bx      r0                                      


;pose 27 头球                               
080263D4 B510     push    r4,r14                                  
080263D6 1C04     mov     r4,r0                                   
080263D8 F7E9FBF6 bl      800FBC8h     ;检查动画结束 头球复原                            
080263DC 2800     cmp     r0,0h                                   
080263DE D01B     beq     @@end                                
080263E0 4803     ldr     r0,=3000738h                            
080263E2 7F82     ldrb    r2,[r0,1Eh]                            
080263E4 1C01     mov     r1,r0                                   
080263E6 2A01     cmp     r2,1h                                   
080263E8 D106     bne     80263F8h                                
080263EA 4802     ldr     r0,=82DD670h                            
080263EC E00B     b       8026406h                                

                              
080263F6 082D     lsr     r5,r5,20h                               
080263F8 2A02     cmp     r2,2h                                   
080263FA D103     bne     8026404h                                
080263FC 4800     ldr     r0,=82DD660h                            
080263FE E002     b       8026406h                                

                              
08026404 4806     ldr     r0,=82DD650h 

@@Peer:                           
08026406 6188     str     r0,[r1,18h]                             
08026408 2000     mov     r0,0h                                   
0802640A 7708     strb    r0,[r1,1Ch]                             
0802640C 2200     mov     r2,0h                                   
0802640E 82C8     strh    r0,[r1,16h]                             
08026410 3124     add     r1,24h                                  
08026412 2009     mov     r0,9h           ;pose写入9                          
08026414 7008     strb    r0,[r1]                                 
08026416 73A2     strb    r2,[r4,0Eh]     ;300071A写回0,可以被击退

@@end:                           
08026418 BC10     pop     r4                                      
0802641A BC01     pop     r0                                      
0802641C 4700     bx      r0                                      


;pose 67                            
08026424 B510     push    r4,r14                                  
08026426 B081     add     sp,-4h                                  
08026428 4B0B     ldr     r3,=3000738h                            
0802642A 1C18     mov     r0,r3                                   
0802642C 3023     add     r0,23h                                  
0802642E 7801     ldrb    r1,[r0]        ;读取主精灵序号                           
08026430 4A0A     ldr     r2,=30001ACh                            
08026432 00C8     lsl     r0,r1,3h                                
08026434 1A40     sub     r0,r0,r1                                
08026436 00C0     lsl     r0,r0,3h                                
08026438 1880     add     r0,r0,r2                                
0802643A 3024     add     r0,24h                                  
0802643C 7800     ldrb    r0,[r0]        ;检查主精灵pose                           
0802643E 2868     cmp     r0,68h         ;不是68则结束                         
08026440 D153     bne     80264EAh                                
08026442 885C     ldrh    r4,[r3,2h]                              
08026444 889A     ldrh    r2,[r3,4h]     ;坐标                         
08026446 7F98     ldrb    r0,[r3,1Eh]    ;Data                          
08026448 2804     cmp     r0,4h                                   
0802644A D847     bhi     @@DataBhi4                                
0802644C 0080     lsl     r0,r0,2h       ;Data乘以8                         
0802644E 4904     ldr     r1,=8026464h   ;DeathTable                         
08026450 1840     add     r0,r0,r1                                
08026452 6800     ldr     r0,[r0]                                 
08026454 4687     mov     r15,r0                                  

DeathTable: 
    .word 80264d6h
	.word 8026478h
	.word 8026496h
	.word 80264dch
	.word 80264b4h
	
                                 
;DATA1 头球3                            
08026478 1C20     mov     r0,r4                                   
0802647A 3010     add     r0,10h                                  
0802647C 0400     lsl     r0,r0,10h                               
0802647E 0C04     lsr     r4,r0,10h                               
08026480 8819     ldrh    r1,[r3]   ;读取取向                              
08026482 2040     mov     r0,40h                                  
08026484 4008     and     r0,r1                                   
08026486 2800     cmp     r0,0h                                   
08026488 D002     beq     @@FaceLeft                                
0802648A 1C10     mov     r0,r2                                   
0802648C 3848     sub     r0,48h    ;X坐标减去48h                              
0802648E E01F     b       @@Peer 

@@FaceLeft:                               
08026490 1C10     mov     r0,r2                                   
08026492 3048     add     r0,48h    ;X坐标加上48h                               
08026494 E01C     b       @@Peer 

;DATA2 头球2                               
08026496 1C20     mov     r0,r4                                   
08026498 3810     sub     r0,10h                                  
0802649A 0400     lsl     r0,r0,10h                               
0802649C 0C04     lsr     r4,r0,10h                               
0802649E 8819     ldrh    r1,[r3]                                 
080264A0 2040     mov     r0,40h                                  
080264A2 4008     and     r0,r1                                   
080264A4 2800     cmp     r0,0h                                   
080264A6 D002     beq     @@FaceLeft2                                
080264A8 1C10     mov     r0,r2                                   
080264AA 3820     sub     r0,20h                                  
080264AC E010     b       @@Peer 

@@FaceLeft2:                               
080264AE 1C10     mov     r0,r2                                   
080264B0 3020     add     r0,20h                                  
080264B2 E00D     b       @@Peer 

;Data4                               
080264B4 1C20     mov     r0,r4                                   
080264B6 3840     sub     r0,40h                                  
080264B8 0400     lsl     r0,r0,10h                               
080264BA 0C04     lsr     r4,r0,10h                               
080264BC 8819     ldrh    r1,[r3]                                 
080264BE 2040     mov     r0,40h                                  
080264C0 4008     and     r0,r1                                   
080264C2 2800     cmp     r0,0h                                   
080264C4 D002     beq     80264CCh                                
080264C6 1C10     mov     r0,r2                                   
080264C8 3878     sub     r0,78h                                  
080264CA E001     b       @@Peer                                
080264CC 1C10     mov     r0,r2                                   
080264CE 3078     add     r0,78h 

@@Peer:                                 
080264D0 0400     lsl     r0,r0,10h                               
080264D2 0C02     lsr     r2,r0,10h                               
080264D4 E002     b       80264DCh 

;Data0                               
080264D6 2000     mov     r0,0h                                   
080264D8 8018     strh    r0,[r3]  ;消失                                
080264DA E006     b       @@end 

@@DataBhi4:  ;Data3                             
080264DC 2021     mov     r0,21h                                  
080264DE 9000     str     r0,[sp]                                 
080264E0 2000     mov     r0,0h                                   
080264E2 1C21     mov     r1,r4                                   
080264E4 2300     mov     r3,0h                                   
080264E6 F7EAFDCD bl      8011084h

@@end:                                
080264EA B001     add     sp,4h                                   
080264EC BC10     pop     r4                                      
080264EE BC01     pop     r0                                      
080264F0 4700     bx      r0                                      


////////////////////////////////////////////////////////////////////////////////////////////////
;主精灵主程序                               
080264F4 B530     push    r4,r5,r14                               
080264F6 491C     ldr     r1,=3000738h                            
080264F8 7F48     ldrb    r0,[r1,1Dh]       ;读取ID                      
080264FA 4C1C     ldr     r4,=300070Ch                            
080264FC 288B     cmp     r0,8Bh                                  
080264FE D100     bne     @@ID4D          ;如果是8B则r4是3000720h                      
08026500 4C1B     ldr     r4,=3000720h   

@@ID4D:                         
08026502 1C0A     mov     r2,r1                                   
08026504 3226     add     r2,26h                                  
08026506 2001     mov     r0,1h                                   
08026508 7010     strb    r0,[r2]           ;300075e写入1                      
0802650A 1C08     mov     r0,r1                                   
0802650C 3024     add     r0,24h                                  
0802650E 7800     ldrb    r0,[r0]           ;读取pose                      
08026510 3801     sub     r0,1h             ;pose值减1                      
08026512 0600     lsl     r0,r0,18h                               
08026514 0E00     lsr     r0,r0,18h                               
08026516 2860     cmp     r0,60h                                  
08026518 D81B     bhi     @@PoseThan61      ;也就是死亡                          
0802651A 1C0B     mov     r3,r1                                   
0802651C 3332     add     r3,32h                                  
0802651E 781A     ldrb    r2,[r3]           ;读取碰撞属性                        
08026520 2502     mov     r5,2h                                   
08026522 1C28     mov     r0,r5                                   
08026524 4010     and     r0,r2             ;and 2                       
08026526 2800     cmp     r0,0h                                   
08026528 D00A     beq     @@NoHitOrInScreen                                
0802652A 20FD     mov     r0,0FDh                                 
0802652C 4010     and     r0,r2             ;去掉2 再写入                     
0802652E 7018     strb    r0,[r3]                                 
08026530 8809     ldrh    r1,[r1]                                 
08026532 1C28     mov     r0,r5                                   
08026534 4008     and     r0,r1             ;检测是否在屏幕内                       
08026536 2800     cmp     r0,0h                                   
08026538 D002     beq     @@NoHitOrInScreen                                
0802653A 20AF     mov     r0,0AFh                                 
0802653C F7DCFA6C bl      8002A18h          ;播放挨打声音

@@NoHitOrInScreen:                               
08026540 4909     ldr     r1,=3000738h                            
08026542 8A8A     ldrh    r2,[r1,14h]       ;读取当前血量                      
08026544 8960     ldrh    r0,[r4,0Ah]       ;716或72A  之前血量?                     
08026546 4290     cmp     r0,r2             ;如果相等则未挨打                      
08026548 D003     beq     @@PoseThan61                                
0802654A 8162     strh    r2,[r4,0Ah]       ;血量如果不相等则74C写入716或72A  当前血量写入之前血量                     
0802654C 3124     add     r1,24h                                  
0802654E 2042     mov     r0,42h                                  
08026550 7008     strb    r0,[r1]           ;pose写入42h

@@PoseThan61:                                 
08026552 4805     ldr     r0,=3000738h                            
08026554 3024     add     r0,24h                                  
08026556 7800     ldrb    r0,[r0]           ;读取pose                      
08026558 2868     cmp     r0,68h                                  
0802655A D900     bls     @@Pass                               
0802655C E11A     b       @@DeathCheck 

@@Pass:                               
0802655E 0080     lsl     r0,r0,2h                                
08026560 4904     ldr     r1,=8026578h                            
08026562 1840     add     r0,r0,r1                                
08026564 6800     ldr     r0,[r0]                                 
08026566 4687     mov     r15,r0                                  
PoseTable:
    .word 802671ch  ;00
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h 
	.word 802672ch  ;08
	.word 8026732h  ;09
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h  
	.word 8026724h  ;0F
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h 
	.word 802673ah  ;22h
	.word 8026740h  ;23h
	.word 8026748h  ;24h
	.word 802674eh  ;25h
	.word 8026756h  ;26h
	.word 802675ch  ;27h
	.word 8026764h  ;28h
	.word 802676ah  ;29h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
    .word 8026794h .word 8026794h .word 8026794h .word 8026794h
    .word 8026772h  ;42h
	.word 8026778h  ;43h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026794h .word 8026794h 
	.word 8026780h  ;62h
	.word 8026794h .word 8026794h .word 8026794h .word 8026794h
	.word 8026786h  ;67h
	.word 802678eh  ;68h
    	
///////////////////////////////////////////////////////////////////	

0802671C 1C20     mov     r0,r4         ;pose 0h                          
0802671E F7FFF9AF bl      8025A80h                                
08026722 E037     b       @@DeathCheck                                
08026724 1C20     mov     r0,r4         ;pose 0Fh                          
08026726 F7FFFA75 bl      8025C14h                                
0802672A E033     b       @@DeathCheck                                
0802672C 1C20     mov     r0,r4         ;pose 8h                           
0802672E F7FFFA8D bl      8025C4Ch                                
08026732 1C20     mov     r0,r4         ;pose 9h                          
08026734 F7FFFA98 bl      8025C68h                                
08026738 E02C     b       @@DeathCheck                                
0802673A 1C20     mov     r0,r4         ;pose 22h                          
0802673C F7FFFA9A bl      8025C74h                                
08026740 1C20     mov     r0,r4         ;pose 23h                          
08026742 F7FFFAAB bl      8025C9Ch                                
08026746 E025     b       @@DeathCheck                                
08026748 1C20     mov     r0,r4         ;pose 24h                          
0802674A F7FFFADB bl      8025D04h                                
0802674E 1C20     mov     r0,r4         ;pose 25h                          
08026750 F7FFFAE6 bl      8025D20h                                
08026754 E01E     b       @@DeathCheck                                
08026756 1C20     mov     r0,r4         ;pose 26h                          
08026758 F7FFFAF6 bl      8025D48h                                
0802675C 1C20     mov     r0,r4         ;pose 27h                          
0802675E F7FFFB0D bl      8025D7Ch                                
08026762 E017     b       @@DeathCheck                                
08026764 1C20     mov     r0,r4         ;pose 28h                          
08026766 F7FFFB1B bl      8025DA0h                                
0802676A 1C20     mov     r0,r4         ;pose 29h                          
0802676C F7FFFB2C bl      8025DC8h                                
08026770 E010     b       @@DeathCheck                                
08026772 1C20     mov     r0,r4         ;pose 42h                          
08026774 F7FFFB5A bl      8025E2Ch                                
08026778 1C20     mov     r0,r4         ;pose 43h                          
0802677A F7FFFB73 bl      8025E64h                                
0802677E E009     b       @@DeathCheck                                
08026780 1C20     mov     r0,r4         ;pose 62h                          
08026782 F7FFFB81 bl      8025E88h                                
08026786 1C20     mov     r0,r4         ;pose 67h                          
08026788 F7FFFBB0 bl      8025EECh                                
0802678C E002     b       @@DeathCheck                                
0802678E 1C20     mov     r0,r4         ;pose 68h                          
08026790 F7FFFBC0 bl      8025F14h 

@@DeathCheck:                               
08026794 4806     ldr     r0,=3000738h                            
08026796 8A80     ldrh    r0,[r0,14h]    ;读取血量                           
08026798 2800     cmp     r0,0h                                   
0802679A D005     beq     @@end                                
0802679C 1C20     mov     r0,r4          ;没有死亡                          
0802679E F7EAFE85 bl      80114ACh       ;控制1和3两个头球跟着的蠕动而动                         
080267A2 1C20     mov     r0,r4                                   
080267A4 F7FFF8FC bl      80259A0h

@@end:                                
080267A8 BC30     pop     r4,r5                                   
080267AA BC01     pop     r0                                      
080267AC 4700     bx      r0                                      

//////////////////////////////////////////////////////////////////////
;副精灵         主程序                     
080267B4 B570     push    r4-r6,r14                               
080267B6 4B1B     ldr     r3,=3000738h                            
080267B8 1C18     mov     r0,r3                                   
080267BA 3023     add     r0,23h                                  
080267BC 7801     ldrb    r1,[r0]      ;读取主序号                            
080267BE 4A1A     ldr     r2,=30001ACh                            
080267C0 00C8     lsl     r0,r1,3h                                
080267C2 1A40     sub     r0,r0,r1                                
080267C4 00C0     lsl     r0,r0,3h     ;56倍                           
080267C6 1882     add     r2,r0,r2     ;加上起始坐标                           
080267C8 7F50     ldrb    r0,[r2,1Dh]  ;读取ID                           
080267CA 4C18     ldr     r4,=300070Ch                            
080267CC 288B     cmp     r0,8Bh                                  
080267CE D100     bne     @@Peer                                
080267D0 4C17     ldr     r4,=3000720h 

@@Peer:                           
080267D2 1C10     mov     r0,r2                                   
080267D4 3024     add     r0,24h       ;读取当前主精灵pose                            
080267D6 7800     ldrb    r0,[r0]                                 
080267D8 2861     cmp     r0,61h                                  
080267DA D912     bls     @@Pass                                
080267DC 1C1D     mov     r5,r3                                   
080267DE 3524     add     r5,24h       ;读取副精灵的pose                           
080267E0 7828     ldrb    r0,[r5]                                 
080267E2 2861     cmp     r0,61h                                  
080267E4 D80D     bhi     @@Pass                                
080267E6 8819     ldrh    r1,[r3]      ;读取取向                           
080267E8 2680     mov     r6,80h       ;副精灵pose小于等于61,主精灵pose大于等于61时执行                           
080267EA 0236     lsl     r6,r6,8h                                
080267EC 1C30     mov     r0,r6                                   
080267EE 4308     orr     r0,r1        ;orr 8000   无敌                         
080267F0 8018     strh    r0,[r3]      ;再写入                           
080267F2 2067     mov     r0,67h                                  
080267F4 7028     strb    r0,[r5]      ;pose写入67h                           
080267F6 1C10     mov     r0,r2                                   
080267F8 302B     add     r0,2Bh                                  
080267FA 7801     ldrb    r1,[r0]      ;读取主精灵无敌时间                           
080267FC 1C18     mov     r0,r3                                   
080267FE 302B     add     r0,2Bh                                  
08026800 7001     strb    r1,[r0]      ;写入当前精灵无敌时间

@@Pass:                                 
08026802 4808     ldr     r0,=3000738h                            
08026804 3024     add     r0,24h       ;读取当前精灵的pose                           
08026806 7800     ldrb    r0,[r0]                                 
08026808 2827     cmp     r0,27h                                  
0802680A D02B     beq     @@Pose27                                
0802680C 2827     cmp     r0,27h                                  
0802680E DC14     bgt     @@More27                                
08026810 2823     cmp     r0,23h                                  
08026812 D01F     beq     @@Pose23                                
08026814 2823     cmp     r0,23h                                  
08026816 DC0D     bgt     @@More23                                
08026818 2800     cmp     r0,0h                                   
0802681A D013     beq     @@Pose0                                
0802681C 2809     cmp     r0,9h                                   
0802681E D015     beq     @@Pose9                                
08026820 E02B     b       @@Posend                                

@@More23:                              
08026834 2825     cmp     r0,25h                                  
08026836 D011     beq     @@Pose25                                
08026838 E01F     b       @@Posend

@@More27:                                
0802683A 2842     cmp     r0,42h                                  
0802683C D016     beq     @@Pose42                                
0802683E 2867     cmp     r0,67h                                  
08026840 D018     beq     @@Pose67                                
08026842 E01A     b       @@Posend 

@@Pose0:                               
08026844 1C20     mov     r0,r4                                   
08026846 F7FFFB93 bl      8025F70h                                
0802684A E016     b       @@Posend 

@@Pose9:                               
0802684C 1C20     mov     r0,r4                                   
0802684E F7FFFD35 bl      80262BCh                                
08026852 E012     b       @@Posend 

@@Pose23:                               
08026854 1C20     mov     r0,r4                                   
08026856 F7FFFD61 bl      802631Ch                                
0802685A E00E     b       @@Posend

@@Pose25:                                
0802685C 1C20     mov     r0,r4                                   
0802685E F7FFFD85 bl      802636Ch                                
08026862 E00A     b       @@Posend 

@@Pose27:                               
08026864 1C20     mov     r0,r4                                   
08026866 F7FFFDB5 bl      80263D4h                                
0802686A E006     b       @@Posend 

@@Pose42:                               
0802686C 1C20     mov     r0,r4                                   
0802686E F7FFFC65 bl      802613Ch                                
08026872 E002     b       @@Posend 

@@Pose67:                               
08026874 1C20     mov     r0,r4                                   
08026876 F7FFFDD5 bl      8026424h 

@@Posend:                               
0802687A 4A0B     ldr     r2,=3000738h                            
0802687C 8A90     ldrh    r0,[r2,14h]                             
0802687E 2800     cmp     r0,0h                                   
08026880 D019     beq     @@end                                
08026882 7F90     ldrb    r0,[r2,1Eh]    ;精灵date                          
08026884 2804     cmp     r0,4h                                   
08026886 D00A     beq     @@Times4or0                               
08026888 2800     cmp     r0,0h                                   
0802688A D008     beq     @@Times4or0                                
0802688C 1C10     mov     r0,r2                                   
0802688E 3024     add     r0,24h                                  
08026890 7800     ldrb    r0,[r0]                                 
08026892 2867     cmp     r0,67h                                  
08026894 D10C     bne     @@No67                                
08026896 8811     ldrh    r1,[r2]                                 
08026898 4804     ldr     r0,=0FFFBh                              
0802689A 4008     and     r0,r1         ;取向去掉4h                           
0802689C 8010     strh    r0,[r2] 

@@Times4or0:                                
0802689E 1C20     mov     r0,r4                                   
080268A0 F7FFF87E bl      80259A0h                                
080268A4 E007     b       @@end                                

@@No67:                                
080268B0 1C20     mov     r0,r4                                   
080268B2 F7EAFE35 bl      8011520h 

@@end                               
080268B6 BC70     pop     r4-r6                                   
080268B8 BC01     pop     r0                                      
080268BA 4700     bx      r0 

                                     
