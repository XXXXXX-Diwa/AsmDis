08033488 B570     push    r4-r6,lr
0803348A 4C0A     ldr     r4,=30006BCh
0803348C 1C25     mov     r5,r4
0803348E 352C     add     r5,2Ch
08033490 7829     ldrb    r1,[r5]
08033492 267F     mov     r6,7Fh
08033494 1C30     mov     r0,r6
08033496 4008     and     r0,r1
08033498 2804     cmp     r0,4h			;2c(计数)与4 and
0803349A D103     bne     @@NoPlaySound
0803349C 20BA     mov     r0,0BAh
0803349E 0040     lsl     r0,r0,1h		;播放声音174h 372
080334A0 F7CFF9D8 bl      8002854h

@@NoPlaySound:
080334A4 1C20     mov     r0,r4
080334A6 3032     add     r0,32h
080334A8 7800     ldrb    r0,[r0]		;读取冰冻时间
080334AA 2800     cmp     r0,0h
080334AC D004     beq     @@NoFreeze
080334AE F7DEFCC9 bl      8011E44h		;猜测冰冻处理函数?
080334B2 E108     b       @Thend
.pool

@@NoFreeze:
080334B8 1C20     mov     r0,r4
080334BA 3024     add     r0,24h
080334BC 7800     ldrb    r0,[r0]		;读取Pose
080334BE 285A     cmp     r0,5Ah		;大于5Ah
080334C0 D80E     bhi     @@Noorr400
080334C2 7829     ldrb    r1,[r5]
080334C4 1C30     mov     r0,r6
080334C6 4008     and     r0,r1
080334C8 2800     cmp     r0,0h			;是死物?
080334CA D009     beq     @@Noorr400
080334CC 8821     ldrh    r1,[r4]
080334CE 2002     mov     r0,2h
080334D0 4008     and     r0,r1
080334D2 2800     cmp     r0,0h			;不在屏幕内
080334D4 D004     beq     @@Noorr400
080334D6 2280     mov     r2,80h
080334D8 00D2     lsl     r2,r2,3h
080334DA 1C10     mov     r0,r2
080334DC 4308     orr     r0,r1			;orr 400 向右?
080334DE 8020     strh    r0,[r4]

@@Noorr400:
080334E0 4805     ldr     r0,=30006BCh
080334E2 3024     add     r0,24h
080334E4 7800     ldrb    r0,[r0]		;读取pose
080334E6 285B     cmp     r0,5Bh
080334E8 D900     bls     @@Pose	
080334EA E0EC     b       @Thend

@@Pose:
080334EC 0080     lsl     r0,r0,2h
080334EE 4903     ldr     r1,=PoseTable
080334F0 1840     add     r0,r0,r1
080334F2 6800     ldr     r0,[r0]
080334F4 4687     mov     r15,r0
.pool

