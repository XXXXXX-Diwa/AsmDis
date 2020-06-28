 .gba
.open "zm.gba","Cliphax.gba",0x8000000


;Cliphax is originally created by Trunaur68, disassembled and slightly modified by CaptGlitch
;All of the shinespark related clipdata are pretty buggy, I wouldn't suggest using them.

;-Clipdata 98 is a low gravity square
;-Clipdata 99 is a high gravity square
;-Clipdata 9A is a floor that slides you right
;-Clipdata 9B is a floor that slides you left
;-Clipdata 9C is quicksand
;-Clipdata 9D is Shinespark Reversal (Buggy with diagonal sparks, so use is severely limited)
;-Clipdata 9E is Shinespark Accel (can break scrolls) 
;-Clipdata 9F is Shinespark Decel (due to hitting the block multiple times before fully passing though it,
;the shinespark is slowed to a crawl. Diagonal sparking though the blocks slow it enough to stop the spark)

.definelabel SamusData,0x30013D4

.org 0x805A824			;hijack
	ldr r1,=Freespace
	mov r15,r1
.pool
	nop

.org 0x85D9296			;clipdata collision types
	.byte 1,1,0xC
.org 0x85D93DC			;clipdata behavior types
	.halfword 0x56,0x57,0x58
	.halfword 0x59,0x5A,0x5B
	.halfword 0x5C,0x5D


.org 0x8760D38
Freespace:
	mov     r2,r8		;pointer to tiletable                                   
	ldr     r1,[r2,8h]	;clipdata behavior types                              
	lsl     r0,r0,1h                                
	add     r0,r0,r1                                
	ldrh    r3,[r0]                                
	ldr     r1,=SamusData                          
	cmp     r3,56h 		;low gravity                                 
	bne     @@HeavyGrav                              
	ldrh    r0,[r1,18h]	;Y Velocity                           
	add     r0,4h                                
	strh    r0,[r1,18h]                            
@@HeavyGrav:
	cmp     r3,57h		;heavy gravity                                 
	bne     @@RTread
	ldrh    r0,[r1,18h]  	;Y Velocity                        
	sub     r0,4h                                  
	strh    r0,[r1,18h]                            
@@RTread:
	cmp     r3,58h 		;rightward treadmill                               
	bne     @@LTread
	ldrh    r0,[r1,12h]	;X position                            
	add     r0,4h                                 
	strh    r0,[r1,12h]                            
@@LTread:
	cmp     r3,59h		;leftward treadmill                               
	bne     @@Quicksand
	ldrh    r0,[r1,12h]	;X position                           
	sub     r0,4h                              
	strh    r0,[r1,12h]                          
@@Quicksand:
	cmp     r3,5Ah		;quicksand                                
	bne     @@Return
	ldrh    r0,[r1,14h]	;Y position                           
	add     r0,2h                                 
	strh    r0,[r1,14h]                         
	ldrh    r0,[r1,18h] 	;Y velocity                         
	cmp     r0,0B0h                             
	blt     @@Return
	mov     r0,68h                               
	strh    r0,[r1,18h]                                                        
@@Return:
	ldr     r1,=805A82Eh                           
	mov     r15,r1                                 
.pool
.close