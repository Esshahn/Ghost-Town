; input filename:    gt3ab3.prg
; skip bytes:        2
; ==============================================================================
SILENT_MODE         = 0
KANNDOCHNICHWEG     = 1
EXTENDED            = 1                ; 0 = original version, 1 = tweaks and cosmetics

; ==============================================================================
; KERNAL / BASIC ROM CALLS
PRINT               = $c56b
BASIC_DA89          = $da89            ; scroll screen down?

; ==============================================================================
; ZEROPAGE
zp02                = $02
zp03                = $03
zp04                = $04
zp05                = $05
zpA7                = $A7
zpA8                = $A8
; ==============================================================================
code_start          = $3AB3
SCREEN             = $0C00            ; PLUS/4 default SCREEN
COLRAM              = $0800            ; PLUS/4 COLOR RAM
CHARSET            = $2000
screen_win_src      = $175C
screen_start_src    = $313C
BG_COLOR            = $ff15
COLOR_1             = $ff16 
COLOR_2             = $ff17
COLOR_3             = $ff18
BORDER_COLOR        = $ff19
KEYBOARD_LATCH     = $ff08
INTERRUPT           = $ff09
; ==============================================================================
                    !cpu 6502

                    *= CHARSET
                    !if EXTENDED {                    
                        !bin "code/includes/charset-new-charset.bin"
                    }else{
                        !bin "code/includes/charset.bin" 
                    }

                    *= screen_win_src
                    !bin "code/includes/screen_win.scr"

                    *= screen_start_src
                    !bin "code/includes/screen_start.scr"

                    !if KANNDOCHNICHWEG=1 {
                        *= $0f90
datenschrott01:         !source "code/includes/trash/datenschrott01.asm"
                    }
; ==============================================================================
                    *= $1000
m1000:
                    jsr PRINT           ; jsr $c56b ? wird gar nicht benutzt ?!
; ==============================================================================
m1003:
                    lda #$3f
                    sta zpA8
                    lda #$08
                    cpy #$00
                    beq ++              ; beq $1017
-                   clc
                    adc #$28
                    bcc +               ; bcc $1014
                    inc zpA8
+                   dey
                    bne -               ; bne $100d
++                  sta zpA7
                    jsr m3A9D           ; jsr $3a9d
                    ldy #$27
-                   lda (zpA7),y
                    sta SCREEN+$1B8,y ; sta $0db8,y
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
                    jsr m1003           ; jsr $1003
                    jsr BASIC_DA89      ; ?!? scroll screen down ?!?
                    jsr BASIC_DA89      ; ?!? scroll screen down ?!?
                    ldy #$01
                    jsr m1003           ; jsr $1003
                    ldx #$00
                    ldy #$00
                    beq m105F           ; beq $105f
m104C:              lda SCREEN+$1B9,x ; lda $0db9,x
                    clc
                    adc #$80
                    sta SCREEN+$1B9,x ; sta $0db9,x
                    lda SCREEN+$188,y ; lda $0d88,y
                    clc
                    adc #$80
                    sta SCREEN+$188,y ; sta $0d88,y
                    rts
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
                    lda SCREEN+$1B9,x ; lda $0db9,x
                    cmp #$bc
                    bne ++              ; bne $109c
                    cpy #$00
                    beq +               ; beq $1099
                    dey
+                   jmp m105F           ; jmp $105f
++                  sta SCREEN+$188,y ; sta $0d88,y
                    iny
                    cpy #$05
                    bne m105F           ; bne $105f
                    jmp m10B4           ; jmp $10b4
; ==============================================================================
m10A7:
                    ldy #$35
                    jsr wait
                    ldy zp02
                    ldx zp04
                    rts
; ==============================================================================
m10B1:
                    jmp m1155           ; jmp $1155
; ==============================================================================
m10B4:
                    ldx #$05
-                   lda SCREEN+$187,x ; lda $0d87,x
                    cmp m10CC-1,x       ; cmp $10cb,x
                    bne +               ; bne $10c4
                    dex
                    bne -               ; bne $10b6
                    jmp ++              ; jmp $10d1
+                   ldy #$05
                    jsr m1003           ; jsr $1003
                    jmp m3EF9           ; jmp $3ef9
m10CC:              !byte $30, $36, $31, $33, $38
++                  jsr m3A7D           ; jsr $3a7d
                    jsr m3A17           ; jsr $3a17
                    jsr m3B02           ; jsr $3b02
                    jmp m3B4C           ; jmp $3b4c
; ==============================================================================
item_pickup_message:              ; item pickup messages

                    !scr " There is a key in the bottle !         "
                    !scr "   There is a key in the coffin !       "
                    !scr " There is a breathing tube !            "
                    
; ==============================================================================
                    *= $1155
