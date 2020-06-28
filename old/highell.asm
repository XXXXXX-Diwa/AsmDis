.gba
.open "zm.gba","Highell.gba",0x8000000

.org 8044dd8h
    bl highell

;.org 8044FB0h
  ;  bl addhigh
;.org 8044DE0h
   ; sub r3,r3,r1    
 	
.org 8304054h
highell:
   ldr r0,=3000738h
   ldr r2,=0fffff080h   ;一开始的高度改变
   bx r14

.pool	 
     	 
.org 8044ef8h
    .byte 17h     ;pose 0 时跳转到17 而非55
	
.org 8045720h
    .byte 55h	  ;pose 17 后是pose 55
	
.org 8044efeh
    mov r3,40h	
	
.org 8045764h
    ldrh r2,[r0]  ;pose 17速度取反
	neg r2,r2
	
.org 8045736h
    nop           ;逃亡动画取消
    nop	
;.org 8044fb0h
    ; add r1,r0,4h
	 
	 
	 
	 
     
     	 



.close	
	
    	