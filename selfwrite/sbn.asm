.gba
.open "zm.gba","spiderBall.gba",0x8000000
;by : JumZhu.Diwa
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel CheckSlope,800F360h
.definelabel CheckBlock,800F688h         ;���7F1 �ʺ�ͷ��
.definelabel CheckBlock2,800F47Ch        ;���7F0 �ʺ�����
.definelabel CheckBlock3,800f720h
.definelabel Division,808AC34h
.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
.definelabel SamusHeightStage,30015DFh	;վ0 ��1 ��2
;ʵ��֩����
;�ʼ�:
;����̬����/��/��/��+L,����/��/��/����ǽ��,��ἤ��֩����
;����+L�����������ס����,ͬ�������ס�컨��
;����+L(������һ���Ǽ�ʱ�İ���)����ȡ�����������֩����

;3001384Ϊ֩����Pose 1 ������� 2 �컨����� 3 ��ǽ���� 4 ��ǽ����
;3001385Ϊ֩��������ж�ֵ�����
;1385-8bit�����˳����İ�������,����Ϊ ��10 ��20 ��40 ��80
;1385-4bitΪ��ȷ���˰���������,֩����ʱֻ�����»������ƶ�ʱΪ1
;1385��֩���򼤻�����2,�����Ʊ��뼴ʱ����+L����ȡ������֩����
;1385��֩����ʱ��ը��ը����ʧȥ֩���򲢵õ�8�����,��8ÿ֡�ݼ�1,��2�����ٴμ���֩����

;��̬ ��� ��������ּ��
.org 800924Eh
	bl 		TheSpiderBall
	
.org 8009532h
	bl 		TheSpiderBall
	
.org 80093C2h
	bl		TheSpiderBall
	
.org 80077ACh					;���ĺ��ʵĶ���
	bl		BallAnimationControl
	
.org 800B4CAh					;����ȫװ+��������ɫ��
	mov 	r3,2h
	bl		SpiderBallPaletteChanged
;������Ϸ��,����������ǰ�����ȫװ	
.org 800B522h					;����ȫװ ��������ɫ��
	mov		r3,3h
	bl		SpiderBallPaletteChanged
;������Ϸ��������õ���һ����!�����޷��ر�,��ȫװ�������Ϳ���
.org 800B57Eh					;���ķ�ȫװ+���ȵ�ɫ��
	mov		r3,1h
	bl		SpiderBallPaletteChanged
;mage�ĵ���ģʽ��ı�һЩ����,ʹȫװ+���ȳ�Ϊ����		
.org 800B5CEh					;������ȫװ�޸��ȵ�ɫ��
	mov		r3,0h
	bl		SpiderBallPaletteChanged
;���ǿ�ʼ�ķ�װ��!	

.org 8761D38h					;ĩβ��������
.align
SpiderBallPalette:
.import "spiderBall.palette"

;ƫ��0Ϊ��������֩�����ɫ��
;ƫ��20Ϊ����Ĳ�Ӱ��ɫ
;ƫ��40Ϊ��������֩��������ɫ��

;ƫ��A0Ϊ���ȷ���֩�����ɫ��
;ƫ��C0Ϊ����Ĳ�Ӱ��ɫ
;ƫ��E0Ϊ���ȷ���֩��������ɫ��

;ƫ��140Ϊ��������֩�����ɫ��
;ƫ��160Ϊ����Ĳ�Ӱ��ɫ
;ƫ��180Ϊ��������֩��������ɫ��

;ƫ��1E0Ϊȫ������֩�����ɫ��
;ƫ��200Ϊ����Ĳ�Ӱ��ɫ
;ƫ��220Ϊȫ������֩��������ɫ��
	
.org 8304054h					;�������ݵĵ�ַ
TheSpiderBall:
	push	r0,lr
	mov		r2,0h
	ldr		r0,=3001542h		;��ǰ��װ��
	ldrb	r0,[r0]
	cmp		r0,2h				;����ʽ���Żἤ��֩����
	beq		@@CorrectReturn
	bl		SpiderBallMain
@@CorrectReturn:
	pop		r0	
	ldr		r1,=30013D4h
	ldrb	r1,[r1]
	cmp		r2,0h				;�����֩�����Pose
	bne		@@OtherCome
	cmp		r1,11h				;������
	beq		@@MorphNormalPose
	cmp		r1,12h				;������
	beq		@@MorphRollingPose
	cmp		r1,14h				;������
	bne		@@end
	ldrh	r1,[r0]
	mov		r0,40h
	b 		@@end
.pool
@@MorphNormalPose:
	mov		r4,r0
	ldrb	r0,[r4,4h]
	b 		@@end
@@MorphRollingPose:
	ldrh	r1,[r0]
	mov		r2,1h
	b		@@end
@@OtherCome:
	pop		r3
	cmp		r1,11h
	beq		@@MorphNormalSpiderBallPose
	cmp		r1,12h
	beq		@@MorphRollingSpiderBallPose
	ldr		r3,=80095FAh
	b		@@SpiderBallRetrun
	.pool
@@MorphNormalSpiderBallPose:
	ldr		r3,=80093AAh
	b		@@SpiderBallRetrun
	.pool
@@MorphRollingSpiderBallPose:
	ldr		r3,=8009464h
	b		@@SpiderBallRetrun
	.pool
@@end:
	pop		r3
@@SpiderBallRetrun:	
	mov		r15,r3
.pool
	
