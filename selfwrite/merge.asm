.gba
.open "zm.gba","Merge.gba",0x8000000

.definelabel CurrSprite,0x3000738
.definelabel SecondSpriteAIStart,875F1E8h
.definelabel DoorEyeSecondID,36h
.definelabel SpriteData,0x30001AC
.definelabel PlaySound,8002A18h
.definelabel SpriteRNG,300083Ch
.definelabel GfxEffect,80540ECh
.definelabel DeathFireWorks,8011084h
.definelabel StunSprite,8011280h
.definelabel YTagRAM,30007F1h
.definelabel CheckBlock,800F688h
.definelabel SpawnNewSecondarySprite,800E258h 

.org SecondSpriteAIStart + ( DoorEyeSecondID * 4 )
    .dw EyeAndEyeBeamAI + 1
	
.org 804a0f4h           ;原本副灵37的产卵处
    mov r0,36h
    mov r1,1h
	
.org 8049f32h           ;副灵眼睛36的序号从主序号改为0
    mov r1,0h
	
.org 804A02Ah
    bl EyeDoorPose9BLa   ;ad眼一开始就会选择睁眼,跳过偏移2C
	
.org 804A032h
    bl EyeDoorPose9BLb	 ;增加初始的ad眼睁眼判定范围

.org 804A114h
    bl EyeDoorPose27BLa  ;ad眼只要不挨打就一直睁着
	
.org 804A144h
    bl EyeDoorPose27BLb  ;ad眼的oam保持睁着的oam
	
.org 804A110h
    bl EyeDoorPose27BLc  ;ae眼多射几发  	
	
.org 8304054h
EyeDoorPose9BLa:
    lsl r0,r0,18h
    lsr r5,r0,18h
	ldrb r0,[r4,1Dh] 
	cmp r0,0AEh         ;ID是0AEh的话则直接结束
	beq @@end
    ldrb r0,[r6,1h]     ;读取偏移2D的值
    cmp r0,0h
    bne @@end
    strb r0,[r6]        ;无条件睁眼
    mov r5,r0
@@end:
    bx r14   
 	
EyeDoorPose9BLb:        ;睁眼判定范围超大
    mov r1,0E0h
    lsl r1,r1,1h
	ldrb r0,[r4,1Dh] 
	cmp r0,0AEh
	beq @@end
	ldrb r0,[r6,1h]
	cmp r0,0h
	bne @@end
	mov r1,0C0h
	lsl r1,r1,4h
@@end:
    bx r14	
	 
EyeDoorPose27BLa:
    ldrb r0,[r1]
	mov r2,r0
    ldrb r5,[r4,1Dh]  
	cmp r5,0AEh         ;ID是0AEh的话则直接结束
	beq @@end
	ldrb r5,[r1,1h]     
	cmp r5,0h
	bne @@end
	mov r2,2h           ;不挨打就不闭眼
@@end:
    bx r14	

EyeDoorPose27BLb:       ;睁眼的OAM保持
    strb r2,[r1]        ;偏移2C减1再写入
	ldr r2,[r4,18h]
	ldrb r0,[r4,1Dh]    
	cmp r0,0AEh
	beq @@end
	ldrb r0,[r1,1h]
	cmp r0,0h
	bne @@end
	ldr r2,=831886Ch    
@@end:	
	mov r1,r2
    bx r14	
.pool
  
EyeDoorPose27BLc:
    push lr
    add sp,-0Ch
	mov r0,r4
    add r0,24h
	ldrb r1,[r0]
    cmp r1,0ADh
	beq @@end
	add r0,8h
	ldrb r1,[r0]
	cmp r1,53h
	beq @@SecondShoot
	cmp r1,4Dh
	bne @@end
	mov r1,3h
	b @@SpawnShoot
@@SecondShoot:
    mov r1,2h
@@SpawnShoot:
    sub  r0,r0,1h
	ldrb r3,[r0]
    ldrh r0,[r4,2h]
    str r0,[sp]
    ldrh r0,[r4,4h]
    add r0,10h
    str r0,[sp,4h]
    mov r0,40h
    str r0,[sp,8h]
    ldrb r2,[r4,1Fh]
	mov r0,36h 
    bl SpawnNewSecondarySprite	
@@end:
    mov r1,r4
    add r1,2Ch	
	add sp,0Ch
	pop r0
	bx r0
      
