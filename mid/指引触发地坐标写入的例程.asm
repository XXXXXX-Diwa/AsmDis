08072B14 B5F0     push    r4-r7,r14                                       
08072B16 1C04     mov     r4,r0         ;16d9                                   
08072B18 1C0E     mov     r6,r1         ;16da                                  
08072B1A 4F15     ldr     r7,=8345934h                                    
08072B1C 2000     mov     r0,0h                                           
08072B1E 5618     ldsb    r0,[r3,r0]    ;40E092                                    
08072B20 00C0     lsl     r0,r0,3h      ;值乘以8                                  
08072B22 19C0     add     r0,r0,r7      ;加上偏移                                  
08072B24 4684     mov     r12,r0        ;给r12                                  
08072B26 4813     ldr     r0,=8754BC4h                                    
08072B28 6800     ldr     r0,[r0]       ;16C4                                  
08072B2A 4665     mov     r5,r12                                          
08072B2C 7829     ldrb    r1,[r5]       ;读取数据起始区号                                  
08072B2E 7C85     ldrb    r5,[r0,12h]   ;当前小地图的序号  16d6                                
08072B30 42A9     cmp     r1,r5                                           
08072B32 D121     bne     @@MapDataNo                                        
08072B34 4665     mov     r5,r12                                          
08072B36 7929     ldrb    r1,[r5,4h]    ;读取要去的区的区号                                 
08072B38 3042     add     r0,42h                                          
08072B3A 7001     strb    r1,[r0]       ;读取1706 指引下一个区的区号
08072B3C 2000     mov     r0,0h                                           
08072B3E 5618     ldsb    r0,[r3,r0]    ;读取40e092                                  
08072B40 00C0     lsl     r0,r0,3h                                        
08072B42 19C0     add     r0,r0,r7                                        
08072B44 7880     ldrb    r0,[r0,2h]    ;得到X坐标                                  
08072B46 7020     strb    r0,[r4]       ;写入16D7                                  
08072B48 7820     ldrb    r0,[r4]                                         
08072B4A 0140     lsl     r0,r0,5h      ;乘以32                                  
08072B4C 8050     strh    r0,[r2,2h]    ;写入19AE                                  
08072B4E 2000     mov     r0,0h                                           
08072B50 5618     ldsb    r0,[r3,r0]                                      
08072B52 00C0     lsl     r0,r0,3h                                        
08072B54 19C0     add     r0,r0,r7                                        
08072B56 78C0     ldrb    r0,[r0,3h]    ;得到Y坐标                                     
08072B58 7030     strb    r0,[r6]       ;写入16D8                                  
08072B5A 7830     ldrb    r0,[r6]                                         
08072B5C 3004     add     r0,4h         ;加4                                   
08072B5E 0140     lsl     r0,r0,5h      ;乘以32                                  
08072B60 8010     strh    r0,[r2]       ;写入19aC                                  
08072B62 2001     mov     r0,1h                                           
08072B64 5618     ldsb    r0,[r3,r0]    ;读取40e093                                  
08072B66 2800     cmp     r0,0h                                           
08072B68 DA21     bge     @@Three                                       
08072B6A 2002     mov     r0,2h                                           
08072B6C E020     b       @@Write                                        
.pool

@@MapDataNo:                                       
08072B78 3042     add     r0,42h                                          
08072B7A 7001     strb    r1,[r0]     ;读取下一个区的区号1706                                    
08072B7C 2000     mov     r0,0h                                           
08072B7E 5618     ldsb    r0,[r3,r0]  ;02                                    
08072B80 00C0     lsl     r0,r0,3h                                        
08072B82 19C0     add     r0,r0,r7    ;40E092                                      
08072B84 7980     ldrb    r0,[r0,6h]  ;读取要到的区口X坐标                                   
08072B86 7020     strb    r0,[r4]     ;写入16d9                                    
08072B88 7820     ldrb    r0,[r4]     ;读取X坐标                                    
08072B8A 0140     lsl     r0,r0,5h    ;乘以32                                    
08072B8C 8050     strh    r0,[r2,2h]  ;写入19BE                                    
08072B8E 2000     mov     r0,0h                                           
08072B90 5618     ldsb    r0,[r3,r0]  ;读取40e092                                    
08072B92 00C0     lsl     r0,r0,3h                                        
08072B94 19C0     add     r0,r0,r7                                        
08072B96 79C0     ldrb    r0,[r0,7h]  ;读取要到的区口Y坐标                                    
08072B98 7030     strb    r0,[r6]     ;写入16DA                                    
08072B9A 7830     ldrb    r0,[r6]     ;读取Y坐标                                    
08072B9C 3803     sub     r0,3h       ;减3                                    
08072B9E 0140     lsl     r0,r0,5h    ;乘以32                                    
08072BA0 8010     strh    r0,[r2]     ;写入19BC                                    
08072BA2 2001     mov     r0,1h                                           
08072BA4 5618     ldsb    r0,[r3,r0]  ;读取40E093 上下?                                    
08072BA6 2800     cmp     r0,0h                                           
08072BA8 DA01     bge     @@Three                                        
08072BAA 2002     mov     r0,2h                                           
08072BAC E000     b       @@Write

