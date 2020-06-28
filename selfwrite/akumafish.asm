.gba
.open"zm.gba","akumafish.gba",0x8000000

.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
.definelabel DirectionTag,800F8E0h       ;检查敌人与samus的左右位置
.definelabel MainSpriteDateStart,82b0d68h
.definelabel SamusData,30013d4h
.definelabel CheckRange,800FDE0h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel CheckAnimation,800FBC8h
.definelabel CheckAnimation2,800FC00h
.definelabel CurrSprite,3000738h
.definelabel DeathFireWorks,8011084h
.definelabel SpriteDrop,800E3D4h
.definelabel FrozenRoutine,800FFE8h
.definelabel StunSprite,8011280h
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel AkumafishID,12h
.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteRNG,300083Ch
.definelabel BGDataStart,300009Ch
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0
.definelabel UPOutWaterEffect,80116cch
.definelabel DropInWaterEffect,8011718h
.definelabel MakeWaterEffect,8011620h
;.definelabel AkumaFishUpSpeed,8358F64h
;.definelabel AkumaFishNormalOAM,83598FCh
;.definelabel AkumaFishWillAkumaFishGoUpOAM,835990Ch
;.definelabel AkumaFishGoUpOAM,8359924h
;.definelabel AkumaFishWillAkumaFishDownOAM,8359934h
;.definelabel AkumaFishDownOAM,835995Ch


.org 8761E00h                 ;rom末位空白数据
    .align
AkumafishGfx:
    .import "akumafish.gfx.lz"
    .align
AkumafishPal:
    .import "akumafish.palette"
    .align
.org SpriteAiStart +( AkumafishID * 4 )       ;改写ai的地址
    .word AkumaFishMain + 1
	 
.org SpriteGfxPointers + (AkumafishID - 0x10) * 4
    .word AkumafishGfx

.org SpritePalPointers + (AkumafishID - 0x10) * 4
    .word AkumafishPal

	
////////////////////////////////////////////////////////
.org 8304054h	
AkumaPose0:
     push    r4,r5,lr	
     ldr     r5,=CurrSprite
;因为没有明面的设定分界,所以自加,也许是用例程设置的?	 
     mov     r0,20h
     neg     r0,r0
     strh    r0,[r5,0Ah]  ;上部分界写入FF10h
     mov     r0,4h
     strh    r0,[r5,0Ch]  ;下部分界写入4h
     mov     r0,3Ch
     strh    r0,[r5,10h]  ;右部分界写入3Ch
     neg     r0,r0
     strh    r0,[r5,0Eh]  ;左部分界写入FFC4h	 
     mov     r0,r5	
     add     r0,27h	
     mov     r4,0h	
     mov     r2,10h	
     strb    r2,[r0]    ;上视野写入10	
     mov     r1,r5	
     add     r1,28h	
     mov     r0,8h	
     strb    r0,[r1]    ;左右视野写入8h	
     mov     r0,r5	
     add     r0,29h	
     strb    r2,[r0]    ;下视野写入10	
;     bl 803F57Ch   ;融合未知例程	
     ldr     r0,=AkumaFishNormalOAM	
     str     r0,[r5,18h] ;写入普通趴地面的OAM	
     strb    r4,[r5,1Ch]	
     strh    r4,[r5,16h]	
     ldr     r2,=MainSpriteDateStart ;精灵基础数据起始	
     ldrb    r1,[r5,1Dh]  ;读取ID	
     lsl     r0,r1,3h	
     add     r0,r0,r1	
     lsl     r0,r0,1h     ;ID的14倍,零点好像是18倍	
     add     r0,r0,r2	
     ldrh    r0,[r0]      ;读取设定血量	
     strh    r0,[r5,14h]  ;写入当前血量	
     mov     r1,r5	
     add     r1,25h	
     mov     r0,4h	
     strb    r0,[r1]      ;属性写入2h 零点应该是4	
     sub     r1,1h		
     mov     r0,1h	
     strb    r0,[r1]      ;pose写入1	
	
@@end:	
     pop     r4,r5	
     pop     r0	
     bx      r0	
.pool
	
