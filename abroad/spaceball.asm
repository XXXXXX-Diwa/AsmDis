.gba
.open "keepspeed.gba","spaceball.gba",0x8000000

.org 0x800A61E
	ldr r0,=Spaceball
	mov r15,r0
.pool

.org 0x08760E50
Spaceball:
	push r1,r2
	ldr	r2,=300153Fh
	ldrb r0,[r2]
	mov r1,4h
	and r0,r1
	cmp r0,0h
	beq @@notready		;If Spacejump enabled


	
	ldr	r2,=030015E4h
	ldrb r0,[r2]
	cmp r0,0h
	beq @@notunderwater		; if not underwater
	ldr	r2,=300153Fh
	ldrb r0,[r2]
	mov r1,20h
	and r0,r1
	cmp r0,0h
	beq @@notready		;If GravitySuit enabled

@@notunderwater:
	ldr r2,=30013d4h
	ldrb r0,[r2]
	cmp r0,14h
	bne @@notready
	ldrh r0,[r2,18h]
	lsl r0,r0,10h
	asr r0,r0,10h
	ldr r1,=0FFFFFFA0h
	cmp r0,r1
	bgt @@notready
	nop
	ldr	r0,=03001380h
	ldrh r0,[r0]
	mov r1,1h
	and r0,r1
	cmp r0,0h
	beq @@notready
	mov r1,68h
	lsl r1,r1,1h
	strh r1,[r2,18h]
	mov r0,r3
	pop r1,r2
	b	@@return
@@notready:


	pop r1,r2

	mov r0,r3
	add r0,62h
	ldrh r0,[r0]
	sub r0,r5,r0
	strh r0,[r4,18h]
@@return:
	ldr r0,=0800A640h
	mov r15,r0
.pool
.close