@@Three:                                        
08072BAE 2003     mov     r0,3h  

@@Write:                                         
08072BB0 7290     strb    r0,[r2,0Ah]                                     
08072BB2 BCF0     pop     r4-r7                                           
08072BB4 BC01     pop     r0                                              
08072BB6 4700     bx      r0  


                                            
08072BB8 B5F0     push    r4-r7,r14                                       
08072BBA 464F     mov     r7,r9                                           
08072BBC 4646     mov     r6,r8                                           
08072BBE B4C0     push    r6,r7                                           
08072BC0 B085     add     sp,-14h                                         
08072BC2 0600     lsl     r0,r0,18h                                       
08072BC4 0E07     lsr     r7,r0,18h                                       
08072BC6 490B     ldr     r1,=840D038h                                    
08072BC8 2010     mov     r0,10h                                          
08072BCA 9000     str     r0,[sp]                                         
08072BCC 2003     mov     r0,3h                                           
08072BCE AA01     add     r2,sp,4h                                        
08072BD0 2310     mov     r3,10h                                          
08072BD2 F790FB07 bl      80031E4h       ;上略                                  
08072BD6 4808     ldr     r0,=8754BC4h                                    
08072BD8 6800     ldr     r0,[r0]        ;16C4 指引时为12                                 
08072BDA 8801     ldrh    r1,[r0]                                         
08072BDC 2002     mov     r0,2h                                           
08072BDE 4008     and     r0,r1                                           
08072BE0 2800     cmp     r0,0h                                           
08072BE2 D00B     beq     @@NoGuide                                        
08072BE4 AA01     add     r2,sp,4h       ;7E04                                     
08072BE6 7AD1     ldrb    r1,[r2,0Bh]                                     
08072BE8 2004     mov     r0,4h                                           
08072BEA 4240     neg     r0,r0                                           
08072BEC 4008     and     r0,r1          ;去掉3                                 
08072BEE 72D0     strb    r0,[r2,0Bh]    ;0                                 
08072BF0 E009     b       @@Peer                                        
.pool 

@@NoGuide:                                      
08072BFC A801     add     r0,sp,4h                                        
08072BFE 7AC1     ldrb    r1,[r0,0Bh]    ;orr 3                                  
08072C00 2203     mov     r2,3h                                           
08072C02 4311     orr     r1,r2                                           
08072C04 72C1     strb    r1,[r0,0Bh]    ;再写入

@@Peer:                                   
08072C06 2F00     cmp     r7,0h                                           
08072C08 D13A     bne     @@NoFrist      ;第一次是0??                                        
08072C0A 481A     ldr     r0,=8754BC4h                                    
08072C0C 6800     ldr     r0,[r0]                                         
08072C0E 21BA     mov     r1,0BAh                                         
08072C10 0089     lsl     r1,r1,2h                                        
08072C12 1844     add     r4,r0,r1       ;19AC 指引跳到另一张地图的起始坐标 32倍                                   
08072C14 2620     mov     r6,20h                                          
08072C16 250B     mov     r5,0Bh                                          
08072C18 9600     str     r6,[sp]        ;写入7E00                                 
08072C1A 2003     mov     r0,3h                                           
08072C1C A901     add     r1,sp,4h                                        
08072C1E 1C22     mov     r2,r4                                           
08072C20 2310     mov     r3,10h                                          
08072C22 F790FADF bl      80031E4h                                        
08072C26 3D01     sub     r5,1h                                           
08072C28 3410     add     r4,10h                                          
08072C2A 2D00     cmp     r5,0h                                           
08072C2C DAF4     bge     8072C18h                                        
08072C2E 4811     ldr     r0,=8754BC4h                                    
08072C30 6800     ldr     r0,[r0]                                         
08072C32 21EA     mov     r1,0EAh                                         
08072C34 0089     lsl     r1,r1,2h                                        
08072C36 1844     add     r4,r0,r1                                        
08072C38 2620     mov     r6,20h                                          
08072C3A 2504     mov     r5,4h                                           
08072C3C 9600     str     r6,[sp]                                         
08072C3E 2003     mov     r0,3h                                           
08072C40 A901     add     r1,sp,4h                                        
08072C42 1C22     mov     r2,r4                                           
08072C44 2310     mov     r3,10h                                          
08072C46 F790FACD bl      80031E4h                                        
08072C4A 3D01     sub     r5,1h                                           
08072C4C 3410     add     r4,10h                                          
08072C4E 2D00     cmp     r5,0h                                           
08072C50 DAF4     bge     8072C3Ch                                        
08072C52 4A08     ldr     r2,=8754BC4h                                    
08072C54 6810     ldr     r0,[r2]                                         
08072C56 3041     add     r0,41h                                          
08072C58 2100     mov     r1,0h                                           
08072C5A 7001     strb    r1,[r0]      ;1705写入0                                   
08072C5C 6810     ldr     r0,[r2]                                         
08072C5E 3040     add     r0,40h                                          
08072C60 21FF     mov     r1,0FFh                                         
08072C62 7001     strb    r1,[r0]      ;1704写入FF                                    
08072C64 6810     ldr     r0,[r2]                                         
08072C66 3042     add     r0,42h                                          
08072C68 2101     mov     r1,1h                                           
08072C6A 4249     neg     r1,r1                                           
08072C6C 7001     strb    r1,[r0]      ;1706写入FF                                   
08072C6E F000FA2D bl      80730CCh                                        
08072C72 E029     b       8072CC8h                                        
08072C74 4BC4     ldr     r3,=20003410h                                   
08072C76 0875     lsr     r5,r6,1h                                        
08072C78 1C10     mov     r0,r2                                           
08072C7A 3040     add     r0,40h                                          
08072C7C 7005     strb    r5,[r0]                                         
08072C7E E060     b       8072D42h 

