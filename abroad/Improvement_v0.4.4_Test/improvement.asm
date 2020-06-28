.gba
.open "zm.gba","improvement.gba",0x8000000

;
; Labels & Tweaks
.include "ASM\Labels.asm"
.include "Tweaks.asm"
;


;
; GENERAL ASM
;

.include "ASM\ballspark.asm"
.include "ASM\betterRoll.asm"
.include "ASM\GravityHeat.asm"

.include "ASM\itemGrab.asm"			\\Incomplete

.include "ASM\itemToggle.asm"
.include "ASM\noHints.asm"
.include "ASM\PBsBeforeBombs.asm"

;.include "ASM\removeCloseup.asm"

.include "ASM\rShot.asm"

.include "ASM\rToggle.asm"
;.include "ASM\SMControls.asm"			\\Incomplete

.include "ASM\sparkSteering.asm"
.include "ASM\speedBall.asm"

;.include "ASM\startingRoom.asm"
;.include "ASM\startingItems.asm"

.include "ASM\tractorBeam.asm"
.include "ASM\twoLineTXT.asm"
.include "ASM\GFX.asm"
.include "ASM\unkItems.asm"	
.include "ASM\unlockKraid.asm"
.include "ASM\setTimerValues.asm"
.include "ASM\minimapColors.asm"

;


;
; FREESPACE ASM
;
;.org 0x8760D40 ; Freespace?
;.include "ASM\FreespaceASM\F_rToggle.asm"				\\Incomplete
;
;.org 0x8760D50 ; Freespace
;.include "ASM\FreespaceASM\F_startingItems.asm"
;
;.org 0x8043DF0 ; Unused Crocomire AI
;.include "ASM\FreespaceASM\F_scaleEndPercent.asm"
;
.org 0x8304054 ; Croco GFX, unused
.area 0x3094
.include "ASM\FreespaceASM\F_ballspark.asm"
.include "ASM\FreespaceASM\F_betterRoll.asm"
.include "ASM\FreespaceASM\F_GravityHeat.asm"

.include "ASM\FreespaceASM\F_itemGrab.asm"

.include "ASM\FreespaceASM\F_rShot.asm"
.include "ASM\FreespaceASM\F_tractorBeam.asm"

;.include "ASM\FreespaceASM\F_SMControls.asm"

.include "ASM\FreespaceASM\F_sparkSteering.asm"
.include "ASM\FreespaceASM\F_speedBall.asm"
.include "ASM\FreespaceASM\F_unkItems.asm"
.include "ASM\FreespaceASM\F_unlockKraid.asm"
.endarea
;

.close