                    jsr 0x2041
                    bpl 0x3f0e
                    !byte 0x12
                    !byte 0x14
                    jsr 0x060f
                    jsr 0x0814
                    ora 0x20
                    !byte 0x03
                    !byte 0x0f
                    !byte 0x04
                    ora 0x20
                    asl 0x0d15
                    !byte 0x02
                    ora 0x12
                    jsr 0x1309
                    jsr 0x203a
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    eor (0x42,x)
                    !byte 0x43
                    !byte 0x44
                    eor 0x46
                    !byte 0x47
                    pha
                    eor #0x4a
                    !byte 0x4b
                    jmp 0x4e4d
                    !byte 0x4f
                    !byte 0x50
                    eor (0x52),y
                    !byte 0x53
                    !byte 0x54
                    eor 0x56,x
                    !byte 0x57
                    cli
                    eor 0x205a,y
                    bmi 0x3f7f
                    !byte 0x32
                    !byte 0x33
                    !byte 0x34
                    and 0x36,x
                    !byte 0x37
                    sec
                    and 0x20bc,y
                    jsr 0x0f59
                    ora 0x20,x
                    asl 0x0505
                    !byte 0x04
                    !byte 0x3a
                    jsr 0x1502
                    !byte 0x0c
                    !byte 0x02
                    bit 0x0220
                    ora 0x0c,x
                    !byte 0x02
                    jsr 0x0f08
                    !byte 0x0c
                    !byte 0x04
                    ora 0x12
                    bit 0x1320
                    !byte 0x0f
                    !byte 0x03
                    !byte 0x0b
                    ora 0x14
                    jsr 0x2021
                    jsr 0x5420
                    ora 0x0c
                    !byte 0x0c
                    jsr 0x050d
                    jsr 0x0814
                    ora 0x20
                    !byte 0x03
                    !byte 0x0f
                    !byte 0x04
                    ora 0x20
                    asl 0x0d15
                    !byte 0x02
                    ora 0x12
                    jsr 0x203f
                    jsr 0x2020
                    jsr 0x2022
                    jsr 0x2020
                    jsr 0x2022
                    jsr 0x2a20
                    rol
                    rol
                    rol
                    rol
                    jsr 0x2020
                    eor (0x20,x)
                    php
                    ora 0x0c
                    bpl 0x3fc1
                    asl 0x2007
                    !byte 0x0c
                    ora 0x14
                    !byte 0x14
                    ora 0x12
                    jsr 0x203a
                    jsr 0x4320
                    jsr 0x2020
                    rol
                    rol
                    rol
                    rol
                    rol
                    jsr 0x5320
                    !byte 0x0f
                    !byte 0x12
                    !byte 0x12
                    ora 0x202c,y
                    !byte 0x02
                    ora (0x04,x)
                    jsr 0x0f03
                    !byte 0x04
                    ora 0x20
                    asl 0x0d15
                    !byte 0x02
                    ora 0x12
                    and (0x20,x)
                    !byte 0x42
                    ora 0x14
                    !byte 0x14
                    ora 0x12
                    jsr 0x150c
                    !byte 0x03
                    !byte 0x0b
                    jsr 0x050e
                    clc
                    !byte 0x14
                    jsr 0x0914
                    ora 0x2105
                    !byte 0x20
                    ;jsr 0x0000
