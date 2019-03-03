
                    bcs 0x0fa6
                    ror 0x9eed,x
                    !byte 0x02
                    !byte 0x53
                    lsr 0x11,x
                    asl 0x0beb
                    and 0x89
                    rol 0x18,x
                    ora 0x35d1
                    !byte 0x53
                    and 0x98
                    inc 0x265b
                    adc 0x45,x
                    sec
                    beq 0x0fd1
                    asl 0x45
                    rol 0x74
                    eor 0x86
                    !byte 0x34
                    !byte 0xda
                    !byte 0x23
                    and 0x7426,x
                    !byte 0x3b
                    !byte 0xb2
                    stx 0x34
                    !byte 0x92
                    !byte 0x43

; ==============================================================================
                    ; *= 0x0FC0
m0FC0:                                  ; this is all probably leftover from
                                        ; "original" exomized package
                    sei
                    ldy #0x00
                    sty zp03
                    ldx #0x2f
                    lda #0x3f
                    sta zp04
                    lda (zp03),y
                    eor 0x0f90,x
                    sta (zp03),y
                    iny
                    bne 0x0fcb
                    dec zp04
                    dex
                    bpl 0x0fcb
                    sei
                    jsr 0xff8a
                    jsr 0x8117
                    lda #0xfb
                    sta 0x0327
                    lda #0xb4
                    sta 0x0326
                    sta 0x0508
                    jsr 0xe3b0
                    jsr 0xe378
                    cli
                    lda #0x11
                    sta 0xff13
                    jsr 0xe378
                    jmp 0x3ab3
