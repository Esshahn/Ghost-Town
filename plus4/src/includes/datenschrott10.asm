!byte $60 ,$ff ,$c9 ,$df ,$f0 ,$02 ,$e6 ,$0a ,$b1 ,$a7 ,$4c ,$b7 ,$38 ,$06 ,$03 ,$12
!byte $21 ,$03 ,$03 ,$12 ,$21 ,$03 ,$03 ,$15 ,$21 ,$03 ,$03 ,$0f ,$21 ,$15 ,$1e ,$06
!byte $06 ,$06 ,$03 ,$12 ,$21 ,$03 ,$03 ,$09 ,$21 ,$03 ,$03 ,$12 ,$21 ,$03 ,$03 ,$0c
!byte $21 ,$03 ,$03 ,$12 ,$21 ,$0c ,$03 ,$0c ,$20 ,$0c ,$03 ,$0c ,$21 ,$0c ,$03 ,$09
!byte $15 ,$03 ,$03 ,$06 ,$21 ,$03 ,$03 ,$03 ,$21 ,$06 ,$03 ,$12 ,$21 ,$03 ,$03 ,$03
!byte $1d ,$03 ,$03 ,$06 ,$21 ,$03 ,$03

; above bytes as code
!if 1=2{
                    rts
                    !byte 0xff
                    cmp #0xdf
                    beq 0x39a5
                    inc 0x0a
                    lda (0xa7),y
                    jmp 0x38b7
                    asl 0x03
                    !byte 0x12
                    and (0x03,x)
                    !byte 0x03
                    !byte 0x12
                    and (0x03,x)
                    !byte 0x03
                    ora 0x21,x
                    !byte 0x03
                    !byte 0x03
                    !byte 0x0f
                    and (0x15,x)
                    asl 0x0606,x
                    asl 0x03
                    !byte 0x12
                    and (0x03,x)
                    !byte 0x03
                    ora #0x21
                    !byte 0x03
                    !byte 0x03
                    !byte 0x12
                    and (0x03,x)
                    !byte 0x03
                    !byte 0x0c
                    and (0x03,x)
                    !byte 0x03
                    !byte 0x12
                    and (0x0c,x)
                    !byte 0x03
                    !byte 0x0c
                    jsr 0x030c
                    !byte 0x0c
                    and (0x0c,x)
                    !byte 0x03
                    ora #0x15
                    !byte 0x03
                    !byte 0x03
                    asl 0x21
                    !byte 0x03
                    !byte 0x03
                    !byte 0x03
                    and (0x06,x)
                    !byte 0x03
                    !byte 0x12
                    and (0x03,x)
                    !byte 0x03
                    !byte 0x03
                    ora 0x0303,x
                    asl 0x21
                    !byte 0x03
                    !byte 0x03
}