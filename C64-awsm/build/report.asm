
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
    14                          ; Ghost Town, Commodore 64 Version
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
    28                          LANGUAGE = EN
    29                          
    30                          ; ==============================================================================
    31                          ; thse settings change the appearance of the game
    32                          ; EXTENDED = 0 -> original version
    33                          ; EXTENDED = 1 -> altered version
    34                          ; ==============================================================================
    35                          
    36                          EXTENDED                = 0       ; 0 = original version, 1 = tweaks and cosmetics
    37                          
    38                          !if EXTENDED = 0{
    39                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $12 ; red
    40                              MULTICOLOR_1        = $db           ; face pink
    41                              MULTICOLOR_2        = $29
    42                              BORDER_COLOR_VALUE  = $12
    43                              TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    44                              TITLE_KEY           = $01
    45                          
    46                          }
    47                          
    48                          !if EXTENDED = 1{
    49                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $01 ; grey
    50                              MULTICOLOR_1        = $52           ; face pink
    51                              MULTICOLOR_2        = $19           ; brownish
    52                              BORDER_COLOR_VALUE  = $01
    53                              TITLE_KEY_MATRIX    = $7f           ; Extended version key to press on title screen: space
    54                              TITLE_KEY           = $10
    55                          }
    56                          
    57                          
    58                          ; ==============================================================================
    59                          ; CHEATS
    60                          ;
    61                          ;
    62                          ; ==============================================================================
    63                          
    64                          START_ROOM          = 0             ; default 0 
    65                          PLAYER_START_POS_X  = 3             ; default 3
    66                          PLAYER_START_POS_Y  = 6             ; default 6
    67                          SILENT_MODE         = 0
    68                          
    69                          ; ==============================================================================
    70                          ; ITEMS
    71                          ; not used in the code, but useful for testing, 
    72                          ; e.g. "> ._sword df" to pickup the sword in VICE monitor
    73                          ; ==============================================================================
    74                          
    75                          _boots              = items + $84
    76                          _ladder             = items + $4d
    77                          _gloves             = items + $8
    78                          _key                = items + $10
    79                          _wirecutter         = items + $19
    80                          _light              = items + $74
    81                          _hammer             = items + $bb
    82                          _shovel             = items + $96
    83                          _poweroutlet        = items + $ac
    84                          _lightbulb          = items + $c8
    85                          _sword              = items + $1a7
    86                          
    87                          ; ==============================================================================
    88                          ; ZEROPAGE
    89                          
    90                          zp02                = $02
    91                          zp03                = $03
    92                          zp04                = $04
    93                          zp05                = $05               ; seems to always store the COLRAM information
    94                          zp08                = $08
    95                          zp09                = $09
    96                          zp0A                = $0A
    97                          zp10                = $10
    98                          zp11                = $11
    99                          zpA7                = $A7
   100                          zpA8                = $A8
   101                          zpA9                = $A9
   102                          
   103                          ; ==============================================================================
   104                          
   105                          TAPE_BUFFER         = $033c             ; $0333
   106                          SCREENRAM           = $0400             ; $0C00             ; PLUS/4 default SCREEN
   107                          COLRAM              = $d800             ; $0800             ; PLUS/4 COLOR RAM
   108                          PRINT_KERNAL        = $ffd2             ; $c56b
   109                          BASIC_DA89          = $da89             ; scroll screen down?
   110                          FF07                = $d016             ; $FF07             ; FF07 scroll & multicolor
   111                          KEYBOARD_LATCH      = $FF08
   112                          INTERRUPT           = $FF09
   113                          FF0A                = $FF0A
   114                          VOICE1_FREQ_LOW     = $FF0E             ; Low byte of frequency for voice 1
   115                          VOICE2_FREQ_LOW     = $FF0F
   116                          VOICE2              = $FF10
   117                          VOLUME_AND_VOICE_SELECT = $FF11
   118                          VOICE1              = $FF12             ; Bit 0-1 : Voice #1 frequency, bits 8 & 9;  Bit 2    : TED data fetch ROM/RAM select; Bits 0-5 : Bit map base address
   119                          CHAR_BASE_ADDRESS   = $d018             ; $FF13
   120                          BG_COLOR            = $D021
   121                          COLOR_1             = $d022             ;$FF16
   122                          COLOR_2             = $d023             ; $FF17
   123                          COLOR_3             = $d024             ;$FF18
   124                          BORDER_COLOR        = $D020
   125                          FF1D                = $D012             ; $FF1D             ; FF1D raster line
   126                          
   127                          
   128                          
   129                          
   130                          
   131                          
   132                          
   133                          
   134                          
   135                          
   136                          
   137                          
   138                          
   139                          
   140                          
   141                          
   142                          
   143                          
   144                          
   145                          
   146                          
   147                          
   148                          
   149                          
   150                          ; ==============================================================================
   151                          
   152                                              !cpu 6510
   153                                              *= $1000
   154                          
   155                          ; ==============================================================================
   156                          ;
   157                          ; display the hint messages
   158                          ; ==============================================================================
   159                          
   160                          display_hint_message_plus_kernal:
   161                                             
   162  1000 20d2ff                                 jsr PRINT_KERNAL          
   163                          
   164                          display_hint_message:
   165                                             
   166  1003 a93e                                   lda #>hint_messages
   167  1005 85a8                                   sta zpA8
   168  1007 a996                                   lda #<hint_messages
   169  1009 c000               m1009:              cpy #$00
   170  100b f00a                                   beq ++              
   171  100d 18                 -                   clc
   172  100e 6928                                   adc #$28
   173  1010 9002                                   bcc +               
   174  1012 e6a8                                   inc zpA8
   175  1014 88                 +                   dey
   176  1015 d0f6                                   bne -               
   177  1017 85a7               ++                  sta zpA7
   178  1019 202b3a                                 jsr set_charset_and_screen          
   179  101c a027                                   ldy #$27
   180  101e b1a7               -                   lda (zpA7),y
   181  1020 99b805                                 sta SCREENRAM+$1B8,y 
   182  1023 a907                                   lda #$07
   183  1025 99b8d9                                 sta COLRAM+$1B8,y 
   184  1028 88                                     dey
   185  1029 d0f3                                   bne -               
   186  102b 60                                     rts
   187                          
   188                          
   189                          ; ==============================================================================
   190                          ;
   191                          ;
   192                          ; ==============================================================================
   193                          
   194                          prep_and_display_hint:
   195                          
   196  102c 205011                                 jsr switch_charset           
   197  102f c003                                   cpy #$03                                ; is the display hint the one for the code number?
   198  1031 f003                                   beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
   199  1033 4cd810                                 jmp display_hint                        ; no, display the hint
   200                          
   201                          
   202                          room_16_code_number_prep:
   203                          
   204  1036 200310                                 jsr display_hint_message                ; yes we are in room 3
   205  1039 2089da                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   206  103c 2089da                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   207  103f a001                                   ldy #$01                                ; y = 1
   208  1041 200310                                 jsr display_hint_message              
   209  1044 a200                                   ldx #$00                                ; x = 0
   210  1046 a000                                   ldy #$00                                ; y = 0
   211  1048 f013                                   beq room_16_enter_code                  ; room 16 code? how?
   212                          
   213                          room_16_cursor_blinking: 
   214                          
   215  104a bdb905                                 lda SCREENRAM+$1B9,x                    ; load something from screen
   216  104d 18                                     clc                                     
   217  104e 6980                                   adc #$80                                ; add $80 = 128 = inverted char
   218  1050 9db905                                 sta SCREENRAM+$1B9,x                    ; store in the same location
   219  1053 b98805                                 lda SCREENRAM+$188,y                    ; and the same for another position
   220  1056 18                                     clc
   221  1057 6980                                   adc #$80
   222  1059 998805                                 sta SCREENRAM+$188,y 
   223  105c 60                                     rts
   224                          
   225                          ; ==============================================================================
   226                          ; ROOM 16
   227                          ; ENTER CODE
   228                          ; ==============================================================================
   229                          
   230                          room_16_enter_code:
   231  105d 204a10                                 jsr room_16_cursor_blinking
   232  1060 8402                                   sty zp02
   233  1062 8604                                   stx zp04
   234  1064 20a510                                 jsr room_16_code_delay           
   235  1067 204a10                                 jsr room_16_cursor_blinking           
   236  106a 20a510                                 jsr room_16_code_delay
   237  106d a9fd                                   lda #$fd                                        ; KEYBOARD stuff
   238  106f 8d08ff                                 sta KEYBOARD_LATCH                              ; .
   239  1072 ad08ff                                 lda KEYBOARD_LATCH                              ; .
   240  1075 4a                                     lsr                                             ; .
   241  1076 4a                                     lsr
   242  1077 4a                                     lsr
   243  1078 b005                                   bcs +
   244  107a e000                                   cpx #$00
   245  107c f001                                   beq +
   246  107e ca                                     dex
   247  107f 4a                 +                   lsr
   248  1080 b005                                   bcs +
   249  1082 e025                                   cpx #$25
   250  1084 f001                                   beq +
   251  1086 e8                                     inx
   252  1087 2908               +                   and #$08
   253  1089 d0d2                                   bne room_16_enter_code
   254  108b bdb905                                 lda SCREENRAM+$1B9,x
   255  108e c9bc                                   cmp #$bc
   256  1090 d008                                   bne ++
   257  1092 c000                                   cpy #$00
   258  1094 f001                                   beq +
   259  1096 88                                     dey
   260  1097 4c5d10             +                   jmp room_16_enter_code
   261  109a 998805             ++                  sta SCREENRAM+$188,y
   262  109d c8                                     iny
   263  109e c005                                   cpy #$05
   264  10a0 d0bb                                   bne room_16_enter_code
   265  10a2 4caf10                                 jmp check_code_number
   266                          
   267                          ; ==============================================================================
   268                          ;
   269                          ; DELAYS CURSOR MOVEMENT AND BLINKING
   270                          ; ==============================================================================
   271                          
   272                          room_16_code_delay:
   273  10a5 a035                                   ldy #$35                            ; wait a bit
   274  10a7 20043a                                 jsr wait                        
   275  10aa a402                                   ldy zp02                            ; and load x and y 
   276  10ac a604                                   ldx zp04                            ; with shit from zp
   277  10ae 60                                     rts
   278                          
   279                          ; ==============================================================================
   280                          ; ROOM 16
   281                          ; CHECK THE CODE NUMBER
   282                          ; ==============================================================================
   283                          
   284                          check_code_number:
   285  10af a205                                   ldx #$05                            ; x = 5
   286  10b1 bd8705             -                   lda SCREENRAM+$187,x                ; get one number from code
   287  10b4 ddc610                                 cmp code_number-1,x                 ; is it correct?
   288  10b7 d006                                   bne +                               ; no -> +
   289  10b9 ca                                     dex                                 ; yes, check next number
   290  10ba d0f5                                   bne -                               
   291  10bc 4ccc10                                 jmp ++                              ; all correct -> ++
   292  10bf a005               +                   ldy #$05                            ; text for wrong code number
   293  10c1 200310                                 jsr display_hint_message            ; wrong code -> death
   294  10c4 4c353b                                 jmp m3EF9          
   295                          
   296  10c7 3036313338         code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38
   297                          
   298  10cc 200b3a             ++                  jsr set_game_basics                 ; code correct, continue
   299  10cf 20e539                                 jsr set_player_xy          
   300  10d2 20903a                                 jsr draw_border          
   301  10d5 4cda3a                                 jmp main_loop          
   302                          
   303                          ; ==============================================================================
   304                          ;
   305                          ; hint system (question marks)
   306                          ; ==============================================================================
   307                          
   308                          
   309                          display_hint:
   310  10d8 c000                                   cpy #$00
   311  10da d04a                                   bne m11A2           
   312  10dc 200010                                 jsr display_hint_message_plus_kernal
   313  10df aef82f                                 ldx current_room + 1
   314  10e2 e001                                   cpx #$01
   315  10e4 d002                                   bne +               
   316  10e6 a928                                   lda #$28
   317  10e8 e005               +                   cpx #$05
   318  10ea d002                                   bne +               
   319  10ec a929                                   lda #$29
   320  10ee e00a               +                   cpx #$0a
   321  10f0 d002                                   bne +               
   322  10f2 a947                                   lda #$47                   
   323                          
   324  10f4 e00c               +                   cpx #$0c
   325  10f6 d002                                   bne +
   326  10f8 a949                                   lda #$49
   327  10fa e00d               +                   cpx #$0d
   328  10fc d002                                   bne +
   329  10fe a945                                   lda #$45
   330  1100 e00f               +                   cpx #$0f
   331  1102 d00a                                   bne +               
   332  1104 a945                                   lda #$45
   333  1106 8d6fda                                 sta COLRAM + $26f       
   334  1109 a90f                                   lda #$0f
   335  110b 8d6f06                                 sta SCREENRAM + $26f       
   336  110e 8d1f06             +                   sta SCREENRAM + $21f       
   337  1111 a948                                   lda #$48
   338  1113 8d1fda                                 sta COLRAM + $21f       
   339  1116 ad00dc             -                   lda $dc00                         ;lda #$fd
   340                                                                                ;sta KEYBOARD_LATCH
   341                                                                                ; lda KEYBOARD_LATCH
   342  1119 2910                                   and #$10                          ; and #$80
   343  111b d0f9                                   bne -               
   344  111d 200b3a                                 jsr set_game_basics
   345  1120 20fb39                                 jsr m3A2D          
   346  1123 4cda3a                                 jmp main_loop         
   347  1126 c002               m11A2:              cpy #$02
   348  1128 d006                                   bne +             
   349  112a 200010             m11A6:              jsr display_hint_message_plus_kernal
   350  112d 4c1611                                 jmp -             
   351  1130 c004               +                   cpy #$04
   352  1132 d00b                                   bne +              
   353  1134 ad1039                                 lda m3952 + 1    
   354  1137 18                                     clc
   355  1138 6940                                   adc #$40                                        ; this is the helping letter
   356  113a 8d543f                                 sta helping_letter         
   357  113d d0eb                                   bne m11A6          
   358  113f 88                 +                   dey
   359  1140 88                                     dey
   360  1141 88                                     dey
   361  1142 88                                     dey
   362  1143 88                                     dey
   363  1144 a93f                                   lda #>item_pickup_message
   364  1146 85a8                                   sta zpA8
   365  1148 a986                                   lda #<item_pickup_message
   366  114a 200910                                 jsr m1009
   367  114d 4c1611                                 jmp -
   368                          
   369                          ; ==============================================================================
   370                          
   371                          switch_charset:
   372  1150 202b3a                                 jsr set_charset_and_screen           
   373  1153 4cd2ff                                 jmp PRINT_KERNAL           
   374                          
   375                          
   376                          
   377                          
   378                          
   379                          
   380                          
   381                          
   382                          
   383                          
   384                          
   385                          
   386                          
   387                          
   388                          
   389                          
   390                          
   391                          
   392                          
   393                          
   394                          
   395                          
   396                          
   397                          
   398                          
   399                          
   400                          
   401                          ; ==============================================================================
   402                          ;
   403                          ; JUMP TO ROOM LOGIC
   404                          ; This code is new. Previously, code execution jumped from room to room
   405                          ; and in each room did the comparison with the room number.
   406                          ; This is essentially the same, but bundled in one place.
   407                          ; not calles in between room changes, only e.g. for question mark
   408                          ; ==============================================================================
   409                          
   410                          check_room:
   411  1156 acf82f                                 ldy current_room + 1        ; load in the current room number
   412  1159 c000                                   cpy #0
   413  115b d003                                   bne +
   414  115d 4cf811                                 jmp room_00
   415  1160 c001               +                   cpy #1
   416  1162 d003                                   bne +
   417  1164 4c1312                                 jmp room_01
   418  1167 c002               +                   cpy #2
   419  1169 d003                                   bne +
   420  116b 4c5012                                 jmp room_02
   421  116e c003               +                   cpy #3
   422  1170 d003                                   bne +
   423  1172 4ca612                                 jmp room_03
   424  1175 c004               +                   cpy #4
   425  1177 d003                                   bne +
   426  1179 4cb212                                 jmp room_04
   427  117c c005               +                   cpy #5
   428  117e d003                                   bne +
   429  1180 4cd412                                 jmp room_05
   430  1183 c006               +                   cpy #6
   431  1185 d003                                   bne +
   432  1187 4cf812                                 jmp room_06
   433  118a c007               +                   cpy #7
   434  118c d003                                   bne +
   435  118e 4c0413                                 jmp room_07
   436  1191 c008               +                   cpy #8
   437  1193 d003                                   bne +
   438  1195 4c3c13                                 jmp room_08
   439  1198 c009               +                   cpy #9
   440  119a d003                                   bne +
   441  119c 4c9313                                 jmp room_09
   442  119f c00a               +                   cpy #10
   443  11a1 d003                                   bne +
   444  11a3 4c9f13                                 jmp room_10
   445  11a6 c00b               +                   cpy #11
   446  11a8 d003                                   bne +
   447  11aa 4ccf13                                 jmp room_11 
   448  11ad c00c               +                   cpy #12
   449  11af d003                                   bne +
   450  11b1 4cde13                                 jmp room_12
   451  11b4 c00d               +                   cpy #13
   452  11b6 d003                                   bne +
   453  11b8 4cfa13                                 jmp room_13
   454  11bb c00e               +                   cpy #14
   455  11bd d003                                   bne +
   456  11bf 4c1e14                                 jmp room_14
   457  11c2 c00f               +                   cpy #15
   458  11c4 d003                                   bne +
   459  11c6 4c2a14                                 jmp room_15
   460  11c9 c010               +                   cpy #16
   461  11cb d003                                   bne +
   462  11cd 4c3614                                 jmp room_16
   463  11d0 c011               +                   cpy #17
   464  11d2 d003                                   bne +
   465  11d4 4c5c14                                 jmp room_17
   466  11d7 4c6b14             +                   jmp room_18
   467                          
   468                          
   469                          
   470                          ; ==============================================================================
   471                          
   472                          check_death:
   473  11da 20d737                                 jsr update_items_display
   474  11dd 4cda3a                                 jmp main_loop           
   475                          
   476                          ; ==============================================================================
   477                          
   478                          m11E0:              
   479  11e0 a200                                   ldx #$00
   480  11e2 bd4503             -                   lda TAPE_BUFFER + $9,x              
   481  11e5 c91e                                   cmp #$1e                            ; question mark
   482  11e7 9007                                   bcc check_next_char_under_player           
   483  11e9 c9df                                   cmp #$df
   484  11eb f003                                   beq check_next_char_under_player
   485  11ed 4c5611                                 jmp check_room              
   486                          
   487                          ; ==============================================================================
   488                          
   489                          check_next_char_under_player:
   490  11f0 e8                                     inx
   491  11f1 e009                                   cpx #$09
   492  11f3 d0ed                                   bne -                              ; not done checking          
   493  11f5 4cda3a             -                   jmp main_loop           
   494                          
   495                          
   496                          ; ==============================================================================
   497                          ;
   498                          ;                                                             ###        ###
   499                          ;          #####      ####      ####     #    #              #   #      #   #
   500                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   501                          ;          #    #    #    #    #    #    # ## #             #     #    #     #
   502                          ;          #####     #    #    #    #    #    #             #     #    #     #
   503                          ;          #   #     #    #    #    #    #    #              #   #      #   #
   504                          ;          #    #     ####      ####     #    #               ###        ###
   505                          ;
   506                          ; ==============================================================================
   507                          
   508                          
   509                          room_00:
   510                          
   511  11f8 c9a9                                   cmp #$a9                                        ; has the player hit the gloves?
   512  11fa d0f4                                   bne check_next_char_under_player                ; no
   513  11fc a9df                                   lda #$df                                        ; yes, load in char for "empty"
   514  11fe cd6836                                 cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
   515  1201 d0f2                                   bne -                                           ; no
   516  1203 200812                                 jsr pickup_gloves                               ; yes
   517  1206 d0d2                                   bne check_death
   518                          
   519                          
   520                          pickup_gloves:
   521  1208 a96b                                   lda #$6b                                        ; load character for empty bush
   522  120a 8d2336                                 sta items + $8                                  ; store 6b = gloves in inventory
   523  120d a93d                                   lda #$3d                                        ; set the foreground color
   524  120f 8d2136                                 sta items + $6                                  ; and store the color in the items table
   525  1212 60                                     rts
   526                          
   527                          
   528                          
   529                          
   530                          
   531                          
   532                          ; ==============================================================================
   533                          ;
   534                          ;                                                             ###        #
   535                          ;          #####      ####      ####     #    #              #   #      ##
   536                          ;          #    #    #    #    #    #    ##  ##             #     #    # #
   537                          ;          #    #    #    #    #    #    # ## #             #     #      #
   538                          ;          #####     #    #    #    #    #    #             #     #      #
   539                          ;          #   #     #    #    #    #    #    #              #   #       #
   540                          ;          #    #     ####      ####     #    #               ###      #####
   541                          ;
   542                          ; ==============================================================================
   543                          
   544                          room_01:
   545                          
   546  1213 c9e0                                   cmp #$e0                                    ; empty character in charset -> invisible key
   547  1215 f004                                   beq +                                       ; yes, key is there -> +
   548  1217 c9e1                                   cmp #$e1
   549  1219 d014                                   bne ++
   550  121b a9aa               +                   lda #$aa                                    ; display the key, $AA = 1st part of key
   551  121d 8d2b36                                 sta items + $10                             ; store key in items list
   552  1220 20d737                                 jsr update_items_display                    ; update all items in the items list (we just made the key visible)
   553  1223 a0f0                                   ldy #$f0                                    ; set waiting time
   554  1225 20043a                                 jsr wait                                    ; wait
   555  1228 a9df                                   lda #$df                                    ; set key to empty space
   556  122a 8d2b36                                 sta items + $10                             ; update items list
   557  122d d0ab                                   bne check_death
   558  122f c927               ++                  cmp #$27                                    ; question mark (I don't know why 27)
   559  1231 b005                                   bcs check_death_bush
   560  1233 a000                                   ldy #$00
   561  1235 4c2c10                                 jmp prep_and_display_hint
   562                          
   563                          check_death_bush:
   564  1238 c9ad                                   cmp #$ad                                    ; wirecutters
   565  123a d0b4                                   bne check_next_char_under_player
   566  123c ad2336                                 lda items + $8                              ; inventory place for the gloves! 6b = gloves
   567  123f c96b                                   cmp #$6b
   568  1241 f005                                   beq +
   569  1243 a00f                                   ldy #$0f
   570  1245 4ce83a                                 jmp death                                   ; 0f You were wounded by the bush!
   571                          
   572  1248 a9f9               +                   lda #$f9                                    ; wirecutter picked up
   573  124a 8d3436                                 sta items + $19
   574  124d 4cda11                                 jmp check_death
   575                          
   576                          
   577                          
   578                          
   579                          
   580                          
   581                          ; ==============================================================================
   582                          ;
   583                          ;                                                             ###       #####
   584                          ;          #####      ####      ####     #    #              #   #     #     #
   585                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   586                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   587                          ;          #####     #    #    #    #    #    #             #     #    #
   588                          ;          #   #     #    #    #    #    #    #              #   #     #
   589                          ;          #    #     ####      ####     #    #               ###      #######
   590                          ;
   591                          ; ==============================================================================
   592                          
   593                          room_02:
   594                          
   595  1250 c9f5                                   cmp #$f5                                    ; did the player hit the fence? f5 = fence character
   596  1252 d014                                   bne check_lock                              ; no, check for the lock
   597  1254 ad3436                                 lda items + $19                             ; fence was hit, so check if wirecuter was picked up
   598  1257 c9f9                                   cmp #$f9                                    ; where the wirecutters (f9) picked up?
   599  1259 f005                                   beq remove_fence                            ; yes
   600  125b a010                                   ldy #$10                                    ; no, load the correct death message
   601  125d 4ce83a                                 jmp death                                   ; 10 You are trapped in wire-nettings!
   602                          
   603                          remove_fence:
   604  1260 a9df                                   lda #$df                                    ; empty char
   605  1262 8dba38                                 sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
   606  1265 4cda11             m1264:              jmp check_death
   607                          
   608                          
   609                          check_lock:
   610  1268 c9a6                                   cmp #$a6                                    ; lock
   611  126a d00e                                   bne +
   612  126c ad2b36                                 lda items + $10
   613  126f c9df                                   cmp #$df
   614  1271 d0f2                                   bne m1264
   615  1273 a9df                                   lda #$df
   616  1275 8d5336                                 sta items + $38
   617  1278 d0eb                                   bne m1264
   618  127a c9b1               +                   cmp #$b1                                    ; ladder
   619  127c d00a                                   bne +
   620  127e a9df                                   lda #$df
   621  1280 8d6836                                 sta items + $4d
   622  1283 8d7336                                 sta items + $58
   623  1286 d0dd                                   bne m1264
   624  1288 c9b9               +                   cmp #$b9                                    ; bottle
   625  128a f003                                   beq +
   626  128c 4cf011                                 jmp check_next_char_under_player
   627  128f add636             +                   lda items + $bb
   628  1292 c9df                                   cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
   629  1294 f005                                   beq take_key_out_of_bottle                                   
   630  1296 a003                                   ldy #$03
   631  1298 4ce83a                                 jmp death                                   ; 03 You drank from the poisend bottle
   632                          
   633                          take_key_out_of_bottle:
   634  129b a901                                   lda #$01
   635  129d 8da512                                 sta key_in_bottle_storage
   636  12a0 a005                                   ldy #$05
   637  12a2 4c2c10                                 jmp prep_and_display_hint
   638                          
   639                          ; ==============================================================================
   640                          ; this is 1 if the key from the bottle was taken and 0 if not
   641                          
   642  12a5 00                 key_in_bottle_storage:              !byte $00
   643                          
   644                          
   645                          
   646                          
   647                          
   648                          
   649                          
   650                          
   651                          
   652                          ; ==============================================================================
   653                          ;
   654                          ;                                                             ###       #####
   655                          ;          #####      ####      ####     #    #              #   #     #     #
   656                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   657                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   658                          ;          #####     #    #    #    #    #    #             #     #          #
   659                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   660                          ;          #    #     ####      ####     #    #               ###       #####
   661                          ;
   662                          ; ==============================================================================
   663                          
   664                          room_03:
   665                          
   666  12a6 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   667  12a8 9003                                   bcc +
   668  12aa 4cda3a                                 jmp main_loop
   669  12ad a004               +                   ldy #$04
   670  12af 4c2c10                                 jmp prep_and_display_hint
   671                          
   672                          
   673                          
   674                          
   675                          
   676                          
   677                          ; ==============================================================================
   678                          ;
   679                          ;                                                             ###      #
   680                          ;          #####      ####      ####     #    #              #   #     #    #
   681                          ;          #    #    #    #    #    #    ##  ##             #     #    #    #
   682                          ;          #    #    #    #    #    #    # ## #             #     #    #    #
   683                          ;          #####     #    #    #    #    #    #             #     #    #######
   684                          ;          #   #     #    #    #    #    #    #              #   #          #
   685                          ;          #    #     ####      ####     #    #               ###           #
   686                          ;
   687                          ; ==============================================================================
   688                          
   689                          room_04:
   690                          
   691  12b2 c93b                                   cmp #$3b                                    ; you bumped into a zombie coffin?
   692  12b4 f004                                   beq +                                       ; yep
   693  12b6 c942                                   cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
   694  12b8 d005                                   bne ++                                      ; no, really, I didn't ( I swear! )-> ++
   695  12ba a00d               +                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
   696  12bc 4ce83a                                 jmp death                                   ; 0d You found a thirsty zombie....
   697                          
   698                          ++
   699  12bf c9f7                                   cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
   700  12c1 f007                                   beq +                                       ; seems you picked a coffin that contained something different...
   701  12c3 c9f8                                   cmp #$f8
   702  12c5 f003                                   beq +
   703  12c7 4cf011                                 jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
   704  12ca a900               +                   lda #$00                                    ; 
   705  12cc 8d0839                                 sta m394A + 1                               ; some kind of prep for the door to be unlocked 
   706  12cf a006                                   ldy #$06                                    ; display
   707  12d1 4c2c10                                 jmp prep_and_display_hint
   708                          
   709                          
   710                          
   711                          
   712                          
   713                          
   714                          ; ==============================================================================
   715                          ;
   716                          ;                                                             ###      #######
   717                          ;          #####      ####      ####     #    #              #   #     #
   718                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   719                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   720                          ;          #####     #    #    #    #    #    #             #     #          #
   721                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   722                          ;          #    #     ####      ####     #    #               ###       #####
   723                          ;
   724                          ; ==============================================================================
   725                          
   726                          room_05:
   727                          
   728  12d4 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   729  12d6 b005                                   bcs +                                       ; no
   730  12d8 a000                                   ldy #$00                                    ; a = 0
   731  12da 4c2c10                                 jmp prep_and_display_hint
   732                          
   733  12dd c9fd               +                   cmp #$fd                                    ; stone with breathing tube hit?
   734  12df f003                                   beq +                                       ; yes -> +
   735  12e1 4cf011                                 jmp check_next_char_under_player            ; no
   736                          
   737  12e4 a900               +                   lda #$00                                    ; a = 0                  
   738  12e6 acb136                                 ldy items + $96                             ; do you have the shovel? 
   739  12e9 c0df                                   cpy #$df
   740  12eb d008                                   bne +                                       ; no I don't
   741  12ed 8d9638                                 sta breathing_tube_mod + 1                  ; yes, take the breathing tube
   742  12f0 a007                                   ldy #$07                                    ; and display the message
   743  12f2 4c2c10                                 jmp prep_and_display_hint
   744  12f5 4cda3a             +                   jmp main_loop
   745                          
   746                                              ;ldy #$07                                   ; same is happening above and I don't see this being called
   747                                              ;jmp prep_and_display_hint
   748                          
   749                          
   750                          
   751                          
   752                          
   753                          
   754                          ; ==============================================================================
   755                          ;
   756                          ;                                                             ###       #####
   757                          ;          #####      ####      ####     #    #              #   #     #     #
   758                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   759                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   760                          ;          #####     #    #    #    #    #    #             #     #    #     #
   761                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   762                          ;          #    #     ####      ####     #    #               ###       #####
   763                          ;
   764                          ; ==============================================================================
   765                          
   766                          room_06:
   767                          
   768  12f8 c9f6                                   cmp #$f6                                    ; is it a trapped door?
   769  12fa f003                                   beq +                                       ; OMG Yes the room is full of...
   770  12fc 4cf011                                 jmp check_next_char_under_player            ; please move on. nothing happened.
   771  12ff a000               +                   ldy #$00
   772  1301 4ce83a                                 jmp death                                   ; 00 You fell into a snake pit
   773                          
   774                          
   775                          
   776                          
   777                          
   778                          
   779                          ; ==============================================================================
   780                          ;
   781                          ;                                                             ###      #######
   782                          ;          #####      ####      ####     #    #              #   #     #    #
   783                          ;          #    #    #    #    #    #    ##  ##             #     #        #
   784                          ;          #    #    #    #    #    #    # ## #             #     #       #
   785                          ;          #####     #    #    #    #    #    #             #     #      #
   786                          ;          #   #     #    #    #    #    #    #              #   #       #
   787                          ;          #    #     ####      ####     #    #               ###        #
   788                          ;
   789                          ; ==============================================================================
   790                          
   791                          room_07:
   792                                  
   793  1304 c9e3                                   cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
   794  1306 d005                                   bne +
   795  1308 a001                                   ldy #$01                                    ; 01 You'd better watched out for the sacred column
   796  130a 4ce83a                                 jmp death                                   ; bne m1303 <- seems unneccessary
   797                          
   798  130d c95f               +                   cmp #$5f                                    ; seems to be the invisible char for the light
   799  130f f003                                   beq +                                       ; and it was hit -> +
   800  1311 4cf011                                 jmp check_next_char_under_player            ; if not, continue checking
   801                          
   802  1314 a9bc               +                   lda #$bc                                    ; make light visible
   803  1316 8d8f36                                 sta items + $74                             ; but I dont understand how the whole light is shown
   804  1319 a95f                                   lda #$5f                                    ; color?
   805  131b 8d8d36                                 sta items + $72                             ; 
   806  131e 20d737                                 jsr update_items_display                    ; and redraw items
   807  1321 a0ff                                   ldy #$ff
   808  1323 20043a                                 jsr wait                                    ; wait for some time so the player can actually see the light
   809  1326 20043a                                 jsr wait
   810  1329 20043a                                 jsr wait
   811  132c 20043a                                 jsr wait
   812  132f a9df                                   lda #$df
   813  1331 8d8f36                                 sta items + $74                             ; and pick up the light/ remove it from the items list
   814  1334 a900                                   lda #$00
   815  1336 8d8d36                                 sta items + $72                             ; also paint the char black
   816  1339 4cda11                                 jmp check_death
   817                          
   818                          
   819                          
   820                          
   821                          
   822                          
   823                          ; ==============================================================================
   824                          ;
   825                          ;                                                             ###       #####
   826                          ;          #####      ####      ####     #    #              #   #     #     #
   827                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   828                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   829                          ;          #####     #    #    #    #    #    #             #     #    #     #
   830                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   831                          ;          #    #     ####      ####     #    #               ###       #####
   832                          ;
   833                          ; ==============================================================================
   834                          
   835                          room_08:
   836                          
   837  133c a000                                   ldy #$00                                    ; y = 0
   838  133e 84a7                                   sty zpA7                                    ; zpA7 = 0
   839  1340 c94b                                   cmp #$4b                                    ; water
   840  1342 d015                                   bne check_item_water
   841  1344 ac9638                                 ldy breathing_tube_mod + 1
   842  1347 d017                                   bne +
   843  1349 209b35                                 jsr get_player_pos
   844  134c a918                                   lda #$18                                    ; move player on the other side of the river
   845  134e 8d4235             --                  sta player_pos_x + 1
   846  1351 a90c                                   lda #$0c
   847  1353 8d4035                                 sta player_pos_y + 1
   848  1356 4cda3a             -                   jmp main_loop
   849                          
   850                          
   851                          check_item_water:
   852  1359 c956                                   cmp #$56                                    ; so you want to swim right?
   853  135b d011                                   bne check_item_shovel                       ; nah, not this time -> check_item_shovel
   854  135d ac9638                                 ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
   855  1360 d007               +                   bne +
   856  1362 209b35                                 jsr get_player_pos                          ; tube equipped and ready to submerge
   857  1365 a90c                                   lda #$0c
   858  1367 d0e5                                   bne --                                      ; see you on the other side!
   859                          
   860  1369 a002               +                   ldy #$02                                    ; breathing what?
   861  136b 4ce83a                                 jmp death                                   ; 02 You drowned in the deep river
   862                          
   863                          
   864                          check_item_shovel:
   865  136e c9c1                                   cmp #$c1                                    ; wanna have that shovel?
   866  1370 f004                                   beq +                                       ; yup
   867  1372 c9c3                                   cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
   868  1374 d008                                   bne ++                                      ; nah still not interested -> ++
   869  1376 a9df               +                   lda #$df                                    ; alright cool,
   870  1378 8db136                                 sta items + $96                             ; shovel is yours now
   871  137b 4cda11             --                  jmp check_death
   872                          
   873                          
   874  137e c9ca               ++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
   875  1380 f003                                   beq +                                       ; yup
   876  1382 4cf011                                 jmp check_next_char_under_player
   877  1385 add636             +                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
   878  1388 c9df                                   cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
   879  138a d0ca                                   bne -                                       ; what hammer?
   880  138c a9df                                   lda #$df
   881  138e 8d9f36                                 sta items + $84                             ; these fine boots are yours now, sir
   882  1391 d0e8                                   bne --
   883                          
   884                          
   885                          
   886                          
   887                          
   888                          
   889                          ; ==============================================================================
   890                          ;
   891                          ;                                                             ###       #####
   892                          ;          #####      ####      ####     #    #              #   #     #     #
   893                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   894                          ;          #    #    #    #    #    #    # ## #             #     #     ######
   895                          ;          #####     #    #    #    #    #    #             #     #          #
   896                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   897                          ;          #    #     ####      ####     #    #               ###       #####
   898                          ;
   899                          ; ==============================================================================
   900                          
   901                          room_09:            
   902                          
   903  1393 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   904  1395 9003                                   bcc +                                       ; yes -> +
   905  1397 4cf011                                 jmp check_next_char_under_player            ; continue checking
   906  139a a002               +                   ldy #$02                                    ; display hint
   907  139c 4c2c10                                 jmp prep_and_display_hint
   908                          
   909                          
   910                          
   911                          
   912                          
   913                          
   914                          ; ==============================================================================
   915                          ;
   916                          ;                                                             #        ###
   917                          ;          #####      ####      ####     #    #              ##       #   #
   918                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
   919                          ;          #    #    #    #    #    #    # ## #               #      #     #
   920                          ;          #####     #    #    #    #    #    #               #      #     #
   921                          ;          #   #     #    #    #    #    #    #               #       #   #
   922                          ;          #    #     ####      ####     #    #             #####      ###
   923                          ;
   924                          ; ==============================================================================
   925                          
   926                          room_10:
   927                          
   928  139f c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   929  13a1 b005                                   bcs +
   930  13a3 a000                                   ldy #$00                                    ; display hint
   931  13a5 4c2c10                                 jmp prep_and_display_hint
   932                          
   933  13a8 c9cc               +                   cmp #$cc                                    ; hit the power outlet?
   934  13aa f007                                   beq +                                       ; yes -> +
   935  13ac c9cf                                   cmp #$cf                                    ; hit the power outlet?
   936  13ae f003                                   beq +                                       ; yes -> +
   937  13b0 4cf011                                 jmp check_next_char_under_player            ; no, continue
   938  13b3 a9df               +                   lda #$df                                    
   939  13b5 cd8f36                                 cmp items + $74                             ; light picked up?
   940  13b8 d010                                   bne +                                       ; no -> death
   941  13ba cde336                                 cmp items + $c8                             ; yes, lightbulb picked up?
   942  13bd d00b                                   bne +                                       ; no -> death
   943  13bf 8dc736                                 sta items + $ac                             ; yes, pick up power outlet
   944  13c2 a959                                   lda #$59                                    ; and make the foot traps visible
   945  13c4 8d4737                                 sta items + $12c                            ; color position for foot traps
   946  13c7 4cda11                                 jmp check_death
   947                          
   948  13ca a006               +                   ldy #$06
   949  13cc 4ce83a                                 jmp death                                   ; 06 240 Volts! You got an electrical shock!
   950                          
   951                          
   952                          
   953                          
   954                          
   955                          
   956                          ; ==============================================================================
   957                          ;
   958                          ;                                                             #        #
   959                          ;          #####      ####      ####     #    #              ##       ##
   960                          ;          #    #    #    #    #    #    ##  ##             # #      # #
   961                          ;          #    #    #    #    #    #    # ## #               #        #
   962                          ;          #####     #    #    #    #    #    #               #        #
   963                          ;          #   #     #    #    #    #    #    #               #        #
   964                          ;          #    #     ####      ####     #    #             #####    #####
   965                          ;
   966                          ; ==============================================================================
   967                          
   968                          room_11:
   969                          
   970  13cf c9d1                                   cmp #$d1                                    ; picking up the hammer?
   971  13d1 f003                                   beq +                                       ; jep
   972  13d3 4cf011                                 jmp check_next_char_under_player            ; no, continue
   973  13d6 a9df               +                   lda #$df                                    ; player takes the hammer
   974  13d8 8dd636                                 sta items + $bb                             ; hammer
   975  13db 4cda11                                 jmp check_death
   976                          
   977                          
   978                          
   979                          
   980                          
   981                          
   982                          ; ==============================================================================
   983                          ;
   984                          ;                                                             #       #####
   985                          ;          #####      ####      ####     #    #              ##      #     #
   986                          ;          #    #    #    #    #    #    ##  ##             # #            #
   987                          ;          #    #    #    #    #    #    # ## #               #       #####
   988                          ;          #####     #    #    #    #    #    #               #      #
   989                          ;          #   #     #    #    #    #    #    #               #      #
   990                          ;          #    #     ####      ####     #    #             #####    #######
   991                          ;
   992                          ; ==============================================================================
   993                          
   994                          room_12:
   995                          
   996  13de c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   997  13e0 b005                                   bcs +                                       ; no
   998  13e2 a000                                   ldy #$00                                    
   999  13e4 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1000                          
  1001  13e7 c9d2               +                   cmp #$d2                                    ; light bulb hit?
  1002  13e9 f007                                   beq +                                       ; yes
  1003  13eb c9d5                                   cmp #$d5                                    ; light bulb hit?
  1004  13ed f003                                   beq +                                       ; yes
  1005  13ef 4cf011                                 jmp check_next_char_under_player            ; no, continue
  1006  13f2 a9df               +                   lda #$df                                    ; pick up light bulb
  1007  13f4 8de336                                 sta items + $c8
  1008  13f7 4cda11                                 jmp check_death
  1009                          
  1010                          
  1011                          
  1012                          
  1013                          
  1014                          
  1015                          ; ==============================================================================
  1016                          ;
  1017                          ;                                                             #       #####
  1018                          ;          #####      ####      ####     #    #              ##      #     #
  1019                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1020                          ;          #    #    #    #    #    #    # ## #               #       #####
  1021                          ;          #####     #    #    #    #    #    #               #            #
  1022                          ;          #   #     #    #    #    #    #    #               #      #     #
  1023                          ;          #    #     ####      ####     #    #             #####     #####
  1024                          ;
  1025                          ; ==============================================================================
  1026                          
  1027                          room_13:           
  1028                          
  1029  13fa c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1030  13fc b005                                   bcs +
  1031  13fe a000                                   ldy #$00                                    ; message 0 to display
  1032  1400 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1033                          
  1034  1403 c9d6               +                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
  1035  1405 f003                                   beq +                                       ; OUCH!! -> +
  1036  1407 4cf011                                 jmp check_next_char_under_player            ; not stepped into a nail... yet.
  1037  140a ad9f36             +                   lda items + $84                             ; are the boots taken?
  1038  140d c9df                                   cmp #$df                                
  1039  140f f005                                   beq +                                       ; yeah I'm cool these boots are made for nailin'. 
  1040  1411 a007                                   ldy #$07                                    ; death by a thousand nails.
  1041  1413 4ce83a                                 jmp death                                   ; 07 You stepped on a nail!
  1042                          
  1043                          +
  1044  1416 a9e2                                   lda #$e2                                    ; this is also a nail. 
  1045  1418 8df036                                 sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
  1046  141b 4cda11                                 jmp check_death
  1047                          
  1048                          
  1049                          
  1050                          
  1051                          
  1052                          
  1053                          ; ==============================================================================
  1054                          ;
  1055                          ;                                                             #      #
  1056                          ;          #####      ####      ####     #    #              ##      #    #
  1057                          ;          #    #    #    #    #    #    ##  ##             # #      #    #
  1058                          ;          #    #    #    #    #    #    # ## #               #      #    #
  1059                          ;          #####     #    #    #    #    #    #               #      #######
  1060                          ;          #   #     #    #    #    #    #    #               #           #
  1061                          ;          #    #     ####      ####     #    #             #####         #
  1062                          ;
  1063                          ; ==============================================================================
  1064                          
  1065                          room_14:
  1066                          
  1067  141e c9d7                                   cmp #$d7                                    ; foot trap char
  1068  1420 f003                                   beq +                                       ; stepped into it?
  1069  1422 4cf011                                 jmp check_next_char_under_player            ; not... yet...
  1070  1425 a008               +                   ldy #$08                                    ; go die
  1071  1427 4ce83a                                 jmp death                                   ; 08 A foot trap stopped you!
  1072                          
  1073                          
  1074                          
  1075                          
  1076                          
  1077                          
  1078                          ; ==============================================================================
  1079                          ;
  1080                          ;                                                             #      #######
  1081                          ;          #####      ####      ####     #    #              ##      #
  1082                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1083                          ;          #    #    #    #    #    #    # ## #               #      ######
  1084                          ;          #####     #    #    #    #    #    #               #            #
  1085                          ;          #   #     #    #    #    #    #    #               #      #     #
  1086                          ;          #    #     ####      ####     #    #             #####     #####
  1087                          ;
  1088                          ; ==============================================================================
  1089                          
  1090                          room_15:
  1091                          
  1092  142a c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1093  142c b005                                   bcs +
  1094  142e a000                                   ldy #$00                                    ; display hint
  1095  1430 4c2c10                                 jmp prep_and_display_hint
  1096                          
  1097  1433 4cf011             +                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address
  1098                          
  1099                          
  1100                          
  1101                          
  1102                          
  1103                          
  1104                          ; ==============================================================================
  1105                          ;
  1106                          ;                                                             #       #####
  1107                          ;          #####      ####      ####     #    #              ##      #     #
  1108                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1109                          ;          #    #    #    #    #    #    # ## #               #      ######
  1110                          ;          #####     #    #    #    #    #    #               #      #     #
  1111                          ;          #   #     #    #    #    #    #    #               #      #     #
  1112                          ;          #    #     ####      ####     #    #             #####     #####
  1113                          ;
  1114                          ; ==============================================================================
  1115                          
  1116                          room_16:
  1117                          
  1118  1436 c9f4                                   cmp #$f4                                    ; did you hit the wall in the left cell?
  1119  1438 d005                                   bne +                                       ; I did not! -> +
  1120  143a a00a                                   ldy #$0a                                    ; yeah....
  1121  143c 4ce83a                                 jmp death                                   ; 0a You were locked in and starved!
  1122                          
  1123  143f c9d9               +                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
  1124  1441 f004                                   beq +                                       ; not that I know of...
  1125  1443 c9db                                   cmp #$db                                    ; are you sure? take a look at this slightly different wall
  1126  1445 d005                                   bne ++                                      ; it doesn't look familiar... -> ++
  1127                          
  1128  1447 a009               +                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
  1129  1449 4ce83a                                 jmp death
  1130                          
  1131  144c c9b9               ++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
  1132  144e f007                                   beq +                                       ; yes! -> +
  1133  1450 c9bb                                   cmp #$bb                                    ; here's another part of that bottle for reference
  1134  1452 f003                                   beq +                                       ; yes! -> +
  1135  1454 4cf011                                 jmp check_next_char_under_player            ; no, continue
  1136  1457 a003               +                   ldy #$03                                    ; display code enter screen
  1137  1459 4c2c10                                 jmp prep_and_display_hint
  1138                          
  1139                          
  1140                          
  1141                          
  1142                          
  1143                          
  1144                          ; ==============================================================================
  1145                          ;
  1146                          ;                                                             #      #######
  1147                          ;          #####      ####      ####     #    #              ##      #    #
  1148                          ;          #    #    #    #    #    #    ##  ##             # #          #
  1149                          ;          #    #    #    #    #    #    # ## #               #         #
  1150                          ;          #####     #    #    #    #    #    #               #        #
  1151                          ;          #   #     #    #    #    #    #    #               #        #
  1152                          ;          #    #     ####      ####     #    #             #####      #
  1153                          ;
  1154                          ; ==============================================================================
  1155                          
  1156                          room_17:
  1157                          
  1158  145c c9dd                                   cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
  1159  145e f003                                   beq +                                       ; yup
  1160  1460 4cf011                                 jmp check_next_char_under_player            ; nah not yet.
  1161  1463 a9df               +                   lda #$df                                    ; pick up sword
  1162  1465 8dc237                                 sta items + $1a7                            ; store in items list
  1163  1468 4cda11                                 jmp check_death
  1164                          
  1165                          
  1166                          
  1167                          
  1168                          
  1169                          
  1170                          ; ==============================================================================
  1171                          ;
  1172                          ;                                                             #       #####
  1173                          ;          #####      ####      ####     #    #              ##      #     #
  1174                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
  1175                          ;          #    #    #    #    #    #    # ## #               #       #####
  1176                          ;          #####     #    #    #    #    #    #               #      #     #
  1177                          ;          #   #     #    #    #    #    #    #               #      #     #
  1178                          ;          #    #     ####      ####     #    #             #####     #####
  1179                          ;
  1180                          ; ==============================================================================
  1181                          
  1182                          room_18:
  1183  146b c981                                   cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
  1184  146d b003                                   bcs +                   
  1185  146f 4cda11                                 jmp check_death
  1186                          
  1187  1472 ada512             +                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
  1188  1475 d003                                   bne +                                       ; yes I actually did (flexes arms)
  1189  1477 4cda3a                                 jmp main_loop                               ; nope
  1190  147a 202b3a             +                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
  1191  147d 4c451b                                 jmp print_endscreen                         ; (drops mic)
  1192                          
  1193                          
  1194                          
  1195                          
  1196                          
  1197                          
  1198                          
  1199                          
  1200                          
  1201                          
  1202                          
  1203                          
  1204                          
  1205                          
  1206                          
  1207                          
  1208                          
  1209                          
  1210                          
  1211                          
  1212                          
  1213                          
  1214                          
  1215                          
  1216                          
  1217                          
  1218                          
  1219                          
  1220                          
  1221                          
  1222                          
  1223                          
  1224                          
  1225                          
  1226                          
  1227                          
  1228                          
  1229                          
  1230                          
  1231                          
  1232                          
  1233                          ; ==============================================================================
  1234                          ; 
  1235                          ; EVERYTHING ANIMATION RELATED STARTS HERE
  1236                          ; ANIMATIONS FOR
  1237                          ; LASER, BORIS, BELEGRO, STONE, MONSTER
  1238                          ; ==============================================================================
  1239                          
  1240                          ; TODO
  1241                          ; this gets called all the time, no checks 
  1242                          ; needs to be optimized
  1243                          
  1244                          
  1245                          animation_entrypoint:
  1246                                              
  1247                                              ; code below is used to check if the foot traps should be visible
  1248                                              ; it checked for this every single fucking frame
  1249                                              ; moved the foot traps coloring where it belongs (when picking up power outlet)
  1250                                              ;lda items + $ac                         ; $cc (power outlet)
  1251                                              ;cmp #$df                                ; taken?
  1252                                              ;bne +                                   ; no -> +
  1253                                              ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
  1254                                              ;sta items + $12c                        ; originally $0
  1255                          
  1256  1480 acf82f             +                   ldy current_room + 1                    ; load room number
  1257                          
  1258  1483 c011                                   cpy #$11                                ; is it room #17? (Belegro)
  1259  1485 d046                                   bne room_14_prep                         ; no -> m162A
  1260                                              
  1261                                              
  1262  1487 ad1c15                                 lda m14CC + 1                           ; yes, get value from m14CD
  1263  148a d013                                   bne m15FC                               ; 0? -> m15FC
  1264  148c ad4035                                 lda player_pos_y + 1                    ; not 0, get player pos Y
  1265  148f c906                                   cmp #$06                                ; is it 6?
  1266  1491 d00c                                   bne m15FC                               ; no -> m15FC
  1267  1493 ad4235                                 lda player_pos_x + 1                    ; yes, get player pos X
  1268  1496 c918                                   cmp #$18                                ; is player x position $18?
  1269  1498 d005                                   bne m15FC                               ; no -> m15FC
  1270  149a a900                                   lda #$00                                ; yes, load 0
  1271  149c 8da014                                 sta m15FC + 1                           ; store 0 in m15FC+1
  1272  149f a901               m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
  1273  14a1 d016                                   bne +                                   ; is it 0? -> +
  1274  14a3 a006                                   ldy #$06                                ; y = $6
  1275  14a5 a21e               m1602:              ldx #$1e                                ; x = $1e
  1276  14a7 a900                                   lda #$00                                ; a = $0
  1277  14a9 85a7                                   sta zpA7                                ; zpA7 = 0
  1278  14ab 20c734                                 jsr draw_player                         ; TODO
  1279  14ae aea614                                 ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
  1280  14b1 e003                                   cpx #$03                                ; is X = $3?
  1281  14b3 f001                                   beq ++                                  ; yes -> ++
  1282  14b5 ca                                     dex                                     ; x = x -1
  1283  14b6 8ea614             ++                  stx m1602 + 1                           ; store x in m1602+1
  1284  14b9 a978               +                   lda #$78                                ; a = $78
  1285  14bb 85a8                                   sta zpA8                                ; zpA8 = $78
  1286  14bd a949                                   lda #$49                                ; a = $49
  1287  14bf 850a                                   sta zp0A                                ; zp0A = $49
  1288  14c1 a006                                   ldy #$06                                ; y = $06
  1289  14c3 a901                                   lda #$01                                ; a = $01
  1290  14c5 85a7                                   sta zpA7                                ; zpA7 = $01
  1291  14c7 aea614                                 ldx m1602 + 1                           ; get stored x value (should still be the same?)
  1292  14ca 20c734                                 jsr draw_player                         ; TODO
  1293                          
  1294                          
  1295                          room_14_prep:              
  1296  14cd acf82f                                 ldy current_room + 1                    ; load room number
  1297  14d0 c00e                                   cpy #14                                 ; is it #14?
  1298  14d2 d005                                   bne room_15_prep                        ; no -> m148A
  1299  14d4 a020                                   ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
  1300  14d6 20043a                                 jsr wait                                ; was jmp wait before
  1301                          
  1302                          ; ==============================================================================
  1303                          ; ROOM 15 ANIMATION
  1304                          ; MOVEMENT OF THE MONSTER
  1305                          ; ==============================================================================
  1306                          
  1307                          room_15_prep:              
  1308  14d9 c00f                                   cpy #15                                 ; room 15?
  1309  14db d03a                                   bne room_17_prep                        ; no -> m14C8
  1310  14dd a900                                   lda #$00                                ; 
  1311  14df 85a7                                   sta zpA7
  1312  14e1 a00c                                   ldy #$0c                                ; x/y pos of the monster
  1313  14e3 a206               m1494:              ldx #$06
  1314  14e5 20c734                                 jsr draw_player
  1315  14e8 a9eb                                   lda #$eb                                ; the monster (try 9c for Belegro)
  1316  14ea 85a8                                   sta zpA8
  1317  14ec a939                                   lda #$39                                ; color of the monster's cape
  1318  14ee 850a                                   sta zp0A
  1319  14f0 aee414                                 ldx m1494 + 1                           ; self mod the x position of the monster
  1320  14f3 a901               m14A4:              lda #$01
  1321  14f5 d00a                                   bne m14B2               
  1322  14f7 e006                                   cpx #$06                                ; moved 6 steps?
  1323  14f9 d002                                   bne +                                   ; no, keep moving
  1324  14fb a901                                   lda #$01
  1325  14fd ca                 +                   dex
  1326  14fe 4c0815                                 jmp +                                   ; change direction
  1327                          
  1328                          m14B2:              
  1329  1501 e00b                                   cpx #$0b
  1330  1503 d002                                   bne ++
  1331  1505 a900                                   lda #$00
  1332  1507 e8                 ++                  inx
  1333  1508 8ee414             +                   stx m1494 + 1
  1334  150b 8df414                                 sta m14A4 + 1
  1335  150e a901                                   lda #$01
  1336  1510 85a7                                   sta zpA7
  1337  1512 a00c                                   ldy #$0c
  1338  1514 4cc734                                 jmp draw_player
  1339                                             
  1340                          ; ==============================================================================
  1341                          ; ROOM 17 ANIMATION
  1342                          ;
  1343                          ; ==============================================================================
  1344                          
  1345                          room_17_prep:              
  1346  1517 c011                                   cpy #17                             ; room number 17?
  1347  1519 d014                                   bne +                               ; no -> +
  1348  151b a901               m14CC:              lda #$01                            ; selfmod
  1349  151d f021                                   beq ++                              
  1350                                                                                 
  1351                                              ; was moved here
  1352                                              ; as it was called only from this place
  1353                                              ; jmp m15C1  
  1354  151f a900               m15C1:              lda #$00                            ; a = 0 (selfmod)
  1355  1521 c900                                   cmp #$00                            ; is a = 0?
  1356  1523 d004                                   bne skipper                         ; not 0 -> 15CB
  1357  1525 ee2015                                 inc m15C1 + 1                       ; inc m15C1
  1358  1528 60                                     rts
  1359                                       
  1360  1529 ce2015             skipper:            dec m15C1 + 1                       ; dec $15c2
  1361  152c 4cb835                                 jmp belegro_animation
  1362                          
  1363  152f a90f               +                   lda #$0f                            ; a = $0f
  1364  1531 8dbd35                                 sta m3624 + 1                       ; selfmod
  1365  1534 8dbf35                                 sta m3626 + 1                       ; selfmod
  1366                          
  1367                          
  1368  1537 c00a                                   cpy #10                             ; room number 10?
  1369  1539 d044                                   bne check_if_room_09                ; no -> m1523
  1370  153b ceb82f                                 dec speed_byte                      ; yes, reduce speed
  1371  153e f001                                   beq laser_beam_animation            ; if positive -> laser_beam_animation            
  1372  1540 60                 ++                  rts
  1373                          
  1374                          ; ==============================================================================
  1375                          ; ROOM 10
  1376                          ; LASER BEAM ANIMATION
  1377                          ; ==============================================================================
  1378                          
  1379                          laser_beam_animation:
  1380                          
  1381  1541 a008                                   ldy #$08                            ; speed of the laser flashing
  1382  1543 8cb82f                                 sty speed_byte                      ; store     
  1383  1546 a909                                   lda #$09
  1384  1548 8505                                   sta zp05                            ; affects the colram of the laser
  1385  154a a90d                                   lda #$0d                            ; but not understood yet
  1386  154c 8503                                   sta zp03
  1387  154e a97b                                   lda #$7b                            ; position of the laser
  1388  1550 8502                                   sta zp02
  1389  1552 8504                                   sta zp04
  1390  1554 a9df                                   lda #$df                            ; laser beam off
  1391  1556 cd6315                                 cmp m1506 + 1                       
  1392  1559 d002                                   bne +                               
  1393  155b a9d8                                   lda #$d8                            ; laser beam
  1394  155d 8d6315             +                   sta m1506 + 1                       
  1395  1560 a206                                   ldx #$06                            ; 6 laser beam characters
  1396  1562 a9df               m1506:              lda #$df
  1397  1564 a000                                   ldy #$00
  1398  1566 9102                                   sta (zp02),y
  1399  1568 a9ee                                   lda #$ee
  1400  156a 9104                                   sta (zp04),y
  1401  156c a502                                   lda zp02
  1402  156e 18                                     clc
  1403  156f 6928                                   adc #$28                            ; draws the laser beam
  1404  1571 8502                                   sta zp02
  1405  1573 8504                                   sta zp04
  1406  1575 9004                                   bcc +                               
  1407  1577 e603                                   inc zp03
  1408  1579 e605                                   inc zp05
  1409  157b ca                 +                   dex
  1410  157c d0e4                                   bne m1506                           
  1411  157e 60                 -                   rts
  1412                          
  1413                          ; ==============================================================================
  1414                          
  1415                          check_if_room_09:              
  1416  157f c009                                   cpy #09                         ; room number 09?
  1417  1581 f001                                   beq room_09_counter                           ; yes -> +
  1418  1583 60                                     rts                             ; no
  1419                          
  1420                          room_09_counter:
  1421  1584 a201                                   ldx #$01                                ; x = 1 (selfmod)
  1422  1586 e001                                   cpx #$01                                ; is x = 1?
  1423  1588 f003                                   beq +                                   ; yes -> +
  1424  158a 4ca515                                 jmp boris_the_spider_animation          ; no, jump boris animation
  1425  158d ce8515             +                   dec room_09_counter + 1                 ; decrease initial x
  1426  1590 60                                     rts
  1427                          
  1428                          ; ==============================================================================
  1429                          ;
  1430                          ; I moved this out of the main loop and call it once when changing rooms
  1431                          ; TODO: call it only when room 4 is entered
  1432                          ; ==============================================================================
  1433                          
  1434                          room_04_prep_door:
  1435                                              
  1436  1591 adf82f                                 lda current_room + 1                            ; get current room
  1437  1594 c904                                   cmp #04                                         ; is it 4? (coffins)
  1438  1596 d00c                                   bne ++                                          ; nope
  1439  1598 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  1440  159a ac0839                                 ldy m394A + 1                                   ; 
  1441  159d f002                                   beq +
  1442  159f a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  1443  15a1 8df904             +                   sta SCREENRAM + $f9 
  1444  15a4 60                 ++                  rts
  1445                          
  1446                          ; ==============================================================================
  1447                          ; ROOM 09
  1448                          ; BORIS THE SPIDER ANIMATION
  1449                          ; ==============================================================================
  1450                          
  1451                          boris_the_spider_animation:
  1452                          
  1453  15a5 ee8515                                 inc room_09_counter + 1                           
  1454  15a8 a908                                   lda #$08                                ; affects the color ram position for boris the spider
  1455  15aa 8505                                   sta zp05
  1456  15ac a90c                                   lda #$0c
  1457  15ae 8503                                   sta zp03
  1458  15b0 a90f                                   lda #$0f
  1459  15b2 8502                                   sta zp02
  1460  15b4 8504                                   sta zp04
  1461  15b6 a206               m1535:              ldx #$06
  1462  15b8 a900               m1537:              lda #$00
  1463  15ba d009                                   bne +
  1464  15bc ca                                     dex
  1465  15bd e002                                   cpx #$02
  1466  15bf d00b                                   bne ++
  1467  15c1 a901                                   lda #$01
  1468  15c3 d007                                   bne ++
  1469  15c5 e8                 +                   inx
  1470  15c6 e007                                   cpx #$07
  1471  15c8 d002                                   bne ++
  1472  15ca a900                                   lda #$00
  1473  15cc 8db915             ++                  sta m1537 + 1
  1474  15cf 8eb715                                 stx m1535 + 1
  1475  15d2 a000               -                   ldy #$00
  1476  15d4 a9df                                   lda #$df
  1477  15d6 9102                                   sta (zp02),y
  1478  15d8 c8                                     iny
  1479  15d9 c8                                     iny
  1480  15da 9102                                   sta (zp02),y
  1481  15dc 88                                     dey
  1482  15dd a9ea                                   lda #$ea
  1483  15df 9102                                   sta (zp02),y
  1484  15e1 9104                                   sta (zp04),y
  1485  15e3 201e16                                 jsr move_boris                       
  1486  15e6 ca                                     dex
  1487  15e7 d0e9                                   bne -
  1488  15e9 a9e4                                   lda #$e4
  1489  15eb 85a8                                   sta zpA8
  1490  15ed a202                                   ldx #$02
  1491  15ef a000               --                  ldy #$00
  1492  15f1 a5a8               -                   lda zpA8
  1493  15f3 9102                                   sta (zp02),y
  1494  15f5 a9da                                   lda #$da
  1495  15f7 9104                                   sta (zp04),y
  1496  15f9 e6a8                                   inc zpA8
  1497  15fb c8                                     iny
  1498  15fc c003                                   cpy #$03
  1499  15fe d0f1                                   bne -
  1500  1600 201e16                                 jsr move_boris                       
  1501  1603 ca                                     dex
  1502  1604 d0e9                                   bne --
  1503  1606 a000                                   ldy #$00
  1504  1608 a9e7                                   lda #$e7
  1505  160a 85a8                                   sta zpA8
  1506  160c b102               -                   lda (zp02),y
  1507  160e c5a8                                   cmp zpA8
  1508  1610 d004                                   bne +
  1509  1612 a9df                                   lda #$df
  1510  1614 9102                                   sta (zp02),y
  1511  1616 e6a8               +                   inc zpA8
  1512  1618 c8                                     iny
  1513  1619 c003                                   cpy #$03
  1514  161b d0ef                                   bne -
  1515  161d 60                                     rts
  1516                          
  1517                          ; ==============================================================================
  1518                          
  1519                          move_boris:
  1520  161e a502                                   lda zp02
  1521  1620 18                                     clc
  1522  1621 6928                                   adc #$28
  1523  1623 8502                                   sta zp02
  1524  1625 8504                                   sta zp04
  1525  1627 9004                                   bcc +                                   
  1526  1629 e603                                   inc zp03
  1527  162b e605                                   inc zp05
  1528  162d 60                 +                   rts
  1529                          
  1530                          
  1531                          
  1532                          
  1533                          
  1534                          
  1535                          
  1536                          
  1537                          
  1538                          
  1539                          
  1540                          
  1541                          
  1542                          
  1543                          
  1544                          
  1545                          
  1546                          
  1547                          
  1548                          
  1549                          ; ==============================================================================
  1550                          
  1551                          prep_player_pos:
  1552                          
  1553  162e a209                                   ldx #$09
  1554  1630 bd4403             -                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
  1555  1633 9d5403                                 sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
  1556  1636 ca                                     dex
  1557  1637 d0f7                                   bne -                                   ; so this seems to create a copy of the area under the player
  1558                          
  1559  1639 a902                                   lda #$02                                ; a = 2
  1560  163b 85a7                                   sta zpA7
  1561  163d ae4235                                 ldx player_pos_x + 1                    ; x = player x
  1562  1640 ac4035                                 ldy player_pos_y + 1                    ; y = player y
  1563  1643 20c734                                 jsr draw_player                         ; draw player
  1564  1646 60                                     rts
  1565                          
  1566                          
  1567                          
  1568                          
  1569                          
  1570                          
  1571                          
  1572                          
  1573                          
  1574                          
  1575                          
  1576                          
  1577                          
  1578                          
  1579                          
  1580                          
  1581                          
  1582                          
  1583                          
  1584                          
  1585                          
  1586                          ; ==============================================================================
  1587                          ; OBJECT ANIMATION COLLISION ROUTINE
  1588                          ; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
  1589                          ; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
  1590                          ; ==============================================================================
  1591                          
  1592                          object_collision:
  1593                          
  1594  1647 a209                                   ldx #$09                                ; x = 9
  1595                          
  1596                          check_loop:              
  1597                          
  1598  1649 bd4403                                 lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1599  164c c9d8                                   cmp #$d8                                ; check for laser beam
  1600  164e d005                                   bne +                  
  1601                          
  1602  1650 a005               m164E:              ldy #$05
  1603  1652 4ce83a             jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?
  1604                          
  1605  1655 acf82f             +                   ldy current_room + 1                    ; get room number
  1606  1658 c011                                   cpy #17                                 ; is it $11 = #17 (Belegro)?
  1607  165a d010                                   bne +                                   ; nope -> +
  1608  165c c978                                   cmp #$78                                ; hit by the stone?
  1609  165e f008                                   beq ++                                  ; yep -> ++
  1610  1660 c97b                                   cmp #$7b                                ; or another part of the stone?
  1611  1662 f004                                   beq ++                                  ; yes -> ++
  1612  1664 c97e                                   cmp #$7e                                ; or another part of the stone?
  1613  1666 d004                                   bne +                                   ; nah, -> +
  1614  1668 a00b               ++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
  1615  166a d0e6                                   bne jmp_death
  1616  166c c99c               +                   cmp #$9c                                ; so Belegro hit you?
  1617  166e 9007                                   bcc m1676
  1618  1670 c9a5                                   cmp #$a5
  1619  1672 b003                                   bcs m1676
  1620  1674 4ca816                                 jmp m16A7
  1621                          
  1622  1677 c9e4               m1676:              cmp #$e4                                ; hit by Boris the spider?
  1623  1679 9010                                   bcc +                           
  1624  167b c9eb                                   cmp #$eb
  1625  167d b004                                   bcs ++                          
  1626  167f a004               -                   ldy #$04                                ; 04 Boris the spider got you and killed you
  1627  1681 d0cf                                   bne jmp_death                       
  1628  1683 c9f4               ++                  cmp #$f4
  1629  1685 b004                                   bcs +                           
  1630  1687 a00e                                   ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
  1631  1689 d0c7                                   bne jmp_death                       
  1632  168b ca                 +                   dex
  1633  168c d0bb                                   bne check_loop   
  1634                          
  1635                          
  1636                          
  1637  168e a209                                   ldx #$09
  1638  1690 bd5403             --                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
  1639  1693 9d4403                                 sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1640  1696 c9d8                                   cmp #$d8
  1641  1698 f0b6                                   beq m164E                       
  1642  169a c9e4                                   cmp #$e4
  1643  169c 9004                                   bcc +                           
  1644  169e c9ea                                   cmp #$ea
  1645  16a0 90dd                                   bcc -                           
  1646  16a2 ca                 +                   dex
  1647  16a3 d0eb                                   bne --                          
  1648  16a5 4ce011                                 jmp m11E0                     
  1649                          
  1650                          m16A7:
  1651  16a8 acc237                                 ldy items + $1a7                        ; do you have the sword?
  1652  16ab c0df                                   cpy #$df
  1653  16ad f004                                   beq +                                   ; yes -> +                        
  1654  16af a00c                                   ldy #$0c                                ; 0c Belegro killed you!
  1655  16b1 d09f                                   bne jmp_death                       
  1656  16b3 a000               +                   ldy #$00
  1657  16b5 8c1c15                                 sty m14CC + 1                   
  1658  16b8 4c7716                                 jmp m1676                       
  1659                          
  1660                          
  1661                          
  1662                          
  1663                          
  1664                          
  1665                          
  1666                          
  1667                          
  1668                          
  1669                          
  1670                          
  1671                          
  1672                          
  1673                          
  1674                          
  1675                          
  1676                          
  1677                          
  1678                          
  1679                          
  1680                          
  1681                          
  1682                          
  1683                          
  1684                          
  1685                          
  1686                          
  1687                          
  1688                          
  1689                          
  1690                          
  1691                          
  1692                          
  1693                          
  1694                          
  1695                          
  1696                          ; ==============================================================================
  1697                          ; this might be the inventory/ world reset
  1698                          ; puts all items into the level data again
  1699                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1700                          ; addresses are mostly within items.asm address space ( $368a )
  1701                          ; contains color information of the chars
  1702                          ; ==============================================================================
  1703                          
  1704                          reset_items:
  1705  16bb a9a5                                   lda #$a5                        ; $a5 = lock of the shed
  1706  16bd 8d5336                                 sta items + $38
  1707                          
  1708  16c0 a9a9                                   lda #$a9                        ;
  1709  16c2 8d2336                                 sta items + $8                  ; gloves
  1710  16c5 a979                                   lda #$79
  1711  16c7 8d2136                                 sta items + $6                  ; gloves color
  1712                          
  1713  16ca a9e0                                   lda #$e0                        ; empty char
  1714  16cc 8d2b36                                 sta items + $10                 ; invisible key
  1715                          
  1716  16cf a9ac                                   lda #$ac                        ; wirecutter
  1717  16d1 8d3436                                 sta items + $19
  1718                          
  1719  16d4 a9b8                                   lda #$b8                        ; bottle
  1720  16d6 8d4436                                 sta items + $29
  1721                          
  1722  16d9 a9b0                                   lda #$b0                        ; ladder
  1723  16db 8d6836                                 sta items + $4d
  1724  16de a9b5                                   lda #$b5                        ; more ladder
  1725  16e0 8d7336                                 sta items + $58
  1726                          
  1727  16e3 a95e                                   lda #$5e                        ; seems to be water?
  1728  16e5 8d8f36                                 sta items + $74
  1729                          
  1730  16e8 a9c6                                   lda #$c6                        ; boots in the whatever box
  1731  16ea 8d9f36                                 sta items + $84
  1732                          
  1733  16ed a9c0                                   lda #$c0                        ; shovel
  1734  16ef 8db136                                 sta items + $96
  1735                          
  1736  16f2 a9cc                                   lda #$cc                        ; power outlet
  1737  16f4 8dc736                                 sta items + $ac
  1738                          
  1739  16f7 a9d0                                   lda #$d0                        ; hammer
  1740  16f9 8dd636                                 sta items + $bb
  1741                          
  1742  16fc a9d2                                   lda #$d2                        ; light bulb
  1743  16fe 8de336                                 sta items + $c8
  1744                          
  1745  1701 a9d6                                   lda #$d6                        ; nails
  1746  1703 8df036                                 sta items + $d5
  1747                          
  1748  1706 a900                                   lda #$00                        ; door
  1749  1708 8d4737                                 sta items + $12c
  1750                          
  1751  170b a9dd                                   lda #$dd                        ; sword
  1752  170d 8dc237                                 sta items + $1a7
  1753                          
  1754  1710 a901                                   lda #$01                        ; -> wrong write, produced selfmod at the wrong place
  1755  1712 8d0839                                 sta m394A + 1                   ; sta items + $2c1
  1756                          
  1757  1715 a901                                   lda #$01                        ; 
  1758  1717 8d9638                                 sta breathing_tube_mod + 1      ; sta items + $30a
  1759                          
  1760  171a a9f5                                   lda #$f5                        ; fence
  1761  171c 8dba38                                 sta delete_fence + 1            ; sta items + $277
  1762                          
  1763  171f a900                                   lda #$00                        ; key in the bottle
  1764  1721 8da512                                 sta key_in_bottle_storage
  1765                          
  1766  1724 a901                                   lda #$01                        ; door
  1767  1726 8da014                                 sta m15FC + 1
  1768                          
  1769  1729 a91e                                   lda #$1e
  1770  172b 8da614                                 sta m1602 + 1
  1771                          
  1772  172e a901                                   lda #$01
  1773  1730 8d1c15                                 sta m14CC + 1
  1774                          
  1775  1733 a205               m1732:              ldx #$05
  1776  1735 e007                                   cpx #$07
  1777  1737 d002                                   bne +
  1778  1739 a2ff                                   ldx #$ff
  1779  173b e8                 +                   inx
  1780  173c 8e3417                                 stx m1732 + 1                           ; stx $1733
  1781  173f bd4817                                 lda m1747,x                             ; lda $1747,x
  1782  1742 8d1039                                 sta m3952 + 1                   ; sta $3953
  1783  1745 4cb030                                 jmp print_title     ; jmp $310d
  1784                                              
  1785                          ; ==============================================================================
  1786                          
  1787                          m1747:
  1788  1748 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1789                          
  1790                          
  1791                          m174F:
  1792  1750 e00c                                   cpx #$0c
  1793  1752 d002                                   bne +
  1794  1754 a949                                   lda #$49
  1795  1756 e00d               +                   cpx #$0d
  1796  1758 d002                                   bne +
  1797  175a a945                                   lda #$45
  1798  175c 60                 +                   rts
  1799                          
  1800                          
  1801                          
  1802                          screen_win_src:
  1803                                              !if LANGUAGE = EN{
  1804  175d 7040404040404040...                        !bin "includes/screen-win-en.scr"
  1805                                              }
  1806                                              !if LANGUAGE = DE{
  1807                                                  !bin "includes/screen-win-de.scr"
  1808                                              }
  1809                          screen_win_src_end:
  1810                          
  1811                          
  1812                          ; ==============================================================================
  1813                          ;
  1814                          ; PRINT WIN SCREEN
  1815                          ; ==============================================================================
  1816                          
  1817                          print_endscreen:
  1818  1b45 a904                                   lda #>SCREENRAM
  1819  1b47 8503                                   sta zp03
  1820  1b49 a9d8                                   lda #>COLRAM
  1821  1b4b 8505                                   sta zp05
  1822  1b4d a900                                   lda #<SCREENRAM
  1823  1b4f 8502                                   sta zp02
  1824  1b51 8504                                   sta zp04
  1825  1b53 a204                                   ldx #$04
  1826  1b55 a917                                   lda #>screen_win_src
  1827  1b57 85a8                                   sta zpA8
  1828  1b59 a95d                                   lda #<screen_win_src
  1829  1b5b 85a7                                   sta zpA7
  1830  1b5d a000                                   ldy #$00
  1831  1b5f b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1832  1b61 9102                                   sta (zp02),y        ; to SCREEN
  1833  1b63 a900                                   lda #$00           ; color = BLACK
  1834  1b65 9104                                   sta (zp04),y        ; to COLRAM
  1835  1b67 c8                                     iny
  1836  1b68 d0f5                                   bne -
  1837  1b6a e603                                   inc zp03
  1838  1b6c e605                                   inc zp05
  1839  1b6e e6a8                                   inc zpA8
  1840  1b70 ca                                     dex
  1841  1b71 d0ec                                   bne -
  1842  1b73 a9ff                                   lda #$ff           ; PISSGELB
  1843  1b75 8d21d0                                 sta BG_COLOR          ; background
  1844  1b78 8d20d0                                 sta BORDER_COLOR          ; und border
  1845  1b7b a9fd               -                   lda #$fd
  1846  1b7d 8d08ff                                 sta KEYBOARD_LATCH
  1847  1b80 ad08ff                                 lda KEYBOARD_LATCH
  1848  1b83 2980                                   and #$80           ; WAITKEY?
  1849  1b85 d0f4                                   bne -
  1850  1b87 20b030                                 jsr print_title
  1851  1b8a 20b030                                 jsr print_title
  1852  1b8d 4c473a                                 jmp init
  1853                          
  1854                          
  1855                          ; ==============================================================================
  1856                          ;
  1857                          ; INTRO TEXT SCREEN
  1858                          ; ==============================================================================
  1859                          
  1860                          intro_text:
  1861                          
  1862                          ; instructions screen
  1863                          ; "Search the treasure..."
  1864                          
  1865                          !if LANGUAGE = EN{
  1866  1b90 5305011203082014...!scr "Search the treasure of Ghost Town and   "
  1867  1bb8 0f10050e20091420...!scr "open it ! Kill Belegro, the wizard, and "
  1868  1be0 040f04070520010c...!scr "dodge all other dangers. Don't forget to"
  1869  1c08 15130520010c0c20...!scr "use all the items you'll find during    "
  1870  1c30 190f1512200a0f15...!scr "your journey through 19 amazing hires-  "
  1871  1c58 0712011008090313...!scr "graphics-rooms! Enjoy the quest and play"
  1872  1c80 091420010701090e...!scr "it again and again and again ...      > "
  1873                          }
  1874                          
  1875                          !if LANGUAGE = DE{
  1876                          !scr "Suchen Sie die Schatztruhe der Geister- "
  1877                          !scr "stadt und oeffnen Sie diese ! Toeten    "
  1878                          !scr "Sie Belegro, den Zauberer und weichen   "
  1879                          !scr "Sie vielen anderen Wesen geschickt aus. "
  1880                          !scr "Bedienen Sie sich an den vielen Gegen-  "
  1881                          !scr "staenden, welche sich in den 19 Bildern "
  1882                          !scr "befinden. Viel Spass !                > "
  1883                          }
  1884                          
  1885                          ; ==============================================================================
  1886                          ;
  1887                          ; DISPLAY INTRO TEXT
  1888                          ; ==============================================================================
  1889                          
  1890                          display_intro_text:
  1891                          
  1892                                              ; i think this part displays the introduction text
  1893                          
  1894  1ca8 a904                                   lda #>SCREENRAM       ; lda #$0c
  1895  1caa 8503                                   sta zp03
  1896  1cac a9d8                                   lda #>COLRAM        ; lda #$08
  1897  1cae 8505                                   sta zp05
  1898  1cb0 a9a0                                   lda #$a0
  1899  1cb2 8502                                   sta zp02
  1900  1cb4 8504                                   sta zp04
  1901  1cb6 a91b                                   lda #>intro_text
  1902  1cb8 85a8                                   sta zpA8
  1903  1cba a990                                   lda #<intro_text
  1904  1cbc 85a7                                   sta zpA7
  1905  1cbe a207                                   ldx #$07
  1906  1cc0 a000               --                  ldy #$00
  1907  1cc2 b1a7               -                   lda (zpA7),y
  1908  1cc4 9102                                   sta (zp02),y
  1909  1cc6 a968                                   lda #$68
  1910  1cc8 9104                                   sta (zp04),y
  1911  1cca c8                                     iny
  1912  1ccb c028                                   cpy #$28
  1913  1ccd d0f3                                   bne -
  1914  1ccf a5a7                                   lda zpA7
  1915  1cd1 18                                     clc
  1916  1cd2 6928                                   adc #$28
  1917  1cd4 85a7                                   sta zpA7
  1918  1cd6 9002                                   bcc +
  1919  1cd8 e6a8                                   inc zpA8
  1920  1cda a502               +                   lda zp02
  1921  1cdc 18                                     clc
  1922  1cdd 6950                                   adc #$50
  1923  1cdf 8502                                   sta zp02
  1924  1ce1 8504                                   sta zp04
  1925  1ce3 9004                                   bcc +
  1926  1ce5 e603                                   inc zp03
  1927  1ce7 e605                                   inc zp05
  1928  1ce9 ca                 +                   dex
  1929  1cea d0d4                                   bne --
  1930  1cec a900                                   lda #$00
  1931  1cee 8d21d0                                 sta BG_COLOR
  1932  1cf1 60                                     rts
  1933                          
  1934                          ; ==============================================================================
  1935                          ;
  1936                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1937                          ; DECREASES MUSIC VOLUME
  1938                          ; ==============================================================================
  1939                          
  1940                          start_intro:        ;sta KEYBOARD_LATCH
  1941  1cf2 20d2ff                                 jsr PRINT_KERNAL
  1942  1cf5 20a81c                                 jsr display_intro_text
  1943  1cf8 20d41e                                 jsr check_shift_key
  1944                                              
  1945                                              ;lda #$ba
  1946                                              ;sta music_volume+1                          ; sound volume
  1947  1cfb 60                                     rts
  1948                          
  1949                          
  1950                          
  1951                          
  1952                          
  1953                          
  1954                          
  1955                          
  1956                          
  1957                          
  1958                          
  1959                          
  1960                          
  1961                          
  1962                          
  1963                          
  1964                          
  1965                          
  1966                          
  1967                          
  1968                          
  1969                          
  1970                          
  1971                          
  1972                          
  1973                          
  1974                          
  1975                          
  1976                          
  1977                          
  1978                          
  1979                          
  1980                          
  1981                          
  1982                          ; ==============================================================================
  1983                          ; MUSIC
  1984                          ; ==============================================================================
  1985                                              !zone MUSIC

