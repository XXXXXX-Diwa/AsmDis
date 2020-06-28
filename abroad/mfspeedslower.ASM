.gba
.thumb
.open "mf.gba","mfspeedslower.gba",0x8000000

.definelabel Button_input,0x30011E8 //Tile*64
.definelabel SpeedBoosting,0x300124A //hey
.definelabel SpeedBoostingindicator, 0x30012E4
.definelabel SpeedBoostingindicatorCurrent, 0x030012E5
.definelabel ScrewAttackState, 0x030012D8 

//Speedboost hack
.org 0x800B4A8 
ldr r3, =BoostHack
add r3, 1
mov r15, r3
.pool
nop

//Pal Hijack
.org 0x800BFC8
ldr r3, =PalHack
add r3, 1
mov r15, r3
.pool
nop

//Speedboost tile hijack
.org 0x8009F74
ldr r3, =BoosterBlock
add r3, 1
mov r15, r3
.pool

//Check button press perfrom original logic
.org 0x87DC2E8 
LCheck:
push    {r0-r2, lr}
ldr     r0, =button_input 
ldrh    r0, [r0]
//0x200=l button
mov    r1, 0x10
lsl r1, 5
and   r1, r0
cmp r1, 0
mov r5, r1
pop    {r0-r2}
pop   {r0}
bx    r0

PalHack:

push    {r0-r2}
bl LCheck
mov r1, r5
//if  r1 came back 0 then button wasn't pressed
cmp r1, 0
bne checkscrew
ldr r1, =speedboosting
ldrb    r0, [r1]
cmp     r0, 0
bne  RegularLeave

checkscrew:
LDR     R0, =ScrewAttackState
LDRB    R0, [R0,4]
CMP     R0, #0
BEQ     Leave

RegularLeave:
pop  {R0-R2}
ldr r3,=0x800bfd7
mov r15, r3
Leave:

//Hack to go back to original code
pop  {R0-R2}
LDR r3,=0x800BFFD
mov r15, r3
.pool

.align

BoostHack:
push {r0-r1}
bl      Lcheck
mov r1, r5
//if  r1 came back 0 then button wasn't pressed
cmp     r1, 0
bne      DecrementIndicator
here:
nop
nop
test2:                  
mov     r2, r12
ldrb    r0, [r2,6]
cmp     r0, #0
beq     DecrementIndicator

ldr     R0, =SpeedBoostingindicator
mov     r1, #1
strb    r1, [r0]
mov     r1, #0x10
strb    r1, [r0,1]
b       EndBoostHack


DecrementIndicator: 
				
ldr     R2, =SpeedBoostingindicator
ldrb    r0, [r2,1]
add    r1, r0, #0
cmp     r1, #0
beq     UpdateIndicator
sub    r0, #1
strb    r0, [r2,1]
b       EndBoostHack


UpdateIndicator:                        
strb    r1, [r2]

EndBoostHack:
pop {r0-r1}
ldr r3, =0x800B4DF
mov r15, r3
.pool
nop


BoosterBlock:
push {r1}
ldrb    R0, [R6,#6]
cmp     R0, #0
beq     skip
bl LCheck
mov r1, r5
//if  r1 came back 0 then button wasn't pressed
cmp r1, 0
bne skip
add    R0, R7, #1
lsl    R0, R0, #0x10
lsr    R7, R0, #0x10

skip:
pop {r1}
ldr r3, =0x8009F80 
mov r15, r3
.pool
.close