;[MF_U] Allows you to put items in _equivalent rooms_, meaning you can put an item in two (or more) variants of the same room and have the item removed from all of them at once.

;e.g. In the vanilla game, if you skip Bob you are not able to collect him later due to the two room variants used (Sector 3 room 0x06 and Sector 3 room 0x18) one of which contains no Bob. By using this patch and and adding a missile tank to room 0x18 Bob can be collected later.

.gba
.open "test.gba","collected_tanks_eq_rooms.gba",0x8000000

.definelabel CollectedItems,0x02037200

.definelabel CurrentArea,0x0300002C
.definelabel CurrentRoom,0x0300002D
.definelabel PointerToDecompressedBG0,0x03000084
.definelabel NonGameplayFlag,0x03000B84
.definelabel PointerToTileTable,0x03004DDC

.org 0x0806ce40
RemoveCollectedTanksWrapper:
    ldr     r0,=RemoveCollectedTanks + 1
    bx      r0
.pool

.org 0x0879ECC8
RemoveCollectedTanks:
    push    r4-r7,r14
    mov     r7,r10
    mov     r6,r9
    mov     r5,r8
    push    r5-r7
    ldr     r0,=NonGameplayFlag
    ldrb    r0,[r0]
    lsl     r0,r0,18h
    asr     r0,r0,18h
    cmp     r0,0h
    bne     @@Return
    ldr     r1,=CurrentArea
    ldrb    r0,[r1]
    cmp     r0,7h
    bhi     @@Return
    mov     r4,r0
    mov     r0,40h
    mov     r8,r0
    cmp     r4,0h
    beq     @@AreaIsMainDeck
    add     r4,1h
    b       @@PrepareLoop
.pool
@@AreaIsMainDeck:
    mov     r1,80h
    mov     r8,r1
@@PrepareLoop:
    lsl     r0,r4,8h
    ldr     r2,=CollectedItems
    add     r6,r0,r2
    mov     r4,0h
    cmp     r4,r8
    bge     @@Return
    ldr     r7,=PointerToTileTable
    mov     r10,r7
    ldr     r0,=CurrentRoom
    mov     r9,r0
    ldr     r1,=PointerToDecompressedBG0
    mov     r12,r1
@@LoopStart:
    ldrb    r0,[r6]
    cmp     r0,0FFh
    beq     @@Return
    mov     r2,r9
    ldrb    r2,[r2]
    cmp     r0,r2
    bne     @@CheckEquivalentRooms
@@RemoveBlocks:
    ldrb    r1,[r6,3h]
    mov     r5,r12
    ldrh    r0,[r5,1Ch]
    mul     r0,r1
    ldrb    r7,[r6,2h]
    add     r0,r0,r7
    ldr     r1,[r5,18h]
    lsl     r3,r0,1h
    add     r2,r3,r1
    ldrh    r0,[r2]
    mov     r7,r10
    ldr     r1,[r7,8h]
    lsl     r0,r0,1h
    add     r0,r0,r1
    ldrh    r0,[r0]
    sub     r0,2Ah
    cmp     r0,2h
    bhi     @@ThingIDontCareAbout
    ldr     r1,=802Ch
    mov     r0,r1
    strh    r0,[r2]
    ldr     r0,[r5,8h]
    add     r0,r3,r0
    mov     r2,0h
    strh    r2,[r0]
    b       @@IncrementLoop
@@CheckEquivalentRooms:
    ldr     r1,=EquivalentRoomAreaPointers
    ldr     r2,=CurrentArea
    ldrb    r2,[r2]
    lsl     r2,0x2
    ldr     r2,[r1,r2]
@@CERLoopStart:
    ldrb    r5,[r2]         ;r5 = eq[area][i][0]
    add     r2,0x1
    ldrb    r1,[r2]         ;r1 = eq[area][i][1]
    cmp     r5,0xFF
    beq     @@Return
    cmp     r5,r0
    bne     @@CERCheckSecondRoom
    b       @@CERCurrRoomCheck
@@CERCheckSecondRoom:
    cmp     r1,r0
    beq     @@CERCurrRoomCheck
@@CERIncrementLoop:
    add     r2,0x1
    b       @@CERLoopStart
@@CERCurrRoomCheck:
    ldr     r3,=CurrentRoom
    ldrb    r3,[r3]
    cmp     r5,r3
    beq     @@RemoveBlocks
    cmp     r1,r3
    beq     @@RemoveBlocks
    b       @@CERIncrementLoop
.pool

@@ThingIDontCareAbout:
    mov     r7,0h
    strh    r7,[r2]
    mov     r1,r12
    ldr     r0,[r1,8h]
    add     r0,r3,r0
    strh    r7,[r0]
@@IncrementLoop:
    add     r4,1h
    add     r6,4h
    cmp     r4,r8
    blt     @@LoopStart
@@Return:
    pop     r3-r5   
    mov     r8,r3
    mov     r9,r4
    mov     r10,r5
    pop     r4-r7
    pop     r0
    bx      r0

EquivalentRoomAreaPointers:
.word @MainDeck
.word @Sector1
.word @Sector2
.word @Sector3
.word @Sector4
.word @Sector5
.word @Sector6

EquivalentRooms:
@MainDeck:
    .db 0xFF
@Sector1:
    .db 0xFF
@Sector2:
    .db 0xFF
@Sector3:
    .db 0x06,0x18   ;This example would let you collect Bob later if you skipped it. (Would also need a modification to put a missile tank in room 0x18)
    .db 0xFF
@Sector4:
    .db 0xFF
@Sector5:
    .db 0xFF
@Sector6:
    .db 0xFF
    
.close