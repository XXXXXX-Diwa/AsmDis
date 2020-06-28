.gba
.open "zm.gba","laserreturn.gba",0x8000000

.definelabel PlaySound,0x8002A18
	
.org 8038116h
    bne 80381c6h
	
.org 8037f38h
    mov r1,1h
    ldr r0,=3000738h
    strh r1,[r0,14h]
	b 803800eh
.pool	

.org 80380e8h
    push lr
    ldr r2,=3000738h
	mov r0,r2
	add r0,26h
	mov r1,1h
	strb r1,[r0]                                            
    bl cafe
    pop r0
    bx r0	
.pool	
	
.org 8304054h
cafe:
    push lr
    ldr r1,=30001A8h
    ldrh r0,[r1]
	cmp r0,0h
	bne @@end
    mov r1,r2
	add r1,24h
	mov r0,0ch
	strb r0,[r1]
	ldrb r0,[r2]
	mov r1,4h
	eor r1,r0
	strb r1,[r2]
	ldr r0,=11dh
	bl PlaySound
@@end:	
    pop r14	
 
.pool
.close 
;285 适合返回音
;289 下雨