PoseTable:
	.word 0x08033670			;Pose_0
	.word 0x08033676			;Pose_1
	.word 0x0803367A			;Pose_2
	.word @Thend			;Pose_3
	.word 0x08033692			;Pose_4
	.word 0x08033698			;Pose_5
	.word @Thend			;Pose_6
	.word @Thend			;Pose_7
	.word 0x0803368C			;Pose_8
	.word @Thend			;Pose_9
	.word @Thend			;Pose_A
	.word @Thend			;Pose_B
	.word @Thend			;Pose_C
	.word @Thend			;Pose_D
	.word @Thend			;Pose_E
	.word @Thend			;Pose_F
	.word @Thend			;Pose_10
	.word @Thend			;Pose_11
	.word @Thend			;Pose_12
	.word @Thend			;Pose_13
	.word @Thend			;Pose_14
	.word @Thend			;Pose_15
	.word 0x080336A4			;Pose_16
	.word @Thend			;Pose_17
	.word 0x08033680			;Pose_18
	.word @Thend			;Pose_19
	.word 0x08033686			;Pose_1A
	.word @Thend			;Pose_1B
	.word @Thend			;Pose_1C
	.word @Thend			;Pose_1D
	.word @Thend			;Pose_1E
	.word @Thend			;Pose_1F
	.word @Thend			;Pose_20
	.word @Thend			;Pose_21
	.word @Thend			;Pose_22
	.word @Thend			;Pose_23
	.word @Thend			;Pose_24
	.word @Thend			;Pose_25
	.word @Thend			;Pose_26
	.word @Thend			;Pose_27
	.word @Thend			;Pose_28
	.word @Thend			;Pose_29
	.word 0x0803369E			;Pose_2A
	.word @Thend			;Pose_2B
	.word @Thend			;Pose_2C
	.word @Thend			;Pose_2D
	.word @Thend			;Pose_2E
	.word @Thend			;Pose_2F
	.word @Thend			;Pose_30
	.word @Thend			;Pose_31
	.word @Thend			;Pose_32
	.word @Thend			;Pose_33
	.word @Thend			;Pose_34
	.word @Thend			;Pose_35
	.word @Thend			;Pose_36
	.word @Thend			;Pose_37
	.word @Thend			;Pose_38
	.word @Thend			;Pose_39
	.word @Thend			;Pose_3A
	.word @Thend			;Pose_3B
	.word @Thend			;Pose_3C
	.word @Thend			;Pose_3D
	.word @Thend			;Pose_3E
	.word @Thend			;Pose_3F
	.word @Thend			;Pose_40
	.word @Thend			;Pose_41
	.word @Thend			;Pose_42
	.word @Thend			;Pose_43
	.word @Thend			;Pose_44
	.word @Thend			;Pose_45
	.word @Thend			;Pose_46
	.word @Thend			;Pose_47
	.word @Thend			;Pose_48
	.word @Thend			;Pose_49
	.word @Thend			;Pose_4A
	.word @Thend			;Pose_4B
	.word @Thend			;Pose_4C
	.word @Thend			;Pose_4D
	.word @Thend			;Pose_4E
	.word @Thend			;Pose_4F
	.word @Thend			;Pose_50
	.word @Thend			;Pose_51
	.word @Thend			;Pose_52
	.word @Thend			;Pose_53
	.word @Thend			;Pose_54
	.word @Thend			;Pose_55
	.word @Thend			;Pose_56
	.word 0x080336AA			;Pose_57
	.word 0x080336AE			;Pose_58
	.word 0x080336B4			;Pose_59
	.word 0x080336B8			;Pose_5A
	.word 0x080336BE			;Pose_5B

Pose_0:
08033670 F7FEFBE4 bl      @Pose_0		;8031E3Ch
08033674 E027     b       @Thend

Pose_1:
08033676 F7FEFC35 bl      @Pose_1		;8031EE4h

Pose_2:
0803367A F7FEFCED bl      @Pose_2		;8032058h
0803367E E022     b       @Thend

Pose_18:
08033680 F7FEFD12 bl      @Pose_18		;80320A8h 3
08033684 E01F     b       @Thend

Pose_1A:
08033686 F7FEFDD5 bl      @Pose_1A		;8032234h 4
0803368A E01C     b       @Thend

Pose_8:
0803368C F7FEFE4E bl      @Pose_8		;803232Ch 8
08033690 E019     b       @Thend

Pose_4:
08033692 F7FEFE89 bl      @Pose_4		;80323A8h 7
08033696 E016     b       @Thend

Pose_5:
08033698 F7FEFEA8 bl      @Pose_5		;80323ECh 9
0803369C E013     b       @Thend

Pose_2A:
0803369E F7FEFEE3 bl      @Pose_2A		;8032468h  6
080336A2 E010     b       @Thend

Pose_16:
080336A4 F7FEFDF0 bl      @Pose_16		;8032288h  5
080336A8 E00D     b       @Thend

Pose_57:
080336AA F02EF809 bl      @Pose_57		;80616C0h

Pose_58:
080336AE F02EF81D bl      @Pose_58		;80616ECh
080336B2 E008     b       @Thend

Pose_59:								
080336B4 F7FEFBC2 bl      @Pose_59		;8031E3Ch

Pose_5A:
080336B8 F02EFE0C bl      @Pose_5A		;80622D4h
080336BC E003     b       @Thend

Pose_5B:
080336BE F7FEFB7D bl      @Pose_5B		;8031DBCh
080336C2 F02EF939 bl      8061938h

