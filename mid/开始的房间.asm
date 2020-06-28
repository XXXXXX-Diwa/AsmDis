.gba
.open "zm.gba","ZM_U_startingRoom.gba",0x8000000

.definelabel HideHudFlag,0x300004A
.definelabel AreaID,0x3000054

.org 0x8060F5C
    ldr     r0,=AreaID
    mov     r1,1			; new area
    strb    r1,[r0]
;	mov     r1,4h
;	strb r1,[r0,1h]
    mov     r1,0x12			; new door
    strb    r1,[r0,2h]
    ldr     r0,=HideHudFlag
    mov     r1,0
    strh    r1,[r0]
    ldr     r0,=0x3000C75
    strb    r1,[r0]
	mov     r0,0x0		    ; music track
	bl      0x80039F4
    b       0x8060FDA
    .pool
	

.close