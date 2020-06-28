.gba
.open "zm.gba","Metroid.gba",0x8000000

.definelabel Difficulty,0x300002C
.definelabel CurrRoom,0x3000055
.definelabel LockDoor,0x300007B
.definelabel SpriteData,0x30001AC
.definelabel CurrSpriteData,0x3000738
.definelabel SpriteRNG,0x300083C
.definelabel ProjectileData,0x3000A2C
.definelabel Bit8Counter,0x3000C77
.definelabel SamusData,0x30013D4
.definelabel SamusEquipment,0x3001530

.definelabel PlaySound2,0x8002A18
.definelabel PlaySound,0x8002B20
.definelabel SpawnSecondarySprite,0x800E258
.definelabel CheckProjectileHitSprite,0x800E6F8
.definelabel CheckClip,0x800F688
.definelabel CheckBlock,0x800F720
.definelabel NormalThaw,0x801004C
.definelabel FastThaw,0x80100A4
.definelabel DeathRoutine,0x8011084
.definelabel EventFunctions,0x80608BC
.definelabel PrimarySpriteStats,0x82B0D68
.definelabel YOffsetTable,0x82ECB60
.definelabel XOffsetTable,0x82ECBE2

.org 0x8035360
CheckPathAI:
	push    r4-r7,r14				;AI that checks if a block is in the way while latched on Samus                                    
	lsl     r0,r0,10h                      
	lsr     r4,r0,10h                      
	mov     r6,r4                          
	lsl     r1,r1,10h                      
	lsr     r1,r1,10h                      
	mov     r7,0h                          
	ldr     r0,=3001588h                   
	add     r0,4Eh					;30015D6, direction Samus is moving?                        
	ldrb    r0,[r0]                        
	cmp     r0,2h						;2 = moving right                          
	bne     @@CheckIfLeft                       
	mov     r0,r4 					;Y pos                         
	sub     r0,30h                         
	mov     r5,r1						;X pos                          
	add     r5,3Ch                         
	mov     r1,r5                          
	bl      CheckClip					;checking top right of metroid                       
	ldr     r6,=30007F1h                   
	ldrb    r0,[r6]                        
	cmp     r0,0h						;0 = air                          
	bne     @@HitWall                       
	mov     r0,r4                          
	add     r0,10h                         
	mov     r1,r5                          
	bl      CheckClip					;checking bottom right of metroid                        
	ldrb    r0,[r6]                        
	b       @@CheckIfAir                       
.pool
@@CheckIfLeft:
	cmp     r0,1h						;1 = moving left                          
	bne     @@Return                       
	mov     r0,r4                          
	sub     r0,30h 					;Y pos                        
	mov     r4,r1                          
	sub     r4,3Ch 					;X pos                        
	mov     r1,r4                          
	bl      CheckClip					;check top left                       
	ldr     r5,=30007F1h                   
	ldrb    r0,[r5]                        
	cmp     r0,0h						;0 = air                          
	bne     @@HitWall                       
	mov     r0,r6                          
	add     r0,10h                         
	mov     r1,r4                          
	bl      CheckClip					;check bottom left                       
	ldrb    r0,[r5]
@@CheckIfAir:
	cmp     r0,0h                          
	beq     @@Return
@@HitWall:
	mov     r7,1h						;return value, wall is in way
@@Return:
	mov     r0,r7                          
	pop     r4-r7                          
	pop     r1                             
	bx      r1                             
.pool 

MoveAI:  
	push    r4-r7,r14 					;Metroid移动时候的调用例程                                
	mov     r7,r10                                       
	mov     r6,r9                                        
	mov     r5,r8                                        
	push    r5-r7                                        
	add     sp,-14h                                      
	ldr     r4,[sp,34h]                                  
	lsl     r0,r0,10h                                    
	lsr     r0,r0,10h                                    
	str     r0,[sp]						;萨姆斯的头顶坐标                                       
	lsl     r1,r1,10h                                    
	lsr     r1,r1,10h                                    
	str     r1,[sp,4h]					;samus X坐标                                   
	lsl     r2,r2,18h                                    
	lsr     r2,r2,18h                                    
	str     r2,[sp,8h]					; = 1Eh                                   
	lsl     r3,r3,18h                                    
	lsr     r3,r3,18h                                    
	str     r3,[sp,0Ch]					; = 28h                                  
	lsl     r4,r4,18h                                    
	lsr     r4,r4,18h                                    
	mov     r9,r4                                        
	mov     r0,0h                                        
	str     r0,[sp,10h]					;碰到墙壁的flag                                 
	mov     r10,r0                                       
	ldr     r0,=CurrSpriteData                                
	ldrh    r6,[r0,2h]					;精灵 Y                                   
	ldrh    r7,[r0,4h] 					;精灵 X                                  
	ldrh    r1,[r0]                                      
	mov     r0,80h                                       
	lsl     r0,r0,2h 						;检查取向是否有200h                                  
	and     r0,r1                                        
	cmp     r0,0h                                        
	beq     @@CheckLeft                     
;------------------------------------------有200则检查右边	
	mov     r4,r6                                        
	sub     r4,30h                         ;精灵Y坐标向上30h              
	mov     r5,r7                                        
	add     r5,3Ch                         ;精灵X坐标向右3Ch	
	mov     r0,r4                                      
	mov     r1,r5 						                                         
	bl      CheckClip                      ;检查右上角是否碰触到砖块               
	ldr     r1,=30007F1h                                 
	mov     r8,r1                                        
	ldrb    r0,[r1]                                      
	cmp     r0,0h                                        
	bne     @@StoreHit                     ;若有砖块则撞击了砖块                
	mov     r0,r6                          ;Y坐标向下10h              
	add     r0,10h                                    
	mov     r1,r5    					   ;X坐标向右3Ch                                     
	bl      CheckClip                      ;检查右下是否碰触到砖块              
	mov     r1,r8                                        
	ldrb    r0,[r1]                                      
	cmp     r0,0h                                        
	beq     @@CheckDown                    ;如果没有碰到则跳转去检查底部                 
@@StoreHit:
	mov     r3,1h                                        
	str     r3,[sp,10h]					   ;碰撞砖块flag写入1                                  
	b       @@CheckDown                                     
.pool
@@CheckLeft:                                  
	mov     r4,r6                                        
	sub     r4,30h                  ;Y坐标向上30h                     
	mov     r5,r7                                        
	sub     r5,3Ch                  ;X坐标向左3Ch                     
	mov     r0,r4 					                                       
	mov     r1,r5                                        
	bl      CheckClip               ;检查左上是否碰触到砖块                      
	ldr     r0,=30007F1h                                 
	mov     r8,r0                                        
	ldrb    r0,[r0]                                      
	cmp     r0,0h                                        
	beq     @@LowerLeft                                    
	mov     r1,1h                                        
	str     r1,[sp,10h]             ;若碰触砖块则碰砖Flag写入1                       
	b       @@CheckDown                                     
.pool
@@LowerLeft:                                  
	mov     r0,r6                                        
	add     r0,10h              ;Y坐标向下10h                         
	mov     r1,r5  				;X坐标向左3Ch	
	bl      CheckClip           ;检查左下是否碰触砖块                          
	mov     r3,r8                                        
	ldrb    r0,[r3]                                      
	cmp     r0,0h                                        
	beq     @@CheckDown                                     
	mov     r0,1h                                        
	str     r0,[sp,10h]			;碰触则碰砖flag写入1
@@CheckDown:                                  
	ldr     r0,=CurrSpriteData                                 
	ldrh    r1,[r0]                                      
	mov     r0,80h				;检查取向是否有400h	
	lsl     r0,r0,3h                                     
	and     r0,r1                                        
	cmp     r0,0h                                        
	beq     @@LeftCheck         ;取向没有400                           
	mov     r4,r6                                        
	add     r4,18h 				;Y坐标向下18h                                       
@@LeftCheck:
	mov     r1,r7               ;X坐标向左20h                         
	sub     r1,20h				                                      
	mov     r0,r4                                        
	bl      CheckClip           ;检查上左或下左                           
	ldr     r5,=30007F1h                                 
	ldrb    r0,[r5]                                      
	cmp     r0,0h                                        
	bne     @@HittingWall                                     
	mov     r1,r7                                        
	add     r1,20h                                       
	mov     r0,r4					;;检查上右或下右                                       
	bl      CheckClip                                     
	ldrb    r0,[r5]                                      
	cmp     r0,0h                                        
	beq     @@CheckStatus                                     
@@HittingWall:
	mov     r0,r10                                       
	add     r0,1h                                        
	lsl     r0,r0,18h                                    
	lsr     r0,r0,18h                                    
	mov     r10,r0					;r10 = 碰撞到天花板或地板的的Flag
@@CheckStatus:
	mov     r5,0h                                        
	ldr     r2,=CurrSpriteData                                 
	ldrh    r1,[r2]                                      
	mov     r0,80h                                       
	lsl     r0,r0,2h 				;检查取向是否有200h                                   
	and     r0,r1                                        
	cmp     r0,0h                                        
	beq     @@MovingLeft            ;没有则向左移动
;-----------------------------------否则向右移动	
	ldr     r1,[sp,10h] 			;碰撞墙壁的flag                                  
	cmp     r1,0h 					                                       
	bne     @@Hitting               ;不为0则是碰撞了墙壁 
;-----------------------------------没有碰撞右边的墙壁	
	mov     r4,r2                                        
	add     r4,2Dh 					                                      
	ldrb    r3,[r4]                 ;读取水平速度                     
	cmp     r3,0h 					;为0则不减速                                      
	bne     @@CheckDeccelRight      ;否则减速
;-----------------------------------不右减速	
	ldrh    r1,[r2,4h]				;精灵 X                                   
	ldr     r0,[sp,4h]				;萨姆斯 X                                   
	sub     r0,4h                   ;萨姆斯X坐标向左4h                     
	cmp     r1,r0					;精灵X坐标与其比较                                       
	bgt     @@Branch1               ;精灵在右边
;----------------------------------- 精灵在左边	
	mov     r1,r2                                        
	add     r1,2Eh 					;水平加速值                                     
	ldrb    r0,[r1]                                      
	ldr     r3,[sp,0Ch]				;28h                                  
	cmp     r0,r3 					;不能超过28否则跳过储备                                      
	bcs     @@SkipStore                                    
	add     r0,1h                                        
	strb    r0,[r1]                 ;未超过则加1再写入
@@SkipStore:
	ldrb    r0,[r1]                                      
	b       @@MoveRight                                     
.pool
@@CheckDeccelRight:
	ldr     r0,=Bit8Counter                                 
	ldrb    r1,[r0]                                      
	mov     r0,1h                                        
	and     r0,r1 				;二分之一的可能减速                                    
	cmp     r0,0h                                  
	bne     @@NoDeccel                                    
	sub     r0,r3,1             ;水平加速值减1                        
	strb    r0,[r4]             ;写入水平速度
@@NoDeccel:                                     
	ldrb    r0,[r4]                                      
	cmp     r0,0h			    ;读取水平速度如果为0                                        
	beq     @@DoneDeccel        ;则完成减速
@@MoveRight:                                     
	mov     r1,r9                                        
	asr     r0,r1                                        
	ldrh    r3,[r2,4h]                                   
	add     r0,r0,r3				;X的坐标向右                                  
	strh    r0,[r2,4h]				;再写入                                  
	b       @@CheckSwitch                                     
.pool
@@Hitting:
	mov     r5,2h					;标记是撞了右墙                                        
	b       @@SwitchDirection       ;变换方向
@@MovingLeft:
	ldr     r0,[sp,10h]                                  
	cmp     r0,0h					;读取撞墙flag是否为1                                        
	bne     @@WallHit                                     
	mov     r4,r2                                        
	add     r4,2Dh                                       
	ldrb    r3,[r4] 				;水平                                      
	cmp     r3,0h					;if 0, not rubber banding                                        
	bne     @@CheckDeccelLeft                                    
	ldrh    r1,[r2,4h]				;sprite X                                   
	ldr     r0,[sp,4h]				;Samus X                                   
	add     r0,4h                                        
	cmp     r1,r0					;checking if metroid passed samus                                        
	bge     @@Check2E
@@Branch1:
	mov     r0,r2                                        
	add     r0,2Eh					;水平加速                                       
	ldrb    r0,[r0]                                      
	strb    r0,[r4]					;写入减速                                     
	b       @@CheckSwitch
@@Check2E:
	mov     r1,r2                                        
	add     r1,2Eh 					;horizontal accel                                      
	ldrb    r0,[r1]                                      
	ldr     r3,[sp,0Ch]				;28h                                  
	cmp     r0,r3 					;making sure accel doesnt surpass 28h                                       
	bcs     @@SkipStore2                                     
	add     r0,1h                                        
	strb    r0,[r1]  
@@SkipStore2:                                    
	ldrb    r1,[r1]                                      
	mov     r0,r9                                        
	asr     r1,r0                                        
	b       @@MoveLeft
@@CheckDeccelLeft:                                    
	ldr     r0,=Bit8Counter                                 
	ldrb    r1,[r0]                                      
	mov     r0,1h                                        
	and     r0,r1       			;checks if flag 1 is set, 50/50 chance                                                
	cmp     r0,0h                 ;so a 50/50 chance to decrease deccel                                
	bne     @@NoDeccel2                                     
	sub     r0,r3,1                                      
	strb    r0,[r4]
@@NoDeccel2:
	ldrb    r0,[r4]                                      
	cmp     r0,0h					;if 0, no longer rubber banding                                       
	beq     @@DoneDeccel                                    
	mov     r1,r0                                        
	mov     r3,r9                                        
	asr     r1,r3
@@MoveLeft:
	ldrh    r0,[r2,4h]                                   
	sub     r0,r0,r1 				;moves left based on accel/deccel                                    
	strh    r0,[r2,4h]			;sprite x                                   
	b       @@CheckSwitch                                    
.pool
@@DoneDeccel:
	mov     r5,1h						;value for "done bouncing"                                        
	b       @@SwitchDirection
@@WallHit:
	mov     r5,2h						;value for hitting wall
@@CheckSwitch:
	cmp     r5,0h 					;if 0 not switching direction                                        
	beq     @@CheckVertical
@@SwitchDirection:
	ldrh    r0,[r2]                                      
	mov     r3,80h                                       
	lsl     r3,r3,2h 				;switching horizontal direction                                     
	mov     r1,r3                                        
	eor     r0,r1                                        
	strh    r0,[r2]					;new status                                      
	cmp     r5,2h 					;check if hitting wall                                       
	bne     @@Store2E                                     
	mov     r1,r2 					;if not, "rubber band" is over, reset deccel                                       
	add     r1,2Dh                                       
	mov     r0,0h                                        
	strb    r0,[r1]                                      
	add     r1,1h                                        
	mov     r0,10h                                       
	b       @@Store2
@@Store2E:
	mov     r1,r2                                        
	add     r1,2Eh                                       
	mov     r0,1h 
@@Store2:                                       
	strb    r0,[r1] 
@@CheckVertical:
	mov     r5,0h                                        
	ldrh    r1,[r2]                                      
	mov     r0,80h                                       
	lsl     r0,r0,3h				;400h, moving down?                                     
	and     r0,r1                                        
	cmp     r0,0h                                        
	beq     @@MovingUp                                     
	mov     r0,r10					;flag for hitting floor or ceiling                                        
	cmp     r0,0h                                        
	bne     @@HitWall                                     
	mov     r4,r2                                        
	add     r4,2Ch					;vertical deccel timer                                       
	ldrb    r3,[r4]                                      
	cmp     r3,0h                                        
	bne     @@CheckDeccelDown                                     
	ldrh    r1,[r2,2h]				;sprite Y pos                                   
	ldr     r0,[sp]					;Samus' head pos                                      
	sub     r0,4h                                        
	cmp     r1,r0					;checking if metroid is below Samus                                        
	bgt     @@Branch2                                     
	mov     r1,r2                                        
	add     r1,2Fh					;vertical accel                                       
	ldrb    r0,[r1]                                      
	ldr     r3,[sp,8h] 				;1Eh                                  
	cmp     r0,r3					;1E = max value for accel                                        
	bcs     @@SkipStore3                                     
	add     r0,1h                                        
	strb    r0,[r1]
@@SkipStore3:                                      
	ldrb    r0,[r1]                                      
	b       @@DeccelDown                                     
@@CheckDeccelDown:
	ldr     r0,=Bit8Counter                                 
	ldrb    r1,[r0]                                      
	mov     r0,1h                                        
	and     r0,r1 					;checking itf flag 1 is set                                       
	cmp     r0,0h 					;50/50 chance to deccel                                       
	beq     @@NoDeccel3                                     
	sub     r0,r3,1					;decrement vertical deccel                                       
	strb    r0,[r4]
@@NoDeccel3:
	ldrb    r0,[r4]                                      
	cmp     r0,0h                                        
	beq     @@DeccelDone
@@DeccelDown:
	mov     r1,r9                                        
	asr     r0,r1                                        
	ldrh    r3,[r2,2h]                                   
	add     r0,r0,r3				;moves sprite down based on deccel                                     
	strh    r0,[r2,2h]				;sprite Y                                   
	b       @@HitCheck                                    
.pool                                    
@@HitWall:
	mov     r5,2h                                        
	b       @@SwitchDirection2