//////////////////////////////////////////////////////////	
;pose 1 用于落下后的返回	
AkumaPose1:
     ldr     r1,=CurrSprite	
     mov     r3,r1	
     add     r3,24h	
     mov     r2,0h	
     mov     r0,2h	
     strb    r0,[r3]       ;pose写入2	
     strb    r2,[r1,1Ch]	
     strh    r2,[r1,16h]	
     ldr     r0,=AkumaFishNormalOAM	
     str     r0,[r1,18h]   ;再次写入普通的趴地OAM	
     bx      r14	
.pool
	
//////////////////////////////////////////////////////////	
;pose 2 常态循环
AkumaPose2:	
     push    r4,r5,lr	
     ldr     r4,=CurrSprite	
     ldrh    r0,[r4,2h]	
     ldrh    r1,[r4,4h]	
     bl      CheckBlock    ;检查砖块	
     ldr     r5,=YTagRAM   ;类似零点的7F1	
     ldrb    r0,[r5]       	
     cmp     r0,11h	
     beq     @@OnFloor
	 ldrh    r0,[r4,2h]	
     ldrh    r1,[r4,4h]	
     sub     r1,30h        ;左边30h	
     bl      CheckBlock    ;检查砖块		
     ldrb    r0,[r5]       	
     cmp     r0,11h	
     beq     @@OnFloor
;---------------------------------------左边无砖的话	
     ldrh    r0,[r4,2h]    	
     ldrh    r1,[r4,4h]	
     add     r1,30h        ;检查右边的砖块	
     bl      CheckBlock	
     ldrb    r0,[r5]	
     cmp     r0,11h	
     bne     @@BottomNoBlock	
	
@@OnFloor:	
     ldr     r0,=SamusData  ;类似零点的13d4	
     ldrh    r0,[r0,14h]   ;读取samus的Y坐标 零点偏移14	
     sub     r0,48h        ;向上48h	
     ldr     r4,=CurrSprite	
     ldrh    r1,[r4,2h]    ;精灵的Y坐标	
     cmp     r0,r1         ;samus向上48的坐标大于精灵坐标则结束	
     bgt     @@end	
     mov     r0,0A0h	
     lsl     r0,r0,1h      ;140h	
     mov     r1,80h	
     lsl     r1,r1,1h      ;100h	
     bl      CheckRange    ;检查范围?samus附近的精灵	
     lsl     r0,r0,18h	
     cmp     r0,0h         ;一旦进入范围精灵上升准备	
     beq     @@end	
	
@@BottomNoBlock:	
;     bl      DirectionTag     ;写入方向
     ldr     r0,=SpriteRNG
	 ldrb    r0,[r0]
	 mov     r1,1h
	 and     r0,r1
	 cmp     r0,0h
	 beq     @@DirectionFlag
	 ldr     r1,=0fdffh
	 ldrh    r0,[r4]
	 and     r0,r1
	 b       @@WritePose
@@DirectionFlag:
     ldrh    r0,[r4]
     mov     r1,80h
     lsl     r1,r1,2h
     orr     r0,r1
@@WritePose:	 
	 strh    r0,[r4] 
     mov     r1,r4	
     add     r1,24h    ;pose写入3 上升准备	
     mov     r0,3h	
     strb    r0,[r1]		
@@end:	
     pop     r4,r5	
     pop     r0	
     bx      r0	
.pool
	
////////////////////////////////////////////////////////////	
;pose 3
AkumaPose3:	
     ldr     r1,=CurrSprite	
     mov     r0,0h	
     strb    r0,[r1,1Ch]	
     strh    r0,[r1,16h]	
     ldr     r0,=AkumaFishWillAkumaFishGoUpOAM   ;写入上升准备的OAM	
     str     r0,[r1,18h]	
     add     r1,24h	
     mov     r0,4h  	
     strb    r0,[r1]        ;pose写入4	
     bx      r14	
.pool
	
///////////////////////////////////////////////////////////	
;pose 4
AkumaPose4:	
     push    lr	
     bl      CheckAnimation  ;检查动画是否结束	
     cmp     r0,0h	
     beq     @@end	
     ldr     r0,=CurrSprite	
     add     r0,24h	
     mov     r1,5h    ;pose 写入5h	
     strb    r1,[r0]	
	
