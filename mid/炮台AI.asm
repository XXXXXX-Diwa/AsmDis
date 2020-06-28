
;调用
08040A20 B570     push    r4-r6,r14                   
08040A22 4810     ldr     r0,=300083Ch                
08040A24 7805     ldrb    r5,[r0]         ;读取随机值              
08040A26 4C10     ldr     r4,=3000738h                
08040A28 00E8     lsl     r0,r5,3h        ;随机值的八倍            
08040A2A 300A     add     r0,0Ah          ;再加上0A            
08040A2C 1C21     mov     r1,r4                       
08040A2E 312C     add     r1,2Ch                      
08040A30 2200     mov     r2,0h                       
08040A32 7008     strb    r0,[r1]         ;写入偏移2C            
08040A34 7722     strb    r2,[r4,1Ch]                 
08040A36 2600     mov     r6,0h                       
08040A38 82E2     strh    r2,[r4,16h]     ;动画和动画帧归零             
08040A3A 8860     ldrh    r0,[r4,2h]                  
08040A3C 88A1     ldrh    r1,[r4,4h]                  
08040A3E 3140     add     r1,40h                      
08040A40 F7CEFE6E bl      800F720h        ;检查精灵的右边有没有砖块             
08040A44 2800     cmp     r0,0h                       
08040A46 D015     beq     @@RightNoBlock                    
08040A48 8821     ldrh    r1,[r4]                     
08040A4A 4808     ldr     r0,=0FDFFh                  
08040A4C 4008     and     r0,r1                       
08040A4E 8020     strh    r0,[r4]         ;取向去掉200                
08040A50 1C21     mov     r1,r4                       
08040A52 312D     add     r1,2Dh                      
08040A54 2002     mov     r0,2h                       
08040A56 7008     strb    r0,[r1]         ;偏移2D写入2             
08040A58 3102     add     r1,2h                       
08040A5A 7008     strb    r0,[r1]         ;偏移2F写入2            
08040A5C 4804     ldr     r0,=82FEA94h                
08040A5E 61A0     str     r0,[r4,18h]     ;写入OAM            
08040A60 E04B     b       @@Return                    
.pool

@@RightNoBlock:                  
08040A74 8860     ldrh    r0,[r4,2h]                  
08040A76 88A1     ldrh    r1,[r4,4h]                  
08040A78 3940     sub     r1,40h                      
08040A7A F7CEFE51 bl      800F720h        ;检查左边的砖块             
08040A7E 2800     cmp     r0,0h                       
08040A80 D012     beq     @@LeftRightNoBlock                    
08040A82 8820     ldrh    r0,[r4]                     
08040A84 2280     mov     r2,80h                      
08040A86 0092     lsl     r2,r2,2h                    
08040A88 1C11     mov     r1,r2                       
08040A8A 4308     orr     r0,r1                       
08040A8C 8020     strh    r0,[r4]         ;取向orr200                  
08040A8E 1C21     mov     r1,r4                       
08040A90 312D     add     r1,2Dh                      
08040A92 2006     mov     r0,6h                       
08040A94 7008     strb    r0,[r1]         ;偏移2D写入6            
08040A96 3102     add     r1,2h                       
08040A98 2001     mov     r0,1h                       
08040A9A 7008     strb    r0,[r1]         ;偏移2F写入2h            
08040A9C 4801     ldr     r0,=82FEB14h                
08040A9E 61A0     str     r0,[r4,18h]     ;写入OAM            
08040AA0 E02B     b       @@Return                    
.pool

@@LeftRightNoBlock:                   
08040AA8 2001     mov     r0,1h                       
08040AAA 4028     and     r0,r5                       
08040AAC 2800     cmp     r0,0h                       
08040AAE D005     beq     @@Half                        
08040AB0 8821     ldrh    r1,[r4]                     
08040AB2 4801     ldr     r0,=0FDFFh                  
08040AB4 4008     and     r0,r1          ;去掉200              
08040AB6 E006     b       @@Write                    
.pool

@@Half:                   
08040ABC 8820     ldrh    r0,[r4]                     
08040ABE 2280     mov     r2,80h                      
08040AC0 0092     lsl     r2,r2,2h                    
08040AC2 1C11     mov     r1,r2                       
08040AC4 4308     orr     r0,r1           ;加上200

@@Write:                      
08040AC6 8020     strh    r0,[r4]                     
08040AC8 2D07     cmp     r5,7h                       
08040ACA D90B     bls     @@Half2                   
08040ACC 4803     ldr     r0,=3000738h                
08040ACE 1C02     mov     r2,r0                       
08040AD0 322D     add     r2,2Dh                      
08040AD2 2106     mov     r1,6h                       
08040AD4 7011     strb    r1,[r2]         ;偏移2D写入6                
08040AD6 4902     ldr     r1,=82FEB14h                
08040AD8 E00A     b       @@Write2                    
.pool

@@Half2:                   
08040AE4 4806     ldr     r0,=3000738h                
08040AE6 1C02     mov     r2,r0                       
08040AE8 322D     add     r2,2Dh                      
08040AEA 2102     mov     r1,2h                       
08040AEC 7011     strb    r1,[r2]        ;偏移2D写入2             
08040AEE 4905     ldr     r1,=82FEA94h

@@Write2:                
08040AF0 6181     str     r1,[r0,18h]                 
08040AF2 1C01     mov     r1,r0                       
08040AF4 312F     add     r1,2Fh                      
08040AF6 2000     mov     r0,0h                       
08040AF8 7008     strb    r0,[r1]        ;偏移2F写入0

@@Return:                     
08040AFA BC70     pop     r4-r6                       
08040AFC BC01     pop     r0                          
08040AFE 4700     bx      r0                          
.pool

;炮台主程序                 
08040B08 B5F0     push    r4-r7,r14                   
08040B0A 4C0C     ldr     r4,=3000738h                
08040B0C 1C20     mov     r0,r4                       
08040B0E 3026     add     r0,26h                      
08040B10 2501     mov     r5,1h                       
08040B12 7005     strb    r5,[r0]       ;待机值写入1           
08040B14 2003     mov     r0,3h                       
08040B16 2127     mov     r1,27h                      
08040B18 F01FFED0 bl      80608BCh      ;检查母脑自爆事件              
08040B1C 2800     cmp     r0,0h                       
08040B1E D00F     beq     @@MotherBrainAlive                    
08040B20 8821     ldrh    r1,[r4]                     
08040B22 2002     mov     r0,2h                       
08040B24 4008     and     r0,r1         ;检查是否在屏幕内               
08040B26 2800     cmp     r0,0h                       
08040B28 D004     beq     @@PassDeathFireWorks                   
08040B2A 8860     ldrh    r0,[r4,2h]                  
08040B2C 88A1     ldrh    r1,[r4,4h]                  
08040B2E 221F     mov     r2,1Fh        ;爆炸的图像               
08040B30 F013FADC bl      80540ECh

