.gba
.open "zm.gba","Select.gba",0x8000000

.org 0x800C5AC
	.byte 0X7C
.org 0x800C54E
	mov r0,0Ch
.org 0x800C552
	cmp r0,0Ch
	beq 800C562h
.close