@@NoFrist:                                       
08072C80 4846     ldr     r0,=8754BC4h                                    
08072C82 6800     ldr     r0,[r0]                                         
08072C84 21BA     mov     r1,0BAh                                         
08072C86 0089     lsl     r1,r1,2h                                        
08072C88 1844     add     r4,r0,r1                                        
08072C8A 2620     mov     r6,20h                                          
08072C8C 250B     mov     r5,0Bh                                          
08072C8E 9600     str     r6,[sp]                                         
08072C90 2003     mov     r0,3h                                           
08072C92 A901     add     r1,sp,4h                                        
08072C94 1C22     mov     r2,r4                                           
08072C96 2310     mov     r3,10h                                          
08072C98 F790FAA4 bl      80031E4h                                        
08072C9C 3D01     sub     r5,1h                                           
08072C9E 3410     add     r4,10h                                          
08072CA0 2D00     cmp     r5,0h                                           
08072CA2 DAF4     bge     8072C8Eh                                        
08072CA4 483D     ldr     r0,=8754BC4h                                    
08072CA6 6800     ldr     r0,[r0]                                         
08072CA8 21EA     mov     r1,0EAh                                         
08072CAA 0089     lsl     r1,r1,2h                                        
08072CAC 1844     add     r4,r0,r1                                        
08072CAE 2620     mov     r6,20h                                          
08072CB0 2504     mov     r5,4h                                           
08072CB2 9600     str     r6,[sp]                                         
08072CB4 2003     mov     r0,3h                                           
08072CB6 A901     add     r1,sp,4h                                        
08072CB8 1C22     mov     r2,r4                                           
08072CBA 2310     mov     r3,10h                                          
08072CBC F790FA92 bl      80031E4h                                        
08072CC0 3D01     sub     r5,1h                                           
08072CC2 3410     add     r4,10h                                          
08072CC4 2D00     cmp     r5,0h                                           
08072CC6 DAF4     bge     8072CB2h
                                        
08072CC8 4A34     ldr     r2,=8754BC4h                                    
08072CCA 6813     ldr     r3,[r2]                                         
08072CCC 20BA     mov     r0,0BAh                                         
08072CCE 0080     lsl     r0,r0,2h                                        
08072CD0 181C     add     r4,r3,r0                                        
08072CD2 4E33     ldr     r6,=840E02Ch                                    
08072CD4 8819     ldrh    r1,[r3]                                         
08072CD6 2010     mov     r0,10h                                          
08072CD8 4008     and     r0,r1                                           
08072CDA 4690     mov     r8,r2                                           
08072CDC 2800     cmp     r0,0h                                           
08072CDE D100     bne     8072CE2h                                        
08072CE0 E0D9     b       8072E96h                                        
08072CE2 21BE     mov     r1,0BEh                                         
08072CE4 0089     lsl     r1,r1,2h                                        
08072CE6 18C9     add     r1,r1,r3                                        
08072CE8 4689     mov     r9,r1                                           
08072CEA 3EB4     sub     r6,0B4h                                         
08072CEC 46B4     mov     r12,r6                                          
08072CEE 2F00     cmp     r7,0h                                           
08072CF0 D127     bne     8072D42h                                        
08072CF2 2500     mov     r5,0h                                           
08072CF4 20BE     mov     r0,0BEh                                         
08072CF6 0080     lsl     r0,r0,2h                                        
08072CF8 18C0     add     r0,r0,r3                                        
08072CFA 4681     mov     r9,r0                                           
08072CFC 1C1A     mov     r2,r3                                           
08072CFE 1C10     mov     r0,r2                                           
08072D00 3044     add     r0,44h                                          
08072D02 8807     ldrh    r7,[r0]                                         
08072D04 2300     mov     r3,0h                                           
08072D06 1C38     mov     r0,r7                                           
08072D08 4128     asr     r0,r5                                           
08072D0A 2101     mov     r1,1h                                           
08072D0C 4008     and     r0,r1                                           
08072D0E 2800     cmp     r0,0h                                           
08072D10 D013     beq     8072D3Ah                                        
08072D12 4661     mov     r1,r12                                          
08072D14 185E     add     r6,r3,r1                                        
08072D16 7830     ldrb    r0,[r6]                                         
08072D18 7C91     ldrb    r1,[r2,12h]                                     
08072D1A 4288     cmp     r0,r1                                           
08072D1C D10D     bne     8072D3Ah                                        
08072D1E 78F0     ldrb    r0,[r6,3h]                                      
08072D20 7D11     ldrb    r1,[r2,14h]                                     
08072D22 4288     cmp     r0,r1                                           
08072D24 D809     bhi     8072D3Ah                                        
08072D26 7930     ldrb    r0,[r6,4h]                                      
08072D28 4281     cmp     r1,r0                                           
08072D2A D806     bhi     8072D3Ah                                        
08072D2C 7870     ldrb    r0,[r6,1h]                                      
08072D2E 7CD1     ldrb    r1,[r2,13h]                                     
08072D30 4288     cmp     r0,r1                                           
08072D32 D802     bhi     8072D3Ah                                        
08072D34 78B6     ldrb    r6,[r6,2h]                                      
08072D36 42B1     cmp     r1,r6                                           
08072D38 D99E     bls     8072C78h                                        
08072D3A 330C     add     r3,0Ch                                          
08072D3C 3501     add     r5,1h                                           
08072D3E 2D0F     cmp     r5,0Fh                                          
08072D40 DDE1     ble     8072D06h                                        
08072D42 4916     ldr     r1,=8754BC4h                                    
08072D44 4688     mov     r8,r1                                           
08072D46 680A     ldr     r2,[r1]                                         
08072D48 1C10     mov     r0,r2                                           
08072D4A 3040     add     r0,40h                                          
08072D4C 2100     mov     r1,0h                                           
08072D4E 5641     ldsb    r1,[r0,r1]                                      
08072D50 0048     lsl     r0,r1,1h                                        
08072D52 1840     add     r0,r0,r1                                        
08072D54 0080     lsl     r0,r0,2h                                        
08072D56 4661     mov     r1,r12                                          
08072D58 1846     add     r6,r0,r1                                        
08072D5A 7833     ldrb    r3,[r6]                                         
08072D5C 79B0     ldrb    r0,[r6,6h]                                      
08072D5E 4283     cmp     r3,r0                                           
08072D60 D120     bne     8072DA4h                                        
08072D62 7CD0     ldrb    r0,[r2,13h]                                     
08072D64 0140     lsl     r0,r0,5h                                        
08072D66 8060     strh    r0,[r4,2h]                                      
08072D68 7D10     ldrb    r0,[r2,14h]                                     
08072D6A 0140     lsl     r0,r0,5h                                        
08072D6C 8020     strh    r0,[r4]                                         
08072D6E 7970     ldrb    r0,[r6,5h]                                      
08072D70 72A0     strb    r0,[r4,0Ah]                                     
08072D72 464C     mov     r4,r9                                           
08072D74 4640     mov     r0,r8                                           
08072D76 6801     ldr     r1,[r0]                                         
08072D78 79F0     ldrb    r0,[r6,7h]                                      
08072D7A 7548     strb    r0,[r1,15h]                                     
08072D7C 4640     mov     r0,r8                                           
08072D7E 6801     ldr     r1,[r0]                                         
08072D80 7A30     ldrb    r0,[r6,8h]                                      
08072D82 7588     strb    r0,[r1,16h]                                     
08072D84 7A70     ldrb    r0,[r6,9h]                                      
08072D86 72A0     strb    r0,[r4,0Ah]                                     
08072D88 4640     mov     r0,r8                                           
08072D8A 6801     ldr     r1,[r0]                                         
08072D8C 7D48     ldrb    r0,[r1,15h]                                     
08072D8E 0140     lsl     r0,r0,5h                                        
08072D90 8060     strh    r0,[r4,2h]                                      
08072D92 7D88     ldrb    r0,[r1,16h]                                     
08072D94 0140     lsl     r0,r0,5h                                        
08072D96 8020     strh    r0,[r4]                                         
08072D98 3410     add     r4,10h                                          
08072D9A E11E     b       8072FDAh                                        
08072D9C 4BC4     ldr     r3,=20037801h                                   
08072D9E 0875     lsr     r5,r6,1h                                        
08072DA0 E02C     b       8072DFCh                                        
08072DA2 0840     lsr     r0,r0,1h   

                                     
08072DA4 490F     ldr     r1,=87603F0h                                    
08072DA6 4810     ldr     r0,=3000054h                                    
08072DA8 7800     ldrb    r0,[r0]       ;读取区号
08072DAA 0080     lsl     r0,r0,2h      ;乘以4                                  
08072DAC 1840     add     r0,r0,r1                                        
08072DAE 6807     ldr     r7,[r0]                                         
08072DB0 79B1     ldrb    r1,[r6,6h]    ;读取要到的区号                                  
08072DB2 0048     lsl     r0,r1,1h                                        
08072DB4 1840     add     r0,r0,r1                                        
08072DB6 0040     lsl     r0,r0,1h      ;6倍                                   
08072DB8 183F     add     r7,r7,r0      ;加上数据                                  
08072DBA 7C90     ldrb    r0,[r2,12h]   ;读取当前地图号                                   
08072DBC 4298     cmp     r0,r3                                           
08072DBE D115     bne     @@MapDataNo                                        
08072DC0 7CD0     ldrb    r0,[r2,13h]   ;读取雕像X坐标                                   
08072DC2 0140     lsl     r0,r0,5h      ;32倍                                  
08072DC4 8060     strh    r0,[r4,2h]    ;写入19AE                                  
08072DC6 7D10     ldrb    r0,[r2,14h]   ;读取雕像Y坐标                                  
08072DC8 0140     lsl     r0,r0,5h      ;32倍                                  
08072DCA 8020     strh    r0,[r4]       ;写入19AC                                  
08072DCC 7970     ldrb    r0,[r6,5h]    ;基本都是1                                  
08072DCE 72A0     strb    r0,[r4,0Ah]   ;19B6                                  
08072DD0 464C     mov     r4,r9                                           
08072DD2 4640     mov     r0,r8                                           
08072DD4 6801     ldr     r1,[r0]                                         
08072DD6 1C08     mov     r0,r1                                           
08072DD8 3015     add     r0,15h        ;16D9                                       
08072DDA 3116     add     r1,16h        ;16DA                                  
08072DDC 1C22     mov     r2,r4         ;19bc                                  
08072DDE 1C3B     mov     r3,r7         ;840e0a4                                   
08072DE0 E055     b       @@Peer                                        
.pool