@@PassDeathFireWorks:                    
08040B34 2000     mov     r0,0h                       
08040B36 8020     strh    r0,[r4]       ;抹去精灵                  
08040B38 E2EB     b       @@end                    
.pool
@@MotherBrainAlive:                   
08040B40 4818     ldr     r0,=300083Ch                
08040B42 7807     ldrb    r7,[r0]       ;读取精灵的随机值              
08040B44 1C23     mov     r3,r4                       
08040B46 3324     add     r3,24h                      
08040B48 7818     ldrb    r0,[r3]       ;读取pose              
08040B4A 2800     cmp     r0,0h                       
08040B4C D130     bne     @@PoseNoZero                    
08040B4E 1C20     mov     r0,r4                       
08040B50 3027     add     r0,27h                      
08040B52 2110     mov     r1,10h                      
08040B54 7001     strb    r1,[r0]       ;上视野写入10              
08040B56 3001     add     r0,1h                       
08040B58 7001     strb    r1,[r0]       ;左右视野写入10              
08040B5A 3001     add     r0,1h                       
08040B5C 7001     strb    r1,[r0]       ;下视野写入10              
08040B5E 2200     mov     r2,0h                       
08040B60 4911     ldr     r1,=0FFFCh                  
08040B62 8161     strh    r1,[r4,0Ah]                 
08040B64 2004     mov     r0,4h                       
08040B66 81A0     strh    r0,[r4,0Ch]                 
08040B68 81E1     strh    r1,[r4,0Eh]                 
08040B6A 8220     strh    r0,[r4,10h]   ;四面分界,象征性               
08040B6C 1C20     mov     r0,r4                       
08040B6E 3033     add     r0,33h                      
08040B70 7005     strb    r5,[r0]       ;偏移33写入1               
08040B72 380E     sub     r0,0Eh                      
08040B74 7002     strb    r2,[r0]                     
08040B76 1C21     mov     r1,r4                       
08040B78 3122     add     r1,22h                      
08040B7A 2005     mov     r0,5h                       
08040B7C 7008     strb    r0,[r1]       ;属性写入5               
08040B7E 480B     ldr     r0,=3000088h                
08040B80 7B01     ldrb    r1,[r0,0Ch]                 
08040B82 2003     mov     r0,3h                       
08040B84 4008     and     r0,r1                       
08040B86 1C21     mov     r1,r4                       
08040B88 3121     add     r1,21h                      
08040B8A 7008     strb    r0,[r1]       ;那个那个,对就是那个                
08040B8C 2009     mov     r0,9h                       
08040B8E 7018     strb    r0,[r3]       ;pose写入9               
08040B90 8860     ldrh    r0,[r4,2h]                  
08040B92 3820     sub     r0,20h                      
08040B94 8060     strh    r0,[r4,2h]    ;Y坐标向下一格再写入              
08040B96 F7FFFF43 bl      8040A20h                    
08040B9A 8860     ldrh    r0,[r4,2h]                  
08040B9C 80E0     strh    r0,[r4,6h]    ;Y坐标备份              
08040B9E 88A0     ldrh    r0,[r4,4h]                  
08040BA0 8120     strh    r0,[r4,8h]    ;X坐标备份              
08040BA2 E2B6     b       @@end                    
.pool

@@PoseNoZero:                   
08040BB0 88E6     ldrh    r6,[r4,6h]                  
08040BB2 8922     ldrh    r2,[r4,8h]    ;读取备份的坐标              
08040BB4 4804     ldr     r0,=30013D4h                
08040BB6 8A41     ldrh    r1,[r0,12h]   ;SAMUS X坐标              
08040BB8 7F60     ldrb    r0,[r4,1Dh]                 
08040BBA 2888     cmp     r0,88h                      
08040BBC D032     beq     @@ID88                    
08040BBE 2888     cmp     r0,88h                      
08040BC0 DC04     bgt     @@Bgt88                    
08040BC2 287E     cmp     r0,7Eh                      
08040BC4 D005     beq     @@ID7E                    
08040BC6 E09E     b       @@Other                    
.pool

@@Bgt88:                   
08040BCC 2889     cmp     r0,89h                      
08040BCE D05D     beq     @@ID89                    
08040BD0 E099     b       @@Other 

@@ID7E:                   
08040BD2 2514     mov     r5,14h        ;偏移格数14h                
08040BD4 8823     ldrh    r3,[r4]                     
08040BD6 2680     mov     r6,80h                      
08040BD8 0136     lsl     r6,r6,4h                    
08040BDA 1C30     mov     r0,r6                       
08040BDC 4018     and     r0,r3         ;检查取向是否有800              
08040BDE 2800     cmp     r0,0h                       
08040BE0 D012     beq     @@No800                    
08040BE2 4E07     ldr     r6,=0FFFFFB00h              
08040BE4 1990     add     r0,r2,r6      ;X坐标向左500h 20格              
08040BE6 0400     lsl     r0,r0,10h                   
08040BE8 0C02     lsr     r2,r0,10h                   
08040BEA 428A     cmp     r2,r1         ;和samus的X坐标比较              
08040BEC D248     bcs     @@Xcoordinates                    
08040BEE 1A89     sub     r1,r1,r2      ;samus坐标距离那个坐标              
08040BF0 0168     lsl     r0,r5,5h      ;10格              
08040BF2 4281     cmp     r1,r0         ;检查是否走到中间?              
08040BF4 DD44     ble     @@Xcoordinates                    
08040BF6 4803     ldr     r0,=0F7FFh                  
08040BF8 4018     and     r0,r3                       
08040BFA 8020     strh    r0,[r4]       ;去掉800h              
08040BFC 8920     ldrh    r0,[r4,8h]    ;读取原X坐标备份              
08040BFE E038     b       @@Xcoordinates2                    
.pool

@@No800:                   
08040C08 4291     cmp     r1,r2               ;检查Samus是否在原始坐标的右边         
08040C0A D239     bcs     @@Xcoordinates                    
08040C0C 1A51     sub     r1,r2,r1            ;不在右边则减去原坐标        
08040C0E 0168     lsl     r0,r5,5h            ;距离是否大于10格        
08040C10 4281     cmp     r1,r0                       
08040C12 DD35     ble     @@XCoordinates      ;10格内则写入原坐标                  
08040C14 1C30     mov     r0,r6                       
08040C16 4318     orr     r0,r3                       
08040C18 8020     strh    r0,[r4]             ;取向orr800              
08040C1A 4901     ldr     r1,=0FFFFFB00h              
08040C1C E028     b       @@Peer                    
.pool

