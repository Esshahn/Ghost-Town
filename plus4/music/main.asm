                    !cpu 6502

VOICE1_LO           = temp_FF0E
VOICE1_HI           = temp_FF12
VOICE2_LO           = temp_FF0F
VOICE2_HI           = temp_FF10
kFF11               = temp_FF11

vidmem0             = 0x0c00

code_start          = 0x1000

                    *= vidmem0
                    !bin "includes/screen.prg",,2

                    *= code_start
                    lda 0xFF12
                    sta temp_FF12
                    jsr irq_init0
                    jmp *


music_display:      lda temp_FF0E
                    jsr lib_hex2screen
                    sta vidmem0+(1*40)+12
                    stx vidmem0+(1*40)+13
                    lda temp_FF12
                    and #%00000011
                    sta clean_FF12
                    jsr lib_hex2screen
                    sta vidmem0+(2*40)+12
                    stx vidmem0+(2*40)+13

                    lda temp_FF0F
                    jsr lib_hex2screen
                    sta vidmem0+(4*40)+12
                    stx vidmem0+(4*40)+13
                    lda temp_FF10
                    jsr lib_hex2screen
                    sta vidmem0+(5*40)+12
                    stx vidmem0+(5*40)+13

                    lda temp_FF11
                    jsr lib_hex2screen
                    sta vidmem0+(7*40)+12
                    stx vidmem0+(7*40)+13

                    ; print human readable note value voice1
                    ldx clean_FF12
                    lda freq_tab_pt_lo,x
                    sta .frtabpt0+1
                    lda freq_tab_pt_hi,x
                    sta .frtabpt0+2
                    ldx temp_FF0E
.frtabpt0:          lda 0x0000,x
                    cmp #0xFF
                    beq +
                    tax
                    lda note_tab0,x
                    sta vidmem0+(1*40)+20
                    lda note_tab1,x
                    sta vidmem0+(1*40)+21
                    lda note_tab2,x
                    sta vidmem0+(1*40)+22
+                   ; print human readable note value voice2
                    ldx temp_FF10
                    lda freq_tab_pt_lo,x
                    sta .frtabpt1+1
                    lda freq_tab_pt_hi,x
                    sta .frtabpt1+2
                    ldx temp_FF0F
.frtabpt1:          lda 0x0000,x
                    cmp #0xFF
                    beq +
                    tax
                    lda note_tab0,x
                    sta vidmem0+(4*40)+20
                    lda note_tab1,x
                    sta vidmem0+(4*40)+21
                    lda note_tab2,x
                    sta vidmem0+(4*40)+22
+                   rts

music_write:        lda temp_FF0E
                    sta 0xFF0E
                    lda temp_FF12
                    sta 0xFF12
                    lda temp_FF0F
                    sta 0xFF0F
                    lda temp_FF10
                    sta 0xFF10
                    lda temp_FF11
                    sta 0xFF11
                    rts

temp_FF0E:          !byte 0x00
temp_FF12:          !byte 0x00
temp_FF0F:          !byte 0x00
temp_FF10:          !byte 0x00
temp_FF11:          !byte 0x00
clean_FF12:         !byte 0x00
; ==============================================================================
;
; music data
; ==============================================================================
; * = 0x1d11
music:
                    !source "includes/music.asm"

; ==============================================================================
                    ; *= 0x1DD2
music_player:                           ; Teil von music_play
rsav2:              ldy #0x00
                    bne +               ; bne 0x1df3
                    lda #0x40
                    sta rsav3+1         ; sta 0x1e39
                    jsr more_music      ; jsr 0x1e38
rsav4:              ldx #0x00
                    lda music+3,x       ; lda 0x1d14,x / first voice
                    inc rsav4+1         ; inc 0x1ddf
                    tay
                    and #0x1f
                    sta rsav3+1         ; sta 0x1e39
                    tya
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    tay
+                   dey
                    sty rsav2+1         ; sty 0x1dd3
rsav5:              ldy #0x00
                    bne +
                    lda #0x40
                    sta even_more_music + 1
                    jsr even_more_music           ; jsr 0x1e60
rsav6:              ldx #0x00
                    lda music + 0x5d,x     ; lda 0x1d6e,x                 ; second voice
                    tay
                    inx
                    cpx #0x65
                    beq m1E27           ; beq 0x1e27
                    stx rsav6 + 1       ; stx 0x1e04
                    and #0x1f
                    sta even_more_music + 1       ; sta 0x1e61
                    tya
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    tay
+                   dey
                    sty rsav5 + 1       ; sty 0x1df8
                    jsr more_music           ; jsr 0x1e38
                    jmp even_more_music           ; jmp 0x1e60

; ==============================================================================
; music
m1E27:              lda #0x00
                    sta rsav2+1         ; sta 0x1dd3
                    sta rsav4+1         ; sta 0x1ddf
                    sta rsav5+1         ; sta 0x1df8
                    sta rsav6+1         ; sta 0x1e04
                    jmp music_player           ; jmp 0x1dd2

; ==============================================================================
; music

more_music:
rsav3:              ldx #0x04
                    cpx #0x1c
                    bcc +               ; bcc 0x1e46
                    lda kFF11
                    and #0xef           ; clear bit 4
                    jmp writeFF11       ; jmp 0x1e5c

+                   lda m1E88,x         ; lda 0x1e88,x        ; 0x1E88 ... : music data lo ?
                    sta VOICE1_LO          ; Low byte of frequency for voice 1
                    lda VOICE1_HI
                    and #0xfc
                    ora m1E88 + 0x18, x  ; ora 0x1ea0,x        ; 0x1EA0 ... : music data hi ?
                    sta VOICE1_HI          ; High bits of frequency for voice 1
                    lda kFF11
                    ora #0x10           ; set bit 4
writeFF11           sta kFF11           ;  (de-)select voice 1
                    rts

; ==============================================================================
;
;
; ==============================================================================
; music
                    ; *= 0x1E60
even_more_music:
                    ldx #0x0d
                    cpx #0x1c
                    bcc +
                    lda kFF11
                    and #0xdf
                    jmp writeFF11       ; jmp 0x1e5c
+                   lda m1E88,x         ; lda 0x1e88,x
                    sta VOICE2_LO ; sta 0xff0f
                    lda VOICE2_HI
                    and #0xfc
                    ora m1E88 + 0x18,x   ; ora 0x1ea0,x
                    sta VOICE2_HI
                    lda kFF11
                    ora #0x20
                    sta kFF11
                    rts

; ==============================================================================
;
; seems to be the instruments or pitch/octave of the music
; ==============================================================================

; part of the music or the music instruments
; 0x1e88
m1E88:
!byte 0x07, 0x76, 0xa9, 0x06, 0x59, 0x7f, 0xc5, 0x04, 0x3b, 0x54, 0x83, 0xad, 0xc0, 0xe3, 0x02, 0x1e
!byte 0x2a, 0x42, 0x56, 0x60, 0x71, 0x81, 0x8f, 0x95, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x02
!byte 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03
!byte 0x03, 0x03, 0x03, 0x03

; ==============================================================================
;
;
; ==============================================================================
; music

music_play:
rsav0:              ldx #0x09
                    dex
                    stx rsav0+1         ; stx 0x1ebd
                    beq +               ; beq 0x1ece
                    rts

; ==============================================================================
; music
                    ; *= 0x1EC5
rsav1:              ldy #0x01
                    dey
                    sty rsav1+1         ; sty 0x1ec6
                    beq +               ; beq 0x1ece
                    rts

; ==============================================================================
; music
                    ; *= 0x1ECE
+                   ldy #0x0b
                    sty rsav0+1         ; sty 0x1ebd
                    lda kFF11
                    ora #0x37
rsav7:              and #0xbf           ; 0x1ED8 0x1ED9     ; rsav7+1 = sound volume
                    sta kFF11          ; sth. with SOUND / MUSIC ?
                    jmp music_player           ; jmp 0x1dd2

; ==============================================================================
; irq init
;
; ==============================================================================


irq_init0:
                    sei
                    lda #<irq0
                    sta 0x0314
                    lda #>irq0
                    sta 0x0315

                    lda #0x02
                    sta 0xff0a

                    lda #0xbf
                    sta rsav7+1         ; sta 0x1ed9    ; sound volume
                    cli
                    rts

irq0:
                    lda 0xFF09
                    sta 0xFF09
                    dec 0xFF19
                    jsr music_play  ; jsr 0x1ebc
                    jsr music_display
                    jsr music_write
                    inc 0xFF19
                    pla
                    tay
                    pla
                    tax
                    pla
                    rti
; ==============================================================================
; lib_hex2screen
; ------------+-----------------------------------------------------------------
; depends on: | -
; ------------+-----------------------------------------------------------------
; uses:       | A, X
; ------------+-----------------------------------------------------------------
; preserves:  | Y
; ------------+---+-------------------------------------------------------------
; input:      | A | hexvalue to be converted
; ------------+---+-------------------------------------------------------------
; output:     | A | petscii/screencode high nibble
;             | X | petscii/screencode low nibble
; ------------+---+-------------------------------------------------------------
                    !zone LIB_HEX2SCREEN

lib_hex2screen:     sta .savea+1
                    and #%00001111
                    tax
                    lda .hextab,x
                    sta .low_nibble+1
.savea              lda #0
                    lsr
                    lsr
                    lsr
                    lsr
                    tax
                    lda .hextab,x           ; high nibble
.low_nibble         ldx #0
                    rts
.hextab:            !scr "0123456789abcdef"
; ==============================================================================
                    !zone TABLES
freq_tab_pt_lo:     !byte <freq_tab0, <freq_tab1, <freq_tab2, <freq_tab3
freq_tab_pt_hi:     !byte >freq_tab0, >freq_tab1, >freq_tab2, >freq_tab3
freq_tab0:          !fi 255, 0xFF
freq_tab1:          !fi 255, 0xFF
freq_tab2:          !fi 255, 0xFF
freq_tab3:          !fi 255, 0xFF
note_tab0:          !scr "aabccddeffgg"
                    !scr "aabccddeffgg"
                    !scr "aabccddeffgg"
                    !scr "aabccddeffgg"
                    !scr "aabccddeffgg"
note_tab1:          !scr "-#--#-#--#-#"
                    !scr "-#--#-#--#-#"
                    !scr "-#--#-#--#-#"
                    !scr "-#--#-#--#-#"
                    !scr "-#--#-#--#-#"
