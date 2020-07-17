
;球能力总是激活,球能力槽可以给别的新能力
.org    0x8008A64
    ldrb    r1,[r0,12h] ; morph on ground
    mov        r0,2h
    and        r0,r1
    cmp        r0,2h
.org    0x8008D10        ;morph in air
    ldrb    r1,[r0,12h]
    mov        r0,2h
    and        r0,r1
    cmp        r0,2h
.org    0x800968A        ;morph from hanging
    ldrb    r1,[r0,12h]
    mov        r0,2h
    and        r0,r1
    cmp        r0,2h