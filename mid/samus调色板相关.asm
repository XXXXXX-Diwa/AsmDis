0800B474 B4E0     push    r5-r7
0800B476 B082     add     sp,-8h
0800B478 1C05     mov     r5,r0
0800B47A 4917     ldr     r1,=3005440h
0800B47C 2040     mov     r0,40h
0800B47E 8008     strh    r0,[r1]				
0800B480 4916     ldr     r1,=3001414h
0800B482 7988     ldrb    r0,[r1,6h]			;读取光束相关的调色时间
0800B484 2800     cmp     r0,0h
0800B486 D001     beq     @@PassBeamPaletteTimeSub
0800B488 3801     sub     r0,1h
0800B48A 7188     strb    r0,[r1,6h]

@@PassBeamPaletteTimeSub:
0800B48C 7A68     ldrb    r0,[r5,9h]			;读取解除球变形的调色时间
0800B48E 2800     cmp     r0,0h
0800B490 D001     beq     @@PassUnmorphPaletteTimeSub
0800B492 3801     sub     r0,1h
0800B494 7268     strb    r0,[r5,9h]

@@PassUnmorphPaletteTimeSub:
0800B496 4A12     ldr     r2,=3001530h
0800B498 7C90     ldrb    r0,[r2,12h]			;读取服装
0800B49A 1C01     mov     r1,r0
0800B49C 466A     mov     r2,r13				;3007E24
0800B49E 7110     strb    r0,[r2,4h]			;3007E28写入当前的服装
0800B4A0 2901     cmp     r1,1h					;检查是否是全装甲
0800B4A2 D157     bne     @@NoFullPowerSuit
0800B4A4 480E     ldr     r0,=3001530h
0800B4A6 7BC1     ldrb    r1,[r0,0Fh]
0800B4A8 2020     mov     r0,20h
0800B4AA 4008     and     r0,r1
0800B4AC 2800     cmp     r0,0h					;检查重力服是否激活
0800B4AE D02B     beq     @@GravitySuitNoActivation
0800B4B0 490C     ldr     r1,=82383C8h			;全装甲+重力服
0800B4B2 4688     mov     r8,r1					;重力服主调色板
0800B4B4 4A0C     ldr     r2,=8238428h			;重力服short光束调色
0800B4B6 4694     mov     r12,r2
0800B4B8 4E0C     ldr     r6,=82384C8h			;重力服挨打调色1
0800B4BA 480D     ldr     r0,=8238508h			;重力服加速调色1
0800B4BC 4682     mov     r10,r0
0800B4BE 490D     ldr     r1,=8238568h			;重力服变人调色1
0800B4C0 9100     str     r1,[sp]
0800B4C2 4A0D     ldr     r2,=8238608h			;重力服Short蓄力光束调色
0800B4C4 4691     mov     r9,r2
0800B4C6 480D     ldr     r0,=823A224h
0800B4C8 7F69     ldrb    r1,[r5,1Dh]			;读取动画值
0800B4CA 0089     lsl     r1,r1,2h
0800B4CC 1808     add     r0,r1,r0				;加上偏移
0800B4CE 6803     ldr     r3,[r0]				;读取地址
0800B4D0 4F0B     ldr     r7,=82379E8h
0800B4D2 480C     ldr     r0,=823A2DCh
0800B4D4 E0A6     b       @@Peer
.pool

@@GravitySuitNoActivation:						;全装甲 + 无重力
0800B508 4809     ldr     r0,=8237FA8h
0800B50A 4680     mov     r8,r0
0800B50C 4909     ldr     r1,=8238008h
0800B50E 468C     mov     r12,r1
0800B510 4E09     ldr     r6,=82380A8h
0800B512 4A0A     ldr     r2,=82380E8h
0800B514 4692     mov     r10,r2
0800B516 480A     ldr     r0,=8238148h
0800B518 9000     str     r0,[sp]
0800B51A 490A     ldr     r1,=82381E8h
0800B51C 4689     mov     r9,r1
0800B51E 480A     ldr     r0,=823A1F8h
0800B520 7F69     ldrb    r1,[r5,1Dh]
0800B522 0089     lsl     r1,r1,2h
0800B524 1808     add     r0,r1,r0
0800B526 6803     ldr     r3,[r0]
0800B528 4F08     ldr     r7,=82379C8h
0800B52A 4809     ldr     r0,=823A2BCh
0800B52C E07A     b       @@Peer
.pool

@@NoFullPowerSuit:
0800B554 2900     cmp     r1,0h
0800B556 D153     bne     @@ZeroSuit				
0800B558 4A0C     ldr     r2,=3001530h
0800B55A 7BD1     ldrb    r1,[r2,0Fh]
0800B55C 2010     mov     r0,10h
0800B55E 4008     and     r0,r1
0800B560 2800     cmp     r0,0h					;检查隔热服是否开启
0800B562 D027     beq     @@VariaNoActivation
0800B564 480A     ldr     r0,=8237BE8h			;非全装+隔热
0800B566 4680     mov     r8,r0
0800B568 490A     ldr     r1,=8237C48h
0800B56A 468C     mov     r12,r1
0800B56C 4E0A     ldr     r6,=8237CE8h
0800B56E 4A0B     ldr     r2,=8237D28h
0800B570 4692     mov     r10,r2
0800B572 480B     ldr     r0,=8237D88h
0800B574 9000     str     r0,[sp]
0800B576 490B     ldr     r1,=8237E28h
0800B578 4689     mov     r9,r1
0800B57A 480B     ldr     r0,=823A1CCh
0800B57C 7F69     ldrb    r1,[r5,1Dh]
0800B57E 0089     lsl     r1,r1,2h
0800B580 1808     add     r0,r1,r0
0800B582 6803     ldr     r3,[r0]
0800B584 4F09     ldr     r7,=82379A8h
0800B586 480A     ldr     r0,=823A29Ch
0800B588 E04C     b       @@Peer
.pool

