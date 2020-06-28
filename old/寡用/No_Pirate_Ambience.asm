.gba
.open "zm.gba","Song.gba",0x8000000
;makes pirate ambience no longer play after tripping pirate alarm,
;plays room track instead. Change 17h to event you want the alarm to stop
;activating to

.org 0x8003938
	.byte 0x0	;flag for music priority? set to 0
.org 0x8003942
	bl RoomTrack	;routine to play room music
.org 0x8028814
	.byte 0x17	;pirate ambience code skipped if gravity grabbed event is true
.org 0x8028856
	.byte 0x17	;pirate alarm stops if gravity grabbed event is true
	

.org 0x8304054			; Crocomire graphics
RoomTrack:
	ldr r1,=3000030h
	ldrb r1,[r1]
	mov r0,5h
	bx r14
.pool
.close