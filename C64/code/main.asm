                    !cpu 6510
; ==============================================================================
DEBUG               = 1
BLACK               = 0x00
WHITE               = 0x01
RED                 = 0x02
CYAN                = 0x03
PURPLE              = 0x04
GREEN               = 0x05
BLUE                = 0x06
YELLOW              = 0x07
ORANGE              = 0x08
BROWN               = 0x09
PINK                = 0x0A
DARK_GREY           = 0x0B
GREY                = 0x0C
LIGHT_GREEN         = 0x0D
LIGHT_BLUE          = 0x0E
LIGHT_GREY          = 0x0F
KEY_W               = 0x57
KEY_A               = 0x41
KEY_S               = 0x53
KEY_D               = 0x44
KEY_RETURN          = 0x0D
KEY_SPACE           = 0x20
COL_BORDER_INGAME   = RED
COL_BG_INGAME       = BLACK
COL_BORDER_START    = DARK_GREY
COL_BG_START        = DARK_GREY
; ==============================================================================
zp_start            = 0x02
zp_temp0            = zp_start
zp_temp0_lo         = zp_temp0
zp_temp0_hi         = zp_temp0_lo+1
zp_temp1            = zp_temp0_hi+1
zp_temp1_lo         = zp_temp1
zp_temp1_hi         = zp_temp1_lo+1
zp_temp2            = zp_temp1_hi+1
zp_temp2_lo         = zp_temp2
zp_temp2_hi         = zp_temp2_lo+1
pt_screen           = zp_temp2_hi+1
pt_screen_lo        = pt_screen
pt_screen_hi        = pt_screen_lo+1
pt_colram           = pt_screen_hi+1
pt_colram_lo        = pt_colram
pt_colram_hi        = pt_colram_lo+1
key_up              = pt_colram_hi+1
key_down            = key_up+1
key_left            = key_down+1
key_right           = key_left+1
key_action          = key_right+1
irq_ready           = key_action+1
current_room        = irq_ready+1
; ==============================================================================
getin               = 0xFFE4
keyscan             = 0xEA87
code_start          = 0x4000
music_init          = 0x1000
music_play          = music_init+3
vicbank             = 0x0000
charset0            = vicbank+0x1800
charset1            = vicbank+0x0800
vidmem0             = vicbank+0x0400
vidmem_start        = vicbank+0x2000
vidmem_win          = vicbank+0x2400
dd00_val0           = <!(vicbank/0x4000) & 3
d018_val0           = <(((vidmem0-vicbank)/0x400) << 4) + <(((charset0-vicbank)/0x800) << 1)
d018_val1           = <(((vidmem0-vicbank)/0x400) << 4) + <(((charset1-vicbank)/0x800) << 1)
d018_val_start      = <(((vidmem_start-vicbank)/0x400) << 4) + <(((charset0-vicbank)/0x800) << 1)
d018_val_win        = <(((vidmem_win-vicbank)/0x400) << 4) + <(((charset0-vicbank)/0x800) << 1)
; ==============================================================================
                    !zone INCLUDES
                    *= charset1
                    !bin "includes/charset.bin"
charset1_end:
                    *= music_init
                    !bin "../music/sid/Industrial_Town_64.sid",,0x7E
music_end:
                    *= vidmem_start
                    !bin "includes/screen-start.scr"
vidmem_start_end:
                    *= vidmem_win
                    !bin "includes/screen-win-en.scr"
vidmem_win_end:
; ==============================================================================
                    *= code_start
                    jmp init
; ==============================================================================
                    !zone IRQ
irq0:               !if DEBUG = 1 { dec 0xD020 }
                    asl 0xD019
                    jsr music_play
                    jsr input
                    !if DEBUG = 1 { inc 0xD020 }
                    lda #0x01
                    sta irq_ready
irq_end:            jmp 0xEA81
nmi:                rti
; ==============================================================================
                    !zone INIT
init:               sei
                    lda #0x7F
                    sta 0xDC0D
                    sta 0xDD0D
                    lda 0xDC0D
                    lda 0xDD0D
                    lda #0x36
                    sta 0x01
                    jsr init_vic
                    jsr init_zeropage
                    jsr init_music
                    jsr init_irq
                    jmp main_startscreen
init_irq:           lda #0xFB
                    sta 0xD012
                    lda #<irq0
                    sta 0x0314
                    lda #>irq0
                    sta 0x0315
                    lda #<nmi
                    sta 0x0319
                    lda #>nmi
                    sta 0x031A
                    lda #0x01
                    sta 0xD01A
                    sta 0xD019
                    cli
                    rts
init_music:         lda #0x00
                    tax
                    tay
                    jsr music_init
                    rts
init_vic:           lda #0x0B
                    sta 0xD011
                    lda #dd00_val0
                    sta 0xDD00
                    lda #d018_val0
                    sta 0xD018
                    lda #0x08
                    sta 0xD016
                    lda #0x00
                    sta 0xD015
                    rts
init_zeropage:      lda #0x00
                    ldx #0x02
-                   sta 0x00,x
                    inx
                    bne -
                    rts
init_pointers:      lda #0x00
                    sta pt_screen_lo
                    sta pt_colram_lo
                    lda #>vidmem0
                    sta pt_screen_hi
                    lda #>(0xD800)
                    sta pt_colram_hi
                    rts
; ==============================================================================
                    !zone MAINLOOP
main_startscreen:   jsr print_screen_start
                    jsr wait_key_action
                    jsr print_room
mainloop:
                    jsr wait_key_action
                    inc current_room
                    lda current_room
                    cmp #19
                    bne +
                    lda #0
                    sta current_room
+                   jsr print_room
                    jmp mainloop
; ==============================================================================
                    !zone PRINT
print_screen_start: lda #0x0B
                    sta 0xD011
                    lda #COL_BORDER_START
                    sta 0xD020
                    lda #COL_BG_START
                    sta 0xD021
                    lda #BLACK
                    jsr lib_colramfill
                    lda #d018_val_start
                    sta 0xD018
                    lda #0x08
                    sta 0xD016
                    lda #0x1B
                    sta 0xD011
                    rts
print_room:         lda #0x0B
                    sta 0xD011
                    lda #COL_BORDER_INGAME
                    sta 0xD020
                    lda #COL_BG_INGAME
                    sta 0xD021
                    jsr print_border
                    jsr init_pointers
                    ldx current_room
                    lda room_tab_lo,x
                    sta zp_temp0_lo
                    lda room_tab_hi,x
                    sta zp_temp0_hi
                    ldy #0x00
                    sty .ct_chars+1
                    sty .ct_cols+1
.get_tile:          lda (zp_temp0),y
                    tax
                    lda tiles_chars,x
                    sta zp_temp1
                    lda tiles_colors,x
                    sta zp_temp2
                    ldx #0x03
.tileloop:          ldy #0x00
-                   lda pt_screen_lo
                    sta pt_colram_lo
                    lda zp_temp2
                    sta (pt_colram),y
                    lda zp_temp1
                    sta (pt_screen),y
                    cmp #0xDF           ; empty char ?
                    beq +
                    inc zp_temp1        ; tiles are "ordered" in charset
+                   iny
                    cpy #0x03
                    bne -
                    clc
                    lda pt_screen_lo
                    adc #0x28
                    sta pt_screen_lo
                    bcc +
                    inc pt_screen_hi
                    inc pt_colram_hi
+                   dex
                    bne .tileloop
                    inc .ct_cols+1
                    inc .ct_chars+1
                    lda #0x75
.ct_cols:           ldx #0x00
                    cpx #0x0D
                    bcc +
.ct_chars:          ldx #0x00
                    cpx #0x66
                    bcs .fix_doors
                    lda #0x00
                    sta .ct_cols+1
                    lda #0x24
+                   sta .subtract_val+1
                    sec
                    lda pt_screen_lo
.subtract_val:      sbc #0x00
                    sta pt_screen_lo
                    bcs +
                    dec pt_screen_hi
                    dec pt_colram_hi
+                   ldy .ct_chars+1
                    jmp .get_tile
.fix_doors:         jsr init_pointers
-                   ldy #0x28
                    lda (pt_screen),y
                    cmp #0x06
                    bcs +
                    sec
                    sbc #0x03
                    ldy #0x00
                    sta (pt_screen),y
                    lda #YELLOW+8
                    sta (pt_colram),y
+                   lda pt_screen_lo
                    clc
                    adc #$01
                    bcc +
                    inc pt_screen_hi
                    inc pt_colram_hi
+                   sta pt_screen_lo
                    sta pt_colram_lo
                    cmp #0x98
                    bne -
                    lda pt_screen_hi
                    cmp #>(vidmem0+0x300)
                    bne -
                    lda #0x18
                    sta 0xD016
                    lda #PINK
                    sta 0xD022
                    lda #BROWN
                    sta 0xD023
                    lda #d018_val1
                    sta 0xD018
                    lda #0x1B
                    sta 0xD011
                    rts
print_border:       lda #0x27
                    sta zp_temp0_lo
                    sta zp_temp1_lo
                    lda #>(0xD800)
                    sta zp_temp1_hi
                    lda #>vidmem0
                    sta zp_temp0_hi
                    ldx #0x18
                    ldy #0x00
-                   lda #0x5D
                    sta (zp_temp0),y
                    lda #COL_BORDER_INGAME
                    sta (zp_temp1),y
                    tya
                    clc
                    adc #0x28
                    tay
                    bcc +
                    inc zp_temp0_hi
                    inc zp_temp1_hi
+                   dex
                    bne -
-                   lda #0x5D
                    sta vidmem0 + 0x3c0,x
                    lda #COL_BORDER_INGAME
                    sta 0xD800 + 0x3c0,x
                    inx
                    cpx #0x28
                    bne -
                    rts
; ==============================================================================
                    !zone WAIT
wait:               dex
                    bne wait
                    dey
                    bne wait
                    rts
wait_key_action:    lda #0x00
                    sta key_action
-                   lda key_action
                    beq -
                    rts
wait_irq:           lda #0x00
                    sta irq_ready
-                   lda irq_ready
                    beq -
                    rts
; ==============================================================================
                    !zone LIB
lib_colramfill:     ldx #0x00
-                   sta 0xD800+0x000,x
                    sta 0xD800+0x100,x
                    sta 0xD800+0x200,x
                    sta 0xD800+0x2E8,x
                    inx
                    bne -
                    rts
; ==============================================================================
                    !zone INPUT
input:              lda #0x00
                    sta key_up
                    sta key_down
                    sta key_left
                    sta key_right
                    sta key_action
                    jsr input_keyboard
                    rts
input_keyboard:     !if DEBUG=1 { dec 0xD020 }
                    jsr keyscan
                    jsr getin
                    bne +
                    jmp .key_exit
+                   !if DEBUG=1 { sta vidmem_start+0x3E7 }
                    cmp #KEY_W
                    bne +
                    inc key_up
                    jmp .key_exit
+                   cmp #KEY_S
                    bne +
                    inc key_down
                    jmp .key_exit
+                   cmp #KEY_A
                    bne +
                    inc key_left
                    jmp .key_exit
+                   cmp #KEY_D
                    bne +
                    inc key_right
                    jmp .key_exit
+                   cmp #KEY_RETURN
                    bne +
                    inc key_action
                    jmp .key_exit
+                   cmp #KEY_SPACE
                    bne +
                    inc key_action
                    jmp .key_exit
+
.key_exit:
                    !if DEBUG=1 { inc 0xD020 }
                    rts
; ==============================================================================
                    !zone DATA
room_00:  !byte $01, $00, $00, $00, $01, $01, $01, $00, $0b, $00, $00, $00, $00
          !byte $01, $00, $0b, $00, $00, $00, $00, $00, $0c, $01, $01, $01, $00
          !byte $10, $00, $0c, $00, $00, $0b, $00, $00, $01, $00, $00, $00, $00
          !byte $01, $01, $01, $01, $00, $0c, $00, $00, $00, $00, $0b, $00, $01
          !byte $00, $00, $00, $00, $01, $01, $00, $0b, $00, $00, $0c, $00, $01
          !byte $01, $00, $0b, $00, $00, $00, $00, $0c, $00, $01, $01, $00, $01
          !byte $01, $00, $0c, $00, $01, $01, $00, $01, $00, $00, $00, $00, $10
          !byte $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01
room_01:  !byte $00, $00, $02, $02, $02, $02, $02, $00, $00, $00, $02, $02, $02
          !byte $10, $00, $02, $00, $00, $00, $04, $00, $02, $00, $00, $00, $02
          !byte $02, $00, $00, $00, $00, $00, $00, $00, $02, $00, $04, $00, $02
          !byte $02, $00, $04, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02
          !byte $02, $00, $00, $00, $00, $02, $00, $04, $00, $00, $00, $00, $02
          !byte $02, $00, $03, $04, $00, $00, $00, $00, $00, $00, $00, $00, $02
          !byte $02, $02, $00, $00, $00, $02, $02, $00, $04, $00, $02, $00, $10
          !byte $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $02, $02, $02
room_02:  !byte $00, $01, $01, $01, $01, $02, $02, $02, $00, $00, $00, $02, $02
          !byte $10, $00, $01, $01, $01, $01, $00, $00, $00, $02, $00, $00, $00
          !byte $01, $00, $01, $01, $01, $01, $02, $02, $02, $00, $02, $02, $00
          !byte $01, $00, $00, $00, $01, $01, $01, $02, $00, $00, $00, $02, $00
          !byte $01, $01, $00, $00, $00, $01, $01, $02, $02, $00, $02, $02, $00
          !byte $01, $00, $00, $00, $00, $00, $01, $01, $02, $00, $02, $00, $00
          !byte $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
          !byte $01, $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $00, $10
room_03:  !byte $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $03, $01
          !byte $10, $00, $01, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01
          !byte $01, $00, $01, $01, $00, $01, $00, $00, $00, $01, $00, $00, $01
          !byte $01, $00, $00, $01, $00, $01, $00, $01, $00, $01, $00, $00, $01
          !byte $01, $01, $00, $01, $00, $00, $00, $01, $00, $01, $00, $00, $01
          !byte $00, $01, $00, $01, $01, $01, $01, $01, $00, $01, $00, $00, $10
          !byte $00, $01, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01
          !byte $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00
room_04:  !byte $01, $01, $01, $01, $01, $02, $00, $02, $01, $01, $01, $01, $01
          !byte $06, $00, $00, $01, $01, $02, $00, $02, $01, $00, $00, $00, $07
          !byte $01, $01, $00, $10, $01, $02, $00, $02, $01, $00, $01, $01, $01
          !byte $06, $00, $00, $00, $01, $02, $00, $00, $00, $00, $00, $00, $07
          !byte $01, $01, $01, $00, $01, $02, $00, $02, $00, $01, $01, $01, $01
          !byte $06, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $00, $07
          !byte $01, $01, $00, $01, $01, $02, $00, $02, $01, $01, $00, $01, $01
          !byte $06, $00, $00, $00, $01, $02, $00, $02, $01, $10, $00, $00, $07
room_05:  !byte $01, $00, $00, $00, $01, $00, $00, $00, $00, $0d, $00, $01, $01
          !byte $01, $00, $0d, $00, $01, $00, $00, $00, $01, $01, $00, $00, $01
          !byte $10, $00, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01
          !byte $01, $00, $01, $01, $00, $00, $00, $00, $00, $00, $0d, $00, $01
          !byte $01, $00, $00, $00, $00, $00, $0d, $00, $01, $01, $01, $00, $01
          !byte $00, $00, $01, $03, $00, $00, $01, $01, $00, $00, $00, $00, $00
          !byte $0d, $00, $00, $00, $00, $01, $01, $00, $00, $0d, $00, $00, $10
          !byte $01, $01, $01, $00, $0d, $00, $01, $01, $01, $01, $01, $01, $01
room_06:  !byte $02, $00, $02, $00, $00, $00, $02, $00, $00, $00, $02, $00, $02
          !byte $10, $00, $02, $00, $01, $00, $02, $00, $01, $00, $02, $00, $10
          !byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
          !byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $10
          !byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
          !byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $10
          !byte $02, $00, $01, $00, $02, $00, $01, $00, $02, $00, $01, $00, $02
          !byte $02, $00, $00, $00, $02, $00, $00, $00, $02, $00, $00, $00, $10
room_07:  !byte $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $00, $00, $0b
          !byte $10, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $0c
          !byte $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01
          !byte $01, $00, $00, $00, $0b, $00, $00, $00, $05, $00, $0b, $00, $01
          !byte $01, $01, $00, $00, $0c, $00, $01, $00, $00, $00, $0c, $00, $01
          !byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
          !byte $00, $00, $00, $01, $01, $00, $0b, $00, $01, $01, $01, $00, $10
          !byte $01, $00, $00, $00, $00, $00, $0c, $00, $00, $00, $00, $00, $01
room_08:  !byte $00, $00, $01, $01, $01, $08, $0a, $09, $00, $02, $02, $02, $02
          !byte $10, $00, $00, $00, $01, $08, $0a, $09, $00, $00, $02, $02, $02
          !byte $00, $00, $00, $00, $00, $08, $0a, $09, $00, $00, $00, $02, $02
          !byte $00, $00, $01, $01, $00, $08, $0a, $09, $00, $00, $00, $00, $02
          !byte $00, $00, $00, $01, $00, $08, $0a, $09, $00, $00, $00, $00, $10
          !byte $01, $00, $00, $00, $00, $08, $0a, $09, $00, $00, $00, $02, $02
          !byte $01, $00, $00, $00, $00, $08, $0a, $09, $00, $00, $02, $02, $02
          !byte $00, $01, $01, $00, $00, $08, $0a, $09, $00, $02, $02, $02, $02
room_09:  !byte $00, $02, $02, $02, $00, $00, $00, $02, $00, $00, $00, $00, $02
          !byte $10, $00, $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $02
          !byte $02, $02, $02, $02, $00, $00, $00, $02, $02, $00, $02, $00, $02
          !byte $02, $00, $00, $00, $02, $02, $02, $00, $00, $00, $02, $00, $02
          !byte $02, $00, $02, $00, $00, $00, $02, $00, $02, $00, $00, $00, $02
          !byte $02, $00, $02, $02, $02, $00, $00, $00, $02, $02, $02, $02, $00
          !byte $03, $00, $00, $00, $02, $02, $02, $02, $02, $00, $00, $00, $10
          !byte $02, $02, $02, $00, $00, $00, $00, $00, $00, $00, $02, $02, $02
room_10:  !byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
          !byte $02, $02, $00, $00, $02, $02, $02, $02, $02, $00, $00, $02, $02
          !byte $02, $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $02
          !byte $02, $00, $00, $03, $00, $00, $00, $00, $00, $00, $00, $00, $02
          !byte $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $10
          !byte $02, $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $02
          !byte $02, $02, $00, $00, $02, $02, $02, $02, $02, $00, $00, $02, $02
          !byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
room_11:  !byte $02, $02, $02, $00, $00, $00, $0b, $00, $00, $01, $01, $01, $00
          !byte $02, $02, $00, $00, $00, $00, $0c, $00, $01, $00, $00, $00, $01
          !byte $02, $00, $00, $0b, $00, $00, $00, $00, $00, $01, $01, $00, $01
          !byte $02, $00, $00, $0c, $00, $0b, $00, $00, $00, $00, $00, $00, $00
          !byte $10, $00, $00, $00, $00, $0c, $00, $0b, $00, $00, $01, $00, $10
          !byte $02, $00, $00, $00, $00, $00, $00, $0c, $00, $00, $01, $00, $01
          !byte $02, $02, $00, $00, $0b, $00, $00, $00, $00, $01, $00, $01, $00
          !byte $02, $02, $02, $00, $0c, $00, $00, $01, $01, $00, $00, $00, $00
room_12:  !byte $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00
          !byte $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
          !byte $01, $00, $00, $0d, $00, $00, $00, $00, $0d, $00, $00, $00, $01
          !byte $01, $00, $00, $00, $00, $00, $10, $00, $00, $0d, $00, $00, $01
          !byte $10, $00, $00, $0d, $00, $00, $00, $00, $00, $00, $00, $03, $01
          !byte $01, $00, $00, $00, $0d, $00, $00, $00, $0d, $00, $00, $00, $01
          !byte $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
          !byte $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00
room_13:  !byte $02, $02, $02, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02
          !byte $10, $00, $02, $02, $00, $02, $02, $02, $02, $00, $02, $00, $02
          !byte $02, $00, $00, $02, $00, $00, $00, $00, $02, $00, $02, $00, $10
          !byte $02, $02, $00, $02, $02, $02, $02, $00, $02, $00, $02, $00, $02
          !byte $02, $02, $00, $02, $00, $00, $00, $00, $02, $00, $02, $00, $02
          !byte $00, $00, $00, $02, $00, $02, $02, $02, $02, $00, $02, $00, $02
          !byte $00, $02, $02, $02, $00, $02, $03, $00, $00, $00, $00, $00, $02
          !byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02
