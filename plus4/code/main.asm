; ==============================================================================
;
;  ▄████  ██░ ██  ▒█████    ██████ ▄▄▄█████▓   ▄▄▄█████▓ ▒█████   █     █░███▄    █ 
; ██▒ ▀█▒▓██░ ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒   ▓  ██▒ ▓▒▒██▒  ██▒▓█░ █ ░█░██ ▀█   █ 
;▒██░▄▄▄░▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░   ▒ ▓██░ ▒░▒██░  ██▒▒█░ █ ░█▓██  ▀█ ██▒
;░▓█  ██▓░▓█ ░██ ▒██   ██░  ▒   ██▒░ ▓██▓ ░    ░ ▓██▓ ░ ▒██   ██░░█░ █ ░█▓██▒  ▐▌██▒
;░▒▓███▀▒░▓█▒░██▓░ ████▓▒░▒██████▒▒  ▒██▒ ░      ▒██▒ ░ ░ ████▓▒░░░██▒██▓▒██░   ▓██░
; ░▒   ▒  ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░        ▒ ░░   ░ ▒░▒░▒░ ░ ▓░▒ ▒ ░ ▒░   ▒ ▒ 
;  ░   ░  ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░           ░      ░ ▒ ▒░   ▒ ░ ░ ░ ░░   ░ ▒░
;░ ░   ░  ░  ░░ ░░ ░ ░ ▒  ░  ░  ░    ░           ░      ░ ░ ░ ▒    ░   ░    ░   ░ ░ 
;      ░  ░  ░  ░    ░ ░        ░                           ░ ░      ░            ░ 
;                                                                                   
;
; Ghost Town, Commodore 16 Version
; Disassembled by awsm & spider j of Mayday in 2019
;
; ==============================================================================

; ==============================================================================
; language
; ENGLISH and GERMAN are available
; OPTIONS: EN / DE
; ==============================================================================

EN = 0
DE = 1

LANGUAGE = DE 

; ==============================================================================
; thse settings change the appearance of the game
; EXTENDED = 0 -> original version
; EXTENDED = 1 -> altered version
; ==============================================================================

EXTENDED            = 0       ; 0 = original version, 1 = tweaks and cosmetics

!if EXTENDED = 0{
    COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $12 ; red
    MULTICOLOR_1        = $db
    MULTICOLOR_2        = $29
    BORDER_COLOR_VALUE  = $12
    TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    TITLE_KEY           = $01

}

!if EXTENDED = 1{
    COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $01 ; grey
    MULTICOLOR_1        = $6b
    MULTICOLOR_2        = $19
    BORDER_COLOR_VALUE  = $01
    TITLE_KEY_MATRIX    = $7f           ; Extended version key to press on title screen: space
    TITLE_KEY           = $10
}


; ==============================================================================
; cheats
;
;
; ==============================================================================

START_ROOM          = 0             ; default 0 ; address $3b45
PLAYER_START_POS_X  = 3             ; default 3
PLAYER_START_POS_Y  = 6             ; default 6
SILENT_MODE         = 0

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

TAPE_BUFFER         = $0333
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
CHAR_BASE_ADDRESS   = $FF13
BG_COLOR            = $FF15
COLOR_1             = $FF16
COLOR_2             = $FF17
COLOR_3             = $FF18
BORDER_COLOR        = $FF19

