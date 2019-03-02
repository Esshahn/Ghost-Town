!byte 0x02
                    !byte 0x07
                    !byte 0x04
                    asl 0x08
                    ora (0x05,x)
                    !byte 0x03
                    cpx #0x0c
                    bne 0x1755
                    lda #0x49
                    cpx #0x0d
                    bne 0x175b
                    lda #0x45
                    rts
                    bvs 0x179e
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    ror 0x205d
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0x20
                    ldy #0xa0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0xa0
                    ldy #0x20
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa020
                    ldy #0x20
                    eor 0xa05d,x
                    ldy #0xa0
                    ldy #0xa0
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    jsr 0xa0a0
                    ldy #0xa0
                    ldy #0xa0
                    jsr 0xa0a0
                    ldy #0xa0
                    jsr 0xa020
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0x5d
                    eor 0xa0a0,x
                    jsr 0x2020
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    jsr 0x2020
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0x5d
                    eor 0xa0a0,x
                    jsr 0x2020
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    jsr 0x2020
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0x5d
                    eor 0xa0a0,x
                    jsr 0x2020
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    jsr 0x2020
                    jsr 0xa0a0
                    jsr 0xa0a0
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0x5d
                    eor 0xa0a0,x
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0xa0
                    jsr 0xa0a0
                    ldy #0xa0
                    jsr 0xa020
                    ldy #0xa0
                    ldy #0xa0
                    jsr 0x2020
                    ldy #0xa0
                    ldy #0x5d
                    eor 0xa020,x
                    ldy #0xa0
                    ldy #0xa0
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0xa0
                    jsr 0xa020
                    ldy #0xa0
                    ldy #0x20
                    jsr 0x2020
                    ldy #0xa0
                    ldy #0x5d
                    eor 0x2020,x
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    jsr 0x2020
                    jsr 0xa020
                    ldy #0x20
                    jsr 0x2020
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa020
                    ldy #0xa0
                    eor 0x205d,x
                    jsr 0x2020
                    ldy #0xa0
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    ldy #0xa0
                    jsr 0x2020
                    jsr 0xa020
                    ldy #0x20
                    jsr 0x2020
                    ldy #0xa0
                    jsr 0xa0a0
                    ldy #0x20
                    jsr 0x2020
                    jsr 0x5d5d
                    jsr 0xa0a0
                    ldy #0xa0
                    ldy #0x20
                    ldy #0xa0
                    ldy #0xa0
                    ldy #0xa0
                    jsr 0xa0a0
                    jsr 0x2020
                    jsr 0xa020
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0x5d
                    eor 0xa0a0,x
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa020
                    ldy #0xa0
                    ldy #0x20
                    jsr 0xa0a0
                    jsr 0x2020
                    jsr 0xa020
                    ldy #0xa0
                    ldy #0xa0
                    jsr 0xa0a0
                    jsr 0xa020
                    ldy #0x20
                    jsr 0xa0a0
                    ldy #0x5d
                    !byte 0x6b
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    !byte 0x73
                    eor 0x2020,x
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    eor 0x205d,x
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x5d5d
                    eor 0x0f59,x
                    ora 0x20,x
                    asl
                    ora 0x13,x
                    !byte 0x14
                    jsr 0x0108
                    asl 0x05,x
                    jsr 0x0f13
                    !byte 0x0c
                    asl 0x05,x
                    !byte 0x04
                    jsr 0x0814
                    ora 0x20
                    ora 0x1319
                    !byte 0x14
                    ora 0x12
                    ora 0x0f20,y
                    asl 0x20
                    eor 0x5d5d,x
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    eor 0x475d,x
                    php
                    !byte 0x0f
                    !byte 0x13
                    !byte 0x14
                    jsr 0x0f54
                    !byte 0x17
                    asl 0x202c
                    !byte 0x0b
                    ora #0x0c
                    !byte 0x0c
                    ora 0x04
                    jsr 0x0542
                    !byte 0x0c
                    ora 0x07
                    !byte 0x12
                    !byte 0x0f
                    bit 0x0120
                    asl 0x2004
                    asl 0x0f
                    ora 0x0e,x
                    !byte 0x04
                    jsr 0x5d5d
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    jsr 0x5d20
                    eor 0x0814,x
                    ora 0x20
                    bpl 0x1a6d
                    ora 0x03
                    ora #0x0f
                    ora 0x13,x
                    jsr 0x1214
                    ora 0x01
                    !byte 0x13
                    ora 0x12,x
                    ora 0x20
                    and (0x20,x)
                    and (0x20,x)
                    and (0x20,x)
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x5d5d
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    jsr 0x2020
                    eor 0x406b,x
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    !byte 0x73
                    eor 0x494b,x
                    lsr 0x5347
                    !byte 0x4f
                    lsr 0x54
                    jsr 0x0f03
                    asl 0x1207
                    ora (0x14,x)
                    ora 0x0c,x
                    ora (0x14,x)
                    ora 0x13
                    jsr 0x503e
                    !byte 0x0c
                    ora (0x19,x)
                    jsr 0x1409
                    jsr 0x0701
                    ora (0x09,x)
                    asl 0x5d3e
                    eor 0x6363,x
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    !byte 0x63
                    eor 0x406d,x
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
                    rti