@@MovingUp:
	mov     r0,r10					;hit floor or ceiling flag                                       
	cmp     r0,0h                                        
	bne     @@HitWall2                                    
	mov     r4,r2                                        
	add     r4,2Ch					;verticle deccel timer                                       
	ldrb    r3,[r4]                                      
	cmp     r3,0h						;if 0, done "bouncing"                                        
	bne     @@CheckDeccelUp                                     
	ldrh    r1,[r2,2h]				;sprite Y                                   
	ldr     r0,[sp]					;Samus head pos                                      
	add     r0,4h                                        
	cmp     r1,r0                     ;checkinf if metroid is under Samus                   
	bge     @@Check2F
@@Branch2:
	mov     r0,r2                                        
	add     r0,2Fh                                       
	ldrb    r0,[r0]					;vertical accel stored to deccel                                      
	strb    r0,[r4]					;starts rubber banding                                       
	b       @@HitCheck
@@Check2F:
	mov     r1,r2                                        
	add     r1,2Fh					;vertical accel                                       
	ldrb    r0,[r1]                                      
	ldr     r3,[sp,8h] 				;1Eh                                  
	cmp     r0,r3					;                                        
	bcs     @@SkipStore4                                     
	add     r0,1h                                        
	strb    r0,[r1]
@@SkipStore4:
	ldrb    r1,[r1]                                      
	mov     r0,r9                                        
	asr     r1,r0                                        
	b       @@DeccelUp
@@CheckDeccelUp:
	ldr     r0,=Bit8Counter                                 
	ldrb    r1,[r0]                                      
	mov     r0,1h                                        
	and     r0,r1						;check is flag 1h is set                                        
	cmp     r0,0h						;50/50 chance to decrement deccel timer                                        
	beq     @@NoDeccel4                                     
	sub     r0,r3,1					;decrement vertical deccel timer                                      
	strb    r0,[r4]
@@NoDeccel4:
	ldrb    r0,[r4]                                      
	cmp     r0,0h                                        
	beq     @@DeccelDone                                     
	mov     r1,r0                                        
	mov     r3,r9                                        
	asr     r1,r3
@@DeccelUp:
	ldrh    r0,[r2,2h]                                   
	sub     r0,r0,r1					;moves up based on deccel                                     
	strh    r0,[r2,2h]				;sprite Y                                   
	b       @@HitCheck                                     
.pool
@@DeccelDone:
	mov     r5,1h                                        
	b       @@SwitchDirection2
@@HitWall2:
	mov     r5,2h
@@HitCheck:
	cmp     r5,0h 					;if not hitting wall, or finishing deccel, return                                       
	beq     @@Return
@@SwitchDirection2:
	ldrh    r0,[r2]                                      
	mov     r3,80h                                       
	lsl     r3,r3,3h					;400h                                     
	mov     r1,r3						;switching vertical direction                                        
	eor     r0,r1                                        
	strh    r0,[r2]                                      
	cmp     r5,2h						;if 1, done "bouncing", reset deccel                                        
	bne     @@Store2F                                     
	mov     r1,r2                                        
	add     r1,2Ch                                       
	mov     r0,0h                                        
	strb    r0,[r1]					;resetting vertical deccel                                      
	add     r1,3h                                        
	mov     r0,10h                                       
	b       @@Store3
@@Store2F:
	mov     r1,r2                                        
	add     r1,2Fh                                       
	mov     r0,1h 
@@Store3:
	strb    r0,[r1]
@@Return:
	add     sp,14h                                       
	pop     r3-r5                                        
	mov     r8,r3                                        
	mov     r9,r4                                        
	mov     r10,r5                                       
	pop     r4-r7                                        
	pop     r0                                           
	bx      r0 

CheckUnlatchAI:   
	push    r4-r7,r14				;AI that checks if a bomb has exploded on th metroid, forcing an unlatch                                    
	mov     r7,r10                                       
	mov     r6,r9                                        
	mov     r5,r8                                        
	push    r5-r7                                        
	add     sp,-14h                                      
	ldr     r2,=CurrSpriteData                                 
	ldrh    r1,[r2,2h]				;sprite Y                                   
	ldrh    r3,[r2,4h]				;Sprite X                                   
	ldrh    r0,[r2,0Ah] 				;sprite top hitbox                                 
	add     r0,r1,r0                  ;topmost position                  
	lsl     r0,r0,10h                                    
	lsr     r0,r0,10h                                    
	str     r0,[sp,10h]                                  
	ldrh    r0,[r2,0Ch]				;bottom hitbox                                  
	add     r1,r1,r0					;bottommost positio                                     
	lsl     r1,r1,10h                                    
	lsr     r1,r1,10h                                    
	mov     r10,r1                                       
	ldrh    r0,[r2,0Eh]				;left hitbox                                  
	add     r0,r3,r0                  ;leftmost position                  
	lsl     r0,r0,10h                                    
	lsr     r0,r0,10h                                    
	mov     r9,r0                                        
	ldrh    r0,[r2,10h] 				;right hitbox                                 
	add     r3,r3,r0                  ;rightmost position                   
	lsl     r3,r3,10h                                    
	lsr     r3,r3,10h                                    
	mov     r8,r3                                        
	mov     r7,11h                                       
	mov     r6,0h						;r6 = projecile slot 
@@Loop:
	lsl     r0,r6,3h					;math to get next projectile slot                                     
	sub     r0,r0,r6                                     
	lsl     r0,r0,2h                                     
	ldr     r1,=ProjectileData                                 
	add     r5,r0,r1                                     
	ldrb    r0,[r5,0Fh]				;projectile type                                  
	cmp     r0,0Eh					;checking if bomb                                       
	bne     @@Inc                                     
	ldrb    r0,[r5]                                      
	and     r0,r7						;r7 = 11h                                        
	cmp     r0,r7						;checking if bomb is alive and active                                        
	bne     @@Inc                                     
	ldrh    r3,[r5,8h]				;bomb Y                                   
	ldrh    r4,[r5,0Ah]				;Bomb X                                  
	ldrh    r2,[r5,14h]				;bomb top hitbox                                  
	add     r2,r3,r2 					;bomb explosion topmost position                                    
	lsl     r2,r2,10h                                    
	lsr     r2,r2,10h                                    
	ldrh    r0,[r5,16h] 				;bomb bottom hitbox                                 
	add     r3,r3,r0 					;bomb explosion bottommost position                                   
	lsl     r3,r3,10h                                    
	lsr     r3,r3,10h                                    
	ldrh    r1,[r5,18h]				;bomb left hitbox                                  
	add     r1,r4,r1					;bomb explosion leftmost position                                      
	lsl     r1,r1,10h                                    
	lsr     r1,r1,10h                                    
	ldrh    r0,[r5,1Ah]				;bomb right hitbox                                  
	add     r4,r4,r0 					;bomb explosion rightmost position                                    
	lsl     r4,r4,10h                                    
	lsr     r4,r4,10h                                    
	str     r2,[sp]                                      
	str     r3,[sp,4h]                                   
	str     r1,[sp,8h]                                   
	str     r4,[sp,0Ch]                                  
	ldr     r0,[sp,10h]                                  
	mov     r1,r10                                       
	mov     r2,r9                                        
	mov     r3,r8                                        
	bl      CheckProjectileHitSprite                                     
	cmp     r0,0h						;0 if bomb did not hit metroid                                        
	beq     @@Inc                                     
	mov     r0,1h						;return value, metroid was bombed                                        
	b       @@Return                                     
.pool
@@Inc:
	add     r0,r6,1					;increments slot number                                      
	lsl     r0,r0,18h                                    
	lsr     r6,r0,18h                                    
	cmp     r6,0Fh					;checks if all 16 slots were checked                                       
	bls     @@Loop                                     
	mov     r0,0h 					;return value, metroid not bombed                                       
@@Return:
	add     sp,14h                                       
	pop     r3-r5                                        
	mov     r8,r3                                        
	mov     r9,r4                                        
	mov     r10,r5                                       
	pop     r4-r7                                        
	pop     r1                                           
	bx      r1  