m1155:              cpy #$00
                    bne m11A2           ; bne $11a2
                    jsr m1000
                    ldx $3051
                    cpx #$01
                    bne $1165
                    lda #$28
                    cpx #$05
                    bne $116b
                    lda #$29
                    cpx #$0a
                    bne $1171
                    lda #$47
                    nop
                    nop
                    nop
                    jsr $174f
                    cpx #$0f
                    bne $1185
                    lda #$45
                    sta $0a6f
                    lda #$0f
                    sta $0e6f
                    sta $0e1f
                    lda #$48
                    sta $0a1f
                    lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
                    and #$80
                    bne $118d
                    jsr m3A7D           ; jsr $3a7d
                    jsr $3a2d
                    jmp m3B4C           ; jmp $3b4c
m11A2:              cpy #$02
                    bne $11ac
                    jsr m1000
                    jmp $118d
                    cpy #$04
                    bne $11bb
                    lda $3953
                    clc
                    adc #$40
                    sta $3fc6
                    bne $11a6
                    dey
                    dey
                    dey
                    dey
                    dey
                    lda #$10
                    sta zpA8
                    lda #$dd
                    jsr $1009
                    jmp $118d
; ==============================================================================
m11CC:
                    jsr m3A9D           ; jsr $3a9d
                    jmp PRINT           ; jmp $c56b
; ==============================================================================
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    nop
                    jsr $3846
                    jmp m3B4C           ; jmp $3b4c
                    ldx #$00
                    lda $033c,x
                    cmp #$1e
                    bcc $11ed
                    cmp #$df
                    bne $11f5
                    inx
                    cpx #$09
                    bne $11e2
                    jmp m3B4C           ; jmp $3b4c
                    ldy $3051
                    bne $120a
                    cmp #$a9
                    bne $11ed
                    lda #$df
                    cmp $36d7
                    bne $11f2
                    jsr $2fc0
                    bne $11da
                    cpy #$01
                    bne $124b
                    cmp #$e0
                    beq $1216
                    cmp #$e1
                    bne $122a
                    lda #$aa
                    sta $369a
                    jsr $3846
                    ldy #$f0
                    jsr wait
                    lda #$df
                    sta $369a
                    bne $11da
                    cmp #$27
                    bcs $1233
                    ldy #$00
                    jmp m1031           ; jmp $1031
                    cmp #$ad
                    bne $11ed
                    lda $3692
                    cmp #$6b
                    beq $1243
                    ldy #$0f
                    jmp $3eac
                    lda #$f9
                    sta $36a3
                    jmp $11da
                    cpy #$02
                    bne $12a5
                    cmp #$f5
                    bne $1267
                    lda $36a3
                    cmp #$f9
                    beq $125f
                    ldy #$10
                    jmp $3eac
                    lda #$df
                    sta $3901
                    jmp $11da
                    cmp #$a6
                    bne $1279
                    lda $369a
                    cmp #$df
                    bne $1264
                    lda #$df
                    sta $36c2
                    bne $1264
                    cmp #$b1
                    bne $1287
                    lda #$df
                    sta $36d7
                    sta $36e2
                    bne $1264
                    cmp #$b9
                    beq $128e
                    jmp $11ed
                    lda $3745
                    cmp #$df
                    beq $129a
                    ldy #$03
                    jmp $3eac
                    lda #$01
                    sta $12a4
                    ldy #$05
                    jmp m1031           ; jmp $1031
                    !byte $00
; ==============================================================================
                    cpy #$03
                    bne $12b5
                    cmp #$27
                    bcs $12b2
                    ldy #$04
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    jmp m3B4C           ; jmp $3b4c
; ==============================================================================
                    cpy #$04
                    bne $12db
                    cmp #$3b
                    beq $12c1
                    cmp #$42
                    bne $12c6
                    ldy #$0d
                    jmp $3eac
                    cmp #$f7
                    beq $12d1
                    cmp #$f8
                    beq $12d1
                    jmp $11ed
                    lda #$00
                    sta $394b
                    ldy #$06
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cpy #$05
                    bne $12f9
                    cmp #$27
                    bcs $12e8
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cmp #$fd
                    beq $12ef
                    jmp $11ed
                    lda #$00
                    jmp $2fdf
