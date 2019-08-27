datenschrott07

!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
!byte $00, $df, $0c, $15, $1e, $27, $30, $39, $42, $4b, $54, $5d, $66, $6f, $78, $81
!byte $8a, $03, $00, $39, $19, $0e, $3d, $7f, $2a, $2a, $1e, $1e, $1e, $3d, $3d, $19
!byte $2f, $2f, $39


!if 1=2{
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0x00
                    !byte 0xdf
                    !byte 0x0c
                    ora 0x1e,x
                    !byte 0x27
                    bmi 0x305e
                    !byte 0x42
                    !byte 0x4b
                    !byte 0x54
                    eor 0x6f66,x
                    sei
                    sta (0x8a,x)
                    !byte 0x03
                    !byte 0x00
                    and 0x0e19,y
                    and 0x2a7f,x
                    rol
                    asl 0x1e1e,x
                    and 0x193d,x
                    !byte 0x2f
                    !byte 0x2f
                    !byte 0x39
                    ;and 0x20ea,y
                    ;sbc 0x2f,x
}
datenschrott07_ende