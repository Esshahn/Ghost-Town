datenschrott05
; not sure what this does yet

; converted to bytes 

!if 1=1{
!byte $07, $76, $a9, $06, $59, $7f, $c5, $04, $3b, $54, $83, $ad, $c0, $e3, $02, $1e
!byte $2a, $42, $56, $60, $71, $81, $8f, $95, $00, $00, $00, $01, $01, $01, $01, $02
!byte $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
!byte $03, $03, $03, $03
}

; old conversion, might be deleted

!if 1=2{
                    !byte 0x07
                    ror 0xa9,x
                    asl 0x59
                    !byte 0x7f
                    cmp 0x04
                    !byte 0x3b
                    !byte 0x54
                    !byte 0x83
                    lda 0xe3c0
                    !byte 0x02
                    asl 0x422a,x
                    lsr 0x60,x
                    adc (0x81),y
                    !byte 0x8f
                    sta 0x00,x
                    !byte 0x00
                    !byte 0x00
                    ora (0x01,x)
                    ora (0x01,x)
                    !byte 0x02
                    !byte 0x02
                    !byte 0x02
                    !byte 0x02
                    !byte 0x02
                    !byte 0x02
                    !byte 0x02
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
}
datenschrott05_ende