SpiderBallMain:
	push	r4-r7,lr
	ldr		r0,=300137Ch		;����
	ldr		r6,=XTagRAM
	mov		r7,0F0h
	mov		r4,r0
	mov		r5,r4
	add		r5,58h				;�õ�13d4
	bl		SpiderBallSuitableControl
	bl		SpiderBallCheckRemove
	bl		SpiderBallPreciseCoordinates
	ldrb	r0,[r4,8h]
	lsl		r0,r0,2h
	ldr		r1,=SpiderBallPoseTable
	add		r0,r1
	ldr		r0,[r0]
	mov		r15,r0
.pool
SpiderBallPoseTable:
	.word	SpiderBallCheckFlag
	.word	SpiderBallOnFloor
	.word	SpiderBallOnCeiling
	.word 	SpiderBallOnLeftWall
	.word	SpiderBallOnRightWall
SpiderBallCheckFlag:
	bl		SpiderBallCheckFlagPose
	b		@Thend
SpiderBallOnFloor:
	bl		SpiderBallOnFloorPose
	b		@Thend
SpiderBallOnCeiling:
	bl		SpiderBallOnCeilingPose
	b 		@Thend
SpiderBallOnLeftWall:
	bl		SpiderBallOnLeftWallPose
	b		@Thend
SpiderBallOnRightWall:
	bl		SpiderBallOnRightWallPose
	
@Thend:	
	ldrb	r2,[r4,8h]
	pop		r4-r7
	pop		r1
	bx		r1
.pool
	
SpiderBallPreciseCoordinates:	;��ʱʹ������ǽ�������л��Ķ�����
	ldrb	r1,[r4,8h]			;��ȡ֩����Pose
	cmp		r1,1h				;�������1�Ļ�
	bls		@@end
	cmp		r1,2h
	bhi		@@NoCeilingPose
	ldrh	r0,[r5,14h]			;����Y����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]
	b 		@@end
@@NoCeilingPose:
	ldrh	r0,[r5,12h]			;����X����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	cmp		r1,3h
	bne		@@RightWallPose
	add		r0,1Ch
	b		@@WriteFixX
@@RightWallPose:
	add		r0,23h
@@WriteFixX:
	strh	r0,[r5,12h]
@@end:
	bx		r14
.pool	

SpiderBallCheckRemove:			;���֩����Ľ��
	push	r4-r7,lr
	add		sp,-10h
	mov		r2,r5
	add		r2,20h				;13F4
	ldrb	r0,[r2]				;��ȡ��һ������
	cmp		r0,31h				;������1�Ļ�
	beq		@@AllReturnSpiderBallZero
	cmp		r0,32h				;������2�Ļ�
	beq		@@AllReturnSpiderBallZero
	ldrb	r1,[r4,9h]
	cmp		r1,2h
	bne		@@PassAllReturnZero
	cmp		r0,27h				;���̽���
	bne		@@end
	mov		r0,20h
	strb	r0,[r2]				;�ı���һ��Poseֵ��ֹ����
@@AllReturnSpiderBallZero:
	mov		r0,0h
	strh	r0,[r4,8h]			;ȫ������
	b		@@end	
@@PassAllReturnZero:	
	ldrb	r0,[r4,8h]
	cmp		r0,0h				;���֩��������
	beq		@@end				;û�����������
	ldrh	r0,[r4]				;��ȡ����
	mov		r1,0A0h
	lsl		r1,r1,2h
	and		r0,r1
	lsr		r0,r0,2h
	cmp		r0,0A0h
	bne		@@CheckBombContact				;����Ƿ����º�L
	ldrh	r0,[r4,4h]			;��ȡ��ʱ����
	and		r0,r1
	cmp		r0,0h				;�м�ʱ������ȡ��֩����
	beq		@@CheckBombContact
	; beq		@@end
	mov		r0,0h				;����Ҫ���ȡ��
	strb	r0,[r4,8h]
	mov		r0,1h
	strb	r0,[r4,9h]			;�����ȡ���ı��
	ldr		r0,=24Fh
	bl		PlaySound2
	b		@@end
	.pool
@@CheckBombContact:
	ldr		r7,=3000A2Ch		;��ҩ���ݵ�ַ
	ldr		r6,=30015D8h		;�����ж���ַ
@@Loop:	
	ldrb	r0,[r7]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h				;����Ƿ�����Ч�ĵ���
	beq		@@NextPro			;��Ч������һ��
	ldrb	r0,[r7,0Fh]
	cmp		r0,0Eh				;����Ƿ���ը��
	bne		@@NextPro			;���Ǽ����һ��
	ldrb	r0,[r7,11h]
	cmp		r0,3h				;���ը���Ľ����Ǳ�ը>
	bne		@@NextPro			;���Ǽ����һ��
	ldrh	r0,[r7,8h]			;ը����Y����
	ldrh	r1,[r7,14h]			;ը�����ϲ��ж�
	add		r1,r0
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	str		r1,[sp]				;������
	ldrh	r1,[r7,16h]			;ը�����²��ж�
	add		r1,r0
	str		r1,[sp,4h]			;������
	ldrh	r0,[r7,0Ah]			;ը����X����
	ldrh	r1,[r7,18h]			;ը�������ж�
	add		r1,r0
	lsl		r1,r1,10h
	lsr		r1,r1,10h
	str		r1,[sp,8h]			;������
	ldrh	r1,[r7,1Ah]			;ը�����Ҳ��ж�
	add		r1,r0
	str		r1,[sp,0Ch]			;������
	ldrh	r1,[r5,12h]			;�����X����
	ldrh	r2,[r6]				;��������ж�
	add		r2,r1
	lsl		r2,r2,10h
	lsr		r2,r2,10h			;�˼���
	ldrh	r3,[r6,2h]			;������Ҳ��ж�
	add		r3,r1				;�˼���
	ldrh	r1,[r5,14h]			;�����Y���� �˼���
	ldrh	r0,[r6,4h]			;������ϲ��ж�
	add		r0,r1
	lsl		r0,r0,10h
	lsr		r0,r0,10h			;�˼���
	bl		800E6F8h			;����Ƿ��ཻ
	cmp		r0,0h
	beq		@@NextPro
	; b		@@AllReturnSpiderBallZero
	mov		r0,0h
	strb	r0,[r4,8h]
	mov		r0,8h
	strb	r0,[r4,9h]
	b		@@end