MetroidPushAI:
	push    r4-r7,r14 					;AI that allows metroids to "bounce" off each other                                   
	mov     r7,r10                                       
	mov     r6,r9                                        
	mov     r5,r8                                        
	push    r5-r7                                        
	add     sp,-4h                                       
	lsl     r0,r0,10h                                    
	lsr     r0,r0,10h                                    
	mov     r8,r0                                        
	ldr     r1,=CurrSpriteData                                 
	ldrh    r0,[r1,2h] 				;sprite Y                                  
	sub     r0,10h                                       
	lsl     r0,r0,10h                                    
	lsr     r3,r0,10h                                    
	ldrh    r0,[r1,4h]				;sprite X                                   
	str     r0,[sp]                                      
	mov     r7,20h                                       
	mov     r2,9h                                        
	mov     r12,r2                                       
	mov     r0,r1                                        
	add     r0,24h					;checking sprite pose                                       
	ldrb    r0,[r0]                                      
	cmp     r0,9h                                        
	bne     @@Branch                                     
	mov     r0,r1                                        
	add     r0,30h                                       
	ldrb    r0,[r0]					;checking frozen timer                                      
	cmp     r0,0h                                        
	bne     @@Branch                                     
	mov     r0,r1                                        
	add     r0,23h					;RAM slot                                       
	ldrb    r0,[r0]					;adds 1 to check all slots after it                                      
	add     r0,1h					                                        
	lsl     r0,r0,18h                                    
	lsr     r5,r0,18h                                    
	b       @@CheckSlotNumber                                     
.pool
@@Branch:
	mov     r5,0h
@@CheckSlotNumber:
	cmp     r5,17h					;making sure not over sprite slot limit                                       
	bls     80357F8h                                     
	b       @@Return                                     
	mov     r0,r8                                        
	lsl     r0,r0,4h                                     
	mov     r9,r0
@@Loop:												;loop checks for other metroids in room
	lsl     r0,r5,3h					;r5 = slot number                                     
	sub     r1,r0,r5					;math to get sprite data slot                                     
	lsl     r1,r1,3h                                     
	ldr     r2,=SpriteData                                 
	add     r4,r1,r2                                     
	ldrh    r1,[r4] 					;Status                                     
	mov     r2,1h	                                        
	and     r1,r2                                        
	mov     r10,r0                                       
	cmp     r1,0h						;checks if alive                                        
	bne     @@CheckCollision                                     
	b       @@Inc
@@CheckCollision:
	mov     r0,r4                                        
	add     r0,25h					;Samus collision                                       
	ldrb    r0,[r0]                                      
	cmp     r0,18h					;18 = metroid                                        
	beq     @@CheckIfFrozen                                     
	b       @@Inc
@@CheckIfFrozen:
	mov     r0,r4                                        
	add     r0,30h					;freeze timer                                       
	ldrb    r0,[r0]                                      
	cmp     r0,0h                                        
	beq     @@PoseCheck                                     
	b       @@Inc
@@PoseCheck:
	mov     r0,r4                                        
	add     r0,24h                                       
	ldrb    r0,[r0] 					;check pose                                     
	cmp     r0,r12					;check if pose = 9                                       
	beq     @@CheckProximity			;if all true, metroid, check if they are close together                                     
	b       @@Inc
@@CheckProximity:
	ldrh    r0,[r4,2h]				;sprite Y                                   
	mov     r1,10h                                       
	sub     r0,r0,r1
	lsl     r0,r0,10h                                    
	lsr     r2,r0,10h                                    
	ldrh    r6,[r4,4h]				;Sprite X                                   
	add     r1,r3,r7					                                    
	sub     r0,r2,r7 					                                  
	cmp     r1,r0						;checking if metroid is within vertical range						                                      
	ble     @@Inc                                     
	sub     r1,r3,r7					                                   
	add     r0,r2,r7					                                    
	cmp     r1,r0						;checking if metroid is within vertical range                                        
	bge     @@Inc                                     
	ldr     r0,[sp]                                      
	add     r1,r0,r7                                     
	sub     r0,r6,r7                                     
	cmp     r1,r0						;checking if metroid is within horizontal range                                        
	ble     @@Inc                                     
	ldr     r0,[sp]                                      
	sub     r1,r0,r7                                     
	add     r0,r6,r7                                     
	cmp     r1,r0						;checking if metroid is within horizontal range                                        
	bge     @@Inc                                     
	cmp     r3,r2						;checking if current metroid is above or below the other metroid                                     
	bls     @@Above                                     
	ldrh    r0,[r4,2h] 				;other Metroid's Y                                  
	sub     r0,r0,r7                                     
	mov     r1,r6						;check block above metroid                                        
	bl      CheckBlock                                     
	cmp     r0,0h						;if solid, skip Y change                                        
	bne     @@SideCheck                                     
	ldrh    r0,[r4,2h]                                   
	mov     r1,r8                                        
	sub     r0,r0,r1					;push other metroid upwards based on r8                                     
	strh    r0,[r4,2h]                                   
	ldrh    r0,[r4]                                      
	ldr     r2,=0FBFFh				;gets rid of 400h (moving down) in status                                   
	mov     r1,r2                                        
	and     r0,r1                                        
	b       @@NewStatus                                     
.pool 
@@Above:
	ldrh    r0,[r4,2h] 				;other metroid's Y                                  
	add     r0,r0,r7					;check block below metroid                                     
	mov     r1,r6                                        
	bl      CheckBlock                                     
	cmp     r0,0h						;if solid, skip Y change                                         
	bne     @@SideCheck                                     
	ldrh    r0,[r4,2h]                                   
	add     r0,r8                                        
	strh    r0,[r4,2h]	            ;push other metroid downwards based on r8                      
	ldrh    r0,[r4]                                      
	mov     r2,80h                                       
	lsl     r2,r2,3h					;turns on 400h (moving down) in status                                     
	mov     r1,r2                                        
	orr     r0,r1
@@NewStatus:
	strh    r0,[r4]                                      
	mov     r0,r4                                        
	add     r0,2Ch                                       
	mov     r1,0h                                        
	strb    r1,[r0]					;sets vertical deccel to 0                                      
	add     r0,3h						;2Fh                                        
	mov     r2,r9                                        
	strb    r2,[r0]
@@SideCheck:
	ldr     r0,[sp]
	cmp     r0,r6						;check what side the metroid is on compared to other metroid                                        
	bls     @@Left                                     
	mov     r1,r10                                       
	sub     r0,r1,r5                                     
	lsl     r0,r0,3h                                     
	ldr     r2,=SpriteData                                 
	add     r4,r0,r2                                     
	ldrh    r0,[r4,2h]				;other metroid's Y                                   
	ldrh    r1,[r4,4h]                ;other metroid's X                     
	sub     r1,r1,r7                                     
	bl      CheckBlock                                     
	cmp     r0,0h						;if solid, skip X change
	bne     @@Return                                     
	ldrh    r0,[r4,4h]                                   
	mov     r1,r8                                        
	sub     r0,r0,r1					;push other metroid to the left based on r8                                     
	strh    r0,[r4,4h]                                   
	ldrh    r0,[r4]                                      
	ldr     r2,=0FDFFh				;gets rid of 200h (moving right) in status                                   
	mov     r1,r2                                        
	and     r0,r1                                        
	b       @@NewStatus2                                    
.pool
@@Left:
	mov     r1,r10                                       
	sub     r0,r1,r5                                     
	lsl     r0,r0,3h                                     
	ldr     r2,=SpriteData                                 
	add     r4,r0,r2                                     
	ldrh    r0,[r4,2h]				;other metroid's Y                                     
	ldrh    r1,[r4,4h]				;other metroid's x                                     
	add     r1,r1,r7                                     
	bl      CheckBlock                                     
	cmp     r0,0h                                        
	bne     @@Return                                     
	ldrh    r0,[r4,4h]                                   
	add     r0,r8						;pushes other metroid to the right based on r8                                        
	strh    r0,[r4,4h]                                   
	ldrh    r0,[r4]                                      
	mov     r2,80h                                       
	lsl     r2,r2,2h					;turns on 200h (moving right) flag in status                                     
	mov     r1,r2                                        
	orr     r0,r1 
@@NewStatus2:
	strh    r0,[r4]                                      
	mov     r0,r4                                        
	add     r0,2Dh					;reset horizontal deccel                                       
	mov     r1,0h                                        
	strb    r1,[r0]                                      
	add     r0,1h						;2Eh                                        
	mov     r2,r9                                        
	strb    r2,[r0]                                      
	b       @@Return                                     
.pool
@@Inc:
	add     r0,r5,1                                      
	lsl     r0,r0,18h                                    
	lsr     r5,r0,18h                                    
	cmp     r5,17h				;23h, checks all sprite slots                                       
	bhi     @@Return                                    
	b       @@Loop
@@Return:
	add     sp,4h                                        
	pop     r3-r5                                        
	mov     r8,r3                                        
	mov     r9,r4                                        
	mov     r10,r5                                       
	pop     r4-r7                                        
	pop     r0                                           
	bx      r0                                           

 
CheckLatchAI:
	push    r4,r14 					;AI that checks if metroid is free to latch onto Samus                                   
	mov     r3,0h                       
	ldr     r4,=SpriteData 
