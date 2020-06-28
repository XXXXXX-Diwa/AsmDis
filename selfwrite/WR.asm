.gba
.open "zm.gba","Worker_robotake.gba",0x8000000

.org 802fb1ch
    add r0,4h  ;金桶行走基础值
.org 802fb30h
    add r0,2h  ;被载前行速度
.org 802fb2ch
    bl rightake
.org 802fb9ch
    sub r0,4h	
.org 802fbb0h
    sub r0,2h
.org 802fbach
    bl leftake
.org 8304054h
rightake:
    ldr r1,=3000738h
    ldrh r0,[r1,4h]
    sub r0,2h    ;金桶载人减速
    strh r0,[r1,4h]
    ldr r1,=30013d4h
    ldrh r0,[r1,12h]
	bx r14
leftake:
    ldr r1,=3000738h
    ldrh r0,[r1,4h]
    add r0,2h    
	strh r0,[r1,4h]
	ldr r1,=30013d4h
	ldrh r0,[r1,12h]
	bx r14	
.pool
.close	