0800924C B530     push    r4,r5,r14               
0800924E 1C04     mov     r4,r0                   
08009250 7920     ldrb    r0,[r4,4h]              
08009252 1C01     mov     r1,r0                   
08009254 2915     cmp     r1,15h                  
08009256 D903     bls     @@Pass                
08009258 2001     mov     r0,1h                   
0800925A 7120     strb    r0,[r4,4h]    ;bounce flag 

@@PoseFE:         
0800925C 20FE     mov     r0,0FEh                 
0800925E E0A5     b       @@end  

@@Pass:              
08009260 2913     cmp     r1,13h                  
08009262 D902     bls     @@Pass2                
08009264 3001     add     r0,1h        ;加一...           
08009266 7120     strb    r0,[r4,4h]              
08009268 E09F     b       @@NoChangePoseEnd 

@@Pass2:               
0800926A 4810     ldr     r0,=3001380h            
0800926C 8801     ldrh    r1,[r0]                 
0800926E 2201     mov     r2,1h                   
08009270 1C10     mov     r0,r2                   
08009272 4008     and     r0,r1                   
08009274 2800     cmp     r0,0h      ;检查是否按了跳                
08009276 D01F     beq     @@NoPressJump               
08009278 480D     ldr     r0,=3001530h            
0800927A 7BC1     ldrb    r1,[r0,0Fh]             
0800927C 1C10     mov     r0,r2                   
0800927E 4008     and     r0,r1                   
08009280 2800     cmp     r0,0h      ;检查是否高跳能力激活              
08009282 D019     beq     @@NoPressJump                
08009284 7A20     ldrb    r0,[r4,8h]              
08009286 2800     cmp     r0,0h      ;检查金身时间             
08009288 D016     beq     @@NoPressJump                
0800928A 480A     ldr     r0,=823A554h            
0800928C 8A01     ldrh    r1,[r0,10h]             
0800928E 3940     sub     r1,40h                  
08009290 0409     lsl     r1,r1,10h               
08009292 1409     asr     r1,r1,10h               
08009294 1C20     mov     r0,r4                   
08009296 F7FCFAA9 bl      80057ECh   ;检查球跳上面的判定            
0800929A 0600     lsl     r0,r0,18h               
0800929C 2800     cmp     r0,0h                   
0800929E D10B     bne     @@NoPressJump                
080092A0 8AA0     ldrh    r0,[r4,14h]             
080092A2 3820     sub     r0,20h                  
080092A4 82A0     strh    r0,[r4,14h]             
080092A6 2025     mov     r0,25h     ;球冲刺准备动作            
080092A8 E080     b       @@end                
.pool

@@NoPressJump:             
080092B8 1C20     mov     r0,r4                   
080092BA F7FEFECF bl      800805Ch   ;检查是否即时输入跳             
080092BE 0600     lsl     r0,r0,18h               
080092C0 2800     cmp     r0,0h                   
080092C2 D008     beq     @@NoPressA                
080092C4 7921     ldrb    r1,[r4,4h]              
080092C6 2901     cmp     r1,1h                   
080092C8 D1C8     bne     @@PoseFE                
080092CA 4807     ldr     r0,=3001530h            
080092CC 7BC0     ldrb    r0,[r0,0Fh]             
080092CE 4008     and     r0,r1                   
080092D0 2800     cmp     r0,0h      ;检查是否有高跳             
080092D2 D1C3     bne     @@PoseFE                
080092D4 7120     strb    r0,[r4,4h] 

@@NoPressA:             
080092D6 4805     ldr     r0,=300137Ch            
080092D8 8800     ldrh    r0,[r0]                 
080092DA 2130     mov     r1,30h                  
080092DC 4001     and     r1,r0      ;检查是否按着左右            
080092DE 2900     cmp     r1,0h                   
080092E0 D006     beq     @@NoPressLeftRight                
080092E2 81E1     strh    r1,[r4,0Eh]             
080092E4 2012     mov     r0,12h     ;pose写为滚球              
080092E6 E061     b       @@end                
.pool

