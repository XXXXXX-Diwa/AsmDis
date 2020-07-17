.gba
.open "zm.gba","plasmalimit.gba",0x8000000
.definelabel nerfPlasma,0x08760d50
.definelabel nerfChargedPlasma,0x08760dA0
.definelabel nerfIcePlasma,0x08760DF0

.org 0x0805040A ; set Ice Stun timer
	mov r1,09h  ; change 9 to be lower for more hits

.org 0x08050490 ;set length of hit stun timer
	mov r1,09h  ; change 9 to be lower for more hits

.org 0x080505D4
	ldr		r0,=nerfPlasma
	mov 	r15,r0
.pool

.org nerfPlasma
	mov     r0,r4    
    add     r0,2Bh   
    ldrb    r1,[r0]    
    cmp     r1,0h   
	bne		Stunned
	b		OriginalCode
Stunned:
	ldr		r0,=08050644h
	mov		r15,r0
OriginalCode:
	mov     r0,r4    
    add     r0,32h   
    ldrb    r1,[r0]  
    mov     r0,8h    
    and     r0,r1    
    cmp     r0,0h    
    beq     Hasnt8
Has8:
	ldr		r0,=080505E2h
	mov		r15,r0
Hasnt8:
	ldr 	r0,=080505F4h
	mov 	r15,r0
.pool


;Charged
.org 0x0805067C
	ldr		r0,=nerfChargedPlasma
	mov 	r15,r0
.pool

.org nerfChargedPlasma
	mov     r0,r4    
    add     r0,2Bh   
    ldrb    r1,[r0]    
    cmp     r1,0h   
	bne		CStunned
	b		COriginalCode
CStunned:
	ldr		r0,=080506ECh
	mov		r15,r0
COriginalCode:
	mov     r0,r4    
    add     r0,32h   
    ldrb    r1,[r0]  
    mov     r0,8h    
    and     r0,r1    
    cmp     r0,0h    
    beq     Hasnt8
CHas8:
	ldr		r0,=0805068Ah
	mov		r15,r0
CHasnt8:
	ldr 	r0,=0805069Ch
	mov 	r15,r0
.pool

;Ice
.org 0x0805074E
	ldr		r0,=nerfIcePlasma
	mov 	r15,r0
.pool

.org nerfIcePlasma
	mov     r0,r4    
    add     r0,2Bh   
    ldrb    r1,[r0]    
    cmp     r1,0h   
	bne		IStunned
	b		IOriginalCode
IStunned:
	mov		r5,40
	ldr		r0,=08050818h
	mov		r15,r0
IOriginalCode:
	mov     r0,r4    
    add     r0,32h   
    ldrb    r1,[r0]  
    mov     r0,8h    
    and     r0,r1    
    cmp     r0,0h    
    beq     IHasnt8
IHas8:
	ldr		r0,=0805075Ch
	mov		r15,r0
IHasnt8:
	ldr 	r0,=0805076Eh
	mov 	r15,r0
.pool



.close