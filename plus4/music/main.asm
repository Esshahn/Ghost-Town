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
                    rts

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
                    jsr music_play  ; jsr 0x1ebc
                    jsr music_display
                    jsr music_write
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
