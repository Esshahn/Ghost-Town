
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
   162  1000 20d2ff                                 jsr PRINT_KERNAL          
   163                          
   164                          display_hint_message:
   165                                             
   166  1003 a93e                                   lda #>hint_messages
   167  1005 85a8                                   sta zpA8
   168  1007 a991                                   lda #<hint_messages
   169  1009 c000               m1009:              cpy #$00
   170  100b f00a                                   beq ++              
   171  100d 18                 -                   clc
   172  100e 6928                                   adc #$28
   173  1010 9002                                   bcc +               
   174  1012 e6a8                                   inc zpA8
   175  1014 88                 +                   dey
   176  1015 d0f6                                   bne -               
   177  1017 85a7               ++                  sta zpA7
   178  1019 20263a                                 jsr set_charset_and_screen          
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
   196  102c 204511                                 jsr switch_charset           
   197  102f c003                                   cpy #$03                                ; is the display hint the one for the code number?
   198  1031 f003                                   beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
   199  1033 4ccd10                                 jmp display_hint                        ; no, display the hint
   200                          
   201                          
   202                          room_16_code_number_prep:
   203                          
   204  1036 200310                                 jsr display_hint_message                ; yes we are in room 3
   205                                              ;jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   206                                              ;jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   207  1039 a001                                   ldy #$01                                ; y = 1
   208  103b 200310                                 jsr display_hint_message              
   209  103e a200                                   ldx #$00                                ; x = 0
   210  1040 a000                                   ldy #$00                                ; y = 0
   211  1042 f013                                   beq room_16_enter_code                  ; room 16 code? how?
   212                          
   213                          room_16_cursor_blinking: 
   214                          
   215  1044 bdb905                                 lda SCREENRAM+$1B9,x                    ; load something from screen
   216  1047 18                                     clc                                     
   217  1048 6980                                   adc #$80                                ; add $80 = 128 = inverted char
   218  104a 9db905                                 sta SCREENRAM+$1B9,x                    ; store in the same location
   219  104d b98805                                 lda SCREENRAM+$188,y                    ; and the same for another position
   220  1050 18                                     clc
   221  1051 6980                                   adc #$80
   222  1053 998805                                 sta SCREENRAM+$188,y 
   223  1056 60                                     rts
   224                          
   225                          ; ==============================================================================
   226                          ; ROOM 16
   227                          ; ENTER CODE
   228                          ; ==============================================================================
   229                          
   230                          room_16_enter_code:
   231  1057 204410                                 jsr room_16_cursor_blinking
   232  105a 8402                                   sty zp02
   233  105c 8604                                   stx zp04
   234  105e 209a10                                 jsr room_16_code_delay           
   235  1061 204410                                 jsr room_16_cursor_blinking           
   236  1064 209a10                                 jsr room_16_code_delay
   237  1067 ad00dc                                 lda $dc00
   238                                              ;lda #$fd                                        ; KEYBOARD stuff
   239                                              ;sta KEYBOARD_LATCH                              ; .
   240                                              ;lda KEYBOARD_LATCH                              ; .
   241  106a 4a                                     lsr                                             ; .
   242  106b 4a                                     lsr
   243  106c 4a                                     lsr
   244  106d b005                                   bcs +
   245  106f e000                                   cpx #$00
   246  1071 f001                                   beq +
   247  1073 ca                                     dex
   248  1074 4a                 +                   lsr
   249  1075 b005                                   bcs +
   250  1077 e025                                   cpx #$25
   251  1079 f001                                   beq +
   252  107b e8                                     inx
   253  107c 2908               +                   and #$08
   254  107e d0d7                                   bne room_16_enter_code
   255  1080 bdb905                                 lda SCREENRAM+$1B9,x
   256  1083 c9bc                                   cmp #$bc
   257  1085 d008                                   bne ++
   258  1087 c000                                   cpy #$00
   259  1089 f001                                   beq +
   260  108b 88                                     dey
   261  108c 4c5710             +                   jmp room_16_enter_code
   262  108f 998805             ++                  sta SCREENRAM+$188,y
   263  1092 c8                                     iny
   264  1093 c005                                   cpy #$05
   265  1095 d0c0                                   bne room_16_enter_code
   266  1097 4ca410                                 jmp check_code_number
   267                          
   268                          ; ==============================================================================
   269                          ;
   270                          ; DELAYS CURSOR MOVEMENT AND BLINKING
   271                          ; ==============================================================================
   272                          
   273                          room_16_code_delay:
   274  109a a035                                   ldy #$35                            ; wait a bit
   275  109c 20ff39                                 jsr wait                        
   276  109f a402                                   ldy zp02                            ; and load x and y 
   277  10a1 a604                                   ldx zp04                            ; with shit from zp
   278  10a3 60                                     rts
   279                          
   280                          ; ==============================================================================
   281                          ; ROOM 16
   282                          ; CHECK THE CODE NUMBER
   283                          ; ==============================================================================
   284                          
   285                          check_code_number:
   286  10a4 a205                                   ldx #$05                            ; x = 5
   287  10a6 bd8705             -                   lda SCREENRAM+$187,x                ; get one number from code
   288  10a9 ddbb10                                 cmp code_number-1,x                 ; is it correct?
   289  10ac d006                                   bne +                               ; no -> +
   290  10ae ca                                     dex                                 ; yes, check next number
   291  10af d0f5                                   bne -                               
   292  10b1 4cc110                                 jmp ++                              ; all correct -> ++
   293  10b4 a005               +                   ldy #$05                            ; text for wrong code number
   294  10b6 200310                                 jsr display_hint_message            ; wrong code -> death
   295  10b9 4c303b                                 jmp m3EF9          
   296                          
   297  10bc 3036313338         code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38
   298                          
   299  10c1 20063a             ++                  jsr set_game_basics                 ; code correct, continue
   300  10c4 20e039                                 jsr set_player_xy          
   301  10c7 208b3a                                 jsr draw_border          
   302  10ca 4cd53a                                 jmp main_loop          
   303                          
   304                          ; ==============================================================================
   305                          ;
   306                          ; hint system (question marks)
   307                          ; ==============================================================================
   308                          
   309                          
   310                          display_hint:
   311  10cd c000                                   cpy #$00
   312  10cf d04a                                   bne m11A2           
   313  10d1 200010                                 jsr display_hint_message_plus_kernal
   314  10d4 aef82f                                 ldx current_room + 1
   315  10d7 e001                                   cpx #$01
   316  10d9 d002                                   bne +               
   317  10db a928                                   lda #$28
   318  10dd e005               +                   cpx #$05
   319  10df d002                                   bne +               
   320  10e1 a929                                   lda #$29
   321  10e3 e00a               +                   cpx #$0a
   322  10e5 d002                                   bne +               
   323  10e7 a947                                   lda #$47                   
   324                          
   325  10e9 e00c               +                   cpx #$0c
   326  10eb d002                                   bne +
   327  10ed a949                                   lda #$49
   328  10ef e00d               +                   cpx #$0d
   329  10f1 d002                                   bne +
   330  10f3 a945                                   lda #$45
   331  10f5 e00f               +                   cpx #$0f
   332  10f7 d00a                                   bne +               
   333  10f9 a945                                   lda #$45
   334  10fb 8d6fda                                 sta COLRAM + $26f       
   335  10fe a90f                                   lda #$0f
   336  1100 8d6f06                                 sta SCREENRAM + $26f       
   337  1103 8d1f06             +                   sta SCREENRAM + $21f       
   338  1106 a948                                   lda #$48
   339  1108 8d1fda                                 sta COLRAM + $21f       
   340  110b ad00dc             -                   lda $dc00                         ;lda #$fd
   341                                                                                ;sta KEYBOARD_LATCH
   342                                                                                ; lda KEYBOARD_LATCH
   343  110e 2910                                   and #$10                          ; and #$80
   344  1110 d0f9                                   bne -               
   345  1112 20063a                                 jsr set_game_basics
   346  1115 20f639                                 jsr m3A2D          
   347  1118 4cd53a                                 jmp main_loop         
   348  111b c002               m11A2:              cpy #$02
   349  111d d006                                   bne +             
   350  111f 200010             m11A6:              jsr display_hint_message_plus_kernal
   351  1122 4c0b11                                 jmp -             
   352  1125 c004               +                   cpy #$04
   353  1127 d00b                                   bne +              
   354  1129 ad0b39                                 lda m3952 + 1    
   355  112c 18                                     clc
   356  112d 6940                                   adc #$40                                        ; this is the helping letter
   357  112f 8d4f3f                                 sta helping_letter         
   358  1132 d0eb                                   bne m11A6          
   359  1134 88                 +                   dey
   360  1135 88                                     dey
   361  1136 88                                     dey
   362  1137 88                                     dey
   363  1138 88                                     dey
   364  1139 a93f                                   lda #>item_pickup_message
   365  113b 85a8                                   sta zpA8
   366  113d a981                                   lda #<item_pickup_message
   367  113f 200910                                 jsr m1009
   368  1142 4c0b11                                 jmp -
   369                          
   370                          ; ==============================================================================
   371                          
   372                          switch_charset:
   373  1145 20263a                                 jsr set_charset_and_screen           
   374  1148 4cd2ff                                 jmp PRINT_KERNAL           
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
   401                          
   402                          ; ==============================================================================
   403                          ;
   404                          ; JUMP TO ROOM LOGIC
   405                          ; This code is new. Previously, code execution jumped from room to room
   406                          ; and in each room did the comparison with the room number.
   407                          ; This is essentially the same, but bundled in one place.
   408                          ; not calles in between room changes, only e.g. for question mark
   409                          ; ==============================================================================
   410                          
   411                          check_room:
   412  114b acf82f                                 ldy current_room + 1        ; load in the current room number
   413  114e c000                                   cpy #0
   414  1150 d003                                   bne +
   415  1152 4ced11                                 jmp room_00
   416  1155 c001               +                   cpy #1
   417  1157 d003                                   bne +
   418  1159 4c0812                                 jmp room_01
   419  115c c002               +                   cpy #2
   420  115e d003                                   bne +
   421  1160 4c4512                                 jmp room_02
   422  1163 c003               +                   cpy #3
   423  1165 d003                                   bne +
   424  1167 4c9b12                                 jmp room_03
   425  116a c004               +                   cpy #4
   426  116c d003                                   bne +
   427  116e 4ca712                                 jmp room_04
   428  1171 c005               +                   cpy #5
   429  1173 d003                                   bne +
   430  1175 4cc912                                 jmp room_05
   431  1178 c006               +                   cpy #6
   432  117a d003                                   bne +
   433  117c 4ced12                                 jmp room_06
   434  117f c007               +                   cpy #7
   435  1181 d003                                   bne +
   436  1183 4cf912                                 jmp room_07
   437  1186 c008               +                   cpy #8
   438  1188 d003                                   bne +
   439  118a 4c3113                                 jmp room_08
   440  118d c009               +                   cpy #9
   441  118f d003                                   bne +
   442  1191 4c8813                                 jmp room_09
   443  1194 c00a               +                   cpy #10
   444  1196 d003                                   bne +
   445  1198 4c9413                                 jmp room_10
   446  119b c00b               +                   cpy #11
   447  119d d003                                   bne +
   448  119f 4cc413                                 jmp room_11 
   449  11a2 c00c               +                   cpy #12
   450  11a4 d003                                   bne +
   451  11a6 4cd313                                 jmp room_12
   452  11a9 c00d               +                   cpy #13
   453  11ab d003                                   bne +
   454  11ad 4cef13                                 jmp room_13
   455  11b0 c00e               +                   cpy #14
   456  11b2 d003                                   bne +
   457  11b4 4c1314                                 jmp room_14
   458  11b7 c00f               +                   cpy #15
   459  11b9 d003                                   bne +
   460  11bb 4c1f14                                 jmp room_15
   461  11be c010               +                   cpy #16
   462  11c0 d003                                   bne +
   463  11c2 4c2b14                                 jmp room_16
   464  11c5 c011               +                   cpy #17
   465  11c7 d003                                   bne +
   466  11c9 4c5114                                 jmp room_17
   467  11cc 4c6014             +                   jmp room_18
   468                          
   469                          
   470                          
   471                          ; ==============================================================================
   472                          
   473                          check_death:
   474  11cf 20d237                                 jsr update_items_display
   475  11d2 4cd53a                                 jmp main_loop           
   476                          
   477                          ; ==============================================================================
   478                          
   479                          m11E0:              
   480  11d5 a200                                   ldx #$00
   481  11d7 bd4503             -                   lda TAPE_BUFFER + $9,x              
   482  11da c91e                                   cmp #$1e                            ; question mark
   483  11dc 9007                                   bcc check_next_char_under_player           
   484  11de c9df                                   cmp #$df
   485  11e0 f003                                   beq check_next_char_under_player
   486  11e2 4c4b11                                 jmp check_room              
   487                          
   488                          ; ==============================================================================
   489                          
   490                          check_next_char_under_player:
   491  11e5 e8                                     inx
   492  11e6 e009                                   cpx #$09
   493  11e8 d0ed                                   bne -                              ; not done checking          
   494  11ea 4cd53a             -                   jmp main_loop           
   495                          
   496                          
   497                          ; ==============================================================================
   498                          ;
   499                          ;                                                             ###        ###
   500                          ;          #####      ####      ####     #    #              #   #      #   #
   501                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   502                          ;          #    #    #    #    #    #    # ## #             #     #    #     #
   503                          ;          #####     #    #    #    #    #    #             #     #    #     #
   504                          ;          #   #     #    #    #    #    #    #              #   #      #   #
   505                          ;          #    #     ####      ####     #    #               ###        ###
   506                          ;
   507                          ; ==============================================================================
   508                          
   509                          
   510                          room_00:
   511                          
   512  11ed c9a9                                   cmp #$a9                                        ; has the player hit the gloves?
   513  11ef d0f4                                   bne check_next_char_under_player                ; no
   514  11f1 a9df                                   lda #$df                                        ; yes, load in char for "empty"
   515  11f3 cd6336                                 cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
   516  11f6 d0f2                                   bne -                                           ; no
   517  11f8 20fd11                                 jsr pickup_gloves                               ; yes
   518  11fb d0d2                                   bne check_death
   519                          
   520                          
   521                          pickup_gloves:
   522  11fd a96b                                   lda #$6b                                        ; load character for empty bush
   523  11ff 8d1e36                                 sta items + $8                                  ; store 6b = gloves in inventory
   524  1202 a93d                                   lda #$3d                                        ; set the foreground color
   525  1204 8d1c36                                 sta items + $6                                  ; and store the color in the items table
   526  1207 60                                     rts
   527                          
   528                          
   529                          
   530                          
   531                          
   532                          
   533                          ; ==============================================================================
   534                          ;
   535                          ;                                                             ###        #
   536                          ;          #####      ####      ####     #    #              #   #      ##
   537                          ;          #    #    #    #    #    #    ##  ##             #     #    # #
   538                          ;          #    #    #    #    #    #    # ## #             #     #      #
   539                          ;          #####     #    #    #    #    #    #             #     #      #
   540                          ;          #   #     #    #    #    #    #    #              #   #       #
   541                          ;          #    #     ####      ####     #    #               ###      #####
   542                          ;
   543                          ; ==============================================================================
   544                          
   545                          room_01:
   546                          
   547  1208 c9e0                                   cmp #$e0                                    ; empty character in charset -> invisible key
   548  120a f004                                   beq +                                       ; yes, key is there -> +
   549  120c c9e1                                   cmp #$e1
   550  120e d014                                   bne ++
   551  1210 a9aa               +                   lda #$aa                                    ; display the key, $AA = 1st part of key
   552  1212 8d2636                                 sta items + $10                             ; store key in items list
   553  1215 20d237                                 jsr update_items_display                    ; update all items in the items list (we just made the key visible)
   554  1218 a0f0                                   ldy #$f0                                    ; set waiting time
   555  121a 20ff39                                 jsr wait                                    ; wait
   556  121d a9df                                   lda #$df                                    ; set key to empty space
   557  121f 8d2636                                 sta items + $10                             ; update items list
   558  1222 d0ab                                   bne check_death
   559  1224 c927               ++                  cmp #$27                                    ; question mark (I don't know why 27)
   560  1226 b005                                   bcs check_death_bush
   561  1228 a000                                   ldy #$00
   562  122a 4c2c10                                 jmp prep_and_display_hint
   563                          
   564                          check_death_bush:
   565  122d c9ad                                   cmp #$ad                                    ; wirecutters
   566  122f d0b4                                   bne check_next_char_under_player
   567  1231 ad1e36                                 lda items + $8                              ; inventory place for the gloves! 6b = gloves
   568  1234 c96b                                   cmp #$6b
   569  1236 f005                                   beq +
   570  1238 a00f                                   ldy #$0f
   571  123a 4ce33a                                 jmp death                                   ; 0f You were wounded by the bush!
   572                          
   573  123d a9f9               +                   lda #$f9                                    ; wirecutter picked up
   574  123f 8d2f36                                 sta items + $19
   575  1242 4ccf11                                 jmp check_death
   576                          
   577                          
   578                          
   579                          
   580                          
   581                          
   582                          ; ==============================================================================
   583                          ;
   584                          ;                                                             ###       #####
   585                          ;          #####      ####      ####     #    #              #   #     #     #
   586                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   587                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   588                          ;          #####     #    #    #    #    #    #             #     #    #
   589                          ;          #   #     #    #    #    #    #    #              #   #     #
   590                          ;          #    #     ####      ####     #    #               ###      #######
   591                          ;
   592                          ; ==============================================================================
   593                          
   594                          room_02:
   595                          
   596  1245 c9f5                                   cmp #$f5                                    ; did the player hit the fence? f5 = fence character
   597  1247 d014                                   bne check_lock                              ; no, check for the lock
   598  1249 ad2f36                                 lda items + $19                             ; fence was hit, so check if wirecuter was picked up
   599  124c c9f9                                   cmp #$f9                                    ; where the wirecutters (f9) picked up?
   600  124e f005                                   beq remove_fence                            ; yes
   601  1250 a010                                   ldy #$10                                    ; no, load the correct death message
   602  1252 4ce33a                                 jmp death                                   ; 10 You are trapped in wire-nettings!
   603                          
   604                          remove_fence:
   605  1255 a9df                                   lda #$df                                    ; empty char
   606  1257 8db538                                 sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
   607  125a 4ccf11             m1264:              jmp check_death
   608                          
   609                          
   610                          check_lock:
   611  125d c9a6                                   cmp #$a6                                    ; lock
   612  125f d00e                                   bne +
   613  1261 ad2636                                 lda items + $10
   614  1264 c9df                                   cmp #$df
   615  1266 d0f2                                   bne m1264
   616  1268 a9df                                   lda #$df
   617  126a 8d4e36                                 sta items + $38
   618  126d d0eb                                   bne m1264
   619  126f c9b1               +                   cmp #$b1                                    ; ladder
   620  1271 d00a                                   bne +
   621  1273 a9df                                   lda #$df
   622  1275 8d6336                                 sta items + $4d
   623  1278 8d6e36                                 sta items + $58
   624  127b d0dd                                   bne m1264
   625  127d c9b9               +                   cmp #$b9                                    ; bottle
   626  127f f003                                   beq +
   627  1281 4ce511                                 jmp check_next_char_under_player
   628  1284 add136             +                   lda items + $bb
   629  1287 c9df                                   cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
   630  1289 f005                                   beq take_key_out_of_bottle                                   
   631  128b a003                                   ldy #$03
   632  128d 4ce33a                                 jmp death                                   ; 03 You drank from the poisend bottle
   633                          
   634                          take_key_out_of_bottle:
   635  1290 a901                                   lda #$01
   636  1292 8d9a12                                 sta key_in_bottle_storage
   637  1295 a005                                   ldy #$05
   638  1297 4c2c10                                 jmp prep_and_display_hint
   639                          
   640                          ; ==============================================================================
   641                          ; this is 1 if the key from the bottle was taken and 0 if not
   642                          
   643  129a 00                 key_in_bottle_storage:              !byte $00
   644                          
   645                          
   646                          
   647                          
   648                          
   649                          
   650                          
   651                          
   652                          
   653                          ; ==============================================================================
   654                          ;
   655                          ;                                                             ###       #####
   656                          ;          #####      ####      ####     #    #              #   #     #     #
   657                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   658                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   659                          ;          #####     #    #    #    #    #    #             #     #          #
   660                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   661                          ;          #    #     ####      ####     #    #               ###       #####
   662                          ;
   663                          ; ==============================================================================
   664                          
   665                          room_03:
   666                          
   667  129b c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   668  129d 9003                                   bcc +
   669  129f 4cd53a                                 jmp main_loop
   670  12a2 a004               +                   ldy #$04
   671  12a4 4c2c10                                 jmp prep_and_display_hint
   672                          
   673                          
   674                          
   675                          
   676                          
   677                          
   678                          ; ==============================================================================
   679                          ;
   680                          ;                                                             ###      #
   681                          ;          #####      ####      ####     #    #              #   #     #    #
   682                          ;          #    #    #    #    #    #    ##  ##             #     #    #    #
   683                          ;          #    #    #    #    #    #    # ## #             #     #    #    #
   684                          ;          #####     #    #    #    #    #    #             #     #    #######
   685                          ;          #   #     #    #    #    #    #    #              #   #          #
   686                          ;          #    #     ####      ####     #    #               ###           #
   687                          ;
   688                          ; ==============================================================================
   689                          
   690                          room_04:
   691                          
   692  12a7 c93b                                   cmp #$3b                                    ; you bumped into a zombie coffin?
   693  12a9 f004                                   beq +                                       ; yep
   694  12ab c942                                   cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
   695  12ad d005                                   bne ++                                      ; no, really, I didn't ( I swear! )-> ++
   696  12af a00d               +                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
   697  12b1 4ce33a                                 jmp death                                   ; 0d You found a thirsty zombie....
   698                          
   699                          ++
   700  12b4 c9f7                                   cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
   701  12b6 f007                                   beq +                                       ; seems you picked a coffin that contained something different...
   702  12b8 c9f8                                   cmp #$f8
   703  12ba f003                                   beq +
   704  12bc 4ce511                                 jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
   705  12bf a900               +                   lda #$00                                    ; 
   706  12c1 8d0339                                 sta m394A + 1                               ; some kind of prep for the door to be unlocked 
   707  12c4 a006                                   ldy #$06                                    ; display
   708  12c6 4c2c10                                 jmp prep_and_display_hint
   709                          
   710                          
   711                          
   712                          
   713                          
   714                          
   715                          ; ==============================================================================
   716                          ;
   717                          ;                                                             ###      #######
   718                          ;          #####      ####      ####     #    #              #   #     #
   719                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   720                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   721                          ;          #####     #    #    #    #    #    #             #     #          #
   722                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   723                          ;          #    #     ####      ####     #    #               ###       #####
   724                          ;
   725                          ; ==============================================================================
   726                          
   727                          room_05:
   728                          
   729  12c9 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   730  12cb b005                                   bcs +                                       ; no
   731  12cd a000                                   ldy #$00                                    ; a = 0
   732  12cf 4c2c10                                 jmp prep_and_display_hint
   733                          
   734  12d2 c9fd               +                   cmp #$fd                                    ; stone with breathing tube hit?
   735  12d4 f003                                   beq +                                       ; yes -> +
   736  12d6 4ce511                                 jmp check_next_char_under_player            ; no
   737                          
   738  12d9 a900               +                   lda #$00                                    ; a = 0                  
   739  12db acac36                                 ldy items + $96                             ; do you have the shovel? 
   740  12de c0df                                   cpy #$df
   741  12e0 d008                                   bne +                                       ; no I don't
   742  12e2 8d9138                                 sta breathing_tube_mod + 1                  ; yes, take the breathing tube
   743  12e5 a007                                   ldy #$07                                    ; and display the message
   744  12e7 4c2c10                                 jmp prep_and_display_hint
   745  12ea 4cd53a             +                   jmp main_loop
   746                          
   747                                              ;ldy #$07                                   ; same is happening above and I don't see this being called
   748                                              ;jmp prep_and_display_hint
   749                          
   750                          
   751                          
   752                          
   753                          
   754                          
   755                          ; ==============================================================================
   756                          ;
   757                          ;                                                             ###       #####
   758                          ;          #####      ####      ####     #    #              #   #     #     #
   759                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   760                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   761                          ;          #####     #    #    #    #    #    #             #     #    #     #
   762                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   763                          ;          #    #     ####      ####     #    #               ###       #####
   764                          ;
   765                          ; ==============================================================================
   766                          
   767                          room_06:
   768                          
   769  12ed c9f6                                   cmp #$f6                                    ; is it a trapped door?
   770  12ef f003                                   beq +                                       ; OMG Yes the room is full of...
   771  12f1 4ce511                                 jmp check_next_char_under_player            ; please move on. nothing happened.
   772  12f4 a000               +                   ldy #$00
   773  12f6 4ce33a                                 jmp death                                   ; 00 You fell into a snake pit
   774                          
   775                          
   776                          
   777                          
   778                          
   779                          
   780                          ; ==============================================================================
   781                          ;
   782                          ;                                                             ###      #######
   783                          ;          #####      ####      ####     #    #              #   #     #    #
   784                          ;          #    #    #    #    #    #    ##  ##             #     #        #
   785                          ;          #    #    #    #    #    #    # ## #             #     #       #
   786                          ;          #####     #    #    #    #    #    #             #     #      #
   787                          ;          #   #     #    #    #    #    #    #              #   #       #
   788                          ;          #    #     ####      ####     #    #               ###        #
   789                          ;
   790                          ; ==============================================================================
   791                          
   792                          room_07:
   793                                  
   794  12f9 c9e3                                   cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
   795  12fb d005                                   bne +
   796  12fd a001                                   ldy #$01                                    ; 01 You'd better watched out for the sacred column
   797  12ff 4ce33a                                 jmp death                                   ; bne m1303 <- seems unneccessary
   798                          
   799  1302 c95f               +                   cmp #$5f                                    ; seems to be the invisible char for the light
   800  1304 f003                                   beq +                                       ; and it was hit -> +
   801  1306 4ce511                                 jmp check_next_char_under_player            ; if not, continue checking
   802                          
   803  1309 a9bc               +                   lda #$bc                                    ; make light visible
   804  130b 8d8a36                                 sta items + $74                             ; but I dont understand how the whole light is shown
   805  130e a95f                                   lda #$5f                                    ; color?
   806  1310 8d8836                                 sta items + $72                             ; 
   807  1313 20d237                                 jsr update_items_display                    ; and redraw items
   808  1316 a0ff                                   ldy #$ff
   809  1318 20ff39                                 jsr wait                                    ; wait for some time so the player can actually see the light
   810  131b 20ff39                                 jsr wait
   811  131e 20ff39                                 jsr wait
   812  1321 20ff39                                 jsr wait
   813  1324 a9df                                   lda #$df
   814  1326 8d8a36                                 sta items + $74                             ; and pick up the light/ remove it from the items list
   815  1329 a900                                   lda #$00
   816  132b 8d8836                                 sta items + $72                             ; also paint the char black
   817  132e 4ccf11                                 jmp check_death
   818                          
   819                          
   820                          
   821                          
   822                          
   823                          
   824                          ; ==============================================================================
   825                          ;
   826                          ;                                                             ###       #####
   827                          ;          #####      ####      ####     #    #              #   #     #     #
   828                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   829                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   830                          ;          #####     #    #    #    #    #    #             #     #    #     #
   831                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   832                          ;          #    #     ####      ####     #    #               ###       #####
   833                          ;
   834                          ; ==============================================================================
   835                          
   836                          room_08:
   837                          
   838  1331 a000                                   ldy #$00                                    ; y = 0
   839  1333 84a7                                   sty zpA7                                    ; zpA7 = 0
   840  1335 c94b                                   cmp #$4b                                    ; water
   841  1337 d015                                   bne check_item_water
   842  1339 ac9138                                 ldy breathing_tube_mod + 1
   843  133c d017                                   bne +
   844  133e 209635                                 jsr get_player_pos
   845  1341 a918                                   lda #$18                                    ; move player on the other side of the river
   846  1343 8d4235             --                  sta player_pos_x + 1
   847  1346 a90c                                   lda #$0c
   848  1348 8d4035                                 sta player_pos_y + 1
   849  134b 4cd53a             -                   jmp main_loop
   850                          
   851                          
   852                          check_item_water:
   853  134e c956                                   cmp #$56                                    ; so you want to swim right?
   854  1350 d011                                   bne check_item_shovel                       ; nah, not this time -> check_item_shovel
   855  1352 ac9138                                 ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
   856  1355 d007               +                   bne +
   857  1357 209635                                 jsr get_player_pos                          ; tube equipped and ready to submerge
   858  135a a90c                                   lda #$0c
   859  135c d0e5                                   bne --                                      ; see you on the other side!
   860                          
   861  135e a002               +                   ldy #$02                                    ; breathing what?
   862  1360 4ce33a                                 jmp death                                   ; 02 You drowned in the deep river
   863                          
   864                          
   865                          check_item_shovel:
   866  1363 c9c1                                   cmp #$c1                                    ; wanna have that shovel?
   867  1365 f004                                   beq +                                       ; yup
   868  1367 c9c3                                   cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
   869  1369 d008                                   bne ++                                      ; nah still not interested -> ++
   870  136b a9df               +                   lda #$df                                    ; alright cool,
   871  136d 8dac36                                 sta items + $96                             ; shovel is yours now
   872  1370 4ccf11             --                  jmp check_death
   873                          
   874                          
   875  1373 c9ca               ++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
   876  1375 f003                                   beq +                                       ; yup
   877  1377 4ce511                                 jmp check_next_char_under_player
   878  137a add136             +                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
   879  137d c9df                                   cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
   880  137f d0ca                                   bne -                                       ; what hammer?
   881  1381 a9df                                   lda #$df
   882  1383 8d9a36                                 sta items + $84                             ; these fine boots are yours now, sir
   883  1386 d0e8                                   bne --
   884                          
   885                          
   886                          
   887                          
   888                          
   889                          
   890                          ; ==============================================================================
   891                          ;
   892                          ;                                                             ###       #####
   893                          ;          #####      ####      ####     #    #              #   #     #     #
   894                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   895                          ;          #    #    #    #    #    #    # ## #             #     #     ######
   896                          ;          #####     #    #    #    #    #    #             #     #          #
   897                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   898                          ;          #    #     ####      ####     #    #               ###       #####
   899                          ;
   900                          ; ==============================================================================
   901                          
   902                          room_09:            
   903                          
   904  1388 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   905  138a 9003                                   bcc +                                       ; yes -> +
   906  138c 4ce511                                 jmp check_next_char_under_player            ; continue checking
   907  138f a002               +                   ldy #$02                                    ; display hint
   908  1391 4c2c10                                 jmp prep_and_display_hint
   909                          
   910                          
   911                          
   912                          
   913                          
   914                          
   915                          ; ==============================================================================
   916                          ;
   917                          ;                                                             #        ###
   918                          ;          #####      ####      ####     #    #              ##       #   #
   919                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
   920                          ;          #    #    #    #    #    #    # ## #               #      #     #
   921                          ;          #####     #    #    #    #    #    #               #      #     #
   922                          ;          #   #     #    #    #    #    #    #               #       #   #
   923                          ;          #    #     ####      ####     #    #             #####      ###
   924                          ;
   925                          ; ==============================================================================
   926                          
   927                          room_10:
   928                          
   929  1394 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   930  1396 b005                                   bcs +
   931  1398 a000                                   ldy #$00                                    ; display hint
   932  139a 4c2c10                                 jmp prep_and_display_hint
   933                          
   934  139d c9cc               +                   cmp #$cc                                    ; hit the power outlet?
   935  139f f007                                   beq +                                       ; yes -> +
   936  13a1 c9cf                                   cmp #$cf                                    ; hit the power outlet?
   937  13a3 f003                                   beq +                                       ; yes -> +
   938  13a5 4ce511                                 jmp check_next_char_under_player            ; no, continue
   939  13a8 a9df               +                   lda #$df                                    
   940  13aa cd8a36                                 cmp items + $74                             ; light picked up?
   941  13ad d010                                   bne +                                       ; no -> death
   942  13af cdde36                                 cmp items + $c8                             ; yes, lightbulb picked up?
   943  13b2 d00b                                   bne +                                       ; no -> death
   944  13b4 8dc236                                 sta items + $ac                             ; yes, pick up power outlet
   945  13b7 a959                                   lda #$59                                    ; and make the foot traps visible
   946  13b9 8d4237                                 sta items + $12c                            ; color position for foot traps
   947  13bc 4ccf11                                 jmp check_death
   948                          
   949  13bf a006               +                   ldy #$06
   950  13c1 4ce33a                                 jmp death                                   ; 06 240 Volts! You got an electrical shock!
   951                          
   952                          
   953                          
   954                          
   955                          
   956                          
   957                          ; ==============================================================================
   958                          ;
   959                          ;                                                             #        #
   960                          ;          #####      ####      ####     #    #              ##       ##
   961                          ;          #    #    #    #    #    #    ##  ##             # #      # #
   962                          ;          #    #    #    #    #    #    # ## #               #        #
   963                          ;          #####     #    #    #    #    #    #               #        #
   964                          ;          #   #     #    #    #    #    #    #               #        #
   965                          ;          #    #     ####      ####     #    #             #####    #####
   966                          ;
   967                          ; ==============================================================================
   968                          
   969                          room_11:
   970                          
   971  13c4 c9d1                                   cmp #$d1                                    ; picking up the hammer?
   972  13c6 f003                                   beq +                                       ; jep
   973  13c8 4ce511                                 jmp check_next_char_under_player            ; no, continue
   974  13cb a9df               +                   lda #$df                                    ; player takes the hammer
   975  13cd 8dd136                                 sta items + $bb                             ; hammer
   976  13d0 4ccf11                                 jmp check_death
   977                          
   978                          
   979                          
   980                          
   981                          
   982                          
   983                          ; ==============================================================================
   984                          ;
   985                          ;                                                             #       #####
   986                          ;          #####      ####      ####     #    #              ##      #     #
   987                          ;          #    #    #    #    #    #    ##  ##             # #            #
   988                          ;          #    #    #    #    #    #    # ## #               #       #####
   989                          ;          #####     #    #    #    #    #    #               #      #
   990                          ;          #   #     #    #    #    #    #    #               #      #
   991                          ;          #    #     ####      ####     #    #             #####    #######
   992                          ;
   993                          ; ==============================================================================
   994                          
   995                          room_12:
   996                          
   997  13d3 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   998  13d5 b005                                   bcs +                                       ; no
   999  13d7 a000                                   ldy #$00                                    
  1000  13d9 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1001                          
  1002  13dc c9d2               +                   cmp #$d2                                    ; light bulb hit?
  1003  13de f007                                   beq +                                       ; yes
  1004  13e0 c9d5                                   cmp #$d5                                    ; light bulb hit?
  1005  13e2 f003                                   beq +                                       ; yes
  1006  13e4 4ce511                                 jmp check_next_char_under_player            ; no, continue
  1007  13e7 a9df               +                   lda #$df                                    ; pick up light bulb
  1008  13e9 8dde36                                 sta items + $c8
  1009  13ec 4ccf11                                 jmp check_death
  1010                          
  1011                          
  1012                          
  1013                          
  1014                          
  1015                          
  1016                          ; ==============================================================================
  1017                          ;
  1018                          ;                                                             #       #####
  1019                          ;          #####      ####      ####     #    #              ##      #     #
  1020                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1021                          ;          #    #    #    #    #    #    # ## #               #       #####
  1022                          ;          #####     #    #    #    #    #    #               #            #
  1023                          ;          #   #     #    #    #    #    #    #               #      #     #
  1024                          ;          #    #     ####      ####     #    #             #####     #####
  1025                          ;
  1026                          ; ==============================================================================
  1027                          
  1028                          room_13:           
  1029                          
  1030  13ef c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1031  13f1 b005                                   bcs +
  1032  13f3 a000                                   ldy #$00                                    ; message 0 to display
  1033  13f5 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1034                          
  1035  13f8 c9d6               +                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
  1036  13fa f003                                   beq +                                       ; OUCH!! -> +
  1037  13fc 4ce511                                 jmp check_next_char_under_player            ; not stepped into a nail... yet.
  1038  13ff ad9a36             +                   lda items + $84                             ; are the boots taken?
  1039  1402 c9df                                   cmp #$df                                
  1040  1404 f005                                   beq +                                       ; yeah I'm cool these boots are made for nailin'. 
  1041  1406 a007                                   ldy #$07                                    ; death by a thousand nails.
  1042  1408 4ce33a                                 jmp death                                   ; 07 You stepped on a nail!
  1043                          
  1044                          +
  1045  140b a9e2                                   lda #$e2                                    ; this is also a nail. 
  1046  140d 8deb36                                 sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
  1047  1410 4ccf11                                 jmp check_death
  1048                          
  1049                          
  1050                          
  1051                          
  1052                          
  1053                          
  1054                          ; ==============================================================================
  1055                          ;
  1056                          ;                                                             #      #
  1057                          ;          #####      ####      ####     #    #              ##      #    #
  1058                          ;          #    #    #    #    #    #    ##  ##             # #      #    #
  1059                          ;          #    #    #    #    #    #    # ## #               #      #    #
  1060                          ;          #####     #    #    #    #    #    #               #      #######
  1061                          ;          #   #     #    #    #    #    #    #               #           #
  1062                          ;          #    #     ####      ####     #    #             #####         #
  1063                          ;
  1064                          ; ==============================================================================
  1065                          
  1066                          room_14:
  1067                          
  1068  1413 c9d7                                   cmp #$d7                                    ; foot trap char
  1069  1415 f003                                   beq +                                       ; stepped into it?
  1070  1417 4ce511                                 jmp check_next_char_under_player            ; not... yet...
  1071  141a a008               +                   ldy #$08                                    ; go die
  1072  141c 4ce33a                                 jmp death                                   ; 08 A foot trap stopped you!
  1073                          
  1074                          
  1075                          
  1076                          
  1077                          
  1078                          
  1079                          ; ==============================================================================
  1080                          ;
  1081                          ;                                                             #      #######
  1082                          ;          #####      ####      ####     #    #              ##      #
  1083                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1084                          ;          #    #    #    #    #    #    # ## #               #      ######
  1085                          ;          #####     #    #    #    #    #    #               #            #
  1086                          ;          #   #     #    #    #    #    #    #               #      #     #
  1087                          ;          #    #     ####      ####     #    #             #####     #####
  1088                          ;
  1089                          ; ==============================================================================
  1090                          
  1091                          room_15:
  1092                          
  1093  141f c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1094  1421 b005                                   bcs +
  1095  1423 a000                                   ldy #$00                                    ; display hint
  1096  1425 4c2c10                                 jmp prep_and_display_hint
  1097                          
  1098  1428 4ce511             +                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address
  1099                          
  1100                          
  1101                          
  1102                          
  1103                          
  1104                          
  1105                          ; ==============================================================================
  1106                          ;
  1107                          ;                                                             #       #####
  1108                          ;          #####      ####      ####     #    #              ##      #     #
  1109                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1110                          ;          #    #    #    #    #    #    # ## #               #      ######
  1111                          ;          #####     #    #    #    #    #    #               #      #     #
  1112                          ;          #   #     #    #    #    #    #    #               #      #     #
  1113                          ;          #    #     ####      ####     #    #             #####     #####
  1114                          ;
  1115                          ; ==============================================================================
  1116                          
  1117                          room_16:
  1118                          
  1119  142b c9f4                                   cmp #$f4                                    ; did you hit the wall in the left cell?
  1120  142d d005                                   bne +                                       ; I did not! -> +
  1121  142f a00a                                   ldy #$0a                                    ; yeah....
  1122  1431 4ce33a                                 jmp death                                   ; 0a You were locked in and starved!
  1123                          
  1124  1434 c9d9               +                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
  1125  1436 f004                                   beq +                                       ; not that I know of...
  1126  1438 c9db                                   cmp #$db                                    ; are you sure? take a look at this slightly different wall
  1127  143a d005                                   bne ++                                      ; it doesn't look familiar... -> ++
  1128                          
  1129  143c a009               +                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
  1130  143e 4ce33a                                 jmp death
  1131                          
  1132  1441 c9b9               ++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
  1133  1443 f007                                   beq +                                       ; yes! -> +
  1134  1445 c9bb                                   cmp #$bb                                    ; here's another part of that bottle for reference
  1135  1447 f003                                   beq +                                       ; yes! -> +
  1136  1449 4ce511                                 jmp check_next_char_under_player            ; no, continue
  1137  144c a003               +                   ldy #$03                                    ; display code enter screen
  1138  144e 4c2c10                                 jmp prep_and_display_hint
  1139                          
  1140                          
  1141                          
  1142                          
  1143                          
  1144                          
  1145                          ; ==============================================================================
  1146                          ;
  1147                          ;                                                             #      #######
  1148                          ;          #####      ####      ####     #    #              ##      #    #
  1149                          ;          #    #    #    #    #    #    ##  ##             # #          #
  1150                          ;          #    #    #    #    #    #    # ## #               #         #
  1151                          ;          #####     #    #    #    #    #    #               #        #
  1152                          ;          #   #     #    #    #    #    #    #               #        #
  1153                          ;          #    #     ####      ####     #    #             #####      #
  1154                          ;
  1155                          ; ==============================================================================
  1156                          
  1157                          room_17:
  1158                          
  1159  1451 c9dd                                   cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
  1160  1453 f003                                   beq +                                       ; yup
  1161  1455 4ce511                                 jmp check_next_char_under_player            ; nah not yet.
  1162  1458 a9df               +                   lda #$df                                    ; pick up sword
  1163  145a 8dbd37                                 sta items + $1a7                            ; store in items list
  1164  145d 4ccf11                                 jmp check_death
  1165                          
  1166                          
  1167                          
  1168                          
  1169                          
  1170                          
  1171                          ; ==============================================================================
  1172                          ;
  1173                          ;                                                             #       #####
  1174                          ;          #####      ####      ####     #    #              ##      #     #
  1175                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
  1176                          ;          #    #    #    #    #    #    # ## #               #       #####
  1177                          ;          #####     #    #    #    #    #    #               #      #     #
  1178                          ;          #   #     #    #    #    #    #    #               #      #     #
  1179                          ;          #    #     ####      ####     #    #             #####     #####
  1180                          ;
  1181                          ; ==============================================================================
  1182                          
  1183                          room_18:
  1184  1460 c981                                   cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
  1185  1462 b003                                   bcs +                   
  1186  1464 4ccf11                                 jmp check_death
  1187                          
  1188  1467 ad9a12             +                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
  1189  146a d003                                   bne +                                       ; yes I actually did (flexes arms)
  1190  146c 4cd53a                                 jmp main_loop                               ; nope
  1191  146f 20263a             +                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
  1192  1472 4c3a1b                                 jmp print_endscreen                         ; (drops mic)
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
  1233                          
  1234                          ; ==============================================================================
  1235                          ; 
  1236                          ; EVERYTHING ANIMATION RELATED STARTS HERE
  1237                          ; ANIMATIONS FOR
  1238                          ; LASER, BORIS, BELEGRO, STONE, MONSTER
  1239                          ; ==============================================================================
  1240                          
  1241                          ; TODO
  1242                          ; this gets called all the time, no checks 
  1243                          ; needs to be optimized
  1244                          
  1245                          
  1246                          animation_entrypoint:
  1247                                              
  1248                                              ; code below is used to check if the foot traps should be visible
  1249                                              ; it checked for this every single fucking frame
  1250                                              ; moved the foot traps coloring where it belongs (when picking up power outlet)
  1251                                              ;lda items + $ac                         ; $cc (power outlet)
  1252                                              ;cmp #$df                                ; taken?
  1253                                              ;bne +                                   ; no -> +
  1254                                              ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
  1255                                              ;sta items + $12c                        ; originally $0
  1256                          
  1257  1475 acf82f             +                   ldy current_room + 1                    ; load room number
  1258                          
  1259  1478 c011                                   cpy #$11                                ; is it room #17? (Belegro)
  1260  147a d046                                   bne room_14_prep                         ; no -> m162A
  1261                                              
  1262                                              
  1263  147c ad1115                                 lda m14CC + 1                           ; yes, get value from m14CD
  1264  147f d013                                   bne m15FC                               ; 0? -> m15FC
  1265  1481 ad4035                                 lda player_pos_y + 1                    ; not 0, get player pos Y
  1266  1484 c906                                   cmp #$06                                ; is it 6?
  1267  1486 d00c                                   bne m15FC                               ; no -> m15FC
  1268  1488 ad4235                                 lda player_pos_x + 1                    ; yes, get player pos X
  1269  148b c918                                   cmp #$18                                ; is player x position $18?
  1270  148d d005                                   bne m15FC                               ; no -> m15FC
  1271  148f a900                                   lda #$00                                ; yes, load 0
  1272  1491 8d9514                                 sta m15FC + 1                           ; store 0 in m15FC+1
  1273  1494 a901               m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
  1274  1496 d016                                   bne +                                   ; is it 0? -> +
  1275  1498 a006                                   ldy #$06                                ; y = $6
  1276  149a a21e               m1602:              ldx #$1e                                ; x = $1e
  1277  149c a900                                   lda #$00                                ; a = $0
  1278  149e 85a7                                   sta zpA7                                ; zpA7 = 0
  1279  14a0 20c734                                 jsr draw_player                         ; TODO
  1280  14a3 ae9b14                                 ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
  1281  14a6 e003                                   cpx #$03                                ; is X = $3?
  1282  14a8 f001                                   beq ++                                  ; yes -> ++
  1283  14aa ca                                     dex                                     ; x = x -1
  1284  14ab 8e9b14             ++                  stx m1602 + 1                           ; store x in m1602+1
  1285  14ae a978               +                   lda #$78                                ; a = $78
  1286  14b0 85a8                                   sta zpA8                                ; zpA8 = $78
  1287  14b2 a949                                   lda #$49                                ; a = $49
  1288  14b4 850a                                   sta zp0A                                ; zp0A = $49
  1289  14b6 a006                                   ldy #$06                                ; y = $06
  1290  14b8 a901                                   lda #$01                                ; a = $01
  1291  14ba 85a7                                   sta zpA7                                ; zpA7 = $01
  1292  14bc ae9b14                                 ldx m1602 + 1                           ; get stored x value (should still be the same?)
  1293  14bf 20c734                                 jsr draw_player                         ; TODO
  1294                          
  1295                          
  1296                          room_14_prep:              
  1297  14c2 acf82f                                 ldy current_room + 1                    ; load room number
  1298  14c5 c00e                                   cpy #14                                 ; is it #14?
  1299  14c7 d005                                   bne room_15_prep                        ; no -> m148A
  1300  14c9 a020                                   ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
  1301  14cb 20ff39                                 jsr wait                                ; was jmp wait before
  1302                          
  1303                          ; ==============================================================================
  1304                          ; ROOM 15 ANIMATION
  1305                          ; MOVEMENT OF THE MONSTER
  1306                          ; ==============================================================================
  1307                          
  1308                          room_15_prep:              
  1309  14ce c00f                                   cpy #15                                 ; room 15?
  1310  14d0 d03a                                   bne room_17_prep                        ; no -> m14C8
  1311  14d2 a900                                   lda #$00                                ; 
  1312  14d4 85a7                                   sta zpA7
  1313  14d6 a00c                                   ldy #$0c                                ; x/y pos of the monster
  1314  14d8 a206               m1494:              ldx #$06
  1315  14da 20c734                                 jsr draw_player
  1316  14dd a9eb                                   lda #$eb                                ; the monster (try 9c for Belegro)
  1317  14df 85a8                                   sta zpA8
  1318  14e1 a939                                   lda #$39                                ; color of the monster's cape
  1319  14e3 850a                                   sta zp0A
  1320  14e5 aed914                                 ldx m1494 + 1                           ; self mod the x position of the monster
  1321  14e8 a901               m14A4:              lda #$01
  1322  14ea d00a                                   bne m14B2               
  1323  14ec e006                                   cpx #$06                                ; moved 6 steps?
  1324  14ee d002                                   bne +                                   ; no, keep moving
  1325  14f0 a901                                   lda #$01
  1326  14f2 ca                 +                   dex
  1327  14f3 4cfd14                                 jmp +                                   ; change direction
  1328                          
  1329                          m14B2:              
  1330  14f6 e00b                                   cpx #$0b
  1331  14f8 d002                                   bne ++
  1332  14fa a900                                   lda #$00
  1333  14fc e8                 ++                  inx
  1334  14fd 8ed914             +                   stx m1494 + 1
  1335  1500 8de914                                 sta m14A4 + 1
  1336  1503 a901                                   lda #$01
  1337  1505 85a7                                   sta zpA7
  1338  1507 a00c                                   ldy #$0c
  1339  1509 4cc734                                 jmp draw_player
  1340                                             
  1341                          ; ==============================================================================
  1342                          ; ROOM 17 ANIMATION
  1343                          ;
  1344                          ; ==============================================================================
  1345                          
  1346                          room_17_prep:              
  1347  150c c011                                   cpy #17                             ; room number 17?
  1348  150e d014                                   bne +                               ; no -> +
  1349  1510 a901               m14CC:              lda #$01                            ; selfmod
  1350  1512 f021                                   beq ++                              
  1351                                                                                 
  1352                                              ; was moved here
  1353                                              ; as it was called only from this place
  1354                                              ; jmp m15C1  
  1355  1514 a900               m15C1:              lda #$00                            ; a = 0 (selfmod)
  1356  1516 c900                                   cmp #$00                            ; is a = 0?
  1357  1518 d004                                   bne skipper                         ; not 0 -> 15CB
  1358  151a ee1515                                 inc m15C1 + 1                       ; inc m15C1
  1359  151d 60                                     rts
  1360                                       
  1361  151e ce1515             skipper:            dec m15C1 + 1                       ; dec $15c2
  1362  1521 4cb335                                 jmp belegro_animation
  1363                          
  1364  1524 a90f               +                   lda #$0f                            ; a = $0f
  1365  1526 8db835                                 sta m3624 + 1                       ; selfmod
  1366  1529 8dba35                                 sta m3626 + 1                       ; selfmod
  1367                          
  1368                          
  1369  152c c00a                                   cpy #10                             ; room number 10?
  1370  152e d044                                   bne check_if_room_09                ; no -> m1523
  1371  1530 ceb82f                                 dec speed_byte                      ; yes, reduce speed
  1372  1533 f001                                   beq laser_beam_animation            ; if positive -> laser_beam_animation            
  1373  1535 60                 ++                  rts
  1374                          
  1375                          ; ==============================================================================
  1376                          ; ROOM 10
  1377                          ; LASER BEAM ANIMATION
  1378                          ; ==============================================================================
  1379                          
  1380                          laser_beam_animation:
  1381                          
  1382  1536 a008                                   ldy #$08                            ; speed of the laser flashing
  1383  1538 8cb82f                                 sty speed_byte                      ; store     
  1384  153b a909                                   lda #$09
  1385  153d 8505                                   sta zp05                            ; affects the colram of the laser
  1386  153f a90d                                   lda #$0d                            ; but not understood yet
  1387  1541 8503                                   sta zp03
  1388  1543 a97b                                   lda #$7b                            ; position of the laser
  1389  1545 8502                                   sta zp02
  1390  1547 8504                                   sta zp04
  1391  1549 a9df                                   lda #$df                            ; laser beam off
  1392  154b cd5815                                 cmp m1506 + 1                       
  1393  154e d002                                   bne +                               
  1394  1550 a9d8                                   lda #$d8                            ; laser beam
  1395  1552 8d5815             +                   sta m1506 + 1                       
  1396  1555 a206                                   ldx #$06                            ; 6 laser beam characters
  1397  1557 a9df               m1506:              lda #$df
  1398  1559 a000                                   ldy #$00
  1399  155b 9102                                   sta (zp02),y
  1400  155d a9ee                                   lda #$ee
  1401  155f 9104                                   sta (zp04),y
  1402  1561 a502                                   lda zp02
  1403  1563 18                                     clc
  1404  1564 6928                                   adc #$28                            ; draws the laser beam
  1405  1566 8502                                   sta zp02
  1406  1568 8504                                   sta zp04
  1407  156a 9004                                   bcc +                               
  1408  156c e603                                   inc zp03
  1409  156e e605                                   inc zp05
  1410  1570 ca                 +                   dex
  1411  1571 d0e4                                   bne m1506                           
  1412  1573 60                 -                   rts
  1413                          
  1414                          ; ==============================================================================
  1415                          
  1416                          check_if_room_09:              
  1417  1574 c009                                   cpy #09                         ; room number 09?
  1418  1576 f001                                   beq room_09_counter                           ; yes -> +
  1419  1578 60                                     rts                             ; no
  1420                          
  1421                          room_09_counter:
  1422  1579 a201                                   ldx #$01                                ; x = 1 (selfmod)
  1423  157b e001                                   cpx #$01                                ; is x = 1?
  1424  157d f003                                   beq +                                   ; yes -> +
  1425  157f 4c9a15                                 jmp boris_the_spider_animation          ; no, jump boris animation
  1426  1582 ce7a15             +                   dec room_09_counter + 1                 ; decrease initial x
  1427  1585 60                                     rts
  1428                          
  1429                          ; ==============================================================================
  1430                          ;
  1431                          ; I moved this out of the main loop and call it once when changing rooms
  1432                          ; TODO: call it only when room 4 is entered
  1433                          ; ==============================================================================
  1434                          
  1435                          room_04_prep_door:
  1436                                              
  1437  1586 adf82f                                 lda current_room + 1                            ; get current room
  1438  1589 c904                                   cmp #04                                         ; is it 4? (coffins)
  1439  158b d00c                                   bne ++                                          ; nope
  1440  158d a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  1441  158f ac0339                                 ldy m394A + 1                                   ; 
  1442  1592 f002                                   beq +
  1443  1594 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  1444  1596 8df904             +                   sta SCREENRAM + $f9 
  1445  1599 60                 ++                  rts
  1446                          
  1447                          ; ==============================================================================
  1448                          ; ROOM 09
  1449                          ; BORIS THE SPIDER ANIMATION
  1450                          ; ==============================================================================
  1451                          
  1452                          boris_the_spider_animation:
  1453                          
  1454  159a ee7a15                                 inc room_09_counter + 1                           
  1455  159d a908                                   lda #$08                                ; affects the color ram position for boris the spider
  1456  159f 8505                                   sta zp05
  1457  15a1 a90c                                   lda #$0c
  1458  15a3 8503                                   sta zp03
  1459  15a5 a90f                                   lda #$0f
  1460  15a7 8502                                   sta zp02
  1461  15a9 8504                                   sta zp04
  1462  15ab a206               m1535:              ldx #$06
  1463  15ad a900               m1537:              lda #$00
  1464  15af d009                                   bne +
  1465  15b1 ca                                     dex
  1466  15b2 e002                                   cpx #$02
  1467  15b4 d00b                                   bne ++
  1468  15b6 a901                                   lda #$01
  1469  15b8 d007                                   bne ++
  1470  15ba e8                 +                   inx
  1471  15bb e007                                   cpx #$07
  1472  15bd d002                                   bne ++
  1473  15bf a900                                   lda #$00
  1474  15c1 8dae15             ++                  sta m1537 + 1
  1475  15c4 8eac15                                 stx m1535 + 1
  1476  15c7 a000               -                   ldy #$00
  1477  15c9 a9df                                   lda #$df
  1478  15cb 9102                                   sta (zp02),y
  1479  15cd c8                                     iny
  1480  15ce c8                                     iny
  1481  15cf 9102                                   sta (zp02),y
  1482  15d1 88                                     dey
  1483  15d2 a9ea                                   lda #$ea
  1484  15d4 9102                                   sta (zp02),y
  1485  15d6 9104                                   sta (zp04),y
  1486  15d8 201316                                 jsr move_boris                       
  1487  15db ca                                     dex
  1488  15dc d0e9                                   bne -
  1489  15de a9e4                                   lda #$e4
  1490  15e0 85a8                                   sta zpA8
  1491  15e2 a202                                   ldx #$02
  1492  15e4 a000               --                  ldy #$00
  1493  15e6 a5a8               -                   lda zpA8
  1494  15e8 9102                                   sta (zp02),y
  1495  15ea a9da                                   lda #$da
  1496  15ec 9104                                   sta (zp04),y
  1497  15ee e6a8                                   inc zpA8
  1498  15f0 c8                                     iny
  1499  15f1 c003                                   cpy #$03
  1500  15f3 d0f1                                   bne -
  1501  15f5 201316                                 jsr move_boris                       
  1502  15f8 ca                                     dex
  1503  15f9 d0e9                                   bne --
  1504  15fb a000                                   ldy #$00
  1505  15fd a9e7                                   lda #$e7
  1506  15ff 85a8                                   sta zpA8
  1507  1601 b102               -                   lda (zp02),y
  1508  1603 c5a8                                   cmp zpA8
  1509  1605 d004                                   bne +
  1510  1607 a9df                                   lda #$df
  1511  1609 9102                                   sta (zp02),y
  1512  160b e6a8               +                   inc zpA8
  1513  160d c8                                     iny
  1514  160e c003                                   cpy #$03
  1515  1610 d0ef                                   bne -
  1516  1612 60                                     rts
  1517                          
  1518                          ; ==============================================================================
  1519                          
  1520                          move_boris:
  1521  1613 a502                                   lda zp02
  1522  1615 18                                     clc
  1523  1616 6928                                   adc #$28
  1524  1618 8502                                   sta zp02
  1525  161a 8504                                   sta zp04
  1526  161c 9004                                   bcc +                                   
  1527  161e e603                                   inc zp03
  1528  1620 e605                                   inc zp05
  1529  1622 60                 +                   rts
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
  1549                          
  1550                          ; ==============================================================================
  1551                          
  1552                          prep_player_pos:
  1553                          
  1554  1623 a209                                   ldx #$09
  1555  1625 bd4403             -                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
  1556  1628 9d5403                                 sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
  1557  162b ca                                     dex
  1558  162c d0f7                                   bne -                                   ; so this seems to create a copy of the area under the player
  1559                          
  1560  162e a902                                   lda #$02                                ; a = 2
  1561  1630 85a7                                   sta zpA7
  1562  1632 ae4235                                 ldx player_pos_x + 1                    ; x = player x
  1563  1635 ac4035                                 ldy player_pos_y + 1                    ; y = player y
  1564  1638 20c734                                 jsr draw_player                         ; draw player
  1565  163b 60                                     rts
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
  1586                          
  1587                          ; ==============================================================================
  1588                          ; OBJECT ANIMATION COLLISION ROUTINE
  1589                          ; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
  1590                          ; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
  1591                          ; ==============================================================================
  1592                          
  1593                          object_collision:
  1594                          
  1595  163c a209                                   ldx #$09                                ; x = 9
  1596                          
  1597                          check_loop:              
  1598                          
  1599  163e bd4403                                 lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1600  1641 c9d8                                   cmp #$d8                                ; check for laser beam
  1601  1643 d005                                   bne +                  
  1602                          
  1603  1645 a005               m164E:              ldy #$05
  1604  1647 4ce33a             jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?
  1605                          
  1606  164a acf82f             +                   ldy current_room + 1                    ; get room number
  1607  164d c011                                   cpy #17                                 ; is it $11 = #17 (Belegro)?
  1608  164f d010                                   bne +                                   ; nope -> +
  1609  1651 c978                                   cmp #$78                                ; hit by the stone?
  1610  1653 f008                                   beq ++                                  ; yep -> ++
  1611  1655 c97b                                   cmp #$7b                                ; or another part of the stone?
  1612  1657 f004                                   beq ++                                  ; yes -> ++
  1613  1659 c97e                                   cmp #$7e                                ; or another part of the stone?
  1614  165b d004                                   bne +                                   ; nah, -> +
  1615  165d a00b               ++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
  1616  165f d0e6                                   bne jmp_death
  1617  1661 c99c               +                   cmp #$9c                                ; so Belegro hit you?
  1618  1663 9007                                   bcc m1676
  1619  1665 c9a5                                   cmp #$a5
  1620  1667 b003                                   bcs m1676
  1621  1669 4c9d16                                 jmp m16A7
  1622                          
  1623  166c c9e4               m1676:              cmp #$e4                                ; hit by Boris the spider?
  1624  166e 9010                                   bcc +                           
  1625  1670 c9eb                                   cmp #$eb
  1626  1672 b004                                   bcs ++                          
  1627  1674 a004               -                   ldy #$04                                ; 04 Boris the spider got you and killed you
  1628  1676 d0cf                                   bne jmp_death                       
  1629  1678 c9f4               ++                  cmp #$f4
  1630  167a b004                                   bcs +                           
  1631  167c a00e                                   ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
  1632  167e d0c7                                   bne jmp_death                       
  1633  1680 ca                 +                   dex
  1634  1681 d0bb                                   bne check_loop   
  1635                          
  1636                          
  1637                          
  1638  1683 a209                                   ldx #$09
  1639  1685 bd5403             --                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
  1640  1688 9d4403                                 sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1641  168b c9d8                                   cmp #$d8
  1642  168d f0b6                                   beq m164E                       
  1643  168f c9e4                                   cmp #$e4
  1644  1691 9004                                   bcc +                           
  1645  1693 c9ea                                   cmp #$ea
  1646  1695 90dd                                   bcc -                           
  1647  1697 ca                 +                   dex
  1648  1698 d0eb                                   bne --                          
  1649  169a 4cd511                                 jmp m11E0                     
  1650                          
  1651                          m16A7:
  1652  169d acbd37                                 ldy items + $1a7                        ; do you have the sword?
  1653  16a0 c0df                                   cpy #$df
  1654  16a2 f004                                   beq +                                   ; yes -> +                        
  1655  16a4 a00c                                   ldy #$0c                                ; 0c Belegro killed you!
  1656  16a6 d09f                                   bne jmp_death                       
  1657  16a8 a000               +                   ldy #$00
  1658  16aa 8c1115                                 sty m14CC + 1                   
  1659  16ad 4c6c16                                 jmp m1676                       
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
  1696                          
  1697                          ; ==============================================================================
  1698                          ; this might be the inventory/ world reset
  1699                          ; puts all items into the level data again
  1700                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1701                          ; addresses are mostly within items.asm address space ( $368a )
  1702                          ; contains color information of the chars
  1703                          ; ==============================================================================
  1704                          
  1705                          reset_items:
  1706  16b0 a9a5                                   lda #$a5                        ; $a5 = lock of the shed
  1707  16b2 8d4e36                                 sta items + $38
  1708                          
  1709  16b5 a9a9                                   lda #$a9                        ;
  1710  16b7 8d1e36                                 sta items + $8                  ; gloves
  1711  16ba a979                                   lda #$79
  1712  16bc 8d1c36                                 sta items + $6                  ; gloves color
  1713                          
  1714  16bf a9e0                                   lda #$e0                        ; empty char
  1715  16c1 8d2636                                 sta items + $10                 ; invisible key
  1716                          
  1717  16c4 a9ac                                   lda #$ac                        ; wirecutter
  1718  16c6 8d2f36                                 sta items + $19
  1719                          
  1720  16c9 a9b8                                   lda #$b8                        ; bottle
  1721  16cb 8d3f36                                 sta items + $29
  1722                          
  1723  16ce a9b0                                   lda #$b0                        ; ladder
  1724  16d0 8d6336                                 sta items + $4d
  1725  16d3 a9b5                                   lda #$b5                        ; more ladder
  1726  16d5 8d6e36                                 sta items + $58
  1727                          
  1728  16d8 a95e                                   lda #$5e                        ; seems to be water?
  1729  16da 8d8a36                                 sta items + $74
  1730                          
  1731  16dd a9c6                                   lda #$c6                        ; boots in the whatever box
  1732  16df 8d9a36                                 sta items + $84
  1733                          
  1734  16e2 a9c0                                   lda #$c0                        ; shovel
  1735  16e4 8dac36                                 sta items + $96
  1736                          
  1737  16e7 a9cc                                   lda #$cc                        ; power outlet
  1738  16e9 8dc236                                 sta items + $ac
  1739                          
  1740  16ec a9d0                                   lda #$d0                        ; hammer
  1741  16ee 8dd136                                 sta items + $bb
  1742                          
  1743  16f1 a9d2                                   lda #$d2                        ; light bulb
  1744  16f3 8dde36                                 sta items + $c8
  1745                          
  1746  16f6 a9d6                                   lda #$d6                        ; nails
  1747  16f8 8deb36                                 sta items + $d5
  1748                          
  1749  16fb a900                                   lda #$00                        ; door
  1750  16fd 8d4237                                 sta items + $12c
  1751                          
  1752  1700 a9dd                                   lda #$dd                        ; sword
  1753  1702 8dbd37                                 sta items + $1a7
  1754                          
  1755  1705 a901                                   lda #$01                        ; -> wrong write, produced selfmod at the wrong place
  1756  1707 8d0339                                 sta m394A + 1                   ; sta items + $2c1
  1757                          
  1758  170a a901                                   lda #$01                        ; 
  1759  170c 8d9138                                 sta breathing_tube_mod + 1      ; sta items + $30a
  1760                          
  1761  170f a9f5                                   lda #$f5                        ; fence
  1762  1711 8db538                                 sta delete_fence + 1            ; sta items + $277
  1763                          
  1764  1714 a900                                   lda #$00                        ; key in the bottle
  1765  1716 8d9a12                                 sta key_in_bottle_storage
  1766                          
  1767  1719 a901                                   lda #$01                        ; door
  1768  171b 8d9514                                 sta m15FC + 1
  1769                          
  1770  171e a91e                                   lda #$1e
  1771  1720 8d9b14                                 sta m1602 + 1
  1772                          
  1773  1723 a901                                   lda #$01
  1774  1725 8d1115                                 sta m14CC + 1
  1775                          
  1776  1728 a205               m1732:              ldx #$05
  1777  172a e007                                   cpx #$07
  1778  172c d002                                   bne +
  1779  172e a2ff                                   ldx #$ff
  1780  1730 e8                 +                   inx
  1781  1731 8e2917                                 stx m1732 + 1                           ; stx $1733
  1782  1734 bd3d17                                 lda m1747,x                             ; lda $1747,x
  1783  1737 8d0b39                                 sta m3952 + 1                   ; sta $3953
  1784  173a 4cb030                                 jmp print_title     ; jmp $310d
  1785                                              
  1786                          ; ==============================================================================
  1787                          
  1788                          m1747:
  1789  173d 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1790                          
  1791                          
  1792                          m174F:
  1793  1745 e00c                                   cpx #$0c
  1794  1747 d002                                   bne +
  1795  1749 a949                                   lda #$49
  1796  174b e00d               +                   cpx #$0d
  1797  174d d002                                   bne +
  1798  174f a945                                   lda #$45
  1799  1751 60                 +                   rts
  1800                          
  1801                          
  1802                          
  1803                          screen_win_src:
  1804                                              !if LANGUAGE = EN{
  1805  1752 7040404040404040...                        !bin "includes/screen-win-en.scr"
  1806                                              }
  1807                                              !if LANGUAGE = DE{
  1808                                                  !bin "includes/screen-win-de.scr"
  1809                                              }
  1810                          screen_win_src_end:
  1811                          
  1812                          
  1813                          ; ==============================================================================
  1814                          ;
  1815                          ; PRINT WIN SCREEN
  1816                          ; ==============================================================================
  1817                          
  1818                          print_endscreen:
  1819  1b3a a904                                   lda #>SCREENRAM
  1820  1b3c 8503                                   sta zp03
  1821  1b3e a9d8                                   lda #>COLRAM
  1822  1b40 8505                                   sta zp05
  1823  1b42 a900                                   lda #<SCREENRAM
  1824  1b44 8502                                   sta zp02
  1825  1b46 8504                                   sta zp04
  1826  1b48 a204                                   ldx #$04
  1827  1b4a a917                                   lda #>screen_win_src
  1828  1b4c 85a8                                   sta zpA8
  1829  1b4e a952                                   lda #<screen_win_src
  1830  1b50 85a7                                   sta zpA7
  1831  1b52 a000                                   ldy #$00
  1832  1b54 b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1833  1b56 9102                                   sta (zp02),y        ; to SCREEN
  1834  1b58 a900                                   lda #$00            ; color = BLACK
  1835  1b5a 9104                                   sta (zp04),y        ; to COLRAM
  1836  1b5c c8                                     iny
  1837  1b5d d0f5                                   bne -
  1838  1b5f e603                                   inc zp03
  1839  1b61 e605                                   inc zp05
  1840  1b63 e6a8                                   inc zpA8
  1841  1b65 ca                                     dex
  1842  1b66 d0ec                                   bne -
  1843  1b68 a907                                   lda #$07                  ; yellow
  1844  1b6a 8d21d0                                 sta BG_COLOR              ; background
  1845  1b6d 8d20d0                                 sta BORDER_COLOR          ; und border
  1846  1b70 a9fd               -                   lda #$fd
  1847  1b72 8d08ff                                 sta KEYBOARD_LATCH
  1848  1b75 ad08ff                                 lda KEYBOARD_LATCH
  1849  1b78 2980                                   and #$80           ; WAITKEY?
  1850  1b7a d0f4                                   bne -
  1851  1b7c 20b030                                 jsr print_title
  1852  1b7f 20b030                                 jsr print_title
  1853  1b82 4c423a                                 jmp init
  1854                          
  1855                          
  1856                          ; ==============================================================================
  1857                          ;
  1858                          ; INTRO TEXT SCREEN
  1859                          ; ==============================================================================
  1860                          
  1861                          intro_text:
  1862                          
  1863                          ; instructions screen
  1864                          ; "Search the treasure..."
  1865                          
  1866                          !if LANGUAGE = EN{
  1867  1b85 5305011203082014...!scr "Search the treasure of Ghost Town and   "
  1868  1bad 0f10050e20091420...!scr "open it ! Kill Belegro, the wizard, and "
  1869  1bd5 040f04070520010c...!scr "dodge all other dangers. Don't forget to"
  1870  1bfd 15130520010c0c20...!scr "use all the items you'll find during    "
  1871  1c25 190f1512200a0f15...!scr "your journey through 19 amazing hires-  "
  1872  1c4d 0712011008090313...!scr "graphics-rooms! Enjoy the quest and play"
  1873  1c75 091420010701090e...!scr "it again and again and again ...      > "
  1874                          }
  1875                          
  1876                          !if LANGUAGE = DE{
  1877                          !scr "Suchen Sie die Schatztruhe der Geister- "
  1878                          !scr "stadt und oeffnen Sie diese ! Toeten    "
  1879                          !scr "Sie Belegro, den Zauberer und weichen   "
  1880                          !scr "Sie vielen anderen Wesen geschickt aus. "
  1881                          !scr "Bedienen Sie sich an den vielen Gegen-  "
  1882                          !scr "staenden, welche sich in den 19 Bildern "
  1883                          !scr "befinden. Viel Spass !                > "
  1884                          }
  1885                          
  1886                          ; ==============================================================================
  1887                          ;
  1888                          ; DISPLAY INTRO TEXT
  1889                          ; ==============================================================================
  1890                          
  1891                          display_intro_text:
  1892                          
  1893                                              ; i think this part displays the introduction text
  1894                          
  1895  1c9d a904                                   lda #>SCREENRAM       ; lda #$0c
  1896  1c9f 8503                                   sta zp03
  1897  1ca1 a9d8                                   lda #>COLRAM        ; lda #$08
  1898  1ca3 8505                                   sta zp05
  1899  1ca5 a9a0                                   lda #$a0
  1900  1ca7 8502                                   sta zp02
  1901  1ca9 8504                                   sta zp04
  1902  1cab a91b                                   lda #>intro_text
  1903  1cad 85a8                                   sta zpA8
  1904  1caf a985                                   lda #<intro_text
  1905  1cb1 85a7                                   sta zpA7
  1906  1cb3 a207                                   ldx #$07
  1907  1cb5 a000               --                  ldy #$00
  1908  1cb7 b1a7               -                   lda (zpA7),y
  1909  1cb9 9102                                   sta (zp02),y
  1910  1cbb a968                                   lda #$68
  1911  1cbd 9104                                   sta (zp04),y
  1912  1cbf c8                                     iny
  1913  1cc0 c028                                   cpy #$28
  1914  1cc2 d0f3                                   bne -
  1915  1cc4 a5a7                                   lda zpA7
  1916  1cc6 18                                     clc
  1917  1cc7 6928                                   adc #$28
  1918  1cc9 85a7                                   sta zpA7
  1919  1ccb 9002                                   bcc +
  1920  1ccd e6a8                                   inc zpA8
  1921  1ccf a502               +                   lda zp02
  1922  1cd1 18                                     clc
  1923  1cd2 6950                                   adc #$50
  1924  1cd4 8502                                   sta zp02
  1925  1cd6 8504                                   sta zp04
  1926  1cd8 9004                                   bcc +
  1927  1cda e603                                   inc zp03
  1928  1cdc e605                                   inc zp05
  1929  1cde ca                 +                   dex
  1930  1cdf d0d4                                   bne --
  1931  1ce1 a900                                   lda #$00
  1932  1ce3 8d21d0                                 sta BG_COLOR
  1933  1ce6 60                                     rts
  1934                          
  1935                          ; ==============================================================================
  1936                          ;
  1937                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1938                          ; DECREASES MUSIC VOLUME
  1939                          ; ==============================================================================
  1940                          
  1941                          start_intro:        ;sta KEYBOARD_LATCH
  1942  1ce7 20d2ff                                 jsr PRINT_KERNAL
  1943  1cea 209d1c                                 jsr display_intro_text
  1944  1ced 20c91e                                 jsr check_shift_key
  1945                                              
  1946                                              ;lda #$ba
  1947                                              ;sta music_volume+1                          ; sound volume
  1948  1cf0 60                                     rts
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
  1982                          
  1983                          ; ==============================================================================
  1984                          ; MUSIC
  1985                          ; ==============================================================================
  1986                                              !zone MUSIC

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
  1988                          ; ==============================================================================
  1989                          music_get_data:
  1990  1daf a000               .voice1_dur_pt:     ldy #$00
  1991  1db1 d01d                                   bne +
  1992  1db3 a940                                   lda #$40
  1993  1db5 8d161e                                 sta music_voice1+1
  1994  1db8 20151e                                 jsr music_voice1
  1995  1dbb a200               .voice1_dat_pt:     ldx #$00
  1996  1dbd bdf11c                                 lda music_data_voice1,x
  1997  1dc0 eebc1d                                 inc .voice1_dat_pt+1
  1998  1dc3 a8                                     tay
  1999  1dc4 291f                                   and #$1f
  2000  1dc6 8d161e                                 sta music_voice1+1
  2001  1dc9 98                                     tya
  2002  1dca 4a                                     lsr
  2003  1dcb 4a                                     lsr
  2004  1dcc 4a                                     lsr
  2005  1dcd 4a                                     lsr
  2006  1dce 4a                                     lsr
  2007  1dcf a8                                     tay
  2008  1dd0 88                 +                   dey
  2009  1dd1 8cb01d                                 sty .voice1_dur_pt + 1
  2010  1dd4 a000               .voice2_dur_pt:     ldy #$00
  2011  1dd6 d022                                   bne +
  2012  1dd8 a940                                   lda #$40
  2013  1dda 8d3e1e                                 sta music_voice2 + 1
  2014  1ddd 203d1e                                 jsr music_voice2
  2015  1de0 a200               .voice2_dat_pt:     ldx #$00
  2016  1de2 bd4b1d                                 lda music_data_voice2,x
  2017  1de5 a8                                     tay
  2018  1de6 e8                                     inx
  2019  1de7 e065                                   cpx #$65
  2020  1de9 f019                                   beq music_reset
  2021  1deb 8ee11d                                 stx .voice2_dat_pt + 1
  2022  1dee 291f                                   and #$1f
  2023  1df0 8d3e1e                                 sta music_voice2 + 1
  2024  1df3 98                                     tya
  2025  1df4 4a                                     lsr
  2026  1df5 4a                                     lsr
  2027  1df6 4a                                     lsr
  2028  1df7 4a                                     lsr
  2029  1df8 4a                                     lsr
  2030  1df9 a8                                     tay
  2031  1dfa 88                 +                   dey
  2032  1dfb 8cd51d                                 sty .voice2_dur_pt + 1
  2033  1dfe 20151e                                 jsr music_voice1
  2034  1e01 4c3d1e                                 jmp music_voice2
  2035                          ; ==============================================================================
  2036  1e04 a900               music_reset:        lda #$00
  2037  1e06 8db01d                                 sta .voice1_dur_pt + 1
  2038  1e09 8dbc1d                                 sta .voice1_dat_pt + 1
  2039  1e0c 8dd51d                                 sta .voice2_dur_pt + 1
  2040  1e0f 8de11d                                 sta .voice2_dat_pt + 1
  2041  1e12 4caf1d                                 jmp music_get_data
  2042                          ; ==============================================================================
  2043                          ; write music data for voice1 / voice2 into TED registers
  2044                          ; ==============================================================================
  2045  1e15 a204               music_voice1:       ldx #$04
  2046  1e17 e01c                                   cpx #$1c
  2047  1e19 9008                                   bcc +
  2048  1e1b ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2049  1e1e 29ef                                   and #$ef
  2050  1e20 4c391e                                 jmp writeFF11
  2051  1e23 bd651e             +                   lda freq_tab_lo,x
  2052  1e26 8d0eff                                 sta VOICE1_FREQ_LOW
  2053  1e29 ad12ff                                 lda VOICE1
  2054  1e2c 29fc                                   and #$fc
  2055  1e2e 1d7d1e                                 ora freq_tab_hi, x
  2056  1e31 8d12ff                                 sta VOICE1
  2057  1e34 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2058  1e37 0910                                   ora #$10
  2059  1e39 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  2060  1e3c 60                                     rts
  2061                          ; ==============================================================================
  2062  1e3d a20d               music_voice2:       ldx #$0d
  2063  1e3f e01c                                   cpx #$1c
  2064  1e41 9008                                   bcc +
  2065  1e43 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2066  1e46 29df                                   and #$df
  2067  1e48 4c391e                                 jmp writeFF11
  2068  1e4b bd651e             +                   lda freq_tab_lo,x
  2069  1e4e 8d0fff                                 sta VOICE2_FREQ_LOW
  2070  1e51 ad10ff                                 lda VOICE2
  2071  1e54 29fc                                   and #$fc
  2072  1e56 1d7d1e                                 ora freq_tab_hi,x
  2073  1e59 8d10ff                                 sta VOICE2
  2074  1e5c ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2075  1e5f 0920                                   ora #$20
  2076  1e61 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2077  1e64 60                                     rts
  2078                          ; ==============================================================================
  2079                          ; TED frequency tables
  2080                          ; ==============================================================================
  2081  1e65 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  2082  1e6c 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  2083  1e73 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  2084  1e7a 818f95                                 !byte $81, $8f, $95
  2085  1e7d 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  2086  1e84 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  2087  1e8b 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  2088  1e92 030303                                 !byte $03, $03, $03
  2089                          ; ==============================================================================
  2090                                              MUSIC_DELAY_INITIAL   = $09
  2091                                              MUSIC_DELAY           = $0B
  2092  1e95 a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  2093  1e97 ca                                     dex
  2094  1e98 8e961e                                 stx music_play+1
  2095  1e9b f001                                   beq +
  2096  1e9d 60                                     rts
  2097  1e9e a20b               +                   ldx #MUSIC_DELAY
  2098  1ea0 8e961e                                 stx music_play+1
  2099  1ea3 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2100  1ea6 0937                                   ora #$37
  2101  1ea8 29bf               music_volume:       and #$bf
  2102  1eaa 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2103  1ead 4caf1d                                 jmp music_get_data
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
  2135                          
  2136                          ; ==============================================================================
  2137                          ; irq init
  2138                          ; ==============================================================================
  2139                                              !zone IRQ
  2140  1eb0 78                 irq_init0:          sei
  2141  1eb1 a9d0                                   lda #<irq0          ; lda #$06
  2142  1eb3 8d1403                                 sta $0314          ; irq lo
  2143  1eb6 a91e                                   lda #>irq0          ; lda #$1f
  2144  1eb8 8d1503                                 sta $0315          ; irq hi
  2145                                                                  ; irq at $1F06
  2146  1ebb a902                                   lda #$02
  2147  1ebd 8d0aff                                 sta FF0A          ; set IRQ source to RASTER
  2148                          
  2149  1ec0 a9bf                                   lda #$bf
  2150  1ec2 8da91e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  2151  1ec5 58                                     cli
  2152                          
  2153  1ec6 4c263a                                 jmp set_charset_and_screen
  2154                          
  2155                          ; ==============================================================================
  2156                          ; intro text
  2157                          ; wait for shift or joy2 fire press
  2158                          ; ==============================================================================
  2159                          
  2160                          check_shift_key:
  2161                          
  2162  1ec9 a5cb               -                   lda $cb
  2163  1ecb c93c                                   cmp #$3c
  2164  1ecd d0fa                                   bne -
  2165  1ecf 60                                     rts
  2166                          
  2167                          ; ==============================================================================
  2168                          ;
  2169                          ; INTERRUPT routine for music
  2170                          ; ==============================================================================
  2171                          
  2172                                              ; *= $1F06
  2173                          irq0:
  2174  1ed0 ce09ff                                 DEC INTERRUPT
  2175                          
  2176                                                                  ; this IRQ seems to handle music only!
  2177                                              !if SILENT_MODE = 1 {
  2178                                                  jsr fake
  2179                                              } else {
  2180  1ed3 20951e                                     jsr music_play
  2181                                              }
  2182  1ed6 68                                     pla
  2183  1ed7 a8                                     tay
  2184  1ed8 68                                     pla
  2185  1ed9 aa                                     tax
  2186  1eda 68                                     pla
  2187  1edb 40                                     rti
  2188                          
  2189                          ; ==============================================================================
  2190                          ; checks if the music volume is at the desired level
  2191                          ; and increases it if not
  2192                          ; if volume is high enough, it initializes the music irq routine
  2193                          ; is called right at the start of the game, but also when a game ended
  2194                          ; and is about to show the title screen again (increasing the volume)
  2195                          ; ==============================================================================
  2196                          
  2197                          init_music:                                  
  2198  1edc ada91e                                 lda music_volume+1                              ; sound volume
  2199  1edf c9bf               --                  cmp #$bf                                        ; is true on init
  2200  1ee1 d003                                   bne +
  2201  1ee3 4cb01e                                 jmp irq_init0
  2202  1ee6 a204               +                   ldx #$04
  2203  1ee8 86a8               -                   stx zpA8                                        ; buffer serial input byte ?
  2204  1eea a0ff                                   ldy #$ff
  2205  1eec 20ff39                                 jsr wait
  2206  1eef a6a8                                   ldx zpA8
  2207  1ef1 ca                                     dex
  2208  1ef2 d0f4                                   bne -                                               
  2209  1ef4 18                                     clc
  2210  1ef5 6901                                   adc #$01                                        ; increases volume again before returning to title screen
  2211  1ef7 8da91e                                 sta music_volume+1                              ; sound volume
  2212  1efa 4cdf1e                                 jmp --
  2213                          
  2214                          
  2215                          
  2216                                              ; 222222222222222         000000000          000000000          000000000
  2217                                              ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
  2218                                              ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2219                                              ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2220                                              ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2221                                              ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2222                                              ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2223                                              ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2224                                              ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2225                                              ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2226                                              ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2227                                              ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2228                                              ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2229                                              ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2230                                              ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
  2231                                              ;22222222222222222222     000000000          000000000          000000000
  2232                          
  2233                          ; ==============================================================================
  2234                          ; CHARSET
  2235                          ; $2000 - $2800
  2236                          ; ==============================================================================
  2237                          
  2238                          
  2239                          charset_start:
  2240                                              *= $2000
  2241                                              !if EXTENDED {
  2242                                                  !bin "includes/charset-new-charset.bin"
  2243                                              }else{
  2244  2000 000000020a292727...                        !bin "includes/charset.bin"
  2245                                              }
  2246                          charset_end:    ; $2800
  2247                          
  2248                          
  2249                                              ; 222222222222222         888888888          000000000           000000000
  2250                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  2251                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  2252                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2253                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2254                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2255                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  2256                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2257                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2258                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2259                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2260                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2261                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2262                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  2263                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  2264                                              ;22222222222222222222     888888888           000000000           000000000
  2265                          
  2266                          
  2267                          
  2268                          ; ==============================================================================
  2269                          ; LEVEL DATA
  2270                          ; Based on tiles
  2271                          ;                     !IMPORTANT!
  2272                          ;                     has to be page aligned or
  2273                          ;                     display_room routine will fail
  2274                          ; ==============================================================================
  2275                          
  2276                                              *= $2800
  2277                          level_data:

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
  2279                          level_data_end:
  2280                          
  2281                          
  2282                          ;$2fbf
  2283                          speed_byte:
  2284  2fb8 01                 !byte $01
  2285                          
  2286                          
  2287                          
  2288                          
  2289                          
  2290                          ; ==============================================================================
  2291                          ;
  2292                          ;
  2293                          ; ==============================================================================
  2294                                  
  2295                          
  2296                          rasterpoll_and_other_stuff:
  2297                          
  2298  2fb9 209f35                                 jsr poll_raster
  2299  2fbc 20c039                                 jsr check_door 
  2300  2fbf 4c7514                                 jmp animation_entrypoint          
  2301                          
  2302                          
  2303                          
  2304                          ; ==============================================================================
  2305                          ;
  2306                          ; tileset definition
  2307                          ; these are the first characters in the charset of each tile.
  2308                          ; example: rocks start at $0c and span 9 characters in total
  2309                          ; ==============================================================================
  2310                          
  2311                          tileset_definition:
  2312                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  2313  2fc2 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
  2314                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2315  2fca 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
  2316                                              ;     $10
  2317  2fd2 03                                     !byte $03                                           ; door
  2318                          
  2319                          !if EXTENDED = 0{
  2320                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2321  2fd3 00390a0e3d7f2a2a                       !byte $00, $39, $0a, $0e, $3d, $7f, $2a, $2a
  2322                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2323  2fdb 1e1e1e3d3d192f2f                       !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2324                                              ;     $10
  2325  2fe3 0a                                     !byte $0a
  2326                          }
  2327                          
  2328                          !if EXTENDED = 1{
  2329                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2330                                              !byte $00, $39, $2a, $0e, $3d, $7f, $2a, $2a
  2331                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2332                                              !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2333                                              ;     $10
  2334                                              !byte $29   
  2335                          }
  2336                          
  2337                          ; ==============================================================================
  2338                          ;
  2339                          ; displays a room based on tiles
  2340                          ; ==============================================================================
  2341                          
  2342                          display_room:       
  2343  2fe4 208b3a                                 jsr draw_border
  2344  2fe7 a900                                   lda #$00
  2345  2fe9 8502                                   sta zp02
  2346  2feb a2d8                                   ldx #>COLRAM        ; HiByte of COLRAM
  2347  2fed 8605                                   stx zp05
  2348  2fef a204                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  2349  2ff1 8603                                   stx zp03
  2350  2ff3 a228                                   ldx #>level_data    ; HiByte of level_data
  2351  2ff5 860a                                   stx zp0A            ; in zp0A
  2352  2ff7 a201               current_room:       ldx #$01            ; current_room in X
  2353  2ff9 f00a                                   beq ++              ; if 0 -> skip
  2354  2ffb 18                 -                   clc                 ; else
  2355  2ffc 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  2356  2ffe 9002                                   bcc +               ; to zp09/zp0A
  2357  3000 e60a                                   inc zp0A            ;
  2358  3002 ca                 +                   dex                 ; X times
  2359  3003 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  2360  3005 8509               ++                  sta zp09            ; LoByte from above
  2361  3007 a000                                   ldy #$00
  2362  3009 84a8                                   sty zpA8
  2363  300b 84a7                                   sty zpA7
  2364  300d b109               m3066:              lda (zp09),y        ; get Tilenumber
  2365  300f aa                                     tax                 ; in X
  2366  3010 bdd32f                                 lda tiles_colors,x  ; get Tilecolor
  2367  3013 8510                                   sta zp10            ; => zp10
  2368  3015 bdc22f                                 lda tiles_chars,x   ; get Tilechar
  2369  3018 8511                                   sta zp11            ; => zp11
  2370  301a a203                                   ldx #$03            ; (3 rows)
  2371  301c a000               --                  ldy #$00
  2372  301e a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  2373  3020 8504                                   sta zp04            ; LoByte of COLRAM pointer
  2374  3022 a511                                   lda zp11            ; Load Tilechar
  2375  3024 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  2376  3026 a510                                   lda zp10            ; Load Tilecolor
  2377  3028 9104                                   sta (zp04),y        ; to COLRAM + Y
  2378  302a a511                                   lda zp11            ; Load Tilechar again
  2379  302c c9df                                   cmp #$df            ; if empty tile
  2380  302e f002                                   beq +               ; -> skip
  2381  3030 e611                                   inc zp11            ; else: Tilechar + 1
  2382  3032 c8                 +                   iny                 ; Y = Y + 1
  2383  3033 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  2384  3035 d0e7                                   bne -               ; no -> next Char
  2385  3037 a502                                   lda zp02            ; yes:
  2386  3039 18                                     clc
  2387  303a 6928                                   adc #$28            ; next SCREEN row
  2388  303c 8502                                   sta zp02
  2389  303e 9004                                   bcc +
  2390  3040 e603                                   inc zp03
  2391  3042 e605                                   inc zp05            ; and COLRAM row
  2392  3044 ca                 +                   dex                 ; X = X - 1
  2393  3045 d0d5                                   bne --              ; X != 0 -> next Char
  2394  3047 e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  2395  3049 e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  2396  304b a975                                   lda #$75            ; for m30B8 + 1
  2397  304d a6a8                                   ldx zpA8
  2398  304f e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  2399  3051 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  2400  3053 a6a7                                   ldx zpA7            ; else:
  2401  3055 e066                                   cpx #$66            ; zpA7 >= $66
  2402  3057 b01c                                   bcs display_door    ; yes: display_door
  2403  3059 a900                                   lda #$00            ; else:
  2404  305b 85a8                                   sta zpA8            ; clear zpA8
  2405  305d a924                                   lda #$24            ; for m30B8 + 1
  2406  305f 8d6630             +                   sta m30B8 + 1       ;
  2407  3062 a502                                   lda zp02
  2408  3064 38                                     sec
  2409  3065 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  2410  3067 8502                                   sta zp02
  2411  3069 b004                                   bcs +
  2412  306b c603                                   dec zp03
  2413  306d c605                                   dec zp05
  2414  306f a4a7               +                   ldy zpA7
  2415  3071 4c0d30                                 jmp m3066
  2416  3074 60                                     rts                 ; will this ever be used?
  2417                          
  2418  3075 a904               display_door:       lda #>SCREENRAM
  2419  3077 8503                                   sta zp03
  2420  3079 a9d8                                   lda #>COLRAM
  2421  307b 8505                                   sta zp05
  2422  307d a900                                   lda #$00
  2423  307f 8502                                   sta zp02
  2424  3081 8504                                   sta zp04
  2425  3083 a028               -                   ldy #$28
  2426  3085 b102                                   lda (zp02),y        ; read from SCREENRAM
  2427  3087 c906                                   cmp #$06            ; $06 (part from Door?)
  2428  3089 b00b                                   bcs +               ; >= $06 -> skip
  2429  308b 38                                     sec                 ; else:
  2430  308c e903                                   sbc #$03            ; subtract $03
  2431  308e a000                                   ldy #$00            ; set Y = $00
  2432  3090 9102                                   sta (zp02),y        ; and copy to one row above
  2433  3092 a90a                                   lda #$0a            ; color brown - luminance $3
  2434  3094 9104                                   sta (zp04),y
  2435  3096 a502               +                   lda zp02
  2436  3098 18                                     clc
  2437  3099 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  2438  309b 9004                                   bcc +
  2439  309d e603                                   inc zp03            ; inc pointer HiBytes if necessary
  2440  309f e605                                   inc zp05
  2441  30a1 8502               +                   sta zp02
  2442  30a3 8504                                   sta zp04
  2443  30a5 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  2444  30a7 d0da                                   bne -               ; no -> loop
  2445  30a9 a503                                   lda zp03            ; else:
  2446  30ab c907                                   cmp #>(SCREENRAM+$300)
  2447  30ad d0d4                                   bne -               ; no -> loop
  2448  30af 60                                     rts                 ; else: finally ready with room display
  2449                          
  2450                          ; ==============================================================================
  2451                          
  2452  30b0 a904               print_title:        lda #>SCREENRAM
  2453  30b2 8503                                   sta zp03
  2454  30b4 a9d8                                   lda #>COLRAM
  2455  30b6 8505                                   sta zp05
  2456  30b8 a900                                   lda #<SCREENRAM
  2457  30ba 8502                                   sta zp02
  2458  30bc 8504                                   sta zp04
  2459  30be a930                                   lda #>screen_start_src
  2460  30c0 85a8                                   sta zpA8
  2461  30c2 a9df                                   lda #<screen_start_src
  2462  30c4 85a7                                   sta zpA7
  2463  30c6 a204                                   ldx #$04
  2464  30c8 a000               --                  ldy #$00
  2465  30ca b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  2466  30cc 9102                                   sta (zp02),y        ; nach SCREEN
  2467  30ce a900                                   lda #$00           ; BLACK
  2468  30d0 9104                                   sta (zp04),y        ; nach COLRAM
  2469  30d2 c8                                     iny
  2470  30d3 d0f5                                   bne -
  2471  30d5 e603                                   inc zp03
  2472  30d7 e605                                   inc zp05
  2473  30d9 e6a8                                   inc zpA8
  2474  30db ca                                     dex
  2475  30dc d0ea                                   bne --
  2476  30de 60                                     rts
  2477                          
  2478                          ; ==============================================================================
  2479                          ; TITLE SCREEN DATA
  2480                          ;
  2481                          ; ==============================================================================
  2482                          
  2483                          screen_start_src:
  2484                          
  2485                                              !if EXTENDED {
  2486                                                  !bin "includes/screen-start-extended.scr"
  2487                                              }else{
  2488  30df 20202020202020a0...                        !bin "includes/screen-start.scr"
  2489                                              }
  2490                          
  2491                          screen_start_src_end:
  2492                          
  2493                          
  2494                          ; ==============================================================================
  2495                          ; i think this might be the draw routine for the player sprite
  2496                          ;
  2497                          ; ==============================================================================
  2498                          
  2499                          
  2500                          draw_player:
  2501  34c7 8eea34                                 stx m3548 + 1                       ; store x pos of player
  2502  34ca a9d8                                   lda #>COLRAM                        ; store colram high in zp05
  2503  34cc 8505                                   sta zp05
  2504  34ce a904                                   lda #>SCREENRAM                     ; store screenram high in zp03
  2505  34d0 8503                                   sta zp03
  2506  34d2 a900                                   lda #$00
  2507  34d4 8502                                   sta zp02
  2508  34d6 8504                                   sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
  2509  34d8 c000                                   cpy #$00                            ; Y is probably the player Y position
  2510  34da f00c                                   beq +                               ; Y is 0 -> +
  2511  34dc 18                 -                   clc                                 ; Y not 0
  2512  34dd 6928                                   adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
  2513  34df 9004                                   bcc ++                              ; <256? -> ++
  2514  34e1 e603                                   inc zp03
  2515  34e3 e605                                   inc zp05
  2516  34e5 88                 ++                  dey                                 ; Y = Y - 1
  2517  34e6 d0f4                                   bne -                               ; Y = 0 ? -> -
  2518  34e8 18                 +                   clc                                 ;
  2519  34e9 6916               m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
  2520  34eb 8502                                   sta zp02
  2521  34ed 8504                                   sta zp04
  2522  34ef 9004                                   bcc +
  2523  34f1 e603                                   inc zp03
  2524  34f3 e605                                   inc zp05
  2525  34f5 a203               +                   ldx #$03                            ; draw 3 rows for the player "sprite"
  2526  34f7 a900                                   lda #$00
  2527  34f9 8509                                   sta zp09
  2528  34fb a000               --                  ldy #$00
  2529  34fd a5a7               -                   lda zpA7
  2530  34ff d006                                   bne +
  2531  3501 a9df                                   lda #$df                            ; empty char, but not sure why
  2532  3503 9102                                   sta (zp02),y
  2533  3505 d01b                                   bne ++
  2534  3507 c901               +                   cmp #$01
  2535  3509 d00a                                   bne +
  2536  350b a5a8                                   lda zpA8
  2537  350d 9102                                   sta (zp02),y
  2538  350f a50a                                   lda zp0A
  2539  3511 9104                                   sta (zp04),y
  2540  3513 d00d                                   bne ++
  2541  3515 b102               +                   lda (zp02),y
  2542  3517 8610                                   stx zp10
  2543  3519 a609                                   ldx zp09
  2544  351b 9d4503                                 sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
  2545  351e e609                                   inc zp09
  2546  3520 a610                                   ldx zp10
  2547  3522 e6a8               ++                  inc zpA8
  2548  3524 c8                                     iny
  2549  3525 c003                                   cpy #$03                            ; width of the player sprite in characters (3)
  2550  3527 d0d4                                   bne -
  2551  3529 a502                                   lda zp02
  2552  352b 18                                     clc
  2553  352c 6928                                   adc #$28                            ; $28 = #40, draws one row of the player under each other
  2554  352e 8502                                   sta zp02
  2555  3530 8504                                   sta zp04
  2556  3532 9004                                   bcc +
  2557  3534 e603                                   inc zp03
  2558  3536 e605                                   inc zp05
  2559  3538 ca                 +                   dex
  2560  3539 d0c0                                   bne --
  2561  353b 60                                     rts
  2562                          
  2563                          
  2564                          ; ==============================================================================
  2565                          ; $359b
  2566                          ; JOYSTICK CONTROLS
  2567                          ; ==============================================================================
  2568                          
  2569                          check_joystick:
  2570                          
  2571                                              ;lda #$fd
  2572                                              ;sta KEYBOARD_LATCH
  2573                                              ;lda KEYBOARD_LATCH
  2574  353c ad00dc                                 lda $dc00
  2575  353f a009               player_pos_y:       ldy #$09
  2576  3541 a215               player_pos_x:       ldx #$15
  2577  3543 4a                                     lsr
  2578  3544 b005                                   bcs +
  2579  3546 c000                                   cpy #$00
  2580  3548 f001                                   beq +
  2581  354a 88                                     dey                                           ; JOYSTICK UP
  2582  354b 4a                 +                   lsr
  2583  354c b005                                   bcs +
  2584  354e c015                                   cpy #$15
  2585  3550 b001                                   bcs +
  2586  3552 c8                                     iny                                           ; JOYSTICK DOWN
  2587  3553 4a                 +                   lsr
  2588  3554 b005                                   bcs +
  2589  3556 e000                                   cpx #$00
  2590  3558 f001                                   beq +
  2591  355a ca                                     dex                                           ; JOYSTICK LEFT
  2592  355b 4a                 +                   lsr
  2593  355c b005                                   bcs +
  2594  355e e024                                   cpx #$24
  2595  3560 b001                                   bcs +
  2596  3562 e8                                     inx                                           ; JOYSTICK RIGHT
  2597  3563 8c8135             +                   sty m35E7 + 1
  2598  3566 8e8635                                 stx m35EC + 1
  2599  3569 a902                                   lda #$02
  2600  356b 85a7                                   sta zpA7
  2601  356d 20c734                                 jsr draw_player
  2602  3570 a209                                   ldx #$09
  2603  3572 bd4403             -                   lda TAPE_BUFFER + $8,x
  2604  3575 c9df                                   cmp #$df
  2605  3577 f004                                   beq +
  2606  3579 c9e2                                   cmp #$e2
  2607  357b d00d                                   bne ++
  2608  357d ca                 +                   dex
  2609  357e d0f2                                   bne -
  2610  3580 a90a               m35E7:              lda #$0a
  2611  3582 8d4035                                 sta player_pos_y + 1
  2612  3585 a915               m35EC:              lda #$15
  2613  3587 8d4235                                 sta player_pos_x + 1
  2614                          ++                  ;lda #$ff
  2615                                              ;sta KEYBOARD_LATCH
  2616  358a a901                                   lda #$01
  2617  358c 85a7                                   sta zpA7
  2618  358e a993                                   lda #$93                ; first character of the player graphic
  2619  3590 85a8                                   sta zpA8
  2620  3592 a93d                                   lda #$3d
  2621  3594 850a                                   sta zp0A
  2622  3596 ac4035             get_player_pos:     ldy player_pos_y + 1
  2623  3599 ae4235                                 ldx player_pos_x + 1
  2624                                        
  2625  359c 4cc734                                 jmp draw_player
  2626                          
  2627                          ; ==============================================================================
  2628                          ;
  2629                          ; POLL RASTER
  2630                          ; ==============================================================================
  2631                          
  2632                          poll_raster:
  2633  359f 78                                     sei                     ; disable interrupt
  2634  35a0 a9c0                                   lda #$c0                ; A = $c0
  2635  35a2 cd12d0             -                   cmp FF1D               ; vertical line bits 0-7
  2636                                              
  2637  35a5 d0fb                                   bne -                   ; loop until we hit line c0
  2638  35a7 a900                                   lda #$00                ; A = 0
  2639  35a9 85a7                                   sta zpA7                ; zpA7 = 0
  2640                                              
  2641  35ab 209635                                 jsr get_player_pos
  2642                                              
  2643  35ae 203c35                                 jsr check_joystick
  2644  35b1 58                                     cli
  2645  35b2 60                                     rts
  2646                          
  2647                          
  2648                          ; ==============================================================================
  2649                          ; ROOM 16
  2650                          ; BELEGRO ANIMATION
  2651                          ; ==============================================================================
  2652                          
  2653                          belegro_animation:
  2654                          
  2655  35b3 a900                                   lda #$00
  2656  35b5 85a7                                   sta zpA7
  2657  35b7 a20f               m3624:              ldx #$0f
  2658  35b9 a00f               m3626:              ldy #$0f
  2659  35bb 20c734                                 jsr draw_player
  2660  35be aeb835                                 ldx m3624 + 1
  2661  35c1 acba35                                 ldy m3626 + 1
  2662  35c4 ec4235                                 cpx player_pos_x + 1
  2663  35c7 b002                                   bcs +
  2664  35c9 e8                                     inx
  2665  35ca e8                                     inx
  2666  35cb ec4235             +                   cpx player_pos_x + 1
  2667  35ce f001                                   beq +
  2668  35d0 ca                                     dex
  2669  35d1 cc4035             +                   cpy player_pos_y + 1
  2670  35d4 b002                                   bcs +
  2671  35d6 c8                                     iny
  2672  35d7 c8                                     iny
  2673  35d8 cc4035             +                   cpy player_pos_y + 1
  2674  35db f001                                   beq +
  2675  35dd 88                                     dey
  2676  35de 8ef835             +                   stx m3668 + 1
  2677  35e1 8cfd35                                 sty m366D + 1
  2678  35e4 a902                                   lda #$02
  2679  35e6 85a7                                   sta zpA7
  2680  35e8 20c734                                 jsr draw_player
  2681  35eb a209                                   ldx #$09
  2682  35ed bd4403             -                   lda TAPE_BUFFER + $8,x
  2683  35f0 c992                                   cmp #$92
  2684  35f2 900d                                   bcc +
  2685  35f4 ca                                     dex
  2686  35f5 d0f6                                   bne -
  2687  35f7 a210               m3668:              ldx #$10
  2688  35f9 8eb835                                 stx m3624 + 1
  2689  35fc a00e               m366D:              ldy #$0e
  2690  35fe 8cba35                                 sty m3626 + 1
  2691  3601 a99c               +                   lda #$9c                                ; belegro chars
  2692  3603 85a8                                   sta zpA8
  2693  3605 a93e                                   lda #$3e
  2694  3607 850a                                   sta zp0A
  2695  3609 acba35                                 ldy m3626 + 1
  2696  360c aeb835                                 ldx m3624 + 1                    
  2697  360f a901                                   lda #$01
  2698  3611 85a7                                   sta zpA7
  2699  3613 4cc734                                 jmp draw_player
  2700                          
  2701                          
  2702                          ; ==============================================================================
  2703                          ; items
  2704                          ; This area seems to be responsible for items placement
  2705                          ;
  2706                          ; ==============================================================================
  2707                          
  2708                          items:

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
  2710                          items_end:
  2711                          
  2712                          next_item:
  2713  37c6 a5a7                                   lda zpA7
  2714  37c8 18                                     clc
  2715  37c9 6901                                   adc #$01
  2716  37cb 85a7                                   sta zpA7
  2717  37cd 9002                                   bcc +                       ; bcc $3845
  2718  37cf e6a8                                   inc zpA8
  2719  37d1 60                 +                   rts
  2720                          
  2721                          ; ==============================================================================
  2722                          ; TODO
  2723                          ; no clue yet. level data has already been drawn when this is called
  2724                          ; probably placing the items on the screen
  2725                          ; ==============================================================================
  2726                          
  2727                          update_items_display:
  2728  37d2 a936                                   lda #>items                 ; load address for items into zeropage
  2729  37d4 85a8                                   sta zpA8
  2730  37d6 a916                                   lda #<items
  2731  37d8 85a7                                   sta zpA7
  2732  37da a000                                   ldy #$00                    ; y = 0
  2733  37dc b1a7               --                  lda (zpA7),y                ; load first value
  2734  37de c9ff                                   cmp #$ff                    ; is it $ff?
  2735  37e0 f006                                   beq +                       ; yes -> +
  2736  37e2 20c637             -                   jsr next_item               ; no -> set zero page to next value
  2737  37e5 4cdc37                                 jmp --                      ; and loop
  2738  37e8 20c637             +                   jsr next_item               ; value was $ff, now get the next value in the list
  2739  37eb b1a7                                   lda (zpA7),y
  2740  37ed c9ff                                   cmp #$ff                    ; is the next value $ff again?
  2741  37ef d003                                   bne +
  2742  37f1 4c7638                                 jmp prepare_rooms           ; yes -> m38DF
  2743  37f4 cdf82f             +                   cmp current_room + 1        ; is the number the current room number?
  2744  37f7 d0e9                                   bne -                       ; no -> loop
  2745  37f9 a9d8                                   lda #>COLRAM                ; yes the number is the current room number
  2746  37fb 8505                                   sta zp05                    ; store COLRAM and SCREENRAM in zeropage
  2747  37fd a904                                   lda #>SCREENRAM
  2748  37ff 8503                                   sta zp03
  2749  3801 a900                                   lda #$00                    ; A = 0
  2750  3803 8502                                   sta zp02                    ; zp02 = 0, zp04 = 0
  2751  3805 8504                                   sta zp04
  2752  3807 20c637                                 jsr next_item               ; move to next value
  2753  380a b1a7                                   lda (zpA7),y                ; get next value in the list
  2754  380c c9fe               -                   cmp #$fe                    ; is it $FE?
  2755  380e f00b                                   beq +                       ; yes -> +
  2756  3810 c9f9                                   cmp #$f9                    ; no, is it $f9?
  2757  3812 d00d                                   bne +++                     ; no -> +++
  2758  3814 a502                                   lda zp02                    ; value is $f9
  2759  3816 206e38                                 jsr m38D7                   ; add 1 to zp02 and zp04
  2760  3819 9004                                   bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
  2761  381b e603               +                   inc zp03                    ; value is $fe
  2762  381d e605                                   inc zp05                    ; increase zp03 and zp05
  2763  381f b1a7               ++                  lda (zpA7),y                ; get value from list
  2764  3821 c9fb               +++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
  2765  3823 d009                                   bne +                       ; no -> +
  2766  3825 20c637                                 jsr next_item               ; yes it's $fb, get the next value
  2767  3828 b1a7                                   lda (zpA7),y                ; get value from list
  2768  382a 8509                                   sta zp09                    ; store value in zp09
  2769  382c d028                                   bne ++                      ; if value was 0 -> ++
  2770  382e c9f8               +                   cmp #$f8
  2771  3830 f01c                                   beq +
  2772  3832 c9fc                                   cmp #$fc
  2773  3834 d00d                                   bne +++
  2774  3836 a50a                                   lda zp0A
  2775                                                                          ; jmp m399F
  2776                          
  2777  3838 c9df                                   cmp #$df                    ; this part was moved here as it wasn't called anywhere else
  2778  383a f002                                   beq skip                    ; and I think it was just outsourced for branching length issues
  2779  383c e60a                                   inc zp0A           
  2780  383e b1a7               skip:               lda (zpA7),y        
  2781  3840 4c4e38                                 jmp m38B7
  2782                          
  2783  3843 c9fa               +++                 cmp #$fa
  2784  3845 d00f                                   bne ++
  2785  3847 20c637                                 jsr next_item
  2786  384a b1a7                                   lda (zpA7),y
  2787  384c 850a                                   sta zp0A
  2788                          m38B7:
  2789  384e a509               +                   lda zp09
  2790  3850 9104                                   sta (zp04),y
  2791  3852 a50a                                   lda zp0A
  2792  3854 9102                                   sta (zp02),y
  2793  3856 c9fd               ++                  cmp #$fd
  2794  3858 d009                                   bne +
  2795  385a 20c637                                 jsr next_item
  2796  385d b1a7                                   lda (zpA7),y
  2797  385f 8502                                   sta zp02
  2798  3861 8504                                   sta zp04
  2799  3863 20c637             +                   jsr next_item
  2800  3866 b1a7                                   lda (zpA7),y
  2801  3868 c9ff                                   cmp #$ff
  2802  386a d0a0                                   bne -
  2803  386c f008                                   beq prepare_rooms
  2804  386e 18                 m38D7:              clc
  2805  386f 6901                                   adc #$01
  2806  3871 8502                                   sta zp02
  2807  3873 8504                                   sta zp04
  2808  3875 60                                     rts
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
  2836                          
  2837                          ; ==============================================================================
  2838                          ; ROOM PREPARATION CHECK
  2839                          ; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
  2840                          ; ==============================================================================
  2841                          
  2842                          prepare_rooms:
  2843                                      
  2844  3876 adf82f                                 lda current_room + 1
  2845                                              
  2846  3879 c902                                   cmp #$02                                ; is the current room 02?
  2847  387b f01d                                   beq room_02_prep
  2848                          
  2849  387d c907                                   cmp #$07
  2850  387f f04c                                   beq room_07_make_sacred_column
  2851                                              
  2852  3881 c906                                   cmp #$06          
  2853  3883 f05a                                   beq room_06_make_deadly_doors
  2854                          
  2855  3885 c904                                   cmp #$04
  2856  3887 f062                                   beq room_04_prep
  2857                          
  2858  3889 c905                                   cmp #$05
  2859  388b f001                                   beq room_05_prep
  2860                          
  2861  388d 60                                     rts
  2862                          
  2863                          
  2864                          
  2865                          ; ==============================================================================
  2866                          ; ROOM 05
  2867                          ; HIDE THE BREATHING TUBE UNDER THE STONE
  2868                          ; ==============================================================================
  2869                          
  2870                          room_05_prep:                  
  2871                                                         
  2872  388e a9fd                                   lda #$fd                                    ; yes
  2873  3890 a201               breathing_tube_mod: ldx #$01
  2874  3892 d002                                   bne +                                       ; based on self mod, put the normal
  2875  3894 a97a                                   lda #$7a                                    ; stone char back again
  2876  3896 8dd206             +                   sta SCREENRAM + $2d2   
  2877  3899 60                                     rts
  2878                          
  2879                          
  2880                          
  2881                          ; ==============================================================================
  2882                          ; ROOM 02 PREP
  2883                          ; 
  2884                          ; ==============================================================================
  2885                          
  2886                          room_02_prep:
  2887  389a a90d                                   lda #$0d                                ; yes room is 02, a = $0d #13
  2888  389c 8502                                   sta zp02                                ; zp02 = $0d
  2889  389e 8504                                   sta zp04                                ; zp04 = $0d
  2890  38a0 a9d8                                   lda #>COLRAM                            ; set colram zp
  2891  38a2 8505                                   sta zp05
  2892  38a4 a904                                   lda #>SCREENRAM                         ; set screenram zp      
  2893  38a6 8503                                   sta zp03
  2894  38a8 a218                                   ldx #$18                                ; x = $18 #24
  2895  38aa b102               -                   lda (zp02),y                            ; y must have been set earlier
  2896  38ac c9df                                   cmp #$df                                ; $df = empty space likely
  2897  38ae f004                                   beq delete_fence                        ; yes, empty -> m3900
  2898  38b0 c9f5                                   cmp #$f5                                ; no, but maybe a $f5? (fence!)
  2899  38b2 d006                                   bne +                                   ; nope -> ++
  2900                          
  2901                          delete_fence:
  2902  38b4 a9f5                                   lda #$f5                                ; A is either $df or $f5 -> selfmod here
  2903  38b6 9102                                   sta (zp02),y                            ; store that value
  2904  38b8 9104                                   sta (zp04),y                            ; in zp02 and zo04
  2905  38ba a502               +                   lda zp02                                ; and load it in again, jeez
  2906  38bc 18                                     clc
  2907  38bd 6928                                   adc #$28                                ; smells like we're going to draw a fence
  2908  38bf 8502                                   sta zp02
  2909  38c1 8504                                   sta zp04
  2910  38c3 9004                                   bcc +             
  2911  38c5 e603                                   inc zp03
  2912  38c7 e605                                   inc zp05
  2913  38c9 ca                 +                   dex
  2914  38ca d0de                                   bne -              
  2915  38cc 60                                     rts
  2916                          
  2917                          ; ==============================================================================
  2918                          ; ROOM 07 PREP
  2919                          ;
  2920                          ; ==============================================================================
  2921                          
  2922                          room_07_make_sacred_column:
  2923                          
  2924                                              
  2925  38cd a217                                   ldx #$17                                    ; yes
  2926  38cf bd6805             -                   lda SCREENRAM + $168,x     
  2927  38d2 c9df                                   cmp #$df
  2928  38d4 d005                                   bne +                       
  2929  38d6 a9e3                                   lda #$e3
  2930  38d8 9d6805                                 sta SCREENRAM + $168,x    
  2931  38db ca                 +                   dex
  2932  38dc d0f1                                   bne -                      
  2933  38de 60                                     rts
  2934                          
  2935                          
  2936                          ; ==============================================================================
  2937                          ; ROOM 06
  2938                          ; PREPARE THE DEADLY DOORS
  2939                          ; ==============================================================================
  2940                          
  2941                          room_06_make_deadly_doors:
  2942                          
  2943                                              
  2944  38df a9f6                                   lda #$f6                                    ; char for wrong door
  2945  38e1 8d9c04                                 sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
  2946  38e4 8d7c06                                 sta SCREENRAM + $27c
  2947  38e7 8d6c07                                 sta SCREENRAM + $36c       
  2948  38ea 60                                     rts
  2949                          
  2950                          ; ==============================================================================
  2951                          ; ROOM 04
  2952                          ; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
  2953                          ; ==============================================================================
  2954                          
  2955                          room_04_prep: 
  2956                          
  2957                          
  2958                                              
  2959  38eb adf82f                                 lda current_room + 1                            ; get current room
  2960  38ee c904                                   cmp #04                                         ; is it 4? (coffins)
  2961  38f0 d00c                                   bne ++                                          ; nope
  2962  38f2 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  2963  38f4 ac0339                                 ldy m394A + 1                                   ; 
  2964  38f7 f002                                   beq +
  2965  38f9 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  2966  38fb 8df904             +                   sta SCREENRAM + $f9 
  2967                                          
  2968  38fe a2f7               ++                  ldx #$f7                                    ; yes room 04
  2969  3900 a0f8                                   ldy #$f8
  2970  3902 a901               m394A:              lda #$01
  2971  3904 d004                                   bne m3952           
  2972  3906 a23b                                   ldx #$3b
  2973  3908 a042                                   ldy #$42
  2974  390a a901               m3952:              lda #$01                                    ; some self mod here
  2975  390c c901                                   cmp #$01
  2976  390e d003                                   bne +           
  2977  3910 8e7a04                                 stx SCREENRAM+ $7a 
  2978  3913 c902               +                   cmp #$02
  2979  3915 d003                                   bne +           
  2980  3917 8e6a05                                 stx SCREENRAM + $16a   
  2981  391a c903               +                   cmp #$03
  2982  391c d003                                   bne +           
  2983  391e 8e5a06                                 stx SCREENRAM + $25a       
  2984  3921 c904               +                   cmp #$04
  2985  3923 d003                                   bne +           
  2986  3925 8e4a07                                 stx SCREENRAM + $34a   
  2987  3928 c905               +                   cmp #$05
  2988  392a d003                                   bne +           
  2989  392c 8c9c04                                 sty SCREENRAM + $9c    
  2990  392f c906               +                   cmp #$06
  2991  3931 d003                                   bne +           
  2992  3933 8c8c05                                 sty SCREENRAM + $18c   
  2993  3936 c907               +                   cmp #$07
  2994  3938 d003                                   bne +           
  2995  393a 8c7c06                                 sty SCREENRAM + $27c 
  2996  393d c908               +                   cmp #$08
  2997  393f d003                                   bne +           
  2998  3941 8c6c07                                 sty SCREENRAM + $36c   
  2999  3944 60                 +                   rts
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
  3019                          
  3020                          ; ==============================================================================
  3021                          ; PLAYER POSITION TABLE FOR EACH ROOM
  3022                          ; FORMAT: Y left door, X left door, Y right door, X right door
  3023                          ; ==============================================================================
  3024                          
  3025                          player_xy_pos_table:
  3026                          
  3027  3945 06031221           !byte $06, $03, $12, $21                                        ; room 00
  3028  3949 03031221           !byte $03, $03, $12, $21                                        ; room 01
  3029  394d 03031521           !byte $03, $03, $15, $21                                        ; room 02
  3030  3951 03030f21           !byte $03, $03, $0f, $21                                        ; room 03
  3031  3955 151e0606           !byte $15, $1e, $06, $06                                        ; room 04
  3032  3959 06031221           !byte $06, $03, $12, $21                                        ; room 05
  3033  395d 03030921           !byte $03, $03, $09, $21                                        ; room 06
  3034  3961 03031221           !byte $03, $03, $12, $21                                        ; room 07
  3035  3965 03030c21           !byte $03, $03, $0c, $21                                        ; room 08
  3036  3969 03031221           !byte $03, $03, $12, $21                                        ; room 09
  3037  396d 0c030c20           !byte $0c, $03, $0c, $20                                        ; room 10
  3038  3971 0c030c21           !byte $0c, $03, $0c, $21                                        ; room 11
  3039  3975 0c030915           !byte $0c, $03, $09, $15                                        ; room 12
  3040  3979 03030621           !byte $03, $03, $06, $21                                        ; room 13
  3041  397d 03030321           !byte $03, $03, $03, $21                                        ; room 14
  3042  3981 06031221           !byte $06, $03, $12, $21                                        ; room 15
  3043  3985 0303031d           !byte $03, $03, $03, $1d                                        ; room 16
  3044  3989 03030621           !byte $03, $03, $06, $21                                        ; room 17
  3045  398d 0303               !byte $03, $03                                                  ; room 18 (only one door)
  3046                          
  3047                          
  3048                          
  3049                          ; ==============================================================================
  3050                          ; $3a33
  3051                          ; Apparently some lookup table, e.g. to get the 
  3052                          ; ==============================================================================
  3053                          
  3054                          room_player_pos_lookup:
  3055                          
  3056  398f 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  3057  399f 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  3058  39af 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  3059  39bf 00                 !byte $00
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
  3070                          
  3071                          ; ==============================================================================
  3072                          ;
  3073                          ;
  3074                          ; ==============================================================================
  3075                          
  3076                          check_door:
  3077                          
  3078  39c0 a209                                   ldx #$09                                    ; set loop to 9
  3079  39c2 bd4403             -                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
  3080  39c5 c905                                   cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
  3081  39c7 f008                                   beq +                                       ; yes -> +
  3082  39c9 c903                                   cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
  3083  39cb f013                                   beq set_player_xy                           ; yes -> m3A17
  3084  39cd ca                                     dex                                         ; decrease loop
  3085  39ce d0f2                                   bne -                                       ; loop
  3086  39d0 60                 -                   rts
  3087                          
  3088  39d1 aef82f             +                   ldx current_room + 1
  3089  39d4 f0fa                                   beq -               
  3090  39d6 ca                                     dex
  3091  39d7 8ef82f                                 stx current_room + 1                        ; update room number                         
  3092  39da bc8f39                                 ldy room_player_pos_lookup,x                ; load        
  3093  39dd 4cea39                                 jmp update_player_pos           
  3094                          
  3095                          set_player_xy:
  3096  39e0 aef82f                                 ldx current_room + 1                            ; x = room number
  3097  39e3 e8                                     inx                                             ; room number ++
  3098  39e4 8ef82f                                 stx current_room + 1                            ; update room number
  3099  39e7 bca639                                 ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room
  3100                          
  3101                          update_player_pos:              
  3102  39ea b94539                                 lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
  3103  39ed 8d4035                                 sta player_pos_y + 1                            ; player y pos = a
  3104  39f0 b94639                                 lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
  3105  39f3 8d4235                                 sta player_pos_x + 1
  3106                          
  3107  39f6 20e42f             m3A2D:              jsr display_room                                ; done  
  3108  39f9 208615                                 jsr room_04_prep_door                           ; was in main loop before, might find a better place
  3109  39fc 4cd237                                 jmp update_items_display
  3110                          
  3111                          
  3112                          
  3113                          ; ==============================================================================
  3114                          ;
  3115                          ; wait routine
  3116                          ; usually called with Y set before
  3117                          ; ==============================================================================
  3118                          
  3119                          wait:
  3120  39ff ca                                     dex
  3121  3a00 d0fd                                   bne wait
  3122  3a02 88                                     dey
  3123  3a03 d0fa                                   bne wait
  3124  3a05 60                 fake:               rts
  3125                          
  3126                          
  3127                          ; ==============================================================================
  3128                          ; sets the game screen
  3129                          ; multicolor, charset, main colors
  3130                          ; ==============================================================================
  3131                          
  3132                          set_game_basics:
  3133  3a06 ad12ff                                 lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  3134  3a09 29fb                                   and #$fb                                    ; clear bit 2
  3135  3a0b 8d12ff                                 sta VOICE1                                  ; => get data from RAM
  3136  3a0e a918                                   lda #$18            ;lda #$21
  3137  3a10 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
  3138                                              
  3139                                                                                          ; bit 1 : Single clock set  ( 0 )
  3140                                                                                          ; b.2-7 : character data base address
  3141                                                                                          ; %00100$x ($2000)
  3142  3a13 ad16d0                                 lda FF07
  3143  3a16 0990                                   ora #$90                                    ; multicolor ON - reverse OFF
  3144  3a18 8d16d0                                 sta FF07
  3145                          
  3146                                                                                          ; set the main colors for the game
  3147                          
  3148  3a1b a90a                                   lda #MULTICOLOR_1                           ; original: #$db
  3149  3a1d 8d22d0                                 sta COLOR_1                                 ; char color 1
  3150  3a20 a909                                   lda #MULTICOLOR_2                           ; original: #$29
  3151  3a22 8d23d0                                 sta COLOR_2                                 ; char color 2
  3152                                              
  3153  3a25 60                                     rts
  3154                          
  3155                          ; ==============================================================================
  3156                          ; set font and screen setup (40 columns and hires)
  3157                          ; $3a9d
  3158                          ; ==============================================================================
  3159                          
  3160                          set_charset_and_screen:                               ; set text screen
  3161                          
  3162  3a26 ad12ff                                 lda VOICE1
  3163  3a29 0904                                   ora #$04                                    ; set bit 2
  3164  3a2b 8d12ff                                 sta VOICE1                                  ; => get data from ROM
  3165  3a2e a9d5                                   lda #$d5                                    ; ROM FONT
  3166  3a30 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; set
  3167  3a33 ad16d0                                 lda FF07
  3168  3a36 a908                                   lda #$08                                    ; 40 columns and Multicolor OFF
  3169  3a38 8d16d0                                 sta FF07
  3170                                              
  3171  3a3b 60                                     rts
  3172                          
  3173                          test:
  3174  3a3c ee20d0                                 inc BORDER_COLOR
  3175  3a3f 4c3c3a                                 jmp test
  3176                          
  3177                          ; ==============================================================================
  3178                          ; init
  3179                          ; start of game (original $3ab3)
  3180                          ; ==============================================================================
  3181                          
  3182                          code_start:
  3183                          init:
  3184                                              ;jsr init_music           ; TODO
  3185                                              
  3186  3a42 a917                                   lda #$17                  ; set lower case charset
  3187  3a44 8d18d0                                 sta $d018                 ; wasn't on Plus/4 for some reason
  3188                                              
  3189  3a47 a90b                                   lda #$0b
  3190  3a49 8d21d0                                 sta BG_COLOR          ; background color
  3191  3a4c 8d20d0                                 sta BORDER_COLOR          ; border color
  3192  3a4f 20b016                                 jsr reset_items           ; might be a level data reset, and print the title screen
  3193                          
  3194  3a52 a020                                   ldy #$20
  3195  3a54 20ff39                                 jsr wait
  3196                                              
  3197                                              ; waiting for key press on title screen
  3198                          
  3199  3a57 a5cb               -                   lda $cb                   ; zp position of currently pressed key
  3200  3a59 c938                                   cmp #$38                  ; is it the space key?
  3201  3a5b d0fa                                   bne -
  3202                          
  3203                                                                        ;clda #$ff
  3204  3a5d 20e71c                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  3205                                              
  3206                          
  3207                                              ; TODO: unclear what the code below does
  3208                                              ; i think it fills the level data with "DF", which is a blank character
  3209  3a60 a904                                   lda #>SCREENRAM
  3210  3a62 8503                                   sta zp03
  3211  3a64 a900                                   lda #$00
  3212  3a66 8502                                   sta zp02
  3213  3a68 a204                                   ldx #$04
  3214  3a6a a000                                   ldy #$00
  3215  3a6c a9df                                   lda #$df
  3216  3a6e 9102               -                   sta (zp02),y
  3217  3a70 c8                                     iny
  3218  3a71 d0fb                                   bne -
  3219  3a73 e603                                   inc zp03
  3220  3a75 ca                                     dex
  3221  3a76 d0f6                                   bne -
  3222                                              
  3223  3a78 20063a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  3224                          
  3225                                              ; set background color
  3226  3a7b a900                                   lda #$00
  3227  3a7d 8d21d0                                 sta BG_COLOR
  3228                          
  3229                                              ; border color. default is a dark red
  3230  3a80 a902                                   lda #BORDER_COLOR_VALUE
  3231  3a82 8d20d0                                 sta BORDER_COLOR
  3232                                              
  3233  3a85 208b3a                                 jsr draw_border
  3234                                              
  3235  3a88 4cc33a                                 jmp set_start_screen
  3236                          
  3237                          ; ==============================================================================
  3238                          ;
  3239                          ; draws the extended "border"
  3240                          ; ==============================================================================
  3241                          
  3242                          draw_border:        
  3243  3a8b a927                                   lda #$27
  3244  3a8d 8502                                   sta zp02
  3245  3a8f 8504                                   sta zp04
  3246  3a91 a9d8                                   lda #>COLRAM
  3247  3a93 8505                                   sta zp05
  3248  3a95 a904                                   lda #>SCREENRAM
  3249  3a97 8503                                   sta zp03
  3250  3a99 a218                                   ldx #$18
  3251  3a9b a000                                   ldy #$00
  3252  3a9d a95d               -                   lda #$5d
  3253  3a9f 9102                                   sta (zp02),y
  3254  3aa1 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3255  3aa3 9104                                   sta (zp04),y
  3256  3aa5 98                                     tya
  3257  3aa6 18                                     clc
  3258  3aa7 6928                                   adc #$28
  3259  3aa9 a8                                     tay
  3260  3aaa 9004                                   bcc +
  3261  3aac e603                                   inc zp03
  3262  3aae e605                                   inc zp05
  3263  3ab0 ca                 +                   dex
  3264  3ab1 d0ea                                   bne -
  3265  3ab3 a95d               -                   lda #$5d
  3266  3ab5 9dc007                                 sta SCREENRAM + $3c0,x
  3267  3ab8 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3268  3aba 9dc0db                                 sta COLRAM + $3c0,x
  3269  3abd e8                                     inx
  3270  3abe e028                                   cpx #$28
  3271  3ac0 d0f1                                   bne -
  3272  3ac2 60                                     rts
  3273                          
  3274                          ; ==============================================================================
  3275                          ; SETUP FIRST ROOM
  3276                          ; player xy position and room number
  3277                          ; ==============================================================================
  3278                          
  3279                          set_start_screen:
  3280  3ac3 a906                                   lda #PLAYER_START_POS_Y
  3281  3ac5 8d4035                                 sta player_pos_y + 1                    ; Y player start position (0 = top)
  3282  3ac8 a903                                   lda #PLAYER_START_POS_X
  3283  3aca 8d4235                                 sta player_pos_x + 1                    ; X player start position (0 = left)
  3284  3acd a900                                   lda #START_ROOM                         ; room number (start screen) ($3b45)
  3285  3acf 8df82f                                 sta current_room + 1
  3286  3ad2 20f639                                 jsr m3A2D
  3287                                              
  3288                          
  3289                          main_loop:
  3290                                              
  3291  3ad5 20b92f                                 jsr rasterpoll_and_other_stuff
  3292  3ad8 a030                                   ldy #$30                                ; wait a bit -> in each frame! slows down movement
  3293  3ada 20ff39                                 jsr wait
  3294                                                                                      ;jsr room_04_prep_door
  3295  3add 202316                                 jsr prep_player_pos
  3296  3ae0 4c3c16                                 jmp object_collision
  3297                          
  3298                          ; ==============================================================================
  3299                          ;
  3300                          ; Display the death message
  3301                          ; End of game and return to start screen
  3302                          ; ==============================================================================
  3303                          
  3304                          death:
  3305  3ae3 a93b                                   lda #>death_messages
  3306  3ae5 85a8                                   sta zpA8
  3307  3ae7 a93f                                   lda #<death_messages
  3308  3ae9 85a7                                   sta zpA7
  3309  3aeb c000                                   cpy #$00
  3310  3aed f00c                                   beq ++
  3311  3aef 18                 -                   clc
  3312  3af0 6932                                   adc #$32
  3313  3af2 85a7                                   sta zpA7
  3314  3af4 9002                                   bcc +
  3315  3af6 e6a8                                   inc zpA8
  3316  3af8 88                 +                   dey
  3317  3af9 d0f4                                   bne -
  3318  3afb a90c               ++                  lda #$0c
  3319  3afd 8503                                   sta zp03
  3320  3aff 8402                                   sty zp02
  3321  3b01 a204                                   ldx #$04
  3322  3b03 a920                                   lda #$20
  3323  3b05 9102               -                   sta (zp02),y
  3324  3b07 c8                                     iny
  3325  3b08 d0fb                                   bne -
  3326  3b0a e603                                   inc zp03
  3327  3b0c ca                                     dex
  3328  3b0d d0f6                                   bne -
  3329  3b0f 20263a                                 jsr set_charset_and_screen
  3330  3b12 b1a7               -                   lda (zpA7),y
  3331  3b14 9dc005                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  3332  3b17 a900                                   lda #$00                                    ; color of the death message
  3333  3b19 9dc0d9                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  3334  3b1c e8                                     inx
  3335  3b1d c8                                     iny
  3336  3b1e e019                                   cpx #$19
  3337  3b20 d002                                   bne +
  3338  3b22 a250                                   ldx #$50
  3339  3b24 c032               +                   cpy #$32
  3340  3b26 d0ea                                   bne -
  3341  3b28 a9fd                                   lda #$fd
  3342  3b2a 8d21d0                                 sta BG_COLOR
  3343  3b2d 8d20d0                                 sta BORDER_COLOR
  3344                          m3EF9:
  3345  3b30 a908                                   lda #$08
  3346  3b32 a0ff               -                   ldy #$ff
  3347  3b34 20ff39                                 jsr wait
  3348  3b37 38                                     sec
  3349  3b38 e901                                   sbc #$01
  3350  3b3a d0f6                                   bne -
  3351  3b3c 4c423a                                 jmp init
  3352                          
  3353                          ; ==============================================================================
  3354                          ;
  3355                          ; DEATH MESSAGES
  3356                          ; ==============================================================================
  3357                          
  3358                          death_messages:
  3359                          
  3360                          ; death messages
  3361                          ; like "You fell into a snake pit"
  3362                          
  3363                          ; scr conversion
  3364                          
  3365                          ; 00 You fell into a snake pit
  3366                          ; 01 You'd better watched out for the sacred column
  3367                          ; 02 You drowned in the deep river
  3368                          ; 03 You drank from the poisend bottle
  3369                          ; 04 Boris the spider got you and killed you
  3370                          ; 05 Didn't you see the laser beam?
  3371                          ; 06 240 Volts! You got an electrical shock!
  3372                          ; 07 You stepped on a nail!
  3373                          ; 08 A foot trap stopped you!
  3374                          ; 09 This room is doomed by the wizard Manilo!
  3375                          ; 0a You were locked in and starved!
  3376                          ; 0b You were hit by a big rock and died!
  3377                          ; 0c Belegro killed you!
  3378                          ; 0d You found a thirsty zombie....
  3379                          ; 0e The monster grabbed you you. You are dead!
  3380                          ; 0f You were wounded by the bush!
  3381                          ; 10 You are trapped in wire-nettings!
  3382                          
  3383                          !if LANGUAGE = EN{
  3384  3b3f 590f152006050c0c...!scr "You fell into a          snake pit !              "
  3385  3b71 590f152704200205...!scr "You'd better watched out for the sacred column!   "
  3386  3ba3 590f152004120f17...!scr "You drowned in the deep  river !                  "
  3387  3bd5 590f15200412010e...!scr "You drank from the       poisened bottle ........ "
  3388  3c07 420f1209132c2014...!scr "Boris, the spider, got   you and killed you !     "
  3389  3c39 4409040e27142019...!scr "Didn't you see the       laser beam ?!?           "
  3390  3c6b 32343020560f0c14...!scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  3391  3c9d 590f152013140510...!scr "You stepped on a nail !                           "
  3392  3ccf 4120060f0f142014...!scr "A foot trap stopped you !                         "
  3393  3d01 5408091320120f0f...!scr "This room is doomed      by the wizard Manilo !   "
  3394  3d33 590f152017051205...!scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  3395  3d65 590f152017051205...!scr "You were hit by a big    rock and died !          "
  3396  3d97 42050c0507120f20...!scr "Belegro killed           you !                    "
  3397  3dc9 590f1520060f150e...!scr "You found a thirsty      zombie .......           "
  3398  3dfb 540805200d0f0e13...!scr "The monster grapped       you. You are dead !     "
  3399  3e2d 590f152017051205...!scr "You were wounded by      the bush !               "
  3400  3e5f 590f152001120520...!scr "You are trapped in       wire-nettings !          "
  3401                          }
  3402                          
  3403                          
  3404                          !if LANGUAGE = DE{
  3405                          !scr "Sie sind in eine         Schlangengrube gefallen !"
  3406                          !scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  3407                          !scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  3408                          !scr "Sie haben aus der Gift-  flasche getrunken....... "
  3409                          !scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  3410                          !scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  3411                          !scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  3412                          !scr "Sie sind in einen Nagel  getreten !               "
  3413                          !scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  3414                          !scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  3415                          !scr "Sie wurden eingeschlossenund verhungern !         "
  3416                          !scr "Sie wurden von einem     Stein ueberollt !!       "
  3417                          !scr "Belegro hat Sie          vernichtet !             "
  3418                          !scr "Im Sarg lag ein durstigerZombie........           "
  3419                          !scr "Das Monster hat Sie      erwischt !!!!!           "
  3420                          !scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  3421                          !scr "Sie haben sich im        Stacheldraht verfangen !!"
  3422                          }
  3423                          
  3424                          ; ==============================================================================
  3425                          ; screen messages
  3426                          ; and the code entry text
  3427                          ; ==============================================================================
  3428                          
  3429                          !if LANGUAGE = EN{
  3430                          
  3431                          hint_messages:
  3432  3e91 2041201001121420...!scr " A part of the code number is :         "
  3433  3eb9 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3434  3ee1 20590f15200e0505...!scr " You need: bulb, bulb holder, socket !  "
  3435  3f09 2054050c0c200d05...!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  3436  3f31 202a2a2a2a2a2020...!scr " *****   A helping letter :   "
  3437  3f4f 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  3438  3f59 2057120f0e072003...!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  3439                          
  3440                          }
  3441                          
  3442                          !if LANGUAGE = DE{
  3443                          
  3444                          hint_messages:
  3445                          !scr " Ein Teil des Loesungscodes lautet:     "
  3446                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3447                          !scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  3448                          !scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  3449                          !scr " *****   Ein Hilfsbuchstabe:  "
  3450                          helping_letter: !scr "C   ***** "
  3451                          !scr " Falscher Loesungscode ! TODESSTRAFE !! "
  3452                          
  3453                          }
  3454                          
  3455                          
  3456                          ; ==============================================================================
  3457                          ;
  3458                          ; ITEM PICKUP MESSAGES
  3459                          ; ==============================================================================
  3460                          
  3461                          
  3462                          item_pickup_message:              ; item pickup messages
  3463                          
  3464                          !if LANGUAGE = EN{
  3465  3f81 2054080512052009...!scr " There is a key in the bottle !         "
  3466  3fa9 2020205408051205...!scr "   There is a key in the coffin !       "
  3467  3fd1 2054080512052009...!scr " There is a breathing tube !            "
  3468                          }
  3469                          
  3470                          !if LANGUAGE = DE{
  3471                          !scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
  3472                          !scr "    In dem Sarg lag ein Schluessel !    "
  3473                          !scr " Unter dem Stein lag ein Taucheranzug ! "
  3474                          }
  3475                          item_pickup_message_end:
