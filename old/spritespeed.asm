.gba
.open "zm.gba","waverspeed.gba",0x8000000

.org 0x80248CC
    bl waverrightspeed
.org 0x8024900
    bl waverleftspeed
.org 0x80178E6
    bl zeelaup
.org 0x8017886
    bl zeeladown	 
.org 0x8017A84
    bl zeelaright
.org 0x8017A28
    bl zeelaleft	 
.org 0x80179A0
    bl ceilingzeelaright
.org 0x8017AB4
    bl zeelaleftdown
.org 0x8017940
    bl ceilingzeelaleft
.org 0x8017B02
    bl zeelarightdown
.org 0x8017ADA
    bl zeelaupright	
.org 0x8017B22
    bl zeelaupleft

.org 0x8304054	 
waverrightspeed:
    ldrb r3,[r4,1dh]
	add r0,6h
	cmp r3,49h
	bne @@return
	add r0,8h
@@return:
    mov r3,0h
    strh r0,[r4,4h]
	bx r14
	 
waverleftspeed:
    ldrb r3,[r4,1dh]
	sub r0,6h
	cmp r3,49h
	bne @@return1
    sub r0,8h	 
@@return1:
    mov r3,0h
    strh r0,[r4,4h]
	bx r14

zeelaright:
    ldrb r3,[r4,1dh]
    ldrh r0,[r4,4h] 
    sub r0,1h
    cmp r3,15h
    bne @@return2
	sub r0,6h
@@return2:
    mov r3,0h
	bx r14
zeelaup:
    ldrb r3,[r4,1dh]
	sub r0,1h
	cmp r3,15h
	bne @@return3
	sub r0,6h
@@return3:
    mov r3,0h
	strh r0,[r4,2h]
	bx r14
zeeladown:
    ldrb r3,[r4,1dh]
	add r0,1h
	cmp r3,15h
	bne @@return4
	add r0,6h
@@return4:
    mov r3,0h
    strh r0,[r4,2h]
    bx r14	
zeelaleft:
    ldrb r3,[r4,1dh]
	ldrh r0,[r4,4h]
	add r0,1h
	cmp r3,15h
	bne @@return5
	add r0,6h
@@return5:
    mov r3,0h
	bx r14
ceilingzeelaright:
    ldrb r3,[r4,1dh]
	ldrh r0,[r4,4h]
	sub r0,1h
	cmp r3,15h
	bne @@return6
	sub r0,6h
@@return6:
    mov r3,0h
	bx r14
zeelaleftdown:
    ldrb r1,[r4,1dh]
	ldrh r0,[r4,4h]
	add r0,1h
	cmp r1,15h
	bne @@return7
	add r0,6h
@@return7:
    mov r1,0h
	bx r14
ceilingzeelaleft:
    ldrb r3,[r4,1dh]
    ldrh r0,[r4,4h]
    add r0,1h
    cmp r3,15h
    bne @@return8
    add r0,6h
@@return8:
    mov r3,0h
	bx r14
zeelarightdown:
    ldrb r1,[r4,1dh]
	ldrh r0,[r4,4h]
	sub r0,1h
	cmp r1,15h
	bne @@return9
	sub r0,6h
@@return9:
    mov r1,0h
    bx r14	
zeelaupleft:
    ldrb r1,[r4,1dh]
    ldrh r0,[r4,4h]
    sub r0,1h
    cmp r1,15h
    bne @@returnA
    sub r0,6h
@@returnA:
    mov r1,0h
    bx r14	
zeelaupright:
    ldrb r1,[r4,1dh]
    ldrh r0,[r4,4h]
    add r0,1h
    cmp r1,15h
    bne @@returnB
    add r0,6h
@@returnB:
    mov r1,0h
    bx r14	
.pool	 
.close	 

	 
	 
	 