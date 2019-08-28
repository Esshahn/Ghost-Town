
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
   162  1000 203f3b                                 jsr clear               ;     jsr PRINT_KERNAL   
   163                                                   
   164                          
   165                          display_hint_message:
   166                                              
   167  1003 a93e                                   lda #>hint_messages
   168  1005 85a8                                   sta zpA8
   169  1007 a9b1                                   lda #<hint_messages
   170  1009 c000               m1009:              cpy #$00
   171  100b f00a                                   beq ++              
   172  100d 18                 -                   clc
   173  100e 6928                                   adc #$28
   174  1010 9002                                   bcc +               
   175  1012 e6a8                                   inc zpA8
   176  1014 88                 +                   dey
   177  1015 d0f6                                   bne -               
   178  1017 85a7               ++                  sta zpA7
   179  1019 20263a                                 jsr set_charset_and_screen          
   180  101c a027                                   ldy #$27
   181  101e b1a7               -                   lda (zpA7),y
   182  1020 99b805                                 sta SCREENRAM+$1B8,y 
   183  1023 a905                                   lda #$05
   184  1025 99b8d9                                 sta COLRAM+$1B8,y 
   185  1028 88                                     dey
   186  1029 d0f3                                   bne -               
   187  102b 60                                     rts
   188                          
   189                          
   190                          ; ==============================================================================
   191                          ;
   192                          ;
   193                          ; ==============================================================================
   194                          
   195                          prep_and_display_hint:
   196                          
   197  102c 204511                                 jsr switch_charset           
   198  102f c003                                   cpy #$03                                ; is the display hint the one for the code number?
   199  1031 f003                                   beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
   200  1033 4ccd10                                 jmp display_hint                        ; no, display the hint
   201                          
   202                          
   203                          room_16_code_number_prep:
   204                          
   205  1036 200310                                 jsr display_hint_message                ; yes we are in room 3
   206                                              ;jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   207                                              ;jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   208  1039 a001                                   ldy #$01                                ; y = 1
   209  103b 200310                                 jsr display_hint_message              
   210  103e a200                                   ldx #$00                                ; x = 0
   211  1040 a000                                   ldy #$00                                ; y = 0
   212  1042 f013                                   beq room_16_enter_code                  ; room 16 code? how?
   213                          
   214                          room_16_cursor_blinking: 
   215                          
   216  1044 bdb905                                 lda SCREENRAM+$1B9,x                    ; load something from screen
   217  1047 18                                     clc                                     
   218  1048 6980                                   adc #$80                                ; add $80 = 128 = inverted char
   219  104a 9db905                                 sta SCREENRAM+$1B9,x                    ; store in the same location
   220  104d b98805                                 lda SCREENRAM+$188,y                    ; and the same for another position
   221  1050 18                                     clc
   222  1051 6980                                   adc #$80
   223  1053 998805                                 sta SCREENRAM+$188,y 
   224  1056 60                                     rts
   225                          
   226                          ; ==============================================================================
   227                          ; ROOM 16
   228                          ; ENTER CODE
   229                          ; ==============================================================================
   230                          
   231                          room_16_enter_code:
   232  1057 204410                                 jsr room_16_cursor_blinking
   233  105a 8402                                   sty zp02
   234  105c 8604                                   stx zp04
   235  105e 209a10                                 jsr room_16_code_delay           
   236  1061 204410                                 jsr room_16_cursor_blinking           
   237  1064 209a10                                 jsr room_16_code_delay
   238  1067 ad00dc                                 lda $dc00
   239                                              ;lda #$fd                                        ; KEYBOARD stuff
   240                                              ;sta KEYBOARD_LATCH                              ; .
   241                                              ;lda KEYBOARD_LATCH                              ; .
   242  106a 4a                                     lsr                                             ; .
   243  106b 4a                                     lsr
   244  106c 4a                                     lsr
   245  106d b005                                   bcs +
   246  106f e000                                   cpx #$00
   247  1071 f001                                   beq +
   248  1073 ca                                     dex
   249  1074 4a                 +                   lsr
   250  1075 b005                                   bcs +
   251  1077 e025                                   cpx #$25
   252  1079 f001                                   beq +
   253  107b e8                                     inx
   254  107c 2908               +                   and #$08
   255  107e d0d7                                   bne room_16_enter_code
   256  1080 bdb905                                 lda SCREENRAM+$1B9,x
   257  1083 c9bc                                   cmp #$bc
   258  1085 d008                                   bne ++
   259  1087 c000                                   cpy #$00
   260  1089 f001                                   beq +
   261  108b 88                                     dey
   262  108c 4c5710             +                   jmp room_16_enter_code
   263  108f 998805             ++                  sta SCREENRAM+$188,y
   264  1092 c8                                     iny
   265  1093 c005                                   cpy #$05
   266  1095 d0c0                                   bne room_16_enter_code
   267  1097 4ca410                                 jmp check_code_number
   268                          
   269                          ; ==============================================================================
   270                          ;
   271                          ; DELAYS CURSOR MOVEMENT AND BLINKING
   272                          ; ==============================================================================
   273                          
   274                          room_16_code_delay:
   275  109a a035                                   ldy #$35                            ; wait a bit
   276  109c 20ff39                                 jsr wait                        
   277  109f a402                                   ldy zp02                            ; and load x and y 
   278  10a1 a604                                   ldx zp04                            ; with shit from zp
   279  10a3 60                                     rts
   280                          
   281                          ; ==============================================================================
   282                          ; ROOM 16
   283                          ; CHECK THE CODE NUMBER
   284                          ; ==============================================================================
   285                          
   286                          check_code_number:
   287  10a4 a205                                   ldx #$05                            ; x = 5
   288  10a6 bd8705             -                   lda SCREENRAM+$187,x                ; get one number from code
   289  10a9 ddbb10                                 cmp code_number-1,x                 ; is it correct?
   290  10ac d006                                   bne +                               ; no -> +
   291  10ae ca                                     dex                                 ; yes, check next number
   292  10af d0f5                                   bne -                               
   293  10b1 4cc110                                 jmp ++                              ; all correct -> ++
   294  10b4 a005               +                   ldy #$05                            ; text for wrong code number
   295  10b6 200310                                 jsr display_hint_message            ; wrong code -> death
   296  10b9 4c303b                                 jmp m3EF9          
   297                          
   298  10bc 3036313338         code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38
   299                          
   300  10c1 20063a             ++                  jsr set_game_basics                 ; code correct, continue
   301  10c4 20e039                                 jsr set_player_xy          
   302  10c7 208b3a                                 jsr draw_border          
   303  10ca 4cd53a                                 jmp main_loop          
   304                          
   305                          ; ==============================================================================
   306                          ;
   307                          ; hint system (question marks)
   308                          ; ==============================================================================
   309                          
   310                          
   311                          display_hint:
   312  10cd c000                                   cpy #$00
   313  10cf d04a                                   bne m11A2           
   314  10d1 200010                                 jsr display_hint_message_plus_kernal
   315  10d4 aef82f                                 ldx current_room + 1
   316  10d7 e001                                   cpx #$01
   317  10d9 d002                                   bne +               
   318  10db a928                                   lda #$28
   319  10dd e005               +                   cpx #$05
   320  10df d002                                   bne +               
   321  10e1 a929                                   lda #$29
   322  10e3 e00a               +                   cpx #$0a
   323  10e5 d002                                   bne +               
   324  10e7 a947                                   lda #$47                   
   325  10e9 e00c               +                   cpx #$0c
   326  10eb d002                                   bne +
   327  10ed a949                                   lda #$49
   328  10ef e00d               +                   cpx #$0d
   329  10f1 d002                                   bne +
   330  10f3 a945                                   lda #$45
   331  10f5 e00f               +                   cpx #$0f
   332  10f7 d00a                                   bne +               
   333  10f9 a945                                   lda #$45
   334                                             
   335  10fb 8d6fda                                 sta COLRAM + $26f       
   336  10fe a90f                                   lda #$0f
   337  1100 8d6f06                                 sta SCREENRAM + $26f       
   338  1103 8d1f06             +                   sta SCREENRAM + $21f       
   339  1106 a948                                   lda #$48
   340  1108 8d1fda                                 sta COLRAM + $21f       
   341  110b ad00dc             -                   lda $dc00                         ;lda #$fd
   342                                                                                ;sta KEYBOARD_LATCH
   343                                                                                ; lda KEYBOARD_LATCH
   344  110e 2910                                   and #$10                          ; and #$80
   345  1110 d0f9                                   bne -               
   346  1112 20063a                                 jsr set_game_basics
   347  1115 20f639                                 jsr m3A2D          
   348  1118 4cd53a                                 jmp main_loop         
   349  111b c002               m11A2:              cpy #$02
   350  111d d006                                   bne +             
   351  111f 200010             m11A6:              jsr display_hint_message_plus_kernal
   352  1122 4c0b11                                 jmp -             
   353  1125 c004               +                   cpy #$04
   354  1127 d00b                                   bne +              
   355  1129 ad0b39                                 lda m3952 + 1    
   356  112c 18                                     clc
   357  112d 6940                                   adc #$40                                        ; this is the helping letter
   358  112f 8d6f3f                                 sta helping_letter         
   359  1132 d0eb                                   bne m11A6          
   360  1134 88                 +                   dey
   361  1135 88                                     dey
   362  1136 88                                     dey
   363  1137 88                                     dey
   364  1138 88                                     dey
   365  1139 a93f                                   lda #>item_pickup_message
   366  113b 85a8                                   sta zpA8
   367  113d a9a1                                   lda #<item_pickup_message
   368  113f 200910                                 jsr m1009
   369  1142 4c0b11                                 jmp -
   370                          
   371                          ; ==============================================================================
   372                          
   373                          switch_charset:
   374  1145 20263a                                 jsr set_charset_and_screen           
   375  1148 4c3f3b                                 jmp clear       ; jmp PRINT_KERNAL           
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
   401                          
   402                          
   403                          ; ==============================================================================
   404                          ;
   405                          ; JUMP TO ROOM LOGIC
   406                          ; This code is new. Previously, code execution jumped from room to room
   407                          ; and in each room did the comparison with the room number.
   408                          ; This is essentially the same, but bundled in one place.
   409                          ; not calles in between room changes, only e.g. for question mark
   410                          ; ==============================================================================
   411                          
   412                          check_room:
   413  114b acf82f                                 ldy current_room + 1        ; load in the current room number
   414  114e c000                                   cpy #0
   415  1150 d003                                   bne +
   416  1152 4ced11                                 jmp room_00
   417  1155 c001               +                   cpy #1
   418  1157 d003                                   bne +
   419  1159 4c0812                                 jmp room_01
   420  115c c002               +                   cpy #2
   421  115e d003                                   bne +
   422  1160 4c4512                                 jmp room_02
   423  1163 c003               +                   cpy #3
   424  1165 d003                                   bne +
   425  1167 4c9b12                                 jmp room_03
   426  116a c004               +                   cpy #4
   427  116c d003                                   bne +
   428  116e 4ca712                                 jmp room_04
   429  1171 c005               +                   cpy #5
   430  1173 d003                                   bne +
   431  1175 4cc912                                 jmp room_05
   432  1178 c006               +                   cpy #6
   433  117a d003                                   bne +
   434  117c 4ced12                                 jmp room_06
   435  117f c007               +                   cpy #7
   436  1181 d003                                   bne +
   437  1183 4cf912                                 jmp room_07
   438  1186 c008               +                   cpy #8
   439  1188 d003                                   bne +
   440  118a 4c3113                                 jmp room_08
   441  118d c009               +                   cpy #9
   442  118f d003                                   bne +
   443  1191 4c8813                                 jmp room_09
   444  1194 c00a               +                   cpy #10
   445  1196 d003                                   bne +
   446  1198 4c9413                                 jmp room_10
   447  119b c00b               +                   cpy #11
   448  119d d003                                   bne +
   449  119f 4cc413                                 jmp room_11 
   450  11a2 c00c               +                   cpy #12
   451  11a4 d003                                   bne +
   452  11a6 4cd313                                 jmp room_12
   453  11a9 c00d               +                   cpy #13
   454  11ab d003                                   bne +
   455  11ad 4cef13                                 jmp room_13
   456  11b0 c00e               +                   cpy #14
   457  11b2 d003                                   bne +
   458  11b4 4c1314                                 jmp room_14
   459  11b7 c00f               +                   cpy #15
   460  11b9 d003                                   bne +
   461  11bb 4c1f14                                 jmp room_15
   462  11be c010               +                   cpy #16
   463  11c0 d003                                   bne +
   464  11c2 4c2b14                                 jmp room_16
   465  11c5 c011               +                   cpy #17
   466  11c7 d003                                   bne +
   467  11c9 4c5114                                 jmp room_17
   468  11cc 4c6014             +                   jmp room_18
   469                          
   470                          
   471                          
   472                          ; ==============================================================================
   473                          
   474                          check_death:
   475  11cf 20d237                                 jsr update_items_display
   476  11d2 4cd53a                                 jmp main_loop           
   477                          
   478                          ; ==============================================================================
   479                          
   480                          m11E0:              
   481  11d5 a200                                   ldx #$00
   482  11d7 bd4503             -                   lda TAPE_BUFFER + $9,x              
   483  11da c91e                                   cmp #$1e                            ; question mark
   484  11dc 9007                                   bcc check_next_char_under_player           
   485  11de c9df                                   cmp #$df
   486  11e0 f003                                   beq check_next_char_under_player
   487  11e2 4c4b11                                 jmp check_room              
   488                          
   489                          ; ==============================================================================
   490                          
   491                          check_next_char_under_player:
   492  11e5 e8                                     inx
   493  11e6 e009                                   cpx #$09
   494  11e8 d0ed                                   bne -                              ; not done checking          
   495  11ea 4cd53a             -                   jmp main_loop           
   496                          
   497                          
   498                          ; ==============================================================================
   499                          ;
   500                          ;                                                             ###        ###
   501                          ;          #####      ####      ####     #    #              #   #      #   #
   502                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   503                          ;          #    #    #    #    #    #    # ## #             #     #    #     #
   504                          ;          #####     #    #    #    #    #    #             #     #    #     #
   505                          ;          #   #     #    #    #    #    #    #              #   #      #   #
   506                          ;          #    #     ####      ####     #    #               ###        ###
   507                          ;
   508                          ; ==============================================================================
   509                          
   510                          
   511                          room_00:
   512                          
   513  11ed c9a9                                   cmp #$a9                                        ; has the player hit the gloves?
   514  11ef d0f4                                   bne check_next_char_under_player                ; no
   515  11f1 a9df                                   lda #$df                                        ; yes, load in char for "empty"
   516  11f3 cd6336                                 cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
   517  11f6 d0f2                                   bne -                                           ; no
   518  11f8 20fd11                                 jsr pickup_gloves                               ; yes
   519  11fb d0d2                                   bne check_death
   520                          
   521                          
   522                          pickup_gloves:
   523  11fd a96b                                   lda #$6b                                        ; load character for empty bush
   524  11ff 8d1e36                                 sta items + $8                                  ; store 6b = gloves in inventory
   525  1202 a93d                                   lda #$3d                                        ; set the foreground color
   526  1204 8d1c36                                 sta items + $6                                  ; and store the color in the items table
   527  1207 60                                     rts
   528                          
   529                          
   530                          
   531                          
   532                          
   533                          
   534                          ; ==============================================================================
   535                          ;
   536                          ;                                                             ###        #
   537                          ;          #####      ####      ####     #    #              #   #      ##
   538                          ;          #    #    #    #    #    #    ##  ##             #     #    # #
   539                          ;          #    #    #    #    #    #    # ## #             #     #      #
   540                          ;          #####     #    #    #    #    #    #             #     #      #
   541                          ;          #   #     #    #    #    #    #    #              #   #       #
   542                          ;          #    #     ####      ####     #    #               ###      #####
   543                          ;
   544                          ; ==============================================================================
   545                          
   546                          room_01:
   547                          
   548  1208 c9e0                                   cmp #$e0                                    ; empty character in charset -> invisible key
   549  120a f004                                   beq +                                       ; yes, key is there -> +
   550  120c c9e1                                   cmp #$e1
   551  120e d014                                   bne ++
   552  1210 a9aa               +                   lda #$aa                                    ; display the key, $AA = 1st part of key
   553  1212 8d2636                                 sta items + $10                             ; store key in items list
   554  1215 20d237                                 jsr update_items_display                    ; update all items in the items list (we just made the key visible)
   555  1218 a0f0                                   ldy #$f0                                    ; set waiting time
   556  121a 20ff39                                 jsr wait                                    ; wait
   557  121d a9df                                   lda #$df                                    ; set key to empty space
   558  121f 8d2636                                 sta items + $10                             ; update items list
   559  1222 d0ab                                   bne check_death
   560  1224 c927               ++                  cmp #$27                                    ; question mark (I don't know why 27)
   561  1226 b005                                   bcs check_death_bush
   562  1228 a000                                   ldy #$00
   563  122a 4c2c10                                 jmp prep_and_display_hint
   564                          
   565                          check_death_bush:
   566  122d c9ad                                   cmp #$ad                                    ; wirecutters
   567  122f d0b4                                   bne check_next_char_under_player
   568  1231 ad1e36                                 lda items + $8                              ; inventory place for the gloves! 6b = gloves
   569  1234 c96b                                   cmp #$6b
   570  1236 f005                                   beq +
   571  1238 a00f                                   ldy #$0f
   572  123a 4ce33a                                 jmp death                                   ; 0f You were wounded by the bush!
   573                          
   574  123d a9f9               +                   lda #$f9                                    ; wirecutter picked up
   575  123f 8d2f36                                 sta items + $19
   576  1242 4ccf11                                 jmp check_death
   577                          
   578                          
   579                          
   580                          
   581                          
   582                          
   583                          ; ==============================================================================
   584                          ;
   585                          ;                                                             ###       #####
   586                          ;          #####      ####      ####     #    #              #   #     #     #
   587                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   588                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   589                          ;          #####     #    #    #    #    #    #             #     #    #
   590                          ;          #   #     #    #    #    #    #    #              #   #     #
   591                          ;          #    #     ####      ####     #    #               ###      #######
   592                          ;
   593                          ; ==============================================================================
   594                          
   595                          room_02:
   596                          
   597  1245 c9f5                                   cmp #$f5                                    ; did the player hit the fence? f5 = fence character
   598  1247 d014                                   bne check_lock                              ; no, check for the lock
   599  1249 ad2f36                                 lda items + $19                             ; fence was hit, so check if wirecuter was picked up
   600  124c c9f9                                   cmp #$f9                                    ; where the wirecutters (f9) picked up?
   601  124e f005                                   beq remove_fence                            ; yes
   602  1250 a010                                   ldy #$10                                    ; no, load the correct death message
   603  1252 4ce33a                                 jmp death                                   ; 10 You are trapped in wire-nettings!
   604                          
   605                          remove_fence:
   606  1255 a9df                                   lda #$df                                    ; empty char
   607  1257 8db538                                 sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
   608  125a 4ccf11             m1264:              jmp check_death
   609                          
   610                          
   611                          check_lock:
   612  125d c9a6                                   cmp #$a6                                    ; lock
   613  125f d00e                                   bne +
   614  1261 ad2636                                 lda items + $10
   615  1264 c9df                                   cmp #$df
   616  1266 d0f2                                   bne m1264
   617  1268 a9df                                   lda #$df
   618  126a 8d4e36                                 sta items + $38
   619  126d d0eb                                   bne m1264
   620  126f c9b1               +                   cmp #$b1                                    ; ladder
   621  1271 d00a                                   bne +
   622  1273 a9df                                   lda #$df
   623  1275 8d6336                                 sta items + $4d
   624  1278 8d6e36                                 sta items + $58
   625  127b d0dd                                   bne m1264
   626  127d c9b9               +                   cmp #$b9                                    ; bottle
   627  127f f003                                   beq +
   628  1281 4ce511                                 jmp check_next_char_under_player
   629  1284 add136             +                   lda items + $bb
   630  1287 c9df                                   cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
   631  1289 f005                                   beq take_key_out_of_bottle                                   
   632  128b a003                                   ldy #$03
   633  128d 4ce33a                                 jmp death                                   ; 03 You drank from the poisend bottle
   634                          
   635                          take_key_out_of_bottle:
   636  1290 a901                                   lda #$01
   637  1292 8d9a12                                 sta key_in_bottle_storage
   638  1295 a005                                   ldy #$05
   639  1297 4c2c10                                 jmp prep_and_display_hint
   640                          
   641                          ; ==============================================================================
   642                          ; this is 1 if the key from the bottle was taken and 0 if not
   643                          
   644  129a 00                 key_in_bottle_storage:              !byte $00
   645                          
   646                          
   647                          
   648                          
   649                          
   650                          
   651                          
   652                          
   653                          
   654                          ; ==============================================================================
   655                          ;
   656                          ;                                                             ###       #####
   657                          ;          #####      ####      ####     #    #              #   #     #     #
   658                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   659                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   660                          ;          #####     #    #    #    #    #    #             #     #          #
   661                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   662                          ;          #    #     ####      ####     #    #               ###       #####
   663                          ;
   664                          ; ==============================================================================
   665                          
   666                          room_03:
   667                          
   668  129b c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   669  129d 9003                                   bcc +
   670  129f 4cd53a                                 jmp main_loop
   671  12a2 a004               +                   ldy #$04
   672  12a4 4c2c10                                 jmp prep_and_display_hint
   673                          
   674                          
   675                          
   676                          
   677                          
   678                          
   679                          ; ==============================================================================
   680                          ;
   681                          ;                                                             ###      #
   682                          ;          #####      ####      ####     #    #              #   #     #    #
   683                          ;          #    #    #    #    #    #    ##  ##             #     #    #    #
   684                          ;          #    #    #    #    #    #    # ## #             #     #    #    #
   685                          ;          #####     #    #    #    #    #    #             #     #    #######
   686                          ;          #   #     #    #    #    #    #    #              #   #          #
   687                          ;          #    #     ####      ####     #    #               ###           #
   688                          ;
   689                          ; ==============================================================================
   690                          
   691                          room_04:
   692                          
   693  12a7 c93b                                   cmp #$3b                                    ; you bumped into a zombie coffin?
   694  12a9 f004                                   beq +                                       ; yep
   695  12ab c942                                   cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
   696  12ad d005                                   bne ++                                      ; no, really, I didn't ( I swear! )-> ++
   697  12af a00d               +                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
   698  12b1 4ce33a                                 jmp death                                   ; 0d You found a thirsty zombie....
   699                          
   700                          ++
   701  12b4 c9f7                                   cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
   702  12b6 f007                                   beq +                                       ; seems you picked a coffin that contained something different...
   703  12b8 c9f8                                   cmp #$f8
   704  12ba f003                                   beq +
   705  12bc 4ce511                                 jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
   706  12bf a900               +                   lda #$00                                    ; 
   707  12c1 8d0339                                 sta m394A + 1                               ; some kind of prep for the door to be unlocked 
   708  12c4 a006                                   ldy #$06                                    ; display
   709  12c6 4c2c10                                 jmp prep_and_display_hint
   710                          
   711                          
   712                          
   713                          
   714                          
   715                          
   716                          ; ==============================================================================
   717                          ;
   718                          ;                                                             ###      #######
   719                          ;          #####      ####      ####     #    #              #   #     #
   720                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   721                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   722                          ;          #####     #    #    #    #    #    #             #     #          #
   723                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   724                          ;          #    #     ####      ####     #    #               ###       #####
   725                          ;
   726                          ; ==============================================================================
   727                          
   728                          room_05:
   729                          
   730  12c9 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   731  12cb b005                                   bcs +                                       ; no
   732  12cd a000                                   ldy #$00                                    ; a = 0
   733  12cf 4c2c10                                 jmp prep_and_display_hint
   734                          
   735  12d2 c9fd               +                   cmp #$fd                                    ; stone with breathing tube hit?
   736  12d4 f003                                   beq +                                       ; yes -> +
   737  12d6 4ce511                                 jmp check_next_char_under_player            ; no
   738                          
   739  12d9 a900               +                   lda #$00                                    ; a = 0                  
   740  12db acac36                                 ldy items + $96                             ; do you have the shovel? 
   741  12de c0df                                   cpy #$df
   742  12e0 d008                                   bne +                                       ; no I don't
   743  12e2 8d9138                                 sta breathing_tube_mod + 1                  ; yes, take the breathing tube
   744  12e5 a007                                   ldy #$07                                    ; and display the message
   745  12e7 4c2c10                                 jmp prep_and_display_hint
   746  12ea 4cd53a             +                   jmp main_loop
   747                          
   748                                              ;ldy #$07                                   ; same is happening above and I don't see this being called
   749                                              ;jmp prep_and_display_hint
   750                          
   751                          
   752                          
   753                          
   754                          
   755                          
   756                          ; ==============================================================================
   757                          ;
   758                          ;                                                             ###       #####
   759                          ;          #####      ####      ####     #    #              #   #     #     #
   760                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   761                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   762                          ;          #####     #    #    #    #    #    #             #     #    #     #
   763                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   764                          ;          #    #     ####      ####     #    #               ###       #####
   765                          ;
   766                          ; ==============================================================================
   767                          
   768                          room_06:
   769                          
   770  12ed c9f6                                   cmp #$f6                                    ; is it a trapped door?
   771  12ef f003                                   beq +                                       ; OMG Yes the room is full of...
   772  12f1 4ce511                                 jmp check_next_char_under_player            ; please move on. nothing happened.
   773  12f4 a000               +                   ldy #$00
   774  12f6 4ce33a                                 jmp death                                   ; 00 You fell into a snake pit
   775                          
   776                          
   777                          
   778                          
   779                          
   780                          
   781                          ; ==============================================================================
   782                          ;
   783                          ;                                                             ###      #######
   784                          ;          #####      ####      ####     #    #              #   #     #    #
   785                          ;          #    #    #    #    #    #    ##  ##             #     #        #
   786                          ;          #    #    #    #    #    #    # ## #             #     #       #
   787                          ;          #####     #    #    #    #    #    #             #     #      #
   788                          ;          #   #     #    #    #    #    #    #              #   #       #
   789                          ;          #    #     ####      ####     #    #               ###        #
   790                          ;
   791                          ; ==============================================================================
   792                          
   793                          room_07:
   794                                  
   795  12f9 c9e3                                   cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
   796  12fb d005                                   bne +
   797  12fd a001                                   ldy #$01                                    ; 01 You'd better watched out for the sacred column
   798  12ff 4ce33a                                 jmp death                                   ; bne m1303 <- seems unneccessary
   799                          
   800  1302 c95f               +                   cmp #$5f                                    ; seems to be the invisible char for the light
   801  1304 f003                                   beq +                                       ; and it was hit -> +
   802  1306 4ce511                                 jmp check_next_char_under_player            ; if not, continue checking
   803                          
   804  1309 a9bc               +                   lda #$bc                                    ; make light visible
   805  130b 8d8a36                                 sta items + $74                             ; but I dont understand how the whole light is shown
   806  130e a95f                                   lda #$5f                                    ; color?
   807  1310 8d8836                                 sta items + $72                             ; 
   808  1313 20d237                                 jsr update_items_display                    ; and redraw items
   809  1316 a0ff                                   ldy #$ff
   810  1318 20ff39                                 jsr wait                                    ; wait for some time so the player can actually see the light
   811  131b 20ff39                                 jsr wait
   812  131e 20ff39                                 jsr wait
   813  1321 20ff39                                 jsr wait
   814  1324 a9df                                   lda #$df
   815  1326 8d8a36                                 sta items + $74                             ; and pick up the light/ remove it from the items list
   816  1329 a900                                   lda #$00
   817  132b 8d8836                                 sta items + $72                             ; also paint the char black
   818  132e 4ccf11                                 jmp check_death
   819                          
   820                          
   821                          
   822                          
   823                          
   824                          
   825                          ; ==============================================================================
   826                          ;
   827                          ;                                                             ###       #####
   828                          ;          #####      ####      ####     #    #              #   #     #     #
   829                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   830                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   831                          ;          #####     #    #    #    #    #    #             #     #    #     #
   832                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   833                          ;          #    #     ####      ####     #    #               ###       #####
   834                          ;
   835                          ; ==============================================================================
   836                          
   837                          room_08:
   838                          
   839  1331 a000                                   ldy #$00                                    ; y = 0
   840  1333 84a7                                   sty zpA7                                    ; zpA7 = 0
   841  1335 c94b                                   cmp #$4b                                    ; water
   842  1337 d015                                   bne check_item_water
   843  1339 ac9138                                 ldy breathing_tube_mod + 1
   844  133c d017                                   bne +
   845  133e 209635                                 jsr get_player_pos
   846  1341 a918                                   lda #$18                                    ; move player on the other side of the river
   847  1343 8d4235             --                  sta player_pos_x + 1
   848  1346 a90c                                   lda #$0c
   849  1348 8d4035                                 sta player_pos_y + 1
   850  134b 4cd53a             -                   jmp main_loop
   851                          
   852                          
   853                          check_item_water:
   854  134e c956                                   cmp #$56                                    ; so you want to swim right?
   855  1350 d011                                   bne check_item_shovel                       ; nah, not this time -> check_item_shovel
   856  1352 ac9138                                 ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
   857  1355 d007               +                   bne +
   858  1357 209635                                 jsr get_player_pos                          ; tube equipped and ready to submerge
   859  135a a90c                                   lda #$0c
   860  135c d0e5                                   bne --                                      ; see you on the other side!
   861                          
   862  135e a002               +                   ldy #$02                                    ; breathing what?
   863  1360 4ce33a                                 jmp death                                   ; 02 You drowned in the deep river
   864                          
   865                          
   866                          check_item_shovel:
   867  1363 c9c1                                   cmp #$c1                                    ; wanna have that shovel?
   868  1365 f004                                   beq +                                       ; yup
   869  1367 c9c3                                   cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
   870  1369 d008                                   bne ++                                      ; nah still not interested -> ++
   871  136b a9df               +                   lda #$df                                    ; alright cool,
   872  136d 8dac36                                 sta items + $96                             ; shovel is yours now
   873  1370 4ccf11             --                  jmp check_death
   874                          
   875                          
   876  1373 c9ca               ++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
   877  1375 f003                                   beq +                                       ; yup
   878  1377 4ce511                                 jmp check_next_char_under_player
   879  137a add136             +                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
   880  137d c9df                                   cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
   881  137f d0ca                                   bne -                                       ; what hammer?
   882  1381 a9df                                   lda #$df
   883  1383 8d9a36                                 sta items + $84                             ; these fine boots are yours now, sir
   884  1386 d0e8                                   bne --
   885                          
   886                          
   887                          
   888                          
   889                          
   890                          
   891                          ; ==============================================================================
   892                          ;
   893                          ;                                                             ###       #####
   894                          ;          #####      ####      ####     #    #              #   #     #     #
   895                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   896                          ;          #    #    #    #    #    #    # ## #             #     #     ######
   897                          ;          #####     #    #    #    #    #    #             #     #          #
   898                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   899                          ;          #    #     ####      ####     #    #               ###       #####
   900                          ;
   901                          ; ==============================================================================
   902                          
   903                          room_09:            
   904                          
   905  1388 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   906  138a 9003                                   bcc +                                       ; yes -> +
   907  138c 4ce511                                 jmp check_next_char_under_player            ; continue checking
   908  138f a002               +                   ldy #$02                                    ; display hint
   909  1391 4c2c10                                 jmp prep_and_display_hint
   910                          
   911                          
   912                          
   913                          
   914                          
   915                          
   916                          ; ==============================================================================
   917                          ;
   918                          ;                                                             #        ###
   919                          ;          #####      ####      ####     #    #              ##       #   #
   920                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
   921                          ;          #    #    #    #    #    #    # ## #               #      #     #
   922                          ;          #####     #    #    #    #    #    #               #      #     #
   923                          ;          #   #     #    #    #    #    #    #               #       #   #
   924                          ;          #    #     ####      ####     #    #             #####      ###
   925                          ;
   926                          ; ==============================================================================
   927                          
   928                          room_10:
   929                          
   930  1394 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   931  1396 b005                                   bcs +
   932  1398 a000                                   ldy #$00                                    ; display hint
   933  139a 4c2c10                                 jmp prep_and_display_hint
   934                          
   935  139d c9cc               +                   cmp #$cc                                    ; hit the power outlet?
   936  139f f007                                   beq +                                       ; yes -> +
   937  13a1 c9cf                                   cmp #$cf                                    ; hit the power outlet?
   938  13a3 f003                                   beq +                                       ; yes -> +
   939  13a5 4ce511                                 jmp check_next_char_under_player            ; no, continue
   940  13a8 a9df               +                   lda #$df                                    
   941  13aa cd8a36                                 cmp items + $74                             ; light picked up?
   942  13ad d010                                   bne +                                       ; no -> death
   943  13af cdde36                                 cmp items + $c8                             ; yes, lightbulb picked up?
   944  13b2 d00b                                   bne +                                       ; no -> death
   945  13b4 8dc236                                 sta items + $ac                             ; yes, pick up power outlet
   946  13b7 a959                                   lda #$59                                    ; and make the foot traps visible
   947  13b9 8d4237                                 sta items + $12c                            ; color position for foot traps
   948  13bc 4ccf11                                 jmp check_death
   949                          
   950  13bf a006               +                   ldy #$06
   951  13c1 4ce33a                                 jmp death                                   ; 06 240 Volts! You got an electrical shock!
   952                          
   953                          
   954                          
   955                          
   956                          
   957                          
   958                          ; ==============================================================================
   959                          ;
   960                          ;                                                             #        #
   961                          ;          #####      ####      ####     #    #              ##       ##
   962                          ;          #    #    #    #    #    #    ##  ##             # #      # #
   963                          ;          #    #    #    #    #    #    # ## #               #        #
   964                          ;          #####     #    #    #    #    #    #               #        #
   965                          ;          #   #     #    #    #    #    #    #               #        #
   966                          ;          #    #     ####      ####     #    #             #####    #####
   967                          ;
   968                          ; ==============================================================================
   969                          
   970                          room_11:
   971                          
   972  13c4 c9d1                                   cmp #$d1                                    ; picking up the hammer?
   973  13c6 f003                                   beq +                                       ; jep
   974  13c8 4ce511                                 jmp check_next_char_under_player            ; no, continue
   975  13cb a9df               +                   lda #$df                                    ; player takes the hammer
   976  13cd 8dd136                                 sta items + $bb                             ; hammer
   977  13d0 4ccf11                                 jmp check_death
   978                          
   979                          
   980                          
   981                          
   982                          
   983                          
   984                          ; ==============================================================================
   985                          ;
   986                          ;                                                             #       #####
   987                          ;          #####      ####      ####     #    #              ##      #     #
   988                          ;          #    #    #    #    #    #    ##  ##             # #            #
   989                          ;          #    #    #    #    #    #    # ## #               #       #####
   990                          ;          #####     #    #    #    #    #    #               #      #
   991                          ;          #   #     #    #    #    #    #    #               #      #
   992                          ;          #    #     ####      ####     #    #             #####    #######
   993                          ;
   994                          ; ==============================================================================
   995                          
   996                          room_12:
   997                          
   998  13d3 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   999  13d5 b005                                   bcs +                                       ; no
  1000  13d7 a000                                   ldy #$00                                    
  1001  13d9 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1002                          
  1003  13dc c9d2               +                   cmp #$d2                                    ; light bulb hit?
  1004  13de f007                                   beq +                                       ; yes
  1005  13e0 c9d5                                   cmp #$d5                                    ; light bulb hit?
  1006  13e2 f003                                   beq +                                       ; yes
  1007  13e4 4ce511                                 jmp check_next_char_under_player            ; no, continue
  1008  13e7 a9df               +                   lda #$df                                    ; pick up light bulb
  1009  13e9 8dde36                                 sta items + $c8
  1010  13ec 4ccf11                                 jmp check_death
  1011                          
  1012                          
  1013                          
  1014                          
  1015                          
  1016                          
  1017                          ; ==============================================================================
  1018                          ;
  1019                          ;                                                             #       #####
  1020                          ;          #####      ####      ####     #    #              ##      #     #
  1021                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1022                          ;          #    #    #    #    #    #    # ## #               #       #####
  1023                          ;          #####     #    #    #    #    #    #               #            #
  1024                          ;          #   #     #    #    #    #    #    #               #      #     #
  1025                          ;          #    #     ####      ####     #    #             #####     #####
  1026                          ;
  1027                          ; ==============================================================================
  1028                          
  1029                          room_13:           
  1030                          
  1031  13ef c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1032  13f1 b005                                   bcs +
  1033  13f3 a000                                   ldy #$00                                    ; message 0 to display
  1034  13f5 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1035                          
  1036  13f8 c9d6               +                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
  1037  13fa f003                                   beq +                                       ; OUCH!! -> +
  1038  13fc 4ce511                                 jmp check_next_char_under_player            ; not stepped into a nail... yet.
  1039  13ff ad9a36             +                   lda items + $84                             ; are the boots taken?
  1040  1402 c9df                                   cmp #$df                                
  1041  1404 f005                                   beq +                                       ; yeah I'm cool these boots are made for nailin'. 
  1042  1406 a007                                   ldy #$07                                    ; death by a thousand nails.
  1043  1408 4ce33a                                 jmp death                                   ; 07 You stepped on a nail!
  1044                          
  1045                          +
  1046  140b a9e2                                   lda #$e2                                    ; this is also a nail. 
  1047  140d 8deb36                                 sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
  1048  1410 4ccf11                                 jmp check_death
  1049                          
  1050                          
  1051                          
  1052                          
  1053                          
  1054                          
  1055                          ; ==============================================================================
  1056                          ;
  1057                          ;                                                             #      #
  1058                          ;          #####      ####      ####     #    #              ##      #    #
  1059                          ;          #    #    #    #    #    #    ##  ##             # #      #    #
  1060                          ;          #    #    #    #    #    #    # ## #               #      #    #
  1061                          ;          #####     #    #    #    #    #    #               #      #######
  1062                          ;          #   #     #    #    #    #    #    #               #           #
  1063                          ;          #    #     ####      ####     #    #             #####         #
  1064                          ;
  1065                          ; ==============================================================================
  1066                          
  1067                          room_14:
  1068                          
  1069  1413 c9d7                                   cmp #$d7                                    ; foot trap char
  1070  1415 f003                                   beq +                                       ; stepped into it?
  1071  1417 4ce511                                 jmp check_next_char_under_player            ; not... yet...
  1072  141a a008               +                   ldy #$08                                    ; go die
  1073  141c 4ce33a                                 jmp death                                   ; 08 A foot trap stopped you!
  1074                          
  1075                          
  1076                          
  1077                          
  1078                          
  1079                          
  1080                          ; ==============================================================================
  1081                          ;
  1082                          ;                                                             #      #######
  1083                          ;          #####      ####      ####     #    #              ##      #
  1084                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1085                          ;          #    #    #    #    #    #    # ## #               #      ######
  1086                          ;          #####     #    #    #    #    #    #               #            #
  1087                          ;          #   #     #    #    #    #    #    #               #      #     #
  1088                          ;          #    #     ####      ####     #    #             #####     #####
  1089                          ;
  1090                          ; ==============================================================================
  1091                          
  1092                          room_15:
  1093                          
  1094  141f c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1095  1421 b005                                   bcs +
  1096  1423 a000                                   ldy #$00                                    ; display hint
  1097  1425 4c2c10                                 jmp prep_and_display_hint
  1098                          
  1099  1428 4ce511             +                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address
  1100                          
  1101                          
  1102                          
  1103                          
  1104                          
  1105                          
  1106                          ; ==============================================================================
  1107                          ;
  1108                          ;                                                             #       #####
  1109                          ;          #####      ####      ####     #    #              ##      #     #
  1110                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1111                          ;          #    #    #    #    #    #    # ## #               #      ######
  1112                          ;          #####     #    #    #    #    #    #               #      #     #
  1113                          ;          #   #     #    #    #    #    #    #               #      #     #
  1114                          ;          #    #     ####      ####     #    #             #####     #####
  1115                          ;
  1116                          ; ==============================================================================
  1117                          
  1118                          room_16:
  1119                          
  1120  142b c9f4                                   cmp #$f4                                    ; did you hit the wall in the left cell?
  1121  142d d005                                   bne +                                       ; I did not! -> +
  1122  142f a00a                                   ldy #$0a                                    ; yeah....
  1123  1431 4ce33a                                 jmp death                                   ; 0a You were locked in and starved!
  1124                          
  1125  1434 c9d9               +                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
  1126  1436 f004                                   beq +                                       ; not that I know of...
  1127  1438 c9db                                   cmp #$db                                    ; are you sure? take a look at this slightly different wall
  1128  143a d005                                   bne ++                                      ; it doesn't look familiar... -> ++
  1129                          
  1130  143c a009               +                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
  1131  143e 4ce33a                                 jmp death
  1132                          
  1133  1441 c9b9               ++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
  1134  1443 f007                                   beq +                                       ; yes! -> +
  1135  1445 c9bb                                   cmp #$bb                                    ; here's another part of that bottle for reference
  1136  1447 f003                                   beq +                                       ; yes! -> +
  1137  1449 4ce511                                 jmp check_next_char_under_player            ; no, continue
  1138  144c a003               +                   ldy #$03                                    ; display code enter screen
  1139  144e 4c2c10                                 jmp prep_and_display_hint
  1140                          
  1141                          
  1142                          
  1143                          
  1144                          
  1145                          
  1146                          ; ==============================================================================
  1147                          ;
  1148                          ;                                                             #      #######
  1149                          ;          #####      ####      ####     #    #              ##      #    #
  1150                          ;          #    #    #    #    #    #    ##  ##             # #          #
  1151                          ;          #    #    #    #    #    #    # ## #               #         #
  1152                          ;          #####     #    #    #    #    #    #               #        #
  1153                          ;          #   #     #    #    #    #    #    #               #        #
  1154                          ;          #    #     ####      ####     #    #             #####      #
  1155                          ;
  1156                          ; ==============================================================================
  1157                          
  1158                          room_17:
  1159                          
  1160  1451 c9dd                                   cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
  1161  1453 f003                                   beq +                                       ; yup
  1162  1455 4ce511                                 jmp check_next_char_under_player            ; nah not yet.
  1163  1458 a9df               +                   lda #$df                                    ; pick up sword
  1164  145a 8dbd37                                 sta items + $1a7                            ; store in items list
  1165  145d 4ccf11                                 jmp check_death
  1166                          
  1167                          
  1168                          
  1169                          
  1170                          
  1171                          
  1172                          ; ==============================================================================
  1173                          ;
  1174                          ;                                                             #       #####
  1175                          ;          #####      ####      ####     #    #              ##      #     #
  1176                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
  1177                          ;          #    #    #    #    #    #    # ## #               #       #####
  1178                          ;          #####     #    #    #    #    #    #               #      #     #
  1179                          ;          #   #     #    #    #    #    #    #               #      #     #
  1180                          ;          #    #     ####      ####     #    #             #####     #####
  1181                          ;
  1182                          ; ==============================================================================
  1183                          
  1184                          room_18:
  1185  1460 c981                                   cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
  1186  1462 b003                                   bcs +                   
  1187  1464 4ccf11                                 jmp check_death
  1188                          
  1189  1467 ad9a12             +                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
  1190  146a d003                                   bne +                                       ; yes I actually did (flexes arms)
  1191  146c 4cd53a                                 jmp main_loop                               ; nope
  1192  146f 20263a             +                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
  1193  1472 4c3a1b                                 jmp print_endscreen                         ; (drops mic)
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
  1233                          
  1234                          
  1235                          ; ==============================================================================
  1236                          ; 
  1237                          ; EVERYTHING ANIMATION RELATED STARTS HERE
  1238                          ; ANIMATIONS FOR
  1239                          ; LASER, BORIS, BELEGRO, STONE, MONSTER
  1240                          ; ==============================================================================
  1241                          
  1242                          ; TODO
  1243                          ; this gets called all the time, no checks 
  1244                          ; needs to be optimized
  1245                          
  1246                          
  1247                          animation_entrypoint:
  1248                                              
  1249                                              ; code below is used to check if the foot traps should be visible
  1250                                              ; it checked for this every single fucking frame
  1251                                              ; moved the foot traps coloring where it belongs (when picking up power outlet)
  1252                                              ;lda items + $ac                         ; $cc (power outlet)
  1253                                              ;cmp #$df                                ; taken?
  1254                                              ;bne +                                   ; no -> +
  1255                                              ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
  1256                                              ;sta items + $12c                        ; originally $0
  1257                          
  1258  1475 acf82f             +                   ldy current_room + 1                    ; load room number
  1259                          
  1260  1478 c011                                   cpy #$11                                ; is it room #17? (Belegro)
  1261  147a d046                                   bne room_14_prep                         ; no -> m162A
  1262                                              
  1263                                              
  1264  147c ad1115                                 lda m14CC + 1                           ; yes, get value from m14CD
  1265  147f d013                                   bne m15FC                               ; 0? -> m15FC
  1266  1481 ad4035                                 lda player_pos_y + 1                    ; not 0, get player pos Y
  1267  1484 c906                                   cmp #$06                                ; is it 6?
  1268  1486 d00c                                   bne m15FC                               ; no -> m15FC
  1269  1488 ad4235                                 lda player_pos_x + 1                    ; yes, get player pos X
  1270  148b c918                                   cmp #$18                                ; is player x position $18?
  1271  148d d005                                   bne m15FC                               ; no -> m15FC
  1272  148f a900                                   lda #$00                                ; yes, load 0
  1273  1491 8d9514                                 sta m15FC + 1                           ; store 0 in m15FC+1
  1274  1494 a901               m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
  1275  1496 d016                                   bne +                                   ; is it 0? -> +
  1276  1498 a006                                   ldy #$06                                ; y = $6
  1277  149a a21e               m1602:              ldx #$1e                                ; x = $1e
  1278  149c a900                                   lda #$00                                ; a = $0
  1279  149e 85a7                                   sta zpA7                                ; zpA7 = 0
  1280  14a0 20c734                                 jsr draw_player                         ; TODO
  1281  14a3 ae9b14                                 ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
  1282  14a6 e003                                   cpx #$03                                ; is X = $3?
  1283  14a8 f001                                   beq ++                                  ; yes -> ++
  1284  14aa ca                                     dex                                     ; x = x -1
  1285  14ab 8e9b14             ++                  stx m1602 + 1                           ; store x in m1602+1
  1286  14ae a978               +                   lda #$78                                ; a = $78
  1287  14b0 85a8                                   sta zpA8                                ; zpA8 = $78
  1288  14b2 a949                                   lda #$49                                ; a = $49
  1289  14b4 850a                                   sta zp0A                                ; zp0A = $49
  1290  14b6 a006                                   ldy #$06                                ; y = $06
  1291  14b8 a901                                   lda #$01                                ; a = $01
  1292  14ba 85a7                                   sta zpA7                                ; zpA7 = $01
  1293  14bc ae9b14                                 ldx m1602 + 1                           ; get stored x value (should still be the same?)
  1294  14bf 20c734                                 jsr draw_player                         ; TODO
  1295                          
  1296                          
  1297                          room_14_prep:              
  1298  14c2 acf82f                                 ldy current_room + 1                    ; load room number
  1299  14c5 c00e                                   cpy #14                                 ; is it #14?
  1300  14c7 d005                                   bne room_15_prep                        ; no -> m148A
  1301  14c9 a020                                   ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
  1302  14cb 20ff39                                 jsr wait                                ; was jmp wait before
  1303                          
  1304                          ; ==============================================================================
  1305                          ; ROOM 15 ANIMATION
  1306                          ; MOVEMENT OF THE MONSTER
  1307                          ; ==============================================================================
  1308                          
  1309                          room_15_prep:              
  1310  14ce c00f                                   cpy #15                                 ; room 15?
  1311  14d0 d03a                                   bne room_17_prep                        ; no -> m14C8
  1312  14d2 a900                                   lda #$00                                ; 
  1313  14d4 85a7                                   sta zpA7
  1314  14d6 a00c                                   ldy #$0c                                ; x/y pos of the monster
  1315  14d8 a206               m1494:              ldx #$06
  1316  14da 20c734                                 jsr draw_player
  1317  14dd a9eb                                   lda #$eb                                ; the monster (try 9c for Belegro)
  1318  14df 85a8                                   sta zpA8
  1319  14e1 a939                                   lda #$39                                ; color of the monster's cape
  1320  14e3 850a                                   sta zp0A
  1321  14e5 aed914                                 ldx m1494 + 1                           ; self mod the x position of the monster
  1322  14e8 a901               m14A4:              lda #$01
  1323  14ea d00a                                   bne m14B2               
  1324  14ec e006                                   cpx #$06                                ; moved 6 steps?
  1325  14ee d002                                   bne +                                   ; no, keep moving
  1326  14f0 a901                                   lda #$01
  1327  14f2 ca                 +                   dex
  1328  14f3 4cfd14                                 jmp +                                   ; change direction
  1329                          
  1330                          m14B2:              
  1331  14f6 e00b                                   cpx #$0b
  1332  14f8 d002                                   bne ++
  1333  14fa a900                                   lda #$00
  1334  14fc e8                 ++                  inx
  1335  14fd 8ed914             +                   stx m1494 + 1
  1336  1500 8de914                                 sta m14A4 + 1
  1337  1503 a901                                   lda #$01
  1338  1505 85a7                                   sta zpA7
  1339  1507 a00c                                   ldy #$0c
  1340  1509 4cc734                                 jmp draw_player
  1341                                             
  1342                          ; ==============================================================================
  1343                          ; ROOM 17 ANIMATION
  1344                          ;
  1345                          ; ==============================================================================
  1346                          
  1347                          room_17_prep:              
  1348  150c c011                                   cpy #17                             ; room number 17?
  1349  150e d014                                   bne +                               ; no -> +
  1350  1510 a901               m14CC:              lda #$01                            ; selfmod
  1351  1512 f021                                   beq ++                              
  1352                                                                                 
  1353                                              ; was moved here
  1354                                              ; as it was called only from this place
  1355                                              ; jmp m15C1  
  1356  1514 a900               m15C1:              lda #$00                            ; a = 0 (selfmod)
  1357  1516 c900                                   cmp #$00                            ; is a = 0?
  1358  1518 d004                                   bne skipper                         ; not 0 -> 15CB
  1359  151a ee1515                                 inc m15C1 + 1                       ; inc m15C1
  1360  151d 60                                     rts
  1361                                       
  1362  151e ce1515             skipper:            dec m15C1 + 1                       ; dec $15c2
  1363  1521 4cb335                                 jmp belegro_animation
  1364                          
  1365  1524 a90f               +                   lda #$0f                            ; a = $0f
  1366  1526 8db835                                 sta m3624 + 1                       ; selfmod
  1367  1529 8dba35                                 sta m3626 + 1                       ; selfmod
  1368                          
  1369                          
  1370  152c c00a                                   cpy #10                             ; room number 10?
  1371  152e d044                                   bne check_if_room_09                ; no -> m1523
  1372  1530 ceb82f                                 dec speed_byte                      ; yes, reduce speed
  1373  1533 f001                                   beq laser_beam_animation            ; if positive -> laser_beam_animation            
  1374  1535 60                 ++                  rts
  1375                          
  1376                          ; ==============================================================================
  1377                          ; ROOM 10
  1378                          ; LASER BEAM ANIMATION
  1379                          ; ==============================================================================
  1380                          
  1381                          laser_beam_animation:
  1382                          
  1383  1536 a008                                   ldy #$08                            ; speed of the laser flashing
  1384  1538 8cb82f                                 sty speed_byte                      ; store     
  1385  153b a909                                   lda #$09
  1386  153d 8505                                   sta zp05                            ; affects the colram of the laser
  1387  153f a90d                                   lda #$0d                            ; but not understood yet
  1388  1541 8503                                   sta zp03
  1389  1543 a97b                                   lda #$7b                            ; position of the laser
  1390  1545 8502                                   sta zp02
  1391  1547 8504                                   sta zp04
  1392  1549 a9df                                   lda #$df                            ; laser beam off
  1393  154b cd5815                                 cmp m1506 + 1                       
  1394  154e d002                                   bne +                               
  1395  1550 a9d8                                   lda #$d8                            ; laser beam
  1396  1552 8d5815             +                   sta m1506 + 1                       
  1397  1555 a206                                   ldx #$06                            ; 6 laser beam characters
  1398  1557 a9df               m1506:              lda #$df
  1399  1559 a000                                   ldy #$00
  1400  155b 9102                                   sta (zp02),y
  1401  155d a9ee                                   lda #$ee
  1402  155f 9104                                   sta (zp04),y
  1403  1561 a502                                   lda zp02
  1404  1563 18                                     clc
  1405  1564 6928                                   adc #$28                            ; draws the laser beam
  1406  1566 8502                                   sta zp02
  1407  1568 8504                                   sta zp04
  1408  156a 9004                                   bcc +                               
  1409  156c e603                                   inc zp03
  1410  156e e605                                   inc zp05
  1411  1570 ca                 +                   dex
  1412  1571 d0e4                                   bne m1506                           
  1413  1573 60                 -                   rts
  1414                          
  1415                          ; ==============================================================================
  1416                          
  1417                          check_if_room_09:              
  1418  1574 c009                                   cpy #09                         ; room number 09?
  1419  1576 f001                                   beq room_09_counter                           ; yes -> +
  1420  1578 60                                     rts                             ; no
  1421                          
  1422                          room_09_counter:
  1423  1579 a201                                   ldx #$01                                ; x = 1 (selfmod)
  1424  157b e001                                   cpx #$01                                ; is x = 1?
  1425  157d f003                                   beq +                                   ; yes -> +
  1426  157f 4c9a15                                 jmp boris_the_spider_animation          ; no, jump boris animation
  1427  1582 ce7a15             +                   dec room_09_counter + 1                 ; decrease initial x
  1428  1585 60                                     rts
  1429                          
  1430                          ; ==============================================================================
  1431                          ;
  1432                          ; I moved this out of the main loop and call it once when changing rooms
  1433                          ; TODO: call it only when room 4 is entered
  1434                          ; ==============================================================================
  1435                          
  1436                          room_04_prep_door:
  1437                                              
  1438  1586 adf82f                                 lda current_room + 1                            ; get current room
  1439  1589 c904                                   cmp #04                                         ; is it 4? (coffins)
  1440  158b d00c                                   bne ++                                          ; nope
  1441  158d a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  1442  158f ac0339                                 ldy m394A + 1                                   ; 
  1443  1592 f002                                   beq +
  1444  1594 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  1445  1596 8df904             +                   sta SCREENRAM + $f9 
  1446  1599 60                 ++                  rts
  1447                          
  1448                          ; ==============================================================================
  1449                          ; ROOM 09
  1450                          ; BORIS THE SPIDER ANIMATION
  1451                          ; ==============================================================================
  1452                          
  1453                          boris_the_spider_animation:
  1454                          
  1455  159a ee7a15                                 inc room_09_counter + 1                           
  1456  159d a908                                   lda #$08                                ; affects the color ram position for boris the spider
  1457  159f 8505                                   sta zp05
  1458  15a1 a90c                                   lda #$0c
  1459  15a3 8503                                   sta zp03
  1460  15a5 a90f                                   lda #$0f
  1461  15a7 8502                                   sta zp02
  1462  15a9 8504                                   sta zp04
  1463  15ab a206               m1535:              ldx #$06
  1464  15ad a900               m1537:              lda #$00
  1465  15af d009                                   bne +
  1466  15b1 ca                                     dex
  1467  15b2 e002                                   cpx #$02
  1468  15b4 d00b                                   bne ++
  1469  15b6 a901                                   lda #$01
  1470  15b8 d007                                   bne ++
  1471  15ba e8                 +                   inx
  1472  15bb e007                                   cpx #$07
  1473  15bd d002                                   bne ++
  1474  15bf a900                                   lda #$00
  1475  15c1 8dae15             ++                  sta m1537 + 1
  1476  15c4 8eac15                                 stx m1535 + 1
  1477  15c7 a000               -                   ldy #$00
  1478  15c9 a9df                                   lda #$df
  1479  15cb 9102                                   sta (zp02),y
  1480  15cd c8                                     iny
  1481  15ce c8                                     iny
  1482  15cf 9102                                   sta (zp02),y
  1483  15d1 88                                     dey
  1484  15d2 a9ea                                   lda #$ea
  1485  15d4 9102                                   sta (zp02),y
  1486  15d6 9104                                   sta (zp04),y
  1487  15d8 201316                                 jsr move_boris                       
  1488  15db ca                                     dex
  1489  15dc d0e9                                   bne -
  1490  15de a9e4                                   lda #$e4
  1491  15e0 85a8                                   sta zpA8
  1492  15e2 a202                                   ldx #$02
  1493  15e4 a000               --                  ldy #$00
  1494  15e6 a5a8               -                   lda zpA8
  1495  15e8 9102                                   sta (zp02),y
  1496  15ea a9da                                   lda #$da
  1497  15ec 9104                                   sta (zp04),y
  1498  15ee e6a8                                   inc zpA8
  1499  15f0 c8                                     iny
  1500  15f1 c003                                   cpy #$03
  1501  15f3 d0f1                                   bne -
  1502  15f5 201316                                 jsr move_boris                       
  1503  15f8 ca                                     dex
  1504  15f9 d0e9                                   bne --
  1505  15fb a000                                   ldy #$00
  1506  15fd a9e7                                   lda #$e7
  1507  15ff 85a8                                   sta zpA8
  1508  1601 b102               -                   lda (zp02),y
  1509  1603 c5a8                                   cmp zpA8
  1510  1605 d004                                   bne +
  1511  1607 a9df                                   lda #$df
  1512  1609 9102                                   sta (zp02),y
  1513  160b e6a8               +                   inc zpA8
  1514  160d c8                                     iny
  1515  160e c003                                   cpy #$03
  1516  1610 d0ef                                   bne -
  1517  1612 60                                     rts
  1518                          
  1519                          ; ==============================================================================
  1520                          
  1521                          move_boris:
  1522  1613 a502                                   lda zp02
  1523  1615 18                                     clc
  1524  1616 6928                                   adc #$28
  1525  1618 8502                                   sta zp02
  1526  161a 8504                                   sta zp04
  1527  161c 9004                                   bcc +                                   
  1528  161e e603                                   inc zp03
  1529  1620 e605                                   inc zp05
  1530  1622 60                 +                   rts
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
  1549                          
  1550                          
  1551                          ; ==============================================================================
  1552                          
  1553                          prep_player_pos:
  1554                          
  1555  1623 a209                                   ldx #$09
  1556  1625 bd4403             -                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
  1557  1628 9d5403                                 sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
  1558  162b ca                                     dex
  1559  162c d0f7                                   bne -                                   ; so this seems to create a copy of the area under the player
  1560                          
  1561  162e a902                                   lda #$02                                ; a = 2
  1562  1630 85a7                                   sta zpA7
  1563  1632 ae4235                                 ldx player_pos_x + 1                    ; x = player x
  1564  1635 ac4035                                 ldy player_pos_y + 1                    ; y = player y
  1565  1638 20c734                                 jsr draw_player                         ; draw player
  1566  163b 60                                     rts
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
  1586                          
  1587                          
  1588                          ; ==============================================================================
  1589                          ; OBJECT ANIMATION COLLISION ROUTINE
  1590                          ; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
  1591                          ; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
  1592                          ; ==============================================================================
  1593                          
  1594                          object_collision:
  1595                          
  1596  163c a209                                   ldx #$09                                ; x = 9
  1597                          
  1598                          check_loop:              
  1599                          
  1600  163e bd4403                                 lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1601  1641 c9d8                                   cmp #$d8                                ; check for laser beam
  1602  1643 d005                                   bne +                  
  1603                          
  1604  1645 a005               m164E:              ldy #$05
  1605  1647 4ce33a             jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?
  1606                          
  1607  164a acf82f             +                   ldy current_room + 1                    ; get room number
  1608  164d c011                                   cpy #17                                 ; is it $11 = #17 (Belegro)?
  1609  164f d010                                   bne +                                   ; nope -> +
  1610  1651 c978                                   cmp #$78                                ; hit by the stone?
  1611  1653 f008                                   beq ++                                  ; yep -> ++
  1612  1655 c97b                                   cmp #$7b                                ; or another part of the stone?
  1613  1657 f004                                   beq ++                                  ; yes -> ++
  1614  1659 c97e                                   cmp #$7e                                ; or another part of the stone?
  1615  165b d004                                   bne +                                   ; nah, -> +
  1616  165d a00b               ++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
  1617  165f d0e6                                   bne jmp_death
  1618  1661 c99c               +                   cmp #$9c                                ; so Belegro hit you?
  1619  1663 9007                                   bcc m1676
  1620  1665 c9a5                                   cmp #$a5
  1621  1667 b003                                   bcs m1676
  1622  1669 4c9d16                                 jmp m16A7
  1623                          
  1624  166c c9e4               m1676:              cmp #$e4                                ; hit by Boris the spider?
  1625  166e 9010                                   bcc +                           
  1626  1670 c9eb                                   cmp #$eb
  1627  1672 b004                                   bcs ++                          
  1628  1674 a004               -                   ldy #$04                                ; 04 Boris the spider got you and killed you
  1629  1676 d0cf                                   bne jmp_death                       
  1630  1678 c9f4               ++                  cmp #$f4
  1631  167a b004                                   bcs +                           
  1632  167c a00e                                   ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
  1633  167e d0c7                                   bne jmp_death                       
  1634  1680 ca                 +                   dex
  1635  1681 d0bb                                   bne check_loop   
  1636                          
  1637                          
  1638                          
  1639  1683 a209                                   ldx #$09
  1640  1685 bd5403             --                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
  1641  1688 9d4403                                 sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1642  168b c9d8                                   cmp #$d8
  1643  168d f0b6                                   beq m164E                       
  1644  168f c9e4                                   cmp #$e4
  1645  1691 9004                                   bcc +                           
  1646  1693 c9ea                                   cmp #$ea
  1647  1695 90dd                                   bcc -                           
  1648  1697 ca                 +                   dex
  1649  1698 d0eb                                   bne --                          
  1650  169a 4cd511                                 jmp m11E0                     
  1651                          
  1652                          m16A7:
  1653  169d acbd37                                 ldy items + $1a7                        ; do you have the sword?
  1654  16a0 c0df                                   cpy #$df
  1655  16a2 f004                                   beq +                                   ; yes -> +                        
  1656  16a4 a00c                                   ldy #$0c                                ; 0c Belegro killed you!
  1657  16a6 d09f                                   bne jmp_death                       
  1658  16a8 a000               +                   ldy #$00
  1659  16aa 8c1115                                 sty m14CC + 1                   
  1660  16ad 4c6c16                                 jmp m1676                       
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
  1696                          
  1697                          
  1698                          ; ==============================================================================
  1699                          ; this might be the inventory/ world reset
  1700                          ; puts all items into the level data again
  1701                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1702                          ; addresses are mostly within items.asm address space ( $368a )
  1703                          ; contains color information of the chars
  1704                          ; ==============================================================================
  1705                          
  1706                          reset_items:
  1707  16b0 a9a5                                   lda #$a5                        ; $a5 = lock of the shed
  1708  16b2 8d4e36                                 sta items + $38
  1709                          
  1710  16b5 a9a9                                   lda #$a9                        ;
  1711  16b7 8d1e36                                 sta items + $8                  ; gloves
  1712  16ba a979                                   lda #$79
  1713  16bc 8d1c36                                 sta items + $6                  ; gloves color
  1714                          
  1715  16bf a9e0                                   lda #$e0                        ; empty char
  1716  16c1 8d2636                                 sta items + $10                 ; invisible key
  1717                          
  1718  16c4 a9ac                                   lda #$ac                        ; wirecutter
  1719  16c6 8d2f36                                 sta items + $19
  1720                          
  1721  16c9 a9b8                                   lda #$b8                        ; bottle
  1722  16cb 8d3f36                                 sta items + $29
  1723                          
  1724  16ce a9b0                                   lda #$b0                        ; ladder
  1725  16d0 8d6336                                 sta items + $4d
  1726  16d3 a9b5                                   lda #$b5                        ; more ladder
  1727  16d5 8d6e36                                 sta items + $58
  1728                          
  1729  16d8 a95e                                   lda #$5e                        ; seems to be water?
  1730  16da 8d8a36                                 sta items + $74
  1731                          
  1732  16dd a9c6                                   lda #$c6                        ; boots in the whatever box
  1733  16df 8d9a36                                 sta items + $84
  1734                          
  1735  16e2 a9c0                                   lda #$c0                        ; shovel
  1736  16e4 8dac36                                 sta items + $96
  1737                          
  1738  16e7 a9cc                                   lda #$cc                        ; power outlet
  1739  16e9 8dc236                                 sta items + $ac
  1740                          
  1741  16ec a9d0                                   lda #$d0                        ; hammer
  1742  16ee 8dd136                                 sta items + $bb
  1743                          
  1744  16f1 a9d2                                   lda #$d2                        ; light bulb
  1745  16f3 8dde36                                 sta items + $c8
  1746                          
  1747  16f6 a9d6                                   lda #$d6                        ; nails
  1748  16f8 8deb36                                 sta items + $d5
  1749                          
  1750  16fb a900                                   lda #$00                        ; door
  1751  16fd 8d4237                                 sta items + $12c
  1752                          
  1753  1700 a9dd                                   lda #$dd                        ; sword
  1754  1702 8dbd37                                 sta items + $1a7
  1755                          
  1756  1705 a901                                   lda #$01                        ; -> wrong write, produced selfmod at the wrong place
  1757  1707 8d0339                                 sta m394A + 1                   ; sta items + $2c1
  1758                          
  1759  170a a901                                   lda #$01                        ; 
  1760  170c 8d9138                                 sta breathing_tube_mod + 1      ; sta items + $30a
  1761                          
  1762  170f a9f5                                   lda #$f5                        ; fence
  1763  1711 8db538                                 sta delete_fence + 1            ; sta items + $277
  1764                          
  1765  1714 a900                                   lda #$00                        ; key in the bottle
  1766  1716 8d9a12                                 sta key_in_bottle_storage
  1767                          
  1768  1719 a901                                   lda #$01                        ; door
  1769  171b 8d9514                                 sta m15FC + 1
  1770                          
  1771  171e a91e                                   lda #$1e
  1772  1720 8d9b14                                 sta m1602 + 1
  1773                          
  1774  1723 a901                                   lda #$01
  1775  1725 8d1115                                 sta m14CC + 1
  1776                          
  1777  1728 a205               m1732:              ldx #$05
  1778  172a e007                                   cpx #$07
  1779  172c d002                                   bne +
  1780  172e a2ff                                   ldx #$ff
  1781  1730 e8                 +                   inx
  1782  1731 8e2917                                 stx m1732 + 1                           ; stx $1733
  1783  1734 bd3d17                                 lda m1747,x                             ; lda $1747,x
  1784  1737 8d0b39                                 sta m3952 + 1                   ; sta $3953
  1785  173a 4cb030                                 jmp print_title     ; jmp $310d
  1786                                              
  1787                          ; ==============================================================================
  1788                          
  1789                          m1747:
  1790  173d 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1791                          
  1792                          
  1793                          m174F:
  1794  1745 e00c                                   cpx #$0c
  1795  1747 d002                                   bne +
  1796  1749 a949                                   lda #$49
  1797  174b e00d               +                   cpx #$0d
  1798  174d d002                                   bne +
  1799  174f a945                                   lda #$45
  1800  1751 60                 +                   rts
  1801                          
  1802                          
  1803                          
  1804                          screen_win_src:
  1805                                              !if LANGUAGE = EN{
  1806  1752 7040404040404040...                        !bin "includes/screen-win-en.scr"
  1807                                              }
  1808                                              !if LANGUAGE = DE{
  1809                                                  !bin "includes/screen-win-de.scr"
  1810                                              }
  1811                          screen_win_src_end:
  1812                          
  1813                          
  1814                          ; ==============================================================================
  1815                          ;
  1816                          ; PRINT WIN SCREEN
  1817                          ; ==============================================================================
  1818                          
  1819                          print_endscreen:
  1820  1b3a a904                                   lda #>SCREENRAM
  1821  1b3c 8503                                   sta zp03
  1822  1b3e a9d8                                   lda #>COLRAM
  1823  1b40 8505                                   sta zp05
  1824  1b42 a900                                   lda #<SCREENRAM
  1825  1b44 8502                                   sta zp02
  1826  1b46 8504                                   sta zp04
  1827  1b48 a204                                   ldx #$04
  1828  1b4a a917                                   lda #>screen_win_src
  1829  1b4c 85a8                                   sta zpA8
  1830  1b4e a952                                   lda #<screen_win_src
  1831  1b50 85a7                                   sta zpA7
  1832  1b52 a000                                   ldy #$00
  1833  1b54 b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1834  1b56 9102                                   sta (zp02),y        ; to SCREEN
  1835  1b58 a900                                   lda #$00            ; color = BLACK
  1836  1b5a 9104                                   sta (zp04),y        ; to COLRAM
  1837  1b5c c8                                     iny
  1838  1b5d d0f5                                   bne -
  1839  1b5f e603                                   inc zp03
  1840  1b61 e605                                   inc zp05
  1841  1b63 e6a8                                   inc zpA8
  1842  1b65 ca                                     dex
  1843  1b66 d0ec                                   bne -
  1844  1b68 a907                                   lda #$07                  ; yellow
  1845  1b6a 8d21d0                                 sta BG_COLOR              ; background
  1846  1b6d 8d20d0                                 sta BORDER_COLOR          ; und border
  1847  1b70 a9fd               -                   lda #$fd
  1848  1b72 8d08ff                                 sta KEYBOARD_LATCH
  1849  1b75 ad08ff                                 lda KEYBOARD_LATCH
  1850  1b78 2980                                   and #$80           ; WAITKEY?
  1851  1b7a d0f4                                   bne -
  1852  1b7c 20b030                                 jsr print_title
  1853  1b7f 20b030                                 jsr print_title
  1854  1b82 4c423a                                 jmp init
  1855                          
  1856                          
  1857                          ; ==============================================================================
  1858                          ;
  1859                          ; INTRO TEXT SCREEN
  1860                          ; ==============================================================================
  1861                          
  1862                          intro_text:
  1863                          
  1864                          ; instructions screen
  1865                          ; "Search the treasure..."
  1866                          
  1867                          !if LANGUAGE = EN{
  1868  1b85 5305011203082014...!scr "Search the treasure of Ghost Town and   "
  1869  1bad 0f10050e20091420...!scr "open it ! Kill Belegro, the wizard, and "
  1870  1bd5 040f04070520010c...!scr "dodge all other dangers. Don't forget to"
  1871  1bfd 15130520010c0c20...!scr "use all the items you'll find during    "
  1872  1c25 190f1512200a0f15...!scr "your journey through 19 amazing hires-  "
  1873  1c4d 0712011008090313...!scr "graphics-rooms! Enjoy the quest and play"
  1874  1c75 091420010701090e...!scr "it again and again and again ...      > "
  1875                          }
  1876                          
  1877                          !if LANGUAGE = DE{
  1878                          !scr "Suchen Sie die Schatztruhe der Geister- "
  1879                          !scr "stadt und oeffnen Sie diese ! Toeten    "
  1880                          !scr "Sie Belegro, den Zauberer und weichen   "
  1881                          !scr "Sie vielen anderen Wesen geschickt aus. "
  1882                          !scr "Bedienen Sie sich an den vielen Gegen-  "
  1883                          !scr "staenden, welche sich in den 19 Bildern "
  1884                          !scr "befinden. Viel Spass !                > "
  1885                          }
  1886                          
  1887                          ; ==============================================================================
  1888                          ;
  1889                          ; DISPLAY INTRO TEXT
  1890                          ; ==============================================================================
  1891                          
  1892                          display_intro_text:
  1893                          
  1894                                              ; i think this part displays the introduction text
  1895                          
  1896  1c9d a904                                   lda #>SCREENRAM       ; lda #$0c
  1897  1c9f 8503                                   sta zp03
  1898  1ca1 a9d8                                   lda #>COLRAM        ; lda #$08
  1899  1ca3 8505                                   sta zp05
  1900  1ca5 a9a0                                   lda #$a0
  1901  1ca7 8502                                   sta zp02
  1902  1ca9 8504                                   sta zp04
  1903  1cab a91b                                   lda #>intro_text
  1904  1cad 85a8                                   sta zpA8
  1905  1caf a985                                   lda #<intro_text
  1906  1cb1 85a7                                   sta zpA7
  1907  1cb3 a207                                   ldx #$07
  1908  1cb5 a000               --                  ldy #$00
  1909  1cb7 b1a7               -                   lda (zpA7),y
  1910  1cb9 9102                                   sta (zp02),y
  1911  1cbb a968                                   lda #$68
  1912  1cbd 9104                                   sta (zp04),y
  1913  1cbf c8                                     iny
  1914  1cc0 c028                                   cpy #$28
  1915  1cc2 d0f3                                   bne -
  1916  1cc4 a5a7                                   lda zpA7
  1917  1cc6 18                                     clc
  1918  1cc7 6928                                   adc #$28
  1919  1cc9 85a7                                   sta zpA7
  1920  1ccb 9002                                   bcc +
  1921  1ccd e6a8                                   inc zpA8
  1922  1ccf a502               +                   lda zp02
  1923  1cd1 18                                     clc
  1924  1cd2 6950                                   adc #$50
  1925  1cd4 8502                                   sta zp02
  1926  1cd6 8504                                   sta zp04
  1927  1cd8 9004                                   bcc +
  1928  1cda e603                                   inc zp03
  1929  1cdc e605                                   inc zp05
  1930  1cde ca                 +                   dex
  1931  1cdf d0d4                                   bne --
  1932  1ce1 a900                                   lda #$00
  1933  1ce3 8d21d0                                 sta BG_COLOR
  1934  1ce6 60                                     rts
  1935                          
  1936                          ; ==============================================================================
  1937                          ;
  1938                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1939                          ; DECREASES MUSIC VOLUME
  1940                          ; ==============================================================================
  1941                          
  1942                          start_intro:        ;sta KEYBOARD_LATCH
  1943  1ce7 203f3b                                 jsr clear                                   ; jsr PRINT_KERNAL
  1944  1cea 209d1c                                 jsr display_intro_text
  1945  1ced 20c91e                                 jsr check_shift_key
  1946                                              
  1947                                              ;lda #$ba
  1948                                              ;sta music_volume+1                          ; sound volume
  1949  1cf0 60                                     rts
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
  1982                          
  1983                          
  1984                          ; ==============================================================================
  1985                          ; MUSIC
  1986                          ; ==============================================================================
  1987                                              !zone MUSIC

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
  1989                          ; ==============================================================================
  1990                          music_get_data:
  1991  1daf a000               .voice1_dur_pt:     ldy #$00
  1992  1db1 d01d                                   bne +
  1993  1db3 a940                                   lda #$40
  1994  1db5 8d161e                                 sta music_voice1+1
  1995  1db8 20151e                                 jsr music_voice1
  1996  1dbb a200               .voice1_dat_pt:     ldx #$00
  1997  1dbd bdf11c                                 lda music_data_voice1,x
  1998  1dc0 eebc1d                                 inc .voice1_dat_pt+1
  1999  1dc3 a8                                     tay
  2000  1dc4 291f                                   and #$1f
  2001  1dc6 8d161e                                 sta music_voice1+1
  2002  1dc9 98                                     tya
  2003  1dca 4a                                     lsr
  2004  1dcb 4a                                     lsr
  2005  1dcc 4a                                     lsr
  2006  1dcd 4a                                     lsr
  2007  1dce 4a                                     lsr
  2008  1dcf a8                                     tay
  2009  1dd0 88                 +                   dey
  2010  1dd1 8cb01d                                 sty .voice1_dur_pt + 1
  2011  1dd4 a000               .voice2_dur_pt:     ldy #$00
  2012  1dd6 d022                                   bne +
  2013  1dd8 a940                                   lda #$40
  2014  1dda 8d3e1e                                 sta music_voice2 + 1
  2015  1ddd 203d1e                                 jsr music_voice2
  2016  1de0 a200               .voice2_dat_pt:     ldx #$00
  2017  1de2 bd4b1d                                 lda music_data_voice2,x
  2018  1de5 a8                                     tay
  2019  1de6 e8                                     inx
  2020  1de7 e065                                   cpx #$65
  2021  1de9 f019                                   beq music_reset
  2022  1deb 8ee11d                                 stx .voice2_dat_pt + 1
  2023  1dee 291f                                   and #$1f
  2024  1df0 8d3e1e                                 sta music_voice2 + 1
  2025  1df3 98                                     tya
  2026  1df4 4a                                     lsr
  2027  1df5 4a                                     lsr
  2028  1df6 4a                                     lsr
  2029  1df7 4a                                     lsr
  2030  1df8 4a                                     lsr
  2031  1df9 a8                                     tay
  2032  1dfa 88                 +                   dey
  2033  1dfb 8cd51d                                 sty .voice2_dur_pt + 1
  2034  1dfe 20151e                                 jsr music_voice1
  2035  1e01 4c3d1e                                 jmp music_voice2
  2036                          ; ==============================================================================
  2037  1e04 a900               music_reset:        lda #$00
  2038  1e06 8db01d                                 sta .voice1_dur_pt + 1
  2039  1e09 8dbc1d                                 sta .voice1_dat_pt + 1
  2040  1e0c 8dd51d                                 sta .voice2_dur_pt + 1
  2041  1e0f 8de11d                                 sta .voice2_dat_pt + 1
  2042  1e12 4caf1d                                 jmp music_get_data
  2043                          ; ==============================================================================
  2044                          ; write music data for voice1 / voice2 into TED registers
  2045                          ; ==============================================================================
  2046  1e15 a204               music_voice1:       ldx #$04
  2047  1e17 e01c                                   cpx #$1c
  2048  1e19 9008                                   bcc +
  2049  1e1b ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2050  1e1e 29ef                                   and #$ef
  2051  1e20 4c391e                                 jmp writeFF11
  2052  1e23 bd651e             +                   lda freq_tab_lo,x
  2053  1e26 8d0eff                                 sta VOICE1_FREQ_LOW
  2054  1e29 ad12ff                                 lda VOICE1
  2055  1e2c 29fc                                   and #$fc
  2056  1e2e 1d7d1e                                 ora freq_tab_hi, x
  2057  1e31 8d12ff                                 sta VOICE1
  2058  1e34 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2059  1e37 0910                                   ora #$10
  2060  1e39 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  2061  1e3c 60                                     rts
  2062                          ; ==============================================================================
  2063  1e3d a20d               music_voice2:       ldx #$0d
  2064  1e3f e01c                                   cpx #$1c
  2065  1e41 9008                                   bcc +
  2066  1e43 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2067  1e46 29df                                   and #$df
  2068  1e48 4c391e                                 jmp writeFF11
  2069  1e4b bd651e             +                   lda freq_tab_lo,x
  2070  1e4e 8d0fff                                 sta VOICE2_FREQ_LOW
  2071  1e51 ad10ff                                 lda VOICE2
  2072  1e54 29fc                                   and #$fc
  2073  1e56 1d7d1e                                 ora freq_tab_hi,x
  2074  1e59 8d10ff                                 sta VOICE2
  2075  1e5c ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2076  1e5f 0920                                   ora #$20
  2077  1e61 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2078  1e64 60                                     rts
  2079                          ; ==============================================================================
  2080                          ; TED frequency tables
  2081                          ; ==============================================================================
  2082  1e65 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  2083  1e6c 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  2084  1e73 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  2085  1e7a 818f95                                 !byte $81, $8f, $95
  2086  1e7d 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  2087  1e84 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  2088  1e8b 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  2089  1e92 030303                                 !byte $03, $03, $03
  2090                          ; ==============================================================================
  2091                                              MUSIC_DELAY_INITIAL   = $09
  2092                                              MUSIC_DELAY           = $0B
  2093  1e95 a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  2094  1e97 ca                                     dex
  2095  1e98 8e961e                                 stx music_play+1
  2096  1e9b f001                                   beq +
  2097  1e9d 60                                     rts
  2098  1e9e a20b               +                   ldx #MUSIC_DELAY
  2099  1ea0 8e961e                                 stx music_play+1
  2100  1ea3 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2101  1ea6 0937                                   ora #$37
  2102  1ea8 29bf               music_volume:       and #$bf
  2103  1eaa 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2104  1ead 4caf1d                                 jmp music_get_data
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
  2135                          
  2136                          
  2137                          ; ==============================================================================
  2138                          ; irq init
  2139                          ; ==============================================================================
  2140                                              !zone IRQ
  2141  1eb0 78                 irq_init0:          sei
  2142  1eb1 a9d0                                   lda #<irq0          ; lda #$06
  2143  1eb3 8d1403                                 sta $0314          ; irq lo
  2144  1eb6 a91e                                   lda #>irq0          ; lda #$1f
  2145  1eb8 8d1503                                 sta $0315          ; irq hi
  2146                                                                  ; irq at $1F06
  2147  1ebb a901                                   lda #$01            ;lda #$02
  2148  1ebd 8d1ad0                                 sta $d01a           ; sta FF0A          ; set IRQ source to RASTER
  2149                          
  2150  1ec0 a9bf                                   lda #$bf
  2151  1ec2 8da91e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  2152  1ec5 58                                     cli
  2153                          
  2154  1ec6 4c263a                                 jmp set_charset_and_screen
  2155                          
  2156                          ; ==============================================================================
  2157                          ; intro text
  2158                          ; wait for shift or joy2 fire press
  2159                          ; ==============================================================================
  2160                          
  2161                          check_shift_key:
  2162                          
  2163  1ec9 a5cb               -                   lda $cb
  2164  1ecb c93c                                   cmp #$3c
  2165  1ecd d0fa                                   bne -
  2166  1ecf 60                                     rts
  2167                          
  2168                          ; ==============================================================================
  2169                          ;
  2170                          ; INTERRUPT routine for music
  2171                          ; ==============================================================================
  2172                          
  2173                                              ; *= $1F06
  2174                          irq0:
  2175  1ed0 ce09ff                                 DEC INTERRUPT
  2176                          
  2177                                                                  ; this IRQ seems to handle music only!
  2178                                              !if SILENT_MODE = 1 {
  2179                                                  jsr fake
  2180                                              } else {
  2181  1ed3 20951e                                     jsr music_play
  2182                                              }
  2183  1ed6 68                                     pla
  2184  1ed7 a8                                     tay
  2185  1ed8 68                                     pla
  2186  1ed9 aa                                     tax
  2187  1eda 68                                     pla
  2188  1edb 40                                     rti
  2189                          
  2190                          ; ==============================================================================
  2191                          ; checks if the music volume is at the desired level
  2192                          ; and increases it if not
  2193                          ; if volume is high enough, it initializes the music irq routine
  2194                          ; is called right at the start of the game, but also when a game ended
  2195                          ; and is about to show the title screen again (increasing the volume)
  2196                          ; ==============================================================================
  2197                          
  2198                          init_music:                                  
  2199  1edc ada91e                                 lda music_volume+1                              ; sound volume
  2200  1edf c9bf               --                  cmp #$bf                                        ; is true on init
  2201  1ee1 d003                                   bne +
  2202  1ee3 4cb01e                                 jmp irq_init0
  2203  1ee6 a204               +                   ldx #$04
  2204  1ee8 86a8               -                   stx zpA8                                        ; buffer serial input byte ?
  2205  1eea a0ff                                   ldy #$ff
  2206  1eec 20ff39                                 jsr wait
  2207  1eef a6a8                                   ldx zpA8
  2208  1ef1 ca                                     dex
  2209  1ef2 d0f4                                   bne -                                               
  2210  1ef4 18                                     clc
  2211  1ef5 6901                                   adc #$01                                        ; increases volume again before returning to title screen
  2212  1ef7 8da91e                                 sta music_volume+1                              ; sound volume
  2213  1efa 4cdf1e                                 jmp --
  2214                          
  2215                          
  2216                          
  2217                                              ; 222222222222222         000000000          000000000          000000000
  2218                                              ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
  2219                                              ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2220                                              ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2221                                              ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2222                                              ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2223                                              ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2224                                              ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2225                                              ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2226                                              ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2227                                              ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2228                                              ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2229                                              ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2230                                              ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2231                                              ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
  2232                                              ;22222222222222222222     000000000          000000000          000000000
  2233                          
  2234                          ; ==============================================================================
  2235                          ; CHARSET
  2236                          ; $2000 - $2800
  2237                          ; ==============================================================================
  2238                          
  2239                          
  2240                          charset_start:
  2241                                              *= $2000
  2242                                              !if EXTENDED {
  2243                                                  !bin "includes/charset-new-charset.bin"
  2244                                              }else{
  2245  2000 000000020a292727...                        !bin "includes/charset.bin"
  2246                                              }
  2247                          charset_end:    ; $2800
  2248                          
  2249                          
  2250                                              ; 222222222222222         888888888          000000000           000000000
  2251                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  2252                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  2253                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2254                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2255                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2256                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  2257                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2258                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2259                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2260                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2261                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2262                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2263                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  2264                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  2265                                              ;22222222222222222222     888888888           000000000           000000000
  2266                          
  2267                          
  2268                          
  2269                          ; ==============================================================================
  2270                          ; LEVEL DATA
  2271                          ; Based on tiles
  2272                          ;                     !IMPORTANT!
  2273                          ;                     has to be page aligned or
  2274                          ;                     display_room routine will fail
  2275                          ; ==============================================================================
  2276                          
  2277                                              *= $2800
  2278                          level_data:

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
  2280                          level_data_end:
  2281                          
  2282                          
  2283                          ;$2fbf
  2284                          speed_byte:
  2285  2fb8 01                 !byte $01
  2286                          
  2287                          
  2288                          
  2289                          
  2290                          
  2291                          ; ==============================================================================
  2292                          ;
  2293                          ;
  2294                          ; ==============================================================================
  2295                                  
  2296                          
  2297                          rasterpoll_and_other_stuff:
  2298                          
  2299  2fb9 209f35                                 jsr poll_raster
  2300  2fbc 20c039                                 jsr check_door 
  2301  2fbf 4c7514                                 jmp animation_entrypoint          
  2302                          
  2303                          
  2304                          
  2305                          ; ==============================================================================
  2306                          ;
  2307                          ; tileset definition
  2308                          ; these are the first characters in the charset of each tile.
  2309                          ; example: rocks start at $0c and span 9 characters in total
  2310                          ; ==============================================================================
  2311                          
  2312                          tileset_definition:
  2313                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  2314  2fc2 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
  2315                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2316  2fca 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
  2317                                              ;     $10
  2318  2fd2 03                                     !byte $03                                           ; door
  2319                          
  2320                          !if EXTENDED = 0{
  2321                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2322  2fd3 00390a0e3d7f2a2a                       !byte $00, $39, $0a, $0e, $3d, $7f, $2a, $2a
  2323                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2324  2fdb 1e1e1e3d3d192f2f                       !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2325                                              ;     $10
  2326  2fe3 0a                                     !byte $0a
  2327                          }
  2328                          
  2329                          !if EXTENDED = 1{
  2330                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2331                                              !byte $00, $39, $2a, $0e, $3d, $7f, $2a, $2a
  2332                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2333                                              !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2334                                              ;     $10
  2335                                              !byte $29   
  2336                          }
  2337                          
  2338                          ; ==============================================================================
  2339                          ;
  2340                          ; displays a room based on tiles
  2341                          ; ==============================================================================
  2342                          
  2343                          display_room:       
  2344  2fe4 208b3a                                 jsr draw_border
  2345  2fe7 a900                                   lda #$00
  2346  2fe9 8502                                   sta zp02
  2347  2feb a2d8                                   ldx #>COLRAM        ; HiByte of COLRAM
  2348  2fed 8605                                   stx zp05
  2349  2fef a204                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  2350  2ff1 8603                                   stx zp03
  2351  2ff3 a228                                   ldx #>level_data    ; HiByte of level_data
  2352  2ff5 860a                                   stx zp0A            ; in zp0A
  2353  2ff7 a201               current_room:       ldx #$01            ; current_room in X
  2354  2ff9 f00a                                   beq ++              ; if 0 -> skip
  2355  2ffb 18                 -                   clc                 ; else
  2356  2ffc 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  2357  2ffe 9002                                   bcc +               ; to zp09/zp0A
  2358  3000 e60a                                   inc zp0A            ;
  2359  3002 ca                 +                   dex                 ; X times
  2360  3003 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  2361  3005 8509               ++                  sta zp09            ; LoByte from above
  2362  3007 a000                                   ldy #$00
  2363  3009 84a8                                   sty zpA8
  2364  300b 84a7                                   sty zpA7
  2365  300d b109               m3066:              lda (zp09),y        ; get Tilenumber
  2366  300f aa                                     tax                 ; in X
  2367  3010 bdd32f                                 lda tiles_colors,x  ; get Tilecolor
  2368  3013 8510                                   sta zp10            ; => zp10
  2369  3015 bdc22f                                 lda tiles_chars,x   ; get Tilechar
  2370  3018 8511                                   sta zp11            ; => zp11
  2371  301a a203                                   ldx #$03            ; (3 rows)
  2372  301c a000               --                  ldy #$00
  2373  301e a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  2374  3020 8504                                   sta zp04            ; LoByte of COLRAM pointer
  2375  3022 a511                                   lda zp11            ; Load Tilechar
  2376  3024 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  2377  3026 a510                                   lda zp10            ; Load Tilecolor
  2378  3028 9104                                   sta (zp04),y        ; to COLRAM + Y
  2379  302a a511                                   lda zp11            ; Load Tilechar again
  2380  302c c9df                                   cmp #$df            ; if empty tile
  2381  302e f002                                   beq +               ; -> skip
  2382  3030 e611                                   inc zp11            ; else: Tilechar + 1
  2383  3032 c8                 +                   iny                 ; Y = Y + 1
  2384  3033 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  2385  3035 d0e7                                   bne -               ; no -> next Char
  2386  3037 a502                                   lda zp02            ; yes:
  2387  3039 18                                     clc
  2388  303a 6928                                   adc #$28            ; next SCREEN row
  2389  303c 8502                                   sta zp02
  2390  303e 9004                                   bcc +
  2391  3040 e603                                   inc zp03
  2392  3042 e605                                   inc zp05            ; and COLRAM row
  2393  3044 ca                 +                   dex                 ; X = X - 1
  2394  3045 d0d5                                   bne --              ; X != 0 -> next Char
  2395  3047 e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  2396  3049 e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  2397  304b a975                                   lda #$75            ; for m30B8 + 1
  2398  304d a6a8                                   ldx zpA8
  2399  304f e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  2400  3051 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  2401  3053 a6a7                                   ldx zpA7            ; else:
  2402  3055 e066                                   cpx #$66            ; zpA7 >= $66
  2403  3057 b01c                                   bcs display_door    ; yes: display_door
  2404  3059 a900                                   lda #$00            ; else:
  2405  305b 85a8                                   sta zpA8            ; clear zpA8
  2406  305d a924                                   lda #$24            ; for m30B8 + 1
  2407  305f 8d6630             +                   sta m30B8 + 1       ;
  2408  3062 a502                                   lda zp02
  2409  3064 38                                     sec
  2410  3065 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  2411  3067 8502                                   sta zp02
  2412  3069 b004                                   bcs +
  2413  306b c603                                   dec zp03
  2414  306d c605                                   dec zp05
  2415  306f a4a7               +                   ldy zpA7
  2416  3071 4c0d30                                 jmp m3066
  2417  3074 60                                     rts                 ; will this ever be used?
  2418                          
  2419  3075 a904               display_door:       lda #>SCREENRAM
  2420  3077 8503                                   sta zp03
  2421  3079 a9d8                                   lda #>COLRAM
  2422  307b 8505                                   sta zp05
  2423  307d a900                                   lda #$00
  2424  307f 8502                                   sta zp02
  2425  3081 8504                                   sta zp04
  2426  3083 a028               -                   ldy #$28
  2427  3085 b102                                   lda (zp02),y        ; read from SCREENRAM
  2428  3087 c906                                   cmp #$06            ; $06 (part from Door?)
  2429  3089 b00b                                   bcs +               ; >= $06 -> skip
  2430  308b 38                                     sec                 ; else:
  2431  308c e903                                   sbc #$03            ; subtract $03
  2432  308e a000                                   ldy #$00            ; set Y = $00
  2433  3090 9102                                   sta (zp02),y        ; and copy to one row above
  2434  3092 a90a                                   lda #$0a            ; lda #$39 ; color brown - luminance $3  -> color of the top of a door
  2435  3094 9104                                   sta (zp04),y
  2436  3096 a502               +                   lda zp02
  2437  3098 18                                     clc
  2438  3099 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  2439  309b 9004                                   bcc +
  2440  309d e603                                   inc zp03            ; inc pointer HiBytes if necessary
  2441  309f e605                                   inc zp05
  2442  30a1 8502               +                   sta zp02
  2443  30a3 8504                                   sta zp04
  2444  30a5 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  2445  30a7 d0da                                   bne -               ; no -> loop
  2446  30a9 a503                                   lda zp03            ; else:
  2447  30ab c907                                   cmp #>(SCREENRAM+$300)
  2448  30ad d0d4                                   bne -               ; no -> loop
  2449  30af 60                                     rts                 ; else: finally ready with room display
  2450                          
  2451                          ; ==============================================================================
  2452                          
  2453  30b0 a904               print_title:        lda #>SCREENRAM
  2454  30b2 8503                                   sta zp03
  2455  30b4 a9d8                                   lda #>COLRAM
  2456  30b6 8505                                   sta zp05
  2457  30b8 a900                                   lda #<SCREENRAM
  2458  30ba 8502                                   sta zp02
  2459  30bc 8504                                   sta zp04
  2460  30be a930                                   lda #>screen_start_src
  2461  30c0 85a8                                   sta zpA8
  2462  30c2 a9df                                   lda #<screen_start_src
  2463  30c4 85a7                                   sta zpA7
  2464  30c6 a204                                   ldx #$04
  2465  30c8 a000               --                  ldy #$00
  2466  30ca b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  2467  30cc 9102                                   sta (zp02),y        ; nach SCREEN
  2468  30ce a900                                   lda #$00           ; BLACK
  2469  30d0 9104                                   sta (zp04),y        ; nach COLRAM
  2470  30d2 c8                                     iny
  2471  30d3 d0f5                                   bne -
  2472  30d5 e603                                   inc zp03
  2473  30d7 e605                                   inc zp05
  2474  30d9 e6a8                                   inc zpA8
  2475  30db ca                                     dex
  2476  30dc d0ea                                   bne --
  2477  30de 60                                     rts
  2478                          
  2479                          ; ==============================================================================
  2480                          ; TITLE SCREEN DATA
  2481                          ;
  2482                          ; ==============================================================================
  2483                          
  2484                          screen_start_src:
  2485                          
  2486                                              !if EXTENDED {
  2487                                                  !bin "includes/screen-start-extended.scr"
  2488                                              }else{
  2489  30df 20202020202020a0...                        !bin "includes/screen-start.scr"
  2490                                              }
  2491                          
  2492                          screen_start_src_end:
  2493                          
  2494                          
  2495                          ; ==============================================================================
  2496                          ; i think this might be the draw routine for the player sprite
  2497                          ;
  2498                          ; ==============================================================================
  2499                          
  2500                          
  2501                          draw_player:
  2502  34c7 8eea34                                 stx m3548 + 1                       ; store x pos of player
  2503  34ca a9d8                                   lda #>COLRAM                        ; store colram high in zp05
  2504  34cc 8505                                   sta zp05
  2505  34ce a904                                   lda #>SCREENRAM                     ; store screenram high in zp03
  2506  34d0 8503                                   sta zp03
  2507  34d2 a900                                   lda #$00
  2508  34d4 8502                                   sta zp02
  2509  34d6 8504                                   sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
  2510  34d8 c000                                   cpy #$00                            ; Y is probably the player Y position
  2511  34da f00c                                   beq +                               ; Y is 0 -> +
  2512  34dc 18                 -                   clc                                 ; Y not 0
  2513  34dd 6928                                   adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
  2514  34df 9004                                   bcc ++                              ; <256? -> ++
  2515  34e1 e603                                   inc zp03
  2516  34e3 e605                                   inc zp05
  2517  34e5 88                 ++                  dey                                 ; Y = Y - 1
  2518  34e6 d0f4                                   bne -                               ; Y = 0 ? -> -
  2519  34e8 18                 +                   clc                                 ;
  2520  34e9 6916               m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
  2521  34eb 8502                                   sta zp02
  2522  34ed 8504                                   sta zp04
  2523  34ef 9004                                   bcc +
  2524  34f1 e603                                   inc zp03
  2525  34f3 e605                                   inc zp05
  2526  34f5 a203               +                   ldx #$03                            ; draw 3 rows for the player "sprite"
  2527  34f7 a900                                   lda #$00
  2528  34f9 8509                                   sta zp09
  2529  34fb a000               --                  ldy #$00
  2530  34fd a5a7               -                   lda zpA7
  2531  34ff d006                                   bne +
  2532  3501 a9df                                   lda #$df                            ; empty char, but not sure why
  2533  3503 9102                                   sta (zp02),y
  2534  3505 d01b                                   bne ++
  2535  3507 c901               +                   cmp #$01
  2536  3509 d00a                                   bne +
  2537  350b a5a8                                   lda zpA8
  2538  350d 9102                                   sta (zp02),y
  2539  350f a50a                                   lda zp0A
  2540  3511 9104                                   sta (zp04),y
  2541  3513 d00d                                   bne ++
  2542  3515 b102               +                   lda (zp02),y
  2543  3517 8610                                   stx zp10
  2544  3519 a609                                   ldx zp09
  2545  351b 9d4503                                 sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
  2546  351e e609                                   inc zp09
  2547  3520 a610                                   ldx zp10
  2548  3522 e6a8               ++                  inc zpA8
  2549  3524 c8                                     iny
  2550  3525 c003                                   cpy #$03                            ; width of the player sprite in characters (3)
  2551  3527 d0d4                                   bne -
  2552  3529 a502                                   lda zp02
  2553  352b 18                                     clc
  2554  352c 6928                                   adc #$28                            ; $28 = #40, draws one row of the player under each other
  2555  352e 8502                                   sta zp02
  2556  3530 8504                                   sta zp04
  2557  3532 9004                                   bcc +
  2558  3534 e603                                   inc zp03
  2559  3536 e605                                   inc zp05
  2560  3538 ca                 +                   dex
  2561  3539 d0c0                                   bne --
  2562  353b 60                                     rts
  2563                          
  2564                          
  2565                          ; ==============================================================================
  2566                          ; $359b
  2567                          ; JOYSTICK CONTROLS
  2568                          ; ==============================================================================
  2569                          
  2570                          check_joystick:
  2571                          
  2572                                              ;lda #$fd
  2573                                              ;sta KEYBOARD_LATCH
  2574                                              ;lda KEYBOARD_LATCH
  2575  353c ad00dc                                 lda $dc00
  2576  353f a009               player_pos_y:       ldy #$09
  2577  3541 a215               player_pos_x:       ldx #$15
  2578  3543 4a                                     lsr
  2579  3544 b005                                   bcs +
  2580  3546 c000                                   cpy #$00
  2581  3548 f001                                   beq +
  2582  354a 88                                     dey                                           ; JOYSTICK UP
  2583  354b 4a                 +                   lsr
  2584  354c b005                                   bcs +
  2585  354e c015                                   cpy #$15
  2586  3550 b001                                   bcs +
  2587  3552 c8                                     iny                                           ; JOYSTICK DOWN
  2588  3553 4a                 +                   lsr
  2589  3554 b005                                   bcs +
  2590  3556 e000                                   cpx #$00
  2591  3558 f001                                   beq +
  2592  355a ca                                     dex                                           ; JOYSTICK LEFT
  2593  355b 4a                 +                   lsr
  2594  355c b005                                   bcs +
  2595  355e e024                                   cpx #$24
  2596  3560 b001                                   bcs +
  2597  3562 e8                                     inx                                           ; JOYSTICK RIGHT
  2598  3563 8c8135             +                   sty m35E7 + 1
  2599  3566 8e8635                                 stx m35EC + 1
  2600  3569 a902                                   lda #$02
  2601  356b 85a7                                   sta zpA7
  2602  356d 20c734                                 jsr draw_player
  2603  3570 a209                                   ldx #$09
  2604  3572 bd4403             -                   lda TAPE_BUFFER + $8,x
  2605  3575 c9df                                   cmp #$df
  2606  3577 f004                                   beq +
  2607  3579 c9e2                                   cmp #$e2
  2608  357b d00d                                   bne ++
  2609  357d ca                 +                   dex
  2610  357e d0f2                                   bne -
  2611  3580 a90a               m35E7:              lda #$0a
  2612  3582 8d4035                                 sta player_pos_y + 1
  2613  3585 a915               m35EC:              lda #$15
  2614  3587 8d4235                                 sta player_pos_x + 1
  2615                          ++                  ;lda #$ff
  2616                                              ;sta KEYBOARD_LATCH
  2617  358a a901                                   lda #$01
  2618  358c 85a7                                   sta zpA7
  2619  358e a993                                   lda #$93                ; first character of the player graphic
  2620  3590 85a8                                   sta zpA8
  2621  3592 a93d                                   lda #$3d
  2622  3594 850a                                   sta zp0A
  2623  3596 ac4035             get_player_pos:     ldy player_pos_y + 1
  2624  3599 ae4235                                 ldx player_pos_x + 1
  2625                                        
  2626  359c 4cc734                                 jmp draw_player
  2627                          
  2628                          ; ==============================================================================
  2629                          ;
  2630                          ; POLL RASTER
  2631                          ; ==============================================================================
  2632                          
  2633                          poll_raster:
  2634  359f 78                                     sei                     ; disable interrupt
  2635  35a0 a9f0                                   lda #$f0                ; lda #$c0  ;A = $c0
  2636  35a2 cd12d0             -                   cmp FF1D                ; vertical line bits 0-7
  2637                                              
  2638  35a5 d0fb                                   bne -                   ; loop until we hit line c0
  2639  35a7 a900                                   lda #$00                ; A = 0
  2640  35a9 85a7                                   sta zpA7                ; zpA7 = 0
  2641                                              
  2642  35ab 209635                                 jsr get_player_pos
  2643                                              
  2644  35ae 203c35                                 jsr check_joystick
  2645  35b1 58                                     cli
  2646  35b2 60                                     rts
  2647                          
  2648                          
  2649                          ; ==============================================================================
  2650                          ; ROOM 16
  2651                          ; BELEGRO ANIMATION
  2652                          ; ==============================================================================
  2653                          
  2654                          belegro_animation:
  2655                          
  2656  35b3 a900                                   lda #$00
  2657  35b5 85a7                                   sta zpA7
  2658  35b7 a20f               m3624:              ldx #$0f
  2659  35b9 a00f               m3626:              ldy #$0f
  2660  35bb 20c734                                 jsr draw_player
  2661  35be aeb835                                 ldx m3624 + 1
  2662  35c1 acba35                                 ldy m3626 + 1
  2663  35c4 ec4235                                 cpx player_pos_x + 1
  2664  35c7 b002                                   bcs +
  2665  35c9 e8                                     inx
  2666  35ca e8                                     inx
  2667  35cb ec4235             +                   cpx player_pos_x + 1
  2668  35ce f001                                   beq +
  2669  35d0 ca                                     dex
  2670  35d1 cc4035             +                   cpy player_pos_y + 1
  2671  35d4 b002                                   bcs +
  2672  35d6 c8                                     iny
  2673  35d7 c8                                     iny
  2674  35d8 cc4035             +                   cpy player_pos_y + 1
  2675  35db f001                                   beq +
  2676  35dd 88                                     dey
  2677  35de 8ef835             +                   stx m3668 + 1
  2678  35e1 8cfd35                                 sty m366D + 1
  2679  35e4 a902                                   lda #$02
  2680  35e6 85a7                                   sta zpA7
  2681  35e8 20c734                                 jsr draw_player
  2682  35eb a209                                   ldx #$09
  2683  35ed bd4403             -                   lda TAPE_BUFFER + $8,x
  2684  35f0 c992                                   cmp #$92
  2685  35f2 900d                                   bcc +
  2686  35f4 ca                                     dex
  2687  35f5 d0f6                                   bne -
  2688  35f7 a210               m3668:              ldx #$10
  2689  35f9 8eb835                                 stx m3624 + 1
  2690  35fc a00e               m366D:              ldy #$0e
  2691  35fe 8cba35                                 sty m3626 + 1
  2692  3601 a99c               +                   lda #$9c                                ; belegro chars
  2693  3603 85a8                                   sta zpA8
  2694  3605 a93e                                   lda #$3e
  2695  3607 850a                                   sta zp0A
  2696  3609 acba35                                 ldy m3626 + 1
  2697  360c aeb835                                 ldx m3624 + 1                    
  2698  360f a901                                   lda #$01
  2699  3611 85a7                                   sta zpA7
  2700  3613 4cc734                                 jmp draw_player
  2701                          
  2702                          
  2703                          ; ==============================================================================
  2704                          ; items
  2705                          ; This area seems to be responsible for items placement
  2706                          ;
  2707                          ; ==============================================================================
  2708                          
  2709                          items:

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
  2711                          items_end:
  2712                          
  2713                          next_item:
  2714  37c6 a5a7                                   lda zpA7
  2715  37c8 18                                     clc
  2716  37c9 6901                                   adc #$01
  2717  37cb 85a7                                   sta zpA7
  2718  37cd 9002                                   bcc +                       ; bcc $3845
  2719  37cf e6a8                                   inc zpA8
  2720  37d1 60                 +                   rts
  2721                          
  2722                          ; ==============================================================================
  2723                          ; TODO
  2724                          ; no clue yet. level data has already been drawn when this is called
  2725                          ; probably placing the items on the screen
  2726                          ; ==============================================================================
  2727                          
  2728                          update_items_display:
  2729  37d2 a936                                   lda #>items                 ; load address for items into zeropage
  2730  37d4 85a8                                   sta zpA8
  2731  37d6 a916                                   lda #<items
  2732  37d8 85a7                                   sta zpA7
  2733  37da a000                                   ldy #$00                    ; y = 0
  2734  37dc b1a7               --                  lda (zpA7),y                ; load first value
  2735  37de c9ff                                   cmp #$ff                    ; is it $ff?
  2736  37e0 f006                                   beq +                       ; yes -> +
  2737  37e2 20c637             -                   jsr next_item               ; no -> set zero page to next value
  2738  37e5 4cdc37                                 jmp --                      ; and loop
  2739  37e8 20c637             +                   jsr next_item               ; value was $ff, now get the next value in the list
  2740  37eb b1a7                                   lda (zpA7),y
  2741  37ed c9ff                                   cmp #$ff                    ; is the next value $ff again?
  2742  37ef d003                                   bne +
  2743  37f1 4c7638                                 jmp prepare_rooms           ; yes -> m38DF
  2744  37f4 cdf82f             +                   cmp current_room + 1        ; is the number the current room number?
  2745  37f7 d0e9                                   bne -                       ; no -> loop
  2746  37f9 a9d8                                   lda #>COLRAM                ; yes the number is the current room number
  2747  37fb 8505                                   sta zp05                    ; store COLRAM and SCREENRAM in zeropage
  2748  37fd a904                                   lda #>SCREENRAM
  2749  37ff 8503                                   sta zp03
  2750  3801 a900                                   lda #$00                    ; A = 0
  2751  3803 8502                                   sta zp02                    ; zp02 = 0, zp04 = 0
  2752  3805 8504                                   sta zp04
  2753  3807 20c637                                 jsr next_item               ; move to next value
  2754  380a b1a7                                   lda (zpA7),y                ; get next value in the list
  2755  380c c9fe               -                   cmp #$fe                    ; is it $FE?
  2756  380e f00b                                   beq +                       ; yes -> +
  2757  3810 c9f9                                   cmp #$f9                    ; no, is it $f9?
  2758  3812 d00d                                   bne +++                     ; no -> +++
  2759  3814 a502                                   lda zp02                    ; value is $f9
  2760  3816 206e38                                 jsr m38D7                   ; add 1 to zp02 and zp04
  2761  3819 9004                                   bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
  2762  381b e603               +                   inc zp03                    ; value is $fe
  2763  381d e605                                   inc zp05                    ; increase zp03 and zp05
  2764  381f b1a7               ++                  lda (zpA7),y                ; get value from list
  2765  3821 c9fb               +++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
  2766  3823 d009                                   bne +                       ; no -> +
  2767  3825 20c637                                 jsr next_item               ; yes it's $fb, get the next value
  2768  3828 b1a7                                   lda (zpA7),y                ; get value from list
  2769  382a 8509                                   sta zp09                    ; store value in zp09
  2770  382c d028                                   bne ++                      ; if value was 0 -> ++
  2771  382e c9f8               +                   cmp #$f8
  2772  3830 f01c                                   beq +
  2773  3832 c9fc                                   cmp #$fc
  2774  3834 d00d                                   bne +++
  2775  3836 a50a                                   lda zp0A
  2776                                                                          ; jmp m399F
  2777                          
  2778  3838 c9df                                   cmp #$df                    ; this part was moved here as it wasn't called anywhere else
  2779  383a f002                                   beq skip                    ; and I think it was just outsourced for branching length issues
  2780  383c e60a                                   inc zp0A           
  2781  383e b1a7               skip:               lda (zpA7),y        
  2782  3840 4c4e38                                 jmp m38B7
  2783                          
  2784  3843 c9fa               +++                 cmp #$fa
  2785  3845 d00f                                   bne ++
  2786  3847 20c637                                 jsr next_item
  2787  384a b1a7                                   lda (zpA7),y
  2788  384c 850a                                   sta zp0A
  2789                          m38B7:
  2790  384e a509               +                   lda zp09
  2791  3850 9104                                   sta (zp04),y
  2792  3852 a50a                                   lda zp0A
  2793  3854 9102                                   sta (zp02),y
  2794  3856 c9fd               ++                  cmp #$fd
  2795  3858 d009                                   bne +
  2796  385a 20c637                                 jsr next_item
  2797  385d b1a7                                   lda (zpA7),y
  2798  385f 8502                                   sta zp02
  2799  3861 8504                                   sta zp04
  2800  3863 20c637             +                   jsr next_item
  2801  3866 b1a7                                   lda (zpA7),y
  2802  3868 c9ff                                   cmp #$ff
  2803  386a d0a0                                   bne -
  2804  386c f008                                   beq prepare_rooms
  2805  386e 18                 m38D7:              clc
  2806  386f 6901                                   adc #$01
  2807  3871 8502                                   sta zp02
  2808  3873 8504                                   sta zp04
  2809  3875 60                                     rts
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
  2836                          
  2837                          
  2838                          ; ==============================================================================
  2839                          ; ROOM PREPARATION CHECK
  2840                          ; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
  2841                          ; ==============================================================================
  2842                          
  2843                          prepare_rooms:
  2844                                      
  2845  3876 adf82f                                 lda current_room + 1
  2846                                              
  2847  3879 c902                                   cmp #$02                                ; is the current room 02?
  2848  387b f01d                                   beq room_02_prep
  2849                          
  2850  387d c907                                   cmp #$07
  2851  387f f04c                                   beq room_07_make_sacred_column
  2852                                              
  2853  3881 c906                                   cmp #$06          
  2854  3883 f05a                                   beq room_06_make_deadly_doors
  2855                          
  2856  3885 c904                                   cmp #$04
  2857  3887 f062                                   beq room_04_prep
  2858                          
  2859  3889 c905                                   cmp #$05
  2860  388b f001                                   beq room_05_prep
  2861                          
  2862  388d 60                                     rts
  2863                          
  2864                          
  2865                          
  2866                          ; ==============================================================================
  2867                          ; ROOM 05
  2868                          ; HIDE THE BREATHING TUBE UNDER THE STONE
  2869                          ; ==============================================================================
  2870                          
  2871                          room_05_prep:                  
  2872                                                         
  2873  388e a9fd                                   lda #$fd                                    ; yes
  2874  3890 a201               breathing_tube_mod: ldx #$01
  2875  3892 d002                                   bne +                                       ; based on self mod, put the normal
  2876  3894 a97a                                   lda #$7a                                    ; stone char back again
  2877  3896 8dd206             +                   sta SCREENRAM + $2d2   
  2878  3899 60                                     rts
  2879                          
  2880                          
  2881                          
  2882                          ; ==============================================================================
  2883                          ; ROOM 02 PREP
  2884                          ; 
  2885                          ; ==============================================================================
  2886                          
  2887                          room_02_prep:
  2888  389a a90d                                   lda #$0d                                ; yes room is 02, a = $0d #13
  2889  389c 8502                                   sta zp02                                ; zp02 = $0d
  2890  389e 8504                                   sta zp04                                ; zp04 = $0d
  2891  38a0 a9d8                                   lda #>COLRAM                            ; set colram zp
  2892  38a2 8505                                   sta zp05
  2893  38a4 a904                                   lda #>SCREENRAM                         ; set screenram zp      
  2894  38a6 8503                                   sta zp03
  2895  38a8 a218                                   ldx #$18                                ; x = $18 #24
  2896  38aa b102               -                   lda (zp02),y                            ; y must have been set earlier
  2897  38ac c9df                                   cmp #$df                                ; $df = empty space likely
  2898  38ae f004                                   beq delete_fence                        ; yes, empty -> m3900
  2899  38b0 c9f5                                   cmp #$f5                                ; no, but maybe a $f5? (fence!)
  2900  38b2 d006                                   bne +                                   ; nope -> ++
  2901                          
  2902                          delete_fence:
  2903  38b4 a9f5                                   lda #$f5                                ; A is either $df or $f5 -> selfmod here
  2904  38b6 9102                                   sta (zp02),y                            ; store that value
  2905  38b8 9104                                   sta (zp04),y                            ; in zp02 and zo04
  2906  38ba a502               +                   lda zp02                                ; and load it in again, jeez
  2907  38bc 18                                     clc
  2908  38bd 6928                                   adc #$28                                ; smells like we're going to draw a fence
  2909  38bf 8502                                   sta zp02
  2910  38c1 8504                                   sta zp04
  2911  38c3 9004                                   bcc +             
  2912  38c5 e603                                   inc zp03
  2913  38c7 e605                                   inc zp05
  2914  38c9 ca                 +                   dex
  2915  38ca d0de                                   bne -              
  2916  38cc 60                                     rts
  2917                          
  2918                          ; ==============================================================================
  2919                          ; ROOM 07 PREP
  2920                          ;
  2921                          ; ==============================================================================
  2922                          
  2923                          room_07_make_sacred_column:
  2924                          
  2925                                              
  2926  38cd a217                                   ldx #$17                                    ; yes
  2927  38cf bd6805             -                   lda SCREENRAM + $168,x     
  2928  38d2 c9df                                   cmp #$df
  2929  38d4 d005                                   bne +                       
  2930  38d6 a9e3                                   lda #$e3
  2931  38d8 9d6805                                 sta SCREENRAM + $168,x    
  2932  38db ca                 +                   dex
  2933  38dc d0f1                                   bne -                      
  2934  38de 60                                     rts
  2935                          
  2936                          
  2937                          ; ==============================================================================
  2938                          ; ROOM 06
  2939                          ; PREPARE THE DEADLY DOORS
  2940                          ; ==============================================================================
  2941                          
  2942                          room_06_make_deadly_doors:
  2943                          
  2944                                              
  2945  38df a9f6                                   lda #$f6                                    ; char for wrong door
  2946  38e1 8d9c04                                 sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
  2947  38e4 8d7c06                                 sta SCREENRAM + $27c
  2948  38e7 8d6c07                                 sta SCREENRAM + $36c       
  2949  38ea 60                                     rts
  2950                          
  2951                          ; ==============================================================================
  2952                          ; ROOM 04
  2953                          ; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
  2954                          ; ==============================================================================
  2955                          
  2956                          room_04_prep: 
  2957                          
  2958                          
  2959                                              
  2960  38eb adf82f                                 lda current_room + 1                            ; get current room
  2961  38ee c904                                   cmp #04                                         ; is it 4? (coffins)
  2962  38f0 d00c                                   bne ++                                          ; nope
  2963  38f2 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  2964  38f4 ac0339                                 ldy m394A + 1                                   ; 
  2965  38f7 f002                                   beq +
  2966  38f9 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  2967  38fb 8df904             +                   sta SCREENRAM + $f9 
  2968                                          
  2969  38fe a2f7               ++                  ldx #$f7                                    ; yes room 04
  2970  3900 a0f8                                   ldy #$f8
  2971  3902 a901               m394A:              lda #$01
  2972  3904 d004                                   bne m3952           
  2973  3906 a23b                                   ldx #$3b
  2974  3908 a042                                   ldy #$42
  2975  390a a901               m3952:              lda #$01                                    ; some self mod here
  2976  390c c901                                   cmp #$01
  2977  390e d003                                   bne +           
  2978  3910 8e7a04                                 stx SCREENRAM+ $7a 
  2979  3913 c902               +                   cmp #$02
  2980  3915 d003                                   bne +           
  2981  3917 8e6a05                                 stx SCREENRAM + $16a   
  2982  391a c903               +                   cmp #$03
  2983  391c d003                                   bne +           
  2984  391e 8e5a06                                 stx SCREENRAM + $25a       
  2985  3921 c904               +                   cmp #$04
  2986  3923 d003                                   bne +           
  2987  3925 8e4a07                                 stx SCREENRAM + $34a   
  2988  3928 c905               +                   cmp #$05
  2989  392a d003                                   bne +           
  2990  392c 8c9c04                                 sty SCREENRAM + $9c    
  2991  392f c906               +                   cmp #$06
  2992  3931 d003                                   bne +           
  2993  3933 8c8c05                                 sty SCREENRAM + $18c   
  2994  3936 c907               +                   cmp #$07
  2995  3938 d003                                   bne +           
  2996  393a 8c7c06                                 sty SCREENRAM + $27c 
  2997  393d c908               +                   cmp #$08
  2998  393f d003                                   bne +           
  2999  3941 8c6c07                                 sty SCREENRAM + $36c   
  3000  3944 60                 +                   rts
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
  3019                          
  3020                          
  3021                          ; ==============================================================================
  3022                          ; PLAYER POSITION TABLE FOR EACH ROOM
  3023                          ; FORMAT: Y left door, X left door, Y right door, X right door
  3024                          ; ==============================================================================
  3025                          
  3026                          player_xy_pos_table:
  3027                          
  3028  3945 06031221           !byte $06, $03, $12, $21                                        ; room 00
  3029  3949 03031221           !byte $03, $03, $12, $21                                        ; room 01
  3030  394d 03031521           !byte $03, $03, $15, $21                                        ; room 02
  3031  3951 03030f21           !byte $03, $03, $0f, $21                                        ; room 03
  3032  3955 151e0606           !byte $15, $1e, $06, $06                                        ; room 04
  3033  3959 06031221           !byte $06, $03, $12, $21                                        ; room 05
  3034  395d 03030921           !byte $03, $03, $09, $21                                        ; room 06
  3035  3961 03031221           !byte $03, $03, $12, $21                                        ; room 07
  3036  3965 03030c21           !byte $03, $03, $0c, $21                                        ; room 08
  3037  3969 03031221           !byte $03, $03, $12, $21                                        ; room 09
  3038  396d 0c030c20           !byte $0c, $03, $0c, $20                                        ; room 10
  3039  3971 0c030c21           !byte $0c, $03, $0c, $21                                        ; room 11
  3040  3975 0c030915           !byte $0c, $03, $09, $15                                        ; room 12
  3041  3979 03030621           !byte $03, $03, $06, $21                                        ; room 13
  3042  397d 03030321           !byte $03, $03, $03, $21                                        ; room 14
  3043  3981 06031221           !byte $06, $03, $12, $21                                        ; room 15
  3044  3985 0303031d           !byte $03, $03, $03, $1d                                        ; room 16
  3045  3989 03030621           !byte $03, $03, $06, $21                                        ; room 17
  3046  398d 0303               !byte $03, $03                                                  ; room 18 (only one door)
  3047                          
  3048                          
  3049                          
  3050                          ; ==============================================================================
  3051                          ; $3a33
  3052                          ; Apparently some lookup table, e.g. to get the 
  3053                          ; ==============================================================================
  3054                          
  3055                          room_player_pos_lookup:
  3056                          
  3057  398f 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  3058  399f 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  3059  39af 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  3060  39bf 00                 !byte $00
  3061                          
  3062                          
  3063                          
  3064                          
  3065                          
  3066                          
  3067                          
  3068                          
  3069                          
  3070                          
  3071                          
  3072                          ; ==============================================================================
  3073                          ;
  3074                          ;
  3075                          ; ==============================================================================
  3076                          
  3077                          check_door:
  3078                          
  3079  39c0 a209                                   ldx #$09                                    ; set loop to 9
  3080  39c2 bd4403             -                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
  3081  39c5 c905                                   cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
  3082  39c7 f008                                   beq +                                       ; yes -> +
  3083  39c9 c903                                   cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
  3084  39cb f013                                   beq set_player_xy                           ; yes -> m3A17
  3085  39cd ca                                     dex                                         ; decrease loop
  3086  39ce d0f2                                   bne -                                       ; loop
  3087  39d0 60                 -                   rts
  3088                          
  3089  39d1 aef82f             +                   ldx current_room + 1
  3090  39d4 f0fa                                   beq -               
  3091  39d6 ca                                     dex
  3092  39d7 8ef82f                                 stx current_room + 1                        ; update room number                         
  3093  39da bc8f39                                 ldy room_player_pos_lookup,x                ; load        
  3094  39dd 4cea39                                 jmp update_player_pos           
  3095                          
  3096                          set_player_xy:
  3097  39e0 aef82f                                 ldx current_room + 1                            ; x = room number
  3098  39e3 e8                                     inx                                             ; room number ++
  3099  39e4 8ef82f                                 stx current_room + 1                            ; update room number
  3100  39e7 bca639                                 ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room
  3101                          
  3102                          update_player_pos:              
  3103  39ea b94539                                 lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
  3104  39ed 8d4035                                 sta player_pos_y + 1                            ; player y pos = a
  3105  39f0 b94639                                 lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
  3106  39f3 8d4235                                 sta player_pos_x + 1
  3107                          
  3108  39f6 20e42f             m3A2D:              jsr display_room                                ; done  
  3109  39f9 208615                                 jsr room_04_prep_door                           ; was in main loop before, might find a better place
  3110  39fc 4cd237                                 jmp update_items_display
  3111                          
  3112                          
  3113                          
  3114                          ; ==============================================================================
  3115                          ;
  3116                          ; wait routine
  3117                          ; usually called with Y set before
  3118                          ; ==============================================================================
  3119                          
  3120                          wait:
  3121  39ff ca                                     dex
  3122  3a00 d0fd                                   bne wait
  3123  3a02 88                                     dey
  3124  3a03 d0fa                                   bne wait
  3125  3a05 60                 fake:               rts
  3126                          
  3127                          
  3128                          ; ==============================================================================
  3129                          ; sets the game screen
  3130                          ; multicolor, charset, main colors
  3131                          ; ==============================================================================
  3132                          
  3133                          set_game_basics:
  3134  3a06 ad12ff                                 lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  3135  3a09 29fb                                   and #$fb                                    ; clear bit 2
  3136  3a0b 8d12ff                                 sta VOICE1                                  ; => get data from RAM
  3137  3a0e a918                                   lda #$18            ;lda #$21
  3138  3a10 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
  3139                                              
  3140                                                                                          ; bit 1 : Single clock set  ( 0 )
  3141                                                                                          ; b.2-7 : character data base address
  3142                                                                                          ; %00100$x ($2000)
  3143  3a13 ad16d0                                 lda FF07
  3144  3a16 0990                                   ora #$90                                    ; multicolor ON - reverse OFF
  3145  3a18 8d16d0                                 sta FF07
  3146                          
  3147                                                                                          ; set the main colors for the game
  3148                          
  3149  3a1b a90a                                   lda #MULTICOLOR_1                           ; original: #$db
  3150  3a1d 8d22d0                                 sta COLOR_1                                 ; char color 1
  3151  3a20 a909                                   lda #MULTICOLOR_2                           ; original: #$29
  3152  3a22 8d23d0                                 sta COLOR_2                                 ; char color 2
  3153                                              
  3154  3a25 60                                     rts
  3155                          
  3156                          ; ==============================================================================
  3157                          ; set font and screen setup (40 columns and hires)
  3158                          ; $3a9d
  3159                          ; ==============================================================================
  3160                          
  3161                          set_charset_and_screen:                               ; set text screen
  3162                                             
  3163  3a26 ad12ff                                 lda VOICE1
  3164  3a29 0904                                   ora #$04                                    ; set bit 2
  3165  3a2b 8d12ff                                 sta VOICE1                                  ; => get data from ROM
  3166  3a2e a9d5                                   lda #$d5                                    ; ROM FONT
  3167  3a30 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; set
  3168  3a33 ad16d0                                 lda FF07
  3169  3a36 a908                                   lda #$08                                    ; 40 columns and Multicolor OFF
  3170  3a38 8d16d0                                 sta FF07
  3171                                              
  3172  3a3b 60                                     rts
  3173                          
  3174                          test:
  3175  3a3c ee20d0                                 inc BORDER_COLOR
  3176  3a3f 4c3c3a                                 jmp test
  3177                          
  3178                          ; ==============================================================================
  3179                          ; init
  3180                          ; start of game (original $3ab3)
  3181                          ; ==============================================================================
  3182                          
  3183                          code_start:
  3184                          init:
  3185                                              ;jsr init_music           ; TODO
  3186                                              
  3187  3a42 a917                                   lda #$17                  ; set lower case charset
  3188  3a44 8d18d0                                 sta $d018                 ; wasn't on Plus/4 for some reason
  3189                                              
  3190  3a47 a90b                                   lda #$0b
  3191  3a49 8d21d0                                 sta BG_COLOR          ; background color
  3192  3a4c 8d20d0                                 sta BORDER_COLOR          ; border color
  3193  3a4f 20b016                                 jsr reset_items           ; might be a level data reset, and print the title screen
  3194                          
  3195  3a52 a020                                   ldy #$20
  3196  3a54 20ff39                                 jsr wait
  3197                                              
  3198                                              ; waiting for key press on title screen
  3199                          
  3200  3a57 a5cb               -                   lda $cb                   ; zp position of currently pressed key
  3201  3a59 c938                                   cmp #$38                  ; is it the space key?
  3202  3a5b d0fa                                   bne -
  3203                          
  3204                                                                        ;clda #$ff
  3205  3a5d 20e71c                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  3206                                              
  3207                          
  3208                                              ; TODO: unclear what the code below does
  3209                                              ; i think it fills the level data with "DF", which is a blank character
  3210  3a60 a904                                   lda #>SCREENRAM
  3211  3a62 8503                                   sta zp03
  3212  3a64 a900                                   lda #$00
  3213  3a66 8502                                   sta zp02
  3214  3a68 a204                                   ldx #$04
  3215  3a6a a000                                   ldy #$00
  3216  3a6c a9df                                   lda #$df
  3217  3a6e 9102               -                   sta (zp02),y
  3218  3a70 c8                                     iny
  3219  3a71 d0fb                                   bne -
  3220  3a73 e603                                   inc zp03
  3221  3a75 ca                                     dex
  3222  3a76 d0f6                                   bne -
  3223                                              
  3224  3a78 20063a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  3225                          
  3226                                              ; set background color
  3227  3a7b a900                                   lda #$00
  3228  3a7d 8d21d0                                 sta BG_COLOR
  3229                          
  3230                                              ; border color. default is a dark red
  3231  3a80 a902                                   lda #BORDER_COLOR_VALUE
  3232  3a82 8d20d0                                 sta BORDER_COLOR
  3233                                              
  3234  3a85 208b3a                                 jsr draw_border
  3235                                              
  3236  3a88 4cc33a                                 jmp set_start_screen
  3237                          
  3238                          ; ==============================================================================
  3239                          ;
  3240                          ; draws the extended "border"
  3241                          ; ==============================================================================
  3242                          
  3243                          draw_border:        
  3244  3a8b a927                                   lda #$27
  3245  3a8d 8502                                   sta zp02
  3246  3a8f 8504                                   sta zp04
  3247  3a91 a9d8                                   lda #>COLRAM
  3248  3a93 8505                                   sta zp05
  3249  3a95 a904                                   lda #>SCREENRAM
  3250  3a97 8503                                   sta zp03
  3251  3a99 a218                                   ldx #$18
  3252  3a9b a000                                   ldy #$00
  3253  3a9d a95d               -                   lda #$5d
  3254  3a9f 9102                                   sta (zp02),y
  3255  3aa1 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3256  3aa3 9104                                   sta (zp04),y
  3257  3aa5 98                                     tya
  3258  3aa6 18                                     clc
  3259  3aa7 6928                                   adc #$28
  3260  3aa9 a8                                     tay
  3261  3aaa 9004                                   bcc +
  3262  3aac e603                                   inc zp03
  3263  3aae e605                                   inc zp05
  3264  3ab0 ca                 +                   dex
  3265  3ab1 d0ea                                   bne -
  3266  3ab3 a95d               -                   lda #$5d
  3267  3ab5 9dc007                                 sta SCREENRAM + $3c0,x
  3268  3ab8 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3269  3aba 9dc0db                                 sta COLRAM + $3c0,x
  3270  3abd e8                                     inx
  3271  3abe e028                                   cpx #$28
  3272  3ac0 d0f1                                   bne -
  3273  3ac2 60                                     rts
  3274                          
  3275                          ; ==============================================================================
  3276                          ; SETUP FIRST ROOM
  3277                          ; player xy position and room number
  3278                          ; ==============================================================================
  3279                          
  3280                          set_start_screen:
  3281  3ac3 a906                                   lda #PLAYER_START_POS_Y
  3282  3ac5 8d4035                                 sta player_pos_y + 1                    ; Y player start position (0 = top)
  3283  3ac8 a903                                   lda #PLAYER_START_POS_X
  3284  3aca 8d4235                                 sta player_pos_x + 1                    ; X player start position (0 = left)
  3285  3acd a900                                   lda #START_ROOM                         ; room number (start screen) ($3b45)
  3286  3acf 8df82f                                 sta current_room + 1
  3287  3ad2 20f639                                 jsr m3A2D
  3288                                              
  3289                          
  3290                          main_loop:
  3291                                              
  3292  3ad5 20b92f                                 jsr rasterpoll_and_other_stuff
  3293  3ad8 a01b                                   ldy #$1b                                ; ldy #$30    ; wait a bit -> in each frame! slows down movement
  3294  3ada 20ff39                                 jsr wait
  3295                                                                                      ;jsr room_04_prep_door
  3296  3add 202316                                 jsr prep_player_pos
  3297  3ae0 4c3c16                                 jmp object_collision
  3298                          
  3299                          ; ==============================================================================
  3300                          ;
  3301                          ; Display the death message
  3302                          ; End of game and return to start screen
  3303                          ; ==============================================================================
  3304                          
  3305                          death:
  3306                                             
  3307  3ae3 a93b                                   lda #>death_messages
  3308  3ae5 85a8                                   sta zpA8
  3309  3ae7 a95f                                   lda #<death_messages
  3310  3ae9 85a7                                   sta zpA7
  3311  3aeb c000                                   cpy #$00
  3312  3aed f00c                                   beq ++
  3313  3aef 18                 -                   clc
  3314  3af0 6932                                   adc #$32
  3315  3af2 85a7                                   sta zpA7
  3316  3af4 9002                                   bcc +
  3317  3af6 e6a8                                   inc zpA8
  3318  3af8 88                 +                   dey
  3319  3af9 d0f4                                   bne -
  3320  3afb a90c               ++                  lda #$0c
  3321  3afd 8503                                   sta zp03
  3322  3aff 8402                                   sty zp02
  3323  3b01 a204                                   ldx #$04
  3324  3b03 a920                                   lda #$20
  3325  3b05 9102               -                   sta (zp02),y
  3326  3b07 c8                                     iny
  3327  3b08 d0fb                                   bne -
  3328  3b0a e603                                   inc zp03
  3329  3b0c ca                                     dex
  3330  3b0d d0f6                                   bne -
  3331  3b0f 20263a                                 jsr set_charset_and_screen
  3332  3b12 b1a7               -                   lda (zpA7),y
  3333  3b14 9dc005                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  3334  3b17 a900                                   lda #$00                                    ; color of the death message
  3335  3b19 9dc0d9                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  3336  3b1c e8                                     inx
  3337  3b1d c8                                     iny
  3338  3b1e e019                                   cpx #$19
  3339  3b20 d002                                   bne +
  3340  3b22 a250                                   ldx #$50
  3341  3b24 c032               +                   cpy #$32
  3342  3b26 d0ea                                   bne -
  3343  3b28 a903                                   lda #$03
  3344  3b2a 8d21d0                                 sta BG_COLOR
  3345  3b2d 8d20d0                                 sta BORDER_COLOR
  3346                                             
  3347                          m3EF9:
  3348  3b30 a908                                   lda #$08
  3349  3b32 a0ff               -                   ldy #$ff
  3350  3b34 20ff39                                 jsr wait
  3351  3b37 38                                     sec
  3352  3b38 e901                                   sbc #$01
  3353  3b3a d0f6                                   bne -
  3354                                              
  3355  3b3c 4c423a                                 jmp init
  3356                          
  3357                          ; ==============================================================================
  3358                          ;
  3359                          ; clear the sceen (replacing kernal call on plus/4)
  3360                          ; 
  3361                          ; ==============================================================================
  3362                          
  3363  3b3f a920               clear               lda #$20     ; #$20 is the spacebar Screen Code
  3364  3b41 9d0004                                 sta $0400,x  ; fill four areas with 256 spacebar characters
  3365  3b44 9d0005                                 sta $0500,x 
  3366  3b47 9d0006                                 sta $0600,x 
  3367  3b4a 9de806                                 sta $06e8,x 
  3368  3b4d a900                                   lda #$00     ; set foreground to black in Color Ram 
  3369  3b4f 9d00d8                                 sta $d800,x  
  3370  3b52 9d00d9                                 sta $d900,x
  3371  3b55 9d00da                                 sta $da00,x
  3372  3b58 9de8da                                 sta $dae8,x
  3373  3b5b e8                                     inx           ; increment X
  3374  3b5c d0e1                                   bne clear     ; did X turn to zero yet?
  3375                                                          ; if not, continue with the loop
  3376  3b5e 60                                     rts           ; return from this subroutine
  3377                          ; ==============================================================================
  3378                          ;
  3379                          ; DEATH MESSAGES
  3380                          ; ==============================================================================
  3381                          
  3382                          death_messages:
  3383                          
  3384                          ; death messages
  3385                          ; like "You fell into a snake pit"
  3386                          
  3387                          ; scr conversion
  3388                          
  3389                          ; 00 You fell into a snake pit
  3390                          ; 01 You'd better watched out for the sacred column
  3391                          ; 02 You drowned in the deep river
  3392                          ; 03 You drank from the poisend bottle
  3393                          ; 04 Boris the spider got you and killed you
  3394                          ; 05 Didn't you see the laser beam?
  3395                          ; 06 240 Volts! You got an electrical shock!
  3396                          ; 07 You stepped on a nail!
  3397                          ; 08 A foot trap stopped you!
  3398                          ; 09 This room is doomed by the wizard Manilo!
  3399                          ; 0a You were locked in and starved!
  3400                          ; 0b You were hit by a big rock and died!
  3401                          ; 0c Belegro killed you!
  3402                          ; 0d You found a thirsty zombie....
  3403                          ; 0e The monster grabbed you you. You are dead!
  3404                          ; 0f You were wounded by the bush!
  3405                          ; 10 You are trapped in wire-nettings!
  3406                          
  3407                          !if LANGUAGE = EN{
  3408  3b5f 590f152006050c0c...!scr "You fell into a          snake pit !              "
  3409  3b91 590f152704200205...!scr "You'd better watched out for the sacred column!   "
  3410  3bc3 590f152004120f17...!scr "You drowned in the deep  river !                  "
  3411  3bf5 590f15200412010e...!scr "You drank from the       poisened bottle ........ "
  3412  3c27 420f1209132c2014...!scr "Boris, the spider, got   you and killed you !     "
  3413  3c59 4409040e27142019...!scr "Didn't you see the       laser beam ?!?           "
  3414  3c8b 32343020560f0c14...!scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  3415  3cbd 590f152013140510...!scr "You stepped on a nail !                           "
  3416  3cef 4120060f0f142014...!scr "A foot trap stopped you !                         "
  3417  3d21 5408091320120f0f...!scr "This room is doomed      by the wizard Manilo !   "
  3418  3d53 590f152017051205...!scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  3419  3d85 590f152017051205...!scr "You were hit by a big    rock and died !          "
  3420  3db7 42050c0507120f20...!scr "Belegro killed           you !                    "
  3421  3de9 590f1520060f150e...!scr "You found a thirsty      zombie .......           "
  3422  3e1b 540805200d0f0e13...!scr "The monster grapped       you. You are dead !     "
  3423  3e4d 590f152017051205...!scr "You were wounded by      the bush !               "
  3424  3e7f 590f152001120520...!scr "You are trapped in       wire-nettings !          "
  3425                          }
  3426                          
  3427                          
  3428                          !if LANGUAGE = DE{
  3429                          !scr "Sie sind in eine         Schlangengrube gefallen !"
  3430                          !scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  3431                          !scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  3432                          !scr "Sie haben aus der Gift-  flasche getrunken....... "
  3433                          !scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  3434                          !scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  3435                          !scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  3436                          !scr "Sie sind in einen Nagel  getreten !               "
  3437                          !scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  3438                          !scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  3439                          !scr "Sie wurden eingeschlossenund verhungern !         "
  3440                          !scr "Sie wurden von einem     Stein ueberollt !!       "
  3441                          !scr "Belegro hat Sie          vernichtet !             "
  3442                          !scr "Im Sarg lag ein durstigerZombie........           "
  3443                          !scr "Das Monster hat Sie      erwischt !!!!!           "
  3444                          !scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  3445                          !scr "Sie haben sich im        Stacheldraht verfangen !!"
  3446                          }
  3447                          
  3448                          ; ==============================================================================
  3449                          ; screen messages
  3450                          ; and the code entry text
  3451                          ; ==============================================================================
  3452                          
  3453                          !if LANGUAGE = EN{
  3454                          
  3455                          hint_messages:
  3456  3eb1 2041201001121420...!scr " A part of the code number is :         "
  3457  3ed9 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3458  3f01 20590f15200e0505...!scr " You need: bulb, bulb holder, socket !  "
  3459  3f29 2054050c0c200d05...!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  3460  3f51 202a2a2a2a2a2020...!scr " *****   A helping letter :   "
  3461  3f6f 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  3462  3f79 2057120f0e072003...!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  3463                          
  3464                          }
  3465                          
  3466                          !if LANGUAGE = DE{
  3467                          
  3468                          hint_messages:
  3469                          !scr " Ein Teil des Loesungscodes lautet:     "
  3470                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3471                          !scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  3472                          !scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  3473                          !scr " *****   Ein Hilfsbuchstabe:  "
  3474                          helping_letter: !scr "C   ***** "
  3475                          !scr " Falscher Loesungscode ! TODESSTRAFE !! "
  3476                          
  3477                          }
  3478                          
  3479                          
  3480                          ; ==============================================================================
  3481                          ;
  3482                          ; ITEM PICKUP MESSAGES
  3483                          ; ==============================================================================
  3484                          
  3485                          
  3486                          item_pickup_message:              ; item pickup messages
  3487                          
  3488                          !if LANGUAGE = EN{
  3489  3fa1 2054080512052009...!scr " There is a key in the bottle !         "
  3490  3fc9 2020205408051205...!scr "   There is a key in the coffin !       "
  3491  3ff1 2054080512052009...!scr " There is a breathing tube !            "
  3492                          }
  3493                          
  3494                          !if LANGUAGE = DE{
  3495                          !scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
  3496                          !scr "    In dem Sarg lag ein Schluessel !    "
  3497                          !scr " Unter dem Stein lag ein Taucheranzug ! "
  3498                          }
  3499                          item_pickup_message_end:
