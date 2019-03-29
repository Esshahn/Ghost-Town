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

START_ROOM          = 0            ; default 0 
PLAYER_START_POS_X  = 3             ; default 3
PLAYER_START_POS_Y  = 6             ; default 6
SILENT_MODE         = 0


; ==============================================================================
; ZEROPAGE

zp02                = $02
zp03                = $03
zp04                = $04
zp05                = $05            ; seems to always store the COLRAM information
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
SCREENRAM           = $0C00            ; PLUS/4 default SCREEN
COLRAM              = $0800            ; PLUS/4 COLOR RAM
PRINT_KERNAL        = $c56b
BASIC_DA89          = $da89            ; scroll screen down?
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
                    beq ++              
-                   clc
                    adc #$28
                    bcc +               
                    inc zpA8
+                   dey
                    bne -               
++                  sta zpA7
                    jsr set_charset_and_screen_for_title          
                    ldy #$27
-                   lda (zpA7),y
                    sta SCREENRAM+$1B8,y 
                    lda #$07
                    sta COLRAM+$1B8,y 
                    dey
                    bne -               
                    rts

; ==============================================================================
                    ;sta BORDER_COLOR          ; ?!? womöglich unbenutzt ?!?
                    ;rts
; ==============================================================================
; TODO: understand this one, it gets called a lot

prep_and_display_hint:

                    jsr switch_charset           
                    cpy #$03                                ; is the display hint the one for the code number?
                    beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
                    jmp display_hint                        ; no, display the hint


room_16_code_number_prep:

                    jsr display_hint_message                ; yes we are in room 3
                    jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
                    jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
                    ldy #$01                                ; y = 1
                    jsr display_hint_message              
                    ldx #$00                                ; x = 0
                    ldy #$00                                ; y = 0
                    beq room_16_enter_code                  ; room 16 code? how?

room_16_cursor_blinking: 

                    lda SCREENRAM+$1B9,x                    ; load something from screen
                    clc                                     
                    adc #$80                                ; add $80 = 128 = inverted char
                    sta SCREENRAM+$1B9,x                    ; store in the same location
                    lda SCREENRAM+$188,y                    ; and the same for another position
                    clc
                    adc #$80
                    sta SCREENRAM+$188,y 
                    rts

; ==============================================================================
; ROOM 16
; ENTER CODE
; ==============================================================================

room_16_enter_code:
                    jsr room_16_cursor_blinking
                    sty zp02
                    stx zp04
                    jsr m10A7           
                    jsr room_16_cursor_blinking           
                    jsr m10A7
                    lda #$fd                                        ; KEYBOARD stuff
                    sta KEYBOARD_LATCH                              ; .
                    lda KEYBOARD_LATCH                              ; .
                    lsr                                             ; .
                    lsr
                    lsr
                    bcs +
                    cpx #$00
                    beq +
                    dex
+                   lsr
                    bcs +
                    cpx #$25
                    beq +
                    inx
+                   and #$08
                    bne room_16_enter_code
                    lda SCREENRAM+$1B9,x
                    cmp #$bc
                    bne ++
                    cpy #$00
                    beq +
                    dey
+                   jmp room_16_enter_code
++                  sta SCREENRAM+$188,y
                    iny
                    cpy #$05
                    bne room_16_enter_code
                    jmp m10B4

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
                    jsr draw_border           ; jsr $3b02
                    jmp m3B4C           ; jmp $3b4c

; ==============================================================================
;
; ITEM PICKUP MESSAGES
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
item_pickup_message_end:

; ==============================================================================
;
; hint system (question marks)
; ==============================================================================


display_hint:
                    cpy #$00
                    bne m11A2           ; bne $11a2
                    jsr m1000
                    ldx current_room + 1
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
                    lda #>item_pickup_message
                    sta zpA8
                    lda #<item_pickup_message
                    jsr m1009
                    jmp -
; ==============================================================================
switch_charset:
                    jsr set_charset_and_screen_for_title           ; jsr $3a9d
                    jmp PRINT_KERNAL           ; jmp $c56b



; ==============================================================================
;
; JUMP TO ROOM LOGIC
; This code is new. Previously, code execution jumped from room to room
; and in each room did the comparison with the room number.
; This is essentially the same, but bundled in one place.
; ==============================================================================

check_room:
                    ldy current_room + 1        ; load in the current room number
                    cpy #0
                    bne +
                    jmp room_00
+                   cpy #1
                    bne +
                    jmp room_01
+                   cpy #2
                    bne +
                    jmp room_02
+                   cpy #3
                    bne +
                    jmp room_03
+                   cpy #4
                    bne +
                    jmp room_04
+                   cpy #4
                    bne +
                    jmp room_04
+                   cpy #5
                    bne +
                    jmp room_05
+                   cpy #6
                    bne +
                    jmp room_06
+                   cpy #7
                    bne +
                    jmp room_07
+                   cpy #8
                    bne +
                    jmp room_08
+                   cpy #9
                    bne +
                    jmp room_09
+                   cpy #10
                    bne +
                    jmp room_10
+                   cpy #11
                    bne +
                    jmp room_11 
+                   cpy #12
                    bne +
                    jmp room_12
+                   cpy #13
                    bne +
                    jmp room_13
+                   cpy #14
                    bne +
                    jmp room_14
+                   cpy #15
                    bne +
                    jmp room_15
+                   cpy #16
                    bne +
                    jmp room_16
+                   cpy #17
                    bne +
                    jmp room_17
+                   jmp room_18



; ==============================================================================

check_death:
                    jsr update_items_display
                    jmp m3B4C           

; ==============================================================================

m11E0:              
                    ldx #$00
-                   lda TAPE_BUFFER + $9,x              
                    cmp #$1e                            ; question mark
                    bcc check_next_char_under_player           
                    cmp #$df
                    beq check_next_char_under_player
                    jmp check_room              

; ==============================================================================

check_next_char_under_player:
                    inx
                    cpx #$09
                    bne -                              ; not done checking          
-                   jmp m3B4C           


; ==============================================================================
;
;                                                             ###        ###
;          #####      ####      ####     #    #              #   #      #   #
;          #    #    #    #    #    #    ##  ##             #     #    #     #
;          #    #    #    #    #    #    # ## #             #     #    #     #
;          #####     #    #    #    #    #    #             #     #    #     #
;          #   #     #    #    #    #    #    #              #   #      #   #
;          #    #     ####      ####     #    #               ###        ###
;
; ==============================================================================


room_00:

                    cmp #$a9                    ; has the player hit the gloves?
                    bne check_next_char_under_player                   ; no
                    lda #$df                    ; yes, load in char for "empty"
                    cmp items + $4d             ; position for 1st char of ladder ($b0) -> ladder already taken?
                    bne -                       ; no
                    jsr pickup_gloves           ; yes
                    bne check_death


