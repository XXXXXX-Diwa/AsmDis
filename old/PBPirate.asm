.gba
.open "zm.gba","PBPirate.gba",0x8000000
.definelabel CurrSpriteData,0x3000738
.definelabel CurrRoom,0x3000055

.definelabel EventFunctions,0x80608BC
.definelabel CheckHitWall,0x800F688

.org 0x804B604
	push    r4,r14                                  
	ldr     r0,=CurrRoom                           
	ldrb    r0,[r0]                                 
	add     r0,1h                                   
	lsl     r0,r0,18h                               
	lsr     r2,r0,18h                               
	mov     r4,r2                                   
	ldr     r3,=CurrSpriteData                            
	mov     r0,r3                                   
	add     r0,24h                                  
	ldrb    r0,[r0] 		;pose                                
	cmp     r0,9h                                   
	beq     @@Pose1                               
	cmp     r0,9h                                   
	bgt     @@PoseCheck                           
	cmp     r0,0h                                   
	beq     @@RoomCheck                               
	b       @@Return                                
.pool
@@PoseCheck:
	cmp     r0,23h                                  
	beq     @@Pose2                              
	b       @@Return                              
@@RoomCheck:
	cmp     r2,21h                                
	bne     @@RoomCheck2                             
	mov     r0,3h                                 
	mov     r1,47h    		;checks if pirate was already seen in that room                            
	b       @@EventCheck                            
@@RoomCheck2:
	cmp     r2,2Fh                                  
	bne     @@ForceKill                              
	mov     r0,3h                                   
	mov     r1,48h 			;checks if pirate was already seen in that room                                    
@@EventCheck:
	bl      EventFunctions                               
	lsl     r0,r0,18h                               
	lsr     r3,r0,18h                               
	b       @@CheckSet
@@ForceKill:
	mov     r3,1h 			;if in another room, act as if event is set                                  
@@CheckSet:
	cmp     r3,0h                                   
	beq     @@Initialize		;if event not set, spawn                             
	ldr     r1,=CurrSpriteData                            
	mov     r0,0h                                   
	strh    r0,[r1]			;kills sprite is event is set                                 
	b       @@Return                                
.pool
@@Initialize:
	ldr     r2,=CurrSpriteData                          
	mov     r1,r2                                   
	add     r1,27h                                  
	mov     r0,30h                                  
	strb    r0,[r1]			;27h                                 
	mov     r0,r2                                   
	add     r0,28h                                  
	strb    r3,[r0] 		;28h                                
	add     r1,2h                                   
	mov     r0,20h                                  
	strb    r0,[r1]			;29h                                 
	mov     r1,0h                                   
	strh    r3,[r2,0Ah]                             
	strh    r3,[r2,0Ch]                             
	strh    r3,[r2,0Eh]                             
	strh    r3,[r2,10h]     	;0 to all boundaries                         
	ldr     r0,=82E4970h		;OAM Pointer                            
	str     r0,[r2,18h]                             
	strb    r1,[r2,1Ch]                             
	strh    r3,[r2,16h]                             
	mov     r0,r2                                   
	add     r0,25h                                  
	strb    r1,[r0]			;cannot hurt Samus                                 
	mov     r1,r2                                   
	add     r1,24h                                  
	mov     r0,9h                                   
	strb    r0,[r1] 		;stores pose 9                                
	ldrh    r0,[r2]                                 
	mov     r3,90h                                  
	lsl     r3,r3,2h 		;240h                               
	mov     r1,r3                                   
	orr     r0,r1                                   
	strh    r0,[r2] 		;adds 40 (flip flag) and 200h flag                                
	b       @@Return                               
.pool
@@Pose1:
	ldrh    r1,[r3] 		;sprite status                                
	mov     r0,2h                                   
	and     r0,r1 			;checks if sprite is onscreen                                  
	cmp     r0,0h                                   
	beq     @@Return                             
	cmp     r2,21h    		;room ID + 1                               
	bne     @@RoomCheck3                               
	mov     r0,1h                                   
	mov     r1,47h    		;sets event based on room                               
	bl      EventFunctions                             
	b       @@NextPose                              
@@RoomCheck3:
	cmp     r4,2Fh			;Room ID + 1                                  
	bne     @@NextPose                             
	mov     r0,1h                                   
	mov     r1,48h      		;sets event based on room                               	
	bl      EventFunctions                               
@@NextPose:
	ldr     r2,=CurrSpriteData                          
	mov     r0,r2                                   
	add     r0,24h                                  
	mov     r1,23h                                  
	strb    r1,[r0]			;stores pose 23                                 
	ldrb    r0,[r2,1Ch] 		;animation counter                            
	cmp     r0,5h                                   
	bls     @@Return                                
	ldrh    r1,[r2,16h]                             
	mov     r0,3h                                   
	and     r0,r1                                   
	cmp     r0,0h                                   
	bne     @@Return                               
	ldr     r0,=165h 		;used to play footstep sound based on animation frame                                
	bl      8002B20h                               
	b       @@Return                               
.pool

@@Pose2:
	ldrb    r0,[r3,1Ch]  		;animation counter                           
	cmp     r0,5h                                   
	bls     @@FlagCheck                             
	ldrh    r1,[r3,16h]   		                        
	mov     r0,3h                                   
	and     r0,r1                                   
	cmp     r0,0h                                   
	bne     @@FlagCheck                             
	ldrh    r1,[r3]                                 
	mov     r0,2h                                   
	and     r0,r1                                   
	cmp     r0,0h  			;checks if onscreen                                 
	beq     @@FlagCheck                             
	ldr     r0,=165h 		;used to play footstep sound based on animation frame                                 
	bl      8002B20h                                
@@FlagCheck:
	ldr	r2,=CurrSpriteData                           
	ldrh    r1,[r2]                                 
	mov     r0,80h                                  
	lsl     r0,r0,2h                                
	and     r0,r1                                   
	mov     r4,r2                                   
	cmp     r0,0h  			;checks for 200h flag                                 
	beq     @@Branch12 		;will never be true in vanilla                             
	ldrh    r1,[r4,4h]		;Sprite X                              
	mov     r0,r1                                   
	add     r0,40h                                  
	lsl     r0,r0,10h                               
	lsr     r2,r0,10h                               
	add     r1,4h  			;moves 1 pixel per frame                                 
	b       @@Move                                
.pool
@@Branch12:				;doesn't look like this is ever run as 200h is always set when the sprite spawns
	ldrh    r1,[r4,4h] 		;Sprite X                             
	mov     r0,r1                                   
	sub     r0,40h                                  
	lsl     r0,r0,10h                               
	lsr     r2,r0,10h                               
	sub     r1,4h                                   
@@Move:
	strh    r1,[r4,4h]                             
	ldrh    r0,[r4,2h]                             
	sub     r0,40h                                 
	mov     r1,r2 			;sprite X plus 40 (1 block)                                 
	bl      CheckHitWall                    
	ldr     r0,=30007F1h                           
	ldrb    r0,[r0]                                
	cmp     r0,11h                                 
	bne     @@Return                               
	ldr     r0,=30000DCh                           
	ldrh    r0,[r0]			;somehow checks if pirate zonline?                                
	cmp     r0,8h                                  
	bne     @@Return                               
	mov     r0,0h                                   
	strh    r0,[r4]                                 
@@Return:
	pop     r4                                      
	pop     r0                                      
	bx      r0                                      
.pool
.close