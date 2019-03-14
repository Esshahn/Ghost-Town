; input filename:    gt3ab3.prg
; skip bytes:        2
; ==============================================================================

SILENT_MODE         = 0

; ==============================================================================
; thse settings change the appearance of the game
; EXTENDED = 0 -> original version
; EXTENDED = 1 -> altered version
; ==============================================================================

EXTENDED            = 0       ; 0 = original version, 1 = tweaks and cosmetics

!if EXTENDED = 0{
    COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $12 ; red
    MULTICOLOR_1    = $db
    MULTICOLOR_2    = $29
    BORDER_COLOR_VALUE = $12

}

!if EXTENDED = 1{
    COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $01 ; grey
    MULTICOLOR_1    = $6b
    MULTICOLOR_2    = $19
    BORDER_COLOR_VALUE = $01
}


; ==============================================================================
; cheats
;
;
; ==============================================================================

START_ROOM          = 0             ; default 0
PLAYER_START_POS_X  = 3             ; default 3
PLAYER_START_POS_Y  = 6             ; default 6

; ==============================================================================
; KERNAL / BASIC ROM CALLS

PRINT_KERNAL        = $c56b
BASIC_DA89          = $da89            ; scroll screen down?

; ==============================================================================
; ZEROPAGE

zp02                = $02
zp03                = $03
zp04                = $04
zp05                = $05
zp08                = $08
zp09                = $09
zp0A                = $0A
zp10                = $10
zp11                = $11
zpA7                = $A7
zpA8                = $A8
zpA9                = $A9

; ==============================================================================

code_start          = $3AB3
SCREENRAM           = $0C00            ; PLUS/4 default SCREEN
COLRAM              = $0800            ; PLUS/4 COLOR RAM
CHARSET             = $2000
screen_win_src      = $175C
screen_start_src    = $313C

KEYBOARD_LATCH      = $FF08
INTERRUPT           = $FF09
VOICE1_FREQ_LOW     = $FF0E         ; Low byte of frequency for voice 1
VOICE2_FREQ_LOW     = $FF0F
VOICE2              = $FF10
VOLUME_AND_VOICE_SELECT = $FF11
VOICE1              = $FF12 ; Bit 0-1 : Voice #1 frequency, bits 8 & 9;  Bit 2    : TED data fetch ROM/RAM select; Bits 0-5 : Bit map base address
BG_COLOR            = $FF15
COLOR_1             = $FF16
COLOR_2             = $FF17
COLOR_3             = $FF18
BORDER_COLOR        = $FF19

; ==============================================================================
; INVENTORY
; these are char codes inside the screen data
; if $3692 is a9 it means that the character for the gloves (which is a9 in the charset)
; is still in the level data. If the gloves got picked up, the character is replaced
; by 6b, which is the character for the plant which gets shown instead now
; "df" always stands for an empty cell, therefore something was picked up
; ==============================================================================

INVENTORY_GLOVES    = $3692             ; 6b = gloves
INVENTORY_WIRECUTTER  = $36a3             ; ac = clippers not picked up, f9 clippers picked up
INVENTORY_HAMMER    = $3745             ; d0 = hammer not picked up, df = hammer picked up

; ==============================================================================


                    !cpu 6502

                    *= CHARSET
                    !if EXTENDED {
                        !bin "includes/charset-new-charset.bin"
                    }else{
                        !bin "includes/charset.bin"
                    }

                    *= screen_win_src
                    !bin "includes/screen_win.scr"

                
                    *= screen_start_src
                    !if EXTENDED {
                        !bin "includes/screen_start_extended.scr"
                    }else{
                        !bin "includes/screen_start.scr"
                    }
                    








                                ;  1111111        000000000          000000000          000000000     
                                ; 1::::::1      00:::::::::00      00:::::::::00      00:::::::::00   
                                ;1:::::::1    00:::::::::::::00  00:::::::::::::00  00:::::::::::::00 
                                ;111:::::1   0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
                                ;   1::::1   0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
                                ;   1::::1   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                                ;   1::::1   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                                ;   1::::l   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
                                ;   1::::l   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
                                ;   1::::l   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                                ;   1::::l   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                                ;   1::::l   0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
                                ;111::::::1110:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
                                ;1::::::::::1 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00 
                                ;1::::::::::1   00:::::::::00      00:::::::::00      00:::::::::00   
                                ;111111111111     000000000          000000000          000000000  
                              




                    *= $1000
m1000:
                    jsr PRINT_KERNAL           ; jsr $c56b ? wird gar nicht benutzt ?!

; ==============================================================================
;
; display the hint messages
; ==============================================================================

display_hint_message:

                    lda #>hint_messages
                    sta zpA8
                    lda #<hint_messages
m1009:              cpy #$00
                    beq ++              ; beq $1017
-                   clc
                    adc #$28
                    bcc +               ; bcc $1014
                    inc zpA8
+                   dey
                    bne -               ; bne $100d
++                  sta zpA7
                    jsr set_charset_and_screen_for_title           ; jsr $3a9d
                    ldy #$27
-                   lda (zpA7),y
                    sta SCREENRAM+$1B8,y ; sta $0db8,y
                    lda #$07
                    sta COLRAM+$1B8,y  ; sta $09b8,y
                    dey
                    bne -               ; bne $101e
                    rts
                    !byte $00
; ==============================================================================
                    sta BORDER_COLOR          ; ?!? womöglich unbenutzt ?!?
                    rts
; ==============================================================================
m1031:
                    jsr m11CC           ; jsr $11cc
                    cpy #$03
                    bne m10B1           ; bne $10b1
                    jsr display_hint_message           ; jsr $1003
                    jsr BASIC_DA89      ; ?!? scroll screen down ?!?
                    jsr BASIC_DA89      ; ?!? scroll screen down ?!?
                    ldy #$01
                    jsr display_hint_message           ; jsr $1003
                    ldx #$00
                    ldy #$00
                    beq m105F           ; beq $105f
m104C:              lda SCREENRAM+$1B9,x ; lda $0db9,x
                    clc
                    adc #$80
                    sta SCREENRAM+$1B9,x ; sta $0db9,x
                    lda SCREENRAM+$188,y ; lda $0d88,y
                    clc
                    adc #$80
                    sta SCREENRAM+$188,y ; sta $0d88,y
                    rts

; ==============================================================================
;
;
; ==============================================================================

m105F:              jsr m104C           ; jsr $104c
                    sty zp02
                    stx zp04
                    jsr m10A7           ; jsr $10a7 / wait
                    jsr m104C           ; jsr $104c / some screen stuff
                    jsr m10A7           ; jsr $10a7 / wait
                    lda #$fd           ; KEYBOARD stuff
                    sta KEYBOARD_LATCH          ; .
                    lda KEYBOARD_LATCH          ; .
                    lsr                 ; .
                    lsr
                    lsr
                    bcs +               ; bcs $1081
                    cpx #$00
                    beq +               ; beq $1081
                    dex
+                   lsr
                    bcs +               ; bcs $1089
                    cpx #$25
                    beq +               ; beq $1089
                    inx
+                   and #$08
                    bne m105F           ; bne $105f
                    lda SCREENRAM+$1B9,x ; lda $0db9,x
                    cmp #$bc
                    bne ++              ; bne $109c
                    cpy #$00
                    beq +               ; beq $1099
                    dey
+                   jmp m105F           ; jmp $105f
++                  sta SCREENRAM+$188,y ; sta $0d88,y
                    iny
                    cpy #$05
                    bne m105F           ; bne $105f
                    jmp m10B4           ; jmp $10b4

; ==============================================================================
;
;
; ==============================================================================

m10A7:
                    ldy #$35
                    jsr wait
                    ldy zp02
                    ldx zp04
                    rts

; ==============================================================================
;
;
; ==============================================================================

m10B1:
                    jmp display_hint           ; jmp $1155

; ==============================================================================
;
;
; ==============================================================================

m10B4:
                    ldx #$05
-                   lda SCREENRAM+$187,x ; lda $0d87,x
                    cmp m10CC-1,x       ; cmp $10cb,x
                    bne +               ; bne $10c4
                    dex
                    bne -               ; bne $10b6
                    jmp ++              ; jmp $10d1
+                   ldy #$05
                    jsr display_hint_message           ; jsr $1003
                    jmp m3EF9           ; jmp $3ef9
m10CC:              !byte $30, $36, $31, $33, $38
++                  jsr set_game_basics           ; jsr $3a7d
                    jsr m3A17           ; jsr $3a17
                    jsr draw_empty_column_and_row           ; jsr $3b02
                    jmp m3B4C           ; jmp $3b4c

; ==============================================================================
;
;
; ==============================================================================

item_pickup_message:              ; item pickup messages

!scr " There is a key in the bottle !         "
!scr "   There is a key in the coffin !       "
!scr " There is a breathing tube !            "





                                    ;  1111111      1111111   555555555555555555 555555555555555555 
                                    ; 1::::::1     1::::::1   5::::::::::::::::5 5::::::::::::::::5 
                                    ;1:::::::1    1:::::::1   5::::::::::::::::5 5::::::::::::::::5 
                                    ;111:::::1    111:::::1   5:::::555555555555 5:::::555555555555 
                                    ;   1::::1       1::::1   5:::::5            5:::::5            
                                    ;   1::::1       1::::1   5:::::5            5:::::5            
                                    ;   1::::1       1::::1   5:::::5555555555   5:::::5555555555   
                                    ;   1::::l       1::::l   5:::::::::::::::5  5:::::::::::::::5  
                                    ;   1::::l       1::::l   555555555555:::::5 555555555555:::::5 
                                    ;   1::::l       1::::l               5:::::5            5:::::5
                                    ;   1::::l       1::::l               5:::::5            5:::::5
                                    ;   1::::l       1::::l   5555555     5:::::55555555     5:::::5
                                    ;111::::::111 111::::::1115::::::55555::::::55::::::55555::::::5
                                    ;1::::::::::1 1::::::::::1 55:::::::::::::55  55:::::::::::::55 
                                    ;1::::::::::1 1::::::::::1   55:::::::::55      55:::::::::55   
                                    ;111111111111 111111111111     555555555          555555555   








; ==============================================================================
;
; hint system (question marks)
; ==============================================================================

                    *= $1155
display_hint:       
                    cpy #$00
                    bne m11A2           ; bne $11a2
                    jsr m1000
                    ldx m3050 + 1
                    cpx #$01
                    bne +               ; bne $1165
                    lda #$28
+                   cpx #$05
                    bne +               ; bne $116b
                    lda #$29
+                   cpx #$0a
                    bne +               ; bne $1171
                    lda #$47
+                   nop
                    nop
                    nop
                    jsr m174F           ; jsr $174f
                    cpx #$0f
                    bne +               ; bne $1185
                    lda #$45
                    sta COLRAM + $26f       ; sta $0a6f
                    lda #$0f
                    sta SCREENRAM + $26f       ; sta $0e6f
+                   sta SCREENRAM + $21f       ; sta $0e1f
                    lda #$48
                    sta COLRAM + $21f       ; sta $0a1f
-                   lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
                    and #$80
                    bne -               ; bne $118d
                    jsr set_game_basics           ; jsr $3a7d
                    jsr m3A2D           ; jsr $3a2d
                    jmp m3B4C           ; jmp $3b4c
m11A2:              cpy #$02
                    bne +               ; bne $11ac
m11A6:              jsr m1000
                    jmp -               ; jmp $118d
+                   cpy #$04
                    bne +               ; bne $11bb
                    lda m3952 + 1       ; lda $3953
                    clc
                    adc #$40            ; this is the helping letter
                    sta $3fc6           ; this value seems to be never read anywhere
                    bne m11A6               ; bne $11a6
+                   dey
                    dey
                    dey
                    dey
                    dey
                    lda #$10
                    sta zpA8
                    lda #$dd
                    jsr m1009
                    jmp -
; ==============================================================================
m11CC:
                    jsr set_charset_and_screen_for_title           ; jsr $3a9d
                    jmp PRINT_KERNAL           ; jmp $c56b
; ==============================================================================

                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
check_death:
                    jsr m3846
                    jmp m3B4C           ; jmp $3b4c

; ==============================================================================

m11E0:              ldx #$00
-                   lda $033c,x
                    cmp #$1e            ; question mark 
                    bcc m11ED           ; bcc $11ed
                    cmp #$df
                    bne ++              ; bne $11f5
m11ED:              inx
                    cpx #$09
                    bne -               ; bne $11e2
-                   jmp m3B4C           ; jmp $3b4c
++                  ldy m3050 + 1
                    bne +               ; bne $120a
                    cmp #$a9            ; egg plant gloves ;)
                    bne m11ED
                    lda #$df
                    cmp $36d7
