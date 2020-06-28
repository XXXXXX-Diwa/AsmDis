.gba
.open "zm.gba","S.gba",0x8000000

.definelabel EventFunctions,0x80608BC
.definelabel Equipment,0x3001530
.definelabel Difficulty,0x300002C
;300155Fh is a flag I use and set so the EventFunction doesn't need to be called repeatedly



;|
;|HUD Changes
;|

.org 0x80524CC			;makes super icon never drawn
	b 805251Ch
.org 0x8052544			;places Power Bomb icon where super Icon was
	mov r1,50h
.org 0x8053606
	bl ArmedChange		;ran when missiles are armed
	pop r2
.org 0x8053584
	bl UnarmedChange	;ran when missiles are unarmed
	pop r2
.org 0X80535C6	
	bl OffChange		;ran when missiles are deselected 
	pop r2
.org 0x8053554
	bl OffChange		;ran when missiles are deselected 
	pop r2
.org 0x8053646
	bl UnarmedChange	;ran when missiles are unarmed
	pop r2
.org 0x805304A
	bl GlowCheck1		;ran when filled at Chozo statue
.org 0x805307C
	bl GlowCheck2		;ran when filled at Chozo statue
.org 0x8053094
	bl GlowCheck3		;ran when filled at Chozo statue
	pop r2
.org 0x80530CC
	bl GlowCheck4
;|
;|Projectile Initialization Changes
;|

.org 0x804F1BC			;checks what projectile to check for maximum of
	bl UpgradeCheck				
.org 0x804F1D0
	bl MissileType		;based on if our special flag is set, chooses missile type

;|
;|Event Check
;|

.org 0x805396A
	bl FlagSet		;routine run every frame that sets flag if custom event is set

;|
;|Super Missile Changes
;|

.org 0x8051CCA
	ldrh r0,[r1,8h]		;changes a check for super missile count
.org 0x8051CD2
	strh r0,[r1,8h]		;changes to decrement missile count rather than Super count 
.org 0x83459CA
	.byte 0xA		;Big expansion value on easy/normal
.org 0x83459CC
	.byte 0x4		;big expansion value on hard
.org 0x805AC84
	bl SuperGet		;routine that adds missiles and shows correct message boxes
.org 0x801B8A2			;Needed to prevent a softlock when picking up supers first 
	beq 801B8B0h
.org 0x8010FD8
	bl AmmoDrop		;routine run to make super missile drops appear after upgrade
.org 0x8012F5E			;changes super ammo drops to "large missile ammo drops"
	ldrh r0,[r1,8h]
	add r0,4h		;ammo that super drops restore
	strh r0,[r1,8h]	
	ldrh r2,[r1,2h]
.org 0x8012F6E			;used if missile drop is gotten when missiles are maxed or if player
	strh r2,[r1,8h]		;hasn't got missiles yet		
;|
;|Projectile Initialization Changes
;|


.org 0x8304054			; Crocomire graphics
UpgradeCheck:			
	push  r14		
	ldr r5,=300155Fh	;Our special "event set" flag
	ldrb r0,[r5]
	cmp r0,0h
	bne @@SetSuper 
@@NotUpgraded:
	mov r0,0Ch		;missile projectile value
	mov r1,4h		;missile limit	
	b @@Return 
@@SetSuper:
	mov r0,0Dh		;Super projectile value
	mov r1,4h		;super missile limit
@@Return:
	pop r2
	bx r2	
.pool
MissileType:
	ldr r2,=300155Fh
	ldrb r2,[r2]
	cmp r2,0h		;checks if our flag is set
	beq @@NormalMissile
	ldrh r2,[r0]
	mov r0,0Dh		;initializes Super missile projectile
	b @@Return
.pool
@@NormalMissile:
	ldrh r2,[r0]		;initializes like normal
	mov r0,0Ch
@@Return:
	bx r14



;|
;|Super Missile Changes
;|

SuperGet:			;modified copy of super pickup routine
	ldr r0,=300155Fh
	mov r11,r0
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag so the event isn't set over and over
	bne @@AmountGet
	mov r0,1h
	mov r1,28h
	bl EventFunctions	;sets Missile upgrade event
@@AmountGet:	
	mov r0,r9
	ldrb r3,[r0,1Eh]
	ldr r6,=83459C4h	;Tank Increase Ammounts
	ldr r5,=Difficulty
	ldrb r0,[r5]
	lsl r0,r0,2h
	add r0,r0,r6		;math to get Super missile expansion value
	ldrb r2,[r0,2h]
	ldr r1,=Equipment
	ldrh r0,[r1,8h]
	add r3,r0,r2		;value for current missiles
	ldrh r0,[r1,2h]		
	add r2,r0,r2		;value for max missiles
	cmp r0,0h
	beq @@MessageSet
	mov r0,r11
	ldrb r5,[r0]		;checks if event flag is set
	cmp r5,0h
	bne @@AddMissiles
@@MessageSet:
	push r1-r7
	ldr r1,=83040D9h
	mov r14,r1
	push r4,r14
	ldr r1,=40000D4h
	ldr r0,=8330688h
	str r0,[r1]
	ldr r4,=3000900h
	mov r3,1h
	bl 805358Ah		;all used to make super icon change right when super is grabbed
	pop r1-r7	
	mov r5,1h		;used for message box
	mov r10,r5
	
@@AddMissiles:
	strh r2,[r1,2h]		;max missiles
	strh r3,[r1,8h]		;current missiles
	ldr r1,=805AD14h
	mov r15,r1
.pool