@@VariaNoActivation
0800B5B4 4A09     ldr     r2,=82376A8h			;无全装 无隔热
0800B5B6 4690     mov     r8,r2
0800B5B8 4809     ldr     r0,=8237708h
0800B5BA 4684     mov     r12,r0
0800B5BC 4E09     ldr     r6,=82377A8h
0800B5BE 490A     ldr     r1,=82377E8h
0800B5C0 468A     mov     r10,r1
0800B5C2 4A0A     ldr     r2,=8237848h
0800B5C4 9200     str     r2,[sp]
0800B5C6 480A     ldr     r0,=8237A68h
0800B5C8 4681     mov     r9,r0
0800B5CA 480A     ldr     r0,=823A1A0h
0800B5CC 7F69     ldrb    r1,[r5,1Dh]
0800B5CE 0089     lsl     r1,r1,2h
0800B5D0 1808     add     r0,r1,r0
0800B5D2 6803     ldr     r3,[r0]
0800B5D4 4F08     ldr     r7,=8237888h
0800B5D6 4809     ldr     r0,=823A27Ch
0800B5D8 E024     b       @@Peer
.pool

@@ZeroSuit:
0800B600 4913     ldr     r1,=82387E8h			;常态
0800B602 4688     mov     r8,r1
0800B604 4A13     ldr     r2,=8238848h			;射击??
0800B606 4694     mov     r12,r2
0800B608 4E13     ldr     r6,=82388E8h			;挨打的调色
0800B60A 4814     ldr     r0,=82377E8h			;加速1和普通装甲一样
0800B60C 4682     mov     r10,r0
0800B60E 4914     ldr     r1,=8237848h			;球变人调色
0800B610 9100     str     r1,[sp]
0800B612 4A14     ldr     r2,=8238988h			;蓄力射击调色
0800B614 4691     mov     r9,r2
0800B616 4814     ldr     r0,=823A250h
0800B618 7F69     ldrb    r1,[r5,1Dh]
0800B61A 0089     lsl     r1,r1,2h
0800B61C 1808     add     r0,r1,r0
0800B61E 6803     ldr     r3,[r0]
0800B620 4F12     ldr     r7,=82378A8h			;球变人过程调色
0800B622 4813     ldr     r0,=823A2FCh

