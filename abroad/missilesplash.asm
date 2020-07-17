.gba
.open "zm.gba","missilesplash.gba",0x8000000

.definelabel Air,0x00


.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8
.definelabel ProjectileData,0x3000A2C

;eliminate vanilla damage
.org 0x08050A30
	mov	r1,0x00         ; was 14
.org 0x08050ACC
	mov	r1,0x00         ; was 64

.org 0x804fd88
	bl	missilehitblockwrapper
.org 0x804fcf2
	strh	r0,[r2]
.org  0x8051C00
	bl	missilehitblockwrapper
.org  0x8050A6A
	bl 	missilehitspritewrapper
.org  0x8051d50
	bl	missilehitblockwrapper
.org  0x8050B06
	bl 	missilehitspritewrapper

.org 0x8304054    ; crocomire graphics
missilehitblockwrapper:
	ldr		r0,=missilehitblock
	mov		r15,r0
missilehitspritewrapper:
	ldr		r0,=missilehitsprite
	mov		r15,r0
.pool

.org 0x8761000
missilehitblock:
	push	r14
	push	r4-r6
	push 	r7
	mov		r1,r4
	push	r1
	mov		r2,r1
	add		r1,0xf
	ldrb	r0,[r1]
	cmp		r0,0xD
	beq		@@super
	cmp		r0,0xC
	bne		@@continue2
	ldr     r0,=0FFC0h      ;
    strh    r0,[r2,14h]     ;
    strh    r0,[r2,18h]     ;
    mov     r1,40h          ;
    strh    r1,[r2,16h]     ;
    strh    r1,[r2,1Ah]     ;
	pop		r1
	push	r1
	bl		checkmissiletouchingsprites
	b		@@continue
@@super:
	ldr     r0,=0FFa0h      ;
    strh    r0,[r2,14h]     ;
    strh    r0,[r2,18h]     ;
    mov     r1,60h          ;
    strh    r1,[r2,16h]     ;
    strh    r1,[r2,1Ah]     ;
	pop		r1
	push	r1
	bl		checksupertouchingsprites
	b		@@continue
@@continue:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xD
	beq		@@supersplash
	bl		clipsplash
	b		@@continue2
@@supersplash:
	bl		superclipsplash
	b		@@continue2
@@continue2:
	pop		r1
	push	r1
	mov		r0,0h
	strh	r0,[r1]
	pop		r1
	pop		r7
	pop     r4-r6
	pop     r2
	bx      r2
.pool

missilehitsprite:
	push	r14
	push	r4-r6
	push 	r7
	mov		r1,r7
	push	r1
	mov		r2,r1
	add		r1,0xf
	ldrb	r0,[r1]
	cmp		r0,0xD
	beq		@@super
	cmp		r0,0xC
	bne		@@continue2
	ldr     r0,=0FFC0h      ;
    strh    r0,[r2,14h]     ;
    strh    r0,[r2,18h]     ;
    mov     r1,40h          ;
    strh    r1,[r2,16h]     ;
    strh    r1,[r2,1Ah]     ;
	pop		r1
	push	r1
	bl		checkmissiletouchingsprites
	b		@@continue
@@super:
	ldr     r0,=0FFA0h      ;
    strh    r0,[r2,14h]     ;
    strh    r0,[r2,18h]     ;
    mov     r1,60h          ;
    strh    r1,[r2,16h]     ;
    strh    r1,[r2,1Ah]     ;
	pop		r1
	push	r1
	bl		checksupertouchingsprites
	b		@@continue
@@continue:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xD
	beq		@@supersplash
	bl		clipsplash
	b		@@continue2
@@supersplash:
	bl		superclipsplash
	b		@@continue2
@@continue2:
	pop		r1
	push	r1
	mov		r0,0h
	strh	r0,[r1]
	pop		r1
	pop		r7
	pop     r4-r6
	pop     r2
	bx      r2
.pool



superclipsplash:
	push	r14
	mov		r4,r1

	ldrh	r0,[r4,0xA]
	push	r0
	ldrh	r0,[r4,0x8]
	push	r0

	ldrh	r0,[r4,0x8]
	add		r0,40h
	strh	r0,[r4,0x8]
	bl		clipsubroutine     ; down 1

	ldrh	r0,[r4,0x8]
	add		r0,40h
	strh	r0,[r4,0x8]
	ldrh	r0,[r4,0xA]
	sub		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; down 1 left 1

	ldrh	r0,[r4,0x8]
	add		r0,40h
	strh	r0,[r4,0x8]
	ldrh	r0,[r4,0xA]
	add		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; down 1 right 1

	ldrh	r0,[r4,0x8]
	sub		r0,40h
	strh	r0,[r4,0x8]
	bl		clipsubroutine     ; up 1

	ldrh	r0,[r4,0x8]
	sub		r0,40h
	strh	r0,[r4,0x8]
	ldrh	r0,[r4,0xA]
	sub		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; up 1 left 1

	ldrh	r0,[r4,0x8]
	sub		r0,40h
	strh	r0,[r4,0x8]
	ldrh	r0,[r4,0xA]
	add		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; up 1 right 1




	ldrh	r0,[r4,0xA]
	sub		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; left 1
