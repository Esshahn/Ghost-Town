
!byte $60 ,$60 ,$f4 ,$84 ,$45 ,$43 ,$44 ,$25 ,$26 ,$25 ,$26 ,$27 ,$24 ,$4b ,$2c ,$2d
!byte $2c ,$2d ,$2e ,$2b ,$44 ,$25 ,$26 ,$25 ,$26 ,$27 ,$24 ,$46 ,$64 ,$66 ,$47 ,$67
!byte $67 ,$46 ,$64 ,$66 ,$47 ,$67 ,$67 ,$27 ,$29 ,$27 ,$49 ,$67 ,$44 ,$66 ,$64 ,$27
!byte $29 ,$27 ,$49 ,$67 ,$44 ,$66 ,$64 ,$32 ,$35 ,$32 ,$50 ,$6e ,$2f ,$30 ,$31 ,$30
!byte $31 ,$32 ,$31 ,$2f ,$2f ,$4f ,$50 ,$4f ,$2e ,$2f ,$30 ,$31 ,$30 ,$31 ,$32 ,$31
!byte $2f ,$4f ,$6d ,$6b ,$4e ,$6c ,$6a ,$4f ,$6d ,$6b ,$4e ,$6c ,$6a ,$92 ,$31 ,$33
!byte $31 ,$31 ,$52 ,$33 ,$34 ,$33 ,$34 ,$35 ,$32 ,$54 ,$32 ,$52 ,$75 ,$54 ,$32 ,$52
!byte $75 ,$8d ,$8d ,$2c ,$2d ,$ce ,$8d ,$8d ,$2c ,$2d ,$ce ,$75 ,$34 ,$32 ,$30 ,$2e
!byte $2d ,$2f ,$30 ,$31 ,$30 ,$31 ,$32 ,$31 ,$32 ,$35 ,$32 ,$35 ,$32 ,$35 ,$32 ,$2e
!byte $2d ,$2f ,$30 ,$31 ,$30 ,$31 ,$32 ,$31 ,$32 ,$4b ,$69 ,$67 ,$4c ,$6a ,$68 ,$4b
!byte $69 ,$67 ,$4c ,$6a ,$68 ,$32 ,$33 ,$32 ,$b2 ,$33 ,$31 ,$32 ,$33 ,$34 ,$35 ,$36
!byte $35 ,$33 ,$32 ,$31 ,$31 ,$32 ,$33 ,$34 ,$33 ,$34 ,$35 ,$36 ,$35 ,$36 ,$37 ,$36
!byte $ea

; data from above or garbage
!if 1=2{
                    rts
                    rts
                    !byte 0xf4
                    sty 0x45
                    !byte 0x43
                    !byte 0x44
                    and 0x26
                    and 0x26
                    !byte 0x27
                    bit 0x4b
                    bit 0x2c2d
                    and 0x2b2e
                    !byte 0x44
                    and 0x26
                    and 0x26
                    !byte 0x27
                    bit 0x46
                    !byte 0x64
                    ror 0x47
                    !byte 0x67
                    !byte 0x67
                    lsr 0x64
                    ror 0x47
                    !byte 0x67
                    !byte 0x67
                    !byte 0x27
                    and #0x27
                    eor #0x67
                    !byte 0x44
                    ror 0x64
                    !byte 0x27
                    and #0x27
                    eor #0x67
                    !byte 0x44
                    ror 0x64
                    !byte 0x32
                    and 0x32,x
                    !byte 0x50
                    ror 0x302f
                    and (0x30),y
                    and (0x32),y
                    and (0x2f),y
                    !byte 0x2f
                    !byte 0x4f
                    !byte 0x50
                    !byte 0x4f
                    rol 0x302f
                    and (0x30),y
                    and (0x32),y
                    and (0x2f),y
                    !byte 0x4f
                    adc 0x4e6b
                    jmp (0x4f6a)
                    adc 0x4e6b
                    jmp (0x926a)
                    and (0x33),y
                    and (0x31),y
                    !byte 0x52
                    !byte 0x33
                    !byte 0x34
                    !byte 0x33
                    !byte 0x34
                    and 0x32,x
                    !byte 0x54
                    !byte 0x32
                    !byte 0x52
                    adc 0x54,x
                    !byte 0x32
                    !byte 0x52
                    adc 0x8d,x
                    sta 0x2d2c
                    dec 0x8d8d
                    bit 0xce2d
                    adc 0x34,x
                    !byte 0x32
                    bmi 0x1dbf
                    and 0x302f
                    and (0x30),y
                    and (0x32),y
                    and (0x32),y
                    and 0x32,x
                    and 0x32,x
                    and 0x32,x
                    rol 0x2f2d
                    bmi 0x1dd6
                    bmi 0x1dd8
                    !byte 0x32
                    and (0x32),y
                    !byte 0x4b
                    adc #0x67
                    jmp 0x686a
                    !byte 0x4b
                    adc #0x67
                    jmp 0x686a
                    !byte 0x32
                    !byte 0x33
                    !byte 0x32
                    !byte 0xb2
                    !byte 0x33
                    and (0x32),y
                    !byte 0x33
                    !byte 0x34
                    and 0x36,x
                    and 0x33,x
                    !byte 0x32
                    and (0x31),y
                    !byte 0x32
                    !byte 0x33
                    !byte 0x34
                    !byte 0x33
                    !byte 0x34
                    and 0x36,x
                    and 0x36,x
                    !byte 0x37
                    rol 0xea,x
}