; ******** Source: includes/music_data.asm
     1                          ; music! :)
     2                          
     3                          music_data_voice1:
     4  1cfc 8445434425262526...!byte $84, $45, $43, $44, $25, $26, $25, $26, $27, $24, $4b, $2c, $2d
     5  1d09 2c2d2e2b44252625...!byte $2c, $2d, $2e, $2b, $44, $25, $26, $25, $26, $27, $24, $46, $64, $66, $47, $67
     6  1d19 6746646647676727...!byte $67, $46, $64, $66, $47, $67, $67, $27, $29, $27, $49, $67, $44, $66, $64, $27
     7  1d29 2927496744666432...!byte $29, $27, $49, $67, $44, $66, $64, $32, $35, $32, $50, $6e, $2f, $30, $31, $30
     8  1d39 3132312f2f4f504f...!byte $31, $32, $31, $2f, $2f, $4f, $50, $4f, $2e, $2f, $30, $31, $30, $31, $32, $31
     9  1d49 2f4f6d6b4e6c6a4f...!byte $2f, $4f, $6d, $6b, $4e, $6c, $6a, $4f, $6d, $6b, $4e, $6c, $6a
    10                          
    11                          music_data_voice2:
    12  1d56 923133             !byte $92, $31, $33
    13  1d59 3131523334333435...!byte $31, $31, $52, $33, $34, $33, $34, $35, $32, $54, $32, $52, $75, $54, $32, $52
    14  1d69 758d8d2c2dce8d8d...!byte $75, $8d, $8d, $2c, $2d, $ce, $8d, $8d, $2c, $2d, $ce, $75, $34, $32, $30, $2e
    15  1d79 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $35, $32, $35, $32, $35, $32, $2e
    16  1d89 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $4b, $69, $67, $4c, $6a, $68, $4b
    17  1d99 69674c6a68323332...!byte $69, $67, $4c, $6a, $68, $32, $33, $32, $b2, $33, $31, $32, $33, $34, $35, $36
    18  1da9 3533323131323334...!byte $35, $33, $32, $31, $31, $32, $33, $34, $33, $34, $35, $36, $35, $36, $37, $36
    19  1db9 ea                 !byte $ea

; ******** Source: main.asm
  1987                          ; ==============================================================================
  1988                          music_get_data:
  1989  1dba a000               .voice1_dur_pt:     ldy #$00
  1990  1dbc d01d                                   bne +
  1991  1dbe a940                                   lda #$40
  1992  1dc0 8d211e                                 sta music_voice1+1
  1993  1dc3 20201e                                 jsr music_voice1
  1994  1dc6 a200               .voice1_dat_pt:     ldx #$00
  1995  1dc8 bdfc1c                                 lda music_data_voice1,x
  1996  1dcb eec71d                                 inc .voice1_dat_pt+1
  1997  1dce a8                                     tay
  1998  1dcf 291f                                   and #$1f
  1999  1dd1 8d211e                                 sta music_voice1+1
  2000  1dd4 98                                     tya
  2001  1dd5 4a                                     lsr
  2002  1dd6 4a                                     lsr
  2003  1dd7 4a                                     lsr
  2004  1dd8 4a                                     lsr
  2005  1dd9 4a                                     lsr
  2006  1dda a8                                     tay
  2007  1ddb 88                 +                   dey
  2008  1ddc 8cbb1d                                 sty .voice1_dur_pt + 1
  2009  1ddf a000               .voice2_dur_pt:     ldy #$00
  2010  1de1 d022                                   bne +
  2011  1de3 a940                                   lda #$40
  2012  1de5 8d491e                                 sta music_voice2 + 1
  2013  1de8 20481e                                 jsr music_voice2
  2014  1deb a200               .voice2_dat_pt:     ldx #$00
  2015  1ded bd561d                                 lda music_data_voice2,x
  2016  1df0 a8                                     tay
  2017  1df1 e8                                     inx
  2018  1df2 e065                                   cpx #$65
  2019  1df4 f019                                   beq music_reset
  2020  1df6 8eec1d                                 stx .voice2_dat_pt + 1
  2021  1df9 291f                                   and #$1f
  2022  1dfb 8d491e                                 sta music_voice2 + 1
  2023  1dfe 98                                     tya
  2024  1dff 4a                                     lsr
  2025  1e00 4a                                     lsr
  2026  1e01 4a                                     lsr
  2027  1e02 4a                                     lsr
  2028  1e03 4a                                     lsr
  2029  1e04 a8                                     tay
  2030  1e05 88                 +                   dey
  2031  1e06 8ce01d                                 sty .voice2_dur_pt + 1
  2032  1e09 20201e                                 jsr music_voice1
  2033  1e0c 4c481e                                 jmp music_voice2
  2034                          ; ==============================================================================
  2035  1e0f a900               music_reset:        lda #$00
  2036  1e11 8dbb1d                                 sta .voice1_dur_pt + 1
  2037  1e14 8dc71d                                 sta .voice1_dat_pt + 1
  2038  1e17 8de01d                                 sta .voice2_dur_pt + 1
  2039  1e1a 8dec1d                                 sta .voice2_dat_pt + 1
  2040  1e1d 4cba1d                                 jmp music_get_data
  2041                          ; ==============================================================================
  2042                          ; write music data for voice1 / voice2 into TED registers
  2043                          ; ==============================================================================
  2044  1e20 a204               music_voice1:       ldx #$04
  2045  1e22 e01c                                   cpx #$1c
  2046  1e24 9008                                   bcc +
  2047  1e26 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2048  1e29 29ef                                   and #$ef
  2049  1e2b 4c441e                                 jmp writeFF11
  2050  1e2e bd701e             +                   lda freq_tab_lo,x
  2051  1e31 8d0eff                                 sta VOICE1_FREQ_LOW
  2052  1e34 ad12ff                                 lda VOICE1
  2053  1e37 29fc                                   and #$fc
  2054  1e39 1d881e                                 ora freq_tab_hi, x
  2055  1e3c 8d12ff                                 sta VOICE1
  2056  1e3f ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2057  1e42 0910                                   ora #$10
  2058  1e44 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  2059  1e47 60                                     rts
  2060                          ; ==============================================================================
  2061  1e48 a20d               music_voice2:       ldx #$0d
  2062  1e4a e01c                                   cpx #$1c
  2063  1e4c 9008                                   bcc +
  2064  1e4e ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2065  1e51 29df                                   and #$df
  2066  1e53 4c441e                                 jmp writeFF11
  2067  1e56 bd701e             +                   lda freq_tab_lo,x
  2068  1e59 8d0fff                                 sta VOICE2_FREQ_LOW
  2069  1e5c ad10ff                                 lda VOICE2
  2070  1e5f 29fc                                   and #$fc
  2071  1e61 1d881e                                 ora freq_tab_hi,x
  2072  1e64 8d10ff                                 sta VOICE2
  2073  1e67 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2074  1e6a 0920                                   ora #$20
  2075  1e6c 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2076  1e6f 60                                     rts
  2077                          ; ==============================================================================
  2078                          ; TED frequency tables
  2079                          ; ==============================================================================
  2080  1e70 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  2081  1e77 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  2082  1e7e 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  2083  1e85 818f95                                 !byte $81, $8f, $95
  2084  1e88 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  2085  1e8f 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  2086  1e96 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  2087  1e9d 030303                                 !byte $03, $03, $03
  2088                          ; ==============================================================================
  2089                                              MUSIC_DELAY_INITIAL   = $09
  2090                                              MUSIC_DELAY           = $0B
  2091  1ea0 a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  2092  1ea2 ca                                     dex
  2093  1ea3 8ea11e                                 stx music_play+1
  2094  1ea6 f001                                   beq +
  2095  1ea8 60                                     rts
  2096  1ea9 a20b               +                   ldx #MUSIC_DELAY
  2097  1eab 8ea11e                                 stx music_play+1
  2098  1eae ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2099  1eb1 0937                                   ora #$37
  2100  1eb3 29bf               music_volume:       and #$bf
  2101  1eb5 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2102  1eb8 4cba1d                                 jmp music_get_data
  2103                          
  2104                          
  2105                          
  2106                          
  2107                          
  2108                          
  2109                          
  2110                          
  2111                          
  2112                          
  2113                          
  2114                          
  2115                          
  2116                          
  2117                          
  2118                          
  2119                          
  2120                          
  2121                          
  2122                          
  2123                          
  2124                          
  2125                          
  2126                          
  2127                          
  2128                          
  2129                          
  2130                          
  2131                          
  2132                          
  2133                          
  2134                          
  2135                          ; ==============================================================================
  2136                          ; irq init
  2137                          ; ==============================================================================
  2138                                              !zone IRQ
  2139  1ebb 78                 irq_init0:          sei
  2140  1ebc a9db                                   lda #<irq0          ; lda #$06
  2141  1ebe 8d1403                                 sta $0314          ; irq lo
  2142  1ec1 a91e                                   lda #>irq0          ; lda #$1f
  2143  1ec3 8d1503                                 sta $0315          ; irq hi
  2144                                                                  ; irq at $1F06
  2145  1ec6 a902                                   lda #$02
  2146  1ec8 8d0aff                                 sta FF0A          ; set IRQ source to RASTER
  2147                          
  2148  1ecb a9bf                                   lda #$bf
  2149  1ecd 8db41e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  2150  1ed0 58                                     cli
  2151                          
  2152  1ed1 4c2b3a                                 jmp set_charset_and_screen
  2153                          
  2154                          ; ==============================================================================
  2155                          ; intro text
  2156                          ; wait for shift or joy2 fire press
  2157                          ; ==============================================================================
  2158                          
  2159                          check_shift_key:
  2160                          
  2161  1ed4 a5cb               -                   lda $cb
  2162  1ed6 c93c                                   cmp #$3c
  2163  1ed8 d0fa                                   bne -
  2164  1eda 60                                     rts
  2165                          
  2166                          ; ==============================================================================
  2167                          ;
  2168                          ; INTERRUPT routine for music
  2169                          ; ==============================================================================
  2170                          
  2171                                              ; *= $1F06
  2172                          irq0:
  2173  1edb ce09ff                                 DEC INTERRUPT
  2174                          
  2175                                                                  ; this IRQ seems to handle music only!
  2176                                              !if SILENT_MODE = 1 {
  2177                                                  jsr fake
  2178                                              } else {
  2179  1ede 20a01e                                     jsr music_play
  2180                                              }
  2181  1ee1 68                                     pla
  2182  1ee2 a8                                     tay
  2183  1ee3 68                                     pla
  2184  1ee4 aa                                     tax
  2185  1ee5 68                                     pla
  2186  1ee6 40                                     rti
  2187                          
  2188                          ; ==============================================================================
  2189                          ; checks if the music volume is at the desired level
  2190                          ; and increases it if not
  2191                          ; if volume is high enough, it initializes the music irq routine
  2192                          ; is called right at the start of the game, but also when a game ended
  2193                          ; and is about to show the title screen again (increasing the volume)
  2194                          ; ==============================================================================
  2195                          
  2196                          init_music:                                  
  2197  1ee7 adb41e                                 lda music_volume+1                              ; sound volume
  2198  1eea c9bf               --                  cmp #$bf                                        ; is true on init
  2199  1eec d003                                   bne +
  2200  1eee 4cbb1e                                 jmp irq_init0
  2201  1ef1 a204               +                   ldx #$04
  2202  1ef3 86a8               -                   stx zpA8                                        ; buffer serial input byte ?
  2203  1ef5 a0ff                                   ldy #$ff
  2204  1ef7 20043a                                 jsr wait
  2205  1efa a6a8                                   ldx zpA8
  2206  1efc ca                                     dex
  2207  1efd d0f4                                   bne -                                               
  2208  1eff 18                                     clc
  2209  1f00 6901                                   adc #$01                                        ; increases volume again before returning to title screen
  2210  1f02 8db41e                                 sta music_volume+1                              ; sound volume
  2211  1f05 4cea1e                                 jmp --
  2212                          
  2213                          
  2214                          
  2215                                              ; 222222222222222         000000000          000000000          000000000
  2216                                              ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
  2217                                              ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2218                                              ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2219                                              ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2220                                              ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2221                                              ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2222                                              ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2223                                              ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2224                                              ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2225                                              ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2226                                              ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2227                                              ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2228                                              ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2229                                              ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
  2230                                              ;22222222222222222222     000000000          000000000          000000000
  2231                          
  2232                          ; ==============================================================================
  2233                          ; CHARSET
  2234                          ; $2000 - $2800
  2235                          ; ==============================================================================
  2236                          
  2237                          
  2238                          charset_start:
  2239                                              *= $2000
  2240                                              !if EXTENDED {
  2241                                                  !bin "includes/charset-new-charset.bin"
  2242                                              }else{
  2243  2000 000000020a292727...                        !bin "includes/charset.bin"
  2244                                              }
  2245                          charset_end:    ; $2800
  2246                          
  2247                          
  2248                                              ; 222222222222222         888888888          000000000           000000000
  2249                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  2250                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  2251                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2252                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2253                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2254                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  2255                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2256                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2257                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2258                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2259                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2260                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2261                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  2262                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  2263                                              ;22222222222222222222     888888888           000000000           000000000
  2264                          
  2265                          
  2266                          
  2267                          ; ==============================================================================
  2268                          ; LEVEL DATA
  2269                          ; Based on tiles
  2270                          ;                     !IMPORTANT!
  2271                          ;                     has to be page aligned or
  2272                          ;                     display_room routine will fail
  2273                          ; ==============================================================================
  2274                          
  2275                                              *= $2800
  2276                          level_data:

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
  2278                          level_data_end:
  2279                          
  2280                          
  2281                          ;$2fbf
  2282                          speed_byte:
  2283  2fb8 01                 !byte $01
  2284                          
  2285                          
  2286                          
  2287                          
  2288                          
  2289                          ; ==============================================================================
  2290                          ;
  2291                          ;
  2292                          ; ==============================================================================
  2293                                  
  2294                          
  2295                          rasterpoll_and_other_stuff:
  2296                          
  2297  2fb9 20a435                                 jsr poll_raster
  2298  2fbc 20c539                                 jsr check_door 
  2299  2fbf 4c8014                                 jmp animation_entrypoint          
  2300                          
  2301                          
  2302                          
  2303                          ; ==============================================================================
  2304                          ;
  2305                          ; tileset definition
  2306                          ; these are the first characters in the charset of each tile.
  2307                          ; example: rocks start at $0c and span 9 characters in total
  2308                          ; ==============================================================================
  2309                          
  2310                          tileset_definition:
  2311                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  2312  2fc2 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
  2313                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2314  2fca 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
  2315                                              ;     $10
  2316  2fd2 03                                     !byte $03                                           ; door
  2317                          
  2318                          !if EXTENDED = 0{
  2319                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2320  2fd3 0039190e3d7f2a2a                       !byte $00, $39, $19, $0e, $3d, $7f, $2a, $2a
  2321                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2322  2fdb 1e1e1e3d3d192f2f                       !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2323                                              ;     $10
  2324  2fe3 39                                     !byte $39
  2325                          }
  2326                          
  2327                          !if EXTENDED = 1{
  2328                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2329                                              !byte $00, $39, $2a, $0e, $3d, $7f, $2a, $2a
  2330                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2331                                              !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2332                                              ;     $10
  2333                                              !byte $29   
  2334                          }
  2335                          
  2336                          ; ==============================================================================
  2337                          ;
  2338                          ; displays a room based on tiles
  2339                          ; ==============================================================================
  2340                          
  2341                          display_room:       
  2342  2fe4 20903a                                 jsr draw_border
  2343  2fe7 a900                                   lda #$00
  2344  2fe9 8502                                   sta zp02
  2345  2feb a2d8                                   ldx #>COLRAM        ; HiByte of COLRAM
  2346  2fed 8605                                   stx zp05
  2347  2fef a204                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  2348  2ff1 8603                                   stx zp03
  2349  2ff3 a228                                   ldx #>level_data    ; HiByte of level_data
  2350  2ff5 860a                                   stx zp0A            ; in zp0A
  2351  2ff7 a201               current_room:       ldx #$01            ; current_room in X
  2352  2ff9 f00a                                   beq ++              ; if 0 -> skip
  2353  2ffb 18                 -                   clc                 ; else
  2354  2ffc 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  2355  2ffe 9002                                   bcc +               ; to zp09/zp0A
  2356  3000 e60a                                   inc zp0A            ;
  2357  3002 ca                 +                   dex                 ; X times
  2358  3003 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  2359  3005 8509               ++                  sta zp09            ; LoByte from above
  2360  3007 a000                                   ldy #$00
  2361  3009 84a8                                   sty zpA8
  2362  300b 84a7                                   sty zpA7
  2363  300d b109               m3066:              lda (zp09),y        ; get Tilenumber
  2364  300f aa                                     tax                 ; in X
  2365  3010 bdd32f                                 lda tiles_colors,x  ; get Tilecolor
  2366  3013 8510                                   sta zp10            ; => zp10
  2367  3015 bdc22f                                 lda tiles_chars,x   ; get Tilechar
  2368  3018 8511                                   sta zp11            ; => zp11
  2369  301a a203                                   ldx #$03            ; (3 rows)
  2370  301c a000               --                  ldy #$00
  2371  301e a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  2372  3020 8504                                   sta zp04            ; LoByte of COLRAM pointer
  2373  3022 a511                                   lda zp11            ; Load Tilechar
  2374  3024 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  2375  3026 a510                                   lda zp10            ; Load Tilecolor
  2376  3028 9104                                   sta (zp04),y        ; to COLRAM + Y
  2377  302a a511                                   lda zp11            ; Load Tilechar again
  2378  302c c9df                                   cmp #$df            ; if empty tile
  2379  302e f002                                   beq +               ; -> skip
  2380  3030 e611                                   inc zp11            ; else: Tilechar + 1
  2381  3032 c8                 +                   iny                 ; Y = Y + 1
  2382  3033 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  2383  3035 d0e7                                   bne -               ; no -> next Char
  2384  3037 a502                                   lda zp02            ; yes:
  2385  3039 18                                     clc
  2386  303a 6928                                   adc #$28            ; next SCREEN row
  2387  303c 8502                                   sta zp02
  2388  303e 9004                                   bcc +
  2389  3040 e603                                   inc zp03
  2390  3042 e605                                   inc zp05            ; and COLRAM row
  2391  3044 ca                 +                   dex                 ; X = X - 1
  2392  3045 d0d5                                   bne --              ; X != 0 -> next Char
  2393  3047 e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  2394  3049 e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  2395  304b a975                                   lda #$75            ; for m30B8 + 1
  2396  304d a6a8                                   ldx zpA8
  2397  304f e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  2398  3051 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  2399  3053 a6a7                                   ldx zpA7            ; else:
  2400  3055 e066                                   cpx #$66            ; zpA7 >= $66
  2401  3057 b01c                                   bcs display_door    ; yes: display_door
  2402  3059 a900                                   lda #$00            ; else:
  2403  305b 85a8                                   sta zpA8            ; clear zpA8
  2404  305d a924                                   lda #$24            ; for m30B8 + 1
  2405  305f 8d6630             +                   sta m30B8 + 1       ;
  2406  3062 a502                                   lda zp02
  2407  3064 38                                     sec
  2408  3065 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  2409  3067 8502                                   sta zp02
  2410  3069 b004                                   bcs +
  2411  306b c603                                   dec zp03
  2412  306d c605                                   dec zp05
  2413  306f a4a7               +                   ldy zpA7
  2414  3071 4c0d30                                 jmp m3066
  2415  3074 60                                     rts                 ; will this ever be used?
  2416                          
  2417  3075 a904               display_door:       lda #>SCREENRAM
  2418  3077 8503                                   sta zp03
  2419  3079 a9d8                                   lda #>COLRAM
  2420  307b 8505                                   sta zp05
  2421  307d a900                                   lda #$00
  2422  307f 8502                                   sta zp02
  2423  3081 8504                                   sta zp04
  2424  3083 a028               -                   ldy #$28
  2425  3085 b102                                   lda (zp02),y        ; read from SCREENRAM
  2426  3087 c906                                   cmp #$06            ; $06 (part from Door?)
  2427  3089 b00b                                   bcs +               ; >= $06 -> skip
  2428  308b 38                                     sec                 ; else:
  2429  308c e903                                   sbc #$03            ; subtract $03
  2430  308e a000                                   ldy #$00            ; set Y = $00
  2431  3090 9102                                   sta (zp02),y        ; and copy to one row above
  2432  3092 a939                                   lda #$39            ; color brown - luminance $3
  2433  3094 9104                                   sta (zp04),y
  2434  3096 a502               +                   lda zp02
  2435  3098 18                                     clc
  2436  3099 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  2437  309b 9004                                   bcc +
  2438  309d e603                                   inc zp03            ; inc pointer HiBytes if necessary
  2439  309f e605                                   inc zp05
  2440  30a1 8502               +                   sta zp02
  2441  30a3 8504                                   sta zp04
  2442  30a5 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  2443  30a7 d0da                                   bne -               ; no -> loop
  2444  30a9 a503                                   lda zp03            ; else:
  2445  30ab c907                                   cmp #>(SCREENRAM+$300)
  2446  30ad d0d4                                   bne -               ; no -> loop
  2447  30af 60                                     rts                 ; else: finally ready with room display
  2448                          
  2449                          ; ==============================================================================
  2450                          
  2451  30b0 a904               print_title:        lda #>SCREENRAM
  2452  30b2 8503                                   sta zp03
  2453  30b4 a9d8                                   lda #>COLRAM
  2454  30b6 8505                                   sta zp05
  2455  30b8 a900                                   lda #<SCREENRAM
  2456  30ba 8502                                   sta zp02
  2457  30bc 8504                                   sta zp04
  2458  30be a930                                   lda #>screen_start_src
  2459  30c0 85a8                                   sta zpA8
  2460  30c2 a9df                                   lda #<screen_start_src
  2461  30c4 85a7                                   sta zpA7
  2462  30c6 a204                                   ldx #$04
  2463  30c8 a000               --                  ldy #$00
  2464  30ca b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  2465  30cc 9102                                   sta (zp02),y        ; nach SCREEN
  2466  30ce a900                                   lda #$00           ; BLACK
  2467  30d0 9104                                   sta (zp04),y        ; nach COLRAM
  2468  30d2 c8                                     iny
  2469  30d3 d0f5                                   bne -
  2470  30d5 e603                                   inc zp03
  2471  30d7 e605                                   inc zp05
  2472  30d9 e6a8                                   inc zpA8
  2473  30db ca                                     dex
  2474  30dc d0ea                                   bne --
  2475  30de 60                                     rts
  2476                          
  2477                          ; ==============================================================================
  2478                          ; TITLE SCREEN DATA
  2479                          ;
  2480                          ; ==============================================================================
  2481                          
  2482                          screen_start_src:
  2483                          
  2484                                              !if EXTENDED {
  2485                                                  !bin "includes/screen-start-extended.scr"
  2486                                              }else{
  2487  30df 20202020202020a0...                        !bin "includes/screen-start.scr"
  2488                                              }
  2489                          
  2490                          screen_start_src_end:
  2491                          
  2492                          
  2493                          ; ==============================================================================
  2494                          ; i think this might be the draw routine for the player sprite
  2495                          ;
  2496                          ; ==============================================================================
  2497                          
  2498                          
  2499                          draw_player:
  2500  34c7 8eea34                                 stx m3548 + 1                       ; store x pos of player
  2501  34ca a9d8                                   lda #>COLRAM                        ; store colram high in zp05
  2502  34cc 8505                                   sta zp05
  2503  34ce a904                                   lda #>SCREENRAM                     ; store screenram high in zp03
  2504  34d0 8503                                   sta zp03
  2505  34d2 a900                                   lda #$00
  2506  34d4 8502                                   sta zp02
  2507  34d6 8504                                   sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
  2508  34d8 c000                                   cpy #$00                            ; Y is probably the player Y position
  2509  34da f00c                                   beq +                               ; Y is 0 -> +
  2510  34dc 18                 -                   clc                                 ; Y not 0
  2511  34dd 6928                                   adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
  2512  34df 9004                                   bcc ++                              ; <256? -> ++
  2513  34e1 e603                                   inc zp03
  2514  34e3 e605                                   inc zp05
  2515  34e5 88                 ++                  dey                                 ; Y = Y - 1
  2516  34e6 d0f4                                   bne -                               ; Y = 0 ? -> -
  2517  34e8 18                 +                   clc                                 ;
  2518  34e9 6916               m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
  2519  34eb 8502                                   sta zp02
  2520  34ed 8504                                   sta zp04
  2521  34ef 9004                                   bcc +
  2522  34f1 e603                                   inc zp03
  2523  34f3 e605                                   inc zp05
  2524  34f5 a203               +                   ldx #$03                            ; draw 3 rows for the player "sprite"
  2525  34f7 a900                                   lda #$00
  2526  34f9 8509                                   sta zp09
  2527  34fb a000               --                  ldy #$00
  2528  34fd a5a7               -                   lda zpA7
  2529  34ff d006                                   bne +
  2530  3501 a9df                                   lda #$df                            ; empty char, but not sure why
  2531  3503 9102                                   sta (zp02),y
  2532  3505 d01b                                   bne ++
  2533  3507 c901               +                   cmp #$01
  2534  3509 d00a                                   bne +
  2535  350b a5a8                                   lda zpA8
  2536  350d 9102                                   sta (zp02),y
  2537  350f a50a                                   lda zp0A
  2538  3511 9104                                   sta (zp04),y
  2539  3513 d00d                                   bne ++
  2540  3515 b102               +                   lda (zp02),y
  2541  3517 8610                                   stx zp10
  2542  3519 a609                                   ldx zp09
  2543  351b 9d4503                                 sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
  2544  351e e609                                   inc zp09
  2545  3520 a610                                   ldx zp10
  2546  3522 e6a8               ++                  inc zpA8
  2547  3524 c8                                     iny
  2548  3525 c003                                   cpy #$03                            ; width of the player sprite in characters (3)
  2549  3527 d0d4                                   bne -
  2550  3529 a502                                   lda zp02
  2551  352b 18                                     clc
  2552  352c 6928                                   adc #$28                            ; $28 = #40, draws one row of the player under each other
  2553  352e 8502                                   sta zp02
  2554  3530 8504                                   sta zp04
  2555  3532 9004                                   bcc +
  2556  3534 e603                                   inc zp03
  2557  3536 e605                                   inc zp05
  2558  3538 ca                 +                   dex
  2559  3539 d0c0                                   bne --
  2560  353b 60                                     rts
  2561                          
  2562                          
  2563                          ; ==============================================================================
  2564                          ; $359b
  2565                          ; JOYSTICK CONTROLS
  2566                          ; ==============================================================================
  2567                          
  2568                          check_joystick:
  2569                          
  2570                                              ;lda #$fd
  2571                                              ;sta KEYBOARD_LATCH
  2572                                              ;lda KEYBOARD_LATCH
  2573  353c ad00dc                                 lda $dc00
  2574  353f a009               player_pos_y:       ldy #$09
  2575  3541 a215               player_pos_x:       ldx #$15
  2576  3543 4a                                     lsr
  2577  3544 b005                                   bcs +
  2578  3546 c000                                   cpy #$00
  2579  3548 f001                                   beq +
  2580  354a 88                                     dey                                           ; JOYSTICK UP
  2581  354b 4a                 +                   lsr
  2582  354c b005                                   bcs +
  2583  354e c015                                   cpy #$15
  2584  3550 b001                                   bcs +
  2585  3552 c8                                     iny                                           ; JOYSTICK DOWN
  2586  3553 4a                 +                   lsr
  2587  3554 b005                                   bcs +
  2588  3556 e000                                   cpx #$00
  2589  3558 f001                                   beq +
  2590  355a ca                                     dex                                           ; JOYSTICK LEFT
  2591  355b 4a                 +                   lsr
  2592  355c b005                                   bcs +
  2593  355e e024                                   cpx #$24
  2594  3560 b001                                   bcs +
  2595  3562 e8                                     inx                                           ; JOYSTICK RIGHT
  2596  3563 8c8135             +                   sty m35E7 + 1
  2597  3566 8e8635                                 stx m35EC + 1
  2598  3569 a902                                   lda #$02
  2599  356b 85a7                                   sta zpA7
  2600  356d 20c734                                 jsr draw_player
  2601  3570 a209                                   ldx #$09
  2602  3572 bd4403             -                   lda TAPE_BUFFER + $8,x
  2603  3575 c9df                                   cmp #$df
  2604  3577 f004                                   beq +
  2605  3579 c9e2                                   cmp #$e2
  2606  357b d00d                                   bne ++
  2607  357d ca                 +                   dex
  2608  357e d0f2                                   bne -
  2609  3580 a90a               m35E7:              lda #$0a
  2610  3582 8d4035                                 sta player_pos_y + 1
  2611  3585 a915               m35EC:              lda #$15
  2612  3587 8d4235                                 sta player_pos_x + 1
  2613  358a a9ff               ++                  lda #$ff
  2614  358c 8d08ff                                 sta KEYBOARD_LATCH
  2615  358f a901                                   lda #$01
  2616  3591 85a7                                   sta zpA7
  2617  3593 a993                                   lda #$93                ; first character of the player graphic
  2618  3595 85a8                                   sta zpA8
  2619  3597 a93d                                   lda #$3d
  2620  3599 850a                                   sta zp0A
  2621  359b ac4035             get_player_pos:     ldy player_pos_y + 1
  2622  359e ae4235                                 ldx player_pos_x + 1
  2623                                        
  2624  35a1 4cc734                                 jmp draw_player
  2625                          
  2626                          ; ==============================================================================
  2627                          ;
  2628                          ; POLL RASTER
  2629                          ; ==============================================================================
  2630                          
  2631                          poll_raster:
  2632  35a4 78                                     sei                     ; disable interrupt
  2633  35a5 a9c0                                   lda #$c0                ; A = $c0
  2634  35a7 cd12d0             -                   cmp FF1D               ; vertical line bits 0-7
  2635                                              
  2636  35aa d0fb                                   bne -                   ; loop until we hit line c0
  2637  35ac a900                                   lda #$00                ; A = 0
  2638  35ae 85a7                                   sta zpA7                ; zpA7 = 0
  2639                                              
  2640  35b0 209b35                                 jsr get_player_pos
  2641                                              
  2642  35b3 203c35                                 jsr check_joystick
  2643  35b6 58                                     cli
  2644  35b7 60                                     rts
  2645                          
  2646                          
  2647                          ; ==============================================================================
  2648                          ; ROOM 16
  2649                          ; BELEGRO ANIMATION
  2650                          ; ==============================================================================
  2651                          
  2652                          belegro_animation:
  2653                          
  2654  35b8 a900                                   lda #$00
  2655  35ba 85a7                                   sta zpA7
  2656  35bc a20f               m3624:              ldx #$0f
  2657  35be a00f               m3626:              ldy #$0f
  2658  35c0 20c734                                 jsr draw_player
  2659  35c3 aebd35                                 ldx m3624 + 1
  2660  35c6 acbf35                                 ldy m3626 + 1
  2661  35c9 ec4235                                 cpx player_pos_x + 1
  2662  35cc b002                                   bcs +
  2663  35ce e8                                     inx
  2664  35cf e8                                     inx
  2665  35d0 ec4235             +                   cpx player_pos_x + 1
  2666  35d3 f001                                   beq +
  2667  35d5 ca                                     dex
  2668  35d6 cc4035             +                   cpy player_pos_y + 1
  2669  35d9 b002                                   bcs +
  2670  35db c8                                     iny
  2671  35dc c8                                     iny
  2672  35dd cc4035             +                   cpy player_pos_y + 1
  2673  35e0 f001                                   beq +
  2674  35e2 88                                     dey
  2675  35e3 8efd35             +                   stx m3668 + 1
  2676  35e6 8c0236                                 sty m366D + 1
  2677  35e9 a902                                   lda #$02
  2678  35eb 85a7                                   sta zpA7
  2679  35ed 20c734                                 jsr draw_player
  2680  35f0 a209                                   ldx #$09
  2681  35f2 bd4403             -                   lda TAPE_BUFFER + $8,x
  2682  35f5 c992                                   cmp #$92
  2683  35f7 900d                                   bcc +
  2684  35f9 ca                                     dex
  2685  35fa d0f6                                   bne -
  2686  35fc a210               m3668:              ldx #$10
  2687  35fe 8ebd35                                 stx m3624 + 1
  2688  3601 a00e               m366D:              ldy #$0e
  2689  3603 8cbf35                                 sty m3626 + 1
  2690  3606 a99c               +                   lda #$9c                                ; belegro chars
  2691  3608 85a8                                   sta zpA8
  2692  360a a93e                                   lda #$3e
  2693  360c 850a                                   sta zp0A
  2694  360e acbf35                                 ldy m3626 + 1
  2695  3611 aebd35                                 ldx m3624 + 1                    
  2696  3614 a901                                   lda #$01
  2697  3616 85a7                                   sta zpA7
  2698  3618 4cc734                                 jmp draw_player
  2699                          
  2700                          
  2701                          ; ==============================================================================
  2702                          ; items
  2703                          ; This area seems to be responsible for items placement
  2704                          ;
  2705                          ; ==============================================================================
  2706                          
  2707                          items:

; ******** Source: includes/items.asm
     1                          
     2                          
     3                          ; ==============================================================================
     4                          ; Items in the rooms are stored here
     5                          ; 
     6                          ; $ff is the separator for the next item
     7                          ; 
     8                          ; 
     9                          ; ==============================================================================
    10                          
    11                           
    12  361b ff00fefd29fb79fa...!byte $ff ,$00 ,$fe ,$fd ,$29 ,$fb ,$79 ,$fa ,$a9 ,$ff ,$01 ,$fd ,$bf ,$fb ,$49 ,$fa
    13  362b e0f9fcfefdf6fb3d...!byte $e0 ,$f9 ,$fc ,$fe ,$fd ,$f6 ,$fb ,$3d ,$fa ,$ac ,$f9 ,$fc ,$fe ,$fd ,$1e ,$fc
    14  363b f9fcff02fb5ffdb3...!byte $f9 ,$fc ,$ff ,$02 ,$fb ,$5f ,$fd ,$b3 ,$fa ,$b8 ,$f9 ,$fc ,$fd ,$db ,$fc ,$f9
    15  364b fcfdd3fefefb49fa...!byte $fc ,$fd ,$d3 ,$fe ,$fe ,$fb ,$49 ,$fa ,$a5 ,$f9 ,$f8 ,$f9 ,$f8 ,$f9 ,$fc ,$f9
    16  365b faa8fdfffaa7fefd...!byte $fa ,$a8 ,$fd ,$ff ,$fa ,$a7 ,$fe ,$fd ,$27 ,$f8 ,$fd ,$24 ,$fa ,$b0 ,$f9 ,$fc
    17  366b fd4cfcf9fcfd74fa...!byte $fd ,$4c ,$fc ,$f9 ,$fc ,$fd ,$74 ,$fa ,$b5 ,$fc ,$f9 ,$fc ,$fd ,$27 ,$fa ,$a7
    18  367b fd4ff8fd77f8fd9f...!byte $fd ,$4f ,$f8 ,$fd ,$77 ,$f8 ,$fd ,$9f ,$f8 ,$ff ,$90 ,$ff ,$07 ,$fe ,$fe ,$fd
    19  368b d1fb00fa5ef9fcfd...!byte $d1 ,$fb ,$00 ,$fa ,$5e ,$f9 ,$fc ,$fd ,$f9 ,$fc ,$f9 ,$fc ,$ff ,$08 ,$fe ,$fd
    20  369b 33fb4cfac6f9fcf9...!byte $33 ,$fb ,$4c ,$fa ,$c6 ,$f9 ,$fc ,$f9 ,$fc ,$fd ,$5b ,$fc ,$f9 ,$fc ,$f9 ,$fc
    21  36ab fefdacfb3ffac0f9...!byte $fe ,$fd ,$ac ,$fb ,$3f ,$fa ,$c0 ,$f9 ,$fc ,$fd ,$d4 ,$fc ,$f9 ,$fc ,$fd ,$fc
    22  36bb fcf9fcff0afefefd...!byte $fc ,$f9 ,$fc ,$ff ,$0a ,$fe ,$fe ,$fd ,$9c ,$fb ,$29 ,$fa ,$cc ,$f9 ,$fc ,$fd
    23  36cb c4fcf9fcff0bfd94...!byte $c4 ,$fc ,$f9 ,$fc ,$ff ,$0b ,$fd ,$94 ,$fb ,$39 ,$fa ,$d0 ,$fd ,$bc ,$fc ,$ff
    24  36db 0cfefefd15fb39fa...!byte $0c ,$fe ,$fe ,$fd ,$15 ,$fb ,$39 ,$fa ,$d2 ,$f9 ,$fc ,$fd ,$3d ,$fc ,$f9 ,$fc
    25  36eb ff0dfbfffad6fdae...!byte $ff ,$0d ,$fb ,$ff ,$fa ,$d6 ,$fd ,$ae ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$11 ,$f8 ,$fd
    26  36fb 65f8fd40f8fd69f8...!byte $65 ,$f8 ,$fd ,$40 ,$f8 ,$fd ,$69 ,$f8 ,$fe ,$fd ,$44 ,$f8 ,$fd ,$98 ,$f8 ,$fd
    27  370b f4f8fd7ef8fd51f8...!byte $f4 ,$f8 ,$fd ,$7e ,$f8 ,$fd ,$51 ,$f8 ,$fd ,$0c ,$f8 ,$fd ,$83 ,$f8 ,$fe ,$fd
    28  371b 0ff8fd86f8fd82f8...!byte $0f ,$f8 ,$fd ,$86 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$f8 ,$f8 ,$fd ,$b4 ,$f8 ,$fd ,$15
    29  372b f8fd40f8fd25f8fd...!byte $f8 ,$fd ,$40 ,$f8 ,$fd ,$25 ,$f8 ,$fd ,$9b ,$f8 ,$fe ,$fd ,$71 ,$f8 ,$fd ,$4d
    30  373b f8fd79f8fda6f8ff...!byte $f8 ,$fd ,$79 ,$f8 ,$fd ,$a6 ,$f8 ,$ff ,$0e ,$fd ,$f6 ,$fb ,$00 ,$fa ,$d7 ,$f8
    31  374b fd82f8fefd5ff8fd...!byte $fd ,$82 ,$f8 ,$fe ,$fd ,$5f ,$f8 ,$fd ,$84 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$e6 ,$f8
    32  375b fd71f8fd73f8fd1f...!byte $fd ,$71 ,$f8 ,$fd ,$73 ,$f8 ,$fd ,$1f ,$f8 ,$fd ,$1c ,$f8 ,$fe ,$fd ,$24 ,$f8
    33  376b fd27f8fd50f8fd48...!byte $fd ,$27 ,$f8 ,$fd ,$50 ,$f8 ,$fd ,$48 ,$f8 ,$fd ,$c4 ,$f8 ,$fd ,$c0 ,$f8 ,$fd
    34  377b 94f8fde0f8fd64f8...!byte $94 ,$f8 ,$fd ,$e0 ,$f8 ,$fd ,$64 ,$f8 ,$fd ,$3f ,$f8 ,$fd ,$13 ,$f8 ,$fe ,$fd
    35  378b 15f8fd34f8fd04f8...!byte $15 ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$04 ,$f8 ,$ff ,$10 ,$fd ,$63 ,$fb ,$5f ,$fa ,$b8
    36  379b f9fcfd8bfcf8f9fc...!byte $f9 ,$fc ,$fd ,$8b ,$fc ,$f8 ,$f9 ,$fc ,$fe ,$fe ,$fb ,$39 ,$fd ,$fb ,$fa ,$f4
    37  37ab fdf2fb39fad9f9fc...!byte $fd ,$f2 ,$fb ,$39 ,$fa ,$d9 ,$f9 ,$fc ,$fd ,$1a ,$fe ,$fc ,$f9 ,$fc ,$ff ,$11
    38  37bb fefefdc3fb39fadd...!byte $fe ,$fe ,$fd ,$c3 ,$fb ,$39 ,$fa ,$dd ,$fd ,$eb ,$fc ,$ff ,$ff ,$ff ,$ff ,$ff
    39                                          

; ******** Source: main.asm
  2709                          items_end:
  2710                          
  2711                          next_item:
  2712  37cb a5a7                                   lda zpA7
  2713  37cd 18                                     clc
  2714  37ce 6901                                   adc #$01
  2715  37d0 85a7                                   sta zpA7
  2716  37d2 9002                                   bcc +                       ; bcc $3845
  2717  37d4 e6a8                                   inc zpA8
  2718  37d6 60                 +                   rts
  2719                          
  2720                          ; ==============================================================================
  2721                          ; TODO
  2722                          ; no clue yet. level data has already been drawn when this is called
  2723                          ; probably placing the items on the screen
  2724                          ; ==============================================================================
  2725                          
  2726                          update_items_display:
  2727  37d7 a936                                   lda #>items                 ; load address for items into zeropage
  2728  37d9 85a8                                   sta zpA8
  2729  37db a91b                                   lda #<items
  2730  37dd 85a7                                   sta zpA7
  2731  37df a000                                   ldy #$00                    ; y = 0
  2732  37e1 b1a7               --                  lda (zpA7),y                ; load first value
  2733  37e3 c9ff                                   cmp #$ff                    ; is it $ff?
  2734  37e5 f006                                   beq +                       ; yes -> +
  2735  37e7 20cb37             -                   jsr next_item               ; no -> set zero page to next value
  2736  37ea 4ce137                                 jmp --                      ; and loop
  2737  37ed 20cb37             +                   jsr next_item               ; value was $ff, now get the next value in the list
  2738  37f0 b1a7                                   lda (zpA7),y
  2739  37f2 c9ff                                   cmp #$ff                    ; is the next value $ff again?
  2740  37f4 d003                                   bne +
  2741  37f6 4c7b38                                 jmp prepare_rooms           ; yes -> m38DF
  2742  37f9 cdf82f             +                   cmp current_room + 1        ; is the number the current room number?
  2743  37fc d0e9                                   bne -                       ; no -> loop
  2744  37fe a9d8                                   lda #>COLRAM                ; yes the number is the current room number
  2745  3800 8505                                   sta zp05                    ; store COLRAM and SCREENRAM in zeropage
  2746  3802 a904                                   lda #>SCREENRAM
  2747  3804 8503                                   sta zp03
  2748  3806 a900                                   lda #$00                    ; A = 0
  2749  3808 8502                                   sta zp02                    ; zp02 = 0, zp04 = 0
  2750  380a 8504                                   sta zp04
  2751  380c 20cb37                                 jsr next_item               ; move to next value
  2752  380f b1a7                                   lda (zpA7),y                ; get next value in the list
  2753  3811 c9fe               -                   cmp #$fe                    ; is it $FE?
  2754  3813 f00b                                   beq +                       ; yes -> +
  2755  3815 c9f9                                   cmp #$f9                    ; no, is it $f9?
  2756  3817 d00d                                   bne +++                     ; no -> +++
  2757  3819 a502                                   lda zp02                    ; value is $f9
  2758  381b 207338                                 jsr m38D7                   ; add 1 to zp02 and zp04
  2759  381e 9004                                   bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
  2760  3820 e603               +                   inc zp03                    ; value is $fe
  2761  3822 e605                                   inc zp05                    ; increase zp03 and zp05
  2762  3824 b1a7               ++                  lda (zpA7),y                ; get value from list
  2763  3826 c9fb               +++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
  2764  3828 d009                                   bne +                       ; no -> +
  2765  382a 20cb37                                 jsr next_item               ; yes it's $fb, get the next value
  2766  382d b1a7                                   lda (zpA7),y                ; get value from list
  2767  382f 8509                                   sta zp09                    ; store value in zp09
  2768  3831 d028                                   bne ++                      ; if value was 0 -> ++
  2769  3833 c9f8               +                   cmp #$f8
  2770  3835 f01c                                   beq +
  2771  3837 c9fc                                   cmp #$fc
  2772  3839 d00d                                   bne +++
  2773  383b a50a                                   lda zp0A
  2774                                                                          ; jmp m399F
  2775                          
  2776  383d c9df                                   cmp #$df                    ; this part was moved here as it wasn't called anywhere else
  2777  383f f002                                   beq skip                    ; and I think it was just outsourced for branching length issues
  2778  3841 e60a                                   inc zp0A           
  2779  3843 b1a7               skip:               lda (zpA7),y        
  2780  3845 4c5338                                 jmp m38B7
  2781                          
  2782  3848 c9fa               +++                 cmp #$fa
  2783  384a d00f                                   bne ++
  2784  384c 20cb37                                 jsr next_item
  2785  384f b1a7                                   lda (zpA7),y
  2786  3851 850a                                   sta zp0A
  2787                          m38B7:
  2788  3853 a509               +                   lda zp09
  2789  3855 9104                                   sta (zp04),y
  2790  3857 a50a                                   lda zp0A
  2791  3859 9102                                   sta (zp02),y
  2792  385b c9fd               ++                  cmp #$fd
  2793  385d d009                                   bne +
  2794  385f 20cb37                                 jsr next_item
  2795  3862 b1a7                                   lda (zpA7),y
  2796  3864 8502                                   sta zp02
  2797  3866 8504                                   sta zp04
  2798  3868 20cb37             +                   jsr next_item
  2799  386b b1a7                                   lda (zpA7),y
  2800  386d c9ff                                   cmp #$ff
  2801  386f d0a0                                   bne -
  2802  3871 f008                                   beq prepare_rooms
  2803  3873 18                 m38D7:              clc
  2804  3874 6901                                   adc #$01
  2805  3876 8502                                   sta zp02
  2806  3878 8504                                   sta zp04
  2807  387a 60                                     rts
  2808                          
  2809                          
  2810                          
  2811                          
  2812                          
  2813                          
  2814                          
  2815                          
  2816                          
  2817                          
  2818                          
  2819                          
  2820                          
  2821                          
  2822                          
  2823                          
  2824                          
  2825                          
  2826                          
  2827                          
  2828                          
  2829                          
  2830                          
  2831                          
  2832                          
  2833                          
  2834                          
  2835                          
  2836                          ; ==============================================================================
  2837                          ; ROOM PREPARATION CHECK
  2838                          ; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
  2839                          ; ==============================================================================
  2840                          
  2841                          prepare_rooms:
  2842                                      
  2843  387b adf82f                                 lda current_room + 1
  2844                                              
  2845  387e c902                                   cmp #$02                                ; is the current room 02?
  2846  3880 f01d                                   beq room_02_prep
  2847                          
  2848  3882 c907                                   cmp #$07
  2849  3884 f04c                                   beq room_07_make_sacred_column
  2850                                              
  2851  3886 c906                                   cmp #$06          
  2852  3888 f05a                                   beq room_06_make_deadly_doors
  2853                          
  2854  388a c904                                   cmp #$04
  2855  388c f062                                   beq room_04_prep
  2856                          
  2857  388e c905                                   cmp #$05
  2858  3890 f001                                   beq room_05_prep
  2859                          
  2860  3892 60                                     rts
  2861                          
  2862                          
  2863                          
  2864                          ; ==============================================================================
  2865                          ; ROOM 05
  2866                          ; HIDE THE BREATHING TUBE UNDER THE STONE
  2867                          ; ==============================================================================
  2868                          
  2869                          room_05_prep:                  
  2870                                                         
  2871  3893 a9fd                                   lda #$fd                                    ; yes
  2872  3895 a201               breathing_tube_mod: ldx #$01
  2873  3897 d002                                   bne +                                       ; based on self mod, put the normal
  2874  3899 a97a                                   lda #$7a                                    ; stone char back again
  2875  389b 8dd206             +                   sta SCREENRAM + $2d2   
  2876  389e 60                                     rts
  2877                          
  2878                          
  2879                          
  2880                          ; ==============================================================================
  2881                          ; ROOM 02 PREP
  2882                          ; 
  2883                          ; ==============================================================================
  2884                          
  2885                          room_02_prep:
  2886  389f a90d                                   lda #$0d                                ; yes room is 02, a = $0d #13
  2887  38a1 8502                                   sta zp02                                ; zp02 = $0d
  2888  38a3 8504                                   sta zp04                                ; zp04 = $0d
  2889  38a5 a9d8                                   lda #>COLRAM                            ; set colram zp
  2890  38a7 8505                                   sta zp05
  2891  38a9 a904                                   lda #>SCREENRAM                         ; set screenram zp      
  2892  38ab 8503                                   sta zp03
  2893  38ad a218                                   ldx #$18                                ; x = $18 #24
  2894  38af b102               -                   lda (zp02),y                            ; y must have been set earlier
  2895  38b1 c9df                                   cmp #$df                                ; $df = empty space likely
  2896  38b3 f004                                   beq delete_fence                        ; yes, empty -> m3900
  2897  38b5 c9f5                                   cmp #$f5                                ; no, but maybe a $f5? (fence!)
  2898  38b7 d006                                   bne +                                   ; nope -> ++
  2899                          
  2900                          delete_fence:
  2901  38b9 a9f5                                   lda #$f5                                ; A is either $df or $f5 -> selfmod here
  2902  38bb 9102                                   sta (zp02),y                            ; store that value
  2903  38bd 9104                                   sta (zp04),y                            ; in zp02 and zo04
  2904  38bf a502               +                   lda zp02                                ; and load it in again, jeez
  2905  38c1 18                                     clc
  2906  38c2 6928                                   adc #$28                                ; smells like we're going to draw a fence
  2907  38c4 8502                                   sta zp02
  2908  38c6 8504                                   sta zp04
  2909  38c8 9004                                   bcc +             
  2910  38ca e603                                   inc zp03
  2911  38cc e605                                   inc zp05
  2912  38ce ca                 +                   dex
  2913  38cf d0de                                   bne -              
  2914  38d1 60                                     rts
  2915                          
  2916                          ; ==============================================================================
  2917                          ; ROOM 07 PREP
  2918                          ;
  2919                          ; ==============================================================================
  2920                          
  2921                          room_07_make_sacred_column:
  2922                          
  2923                                              
  2924  38d2 a217                                   ldx #$17                                    ; yes
  2925  38d4 bd6805             -                   lda SCREENRAM + $168,x     
  2926  38d7 c9df                                   cmp #$df
  2927  38d9 d005                                   bne +                       
  2928  38db a9e3                                   lda #$e3
  2929  38dd 9d6805                                 sta SCREENRAM + $168,x    
  2930  38e0 ca                 +                   dex
  2931  38e1 d0f1                                   bne -                      
  2932  38e3 60                                     rts
  2933                          
  2934                          
  2935                          ; ==============================================================================
  2936                          ; ROOM 06
  2937                          ; PREPARE THE DEADLY DOORS
  2938                          ; ==============================================================================
  2939                          
  2940                          room_06_make_deadly_doors:
  2941                          
  2942                                              
  2943  38e4 a9f6                                   lda #$f6                                    ; char for wrong door
  2944  38e6 8d9c04                                 sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
  2945  38e9 8d7c06                                 sta SCREENRAM + $27c
  2946  38ec 8d6c07                                 sta SCREENRAM + $36c       
  2947  38ef 60                                     rts
  2948                          
  2949                          ; ==============================================================================
  2950                          ; ROOM 04
  2951                          ; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
  2952                          ; ==============================================================================
  2953                          
  2954                          room_04_prep: 
  2955                          
  2956                          
  2957                                              
  2958  38f0 adf82f                                 lda current_room + 1                            ; get current room
  2959  38f3 c904                                   cmp #04                                         ; is it 4? (coffins)
  2960  38f5 d00c                                   bne ++                                          ; nope
  2961  38f7 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  2962  38f9 ac0839                                 ldy m394A + 1                                   ; 
  2963  38fc f002                                   beq +
  2964  38fe a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  2965  3900 8df904             +                   sta SCREENRAM + $f9 
  2966                                          
  2967  3903 a2f7               ++                  ldx #$f7                                    ; yes room 04
  2968  3905 a0f8                                   ldy #$f8
  2969  3907 a901               m394A:              lda #$01
  2970  3909 d004                                   bne m3952           
  2971  390b a23b                                   ldx #$3b
  2972  390d a042                                   ldy #$42
  2973  390f a901               m3952:              lda #$01                                    ; some self mod here
  2974  3911 c901                                   cmp #$01
  2975  3913 d003                                   bne +           
  2976  3915 8e7a04                                 stx SCREENRAM+ $7a 
  2977  3918 c902               +                   cmp #$02
  2978  391a d003                                   bne +           
  2979  391c 8e6a05                                 stx SCREENRAM + $16a   
  2980  391f c903               +                   cmp #$03
  2981  3921 d003                                   bne +           
  2982  3923 8e5a06                                 stx SCREENRAM + $25a       
  2983  3926 c904               +                   cmp #$04
  2984  3928 d003                                   bne +           
  2985  392a 8e4a07                                 stx SCREENRAM + $34a   
  2986  392d c905               +                   cmp #$05
  2987  392f d003                                   bne +           
  2988  3931 8c9c04                                 sty SCREENRAM + $9c    
  2989  3934 c906               +                   cmp #$06
  2990  3936 d003                                   bne +           
  2991  3938 8c8c05                                 sty SCREENRAM + $18c   
  2992  393b c907               +                   cmp #$07
  2993  393d d003                                   bne +           
  2994  393f 8c7c06                                 sty SCREENRAM + $27c 
  2995  3942 c908               +                   cmp #$08
  2996  3944 d003                                   bne +           
  2997  3946 8c6c07                                 sty SCREENRAM + $36c   
  2998  3949 60                 +                   rts
  2999                          
  3000                          
  3001                          
  3002                          
  3003                          
  3004                          
  3005                          
  3006                          
  3007                          
  3008                          
  3009                          
  3010                          
  3011                          
  3012                          
  3013                          
  3014                          
  3015                          
  3016                          
  3017                          
  3018                          
  3019                          ; ==============================================================================
  3020                          ; PLAYER POSITION TABLE FOR EACH ROOM
  3021                          ; FORMAT: Y left door, X left door, Y right door, X right door
  3022                          ; ==============================================================================
  3023                          
  3024                          player_xy_pos_table:
  3025                          
  3026  394a 06031221           !byte $06, $03, $12, $21                                        ; room 00
  3027  394e 03031221           !byte $03, $03, $12, $21                                        ; room 01
  3028  3952 03031521           !byte $03, $03, $15, $21                                        ; room 02
  3029  3956 03030f21           !byte $03, $03, $0f, $21                                        ; room 03
  3030  395a 151e0606           !byte $15, $1e, $06, $06                                        ; room 04
  3031  395e 06031221           !byte $06, $03, $12, $21                                        ; room 05
  3032  3962 03030921           !byte $03, $03, $09, $21                                        ; room 06
  3033  3966 03031221           !byte $03, $03, $12, $21                                        ; room 07
  3034  396a 03030c21           !byte $03, $03, $0c, $21                                        ; room 08
  3035  396e 03031221           !byte $03, $03, $12, $21                                        ; room 09
  3036  3972 0c030c20           !byte $0c, $03, $0c, $20                                        ; room 10
  3037  3976 0c030c21           !byte $0c, $03, $0c, $21                                        ; room 11
  3038  397a 0c030915           !byte $0c, $03, $09, $15                                        ; room 12
  3039  397e 03030621           !byte $03, $03, $06, $21                                        ; room 13
  3040  3982 03030321           !byte $03, $03, $03, $21                                        ; room 14
  3041  3986 06031221           !byte $06, $03, $12, $21                                        ; room 15
  3042  398a 0303031d           !byte $03, $03, $03, $1d                                        ; room 16
  3043  398e 03030621           !byte $03, $03, $06, $21                                        ; room 17
  3044  3992 0303               !byte $03, $03                                                  ; room 18 (only one door)
  3045                          
  3046                          
  3047                          
  3048                          ; ==============================================================================
  3049                          ; $3a33
  3050                          ; Apparently some lookup table, e.g. to get the 
  3051                          ; ==============================================================================
  3052                          
  3053                          room_player_pos_lookup:
  3054                          
  3055  3994 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  3056  39a4 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  3057  39b4 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  3058  39c4 00                 !byte $00
  3059                          
  3060                          
  3061                          
  3062                          
  3063                          
  3064                          
  3065                          
  3066                          
  3067                          
  3068                          
  3069                          
  3070                          ; ==============================================================================
  3071                          ;
  3072                          ;
  3073                          ; ==============================================================================
  3074                          
  3075                          check_door:
  3076                          
  3077  39c5 a209                                   ldx #$09                                    ; set loop to 9
  3078  39c7 bd4403             -                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
  3079  39ca c905                                   cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
  3080  39cc f008                                   beq +                                       ; yes -> +
  3081  39ce c903                                   cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
  3082  39d0 f013                                   beq set_player_xy                           ; yes -> m3A17
  3083  39d2 ca                                     dex                                         ; decrease loop
  3084  39d3 d0f2                                   bne -                                       ; loop
  3085  39d5 60                 -                   rts
  3086                          
  3087  39d6 aef82f             +                   ldx current_room + 1
  3088  39d9 f0fa                                   beq -               
  3089  39db ca                                     dex
  3090  39dc 8ef82f                                 stx current_room + 1                        ; update room number                         
  3091  39df bc9439                                 ldy room_player_pos_lookup,x                ; load        
  3092  39e2 4cef39                                 jmp update_player_pos           
  3093                          
  3094                          set_player_xy:
  3095  39e5 aef82f                                 ldx current_room + 1                            ; x = room number
  3096  39e8 e8                                     inx                                             ; room number ++
  3097  39e9 8ef82f                                 stx current_room + 1                            ; update room number
  3098  39ec bcab39                                 ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room
  3099                          
  3100                          update_player_pos:              
  3101  39ef b94a39                                 lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
  3102  39f2 8d4035                                 sta player_pos_y + 1                            ; player y pos = a
  3103  39f5 b94b39                                 lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
  3104  39f8 8d4235                                 sta player_pos_x + 1
  3105                          
  3106  39fb 20e42f             m3A2D:              jsr display_room                                ; done  
  3107  39fe 209115                                 jsr room_04_prep_door                           ; was in main loop before, might find a better place
  3108  3a01 4cd737                                 jmp update_items_display
  3109                          
  3110                          
  3111                          
  3112                          ; ==============================================================================
  3113                          ;
  3114                          ; wait routine
  3115                          ; usually called with Y set before
  3116                          ; ==============================================================================
  3117                          
  3118                          wait:
  3119  3a04 ca                                     dex
  3120  3a05 d0fd                                   bne wait
  3121  3a07 88                                     dey
  3122  3a08 d0fa                                   bne wait
  3123  3a0a 60                 fake:               rts
  3124                          
  3125                          
  3126                          ; ==============================================================================
  3127                          ; sets the game screen
  3128                          ; multicolor, charset, main colors
  3129                          ; ==============================================================================
  3130                          
  3131                          set_game_basics:
  3132  3a0b ad12ff                                 lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  3133  3a0e 29fb                                   and #$fb                                    ; clear bit 2
  3134  3a10 8d12ff                                 sta VOICE1                                  ; => get data from RAM
  3135  3a13 a918                                   lda #$18            ;lda #$21
  3136  3a15 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
  3137                                              
  3138                                                                                          ; bit 1 : Single clock set  ( 0 )
  3139                                                                                          ; b.2-7 : character data base address
  3140                                                                                          ; %00100$x ($2000)
  3141  3a18 ad16d0                                 lda FF07
  3142  3a1b 0990                                   ora #$90                                    ; multicolor ON - reverse OFF
  3143  3a1d 8d16d0                                 sta FF07
  3144                          
  3145                                                                                          ; set the main colors for the game
  3146                          
  3147  3a20 a9db                                   lda #MULTICOLOR_1                           ; original: #$db
  3148  3a22 8d22d0                                 sta COLOR_1                                 ; char color 1
  3149  3a25 a929                                   lda #MULTICOLOR_2                           ; original: #$29
  3150  3a27 8d23d0                                 sta COLOR_2                                 ; char color 2
  3151                                              
  3152  3a2a 60                                     rts
  3153                          
  3154                          ; ==============================================================================
  3155                          ; set font and screen setup (40 columns and hires)
  3156                          ; $3a9d
  3157                          ; ==============================================================================
  3158                          
  3159                          set_charset_and_screen:                               ; set text screen
  3160                          
  3161  3a2b ad12ff                                 lda VOICE1
  3162  3a2e 0904                                   ora #$04                                    ; set bit 2
  3163  3a30 8d12ff                                 sta VOICE1                                  ; => get data from ROM
  3164  3a33 a9d5                                   lda #$d5                                    ; ROM FONT
  3165  3a35 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; set
  3166  3a38 ad16d0                                 lda FF07
  3167  3a3b a908                                   lda #$08                                    ; 40 columns and Multicolor OFF
  3168  3a3d 8d16d0                                 sta FF07
  3169                                              
  3170  3a40 60                                     rts
  3171                          
  3172                          test:
  3173  3a41 ee20d0                                 inc BORDER_COLOR
  3174  3a44 4c413a                                 jmp test
  3175                          
  3176                          ; ==============================================================================
  3177                          ; init
  3178                          ; start of game (original $3ab3)
  3179                          ; ==============================================================================
  3180                          
  3181                          code_start:
  3182                          init:
  3183                                              ;jsr init_music           ; TODO
  3184                                              
  3185  3a47 a917                                   lda #$17                  ; set lower case charset
  3186  3a49 8d18d0                                 sta $d018                 ; wasn't on Plus/4 for some reason
  3187                                              
  3188  3a4c a90b                                   lda #$0b
  3189  3a4e 8d21d0                                 sta BG_COLOR          ; background color
  3190  3a51 8d20d0                                 sta BORDER_COLOR          ; border color
  3191  3a54 20bb16                                 jsr reset_items           ; might be a level data reset, and print the title screen
  3192                          
  3193  3a57 a020                                   ldy #$20
  3194  3a59 20043a                                 jsr wait
  3195                                              
  3196                                              ; waiting for key press on title screen
  3197                          
  3198  3a5c a5cb               -                   lda $cb                   ; zp position of currently pressed key
  3199  3a5e c938                                   cmp #$38                  ; is it the space key?
  3200  3a60 d0fa                                   bne -
  3201                          
  3202                                                                        ;clda #$ff
  3203  3a62 20f21c                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  3204                                              
  3205                          
  3206                                              ; TODO: unclear what the code below does
  3207                                              ; i think it fills the level data with "DF", which is a blank character
  3208  3a65 a904                                   lda #>SCREENRAM
  3209  3a67 8503                                   sta zp03
  3210  3a69 a900                                   lda #$00
  3211  3a6b 8502                                   sta zp02
  3212  3a6d a204                                   ldx #$04
  3213  3a6f a000                                   ldy #$00
  3214  3a71 a9df                                   lda #$df
  3215  3a73 9102               -                   sta (zp02),y
  3216  3a75 c8                                     iny
  3217  3a76 d0fb                                   bne -
  3218  3a78 e603                                   inc zp03
  3219  3a7a ca                                     dex
  3220  3a7b d0f6                                   bne -
  3221                                              
  3222  3a7d 200b3a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  3223                          
  3224                                              ; set background color
  3225  3a80 a900                                   lda #$00
  3226  3a82 8d21d0                                 sta BG_COLOR
  3227                          
  3228                                              ; border color. default is a dark red
  3229  3a85 a912                                   lda #BORDER_COLOR_VALUE
  3230  3a87 8d20d0                                 sta BORDER_COLOR
  3231                                              
  3232  3a8a 20903a                                 jsr draw_border
  3233                                              
  3234  3a8d 4cc83a                                 jmp set_start_screen
  3235                          
  3236                          ; ==============================================================================
  3237                          ;
  3238                          ; draws the extended "border"
  3239                          ; ==============================================================================
  3240                          
  3241                          draw_border:        
  3242  3a90 a927                                   lda #$27
  3243  3a92 8502                                   sta zp02
  3244  3a94 8504                                   sta zp04
  3245  3a96 a9d8                                   lda #>COLRAM
  3246  3a98 8505                                   sta zp05
  3247  3a9a a904                                   lda #>SCREENRAM
  3248  3a9c 8503                                   sta zp03
  3249  3a9e a218                                   ldx #$18
  3250  3aa0 a000                                   ldy #$00
  3251  3aa2 a95d               -                   lda #$5d
  3252  3aa4 9102                                   sta (zp02),y
  3253  3aa6 a912                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3254  3aa8 9104                                   sta (zp04),y
  3255  3aaa 98                                     tya
  3256  3aab 18                                     clc
  3257  3aac 6928                                   adc #$28
  3258  3aae a8                                     tay
  3259  3aaf 9004                                   bcc +
  3260  3ab1 e603                                   inc zp03
  3261  3ab3 e605                                   inc zp05
  3262  3ab5 ca                 +                   dex
  3263  3ab6 d0ea                                   bne -
  3264  3ab8 a95d               -                   lda #$5d
  3265  3aba 9dc007                                 sta SCREENRAM + $3c0,x
  3266  3abd a912                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3267  3abf 9dc0db                                 sta COLRAM + $3c0,x
  3268  3ac2 e8                                     inx
  3269  3ac3 e028                                   cpx #$28
  3270  3ac5 d0f1                                   bne -
  3271  3ac7 60                                     rts
  3272                          
  3273                          ; ==============================================================================
  3274                          ; SETUP FIRST ROOM
  3275                          ; player xy position and room number
  3276                          ; ==============================================================================
  3277                          
  3278                          set_start_screen:
  3279  3ac8 a906                                   lda #PLAYER_START_POS_Y
  3280  3aca 8d4035                                 sta player_pos_y + 1                    ; Y player start position (0 = top)
  3281  3acd a903                                   lda #PLAYER_START_POS_X
  3282  3acf 8d4235                                 sta player_pos_x + 1                    ; X player start position (0 = left)
  3283  3ad2 a900                                   lda #START_ROOM                         ; room number (start screen) ($3b45)
  3284  3ad4 8df82f                                 sta current_room + 1
  3285  3ad7 20fb39                                 jsr m3A2D
  3286                                              
  3287                          
  3288                          main_loop:
  3289                                              
  3290  3ada 20b92f                                 jsr rasterpoll_and_other_stuff
  3291  3add a030                                   ldy #$30                                ; wait a bit -> in each frame! slows down movement
  3292  3adf 20043a                                 jsr wait
  3293                                                                                      ;jsr room_04_prep_door
  3294  3ae2 202e16                                 jsr prep_player_pos
  3295  3ae5 4c4716                                 jmp object_collision
  3296                          
  3297                          ; ==============================================================================
  3298                          ;
  3299                          ; Display the death message
  3300                          ; End of game and return to start screen
  3301                          ; ==============================================================================
  3302                          
  3303                          death:
  3304  3ae8 a93b                                   lda #>death_messages
  3305  3aea 85a8                                   sta zpA8
  3306  3aec a944                                   lda #<death_messages
  3307  3aee 85a7                                   sta zpA7
  3308  3af0 c000                                   cpy #$00
  3309  3af2 f00c                                   beq ++
  3310  3af4 18                 -                   clc
  3311  3af5 6932                                   adc #$32
  3312  3af7 85a7                                   sta zpA7
  3313  3af9 9002                                   bcc +
  3314  3afb e6a8                                   inc zpA8
  3315  3afd 88                 +                   dey
  3316  3afe d0f4                                   bne -
  3317  3b00 a90c               ++                  lda #$0c
  3318  3b02 8503                                   sta zp03
  3319  3b04 8402                                   sty zp02
  3320  3b06 a204                                   ldx #$04
  3321  3b08 a920                                   lda #$20
  3322  3b0a 9102               -                   sta (zp02),y
  3323  3b0c c8                                     iny
  3324  3b0d d0fb                                   bne -
  3325  3b0f e603                                   inc zp03
  3326  3b11 ca                                     dex
  3327  3b12 d0f6                                   bne -
  3328  3b14 202b3a                                 jsr set_charset_and_screen
  3329  3b17 b1a7               -                   lda (zpA7),y
  3330  3b19 9dc005                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  3331  3b1c a900                                   lda #$00                                    ; color of the death message
  3332  3b1e 9dc0d9                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  3333  3b21 e8                                     inx
  3334  3b22 c8                                     iny
  3335  3b23 e019                                   cpx #$19
  3336  3b25 d002                                   bne +
  3337  3b27 a250                                   ldx #$50
  3338  3b29 c032               +                   cpy #$32
  3339  3b2b d0ea                                   bne -
  3340  3b2d a9fd                                   lda #$fd
  3341  3b2f 8d21d0                                 sta BG_COLOR
  3342  3b32 8d20d0                                 sta BORDER_COLOR
  3343                          m3EF9:
  3344  3b35 a908                                   lda #$08
  3345  3b37 a0ff               -                   ldy #$ff
  3346  3b39 20043a                                 jsr wait
  3347  3b3c 38                                     sec
  3348  3b3d e901                                   sbc #$01
  3349  3b3f d0f6                                   bne -
  3350  3b41 4c473a                                 jmp init
  3351                          
  3352                          ; ==============================================================================
  3353                          ;
  3354                          ; DEATH MESSAGES
  3355                          ; ==============================================================================
  3356                          
  3357                          death_messages:
  3358                          
  3359                          ; death messages
  3360                          ; like "You fell into a snake pit"
  3361                          
  3362                          ; scr conversion
  3363                          
  3364                          ; 00 You fell into a snake pit
  3365                          ; 01 You'd better watched out for the sacred column
  3366                          ; 02 You drowned in the deep river
  3367                          ; 03 You drank from the poisend bottle
  3368                          ; 04 Boris the spider got you and killed you
  3369                          ; 05 Didn't you see the laser beam?
  3370                          ; 06 240 Volts! You got an electrical shock!
  3371                          ; 07 You stepped on a nail!
  3372                          ; 08 A foot trap stopped you!
  3373                          ; 09 This room is doomed by the wizard Manilo!
  3374                          ; 0a You were locked in and starved!
  3375                          ; 0b You were hit by a big rock and died!
  3376                          ; 0c Belegro killed you!
  3377                          ; 0d You found a thirsty zombie....
  3378                          ; 0e The monster grabbed you you. You are dead!
  3379                          ; 0f You were wounded by the bush!
  3380                          ; 10 You are trapped in wire-nettings!
  3381                          
  3382                          !if LANGUAGE = EN{
  3383  3b44 590f152006050c0c...!scr "You fell into a          snake pit !              "
  3384  3b76 590f152704200205...!scr "You'd better watched out for the sacred column!   "
  3385  3ba8 590f152004120f17...!scr "You drowned in the deep  river !                  "
  3386  3bda 590f15200412010e...!scr "You drank from the       poisened bottle ........ "
  3387  3c0c 420f1209132c2014...!scr "Boris, the spider, got   you and killed you !     "
  3388  3c3e 4409040e27142019...!scr "Didn't you see the       laser beam ?!?           "
  3389  3c70 32343020560f0c14...!scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  3390  3ca2 590f152013140510...!scr "You stepped on a nail !                           "
  3391  3cd4 4120060f0f142014...!scr "A foot trap stopped you !                         "
  3392  3d06 5408091320120f0f...!scr "This room is doomed      by the wizard Manilo !   "
  3393  3d38 590f152017051205...!scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  3394  3d6a 590f152017051205...!scr "You were hit by a big    rock and died !          "
  3395  3d9c 42050c0507120f20...!scr "Belegro killed           you !                    "
  3396  3dce 590f1520060f150e...!scr "You found a thirsty      zombie .......           "
  3397  3e00 540805200d0f0e13...!scr "The monster grapped       you. You are dead !     "
  3398  3e32 590f152017051205...!scr "You were wounded by      the bush !               "
  3399  3e64 590f152001120520...!scr "You are trapped in       wire-nettings !          "
  3400                          }
  3401                          
  3402                          
  3403                          !if LANGUAGE = DE{
  3404                          !scr "Sie sind in eine         Schlangengrube gefallen !"
  3405                          !scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  3406                          !scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  3407                          !scr "Sie haben aus der Gift-  flasche getrunken....... "
  3408                          !scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  3409                          !scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  3410                          !scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  3411                          !scr "Sie sind in einen Nagel  getreten !               "
  3412                          !scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  3413                          !scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  3414                          !scr "Sie wurden eingeschlossenund verhungern !         "
  3415                          !scr "Sie wurden von einem     Stein ueberollt !!       "
  3416                          !scr "Belegro hat Sie          vernichtet !             "
  3417                          !scr "Im Sarg lag ein durstigerZombie........           "
  3418                          !scr "Das Monster hat Sie      erwischt !!!!!           "
  3419                          !scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  3420                          !scr "Sie haben sich im        Stacheldraht verfangen !!"
  3421                          }
  3422                          
  3423                          ; ==============================================================================
  3424                          ; screen messages
  3425                          ; and the code entry text
  3426                          ; ==============================================================================
  3427                          
  3428                          !if LANGUAGE = EN{
  3429                          
  3430                          hint_messages:
  3431  3e96 2041201001121420...!scr " A part of the code number is :         "
  3432  3ebe 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3433  3ee6 20590f15200e0505...!scr " You need: bulb, bulb holder, socket !  "
  3434  3f0e 2054050c0c200d05...!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  3435  3f36 202a2a2a2a2a2020...!scr " *****   A helping letter :   "
  3436  3f54 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  3437  3f5e 2057120f0e072003...!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  3438                          
  3439                          }
  3440                          
  3441                          !if LANGUAGE = DE{
  3442                          
  3443                          hint_messages:
  3444                          !scr " Ein Teil des Loesungscodes lautet:     "
  3445                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3446                          !scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  3447                          !scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  3448                          !scr " *****   Ein Hilfsbuchstabe:  "
  3449                          helping_letter: !scr "C   ***** "
  3450                          !scr " Falscher Loesungscode ! TODESSTRAFE !! "
  3451                          
  3452                          }
  3453                          
  3454                          
  3455                          ; ==============================================================================
  3456                          ;
  3457                          ; ITEM PICKUP MESSAGES
  3458                          ; ==============================================================================
  3459                          
  3460                          
  3461                          item_pickup_message:              ; item pickup messages
  3462                          
  3463                          !if LANGUAGE = EN{
  3464  3f86 2054080512052009...!scr " There is a key in the bottle !         "
  3465  3fae 2020205408051205...!scr "   There is a key in the coffin !       "
  3466  3fd6 2054080512052009...!scr " There is a breathing tube !            "
  3467                          }
  3468                          
  3469                          !if LANGUAGE = DE{
  3470                          !scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
  3471                          !scr "    In dem Sarg lag ein Schluessel !    "
  3472                          !scr " Unter dem Stein lag ein Taucheranzug ! "
  3473                          }
  3474                          item_pickup_message_end:
