.gba
.open "r.gba","RIDLEY.gba",0x8000000
;makes pirate ambience no longer play after tripping pirate alarm,
;plays room track instead. Change 17h to event you want the alarm to stop
;activating to

.org 0x8003938
	.byte 0x20	;flag for music priority? set to 0
.org 0x8003942
	bl RoomTrack	;routine to play room music
.org 0x8028814
	.byte 0x08	;pirate ambience code skipped if gravity grabbed event is true 海盗氛围跳过
.org 0x8028858
	.byte 0x09	;pirate alarm stops if gravity grabbed event is true 海盗警报停止
	

.org 0x8304454			; Crocomire graphics
RoomTrack:
	ldr r1,=3000030h ;原本房间音乐地址
	ldrb r1,[r1]
       ; mov r1,0x49
	mov r0,5h
	bx r14
.pool
.close