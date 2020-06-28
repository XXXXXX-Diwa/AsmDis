.gba
.open "zm.gba","unlockDoors.gba",0x8000000

.definelabel DoorUnlockTimer, 0x300007B

.org 0x8019E7A
	bl UnlockDoors

.org 0x8304054 ;Croco GFX, unused
	UnlockDoors:
	ldr r0,=DoorUnlockTimer
	mov r1,0FFh
	strb r1,[r0]
	ldr r0,=300070Ch
	ldrh r1,[r0,6h]
	bx r14
.pool

.close