m12f4:              ldy #$07
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    cpy #$06
                    bne $1306
                    cmp #$f6
                    bne $12ec
                    ldy #$00
                    jmp $3eac
                    cpy #$07
                    bne $133e
                    cmp #$e3
                    bne $1312
                    ldy #$01
                    bne $1303
                    cmp #$5f
                    bne $12ec
                    lda #$bc
                    sta $36fe
                    lda #$5f
                    sta $36fc
                    jsr $3846
                    ldy #$ff
                    jsr wait
                    jsr wait
                    jsr wait
                    jsr wait
                    lda #$df
                    sta $36fe
                    lda #$00
                    sta $36fc
                    jmp $11da
                    cpy #$08
                    bne $1396
                    ldy #$00
                    sty zpA7
                    cmp #$4b
                    bne $135f
                    ldy $3994
                    bne $1366
                    jsr $3602
                    lda #$18
                    sta $35a6
                    lda #$0c
                    sta $35a4
                    jmp m3B4C           ; jmp $3b4c
                    cmp #$56
                    bne $1374
                    ldy $3994
                    bne $136f
                    jsr $3602
                    lda #$0c
                    bne $1354
                    ldy #$02
                    jmp $3eac
                    cmp #$c1
                    beq $137c
                    cmp #$c3
                    bne $1384
                    lda #$df
                    sta $3720
                    jmp $11da
                    cmp #$cb
                    bne $13b0
                    lda $3745
                    cmp #$df
                    bne $135c
                    lda #$df
                    sta $370e
                    bne $1381
                    cpy #$09
                    bne $13a3
                    cmp #$27
                    bcs $13b0
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
                    jmp $11ed
                    cmp #$cc
                    beq $13bb
                    cmp #$cf
                    bne $13b0
                    lda #$df
                    cmp $36fe
                    bne $13cd
                    cmp $3752
                    bne $13cd
                    sta $3736
                    jmp $11da
                    ldy #$06
                    jmp $3eac
                    cpy #$0b
                    bne $13e1
                    cmp #$d1
                    bne $13b0
                    lda #$df
                    sta $3745
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
                    bne $13b0
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
                    bne $13b0
                    lda $370e
                    cmp #$df
                    beq $141a
                    ldy #$07
                    jmp $3eac
                    lda #$e2
                    sta $375f
                    bne $13ca
                    cpy #$0e
                    bne $142e
                    cmp #$d7
                    bne $13b0
                    ldy #$08
                    jmp $3eac
                    cpy #$0f
                    bne $143e
                    cmp #$27
                    bcs $143b
                    ldy #$00
                    jmp m1031           ; jmp $1031
; ==============================================================================
                    jmp $13b0
; ==============================================================================
                    cpy #$10
                    bne $1464
                    cmp #$f4
                    bne $144b
                    ldy #$0a
                    jmp $3eac
                    cmp #$d9
                    beq $1453
                    cmp #$db
                    bne $1457
                    ldy #$09
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
                    jmp $11da
                    cmp #$81
                    bcs $147b
                    jmp $11da
                    jmp $1b8f
                    ldy $3051
                    cpy #$0e
                    bne $148a
                    ldy #$20
                    jmp wait
                    cpy #$0f
                    bne $14c8
                    lda #$00
                    sta zpA7
                    ldy #$0c
                    ldx #$06
                    jsr $3608
                    lda #$eb
                    sta zpA8
                    lda #$39
                    sta $0a
                    ldx $1495
                    lda #$01
                    bne $14b2
                    cpx #$06
                    bne $14ae
                    lda #$01
                    dex
                    jmp $14b9
                    cpx #$0b
                    bne $14b8
                    lda #$00
                    inx
                    stx $1495
                    sta $14a5
                    lda #$01
                    sta zpA7
                    ldy #$0c
                    jmp $3608
                    cpy #$11
                    bne $14d3
                    lda #$01
                    beq $14e4
                    jmp $15c1
                    lda #$0f
                    sta $3625
                    sta $3627
                    cpy #$0a
                    bne $1523
                    dec $2fbf
                    beq $14e5
                    rts
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
                    cpy #$09
                    bne $1522
                    nop
                    jmp $15ad
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
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc $15ac
                    inc zp03
                    inc zp05
                    rts
                    ldx #$01
                    cpx #$01
                    bne $15b7
                    dec $15ae
                    rts
                    inc $15ae
                    lda #$08
                    sta zp05
                    jmp $152b
                    lda #$00
                    cmp #$00
                    bne $15cb
                    inc $15c2
                    rts
                    dec $15c2
                    jmp $3620
                    lda $3736
                    cmp #$df
                    bne $15dd
                    lda #$59
                    sta $37b6
                    lda $3051
                    cmp #$11
                    bne $162a
                    lda $14cd
                    bne $15fc
                    lda $35a4
                    cmp #$06
                    bne $15fc
                    lda $35a6
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
                    jsr $3608
                    ldx $1603
                    cpx #$03
                    beq $1613
                    dex
                    stx $1603
                    lda #$78
                    sta zpA8
                    lda #$49
                    sta $0a
                    ldy #$06
                    lda #$01
                    sta zpA7
                    ldx $1603
                    jsr $3608
                    jmp $147e
                    ldx #$09
                    lda $033b,x
                    sta $034b,x
                    dex
                    bne $162f
                    lda #$02
                    sta zpA7
                    ldx $35a6
                    ldy $35a4
                    jsr $3608
                    ldx #$09
                    lda $033b,x
                    cmp #$d8
                    bne $1653
                    ldy #$05
                    jmp $3eac
                    ldy $3051
                    cpy #$11
                    bne $166a
                    cmp #$78
                    beq $1666
                    cmp #$7b
                    beq $1666
                    cmp #$7e
                    bne $166a
                    ldy #$0b
                    bne $1650
                    cmp #$9c
                    bcc $1676
                    cmp #$a5
                    bcs $1676
                    jmp $16a7
                    nop
                    cmp #$e4
                    bcc $168a
                    cmp #$eb
                    bcs $1682
                    ldy #$04
                    bne $1650
                    cmp #$f4
                    bcs $168a
                    ldy #$0e
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
                    jmp $11e0
                    ldy $3831
                    cpy #$df
                    beq $16b2
                    ldy #$0c
                    bne $1650
                    ldy #$00
                    sty $14cd
                    jmp $1675
                    lda #$a5
                    sta $36c2
                    lda #$a9
                    sta $3692
                    lda #$79
                    sta $3690
                    lda #$e0
                    sta $369a
                    lda #$ac
                    sta $36a3
                    lda #$b8
                    sta $36b3
                    lda #$b0
                    sta $36d7
                    lda #$b5
                    sta $36e2
                    lda #$5e
                    sta $36fe
                    lda #$c6
                    sta $370e
                    lda #$c0
                    sta $3720
                    lda #$cc
                    sta $3736
                    lda #$d0
                    sta $3745
                    lda #$d2
                    sta $3752
                    lda #$d6
                    sta $375f
                    lda #$00
                    sta $37b6
                    lda #$dd
                    sta $3831
                    lda #$01
                    sta $394b
                    lda #$01
                    sta $3994
                    lda #$f5
                    sta $3901
                    lda #$00
                    sta $12a4
                    lda #$01
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

                    !byte $02
                    !byte $07
                    !byte $04
                    asl $08
                    ora ($05,x)
                    !byte $03

                    cpx #$0c
                    bne $1755
                    lda #$49
                    cpx #$0d
                    bne $175b
                    lda #$45
                    rts
; ==============================================================================
                    *= $1B44
print_endscreen:
                    lda #>SCREEN       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #<SCREEN       ; lda #$00
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
                    lda $12a4
                    bne $1b97
                    jmp m3B4C           ; jmp $3b4c
                    jsr m3A9D           ; jsr $3a9d
                    jmp print_endscreen ; jmp $1b44
; ==============================================================================
m1B9D:

                    ; instructions screen
                    ; "Search the treasure..."

                    !scr "Search the treasure of Ghost Town and   "
                    !scr "open it ! Kill Belegro, the wizard, and "
                    !scr "dodge all other dangers. Don't forget to"
                    !scr "use all the items you'll find during    "
                    !scr "your yourney through 19 amazing hires-  "
                    !scr "graphics-rooms! Enjoy the quest and play"
                    !scr "it again and again and again ...      > "
                    
; ==============================================================================
m1CB5:

                    ; i think this part displays the introductin text

                    lda #>SCREEN       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #$a0
                    sta zp02
                    sta zp04
                    lda #$1b
                    sta zpA8
                    lda #$9d
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
                    sta KEYBOARD_LATCH
                    jsr PRINT           ; jsr $c56b
                    jsr m1CB5           ; jsr $1cb5
                    jsr $1ef9
                    lda #$ba
                    sta rsav7+1         ; sta $1ed9
                    rts
datenschrott04:
                    
                    !source "code/includes/datenschrott04.asm"
                   
; ==============================================================================
                    ; *= $1DD2
m1DD2:                                  ; Teil von music_play
rsav2:              ldy #$00
                    bne +               ; bne $1df3
                    lda #$40
                    sta rsav3+1         ; sta $1e39
                    jsr m1E38           ; jsr $1e38
rsav4:              ldx #$00
                    lda $1d14,x
                    inc $1ddf
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
                    bne $1e1d
                    lda #$40
                    sta $1e61
                    jsr m1E60           ; jsr $1e60
rsav6:              ldx #$00
                    lda $1d6e,x
                    tay
                    inx
                    cpx #$65
                    beq $1e27
                    stx $1e04
                    and #$1f
                    sta $1e61
                    tya
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    tay
                    dey
                    sty $1df8
                    jsr m1E38           ; jsr $1e38
                    jmp m1E60           ; jmp $1e60
                    lda #$00
                    sta rsav2+1         ; sta $1dd3
                    sta rsav4+1         ; sta $1ddf
                    sta rsav5+1         ; sta $1df8
                    sta rsav6+1         ; sta $1e04
                    jmp m1DD2           ; jmp $1dd2
                    ; *= $1E38
m1E38:
rsav3:              ldx #$04
                    cpx #$1c
                    bcc +               ; bcc $1e46
                    lda $ff11
                    and #$ef           ; clear bit 4
                    jmp writeFF11       ; jmp $1e5c

+                   lda $1e88,x        ; $1E88 ... : music data lo ?
                    sta $ff0e          ; Low byte of frequency for voice 1
                    lda $ff12
                    and #$fc
                    ora $1ea0,x        ; $1EA0 ... : music data hi ?
                    sta $ff12          ; High bits of frequency for voice 1
                    lda $ff11
                    ora #$10           ; set bit 4
writeFF11           sta $ff11          ; (de-)select voice 1
                    rts
                    ; *= $1E60
