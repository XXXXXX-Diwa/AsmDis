.gba
.open "zm.gba","ChargeHeal.gba",0x8000000

;Original code by CaptainGlitch
;Decompiled by MetroidPrime_Stratton

.definelabel    HealthCapacity,0x3001530

.org 0x8007D6A
    bl      8043DF0h
    nop
.org 0x8043DF0
    ldr     r4,=3001530h
    ldrb    r0,[r3,5h]
    cmp     r0,39h
    bhi     8043DFEh
    mov     r1,0h
    strb    r1,[r4,1Fh]
    bx      r14
    push    r0
    ldrb    r1,[r4]
    ldrb    r0,[r4,6h]
    cmp     r0,r1
    beq     8043E1Ch
    ldrb    r1,[r4,1Fh]
    cmp     r1,1Fh
    beq     8043E14h
    add     r1,1h
    strb    r1,[r4,1Fh]
    b       8043E1Ch
    mov     r1,0h
    strb    r1,[r4,1Fh]
    add     r0,1h
    strb    r0,[r4,6h]
    pop     r0
    ldr     r1,=8007D7Ch
    mov     r15,r1
    lsl     r0,r0,0h
    asr     r0,r6,14h
    lsl     r0,r0,0Ch
    ldrb    r4,[r7,15h]
    lsr     r0,r0,15h
.pool
.close