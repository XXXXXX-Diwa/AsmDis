.gba
.open "zm.gba","fullpower.gba",0x8000000


.org 0x800B554	;shows correct palette with unknown items patch. Comment if that patch isnt on the ROM
	cmp r1,#0x1
.org 0x800BD78	;hijack point, accessed on start game, do not change
	ldr r5,=0x8581950
	mov r15,r5
.pool

.org 0x8581950			;freespace
	ldr r5,=0x3001542
	mov r6,1h
	strb r6,[r5]
	strh r0,[r4,#0xE]	;everything after this is Hijack stuff
	mov r0,#0x63	
	mov r1,r8
	strh r0,[r1]	
	strh r0,[r1,#0x6]
	ldr r5,=0x800BD82	;Goes back to hijack area, do not change
	mov r15,r5
.pool
.close