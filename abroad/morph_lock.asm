.gba
.open "zm.gba","morph_lock.gba",0x8000000
;.open "morph_lock_base.gba","morph_lock.gba",0x8000000 ;left for my own testing

; adds check for clipdata 7A(morphlock) and 7B(morphunlock)
; place it in a room, and if samus touches it while morphed(check seems unbalanced, seemed to only trigger when touching the right edge), it'll either lock or unlock her ability to morph
; will likely interfere with spidertweak.asm if used together. would need modifying some things to use these together

; credits:
; used some hijack points from spidertweak.asm by raygun
; used huge chunk of code from morph_shoot.asm, thanks to these guys:
; Code by OneOf99
; Thanks to CaptGlitch for help

.definelabel Air,0x00
.definelabel MorphLock,0x7A
.definelabel MorphUnlock,0x7B

.definelabel DecompClipdata,0x2027800
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel Equipment,0x3001530
.definelabel SamusHitbox,0x30015D8

.definelabel lockflag,0x3007b00 ;hopefully free ram, documentation doesn't seem to have any free chunks marked, and ranomly looking there were used nonzero values everywhere

; new code
.org 0x8304054    ; crocomire graphics



CheckTouchingClip:
	push    r14
	push    r4-r6
	ldr     r1,=SamusData
	ldrh    r2,[r1,0x12]   ; r2 = x position
	ldrh    r3,[r1,0x14]   ; r3 = y position
	ldr     r1,=SamusHitbox
	mov	r0,0
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
	ldr     r0,=DecompClipdata
	add     r1,r0,r1
	ldrh    r0,[r1]
	cmp		r0,Air
	beq		@@Reset
	cmp     r0,MorphLock
	beq     @@DoLock
	cmp		r0,MorphUnlock
	beq		@@DoUnlock
	cmp     r4,r5          ; check if horizontal blocks are same
	beq     @@Loop
; check block to right
	add     r0,r1,2
	ldrh    r0,[r0]
	cmp		r0,Air
	beq		@@Reset
	cmp     r0,MorphLock
	beq     @@DoLock
	cmp		r0,MorphUnlock
	beq		@@DoUnlock

@@Loop:
	cmp     r6,r3          ; check if lowest block checked
	bcs     @@Reset
	add     r6,1           ; add 1 to y block
	b       @@CheckLeftSide
	
@@DoLock:

	ldr		r1,=030013D4h		; Load pose
	ldrb	r0,[r1]
	
	cmp		r0,12h				; Check if morph ball
	bne		@@AfterSparkLeft	; Skip if not morphed
	
ldr r1,=lockflag
mov r0,1
strb r0,[r1]
	
@@AfterSparkLeft:
	b		@@Done

@@DoUnlock:

	ldr		r1,=030013D4h		; Load pose
	ldrb	r0,[r1]
	
	cmp		r0,12h				; Check if morph ball
	bne		@@AfterSparkRight	; Skip if not morphed
	
ldr r1,=lockflag
mov r0,0
strb r0,[r1]
	
@@AfterSparkRight:
	b		@@Done
	
@@Reset:
	ldr 	r1,=300152Ch
	mov		r0,0h
	strb	r0,[r1]

@@Done:
	pop     r4-r6
	ldr     r0,=0x3000C72
	mov     r1,0
	pop     r2
	bx      r2
	.pool

checkwhile_morphed:
ldr r0,=lockflag
ldrb r0,[r0]
cmp r0,0
bne deny_morphed

;execute overwritten
ldr     r5,=823A554h
mov    r0,4h
bx r14
deny_morphed:
ldr r0,=8009386h+1
bx r0

checkwhile_air:
ldr r0,=lockflag
ldrb r0,[r0]
cmp r0,0
bne deny_air

;execute overwritten
ldr     r0,=823A554h
mov    r2,4h
bx r14
deny_air:
ldr r0,=800957ah+1
bx r0

checkwhile_rolling:
ldr r0,=lockflag
ldrb r0,[r0]
cmp r0,0
bne deny_rolling

;execute overwritten
ldr     r0,=3001588h
add    r0,5Bh ;guess i could just move this to above ldr
bx r14
deny_rolling:
ldr r0,=800957ah+1
bx r0

;was intended as one of the reset places, using morphing pose(10) now
;deathhijack:
;pop r0
;push r14
;push r0
;ldr r1,=lockflag
;mov r0,0
;strb r0,[r1]
;
;;execute overwritten
;mov    r0,33h
;strb    r0,[r4]
;ldr     r1,=30013B8h
;pop r0
;mov r14,r0
;pop r15
;.pool

about_to_morph:
ldr r1,=lockflag
mov r0,0
strb r0,[r1]
ldr     r0,=03001530h
ldrb    r1,[r0,0Fh]
bx r14

.pool ;single pool since it's all in range. i think?

;-----end of freespace part

; hijack code near end of in-game routine
.org 0x800C6D0
	bl      CheckTouchingClip
	
; fix clipdata collision table
.org 0x85D91FC + MorphLock
	.byte 0
.org 0x85D91FC + MorphUnlock
	.byte 0

; fix clipdata behavior table
.org 0x85D92AC + (MorphLock * 2)
	.halfword 0
.org 0x85D92AC + (MorphUnlock * 2)
	.halfword 0
	
.org 0x80092fc ; morphed
;push r14 ;doesn't seem like i need to preserve this. well, in theory at least
bl checkwhile_morphed ;bl so i don't have to worry about range which seemd like it'd need register load
;pop r14

.org 0x800953c ;in air
bl checkwhile_air

.org 0x800940a ;while rolling
bl checkwhile_rolling

;was intended as one of the reset places, using morphing pose(10) now
;.org 0x8006fea ;dying
;push r14
;bl deathhijack

;idea here is, if we're about to morph, then clearly weare not currently morphed, so lets reset morph lock in case it is still set from before dying/beating the game with morph lock active/something else(?)

.org 0x8008a62 ;crouched
bl about_to_morph

.org 0x8008d0e ;midair
bl about_to_morph

.org 0x8009688 ;ledge
bl about_to_morph

.close
