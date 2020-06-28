0800A500 B570     push    r4-r6,lr
0800A502 1C04     mov     r4,r0
0800A504 4B0A     ldr     r3,=3001588h
0800A506 490B     ldr     r1,=8239464h
0800A508 7822     ldrb    r2,[r4]      ;读取姿势
0800A50A 0050     lsl     r0,r2,1h     ;乘以2
0800A50C 1880     add     r0,r0,r2     ;三倍
0800A50E 3101     add     r1,1h
0800A510 1840     add     r0,r0,r1     ;加上偏移值
0800A512 7800     ldrb    r0,[r0]      ;读取数值
0800A514 1C19     mov     r1,r3
0800A516 3157     add     r1,57h
0800A518 7008     strb    r0,[r1]      ;标记了当前是蹲还是站还是球 
0800A51A 7820     ldrb    r0,[r4]
0800A51C 3808     sub     r0,8h
0800A51E 282A     cmp     r0,2Ah       ;在非zero suit和非跳跃姿势之间
0800A520 D900     bls     @@Goto
0800A522 E090     b       @@OtherPose
0800A524 0080     lsl     r0,r0,2h
0800A526 4904     ldr     r1,=800A53Ch
0800A528 1840     add     r0,r0,r1
0800A52A 6800     ldr     r0,[r0]
0800A52C 4687     mov     r15,r0

PoseTable:
    .word 800A5E8h  ;08
	.word 800A5E8h  ;09
	.word 800A646h  ;0A
 	.word 800A5E8h  ;0B
	.word 800A5E8h  ;0C
	.word 800A646h  ;D
	.word 800A5E8h  ;E
	.word 800A5E8h  ;F
	.word 800A646h  ;10
	.word 800A646h  ;11
	.word 800A646h  ;12
	.word 800A646h  ;13
	.word 800A5E8h  ;14
	.word 800A646h  ;15
	.word 800A646h  ;16
	.word 800A646h  ;17
	.word 800A646h  ;18
	.word 800A646h  ;19
	.word 800A646h  ;1A
	.word 800A646h  ;1B
	.word 800A646h  ;1C
	.word 800A646h  ;1D
	.word 800A646h  ;1E
	.word 800A646h  ;1F
	.word 800A646h  ;20
	.word 800A646h  ;21
	.word 800A630h  ;22
	.word 800A646h  ;23
	.word 800A646h  ;24
	.word 800A646h  ;25
	.word 800A630h  ;26
	.word 800A646h  ;27
	.word 800A646h  ;28
	.word 800A646h  ;29
	.word 800A646h  ;2A
	.word 800A646h  ;2B
	.word 800A646h  ;2C
	.word 800A646h  ;2D
	.word 800A646h  ;2E
	.word 800A5E8h  ;2F
	.word 800A5E8h  ;30
	.word 800A5E8h  ;31
	.word 800A5E8h  ;32
	
0800A5E8 1C18     mov     r0,r3
0800A5EA 3064     add     r0,64h 
0800A5EC 8B21     ldrh    r1,[r4,18h] ;跳跃最大高度值
0800A5EE 8800     ldrh    r0,[r0]     ;正向的Y值
0800A5F0 040A     lsl     r2,r1,10h   
0800A5F2 0400     lsl     r0,r0,10h
0800A5F4 1C0D     mov     r5,r1
0800A5F6 4282     cmp     r2,r0       ;检查
0800A5F8 DD01     ble     @@NoH-Jump
0800A5FA 14C2     asr     r2,r0,13h   ;18h
0800A5FC E00B     b       800A616h

@@NoH-Jump:
0800A5FE 2018     mov     r0,18h
0800A600 5E21     ldsh    r1,[r4,r0] ;读取Y值
0800A602 1C18     mov     r0,r3
0800A604 3066     add     r0,66h     ;读取负向的Y值
0800A606 2600     mov     r6,0h
0800A608 5F80     ldsh    r0,[r0,r6] 
0800A60A 4240     neg     r0,r0      ;取反
0800A60C 4281     cmp     r1,r0
0800A60E DA01     bge     800A614h
0800A610 10C2     asr     r2,r0,3h
0800A612 E000     b       800A616h
0800A614 14D2     asr     r2,r2,13h
0800A616 0429     lsl     r1,r5,10h
0800A618 4804     ldr     r0,=0FF190000h
0800A61A 4281     cmp     r1,r0
0800A61C DB10     blt     800A640h
0800A61E 1C18     mov     r0,r3
0800A620 3062     add     r0,62h
0800A622 8800     ldrh    r0,[r0]
0800A624 1A28     sub     r0,r5,r0
0800A626 8320     strh    r0,[r4,18h]
0800A628 E00A     b       800A640h
0800A62A 0000     lsl     r0,r0,0h
0800A62C 0000     lsl     r0,r0,0h
0800A62E FF197921 ????
0800A630 7921     ldrb    r1,[r4,4h]
0800A632 2001     mov     r0,1h
0800A634 4008     and     r0,r1
0800A636 2800     cmp     r0,0h
0800A638 D105     bne     800A646h
0800A63A 8B20     ldrh    r0,[r4,18h]
0800A63C 0400     lsl     r0,r0,10h
0800A63E 14C2     asr     r2,r0,13h
0800A640 8AA0     ldrh    r0,[r4,14h]
0800A642 1A80     sub     r0,r0,r2
0800A644 82A0     strh    r0,[r4,14h]

