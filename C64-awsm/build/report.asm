
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
    39                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $02 ; red
    40                              MULTICOLOR_1        = $0a           ; face pink
    41                              MULTICOLOR_2        = $09
    42                              BORDER_COLOR_VALUE  = $02
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
    64                          START_ROOM          = 16             ; default 0 
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
    91                          zp03                = $03               ; high byte of screen ram
    92                          zp04                = $04               ; low byte of screen ram
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
   109                          BASIC_DA89          = $e8ea             ; $da89             ; scroll screen down?
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
   162  1000 20423b                                 jsr clear               ;     jsr PRINT_KERNAL   
   163                                                   
   164                          
   165                          display_hint_message:
   166                                             
   167                          
   168  1003 a93e                                   lda #>hint_messages
   169  1005 85a8                                   sta zpA8
   170  1007 a9b4                                   lda #<hint_messages
   171  1009 c000               m1009:              cpy #$00
   172  100b f00a                                   beq ++              
   173  100d 18                 -                   clc
   174  100e 6928                                   adc #$28
   175  1010 9002                                   bcc +               
   176  1012 e6a8                                   inc zpA8
   177  1014 88                 +                   dey
   178  1015 d0f6                                   bne -               
   179  1017 85a7               ++                  sta zpA7
   180  1019 20263a                                 jsr set_charset_and_screen 
   181                          
   182  101c a027                                   ldy #$27
   183  101e b1a7               -                   lda (zpA7),y
   184  1020 99b805                                 sta SCREENRAM+$1B8,y 
   185  1023 a905                                   lda #$05
   186  1025 99b8d9                                 sta COLRAM+$1B8,y 
   187  1028 88                                     dey
   188  1029 d0f3                                   bne -  
   189                                                 
   190  102b 60                                     rts
   191                          
   192                          
   193                          ; ==============================================================================
   194                          ;
   195                          ;
   196                          ; ==============================================================================
   197                          
   198                          prep_and_display_hint:
   199                          
   200  102c 204b11                                 jsr switch_charset           
   201  102f c003                                   cpy #$03                                ; is the display hint the one for the code number?
   202  1031 f003                                   beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
   203  1033 4cd310                                 jmp display_hint                        ; no, display the hint
   204                          
   205                          
   206                          room_16_code_number_prep:
   207                          
   208  1036 200310                                 jsr display_hint_message                ; yes we are in room 3
   209  1039 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   210  103c 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   211                                             
   212  103f a001                                   ldy #$01                                ; y = 1
   213  1041 200310                                 jsr display_hint_message              
   214  1044 a200                                   ldx #$00                                ; x = 0
   215  1046 a000                                   ldy #$00                                ; y = 0
   216  1048 f013                                   beq room_16_enter_code                  ; room 16 code? how?
   217                          
   218                          room_16_cursor_blinking: 
   219                          
   220  104a bdb905                                 lda SCREENRAM+$1B9,x                    ; load something from screen
   221  104d 18                                     clc                                     
   222  104e 6980                                   adc #$80                                ; add $80 = 128 = inverted char
   223  1050 9db905                                 sta SCREENRAM+$1B9,x                    ; store in the same location
   224  1053 b98805                                 lda SCREENRAM+$188,y                    ; and the same for another position
   225  1056 18                                     clc
   226  1057 6980                                   adc #$80
   227  1059 998805                                 sta SCREENRAM+$188,y 
   228  105c 60                                     rts
   229                          
   230                          ; ==============================================================================
   231                          ; ROOM 16
   232                          ; ENTER CODE
   233                          ; ==============================================================================
   234                          
   235                          room_16_enter_code:
   236                                              
   237  105d 204a10                                 jsr room_16_cursor_blinking
   238  1060 8402                                   sty zp02
   239  1062 8604                                   stx zp04
   240  1064 20a010                                 jsr room_16_code_delay           
   241  1067 204a10                                 jsr room_16_cursor_blinking           
   242  106a 20a010                                 jsr room_16_code_delay
   243  106d ad00dc                                 lda $dc00
   244                                              ;lda #$fd                                        ; KEYBOARD stuff
   245                                              ;sta KEYBOARD_LATCH                              ; .
   246                                              ;lda KEYBOARD_LATCH                              ; .
   247  1070 4a                                     lsr                                             ; .
   248  1071 4a                                     lsr
   249  1072 4a                                     lsr
   250  1073 b005                                   bcs +
   251  1075 e000                                   cpx #$00
   252  1077 f001                                   beq +
   253  1079 ca                                     dex
   254  107a 4a                 +                   lsr
   255  107b b005                                   bcs +
   256  107d e025                                   cpx #$25
   257  107f f001                                   beq +
   258  1081 e8                                     inx
   259  1082 2908               +                   and #$08
   260  1084 d0d7                                   bne room_16_enter_code
   261  1086 bdb905                                 lda SCREENRAM+$1B9,x
   262  1089 c9bc                                   cmp #$bc
   263  108b d008                                   bne ++
   264  108d c000                                   cpy #$00
   265  108f f001                                   beq +
   266  1091 88                                     dey
   267  1092 4c5d10             +                   jmp room_16_enter_code
   268  1095 998805             ++                  sta SCREENRAM+$188,y
   269  1098 c8                                     iny
   270  1099 c005                                   cpy #$05
   271  109b d0c0                                   bne room_16_enter_code
   272  109d 4caa10                                 jmp check_code_number
   273                          
   274                          ; ==============================================================================
   275                          ;
   276                          ; DELAYS CURSOR MOVEMENT AND BLINKING
   277                          ; ==============================================================================
   278                          
   279                          room_16_code_delay:
   280  10a0 a035                                   ldy #$35                            ; wait a bit
   281  10a2 20ff39                                 jsr wait                        
   282  10a5 a402                                   ldy zp02                            ; and load x and y 
   283  10a7 a604                                   ldx zp04                            ; with shit from zp
   284  10a9 60                                     rts
   285                          
   286                          ; ==============================================================================
   287                          ; ROOM 16
   288                          ; CHECK THE CODE NUMBER
   289                          ; ==============================================================================
   290                          
   291                          check_code_number:
   292  10aa a205                                   ldx #$05                            ; x = 5
   293  10ac bd8705             -                   lda SCREENRAM+$187,x                ; get one number from code
   294  10af ddc110                                 cmp code_number-1,x                 ; is it correct?
   295  10b2 d006                                   bne +                               ; no -> +
   296  10b4 ca                                     dex                                 ; yes, check next number
   297  10b5 d0f5                                   bne -                               
   298  10b7 4cc710                                 jmp ++                              ; all correct -> ++
   299  10ba a005               +                   ldy #$05                            ; text for wrong code number
   300  10bc 200310                                 jsr display_hint_message            ; wrong code -> death
   301  10bf 4c333b                                 jmp m3EF9          
   302                          
   303  10c2 3036313338         code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38
   304                          
   305  10c7 20063a             ++                  jsr set_game_basics                 ; code correct, continue
   306  10ca 20e039                                 jsr set_player_xy          
   307  10cd 208b3a                                 jsr draw_border          
   308  10d0 4cd53a                                 jmp main_loop          
   309                          
   310                          ; ==============================================================================
   311                          ;
   312                          ; hint system (question marks)
   313                          ; ==============================================================================
   314                          
   315                          
   316                          display_hint:
   317  10d3 c000                                   cpy #$00
   318  10d5 d04a                                   bne m11A2           
   319  10d7 200010                                 jsr display_hint_message_plus_kernal
   320  10da aef82f                                 ldx current_room + 1
   321  10dd e001                                   cpx #$01
   322  10df d002                                   bne +               
   323  10e1 a928                                   lda #$28
   324  10e3 e005               +                   cpx #$05
   325  10e5 d002                                   bne +               
   326  10e7 a929                                   lda #$29
   327  10e9 e00a               +                   cpx #$0a
   328  10eb d002                                   bne +               
   329  10ed a947                                   lda #$47                   
   330  10ef e00c               +                   cpx #$0c
   331  10f1 d002                                   bne +
   332  10f3 a949                                   lda #$49
   333  10f5 e00d               +                   cpx #$0d
   334  10f7 d002                                   bne +
   335  10f9 a945                                   lda #$45
   336  10fb e00f               +                   cpx #$0f
   337  10fd d00a                                   bne +               
   338  10ff a945                                   lda #$45
   339                                             
   340  1101 8d6fda                                 sta COLRAM + $26f       
   341  1104 a90f                                   lda #$0f
   342  1106 8d6f06                                 sta SCREENRAM + $26f       
   343  1109 8d1f06             +                   sta SCREENRAM + $21f       
   344  110c a948                                   lda #$48
   345  110e 8d1fda                                 sta COLRAM + $21f       
   346  1111 ad00dc             -                   lda $dc00                         ;lda #$fd
   347                                                                                ;sta KEYBOARD_LATCH
   348                                                                                ; lda KEYBOARD_LATCH
   349  1114 2910                                   and #$10                          ; and #$80
   350  1116 d0f9                                   bne -               
   351  1118 20063a                                 jsr set_game_basics
   352  111b 20f639                                 jsr m3A2D          
   353  111e 4cd53a                                 jmp main_loop         
   354  1121 c002               m11A2:              cpy #$02
   355  1123 d006                                   bne +             
   356  1125 200010             m11A6:              jsr display_hint_message_plus_kernal
   357  1128 4c1111                                 jmp -             
   358  112b c004               +                   cpy #$04
   359  112d d00b                                   bne +              
   360  112f ad0b39                                 lda m3952 + 1    
   361  1132 18                                     clc
   362  1133 6940                                   adc #$40                                        ; this is the helping letter
   363  1135 8d723f                                 sta helping_letter         
   364  1138 d0eb                                   bne m11A6          
   365  113a 88                 +                   dey
   366  113b 88                                     dey
   367  113c 88                                     dey
   368  113d 88                                     dey
   369  113e 88                                     dey
   370  113f a93f                                   lda #>item_pickup_message
   371  1141 85a8                                   sta zpA8
   372  1143 a9a4                                   lda #<item_pickup_message
   373  1145 200910                                 jsr m1009
   374  1148 4c1111                                 jmp -
   375                          
   376                          ; ==============================================================================
   377                          
   378                          switch_charset:
   379  114b 20263a                                 jsr set_charset_and_screen           
   380  114e 4c423b                                 jmp clear       ; jmp PRINT_KERNAL           
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
   401                          
   402                          
   403                          
   404                          
   405                          
   406                          
   407                          
   408                          ; ==============================================================================
   409                          ;
   410                          ; JUMP TO ROOM LOGIC
   411                          ; This code is new. Previously, code execution jumped from room to room
   412                          ; and in each room did the comparison with the room number.
   413                          ; This is essentially the same, but bundled in one place.
   414                          ; not calles in between room changes, only e.g. for question mark
   415                          ; ==============================================================================
   416                          
   417                          check_room:
   418  1151 acf82f                                 ldy current_room + 1        ; load in the current room number
   419  1154 c000                                   cpy #0
   420  1156 d003                                   bne +
   421  1158 4cf311                                 jmp room_00
   422  115b c001               +                   cpy #1
   423  115d d003                                   bne +
   424  115f 4c0e12                                 jmp room_01
   425  1162 c002               +                   cpy #2
   426  1164 d003                                   bne +
   427  1166 4c4b12                                 jmp room_02
   428  1169 c003               +                   cpy #3
   429  116b d003                                   bne +
   430  116d 4ca112                                 jmp room_03
   431  1170 c004               +                   cpy #4
   432  1172 d003                                   bne +
   433  1174 4cad12                                 jmp room_04
   434  1177 c005               +                   cpy #5
   435  1179 d003                                   bne +
   436  117b 4ccf12                                 jmp room_05
   437  117e c006               +                   cpy #6
   438  1180 d003                                   bne +
   439  1182 4cf312                                 jmp room_06
   440  1185 c007               +                   cpy #7
   441  1187 d003                                   bne +
   442  1189 4cff12                                 jmp room_07
   443  118c c008               +                   cpy #8
   444  118e d003                                   bne +
   445  1190 4c3713                                 jmp room_08
   446  1193 c009               +                   cpy #9
   447  1195 d003                                   bne +
   448  1197 4c8e13                                 jmp room_09
   449  119a c00a               +                   cpy #10
   450  119c d003                                   bne +
   451  119e 4c9a13                                 jmp room_10
   452  11a1 c00b               +                   cpy #11
   453  11a3 d003                                   bne +
   454  11a5 4cca13                                 jmp room_11 
   455  11a8 c00c               +                   cpy #12
   456  11aa d003                                   bne +
   457  11ac 4cd913                                 jmp room_12
   458  11af c00d               +                   cpy #13
   459  11b1 d003                                   bne +
   460  11b3 4cf513                                 jmp room_13
   461  11b6 c00e               +                   cpy #14
   462  11b8 d003                                   bne +
   463  11ba 4c1914                                 jmp room_14
   464  11bd c00f               +                   cpy #15
   465  11bf d003                                   bne +
   466  11c1 4c2514                                 jmp room_15
   467  11c4 c010               +                   cpy #16
   468  11c6 d003                                   bne +
   469  11c8 4c3114                                 jmp room_16
   470  11cb c011               +                   cpy #17
   471  11cd d003                                   bne +
   472  11cf 4c5714                                 jmp room_17
   473  11d2 4c6614             +                   jmp room_18
   474                          
   475                          
   476                          
   477                          ; ==============================================================================
   478                          
   479                          check_death:
   480  11d5 20d237                                 jsr update_items_display
   481  11d8 4cd53a                                 jmp main_loop           
   482                          
   483                          ; ==============================================================================
   484                          
   485                          m11E0:              
   486  11db a200                                   ldx #$00
   487  11dd bd4503             -                   lda TAPE_BUFFER + $9,x              
   488  11e0 c91e                                   cmp #$1e                            ; question mark
   489  11e2 9007                                   bcc check_next_char_under_player           
   490  11e4 c9df                                   cmp #$df
   491  11e6 f003                                   beq check_next_char_under_player
   492  11e8 4c5111                                 jmp check_room              
   493                          
   494                          ; ==============================================================================
   495                          
   496                          check_next_char_under_player:
   497  11eb e8                                     inx
   498  11ec e009                                   cpx #$09
   499  11ee d0ed                                   bne -                              ; not done checking          
   500  11f0 4cd53a             -                   jmp main_loop           
   501                          
   502                          
   503                          ; ==============================================================================
   504                          ;
   505                          ;                                                             ###        ###
   506                          ;          #####      ####      ####     #    #              #   #      #   #
   507                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   508                          ;          #    #    #    #    #    #    # ## #             #     #    #     #
   509                          ;          #####     #    #    #    #    #    #             #     #    #     #
   510                          ;          #   #     #    #    #    #    #    #              #   #      #   #
   511                          ;          #    #     ####      ####     #    #               ###        ###
   512                          ;
   513                          ; ==============================================================================
   514                          
   515                          
   516                          room_00:
   517                          
   518  11f3 c9a9                                   cmp #$a9                                        ; has the player hit the gloves?
   519  11f5 d0f4                                   bne check_next_char_under_player                ; no
   520  11f7 a9df                                   lda #$df                                        ; yes, load in char for "empty"
   521  11f9 cd6336                                 cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
   522  11fc d0f2                                   bne -                                           ; no
   523  11fe 200312                                 jsr pickup_gloves                               ; yes
   524  1201 d0d2                                   bne check_death
   525                          
   526                          
   527                          pickup_gloves:
   528  1203 a96b                                   lda #$6b                                        ; load character for empty bush
   529  1205 8d1e36                                 sta items + $8                                  ; store 6b = gloves in inventory
   530  1208 a93d                                   lda #$3d                                        ; set the foreground color
   531  120a 8d1c36                                 sta items + $6                                  ; and store the color in the items table
   532  120d 60                                     rts
   533                          
   534                          
   535                          
   536                          
   537                          
   538                          
   539                          ; ==============================================================================
   540                          ;
   541                          ;                                                             ###        #
   542                          ;          #####      ####      ####     #    #              #   #      ##
   543                          ;          #    #    #    #    #    #    ##  ##             #     #    # #
   544                          ;          #    #    #    #    #    #    # ## #             #     #      #
   545                          ;          #####     #    #    #    #    #    #             #     #      #
   546                          ;          #   #     #    #    #    #    #    #              #   #       #
   547                          ;          #    #     ####      ####     #    #               ###      #####
   548                          ;
   549                          ; ==============================================================================
   550                          
   551                          room_01:
   552                          
   553  120e c9e0                                   cmp #$e0                                    ; empty character in charset -> invisible key
   554  1210 f004                                   beq +                                       ; yes, key is there -> +
   555  1212 c9e1                                   cmp #$e1
   556  1214 d014                                   bne ++
   557  1216 a9aa               +                   lda #$aa                                    ; display the key, $AA = 1st part of key
   558  1218 8d2636                                 sta items + $10                             ; store key in items list
   559  121b 20d237                                 jsr update_items_display                    ; update all items in the items list (we just made the key visible)
   560  121e a0f0                                   ldy #$f0                                    ; set waiting time
   561  1220 20ff39                                 jsr wait                                    ; wait
   562  1223 a9df                                   lda #$df                                    ; set key to empty space
   563  1225 8d2636                                 sta items + $10                             ; update items list
   564  1228 d0ab                                   bne check_death
   565  122a c927               ++                  cmp #$27                                    ; question mark (I don't know why 27)
   566  122c b005                                   bcs check_death_bush
   567  122e a000                                   ldy #$00
   568  1230 4c2c10                                 jmp prep_and_display_hint
   569                          
   570                          check_death_bush:
   571  1233 c9ad                                   cmp #$ad                                    ; wirecutters
   572  1235 d0b4                                   bne check_next_char_under_player
   573  1237 ad1e36                                 lda items + $8                              ; inventory place for the gloves! 6b = gloves
   574  123a c96b                                   cmp #$6b
   575  123c f005                                   beq +
   576  123e a00f                                   ldy #$0f
   577  1240 4ce33a                                 jmp death                                   ; 0f You were wounded by the bush!
   578                          
   579  1243 a9f9               +                   lda #$f9                                    ; wirecutter picked up
   580  1245 8d2f36                                 sta items + $19
   581  1248 4cd511                                 jmp check_death
   582                          
   583                          
   584                          
   585                          
   586                          
   587                          
   588                          ; ==============================================================================
   589                          ;
   590                          ;                                                             ###       #####
   591                          ;          #####      ####      ####     #    #              #   #     #     #
   592                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   593                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   594                          ;          #####     #    #    #    #    #    #             #     #    #
   595                          ;          #   #     #    #    #    #    #    #              #   #     #
   596                          ;          #    #     ####      ####     #    #               ###      #######
   597                          ;
   598                          ; ==============================================================================
   599                          
   600                          room_02:
   601                          
   602  124b c9f5                                   cmp #$f5                                    ; did the player hit the fence? f5 = fence character
   603  124d d014                                   bne check_lock                              ; no, check for the lock
   604  124f ad2f36                                 lda items + $19                             ; fence was hit, so check if wirecuter was picked up
   605  1252 c9f9                                   cmp #$f9                                    ; where the wirecutters (f9) picked up?
   606  1254 f005                                   beq remove_fence                            ; yes
   607  1256 a010                                   ldy #$10                                    ; no, load the correct death message
   608  1258 4ce33a                                 jmp death                                   ; 10 You are trapped in wire-nettings!
   609                          
   610                          remove_fence:
   611  125b a9df                                   lda #$df                                    ; empty char
   612  125d 8db538                                 sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
   613  1260 4cd511             m1264:              jmp check_death
   614                          
   615                          
   616                          check_lock:
   617  1263 c9a6                                   cmp #$a6                                    ; lock
   618  1265 d00e                                   bne +
   619  1267 ad2636                                 lda items + $10
   620  126a c9df                                   cmp #$df
   621  126c d0f2                                   bne m1264
   622  126e a9df                                   lda #$df
   623  1270 8d4e36                                 sta items + $38
   624  1273 d0eb                                   bne m1264
   625  1275 c9b1               +                   cmp #$b1                                    ; ladder
   626  1277 d00a                                   bne +
   627  1279 a9df                                   lda #$df
   628  127b 8d6336                                 sta items + $4d
   629  127e 8d6e36                                 sta items + $58
   630  1281 d0dd                                   bne m1264
   631  1283 c9b9               +                   cmp #$b9                                    ; bottle
   632  1285 f003                                   beq +
   633  1287 4ceb11                                 jmp check_next_char_under_player
   634  128a add136             +                   lda items + $bb
   635  128d c9df                                   cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
   636  128f f005                                   beq take_key_out_of_bottle                                   
   637  1291 a003                                   ldy #$03
   638  1293 4ce33a                                 jmp death                                   ; 03 You drank from the poisend bottle
   639                          
   640                          take_key_out_of_bottle:
   641  1296 a901                                   lda #$01
   642  1298 8da012                                 sta key_in_bottle_storage
   643  129b a005                                   ldy #$05
   644  129d 4c2c10                                 jmp prep_and_display_hint
   645                          
   646                          ; ==============================================================================
   647                          ; this is 1 if the key from the bottle was taken and 0 if not
   648                          
   649  12a0 00                 key_in_bottle_storage:              !byte $00
   650                          
   651                          
   652                          
   653                          
   654                          
   655                          
   656                          
   657                          
   658                          
   659                          ; ==============================================================================
   660                          ;
   661                          ;                                                             ###       #####
   662                          ;          #####      ####      ####     #    #              #   #     #     #
   663                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   664                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   665                          ;          #####     #    #    #    #    #    #             #     #          #
   666                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   667                          ;          #    #     ####      ####     #    #               ###       #####
   668                          ;
   669                          ; ==============================================================================
   670                          
   671                          room_03:
   672                          
   673  12a1 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   674  12a3 9003                                   bcc +
   675  12a5 4cd53a                                 jmp main_loop
   676  12a8 a004               +                   ldy #$04
   677  12aa 4c2c10                                 jmp prep_and_display_hint
   678                          
   679                          
   680                          
   681                          
   682                          
   683                          
   684                          ; ==============================================================================
   685                          ;
   686                          ;                                                             ###      #
   687                          ;          #####      ####      ####     #    #              #   #     #    #
   688                          ;          #    #    #    #    #    #    ##  ##             #     #    #    #
   689                          ;          #    #    #    #    #    #    # ## #             #     #    #    #
   690                          ;          #####     #    #    #    #    #    #             #     #    #######
   691                          ;          #   #     #    #    #    #    #    #              #   #          #
   692                          ;          #    #     ####      ####     #    #               ###           #
   693                          ;
   694                          ; ==============================================================================
   695                          
   696                          room_04:
   697                          
   698  12ad c93b                                   cmp #$3b                                    ; you bumped into a zombie coffin?
   699  12af f004                                   beq +                                       ; yep
   700  12b1 c942                                   cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
   701  12b3 d005                                   bne ++                                      ; no, really, I didn't ( I swear! )-> ++
   702  12b5 a00d               +                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
   703  12b7 4ce33a                                 jmp death                                   ; 0d You found a thirsty zombie....
   704                          
   705                          ++
   706  12ba c9f7                                   cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
   707  12bc f007                                   beq +                                       ; seems you picked a coffin that contained something different...
   708  12be c9f8                                   cmp #$f8
   709  12c0 f003                                   beq +
   710  12c2 4ceb11                                 jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
   711  12c5 a900               +                   lda #$00                                    ; 
   712  12c7 8d0339                                 sta m394A + 1                               ; some kind of prep for the door to be unlocked 
   713  12ca a006                                   ldy #$06                                    ; display
   714  12cc 4c2c10                                 jmp prep_and_display_hint
   715                          
   716                          
   717                          
   718                          
   719                          
   720                          
   721                          ; ==============================================================================
   722                          ;
   723                          ;                                                             ###      #######
   724                          ;          #####      ####      ####     #    #              #   #     #
   725                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   726                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   727                          ;          #####     #    #    #    #    #    #             #     #          #
   728                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   729                          ;          #    #     ####      ####     #    #               ###       #####
   730                          ;
   731                          ; ==============================================================================
   732                          
   733                          room_05:
   734                          
   735  12cf c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   736  12d1 b005                                   bcs +                                       ; no
   737  12d3 a000                                   ldy #$00                                    ; a = 0
   738  12d5 4c2c10                                 jmp prep_and_display_hint
   739                          
   740  12d8 c9fd               +                   cmp #$fd                                    ; stone with breathing tube hit?
   741  12da f003                                   beq +                                       ; yes -> +
   742  12dc 4ceb11                                 jmp check_next_char_under_player            ; no
   743                          
   744  12df a900               +                   lda #$00                                    ; a = 0                  
   745  12e1 acac36                                 ldy items + $96                             ; do you have the shovel? 
   746  12e4 c0df                                   cpy #$df
   747  12e6 d008                                   bne +                                       ; no I don't
   748  12e8 8d9138                                 sta breathing_tube_mod + 1                  ; yes, take the breathing tube
   749  12eb a007                                   ldy #$07                                    ; and display the message
   750  12ed 4c2c10                                 jmp prep_and_display_hint
   751  12f0 4cd53a             +                   jmp main_loop
   752                          
   753                                              ;ldy #$07                                   ; same is happening above and I don't see this being called
   754                                              ;jmp prep_and_display_hint
   755                          
   756                          
   757                          
   758                          
   759                          
   760                          
   761                          ; ==============================================================================
   762                          ;
   763                          ;                                                             ###       #####
   764                          ;          #####      ####      ####     #    #              #   #     #     #
   765                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   766                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   767                          ;          #####     #    #    #    #    #    #             #     #    #     #
   768                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   769                          ;          #    #     ####      ####     #    #               ###       #####
   770                          ;
   771                          ; ==============================================================================
   772                          
   773                          room_06:
   774                          
   775  12f3 c9f6                                   cmp #$f6                                    ; is it a trapped door?
   776  12f5 f003                                   beq +                                       ; OMG Yes the room is full of...
   777  12f7 4ceb11                                 jmp check_next_char_under_player            ; please move on. nothing happened.
   778  12fa a000               +                   ldy #$00
   779  12fc 4ce33a                                 jmp death                                   ; 00 You fell into a snake pit
   780                          
   781                          
   782                          
   783                          
   784                          
   785                          
   786                          ; ==============================================================================
   787                          ;
   788                          ;                                                             ###      #######
   789                          ;          #####      ####      ####     #    #              #   #     #    #
   790                          ;          #    #    #    #    #    #    ##  ##             #     #        #
   791                          ;          #    #    #    #    #    #    # ## #             #     #       #
   792                          ;          #####     #    #    #    #    #    #             #     #      #
   793                          ;          #   #     #    #    #    #    #    #              #   #       #
   794                          ;          #    #     ####      ####     #    #               ###        #
   795                          ;
   796                          ; ==============================================================================
   797                          
   798                          room_07:
   799                                  
   800  12ff c9e3                                   cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
   801  1301 d005                                   bne +
   802  1303 a001                                   ldy #$01                                    ; 01 You'd better watched out for the sacred column
   803  1305 4ce33a                                 jmp death                                   ; bne m1303 <- seems unneccessary
   804                          
   805  1308 c95f               +                   cmp #$5f                                    ; seems to be the invisible char for the light
   806  130a f003                                   beq +                                       ; and it was hit -> +
   807  130c 4ceb11                                 jmp check_next_char_under_player            ; if not, continue checking
   808                          
   809  130f a9bc               +                   lda #$bc                                    ; make light visible
   810  1311 8d8a36                                 sta items + $74                             ; but I dont understand how the whole light is shown
   811  1314 a95f                                   lda #$5f                                    ; color?
   812  1316 8d8836                                 sta items + $72                             ; 
   813  1319 20d237                                 jsr update_items_display                    ; and redraw items
   814  131c a0ff                                   ldy #$ff
   815  131e 20ff39                                 jsr wait                                    ; wait for some time so the player can actually see the light
   816  1321 20ff39                                 jsr wait
   817  1324 20ff39                                 jsr wait
   818  1327 20ff39                                 jsr wait
   819  132a a9df                                   lda #$df
   820  132c 8d8a36                                 sta items + $74                             ; and pick up the light/ remove it from the items list
   821  132f a900                                   lda #$00
   822  1331 8d8836                                 sta items + $72                             ; also paint the char black
   823  1334 4cd511                                 jmp check_death
   824                          
   825                          
   826                          
   827                          
   828                          
   829                          
   830                          ; ==============================================================================
   831                          ;
   832                          ;                                                             ###       #####
   833                          ;          #####      ####      ####     #    #              #   #     #     #
   834                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   835                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   836                          ;          #####     #    #    #    #    #    #             #     #    #     #
   837                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   838                          ;          #    #     ####      ####     #    #               ###       #####
   839                          ;
   840                          ; ==============================================================================
   841                          
   842                          room_08:
   843                          
   844  1337 a000                                   ldy #$00                                    ; y = 0
   845  1339 84a7                                   sty zpA7                                    ; zpA7 = 0
   846  133b c94b                                   cmp #$4b                                    ; water
   847  133d d015                                   bne check_item_water
   848  133f ac9138                                 ldy breathing_tube_mod + 1
   849  1342 d017                                   bne +
   850  1344 209635                                 jsr get_player_pos
   851  1347 a918                                   lda #$18                                    ; move player on the other side of the river
   852  1349 8d4235             --                  sta player_pos_x + 1
   853  134c a90c                                   lda #$0c
   854  134e 8d4035                                 sta player_pos_y + 1
   855  1351 4cd53a             -                   jmp main_loop
   856                          
   857                          
   858                          check_item_water:
   859  1354 c956                                   cmp #$56                                    ; so you want to swim right?
   860  1356 d011                                   bne check_item_shovel                       ; nah, not this time -> check_item_shovel
   861  1358 ac9138                                 ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
   862  135b d007               +                   bne +
   863  135d 209635                                 jsr get_player_pos                          ; tube equipped and ready to submerge
   864  1360 a90c                                   lda #$0c
   865  1362 d0e5                                   bne --                                      ; see you on the other side!
   866                          
   867  1364 a002               +                   ldy #$02                                    ; breathing what?
   868  1366 4ce33a                                 jmp death                                   ; 02 You drowned in the deep river
   869                          
   870                          
   871                          check_item_shovel:
   872  1369 c9c1                                   cmp #$c1                                    ; wanna have that shovel?
   873  136b f004                                   beq +                                       ; yup
   874  136d c9c3                                   cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
   875  136f d008                                   bne ++                                      ; nah still not interested -> ++
   876  1371 a9df               +                   lda #$df                                    ; alright cool,
   877  1373 8dac36                                 sta items + $96                             ; shovel is yours now
   878  1376 4cd511             --                  jmp check_death
   879                          
   880                          
   881  1379 c9ca               ++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
   882  137b f003                                   beq +                                       ; yup
   883  137d 4ceb11                                 jmp check_next_char_under_player
   884  1380 add136             +                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
   885  1383 c9df                                   cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
   886  1385 d0ca                                   bne -                                       ; what hammer?
   887  1387 a9df                                   lda #$df
   888  1389 8d9a36                                 sta items + $84                             ; these fine boots are yours now, sir
   889  138c d0e8                                   bne --
   890                          
   891                          
   892                          
   893                          
   894                          
   895                          
   896                          ; ==============================================================================
   897                          ;
   898                          ;                                                             ###       #####
   899                          ;          #####      ####      ####     #    #              #   #     #     #
   900                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   901                          ;          #    #    #    #    #    #    # ## #             #     #     ######
   902                          ;          #####     #    #    #    #    #    #             #     #          #
   903                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   904                          ;          #    #     ####      ####     #    #               ###       #####
   905                          ;
   906                          ; ==============================================================================
   907                          
   908                          room_09:            
   909                          
   910  138e c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   911  1390 9003                                   bcc +                                       ; yes -> +
   912  1392 4ceb11                                 jmp check_next_char_under_player            ; continue checking
   913  1395 a002               +                   ldy #$02                                    ; display hint
   914  1397 4c2c10                                 jmp prep_and_display_hint
   915                          
   916                          
   917                          
   918                          
   919                          
   920                          
   921                          ; ==============================================================================
   922                          ;
   923                          ;                                                             #        ###
   924                          ;          #####      ####      ####     #    #              ##       #   #
   925                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
   926                          ;          #    #    #    #    #    #    # ## #               #      #     #
   927                          ;          #####     #    #    #    #    #    #               #      #     #
   928                          ;          #   #     #    #    #    #    #    #               #       #   #
   929                          ;          #    #     ####      ####     #    #             #####      ###
   930                          ;
   931                          ; ==============================================================================
   932                          
   933                          room_10:
   934                          
   935  139a c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   936  139c b005                                   bcs +
   937  139e a000                                   ldy #$00                                    ; display hint
   938  13a0 4c2c10                                 jmp prep_and_display_hint
   939                          
   940  13a3 c9cc               +                   cmp #$cc                                    ; hit the power outlet?
   941  13a5 f007                                   beq +                                       ; yes -> +
   942  13a7 c9cf                                   cmp #$cf                                    ; hit the power outlet?
   943  13a9 f003                                   beq +                                       ; yes -> +
   944  13ab 4ceb11                                 jmp check_next_char_under_player            ; no, continue
   945  13ae a9df               +                   lda #$df                                    
   946  13b0 cd8a36                                 cmp items + $74                             ; light picked up?
   947  13b3 d010                                   bne +                                       ; no -> death
   948  13b5 cdde36                                 cmp items + $c8                             ; yes, lightbulb picked up?
   949  13b8 d00b                                   bne +                                       ; no -> death
   950  13ba 8dc236                                 sta items + $ac                             ; yes, pick up power outlet
   951  13bd a959                                   lda #$59                                    ; and make the foot traps visible
   952  13bf 8d4237                                 sta items + $12c                            ; color position for foot traps
   953  13c2 4cd511                                 jmp check_death
   954                          
   955  13c5 a006               +                   ldy #$06
   956  13c7 4ce33a                                 jmp death                                   ; 06 240 Volts! You got an electrical shock!
   957                          
   958                          
   959                          
   960                          
   961                          
   962                          
   963                          ; ==============================================================================
   964                          ;
   965                          ;                                                             #        #
   966                          ;          #####      ####      ####     #    #              ##       ##
   967                          ;          #    #    #    #    #    #    ##  ##             # #      # #
   968                          ;          #    #    #    #    #    #    # ## #               #        #
   969                          ;          #####     #    #    #    #    #    #               #        #
   970                          ;          #   #     #    #    #    #    #    #               #        #
   971                          ;          #    #     ####      ####     #    #             #####    #####
   972                          ;
   973                          ; ==============================================================================
   974                          
   975                          room_11:
   976                          
   977  13ca c9d1                                   cmp #$d1                                    ; picking up the hammer?
   978  13cc f003                                   beq +                                       ; jep
   979  13ce 4ceb11                                 jmp check_next_char_under_player            ; no, continue
   980  13d1 a9df               +                   lda #$df                                    ; player takes the hammer
   981  13d3 8dd136                                 sta items + $bb                             ; hammer
   982  13d6 4cd511                                 jmp check_death
   983                          
   984                          
   985                          
   986                          
   987                          
   988                          
   989                          ; ==============================================================================
   990                          ;
   991                          ;                                                             #       #####
   992                          ;          #####      ####      ####     #    #              ##      #     #
   993                          ;          #    #    #    #    #    #    ##  ##             # #            #
   994                          ;          #    #    #    #    #    #    # ## #               #       #####
   995                          ;          #####     #    #    #    #    #    #               #      #
   996                          ;          #   #     #    #    #    #    #    #               #      #
   997                          ;          #    #     ####      ####     #    #             #####    #######
   998                          ;
   999                          ; ==============================================================================
  1000                          
  1001                          room_12:
  1002                          
  1003  13d9 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1004  13db b005                                   bcs +                                       ; no
  1005  13dd a000                                   ldy #$00                                    
  1006  13df 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1007                          
  1008  13e2 c9d2               +                   cmp #$d2                                    ; light bulb hit?
  1009  13e4 f007                                   beq +                                       ; yes
  1010  13e6 c9d5                                   cmp #$d5                                    ; light bulb hit?
  1011  13e8 f003                                   beq +                                       ; yes
  1012  13ea 4ceb11                                 jmp check_next_char_under_player            ; no, continue
  1013  13ed a9df               +                   lda #$df                                    ; pick up light bulb
  1014  13ef 8dde36                                 sta items + $c8
  1015  13f2 4cd511                                 jmp check_death
  1016                          
  1017                          
  1018                          
  1019                          
  1020                          
  1021                          
  1022                          ; ==============================================================================
  1023                          ;
  1024                          ;                                                             #       #####
  1025                          ;          #####      ####      ####     #    #              ##      #     #
  1026                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1027                          ;          #    #    #    #    #    #    # ## #               #       #####
  1028                          ;          #####     #    #    #    #    #    #               #            #
  1029                          ;          #   #     #    #    #    #    #    #               #      #     #
  1030                          ;          #    #     ####      ####     #    #             #####     #####
  1031                          ;
  1032                          ; ==============================================================================
  1033                          
  1034                          room_13:           
  1035                          
  1036  13f5 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1037  13f7 b005                                   bcs +
  1038  13f9 a000                                   ldy #$00                                    ; message 0 to display
  1039  13fb 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1040                          
  1041  13fe c9d6               +                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
  1042  1400 f003                                   beq +                                       ; OUCH!! -> +
  1043  1402 4ceb11                                 jmp check_next_char_under_player            ; not stepped into a nail... yet.
  1044  1405 ad9a36             +                   lda items + $84                             ; are the boots taken?
  1045  1408 c9df                                   cmp #$df                                
  1046  140a f005                                   beq +                                       ; yeah I'm cool these boots are made for nailin'. 
  1047  140c a007                                   ldy #$07                                    ; death by a thousand nails.
  1048  140e 4ce33a                                 jmp death                                   ; 07 You stepped on a nail!
  1049                          
  1050                          +
  1051  1411 a9e2                                   lda #$e2                                    ; this is also a nail. 
  1052  1413 8deb36                                 sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
  1053  1416 4cd511                                 jmp check_death
  1054                          
  1055                          
  1056                          
  1057                          
  1058                          
  1059                          
  1060                          ; ==============================================================================
  1061                          ;
  1062                          ;                                                             #      #
  1063                          ;          #####      ####      ####     #    #              ##      #    #
  1064                          ;          #    #    #    #    #    #    ##  ##             # #      #    #
  1065                          ;          #    #    #    #    #    #    # ## #               #      #    #
  1066                          ;          #####     #    #    #    #    #    #               #      #######
  1067                          ;          #   #     #    #    #    #    #    #               #           #
  1068                          ;          #    #     ####      ####     #    #             #####         #
  1069                          ;
  1070                          ; ==============================================================================
  1071                          
  1072                          room_14:
  1073                          
  1074  1419 c9d7                                   cmp #$d7                                    ; foot trap char
  1075  141b f003                                   beq +                                       ; stepped into it?
  1076  141d 4ceb11                                 jmp check_next_char_under_player            ; not... yet...
  1077  1420 a008               +                   ldy #$08                                    ; go die
  1078  1422 4ce33a                                 jmp death                                   ; 08 A foot trap stopped you!
  1079                          
  1080                          
  1081                          
  1082                          
  1083                          
  1084                          
  1085                          ; ==============================================================================
  1086                          ;
  1087                          ;                                                             #      #######
  1088                          ;          #####      ####      ####     #    #              ##      #
  1089                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1090                          ;          #    #    #    #    #    #    # ## #               #      ######
  1091                          ;          #####     #    #    #    #    #    #               #            #
  1092                          ;          #   #     #    #    #    #    #    #               #      #     #
  1093                          ;          #    #     ####      ####     #    #             #####     #####
  1094                          ;
  1095                          ; ==============================================================================
  1096                          
  1097                          room_15:
  1098                          
  1099  1425 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1100  1427 b005                                   bcs +
  1101  1429 a000                                   ldy #$00                                    ; display hint
  1102  142b 4c2c10                                 jmp prep_and_display_hint
  1103                          
  1104  142e 4ceb11             +                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address
  1105                          
  1106                          
  1107                          
  1108                          
  1109                          
  1110                          
  1111                          ; ==============================================================================
  1112                          ;
  1113                          ;                                                             #       #####
  1114                          ;          #####      ####      ####     #    #              ##      #     #
  1115                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1116                          ;          #    #    #    #    #    #    # ## #               #      ######
  1117                          ;          #####     #    #    #    #    #    #               #      #     #
  1118                          ;          #   #     #    #    #    #    #    #               #      #     #
  1119                          ;          #    #     ####      ####     #    #             #####     #####
  1120                          ;
  1121                          ; ==============================================================================
  1122                          
  1123                          room_16:
  1124                          
  1125  1431 c9f4                                   cmp #$f4                                    ; did you hit the wall in the left cell?
  1126  1433 d005                                   bne +                                       ; I did not! -> +
  1127  1435 a00a                                   ldy #$0a                                    ; yeah....
  1128  1437 4ce33a                                 jmp death                                   ; 0a You were locked in and starved!
  1129                          
  1130  143a c9d9               +                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
  1131  143c f004                                   beq +                                       ; not that I know of...
  1132  143e c9db                                   cmp #$db                                    ; are you sure? take a look at this slightly different wall
  1133  1440 d005                                   bne ++                                      ; it doesn't look familiar... -> ++
  1134                          
  1135  1442 a009               +                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
  1136  1444 4ce33a                                 jmp death
  1137                          
  1138  1447 c9b9               ++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
  1139  1449 f007                                   beq +                                       ; yes! -> +
  1140  144b c9bb                                   cmp #$bb                                    ; here's another part of that bottle for reference
  1141  144d f003                                   beq +                                       ; yes! -> +
  1142  144f 4ceb11                                 jmp check_next_char_under_player            ; no, continue
  1143  1452 a003               +                   ldy #$03                                    ; display code enter screen
  1144  1454 4c2c10                                 jmp prep_and_display_hint
  1145                          
  1146                          
  1147                          
  1148                          
  1149                          
  1150                          
  1151                          ; ==============================================================================
  1152                          ;
  1153                          ;                                                             #      #######
  1154                          ;          #####      ####      ####     #    #              ##      #    #
  1155                          ;          #    #    #    #    #    #    ##  ##             # #          #
  1156                          ;          #    #    #    #    #    #    # ## #               #         #
  1157                          ;          #####     #    #    #    #    #    #               #        #
  1158                          ;          #   #     #    #    #    #    #    #               #        #
  1159                          ;          #    #     ####      ####     #    #             #####      #
  1160                          ;
  1161                          ; ==============================================================================
  1162                          
  1163                          room_17:
  1164                          
  1165  1457 c9dd                                   cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
  1166  1459 f003                                   beq +                                       ; yup
  1167  145b 4ceb11                                 jmp check_next_char_under_player            ; nah not yet.
  1168  145e a9df               +                   lda #$df                                    ; pick up sword
  1169  1460 8dbd37                                 sta items + $1a7                            ; store in items list
  1170  1463 4cd511                                 jmp check_death
  1171                          
  1172                          
  1173                          
  1174                          
  1175                          
  1176                          
  1177                          ; ==============================================================================
  1178                          ;
  1179                          ;                                                             #       #####
  1180                          ;          #####      ####      ####     #    #              ##      #     #
  1181                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
  1182                          ;          #    #    #    #    #    #    # ## #               #       #####
  1183                          ;          #####     #    #    #    #    #    #               #      #     #
  1184                          ;          #   #     #    #    #    #    #    #               #      #     #
  1185                          ;          #    #     ####      ####     #    #             #####     #####
  1186                          ;
  1187                          ; ==============================================================================
  1188                          
  1189                          room_18:
  1190  1466 c981                                   cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
  1191  1468 b003                                   bcs +                   
  1192  146a 4cd511                                 jmp check_death
  1193                          
  1194  146d ada012             +                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
  1195  1470 d003                                   bne +                                       ; yes I actually did (flexes arms)
  1196  1472 4cd53a                                 jmp main_loop                               ; nope
  1197  1475 20263a             +                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
  1198  1478 4c401b                                 jmp print_endscreen                         ; (drops mic)
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
  1233                          
  1234                          
  1235                          
  1236                          
  1237                          
  1238                          
  1239                          
  1240                          ; ==============================================================================
  1241                          ; 
  1242                          ; EVERYTHING ANIMATION RELATED STARTS HERE
  1243                          ; ANIMATIONS FOR
  1244                          ; LASER, BORIS, BELEGRO, STONE, MONSTER
  1245                          ; ==============================================================================
  1246                          
  1247                          ; TODO
  1248                          ; this gets called all the time, no checks 
  1249                          ; needs to be optimized
  1250                          
  1251                          
  1252                          animation_entrypoint:
  1253                                              
  1254                                              ; code below is used to check if the foot traps should be visible
  1255                                              ; it checked for this every single fucking frame
  1256                                              ; moved the foot traps coloring where it belongs (when picking up power outlet)
  1257                                              ;lda items + $ac                         ; $cc (power outlet)
  1258                                              ;cmp #$df                                ; taken?
  1259                                              ;bne +                                   ; no -> +
  1260                                              ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
  1261                                              ;sta items + $12c                        ; originally $0
  1262                          
  1263  147b acf82f             +                   ldy current_room + 1                    ; load room number
  1264                          
  1265  147e c011                                   cpy #$11                                ; is it room #17? (Belegro)
  1266  1480 d046                                   bne room_14_prep                         ; no -> m162A
  1267                                              
  1268                                              
  1269  1482 ad1715                                 lda m14CC + 1                           ; yes, get value from m14CD
  1270  1485 d013                                   bne m15FC                               ; 0? -> m15FC
  1271  1487 ad4035                                 lda player_pos_y + 1                    ; not 0, get player pos Y
  1272  148a c906                                   cmp #$06                                ; is it 6?
  1273  148c d00c                                   bne m15FC                               ; no -> m15FC
  1274  148e ad4235                                 lda player_pos_x + 1                    ; yes, get player pos X
  1275  1491 c918                                   cmp #$18                                ; is player x position $18?
  1276  1493 d005                                   bne m15FC                               ; no -> m15FC
  1277  1495 a900                                   lda #$00                                ; yes, load 0
  1278  1497 8d9b14                                 sta m15FC + 1                           ; store 0 in m15FC+1
  1279  149a a901               m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
  1280  149c d016                                   bne +                                   ; is it 0? -> +
  1281  149e a006                                   ldy #$06                                ; y = $6
  1282  14a0 a21e               m1602:              ldx #$1e                                ; x = $1e
  1283  14a2 a900                                   lda #$00                                ; a = $0
  1284  14a4 85a7                                   sta zpA7                                ; zpA7 = 0
  1285  14a6 20c734                                 jsr draw_player                         ; TODO
  1286  14a9 aea114                                 ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
  1287  14ac e003                                   cpx #$03                                ; is X = $3?
  1288  14ae f001                                   beq ++                                  ; yes -> ++
  1289  14b0 ca                                     dex                                     ; x = x -1
  1290  14b1 8ea114             ++                  stx m1602 + 1                           ; store x in m1602+1
  1291  14b4 a978               +                   lda #$78                                ; a = $78
  1292  14b6 85a8                                   sta zpA8                                ; zpA8 = $78
  1293  14b8 a949                                   lda #$49                                ; a = $49
  1294  14ba 850a                                   sta zp0A                                ; zp0A = $49
  1295  14bc a006                                   ldy #$06                                ; y = $06
  1296  14be a901                                   lda #$01                                ; a = $01
  1297  14c0 85a7                                   sta zpA7                                ; zpA7 = $01
  1298  14c2 aea114                                 ldx m1602 + 1                           ; get stored x value (should still be the same?)
  1299  14c5 20c734                                 jsr draw_player                         ; TODO
  1300                          
  1301                          
  1302                          room_14_prep:              
  1303  14c8 acf82f                                 ldy current_room + 1                    ; load room number
  1304  14cb c00e                                   cpy #14                                 ; is it #14?
  1305  14cd d005                                   bne room_15_prep                        ; no -> m148A
  1306  14cf a020                                   ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
  1307  14d1 20ff39                                 jsr wait                                ; was jmp wait before
  1308                          
  1309                          ; ==============================================================================
  1310                          ; ROOM 15 ANIMATION
  1311                          ; MOVEMENT OF THE MONSTER
  1312                          ; ==============================================================================
  1313                          
  1314                          room_15_prep:              
  1315  14d4 c00f                                   cpy #15                                 ; room 15?
  1316  14d6 d03a                                   bne room_17_prep                        ; no -> m14C8
  1317  14d8 a900                                   lda #$00                                ; 
  1318  14da 85a7                                   sta zpA7
  1319  14dc a00c                                   ldy #$0c                                ; x/y pos of the monster
  1320  14de a206               m1494:              ldx #$06
  1321  14e0 20c734                                 jsr draw_player
  1322  14e3 a9eb                                   lda #$eb                                ; the monster (try 9c for Belegro)
  1323  14e5 85a8                                   sta zpA8
  1324  14e7 a939                                   lda #$39                                ; color of the monster's cape
  1325  14e9 850a                                   sta zp0A
  1326  14eb aedf14                                 ldx m1494 + 1                           ; self mod the x position of the monster
  1327  14ee a901               m14A4:              lda #$01
  1328  14f0 d00a                                   bne m14B2               
  1329  14f2 e006                                   cpx #$06                                ; moved 6 steps?
  1330  14f4 d002                                   bne +                                   ; no, keep moving
  1331  14f6 a901                                   lda #$01
  1332  14f8 ca                 +                   dex
  1333  14f9 4c0315                                 jmp +                                   ; change direction
  1334                          
  1335                          m14B2:              
  1336  14fc e00b                                   cpx #$0b
  1337  14fe d002                                   bne ++
  1338  1500 a900                                   lda #$00
  1339  1502 e8                 ++                  inx
  1340  1503 8edf14             +                   stx m1494 + 1
  1341  1506 8def14                                 sta m14A4 + 1
  1342  1509 a901                                   lda #$01
  1343  150b 85a7                                   sta zpA7
  1344  150d a00c                                   ldy #$0c
  1345  150f 4cc734                                 jmp draw_player
  1346                                             
  1347                          ; ==============================================================================
  1348                          ; ROOM 17 ANIMATION
  1349                          ;
  1350                          ; ==============================================================================
  1351                          
  1352                          room_17_prep:              
  1353  1512 c011                                   cpy #17                             ; room number 17?
  1354  1514 d014                                   bne +                               ; no -> +
  1355  1516 a901               m14CC:              lda #$01                            ; selfmod
  1356  1518 f021                                   beq ++                              
  1357                                                                                 
  1358                                              ; was moved here
  1359                                              ; as it was called only from this place
  1360                                              ; jmp m15C1  
  1361  151a a900               m15C1:              lda #$00                            ; a = 0 (selfmod)
  1362  151c c900                                   cmp #$00                            ; is a = 0?
  1363  151e d004                                   bne skipper                         ; not 0 -> 15CB
  1364  1520 ee1b15                                 inc m15C1 + 1                       ; inc m15C1
  1365  1523 60                                     rts
  1366                                       
  1367  1524 ce1b15             skipper:            dec m15C1 + 1                       ; dec $15c2
  1368  1527 4cb335                                 jmp belegro_animation
  1369                          
  1370  152a a90f               +                   lda #$0f                            ; a = $0f
  1371  152c 8db835                                 sta m3624 + 1                       ; selfmod
  1372  152f 8dba35                                 sta m3626 + 1                       ; selfmod
  1373                          
  1374                          
  1375  1532 c00a                                   cpy #10                             ; room number 10?
  1376  1534 d044                                   bne check_if_room_09                ; no -> m1523
  1377  1536 ceb82f                                 dec speed_byte                      ; yes, reduce speed
  1378  1539 f001                                   beq laser_beam_animation            ; if positive -> laser_beam_animation            
  1379  153b 60                 ++                  rts
  1380                          
  1381                          ; ==============================================================================
  1382                          ; ROOM 10
  1383                          ; LASER BEAM ANIMATION
  1384                          ; ==============================================================================
  1385                          
  1386                          laser_beam_animation:
  1387                                             
  1388  153c a008                                   ldy #$08                            ; speed of the laser flashing
  1389  153e 8cb82f                                 sty speed_byte                      ; store     
  1390  1541 a9d9                                   lda #$d9
  1391  1543 8505                                   sta zp05                            ; affects the colram of the laser
  1392  1545 a905                                   lda #$05                            ; but not understood yet
  1393  1547 8503                                   sta zp03
  1394  1549 a97b                                   lda #$7b                            ; position of the laser
  1395  154b 8502                                   sta zp02
  1396  154d 8504                                   sta zp04
  1397  154f a9df                                   lda #$df                            ; laser beam off
  1398  1551 cd5e15                                 cmp m1506 + 1                       
  1399  1554 d002                                   bne +                               
  1400  1556 a9d8                                   lda #$d8                            ; laser beam character
  1401  1558 8d5e15             +                   sta m1506 + 1                       
  1402  155b a206                                   ldx #$06                            ; 6 laser beam characters
  1403  155d a9df               m1506:              lda #$df
  1404  155f a000                                   ldy #$00
  1405  1561 9102                                   sta (zp02),y
  1406  1563 a9ee                                   lda #$ee
  1407  1565 9104                                   sta (zp04),y
  1408  1567 a502                                   lda zp02
  1409  1569 18                                     clc
  1410  156a 6928                                   adc #$28                            ; draws the laser beam
  1411  156c 8502                                   sta zp02
  1412  156e 8504                                   sta zp04
  1413  1570 9004                                   bcc +                               
  1414  1572 e603                                   inc zp03
  1415  1574 e605                                   inc zp05
  1416  1576 ca                 +                   dex
  1417  1577 d0e4                                   bne m1506                           
  1418  1579 60                 -                   rts
  1419                          
  1420                          ; ==============================================================================
  1421                          
  1422                          check_if_room_09:              
  1423  157a c009                                   cpy #09                         ; room number 09?
  1424  157c f001                                   beq room_09_counter                           ; yes -> +
  1425  157e 60                                     rts                             ; no
  1426                          
  1427                          room_09_counter:
  1428  157f a201                                   ldx #$01                                ; x = 1 (selfmod)
  1429  1581 e001                                   cpx #$01                                ; is x = 1?
  1430  1583 f003                                   beq +                                   ; yes -> +
  1431  1585 4ca015                                 jmp boris_the_spider_animation          ; no, jump boris animation
  1432  1588 ce8015             +                   dec room_09_counter + 1                 ; decrease initial x
  1433  158b 60                                     rts
  1434                          
  1435                          ; ==============================================================================
  1436                          ;
  1437                          ; I moved this out of the main loop and call it once when changing rooms
  1438                          ; TODO: call it only when room 4 is entered
  1439                          ; ==============================================================================
  1440                          
  1441                          room_04_prep_door:
  1442                                              
  1443  158c adf82f                                 lda current_room + 1                            ; get current room
  1444  158f c904                                   cmp #04                                         ; is it 4? (coffins)
  1445  1591 d00c                                   bne ++                                          ; nope
  1446  1593 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  1447  1595 ac0339                                 ldy m394A + 1                                   ; 
  1448  1598 f002                                   beq +
  1449  159a a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  1450  159c 8df904             +                   sta SCREENRAM + $f9 
  1451  159f 60                 ++                  rts
  1452                          
  1453                          ; ==============================================================================
  1454                          ; ROOM 09
  1455                          ; BORIS THE SPIDER ANIMATION
  1456                          ; ==============================================================================
  1457                          
  1458                          boris_the_spider_animation:
  1459                          
  1460  15a0 ee8015                                 inc room_09_counter + 1                           
  1461  15a3 a9d8                                   lda #>COLRAM + 1                               ; affects the color ram position for boris the spider
  1462  15a5 8505                                   sta zp05
  1463  15a7 a904                                   lda #>SCREENRAM
  1464  15a9 8503                                   sta zp03
  1465  15ab a90f                                   lda #$0f
  1466  15ad 8502                                   sta zp02
  1467  15af 8504                                   sta zp04
  1468  15b1 a206               m1535:              ldx #$06
  1469  15b3 a900               m1537:              lda #$00
  1470  15b5 d009                                   bne +
  1471  15b7 ca                                     dex
  1472  15b8 e002                                   cpx #$02
  1473  15ba d00b                                   bne ++
  1474  15bc a901                                   lda #$01
  1475  15be d007                                   bne ++
  1476  15c0 e8                 +                   inx
  1477  15c1 e007                                   cpx #$07
  1478  15c3 d002                                   bne ++
  1479  15c5 a900                                   lda #$00
  1480  15c7 8db415             ++                  sta m1537 + 1
  1481  15ca 8eb215                                 stx m1535 + 1
  1482  15cd a000               -                   ldy #$00
  1483  15cf a9df                                   lda #$df
  1484  15d1 9102                                   sta (zp02),y
  1485  15d3 c8                                     iny
  1486  15d4 c8                                     iny
  1487  15d5 9102                                   sta (zp02),y
  1488  15d7 88                                     dey
  1489  15d8 a9ea                                   lda #$ea
  1490  15da 9102                                   sta (zp02),y
  1491  15dc 9104                                   sta (zp04),y
  1492  15de 201916                                 jsr move_boris                       
  1493  15e1 ca                                     dex
  1494  15e2 d0e9                                   bne -
  1495  15e4 a9e4                                   lda #$e4
  1496  15e6 85a8                                   sta zpA8
  1497  15e8 a202                                   ldx #$02
  1498  15ea a000               --                  ldy #$00
  1499  15ec a5a8               -                   lda zpA8
  1500  15ee 9102                                   sta (zp02),y
  1501  15f0 a9da                                   lda #$da
  1502  15f2 9104                                   sta (zp04),y
  1503  15f4 e6a8                                   inc zpA8
  1504  15f6 c8                                     iny
  1505  15f7 c003                                   cpy #$03
  1506  15f9 d0f1                                   bne -
  1507  15fb 201916                                 jsr move_boris                       
  1508  15fe ca                                     dex
  1509  15ff d0e9                                   bne --
  1510  1601 a000                                   ldy #$00
  1511  1603 a9e7                                   lda #$e7
  1512  1605 85a8                                   sta zpA8
  1513  1607 b102               -                   lda (zp02),y
  1514  1609 c5a8                                   cmp zpA8
  1515  160b d004                                   bne +
  1516  160d a9df                                   lda #$df
  1517  160f 9102                                   sta (zp02),y
  1518  1611 e6a8               +                   inc zpA8
  1519  1613 c8                                     iny
  1520  1614 c003                                   cpy #$03
  1521  1616 d0ef                                   bne -
  1522  1618 60                                     rts
  1523                          
  1524                          ; ==============================================================================
  1525                          
  1526                          move_boris:
  1527  1619 a502                                   lda zp02
  1528  161b 18                                     clc
  1529  161c 6928                                   adc #$28
  1530  161e 8502                                   sta zp02
  1531  1620 8504                                   sta zp04
  1532  1622 9004                                   bcc +                                   
  1533  1624 e603                                   inc zp03
  1534  1626 e605                                   inc zp05
  1535  1628 60                 +                   rts
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
  1549                          
  1550                          
  1551                          
  1552                          
  1553                          
  1554                          
  1555                          
  1556                          ; ==============================================================================
  1557                          
  1558                          prep_player_pos:
  1559                          
  1560  1629 a209                                   ldx #$09
  1561  162b bd4403             -                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
  1562  162e 9d5403                                 sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
  1563  1631 ca                                     dex
  1564  1632 d0f7                                   bne -                                   ; so this seems to create a copy of the area under the player
  1565                          
  1566  1634 a902                                   lda #$02                                ; a = 2
  1567  1636 85a7                                   sta zpA7
  1568  1638 ae4235                                 ldx player_pos_x + 1                    ; x = player x
  1569  163b ac4035                                 ldy player_pos_y + 1                    ; y = player y
  1570  163e 20c734                                 jsr draw_player                         ; draw player
  1571  1641 60                                     rts
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
  1586                          
  1587                          
  1588                          
  1589                          
  1590                          
  1591                          
  1592                          
  1593                          ; ==============================================================================
  1594                          ; OBJECT ANIMATION COLLISION ROUTINE
  1595                          ; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
  1596                          ; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
  1597                          ; ==============================================================================
  1598                          
  1599                          object_collision:
  1600                          
  1601  1642 a209                                   ldx #$09                                ; x = 9
  1602                          
  1603                          check_loop:              
  1604                          
  1605  1644 bd4403                                 lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1606  1647 c9d8                                   cmp #$d8                                ; check for laser beam
  1607  1649 d005                                   bne +                  
  1608                          
  1609  164b a005               m164E:              ldy #$05
  1610  164d 4ce33a             jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?
  1611                          
  1612  1650 acf82f             +                   ldy current_room + 1                    ; get room number
  1613  1653 c011                                   cpy #17                                 ; is it $11 = #17 (Belegro)?
  1614  1655 d010                                   bne +                                   ; nope -> +
  1615  1657 c978                                   cmp #$78                                ; hit by the stone?
  1616  1659 f008                                   beq ++                                  ; yep -> ++
  1617  165b c97b                                   cmp #$7b                                ; or another part of the stone?
  1618  165d f004                                   beq ++                                  ; yes -> ++
  1619  165f c97e                                   cmp #$7e                                ; or another part of the stone?
  1620  1661 d004                                   bne +                                   ; nah, -> +
  1621  1663 a00b               ++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
  1622  1665 d0e6                                   bne jmp_death
  1623  1667 c99c               +                   cmp #$9c                                ; so Belegro hit you?
  1624  1669 9007                                   bcc m1676
  1625  166b c9a5                                   cmp #$a5
  1626  166d b003                                   bcs m1676
  1627  166f 4ca316                                 jmp m16A7
  1628                          
  1629  1672 c9e4               m1676:              cmp #$e4                                ; hit by Boris the spider?
  1630  1674 9010                                   bcc +                           
  1631  1676 c9eb                                   cmp #$eb
  1632  1678 b004                                   bcs ++                          
  1633  167a a004               -                   ldy #$04                                ; 04 Boris the spider got you and killed you
  1634  167c d0cf                                   bne jmp_death                       
  1635  167e c9f4               ++                  cmp #$f4
  1636  1680 b004                                   bcs +                           
  1637  1682 a00e                                   ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
  1638  1684 d0c7                                   bne jmp_death                       
  1639  1686 ca                 +                   dex
  1640  1687 d0bb                                   bne check_loop   
  1641                          
  1642                          
  1643                          
  1644  1689 a209                                   ldx #$09
  1645  168b bd5403             --                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
  1646  168e 9d4403                                 sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1647  1691 c9d8                                   cmp #$d8
  1648  1693 f0b6                                   beq m164E                       
  1649  1695 c9e4                                   cmp #$e4
  1650  1697 9004                                   bcc +                           
  1651  1699 c9ea                                   cmp #$ea
  1652  169b 90dd                                   bcc -                           
  1653  169d ca                 +                   dex
  1654  169e d0eb                                   bne --                          
  1655  16a0 4cdb11                                 jmp m11E0                     
  1656                          
  1657                          m16A7:
  1658  16a3 acbd37                                 ldy items + $1a7                        ; do you have the sword?
  1659  16a6 c0df                                   cpy #$df
  1660  16a8 f004                                   beq +                                   ; yes -> +                        
  1661  16aa a00c                                   ldy #$0c                                ; 0c Belegro killed you!
  1662  16ac d09f                                   bne jmp_death                       
  1663  16ae a000               +                   ldy #$00
  1664  16b0 8c1715                                 sty m14CC + 1                   
  1665  16b3 4c7216                                 jmp m1676                       
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
  1696                          
  1697                          
  1698                          
  1699                          
  1700                          
  1701                          
  1702                          
  1703                          ; ==============================================================================
  1704                          ; this might be the inventory/ world reset
  1705                          ; puts all items into the level data again
  1706                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1707                          ; addresses are mostly within items.asm address space ( $368a )
  1708                          ; contains color information of the chars
  1709                          ; ==============================================================================
  1710                          
  1711                          reset_items:
  1712  16b6 a9a5                                   lda #$a5                        ; $a5 = lock of the shed
  1713  16b8 8d4e36                                 sta items + $38
  1714                          
  1715  16bb a9a9                                   lda #$a9                        ;
  1716  16bd 8d1e36                                 sta items + $8                  ; gloves
  1717  16c0 a979                                   lda #$79
  1718  16c2 8d1c36                                 sta items + $6                  ; gloves color
  1719                          
  1720  16c5 a9e0                                   lda #$e0                        ; empty char
  1721  16c7 8d2636                                 sta items + $10                 ; invisible key
  1722                          
  1723  16ca a9ac                                   lda #$ac                        ; wirecutter
  1724  16cc 8d2f36                                 sta items + $19
  1725                          
  1726  16cf a9b8                                   lda #$b8                        ; bottle
  1727  16d1 8d3f36                                 sta items + $29
  1728                          
  1729  16d4 a9b0                                   lda #$b0                        ; ladder
  1730  16d6 8d6336                                 sta items + $4d
  1731  16d9 a9b5                                   lda #$b5                        ; more ladder
  1732  16db 8d6e36                                 sta items + $58
  1733                          
  1734  16de a95e                                   lda #$5e                        ; seems to be water?
  1735  16e0 8d8a36                                 sta items + $74
  1736                          
  1737  16e3 a9c6                                   lda #$c6                        ; boots in the whatever box
  1738  16e5 8d9a36                                 sta items + $84
  1739                          
  1740  16e8 a9c0                                   lda #$c0                        ; shovel
  1741  16ea 8dac36                                 sta items + $96
  1742                          
  1743  16ed a9cc                                   lda #$cc                        ; power outlet
  1744  16ef 8dc236                                 sta items + $ac
  1745                          
  1746  16f2 a9d0                                   lda #$d0                        ; hammer
  1747  16f4 8dd136                                 sta items + $bb
  1748                          
  1749  16f7 a9d2                                   lda #$d2                        ; light bulb
  1750  16f9 8dde36                                 sta items + $c8
  1751                          
  1752  16fc a9d6                                   lda #$d6                        ; nails
  1753  16fe 8deb36                                 sta items + $d5
  1754                          
  1755  1701 a900                                   lda #$00                        ; door
  1756  1703 8d4237                                 sta items + $12c
  1757                          
  1758  1706 a9dd                                   lda #$dd                        ; sword
  1759  1708 8dbd37                                 sta items + $1a7
  1760                          
  1761  170b a901                                   lda #$01                        ; -> wrong write, produced selfmod at the wrong place
  1762  170d 8d0339                                 sta m394A + 1                   ; sta items + $2c1
  1763                          
  1764  1710 a901                                   lda #$01                        ; 
  1765  1712 8d9138                                 sta breathing_tube_mod + 1      ; sta items + $30a
  1766                          
  1767  1715 a9f5                                   lda #$f5                        ; fence
  1768  1717 8db538                                 sta delete_fence + 1            ; sta items + $277
  1769                          
  1770  171a a900                                   lda #$00                        ; key in the bottle
  1771  171c 8da012                                 sta key_in_bottle_storage
  1772                          
  1773  171f a901                                   lda #$01                        ; door
  1774  1721 8d9b14                                 sta m15FC + 1
  1775                          
  1776  1724 a91e                                   lda #$1e
  1777  1726 8da114                                 sta m1602 + 1
  1778                          
  1779  1729 a901                                   lda #$01
  1780  172b 8d1715                                 sta m14CC + 1
  1781                          
  1782  172e a205               m1732:              ldx #$05
  1783  1730 e007                                   cpx #$07
  1784  1732 d002                                   bne +
  1785  1734 a2ff                                   ldx #$ff
  1786  1736 e8                 +                   inx
  1787  1737 8e2f17                                 stx m1732 + 1                           ; stx $1733
  1788  173a bd4317                                 lda m1747,x                             ; lda $1747,x
  1789  173d 8d0b39                                 sta m3952 + 1                   ; sta $3953
  1790  1740 4cb030                                 jmp print_title     ; jmp $310d
  1791                                              
  1792                          ; ==============================================================================
  1793                          
  1794                          m1747:
  1795  1743 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1796                          
  1797                          
  1798                          m174F:
  1799  174b e00c                                   cpx #$0c
  1800  174d d002                                   bne +
  1801  174f a949                                   lda #$49
  1802  1751 e00d               +                   cpx #$0d
  1803  1753 d002                                   bne +
  1804  1755 a945                                   lda #$45
  1805  1757 60                 +                   rts
  1806                          
  1807                          
  1808                          
  1809                          screen_win_src:
  1810                                              !if LANGUAGE = EN{
  1811  1758 7040404040404040...                        !bin "includes/screen-win-en.scr"
  1812                                              }
  1813                                              !if LANGUAGE = DE{
  1814                                                  !bin "includes/screen-win-de.scr"
  1815                                              }
  1816                          screen_win_src_end:
  1817                          
  1818                          
  1819                          ; ==============================================================================
  1820                          ;
  1821                          ; PRINT WIN SCREEN
  1822                          ; ==============================================================================
  1823                          
  1824                          print_endscreen:
  1825  1b40 a904                                   lda #>SCREENRAM
  1826  1b42 8503                                   sta zp03
  1827  1b44 a9d8                                   lda #>COLRAM
  1828  1b46 8505                                   sta zp05
  1829  1b48 a900                                   lda #<SCREENRAM
  1830  1b4a 8502                                   sta zp02
  1831  1b4c 8504                                   sta zp04
  1832  1b4e a204                                   ldx #$04
  1833  1b50 a917                                   lda #>screen_win_src
  1834  1b52 85a8                                   sta zpA8
  1835  1b54 a958                                   lda #<screen_win_src
  1836  1b56 85a7                                   sta zpA7
  1837  1b58 a000                                   ldy #$00
  1838  1b5a b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1839  1b5c 9102                                   sta (zp02),y        ; to SCREEN
  1840  1b5e a900                                   lda #$00            ; color = BLACK
  1841  1b60 9104                                   sta (zp04),y        ; to COLRAM
  1842  1b62 c8                                     iny
  1843  1b63 d0f5                                   bne -
  1844  1b65 e603                                   inc zp03
  1845  1b67 e605                                   inc zp05
  1846  1b69 e6a8                                   inc zpA8
  1847  1b6b ca                                     dex
  1848  1b6c d0ec                                   bne -
  1849  1b6e a907                                   lda #$07                  ; yellow
  1850  1b70 8d21d0                                 sta BG_COLOR              ; background
  1851  1b73 8d20d0                                 sta BORDER_COLOR          ; und border
  1852  1b76 a5cb               -                   lda $cb                   ; lda #$fd
  1853                                                                        ; sta KEYBOARD_LATCH
  1854                                                                        ; lda KEYBOARD_LATCH
  1855                                                                        ; and #$80           ; WAITKEY?
  1856                                              
  1857  1b78 c93c                                   cmp #$3c                  ; check for space key on C64
  1858  1b7a d0fa                                   bne -
  1859  1b7c 20b030                                 jsr print_title
  1860  1b7f 20b030                                 jsr print_title
  1861  1b82 4c423a                                 jmp init
  1862                          
  1863                          
  1864                          ; ==============================================================================
  1865                          ;
  1866                          ; INTRO TEXT SCREEN
  1867                          ; ==============================================================================
  1868                          
  1869                          intro_text:
  1870                          
  1871                          ; instructions screen
  1872                          ; "Search the treasure..."
  1873                          
  1874                          !if LANGUAGE = EN{
  1875  1b85 5305011203082014...!scr "Search the treasure of Ghost Town and   "
  1876  1bad 0f10050e20091420...!scr "open it ! Kill Belegro, the wizard, and "
  1877  1bd5 040f04070520010c...!scr "dodge all other dangers. Don't forget to"
  1878  1bfd 15130520010c0c20...!scr "use all the items you'll find during    "
  1879  1c25 190f1512200a0f15...!scr "your journey through 19 amazing hires-  "
  1880  1c4d 0712011008090313...!scr "graphics-rooms! Enjoy the quest and play"
  1881  1c75 091420010701090e...!scr "it again and again and again ...      > "
  1882                          }
  1883                          
  1884                          !if LANGUAGE = DE{
  1885                          !scr "Suchen Sie die Schatztruhe der Geister- "
  1886                          !scr "stadt und oeffnen Sie diese ! Toeten    "
  1887                          !scr "Sie Belegro, den Zauberer und weichen   "
  1888                          !scr "Sie vielen anderen Wesen geschickt aus. "
  1889                          !scr "Bedienen Sie sich an den vielen Gegen-  "
  1890                          !scr "staenden, welche sich in den 19 Bildern "
  1891                          !scr "befinden. Viel Spass !                > "
  1892                          }
  1893                          
  1894                          ; ==============================================================================
  1895                          ;
  1896                          ; DISPLAY INTRO TEXT
  1897                          ; ==============================================================================
  1898                          
  1899                          display_intro_text:
  1900                          
  1901                                              ; i think this part displays the introduction text
  1902                          
  1903  1c9d a904                                   lda #>SCREENRAM       ; lda #$0c
  1904  1c9f 8503                                   sta zp03
  1905  1ca1 a9d8                                   lda #>COLRAM        ; lda #$08
  1906  1ca3 8505                                   sta zp05
  1907  1ca5 a9a0                                   lda #$a0
  1908  1ca7 8502                                   sta zp02
  1909  1ca9 8504                                   sta zp04
  1910  1cab a91b                                   lda #>intro_text
  1911  1cad 85a8                                   sta zpA8
  1912  1caf a985                                   lda #<intro_text
  1913  1cb1 85a7                                   sta zpA7
  1914  1cb3 a207                                   ldx #$07
  1915  1cb5 a000               --                  ldy #$00
  1916  1cb7 b1a7               -                   lda (zpA7),y
  1917  1cb9 9102                                   sta (zp02),y
  1918  1cbb a968                                   lda #$68
  1919  1cbd 9104                                   sta (zp04),y
  1920  1cbf c8                                     iny
  1921  1cc0 c028                                   cpy #$28
  1922  1cc2 d0f3                                   bne -
  1923  1cc4 a5a7                                   lda zpA7
  1924  1cc6 18                                     clc
  1925  1cc7 6928                                   adc #$28
  1926  1cc9 85a7                                   sta zpA7
  1927  1ccb 9002                                   bcc +
  1928  1ccd e6a8                                   inc zpA8
  1929  1ccf a502               +                   lda zp02
  1930  1cd1 18                                     clc
  1931  1cd2 6950                                   adc #$50
  1932  1cd4 8502                                   sta zp02
  1933  1cd6 8504                                   sta zp04
  1934  1cd8 9004                                   bcc +
  1935  1cda e603                                   inc zp03
  1936  1cdc e605                                   inc zp05
  1937  1cde ca                 +                   dex
  1938  1cdf d0d4                                   bne --
  1939  1ce1 a900                                   lda #$00
  1940  1ce3 8d21d0                                 sta BG_COLOR
  1941  1ce6 60                                     rts
  1942                          
  1943                          ; ==============================================================================
  1944                          ;
  1945                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1946                          ; DECREASES MUSIC VOLUME
  1947                          ; ==============================================================================
  1948                          
  1949                          start_intro:        ;sta KEYBOARD_LATCH
  1950  1ce7 20423b                                 jsr clear                                   ; jsr PRINT_KERNAL
  1951  1cea 209d1c                                 jsr display_intro_text
  1952  1ced 20c91e                                 jsr check_shift_key
  1953                                              
  1954                                              ;lda #$ba
  1955                                              ;sta music_volume+1                          ; sound volume
  1956  1cf0 60                                     rts
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
  1982                          
  1983                          
  1984                          
  1985                          
  1986                          
  1987                          
  1988                          
  1989                          
  1990                          
  1991                          ; ==============================================================================
  1992                          ; MUSIC
  1993                          ; ==============================================================================
  1994                                              !zone MUSIC

; ******** Source: includes/music_data.asm
     1                          ; music! :)
     2                          
     3                          music_data_voice1:
     4  1cf1 8445434425262526...!byte $84, $45, $43, $44, $25, $26, $25, $26, $27, $24, $4b, $2c, $2d
     5  1cfe 2c2d2e2b44252625...!byte $2c, $2d, $2e, $2b, $44, $25, $26, $25, $26, $27, $24, $46, $64, $66, $47, $67
     6  1d0e 6746646647676727...!byte $67, $46, $64, $66, $47, $67, $67, $27, $29, $27, $49, $67, $44, $66, $64, $27
     7  1d1e 2927496744666432...!byte $29, $27, $49, $67, $44, $66, $64, $32, $35, $32, $50, $6e, $2f, $30, $31, $30
     8  1d2e 3132312f2f4f504f...!byte $31, $32, $31, $2f, $2f, $4f, $50, $4f, $2e, $2f, $30, $31, $30, $31, $32, $31
     9  1d3e 2f4f6d6b4e6c6a4f...!byte $2f, $4f, $6d, $6b, $4e, $6c, $6a, $4f, $6d, $6b, $4e, $6c, $6a
    10                          
    11                          music_data_voice2:
    12  1d4b 923133             !byte $92, $31, $33
    13  1d4e 3131523334333435...!byte $31, $31, $52, $33, $34, $33, $34, $35, $32, $54, $32, $52, $75, $54, $32, $52
    14  1d5e 758d8d2c2dce8d8d...!byte $75, $8d, $8d, $2c, $2d, $ce, $8d, $8d, $2c, $2d, $ce, $75, $34, $32, $30, $2e
    15  1d6e 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $35, $32, $35, $32, $35, $32, $2e
    16  1d7e 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $4b, $69, $67, $4c, $6a, $68, $4b
    17  1d8e 69674c6a68323332...!byte $69, $67, $4c, $6a, $68, $32, $33, $32, $b2, $33, $31, $32, $33, $34, $35, $36
    18  1d9e 3533323131323334...!byte $35, $33, $32, $31, $31, $32, $33, $34, $33, $34, $35, $36, $35, $36, $37, $36
    19  1dae ea                 !byte $ea

