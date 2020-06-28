;
.org 801b876h
    nop
    nop	
.org 801b8b0h
    nop
    nop
.org 0x801BAF8
	bl 0x804F670	;refreshes beam GFX (thanks biospark)	
	b 0x801BB00	;prevents going to status screen when getting an item
.org 0x8013176
	bl MorphBall
.org 0x8013B2A
	bl SpeedBooster
.org 0x8013B42
	bl HiJump
.org 0x8013B62
	bl ScrewAttack
.org 0x8013B82
	bl Varia
.org 0x8013BBA
	bl Gravity
.org 0x80133B4
	bl Grip
.org 0x8013BA2
	bl SpaceJump
.org 0x8013ACA
	bl LongBeam
.org 0x8013AE2
	bl IceBeam
.org 0x8013AFA
	bl WaveBeam
.org 0x8013BD2
	bl PlasmaBeam
.org 0x801365A
	bl ChargeBeam	
.org 0x8013B12
	bl Bombs	
;