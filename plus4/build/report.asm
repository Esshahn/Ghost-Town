
; ******** Source: main.asm
     1                          ; ==============================================================================
     2                          ;
     3                          ;  ▄████  ██░ ██  ▒█████    ██████ ▄▄▄█████▓   ▄▄▄█████▓ ▒█████   █     █░███▄    █
     4                          ; ██▒ ▀█▒▓██░ ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒   ▓  ██▒ ▓▒▒██▒  ██▒▓█░ █ ░█░██ ▀█   █
     5                          ;▒██░▄▄▄░▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░   ▒ ▓██░ ▒░▒██░  ██▒▒█░ █ ░█▓██  ▀█ ██▒
     6                          ;░▓█  ██▓░▓█ ░██ ▒██   ██░  ▒   ██▒░ ▓██▓ ░    ░ ▓██▓ ░ ▒██   ██░░█░ █ ░█▓██▒  ▐▌██▒
     7                          ;░▒▓███▀▒░▓█▒░██▓░ ████▓▒░▒██████▒▒  ▒██▒ ░      ▒██▒ ░ ░ ████▓▒░░░██▒██▓▒██░   ▓██░
     8                          ; ░▒   ▒  ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░        ▒ ░░   ░ ▒░▒░▒░ ░ ▓░▒ ▒ ░ ▒░   ▒ ▒
     9                          ;  ░   ░  ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░           ░      ░ ▒ ▒░   ▒ ░ ░ ░ ░░   ░ ▒░
    10                          ;░ ░   ░  ░  ░░ ░░ ░ ░ ▒  ░  ░  ░    ░           ░      ░ ░ ░ ▒    ░   ░    ░   ░ ░
    11                          ;      ░  ░  ░  ░    ░ ░        ░                           ░ ░      ░            ░
    12                          ;
    13                          ;
    14                          ; Ghost Town, Commodore 16 Version
    15                          ; Disassembled by awsm & spider j of Mayday in 2019
    16                          ;
    17                          ; ==============================================================================
    18                          
    19                          ; ==============================================================================
    20                          ; language
    21                          ; ENGLISH and GERMAN are available
    22                          ; OPTIONS: EN / DE
    23                          ; ==============================================================================
    24                          
    25                          EN = 0
    26                          DE = 1
    27                          
    28                          LANGUAGE = DE
    29                          
    30                          ; ==============================================================================
    31                          ; thse settings change the appearance of the game
    32                          ; EXTENDED = 0 -> original version
    33                          ; EXTENDED = 1 -> altered version
    34                          ; ==============================================================================
    35                          
    36                          EXTENDED            = 0       ; 0 = original version, 1 = tweaks and cosmetics
    37                          
    38                          !if EXTENDED = 0{
    39                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $12 ; red
    40                              MULTICOLOR_1        = $db
    41                              MULTICOLOR_2        = $29
    42                              BORDER_COLOR_VALUE  = $12
    43                              TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    44                              TITLE_KEY           = $01
    45                          
    46                          }
    47                          
    48                          !if EXTENDED = 1{
    49                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $01 ; grey
    50                              MULTICOLOR_1        = $6b
    51                              MULTICOLOR_2        = $19
    52                              BORDER_COLOR_VALUE  = $01
    53                              TITLE_KEY_MATRIX    = $7f           ; Extended version key to press on title screen: space
    54                              TITLE_KEY           = $10
    55                          }
    56                          
    57                          
    58                          ; ==============================================================================
    59                          ; cheats
    60                          ;
    61                          ;
    62                          ; ==============================================================================
    63                          
    64                          START_ROOM          = 16             ; default 0 ; address $3b45
    65                          PLAYER_START_POS_X  = 3             ; default 3
    66                          PLAYER_START_POS_Y  = 6             ; default 6
    67                          SILENT_MODE         = 0
    68                          
    69                          ; ==============================================================================
    70                          ; KERNAL / BASIC ROM CALLS
    71                          
    72                          PRINT_KERNAL        = $c56b
    73                          BASIC_DA89          = $da89            ; scroll screen down?
    74                          
    75                          ; ==============================================================================
    76                          ; ZEROPAGE
    77                          
    78                          zp02                = $02
    79                          zp03                = $03
    80                          zp04                = $04
    81                          zp05                = $05
    82                          zp08                = $08
    83                          zp09                = $09
    84                          zp0A                = $0A
    85                          zp10                = $10
    86                          zp11                = $11
    87                          zpA7                = $A7
    88                          zpA8                = $A8
    89                          zpA9                = $A9
    90                          
    91                          ; ==============================================================================
    92                          
    93                          TAPE_BUFFER         = $0333
    94                          code_start          = $3AB3
    95                          SCREENRAM           = $0C00            ; PLUS/4 default SCREEN
    96                          COLRAM              = $0800            ; PLUS/4 COLOR RAM
    97                          CHARSET             = $2000
    98                          screen_start_src    = $313C
    99                          
   100                          
   101                          KEYBOARD_LATCH      = $FF08
   102                          INTERRUPT           = $FF09
   103                          VOICE1_FREQ_LOW     = $FF0E         ; Low byte of frequency for voice 1
   104                          VOICE2_FREQ_LOW     = $FF0F
   105                          VOICE2              = $FF10
   106                          VOLUME_AND_VOICE_SELECT = $FF11
   107                          VOICE1              = $FF12 ; Bit 0-1 : Voice #1 frequency, bits 8 & 9;  Bit 2    : TED data fetch ROM/RAM select; Bits 0-5 : Bit map base address
   108                          CHAR_BASE_ADDRESS   = $FF13
   109                          BG_COLOR            = $FF15
   110                          COLOR_1             = $FF16
   111                          COLOR_2             = $FF17
   112                          COLOR_3             = $FF18
   113                          BORDER_COLOR        = $FF19
   114                          
   115                          ; ==============================================================================
   116                          
   117                          
   118                                              !cpu 6502
   119                          
   120                                              *= CHARSET
   121                                              !if EXTENDED {
   122                                                  !bin "includes/charset-new-charset.bin"
   123                                              }else{
   124  2000 000000020a292727...                        !bin "includes/charset.bin"
   125                                              }
   126                          
   127                          
   128                                              *= screen_start_src
   129                                              !if EXTENDED {
   130                                                  !bin "includes/screen-start-extended.scr"
   131                                              }else{
   132  313c 20202020202020a0...                        !bin "includes/screen-start.scr"
   133                                              }
   134                          
   135                          
   136                          
   137                                              ;  1111111        000000000          000000000          000000000
   138                                              ; 1::::::1      00:::::::::00      00:::::::::00      00:::::::::00
   139                                              ;1:::::::1    00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
   140                                              ;111:::::1   0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
   141                                              ;   1::::1   0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
   142                                              ;   1::::1   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
   143                                              ;   1::::1   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
   144                                              ;   1::::l   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
   145                                              ;   1::::l   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
   146                                              ;   1::::l   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
   147                                              ;   1::::l   0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
   148                                              ;   1::::l   0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
   149                                              ;111::::::1110:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
   150                                              ;1::::::::::1 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
   151                                              ;1::::::::::1   00:::::::::00      00:::::::::00      00:::::::::00
   152                                              ;111111111111     000000000          000000000          000000000
   153                          
   154                          
   155                          
   156                          
   157                          
   158                                              *= $1000
   159                          m1000:
   160  1000 206bc5                                 jsr PRINT_KERNAL           ; jsr $c56b ? wird gar nicht benutzt ?!
   161                          
   162                          ; ==============================================================================
   163                          ;
   164                          ; display the hint messages
   165                          ; ==============================================================================
   166                          
   167                          display_hint_message:
   168                          
   169  1003 a93f                                   lda #>hint_messages
   170  1005 85a8                                   sta zpA8
   171  1007 a908                                   lda #<hint_messages
   172  1009 c000               m1009:              cpy #$00
   173  100b f00a                                   beq ++              ; beq $1017
   174  100d 18                 -                   clc
   175  100e 6928                                   adc #$28
   176  1010 9002                                   bcc +               ; bcc $1014
   177  1012 e6a8                                   inc zpA8
   178  1014 88                 +                   dey
   179  1015 d0f6                                   bne -               ; bne $100d
   180  1017 85a7               ++                  sta zpA7
   181  1019 209d3a                                 jsr set_charset_and_screen_for_title           ; jsr $3a9d
   182  101c a027                                   ldy #$27
   183  101e b1a7               -                   lda (zpA7),y
   184  1020 99b80d                                 sta SCREENRAM+$1B8,y ; sta $0db8,y
   185  1023 a907                                   lda #$07
   186  1025 99b809                                 sta COLRAM+$1B8,y  ; sta $09b8,y
   187  1028 88                                     dey
   188  1029 d0f3                                   bne -               ; bne $101e
   189  102b 60                                     rts
   190  102c 00                                     !byte $00
   191                          ; ==============================================================================
   192  102d 8d19ff                                 sta BORDER_COLOR          ; ?!? womöglich unbenutzt ?!?
   193  1030 60                                     rts
   194                          ; ==============================================================================
   195                          ; TODO: understand this one, it gets called a lot
   196                          
   197                          m1031:
   198  1031 20c911                                 jsr m11CC           ; jsr $11cc
   199  1034 c003                                   cpy #$03
   200  1036 f003                                   beq +                           ;bne m10B1           ; bne $10b1
   201  1038 4c5511                                 jmp display_hint           ; jmp $1155
   202  103b 200310             +                   jsr display_hint_message           ; jsr $1003
   203  103e 2089da                                 jsr BASIC_DA89      ; ?!? scroll screen down ?!?
   204  1041 2089da                                 jsr BASIC_DA89      ; ?!? scroll screen down ?!?
   205  1044 a001                                   ldy #$01
   206  1046 200310                                 jsr display_hint_message           ; jsr $1003
   207  1049 a200                                   ldx #$00
   208  104b a000                                   ldy #$00
   209  104d f013                                   beq room_16_enter_code           ; beq $105f
   210  104f bdb90d             m104C:              lda SCREENRAM+$1B9,x ; lda $0db9,x
   211  1052 18                                     clc
   212  1053 6980                                   adc #$80
   213  1055 9db90d                                 sta SCREENRAM+$1B9,x ; sta $0db9,x
   214  1058 b9880d                                 lda SCREENRAM+$188,y ; lda $0d88,y
   215  105b 18                                     clc
   216  105c 6980                                   adc #$80
   217  105e 99880d                                 sta SCREENRAM+$188,y ; sta $0d88,y
   218  1061 60                                     rts
   219                          
   220                          ; ==============================================================================
   221                          ;
   222                          ;
   223                          ; ==============================================================================
   224                          
   225                          room_16_enter_code:              
   226  1062 204f10                                 jsr m104C           ; jsr $104c
   227  1065 8402                                   sty zp02
   228  1067 8604                                   stx zp04
   229  1069 20aa10                                 jsr m10A7           ; jsr $10a7 / wait
   230  106c 204f10                                 jsr m104C           ; jsr $104c / some screen stuff
   231  106f 20aa10                                 jsr m10A7           ; jsr $10a7 / wait
   232  1072 a9fd                                   lda #$fd           ; KEYBOARD stuff
   233  1074 8d08ff                                 sta KEYBOARD_LATCH          ; .
   234  1077 ad08ff                                 lda KEYBOARD_LATCH          ; .
   235  107a 4a                                     lsr                 ; .
   236  107b 4a                                     lsr
   237  107c 4a                                     lsr
   238  107d b005                                   bcs +               ; bcs $1081
   239  107f e000                                   cpx #$00
   240  1081 f001                                   beq +               ; beq $1081
   241  1083 ca                                     dex
   242  1084 4a                 +                   lsr
   243  1085 b005                                   bcs +               ; bcs $1089
   244  1087 e025                                   cpx #$25
   245  1089 f001                                   beq +               ; beq $1089
   246  108b e8                                     inx
   247  108c 2908               +                   and #$08
   248  108e d0d2                                   bne room_16_enter_code           ; bne $105f
   249  1090 bdb90d                                 lda SCREENRAM+$1B9,x ; lda $0db9,x
   250  1093 c9bc                                   cmp #$bc
   251  1095 d008                                   bne ++              ; bne $109c
   252  1097 c000                                   cpy #$00
   253  1099 f001                                   beq +               ; beq $1099
   254  109b 88                                     dey
   255  109c 4c6210             +                   jmp room_16_enter_code           ; jmp $105f
   256  109f 99880d             ++                  sta SCREENRAM+$188,y ; sta $0d88,y
   257  10a2 c8                                     iny
   258  10a3 c005                                   cpy #$05
   259  10a5 d0bb                                   bne room_16_enter_code           ; bne $105f
   260  10a7 4cb410                                 jmp m10B4           ; jmp $10b4
   261                          
   262                          ; ==============================================================================
   263                          ;
   264                          ;
   265                          ; ==============================================================================
   266                          
   267                          m10A7:
   268  10aa a035                                   ldy #$35
   269  10ac 20763a                                 jsr wait
   270  10af a402                                   ldy zp02
   271  10b1 a604                                   ldx zp04
   272  10b3 60                                     rts
   273                          
   274                          
   275                          
   276                          ; ==============================================================================
   277                          ;
   278                          ;
   279                          ; ==============================================================================
   280                          
   281                          m10B4:
   282  10b4 a205                                   ldx #$05
   283  10b6 bd870d             -                   lda SCREENRAM+$187,x ; lda $0d87,x
   284  10b9 ddcb10                                 cmp m10CC-1,x       ; cmp $10cb,x
   285  10bc d006                                   bne +               ; bne $10c4
   286  10be ca                                     dex
   287  10bf d0f5                                   bne -               ; bne $10b6
   288  10c1 4cd110                                 jmp ++              ; jmp $10d1
   289  10c4 a005               +                   ldy #$05
   290  10c6 200310                                 jsr display_hint_message           ; jsr $1003
   291  10c9 4cf93e                                 jmp m3EF9           ; jmp $3ef9
   292  10cc 3036313338         m10CC:              !byte $30, $36, $31, $33, $38
   293  10d1 207d3a             ++                  jsr set_game_basics           ; jsr $3a7d
   294  10d4 20173a                                 jsr m3A17           ; jsr $3a17
   295  10d7 20023b                                 jsr draw_border           ; jsr $3b02
   296  10da 4c4c3b                                 jmp m3B4C           ; jmp $3b4c
   297                          
   298                          ; ==============================================================================
   299                          ;
   300                          ;
   301                          ; ==============================================================================
   302                          
   303                          item_pickup_message:              ; item pickup messages
   304                          
   305                          !if LANGUAGE = EN{
   306                          !scr " There is a key in the bottle !         "
   307                          !scr "   There is a key in the coffin !       "
   308                          !scr " There is a breathing tube !            "
   309                          }
   310                          
   311                          !if LANGUAGE = DE{
   312  10dd 20490e2004051220...!scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
   313  1105 20202020490e2004...!scr "    In dem Sarg lag ein Schluessel !    "
   314  112d 20550e1405122004...!scr " Unter dem Stein lag ein Taucheranzug ! "
   315                          }
   316                          
   317                          
   318                          ; ==============================================================================
   319                          ;
   320                          ; hint system (question marks)
   321                          ; ==============================================================================
   322                          
   323                          
   324                          display_hint:
   325  1155 c000                                   cpy #$00
   326  1157 d046                                   bne m11A2           ; bne $11a2
   327  1159 200010                                 jsr m1000
   328  115c ae4c30                                 ldx current_room + 1
   329  115f e001                                   cpx #$01
   330  1161 d002                                   bne +               ; bne $1165
   331  1163 a928                                   lda #$28
   332  1165 e005               +                   cpx #$05
   333  1167 d002                                   bne +               ; bne $116b
   334  1169 a929                                   lda #$29
   335  116b e00a               +                   cpx #$0a
   336  116d d002                                   bne +               ; bne $1171
   337  116f a947                                   lda #$47
   338  1171 204d17             +                   jsr m174F           ; jsr $174f
   339  1174 e00f                                   cpx #$0f
   340  1176 d00a                                   bne +               ; bne $1185
   341  1178 a945                                   lda #$45
   342  117a 8d6f0a                                 sta COLRAM + $26f       ; sta $0a6f
   343  117d a90f                                   lda #$0f
   344  117f 8d6f0e                                 sta SCREENRAM + $26f       ; sta $0e6f
   345  1182 8d1f0e             +                   sta SCREENRAM + $21f       ; sta $0e1f
   346  1185 a948                                   lda #$48
   347  1187 8d1f0a                                 sta COLRAM + $21f       ; sta $0a1f
   348  118a a9fd               -                   lda #$fd
   349  118c 8d08ff                                 sta KEYBOARD_LATCH
   350  118f ad08ff                                 lda KEYBOARD_LATCH
   351  1192 2980                                   and #$80
   352  1194 d0f4                                   bne -               ; bne $118d
   353  1196 207d3a                                 jsr set_game_basics           ; jsr $3a7d
   354  1199 202d3a                                 jsr m3A2D           ; jsr $3a2d
   355  119c 4c4c3b                                 jmp m3B4C           ; jmp $3b4c
   356  119f c002               m11A2:              cpy #$02
   357  11a1 d006                                   bne +               ; bne $11ac
   358  11a3 200010             m11A6:              jsr m1000
   359  11a6 4c8a11                                 jmp -               ; jmp $118d
   360  11a9 c004               +                   cpy #$04
   361  11ab d00b                                   bne +               ; bne $11bb
   362  11ad ad5339                                 lda m3952 + 1       ; lda $3953
   363  11b0 18                                     clc
   364  11b1 6940                                   adc #$40            ; this is the helping letter
   365  11b3 8dc63f                                 sta helping_letter          ; sta $3fc6
   366  11b6 d0eb                                   bne m11A6               ; bne $11a6
   367  11b8 88                 +                   dey
   368  11b9 88                                     dey
   369  11ba 88                                     dey
   370  11bb 88                                     dey
   371  11bc 88                                     dey
   372  11bd a910                                   lda #$10
   373  11bf 85a8                                   sta zpA8
   374  11c1 a9dd                                   lda #$dd
   375  11c3 200910                                 jsr m1009
   376  11c6 4c8a11                                 jmp -
   377                          ; ==============================================================================
   378                          m11CC:
   379  11c9 209d3a                                 jsr set_charset_and_screen_for_title           ; jsr $3a9d
   380  11cc 4c6bc5                                 jmp PRINT_KERNAL           ; jmp $c56b
   381                          ; ==============================================================================
   382                          
   383                          check_death:
   384  11cf 204638                                 jsr m3846
   385  11d2 4c4c3b                                 jmp m3B4C           ; jmp $3b4c
   386                          
   387                          ; ==============================================================================
   388                          
   389  11d5 a200               m11E0:              ldx #$00
   390  11d7 bd3c03             -                   lda TAPE_BUFFER + $9,x              ;  lda $033c,x
   391  11da c91e                                   cmp #$1e            ; question mark
   392  11dc 9004                                   bcc m11ED           ; bcc $11ed
   393  11de c9df                                   cmp #$df
   394  11e0 d008                                   bne room_00              ; bne $11f5
   395  11e2 e8                 m11ED:              inx
   396  11e3 e009                                   cpx #$09
   397  11e5 d0f0                                   bne -               ; bne $11e2
   398  11e7 4c4c3b             -                   jmp m3B4C           ; jmp $3b4c
   399                          
   400                          ; ==============================================================================
   401                          
   402                          room_00:
   403  11ea ac4c30                                 ldy current_room + 1
   404  11ed d010                                   bne room_01               ; bne $120a
   405  11ef c9a9                                   cmp #$a9            ; egg plant gloves ;)
   406  11f1 d0ef                                   bne m11ED
   407  11f3 a9df                                   lda #$df
   408  11f5 cdd736                                 cmp items + $4d                        ; cmp $36d7
   409  11f8 d0ed               m1203:              bne -               ; bne $11f2
   410  11fa 20c02f                                 jsr m2FC0
   411  11fd d0d0                                   bne check_death     ; bne $11da
   412                          
   413                          
   414                          room_01:
   415  11ff c001                                   cpy #$01
   416  1201 d03d                                   bne room_02           ; bne $124b
   417  1203 c9e0                                   cmp #$e0            ; empty character in charset
   418  1205 f004                                   beq +               ; beq $1216
   419  1207 c9e1                                   cmp #$e1
   420  1209 d014                                   bne ++              ; bne $122a
   421  120b a9aa               +                   lda #$aa
   422  120d 8d9a36                                 sta items + $10                        ; sta $369a
   423  1210 204638                                 jsr m3846
   424  1213 a0f0                                   ldy #$f0
   425  1215 20763a                                 jsr wait
   426  1218 a9df                                   lda #$df
   427  121a 8d9a36                                 sta items + $10                        ; sta $369a
   428  121d d0b0                                   bne check_death     ; bne $11da
   429  121f c927               ++                  cmp #$27            ; part of a bush
   430  1221 b005                                   bcs check_death_bush
   431  1223 a000                                   ldy #$00
   432  1225 4c3110                                 jmp m1031           ; jmp $1031
   433                          
   434                          ; ==============================================================================
   435                          check_death_bush:                 ; $1233
   436  1228 c9ad                                   cmp #$ad                ; wirecutters
   437  122a d0b6                                   bne m11ED
   438  122c ad9236                                 lda items + $8           ; inventory place for the gloves! 6b = gloves
   439  122f c96b                                   cmp #$6b
   440  1231 f005                                   beq +                   ; beq $1243
   441  1233 a00f                                   ldy #$0f
   442  1235 4cac3e                                 jmp death         ; 0f You were wounded by the bush!
   443                          
   444                          ; ==============================================================================
   445                          ;$1243
   446  1238 a9f9               +                   lda #$f9                ; wirecutter picked up
   447  123a 8da336                                 sta items + $19
   448  123d 4ccf11                                 jmp check_death
   449                          
   450                          ; ==============================================================================
   451                          
   452                          room_02:
   453  1240 c002                                   cpy #$02
   454  1242 d056                                   bne room_03           ; bne $12a5
   455  1244 c9f5                                   cmp #$f5        ; f5 = fence character
   456  1246 d014                                   bne +           ;bne $1267
   457  1248 ada336                                 lda items + $19      ; fence was hit, so check if wirecuter was picked up
   458  124b c9f9                                   cmp #$f9        ; f9 = wirecutters were picked up
   459  124d f005                                   beq m125F           ;beq $125f
   460  124f a010                                   ldy #$10
   461  1251 4cac3e                                 jmp death     ; 10 You are trapped in wire-nettings!
   462                          
   463                          ; ==============================================================================
   464                          m125F:
   465  1254 a9df                                   lda #$df
   466  1256 8d0139                                 sta m3900 + 1                           ; sta $3901
   467  1259 4ccf11             m1264:              jmp check_death
   468                          
   469                          ; ==============================================================================
   470                          ;$1267
   471                          m1267:
   472  125c c9a6               +                   cmp #$a6            ; lock
   473  125e d00e                                   bne +                                   ; bne $1279
   474  1260 ad9a36                                 lda items + $10                        ; lda $369a
   475  1263 c9df                                   cmp #$df
   476  1265 d0f2                                   bne m1264                               ; bne $1264
   477  1267 a9df                                   lda #$df
   478  1269 8dc236                                 sta items + $38                        ; sta $36c2
   479  126c d0eb                                   bne m1264                               ; bne $1264
   480  126e c9b1               +                   cmp #$b1            ; ladder
   481  1270 d00a                                   bne +                                   ; bne $1287
   482  1272 a9df                                   lda #$df
   483  1274 8dd736                                 sta items + $4d                        ; sta $36d7
   484  1277 8de236                                 sta items + $58                        ; sta $36e2
   485  127a d0dd                                   bne m1264                               ; bne $1264
   486  127c c9b9               +                   cmp #$b9            ; bottle
   487  127e f003                                   beq +                                   ; beq $128e
   488  1280 4ce211                                 jmp m11ED
   489  1283 ad4537             +                   lda items + $bb
   490  1286 c9df                                   cmp #$df            ; df = empty spot where the hammer was. = hammer taken
   491  1288 f005                                   beq take_key_out_of_bottle                                   ; beq $129a
   492  128a a003                                   ldy #$03
   493  128c 4cac3e                                 jmp death        ; 03 You drank from the poisend bottle
   494                          
   495                          
   496                          ; ==============================================================================
   497                          ; take the key out of the bottle
   498                          take_key_out_of_bottle:
   499  128f a901                                   lda #$01
   500  1291 8d9912                                 sta key_in_bottle_storage                                   ; sta $12a4
   501  1294 a005                                   ldy #$05
   502  1296 4c3110                                 jmp m1031           ; jmp $1031
   503                          
   504                          ; ==============================================================================
   505                          ; this is 1 if the key from the bottle was taken and 0 if not
   506                          
   507  1299 00                 key_in_bottle_storage:              !byte $00
   508                          
   509                          ; ==============================================================================
   510                          
   511                          room_03:            
   512  129a c003                                   cpy #$03            ; room 03
   513  129c d00c                                   bne room_04                                   
   514  129e c927                                   cmp #$27            
   515  12a0 9003                                   bcc +                                                  
   516  12a2 4c4c3b                                 jmp m3B4C
   517  12a5 a004               +                   ldy #$04
   518  12a7 4c3110                                 jmp m1031           
   519                          
   520                          ; ==============================================================================
   521                          
   522                          room_04:
   523  12aa c004                                   cpy #$04            ; room 04
   524  12ac d022                                   bne room_05                               ; bne $12db
   525  12ae c93b                                   cmp #$3b            ; part of a coffin
   526  12b0 f004                                   beq +                                   ; beq $12c1
   527  12b2 c942                                   cmp #$42
   528  12b4 d005                                   bne m12C6                               ; bne $12c6
   529  12b6 a00d               +                   ldy #$0d
   530  12b8 4cac3e                                 jmp death    ; 0d You found a thirsty zombie....
   531                          
   532                          ; ==============================================================================
   533                          
   534                          m12C6:
   535  12bb c9f7                                   cmp #$f7
   536  12bd f007                                   beq +                                       ; beq $12d1
   537  12bf c9f8                                   cmp #$f8
   538  12c1 f003                                   beq +                                       ; beq $12d1
   539  12c3 4ce211                                 jmp m11ED
   540  12c6 a900               +                   lda #$00
   541  12c8 8d4b39                                 sta m394A + 1                               ; sta $394b
   542  12cb a006                                   ldy #$06
   543  12cd 4c3110                                 jmp m1031           ; jmp $1031
   544                          ; ==============================================================================
   545                          
   546                          room_05:
   547  12d0 c005                                   cpy #$05
   548  12d2 d01a                                   bne room_06                                   ; bne $12f9
   549  12d4 c927                                   cmp #$27            ; part of a bush
   550  12d6 b005                                   bcs m12E8                                   ; bcs $12e8
   551  12d8 a000                                   ldy #$00
   552  12da 4c3110                                 jmp m1031           ; jmp $1031
   553                          
   554                          ; ==============================================================================
   555                          
   556                          m12E8:
   557  12dd c9fd                                   cmp #$fd
   558  12df f003                                   beq +                                   ; beq $12ef
   559  12e1 4ce211             m12EC:              jmp m11ED
   560  12e4 a900               +                   lda #$00
   561  12e6 4cdf2f                                 jmp m2FDF
   562                          
   563                          ; ==============================================================================
   564                          
   565  12e9 a007               m12F4:              ldy #$07
   566  12eb 4c3110                                 jmp m1031           ; jmp $1031
   567                          ; ==============================================================================
   568                          
   569                          room_06:
   570  12ee c006                                   cpy #$06
   571  12f0 d009                                   bne room_07                       ; bne $1306
   572  12f2 c9f6                                   cmp #$f6            ; is it a trapped door?
   573  12f4 d0eb                                   bne m12EC                               ; bne $12ec
   574  12f6 a000                                   ldy #$00
   575  12f8 4cac3e             m1303:              jmp death    ; 00 You fell into a snake pit
   576                          
   577                          ; ==============================================================================
   578                          
   579                          room_07:
   580  12fb c007                                   cpy #$07
   581  12fd d034                                   bne room_08                               ; bne $133e
   582  12ff c9e3                                   cmp #$e3            ; $e3 is the char for the invisible, I mean SACRED, column
   583  1301 d004                                   bne +                                   ; bne $1312
   584  1303 a001                                   ldy #$01            ; 01 You'd better watched out for the sacred column
   585  1305 d0f1                                   bne m1303                               ; bne $1303
   586  1307 c95f               +                   cmp #$5f
   587  1309 d0d6                                   bne m12EC                               ; bne $12ec
   588  130b a9bc                                   lda #$bc            ; light picked up
   589  130d 8dfe36                                 sta items + $74                        ; sta $36fe           ; but I dont understand how the whole light is shown
   590  1310 a95f                                   lda #$5f
   591  1312 8dfc36                                 sta items + $72                        ; sta $36fc
   592  1315 204638                                 jsr m3846
   593  1318 a0ff                                   ldy #$ff
   594  131a 20763a                                 jsr wait
   595  131d 20763a                                 jsr wait
   596  1320 20763a                                 jsr wait
   597  1323 20763a                                 jsr wait
   598  1326 a9df                                   lda #$df
   599  1328 8dfe36                                 sta items + $74                        ; sta $36fe
   600  132b a900                                   lda #$00
   601  132d 8dfc36                                 sta items + $72                        ; sta $36fc
   602  1330 4ccf11                                 jmp check_death
   603                          
   604                          ; ==============================================================================
   605                          
   606                          room_08:
   607  1333 c008                                   cpy #$08
   608  1335 d054                                   bne room_09                               ; bne $1396
   609  1337 a000                                   ldy #$00
   610  1339 84a7                                   sty zpA7
   611  133b c94b                                   cmp #$4b            ; water
   612  133d d015                                   bne check_item_water                    ; bne $135f
   613  133f ac9439                                 ldy m3993 + 1                           ; ldy $3994
   614  1342 d017                                   bne m1366                               ; bne $1366
   615  1344 200236                                 jsr m3602
   616  1347 a918                                   lda #$18
   617  1349 8da635             m1354:              sta player_pos_x + 1
   618  134c a90c                                   lda #$0c
   619  134e 8da435                                 sta player_pos_y + 1
   620  1351 4c4c3b             m135C:              jmp m3B4C           ; jmp $3b4c
   621                          
   622                          
   623                          ; ==============================================================================
   624                          
   625                          check_item_water:
   626  1354 c956                                   cmp #$56        ; water character
   627  1356 d011                                   bne check_item_shovel                   ; bne $1374
   628  1358 ac9439                                 ldy m3993 + 1                           ; ldy $3994
   629  135b d007               m1366:              bne +                                   ; bne $136f
   630  135d 200236                                 jsr m3602
   631  1360 a90c                                   lda #$0c
   632  1362 d0e5                                   bne m1354                               ; bne $1354
   633  1364 a002               +                   ldy #$02
   634  1366 4cac3e                                 jmp death       ; 02 You drowned in the deep river
   635                          
   636                          ; ==============================================================================
   637                          
   638                          check_item_shovel:
   639  1369 c9c1                                   cmp #$c1            ; shovel
   640  136b f004                                   beq +                                   ; beq $137c
   641  136d c9c3                                   cmp #$c3            ; shovel
   642  136f d008                                   bne m1384                               ; bne $1384
   643  1371 a9df               +                   lda #$df
   644  1373 8d2037                                 sta items + $96                        ; sta $3720
   645  1376 4ccf11             m1381:              jmp check_death
   646                          
   647                          ; ==============================================================================
   648                          
   649                          m1384:
   650  1379 c9cb                                   cmp #$cb
   651  137b d028                                   bne m13B0
   652  137d ad4537                                 lda items + $bb                         ; hammer
   653  1380 c9df                                   cmp #$df
   654  1382 d0cd                                   bne m135C                               ; bne $135c
   655  1384 a9df                                   lda #$df
   656  1386 8d0e37                                 sta items + $84                        ; sta $370e
   657  1389 d0eb                                   bne m1381                               ; bne $1381
   658                          
   659  138b c009               room_09:            cpy #$09
   660  138d d009                                   bne room_10                               ; bne $13a3
   661  138f c927                                   cmp #$27
   662  1391 b012                                   bcs m13B0
   663  1393 a002                                   ldy #$02
   664  1395 4c3110                                 jmp m1031           ; jmp $1031
   665                          
   666                          ; ==============================================================================
   667                          
   668                          room_10:
   669  1398 c00a                                   cpy #$0a
   670  139a d02b                                   bne room_11                               ; bne $13d2
   671  139c c927                                   cmp #$27
   672  139e b008                                   bcs m13B3                               ; bcs $13b3
   673  13a0 a000                                   ldy #$00
   674  13a2 4c3110                                 jmp m1031           ; jmp $1031
   675                          ; ==============================================================================
   676                          
   677  13a5 4ce211             m13B0:              jmp m11ED
   678                          
   679                          ; ==============================================================================
   680                          
   681                          m13B3:
   682  13a8 c9cc                                   cmp #$cc
   683  13aa f004                                   beq +                                   ; beq $13bb
   684  13ac c9cf                                   cmp #$cf
   685  13ae d0f5                                   bne m13B0
   686  13b0 a9df               +                   lda #$df
   687  13b2 cdfe36                                 cmp items + $74                        ; cmp $36fe
   688  13b5 d00b                                   bne m13CD           ; bne $13cd
   689  13b7 cd5237                                 cmp items + $c8                        ; cmp $3752
   690  13ba d006                                   bne m13CD           ; bne $13cd
   691  13bc 8d3637                                 sta items + $ac                        ; sta $3736
   692  13bf 4ccf11             m13CA:              jmp check_death
   693                          
   694                          ; ==============================================================================
   695                          ; death by 240 volts
   696                          
   697                          m13CD:
   698  13c2 a006                                   ldy #$06
   699  13c4 4cac3e                                 jmp death    ; 06 240 Volts! You got an electrical shock!
   700                          
   701                          ; ==============================================================================
   702                          
   703                          room_11:
   704  13c7 c00b                                   cpy #$0b
   705  13c9 d00b                                   bne room_12                                   ; bne $13e1
   706  13cb c9d1                                   cmp #$d1
   707  13cd d0d6                                   bne m13B0
   708  13cf a9df                                   lda #$df                ; player takes the hammer
   709  13d1 8d4537                                 sta items + $bb                         ; hammer
   710  13d4 d0e9                                   bne m13CA                               ; bne $13ca
   711                          
   712                          ; ==============================================================================
   713                          
   714                          room_12:
   715  13d6 c00c                                   cpy #$0c
   716  13d8 d018                                   bne room_13                               ; bne $13fd
   717  13da c927                                   cmp #$27
   718  13dc b005                                   bcs m13EE                               ; bcs $13ee
   719  13de a000                                   ldy #$00
   720  13e0 4c3110                                 jmp m1031           ; jmp $1031
   721                          ; ==============================================================================
   722                          
   723                          m13EE:
   724  13e3 c9d2                                   cmp #$d2
   725  13e5 f004                                   beq +                                   ; beq $13f6
   726  13e7 c9d5                                   cmp #$d5
   727  13e9 d0ba                                   bne m13B0
   728  13eb a9df               +                   lda #$df
   729  13ed 8d5237                                 sta items + $c8                        ; sta $3752
   730  13f0 d0cd                                   bne m13CA                               ; bne $13ca
   731                          
   732                          ; ==============================================================================
   733                          
   734  13f2 c00d               room_13:            cpy #$0d
   735  13f4 d020                                   bne room_14                               ; bne $1421
   736  13f6 c927                                   cmp #$27
   737  13f8 b005                                   bcs m140A                               ; bcs $140a
   738  13fa a000                                   ldy #$00
   739  13fc 4c3110                                 jmp m1031           ; jmp $1031
   740                          
   741                          ; ==============================================================================
   742                          
   743                          m140A:
   744  13ff c9d6                                   cmp #$d6
   745  1401 d0a2                                   bne m13B0
   746  1403 ad0e37                                 lda items + $84                        ; lda $370e
   747  1406 c9df                                   cmp #$df
   748  1408 f005                                   beq m141A                               ; beq $141a
   749  140a a007                                   ldy #$07
   750  140c 4cac3e                                 jmp death    ; 07 You stepped on a nail!
   751                          
   752                          ; ==============================================================================
   753                          
   754                          m141A:
   755  140f a9e2                                   lda #$e2
   756  1411 8d5f37                                 sta items + $d5                        ; sta $375f
   757  1414 d0a9                                   bne m13CA                               ; bne $13ca
   758                          
   759                          ; ==============================================================================
   760                          
   761  1416 c00e               room_14:            cpy #$0e
   762  1418 d009                                   bne room_15                               ; bne $142e
   763  141a c9d7                                   cmp #$d7
   764  141c d087                                   bne m13B0
   765  141e a008                                   ldy #$08
   766  1420 4cac3e                                 jmp death    ; 08 A foot trap stopped you!
   767                          
   768                          ; ==============================================================================
   769                          
   770                          room_15:
   771  1423 c00f                                   cpy #$0f
   772  1425 d00c                                   bne room_16                               ; bne $143e
   773  1427 c927                                   cmp #$27
   774  1429 b005                                   bcs m143B                               ; bcs $143b
   775  142b a000                                   ldy #$00
   776  142d 4c3110                                 jmp m1031           ; jmp $1031
   777                          
   778                          ; ==============================================================================
   779                          
   780                          m143B:
   781  1430 4ca513                                 jmp m13B0
   782                          ; ==============================================================================
   783                          
   784                          room_16:
   785  1433 c010                                   cpy #$10
   786  1435 d022                                   bne room_17                               ; bne $1464
   787  1437 c9f4                                   cmp #$f4
   788  1439 d005                                   bne m144B                               ; bne $144b
   789  143b a00a                                   ldy #$0a
   790  143d 4cac3e             m1448:              jmp death    ; 0a You were locked in and starved!
   791                          
   792                          ; ==============================================================================
   793                          
   794                          m144B:
   795  1440 c9d9                                   cmp #$d9
   796  1442 f004                                   beq +                                   ; beq $1453
   797  1444 c9db                                   cmp #$db
   798  1446 d004                                   bne ++                                  ; bne $1457
   799  1448 a009               +                   ldy #$09          ; 09 This room is doomed by the wizard Manilo!
   800  144a d0f1                                   bne m1448                               ; bne $1448
   801  144c c9b8               ++                  cmp #$b8
   802  144e f004                                   beq +                                   ; beq $145f
   803  1450 c9bb                                   cmp #$bb
   804  1452 d0dc                                   bne m143B                               ; bne $143b
   805  1454 a003               +                   ldy #$03
   806  1456 4c3110                                 jmp m1031           ; jmp $1031
   807                          
   808                          ; ==============================================================================
   809                          
   810                          room_17:
   811  1459 c011                                   cpy #$11
   812  145b d00c                                   bne room_18                               ; bne $1474
   813  145d c9dd                                   cmp #$dd
   814  145f d0cf                                   bne m143B                               ; bne $143b
   815  1461 a9df                                   lda #$df
   816  1463 8d3138                                 sta items + $1a7                        ; sta $3831
   817  1466 4ccf11                                 jmp check_death
   818                          
   819                          ; ==============================================================================
   820                          
   821                          room_18:
   822  1469 c981                                   cmp #$81
   823  146b b003                                   bcs +                   ; bcs $147b
   824  146d 4ccf11                                 jmp check_death
   825                          +
   826  1470 ad9912                                 lda key_in_bottle_storage           ; lda $12a4
   827  1473 d003                                   bne +               ; bne $1b97
   828  1475 4c4c3b                                 jmp m3B4C           ; jmp $3b4c
   829  1478 209d3a             +                   jsr set_charset_and_screen_for_title           ; jsr $3a9d
   830  147b 4c421b                                 jmp print_endscreen ; jmp $1b44
   831                          
   832                          ; ==============================================================================
   833                          
   834  147e ac4c30             m147E:              ldy current_room + 1
   835  1481 c00e                                   cpy #$0e
   836  1483 d005                                   bne m148A               ; bne $148a
   837  1485 a020                                   ldy #$20
   838  1487 4c763a                                 jmp wait
   839                          
   840                          ; ==============================================================================
   841                          
   842  148a c00f               m148A:              cpy #$0f
   843  148c d03a                                   bne m14C8               ; bne $14c8
   844  148e a900                                   lda #$00
   845  1490 85a7                                   sta zpA7
   846  1492 a00c                                   ldy #$0c
   847  1494 a206               m1494:              ldx #$06
   848  1496 200836                                 jsr m3608
   849  1499 a9eb                                   lda #$eb
   850  149b 85a8                                   sta zpA8
   851  149d a939                                   lda #$39
   852  149f 850a                                   sta zp0A
   853  14a1 ae9514                                 ldx m1494 + 1           ; ldx $1495
   854  14a4 a901               m14A4:              lda #$01
   855  14a6 d00a                                   bne m14B2               ; bne $14b2
   856  14a8 e006                                   cpx #$06
   857  14aa d002                                   bne +                   ; bne $14ae
   858  14ac a901                                   lda #$01
   859  14ae ca                 +                   dex
   860  14af 4cb914                                 jmp +                   ; jmp $14b9
   861                          
   862                          ; ==============================================================================
   863                          
   864  14b2 e00b               m14B2:              cpx #$0b
   865  14b4 d002                                   bne ++                              ; bne $14b8
   866  14b6 a900                                   lda #$00
   867  14b8 e8                 ++                  inx
   868  14b9 8e9514             +                   stx m1494 + 1                       ; stx $1495
   869  14bc 8da514                                 sta m14A4 + 1                       ; sta $14a5
   870  14bf a901                                   lda #$01
   871  14c1 85a7                                   sta zpA7
   872  14c3 a00c                                   ldy #$0c
   873  14c5 4c0836                                 jmp m3608
   874                          
   875                          ; ==============================================================================
   876                          
   877  14c8 c011               m14C8:              cpy #$11
   878  14ca d007                                   bne +                               ; bne $14d3
   879  14cc a901               m14CC:              lda #$01
   880  14ce f014                                   beq ++                              ; beq $14e4
   881  14d0 4cc015                                 jmp m15C1                           ; jmp $15c1
   882  14d3 a90f               +                   lda #$0f
   883  14d5 8d2536                                 sta m3624 + 1                       ; sta $3625
   884  14d8 8d2736                                 sta m3626 + 1                       ; sta $3627
   885  14db c00a                                   cpy #$0a
   886  14dd d044                                   bne m1523                           ; bne $1523
   887  14df cebf2f                                 dec m2FBF                           ; dec $2fbf
   888  14e2 f001                                   beq m14E5                           ; beq $14e5
   889  14e4 60                 ++                  rts
   890                          
   891                          ; ==============================================================================
   892                          ;
   893                          ;
   894                          ; ==============================================================================
   895                          
   896  14e5 a008               m14E5:              ldy #$08
   897  14e7 8cbf2f                                 sty m2FBF                           ; sty $2fbf
   898  14ea a909                                   lda #$09
   899  14ec 8505                                   sta zp05
   900  14ee a90d                                   lda #$0d
   901  14f0 8503                                   sta zp03
   902  14f2 a97b                                   lda #$7b
   903  14f4 8502                                   sta zp02
   904  14f6 8504                                   sta zp04
   905  14f8 a9df                                   lda #$df
   906  14fa cd0715                                 cmp m1506 + 1                       ; cmp $1507
   907  14fd d002                                   bne +                               ; bne $1501
   908  14ff a9d8                                   lda #$d8
   909  1501 8d0715             +                   sta m1506 + 1                       ; sta $1507
   910  1504 a206                                   ldx #$06
   911  1506 a9df               m1506:              lda #$df
   912  1508 a000                                   ldy #$00
   913  150a 9102                                   sta (zp02),y
   914  150c a9ee                                   lda #$ee
   915  150e 9104                                   sta (zp04),y
   916  1510 a502                                   lda zp02
   917  1512 18                                     clc
   918  1513 6928                                   adc #$28
   919  1515 8502                                   sta zp02
   920  1517 8504                                   sta zp04
   921  1519 9004                                   bcc +                               ; bcc $151f
   922  151b e603                                   inc zp03
   923  151d e605                                   inc zp05
   924  151f ca                 +                   dex
   925  1520 d0e4                                   bne m1506                           ; bne $1506
   926  1522 60                 -                   rts
   927                          
   928                          ; ==============================================================================
   929                          ;
   930                          ;
   931                          ; ==============================================================================
   932                          
   933  1523 c009               m1523:              cpy #$09
   934  1525 d0fb                                   bne -                           ; bne $1522
   935  1527 4cac15                                 jmp m15AD                       ; jmp $15ad
   936                          
   937                          ; ==============================================================================
   938                          m152B:
   939  152a a90c                                   lda #$0c
   940  152c 8503                                   sta zp03
   941  152e a90f                                   lda #$0f
   942  1530 8502                                   sta zp02
   943  1532 8504                                   sta zp04
   944  1534 a206               m1535:              ldx #$06
   945  1536 a900               m1537:              lda #$00
   946  1538 d009                                   bne +                           ; bne $1544
   947  153a ca                                     dex
   948  153b e002                                   cpx #$02
   949  153d d00b                                   bne ++                          ; bne $154b
   950  153f a901                                   lda #$01
   951  1541 d007                                   bne ++                          ; bne $154b
   952  1543 e8                 +                   inx
   953  1544 e007                                   cpx #$07
   954  1546 d002                                   bne ++                          ; bne $154b
   955  1548 a900                                   lda #$00
   956  154a 8d3715             ++                  sta m1537 + 1                   ; sta $1538
   957  154d 8e3515                                 stx m1535 + 1                   ; stx $1536
   958  1550 a000               -                   ldy #$00
   959  1552 a9df                                   lda #$df
   960  1554 9102                                   sta (zp02),y
   961  1556 c8                                     iny
   962  1557 c8                                     iny
   963  1558 9102                                   sta (zp02),y
   964  155a 88                                     dey
   965  155b a9ea                                   lda #$ea
   966  155d 9102                                   sta (zp02),y
   967  155f 9104                                   sta (zp04),y
   968  1561 209c15                                 jsr m159D                       ; jsr $159d
   969  1564 ca                                     dex
   970  1565 d0e9                                   bne -                           ; bne $1551
   971  1567 a9e4                                   lda #$e4
   972  1569 85a8                                   sta zpA8
   973  156b a202                                   ldx #$02
   974  156d a000               --                  ldy #$00
   975  156f a5a8               -                   lda zpA8
   976  1571 9102                                   sta (zp02),y
   977  1573 a9da                                   lda #$da
   978  1575 9104                                   sta (zp04),y
   979  1577 e6a8                                   inc zpA8
   980  1579 c8                                     iny
   981  157a c003                                   cpy #$03
   982  157c d0f1                                   bne -                           ; bne $1570
   983  157e 209c15                                 jsr m159D                       ; jsr $159d
   984  1581 ca                                     dex
   985  1582 d0e9                                   bne --                          ; bne $156e
   986  1584 a000                                   ldy #$00
   987  1586 a9e7                                   lda #$e7
   988  1588 85a8                                   sta zpA8
   989  158a b102               -                   lda (zp02),y
   990  158c c5a8                                   cmp zpA8
   991  158e d004                                   bne +                           ; bne $1595
   992  1590 a9df                                   lda #$df
   993  1592 9102                                   sta (zp02),y
   994  1594 e6a8               +                   inc zpA8
   995  1596 c8                                     iny
   996  1597 c003                                   cpy #$03
   997  1599 d0ef                                   bne -                           ; bne $158b
   998  159b 60                                     rts
   999                          
  1000                          ; ==============================================================================
  1001                          ;
  1002                          ;
  1003                          ; ==============================================================================
  1004                          
  1005  159c a502               m159D:              lda zp02
  1006  159e 18                                     clc
  1007  159f 6928                                   adc #$28
  1008  15a1 8502                                   sta zp02
  1009  15a3 8504                                   sta zp04
  1010  15a5 9004                                   bcc +                                   ; bcc $15ac
  1011  15a7 e603                                   inc zp03
  1012  15a9 e605                                   inc zp05
  1013  15ab 60                 +                   rts
  1014                          
  1015                          ; ==============================================================================
  1016                          ;
  1017                          ;
  1018                          ; ==============================================================================
  1019                          
  1020  15ac a201               m15AD:              ldx #$01
  1021  15ae e001                                   cpx #$01
  1022  15b0 d004                                   bne m15B7                               ; bne $15b7
  1023  15b2 cead15                                 dec m15AD + 1                           ; dec $15ae
  1024  15b5 60                                     rts
  1025                          
  1026                          ; ==============================================================================
  1027                          ;
  1028                          ;
  1029                          ; ==============================================================================
  1030                          
  1031  15b6 eead15             m15B7:              inc m15AD + 1                           ; inc $15ae
  1032  15b9 a908                                   lda #$08
  1033  15bb 8505                                   sta zp05
  1034  15bd 4c2a15                                 jmp m152B           ; jmp $152b
  1035                          
  1036                          ; ==============================================================================
  1037                          
  1038  15c0 a900               m15C1:              lda #$00
  1039  15c2 c900                                   cmp #$00
  1040  15c4 d004                                   bne m15CB                               ; bne $15cb
  1041  15c6 eec115                                 inc m15C1 + 1                           ; inc $15c2
  1042  15c9 60                                     rts
  1043                          
  1044                          ; ==============================================================================
  1045                          ;
  1046                          ;
  1047                          ; ==============================================================================
  1048                          
  1049  15ca cec115             m15CB:              dec m15C1 + 1                           ; dec $15c2
  1050  15cd 4c2036                                 jmp m3620
  1051                          
  1052                          ; ==============================================================================
  1053                          
  1054  15d0 ad3637             m15D1:              lda items + $ac                        ; lda $3736
  1055  15d3 c9df                                   cmp #$df
  1056  15d5 d005                                   bne +                                   ; bne $15dd
  1057  15d7 a959                                   lda #$59
  1058  15d9 8db637                                 sta items + $12c                        ; sta $37b6
  1059  15dc ad4c30             +                   lda current_room + 1
  1060  15df c911                                   cmp #$11
  1061  15e1 d046                                   bne m162A                               ; bne $162a
  1062  15e3 adcd14                                 lda m14CC + 1                           ; lda $14cd
  1063  15e6 d013                                   bne m15FC                               ; bne $15fc
  1064  15e8 ada435                                 lda player_pos_y + 1
  1065  15eb c906                                   cmp #$06
  1066  15ed d00c                                   bne m15FC                               ; bne $15fc
  1067  15ef ada635                                 lda player_pos_x + 1
  1068  15f2 c918                                   cmp #$18
  1069  15f4 d005                                   bne m15FC                               ; bne $15fc
  1070  15f6 a900                                   lda #$00
  1071  15f8 8dfc15                                 sta m15FC + 1                           ; sta $15fd
  1072  15fb a901               m15FC:              lda #$01
  1073  15fd d016                                   bne +                                   ; bne $1616
  1074  15ff a006                                   ldy #$06
  1075  1601 a21e               m1602:              ldx #$1e
  1076  1603 a900                                   lda #$00
  1077  1605 85a7                                   sta zpA7
  1078  1607 200836                                 jsr m3608
  1079  160a ae0216                                 ldx m1602 + 1                   ; ldx $1603
  1080  160d e003                                   cpx #$03
  1081  160f f001                                   beq ++                          ; beq $1613
  1082  1611 ca                                     dex
  1083  1612 8e0216             ++                  stx m1602 + 1                   ; stx $1603
  1084  1615 a978               +                   lda #$78
  1085  1617 85a8                                   sta zpA8
  1086  1619 a949                                   lda #$49
  1087  161b 850a                                   sta zp0A
  1088  161d a006                                   ldy #$06
  1089  161f a901                                   lda #$01
  1090  1621 85a7                                   sta zpA7
  1091  1623 ae0216                                 ldx m1602 + 1                   ; ldx $1603
  1092  1626 200836                                 jsr m3608
  1093  1629 4c7e14             m162A:              jmp m147E                   ; jmp $147e
  1094                          
  1095                          
  1096                          ; ==============================================================================
  1097                          
  1098                          m162d:
  1099  162c a209                                   ldx #$09
  1100  162e bd3b03             -                   lda TAPE_BUFFER + $8,x         ; lda $033b,x              ; cassette tape buffer
  1101  1631 9d4b03                                 sta TAPE_BUFFER + $18,x         ; sta $034b,x              ; cassette tape buffer
  1102  1634 ca                                     dex
  1103  1635 d0f7                                   bne -                       ; bne $162f
  1104  1637 a902                                   lda #$02
  1105  1639 85a7                                   sta zpA7
  1106  163b aea635                                 ldx player_pos_x + 1
  1107  163e aca435                                 ldy player_pos_y + 1
  1108  1641 200836                                 jsr m3608
  1109  1644 a209                                   ldx #$09
  1110  1646 bd3b03             m1647:              lda TAPE_BUFFER + $8,x      ; lda $033b,x              ; cassette tape buffer
  1111  1649 c9d8                                   cmp #$d8
  1112  164b d005                                   bne +                   ; bne $1653
  1113  164d a005               m164E:              ldy #$05
  1114  164f 4cac3e             m1650:              jmp death               ; 05 Didn't you see the laser beam?
  1115                          
  1116                          ; ==============================================================================
  1117                          
  1118  1652 ac4c30             +                   ldy current_room + 1
  1119  1655 c011                                   cpy #$11
  1120  1657 d010                                   bne +                       ; bne $166a
  1121  1659 c978                                   cmp #$78
  1122  165b f008                                   beq ++                      ; beq $1666
  1123  165d c97b                                   cmp #$7b
  1124  165f f004                                   beq ++                      ; beq $1666
  1125  1661 c97e                                   cmp #$7e
  1126  1663 d004                                   bne +                       ; bne $166a
  1127  1665 a00b               ++                  ldy #$0b                      ; 0b You were hit by a big rock and died!
  1128  1667 d0e6                                   bne m1650                   ; bne $1650
  1129  1669 c99c               +                   cmp #$9c
  1130  166b 9007                                   bcc m1676                   ; bcc $1676
  1131  166d c9a5                                   cmp #$a5
  1132  166f b003                                   bcs m1676                   ; bcs $1676
  1133  1671 4ca516                                 jmp m16A7                 ; jmp $16a7
  1134                          
  1135                          ; ==============================================================================
  1136                          
  1137  1674 c9e4               m1676:              cmp #$e4
  1138  1676 9010                                   bcc +                           ; bcc $168a
  1139  1678 c9eb                                   cmp #$eb
  1140  167a b004                                   bcs ++                          ; bcs $1682
  1141  167c a004               -                   ldy #$04                        ; 04 Boris the spider got you and killed you
  1142  167e d0cf                                   bne m1650                       ; bne $1650
  1143  1680 c9f4               ++                  cmp #$f4
  1144  1682 b004                                   bcs +                           ; bcs $168a
  1145  1684 a00e                                   ldy #$0e                      ; 0e The monster grabbed you you. You are dead!
  1146  1686 d0c7                                   bne m1650                       ; bne $1650
  1147  1688 ca                 +                   dex
  1148  1689 d0bb                                   bne m1647                       ; bne $1647
  1149  168b a209                                   ldx #$09
  1150  168d bd4b03             --                  lda $034b,x
  1151  1690 9d3b03                                 sta TAPE_BUFFER + $8,x          ; sta $033b,x
  1152  1693 c9d8                                   cmp #$d8
  1153  1695 f0b6                                   beq m164E                       ; beq $164e
  1154  1697 c9e4                                   cmp #$e4
  1155  1699 9004                                   bcc +                           ; bcc $16a1
  1156  169b c9ea                                   cmp #$ea
  1157  169d 90dd                                   bcc -                           ; bcc $167e
  1158  169f ca                 +                   dex
  1159  16a0 d0eb                                   bne --                          ; bne $168f
  1160  16a2 4cd511                                 jmp m11E0                     ; jmp $11e0
  1161                          
  1162                          m16A7:
  1163  16a5 ac3138                                 ldy items + $1a7                ; ldy $3831
  1164  16a8 c0df                                   cpy #$df
  1165  16aa f004                                   beq +                           ; beq $16b2
  1166  16ac a00c                                   ldy #$0c                      ; 0c Belegro killed you!
  1167  16ae d09f                                   bne m1650                       ; bne $1650
  1168  16b0 a000               +                   ldy #$00
  1169  16b2 8ccd14                                 sty m14CC + 1                   ; sty $14cd
  1170  16b5 4c7416                                 jmp m1676                       ; jmp $1675
  1171                          
  1172                          ; ==============================================================================
  1173                          ; this might be the inventory/ world reset
  1174                          ; puts all items into the level data again
  1175                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1176                          ; addresses are mostly within items.asm address space ( $368a )
  1177                          ; ==============================================================================
  1178                          
  1179                          m16BA:
  1180  16b8 a9a5                                   lda #$a5                        ; $a5 = the door of the shed where the ladder is
  1181  16ba 8dc236                                 sta items + $38                        ; sta $36c2
  1182  16bd a9a9                                   lda #$a9                        ; a9 = NO gloves
  1183  16bf 8d9236                                 sta items + $8                        ; sta $3692                       ; inventory gloves
  1184  16c2 a979                                   lda #$79
  1185  16c4 8d9036                                 sta items + $6                        ; sta $3690
  1186  16c7 a9e0                                   lda #$e0                        ; empty char
  1187  16c9 8d9a36                                 sta items + $10                        ; sta $369a
  1188  16cc a9ac                                   lda #$ac                        ; wirecutter
  1189  16ce 8da336                                 sta items + $19                        ; sta $36a3
  1190  16d1 a9b8                                   lda #$b8                        ; part of the bottle - hmmm...
  1191  16d3 8db336                                 sta items + $29                        ; sta $36b3
  1192  16d6 a9b0                                   lda #$b0                        ; the ladder
  1193  16d8 8dd736                                 sta items + $4d                        ; sta $36d7
  1194  16db a9b5                                   lda #$b5                        ; more ladder
  1195  16dd 8de236                                 sta items + $58                        ; sta $36e2
  1196  16e0 a95e                                   lda #$5e                        ; seems to be water?
  1197  16e2 8dfe36                                 sta items + $74                        ; sta $36fe
  1198  16e5 a9c6                                   lda #$c6                        ; boots in the whatever box
  1199  16e7 8d0e37                                 sta items + $84                        ; sta $370e
  1200  16ea a9c0                                   lda #$c0                        ; not sure
  1201  16ec 8d2037                                 sta items + $96                        ; sta $3720
  1202  16ef a9cc                                   lda #$cc                        ; power outlet
  1203  16f1 8d3637                                 sta items + $ac                        ; sta $3736
  1204  16f4 a9d0                                   lda #$d0                        ; the hammer
  1205  16f6 8d4537                                 sta items + $bb                        ; sta $3745
  1206  16f9 a9d2                                   lda #$d2                        ; unsure
  1207  16fb 8d5237                                 sta items + $c8                        ; sta $3752
  1208  16fe a9d6                                   lda #$d6                        ; unsure
  1209  1700 8d5f37                                 sta items + $d5                        ; sta $375f
  1210  1703 a900                                   lda #$00                        ; door
  1211  1705 8db637                                 sta items + $12c                        ; sta $37b6
  1212  1708 a9dd                                   lda #$dd                        ; unsure
  1213  170a 8d3138                                 sta items + $1a7                        ; sta $3831
  1214  170d a901                                   lda #$01                        ; door
  1215  170f 8d4b39                                 sta items + $2c1                        ; sta $394b
  1216  1712 a901                                   lda #$01                        ; door
  1217  1714 8d9439                                 sta items + $30a                        ; sta $3994
  1218  1717 a9f5                                   lda #$f5                        ; fence
  1219  1719 8d0139                                 sta items + $277                        ; sta $3901
  1220  171c a900                                   lda #$00                        ; key in the bottle
  1221  171e 8d9912                                 sta key_in_bottle_storage                               ; sta $12a4
  1222  1721 a901                                   lda #$01                        ; door
  1223  1723 8dfc15                                 sta m15FC + 1                           ; sta $15fd
  1224  1726 a91e                                   lda #$1e
  1225  1728 8d0216                                 sta m1602 + 1                           ; sta $1603
  1226  172b a901                                   lda #$01
  1227  172d 8dcd14                                 sta m14CC + 1                           ; sta $14cd
  1228  1730 a205               m1732:              ldx #$05
  1229  1732 e007                                   cpx #$07
  1230  1734 d002                                   bne +                                   ; bne $173a
  1231  1736 a2ff                                   ldx #$ff
  1232  1738 e8                 +                   inx
  1233  1739 8e3117                                 stx m1732 + 1                           ; stx $1733
  1234  173c bd4517                                 lda m1747,x                             ; lda $1747,x
  1235  173f 8d5339                                 sta m3952 + 1                   ; sta $3953
  1236  1742 4c0431                                 jmp print_title     ; jmp $310d
  1237                          
  1238                          ; ==============================================================================
  1239                          
  1240                          m1747:
  1241  1745 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1242                          
  1243                          
  1244                          m174F:
  1245  174d e00c                                   cpx #$0c
  1246  174f d002                                   bne +           ; bne $1755
  1247  1751 a949                                   lda #$49
  1248  1753 e00d               +                   cpx #$0d
  1249  1755 d002                                   bne +           ; bne $175b
  1250  1757 a945                                   lda #$45
  1251  1759 60                 +                   rts
  1252                          
  1253                          
  1254                          
  1255                          screen_win_src:
  1256                                              !if LANGUAGE = EN{
  1257                                                  !bin "includes/screen-win-en.scr"
  1258                                              }
  1259                                              !if LANGUAGE = DE{
  1260  175a 7040404040404040...                        !bin "includes/screen-win-de.scr"
  1261                                              }
  1262                          screen_win_src_end:
  1263                                              
  1264                          
  1265                          ; ==============================================================================
  1266                          ;
  1267                          ; PRINT WIN SCREEN
  1268                          ; ==============================================================================
  1269                                            
  1270                          print_endscreen:
  1271  1b42 a90c                                   lda #>SCREENRAM       ; lda #$0c
  1272  1b44 8503                                   sta zp03
  1273  1b46 a908                                   lda #>COLRAM        ; lda #$08
  1274  1b48 8505                                   sta zp05
  1275  1b4a a900                                   lda #<SCREENRAM       ; lda #$00
  1276  1b4c 8502                                   sta zp02
  1277  1b4e 8504                                   sta zp04
  1278  1b50 a204                                   ldx #$04
  1279  1b52 a917                                   lda #>screen_win_src;lda #$17
  1280  1b54 85a8                                   sta zpA8
  1281  1b56 a95a                                   lda #<screen_win_src;lda #$5c
  1282  1b58 85a7                                   sta zpA7
  1283  1b5a a000                                   ldy #$00
  1284  1b5c b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1285  1b5e 9102                                   sta (zp02),y        ; to SCREEN
  1286  1b60 a900                                   lda #$00           ; color = BLACK
  1287  1b62 9104                                   sta (zp04),y        ; to COLRAM
  1288  1b64 c8                                     iny
  1289  1b65 d0f5                                   bne -               ; bne $1b5e
  1290  1b67 e603                                   inc zp03
  1291  1b69 e605                                   inc zp05
  1292  1b6b e6a8                                   inc zpA8
  1293  1b6d ca                                     dex
  1294  1b6e d0ec                                   bne -               ; bne $1b5e
  1295  1b70 a9ff                                   lda #$ff           ; PISSGELB
  1296  1b72 8d15ff                                 sta BG_COLOR          ; background
  1297  1b75 8d19ff                                 sta BORDER_COLOR          ; und border
  1298  1b78 a9fd               -                   lda #$fd
  1299  1b7a 8d08ff                                 sta KEYBOARD_LATCH
  1300  1b7d ad08ff                                 lda KEYBOARD_LATCH
  1301  1b80 2980                                   and #$80           ; WAITKEY?
  1302  1b82 d0f4                                   bne -               ; bne $1b7a
  1303  1b84 200431                                 jsr print_title     ; jsr $310d
  1304  1b87 200431                                 jsr print_title     ; jsr $310d
  1305  1b8a 4cb33a                                 jmp init            ; jmp $3ab3
  1306                          
  1307                          
  1308                          ; ==============================================================================
  1309                          ;
  1310                          ; INTRO TEXT SCREEN
  1311                          ; ==============================================================================
  1312                          
  1313                          intro_text:
  1314                          
  1315                          ; instructions screen
  1316                          ; "Search the treasure..."
  1317                          
  1318                          !if LANGUAGE = EN{
  1319                          !scr "Search the treasure of Ghost Town and   "
  1320                          !scr "open it ! Kill Belegro, the wizard, and "
  1321                          !scr "dodge all other dangers. Don't forget to"
  1322                          !scr "use all the items you'll find during    "
  1323                          !scr "your yourney through 19 amazing hires-  "
  1324                          !scr "graphics-rooms! Enjoy the quest and play"
  1325                          !scr "it again and again and again ...      > "
  1326                          }
  1327                          
  1328                          !if LANGUAGE = DE{
  1329  1b8d 53150308050e2053...!scr "Suchen Sie die Schatztruhe der Geister- "
  1330  1bb5 131401041420150e...!scr "stadt und oeffnen Sie diese ! Toeten    "
  1331  1bdd 5309052042050c05...!scr "Sie Belegro, den Zauberer und weichen   "
  1332  1c05 530905201609050c...!scr "Sie vielen anderen Wesen geschickt aus. "
  1333  1c2d 42050409050e050e...!scr "Bedienen Sie sich an den vielen Gegen-  "
  1334  1c55 131401050e04050e...!scr "staenden, welche sich in den 19 Bildern "
  1335  1c7d 020506090e04050e...!scr "befinden. Viel Spass !                > "
  1336                          }
  1337                          
  1338                          display_intro_text:
  1339                          
  1340                                              ; i think this part displays the introduction text
  1341                          
  1342  1ca5 a90c                                   lda #>SCREENRAM       ; lda #$0c
  1343  1ca7 8503                                   sta zp03
  1344  1ca9 a908                                   lda #>COLRAM        ; lda #$08
  1345  1cab 8505                                   sta zp05
  1346  1cad a9a0                                   lda #$a0
  1347  1caf 8502                                   sta zp02
  1348  1cb1 8504                                   sta zp04
  1349  1cb3 a91b                                   lda #>intro_text
  1350  1cb5 85a8                                   sta zpA8
  1351  1cb7 a98d                                   lda #<intro_text
  1352  1cb9 85a7                                   sta zpA7
  1353  1cbb a207                                   ldx #$07
  1354  1cbd a000               --                  ldy #$00
  1355  1cbf b1a7               -                   lda (zpA7),y
  1356  1cc1 9102                                   sta (zp02),y
  1357  1cc3 a968                                   lda #$68
  1358  1cc5 9104                                   sta (zp04),y
  1359  1cc7 c8                                     iny
  1360  1cc8 c028                                   cpy #$28
  1361  1cca d0f3                                   bne -
  1362  1ccc a5a7                                   lda zpA7
  1363  1cce 18                                     clc
  1364  1ccf 6928                                   adc #$28
  1365  1cd1 85a7                                   sta zpA7
  1366  1cd3 9002                                   bcc +           ; bcc $1ce7
  1367  1cd5 e6a8                                   inc zpA8
  1368  1cd7 a502               +                   lda zp02
  1369  1cd9 18                                     clc
  1370  1cda 6950                                   adc #$50
  1371  1cdc 8502                                   sta zp02
  1372  1cde 8504                                   sta zp04
  1373  1ce0 9004                                   bcc +           ; bcc $1cf6
  1374  1ce2 e603                                   inc zp03
  1375  1ce4 e605                                   inc zp05
  1376  1ce6 ca                 +                   dex                ; 1cf6
  1377  1ce7 d0d4                                   bne --          ; bne $1ccd
  1378  1ce9 a900                                   lda #$00
  1379  1ceb 8d15ff                                 sta BG_COLOR
  1380  1cee 60                                     rts
  1381                          
  1382                          ; ==============================================================================
  1383                          ;
  1384                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1385                          ; DECREASES MUSIC VOLUME
  1386                          ; ==============================================================================
  1387                          
  1388  1cef 8d08ff             start_intro:        sta KEYBOARD_LATCH
  1389  1cf2 206bc5                                 jsr PRINT_KERNAL           ; jsr $c56b
  1390  1cf5 20a51c                                 jsr display_intro_text           ; jsr $1cb5
  1391  1cf8 20d91e                                 jsr check_shift_key ; jsr $1ef9
  1392  1cfb a9ba                                   lda #$ba
  1393  1cfd 8db91e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  1394  1d00 60                                     rts
  1395                          ; ==============================================================================
  1396                          ; MUSIC
  1397                          ; ==============================================================================
  1398                                              !zone MUSIC