@@Loop:           
	lsl     r0,r3,3h				;math to get status of sprite                    
	sub     r0,r0,r3              ;r3 = slot to check     
	lsl     r0,r0,3h                    
	add     r2,r0,r4 				                  
	ldrh    r1,[r2]					;status of sprite                      
	mov     r0,1h                       
	and     r0,r1                       
	cmp     r0,0h					;check if dead                     
	beq     @@Inc                   
	mov     r0,r2                       
	add     r0,25h                      
	ldrb    r0,[r0] 				;checking if Samus collision value is metroid                     
	cmp     r0,18h                      
	bne     @@Inc                   
	mov     r0,r2                       
	add     r0,24h                      
	ldrb    r0,[r0]  				;check if pose = 9                   
	cmp     r0,9h                       
	beq     @@Inc                   
	mov     r0,1h 				;return value, a metroid is already on Samus                       
	b       @@Return                   
.pool 
@@Inc:
	add     r0,r3,1                     
	lsl     r0,r0,18h                   
	lsr     r3,r0,18h                   
	cmp     r3,17h				;23 (for all sprite slots)                      
	bls     @@Loop                    
	mov     r0,0h				;return value, no metroid on Samus  
@@Return:
	pop     r4                          
	pop     r1                          
	bx      r1                          
	lsl     r0,r0,0h 


CheckPlaySoundAI:     
	push    r14                         
	ldr     r1,=CurrSpriteData                
	ldrh    r0,[r1,16h] 				;animation                
	cmp     r0,0h                       
	bne     @@Return                    
	ldrb    r0,[r1,1Ch] 				;animation timer                
	cmp     r0,1h                       
	bne     @@Return                   
	ldrh    r1,[r1] 					;status                    
	mov     r0,2h                     ;checking if on screen 
	and     r0,r1                       
	cmp     r0,0h	                       
	beq     @@Return                    
	mov     r0,0B8h                     
	lsl     r0,r0,1h 					;170h                   
	bl      PlaySound 
@@Return:                   
	pop     r0                          
	bx      r0                          
.pool 
 
Initialize:
	push    r4-r6,r14                                    
	add     sp,-0Ch                        
	mov     r4,0h                          
	ldr     r0,=CurrRoom                  
	ldrb    r0,[r0]                        
	sub     r0,1h                          
	cmp     r0,12h                         
	bhi     @@Set2                      
	lsl     r0,r0,2h                       
	ldr     r1,=@@JumpTable                  
	add     r0,r0,r1                       
	ldr     r0,[r0]                        
	mov     r15,r0                         
.pool
@@JumpTable:  
	.word @@Event38,@@Event39,@@Set2,@@Set2                     
	.word @@Set2,@@Set2,@@Set2,@@Set2                     
	.word @@Set2,@@Set2,@@Set2,@@Set2  
	.word @@Set2,@@Event37,@@Event3A,@@Event3B                   
	.word @@Set2,@@Set2,@@Event3C
@@Event37:	
	mov     r0,3h                          
	mov     r1,37h                         
	b       @@CheckEvent  
@@Event38:                     
	mov     r0,3h                          
	mov     r1,38h                         
	b       @@CheckEvent  
@@Event39:                    
	mov     r0,3h                          
	mov     r1,39h                         
	b       @@CheckEvent
@@Event3A:   
	mov     r0,3h                          
	mov     r1,3Ah                         
	b       @@CheckEvent
@@Event3B:                       
	mov     r0,3h                          
	mov     r1,3Bh                         
	b       @@CheckEvent 
@@Event3C:   
	mov     r0,3h                          
	mov     r1,3Ch 
@@CheckEvent:
	bl      EventFunctions  			;checks events based on room number                   
	cmp     r0,0h                          
	bne     @@CheckFlag                      
	add     r0,r4,1                        
	lsl     r0,r0,18h                      
	lsr     r4,r0,18h                      
	b       @@CheckFlag  
@@Set2:                     
	mov     r4,2h         
@@CheckFlag:                 
	cmp     r4,0h					;true if events are aren't set   
	bne     @@CheckFlag2                       
	ldr     r0,=CurrSpriteData                  
	strh    r4,[r0]					;kills sprite if event is set                        
	b       @@Return                       
.pool
@@CheckFlag2:                   
	cmp     r4,1h                          
	bne     @@SpawnSprite                      
	ldr     r0,=LockDoor                   
	strb    r4,[r0]
@@SpawnSprite:
	ldr     r5,=CurrSpriteData                  
	ldrh    r1,[r5]					;status                        
	mov     r0,20h                         
	mov     r6,0h                          
	orr     r0,r1                   ;取向ORR20       
	mov     r2,80h                         
	lsl     r2,r2,8h                       
	mov     r1,r2                          
	orr     r0,r1                   ;取向orr8000       
	mov     r4,0h                          
	mov     r1,80h                  ;取向orr80       
	orr     r0,r1                          
	strh    r0,[r5]                 ;写入取向       
	mov     r0,40h                  ;74A写入40h       
	strh    r0,[r5,12h]				;OAM Scaling                    
	mov     r0,r5                          
	add     r0,2Ah                  ;762写入0       
	strb    r4,[r0]					;OAM Rotation                         
	sub     r0,3h                          
	mov     r1,6h                          
	strb    r1,[r0] 				;27h  视野判定上写入6h                     
	add     r0,1h                          
	strb    r1,[r0]					;28h  视野判定左右写入6h                      
	mov     r1,r5                          
	add     r1,29h                         
	mov     r0,5h                          
	strb    r0,[r1]                 ;视野判定下写入5h       
	ldr     r1,=0FFD8h              ;上部分界写入neg 28h       
	strh    r1,[r5,0Ah]				;top hitbox                    
	mov     r0,20h                  ;下部分界写入20h       
	strh    r0,[r5,0Ch] 			;bottom hitbox 左分界写入neg 28                   
	strh    r1,[r5,0Eh]				;left hitbox                    
	mov     r0,28h                  ;有分解写入28h       
	strh    r0,[r5,10h]				;right hitbox                    
	ldr     r0,=82EDD20h 			;OAM Pointer                  
	str     r0,[r5,18h]                    
	strb    r4,[r5,1Ch]                    
	strh    r6,[r5,16h]                    
	ldr     r2,=PrimarySpriteStats 	                  
	ldrb    r1,[r5,1Dh]				;sprite ID                    
	lsl     r0,r1,3h                       
	add     r0,r0,r1                       
	lsl     r0,r0,1h                       
	add     r0,r0,r2                       
	ldrh    r0,[r0]                 ;写入初始血量       
	strh    r0,[r5,14h]				;math to get sprite health                    
	strh    r0,[r5,6h]              ;同时备份在Y备份坐标       
	mov     r0,r5                          
	add     r0,25h                         
	strb    r4,[r0] 				;0 to Samus collision, making it not interact with her                       
	bl      800F8E0h                ;判断人物与精灵位置       
	mov     r1,r5                   ;右则取向加200h       
	add     r1,24h                         
	mov     r0,1h                          
	strb    r0,[r1] 				;pose = 1                       
	mov     r0,r5                          
	add     r0,2Eh                         
	strb    r4,[r0]                 ;766归0       
	add     r0,1h                          
	strb    r4,[r0]                 ;767归0       
	sub     r1,2h                          
	mov     r0,0Ch                         
	strb    r0,[r1]                 ;765写入0C 产卵次数?       
	ldrb    r1,[r5,1Eh]				;sprite number                    
	ldrb    r2,[r5,1Fh] 			;spriteset GFX slot                   
	mov     r0,r5                          
	add     r0,23h  				;RAM slot                         
	ldrb    r3,[r0]                          
	ldrh    r0,[r5,2h]				;sprite Y                       
	str     r0,[sp]                          
	ldrh    r0,[r5,4h]                       
	str     r0,[sp,4h]                       
	str     r6,[sp,8h]                       
	mov     r0,1Ah					;metroid shell                           
	bl      SpawnSecondarySprite    ;生产绿色壳                     
	lsl     r0,r0,18h                        
	lsr     r0,r0,18h                        
	cmp     r0,0FFh                          
	bne     @@Palette                         
	strh    r6,[r5] 				;kills sprite if shell could not spawn
@@Palette:	
	mov     r1,r5                            
	add     r1,20h					;palette                           
	mov     r0,3h                            
	strb    r0,[r1]                 ;调色板号写入3h         
@@Return:
	add     sp,0Ch 
	pop     r4-r6  
	pop     r0     
	bx      r0     	
.pool

