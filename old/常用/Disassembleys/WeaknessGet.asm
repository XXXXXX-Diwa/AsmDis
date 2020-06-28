.gba
.open "zm.gba","ZeroMission.gba",0x8000000

;Routine used to get an enemy's weakness value
.org 0x8050370			;r0 = Sprite Data Pointer  
	push    r14                                   
	mov     r3,r0		;moves sprite data pointer to r3                        
    	add     r0,32h          ;adds 32 to get collision properties                
    	ldrb    r1,[r0]                                 
    	mov     r0,80h                                
    	and     r0,r1                                   
    	cmp     r0,0h		;checks if sprite is primary or secondary                                
    	beq     @@Primary                          
    	ldr     r2,=82B1BE4h	;base address needed to determine weakness for secondary sprites                     
    	b       @@WeaknessGet                          
.pool
@@Primary:    
	ldr     r2,=82B0D68h	;base address needed to determine weakness for primary sprites                            
@@WeaknessGet:    
	ldrb    r1,[r3,1Dh]	;Sprite ID                            
   	lsl     r0,r1,3h                               
   	add     r0,r0,r1                              
    	lsl     r0,r0,1h                             
   	add     r2,4h                              
    	add     r0,r0,r2	;math to get weakness value                              
    	ldrh    r0,[r0]         ;loads sprite weakness value                 
    	pop     r1                                     
    	bx      r1		;r0 returns Sprite Weakness Value                                     
.pool
.close