;
	ldrh	r0,[r4,0xA]
	add		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; right 1

	
	pop		r0
	strh	r0,[r4,0x8]
	pop		r0
	strh	r0,[r4,0xA]
	pop		r14
	bx		r14

clipsplash:
	push	r14
	mov		r4,r1
	ldrh	r0,[r4,0xA]
	push	r0
	ldrh	r0,[r4,0x8]
	push	r0
	add		r0,40h
	strh	r0,[r4,0x8]
	bl		clipsubroutine     ; down 1

	ldrh	r0,[r4,0x8]
	sub		r0,40h
	strh	r0,[r4,0x8]
	bl		clipsubroutine     ; up 1


	ldrh	r0,[r4,0xA]
	sub		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; left 1
;
	ldrh	r0,[r4,0xA]
	add		r0,40h
	strh	r0,[r4,0xA]
	bl		clipsubroutine     ; right 1

	
	pop		r0
	strh	r0,[r4,0x8]
	pop		r0
	strh	r0,[r4,0xA]
	pop		r14
	bx		r14

resetpositions:
	push	r14
	mov		r0,sp
	add		r0,0xC
	ldrh	r1,[r0]
	strh	r1,[r4,0x8]
	ldrh	r1,[r0,0x4]
	strh	r1,[r4,0xA]
	pop		r14
	bx		r14

clipsubroutine:
	push	r14
	push	r4
	ldrh	r0,[r4,0x8]
	lsl		r0,r0,0x10
	asr		r0,r0,0x10
	cmp		r0,0h
	bls		@@cliplink
	ldr     r0,=3000079h
    mov     r1,9h       
    strb    r1,[r0]
	ldr		r1,=@@cliplink
	add		r1,1h
	mov		r14,r1
    mov     r0,r4       
    ldr		r1,=804FA3Ch    
	mov		r15,r1
@@cliplink:
	bl		resetpositions
	pop		r4
	pop		r14
	bx		r14

.pool














checkmissiletouchingsprites:
	push	r14
	push	r1


@@continue:
	ldrh	r2,[r1,0xA] ;r2=x position
	ldrh	r3,[r1,0x8] ;r3=y position
	add		r1,0x14
	ldrh	r4,[r1,0x4]		;left hitbox
	lsl		r4,r4,10h
	asr		r4,r4,10h
	ldrh	r5,[r1,0x6]		;right hitbox

	ldrh	r6,[r1] 		;top hitbox
	lsl		r6,r6,10h
	asr		r6,r6,10h
	ldrh	r7,[r1,0x2]		;bottom hitbox
	add		r4,r4,r2		;left
	add		r5,r5,r2		;right
	add		r6,r6,r3		;top
	add		r7,r7,r3		;bottom
	ldr		r3,=30001ACh
@@spriteloop:
	ldrh	r0,[r3]
	mov		r1,0x1
	and		r1,r0
	cmp		r1,0h
	beq		@@endofloop
	mov		r0,r3
	add		r0,0x32
	ldrb	r0,[r0]
	mov		r1,0x8
	and		r0,r1
	cmp		r0,0h
	bne		@@endofloop
	mov		r1,0x40
	and		r0,r1
	cmp		r0,0h
	bne		@@endofloop
	bl		getspriteweakness
	mov		r1,0x8
	and		r1,r0
	cmp		r1,0h
	beq		@@endofloop


	bl		gettopbottomspritehitbox

	cmp		r1,r7           ;if top of sprite hitbox is less than bottom of proj hitbox
	bhi		@@spritebelow
	cmp		r6,r2
	bhi		@@spriteabove
	bl		getleftrightspritehitbox
	cmp		r1,r5
	bhi		@@spriteright
	cmp		r4,r2
	bhi		@@spriteleft
	pop		r1
	push	r1
	bl		dospritedamage

	
@@spritebelow:
@@spriteabove:
@@spriteright:
@@spriteleft:
@@endofloop:
	add		r3,0x38
	ldr		r2,=0x3000738
	cmp		r2,r3
	bhi		@@spriteloop

