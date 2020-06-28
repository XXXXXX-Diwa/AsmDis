.gba
.open "tsed.gba","New Clip.gba",0x8000000

.definelabel SpikeClipNum,0x90
.definelabel SpikeDamage,10
.definelabel KnockbackVelocityX,0x30
.definelabel Air,0x00
.definelabel RightGustClip,0x91
.definelabel LeftGustClip,0x92
.definelabel FanLeft,0x37
.definelabel FanRight,0x38
.definelabel FanUp,0x39
.definelabel FanDown,0x3A
.definelabel Fan,0x3B

.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8

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
	;.halfword 0x5C,0x5D

; new code
.org 0x8304414    ; crocomire graphics
CheckTouchingSpike:
	push    r14
	ldr     r1,=SamusData
; check invincibility
	ldrb    r0,[r1,6]      ; r0 = invincibility timer
	cmp     r0,0
	bhi     @@Return
	push    r4-r6
	ldrh    r2,[r1,0x12]   ; r2 = x position
	ldrh    r3,[r1,0x14]   ; r3 = y position
	ldr     r1,=SamusHitbox
	ldsh    r4,[r1,r0]     ; r4 = left hitbox
	ldrh    r5,[r1,2]      ; r5 = right hitbox
	mov     r0,4
	ldsh    r6,[r1,r0]     ; r6 = top hitbox
	add     r4,r4,r2       ; r4 = left-most position
	add     r5,r5,r2       ; r5 = right-most position
	add     r6,r6,r3       ; r6 = top-most position
	add     r3,1
	sub     r4,1
	add     r5,1
	sub     r6,1
	lsr     r3,r3,6        ; r3 = bottom block
	lsr     r4,r4,6        ; r4 = left block
	lsr     r5,r5,6        ; r5 = right block
	lsr     r6,r6,6        ; r6 = top block
	ldr     r2,=RoomWidth
	ldrh    r2,[r2]        ; r2 = room width
@@CheckLeftSide:
	mov     r1,r2
	mul     r1,r6
	add     r1,r1,r4
	lsl     r1,r1,1
	ldr     r0,=DecompClipdata
	add     r1,r0,r1
	ldrh    r0,[r1]
	cmp     r0,SpikeClipNum
	beq     @@TouchingSpikeRight
	cmp     r4,r5          ; check if horizontal blocks are same
	beq     @@Loop
; check block to right
	add     r0,r1,2
	ldrh    r0,[r0]
	cmp     r0,SpikeClipNum
	beq     @@TouchingSpikeLeft
@@Loop:
	cmp     r6,r3          ; check if lowest block checked
	bcs     @@Done
	add     r6,1           ; add 1 to y block
	b       @@CheckLeftSide
@@TouchingSpikeLeft:
	ldr     r4,=(0x10000 - KnockbackVelocityX)
	b       @@TouchingSpike
@@TouchingSpikeRight:
	mov     r4,KnockbackVelocityX
@@TouchingSpike:
; get damage to deal
	ldr     r2,=Equipment
	ldrb    r1,[r2,0xF]    ; r1 = suit activation
; check for both suits
	mov     r0,0x30
	and     r0,r1
	cmp     r0,0x30
	bne     @@CheckVaria
	mov     r0,(SpikeDamage * 5 / 10)
	b       @@ReduceEnergy
@@CheckVaria:
	mov     r0,0x10
	and     r0,r1
	cmp     r0,0x10
	bne     @@CheckGravity
	mov     r0,(SpikeDamage * 8 / 10)
	b       @@ReduceEnergy
@@CheckGravity:
	mov     r0,0x20
	and     r0,r1
	cmp     r0,0x20
	bne     @@NoSuits
	mov     r0,(SpikeDamage * 7 / 10)
	b       @@ReduceEnergy
@@NoSuits:
	mov     r0,SpikeDamage
@@ReduceEnergy:
	ldrh    r1,[r2,6]
	cmp     r1,r0          ; compare energy and damage
	bls     @@Dead
	sub     r1,r0
	b       @@SetHealth
@@Dead:
	mov     r1,0
@@SetHealth:
	strh    r1,[r2,6]
; knockback
	mov     r0,0xFA
	bl      0x80074E8
; set x velocity
	ldr     r0,=SamusData
	strh    r4,[r0,0x16]
@@Done:
	pop     r4-r6
@@Return:
	ldr     r0,=0x3000C72
	mov     r1,0
	pop     r2
	bx      r2
