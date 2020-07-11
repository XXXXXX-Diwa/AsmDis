.gba
.open "MZMO.gba","newportal.gba",0x8000000

.definelabel Air,0x00
.definelabel EnemyOnly,0x17
.definelabel Water,0x1b
.definelabel BGTriggerOpaque,0x80
.definelabel BGTriggerDefault,0x8B
.definelabel DoorsUnlockedFlag,0x30054E4
.definelabel CurrentArea,0x3000054
.definelabel CurrentRoom,0x3000055
.definelabel ActivePortal,0x91
.definelabel InactivePortal,0x92
.definelabel WarpingFlag,0x3001694
.definelabel DecompClipdata,0x2027800
.definelabel DecompBG1,0x0202D800
.definelabel RoomWidth,0x30000B8
.definelabel RoomHeight,0x30000BA
.definelabel SamusData,0x30013D4
.definelabel ProjectileData,0x03000A2C
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8
.definelabel ButtonInput,0x300137c
.definelabel Division,0x808AC34
.definelabel Modulo,0x808AD10
.definelabel ClipSpawnCounter,0x3001695
.definelabel Clip1Offset,0x3001696
.definelabel Clip2Offset,0x3001698
.definelabel PortalTimer,0x300169A
.definelabel SubGameMode1,0x03000C72
.definelabel freespace,0x8761000
.definelabel notoffscreen,0x0804F65E
.definelabel offscreen,0x0804F65A
.definelabel SuitMiscActive,0x0300153F

.org 0x8025ADC
	mov r0,0x0
.org 0x8051CD0      ;dont use super ammo
	nop

.org 0x0804F176       ; beam limit (was 6)
	mov		r1,0xA

.org 0x804F1BE			; missile limit (was 4)
	mov		r1,0xA

.org 0x804F202			;super limit (was 4)
	mov		r1,0xA		


.org 0x0804F650
	ldr		r1,=offscreenhijack
	mov		r15,r1
.pool




.org 0x8051D04
	nop
.org 0x8051D08
	mov		r15,r0

.org 0x08051D38
	.word	superhijack



; new code
.org 0x8304054    ; crocomire graphics

CheckTouchingClip:
	push    r14
	push    r4-r6
	bl		clearportalsifchangingrooms
	bl		portalanimation
	bl		projectileportal
	bl		samuswarp

	pop     r4-r6
	ldr     r0,=0x3000C72
	mov     r1,0
	pop     r2
	bx      r2
.pool



samuswarp:
	push	r14
	ldr		r1,=ClipSpawnCounter
	ldrb	r1,[r1]
	cmp		r1,0x2
	beq		@@twoportalsexist
	b		@@done
@@twoportalsexist:
	ldr     r1,=SamusData
	ldrh    r2,[r1,0x12]   ; r2 = x position
	ldrh    r3,[r1,0x14]   ; r3 = y position
	ldr     r1,=SamusHitbox
	mov		r0,0
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
	ldr     r0,=Clip1Offset
	ldrh	r0,[r0]
	cmp     r0,r1
	beq     @@Teleport2
	ldr     r0,=Clip2Offset
	ldrh	r0,[r0]
	cmp     r0,r1
	beq     @@Teleport1
	cmp     r4,r5          ; check if horizontal blocks are same
	beq     @@Loop
; check block to right
	add     r1,r1,2
	ldr     r0,=Clip1Offset
	ldrh	r0,[r0]
	cmp     r0,r1
	beq     @@Teleport2
	ldr     r0,=Clip2Offset
	ldrh	r0,[r0]
	cmp     r0,r1
	beq     @@Teleport1


@@Loop:
	cmp     r6,r3          ; check if lowest block checked
	bcs     @@Reset
	add     r6,1           ; add 1 to y block
	b       @@CheckLeftSide
	
@@Teleport2:
	mov		r2,r1
	ldr		r1,=WarpingFlag
	ldrb	r0,[r1]
	cmp		r0,0x1
	beq		@@Teleported
	cmp		r0,0x2
	beq		@@done
	mov		r0,0x1
	strb	r0,[r1]
	ldr		r1,=SamusData
	ldrb	r0,[r1]
	
	cmp		r0,0x1A
	beq		@@done
	cmp		r0,0x1B
	beq		@@done
	cmp		r0,0x1C
	beq		@@done
	cmp		r0,0x1D
	beq		@@done
	cmp		r0,0x1E
	beq		@@done
	cmp		r0,0x20
	beq		@@done
	cmp		r0,0x2D
	beq		@@done
	cmp		r0,0x2C
	beq		@@done
	cmp		r0,0x33
	beq		@@done
	ldr		r1,=Clip2Offset
	ldrh	r2,[r1]
	bl		warptoR2offset
	b		@@Done

@@Teleport1:
	mov		r2,r1
	ldr		r1,=WarpingFlag
	ldrb	r0,[r1]
	cmp		r0,0x1
	beq		@@Teleported
	cmp		r0,0x2
	beq		@@done
	mov		r0,0x1
	strb	r0,[r1]
	ldr		r1,=SamusData
	ldrb	r0,[r1]
	cmp		r0,0x1A
	beq		@@done
	cmp		r0,0x1B
	beq		@@done
	cmp		r0,0x1C
	beq		@@done
	cmp		r0,0x1D
	beq		@@done
	cmp		r0,0x1E
	beq		@@done
	cmp		r0,0x20
	beq		@@done
	cmp		r0,0x2D
	beq		@@done
	cmp		r0,0x2C
	beq		@@done
	cmp		r0,0x33
	beq		@@done
	ldr		r1,=Clip1Offset
	ldrh	r2,[r1]
	bl		warptoR2offset
	b		@@Done

@@Teleported:
	ldr		r1,=WarpingFlag
	ldrb	r0,[r1]
	cmp		r0,1                ;Set flag to 2 after teleport
	bne		@@Done
	mov		r0,0x2
	strb	r0,[r1]
	ldr		r1,=0x3000144
	ldr		r0,[r1]
	ldr		r1,=0x30013b4
	str		r0,[r1]
	add		r1,r1,0x4
	str		r0,[r1]
	add		r1,r1,0x4
	str		r0,[r1]
	mov		r0,0x0
	bl		0x08056b28
	mov		r0,0x1
	bl		0x08056b28
	mov		r0,0x2
	bl		0x08056b28
	b		@@Done

@@Reset:
	ldr		r1,=WarpingFlag
	ldrb	r0,[r1]
	cmp		r0,2
	bne		@@Done
	mov		r0,0x0
	strb	r0,[r1]
@@Done:
	pop		r14
	bx		r14

warptoR2Offset:
	push	r14
	bl		checkifmorphtunnel
	cmp		r0,0x0
	bne		@@return
	bl		preventceilingclip

	lsr		r2,r2,1h
	push	r2
	mov		r0,r2
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	nop
	bl		Modulo
	pop		r2
	mov		r4,r0
	sub		r0,r2,r0
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	bl		Division
	add		r0,r0,0x1
	mov		r3,r0
	lsl		r3,r3,0x6       ; yposition
	sub		r3,r3,1
	lsl		r4,r4,0x6		; xposition
	mov		r1,0x20
	add		r4,r4,r1
	ldr		r1,=SamusData	;Load SamusData
	strh	r4,[r1,12h]		;Store x position
	strh	r3,[r1,14h]		;Store y position
	mov		r0,0x0
	strb	r0,[r1,0x1A]
@@return:
	pop		r14
	bx		r14

preventceilingclip:
	push	r14
	ldr		r1,=SamusData
	ldrb	r0,[r1]
	cmp		r0,0x10           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x11           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x12           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x13           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x14           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x26           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x27           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x31           ; if in morphball
	beq		@@return0         ; if in morphball
	cmp		r0,0x32           ; if in morphball
	beq		@@return0
	cmp		r0,0x28
	beq		@@zip
	cmp		r0,0x29
	beq		@@zip
	cmp		r0,0x2a
	beq		@@zip
	cmp		r0,0x2b
	beq		@@zipmorph
	b		@@continue
@@zip:
	mov		r0,0x8
	strb	r0,[r1]
	b		@@return0
@@zipmorph:
	mov		r0,0x14
	strb	r0,[r1]
	b		@@return0
@@continue:
	ldr		r1,=SamusData
	ldrb	r0,[r1]
	cmp		r0,0x0
	beq		@@solid2
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	lsl		r1,r1,1
	sub		r1,r2,r1
	ldr		r0,=DecompClipdata
	add		r1,r1,r0
	ldrh	r0,[r1]
	
	cmp		r0,0x21
	beq		@@return0
	cmp		r0,0x22
	beq		@@return0
	cmp		r0,0x23
	beq		@@return0
	cmp		r0,0x24
	beq		@@return0
	cmp		r0,0x25
	beq		@@return0
	cmp		r0,0x26
	beq		@@return0
	cmp		r0,Air
	beq		@@return0
	cmp		r0,Water
	beq		@@return0
	cmp		r0,EnemyOnly
	beq		@@return0
	cmp		r0,BGTriggerOpaque
	bcc		@@solid2
	cmp		r0,BGTriggerDefault
	bhi		@@solid2
	b		@@return0
@@solid2:

	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	lsl		r1,r1,1
	add		r1,r1,r2
	ldr		r0,=DecompClipdata
	add		r1,r1,r0
	ldrh	r0,[r1]
	cmp		r0,0x21
	beq		@@solid1
	cmp		r0,0x22
	beq		@@solid1
	cmp		r0,0x23
	beq		@@solid1
	cmp		r0,0x24
	beq		@@solid1
	cmp		r0,0x25
	beq		@@solid1
	cmp		r0,0x26
	beq		@@solid1
	cmp		r0,Air
	beq		@@solid1
	cmp		r0,Water
	beq		@@solid1
	cmp		r0,EnemyOnly
	beq		@@solid1
	cmp		r0,BGTriggerOpaque
	bcc		@@return0
	cmp		r0,BGTriggerDefault
	bhi		@@return0
	b		@@solid1
@@solid1:
	ldr		r1,=SamusData
	ldrh	r0,[r1,0x18]
	lsl		r0,r0,0x10
	asr		r0,r0,0x10
	cmp		r0,0
	blt		@@return0
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	lsl		r1,r1,1
	add		r2,r2,r1
@@return0:
	pop		r14
	bx		r14
.pool

checkifmorphtunnel:
	push	r14
	;push	r2
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	lsl		r1,r1,1
	add		r1,r1,r2
	ldr		r0,=DecompClipdata
	add		r1,r1,r0
	ldrh	r0,[r1]
	cmp		r0,0x21
	beq		@@return0
	cmp		r0,0x22
	beq		@@return0
	cmp		r0,0x23
	beq		@@return0
	cmp		r0,0x24
	beq		@@return0
	cmp		r0,0x25
	beq		@@return0
	cmp		r0,0x26
	beq		@@return0
	cmp		r0,Air
	beq		@@return0
	cmp		r0,Water
	beq		@@return0
	cmp		r0,EnemyOnly
	beq		@@return0
	cmp		r0,BGTriggerOpaque
	bcc		@@solid1
	cmp		r0,BGTriggerDefault
	bhi		@@solid1
	b		@@return0
@@solid1:

	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	lsl		r1,r1,1
	sub		r1,r2,r1
	ldr		r0,=DecompClipdata
	add		r1,r1,r0
	ldrh	r0,[r1]
	cmp		r0,0x21
	beq		@@return0
	cmp		r0,0x22
	beq		@@return0
	cmp		r0,0x23
	beq		@@return0
	cmp		r0,0x24
	beq		@@return0
	cmp		r0,0x25
	beq		@@return0
	cmp		r0,0x26
	beq		@@return0
	cmp		r0,Air
	beq		@@return0
	cmp		r0,Water
	beq		@@return0
	cmp		r0,EnemyOnly
	beq		@@return0
	cmp		r0,BGTriggerOpaque
	bcc		@@solid2
	cmp		r0,BGTriggerDefault
	bhi		@@solid2
	b		@@return0
@@solid2:

	ldr		r1,=SuitMiscActive
	ldrb	r1,[r1]
	mov		r0,0x40
	and		r0,r1
	cmp		r0,0
	beq		@@return1
	ldr     r1,=SamusData
	ldrb	r0,[r1]
	cmp		r0,0x22
	beq		@@ballspark
	cmp		r0,0x26
	beq		@@ballspark
	cmp		r0,0x21
	beq		@@delaybeforespark
	cmp		r0,0x25
	beq		@@delaybeforespark
	b		@@morph
@@delaybeforespark:
	mov		r0,0x25
	b		@@setpose
@@ballspark:
	mov		r0,0x26
	b		@@setpose
@@morph:
	mov		r0,0x12
	b		@@setpose
@@setpose:
	strb	r0,[r1]
	mov		r0,0x0
	add		r1,0x1c
	strb	r0,[r1]
	strb	r0,[r1,0x1]
	add		r1,0x4
	mov		r0,0x0
	add		r1,0x1c
	strb	r0,[r1]
	strb	r0,[r1,0x1]
	ldr		r1,=0x3001528
	mov		r0,0x0
	strb	r0,[r1]
	strb	r0,[r1,0x1]
	strb	r0,[r1,0x2]
	b		@@return0

@@return1:
	mov		r0,0x1
	;pop		r2
	pop		r14
	bx		r14

@@return0:
	mov		r0,0x0
	;pop		r2
	pop		r14
	bx		r14



clearportalsifchangingrooms:
	push	r14
	ldr		r1,=SubGameMode1
	ldrb	r1,[r1]
	cmp		r1,0x1
	bne		@@continue1
	b		@@clearclipdata
@@continue1:
	ldr		r2,=SamusData
	ldrb	r0,[r2]
	cmp		r0,0x22
	beq		@@shinesparkcheck
	cmp		r0,0x26
	bne		@@continue2
@@shinesparkcheck:
	ldr		r1,=ButtonInput
	ldrh	r1,[r1]
	mov		r0,0x2
	and		r0,r1
	cmp		r0,0x0
	beq		@@continue2
@@clearclipdata:
	ldr		r1,=PortalTimer
	mov		r0,0h
	strb	r0,[r1]
	ldr		r1,=ClipSpawnCounter
	mov		r0,0h
	strb	r0,[r1]
	ldr		r1,=WarpingFlag
	mov		r0,0h
	strb	r0,[r1]

@@continue2:
	pop		r14
	bx		r14






projectileportal:
	push	r14
	push	r4-r6
	mov		r2,0x0
	ldr		r1,=ClipSpawnCounter
	ldrb	r1,[r1]
	cmp		r1,0x2
	beq		@@loop2
	b		@@return
@@loop2:
	ldr		r1,=ProjectileData
	add		r1,r2,r1
	ldrb	r0,[r1]
	mov		r1,0x1
	and		r1,r0
	cmp		r1,0x0
	beq		@@endofloop
	mov		r1,0x80
	and		r1,r0
	cmp		r1,0x0
	bne		@@endofloop
	bl		checkprojectilehitportal
@@endofloop:
	mov		r1,0x1C
	add		r2,r2,r1
	ldr		r1,=0x268
	cmp		r2,r1
	bcc		@@loop2
@@return:
	pop		r4-r6
	pop		r14
	bx		r14

checkprojectilehitportal:
	push	r14
	push	r4-r6
	push	r2
	mov		r5,r2
	ldr		r1,=ProjectileData
	add		r1,r2,r1
	ldrh	r2,[r1,0x8]
	ldrh	r3,[r1,0xA]
	lsr		r2,r2,0x6
	lsr		r3,r3,0x6
	ldr     r1,=RoomWidth
	ldrh    r1,[r1]        ; r2 = room width
	mul     r1,r2
	add     r1,r1,r3
	lsl     r1,r1,1
	mov		r6,r1           ;r6=og projectile offset
	ldr		r0,=Clip1Offset
	ldrh	r0,[r0]
	cmp		r0,r1
	bne		@@nottouchingclip1
@@gotoportal2:
	ldr		r1,=Clip2Offset
	ldrh	r2,[r1]
	lsr		r2,r2,1h
	push	r2
	mov		r0,r2
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	nop
	bl		Modulo
	pop		r2
	mov		r4,r0
	sub		r0,r2,r0
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	bl		Division
	add		r0,r0,0x1

	mov		r3,r0
	lsl		r3,r3,0x6       ; yposition
	sub		r3,r3,1
	lsl		r4,r4,0x6		; xposition
	mov		r1,0x20
	add		r4,r4,r1
	b		@@setposition

@@nottouchingclip1:
	ldr		r0,=Clip2Offset
	ldrh	r0,[r0]
	cmp		r0,r1
	bne		@@end
@@gotoportal1:
	ldr		r1,=Clip1Offset
	ldrh	r2,[r1]
	lsr		r2,r2,1h
	push	r2
	mov		r0,r2
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	nop
	bl		Modulo
	pop		r2
	mov		r4,r0
	sub		r0,r2,r0
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	bl		Division
	add		r0,r0,0x1
	mov		r3,r0
	lsl		r3,r3,0x6       ; yposition
	sub		r3,r3,1
	lsl		r4,r4,0x6		; xposition
	mov		r1,0x20
	add		r4,r4,r1
	b		@@setposition

@@setposition:
	mov		r0,r5
	ldr		r1,=ProjectileData
	add		r1,r1,r0
	mov		r0,0x20
	sub		r3,r3,r0
	strh	r3,[r1,0x8]
	strh	r4,[r1,0xA]

	mov		r0,0x80
	ldrb	r2,[r1]
	orr		r0,r2
	strb	r0,[r1]
@@end:
	pop		r2
	pop		r4-r6
	pop		r14
	bx		r14



portalanimation:
	push	r14
	push	r4
	ldr		r1,=PortalTimer
	ldrh	r0,[r1]
	add		r0,r0,0x1
	strh	r0,[r1]
	cmp		r0,0x8
	bcs		@@continue
	b		@@return

@@continue:
	mov		r0,0x0
	strh	r0,[r1]
	ldr		r1,=ClipSpawnCounter
	ldrb	r0,[r1]
	cmp		r0,0x1
	beq		@@oneportal
	cmp		r0,0x2
	beq		@@twoportals
	b		@@return
@@twoportals:
	ldr		r2,=Clip2Offset
	ldrh	r2,[r2]
	lsr		r2,r2,1h
	push	r2
	mov		r0,r2
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	bl		Modulo
	pop		r2
	mov		r4,r0
	sub		r0,r2,r0
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	bl		Division
	add		r0,r0,0x1
	mov		r3,r0
	lsl		r3,r3,0x6       ; yposition
	mov		r1,0x20
	sub		r3,r3,r1
	lsl		r4,r4,0x6		; xposition
	mov		r1,0x20
	add		r4,r4,r1
	mov		r0,r3
	mov		r1,r4
	bl		gfxsubroutine
@@oneportal:
	ldr		r2,=Clip1Offset
	ldrh	r2,[r2]
	lsr		r2,r2,1h
	push	r2
	mov		r0,r2
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	bl		Modulo
	pop		r2
	mov		r4,r0
	sub		r0,r2,r0
	ldr		r1,=RoomWidth
	ldrh	r1,[r1]
	bl		Division
	add		r0,r0,0x1
	mov		r3,r0
	lsl		r3,r3,0x6       ; yposition
	mov		r1,0x20
	sub		r3,r3,r1
	lsl		r4,r4,0x6		; xposition
	mov		r1,0x20
	add		r4,r4,r1
	mov		r0,r3
	mov		r1,r4
	bl		gfxsubroutine
@@return:
	pop		r4
	pop		r14
	bx		r14


gfxsubroutine:
	push	r14
	push	r0
	push	r1-r4
	mov		r2,0x2D
	ldr		r3,=@@gfxlink
	add		r3,1
	mov		r14,r3
	ldr		r3,=0x80540EC
	mov		r15,r3
@@gfxlink:
	pop		r1-r4
	pop 	r0
	pop		r14
	bx		r14




.pool



.org freespace

superhijack:
	push	r2-r4
	push	r5-r7
	ldr		r1,=ClipSpawnCounter
	ldrb	r0,[r1]
	cmp		r0,0x1
	bhi		@@clearportals
	b		@@continue
	
@@clearportals:
	mov		r0,0h
	strb	r0,[r1]
	ldr		r1,=PortalTimer
	mov		r0,0h
	strb	r0,[r1]
	ldr		r1,=ClipSpawnCounter

@@continue:
	ldr		r1,=ButtonInput
	ldrh	r1,[r1]
	mov		r0,0x2
	and		r0,r1
	cmp		r0,0x0
	bne		@@return
	ldrh	r1,[r4]
	mov		r0,0x8
	and		r0,r1
	cmp		r0,0
	bne		@@return
	
	ldrh	r1,[r4]
	mov		r0,0x1
	and		r0,r1
	cmp		r0,0
	beq		@@dead
	
	sub		r1,r1,1
@@dead:

	strh	r1,[r4]
	ldrh	r0,[r4,0x8]
	ldrh	r1,[r4,0xA]

	bl		getclipaddress		 ; r0=ypos ,r1=xpos, output r5=tileoffset
	ldr		r1,=DecompClipdata
	add		r1,r1,r5
	ldrh	r0,[r1]
	cmp		r0,0x21
	beq		@@genclipdata
	cmp		r0,0x22
	beq		@@genclipdata
	cmp		r0,0x23
	beq		@@genclipdata
	cmp		r0,0x24
	beq		@@genclipdata
	cmp		r0,0x25
	beq		@@genclipdata
	cmp		r0,0x26
	beq		@@genclipdata
	cmp		r0,Air
	beq		@@genclipdata
	cmp		r0,Water
	beq		@@genclipdata
	cmp		r0,EnemyOnly
	beq		@@genclipdata
	cmp		r0,BGTriggerOpaque
	bcc		@@return
	cmp		r0,BGTriggerDefault
	bhi		@@return
;generate clipdata
@@genclipdata:

	ldr		r1,=ClipSpawnCounter
	ldrb	r0,[r1]
	add		r0,r0,1
	strb	r0,[r1]
	cmp		r0,0x1
	bne		@@secondclip
	mov		r0,r5
	ldr		r1,=Clip1Offset
	strh	r0,[r1]
	b		@@continue1
@@secondclip:
	ldr		r1,=Clip1Offset
	ldrh	r1,[r1]
	mov		r0,r5
	cmp		r0,r1
	bne		@@setsecondportal
	mov		r0,0x1
	ldr		r1,=ClipSpawnCounter
	strb	r0,[r1]
@@setsecondportal:
	ldr		r1,=Clip2Offset
	strh	r0,[r1]
@@continue1:


	



@@return:
	pop		r5-r7
	pop		r2-r4
	ldrb    r0,[r4,11h]
	cmp     r0,2h      
	bne     @@earlyreturn   
	ldr		r0,=3000079h
	mov		r1,0xA
	strb	r1,[r0]
	ldr		r0,=0x8051D0C
	mov		r15,r0
@@earlyreturn:
	ldr		r1,=0x8051D3C
	mov		r15,r1




updatebgportal:
	push	r14
	mov		r0,0x1
	ldr		r1,=@@updatelink
	add		r1,r1,1
	mov		r14,r1
	ldr		r1,=0x08056b28
	mov		r15,r1
@@updatelink:
	pop		r14
	bx		r14



getclipaddress:         ; r0=ypos ,r1=xpos, output r5=tileoffset
	push	r14
	push	r0
	push	r1-r4
	lsr		r3,r0,0x6
	lsr		r4,r1,0x6
	ldr     r2,=RoomWidth
	ldrh    r2,[r2]        ; r2 = room width
	mov     r1,r2
	mul     r1,r3
	add     r1,r1,r4
	lsl     r5,r1,1
	ldr     r0,=DecompClipdata
	add     r1,r0,r5
	ldrh    r0,[r1]

	pop		r1-r4
	pop 	r0
	pop		r14
	bx		r14


.pool

offscreenhijack:
	ldrh    r4,[r6,8h]      ; r4 = y position
    ldrh    r5,[r6,0Ah]     ; r5 = x position
	ldr		r2,=RoomWidth
	ldrh	r2,[r2]
	lsl		r2,r2,0x6
	ldr		r1,=RoomHeight
	ldrh	r1,[r1]
	lsl		r1,r1,0x6
	cmp		r4,0
	ble		@@offscreen
	cmp		r5,0
	ble		@@offscreen
	cmp		r1,r4
	ble		@@offscreen
	cmp		r2,r5
	ble		@@offscreen
	b		@@notoffscreen

@@offscreen:
	ldr		r0,=offscreen
	mov		r15,r0
@@notoffscreen:
	ldr		r0,=notoffscreen
	mov		r15,r0
.pool

; hijack code near end of in-game routine
.org 0x800C6D0
	bl      CheckTouchingClip
	

.close
