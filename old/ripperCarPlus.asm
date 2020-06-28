.gba
.open "ZM.gba","ripperCarPlus.gba",0x8000000
;这是一个让ripperII（ID 71）变成可以乘坐的浮游平台的补丁。制作者；JumZhu.Diwa
.org 801c0cah
    bl ripperleft
.org 801c096h
    bl ripperight	
.org 801c016h
    .byte 0x03	        ;ripper属性为固体
.org 801c09ah
    .halfword 0xE018	;更改跳转
.org 8304054h           ;无用数据地址
ripperight:
    ldrh r0,[r4,4h]     ;调用ripper X轴坐标数值
	add r0,4h           ;增加x轴坐标值
	strh r0,[r4,4h]     ;写入新值
    ldrh r4,[r4]        ;调用当前精灵的某值，左为43h，右为3h，若踩在上面则加0x1000？？
	mov r0,80h          
	lsl r0,r0,5h        ;相当于r0乘以20h，值为1000h？？
	and r0,r4           ;1000and10xx或1000and00xx？？
	cmp r0,0h           ;若不为0，则乘坐
    beq @@notake        ;若为0，则不乘坐
	ldr r4,=3000738h
	ldrh r0,[r4,4h]
	add r0,4h
	strh r0,[r4,4h]
	ldr r4,=30013d4h    
	ldrh r0,[r4,12h]    ;调用乘客x坐标
	add r0,8h           ;给予相等的值
	strh r0,[r4,12h]    ;写入新值
	ldr r4,=3000738h    ;返还r4原值
@@notake:
    bx r14
ripperleft:
	sub r0,4h
	strh r0,[r4,4h]
    ldrh r4,[r4]
	mov r0,80h
	lsl r0,r0,5h
	and r0,r4
	cmp r0,0h
    beq @@return
	ldr r4,=3000738h
	ldrh r0,[r4,4h]
	sub r0,4h
	strh r0,[r4,4h]
	ldr r4,=30013d4h
	ldrh r0,[r4,12h]
    sub r0,8h
	strh r0,[r4,12h]
	ldr r4,=3000738h
@@return:
    bx r14	
.pool
.close
	
	