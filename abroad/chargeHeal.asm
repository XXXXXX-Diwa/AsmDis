```arm
.gba
.open "zm.gba","chargeheal.gba",0x8000000

;Original code by CaptainGlitch
;Decompiled by MetroidPrime_Stratton
;Fixed by Cosmic and raygun

.org 0x8007D6A              ; Chargebeam Hijack
    bl      Chargeheal
    nop

.org 0x8043DF0             ; Unused Crocomire AI
Chargeheal:
    ldr     r4,=3001530h    ; Load max energy
    ldrb      r0,[r3,5h]        ; Load charge timer into r0 (03001419)
    cmp     r0,4Eh            ; 
    bhi     8043DFEh        ; Branch if higher than 4E? Maybe full charge
    mov     r1,0h            ;
    mov     r4,r7            ; Reset r4
    bx      r14             ; Return
    push    r0              ; Push charge timer (is higher than 4E)
    ldrh    r1,[r4]         ; \
    ldrh    r0,[r4,6h]      ; |
    cmp     r0,r1           ; } If health == maxhealth: return
    beq     8043E1Ch        ; 
    ldrb    r1,[r4,1Fh]        ; Load 3001530h + 1Fh into r1
    cmp     r1,3h            ; cmp r1,x  ==> x>3 - slower healing      x<3 - faster healing
    beq     8043E14h        ;  
    add     r1,1h            ; Increase maxhealth+1F by one
    strb    r1,[r4,1Fh]     ; /
    b       8043E1Ch        ; 
    mov     r1,0h           ; else: Maxhealth+1F == 1F
    strb    r1,[r4,1Fh]     ; reset Maxhealth to 0
    add     r0,1h           ; \
    strh    r0,[r4,6h]      ; } Currenthealth +1
    mov        r4,r7           ;
    pop     r0              ;
    ldr     r1,=8007D7Ch    ;
    mov     r15,r1          ;
    lsl     r0,r0,0h        ;
    asr     r0,r6,14h       ;
    lsl     r0,r0,0Ch       ;
    ldrb    r4,[r7,15h]     ;
    lsr     r0,r0,15h       ;
    
.pool
.close
```