.gba
.open "zm.gba","ZeroMission.gba",0x8000000

;only seems to be ran when an item sprite is shot
.org 0x80504AC			;r0 = sprite data pointer
	push    r14                                  
	mov     r1,r0		;moves sprite data pointer to r1                            
	mov     r3,r1		;moves sprite data pointer to r3                                
	add     r3,2Bh		;adds 2B, which is stun timer                            
	ldrb    r2,[r3]                                 
	mov     r1,7Fh                                  
	and     r1,r2                                  
	cmp     r1,2h		;checks if enemy is invulnerable?                                  
	bcs     @@Return                               
    	mov     r1,80h                                
    	and     r1,r2                                 
    	mov     r2,2h                                 
    	orr     r1,r2		;if 80, stores 82 to r3. If 0, stores 2                             
    	strb    r1,[r3]                           
@@Return:   
 	pop     r1                                     
    	bx      r1                                  
.close