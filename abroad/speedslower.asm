.gba
.thumb
.open "test.gba","mfspeedslower.gba",0x8000000

.definelabel Button_input,0x30011E8 //Tile*64
.definelabel SpeedBoosting,0x300124A //hey
.definelabel SpeedBoostingindicator, 0x30012E4
.definelabel SpeedBoostingindicatorCurrent, 0x030012E5
.definelabel ScrewAttackState, 0x030012D8 
.definelabel SamusData, 0x3001244 
.definelabel SamusDataBuffer, 0x3001270
.definelabel SamusPose, 0x3001245
.definelabel someposestuff, 0x3001244

//Samus Pose enums
.definelabel Jumping_Falling, 4
.definelabel TurningAndJumpFall, 5
.definelabel Morphing, 0xC
.definelabel Morphball, 0xD
.definelabel Rolling, 0xF
.definelabel Unmorphing, 0x10
.definelabel InAirMorphball, 0x11

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
nop
.org 0x8009208//Velocity down hack
LDR R0, =VelocityFix
ADD r0, 1
MOV r15, r0
.pool 
nop 

.org 0x8004D60
                 LDR             R0, =ResetVelocityAndStuffHack
				 add r0,1
                 MOV             r15, R0
.pool
.align

.org 0x8006AA4 
 LDR             R0, =EnableMidairMorph
				 add r0,1
                 MOV             r15, R0
				 .pool
				 .align
//Check button press perfrom original logic
.org 0x87DC2E8 
PoseChecks:
push {r2-r3, lr}
mov r1, 0
ldr r2, =SamusPose
ldrb r2, [r2]
cmp r2, Jumping_Falling
beq InPose
cmp r2, TurningAndJumpFall
beq InPose
cmp r2, Morphing
beq InPose
cmp r2, Morphball
beq InPose
cmp r2, Rolling
beq InPose
cmp r2, Unmorphing
beq InPose
cmp r2, InAirMorphball
beq InPose
b SamusPoseCheckEnd
InPose:
mov r1, 1

SamusPoseCheckEnd:
pop {r2-r3}
pop {r0}
bx r0
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


RCheck:
push    {r0-r2, lr}
ldr     r0, =button_input 
ldrh    r0, [r0]
//0x200=l button
mov    r1, 0x10
and   r1, r0
cmp r1, 0
mov r5, r1
pop    {r0-r2}
pop   {r0}
bx    r0

ACheck:
push    {r0-r2, lr}
ldr     r0, =button_input 
ldrh    r0, [r0]
//0x200=l button
mov    r1, 0x1
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
.align 


