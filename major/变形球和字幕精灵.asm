

.definelabel spawnsecsprite,800E258h
.definelabel spawnprisprite,800E31Ch

;pose 00
08013080 B530     push    r4,r5,r14                               
08013082 B083     add     sp,-0Ch                                 
08013084 4805     ldr     r0,=3001530h                            
08013086 7B81     ldrb    r1,[r0,0Eh]    ;读取300153e的值                         
08013088 2040     mov     r0,40h                                  
0801308A 4008     and     r0,r1          ;40 and                         
0801308C 0600     lsl     r0,r0,18h                               
0801308E 0E04     lsr     r4,r0,18h                               
08013090 2C00     cmp     r4,0h                                   
08013092 D007     beq     @@noget                                
08013094 4902     ldr     r1,=3000738h                            
08013096 2000     mov     r0,0h                                   
08013098 8008     strh    r0,[r1]        ;取向清零=消失                              
0801309A E03C     b       @@end                                
@@noget:                              
080130A4 481E     ldr     r0,=3000738h                            
080130A6 4684     mov     r12,r0                                  
080130A8 4662     mov     r2,r12                                  
080130AA 3232     add     r2,32h                                  
080130AC 7810     ldrb    r0,[r2]                                 
080130AE 2140     mov     r1,40h                                  
080130B0 4308     orr     r0,r1          ;300076a orr 40h                              
080130B2 7010     strb    r0,[r2]        ;再写入                         
080130B4 2200     mov     r2,0h                                   
080130B6 491B     ldr     r1,=0FFE4h                              
080130B8 4663     mov     r3,r12                                  
080130BA 8159     strh    r1,[r3,0Ah]                             
080130BC 201C     mov     r0,1Ch                                  
080130BE 8198     strh    r0,[r3,0Ch]                             
080130C0 81D9     strh    r1,[r3,0Eh]                             
080130C2 8218     strh    r0,[r3,10h]    ;四面分界                          
080130C4 4660     mov     r0,r12                                  
080130C6 3027     add     r0,27h                                  
080130C8 2108     mov     r1,8h                                   
080130CA 7001     strb    r1,[r0]        ;300075f写入8h                         
080130CC 3001     add     r0,1h                                   
080130CE 7001     strb    r1,[r0]        ;3000760写入8h                         
080130D0 3001     add     r0,1h                                   
080130D2 7001     strb    r1,[r0]        ;3000761写入8h                         
080130D4 4814     ldr     r0,=82B2BA8h                            
080130D6 6198     str     r0,[r3,18h]                             
080130D8 771A     strb    r2,[r3,1Ch]                             
080130DA 82DC     strh    r4,[r3,16h]                             
080130DC 4661     mov     r1,r12                                  
080130DE 3125     add     r1,25h                                  
080130E0 201E     mov     r0,1Eh                                  
080130E2 7008     strb    r0,[r1]        ;属性写入1eh                         
080130E4 2001     mov     r0,1h                                   
080130E6 8298     strh    r0,[r3,14h]    ;血量写入1                         
080130E8 8858     ldrh    r0,[r3,2h]                              
080130EA 3820     sub     r0,20h         ;垂直坐标向上提升20h                         
080130EC 8058     strh    r0,[r3,2h]     ;再写入                         
080130EE 3901     sub     r1,1h                                   
080130F0 2009     mov     r0,9h          ;pose写入9h                         
080130F2 7008     strb    r0,[r1]                                 
080130F4 3902     sub     r1,2h                                   
080130F6 2003     mov     r0,3h                                   
080130F8 7008     strb    r0,[r1]        ;300075a写入3h  绘图顺序                       
080130FA 7F99     ldrb    r1,[r3,1Eh]    ;精灵数据1E                        
080130FC 7FDA     ldrb    r2,[r3,1Fh]    ;精灵gfx slot                         
080130FE 4660     mov     r0,r12                                  
08013100 3023     add     r0,23h                                  
08013102 7803     ldrb    r3,[r0]        ;读取300075b的值 序号                        
08013104 4665     mov     r5,r12                                  
08013106 8868     ldrh    r0,[r5,2h]     ;读取垂直坐标                         
08013108 9000     str     r0,[sp]        ;写入sp                         
0801310A 88A8     ldrh    r0,[r5,4h]     ;读取水平坐标                         
0801310C 9001     str     r0,[sp,4h]     ;写入sp+4                         
0801310E 9402     str     r4,[sp,8h]     ;0写入sp+8                         
08013110 2013     mov     r0,13h                                  
08013112 F7FBF8A1 bl      spawnsecsprite  ;r0 ID; r1 精灵数据1E; r2 GFX row; r3精灵序号; sp[00] Y坐标; sp[04] X坐标; sp[08] 状态

@@end:                              
08013116 B003     add     sp,0Ch                                  
08013118 BC30     pop     r4,r5                                   
0801311A BC01     pop     r0                                      
0801311C 4700     bx      r0                                      

;pose 9h                             
0801312C B510     push    r4,r14                                  
0801312E B082     add     sp,-8h                                  
08013130 4818     ldr     r0,=3000738h                            
08013132 4684     mov     r12,r0                                  
08013134 8801     ldrh    r1,[r0]                                 
08013136 2080     mov     r0,80h                                  
08013138 0100     lsl     r0,r0,4h                                
0801313A 4008     and     r0,r1        ;800h and 取向                           
0801313C 2800     cmp     r0,0h                                   
0801313E D024     beq     @@noget2                                
08013140 4915     ldr     r1,=3001606h                            
08013142 22FA     mov     r2,0FAh                                 
08013144 0092     lsl     r2,r2,2h                                
08013146 1C10     mov     r0,r2                                   
08013148 8008     strh    r0,[r1]     ;3001606写入3e8 用于计时?                            
0801314A 4662     mov     r2,r12                                  
0801314C 3232     add     r2,32h                                  
0801314E 7811     ldrb    r1,[r2]     ;读取碰撞属性                            
08013150 2001     mov     r0,1h                                   
08013152 2400     mov     r4,0h                                   
08013154 4308     orr     r0,r1       ;1 orr 40                            
08013156 7010     strb    r0,[r2]     ;重写入                            
08013158 4661     mov     r1,r12                                  
0801315A 3126     add     r1,26h                                  
0801315C 2001     mov     r0,1h                                   
0801315E 7008     strb    r0,[r1]     ;300075e写入1                            
08013160 3902     sub     r1,2h                                   
08013162 2023     mov     r0,23h                                  
08013164 7008     strb    r0,[r1]     ;pose写入23h                            
08013166 4660     mov     r0,r12                                  
08013168 302C     add     r0,2Ch                                  
0801316A 7004     strb    r4,[r0]     ;3000764写入0h                            
0801316C 4A0B     ldr     r2,=3001530h                            
0801316E 7B91     ldrb    r1,[r2,0Eh]                             
08013170 2040     mov     r0,40h                                  
08013172 4308     orr     r0,r1       ;3000153e orr 40h                            
08013174 7390     strb    r0,[r2,0Eh] ;重写入                            
08013176 4660     mov     r0,r12                                  
08013178 8843     ldrh    r3,[r0,2h]                              
0801317A 8880     ldrh    r0,[r0,4h]                              
0801317C 9000     str     r0,[sp]     ;水平坐标写入sp                            
0801317E 9401     str     r4,[sp,4h]  ;sp+4写入0                           
08013180 2011     mov     r0,11h      ;字幕精灵                            
08013182 2110     mov     r1,10h      ;精灵数据                            
08013184 2206     mov     r2,6h       ;精灵set gfx行                                
08013186 F7FBF8C9 bl      spawnprisprite ;r0 ID; r1 精灵数据1E; r2 GFX row; r3 Y坐标; sp[00] X坐标; sp[04] 状态
@@noget2:                                
0801318A B002     add     sp,8h                                   
0801318C BC10     pop     r4                                      
0801318E BC01     pop     r0                                      
08013190 4700     bx      r0                                      

;pose 23h                             
080131A0 B500     push    r14                                     
080131A2 4A0B     ldr     r2,=3000738h                            
080131A4 1C11     mov     r1,r2                                   
080131A6 3126     add     r1,26h                                  
080131A8 2001     mov     r0,1h                                   
080131AA 7008     strb    r0,[r1]   ;300075e写入1 冷却时间?                               
080131AC 3106     add     r1,6h                                   
080131AE 7809     ldrb    r1,[r1]   ;读取3000764的值                              
080131B0 4008     and     r0,r1     ;1 and                              
080131B2 2800     cmp     r0,0h                                   
080131B4 D103     bne     @@pass                                
080131B6 8810     ldrh    r0,[r2]   ;读取取向 正常为3                             
080131B8 2104     mov     r1,4h                                   
080131BA 4048     eor     r0,r1     ;取向 eor 4   控制每帧都闪                         
080131BC 8010     strh    r0,[r2]   ;重写入