; ==============================================================================


                    !cpu 6502

                    *= CHARSET
                    !if EXTENDED {
                        !bin "includes/charset-new-charset.bin"
                    }else{
                        !bin "includes/charset.bin"
                    }

                    *= screen_win_src
                    !if LANGUAGE = EN{
                        !bin "includes/screen-win-en.scr"
                    }
                    !if LANGUAGE = DE{
                        !bin "includes/screen-win-de.scr"
                    }
                
                    *= screen_start_src
                    !if EXTENDED {
                        !bin "includes/screen-start-extended.scr"
                    }else{
                        !bin "includes/screen-start.scr"
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

!if LANGUAGE = EN{
!scr " There is a key in the bottle !         "
!scr "   There is a key in the coffin !       "
!scr " There is a breathing tube !            "
}

!if LANGUAGE = DE{
!scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
!scr "    In dem Sarg lag ein Schluessel !    "
!scr " Unter dem Stein lag ein Taucheranzug ! "
}


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
+                   jsr m174F           ; jsr $174f
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
                    sta helping_letter          ; sta $3fc6          
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

check_death:
                    jsr m3846
                    jmp m3B4C           ; jmp $3b4c

; ==============================================================================

m11E0:              ldx #$00
-                   lda TAPE_BUFFER + $9,x              ;  lda $033c,x
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
                    cmp items + $4d                        ; cmp $36d7
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
                    sta items + $10                        ; sta $369a
                    jsr m3846
                    ldy #$f0
                    jsr wait
                    lda #$df
                    sta items + $10                        ; sta $369a
                    bne check_death     ; bne $11da
++                  cmp #$27            ; part of a bush
                    bcs check_death_bush
                    ldy #$00
                    jmp m1031           ; jmp $1031

; ==============================================================================
check_death_bush:                 ; $1233
                    cmp #$ad                ; wirecutters
                    bne m11ED
                    lda items + $8           ; inventory place for the gloves! 6b = gloves
                    cmp #$6b
                    beq +                   ; beq $1243
                    ldy #$0f
                    jmp death         ; 0f You were wounded by the bush!

; ==============================================================================
;$1243
+                   lda #$f9                ; wirecutter picked up
                    sta items + $19
                    jmp check_death

; ==============================================================================


m124B:              
                    cpy #$02
                    bne m12A5           ; bne $12a5
                    cmp #$f5        ; f5 = fence character
                    bne +           ;bne $1267
                    lda items + $19      ; fence was hit, so check if wirecuter was picked up
                    cmp #$f9        ; f9 = wirecutters were picked up
                    beq m125F           ;beq $125f
                    ldy #$10
                    jmp death     ; 10 You are trapped in wire-nettings!

; ==============================================================================
m125F:
                    lda #$df
                    sta m3900 + 1                           ; sta $3901
m1264:              jmp check_death

; ==============================================================================
;$1267
m1267:
+                   cmp #$a6            ; lock
                    bne +                                   ; bne $1279
                    lda items + $10                        ; lda $369a
                    cmp #$df
                    bne m1264                               ; bne $1264
                    lda #$df
                    sta items + $38                        ; sta $36c2
                    bne m1264                               ; bne $1264
+                   cmp #$b1            ; ladder
                    bne +                                   ; bne $1287
                    lda #$df
                    sta items + $4d                        ; sta $36d7
                    sta items + $58                        ; sta $36e2
                    bne m1264                               ; bne $1264
+                   cmp #$b9            ; bottle
                    beq +                                   ; beq $128e
                    jmp m11ED
+                   lda items + $bb
                    cmp #$df            ; df = empty spot where the hammer was. = hammer taken
                    beq m129A                                   ; beq $129a
                    ldy #$03
                    jmp death        ; 03 You drank from the poisend bottle


; ==============================================================================

m129A: 
                    lda #$01
                    sta m12A4                                   ; sta $12a4
                    ldy #$05
                    jmp m1031           ; jmp $1031

; ==============================================================================

m12A4:              !byte $00
; ==============================================================================
m12A5:              cpy #$03
                    bne m12B5                                   ; bne $12b5
                    cmp #$27            ; part of a bush
                    bcs m12B2                                   ; bcs $12b2
                    ldy #$04
                    jmp m1031           ; jmp $1031
; ==============================================================================
m12B2:              jmp m3B4C           ; jmp $3b4c
; ==============================================================================
m12B5:
                    cpy #$04
                    bne m12DB                               ; bne $12db
                    cmp #$3b            ; part of a coffin
                    beq +                                   ; beq $12c1
                    cmp #$42
                    bne m12C6                               ; bne $12c6
+                   ldy #$0d
                    jmp death    ; 0d You found a thirsty zombie....

; ==============================================================================
m12C6:
                    cmp #$f7
                    beq +                                       ; beq $12d1
                    cmp #$f8
                    beq +                                       ; beq $12d1
                    jmp m11ED
+                   lda #$00
                    sta m394A + 1                               ; sta $394b
                    ldy #$06
                    jmp m1031           ; jmp $1031
; ==============================================================================
m12DB:
                    cpy #$05
                    bne m12F9                                   ; bne $12f9
                    cmp #$27            ; part of a bush
                    bcs m12E8                                   ; bcs $12e8
                    ldy #$00
                    jmp m1031           ; jmp $1031


; ==============================================================================
m12E8:
                    cmp #$fd
                    beq +                                   ; beq $12ef
m12EC:              jmp m11ED
+                   lda #$00
                    jmp m2FDF

; ==============================================================================

m12F4:              ldy #$07
                    jmp m1031           ; jmp $1031
; ==============================================================================
m12F9:
                    cpy #$06
                    bne sacred_column                       ; bne $1306
                    cmp #$f6            ; is it a trapped door?
                    bne m12EC                               ; bne $12ec
                    ldy #$00
m1303:              jmp death    ; 00 You fell into a snake pit

; ==============================================================================
sacred_column:
                    cpy #$07
                    bne m133E                               ; bne $133e
                    cmp #$e3            ; $e3 is the char for the invisible, I mean SACRED, column
                    bne +                                   ; bne $1312
                    ldy #$01            ; 01 You'd better watched out for the sacred column
                    bne m1303                               ; bne $1303
+                   cmp #$5f            ; water?
                    bne m12EC                               ; bne $12ec
                    lda #$bc            ; light picked up
                    sta items + $74                        ; sta $36fe           ; but I dont understand how the whole light is shown
                    lda #$5f
                    sta items + $72                        ; sta $36fc
                    jsr m3846
                    ldy #$ff
                    jsr wait
                    jsr wait
                    jsr wait
                    jsr wait
                    lda #$df
                    sta items + $74                        ; sta $36fe
                    lda #$00
                    sta items + $72                        ; sta $36fc
                    jmp check_death

; ==============================================================================
m133E:
                    cpy #$08
                    bne m1396                               ; bne $1396
                    ldy #$00
                    sty zpA7
                    cmp #$4b            ; water
                    bne check_item_water                    ; bne $135f
                    ldy m3993 + 1                           ; ldy $3994
                    bne m1366                               ; bne $1366
                    jsr m3602
                    lda #$18
m1354:              sta m35A3 + 3
                    lda #$0c
                    sta m35A3 + 1
m135C:              jmp m3B4C           ; jmp $3b4c


; ==============================================================================
check_item_water:
                    cmp #$56        ; water character
                    bne check_item_shovel                   ; bne $1374
                    ldy m3993 + 1                           ; ldy $3994
m1366:              bne +                                   ; bne $136f
                    jsr m3602
                    lda #$0c
                    bne m1354                               ; bne $1354
+                   ldy #$02
                    jmp death       ; 02 You drowned in the deep river

; ==============================================================================
check_item_shovel:
                    cmp #$c1            ; shovel
                    beq +                                   ; beq $137c
                    cmp #$c3            ; shovel
                    bne m1384                               ; bne $1384
+                   lda #$df
                    sta items + $96                        ; sta $3720
m1381:              jmp check_death

; ==============================================================================

m1384:
                    cmp #$cb
                    bne m13B0
                    lda items + $bb                         ; hammer
                    cmp #$df
                    bne m135C                               ; bne $135c
                    lda #$df
                    sta items + $84                        ; sta $370e
                    bne m1381                               ; bne $1381
m1396:              cpy #$09
                    bne m13A3                               ; bne $13a3
                    cmp #$27
                    bcs m13B0
                    ldy #$02
                    jmp m1031           ; jmp $1031

; ==============================================================================
m13A3:
                    cpy #$0a
                    bne m13D2                               ; bne $13d2
                    cmp #$27
                    bcs m13B3                               ; bcs $13b3
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
m13B0:              jmp m11ED

; ==============================================================================
m13B3:
                    cmp #$cc
                    beq +                                   ; beq $13bb
                    cmp #$cf
                    bne m13B0
+                   lda #$df
                    cmp items + $74                        ; cmp $36fe
                    bne m13CD           ; bne $13cd
                    cmp items + $c8                        ; cmp $3752
                    bne m13CD           ; bne $13cd
                    sta items + $ac                        ; sta $3736
m13CA:              jmp check_death

; ==============================================================================
; death by 240 volts

m13CD:
                    ldy #$06
                    jmp death    ; 06 240 Volts! You got an electrical shock!

; ==============================================================================
m13D2:
                    cpy #$0b
                    bne +                                   ; bne $13e1
                    cmp #$d1
                    bne m13B0
                    lda #$df                ; player takes the hammer
                    sta items + $bb                         ; hammer
                    bne m13CA                               ; bne $13ca
+                   cpy #$0c
                    bne m13FD                               ; bne $13fd
                    cmp #$27
                    bcs m13EE                               ; bcs $13ee
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
m13EE:
                    cmp #$d2
                    beq +                                   ; beq $13f6
                    cmp #$d5
                    bne m13B0
+                   lda #$df
                    sta items + $c8                        ; sta $3752
                    bne m13CA                               ; bne $13ca
m13FD:              cpy #$0d
                    bne m1421                               ; bne $1421
                    cmp #$27
                    bcs m140A                               ; bcs $140a
                    ldy #$00
                    jmp m1031           ; jmp $1031

; ==============================================================================
m140A:
                    cmp #$d6
                    bne m13B0
                    lda items + $84                        ; lda $370e
                    cmp #$df
                    beq m141A                               ; beq $141a
                    ldy #$07
                    jmp death    ; 07 You stepped on a nail!

; ==============================================================================
m141A:
                    lda #$e2
                    sta items + $d5                        ; sta $375f
                    bne m13CA                               ; bne $13ca
m1421:              cpy #$0e
                    bne m142E                               ; bne $142e
                    cmp #$d7
                    bne m13B0
                    ldy #$08
                    jmp death    ; 08 A foot trap stopped you!

; ==============================================================================

m142E:
                    cpy #$0f
                    bne m143E                               ; bne $143e
                    cmp #$27
                    bcs m143B                               ; bcs $143b
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
m143B:                  
                    jmp m13B0
; ==============================================================================
m143E:
                    cpy #$10
                    bne m1464                               ; bne $1464
                    cmp #$f4
                    bne m144B                               ; bne $144b
                    ldy #$0a
m1448:              jmp death    ; 0a You were locked in and starved!

; ==============================================================================

m144B:
                    cmp #$d9
                    beq +                                   ; beq $1453
                    cmp #$db
                    bne ++                                  ; bne $1457
+                   ldy #$09          ; 09 This room is doomed by the wizard Manilo!
                    bne m1448                               ; bne $1448
++                  cmp #$b8
                    beq +                                   ; beq $145f
                    cmp #$bb
                    bne m143B                               ; bne $143b
+                   ldy #$03
                    jmp m1031           ; jmp $1031

; ==============================================================================

m1464:
                    cpy #$11
                    bne m1474                               ; bne $1474
                    cmp #$dd
                    bne m143B                               ; bne $143b
                    lda #$df
                    sta items + $1a7                        ; sta $3831
                    jmp check_death


; ==============================================================================


m1474:              cmp #$81
                    bcs +                   ; bcs $147b
                    jmp check_death

+                   jmp m1B8F


; ==============================================================================

m147E:              ldy m3050 + 1
                    cpy #$0e
                    bne m148A               ; bne $148a
                    ldy #$20
                    jmp wait

; ==============================================================================

m148A:              cpy #$0f
                    bne m14C8               ; bne $14c8
                    lda #$00
                    sta zpA7
                    ldy #$0c
m1494:              ldx #$06
                    jsr m3608
                    lda #$eb
                    sta zpA8
                    lda #$39
                    sta zp0A
                    ldx m1494 + 1           ; ldx $1495
m14A4:              lda #$01
                    bne m14B2               ; bne $14b2
                    cpx #$06
                    bne +                   ; bne $14ae
                    lda #$01
+                   dex
                    jmp +                   ; jmp $14b9


; ==============================================================================

m14B2:              cpx #$0b
                    bne ++                              ; bne $14b8
                    lda #$00
++                  inx
+                   stx m1494 + 1                       ; stx $1495
                    sta m14A4 + 1                       ; sta $14a5
                    lda #$01
                    sta zpA7
                    ldy #$0c
                    jmp m3608

; ==============================================================================

m14C8:              cpy #$11
                    bne +                               ; bne $14d3
m14CC:              lda #$01
                    beq ++                              ; beq $14e4
                    jmp m15C1                           ; jmp $15c1
+                   lda #$0f
                    sta m3624 + 1                       ; sta $3625
                    sta m3626 + 1                       ; sta $3627
                    cpy #$0a
                    bne m1523                           ; bne $1523
                    dec m2FBF                           ; dec $2fbf
                    beq m14E5                           ; beq $14e5
++                  rts


; ==============================================================================
;
;
; ==============================================================================

m14E5:              ldy #$08
                    sty m2FBF                           ; sty $2fbf
                    lda #$09
                    sta zp05
                    lda #$0d
                    sta zp03
                    lda #$7b
                    sta zp02
                    sta zp04
                    lda #$df
                    cmp m1506 + 1                       ; cmp $1507
                    bne +                               ; bne $1501
                    lda #$d8
+                   sta m1506 + 1                       ; sta $1507
                    ldx #$06
m1506:              lda #$df
                    ldy #$00
                    sta (zp02),y
                    lda #$ee
                    sta (zp04),y
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc +                               ; bcc $151f
                    inc zp03
                    inc zp05
+                   dex
                    bne m1506                           ; bne $1506
-                   rts


; ==============================================================================
;
;
; ==============================================================================

m1523:              cpy #$09
                    bne -                           ; bne $1522
                    jmp m15AD                       ; jmp $15ad

; ==============================================================================
m152B:
                    lda #$0c
                    sta zp03
                    lda #$0f
                    sta zp02
                    sta zp04
m1535:              ldx #$06
m1537:              lda #$00
                    bne +                           ; bne $1544
                    dex
                    cpx #$02
                    bne ++                          ; bne $154b
                    lda #$01
                    bne ++                          ; bne $154b
+                   inx
                    cpx #$07
                    bne ++                          ; bne $154b
                    lda #$00
++                  sta m1537 + 1                   ; sta $1538
                    stx m1535 + 1                   ; stx $1536
-                   ldy #$00
                    lda #$df
                    sta (zp02),y
                    iny
                    iny
                    sta (zp02),y
                    dey
                    lda #$ea
                    sta (zp02),y
                    sta (zp04),y
                    jsr m159D                       ; jsr $159d
                    dex
                    bne -                           ; bne $1551
                    lda #$e4
                    sta zpA8
                    ldx #$02
--                  ldy #$00
-                   lda zpA8
                    sta (zp02),y
                    lda #$da
                    sta (zp04),y
                    inc zpA8
                    iny
                    cpy #$03
                    bne -                           ; bne $1570
                    jsr m159D                       ; jsr $159d
                    dex
                    bne --                          ; bne $156e
                    ldy #$00
                    lda #$e7
                    sta zpA8
-                   lda (zp02),y
                    cmp zpA8
                    bne +                           ; bne $1595
                    lda #$df
                    sta (zp02),y
+                   inc zpA8
                    iny
                    cpy #$03
                    bne -                           ; bne $158b
                    rts

; ==============================================================================
;
;
; ==============================================================================

m159D:              lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc +                                   ; bcc $15ac
                    inc zp03
                    inc zp05
+                   rts

; ==============================================================================
;
;
; ==============================================================================

m15AD:              ldx #$01
                    cpx #$01
                    bne m15B7                               ; bne $15b7
                    dec m15AD + 1                           ; dec $15ae
                    rts

; ==============================================================================
;
;
; ==============================================================================

m15B7:              inc m15AD + 1                           ; inc $15ae
                    lda #$08
                    sta zp05
                    jmp m152B           ; jmp $152b

; ==============================================================================

m15C1:              lda #$00
                    cmp #$00
                    bne m15CB                               ; bne $15cb
                    inc m15C1 + 1                           ; inc $15c2
                    rts

; ==============================================================================
;
;
; ==============================================================================

m15CB:              dec m15C1 + 1                           ; dec $15c2
                    jmp m3620

; ==============================================================================

m15D1:              lda items + $ac                        ; lda $3736
                    cmp #$df
                    bne +                                   ; bne $15dd
                    lda #$59
                    sta items + $12c                        ; sta $37b6
+                   lda m3050 + 1
                    cmp #$11
                    bne m162A                               ; bne $162a
                    lda m14CC + 1                           ; lda $14cd
                    bne m15FC                               ; bne $15fc
                    lda m35A3 + 1
                    cmp #$06
                    bne m15FC                               ; bne $15fc
                    lda m35A3 + 3
                    cmp #$18
                    bne m15FC                               ; bne $15fc
                    lda #$00
                    sta m15FC + 1                           ; sta $15fd
m15FC:              lda #$01
                    bne +                                   ; bne $1616
                    ldy #$06
m1602:              ldx #$1e
                    lda #$00
                    sta zpA7
                    jsr m3608
                    ldx m1602 + 1                   ; ldx $1603
                    cpx #$03
                    beq ++                          ; beq $1613
                    dex
++                  stx m1602 + 1                   ; stx $1603
+                   lda #$78
                    sta zpA8
                    lda #$49
                    sta zp0A
                    ldy #$06
                    lda #$01
                    sta zpA7
                    ldx m1602 + 1                   ; ldx $1603
                    jsr m3608
m162A:              jmp m147E                   ; jmp $147e


; ==============================================================================
m162d:
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x         ; lda $033b,x              ; cassette tape buffer
                    sta TAPE_BUFFER + $18,x         ; sta $034b,x              ; cassette tape buffer
                    dex
                    bne -                       ; bne $162f
                    lda #$02
                    sta zpA7
                    ldx m35A3 + 3
                    ldy m35A3 + 1
                    jsr m3608
                    ldx #$09
m1647:              lda TAPE_BUFFER + $8,x      ; lda $033b,x              ; cassette tape buffer
                    cmp #$d8
                    bne +                   ; bne $1653
m164E:              ldy #$05
m1650:              jmp death               ; 05 Didn't you see the laser beam?

; ==============================================================================

+                   ldy m3050 + 1
                    cpy #$11
                    bne +                       ; bne $166a
                    cmp #$78
                    beq ++                      ; beq $1666
                    cmp #$7b
                    beq ++                      ; beq $1666
                    cmp #$7e
                    bne +                       ; bne $166a
++                  ldy #$0b                      ; 0b You were hit by a big rock and died!
                    bne m1650                   ; bne $1650
+                   cmp #$9c
                    bcc m1676                   ; bcc $1676
                    cmp #$a5
                    bcs m1676                   ; bcs $1676
                    jmp m16A7                 ; jmp $16a7

; ==============================================================================

m1676:              cmp #$e4
                    bcc +                           ; bcc $168a
                    cmp #$eb
                    bcs ++                          ; bcs $1682
-                   ldy #$04                        ; 04 Boris the spider got you and killed you
                    bne m1650                       ; bne $1650
++                  cmp #$f4
                    bcs +                           ; bcs $168a
                    ldy #$0e                      ; 0e The monster grabbed you you. You are dead!
                    bne m1650                       ; bne $1650
+                   dex
                    bne m1647                       ; bne $1647
                    ldx #$09
--                  lda $034b,x
                    sta TAPE_BUFFER + $8,x          ; sta $033b,x
                    cmp #$d8
                    beq m164E                       ; beq $164e
                    cmp #$e4
                    bcc +                           ; bcc $16a1
                    cmp #$ea
                    bcc -                           ; bcc $167e
+                   dex
                    bne --                          ; bne $168f
                    jmp m11E0                     ; jmp $11e0

m16A7:
                    ldy items + $1a7                ; ldy $3831
                    cpy #$df
                    beq +                           ; beq $16b2
                    ldy #$0c                      ; 0c Belegro killed you!
                    bne m1650                       ; bne $1650
+                   ldy #$00
                    sty m14CC + 1                   ; sty $14cd
                    jmp m1676                       ; jmp $1675


; ==============================================================================
; this might be the inventory/ world reset
; puts all items into the level data again
; maybe not. not all characters for e.g. the wirecutter is put back
; addresses are mostly within items.asm address space ( $368a )
; ==============================================================================

m16BA:
                    lda #$a5                        ; $a5 = the door of the shed where the ladder is
                    sta items + $38                        ; sta $36c2
                    lda #$a9                        ; a9 = NO gloves
                    sta items + $8                        ; sta $3692                       ; inventory gloves
                    lda #$79
                    sta items + $6                        ; sta $3690
                    lda #$e0                        ; empty char
                    sta items + $10                        ; sta $369a
                    lda #$ac                        ; wirecutter
                    sta items + $19                        ; sta $36a3
                    lda #$b8                        ; part of the bottle - hmmm...
                    sta items + $29                        ; sta $36b3
                    lda #$b0                        ; the ladder
                    sta items + $4d                        ; sta $36d7
                    lda #$b5                        ; more ladder
                    sta items + $58                        ; sta $36e2
                    lda #$5e                        ; seems to be water?
                    sta items + $74                        ; sta $36fe
                    lda #$c6                        ; boots in the whatever box
                    sta items + $84                        ; sta $370e
                    lda #$c0                        ; not sure
                    sta items + $96                        ; sta $3720
                    lda #$cc                        ; power outlet
                    sta items + $ac                        ; sta $3736
                    lda #$d0                        ; the hammer
                    sta items + $bb                        ; sta $3745
                    lda #$d2                        ; unsure
                    sta items + $c8                        ; sta $3752
                    lda #$d6                        ; unsure
                    sta items + $d5                        ; sta $375f
                    lda #$00                        ; door
                    sta items + $12c                        ; sta $37b6
                    lda #$dd                        ; unsure
                    sta items + $1a7                        ; sta $3831
                    lda #$01                        ; door
                    sta items + $2c1                        ; sta $394b
                    lda #$01                        ; door
                    sta items + $30a                        ; sta $3994
                    lda #$f5                        ; fence
                    sta items + $277                        ; sta $3901
                    lda #$00                        ; door
                    sta m12A4                               ; sta $12a4
                    lda #$01                        ; door
                    sta m15FC + 1                           ; sta $15fd
                    lda #$1e
                    sta m1602 + 1                           ; sta $1603
                    lda #$01
                    sta m14CC + 1                           ; sta $14cd
m1732:              ldx #$05
                    cpx #$07
                    bne +                                   ; bne $173a
                    ldx #$ff
+                   inx
                    stx m1732 + 1                           ; stx $1733
                    lda m1747,x                             ; lda $1747,x
                    sta m3952 + 1                   ; sta $3953
                    jmp print_title     ; jmp $310d


; ==============================================================================

m1747:
                    !byte $02, $07, $04, $06, $08, $01, $05, $03


m174F:
                    cpx #$0c
                    bne +           ; bne $1755
                    lda #$49
+                   cpx #$0d
                    bne +           ; bne $175b
                    lda #$45
+                   rts






                    ;  1111111    BBBBBBBBBBBBBBBBB          444444444         444444444  
                    ; 1::::::1    B::::::::::::::::B        4::::::::4        4::::::::4  
                    ;1:::::::1    B::::::BBBBBB:::::B      4:::::::::4       4:::::::::4  
                    ;111:::::1    BB:::::B     B:::::B    4::::44::::4      4::::44::::4  
                    ;   1::::1      B::::B     B:::::B   4::::4 4::::4     4::::4 4::::4  
                    ;   1::::1      B::::B     B:::::B  4::::4  4::::4    4::::4  4::::4  
                    ;   1::::1      B::::BBBBBB:::::B  4::::4   4::::4   4::::4   4::::4  
                    ;   1::::l      B:::::::::::::BB  4::::444444::::4444::::444444::::444
                    ;   1::::l      B::::BBBBBB:::::B 4::::::::::::::::44::::::::::::::::4
                    ;   1::::l      B::::B     B:::::B4444444444:::::4444444444444:::::444
                    ;   1::::l      B::::B     B:::::B          4::::4            4::::4  
                    ;   1::::l      B::::B     B:::::B          4::::4            4::::4  
                    ;111::::::111 BB:::::BBBBBB::::::B          4::::4            4::::4  
                    ;1::::::::::1 B:::::::::::::::::B         44::::::44        44::::::44
                    ;1::::::::::1 B::::::::::::::::B          4::::::::4        4::::::::4
                    ;111111111111 BBBBBBBBBBBBBBBBB           4444444444        4444444444








; ==============================================================================
;
;
; ==============================================================================
                    *= $1B44
print_endscreen:
                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #<SCREENRAM       ; lda #$00
                    sta zp02
                    sta zp04
                    ldx #$04
                    lda #>screen_win_src;lda #$17
                    sta zpA8
                    lda #<screen_win_src;lda #$5c
                    sta zpA7
                    ldy #$00
-                   lda (zpA7),y        ; copy from $175c + y
                    sta (zp02),y        ; to SCREEN
                    lda #$00           ; color = BLACK
                    sta (zp04),y        ; to COLRAM
                    iny
                    bne -               ; bne $1b5e
                    inc zp03
                    inc zp05
                    inc zpA8
                    dex
                    bne -               ; bne $1b5e
                    lda #$ff           ; PISSGELB
                    sta BG_COLOR          ; background
                    sta BORDER_COLOR          ; und border
-                   lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
                    and #$80           ; WAITKEY?
                    bne -               ; bne $1b7a
                    jsr print_title     ; jsr $310d
                    jsr print_title     ; jsr $310d
                    jmp init            ; jmp $3ab3

; ==============================================================================

m1B8F:              lda m12A4           ; lda $12a4
                    bne +               ; bne $1b97
                    jmp m3B4C           ; jmp $3b4c
+                   jsr set_charset_and_screen_for_title           ; jsr $3a9d
                    jmp print_endscreen ; jmp $1b44


; ==============================================================================
;
; INTRO TEXT SCREEN
; ==============================================================================

intro_text:

; instructions screen
; "Search the treasure..."

!if LANGUAGE = EN{
!scr "Search the treasure of Ghost Town and   "
!scr "open it ! Kill Belegro, the wizard, and "
!scr "dodge all other dangers. Don't forget to"
!scr "use all the items you'll find during    "
!scr "your yourney through 19 amazing hires-  "
!scr "graphics-rooms! Enjoy the quest and play"
!scr "it again and again and again ...      > "
}

!if LANGUAGE = DE{
!scr "Suchen Sie die Schatztruhe der Geister- "
!scr "stadt und oeffnen Sie diese ! Toeten    "
!scr "Sie Belegro, den Zauberer und weichen   "
!scr "Sie vielen anderen Wesen geschickt aus. "
!scr "Bedienen Sie sich an den vielen Gegen-  "
!scr "staenden, welche sich in den 19 Bildern "
!scr "befinden. Viel Spass !                > "
}

display_intro_text:

                    ; i think this part displays the introduction text

                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #$a0
                    sta zp02
                    sta zp04
                    lda #>intro_text
                    sta zpA8
                    lda #<intro_text
                    sta zpA7
                    ldx #$07
--                  ldy #$00
-                   lda (zpA7),y
                    sta (zp02),y
                    lda #$68
                    sta (zp04),y
                    iny
                    cpy #$28
                    bne -
                    lda zpA7
                    clc
                    adc #$28
                    sta zpA7
                    bcc +           ; bcc $1ce7
                    inc zpA8
+                   lda zp02
                    clc
                    adc #$50
                    sta zp02
                    sta zp04
                    bcc +           ; bcc $1cf6
                    inc zp03
                    inc zp05
+                   dex                ; 1cf6
                    bne --          ; bne $1ccd
                    lda #$00
                    sta BG_COLOR
                    rts

; ==============================================================================
;
; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
; DECREASES MUSIC VOLUME
; ==============================================================================

start_intro:        sta KEYBOARD_LATCH
                    jsr PRINT_KERNAL           ; jsr $c56b
                    jsr display_intro_text           ; jsr $1cb5
                    jsr check_shift_key ; jsr $1ef9
                    lda #$ba
                    sta rsav7+1         ; sta $1ed9    ; sound volume
                    rts

; ==============================================================================
;
; music data
; ==============================================================================
; * = $1d11
music:
                    !source "includes/music.asm"

; ==============================================================================
                    ; *= $1DD2
music_player:                                  ; Teil von music_play
rsav2:              ldy #$00
                    bne +               ; bne $1df3
                    lda #$40
                    sta rsav3+1         ; sta $1e39
                    jsr more_music           ; jsr $1e38
rsav4:              ldx #$00
                    lda music+3,x       ; lda $1d14,x                     ; first voice
                    inc rsav4+1         ; inc $1ddf
                    tay
                    and #$1f
                    sta rsav3+1         ; sta $1e39
                    tya
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    tay
+                   dey
                    sty rsav2+1         ; sty $1dd3
rsav5:              ldy #$00
                    bne +
                    lda #$40
                    sta even_more_music + 1
                    jsr even_more_music           ; jsr $1e60
rsav6:              ldx #$00
                    lda music + $5d,x     ; lda $1d6e,x                 ; second voice
                    tay
                    inx
                    cpx #$65
                    beq m1E27           ; beq $1e27
                    stx rsav6 + 1       ; stx $1e04
                    and #$1f
                    sta even_more_music + 1       ; sta $1e61
                    tya
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    tay
+                   dey
                    sty rsav5 + 1       ; sty $1df8
                    jsr more_music           ; jsr $1e38
                    jmp even_more_music           ; jmp $1e60

; ==============================================================================
; music
m1E27:              lda #$00
                    sta rsav2+1         ; sta $1dd3
                    sta rsav4+1         ; sta $1ddf
                    sta rsav5+1         ; sta $1df8
                    sta rsav6+1         ; sta $1e04
                    jmp music_player           ; jmp $1dd2

; ==============================================================================
; music

more_music:
rsav3:              ldx #$04
                    cpx #$1c
                    bcc +               ; bcc $1e46
                    lda VOLUME_AND_VOICE_SELECT
                    and #$ef           ; clear bit 4
                    jmp writeFF11       ; jmp $1e5c

+                   lda m1E88,x         ; lda $1e88,x        ; $1E88 ... : music data lo ?
                    sta VOICE1_FREQ_LOW          ; Low byte of frequency for voice 1
                    lda VOICE1
                    and #$fc
                    ora m1E88 + $18, x  ; ora $1ea0,x        ; $1EA0 ... : music data hi ?
                    sta VOICE1          ; High bits of frequency for voice 1
                    lda VOLUME_AND_VOICE_SELECT
                    ora #$10           ; set bit 4
writeFF11           sta VOLUME_AND_VOICE_SELECT          ; (de-)select voice 1
                    rts

; ==============================================================================
;
;
; ==============================================================================
; music
                    ; *= $1E60
even_more_music:
                    ldx #$0d
                    cpx #$1c
                    bcc +
                    lda VOLUME_AND_VOICE_SELECT
                    and #$df
                    jmp writeFF11       ; jmp $1e5c
+                   lda m1E88,x         ; lda $1e88,x
                    sta VOICE2_FREQ_LOW ; sta $ff0f
                    lda VOICE2
                    and #$fc
                    ora m1E88 + $18,x   ; ora $1ea0,x
                    sta VOICE2
                    lda VOLUME_AND_VOICE_SELECT
                    ora #$20
                    sta VOLUME_AND_VOICE_SELECT
                    rts

; ==============================================================================
;
; seems to be the instruments or pitch/octave of the music
; ==============================================================================

; part of the music or the music instruments
; $1e88
m1E88:
!byte $07, $76, $a9, $06, $59, $7f, $c5, $04, $3b, $54, $83, $ad, $c0, $e3, $02, $1e
!byte $2a, $42, $56, $60, $71, $81, $8f, $95, $00, $00, $00, $01, $01, $01, $01, $02
!byte $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
!byte $03, $03, $03, $03

; ==============================================================================
;
;
; ==============================================================================
; music

music_play:
rsav0:              ldx #$09
                    dex
                    stx rsav0+1         ; stx $1ebd
                    beq +               ; beq $1ece
                    rts

; ==============================================================================
; music
                    ; *= $1EC5
rsav1:              ldy #$01
                    dey
                    sty rsav1+1         ; sty $1ec6
                    beq +               ; beq $1ece
                    rts

; ==============================================================================
; music
                    ; *= $1ECE
+                   ldy #$0b
                    sty rsav0+1         ; sty $1ebd
                    lda VOLUME_AND_VOICE_SELECT
                    ora #$37
rsav7:              and #$bf           ; $1ED8 $1ED9     ; rsav7+1 = sound volume
                    sta VOLUME_AND_VOICE_SELECT          ; sth. with SOUND / MUSIC ?
                    jmp music_player           ; jmp $1dd2

; ==============================================================================
; irq init
;
; ==============================================================================

                    ; *= $1EE0
irq_init0:
                    sei
                    lda #<irq0          ; lda #$06
                    sta $0314          ; irq lo
                    lda #>irq0          ; lda #$1f
                    sta $0315          ; irq hi
                                        ; irq at $1F06
                    lda #$02
                    sta $ff0a          ; set IRQ source to RASTER

                    lda #$bf
                    sta rsav7+1         ; sta $1ed9    ; sound volume
                    cli

                    jmp set_charset_and_screen_for_title           ; jmp $3a9d

; ==============================================================================
; intro text
; wait for shift or joy2 fire press
; ==============================================================================

check_shift_key:

-                   lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
                    and #$80            ; checks for SHIFT key, same as joy 2 fire?
                    bne -               ; bne $1ef9
                    rts

; ==============================================================================
;
; INTERRUPT routine for music
; ==============================================================================

                    ; *= $1F06
irq0:
                    lda INTERRUPT
                    sta INTERRUPT          ; ack IRQ
                                        ; this IRQ seems to handle music only!
                    !if SILENT_MODE = 1 {
                        jsr fake
                    } else {
                        jsr music_play  ; jsr $1ebc
                    }
                    pla
                    tay
                    pla
                    tax
                    pla
                    rti

; ==============================================================================
; gets called immediately after start of game
; looks like some sound/irq initialization?
; i think the branching part does fade the sound
; ==============================================================================

m1F15:                                  ; call from init
                    lda rsav7+1         ; lda $1ed9           ; sound volume
--                  cmp #$bf           ; is true on init
                    bne +               ; bne $1f1f
                    jmp irq_init0       ; jmp $1ee0
+                   ldx #$04
-                   stx zpA8            ; buffer serial input byte ?
                    ldy #$ff
                    jsr wait
                    ldx zpA8
                    dex
                    bne -               ; bne $1f21 / some weird wait loop ?
                    clc
                    adc #$01           ; add 1 (#$C0 on init)
                    sta rsav7+1         ; sta $1ed9             ; sound volume
                    jmp --              ; jmp $1f18






                    ; 222222222222222         888888888          000000000           000000000     
                    ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00   
                    ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00 
                    ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
                    ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
                    ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
                    ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
                    ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
                    ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
                    ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
                    ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
                    ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
                    ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
                    ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00 
                    ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00   
                    ;22222222222222222222     888888888           000000000           000000000   







; ==============================================================================
;
; LEVEL DATA
; Based on tiles
; ==============================================================================
                     *= $2800
level_data:
                    !source "includes/levels.asm"

!byte $00, $00, $00, $00, $00, $00, $00

;$2fbf
m2FBF:
!byte $01

; $2fc0
m2FC0:
                    lda #$6b
                    sta items + $8               ; store 6b = gloves in inventory
                    lda #$3d
                    sta items + $6                      ;sta $3690
-                   rts

; ==============================================================================
;
;
; ==============================================================================

m2fCB:              lda m3050 + 1
                    cmp #$04
                    bne -                   ; bne $2fca
                    lda #$03
                    ldy m394A + 1           ; ldy $394b
                    beq +
                    lda #$f6
+                   sta SCREENRAM + $f9     ; sta $0cf9
                    rts

; ==============================================================================
;
;
; ==============================================================================

m2FDF:              ldy items + $96     ; ldy $3720
                    cpy #$df
                    bne +               ; bne $2fec
                    sta m3993 + 1       ; sta $3994
                    jmp m12F4           ; jmp $12f4
+                   jmp m3B4C           ; jmp $3b4c
m2FEF:              jsr m39F4 ; jsr $39f4
                    jmp m15D1           ; jmp $15d1


; ==============================================================================
;
;
; ==============================================================================

m2FF5:
                    jsr draw_empty_column_and_row           ; jsr $3b02
                    lda #$00            ; settings this to e.g. 1 mirrors the level layout (to some extend)
                    sta zp02
                    rts


; $2ffd
unknown: ; haven't found a call for this code area yet. might be waste
!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
!byte $00

; ==============================================================================
;
; tileset definition
; these are the first characters in the charset of each tile.
; example: rocks start at $0c and span 9 characters in total
; ==============================================================================
; $301e
tileset_definition:
!byte $df, $0c, $15, $1e, $27, $30, $39, $42, $4b, $54, $5d, $66, $6f, $78, $81
!byte $8a, $03, $00, $39, $19, $0e, $3d, $7f, $2a, $2a, $1e, $1e, $1e, $3d, $3d, $19
!byte $2f, $2f, $39

; ==============================================================================
;
; displays a room based on tiles
; ==============================================================================

display_room:       
                    jsr m2FF5           ; jsr $2FF5
                    ldx #$08            ; i think this sets the colram (0800)
                    stx zp05
                    ldx #$0c            ; and this the screen (0c00)
                    stx zp03
                    ldx #$28            ; when changed shifts level data -> $2800 = start of level data
                    stx zp0A
m3050:              ldx #$01
                    beq ++               ; beq $305e
-                   clc
                    adc #$68            ; $68 = 104 = 13*8 (size of a room)
                    bcc +               ; bcc $305b
                    inc zp0A
+                   dex
                    bne -               ; bne $3054
++                  sta zp09
                    ldy #$00
                    sty zpA8
                    sty zpA7
m3066:              lda (zp09),y
                    tax
                    lda tileset_definition + $11,x
                    sta zp10
                    lda tileset_definition,x
                    sta zp11
                    ldx #$03
--                  ldy #$00
-                   lda zp02
                    sta zp04
                    lda zp11
                    sta (zp02),y
                    lda zp10
                    sta (zp04),y
                    jsr m30C8           ; jsr $30c8
                    cpy #$03
                    bne -               ; bne $3077
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    bcc +               ; bcc $3097
                    inc zp03
                    inc zp05
+                   dex
                    bne --              ; bne $3075
                    inc zpA8
                    inc zpA7
                    lda #$75
                    ldx zpA8
                    cpx #$0d
                    bcc +               ; bcc $30b2
                    ldx zpA7
                    cpx #$66
                    bcs print_X         ; bcs $30d2
                    lda #$00
                    sta zpA8
                    lda #$24
+                   sta m30B8 + 1      ; sta $30b9
                    lda zp02
                    sec
m30B8:              sbc #$75
                    sta zp02
                    bcs +               ; bcs $30c2
                    dec zp03
                    dec zp05
+                   ldy zpA7
                    jmp m3066
                    rts               ; will this ever be used?

; ==============================================================================
;
;
; ==============================================================================

m30C8:
                    lda zp11
                    cmp #$df
                    beq +               ;beq $30d0
                    inc zp11
+                   iny
                    rts

; ==============================================================================
;
;
; ==============================================================================

                    ; *= $30D2
print_X:
                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #$00
                    sta zp02
                    sta zp04
-                   ldy #$28
                    lda (zp02),y
                    cmp #$06
                    bcs +               ; bcs $30f3
                    sec
                    sbc #$03
                    ldy #$00
                    sta (zp02),y
                    lda #$39
                    sta (zp04),y
+                   lda zp02
                    clc
                    adc #$01
                    bcc +               ; bcc $30fe
                    inc zp03
                    inc zp05
+                   sta zp02
                    sta zp04
                    cmp #$98
                    bne -               ; bne $30e0
                    lda zp03
                    cmp #$0f
                    bne -               ; bne $30e0
                    rts

; ==============================================================================
;
;
; ==============================================================================

print_title:
                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #<SCREENRAM       ; lda #$00
                    sta zp02
                    sta zp04
                    lda #>screen_start_src
                    sta zpA8
                    lda #<screen_start_src
                    sta zpA7
                    ldx #$04
--                  ldy #$00
-                   lda (zpA7),y        ; $313C + Y ( Titelbild )
                    sta (zp02),y        ; nach SCREEN
                    lda #$00           ; BLACK
                    sta (zp04),y        ; nach COLRAM
                    iny
                    bne -               ; bne $3127
                    inc zp03
                    inc zp05
                    inc zpA8
                    dex
                    bne --              ; bne $3125
                    rts





                    ; 333333333333333   555555555555555555  222222222222222    555555555555555555 
                    ;3:::::::::::::::33 5::::::::::::::::5 2:::::::::::::::22  5::::::::::::::::5 
                    ;3::::::33333::::::35::::::::::::::::5 2::::::222222:::::2 5::::::::::::::::5 
                    ;3333333     3:::::35:::::555555555555 2222222     2:::::2 5:::::555555555555 
                    ;            3:::::35:::::5                        2:::::2 5:::::5            
                    ;            3:::::35:::::5                        2:::::2 5:::::5            
                    ;    33333333:::::3 5:::::5555555555            2222::::2  5:::::5555555555   
                    ;    3:::::::::::3  5:::::::::::::::5      22222::::::22   5:::::::::::::::5  
                    ;    33333333:::::3 555555555555:::::5   22::::::::222     555555555555:::::5 
                    ;            3:::::3            5:::::5 2:::::22222                    5:::::5
                    ;            3:::::3            5:::::52:::::2                         5:::::5
                    ;            3:::::35555555     5:::::52:::::2             5555555     5:::::5
                    ;3333333     3:::::35::::::55555::::::52:::::2       2222225::::::55555::::::5
                    ;3::::::33333::::::3 55:::::::::::::55 2::::::2222222:::::2 55:::::::::::::55 
                    ;3:::::::::::::::33    55:::::::::55   2::::::::::::::::::2   55:::::::::55   
                    ; 333333333333333        555555555     22222222222222222222     555555555  





; ==============================================================================
;
;
; ==============================================================================

                    *= $3525
m3525:
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #$00
                    sta zp02
                    sta zp04
                    rts

; ==============================================================================
;
;
; ==============================================================================

m3534:
                    jsr m3525           ; jsr $3525
                    cpy #$00
                    beq +               ; beq $3547
-                   clc
                    adc #$28
                    bcc ++              ; bcc $3544
                    inc zp03
                    inc zp05
++                  dey
                    bne -               ; bne $353b
+                   clc
m3548:              adc #$15
                    sta zp02
                    sta zp04
                    bcc +               ; bcc $3554
                    inc zp03
                    inc zp05
+                   ldx #$03
                    lda #$00
                    sta zp09
--                  ldy #$00
-                   lda zpA7
                    bne +               ; bne $3566
                    lda #$df
                    sta (zp02),y
                    bne ++              ; bne $3581
+                   cmp #$01
                    bne +               ; bne $3574
                    lda zpA8
                    sta (zp02),y
                    lda zp0A
                    sta (zp04),y
                    bne ++              ; bne $3581
+                   lda (zp02),y
                    stx zp10
                    ldx zp09
                    sta TAPE_BUFFER + $9,x          ; sta $033c,x                 ; cassette tape buffer
                    inc zp09
                    ldx zp10
++                  inc zpA8
                    iny
                    cpy #$03
                    bne -               ; bne $355c
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc +               ; bcc $3597
                    inc zp03
                    inc zp05
+                   dex
                    bne --              ; bne $355a
                    rts


; ==============================================================================
; $359b
; JOYSTICK CONTROLS
; ==============================================================================

check_joystick:
                    lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
m35A3:              ldy #$09
                    ldx #$15
                    lsr
                    bcs +                   ; bcs $35af
                    cpy #$00
                    beq +                   ; beq $35af
                    dey                                           ; JOYSTICK UP
+                   lsr
                    bcs +                   ; bcs $35b7
                    cpy #$15
                    bcs +                   ; bcs $35b7
                    iny                                           ; JOYSTICK DOWN
+                   lsr
                    bcs +                   ; bcs $35bf
                    cpx #$00
                    beq +                   ; beq $35bf
                    dex                                           ; JOYSTICK LEFT
+                   lsr
                    bcs +                   ; bcs $35c7
                    cpx #$24
                    bcs +                   ; bcs $35c7
                    inx                                           ; JOYSTICK RIGHT
+                   sty m35E7 + 1           ; sty $35e8
                    stx m35EC + 1           ; stx $35ed
                    stx m3548 + 1           ; stx $3549
                    lda #$02
                    sta zpA7
                    jsr m3534           ; jsr $3534
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x      ; lda $033b,x
                    cmp #$df
                    beq +                   ; beq $35e4
                    cmp #$e2
                    bne ++                  ; bne $35f1
+                   dex
                    bne -                   ; bne $35d9
m35E7:              lda #$0a
                    sta m35A3 + 1
m35EC:              lda #$15
                    sta m35A3 + 3
++                  lda #$ff
                    sta KEYBOARD_LATCH
                    lda #$01
                    sta zpA7
                    lda #$93                ; first character of the player graphic
                    sta zpA8
                    lda #$3d
                    sta zp0A
m3602:              ldy m35A3 + 1
                    ldx m35A3 + 3
m3608:              stx m3548 + 1           ; stx $3549
                    jmp m3534           ; jmp $3534

; ==============================================================================
;
; JOYSTICK INTERRUPT?
; ==============================================================================

m360E:
                    sei
                    lda #$c0
-                   cmp $ff1d           ; vertical line bits 0-7
                    bne -               ; bne $3611
                    lda #$00
                    sta zpA7
-                   jmp m3A6D
                    bne -               ; bne $361a
                    rts

; ==============================================================================
;
;
; ==============================================================================
m3620:
                    lda #$00
                    sta zpA7
m3624:              ldx #$0f
m3626:              ldy #$0f
                    jsr m3608
                    nop
                    ldx m3624 + 1            ; ldx $3625
                    ldy m3626 + 1            ; ldy $3627
                    cpx m35A3 + 3
                    bcs +                   ; bcs $3639
                    inx
                    inx
+                   cpx m35A3 + 3
                    beq +                   ; beq $363f
                    dex
+                   cpy m35A3 + 1
                    bcs +                   ; bcs $3646
                    iny
                    iny
+                   cpy m35A3 + 1
                    beq +               ; beq $364c
                    dey
+                   stx m3668 + 1       ; stx $3669
                    stx m3548 + 1       ; stx $3549
                    sty m366D + 1       ; sty $366e
                    lda #$02
                    sta zpA7
                    jsr m3534           ; jsr $3534
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x  ; lda $033b,x
                    cmp #$92
                    bcc +               ; bcc $3672
                    dex
                    bne -               ; bne $365e
m3668:              ldx #$10
                    stx m3624 + 1       ; stx $3625
m366D:              ldy #$0e
                    sty m3626 + 1       ; sty $3627
+                   lda #$9c
                    sta zpA8
                    lda #$3e
                    sta zp0A
                    ldy m3626 + 1       ; ldy $3627
                    ldx m3624 + 1       ; ldx $3625
                    stx m3548 + 1           ; stx $3549
                    lda #$01
                    sta zpA7
                    jmp m3534           ; jmp $3534


; $368a
; ==============================================================================
; items
; This area seems to be responsible for items placement
;
; ==============================================================================
                    !source "includes/items.asm"

m383A:
                    lda zpA7
                    clc
                    adc #$01
                    sta zpA7
                    bcc +                       ; bcc $3845
                    inc zpA8
+                   rts

; ==============================================================================
; TODO
; no clue yet. level data has already been drawn when this is called
; probably placing the items on the screen
; ==============================================================================

m3846:
                    lda #>items                ; items
                    sta zpA8
                    lda #<items
                    sta zpA7
                    ldy #$00
m3850:              lda (zpA7),y
                    cmp #$ff
                    beq +                       ; beq $385c
-                   jsr m383A
                    jmp m3850
+                   jsr m383A
                    lda (zpA7),y
                    cmp #$ff
                    beq m38DF               ; beq $38df
                    cmp m3050 + 1
                    bne -                   ; bne $3856
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #$00
                    sta zp02
                    sta zp04
                    jsr m383A
                    lda (zpA7),y
-                   cmp #$fe
                    beq +                   ; beq $388c
                    cmp #$f9
                    bne +++                  ; bne $3892
                    lda zp02
                    jsr m38D7
                    bcc ++                   ; bcc $3890
+                   inc zp03
                    inc zp05
++                  lda (zpA7),y
+++                 cmp #$fb
                    bne +                   ; bne $389f
                    jsr m383A
                    lda (zpA7),y
                    sta zp09
                    bne ++                  ; bne $38bf
+                   cmp #$f8
                    beq +                   ; beq $38b7
                    cmp #$fc
                    bne +++                 ; bne $38ac
                    lda zp0A
                    jmp m399F
+++                 cmp #$fa
                    bne ++                  ; bne $38bf
                    jsr m383A
                    lda (zpA7),y
                    sta zp0A
m38B7:
+                   lda zp09
                    sta (zp04),y
                    lda zp0A
                    sta (zp02),y
++                  cmp #$fd
                    bne +                   ; bne $38cc
                    jsr m383A
                    lda (zpA7),y
                    sta zp02
                    sta zp04
+                   jsr m383A
                    lda (zpA7),y
                    cmp #$ff
                    bne -                   ; bne $387d
                    beq m38DF               ; beq $38df
m38D7:              clc
                    adc #$01
                    sta zp02
                    sta zp04
                    rts

; ==============================================================================
;
;
; ==============================================================================

m38DF:              lda m3050 + 1
                    cmp #$02
                    bne m3919           ; bne $3919
                    lda #$0d
                    sta zp02
                    sta zp04
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    ldx #$18
-                   lda (zp02),y
                    cmp #$df
                    beq m3900               ; beq $3900
                    cmp #$f5
                    bne ++              ; bne $3906
m3900:              lda #$f5
                    sta (zp02),y
                    sta (zp04),y
++                  lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc +               ; bcc $3915
                    inc zp03
                    inc zp05
+                   dex
                    bne -               ; bne $38f6
                    rts

; ==============================================================================
;
;
; ==============================================================================

m3919:              cmp #$07
                    bne m392F       ; bne $392f
                    ldx #$17
-                   lda SCREENRAM + $168,x     ; lda $0d68,x
                    cmp #$df
                    bne +                       ; bne $392b
                    lda #$e3
                    sta SCREENRAM + $168,x     ; sta $0d68,x
+                   dex
                    bne -                       ; bne $391f
                    rts


; ==============================================================================
;
;
; ==============================================================================
m392F:
                    cmp #$06
                    bne +
                    lda #$f6
                    sta SCREENRAM + $9c        ; sta $0c9c
                    sta SCREENRAM + $9c        ;sta $0c9c    (yes, it's really 2 times the same sta)
                    sta SCREENRAM + $27c       ; sta $0e7c
                    sta SCREENRAM + $36c       ; sta $0f6c
                    rts

; ==============================================================================
;
;
; ==============================================================================

+                   cmp #$04
                    bne ++
                    ldx #$f7
                    ldy #$f8
m394A:              lda #$01
                    bne m3952           ; bne $3952
                    ldx #$3b
                    ldy #$42
m3952:              lda #$01        ; there seems to happen some self mod here
                    cmp #$01
                    bne +           ; bne $395b
                    stx SCREENRAM+ $7a ; stx $0c7a
+                   cmp #$02
                    bne +           ; bne $3962
                    stx SCREENRAM + $16a   ;stx $0d6a
+                   cmp #$03
                    bne +           ; bne $3969
                    stx SCREENRAM + $25a       ;stx $0e5a
+                   cmp #$04
                    bne +           ; bne $3970
                    stx SCREENRAM + $34a   ; stx $0f4a
+                   cmp #$05
                    bne +           ; bne $3977
                    sty SCREENRAM + $9c    ; sty $0c9c
+                   cmp #$06
                    bne +           ; bne $397e
                    sty SCREENRAM + $18c   ; sty $0d8c
+                   cmp #$07
                    bne +           ; bne $3985
                    sty SCREENRAM + $27c ; sty $0e7c
+                   cmp #$08
                    bne +           ; bne $398c
                    sty SCREENRAM + $36c   ; sty $0f6c
+                   rts

; ==============================================================================
;
;
; ==============================================================================

++                  cmp #$05
                    bne m399D          ; todo: understand why it jumps to an RTS
                    lda #$fd
m3993:              ldx #$01
                    bne +               ; bne $3999
                    lda #$7a
+                   sta SCREENRAM + $2d2   ;sta $0ed2
                    rts

; ==============================================================================
;
;
; ==============================================================================

m399D:
                    rts
                    
!byte $ff

m399F:
                    cmp #$df
                    beq +               ; beq $39a5
                    inc zp0A            ; inc $0a
+                   lda (zpA7),y        ; lda ($a7),y
                    jmp m38B7           ; jmp $38b7

; ==============================================================================
; Kein Schrott, wird in m3A17 eingelesen
; $39aa
; ==============================================================================
m39AA:
!byte $06, $03, $12, $21, $03, $03, $12, $21, $03, $03, $15, $21, $03, $03, $0f, $21
!byte $15, $1e, $06, $06, $06, $03, $12, $21, $03, $03, $09, $21, $03, $03, $12, $21
!byte $03, $03, $0c, $21, $03, $03, $12, $21, $0c, $03, $0c, $20, $0c, $03, $0c, $21
!byte $0c, $03, $09, $15, $03, $03, $06, $21, $03, $03, $03, $21, $06, $03, $12, $21
!byte $03, $03, $03, $1d, $03, $03, $06, $21, $03, $03

; $39F4
     
m39F4:
                    jsr m360E           ; jsr $360e
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x  ; lda $033b,x
                    cmp #$05
                    beq m3A08           ; beq $3a08
                    cmp #$03
                    beq m3A17           ; beq $3a17
                    dex
                    bne -               ; bne $39f9
-                   rts

; ==============================================================================
;
;
; ==============================================================================

m3A08:              ldx m3050 + 1
                    beq -               ;beq $3a07
                    dex
                    jmp m3A64           ; jmp $3a64
                               
!byte $34, $38, $32, $38, $02, $ff

m3A17:
                    ldx m3050 + 1
                    inx
                    stx m3050 + 1
                    ldy m3A33 + $17, x         ; ldy $3a4a,x
m3A21:              lda m39AA,y                ; lda $39aa,y
                    sta m35A3 + 1
                    lda m39AA + 1,y            ; lda $39ab,y
                    sta m35A3 + 3
m3A2D:              jsr display_room           ; jsr $3040
                    jmp m3846



; ==============================================================================
; $3a33
; Kein Schrott
; ==============================================================================

m3A33:
!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
!byte $00 

m3A64:
                    stx m3050 + 1                           ; stx $3051
                    ldy m3A33,x                             ; ldy $3A33,x
                    jmp m3A21                               ; jmp $3A21
m3A6D:

                    jsr m3602
                    jsr check_joystick
                    cli
                    rts
                    brk             ; $00

; ==============================================================================

wait:
                    dex
                    bne wait
                    dey
                    bne wait
fake:               rts

; ==============================================================================
; sets the game screen
; multicolor, charset, main colors
; ==============================================================================

set_game_basics:
                    lda VOICE1           ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
                    and #$fb           ; clear bit 2
                    sta VOICE1          ; => get data from RAM
                    lda #$21
                    sta CHAR_BASE_ADDRESS   ; sta $ff13          ; bit 0 : Status of Clock   ( 1 )
                                        ; bit 1 : Single clock set  ( 0 )
                                        ; b.2-7 : character data base address
                                        ;         %00100$x ($2000)
                    lda $ff07
                    ora #$90           ; multicolor ON - reverse OFF
                    sta $ff07

                    ; set the main colors for the game


                    lda #MULTICOLOR_1            ; original: #$db
                    sta COLOR_1           ; char color 1
                    lda #MULTICOLOR_2            ; original: #$29
                    sta COLOR_2           ; char color 2

                    rts

; ==============================================================================
; set font and screen setup (40 columns and hires)
; $3a9d
; ==============================================================================

set_charset_and_screen_for_title:    ; set text screen
                    
                    lda VOICE1
                    ora #$04           ; set bit 2
                    sta VOICE1          ; => get data from ROM
                    lda #$d5           ; ROM FONT
                    sta CHAR_BASE_ADDRESS   ; sta $ff13          ; set
                    lda $ff07
                    lda #$08           ; 40 columns and Multicolor OFF
                    sta $ff07
                    rts
                    

; ==============================================================================
; init
; start of game
; ==============================================================================

init:
                    jsr m1F15           ; jsr $1f15
                    lda #$01
                    sta BG_COLOR          ; background color
                    sta BORDER_COLOR          ; border color
                    jsr m16BA           ; might be a level data reset, and print the title screen
                    ldy #$20
                    jsr wait

                    ; waiting for key press on title screen

                    lda #TITLE_KEY_MATRIX    ;#$7f           ; read row 7 of keyboard matrix (http://plus4world.powweb.com/plus4encyclopedia/500012)
-                   sta KEYBOARD_LATCH          ; Latch register for keyboard
                    lda KEYBOARD_LATCH
                    and #TITLE_KEY    ;#$10            ; $10 = space
                    bne -               ; bne $3ac8 / wait for keypress ?

                    lda #$ff
                    jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume


                    ; TODO: unclear what the code below does
                    ; i think it fills the level data with "DF", which is a blank character
                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #$00
                    sta zp02
                    ldx #$04
                    ldy #$00
                    lda #$df
-                   sta (zp02),y
                    iny
                    bne -               ; bne $3ae5
                    inc zp03
                    dex
                    bne -               ; bne $3ae5

                    jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors

                    ; set background color
                    lda #$00
                    sta BG_COLOR

                    ; border color. default is a dark red
                    lda #BORDER_COLOR_VALUE
                    sta BORDER_COLOR

                    jsr draw_empty_column_and_row           ; jsr $3b02
                    jmp set_start_screen           ; jmp $3b3a
; ==============================================================================

draw_empty_column_and_row:
                    ; this seems to mainly draw the
                    ; horizontal and vertical blank lines
                    ; in the game

                    ; TODO: there is probably more to it. too complicated for such a simple task
                    ; is the level itself drawn here too?

                    lda #$27
                    sta zp02
                    sta zp04
                    lda #$08
                    sta zp05
                    lda #$0c
                    sta zp03
                    ldx #$18
                    ldy #$00
-                   lda #$5d
                    sta (zp02),y

                    lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN            ; draws blank column 40

                    sta (zp04),y
                    tya
                    clc
                    adc #$28
                    tay
                    bcc +               ; bcc $3b27
                    inc zp03
                    inc zp05
+                   dex
                    bne -               ; bne $3b14


                    ; fills the bottom line with blank colored space (making it invisible)
-                   lda #$5d
                    sta SCREENRAM + $3c0,x  ;sta $0fc0,x ; last row of the screen

                    lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN            ; draws blank row 25

                    sta COLRAM + $3c0,x         ;sta $0bc0,x             ; writes the line into the color ram

                    inx
                    cpx #$28
                    bne -               ; bne $3b2a
                    rts

; ==============================================================================
; SETUP FIRST ROOM
; player xy position and room number
; ==============================================================================

set_start_screen:
                    lda #PLAYER_START_POS_Y
                    sta m35A3 + 1               ; Y player start position (0 = top)
                    lda #PLAYER_START_POS_X
                    sta m35A3 + 3               ; X player start position (0 = left)
                    lda #START_ROOM              ; room number (start screen) ($3b45)
                    sta m3050 + 1
                    jsr m3A2D                   ; jsr $3a2d

m3B4C:
                    jsr m2FEF                   ; jsr $2fef
                    ldy #$30
                    jsr wait
                    jsr m2fCB                   ; jsr $2fcb
                    jmp m162d
; ==============================================================================

death_messages:

; death messages
; like "You fell into a snake pit"

; scr conversion 

; 00 You fell into a snake pit
; 01 You'd better watched out for the sacred column
; 02 You drowned in the deep river
; 03 You drank from the poisend bottle
; 04 Boris the spider got you and killed you
; 05 Didn't you see the laser beam?
; 06 240 Volts! You got an electrical shock!
; 07 You stepped on a nail!
; 08 A foot trap stopped you!
; 09 This room is doomed by the wizard Manilo!
; 0a You were locked in and starved!
; 0b You were hit by a big rock and died!
; 0c Belegro killed you!
; 0d You found a thirsty zombie....
; 0e The monster grabbed you you. You are dead!
; 0f You were wounded by the bush!
; 10 You are trapped in wire-nettings!

!if LANGUAGE = EN{
!scr "You fell into a          snake pit !              "
!scr "You'd better watched out for the sacred column!   "
!scr "You drowned in the deep  river !                  "
!scr "You drank from the       poisened bottle ........ "
!scr "Boris, the spider, got   you and killed you !     "
!scr "Didn't you see the       laser beam ?!?           "
!scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
!scr "You stepped on a nail !                           "
!scr "A foot trap stopped you !                         "
!scr "This room is doomed      by the wizard Manilo !   "
!scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
!scr "You were hit by a big    rock and died !          "
!scr "Belegro killed           you !                    "
!scr "You found a thirsty      zombie .......           "
!scr "The monster grapped       you. You are dead !     "
!scr "You were wounded by      the bush !               "
!scr "You are trapped in       wire-nettings !          "
}


!if LANGUAGE = DE{
!scr "Sie sind in eine         Schlangengrube gefallen !"
!scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
!scr "Sie sind in dem tiefen   Fluss ertrunken !        "
!scr "Sie haben aus der Gift-  flasche getrunken....... "
!scr "Boris, die Spinne, hat   Sie verschlungen !!      "
!scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
!scr "220 Volt !! Sie erlitten einen Elektroschock !    "
!scr "Sie sind in einen Nagel  getreten !               "
!scr "Eine Fussangel verhindertIhr Weiterkommen !       "
!scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
!scr "Sie wurden eingeschlossenund verhungern !         "
!scr "Sie wurden von einem     Stein ueberollt !!       "
!scr "Belegro hat Sie          vernichtet !             "
!scr "Im Sarg lag ein durstigerZombie........           "
!scr "Das Monster hat Sie      erwischt !!!!!           "
!scr "Sie haben sich an dem    Dornenbusch verletzt !   "
!scr "Sie haben sich im        Stacheldraht verfangen !!"
}

; ==============================================================================
;
; Display the death message
; End of game and return to start screen
; ==============================================================================

death:
                    lda #>death_messages
                    sta zpA8
                    lda #<death_messages
                    sta zpA7
                    cpy #$00
                    beq ++           ; beq $3ec4
-                   clc
                    adc #$32
                    sta zpA7
                    bcc +            ; bcc $3ec1
                    inc zpA8
+                   dey
                    bne -           ; bne $3eb8
++                  lda #$0c
                    sta zp03
                    sty zp02
                    ldx #$04
                    lda #$20
-                   sta (zp02),y
                    iny
                    bne -               ; bne $3ece
                    inc zp03
                    dex
                    bne -               ; bne $3ece
                    jsr set_charset_and_screen_for_title
-                   lda (zpA7),y
                    sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
                    lda #$00                                    ; color of the death message
                    sta COLRAM + $1c0,x     ; sta $09c0,x
                    inx
                    iny
                    cpx #$19
                    bne +               ; bne $3eed
                    ldx #$50
+                   cpy #$32
                    bne -               ; bne $3edb
                    lda #$fd
                    sta BG_COLOR
                    sta BORDER_COLOR
m3EF9:
                    lda #$08
-                   ldy #$ff
                    jsr wait           ; jsr $3a76
                    sec
                    sbc #$01
                    bne -               ; bne $3efb
                    jmp init            ; jmp $3ab3
; ==============================================================================
; screen messages
; and the code entry text
; ==============================================================================

!if LANGUAGE = EN{

hint_messages 
!scr " A part of the code number is :         "
!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
!scr " You need: bulb, bulb holder, socket !  "
!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
!scr " *****   A helping letter :   "
helping_letter !scr "C   ***** "
!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "

}

!if LANGUAGE = DE{

hint_messages 
!scr " Ein Teil des Loesungscodes lautet:     "
!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
!scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
!scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
!scr " *****   Ein Hilfsbuchstabe:  "
helping_letter !scr "C   ***** "
!scr " Falscher Loesungscode ! TODESSTRAFE !!!"

}

; ==============================================================================

; jsr $c56b        Aufruf print Routine ?!?
;                   im PLUS/4 ROM:
;
; .C:c56b  A9 93       LDA #$93
; .C:c56d  4C D2 FF    JMP $FFD2        ; Output (print usually)($EC4B)
;
; .C:ffd2  6C 24 03    JMP ($0324)      ; Vector bei $0324 steht auf $EC4B
;