m1E60:
                    ldx #$0d
                    cpx #$1c
                    bcc $1e6e
                    lda $ff11
                    and #$df
                    jmp writeFF11       ; jmp $1e5c
                    lda $1e88,x
                    sta $ff0f
                    lda $ff10
                    and #$fc
                    ora $1ea0,x
                    sta $ff10
                    lda $ff11
                    ora #$20
                    sta $ff11
                    rts
datenschrott05:
                    !source "code/includes/datenschrott05.asm"
; ==============================================================================
music_play:
rsav0:              ldx #$09
                    dex
                    stx rsav0+1         ; stx $1ebd
                    beq +               ; beq $1ece
                    rts
                    ; *= $1EC5
rsav1:              ldy #$01
                    dey
                    sty rsav1+1         ; sty $1ec6
                    beq +               ; beq $1ece
                    rts
                    ; *= $1ECE
+                   ldy #$0b
                    sty rsav0+1         ; sty $1ebd
                    lda $ff11
                    ora #$37
rsav7:              and #$bf           ; $1ED8 $1ED9
                    sta $ff11          ; sth. with SOUND / MUSIC ?
                    jmp m1DD2           ; jmp $1dd2
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
                    sta rsav7+1         ; sta $1ed9
                    cli

                    jmp m3A9D           ; jmp $3a9d
; ==============================================================================
-                   lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
                    and #$80            ; checks for SHIFT key, why?
                    bne -               ; bne $1ef9
                    rts
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
m1F15:                                  ; call from init
                    lda rsav7+1         ; lda $1ed9
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
                    sta rsav7+1         ; sta $1ed9
                    jmp --              ; jmp $1f18
datenschrott06:
                    !source "code/includes/datenschrott06.asm"
eventuellcode06:
                    ora ($a9,x)
                    !byte $6b
                    sta $3692
                    lda #$3d
                    sta $3690
                    rts
                    lda $3051
                    cmp #$04
                    bne $2fca
                    lda #$03
                    ldy $394b
                    beq +
                    lda #$f6
+                   sta $0cf9
                    rts
                    ldy $3720
                    cpy #$df
                    bne +               ; bne $2fec
                    sta $3994
                    jmp m12f4           ; jmp $12f4
+                   jmp m3B4C           ; jmp $3b4c
                    jsr $39f4
                    jmp $15d1
; ==============================================================================
m2FF5:
                    jsr m3B02           ; jsr $3b02
                    lda #$00
                    sta zp02
                    rts
datenschrott07:
                    !source "code/includes/datenschrott07.asm"
; ==============================================================================
m3040:              nop
                    jsr m2FF5           ; jsr $2FF5
                    ldx #$08
                    stx zp05
                    ldx #$0c
                    stx zp03
                    ldx #$28
                    stx $0a
                    ldx #$01
                    beq $305e
                    clc
                    adc #$68
                    bcc $305b
                    inc $0a
                    dex
                    bne $3054
                    sta $09
                    ldy #$00
                    sty zpA8
                    sty zpA7
                    lda ($09),y
                    tax
                    lda $302f,x
                    sta $10
                    lda $301e,x
                    sta $11
                    ldx #$03
                    ldy #$00
                    lda zp02
                    sta zp04
                    lda $11
                    sta (zp02),y
                    lda $10
                    sta (zp04),y
                    jsr $30c8
                    cpy #$03
                    bne $3077
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    bcc $3097
                    inc zp03
                    inc zp05
                    dex
                    bne $3075
                    inc zpA8
                    inc zpA7
                    lda #$75
                    ldx zpA8
                    cpx #$0d
                    bcc $30b2
                    ldx zpA7
                    cpx #$66
                    bcs $30d2
                    lda #$00
                    sta zpA8
                    lda #$24
                    sta $30b9
                    lda zp02
                    sec
                    sbc #$75
                    sta zp02
                    bcs $30c2
                    dec zp03
                    dec zp05
                    ldy zpA7
                    jmp $3066
                    rts
                    lda $11
                    cmp #$df
                    beq $30d0
                    inc $11
                    iny
                    rts
; ==============================================================================
                    ; *= $30D2
print_X:
                    lda #>SCREEN       ; lda #$0c
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
print_title:
                    lda #>SCREEN       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #<SCREEN       ; lda #$00
                    sta zp02
                    sta zp04
                    lda #$31
                    sta zpA8
                    lda #$3c
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
                    *= $3525
m3525:
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #>SCREEN       ; lda #$0c
                    sta zp03
                    lda #$00
                    sta zp02
                    sta zp04
                    rts