@Thend:
080336C6 BC70     pop     r4-r6
080336C8 BC01     pop     r0
080336CA 4700     bx      r0


;空行蚂蚱
080336CC B510     push    r4,lr
080336CE 4C0D     ldr     r4,=30006BCh
080336D0 1C20     mov     r0,r4
080336D2 302C     add     r0,2Ch
080336D4 7801     ldrb    r1,[r0]		;读取偏移2c
080336D6 207F     mov     r0,7Fh
080336D8 4008     and     r0,r1
080336DA 2804     cmp     r0,4h			;检查是否是4的倍数
080336DC D103     bne     @@nofour
080336DE 20BA     mov     r0,0BAh
080336E0 0040     lsl     r0,r0,1h		;播放174h 372
080336E2 F7CFF8B7 bl      8002854h

@@nofour:
080336E6 1C20     mov     r0,r4
080336E8 3032     add     r0,32h		;读取冰冻时间
080336EA 7800     ldrb    r0,[r0]
080336EC 2800     cmp     r0,0h
080336EE D00B     beq     @@nofreeze
080336F0 F7DEFBA8 bl      8011E44h		;冰冻处理函数
080336F4 1C20     mov     r0,r4
080336F6 3023     add     r0,23h
080336F8 7801     ldrb    r1,[r0]		;读取精灵序号
080336FA 2010     mov     r0,10h
080336FC F7DEFBD2 bl      8011EA4h		;副灵冰冻处理函数
08033700 E10A     b       @Thend
.pool

@@nofreeze:
08033708 1C20     mov     r0,r4
0803370A 3024     add     r0,24h
0803370C 7800     ldrb    r0,[r0]
0803370E 285B     cmp     r0,5Bh
08033710 D900     bls     @@noover		;检查pose是否小于或等于5b
08033712 E0F4     b       @@airtofloor

@@noover:
08033714 0080     lsl     r0,r0,2h
08033716 4902     ldr     r1,=PoseTable
08033718 1840     add     r0,r0,r1
0803371A 6800     ldr     r0,[r0]
0803371C 4687     mov     r15,r0
.pool

PoseTable:
	.word 0x08033894			;Pose_0
	.word 0x0803389A			;Pose_1
	.word 0x0803389E			;Pose_2
	.word 0x080338A4			;Pose_3
	.word 0x080338A8			;Pose_4
	.word 0x080338AE			;Pose_5
	.word @@airtofloor			;Pose_6
	.word @@airtofloor			;Pose_7
	.word @@airtofloor			;Pose_8
	.word @@airtofloor			;Pose_9
	.word @@airtofloor			;Pose_A
	.word @@airtofloor			;Pose_B
	.word @@airtofloor			;Pose_C
	.word @@airtofloor			;Pose_D
	.word @@airtofloor			;Pose_E
	.word @@airtofloor			;Pose_F
	.word @@airtofloor			;Pose_10
	.word @@airtofloor			;Pose_11
	.word @@airtofloor			;Pose_12
	.word @@airtofloor			;Pose_13
	.word @@airtofloor			;Pose_14
	.word @@airtofloor			;Pose_15
	.word @@airtofloor			;Pose_16
	.word @@airtofloor			;Pose_17
	.word @@airtofloor			;Pose_18
	.word @@airtofloor			;Pose_19
	.word @@airtofloor			;Pose_1A
	.word @@airtofloor			;Pose_1B
	.word @@airtofloor			;Pose_1C
	.word @@airtofloor			;Pose_1D
	.word @@airtofloor			;Pose_1E
	.word @@airtofloor			;Pose_1F
	.word @@airtofloor			;Pose_20
	.word @@airtofloor			;Pose_21
	.word @@airtofloor			;Pose_22
	.word @@airtofloor			;Pose_23
	.word @@airtofloor			;Pose_24
	.word @@airtofloor			;Pose_25
	.word @@airtofloor			;Pose_26
	.word @@airtofloor			;Pose_27
	.word @@airtofloor			;Pose_28
	.word 0x080338B4			;Pose_29
	.word 0x080338B8			;Pose_2A
	.word 0x080338BE			;Pose_2B
	.word 0x080338C2			;Pose_2C
	.word 0x080338C8			;Pose_2D
	.word 0x080338CC			;Pose_2E
	.word @@airtofloor			;Pose_2F
	.word @@airtofloor			;Pose_30
	.word @@airtofloor			;Pose_31
	.word @@airtofloor			;Pose_32
	.word @@airtofloor			;Pose_33
	.word @@airtofloor			;Pose_34
	.word @@airtofloor			;Pose_35
	.word @@airtofloor			;Pose_36
	.word @@airtofloor			;Pose_37
	.word @@airtofloor			;Pose_38
	.word @@airtofloor			;Pose_39
	.word @@airtofloor			;Pose_3A
	.word @@airtofloor			;Pose_3B
	.word @@airtofloor			;Pose_3C
	.word @@airtofloor			;Pose_3D
	.word @@airtofloor			;Pose_3E
	.word @@airtofloor			;Pose_3F
	.word @@airtofloor			;Pose_40
	.word @@airtofloor			;Pose_41
	.word @@airtofloor			;Pose_42
	.word @@airtofloor			;Pose_43
	.word @@airtofloor			;Pose_44
	.word @@airtofloor			;Pose_45
	.word @@airtofloor			;Pose_46
	.word @@airtofloor			;Pose_47
	.word @@airtofloor			;Pose_48
	.word @@airtofloor			;Pose_49
	.word @@airtofloor			;Pose_4A
	.word @@airtofloor			;Pose_4B
	.word @@airtofloor			;Pose_4C
	.word @@airtofloor			;Pose_4D
	.word @@airtofloor			;Pose_4E
	.word @@airtofloor			;Pose_4F
	.word @@airtofloor			;Pose_50
	.word @@airtofloor			;Pose_51
	.word @@airtofloor			;Pose_52
	.word @@airtofloor			;Pose_53
	.word @@airtofloor			;Pose_54
	.word @@airtofloor			;Pose_55
	.word @@airtofloor			;Pose_56
	.word 0x080338D2			;Pose_57
	.word 0x080338E2			;Pose_58
	.word 0x080338EC			;Pose_59
	.word 0x080338F0			;Pose_5A
	.word 0x080338F6			;Pose_5B

