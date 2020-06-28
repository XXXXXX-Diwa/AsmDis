;uncomment the instructions below if you use Biosparks unknown items patch and also activate fullsuit

;.org 0x800B554
;	cmp r1,#0x1


.org 0x800BD78	;hijack point, accessed only on start game, do not change
	ldr r5,=8760D50h
	mov r15,r5
.pool