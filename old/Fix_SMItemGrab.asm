.gba
.open "zm.gba","Fix_SMItemGrab.gba",0x8000000
;fix SM_ItemGrab.asm use shinespark to get the ability cause voice errors and No play get_ability music
;In addition, the text will have two boxes
.org 801b86ah  ;判断能力和道具的例程一律判断为道具
    b 801b89ch
.org 801b89eh  ;判断第一次吃道具一律为第二次
    b 801b8bch
;If you want play get_ability's music, remove the following code's ";" ,
;but will cause room music to temporarily stop until to other room
;.org 801b8ech   
    ;mov r0,37h
.pool
.close