@@end:	
     pop     r0	
     bx      r0	
.pool
	
/////////////////////////////////////////////////////////////	
;pose 5
AkumaPose5:	
     push    r4,lr	
     ldr     r4,=CurrSprite	
     mov     r0,0h	
     strb    r0,[r4,1Ch]	
     mov     r2,0h	
     strh    r0,[r4,16h]	
     ldr     r0,=AkumaFishGoUpOAM  ;上升的OAM	
     str     r0,[r4,18h]	
     mov     r1,r4	
     add     r1,24h	
     mov     r0,6h	
     strb    r0,[r1]       ;pose写入6	
     mov     r0,r4	
     add     r0,2Ch        	
     strb    r2,[r0]       ;写入0	用于计数
;     bl 803F59Ch
	 ldr	 r2,=155h
     ldr     r0,=300006Ch   ;检查是否液体中
     ldrh    r0,[r0]
	 cmp     r0,0h
	 beq     @@PlaySound
     ldrh    r1,[r4,2h]
     cmp     r1,r0
     bcc     @@PlaySound
	 mov	 r2,94h
@@PlaySound:	 
     ldrh    r1,[r4]	
     mov     r0,2h	
     and     r0,r1	
     cmp     r0,0h         ;检查是否在屏幕内	
     beq     @@end	
     mov	 r0,r2 
     bl      PlaySound2 
@@end:	
     pop     r4	
     pop     r0	
     bx      r0	
.pool
	
///////////////////////////////////////////////////////////	
;pose 6
AkumaPose6:	
     push    r4-r6,lr	
     ldr     r4,=CurrSprite	
     ldrh    r0,[r4,2h]	
	 mov     r10,r0        ;把移动前的坐标备份
     sub     r0,30h	
     ldrh    r1,[r4,4h]	
     bl      CheckBlock	
     ldr     r5,=YTagRAM	
     ldrb    r0,[r5]	
     cmp     r0,11h	
     beq     @@TopHaveBlock	
	 ldrh    r0,[r4,2h]	
     sub     r0,30h	
     ldrh    r1,[r4,4h]	
     sub     r1,30h        ;精灵上30 左30检查砖块	
     bl      CheckBlock		
     ldrb    r0,[r5]	
     cmp     r0,11h	
     beq     @@TopHaveBlock	
     ldrh    r0,[r4,2h]	
     sub     r0,30h	
     ldrh    r1,[r4,4h]	
     add     r1,30h        ;精灵上30 有30检查砖块	
     bl      CheckBlock	
     ldrb    r0,[r5]	
     cmp     r0,11h	
     beq     @@TopHaveBlock	
	
;---------------------------------------顶部无砖	
     mov     r5,r4	
     add     r5,2Ch	
     ldrb    r2,[r5]       ;上升就从1开始增加	
     ldr     r1,=AkumaFishUpSpeed   ;应该是敌人的速度值	
     lsl     r0,r2,1h      ;乘以2	
     add     r0,r0,r1      ;加上偏移值	
     ldrh    r3,[r0]       ;读取上升速度值	
     mov     r6,0h	
     ldsh    r1,[r0,r6]    ;带负数的形式读取	
     ldr     r0,=7FFFh	
     cmp     r1,r0         ;检查是否到了尾端	
     bne     @@Continue	
	
@@TopHaveBlock:	
     mov     r1,r4	
     add     r1,24h	
     mov     r0,7h	
     strb    r0,[r1]	
     b       @@end	
	
@@Continue:	
     add     r0,r2,1       ;上升累计值加1	
     strb    r0,[r5]       ;再写入	
     ldrh    r0,[r4,2h]    ;读取Y坐标	
     add     r0,r0,r3      ;加上上升速度值	
     strh    r0,[r4,2h]    ;再写入	
	 mov     r1,r0
	 ldrh    r2,[r4,4h]
	 mov     r0,r10
	 mov     r3,2h
	 bl      UPOutWaterEffect 
	 cmp     r0,1h
	 beq @@CountCheck
;以下无用,....	 
	 ldrh    r1,[r4,2h]
	 ldrh    r2,[r4,4h]
	 mov     r0,r10
	 bl CheckOutOrInWater
     cmp     r0,0h
     beq @@end
	 ldrh    r0,[r4,2h]
	 ldrh    r1,[r4,4h]
     mov     r2,2h
     bl MakeWaterEffect	 
