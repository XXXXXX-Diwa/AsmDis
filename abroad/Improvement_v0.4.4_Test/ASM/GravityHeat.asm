;this code makes gravity take heat damage, but still offers lava damage protection
;this is why it cannot just be a hex tweak, as lava damage overrides heat damage
;In otherwords, with a hex tweak, gravity will take heat damage until the player
;hops in lava, which makes no sense. If you wish gravity to take lava and heat damage,
;use a hex tweak, not this patch

.org 0x800830E			;ran if gravity is on, before checking hazard type
	bl	CheckEffect
