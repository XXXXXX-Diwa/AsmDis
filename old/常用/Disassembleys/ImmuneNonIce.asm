.gba
.open "zm.gba","ZeroMission.gba",0x8000000

;Ran when an enemy is immune to a non-ice projectile
;essentially adds three to sprite's stun/invulnerability if not already invincible  

.org 0x80504CC			;r0 = Sprite Data Pointer 
	push    r14                                     
  	mov     r1,r0		;moves sprite data pointer to r1                                
	mov     r3,r1		;moves sprite data pointer to r3                                    
	add     r3,2Bh		;adds 2B, which is stun timer                                
	ldrb    r2,[r3]                               
	mov     r1,7Fh                                
 	and     r1,r2                                
  	cmp     r1,3h		;checks if enemy is invulnerable?                                  
   	bcs     @@Return                                
    	mov     r1,80h                                  
    	and     r1,r2		                                   
    	mov     r2,3h                                   
    	orr     r1,r2		;if 80, stores 83 to r3. If 0, stores 3                                   
    	strb    r1,[r3]                               
@@Return:  
	pop     r1		                                      
	bx      r1                                      
.close