@@OtherPose:
0800A646 7860     ldrb    r0,[r4,1h]
0800A648 2800     cmp     r0,0h       ;检查是否在地面
0800A64A D114     bne     @@NoOnGround
0800A64C 1C20     mov     r0,r4
0800A64E F7FDF86D bl      800772Ch
0800A652 0400     lsl     r0,r0,10h
0800A654 14C2     asr     r2,r0,13h   ;X速度除8为位移速度
0800A656 7820     ldrb    r0,[r4]     ;姿势
0800A658 2800     cmp     r0,0h
0800A65A D10F     bne     @@NoRun
;跑步时
0800A65C 89E1     ldrh    r1,[r4,0Eh] ;读取面向
0800A65E 2010     mov     r0,10h
0800A660 4008     and     r0,r1
0800A662 2800     cmp     r0,0h
0800A664 D003     beq     @@FaceLeft
0800A666 2A00     cmp     r2,0h
0800A668 DA08     bge     800A67Ch
0800A66A 2200     mov     r2,0h
0800A66C E006     b       800A67Ch

@@FaceLeft:
0800A66E 2A00     cmp     r2,0h
0800A670 DD04     ble     800A67Ch
0800A672 2200     mov     r2,0h
0800A674 E002     b       800A67Ch

@@NoOnGround:
0800A676 8AE0     ldrh    r0,[r4,16h]   ;读取X速度
0800A678 0400     lsl     r0,r0,10h
0800A67A 14C2     asr     r2,r0,13h     ;除以8

@@NoRun:
0800A67C 8A60     ldrh    r0,[r4,12h]   ;读取X坐标
0800A67E 1880     add     r0,r0,r2      ;加上值
0800A680 8260     strh    r0,[r4,12h]   ;再写入
0800A682 BC70     pop     r4-r6
0800A684 BC01     pop     r0
0800A686 4700     bx      r0


0800772C B500     push    lr
0800772E 2116     mov     r1,16h
08007730 5E42     ldsh    r2,[r0,r1]    ;读取X速度
08007732 89C1     ldrh    r1,[r0,0Eh]   ;读取面向
08007734 8B43     ldrh    r3,[r0,1Ah]   ;读取坡
08007736 4019     and     r1,r3
08007738 2900     cmp     r1,0h
0800773A D00D     beq     @@DownSloop
0800773C 2001     mov     r0,1h
0800773E 4018     and     r0,r3
08007740 2800     cmp     r0,0h
08007742 D002     beq     @@NoSteep

;陡峭的坡
08007744 0050     lsl     r0,r2,1h     ;X速度乘以2 
08007746 1880     add     r0,r0,r2     ;三倍
08007748 E000     b       800774Ch     ;陡峭坡速度乘以五分之三

@@NoSteep:                        ;不陡峭的坡速度乘以五分之四
0800774A 0090     lsl     r0,r2,2h     ;4倍 
0800774C 2105     mov     r1,5h
0800774E F083FA71 bl      808AC34h
08007752 0400     lsl     r0,r0,10h
08007754 1402     asr     r2,r0,10h
08007756 E008     b       @@end

@@DownSloop:
08007758 2AA0     cmp     r2,0A0h
0800775A DD01     ble     8007760h
0800775C 22A0     mov     r2,0A0h      ;速度大于A0则固定速度为A0
0800775E E004     b       @@end


08007760 20A0     mov     r0,0A0h
08007762 4240     neg     r0,r0
08007764 4282     cmp     r2,r0
08007766 DA00     bge     @@end
08007768 1C02     mov     r2,r0

@@end:
0800776A 1C10     mov     r0,r2
0800776C>BC02     pop     r1
0800776E 4708     bx      r1


08007770 B510     push    r4,lr
08007772 1C04     mov     r4,r0
08007774 1C0B     mov     r3,r1
08007776 189A     add     r2,r3,r2
08007778 4293     cmp     r3,r2
0800777A DA0A     bge     8007792h
0800777C 4906     ldr     r1,=30053E0h
0800777E 0058     lsl     r0,r3,1h
08007780 1841     add     r1,r0,r1
08007782 1AD3     sub     r3,r2,r3
08007784 8820     ldrh    r0,[r4]
08007786 8008     strh    r0,[r1]
08007788 3402     add     r4,2h
0800778A 3102     add     r1,2h
0800778C 3B01     sub     r3,1h
0800778E 2B00     cmp     r3,0h
08007790 D1F8     bne     8007784h
08007792 BC10     pop     r4
08007794 BC01     pop     r0
08007796 4700     bx      r0