@@pass:                              
080131BE 4805     ldr     r0,=3001606h                            
080131C0 8801     ldrh    r1,[r0]                                 
080131C2 4805     ldr     r0,=3E6h                                
080131C4 4281     cmp     r1,r0     ;如果值大于3e6则跳过                              
080131C6 D801     bhi     @@end                               
080131C8 2000     mov     r0,0h                                   
080131CA 8010     strh    r0,[r2]   ;取向彻底清零

@@end:                                 
080131CC BC01     pop     r0                                      
080131CE 4700     bx      r0                                      
////////////////////////////////////////////////////////////////////////////////////////////////////////
;球附带的弹丸精灵
080132A8 B500     push    r14                                     
080132AA 4806     ldr     r0,=3000738h                            
080132AC 1C02     mov     r2,r0                                   
080132AE 3226     add     r2,26h                                  
080132B0 2101     mov     r1,1h                                   
080132B2 7011     strb    r1,[r2]     ;300075e写入1                              
080132B4 3024     add     r0,24h                                  
080132B6 7800     ldrb    r0,[r0]     ;读取pose                            
080132B8 2800     cmp     r0,0h                                   
080132BA D005     beq     @@posezero                                
080132BC 2809     cmp     r0,9h                                   
080132BE D005     beq     @@posenine                               
080132C0 E006     b       @@end                               

@@posezero:                              
080132C8 F7FFFF88 bl      80131DCh    ;00

@@posenine:                               
080132CC F7FFFFB2 bl      8013234h    ;09h

@@end:                              
080132D0 BC01     pop     r0                                      
080132D2 4700     bx      r0 
                                     
;pose 0   球壳                           
080131DC B510     push    r4,r14                                  
080131DE 4812     ldr     r0,=3000738h                            
080131E0 4684     mov     r12,r0                                  
080131E2 2200     mov     r2,0h                                   
080131E4 2300     mov     r3,0h                                   
080131E6 4911     ldr     r1,=0FFFCh                              
080131E8 8141     strh    r1,[r0,0Ah]                             
080131EA 2004     mov     r0,4h                                   
080131EC 4664     mov     r4,r12                                  
080131EE 81A0     strh    r0,[r4,0Ch]                             
080131F0 81E1     strh    r1,[r4,0Eh]                             
080131F2 8220     strh    r0,[r4,10h]   ;四面分界 很小的样子                          
080131F4 4660     mov     r0,r12                                  
080131F6 3027     add     r0,27h                                  
080131F8 2108     mov     r1,8h                                   
080131FA 7001     strb    r1,[r0]       ;300075f写入8h                          
080131FC 3001     add     r0,1h                                   
080131FE 7001     strb    r1,[r0]       ;3000760写入8h                          
08013200 3001     add     r0,1h                                   
08013202 7001     strb    r1,[r0]       ;3000761写入8h                          
08013204 480A     ldr     r0,=82B2BD0h                            
08013206 61A0     str     r0,[r4,18h]                             
08013208 7722     strb    r2,[r4,1Ch]                             
0801320A 82E3     strh    r3,[r4,16h]   ;写入图片                           
0801320C 4660     mov     r0,r12                                  
0801320E 3025     add     r0,25h                                  
08013210 7002     strb    r2,[r0]       ;属性写入0                          
08013212 4661     mov     r1,r12                                  
08013214 3122     add     r1,22h                                  
08013216 2002     mov     r0,2h                                   
08013218 7008     strb    r0,[r1]       ;300075a写入2h                          
0801321A 3102     add     r1,2h                                   
0801321C 2009     mov     r0,9h                                   
0801321E 7008     strb    r0,[r1]       ;pose 9h                          
08013220 BC10     pop     r4                                      
08013222 BC01     pop     r0                                      
08013224 4700     bx      r0                                      

;pose 9h                        
08013234 B500     push    r14                                     
08013236 4B0C     ldr     r3,=3000738h                            
08013238 1C18     mov     r0,r3                                   
0801323A 3023     add     r0,23h                                  
0801323C 7801     ldrb    r1,[r0]      ;读取300075b的值 精灵序号                            
0801323E 4A0B     ldr     r2,=30001ACh                            
08013240 00C8     lsl     r0,r1,3h                                
08013242 1A40     sub     r0,r0,r1                                
08013244 00C0     lsl     r0,r0,3h     ;56倍                           
08013246 1880     add     r0,r0,r2                                
08013248 8801     ldrh    r1,[r0]      ;等于得到球的取向?                           
0801324A 8019     strh    r1,[r3]      ;写入取向                           
0801324C 3032     add     r0,32h                                  
0801324E 7801     ldrb    r1,[r0]                                 
08013250 2001     mov     r0,1h                                   
08013252 4008     and     r0,r1        ;1 and 碰撞属性                           
08013254 2800     cmp     r0,0h                                   
08013256 D005     beq     @@end                                
08013258 1C1A     mov     r2,r3        ;不为0的话则get                           
0801325A 3232     add     r2,32h                                  
0801325C 7811     ldrb    r1,[r2]                                 
0801325E 2001     mov     r0,1h                                   
08013260 4308     orr     r0,r1        ;1 orr 碰撞属性                           
08013262 7010     strb    r0,[r2]      ;再写入

@@end:                                 
08013264 BC01     pop     r0                                      
08013266 4700     bx      r0                                      
                            

;球主程序
08013270 B500     push    r14                                     
08013272 4805     ldr     r0,=3000738h                            
08013274 3024     add     r0,24h                                  
08013276 7800     ldrb    r0,[r0]                                 
08013278 2809     cmp     r0,9h                                   
0801327A D00D     beq     @@posenine                                
0801327C 2809     cmp     r0,9h                                   
0801327E DC05     bgt     @@morethan9h                                
08013280 2800     cmp     r0,0h                                   
08013282 D006     beq     @@posezero                                
08013284 E00D     b       @@end                                

@@morethan9h:                              
0801328C 2823     cmp     r0,23h                                  
0801328E D006     beq     @@pose23                             
08013290 E007     b       @@end   
@@posezero:                             
08013292 F7FFFEF5 bl      8013080h    ;00                               
08013296 E004     b       @@end 
@@posenine:                               
08013298 F7FFFF48 bl      801312Ch    ;09h                            
0801329C E001     b       @@end    
@@pose23:                            
0801329E F7FFFF7F bl      80131A0h    ;23h 
@@end:                                
080132A2 BC01     pop     r0                                      
080132A4 4700     bx      r0
//////////////////////////////////////////////////////////////////////////////////////////////
;主精灵生产;r0 ID; r1 精灵数据1E; r2 GFX row; r3 Y坐标; sp[00] X坐标; sp[04] 状态
0800E31C B5F0     push    r4-r7,r14                               
0800E31E 4657     mov     r7,r10                                  
0800E320 464E     mov     r6,r9                                   
0800E322 4645     mov     r5,r8                                   
0800E324 B4E0     push    r5-r7                                   
0800E326 9C08     ldr     r4,[sp,20h]   ;X坐标                            
0800E328 9D09     ldr     r5,[sp,24h]   ;状态                          
0800E32A 0600     lsl     r0,r0,18h                               
0800E32C 0E00     lsr     r0,r0,18h                               
0800E32E 4681     mov     r9,r0         ;精灵ID                          
0800E330 0609     lsl     r1,r1,18h                               
0800E332 0E09     lsr     r1,r1,18h                               
0800E334 468A     mov     r10,r1        ;精灵数据1E                          
0800E336 0612     lsl     r2,r2,18h                               
0800E338 0E17     lsr     r7,r2,18h     ;gfx row                          
0800E33A 041B     lsl     r3,r3,10h                               
0800E33C 0C1B     lsr     r3,r3,10h                               
0800E33E 4698     mov     r8,r3         ;Y坐标                          
0800E340 0424     lsl     r4,r4,10h                               
0800E342 0C26     lsr     r6,r4,10h     ;r4=0                          
0800E344 042D     lsl     r5,r5,10h                               
0800E346 0C2D     lsr     r5,r5,10h     ;球能力时状态为0                         
0800E348 2400     mov     r4,0h                                   
0800E34A 4A17     ldr     r2,=30001ACh                            
0800E34C 21A8     mov     r1,0A8h                                 
0800E34E 00C9     lsl     r1,r1,3h                                
0800E350 1850     add     r0,r2,r1 ;30006ech                               
0800E352 4282     cmp     r2,r0    ;大于或等于跳转                               
0800E354 D233     bcs     @@endandr0ff                               
0800E356 2007     mov     r0,7h                                   
0800E358 2100     mov     r1,0h                                   
0800E35A 4305     orr     r5,r0    ;0 orr 7 = 7                              
0800E35C 201D     mov     r0,1Dh                                  
0800E35E 1880     add     r0,r0,r2                                
0800E360 4684     mov     r12,r0   ;检验的精灵ID地址 

