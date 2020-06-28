080085B0 B530     push    r4,r5,lr
080085B2 1C02     mov     r2,r0
080085B4 4D04     ldr     r5,=3001528h
080085B6 4C05     ldr     r4,=3001588h
080085B8 7951     ldrb    r1,[r2,5h]
080085BA 2900     cmp     r1,0h              ;检查金身flag
080085BC D10A     bne     @@HaveSparkingFlag
080085BE 4804     ldr     r0,=8238D8Ch
080085C0 6803     ldr     r3,[r0]            ;2482f4
080085C2 7029     strb    r1,[r5]            ;旋转攻击flag为0
080085C4 E00A     b       @@Peer

@@HaveSparkingFlag:
080085D4 4810     ldr     r0,=8238DACh
080085D6 6803     ldr     r3,[r0]            ;2490d4
080085D8 2001     mov     r0,1h
080085DA 7028     strb    r0,[r5]            ;旋转攻击flag为1

@@Peer:
080085DC 7F50     ldrb    r0,[r2,1Dh]        ;读取萨姆斯当前动画
080085DE 0100     lsl     r0,r0,4h
080085E0 181B     add     r3,r3,r0
080085E2 7B19     ldrb    r1,[r3,0Ch]        ;读取当前动画帧数 
080085E4 345B     add     r4,5Bh
080085E6 7820     ldrb    r0,[r4]            ;读取无重力在水中flag
080085E8 2800     cmp     r0,0h
080085EA D001     beq     @@NoWaterFlag
080085EC 0648     lsl     r0,r1,19h
080085EE 0E01     lsr     r1,r0,18h          ;有水动画帧数乘以2

@@NoWaterFlag:
080085F0 7F10     ldrb    r0,[r2,1Ch]        ;读取动画帧
080085F2 4288     cmp     r0,r1              ;当前帧数比较最大动画帧数
080085F4 D349     bcc     @@AmiationFramesNoEnd
080085F6 2000     mov     r0,0h
080085F8 7710     strb    r0,[r2,1Ch]        ;动画帧写入0
080085FA 7F50     ldrb    r0,[r2,1Dh]        ;读取动画加1再写入
080085FC 3001     add     r0,1h
080085FE 7750     strb    r0,[r2,1Dh]
08008600 7F18     ldrb    r0,[r3,1Ch]        ;读取动画帧
08008602 2800     cmp     r0,0h
08008604 D100     bne     @@Pass
08008606 7750     strb    r0,[r2,1Dh]

@@Pass:
08008608 7F50     ldrb    r0,[r2,1Dh]
0800860A 2802     cmp     r0,2h
0800860C D01C     beq     @@AnimationTwo
0800860E 2802     cmp     r0,2h
08008610 DC04     bgt     @@AnimationMoreTwo
08008612 2801     cmp     r0,1h
08008614 D007     beq     @@AnimationOne
08008616 E038     b       @@AmiationFramesNoEnd

@@AnimationMoreTwo:
0800861C 2806     cmp     r0,6h
0800861E D01F     beq     @@AnimationSix
08008620 2807     cmp     r0,7h
08008622 D017     beq     @@AnimationSeven
08008624 E031     b       @@AmiationFramesNoEnd

@@AnimationOne:
08008626 7820     ldrb    r0,[r4]
08008628 2800     cmp     r0,0h                 ;读取无重力在水flag
0800862A D11C     bne     @@HaveWaterFlag2
0800862C 4803     ldr     r0,=3001530h
0800862E 7C80     ldrb    r0,[r0,12h]    
08008630 2802     cmp     r0,2h                 ;检查是否是零式服    
08008632 D005     beq     @@ZSRuningSound
08008634 2064     mov     r0,64h
08008636 F7FAF9EF bl      8002A18h              ;装甲服的脚部声
0800863A E026     b       @@AmiationFramesNoEnd


@@ZSRuningSound:
08008640 2096     mov     r0,096h
08008642 F7FAF9E9 bl      8002A18h              ;零式服的脚步声
08008646 E020     b       @@AmiationFramesNoEnd

@@AnimationTwo:
08008648 1C10     mov     r0,r2
0800864A 2100     mov     r1,0h
0800864C 2200     mov     r2,0h
0800864E F7FDFDE1 bl      8006214h
08008652 E01A     b       @@AmiationFramesNoEnd

@@AnimationSeven:
08008654 1C10     mov     r0,r2
08008656 2100     mov     r1,0h
08008658 2201     mov     r2,1h
0800865A F7FDFDDB bl      8006214h
0800865E E014     b       800868Ah

@@AnimationSix:
08008660 7820     ldrb    r0,[r4]
08008662 2800     cmp     r0,0h
08008664 D003     beq     800866Eh

@@HaveWaterFlag2:
08008666 2093     mov     r0,093h
08008668 F7FAF9D6 bl      8002A18h
0800866C E00D     b       800868Ah
0800866E 4804     ldr     r0,=3001530h
08008670 7C80     ldrb    r0,[r0,12h]
08008672 2802     cmp     r0,2h
08008674 D006     beq     8008684h
08008676 2065     mov     r0,65h
08008678 F7FAF9CE bl      8002A18h
0800867C E005     b       800868Ah
0800867E 0000     lsl     r0,r0,0h
08008680 1530     asr     r0,r6,14h
08008682 0300     lsl     r0,r0,0Ch
08008684 2097     mov     r0,097h
08008686 F7FAF9C7 bl      8002A18h

@@AmiationFramesNoEnd:
0800868A 7828     ldrb    r0,[r5]
0800868C 2800     cmp     r0,0h
0800868E D01B     beq     80086C8h
08008690 7868     ldrb    r0,[r5,1h]
08008692 3001     add     r0,1h
08008694 7068     strb    r0,[r5,1h]
08008696 4B0E     ldr     r3,=8288E20h
08008698 78AA     ldrb    r2,[r5,2h]
0800869A 0051     lsl     r1,r2,1h
0800869C 1889     add     r1,r1,r2
0800869E 0089     lsl     r1,r1,2h
080086A0 18C9     add     r1,r1,r3
080086A2 0600     lsl     r0,r0,18h
080086A4 0E00     lsr     r0,r0,18h
080086A6 7A09     ldrb    r1,[r1,8h]
080086A8 4288     cmp     r0,r1
080086AA D30D     bcc     80086C8h
080086AC 2000     mov     r0,0h
080086AE 7068     strb    r0,[r5,1h]
080086B0 78A8     ldrb    r0,[r5,2h]
080086B2 3001     add     r0,1h
080086B4 70A8     strb    r0,[r5,2h]
080086B6 78A9     ldrb    r1,[r5,2h]
080086B8 0048     lsl     r0,r1,1h
080086BA 1840     add     r0,r0,r1
080086BC 0080     lsl     r0,r0,2h
080086BE 18C0     add     r0,r0,r3
080086C0 7A00     ldrb    r0,[r0,8h]
080086C2 2800     cmp     r0,0h
080086C4 D100     bne     80086C8h
080086C6 70A8     strb    r0,[r5,2h]
080086C8 20FF     mov     r0,0FFh
080086CA BC30     pop     r4,r5
080086CC BC02     pop     r1
080086CE 4708     bx      r1

080086D0 8E20     ldrh    r0,[r4,30h]
080086D2 0828     lsr     r0,r5,20h
080086D4 B570     push    r4-r6,lr
080086D6 1C04     mov     r4,r0
080086D8 480F     ldr     r0,=300137Ch
080086DA 8801     ldrh    r1,[r0]
080086DC 2030     mov     r0,30h
080086DE 4008     and     r0,r1
080086E0 2800     cmp     r0,0h
080086E2 D11F     bne     8008724h
080086E4 480D     ldr     r0,=3001380h
080086E6 8801     ldrh    r1,[r0]
080086E8 2001     mov     r0,1h
080086EA 4008     and     r0,r1
080086EC 2800     cmp     r0,0h
080086EE D019     beq     8008724h
080086F0 7A20     ldrb    r0,[r4,8h]
080086F2 2800     cmp     r0,0h
080086F4 D016     beq     8008724h
080086F6 480A     ldr     r0,=823A554h
080086F8 8881     ldrh    r1,[r0,4h]
080086FA 3920     sub     r1,20h
080086FC 0409     lsl     r1,r1,10h
080086FE 1409     asr     r1,r1,10h
08008700 1C20     mov     r0,r4
08008702 F7FDF873 bl      80057ECh
08008706 0600     lsl     r0,r0,18h
08008708 2800     cmp     r0,0h
0800870A D10B     bne     8008724h
0800870C 8AA0     ldrh    r0,[r4,14h]
0800870E 3820     sub     r0,20h
08008710 82A0     strh    r0,[r4,14h]
08008712 2021     mov     r0,21h
08008714 E07F     b       8008816h
08008716 0000     lsl     r0,r0,0h
08008718 137C     asr     r4,r7,0Dh
0800871A 0300     lsl     r0,r0,0Ch
0800871C 1380     asr     r0,r0,0Eh
0800871E 0300     lsl     r0,r0,0Ch
08008720 A554     add     r5,=8008874h
08008722 0823     lsr     r3,r4,20h
08008724 1C20     mov     r0,r4
08008726 F7FFFC99 bl      800805Ch
0800872A 0600     lsl     r0,r0,18h
0800872C 2800     cmp     r0,0h
0800872E D001     beq     8008734h
08008730 20FE     mov     r0,0FEh
08008732 E070     b       8008816h
08008734 4804     ldr     r0,=300137Ch
08008736 8802     ldrh    r2,[r0]
08008738 89E1     ldrh    r1,[r4,0Eh]
0800873A 1C10     mov     r0,r2
0800873C 4008     and     r0,r1
0800873E 2800     cmp     r0,0h
08008740 D004     beq     800874Ch
08008742 2000     mov     r0,0h
08008744 E067     b       8008816h
08008746 0000     lsl     r0,r0,0h
08008748 137C     asr     r4,r7,0Dh
0800874A 0300     lsl     r0,r0,0Ch
0800874C 4803     ldr     r0,=3001588h
0800874E 1C06     mov     r6,r0
08008750 365C     add     r6,5Ch
08008752 7830     ldrb    r0,[r6]
08008754 2800     cmp     r0,0h
08008756 D003     beq     8008760h
08008758 2003     mov     r0,3h
0800875A E05C     b       8008816h
0800875C 1588     asr     r0,r1,16h
0800875E 0300     lsl     r0,r0,0Ch
08008760 2030     mov     r0,30h
08008762 4048     eor     r0,r1
08008764 4010     and     r0,r2
08008766 2800     cmp     r0,0h
08008768 D001     beq     800876Eh
0800876A 2002     mov     r0,2h
0800876C E053     b       8008816h
0800876E 4812     ldr     r0,=3001380h
08008770 8801     ldrh    r1,[r0]
08008772 2580     mov     r5,80h
08008774 1C28     mov     r0,r5
08008776 4008     and     r0,r1
08008778 2800     cmp     r0,0h
0800877A D02A     beq     80087D2h
0800877C 8AA0     ldrh    r0,[r4,14h]
0800877E 3004     add     r0,4h
08008780 0400     lsl     r0,r0,10h
08008782 0C00     lsr     r0,r0,10h
08008784 8A61     ldrh    r1,[r4,12h]
08008786 F04FFC7B bl      8058080h
0800878A 1400     asr     r0,r0,10h
0800878C 2801     cmp     r0,1h
0800878E D02F     beq     80087F0h
08008790 480A     ldr     r0,=3001414h
08008792 7800     ldrb    r0,[r0]
08008794 2800     cmp     r0,0h
08008796 D002     beq     800879Eh
08008798 78A0     ldrb    r0,[r4,2h]
0800879A 2802     cmp     r0,2h
0800879C D132     bne     8008804h
0800879E 4C08     ldr     r4,=3001530h
080087A0 7CA0     ldrb    r0,[r4,12h]
080087A2 2802     cmp     r0,2h
080087A4 D002     beq     80087ACh
080087A6 2079     mov     r0,79h
080087A8 F7FAF936 bl      8002A18h
080087AC 7830     ldrb    r0,[r6]
080087AE 2800     cmp     r0,0h
080087B0 D008     beq     80087C4h
080087B2 2006     mov     r0,6h
080087B4 E02F     b       8008816h
080087B6 0000     lsl     r0,r0,0h
080087B8 1380     asr     r0,r0,0Eh
080087BA 0300     lsl     r0,r0,0Ch
080087BC 1414     asr     r4,r2,10h
080087BE 0300     lsl     r0,r0,0Ch
080087C0 1530     asr     r0,r6,14h
080087C2 0300     lsl     r0,r0,0Ch
080087C4 7CA0     ldrb    r0,[r4,12h]
080087C6 2802     cmp     r0,2h
080087C8 D101     bne     80087CEh
080087CA 203C     mov     r0,3Ch
080087CC E023     b       8008816h
080087CE 2004     mov     r0,4h
080087D0 E021     b       8008816h
080087D2 2540     mov     r5,40h
080087D4 1C28     mov     r0,r5
080087D6 4008     and     r0,r1
080087D8 2800     cmp     r0,0h
080087DA D013     beq     8008804h
080087DC 8AA0     ldrh    r0,[r4,14h]
080087DE 3004     add     r0,4h
080087E0 0400     lsl     r0,r0,10h
080087E2 0C00     lsr     r0,r0,10h
080087E4 8A61     ldrh    r1,[r4,12h]
080087E6 F04FFC4B bl      8058080h
080087EA 1400     asr     r0,r0,10h
080087EC 2802     cmp     r0,2h
080087EE D109     bne     8008804h
080087F0 8A61     ldrh    r1,[r4,12h]
080087F2 4803     ldr     r0,=0FFC0h
080087F4 4008     and     r0,r1
080087F6 3020     add     r0,20h
080087F8 8260     strh    r0,[r4,12h]
080087FA 8225     strh    r5,[r4,10h]
080087FC 201F     mov     r0,1Fh
080087FE E00A     b       8008816h
08008800 FFC00000 ????
08008802 0000     lsl     r0,r0,0h
08008804 7AA0     ldrb    r0,[r4,0Ah]
08008806 2800     cmp     r0,0h
08008808 D001     beq     800880Eh
0800880A 3801     sub     r0,1h
0800880C 72A0     strb    r0,[r4,0Ah]
0800880E 1C20     mov     r0,r4
08008810 F7FFF8C8 bl      80079A4h
08008814 20FF     mov     r0,0FFh
08008816 BC70     pop     r4-r6
08008818 BC02     pop     r1
0800881A 4708     bx      r1
0800881C B510     push    r4,lr
0800881E 1C04     mov     r4,r0
08008820 2100     mov     r1,0h
08008822 F7FFFE2B bl      800847Ch
08008826 0600     lsl     r0,r0,18h
08008828 0E00     lsr     r0,r0,18h
0800882A 2802     cmp     r0,2h
0800882C D101     bne     8008832h
0800882E 2000     mov     r0,0h
08008830 7760     strb    r0,[r4,1Dh]
08008832 20FF     mov     r0,0FFh
08008834 BC10     pop     r4
08008836 BC02     pop     r1
08008838 4708     bx      r1
0800883A 0000     lsl     r0,r0,0h
0800883C B510     push    r4,lr
0800883E 1C04     mov     r4,r0
08008840 480F     ldr     r0,=300137Ch
08008842 8801     ldrh    r1,[r0]
08008844 2030     mov     r0,30h
08008846 4008     and     r0,r1
08008848 2800     cmp     r0,0h
0800884A D11F     bne     800888Ch
0800884C 480D     ldr     r0,=3001380h
0800884E 8801     ldrh    r1,[r0]
08008850 2001     mov     r0,1h
08008852 4008     and     r0,r1
08008854 2800     cmp     r0,0h
08008856 D019     beq     800888Ch
08008858 7A20     ldrb    r0,[r4,8h]
0800885A 2800     cmp     r0,0h
0800885C D016     beq     800888Ch
0800885E 480A     ldr     r0,=823A554h
08008860 8881     ldrh    r1,[r0,4h]
08008862 3920     sub     r1,20h
08008864 0409     lsl     r1,r1,10h
08008866 1409     asr     r1,r1,10h
08008868 1C20     mov     r0,r4
0800886A F7FCFFBF bl      80057ECh
0800886E 0600     lsl     r0,r0,18h
08008870 2800     cmp     r0,0h
08008872 D10B     bne     800888Ch
08008874 8AA0     ldrh    r0,[r4,14h]
08008876 3820     sub     r0,20h
08008878 82A0     strh    r0,[r4,14h]
0800887A 2021     mov     r0,21h
0800887C E039     b       80088F2h
0800887E 0000     lsl     r0,r0,0h
08008880 137C     asr     r4,r7,0Dh
08008882 0300     lsl     r0,r0,0Ch
08008884 1380     asr     r0,r0,0Eh
08008886 0300     lsl     r0,r0,0Ch
08008888 A554     add     r5,=80089DCh
0800888A 0823     lsr     r3,r4,20h
0800888C 1C20     mov     r0,r4
0800888E F7FFFBE5 bl      800805Ch
08008892 0600     lsl     r0,r0,18h
08008894 2800     cmp     r0,0h
08008896 D001     beq     800889Ch
08008898 20FE     mov     r0,0FEh
0800889A E02A     b       80088F2h
0800889C 480F     ldr     r0,=3001380h
0800889E 8801     ldrh    r1,[r0]
080088A0 2080     mov     r0,80h
080088A2 4008     and     r0,r1
080088A4 2800     cmp     r0,0h
080088A6 D00F     beq     80088C8h
080088A8 480D     ldr     r0,=3001414h
080088AA 7800     ldrb    r0,[r0]
080088AC 2800     cmp     r0,0h
080088AE D002     beq     80088B6h