@@ID88:                   
08040C24 2518     mov     r5,18h              ;24格数         
08040C26 8823     ldrh    r3,[r4]                     
08040C28 2680     mov     r6,80h                      
08040C2A 0136     lsl     r6,r6,4h                    
08040C2C 1C30     mov     r0,r6                       
08040C2E 4018     and     r0,r3                       
08040C30 2800     cmp     r0,0h               ;检查是否有800          
08040C32 D013     beq     @@No800Two                    
08040C34 4E07     ldr     r6,=0FFFFFA00h              
08040C36 1990     add     r0,r2,r6            ;X坐标向左24格        
08040C38 0400     lsl     r0,r0,10h                   
08040C3A 0C02     lsr     r2,r0,10h                   
08040C3C 428A     cmp     r2,r1               ;和samus的坐标比较        
08040C3E D21F     bcs     @@Xcoordinates      ;在左边则把这个坐标写入新坐标              
08040C40 1A89     sub     r1,r1,r2            ;在左边则减去samus的坐标       
08040C42 0168     lsl     r0,r5,5h                    
08040C44 4281     cmp     r1,r0               ;检查是否有12格        
08040C46 DD1B     ble     @@Xcoordinates      ;如果在12格以内依然写入新坐标              
08040C48 4803     ldr     r0,=0F7FFh                  
08040C4A 4018     and     r0,r3                       
08040C4C 8020     strh    r0,[r4]             ;去掉800h        
08040C4E 8920     ldrh    r0,[r4,8h]          ;读取原的X坐标备份        
08040C50 E00F     b       @@Xcoordinates2                                     
.pool

@@No800Two:                 
08040C5C 4291     cmp     r1,r2               ;samus坐标和原坐标比较        
08040C5E D20F     bcs     @@Xcoordinates      ;在右边则直接写入              
08040C60 1A51     sub     r1,r2,r1            ;在左边则减去原坐标        
08040C62 0168     lsl     r0,r5,5h                    
08040C64 4281     cmp     r1,r0               ;检查距离是否小于12格        
08040C66 DD0B     ble     @@Xcoordinates      ;小于则直接写入原坐标              
08040C68 1C30     mov     r0,r6                       
08040C6A 4318     orr     r0,r3                       
08040C6C 8020     strh    r0,[r4]             ;否则取向orr800        
08040C6E 4903     ldr     r1,=0FFFFFA00h      ;坐标偏移 

@@Peer:             
08040C70 1850     add     r0,r2,r1  

@@Xcoordinates2:                  
08040C72 80A0     strh    r0,[r4,4h]                  
08040C74 F7FFFED4 bl      8040A20h            ;重新检查一次左右的砖块         
08040C78 E045     b       @@Other                    
.pool

@@Xcoordinates:                   
08040C80 4801     ldr     r0,=3000738h                
08040C82 8082     strh    r2,[r0,4h]                  
08040C84 E03F     b       @@Other                    
.pool

@@ID89:                  
08040C8C 2518     mov     r5,18h              ;24格       
08040C8E 8823     ldrh    r3,[r4]                     
08040C90 2080     mov     r0,80h                      
08040C92 0100     lsl     r0,r0,4h                    
08040C94 4684     mov     r12,r0                      
08040C96 4018     and     r0,r3                       
08040C98 2800     cmp     r0,0h                       
08040C9A D01D     beq     @@No800Three                    
08040C9C 4808     ldr     r0,=0FFFFFA00h              
08040C9E 1812     add     r2,r2,r0                    
08040CA0 0410     lsl     r0,r2,10h                   
08040CA2 0C02     lsr     r2,r0,10h          ;原x坐标向左24格            
08040CA4 428A     cmp     r2,r1              ;和samus的x坐标比较         
08040CA6 D20F     bcs     @@Up1           ;在右边的话         
08040CA8 1A89     sub     r1,r1,r2                    
08040CAA 0168     lsl     r0,r5,5h                    
08040CAC 4281     cmp     r1,r0                       
08040CAE DD0B     ble     @@Up1                    
08040CB0 4804     ldr     r0,=0F7FFh                  
08040CB2 4018     and     r0,r3           ;取向去掉800            
08040CB4 8020     strh    r0,[r4]                     
08040CB6 8920     ldrh    r0,[r4,8h]                  
08040CB8 80A0     strh    r0,[r4,4h]      ;原x坐标写入当前坐标             
08040CBA 88E0     ldrh    r0,[r4,6h]                  
08040CBC E01A     b       @@ReCheck                   
.pool
 
@@Up1: 
08040CC8 4902     ldr     r1,=3000738h                
08040CCA 808A     strh    r2,[r1,4h]        ;写入新坐标            
08040CCC 1C30     mov     r0,r6                       
08040CCE 3840     sub     r0,40h                      
08040CD0 8048     strh    r0,[r1,2h]        ;Y坐标向上一格再写入           
08040CD2 E018     b       @@Other                    
.pool

@@No800Three:                   
08040CD8 4291     cmp     r1,r2             ;Samus x坐标和精灵坐标比较          
08040CDA D211     bcs     @@WriteOld        ;在右边          
08040CDC 1A51     sub     r1,r2,r1          ;samus在左边则减           
08040CDE 0168     lsl     r0,r5,5h                    
08040CE0 4281     cmp     r1,r0             ;检查距离是否小于12格           
08040CE2 DD0D     ble     @@WriteOld               
08040CE4 4660     mov     r0,r12                      
08040CE6 4318     orr     r0,r3                       
08040CE8 8020     strh    r0,[r4]           ;取向orr800           
08040CEA 4904     ldr     r1,=0FFFFFA00h              
08040CEC 1850     add     r0,r2,r1                    
08040CEE 80A0     strh    r0,[r4,4h]        ;写入新x坐标          
08040CF0 1C30     mov     r0,r6                       
08040CF2 3840     sub     r0,40h            ;Y坐标向上一格再写入

@@ReCheck:                     
08040CF4 8060     strh    r0,[r4,2h]                  
08040CF6 F7FFFE93 bl      8040A20h         ;继续检查左右的砖块             
08040CFA E004     b       @@Other                    
.pool


@@WriteOld:                  
08040D00 4806     ldr     r0,=3000738h                
08040D02 8082     strh    r2,[r0,4h]                  
08040D04 8046     strh    r6,[r0,2h] 

@@Other:                 
08040D06 4805     ldr     r0,=3000738h                
08040D08 302D     add     r0,2Dh                      
08040D0A 7800     ldrb    r0,[r0]          ;读取偏移2D            
08040D0C 2808     cmp     r0,8h            ;和8比较           
08040D0E D900     bls     @@Pass                    
08040D10 E1FF     b       @@end   

@@Pass:                 
08040D12 0080     lsl     r0,r0,2h                    
08040D14 4902     ldr     r1,=8040D24h                
08040D16 1840     add     r0,r0,r1                    
08040D18 6800     ldr     r0,[r0]                     
08040D1A 4687     mov     r15,r0                      
.pool  

PoseTable:                 
    .dw 0x8040D48 ;0
    .dw 0x8040DB8 ;1
    .dw 0x8040E0C ;2
    .dw 0x8040E88 ;3
    .dw 0x8040EDC ;4
    .dw 0x8040F70 ;5
    .dw 0x8040FC4 ;6
    .dw 0x804104C ;7
    .dw 0x80410B0 ;8

                  ldr     r4,=3000738h                
