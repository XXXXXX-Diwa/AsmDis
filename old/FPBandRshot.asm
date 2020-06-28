.gba
.open "tsed.gba","FPBandRshot.gba",0x8000000
.definelabel PlaySound,0x8002A18

; allow laying PBs before bombs
.org 0x8008022
	ldrb    r1,[r3,2]
	mov     r0,4
	and     r0,r1
	cmp     r0,0	
	beq     @@TryLayBomb
	mov     r0,5  ; power bomb
	b       LayBomb
@@TryLayBomb:
	ldrb    r1,[r2,0Dh]
	mov     r0,80h
	and     r0,r1
	cmp     r0,0h
	beq     8008046h
	mov     r0,4h  ; normal bomb
	b       LayBomb

.org 0x8008044
LayBomb:
	strb    r0,[r3,1h]


; fix status screen

; check PBs if no bombs
.org 0x80709F2
    beq     0x8070A08
.org 0x8070A02
	b       0x8070A08
.org 0x8070A24
	b       0x8070BFE  ; return if not any bombs

; if PBs and no bombs, gray bombs out
.org 0x8070A9E
	beq     0x8070B66

; make PB activation not depend on bomb activation
.org 0x8070B1A
	b       0x8070B28

; skip assigning cursor position (avoid selecting bombs)
.org 0x8070BEC
	b       0x8070BFE
; hijack code
.org 0x80081B0
	bl      CheckFireBeam
	b       0x80081B8
.org 0x8304744

; new code
CheckFireBeam:
	push    r14
	ldrb    r0,[r4,5]		; load charge counter
	cmp     r0,0x3F
	bls     @@Return
; fire beam
	mov     r0,0
	strb    r0,[r4,5]		; reset charge counter
	mov     r0,6
	strb    r0,[r4,1]		; set flag to fire charged shot
@@Return:
; replaced code
	mov     r0,0x84
	bl      PlaySound
	pop     r0
	bx      r0
.close