AmmoDrop:
	push r14
	ldr r0,=300155Fh	;checks our flag
	ldrb r0,[r0]
	cmp r0,0h
	beq @@NoDrop
	ldrb r0,[r2,2h]		;max missiles
	ldrb r1,[r2,8h]		;current missiles
	b @@Return
.pool
@@NoDrop:
	ldrb r0,[r2,4h]		;checks super counts instead. players will never have anything
	ldrb r1,[r2,0Ah]	;other than 0 here, so it makes the return compare false
@@Return:
	pop r2
	bx r2	
	

;|
;|Event Check
;|

FlagSet:			;routine run every frame. Ensures flag is set if upgrade event is set
	push r14
	push r4-r7
	ldr r4,=Equipment
	mov r1,0h
	strb r1,[r4,0Ah]	;makes sure player doesn't have actual supers
	strb r1,[r4,4h]
	add r4,2Fh		;special flag
	ldrb r1,[r4]
	cmp r1,0h		;checks if flag is already set
	bne @@Return
	bl EventCheck
	cmp r0,0h
	beq @@Return
	strb r0,[r4]		;sets flag
	mov r0,3h
@@Return:
	pop r4-r7
	mov r0,3h		;overwritten stuff
	mov r1,41h
	pop r2
	bx r2
.pool


;|
;|HUD Changes
;|

ArmedChange:
	push r2
	push r14
	ldr r0,=300155Fh
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag 
	bne @@Super
	push r3
	bl EventCheck
	pop r3
	cmp r0,0h
	beq @@Missile
	b @@Super
.pool 
@@Missile:
	ldr r1,=40000D4h
	ldr r0,=8330548h	;Missile armed GFX
	b @@Return
@@Super:
	ldr r1,=40000D4h
	ldr r0,=83306C8h	;Super armed GFX
@@Return:
	str r0,[r1]
	pop r2
	bx r2
.pool


UnarmedChange:
	push r2
	push r14
	ldr r0,=300155Fh
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag
	bne @@Super
	push r3 
	bl EventCheck
	pop r3
	cmp r0,0h
	beq @@Missile
	b @@Super
.pool 
@@Missile:
	ldr r1,=40000D4h
	ldr r0,=8330508h	;Missile selected GFX
	b @@Return
@@Super:
	ldr r1,=40000D4h
	ldr r0,=8330688h	;Super selected GFX
@@Return:
	str r0,[r1]
	pop r2
	bx r2
.pool


OffChange:
	push r2
	push r14
	ldr r0,=300155Fh
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag 
	bne @@Super
	push r3
	bl EventCheck
	pop r3
	cmp r0,0h
	beq @@Missile
	b @@Super
.pool 
@@Missile:
	ldr r1,=40000D4h
	ldr r0,=83304C8h	;Missile out of ammo GFX
	b @@Return
@@Super:
	ldr r1,=40000D4h
	ldr r0,=8330648h	;Super out of ammo GFX
@@Return:
	str r0,[r1]
	pop r2
	bx r2
.pool

GlowCheck1:
	ldr r0,=300155Fh
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag 
	bne @@Super
	push r2,r3
	bl EventCheck
	pop r2,r3
	cmp r0,0h
	beq @@Missile
	b @@Super
.pool 
@@Missile:
	ldr r1,=40000D4h
	ldr r0,=8330588h	;Missile filled from statue GFX
	b @@Return
@@Super:
	ldr r1,=40000D4h
	ldr r0,=8330708h	;Super filled from statue GFX
@@Return:
	str r0,[r1]
	ldr r7,=805309Ah
	mov r15,r7
.pool

GlowCheck2:
	ldr r0,=300155Fh
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag 
	bne @@Super
	push r2,r3
	bl EventCheck
	pop r2,r3
	cmp r0,0h
	beq @@Missile
	b @@Super
.pool 
@@Missile:
	ldr r1,=40000D4h
	ldr r0,=83305C8h	;Missile filled from statue GFX
	b @@Return
@@Super:
	ldr r1,=40000D4h
	ldr r0,=8330748h	;Super filled from statue GFX
@@Return:
	str r0,[r1]
	ldr r7,=805309Ah
	mov r15,r7
.pool
	
GlowCheck3:
	push r2
	push r14
	ldr r0,=300155Fh
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag 
	bne @@Super
	push r3
	bl EventCheck
	pop r3
	cmp r0,0h
	beq @@Missile
	b @@Super
.pool 
@@Missile:
	ldr r1,=40000D4h
	ldr r0,=8330608h	;Missile filled from statue GFX
	b @@Return
@@Super:
	ldr r1,=40000D4h
	ldr r0,=8330788h	;Super filled from statue GFX
@@Return:
	str r0,[r1]
	pop r2
	bx r2
.pool	

GlowCheck4:
	push r0-r3
	ldr r0,=300155Fh
	ldrb r0,[r0]
	cmp r0,0h		;checks our flag 
	bne @@Super
	bl EventCheck
	cmp r0,0h
	beq @@Missile
	b @@Super
.pool 
@@Missile:
	pop r0-r3
	ldr r1,=83304C8h	;Missile filled from statue GFX
	b @@Return
@@Super:
	pop r0-r3
	ldr r1,=8330648h	;Super filled from statue GFX
@@Return:
	add r0,r0,r1
	ldr r7,=80530D0h
	mov r15,r7
.pool	



EventCheck:			;routine to check event, made to save space
	push r14
	mov r0,3h
	mov r1,28h
	bl EventFunctions	;checks if upgrade event is set
	pop r1
	bx r1 
.close
	






		