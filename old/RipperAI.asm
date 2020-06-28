.gba
.open "zm.gba","ZeroMission.gba",0x8000000
.definelabel CheckEndSpriteAnimation,0x800FBC8
.definelabel StunSprite,0x8011280	
.definelabel MoveAI,0x801BE1C
.definelabel TurningAI,0x801BE88
.definelabel TurningAI2,0x801BEA8
.definelabel CheckEndTurn,0x801BEE0
.definelabel SetUpAI,0x801BD8C
.definelabel EndTurnAI,0x801BDFC


.org 0x801BD8C				;sets up Ripper, ran once per ripper when spawning
	push    r4,r5,r14          ;好像只有生成的时候运行一次                     
	ldr     r5,=3000738h                            
	mov     r3,0h                                   
	mov     r2,0h                                   
	ldr     r0,=0FFDCh		;sprite top boundary value                             
	strh    r0,[r5,0Ah]		;stores top sprite boundary    3000742 23?                       
	strh    r2,[r5,0Ch]		;stores 0 to sprite bottom boundary   3000744 0                         
	add     r0,4h                                   
	strh    r0,[r5,0Eh]		;sprite left boundary        3000746    23 头?         
	mov     r0,20h                                  
	strh    r0,[r5,10h]		;sprite right boundary        3000748   20 尾               
	mov     r0,r5                                   
	add     r0,27h                         ;300075f         
	mov     r1,10h                                  
	strb    r1,[r0]			;stores 10 to unknown sprite address                                 
	add     r0,1h                           ;3000760       
	mov     r4,8h                                   
	strb    r4,[r0]			;stores 8 to unknown sprite address			                                 
	add     r0,1h                           ;3000761        
	strb    r1,[r0]			;stores 10 to unknown sprite address                                 
	ldr     r0,=82CC048h		;OAM pointer      敌人图像地址?                      
	str     r0,[r5,18h]		;stores OAM pointer to sprite data    3000750                         
	strb    r3,[r5,1Ch]		;sets animation and counter to 0    300074E  动画                      
	strh    r2,[r5,16h]                           ;3000754  持续帧数
	mov     r1,r5                                   
	add     r1,25h                                  
	mov     r0,4h                                   
	strb    r0,[r1]			;stores 4 to unknown sprite address  300075d写入攻击属性                               
	ldr     r2,=82B0D68h		;base value for math to find sprite health		                            
	ldrb    r1,[r5,1Dh]                   ;读取 3000755 ID         
	lsl     r0,r1,3h                       ;ID乘8         
	add     r0,r0,r1                       ;加1         
	lsl     r0,r0,1h                       ;再乘2         
	add     r0,r0,r2                       ;加上敌人基础数据偏移起始坐标         
	ldrh    r0,[r0]                        ;读取血量         
	strh    r0,[r5,14h]		;stores health  写入300074c                           
	ldrh    r0,[r5,2h]          ;读取Y坐标                   
	sub     r0,8h               ;减少8,相当于向上升8       
	strh    r0,[r5,2h]		;subtracts Y position by 8h                              
	bl      800F80Ch                                
	mov     r0,r5                                   
	add     r0,24h          ;300075c 敌人pose                      
	strb    r4,[r0]			;stores pose 和3000760一样是8                             
	pop     r4,r5                                   
	pop     r0                                      
	bx      r0                                     
.pool
.org 0x801BDFC				;ends ripper's turning AI
	ldr     r1,=3000738h                            
	mov     r2,r1                                   
	add     r2,24h                                  
	mov     r3,0h                                   
	mov     r0,9h			;stores 9 to sprite pose  敌人pose9                               
	strb    r0,[r2]                                 
	ldr     r0,=82CC048h		;OAM Pointer                            
	str     r0,[r1,18h]		;stores OAM pointer to sprite data                             
	mov     r0,0h                                   
	strh    r3,[r1,16h]		;resets animation and counter                             
	strb    r0,[r1,1Ch]                             
	bx      r14                                     
.pool

