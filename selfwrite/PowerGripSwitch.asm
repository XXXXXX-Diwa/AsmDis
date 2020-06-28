.gba
.open "zm.gba","PowerGripSwitch.gba",0x8000000

.definelabel PlaySound,0x8002A18

.org 80060A4h        ;零式服强力抓动作设定地点
    bl PowerGripSwitch
    b 80060DCh
;.org 80060C0h        ;正常服装强力抓动作设定地点
;    bl PowerGripSwitch
	
.org 8304054h
PowerGripSwitch:
    push lr
    mov r1,r5
	sub r1,58h
	ldrh r1,[r1]
	mov r0,80h
	lsl r0,r0,2
	and r0,r1
	cmp r0,0h
	beq @@NoDisable
	mov r0,0FFh
	mov r10,r0
	b @@end
@@NoDisable:
    ldrb r0,[r2,12h]
    cmp r0,2h
    bne @@Normal
	mov r0,3Dh
	mov r10,r0
    mov r0,9Bh
    b @@SoundPlay
@@Normal:
    mov r0,15h
    mov r10,r0
	mov r0,r9
	add r0,5Bh
	ldrb r0,[r0]
	cmp r0,0
	beq @@NoWaterFlag
	mov r0,95h
	b @@SoundPlay
@@NoWaterFlag:	
	mov r0,7Ah
@@SoundPlay:
    bl PlaySound
@@end:
    pop r15   	

	
.pool
.close