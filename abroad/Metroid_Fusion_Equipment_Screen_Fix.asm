; Written by Kazuto

.gba
.open "Metroid Fusion (U).gba","Metroid Fusion Equipment Fix.gba",0x08000000

; Code for Beams/Suits (Section always visible)
.org 0x0807e886
    ldr     r0,[sp,0x04]
    add     r0,r9
.org 0x0807e8b4
.area 0x0807e8c4-.
    mov     r3,r2
    mov     r2,0x01
    add     r9,r2
    ldr     r1,[sp,0x14]
    ldrb    r0,[r1]
    mov     r2,r8
    sub     r0,r0,r2
    mov     r2,r3
.endarea

; Code for Missiles (Section only shows w/collected item)
.org 0x0807e99a
	ldr     r0,=0x0857617a
.org 0x0807e9a4
	ldr     r1,=0x0858217c
.org 0x0807e9ac
	ldr     r0,=0x085821b3
.org 0x0807e9d6
	ldr     r1,=0x085821b3
.org 0x0807e9e4
	ldr     r0,=0x0879bea8
.org 0x0807e9f4
	beq     0x0807ea4c
    ldr     r0,[sp,0x04]
	add     r0,0x01
	str     r0,[sp,0x04]
	ldr     r3,[sp,0x14]
	ldrb    r0,[r3,0x00]
	mov     r1,r9
	sub     r0,r0,r1
	ldr     r0,=0x0858217f
.org 0x0807ea14
	ldr     r6,=0x0600c800
.org 0x0807ea2e
	mov     r6,0x20
	add     r12,r6
	b       0x0807ea50
.pool
.org 0x0807ea4c
	cmp     r2,0x00
	beq     0x0807eab8

; Code for Misc (Section only shows w/collected item)
.org 0x0807eaf6
    ldr     r0,=0x0857617a
.org 0x0807eb02
    ldr     r1,=0x0858217c
.org 0x0807eb0a
    ldr     r3,=0x085821b3
.org 0x0807eb30
.area 0x0807eb9c-.
    mov     r5,0x00
@@itemLoop:
    ldr     r1,[sp,0x08]
    add     r0,r1,r5
    lsl     r0,r0,0x05
    add     r6,r0,r7
    mov     r3,r10
    add     r0,r2,r3
    ldrb    r0,[r0]
    add     r0,0x01
    add     r0,r0,r4
    lsl     r0,r0,0x05
    ldr     r1,[sp,0x0c]
    add     r3,r0,r1
    ldr     r0,=0x0879bea8
    add     r0,r9
    ldr     r0,[r0]
    add     r0,r0,r4
    ldrb    r0,[r0]
    ldr     r1,[sp]
    and     r0,r1
    add     r4,0x01
    cmp     r0,0x00
    beq     @@incrementLoop
    add     r5,0x01
    str     r5,[sp,0x04]
    ldr     r1,[sp,0x10]
    push    r4
    ldr     r4,=0x0858217f
    add     r0,r1,r4
    ldrb    r1,[r0]
    mov     r4,r12
    ldrb    r0,[r4]
    sub     r1,r1,r0
    lsl     r0,r3,0x01
    ldr     r3,=0x0600c800
    add     r4,r0,r3
    lsl     r0,r6,0x01
    add     r3,r0,r3
    add     r1,0x01
@@drawLoop:
    ldrh    r0,[r4]
    strh    r0,[r3]
    add     r4,0x02
    add     r3,0x02
    sub     r1,0x01
    cmp     r1,0x00
    bne     @@drawLoop
    pop     r4
@@incrementLoop:
    ldr     r0,=0x0857617a
    add     r0,r8
    ldrb    r0,[r0]
    cmp     r4,r0
    blt     @@itemLoop
    b       0x0807eb9c
.fill 0x0807eb9c-.
.endarea
.org 0x0807eba4
    ldr     r1,=0x0858217c
.org 0x0807ebb6
    ldr     r0,=0x085821b3
.org 0x0807ebc2
    ldr     r0,=0x085821b3
.org 0x0807ebca
    ldr     r3,=0x0858217f
.org 0x0807ebf8
.area 0x0807ec10-.
.pool
.endarea

.close
