.gba
.open "zm.gba","control_switch.gba",0x8000000

;.definelabel unusedRAM,3007eb0h
;.definelabel unusedRAM,0x3001610
.definelabel checkevent,0x80608bc
.definelabel checksprite,80107F8h
 
.org 801D836h	;按钮始终出现
	b 801D844h

.org 801d850h
    bl 801D808h
    b 801D86Ch
	
.org 801d87ah
    bl 801D808h
    b 0801D886h
	
.org 801d776h
    b 801D77Eh	
		
;.org 801d48eh
   ; nop
	
.org 802ebc2h
    bl general
.org 802ecdah
    bl general
.org 802ec68h
    bl general

.org 801D914h	
    bl checkswitch

.org 801d8b0h
    bl make


	
.org 8304054h
checkswitch:         ;原检查传送停止的例程
    push r0-r2,lr
    mov r0,3dh
    bl 80107F8h    ;检查是否有传送?                            
    lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	beq @@nohave
    pop r0-r2
    add r0,r0,r2                                
	ldrh r0,[r0,14h]
	b @@end
@@nohave:
    ldr r0,=3000738h
	ldrb r1,[r0,30h]
	add r1,1h
	cmp r1,20h      ;必须累计到20帧以上才会跳转到pose9
	bls @@pass
	mov r1,0h
	strb r1,[r0,30h]
	pop r0-r2
	mov r0,1h
	b @@end
@@pass:	
	strb r1,[r0,30h]
    pop r0-r2
	mov r0,0h       ;没有传送默认恢复到pose 9
@@end:	
	pop r14
.pool

make:
    push r0-r2,lr
	mov r0,3dh
    bl checksprite      ;判断是否有传送
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh  
	bne @@have
    mov r0,1h
    mov r1,42h
	bl checkevent
@@have:	
	pop r0-r2	
    strh r1,[r0,14h] ;击中则血量写入2h                            
    mov r4,1h 
    pop r14	
.pool


general:
    push r1-r2,lr
    mov r0,3eh
    bl checksprite
	lsl r0,r0,18h                               
    lsr r0,r0,18h                               
    cmp r0,0FFh
    bne @@have	
	ldr r0,=30001a8h
	ldrh r0,[r0]
    b @@end	
@@have:
    mov r0,3h
    mov r1,42h
	bl checkevent
@@end:
    pop r1,r2
    bx r14	
	
.pool	
.close