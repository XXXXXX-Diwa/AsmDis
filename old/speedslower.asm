.gba
.open "MF.gba","mfspeedslower.gba",0x8000000

.definelabel Button_input,0x30011E8 //Tile*64
.definelabel SpeedBoosting,0x300124A //hey
LCheck:
	PUSH    {R0-R2, LR}
		LDR     R0, =Button_input ; jumptable 0800B536 case 63
		LDRH    R0, [R0]
		//0x200=L Button
		MOV    R1, #0x10
		LSL R1, 5
		AND   R1, R0
		NEG    R0, R1
		ORR    R1, R0
		POP    {R0-R2}
		POP   {R0}
	BX    R0

PalHack://old 0x800BFC8

	PUSH    {R0-R2,LR}
	BL LCheck
	//if  r1 came back 0 then button wasn't pressed
	CMP r1, #0
	BEQ CheckScrew
	LDR R1, =SpeedBoosting
	LDRB    R0, [R1]
	CMP     R0, #0
	BEQ  CheckScrew
	//Hack to go back to original code
	POP  {R0-R2}
	LDR r3,=#0x800BFD6
	MOV r15, r3

CheckScrew:
	//Hack to go back to original code
	pop  {R0-R2}
	LDR r3,=#0x800BFCE
	mov r15, r3
.pool

.close