pickup_gloves:
                    lda #$6b                    ; load character for empty bush
                    sta items + $8              ; store 6b = gloves in inventory
                    lda #$3d                    ; set the foreground color
                    sta items + $6              ; and store the color in the items table
                    rts






; ==============================================================================
;
;                                                             ###        #
;          #####      ####      ####     #    #              #   #      ##
;          #    #    #    #    #    #    ##  ##             #     #    # #
;          #    #    #    #    #    #    # ## #             #     #      #
;          #####     #    #    #    #    #    #             #     #      #
;          #   #     #    #    #    #    #    #              #   #       #
;          #    #     ####      ####     #    #               ###      #####
;
; ==============================================================================

room_01:

                    cmp #$e0                    ; empty character in charset -> invisible key
                    beq +                       ; yes, key is there -> +
                    cmp #$e1
                    bne ++
+                   lda #$aa                    ; display the key, $AA = 1st part of key
                    sta items + $10             ; store key in items list
                    jsr update_items_display    ; update all items in the items list (we just made the key visible)
                    ldy #$f0                    ; set waiting time
                    jsr wait                    ; wait
                    lda #$df                    ; set key to empty space
                    sta items + $10             ; update items list
                    bne check_death
++                  cmp #$27                    ; question mark (I don't know why 27)
                    bcs check_death_bush
                    ldy #$00
                    jmp prep_and_display_hint

check_death_bush:
                    cmp #$ad                    ; wirecutters
                    bne check_next_char_under_player
                    lda items + $8              ; inventory place for the gloves! 6b = gloves
                    cmp #$6b
                    beq +
                    ldy #$0f
                    jmp death                   ; 0f You were wounded by the bush!

+                   lda #$f9                    ; wirecutter picked up
                    sta items + $19
                    jmp check_death






; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #          #
;          #    #    #    #    #    #    # ## #             #     #     #####
;          #####     #    #    #    #    #    #             #     #    #
;          #   #     #    #    #    #    #    #              #   #     #
;          #    #     ####      ####     #    #               ###      #######
;
; ==============================================================================

room_02:

                    cmp #$f5                    ; did the player hit the fence? f5 = fence character
                    bne check_lock              ; no, check for the lock
                    lda items + $19             ; fence was hit, so check if wirecuter was picked up
                    cmp #$f9                    ; where the wirecutters (f9) picked up?
                    beq remove_fence            ; yes
                    ldy #$10                    ; no, load the correct death message
                    jmp death                   ; 10 You are trapped in wire-nettings!

remove_fence:
                    lda #$df                    ; empty char
                    sta m3900 + 1               ; m3900 must be the draw routine to clear out stuff?
m1264:              jmp check_death


check_lock:
                    cmp #$a6                    ; lock
                    bne +
                    lda items + $10
                    cmp #$df
                    bne m1264
                    lda #$df
                    sta items + $38
                    bne m1264
+                   cmp #$b1                    ; ladder
                    bne +
                    lda #$df
                    sta items + $4d
                    sta items + $58
                    bne m1264
+                   cmp #$b9                    ; bottle
                    beq +
                    jmp check_next_char_under_player
+                   lda items + $bb
                    cmp #$df                    ; df = empty spot where the hammer was. = hammer taken
                    beq take_key_out_of_bottle                                   ; beq $129a
                    ldy #$03
                    jmp death                   ; 03 You drank from the poisend bottle

take_key_out_of_bottle:
                    lda #$01
                    sta key_in_bottle_storage
                    ldy #$05
                    jmp prep_and_display_hint

; ==============================================================================
; this is 1 if the key from the bottle was taken and 0 if not

key_in_bottle_storage:              !byte $00









; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #          #
;          #    #    #    #    #    #    # ## #             #     #     #####
;          #####     #    #    #    #    #    #             #     #          #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_03:

                    cmp #$27                    ; question mark (I don't know why 27)
                    bcc +
                    jmp m3B4C
+                   ldy #$04
                    jmp prep_and_display_hint






; ==============================================================================
;
;                                                             ###      #
;          #####      ####      ####     #    #              #   #     #    #
;          #    #    #    #    #    #    ##  ##             #     #    #    #
;          #    #    #    #    #    #    # ## #             #     #    #    #
;          #####     #    #    #    #    #    #             #     #    #######
;          #   #     #    #    #    #    #    #              #   #          #
;          #    #     ####      ####     #    #               ###           #
;
; ==============================================================================

room_04:

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
                    jmp check_next_char_under_player
+                   lda #$00
                    sta m394A + 1                               ; sta $394b
                    ldy #$06
                    jmp prep_and_display_hint           ; jmp $1031






; ==============================================================================
;
;                                                             ###      #######
;          #####      ####      ####     #    #              #   #     #
;          #    #    #    #    #    #    ##  ##             #     #    #
;          #    #    #    #    #    #    # ## #             #     #    ######
;          #####     #    #    #    #    #    #             #     #          #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_05:

                    cmp #$27                                ; question mark (I don't know why 27)
                    bcs +                                   ; no
                    ldy #$00                                ; a = 0
                    jmp prep_and_display_hint

+                   cmp #$fd                                ; stone with breathing tube hit?
                    beq +                                   ; yes -> +
m12EC:              jmp check_next_char_under_player        ; no
+                   lda #$00                                ; a = 0
                    jmp m2FDF

; ==============================================================================

m12F4:              ldy #$07
                    jmp prep_and_display_hint           ; jmp $1031






; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #    #
;          #    #    #    #    #    #    # ## #             #     #    ######
;          #####     #    #    #    #    #    #             #     #    #     #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_06:

                    cmp #$f6            ; is it a trapped door?
                    bne m12EC                               ; bne $12ec
                    ldy #$00
m1303:              jmp death    ; 00 You fell into a snake pit






; ==============================================================================
;
;                                                             ###      #######
;          #####      ####      ####     #    #              #   #     #    #
;          #    #    #    #    #    #    ##  ##             #     #        #
;          #    #    #    #    #    #    # ## #             #     #       #
;          #####     #    #    #    #    #    #             #     #      #
;          #   #     #    #    #    #    #    #              #   #       #
;          #    #     ####      ####     #    #               ###        #
;
; ==============================================================================

room_07:

                    cmp #$e3            ; $e3 is the char for the invisible, I mean SACRED, column
                    bne +                                   ; bne $1312
                    ldy #$01            ; 01 You'd better watched out for the sacred column
                    bne m1303                               ; bne $1303