08040D4A 69A1     ldr     r1,[r4,18h]                 
08040D4C 4807     ldr     r0,=82FEA64h                
08040D4E 4281     cmp     r1,r0                       
08040D50 D112     bne     8040D78h                    
08040D52 F7CEFF39 bl      800FBC8h                    
08040D56 2800     cmp     r0,0h                       
08040D58 D00C     beq     8040D74h                    
08040D5A 4805     ldr     r0,=82FEA54h                
08040D5C 61A0     str     r0,[r4,18h]                 
08040D5E 2000     mov     r0,0h                       
08040D60 7720     strb    r0,[r4,1Ch]                 
08040D62 82E0     strh    r0,[r4,16h]                 
08040D64 E008     b       8040D78h                    
08040D66 0000     lsl     r0,r0,0h                    
08040D68 0738     lsl     r0,r7,1Ch                   
08040D6A 0300     lsl     r0,r0,0Ch                   
08040D6C EA64     ????                                
08040D6E 082F     lsr     r7,r5,20h                   
08040D70 EA54     ????                                
08040D72 082F     lsr     r7,r5,20h                   
08040D74 F7FFFE2E bl      80409D4h                    
08040D78 4A0D     ldr     r2,=3000738h                
08040D7A 1C13     mov     r3,r2                       
08040D7C 332C     add     r3,2Ch                      
08040D7E 7818     ldrb    r0,[r3]                     
08040D80 3801     sub     r0,1h                       
08040D82 7018     strb    r0,[r3]                     
08040D84 0600     lsl     r0,r0,18h                   
08040D86 0E01     lsr     r1,r0,18h                   
08040D88 2900     cmp     r1,0h                       
08040D8A D000     beq     8040D8Eh                    
08040D8C E1C1     b       @@end                    
08040D8E 2042     mov     r0,42h                      
08040D90 7018     strb    r0,[r3]                     
08040D92 7711     strb    r1,[r2,1Ch]                 
08040D94 82D1     strh    r1,[r2,16h]                 
08040D96 1C11     mov     r1,r2                       
08040D98 312D     add     r1,2Dh                      
08040D9A 7808     ldrb    r0,[r1]                     
08040D9C 3001     add     r0,1h                       
08040D9E 7008     strb    r0,[r1]                     
08040DA0 4804     ldr     r0,=82FEA84h                
08040DA2 6190     str     r0,[r2,18h]                 
08040DA4 8811     ldrh    r1,[r2]                     
08040DA6 2380     mov     r3,80h                      
08040DA8 009B     lsl     r3,r3,2h                    
08040DAA 1C18     mov     r0,r3                       
08040DAC 4308     orr     r0,r1                       
08040DAE E1AF     b       8041110h                    
08040DB0 0738     lsl     r0,r7,1Ch                   
08040DB2 0300     lsl     r0,r0,0Ch                   
08040DB4 EA84     ????                                
08040DB6 082F     lsr     r7,r5,20h                   
08040DB8 F7CEFF06 bl      800FBC8h                    
08040DBC 2800     cmp     r0,0h                       
08040DBE D100     bne     8040DC2h                    
08040DC0 E1A7     b       @@end                    
08040DC2 4A06     ldr     r2,=3000738h                
08040DC4 8811     ldrh    r1,[r2]                     
08040DC6 2080     mov     r0,80h                      
08040DC8 0080     lsl     r0,r0,2h                    
08040DCA 4008     and     r0,r1                       
08040DCC 1C11     mov     r1,r2                       
08040DCE 2800     cmp     r0,0h                       
08040DD0 D012     beq     8040DF8h                    
08040DD2 2F02     cmp     r7,2h                       
08040DD4 D906     bls     8040DE4h                    
08040DD6 4802     ldr     r0,=82FEAA4h                
08040DD8 E005     b       8040DE6h                    
08040DDA 0000     lsl     r0,r0,0h                    
08040DDC 0738     lsl     r0,r7,1Ch                   
08040DDE 0300     lsl     r0,r0,0Ch                   
08040DE0 EAA4     ????                                
08040DE2 082F     lsr     r7,r5,20h                   
08040DE4 4803     ldr     r0,=82FEA94h                
08040DE6 6188     str     r0,[r1,18h]                 
08040DE8 1C0A     mov     r2,r1                       
08040DEA 322D     add     r2,2Dh                      
08040DEC 7810     ldrb    r0,[r2]                     
08040DEE 3001     add     r0,1h                       
08040DF0 E156     b       80410A0h                    
08040DF2 0000     lsl     r0,r0,0h                    
08040DF4 EA94     ????                                
08040DF6 082F     lsr     r7,r5,20h                   
08040DF8 2F0A     cmp     r7,0Ah                      
08040DFA D903     bls     8040E04h                    
08040DFC 4800     ldr     r0,=82FEA64h                
08040DFE E14A     b       8041096h                    
08040E00 EA64     ????                                
08040E02 082F     lsr     r7,r5,20h                   
08040E04 4800     ldr     r0,=82FEA54h                
08040E06 E146     b       8041096h                    
08040E08 EA54     ????                                
08040E0A 082F     lsr     r7,r5,20h                   
08040E0C 4C07     ldr     r4,=3000738h                
08040E0E 69A1     ldr     r1,[r4,18h]                 
08040E10 4807     ldr     r0,=82FEAA4h                
08040E12 4281     cmp     r1,r0                       
08040E14 D112     bne     8040E3Ch                    
08040E16 F7CEFED7 bl      800FBC8h                    
08040E1A 2800     cmp     r0,0h                       
08040E1C D00C     beq     8040E38h                    
08040E1E 4805     ldr     r0,=82FEA94h                
08040E20 61A0     str     r0,[r4,18h]                 
08040E22 2000     mov     r0,0h                       
08040E24 7720     strb    r0,[r4,1Ch]                 
08040E26 82E0     strh    r0,[r4,16h]                 
08040E28 E008     b       8040E3Ch                    
08040E2A 0000     lsl     r0,r0,0h                    
08040E2C 0738     lsl     r0,r7,1Ch                   
08040E2E 0300     lsl     r0,r0,0Ch                   
08040E30 EAA4     ????                                
08040E32 082F     lsr     r7,r5,20h                   
08040E34 EA94     ????                                
08040E36 082F     lsr     r7,r5,20h                   
08040E38 F7FFFDCC bl      80409D4h                    
08040E3C 4A0C     ldr     r2,=3000738h                
08040E3E 1C13     mov     r3,r2                       
08040E40 332C     add     r3,2Ch                      
08040E42 7818     ldrb    r0,[r3]                     
08040E44 3801     sub     r0,1h                       
08040E46 7018     strb    r0,[r3]                     
08040E48 0600     lsl     r0,r0,18h                   
08040E4A 0E01     lsr     r1,r0,18h                   
08040E4C 2900     cmp     r1,0h                       
08040E4E D000     beq     8040E52h                    
08040E50 E15F     b       @@end                    
08040E52 2042     mov     r0,42h                      
08040E54 7018     strb    r0,[r3]                     
08040E56 7711     strb    r1,[r2,1Ch]                 
08040E58 82D1     strh    r1,[r2,16h]                 
08040E5A 8811     ldrh    r1,[r2]                     
08040E5C 2080     mov     r0,80h                      
08040E5E 0080     lsl     r0,r0,2h                    
08040E60 4008     and     r0,r1                       
08040E62 2800     cmp     r0,0h                       
08040E64 D006     beq     8040E74h                    
08040E66 1C11     mov     r1,r2                       
08040E68 312D     add     r1,2Dh                      
08040E6A 7808     ldrb    r0,[r1]                     
08040E6C 3001     add     r0,1h                       
08040E6E E079     b       8040F64h                    
08040E70 0738     lsl     r0,r7,1Ch                   
08040E72 0300     lsl     r0,r0,0Ch                   
08040E74 1C11     mov     r1,r2                       
08040E76 312D     add     r1,2Dh                      
08040E78 7808     ldrb    r0,[r1]                     
08040E7A 3801     sub     r0,1h                       
08040E7C 7008     strb    r0,[r1]                     
08040E7E 4801     ldr     r0,=82FEA84h                
08040E80 6190     str     r0,[r2,18h]                 
08040E82 E146     b       @@end                    
08040E84 EA84     ????                                
08040E86 082F     lsr     r7,r5,20h                   
08040E88 F7CEFE9E bl      800FBC8h                    
08040E8C 2800     cmp     r0,0h                       
08040E8E D100     bne     8040E92h                    
08040E90 E13F     b       @@end                    
08040E92 4A06     ldr     r2,=3000738h                
08040E94 8811     ldrh    r1,[r2]                     
08040E96 2080     mov     r0,80h                      
08040E98 0080     lsl     r0,r0,2h                    
08040E9A 4008     and     r0,r1                       
08040E9C 1C11     mov     r1,r2                       
08040E9E 2800     cmp     r0,0h                       
08040EA0 D012     beq     8040EC8h                    
08040EA2 2F04     cmp     r7,4h                       
08040EA4 D906     bls     8040EB4h                    
08040EA6 4802     ldr     r0,=82FEAE4h                
08040EA8 E005     b       8040EB6h                    
08040EAA 0000     lsl     r0,r0,0h                    
08040EAC 0738     lsl     r0,r7,1Ch                   
08040EAE 0300     lsl     r0,r0,0Ch                   
08040EB0 EAE4     ????                                
08040EB2 082F     lsr     r7,r5,20h                   
08040EB4 4803     ldr     r0,=82FEAD4h                
08040EB6 6188     str     r0,[r1,18h]                 
08040EB8 1C0A     mov     r2,r1                       
08040EBA 322D     add     r2,2Dh                      
08040EBC 7810     ldrb    r0,[r2]                     
08040EBE 3001     add     r0,1h                       
08040EC0 E0EE     b       80410A0h                    
08040EC2 0000     lsl     r0,r0,0h                    
08040EC4 EAD4     ????                                
08040EC6 082F     lsr     r7,r5,20h                   
08040EC8 2F02     cmp     r7,2h                       
08040ECA D903     bls     8040ED4h                    
08040ECC 4800     ldr     r0,=82FEAA4h                
08040ECE E0E2     b       8041096h                    
08040ED0 EAA4     ????                                
08040ED2 082F     lsr     r7,r5,20h                   
08040ED4 4800     ldr     r0,=82FEA94h                
08040ED6 E0DE     b       8041096h                    
08040ED8 EA94     ????                                
08040EDA 082F     lsr     r7,r5,20h                   
08040EDC 4C07     ldr     r4,=3000738h                
08040EDE 69A1     ldr     r1,[r4,18h]                 
08040EE0 4807     ldr     r0,=82FEAE4h                
08040EE2 4281     cmp     r1,r0                       
08040EE4 D112     bne     8040F0Ch                    
08040EE6 F7CEFE6F bl      800FBC8h                    
08040EEA 2800     cmp     r0,0h                       
08040EEC D00C     beq     8040F08h                    
08040EEE 4805     ldr     r0,=82FEAD4h                
08040EF0 61A0     str     r0,[r4,18h]                 
08040EF2 2000     mov     r0,0h                       
08040EF4 7720     strb    r0,[r4,1Ch]                 
08040EF6 82E0     strh    r0,[r4,16h]                 
08040EF8 E008     b       8040F0Ch                    
08040EFA 0000     lsl     r0,r0,0h                    
08040EFC 0738     lsl     r0,r7,1Ch                   
08040EFE 0300     lsl     r0,r0,0Ch                   
08040F00 EAE4     ????                                
08040F02 082F     lsr     r7,r5,20h                   
08040F04 EAD4     ????                                
08040F06 082F     lsr     r7,r5,20h                   
08040F08 F7FFFD64 bl      80409D4h                    
08040F0C 4A12     ldr     r2,=3000738h                
08040F0E 1C13     mov     r3,r2                       
08040F10 332C     add     r3,2Ch                      
08040F12 7818     ldrb    r0,[r3]                     
08040F14 3801     sub     r0,1h                       
08040F16 7018     strb    r0,[r3]                     
08040F18 0600     lsl     r0,r0,18h                   
08040F1A 0E01     lsr     r1,r0,18h                   
08040F1C 2900     cmp     r1,0h                       
08040F1E D000     beq     8040F22h                    
08040F20 E0F7     b       @@end                    
08040F22 2042     mov     r0,42h                      
08040F24 7018     strb    r0,[r3]                     
08040F26 7711     strb    r1,[r2,1Ch]                 
08040F28 82D1     strh    r1,[r2,16h]                 
08040F2A 1C10     mov     r0,r2                       
08040F2C 302F     add     r0,2Fh                      
08040F2E 7800     ldrb    r0,[r0]                     
08040F30 2800     cmp     r0,0h                       
08040F32 D005     beq     8040F40h                    
08040F34 8810     ldrh    r0,[r2]                     
08040F36 2680     mov     r6,80h                      
08040F38 00B6     lsl     r6,r6,2h                    
08040F3A 1C31     mov     r1,r6                       
08040F3C 4048     eor     r0,r1                       
08040F3E 8010     strh    r0,[r2]                     
08040F40 8811     ldrh    r1,[r2]                     
08040F42 2080     mov     r0,80h                      
08040F44 0080     lsl     r0,r0,2h                    
08040F46 4008     and     r0,r1                       
08040F48 2800     cmp     r0,0h                       
08040F4A D007     beq     8040F5Ch                    
08040F4C 1C11     mov     r1,r2                       
08040F4E 312D     add     r1,2Dh                      
08040F50 7808     ldrb    r0,[r1]                     
08040F52 3001     add     r0,1h                       
08040F54 E074     b       8041040h                    
08040F56 0000     lsl     r0,r0,0h                    
08040F58 0738     lsl     r0,r7,1Ch                   
08040F5A 0300     lsl     r0,r0,0Ch                   
08040F5C 1C11     mov     r1,r2                       
08040F5E 312D     add     r1,2Dh                      
08040F60 7808     ldrb    r0,[r1]                     
08040F62 3801     sub     r0,1h                       
08040F64 7008     strb    r0,[r1]                     
08040F66 4801     ldr     r0,=82FEAC4h                
08040F68 6190     str     r0,[r2,18h]                 
08040F6A E0D2     b       @@end                    
08040F6C EAC4     ????                                
08040F6E 082F     lsr     r7,r5,20h                   
08040F70 F7CEFE2A bl      800FBC8h                    
08040F74 2800     cmp     r0,0h                       
08040F76 D100     bne     8040F7Ah                    
08040F78 E0CB     b       @@end                    
08040F7A 4A06     ldr     r2,=3000738h                
08040F7C 8811     ldrh    r1,[r2]                     
08040F7E 2080     mov     r0,80h                      
08040F80 0080     lsl     r0,r0,2h                    
08040F82 4008     and     r0,r1                       
08040F84 1C11     mov     r1,r2                       
08040F86 2800     cmp     r0,0h                       
08040F88 D012     beq     8040FB0h                    
08040F8A 2F02     cmp     r7,2h                       
08040F8C D906     bls     8040F9Ch                    
08040F8E 4802     ldr     r0,=82FEB24h                
08040F90 E005     b       8040F9Eh                    
08040F92 0000     lsl     r0,r0,0h                    
08040F94 0738     lsl     r0,r7,1Ch                   
08040F96 0300     lsl     r0,r0,0Ch                   
08040F98 EB24     ????                                
08040F9A 082F     lsr     r7,r5,20h                   
08040F9C 4803     ldr     r0,=82FEB14h                
08040F9E 6188     str     r0,[r1,18h]                 
08040FA0 1C0A     mov     r2,r1                       
08040FA2 322D     add     r2,2Dh                      
08040FA4 7810     ldrb    r0,[r2]                     
08040FA6 3001     add     r0,1h                       
08040FA8 E07A     b       80410A0h                    
08040FAA 0000     lsl     r0,r0,0h                    
08040FAC EB14     ????                                
08040FAE 082F     lsr     r7,r5,20h                   
08040FB0 2F04     cmp     r7,4h                       
08040FB2 D903     bls     8040FBCh                    
08040FB4 4800     ldr     r0,=82FEAE4h                
08040FB6 E06E     b       8041096h                    
08040FB8 EAE4     ????                                
08040FBA 082F     lsr     r7,r5,20h                   
08040FBC 4800     ldr     r0,=82FEAD4h                
08040FBE E06A     b       8041096h                    
08040FC0 EAD4     ????                                
08040FC2 082F     lsr     r7,r5,20h                   
08040FC4 4C07     ldr     r4,=3000738h                
08040FC6 69A1     ldr     r1,[r4,18h]                 
08040FC8 4807     ldr     r0,=82FEB24h                
08040FCA 4281     cmp     r1,r0                       
08040FCC D112     bne     8040FF4h                    
08040FCE F7CEFDFB bl      800FBC8h                    
08040FD2 2800     cmp     r0,0h                       
08040FD4 D00C     beq     8040FF0h                    
08040FD6 4805     ldr     r0,=82FEB14h                
08040FD8 61A0     str     r0,[r4,18h]                 
08040FDA 2000     mov     r0,0h                       
08040FDC 7720     strb    r0,[r4,1Ch]                 
08040FDE 82E0     strh    r0,[r4,16h]                 
08040FE0 E008     b       8040FF4h                    
08040FE2 0000     lsl     r0,r0,0h                    
08040FE4 0738     lsl     r0,r7,1Ch                   
08040FE6 0300     lsl     r0,r0,0Ch                   
08040FE8 EB24     ????                                
08040FEA 082F     lsr     r7,r5,20h                   
08040FEC EB14     ????                                
08040FEE 082F     lsr     r7,r5,20h                   
08040FF0 F7FFFCF0 bl      80409D4h                    
08040FF4 4A0E     ldr     r2,=3000738h                
08040FF6 1C13     mov     r3,r2                       
08040FF8 332C     add     r3,2Ch                      
08040FFA 7818     ldrb    r0,[r3]                     
08040FFC 3801     sub     r0,1h                       
08040FFE 7018     strb    r0,[r3]                     
08041000 0600     lsl     r0,r0,18h                   
08041002 0E01     lsr     r1,r0,18h                   
08041004 2900     cmp     r1,0h                       
08041006 D000     beq     804100Ah                    
08041008 E083     b       @@end                    
0804100A 2042     mov     r0,42h                      
0804100C 7018     strb    r0,[r3]                     
0804100E 7711     strb    r1,[r2,1Ch]                 
08041010 82D1     strh    r1,[r2,16h]                 
08041012 8811     ldrh    r1,[r2]                     
08041014 2080     mov     r0,80h                      
08041016 0080     lsl     r0,r0,2h                    
08041018 4008     and     r0,r1                       
0804101A 2800     cmp     r0,0h                       
0804101C D00C     beq     8041038h                    
0804101E 1C11     mov     r1,r2                       
08041020 312D     add     r1,2Dh                      
08041022 7808     ldrb    r0,[r1]                     
08041024 3001     add     r0,1h                       
08041026 7008     strb    r0,[r1]                     
08041028 4802     ldr     r0,=82FEB44h                
0804102A 6190     str     r0,[r2,18h]                 
0804102C E071     b       @@end                    
0804102E 0000     lsl     r0,r0,0h                    
08041030 0738     lsl     r0,r7,1Ch                   
08041032 0300     lsl     r0,r0,0Ch                   
08041034 EB44     ????                                
08041036 082F     lsr     r7,r5,20h                   
08041038 1C11     mov     r1,r2                       
0804103A 312D     add     r1,2Dh                      
0804103C 7808     ldrb    r0,[r1]                     
0804103E 3801     sub     r0,1h                       
08041040 7008     strb    r0,[r1]                     
08041042 4801     ldr     r0,=82FEB04h                
08041044 6190     str     r0,[r2,18h]                 
08041046 E064     b       @@end                    
08041048 EB04     ????                                
0804104A 082F     lsr     r7,r5,20h                   
0804104C F7CEFDBC bl      800FBC8h                    
08041050 2800     cmp     r0,0h                       
08041052 D05E     beq     @@end                    
08041054 4A05     ldr     r2,=3000738h                
08041056 8811     ldrh    r1,[r2]                     
08041058 2080     mov     r0,80h                      
0804105A 0080     lsl     r0,r0,2h                    
0804105C 4008     and     r0,r1                       
0804105E 1C11     mov     r1,r2                       
08041060 2800     cmp     r0,0h                       
08041062 D011     beq     8041088h                    
08041064 2F0A     cmp     r7,0Ah                      
08041066 D905     bls     8041074h                    
08041068 4801     ldr     r0,=82FEB64h                
0804106A E004     b       8041076h                    
0804106C 0738     lsl     r0,r7,1Ch                   
0804106E 0300     lsl     r0,r0,0Ch                   
08041070 EB64     ????                                
08041072 082F     lsr     r7,r5,20h                   
08041074 4803     ldr     r0,=82FEB54h                
08041076 6188     str     r0,[r1,18h]                 
08041078 1C0A     mov     r2,r1                       
0804107A 322D     add     r2,2Dh                      
0804107C 7810     ldrb    r0,[r2]                     
0804107E 3001     add     r0,1h                       
08041080 E00E     b       80410A0h                    
08041082 0000     lsl     r0,r0,0h                    
08041084 EB54     ????                                
08041086 082F     lsr     r7,r5,20h                   
08041088 2F02     cmp     r7,2h                       
0804108A D903     bls     8041094h                    
0804108C 4800     ldr     r0,=82FEB24h                
0804108E E002     b       8041096h                    
08041090 EB24     ????                                
08041092 082F     lsr     r7,r5,20h                   
08041094 4805     ldr     r0,=82FEB14h                
08041096 6188     str     r0,[r1,18h]                 
08041098 1C0A     mov     r2,r1                       
0804109A 322D     add     r2,2Dh                      
0804109C 7810     ldrb    r0,[r2]                     
0804109E 3801     sub     r0,1h                       
080410A0 7010     strb    r0,[r2]                     
080410A2 2000     mov     r0,0h                       
080410A4 7708     strb    r0,[r1,1Ch]                 
080410A6 82C8     strh    r0,[r1,16h]                 
080410A8 E033     b       @@end                    
080410AA 0000     lsl     r0,r0,0h                    
080410AC EB14     ????                                
080410AE 082F     lsr     r7,r5,20h                   
080410B0 4C07     ldr     r4,=3000738h                
080410B2 69A1     ldr     r1,[r4,18h]                 
080410B4 4807     ldr     r0,=82FEB64h                
080410B6 4281     cmp     r1,r0                       
080410B8 D112     bne     80410E0h                    
080410BA F7CEFD85 bl      800FBC8h                    
080410BE 2800     cmp     r0,0h                       
080410C0 D00C     beq     80410DCh                    
080410C2 4805     ldr     r0,=82FEB54h                
080410C4 61A0     str     r0,[r4,18h]                 
080410C6 2000     mov     r0,0h                       
080410C8 7720     strb    r0,[r4,1Ch]                 
080410CA 82E0     strh    r0,[r4,16h]                 
080410CC E008     b       80410E0h                    
080410CE 0000     lsl     r0,r0,0h                    
080410D0 0738     lsl     r0,r7,1Ch                   
080410D2 0300     lsl     r0,r0,0Ch                   
080410D4 EB64     ????                                
080410D6 082F     lsr     r7,r5,20h                   
080410D8 EB54     ????                                
080410DA 082F     lsr     r7,r5,20h                   
080410DC F7FFFC7A bl      80409D4h                    
080410E0 4A0D     ldr     r2,=3000738h                
080410E2 1C13     mov     r3,r2                       
080410E4 332C     add     r3,2Ch                      
080410E6 7818     ldrb    r0,[r3]                     
080410E8 3801     sub     r0,1h                       
080410EA 7018     strb    r0,[r3]                     
080410EC 0600     lsl     r0,r0,18h                   
080410EE 0E01     lsr     r1,r0,18h                   
080410F0 2900     cmp     r1,0h                       
080410F2 D10E     bne     @@end                    
080410F4 2042     mov     r0,42h                      
080410F6 7018     strb    r0,[r3]                     
080410F8 7711     strb    r1,[r2,1Ch]                 
080410FA 82D1     strh    r1,[r2,16h]                 
080410FC 1C11     mov     r1,r2                       
080410FE 312D     add     r1,2Dh                      
08041100 7808     ldrb    r0,[r1]                     
08041102 3801     sub     r0,1h                       
08041104 7008     strb    r0,[r1]                     
08041106 4805     ldr     r0,=82FEB44h                
08041108 6190     str     r0,[r2,18h]                 
0804110A 8811     ldrh    r1,[r2]                     
0804110C 4804     ldr     r0,=0FDFFh                  
0804110E 4008     and     r0,r1                       
08041110 8010     strh    r0,[r2] 