IdleAI:
	push    r14               
	ldr     r2,=CurrSpriteData
	ldrh    r1,[r2]           
	mov     r0,2h             
	and     r0,r1             
	cmp     r0,0h  					;check if on screen           
	beq     @@Return                ;不在屏幕内则结束
	mov     r1,r2             
	add     r1,24h            
	mov     r0,2h             
	strb    r0,[r1]					;pose = 2           
	mov     r0,r2             
	add     r0,27h            
	mov     r1,18h            
	strb    r1,[r0]                 ;视野上写入18h
	add     r0,1h             
	strb    r1,[r0]					;28h  左右视野各写入18h         
	mov     r1,r2             
	add     r1,29h            
	mov     r0,14h                  ;视野下写入14h
	strb    r0,[r1]           
	ldr     r0,=SpriteRNG           ;随机值
	ldrb    r0,[r0]           
	lsl     r0,r0,2h                ;乘以4
	add     r0,1h                   ;写入764用于计数
	add     r1,3h 					;2Ch, a timer?            
	strb    r0,[r1]           
@@Return:
	pop     r0
	bx      r0
.pool

MoveInAI:    
	push    r4-r7,r14 						;AI ran when "moving towards" the screen when aggro'd                                   
	ldr     r3,=CurrSpriteData                             
	mov     r0,2Fh                                       
	add     r0,r0,r3                                     
	mov     r12,r0                          ;767             
	ldrb    r2,[r0]                                      
	ldr     r4,=YOffsetTable			;table used by to offset Y pos when moving to the foreground                                   
	lsl     r0,r2,1h                    ;767的值乘以2                 
	add     r0,r0,r4                    ;加上偏移值                 
	mov     r5,0h                                        
	ldsh    r1,[r0,r5]                  ;读取数据                 
	ldr     r5,=7FFFh                                    
	cmp     r1,r5                                        
	bne     @@Skip                      ;如果等于则从头开始读取              
	mov     r7,0h                                        
	ldsh    r1,[r4,r7]                                   
	mov     r2,0h  
@@Skip:
	add     r0,r2,1                                      
	mov     r2,r12                                       
	strb    r0,[r2]                     ;r2加1再写入                 
	ldrh    r0,[r3,2h]                                   
	add     r0,r0,r1                    ;Y坐标加上Y偏移值                 
	mov     r6,0h                                        
	strh    r0,[r3,2h]  				;sprite Y                                 
	mov     r7,2Eh                                       
	add     r7,r7,r3                                     
	mov     r12,r7                                       
	ldrb    r2,[r7]                                      
	ldr     r4,=XOffsetTable			;table used by to offset X pos when moving to the foreground                                  
	lsl     r0,r2,1h                                     
	add     r0,r0,r4                                     
	mov     r7,0h                                        
	ldsh    r1,[r0,r7]                                   
	cmp     r1,r5                                        
	bne     @@Skip2                                     
	mov     r0,0h                                        
	ldsh    r1,[r4,r0]                                   
	mov     r2,0h
@@Skip2:
	add     r0,r2,1                                      
	mov     r2,r12                                       
	strb    r0,[r2]                                      
	ldrh    r0,[r3,4h]                                   
	add     r0,r0,r1                                     
	strh    r0,[r3,4h] 				;sprite X                                  
	mov     r1,r3                                        
	add     r1,2Ch					;timer until increase scaling                                        
	ldrb    r0,[r1]                                      
	mov     r4,r0                                        
	cmp     r4,0h                                        
	beq     @@CheckScaling                                     
	sub     r0,1h                                        
	b       @@Store                                     
.pool
@@CheckScaling:                                    
	ldrh    r0,[r3,12h]                                  
	cmp     r0,0FFh                                      
	bhi     @@SetNewPose                                    
	add     r0,4h				;increase scaling, giving impression that the metroid is getting closer                                        
	strh    r0,[r3,12h]			;OAM Scaling                                  
	lsl     r0,r0,10h                                    
	lsr     r0,r0,10h                                    
	cmp     r0,0D0h                                      
	bls     @@CheckScaling2                                     
	mov     r1,r3                                        
	add     r1,20h 				;palette                                      
	mov     r0,1h                                        
	b       @@Store
@@CheckScaling2:
	cmp     r0,0A0h                                      
	bls     @@Return                                    
	mov     r1,r3                                        
	add     r1,20h 				;palette                                      
	mov     r0,2h            	                            
	b       @@Store
@@SetNewPose:                                    
	mov     r0,r3                                        
	add     r0,20h                                       
	strb    r6,[r0]                                      
	ldrh    r0,[r3] 				;status                                     
	ldr     r1,=0FF7Fh  			;gets run of 80h flag                                 
	and     r1,r0                                        
	mov     r2,r3                                        
	add     r2,24h                                       
	mov     r0,8h					;pose = 8                                        
	strb    r0,[r2]                                      
	ldr     r0,=82EDC20h 			;OAM pointer                                
	str     r0,[r3,18h]                                  
	strb    r6,[r3,1Ch]                                  
	strh    r4,[r3,16h]                                  
	and     r1,r5                                        
	strh    r1,[r3]                                      
	mov     r1,r3                                        
	add     r1,25h                                       
	mov     r0,18h                                       
	strb    r0,[r1]                                      
	sub     r1,3h                                        
	mov     r0,4h 
@@Store:
	strb    r0,[r1] 
@@Return:                                     
	pop     r4-r7                                        
	pop     r0                                           
	bx      r0
.pool

SetPursueAI:   
	ldr     r3,=CurrSpriteData                                
	mov     r1,r3                                        
	add     r1,24h                                       
	mov     r2,0h                                        
	mov     r0,9h                                        
	strb    r0,[r1] 				;pose = 9, pursue                                     
	mov     r0,r3                                        
	add     r0,2Dh                                       
	strb    r2,[r0]                                      
	add     r0,1h                                        
	mov     r1,1h                                        
	strb    r1,[r0] 				;1 to 2Eh                                     
	sub     r0,2h                                        
	strb    r2,[r0] 				;0 to 2Ch                                     
	add     r0,3h                                        
	strb    r1,[r0]					;1 to 2Fh                                      
	ldr     r0,=82EDC20h			;OAM pointer                                 
	str     r0,[r3,18h]                                  
	strb    r2,[r3,1Ch]                                  
	strh    r2,[r3,16h]                                  
	bx      r14                                          
.pool


PursueAI:
	push    r4,r14 					;main AI for metroid. Ran when pursuing Samus                                      
	add     sp,-4h                                       
	bl      CheckPlaySoundAI                                     
	ldr     r4,=CurrSpriteData                                
	ldrh    r1,[r4]					;Status                                      
	mov     r0,80h                                       
	lsl     r0,r0,4h                                     
	and     r0,r1                                        
	cmp     r0,0h 					;checking if 800h flag is set                                       
	beq     @@Move                                    
	bl      CheckLatchAI                                     
	lsl     r0,r0,18h                                    
	cmp     r0,0h 					;check return value                                       
	beq     @@Latch 					                                    
	ldrh    r1,[r4]					;if metroid cannont latch, removes 800h flag from status                                      
	ldr     r0,=0F7FFh 				                               
	and     r0,r1                                        
	strh    r0,[r4]                                      
	b       @@Move                                    
.pool
@@Latch:
	mov     r1,r4                                        
	add     r1,24h                                       
	mov     r0,42h                                       
	strb    r0,[r1]					;pose = 42                                      
	ldrh    r1,[r4]                                      
	mov     r2,80h                                       
	lsl     r2,r2,8h 					;8000h                                    
	mov     r0,r2                                        
	orr     r0,r1                                        
	strh    r0,[r4]                                      
	b       @@Return                                     
@@Move:
	mov     r0,1h                                        
	bl      MetroidPushAI                                     
	ldr     r1,=SamusData                                 
	ldr     r0,=3001588h                                 
	add     r0,70h                                       
	ldrh    r0,[r0]					;Samus top hitbox?                                      
	ldrh    r2,[r1,14h]				;Samus Y                                  
	add     r0,r0,r2                                     
	lsl     r0,r0,10h                                    
	lsr     r0,r0,10h                                    
	ldrh    r1,[r1,12h]				;Samus X                                  
	mov     r2,2h                                        
	str     r2,[sp]                                      
	mov     r2,1Eh                                       
	mov     r3,28h                                       
	bl      MoveAI
@@Return:
	add     sp,4h                                        
	pop     r4                                           
	pop     r0                                           
	bx      r0                                           
.pool
   

SetLatchAI:
	ldr     r0,=CurrSpriteData                                 
	mov     r12,r0                                       
	mov     r1,r12                                       
	add     r1,24h                                       
	mov     r2,0h                                        
	mov     r0,43h                                       
	strb    r0,[r1]						;pose = 43h, latched pose                                      
	ldr     r0,=82EDCA8h				;OAM pointer                                 
	mov     r1,r12      
	str     r0,[r1,18h] 
	strb    r2,[r1,1Ch] 
	mov     r3,0h       
	strh    r2,[r1,16h] 
	add     r1,2Ch      
	mov     r0,4h       
	strb    r0,[r1]						;vertical deccel = 4     
	add     r1,1h       
	strb    r0,[r1]     
	add     r1,6h  						;horizontal deccel = 4     
	strb    r0,[r1]     
	mov     r0,r12      
	add     r0,2Ah      
	strb    r3,[r0]     
	ldr     r1,=SamusEquipment
	mov     r0,1h       
	strb    r0,[r1,13h]					;sets grabbed by metroid flag 
	bx      r14         