.pool
@@NextPro:
	add		r7,1Ch
	ldr		r0,=3000BECh		;��ҩ���ݽ�����ַ
	cmp		r7,r0
	bcc		@@Loop
@@end:
	add		sp,10h
	pop		r4-r7
	pop		r1
	bx		r1
.pool	
	
SpiderBallSuitableControl:		;���ڴ�����赼�ĸı�Pose
	push	lr
	ldrb	r0,[r4,9h]
	cmp		r0,0h
	bne		@@EndTransferStation				;����ǳ������������
	ldrb	r2,[r4,8h]
	cmp		r2,0h
	beq		@@EndTransferStation				;û�п���֩���������
	cmp		r2,2h
	bhi		@@LeftAndRightWallPose
	ldrb	r3,[r4]				;��ȡ����
	mov		r1,30h				;������½������Ƿ�������
	and		r1,r3
	cmp		r1,0h
	bne		@@EndTransferStation				;����������������
	mov		r1,0C0h				;û�а����������Ƿ�������
	and		r1,r3
	cmp		r1,0h
	beq		@@EndTransferStation				;û�а����������
	cmp		r2,1h
	bne		@@CeilingPose		;����Ƿ��ǵ������
	mov		r1,40h
	and		r1,r3				;����Ƿ񰴵���
	cmp		r1,0h				;�����ϵĻ�
	bne		@@CheckInSide		;����ڽ�
	ldrh	r0,[r5,14h]			;������
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@FloorLeftDownNoBlock
	ldrh	r0,[r5,14h]			;������ж�
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@EndTransferStation				;������߶���ש�����
	mov		r0,81h				;���µ������ƶ�
	b 		@@WriteNewStillingPress
@@FloorLeftDownNoBlock:			
	mov		r0,80h				;���µ������ƶ�
	b		@@WriteNewStillingPress	
@@CeilingPose:
	mov		r1,80h
	and		r1,r3
	cmp		r1,0h				;�컨�尴���µĻ�
	bne		@@CheckInSide		;����ڽ�
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,60h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@CeilingRightUpNoBlock
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,60h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@EndTransferStation				;���߶���ש�������
	mov		r0,40h				;���ϵ������ƶ�
	b		@@WriteNewStillingPress
@@CeilingRightUpNoBlock:		;�������û��ש�Ļ�
	mov		r0,41h				;���ϵ������ƶ�
	b		@@WriteNewStillingPress
@@CheckInSide:	
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	sub		r1,3Ch				;����������			
	bl		CheckBlock			;����Ƿ�����н���
	ldrb	r0,[r6,1h]
	and		r0,r7				
	cmp		r0,0h
	beq		@@CheckRightWall	;���û�н��������ұ�
	; ldrh	r0,[r5,12h]			;��������
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; add		r0,1Ch
	; strh	r0,[r5,12h]
	ldrb	r0,[r4,8h]
	cmp		r0,1h
	bne		@@CeilingPoseInsideLeft
	mov		r0,40h
	b		@@WriteNewStillingPress	;����������ϵ������ƶ�
@@CeilingPoseInsideLeft:
	mov		r0,80h
	b		@@WriteNewStillingPress	;�컨�尴�������ƶ�
	; mov		r2,3h				;��߽�����д����Pose
	; b		@@WriteNewPose
@@EndTransferStation:
	b		@@end
	
@@CheckRightWall:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	add		r1,3Ch				;��Ӱ������
	bl		CheckBlock			;����ұ��Ƿ��н���
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h	
	beq		@@end				;�ұ�û�н��������
	; ldrh	r0,[r5,12h]			;��������
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; add		r0,23h
	; strh	r0,[r5,12h]
	ldrb	r0,[r4,8h]
	cmp		r0,1h
	beq		@@FloorPoseInsideRight
	mov		r0,81h
	b		@@WriteNewStillingPress
@@FloorPoseInsideRight:
	mov		r0,41h
	b		@@WriteNewStillingPress
	; mov		r2,4h
	; b		@@WriteNewPose		;�ұ߽�����д����Pose	
@@LeftAndRightWallPose:	
	ldrb	r3,[r4]
	mov		r1,0C0h				;����Ƿ�������
	and		r1,r3
	cmp		r1,0h
	bne		@@end				;�������������
	mov		r1,30h				
	and		r1,r3				;����Ƿ�������
	beq		@@end				;û�а����������
	mov		r1,20h
	and		r1,r3				;����Ƿ�����
	cmp		r1,0h
	beq		@@PressRight
	ldrb	r0,[r4,8h]			;����Pose
	cmp		r0,4h				;�Ƿ�����ǽ����
	beq		@@LeftAndRightWallInside ;��ǽ�������ڽ�
	ldrh	r0,[r5,14h]			;���������
	ldrh	r1,[r5,12h]
	add		r0,4h				
	sub		r1,20h				
	bl		CheckBlock			;�������
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@LeftWallDownLeftNoBlock
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,20h				;�������
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@end				;���¶���ש�����
	mov		r0,20h				;�󰴼����ƶ�
	b		@@WriteNewStillingPress