EyeAndEyeBeamAI:
;副精灵36主程序                                  
    push    r4-r6,r14                               
    add     sp,-4h                                  
    ldr     r1,=CurrSprite
    ldrb    r0,[r1,1Eh]
    cmp     r0,0h
    bhi	    @@EyeBeamtranfer
    mov     r2,r1                                   
    add     r2,26h                                  
    mov     r0,1h                                   
    strb    r0,[r2]    ;待机值写入1                              
    mov     r3,r1                                   
    add     r3,32h                                  
    ldrb    r2,[r3]    ;读取碰撞属性                             
    mov     r4,2h                                    
    mov     r0,r4                                   
    and     r0,r2      ;2 and                             
    cmp     r0,0h                                   
    beq     @@NoHit                                
    mov     r0,0FDh                                 
    and     r0,r2                                   
    strb    r0,[r3]                                 
    ldrh    r1,[r1]                                 
    mov     r0,r4                                   
    and     r0,r1      ;检查是否在屏幕内                              
    cmp     r0,0h                                   
    beq     @@NoHit                                
    ldr     r0,=25Eh   ;眼睛被打的声音                              
    bl      PlaySound  

@@NoHit:                              
    ldr     r1,=CurrSprite                            
    mov     r0,r1                                   
    add     r0,23h                                  
    ldrb    r2,[r0]    ;主精灵序号                             
    ldrh    r0,[r1,14h];读取眼睛血量                             
    mov     r3,r1                                   
    cmp     r0,0h                                   
    beq     @@SpriteDeath                                
    ldr     r1,=SpriteData                            
    lsl     r0,r2,3h                                
    sub     r0,r0,r2                                
    lsl     r0,r0,3h                                
    add     r0,r0,r1                                
    mov     r1,r3                                   
    add     r1,20h                                  
    ldrb    r1,[r1]    ;读取眼睛调色板号                              
    add     r0,20h                                  
    strb    r1,[r0]    ;写入主精灵的调色板号

@@SpriteDeath:                                
    mov     r5,r3                                   
    add     r5,24h                                  
    ldrb    r4,[r5]    ;读取pose                               
    cmp     r4,62h                                  
    beq     @@Pose62                               
    cmp     r4,62h                                  
    bgt     @@OtherPoseB                                
    cmp     r4,0h                                   
    beq     @@PoseZero                                
    b       @@OtherPose                                
.pool

@@OtherPoseB:                              
    cmp     r4,67h                                  
    beq     @@Pose67                               
    b       @@OtherPose

@@PoseZero:                                
    ldr     r0,=3000088h                            
    ldrb    r1,[r0,0Ch]                             
    mov     r0,3h                                   
    and     r0,r1                                   
    mov     r1,r3                                   
    add     r1,21h                                  
    strb    r0,[r1]       ;写入图层优先级                           
    ldr     r1,=SpriteData                            
    lsl     r0,r2,3h                                
    sub     r0,r0,r2                                
    lsl     r0,r0,3h                                
    add     r0,r0,r1                                
    ldrb    r0,[r0,1Dh]   ;读取主精灵的ID                             
    cmp     r0,0ADh                                 
    bne     @@NoAD2
    mov     r0,64h 	
    b       @@Peer        ;AD为主精灵时,眼睛血量为64                               
.pool
    @@EyeBeamtranfer:
    b EyeBeamMain	
@@NoAD2:                              
    mov     r0,r3                                   
    add     r0,34h                                  
    mov     r1,1h                                   
    strb    r1,[r0]       ;击打变色值写入1                              
    sub     r0,14h                                  
    strb    r1,[r0]       ;调色板也写入1                          
    ldr     r2,=82B1BE4h                            
    ldrb    r1,[r3,1Dh]                             
    lsl     r0,r1,3h                                
    add     r0,r0,r1                                
    lsl     r0,r0,1h                                
    add     r0,r0,r2                                
    ldrh    r0,[r0] 

@@Peer:                                
    strh    r0,[r3,14h]   ;写入血量                         
    mov     r0,r3                                   
    add     r0,27h                                  
    mov     r2,0h                                   
    mov     r1,8h                                   
    strb    r1,[r0]       ;上视界写入8h                           
    add     r0,1h                                   
    strb    r1,[r0]       ;左右视界写入8h                          
    add     r0,1h                                   
    strb    r1,[r0]       ;下视界写入8h                          
    mov     r1,0h                                   
    ldr     r0,=0FFD8h                              
    strh    r0,[r3,0Ah]   ;上部分界写入neg 28                          
    mov     r0,28h                                  
    strh    r0,[r3,0Ch]   ;下部分界写入28                          
    ldr     r0,=0FFF0h                              
    strh    r0,[r3,0Eh]   ;左部分界写入neg 10h                          
    mov     r0,10h                                  
    strh    r0,[r3,10h]   ;右部分界写入10h                          
    ldr     r0,=82B2750h  ;写入OAM                          
    str     r0,[r3,18h]                             
    strb    r1,[r3,1Ch]                             
    strh    r2,[r3,16h]                             
    mov     r0,r3                                   
    add     r0,25h                                  
    strb    r1,[r0]       ;属性写入0h                               
    mov     r1,r3                                   
    add     r1,24h                                  
    mov     r0,9h                                   
    strb    r0,[r1]       ;pose写入9h                           
    b       @@end                                
