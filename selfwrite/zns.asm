.gba
.open "motherom.gba","zerosuitnoskill.gba",0x8000000

.org 080075a8h
    bl zerosuitfix
	
.org 8322206h
zerosuitfix:
    cmp r4,3fh
    beq @@nobackface
	cmp r4,1dh
	beq @@noelevator
	b @@return
@@nobackface:	
	ldrb r1,[r3,1ah]
	cmp r1,2h
	beq @@return
    mov r4,20h
	strb r4,[r5]
    b @@return
@@noelevator:
    ldrb r1,[r3,1ah]
	cmp r1,2h
	bne @@return
	mov r4,1eh
	strb r4,[r5]
@@return:
    strb r4,[r5]
	mov r0,r5
    bx r14
.pool
.close	
    	