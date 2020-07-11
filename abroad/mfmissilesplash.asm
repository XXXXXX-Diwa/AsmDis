.gba
.open "aimhang.gba","mfmissilesplash.gba",0x8000000

.definelabel Air,0x00

.definelabel CurrentClipdataAffectingAction,0x03000053
.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8
.definelabel ProjectileData,0x3000A2C

;eliminate vanilla damage
.org 0x08084732
	mov	r1,0x00         ; was A
.org 0x08084806
	mov	r1,0x00         ; was 1E
.org 0x808491C
	mov	r2,0x00			;was 28


.org 0x808491e
	nop
	nop
.org 0x8084a66
	nop
	nop


;regular
.org  0x8085116
	bl	missilehitblockwrapper
.org  0x8084782
	bl 	missilehitspritewrapper
;supers
.org  0x80851C6
	bl	missilehitblockwrapper
.org  0x8084856
	bl 	missilehitspritewrapper
;ice
.org  0x8085276
	bl	missilehitblockwrapper
.org  0x808496C
	bl 	missilehitspritewrapper
;diffusion
.org 0x808534E
	bl	difmissilehitblockwrapper
.org 0x8084b46
	bl  difmissilehitspritewrapper



.org 0x82F8898    ; skree graphics
missilehitblockwrapper:
	ldr		r0,=missilehitblock
	mov		r15,r0
missilehitspritewrapper:
	ldr		r0,=missilehitsprite
	mov		r15,r0
difmissilehitblockwrapper:
	mov		r1,r5
	ldr		r0,=missilehitblock
	mov		r15,r0
difmissilehitspritewrapper:
	mov		r1,r0
	ldr		r0,=missilehitsprite
	mov		r15,r0
.pool

.org 0x879FD80

;r1=3000b60
;r2= ""
;r4=projectileslot

missilehitblock:
	push	r14
	push	r4-r6
	push 	r7
	push	r1
	;mov		r1,r4
	push	r1
	mov		r2,r1
	add		r1,0xf
	ldrb	r0,[r1]
	cmp		r0,0xB
	beq		@@super
	cmp		r0,0xC
	beq		@@super
	cmp		r0,0xD
	beq		@@super
	cmp		r0,0xA
	bne		@@continue2
@@smallhitbox:
	ldr     r0,=0FFC0h      ;
    strh    r0,[r2,16h]     ;
    strh    r0,[r2,1ah]     ;
    mov     r1,40h          ;
    strh    r1,[r2,18h]     ;
    strh    r1,[r2,1Ch]     ;
	pop		r1
	push	r1
	bl		checkmissiletouchingsprites
	b		@@continue
@@super:
	ldr     r0,=0FFa0h      ;
    strh    r0,[r2,16h]     ;
    strh    r0,[r2,1Ah]     ;
    mov     r1,60h          ;
    strh    r1,[r2,18h]     ;
    strh    r1,[r2,1Ch]     ;
	pop		r1
	push	r1
	bl		checkmissiletouchingsprites
	b		@@continue
@@continue:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xB
	beq		@@supersplash
	bl		clipsplash
	b		@@continue2
@@supersplash:
	bl		superclipsplash
	b		@@continue2
@@continue2:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xB
	ble		@@noticey
	bl		icegfx
@@noticey:

	pop		r1
	push	r1
	mov		r0,0h
	strh	r0,[r1]
	pop		r1
	pop		r1
	mov		r0,0h
	strh	r0,[r1]
	pop		r7
	pop     r4-r6
	pop     r2
	bx      r2
.pool

missilehitsprite:
	push	r14
	push	r4-r6
	push 	r7

	;mov		r1,r7
	push	r1
	push	r1
	mov		r2,r1
	add		r1,0xf
	ldrb	r0,[r1]
	cmp		r0,0xb
	beq		@@super
	cmp		r0,0xa
	beq		@@smallhitbox
	cmp		r0,0xC
	beq		@@super
	cmp		r0,0xD
	bne		@@continue2
	b		@@super
@@smallhitbox:
	ldr     r0,=0FFC0h      ;
    strh    r0,[r2,16h]     ;
    strh    r0,[r2,1Ah]     ;
    mov     r1,40h          ;
    strh    r1,[r2,18h]     ;
    strh    r1,[r2,1Ch]     ;
	pop		r1
	push	r1
	bl		checkmissiletouchingsprites
	b		@@continue
