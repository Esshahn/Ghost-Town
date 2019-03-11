; Hier werden vermutlich die Items platziert
; wenn man es auskommentiert, dann fehlen diese

item_placement: 

!byte $ff ,$00 ,$fe ,$fd ,$29 ,$fb ,$79 ,$fa ,$a9 ,$ff ,$01 ,$fd ,$bf ,$fb ,$49 ,$fa
!byte $e0 ,$f9 ,$fc ,$fe ,$fd ,$f6 ,$fb ,$3d ,$fa ,$ac ,$f9 ,$fc ,$fe ,$fd ,$1e ,$fc
!byte $f9 ,$fc ,$ff ,$02 ,$fb ,$5f ,$fd ,$b3 ,$fa ,$b8 ,$f9 ,$fc ,$fd ,$db ,$fc ,$f9
!byte $fc ,$fd ,$d3 ,$fe ,$fe ,$fb ,$49 ,$fa ,$a5 ,$f9 ,$f8 ,$f9 ,$f8 ,$f9 ,$fc ,$f9
!byte $fa ,$a8 ,$fd ,$ff ,$fa ,$a7 ,$fe ,$fd ,$27 ,$f8 ,$fd ,$24 ,$fa ,$b0 ,$f9 ,$fc
!byte $fd ,$4c ,$fc ,$f9 ,$fc ,$fd ,$74 ,$fa ,$b5 ,$fc ,$f9 ,$fc ,$fd ,$27 ,$fa ,$a7
!byte $fd ,$4f ,$f8 ,$fd ,$77 ,$f8 ,$fd ,$9f ,$f8 ,$ff ,$90 ,$ff ,$07 ,$fe ,$fe ,$fd
!byte $d1 ,$fb ,$00 ,$fa ,$5e ,$f9 ,$fc ,$fd ,$f9 ,$fc ,$f9 ,$fc ,$ff ,$08 ,$fe ,$fd
!byte $33 ,$fb ,$4c ,$fa ,$c6 ,$f9 ,$fc ,$f9 ,$fc ,$fd ,$5b ,$fc ,$f9 ,$fc ,$f9 ,$fc
!byte $fe ,$fd ,$ac ,$fb ,$3f ,$fa ,$c0 ,$f9 ,$fc ,$fd ,$d4 ,$fc ,$f9 ,$fc ,$fd ,$fc
!byte $fc ,$f9 ,$fc ,$ff ,$0a ,$fe ,$fe ,$fd ,$9c ,$fb ,$29 ,$fa ,$cc ,$f9 ,$fc ,$fd
!byte $c4 ,$fc ,$f9 ,$fc ,$ff ,$0b ,$fd ,$94 ,$fb ,$39 ,$fa ,$d0 ,$fd ,$bc ,$fc ,$ff
!byte $0c ,$fe ,$fe ,$fd ,$15 ,$fb ,$39 ,$fa ,$d2 ,$f9 ,$fc ,$fd ,$3d ,$fc ,$f9 ,$fc
!byte $ff ,$0d ,$fb ,$ff ,$fa ,$d6 ,$fd ,$ae ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$11 ,$f8 ,$fd
!byte $65 ,$f8 ,$fd ,$40 ,$f8 ,$fd ,$69 ,$f8 ,$fe ,$fd ,$44 ,$f8 ,$fd ,$98 ,$f8 ,$fd
!byte $f4 ,$f8 ,$fd ,$7e ,$f8 ,$fd ,$51 ,$f8 ,$fd ,$0c ,$f8 ,$fd ,$83 ,$f8 ,$fe ,$fd
!byte $0f ,$f8 ,$fd ,$86 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$f8 ,$f8 ,$fd ,$b4 ,$f8 ,$fd ,$15
!byte $f8 ,$fd ,$40 ,$f8 ,$fd ,$25 ,$f8 ,$fd ,$9b ,$f8 ,$fe ,$fd ,$71 ,$f8 ,$fd ,$4d
!byte $f8 ,$fd ,$79 ,$f8 ,$fd ,$a6 ,$f8 ,$ff ,$0e ,$fd ,$f6 ,$fb ,$00 ,$fa ,$d7 ,$f8
!byte $fd ,$82 ,$f8 ,$fe ,$fd ,$5f ,$f8 ,$fd ,$84 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$e6 ,$f8
!byte $fd ,$71 ,$f8 ,$fd ,$73 ,$f8 ,$fd ,$1f ,$f8 ,$fd ,$1c ,$f8 ,$fe ,$fd ,$24 ,$f8
!byte $fd ,$27 ,$f8 ,$fd ,$50 ,$f8 ,$fd ,$48 ,$f8 ,$fd ,$c4 ,$f8 ,$fd ,$c0 ,$f8 ,$fd
!byte $94 ,$f8 ,$fd ,$e0 ,$f8 ,$fd ,$64 ,$f8 ,$fd ,$3f ,$f8 ,$fd ,$13 ,$f8 ,$fe ,$fd
!byte $15 ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$04 ,$f8 ,$ff ,$10 ,$fd ,$63 ,$fb ,$5f ,$fa ,$b8
!byte $f9 ,$fc ,$fd ,$8b ,$fc ,$f8 ,$f9 ,$fc ,$fe ,$fe ,$fb ,$39 ,$fd ,$fb ,$fa ,$f4
!byte $fd ,$f2 ,$fb ,$39 ,$fa ,$d9 ,$f9 ,$fc ,$fd ,$1a ,$fe ,$fc ,$f9 ,$fc ,$ff ,$11
!byte $fe ,$fe ,$fd ,$c3 ,$fb ,$39 ,$fa ,$dd ,$fd ,$eb ,$fc ,$ff ,$ff ,$ff ,$ff ,$ff