room_14:  !byte $02, $00, $00, $02, $0a, $0a, $0a, $0a, $0a, $02, $00, $00, $02
          !byte $10, $00, $00, $00, $02, $0a, $0a, $0a, $02, $00, $00, $00, $10
          !byte $02, $00, $00, $00, $00, $02, $0a, $02, $00, $00, $00, $00, $02
          !byte $02, $00, $00, $00, $00, $02, $0a, $02, $00, $00, $00, $00, $02
          !byte $0a, $02, $00, $00, $00, $00, $02, $00, $00, $00, $00, $02, $0a
          !byte $0a, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $0a
          !byte $0a, $0a, $02, $00, $00, $00, $00, $00, $00, $00, $02, $0a, $0a
          !byte $0a, $0a, $0a, $02, $02, $02, $02, $02, $02, $02, $0a, $0a, $0a
room_15:  !byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
          !byte $02, $00, $00, $02, $02, $00, $02, $00, $00, $03, $00, $00, $02
          !byte $10, $00, $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $02
          !byte $02, $00, $02, $02, $00, $02, $02, $02, $02, $00, $02, $02, $02
          !byte $02, $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $02
          !byte $02, $02, $02, $02, $00, $02, $02, $00, $00, $02, $00, $00, $02
          !byte $02, $02, $02, $02, $00, $00, $00, $00, $02, $02, $00, $00, $10
          !byte $02, $02, $02, $02, $03, $02, $02, $02, $02, $02, $02, $02, $02
room_16:  !byte $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00, $02
          !byte $10, $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02
          !byte $02, $02, $02, $00, $00, $02, $02, $02, $02, $02, $02, $00, $02
          !byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
          !byte $02, $02, $02, $02, $00, $00, $02, $00, $02, $02, $02, $02, $02
          !byte $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00
          !byte $00, $00, $00, $02, $00, $00, $02, $00, $02, $00, $00, $00, $00
          !byte $00, $00, $00, $02, $00, $00, $02, $00, $02, $00, $00, $00, $00
room_17:  !byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
          !byte $10, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $00, $00
          !byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $10
          !byte $02, $00, $00, $02, $00, $00, $02, $02, $02, $02, $02, $02, $02
          !byte $02, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02
          !byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
          !byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
          !byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
room_18:  !byte $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
          !byte $10, $00, $02, $00, $02, $02, $02, $02, $02, $02, $02, $00, $02
          !byte $00, $00, $02, $00, $02, $00, $00, $00, $00, $00, $02, $00, $02
          !byte $00, $02, $02, $00, $02, $00, $0e, $0f, $00, $00, $02, $00, $02
          !byte $00, $02, $00, $00, $02, $02, $02, $02, $02, $00, $02, $00, $02
          !byte $00, $02, $00, $02, $00, $00, $00, $00, $00, $00, $02, $00, $02
          !byte $00, $02, $00, $02, $00, $02, $02, $02, $02, $02, $02, $00, $02
          !byte $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $02
room_tab_lo:        !byte <room_00
                    !byte <room_01
                    !byte <room_02
                    !byte <room_03
                    !byte <room_04
                    !byte <room_05
                    !byte <room_06
                    !byte <room_07
                    !byte <room_08
                    !byte <room_09
                    !byte <room_10
                    !byte <room_11
                    !byte <room_12
                    !byte <room_13
                    !byte <room_14
                    !byte <room_15
                    !byte <room_16
                    !byte <room_17
                    !byte <room_18
room_tab_hi:        !byte >room_00
                    !byte >room_01
                    !byte >room_02
                    !byte >room_03
                    !byte >room_04
                    !byte >room_05
                    !byte >room_06
                    !byte >room_07
                    !byte >room_08
                    !byte >room_09
                    !byte >room_10
                    !byte >room_11
                    !byte >room_12
                    !byte >room_13
                    !byte >room_14
                    !byte >room_15
                    !byte >room_16
                    !byte >room_17
                    !byte >room_18
tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
                    !byte $df, $0c, $15, $1e, $27, $30, $39, $42
                    ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
                    !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a
                    ;     $10
                    !byte $03
tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
                    !byte $00, $39, $19, $0e, $3d, $7f, $2a, $2a
                    ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
                    !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
                    ;     $10
                    !byte $39
                    *= tiles_colors + $01
                    !byte RED+8
                    *= tiles_colors + $02
                    !byte PURPLE+8
                    *= tiles_colors + $0D
                    !byte CYAN+8
                    *= tiles_colors + $10
                    !byte YELLOW+8