@@loop:                              
0800E362 8810     ldrh    r0,[r2]  ;读取取向                               
0800E364 2301     mov     r3,1h                                   
0800E366 4003     and     r3,r0    ;1 and 取向                              
0800E368 2B00     cmp     r3,0h    ;不为0跳转                               
0800E36A D11F     bne     @@noblankdata                                
0800E36C 8015     strh    r5,[r2]  ;7写入取向                               
0800E36E 4665     mov     r5,r12                                  
0800E370 7569     strb    r1,[r5,15h] ;0写入碰撞属性                             
0800E372 70AF     strb    r7,[r5,2h]  ;gfx row写入6                            
0800E374 4648     mov     r0,r9                                   
0800E376 7028     strb    r0,[r5]     ;写入重产精灵ID                            
0800E378 4645     mov     r5,r8                                   
0800E37A 8055     strh    r5,[r2,2h]  ;写入X坐标                            
0800E37C 8096     strh    r6,[r2,4h]  ;写入Y坐标                            
0800E37E 4655     mov     r5,r10                                  
0800E380 4660     mov     r0,r12                                  
0800E382 7045     strb    r5,[r0,1h] ;精灵数据1E写入                             
0800E384 2002     mov     r0,2h                                   
0800E386 4665     mov     r5,r12                                  
0800E388 7128     strb    r0,[r5,4h] ;精灵数据21写入2h                             
0800E38A 2004     mov     r0,4h                                   
0800E38C 7168     strb    r0,[r5,5h] ;精灵数据22写入4h                             
0800E38E 71E9     strb    r1,[r5,7h] ;精灵pose写入0                            
0800E390 8293     strh    r3,[r2,14h] ;血量写入0                           
0800E392 73A9     strb    r1,[r5,0Eh]  ;无敌时间写入0                           
0800E394 70E9     strb    r1,[r5,3h]   ;调色板写入0                           
0800E396 75A9     strb    r1,[r5,16h]  ;6b写入0                           
0800E398 75E9     strb    r1,[r5,17h]  ;6c写入0                           
0800E39A 2001     mov     r0,1h                                   
0800E39C 7268     strb    r0,[r5,9h]   ;26写入1h                           
0800E39E 71AC     strb    r4,[r5,6h]   ;序号写入                           
0800E3A0 74E9     strb    r1,[r5,13h]  ;68写入0h 冰冻时间                          
0800E3A2 7529     strb    r1,[r5,14h]  ;69写入0h                           
0800E3A4 1C20     mov     r0,r4         ;r0=0h                          
0800E3A6 E00B     b       @@end                                

@@noblankdata:                               
0800E3AC 1C60     add     r0,r4,1     ;序号加1                             
0800E3AE 0600     lsl     r0,r0,18h                               
0800E3B0 0E04     lsr     r4,r0,18h                               
0800E3B2 2038     mov     r0,38h      ;当前精灵数据+1D再加38                            
0800E3B4 4484     add     r12,r0                                  
0800E3B6 3238     add     r2,38h      ;精灵数据加38                            
0800E3B8 4805     ldr     r0,=30006ECh                            
0800E3BA 4282     cmp     r2,r0                                   
0800E3BC D3D1     bcc     @@loop      ;主要用于检查精灵数据是否有空白部分,以便生产

@@endandr0ff:                                
0800E3BE 20FF     mov     r0,0FFh

@@end:                                 
0800E3C0 BC38     pop     r3-r5                                   
0800E3C2 4698     mov     r8,r3                                   
0800E3C4 46A1     mov     r9,r4                                   
0800E3C6 46AA     mov     r10,r5                                  
0800E3C8 BCF0     pop     r4-r7                                   
0800E3CA BC02     pop     r1                                      
0800E3CC 4708     bx      r1                                      
//////////////////////////////////////////////////////////////////////////////////////////////////

.definelabel PoseTable,801BB3Ch 
;字幕精灵11h 主程序
0801BB14 B500     push    r14                                     
0801BB16 4807     ldr     r0,=3000738h                            
0801BB18 1C02     mov     r2,r0                                   
0801BB1A 3226     add     r2,26h                                  
0801BB1C 2101     mov     r1,1h                                   
0801BB1E 7011     strb    r1,[r2]  ;冷却时间写入1h                               
0801BB20 3024     add     r0,24h                                  
0801BB22 7800     ldrb    r0,[r0]  ;读取pose值                               
0801BB24 2825     cmp     r0,25h   ;大于25h则结束                               
0801BB26 D866     bhi     @@end                                
0801BB28 0080     lsl     r0,r0,2h                                
0801BB2A 4903     ldr     r1,=PoseTable                            
0801BB2C 1840     add     r0,r0,r1                                
0801BB2E 6800     ldr     r0,[r0]                                 
0801BB30 4687     mov     r15,r0                                  
.org PoseTable
    .word 801bbd4h ;00
	.word 801bbf6h .word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbdah ;08h
	.word 801bbe0h ;09h
	.word 801bbf6h .word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbf6h .word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbf6h .word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbf6h .word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbf6h .word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbf6h .word 801bbf6h .word 801bbf6h .word 801bbf6h
	.word 801bbf6h 
	.word 801bbe6h ;23h
	.word 801bbech ;24h
	.word 801bbf2h ;25h
                              
0801BBD4 F7FFFD70 bl      801B6B8h  ;00h                               
0801BBD8 E00D     b       @@end                                
0801BBDA F7FFFDF5 bl      801B7C8h  ;08h                              
0801BBDE E00A     b       @@end                                
0801BBE0 F7FFFE20 bl      801B824h  ;09h                              
0801BBE4 E007     b       @@end                                
0801BBE6 F7FFFEDF bl      801B9A8h  ;23h                              
0801BBEA E004     b       @@end                                
0801BBEC F7FFFF10 bl      801BA10h  ;24h                              
0801BBF0 E001     b       @@end                                
0801BBF2 F7FFFF35 bl      801BA60h  ;25h

@@end:                              
0801BBF6 BC01     pop     r0                                      
0801BBF8 4700     bx      r0 
//////////////////////////////////////////////////////////////////////////////////////////

;字幕pose 0h
0801B6B8 B570     push    r4-r6,r14                               
0801B6BA 4923     ldr     r1,=3001606h                            
0801B6BC 22FA     mov     r2,0FAh                                 
0801B6BE 0092     lsl     r2,r2,2h                                
0801B6C0 1C10     mov     r0,r2                                   
0801B6C2 8008     strh    r0,[r1]      ;3001606写入3e8h 暂停                              
0801B6C4 4921     ldr     r1,=3000738h                            
0801B6C6 880A     ldrh    r2,[r1]                                 
0801B6C8 2002     mov     r0,2h                                   
0801B6CA 4010     and     r0,r2        ;2 and 取向                             
0801B6CC 468C     mov     r12,r1                                  
0801B6CE 2800     cmp     r0,0h                                   
0801B6D0 D104     bne     @@trigger                                
0801B6D2 2002     mov     r0,2h                                   
0801B6D4 4310     orr     r0,r2        ;2 orr 取向 再写入                           
0801B6D6 8008     strh    r0,[r1]                                 
0801B6D8 20FF     mov     r0,0FFh      ;3000756写入FFh                          
0801B6DA 7788     strb    r0,[r1,1Eh]  ;偏移1E是敌编号....

