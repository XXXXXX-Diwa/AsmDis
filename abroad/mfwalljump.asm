.gba
.open "MFO.gba","mfwalljump.gba",0x8000000
.definelabel newwalljumpcheck,0x879ED00

.org 0x0800728C
	ldr		r0,=newwalljumpcheck
	mov		r15,r0
.pool

.org newwalljumpcheck
	ldrh    r0,[r5,18h]  
	ldrh    r1,[r5,16h]  
	add     r1,r1,r7     
	lsl     r1,r1,10h    
	lsr     r1,r1,10h  
	push 	r2
	ldr		r2,=@continue
	add		r2,1h
	mov 	r14,r2
	ldr		r2,=08068B1Ch
	mov		r15,r2
@continue:
	pop 	r2      
	mov     r1,80h       
	lsl     r1,r1,11h    
	and     r1,r0        
	cmp     r1,0h        
	bne     yeswalljump

	ldrh    r0,[r5,18h]  
	ldrh    r1,[r5,16h]  
	add     r1,r1,r7     
	lsl     r1,r1,10h    
	lsr     r1,r1,10h  
	push 	r2
	mov		r2,64h			; Decrease 64 and walljump window will shorten
	sub		r0,r0,r2
	ldr		r2,=@continue2
	add		r2,1h
	mov 	r14,r2
	ldr		r2,=08068B1Ch
	mov		r15,r2
@continue2:
	pop 	r2      
	mov     r1,80h       
	lsl     r1,r1,11h    
	and     r1,r0        
	cmp     r1,0h        
	bne     yeswalljump

yeswalljump:
	ldr		r0,=080072A4h
	mov		r15,r0
notwalljump:
	ldr		r0,=080072B8h
	mov		r15,r0

.pool
.close