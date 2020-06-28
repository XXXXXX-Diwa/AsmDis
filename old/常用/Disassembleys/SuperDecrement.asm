.gba
.open "zm.gba","ZeroMission.gba",0x8000000

.definelabel Equipment,0x3001530	
.definelabel SamusWeaponInfo,0x3001414	

;run when firing a missile, decrements missile count
.org 0x8051CC4
	push    r14			;r0 = Projectile Data Pointer                                    
    	mov     r3,r0			;moves projectile data pointer to r3                        
   	ldr     r1,=Equipment                        
    	ldrb    r0,[r1,0Ah]		;current number of supers                         
    	cmp     r0,0h			;checks if none                            
    	beq     @@Branch                           
    	sub     r0,1h			;subtracts 1 super                                 
    	strb    r0,[r1,0Ah]		;stores new value                          
    	lsl     r0,r0,18h                            
    	cmp     r0,0h                                
    	bne     @@Branch1                          
    	ldr     r0,=SamusWeaponInfo            
    	ldrb    r1,[r0,2h]		;new projectile value                    
    	mov     r2,2h                             
    	eor     r1,r2                            
    	strb    r1,[r0,2h]                            
@@Branch:   
	mov     r0,40h                    
    	strb    r0,[r3,12h]		;stores 40h to projectile category                            
    	ldrb    r1,[r3]			;projectile status                               
    	mov     r0,0FBh                          
    	and     r0,r1                                 
    	strb    r0,[r3]			;gets rid of update GFX bit                           
    	pop     r0                                   
    	bx      r0                                   
.pool
.close