; ******** Source: includes/music.asm
     1                          ; music! :)
     2                          
     3                          music_data_voice1:
     4  1d01 8445434425262526...!byte $84, $45, $43, $44, $25, $26, $25, $26, $27, $24, $4b, $2c, $2d
     5  1d0e 2c2d2e2b44252625...!byte $2c, $2d, $2e, $2b, $44, $25, $26, $25, $26, $27, $24, $46, $64, $66, $47, $67
     6  1d1e 6746646647676727...!byte $67, $46, $64, $66, $47, $67, $67, $27, $29, $27, $49, $67, $44, $66, $64, $27
     7  1d2e 2927496744666432...!byte $29, $27, $49, $67, $44, $66, $64, $32, $35, $32, $50, $6e, $2f, $30, $31, $30
     8  1d3e 3132312f2f4f504f...!byte $31, $32, $31, $2f, $2f, $4f, $50, $4f, $2e, $2f, $30, $31, $30, $31, $32, $31
     9  1d4e 2f4f6d6b4e6c6a4f...!byte $2f, $4f, $6d, $6b, $4e, $6c, $6a, $4f, $6d, $6b, $4e, $6c, $6a
    10                          
    11                          music_data_voice2:
    12  1d5b 923133             !byte $92, $31, $33
    13  1d5e 3131523334333435...!byte $31, $31, $52, $33, $34, $33, $34, $35, $32, $54, $32, $52, $75, $54, $32, $52
    14  1d6e 758d8d2c2dce8d8d...!byte $75, $8d, $8d, $2c, $2d, $ce, $8d, $8d, $2c, $2d, $ce, $75, $34, $32, $30, $2e
    15  1d7e 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $35, $32, $35, $32, $35, $32, $2e
    16  1d8e 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $4b, $69, $67, $4c, $6a, $68, $4b
    17  1d9e 69674c6a68323332...!byte $69, $67, $4c, $6a, $68, $32, $33, $32, $b2, $33, $31, $32, $33, $34, $35, $36
    18  1dae 3533323131323334...!byte $35, $33, $32, $31, $31, $32, $33, $34, $33, $34, $35, $36, $35, $36, $37, $36
    19  1dbe ea                 !byte $ea