; ==============================================================================
m3534:
                    jsr m3525           ; jsr $3525
                    cpy #$00
                    beq $3547
                    clc
                    adc #$28
                    bcc $3544
                    inc zp03
                    inc zp05
                    dey
                    bne $353b
                    clc
                    adc #$15
                    sta zp02
                    sta zp04
                    bcc $3554
                    inc zp03
                    inc zp05
                    ldx #$03
                    lda #$00
                    sta $09
                    ldy #$00
                    lda zpA7
                    bne $3566
                    lda #$df
                    sta (zp02),y
                    bne $3581
                    cmp #$01
                    bne $3574
                    lda zpA8
                    sta (zp02),y
                    lda $0a
                    sta (zp04),y
                    bne $3581
                    lda (zp02),y
                    stx $10
                    ldx $09
                    sta $033c,x
                    inc $09
                    ldx $10
                    inc zpA8
                    iny
                    cpy #$03
                    bne $355c
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc $3597
                    inc zp03
                    inc zp05
                    dex
                    bne $355a
                    rts
                    lda #$fd
                    sta KEYBOARD_LATCH
                    lda KEYBOARD_LATCH
                    ldy #$09
                    ldx #$15
                    lsr
                    bcs $35af
                    cpy #$00
                    beq $35af
                    dey
                    lsr
                    bcs $35b7
                    cpy #$15
                    bcs $35b7
                    iny
                    lsr
                    bcs $35bf
                    cpx #$00
                    beq $35bf
                    dex
                    lsr
                    bcs $35c7
                    cpx #$24
                    bcs $35c7
                    inx
                    sty $35e8
                    stx $35ed
                    stx $3549
                    lda #$02
                    sta zpA7
                    jsr m3534           ; jsr $3534
                    ldx #$09
                    lda $033b,x
                    cmp #$df
                    beq $35e4
                    cmp #$e2
                    bne $35f1
                    dex
                    bne $35d9
                    lda #$0a
                    sta $35a4
                    lda #$15
                    sta $35a6
                    lda #$ff
                    sta KEYBOARD_LATCH
                    lda #$01
                    sta zpA7
                    lda #$93
                    sta zpA8
                    lda #$3d
                    sta $0a
                    ldy $35a4
                    ldx $35a6
                    stx $3549
                    jmp m3534           ; jmp $3534
; ==============================================================================
                    sei
                    lda #$c0
                    cmp $ff1d           ; vertical line bits 0-7
                    bne $3611
                    lda #$00
                    sta zpA7
                    jmp $3a6d
                    bne $361a
                    rts
                    lda #$00
                    sta zpA7
                    ldx #$0f
                    ldy #$0f
                    jsr $3608
                    nop
                    ldx $3625
                    ldy $3627
                    cpx $35a6
                    bcs $3639
                    inx
                    inx
                    cpx $35a6
                    beq $363f
                    dex
                    cpy $35a4
                    bcs $3646
                    iny
                    iny
                    cpy $35a4
                    beq $364c
                    dey
                    stx $3669
                    stx $3549
                    sty $366e
                    lda #$02
                    sta zpA7
                    jsr m3534           ; jsr $3534
                    ldx #$09
                    lda $033b,x
                    cmp #$92
                    bcc $3672
                    dex
                    bne $365e
                    ldx #$10
                    stx $3625
                    ldy #$0e
                    sty $3627
                    lda #$9c
                    sta zpA8
                    lda #$3e
                    sta $0a
                    ldy $3627
                    ldx $3625
                    stx $3549
                    lda #$01
                    sta zpA7
                    jmp m3534           ; jmp $3534
datenschrott09:
                    !source "code/includes/datenschrott09.asm"
eventuellcode09:
                    lda zpA7
                    clc
                    adc #$01
                    sta zpA7
                    bcc $3845
                    inc zpA8
                    rts
                    lda #$36
                    sta zpA8
                    lda #$8a
                    sta zpA7
                    ldy #$00
                    lda (zpA7),y
                    cmp #$ff
                    beq $385c
                    jsr $383a
                    jmp $3850
                    jsr $383a
                    lda (zpA7),y
                    cmp #$ff
                    beq $38df
                    cmp $3051
                    bne $3856
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #>SCREEN       ; lda #$0c
                    sta zp03
                    lda #$00
                    sta zp02
                    sta zp04
                    jsr $383a
                    lda (zpA7),y
                    cmp #$fe
                    beq $388c
                    cmp #$f9
                    bne $3892
                    lda zp02
                    jsr $38d7
                    bcc $3890
                    inc zp03
                    inc zp05
                    lda (zpA7),y
                    cmp #$fb
                    bne $389f
                    jsr $383a
                    lda (zpA7),y
                    sta $09
                    bne $38bf
                    cmp #$f8
                    beq $38b7
                    cmp #$fc
                    bne $38ac
                    lda $0a
                    jmp $399f
                    cmp #$fa
                    bne $38bf
                    jsr $383a
                    lda (zpA7),y
                    sta $0a
                    lda $09
                    sta (zp04),y
                    lda $0a
                    sta (zp02),y
                    cmp #$fd
                    bne $38cc
                    jsr $383a
                    lda (zpA7),y
                    sta zp02
                    sta zp04
                    jsr $383a
                    lda (zpA7),y
                    cmp #$ff
                    bne $387d
                    beq $38df
                    clc
                    adc #$01
                    sta zp02
                    sta zp04
                    rts
                    lda $3051
                    cmp #$02
                    bne $3919
                    lda #$0d
                    sta zp02
                    sta zp04
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #>SCREEN       ; lda #$0c
                    sta zp03
                    ldx #$18
                    lda (zp02),y
                    cmp #$df
                    beq $3900
                    cmp #$f5
                    bne $3906
                    lda #$f5
                    sta (zp02),y
                    sta (zp04),y
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc $3915
                    inc zp03
                    inc zp05
                    dex
                    bne $38f6
                    rts
                    cmp #$07
                    bne $392f
                    ldx #$17
                    lda $0d68,x
                    cmp #$df
                    bne $392b
                    lda #$e3
                    sta $0d68,x
                    dex
                    bne $391f
                    rts
                    cmp #$06
                    bne $3942
                    lda #$f6
                    sta $0c9c
                    sta $0c9c
                    sta $0e7c
                    sta $0f6c
                    rts
                    cmp #$04
                    bne $398d
                    ldx #$f7
                    ldy #$f8
                    lda #$01
                    bne $3952
                    ldx #$3b
                    ldy #$42
                    lda #$01
                    cmp #$01
                    bne $395b
                    stx $0c7a
                    cmp #$02
                    bne $3962
                    stx $0d6a
                    cmp #$03
                    bne $3969
                    stx $0e5a
                    cmp #$04
                    bne $3970
                    stx $0f4a
                    cmp #$05
                    bne $3977
                    sty $0c9c
                    cmp #$06
                    bne $397e
                    sty $0d8c
                    cmp #$07
                    bne $3985
                    sty $0e7c
                    cmp #$08
                    bne $398c
                    sty $0f6c
                    rts
                    cmp #$05
                    bne $399d
                    lda #$fd
                    ldx #$01
                    bne $3999
                    lda #$7a
                    sta $0ed2
                    rts
