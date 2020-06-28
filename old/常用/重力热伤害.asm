.gba
.open "zm.gba","GravityHeat.gba",0x8000000

.definelabel RoomEffect,0x30000CC

;this code makes gravity take heat damage, but still offers lava damage protection
;this is why it cannot just be a hex tweak, as lava damage overrides heat damage
;In otherwords, with a hex tweak, gravity will take heat damage until the player
;hops in lava, which makes no sense. If you wish gravity to take lava and heat damage,
;use a hex tweak, not this patch

.org 0x800830E			;ran if gravity is on, before checking hazard type
	bl	CheckEffect

.org 0x8304054			; Crocomire graphics
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
.close