; ******** Source: main.asm
  1400                          ; ==============================================================================
  1401                          music_get_data:
  1402  1dbf a000               .voice1_dur_pt:     ldy #$00
  1403  1dc1 d01d                                   bne +
  1404  1dc3 a940                                   lda #$40
  1405  1dc5 8d261e                                 sta music_voice1+1
  1406  1dc8 20251e                                 jsr music_voice1
  1407  1dcb a200               .voice1_dat_pt:     ldx #$00
  1408  1dcd bd011d                                 lda music_data_voice1,x
  1409  1dd0 eecc1d                                 inc .voice1_dat_pt+1
  1410  1dd3 a8                                     tay
  1411  1dd4 291f                                   and #$1f
  1412  1dd6 8d261e                                 sta music_voice1+1
  1413  1dd9 98                                     tya
  1414  1dda 4a                                     lsr
  1415  1ddb 4a                                     lsr
  1416  1ddc 4a                                     lsr
  1417  1ddd 4a                                     lsr
  1418  1dde 4a                                     lsr
  1419  1ddf a8                                     tay
  1420  1de0 88                 +                   dey
  1421  1de1 8cc01d                                 sty .voice1_dur_pt + 1
  1422  1de4 a000               .voice2_dur_pt:     ldy #$00
  1423  1de6 d022                                   bne +
  1424  1de8 a940                                   lda #$40
  1425  1dea 8d4e1e                                 sta music_voice2 + 1
  1426  1ded 204d1e                                 jsr music_voice2
  1427  1df0 a200               .voice2_dat_pt:     ldx #$00
  1428  1df2 bd5b1d                                 lda music_data_voice2,x
  1429  1df5 a8                                     tay
  1430  1df6 e8                                     inx
  1431  1df7 e065                                   cpx #$65
  1432  1df9 f019                                   beq music_reset
  1433  1dfb 8ef11d                                 stx .voice2_dat_pt + 1
  1434  1dfe 291f                                   and #$1f
  1435  1e00 8d4e1e                                 sta music_voice2 + 1
  1436  1e03 98                                     tya
  1437  1e04 4a                                     lsr
  1438  1e05 4a                                     lsr
  1439  1e06 4a                                     lsr
  1440  1e07 4a                                     lsr
  1441  1e08 4a                                     lsr
  1442  1e09 a8                                     tay
  1443  1e0a 88                 +                   dey
  1444  1e0b 8ce51d                                 sty .voice2_dur_pt + 1
  1445  1e0e 20251e                                 jsr music_voice1
  1446  1e11 4c4d1e                                 jmp music_voice2
  1447                          ; ==============================================================================
  1448  1e14 a900               music_reset:        lda #$00
  1449  1e16 8dc01d                                 sta .voice1_dur_pt + 1
  1450  1e19 8dcc1d                                 sta .voice1_dat_pt + 1
  1451  1e1c 8de51d                                 sta .voice2_dur_pt + 1
  1452  1e1f 8df11d                                 sta .voice2_dat_pt + 1
  1453  1e22 4cbf1d                                 jmp music_get_data
  1454                          ; ==============================================================================
  1455                          ; write music data for voice1 / voice2 into TED registers
  1456                          ; ==============================================================================
  1457  1e25 a204               music_voice1:       ldx #$04
  1458  1e27 e01c                                   cpx #$1c
  1459  1e29 9008                                   bcc +
  1460  1e2b ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  1461  1e2e 29ef                                   and #$ef
  1462  1e30 4c491e                                 jmp writeFF11
  1463  1e33 bd751e             +                   lda freq_tab_lo,x
  1464  1e36 8d0eff                                 sta VOICE1_FREQ_LOW
  1465  1e39 ad12ff                                 lda VOICE1
  1466  1e3c 29fc                                   and #$fc
  1467  1e3e 1d8d1e                                 ora freq_tab_hi, x
  1468  1e41 8d12ff                                 sta VOICE1
  1469  1e44 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  1470  1e47 0910                                   ora #$10
  1471  1e49 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  1472  1e4c 60                                     rts
  1473                          ; ==============================================================================
  1474  1e4d a20d               music_voice2:       ldx #$0d
  1475  1e4f e01c                                   cpx #$1c
  1476  1e51 9008                                   bcc +
  1477  1e53 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  1478  1e56 29df                                   and #$df
  1479  1e58 4c491e                                 jmp writeFF11
  1480  1e5b bd751e             +                   lda freq_tab_lo,x
  1481  1e5e 8d0fff                                 sta VOICE2_FREQ_LOW
  1482  1e61 ad10ff                                 lda VOICE2
  1483  1e64 29fc                                   and #$fc
  1484  1e66 1d8d1e                                 ora freq_tab_hi,x
  1485  1e69 8d10ff                                 sta VOICE2
  1486  1e6c ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  1487  1e6f 0920                                   ora #$20
  1488  1e71 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  1489  1e74 60                                     rts
  1490                          ; ==============================================================================
  1491                          ; TED frequency tables
  1492                          ; ==============================================================================
  1493  1e75 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  1494  1e7c 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  1495  1e83 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  1496  1e8a 818f95                                 !byte $81, $8f, $95
  1497  1e8d 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  1498  1e94 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  1499  1e9b 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  1500  1ea2 030303                                 !byte $03, $03, $03
  1501                          ; ==============================================================================
  1502                                              MUSIC_DELAY_INITIAL   = $09
  1503                                              MUSIC_DELAY           = $0B
  1504  1ea5 a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  1505  1ea7 ca                                     dex
  1506  1ea8 8ea61e                                 stx music_play+1
  1507  1eab f001                                   beq +
  1508  1ead 60                                     rts
  1509  1eae a20b               +                   ldx #MUSIC_DELAY
  1510  1eb0 8ea61e                                 stx music_play+1
  1511  1eb3 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  1512  1eb6 0937                                   ora #$37
  1513  1eb8 29bf               music_volume:       and #$bf
  1514  1eba 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  1515  1ebd 4cbf1d                                 jmp music_get_data
  1516                          ; ==============================================================================
  1517                          ; irq init
  1518                          ; ==============================================================================
  1519                                              !zone IRQ
  1520  1ec0 78                 irq_init0:          sei
  1521  1ec1 a9e6                                   lda #<irq0          ; lda #$06
  1522  1ec3 8d1403                                 sta $0314          ; irq lo
  1523  1ec6 a91e                                   lda #>irq0          ; lda #$1f
  1524  1ec8 8d1503                                 sta $0315          ; irq hi
  1525                                                                  ; irq at $1F06
  1526  1ecb a902                                   lda #$02
  1527  1ecd 8d0aff                                 sta $ff0a          ; set IRQ source to RASTER
  1528                          
  1529  1ed0 a9bf                                   lda #$bf
  1530  1ed2 8db91e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  1531  1ed5 58                                     cli
  1532                          
  1533  1ed6 4c9d3a                                 jmp set_charset_and_screen_for_title           ; jmp $3a9d
  1534                          
  1535                          ; ==============================================================================
  1536                          ; intro text
  1537                          ; wait for shift or joy2 fire press
  1538                          ; ==============================================================================
  1539                          
  1540                          check_shift_key:
  1541                          
  1542  1ed9 a9fd               -                   lda #$fd
  1543  1edb 8d08ff                                 sta KEYBOARD_LATCH
  1544  1ede ad08ff                                 lda KEYBOARD_LATCH
  1545  1ee1 2980                                   and #$80            ; checks for SHIFT key, same as joy 2 fire?
  1546  1ee3 d0f4                                   bne -               ; bne $1ef9
  1547  1ee5 60                                     rts
  1548                          
  1549                          ; ==============================================================================
  1550                          ;
  1551                          ; INTERRUPT routine for music
  1552                          ; ==============================================================================
  1553                          
  1554                                              ; *= $1F06
  1555                          irq0:
  1556  1ee6 ad09ff                                 lda INTERRUPT
  1557  1ee9 8d09ff                                 sta INTERRUPT          ; ack IRQ
  1558                                                                  ; this IRQ seems to handle music only!
  1559                                              !if SILENT_MODE = 1 {
  1560                                                  jsr fake
  1561                                              } else {
  1562  1eec 20a51e                                     jsr music_play  ; jsr $1ebc
  1563                                              }
  1564  1eef 68                                     pla
  1565  1ef0 a8                                     tay
  1566  1ef1 68                                     pla
  1567  1ef2 aa                                     tax
  1568  1ef3 68                                     pla
  1569  1ef4 40                                     rti
  1570                          
  1571                          ; ==============================================================================
  1572                          ; gets called immediately after start of game
  1573                          ; looks like some sound/irq initialization?
  1574                          ; i think the branching part does fade the sound
  1575                          ; ==============================================================================
  1576                          
  1577                          m1F15:                                  ; call from init
  1578  1ef5 adb91e                                 lda music_volume+1         ; lda $1ed9           ; sound volume
  1579  1ef8 c9bf               --                  cmp #$bf           ; is true on init
  1580  1efa d003                                   bne +               ; bne $1f1f
  1581  1efc 4cc01e                                 jmp irq_init0       ; jmp $1ee0
  1582  1eff a204               +                   ldx #$04
  1583  1f01 86a8               -                   stx zpA8            ; buffer serial input byte ?
  1584  1f03 a0ff                                   ldy #$ff
  1585  1f05 20763a                                 jsr wait
  1586  1f08 a6a8                                   ldx zpA8
  1587  1f0a ca                                     dex
  1588  1f0b d0f4                                   bne -               ; bne $1f21 / some weird wait loop ?
  1589  1f0d 18                                     clc
  1590  1f0e 6901                                   adc #$01           ; add 1 (#$C0 on init)
  1591  1f10 8db91e                                 sta music_volume+1         ; sta $1ed9             ; sound volume
  1592  1f13 4cf81e                                 jmp --              ; jmp $1f18
  1593                          
  1594                          
  1595                          
  1596                          
  1597                          
  1598                          
  1599                                              ; 222222222222222         888888888          000000000           000000000
  1600                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  1601                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  1602                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  1603                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  1604                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  1605                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  1606                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  1607                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  1608                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  1609                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  1610                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  1611                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  1612                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  1613                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  1614                                              ;22222222222222222222     888888888           000000000           000000000
  1615                          
  1616                          
  1617                          
  1618                          
  1619                          
  1620                          
  1621                          
  1622                          ; ==============================================================================
  1623                          ; LEVEL DATA
  1624                          ; Based on tiles
  1625                          ;                     !IMPORTANT!
  1626                          ;                     has to be page aligned or
  1627                          ;                     display_room routine will fail
  1628                          ; ==============================================================================
  1629                                                *= $2800