@@CountCheck:
     ldrh    r0,[r4]
     mov     r1,2h
	 and     r0,r1
	 cmp     r0,0h
	 beq @@end
	 mov     r0,75h
     bl      PlaySound2	
     	 
@@end:	
     pop     r4-r6	
     pop     r0	
     bx      r0	
.pool
	
/////////////////////////////////////////////////////////////	
;pose 7         下落准备
AkumaPose7:	
     push    lr	
     ldr     r1,=CurrSprite	
     mov     r0,0h	
     strb    r0,[r1,1Ch]	
     strh    r0,[r1,16h]	
     ldr     r0,=AkumaFishWillAkumaFishDownOAM ;下落准备OAM	
     str     r0,[r1,18h]	
     add     r1,24h	
     mov     r0,8h        ;pose写入8h	
     strb    r0,[r1]	
;     bl      803F57Ch      ;未知例程	
     pop     r0	
     bx      r0	
.pool
	
//////////////////////////////////////////////////////////	
;pose 8	
AkumaPose8:
     push    lr	
     bl      CheckAnimation      ;检查动画	
     cmp     r0,0h	
     beq     @@end	
     ldr     r0,=CurrSprite	
     add     r0,24h	
     mov     r1,9h	
     strb    r1,[r0]       ;pose写入2Fh  	
	
@@end:	
     pop     r0	
     bx      r0	
.pool
	
//////////////////////////////////////////////////////////	
;pose 9
AkumaPose9:	
     ldr     r0,=CurrSprite	
     mov     r1,0h	
     strb    r1,[r0,1Ch]	
     mov     r3,0h	
     strh    r1,[r0,16h]	
     ldr     r1,=AkumaFishDownOAM ;写入下落的OAM	
     str     r1,[r0,18h]	
     mov     r2,r0	
     add     r2,24h	
     mov     r1,0Ah       ;pose写入30h	
     strb    r1,[r2]	
     add     r0,2Eh       	
     mov     r1,0Dh
     strb    r1,[r0]	 
     bx      r14	
.pool
	
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////	
;pose A
AkumaPoseA:	
     push    r4-r6,lr
	 ldr     r4,=CurrSprite
	 ldr     r5,=XTagRAM
	 ldrh    r0,[r4,2h]	
	 mov     r10,r0
     ldrh    r1,[r4,4h]	
     bl      CheckBlock2    	 
     ldrb    r0,[r5]	
     cmp     r0,11h	
     bne     @@BottomMiddleNoBlock
     mov     r1,r4	
     add     r1,24h	
     mov     r0,1h        ;pose再次写回1	
     strb    r0,[r1]
	 add     r1,0Ah
	 mov     r0,0h
	 strb    r0,[r1]
     b       @@end
@@BottomMiddleNoBlock:	 
	 ldr     r6,=AkumaFishLevelMobileSpeed
	 ldr     r3,=SamusData
	 mov     r1,r4
	 add     r1,2Eh
	 ldrb    r0,[r1]
	 lsl     r0,r0,1h
	 add     r6,r6,r0
	 ldrh    r5,[r6]
	 mov     r0,0h
	 ldsh    r0,[r6,r0] 
	 ldr     r2,=7fffh   	 
	 cmp     r0,r2
	 beq     @@ChangeDirection
	 ldrh    r0,[r4]
	 mov     r1,80h
	 lsl     r1,r1,2h
	 and     r0,r1
	 cmp     r0,0h
	 beq     @@MoveLeft
;-----------------------------右移动
	 mov     r2,10h
     ldsh    r2,[r4,r2]         ;右部分界
     mov     r6,r5	 
     bl      AkumafishCheckSolid
	 cmp     r0,1h
     bhi     @@HaveBlock
     ldrh    r0,[r4,4h]
     add     r0,r5,r0
	 ldrh    r2,[r3,12h]
	 add     r2,r5,r2
     b       @@WriteNewLocation 
@@MoveLeft:
	 mov     r2,0Eh
     ldsh    r2,[r4,r2]         ;左部分界
     neg     r6,r5	 
     bl      AkumafishCheckSolid
	 cmp     r0,2h
     bcc     @@NoBlock
@@HaveBlock:
     mov     r1,r4
     add     r1,24h
     mov     r0,0Bh
     strb    r0,[r1]
     b       @@end
@@NoBlock:
     ldrh    r0,[r4,4h]
     sub     r0,r0,r5
	 ldrh    r2,[r3,12h]
	 sub     r2,r2,r5
@@WriteNewLocation:
     strh    r0,[r4,4h]
	 ldrh    r0,[r4,2h]	
     add     r0,2h       ;坐标向下再写入	
     strh    r0,[r4,2h]
	 mov     r1,r0
	 mov     r0,r10
	 ldrh    r2,[r4,4h]
	 ldrh    r3,[r4]
	 mov     r6,80h
	 lsl     r6,r6,2h
	 and     r6,r3
	 cmp     r6,0h
	 beq     @@LeftEffect
	 add     r2,60h
	 b       @@ShowEffect
@@LeftEffect:
     sub     r2,60h
@@ShowEffect:	 
	 mov     r3,3h
	 bl      DropInWaterEffect
	 cmp     r0,0h
	 beq     @@NoPlaySound
	 ldrh    r0,[r4]
	 mov     r1,2h
	 and     r0,r1
	 cmp     r0,0h
	 beq     @@NoPlaySound
	 mov     r0,75h
	 bl      PlaySound2
@@NoPlaySound:	 
     mov     r1,r4
	 add     r1,2Eh
	 ldrb    r0,[r1]
	 add     r0,1h
	 strb    r0,[r1]
	 b       @@end
@@ChangeDirection:
     mov     r0,0h
	 strb    r0,[r1]
	 ldrh    r0,[r4]
	 mov     r1,80h
	 lsl     r1,r1,2h
	 mov     r2,r1
	 and     r1,r0
	 cmp     r1,0h
	 beq     @@LeftFalg
	 ldr     r1,=0FDFFh
	 and     r0,r1
	 strh    r0,[r4]
	 b       @@end
@@LeftFalg:
     orr     r0,r2
     strh    r0,[r4]	   	      	 
@@end:	 
     pop     r4-r6	
     pop     r0	
     bx      r0	
.pool	

//////////////////////////////////////////////////////////

AkumaPoseB:
     push    r4-r6,lr
	 ldr     r4,=CurrSprite
	 ldr     r5,=XTagRAM
	 ldrh    r0,[r4,2h]	
	 mov     r10,r0
     ldrh    r1,[r4,4h]	
     bl      CheckBlock2 
     mov     r1,r0   	 
     ldrb    r0,[r5]	
     cmp     r0,11h	
     bne     @@BottomNoBlock1	
     mov     r2,r4	
     add     r2,24h	
     mov     r0,1h        ;pose再次写回1	
     b       @@Willend	
@@BottomNoBlock1:	 
     ldrh    r0,[r4,2h]	
     ldrh    r1,[r4,4h]	
     sub     r1,30h       ;检查左边(身下?)的砖块	
     bl      CheckBlock2
     mov     r1,r0	 
     ldrb    r0,[r5]	
     cmp     r0,11h	
     bne     @@BottomNoBlock2	
     mov     r2,r4	
     add     r2,24h	
     mov     r0,1h        ;pose再次写回1	
     b       @@Willend	 	
@@BottomNoBlock2:
	 ldr     r4,=CurrSprite	
     ldrh    r0,[r4,2h]	
     ldrh    r1,[r4,4h]	
     add     r1,30h       ;同样的炮制右边	
     bl      CheckBlock2
     mov     r1,r0	 
     ldrb    r0,[r5]	
     cmp     r0,11h	
     bne     @@BottomAllNoBlock	
     mov     r2,r4	
     add     r2,24h	
     mov     r0,1h	
     b       @@WillEnd		