//originally from rayguns keep speed patch, includes morphball 
ResetVelocityAndStuffHack:
                PUSH            {R4,R5,LR}
                LDR             R2, =SamusData
                LDR             R0, =SamusDataBuffer
                mov            R1, R2
                LDMIA           R1!, {R3-R5}
                STMIA           R0!, {R3-R5}
                LDMIA           R1!, {R3-R5}
                STMIA           R0!, {R3-R5}
                LDMIA           R1!, {R3-R5}
                STMIA           R0!, {R3-R5}
                LDMIA           R1!, {R3,R4}
                STMIA           R0!, {R3,R4}
                LDRB            R0, [R2,#2]
                CMP             R0, #0
                BEQ             NotTurning
                LDRH            R0, [R2,#0x12]
                mov            R1, #0x30
                EOR            R0, R1
                mov            R1, #0
                STRH            R0, [R2,#0x12]
                STRB            R1, [R2,#2]

NotTurning:
                POP             {R0}
                PUSH            {R0}
                NOP
                NOP
                CMP             R0, #0xFD
                BEQ             NotSureAboutTHis
                B               SetVelocityToZero
NotSureAboutTHis:
                NOP
                mov            R0, R2
                sub            R0, #0x5C
                LDRH            R0, [R0]
                LDRH            R1, [R2,#0x12]
                AND           R1, R0
                CMP             R1, #0
                BEQ             SetVelocityToZero
                mov            R0, R2
                add            R0, #0xE0
                LDRB            R0, [R0,#5]
                CMP             R0, #0
                BEQ             SetVelocityToZero
                mov            R0, R2
                add            R0, #0x2D
                LDRB            R0, [R0]
                CMP             R0, #0x12
                BEQ             SetVelocityToZero
                CMP             R0, #0x14
                BEQ             SetVelocityToZero
				push r1
				bl PoseChecks
				cmp r1, 0
				pop r1
				BEQ 		SetVelocityToZero
                CMP             R0, #0x10
                BNE             Alpha
                mov            R0, #0xE
                B               Beta
; ---------------------------------------------------------------------------
                NOP

Alpha :
				mov            R0, #3

Beta:
				STR             R0, [SP]
                B               ReturnToNormalCode
; ---------------------------------------------------------------------------

SetVelocityToZero: 
				bl ACheck
				mov r1, r5
				//if  r1 came back 0 then button wasn't pressed
				cmp r1, 0
				//Clear out if not pressed.
				beq ClearMomentum
				                    
                mov            R0, #0
				
                STRH            R0, [R2,#0x1A]
				//This logic could improved.
				//Check if A is pressed. 

				//Check if L is pressed
				bl LCheck
				mov r1, r5
				//if  r1 came back 0 then button wasn't pressed
				cmp r1, 0
				bne ReturnToNormalCode
				
								//Check if L is pressed
				bl RCheck
				mov r1, r5
				//if  r1 came back 0 then button wasn't pressed
				cmp r1, 0
				bne ReturnToNormalCode
				
ClearMomentum:
				
				bl PoseChecks
				cmp r1, 0
				beq ReturnToNormalCode
                STRB            R0, [R2,#6]
                NOP
                NOP

ReturnToNormalCode:                   
                mov            R0, #0
                STRB            R0, [R2,#3]
                STRB            R0, [R2,#4]
                NOP
                STRB            R0, [R2,#7]
                STRB            R0, [R2,#0xE]
                STRB            R0, [R2,#0xF]
                mov            R1, #0
                STRH            R0, [R2,#0x10]
                NOP
                STRH            R0, [R2,#0x1C]
                mov            R0, R2
                add            R0, #0x21
                STRB            R1, [R0]
                add            R0, #1
                STRB            R1, [R0]
                LDR             R0, =ScrewAttackState
                STRB            R1, [R0]
                STRB            R1, [R0,1]
                STRB            R1, [R0,2]
                STRB            R1, [R0,3]
                POP             {R4,R5}
                POP             {R0}
                BX              R0
nop
nop
VelocityFix:                            ; CODE XREF: HandleJumpvelocity+2C↑j
                                        ; DATA XREF: HandleJumpvelocity+58↑o ...
                LDR     R1, =SamusData
                MOV    R2, #0
                MOV    R0, #4
                STRB    R0, [R1,1]
				bl ACheck
				mov r1, r5
				//if  r1 came back 0 then button wasn't pressed
				cmp r1, 0
				bne SkipXVelocity
                STRH    R2, [R1,#0x1A]
SkipXVelocity:
                LDRH    R0, [R1,0x18]
                ADD    R0, #0x14
                STRH    R0, [R1,0x18]
				LDR 	R1, =0x80093A9
				MOV R15, r1
; ---------------------------------------------------------------------------
.pool
.align


EnableMidairMorph:                           
                LDR     R0, =Button_input
                LDRH    R0, [R0]
                AND    R2, R0
                mov     R2, #0x80
				AND     R2, R0
				CMP     r2, 0
				BEQ     normal
				LDR     R0, =0x3001244
                MOV    R1, #0xC
                STRB    R1, [R0,#(SamusPose - SomePoseStuff)]
normal:
                MOV    R2, #0xC0
                AND    R2, R0
                CMP     R2, #0
                BNE     momentumstuff
                LDR     R0, =0x3001244
                MOV    R1, #0xB
                STRB    R1, [R0,#(SamusPose - SomePoseStuff)]
                ADD    R1, R0, #0
                ADD    R1, #0x22
                STRB    R2, [R1]
                ADD    R0, #0x21
                STRB    R2, [R0]
                B       otherstuff
 
 
momentumstuff:
				ldr r2,=0x8006ACD
				mov r15, r2
otherstuff:
				ldr r2,=0x8006B63
				mov r15, r2

.pool
.align
.close