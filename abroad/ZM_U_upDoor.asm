.gba
.open "ZM_U.gba","ZM_U_upDoor.gba",0x8000000

.definelabel TryStartDoorTransition,0x805EBF0

; new code
.org 0x8305054    ; crocomire graphics
TryUsingDoor:
	push    r14
	ldrh    r0,[r4,0x14]    ; r4 = SamusData
	ldrh    r1,[r4,0x12]
	lsr     r0,r0,6         ; Ypos / 64
	lsr     r1,r1,6         ; Xpos / 64
	bl      TryStartDoorTransition
	pop     r1
	cmp     r0,0
	bne     @@TransitionStarted
	; overwritten instructions
	ldrh    r0,[r4,0x14]
	add     r0,4
	b       @@Return
@@TransitionStarted:
	add     r1,0x24
@@Return:
	bx      r1
	
; hijack code for pressing up while standing
.org 0x80087DC
	bl      TryUsingDoor
	
.close