CheckTouchingClip:
	push    r14
	push    r4-r6
	ldr     r1,=SamusData
	ldrh    r2,[r1,0x12]   ; r2 = x position
	ldrh    r3,[r1,0x14]   ; r3 = y position
	ldr     r1,=SamusHitbox
	mov	r0,0
	ldsh    r4,[r1,r0]     ; r4 = left hitbox
	ldrh    r5,[r1,2]      ; r5 = right hitbox
	mov     r0,4
	ldsh    r6,[r1,r0]     ; r6 = top hitbox
	add     r4,r4,r2       ; r4 = left-most position
	add     r5,r5,r2       ; r5 = right-most position
	add     r6,r6,r3       ; r6 = top-most position
	lsr     r3,r3,6        ; r3 = bottom block
	lsr     r4,r4,6        ; r4 = left block
	lsr     r5,r5,6        ; r5 = right block
	lsr     r6,r6,6        ; r6 = top block
	ldr     r2,=RoomWidth
	ldrh    r2,[r2]        ; r2 = room width
@@CheckLeftSide:
	mov     r1,r2
	mul     r1,r6
	add     r1,r1,r4
	lsl     r1,r1,1
	ldr     r0,=DecompClipdata
	add     r1,r0,r1
	ldrh    r0,[r1]
	cmp		r0,Air
	beq		@@Reset
	cmp     r0,RightGustClip
	beq     @@TouchingRight
	cmp		r0,LeftGustClip
	beq		@@TouchingLeft
	cmp     r4,r5          ; check if horizontal blocks are same
	beq     @@Loop
; check block to right
	add     r0,r1,2
	ldrh    r0,[r0]
	cmp		r0,Air
	beq		@@Reset
	cmp     r0,RightGustClip
	beq     @@TouchingRight
	cmp		r0,LeftGustClip
	beq		@@TouchingLeft

@@Loop:
	cmp     r6,r3          ; check if lowest block checked
	bcs     @@Reset
	add     r6,1           ; add 1 to y block
	b       @@CheckLeftSide
	
@@TouchingRight:
	ldr 	r1,=300152Ch
	ldrb	r0,[r1]			;Load timer
	ldrb	r3,[r1]			;Load timer
	cmp		r0,02Ah			;Check if max increment
	bgt		@@NoIncrementRight
	add		r0,1h			;Increment timer by 1
	strb	r0,[r1]			;Store timer
	
@@NoIncrementRight:	
	ldr		r1,=30013D9h	;Load Speedboost flag
	ldrb	r2,[r1]
	mov		r2,0h			;Set flag to 0
	strb	r2,[r1]			;Store flag
	
	ldr		r1,=SamusData	;Load SamusData
	ldrh	r2,[r1,12h]
	lsr    	r0,r0,1h
	add		r2,r0,r2
	strh	r2,[r1,12h]		;Store x position
	
	ldr		r1,=30013D4h
	ldrb	r2,[r1]
	cmp		r2,22h			;Check for shinespark
	beq		@@AntiSpeedRight
	cmp		r2,26h			;Check for ballspark
	beq		@@AntiSpeedRight
	cmp		r3,028h			;Check again for max increment
	bgt		@@AntiSpeedRight
	b		@@Done
	
@@AntiSpeedRight:
	mov		r0,07h			;Set pose to 'skidding'
	strb	r0,[r1]			;Store pose and cancel shinespark
	b		@@Done

@@TouchingLeft:
	ldr 	r1,=300152Ch
	ldrb	r0,[r1]			;Load timer
	ldrb	r3,[r1]			;Load timer
	cmp		r0,02Ah			;Check if max increment
	bgt		@@NoIncrementLeft
	add		r0,1h			;Increment timer by 1
	strb	r0,[r1]			;Store timer

@@NoIncrementLeft:	
	ldr		r1,=30013D9h	;Load Speedboost flag
	ldrb	r2,[r1]
	mov		r2,0h			;Set flag to 0
	strb	r2,[r1]			;Store flag	
	
	ldr		r1,=SamusData	;Load SamusData
	ldrh	r2,[r1,12h]
	lsr    	r0,r0,1h
	sub		r2,r2,r0
	strh	r2,[r1,12h]		;Store x position
	
	ldr		r1,=30013D4h	;Load Poses
	ldrb	r2,[r1]
	cmp		r2,22h			;Check for shinespark
	beq		@@AntiSpeedLeft
	cmp		r2,26h			;Check for ballspark
	beq		@@AntiSpeedLeft
	cmp		r3,028h			;Check again for max increment
	bgt		@@AntiSpeedLeft
	b		@@Done
	
@@AntiSpeedLeft:
	mov		r0,07h			;Set pose to 'skidding'
	strb	r0,[r1]			;Store pose and cancel shinespark
	b		@@Done
	
@@Reset:
	ldr 	r1,=300152Ch
	mov		r0,0h
	strb	r0,[r1]

@@Done:
	pop     r4-r6
	ldr     r0,=0x3000C72
	mov     r1,0
	pop     r2
	bx      r2
	.pool
