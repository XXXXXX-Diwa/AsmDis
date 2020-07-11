.gba
.open	"ZM.gba","speeddamage.gba",0x8000000
.definelabel SamusData,0x30013D4
.definelabel Damage,0x40			;this is the damage done by screw/speed/shine

.org 0x801060C

	mov		r0,0x20
	and		r1,r0
	cmp		r1,0
	beq		@@returnhurt
	ldr		r1,=SamusData
	ldrb	r0,[r1]
	cmp		r0,0xF
	bne		@@speedorshine
	ldrb	r0,[r1,0x5]
	cmp		r0,0x0
	bne		@@dospritedamage

@@screwattacking:              ; 
	mov		r0,r4
	add		r0,0x1D
	ldrb	r0,[r0]
	cmp		r0,0x86            ; change 86 to sprite id to make it impervious to screwattack
	beq		@@returnhurt
;	cmp		r0,0x*Sprite ID*
;	beq		@@returnhurt       ; copy these two lines to make additional sprites immune to screwattack
	b		@@dospritedamage

@@speedorshine:
	mov		r0,r4
	add		r0,0x1D
	ldrb	r0,[r0]
;	cmp		r0,0x86            ; change 86 to sprite id to make it impervious to Shinespark/Speedboost
;	beq		@@returnhurt
;	cmp		r0,0x*Sprite ID*
;	beq		@@returnhurt       ; copy these two lines to make additional sprites immune to Shinespark/Speedboost
	b		@@dospritedamage


@@dospritedamage:
	mov		r0,r4
	mov		r1,Damage
	bl		 0x8050424
	ldrh	r0,[r4,0x2]
	ldrh	r1,[r4,0x4]
	mov		r2,0x23
	bl		0x80540eC
	ldr		r0,=0x801069E
	mov		r15,r0

@@returnhurt:
	ldr		r0,=0x8010684
	mov		r15,r0
.pool











.close