@@trigger:                             
0801B6DC 4660     mov     r0,r12                                  
0801B6DE 7F86     ldrb    r6,[r0,1Eh]  ;读取3000756的值                            
0801B6E0 8800     ldrh    r0,[r0]      ;读取取向                           
0801B6E2 2210     mov     r2,10h                                  
0801B6E4 2400     mov     r4,0h                                   
0801B6E6 2300     mov     r3,0h                                   
0801B6E8 4310     orr     r0,r2        ;取向orr 10h  原先是7则为17h                         
0801B6EA 4661     mov     r1,r12                                  
0801B6EC 8008     strh    r0,[r1]      ;重写入                           
0801B6EE 4660     mov     r0,r12                                  
0801B6F0 3021     add     r0,21h                                  
0801B6F2 7004     strb    r4,[r0]      ;偏移21图层优先级写入0                         
0801B6F4 3004     add     r0,4h                                   
0801B6F6 7004     strb    r4,[r0]      ;属性写入0h                           
0801B6F8 4665     mov     r5,r12                                  
0801B6FA 3532     add     r5,32h                                  
0801B6FC 7829     ldrb    r1,[r5]      ;读取碰撞属性                            
0801B6FE 2021     mov     r0,21h                                  
0801B700 4308     orr     r0,r1                                   
0801B702 7028     strb    r0,[r5]      ;orr 21h 再写入                           
0801B704 4660     mov     r0,r12                                  
0801B706 3027     add     r0,27h                                  
0801B708 7002     strb    r2,[r0]      ;300075f写入10h                           
0801B70A 3001     add     r0,1h                                   
0801B70C 7002     strb    r2,[r0]      ;3000760写入10h                            
0801B70E 4661     mov     r1,r12                                  
0801B710 3129     add     r1,29h                                  
0801B712 2080     mov     r0,80h       ;3000761写入80h                            
0801B714 7008     strb    r0,[r1]                                 
0801B716 490E     ldr     r1,=0FFFCh                              
0801B718 4662     mov     r2,r12                                  
0801B71A 8151     strh    r1,[r2,0Ah]  ;顶部分界写入fffch                           
0801B71C 2004     mov     r0,4h                                   
0801B71E 8190     strh    r0,[r2,0Ch]  ;下部分界写入4h                           
0801B720 81D1     strh    r1,[r2,0Eh]  ;左部分界写入fffch                           
0801B722 8210     strh    r0,[r2,10h]  ;右部分界写入4h                           
0801B724 480B     ldr     r0,=82CBA0Ch                            
0801B726 6190     str     r0,[r2,18h]                             
0801B728 7714     strb    r4,[r2,1Ch]                             
0801B72A 82D3     strh    r3,[r2,16h]  ;写入新图 清零                           
0801B72C 2009     mov     r0,9h                                   
0801B72E 80D0     strh    r0,[r2,6h]   ;偏移6写入9h                          
0801B730 4660     mov     r0,r12                                  
0801B732 302C     add     r0,2Ch                                  
0801B734 2101     mov     r1,1h                                   
0801B736 7001     strb    r1,[r0]      ;偏移2C写入1h                             
0801B738 3002     add     r0,2h                                   
0801B73A 7004     strb    r4,[r0]      ;偏移2E写入0h                           
0801B73C 2E16     cmp     r6,16h                                  
0801B73E D10B     bne     @@Offset1ENo16                                
0801B740 3801     sub     r0,1h                                   
0801B742 7001     strb    r1,[r0]      ;偏移2D写入1h                            
0801B744 E00B     b       @@Continue                               
 
@@Offset1ENo16: 
0801B758 4660     mov     r0,r12                                  
0801B75A 302D     add     r0,2Dh                                  
0801B75C 7004     strb    r4,[r0]     ;3000765生产时间写入0h

@@Continue:                                 
0801B75E 2380     mov     r3,80h                                  
0801B760 2200     mov     r2,0h                                   
0801B762 4803     ldr     r0,=30006ECh                            
0801B764 7801     ldrb    r1,[r0]     ;读取精灵ID slot                           
0801B766 1C04     mov     r4,r0                                   
0801B768 2911     cmp     r1,11h      ;检查是否是11                         
0801B76A D105     bne     @@CheckNext                                
0801B76C 4801     ldr     r0,=30006FBh                            
0801B76E E00E     b       @@ID11                                

@@CheckNext:                              
0801B778 1C50     add     r0,r2,1                                 
0801B77A 0600     lsl     r0,r0,18h                               
0801B77C 0E02     lsr     r2,r0,18h     ;r2+1                            
0801B77E 2A0E     cmp     r2,0Eh        ;大于0Eh跳转 也就是不会超过Fh个ID检查                             
0801B780 D806     bhi     @@AllIDNO11                              
0801B782 1910     add     r0,r2,r4                                
0801B784 7800     ldrb    r0,[r0]       ;读取精灵ID                             
0801B786 2811     cmp     r0,11h                                  
0801B788 D1F6     bne     @@CheckNext   ;检查所有的ID都不是11h                            
0801B78A 4806     ldr     r0,=30006FBh  ;精灵SLOT GFXROW                           
0801B78C 1810     add     r0,r2,r0 

@@ID11:                               
0801B78E 7803     ldrb    r3,[r0]       ;读取字幕11的gfxrow

@@AllIDNO11:                                
0801B790 2B07     cmp     r3,7h         ;除非ID = 11 否则都大于                                
0801B792 D809     bhi     @@IDNO11OrGfxRowDataOver                                
0801B794 4661     mov     r1,r12                                  
0801B796 3124     add     r1,24h                                  
0801B798 2009     mov     r0,9h         ;pose 写入9h                              
0801B79A 7008     strb    r0,[r1]                                 
0801B79C 4660     mov     r0,r12                                  
0801B79E 77C3     strb    r3,[r0,1Fh]   ;gfx row写入                           
0801B7A0 E006     b       @@Continue2                                

@@IDNO11OrGfxRowDataOver:                               
0801B7A8 4661     mov     r1,r12                                  
0801B7AA 3124     add     r1,24h                                  
0801B7AC 2008     mov     r0,8h         ;pose 写入8h                              
0801B7AE 7008     strb    r0,[r1] 

@@Continue2:                                
0801B7B0 2036     mov     r0,36h                                  
0801B7B2 4661     mov     r1,r12                                  
0801B7B4 8048     strh    r0,[r1,2h]    ;垂直坐标写入36h                             
0801B7B6 2078     mov     r0,78h                                  
0801B7B8 8088     strh    r0,[r1,4h]    ;水平坐标写入78h                             
0801B7BA 7FC9     ldrb    r1,[r1,1Fh]   ;读取gfx row                             
0801B7BC 1C30     mov     r0,r6         ;字幕精灵的敌编号                         
0801B7BE F053FD4B bl      806F258h      ;r0取向 球为17h r1 gfx row                             
0801B7C2 BC70     pop     r4-r6                                   
0801B7C4 BC01     pop     r0                                      
0801B7C6 4700     bx      r0 

;pose 8h   除非有精灵11,否则00后都是进入pose 8   防止出bug的补充                                  
0801B7C8 B500     push    r14                                     
0801B7CA 4909     ldr     r1,=3001606h                            
0801B7CC 22FA     mov     r2,0FAh                                 
0801B7CE 0092     lsl     r2,r2,2h                                
0801B7D0 1C10     mov     r0,r2                                   
0801B7D2 8008     strh    r0,[r1]       ;再次写入3e8h                                
0801B7D4 4907     ldr     r1,=3000738h                            
0801B7D6 88C8     ldrh    r0,[r1,6h]    ;偏移6减1再写入 原本写入了9h                           
0801B7D8 3801     sub     r0,1h                                   
0801B7DA 80C8     strh    r0,[r1,6h]                              
0801B7DC 0400     lsl     r0,r0,10h                               
0801B7DE 0C00     lsr     r0,r0,10h                               
0801B7E0 2807     cmp     r0,7h         ;如果不是7则跳转  第一次跳转                          
0801B7E2 D109     bne     @@Offset6No7                                
0801B7E4 7FC9     ldrb    r1,[r1,1Fh]   ;gfx row                           
0801B7E6 2011     mov     r0,11h                                  
0801B7E8 F7F2FC4C bl      800E084h      ;图像重新set                           
0801B7EC E00B     b       @@Offset6No8                                

@@Offset6No7:                               
0801B7F8 2808     cmp     r0,8h         ;第一次经历                           
0801B7FA D104     bne     @@Offset6No8                                
0801B7FC 7FC9     ldrb    r1,[r1,1Fh]   ;gfx row                           
0801B7FE 2011     mov     r0,11h                                  
0801B800 2201     mov     r2,1h                                   
0801B802 F7F2FC55 bl      800E0B0h      ;调色板重新set

@@Offset6No8:                                
0801B806 4B06     ldr     r3,=3000738h                            
0801B808 88DA     ldrh    r2,[r3,6h]                              
0801B80A 2A00     cmp     r2,0h       ;偏移6 非0结束                            
0801B80C D105     bne     @@end                                
0801B80E 1C19     mov     r1,r3                                   
0801B810 3124     add     r1,24h                                  
0801B812 2009     mov     r0,9h       ;pose写入9h                             
0801B814 7008     strb    r0,[r1]                                 
0801B816 771A     strb    r2,[r3,1Ch]                             
0801B818 82DA     strh    r2,[r3,16h] ;动画帧清零

@@end:                             
0801B81A BC01     pop     r0                                      
0801B81C 4700     bx      r0                                      

;pose 9h                              
0801B824 B5F0     push    r4-r7,r14                               
0801B826 4647     mov     r7,r8                                   
0801B828 B480     push    r7                                      
0801B82A B083     add     sp,-0Ch                                 
0801B82C 4917     ldr     r1,=3001606h                            
0801B82E 22FA     mov     r2,0FAh                                 
0801B830 0092     lsl     r2,r2,2h                                
0801B832 1C10     mov     r0,r2                                   
0801B834 8008     strh    r0,[r1]     ;写入3e8h                            
0801B836 4C16     ldr     r4,=3000738h                            
0801B838 7FA5     ldrb    r5,[r4,1Eh]  ;读取敌编号  10h?                        
0801B83A 46A8     mov     r8,r5                                   
0801B83C 1C27     mov     r7,r4                                   
0801B83E 372C     add     r7,2Ch                                  
0801B840 783E     ldrb    r6,[r7]      ;读取2C  1h?                           
0801B842 2E00     cmp     r6,0h                                   
0801B844 D06E     beq     @@Offset2CisZero                                
0801B846 7F20     ldrb    r0,[r4,1Ch]  ;读取动画帧                           
0801B848 3801     sub     r0,1h                                   
0801B84A 7720     strb    r0,[r4,1Ch]  ;减1再写入                           
0801B84C F053FD1E bl      806F28Ch                                
0801B850 2800     cmp     r0,0h                                   
0801B852 D100     bne     @@r0nozero                                
0801B854 E0A2     b       @@end

