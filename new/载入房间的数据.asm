0805656C B510     push    r4,lr
0805656E B090     add     sp,-40h
08056570 4924     ldr     r1,=875FAC4h	;区头数据地址集
08056572 4825     ldr     r0,=3000054h	;当前区号
08056574 7800     ldrb    r0,[r0]		
08056576 0080     lsl     r0,r0,2h
08056578 1840     add     r0,r0,r1		;加上区数据地址集得到当前head数据处
0805657A 4924     ldr     r1,=3000055h	
0805657C 780A     ldrb    r2,[r1]		;读取房间号
0805657E 6800     ldr     r0,[r0]		;得到区数据地址
08056580 0111     lsl     r1,r2,4h		;16倍
08056582 1A89     sub     r1,r1,r2		;15倍
08056584 0089     lsl     r1,r1,2h		;60倍
08056586 1809     add     r1,r1,r0		;加上当前区数据地址 得到当前房间head数据地址
08056588 A801     add     r0,sp,4h		;r0记录了sp+4的地址
0805658A 223C     mov     r2,3Ch
0805658C F036F896 bl      808C6BCh		;把当前区数据地址写入到内存sp+4地址中
08056590 4A1F     ldr     r2,=30000BCh
08056592 9907     ldr     r1,[sp,1Ch]	;读取BG3 bgsize
08056594 7808     ldrb    r0,[r1]
08056596 7650     strb    r0,[r2,19h]	;写入30000D5
08056598 1D0B     add     r3,r1,4		;得到解压长度地址
0805659A 491E     ldr     r1,=2007000h	
0805659C 1C18     mov     r0,r3			;bgsize加4
0805659E F7AAF9BB bl      8000918h		;swi18???
080565A2 481D     ldr     r0,=3000BF0h
080565A4 7800     ldrb    r0,[r0]		;读取暂停屏幕flag
080565A6 0600     lsl     r0,r0,18h
080565A8 1600     asr     r0,r0,18h
080565AA 2800     cmp     r0,0h
080565AC D17A     bne     @@end
080565AE 481B     ldr     r0,=3000C75h
080565B0 7800     ldrb    r0,[r0]		;开始姿势的标记
080565B2 0600     lsl     r0,r0,18h
080565B4 1600     asr     r0,r0,18h
080565B6 2800     cmp     r0,0h
080565B8 D005     beq     @@Go
080565BA 4819     ldr     r0,=300007Eh
080565BC 7800     ldrb    r0,[r0]
080565BE 0600     lsl     r0,r0,18h
080565C0 1600     asr     r0,r0,18h
080565C2 2800     cmp     r0,0h
080565C4 D008     beq     @@Gto

@@Go:
080565C6 4A17     ldr     r2,=6003000h	;地址
080565C8 2380     mov     r3,80h
080565CA 015B     lsl     r3,r3,5h		;1000h 长度
080565CC 2010     mov     r0,10h
080565CE 9000     str     r0,[sp]
080565D0 2003     mov     r0,3h			;DMA channel
080565D2 2140     mov     r1,40h		;填充值
080565D4 F7ACFE6E bl      80032B4h

@@Gto:
080565D8 4A0D     ldr     r2,=30000BCh
080565DA 7851     ldrb    r1,[r2,1h]	;BG0的属性
080565DC 2010     mov     r0,10h
080565DE 4008     and     r0,r1
080565E0 2800     cmp     r0,0h			;非10
080565E2 D025     beq     @@NoRel
080565E4 9B03     ldr     r3,[sp,0Ch]	;BG0数据地址
080565E6 4910     ldr     r1,=300009Ch	;BG0解压数据内存指针
080565E8 4A10     ldr     r2,=202A800h
080565EA 600A     str     r2,[r1]		;把指针写入
080565EC 7818     ldrb    r0,[r3]		;房间宽度
080565EE 8088     strh    r0,[r1,4h]	;写入30000A0h
080565F0 3301     add     r3,1h
080565F2 7818     ldrb    r0,[r3]		;房间长度
080565F4 80C8     strh    r0,[r1,6h]	;写入30000A2
080565F6 3301     add     r3,1h			;BGRel压缩数据地址
080565F8 2001     mov     r0,1h
080565FA 1C19     mov     r1,r3
080565FC F000FB8C bl      8056D18h
08056600 E022     b       @@BG0OK
.pool

@@NoRel:
08056630 2040     mov     r0,40h		;检查是否是LZ77
08056632 4008     and     r0,r1
08056634 2800     cmp     r0,0h
08056636 D007     beq     @@BG0OK
08056638 9B03     ldr     r3,[sp,0Ch]	;得到GB0 lz77压缩数据地址
0805663A 7818     ldrb    r0,[r3]
0805663C 7610     strb    r0,[r2,18h]	;bgsize写入
0805663E 3304     add     r3,4h			;减压长度
08056640 491A     ldr     r1,=202A800h
08056642 1C18     mov     r0,r3			;减压长度
08056644 F7AAF968 bl      8000918h

@@BG0OK:
08056648 9B06     ldr     r3,[sp,18h]	;ClipData压缩数据地址
0805664A 4C19     ldr     r4,=300009Ch
0805664C 4A19     ldr     r2,=2027800h
0805664E 61A2     str     r2,[r4,18h]	;内存地址记录
08056650 7818     ldrb    r0,[r3]
08056652 83A0     strh    r0,[r4,1Ch]	;宽度写入
08056654 3301     add     r3,1h
08056656 7818     ldrb    r0,[r3]
08056658 83E0     strh    r0,[r4,1Eh]	;长度写入
0805665A 3301     add     r3,1h
0805665C 2001     mov     r0,1h
0805665E 1C19     mov     r1,r3
08056660 F000FB5A bl      8056D18h
08056664>9B04     ldr     r3,[sp,10h]	;BG1
08056666 4A14     ldr     r2,=202D800h
08056668 60A2     str     r2,[r4,8h]
0805666A 7818     ldrb    r0,[r3]
0805666C 81A0     strh    r0,[r4,0Ch]
0805666E 3301     add     r3,1h
08056670 7818     ldrb    r0,[r3]
08056672 81E0     strh    r0,[r4,0Eh]
08056674 3301     add     r3,1h
08056676 2001     mov     r0,1h
08056678 1C19     mov     r1,r3
0805667A F000FB4D bl      8056D18h
0805667E 480F     ldr     r0,=30000BCh
08056680 78C1     ldrb    r1,[r0,3h]
08056682 2010     mov     r0,10h
08056684 4008     and     r0,r1
08056686 2800     cmp     r0,0h
08056688 D00C     beq     @@end
0805668A 9B05     ldr     r3,[sp,14h]	;BG2
0805668C 4A0C     ldr     r2,=2030800h
0805668E 6122     str     r2,[r4,10h]
08056690 7818     ldrb    r0,[r3]
08056692 82A0     strh    r0,[r4,14h]
08056694 3301     add     r3,1h
08056696 7818     ldrb    r0,[r3]
08056698 82E0     strh    r0,[r4,16h]
0805669A 3301     add     r3,1h
0805669C 2001     mov     r0,1h
0805669E 1C19     mov     r1,r3
080566A0 F000FB3A bl      8056D18h

@@end:
080566A4 B010     add     sp,40h
080566A6 BC10     pop     r4
080566A8 BC01     pop     r0
080566AA 4700     bx      r0