@@end:                    
08041112 BCF0     pop     r4-r7                       
08041114 BC01     pop     r0                          
08041116 4700     bx      r0                          
.pool
                   
08041124 B570     push    r4-r6,r14                   
08041126 2003     mov     r0,3h                       
08041128 2127     mov     r1,27h                      
0804112A F01FFBC7 bl      80608BCh                    
0804112E 1C05     mov     r5,r0                       
08041130 2D00     cmp     r5,0h                       
08041132 D000     beq     8041136h                    
08041134 E0AF     b       8041296h                    
08041136 4C0C     ldr     r4,=3000738h                
08041138 1C26     mov     r6,r4                       
0804113A 3624     add     r6,24h                      
0804113C 7830     ldrb    r0,[r6]                     
0804113E 2800     cmp     r0,0h                       
08041140 D014     beq     804116Ch                    
08041142 2809     cmp     r0,9h                       
08041144 D100     bne     8041148h                    
08041146 E077     b       8041238h                    
08041148 8860     ldrh    r0,[r4,2h]                  
0804114A 88A1     ldrh    r1,[r4,4h]                  
0804114C 221F     mov     r2,1Fh                      
0804114E F012FFCD bl      80540ECh                    
08041152 8821     ldrh    r1,[r4]                     
08041154 2002     mov     r0,2h                       
08041156 4008     and     r0,r1                       
08041158 2800     cmp     r0,0h                       
0804115A D100     bne     804115Eh                    
0804115C E09B     b       8041296h                    
0804115E 2096     mov     r0,96h                      
08041160 0040     lsl     r0,r0,1h                    
08041162 F7C1FC59 bl      8002A18h                    
08041166 E096     b       8041296h                    
08041168 0738     lsl     r0,r7,1Ch                   
0804116A 0300     lsl     r0,r0,0Ch                   
0804116C 8821     ldrh    r1,[r4]                     
0804116E 4817     ldr     r0,=0FFFBh                  
08041170 4008     and     r0,r1                       
08041172 2200     mov     r2,0h                       
08041174 8020     strh    r0,[r4]                     
08041176 1C23     mov     r3,r4                       
08041178 3332     add     r3,32h                      
0804117A 7819     ldrb    r1,[r3]                     
0804117C 2004     mov     r0,4h                       
0804117E 4308     orr     r0,r1                       
08041180 7018     strb    r0,[r3]                     
08041182 1C21     mov     r1,r4                       
08041184 3122     add     r1,22h                      
08041186 2002     mov     r0,2h                       
08041188 7008     strb    r0,[r1]                     
0804118A 82A5     strh    r5,[r4,14h]                 
0804118C 1C20     mov     r0,r4                       
0804118E 3027     add     r0,27h                      
08041190 2108     mov     r1,8h                       
08041192 7001     strb    r1,[r0]                     
08041194 3001     add     r0,1h                       
08041196 7001     strb    r1,[r0]                     
08041198 3001     add     r0,1h                       
0804119A 7001     strb    r1,[r0]                     
0804119C 490C     ldr     r1,=0FFFCh                  
0804119E 8161     strh    r1,[r4,0Ah]                 
080411A0 2004     mov     r0,4h                       
080411A2 81A0     strh    r0,[r4,0Ch]                 
080411A4 81E1     strh    r1,[r4,0Eh]                 
080411A6 8220     strh    r0,[r4,10h]                 
080411A8 1C21     mov     r1,r4                       
080411AA 3125     add     r1,25h                      
080411AC 2006     mov     r0,6h                       
080411AE 7008     strb    r0,[r1]                     
080411B0 2009     mov     r0,9h                       
080411B2 7030     strb    r0,[r6]                     
080411B4 7722     strb    r2,[r4,1Ch]                 
080411B6 82E5     strh    r5,[r4,16h]                 
080411B8 7FA0     ldrb    r0,[r4,1Eh]                 
080411BA 2800     cmp     r0,0h                       
080411BC D10C     bne     80411D8h                    
080411BE 4805     ldr     r0,=82FEB84h                
080411C0 61A0     str     r0,[r4,18h]                 
080411C2 88A0     ldrh    r0,[r4,4h]                  
080411C4 3840     sub     r0,40h                      
080411C6 80A0     strh    r0,[r4,4h]                  
080411C8 E068     b       804129Ch                    
080411CA 0000     lsl     r0,r0,0h                    
080411CC FFFB     bl      lr+0FF6h                    
080411CE 0000     lsl     r0,r0,0h                    
080411D0 FFFC     bl      lr+0FF8h                    
080411D2 0000     lsl     r0,r0,0h                    
080411D4 EB84     ????                                
080411D6 082F     lsr     r7,r5,20h                   
080411D8 2802     cmp     r0,2h                       
080411DA D10B     bne     80411F4h                    
080411DC 4804     ldr     r0,=82FEB9Ch                
080411DE 61A0     str     r0,[r4,18h]                 
080411E0 8860     ldrh    r0,[r4,2h]                  
080411E2 3030     add     r0,30h                      
080411E4 8060     strh    r0,[r4,2h]                  
080411E6 88A0     ldrh    r0,[r4,4h]                  
080411E8 3830     sub     r0,30h                      
080411EA 80A0     strh    r0,[r4,4h]                  
080411EC E056     b       804129Ch                    
080411EE 0000     lsl     r0,r0,0h                    
080411F0 EB9C     ????                                
080411F2 082F     lsr     r7,r5,20h                   
080411F4 2804     cmp     r0,4h                       
080411F6 D107     bne     8041208h                    
080411F8 4802     ldr     r0,=82FEBB4h                
080411FA 61A0     str     r0,[r4,18h]                 
080411FC 8860     ldrh    r0,[r4,2h]                  
080411FE 3040     add     r0,40h                      
08041200 8060     strh    r0,[r4,2h]                  
08041202 E04B     b       804129Ch                    
08041204 EBB4     ????                                
08041206 082F     lsr     r7,r5,20h                   
08041208 2806     cmp     r0,6h                       
0804120A D10B     bne     8041224h                    
0804120C 4804     ldr     r0,=82FEBCCh                
0804120E 61A0     str     r0,[r4,18h]                 
08041210 8860     ldrh    r0,[r4,2h]                  
08041212 3030     add     r0,30h                      
08041214 8060     strh    r0,[r4,2h]                  
08041216 88A0     ldrh    r0,[r4,4h]                  
08041218 3030     add     r0,30h                      
0804121A 80A0     strh    r0,[r4,4h]                  
0804121C E03E     b       804129Ch                    
0804121E 0000     lsl     r0,r0,0h                    
08041220 EBCC     ????                                
08041222 082F     lsr     r7,r5,20h                   
08041224 2808     cmp     r0,8h                       
08041226 D134     bne     8041292h                    
08041228 4802     ldr     r0,=82FEBE4h                
0804122A 61A0     str     r0,[r4,18h]                 
0804122C 88A0     ldrh    r0,[r4,4h]                  
0804122E 3040     add     r0,40h                      
08041230 80A0     strh    r0,[r4,4h]                  
08041232 E033     b       804129Ch                    
08041234 EBE4     ????                                
08041236 082F     lsr     r7,r5,20h                   
08041238 8860     ldrh    r0,[r4,2h]                  
0804123A 88A1     ldrh    r1,[r4,4h]                  
0804123C F7CEFA70 bl      800F720h                    
08041240 2811     cmp     r0,11h                      
08041242 D105     bne     8041250h                    
08041244 2042     mov     r0,42h                      
08041246 7030     strb    r0,[r6]                     
08041248 1C20     mov     r0,r4                       
0804124A 3025     add     r0,25h                      
0804124C 7005     strb    r5,[r0]                     
0804124E E025     b       804129Ch                    
08041250 7FA0     ldrb    r0,[r4,1Eh]                 
08041252 2800     cmp     r0,0h                       
08041254 D103     bne     804125Eh                    
08041256 88A0     ldrh    r0,[r4,4h]                  
08041258 3805     sub     r0,5h                       
0804125A 80A0     strh    r0,[r4,4h]                  
0804125C E01E     b       804129Ch                    
0804125E 2802     cmp     r0,2h                       
08041260 D102     bne     8041268h                    
08041262 88A0     ldrh    r0,[r4,4h]                  
08041264 3803     sub     r0,3h                       
08041266 E009     b       804127Ch                    
08041268 2804     cmp     r0,4h                       
0804126A D103     bne     8041274h                    
0804126C 8860     ldrh    r0,[r4,2h]                  
0804126E 3005     add     r0,5h                       
08041270 8060     strh    r0,[r4,2h]                  
08041272 E013     b       804129Ch                    
08041274 2806     cmp     r0,6h                       
08041276 D106     bne     8041286h                    
08041278 88A0     ldrh    r0,[r4,4h]                  
0804127A 3003     add     r0,3h                       
0804127C 80A0     strh    r0,[r4,4h]                  
0804127E 8860     ldrh    r0,[r4,2h]                  
08041280 3003     add     r0,3h                       
08041282 8060     strh    r0,[r4,2h]                  
08041284 E00A     b       804129Ch                    
08041286 2808     cmp     r0,8h                       
08041288 D103     bne     8041292h                    
0804128A 88A0     ldrh    r0,[r4,4h]                  
0804128C 3005     add     r0,5h                       
0804128E 80A0     strh    r0,[r4,4h]                  
08041290 E004     b       804129Ch                    
08041292 8025     strh    r5,[r4]                     
08041294 E002     b       804129Ch                    
08041296 4903     ldr     r1,=3000738h                
08041298 2000     mov     r0,0h                       
0804129A 8008     strh    r0,[r1]                     
0804129C BC70     pop     r4-r6                       
0804129E BC01     pop     r0                          
080412A0 4700     bx      r0                          