m1203:              bne -               ; bne $11f2
                    jsr m2FC0
                    bne check_death     ; bne $11da
+                   cpy #$01
                    bne m124B           ; bne $124b
                    cmp #$e0            ; empty character in charset
                    beq +               ; beq $1216
                    cmp #$e1
                    bne ++              ; bne $122a
+                   lda #$aa
                    sta $369a
                    jsr m3846
                    ldy #$f0
                    jsr wait
                    lda #$df
                    sta $369a
                    bne check_death     ; bne $11da
++                  cmp #$27            ; part of a bush
                    bcs check_death_bush
                    ldy #$00
                    jmp m1031           ; jmp $1031

; ==============================================================================
check_death_bush:                 ; $1233
                    cmp #$ad                ; wirecutters
                    bne m11ED
                    lda INVENTORY_GLOVES           ; inventory place for the gloves! 6b = gloves
                    cmp #$6b
                    beq +                   ; beq $1243
                    ldy #$0f
                    jmp death         ; 0f You were wounded by the bush!

; ==============================================================================
;$1243
+                   lda #$f9                ; wirecutter picked up
                    sta INVENTORY_WIRECUTTER
                    jmp check_death

; ==============================================================================


m124B:              
                    cpy #$02
                    bne m12A5           ; bne $12a5
                    cmp #$f5        ; f5 = fence character
                    bne +           ;bne $1267
                    lda INVENTORY_WIRECUTTER       ; fence was hit, so check if clippers are picked up
                    cmp #$f9        ; f9 = wirecutters were picked up
                    beq m125F           ;beq $125f
                    ldy #$10
                    jmp death     ; 10 You are trapped in wire-nettings!

; ==============================================================================
m125F:
                    lda #$df
                    sta $3901
                    jmp check_death

; ==============================================================================
;$1267
m1267:
+                   cmp #$a6            ; lock
                    bne $1279
                    lda $369a
                    cmp #$df
                    bne $1264
                    lda #$df
                    sta $36c2
                    bne $1264
                    cmp #$b1            ; ladder
                    bne $1287
                    lda #$df
                    sta $36d7
                    sta $36e2
                    bne $1264
                    cmp #$b9            ; bottle
                    beq $128e
                    jmp m11ED
                    lda INVENTORY_HAMMER
                    cmp #$df            ; df = empty spot where the hammer was. = hammer taken
                    beq $129a
                    ldy #$03
                    jmp death        ; 03 You drank from the poisend bottle

; ==============================================================================

m129A:              lda #$01
                    sta $12a4
                    ldy #$05
                    jmp m1031           ; jmp $1031

; ==============================================================================

m12A4:              !byte $00
; ==============================================================================
m12A5:              cpy #$03
                    bne $12b5
                    cmp #$27            ; part of a bush
                    bcs $12b2
                    ldy #$04
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    jmp m3B4C           ; jmp $3b4c
; ==============================================================================
                    cpy #$04
                    bne $12db
                    cmp #$3b            ; part of a coffin
                    beq $12c1
                    cmp #$42
                    bne $12c6
                    ldy #$0d
                    jmp death    ; 0d You found a thirsty zombie....

; ==============================================================================

                    cmp #$f7
                    beq $12d1
                    cmp #$f8
                    beq $12d1
                    jmp m11ED
                    lda #$00
                    sta $394b
                    ldy #$06
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cpy #$05
                    bne $12f9
                    cmp #$27            ; part of a bush
                    bcs $12e8
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cmp #$fd
                    beq $12ef
                    jmp m11ED
                    lda #$00
                    jmp m2FDF

; ==============================================================================

m12f4:              ldy #$07
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cpy #$06
                    bne $1306
                    cmp #$f6            ; is it a trapped door?
                    bne $12ec
                    ldy #$00
                    jmp death    ; 00 You fell into a snake pit

; ==============================================================================
sacred_column:
                    cpy #$07
                    bne $133e
                    cmp #$e3            ; $e3 is the char for the invisible, I mean SACRED, column
                    bne $1312
                    ldy #$01            ; 01 You'd better watched out for the sacred column
                    bne $1303
                    cmp #$5f            ; water?
                    bne $12ec
                    lda #$bc            ; light picked up
                    sta $36fe           ; but I dont understand how the whole light is shown
                    lda #$5f
                    sta $36fc
                    jsr m3846
                    ldy #$ff
                    jsr wait
                    jsr wait
                    jsr wait
                    jsr wait
                    lda #$df
                    sta $36fe
                    lda #$00
                    sta $36fc
                    jmp check_death

; ==============================================================================

                    cpy #$08
                    bne $1396
                    ldy #$00
                    sty zpA7
                    cmp #$4b            ; water
                    bne $135f
                    ldy $3994
                    bne $1366
                    jsr m3602
                    lda #$18
                    sta m35A3 + 3
                    lda #$0c
                    sta m35A3 + 1
                    jmp m3B4C           ; jmp $3b4c

; ==============================================================================
check_item_water:
                    cmp #$56        ; water character
                    bne $1374
                    ldy $3994
                    bne $136f
                    jsr m3602
                    lda #$0c
                    bne $1354
                    ldy #$02
                    jmp death       ; 02 You drowned in the deep river

; ==============================================================================
check_item_shovel:
                    cmp #$c1            ; shovel
                    beq $137c
                    cmp #$c3            ; shovel
                    bne $1384
                    lda #$df
                    sta $3720
                    jmp check_death

; ==============================================================================


                    cmp #$cb
                    bne m13B0
                    lda INVENTORY_HAMMER
                    cmp #$df
                    bne $135c
                    lda #$df
                    sta $370e
                    bne $1381
                    cpy #$09
                    bne $13a3
                    cmp #$27
                    bcs m13B0
                    ldy #$02
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cpy #$0a
                    bne $13d2
                    cmp #$27
                    bcs $13b3
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
m13B0:              jmp m11ED

; ==============================================================================

                    cmp #$cc
                    beq $13bb
                    cmp #$cf
                    bne m13B0
                    lda #$df
                    cmp $36fe
                    bne m13CD           ; bne $13cd
                    cmp $3752
                    bne m13CD           ; bne $13cd
                    sta $3736
                    jmp check_death

; ==============================================================================
; death by 240 volts

m13CD:
                    ldy #$06
                    jmp death    ; 06 240 Volts! You got an electrical shock!

; ==============================================================================

                    cpy #$0b
                    bne $13e1
                    cmp #$d1
                    bne m13B0
                    lda #$df                ; player takes the hammer
                    sta INVENTORY_HAMMER
                    bne $13ca
                    cpy #$0c
                    bne $13fd
                    cmp #$27
                    bcs $13ee
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cmp #$d2
                    beq $13f6
                    cmp #$d5
                    bne m13B0
                    lda #$df
                    sta $3752
                    bne $13ca
                    cpy #$0d
                    bne $1421
                    cmp #$27
                    bcs $140a
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cmp #$d6
                    bne m13B0
                    lda $370e
                    cmp #$df
                    beq $141a
                    ldy #$07
                    jmp death    ; 07 You stepped on a nail!

; ==============================================================================

                    lda #$e2
                    sta $375f
                    bne $13ca
                    cpy #$0e
                    bne $142e
                    cmp #$d7
                    bne m13B0
                    ldy #$08
                    jmp death    ; 08 A foot trap stopped you!

; ==============================================================================

                    cpy #$0f
                    bne $143e
                    cmp #$27
                    bcs $143b
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    jmp m13B0
; ==============================================================================
                    cpy #$10
                    bne $1464
                    cmp #$f4
                    bne $144b
                    ldy #$0a
                    jmp death    ; 0a You were locked in and starved!

; ==============================================================================

                    cmp #$d9
                    beq $1453
                    cmp #$db
                    bne $1457
                    ldy #$09          ; 09 This room is doomed by the wizard Manilo!
                    bne $1448
                    cmp #$b8
                    beq $145f
                    cmp #$bb
                    bne $143b
                    ldy #$03
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cpy #$11
                    bne $1474
                    cmp #$dd
                    bne $143b
                    lda #$df
                    sta $3831
                    jmp check_death

; ==============================================================================


                    cmp #$81
                    bcs $147b
                    jmp check_death

                    jmp m1B8F


; ==============================================================================

m147E:              ldy m3050 + 1
                    cpy #$0e
                    bne $148a
                    ldy #$20
                    jmp wait

; ==============================================================================

                    cpy #$0f
                    bne $14c8
                    lda #$00
                    sta zpA7
                    ldy #$0c
                    ldx #$06
                    jsr m3608
                    lda #$eb
                    sta zpA8
                    lda #$39
                    sta zp0A
                    ldx $1495
                    lda #$01
                    bne $14b2
                    cpx #$06
                    bne $14ae
                    lda #$01
                    dex
                    jmp +                   ; jmp $14b9

; ==============================================================================

                    cpx #$0b
                    bne $14b8
                    lda #$00
                    inx
+                   stx $1495
                    sta $14a5
                    lda #$01
                    sta zpA7
                    ldy #$0c
                    jmp m3608

; ==============================================================================

                    cpy #$11
                    bne $14d3
                    lda #$01
                    beq $14e4
                    jmp m15C1                   ;jmp $15c1
                    lda #$0f
                    sta $3625
                    sta $3627
                    cpy #$0a
                    bne $1523
                    dec $2fbf
                    beq $14e5
                    rts

; ==============================================================================
;
;
; ==============================================================================

                    ldy #$08
                    sty $2fbf
                    lda #$09
                    sta zp05
                    lda #$0d
                    sta zp03
                    lda #$7b
                    sta zp02
                    sta zp04
                    lda #$df
                    cmp $1507
                    bne $1501
                    lda #$d8
                    sta $1507
                    ldx #$06
                    lda #$df
                    ldy #$00
                    sta (zp02),y
                    lda #$ee
                    sta (zp04),y
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc $151f
                    inc zp03
                    inc zp05
                    dex
                    bne $1506
                    rts

; ==============================================================================
;
;
; ==============================================================================

                    cpy #$09
                    bne $1522
                    nop
                    jmp m15AD               ; jmp $15ad

; ==============================================================================
m152B:
                    lda #$0c
                    sta zp03
                    lda #$0f
                    sta zp02
                    sta zp04
                    ldx #$06
                    lda #$00
                    bne $1544
                    dex
                    cpx #$02
                    bne $154b
                    lda #$01
                    bne $154b
                    inx
                    cpx #$07
                    bne $154b
                    lda #$00
                    sta $1538
                    stx $1536
                    ldy #$00
                    lda #$df
                    sta (zp02),y
                    iny
                    iny
                    sta (zp02),y
                    dey
                    lda #$ea
                    sta (zp02),y
                    sta (zp04),y
                    jsr $159d
                    dex
                    bne $1551
                    lda #$e4
                    sta zpA8
                    ldx #$02
                    ldy #$00
                    lda zpA8
                    sta (zp02),y
                    lda #$da
                    sta (zp04),y
                    inc zpA8
                    iny
                    cpy #$03
                    bne $1570
                    jsr $159d
                    dex
                    bne $156e
                    ldy #$00
                    lda #$e7
                    sta zpA8
                    lda (zp02),y
                    cmp zpA8
                    bne $1595
                    lda #$df
                    sta (zp02),y
                    inc zpA8
                    iny
                    cpy #$03
                    bne $158b
                    rts

; ==============================================================================
;
;
; ==============================================================================

                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc $15ac
                    inc zp03
                    inc zp05
                    rts

; ==============================================================================
;
;
; ==============================================================================

m15AD:              ldx #$01
                    cpx #$01
                    bne $15b7
                    dec $15ae
                    rts

; ==============================================================================
;
;
; ==============================================================================

                    inc $15ae
                    lda #$08
                    sta zp05
                    jmp m152B           ; jmp $152b

; ==============================================================================

m15C1:              lda #$00
                    cmp #$00
                    bne $15cb
                    inc $15c2
                    rts

; ==============================================================================
;
;
; ==============================================================================

                    dec $15c2
                    jmp m3620

; ==============================================================================

m15D1:              lda $3736
                    cmp #$df
                    bne $15dd
                    lda #$59
                    sta $37b6
                    lda m3050 + 1
                    cmp #$11
                    bne $162a
                    lda $14cd
                    bne $15fc
                    lda m35A3 + 1
                    cmp #$06
                    bne $15fc
                    lda m35A3 + 3
                    cmp #$18
                    bne $15fc
                    lda #$00
                    sta $15fd
                    lda #$01
                    bne $1616
                    ldy #$06
                    ldx #$1e
                    lda #$00
                    sta zpA7
                    jsr m3608
                    ldx $1603
                    cpx #$03
                    beq $1613
                    dex
                    stx $1603
                    lda #$78
                    sta zpA8
                    lda #$49
                    sta zp0A
                    ldy #$06
                    lda #$01
                    sta zpA7
                    ldx $1603
                    jsr m3608
                    jmp m147E                   ; jmp $147e