.org 0x801BE1C				;handles moving of the ripper
	push    r4,r5,r14                               
	ldr     r4,=3000738h                            
	ldrb    r0,[r4,1Dh]		;sprite ID                             
	mov     r5,2h 			;normal ripper movement speed                                  
	cmp     r0,17h			;checking ripper type                                  
	bne     @@DirectionCheck                               
	mov     r5,4h			;purple ripper speed                                   
@@DirectionCheck:
	ldrh    r1,[r4]			;sprite status  确认敌人的面向                               
	mov     r0,40h			;checks direction ripper is moving                                  
	and     r0,r1                   ;0 = Left 40 = Right               
	cmp     r0,0h			                                   
	beq     @@MoveLeft                              
	ldrh    r0,[r4,2h]		;sprite Y position                              
	sub     r0,10h                                  
	ldrh    r1,[r4,4h]		;sprite X position                              
	add     r1,24h          ;让判定点回复默认的位置?                       
	bl      800F688h		;series of routines that seem to check is ripper hits a solid block                                  
	ldr     r0,=30007F1h                            
	ldrb    r0,[r0]                                 
	cmp     r0,11h			;only true if ripper is turning around                                 
	beq     @@Turning       ;当30007f1=11的时候转弯                      
	ldrh    r0,[r4,4h]		;Increasing X position                              
	add     r0,r5,r0                                
	b       @@StoreX                                
.pool
@@MoveLeft:
	ldrh    r0,[r4,2h] 		;sprite Y position                             
	sub     r0,10h                                  
	ldrh    r1,[r4,4h]		;sprite X position                               
	sub     r1,24h                                
	bl      800F688h		;series of routines that seem to check is ripper hits a solid block                               
	ldr     r0,=30007F1h                           
	ldrb    r0,[r0]                                 
	cmp     r0,11h			;only true if ripper is turning around                                       
	bne     @@MoveLeft2
@@Turning:                               
	mov     r1,r4                                  
	add     r1,24h			;stores Ah to Sprite Pose (turning pose)                                
	mov     r0,0Ah                                 
	strb    r0,[r1]                                 
	b       @@Return                               
.pool
@@MoveLeft2:
	ldrh    r0,[r4,4h]		;decreases X position                               
	sub     r0,r0,r5                                
@@StoreX:
	strh    r0,[r4,4h]		;stores X position                               
@@Return:
	pop     r4,r5                                   
	pop     r0                                       
	bx      r0                                     

.org 0x801BE88				;Turning AI 
	ldr     r1,=3000738h                            
	mov     r2,r1                                   
	add     r2,24h			;stores Bh to sprite pose                                 
	mov     r3,0h                                   
	mov     r0,0Bh                                  
	strb    r0,[r2]                                
	ldr     r0,=82CC070h		;OAM pointer                            
	str     r0,[r1,18h]		;stores OAM pointer to sprite data                            
	mov     r0,0h                                   
	strh    r3,[r1,16h]		;resets animation counter and animation                             
	strb    r0,[r1,1Ch]                             
	bx      r14                                     
.pool

.org 0x801BEA8				;second turning AI
	push    r4,r14                                  
	bl      CheckEndSpriteAnimation                               
	cmp     r0,0h 			;0 if not true                                  
	beq     @@Return                               
	ldr     r2,=3000738h                            
	ldrh    r1,[r2]			;sprite status                                 
	mov     r0,40h                                  
	eor     r1,r0			;OR operation to change sprite direction flag                                   
	mov     r3,0h                                   
	mov     r4,0h                                  
	strh    r1,[r2]			;stores status                                
	mov     r1,r2                                   
	add     r1,24h			;changes sprite pose to Ch                                 
	mov     r0,0Ch                                  
	strb    r0,[r1]                                 
	ldr     r0,=82CC088h		;OAM pointer                           
	str     r0,[r2,18h]		;stores OAM pointer to Sprite Data                             
	strb    r3,[r2,1Ch]		;resets animation and counter                            
	strh    r4,[r2,16h]                             
