.gba
.open "MF.gba","faster door.gba",0x8000000

;Faster door transitions in fusion
.org 0x806EBB2 
        add r0,r1,2h

.org 0x806EBC4 
        sub r0,r1,2h

.org 0x806EBE6
        add r0,0Ch

.org 0x806EC04 
        sub r0,0Ch

.close