@@r0nozero:                                
0801B856 2000     mov     r0,0h                                   
0801B858 7038     strb    r0,[r7]   ;偏移2C写入0                              
0801B85A 8821     ldrh    r1,[r4]                                 
0801B85C 480D     ldr     r0,=0FFFBh                              
0801B85E 4008     and     r0,r1     ;FFFBh and 取向 去掉隐形                            
0801B860 8020     strh    r0,[r4]                                 
0801B862 1C28     mov     r0,r5     ;10h 敌编号                              
0801B864 3808     sub     r0,8h                                   
0801B866 0600     lsl     r0,r0,18h                               
0801B868 0E00     lsr     r0,r0,18h                               
0801B86A 280D     cmp     r0,0Dh                                  
0801B86C D816     bhi     @@Itemfst                               
0801B86E 1C21     mov     r1,r4                                   
0801B870 312E     add     r1,2Eh                                  
0801B872 2001     mov     r0,1h                                   
0801B874 7008     strb    r0,[r1]  ;偏移2E写入1h                               
0801B876 F7E8FC09 bl      800408Ch                                
0801B87A 2D0C     cmp     r5,0Ch        ;离子枪                      
0801B87C D003     beq     @@UNknowItem                                
0801B87E 2D0F     cmp     r5,0Fh        ;重力服                          
0801B880 D001     beq     @@UNknowItem                                
0801B882 2D14     cmp     r5,14h        ;空间跳                          
0801B884 D108     bne     @@Abilitysound  ;球为10 冰0A 波0B 长08 旋13 隔0E 高12 加11 爪15 蓄9(开始为00?)

@@UNknowItem:                                
0801B886 2042     mov     r0,42h        ;不兼容声                                
0801B888 E01F     b       @@goto                                

@@Abilitysound:                                
0801B898 2037     mov     r0,37h        ;能力获得声                          
0801B89A E016     b       @@goto

@@Itemfst:                                
0801B89C 2D03     cmp     r5,3h      ;导弹 第二次吃则为2   血包为1                          
0801B89E D003     beq     @@Itemfst2                                
0801B8A0 2D05     cmp     r5,5h      ;超导 第二次吃为4                             
0801B8A2 D001     beq     @@Itemfst2                                
0801B8A4 2D07     cmp     r5,7h      ;超炸 第二次吃为6                            
0801B8A6 D109     bne     @@fullpowersuit 

@@Itemfst2:                              
0801B8A8 4803     ldr     r0,=3000738h                            
0801B8AA 302E     add     r0,2Eh                                  
0801B8AC 2101     mov     r1,1h                                   
0801B8AE 7001     strb    r1,[r0]  ;3000766写入1h                               
0801B8B0 F7E8FBEC bl      800408Ch                                
0801B8B4 2037     mov     r0,37h                                  
0801B8B6 E008     b       @@goto                                

@@fullpowersuit:                              
0801B8BC 2D20     cmp     r5,20h                                  
0801B8BE D108     bne     @@pass                                
0801B8C0 2019     mov     r0,19h   ;更快的布林斯坦音乐 ?                                
0801B8C2 2100     mov     r1,0h                                   
0801B8C4 F7E8F896 bl      80039F4h                                
0801B8C8 204A     mov     r0,4Ah   ;得到完全装甲?

@@goto:                                 
0801B8CA 2100     mov     r1,0h                                   
0801B8CC F7E8F9E8 bl      8003CA0h                                
0801B8D0 E00F     b       @@come 

@@pass:                               
0801B8D2 2D16     cmp     r5,16h                                  
0801B8D4 D00D     beq     @@come                                
0801B8D6 1E68     sub     r0,r5,1                                 
0801B8D8 0600     lsl     r0,r0,18h                               
0801B8DA 0E00     lsr     r0,r0,18h                               
0801B8DC 2801     cmp     r0,1h     ;血包和导弹第二次                            
0801B8DE D903     bls     @@week                                
0801B8E0 2D04     cmp     r5,4h     ;超导第二次                              
0801B8E2 D001     beq     @@week                                
0801B8E4 2D06     cmp     r5,6h     ;超炸第二次                              
0801B8E6 D101     bne     @@tatg 

@@week:                               
0801B8E8 F7E8FBD0 bl      800408Ch

@@tatg:                                
0801B8EC 203A     mov     r0,3Ah    ;道具嗤音                              
0801B8EE F7E7F893 bl      8002A18h 

@@come:                               
0801B8F2 480A     ldr     r0,=3000738h                            
0801B8F4 1C01     mov     r1,r0                                   
0801B8F6 312E     add     r1,2Eh                                  
0801B8F8 7809     ldrb    r1,[r1]                                 
0801B8FA 1C02     mov     r2,r0                                   
0801B8FC 2900     cmp     r1,0h     ;偏移2E不为0跳转                              
0801B8FE D107     bne     @@message                                
0801B900 4640     mov     r0,r8     ;偏移1E                             
0801B902 2817     cmp     r0,17h                                  
0801B904 D004     beq     @@message                                
0801B906 381B     sub     r0,1Bh                                  
0801B908 0600     lsl     r0,r0,18h                               
0801B90A 0E00     lsr     r0,r0,18h                               
0801B90C 2805     cmp     r0,5h                                   
0801B90E D845     bhi     @@end 

@@message:                              
0801B910 4803     ldr     r0,=82CBACCh                            
0801B912 6190     str     r0,[r2,18h]                             
0801B914 2000     mov     r0,0h                                   
0801B916 7710     strb    r0,[r2,1Ch]                             
0801B918 82D0     strh    r0,[r2,16h]                             
0801B91A E03F     b       @@end                                

@@Offset2CisZero:                               
0801B924 F7F4F950 bl      800FBC8h     ;检查动画                           
0801B928 2800     cmp     r0,0h                                   
0801B92A D037     beq     @@end                                
0801B92C 7726     strb    r6,[r4,1Ch]                             
0801B92E 82E6     strh    r6,[r4,16h]  ;动画帧清零                           
0801B930 1C21     mov     r1,r4                                   
0801B932 3124     add     r1,24h                                  
0801B934 2023     mov     r0,23h                                  
0801B936 7008     strb    r0,[r1]      ;pose写入23h                               
0801B938 69A1     ldr     r1,[r4,18h]                             
0801B93A 4805     ldr     r0,=82CBACCh                            
0801B93C 4281     cmp     r1,r0                                   
0801B93E D10E     bne     @@OAMDifferent                                
0801B940 4804     ldr     r0,=82CBB5Ch                            
0801B942 61A0     str     r0,[r4,18h]                             
0801B944 2D20     cmp     r5,20h       ;全装甲flag                            
0801B946 D107     bne     @@NoFullSuitGet                                
0801B948 20AA     mov     r0,0AAh                                 
0801B94A 0040     lsl     r0,r0,1h                                
0801B94C 80E0     strh    r0,[r4,6h]   ;偏移6写入 154h                          
0801B94E E025     b       @@end                                

@@NoFullSuitGet:                             
0801B958 2064     mov     r0,64h                                  
0801B95A 80E0     strh    r0,[r4,6h]   ;偏移6写入64h                            
0801B95C E01E     b       @@end    

@@OAMDifferent:                            
0801B95E 480A     ldr     r0,=82CBABCh                            
0801B960 61A0     str     r0,[r4,18h]                             
0801B962 2064     mov     r0,64h                                  
0801B964 80E0     strh    r0,[r4,6h]                              
0801B966 2D16     cmp     r5,16h                                  
0801B968 D110     bne     NoSaveMessage                                
0801B96A 7FE2     ldrb    r2,[r4,1Fh]                             
0801B96C 1C20     mov     r0,r4                                   
0801B96E 3023     add     r0,23h                                  
0801B970 7803     ldrb    r3,[r0]                                 
0801B972 203F     mov     r0,3Fh                                  
0801B974 9000     str     r0,[sp]                                 
0801B976 2096     mov     r0,96h                                  
0801B978 9001     str     r0,[sp,4h]                              
0801B97A 9602     str     r6,[sp,8h]                              
0801B97C 200E     mov     r0,0Eh                                  
0801B97E 2100     mov     r1,0h                                   
0801B980 F7F2FC6A bl      800E258h    ;副灵0E,选择箭头                            
0801B984 E00A     b       @@end                                
.pool
 
