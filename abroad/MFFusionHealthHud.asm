.gba
.open "mf.gba", "hudhack.gba",0x8000000

;Hud Hijack
.org 0x8072768 
ldr r5, =DrawAllHud+1
bx r5
b 0x8072782 
.pool

;Blank hijack
.org 0x8000ADC  
ldr r0, =BlankNextOAM+1
bx r0
.pool


.org 0x8805000
;DMA size must come in OR'd with 0x80000000, size must be divisible by two, and be divided by two
DMA3:

.definelabel size, -0xC
.definelabel dstAdd, -8
.definelabel srcAdd, -4

PUSH    {R7,LR}
SUB     SP, SP, #0x10
ADD     R7, SP, #0
STR     R0, [R7,#0x10+srcAdd]
STR     R1, [R7,#0x10+dstAdd]
STR     R2, [R7,#0x10+size]
LDR     R3, =0x40000D4
LDR     R2, [R7,#0x10+srcAdd]
STR     R2, [R3]
LDR     R3, =0x40000D8
LDR     R2, [R7,#0x10+dstAdd]
STR     R2, [R3]
LDR     R3, =0x40000DC
LDR     R2, [R7,#0x10+size]
STR     R2, [R3]
NOP
MOV     SP, R7
ADD     SP, SP, #0x10
POP     {R7}
POP     {R0}
BX      R0


.definelabel denominator, -8
.definelabel numerator, -4 

Divide:
PUSH    {R7,LR}
SUB     SP, SP, #8
ADD     R7, SP, #0
STR     R0, [R7,#8+numerator]
STR     R1, [R7,#8+denominator]
LDR     R3, =DivArm2
LDR     R3, [R3]
LDR     R2, [R7,#8+denominator]
LDR     R1, [R7,#8+numerator]
MOV    R0, R2
BL      CallFunc
MOV    R3, R0
MOV    R0, R3
MOV     SP, R7
ADD     SP, SP, #8
POP     {R7}
POP     {R1}
BX      R1
; End of function Divide

;Loads the Target GFX and the health values into memory.
CopyGfx:

.definelabel dmaAddress, -8

PUSH    {R4-R7,LR}
MOV     LR, r9
MOV     R7, R8
PUSH    {R7,LR}
SUB     SP, SP, #0xC
ADD     R7, SP, #0
MOV     r9, R0
MOV     R8, R1
MOV    R6, R2
MOV    R5, R3

;Load Target Health
LDR     R4, =0x83E7F1C
LDR     R3, =0x80000010
STR     R3, [R7,#0xC+dmaAddress]
LDR     R3, =targetHealthTiles
LDR     R2, =0x80000040 ; size
LDR     R1, =0x6010900  ; dstAdd
MOV    R0, R3          ; srcAdd
BL      DMA3

;Load thousandths placement
MOV     R3, r9
LSL    R3, R3, #5
ADD    R3, R4, R3
MOV    R0, R3          ; srcAdd
LDR     R3, [R7,#0xC+dmaAddress]
LDR     R1, =0x6010D00  ; dstAdd
MOV    R2, R3          ; size
BL      DMA3

;Load hundreds placement
MOV     R3, R8
LSL    R3, R3, #5
ADD    R3, R4, R3
MOV    R0, R3          ; srcAdd
LDR     R3, [R7,#0xC+dmaAddress]
LDR     R1, =0x6010D20  ; dstAdd
MOV    R2, R3          ; size
BL      DMA3

;Load tens placements
MOV    R3, R6
LSL    R3, R3, #5
ADD    R3, R4, R3
MOV    R0, R3          ; srcAdd
LDR     R3, [R7,#0xC+dmaAddress]
LDR     R1, =0x6010D40  ; dstAdd
MOV    R2, R3          ; size
BL      DMA3

;Load ones placement
MOV    R3, R5
LSL    R3, R3, #5
ADD    R3, R4, R3
MOV    R0, R3          ; srcAdd
LDR     R3, [R7,#0xC+dmaAddress]
LDR     R1, =0x6010D60  ; dstAdd
MOV    R2, R3          ; size
BL      DMA3

NOP
MOV     SP, R7
ADD     SP, SP, #0xC
POP     {R2,R3}
MOV     R8, R2
MOV     r9, R3
POP     {R4-R7}
POP     {R0}
BX      R0

;
CopyGFXtoSpriteRAM:
;Under the hood
;rem = newHealth;
; firstDigit = Divide(rem, 1000);
;rem -= firstDigit * 1000;
; secondDigit = Divide(rem, 100);
;rem -= secondDigit * 100;
;unsigned char thirdDigit = Divide(rem, 10);
;rem -= thirdDigit * 10;
;fourthDigit = rem;
;CopyGfx(firstDigit, secondDigit, thirdDigit, fourthDigit)

.definelabel newHealth, -0xE
.definelabel fourthDigit, -0xC
.definelabel thirdDigit, -0xB
.definelabel secondDigit, -0xA
.definelabel firstDigit, -9
.definelabel rem, -8

PUSH    {R4-R7,LR}
SUB     SP, SP, #0x14
ADD     R7, SP, #0
MOV    R2, R0
ADD    R3, R7, #6
STRH    R2, [R3]
ADD    R3, R7, #6
LDRH    R3, [R3]
STR     R3, [R7,#0x14+rem]
LDR   R3, =#1000
LSL    R2, R3, #2
LDR     R3, [R7,#0x14+rem]
MOV    R1, R2    ; divide by 1000
MOV    R0, R3          ; numerator
BL      Divide


MOV    R2, R0
MOV    R5, #0xB
ADD    R3, R7, R5
STRB    R2, [R3]
ADD    R3, R7, R5
LDRB    R2, [R3]
MOV    R3, R2
LSL    R3, R3, #0x16
SUB    R3, R3, R2
LSL    R3, R3, #6
ADD    R3, R3, R2
LSL    R3, R3, #1
ADD    R3, R3, R2
LSL    R3, R3, #3
MOV    R2, R3
LDR     R3, [R7,#0x14+rem]
ADD    R3, R3, R2
STR     R3, [R7,#0x14+rem]
LDR     R3, [R7,#0x14+rem]
MOV    R1, #100 ; divide by 100
MOV    R0, R3          ; numerator
BL      Divide
MOV    R2, R0
MOV    R6, #0xA
ADD    R3, R7, R6
STRB    R2, [R3]
ADD    R3, R7, R6
LDRB    R2, [R3]
MOV    R3, R2
LSL    R3, R3, #0x19
SUB    R3, R3, R2
LSL    R3, R3, #2
ADD    R3, R3, R2
LSL    R3, R3, #3
SUB    R3, R3, R2
LSL    R3, R3, #2
MOV    R2, R3
LDR     R3, [R7,#0x14+rem]
ADD    R3, R3, R2
STR     R3, [R7,#0x14+rem]
LDR     R3, [R7,#0x14+rem]
MOV    R1, #10         ; divide by 100
MOV    R0, R3          ; numerator
BL      Divide


MOV    R2, R0
MOV    R1, #9
ADD    R3, R7, R1
STRB    R2, [R3]
ADD    R3, R7, R1
LDRB    R2, [R3]
MOV    R3, R2
LSL    R3, R3, #0x1D
SUB    R3, R3, R2
LSL    R3, R3, #2
SUB    R3, R3, R2
LSL    R3, R3, #1
MOV    R2, R3
LDR     R3, [R7,#0x14+rem]
ADD    R3, R3, R2
STR     R3, [R7,#0x14+rem]
MOV    R0, #8
ADD    R3, R7, R0
LDR     R2, [R7,#0x14+rem]
STRB    R2, [R3]
ADD    R3, R7, R0
LDRB    R4, [R3]
ADD    R3, R7, R1
LDRB    R2, [R3]
ADD    R3, R7, R6
LDRB    R1, [R3]
ADD    R3, R7, R5
LDRB    R0, [R3]
MOV    R3, R4
BL      CopyGfx
MOV    R3, #0
MOV    R0, R3
MOV     SP, R7
ADD     SP, SP, #0x14
POP     {R4-R7}
POP     {R1}
BX      R1
; End of function CopyGFXtoSpriteRAM
.pool
SetOAM:

.definelabel myOAM, -4

PUSH    {R7,LR}
SUB     SP, SP, #8
ADD     R7, SP, #0
LDR     R3, =0x30011E0;;Object 127 in in game memory
STR     R3, [R7,#8+myOAM]
LDR     R3, [R7,#8+myOAM]
LDR     R2, =0x4004;Shape and y pos 4
STRH    R2, [R3]
LDR     R3, [R7,#8+myOAM]
LDR     R2, =0x807E;Shape and x pos 126
STRH    R2, [R3,#2]
LDR     R3, [R7,#8+myOAM]
LDR     R2, =0x3048;Pal 0x3000 and tile 0x48
STRH    R2, [R3,#4]
NOP
MOV     SP, R7
ADD     SP, SP, #8
POP     {R7}
POP     {R0}
BX      R0

;Check if id is in list.
IsInList:

.definelabel cur, -0xC
.definelabel idCounter, -4

PUSH    {R7,LR}
SUB     SP, SP, #0x10
ADD     R7, SP, #0
STR     R0, [R7,#0x10+cur]
LDR     R3, [R7,#0x10+cur]
LDRH    R3, [R3,#0x14];Load health 
CMP     R3, #0
BEQ     IsInList_Return0
LDR     R3, [R7,#0x10+cur]
LDRH    R3, [R3] ;Load status
CMP     R3, #0
BEQ     IsInList_Return0
MOV    R3, #0
STR     R3, [R7,#0x10+idCounter]
B       IsInList_CheckIfInLoop

IsInList_CheckAgainstBssID:
LDR     R3, [R7,#0x10+cur]
LDRB    R2, [R3,#0x1D]
LDR     R1, =bossIDs
LDR     R3, [R7,#0x10+idCounter]
ADD    R3, R1, R3
LDRB    R3, [R3]
CMP     R2, R3
BNE    IsInList_IncreaseLoopCount
MOV    R3, #1
B       IsInListEnd

IsInList_IncreaseLoopCount:
LDR     R3, [R7,#0x10+idCounter]
ADD    R3, #1
STR     R3, [R7,#0x10+idCounter]

IsInList_CheckIfInLoop:
LDR     R3, [R7,#0x10+idCounter]
CMP     R3, #0xF
BLE     IsInList_CheckAgainstBssID

IsInList_Return0:
MOV    R3, #0

IsInListEnd:
MOV    R0, R3
MOV     SP, R7
ADD     SP, SP, #0x10
POP     {R7}
POP     {R1}
BX      R1
; End of function IsInList


;Gets boss health
GetBossHealth:

.definelabel curId, -8
.definelabel enemyCounter, -4

PUSH    {R7,LR}
SUB     SP, SP, #8
ADD     R7, SP, #0
MOV    R3, #0
STR     R3, [R7,#8+enemyCounter]
B       loopStart

checkEnemyId:
LDR     R2, [R7,#8+enemyCounter]
MOV    R3, R2
LSL    R3, R3, #3
SUB    R3, R3, R2
LSL    R3, R3, #3
LDR     R2, =0x3000140
MOV     R12, R2
ADD     R3, R12
STR     R3, [R7,#8+curId]
LDR     R3, [R7,#8+curId]
MOV    R0, R3          ; curId
BL      IsInList
MOV    R3, R0
CMP     R3, #1
BNE     nextEnemy
LDR     R3, [R7,#8+curId]
LDRH    R3, [R3,#0x14]
B       GetBossHealth_exitLoop

nextEnemy:
LDR     R3, [R7,#8+enemyCounter]
ADD    R3, #1
STR     R3, [R7,#8+enemyCounter]

loopStart:
LDR     R3, [R7,#8+enemyCounter]
CMP     R3, #0x16
BLE     checkEnemyId
MOV    R3, #0

GetBossHealth_exitLoop:
MOV    R0, R3
MOV     SP, R7
ADD     SP, SP, #8
POP     {R7}
POP     {R1}
BX      R1
; End of function GetBossHealth


DrawTargetHealth:

.definelabel health, -6

PUSH    {R4,R7,LR}
SUB     SP, SP, #0xC
ADD     R7, SP, #0
ADD    R4, R7, #6
BL      GetBossHealth
MOV    R3, R0
STRH    R3, [R4]
LDR     R3, =0x3004A12
MOV    R2, #0
STRB    R2, [R3]
ADD    R3, R7, #6
LDRH    R3, [R3]
CMP     R3, #1
BLS     DrawTargetHealth_End
ADD    R3, R7, #6
LDRH    R3, [R3]
LDR     R2, =0x270E
CMP     R3, R2
BHI     DrawTargetHealth_End
LDR     R3, =0x3004A12
MOV    R2, #1
STRB    R2, [R3]
ADD    R3, R7, #6
LDRH    R3, [R3]
MOV    R0, R3          ; newHealth
BL      CopyGFXtoSpriteRAM
BL      SetOAM

DrawTargetHealth_End:
NOP
MOV     SP, R7
ADD     SP, SP, #0xC
POP     {R4,R7}
POP     {R0}
BX      R0

DrawAllHud:

.definelabel var, -4

PUSH    {R7,LR}
SUB     SP, SP, #8
ADD     R7, SP, #0
MOV    R3, #0
STR     R3, [R7,#8+var]
LDR     R3, =DrawSamusHealth
LDR     R3, [R3]
BL      CallFunc
LDR     R3, =DrawMissileText
LDR     R3, [R3]
MOV    R0, #0
BL      CallFunc
LDR     R3, =DrawPowerbombText
LDR     R3, [R3]
MOV    R0, #0
BL      CallFunc
LDR     R3, =HightMissile
LDR     R3, [R3]
BL      CallFunc
LDR     R3, =DrawHUDmissileGfx
LDR     R3, [R3]
BL      CallFunc
BL      DrawTargetHealth
NOP
MOV     SP, R7
ADD     SP, SP, #8
POP     {R7}
POP     {R0}
BX      R0
; End of function DrawAllHud

BlankNextOAM:
PUSH    {LR}
PUSH  {R4-R7}
LDR     R2, =OAM_data
LDR     R0, =Next_OAM_slot
LDRB    R1, [R0]
LSL    R0, R1, #3
ADD    R2, R0, R2
MOV 	R7, 0x7f 
LDR 	r6, =0x3004A12
ldrb 	r6,[r6]
sub 	r7, r6
CMP     R1, R7 
BGT     BlankNextOAM_End
MOV    R0, #0xFF
MOV    R3, #0
BlankNextOAM_Loop:                             
STRH    R0, [R2]
ADD    R2, #2
STRH    R0, [R2]
ADD    R2, #2
STRH    R3, [R2]
ADD    R2, #4
ADD    R1, #1
CMP     R1, R7
BLE     BlankNextOAM_Loop
BlankNextOAM_End:    
POP   {R4-R7}      		   
POP     {R0}
BX      R0		
.pool

.definelabel OAM_data, 0x3000DE8
.definelabel Next_OAM_slot, 0x30011EE	

nop

;Calls 
CallFunc:
BX      R3

.pool

;Data
DrawSamusHealth:.dd 0x8071C4D
DrawMissileText:.dd  0x807223D
DrawPowerbombText:.dd 0x8072435
HightMissile:.dd 0x807262D
DrawHUDmissileGfx:.dd 0x80719F9
DivArm2:.dd 0x8004BA5
DivRemainder2:.dd  0x8004BA9

.align 4
bossIDs:
.byte 0x11, 0x3A, 0x4B, 0x51, 0x54, 0x55, 0x62
.byte 0x8C, 0x8D, 0xA0, 0xC0, 0xC1, 0xC3, 0xC9
.byte 0xCB, 0xCD, 0xCE
.align 4
targetHealthTiles: 
.byte 0x00,0x00,0x00,0x00,0x00,0x00,0x44,0x44,0x00,0x00,0x14,0x11,0x00,0x00,0x44,0x41
.byte 0x00,0x00,0x44,0x41,0x00,0x00,0x44,0x41,0x00,0x00,0x44,0x41,0x00,0x00,0x44,0x44
.byte 0x00,0x00,0x00,0x00,0x44,0x44,0x44,0x44,0x44,0x11,0x14,0x41,0x14,0x14,0x14,0x14
.byte 0x14,0x14,0x14,0x41,0x14,0x11,0x14,0x14,0x14,0x14,0x14,0x14,0x44,0x44,0x44,0x44
.byte 0x00,0x00,0x00,0x00,0x44,0x44,0x44,0x44,0x44,0x11,0x14,0x41,0x14,0x44,0x14,0x44
.byte 0x14,0x14,0x14,0x41,0x14,0x14,0x14,0x44,0x44,0x11,0x14,0x41,0x44,0x44,0x44,0x44
.byte 0x00,0x00,0x00,0x00,0x44,0x44,0x00,0x00,0x11,0x41,0x00,0x00,0x14,0x44,0x00,0x00
.byte 0x14,0x44,0x00,0x00,0x14,0x44,0x00,0x00,0x14,0x44,0x00,0x00,0x44,0x44,0x00,0x00

.byte 0xFFFFFF
.align 4
.close