.pool 

@@Pose62:                                                            
    ldr     r1,=SpriteData                            
    lsl     r0,r2,3h                                
    sub     r0,r0,r2                                
    lsl     r0,r0,3h                                
    add     r2,r0,r1                                
    mov     r0,r2                                   
    add     r0,24h                                  
    mov     r1,0h                                   
    strb    r4,[r0]       ;主精灵的pose写入62h                             
    mov     r4,r2                                   
    add     r4,26h                                  
    mov     r0,1h                                   
    strb    r0,[r4]       ;主精灵待机值写入1h                          
    strh    r1,[r2,14h]   ;主精灵血量写入0                          
    mov     r0,67h                                  
    strb    r0,[r5]       ;pose写入 67h                           
    ldrh    r1,[r3]                                 
    mov     r2,80h                                  
    lsl     r2,r2,8h                                
    mov     r0,r2                                   
    orr     r0,r1                                   
    strh    r0,[r3]       ;取向写入无敌                          
    mov     r1,r3                                   
    add     r1,2Ch                                  
    mov     r0,28h                                  
    strb    r0,[r1]       ;偏移2C写入28h
    b       @@end  

.pool 

@@Pose67:                             
    mov     r1,r3                                   
    add     r1,2Ch                                  
    ldrb    r0,[r1]       ;读取偏移2C的值                          
    sub     r0,1h         ;减1再写入                          
    strb    r0,[r1]                                 
    lsl     r0,r0,18h                               
    cmp     r0,0h                                   
    bne     @@end                                
    ldr     r0,=SpriteRNG                            
    ldrb    r2,[r0]       ;读取随机值                          
    mov     r1,r2                                   
    sub     r1,44h        ;减去44h                          
    ldrh    r0,[r3,2h]    ;读取坐标                          
    add     r1,r1,r0                                
    add     r2,10h                                  
    ldrh    r3,[r3,4h]                              
    add     r2,r2,r3                                
    mov     r0,22h                                  
    str     r0,[sp]                                 
    mov     r0,0h                                   
    mov     r3,1h                                   
    bl      DeathFireWorks      ;死亡烟花                              
    b       @@end                                 
.pool

@@OtherPose:                             
    ldr     r1,=SpriteData                            
    lsl     r0,r2,3h                                
    sub     r0,r0,r2                                
    lsl     r0,r0,3h                                
    add     r2,r0,r1                                
    mov     r0,r2                                   
    add     r0,24h                                  
    ldrb    r0,[r0]       ;读取主精灵的POSE                            
    cmp     r0,27h                                  
    bne     @@NoOpenEye                                
    ldrh    r1,[r3]                                 
    ldr     r0,=7FFFh                               
    and     r0,r1                                   
    strh    r0,[r3]       ;眼睛若是打开的则取向去掉8000无敌效果                            
    mov     r0,r3                                   
    add     r0,2Bh                                  
    ldrb    r1,[r0]       ;读取击晕时间                            
    mov     r0,7Fh                                  
    and     r0,r1                                   
    cmp     r0,10h        ;比较是否是10h                          
    bne     @@end                                
    mov     r1,r2                                   
    add     r1,2Ch                                  
    mov     r0,0h                                   
    strb    r0,[r1]       ;主精灵的2C偏移值写为0,立即闭眼> 
    mov     r0,1h
    strb    r0,[r1,1h]    ;主精灵的2D偏移值写入1,为击打过的标记
    ldrb    r0,[r2,1Dh]
    cmp     r0,0AEh
    beq     @@end
    mov     r0,64h
    strh    r0,[r3,14h]	  ;ID是AD的话,血量重新回满
    b       @@end                                
.pool

@@NoOpenEye:                              
    ldrh    r1,[r3]                                 
    mov     r2,80h                                  
    lsl     r2,r2,8h      ;眼睛的取向orr8000 无敌                              
    mov     r0,r2                                   
    orr     r0,r1                                   
    strh    r0,[r3]

@@end:                                 
    add     sp,4h                                   
    pop     r4-r6                                   
    pop     r0                                      
    bx      r0 