Pose_0:
08033894 F7FEFE68 bl      @Pose_0		;8032568h
08033898 E031     b       @@airtofloor

Pose_1:
0803389A F7FEFEDB bl      @Pose_1		;8032654h

Pose_2:
0803389E F7FEFEFF bl      @Pose_2		;80326A0h
080338A2 E02C     b       @@airtofloor

Pose_3:
080338A4 F7FEFEEC bl      @Pose_3		;8032680h

Pose_4:
080338A8 F7FEFF84 bl      @Pose_4		;80327B4h
080338AC E027     b       @@airtofloor

Pose_5:
080338AE F7FEFF9D bl      @Pose_5		;80327ECh
080338B2 E024     b       @@airtofloor

Pose_29:
080338B4 F7FEFFEC bl      @Pose_29		;8032890h

Pose_2A:
080338B8 F7FFF82A bl      @Pose_2A		;8032910h
080338BC E01F     b       @@airtofloor

Pose_2B:
080338BE F7FFF899 bl      @Pose_2B		;80329F4h

Pose_2C:
080338C2 F7FFF8A7 bl      @Pose_2C		;8032A14h
080338C6 E01A     b       @@airtofloor

Pose_2D:
080338C8 F7FFF8FE bl      @Pose_2D		;8032AC8h

Pose_2E:
080338CC F7FFF918 bl      @Pose_2E		;8032B00h
080338D0 E015     b       @@airtofloor

Pose_57:
080338D2 4805     ldr     r0,=30006BCh
080338D4 3023     add     r0,23h
080338D6 7801     ldrb    r1,[r0]		;读取主函数序号
080338D8 2010     mov     r0,10h
080338DA F7DEFB61 bl      8011FA0h
080338DE F02DFEEF bl      80616C0h

Pose_58:			;616d0处写入
080338E2 F02DFF03 bl      @Pose_58		;80616ECh
080338E6 E00A     b       @@airtofloor
.pool

Pose_59:
080338EC F7FEFE3C bl      @Pose_59		;8032568h  同pose0 掉翅膀了