; ******** Source: includes/levels.asm
     1                          ; all levels/rooms
     2                          ; based on tiles
     3                          ; one room is 13*8 bytes
     4                          
     5                          
     6                          ; room 00
     7                          room_data_00:
     8  2800 0100000001010100...!byte $01, $00, $00, $00, $01, $01, $01, $00, $0b, $00, $00, $00, $00 
     9  280d 01000b0000000000...!byte $01, $00, $0b, $00, $00, $00, $00, $00, $0c, $01, $01, $01, $00
    10  281a 10000c00000b0000...!byte $10, $00, $0c, $00, $00, $0b, $00, $00, $01, $00, $00, $00, $00
    11  2827 01010101000c0000...!byte $01, $01, $01, $01, $00, $0c, $00, $00, $00, $00, $0b, $00, $01
    12  2834 000000000101000b...!byte $00, $00, $00, $00, $01, $01, $00, $0b, $00, $00, $0c, $00, $01 
    13  2841 01000b000000000c...!byte $01, $00, $0b, $00, $00, $00, $00, $0c, $00, $01, $01, $00, $01 
    14  284e 01000c0001010001...!byte $01, $00, $0c, $00, $01, $01, $00, $01, $00, $00, $00, $00, $10
    15  285b 0101010000000001...!byte $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01
    16                          
    17                          
    18                          ; room 01
    19                          room_data_01:
    20  2868 0000020202020200...!byte $00, $00, $02, $02, $02, $02, $02, $00, $00, $00, $02, $02, $02
    21  2875 1000020000000400...!byte $10, $00, $02, $00, $00, $00, $04, $00, $02, $00, $00, $00, $02
    22  2882 0200000000000000...!byte $02, $00, $00, $00, $00, $00, $00, $00, $02, $00, $04, $00, $02
    23  288f 0200040000020000...!byte $02, $00, $04, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02
    24  289c 0200000000020004...!byte $02, $00, $00, $00, $00, $02, $00, $04, $00, $00, $00, $00, $02
    25  28a9 0200030400000000...!byte $02, $00, $03, $04, $00, $00, $00, $00, $00, $00, $00, $00, $02
    26  28b6 0202000000020200...!byte $02, $02, $00, $00, $00, $02, $02, $00, $04, $00, $02, $00, $10
    27  28c3 0002000002020000...!byte $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $02, $02, $02
    28                          
    29                          
    30                          ; room 02
    31                          room_data_02:
    32  28d0 0001010101020202...!byte $00, $01, $01, $01, $01, $02, $02, $02, $00, $00, $00, $02, $02
    33  28dd 1000010101010000...!byte $10, $00, $01, $01, $01, $01, $00, $00, $00, $02, $00, $00, $00
    34  28ea 0100010101010202...!byte $01, $00, $01, $01, $01, $01, $02, $02, $02, $00, $02, $02, $00
    35  28f7 0100000001010102...!byte $01, $00, $00, $00, $01, $01, $01, $02, $00, $00, $00, $02, $00
    36  2904 0101000000010102...!byte $01, $01, $00, $00, $00, $01, $01, $02, $02, $00, $02, $02, $00
    37  2911 0100000000000101...!byte $01, $00, $00, $00, $00, $00, $01, $01, $02, $00, $02, $00, $00
    38  291e 0100000000000000...!byte $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    39  292b 0100000000010101...!byte $01, $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $00, $10
    40                          
    41                          
    42                          ; room 03
    43                          room_data_03:
    44  2938 0101010000000000...!byte $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $03, $01
    45  2945 1000010000010101...!byte $10, $00, $01, $00, $00, $01, $01, $01, $01, $01, $00, $01, $01
    46  2952 0100010100010000...!byte $01, $00, $01, $01, $00, $01, $00, $00, $00, $01, $00, $00, $01
    47  295f 0100000100010001...!byte $01, $00, $00, $01, $00, $01, $00, $01, $00, $01, $00, $00, $01
    48  296c 0101000100000001...!byte $01, $01, $00, $01, $00, $00, $00, $01, $00, $01, $00, $00, $01
    49  2979 0001000101010101...!byte $00, $01, $00, $01, $01, $01, $01, $01, $00, $01, $00, $00, $10
    50  2986 0001000000000000...!byte $00, $01, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01
    51  2993 0001010101010101...!byte $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00
    52                          
    53                          
    54                          ; room 04
    55                          room_data_04:
    56  29a0 0101010101020002...!byte $01, $01, $01, $01, $01, $02, $00, $02, $01, $01, $01, $01, $01
    57  29ad 0600000101020002...!byte $06, $00, $00, $01, $01, $02, $00, $02, $01, $00, $00, $00, $07
    58  29ba 0101001001020002...!byte $01, $01, $00, $10, $01, $02, $00, $02, $01, $00, $01, $01, $01
    59  29c7 0600000001020000...!byte $06, $00, $00, $00, $01, $02, $00, $00, $00, $00, $00, $00, $07
    60  29d4 0101010001020002...!byte $01, $01, $01, $00, $01, $02, $00, $02, $00, $01, $01, $01, $01
    61  29e1 0600000000000002...!byte $06, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $00, $07
    62  29ee 0101000101020002...!byte $01, $01, $00, $01, $01, $02, $00, $02, $01, $01, $00, $01, $01
    63  29fb 0600000001020002...!byte $06, $00, $00, $00, $01, $02, $00, $02, $01, $10, $00, $00, $07
    64                          
    65                          
    66                          ; room 05
    67                          room_data_05:
    68  2a08 0100000001000000...!byte $01, $00, $00, $00, $01, $00, $00, $00, $00, $0d, $00, $01, $01
    69  2a15 01000d0001000000...!byte $01, $00, $0d, $00, $01, $00, $00, $00, $01, $01, $00, $00, $01
    70  2a22 1000010000000101...!byte $10, $00, $01, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01
    71  2a2f 0100010100000000...!byte $01, $00, $01, $01, $00, $00, $00, $00, $00, $00, $0d, $00, $01
    72  2a3c 0100000000000d00...!byte $01, $00, $00, $00, $00, $00, $0d, $00, $01, $01, $01, $00, $01
    73  2a49 0000010300000101...!byte $00, $00, $01, $03, $00, $00, $01, $01, $00, $00, $00, $00, $00
    74  2a56 0d00000000010100...!byte $0d, $00, $00, $00, $00, $01, $01, $00, $00, $0d, $00, $00, $10
    75  2a63 010101000d000101...!byte $01, $01, $01, $00, $0d, $00, $01, $01, $01, $01, $01, $01, $01
    76                          
    77                          
    78                          ; room 06
    79                          room_data_06:
    80  2a70 0200020000000200...!byte $02, $00, $02, $00, $00, $00, $02, $00, $00, $00, $02, $00, $02
    81  2a7d 1000020001000200...!byte $10, $00, $02, $00, $01, $00, $02, $00, $01, $00, $02, $00, $10
    82  2a8a 0200020002000200...!byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
    83  2a97 0200020002000200...!byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $10
    84  2aa4 0200020002000200...!byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
    85  2ab1 0200020002000200...!byte $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $10
    86  2abe 0200010002000100...!byte $02, $00, $01, $00, $02, $00, $01, $00, $02, $00, $01, $00, $02
    87  2acb 0200000002000000...!byte $02, $00, $00, $00, $02, $00, $00, $00, $02, $00, $00, $00, $10
    88                          
    89                          
    90                          ; room 07
    91                          room_data_07:
    92  2ad8 0000010101010000...!byte $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $00, $00, $0b
    93  2ae5 1000000101000000...!byte $10, $00, $00, $01, $01, $00, $00, $00, $00, $01, $00, $00, $0c
    94  2af2 0100000000000100...!byte $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $01
    95  2aff 010000000b000000...!byte $01, $00, $00, $00, $0b, $00, $00, $00, $05, $00, $0b, $00, $01
    96  2b0c 010100000c000100...!byte $01, $01, $00, $00, $0c, $00, $01, $00, $00, $00, $0c, $00, $01
    97  2b19 0000000000000000...!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01
    98  2b26 0000000101000b00...!byte $00, $00, $00, $01, $01, $00, $0b, $00, $01, $01, $01, $00, $10
    99  2b33 0100000000000c00...!byte $01, $00, $00, $00, $00, $00, $0c, $00, $00, $00, $00, $00, $01
   100                          
   101                          
   102                          ; room 08
   103                          room_data_08:
   104  2b40 0000010101080a09...!byte $00, $00, $01, $01, $01, $08, $0a, $09, $00, $02, $02, $02, $02
   105  2b4d 1000000001080a09...!byte $10, $00, $00, $00, $01, $08, $0a, $09, $00, $00, $02, $02, $02
   106  2b5a 0000000000080a09...!byte $00, $00, $00, $00, $00, $08, $0a, $09, $00, $00, $00, $02, $02
   107  2b67 0000010100080a09...!byte $00, $00, $01, $01, $00, $08, $0a, $09, $00, $00, $00, $00, $02
   108  2b74 0000000100080a09...!byte $00, $00, $00, $01, $00, $08, $0a, $09, $00, $00, $00, $00, $10
   109  2b81 0100000000080a09...!byte $01, $00, $00, $00, $00, $08, $0a, $09, $00, $00, $00, $02, $02
   110  2b8e 0100000000080a09...!byte $01, $00, $00, $00, $00, $08, $0a, $09, $00, $00, $02, $02, $02
   111  2b9b 0001010000080a09...!byte $00, $01, $01, $00, $00, $08, $0a, $09, $00, $02, $02, $02, $02
   112                          
   113                          
   114                          ; room 09
   115                          room_data_09:
   116  2ba8 0002020200000002...!byte $00, $02, $02, $02, $00, $00, $00, $02, $00, $00, $00, $00, $02
   117  2bb5 1000000000000000...!byte $10, $00, $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $02
   118  2bc2 0202020200000002...!byte $02, $02, $02, $02, $00, $00, $00, $02, $02, $00, $02, $00, $02
   119  2bcf 0200000002020200...!byte $02, $00, $00, $00, $02, $02, $02, $00, $00, $00, $02, $00, $02
   120  2bdc 0200020000000200...!byte $02, $00, $02, $00, $00, $00, $02, $00, $02, $00, $00, $00, $02
   121  2be9 0200020202000000...!byte $02, $00, $02, $02, $02, $00, $00, $00, $02, $02, $02, $02, $00
   122  2bf6 0300000002020202...!byte $03, $00, $00, $00, $02, $02, $02, $02, $02, $00, $00, $00, $10
   123  2c03 0202020000000000...!byte $02, $02, $02, $00, $00, $00, $00, $00, $00, $00, $02, $02, $02
   124                          
   125                          
   126                          ; room 10
   127                          room_data_10:
   128  2c10 0202020202020202...!byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
   129  2c1d 0202000002020202...!byte $02, $02, $00, $00, $02, $02, $02, $02, $02, $00, $00, $02, $02
   130  2c2a 0200000000020202...!byte $02, $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $02
   131  2c37 0200000300000000...!byte $02, $00, $00, $03, $00, $00, $00, $00, $00, $00, $00, $00, $02
   132  2c44 1000000000000000...!byte $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $10
   133  2c51 0200000000020202...!byte $02, $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $02
   134  2c5e 0202000002020202...!byte $02, $02, $00, $00, $02, $02, $02, $02, $02, $00, $00, $02, $02
   135  2c6b 0202020202020202...!byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
   136                          
   137                          
   138                          ; room 11
   139                          room_data_11:
   140  2c78 0202020000000b00...!byte $02, $02, $02, $00, $00, $00, $0b, $00, $00, $01, $01, $01, $00
   141  2c85 0202000000000c00...!byte $02, $02, $00, $00, $00, $00, $0c, $00, $01, $00, $00, $00, $01
   142  2c92 0200000b00000000...!byte $02, $00, $00, $0b, $00, $00, $00, $00, $00, $01, $01, $00, $01
   143  2c9f 0200000c000b0000...!byte $02, $00, $00, $0c, $00, $0b, $00, $00, $00, $00, $00, $00, $00
   144  2cac 10000000000c000b...!byte $10, $00, $00, $00, $00, $0c, $00, $0b, $00, $00, $01, $00, $10
   145  2cb9 020000000000000c...!byte $02, $00, $00, $00, $00, $00, $00, $0c, $00, $00, $01, $00, $01
   146  2cc6 020200000b000000...!byte $02, $02, $00, $00, $0b, $00, $00, $00, $00, $01, $00, $01, $00
   147  2cd3 020202000c000001...!byte $02, $02, $02, $00, $0c, $00, $00, $01, $01, $00, $00, $00, $00
   148                          
   149                          
   150                          ; room 12
   151                          room_data_12:
   152  2ce0 0000010101010101...!byte $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00
   153  2ced 0001000000000000...!byte $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
   154  2cfa 0100000d00000000...!byte $01, $00, $00, $0d, $00, $00, $00, $00, $0d, $00, $00, $00, $01
   155  2d07 0100000000001000...!byte $01, $00, $00, $00, $00, $00, $10, $00, $00, $0d, $00, $00, $01
   156  2d14 1000000d00000000...!byte $10, $00, $00, $0d, $00, $00, $00, $00, $00, $00, $00, $03, $01
   157  2d21 010000000d000000...!byte $01, $00, $00, $00, $0d, $00, $00, $00, $0d, $00, $00, $00, $01
   158  2d2e 0001000000000000...!byte $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
   159  2d3b 0000010101010101...!byte $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00
   160                          
   161                          
   162                          ; room 13
   163                          room_data_13:
   164  2d48 0202020200000000...!byte $02, $02, $02, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02
   165  2d55 1000020200020202...!byte $10, $00, $02, $02, $00, $02, $02, $02, $02, $00, $02, $00, $02
   166  2d62 0200000200000000...!byte $02, $00, $00, $02, $00, $00, $00, $00, $02, $00, $02, $00, $10
   167  2d6f 0202000202020200...!byte $02, $02, $00, $02, $02, $02, $02, $00, $02, $00, $02, $00, $02
   168  2d7c 0202000200000000...!byte $02, $02, $00, $02, $00, $00, $00, $00, $02, $00, $02, $00, $02
   169  2d89 0000000200020202...!byte $00, $00, $00, $02, $00, $02, $02, $02, $02, $00, $02, $00, $02
   170  2d96 0002020200020300...!byte $00, $02, $02, $02, $00, $02, $03, $00, $00, $00, $00, $00, $02
   171  2da3 0000000000020202...!byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02
   172                          
   173                          
   174                          ; room 14
   175                          room_data_14:
   176  2db0 020000020a0a0a0a...!byte $02, $00, $00, $02, $0a, $0a, $0a, $0a, $0a, $02, $00, $00, $02
   177  2dbd 10000000020a0a0a...!byte $10, $00, $00, $00, $02, $0a, $0a, $0a, $02, $00, $00, $00, $10
   178  2dca 0200000000020a02...!byte $02, $00, $00, $00, $00, $02, $0a, $02, $00, $00, $00, $00, $02
   179  2dd7 0200000000020a02...!byte $02, $00, $00, $00, $00, $02, $0a, $02, $00, $00, $00, $00, $02
   180  2de4 0a02000000000200...!byte $0a, $02, $00, $00, $00, $00, $02, $00, $00, $00, $00, $02, $0a
   181  2df1 0a02000000000000...!byte $0a, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $0a
   182  2dfe 0a0a020000000000...!byte $0a, $0a, $02, $00, $00, $00, $00, $00, $00, $00, $02, $0a, $0a
   183  2e0b 0a0a0a0202020202...!byte $0a, $0a, $0a, $02, $02, $02, $02, $02, $02, $02, $0a, $0a, $0a
   184                          
   185                          
   186                          ; room 15
   187                          room_data_15:
   188  2e18 0202020202020202...!byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
   189  2e25 0200000202000200...!byte $02, $00, $00, $02, $02, $00, $02, $00, $00, $03, $00, $00, $02
   190  2e32 1000000000000200...!byte $10, $00, $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $02
   191  2e3f 0200020200020202...!byte $02, $00, $02, $02, $00, $02, $02, $02, $02, $00, $02, $02, $02
   192  2e4c 0200000000020202...!byte $02, $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $02
   193  2e59 0202020200020200...!byte $02, $02, $02, $02, $00, $02, $02, $00, $00, $02, $00, $00, $02
   194  2e66 0202020200000000...!byte $02, $02, $02, $02, $00, $00, $00, $00, $02, $02, $00, $00, $10
   195  2e73 0202020203020202...!byte $02, $02, $02, $02, $03, $02, $02, $02, $02, $02, $02, $02, $02
   196                          
   197                          
   198                          ; room 16
   199                          room_data_16:
   200  2e80 0000020202020000...!byte $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00, $02
   201  2e8d 1000000000020000...!byte $10, $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02
   202  2e9a 0202020000020202...!byte $02, $02, $02, $00, $00, $02, $02, $02, $02, $02, $02, $00, $02
   203  2ea7 0000000000000000...!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
   204  2eb4 0202020200000200...!byte $02, $02, $02, $02, $00, $00, $02, $00, $02, $02, $02, $02, $02
   205  2ec1 0000000000000200...!byte $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00
   206  2ece 0000000200000200...!byte $00, $00, $00, $02, $00, $00, $02, $00, $02, $00, $00, $00, $00
   207  2edb 0000000200000200...!byte $00, $00, $00, $02, $00, $00, $02, $00, $02, $00, $00, $00, $00
   208                          
   209                          
   210                          ; room 17
   211                          room_data_17:
   212  2ee8 0202020202020202...!byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
   213  2ef5 1000000000000202...!byte $10, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $00, $00
   214  2f02 0200000000000000...!byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $10
   215  2f0f 0200000200000202...!byte $02, $00, $00, $02, $00, $00, $02, $02, $02, $02, $02, $02, $02
   216  2f1c 0200000200000000...!byte $02, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $02, $02
   217  2f29 0200000000000000...!byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
   218  2f36 0200000000000000...!byte $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
   219  2f43 0202020202020202...!byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
   220                          
   221                          
   222                          ; room 18
   223                          room_data_18:
   224  2f50 0000020000000000...!byte $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02
   225  2f5d 1000020002020202...!byte $10, $00, $02, $00, $02, $02, $02, $02, $02, $02, $02, $00, $02
   226  2f6a 0000020002000000...!byte $00, $00, $02, $00, $02, $00, $00, $00, $00, $00, $02, $00, $02
   227  2f77 0002020002000e0f...!byte $00, $02, $02, $00, $02, $00, $0e, $0f, $00, $00, $02, $00, $02
   228  2f84 0002000002020202...!byte $00, $02, $00, $00, $02, $02, $02, $02, $02, $00, $02, $00, $02
   229  2f91 0002000200000000...!byte $00, $02, $00, $02, $00, $00, $00, $00, $00, $00, $02, $00, $02
   230  2f9e 0002000200020202...!byte $00, $02, $00, $02, $00, $02, $02, $02, $02, $02, $02, $00, $02
   231  2fab 0000000200000000...!byte $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $02
   232                          

