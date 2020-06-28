.gba
.open "zm.gba","TankQuantities.gba",0x8000000
;uncomment all that you want to change and change the .byte 0xXX
.org 0x83459C4  ;Easy Etank
        ;.byte 0x64
.org 0x83459C5  ;Easy Missiles
        ;.byte 0x05
.org 0x83459C6  ;Easy Super Missiles
        ;.byte 0x02
.org 0x83459C7  ;East Power Bombs
        ;.byte 0x02
.org 0x83459C8  ;Normal Etank
        ;.byte 0x64
.org 0x83459C9  ;Normal Missiles
        ;.byte 0x05
.org 0x83459CA  ;Normal Super Missiles
        ;.byte 0x02
.org 0x83459CB  ;Normal Power Bombs
        ;.byte 0x02
.org 0x83459CC  ;Hard Etank
        ;.byte 0x32
.org 0x83459CD  ;Hard Missiles
        ;.byte 0x02
.org 0x83459CE  ;Hard Super Missiles
        ;.byte 0x01
.org 0x83459CF  ;Hard Power Bombs
        ;.byte 0x01
.close