@@Return:
	pop     r4                                      
	pop     r0                                      
	bx      r0                                      
.pool

.org 0x801BEE0				;checks to resume straight movement
	push    r14                                    
	bl      800FC00h                               
	cmp     r0,0h			;true when finishing turning around                                  
	beq     @@Return                                
	ldr     r0,=3000738h		;changes sprite pose to 8h                            
	add     r0,24h                                   
	mov     r1,8h                                  
	strb    r1,[r0]                                 
@@Return:
	pop     r0                                    
	bx      r0                                      
.pool

.org 0x801BEFC				;Main AI routine/always run for each living ripper every frame
	push    r4,r14                                  
	add     sp,-4h                                   
	ldr     r1,=3000738h		;current enemy being processed                             
	mov     r3,r1                                    
	add     r3,32h                                   
	ldrb    r2,[r3] 		;Collision properties  碰撞属性?   300076a                            
	mov     r4,2h                                    
	mov     r0,r4                                   
	and     r0,r2                                   
	cmp     r0,0h            ;等于300076a/=2的话则跳转                    
	beq     @@FrozenCheck                              
	mov     r0,0FDh                                 
	and     r0,r2                                   
	strb    r0,[r3]                                  
	ldrh    r1,[r1]                                 
	mov     r0,r4                                    
	and     r0,r1                                   
	cmp     r0,0h                                    
	beq     @@FrozenCheck                               
	ldr     r0,=149h                                
	bl      8002B20h		;play sound                                
@@FrozenCheck:
	ldr     r4,=3000738h                             
	mov     r0,r4                                    
	add     r0,30h                                 
	ldrb    r0,[r0]			;frozen timer    3000768                            
	cmp     r0,0h			;checking if frozen                                  
	beq     @@RoutineCheck    ;没有冰冻则跳转                         
	bl      800FFE8h                               
	b       @@Return                              
.pool
@@RoutineCheck:
	bl      StunSprite                                
	cmp     r0,0h			;1 if stunned, 0 if not                                 
	bne     @@Return		;returns is stunned                               
	mov     r0,r4                                    
	add     r0,24h			;sprite pose                                 
	ldrb    r0,[r0]                                  
	cmp     r0,0Ch          ;pose大于c则等于死亡                         
	bhi     @@Dead			;true is sprite is dead                               
	lsl     r0,r0,2h                                 
	ldr     r1,=@@Table		;math based on sprite pose and table to run AI routines                           
	add     r0,r0,r1                                 
	ldr     r0,[r0]                                  
	mov     r15,r0                                   
.pool
@@Table:
	.word 0x801BF98     ;bl 801bd8ch 00设置精灵初始值,每个敌人只经历一次
	.word 0x801BFB8     
	.word 0x801BFB8
	.word 0x801BFB8
	.word 0x801BFB8
	.word 0x801BFB8	
	.word 0x801BFB8
	.word 0x801BFB8
	.word 0x801BF9E     ;bl 801bdfch  08 end turn ai
	.word 0x801BFA2     ;bl 801be1ch
	.word 0x801BFA8     ;bl 801be88h
	.word 0x801BFAC     ;bl 801bea8h
	.word 0x801BFB2     ;bl 801bee0h
@@EndTable:
	bl      SetUpAI                                
	b       @@Return                             
	bl      EndTurnAI                                
	bl      MoveAI                               
	b       @@Return                              
	bl      TurningAI                                
	bl      TurningAI2                              
	b       @@Return                               
	bl      CheckEndTurn                                
	b       @@Return                               
@@Dead:
	ldr     r0,=3000738h                             
	ldrh    r1,[r0,2h]		;sprite Y position                              
	sub     r1,18h                                   
	ldrh    r2,[r0,4h]		;sprite X position                               
	mov     r0,20h                                  
	str     r0,[sp]                                 
	mov     r0,0h                                   
	mov     r3,1h                                   
	bl      8011084h		;routine to disassemble                                
@@Return:
	add     sp,4h                                  
	pop     r4                                     
	pop     r0                                       
	bx	r0
.pool
.close