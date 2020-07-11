.gba
.open "zm.gba","projectilesoffscreen.gba",0x8000000
.definelabel notoffscreen,0x0804F65E
.definelabel offscreen,0x0804F65A
.definelabel RoomWidth,0x30000B8
.definelabel RoomHeight,0x30000BA

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

.org 0x8763000
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

.close