; ==============================================================================
m162d:
                    ldx #$09
-                   lda $033b,x              ; cassette tape buffer
                    sta $034b,x              ; cassette tape buffer
                    dex
                    bne -                       ; bne $162f
                    lda #$02
                    sta zpA7
                    ldx m35A3 + 3
                    ldy m35A3 + 1
                    jsr m3608
                    ldx #$09
                    lda $033b,x              ; cassette tape buffer
                    cmp #$d8
                    bne +                   ; bne $1653
                    ldy #$05
                    jmp death               ; 05 Didn't you see the laser beam?

; ==============================================================================

+                   ldy m3050 + 1
                    cpy #$11
                    bne $166a
                    cmp #$78
                    beq $1666
                    cmp #$7b
                    beq $1666
                    cmp #$7e
                    bne $166a
                    ldy #$0b                      ; 0b You were hit by a big rock and died!
                    bne $1650
                    cmp #$9c
                    bcc $1676
                    cmp #$a5
                    bcs $1676
                    jmp m16A7                 ; jmp $16a7
m1675:              nop
                    cmp #$e4
                    bcc $168a
                    cmp #$eb
                    bcs $1682
                    ldy #$04                        ; 04 Boris the spider got you and killed you
                    bne $1650
                    cmp #$f4
                    bcs $168a
                    ldy #$0e                      ; 0e The monster grabbed you you. You are dead!
                    bne $1650
                    dex
                    bne $1647
                    ldx #$09
                    lda $034b,x
                    sta $033b,x
                    cmp #$d8
                    beq $164e
                    cmp #$e4
                    bcc $16a1
                    cmp #$ea
                    bcc $167e
                    dex
                    bne $168f
                    jmp m11E0                     ; jmp $11e0
m16A7:
                    ldy $3831
                    cpy #$df
                    beq $16b2
                    ldy #$0c                      ; 0c Belegro killed you!
                    bne $1650
                    ldy #$00
                    sty $14cd
                    jmp m1675                       ; jmp $1675

; ==============================================================================
; this might be the inventory/ world reset
; puts all items into the level data again
; maybe not. not all characters for e.g. the wirecutter is put back
; addresses are mostly within items.asm address space
; ==============================================================================
m16BA:
                    lda #$a5                        ; $a5 = the door of the shed where the ladder is
                    sta $36c2
                    lda #$a9                        ; a9 = NO gloves
                    sta $3692                       ; inventory gloves
                    lda #$79
                    sta $3690
                    lda #$e0                        ; empty char
                    sta $369a
                    lda #$ac                        ; wirecutter
                    sta $36a3
                    lda #$b8                        ; part of the bottle - hmmm...
                    sta $36b3
                    lda #$b0                        ; the ladder
                    sta $36d7
                    lda #$b5                        ; more ladder
                    sta $36e2
                    lda #$5e                        ; seems to be water?
                    sta $36fe
                    lda #$c6                        ; boots in the whatever box
                    sta $370e
                    lda #$c0                        ; not sure
                    sta $3720
                    lda #$cc                        ; power outlet
                    sta $3736
                    lda #$d0                        ; the hammer
                    sta $3745
                    lda #$d2                        ; unsure
                    sta $3752
                    lda #$d6                        ; unsure
                    sta $375f
                    lda #$00                        ; door
                    sta $37b6
                    lda #$dd                        ; unsure
                    sta $3831
                    lda #$01                        ; door
                    sta $394b
                    lda #$01                        ; door
                    sta $3994
                    lda #$f5                        ; fence
                    sta $3901
                    lda #$00                        ; door
                    sta $12a4
                    lda #$01                        ; door
                    sta $15fd
                    lda #$1e
                    sta $1603
                    lda #$01
                    sta $14cd
                    ldx #$05
                    cpx #$07
                    bne $173a
                    ldx #$ff
                    inx
                    stx $1733
                    lda $1747,x
                    sta $3953
                    jmp print_title     ; jmp $310d



!source "main-converted.asm"