note_tab2:          !scr "000111111111"
                    !scr "111222222222"
                    !scr "222333333333"
                    !scr "333444444444"
                    !scr "444555555555"
                    ; indexes
                    *= freq_tab0+0x07   ; A-0
                    !byte 0x00
                    *= freq_tab0+0x40   ; A#0
                    !byte 0x01
                    *= freq_tab0+0x76   ; B-0
                    !byte 0x02
                    *= freq_tab0+0xA9   ; C-1
                    !byte 0x03
                    *= freq_tab0+0xD9   ; C#1
                    !byte 0x04
                    *= freq_tab1+0x06   ; D-1
                    !byte 0x05
                    *= freq_tab1+0x31   ; D#1
                    !byte 0x06
                    *= freq_tab1+0x59   ; E-1
                    !byte 0x07
                    *= freq_tab1+0x7F   ; F-1
                    !byte 0x08
                    *= freq_tab1+0xA3   ; F#1
                    !byte 0x09
                    *= freq_tab1+0xC5   ; G-1
                    !byte 0x0A
                    *= freq_tab1+0xE5   ; G#1
                    !byte 0x0B
                    *= freq_tab2+0x04   ; A-1
                    !byte 0x0C
                    *= freq_tab2+0x20   ; A#1
                    !byte 0x0D
                    *= freq_tab2+0x3B   ; B-1
                    !byte 0x0E
                    *= freq_tab2+0x54   ; C-2
                    !byte 0x0F
                    *= freq_tab2+0x6C   ; C#2
                    !byte 0x10
                    *= freq_tab2+0x83   ; D-2
                    !byte 0x11
                    *= freq_tab2+0x98   ; D#2
                    !byte 0x12
                    *= freq_tab2+0xAD   ; E-2
                    !byte 0x13
                    *= freq_tab2+0xC0   ; F-2
                    !byte 0x14
                    *= freq_tab2+0xD2   ; F#2
                    !byte 0x15
                    *= freq_tab2+0xE3   ; G-2
                    !byte 0x16
                    *= freq_tab2+0xF3   ; G#2
                    !byte 0x17
                    *= freq_tab3+0x02   ; A-2
                    !byte 0x18
                    *= freq_tab3+0x10   ; A#2
                    !byte 0x19
                    *= freq_tab3+0x1E   ; B-2
                    !byte 0x1A
                    *= freq_tab3+0x2A   ; C-3
                    !byte 0x1B
                    *= freq_tab3+0x36   ; C#3
                    !byte 0x1C
                    *= freq_tab3+0x42   ; D-3
                    !byte 0x1D
                    *= freq_tab3+0x46   ; D#3
                    !byte 0x1E
                    *= freq_tab3+0x56   ; E-3
                    !byte 0x1F
                    *= freq_tab3+0x60   ; F-3
                    !byte 0x20
                    *= freq_tab3+0x69   ; F#3
                    !byte 0x21
                    *= freq_tab3+0x71   ; G-3
                    !byte 0x22
                    *= freq_tab3+0x79   ; G#3
                    !byte 0x23
                    *= freq_tab3+0x81   ; A-3
                    !byte 0x24
                    *= freq_tab3+0x88   ; A#3
                    !byte 0x25
                    *= freq_tab3+0x8F   ; B-3
                    !byte 0x26
                    *= freq_tab3+0x95   ; C-4
                    !byte 0x27
                    *= freq_tab3+0x9B   ; C#4
                    !byte 0x28
                    *= freq_tab3+0xA1   ; D-4
                    !byte 0x29
                    *= freq_tab3+0xA6   ; D#4
                    !byte 0x2A
                    *= freq_tab3+0xAB   ; E-4
                    !byte 0x2B
                    *= freq_tab3+0xB0   ; F-4
                    !byte 0x2C
                    *= freq_tab3+0xB4   ; F#4
                    !byte 0x2D
                    *= freq_tab3+0xB9   ; G-4
                    !byte 0x2E
                    *= freq_tab3+0xBD   ; G#4
                    !byte 0x2F
                    *= freq_tab3+0xC0   ; A-4
                    !byte 0x30
                    *= freq_tab3+0xC4   ; A#4
                    !byte 0x31
                    *= freq_tab3+0xC7   ; B-4
                    !byte 0x32
                    *= freq_tab3+0xCB   ; C-5
                    !byte 0x33
                    *= freq_tab3+0xCE   ; C#5
                    !byte 0x34
                    *= freq_tab3+0xD0   ; D-5
                    !byte 0x35
                    *= freq_tab3+0xD3   ; D#5
                    !byte 0x36
                    *= freq_tab3+0xD6   ; E-5
                    !byte 0x37
                    *= freq_tab3+0xD8   ; F-5
                    !byte 0x38
                    *= freq_tab3+0xDA   ; F#5
                    !byte 0x39
                    *= freq_tab3+0xDC   ; G-5
                    !byte 0x3A
                    *= freq_tab3+0xDE   ; G#5
                    !byte 0x3B