@@super:
	ldr     r0,=0FFA0h      ;
    strh    r0,[r2,16h]     ;
    strh    r0,[r2,1Ah]     ;
    mov     r1,60h          ;
    strh    r1,[r2,18h]     ;
    strh    r1,[r2,1Ch]     ;
	pop		r1
	push	r1
	bl		checkmissiletouchingsprites
	b		@@continue
@@continue:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xB
	beq		@@supersplash
	bl		clipsplash
	b		@@continue2
@@supersplash:
	bl		superclipsplash
	b		@@continue2
@@continue2:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xB
	ble		@@noticey
	bl		icegfx
@@noticey:
	pop		r1
	pop		r1
	mov		r0,0h
	strh	r0,[r1]
	pop		r7
	pop     r4-r6
	pop     r2
	bx      r2
.pool





checkmissiletouchingsprites:
	push	r14
	push	r1

	pop		r1
	push	r1
@@continue:
	ldrh	r2,[r1,0xA] ;r2=x position
	ldrh	r3,[r1,0x8] ;r3=y position
	add		r1,0x16
	ldrh	r4,[r1,0x4]		;left hitbox
	lsl		r4,r4,10h
	asr		r4,r4,10h
	ldrh	r5,[r1,0x6]		;right hitbox

	ldrh	r6,[r1] 		;top hitbox
	lsl		r6,r6,10h
	asr		r6,r6,10h
	ldrh	r7,[r1,0x2]		;bottom hitbox
	lsl		r7,r7,0x10
	asr		r7,r7,0x10
	add		r4,r4,r2		;left
	add		r5,r5,r2		;right
	add		r6,r6,r3		;top
	add		r7,r7,r3		;bottom
	ldr		r3,=03000140h
	mov		r0,0xff
	lsl		r0,r0,18h
	asr		r0,r0,18h
	mov		r2,r0
@@spriteloop:
	add		r2,1h
	ldrh	r0,[r3]
	mov		r1,0x1
	and		r1,r0
	cmp		r1,0h
	bne		@@exists
	b		@@endofloop
@@exists:
	mov		r1,0x80
	lsl		r1,r1,8h
	and		r1,r0
	cmp		r1,0h
	beq		@@notx
	b		@@endofloop
@@notx:
	mov		r0,r3
	add		r0,0x34
	ldrb	r0,[r0]
	mov		r1,0x8
	and		r1,r0
	cmp		r1,0h
	beq		@@notsolid
	b		@@endofloop
@@notsolid:
	mov		r1,0x40
	and		r1,r0
	cmp		r1,0h
	beq		@@notimmune
	b		@@endofloop
@@notimmune:
	mov		r1,0x10
	and		r1,r0
	cmp		r1,0h
	beq		@@notdead
	b		@@endofloop
@@notdead:
	mov		r1,0x1
	and		r1,r0
	cmp		r1,0h
	beq		@@tangible
	b		@@endofloop
@@tangible:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xA
	beq		@@checknormalweak
	cmp		r0,0xC
	beq		@@checkiceweak
	cmp		r0,0xD
	beq		@@checkiceweak
	cmp		r0,0xB
	beq		@@checksuperweak
	b		@@endofloop
@@checknormalweak:

	bl		getspriteweakness
	mov		r1,0x8
	and		r1,r0
	cmp		r1,0h
	beq		@@endofloop
	b		@@doneweaknesscheck
@@checkiceweak:
	bl		getspriteweakness
	mov		r1,0x40
	and		r1,r0
	cmp		r1,0h
	beq		@@checksuperweak
	b		@@doneweaknesscheck

@@checksuperweak:
	bl		getspriteweakness
	mov		r1,0x8
	and		r1,r0
	cmp		r1,0h
	bne		@@doneweaknesscheck
	mov		r1,0x4
	and		r1,r0
	cmp		r1,0h
	beq		@@endofloop
	b		@@doneweaknesscheck
	
	
@@doneweaknesscheck:
	
	bl		gettopbottomspritehitbox

	cmp		r1,r7           ;if top of sprite hitbox is less than bottom of proj hitbox
	bhi		@@spritebelow
	cmp		r6,r0
	bhi		@@spriteabove
	bl		getleftrightspritehitbox
	cmp		r1,r5
	bhi		@@spriteright
	cmp		r4,r0
	bhi		@@spriteleft


	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xB
	ble		@@freezable
	bl		getspriteweakness
	mov		r1,0x40
	and		r1,r0
	cmp		r1,0h
	bne		@@freezable
	pop		r1
	push	r1
	bl		dospritedamage
	b		@@endofloop
@@freezable:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xB
	bhi		@@icedamage
	bl		dospritedamage
	b		@@endofloop
@@icedamage:
	bl		getspriteweakness
	mov		r1,0x8
	and		r1,r0
	cmp		r1,0h
	bne		@@icedoesdamage
	mov		r1,0x4
	and		r1,r0
	cmp		r1,0h
	bne		@@icedoesdamage
	b		@@setfrozennodamage
@@setfrozennodamage:
	pop		r1
	push	r1
	bl		icedamage

	b		@@endofloop



@@icedoesdamage:
	pop		r1
	push	r1
	mov		r0,r1
	add		r0,0xf
	ldrb	r0,[r0]
	cmp		r0,0xD
	beq		@@diffusion

	mov		r0,r3
	add		r0,0x32
	ldrb	r0,[r0]
	cmp		r0,0x0
	bne		@@icedamage2
	bl		icedamage
	ldrh	r0,[r3,14h]
	cmp		r0,0x28
	ble		@@sethealthto1
@@icedamage2:
	bl		icedamage2
	b		@@endofloop

@@diffusion:
	mov		r0,r3
	add		r0,0x32
	ldrb	r0,[r0]
	cmp		r0,0x0
	bne		@@diffdamage
	bl		icedamage
	ldrh	r0,[r3,14h]
	cmp		r0,0x2D
	ble		@@sethealthto1
@@diffdamage:
	bl		diffdamage
	b		@@endofloop

@@sethealthto1:
	mov		r0,1
	strh	r0,[r3,0x14]
	b		@@endofloop

	
@@spritebelow:
@@spriteabove:
@@spriteright:
@@spriteleft:
@@endofloop:
	add		r3,0x38
	ldr		r0,=0x030006BC
	cmp		r0,r3
	bcc		@@exitloop
	b		@@spriteloop
@@exitloop:
@@return:

	pop		r1

	pop		r0
	bx		r0



getspriteweakness:
	push	r14
	push	r2
	mov		r0,r2
	ldr		r1,=@@getweaknesslink
	add		r1,1
	mov		r14,r1
	ldr		r1,=0x8083044
	mov		r15,r1
@@getweaknesslink:
	lsl     r0,r0,10h
    lsr     r0,r0,10h
	pop		r2
	pop		r1
	bx		r1

icedamage:
	push	r14
	push	r1
	push	r2
	push	r3

	ldr		r0,=3000960h
	sub		r0,r1,r0
	lsr		r0,r0,5h
	
	mov		r1,r0
	mov		r0,r2
	mov		r2,0x0

	ldr		r3,=@@damagelink
	add		r3,0x1
	mov		r14,r3
	ldr		r3,=0x8083788
	mov		r15,r3
@@damagelink:

	pop		r3
	pop		r2
	pop		r1
	pop		r14
	bx		r14
	
icedamage2:
	push	r14
	push	r1
	push	r2
	push	r3

	ldr		r0,=3000960h
	sub		r0,r1,r0
	lsr		r0,r0,5h
	
	mov		r1,r0
	mov		r0,r2
	mov		r2,0x28

	ldr		r3,=@@damagelink
	add		r3,0x1
	mov		r14,r3
	ldr		r3,=0x8083788
	mov		r15,r3
@@damagelink:

	pop		r3
	pop		r2
	pop		r1
	pop		r14
	bx		r14
	
diffdamage:
	push	r14
	push	r1
	push	r2
	push	r3

	ldr		r0,=3000960h
	sub		r0,r1,r0
	lsr		r0,r0,5h
	
	mov		r1,r0
	mov		r0,r2
	mov		r2,0x2D

	ldr		r3,=@@damagelink
	add		r3,0x1
	mov		r14,r3
	ldr		r3,=0x8083788
	mov		r15,r3
@@damagelink:
	
	pop		r3
	pop		r2
	pop		r1
	pop		r14
	bx		r14

regulargfx:
	push	r14
	push	r4-r6
	push	r3
	push	r2
	push	r1
	ldr		r0,=@@gfxlink
	add		r0,1
	mov		r14,r0
	
	mov		r0,r3
	ldrh	r0,[r3,0xA]
	lsl		r0,r0,10h
	asr		r0,r0,10h
	ldrh	r1,[r3,0x2]
	add		r2,r0,r1
	ldrh	r0,[r3,0xC]
	lsl		r0,r0,10h
	asr		r0,r0,10h
	ldrh	r1,[r3,0x2]
	add		r0,r1
	add		r0,r2
	lsr		r0,r0,1h
	ldrh	r1,[r3,0x4]
	mov		r2,0x8

	ldr		r3,=0x80730E4
	mov		r15,r3