NoSaveMessage: 
0801B98C 4640     mov     r0,r8                                   
0801B98E 3821     sub     r0,21h                                  
0801B990 0600     lsl     r0,r0,18h                               
0801B992 0E00     lsr     r0,r0,18h                               
0801B994 2801     cmp     r0,1h                                   
0801B996 D801     bhi     @@end       ;21 22两种逃亡信息不会跳过                           
0801B998 F038F856 bl      8053A48h    

@@end:                                
0801B99C B003     add     sp,0Ch                                  
0801B99E BC08     pop     r3                                      
0801B9A0 4698     mov     r8,r3                                   
0801B9A2 BCF0     pop     r4-r7                                   
0801B9A4 BC01     pop     r0                                      
0801B9A6 4700     bx      r0 

;pose23                                     
0801B9A8 B510     push    r4,r14                                  
0801B9AA 4804     ldr     r0,=3000738h                            
0801B9AC 7F82     ldrb    r2,[r0,1Eh]                             
0801B9AE 1C03     mov     r3,r0                                   
0801B9B0 2A20     cmp     r2,20h       ;是否是全装甲                            
0801B9B2 D107     bne     @@NoFullSuitGet                                
0801B9B4 4902     ldr     r1,=3001606h                            
0801B9B6 2000     mov     r0,0h                                   
0801B9B8 E008     b       @@Peer                                  

@@NoFullSuitGet:                              
0801B9C4 4905     ldr     r1,=3001606h                            
0801B9C6 24FA     mov     r4,0FAh                                 
0801B9C8 00A4     lsl     r4,r4,2h                                
0801B9CA 1C20     mov     r0,r4       ;定时写入CB2

@@Peer:                                 
0801B9CC 8008     strh    r0,[r1]     ;定时写入0                               
0801B9CE 1C19     mov     r1,r3                                   
0801B9D0 88C8     ldrh    r0,[r1,6h]  ;同时写入偏移6                            
0801B9D2 2800     cmp     r0,0h                                   
0801B9D4 D004     beq     @@TimeZero                                
0801B9D6 3801     sub     r0,1h                                   
0801B9D8 80C8     strh    r0,[r1,6h]  ;减1再写入                              
0801B9DA E011     b       @@end                                
.pool

@@TimeZero:                              
0801B9E0 2A16     cmp     r2,16h                                  
0801B9E2 D00D     beq     @@end       ;是保存的话结束                          
0801B9E4 4808     ldr     r0,=300137Ch                            
0801B9E6 8801     ldrh    r1,[r0]     ;读取输入                            
0801B9E8 20F3     mov     r0,0F3h                                 
0801B9EA 4008     and     r0,r1       ;基本涵盖了很多的按键                            
0801B9EC 2800     cmp     r0,0h                                   
0801B9EE D103     bne     @@Press                                
0801B9F0 4806     ldr     r0,=30013D2h  ;????                          
0801B9F2 7800     ldrb    r0,[r0]     ;为2的时候会进入菜单                            
0801B9F4 2800     cmp     r0,0h       ;但是出来后黑屏                            
0801B9F6 D003     beq     @@end

@@Press:                               
0801B9F8 1C19     mov     r1,r3                                   
0801B9FA 3124     add     r1,24h                                  
0801B9FC 2024     mov     r0,24h      ;pose24                               
0801B9FE 7008     strb    r0,[r1]

@@end:                                 
0801BA00 BC10     pop     r4                                      
0801BA02 BC01     pop     r0                                      
0801BA04 4700     bx      r0                                      
.pool
 
;pose 24 
0801BA10 B500     push    r14                                     
0801BA12 4808     ldr     r0,=3000044h                            
0801BA14 7800     ldrb    r0,[r0]     ;非能力道具无法吃到flag                            
0801BA16 0600     lsl     r0,r0,18h   ;吃到道具的时候也会为1                            
0801BA18 1600     asr     r0,r0,18h   ;按掉信息就会为0                            
0801BA1A 2800     cmp     r0,0h                                   
0801BA1C D001     beq     @@Flag                               
0801BA1E F03FF9B5 bl      805AD8Ch    ;去除收集过的道具

@@Flag:                               
0801BA22 4805     ldr     r0,=3000738h                            
0801BA24 6982     ldr     r2,[r0,18h]                             
0801BA26 4905     ldr     r1,=82CBB5Ch                            
0801BA28 1C03     mov     r3,r0                                   
0801BA2A 428A     cmp     r2,r1                                   
0801BA2C D10A     bne     @@OAMDifferent                                
0801BA2E 4804     ldr     r0,=82CBB14h                            
0801BA30 E009     b       @@Peer
.pool

@@OAMDifferent:                               
0801BA44 4805     ldr     r0,=82CBA64h

@@Peer:                            
0801BA46 6198     str     r0,[r3,18h]                             
0801BA48 2000     mov     r0,0h                                   
0801BA4A 7718     strb    r0,[r3,1Ch]                             
0801BA4C 82D8     strh    r0,[r3,16h]                             
0801BA4E 1C19     mov     r1,r3                                   
0801BA50 3124     add     r1,24h                                  
0801BA52 2025     mov     r0,25h                                  
0801BA54 7008     strb    r0,[r1]    ;pose 写入25                               
0801BA56 BC01     pop     r0                                      
0801BA58 4700     bx      r0                                      
.pool

;pose 25                              
0801BA60 B5F0     push    r4-r7,r14                               
0801BA62 B082     add     sp,-8h                                  
0801BA64 4E07     ldr     r6,=3000738h                            
0801BA66 7FB4     ldrb    r4,[r6,1Eh]                             
0801BA68 1C25     mov     r5,r4                                   
0801BA6A F7F4F8AD bl      800FBC8h                                
0801BA6E 2800     cmp     r0,0h        ;检查动画结束                           
0801BA70 D046     beq     @@end                                
0801BA72 2700     mov     r7,0h                                   
0801BA74 8037     strh    r7,[r6]      ;精灵去除                            
0801BA76 2C17     cmp     r4,17h       ;保存完毕信息                           
0801BA78 D108     bne     @@NoSaveCompleteMessage                               
0801BA7A 4903     ldr     r1,=3000049h                            
0801BA7C 2000     mov     r0,0h                                   
0801BA7E 7008     strb    r0,[r1]      ;禁用暂停去除                           
0801BA80 E033     b       @@Peer                                
.pool

@@NoSaveCompleteMessage:                              
0801BA8C 2C20     cmp     r4,20h       ;检查是否是全装甲信息                            
0801BA8E D121     bne     @@NoFullSuitGetMessage                                
0801BA90 490D     ldr     r1,=300070Ch                            
0801BA92 2007     mov     r0,7h                                   
0801BA94 73C8     strb    r0,[r1,0Fh]                             
0801BA96 20BC     mov     r0,0BCh      ;                           
0801BA98 2107     mov     r1,7h                                   
0801BA9A F7F2FAF3 bl      800E084h                                
0801BA9E 20BC     mov     r0,0BCh                                 
0801BAA0 2107     mov     r1,7h                                   
0801BAA2 2201     mov     r2,1h                                   
0801BAA4 F7F2FB04 bl      800E0B0h                                
0801BAA8 4808     ldr     r0,=300080Ch                            
0801BAAA 8803     ldrh    r3,[r0]                                 
0801BAAC 4908     ldr     r1,=0FFFFFF00h                          
0801BAAE 185B     add     r3,r3,r1                                
0801BAB0 8840     ldrh    r0,[r0,2h]                              
0801BAB2 21C0     mov     r1,0C0h                                 
0801BAB4 0089     lsl     r1,r1,2h                                
0801BAB6 1840     add     r0,r0,r1                                
0801BAB8 9000     str     r0,[sp]                                 
0801BABA 9701     str     r7,[sp,4h]                              
0801BABC 20BC     mov     r0,0BCh                                 
0801BABE 2100     mov     r1,0h                                   
0801BAC0 2207     mov     r2,7h                                   
0801BAC2 F7F2FC2B bl      800E31Ch   ;生产那个下降的石柱                             
0801BAC6 E010     b       @@Peer                                
.pool

@@NoFullSuitGetMessage:                               
0801BAD4 1E68     sub     r0,r5,1                                 
0801BAD6 0600     lsl     r0,r0,18h                               
0801BAD8 0E00     lsr     r0,r0,18h                               
0801BADA 2801     cmp     r0,1h                                   
0801BADC D903     bls     @@FSTItem                                
0801BADE 2D04     cmp     r5,4h                                   
0801BAE0 D001     beq     @@FSTItem
0801BAE2 2D06     cmp     r5,6h                                   
0801BAE4 D101     bne     @@Peer  

@@FSTItem:                              
0801BAE6 F7E8FB33 bl      8004150h 

