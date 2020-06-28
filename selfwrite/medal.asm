.gba
.open "1276 - Medal of Honor - Infiltrator(UE).gba","Honor.gba", 0x8000000

	
	
.org 81e7220h                  ;关卡增加数据
     ldr     r2,=2007A58h				
;     ldrb    r0,[r2,1h]        ;小关数				
     mov     r1,1h				
     ldsb    r0,[r2,r1]        ;同样(负)???							
     cmp     r0,3h				
     beq     @@AddBigCheckPoint				
     cmp     r0,5h			   ;第二大关第三小关不可经过
     beq     @@AddBigCheckPoint				
     cmp     r0,9h				
     beq     @@AddBigCheckPoint				
     cmp     r0,0Ch				
     beq     @@AddBigCheckPoint				
     cmp     r0,0Fh            ;每三关后都会进入下面的例程				
     bne     @@PassAddBigCheckPoint							
@@AddBigCheckPoint:								
     ldrb    r0,[r2]				
     add     r0,1h             ;大关数加1再写入				
     strb    r0,[r2]		 		
     ldrb    r0,[r2,1h]        ;小关数
@@PassAddBigCheckPoint: 
	 cmp     r0,1h
	 beq     @@PassSmallCheckPoint
	 cmp     r0,5h
	 beq     @@PassSmallCheckPoint
	 cmp     r0,7h
     beq     @@PassSmallCheckPoint
	 cmp     r0,9h
	 beq     @@PassSmallCheckPoint
     cmp     r0,0Dh
	 bne     @@end
@@PassSmallCheckPoint:				
     add     r0,2h				
	 strb    r0,[r2,1h]
	 b       @@Return                  				  				
@@end:				
     add     r0,1h				
     strb    r0,[r2,1h]								
@@Return:				
     bx      r14				



.pool
.close