@@LeftWallDownLeftNoBlock:		;���������û��ש
	mov		r0,21h				;�󰴼����ƶ�
	b 		@@WriteNewStillingPress
@@PressRight:
	ldrb	r0,[r4,8h]			
	cmp		r0,4h				;����Ƿ�����ǽ����
	bne		@@LeftAndRightWallInside	;�������ڽǼ��
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,20h
	bl		CheckBlock			;��ǽ�����Ұ����������
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@RightWallPoseRightUpNoBlock
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,4h
	add		r1,20h
	bl		CheckBlock			;�������
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@end				;��ǽ�������¶���ש�����
	mov		r0,11h				;�ҽ����������ƶ�
	b		@@WriteNewStillingPress
@@RightWallPoseRightUpNoBlock:
	mov		r0,10h				;�ҽ����������ƶ�
	b		@@WriteNewStillingPress
@@LeftAndRightWallInside:	
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h				;���°������			
	bl		CheckBlock			;�������Ƿ����
	ldrb	r0,[r6,1h]			
	cmp		r0,0h
	beq		@@CheckCeiling		;����û�н��������컨��
	; ldrh	r0,[r5,14h]			;��������
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; add		r0,3Fh
	; strh	r0,[r5,14h]
	ldrb	r0,[r4,8h]
	cmp		r0,3h
	bne		@@RightWallPressLeftMoveDown
	mov		r0,11h				;��ǽ���������ƶ�
	b		@@WriteNewStillingPress
@@RightWallPressLeftMoveDown:	
	mov		r0,21h				;��ǽ���������ƶ�
	b		@@WriteNewStillingPress
@@CheckCeiling:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,5Ch				;���ϰ������
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@end				;�컨��Ҳû�н��������
	; ldrh	r0,[r5,14h]			;��������
	; lsr		r0,r0,6h
	; lsl		r0,r0,6h
	; sub		r0,4h
	; strh	r0,[r5,14h]
	ldrb	r0,[r4,8h]
	cmp		r0,4h
	bne		@@LeftWallPosePressRightUpMove
	mov		r0,20h				;��ǽ�����������ƶ�
	b		@@WriteNewStillingPress
@@LeftWallPosePressRightUpMove:	
	mov		r0,10h				;��ǽ�����Ұ������ƶ�
@@WriteNewStillingPress:
	strb	r0,[r4,9h]
@@end:	
	pop		r1
	bx		r1
.pool		
	
SpiderBallCheckFlagPose:		;����Ƿ�Ҫ����֩����
	push	lr
	ldrb	r0,[r4,9h]
	cmp		r0,3h
	bcc		@@CanSpiderBall
	sub		r0,1h
	strb	r0,[r4,9h]
	b 		@@end
@@CanSpiderBall:	
	ldrh	r0,[r4]
	mov		r1,88h
	lsl		r1,r1,2h
	and		r1,r0
	lsr		r1,r1,2h
	cmp		r1,88h				;����Ƿ�����+L
	beq		@@LeftWallCheck
	mov		r1,84h
	lsl		r1,r1,2h
	and		r0,r1
	cmp		r0,r1				;����Ƿ�����+L
	beq		@@RightWallCheck
@@UpDownCheck:	
	ldrh	r0,[r4]				;��ȡ����
	mov		r1,0A0h
	lsl		r1,r1,2h
	and		r0,r1				;����Ƿ�����+L
	cmp		r0,r1
	beq		@@DisFlagCheck
	ldrh	r0,[r4]
	mov		r1,90h				;����Ƿ�����+L
	lsl		r1,r1,2h
	and		r0,r1
	cmp		r0,r1
	; beq		@@InstantUPOrLCheck
	beq		@@CeilingCheck
	b 		@@end
; @@InstantUPOrLCheck:	
	; ldrh	r0,[r4,4h]			;��鼴ʱ����L����
	; and		r0,r1
	; cmp		r0,0h				
	; bne		@@CeilingCheck
	; b		@@end
@@DisFlagCheck:
	ldrb	r0,[r4,9h]			;���ո�ȡ���ı��
	cmp		r0,0h				;����ո�ȡ����Ϊ1
	beq		@@CheckUpDown
	cmp		r0,1h				
	bhi		@@CheckPressing		;����1�Ż������鼴ʱ����
	add		r0,1h
	strb	r0,[r4,9h]			;+1 �ü�ʱ����������һ֡��ʼ,��ֹ����������ֹر�
	b 		@@end
@@CheckPressing:
	ldrh	r0,[r4,4h]						
	and		r1,r0				;����»�L�Ƿ��м�ʱ�����
	cmp		r1,0h
	bne		@@DisFlagReturnZero
	b 		@@end
@@DisFlagReturnZero:
	mov		r0,0h
	strb	r0,[r4,9h]			;�ո�ȡ�����ȥ��
@@CheckUpDown:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	sub		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	; and		r0,r7
	cmp		r0,0h
	bne		@@FloorBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	add		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	; and		r0,r7
	cmp		r0,0h
	beq		@@CeilingCheck
@@FloorBorder:
	mov		r0,1h
	b 		@@WritePose
@@CeilingCheck:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@CeilingBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@CeilingBorder
	b 		@@end
@@CeilingBorder:
	ldrh	r0,[r5,14h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]				;����Y
	mov		r0,2h
	b 		@@WritePose
@@LeftWallCheck:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@LeftWallBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@UpDownCheck
@@LeftWallBorder:
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]				;����X
	mov		r0,3h
	b 		@@WritePose
@@RightWallCheck:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightWallBorder
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightWallBorder
	b 		@@UpDownCheck
@@RightWallBorder:
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	mov		r0,4h
@@WritePose:
	strb	r0,[r4,8h]
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;�ٶ�ȫ����
	strb	r0,[r4,9h]				;ȡ����ǹ���
	ldr		r0,=24Fh
	bl		PlaySound
@@end:
	pop		r1
	bx		r1
.pool	
	
SpiderBallOnFloorPose:				;������
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]				;X�ٶȹ���
	ldrb	r1,[r4,9h]				;��ȡpose�л���������flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;ȥ�����������
	ldrh	r0,[r4]
	and		r0,r1					;����Ƿ��˱�ǵķ���
	cmp		r0,0h
	bne		@@StillingPress
@@PressStillingReturnZero:
	mov		r0,0h
	strb	r0,[r4,9h]				;������ǹ���
	b		@@NoPressStilling
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;��������ƶ�
	beq		@@LeftMove
	b		@@RightMove
@@NoPressStilling:
	ldrh	r0,[r4]					;��ȡ����
	mov		r1,30h
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
;	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
;	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero	
	b      	@@end
@@NoEnd:	
	strb	r0,[r5,0Eh]				;�������
	cmp		r0,10h
	beq		@@RightMove
@@LeftMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@LeftNoBlock
	ldrh	r0,[r5,12h]				;����X����
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]				;��鰴�������Ƿ���Ȼ����
	cmp		r1,0h
	bne		@@FloorToLeftWallOldPressStilling
	mov		r0,3h					;��ǽ����Pose			
	mov		r1,20h					;��������������ƶ�
	b		@@WriteNewPose
@@FloorToLeftWallOldPressStilling:
	and		r1,r7					;ȥ����������ݱ�������İ���
	mov		r0,3h
	b		@@WriteNewPose
@@LeftNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	sub		r1,4h
	bl		CheckBlock				;���������Ƿ��Ѿ��뿪��ש��
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,20h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:
	strh	r0,[r4,8h]
	b 		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,12h]				;����Ҫ��ǽ���µ�����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@FloorToRightWallOldPressStilling
	mov		r0,4h					;��ǽ����
	mov		r1,21h					;��������������ƶ�
	b		@@WriteNewY
@@FloorToRightWallOldPressStilling:
	mov		r0,1h
	orr		r1,r0
	mov		r0,4h
	b		@@WriteNewY
@@RightMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Eh
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@RightNoBlock
	ldrh	r0,[r5,12h]				;����Ҫ��ǽ�ϵ�����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@FloorToRightWallOldPressStilling2
	mov		r0,4h					;��ǽ����Pose	
	mov		r1,10h					;���Һ������ƶ����
	b		@@WriteNewPose			
@@FloorToRightWallOldPressStilling2:
	and		r1,r7
	mov		r0,4h
	b		@@WriteNewPose
@@RightNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]					;�������
	ldrh	r1,[r5,12h]
	add		r0,20h
	sub		r1,21h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@FloorToLeftWallOldPressStilling2
	mov		r0,3h					;��ǽ����Pose
	mov		r1,11h					;���Һ����ƶ����
	b 		@@WriteNewY
@@FloorToLeftWallOldPressStilling2:
	mov		r0,1h
	orr		r1,r0
	mov		r0,3h
@@WriteNewY:
	ldrh	r2,[r5,14h]				;��Y����һ��
	add		r2,8h
	strh	r2,[r5,14h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@LeftMoveX:
	ldrh	r1,[r5,12h]
	sub		r1,4h
	b		@@WriteNewX
@@RightMoveX:
	ldrh	r1,[r5,12h]
	add		r1,4h
@@WriteNewX:	
	strh	r1,[r5,12h]
@@end:	
	pop		r1
	bx		r1
.pool

SpiderBallOnCeilingPose:			;�컨����
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;�������е��ٶ�		
	ldrb	r1,[r4,9h]				;��ȡpose�л���������flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;ȥ�����������	
	ldrh	r0,[r4]
	and		r0,r1					;����Ƿ��ų����İ���
	cmp		r0,0h
	beq		@@PressStillingReturnZero		
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;��������ƶ�
	beq		@@LeftMove
	b		@@RightMove
@@PressStillingReturnZero:
	mov		r0,0h
	strb	r0,[r4,9h]				;������ǹ���
@@NoPressStilling:
	ldrh	r0,[r4]					;��ȡ����
	mov		r1,30h
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]				;����Ƿ��޽���׹��
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	sub		r0,40h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	b		@@end
@@NoEnd:	
	mov		r1,30h
	eor		r1,r0
	strb	r1,[r5,0Eh]				;�������
	cmp		r0,10h
	beq		@@RightMove
@@LeftMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Fh
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@LeftNoBlock
	ldrh	r0,[r5,12h]				;����X����
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToLeftWallPressStilling
	mov		r0,3h					;��ǽ����
	mov		r1,21h					;������������ƶ�
	b		@@WriteNewPose
@@CeilingToLeftWallPressStilling:
	mov		r0,1h
	orr		r1,r0
	mov		r0,3h
	b 		@@WriteNewPose
@@LeftNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,1Dh
	sub		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Dh
	sub		r1,4h
	bl		CheckBlock				;���������Ƿ��Ѿ��뿪��ש��
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@LeftMoveX
	ldrh	r0,[r5,14h]				;����Ƿ��޽���׹��
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,20h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:
	mov		r0,0h
	strh	r0,[r4,8h]
	b		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,12h]				;����Ҫ��ǽ���ϵ�����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToRightWallPressStilling
	mov		r0,4h					;��ǽ����Pose
	mov		r1,20h					;�󰴼������ƶ����
	b		@@WriteNewY
