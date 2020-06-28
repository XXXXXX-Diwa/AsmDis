;r0=sp+4 r1=当前房间头数据地址 r2=0x3C head地址长度

0808C6BC B530     push    r4,r5,lr
0808C6BE 1C05     mov     r5,r0			;sp+4
0808C6C0 1C2C     mov     r4,r5			;sp+4
0808C6C2 1C0B     mov     r3,r1			;当前房间的头数据地址
0808C6C4 2A0F     cmp     r2,0Fh		
0808C6C6 D919     bls     @@failType	;长度小于10h
0808C6C8 1C18     mov     r0,r3			;当前房间头数据地址
0808C6CA 4328     orr     r0,r5			;头数据地址orr sp+4
0808C6CC 2103     mov     r1,3h
0808C6CE 4008     and     r0,r1			;和3 and
0808C6D0 2800     cmp     r0,0h			;保证和4对齐???
0808C6D2 D113     bne     failType		;数据不与4整?
0808C6D4 1C29     mov     r1,r5			;sp+4

@@Loop:
0808C6D6 CB01     ldmia   [r3]!,r0		;轮流把header数据压入栈里
0808C6D8 C101     stmia   [r1]!,r0
0808C6DA CB01     ldmia   [r3]!,r0
0808C6DC C101     stmia   [r1]!,r0
0808C6DE CB01     ldmia   [r3]!,r0
0808C6E0 C101     stmia   [r1]!,r0
0808C6E2 CB01     ldmia   [r3]!,r0
0808C6E4 C101     stmia   [r1]!,r0
0808C6E6 3A10     sub     r2,10h
0808C6E8 2A0F     cmp     r2,0Fh
0808C6EA D8F4     bhi     @@Loop
0808C6EC 2A03     cmp     r2,3h
0808C6EE D904     bls     @@Pass

@@Loop2:
0808C6F0 CB01     ldmia   [r3]!,r0
0808C6F2 C101     stmia   [r1]!,r0
0808C6F4 3A04     sub     r2,4h
0808C6F6 2A03     cmp     r2,3h
0808C6F8 D8FA     bhi     @@Loop2

@@Pass:
0808C6FA 1C0C     mov     r4,r1

@@failType:
0808C6FC 3A01     sub     r2,1h		;r2-1
0808C6FE 2001     mov     r0,1h		;得到反
0808C700 4240     neg     r0,r0
0808C702 4282     cmp     r2,r0		;检查r2之前是否为0?
0808C704 D007     beq     @@end
0808C706 1C01     mov     r1,r0

@@Loop3:
0808C708 7818     ldrb    r0,[r3]
0808C70A 7020     strb    r0,[r4]
0808C70C 3301     add     r3,1h
0808C70E 3401     add     r4,1h
0808C710 3A01     sub     r2,1h
0808C712 428A     cmp     r2,r1
0808C714 D1F8     bne     @@Loop3
@@end:
0808C716 1C28     mov     r0,r5
0808C718 BD30     pop     r4,r5,pc