@@BottomAllNoBlock:	
     ldrh    r0,[r4,2h]	
     add     r0,4h       ;坐标向下再写入	
     strh    r0,[r4,2h]	 
	 mov     r1,r0
	 mov     r0,r10
	 ldrh    r2,[r4,4h]
	 mov     r3,2h
	 bl      DropInWaterEffect  ;不知道为什么无效
	 cmp     r0,0h
	 beq     @@end
	 ldrh    r0,[r4]
	 mov     r1,2h
	 and     r0,r1
	 cmp     r0,0h
	 beq     @@end
	 mov     r0,75h
	 bl      PlaySound2
	 b       @@end
@@WillEnd:	
     strh    r1,[r4,2h]
     strb    r0,[r2]
@@end:
     pop     r4-r6
     pop     r0
     bx      r0
.pool	
	 
////////////////////////////////////////////////////////////////
CheckOutOrInWater:
     push    r0-r2,lr          ;返回0则代表身处无改变,1为液至空,2为空入液
	 sub     r0,2h             ;之前的Y坐标,防止检查身下减2
     mov     r1,r2
	 bl      CheckWaterOrAir    
	 mov     r10,r0            
	 pop     r0-r2
	 sub     r0,r1,2h          ;当前的Y坐标,防止检查身下减2
	 mov     r1,r2
	 bl      CheckWaterOrAir
	 mov     r2,r0             ;当前在空液固
	 mov     r1,r10            ;之前在空液固
	 cmp     r2,2h
	 beq     @@ReturnZero          ;当前在砖块的话
	 cmp     r1,2h
	 beq     @@ReturnZero
	 cmp     r2,r1
	 beq     @@ReturnZero
	 cmp     r2,1h             ;当前在液体中
	 beq     @@AirToWater
	 mov     r0,1h
	 b @@end
@@AirToWater:
     mov     r0,2h	 
	 b @@end
@@ReturnZero:
     mov     r0,0
@@end:
     pop r15     	 
.pool

CheckWaterOrAir:  ;因为游戏中的砖块检查怎么都无效不得已自己写
     push    r3              ;空气为0 液体为1 其余为2
     mov     r3,0Ch
	 ldsh    r3,[r4,r3]           ;下部分界
	 add     r0,r0,r3
     lsl     r0,r0,10h
     lsr     r0,r0,16h
     lsl     r1,r1,10h
     lsr     r1,r1,16h
     ldr     r3,=BGDataStart
     ldrh    r2,[r3,1Ch]          ;读取房间最大宽度格数
     mul     r2,r0                ;乘以当前高度格数
	 add     r2,r1                ;加上宽度格数
     lsl     r2,r2,1h             ;乘以二
     mov     r1,r3
	 add     r1,18h
     ldr     r1,[r1]              ;房间CLIP数据起始
     add     r1,r2
     ldrh    r0,[r1]	 
     cmp     r0,0h
     beq     @@end
	 cmp     r0,1Bh
	 beq     @@ReturnOne
	 cmp     r0,0A0h
	 beq     @@ReturnOne
	 cmp     r0,0A1h
	 beq     @@ReturnOne
	 cmp     r0,0A2h
	 beq     @@ReturnOne
	 mov     r0,2h
	 b       @@end
@@ReturnOne:    	 
     mov     r0,1h
@@end:	
     pop     r3 
	 bx      r14
.pool
	 
AkumafishCheckSolid:  ;因为游戏中的砖块检查怎么都无效不得已自己写
     push    r3              ;空气为0 液体为1 其余为2
     ldrh    r0,[r4,2h]
     ldrh    r1,[r4,4h]
     mov     r3,0Ch
	 ldsh    r3,[r4,r3]           ;下部分界
     add     r0,r0,r3
	 add     r0,2h                ;加上下落速度
	 add     r1,r1,r2             ;X坐标加上左右分界
	 add     r1,r1,r6             ;X坐标加上左右速度
     lsl     r0,r0,10h
     lsr     r0,r0,16h
     lsl     r1,r1,10h
     lsr     r1,r1,16h
     ldr     r3,=BGDataStart
     ldrh    r2,[r3,1Ch]          ;读取房间最大宽度格数
     mul     r2,r0                ;乘以当前高度格数
	 add     r2,r1                ;加上宽度格数
     lsl     r2,r2,1h             ;乘以二
     mov     r1,r3
	 add     r1,18h
     ldr     r1,[r1]              ;房间CLIP数据起始
     add     r1,r2
     ldrh    r0,[r1]	 
     cmp     r0,0h
     beq     @@end
	 cmp	 r0,7h
	 beq	 @@ReturnOne
	 cmp     r0,1Bh
	 beq     @@ReturnOne
	 cmp     r0,0A0h
	 beq     @@ReturnOne
	 cmp     r0,0A1h
	 beq     @@ReturnOne
	 cmp     r0,0A2h
	 beq     @@ReturnOne
	 mov     r0,2h
	 b       @@end