@@CeilingToRightWallPressStilling:
	and		r1,r7
	mov		r0,4h
	b 		@@WriteNewY
@@RightMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,1Fh
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@RightNoBlock
	ldrh	r0,[r5,12h]				;����Ҫ��ǽ���µ�����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,23h
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToRightWallPressStilling2
	mov		r0,4h					;��ǽ����Pose
	mov		r1,11h					;���Һ����ƶ����
	b		@@WriteNewPose
@@CeilingToRightWallPressStilling2:
	mov		r0,1h
	orr		r1,r0
	mov		r0,4h
	b 		@@WriteNewPose
@@RightNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	add		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,1Dh
	add		r1,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@RightMoveX
	ldrh	r0,[r5,14h]					;�������
	ldrh	r1,[r5,12h]
	sub		r0,40h
	sub		r1,21h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,12h]
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,1Ch
	strh	r0,[r5,12h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@CeilingToLeftWallPressStilling2
	mov		r0,3h					;��ǽ����Pose
	mov		r1,10h					;���Һ����ƶ����
	b 		@@WriteNewY
@@CeilingToLeftWallPressStilling2:
	and		r1,r7
	mov		r0,3h
@@WriteNewY:
	ldrh	r2,[r5,14h]				;ʹY��������һ��
	sub		r2,8h
	strh	r2,[r5,14h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@LeftMoveX:
	ldrh	r1,[r5,12h]
	sub		r1,4h
	b		@@WriteNewX
@@RightMoveX:
	ldrh	r1,[r5,12h]
	add		r1,4h
@@WriteNewX:	
	strh	r1,[r5,12h]
@@end:	
	pop		r1
	bx		r1
.pool

SpiderBallOnLeftWallPose:
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;�������е��ٶ�		
	ldrb	r1,[r4,9h]				;��ȡ��������flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;ȥ�����������
	ldrh	r0,[r4]
	and		r0,r1					;����Ƿ��������
	cmp		r0,0h
	beq		@@PressStillingReturnZero		
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;��������ƶ�
	beq		@@UpMove
	b		@@DownMove
@@PressStillingReturnZero:			;һ���ɿ����������������ǹ���
	mov		r0,0h
	strb	r0,[r4,9h]				;������ǹ���
@@NoPressStilling:
	ldrh	r0,[r4]					;��ȡ����
	mov		r1,0C0h					;����Ƿ�������
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	sub		r0,3Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	b 		@@end
@@NoEnd:	
	mov		r1,r0
	lsr		r1,r1,2h				
	mov		r2,30h
	eor		r1,r2
	strb	r1,[r5,0Eh]				;�������
	cmp		r0,80h
	beq		@@DownMove
@@UpMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@UpNoBlock
	ldrh	r0,[r5,14h]				;����Y����
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	sub		r0,4h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToCeilingPressStilling
	mov		r0,2h					;�컨�����
	mov		r1,41h					;�����Ϻ������ƶ�
	b		@@WriteNewPose
@@LeftWallToCeilingPressStilling:
	mov		r0,1h
	orr		r1,r0
	mov		r0,2h
	b 		@@WriteNewPose
@@UpNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	sub		r1,1Dh					;��齫Ҫ�������Ƿ����
	bl		CheckBlock				;�����ǽ�ڵİ���
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
;	add		r0,1h
	sub		r0,4h					;��齫Ҫ�еͲ��Ƿ����
	sub		r1,1Dh					
	bl		CheckBlock				;���������ǽ�ڵİ���
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]				;����Ƿ��Ѿ�����
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:	
	mov		r0,0h
	strh	r0,[r4,8h]
	b		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,14h]				;����Y����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	sub		r0,1h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToFloorPressStilling
	mov		r0,1h					;�������Pose
	mov		r1,40h					;�ϰ��������ƶ����
	b		@@WriteNewX
@@LeftWallToFloorPressStilling:
	and		r1,r7
	mov		r0,1h
	b		@@WriteNewX
@@DownMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	bl		CheckBlock				;����·��Ƿ��е���
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@DownNoBlock			
	ldrh	r0,[r5,14h]				;����Y����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Fh
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToFloorPressStilling2
	mov		r0,1h					;�������Pose
	mov		r1,81h					;���º����ƶ����
	b		@@WriteNewPose
@@LeftWallToFloorPressStilling2:
	mov		r0,1h
	orr		r1,r0
	b 		@@WriteNewPose
@@DownNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	sub		r1,1Dh					;��齫�����²��Ƿ�Խ��
	bl		CheckBlock				;��������µİ���
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch					;��齫�����ϲ��Ƿ�Խ��
	add		r0,4h
	sub		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]				;����Ƿ�׹��
	ldrh	r1,[r5,12h]
	sub		r1,1Dh
	sub		r0,3Ch
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,14h]				;����Y����	
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@LeftWallToCeilingPressStilling2
	mov		r0,2h					;�컨�����
	mov		r1,80h					;���º����ƶ����
	b 		@@WriteNewX
@@LeftWallToCeilingPressStilling2:
	and		r1,r7
	mov		r0,2h