@@NoPressLeftRight:              
080092F0 480E     ldr     r0,=3001380h            
080092F2 8801     ldrh    r1,[r0]                 
080092F4 2040     mov     r0,40h                  
080092F6 4008     and     r0,r1      ;检查是否即时输入上             
080092F8 2800     cmp     r0,0h                   
080092FA D044     beq     @@NoPressingUp                
080092FC 4D0C     ldr     r5,=823A554h            
080092FE 2004     mov     r0,4h                   
08009300 5E29     ldsh    r1,[r5,r0]              
08009302 1C20     mov     r0,r4                   
08009304 F7FCFA72 bl      80057ECh                
08009308 0600     lsl     r0,r0,18h               
0800930A 0E00     lsr     r0,r0,18h  ;检查上部             
0800930C 2801     cmp     r0,1h                   
0800930E D115     bne     @@CheckOther  
;返回1的话             左边稍重合
08009310 8829     ldrh    r1,[r5]    ;0FFE4 左边的分界             
08009312 8A62     ldrh    r2,[r4,12h];X坐标             
08009314 1888     add     r0,r1,r2   ;得到球的左部分界             
08009316 0400     lsl     r0,r0,10h               
08009318 0C02     lsr     r2,r0,10h               
0800931A 4806     ldr     r0,=0FFC0h              
0800931C 4002     and     r2,r0      ;去掉小于40的部分             
0800931E 1A51     sub     r1,r2,r1                
08009320 3140     add     r1,40h                  
08009322 8261     strh    r1,[r4,12h]             
08009324 4804     ldr     r0,=3001600h            
08009326 8001     strh    r1,[r0]                 
08009328 E019     b       @@Peer                
.pool


@@CheckOther:              
0800933C 2808     cmp     r0,8h                   
0800933E D10C     bne     @@LastCheck                
08009340 8869     ldrh    r1,[r5,2h]              
08009342 8A62     ldrh    r2,[r4,12h]             
08009344 1888     add     r0,r1,r2                
08009346 0400     lsl     r0,r0,10h               
08009348 0C02     lsr     r2,r0,10h               
0800934A 4809     ldr     r0,=0FFC0h              
0800934C 4002     and     r2,r0                   
0800934E 1A51     sub     r1,r2,r1                
08009350 3901     sub     r1,1h                   
08009352 8261     strh    r1,[r4,12h]             
08009354 4807     ldr     r0,=3001600h            
08009356 8001     strh    r1,[r0]                 
08009358 2000     mov     r0,0h 

@@LastCheck:                  
0800935A 2800     cmp     r0,0h                   
0800935C D113     bne     NoPressingUp

@@Peer:                
0800935E 4806     ldr     r0,=3001588h            
08009360 305B     add     r0,5Bh                  
08009362 7800     ldrb    r0,[r0]                 
08009364 F2FBF800 bl      8304368h                
08009368 E020     b       @@end                
0800936A F7F9FB55 bl      8002A18h                
0800936E E008     b       8009382h                
08009370 FFC0     bl      lr+0F80h                
08009372 0000     lsl     r0,r0,0h                
08009374 1600     asr     r0,r0,18h               
08009376 0300     lsl     r0,r0,0Ch               
08009378 1588     asr     r0,r1,16h               
0800937A 0300     lsl     r0,r0,0Ch               
0800937C 2078     mov     r0,78h                  
0800937E F7F9FB4B bl      8002A18h                
08009382 2013     mov     r0,13h                  
08009384 E012     b       @@end  

@@NoPressingUp:              
08009386 7AA0     ldrb    r0,[r4,0Ah]             
08009388 2800     cmp     r0,0h       ;检查金身时间             
0800938A D00E     beq     @@NoChangePoseEnd                
0800938C 3801     sub     r0,1h                   
0800938E 72A0     strb    r0,[r4,0Ah] ;减1再写入          
08009390 4808     ldr     r0,=300137Ch            
08009392 8801     ldrh    r1,[r0]                 
08009394 20F0     mov     r0,0F0h                 
08009396 4008     and     r0,r1                   
08009398 2880     cmp     r0,80h      ;检查方向是否只按住了下            
0800939A D106     bne     @@NoChangePoseEnd                
0800939C 20B4     mov     r0,0B4h                 
0800939E 7220     strb    r0,[r4,8h]  ;金身状态时间写入            
080093A0 2000     mov     r0,0h                   
080093A2 72A0     strb    r0,[r4,0Ah]             
080093A4 4904     ldr     r1,=3001528h            
080093A6 2008     mov     r0,8h                   
080093A8 7008     strb    r0,[r1]     ;地面爆花特效

@@NoChangePoseEnd:                 
080093AA 20FF     mov     r0,0FFh 

@@end:                
080093AC BC30     pop     r4,r5                   
080093AE BC02     pop     r1                      
080093B0 4708     bx      r1                      
.pool
             