@@Peer:
0800B624 1809     add     r1,r1,r0
0800B626 6809     ldr     r1,[r1]
0800B628 7828     ldrb    r0,[r5]
0800B62A 1C04     mov     r4,r0
0800B62C 2C33     cmp     r4,33h
0800B62E D137     bne     800B6A0h
0800B630 4C10     ldr     r4,=8237888h
0800B632 1C20     mov     r0,r4
0800B634 2100     mov     r1,0h
0800B636 2210     mov     r2,10h
0800B638 F7FCF89A bl      8007770h
0800B63C 79E8     ldrb    r0,[r5,7h]
0800B63E 2800     cmp     r0,0h
0800B640 D12A     bne     800B698h
0800B642 7F68     ldrb    r0,[r5,1Dh]
0800B644 280B     cmp     r0,0Bh
0800B646 D001     beq     800B64Ch
0800B648 280F     cmp     r0,0Fh
0800B64A D115     bne     800B678h
0800B64C 3440     add     r4,40h
0800B64E E0C2     b       800B7D6h
0800B650 87E8     strh    r0,[r5,3Eh]
0800B652 0823     lsr     r3,r4,20h
0800B654 8848     ldrh    r0,[r1,2h]
0800B656 0823     lsr     r3,r4,20h
0800B658 88E8     ldrh    r0,[r5,6h]
0800B65A 0823     lsr     r3,r4,20h
0800B65C 77E8     strb    r0,[r5,1Fh]
0800B65E 0823     lsr     r3,r4,20h
0800B660 7848     ldrb    r0,[r1,1h]
0800B662 0823     lsr     r3,r4,20h
0800B664 8988     ldrh    r0,[r1,0Ch]
0800B666 0823     lsr     r3,r4,20h
0800B668 A250     add     r2,=800B7ACh
0800B66A 0823     lsr     r3,r4,20h
0800B66C 78A8     ldrb    r0,[r5,2h]
0800B66E 0823     lsr     r3,r4,20h
0800B670 A2FC     add     r2,=800BA64h
0800B672 0823     lsr     r3,r4,20h
0800B674 7888     ldrb    r0,[r1,2h]
0800B676 0823     lsr     r3,r4,20h
0800B678 280C     cmp     r0,0Ch
0800B67A D001     beq     800B680h
0800B67C 280E     cmp     r0,0Eh
0800B67E D101     bne     800B684h
0800B680 3480     add     r4,80h
0800B682 E0A8     b       800B7D6h
0800B684 280D     cmp     r0,0Dh
0800B686 D101     bne     800B68Ch
0800B688 34C0     add     r4,0C0h
0800B68A E0A4     b       800B7D6h
0800B68C 3420     add     r4,20h
0800B68E 280A     cmp     r0,0Ah
0800B690 D900     bls     800B694h
0800B692 E0A0     b       800B7D6h
0800B694 1C3C     mov     r4,r7
0800B696 E09E     b       800B7D6h
0800B698 79E8     ldrb    r0,[r5,7h]
0800B69A 0140     lsl     r0,r0,5h
0800B69C 1904     add     r4,r0,r4
0800B69E E09A     b       800B7D6h
0800B6A0 79A8     ldrb    r0,[r5,6h]
0800B6A2 2800     cmp     r0,0h
0800B6A4 D00E     beq     800B6C4h
0800B6A6 3801     sub     r0,1h
0800B6A8 71A8     strb    r0,[r5,6h]
0800B6AA 4805     ldr     r0,=3000C77h
0800B6AC 7801     ldrb    r1,[r0]
0800B6AE 2003     mov     r0,3h
0800B6B0 4008     and     r0,r1
0800B6B2 1C34     mov     r4,r6
0800B6B4 3420     add     r4,20h
0800B6B6 2801     cmp     r0,1h
0800B6B8 D900     bls     800B6BCh
0800B6BA E085     b       800B7C8h
0800B6BC 1C34     mov     r4,r6
0800B6BE E083     b       800B7C8h
0800B6C0 0C77     lsr     r7,r6,11h
0800B6C2 0300     lsl     r0,r0,0Ch
0800B6C4 4812     ldr     r0,=3001544h
0800B6C6 7902     ldrb    r2,[r0,4h]
0800B6C8 2A00     cmp     r2,0h
0800B6CA D003     beq     800B6D4h
0800B6CC 200F     mov     r0,0Fh
0800B6CE 4010     and     r0,r2
0800B6D0 2807     cmp     r0,7h
0800B6D2 D82B     bhi     800B72Ch
0800B6D4 7968     ldrb    r0,[r5,5h]
0800B6D6 2800     cmp     r0,0h
0800B6D8 D102     bne     800B6E0h
0800B6DA 7A28     ldrb    r0,[r5,8h]
0800B6DC 2800     cmp     r0,0h
0800B6DE D01B     beq     800B718h
0800B6E0 480C     ldr     r0,=3000C77h
0800B6E2 7800     ldrb    r0,[r0]
0800B6E4 2106     mov     r1,6h
0800B6E6 F07FFBB7 bl      808AE58h
0800B6EA 0600     lsl     r0,r0,18h
0800B6EC 0E00     lsr     r0,r0,18h
0800B6EE 2800     cmp     r0,0h
0800B6F0 DB05     blt     800B6FEh
0800B6F2 4654     mov     r4,r10
0800B6F4 2801     cmp     r0,1h
0800B6F6 DD04     ble     800B702h
0800B6F8 3420     add     r4,20h
0800B6FA 2803     cmp     r0,3h
0800B6FC DD01     ble     800B702h
0800B6FE 4654     mov     r4,r10
0800B700 3440     add     r4,40h
0800B702 1C20     mov     r0,r4
0800B704 2100     mov     r1,0h
0800B706 2210     mov     r2,10h
0800B708 F7FCF832 bl      8007770h
0800B70C E063     b       800B7D6h
0800B70E 0000     lsl     r0,r0,0h
0800B710 1544     asr     r4,r0,15h
0800B712 0300     lsl     r0,r0,0Ch
0800B714 0C77     lsr     r7,r6,11h
0800B716 0300     lsl     r0,r0,0Ch
0800B718 0620     lsl     r0,r4,18h
0800B71A 0E00     lsr     r0,r0,18h
0800B71C 280F     cmp     r0,0Fh
0800B71E D108     bne     800B732h
0800B720 7F69     ldrb    r1,[r5,1Dh]
0800B722 2001     mov     r0,1h
0800B724 4008     and     r0,r1
0800B726 4644     mov     r4,r8
0800B728 2800     cmp     r0,0h
0800B72A D04D     beq     800B7C8h
0800B72C 1C34     mov     r4,r6
0800B72E 3420     add     r4,20h
0800B730 E04A     b       800B7C8h
0800B732 282C     cmp     r0,2Ch
0800B734 D108     bne     800B748h
0800B736 1C1C     mov     r4,r3
0800B738 1C20     mov     r0,r4
0800B73A 2100     mov     r1,0h
0800B73C 2210     mov     r2,10h
0800B73E F7FCF817 bl      8007770h
0800B742 4644     mov     r4,r8
0800B744 3440     add     r4,40h
0800B746 E046     b       800B7D6h
0800B748 282D     cmp     r0,2Dh
0800B74A D10C     bne     800B766h
0800B74C 7AA8     ldrb    r0,[r5,0Ah]
0800B74E 1C0C     mov     r4,r1
0800B750 2800     cmp     r0,0h
0800B752 D000     beq     800B756h
0800B754 4644     mov     r4,r8
0800B756 1C20     mov     r0,r4
0800B758 2100     mov     r1,0h
0800B75A 2210     mov     r2,10h
0800B75C F7FCF808 bl      8007770h
0800B760 4644     mov     r4,r8
0800B762 3440     add     r4,40h
0800B764 E037     b       800B7D6h
0800B766 4906     ldr     r1,=3001414h
0800B768 7988     ldrb    r0,[r1,6h]
0800B76A 2800     cmp     r0,0h
0800B76C D021     beq     800B7B2h
0800B76E 4A05     ldr     r2,=3001530h
0800B770 7B51     ldrb    r1,[r2,0Dh]
0800B772 2002     mov     r0,2h
0800B774 4008     and     r0,r1
0800B776 2800     cmp     r0,0h
0800B778 D006     beq     800B788h
0800B77A 4664     mov     r4,r12
0800B77C 3440     add     r4,40h
0800B77E E023     b       800B7C8h
0800B780 1414     asr     r4,r2,10h
0800B782 0300     lsl     r0,r0,0Ch
0800B784 1530     asr     r0,r6,14h
0800B786 0300     lsl     r0,r0,0Ch
0800B788 2008     mov     r0,8h
0800B78A 4008     and     r0,r1
0800B78C 2800     cmp     r0,0h
0800B78E D002     beq     800B796h
0800B790 4664     mov     r4,r12
0800B792 3480     add     r4,80h
0800B794 E018     b       800B7C8h
0800B796 2004     mov     r0,4h
0800B798 4008     and     r0,r1
0800B79A 2800     cmp     r0,0h
0800B79C D002     beq     800B7A4h
0800B79E 4664     mov     r4,r12
0800B7A0 3460     add     r4,60h
0800B7A2 E011     b       800B7C8h
0800B7A4 2001     mov     r0,1h
0800B7A6 4008     and     r0,r1
0800B7A8 4664     mov     r4,r12
0800B7AA 2800     cmp     r0,0h
0800B7AC D00C     beq     800B7C8h
0800B7AE 3420     add     r4,20h
0800B7B0 E00A     b       800B7C8h
0800B7B2 7A68     ldrb    r0,[r5,9h]
0800B7B4 2800     cmp     r0,0h
0800B7B6 D014     beq     800B7E2h
0800B7B8 3805     sub     r0,5h
0800B7BA 0600     lsl     r0,r0,18h
0800B7BC 0E00     lsr     r0,r0,18h
0800B7BE 9C00     ldr     r4,[sp]
0800B7C0 3420     add     r4,20h
0800B7C2 2804     cmp     r0,4h
0800B7C4 D900     bls     800B7C8h
0800B7C6 9C00     ldr     r4,[sp]
0800B7C8 1C20     mov     r0,r4
0800B7CA 2100     mov     r1,0h
0800B7CC 2210     mov     r2,10h
0800B7CE F7FBFFCF bl      8007770h
0800B7D2 4644     mov     r4,r8
0800B7D4 3420     add     r4,20h
0800B7D6 1C20     mov     r0,r4
0800B7D8 2110     mov     r1,10h
0800B7DA 2210     mov     r2,10h
0800B7DC F7FBFFC8 bl      8007770h
0800B7E0 E03A     b       800B858h
0800B7E2 4644     mov     r4,r8
0800B7E4 4669     mov     r1,r13
0800B7E6 7909     ldrb    r1,[r1,4h]
0800B7E8 0608     lsl     r0,r1,18h
0800B7EA 0E00     lsr     r0,r0,18h
0800B7EC 2802     cmp     r0,2h
0800B7EE D02E     beq     800B84Eh
0800B7F0 4A08     ldr     r2,=3001414h
0800B7F2 7950     ldrb    r0,[r2,5h]
0800B7F4 2840     cmp     r0,40h
0800B7F6 D32A     bcc     800B84Eh
0800B7F8 3840     sub     r0,40h
0800B7FA 1082     asr     r2,r0,2h
0800B7FC 2A03     cmp     r2,3h
0800B7FE D026     beq     800B84Eh
0800B800 4805     ldr     r0,=3001530h
0800B802 7B41     ldrb    r1,[r0,0Dh]
0800B804 2002     mov     r0,2h
0800B806 4008     and     r0,r1
0800B808 2800     cmp     r0,0h
0800B80A D007     beq     800B81Ch
0800B80C 464C     mov     r4,r9
0800B80E 3480     add     r4,80h
0800B810 E019     b       800B846h
0800B812 0000     lsl     r0,r0,0h
0800B814 1414     asr     r4,r2,10h
0800B816 0300     lsl     r0,r0,0Ch
0800B818 1530     asr     r0,r6,14h
0800B81A 0300     lsl     r0,r0,0Ch
0800B81C 2008     mov     r0,8h
0800B81E 4008     and     r0,r1
0800B820 2800     cmp     r0,0h
0800B822 D003     beq     800B82Ch
0800B824 2480     mov     r4,80h
0800B826 0064     lsl     r4,r4,1h
0800B828 444C     add     r4,r9
0800B82A E00C     b       800B846h
0800B82C 2004     mov     r0,4h
0800B82E 4008     and     r0,r1
0800B830 2800     cmp     r0,0h
0800B832 D002     beq     800B83Ah
0800B834 464C     mov     r4,r9
0800B836 34C0     add     r4,0C0h
0800B838 E005     b       800B846h
0800B83A 2001     mov     r0,1h
0800B83C 4008     and     r0,r1
0800B83E 464C     mov     r4,r9
0800B840 2800     cmp     r0,0h
0800B842 D000     beq     800B846h
0800B844 3440     add     r4,40h
0800B846 2001     mov     r0,1h
0800B848 4002     and     r2,r0
0800B84A 0150     lsl     r0,r2,5h
0800B84C 1824     add     r4,r4,r0
0800B84E 1C20     mov     r0,r4
0800B850 2100     mov     r1,0h
0800B852 2220     mov     r2,20h
0800B854 F7FBFF8C bl      8007770h
0800B858 B002     add     sp,8h
0800B85A BC38     pop     r3-r5
0800B85C 4698     mov     r8,r3
0800B85E 46A1     mov     r9,r4
0800B860 46AA     mov     r10,r5
0800B862 BCF0     pop     r4-r7
0800B864 BC01     pop     r0
0800B866 4700     bx      r0






