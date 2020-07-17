.gba
.open "zm.gba","rapidfire.gba",0x8000000
;蓄力能力未开启时候连发开火
.org	08007d10h
	mov		r15,r0
.org 08007d30h
	.word	rapidfire

.org 8761000h
rapidfire:
	ldr	r0,=300153Dh
	ldrb	r0,[r0]
	mov		r1,10h
	and		r1,r0
	cmp		r1,0h
	beq		@@nocharge
	ldr 	r0,=03001380h
	ldrh	r1,[r0]
	b		@@end
@@nocharge:
	ldr 	r0,=0300137Ch
	ldrh	r1,[r0]
@@end:
	ldr		r0,=08007d12h
	mov		r15,r0
.pool
.close