!if 1=2{
                    !byte 0xff
                    !byte 0x00
                    inc 0x29fd,x
                    !byte 0xfb
                    adc 0xa9fa,y
                    !byte 0xff
                    ora (0xfd,x)
                    !byte 0xbf
                    !byte 0xfb
                    eor #0xfa
                    cpx #0xf9
                    !byte 0xfc
                    inc 0xf6fd,x
                    !byte 0xfb
                    and 0xacfa,x
                    sbc 0xfefc,y
                    sbc 0xfc1e,x
                    sbc 0xfffc,y
                    !byte 0x02
                    !byte 0xfb
                    !byte 0x5f
                    sbc 0xfab3,x
                    clv
                    sbc 0xfdfc,y
                    !byte 0xdb
                    !byte 0xfc
                    sbc 0xfdfc,y
                    !byte 0xd3
                    inc 0xfbfe,x
                    eor #0xfa
                    lda 0xf9
                    sed
                    sbc 0xf9f8,y
                    !byte 0xfc
                    sbc 0xa8fa,y
                    sbc 0xfaff,x
                    !byte 0xa7
                    inc 0x27fd,x
                    sed
                    sbc 0xfa24,x
                    bcs 0x36d2
                    !byte 0xfc
                    sbc 0xfc4c,x
                    sbc 0xfdfc,y
                    !byte 0x74
                    !byte 0xfa
                    lda 0xfc,x
                    sbc 0xfdfc,y
                    !byte 0x27
                    !byte 0xfa
                    !byte 0xa7
                    sbc 0xf84f,x
                    sbc 0xf877,x
                    sbc 0xf89f,x
                    !byte 0xff
                    bcc 0x36f5
                    !byte 0x07
                    inc 0xfdfe,x
                    cmp (0xfb),y
                    !byte 0x00
                    !byte 0xfa
                    lsr 0xfcf9,x
                    sbc 0xfcf9,x
                    sbc 0xfffc,y
                    php
                    inc 0x33fd,x
                    !byte 0xfb
                    jmp 0xc6fa
                    sbc 0xf9fc,y
                    !byte 0xfc
                    sbc 0xfc5b,x
                    sbc 0xf9fc,y
                    !byte 0xfc
                    inc 0xacfd,x
                    !byte 0xfb
                    !byte 0x3f
                    !byte 0xfa
                    cpy #0xf9
                    !byte 0xfc
                    sbc 0xfcd4,x
                    sbc 0xfdfc,y
                    !byte 0xfc
                    !byte 0xfc
                    sbc 0xfffc,y
                    asl
                    inc 0xfdfe,x
                    !byte 0x9c
                    !byte 0xfb
                    and #0xfa
                    cpy 0xfcf9
                    sbc 0xfcc4,x
                    sbc 0xfffc,y
                    !byte 0x0b
                    sbc 0xfb94,x
                    and 0xd0fa,y
                    sbc 0xfcbc,x
                    !byte 0xff
                    !byte 0x0c
                    inc 0xfdfe,x
                    ora 0xfb,x
                    and 0xd2fa,y
                    sbc 0xfdfc,y
                    and 0xf9fc,x
                    !byte 0xfc
                    !byte 0xff
                    ora 0xfffb
                    !byte 0xfa
                    dec 0xfd,x
                    ldx 0xfdf8
                    !byte 0x34
                    sed
                    sbc 0xf811,x
                    sbc 0xf865,x
                    sbc 0xf840,x
                    sbc 0xf869,x
                    inc 0x44fd,x
                    sed
                    sbc 0xf898,x
                    sbc 0xf8f4,x
                    sbc 0xf87e,x
                    sbc 0xf851,x
                    sbc 0xf80c,x
                    sbc 0xf883,x
                    inc 0x0ffd,x
                    sed
                    sbc 0xf886,x
                    sbc 0xf882,x
                    sbc 0xf8f8,x
                    sbc 0xf8b4,x
                    sbc 0xf815,x
                    sbc 0xf840,x
                    sbc 0xf825,x
                    sbc 0xf89b,x
                    inc 0x71fd,x
                    sed
                    sbc 0xf84d,x
                    sbc 0xf879,x
                    sbc 0xf8a6,x
                    !byte 0xff
                    asl 0xf6fd
                    !byte 0xfb
                    !byte 0x00
                    !byte 0xfa
                    !byte 0xd7
                    sed
                    sbc 0xf882,x
                    inc 0x5ffd,x
                    sed
                    sbc 0xf884,x
                    sbc 0xf882,x
                    sbc 0xf8e6,x
                    sbc 0xf871,x
                    sbc 0xf873,x
                    sbc 0xf81f,x
                    sbc 0xf81c,x
                    inc 0x24fd,x
                    sed
                    sbc 0xf827,x
                    sbc 0xf850,x
                    sbc 0xf848,x
                    sbc 0xf8c4,x
                    sbc 0xf8c0,x
                    sbc 0xf894,x
                    sbc 0xf8e0,x
                    sbc 0xf864,x
                    sbc 0xf83f,x
                    sbc 0xf813,x
                    inc 0x15fd,x
                    sed
                    sbc 0xf834,x
                    sbc 0xf804,x
                    !byte 0xff
                    bpl 0x3802
                    !byte 0x63
                    !byte 0xfb
                    !byte 0x5f
                    !byte 0xfa
                    clv
                    sbc 0xfdfc,y
                    !byte 0x8b
                    !byte 0xfc
                    sed
                    sbc 0xfefc,y
                    inc 0x39fb,x
                    sbc 0xfafb,x
                    !byte 0xf4
                    sbc 0xfbf2,x
                    and 0xd9fa,y
                    sbc 0xfdfc,y
                    !byte 0x1a
                    inc 0xf9fc,x
                    !byte 0xfc
                    !byte 0xff
                    ora (0xfe),y
                    inc 0xc3fd,x
                    !byte 0xfb
                    and 0xddfa,y
                    sbc 0xfceb,x
                    !byte 0xff
                    !byte 0xff
                    !byte 0xff
                    !byte 0xff
                    !byte 0xff
                    }
                    
item_placement_end: