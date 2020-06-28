.gba
.open "Chozo_Reborn.gba","ZM_U_spikes.gba",0x8000000

.definelabel SpikeClipNum,0x90
.definelabel SpikeDamage,10
.definelabel KnockbackVelocityX,0x30

.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8

; new code
.org 0x8305000    ; crocomire graphics
CheckTouchingSpike:
	push    r14
	ldr     r1,=SamusData
; check invincibility
	ldrb    r0,[r1,6]      ; r0 = invincibility timer
	cmp     r0,0
	bhi     @@Return
	push    r4-r6
	ldrh    r2,[r1,0x12]   ; r2 = x position
	ldrh    r3,[r1,0x14]   ; r3 = y position
	ldr     r1,=SamusHitbox
	ldsh    r4,[r1,r0]     ; r4 = left hitbox
	ldrh    r5,[r1,2]      ; r5 = right hitbox
	mov     r0,4
	ldsh    r6,[r1,r0]     ; r6 = top hitbox
	add     r4,r4,r2       ; r4 = left-most position
	add     r5,r5,r2       ; r5 = right-most position
	add     r6,r6,r3       ; r6 = top-most position
	add     r3,1
	sub     r4,1
	add     r5,1
	sub     r6,1
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
	ldr     r0,=DecompClipdata
	add     r1,r0,r1
	ldrh    r0,[r1]
	cmp     r0,SpikeClipNum
	beq     @@TouchingSpikeRight
	cmp     r4,r5          ; check if horizontal blocks are same
	beq     @@Loop
; check block to right
	add     r0,r1,2
	ldrh    r0,[r0]
	cmp     r0,SpikeClipNum
	beq     @@TouchingSpikeLeft
@@Loop:
	cmp     r6,r3          ; check if lowest block checked
	bcs     @@Done
	add     r6,1           ; add 1 to y block
	b       @@CheckLeftSide
@@TouchingSpikeLeft:
	ldr     r4,=(0x10000 - KnockbackVelocityX)
	b       @@TouchingSpike
@@TouchingSpikeRight:
	mov     r4,KnockbackVelocityX
@@TouchingSpike:
; get damage to deal
	ldr     r2,=Equipment
	ldrb    r1,[r2,0xF]    ; r1 = suit activation
; check for both suits
	mov     r0,0x30
	and     r0,r1
	cmp     r0,0x30
	bne     @@CheckVaria
	mov     r0,(SpikeDamage * 5 / 10)
	b       @@ReduceEnergy
@@CheckVaria:
	mov     r0,0x10
	and     r0,r1
	cmp     r0,0x10
	bne     @@CheckGravity
	mov     r0,(SpikeDamage * 8 / 10)
	b       @@ReduceEnergy
@@CheckGravity:
	mov     r0,0x20
	and     r0,r1
	cmp     r0,0x20
	bne     @@NoSuits
	mov     r0,(SpikeDamage * 7 / 10)
	b       @@ReduceEnergy
@@NoSuits:
	mov     r0,SpikeDamage
@@ReduceEnergy:
	ldrh    r1,[r2,6]
	cmp     r1,r0          ; compare energy and damage
	bls     @@Dead
	sub     r1,r0
	b       @@SetHealth
@@Dead:
	mov     r1,0
@@SetHealth:
	strh    r1,[r2,6]
; knockback
	mov     r0,0xFA
	bl      0x80074E8
; set x velocity
	ldr     r0,=SamusData
	strh    r4,[r0,0x16]
@@Done:
	pop     r4-r6
@@Return:
	ldr     r0,=0x3000C72
	mov     r1,0
	pop     r2
	bx      r2
	.pool


; hijack code near end of in-game routine
.org 0x800C6D0
	bl      CheckTouchingSpike
	
; fix clipdata collision table
.org 0x85D91FC + SpikeClipNum
	.byte 1

; fix clipdata behavior table
.org 0x85D92AC + (SpikeClipNum * 2)
	.halfword 0
	
.close
