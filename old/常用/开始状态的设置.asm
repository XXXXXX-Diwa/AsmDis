.gba
.open "zm.gba","Items.gba",0x8000000

;Ultimate start items ASM
;Unknown Items will not be active unless you also give Samus' the fullsuit. Otherwise they will remain unknown items until the chozo trail
;Likewise, unknown items will also not show up correctly in your inventory unless you apply Biospark's Unknown Items patch, or do the chozo trial
;All values are and should stay in hex
;If you dont want to start with Missiles, or Supers, or any beams, ect, either comment those instructions witha ";" or change the variable to 0.
;Leaving any of the variables unchanged will result in the file not compiling. 


;SUIT/MISC TABLE
;01 = Hi-jump
  
;02 = Speed booster
  
;04 = Space jump
  
;08 = Screw attack
  
;10 = Varia suit
  
;20 = Gravity suit
  
;40 = Morph ball
  
;80 = Power grip"

;BEAMS/BOMBS TABLE
  
;01 = Long beam
  
;02 = Ice beam
  
;04 = Wave beam
  
;08 = Plasma beam
  
;10 = Charge beam
  
;80 = Bombs

;SUIT TYPES
;00 = Normal Suit
;01 = Full Powered Suit
;02 = Zero Suit

;uncomment the instructions below if you use Biosparks unknown items patch and also activate fullsuit

;.org 0x800B554	
;	cmp r1,#0x1


.org 0x800BD78	;hijack point, accessed only on start game, do not change
	ldr r5,=8760D50h
	mov r15,r5
.pool

.org 0x8760D50			; change to freespace
	ldr r5,=3001530h	;Samus equipment
	mov r6,Xh		;Change X to any combinations of values according to the Suit/Misc table above. For example, 60h gives you Gravity and morphball
	strb r6,[r5,0Eh]	;Stores X to aquired Suit/Misc Items
	strb r6,[r5,0Fh]	;Stores X to equipped Suit/Misc Items
	mov r6,Yh		;Change Y to any combination of values according to the Beams/Bombs table. For example, 98h gives you Bombs, Charge Beam , and Plasma
	strb r6,[r5,0Ch]	;Stores Y to aquired Beams/Bombs
	strb r6,[r5,0Dh]	;Stores Y to equipped Beams/Bombs
	mov r6,Zh		;Change Z to the number of missiles you'd like to start with. For example, 0Ah is 10 missiles.
	strh r6,[r5,2h]		;Stores Z to max Missiles
	strh r6,[r5,8h]		;Stores Z to current Missiles
	mov r6,Nh		;Change N to number of supers you'd like to start with. For example 0Ah is 10 Super Missiles.
	strb r6,[r5,4h]		;Stores N to max Super Missiles
	strb r6,[r5,0Ah]		;Stores N to current Super Missiles
	mov r6,Vh		;Change V to the number of Power Bombs you'd like to start with. For example 0Ah is 10 Power Bombs
	strb r6,[r5,5h]		;Stores V to Max Power Bombs
	strb r6,[r5,0Bh]		;Stores V to Current Power Bombs
	mov r6,Wh		;Change W to type of Suit you'd like to start with
	strb r6,[r5,12h]	;Stores W to Suit type flag
	

	strh r0,[r4,0Eh]	;everything after this is Hijack stuff, don't change
	mov r0,63h		;starting health, suppose you could change this
	mov r1,r8
	strh r0,[r1]	
	strh r0,[r1,6h]
	ldr r5,=800BD82h	;Goes back to hijack area, do not change
	mov r15,r5
.pool
.close