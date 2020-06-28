.gba
.open "zm.gba","S.gba",0x8000000

.definelabel Equipment,0x3001530
.definelabel Difficulty,0x300002C
.definelabel Division,0x808AC34

;Routine for how much damage a sprite should do to Samus

.org 0x800E634 			;r1 = sprite slot address
	push    r4-r7,r14                           
	mov     r3,r1    	;移动精灵串地址300036c给r3 move sprite slot address to r3     
	lsl     r0,r0,18h                           
	lsr     r7,r0,18h   ;r7得到r0的字节                     
	lsl     r2,r2,10h   ;r2左移16位
	lsr     r4,r2,10h                       
	mov     r0,r3		;move sprite slot address to r0                             
	add     r0,32h          ;add 32 to r3, which determins if sprite is a primary or secondary sprite                    
	ldrb    r1,[r0]         ;300039e地址的字节是区分精灵主副的？    
	mov     r0,80h                          
	and     r0,r1              ;80为主，c0为副                 
	cmp     r0,0h		;checks sprite type                  
	beq     @@Primary                           
  	ldr     r2,=82B1BE4h	;base address for secondary sprite, used to get sprite damage                      
  	b       @@DamageGet                           
.pool
@@Primary:
	ldr     r2,=82B0D68h	;bass address for primary sprite, used to get sprite damage                         
@@DamageGet:
	ldrb    r1,[r3,1Dh]	;loads current sprite's ID   得到当前精灵的ID            
	lsl     r0,r1,3h    ;乘以8                       
	add     r0,r0,r1      ;再加一次                      
	lsl     r0,r0,1h     ;再乘以2,相当于乘以18倍                    
	add     r2,2h         ;把精灵数据地址加2                 
	add     r0,r0,r2      ;加上精灵ID的位置                   
	ldrh    r3,[r0] 	;math to get sprite damage value 得到精灵伤害值                             
	mov     r0,r3                             
	mul     r0,r4        ; 把这个值乘以r4      r4=1            
 	lsl     r5,r0,10h                    
 	lsr     r3,r5,10h                          
    	ldr     r1,=Equipment                      
    	ldrb    r2,[r1,0Fh]      ;得到300153f的字节              
   	mov     r4,r2                              
   	mov     r0,30h		;checks if both suits are active   确认有两套衣服?                
    	and     r0,r2                                 
    	mov     r6,r1                                   
    	cmp     r0,30h             
    	bne     @@GravityCheck                 
	lsr     r3,r5,11h       ;halves sprite Damage value   一半的血           
	b       @@EasyModeCheck                           
.pool
@@GravityCheck:
	mov     r0,20h          ;checks for gravity suit    确认重力服装      
	and     r2,r0                                
	cmp     r2,0h        ;如果没有重力服装则跳转                 
	beq     @@VariaCheck                  
	lsl     r0,r3,3h       ;multiplies by 7?    乘以8      
	sub     r0,r0,r3       ;dividend/damage value will be approximately 70% of the original damage               
	b       @@Divide              ;然后在减一次,等于乘以7          
@@VariaCheck:  
	mov     r0,10h           ;判断有没有隔热                      
 	and     r4,r0                                  
	cmp     r4,0h                             
	beq     @@EasyModeCheck    ;乘以8                  
	lsl     r0,r3,3h	;multiplies by 8/dividend/damage value will be 80% of original
@@Divide:	
	mov     r1,0Ah         ;divisor = 0xA     给予r1=10，估计是除以之前的倍数  
	bl      Division         ;跳到别处                   
   	lsl     r0,r0,10h                    
  	lsr     r3,r0,10h      ;new damage value  新的伤害值                 
@@EasyModeCheck:
	ldr     r0,=Difficulty    ;获取难度的地址    
 	ldrb    r0,[r0]              ;得到数值             
	cmp     r0,0h                ;checks for easy mode    如果是容易模式的话             
	bne     @@HardModeCheck                   
	lsr     r3,r3,1h             ;halves damage if on easy  减去一半的血    
	b       @@ValueZeroCheck                              
.pool
@@HardModeCheck:
	cmp     r0,2h		;checks for hard mode      确认是否是困难模式                   
	bne     @@ValueZeroCheck                             
	lsl     r0,r3,11h                       
	lsr     r3,r0,10h	;doubles damage              双倍血     
@@ValueZeroCheck:   
	cmp     r3,0h		;checks if damage value is 0       ;如果伤害是0的话               
	bne     @@ApplyDamage                           
	mov     r3,1h		;if 0, makes damage value 1     ;自动给予伤害1                   
@@ApplyDamage:
	ldrh    r0,[r6,6h]	;Samus' current health   3001536             
	cmp     r0,r3           ;checks if damage dealt is higher or equal to current health                    
	bls     @@Dead           ;如果当前血量小于或等于伤害血量跳转到死亡          
	sub     r0,r0,r3        ;subtracts damage from current health  正常减去血量                
	strh    r0,[r6,6h]          ;然后写入新值                 
	cmp     r7,0h                            
	beq     @@SetR0to1                      
	mov     r0,0FAh                        
	bl      80074E8h                      
@@SetR0to1:   
	mov     r0,1h                                
 	b       @@Return                     
@@Dead:
	mov     r0,0h                               
	strh    r0,[r6,6h]	;stores 0 to Samus' health, killing her                       
    	mov     r0,0FAh                           
    	bl      80074E8h                       
    	mov     r0,0h                      
@@Return: 
	pop     r4-r7                      
	pop     r1                                      
	bx	r1
.close