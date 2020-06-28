.gba
.open "zm.gba","Geron.gba",0x8000000

.definelabel SpriteData,0x30001AC
.definelabel SpriteDataEnd,0x30006EC
.definelabel PlaySound2,8002b20h
.definelabel CheckEvent,80608bch
.definelabel SpritePalPointers,0x875EEF0

.definelabel bloodballID,0x8C
.definelabel blueballID,0x8D
.definelabel greenballID,0x8E
.definelabel brownballID,0x8F
.definelabel godenballID,0x90


.org 0x8760d38
bloodballPal:
    .import "bloodball.palette"
.align
	
.org SpritePalPointers + (bloodballID - 0x10) * 4
    .word bloodballPal
	
    
.org 0x8044B14               ;同ID晃动纠缠
	bl interference
	ldr r0,=26Bh
	bl PlaySound2
	b 8044C0Eh
.pool	

.org 0x8044AE6               ;同ID腐败纠缠
    bl interference2
	
.org 0x8044944
    b 8044950h               ;8D球不检查高跳指引事件	
	
.org 0x8044BAC
    b 8044C0Eh	             ;原本在23才激活的事件跳过
	
.org 0x8304054
interference:                ;让一个房间同ID的量子球一起晃动
    push r4-r6
	ldrb r5,[r3,1Dh]
	ldr r4,=SpriteData
	ldr r6,=SpriteDataEnd
	ldr r1,=8309348h         ;晃动的OAM
	str r1,[r3,18h]
	mov r0,0h
	strh r0,[r3,16h]
	strb r0,[r3,1Ch]
@@Loop:	
	ldrb r0,[r4,1Dh]
	cmp r0,r5
	bne @@NextCheck
	str r1,[r4,18h]
	mov r0,0h
    strh r0,[r4,16h]
	strb r0,[r4,1Ch]
@@NextCheck:
    add r4,38h
    cmp r4,r6
    bls @@Loop
	pop r4-r6
	bx r14
.pool	

interference2:               ;让一个房间的同ID量子球一起销毁
    push r4-r6,lr            ;并且触发腐败的瞬间就写入事件
    mov r2,0C8h
	strb r2,[r1]
	ldr r4,=SpriteDataEnd
	ldr r5,=8309248h
	ldrb r2,[r3,1Dh]
	ldr r1,=SpriteData
@@Loop:	
	mov r6,r1
	add r6,24h
	ldrb r0,[r1,1Dh]
	cmp r0,r2
	bne @@NextCheck
	mov r0,0h
	str r5,[r1,18h]
	strh r0,[r1,16h]
	strb r0,[r1,1Ch]
	mov r0,23h
	strb r0,[r6]
@@NextCheck:
    add r1,38h
    cmp r1,r4
    bls @@Loop	
;@@EventActivation:
    cmp r2,8Ch
	bne @@IDNo8C
	mov r0,1h
	mov r1,2Fh
	bl CheckEvent
	b @@end
@@IDNo8C:
    cmp r2,8Dh
    bne @@IDNo8D
    mov r0,1h
    mov r1,30h
    bl CheckEvent
    b @@end
@@IDNo8D:
    cmp r2,8Eh
    bne @@IDNo8E
    mov r0,1h
    mov r1,31h
    bl CheckEvent
    b @@end
@@IDNo8E:
    cmp r2,8Fh
    bne @@IDNo8F
    mov r0,1h
    mov r1,32h
    bl CheckEvent
    b @@end
@@IDNo8F:
    cmp r2,90h
    bne @@end
    mov r0,1h
    mov r1,33h
    bl CheckEvent	
@@end:	
    pop r4-r6
	pop r0
	bx r0
.pool
.close
	
	