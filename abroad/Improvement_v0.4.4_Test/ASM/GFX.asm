;
; Removes the world map in the bottom right corner of the map menu.
.org 0x8400E08
	.import "ASM\GFX\UI.lz"
.org 0x83FEFB8
	.import "ASM\GFX\UI2.lz"
.org 0x84029F0
	.import "ASM\GFX\UI3.lz"
;

; This replaces the flashing hatch graphics for the mothership, for when red hatches take more than one missile to open.
.org 0x85DA40C
	.import "ASM\GFX\mothership.gfx"
;
; This replaces the USA font with the EUR font.
.org 0x8416480
	.import "ASM\GFX\EUR.gfx"
;
; This adds a special character from EUR that says [100%].
.org 0x841B780
	.import "ASM\GFX\100.gfx"	
;
; Updates Character Widths for using EUR font
.org 0x840D7B0
	.import "ASM\GFX\eurWidths.bin"