.pool


LatchedAI:    
	push    r4,r5,r14					;AI for when metroid is latched onto Samus                                  
	bl      CheckPlaySoundAI                           
	mov     r0,2h                                      
	bl      MetroidPushAI                              
	ldr     r3,=CurrSpriteData                         
	mov     r1,r3                                      
	add     r1,2Ch						;timer for changing color                                    
	ldrb    r0,[r1]                                    
	sub     r0,1h                                      
	strb    r0,[r1]                                    
	lsl     r0,r0,18h                                  
	lsr     r2,r0,18h                                  
	cmp     r2,0h							;if 0 change color                                      
	bne     @@PositionChange                                   
	mov     r0,4h                                      
	strb    r0,[r1]						;4 to timer                                    
	add     r1,1h                                      
	ldrb    r0,[r1]						;2Dh, color?                                    
	add     r0,1h                                      
	strb    r0,[r1]				                                    
	lsl     r0,r0,18h                                  
	lsr     r0,r0,18h                                  
	cmp     r0,4h							;checks color                                      
	bls     @@ChangePalette                                   
	strb    r2,[r1]						;resets color
@@ChangePalette: 
	ldr     r2,=40000D4h                               
	ldrb    r0,[r1]                                    
	lsl     r0,r0,5h						;math to get palette                                    
	ldr     r1,=82ED988h					;base value                               
	add     r0,r0,r1                                   
	str     r0,[r2]                                    
	ldr     r0,=5000380h                               
	str     r0,[r2,4h]                                 
	ldr     r0,=80000008h                              
	str     r0,[r2,8h]                                 
	ldr     r0,[r2,8h]
@@PositionChange:
	ldr     r4,=CurrSpriteData                               
	ldrh    r0,[r4,2h]					;sprite Y                                 
	ldrh    r1,[r4,4h]					;sprite X                                 
	bl      CheckPathAI                                   
	lsl     r0,r0,18h                                  
	cmp     r0,0h                                      
	beq     @@NotBlocked 
	ldr     r1,=SamusData                               
	ldrh    r0,[r4,4h]					;sprite X                                 
	strh    r0,[r1,12h]					;Samus' X , prevents Samus from moving horizontally                                
	b       @@StoreY                                   
.pool
@@NotBlocked:
	ldr     r1,=SamusData                               
	ldrh    r0,[r1,12h]					;Samus X                                
	strh    r0,[r4,4h]					;make sprite = Samus' X 
@@StoreY:
	ldr     r4,=CurrSpriteData                               
	ldr     r0,=3001588h                               
	add     r0,70h                                     
	ldrh    r0,[r0]						;top hitbox?                                    
	ldrh    r1,[r1,14h]					;Samus' Y                                
	add     r0,r0,r1 						;Samus' topmost position                                  
	mov     r5,0h                                      
	strh    r0,[r4,2h]					;sprite Y = Samus' topmost position                                  
	bl      CheckUnlatchAI                              
	lsl     r0,r0,18h                                  
	cmp     r0,0h							;0 = not bombed                                      
	beq     @@LatchedSounds                                   
	ldr     r0,=SpriteRNG                              
	ldrb    r1,[r0]                                    
	mov     r0,1h                                      
	and     r0,r1                                      
	mov     r2,10h                        ;checking if 1 flah is set              
	cmp     r0,0h 						;50/50 chance?                                   
	beq     @@Unlatch                                   
	mov     r2,1Ch
@@Unlatch:
	mov     r1,r4                                      
	add     r1,24h                                     
	mov     r0,9h                                      
	strb    r0,[r1]						;pose = 9, pursue                                     
	mov     r0,r4                                      
	add     r0,20h						;restore normal palette                                     
	strb    r5,[r0]                                    
	add     r1,2h							;Ignore samus collision timer                                     
	mov     r0,0Fh                                     
	strb    r0,[r1]						;15 frames to not interact with Samus                                    
	ldrh    r1,[r4] 						;status                                   
	ldr     r0,=7BFFh                                  
	and     r0,r1							;removes 400h, so metroid always flies up when bombed                                      
	strh    r0,[r4]                                    
	mov     r0,r4                                      
	add     r0,2Ch                                     
	strb    r5,[r0]						;reset timers                                    
	add     r0,3h                                      
	strb    r2,[r0]                                    
	sub     r0,2h                                      
	strb    r5,[r0]                                    
	add     r0,1h                                      
	strb    r2,[r0]                                    
	ldr     r0,=82EDC20h					;OAM pointer                               
	str     r0,[r4,18h]                                
	strb    r5,[r4,1Ch]                                
	mov     r0,0h                                      
	strh    r0,[r4,16h]                                
	mov     r0,r4                                      
	add     r0,33h                                     
	strb    r5,[r0]                                    
	ldr     r0,=SamusEquipment                               
	strb    r5,[r0,13h]					;removes "grabbed by metroid" flag                                
	b       @@Return                                   
.pool
@@LatchedSounds:
	mov     r0,r4                                      
	add     r0,2Ah					;timer to play sound?                                     
	ldrb    r1,[r0]                                    
	mov     r0,1Fh                                     
	and     r0,r1                                      
	cmp     r0,0h                                      
	bne     @@Inc                                   
	mov     r0,81h 					;lower pitched "suck" sound                                    
	bl      PlaySound                                   
	ldr     r0,=SamusEquipment                               
	ldrb    r0,[r0,0Fh]				;active items                                
	mov     r2,30h                                     
	and     r2,r0                                      
	cmp     r2,0h						;checking for varia or gravity                                      
	bne     @@CheckIfBoth                                   
	ldr     r0,=16Dh					;higher pitched "suck" sound                                     
	bl      PlaySound2                                   
	b       @@Inc                                   
.pool
@@CheckIfBoth:
	cmp     r2,30h                                     
	bne     @@OneSuit                                   
	ldr     r0,=16Fh					;lower pitched "suck" sound                                     
	bl      PlaySound2                                   
	b       @@Inc                                   
.pool
@@OneSuit:
	mov     r0,0B7h                                    
	lsl     r0,r0,1h					;16Eh                                   
	bl      PlaySound2				;higher pitched than 16Dh but lower than 16Fh  
@@Inc:
	ldr     r1,=CurrSpriteData                               
	add     r1,2Ah                                     
	ldrb    r0,[r1]                                    
	add     r0,1h                                      
	strb    r0,[r1]
@@Return:
	pop     r4,r5                                      
	pop     r0                                         
	bx      r0                                         
.pool


DeathAI:
	push    r4-r7,r14                                    
	add     sp,-4h                                       
	ldr     r0,=SpriteRNG                                 
	ldrb    r2,[r0]                                      
	ldr     r0,=CurrSpriteData                                 
	ldrh    r3,[r0,2h]					;sprite Y                                   
	ldrh    r4,[r0,4h]                    ;sprite X              
	ldrh    r1,[r0]                                      
	mov     r0,40h 						;checking 40h (X flip)                                      
	and     r0,r1                                        
	cmp     r0,0h                                        
	beq     @@Sub                                     
	add     r0,r3,r2 						                                    
	b       @@DeathRoutine                                     
.pool
@@MetroidsExist:
	add     r0,r3,1  						;value for metroids existing in room still                                  
	lsl     r0,r0,18h                                    
	lsr     r3,r0,18h                                    
	b       @@CheckIfMore 
@@Sub:
	sub     r0,r3,r2
@@DeathRoutine:
	lsl     r0,r0,10h							;all arguments for death function                                    
	lsr     r3,r0,10h                                    
	mov     r2,r4                                        
	add     r2,24h                                       
	mov     r0,29h                                       
	str     r0,[sp]                                      
	mov     r0,0h                                        
	mov     r1,r3                                        
	mov     r3,1h                                        
	bl      DeathRoutine                                     
	mov     r0,64h                                       
	mov     r12,r0                                       
	mov     r7,65h                                       
	mov     r6,62h                                       
	mov     r5,1h                                        
	mov     r4,80h                                       
	mov     r3,0h                                        
	ldr     r1,=SpriteData                                 
	mov     r2,0A8h                                      
	lsl     r2,r2,3h 							;540h                                    
	add     r0,r1,r2							;30006ECh                                      
	cmp     r1,r0								;not sure why this is here                                        
	bcs     @@CheckIfMore                                    
	mov     r2,r1                                        
	add     r2,24h                                       
