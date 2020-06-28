CheckEffect:
	cmp		r2,4h				;acid hazard flag
	beq		@@Return
	ldr		r0,=RoomEffect
	ldrb	r0,[r0]
	cmp		r0,4h				;heat damage
	beq		@@ChangeHazard
	cmp		r0,6h				;cold damage 1
	beq		@@ChangeHazard
	cmp		r0,7h				;cold damage 2
	beq		@@ChangeHazard
	ldr		r0,=80083A9h		;no harmful hazards
	bx		r0
@@ChangeHazard:
	mov		r2,5h				;heat damage flag
@@VariaReturn:
	mov		r0,r14
	add		r0,0Ch				;800831E, Vaira check
	bx		r0
@@Return:
	bx		r14					;in acid, damage
.pool