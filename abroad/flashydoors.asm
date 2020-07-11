.gba
.open "zm.gba","flashydoors.gba",0x8000000

.org 0x85e042C
	.import "085e042C.palette"
.org 0x85e022C
	.import "085e022C.palette"

.org 0x08056FB8
	.word flashroutine
.org 0x8056F10
	mov	r15,r0

.org 0x8761000
flashroutine:
;	ldr		r0,=3000054h
;	ldrb	r0,[r0]
;	cmp		r0,5h
;	bne		@@dontskipflash
;	ldr		r0,=3000055h
;	ldrb	r0,[r0]
;	cmp		r0,8h
;	beq		@@return
	
@@dontskipflash:
	ldr     r0,=30054E4h
	ldrb    r0,[r0]     
    lsl     r0,r0,18h   
    asr     r0,r0,18h   
    cmp     r0,0h       
    beq     @@doorsnotunlocked
@@skipflash:
	ldr		r0,=08056F1Ah
	mov		r15,r0

@@doorsnotunlocked:
	ldr     r1,=30056F0h
    ldrb    r0,[r1]     
    add     r0,1h       
    mov     r2,0h       
    strb    r0,[r1]     
    lsl     r0,r0,18h   
    lsr     r0,r0,18h   
    cmp     r0,7h       
    bls     @@return    
    strb    r2,[r1]     
    ldrb    r0,[r1,1h]  
    add     r0,1h       
    strb    r0,[r1,1h]  
    lsl     r0,r0,18h   
    asr     r0,r0,18h   
    cmp     r0,5h       
    ble     @@dontreset    
    strb    r2,[r1,1h]
@@dontreset:
    ldrb    r1,[r1,1h]  
    lsl     r1,r1,18h   
    asr     r1,r1,18h   
    lsl     r1,r1,5h    
    add     r1,10h      
    add     r1,r4,r1    
    ldr     r2,=5000030h
	push	r4
	ldr		r0,=@@returnlink
	add		r0,1h
	mov		r14,r0
	ldr		r0,=080031E4h
	mov		r4,r0

    mov     r0,10h     
    str     r0,[sp]
    mov     r0,3h       
    mov     r3,0x10
	mov		r15,r4
@@returnlink:
	pop		r4
@@return:
	ldr		r0,=0x30054e4
	ldrb	r0,[r0,0x1]
	lsl		r0,r0,0x18
	asr		r0,r0,0x18
	cmp		r0,0x0
	beq		@@fullreturn
@@writesecondbgp2:
	ldr		r0,=08056F64h
	mov		r15,r0
@@fullreturn:
	ldr		r0,=08056FA0h
	mov		r15,r0

.pool
.close