@@MapDataNo:                                      
08072DEC 1C10     mov     r0,r2                                           
08072DEE 3042     add     r0,42h                                          
08072DF0 7800     ldrb    r0,[r0]                                         
08072DF2 0600     lsl     r0,r0,18h                                       
08072DF4 1600     asr     r0,r0,18h                                       
08072DF6 4288     cmp     r0,r1                                           
08072DF8 D12A     bne     8072E50h                                        
08072DFA 1C10     mov     r0,r2                                           
08072DFC 3041     add     r0,41h                                          
08072DFE 7800     ldrb    r0,[r0]                                         
08072E00 3801     sub     r0,1h                                           
08072E02 0045     lsl     r5,r0,1h                                        
08072E04 1C10     mov     r0,r2                                           
08072E06 3013     add     r0,13h                                          
08072E08 1C11     mov     r1,r2                                           
08072E0A 3114     add     r1,14h                                          
08072E0C 197B     add     r3,r7,r5                                        
08072E0E 1C22     mov     r2,r4                                           
08072E10 F7FFFE80 bl      8072B14h     ;终区起始设定                                      
08072E14 7AE1     ldrb    r1,[r4,0Bh]                                     
08072E16 203F     mov     r0,3Fh                                          
08072E18 4008     and     r0,r1                                           
08072E1A 2140     mov     r1,40h                                          
08072E1C 4308     orr     r0,r1                                           
08072E1E 72E0     strb    r0,[r4,0Bh]                                     
08072E20 464C     mov     r4,r9                                           
08072E22 4640     mov     r0,r8                                           
08072E24 6801     ldr     r1,[r0]                                         
08072E26 79F0     ldrb    r0,[r6,7h]                                      
08072E28 7548     strb    r0,[r1,15h]                                     
08072E2A 4640     mov     r0,r8                                           
08072E2C 6801     ldr     r1,[r0]                                         
08072E2E 7A30     ldrb    r0,[r6,8h]                                      
08072E30 7588     strb    r0,[r1,16h]                                     
08072E32 79F0     ldrb    r0,[r6,7h]                                      
08072E34 0140     lsl     r0,r0,5h                                        
08072E36 8060     strh    r0,[r4,2h]                                      
08072E38 7A30     ldrb    r0,[r6,8h]                                      
08072E3A 0140     lsl     r0,r0,5h                                        
08072E3C 8020     strh    r0,[r4]                                         
08072E3E 7A70     ldrb    r0,[r6,9h]                                      
08072E40 72A0     strb    r0,[r4,0Ah]                                     
08072E42 3410     add     r4,10h                                          
08072E44 4641     mov     r1,r8                                           
08072E46 6808     ldr     r0,[r1]                                         
08072E48 3042     add     r0,42h                                          
08072E4A 21FF     mov     r1,0FFh                                         
08072E4C 7001     strb    r1,[r0]                                         
08072E4E E0C4     b       8072FDAh                                        
08072E50 1C10     mov     r0,r2                                           
08072E52 3041     add     r0,41h                                          
08072E54 7800     ldrb    r0,[r0]                                         
08072E56 3801     sub     r0,1h                                           
08072E58 0045     lsl     r5,r0,1h                                        
08072E5A 1C10     mov     r0,r2                                           
08072E5C 3013     add     r0,13h                                          
08072E5E 1C11     mov     r1,r2                                           
08072E60 3114     add     r1,14h                                          
08072E62 197B     add     r3,r7,r5                                        
08072E64 1C22     mov     r2,r4                                           
08072E66 F7FFFE55 bl      8072B14h   ;转区起始点设定                                     
08072E6A 7AE1     ldrb    r1,[r4,0Bh]                                     
08072E6C 203F     mov     r0,3Fh                                          
08072E6E 4008     and     r0,r1                                           
08072E70 2140     mov     r1,40h                                          
08072E72 4308     orr     r0,r1                                           
08072E74 72E0     strb    r0,[r4,0Bh]                                     
08072E76 464C     mov     r4,r9                                           
08072E78 4640     mov     r0,r8                                           
08072E7A 6801     ldr     r1,[r0]                                         
08072E7C 1C08     mov     r0,r1                                           
08072E7E 3041     add     r0,41h                                          
08072E80 7800     ldrb    r0,[r0]                                         
08072E82 0045     lsl     r5,r0,1h                                        
08072E84 1C08     mov     r0,r1                                           
08072E86 3015     add     r0,15h                                          
08072E88 3116     add     r1,16h                                          
08072E8A 197B     add     r3,r7,r5                                        
08072E8C 1C22     mov     r2,r4  

