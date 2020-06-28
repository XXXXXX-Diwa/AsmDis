.gba
.open "zm.gba",".gba",0x8000000


;.org 80130fah
;    b 8013116h      ;变形球不生产副精灵13作为球皮
.org 80132b2h
    nop             ;球壳不待机
.org 8013182h
   .db 14h

.org 80131DCh       ;球壳
    push r4,lr
	ldr r4,=3000738h
	mov r3,r4
	add r3,20h
	ldr r1,=0FFF4h
	strh r1,[r4,0Ah]
	mov r0,4h
	strh r0,[r4,0Ch]
	strh r1,[r4,0Eh]
	strh r0,[r4,10h]
	mov r0,8h
	strb r0,[r3,7h]
	strb r0,[r3,8h]
	strb r0,[r3,9h]
	ldr r0,=82b2bd0h
	str r0,[r4,18h]
	mov r0,0h
	strb r0,[r4,1Ch]
	strh r0,[r4,16h]
	mov r0,1h
	strb r0,[r3,5h]
	mov r0,2h
	strb r0,[r3,2h]
	mov r0,9h
	strb r0,[r3,4h]
	pop r4
	pop r0
	bx r0
.pool	

;.org 8304054h



.close