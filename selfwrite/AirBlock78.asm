.gba
.open "zm.gba","AirBlock78.gba",0x8000000

;使序号78的砖块可以作为既不是最快消失,也不是超慢消失的空砖

.definelabel ClipDataBehaviorTypes,85D92ACh
.definelabel ClipDataCollisionTypes,85D91FCh
.definelabel ClipDataBehaviorTypes2,8365330h
.definelabel ClipDataCollisionTypes2,83654D0h
;.definelabel NewSpawnClipNumber,8345ADCh

.org ClipDataBehaviorTypes + 78h * 2 ;序号78行为为56
	.db 0x56
.org ClipDataCollisionTypes + 78h	;序号78碰撞为1
	.db 1
.org NewSpawnClipNumber + 16h * 2 ;序号为16
	.db 7Eh
.org ClipDataBehaviorTypes2 + 7Eh * 2 ;再生的砖块行为
	.db 0X56
.org ClipDataCollisionTypes2 +7Eh  ;再生的砖块属性
	.db 0x1

.org 80597F0h    ;调用偏移处1
	.word NewSpawnClipNumber
.org 8059878h    ;调用偏移处2
	.word NewSpawnClipNumber
.org 8059BD8h    ;调用偏移处3
	.word NewSpawnClipNumber
.org 8059CD4h    ;调用偏移处4
	.word NewSpawnClipNumber
.org 8059BB4h	 ;调用偏移处5
	.word NewClipTimesData
.org 8059C70h    ;调用偏移处6
	.word NewClipTimesData
	

;.org 0x8345b4A
;    .byte 0Fh	   ;缓慢空砖的阶段1帧数
	 
;.org 0x8345b3d    ;快速空砖在加速的时候的消失帧数
;    .byte 04h   	 
	 
;.org 0x8345b30    ;快速空砖在不加速的时候的阶段1消失帧数
;     .byte 04h    ;由于不加速时,会直接到阶段2,正常下无意义 
	 
.org 0x805A894     ;原版判断两种空砖都没有的行为值处
	bl AddSomeClipCheckBehavior
	
.org 0x8059D0E	   ;消失和恢复砖的BG1写入处
	bl AirBlock78Bg1Fix
	
.org 8304054h               ;后退龙的图片
AddSomeClipCheckBehavior:
	push r4-r7,lr
	cmp r3,56h              ;行为值是否是快速的空砖
	bne @@end
	mov r3,0h
	mov r0,16h              ;5528处的类别号 自造
	mov r1,r4
	mov r2,r5
	bl 8059DA8h
@@end:
	add r0,r4,1h
    lsl r0,r0,10h
	pop r4-r7
	pop r15
	.pool
	
	
AirBlock78Bg1Fix:   ;BG1的47E换成47D用来显示有色空砖图
	mov r2,r5
	lsl r2,r2,18h
	lsr r2,r2,18h
	cmp r2,7Eh
	bne @@end
	sub r5,1h
@@end:
	lsl r0,r0,1h
	add r0,r0,r1
	bx lr
	.pool
.align	
NewSpawnClipNumber:
	.db 00,04,05,04,06,04,09,04,0x0B,04,0x7D,04
	.db 0x0C,04,0x0D,04,0x0E,04,0x0F,04,07,04,0x0A,04
	.db 08,04,0x7C,04,0x5C,04,0x5D,04,0x5E,04,0x5F,04
	.db 0x6C,04,0x6D,04,0x6E,04,0x6F,04,0x7E,04
	
NewClipTimesData:	
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,0xFF,04,04,04,04,04
	.db 00,00,04,04,04,04,04,0xFF,04,04,04,04,04
	.db 00,00,04,04,04,04,04,0x14,04,04,04,04,04
	.db 00,05,04,04,04,04,04,0x0F,04,04,04,04,04 ;空砖
	.db 00,0x3C,04,04,04,04,04,0x1E,04,04,04,04,04 ;慢空砖
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,00,04,04,04,04,04,00,00,00,00,00,00
	.db 00,05,04,04,04,04,04,0x0F,04,04,04,04,04,00,00 ;中空砖
.close