@@WriteNewX:
	ldrh	r2,[r5,12h]
	sub		r2,8h
	strh	r2,[r5,12h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@UpMoveY:
	ldrh	r1,[r5,14h]
	sub		r1,4h
	b		@@WriteNewY
@@DownMoveY:
	ldrh	r1,[r5,14h]
	add		r1,4h
@@WriteNewY:	
	strh	r1,[r5,14h]
@@end:	
	pop		r1
	bx		r1
.pool

SpiderBallOnRightWallPose:			;��ǽ����Pose
	push	lr
	mov		r0,0h
	strh	r0,[r5,16h]
	strh	r0,[r5,18h]				;�������е��ٶ�		
	ldrb	r1,[r4,9h]				;��ȡ��������flag
	cmp		r1,0h
	beq		@@NoPressStilling
	and		r1,r7					;ȥ�����������
	ldrh	r0,[r4]
	and		r0,r1					;����Ƿ��������
	cmp		r0,0h
	beq		@@PressStillingReturnZero		
@@StillingPress:
	ldrb	r0,[r4,9h]
	mov		r1,1h
	and		r0,r1
	cmp		r0,0h					;��������ƶ�
	beq		@@UpMove
	b		@@DownMove
@@PressStillingReturnZero:			;һ���ɿ����������������ǹ���
	mov		r0,0h
	strb	r0,[r4,9h]				;������ǹ���
@@NoPressStilling:
	ldrh	r0,[r4]					;��ȡ����
	mov		r1,0C0h					;����Ƿ�������
	and		r0,r1
	cmp		r0,0h
	bne		@@NoEnd
	ldrh	r0,[r5,14h]				;����Ƿ�׹��
	ldrh	r1,[r5,12h]
	add		r1,1Dh
	sub		r0,3Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@TwinCheckDrop
	b 		@@end
@@TwinCheckDrop:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	add		r0,1h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	b 		@@end
@@NoEnd:	
	mov		r1,r0
	lsr		r1,r1,2h				
	mov		r2,30h
	strb	r1,[r5,0Eh]				;�������
	cmp		r0,80h
	beq		@@DownMove
@@UpMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@UpNoBlock
	ldrh	r0,[r5,14h]				;����Y����
	lsr		r0,r0,6h				
	lsl		r0,r0,6h
	sub		r0,4h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToCeilingPressStilling
	mov		r0,2h					;�컨�����
	mov		r1,40h					;�����Ϻ������ƶ�
	b		@@WriteNewPose
@@RightWallToCeilingPressStilling:
	and		r1,r7
	mov		r0,2h
	b 		@@WriteNewPose
@@UpNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	sub		r0,4h
	add		r1,1Dh					;��齫�д��Ƿ����
	bl		CheckBlock				;�����ǽ�ڵİ���
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
;	add		r0,1h
	sub		r0,4h					;��齫�еͲ��Ƿ����
	add		r1,1Dh					
	bl		CheckBlock				;���������ǽ�ڵİ���
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h					
	bne		@@UpMoveY
	ldrh	r0,[r5,14h]				;����Ƿ�׹��
	ldrh	r1,[r5,12h]
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@ChangedNewPose
@@ReturnPoseZero:
	mov		r0,0h
	strh	r0,[r4,8h]
	b		@@end
@@ChangedNewPose:	
	ldrh	r0,[r5,14h]				;����Y����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	sub		r0,1h
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToFloorPressStilling
	mov		r0,1h					;�������Pose
	mov		r1,41h					;�ϰ��������ƶ����
	b		@@WriteNewX
@@RightWallToFloorPressStilling:
	mov		r0,1h
	orr		r1,r0
	b		@@WriteNewX
@@DownMove:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	bl		CheckBlock				;����·��Ƿ��е���
	ldrb	r0,[r6,1h]
	cmp		r0,0h
	beq		@@DownNoBlock			
	ldrh	r0,[r5,14h]				;����Y����
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Fh
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToFloorPressStilling2
	mov		r0,1h					;�������Pose
	mov		r1,80h					;���º����ƶ����
	b		@@WriteNewPose
@@RightWallToFloorPressStilling2:
	mov		r0,1h
	and		r1,r7
	b 		@@WriteNewPose
@@DownNoBlock:
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	; add		r0,1h
	add		r0,4h
	add		r1,1Dh					;;��齫Ҫ�ƶ�������
	bl		CheckBlock				;��������µİ���				
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]
	ldrh	r1,[r5,12h]
	sub		r0,3Ch					;������²��Ƿ�Խ��
	add		r0,4h
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	bne		@@DownMoveY
	ldrh	r0,[r5,14h]				;����Ƿ�׹��
	ldrh	r1,[r5,12h]
	sub		r0,3Ch
	add		r1,1Dh
	bl		CheckBlock
	ldrb	r0,[r6,1h]
	and		r0,r7
	cmp		r0,0h
	beq		@@ReturnPoseZero
	ldrh	r0,[r5,14h]				;����Y����	
	lsr		r0,r0,6h
	lsl		r0,r0,6h
	add		r0,3Ch
	strh	r0,[r5,14h]
	ldrb	r1,[r4,9h]
	cmp		r1,0h
	bne		@@RightWallToCeilingPressStilling2
	mov		r0,2h					;�컨�����
	mov		r1,81h					;���º����ƶ����
	b 		@@WriteNewX
@@RightWallToCeilingPressStilling2:
	mov		r0,1h
	orr		r1,r0
	add		r0,1h
@@WriteNewX:
	ldrh	r2,[r5,12h]
	add		r2,8h
	strh	r2,[r5,12h]
@@WriteNewPose:
	strb	r0,[r4,8h]
	strb	r1,[r4,9h]
	b		@@end
@@UpMoveY:
	ldrh	r1,[r5,14h]
	sub		r1,4h
	b		@@WriteNewY