;副灵37 光束的主程序                                     
EyeBeamMain:                              
    mov     r0,r1                          
    mov     r6,r0                                   
    add     r6,24h                                  
    ldrb    r4,[r6]      ;读取pose                           
    mov     r5,r0                                   
    cmp     r4,0h                                   
    beq     @@PoseZero2                                
    cmp     r4,9h                                   
    beq     @@PoseNine2                                
    b       @@end2                                
.pool 

@@PoseZero2:                              
    ldrh    r1,[r5]                                 
    ldr     r0,=0FFFBh                              
    and     r0,r1        ;取向and FB 去掉4                            
    mov     r3,0h                                   
    strh    r0,[r5]      ;再写入                             
    mov     r2,r5                                   
    add     r2,32h                                  
    ldrb    r1,[r2]      ;读取碰撞属性                           
    mov     r0,40h                                   
    orr     r0,r1        ;orr 4 无敌?                           
    strb    r0,[r2]      ;再写入                           
    mov     r0,r5                                   
    add     r0,27h                                  
    mov     r2,10h                                  
    strb    r2,[r0]      ;上视界写入10h                           
    add     r0,1h                                   
    strb    r2,[r0]      ;左右视界写入10h                           
    add     r0,1h                                   
    strb    r2,[r0]      ;下视界写入10h                           
    ldr     r0,=0FFD0h                              
    strh    r0,[r5,0Ah]  ;上部分界写入neg 30h                            
    mov     r0,30h                                  
    strh    r0,[r5,0Ch]  ;下部分界写入30h                           
    ldr     r0,=83187BCh ;写入OAM                           
    str     r0,[r5,18h]                             
    strb    r3,[r5,1Ch]                             
    strh    r4,[r5,16h]                             
    mov     r0,9h                                   
    strb    r0,[r6]      ;pose写入9h                             
    mov     r1,r5                                   
    add     r1,25h                                  
    mov     r0,4h                                   
    strb    r0,[r1]      ;属性写入4h                           
    sub     r1,3h                                   
    mov     r0,3h                                   
    strb    r0,[r1]      ;绘图顺序写入3h                           
    ldr     r1,=3000088h                            
    ldrb    r1,[r1,0Ch]                             
    and     r0,r1                                   
    mov     r1,r5                                   
    add     r1,21h                                  
    strb    r0,[r1]      ;写入图层优先级 最优先?                           
    mov     r0,1h                                   
    strh    r0,[r5,14h]  ;血量写入1                           
    mov     r0,r5                                   
    add     r0,2Ch                                  
    strb    r2,[r0]      ;偏移2C写入10h                           
    ldr     r0,=0FFFCh                              
    strh    r0,[r5,0Eh]  ;左部分界写入neg 4h                           
    mov     r0,18h                                  
    strh    r0,[r5,10h]  ;右部分界写入18h

@@PoseNine2:                            
    mov     r4,r5                                   
    mov     r1,r4                                   
    add     r1,2Ch                                  
    ldrb    r0,[r1]      ;读取偏移2C的值                              
    mov     r6,r0                                   
    cmp     r6,0h                                   
    beq     @@NumZero                                
    sub     r0,1h                                   
    strb    r0,[r1]      ;减1再写入                              
    lsl     r0,r0,18h                               
    cmp     r0,0h                                   
    bne     @@end2                                
    mov     r0,97h                                  
    lsl     r0,r0,2h     ;发射的声音                           
    bl      PlaySound                                
    b       @@end2                               
.pool

@@NumZero:                              
    ldrh    r0,[r4,4h]                              
    add     r0,0Ch                                  
    strh    r0,[r4,4h]   ;X坐标加上0C再写入                             
    ldrh    r0,[r4,2h]                              
    ldrh    r1,[r4,4h]                              
    bl      CheckBlock    ;检查砖块                          
    ldr     r0,=YTagRAM                            
    ldrb    r0,[r0]      ;检查是否有砖                           
    cmp     r0,0h                                   
    beq     @@end2                                
    ldrh    r0,[r4,2h]                              
    add     r0,1Ch       ;y坐标向上1Ch                           
    ldrh    r1,[r4,4h]                              
    mov     r2,21h                                  
    bl      GfxEffect     ;特效                           
    ldrh    r1,[r4]                                 
    mov     r0,2h                                   
    and     r0,r1                                   
    cmp     r0,0h        ;检查是否在屏幕内                            
    beq     @@NoPlaySound2                                
    ldr     r0,=25Dh                                
    bl      PlaySound 

@@NoPlaySound2:                               
    strh    r6,[r5]

@@end2:     
    add     sp,4h                            
    pop     r4-r6                                   
    pop     r0                                      
    bx      r0
.pool                                      



.close