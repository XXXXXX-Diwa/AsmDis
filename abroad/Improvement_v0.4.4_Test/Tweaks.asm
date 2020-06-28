; Samus' Ship will no longer refill energy or ammunition
;.org 0x8045132
;	b 8045212h
;.org 0x804521A
;	mov r0,0h
;.org 0x8045228
;	mov r1,16h
;.org 0x8045236
;	b 804523Eh

;Time Attack is available at the file select screen without a button combination (Incomplete)
.org 0x807DAC0
	b 807DAD8h

; No more beeping when samus is below 30 energy
;.org 0x8052888
;	b 80528B4h

; A in the pause menu no longer opens a worldmap
;.org 0x806E1AA
;	mov r0,2h

; Hard difficulty can be selected for any new game
.org 0x807DE0E
	bne 807DE34h

; Changes the shinespark impact pose to something faster.
; The Pose can be configured. For example try Pose 08: Falling
.org 0x8009DE8
	mov r0,0Ch ;Bonk pose set to Spinning
	
; New Game+ Item collection & timer is always on.
.org 0x806896C
	b 806897Ah

; Fight Ridley before getting Gravity Suit
.org 0x80322D2
	b 80322D8h

; Nicer Rinka drops
;.org 0x8036D6E
;	b 8036DACh
;.org 0x8036D74
;	b 8036DACh
;.org 0x8036E62
;	b 8036EA0h
;.org 0x8036E68
;	b 8036EA0h

; Space Jump in liquids without the gravity suit
.org 0x8008F50
	b 8008F5Ah
	
; Black Pirates made weak to all beams
.org 0x802CC16
	b 802CC36h

;The Chozodia/Mothership tube can be destroyed at any time
.org 0x8046476
	.halfword 0xE004

; Changes the Amount of Missiles required to open a red hatch
;.org 0x8345CB6
;	.byte 0x0 ; default 0, max is 0F
	
; Separaties missile/super missile vulnerabilities. Something weak to missiles probably won't be weak to supers, and vice-versa.
;.org 0x8050AC2
;	.byte 0x4 ;sprite missile vulnerability only includes normal missiles
;.org 0x8345CB4
;	.byte 0x4 ;missile doors only open with normal missiles
;.org 0x8345ABC
;	.byte 0x4 ;super missiles can't break never reform missile blocks
;.org 0x8345ABE
;	.byte 0x4 ;super missiles can't break no reform missile blocks

; Lets you stay Power Gripped to ledges During a Super Missile/PB explosion
.org 0x8009608
	b 800961Ch
.org 0x800979C
	b 80097ACh
.org 0x80098BC
	b 80098CCh
	
; Imago's Doors will Unlock As Soon As He Dies
.org 0x8043178
	b 804318Ch
	
; Deorem (King Worm/Charge Beam Worm) won't run away
.org 0x8023158
	b 8023164h
	
; Skips the statue activation cutscenes
;.org 0x8019C8A ;Kraid Statue Activation
;	b 8019C9Eh
;.org 0x8033B3C ;Ridley Statue Activation
;	b 8033B56h
	
; Energy Tank Values
;.org 0x83459C4 ;Easy, 100 Default
;	.byte 0x64
;.org 0x83459C8 ;Normal, 100 Default
;	.byte 0x64
;.org 0x83459CC ;Hard, 50 Default
;	.byte 0x32

; Missile Tank Values
;.org 0x83459C5 ;Easy, 5 Default
;	.byte 0x05
;.org 0x83459C9 ;Normal, 5 Default
;	.byte 0x05
;.org 0x83459CD ;Hard, 2 Default
;	.byte 0x02

; Super Missile Tank Values
;.org 0x83459C6 ;Easy, 2 Default
;	.byte 0x02
;.org 0x83459CA ;Normal, 2 Default
;	.byte 0x02
;.org 0x83459CE ;Hard, 1 Default
;	.byte 0x01

; Power Bomb Tank Values
;.org 0x83459C7 ;Easy, 2 Default
;	.byte 0x02
;.org 0x83459CB ;Normal, 2 Default
;	.byte 0x02
;.org 0x83459CF ;Hard, 1 Default
;	.byte 0x01
	
; Starting Energy/Ammo (Deprecated by startingItems ASM)
;.org 0x83459C0
;	.byte 0x63 ;Energy, Default 99
;.org 0x83459C1
;	.byte 0x0 ;Missiles, Default 0
;.org 0x83459C2
;	.byte 0x0 ;Super Missiles, Default 0
;.org 0x83459C3
;	.byte 0x0 ;Power Bombs, Default 0
	
; Energy/Ammo Drops
;.org 0x8012F00
;	.byte 0x5 ;small energy drop value, default 5
;.org 0x8012F20
;	.byte 0x14 ;large energy drop value, default 20 (14 in hex)
;.org 0x8012F40
;	.byte 0x2 ;missile drop value, default 2
;.org 0x8012F60
;	.byte 0x2 ;super missile drop value, default 2
;.org 0x8012F80
;	.byte 0x1 ;power bomb drop value, default 1