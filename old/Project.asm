.gba
.open "zm.gba","project.gba",0x8000000

;
; Labels & Tweaks
.include "ASM\Labels.asm"
.include "ASM\Tweaks.asm"
;


;
; General ASM
;.include "ASM\ballspark.asm"
;.include "ASM\betterRoll.asm"
;.include "ASM\GravityHeat.asm"
;.include "ASM\itemGrab.asm"
;.include "ASM\itemToggle.asm"
;.include "ASM\noHints.asm"
;.include "ASM\PBsBeforeBombs.asm"
;.include "ASM\removeCloseup.asm"
;.include "ASM\rShot.asm"
;.include "ASM\sparkSteering.asm"
;.include "ASM\speedBall.asm"
;.include "ASM\tractorBeam.asm"
;.include "ASM\twoLineTXT.asm"
;.include "ASM\unkItems.asm"
;.include "ASM\unkItemsGfx.asm"
;.include "ASM\UIGFX.asm"

;


;
; Freespace ASM
;.org 0x8304680 ;Croco GFX, unused
;.include "Free\F_ballspark.asm"
;.include "Free\F_betterRoll.asm"
;.include "Free\F_GravityHeat.asm"
;.include "Free\F_itemGrab.asm"
;.include "Free\F_rShot.asm"
;.include "Free\F_tractorBeam.asm"
;.include "Free\F_sparkSteering.asm"
;.include "Free\F_speedBall.asm"
;.include "Free\F_unkItems.asm"
;

.close