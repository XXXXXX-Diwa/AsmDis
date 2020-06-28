.gba
.open "zm.gba","zerosuitfix.gba",0x8000000

.org 80074f4h
    bl zerosuitball
	
.org 8304054h
zerosuitball:
    mov r1,97h
    lsl r1,1
	add r1,r7,r1
	ldrb r1,[r1]
	cmp r1,2h
	bne @@end
	mov r1,58h
	sub r1,r5,r1
	ldrh r2,[r1]
    mov r1,80h
	lsl r1,1
    and r1,r2
	cmp r1,0h
	beq @@end    	
	cmp r4,10h
	bne @@CheckPose36
	mov r4,34h
	b @@end
@@CheckPose36:
    cmp r4,39h
	bne @@CheckPose38
	mov r4,11h
	b @@end
@@CheckPose38:
    cmp r4,38h
    bne @@end
	mov r4,34h	
@@end:
    mov r1,0E0h
	lsl r1,13h
	bx r14
	
.pool
.close
	
	
    
    	
	
	
	
    
    	
         
    	