; ******** Source: main.asm
  1631                          
  1632  2fb8 00000000000000                           !byte $00, $00, $00, $00, $00, $00, $00
  1633                          
  1634                          ;$2fbf
  1635                          m2FBF:
  1636  2fbf 01                 !byte $01
  1637                          
  1638                          ; $2fc0
  1639                          m2FC0:
  1640  2fc0 a96b                                   lda #$6b
  1641  2fc2 8d9236                                 sta items + $8               ; store 6b = gloves in inventory
  1642  2fc5 a93d                                   lda #$3d
  1643  2fc7 8d9036                                 sta items + $6                      ;sta $3690
  1644  2fca 60                 -                   rts
  1645                          
  1646                          ; ==============================================================================
  1647                          ;
  1648                          ;
  1649                          ; ==============================================================================
  1650                          
  1651  2fcb ad4c30             m2fCB:              lda current_room + 1
  1652  2fce c904                                   cmp #$04
  1653  2fd0 d0f8                                   bne -                   ; bne $2fca
  1654  2fd2 a903                                   lda #$03
  1655  2fd4 ac4b39                                 ldy m394A + 1           ; ldy $394b
  1656  2fd7 f002                                   beq +
  1657  2fd9 a9f6                                   lda #$f6
  1658  2fdb 8df90c             +                   sta SCREENRAM + $f9     ; sta $0cf9
  1659  2fde 60                                     rts
  1660                          
  1661                          ; ==============================================================================
  1662                          ;
  1663                          ;
  1664                          ; ==============================================================================
  1665                          
  1666  2fdf ac2037             m2FDF:              ldy items + $96     ; ldy $3720
  1667  2fe2 c0df                                   cpy #$df
  1668  2fe4 d006                                   bne +               ; bne $2fec
  1669  2fe6 8d9439                                 sta m3993 + 1       ; sta $3994
  1670  2fe9 4ce912                                 jmp m12F4           ; jmp $12f4
  1671  2fec 4c4c3b             +                   jmp m3B4C           ; jmp $3b4c
  1672                          
  1673  2fef 20f439             m2FEF:              jsr m39F4 ; jsr $39f4
  1674  2ff2 4cd015                                 jmp m15D1           ; jmp $15d1
  1675                          
  1676                          
  1677                          
  1678                          
  1679                          
  1680                          ; $2ffd
  1681                          unknown: ; haven't found a call for this code area yet. might be waste
  1682  2ff5 0000000000000000...!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
  1683  3005 0000000000000000...!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
  1684  3015 00                 !byte $00
  1685                          
  1686                          ; ==============================================================================
  1687                          ;
  1688                          ; tileset definition
  1689                          ; these are the first characters in the charset of each tile.
  1690                          ; example: rocks start at $0c and span 9 characters in total
  1691                          ; ==============================================================================
  1692                          ; $301e
  1693                          tileset_definition:
  1694                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  1695  3016 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42
  1696                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  1697  301e 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a
  1698                                              ;     $10
  1699  3026 03                                     !byte $03
  1700                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  1701  3027 0039190e3d7f2a2a                       !byte $00, $39, $19, $0e, $3d, $7f, $2a, $2a
  1702                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  1703  302f 1e1e1e3d3d192f2f                       !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  1704                                              ;     $10
  1705  3037 39                                     !byte $39
  1706                          
  1707                          ; ==============================================================================
  1708                          ;
  1709                          ; displays a room based on tiles
  1710                          ; ==============================================================================
  1711                          
  1712                          display_room:
  1713  3038 20023b                                 jsr draw_border
  1714  303b a900                                   lda #$00
  1715  303d 8502                                   sta zp02
  1716  303f a208                                   ldx #>COLRAM        ; HiByte of COLRAM
  1717  3041 8605                                   stx zp05
  1718  3043 a20c                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  1719  3045 8603                                   stx zp03
  1720  3047 a228                                   ldx #>level_data    ; HiByte of level_data
  1721  3049 860a                                   stx zp0A            ; in zp0A
  1722  304b a201               current_room:       ldx #$01            ; current_room in X
  1723  304d f00a                                   beq ++              ; if 0 -> skip
  1724  304f 18                 -                   clc                 ; else
  1725  3050 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  1726  3052 9002                                   bcc +               ; to zp09/zp0A
  1727  3054 e60a                                   inc zp0A            ;
  1728  3056 ca                 +                   dex                 ; X times
  1729  3057 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  1730  3059 8509               ++                  sta zp09            ; LoByte from above
  1731  305b a000                                   ldy #$00
  1732  305d 84a8                                   sty zpA8
  1733  305f 84a7                                   sty zpA7
  1734  3061 b109               m3066:              lda (zp09),y        ; get Tilenumber
  1735  3063 aa                                     tax                 ; in X
  1736  3064 bd2730                                 lda tiles_colors,x  ; get Tilecolor
  1737  3067 8510                                   sta zp10            ; => zp10
  1738  3069 bd1630                                 lda tiles_chars,x   ; get Tilechar
  1739  306c 8511                                   sta zp11            ; => zp11
  1740  306e a203                                   ldx #$03            ; (3 rows)
  1741  3070 a000               --                  ldy #$00
  1742  3072 a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  1743  3074 8504                                   sta zp04            ; LoByte of COLRAM pointer
  1744  3076 a511                                   lda zp11            ; Load Tilechar
  1745  3078 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  1746  307a a510                                   lda zp10            ; Load Tilecolor
  1747  307c 9104                                   sta (zp04),y        ; to COLRAM + Y
  1748  307e a511                                   lda zp11            ; Load Tilechar again
  1749  3080 c9df                                   cmp #$df            ; if empty tile
  1750  3082 f002                                   beq +               ; -> skip
  1751  3084 e611                                   inc zp11            ; else: Tilechar + 1
  1752  3086 c8                 +                   iny                 ; Y = Y + 1
  1753  3087 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  1754  3089 d0e7                                   bne -               ; no -> next Char
  1755  308b a502                                   lda zp02            ; yes:
  1756  308d 18                                     clc
  1757  308e 6928                                   adc #$28            ; next SCREEN row
  1758  3090 8502                                   sta zp02
  1759  3092 9004                                   bcc +
  1760  3094 e603                                   inc zp03
  1761  3096 e605                                   inc zp05            ; and COLRAM row
  1762  3098 ca                 +                   dex                 ; X = X - 1
  1763  3099 d0d5                                   bne --              ; X != 0 -> next Char
  1764  309b e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  1765  309d e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  1766  309f a975                                   lda #$75            ; for m30B8 + 1
  1767  30a1 a6a8                                   ldx zpA8
  1768  30a3 e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  1769  30a5 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  1770  30a7 a6a7                                   ldx zpA7            ; else:
  1771  30a9 e066                                   cpx #$66            ; zpA7 >= $66
  1772  30ab b01c                                   bcs display_door    ; yes: display_door
  1773  30ad a900                                   lda #$00            ; else:
  1774  30af 85a8                                   sta zpA8            ; clear zpA8
  1775  30b1 a924                                   lda #$24            ; for m30B8 + 1
  1776  30b3 8dba30             +                   sta m30B8 + 1       ;
  1777  30b6 a502                                   lda zp02
  1778  30b8 38                                     sec
  1779  30b9 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  1780  30bb 8502                                   sta zp02
  1781  30bd b004                                   bcs +
  1782  30bf c603                                   dec zp03
  1783  30c1 c605                                   dec zp05
  1784  30c3 a4a7               +                   ldy zpA7
  1785  30c5 4c6130                                 jmp m3066
  1786  30c8 60                                     rts                 ; will this ever be used?
  1787  30c9 a90c               display_door:       lda #>SCREENRAM
  1788  30cb 8503                                   sta zp03
  1789  30cd a908                                   lda #>COLRAM
  1790  30cf 8505                                   sta zp05
  1791  30d1 a900                                   lda #$00
  1792  30d3 8502                                   sta zp02
  1793  30d5 8504                                   sta zp04
  1794  30d7 a028               -                   ldy #$28
  1795  30d9 b102                                   lda (zp02),y        ; read from SCREENRAM
  1796  30db c906                                   cmp #$06            ; $06 (part from Door?)
  1797  30dd b00b                                   bcs +               ; >= $06 -> skip
  1798  30df 38                                     sec                 ; else:
  1799  30e0 e903                                   sbc #$03            ; subtract $03
  1800  30e2 a000                                   ldy #$00            ; set Y = $00
  1801  30e4 9102                                   sta (zp02),y        ; and copy to one row above
  1802  30e6 a939                                   lda #$39            ; color brown - luminance $3
  1803  30e8 9104                                   sta (zp04),y
  1804  30ea a502               +                   lda zp02
  1805  30ec 18                                     clc
  1806  30ed 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  1807  30ef 9004                                   bcc +
  1808  30f1 e603                                   inc zp03            ; inc pointer HiBytes if necessary
  1809  30f3 e605                                   inc zp05
  1810  30f5 8502               +                   sta zp02
  1811  30f7 8504                                   sta zp04
  1812  30f9 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  1813  30fb d0da                                   bne -               ; no -> loop
  1814  30fd a503                                   lda zp03            ; else:
  1815  30ff c90f                                   cmp #>(SCREENRAM+$300)
  1816  3101 d0d4                                   bne -               ; no -> loop
  1817  3103 60                                     rts                 ; else: finally ready with room display
  1818                          ; ==============================================================================
  1819  3104 a90c               print_title:        lda #>SCREENRAM       ; lda #$0c
  1820  3106 8503                                   sta zp03
  1821  3108 a908                                   lda #>COLRAM        ; lda #$08
  1822  310a 8505                                   sta zp05
  1823  310c a900                                   lda #<SCREENRAM       ; lda #$00
  1824  310e 8502                                   sta zp02
  1825  3110 8504                                   sta zp04
  1826  3112 a931                                   lda #>screen_start_src
  1827  3114 85a8                                   sta zpA8
  1828  3116 a93c                                   lda #<screen_start_src
  1829  3118 85a7                                   sta zpA7
  1830  311a a204                                   ldx #$04
  1831  311c a000               --                  ldy #$00
  1832  311e b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  1833  3120 9102                                   sta (zp02),y        ; nach SCREEN
  1834  3122 a900                                   lda #$00           ; BLACK
  1835  3124 9104                                   sta (zp04),y        ; nach COLRAM
  1836  3126 c8                                     iny
  1837  3127 d0f5                                   bne -               ; bne $3127
  1838  3129 e603                                   inc zp03
  1839  312b e605                                   inc zp05
  1840  312d e6a8                                   inc zpA8
  1841  312f ca                                     dex
  1842  3130 d0ea                                   bne --              ; bne $3125
  1843  3132 60                                     rts
  1844                          
  1845                          
  1846                          
  1847                          
  1848                          
  1849                                              ; 333333333333333   555555555555555555  222222222222222    555555555555555555
  1850                                              ;3:::::::::::::::33 5::::::::::::::::5 2:::::::::::::::22  5::::::::::::::::5
  1851                                              ;3::::::33333::::::35::::::::::::::::5 2::::::222222:::::2 5::::::::::::::::5
  1852                                              ;3333333     3:::::35:::::555555555555 2222222     2:::::2 5:::::555555555555
  1853                                              ;            3:::::35:::::5                        2:::::2 5:::::5
  1854                                              ;            3:::::35:::::5                        2:::::2 5:::::5
  1855                                              ;    33333333:::::3 5:::::5555555555            2222::::2  5:::::5555555555
  1856                                              ;    3:::::::::::3  5:::::::::::::::5      22222::::::22   5:::::::::::::::5
  1857                                              ;    33333333:::::3 555555555555:::::5   22::::::::222     555555555555:::::5
  1858                                              ;            3:::::3            5:::::5 2:::::22222                    5:::::5
  1859                                              ;            3:::::3            5:::::52:::::2                         5:::::5
  1860                                              ;            3:::::35555555     5:::::52:::::2             5555555     5:::::5
  1861                                              ;3333333     3:::::35::::::55555::::::52:::::2       2222225::::::55555::::::5
  1862                                              ;3::::::33333::::::3 55:::::::::::::55 2::::::2222222:::::2 55:::::::::::::55
  1863                                              ;3:::::::::::::::33    55:::::::::55   2::::::::::::::::::2   55:::::::::55
  1864                                              ; 333333333333333        555555555     22222222222222222222     555555555
  1865                          
  1866                          
  1867                          
  1868                          
  1869                          
  1870                          ; ==============================================================================
  1871                          ;
  1872                          ;
  1873                          ; ==============================================================================
  1874                          
  1875                                              *= $3525
  1876                          
  1877                          
  1878                          m3534:
  1879  3525 a908                                   lda #>COLRAM        ; lda #$08              ; COULD BE WRONG TO ASSUME
  1880  3527 8505                                   sta zp05
  1881  3529 a90c                                   lda #>SCREENRAM       ; lda #$0c             ; COULD BE WRONG TO ASSUME
  1882  352b 8503                                   sta zp03
  1883  352d a900                                   lda #$00
  1884  352f 8502                                   sta zp02
  1885  3531 8504                                   sta zp04
  1886  3533 ea                                     nop
  1887  3534 ea                                     nop
  1888  3535 ea                                     nop
  1889  3536 ea                                     nop
  1890  3537 c000                                   cpy #$00
  1891  3539 f00c                                   beq +               ; beq $3547
  1892  353b 18                 -                   clc
  1893  353c 6928                                   adc #$28
  1894  353e 9004                                   bcc ++              ; bcc $3544
  1895  3540 e603                                   inc zp03
  1896  3542 e605                                   inc zp05
  1897  3544 88                 ++                  dey
  1898  3545 d0f4                                   bne -               ; bne $353b
  1899  3547 18                 +                   clc
  1900  3548 6915               m3548:              adc #$15
  1901  354a 8502                                   sta zp02
  1902  354c 8504                                   sta zp04
  1903  354e 9004                                   bcc +               ; bcc $3554
  1904  3550 e603                                   inc zp03
  1905  3552 e605                                   inc zp05
  1906  3554 a203               +                   ldx #$03
  1907  3556 a900                                   lda #$00
  1908  3558 8509                                   sta zp09
  1909  355a a000               --                  ldy #$00
  1910  355c a5a7               -                   lda zpA7
  1911  355e d006                                   bne +               ; bne $3566
  1912  3560 a9df                                   lda #$df
  1913  3562 9102                                   sta (zp02),y
  1914  3564 d01b                                   bne ++              ; bne $3581
  1915  3566 c901               +                   cmp #$01
  1916  3568 d00a                                   bne +               ; bne $3574
  1917  356a a5a8                                   lda zpA8
  1918  356c 9102                                   sta (zp02),y
  1919  356e a50a                                   lda zp0A
  1920  3570 9104                                   sta (zp04),y
  1921  3572 d00d                                   bne ++              ; bne $3581
  1922  3574 b102               +                   lda (zp02),y
  1923  3576 8610                                   stx zp10
  1924  3578 a609                                   ldx zp09
  1925  357a 9d3c03                                 sta TAPE_BUFFER + $9,x          ; sta $033c,x                 ; cassette tape buffer
  1926  357d e609                                   inc zp09
  1927  357f a610                                   ldx zp10
  1928  3581 e6a8               ++                  inc zpA8
  1929  3583 c8                                     iny
  1930  3584 c003                                   cpy #$03
  1931  3586 d0d4                                   bne -               ; bne $355c
  1932  3588 a502                                   lda zp02
  1933  358a 18                                     clc
  1934  358b 6928                                   adc #$28
  1935  358d 8502                                   sta zp02
  1936  358f 8504                                   sta zp04
  1937  3591 9004                                   bcc +               ; bcc $3597
  1938  3593 e603                                   inc zp03
  1939  3595 e605                                   inc zp05
  1940  3597 ca                 +                   dex
  1941  3598 d0c0                                   bne --              ; bne $355a
  1942  359a 60                                     rts
  1943                          
  1944                          
  1945                          ; ==============================================================================
  1946                          ; $359b
  1947                          ; JOYSTICK CONTROLS
  1948                          ; ==============================================================================
  1949                          
  1950                          check_joystick:
  1951                                              
  1952  359b a9fd                                   lda #$fd
  1953  359d 8d08ff                                 sta KEYBOARD_LATCH
  1954  35a0 ad08ff                                 lda KEYBOARD_LATCH
  1955  35a3 a009               player_pos_y:       ldy #$09
  1956  35a5 a215               player_pos_x:       ldx #$15
  1957  35a7 4a                                     lsr
  1958  35a8 b005                                   bcs +                   ; bcs $35af
  1959  35aa c000                                   cpy #$00
  1960  35ac f001                                   beq +                   ; beq $35af
  1961  35ae 88                                     dey                                           ; JOYSTICK UP
  1962  35af 4a                 +                   lsr
  1963  35b0 b005                                   bcs +                   ; bcs $35b7
  1964  35b2 c015                                   cpy #$15
  1965  35b4 b001                                   bcs +                   ; bcs $35b7
  1966  35b6 c8                                     iny                                           ; JOYSTICK DOWN
  1967  35b7 4a                 +                   lsr
  1968  35b8 b005                                   bcs +                   ; bcs $35bf
  1969  35ba e000                                   cpx #$00
  1970  35bc f001                                   beq +                   ; beq $35bf
  1971  35be ca                                     dex                                           ; JOYSTICK LEFT
  1972  35bf 4a                 +                   lsr
  1973  35c0 b005                                   bcs +                   ; bcs $35c7
  1974  35c2 e024                                   cpx #$24
  1975  35c4 b001                                   bcs +                   ; bcs $35c7
  1976  35c6 e8                                     inx                                           ; JOYSTICK RIGHT
  1977  35c7 8ce835             +                   sty m35E7 + 1           ; sty $35e8
  1978  35ca 8eed35                                 stx m35EC + 1           ; stx $35ed
  1979  35cd 8e4935                                 stx m3548 + 1           ; stx $3549
  1980  35d0 a902                                   lda #$02
  1981  35d2 85a7                                   sta zpA7
  1982  35d4 202535                                 jsr m3534           ; jsr $3534
  1983  35d7 a209                                   ldx #$09
  1984  35d9 bd3b03             -                   lda TAPE_BUFFER + $8,x      ; lda $033b,x
  1985  35dc c9df                                   cmp #$df
  1986  35de f004                                   beq +                   ; beq $35e4
  1987  35e0 c9e2                                   cmp #$e2
  1988  35e2 d00d                                   bne ++                  ; bne $35f1
  1989  35e4 ca                 +                   dex
  1990  35e5 d0f2                                   bne -                   ; bne $35d9
  1991  35e7 a90a               m35E7:              lda #$0a
  1992  35e9 8da435                                 sta player_pos_y + 1
  1993  35ec a915               m35EC:              lda #$15
  1994  35ee 8da635                                 sta player_pos_x + 1
  1995  35f1 a9ff               ++                  lda #$ff
  1996  35f3 8d08ff                                 sta KEYBOARD_LATCH
  1997  35f6 a901                                   lda #$01
  1998  35f8 85a7                                   sta zpA7
  1999  35fa a993                                   lda #$93                ; first character of the player graphic
  2000  35fc 85a8                                   sta zpA8
  2001  35fe a93d                                   lda #$3d
  2002  3600 850a                                   sta zp0A
  2003  3602 aca435             m3602:              ldy player_pos_y + 1
  2004  3605 aea635                                 ldx player_pos_x + 1
  2005  3608 8e4935             m3608:              stx m3548 + 1           ; stx $3549
  2006  360b 4c2535                                 jmp m3534           ; jmp $3534
  2007                          
  2008                          ; ==============================================================================
  2009                          ;
  2010                          ; JOYSTICK INTERRUPT?
  2011                          ; ==============================================================================
  2012                          
  2013                          m360E:
  2014  360e 78                                     sei
  2015  360f a9c0                                   lda #$c0
  2016  3611 cd1dff             -                   cmp $ff1d           ; vertical line bits 0-7
  2017  3614 d0fb                                   bne -               ; bne $3611
  2018  3616 a900                                   lda #$00
  2019  3618 85a7                                   sta zpA7
  2020  361a 4c6d3a             -                   jmp m3A6D
  2021  361d d0fb                                   bne -               ; bne $361a
  2022  361f 60                                     rts
  2023                          
  2024                          ; ==============================================================================
  2025                          ;
  2026                          ;
  2027                          ; ==============================================================================
  2028                          m3620:
  2029  3620 a900                                   lda #$00
  2030  3622 85a7                                   sta zpA7
  2031  3624 a20f               m3624:              ldx #$0f
  2032  3626 a00f               m3626:              ldy #$0f
  2033  3628 200836                                 jsr m3608
  2034  362b ea                                     nop
  2035  362c ae2536                                 ldx m3624 + 1            ; ldx $3625
  2036  362f ac2736                                 ldy m3626 + 1            ; ldy $3627
  2037  3632 eca635                                 cpx player_pos_x + 1
  2038  3635 b002                                   bcs +                   ; bcs $3639
  2039  3637 e8                                     inx
  2040  3638 e8                                     inx
  2041  3639 eca635             +                   cpx player_pos_x + 1
  2042  363c f001                                   beq +                   ; beq $363f
  2043  363e ca                                     dex
  2044  363f cca435             +                   cpy player_pos_y + 1
  2045  3642 b002                                   bcs +                   ; bcs $3646
  2046  3644 c8                                     iny
  2047  3645 c8                                     iny
  2048  3646 cca435             +                   cpy player_pos_y + 1
  2049  3649 f001                                   beq +               ; beq $364c
  2050  364b 88                                     dey
  2051  364c 8e6936             +                   stx m3668 + 1       ; stx $3669
  2052  364f 8e4935                                 stx m3548 + 1       ; stx $3549
  2053  3652 8c6e36                                 sty m366D + 1       ; sty $366e
  2054  3655 a902                                   lda #$02
  2055  3657 85a7                                   sta zpA7
  2056  3659 202535                                 jsr m3534           ; jsr $3534
  2057  365c a209                                   ldx #$09
  2058  365e bd3b03             -                   lda TAPE_BUFFER + $8,x  ; lda $033b,x
  2059  3661 c992                                   cmp #$92
  2060  3663 900d                                   bcc +               ; bcc $3672
  2061  3665 ca                                     dex
  2062  3666 d0f6                                   bne -               ; bne $365e
  2063  3668 a210               m3668:              ldx #$10
  2064  366a 8e2536                                 stx m3624 + 1       ; stx $3625
  2065  366d a00e               m366D:              ldy #$0e
  2066  366f 8c2736                                 sty m3626 + 1       ; sty $3627
  2067  3672 a99c               +                   lda #$9c
  2068  3674 85a8                                   sta zpA8
  2069  3676 a93e                                   lda #$3e
  2070  3678 850a                                   sta zp0A
  2071  367a ac2736                                 ldy m3626 + 1       ; ldy $3627
  2072  367d ae2536                                 ldx m3624 + 1       ; ldx $3625
  2073  3680 8e4935                                 stx m3548 + 1           ; stx $3549
  2074  3683 a901                                   lda #$01
  2075  3685 85a7                                   sta zpA7
  2076  3687 4c2535                                 jmp m3534           ; jmp $3534
  2077                          
  2078                          
  2079                          ; $368a
  2080                          ; ==============================================================================
  2081                          ; items
  2082                          ; This area seems to be responsible for items placement
  2083                          ;
  2084                          ; ==============================================================================

