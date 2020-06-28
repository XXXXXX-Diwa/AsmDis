.gba
.open "zm.gba","ZeroMission.gba",0x8000000

.definelabel SamusData,0x30013D4


;one of the routines used to deal with damage dealt to a sprite by an ice projectile. 

.org 0x80503A0 			;r0 = sprite data pointer, r1 = damage to be dealt
	push    r4-r6,r14                           
	mov     r3,r0         	;moves sprite data pointer to r3
	lsl     r1,r1,10h                             
	lsr     r1,r1,10h                           
	mov     r6,0h                               
	ldrh    r0,[r3,14h]	;sprite health             
	cmp     r0,r1		;checks if sprite health is less than damage dealt to sprite                               
	bls     @@Kill                            
	sub     r0,r0,r1	;subtracts damage dealt from sprite health                            
	strh    r0,[r3,14h]                           
	mov	r6,0F0h		;return value
	mov     r4,r3           ;moves sprite data pointer to r4                      
	add     r4,32h          ;adds 32, which determins if sprite is a primary or secondary sprite                     
	b       @@Stun                      
@@Kill:
	mov     r5,0h                                
    	strh    r6,[r3,14h]	;stores 0 to sprite health                           
   	mov     r2,r3		;moves sprite data pointer to r2                                  
    	add     r2,32h		;adds 32, which determins if sprite is a primary or secondary sprite                               
    	ldrb    r1,[r2]                                
    	mov     r0,10h                         
   	orr     r0,r1                                
   	strb    r0,[r2]                           
    	mov     r0,r3		;moves sprite data pointer to r0                                  
    	add     r0,30h          ;adds 30, which is an unknown in RAM map                     
    	strb    r5,[r0]                               
   	sub     r0,10h          ;subtracts 10 from sprite address, which gets sprite palette                    
    	strb    r5,[r0]         ;stores 0 to sprite palette                      
    	mov     r1,r3		;moves sprite data pointer to r1                             
    	add     r1,31h          ;adds 31, which is an unknown in RAM map                  
   	ldrb    r0,[r1]                            
    	mov     r4,r2                           
 	cmp     r0,0h		                        
    	beq     @@DeathPose                               
  	ldr     r2,=SamusData                         
 	ldrb    r0,[r2,1h]	;standing flag                             
    	cmp     r0,1h           ;checks if Samus is on the frozen enemy          
    	bne     @@DeathPose                            
    	mov     r0,2h           ;sets flag to 2, making Samus fall                     
   	strb    r0,[r2,1h]                          
    	strb    r5,[r1]                               
@@DeathPose:
 	mov     r0,r3		;moves sprite data pointer to r0                            
   	add     r0,24h          ;adds 24, sprite pose                       
    	mov     r0,62h          ;death pose value                       
   	strb    r0,[r1]         ;stores                       
    	mov 	r1,r3		;moves sprite data pointer to r0  
	add	r1,26h		;adds 26                               
    	mov     r0,1h                                 
   	strb    r0,[r1]		;stores 1 to 26 of Sprite Data                                                      
@@Stun:    
	mov     r2,r3		;moves sprite data pointer to r2                                 
    	add     r2,2Bh          ;adds 2B, which seems to be hurt flash                  
    	ldrb    r1,[r2]                       
    	mov     r0,80h                                 
    	and     r0,r1                                 
    	mov     r1,11h                                
    	orr     r0,r1                                
    	strb    r0,[r2]                               
    	ldrb    r1,[r4]                               
    	mov     r0,2h                                 
    	orr     r0,r1                                   
    	strb    r0,[r4]		;stores 2 to SpriteData+32h, which gives the "stun" effect                          
   	mov     r0,r6                                
    	pop     r4-r6                     
    	pop     r1                                      
	bx	r1		;r0 returns 0 if sprite is dead, F0 otherwise
.pool
.close