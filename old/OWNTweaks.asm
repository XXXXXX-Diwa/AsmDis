.gba
.open "ZM.gba","OWNTweaks.gba",0x8000000
	
.definelabel checkevent,80608BCh
.definelabel respawnmusic,80039F4h
.definelabel PlaySound,8002a18h
.definelabel BreakPlaySound,8003CA0h

.org 8012d20h
    .byte 01h                ;掉落出现之前的延迟时间,原为14h

.org 80036d6h                  ;进入门设置音乐劫持
    bl musiceventchange  
.org 802e44eh
    bl activationroomusic	       ;激活房间的音乐改变
	
.org 802E3E0h 
    bl BreakPlaySound	       ;激活台播放声音的时候关闭房间音乐
	
.org 0x8007024  ;金身计数器不会在被击打后清零
    nop
.org 0x8008464 ;??
    nop		
;.org 8304bcch
.org 8304054h
musiceventchange:
    push lr
	lsl r0,10h
	lsr r4,r0,10h            ;下一个房间的音乐
    cmp r4,1h                ;如果不是的话直接结束
	bne @@retrun
	mov r0,3h
	mov r1,8h                ;检查事件号码
	bl checkevent
	cmp r0,0h
	beq @@end                ;事件没有激活重新写入原先音乐结束
	mov r4,32h               ;事件激活写入新音乐结束
	b @@retrun
@@end:
    mov r4,1h
@@retrun:	
	pop r14
.pool
                                
activationroomusic:
    push lr
	mov r0,32h              ;激活时改变当前房间音乐
	mov r1,0h
	bl respawnmusic
    mov r0,1h
	mov r1,2eh
	pop r14
	
.pool
.close	
	