080093BC B510     push    r4,r14                  
080093BE 1C04     mov     r4,r0                   
080093C0 4808     ldr     r0,=3001380h            
080093C2 8801     ldrh    r1,[r0]                 
080093C4 2201     mov     r2,1h                   
080093C6 1C10     mov     r0,r2                   
080093C8 4008     and     r0,r1                   
080093CA 2800     cmp     r0,0h                   
080093CC D00E     beq     80093ECh                
080093CE 4806     ldr     r0,=3001530h            
080093D0 7BC1     ldrb    r1,[r0,0Fh]             
080093D2 1C10     mov     r0,r2                   
080093D4 4008     and     r0,r1                   
080093D6 2800     cmp     r0,0h                   
080093D8 D008     beq     80093ECh                
080093DA 2001     mov     r0,1h                   
080093DC 7120     strb    r0,[r4,4h]              
080093DE 20FE     mov     r0,0FEh                 
080093E0 E04F     b       8009482h                
080093E2 0000     lsl     r0,r0,0h                
080093E4 1380     asr     r0,r0,0Eh               
080093E6 0300     lsl     r0,r0,0Ch               
080093E8 1530     asr     r0,r6,14h               
080093EA 0300     lsl     r0,r0,0Ch               
080093EC 480B     ldr     r0,=823A554h            
080093EE F2FAFFC9 bl      8304384h                
080093F2 2813     cmp     r0,13h                  
080093F4 D11D     bne     8009432h                
080093F6 E044     b       8009482h                
080093F8 0600     lsl     r0,r0,18h               
080093FA 2800     cmp     r0,0h                   
080093FC D119     bne     8009432h                
080093FE 4808     ldr     r0,=3001380h            
08009400 8801     ldrh    r1,[r0]                 
08009402 2040     mov     r0,40h                  
08009404 4008     and     r0,r1                   
08009406 2800     cmp     r0,0h                   
08009408 D013     beq     8009432h                
0800940A 4806     ldr     r0,=3001588h            
0800940C 305B     add     r0,5Bh                  
0800940E 7800     ldrb    r0,[r0]                 
08009410 2800     cmp     r0,0h                   
08009412 D009     beq     8009428h                
08009414 2078     mov     r0,78h                  
08009416 F7F9FAFF bl      8002A18h                
0800941A E008     b       800942Eh                
0800941C A554     add     r5,=8009570h            
0800941E 0823     lsr     r3,r4,20h               
08009420 1380     asr     r0,r0,0Eh               
08009422 0300     lsl     r0,r0,0Ch               
08009424 1588     asr     r0,r1,16h               
08009426 0300     lsl     r0,r0,0Ch               
08009428 2078     mov     r0,78h                  
0800942A F7F9FAF5 bl      8002A18h                
0800942E 2013     mov     r0,13h                  
08009430 E027     b       8009482h                
08009432 480D     ldr     r0,=300137Ch            
08009434 8802     ldrh    r2,[r0]                 
08009436 89E1     ldrh    r1,[r4,0Eh]             
08009438 1C10     mov     r0,r2                   
0800943A 4008     and     r0,r1                   
0800943C 2800     cmp     r0,0h                   
0800943E D017     beq     8009470h                
08009440 4A0A     ldr     r2,=3001588h            
08009442 1C10     mov     r0,r2                   
08009444 3060     add     r0,60h                  
08009446 F2FAFEE7 bl      8304218h                
0800944A 7960     ldrb    r0,[r4,5h]              
0800944C 2800     cmp     r0,0h                   
0800944E D002     beq     8009456h                
08009450 21A0     mov     r1,0A0h                 
08009452 2006     mov     r0,6h                   
08009454 7220     strb    r0,[r4,8h]              
08009456 1C10     mov     r0,r2                   
08009458 305E     add     r0,5Eh                  
0800945A 2200     mov     r2,0h                   
0800945C 5E80     ldsh    r0,[r0,r2]              
0800945E 1C22     mov     r2,r4                   
08009460 F2FAFF50 bl      8304304h                
08009464 20FF     mov     r0,0FFh                 
08009466 E00C     b       8009482h                
08009468 137C     asr     r4,r7,0Dh               
0800946A 0300     lsl     r0,r0,0Ch               
0800946C 1588     asr     r0,r1,16h               
0800946E 0300     lsl     r0,r0,0Ch               
08009470 2030     mov     r0,30h                  
08009472 4048     eor     r0,r1                   
08009474 4010     and     r0,r2                   
08009476 0400     lsl     r0,r0,10h               
08009478 2800     cmp     r0,0h                   
0800947A D001     beq     8009480h                
0800947C 2001     mov     r0,1h                   
0800947E 70E0     strb    r0,[r4,3h]              
08009480 2011     mov     r0,11h                  
08009482 BC10     pop     r4                      
08009484 BC02     pop     r1                      
08009486 4708     bx      r1                      
08009488 B510     push    r4,r14                  
0800948A 1C04     mov     r4,r0                   
0800948C 2100     mov     r1,0h                   
0800948E F7FEFFF5 bl      800847Ch                
08009492 0600     lsl     r0,r0,18h               
08009494 0E00     lsr     r0,r0,18h               
08009496 2802     cmp     r0,2h                   
08009498 D102     bne     80094A0h                
0800949A 2000     mov     r0,0h                   
0800949C 7760     strb    r0,[r4,1Dh]             
0800949E E00B     b       80094B8h                
080094A0 2801     cmp     r0,1h                   
080094A2 D109     bne     80094B8h                
080094A4 7F60     ldrb    r0,[r4,1Dh]             
080094A6 2801     cmp     r0,1h                   
080094A8 D001     beq     80094AEh                
080094AA 2805     cmp     r0,5h                   
080094AC D104     bne     80094B8h                
080094AE 1C20     mov     r0,r4                   
080094B0 2100     mov     r1,0h                   
080094B2 2207     mov     r2,7h                   
080094B4 F7FCFEAE bl      8006214h                
080094B8 20FF     mov     r0,0FFh                 
080094BA BC10     pop     r4                      
080094BC BC02     pop     r1                      
080094BE 4708     bx      r1                      
080094C0 B510     push    r4,r14                  
080094C2 1C04     mov     r4,r0                   
080094C4 4809     ldr     r0,=823A554h            
080094C6 2204     mov     r2,4h                   
080094C8 5E81     ldsh    r1,[r0,r2]              
080094CA 1C20     mov     r0,r4                   
080094CC F7FCF98E bl      80057ECh                
080094D0 0600     lsl     r0,r0,18h               
080094D2 2800     cmp     r0,0h                   
080094D4 D112     bne     80094FCh                
080094D6 4806     ldr     r0,=3001380h            
080094D8 8801     ldrh    r1,[r0]                 
080094DA 2001     mov     r0,1h                   
080094DC 4008     and     r0,r1                   
080094DE 2800     cmp     r0,0h                   
080094E0 D008     beq     80094F4h                
080094E2 2001     mov     r0,1h                   
080094E4 7120     strb    r0,[r4,4h]              
080094E6 20FE     mov     r0,0FEh                 
080094E8 E00B     b       8009502h                
080094EA 0000     lsl     r0,r0,0h                
080094EC A554     add     r5,=8009640h            
080094EE 0823     lsr     r3,r4,20h               
080094F0 1380     asr     r0,r0,0Eh               
080094F2 0300     lsl     r0,r0,0Ch               
080094F4 2080     mov     r0,80h                  
080094F6 4008     and     r0,r1                   
080094F8 2800     cmp     r0,0h                   
080094FA D001     beq     8009500h                
080094FC 2010     mov     r0,10h                  
080094FE 7020     strb    r0,[r4]                 
08009500 20FF     mov     r0,0FFh                 
08009502 BC10     pop     r4                      
08009504 BC02     pop     r1                      
08009506 4708     bx      r1                      
08009508 B510     push    r4,r14                  
0800950A 1C04     mov     r4,r0                   
0800950C 2100     mov     r1,0h                   
0800950E F7FEFFB5 bl      800847Ch                
08009512 0600     lsl     r0,r0,18h               
08009514 0E00     lsr     r0,r0,18h               
08009516 2802     cmp     r0,2h                   
08009518 D001     beq     800951Eh                
0800951A 20FF     mov     r0,0FFh                 
0800951C E002     b       8009524h                
0800951E 200F     mov     r0,0Fh                  
08009520 7260     strb    r0,[r4,9h]              
08009522 2004     mov     r0,4h                   
08009524 BC10     pop     r4                      
08009526 BC02     pop     r1                      
08009528 4708     bx      r1                      
0800952A 0000     lsl     r0,r0,0h                
0800952C B510     push    r4,r14                  
0800952E 1C04     mov     r4,r0                   
08009530 480B     ldr     r0,=3001380h            
08009532 8801     ldrh    r1,[r0]                 
08009534 2040     mov     r0,40h                  
08009536 4008     and     r0,r1                   
08009538 2800     cmp     r0,0h                   
0800953A D01E     beq     800957Ah                
0800953C 4809     ldr     r0,=823A554h            
0800953E 2204     mov     r2,4h                   
08009540 5E81     ldsh    r1,[r0,r2]              
08009542 1C20     mov     r0,r4                   
08009544 F7FCF952 bl      80057ECh                
08009548 0600     lsl     r0,r0,18h               
0800954A 2800     cmp     r0,0h                   

