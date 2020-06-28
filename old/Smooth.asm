.gba
.open "zm.gba","M1.gba",0x8000000


.org 0x80075C4
	ldr r1,=8760D39h
	bl 808ABFCh
	b 80075FEh
.pool
.org 0x8760D38
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	push r14
	mov r1,r2
	sub r1,58h
	ldrh r0,[r1]
	ldrh r1,[r2,0Eh]
	and r0,r1
	cmp r0,0h
	beq 8760DB0h
	mov r1,r2
	add r1,20h
	ldrb r0,[r1,1h]
	cmp r0,0h
	beq 8760D6Ah
	ldrb r0,[r2,1h]
	cmp r0,0h
	beq 8760D6Ah
	b 8760DB0h
	mov r1,r13	;8760D6Ah
	add r1,4h
	ldrb r0,[r1]
	cmp r0,0FDh
	bne 8760D80h
	ldrb r0,[r2]
	cmp r0,14h
	bne 8760D86h
	mov r0,12h
	strb r0,[r1]
	b 8760D9Ch
	cmp r0,0FEh	;8760D80
	bne 8760DB0h
	b 8760D9Ch
	ldrb r0,[r2]	;8760D86
	cmp r0,31h
	beq 8760DB0h
	cmp r0,32h
	beq 8760DB0h
	nop
	nop
	nop
	mov r0,0h
	strb r0,[r1]
	nop
	ldrb r0,[r2,5h]	;8760D9C
	cmp r0,0h
	beq 8760DA8h
	mov r0,22h
	strb r0,[r2]
	nop
	bl 8760DF6h	;8760DA8
	b 8760DD6h
	nop
	bl 8760DF6h	;8760DB0
	b 8760DC0h	
	nop
	nop
	nop
	nop
	b 8760DC6h
	mov r0,0h	;8760DC0
	strh r0,[r2,16h]
	strb r0,[r2,5h]
	strb r0,[r2,2h]	;8760DC6
	strb r0,[r2,0Ah]
	nop
	nop
	nop
	nop
	nop
	nop
	mov r0,0h	;8760DD6
	strh r0,[r2,0Ch]
	strh r0,[r2,10h]
	strh r0,[r2,18h]
	strb r0,[r2,1Ch]
	strb r0,[r2,1Dh]
	mov r0,0h
	strb r0,[r2,4h]
	strb r0,[r2,7h]
	pop r0
	nop
	nop
	nop
	mov r1,0h
	bx r0
	nop
	push r14	;8760DF0
	mov r0,r2
	add r0,20h
	mov r1,r2
	ldmia [r1]!,r4-r6
	stmia [r0]!,r4-r6
	ldmia [r1]!,r4-r6
	stmia [r0]!,r4-r6
	ldmia [r1]!,r4,r5
	stmia [r0]!,r4,r5
	ldrb r0,[r2,3h]
	cmp r0,0h
	beq 8760E1Ch
	ldrh r0,[r2,0Eh]
	mov r1,30h
	eor r0,r1
	mov r1,0h
	strh r0,[r2,0Eh]
	strb r1,[r2,3h]
	pop r0		;8760E1C
	bx r0
.pool
.close