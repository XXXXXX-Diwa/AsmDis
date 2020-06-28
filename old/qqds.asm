.gba
.open "ZM.gba","ZM_U_ballspark.gba",0x8000000

.definelabel ChangedInput,0x3001380
.definelabel Yposition,0x30013E8
.definelabel Pose,0x30013D4
.definelabel ShineTimer,0x30013DC
.definelabel PrevYposition,0x3001602

; hijack input check
.org 0x8008010
	bl Ballspark
	b 0x8008018

; hijack y pos adjust
.org 0x8009E4C
	bl CheckMidair
	b 0x8009E54

; new code
.org 0x8304054		; CHANGE THIS
Ballspark:
	; check pose
	ldr r1,=ShineTimer
	ldrb r0,[r1]
	cmp r0,0x0
	beq @@Return
	ldr r1,=ChangedInput
	ldrb r0,[r1]
	mov r1,0x1
	and r0,r1
	cmp r0,0x0
	beq @@Return

	; check if on ground
	ldr r1,=Yposition
	ldrb r0,[r1,0x4]		; y velocity
	cmp r0,0x0
	bne @@Midair
	; check if moving
	ldrb r0,[r1,0x2]		; x velocity
	cmp r0,0x0
	bne @@Return				; return if moving (spring ball instead)
	ldrh r0,[r1]
	sub r0,0x20
	strh r0,[r1]

@@Midair:
	mov r0,0x0
	strh r0,[r1,0x2]		; set x velocity to 0

	ldr r1,=Pose
	mov r0,0x25
	strb r0,[r1]
	ldr r1,=0x3001528
	mov r0,0x1
	strb r0,[r1]
	ldr r1,=0x3003B54
	strb r0,[r1]
	add r1,0x1
	mov r0,0xE4
	strb r0,[r1]
	add r1,0x1
	mov r0,0x0
	strb r0,[r1]
	add r1,0x2
	ldr r0,=0x820BD34
	str r0,[r1]
@@Return:
	ldr r1,=ChangedInput
	ldrb r0,[r1]
	mov r1,0x2
	and r0,r1
	bx r14


CheckMidair:
	ldr r1,=Yposition
	ldrh r0,[r1]
	ldr r1,=PrevYposition
	ldrh r1,[r1]
	cmp r0,r1
	beq @@Return
	ldr r1,=Yposition
	sub r0,0x20
	strh r0,[r1]
@@Return:
	ldr r1,=ShineTimer
	ldrb r0,[r1,0x2]
	bx r14
	.pool

.close
