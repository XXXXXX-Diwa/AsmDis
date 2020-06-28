.gba
.open "zm.gba","fix2.gba",0x8000000

.org 801b898h ;获得能力的音乐设置地址
    mov r0,3ah
.org 801b8cch	
    bl 8002a18h
.org 801b8b4h ;第一次获得道具的声音设置地址
    mov r0,3ah	
.pool
.close
;3000766写入1则显示的text为一行高。
	 
    