@@return:
	pop		r1
	pop		r0
	bx		r0

checksupertouchingsprites:
	push	r14
	push	r1


@@continue:
	ldrh	r2,[r1,0xA] ;r2=x position
	ldrh	r3,[r1,0x8] ;r3=y position
	add		r1,0x14
	ldrh	r4,[r1,0x4]		;left hitbox
	lsl		r4,r4,10h
	asr		r4,r4,10h
	ldrh	r5,[r1,0x6]		;right hitbox

	ldrh	r6,[r1] 		;top hitbox
	lsl		r6,r6,10h
	asr		r6,r6,10h
	ldrh	r7,[r1,0x2]		;bottom hitbox
	add		r4,r4,r2		;left
	add		r5,r5,r2		;right
	add		r6,r6,r3		;top
	add		r7,r7,r3		;bottom
	ldr		r3,=30001ACh
@@spriteloop:
	ldrh	r0,[r3]
	mov		r1,0x1
	and		r1,r0
	cmp		r1,0h
	beq		@@endofloop
	mov		r0,r3
	add		r0,0x32
	ldrb	r0,[r0]
	mov		r1,0x8
	and		r0,r1
	cmp		r0,0h
	bne		@@endofloop
	mov		r1,0x40
	and		r0,r1
	cmp		r0,0h
	bne		@@endofloop
	bl		getspriteweakness
	mov		r1,0xC
	and		r1,r0
	cmp		r1,0h
	beq		@@endofloop


	bl		gettopbottomspritehitbox

	cmp		r1,r7           ;if top of sprite hitbox is less than bottom of proj hitbox
	bhi		@@spritebelow
	cmp		r6,r2
	bhi		@@spriteabove
	bl		getleftrightspritehitbox
	cmp		r1,r5
	bhi		@@spriteright
	cmp		r4,r2
	bhi		@@spriteleft
	pop		r1
	push	r1
	bl		dospritedamage

	
@@spritebelow:
@@spriteabove:
@@spriteright:
@@spriteleft:
@@endofloop:
	add		r3,0x38
	ldr		r2,=0x3000738
	cmp		r2,r3
	bhi		@@spriteloop
@@return:
	pop		r1
	pop		r0
	bx		r0



getspriteweakness:
	push	r14
	mov		r0,r3
	ldr		r1,=@@getweaknesslink
	add		r1,1
	mov		r14,r1
	ldr		r1,=0x8050370
	mov		r15,r1
@@getweaknesslink:
	lsl     r0,r0,10h
    lsr     r0,r0,10h
	pop		r1
	bx		r1


dospritedamage:
	push	r14
	push	r1
	push	r3
	add		r1,0xf
	ldrb	r0,[r1]
	cmp		r0,0xD
	bne		@@regulardamage
	mov		r1,0x64
	b		@@dosubroutine
@@regulardamage:
	mov		r1,0x14
@@dosubroutine:
	mov		r0,r3
	ldr		r2,=@@damagelink
	add		r2,0x1
	mov		r14,r2
	ldr		r2,=0x8050424
	mov		r15,r2
@@damagelink:
	pop		r3
	push	r3
	ldrh	r0,[r3,0x8]
	ldrh	r1,[r3,0xA]
	mov		r2,0x30
	ldr		r3,=@@gfxlink
	add		r3,1
	mov		r14,r3
	ldr		r3,=0x80540EC
	mov		r15,r3
@@gfxlink:

	pop		r3
	pop		r1
	pop		r14
	bx		r14
	

gettopbottomspritehitbox:		;r3=spritepointer, returns r1=tophitbox r2=bottomhitbox
	push	r14
	ldrh	r0,[r3,0x2]
	ldrh	r1,[r3,0xA]
	ldrh	r2,[r3,0xC]
	lsl		r1,r1,0x10
	asr		r1,r1,0x10
	add		r1,r1,r0
	add		r2,r2,r0
	pop		r14
	bx		r14

getleftrightspritehitbox:   	;r3=spritepointer, returns r1=lefthitbox r2=righthitbox
	push	r14
	ldrh	r0,[r3,0x4]
	ldrh	r1,[r3,0xE]
	ldrh	r2,[r3,0x10]
	lsl		r1,r1,0x10
	asr		r1,r1,0x10
	add		r1,r1,r0
	add		r2,r2,r0
	pop		r14
	bx		r14

.pool

; hijack code near end of in-game routine
.org 0x800C6D0
;	bl      checkcollision


.close