; ******** Source: includes/items.asm
     1                          
     2                          
     3                          ; ==============================================================================
     4                          ; Items in the rooms are stored here
     5                          ; $368a
     6                          ; ==============================================================================
     7                          
     8                          items: 
     9                          
    10  368a ff00fefd29fb79fa...!byte $ff ,$00 ,$fe ,$fd ,$29 ,$fb ,$79 ,$fa ,$a9 ,$ff ,$01 ,$fd ,$bf ,$fb ,$49 ,$fa
    11  369a e0f9fcfefdf6fb3d...!byte $e0 ,$f9 ,$fc ,$fe ,$fd ,$f6 ,$fb ,$3d ,$fa ,$ac ,$f9 ,$fc ,$fe ,$fd ,$1e ,$fc
    12  36aa f9fcff02fb5ffdb3...!byte $f9 ,$fc ,$ff ,$02 ,$fb ,$5f ,$fd ,$b3 ,$fa ,$b8 ,$f9 ,$fc ,$fd ,$db ,$fc ,$f9
    13  36ba fcfdd3fefefb49fa...!byte $fc ,$fd ,$d3 ,$fe ,$fe ,$fb ,$49 ,$fa ,$a5 ,$f9 ,$f8 ,$f9 ,$f8 ,$f9 ,$fc ,$f9
    14  36ca faa8fdfffaa7fefd...!byte $fa ,$a8 ,$fd ,$ff ,$fa ,$a7 ,$fe ,$fd ,$27 ,$f8 ,$fd ,$24 ,$fa ,$b0 ,$f9 ,$fc
    15  36da fd4cfcf9fcfd74fa...!byte $fd ,$4c ,$fc ,$f9 ,$fc ,$fd ,$74 ,$fa ,$b5 ,$fc ,$f9 ,$fc ,$fd ,$27 ,$fa ,$a7
    16  36ea fd4ff8fd77f8fd9f...!byte $fd ,$4f ,$f8 ,$fd ,$77 ,$f8 ,$fd ,$9f ,$f8 ,$ff ,$90 ,$ff ,$07 ,$fe ,$fe ,$fd
    17  36fa d1fb00fa5ef9fcfd...!byte $d1 ,$fb ,$00 ,$fa ,$5e ,$f9 ,$fc ,$fd ,$f9 ,$fc ,$f9 ,$fc ,$ff ,$08 ,$fe ,$fd
    18  370a 33fb4cfac6f9fcf9...!byte $33 ,$fb ,$4c ,$fa ,$c6 ,$f9 ,$fc ,$f9 ,$fc ,$fd ,$5b ,$fc ,$f9 ,$fc ,$f9 ,$fc
    19  371a fefdacfb3ffac0f9...!byte $fe ,$fd ,$ac ,$fb ,$3f ,$fa ,$c0 ,$f9 ,$fc ,$fd ,$d4 ,$fc ,$f9 ,$fc ,$fd ,$fc
    20  372a fcf9fcff0afefefd...!byte $fc ,$f9 ,$fc ,$ff ,$0a ,$fe ,$fe ,$fd ,$9c ,$fb ,$29 ,$fa ,$cc ,$f9 ,$fc ,$fd
    21  373a c4fcf9fcff0bfd94...!byte $c4 ,$fc ,$f9 ,$fc ,$ff ,$0b ,$fd ,$94 ,$fb ,$39 ,$fa ,$d0 ,$fd ,$bc ,$fc ,$ff
    22  374a 0cfefefd15fb39fa...!byte $0c ,$fe ,$fe ,$fd ,$15 ,$fb ,$39 ,$fa ,$d2 ,$f9 ,$fc ,$fd ,$3d ,$fc ,$f9 ,$fc
    23  375a ff0dfbfffad6fdae...!byte $ff ,$0d ,$fb ,$ff ,$fa ,$d6 ,$fd ,$ae ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$11 ,$f8 ,$fd
    24  376a 65f8fd40f8fd69f8...!byte $65 ,$f8 ,$fd ,$40 ,$f8 ,$fd ,$69 ,$f8 ,$fe ,$fd ,$44 ,$f8 ,$fd ,$98 ,$f8 ,$fd
    25  377a f4f8fd7ef8fd51f8...!byte $f4 ,$f8 ,$fd ,$7e ,$f8 ,$fd ,$51 ,$f8 ,$fd ,$0c ,$f8 ,$fd ,$83 ,$f8 ,$fe ,$fd
    26  378a 0ff8fd86f8fd82f8...!byte $0f ,$f8 ,$fd ,$86 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$f8 ,$f8 ,$fd ,$b4 ,$f8 ,$fd ,$15
    27  379a f8fd40f8fd25f8fd...!byte $f8 ,$fd ,$40 ,$f8 ,$fd ,$25 ,$f8 ,$fd ,$9b ,$f8 ,$fe ,$fd ,$71 ,$f8 ,$fd ,$4d
    28  37aa f8fd79f8fda6f8ff...!byte $f8 ,$fd ,$79 ,$f8 ,$fd ,$a6 ,$f8 ,$ff ,$0e ,$fd ,$f6 ,$fb ,$00 ,$fa ,$d7 ,$f8
    29  37ba fd82f8fefd5ff8fd...!byte $fd ,$82 ,$f8 ,$fe ,$fd ,$5f ,$f8 ,$fd ,$84 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$e6 ,$f8
    30  37ca fd71f8fd73f8fd1f...!byte $fd ,$71 ,$f8 ,$fd ,$73 ,$f8 ,$fd ,$1f ,$f8 ,$fd ,$1c ,$f8 ,$fe ,$fd ,$24 ,$f8
    31  37da fd27f8fd50f8fd48...!byte $fd ,$27 ,$f8 ,$fd ,$50 ,$f8 ,$fd ,$48 ,$f8 ,$fd ,$c4 ,$f8 ,$fd ,$c0 ,$f8 ,$fd
    32  37ea 94f8fde0f8fd64f8...!byte $94 ,$f8 ,$fd ,$e0 ,$f8 ,$fd ,$64 ,$f8 ,$fd ,$3f ,$f8 ,$fd ,$13 ,$f8 ,$fe ,$fd
    33  37fa 15f8fd34f8fd04f8...!byte $15 ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$04 ,$f8 ,$ff ,$10 ,$fd ,$63 ,$fb ,$5f ,$fa ,$b8
    34  380a f9fcfd8bfcf8f9fc...!byte $f9 ,$fc ,$fd ,$8b ,$fc ,$f8 ,$f9 ,$fc ,$fe ,$fe ,$fb ,$39 ,$fd ,$fb ,$fa ,$f4
    35  381a fdf2fb39fad9f9fc...!byte $fd ,$f2 ,$fb ,$39 ,$fa ,$d9 ,$f9 ,$fc ,$fd ,$1a ,$fe ,$fc ,$f9 ,$fc ,$ff ,$11
    36  382a fefefdc3fb39fadd...!byte $fe ,$fe ,$fd ,$c3 ,$fb ,$39 ,$fa ,$dd ,$fd ,$eb ,$fc ,$ff ,$ff ,$ff ,$ff ,$ff
    37                                          