+                   cmp #$5f
                    bne m12EC                               ; bne $12ec
                    lda #$bc            ; light picked up
                    sta items + $74                        ; sta $36fe           ; but I dont understand how the whole light is shown
                    lda #$5f
                    sta items + $72                        ; sta $36fc
                    jsr update_items_display
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
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #    #     #
;          #    #    #    #    #    #    # ## #             #     #     #####
;          #####     #    #    #    #    #    #             #     #    #     #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_08:

                    ldy #$00
                    sty zpA7
                    cmp #$4b            ; water
                    bne check_item_water                    ; bne $135f
                    ldy m3993 + 1                           ; ldy $3994
                    bne m1366                               ; bne $1366
                    jsr get_player_pos
                    lda #$18
m1354:              sta player_pos_x + 1
                    lda #$0c
                    sta player_pos_y + 1
m135C:              jmp m3B4C           ; jmp $3b4c


; ==============================================================================

check_item_water:
                    cmp #$56        ; water character
                    bne check_item_shovel                   ; bne $1374
                    ldy m3993 + 1                           ; ldy $3994
m1366:              bne +                                   ; bne $136f
                    jsr get_player_pos
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
                    beq +
                    jmp check_next_char_under_player
+                   lda items + $bb                         ; hammer
                    cmp #$df
                    bne m135C                               ; bne $135c
                    lda #$df
                    sta items + $84                        ; sta $370e
                    bne m1381                               ; bne $1381






; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #    #     #
;          #    #    #    #    #    #    # ## #             #     #     ######
;          #####     #    #    #    #    #    #             #     #          #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_09:            

                    cmp #$27                        ; question mark (I don't know why 27)
                    bcc +
                    jmp check_next_char_under_player
+                   ldy #$02
                    jmp prep_and_display_hint






; ==============================================================================
;
;                                                             #        ###
;          #####      ####      ####     #    #              ##       #   #
;          #    #    #    #    #    #    ##  ##             # #      #     #
;          #    #    #    #    #    #    # ## #               #      #     #
;          #####     #    #    #    #    #    #               #      #     #
;          #   #     #    #    #    #    #    #               #       #   #
;          #    #     ####      ####     #    #             #####      ###
;
; ==============================================================================

room_10:

                    cmp #$27                        ; question mark (I don't know why 27)
                    bcs m13B3
                    ldy #$00
                    jmp prep_and_display_hint

; ==============================================================================

m13B3:
                    cmp #$cc
                    beq +                                   ; beq $13bb
                    cmp #$cf
                    beq +
                    jmp check_next_char_under_player
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
;
;                                                             #        #
;          #####      ####      ####     #    #              ##       ##
;          #    #    #    #    #    #    ##  ##             # #      # #
;          #    #    #    #    #    #    # ## #               #        #
;          #####     #    #    #    #    #    #               #        #
;          #   #     #    #    #    #    #    #               #        #
;          #    #     ####      ####     #    #             #####    #####
;
; ==============================================================================

room_11:

                    cmp #$d1
                    beq +
                    jmp check_next_char_under_player
+                   lda #$df                ; player takes the hammer
                    sta items + $bb                         ; hammer
                    bne m13CA                               ; bne $13ca






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #            #
;          #    #    #    #    #    #    # ## #               #       #####
;          #####     #    #    #    #    #    #               #      #
;          #   #     #    #    #    #    #    #               #      #
;          #    #     ####      ####     #    #             #####    #######
;
; ==============================================================================

room_12:

                    cmp #$27                        ; question mark (I don't know why 27)
                    bcs m13EE
                    ldy #$00
                    jmp prep_and_display_hint
; ==============================================================================

m13EE:
                    cmp #$d2
                    beq +                                   ; beq $13f6
                    cmp #$d5
                    beq +
                    jmp check_next_char_under_player
+                   lda #$df
                    sta items + $c8                        ; sta $3752
                    bne m13CA                               ; bne $13ca






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #            #
;          #    #    #    #    #    #    # ## #               #       #####
;          #####     #    #    #    #    #    #               #            #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_13:           

                    cmp #$27                        ; question mark (I don't know why 27)
                    bcs m140A
                    ldy #$00
                    jmp prep_and_display_hint

; ==============================================================================

m140A:
                    cmp #$d6
                    beq +
                    jmp check_next_char_under_player
+                   lda items + $84                        ; are the boots taken?
                    cmp #$df
                    beq m141A                               ; beq $141a
                    ldy #$07
                    jmp death    ; 07 You stepped on a nail!

; ==============================================================================

m141A:
                    lda #$e2
                    sta items + $d5                        ; sta $375f
                    bne m13CA                               ; bne $13ca






; ==============================================================================
;
;                                                             #      #
;          #####      ####      ####     #    #              ##      #    #
;          #    #    #    #    #    #    ##  ##             # #      #    #
;          #    #    #    #    #    #    # ## #               #      #    #
;          #####     #    #    #    #    #    #               #      #######
;          #   #     #    #    #    #    #    #               #           #
;          #    #     ####      ####     #    #             #####         #
;
; ==============================================================================

room_14:

                    cmp #$d7
                    beq +
                    jmp check_next_char_under_player
+                   ldy #$08
                    jmp death    ; 08 A foot trap stopped you!






; ==============================================================================
;
;                                                             #      #######
;          #####      ####      ####     #    #              ##      #
;          #    #    #    #    #    #    ##  ##             # #      #
;          #    #    #    #    #    #    # ## #               #      ######
;          #####     #    #    #    #    #    #               #            #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_15:

                    cmp #$27                        ; question mark (I don't know why 27)
                    bcs m143B
                    ldy #$00
                    jmp prep_and_display_hint

; ==============================================================================

m143B:
                    jmp check_next_char_under_player           ; jmp m13B0 -> target just jumps again, so replacing with target jmp address






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #      #
;          #    #    #    #    #    #    # ## #               #      ######
;          #####     #    #    #    #    #    #               #      #     #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_16:

                    cmp #$f4
                    bne +
                    ldy #$0a
-                   jmp death                               ; 0a You were locked in and starved!

+                   cmp #$d9
                    beq +
                    cmp #$db
                    bne ++
+                   ldy #$09                                ; 09 This room is doomed by the wizard Manilo!
                    bne -
++                  cmp #$b8
                    beq +
                    cmp #$bb
                    bne m143B
+                   ldy #$03
                    jmp prep_and_display_hint






; ==============================================================================
;
;                                                             #      #######
;          #####      ####      ####     #    #              ##      #    #
;          #    #    #    #    #    #    ##  ##             # #          #
;          #    #    #    #    #    #    # ## #               #         #
;          #####     #    #    #    #    #    #               #        #
;          #   #     #    #    #    #    #    #               #        #
;          #    #     ####      ####     #    #             #####      #
;
; ==============================================================================

room_17:

                    cmp #$dd
                    bne m143B
                    lda #$df
                    sta items + $1a7
                    jmp check_death






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #      #     #
;          #    #    #    #    #    #    # ## #               #       #####
;          #####     #    #    #    #    #    #               #      #     #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_18:
                    cmp #$81
                    bcs +                   
                    jmp check_death
