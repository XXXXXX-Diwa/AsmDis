.gba

.open "mf.gba", "SaveAndRecharge.gba", 0x8000000

;Author: Spedimus
;Save stations now recharge health and ammo.
;Quick change, can definitely be improved.

.definelabel CurrEnergy, 0x3001310
.definelabel CurrMissiles, 0x3001314
.definelabel CurrPBs, 0x3001318

.org 0x801F64C
	bl		0x80F9A28

.org 0x80F9A28						;Unused Sound
	push 	r5, r6, r14
	ldr 	r5, =CurrEnergy			;Refill Energy
	ldr		r6, =CurrEnergy + 2h
	ldrh	r6, [r6]
	strh	r6, [r5]
	ldr 	r5, =CurrMissiles		;Refill Missiles
	ldr		r6, =CurrMissiles + 2
	ldrb 	r6, [r6]
	strb 	r6, [r5]
	ldr 	r5, =CurrPBs			;Refill PBs
	ldr 	r6, =CurrPBs + 1
	ldrb 	r6, [r6]
	strb 	r6, [r5]
	add		r1, r4, 0
	add 	r1, 2Fh
	pop 	r5, r6, r14
	
.pool

.close