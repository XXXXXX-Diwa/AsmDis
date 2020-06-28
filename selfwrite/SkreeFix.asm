.gba
.open "zm.gba","skreefix.gba",0x8000000
;修改吊虫的一些参数
.org 801c8b4h  ;吊虫的爆炸时间增加地址,如果达到3c就会爆炸
    add r0,1h
.org 801c830h
    add r0,2h  ;吊虫落下初始速度

.org 801c844h  ;判定人在吊虫右边垂直速度
    add r0,40h
	
.org 801c848h
    add r0,20h ;判定人在吊虫右边的水平速度
	
.org 801c866h  ;同上但是左边
    add r0,40h

.org 801c868h
    sub r0,20h	
.pool
.close