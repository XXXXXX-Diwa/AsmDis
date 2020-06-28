.gba
.open "zm.gba","ZeroMission.gba",0x8000000


;accessed when a normal and super missile bounce off an enemy

.org 0x8050914 
	push    r4-r6,r14		;r0 = Sprite Data Pointer r1 = projctile status, r2 = C is missile, D is super Missile                              
    	mov     r4,r1			;moves projectile status to r4                                  
    	lsl     r2,r2,18h                   
    	lsr     r5,r2,18h                        
    	mov     r6,0h                             
    	mov     r2,0h                                
    	mov     r1,7h                                 
    	strb    r1,[r4,11h]		;stores 7 to projectile movement stage                       
    	strb    r2,[r4,13h]		;stores 0 to projectile counter/timer		                         
    	ldrb    r1,[r4]			                                
    	mov     r3,0EFh			;makes projectile inactive                               
    	and     r3,r1                             
    	mov     r1,8h						                                
    	orr     r3,r1			;adds no collision bit to projectile                                 
    	orr     r3,r6                                  
    	strb    r3,[r4]			;stores new status to projectile                               
    	strb    r2,[r4,0Eh]		;sets 0 to projectile animation counter                            
    	strh    r2,[r4,0Ch]		;sets 0 to animation frame                          
    	ldrh    r1,[r4,0Ah]		;projectile X pos                         
    	ldrh    r0,[r0,4h]		;sprite X pos                        
    	cmp     r1,r0			;checks if projectile X is lower than sprite's X pos	                                   
    	bls     @@Less                                
    	mov     r0,40h                                  
    	orr     r3,r0                                 
    	b       @@MissileType                                
@@Less:    
	mov     r0,0BFh                               
	and     r3,r0                                   
@@MissileType:    
	strb    r3,[r4]			                                 
    	cmp     r5,0Dh			;checks if super missile                               
    	bne     @@Missile                               
    	ldr     r0,=8327018h		;Super missile GFX?                           
    	str     r0,[r4,4h]		;stores to projectile GFX offset                              
    	mov     r0,0FCh                                
    	bl      8002A28h                               
    	b       @@Return                             
.pool
@@Missile:    
	ldr     r0,=8326FD0h		;Missile GFX?                           
    	str     r0,[r4,4h]		;stores to projectile GFX offset                               
    	mov     r0,0F9h                                
    	bl      8002A28h                              
@@Return:    
	pop     r4-r6                               
    	pop     r0                                
    	bx      r0                                      
.pool
.close