.gba
.open "zm.gba","PBPirate.gba",0x8000000

.org 0x8036D44
	bl	FrozenRinka
.org 0x8036478
	bl	NewAI

.include "Rinka Pirate/PBPirate.asm"
.include "Rinka Pirate/Rinka.asm"

.org 0x8761800
.include "Rinka Pirate/OAM.asm"

.close