@@ReturnOne:    	 
     mov     r0,1h
@@end:	
     pop     r3 
	 bx      r14
.pool	 
//////////////////////////////////////////////////////////////////////////	

;主程序	
AkumaFishMain:
     push    r4,lr	
	 add     sp,-4h
     ldr     r4,=CurrSprite	
     mov     r0,r4	
	 add     r0,32h
	 ldrb    r2,[r0]          ;读取碰撞属性
	 mov     r1,2h
	 and     r1,r2
	 cmp     r1,0h
	 beq     @@NoHit
	 mov     r1,0FDh
	 and     r1,r2
	 strb    r1,[r0]
	 ldrb    r0,[r4]
	 mov     r1,2h
	 and     r1,r0
	 cmp     r1,0h
	 beq     @@NoHit
	 ldr     r0,=26Ah        ;挨打声
	 bl      PlaySound2
@@NoHit:
     mov     r0,r4	
     add     r0,30h            	
     ldrb    r0,[r0]           ;冰冻时间 零点是偏移30	
     cmp     r0,0h	
     beq     @@NoFrozening	
     bl      FrozenRoutine     ;冰冻例程	
     b       @Thend	
	
@@NoFrozening:	
     bl      StunSprite
	 cmp     r0,0h
	 beq     @@NoStun
	 b       @Thend
@@NoStun:	 
     mov     r0,r4	
     add     r0,24h	
     ldrb    r0,[r0]           ;读取pose	
     cmp     r0,0Bh	
     bls     @@NoDeath	
     b       @OverPose
	
@@NoDeath:	
     lsl     r0,r0,2h	
     ldr     r1,=PoseTable	
     add     r0,r0,r1	
     ldr     r0,[r0]	
     mov     r15,r0	
.pool
	
PoseTable:	
    .word @@FishPose0  ;00	
	.word @@FishPose1  ;01
	.word @@FishPose2  ;02
	.word @@FishPose3  ;03
	.word @@FishPose4
	.word @@FishPose5
	.word @@FishPose6
	.word @@FishPose7
	.word @@FishPose8
	.word @@FishPose9
	.word @@FishPoseA
    .word @@FishPoseB	
@@FishPose0:	
     bl AkumaPose0  ;pose 0	
     b       @Thend	
@@FishPose1:	 
     bl AkumaPose1  ;pose 1
@@FishPose2:	 
     bl AkumaPose2  ;pose 2 0-2然后在2循环为普通态	
     b       @Thend	
@@FishPose3:	 
     bl AkumaPose3  ;pose 3
@@FishPose4:	 
     bl AkumaPose4  ;pose 4	
     b       @Thend
@@FishPose5:	 
     bl AkumaPose5    ;pose 5
@@FishPose6:	 
     bl AkumaPose6    ;pose 6  为上升在6循环上升	
     b       @Thend
@@FishPose7:	 
     bl AkumaPose7  ;pose 7
@@FishPose8:	 
     bl AkumaPose8  ;pose 8为上升停止	
     b       @Thend
@@FishPose9:	 
     bl AkumaPose9  ;pose 9
@@FishPoseA:	 
     bl AkumaPoseA  ;pose A 下落并屙屎,落地返回1
     b       @Thend
@@FishPoseB:
     bl AkumaPoseB     ;直直下落
     b       @Thend	 
@OverPose:
     ldr     r0,=CurrSprite
     ldrh    r1,[r0,2h] 
     sub     r1,20h
     ldrh    r2,[r0,4h]
     mov     r0,20h
	 str     r0,[sp]
	 mov     r0,0h
	 mov     r3,1h
	 bl      DeathFireWorks          ;死亡烟花和掉落	 
@Thend:	
     add     sp,4h
     pop     r4	
     pop     r0	
     bx      r0	