; ******** Source: main.asm
  1996                          ; ==============================================================================
  1997                          music_get_data:
  1998  1daf a000               .voice1_dur_pt:     ldy #$00
  1999  1db1 d01d                                   bne +
  2000  1db3 a940                                   lda #$40
  2001  1db5 8d161e                                 sta music_voice1+1
  2002  1db8 20151e                                 jsr music_voice1
  2003  1dbb a200               .voice1_dat_pt:     ldx #$00
  2004  1dbd bdf11c                                 lda music_data_voice1,x
  2005  1dc0 eebc1d                                 inc .voice1_dat_pt+1
  2006  1dc3 a8                                     tay
  2007  1dc4 291f                                   and #$1f
  2008  1dc6 8d161e                                 sta music_voice1+1
  2009  1dc9 98                                     tya
  2010  1dca 4a                                     lsr
  2011  1dcb 4a                                     lsr
  2012  1dcc 4a                                     lsr
  2013  1dcd 4a                                     lsr
  2014  1dce 4a                                     lsr
  2015  1dcf a8                                     tay
  2016  1dd0 88                 +                   dey
  2017  1dd1 8cb01d                                 sty .voice1_dur_pt + 1
  2018  1dd4 a000               .voice2_dur_pt:     ldy #$00
  2019  1dd6 d022                                   bne +
  2020  1dd8 a940                                   lda #$40
  2021  1dda 8d3e1e                                 sta music_voice2 + 1
  2022  1ddd 203d1e                                 jsr music_voice2
  2023  1de0 a200               .voice2_dat_pt:     ldx #$00
  2024  1de2 bd4b1d                                 lda music_data_voice2,x
  2025  1de5 a8                                     tay
  2026  1de6 e8                                     inx
  2027  1de7 e065                                   cpx #$65
  2028  1de9 f019                                   beq music_reset
  2029  1deb 8ee11d                                 stx .voice2_dat_pt + 1
  2030  1dee 291f                                   and #$1f
  2031  1df0 8d3e1e                                 sta music_voice2 + 1
  2032  1df3 98                                     tya
  2033  1df4 4a                                     lsr
  2034  1df5 4a                                     lsr
  2035  1df6 4a                                     lsr
  2036  1df7 4a                                     lsr
  2037  1df8 4a                                     lsr
  2038  1df9 a8                                     tay
  2039  1dfa 88                 +                   dey
  2040  1dfb 8cd51d                                 sty .voice2_dur_pt + 1
  2041  1dfe 20151e                                 jsr music_voice1
  2042  1e01 4c3d1e                                 jmp music_voice2
  2043                          ; ==============================================================================
  2044  1e04 a900               music_reset:        lda #$00
  2045  1e06 8db01d                                 sta .voice1_dur_pt + 1
  2046  1e09 8dbc1d                                 sta .voice1_dat_pt + 1
  2047  1e0c 8dd51d                                 sta .voice2_dur_pt + 1
  2048  1e0f 8de11d                                 sta .voice2_dat_pt + 1
  2049  1e12 4caf1d                                 jmp music_get_data
  2050                          ; ==============================================================================
  2051                          ; write music data for voice1 / voice2 into TED registers
  2052                          ; ==============================================================================
  2053  1e15 a204               music_voice1:       ldx #$04
  2054  1e17 e01c                                   cpx #$1c
  2055  1e19 9008                                   bcc +
  2056  1e1b ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2057  1e1e 29ef                                   and #$ef
  2058  1e20 4c391e                                 jmp writeFF11
  2059  1e23 bd651e             +                   lda freq_tab_lo,x
  2060  1e26 8d0eff                                 sta VOICE1_FREQ_LOW
  2061  1e29 ad12ff                                 lda VOICE1
  2062  1e2c 29fc                                   and #$fc
  2063  1e2e 1d7d1e                                 ora freq_tab_hi, x
  2064  1e31 8d12ff                                 sta VOICE1
  2065  1e34 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2066  1e37 0910                                   ora #$10
  2067  1e39 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  2068  1e3c 60                                     rts
  2069                          ; ==============================================================================
  2070  1e3d a20d               music_voice2:       ldx #$0d
  2071  1e3f e01c                                   cpx #$1c
  2072  1e41 9008                                   bcc +
  2073  1e43 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2074  1e46 29df                                   and #$df
  2075  1e48 4c391e                                 jmp writeFF11
  2076  1e4b bd651e             +                   lda freq_tab_lo,x
  2077  1e4e 8d0fff                                 sta VOICE2_FREQ_LOW
  2078  1e51 ad10ff                                 lda VOICE2
  2079  1e54 29fc                                   and #$fc
  2080  1e56 1d7d1e                                 ora freq_tab_hi,x
  2081  1e59 8d10ff                                 sta VOICE2
  2082  1e5c ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2083  1e5f 0920                                   ora #$20
  2084  1e61 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2085  1e64 60                                     rts
  2086                          ; ==============================================================================
  2087                          ; TED frequency tables
  2088                          ; ==============================================================================
  2089  1e65 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  2090  1e6c 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  2091  1e73 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  2092  1e7a 818f95                                 !byte $81, $8f, $95
  2093  1e7d 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  2094  1e84 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  2095  1e8b 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  2096  1e92 030303                                 !byte $03, $03, $03
  2097                          ; ==============================================================================
  2098                                              MUSIC_DELAY_INITIAL   = $09
  2099                                              MUSIC_DELAY           = $0B
  2100  1e95 a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  2101  1e97 ca                                     dex
  2102  1e98 8e961e                                 stx music_play+1
  2103  1e9b f001                                   beq +
  2104  1e9d 60                                     rts
  2105  1e9e a20b               +                   ldx #MUSIC_DELAY
  2106  1ea0 8e961e                                 stx music_play+1
  2107  1ea3 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2108  1ea6 0937                                   ora #$37
  2109  1ea8 29bf               music_volume:       and #$bf
  2110  1eaa 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2111  1ead 4caf1d                                 jmp music_get_data
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
  2135                          
  2136                          
  2137                          
  2138                          
  2139                          
  2140                          
  2141                          
  2142                          
  2143                          
  2144                          ; ==============================================================================
  2145                          ; irq init
  2146                          ; ==============================================================================
  2147                                              !zone IRQ
  2148  1eb0 78                 irq_init0:          sei
  2149  1eb1 a9d0                                   lda #<irq0          ; lda #$06
  2150  1eb3 8d1403                                 sta $0314          ; irq lo
  2151  1eb6 a91e                                   lda #>irq0          ; lda #$1f
  2152  1eb8 8d1503                                 sta $0315          ; irq hi
  2153                                                                  ; irq at $1F06
  2154  1ebb a901                                   lda #$01            ;lda #$02
  2155  1ebd 8d1ad0                                 sta $d01a           ; sta FF0A          ; set IRQ source to RASTER
  2156                          
  2157  1ec0 a9bf                                   lda #$bf
  2158  1ec2 8da91e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  2159  1ec5 58                                     cli
  2160                          
  2161  1ec6 4c263a                                 jmp set_charset_and_screen
  2162                          
  2163                          ; ==============================================================================
  2164                          ; intro text
  2165                          ; wait for shift or joy2 fire press
  2166                          ; ==============================================================================
  2167                          
  2168                          check_shift_key:
  2169                          
  2170  1ec9 a5cb               -                   lda $cb
  2171  1ecb c93c                                   cmp #$3c
  2172  1ecd d0fa                                   bne -
  2173  1ecf 60                                     rts
  2174                          
  2175                          ; ==============================================================================
  2176                          ;
  2177                          ; INTERRUPT routine for music
  2178                          ; ==============================================================================
  2179                          
  2180                                              ; *= $1F06
  2181                          irq0:
  2182  1ed0 ce09ff                                 DEC INTERRUPT
  2183                          
  2184                                                                  ; this IRQ seems to handle music only!
  2185                                              !if SILENT_MODE = 1 {
  2186                                                  jsr fake
  2187                                              } else {
  2188  1ed3 20951e                                     jsr music_play
  2189                                              }
  2190  1ed6 68                                     pla
  2191  1ed7 a8                                     tay
  2192  1ed8 68                                     pla
  2193  1ed9 aa                                     tax
  2194  1eda 68                                     pla
  2195  1edb 40                                     rti
  2196                          
  2197                          ; ==============================================================================
  2198                          ; checks if the music volume is at the desired level
  2199                          ; and increases it if not
  2200                          ; if volume is high enough, it initializes the music irq routine
  2201                          ; is called right at the start of the game, but also when a game ended
  2202                          ; and is about to show the title screen again (increasing the volume)
  2203                          ; ==============================================================================
  2204                          
  2205                          init_music:                                  
  2206  1edc ada91e                                 lda music_volume+1                              ; sound volume
  2207  1edf c9bf               --                  cmp #$bf                                        ; is true on init
  2208  1ee1 d003                                   bne +
  2209  1ee3 4cb01e                                 jmp irq_init0
  2210  1ee6 a204               +                   ldx #$04
  2211  1ee8 86a8               -                   stx zpA8                                        ; buffer serial input byte ?
  2212  1eea a0ff                                   ldy #$ff
  2213  1eec 20ff39                                 jsr wait
  2214  1eef a6a8                                   ldx zpA8
  2215  1ef1 ca                                     dex
  2216  1ef2 d0f4                                   bne -                                               
  2217  1ef4 18                                     clc
  2218  1ef5 6901                                   adc #$01                                        ; increases volume again before returning to title screen
  2219  1ef7 8da91e                                 sta music_volume+1                              ; sound volume
  2220  1efa 4cdf1e                                 jmp --
  2221                          
  2222                          
  2223                          
  2224                                              ; 222222222222222         000000000          000000000          000000000
  2225                                              ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
  2226                                              ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2227                                              ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2228                                              ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2229                                              ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2230                                              ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2231                                              ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2232                                              ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2233                                              ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2234                                              ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2235                                              ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2236                                              ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2237                                              ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2238                                              ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
  2239                                              ;22222222222222222222     000000000          000000000          000000000
  2240                          
  2241                          ; ==============================================================================
  2242                          ; CHARSET
  2243                          ; $2000 - $2800
  2244                          ; ==============================================================================
  2245                          
  2246                          
  2247                          charset_start:
  2248                                              *= $2000
  2249                                              !if EXTENDED {
  2250                                                  !bin "includes/charset-new-charset.bin"
  2251                                              }else{
  2252  2000 000000020a292727...                        !bin "includes/charset.bin"
  2253                                              }
  2254                          charset_end:    ; $2800
  2255                          
  2256                          
  2257                                              ; 222222222222222         888888888          000000000           000000000
  2258                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  2259                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  2260                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2261                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2262                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2263                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  2264                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2265                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2266                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2267                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2268                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2269                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2270                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  2271                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  2272                                              ;22222222222222222222     888888888           000000000           000000000
  2273                          
  2274                          
  2275                          
  2276                          ; ==============================================================================
  2277                          ; LEVEL DATA
  2278                          ; Based on tiles
  2279                          ;                     !IMPORTANT!
  2280                          ;                     has to be page aligned or
  2281                          ;                     display_room routine will fail
  2282                          ; ==============================================================================
  2283                          
  2284                                              *= $2800
  2285                          level_data:

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
  2287                          level_data_end:
  2288                          
  2289                          
  2290                          ;$2fbf
  2291                          speed_byte:
  2292  2fb8 01                 !byte $01
  2293                          
  2294                          
  2295                          
  2296                          
  2297                          
  2298                          ; ==============================================================================
  2299                          ;
  2300                          ;
  2301                          ; ==============================================================================
  2302                                  
  2303                          
  2304                          rasterpoll_and_other_stuff:
  2305                          
  2306  2fb9 209f35                                 jsr poll_raster
  2307  2fbc 20c039                                 jsr check_door 
  2308  2fbf 4c7b14                                 jmp animation_entrypoint          
  2309                          
  2310                          
  2311                          
  2312                          ; ==============================================================================
  2313                          ;
  2314                          ; tileset definition
  2315                          ; these are the first characters in the charset of each tile.
  2316                          ; example: rocks start at $0c and span 9 characters in total
  2317                          ; ==============================================================================
  2318                          
  2319                          tileset_definition:
  2320                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  2321  2fc2 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
  2322                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2323  2fca 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
  2324                                              ;     $10
  2325  2fd2 03                                     !byte $03                                           ; door
  2326                          
  2327                          !if EXTENDED = 0{
  2328                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2329  2fd3 000a0a0e3d7f2a2a                       !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
  2330                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2331  2fdb 1e1e1e3d3d0e2f2f                       !byte $1e, $1e, $1e, $3d, $3d, $0e, $2f, $2f
  2332                                              ;     $10
  2333  2fe3 0a                                     !byte $0a
  2334                          }
  2335                          
  2336                          !if EXTENDED = 1{
  2337                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2338                                              !byte $00, $39, $2a, $0e, $3d, $7f, $2a, $2a
  2339                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2340                                              !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2341                                              ;     $10
  2342                                              !byte $29   
  2343                          }
  2344                          
  2345                          ; ==============================================================================
  2346                          ;
  2347                          ; displays a room based on tiles
  2348                          ; ==============================================================================
  2349                          
  2350                          display_room:       
  2351  2fe4 208b3a                                 jsr draw_border
  2352  2fe7 a900                                   lda #$00
  2353  2fe9 8502                                   sta zp02
  2354  2feb a2d8                                   ldx #>COLRAM        ; HiByte of COLRAM
  2355  2fed 8605                                   stx zp05
  2356  2fef a204                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  2357  2ff1 8603                                   stx zp03
  2358  2ff3 a228                                   ldx #>level_data    ; HiByte of level_data
  2359  2ff5 860a                                   stx zp0A            ; in zp0A
  2360  2ff7 a201               current_room:       ldx #$01            ; current_room in X
  2361  2ff9 f00a                                   beq ++              ; if 0 -> skip
  2362  2ffb 18                 -                   clc                 ; else
  2363  2ffc 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  2364  2ffe 9002                                   bcc +               ; to zp09/zp0A
  2365  3000 e60a                                   inc zp0A            ;
  2366  3002 ca                 +                   dex                 ; X times
  2367  3003 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  2368  3005 8509               ++                  sta zp09            ; LoByte from above
  2369  3007 a000                                   ldy #$00
  2370  3009 84a8                                   sty zpA8
  2371  300b 84a7                                   sty zpA7
  2372  300d b109               m3066:              lda (zp09),y        ; get Tilenumber
  2373  300f aa                                     tax                 ; in X
  2374  3010 bdd32f                                 lda tiles_colors,x  ; get Tilecolor
  2375  3013 8510                                   sta zp10            ; => zp10
  2376  3015 bdc22f                                 lda tiles_chars,x   ; get Tilechar
  2377  3018 8511                                   sta zp11            ; => zp11
  2378  301a a203                                   ldx #$03            ; (3 rows)
  2379  301c a000               --                  ldy #$00
  2380  301e a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  2381  3020 8504                                   sta zp04            ; LoByte of COLRAM pointer
  2382  3022 a511                                   lda zp11            ; Load Tilechar
  2383  3024 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  2384  3026 a510                                   lda zp10            ; Load Tilecolor
  2385  3028 9104                                   sta (zp04),y        ; to COLRAM + Y
  2386  302a a511                                   lda zp11            ; Load Tilechar again
  2387  302c c9df                                   cmp #$df            ; if empty tile
  2388  302e f002                                   beq +               ; -> skip
  2389  3030 e611                                   inc zp11            ; else: Tilechar + 1
  2390  3032 c8                 +                   iny                 ; Y = Y + 1
  2391  3033 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  2392  3035 d0e7                                   bne -               ; no -> next Char
  2393  3037 a502                                   lda zp02            ; yes:
  2394  3039 18                                     clc
  2395  303a 6928                                   adc #$28            ; next SCREEN row
  2396  303c 8502                                   sta zp02
  2397  303e 9004                                   bcc +
  2398  3040 e603                                   inc zp03
  2399  3042 e605                                   inc zp05            ; and COLRAM row
  2400  3044 ca                 +                   dex                 ; X = X - 1
  2401  3045 d0d5                                   bne --              ; X != 0 -> next Char
  2402  3047 e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  2403  3049 e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  2404  304b a975                                   lda #$75            ; for m30B8 + 1
  2405  304d a6a8                                   ldx zpA8
  2406  304f e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  2407  3051 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  2408  3053 a6a7                                   ldx zpA7            ; else:
  2409  3055 e066                                   cpx #$66            ; zpA7 >= $66
  2410  3057 b01c                                   bcs display_door    ; yes: display_door
  2411  3059 a900                                   lda #$00            ; else:
  2412  305b 85a8                                   sta zpA8            ; clear zpA8
  2413  305d a924                                   lda #$24            ; for m30B8 + 1
  2414  305f 8d6630             +                   sta m30B8 + 1       ;
  2415  3062 a502                                   lda zp02
  2416  3064 38                                     sec
  2417  3065 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  2418  3067 8502                                   sta zp02
  2419  3069 b004                                   bcs +
  2420  306b c603                                   dec zp03
  2421  306d c605                                   dec zp05
  2422  306f a4a7               +                   ldy zpA7
  2423  3071 4c0d30                                 jmp m3066
  2424  3074 60                                     rts                 ; will this ever be used?
  2425                          
  2426  3075 a904               display_door:       lda #>SCREENRAM
  2427  3077 8503                                   sta zp03
  2428  3079 a9d8                                   lda #>COLRAM
  2429  307b 8505                                   sta zp05
  2430  307d a900                                   lda #$00
  2431  307f 8502                                   sta zp02
  2432  3081 8504                                   sta zp04
  2433  3083 a028               -                   ldy #$28
  2434  3085 b102                                   lda (zp02),y        ; read from SCREENRAM
  2435  3087 c906                                   cmp #$06            ; $06 (part from Door?)
  2436  3089 b00b                                   bcs +               ; >= $06 -> skip
  2437  308b 38                                     sec                 ; else:
  2438  308c e903                                   sbc #$03            ; subtract $03
  2439  308e a000                                   ldy #$00            ; set Y = $00
  2440  3090 9102                                   sta (zp02),y        ; and copy to one row above
  2441  3092 a90a                                   lda #$0a            ; lda #$39 ; color brown - luminance $3  -> color of the top of a door
  2442  3094 9104                                   sta (zp04),y
  2443  3096 a502               +                   lda zp02
  2444  3098 18                                     clc
  2445  3099 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  2446  309b 9004                                   bcc +
  2447  309d e603                                   inc zp03            ; inc pointer HiBytes if necessary
  2448  309f e605                                   inc zp05
  2449  30a1 8502               +                   sta zp02
  2450  30a3 8504                                   sta zp04
  2451  30a5 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  2452  30a7 d0da                                   bne -               ; no -> loop
  2453  30a9 a503                                   lda zp03            ; else:
  2454  30ab c907                                   cmp #>(SCREENRAM+$300)
  2455  30ad d0d4                                   bne -               ; no -> loop
  2456  30af 60                                     rts                 ; else: finally ready with room display
  2457                          
  2458                          ; ==============================================================================
  2459                          
  2460  30b0 a904               print_title:        lda #>SCREENRAM
  2461  30b2 8503                                   sta zp03
  2462  30b4 a9d8                                   lda #>COLRAM
  2463  30b6 8505                                   sta zp05
  2464  30b8 a900                                   lda #<SCREENRAM
  2465  30ba 8502                                   sta zp02
  2466  30bc 8504                                   sta zp04
  2467  30be a930                                   lda #>screen_start_src
  2468  30c0 85a8                                   sta zpA8
  2469  30c2 a9df                                   lda #<screen_start_src
  2470  30c4 85a7                                   sta zpA7
  2471  30c6 a204                                   ldx #$04
  2472  30c8 a000               --                  ldy #$00
  2473  30ca b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  2474  30cc 9102                                   sta (zp02),y        ; nach SCREEN
  2475  30ce a900                                   lda #$00           ; BLACK
  2476  30d0 9104                                   sta (zp04),y        ; nach COLRAM
  2477  30d2 c8                                     iny
  2478  30d3 d0f5                                   bne -
  2479  30d5 e603                                   inc zp03
  2480  30d7 e605                                   inc zp05
  2481  30d9 e6a8                                   inc zpA8
  2482  30db ca                                     dex
  2483  30dc d0ea                                   bne --
  2484  30de 60                                     rts
  2485                          
  2486                          ; ==============================================================================
  2487                          ; TITLE SCREEN DATA
  2488                          ;
  2489                          ; ==============================================================================
  2490                          
  2491                          screen_start_src:
  2492                          
  2493                                              !if EXTENDED {
  2494                                                  !bin "includes/screen-start-extended.scr"
  2495                                              }else{
  2496  30df 20202020202020a0...                        !bin "includes/screen-start.scr"
  2497                                              }
  2498                          
  2499                          screen_start_src_end:
  2500                          
  2501                          
  2502                          ; ==============================================================================
  2503                          ; i think this might be the draw routine for the player sprite
  2504                          ;
  2505                          ; ==============================================================================
  2506                          
  2507                          
  2508                          draw_player:
  2509  34c7 8eea34                                 stx m3548 + 1                       ; store x pos of player
  2510  34ca a9d8                                   lda #>COLRAM                        ; store colram high in zp05
  2511  34cc 8505                                   sta zp05
  2512  34ce a904                                   lda #>SCREENRAM                     ; store screenram high in zp03
  2513  34d0 8503                                   sta zp03
  2514  34d2 a900                                   lda #$00
  2515  34d4 8502                                   sta zp02
  2516  34d6 8504                                   sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
  2517  34d8 c000                                   cpy #$00                            ; Y is probably the player Y position
  2518  34da f00c                                   beq +                               ; Y is 0 -> +
  2519  34dc 18                 -                   clc                                 ; Y not 0
  2520  34dd 6928                                   adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
  2521  34df 9004                                   bcc ++                              ; <256? -> ++
  2522  34e1 e603                                   inc zp03
  2523  34e3 e605                                   inc zp05
  2524  34e5 88                 ++                  dey                                 ; Y = Y - 1
  2525  34e6 d0f4                                   bne -                               ; Y = 0 ? -> -
  2526  34e8 18                 +                   clc                                 ;
  2527  34e9 6916               m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
  2528  34eb 8502                                   sta zp02
  2529  34ed 8504                                   sta zp04
  2530  34ef 9004                                   bcc +
  2531  34f1 e603                                   inc zp03
  2532  34f3 e605                                   inc zp05
  2533  34f5 a203               +                   ldx #$03                            ; draw 3 rows for the player "sprite"
  2534  34f7 a900                                   lda #$00
  2535  34f9 8509                                   sta zp09
  2536  34fb a000               --                  ldy #$00
  2537  34fd a5a7               -                   lda zpA7
  2538  34ff d006                                   bne +
  2539  3501 a9df                                   lda #$df                            ; empty char, but not sure why
  2540  3503 9102                                   sta (zp02),y
  2541  3505 d01b                                   bne ++
  2542  3507 c901               +                   cmp #$01
  2543  3509 d00a                                   bne +
  2544  350b a5a8                                   lda zpA8
  2545  350d 9102                                   sta (zp02),y
  2546  350f a50a                                   lda zp0A
  2547  3511 9104                                   sta (zp04),y
  2548  3513 d00d                                   bne ++
  2549  3515 b102               +                   lda (zp02),y
  2550  3517 8610                                   stx zp10
  2551  3519 a609                                   ldx zp09
  2552  351b 9d4503                                 sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
  2553  351e e609                                   inc zp09
  2554  3520 a610                                   ldx zp10
  2555  3522 e6a8               ++                  inc zpA8
  2556  3524 c8                                     iny
  2557  3525 c003                                   cpy #$03                            ; width of the player sprite in characters (3)
  2558  3527 d0d4                                   bne -
  2559  3529 a502                                   lda zp02
  2560  352b 18                                     clc
  2561  352c 6928                                   adc #$28                            ; $28 = #40, draws one row of the player under each other
  2562  352e 8502                                   sta zp02
  2563  3530 8504                                   sta zp04
  2564  3532 9004                                   bcc +
  2565  3534 e603                                   inc zp03
  2566  3536 e605                                   inc zp05
  2567  3538 ca                 +                   dex
  2568  3539 d0c0                                   bne --
  2569  353b 60                                     rts
  2570                          
  2571                          
  2572                          ; ==============================================================================
  2573                          ; $359b
  2574                          ; JOYSTICK CONTROLS
  2575                          ; ==============================================================================
  2576                          
  2577                          check_joystick:
  2578                          
  2579                                              ;lda #$fd
  2580                                              ;sta KEYBOARD_LATCH
  2581                                              ;lda KEYBOARD_LATCH
  2582  353c ad00dc                                 lda $dc00
  2583  353f a009               player_pos_y:       ldy #$09
  2584  3541 a215               player_pos_x:       ldx #$15
  2585  3543 4a                                     lsr
  2586  3544 b005                                   bcs +
  2587  3546 c000                                   cpy #$00
  2588  3548 f001                                   beq +
  2589  354a 88                                     dey                                           ; JOYSTICK UP
  2590  354b 4a                 +                   lsr
  2591  354c b005                                   bcs +
  2592  354e c015                                   cpy #$15
  2593  3550 b001                                   bcs +
  2594  3552 c8                                     iny                                           ; JOYSTICK DOWN
  2595  3553 4a                 +                   lsr
  2596  3554 b005                                   bcs +
  2597  3556 e000                                   cpx #$00
  2598  3558 f001                                   beq +
  2599  355a ca                                     dex                                           ; JOYSTICK LEFT
  2600  355b 4a                 +                   lsr
  2601  355c b005                                   bcs +
  2602  355e e024                                   cpx #$24
  2603  3560 b001                                   bcs +
  2604  3562 e8                                     inx                                           ; JOYSTICK RIGHT
  2605  3563 8c8135             +                   sty m35E7 + 1
  2606  3566 8e8635                                 stx m35EC + 1
  2607  3569 a902                                   lda #$02
  2608  356b 85a7                                   sta zpA7
  2609  356d 20c734                                 jsr draw_player
  2610  3570 a209                                   ldx #$09
  2611  3572 bd4403             -                   lda TAPE_BUFFER + $8,x
  2612  3575 c9df                                   cmp #$df
  2613  3577 f004                                   beq +
  2614  3579 c9e2                                   cmp #$e2
  2615  357b d00d                                   bne ++
  2616  357d ca                 +                   dex
  2617  357e d0f2                                   bne -
  2618  3580 a90a               m35E7:              lda #$0a
  2619  3582 8d4035                                 sta player_pos_y + 1
  2620  3585 a915               m35EC:              lda #$15
  2621  3587 8d4235                                 sta player_pos_x + 1
  2622                          ++                  ;lda #$ff
  2623                                              ;sta KEYBOARD_LATCH
  2624  358a a901                                   lda #$01
  2625  358c 85a7                                   sta zpA7
  2626  358e a993                                   lda #$93                ; first character of the player graphic
  2627  3590 85a8                                   sta zpA8
  2628  3592 a93d                                   lda #$3d
  2629  3594 850a                                   sta zp0A
  2630  3596 ac4035             get_player_pos:     ldy player_pos_y + 1
  2631  3599 ae4235                                 ldx player_pos_x + 1
  2632                                        
  2633  359c 4cc734                                 jmp draw_player
  2634                          
  2635                          ; ==============================================================================
  2636                          ;
  2637                          ; POLL RASTER
  2638                          ; ==============================================================================
  2639                          
  2640                          poll_raster:
  2641  359f 78                                     sei                     ; disable interrupt
  2642  35a0 a9f0                                   lda #$f0                ; lda #$c0  ;A = $c0
  2643  35a2 cd12d0             -                   cmp FF1D                ; vertical line bits 0-7
  2644                                              
  2645  35a5 d0fb                                   bne -                   ; loop until we hit line c0
  2646  35a7 a900                                   lda #$00                ; A = 0
  2647  35a9 85a7                                   sta zpA7                ; zpA7 = 0
  2648                                              
  2649  35ab 209635                                 jsr get_player_pos
  2650                                              
  2651  35ae 203c35                                 jsr check_joystick
  2652  35b1 58                                     cli
  2653  35b2 60                                     rts
  2654                          
  2655                          
  2656                          ; ==============================================================================
  2657                          ; ROOM 16
  2658                          ; BELEGRO ANIMATION
  2659                          ; ==============================================================================
  2660                          
  2661                          belegro_animation:
  2662                          
  2663  35b3 a900                                   lda #$00
  2664  35b5 85a7                                   sta zpA7
  2665  35b7 a20f               m3624:              ldx #$0f
  2666  35b9 a00f               m3626:              ldy #$0f
  2667  35bb 20c734                                 jsr draw_player
  2668  35be aeb835                                 ldx m3624 + 1
  2669  35c1 acba35                                 ldy m3626 + 1
  2670  35c4 ec4235                                 cpx player_pos_x + 1
  2671  35c7 b002                                   bcs +
  2672  35c9 e8                                     inx
  2673  35ca e8                                     inx
  2674  35cb ec4235             +                   cpx player_pos_x + 1
  2675  35ce f001                                   beq +
  2676  35d0 ca                                     dex
  2677  35d1 cc4035             +                   cpy player_pos_y + 1
  2678  35d4 b002                                   bcs +
  2679  35d6 c8                                     iny
  2680  35d7 c8                                     iny
  2681  35d8 cc4035             +                   cpy player_pos_y + 1
  2682  35db f001                                   beq +
  2683  35dd 88                                     dey
  2684  35de 8ef835             +                   stx m3668 + 1
  2685  35e1 8cfd35                                 sty m366D + 1
  2686  35e4 a902                                   lda #$02
  2687  35e6 85a7                                   sta zpA7
  2688  35e8 20c734                                 jsr draw_player
  2689  35eb a209                                   ldx #$09
  2690  35ed bd4403             -                   lda TAPE_BUFFER + $8,x
  2691  35f0 c992                                   cmp #$92
  2692  35f2 900d                                   bcc +
  2693  35f4 ca                                     dex
  2694  35f5 d0f6                                   bne -
  2695  35f7 a210               m3668:              ldx #$10
  2696  35f9 8eb835                                 stx m3624 + 1
  2697  35fc a00e               m366D:              ldy #$0e
  2698  35fe 8cba35                                 sty m3626 + 1
  2699  3601 a99c               +                   lda #$9c                                ; belegro chars
  2700  3603 85a8                                   sta zpA8
  2701  3605 a93e                                   lda #$3e
  2702  3607 850a                                   sta zp0A
  2703  3609 acba35                                 ldy m3626 + 1
  2704  360c aeb835                                 ldx m3624 + 1                    
  2705  360f a901                                   lda #$01
  2706  3611 85a7                                   sta zpA7
  2707  3613 4cc734                                 jmp draw_player
  2708                          
  2709                          
  2710                          ; ==============================================================================
  2711                          ; items
  2712                          ; This area seems to be responsible for items placement
  2713                          ;
  2714                          ; ==============================================================================
  2715                          
  2716                          items:

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
    12  3616 ff00fefd29fb79fa...!byte $ff ,$00 ,$fe ,$fd ,$29 ,$fb ,$79 ,$fa ,$a9 ,$ff ,$01 ,$fd ,$bf ,$fb ,$49 ,$fa
    13  3626 e0f9fcfefdf6fb3d...!byte $e0 ,$f9 ,$fc ,$fe ,$fd ,$f6 ,$fb ,$3d ,$fa ,$ac ,$f9 ,$fc ,$fe ,$fd ,$1e ,$fc
    14  3636 f9fcff02fb5ffdb3...!byte $f9 ,$fc ,$ff ,$02 ,$fb ,$5f ,$fd ,$b3 ,$fa ,$b8 ,$f9 ,$fc ,$fd ,$db ,$fc ,$f9
    15  3646 fcfdd3fefefb49fa...!byte $fc ,$fd ,$d3 ,$fe ,$fe ,$fb ,$49 ,$fa ,$a5 ,$f9 ,$f8 ,$f9 ,$f8 ,$f9 ,$fc ,$f9
    16  3656 faa8fdfffaa7fefd...!byte $fa ,$a8 ,$fd ,$ff ,$fa ,$a7 ,$fe ,$fd ,$27 ,$f8 ,$fd ,$24 ,$fa ,$b0 ,$f9 ,$fc
    17  3666 fd4cfcf9fcfd74fa...!byte $fd ,$4c ,$fc ,$f9 ,$fc ,$fd ,$74 ,$fa ,$b5 ,$fc ,$f9 ,$fc ,$fd ,$27 ,$fa ,$a7
    18  3676 fd4ff8fd77f8fd9f...!byte $fd ,$4f ,$f8 ,$fd ,$77 ,$f8 ,$fd ,$9f ,$f8 ,$ff ,$90 ,$ff ,$07 ,$fe ,$fe ,$fd
    19  3686 d1fb00fa5ef9fcfd...!byte $d1 ,$fb ,$00 ,$fa ,$5e ,$f9 ,$fc ,$fd ,$f9 ,$fc ,$f9 ,$fc ,$ff ,$08 ,$fe ,$fd
    20  3696 33fb4cfac6f9fcf9...!byte $33 ,$fb ,$4c ,$fa ,$c6 ,$f9 ,$fc ,$f9 ,$fc ,$fd ,$5b ,$fc ,$f9 ,$fc ,$f9 ,$fc
    21  36a6 fefdacfb3ffac0f9...!byte $fe ,$fd ,$ac ,$fb ,$3f ,$fa ,$c0 ,$f9 ,$fc ,$fd ,$d4 ,$fc ,$f9 ,$fc ,$fd ,$fc
    22  36b6 fcf9fcff0afefefd...!byte $fc ,$f9 ,$fc ,$ff ,$0a ,$fe ,$fe ,$fd ,$9c ,$fb ,$29 ,$fa ,$cc ,$f9 ,$fc ,$fd
    23  36c6 c4fcf9fcff0bfd94...!byte $c4 ,$fc ,$f9 ,$fc ,$ff ,$0b ,$fd ,$94 ,$fb ,$39 ,$fa ,$d0 ,$fd ,$bc ,$fc ,$ff
    24  36d6 0cfefefd15fb39fa...!byte $0c ,$fe ,$fe ,$fd ,$15 ,$fb ,$39 ,$fa ,$d2 ,$f9 ,$fc ,$fd ,$3d ,$fc ,$f9 ,$fc
    25  36e6 ff0dfbfffad6fdae...!byte $ff ,$0d ,$fb ,$ff ,$fa ,$d6 ,$fd ,$ae ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$11 ,$f8 ,$fd
    26  36f6 65f8fd40f8fd69f8...!byte $65 ,$f8 ,$fd ,$40 ,$f8 ,$fd ,$69 ,$f8 ,$fe ,$fd ,$44 ,$f8 ,$fd ,$98 ,$f8 ,$fd
    27  3706 f4f8fd7ef8fd51f8...!byte $f4 ,$f8 ,$fd ,$7e ,$f8 ,$fd ,$51 ,$f8 ,$fd ,$0c ,$f8 ,$fd ,$83 ,$f8 ,$fe ,$fd
    28  3716 0ff8fd86f8fd82f8...!byte $0f ,$f8 ,$fd ,$86 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$f8 ,$f8 ,$fd ,$b4 ,$f8 ,$fd ,$15
    29  3726 f8fd40f8fd25f8fd...!byte $f8 ,$fd ,$40 ,$f8 ,$fd ,$25 ,$f8 ,$fd ,$9b ,$f8 ,$fe ,$fd ,$71 ,$f8 ,$fd ,$4d
    30  3736 f8fd79f8fda6f8ff...!byte $f8 ,$fd ,$79 ,$f8 ,$fd ,$a6 ,$f8 ,$ff ,$0e ,$fd ,$f6 ,$fb ,$00 ,$fa ,$d7 ,$f8
    31  3746 fd82f8fefd5ff8fd...!byte $fd ,$82 ,$f8 ,$fe ,$fd ,$5f ,$f8 ,$fd ,$84 ,$f8 ,$fd ,$82 ,$f8 ,$fd ,$e6 ,$f8
    32  3756 fd71f8fd73f8fd1f...!byte $fd ,$71 ,$f8 ,$fd ,$73 ,$f8 ,$fd ,$1f ,$f8 ,$fd ,$1c ,$f8 ,$fe ,$fd ,$24 ,$f8
    33  3766 fd27f8fd50f8fd48...!byte $fd ,$27 ,$f8 ,$fd ,$50 ,$f8 ,$fd ,$48 ,$f8 ,$fd ,$c4 ,$f8 ,$fd ,$c0 ,$f8 ,$fd
    34  3776 94f8fde0f8fd64f8...!byte $94 ,$f8 ,$fd ,$e0 ,$f8 ,$fd ,$64 ,$f8 ,$fd ,$3f ,$f8 ,$fd ,$13 ,$f8 ,$fe ,$fd
    35  3786 15f8fd34f8fd04f8...!byte $15 ,$f8 ,$fd ,$34 ,$f8 ,$fd ,$04 ,$f8 ,$ff ,$10 ,$fd ,$63 ,$fb ,$5f ,$fa ,$b8
    36  3796 f9fcfd8bfcf8f9fc...!byte $f9 ,$fc ,$fd ,$8b ,$fc ,$f8 ,$f9 ,$fc ,$fe ,$fe ,$fb ,$39 ,$fd ,$fb ,$fa ,$f4
    37  37a6 fdf2fb39fad9f9fc...!byte $fd ,$f2 ,$fb ,$39 ,$fa ,$d9 ,$f9 ,$fc ,$fd ,$1a ,$fe ,$fc ,$f9 ,$fc ,$ff ,$11
    38  37b6 fefefdc3fb39fadd...!byte $fe ,$fe ,$fd ,$c3 ,$fb ,$39 ,$fa ,$dd ,$fd ,$eb ,$fc ,$ff ,$ff ,$ff ,$ff ,$ff
    39                                          