@@gfxlink:
	pop		r1
	pop		r2
	pop		r3
	pop		r4-r6
	pop		r14
	bx		r14



icegfx:
	push	r14
	push	r4-r6
	push	r3
	push	r2
	push	r1

	mov		r0,r1
	ldrh	r0,[r1,0x8]
	ldrh	r1,[r1,0xA]
	add		r0,0x30
	mov		r2,0xB
	bl		gfxsubroutine
	sub		r0,0x60
	bl		gfxsubroutine
	add		r0,0x30
	add		r1,0x30
	bl		gfxsubroutine
	sub		r1,0x60
	bl		gfxsubroutine

	pop		r1
	pop		r2
	pop		r3
	pop		r4-r6
	pop		r14
	bx		r14

gfxsubroutine:
	push	r14
	push	r0
	push	r1
	push	r2
	ldr		r3,=@@gfxlink
	add		r3,1
	mov		r14,r3
	
	ldr		r3,=0x80730E4
	mov		r15,r3
@@gfxlink:
	pop		r2
	pop		r1
	pop		r0
	pop		r14
	bx		r14



dospritedamage:
	push	r14
	push	r1
	push	r3
	push	r2

	add		r1,0xf
	ldrb	r1,[r1]
	cmp		r1,0xA
	beq		@@regulardamage
	cmp		r1,0xB
	beq		@@superdamage
	cmp		r1,0xC
	beq		@@icedamage
	cmp		r1,0xD
	beq		@@diffusiondamage

	b		@@regulardamage
@@superdamage:
	mov		r1,0x1E
	b		@@dosubroutine
@@regulardamage:
	mov		r1,0xA
	b		@@dosubroutine
@@icedamage:
	mov		r1,0x28
	b		@@dosubroutine
@@diffusiondamage:
	mov		r1,0x2D
	b		@@dosubroutine

@@dosubroutine:
	mov		r0,r2
	ldr		r2,=@@damagelink
	add		r2,0x1
	mov		r14,r2
	ldr		r2,=0x80835F8
	mov		r15,r2
@@damagelink:
	pop		r2
	pop		r3
	pop		r1
	push	r1
	push	r3
	push	r2
	mov		r0,r1
	add		r0,0xF
	ldrb	r0,[r0]
	cmp		r0,0xB
	bhi		@@icey
;	bl		regulargfx
	b		@@return
@@icey:
	b		@@return
@@return:
	pop		r2
	pop		r3
	pop		r1
	pop		r14
	bx		r14





gettopbottomspritehitbox:		;r3=spritepointer, returns r1=tophitbox r2=bottomhitbox
	push	r14
	push	r2
	ldrh	r0,[r3,0x2]
	ldrh	r1,[r3,0xA]
	ldrh	r2,[r3,0xC]
	lsl		r1,r1,0x10
	asr		r1,r1,0x10
	lsl		r2,r2,0x10
	asr		r2,r2,0x10
	add		r1,r1,r0
	add		r0,r2,r0
	pop		r2
	pop		r14
	bx		r14

getleftrightspritehitbox:   	;r3=spritepointer, returns r1=lefthitbox r2=righthitbox
	push	r14
	push	r2
	ldrh	r0,[r3,0x4]
	ldrh	r1,[r3,0xE]
	ldrh	r2,[r3,0x10]
	
	lsl		r2,r2,0x10
	asr		r2,r2,0x10
	lsl		r1,r1,0x10
	asr		r1,r1,0x10
	add		r1,r1,r0
	add		r0,r2,r0
	pop		r2
	pop		r14
	bx		r14

.pool




superclipsplash:
	push	r14
	ldr		r1,=3000B60h
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
	ldr		r1,=3000B60h
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
	ldr     r0,=3000053h
    mov     r1,8h       
    strb    r1,[r0]
	ldr		r1,=@@cliplink
	add		r1,1h
	mov		r14,r1
    mov     r0,r4       
    ldr		r1,=808222Ch    
	mov		r15,r1
@@cliplink:
	bl		resetpositions
	pop		r4
	pop		r14
	bx		r14

.pool














.close