.pool

;.align 2
AkumaFishUpSpeed:
    .halfword 0xffe0
	.halfword 0xffe2,0xffe2
    .halfword 0xffe4,0xffe4
	.halfword 0xffe6
	.halfword 0xffe8
    .halfword 0xffea
	.halfword 0xffec
	.halfword 0xffee
	.halfword 0xfff0,0xfff0
	.halfword 0xfff2,0xfff2
	.halfword 0xfff4,0xfff4
	.halfword 0xfff6,0xfff6
	.halfword 0xfff8,0xfff8
	.halfword 0xfffa,0xfffa
	.halfword 0xfffc,0xfffc
	.halfword 0xfffe,0xfffe
	.halfword 0x7fff
	
AkumaFishLevelMobileSpeed:
    .halfword 0x2
    .halfword 0x3
    .halfword 0x4
    .halfword 0x6
    .halfword 0x7
    .halfword 0x8
	.halfword 0x9
	.halfword 0xa
    .halfword 0xd
    .halfword 0xe
    .halfword 0xf
    .halfword 0x10
    .halfword 0x11
	.halfword 0x12
	.halfword 0x12
    .halfword 0x11	
	.halfword 0x10
    .halfword 0xf
	.halfword 0xe
    .halfword 0xd
	.halfword 0xa
    .halfword 0x9
	.halfword 0x8
    .halfword 0x7
	.halfword 0x6
	.halfword 0x4
    .halfword 0x3
	.halfword 0x2
    .halfword 0x7fff
	
.align	
AkumaFishNormalOAM:
    .word AkumaFishNormalOAM1
	.word 0xff
	.word 0,0
	
AkumaFishNormalOAM1:
    .halfword 0x2
	.halfword 40f8h,0000h,8220h
	.halfword 40f8h,11f0h,8220h

.align
AkumaFishWillAkumaFishGoUpOAM:
    .word AkumaFishWillAkumaFishGoUpOAM1
    .word 0x4
    .word AkumaFishWillAkumaFishGoUpOAM2
    .word 0x8
    .word 0,0
	
AkumaFishWillAkumaFishGoUpOAM1:
    .halfword 0x2
	.halfword 40f9h,0000h,8220h
	.halfword 40f9h,11f0h,8220h
	
AkumaFishWillAkumaFishGoUpOAM2:
    .halfword 0x2
    .halfword 00f4h,4000h,8204h
    .halfword 00f4h,51f0h,8204h
	
.align	
AkumaFishGoUpOAM:
    .word AkumaFishGoUpOAM1
	.word 0xff
    .word 0,0

AkumaFishGoUpOAM1:
    .halfword 0x1
    .halfword 00f4h,41f8h,8202h	
	
.align
AkumaFishWillAkumaFishDownOAM:
    .word AkumaFishWillAkumaFishGoUpOAM2      ;内容相同
    .word 0x6
    .word AkumaFishWillAkumaFishGoUpOAM1      ;内容相同
    .word 0x4
    .word AkumaFishNormalOAM1        ;内容相同
	.word 0x4
	.word AkumaFishWillAkumaFishDownOAM4
	.word 0x4
	.word 0,0
    
AkumaFishWillAkumaFishDownOAM4:
    .halfword 0x2
    .halfword 00f4h,4000h,8206h
	.halfword 00f4h,51f0h,8206h
	
.align    	
AkumaFishDownOAM:
    .word AkumaFishDownOAM1
	.word 0x9
	.word AkumaFishDownOAM2
	.word 0x9
	.word AkumaFishDownOAM3
	.word 0x9
	.word AkumaFishDownOAM2
	.word 0x9
	.word 0,0
.align	
AkumaFishDownOAM1:
    .halfword 0x2
	.halfword 00f4h,4000h,8208h
	.halfword 00f4h,51f0h,8208h

AkumaFishDownOAM2:
    .halfword 0x2
    .halfword 00f4h,4000h,820Ah
    .halfword 00f4h,51f0h,820ah

AkumaFishDownOAM3:
    .halfword 0x2	
	.halfword 00f4h,4000h,820Ch
	.halfword 00f4h,51f0h,820Ch    	

		
.pool
.close