0800B868 B500     push    lr
0800B86A 490B     ldr     r1,=30013D4h
0800B86C 480B     ldr     r0,=3001530h
0800B86E 7C40     ldrb    r0,[r0,11h]
0800B870 2800     cmp     r0,0h
0800B872 D00F     beq     800B894h
0800B874 7808     ldrb    r0,[r1]
0800B876 2833     cmp     r0,33h
0800B878 D00C     beq     800B894h
0800B87A 4809     ldr     r0,=3001606h
0800B87C 8800     ldrh    r0,[r0]
0800B87E 2800     cmp     r0,0h
0800B880 D108     bne     800B894h
0800B882 4808     ldr     r0,=3000C77h
0800B884 7801     ldrb    r1,[r0]
0800B886 200F     mov     r0,0Fh
0800B888 4008     and     r0,r1
0800B88A 2800     cmp     r0,0h
0800B88C D102     bne     800B894h
0800B88E 2082     mov     r0,82h
0800B890 F7F7F8C2 bl      8002A18h
0800B894 BC01     pop     r0
0800B896 4700     bx      r0
0800B898 13D4     asr     r4,r2,0Fh
0800B89A 0300     lsl     r0,r0,0Ch
0800B89C 1530     asr     r0,r6,14h
0800B89E 0300     lsl     r0,r0,0Ch
0800B8A0 1606     asr     r6,r0,18h
0800B8A2 0300     lsl     r0,r0,0Ch
0800B8A4 0C77     lsr     r7,r6,11h
0800B8A6 0300     lsl     r0,r0,0Ch
0800B8A8 B530     push    r4,r5,lr
0800B8AA 1C05     mov     r5,r0
0800B8AC 468C     mov     r12,r1
0800B8AE 4C16     ldr     r4,=8239464h
0800B8B0 7829     ldrb    r1,[r5]
0800B8B2 0048     lsl     r0,r1,1h
0800B8B4 1840     add     r0,r0,r1
0800B8B6 1900     add     r0,r0,r4
0800B8B8 7801     ldrb    r1,[r0]
0800B8BA 4B14     ldr     r3,=823A534h
0800B8BC 00C9     lsl     r1,r1,3h
0800B8BE 18C8     add     r0,r1,r3
0800B8C0 8800     ldrh    r0,[r0]
0800B8C2 4662     mov     r2,r12
0800B8C4 326E     add     r2,6Eh
0800B8C6 8010     strh    r0,[r2]
0800B8C8 1C98     add     r0,r3,2
0800B8CA 1808     add     r0,r1,r0
0800B8CC 8802     ldrh    r2,[r0]
0800B8CE 4660     mov     r0,r12
0800B8D0 3070     add     r0,70h
0800B8D2 8002     strh    r2,[r0]
0800B8D4 1D18     add     r0,r3,4
0800B8D6 1808     add     r0,r1,r0
0800B8D8 8800     ldrh    r0,[r0]
0800B8DA 4662     mov     r2,r12
0800B8DC 3272     add     r2,72h
0800B8DE 8010     strh    r0,[r2]
0800B8E0 3306     add     r3,6h
0800B8E2 18C9     add     r1,r1,r3
0800B8E4 8809     ldrh    r1,[r1]
0800B8E6 4660     mov     r0,r12
0800B8E8 3074     add     r0,74h
0800B8EA 8001     strh    r1,[r0]
0800B8EC 7829     ldrb    r1,[r5]
0800B8EE 0048     lsl     r0,r1,1h
0800B8F0 1840     add     r0,r0,r1
0800B8F2 3402     add     r4,2h
0800B8F4 1900     add     r0,r0,r4
0800B8F6 7801     ldrb    r1,[r0]
0800B8F8 7868     ldrb    r0,[r5,1h]
0800B8FA 2801     cmp     r0,1h
0800B8FC D000     beq     800B900h
0800B8FE 7069     strb    r1,[r5,1h]
0800B900 BC30     pop     r4,r5
0800B902 BC01     pop     r0
0800B904 4700     bx      r0
0800B906 0000     lsl     r0,r0,0h
0800B908 9464     str     r4,[sp,190h]
0800B90A 0823     lsr     r3,r4,20h
0800B90C A534     add     r5,=800B9E0h
0800B90E 0823     lsr     r3,r4,20h
0800B910 B570     push    r4-r6,lr
0800B912 0600     lsl     r0,r0,18h
0800B914 0E03     lsr     r3,r0,18h
0800B916 4E07     ldr     r6,=30013D4h
0800B918 4C07     ldr     r4,=3001530h
0800B91A 4808     ldr     r0,=3001588h
0800B91C 4684     mov     r12,r0
0800B91E 7835     ldrb    r5,[r6]
0800B920 78B2     ldrb    r2,[r6,2h]
0800B922 2D3C     cmp     r5,3Ch
0800B924 D900     bls     800B928h
0800B926 E191     b       800BC4Ch
0800B928 00A8     lsl     r0,r5,2h
0800B92A 4905     ldr     r1,=800B944h
0800B92C 1840     add     r0,r0,r1
0800B92E 6800     ldr     r0,[r0]
0800B930 4687     mov     r15,r0
0800B932 0000     lsl     r0,r0,0h
0800B934 13D4     asr     r4,r2,0Fh
0800B936 0300     lsl     r0,r0,0Ch
0800B938 1530     asr     r0,r6,14h
0800B93A 0300     lsl     r0,r0,0Ch
0800B93C 1588     asr     r0,r1,16h
0800B93E 0300     lsl     r0,r0,0Ch
0800B940 B944     ????
0800B942 0800     lsr     r0,r0,20h
0800B944 BA38     ????
0800B946 0800     lsr     r0,r0,20h
0800B948 BA74     ????
0800B94A 0800     lsr     r0,r0,20h
0800B94C BA94     ????
0800B94E 0800     lsr     r0,r0,20h
0800B950 BAB4     ????
0800B952 0800     lsr     r0,r0,20h
0800B954 BAD4     ????
0800B956 0800     lsr     r0,r0,20h
0800B958 BAF4     ????
0800B95A 0800     lsr     r0,r0,20h
0800B95C BB14     ????
0800B95E 0800     lsr     r0,r0,20h
0800B960 BC4C     pop     r2,r3,r6
0800B962 0800     lsr     r0,r0,20h
0800B964 BB34     ????
0800B966 0800     lsr     r0,r0,20h
0800B968 BB54     ????
0800B96A 0800     lsr     r0,r0,20h
0800B96C BB74     ????
0800B96E 0800     lsr     r0,r0,20h
0800B970 BC4C     pop     r2,r3,r6
0800B972 0800     lsr     r0,r0,20h
0800B974 BC4C     pop     r2,r3,r6
0800B976 0800     lsr     r0,r0,20h
0800B978 BC4C     pop     r2,r3,r6
0800B97A 0800     lsr     r0,r0,20h
0800B97C BC4C     pop     r2,r3,r6
0800B97E 0800     lsr     r0,r0,20h
0800B980 BC4C     pop     r2,r3,r6
0800B982 0800     lsr     r0,r0,20h
0800B984 BC4C     pop     r2,r3,r6
0800B986 0800     lsr     r0,r0,20h
0800B988 BC4C     pop     r2,r3,r6
0800B98A 0800     lsr     r0,r0,20h
0800B98C BC4C     pop     r2,r3,r6
0800B98E 0800     lsr     r0,r0,20h
0800B990 BC4C     pop     r2,r3,r6
0800B992 0800     lsr     r0,r0,20h
0800B994 BC4C     pop     r2,r3,r6
0800B996 0800     lsr     r0,r0,20h
0800B998 BC4C     pop     r2,r3,r6
0800B99A 0800     lsr     r0,r0,20h
0800B99C BC4C     pop     r2,r3,r6
0800B99E 0800     lsr     r0,r0,20h
0800B9A0 BC4C     pop     r2,r3,r6
0800B9A2 0800     lsr     r0,r0,20h
0800B9A4 BB94     ????
0800B9A6 0800     lsr     r0,r0,20h
0800B9A8 BBB4     ????
0800B9AA 0800     lsr     r0,r0,20h
0800B9AC BC4C     pop     r2,r3,r6
0800B9AE 0800     lsr     r0,r0,20h
0800B9B0 BC4C     pop     r2,r3,r6
0800B9B2 0800     lsr     r0,r0,20h
0800B9B4 BC4C     pop     r2,r3,r6
0800B9B6 0800     lsr     r0,r0,20h
0800B9B8 BBD4     ????
0800B9BA 0800     lsr     r0,r0,20h
0800B9BC BC4C     pop     r2,r3,r6
0800B9BE 0800     lsr     r0,r0,20h
0800B9C0 BC4C     pop     r2,r3,r6
0800B9C2 0800     lsr     r0,r0,20h
0800B9C4 BC4C     pop     r2,r3,r6
0800B9C6 0800     lsr     r0,r0,20h
0800B9C8 BC4C     pop     r2,r3,r6
0800B9CA 0800     lsr     r0,r0,20h
0800B9CC BBF0     ????
0800B9CE 0800     lsr     r0,r0,20h
0800B9D0 BBF0     ????
0800B9D2 0800     lsr     r0,r0,20h
0800B9D4 BC4C     pop     r2,r3,r6
0800B9D6 0800     lsr     r0,r0,20h
0800B9D8 BC4C     pop     r2,r3,r6
0800B9DA 0800     lsr     r0,r0,20h
0800B9DC BC4C     pop     r2,r3,r6
0800B9DE 0800     lsr     r0,r0,20h
0800B9E0 BC4C     pop     r2,r3,r6
0800B9E2 0800     lsr     r0,r0,20h
0800B9E4 BC00     pop     
0800B9E6 0800     lsr     r0,r0,20h
0800B9E8 BC0C     pop     r2,r3
0800B9EA 0800     lsr     r0,r0,20h
0800B9EC BC18     pop     r3,r4
0800B9EE 0800     lsr     r0,r0,20h
0800B9F0 BC4C     pop     r2,r3,r6
0800B9F2 0800     lsr     r0,r0,20h
0800B9F4 BC4C     pop     r2,r3,r6
0800B9F6 0800     lsr     r0,r0,20h
0800B9F8 BC4C     pop     r2,r3,r6
0800B9FA 0800     lsr     r0,r0,20h
0800B9FC BC4C     pop     r2,r3,r6
0800B9FE 0800     lsr     r0,r0,20h
0800BA00 BC4C     pop     r2,r3,r6
0800BA02 0800     lsr     r0,r0,20h
0800BA04 BC4C     pop     r2,r3,r6
0800BA06 0800     lsr     r0,r0,20h
0800BA08 BC4C     pop     r2,r3,r6
0800BA0A 0800     lsr     r0,r0,20h
0800BA0C BC4C     pop     r2,r3,r6
0800BA0E 0800     lsr     r0,r0,20h
0800BA10 BC4C     pop     r2,r3,r6
0800BA12 0800     lsr     r0,r0,20h
0800BA14 BC4C     pop     r2,r3,r6
0800BA16 0800     lsr     r0,r0,20h
0800BA18 BC24     pop     r2,r5
0800BA1A 0800     lsr     r0,r0,20h
0800BA1C BC4C     pop     r2,r3,r6
0800BA1E 0800     lsr     r0,r0,20h
0800BA20 BC4C     pop     r2,r3,r6
0800BA22 0800     lsr     r0,r0,20h
0800BA24 BC4C     pop     r2,r3,r6
0800BA26 0800     lsr     r0,r0,20h
0800BA28 BC4C     pop     r2,r3,r6
0800BA2A 0800     lsr     r0,r0,20h
0800BA2C BC4C     pop     r2,r3,r6
0800BA2E 0800     lsr     r0,r0,20h
0800BA30 BC34     pop     r2,r4,r5
0800BA32 0800     lsr     r0,r0,20h
0800BA34 BC40     pop     r6
0800BA36 0800     lsr     r0,r0,20h
0800BA38 2A04     cmp     r2,4h
0800BA3A D902     bls     800BA42h
0800BA3C 1E90     sub     r0,r2,2
0800BA3E 0600     lsl     r0,r0,18h
0800BA40 0E02     lsr     r2,r0,18h
0800BA42 7CA0     ldrb    r0,[r4,12h]
0800BA44 2802     cmp     r0,2h
0800BA46 D105     bne     800BA54h
0800BA48 4801     ldr     r0,=8239FB8h
0800BA4A 0099     lsl     r1,r3,2h
0800BA4C 00D2     lsl     r2,r2,3h
0800BA4E E108     b       800BC62h
0800BA50 9FB8     ldr     r7,[sp,2E0h]
0800BA52 0823     lsr     r3,r4,20h
0800BA54 7970     ldrb    r0,[r6,5h]
0800BA56 2800     cmp     r0,0h
0800BA58 D106     bne     800BA68h
0800BA5A 4802     ldr     r0,=823920Ch
0800BA5C 0099     lsl     r1,r3,2h
0800BA5E 00D2     lsl     r2,r2,3h
0800BA60 E0FF     b       800BC62h
0800BA62 0000     lsl     r0,r0,0h
0800BA64 920C     str     r2,[sp,30h]
0800BA66 0823     lsr     r3,r4,20h
0800BA68 4801     ldr     r0,=823922Ch
0800BA6A 0099     lsl     r1,r3,2h
0800BA6C 00D2     lsl     r2,r2,3h
0800BA6E E0F8     b       800BC62h
0800BA70 922C     str     r2,[sp,0B0h]
0800BA72 0823     lsr     r3,r4,20h
0800BA74 7CA0     ldrb    r0,[r4,12h]
0800BA76 2802     cmp     r0,2h
0800BA78 D106     bne     800BA88h
0800BA7A 4802     ldr     r0,=8239FD8h
0800BA7C 0099     lsl     r1,r3,2h
0800BA7E 00D2     lsl     r2,r2,3h
0800BA80 E0EF     b       800BC62h
0800BA82 0000     lsl     r0,r0,0h
0800BA84 9FD8     ldr     r7,[sp,360h]
0800BA86 0823     lsr     r3,r4,20h
0800BA88 4801     ldr     r0,=823924Ch
0800BA8A 0099     lsl     r1,r3,2h
0800BA8C 00D2     lsl     r2,r2,3h
0800BA8E E0E8     b       800BC62h
0800BA90 924C     str     r2,[sp,130h]
0800BA92 0823     lsr     r3,r4,20h
0800BA94 7CA0     ldrb    r0,[r4,12h]
0800BA96 2802     cmp     r0,2h
0800BA98 D106     bne     800BAA8h
0800BA9A 4802     ldr     r0,=8239FF8h
0800BA9C 0099     lsl     r1,r3,2h
0800BA9E 00D2     lsl     r2,r2,3h
0800BAA0 E0DF     b       800BC62h
0800BAA2 0000     lsl     r0,r0,0h
0800BAA4 9FF8     ldr     r7,[sp,3E0h]
0800BAA6 0823     lsr     r3,r4,20h
0800BAA8 4801     ldr     r0,=823926Ch
0800BAAA 0099     lsl     r1,r3,2h
0800BAAC 00D2     lsl     r2,r2,3h
0800BAAE E0D8     b       800BC62h
0800BAB0 926C     str     r2,[sp,1B0h]
0800BAB2 0823     lsr     r3,r4,20h
0800BAB4 7CA0     ldrb    r0,[r4,12h]
0800BAB6 2802     cmp     r0,2h
0800BAB8 D106     bne     800BAC8h
0800BABA 4802     ldr     r0,=823A018h
0800BABC 0099     lsl     r1,r3,2h
0800BABE 00D2     lsl     r2,r2,3h
0800BAC0 E0CF     b       800BC62h
0800BAC2 0000     lsl     r0,r0,0h
0800BAC4 A018     add     r0,=800BB28h
0800BAC6 0823     lsr     r3,r4,20h
0800BAC8 4801     ldr     r0,=823928Ch
0800BACA 0099     lsl     r1,r3,2h
0800BACC 00D2     lsl     r2,r2,3h
0800BACE E0C8     b       800BC62h
0800BAD0 928C     str     r2,[sp,230h]
0800BAD2 0823     lsr     r3,r4,20h
0800BAD4 7CA0     ldrb    r0,[r4,12h]
0800BAD6 2802     cmp     r0,2h
0800BAD8 D106     bne     800BAE8h
0800BADA 4802     ldr     r0,=823A038h
0800BADC 0099     lsl     r1,r3,2h
0800BADE 00D2     lsl     r2,r2,3h
0800BAE0 E0BF     b       800BC62h
0800BAE2 0000     lsl     r0,r0,0h
0800BAE4 A038     add     r0,=800BBC8h
0800BAE6 0823     lsr     r3,r4,20h
0800BAE8 4801     ldr     r0,=82392ACh
0800BAEA 0099     lsl     r1,r3,2h
0800BAEC 00D2     lsl     r2,r2,3h
0800BAEE E0B8     b       800BC62h
0800BAF0 92AC     str     r2,[sp,2B0h]
0800BAF2 0823     lsr     r3,r4,20h
0800BAF4 7CA0     ldrb    r0,[r4,12h]
0800BAF6 2802     cmp     r0,2h
0800BAF8 D106     bne     800BB08h
0800BAFA 4802     ldr     r0,=823A050h
0800BAFC 0099     lsl     r1,r3,2h
0800BAFE 00D2     lsl     r2,r2,3h
0800BB00 E0AF     b       800BC62h
0800BB02 0000     lsl     r0,r0,0h
0800BB04 A050     add     r0,=800BC48h
0800BB06 0823     lsr     r3,r4,20h
0800BB08 4801     ldr     r0,=82392C4h
0800BB0A 0099     lsl     r1,r3,2h
0800BB0C 00D2     lsl     r2,r2,3h
0800BB0E E0A8     b       800BC62h
0800BB10 92C4     str     r2,[sp,310h]
0800BB12 0823     lsr     r3,r4,20h
0800BB14 7CA0     ldrb    r0,[r4,12h]
0800BB16 2802     cmp     r0,2h
0800BB18 D106     bne     800BB28h
0800BB1A 4802     ldr     r0,=823A068h
0800BB1C 0099     lsl     r1,r3,2h
0800BB1E 00D2     lsl     r2,r2,3h
0800BB20 E09F     b       800BC62h
0800BB22 0000     lsl     r0,r0,0h
0800BB24 A068     add     r0,=800BCC8h
0800BB26 0823     lsr     r3,r4,20h
0800BB28 4801     ldr     r0,=82392DCh
0800BB2A 0099     lsl     r1,r3,2h
0800BB2C 00D2     lsl     r2,r2,3h
0800BB2E E098     b       800BC62h
0800BB30 92DC     str     r2,[sp,370h]
0800BB32 0823     lsr     r3,r4,20h
0800BB34 7CA0     ldrb    r0,[r4,12h]
0800BB36 2802     cmp     r0,2h
0800BB38 D106     bne     800BB48h
0800BB3A 4802     ldr     r0,=823A080h
0800BB3C 0099     lsl     r1,r3,2h
0800BB3E 00D2     lsl     r2,r2,3h
0800BB40 E08F     b       800BC62h
0800BB42 0000     lsl     r0,r0,0h
0800BB44 A080     add     r0,=800BD48h
0800BB46 0823     lsr     r3,r4,20h
0800BB48 4801     ldr     r0,=8239304h
0800BB4A 0099     lsl     r1,r3,2h
0800BB4C 00D2     lsl     r2,r2,3h
0800BB4E E088     b       800BC62h
0800BB50 9304     str     r3,[sp,10h]
0800BB52 0823     lsr     r3,r4,20h
0800BB54 7CA0     ldrb    r0,[r4,12h]
0800BB56 2802     cmp     r0,2h
0800BB58 D106     bne     800BB68h
0800BB5A 4802     ldr     r0,=823A0A8h
0800BB5C 0099     lsl     r1,r3,2h
0800BB5E 00D2     lsl     r2,r2,3h
0800BB60 E07F     b       800BC62h
0800BB62 0000     lsl     r0,r0,0h
0800BB64 A0A8     add     r0,=800BE08h
0800BB66 0823     lsr     r3,r4,20h
0800BB68 4801     ldr     r0,=823932Ch
0800BB6A 0099     lsl     r1,r3,2h
0800BB6C 00D2     lsl     r2,r2,3h
0800BB6E E078     b       800BC62h
0800BB70 932C     str     r3,[sp,0B0h]
0800BB72 0823     lsr     r3,r4,20h