; ******** Source: main.asm
  2086                          
  2087                          next_item:
  2088  383a a5a7                                   lda zpA7
  2089  383c 18                                     clc
  2090  383d 6901                                   adc #$01
  2091  383f 85a7                                   sta zpA7
  2092  3841 9002                                   bcc +                       ; bcc $3845
  2093  3843 e6a8                                   inc zpA8
  2094  3845 60                 +                   rts
  2095                          
  2096                          ; ==============================================================================
  2097                          ; TODO
  2098                          ; no clue yet. level data has already been drawn when this is called
  2099                          ; probably placing the items on the screen
  2100                          ; ==============================================================================
  2101                          
  2102                          m3846:
  2103  3846 a936                                   lda #>items                ; items
  2104  3848 85a8                                   sta zpA8
  2105  384a a98a                                   lda #<items
  2106  384c 85a7                                   sta zpA7
  2107  384e a000                                   ldy #$00
  2108  3850 b1a7               m3850:              lda (zpA7),y
  2109  3852 c9ff                                   cmp #$ff
  2110  3854 f006                                   beq +                       ; beq $385c
  2111  3856 203a38             -                   jsr next_item
  2112  3859 4c5038                                 jmp m3850
  2113  385c 203a38             +                   jsr next_item
  2114  385f b1a7                                   lda (zpA7),y
  2115  3861 c9ff                                   cmp #$ff
  2116  3863 f07a                                   beq m38DF               ; beq $38df
  2117  3865 cd4c30                                 cmp current_room + 1
  2118  3868 d0ec                                   bne -                   ; bne $3856
  2119  386a a908                                   lda #>COLRAM        ; lda #$08
  2120  386c 8505                                   sta zp05
  2121  386e a90c                                   lda #>SCREENRAM       ; lda #$0c
  2122  3870 8503                                   sta zp03
  2123  3872 a900                                   lda #$00
  2124  3874 8502                                   sta zp02
  2125  3876 8504                                   sta zp04
  2126  3878 203a38                                 jsr next_item
  2127  387b b1a7                                   lda (zpA7),y
  2128  387d c9fe               -                   cmp #$fe
  2129  387f f00b                                   beq +                   ; beq $388c
  2130  3881 c9f9                                   cmp #$f9
  2131  3883 d00d                                   bne +++                  ; bne $3892
  2132  3885 a502                                   lda zp02
  2133  3887 20d738                                 jsr m38D7
  2134  388a 9004                                   bcc ++                   ; bcc $3890
  2135  388c e603               +                   inc zp03
  2136  388e e605                                   inc zp05
  2137  3890 b1a7               ++                  lda (zpA7),y
  2138  3892 c9fb               +++                 cmp #$fb
  2139  3894 d009                                   bne +                   ; bne $389f
  2140  3896 203a38                                 jsr next_item
  2141  3899 b1a7                                   lda (zpA7),y
  2142  389b 8509                                   sta zp09
  2143  389d d020                                   bne ++                  ; bne $38bf
  2144  389f c9f8               +                   cmp #$f8
  2145  38a1 f014                                   beq +                   ; beq $38b7
  2146  38a3 c9fc                                   cmp #$fc
  2147  38a5 d005                                   bne +++                 ; bne $38ac
  2148  38a7 a50a                                   lda zp0A
  2149  38a9 4c9f39                                 jmp m399F
  2150  38ac c9fa               +++                 cmp #$fa
  2151  38ae d00f                                   bne ++                  ; bne $38bf
  2152  38b0 203a38                                 jsr next_item
  2153  38b3 b1a7                                   lda (zpA7),y
  2154  38b5 850a                                   sta zp0A
  2155                          m38B7:
  2156  38b7 a509               +                   lda zp09
  2157  38b9 9104                                   sta (zp04),y
  2158  38bb a50a                                   lda zp0A
  2159  38bd 9102                                   sta (zp02),y
  2160  38bf c9fd               ++                  cmp #$fd
  2161  38c1 d009                                   bne +                   ; bne $38cc
  2162  38c3 203a38                                 jsr next_item
  2163  38c6 b1a7                                   lda (zpA7),y
  2164  38c8 8502                                   sta zp02
  2165  38ca 8504                                   sta zp04
  2166  38cc 203a38             +                   jsr next_item
  2167  38cf b1a7                                   lda (zpA7),y
  2168  38d1 c9ff                                   cmp #$ff
  2169  38d3 d0a8                                   bne -                   ; bne $387d
  2170  38d5 f008                                   beq m38DF               ; beq $38df
  2171  38d7 18                 m38D7:              clc
  2172  38d8 6901                                   adc #$01
  2173  38da 8502                                   sta zp02
  2174  38dc 8504                                   sta zp04
  2175  38de 60                                     rts
  2176                          
  2177                          ; ==============================================================================
  2178                          ;
  2179                          ;
  2180                          ; ==============================================================================
  2181                          
  2182  38df ad4c30             m38DF:              lda current_room + 1
  2183  38e2 c902                                   cmp #$02
  2184  38e4 d033                                   bne m3919           ; bne $3919
  2185  38e6 a90d                                   lda #$0d
  2186  38e8 8502                                   sta zp02
  2187  38ea 8504                                   sta zp04
  2188  38ec a908                                   lda #>COLRAM        ; lda #$08
  2189  38ee 8505                                   sta zp05
  2190  38f0 a90c                                   lda #>SCREENRAM       ; lda #$0c
  2191  38f2 8503                                   sta zp03
  2192  38f4 a218                                   ldx #$18
  2193  38f6 b102               -                   lda (zp02),y
  2194  38f8 c9df                                   cmp #$df
  2195  38fa f004                                   beq m3900               ; beq $3900
  2196  38fc c9f5                                   cmp #$f5
  2197  38fe d006                                   bne ++              ; bne $3906
  2198  3900 a9f5               m3900:              lda #$f5
  2199  3902 9102                                   sta (zp02),y
  2200  3904 9104                                   sta (zp04),y
  2201  3906 a502               ++                  lda zp02
  2202  3908 18                                     clc
  2203  3909 6928                                   adc #$28
  2204  390b 8502                                   sta zp02
  2205  390d 8504                                   sta zp04
  2206  390f 9004                                   bcc +               ; bcc $3915
  2207  3911 e603                                   inc zp03
  2208  3913 e605                                   inc zp05
  2209  3915 ca                 +                   dex
  2210  3916 d0de                                   bne -               ; bne $38f6
  2211  3918 60                                     rts
  2212                          
  2213                          ; ==============================================================================
  2214                          ;
  2215                          ;
  2216                          ; ==============================================================================
  2217                          
  2218                          m3919:
  2219  3919 c907                                   cmp #$07
  2220  391b d012                                   bne m392F       ; bne $392f
  2221  391d a217                                   ldx #$17
  2222  391f bd680d             -                   lda SCREENRAM + $168,x     ; lda $0d68,x
  2223  3922 c9df                                   cmp #$df
  2224  3924 d005                                   bne +                       ; bne $392b
  2225  3926 a9e3                                   lda #$e3
  2226  3928 9d680d                                 sta SCREENRAM + $168,x     ; sta $0d68,x
  2227  392b ca                 +                   dex
  2228  392c d0f1                                   bne -                       ; bne $391f
  2229  392e 60                                     rts
  2230                          
  2231                          
  2232                          ; ==============================================================================
  2233                          ;
  2234                          ;
  2235                          ; ==============================================================================
  2236                          m392F:
  2237  392f c906                                   cmp #$06
  2238  3931 d00f                                   bne +
  2239  3933 a9f6                                   lda #$f6
  2240  3935 8d9c0c                                 sta SCREENRAM + $9c        ; sta $0c9c
  2241  3938 8d9c0c                                 sta SCREENRAM + $9c        ;sta $0c9c    (yes, it's really 2 times the same sta)
  2242  393b 8d7c0e                                 sta SCREENRAM + $27c       ; sta $0e7c
  2243  393e 8d6c0f                                 sta SCREENRAM + $36c       ; sta $0f6c
  2244  3941 60                                     rts
  2245                          
  2246                          ; ==============================================================================
  2247                          ;
  2248                          ;
  2249                          ; ==============================================================================
  2250                          
  2251  3942 c904               +                   cmp #$04
  2252  3944 d047                                   bne ++
  2253  3946 a2f7                                   ldx #$f7
  2254  3948 a0f8                                   ldy #$f8
  2255  394a a901               m394A:              lda #$01
  2256  394c d004                                   bne m3952           ; bne $3952
  2257  394e a23b                                   ldx #$3b
  2258  3950 a042                                   ldy #$42
  2259  3952 a901               m3952:              lda #$01        ; there seems to happen some self mod here
  2260  3954 c901                                   cmp #$01
  2261  3956 d003                                   bne +           ; bne $395b
  2262  3958 8e7a0c                                 stx SCREENRAM+ $7a ; stx $0c7a
  2263  395b c902               +                   cmp #$02
  2264  395d d003                                   bne +           ; bne $3962
  2265  395f 8e6a0d                                 stx SCREENRAM + $16a   ;stx $0d6a
  2266  3962 c903               +                   cmp #$03
  2267  3964 d003                                   bne +           ; bne $3969
  2268  3966 8e5a0e                                 stx SCREENRAM + $25a       ;stx $0e5a
  2269  3969 c904               +                   cmp #$04
  2270  396b d003                                   bne +           ; bne $3970
  2271  396d 8e4a0f                                 stx SCREENRAM + $34a   ; stx $0f4a
  2272  3970 c905               +                   cmp #$05
  2273  3972 d003                                   bne +           ; bne $3977
  2274  3974 8c9c0c                                 sty SCREENRAM + $9c    ; sty $0c9c
  2275  3977 c906               +                   cmp #$06
  2276  3979 d003                                   bne +           ; bne $397e
  2277  397b 8c8c0d                                 sty SCREENRAM + $18c   ; sty $0d8c
  2278  397e c907               +                   cmp #$07
  2279  3980 d003                                   bne +           ; bne $3985
  2280  3982 8c7c0e                                 sty SCREENRAM + $27c ; sty $0e7c
  2281  3985 c908               +                   cmp #$08
  2282  3987 d003                                   bne +           ; bne $398c
  2283  3989 8c6c0f                                 sty SCREENRAM + $36c   ; sty $0f6c
  2284  398c 60                 +                   rts
  2285                          
  2286                          ; ==============================================================================
  2287                          ;
  2288                          ;
  2289                          ; ==============================================================================
  2290                          
  2291  398d c905               ++                  cmp #$05
  2292  398f d00c                                   bne m399D          ; todo: understand why it jumps to an RTS
  2293  3991 a9fd                                   lda #$fd
  2294  3993 a201               m3993:              ldx #$01
  2295  3995 d002                                   bne +               ; bne $3999
  2296  3997 a97a                                   lda #$7a
  2297  3999 8dd20e             +                   sta SCREENRAM + $2d2   ;sta $0ed2
  2298  399c 60                                     rts
  2299                          
  2300                          ; ==============================================================================
  2301                          ;
  2302                          ;
  2303                          ; ==============================================================================
  2304                          
  2305                          m399D:
  2306  399d 60                                     rts
  2307                          
  2308  399e ff                 !byte $ff
  2309                          
  2310                          m399F:
  2311  399f c9df                                   cmp #$df
  2312  39a1 f002                                   beq +               ; beq $39a5
  2313  39a3 e60a                                   inc zp0A            ; inc $0a
  2314  39a5 b1a7               +                   lda (zpA7),y        ; lda ($a7),y
  2315  39a7 4cb738                                 jmp m38B7           ; jmp $38b7
  2316                          
  2317                          ; ==============================================================================
  2318                          ; Kein Schrott, wird in m3A17 eingelesen
  2319                          ; $39aa
  2320                          ; ==============================================================================
  2321                          m39AA:
  2322  39aa 0603122103031221...!byte $06, $03, $12, $21, $03, $03, $12, $21, $03, $03, $15, $21, $03, $03, $0f, $21
  2323  39ba 151e060606031221...!byte $15, $1e, $06, $06, $06, $03, $12, $21, $03, $03, $09, $21, $03, $03, $12, $21
  2324  39ca 03030c2103031221...!byte $03, $03, $0c, $21, $03, $03, $12, $21, $0c, $03, $0c, $20, $0c, $03, $0c, $21
  2325  39da 0c03091503030621...!byte $0c, $03, $09, $15, $03, $03, $06, $21, $03, $03, $03, $21, $06, $03, $12, $21
  2326  39ea 0303031d03030621...!byte $03, $03, $03, $1d, $03, $03, $06, $21, $03, $03
  2327                          
  2328                          ; $39F4
  2329                          
  2330                          m39F4:
  2331  39f4 200e36                                 jsr m360E           ; jsr $360e
  2332  39f7 a209                                   ldx #$09
  2333  39f9 bd3b03             -                   lda TAPE_BUFFER + $8,x  ; lda $033b,x
  2334  39fc c905                                   cmp #$05
  2335  39fe f008                                   beq m3A08           ; beq $3a08
  2336  3a00 c903                                   cmp #$03
  2337  3a02 f013                                   beq m3A17           ; beq $3a17
  2338  3a04 ca                                     dex
  2339  3a05 d0f2                                   bne -               ; bne $39f9
  2340  3a07 60                 -                   rts
  2341                          
  2342                          ; ==============================================================================
  2343                          ;
  2344                          ;
  2345                          ; ==============================================================================
  2346                          
  2347  3a08 ae4c30             m3A08:              ldx current_room + 1
  2348  3a0b f0fa                                   beq -               ;beq $3a07
  2349  3a0d ca                                     dex
  2350  3a0e 4c643a                                 jmp m3A64           ; jmp $3a64
  2351                          
  2352  3a11 3438323802ff       !byte $34, $38, $32, $38, $02, $ff
  2353                          
  2354                          m3A17:
  2355  3a17 ae4c30                                 ldx current_room + 1
  2356  3a1a e8                                     inx
  2357  3a1b 8e4c30                                 stx current_room + 1
  2358  3a1e bc4a3a                                 ldy m3A33 + $17, x         ; ldy $3a4a,x
  2359  3a21 b9aa39             m3A21:              lda m39AA,y                ; lda $39aa,y
  2360  3a24 8da435                                 sta player_pos_y + 1
  2361  3a27 b9ab39                                 lda m39AA + 1,y            ; lda $39ab,y
  2362  3a2a 8da635                                 sta player_pos_x + 1
  2363  3a2d 203830             m3A2D:              jsr display_room           ; jsr $3040
  2364  3a30 4c4638                                 jmp m3846
  2365                          
  2366                          
  2367                          
  2368                          ; ==============================================================================
  2369                          ; $3a33
  2370                          ; Kein Schrott
  2371                          ; ==============================================================================
  2372                          
  2373                          m3A33:
  2374  3a33 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  2375  3a43 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  2376  3a53 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  2377  3a63 00                 !byte $00
  2378                          
  2379                          m3A64:
  2380  3a64 8e4c30                                 stx current_room + 1                           ; stx $3051
  2381  3a67 bc333a                                 ldy m3A33,x                             ; ldy $3A33,x
  2382  3a6a 4c213a                                 jmp m3A21                               ; jmp $3A21
  2383                          m3A6D:
  2384                          
  2385  3a6d 200236                                 jsr m3602
  2386  3a70 209b35                                 jsr check_joystick
  2387  3a73 58                                     cli
  2388  3a74 60                                     rts
  2389  3a75 00                                     brk             ; $00
  2390                          
  2391                          ; ==============================================================================
  2392                          ;
  2393                          ; wait routine
  2394                          ; usually called with Y set before
  2395                          ; ==============================================================================
  2396                          
  2397                          wait:
  2398  3a76 ca                                     dex
  2399  3a77 d0fd                                   bne wait
  2400  3a79 88                                     dey
  2401  3a7a d0fa                                   bne wait
  2402  3a7c 60                 fake:               rts
  2403                          
  2404                          ; ==============================================================================
  2405                          ; sets the game screen
  2406                          ; multicolor, charset, main colors
  2407                          ; ==============================================================================
  2408                          
  2409                          set_game_basics:
  2410  3a7d ad12ff                                 lda VOICE1           ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  2411  3a80 29fb                                   and #$fb           ; clear bit 2
  2412  3a82 8d12ff                                 sta VOICE1          ; => get data from RAM
  2413  3a85 a921                                   lda #$21
  2414  3a87 8d13ff                                 sta CHAR_BASE_ADDRESS   ; sta $ff13          ; bit 0 : Status of Clock   ( 1 )
  2415                                                                  ; bit 1 : Single clock set  ( 0 )
  2416                                                                  ; b.2-7 : character data base address
  2417                                                                  ;         %00100$x ($2000)
  2418  3a8a ad07ff                                 lda $ff07
  2419  3a8d 0990                                   ora #$90           ; multicolor ON - reverse OFF
  2420  3a8f 8d07ff                                 sta $ff07
  2421                          
  2422                                              ; set the main colors for the game
  2423                          
  2424                          
  2425  3a92 a9db                                   lda #MULTICOLOR_1            ; original: #$db
  2426  3a94 8d16ff                                 sta COLOR_1           ; char color 1
  2427  3a97 a929                                   lda #MULTICOLOR_2            ; original: #$29
  2428  3a99 8d17ff                                 sta COLOR_2           ; char color 2
  2429                          
  2430  3a9c 60                                     rts
  2431                          
  2432                          ; ==============================================================================
  2433                          ; set font and screen setup (40 columns and hires)
  2434                          ; $3a9d
  2435                          ; ==============================================================================
  2436                          
  2437                          set_charset_and_screen_for_title:    ; set text screen
  2438                          
  2439  3a9d ad12ff                                 lda VOICE1
  2440  3aa0 0904                                   ora #$04           ; set bit 2
  2441  3aa2 8d12ff                                 sta VOICE1          ; => get data from ROM
  2442  3aa5 a9d5                                   lda #$d5           ; ROM FONT
  2443  3aa7 8d13ff                                 sta CHAR_BASE_ADDRESS   ; sta $ff13          ; set
  2444  3aaa ad07ff                                 lda $ff07
  2445  3aad a908                                   lda #$08           ; 40 columns and Multicolor OFF
  2446  3aaf 8d07ff                                 sta $ff07
  2447  3ab2 60                                     rts
  2448                          
  2449                          
  2450                          ; ==============================================================================
  2451                          ; init
  2452                          ; start of game
  2453                          ; ==============================================================================
  2454                          
  2455                          init:
  2456  3ab3 20f51e                                 jsr m1F15           ; jsr $1f15
  2457  3ab6 a901                                   lda #$01
  2458  3ab8 8d15ff                                 sta BG_COLOR          ; background color
  2459  3abb 8d19ff                                 sta BORDER_COLOR          ; border color
  2460  3abe 20b816                                 jsr m16BA           ; might be a level data reset, and print the title screen
  2461  3ac1 a020                                   ldy #$20
  2462  3ac3 20763a                                 jsr wait
  2463                          
  2464                                              ; waiting for key press on title screen
  2465                          
  2466  3ac6 a9fd                                   lda #TITLE_KEY_MATRIX    ;#$7f           ; read row 7 of keyboard matrix (http://plus4world.powweb.com/plus4encyclopedia/500012)
  2467  3ac8 8d08ff             -                   sta KEYBOARD_LATCH          ; Latch register for keyboard
  2468  3acb ad08ff                                 lda KEYBOARD_LATCH
  2469  3ace 2901                                   and #TITLE_KEY    ;#$10            ; $10 = space
  2470  3ad0 d0f6                                   bne -               ; bne $3ac8 / wait for keypress ?
  2471                          
  2472  3ad2 a9ff                                   lda #$ff
  2473  3ad4 20ef1c                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  2474                          
  2475                          
  2476                                              ; TODO: unclear what the code below does
  2477                                              ; i think it fills the level data with "DF", which is a blank character
  2478  3ad7 a90c                                   lda #>SCREENRAM       ; lda #$0c
  2479  3ad9 8503                                   sta zp03
  2480  3adb a900                                   lda #$00
  2481  3add 8502                                   sta zp02
  2482  3adf a204                                   ldx #$04
  2483  3ae1 a000                                   ldy #$00
  2484  3ae3 a9df                                   lda #$df
  2485  3ae5 9102               -                   sta (zp02),y
  2486  3ae7 c8                                     iny
  2487  3ae8 d0fb                                   bne -               ; bne $3ae5
  2488  3aea e603                                   inc zp03
  2489  3aec ca                                     dex
  2490  3aed d0f6                                   bne -               ; bne $3ae5
  2491                          
  2492  3aef 207d3a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  2493                          
  2494                                              ; set background color
  2495  3af2 a900                                   lda #$00
  2496  3af4 8d15ff                                 sta BG_COLOR
  2497                          
  2498                                              ; border color. default is a dark red
  2499  3af7 a912                                   lda #BORDER_COLOR_VALUE
  2500  3af9 8d19ff                                 sta BORDER_COLOR
  2501  3afc 20023b                                 jsr draw_border
  2502  3aff 4c3a3b                                 jmp set_start_screen           ; jmp $3b3a
  2503                          ; ==============================================================================
  2504                          draw_border:        ; draws the extended "border"
  2505  3b02 a927                                   lda #$27
  2506  3b04 8502                                   sta zp02
  2507  3b06 8504                                   sta zp04
  2508  3b08 a908                                   lda #>COLRAM
  2509  3b0a 8505                                   sta zp05
  2510  3b0c a90c                                   lda #>SCREENRAM
  2511  3b0e 8503                                   sta zp03
  2512  3b10 a218                                   ldx #$18
  2513  3b12 a000                                   ldy #$00
  2514  3b14 a95d               -                   lda #$5d
  2515  3b16 9102                                   sta (zp02),y
  2516  3b18 a912                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  2517  3b1a 9104                                   sta (zp04),y
  2518  3b1c 98                                     tya
  2519  3b1d 18                                     clc
  2520  3b1e 6928                                   adc #$28
  2521  3b20 a8                                     tay
  2522  3b21 9004                                   bcc +
  2523  3b23 e603                                   inc zp03
  2524  3b25 e605                                   inc zp05
  2525  3b27 ca                 +                   dex
  2526  3b28 d0ea                                   bne -
  2527  3b2a a95d               -                   lda #$5d
  2528  3b2c 9dc00f                                 sta SCREENRAM + $3c0,x
  2529  3b2f a912                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  2530  3b31 9dc00b                                 sta COLRAM + $3c0,x
  2531  3b34 e8                                     inx
  2532  3b35 e028                                   cpx #$28
  2533  3b37 d0f1                                   bne -
  2534  3b39 60                                     rts
  2535                          
  2536                          ; ==============================================================================
  2537                          ; SETUP FIRST ROOM
  2538                          ; player xy position and room number
  2539                          ; ==============================================================================
  2540                          
  2541                          set_start_screen:
  2542  3b3a a906                                   lda #PLAYER_START_POS_Y
  2543  3b3c 8da435                                 sta player_pos_y + 1               ; Y player start position (0 = top)
  2544  3b3f a903                                   lda #PLAYER_START_POS_X
  2545  3b41 8da635                                 sta player_pos_x + 1               ; X player start position (0 = left)
  2546  3b44 a910                                   lda #START_ROOM              ; room number (start screen) ($3b45)
  2547  3b46 8d4c30                                 sta current_room + 1
  2548  3b49 202d3a                                 jsr m3A2D                   ; jsr $3a2d
  2549                          
  2550                          m3B4C:
  2551  3b4c 20ef2f                                 jsr m2FEF                   ; jsr $2fef
  2552  3b4f a030                                   ldy #$30
  2553  3b51 20763a                                 jsr wait
  2554  3b54 20cb2f                                 jsr m2fCB                   ; jsr $2fcb
  2555  3b57 4c2c16                                 jmp m162d
  2556                          ; ==============================================================================
  2557                          
  2558                          death_messages:
  2559                          
  2560                          ; death messages
  2561                          ; like "You fell into a snake pit"
  2562                          
  2563                          ; scr conversion
  2564                          
  2565                          ; 00 You fell into a snake pit
  2566                          ; 01 You'd better watched out for the sacred column
  2567                          ; 02 You drowned in the deep river
  2568                          ; 03 You drank from the poisend bottle
  2569                          ; 04 Boris the spider got you and killed you
  2570                          ; 05 Didn't you see the laser beam?
  2571                          ; 06 240 Volts! You got an electrical shock!
  2572                          ; 07 You stepped on a nail!
  2573                          ; 08 A foot trap stopped you!
  2574                          ; 09 This room is doomed by the wizard Manilo!
  2575                          ; 0a You were locked in and starved!
  2576                          ; 0b You were hit by a big rock and died!
  2577                          ; 0c Belegro killed you!
  2578                          ; 0d You found a thirsty zombie....
  2579                          ; 0e The monster grabbed you you. You are dead!
  2580                          ; 0f You were wounded by the bush!
  2581                          ; 10 You are trapped in wire-nettings!
  2582                          
  2583                          !if LANGUAGE = EN{
  2584                          !scr "You fell into a          snake pit !              "
  2585                          !scr "You'd better watched out for the sacred column!   "
  2586                          !scr "You drowned in the deep  river !                  "
  2587                          !scr "You drank from the       poisened bottle ........ "
  2588                          !scr "Boris, the spider, got   you and killed you !     "
  2589                          !scr "Didn't you see the       laser beam ?!?           "
  2590                          !scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  2591                          !scr "You stepped on a nail !                           "
  2592                          !scr "A foot trap stopped you !                         "
  2593                          !scr "This room is doomed      by the wizard Manilo !   "
  2594                          !scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  2595                          !scr "You were hit by a big    rock and died !          "
  2596                          !scr "Belegro killed           you !                    "
  2597                          !scr "You found a thirsty      zombie .......           "
  2598                          !scr "The monster grapped       you. You are dead !     "
  2599                          !scr "You were wounded by      the bush !               "
  2600                          !scr "You are trapped in       wire-nettings !          "
  2601                          }
  2602                          
  2603                          
  2604                          !if LANGUAGE = DE{
  2605  3b5a 5309052013090e04...!scr "Sie sind in eine         Schlangengrube gefallen !"
  2606  3b8c 470f141405130c01...!scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  2607  3bbe 5309052013090e04...!scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  2608  3bf0 5309052008010205...!scr "Sie haben aus der Gift-  flasche getrunken....... "
  2609  3c22 420f1209132c2004...!scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  2610  3c54 44050e204c011305...!scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  2611  3c86 32323020560f0c14...!scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  2612  3cb8 5309052013090e04...!scr "Sie sind in einen Nagel  getreten !               "
  2613  3cea 45090e0520461513...!scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  2614  3d1c 4115062004090513...!scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  2615  3d4e 5309052017151204...!scr "Sie wurden eingeschlossenund verhungern !         "
  2616  3d80 5309052017151204...!scr "Sie wurden von einem     Stein ueberollt !!       "
  2617  3db2 42050c0507120f20...!scr "Belegro hat Sie          vernichtet !             "
  2618  3de4 490d205301120720...!scr "Im Sarg lag ein durstigerZombie........           "
  2619  3e16 440113204d0f0e13...!scr "Das Monster hat Sie      erwischt !!!!!           "
  2620  3e48 5309052008010205...!scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  2621  3e7a 5309052008010205...!scr "Sie haben sich im        Stacheldraht verfangen !!"
  2622                          }
  2623                          
  2624                          ; ==============================================================================
  2625                          ;
  2626                          ; Display the death message
  2627                          ; End of game and return to start screen
  2628                          ; ==============================================================================
  2629                          
  2630                          death:
  2631  3eac a93b                                   lda #>death_messages
  2632  3eae 85a8                                   sta zpA8
  2633  3eb0 a95a                                   lda #<death_messages
  2634  3eb2 85a7                                   sta zpA7
  2635  3eb4 c000                                   cpy #$00
  2636  3eb6 f00c                                   beq ++           ; beq $3ec4
  2637  3eb8 18                 -                   clc
  2638  3eb9 6932                                   adc #$32
  2639  3ebb 85a7                                   sta zpA7
  2640  3ebd 9002                                   bcc +            ; bcc $3ec1
  2641  3ebf e6a8                                   inc zpA8
  2642  3ec1 88                 +                   dey
  2643  3ec2 d0f4                                   bne -           ; bne $3eb8
  2644  3ec4 a90c               ++                  lda #$0c
  2645  3ec6 8503                                   sta zp03
  2646  3ec8 8402                                   sty zp02
  2647  3eca a204                                   ldx #$04
  2648  3ecc a920                                   lda #$20
  2649  3ece 9102               -                   sta (zp02),y
  2650  3ed0 c8                                     iny
  2651  3ed1 d0fb                                   bne -               ; bne $3ece
  2652  3ed3 e603                                   inc zp03
  2653  3ed5 ca                                     dex
  2654  3ed6 d0f6                                   bne -               ; bne $3ece
  2655  3ed8 209d3a                                 jsr set_charset_and_screen_for_title
  2656  3edb b1a7               -                   lda (zpA7),y
  2657  3edd 9dc00d                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  2658  3ee0 a900                                   lda #$00                                    ; color of the death message
  2659  3ee2 9dc009                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  2660  3ee5 e8                                     inx
  2661  3ee6 c8                                     iny
  2662  3ee7 e019                                   cpx #$19
  2663  3ee9 d002                                   bne +               ; bne $3eed
  2664  3eeb a250                                   ldx #$50
  2665  3eed c032               +                   cpy #$32
  2666  3eef d0ea                                   bne -               ; bne $3edb
  2667  3ef1 a9fd                                   lda #$fd
  2668  3ef3 8d15ff                                 sta BG_COLOR
  2669  3ef6 8d19ff                                 sta BORDER_COLOR
  2670                          m3EF9:
  2671  3ef9 a908                                   lda #$08
  2672  3efb a0ff               -                   ldy #$ff
  2673  3efd 20763a                                 jsr wait           ; jsr $3a76
  2674  3f00 38                                     sec
  2675  3f01 e901                                   sbc #$01
  2676  3f03 d0f6                                   bne -               ; bne $3efb
  2677  3f05 4cb33a                                 jmp init            ; jmp $3ab3
  2678                          ; ==============================================================================
  2679                          ; screen messages
  2680                          ; and the code entry text
  2681                          ; ==============================================================================
  2682                          
  2683                          !if LANGUAGE = EN{
  2684                          
  2685                          hint_messages:
  2686                          !scr " A part of the code number is :         "
  2687                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  2688                          !scr " You need: bulb, bulb holder, socket !  "
  2689                          !scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  2690                          !scr " *****   A helping letter :   "
  2691                          helping_letter: !scr "C   ***** "
  2692                          !scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  2693                          
  2694                          }
  2695                          
  2696                          !if LANGUAGE = DE{
  2697                          
  2698                          hint_messages:
  2699  3f08 2045090e20540509...!scr " Ein Teil des Loesungscodes lautet:     "
  2700  3f30 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  2701  3f58 2044152002120115...!scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  2702  3f80 20570905200c0115...!scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  2703  3fa8 202a2a2a2a2a2020...!scr " *****   Ein Hilfsbuchstabe:  "
  2704  3fc6 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  2705  3fd0 2046010c13030805...!scr " Falscher Loesungscode ! TODESSTRAFE !!!"
  2706                          
  2707                          }