@@Peer:                               
0801BAEA 4907     ldr     r1,=3001606h                            
0801BAEC 2000     mov     r0,0h                                   
0801BAEE 8008     strh    r0,[r1]      ;定时写入0                           
0801BAF0 4806     ldr     r0,=3000738h                            
0801BAF2 302E     add     r0,2Eh                                  
0801BAF4 7800     ldrb    r0,[r0]                                 
0801BAF6 2800     cmp     r0,0h       ;偏移2E的值是否为0                           
0801BAF8 D002     beq     @@end                                
0801BAFA 4905     ldr     r1,=3000BF0h                            
0801BAFC 2006     mov     r0,6h                                   
0801BAFE 7008     strb    r0,[r1]     ;gfxrow写入6

@@end:                                
0801BB00 B002     add     sp,8h                                   
0801BB02 BCF0     pop     r4-r7                                   
0801BB04 BC01     pop     r0                                      
0801BB06 4700     bx      r0                                      
                              
/////////////////////////////////////////////////////////////////////////////////////////

;字幕pose 0h调用例程
0806F258 B5F0     push    r4-r7,r14     ;r0取向 球为17h r1 gfx row                                
0806F25A 0600     lsl     r0,r0,18h                               
0806F25C 0E00     lsr     r0,r0,18h                               
0806F25E 0609     lsl     r1,r1,18h                               
0806F260 0E0C     lsr     r4,r1,18h     ;gfx row                          
0806F262 4B08     ldr     r3,=3000C0Ch                            
0806F264 1C1A     mov     r2,r3                                   
0806F266 4908     ldr     r1,=840DC50h                            
0806F268 C9E0     ldmia   [r1]!,r5-r7   ;全部是0?                          
0806F26A C2E0     stmia   [r2]!,r5-r7                             
0806F26C 6809     ldr     r1,[r1]                                 
0806F26E 6011     str     r1,[r2]                                 
0806F270 1C01     mov     r1,r0                                   
0806F272 2823     cmp     r0,23h        ;小于或等于23跳转                           
0806F274 D900     bls     @@pass                               
0806F276 2123     mov     r1,23h 

@@pass:                                 
0806F278 7299     strb    r1,[r3,0Ah]   ;写入3000c16 当前信息的序号                          
0806F27A 72DC     strb    r4,[r3,0Bh]   ;写入3000c17 当前信息的gfx row                          
0806F27C BCF0     pop     r4-r7                                   
0806F27E BC01     pop     r0                                      
0806F280 4700     bx      r0                                      
.definelabel pose9Table,806F2B0h
;字幕 pose 9h 经历例程                       
0806F28C B5F0     push    r4-r7,r14                               
0806F28E B081     add     sp,-4h                                  
0806F290 4805     ldr     r0,=3000C0Ch                            
0806F292 7B02     ldrb    r2,[r0,0Ch]   ;读取3000c18的值                          
0806F294 1C07     mov     r7,r0                                   
0806F296 2A04     cmp     r2,4h                                   
0806F298 D900     bls     @@c18<=four                                
0806F29A E0A6     b       @@pass  

@@c18<=four:                              
0806F29C 0090     lsl     r0,r2,2h                                
0806F29E 4903     ldr     r1,=pose9Table                            
0806F2A0 1840     add     r0,r0,r1                                
0806F2A2 6800     ldr     r0,[r0]                                 
0806F2A4 4687     mov     r15,r0                                  
.org pose9Table:
    .word 806f2c4h
	.word 806f2f4h
	.word 806f338h
	.word 806f3c4h
	.word 806f3eah
;00                               
0806F2C4 2601     mov     r6,1h                                   
0806F2C6 4276     neg     r6,r6         ;ffffffffh                                 
0806F2C8 7AFA     ldrb    r2,[r7,0Bh]   ;3000c17 gfx row  6h                        
0806F2CA 02D2     lsl     r2,r2,0Bh     ;3000h                          
0806F2CC 4807     ldr     r0,=6014000h                            
0806F2CE 1812     add     r2,r2,r0      ;6017000h 填地址                             
0806F2D0 25E0     mov     r5,0E0h                                 
0806F2D2 00AD     lsl     r5,r5,2h      ;380h                           
0806F2D4 2420     mov     r4,20h                                  
0806F2D6 9400     str     r4,[sp]                                 
0806F2D8 2003     mov     r0,3h         ;DMA通道 直接内存存取通道?                          
0806F2DA 1C31     mov     r1,r6         ;值 ffffffffh                         
0806F2DC 1C2B     mov     r3,r5         ;长度380h                          
0806F2DE F793FFE9 bl      80032B4h      ;16bit填满                          
0806F2E2 7AFA     ldrb    r2,[r7,0Bh]                             
0806F2E4 02D2     lsl     r2,r2,0Bh                               
0806F2E6 4B02     ldr     r3,=6014400h                            
0806F2E8 E016     b       @@goto                                

;01h                              
0806F2F4 2601     mov     r6,1h                                   
0806F2F6 4276     neg     r6,r6                                   
0806F2F8 7AFA     ldrb    r2,[r7,0Bh]                             
0806F2FA 02D2     lsl     r2,r2,0Bh                               
0806F2FC 480C     ldr     r0,=6014800h                            
0806F2FE 1812     add     r2,r2,r0      ;6017800h                            
0806F300 25E0     mov     r5,0E0h                                 
0806F302 00AD     lsl     r5,r5,2h                                
0806F304 2420     mov     r4,20h                                  
0806F306 9400     str     r4,[sp]                                 
0806F308 2003     mov     r0,3h                                   
0806F30A 1C31     mov     r1,r6                                   
0806F30C 1C2B     mov     r3,r5                                   
0806F30E F793FFD1 bl      80032B4h                                
0806F312 7AFA     ldrb    r2,[r7,0Bh]                             
0806F314 02D2     lsl     r2,r2,0Bh                               
0806F316 4B07     ldr     r3,=6014C00h

@@goto:                            
0806F318 18D2     add     r2,r2,r3 ;6017400 6017c00                               
0806F31A 9400     str     r4,[sp]  ;20h                               
0806F31C 2003     mov     r0,3h                                   
0806F31E 1C31     mov     r1,r6                                   
0806F320 1C2B     mov     r3,r5                                   
0806F322 F793FFC7 bl      80032B4h                                
0806F326 7B38     ldrb    r0,[r7,0Ch]  ;3000c18加1 进行下一fill                           
0806F328 3001     add     r0,1h                                   
0806F32A 7338     strb    r0,[r7,0Ch]                             
0806F32C E064     b       @@end                                

;02h                              
0806F338 2508     mov     r5,8h                                   
0806F33A 79F8     ldrb    r0,[r7,7h] ;3000c13  0h?                            
0806F33C 2801     cmp     r0,1h                                   
0806F33E D802     bhi     @@C13>one                                
0806F340 7BB8     ldrb    r0,[r7,0Eh] ;3000c1a 0h?                            
0806F342 2800     cmp     r0,0h                                   
0806F344 D003     beq     C1A=zero 

@@C13>one:                              
0806F346 7B38     ldrb    r0,[r7,0Ch] ;C18 加1                            
0806F348 3001     add     r0,1h                                   
0806F34A 7338     strb    r0,[r7,0Ch]                             
0806F34C 2500     mov     r5,0h       ;并且r5写入0h

