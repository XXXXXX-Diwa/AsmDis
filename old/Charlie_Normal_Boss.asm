.gba
.open "zm.gba","Charlie.gba",0x8000000
.definelabel SetNewSong,0x80039F4

.org 0x803972A
	mov r2,0h
	strb r2,[r1]			;kills sprite
	mov r0,1h			;song after fight
	mov r1,0h
	bl SetNewSong
	b 803973Ch			;makes event set
.org 0x8039758
	b 803975Eh			;skips cutscenes

.close