@@Loop:
	ldrh    r0,[r1]							;check status                                     
	and     r0,r5								;checks if alive                                        
	cmp     r0,0h                                        
	beq     @@NextSlot                                     
	ldrb    r0,[r2,0Eh] 						;collision properties                                 
	and     r0,r4                                        
	cmp     r0,0h	                                        
	bne     @@NextSlot                                     
	ldrb    r0,[r1,1Dh]						;sprite ID                                  
	cmp     r0,r12                            ;64h, metroid           
	beq     @@IsMetroid                                    
	cmp     r0,r7								;65h, frozen metroid                                        
	bne     @@NextSlot
@@IsMetroid:
	ldrb    r0,[r2]							;checks if pose of metroid/death pose                                      
	cmp     r0,r6                                        
	bcc     @@MetroidsExist 
@@NextSlot:
	add     r2,38h                                       
	add     r1,38h                                       
	ldr     r0,=30006ECh					;address of last slot in sprite data                                
	cmp     r1,r0                                        
	bcc     @@Loop
@@CheckIfMore:
	cmp     r3,0h							;check value for more metroids being true							                                       
	bne     @@Return                                     
	ldr     r0,=CurrRoom                                 
	ldrb    r0,[r0]                                      
	sub     r0,1h                                        
	cmp     r0,12h							;jump table that sets event based on room                                       
	bhi     @@Return                                     
	lsl     r0,r0,2h                                     
	ldr     r1,=@@JumpTable                                 
	add     r0,r0,r1                                     
	ldr     r0,[r0]                                      
	mov     r15,r0                                       
.pool
@@JumpTable:
	.word @@Event38,@@Event39,@@Return,@@Return                                    
	.word @@Return,@@Return,@@Return,@@Return
	.word @@Return,@@Return,@@Return,@@Return
	.word @@Return,@@Event37,@@Event3A,@@Event3B                                   
	.word @@Return,@@Return,@@Event3C
@@Event37:	
	mov     r0,1h                                        
	mov     r1,37h                                       
	b       @@SetEvent
@@Event38:
	mov     r0,1h                                        
	mov     r1,38h                                       
	b       @@SetEvent
@@Event39:
	mov     r0,1h                                        
	mov     r1,39h                                       
	b       @@SetEvent
@@Event3A:
	mov     r0,1h                                        
	mov     r1,3Ah                                       
	b       @@SetEvent
@@Event3B:
	mov     r0,1h                                        
	mov     r1,3Bh                                       
	b       @@SetEvent 
@@Event3C:
	mov     r0,1h                                        
	mov     r1,3Ch
@@SetEvent:
	bl      EventFunctions                                     
	ldr     r1,=LockDoor                                 
	mov     r2,14h                                       
	neg     r2,r2                                        
	mov     r0,r2                                        
	strb    r0,[r1]				;timer to unlock door
@@Return:
	add     sp,4h                                        
	pop     r4-r7                                        
	pop     r0                                           
	bx      r0                                           
.pool


MainAI:
	push    r4,r14                 
	ldr     r1,=CurrSpriteData           
	mov     r3,r1                  
	add     r3,32h                 
	ldrb    r2,[r3]						;collision properties                 
	mov     r4,2h                  
	mov     r0,r4                  
	and     r0,r2                  
	cmp     r0,0h 						;only false if hurt                 
	beq     @@HitCheck               
	mov     r0,0FDh 						;gets rid of 2h flag               
	and     r0,r2                  
	strb    r0,[r3]                
	ldrh    r1,[r1]						;status                
	mov     r0,r4                  
	and     r0,r1							;check if on screen                  
	cmp     r0,0h                  
	beq     @@FrozenCheck               
	mov     r0,0B9h                
	lsl     r0,r0,1h						;172h, metroid hurt sound              
	bl      PlaySound               
	b       @@FrozenCheck               
.pool
@@HitCheck:
	mov     r0,r1                  
	add     r0,2Bh                 
	ldrb    r0,[r0]						;stun timer                
	mov     r2,7Fh						;removing 80h flag                 
	and     r2,r0                  
	cmp     r2,2h							;flase if projectile hit metroid                   
	bne     @@FrozenCheck               
	ldrh    r0,[r1,14h]					;heath           
	ldrh    r3,[r1,6h]					;previous health             
	cmp     r0,r3					        ;checks if metroid was hurt           
	bne     @@Store              
	ldrh    r0,[r1]						;status	                
	and     r2,r0                  
	cmp     r2,0h 						;checking if onscreen                 
	beq     @@FrozenCheck               
	ldr     r0,=171h						;metroid sound, plays if shot with projectile it is immune to               
	bl      PlaySound              
	b       @@FrozenCheck               
.pool
@@Store:
	strh    r0,[r1,6h]					;prevoius health = health
@@FrozenCheck:
	ldr     r2,=CurrSpriteData           
	mov     r0,r2                  
	add     r0,30h						;freeze timer                 
	ldrb    r0,[r0]                
	cmp     r0,0h                  
	beq     @@IDCheck               
	ldr     r0,=0FFD0h					;if frozen, new hitboxes             
	strh    r0,[r2,0Ah]					;top            
	mov     r0,28h                 
	strh    r0,[r2,0Ch]					;bottom            
	ldr     r0,=0FFC0h             
	strh    r0,[r2,0Eh]					;left            
	mov     r0,40h                 
	strh    r0,[r2,10h] 					;right           
	mov     r0,1h                  
	bl      MetroidPushAI          
	ldr     r0,=Difficulty           
	ldrb    r0,[r0]						;decides how fast to unthaw metroid based on difficulty                
	cmp     r0,0h                  
	bne     @@FastThaw               
	bl      NormalThaw               
	b       @@NewID              
.pool
@@FastThaw:
	bl      FastThaw
@@NewID:
	ldr     r1,=CurrSpriteData          
	mov     r0,65h                 
	strb    r0,[r1,1Dh]					;changes ID when frozen to allow missile damage          
	b       @@Return               
.pool
@@IDCheck:
	ldrb    r0,[r2,1Dh]            
	cmp     r0,65h                 
	bne     @@PoseCheck
	ldr     r1,=0FFD8h 					;restores hitboxes to non-frozen state            
	strh    r1,[r2,0Ah]					;top            
	mov     r0,20h                 
	strh    r0,[r2,0Ch]					;bottom            
	strh    r1,[r2,0Eh]					;left            
	mov     r0,28h                 
	strh    r0,[r2,10h] 					;right           
	mov     r0,64h                 
	strb    r0,[r2,1Dh]					;restores ID to 64, immune to missiles again            
	mov     r1,r2                  
	add     r1,24h                 
	ldrb    r0,[r1]						;pose                
	cmp     r0,61h                 
	bhi     @@PoseCheck               
	mov     r0,8h                  
	strb    r0,[r1]
@@PoseCheck:
	ldr     r0,=CurrSpriteData           
	add     r0,24h                 
	ldrb    r0,[r0]						;pose                
	cmp     r0,8h                  
	beq     @@SetPursue               
	cmp     r0,8h                  
	bgt     @@PoseCheck2               
	cmp     r0,1h                  
	beq     @@Idle              
	cmp     r0,1h                  
	bgt     @@PoseCheck4               
	cmp     r0,0h                  
	beq     @@Spawn               
	b       @@RemoveFlag               
.pool
@@PoseCheck4:
	cmp     r0,2h                  
	beq     @@MoveIn               
	b       @@RemoveFlag
@@PoseCheck2:
	cmp     r0,42h                 
	beq     @@SetLatch               
	cmp     r0,42h                 
	bgt     @@PoseCheck3               
	cmp     r0,9h                  
	beq     @@Pursuit               
	b       @@RemoveFlag
@@PoseCheck3:
	cmp     r0,43h                 
	beq     @@Latched               
	cmp     r0,62h                 
	beq     @@Dead               
	b       @@RemoveFlag
@@Spawn:
	bl      Initialize
	b       @@RemoveFlag
@@Idle:
	bl      IdleAI
	b       @@RemoveFlag
@@MoveIn:
	bl      MoveInAI
	b       @@RemoveFlag               
@@SetPursue:
	bl      SetPursueAI
@@Pursuit:
	bl      PursueAI
	b       @@RemoveFlag
@@SetLatch:
	bl      SetLatchAI
@@Latched:
	bl      LatchedAI
	b       @@RemoveFlag
@@Dead:
	bl      DeathAI
@@RemoveFlag:
	ldr     r2,=CurrSpriteData           
	ldrh    r1,[r2]                
	ldr     r0,=0F7FFh 				;removes 800h            
	and     r0,r1                  
	strh    r0,[r2]
@@Return:
	pop     r4                     
	pop     r0                     
	bx      r0                     
.pool
.close