; ******** Source: main.asm
  2718                          items_end:
  2719                          
  2720                          next_item:
  2721  37c6 a5a7                                   lda zpA7
  2722  37c8 18                                     clc
  2723  37c9 6901                                   adc #$01
  2724  37cb 85a7                                   sta zpA7
  2725  37cd 9002                                   bcc +                       ; bcc $3845
  2726  37cf e6a8                                   inc zpA8
  2727  37d1 60                 +                   rts
  2728                          
  2729                          ; ==============================================================================
  2730                          ; TODO
  2731                          ; no clue yet. level data has already been drawn when this is called
  2732                          ; probably placing the items on the screen
  2733                          ; ==============================================================================
  2734                          
  2735                          update_items_display:
  2736  37d2 a936                                   lda #>items                 ; load address for items into zeropage
  2737  37d4 85a8                                   sta zpA8
  2738  37d6 a916                                   lda #<items
  2739  37d8 85a7                                   sta zpA7
  2740  37da a000                                   ldy #$00                    ; y = 0
  2741  37dc b1a7               --                  lda (zpA7),y                ; load first value
  2742  37de c9ff                                   cmp #$ff                    ; is it $ff?
  2743  37e0 f006                                   beq +                       ; yes -> +
  2744  37e2 20c637             -                   jsr next_item               ; no -> set zero page to next value
  2745  37e5 4cdc37                                 jmp --                      ; and loop
  2746  37e8 20c637             +                   jsr next_item               ; value was $ff, now get the next value in the list
  2747  37eb b1a7                                   lda (zpA7),y
  2748  37ed c9ff                                   cmp #$ff                    ; is the next value $ff again?
  2749  37ef d003                                   bne +
  2750  37f1 4c7638                                 jmp prepare_rooms           ; yes -> m38DF
  2751  37f4 cdf82f             +                   cmp current_room + 1        ; is the number the current room number?
  2752  37f7 d0e9                                   bne -                       ; no -> loop
  2753  37f9 a9d8                                   lda #>COLRAM                ; yes the number is the current room number
  2754  37fb 8505                                   sta zp05                    ; store COLRAM and SCREENRAM in zeropage
  2755  37fd a904                                   lda #>SCREENRAM
  2756  37ff 8503                                   sta zp03
  2757  3801 a900                                   lda #$00                    ; A = 0
  2758  3803 8502                                   sta zp02                    ; zp02 = 0, zp04 = 0
  2759  3805 8504                                   sta zp04
  2760  3807 20c637                                 jsr next_item               ; move to next value
  2761  380a b1a7                                   lda (zpA7),y                ; get next value in the list
  2762  380c c9fe               -                   cmp #$fe                    ; is it $FE?
  2763  380e f00b                                   beq +                       ; yes -> +
  2764  3810 c9f9                                   cmp #$f9                    ; no, is it $f9?
  2765  3812 d00d                                   bne +++                     ; no -> +++
  2766  3814 a502                                   lda zp02                    ; value is $f9
  2767  3816 206e38                                 jsr m38D7                   ; add 1 to zp02 and zp04
  2768  3819 9004                                   bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
  2769  381b e603               +                   inc zp03                    ; value is $fe
  2770  381d e605                                   inc zp05                    ; increase zp03 and zp05
  2771  381f b1a7               ++                  lda (zpA7),y                ; get value from list
  2772  3821 c9fb               +++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
  2773  3823 d009                                   bne +                       ; no -> +
  2774  3825 20c637                                 jsr next_item               ; yes it's $fb, get the next value
  2775  3828 b1a7                                   lda (zpA7),y                ; get value from list
  2776  382a 8509                                   sta zp09                    ; store value in zp09
  2777  382c d028                                   bne ++                      ; if value was 0 -> ++
  2778  382e c9f8               +                   cmp #$f8
  2779  3830 f01c                                   beq +
  2780  3832 c9fc                                   cmp #$fc
  2781  3834 d00d                                   bne +++
  2782  3836 a50a                                   lda zp0A
  2783                                                                          ; jmp m399F
  2784                          
  2785  3838 c9df                                   cmp #$df                    ; this part was moved here as it wasn't called anywhere else
  2786  383a f002                                   beq skip                    ; and I think it was just outsourced for branching length issues
  2787  383c e60a                                   inc zp0A           
  2788  383e b1a7               skip:               lda (zpA7),y        
  2789  3840 4c4e38                                 jmp m38B7
  2790                          
  2791  3843 c9fa               +++                 cmp #$fa
  2792  3845 d00f                                   bne ++
  2793  3847 20c637                                 jsr next_item
  2794  384a b1a7                                   lda (zpA7),y
  2795  384c 850a                                   sta zp0A
  2796                          m38B7:
  2797  384e a509               +                   lda zp09
  2798  3850 9104                                   sta (zp04),y
  2799  3852 a50a                                   lda zp0A
  2800  3854 9102                                   sta (zp02),y
  2801  3856 c9fd               ++                  cmp #$fd
  2802  3858 d009                                   bne +
  2803  385a 20c637                                 jsr next_item
  2804  385d b1a7                                   lda (zpA7),y
  2805  385f 8502                                   sta zp02
  2806  3861 8504                                   sta zp04
  2807  3863 20c637             +                   jsr next_item
  2808  3866 b1a7                                   lda (zpA7),y
  2809  3868 c9ff                                   cmp #$ff
  2810  386a d0a0                                   bne -
  2811  386c f008                                   beq prepare_rooms
  2812  386e 18                 m38D7:              clc
  2813  386f 6901                                   adc #$01
  2814  3871 8502                                   sta zp02
  2815  3873 8504                                   sta zp04
  2816  3875 60                                     rts
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
  2836                          
  2837                          
  2838                          
  2839                          
  2840                          
  2841                          
  2842                          
  2843                          
  2844                          
  2845                          ; ==============================================================================
  2846                          ; ROOM PREPARATION CHECK
  2847                          ; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
  2848                          ; ==============================================================================
  2849                          
  2850                          prepare_rooms:
  2851                                      
  2852  3876 adf82f                                 lda current_room + 1
  2853                                              
  2854  3879 c902                                   cmp #$02                                ; is the current room 02?
  2855  387b f01d                                   beq room_02_prep
  2856                          
  2857  387d c907                                   cmp #$07
  2858  387f f04c                                   beq room_07_make_sacred_column
  2859                                              
  2860  3881 c906                                   cmp #$06          
  2861  3883 f05a                                   beq room_06_make_deadly_doors
  2862                          
  2863  3885 c904                                   cmp #$04
  2864  3887 f062                                   beq room_04_prep
  2865                          
  2866  3889 c905                                   cmp #$05
  2867  388b f001                                   beq room_05_prep
  2868                          
  2869  388d 60                                     rts
  2870                          
  2871                          
  2872                          
  2873                          ; ==============================================================================
  2874                          ; ROOM 05
  2875                          ; HIDE THE BREATHING TUBE UNDER THE STONE
  2876                          ; ==============================================================================
  2877                          
  2878                          room_05_prep:                  
  2879                                                         
  2880  388e a9fd                                   lda #$fd                                    ; yes
  2881  3890 a201               breathing_tube_mod: ldx #$01
  2882  3892 d002                                   bne +                                       ; based on self mod, put the normal
  2883  3894 a97a                                   lda #$7a                                    ; stone char back again
  2884  3896 8dd206             +                   sta SCREENRAM + $2d2   
  2885  3899 60                                     rts
  2886                          
  2887                          
  2888                          
  2889                          ; ==============================================================================
  2890                          ; ROOM 02 PREP
  2891                          ; 
  2892                          ; ==============================================================================
  2893                          
  2894                          room_02_prep:
  2895  389a a90d                                   lda #$0d                                ; yes room is 02, a = $0d #13
  2896  389c 8502                                   sta zp02                                ; zp02 = $0d
  2897  389e 8504                                   sta zp04                                ; zp04 = $0d
  2898  38a0 a9d8                                   lda #>COLRAM                            ; set colram zp
  2899  38a2 8505                                   sta zp05
  2900  38a4 a904                                   lda #>SCREENRAM                         ; set screenram zp      
  2901  38a6 8503                                   sta zp03
  2902  38a8 a218                                   ldx #$18                                ; x = $18 #24
  2903  38aa b102               -                   lda (zp02),y                            ; y must have been set earlier
  2904  38ac c9df                                   cmp #$df                                ; $df = empty space likely
  2905  38ae f004                                   beq delete_fence                        ; yes, empty -> m3900
  2906  38b0 c9f5                                   cmp #$f5                                ; no, but maybe a $f5? (fence!)
  2907  38b2 d006                                   bne +                                   ; nope -> ++
  2908                          
  2909                          delete_fence:
  2910  38b4 a9f5                                   lda #$f5                                ; A is either $df or $f5 -> selfmod here
  2911  38b6 9102                                   sta (zp02),y                            ; store that value
  2912  38b8 9104                                   sta (zp04),y                            ; in zp02 and zo04
  2913  38ba a502               +                   lda zp02                                ; and load it in again, jeez
  2914  38bc 18                                     clc
  2915  38bd 6928                                   adc #$28                                ; smells like we're going to draw a fence
  2916  38bf 8502                                   sta zp02
  2917  38c1 8504                                   sta zp04
  2918  38c3 9004                                   bcc +             
  2919  38c5 e603                                   inc zp03
  2920  38c7 e605                                   inc zp05
  2921  38c9 ca                 +                   dex
  2922  38ca d0de                                   bne -              
  2923  38cc 60                                     rts
  2924                          
  2925                          ; ==============================================================================
  2926                          ; ROOM 07 PREP
  2927                          ;
  2928                          ; ==============================================================================
  2929                          
  2930                          room_07_make_sacred_column:
  2931                          
  2932                                              
  2933  38cd a217                                   ldx #$17                                    ; yes
  2934  38cf bd6805             -                   lda SCREENRAM + $168,x     
  2935  38d2 c9df                                   cmp #$df
  2936  38d4 d005                                   bne +                       
  2937  38d6 a9e3                                   lda #$e3
  2938  38d8 9d6805                                 sta SCREENRAM + $168,x    
  2939  38db ca                 +                   dex
  2940  38dc d0f1                                   bne -                      
  2941  38de 60                                     rts
  2942                          
  2943                          
  2944                          ; ==============================================================================
  2945                          ; ROOM 06
  2946                          ; PREPARE THE DEADLY DOORS
  2947                          ; ==============================================================================
  2948                          
  2949                          room_06_make_deadly_doors:
  2950                          
  2951                                              
  2952  38df a9f6                                   lda #$f6                                    ; char for wrong door
  2953  38e1 8d9c04                                 sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
  2954  38e4 8d7c06                                 sta SCREENRAM + $27c
  2955  38e7 8d6c07                                 sta SCREENRAM + $36c       
  2956  38ea 60                                     rts
  2957                          
  2958                          ; ==============================================================================
  2959                          ; ROOM 04
  2960                          ; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
  2961                          ; ==============================================================================
  2962                          
  2963                          room_04_prep: 
  2964                          
  2965                          
  2966                                              
  2967  38eb adf82f                                 lda current_room + 1                            ; get current room
  2968  38ee c904                                   cmp #04                                         ; is it 4? (coffins)
  2969  38f0 d00c                                   bne ++                                          ; nope
  2970  38f2 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  2971  38f4 ac0339                                 ldy m394A + 1                                   ; 
  2972  38f7 f002                                   beq +
  2973  38f9 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  2974  38fb 8df904             +                   sta SCREENRAM + $f9 
  2975                                          
  2976  38fe a2f7               ++                  ldx #$f7                                    ; yes room 04
  2977  3900 a0f8                                   ldy #$f8
  2978  3902 a901               m394A:              lda #$01
  2979  3904 d004                                   bne m3952           
  2980  3906 a23b                                   ldx #$3b
  2981  3908 a042                                   ldy #$42
  2982  390a a901               m3952:              lda #$01                                    ; some self mod here
  2983  390c c901                                   cmp #$01
  2984  390e d003                                   bne +           
  2985  3910 8e7a04                                 stx SCREENRAM+ $7a 
  2986  3913 c902               +                   cmp #$02
  2987  3915 d003                                   bne +           
  2988  3917 8e6a05                                 stx SCREENRAM + $16a   
  2989  391a c903               +                   cmp #$03
  2990  391c d003                                   bne +           
  2991  391e 8e5a06                                 stx SCREENRAM + $25a       
  2992  3921 c904               +                   cmp #$04
  2993  3923 d003                                   bne +           
  2994  3925 8e4a07                                 stx SCREENRAM + $34a   
  2995  3928 c905               +                   cmp #$05
  2996  392a d003                                   bne +           
  2997  392c 8c9c04                                 sty SCREENRAM + $9c    
  2998  392f c906               +                   cmp #$06
  2999  3931 d003                                   bne +           
  3000  3933 8c8c05                                 sty SCREENRAM + $18c   
  3001  3936 c907               +                   cmp #$07
  3002  3938 d003                                   bne +           
  3003  393a 8c7c06                                 sty SCREENRAM + $27c 
  3004  393d c908               +                   cmp #$08
  3005  393f d003                                   bne +           
  3006  3941 8c6c07                                 sty SCREENRAM + $36c   
  3007  3944 60                 +                   rts
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
  3019                          
  3020                          
  3021                          
  3022                          
  3023                          
  3024                          
  3025                          
  3026                          
  3027                          
  3028                          ; ==============================================================================
  3029                          ; PLAYER POSITION TABLE FOR EACH ROOM
  3030                          ; FORMAT: Y left door, X left door, Y right door, X right door
  3031                          ; ==============================================================================
  3032                          
  3033                          player_xy_pos_table:
  3034                          
  3035  3945 06031221           !byte $06, $03, $12, $21                                        ; room 00
  3036  3949 03031221           !byte $03, $03, $12, $21                                        ; room 01
  3037  394d 03031521           !byte $03, $03, $15, $21                                        ; room 02
  3038  3951 03030f21           !byte $03, $03, $0f, $21                                        ; room 03
  3039  3955 151e0606           !byte $15, $1e, $06, $06                                        ; room 04
  3040  3959 06031221           !byte $06, $03, $12, $21                                        ; room 05
  3041  395d 03030921           !byte $03, $03, $09, $21                                        ; room 06
  3042  3961 03031221           !byte $03, $03, $12, $21                                        ; room 07
  3043  3965 03030c21           !byte $03, $03, $0c, $21                                        ; room 08
  3044  3969 03031221           !byte $03, $03, $12, $21                                        ; room 09
  3045  396d 0c030c20           !byte $0c, $03, $0c, $20                                        ; room 10
  3046  3971 0c030c21           !byte $0c, $03, $0c, $21                                        ; room 11
  3047  3975 0c030915           !byte $0c, $03, $09, $15                                        ; room 12
  3048  3979 03030621           !byte $03, $03, $06, $21                                        ; room 13
  3049  397d 03030321           !byte $03, $03, $03, $21                                        ; room 14
  3050  3981 06031221           !byte $06, $03, $12, $21                                        ; room 15
  3051  3985 0303031d           !byte $03, $03, $03, $1d                                        ; room 16
  3052  3989 03030621           !byte $03, $03, $06, $21                                        ; room 17
  3053  398d 0303               !byte $03, $03                                                  ; room 18 (only one door)
  3054                          
  3055                          
  3056                          
  3057                          ; ==============================================================================
  3058                          ; $3a33
  3059                          ; Apparently some lookup table, e.g. to get the 
  3060                          ; ==============================================================================
  3061                          
  3062                          room_player_pos_lookup:
  3063                          
  3064  398f 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  3065  399f 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  3066  39af 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  3067  39bf 00                 !byte $00
  3068                          
  3069                          
  3070                          
  3071                          
  3072                          
  3073                          
  3074                          
  3075                          
  3076                          
  3077                          
  3078                          
  3079                          ; ==============================================================================
  3080                          ;
  3081                          ;
  3082                          ; ==============================================================================
  3083                          
  3084                          check_door:
  3085                          
  3086  39c0 a209                                   ldx #$09                                    ; set loop to 9
  3087  39c2 bd4403             -                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
  3088  39c5 c905                                   cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
  3089  39c7 f008                                   beq +                                       ; yes -> +
  3090  39c9 c903                                   cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
  3091  39cb f013                                   beq set_player_xy                           ; yes -> m3A17
  3092  39cd ca                                     dex                                         ; decrease loop
  3093  39ce d0f2                                   bne -                                       ; loop
  3094  39d0 60                 -                   rts
  3095                          
  3096  39d1 aef82f             +                   ldx current_room + 1
  3097  39d4 f0fa                                   beq -               
  3098  39d6 ca                                     dex
  3099  39d7 8ef82f                                 stx current_room + 1                        ; update room number                         
  3100  39da bc8f39                                 ldy room_player_pos_lookup,x                ; load        
  3101  39dd 4cea39                                 jmp update_player_pos           
  3102                          
  3103                          set_player_xy:
  3104  39e0 aef82f                                 ldx current_room + 1                            ; x = room number
  3105  39e3 e8                                     inx                                             ; room number ++
  3106  39e4 8ef82f                                 stx current_room + 1                            ; update room number
  3107  39e7 bca639                                 ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room
  3108                          
  3109                          update_player_pos:              
  3110  39ea b94539                                 lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
  3111  39ed 8d4035                                 sta player_pos_y + 1                            ; player y pos = a
  3112  39f0 b94639                                 lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
  3113  39f3 8d4235                                 sta player_pos_x + 1
  3114                          
  3115  39f6 20e42f             m3A2D:              jsr display_room                                ; done  
  3116  39f9 208c15                                 jsr room_04_prep_door                           ; was in main loop before, might find a better place
  3117  39fc 4cd237                                 jmp update_items_display
  3118                          
  3119                          
  3120                          
  3121                          ; ==============================================================================
  3122                          ;
  3123                          ; wait routine
  3124                          ; usually called with Y set before
  3125                          ; ==============================================================================
  3126                          
  3127                          wait:
  3128  39ff ca                                     dex
  3129  3a00 d0fd                                   bne wait
  3130  3a02 88                                     dey
  3131  3a03 d0fa                                   bne wait
  3132  3a05 60                 fake:               rts
  3133                          
  3134                          
  3135                          ; ==============================================================================
  3136                          ; sets the game screen
  3137                          ; multicolor, charset, main colors
  3138                          ; ==============================================================================
  3139                          
  3140                          set_game_basics:
  3141  3a06 ad12ff                                 lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  3142  3a09 29fb                                   and #$fb                                    ; clear bit 2
  3143  3a0b 8d12ff                                 sta VOICE1                                  ; => get data from RAM
  3144  3a0e a918                                   lda #$18            ;lda #$21
  3145  3a10 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
  3146                                              
  3147                                                                                          ; bit 1 : Single clock set  ( 0 )
  3148                                                                                          ; b.2-7 : character data base address
  3149                                                                                          ; %00100$x ($2000)
  3150  3a13 ad16d0                                 lda FF07
  3151  3a16 0990                                   ora #$90                                    ; multicolor ON - reverse OFF
  3152  3a18 8d16d0                                 sta FF07
  3153                          
  3154                                                                                          ; set the main colors for the game
  3155                          
  3156  3a1b a90a                                   lda #MULTICOLOR_1                           ; original: #$db
  3157  3a1d 8d22d0                                 sta COLOR_1                                 ; char color 1
  3158  3a20 a909                                   lda #MULTICOLOR_2                           ; original: #$29
  3159  3a22 8d23d0                                 sta COLOR_2                                 ; char color 2
  3160                                              
  3161  3a25 60                                     rts
  3162                          
  3163                          ; ==============================================================================
  3164                          ; set font and screen setup (40 columns and hires)
  3165                          ; $3a9d
  3166                          ; ==============================================================================
  3167                          
  3168                          set_charset_and_screen:                               ; set text screen
  3169                                             
  3170  3a26 ad12ff                                 lda VOICE1
  3171  3a29 0904                                   ora #$04                                    ; set bit 2
  3172  3a2b 8d12ff                                 sta VOICE1                                  ; => get data from ROM
  3173  3a2e a917                                   lda #$17                                    ; lda #$d5                                    ; ROM FONT
  3174  3a30 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; set
  3175  3a33 ad16d0                                 lda FF07
  3176  3a36 a908                                   lda #$08                                    ; 40 columns and Multicolor OFF
  3177  3a38 8d16d0                                 sta FF07
  3178  3a3b 60                                     rts
  3179                          
  3180                          test:
  3181  3a3c ee20d0                                 inc BORDER_COLOR
  3182  3a3f 4c3c3a                                 jmp test
  3183                          
  3184                          ; ==============================================================================
  3185                          ; init
  3186                          ; start of game (original $3ab3)
  3187                          ; ==============================================================================
  3188                          
  3189                          code_start:
  3190                          init:
  3191                                              ;jsr init_music           ; TODO
  3192                                              
  3193  3a42 a917                                   lda #$17                  ; set lower case charset
  3194  3a44 8d18d0                                 sta $d018                 ; wasn't on Plus/4 for some reason
  3195                                              
  3196  3a47 a90b                                   lda #$0b
  3197  3a49 8d21d0                                 sta BG_COLOR              ; background color
  3198  3a4c 8d20d0                                 sta BORDER_COLOR          ; border color
  3199  3a4f 20b616                                 jsr reset_items           ; might be a level data reset, and print the title screen
  3200                          
  3201  3a52 a020                                   ldy #$20
  3202  3a54 20ff39                                 jsr wait
  3203                                              
  3204                                              ; waiting for key press on title screen
  3205                          
  3206  3a57 a5cb               -                   lda $cb                   ; zp position of currently pressed key
  3207  3a59 c938                                   cmp #$38                  ; is it the space key?
  3208  3a5b d0fa                                   bne -
  3209                          
  3210                                                                        ; lda #$ff
  3211  3a5d 20e71c                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  3212                                              
  3213                          
  3214                                              ; TODO: unclear what the code below does
  3215                                              ; i think it fills the level data with "DF", which is a blank character
  3216  3a60 a904                                   lda #>SCREENRAM
  3217  3a62 8503                                   sta zp03
  3218  3a64 a900                                   lda #$00
  3219  3a66 8502                                   sta zp02
  3220  3a68 a204                                   ldx #$04
  3221  3a6a a000                                   ldy #$00
  3222  3a6c a9df                                   lda #$df
  3223  3a6e 9102               -                   sta (zp02),y
  3224  3a70 c8                                     iny
  3225  3a71 d0fb                                   bne -
  3226  3a73 e603                                   inc zp03
  3227  3a75 ca                                     dex
  3228  3a76 d0f6                                   bne -
  3229                                              
  3230  3a78 20063a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  3231                          
  3232                                              ; set background color
  3233  3a7b a900                                   lda #$00
  3234  3a7d 8d21d0                                 sta BG_COLOR
  3235                          
  3236                                              ; border color. default is a dark red
  3237  3a80 a902                                   lda #BORDER_COLOR_VALUE
  3238  3a82 8d20d0                                 sta BORDER_COLOR
  3239                                              
  3240  3a85 208b3a                                 jsr draw_border
  3241                                              
  3242  3a88 4cc33a                                 jmp set_start_screen
  3243                          
  3244                          ; ==============================================================================
  3245                          ;
  3246                          ; draws the extended "border"
  3247                          ; ==============================================================================
  3248                          
  3249                          draw_border:        
  3250  3a8b a927                                   lda #$27
  3251  3a8d 8502                                   sta zp02
  3252  3a8f 8504                                   sta zp04
  3253  3a91 a9d8                                   lda #>COLRAM
  3254  3a93 8505                                   sta zp05
  3255  3a95 a904                                   lda #>SCREENRAM
  3256  3a97 8503                                   sta zp03
  3257  3a99 a218                                   ldx #$18
  3258  3a9b a000                                   ldy #$00
  3259  3a9d a95d               -                   lda #$5d
  3260  3a9f 9102                                   sta (zp02),y
  3261  3aa1 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3262  3aa3 9104                                   sta (zp04),y
  3263  3aa5 98                                     tya
  3264  3aa6 18                                     clc
  3265  3aa7 6928                                   adc #$28
  3266  3aa9 a8                                     tay
  3267  3aaa 9004                                   bcc +
  3268  3aac e603                                   inc zp03
  3269  3aae e605                                   inc zp05
  3270  3ab0 ca                 +                   dex
  3271  3ab1 d0ea                                   bne -
  3272  3ab3 a95d               -                   lda #$5d
  3273  3ab5 9dc007                                 sta SCREENRAM + $3c0,x
  3274  3ab8 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3275  3aba 9dc0db                                 sta COLRAM + $3c0,x
  3276  3abd e8                                     inx
  3277  3abe e028                                   cpx #$28
  3278  3ac0 d0f1                                   bne -
  3279  3ac2 60                                     rts
  3280                          
  3281                          ; ==============================================================================
  3282                          ; SETUP FIRST ROOM
  3283                          ; player xy position and room number
  3284                          ; ==============================================================================
  3285                          
  3286                          set_start_screen:
  3287  3ac3 a906                                   lda #PLAYER_START_POS_Y
  3288  3ac5 8d4035                                 sta player_pos_y + 1                    ; Y player start position (0 = top)
  3289  3ac8 a903                                   lda #PLAYER_START_POS_X
  3290  3aca 8d4235                                 sta player_pos_x + 1                    ; X player start position (0 = left)
  3291  3acd a910                                   lda #START_ROOM                         ; room number (start screen) ($3b45)
  3292  3acf 8df82f                                 sta current_room + 1
  3293  3ad2 20f639                                 jsr m3A2D
  3294                                              
  3295                          
  3296                          main_loop:
  3297                                              
  3298  3ad5 20b92f                                 jsr rasterpoll_and_other_stuff
  3299  3ad8 a01b                                   ldy #$1b                                ; ldy #$30    ; wait a bit -> in each frame! slows down movement
  3300  3ada 20ff39                                 jsr wait
  3301                                                                                      ;jsr room_04_prep_door
  3302  3add 202916                                 jsr prep_player_pos
  3303  3ae0 4c4216                                 jmp object_collision
  3304                          
  3305                          ; ==============================================================================
  3306                          ;
  3307                          ; Display the death message
  3308                          ; End of game and return to start screen
  3309                          ; ==============================================================================
  3310                          
  3311                          death:
  3312                                             
  3313  3ae3 a93b                                   lda #>death_messages
  3314  3ae5 85a8                                   sta zpA8
  3315  3ae7 a962                                   lda #<death_messages
  3316  3ae9 85a7                                   sta zpA7
  3317  3aeb c000                                   cpy #$00
  3318  3aed f00c                                   beq ++
  3319  3aef 18                 -                   clc
  3320  3af0 6932                                   adc #$32
  3321  3af2 85a7                                   sta zpA7
  3322  3af4 9002                                   bcc +
  3323  3af6 e6a8                                   inc zpA8
  3324  3af8 88                 +                   dey
  3325  3af9 d0f4                                   bne -
  3326  3afb a90c               ++                  lda #$0c
  3327  3afd 8503                                   sta zp03
  3328  3aff 8402                                   sty zp02
  3329  3b01 a204                                   ldx #$04
  3330  3b03 a920                                   lda #$20
  3331  3b05 9102               -                   sta (zp02),y
  3332  3b07 c8                                     iny
  3333  3b08 d0fb                                   bne -
  3334  3b0a e603                                   inc zp03
  3335  3b0c ca                                     dex
  3336  3b0d d0f6                                   bne -
  3337  3b0f 20263a                                 jsr set_charset_and_screen
  3338  3b12 20423b                                 jsr clear
  3339  3b15 b1a7               -                   lda (zpA7),y
  3340  3b17 9dc005                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  3341  3b1a a900                                   lda #$00                                    ; color of the death message
  3342  3b1c 9dc0d9                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  3343  3b1f e8                                     inx
  3344  3b20 c8                                     iny
  3345  3b21 e019                                   cpx #$19
  3346  3b23 d002                                   bne +
  3347  3b25 a250                                   ldx #$50
  3348  3b27 c032               +                   cpy #$32
  3349  3b29 d0ea                                   bne -
  3350  3b2b a903                                   lda #$03
  3351  3b2d 8d21d0                                 sta BG_COLOR
  3352  3b30 8d20d0                                 sta BORDER_COLOR
  3353                                             
  3354                          m3EF9:
  3355  3b33 a908                                   lda #$08
  3356  3b35 a0ff               -                   ldy #$ff
  3357  3b37 20ff39                                 jsr wait
  3358  3b3a 38                                     sec
  3359  3b3b e901                                   sbc #$01
  3360  3b3d d0f6                                   bne -
  3361                                              
  3362  3b3f 4c423a                                 jmp init
  3363                          
  3364                          ; ==============================================================================
  3365                          ;
  3366                          ; clear the sceen (replacing kernal call on plus/4)
  3367                          ; 
  3368                          ; ==============================================================================
  3369                          
  3370  3b42 a920               clear               lda #$20     ; #$20 is the spacebar Screen Code
  3371  3b44 9d0004                                 sta $0400,x  ; fill four areas with 256 spacebar characters
  3372  3b47 9d0005                                 sta $0500,x 
  3373  3b4a 9d0006                                 sta $0600,x 
  3374  3b4d 9de806                                 sta $06e8,x 
  3375  3b50 a900                                   lda #$00     ; set foreground to black in Color Ram 
  3376  3b52 9d00d8                                 sta $d800,x  
  3377  3b55 9d00d9                                 sta $d900,x
  3378  3b58 9d00da                                 sta $da00,x
  3379  3b5b 9de8da                                 sta $dae8,x
  3380  3b5e e8                                     inx           ; increment X
  3381  3b5f d0e1                                   bne clear     ; did X turn to zero yet?
  3382                                                          ; if not, continue with the loop
  3383  3b61 60                                     rts           ; return from this subroutine
  3384                          ; ==============================================================================
  3385                          ;
  3386                          ; DEATH MESSAGES
  3387                          ; ==============================================================================
  3388                          
  3389                          death_messages:
  3390                          
  3391                          ; death messages
  3392                          ; like "You fell into a snake pit"
  3393                          
  3394                          ; scr conversion
  3395                          
  3396                          ; 00 You fell into a snake pit
  3397                          ; 01 You'd better watched out for the sacred column
  3398                          ; 02 You drowned in the deep river
  3399                          ; 03 You drank from the poisend bottle
  3400                          ; 04 Boris the spider got you and killed you
  3401                          ; 05 Didn't you see the laser beam?
  3402                          ; 06 240 Volts! You got an electrical shock!
  3403                          ; 07 You stepped on a nail!
  3404                          ; 08 A foot trap stopped you!
  3405                          ; 09 This room is doomed by the wizard Manilo!
  3406                          ; 0a You were locked in and starved!
  3407                          ; 0b You were hit by a big rock and died!
  3408                          ; 0c Belegro killed you!
  3409                          ; 0d You found a thirsty zombie....
  3410                          ; 0e The monster grabbed you you. You are dead!
  3411                          ; 0f You were wounded by the bush!
  3412                          ; 10 You are trapped in wire-nettings!
  3413                          
  3414                          !if LANGUAGE = EN{
  3415  3b62 590f152006050c0c...!scr "You fell into a          snake pit !              "
  3416  3b94 590f152704200205...!scr "You'd better watched out for the sacred column!   "
  3417  3bc6 590f152004120f17...!scr "You drowned in the deep  river !                  "
  3418  3bf8 590f15200412010e...!scr "You drank from the       poisened bottle ........ "
  3419  3c2a 420f1209132c2014...!scr "Boris, the spider, got   you and killed you !     "
  3420  3c5c 4409040e27142019...!scr "Didn't you see the       laser beam ?!?           "
  3421  3c8e 32343020560f0c14...!scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  3422  3cc0 590f152013140510...!scr "You stepped on a nail !                           "
  3423  3cf2 4120060f0f142014...!scr "A foot trap stopped you !                         "
  3424  3d24 5408091320120f0f...!scr "This room is doomed      by the wizard Manilo !   "
  3425  3d56 590f152017051205...!scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  3426  3d88 590f152017051205...!scr "You were hit by a big    rock and died !          "
  3427  3dba 42050c0507120f20...!scr "Belegro killed           you !                    "
  3428  3dec 590f1520060f150e...!scr "You found a thirsty      zombie .......           "
  3429  3e1e 540805200d0f0e13...!scr "The monster grapped       you. You are dead !     "
  3430  3e50 590f152017051205...!scr "You were wounded by      the bush !               "
  3431  3e82 590f152001120520...!scr "You are trapped in       wire-nettings !          "
  3432                          }
  3433                          
  3434                          
  3435                          !if LANGUAGE = DE{
  3436                          !scr "Sie sind in eine         Schlangengrube gefallen !"
  3437                          !scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  3438                          !scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  3439                          !scr "Sie haben aus der Gift-  flasche getrunken....... "
  3440                          !scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  3441                          !scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  3442                          !scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  3443                          !scr "Sie sind in einen Nagel  getreten !               "
  3444                          !scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  3445                          !scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  3446                          !scr "Sie wurden eingeschlossenund verhungern !         "
  3447                          !scr "Sie wurden von einem     Stein ueberollt !!       "
  3448                          !scr "Belegro hat Sie          vernichtet !             "
  3449                          !scr "Im Sarg lag ein durstigerZombie........           "
  3450                          !scr "Das Monster hat Sie      erwischt !!!!!           "
  3451                          !scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  3452                          !scr "Sie haben sich im        Stacheldraht verfangen !!"
  3453                          }
  3454                          
  3455                          ; ==============================================================================
  3456                          ; screen messages
  3457                          ; and the code entry text
  3458                          ; ==============================================================================
  3459                          
  3460                          !if LANGUAGE = EN{
  3461                          
  3462                          hint_messages:
  3463  3eb4 2041201001121420...!scr " A part of the code number is :         "
  3464  3edc 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3465  3f04 20590f15200e0505...!scr " You need: bulb, bulb holder, socket !  "
  3466  3f2c 2054050c0c200d05...!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  3467  3f54 202a2a2a2a2a2020...!scr " *****   A helping letter :   "
  3468  3f72 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  3469  3f7c 2057120f0e072003...!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  3470                          
  3471                          }
  3472                          
  3473                          !if LANGUAGE = DE{
  3474                          
  3475                          hint_messages:
  3476                          !scr " Ein Teil des Loesungscodes lautet:     "
  3477                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3478                          !scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  3479                          !scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  3480                          !scr " *****   Ein Hilfsbuchstabe:  "
  3481                          helping_letter: !scr "C   ***** "
  3482                          !scr " Falscher Loesungscode ! TODESSTRAFE !! "
  3483                          
  3484                          }
  3485                          
  3486                          
  3487                          ; ==============================================================================
  3488                          ;
  3489                          ; ITEM PICKUP MESSAGES
  3490                          ; ==============================================================================
  3491                          
  3492                          
  3493                          item_pickup_message:              ; item pickup messages
  3494                          
  3495                          !if LANGUAGE = EN{
  3496  3fa4 2054080512052009...!scr " There is a key in the bottle !         "
  3497  3fcc 2020205408051205...!scr "   There is a key in the coffin !       "
  3498  3ff4 2054080512052009...!scr " There is a breathing tube !            "
  3499                          }
  3500                          
  3501                          !if LANGUAGE = DE{
  3502                          !scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
  3503                          !scr "    In dem Sarg lag ein Schluessel !    "
  3504                          !scr " Unter dem Stein lag ein Taucheranzug ! "
  3505                          }
  3506                          item_pickup_message_end:
