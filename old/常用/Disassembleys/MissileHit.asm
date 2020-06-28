.gba
.open "zm.gba","ZeroMission.gba",0x8000000

.definelabel WeaknessGet,0x8050370	;routine to get sprite weakness
.definelabel HurtSprite,0x8050424	;routine to damage sprite
.definelabel ImmuneNonIce,0x80504CC	;routine ran when enemies are immune to a non-ice projectile
.definelabel SetGFX,0x80540EC		;routine for setting a GFX effect
.definelabel MissileBounce,0x8050914	;routine for missile bouncing off immune enemy
.definelabel ImmuneItem,0x80504AC	;routine run when an item sprite is shot
.definelabel MissileDecrement,0x8051B74	;routine for decreasing missile count


;routine ran when a normal missile strikes most sprites (not ran when hitting a chozo statue for instance)
;r0 = sprite data pointer r1 = projectile data pointer r2 = Projectile Y pos r3 = Projectile X pos  
.org 0x80509DC 
	push    r4-r7,r14		                         
    	mov     r7,r10                   
    	mov     r6,r9                                 
    	mov     r5,r8                               
    	push    r5-r7                           
    	mov     r4,r0			;moves sprite data pointer to r4                            
    	mov     r7,r1			;moves projectile data pointer to r7                                
    	lsl     r2,r2,10h                            
    	lsr     r5,r2,10h                            
    	mov     r10,r5                             
    	lsl     r3,r3,10h                              
    	lsr     r6,r3,10h                         
    	mov     r9,r6                               
    	add     r0,32h			;adds 32 to get sprite collision properties                        
    	ldrb    r1,[r0]                          
    	mov     r0,8h			;seems to be set if sprite ignores all weapons and missiles don't bounce off it                                 
    	mov     r8,r0                               
    	and     r0,r1                               
    	cmp	r0,0h                             
    	beq     @@ImmuneCheck                      
    	mov     r0,r4			;moves sprite data pointer to r0                                 
    	bl      ImmuneNonIce                             
    	b       @@ExplodeSet                       
@@ImmuneCheck:
	mov     r0,40h			;seems to be set if sprite is an item without a statue                                 
	and     r0,r1                            
	cmp     r0,0h                              
	beq     @@VulnerableCheck                            
    	mov     r0,r4			;moves sprite data pointer to r0                             
    	bl      ImmuneItem                            
    	mov     r0,r5			;projectile Y                                 
    	mov     r1,r6			;projectile X                                
    	b       @@GFXRoutines                             
@@VulnerableCheck:    
	mov     r0,r4			;moves sprite data pointer to r0		                                   
	bl      WeaknessGet                         
    	mov     r1,r8                                   
    	and     r1,r0                                  
    	cmp     r1,0h			;checks if sprite's weakness allows for missile damage                                   
    	beq     @@Immune                               
   	mov     r0,r4                            
    	mov     r1,14h			;missile damage                                 
	bl      HurtSprite                              
@@ExplodeSet:    
	mov     r0,r5			;projectile Y                          
	mov     r1,r6			;projectile X                                 
	mov     r2,30h			;value for missile explosion                              
 	bl      SetGFX			;sets missile explosion animation                              
  	b       @@ProjectileCheck                         
@@Immune:    
	mov     r0,r4                         
    	bl      ImmuneNonIce                               
    	mov     r0,r10			;projectile Y                             
    	mov     r1,r9                   ;projectile X
@@GFXRoutines:    
	mov     r2,2Fh			;value for "immune" puff                                 
   	bl      SetGFX			;starts "immune" puff animation                             
    	mov     r0,r4                                   
    	mov     r1,r7			;moves projectile data pointer to r1                                 
    	mov     r2,0Ch			;normal missile value for routine                                 
    	bl      MissileBounce                            
    	b       @@Return                             
@@ProjectileCheck:    
	ldrb    r0,[r7,11h]                       
    	cmp     r0,0h			;checks if missile is active                                
    	bne     @@Set0                       
    	mov     r0,r7			;moves projectile data pointer to r0                                  
    	bl      MissileDecrement	;routine is run if missile was fired at point black range                              
@@Set0:   	
	mov     r0,0h                             
    	strb    r0,[r7]			;sets 0 to projectile status                         
@@Return:    
	pop     r3-r5                           
    	mov     r8,r3                               
    	mov     r9,r4                         
    	mov     r10,r5                               
    	pop     r4-r7                             
    	pop     r0                                   
	bx      r0                                     
.close