@@C1A=zero:                                  
0806F34E 2D00     cmp     r5,0h                                   
0806F350 D052     beq     @@end                                
0806F352 4C10     ldr     r4,=3000C0Ch                            
0806F354 4E10     ldr     r6,=8760780h                            
0806F356 4811     ldr     r0,=3000020h  ;语言                          
0806F358 7800     ldrb    r0,[r0]                                 
0806F35A 0600     lsl     r0,r0,18h                               
0806F35C 1600     asr     r0,r0,18h                               
0806F35E 0080     lsl     r0,r0,2h     ;8h                           
0806F360 1980     add     r0,r0,r6     ;8760788h                           
0806F362 7AA1     ldrb    r1,[r4,0Ah]  ;C16 10h                           
0806F364 6800     ldr     r0,[r0]      ;08760660h                           
0806F366 0089     lsl     r1,r1,2h     ;40h                           
0806F368 1809     add     r1,r1,r0     ;087606a0h                           
0806F36A 6809     ldr     r1,[r1]      ;084428c0h                           
0806F36C 7AE2     ldrb    r2,[r4,0Bh]  ;C17 6h                           
0806F36E 02D2     lsl     r2,r2,0Bh    ;3000h                           
0806F370 79E0     ldrb    r0,[r4,7h]   ;C13 0h                           
0806F372 02C0     lsl     r0,r0,0Bh                               
0806F374 4B0A     ldr     r3,=6014000h                            
0806F376 18C0     add     r0,r0,r3                                
0806F378 1812     add     r2,r2,r0     ;6017000h                           
0806F37A 1C20     mov     r0,r4                                   
0806F37C F000FB06 bl      806F98Ch                                
0806F380 0600     lsl     r0,r0,18h                               
0806F382 0E00     lsr     r0,r0,18h                               
0806F384 2802     cmp     r0,2h                                   
0806F386 D010     beq     806F3AAh                                
0806F388 2802     cmp     r0,2h                                   
0806F38A DC0B     bgt     806F3A4h                                
0806F38C 2801     cmp     r0,1h                                   
0806F38E D00F     beq     806F3B0h                                
0806F390 E011     b       806F3B6h                                
0806F392 0000     lsl     r0,r0,0h                                
0806F394 0C0C     lsr     r4,r1,10h                               
0806F396 0300     lsl     r0,r0,0Ch                               
0806F398 0780     lsl     r0,r0,1Eh                               
0806F39A 0876     lsr     r6,r6,1h                                
0806F39C 0020     lsl     r0,r4,0h                                
0806F39E 0300     lsl     r0,r0,0Ch                               
0806F3A0 4000     and     r0,r0                                   
0806F3A2 0601     lsl     r1,r0,18h                               
0806F3A4 2804     cmp     r0,4h                                   
0806F3A6 D003     beq     806F3B0h                                
0806F3A8 E005     b       806F3B6h                                
0806F3AA 7B20     ldrb    r0,[r4,0Ch]                             
0806F3AC 3001     add     r0,1h                                   
0806F3AE 7320     strb    r0,[r4,0Ch]                             
0806F3B0 2000     mov     r0,0h                                   
0806F3B2 8060     strh    r0,[r4,2h]                              
0806F3B4 E020     b       806F3F8h                                
0806F3B6 79E0     ldrb    r0,[r4,7h]                              
0806F3B8 2801     cmp     r0,1h                                   
0806F3BA D81D     bhi     806F3F8h                                
0806F3BC 3D01     sub     r5,1h                                   
0806F3BE 2D00     cmp     r5,0h                                   
0806F3C0 D1C9     bne     806F356h                                
0806F3C2 E019     b       806F3F8h 

;03h                               
0806F3C4 490A     ldr     r1,=3000C0Ch                            
0806F3C6 79C8     ldrb    r0,[r1,7h]                              
0806F3C8 3001     add     r0,1h                                   
0806F3CA 71C8     strb    r0,[r1,7h]                              
0806F3CC 7A8A     ldrb    r2,[r1,0Ah]                             
0806F3CE 1C11     mov     r1,r2                                   
0806F3D0 2915     cmp     r1,15h                                  
0806F3D2 D805     bhi     806F3E0h                                
0806F3D4 4807     ldr     r0,=3000BF2h                            
0806F3D6 7002     strb    r2,[r0]                                 
0806F3D8 2907     cmp     r1,7h                                   
0806F3DA D901     bls     806F3E0h                                
0806F3DC F7EBFD06 bl      805ADECh                                
0806F3E0 4903     ldr     r1,=3000C0Ch                            
0806F3E2 7B08     ldrb    r0,[r1,0Ch]                             
0806F3E4 3001     add     r0,1h                                   
0806F3E6 7308     strb    r0,[r1,0Ch]                             
0806F3E8 1C0F     mov     r7,r1   

@@pass:                                
0806F3EA 79F8     ldrb    r0,[r7,7h]                              
0806F3EC E005     b       806F3FAh                                 

@@end:                             
0806F3F8 2000     mov     r0,0h

                                   
0806F3FA B001     add     sp,4h                                   
0806F3FC BCF0     pop     r4-r7                                   
0806F3FE BC02     pop     r1                                      
0806F400 4708     bx      r1                                      
0806F402 0000     lsl     r0,r0,0h                                
0806F404 B570     push    r4-r6,r14                               
0806F406 4B05     ldr     r3,=3000C0Ch                            
0806F408 1C1A     mov     r2,r3                                   
0806F40A 4905     ldr     r1,=840DC60h                            
0806F40C C970     ldmia   [r1]!,r4-r6                             
0806F40E C270     stmia   [r2]!,r4-r6                             
0806F410 6809     ldr     r1,[r1]                                 
0806F412 6011     str     r1,[r2]                                 
0806F414 7298     strb    r0,[r3,0Ah]                             
0806F416 BC70     pop     r4-r6                                   
0806F418 BC01     pop     r0                                      
0806F41A 4700     bx      r0                                      
0806F41C 0C0C     lsr     r4,r1,10h                               
0806F41E 0300     lsl     r0,r0,0Ch                               
0806F420 DC60     bgt     806F4E4h                                
0806F422 0840     lsr     r0,r0,1h                                
0806F424 B5F0     push    r4-r7,r14                               
0806F426 B081     add     sp,-4h                                  
0806F428 4805     ldr     r0,=3000C0Ch                            
0806F42A 7B01     ldrb    r1,[r0,0Ch]                             
0806F42C 1C06     mov     r6,r0                                   
0806F42E 2904     cmp     r1,4h                                   
0806F430 D900     bls     806F434h                                
0806F432 E0AF     b       806F594h                                
0806F434 0088     lsl     r0,r1,2h                                
0806F436 4903     ldr     r1,=806F448h                            
0806F438 1840     add     r0,r0,r1                                
0806F43A 6800     ldr     r0,[r0]                                 
0806F43C 4687     mov     r15,r0                                  
0806F43E 0000     lsl     r0,r0,0h                                
0806F440 0C0C     lsr     r4,r1,10h                               
0806F442 0300     lsl     r0,r0,0Ch                               
0806F444 F448     ????                                            
0806F446 0806     lsr     r6,r0,20h                               
0806F448 F45C     ????                                            
0806F44A 0806     lsr     r6,r0,20h                               
0806F44C F49C     ????                                            
0806F44E 0806     lsr     r6,r0,20h                               
0806F450 F4D4     ????                                            
0806F452 0806     lsr     r6,r0,20h                               
0806F454 F588     ????                                            
0806F456 0806     lsr     r6,r0,20h                               


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;字幕pose 8 第2次调用例程
0800E084 B500     push    r14                                     
0800E086 0600     lsl     r0,r0,18h    ;r0=11000000h                            
0800E088 0609     lsl     r1,r1,18h    ;06000000h                           
0800E08A 22F0     mov     r2,0F0h                                 
0800E08C 0612     lsl     r2,r2,18h                               
0800E08E 1880     add     r0,r0,r2     ;01000000h                           
0800E090 4A05     ldr     r2,=875EBF8h                            
0800E092 0D80     lsr     r0,r0,16h    ;4h 相当于乘以4...                           
0800E094 1880     add     r0,r0,r2     ;相加得到偏移地址                           
0800E096 6800     ldr     r0,[r0]      ;得到跳转地址                           
0800E098 0B49     lsr     r1,r1,0Dh    ;3000h                           
0800E09A 4A04     ldr     r2,=6014000h                            
0800E09C 1889     add     r1,r1,r2     ;6017000h                           
0800E09E F7F7F881 bl      80051A4h     ;中断???                           
0800E0A2 BC01     pop     r0                                      
0800E0A4 4700     bx      r0     
                                 
;字幕pose 8 第1次调用例程                                     
0800E0B0 B510     push    r4,r14                                  
0800E0B2 0600     lsl     r0,r0,18h    ;11000000h                             
0800E0B4 0609     lsl     r1,r1,18h    ;6000000h                           
0800E0B6 0612     lsl     r2,r2,18h    ;1000000h                           
0800E0B8 23F0     mov     r3,0F0h                                 
0800E0BA 061B     lsl     r3,r3,18h                               
0800E0BC 18C0     add     r0,r0,r3                                
0800E0BE 4C09     ldr     r4,=40000D4h                            
0800E0C0 4B09     ldr     r3,=875EEF0h                            
0800E0C2 0D80     lsr     r0,r0,16h    ;4h                           
0800E0C4 18C0     add     r0,r0,r3     ;相加得到偏移地址                           
0800E0C6 6800     ldr     r0,[r0]      ;得到跳转地址                           
0800E0C8 6020     str     r0,[r4]      ;写入40000d4                           
0800E0CA 0CC9     lsr     r1,r1,13h    ;c0h                           
0800E0CC 4807     ldr     r0,=5000300h                            
0800E0CE 1809     add     r1,r1,r0     ;50003c0h                           
0800E0D0 6061     str     r1,[r4,4h]   ;写入40000d8h                           
0800E0D2 0D12     lsr     r2,r2,14h    ;10h                           
0800E0D4 2080     mov     r0,80h                                  
0800E0D6 0600     lsl     r0,r0,18h                               
0800E0D8 4302     orr     r2,r0        ;8000010h                            
0800E0DA 60A2     str     r2,[r4,8h]   ;写入40000dch                           
0800E0DC 68A0     ldr     r0,[r4,8h]                              
0800E0DE BC10     pop     r4                                      
0800E0E0 BC01     pop     r0                                      
0800E0E2 4700     bx      r0                                      