+
                    lda key_in_bottle_storage           
                    bne +               
                    jmp m3B4C          
+                   jsr set_charset_and_screen_for_title
                    jmp print_endscreen

; ==============================================================================

room_14_prep:              
                    ldy current_room + 1                    ; load room number
                    cpy #14                                 ; is it #14?
                    bne room_15_prep                        ; no -> m148A
                    ldy #$20                                ; yes, wait a bit
                    jmp wait

; ==============================================================================

room_15_prep:              
                    cpy #15                                 ; room 15?
                    bne room_17_prep                        ; no -> m14C8
                    lda #$00
                    sta zpA7
                    ldy #$0c
m1494:              ldx #$06
                    jsr m3608
                    lda #$eb
                    sta zpA8
                    lda #$39
                    sta zp0A
                    ldx m1494 + 1           
m14A4:              lda #$01
                    bne m14B2               
                    cpx #$06
                    bne +                   
                    lda #$01
+                   dex
                    jmp +                   

; ==============================================================================

m14B2:              
                    cpx #$0b
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

room_17_prep:              
                    cpy #17                             ; room number 17?
                    bne +                               ; no -> +
m14CC:              lda #$01                            ; selfmod
                    beq ++                              
                    jmp m15C1                           
+                   lda #$0f                            ; a = $0f
                    sta m3624 + 1                       ; selfmod
                    sta m3626 + 1                       ; selfmod
                    cpy #10                             ; room number 10?
                    bne check_if_room_09                ; no -> m1523
                    dec speed_byte                      ; yes, reduce speed
                    beq laser_beam_animation            ; if positive -> laser_beam_animation            
++                  rts

; ==============================================================================
; ROOM 10
; LASER BEAM ANIMATION
; ==============================================================================

laser_beam_animation:

                    ldy #$08                            ; speed of the laser flashing
                    sty speed_byte                      ; store     
                    lda #$09
                    sta zp05                            ; affects the colram of the laser
                    lda #$0d                            ; but not understood yet
                    sta zp03
                    lda #$7b                            ; position of the laser
                    sta zp02
                    sta zp04
                    lda #$df                            ; laser beam off
                    cmp m1506 + 1                       
                    bne +                               
                    lda #$d8                            ; laser beam
+                   sta m1506 + 1                       
                    ldx #$06                            ; 6 laser beam characters
m1506:              lda #$df
                    ldy #$00
                    sta (zp02),y
                    lda #$ee
                    sta (zp04),y
                    lda zp02
                    clc
                    adc #$28                            ; draws the laser beam
                    sta zp02
                    sta zp04
                    bcc +                               
                    inc zp03
                    inc zp05
+                   dex
                    bne m1506                           
-                   rts

; ==============================================================================

check_if_room_09:              
                    cpy #09                         ; room number 09?
                    beq +                           ; yes -> +
                    rts                             ; no
+                   jmp room_09_counter             ; room number is 09, jump

; ==============================================================================
; ROOM 09
; BORIS THE SPIDER ANIMATION
; ==============================================================================

boris_the_spider_animation:

                    inc room_09_counter + 1                           
                    lda #$08                                ; affects the color ram position for boris the spider
                    sta zp05
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
                    jsr move_boris                       
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
                    jsr move_boris                       
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

move_boris:
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc +                                   
                    inc zp03
                    inc zp05
+                   rts

; ==============================================================================
;
;
; ==============================================================================

room_09_counter:
                    ldx #$01                                ; x = 1 (selfmod)
                    cpx #$01                                ; is x = 1?
                    beq +                                   ; yes -> +
                    jmp boris_the_spider_animation          ; no, jump boris animation
+                   dec room_09_counter + 1                 ; decrease initial x
                    rts

; ==============================================================================

m15C1:              lda #$00                                ; a = 0 (selfmod)
                    cmp #$00                                ; is a = 0?
                    bne m15CB                               ; not 0 -> 15CB
                    inc m15C1 + 1                           ; inc m15C1
                    rts

; ==============================================================================

m15CB:              
                    dec m15C1 + 1                           ; dec $15c2
                    jmp belegro_animation

; ==============================================================================
; ROOM 17
; STONE ANIMATION
; ==============================================================================

room_17_stone_animation:

                    lda items + $ac                         ; $cc (power outlet)
                    cmp #$df                                ; taken?
                    bne +                                   ; no -> +
                    lda #$59                                ; yes, $59 (part of water, wtf)
                    sta items + $12c                        ; originally $0
+                   lda current_room + 1                    ; load room number
                    cmp #$11                                ; is it room #17? (Belegro)
                    bne m162A                               ; no -> m162A
                    lda m14CC + 1                           ; yes, get value from m14CD
                    bne m15FC                               ; 0? -> m15FC
                    lda player_pos_y + 1                    ; not 0, get player pos Y
                    cmp #$06                                ; is it 6?
                    bne m15FC                               ; no -> m15FC
                    lda player_pos_x + 1                    ; yes, get player pos X
                    cmp #$18                                ; is player x position $18?
                    bne m15FC                               ; no -> m15FC
                    lda #$00                                ; yes, load 0
                    sta m15FC + 1                           ; store 0 in m15FC+1
m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
                    bne +                                   ; is it 0? -> +
                    ldy #$06                                ; y = $6
m1602:              ldx #$1e                                ; x = $1e
                    lda #$00                                ; a = $0
                    sta zpA7                                ; zpA7 = 0
                    jsr m3608                               ; TODO
                    ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
                    cpx #$03                                ; is X = $3?
                    beq ++                                  ; yes -> ++
                    dex                                     ; x = x -1
++                  stx m1602 + 1                           ; store x in m1602+1
+                   lda #$78                                ; a = $78
                    sta zpA8                                ; zpA8 = $78
                    lda #$49                                ; a = $49
                    sta zp0A                                ; zp0A = $49
                    ldy #$06                                ; y = $06
                    lda #$01                                ; a = $01
                    sta zpA7                                ; zpA7 = $01
                    ldx m1602 + 1                           ; get stored x value (should still be the same?)
                    jsr m3608                               ; TODO
m162A:              jmp room_14_prep                        


; ==============================================================================

m162d:
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x                   ; cassette tape buffer
                    sta TAPE_BUFFER + $18,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
                    dex
                    bne -                       
                    lda #$02
                    sta zpA7
                    ldx player_pos_x + 1
                    ldy player_pos_y + 1
                    jsr m3608
                    ldx #$09
m1647:              lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
                    cmp #$d8
                    bne +                  
m164E:              ldy #$05
m1650:              jmp death                               ; 05 Didn't you see the laser beam?

; ==============================================================================

+                   ldy current_room + 1
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

m1676:              cmp #$e4                        ; hit by Boris the spider?
                    bcc +                           
                    cmp #$eb
                    bcs ++                          
