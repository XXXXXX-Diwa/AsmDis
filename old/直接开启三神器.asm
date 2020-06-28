.gba
.open "zm.gba","ZM_unkItems.gba",0x8000000

;-----
; All
;-----
.org 0x801B886			; Play correct jingle
	mov r0,0x37
.org 0x8071120			; Play correct sound
	.halfword 0x01F7	; 8071118 ldr r0,=1F7h

	
;--------
; Plasma
;--------
.org 0x807057E			; Show non-garbled text
	b 0x8070584
.org 0x8071944			; Display proper description text
	mov r3,0x4
	b 0x8071A32
.org 0x8071B8E			; Enable plasma
	b 0x8071C1A
	
;---------
; Gravity
;---------
.org 0x80706EC			; Show non-garbled text
	b 0x80706F2
.org 0x80719BC			; Display proper description text
	mov r3,0xA
	b 0x8071A32
.org 0x8071BDE			; Enable gravity
	b 0x8071C1A
	
.org 0x800B4A0			; Load proper palette
	.halfword 0x480F	; ldr r0,=0x3001530
	ldrb r2,[r0,0xF]
	mov r0,0x20
	and r0,r2
	cmp r0,0
	beq 0x800B554
	b 0x800B4B0
	
;------------
; Space Jump
;------------
.org 0x807085A			; Show non-garbled text
	b 0x8070860
.org 0x8071A24			; Display proper description text
	mov r3,0x10
	b 0x8071A32
.org 0x8071C12			; Enable space
	b 0x8071C1A

.close