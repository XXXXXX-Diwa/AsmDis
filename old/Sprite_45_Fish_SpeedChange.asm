.gba
.open "zm.gba","Fishspeed.gba",0x8000000

.definelabel Frozen,800FFE8h              ;普通冰冻例程
.definelabel PlaySound,8002B20h           ;第二播音例程
.definelabel StunSprite,8011280h          ;精灵受创行止例程    
.definelabel DeathFireworks,8011084h      ;精灵死亡例程
.definelabel PriSpriteDateStart,82B0D68h  ;主精灵基础数据偏移起始
.definelabel CheckClip,800F688h           ;RAM7F1砖块检查例程
.definelabel CheckSpriteScope,800FDE0h    ;检查精灵与人物的位置
.definelabel CheckAnimation,800FBC8h      ;检查动画帧例程
.definelabel DeathCheck,80108B0h          ;检查是否有掉落例程(副用途)
.definelabel CheckDrop,8010EECh           ;检查掉落ID
.definelabel RNGdirection,800F80Ch        ;随机方向设定

.org 8048d96h    ;pose 8给pose 9左右移动的延迟 left or right mov delay
    .byte 1h
	
.org 8048e0ah    ;pose 9 继续左右移动的延迟    left or right mov delay
    .byte 1h

.org 8048f3ch    ;pose 35 控制左右移动的延迟   left or right mov delay
    .byte 1h	
	
.org 8048f1ch    ;pose 35 左右移动速度         left or right speed 
    .byte 8h    

.org 8048dbch    ;pose 9 左右移动速度          left or right speed 
    .byte 4h

.org 8048ed4h    ;pose 35 上移动速度           up speed
    .byte 4h	
	
.org 8048f06h    ;pose 35 下移动速度           down speed
    .byte 4h

	
.org 8048f4eh    ;控制鱼触发追击的范围        trigger distance
    mov r1,80h
    lsl r1,3h
    mov r0,0xff	
	
.org 8048ecah                   ;fish can up mov at all
    b 8048ed2h	
	
.pool
.close	
	
                        