Pose_5A:
080338F0 F02EFCF0 bl      @Pose_5A		;80622D4h
080338F4 E003     b       @@airtofloor

Pose_5B:			;6174e处写入
080338F6 F7FEFA61 bl      @Pose_5B		;8031DBCh 死亡
080338FA F02EF81D bl      8061938h

@@airtofloor:
080338FE 4A08     ldr     r2,=30006BCh
08033900 1C13     mov     r3,r2
08033902 3324     add     r3,24h
08033904 7818     ldrb    r0,[r3]
08033906 2856     cmp     r0,56h		;pose大于56则结束
08033908 D806     bhi     @Thend
0803390A 8A90     ldrh    r0,[r2,14h]	;血量大于6则结束
0803390C 2806     cmp     r0,6h
0803390E D803     bhi     @Thend
08033910 2100     mov     r1,0h
08033912 205C     mov     r0,5Ch		;id转为地行蚂蚱
08033914 7750     strb    r0,[r2,1Dh]
08033916 7019     strb    r1,[r3]		;pose改为0

@Thend:
08033918 BC10     pop     r4
0803391A BC01     pop     r0
0803391C 4700     bx      r0
.pool

///////////////////////////////////////////////////////////////////////////
;翅膀主体
08033924 B500     push    lr
08033926 4906     ldr     r1,=30006BCh
08033928 1C0A     mov     r2,r1
0803392A 3226     add     r2,26h
0803392C 2001     mov     r0,1h
0803392E 7010     strb    r0,[r2]		;忽略属性时间写入1 也就是没有判定
08033930 1C08     mov     r0,r1
08033932 3032     add     r0,32h
08033934 7800     ldrb    r0,[r0]
08033936 2800     cmp     r0,0h			;检查冰冻时间
08033938 D004     beq     @@noFreeze
0803393A F7DEFA83 bl      8011E44h		;冰冻处理函数
0803393E E01C     b       @@end
.pool

@@noFreeze:
08033944 1C08     mov     r0,r1
08033946 3024     add     r0,24h
08033948 7800     ldrb    r0,[r0]		;读取pose值
0803394A 283A     cmp     r0,3Ah
0803394C D00E     beq     @@pose3a
0803394E 283A     cmp     r0,3Ah
08033950 DC04     bgt     @@than3a
08033952 2800     cmp     r0,0h
08033954 D00D     beq     @@posezero
08033956 2838     cmp     r0,38h
08033958 D005     beq     @@pose38
0803395A E00C     b       @@pose2

@@than3a:
0803395C 2858     cmp     r0,58h
0803395E D10A     bne     @@pose2
08033960 F02DFEC4 bl      80616ECh
08033964 E009     b       @@end

@@pose38:
08033966 F7FFFA2B bl      8032DC0h
0803396A E006     b       @@end

@@pose3a:
0803396C F7FFFA46 bl      8032DFCh
08033970 E003     b       @@end

@@posezero:
08033972 F7FFF975 bl      8032C60h

@@pose2:
08033976 F7FFF9BB bl      8032CF0h

@@end:
0803397A BC01     pop     r0
0803397C 4700     bx      r0
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

;唾液
08033980 B500     push    lr
08033982 4805     ldr     r0,=30006BCh
08033984 3024     add     r0,24h
08033986 7800     ldrb    r0,[r0]			;读取pose
08033988 2802     cmp     r0,2h
0803398A D00C     beq     @@pose2
0803398C 2802     cmp     r0,2h
0803398E DC05     bgt     @@than2
08033990 2800     cmp     r0,0h
08033992 D006     beq     @@posezero
08033994 E00D     b       @@pose37
.pool

@@than2:
0803399C 2838     cmp     r0,38h
0803399E D005     beq     @@pose38
080339A0 E007     b       @@pose37

@@posezero:
080339A2 F7FFFA47 bl      8032E34h

@@pose2:
080339A6 F7FFFA7D bl      8032EA4h
080339AA E004     b       @@end

@@pose38:
080339AC F7FFFAD2 bl      8032F54h
080339B0 E001     b       @@end

@@pose37:
080339B2 F7FFFABD bl      8032F30h

@@end:
080339B6 BC01     pop     r0
080339B8 4700     bx      r0