datenschrott10:
                    !source "code/includes/datenschrott10.asm"
eventuellcode10:
                    jsr $360e
                    ldx #$09
                    lda $033b,x
                    cmp #$05
                    beq $3a08
                    cmp #$03
                    beq m3A17           ; beq $3a17
                    dex
                    bne $39f9
                    rts
                    ldx $3051
                    beq $3a07
                    dex
                    jmp $3a64
                    !byte $34
                    !byte $38 ;sec
                    !byte $32
                    !byte $38 ;sec
                    !byte $02
                    !byte $ff
m3A17:
                    ldx $3051
                    inx
                    stx $3051
                    ldy $3a4a,x
                    lda $39aa,y
                    sta $35a4
                    lda $39ab,y
                    sta $35a6
                    jsr m3040           ; jsr $3040
                    jmp $3846
; ==============================================================================
                    !byte $02
                    asl $0a
                    asl $1612
                    !byte $1a
                    asl $2622,x
                    rol
                    rol $3632
                    !byte $3a
                    rol $4642,x
                    lsr
                    lsr $5652
                    !byte $5a
                    lsr $0804,x
                    !byte $0c
                    bpl $3a64
                    clc
                    !byte $1c
                    jsr $2824
                    bit $3430
                    sec
                    !byte $3c
                    rti
                    !byte $44
                    pha
                    jmp $5450
                    cli
                    !byte $5c
                    rts
                    !byte $00
                    stx $3051
                    ldy $3a33,x
                    jmp $3a21
                    jsr $3602
                    jsr $359b
                    cli
                    rts
                    !byte $00
eventuellcode12:
; ==============================================================================
wait:               dex
                    bne wait
                    dey
                    bne wait
fake:               rts
; ==============================================================================
m3A7D:
                    lda $ff12           ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
                    and #$fb           ; clear bit 2
                    sta $ff12          ; => get data from RAM  
                    lda #$21
                    sta $ff13          ; bit 0 : Status of Clock   ( 1 )
                                        ; bit 1 : Single clock set  ( 0 )
                                        ; b.2-7 : character data base address
                                        ;         %00100$x ($2000)
                    lda $ff07
                    ora #$90           ; multicolor ON - reverse OFF
                    sta $ff07

                    ; set the main colors for the game

                    !if EXTENDED=1 {
                    lda #$6b            ; original: #$db  
                    sta COLOR_1           ; char color 1
                    lda #$19            ; original: #$29
                    sta COLOR_2           ; char color 2
                    }

                    !if EXTENDED=0 {
                    lda #$db            ; original: #$db  
                    sta COLOR_1           ; char color 1
                    lda #$29            ; original: #$29
                    sta COLOR_2           ; char color 2
                    }
                    
                    rts
; ==============================================================================
m3A9D:                                  ; set text screen
                    lda $ff12
                    ora #$04           ; set bit 2
                    sta $ff12          ; => get data from ROM
                    lda #$d5           ; ROM FONT
                    sta $ff13          ; set
                    lda $ff07
                    lda #$08           ; 40 columns and Multicolor OFF
                    sta $ff07
                    rts
; ==============================================================================
init:
                    jsr m1F15           ; jsr $1f15
                    lda #$01
                    sta BG_COLOR          ; background color
                    sta BORDER_COLOR          ; border color
                    jsr $16ba
                    ldy #$20
                    jsr wait

                    ; waiting for key press on title screen

                    lda #$7f           ; read row 7 of keyboard matrix (http://plus4world.powweb.com/plus4encyclopedia/500012)
-                   sta KEYBOARD_LATCH          ; Latch register for keyboard
                    lda KEYBOARD_LATCH
                    and #$10            ; $10 = space
                    bne -               ; bne $3ac8 / wait for keypress ?
                    
                    lda #$ff
                    jsr $1cff
                    lda #>SCREEN       ; lda #$0c
                    sta zp03
                    lda #$00
                    sta zp02
                    ldx #$04
                    ldy #$00
                    lda #$df
                    sta (zp02),y
                    iny
                    bne $3ae5
                    inc zp03
                    dex
                    bne $3ae5
                    jsr m3A7D           ; jsr $3a7d
                    lda #$00
                    sta BG_COLOR
                    
                    ; border color. default is a dark red
                    ; extended version is distinguished by dark grey
                    !if EXTENDED = 1{
                    lda #$01
                    }
                    !if EXTENDED = 0{
                    lda #$12
                    }
                    sta BORDER_COLOR
                    jsr m3B02           ; jsr $3b02
                    jmp $3b3a
; ==============================================================================
m3B02:
                    ; this seems to mainly draw the
                    ; horizontal and vertical blank lines
                    ; in the game

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
                    !if EXTENDED = 0{
                    lda #$12            ; draws blank column 40
                    }
                    !if EXTENDED = 1{
                    lda #$01            ; draws blank column 40   
                    }
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
-                   lda #$5d
                    sta $0fc0,x
                    !if EXTENDED = 0{
                    lda #$12            ; draws blank row 25
                    }
                    !if EXTENDED = 1{
                    lda #$01            ; draws blank row 25
                    }
                    sta $0bc0,x
                    inx
                    cpx #$28
                    bne -               ; bne $3b2a
                    rts
; ==============================================================================
                    lda #$06
                    sta $35a4
                    lda #$03
                    sta $35a6
                    lda #$00
                    sta $3051
                    jsr $3a2d
m3B4C:
                    jsr $2fef
                    ldy #$30
                    jsr wait
                    jsr $2fcb
                    jmp $162d
; ==============================================================================
datenschrott13:
death_messages:
                    ; death messages
                    ; like "You fell into a snake pit"
                    
                    ; scr conversion

                    !scr "You fell into a          snake pit !    "
                    !scr "          You'd better watched out for t"
                    !scr "he sacred column!   You drowned in the d"
                    !scr "eep river !                   You drank "
                    !scr "from the       poisened bottle ........ "
                    !scr "Boris, the spider, got   you and killed "
                    !scr "you !     Didn't you see the       laser"
                    !scr " beam ?!?           240 Volts ! You got "
                    !scr "an electrical shock !         You steppe"
                    !scr "d on a nail !                           "
                    !scr "A foot trap stopped you !               "
                    !scr "          This room is doomed      by th"
                    !scr "e wizard Manilo !   You were locked in a"
                    !scr "nd starved !                  You were h"
                    !scr "it by a big    rock and died !          "
                    !scr "Belegro killed           you !          "
                    !scr "          You found a thirsty      zombi"
                    !scr "e .......           The monster grapped "
                    !scr "      you. You are dead !     You were w"
                    !scr "ounded by      the bush !               "
                    !scr "You are trapped in       wire-nettings !"
                    !scr "          "
                    
; ==============================================================================
tmp
                    lda #$3b
                    sta $a8
                    lda #$5a
                    sta $a7
                    cpy #$00
                    beq ++           ; beq $3ec4
-                   clc
                    adc #$32
                    sta $a7
                    bcc +            ; bcc $3ec1
                    inc $a8
+                   dey
                    bne -           ; bne $3eb8
++                  lda #$0c
                    sta $03
                    sty $02
                    ldx #$04
                    lda #$20
-                   sta ($02),y
                    iny
                    bne -               ; bne $3ece
                    inc $03
                    dex
                    bne -               ; bne $3ece
                    jsr m3A9D
                    lda ($a7),y
                    sta $0dc0,x
                    lda #$00
                    sta $09c0,x
                    inx
                    iny
                    cpx #$19
                    bne +               ; bne $3eed
                    ldx #$50
+                   cpy #$32
                    bne $3edb
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

                    !scr " A part of the code number is :         "
                    !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
                    !scr " You need: bulb, bulb holder, socket !  "
                    !scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
                    !scr " *****   A helping letter :   C   ***** "
                    !scr " Sorry, bad code number! Better luck next time! "

; ==============================================================================

; jsr $c56b        Aufruf print Routine ?!?
;                   im PLUS/4 ROM:
;
; .C:c56b  A9 93       LDA #$93
; .C:c56d  4C D2 FF    JMP $FFD2        ; Output (print usually)($EC4B)
;
; .C:ffd2  6C 24 03    JMP ($0324)      ; Vector bei $0324 steht auf $EC4B
;
