0804F954 B530     push    r4,r5,lr
0804F956 1C04     mov     r4,r0                  ;弹丸数据地址
0804F958 0609     lsl     r1,r1,18h              ;距离
0804F95A 0E0A     lsr     r2,r1,18h
0804F95C 7C20     ldrb    r0,[r4,10h]           ;读取弹丸方向
0804F95E 2802     cmp     r0,2h                 
0804F960 D023     beq     @@decline
0804F962 2802     cmp     r0,2h
0804F964 DC02     bgt     @@Other
0804F966 2801     cmp     r0,1h
0804F968 D00D     beq     @@Diagonal
0804F96A E030     b       @@level

@@Other:
0804F96C 2803     cmp     r0,3h
0804F96E D002     beq     @@Up
0804F970 2804     cmp     r0,4h
0804F972 D004     beq     @@Down
0804F974 E02B     b       @@level

@@Up:
0804F976 8920     ldrh    r0,[r4,8h]       ;读取弹丸Y坐标
0804F978 1A80     sub     r0,r0,r2         ;减去速度
0804F97A 8120     strh    r0,[r4,8h]       ;再写入
0804F97C E049     b       @@end

@@Down:
0804F97E 8920     ldrh    r0,[r4,8h]       ;读取弹丸的Y坐标
0804F980 1880     add     r0,r0,r2         ;加上速度
0804F982 8120     strh    r0,[r4,8h]       ;再写入
0804F984 E045     b       @@end

@@Diagonal:
0804F986 00D0     lsl     r0,r2,3h         ;速度乘以8
0804F988 1A80     sub     r0,r0,r2         ;7倍 
0804F98A 210A     mov     r1,0Ah           ;除以10
0804F98C F03BF952 bl      808AC34h
0804F990 0600     lsl     r0,r0,18h
0804F992 0E02     lsr     r2,r0,18h
0804F994 8920     ldrh    r0,[r4,8h]
0804F996 1A80     sub     r0,r0,r2         ;Y坐标速度是十分之七
0804F998 8120     strh    r0,[r4,8h]
0804F99A 7821     ldrb    r1,[r4]
0804F99C 2040     mov     r0,40h
0804F99E 4008     and     r0,r1
0804F9A0 2800     cmp     r0,0h
0804F9A2 D01C     beq     @@levelLeft
0804F9A4 8960     ldrh    r0,[r4,0Ah]      ;弹丸X坐标加上速度
0804F9A6 1880     add     r0,r0,r2
0804F9A8 E01B     b       @@Peer

@@decline:
0804F9AA 00D0     lsl     r0,r2,3h
0804F9AC 1A80     sub     r0,r0,r2
0804F9AE 210A     mov     r1,0Ah
0804F9B0 F03BF940 bl      808AC34h
0804F9B4 0600     lsl     r0,r0,18h
0804F9B6 0E02     lsr     r2,r0,18h
0804F9B8 8920     ldrh    r0,[r4,8h]
0804F9BA 1880     add     r0,r0,r2
0804F9BC 8120     strh    r0,[r4,8h]
0804F9BE 7821     ldrb    r1,[r4]
0804F9C0 2040     mov     r0,40h
0804F9C2 4008     and     r0,r1
0804F9C4 2800     cmp     r0,0h
0804F9C6 D00A     beq     @@levelLeft
0804F9C8 8960     ldrh    r0,[r4,0Ah]
0804F9CA 1880     add     r0,r0,r2
0804F9CC E009     b       @@Peer2

@@level:
0804F9CE 7821     ldrb    r1,[r4]
0804F9D0 2040     mov     r0,40h
0804F9D2 4008     and     r0,r1
0804F9D4 2800     cmp     r0,0h
0804F9D6 D002     beq     @@levelLeft
0804F9D8 8960     ldrh    r0,[r4,0Ah]
0804F9DA 1880     add     r0,r0,r2
0804F9DC E001     b       @@Peer2

@@levelLeft:
0804F9DE 8960     ldrh    r0,[r4,0Ah]
0804F9E0 1A80     sub     r0,r0,r2

@@Peer:
0804F9E2 8160     strh    r0,[r4,0Ah]
0804F9E4>4807     ldr     r0,=30013D4h
0804F9E6 8AC0     ldrh    r0,[r0,16h]     ;读取人物水平速度
0804F9E8 0400     lsl     r0,r0,10h
0804F9EA 1403     asr     r3,r0,10h
0804F9EC 14C2     asr     r2,r0,13h       ;除以八
0804F9EE 1C15     mov     r5,r2
0804F9F0 2040     mov     r0,40h
0804F9F2 4008     and     r0,r1
0804F9F4 2800     cmp     r0,0h
0804F9F6 D007     beq     @@Left
0804F9F8 2B00     cmp     r3,0h
0804F9FA DD0A     ble     @@end
0804F9FC 8960     ldrh    r0,[r4,0Ah]
0804F9FE 1880     add     r0,r0,r2
0804FA00 E006     b       @@Write

@@left:
0804FA08 2B00     cmp     r3,0h
0804FA0A DA02     bge     @@end
0804FA0C 8960     ldrh    r0,[r4,0Ah]
0804FA0E 1940     add     r0,r0,r5

@@Write:
0804FA10 8160     strh    r0,[r4,0Ah]

@@end:
0804FA12 BC30     pop     r4,r5
0804FA14 BC01     pop     r0
0804FA16 4700     bx      r0