-                   ldy #$04                        ; 04 Boris the spider got you and killed you
                    bne m1650                       
++                  cmp #$f4
                    bcs +                           
                    ldy #$0e                        ; 0e The monster grabbed you you. You are dead!
                    bne m1650                       
+                   dex
                    bne m1647                       
                    ldx #$09
--                  lda $034b,x
                    sta TAPE_BUFFER + $8,x          ; the tape buffer stores the chars UNDER the player (9 in total)
                    cmp #$d8
                    beq m164E                       
                    cmp #$e4
                    bcc +                           
                    cmp #$ea
                    bcc -                           
+                   dex
                    bne --                          
                    jmp m11E0                     

m16A7:
                    ldy items + $1a7                
                    cpy #$df
                    beq +                           
                    ldy #$0c                        ; 0c Belegro killed you!
                    bne m1650                       
+                   ldy #$00
                    sty m14CC + 1                   
                    jmp m1676                       








; ==============================================================================
; this might be the inventory/ world reset
; puts all items into the level data again
; maybe not. not all characters for e.g. the wirecutter is put back
; addresses are mostly within items.asm address space ( $368a )
; contains color information of the chars
; ==============================================================================

reset_items:
                    lda #$a5                        ; $a5 = lock of the shed
                    sta items + $38

                    lda #$a9                        ;
                    sta items + $8                  ; gloves
                    lda #$79
                    sta items + $6                  ; gloves color

                    lda #$e0                        ; empty char
                    sta items + $10                 ; invisible key

                    lda #$ac                        ; wirecutter
                    sta items + $19

                    lda #$b8                        ; bottle
                    sta items + $29

                    lda #$b0                        ; ladder
                    sta items + $4d
                    lda #$b5                        ; more ladder
                    sta items + $58

                    lda #$5e                        ; seems to be water?
                    sta items + $74

                    lda #$c6                        ; boots in the whatever box
                    sta items + $84

                    lda #$c0                        ; shovel
                    sta items + $96

                    lda #$cc                        ; power outlet
                    sta items + $ac

                    lda #$d0                        ; hammer
                    sta items + $bb

                    lda #$d2                        ; light bulb
                    sta items + $c8

                    lda #$d6                        ; nails
                    sta items + $d5

                    lda #$00                        ; door
                    sta items + $12c

                    lda #$dd                        ; sword
                    sta items + $1a7

                    lda #$01                        ; door
                    sta items + $2c1

                    lda #$01                        ; door
                    sta items + $30a

                    lda #$f5                        ; fence
                    sta items + $277

                    lda #$00                        ; key in the bottle
                    sta key_in_bottle_storage

                    lda #$01                        ; door
                    sta m15FC + 1

                    lda #$1e
                    sta m1602 + 1

                    lda #$01
                    sta m14CC + 1

m1732:              ldx #$05
                    cpx #$07
                    bne +
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



screen_win_src:
                    !if LANGUAGE = EN{
                        !bin "includes/screen-win-en.scr"
                    }
                    !if LANGUAGE = DE{
                        !bin "includes/screen-win-de.scr"
                    }
screen_win_src_end:


; ==============================================================================
;
; PRINT WIN SCREEN
; ==============================================================================

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

; ==============================================================================
;
; DISPLAY INTRO TEXT
; ==============================================================================

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
                    sta music_volume+1         ; sta $1ed9    ; sound volume
                    rts





; ==============================================================================
; MUSIC
; ==============================================================================
                    !zone MUSIC
music_data:         !source "includes/music_data.asm"
; ==============================================================================
music_get_data:
.voice1_dur_pt:     ldy #$00
                    bne +
                    lda #$40
                    sta music_voice1+1
                    jsr music_voice1
.voice1_dat_pt:     ldx #$00
                    lda music_data_voice1,x
                    inc .voice1_dat_pt+1
                    tay
                    and #$1f
                    sta music_voice1+1
                    tya
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    tay
+                   dey
                    sty .voice1_dur_pt + 1
.voice2_dur_pt:     ldy #$00
                    bne +
                    lda #$40
                    sta music_voice2 + 1
                    jsr music_voice2
.voice2_dat_pt:     ldx #$00
                    lda music_data_voice2,x
                    tay
                    inx
                    cpx #$65
                    beq music_reset
                    stx .voice2_dat_pt + 1
                    and #$1f
                    sta music_voice2 + 1
                    tya
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    tay
+                   dey
                    sty .voice2_dur_pt + 1
                    jsr music_voice1
                    jmp music_voice2
; ==============================================================================
music_reset:        lda #$00
                    sta .voice1_dur_pt + 1
                    sta .voice1_dat_pt + 1
                    sta .voice2_dur_pt + 1
                    sta .voice2_dat_pt + 1
                    jmp music_get_data
; ==============================================================================
; write music data for voice1 / voice2 into TED registers
; ==============================================================================
music_voice1:       ldx #$04
                    cpx #$1c
                    bcc +
                    lda VOLUME_AND_VOICE_SELECT
                    and #$ef
                    jmp writeFF11
+                   lda freq_tab_lo,x
                    sta VOICE1_FREQ_LOW
                    lda VOICE1
                    and #$fc
                    ora freq_tab_hi, x
                    sta VOICE1
                    lda VOLUME_AND_VOICE_SELECT
                    ora #$10
writeFF11           sta VOLUME_AND_VOICE_SELECT
                    rts
; ==============================================================================
music_voice2:       ldx #$0d
                    cpx #$1c
                    bcc +
                    lda VOLUME_AND_VOICE_SELECT
                    and #$df
                    jmp writeFF11
+                   lda freq_tab_lo,x
                    sta VOICE2_FREQ_LOW
                    lda VOICE2
                    and #$fc
                    ora freq_tab_hi,x
                    sta VOICE2
                    lda VOLUME_AND_VOICE_SELECT
                    ora #$20
                    sta VOLUME_AND_VOICE_SELECT
                    rts
; ==============================================================================
; TED frequency tables
; ==============================================================================
freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
                    !byte $04, $3b, $54, $83, $ad, $c0, $e3
                    !byte $02, $1e, $2a, $42, $56, $60, $71
                    !byte $81, $8f, $95
freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
                    !byte $02, $02, $02, $02, $02, $02, $02
                    !byte $03, $03, $03, $03, $03, $03, $03
                    !byte $03, $03, $03
; ==============================================================================
                    MUSIC_DELAY_INITIAL   = $09
                    MUSIC_DELAY           = $0B
music_play:         ldx #MUSIC_DELAY_INITIAL
                    dex
                    stx music_play+1
                    beq +
                    rts
+                   ldx #MUSIC_DELAY
                    stx music_play+1
                    lda VOLUME_AND_VOICE_SELECT
                    ora #$37
music_volume:       and #$bf
                    sta VOLUME_AND_VOICE_SELECT
                    jmp music_get_data







; ==============================================================================
; irq init
; ==============================================================================
                    !zone IRQ
irq_init0:          sei
                    lda #<irq0          ; lda #$06
                    sta $0314          ; irq lo
                    lda #>irq0          ; lda #$1f
                    sta $0315          ; irq hi
                                        ; irq at $1F06
                    lda #$02
                    sta $ff0a          ; set IRQ source to RASTER

                    lda #$bf
                    sta music_volume+1         ; sta $1ed9    ; sound volume
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
                    DEC INTERRUPT

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
                    lda music_volume+1         ; lda $1ed9           ; sound volume
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
                    sta music_volume+1         ; sta $1ed9             ; sound volume
                    jmp --              ; jmp $1f18



                    ; 222222222222222         000000000          000000000          000000000
                    ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
                    ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
                    ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
                    ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
                    ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
                    ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
                    ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
                    ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
                    ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
                    ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
                    ;22222222222222222222     000000000          000000000          000000000

; ==============================================================================
; CHARSET
; $2000 - $2800
; ==============================================================================


charset_start:
                    *= $2000
                    !if EXTENDED {
                        !bin "includes/charset-new-charset.bin"
                    }else{
                        !bin "includes/charset.bin"
                    }
charset_end:    ; $2800


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
; LEVEL DATA
; Based on tiles
;                     !IMPORTANT!
;                     has to be page aligned or
;                     display_room routine will fail
; ==============================================================================

                    *= $2800
level_data:
                    !source "includes/levels.asm"
level_data_end:

!if 1=2{
!byte $00, $00, $00, $00, $00, $00, $00
}


;$2fbf
speed_byte:
!byte $01



; ==============================================================================
;
;
; ==============================================================================

m2fCB:              
                    lda current_room + 1
                    cmp #$04
                    bne ++
                    lda #$03
                    ldy m394A + 1
                    beq +
                    lda #$f6
+                   sta SCREENRAM + $f9 
++                  rts

; ==============================================================================
;
;
; ==============================================================================

m2FDF:              
                    ldy items + $96     
                    cpy #$df
                    bne +               
                    sta m3993 + 1       
                    jmp m12F4
+                   jmp m3B4C

m2FEF:
                    jsr poll_raster
                    jsr check_door 
                    jmp room_17_stone_animation           




!if 1=2{
; $2ffd
unknown: ; haven't found a call for this code area yet. might be waste
!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
!byte $00
}

; ==============================================================================
;
; tileset definition
; these are the first characters in the charset of each tile.
; example: rocks start at $0c and span 9 characters in total
; ==============================================================================

tileset_definition:
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

; ==============================================================================
;
; displays a room based on tiles
; ==============================================================================

display_room:
                    jsr draw_border
                    lda #$00
                    sta zp02
                    ldx #>COLRAM        ; HiByte of COLRAM
                    stx zp05
                    ldx #>SCREENRAM     ; HiByte of SCREENRAM
                    stx zp03
                    ldx #>level_data    ; HiByte of level_data
                    stx zp0A            ; in zp0A
current_room:       ldx #$01            ; current_room in X
                    beq ++              ; if 0 -> skip
-                   clc                 ; else
                    adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
                    bcc +               ; to zp09/zp0A
                    inc zp0A            ;
+                   dex                 ; X times
                    bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
++                  sta zp09            ; LoByte from above
                    ldy #$00
                    sty zpA8
                    sty zpA7
m3066:              lda (zp09),y        ; get Tilenumber
                    tax                 ; in X
                    lda tiles_colors,x  ; get Tilecolor
                    sta zp10            ; => zp10
                    lda tiles_chars,x   ; get Tilechar
                    sta zp11            ; => zp11
                    ldx #$03            ; (3 rows)
--                  ldy #$00
-                   lda zp02            ; LoByte of SCREENRAM pointer
                    sta zp04            ; LoByte of COLRAM pointer
                    lda zp11            ; Load Tilechar
                    sta (zp02),y        ; to SCREENRAM + Y
                    lda zp10            ; Load Tilecolor
                    sta (zp04),y        ; to COLRAM + Y
                    lda zp11            ; Load Tilechar again
                    cmp #$df            ; if empty tile
                    beq +               ; -> skip
                    inc zp11            ; else: Tilechar + 1
+                   iny                 ; Y = Y + 1
                    cpy #$03            ; Y = 3 ? (Tilecolumns)
                    bne -               ; no -> next Char
                    lda zp02            ; yes:
                    clc
                    adc #$28            ; next SCREEN row
                    sta zp02
                    bcc +
                    inc zp03
                    inc zp05            ; and COLRAM row
+                   dex                 ; X = X - 1
                    bne --              ; X != 0 -> next Char
                    inc zpA8            ; else: zpA8 = zpA8 + 1
                    inc zpA7            ; zpA7 = zpA7 + 1
                    lda #$75            ; for m30B8 + 1
                    ldx zpA8
                    cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
                    bcc +               ; yes: -> skip (-$75 for next Tile)
                    ldx zpA7            ; else:
                    cpx #$66            ; zpA7 >= $66
                    bcs display_door    ; yes: display_door
                    lda #$00            ; else:
                    sta zpA8            ; clear zpA8
                    lda #$24            ; for m30B8 + 1
+                   sta m30B8 + 1       ;
                    lda zp02
                    sec
m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
                    sta zp02
                    bcs +
                    dec zp03
                    dec zp05
+                   ldy zpA7
                    jmp m3066
                    rts                 ; will this ever be used?
display_door:       lda #>SCREENRAM
                    sta zp03
                    lda #>COLRAM
                    sta zp05
                    lda #$00
                    sta zp02
                    sta zp04
-                   ldy #$28
                    lda (zp02),y        ; read from SCREENRAM
                    cmp #$06            ; $06 (part from Door?)
                    bcs +               ; >= $06 -> skip
                    sec                 ; else:
                    sbc #$03            ; subtract $03
                    ldy #$00            ; set Y = $00
                    sta (zp02),y        ; and copy to one row above
                    lda #$39            ; color brown - luminance $3
                    sta (zp04),y
+                   lda zp02
                    clc
                    adc #$01            ; add 1 to SCREENRAM pointer low
                    bcc +
                    inc zp03            ; inc pointer HiBytes if necessary
                    inc zp05
+                   sta zp02
                    sta zp04
                    cmp #$98            ; SCREENRAM pointer low = $98
                    bne -               ; no -> loop
                    lda zp03            ; else:
                    cmp #>(SCREENRAM+$300)
                    bne -               ; no -> loop
                    rts                 ; else: finally ready with room display

; ==============================================================================

print_title:        lda #>SCREENRAM       ; lda #$0c
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

; ==============================================================================
; TITLE SCREEN DATA
;
; ==============================================================================

screen_start_src:

                    !if EXTENDED {
                        !bin "includes/screen-start-extended.scr"
                    }else{
                        !bin "includes/screen-start.scr"
                    }

screen_start_src_end:


; ==============================================================================
; i think this might be the draw routine for the player sprite
;
; ==============================================================================


draw_player:
                    lda #>COLRAM                        ; store colram high in zp05
                    sta zp05
                    lda #>SCREENRAM                     ; store screenram high in zp03
                    sta zp03
                    lda #$00
                    sta zp02
                    sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
                    cpy #$00                            ; Y is probably the player Y position
                    beq +                               ; Y is 0 -> +
-                   clc                                 ; Y not 0
                    adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
                    bcc ++                              ; <256? -> ++
                    inc zp03
                    inc zp05
++                  dey                                 ; Y = Y - 1
                    bne -                               ; Y = 0 ? -> -
+                   clc                                 ;
m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
                    sta zp02
                    sta zp04
                    bcc +
                    inc zp03
                    inc zp05
+                   ldx #$03                            ; draw 3 rows for the player "sprite"
                    lda #$00
                    sta zp09
--                  ldy #$00
-                   lda zpA7
                    bne +
                    lda #$df                            ; empty char, but not sure why
                    sta (zp02),y
                    bne ++
+                   cmp #$01
                    bne +
                    lda zpA8
                    sta (zp02),y
                    lda zp0A
                    sta (zp04),y
                    bne ++
+                   lda (zp02),y
                    stx zp10
                    ldx zp09
                    sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
                    inc zp09
                    ldx zp10
++                  inc zpA8
                    iny
                    cpy #$03                            ; width of the player sprite in characters (3)
                    bne -
                    lda zp02
                    clc
                    adc #$28                            ; $28 = #40, draws one row of the player under each other
                    sta zp02
                    sta zp04
                    bcc +
                    inc zp03
                    inc zp05
+                   dex
                    bne --
                    rts


; ==============================================================================
; $359b
; JOYSTICK CONTROLS
; ==============================================================================

check_joystick:

                    lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
player_pos_y:       ldy #$09
player_pos_x:       ldx #$15
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
                    jsr draw_player           ; jsr $3534
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x      ; lda $033b,x
                    cmp #$df
                    beq +                   ; beq $35e4
                    cmp #$e2
                    bne ++                  ; bne $35f1
+                   dex
                    bne -                   ; bne $35d9
m35E7:              lda #$0a
                    sta player_pos_y + 1
m35EC:              lda #$15
                    sta player_pos_x + 1
++                  lda #$ff
                    sta KEYBOARD_LATCH
                    lda #$01
                    sta zpA7
                    lda #$93                ; first character of the player graphic
                    sta zpA8
                    lda #$3d
                    sta zp0A
get_player_pos:     ldy player_pos_y + 1
                    ldx player_pos_x + 1
m3608:              stx m3548 + 1           ; stx $3549
                    jmp draw_player           ; jmp $3534

; ==============================================================================
;
; POLL RASTER
; ==============================================================================

poll_raster:
                    sei                     ; disable interrupt
                    lda #$c0                ; A = $c0
-                   cmp $ff1d               ; vertical line bits 0-7
                    bne -                   ; loop until we hit line c0
                    lda #$00                ; A = 0
                    sta zpA7                ; zpA7 = 0

                    jsr get_player_pos
                    jsr check_joystick
                    cli
                    rts


; ==============================================================================
; ROOM 16
; BELEGRO ANIMATION
; ==============================================================================

belegro_animation:

                    lda #$00
                    sta zpA7
m3624:              ldx #$0f
m3626:              ldy #$0f
                    jsr m3608
                    ldx m3624 + 1
                    ldy m3626 + 1
                    cpx player_pos_x + 1
                    bcs +
                    inx
                    inx
+                   cpx player_pos_x + 1
                    beq +
                    dex
+                   cpy player_pos_y + 1
                    bcs +
                    iny
                    iny
+                   cpy player_pos_y + 1
                    beq +
                    dey
+                   stx m3668 + 1
                    stx m3548 + 1
                    sty m366D + 1
                    lda #$02
                    sta zpA7
                    jsr draw_player
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x
                    cmp #$92
                    bcc +
                    dex
                    bne -
m3668:              ldx #$10
                    stx m3624 + 1
m366D:              ldy #$0e
                    sty m3626 + 1
+                   lda #$9c                                ; belegro chars
                    sta zpA8
                    lda #$3e
                    sta zp0A
                    ldy m3626 + 1
                    ldx m3624 + 1
                    stx m3548 + 1
                    lda #$01
                    sta zpA7
                    jmp draw_player


; ==============================================================================
; items
; This area seems to be responsible for items placement
;
; ==============================================================================

items:
                    !source "includes/items.asm"
items_end:

next_item:
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

update_items_display:
                    lda #>items                 ; load address for items into zeropage
                    sta zpA8
                    lda #<items
                    sta zpA7
                    ldy #$00                    ; y = 0
--                  lda (zpA7),y                ; load first value
                    cmp #$ff                    ; is it $ff?
                    beq +                       ; yes -> +
-                   jsr next_item               ; no -> set zero page to next value
                    jmp --                      ; and loop
+                   jsr next_item               ; value was $ff, now get the next value in the list
                    lda (zpA7),y
                    cmp #$ff                    ; is the next value $ff again?
                    beq m38DF                   ; yes -> m38DF
                    cmp current_room + 1        ; is the number the current room number?
                    bne -                       ; no -> loop
                    lda #>COLRAM                ; yes the number is the current room number
                    sta zp05                    ; store COLRAM and SCREENRAM in zeropage
                    lda #>SCREENRAM
                    sta zp03
                    lda #$00                    ; A = 0
                    sta zp02                    ; zp02 = 0, zp04 = 0
                    sta zp04
                    jsr next_item               ; move to next value
                    lda (zpA7),y                ; get next value in the list
-                   cmp #$fe                    ; is it $FE?
                    beq +                       ; yes -> +
                    cmp #$f9                    ; no, is it $f9?
                    bne +++                     ; no -> +++
                    lda zp02                    ; value is $f9
                    jsr m38D7                   ; add 1 to zp02 and zp04
                    bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
+                   inc zp03                    ; value is $fe
                    inc zp05                    ; increase zp03 and zp05
++                  lda (zpA7),y                ; get value from list
+++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
                    bne +                       ; no -> +
                    jsr next_item               ; yes it's $fb, get the next value
                    lda (zpA7),y                ; get value from list
                    sta zp09                    ; store value in zp09
                    bne ++                      ; if value was 0 -> ++
+                   cmp #$f8
                    beq +
                    cmp #$fc
                    bne +++
                    lda zp0A
                    jmp m399F
+++                 cmp #$fa
                    bne ++
                    jsr next_item
                    lda (zpA7),y
                    sta zp0A
m38B7:
+                   lda zp09
                    sta (zp04),y
                    lda zp0A
                    sta (zp02),y
++                  cmp #$fd
                    bne +
                    jsr next_item
                    lda (zpA7),y
                    sta zp02
                    sta zp04
+                   jsr next_item
                    lda (zpA7),y
                    cmp #$ff
                    bne -
                    beq m38DF
m38D7:              clc
                    adc #$01
                    sta zp02
                    sta zp04
                    rts

; ==============================================================================
;
;
; ==============================================================================

m38DF:              lda current_room + 1
                    cmp #$02                                ; is the current room 02?
                    bne room_07_make_sacred_column          ; no 
                    lda #$0d                                ; yes room is 02
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

room_07_make_sacred_column:

                    cmp #$07                                    ; is the current room 07?
                    bne room_06_make_deadly_doors               ; no
                    ldx #$17                                    ; yes
-                   lda SCREENRAM + $168,x     
                    cmp #$df
                    bne +                       
                    lda #$e3
                    sta SCREENRAM + $168,x    
+                   dex
                    bne -                      
                    rts


; ==============================================================================
; ROOM 06
; PREPARE THE DEADLY DOORS
; ==============================================================================

room_06_make_deadly_doors:

                    cmp #$06                                    ; is the current room 06?
                    bne room_04_put_zombies_in_the_coffins
                    lda #$f6                                    ; char for wrong door
                    sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
                    sta SCREENRAM + $27c
                    sta SCREENRAM + $36c       
                    rts

; ==============================================================================
; ROOM 04
; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
; ==============================================================================

room_04_put_zombies_in_the_coffins: 

                    cmp #$04                                    ; is the current room 04?
                    bne room_05_prep                            ; no
                    ldx #$f7                                    ; yes room 04
                    ldy #$f8
m394A:              lda #$01
                    bne m3952           
                    ldx #$3b
                    ldy #$42
m3952:              lda #$01                                    ; some self mod here
                    cmp #$01
                    bne +           
                    stx SCREENRAM+ $7a 
+                   cmp #$02
                    bne +           
                    stx SCREENRAM + $16a   
+                   cmp #$03
                    bne +           
                    stx SCREENRAM + $25a       
+                   cmp #$04
                    bne +           
                    stx SCREENRAM + $34a   
+                   cmp #$05
                    bne +           
                    sty SCREENRAM + $9c    
+                   cmp #$06
                    bne +           
                    sty SCREENRAM + $18c   
+                   cmp #$07
                    bne +           
                    sty SCREENRAM + $27c 
+                   cmp #$08
                    bne +           
                    sty SCREENRAM + $36c   
+                   rts

; ==============================================================================
; ROOM 05
; HIDE THE BREATHING TUBE UNDER THE STONE
; ==============================================================================

room_05_prep:                  
                    cmp #$05                                    ; is the current room 02?
                    bne ++                                      ; no, and I'm done with you guys!
+                   lda #$fd                                    ; yes
m3993:              ldx #$01
                    bne +                                       ; based on self mod, put the normal
                    lda #$7a                                    ; stone char back again
+                   sta SCREENRAM + $2d2   
++                  rts


; ==============================================================================

!if 1=2 {
m399D:
                    rts

!byte $ff
}

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

; ==============================================================================
;
;
; ==============================================================================

check_door:

                    ldx #$09                ; set loop to 9
-                   lda TAPE_BUFFER + $8,x  ; get value from tape buffer
                    cmp #$05                ; is it a 05? -> right side of the door, meaning LEFT DOOR
                    beq m3A08               ; yes -> m3A08
                    cmp #$03                ; is it a 03? -> left side of the door, meaning RIGHT DOOR
                    beq m3A17               ; yes -> m3A17
                    dex                     ; decrease loop
                    bne -                   ; loop
-                   rts

; ==============================================================================
;
;
; ==============================================================================

m3A08:              ldx current_room + 1
                    beq -               ;beq $3a07
                    dex
                    jmp m3A64           ; jmp $3a64

!if 1=2{
!byte $34, $38, $32, $38, $02, $ff
}

m3A17:
                    ldx current_room + 1
                    inx
                    stx current_room + 1
                    ldy m3A33 + $17, x         ; ldy $3a4a,x
m3A21:              lda m39AA,y                ; lda $39aa,y
                    sta player_pos_y + 1
                    lda m39AA + 1,y            ; lda $39ab,y
                    sta player_pos_x + 1
m3A2D:              jsr display_room           ; jsr $3040
                    jmp update_items_display



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
                    stx current_room + 1                           ; stx $3051
                    ldy m3A33,x                             ; ldy $3A33,x
                    jmp m3A21                               ; jmp $3A21


; ==============================================================================
;
; wait routine
; usually called with Y set before
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
; start of game (original $3ab3)
; ==============================================================================

code_start:
init:
                    jsr m1F15           ; jsr $1f15
                    lda #$01
                    sta BG_COLOR          ; background color
                    sta BORDER_COLOR          ; border color
                    jsr reset_items           ; might be a level data reset, and print the title screen
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
                    jsr draw_border
                    jmp set_start_screen           ; jmp $3b3a
; ==============================================================================
draw_border:        ; draws the extended "border"
                    lda #$27
                    sta zp02
                    sta zp04
                    lda #>COLRAM
                    sta zp05
                    lda #>SCREENRAM
                    sta zp03
                    ldx #$18
                    ldy #$00
-                   lda #$5d
                    sta (zp02),y
                    lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
                    sta (zp04),y
                    tya
                    clc
                    adc #$28
                    tay
                    bcc +
                    inc zp03
                    inc zp05
+                   dex
                    bne -
-                   lda #$5d
                    sta SCREENRAM + $3c0,x
                    lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
                    sta COLRAM + $3c0,x
                    inx
                    cpx #$28
                    bne -
                    rts

; ==============================================================================
; SETUP FIRST ROOM
; player xy position and room number
; ==============================================================================

set_start_screen:
                    lda #PLAYER_START_POS_Y
                    sta player_pos_y + 1               ; Y player start position (0 = top)
                    lda #PLAYER_START_POS_X
                    sta player_pos_x + 1               ; X player start position (0 = left)
                    lda #START_ROOM              ; room number (start screen) ($3b45)
                    sta current_room + 1
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

hint_messages:
!scr " A part of the code number is :         "
!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
!scr " You need: bulb, bulb holder, socket !  "
!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
!scr " *****   A helping letter :   "
helping_letter: !scr "C   ***** "
!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "

}

!if LANGUAGE = DE{

hint_messages:
!scr " Ein Teil des Loesungscodes lautet:     "
!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
!scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
!scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
!scr " *****   Ein Hilfsbuchstabe:  "
helping_letter: !scr "C   ***** "
!scr " Falscher Loesungscode ! TODESSTRAFE !! "

}