CheckBombClip:
	push 	r2,r14
	mov	r4,r0		;projectile slot
	ldrb	r0,[r4,11h]
	cmp 	r0,0		;skip if bomb is spawning
	beq	@@Return	;reset's accel timer for ram slot
	cmp	r0,3h		;skip if bomb detonated
	beq	@@Reset
	ldrh	r0,[r4,8h]	;Bomb Y
	ldrh	r1,[r4,0Ah]	;Bomb X
	lsr     r0,r0,6 
	lsr     r1,r1,6        
	ldr     r2,=RoomWidth
	ldrh    r2,[r2]        
	mul     r2,r0
	add     r2,r2,r1
	lsl     r2,r2,1
	ldr     r0,=DecompClipdata
	add     r1,r0,r2
	ldrh    r0,[r1]		;clipdata the bomb is on
	cmp	r0,FanLeft	;this takes up less space than setting up a loop, so while gross, it's better
	beq	@@FanLeft
	cmp	r0,FanRight
	beq	@@FanRight
	cmp	r0,FanUp
	beq	@@FanUp
	cmp	r0,FanDown
	beq	@@FanDown
	cmp	r0,Fan
	beq	@@Fan
	b	@@Return
.pool
@@FanLeft:
	ldrh	r0,[r4,0Ah]	;bomb X
	bl	FindSlot
	sub	r0,r0,r2
	strh	r0,[r4,0Ah]
	b	@@Return
@@FanRight:
	ldrh	r0,[r4,0Ah]	;bomb X
	bl	FindSlot
	add	r0,r0,r2
	strh	r0,[r4,0Ah]
	b	@@Return
@@FanUp:
	ldrh	r0,[r4,8h]	;bomb Y
	bl	FindSlot
	sub	r0,r0,r2
	strh	r0,[r4,8h]
	b	@@Return
@@FanDown:
	ldrh	r0,[r4,8h]	;bomb Y
	bl	FindSlot
	add	r0,r0,r2
	strh	r0,[r4,8h]
	b	@@Return
@@Fan:	
	mov	r0,1h
	strb	r0,[r4,13h]
	add	r0,1h
	strb	r0,[r4,11h]	;detonate bomb
@@Reset:
	bl	FindSlot
	mov	r0,0h
	strb	r0,[r1]
@@Return:
	pop	r2
	ldrb	r0,[r4,11h]
	pop	r1
	bx	r1


FindSlot:			;this routine is used to give each projectile slot an extra RAM slot for an acceleration timer
	push	r0
	mov	r1,1Ch
	mov	r2,0	
	ldr	r0,=3000A2Ch
@@Continue:
	cmp	r0,r4
	bne	@@Loop
	ldr	r1,=3001610h	;extra ram base (not sure if these are unused in vanilla)
	add	r1,r1,r2	;extra ram address based on projectile slot
	ldrb	r2,[r1]
	cmp	r2,0Ch
	beq	@@Return
	add	r2,1h
	strb	r2,[r1]
	lsr	r2,r2,1h	;slows acceleration
@@Return:
	pop	r0
	bx	r14	

@@Loop:
	add 	r2,1h
	add	r0,r0,r1
	b	@@Continue
.pool

.org 0x8760F80
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
	bne     @@DSwitch
	ldrh    r0,[r1,14h]	;Y position                           
	add     r0,3h                                 
	strh    r0,[r1,14h]                         
	ldrh    r0,[r1,18h] 	;Y velocity                         
	cmp     r0,0B0h                             
	blt     @@DSwitch
	mov     r0,68h                               
	strh    r0,[r1,18h]                             
@@DSwitch:
	cmp     r3,5Bh 		;direction switch, modified to only use with shinesparks                                 
	bne     @@Return
	ldrb	r0,[r1]
	cmp	r0,22h
	beq	@@Speeding
	cmp	r0,26h
	bne	@@Return
@@Speeding:                               
	mov     r0,16h                                
	ldsh    r0,[r1,r0] 	;X velocity                          
	neg     r0,r0		;switches sign of X velocity to match X speed for the proper direction 
	strh	r0,[r1,16h]
	ldrb	r0,[r1,0Eh]
	mov	r3,30h
	eor	r0,r3		;switches direction
	strb    r0,[r1,0Eh]                            
@@Return:
	ldr     r1,=805A82Eh                           
	mov     r15,r1                                 
.pool

; hijack code near end of in-game routine
.org 0x800C6D0
	bl      CheckTouchingClip
	bl		CheckTouchingSpike

;Bomb Processing hijack code
.org 0x8051FFA
	bl      CheckBombCLip
	
; fix clipdata collision table
.org 0x85D91FC + SpikeClipNum
	.byte 1
.org 0x85D91FC + RightGustClip
	.byte 0
.org 0x85D91FC + LeftGustClip
	.byte 0
.org 0x85D91FC + FanLeft
	.byte 0,0,0,0		;blowing fan blocks
	.byte 1			;fan block

; fix clipdata behavior table
.org 0x85D92AC + (SpikeClipNum * 2)
	.halfword 6
.org 0x85D92AC + (RightGustClip * 2)
	.halfword 0
.org 0x85D92AC + (LeftGustClip * 2)
	.halfword 0
.org 0x85D92AC + (FanLeft * 2)
	.halfword 0,0,0,0,0	;all blocks
	
.close
