.gba
.open "zm.gba","S.gba",0x8000000

.definelabel Equipment,0x3001530
.definelabel Difficulty,0x300002C
.definelabel Division,0x808AC34

;Routine for how much damage a sprite should do to Samus

.org 0x800E634 			;r1 = sprite slot address
	push    r4-r7,r14                           
	mov     r3,r1    	;move sprite slot address to r3     
	lsl     r0,r0,18h                           
	lsr     r7,r0,18h                        
	lsl     r2,r2,10h       
	lsr     r4,r2,10h                       
	mov     r0,r3		;move sprite slot address to r0                             
	add     r0,32h          ;add 32 to r3, which determins if sprite is a primary or secondary sprite                    
	ldrb    r1,[r0]             
	mov     r0,80h                          
	and     r0,r1                                 
	cmp     r0,0h		;checks sprite type                  
	beq     @@Primary                           
  	ldr     r2,=82B1BE4h	;base address for secondary sprite, used to get sprite damage                      
  	b       @@DamageGet                           
.pool
@@Primary:
	ldr     r2,=82B0D68h	;bass address for primary sprite, used to get sprite damage                         
@@DamageGet:
	ldrb    r1,[r3,1Dh]	;loads current sprite's ID               
	lsl     r0,r1,3h                            
	add     r0,r0,r1                            
	lsl     r0,r0,1h                          
	add     r2,2h                          
	add     r0,r0,r2                         
	ldrh    r3,[r0] 	;math to get sprite damage value                              
	mov     r0,r3                             
	mul     r0,r4                            
 	lsl     r5,r0,10h                    
 	lsr     r3,r5,10h                          
    	ldr     r1,=Equipment                      
    	ldrb    r2,[r1,0Fh]                        
   	mov     r4,r2                              
   	mov     r0,30h		;checks if both suits are active                   
    	and     r0,r2                                 
    	mov     r6,r1                                   
    	cmp     r0,30h             
    	bne     @@GravityCheck                        
	lsr     r3,r5,11h       ;halves sprite Damage value              
	b       @@EasyModeCheck                           
.pool
@@GravityCheck:
	mov     r0,20h          ;checks for gravity suit           
	and     r2,r0                                
	cmp     r2,0h                         
	beq     @@VariaCheck                  
	lsl     r0,r3,3h       ;multiplies by 7?           
	sub     r0,r0,r3       ;dividend/damage value will be approximately 70% of the original damage               
	b       @@Divide                        
@@VariaCheck:  
	mov     r0,10h                                 
 	and     r4,r0                                  
	cmp     r4,0h                             
	beq     @@EasyModeCheck                      
	lsl     r0,r3,3h	;multiplies by 8/dividend/damage value will be 80% of original
@@Divide:	
	mov     r1,0Ah         ;divisor = 0xA           
	bl      Division                            
   	lsl     r0,r0,10h                    
  	lsr     r3,r0,10h      ;new damage value                   
@@EasyModeCheck:
	ldr     r0,=Difficulty          
 	ldrb    r0,[r0]                           
	cmp     r0,0h                ;checks for easy mode                 
	bne     @@HardModeCheck                       
	lsr     r3,r3,1h             ;halves damage if on easy      
	b       @@ValueZeroCheck                              
.pool
@@HardModeCheck:
	cmp     r0,2h		;checks for hard mode                         
	bne     @@ValueZeroCheck                             
	lsl     r0,r3,11h                       
	lsr     r3,r0,10h	;doubles damage                   
@@ValueZeroCheck:   
	cmp     r3,0h		;checks if damage value is 0                      
	bne     @@ApplyDamage                           
	mov     r3,1h		;if 0, makes damage value 1                        
@@ApplyDamage:
	ldrh    r0,[r6,6h]	;Samus' current health                
	cmp     r0,r3           ;checks if damage dealt is higher or equal to current health                    
	bls     @@Dead                          
	sub     r0,r0,r3        ;subtracts damage from current health                  
	strh    r0,[r6,6h]                           
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