.gba
.open "zm.gba","stereoboot.gba",0x8000000
.definelabel stereobootroutine,0x8760d50
.org 0x0800078C
	mov r15,r0

.org 0x080007B8
	.word stereobootroutine

.org stereobootroutine
	mov 	r1,1h
	ldr		r0,=03000004h
	strb	r1,[r0]
	ldr		r0,=0800078Eh
	mov		r15,r0
.pool

.org 0x08074CDC
	mov		r0,1h
.close