@@DownMoveY:
	ldrh	r1,[r5,14h]
	add		r1,4h
@@WriteNewY:	
	strh	r1,[r5,14h]
@@end:	
	pop		r1
	bx		r1
.pool

BallAnimationControl:
	push	r4-r6
	mov		r5,r0
	ldrb	r0,[r4]
	cmp		r0,11h
	beq		@@IsBall
	cmp		r0,12h
	beq		@@IsBall
	cmp		r0,14h
	bne		@@NoBall
@@IsBall:
	ldr		r6,=300137Ch
	ldrh	r1,[r6]				;��ȡ����
	ldrb	r2,[r6,8h]			;����Ƿ���֩�����Pose
	cmp		r2,0h
	beq		@@NoBall			;֩����û�м��������
	; mov		r0,80h
	; lsl		r0,r0,2h
	; and		r0,r1
	; cmp		r0,0h				;����Ƿ���L
	; beq		@@NoPressL
	; mov		r0,7h
	; b		@@OnlyChange1D
; @@NoPressL:	
	ldrb	r0,[r6,9h]			
	cmp		r0,0h
	bne		@@SlowAnimation				;����ǳ����ƶ��򶯻�����һ��
	cmp		r2,2h
	bhi		@@LeftAndRightWallPose
	ldrh	r1,[r6]
	mov		r0,30h
	and		r0,r1
	cmp		r0,0h
	bne		@@SlowAnimation		;����������������Ķ���
	cmp		r2,1h
	bne		@@CeilingPose
	ldrb	r0,[r4,1Dh]			;�������֩����ֹͣ����
	cmp		r0,2h
	bcc		@@OnlyChange1D
	cmp		r0,7h
	beq		@@OnlyChange1D
	mov		r1,2h
	eor		r0,r1
	cmp		r0,2h
	bcc		@@OnlyChange1D
	cmp		r0,7h
	beq		@@OnlyChange1D
	mov		r1,4h
	eor		r0,r1
	b		@@OnlyChange1D
@@CeilingPose:
	ldrb	r0,[r4,1Dh]
	cmp		r0,0h
	bne		@@CeilingNextCheck
	mov		r0,1h
	b		@@OnlyChange1D
@@CeilingNextCheck:
	cmp		r0,3h
	bcc		@@OnlyChange1D
	cmp		r0,5h
	bhi		@@OnlyChange1D
	mov		r1,2h
	eor		r0,r1
	b 		@@OnlyChange1D
@@ChangedNewAnimation:
	mov		r1,0h
	strb	r1,[r4,1Ch]			;����֡Ϊ0
@@OnlyChange1D:	
	strb	r0,[r4,1Dh]
	b 		@@end
@@LeftAndRightWallPose:	
	ldrh	r1,[r6]				;��ȡ����
	mov		r0,0C0h				;����Ƿ�������
	and		r0,r1
	cmp		r0,0h				;û�еĻ������
	bne		@@SlowAnimation
	ldrb	r0,[r4,1Dh]			;��ȡ����
	cmp		r0,5h
	bne		@@WallPoseAnimationNextCheck
	ldrb	r1,[r4,1Ch]
	cmp		r1,1h
	bhi		@@OnlyChange1D
	b		@@WallChangePeer
@@WallPoseAnimationNextCheck:
	cmp		r0,2h
	bcc		@@OnlyChange1D
	cmp		r0,4h
	bhi		@@OnlyChange1D
@@WallChangePeer:
	mov		r1,2h
	eor		r0,r1
	b		@@OnlyChange1D
@@SlowAnimation:	
	ldr		r0,=3000002h
	ldrb	r0,[r0]
	mov		r6,1h
	and		r0,r6
	cmp		r0,0h				;֩����ʱ����ƶ�,�����ݽ�����
	beq		@@end
@@NoBall:
	add		r5,1h
	strb	r5,[r4,1Ch]
@@end:
	pop		r4-r6
	bx		r14
.pool	

SpiderBallPaletteChanged:
	push	r0,r1
	ldr		r1,=SamusHeightStage
	ldrb	r0,[r1]
	cmp		r0,2h				;���������׶������	
	bne		@@end
	ldrb	r0,[r5]
	cmp		r0,10h				;����Ƿ��Ǳ�����
	beq		@@end
	cmp		r0,13h				;����Ƿ��Ǳ�����
	beq		@@end
	cmp		r0,1Ch
	beq		@@end				;�ų��˽�����ʽ����
	cmp		r0,2Bh				;������
	beq		@@CheckSpiderBall
	cmp		r0,20h				;20�Ǳ�����ץס,So
	bhi		@@end
	
@@CheckSpiderBall:				;ȫ�ǿ�����֩�������
	mov		r0,0h
	strb	r0,[r5,9h]			;�����������
	mov		r1,r5
	sub		r1,58h				
	ldrb	r0,[r1,8h]			;����Ƿ���֩����
	cmp		r0,0h
	beq		@@end
	mov		r0,0h
	strb	r0,[r5,6h]			;ȥ���޵е�ʱ��
	ldr		r0,=SpiderBallPalette
	mov		r1,0A0h
	mul		r1,r3
	add		r0,r1
	mov		r8,r0
	ldrb	r0,[r5,8h]			;����ʱ��
	cmp		r0,0h
	beq		@@end
	ldr		r0,=SpiderBallPalette + 40h
	mov		r1,0A0h
	mul		r1,r3
	add		r0,r1
	mov		r10,r0
	
@@end:
	pop		r0,r1
	lsl		r1,r1,2h
	add		r0,r1,r0
	ldr		r3,[r0]
	bx		r14
.pool

.close	