@@Peer:                                          
08072E8E F7FFFE41 bl      8072B14h  ;到达点设定???                                       
08072E92 3410     add     r4,10h                                          
08072E94 E0A1     b       8072FDAh                                        
08072E96 1C1A     mov     r2,r3                                           
08072E98 3244     add     r2,44h                                          
08072E9A 8810     ldrh    r0,[r2]                                         
08072E9C 2800     cmp     r0,0h                                           
08072E9E D100     bne     8072EA2h                                        
08072EA0 E09B     b       8072FDAh                                        
08072EA2 4B33     ldr     r3,=3000054h                                    
08072EA4 7818     ldrb    r0,[r3]                                         
08072EA6 2805     cmp     r0,5h                                           
08072EA8 D900     bls     8072EACh                                        
08072EAA E096     b       8072FDAh                                        
08072EAC 4931     ldr     r1,=87603F0h                                    
08072EAE 7818     ldrb    r0,[r3]                                         
08072EB0 0080     lsl     r0,r0,2h                                        
08072EB2 1840     add     r0,r0,r1                                        
08072EB4 6807     ldr     r7,[r0]                                         
08072EB6 2F00     cmp     r7,0h                                           
08072EB8 D100     bne     8072EBCh                                        
08072EBA E08E     b       8072FDAh                                        
08072EBC 2500     mov     r5,0h                                           
08072EBE 8810     ldrh    r0,[r2]                                         
08072EC0 2101     mov     r1,1h                                           
08072EC2 4008     and     r0,r1                                           
08072EC4 3EB4     sub     r6,0B4h                                         
08072EC6 46B4     mov     r12,r6                                          
08072EC8 2800     cmp     r0,0h                                           
08072ECA D008     beq     8072EDEh                                        
08072ECC 4E2A     ldr     r6,=840E038h                                    
08072ECE 7830     ldrb    r0,[r6]                                         
08072ED0 2300     mov     r3,0h                                           
08072ED2 2800     cmp     r0,0h                                           
08072ED4 D016     beq     8072F04h                                        
08072ED6 1998     add     r0,r3,r6                                        
08072ED8 7800     ldrb    r0,[r0]                                         
08072EDA 2801     cmp     r0,1h                                           
08072EDC D012     beq     8072F04h                                        
08072EDE 3501     add     r5,1h                                           
08072EE0 2D0E     cmp     r5,0Eh                                          
08072EE2 DC0F     bgt     8072F04h                                        
08072EE4 4641     mov     r1,r8                                           
08072EE6 6808     ldr     r0,[r1]                                         
08072EE8 3044     add     r0,44h                                          
08072EEA 8800     ldrh    r0,[r0]                                         
08072EEC 4128     asr     r0,r5                                           
08072EEE 2101     mov     r1,1h                                           
08072EF0 4008     and     r0,r1                                           
08072EF2 2800     cmp     r0,0h                                           
08072EF4 D0F3     beq     8072EDEh                                        
08072EF6 4E20     ldr     r6,=840E038h                                    
08072EF8 0068     lsl     r0,r5,1h                                        
08072EFA 1981     add     r1,r0,r6                                        
08072EFC 7809     ldrb    r1,[r1]                                         
08072EFE 1C03     mov     r3,r0                                           
08072F00 2900     cmp     r1,0h                                           
08072F02 D1E8     bne     8072ED6h                                        
08072F04 0068     lsl     r0,r5,1h                                        
08072F06 1940     add     r0,r0,r5                                        
08072F08 0080     lsl     r0,r0,2h                                        
08072F0A 4661     mov     r1,r12                                          
08072F0C 1846     add     r6,r0,r1                                        
08072F0E 79B0     ldrb    r0,[r6,6h]                                      
08072F10 2802     cmp     r0,2h                                           
08072F12 D862     bhi     8072FDAh                                        
08072F14 1C01     mov     r1,r0                                           
08072F16 0048     lsl     r0,r1,1h                                        
08072F18 1840     add     r0,r0,r1                                        
08072F1A 0040     lsl     r0,r0,1h                                        
08072F1C 183F     add     r7,r7,r0                                        
08072F1E 4D17     ldr     r5,=8345934h                                    
08072F20 46AC     mov     r12,r5                                          
08072F22 4817     ldr     r0,=8754BC4h                                    
08072F24 4680     mov     r8,r0                                           
08072F26 1C3B     mov     r3,r7                                           
08072F28 213F     mov     r1,3Fh                                          
08072F2A 4689     mov     r9,r1                                           
08072F2C 2640     mov     r6,40h                                          
08072F2E 2000     mov     r0,0h                                           
08072F30 5618     ldsb    r0,[r3,r0]                                      
08072F32 00C0     lsl     r0,r0,3h                                        
08072F34 4661     mov     r1,r12                                          
08072F36 1842     add     r2,r0,r1                                        
08072F38 4640     mov     r0,r8                                           
08072F3A 6801     ldr     r1,[r0]                                         
08072F3C 7810     ldrb    r0,[r2]                                         
08072F3E 7C89     ldrb    r1,[r1,12h]                                     
08072F40 4288     cmp     r0,r1                                           
08072F42 D122     bne     8072F8Ah                                        
08072F44 7890     ldrb    r0,[r2,2h]                                      
08072F46 0140     lsl     r0,r0,5h                                        
08072F48 8060     strh    r0,[r4,2h]                                      
08072F4A 2000     mov     r0,0h                                           
08072F4C 5618     ldsb    r0,[r3,r0]                                      
08072F4E 00C0     lsl     r0,r0,3h                                        
08072F50 1940     add     r0,r0,r5                                        
08072F52 78C0     ldrb    r0,[r0,3h]                                      
08072F54 3004     add     r0,4h                                           
08072F56 0140     lsl     r0,r0,5h                                        
08072F58 8020     strh    r0,[r4]                                         
08072F5A 7AE1     ldrb    r1,[r4,0Bh]                                     
08072F5C 4648     mov     r0,r9                                           
08072F5E 4008     and     r0,r1                                           
08072F60 4330     orr     r0,r6                                           
08072F62 72E0     strb    r0,[r4,0Bh]                                     
08072F64 2001     mov     r0,1h                                           
08072F66 5618     ldsb    r0,[r3,r0]                                      
08072F68 2800     cmp     r0,0h                                           
08072F6A DA0B     bge     8072F84h                                        
08072F6C 2002     mov     r0,2h                                           
08072F6E E00A     b       8072F86h                                        
08072F70 0054     lsl     r4,r2,1h                                        
08072F72 0300     lsl     r0,r0,0Ch                                       
08072F74 03F0     lsl     r0,r6,0Fh                                       
08072F76 0876     lsr     r6,r6,1h                                        
08072F78 E038     b       8072FECh                                        
08072F7A 0840     lsr     r0,r0,1h                                        
08072F7C 5934     ldr     r4,[r6,r4]                                      
08072F7E 0834     lsr     r4,r6,20h                                       
08072F80 4BC4     ldr     r3,=4700h                                       
08072F82 0875     lsr     r5,r6,1h                                        
08072F84 2003     mov     r0,3h                                           
08072F86 72A0     strb    r0,[r4,0Ah]                                     
08072F88 3410     add     r4,10h                                          
08072F8A 2000     mov     r0,0h                                           
08072F8C 5618     ldsb    r0,[r3,r0]                                      
08072F8E 00C0     lsl     r0,r0,3h                                        
08072F90 4661     mov     r1,r12                                          
08072F92 1842     add     r2,r0,r1                                        
08072F94 4640     mov     r0,r8                                           
08072F96 6801     ldr     r1,[r0]                                         
08072F98 7910     ldrb    r0,[r2,4h]                                      
08072F9A 7C89     ldrb    r1,[r1,12h]                                     
08072F9C 4288     cmp     r0,r1                                           
08072F9E D118     bne     8072FD2h                                        
08072FA0 7990     ldrb    r0,[r2,6h]                                      
08072FA2 0140     lsl     r0,r0,5h                                        
08072FA4 8060     strh    r0,[r4,2h]                                      
08072FA6 2000     mov     r0,0h                                           
08072FA8 5618     ldsb    r0,[r3,r0]                                      
08072FAA 00C0     lsl     r0,r0,3h                                        
08072FAC 1940     add     r0,r0,r5                                        
08072FAE 79C0     ldrb    r0,[r0,7h]                                      
08072FB0 3803     sub     r0,3h                                           
08072FB2 0140     lsl     r0,r0,5h                                        
08072FB4 8020     strh    r0,[r4]                                         
08072FB6 7AE1     ldrb    r1,[r4,0Bh]                                     
08072FB8 4648     mov     r0,r9                                           
08072FBA 4008     and     r0,r1                                           
08072FBC 4330     orr     r0,r6                                           
08072FBE 72E0     strb    r0,[r4,0Bh]                                     
08072FC0 2001     mov     r0,1h                                           
08072FC2 5618     ldsb    r0,[r3,r0]                                      
08072FC4 2800     cmp     r0,0h                                           
08072FC6 DA01     bge     8072FCCh                                        
08072FC8 2002     mov     r0,2h                                           
08072FCA E000     b       8072FCEh                                        
08072FCC 2003     mov     r0,3h                                           
08072FCE 72A0     strb    r0,[r4,0Ah]                                     
08072FD0 3410     add     r4,10h                                          
08072FD2 3302     add     r3,2h                                           
08072FD4 1D78     add     r0,r7,5                                         
08072FD6 4283     cmp     r3,r0                                           
08072FD8 DDA9     ble     8072F2Eh                                        
08072FDA 2500     mov     r5,0h                                           
08072FDC 491A     ldr     r1,=8754BC4h                                    
08072FDE 4688     mov     r8,r1                                           
08072FE0 2700     mov     r7,0h                                           
08072FE2 4640     mov     r0,r8                                           
08072FE4 6803     ldr     r3,[r0]                                         
08072FE6 1C18     mov     r0,r3                                           
08072FE8 3040     add     r0,40h                                          
08072FEA 7800     ldrb    r0,[r0]                                         
08072FEC 0600     lsl     r0,r0,18h                                       
08072FEE 1600     asr     r0,r0,18h                                       
08072FF0 4285     cmp     r5,r0                                           
08072FF2 D01C     beq     807302Eh                                        
08072FF4 1C18     mov     r0,r3                                           
08072FF6 3044     add     r0,44h                                          
08072FF8 8800     ldrh    r0,[r0]                                         
08072FFA 4128     asr     r0,r5                                           
08072FFC 2101     mov     r1,1h                                           
08072FFE 4008     and     r0,r1                                           
08073000 2800     cmp     r0,0h                                           
08073002 D014     beq     807302Eh                                        
08073004 4811     ldr     r0,=840DF78h                                    
08073006 183E     add     r6,r7,r0                                        
08073008 79B0     ldrb    r0,[r6,6h]                                      
0807300A 7C9B     ldrb    r3,[r3,12h]                                     
0807300C 4298     cmp     r0,r3                                           
0807300E D10E     bne     807302Eh                                        
08073010 7A70     ldrb    r0,[r6,9h]                                      
08073012 72A0     strb    r0,[r4,0Ah]                                     
08073014 79F0     ldrb    r0,[r6,7h]                                      
08073016 0140     lsl     r0,r0,5h                                        
08073018 8060     strh    r0,[r4,2h]                                      
0807301A 7A30     ldrb    r0,[r6,8h]                                      
0807301C 0140     lsl     r0,r0,5h                                        
0807301E 8020     strh    r0,[r4]                                         
08073020 7AE1     ldrb    r1,[r4,0Bh]                                     
08073022 203F     mov     r0,3Fh                                          
08073024 4008     and     r0,r1                                           
08073026 2140     mov     r1,40h                                          
08073028 4308     orr     r0,r1                                           
0807302A 72E0     strb    r0,[r4,0Bh]                                     
0807302C 3410     add     r4,10h                                          
0807302E 370C     add     r7,0Ch                                          
08073030 3501     add     r5,1h                                           
08073032 2D0F     cmp     r5,0Fh                                          
08073034 DDD5     ble     8072FE2h                                        
08073036 F000F88B bl      8073150h                                        
0807303A B005     add     sp,14h                                          
0807303C BC18     pop     r3,r4                                           
0807303E 4698     mov     r8,r3                                           
08073040 46A1     mov     r9,r4                                           
08073042 BCF0     pop     r4-r7                                           
08073044 BC01     pop     r0                                              
08073046 4700     bx      r0                                              


6AA05为当前区到当前区的位置
72a1f为换区