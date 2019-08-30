
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
    28                          LANGUAGE = DE
    29                          
    30                          ; ==============================================================================
    31                          ; thse settings change the appearance of the game
    32                          ; EXTENDED = 0 -> original version
    33                          ; EXTENDED = 1 -> altered version
    34                          ; ==============================================================================
    35                          
    36                          EXTENDED                = 1       ; 0 = original version, 1 = tweaks and cosmetics
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
    49                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $02 ; red
    50                              MULTICOLOR_1        = $0a           ; face pink
    51                              MULTICOLOR_2        = $09
    52                              BORDER_COLOR_VALUE  = $02
    53                              TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    54                              TITLE_KEY           = $01
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
   109                          BASIC_DA89          = $e8ea             ; $da89             ; scroll screen up by 1 line
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
   160                          display_hint_message_plus_clear:
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
   200  102c 20423b                                 jsr clear
   201  102f 205011                                 jsr switch_charset           
   202  1032 c003                                   cpy #$03                                ; is the display hint the one for the code number?
   203  1034 f003                                   beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
   204  1036 4cd810                                 jmp display_hint                        ; no, display the hint
   205                          
   206                          
   207                          room_16_code_number_prep:
   208                                              
   209  1039 20423b                                 jsr clear
   210  103c 200310                                 jsr display_hint_message                ; yes we are in room 3
   211  103f 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   212  1042 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   213                                             
   214  1045 a001                                   ldy #$01                                ; y = 1
   215  1047 200310                                 jsr display_hint_message              
   216  104a a200                                   ldx #$00                                ; x = 0
   217  104c a000                                   ldy #$00                                ; y = 0
   218  104e f013                                   beq room_16_enter_code                  ; room 16 code? how?
   219                          
   220                          room_16_cursor_blinking: 
   221                          
   222  1050 bdb905                                 lda SCREENRAM+$1B9,x                    ; load something from screen
   223  1053 18                                     clc                                     
   224  1054 6980                                   adc #$80                                ; add $80 = 128 = inverted char
   225  1056 9db905                                 sta SCREENRAM+$1B9,x                    ; store in the same location
   226  1059 b98805                                 lda SCREENRAM+$188,y                    ; and the same for another position
   227  105c 18                                     clc
   228  105d 6980                                   adc #$80
   229  105f 998805                                 sta SCREENRAM+$188,y 
   230  1062 60                                     rts
   231                          
   232                          ; ==============================================================================
   233                          ; ROOM 16
   234                          ; ENTER CODE
   235                          ; ==============================================================================
   236                          
   237                          room_16_enter_code:
   238                          
   239  1063 205010                                 jsr room_16_cursor_blinking
   240  1066 8402                                   sty zp02
   241  1068 8604                                   stx zp04
   242  106a 20a510                                 jsr room_16_code_delay           
   243  106d 205010                                 jsr room_16_cursor_blinking           
   244  1070 20a510                                 jsr room_16_code_delay
   245                          
   246  1073 ad00dc                                 lda $dc00
   247                                                                                          ; Bit #0: 0 = Port 2 joystick up pressed.
   248                                                                                          ; Bit #1: 0 = Port 2 joystick down pressed.
   249                                                                                          ; Bit #2: 0 = Port 2 joystick left pressed.
   250                                                                                          ; Bit #3: 0 = Port 2 joystick right pressed.
   251                                                                                          ; Bit #4: 0 = Port 2 joystick fire pressed.
   252                                              
   253  1076 4a                                     lsr                                         ; we don't check for up       
   254  1077 4a                                     lsr                                         ; we don't check for down
   255                                              
   256  1078 4a                                     lsr                                         ; now we have carry = 0 if LEFT PRESSED
   257  1079 b005                                   bcs +                                       ; left not pressed ->
   258  107b e000                                   cpx #$00                                    ; x = 0?
   259  107d f001                                   beq +                                       ; yes ->
   260  107f ca                                     dex                                         ; no, x = x - 1 = move cursor left
   261                          
   262  1080 4a                 +                   lsr                                         ; now we have carry = 0 if RIGHT PRESSED
   263  1081 b005                                   bcs +                                       ; right not pressed ->
   264  1083 e025                                   cpx #$25                                    ; right was pressed, but are we at the rightmost position already?
   265  1085 f001                                   beq +                                       ; yes we are ->
   266  1087 e8                                     inx                                         ; no, we can move one more, so x = x + 1
   267                          
   268  1088 4a                 +                   lsr                                         ; now we have carry = 0 if FIRE PRESSED
   269  1089 b0d8                                   bcs room_16_enter_code                      ; fire wasn't pressed, so start over
   270                                              
   271  108b bdb905                                 lda SCREENRAM+$1B9,x                        ; fire WAS pressed, so get the current character
   272  108e c9bc                                   cmp #$bc                                    ; is it the "<" char for back?
   273  1090 d008                                   bne ++                                      ; no ->
   274  1092 c000                                   cpy #$00                                    ; yes, code submitted
   275  1094 f001                                   beq +
   276  1096 88                                     dey
   277  1097 4c6310             +                   jmp room_16_enter_code
   278  109a 998805             ++                  sta SCREENRAM+$188,y
   279  109d c8                                     iny
   280  109e c005                                   cpy #$05
   281  10a0 d0c1                                   bne room_16_enter_code
   282  10a2 4caf10                                 jmp check_code_number
   283                          ; ==============================================================================
   284                          ;
   285                          ; DELAYS CURSOR MOVEMENT AND BLINKING
   286                          ; ==============================================================================
   287                          
   288                          room_16_code_delay:
   289  10a5 a020                                   ldy #$20                            ; wait a bit
   290  10a7 20ff39                                 jsr wait                        
   291  10aa a402                                   ldy zp02                            ; and load x and y 
   292  10ac a604                                   ldx zp04                            ; with shit from zp
   293  10ae 60                                     rts
   294                          
   295                          ; ==============================================================================
   296                          ; ROOM 16
   297                          ; CHECK THE CODE NUMBER
   298                          ; ==============================================================================
   299                          
   300                          check_code_number:
   301  10af a205                                   ldx #$05                            ; x = 5
   302  10b1 bd8705             -                   lda SCREENRAM+$187,x                ; get one number from code
   303  10b4 ddc610                                 cmp code_number-1,x                 ; is it correct?
   304  10b7 d006                                   bne +                               ; no -> +
   305  10b9 ca                                     dex                                 ; yes, check next number
   306  10ba d0f5                                   bne -                               
   307  10bc 4ccc10                                 jmp ++                              ; all correct -> ++
   308  10bf a005               +                   ldy #$05                            ; text for wrong code number
   309  10c1 200310                                 jsr display_hint_message            ; wrong code -> death
   310  10c4 4c333b                                 jmp m3EF9          
   311                          
   312  10c7 3036313338         code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38
   313                          
   314  10cc 20063a             ++                  jsr set_game_basics                 ; code correct, continue
   315  10cf 20e039                                 jsr set_player_xy          
   316  10d2 208b3a                                 jsr draw_border          
   317  10d5 4cd53a                                 jmp main_loop          
   318                          
   319                          ; ==============================================================================
   320                          ;
   321                          ; hint system (question marks)
   322                          ; ==============================================================================
   323                          
   324                          
   325                          display_hint:
   326  10d8 c000                                   cpy #$00
   327  10da d04a                                   bne m11A2           
   328  10dc 200010                                 jsr display_hint_message_plus_clear
   329  10df aef82f                                 ldx current_room + 1
   330  10e2 e001                                   cpx #$01
   331  10e4 d002                                   bne +               
   332  10e6 a928                                   lda #$28
   333  10e8 e005               +                   cpx #$05
   334  10ea d002                                   bne +               
   335  10ec a929                                   lda #$29
   336  10ee e00a               +                   cpx #$0a
   337  10f0 d002                                   bne +               
   338  10f2 a947                                   lda #$47                   
   339  10f4 e00c               +                   cpx #$0c
   340  10f6 d002                                   bne +
   341  10f8 a949                                   lda #$49
   342  10fa e00d               +                   cpx #$0d
   343  10fc d002                                   bne +
   344  10fe a945                                   lda #$45
   345  1100 e00f               +                   cpx #$0f
   346  1102 d00a                                   bne +               
   347  1104 a945                                   lda #$45
   348                                             
   349  1106 8d6fda                                 sta COLRAM + $26f       
   350  1109 a90f                                   lda #$0f
   351  110b 8d6f06                                 sta SCREENRAM + $26f       
   352  110e 8d1f06             +                   sta SCREENRAM + $21f       
   353  1111 a948                                   lda #$48
   354  1113 8d1fda                                 sta COLRAM + $21f       
   355  1116 ad00dc             -                   lda $dc00                         ;lda #$fd
   356                                                                                ;sta KEYBOARD_LATCH
   357                                                                                ; lda KEYBOARD_LATCH
   358  1119 2910                                   and #$10                          ; and #$80
   359  111b d0f9                                   bne -               
   360  111d 20063a                                 jsr set_game_basics
   361  1120 20f639                                 jsr m3A2D          
   362  1123 4cd53a                                 jmp main_loop         
   363  1126 c002               m11A2:              cpy #$02
   364  1128 d006                                   bne +             
   365  112a 200010             m11A6:              jsr display_hint_message_plus_clear
   366  112d 4c1611                                 jmp -             
   367  1130 c004               +                   cpy #$04
   368  1132 d00b                                   bne +              
   369  1134 ad0b39                                 lda m3952 + 1    
   370  1137 18                                     clc
   371  1138 6940                                   adc #$40                                        ; this is the helping letter
   372  113a 8d723f                                 sta helping_letter         
   373  113d d0eb                                   bne m11A6          
   374  113f 88                 +                   dey
   375  1140 88                                     dey
   376  1141 88                                     dey
   377  1142 88                                     dey
   378  1143 88                                     dey
   379  1144 a93f                                   lda #>item_pickup_message
   380  1146 85a8                                   sta zpA8
   381  1148 a9a4                                   lda #<item_pickup_message
   382  114a 200910                                 jsr m1009
   383  114d 4c1611                                 jmp -
   384                          
   385                          ; ==============================================================================
   386                          
   387                          switch_charset:
   388  1150 20263a                                 jsr set_charset_and_screen           
   389  1153 4c423b                                 jmp clear       ; jmp PRINT_KERNAL           
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
   408                          
   409                          
   410                          
   411                          
   412                          
   413                          
   414                          
   415                          
   416                          
   417                          ; ==============================================================================
   418                          ;
   419                          ; JUMP TO ROOM LOGIC
   420                          ; This code is new. Previously, code execution jumped from room to room
   421                          ; and in each room did the comparison with the room number.
   422                          ; This is essentially the same, but bundled in one place.
   423                          ; not calles in between room changes, only e.g. for question mark
   424                          ; ==============================================================================
   425                          
   426                          check_room:
   427  1156 acf82f                                 ldy current_room + 1        ; load in the current room number
   428  1159 c000                                   cpy #0
   429  115b d003                                   bne +
   430  115d 4cf811                                 jmp room_00
   431  1160 c001               +                   cpy #1
   432  1162 d003                                   bne +
   433  1164 4c1312                                 jmp room_01
   434  1167 c002               +                   cpy #2
   435  1169 d003                                   bne +
   436  116b 4c5012                                 jmp room_02
   437  116e c003               +                   cpy #3
   438  1170 d003                                   bne +
   439  1172 4ca612                                 jmp room_03
   440  1175 c004               +                   cpy #4
   441  1177 d003                                   bne +
   442  1179 4cb212                                 jmp room_04
   443  117c c005               +                   cpy #5
   444  117e d003                                   bne +
   445  1180 4cd412                                 jmp room_05
   446  1183 c006               +                   cpy #6
   447  1185 d003                                   bne +
   448  1187 4cf812                                 jmp room_06
   449  118a c007               +                   cpy #7
   450  118c d003                                   bne +
   451  118e 4c0413                                 jmp room_07
   452  1191 c008               +                   cpy #8
   453  1193 d003                                   bne +
   454  1195 4c3c13                                 jmp room_08
   455  1198 c009               +                   cpy #9
   456  119a d003                                   bne +
   457  119c 4c9313                                 jmp room_09
   458  119f c00a               +                   cpy #10
   459  11a1 d003                                   bne +
   460  11a3 4c9f13                                 jmp room_10
   461  11a6 c00b               +                   cpy #11
   462  11a8 d003                                   bne +
   463  11aa 4ccf13                                 jmp room_11 
   464  11ad c00c               +                   cpy #12
   465  11af d003                                   bne +
   466  11b1 4cde13                                 jmp room_12
   467  11b4 c00d               +                   cpy #13
   468  11b6 d003                                   bne +
   469  11b8 4cfa13                                 jmp room_13
   470  11bb c00e               +                   cpy #14
   471  11bd d003                                   bne +
   472  11bf 4c1e14                                 jmp room_14
   473  11c2 c00f               +                   cpy #15
   474  11c4 d003                                   bne +
   475  11c6 4c2a14                                 jmp room_15
   476  11c9 c010               +                   cpy #16
   477  11cb d003                                   bne +
   478  11cd 4c3614                                 jmp room_16
   479  11d0 c011               +                   cpy #17
   480  11d2 d003                                   bne +
   481  11d4 4c5c14                                 jmp room_17
   482  11d7 4c6b14             +                   jmp room_18
   483                          
   484                          
   485                          
   486                          ; ==============================================================================
   487                          
   488                          check_death:
   489  11da 20d237                                 jsr update_items_display
   490  11dd 4cd53a                                 jmp main_loop           
   491                          
   492                          ; ==============================================================================
   493                          
   494                          m11E0:              
   495  11e0 a200                                   ldx #$00
   496  11e2 bd4503             -                   lda TAPE_BUFFER + $9,x              
   497  11e5 c91e                                   cmp #$1e                            ; question mark
   498  11e7 9007                                   bcc check_next_char_under_player           
   499  11e9 c9df                                   cmp #$df
   500  11eb f003                                   beq check_next_char_under_player
   501  11ed 4c5611                                 jmp check_room              
   502                          
   503                          ; ==============================================================================
   504                          
   505                          check_next_char_under_player:
   506  11f0 e8                                     inx
   507  11f1 e009                                   cpx #$09
   508  11f3 d0ed                                   bne -                              ; not done checking          
   509  11f5 4cd53a             -                   jmp main_loop           
   510                          
   511                          
   512                          ; ==============================================================================
   513                          ;
   514                          ;                                                             ###        ###
   515                          ;          #####      ####      ####     #    #              #   #      #   #
   516                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   517                          ;          #    #    #    #    #    #    # ## #             #     #    #     #
   518                          ;          #####     #    #    #    #    #    #             #     #    #     #
   519                          ;          #   #     #    #    #    #    #    #              #   #      #   #
   520                          ;          #    #     ####      ####     #    #               ###        ###
   521                          ;
   522                          ; ==============================================================================
   523                          
   524                          
   525                          room_00:
   526                          
   527  11f8 c9a9                                   cmp #$a9                                        ; has the player hit the gloves?
   528  11fa d0f4                                   bne check_next_char_under_player                ; no
   529  11fc a9df                                   lda #$df                                        ; yes, load in char for "empty"
   530  11fe cd6336                                 cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
   531  1201 d0f2                                   bne -                                           ; no
   532  1203 200812                                 jsr pickup_gloves                               ; yes
   533  1206 d0d2                                   bne check_death
   534                          
   535                          
   536                          pickup_gloves:
   537  1208 a96b                                   lda #$6b                                        ; load character for empty bush
   538  120a 8d1e36                                 sta items + $8                                  ; store 6b = gloves in inventory
   539  120d a93d                                   lda #$3d                                        ; set the foreground color
   540  120f 8d1c36                                 sta items + $6                                  ; and store the color in the items table
   541  1212 60                                     rts
   542                          
   543                          
   544                          
   545                          
   546                          
   547                          
   548                          ; ==============================================================================
   549                          ;
   550                          ;                                                             ###        #
   551                          ;          #####      ####      ####     #    #              #   #      ##
   552                          ;          #    #    #    #    #    #    ##  ##             #     #    # #
   553                          ;          #    #    #    #    #    #    # ## #             #     #      #
   554                          ;          #####     #    #    #    #    #    #             #     #      #
   555                          ;          #   #     #    #    #    #    #    #              #   #       #
   556                          ;          #    #     ####      ####     #    #               ###      #####
   557                          ;
   558                          ; ==============================================================================
   559                          
   560                          room_01:
   561                          
   562  1213 c9e0                                   cmp #$e0                                    ; empty character in charset -> invisible key
   563  1215 f004                                   beq +                                       ; yes, key is there -> +
   564  1217 c9e1                                   cmp #$e1
   565  1219 d014                                   bne ++
   566  121b a9aa               +                   lda #$aa                                    ; display the key, $AA = 1st part of key
   567  121d 8d2636                                 sta items + $10                             ; store key in items list
   568  1220 20d237                                 jsr update_items_display                    ; update all items in the items list (we just made the key visible)
   569  1223 a0f0                                   ldy #$f0                                    ; set waiting time
   570  1225 20ff39                                 jsr wait                                    ; wait
   571  1228 a9df                                   lda #$df                                    ; set key to empty space
   572  122a 8d2636                                 sta items + $10                             ; update items list
   573  122d d0ab                                   bne check_death
   574  122f c927               ++                  cmp #$27                                    ; question mark (I don't know why 27)
   575  1231 b005                                   bcs check_death_bush
   576  1233 a000                                   ldy #$00
   577  1235 4c2c10                                 jmp prep_and_display_hint
   578                          
   579                          check_death_bush:
   580  1238 c9ad                                   cmp #$ad                                    ; wirecutters
   581  123a d0b4                                   bne check_next_char_under_player
   582  123c ad1e36                                 lda items + $8                              ; inventory place for the gloves! 6b = gloves
   583  123f c96b                                   cmp #$6b
   584  1241 f005                                   beq +
   585  1243 a00f                                   ldy #$0f
   586  1245 4ce33a                                 jmp death                                   ; 0f You were wounded by the bush!
   587                          
   588  1248 a9f9               +                   lda #$f9                                    ; wirecutter picked up
   589  124a 8d2f36                                 sta items + $19
   590  124d 4cda11                                 jmp check_death
   591                          
   592                          
   593                          
   594                          
   595                          
   596                          
   597                          ; ==============================================================================
   598                          ;
   599                          ;                                                             ###       #####
   600                          ;          #####      ####      ####     #    #              #   #     #     #
   601                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   602                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   603                          ;          #####     #    #    #    #    #    #             #     #    #
   604                          ;          #   #     #    #    #    #    #    #              #   #     #
   605                          ;          #    #     ####      ####     #    #               ###      #######
   606                          ;
   607                          ; ==============================================================================
   608                          
   609                          room_02:
   610                          
   611  1250 c9f5                                   cmp #$f5                                    ; did the player hit the fence? f5 = fence character
   612  1252 d014                                   bne check_lock                              ; no, check for the lock
   613  1254 ad2f36                                 lda items + $19                             ; fence was hit, so check if wirecuter was picked up
   614  1257 c9f9                                   cmp #$f9                                    ; where the wirecutters (f9) picked up?
   615  1259 f005                                   beq remove_fence                            ; yes
   616  125b a010                                   ldy #$10                                    ; no, load the correct death message
   617  125d 4ce33a                                 jmp death                                   ; 10 You are trapped in wire-nettings!
   618                          
   619                          remove_fence:
   620  1260 a9df                                   lda #$df                                    ; empty char
   621  1262 8db538                                 sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
   622  1265 4cda11             m1264:              jmp check_death
   623                          
   624                          
   625                          check_lock:
   626  1268 c9a6                                   cmp #$a6                                    ; lock
   627  126a d00e                                   bne +
   628  126c ad2636                                 lda items + $10
   629  126f c9df                                   cmp #$df
   630  1271 d0f2                                   bne m1264
   631  1273 a9df                                   lda #$df
   632  1275 8d4e36                                 sta items + $38
   633  1278 d0eb                                   bne m1264
   634  127a c9b1               +                   cmp #$b1                                    ; ladder
   635  127c d00a                                   bne +
   636  127e a9df                                   lda #$df
   637  1280 8d6336                                 sta items + $4d
   638  1283 8d6e36                                 sta items + $58
   639  1286 d0dd                                   bne m1264
   640  1288 c9b9               +                   cmp #$b9                                    ; bottle
   641  128a f003                                   beq +
   642  128c 4cf011                                 jmp check_next_char_under_player
   643  128f add136             +                   lda items + $bb
   644  1292 c9df                                   cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
   645  1294 f005                                   beq take_key_out_of_bottle                                   
   646  1296 a003                                   ldy #$03
   647  1298 4ce33a                                 jmp death                                   ; 03 You drank from the poisend bottle
   648                          
   649                          take_key_out_of_bottle:
   650  129b a901                                   lda #$01
   651  129d 8da512                                 sta key_in_bottle_storage
   652  12a0 a005                                   ldy #$05
   653  12a2 4c2c10                                 jmp prep_and_display_hint
   654                          
   655                          ; ==============================================================================
   656                          ; this is 1 if the key from the bottle was taken and 0 if not
   657                          
   658  12a5 00                 key_in_bottle_storage:              !byte $00
   659                          
   660                          
   661                          
   662                          
   663                          
   664                          
   665                          
   666                          
   667                          
   668                          ; ==============================================================================
   669                          ;
   670                          ;                                                             ###       #####
   671                          ;          #####      ####      ####     #    #              #   #     #     #
   672                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   673                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   674                          ;          #####     #    #    #    #    #    #             #     #          #
   675                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   676                          ;          #    #     ####      ####     #    #               ###       #####
   677                          ;
   678                          ; ==============================================================================
   679                          
   680                          room_03:
   681                          
   682  12a6 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   683  12a8 9003                                   bcc +
   684  12aa 4cd53a                                 jmp main_loop
   685  12ad a004               +                   ldy #$04
   686  12af 4c2c10                                 jmp prep_and_display_hint
   687                          
   688                          
   689                          
   690                          
   691                          
   692                          
   693                          ; ==============================================================================
   694                          ;
   695                          ;                                                             ###      #
   696                          ;          #####      ####      ####     #    #              #   #     #    #
   697                          ;          #    #    #    #    #    #    ##  ##             #     #    #    #
   698                          ;          #    #    #    #    #    #    # ## #             #     #    #    #
   699                          ;          #####     #    #    #    #    #    #             #     #    #######
   700                          ;          #   #     #    #    #    #    #    #              #   #          #
   701                          ;          #    #     ####      ####     #    #               ###           #
   702                          ;
   703                          ; ==============================================================================
   704                          
   705                          room_04:
   706                          
   707  12b2 c93b                                   cmp #$3b                                    ; you bumped into a zombie coffin?
   708  12b4 f004                                   beq +                                       ; yep
   709  12b6 c942                                   cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
   710  12b8 d005                                   bne ++                                      ; no, really, I didn't ( I swear! )-> ++
   711  12ba a00d               +                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
   712  12bc 4ce33a                                 jmp death                                   ; 0d You found a thirsty zombie....
   713                          
   714                          ++
   715  12bf c9f7                                   cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
   716  12c1 f007                                   beq +                                       ; seems you picked a coffin that contained something different...
   717  12c3 c9f8                                   cmp #$f8
   718  12c5 f003                                   beq +
   719  12c7 4cf011                                 jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
   720  12ca a900               +                   lda #$00                                    ; 
   721  12cc 8d0339                                 sta m394A + 1                               ; some kind of prep for the door to be unlocked 
   722  12cf a006                                   ldy #$06                                    ; display
   723  12d1 4c2c10                                 jmp prep_and_display_hint
   724                          
   725                          
   726                          
   727                          
   728                          
   729                          
   730                          ; ==============================================================================
   731                          ;
   732                          ;                                                             ###      #######
   733                          ;          #####      ####      ####     #    #              #   #     #
   734                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   735                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   736                          ;          #####     #    #    #    #    #    #             #     #          #
   737                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   738                          ;          #    #     ####      ####     #    #               ###       #####
   739                          ;
   740                          ; ==============================================================================
   741                          
   742                          room_05:
   743                          
   744  12d4 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   745  12d6 b005                                   bcs +                                       ; no
   746  12d8 a000                                   ldy #$00                                    ; a = 0
   747  12da 4c2c10                                 jmp prep_and_display_hint
   748                          
   749  12dd c9fd               +                   cmp #$fd                                    ; stone with breathing tube hit?
   750  12df f003                                   beq +                                       ; yes -> +
   751  12e1 4cf011                                 jmp check_next_char_under_player            ; no
   752                          
   753  12e4 a900               +                   lda #$00                                    ; a = 0                  
   754  12e6 acac36                                 ldy items + $96                             ; do you have the shovel? 
   755  12e9 c0df                                   cpy #$df
   756  12eb d008                                   bne +                                       ; no I don't
   757  12ed 8d9138                                 sta breathing_tube_mod + 1                  ; yes, take the breathing tube
   758  12f0 a007                                   ldy #$07                                    ; and display the message
   759  12f2 4c2c10                                 jmp prep_and_display_hint
   760  12f5 4cd53a             +                   jmp main_loop
   761                          
   762                                              ;ldy #$07                                   ; same is happening above and I don't see this being called
   763                                              ;jmp prep_and_display_hint
   764                          
   765                          
   766                          
   767                          
   768                          
   769                          
   770                          ; ==============================================================================
   771                          ;
   772                          ;                                                             ###       #####
   773                          ;          #####      ####      ####     #    #              #   #     #     #
   774                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   775                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   776                          ;          #####     #    #    #    #    #    #             #     #    #     #
   777                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   778                          ;          #    #     ####      ####     #    #               ###       #####
   779                          ;
   780                          ; ==============================================================================
   781                          
   782                          room_06:
   783                          
   784  12f8 c9f6                                   cmp #$f6                                    ; is it a trapped door?
   785  12fa f003                                   beq +                                       ; OMG Yes the room is full of...
   786  12fc 4cf011                                 jmp check_next_char_under_player            ; please move on. nothing happened.
   787  12ff a000               +                   ldy #$00
   788  1301 4ce33a                                 jmp death                                   ; 00 You fell into a snake pit
   789                          
   790                          
   791                          
   792                          
   793                          
   794                          
   795                          ; ==============================================================================
   796                          ;
   797                          ;                                                             ###      #######
   798                          ;          #####      ####      ####     #    #              #   #     #    #
   799                          ;          #    #    #    #    #    #    ##  ##             #     #        #
   800                          ;          #    #    #    #    #    #    # ## #             #     #       #
   801                          ;          #####     #    #    #    #    #    #             #     #      #
   802                          ;          #   #     #    #    #    #    #    #              #   #       #
   803                          ;          #    #     ####      ####     #    #               ###        #
   804                          ;
   805                          ; ==============================================================================
   806                          
   807                          room_07:
   808                                  
   809  1304 c9e3                                   cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
   810  1306 d005                                   bne +
   811  1308 a001                                   ldy #$01                                    ; 01 You'd better watched out for the sacred column
   812  130a 4ce33a                                 jmp death                                   ; bne m1303 <- seems unneccessary
   813                          
   814  130d c95f               +                   cmp #$5f                                    ; seems to be the invisible char for the light
   815  130f f003                                   beq +                                       ; and it was hit -> +
   816  1311 4cf011                                 jmp check_next_char_under_player            ; if not, continue checking
   817                          
   818  1314 a9bc               +                   lda #$bc                                    ; make light visible
   819  1316 8d8a36                                 sta items + $74                             ; but I dont understand how the whole light is shown
   820  1319 a95f                                   lda #$5f                                    ; color?
   821  131b 8d8836                                 sta items + $72                             ; 
   822  131e 20d237                                 jsr update_items_display                    ; and redraw items
   823  1321 a0ff                                   ldy #$ff
   824  1323 20ff39                                 jsr wait                                    ; wait for some time so the player can actually see the light
   825  1326 20ff39                                 jsr wait
   826  1329 20ff39                                 jsr wait
   827  132c 20ff39                                 jsr wait
   828  132f a9df                                   lda #$df
   829  1331 8d8a36                                 sta items + $74                             ; and pick up the light/ remove it from the items list
   830  1334 a900                                   lda #$00
   831  1336 8d8836                                 sta items + $72                             ; also paint the char black
   832  1339 4cda11                                 jmp check_death
   833                          
   834                          
   835                          
   836                          
   837                          
   838                          
   839                          ; ==============================================================================
   840                          ;
   841                          ;                                                             ###       #####
   842                          ;          #####      ####      ####     #    #              #   #     #     #
   843                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   844                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   845                          ;          #####     #    #    #    #    #    #             #     #    #     #
   846                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   847                          ;          #    #     ####      ####     #    #               ###       #####
   848                          ;
   849                          ; ==============================================================================
   850                          
   851                          room_08:
   852                          
   853  133c a000                                   ldy #$00                                    ; y = 0
   854  133e 84a7                                   sty zpA7                                    ; zpA7 = 0
   855  1340 c94b                                   cmp #$4b                                    ; water
   856  1342 d015                                   bne check_item_water
   857  1344 ac9138                                 ldy breathing_tube_mod + 1
   858  1347 d017                                   bne +
   859  1349 209635                                 jsr get_player_pos
   860  134c a918                                   lda #$18                                    ; move player on the other side of the river
   861  134e 8d4235             --                  sta player_pos_x + 1
   862  1351 a90c                                   lda #$0c
   863  1353 8d4035                                 sta player_pos_y + 1
   864  1356 4cd53a             -                   jmp main_loop
   865                          
   866                          
   867                          check_item_water:
   868  1359 c956                                   cmp #$56                                    ; so you want to swim right?
   869  135b d011                                   bne check_item_shovel                       ; nah, not this time -> check_item_shovel
   870  135d ac9138                                 ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
   871  1360 d007               +                   bne +
   872  1362 209635                                 jsr get_player_pos                          ; tube equipped and ready to submerge
   873  1365 a90c                                   lda #$0c
   874  1367 d0e5                                   bne --                                      ; see you on the other side!
   875                          
   876  1369 a002               +                   ldy #$02                                    ; breathing what?
   877  136b 4ce33a                                 jmp death                                   ; 02 You drowned in the deep river
   878                          
   879                          
   880                          check_item_shovel:
   881  136e c9c1                                   cmp #$c1                                    ; wanna have that shovel?
   882  1370 f004                                   beq +                                       ; yup
   883  1372 c9c3                                   cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
   884  1374 d008                                   bne ++                                      ; nah still not interested -> ++
   885  1376 a9df               +                   lda #$df                                    ; alright cool,
   886  1378 8dac36                                 sta items + $96                             ; shovel is yours now
   887  137b 4cda11             --                  jmp check_death
   888                          
   889                          
   890  137e c9ca               ++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
   891  1380 f003                                   beq +                                       ; yup
   892  1382 4cf011                                 jmp check_next_char_under_player
   893  1385 add136             +                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
   894  1388 c9df                                   cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
   895  138a d0ca                                   bne -                                       ; what hammer?
   896  138c a9df                                   lda #$df
   897  138e 8d9a36                                 sta items + $84                             ; these fine boots are yours now, sir
   898  1391 d0e8                                   bne --
   899                          
   900                          
   901                          
   902                          
   903                          
   904                          
   905                          ; ==============================================================================
   906                          ;
   907                          ;                                                             ###       #####
   908                          ;          #####      ####      ####     #    #              #   #     #     #
   909                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   910                          ;          #    #    #    #    #    #    # ## #             #     #     ######
   911                          ;          #####     #    #    #    #    #    #             #     #          #
   912                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   913                          ;          #    #     ####      ####     #    #               ###       #####
   914                          ;
   915                          ; ==============================================================================
   916                          
   917                          room_09:            
   918                          
   919  1393 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   920  1395 9003                                   bcc +                                       ; yes -> +
   921  1397 4cf011                                 jmp check_next_char_under_player            ; continue checking
   922  139a a002               +                   ldy #$02                                    ; display hint
   923  139c 4c2c10                                 jmp prep_and_display_hint
   924                          
   925                          
   926                          
   927                          
   928                          
   929                          
   930                          ; ==============================================================================
   931                          ;
   932                          ;                                                             #        ###
   933                          ;          #####      ####      ####     #    #              ##       #   #
   934                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
   935                          ;          #    #    #    #    #    #    # ## #               #      #     #
   936                          ;          #####     #    #    #    #    #    #               #      #     #
   937                          ;          #   #     #    #    #    #    #    #               #       #   #
   938                          ;          #    #     ####      ####     #    #             #####      ###
   939                          ;
   940                          ; ==============================================================================
   941                          
   942                          room_10:
   943                          
   944  139f c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   945  13a1 b005                                   bcs +
   946  13a3 a000                                   ldy #$00                                    ; display hint
   947  13a5 4c2c10                                 jmp prep_and_display_hint
   948                          
   949  13a8 c9cc               +                   cmp #$cc                                    ; hit the power outlet?
   950  13aa f007                                   beq +                                       ; yes -> +
   951  13ac c9cf                                   cmp #$cf                                    ; hit the power outlet?
   952  13ae f003                                   beq +                                       ; yes -> +
   953  13b0 4cf011                                 jmp check_next_char_under_player            ; no, continue
   954  13b3 a9df               +                   lda #$df                                    
   955  13b5 cd8a36                                 cmp items + $74                             ; light picked up?
   956  13b8 d010                                   bne +                                       ; no -> death
   957  13ba cdde36                                 cmp items + $c8                             ; yes, lightbulb picked up?
   958  13bd d00b                                   bne +                                       ; no -> death
   959  13bf 8dc236                                 sta items + $ac                             ; yes, pick up power outlet
   960  13c2 a959                                   lda #$59                                    ; and make the foot traps visible
   961  13c4 8d4237                                 sta items + $12c                            ; color position for foot traps
   962  13c7 4cda11                                 jmp check_death
   963                          
   964  13ca a006               +                   ldy #$06
   965  13cc 4ce33a                                 jmp death                                   ; 06 240 Volts! You got an electrical shock!
   966                          
   967                          
   968                          
   969                          
   970                          
   971                          
   972                          ; ==============================================================================
   973                          ;
   974                          ;                                                             #        #
   975                          ;          #####      ####      ####     #    #              ##       ##
   976                          ;          #    #    #    #    #    #    ##  ##             # #      # #
   977                          ;          #    #    #    #    #    #    # ## #               #        #
   978                          ;          #####     #    #    #    #    #    #               #        #
   979                          ;          #   #     #    #    #    #    #    #               #        #
   980                          ;          #    #     ####      ####     #    #             #####    #####
   981                          ;
   982                          ; ==============================================================================
   983                          
   984                          room_11:
   985                          
   986  13cf c9d1                                   cmp #$d1                                    ; picking up the hammer?
   987  13d1 f003                                   beq +                                       ; jep
   988  13d3 4cf011                                 jmp check_next_char_under_player            ; no, continue
   989  13d6 a9df               +                   lda #$df                                    ; player takes the hammer
   990  13d8 8dd136                                 sta items + $bb                             ; hammer
   991  13db 4cda11                                 jmp check_death
   992                          
   993                          
   994                          
   995                          
   996                          
   997                          
   998                          ; ==============================================================================
   999                          ;
  1000                          ;                                                             #       #####
  1001                          ;          #####      ####      ####     #    #              ##      #     #
  1002                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1003                          ;          #    #    #    #    #    #    # ## #               #       #####
  1004                          ;          #####     #    #    #    #    #    #               #      #
  1005                          ;          #   #     #    #    #    #    #    #               #      #
  1006                          ;          #    #     ####      ####     #    #             #####    #######
  1007                          ;
  1008                          ; ==============================================================================
  1009                          
  1010                          room_12:
  1011                          
  1012  13de c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1013  13e0 b005                                   bcs +                                       ; no
  1014  13e2 a000                                   ldy #$00                                    
  1015  13e4 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1016                          
  1017  13e7 c9d2               +                   cmp #$d2                                    ; light bulb hit?
  1018  13e9 f007                                   beq +                                       ; yes
  1019  13eb c9d5                                   cmp #$d5                                    ; light bulb hit?
  1020  13ed f003                                   beq +                                       ; yes
  1021  13ef 4cf011                                 jmp check_next_char_under_player            ; no, continue
  1022  13f2 a9df               +                   lda #$df                                    ; pick up light bulb
  1023  13f4 8dde36                                 sta items + $c8
  1024  13f7 4cda11                                 jmp check_death
  1025                          
  1026                          
  1027                          
  1028                          
  1029                          
  1030                          
  1031                          ; ==============================================================================
  1032                          ;
  1033                          ;                                                             #       #####
  1034                          ;          #####      ####      ####     #    #              ##      #     #
  1035                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1036                          ;          #    #    #    #    #    #    # ## #               #       #####
  1037                          ;          #####     #    #    #    #    #    #               #            #
  1038                          ;          #   #     #    #    #    #    #    #               #      #     #
  1039                          ;          #    #     ####      ####     #    #             #####     #####
  1040                          ;
  1041                          ; ==============================================================================
  1042                          
  1043                          room_13:           
  1044                          
  1045  13fa c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1046  13fc b005                                   bcs +
  1047  13fe a000                                   ldy #$00                                    ; message 0 to display
  1048  1400 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1049                          
  1050  1403 c9d6               +                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
  1051  1405 f003                                   beq +                                       ; OUCH!! -> +
  1052  1407 4cf011                                 jmp check_next_char_under_player            ; not stepped into a nail... yet.
  1053  140a ad9a36             +                   lda items + $84                             ; are the boots taken?
  1054  140d c9df                                   cmp #$df                                
  1055  140f f005                                   beq +                                       ; yeah I'm cool these boots are made for nailin'. 
  1056  1411 a007                                   ldy #$07                                    ; death by a thousand nails.
  1057  1413 4ce33a                                 jmp death                                   ; 07 You stepped on a nail!
  1058                          
  1059                          +
  1060  1416 a9e2                                   lda #$e2                                    ; this is also a nail. 
  1061  1418 8deb36                                 sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
  1062  141b 4cda11                                 jmp check_death
  1063                          
  1064                          
  1065                          
  1066                          
  1067                          
  1068                          
  1069                          ; ==============================================================================
  1070                          ;
  1071                          ;                                                             #      #
  1072                          ;          #####      ####      ####     #    #              ##      #    #
  1073                          ;          #    #    #    #    #    #    ##  ##             # #      #    #
  1074                          ;          #    #    #    #    #    #    # ## #               #      #    #
  1075                          ;          #####     #    #    #    #    #    #               #      #######
  1076                          ;          #   #     #    #    #    #    #    #               #           #
  1077                          ;          #    #     ####      ####     #    #             #####         #
  1078                          ;
  1079                          ; ==============================================================================
  1080                          
  1081                          room_14:
  1082                          
  1083  141e c9d7                                   cmp #$d7                                    ; foot trap char
  1084  1420 f003                                   beq +                                       ; stepped into it?
  1085  1422 4cf011                                 jmp check_next_char_under_player            ; not... yet...
  1086  1425 a008               +                   ldy #$08                                    ; go die
  1087  1427 4ce33a                                 jmp death                                   ; 08 A foot trap stopped you!
  1088                          
  1089                          
  1090                          
  1091                          
  1092                          
  1093                          
  1094                          ; ==============================================================================
  1095                          ;
  1096                          ;                                                             #      #######
  1097                          ;          #####      ####      ####     #    #              ##      #
  1098                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1099                          ;          #    #    #    #    #    #    # ## #               #      ######
  1100                          ;          #####     #    #    #    #    #    #               #            #
  1101                          ;          #   #     #    #    #    #    #    #               #      #     #
  1102                          ;          #    #     ####      ####     #    #             #####     #####
  1103                          ;
  1104                          ; ==============================================================================
  1105                          
  1106                          room_15:
  1107                          
  1108  142a c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1109  142c b005                                   bcs +
  1110  142e a000                                   ldy #$00                                    ; display hint
  1111  1430 4c2c10                                 jmp prep_and_display_hint
  1112                          
  1113  1433 4cf011             +                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address
  1114                          
  1115                          
  1116                          
  1117                          
  1118                          
  1119                          
  1120                          ; ==============================================================================
  1121                          ;
  1122                          ;                                                             #       #####
  1123                          ;          #####      ####      ####     #    #              ##      #     #
  1124                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1125                          ;          #    #    #    #    #    #    # ## #               #      ######
  1126                          ;          #####     #    #    #    #    #    #               #      #     #
  1127                          ;          #   #     #    #    #    #    #    #               #      #     #
  1128                          ;          #    #     ####      ####     #    #             #####     #####
  1129                          ;
  1130                          ; ==============================================================================
  1131                          
  1132                          room_16:
  1133                          
  1134  1436 c9f4                                   cmp #$f4                                    ; did you hit the wall in the left cell?
  1135  1438 d005                                   bne +                                       ; I did not! -> +
  1136  143a a00a                                   ldy #$0a                                    ; yeah....
  1137  143c 4ce33a                                 jmp death                                   ; 0a You were locked in and starved!
  1138                          
  1139  143f c9d9               +                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
  1140  1441 f004                                   beq +                                       ; not that I know of...
  1141  1443 c9db                                   cmp #$db                                    ; are you sure? take a look at this slightly different wall
  1142  1445 d005                                   bne ++                                      ; it doesn't look familiar... -> ++
  1143                          
  1144  1447 a009               +                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
  1145  1449 4ce33a                                 jmp death
  1146                          
  1147  144c c9b9               ++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
  1148  144e f007                                   beq +                                       ; yes! -> +
  1149  1450 c9bb                                   cmp #$bb                                    ; here's another part of that bottle for reference
  1150  1452 f003                                   beq +                                       ; yes! -> +
  1151  1454 4cf011                                 jmp check_next_char_under_player            ; no, continue
  1152  1457 a003               +                   ldy #$03                                    ; display code enter screen
  1153  1459 4c2c10                                 jmp prep_and_display_hint
  1154                          
  1155                          
  1156                          
  1157                          
  1158                          
  1159                          
  1160                          ; ==============================================================================
  1161                          ;
  1162                          ;                                                             #      #######
  1163                          ;          #####      ####      ####     #    #              ##      #    #
  1164                          ;          #    #    #    #    #    #    ##  ##             # #          #
  1165                          ;          #    #    #    #    #    #    # ## #               #         #
  1166                          ;          #####     #    #    #    #    #    #               #        #
  1167                          ;          #   #     #    #    #    #    #    #               #        #
  1168                          ;          #    #     ####      ####     #    #             #####      #
  1169                          ;
  1170                          ; ==============================================================================
  1171                          
  1172                          room_17:
  1173                          
  1174  145c c9dd                                   cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
  1175  145e f003                                   beq +                                       ; yup
  1176  1460 4cf011                                 jmp check_next_char_under_player            ; nah not yet.
  1177  1463 a9df               +                   lda #$df                                    ; pick up sword
  1178  1465 8dbd37                                 sta items + $1a7                            ; store in items list
  1179  1468 4cda11                                 jmp check_death
  1180                          
  1181                          
  1182                          
  1183                          
  1184                          
  1185                          
  1186                          ; ==============================================================================
  1187                          ;
  1188                          ;                                                             #       #####
  1189                          ;          #####      ####      ####     #    #              ##      #     #
  1190                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
  1191                          ;          #    #    #    #    #    #    # ## #               #       #####
  1192                          ;          #####     #    #    #    #    #    #               #      #     #
  1193                          ;          #   #     #    #    #    #    #    #               #      #     #
  1194                          ;          #    #     ####      ####     #    #             #####     #####
  1195                          ;
  1196                          ; ==============================================================================
  1197                          
  1198                          room_18:
  1199  146b c981                                   cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
  1200  146d b003                                   bcs +                   
  1201  146f 4cda11                                 jmp check_death
  1202                          
  1203  1472 ada512             +                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
  1204  1475 d003                                   bne +                                       ; yes I actually did (flexes arms)
  1205  1477 4cd53a                                 jmp main_loop                               ; nope
  1206  147a 20263a             +                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
  1207  147d 4c451b                                 jmp print_endscreen                         ; (drops mic)
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
  1240                          
  1241                          
  1242                          
  1243                          
  1244                          
  1245                          
  1246                          
  1247                          
  1248                          
  1249                          ; ==============================================================================
  1250                          ; 
  1251                          ; EVERYTHING ANIMATION RELATED STARTS HERE
  1252                          ; ANIMATIONS FOR
  1253                          ; LASER, BORIS, BELEGRO, STONE, MONSTER
  1254                          ; ==============================================================================
  1255                          
  1256                          ; TODO
  1257                          ; this gets called all the time, no checks 
  1258                          ; needs to be optimized
  1259                          
  1260                          
  1261                          animation_entrypoint:
  1262                                              
  1263                                              ; code below is used to check if the foot traps should be visible
  1264                                              ; it checked for this every single fucking frame
  1265                                              ; moved the foot traps coloring where it belongs (when picking up power outlet)
  1266                                              ;lda items + $ac                         ; $cc (power outlet)
  1267                                              ;cmp #$df                                ; taken?
  1268                                              ;bne +                                   ; no -> +
  1269                                              ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
  1270                                              ;sta items + $12c                        ; originally $0
  1271                          
  1272  1480 acf82f             +                   ldy current_room + 1                    ; load room number
  1273                          
  1274  1483 c011                                   cpy #$11                                ; is it room #17? (Belegro)
  1275  1485 d046                                   bne room_14_prep                         ; no -> m162A
  1276                                              
  1277                                              
  1278  1487 ad1c15                                 lda m14CC + 1                           ; yes, get value from m14CD
  1279  148a d013                                   bne m15FC                               ; 0? -> m15FC
  1280  148c ad4035                                 lda player_pos_y + 1                    ; not 0, get player pos Y
  1281  148f c906                                   cmp #$06                                ; is it 6?
  1282  1491 d00c                                   bne m15FC                               ; no -> m15FC
  1283  1493 ad4235                                 lda player_pos_x + 1                    ; yes, get player pos X
  1284  1496 c918                                   cmp #$18                                ; is player x position $18?
  1285  1498 d005                                   bne m15FC                               ; no -> m15FC
  1286  149a a900                                   lda #$00                                ; yes, load 0
  1287  149c 8da014                                 sta m15FC + 1                           ; store 0 in m15FC+1
  1288  149f a901               m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
  1289  14a1 d016                                   bne +                                   ; is it 0? -> +
  1290  14a3 a006                                   ldy #$06                                ; y = $6
  1291  14a5 a21e               m1602:              ldx #$1e                                ; x = $1e
  1292  14a7 a900                                   lda #$00                                ; a = $0
  1293  14a9 85a7                                   sta zpA7                                ; zpA7 = 0
  1294  14ab 20c734                                 jsr draw_player                         ; TODO
  1295  14ae aea614                                 ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
  1296  14b1 e003                                   cpx #$03                                ; is X = $3?
  1297  14b3 f001                                   beq ++                                  ; yes -> ++
  1298  14b5 ca                                     dex                                     ; x = x -1
  1299  14b6 8ea614             ++                  stx m1602 + 1                           ; store x in m1602+1
  1300  14b9 a978               +                   lda #$78                                ; a = $78
  1301  14bb 85a8                                   sta zpA8                                ; zpA8 = $78
  1302  14bd a949                                   lda #$49                                ; a = $49
  1303  14bf 850a                                   sta zp0A                                ; zp0A = $49
  1304  14c1 a006                                   ldy #$06                                ; y = $06
  1305  14c3 a901                                   lda #$01                                ; a = $01
  1306  14c5 85a7                                   sta zpA7                                ; zpA7 = $01
  1307  14c7 aea614                                 ldx m1602 + 1                           ; get stored x value (should still be the same?)
  1308  14ca 20c734                                 jsr draw_player                         ; TODO
  1309                          
  1310                          
  1311                          room_14_prep:              
  1312  14cd acf82f                                 ldy current_room + 1                    ; load room number
  1313  14d0 c00e                                   cpy #14                                 ; is it #14?
  1314  14d2 d005                                   bne room_15_prep                        ; no -> m148A
  1315  14d4 a020                                   ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
  1316  14d6 20ff39                                 jsr wait                                ; was jmp wait before
  1317                          
  1318                          ; ==============================================================================
  1319                          ; ROOM 15 ANIMATION
  1320                          ; MOVEMENT OF THE MONSTER
  1321                          ; ==============================================================================
  1322                          
  1323                          room_15_prep:              
  1324  14d9 c00f                                   cpy #15                                 ; room 15?
  1325  14db d03a                                   bne room_17_prep                        ; no -> m14C8
  1326  14dd a900                                   lda #$00                                ; 
  1327  14df 85a7                                   sta zpA7
  1328  14e1 a00c                                   ldy #$0c                                ; x/y pos of the monster
  1329  14e3 a206               m1494:              ldx #$06
  1330  14e5 20c734                                 jsr draw_player
  1331  14e8 a9eb                                   lda #$eb                                ; the monster (try 9c for Belegro)
  1332  14ea 85a8                                   sta zpA8
  1333  14ec a939                                   lda #$39                                ; color of the monster's cape
  1334  14ee 850a                                   sta zp0A
  1335  14f0 aee414                                 ldx m1494 + 1                           ; self mod the x position of the monster
  1336  14f3 a901               m14A4:              lda #$01
  1337  14f5 d00a                                   bne m14B2               
  1338  14f7 e006                                   cpx #$06                                ; moved 6 steps?
  1339  14f9 d002                                   bne +                                   ; no, keep moving
  1340  14fb a901                                   lda #$01
  1341  14fd ca                 +                   dex
  1342  14fe 4c0815                                 jmp +                                   ; change direction
  1343                          
  1344                          m14B2:              
  1345  1501 e00b                                   cpx #$0b
  1346  1503 d002                                   bne ++
  1347  1505 a900                                   lda #$00
  1348  1507 e8                 ++                  inx
  1349  1508 8ee414             +                   stx m1494 + 1
  1350  150b 8df414                                 sta m14A4 + 1
  1351  150e a901                                   lda #$01
  1352  1510 85a7                                   sta zpA7
  1353  1512 a00c                                   ldy #$0c
  1354  1514 4cc734                                 jmp draw_player
  1355                                             
  1356                          ; ==============================================================================
  1357                          ; ROOM 17 ANIMATION
  1358                          ;
  1359                          ; ==============================================================================
  1360                          
  1361                          room_17_prep:              
  1362  1517 c011                                   cpy #17                             ; room number 17?
  1363  1519 d014                                   bne +                               ; no -> +
  1364  151b a901               m14CC:              lda #$01                            ; selfmod
  1365  151d f021                                   beq ++                              
  1366                                                                                 
  1367                                              ; was moved here
  1368                                              ; as it was called only from this place
  1369                                              ; jmp m15C1  
  1370  151f a900               m15C1:              lda #$00                            ; a = 0 (selfmod)
  1371  1521 c900                                   cmp #$00                            ; is a = 0?
  1372  1523 d004                                   bne skipper                         ; not 0 -> 15CB
  1373  1525 ee2015                                 inc m15C1 + 1                       ; inc m15C1
  1374  1528 60                                     rts
  1375                                       
  1376  1529 ce2015             skipper:            dec m15C1 + 1                       ; dec $15c2
  1377  152c 4cb335                                 jmp belegro_animation
  1378                          
  1379  152f a90f               +                   lda #$0f                            ; a = $0f
  1380  1531 8db835                                 sta m3624 + 1                       ; selfmod
  1381  1534 8dba35                                 sta m3626 + 1                       ; selfmod
  1382                          
  1383                          
  1384  1537 c00a                                   cpy #10                             ; room number 10?
  1385  1539 d044                                   bne check_if_room_09                ; no -> m1523
  1386  153b ceb82f                                 dec speed_byte                      ; yes, reduce speed
  1387  153e f001                                   beq laser_beam_animation            ; if positive -> laser_beam_animation            
  1388  1540 60                 ++                  rts
  1389                          
  1390                          ; ==============================================================================
  1391                          ; ROOM 10
  1392                          ; LASER BEAM ANIMATION
  1393                          ; ==============================================================================
  1394                          
  1395                          laser_beam_animation:
  1396                                             
  1397  1541 a008                                   ldy #$08                            ; speed of the laser flashing
  1398  1543 8cb82f                                 sty speed_byte                      ; store     
  1399  1546 a9d9                                   lda #$d9
  1400  1548 8505                                   sta zp05                            ; affects the colram of the laser
  1401  154a a905                                   lda #$05                            ; but not understood yet
  1402  154c 8503                                   sta zp03
  1403  154e a97b                                   lda #$7b                            ; position of the laser
  1404  1550 8502                                   sta zp02
  1405  1552 8504                                   sta zp04
  1406  1554 a9df                                   lda #$df                            ; laser beam off
  1407  1556 cd6315                                 cmp m1506 + 1                       
  1408  1559 d002                                   bne +                               
  1409  155b a9d8                                   lda #$d8                            ; laser beam character
  1410  155d 8d6315             +                   sta m1506 + 1                       
  1411  1560 a206                                   ldx #$06                            ; 6 laser beam characters
  1412  1562 a9df               m1506:              lda #$df
  1413  1564 a000                                   ldy #$00
  1414  1566 9102                                   sta (zp02),y
  1415  1568 a9ee                                   lda #$ee
  1416  156a 9104                                   sta (zp04),y
  1417  156c a502                                   lda zp02
  1418  156e 18                                     clc
  1419  156f 6928                                   adc #$28                            ; draws the laser beam
  1420  1571 8502                                   sta zp02
  1421  1573 8504                                   sta zp04
  1422  1575 9004                                   bcc +                               
  1423  1577 e603                                   inc zp03
  1424  1579 e605                                   inc zp05
  1425  157b ca                 +                   dex
  1426  157c d0e4                                   bne m1506                           
  1427  157e 60                 -                   rts
  1428                          
  1429                          ; ==============================================================================
  1430                          
  1431                          check_if_room_09:              
  1432  157f c009                                   cpy #09                         ; room number 09?
  1433  1581 f001                                   beq room_09_counter                           ; yes -> +
  1434  1583 60                                     rts                             ; no
  1435                          
  1436                          room_09_counter:
  1437  1584 a201                                   ldx #$01                                ; x = 1 (selfmod)
  1438  1586 e001                                   cpx #$01                                ; is x = 1?
  1439  1588 f003                                   beq +                                   ; yes -> +
  1440  158a 4ca515                                 jmp boris_the_spider_animation          ; no, jump boris animation
  1441  158d ce8515             +                   dec room_09_counter + 1                 ; decrease initial x
  1442  1590 60                                     rts
  1443                          
  1444                          ; ==============================================================================
  1445                          ;
  1446                          ; I moved this out of the main loop and call it once when changing rooms
  1447                          ; TODO: call it only when room 4 is entered
  1448                          ; ==============================================================================
  1449                          
  1450                          room_04_prep_door:
  1451                                              
  1452  1591 adf82f                                 lda current_room + 1                            ; get current room
  1453  1594 c904                                   cmp #04                                         ; is it 4? (coffins)
  1454  1596 d00c                                   bne ++                                          ; nope
  1455  1598 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  1456  159a ac0339                                 ldy m394A + 1                                   ; 
  1457  159d f002                                   beq +
  1458  159f a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  1459  15a1 8df904             +                   sta SCREENRAM + $f9 
  1460  15a4 60                 ++                  rts
  1461                          
  1462                          ; ==============================================================================
  1463                          ; ROOM 09
  1464                          ; BORIS THE SPIDER ANIMATION
  1465                          ; ==============================================================================
  1466                          
  1467                          boris_the_spider_animation:
  1468                          
  1469  15a5 ee8515                                 inc room_09_counter + 1                           
  1470  15a8 a9d8                                   lda #>COLRAM + 1                               ; affects the color ram position for boris the spider
  1471  15aa 8505                                   sta zp05
  1472  15ac a904                                   lda #>SCREENRAM
  1473  15ae 8503                                   sta zp03
  1474  15b0 a90f                                   lda #$0f
  1475  15b2 8502                                   sta zp02
  1476  15b4 8504                                   sta zp04
  1477  15b6 a206               m1535:              ldx #$06
  1478  15b8 a900               m1537:              lda #$00
  1479  15ba d009                                   bne +
  1480  15bc ca                                     dex
  1481  15bd e002                                   cpx #$02
  1482  15bf d00b                                   bne ++
  1483  15c1 a901                                   lda #$01
  1484  15c3 d007                                   bne ++
  1485  15c5 e8                 +                   inx
  1486  15c6 e007                                   cpx #$07
  1487  15c8 d002                                   bne ++
  1488  15ca a900                                   lda #$00
  1489  15cc 8db915             ++                  sta m1537 + 1
  1490  15cf 8eb715                                 stx m1535 + 1
  1491  15d2 a000               -                   ldy #$00
  1492  15d4 a9df                                   lda #$df
  1493  15d6 9102                                   sta (zp02),y
  1494  15d8 c8                                     iny
  1495  15d9 c8                                     iny
  1496  15da 9102                                   sta (zp02),y
  1497  15dc 88                                     dey
  1498  15dd a9ea                                   lda #$ea
  1499  15df 9102                                   sta (zp02),y
  1500  15e1 9104                                   sta (zp04),y
  1501  15e3 201e16                                 jsr move_boris                       
  1502  15e6 ca                                     dex
  1503  15e7 d0e9                                   bne -
  1504  15e9 a9e4                                   lda #$e4
  1505  15eb 85a8                                   sta zpA8
  1506  15ed a202                                   ldx #$02
  1507  15ef a000               --                  ldy #$00
  1508  15f1 a5a8               -                   lda zpA8
  1509  15f3 9102                                   sta (zp02),y
  1510  15f5 a9da                                   lda #$da
  1511  15f7 9104                                   sta (zp04),y
  1512  15f9 e6a8                                   inc zpA8
  1513  15fb c8                                     iny
  1514  15fc c003                                   cpy #$03
  1515  15fe d0f1                                   bne -
  1516  1600 201e16                                 jsr move_boris                       
  1517  1603 ca                                     dex
  1518  1604 d0e9                                   bne --
  1519  1606 a000                                   ldy #$00
  1520  1608 a9e7                                   lda #$e7
  1521  160a 85a8                                   sta zpA8
  1522  160c b102               -                   lda (zp02),y
  1523  160e c5a8                                   cmp zpA8
  1524  1610 d004                                   bne +
  1525  1612 a9df                                   lda #$df
  1526  1614 9102                                   sta (zp02),y
  1527  1616 e6a8               +                   inc zpA8
  1528  1618 c8                                     iny
  1529  1619 c003                                   cpy #$03
  1530  161b d0ef                                   bne -
  1531  161d 60                                     rts
  1532                          
  1533                          ; ==============================================================================
  1534                          
  1535                          move_boris:
  1536  161e a502                                   lda zp02
  1537  1620 18                                     clc
  1538  1621 6928                                   adc #$28
  1539  1623 8502                                   sta zp02
  1540  1625 8504                                   sta zp04
  1541  1627 9004                                   bcc +                                   
  1542  1629 e603                                   inc zp03
  1543  162b e605                                   inc zp05
  1544  162d 60                 +                   rts
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
  1556                          
  1557                          
  1558                          
  1559                          
  1560                          
  1561                          
  1562                          
  1563                          
  1564                          
  1565                          ; ==============================================================================
  1566                          
  1567                          prep_player_pos:
  1568                          
  1569  162e a209                                   ldx #$09
  1570  1630 bd4403             -                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
  1571  1633 9d5403                                 sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
  1572  1636 ca                                     dex
  1573  1637 d0f7                                   bne -                                   ; so this seems to create a copy of the area under the player
  1574                          
  1575  1639 a902                                   lda #$02                                ; a = 2
  1576  163b 85a7                                   sta zpA7
  1577  163d ae4235                                 ldx player_pos_x + 1                    ; x = player x
  1578  1640 ac4035                                 ldy player_pos_y + 1                    ; y = player y
  1579  1643 20c734                                 jsr draw_player                         ; draw player
  1580  1646 60                                     rts
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
  1593                          
  1594                          
  1595                          
  1596                          
  1597                          
  1598                          
  1599                          
  1600                          
  1601                          
  1602                          ; ==============================================================================
  1603                          ; OBJECT ANIMATION COLLISION ROUTINE
  1604                          ; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
  1605                          ; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
  1606                          ; ==============================================================================
  1607                          
  1608                          object_collision:
  1609                          
  1610  1647 a209                                   ldx #$09                                ; x = 9
  1611                          
  1612                          check_loop:              
  1613                          
  1614  1649 bd4403                                 lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1615  164c c9d8                                   cmp #$d8                                ; check for laser beam
  1616  164e d005                                   bne +                  
  1617                          
  1618  1650 a005               m164E:              ldy #$05
  1619  1652 4ce33a             jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?
  1620                          
  1621  1655 acf82f             +                   ldy current_room + 1                    ; get room number
  1622  1658 c011                                   cpy #17                                 ; is it $11 = #17 (Belegro)?
  1623  165a d010                                   bne +                                   ; nope -> +
  1624  165c c978                                   cmp #$78                                ; hit by the stone?
  1625  165e f008                                   beq ++                                  ; yep -> ++
  1626  1660 c97b                                   cmp #$7b                                ; or another part of the stone?
  1627  1662 f004                                   beq ++                                  ; yes -> ++
  1628  1664 c97e                                   cmp #$7e                                ; or another part of the stone?
  1629  1666 d004                                   bne +                                   ; nah, -> +
  1630  1668 a00b               ++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
  1631  166a d0e6                                   bne jmp_death
  1632  166c c99c               +                   cmp #$9c                                ; so Belegro hit you?
  1633  166e 9007                                   bcc m1676
  1634  1670 c9a5                                   cmp #$a5
  1635  1672 b003                                   bcs m1676
  1636  1674 4ca816                                 jmp m16A7
  1637                          
  1638  1677 c9e4               m1676:              cmp #$e4                                ; hit by Boris the spider?
  1639  1679 9010                                   bcc +                           
  1640  167b c9eb                                   cmp #$eb
  1641  167d b004                                   bcs ++                          
  1642  167f a004               -                   ldy #$04                                ; 04 Boris the spider got you and killed you
  1643  1681 d0cf                                   bne jmp_death                       
  1644  1683 c9f4               ++                  cmp #$f4
  1645  1685 b004                                   bcs +                           
  1646  1687 a00e                                   ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
  1647  1689 d0c7                                   bne jmp_death                       
  1648  168b ca                 +                   dex
  1649  168c d0bb                                   bne check_loop   
  1650                          
  1651                          
  1652                          
  1653  168e a209                                   ldx #$09
  1654  1690 bd5403             --                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
  1655  1693 9d4403                                 sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1656  1696 c9d8                                   cmp #$d8
  1657  1698 f0b6                                   beq m164E                       
  1658  169a c9e4                                   cmp #$e4
  1659  169c 9004                                   bcc +                           
  1660  169e c9ea                                   cmp #$ea
  1661  16a0 90dd                                   bcc -                           
  1662  16a2 ca                 +                   dex
  1663  16a3 d0eb                                   bne --                          
  1664  16a5 4ce011                                 jmp m11E0                     
  1665                          
  1666                          m16A7:
  1667  16a8 acbd37                                 ldy items + $1a7                        ; do you have the sword?
  1668  16ab c0df                                   cpy #$df
  1669  16ad f004                                   beq +                                   ; yes -> +                        
  1670  16af a00c                                   ldy #$0c                                ; 0c Belegro killed you!
  1671  16b1 d09f                                   bne jmp_death                       
  1672  16b3 a000               +                   ldy #$00
  1673  16b5 8c1c15                                 sty m14CC + 1                   
  1674  16b8 4c7716                                 jmp m1676                       
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
  1703                          
  1704                          
  1705                          
  1706                          
  1707                          
  1708                          
  1709                          
  1710                          
  1711                          
  1712                          ; ==============================================================================
  1713                          ; this might be the inventory/ world reset
  1714                          ; puts all items into the level data again
  1715                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1716                          ; addresses are mostly within items.asm address space ( $368a )
  1717                          ; contains color information of the chars
  1718                          ; ==============================================================================
  1719                          
  1720                          reset_items:
  1721  16bb a9a5                                   lda #$a5                        ; $a5 = lock of the shed
  1722  16bd 8d4e36                                 sta items + $38
  1723                          
  1724  16c0 a9a9                                   lda #$a9                        ;
  1725  16c2 8d1e36                                 sta items + $8                  ; gloves
  1726  16c5 a979                                   lda #$79
  1727  16c7 8d1c36                                 sta items + $6                  ; gloves color
  1728                          
  1729  16ca a9e0                                   lda #$e0                        ; empty char
  1730  16cc 8d2636                                 sta items + $10                 ; invisible key
  1731                          
  1732  16cf a9ac                                   lda #$ac                        ; wirecutter
  1733  16d1 8d2f36                                 sta items + $19
  1734                          
  1735  16d4 a9b8                                   lda #$b8                        ; bottle
  1736  16d6 8d3f36                                 sta items + $29
  1737                          
  1738  16d9 a9b0                                   lda #$b0                        ; ladder
  1739  16db 8d6336                                 sta items + $4d
  1740  16de a9b5                                   lda #$b5                        ; more ladder
  1741  16e0 8d6e36                                 sta items + $58
  1742                          
  1743  16e3 a95e                                   lda #$5e                        ; seems to be water?
  1744  16e5 8d8a36                                 sta items + $74
  1745                          
  1746  16e8 a9c6                                   lda #$c6                        ; boots in the whatever box
  1747  16ea 8d9a36                                 sta items + $84
  1748                          
  1749  16ed a9c0                                   lda #$c0                        ; shovel
  1750  16ef 8dac36                                 sta items + $96
  1751                          
  1752  16f2 a9cc                                   lda #$cc                        ; power outlet
  1753  16f4 8dc236                                 sta items + $ac
  1754                          
  1755  16f7 a9d0                                   lda #$d0                        ; hammer
  1756  16f9 8dd136                                 sta items + $bb
  1757                          
  1758  16fc a9d2                                   lda #$d2                        ; light bulb
  1759  16fe 8dde36                                 sta items + $c8
  1760                          
  1761  1701 a9d6                                   lda #$d6                        ; nails
  1762  1703 8deb36                                 sta items + $d5
  1763                          
  1764  1706 a900                                   lda #$00                        ; door
  1765  1708 8d4237                                 sta items + $12c
  1766                          
  1767  170b a9dd                                   lda #$dd                        ; sword
  1768  170d 8dbd37                                 sta items + $1a7
  1769                          
  1770  1710 a901                                   lda #$01                        ; -> wrong write, produced selfmod at the wrong place
  1771  1712 8d0339                                 sta m394A + 1                   ; sta items + $2c1
  1772                          
  1773  1715 a901                                   lda #$01                        ; 
  1774  1717 8d9138                                 sta breathing_tube_mod + 1      ; sta items + $30a
  1775                          
  1776  171a a9f5                                   lda #$f5                        ; fence
  1777  171c 8db538                                 sta delete_fence + 1            ; sta items + $277
  1778                          
  1779  171f a900                                   lda #$00                        ; key in the bottle
  1780  1721 8da512                                 sta key_in_bottle_storage
  1781                          
  1782  1724 a901                                   lda #$01                        ; door
  1783  1726 8da014                                 sta m15FC + 1
  1784                          
  1785  1729 a91e                                   lda #$1e
  1786  172b 8da614                                 sta m1602 + 1
  1787                          
  1788  172e a901                                   lda #$01
  1789  1730 8d1c15                                 sta m14CC + 1
  1790                          
  1791  1733 a205               m1732:              ldx #$05
  1792  1735 e007                                   cpx #$07
  1793  1737 d002                                   bne +
  1794  1739 a2ff                                   ldx #$ff
  1795  173b e8                 +                   inx
  1796  173c 8e3417                                 stx m1732 + 1                   ; stx $1733
  1797  173f bd4817                                 lda m1747,x                     ; lda $1747,x
  1798  1742 8d0b39                                 sta m3952 + 1                   ; sta $3953
  1799  1745 4cb030                                 jmp print_title                 ; jmp $310d
  1800                                              
  1801                          ; ==============================================================================
  1802                          
  1803                          m1747:
  1804  1748 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1805                          
  1806                          
  1807                          m174F:
  1808  1750 e00c                                   cpx #$0c
  1809  1752 d002                                   bne +
  1810  1754 a949                                   lda #$49
  1811  1756 e00d               +                   cpx #$0d
  1812  1758 d002                                   bne +
  1813  175a a945                                   lda #$45
  1814  175c 60                 +                   rts
  1815                          
  1816                          
  1817                          
  1818                          screen_win_src:
  1819                                              !if LANGUAGE = EN{
  1820                                                  !bin "includes/screen-win-en.scr"
  1821                                              }
  1822                                              !if LANGUAGE = DE{
  1823  175d 7040404040404040...                        !bin "includes/screen-win-de.scr"
  1824                                              }
  1825                          screen_win_src_end:
  1826                          
  1827                          
  1828                          ; ==============================================================================
  1829                          ;
  1830                          ; PRINT WIN SCREEN
  1831                          ; ==============================================================================
  1832                          
  1833                          print_endscreen:
  1834  1b45 a904                                   lda #>SCREENRAM
  1835  1b47 8503                                   sta zp03
  1836  1b49 a9d8                                   lda #>COLRAM
  1837  1b4b 8505                                   sta zp05
  1838  1b4d a900                                   lda #<SCREENRAM
  1839  1b4f 8502                                   sta zp02
  1840  1b51 8504                                   sta zp04
  1841  1b53 a204                                   ldx #$04
  1842  1b55 a917                                   lda #>screen_win_src
  1843  1b57 85a8                                   sta zpA8
  1844  1b59 a95d                                   lda #<screen_win_src
  1845  1b5b 85a7                                   sta zpA7
  1846  1b5d a000                                   ldy #$00
  1847  1b5f b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1848  1b61 9102                                   sta (zp02),y        ; to SCREEN
  1849  1b63 a900                                   lda #$00            ; color = BLACK
  1850  1b65 9104                                   sta (zp04),y        ; to COLRAM
  1851  1b67 c8                                     iny
  1852  1b68 d0f5                                   bne -
  1853  1b6a e603                                   inc zp03
  1854  1b6c e605                                   inc zp05
  1855  1b6e e6a8                                   inc zpA8
  1856  1b70 ca                                     dex
  1857  1b71 d0ec                                   bne -
  1858  1b73 a907                                   lda #$07                  ; yellow
  1859  1b75 8d21d0                                 sta BG_COLOR              ; background
  1860  1b78 8d20d0                                 sta BORDER_COLOR          ; und border
  1861  1b7b a5cb               -                   lda $cb                   ; lda #$fd
  1862                                                                        ; sta KEYBOARD_LATCH
  1863                                                                        ; lda KEYBOARD_LATCH
  1864                                                                        ; and #$80           ; WAITKEY?
  1865                                              
  1866  1b7d c93c                                   cmp #$3c                  ; check for space key on C64
  1867  1b7f d0fa                                   bne -
  1868  1b81 20b030                                 jsr print_title
  1869  1b84 20b030                                 jsr print_title
  1870  1b87 4c423a                                 jmp init
  1871                          
  1872                          
  1873                          ; ==============================================================================
  1874                          ;
  1875                          ; INTRO TEXT SCREEN
  1876                          ; ==============================================================================
  1877                          
  1878                          intro_text:
  1879                          
  1880                          ; instructions screen
  1881                          ; "Search the treasure..."
  1882                          
  1883                          !if LANGUAGE = EN{
  1884                          !scr "Search the treasure of Ghost Town and   "
  1885                          !scr "open it ! Kill Belegro, the wizard, and "
  1886                          !scr "dodge all other dangers. Don't forget to"
  1887                          !scr "use all the items you'll find during    "
  1888                          !scr "your journey through 19 amazing hires-  "
  1889                          !scr "graphics-rooms! Enjoy the quest and play"
  1890                          !scr "it again and again and again ...        "
  1891                          !scr "                                        "
  1892                          !scr "         Press fire to start !          "
  1893                          }
  1894                          
  1895                          !if LANGUAGE = DE{
  1896  1b8a 53150308050e2053...!scr "Suchen Sie die Schatztruhe der Geister- "
  1897  1bb2 131401041420150e...!scr "stadt und oeffnen Sie diese ! Toeten    "
  1898  1bda 5309052042050c05...!scr "Sie Belegro, den Zauberer und weichen   "
  1899  1c02 530905201609050c...!scr "Sie vielen anderen Wesen geschickt aus. "
  1900  1c2a 42050409050e050e...!scr "Bedienen Sie sich an den vielen Gegen-  "
  1901  1c52 131401050e04050e...!scr "staenden, welche sich in den 19 Bildern "
  1902  1c7a 020506090e04050e...!scr "befinden. Viel Spass !                  "
  1903  1ca2 2020202020202020...!scr "                                        "
  1904  1cca 2020202044121505...!scr "    Druecken Sie Feuer zum Starten !    "
  1905                          }
  1906                          
  1907                          ; ==============================================================================
  1908                          ;
  1909                          ; DISPLAY INTRO TEXT
  1910                          ; ==============================================================================
  1911                          
  1912                          display_intro_text:
  1913                          
  1914                                              ; i think this part displays the introduction text
  1915                          
  1916  1cf2 a904                                   lda #>SCREENRAM       ; lda #$0c
  1917  1cf4 8503                                   sta zp03
  1918  1cf6 a9d8                                   lda #>COLRAM        ; lda #$08
  1919  1cf8 8505                                   sta zp05
  1920  1cfa a9a0                                   lda #$a0
  1921  1cfc 8502                                   sta zp02
  1922  1cfe 8504                                   sta zp04
  1923  1d00 a91b                                   lda #>intro_text
  1924  1d02 85a8                                   sta zpA8
  1925  1d04 a98a                                   lda #<intro_text
  1926  1d06 85a7                                   sta zpA7
  1927  1d08 a209                                   ldx #$09
  1928  1d0a a000               --                  ldy #$00
  1929  1d0c b1a7               -                   lda (zpA7),y
  1930  1d0e 9102                                   sta (zp02),y
  1931  1d10 a968                                   lda #$68
  1932  1d12 9104                                   sta (zp04),y
  1933  1d14 c8                                     iny
  1934  1d15 c028                                   cpy #$28
  1935  1d17 d0f3                                   bne -
  1936  1d19 a5a7                                   lda zpA7
  1937  1d1b 18                                     clc
  1938  1d1c 6928                                   adc #$28
  1939  1d1e 85a7                                   sta zpA7
  1940  1d20 9002                                   bcc +
  1941  1d22 e6a8                                   inc zpA8
  1942  1d24 a502               +                   lda zp02
  1943  1d26 18                                     clc
  1944  1d27 6950                                   adc #$50
  1945  1d29 8502                                   sta zp02
  1946  1d2b 8504                                   sta zp04
  1947  1d2d 9004                                   bcc +
  1948  1d2f e603                                   inc zp03
  1949  1d31 e605                                   inc zp05
  1950  1d33 ca                 +                   dex
  1951  1d34 d0d4                                   bne --
  1952  1d36 a900                                   lda #$00
  1953  1d38 8d21d0                                 sta BG_COLOR
  1954  1d3b 60                                     rts
  1955                          
  1956                          ; ==============================================================================
  1957                          ;
  1958                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1959                          ; DECREASES MUSIC VOLUME
  1960                          ; ==============================================================================
  1961                          
  1962                          start_intro:        ;sta KEYBOARD_LATCH
  1963  1d3c 20423b                                 jsr clear                                   ; jsr PRINT_KERNAL
  1964  1d3f 20f21c                                 jsr display_intro_text
  1965  1d42 201e1f                                 jsr check_shift_key
  1966                                              
  1967                                              ;lda #$ba
  1968                                              ;sta music_volume+1                          ; sound volume
  1969  1d45 60                                     rts
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
  1991                          
  1992                          
  1993                          
  1994                          
  1995                          
  1996                          
  1997                          
  1998                          
  1999                          
  2000                          
  2001                          
  2002                          
  2003                          
  2004                          ; ==============================================================================
  2005                          ; MUSIC
  2006                          ; ==============================================================================
  2007                                              !zone MUSIC

; ******** Source: includes/music_data.asm
     1                          ; music! :)
     2                          
     3                          music_data_voice1:
     4  1d46 8445434425262526...!byte $84, $45, $43, $44, $25, $26, $25, $26, $27, $24, $4b, $2c, $2d
     5  1d53 2c2d2e2b44252625...!byte $2c, $2d, $2e, $2b, $44, $25, $26, $25, $26, $27, $24, $46, $64, $66, $47, $67
     6  1d63 6746646647676727...!byte $67, $46, $64, $66, $47, $67, $67, $27, $29, $27, $49, $67, $44, $66, $64, $27
     7  1d73 2927496744666432...!byte $29, $27, $49, $67, $44, $66, $64, $32, $35, $32, $50, $6e, $2f, $30, $31, $30
     8  1d83 3132312f2f4f504f...!byte $31, $32, $31, $2f, $2f, $4f, $50, $4f, $2e, $2f, $30, $31, $30, $31, $32, $31
     9  1d93 2f4f6d6b4e6c6a4f...!byte $2f, $4f, $6d, $6b, $4e, $6c, $6a, $4f, $6d, $6b, $4e, $6c, $6a
    10                          
    11                          music_data_voice2:
    12  1da0 923133             !byte $92, $31, $33
    13  1da3 3131523334333435...!byte $31, $31, $52, $33, $34, $33, $34, $35, $32, $54, $32, $52, $75, $54, $32, $52
    14  1db3 758d8d2c2dce8d8d...!byte $75, $8d, $8d, $2c, $2d, $ce, $8d, $8d, $2c, $2d, $ce, $75, $34, $32, $30, $2e
    15  1dc3 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $35, $32, $35, $32, $35, $32, $2e
    16  1dd3 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $4b, $69, $67, $4c, $6a, $68, $4b
    17  1de3 69674c6a68323332...!byte $69, $67, $4c, $6a, $68, $32, $33, $32, $b2, $33, $31, $32, $33, $34, $35, $36
    18  1df3 3533323131323334...!byte $35, $33, $32, $31, $31, $32, $33, $34, $33, $34, $35, $36, $35, $36, $37, $36
    19  1e03 ea                 !byte $ea

; ******** Source: main.asm
  2009                          ; ==============================================================================
  2010                          music_get_data:
  2011  1e04 a000               .voice1_dur_pt:     ldy #$00
  2012  1e06 d01d                                   bne +
  2013  1e08 a940                                   lda #$40
  2014  1e0a 8d6b1e                                 sta music_voice1+1
  2015  1e0d 206a1e                                 jsr music_voice1
  2016  1e10 a200               .voice1_dat_pt:     ldx #$00
  2017  1e12 bd461d                                 lda music_data_voice1,x
  2018  1e15 ee111e                                 inc .voice1_dat_pt+1
  2019  1e18 a8                                     tay
  2020  1e19 291f                                   and #$1f
  2021  1e1b 8d6b1e                                 sta music_voice1+1
  2022  1e1e 98                                     tya
  2023  1e1f 4a                                     lsr
  2024  1e20 4a                                     lsr
  2025  1e21 4a                                     lsr
  2026  1e22 4a                                     lsr
  2027  1e23 4a                                     lsr
  2028  1e24 a8                                     tay
  2029  1e25 88                 +                   dey
  2030  1e26 8c051e                                 sty .voice1_dur_pt + 1
  2031  1e29 a000               .voice2_dur_pt:     ldy #$00
  2032  1e2b d022                                   bne +
  2033  1e2d a940                                   lda #$40
  2034  1e2f 8d931e                                 sta music_voice2 + 1
  2035  1e32 20921e                                 jsr music_voice2
  2036  1e35 a200               .voice2_dat_pt:     ldx #$00
  2037  1e37 bda01d                                 lda music_data_voice2,x
  2038  1e3a a8                                     tay
  2039  1e3b e8                                     inx
  2040  1e3c e065                                   cpx #$65
  2041  1e3e f019                                   beq music_reset
  2042  1e40 8e361e                                 stx .voice2_dat_pt + 1
  2043  1e43 291f                                   and #$1f
  2044  1e45 8d931e                                 sta music_voice2 + 1
  2045  1e48 98                                     tya
  2046  1e49 4a                                     lsr
  2047  1e4a 4a                                     lsr
  2048  1e4b 4a                                     lsr
  2049  1e4c 4a                                     lsr
  2050  1e4d 4a                                     lsr
  2051  1e4e a8                                     tay
  2052  1e4f 88                 +                   dey
  2053  1e50 8c2a1e                                 sty .voice2_dur_pt + 1
  2054  1e53 206a1e                                 jsr music_voice1
  2055  1e56 4c921e                                 jmp music_voice2
  2056                          ; ==============================================================================
  2057  1e59 a900               music_reset:        lda #$00
  2058  1e5b 8d051e                                 sta .voice1_dur_pt + 1
  2059  1e5e 8d111e                                 sta .voice1_dat_pt + 1
  2060  1e61 8d2a1e                                 sta .voice2_dur_pt + 1
  2061  1e64 8d361e                                 sta .voice2_dat_pt + 1
  2062  1e67 4c041e                                 jmp music_get_data
  2063                          ; ==============================================================================
  2064                          ; write music data for voice1 / voice2 into TED registers
  2065                          ; ==============================================================================
  2066  1e6a a204               music_voice1:       ldx #$04
  2067  1e6c e01c                                   cpx #$1c
  2068  1e6e 9008                                   bcc +
  2069  1e70 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2070  1e73 29ef                                   and #$ef
  2071  1e75 4c8e1e                                 jmp writeFF11
  2072  1e78 bdba1e             +                   lda freq_tab_lo,x
  2073  1e7b 8d0eff                                 sta VOICE1_FREQ_LOW
  2074  1e7e ad12ff                                 lda VOICE1
  2075  1e81 29fc                                   and #$fc
  2076  1e83 1dd21e                                 ora freq_tab_hi, x
  2077  1e86 8d12ff                                 sta VOICE1
  2078  1e89 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2079  1e8c 0910                                   ora #$10
  2080  1e8e 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  2081  1e91 60                                     rts
  2082                          ; ==============================================================================
  2083  1e92 a20d               music_voice2:       ldx #$0d
  2084  1e94 e01c                                   cpx #$1c
  2085  1e96 9008                                   bcc +
  2086  1e98 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2087  1e9b 29df                                   and #$df
  2088  1e9d 4c8e1e                                 jmp writeFF11
  2089  1ea0 bdba1e             +                   lda freq_tab_lo,x
  2090  1ea3 8d0fff                                 sta VOICE2_FREQ_LOW
  2091  1ea6 ad10ff                                 lda VOICE2
  2092  1ea9 29fc                                   and #$fc
  2093  1eab 1dd21e                                 ora freq_tab_hi,x
  2094  1eae 8d10ff                                 sta VOICE2
  2095  1eb1 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2096  1eb4 0920                                   ora #$20
  2097  1eb6 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2098  1eb9 60                                     rts
  2099                          ; ==============================================================================
  2100                          ; TED frequency tables
  2101                          ; ==============================================================================
  2102  1eba 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  2103  1ec1 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  2104  1ec8 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  2105  1ecf 818f95                                 !byte $81, $8f, $95
  2106  1ed2 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  2107  1ed9 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  2108  1ee0 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  2109  1ee7 030303                                 !byte $03, $03, $03
  2110                          ; ==============================================================================
  2111                                              MUSIC_DELAY_INITIAL   = $09
  2112                                              MUSIC_DELAY           = $0B
  2113  1eea a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  2114  1eec ca                                     dex
  2115  1eed 8eeb1e                                 stx music_play+1
  2116  1ef0 f001                                   beq +
  2117  1ef2 60                                     rts
  2118  1ef3 a20b               +                   ldx #MUSIC_DELAY
  2119  1ef5 8eeb1e                                 stx music_play+1
  2120  1ef8 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2121  1efb 0937                                   ora #$37
  2122  1efd 29bf               music_volume:       and #$bf
  2123  1eff 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2124  1f02 4c041e                                 jmp music_get_data
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
  2144                          
  2145                          
  2146                          
  2147                          
  2148                          
  2149                          
  2150                          
  2151                          
  2152                          
  2153                          
  2154                          
  2155                          
  2156                          
  2157                          ; ==============================================================================
  2158                          ; irq init
  2159                          ; ==============================================================================
  2160                                              !zone IRQ
  2161  1f05 78                 irq_init0:          sei
  2162  1f06 a929                                   lda #<irq0          ; lda #$06
  2163  1f08 8d1403                                 sta $0314          ; irq lo
  2164  1f0b a91f                                   lda #>irq0          ; lda #$1f
  2165  1f0d 8d1503                                 sta $0315          ; irq hi
  2166                                                                  ; irq at $1F06
  2167  1f10 a901                                   lda #$01            ;lda #$02
  2168  1f12 8d1ad0                                 sta $d01a           ; sta FF0A          ; set IRQ source to RASTER
  2169                          
  2170  1f15 a9bf                                   lda #$bf
  2171  1f17 8dfe1e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  2172  1f1a 58                                     cli
  2173                          
  2174  1f1b 4c263a                                 jmp set_charset_and_screen
  2175                          
  2176                          ; ==============================================================================
  2177                          ; intro text
  2178                          ; wait for shift or joy2 fire press
  2179                          ; ==============================================================================
  2180                          
  2181                          check_shift_key:
  2182                          
  2183  1f1e ad00dc             -                   lda $dc00
  2184  1f21 4a                                     lsr
  2185  1f22 4a                                     lsr
  2186  1f23 4a                                     lsr
  2187  1f24 4a                                     lsr
  2188  1f25 4a                                     lsr
  2189  1f26 b0f6                                   bcs -
  2190  1f28 60                                     rts
  2191                          
  2192                          ; ==============================================================================
  2193                          ;
  2194                          ; INTERRUPT routine for music
  2195                          ; ==============================================================================
  2196                          
  2197                                              ; *= $1F06
  2198                          irq0:
  2199  1f29 ce09ff                                 DEC INTERRUPT
  2200                          
  2201                                                                  ; this IRQ seems to handle music only!
  2202                                              !if SILENT_MODE = 1 {
  2203                                                  jsr fake
  2204                                              } else {
  2205  1f2c 20ea1e                                     jsr music_play
  2206                                              }
  2207  1f2f 68                                     pla
  2208  1f30 a8                                     tay
  2209  1f31 68                                     pla
  2210  1f32 aa                                     tax
  2211  1f33 68                                     pla
  2212  1f34 40                                     rti
  2213                          
  2214                          ; ==============================================================================
  2215                          ; checks if the music volume is at the desired level
  2216                          ; and increases it if not
  2217                          ; if volume is high enough, it initializes the music irq routine
  2218                          ; is called right at the start of the game, but also when a game ended
  2219                          ; and is about to show the title screen again (increasing the volume)
  2220                          ; ==============================================================================
  2221                          
  2222                          init_music:                                  
  2223  1f35 adfe1e                                 lda music_volume+1                              ; sound volume
  2224  1f38 c9bf               --                  cmp #$bf                                        ; is true on init
  2225  1f3a d003                                   bne +
  2226  1f3c 4c051f                                 jmp irq_init0
  2227  1f3f a204               +                   ldx #$04
  2228  1f41 86a8               -                   stx zpA8                                        ; buffer serial input byte ?
  2229  1f43 a0ff                                   ldy #$ff
  2230  1f45 20ff39                                 jsr wait
  2231  1f48 a6a8                                   ldx zpA8
  2232  1f4a ca                                     dex
  2233  1f4b d0f4                                   bne -                                               
  2234  1f4d 18                                     clc
  2235  1f4e 6901                                   adc #$01                                        ; increases volume again before returning to title screen
  2236  1f50 8dfe1e                                 sta music_volume+1                              ; sound volume
  2237  1f53 4c381f                                 jmp --
  2238                          
  2239                          
  2240                          
  2241                                              ; 222222222222222         000000000          000000000          000000000
  2242                                              ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
  2243                                              ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2244                                              ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2245                                              ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2246                                              ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2247                                              ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2248                                              ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2249                                              ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2250                                              ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2251                                              ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2252                                              ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2253                                              ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2254                                              ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2255                                              ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
  2256                                              ;22222222222222222222     000000000          000000000          000000000
  2257                          
  2258                          ; ==============================================================================
  2259                          ; CHARSET
  2260                          ; $2000 - $2800
  2261                          ; ==============================================================================
  2262                          
  2263                          
  2264                          charset_start:
  2265                                              *= $2000
  2266                                              !if EXTENDED {
  2267  2000 000000020a292727...                        !bin "includes/charset_tweaked-charset.bin"
  2268                                              }else{
  2269                                                  !bin "includes/charset.bin" ; !bin "includes/charset.bin"
  2270                                              }
  2271                          charset_end:    ; $2800
  2272                          
  2273                          
  2274                                              ; 222222222222222         888888888          000000000           000000000
  2275                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  2276                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  2277                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2278                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2279                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2280                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  2281                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2282                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2283                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2284                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2285                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2286                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2287                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  2288                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  2289                                              ;22222222222222222222     888888888           000000000           000000000
  2290                          
  2291                          
  2292                          
  2293                          ; ==============================================================================
  2294                          ; LEVEL DATA
  2295                          ; Based on tiles
  2296                          ;                     !IMPORTANT!
  2297                          ;                     has to be page aligned or
  2298                          ;                     display_room routine will fail
  2299                          ; ==============================================================================
  2300                          
  2301                                              *= $2800
  2302                          level_data:

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
  2304                          level_data_end:
  2305                          
  2306                          
  2307                          ;$2fbf
  2308                          speed_byte:
  2309  2fb8 01                 !byte $01
  2310                          
  2311                          
  2312                          
  2313                          
  2314                          
  2315                          ; ==============================================================================
  2316                          ;
  2317                          ;
  2318                          ; ==============================================================================
  2319                                  
  2320                          
  2321                          rasterpoll_and_other_stuff:
  2322                          
  2323  2fb9 209f35                                 jsr poll_raster
  2324  2fbc 20c039                                 jsr check_door 
  2325  2fbf 4c8014                                 jmp animation_entrypoint          
  2326                          
  2327                          
  2328                          
  2329                          ; ==============================================================================
  2330                          ;
  2331                          ; tileset definition
  2332                          ; these are the first characters in the charset of each tile.
  2333                          ; example: rocks start at $0c and span 9 characters in total
  2334                          ; ==============================================================================
  2335                          
  2336                          tileset_definition:
  2337                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  2338  2fc2 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
  2339                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2340  2fca 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
  2341                                              ;     $10
  2342  2fd2 03                                     !byte $03                                           ; door
  2343                          
  2344                          !if EXTENDED = 0{
  2345                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2346                                              !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
  2347                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2348                                              !byte $1e, $1e, $1e, $3d, $3d, $0d, $2f, $2f
  2349                                              ;     $10
  2350                                              !byte $0a
  2351                          }
  2352                          
  2353                          !if EXTENDED = 1{
  2354                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2355  2fd3 000a0a0e3d7f2a2a                       !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
  2356                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2357  2fdb 1e1e1e3d3d0d2f2f                       !byte $1e, $1e, $1e, $3d, $3d, $0d, $2f, $2f
  2358                                              ;     $10
  2359  2fe3 0a                                     !byte $0a  
  2360                          }
  2361                          
  2362                          ; ==============================================================================
  2363                          ;
  2364                          ; displays a room based on tiles
  2365                          ; ==============================================================================
  2366                          
  2367                          display_room:       
  2368  2fe4 208b3a                                 jsr draw_border
  2369  2fe7 a900                                   lda #$00
  2370  2fe9 8502                                   sta zp02
  2371  2feb a2d8                                   ldx #>COLRAM        ; HiByte of COLRAM
  2372  2fed 8605                                   stx zp05
  2373  2fef a204                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  2374  2ff1 8603                                   stx zp03
  2375  2ff3 a228                                   ldx #>level_data    ; HiByte of level_data
  2376  2ff5 860a                                   stx zp0A            ; in zp0A
  2377  2ff7 a201               current_room:       ldx #$01            ; current_room in X
  2378  2ff9 f00a                                   beq ++              ; if 0 -> skip
  2379  2ffb 18                 -                   clc                 ; else
  2380  2ffc 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  2381  2ffe 9002                                   bcc +               ; to zp09/zp0A
  2382  3000 e60a                                   inc zp0A            ;
  2383  3002 ca                 +                   dex                 ; X times
  2384  3003 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  2385  3005 8509               ++                  sta zp09            ; LoByte from above
  2386  3007 a000                                   ldy #$00
  2387  3009 84a8                                   sty zpA8
  2388  300b 84a7                                   sty zpA7
  2389  300d b109               m3066:              lda (zp09),y        ; get Tilenumber
  2390  300f aa                                     tax                 ; in X
  2391  3010 bdd32f                                 lda tiles_colors,x  ; get Tilecolor
  2392  3013 8510                                   sta zp10            ; => zp10
  2393  3015 bdc22f                                 lda tiles_chars,x   ; get Tilechar
  2394  3018 8511                                   sta zp11            ; => zp11
  2395  301a a203                                   ldx #$03            ; (3 rows)
  2396  301c a000               --                  ldy #$00
  2397  301e a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  2398  3020 8504                                   sta zp04            ; LoByte of COLRAM pointer
  2399  3022 a511                                   lda zp11            ; Load Tilechar
  2400  3024 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  2401  3026 a510                                   lda zp10            ; Load Tilecolor
  2402  3028 9104                                   sta (zp04),y        ; to COLRAM + Y
  2403  302a a511                                   lda zp11            ; Load Tilechar again
  2404  302c c9df                                   cmp #$df            ; if empty tile
  2405  302e f002                                   beq +               ; -> skip
  2406  3030 e611                                   inc zp11            ; else: Tilechar + 1
  2407  3032 c8                 +                   iny                 ; Y = Y + 1
  2408  3033 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  2409  3035 d0e7                                   bne -               ; no -> next Char
  2410  3037 a502                                   lda zp02            ; yes:
  2411  3039 18                                     clc
  2412  303a 6928                                   adc #$28            ; next SCREEN row
  2413  303c 8502                                   sta zp02
  2414  303e 9004                                   bcc +
  2415  3040 e603                                   inc zp03
  2416  3042 e605                                   inc zp05            ; and COLRAM row
  2417  3044 ca                 +                   dex                 ; X = X - 1
  2418  3045 d0d5                                   bne --              ; X != 0 -> next Char
  2419  3047 e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  2420  3049 e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  2421  304b a975                                   lda #$75            ; for m30B8 + 1
  2422  304d a6a8                                   ldx zpA8
  2423  304f e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  2424  3051 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  2425  3053 a6a7                                   ldx zpA7            ; else:
  2426  3055 e066                                   cpx #$66            ; zpA7 >= $66
  2427  3057 b01c                                   bcs display_door    ; yes: display_door
  2428  3059 a900                                   lda #$00            ; else:
  2429  305b 85a8                                   sta zpA8            ; clear zpA8
  2430  305d a924                                   lda #$24            ; for m30B8 + 1
  2431  305f 8d6630             +                   sta m30B8 + 1       ;
  2432  3062 a502                                   lda zp02
  2433  3064 38                                     sec
  2434  3065 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  2435  3067 8502                                   sta zp02
  2436  3069 b004                                   bcs +
  2437  306b c603                                   dec zp03
  2438  306d c605                                   dec zp05
  2439  306f a4a7               +                   ldy zpA7
  2440  3071 4c0d30                                 jmp m3066
  2441  3074 60                                     rts                 ; will this ever be used?
  2442                          
  2443  3075 a904               display_door:       lda #>SCREENRAM
  2444  3077 8503                                   sta zp03
  2445  3079 a9d8                                   lda #>COLRAM
  2446  307b 8505                                   sta zp05
  2447  307d a900                                   lda #$00
  2448  307f 8502                                   sta zp02
  2449  3081 8504                                   sta zp04
  2450  3083 a028               -                   ldy #$28
  2451  3085 b102                                   lda (zp02),y        ; read from SCREENRAM
  2452  3087 c906                                   cmp #$06            ; $06 (part from Door?)
  2453  3089 b00b                                   bcs +               ; >= $06 -> skip
  2454  308b 38                                     sec                 ; else:
  2455  308c e903                                   sbc #$03            ; subtract $03
  2456  308e a000                                   ldy #$00            ; set Y = $00
  2457  3090 9102                                   sta (zp02),y        ; and copy to one row above
  2458  3092 a90a                                   lda #$0a            ; lda #$39 ; color brown - luminance $3  -> color of the top of a door
  2459  3094 9104                                   sta (zp04),y
  2460  3096 a502               +                   lda zp02
  2461  3098 18                                     clc
  2462  3099 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  2463  309b 9004                                   bcc +
  2464  309d e603                                   inc zp03            ; inc pointer HiBytes if necessary
  2465  309f e605                                   inc zp05
  2466  30a1 8502               +                   sta zp02
  2467  30a3 8504                                   sta zp04
  2468  30a5 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  2469  30a7 d0da                                   bne -               ; no -> loop
  2470  30a9 a503                                   lda zp03            ; else:
  2471  30ab c907                                   cmp #>(SCREENRAM+$300)
  2472  30ad d0d4                                   bne -               ; no -> loop
  2473  30af 60                                     rts                 ; else: finally ready with room display
  2474                          
  2475                          ; ==============================================================================
  2476                          
  2477  30b0 a904               print_title:        lda #>SCREENRAM
  2478  30b2 8503                                   sta zp03
  2479  30b4 a9d8                                   lda #>COLRAM
  2480  30b6 8505                                   sta zp05
  2481  30b8 a900                                   lda #<SCREENRAM
  2482  30ba 8502                                   sta zp02
  2483  30bc 8504                                   sta zp04
  2484  30be a930                                   lda #>screen_start_src
  2485  30c0 85a8                                   sta zpA8
  2486  30c2 a9df                                   lda #<screen_start_src
  2487  30c4 85a7                                   sta zpA7
  2488  30c6 a204                                   ldx #$04
  2489  30c8 a000               --                  ldy #$00
  2490  30ca b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  2491  30cc 9102                                   sta (zp02),y        ; nach SCREEN
  2492  30ce a900                                   lda #$00           ; BLACK
  2493  30d0 9104                                   sta (zp04),y        ; nach COLRAM
  2494  30d2 c8                                     iny
  2495  30d3 d0f5                                   bne -
  2496  30d5 e603                                   inc zp03
  2497  30d7 e605                                   inc zp05
  2498  30d9 e6a8                                   inc zpA8
  2499  30db ca                                     dex
  2500  30dc d0ea                                   bne --
  2501  30de 60                                     rts
  2502                          
  2503                          ; ==============================================================================
  2504                          ; TITLE SCREEN DATA
  2505                          ;
  2506                          ; ==============================================================================
  2507                          
  2508                          screen_start_src:
  2509                          
  2510                                              !if EXTENDED {
  2511  30df 20202020202020a0...                        !bin "includes/title-extended.scr"
  2512                                              }else{
  2513                                                  !bin "includes/title.scr"
  2514                                              }
  2515                          
  2516                          screen_start_src_end:
  2517                          
  2518                          
  2519                          ; ==============================================================================
  2520                          ; i think this might be the draw routine for the player sprite
  2521                          ;
  2522                          ; ==============================================================================
  2523                          
  2524                          
  2525                          draw_player:
  2526  34c7 8eea34                                 stx m3548 + 1                       ; store x pos of player
  2527  34ca a9d8                                   lda #>COLRAM                        ; store colram high in zp05
  2528  34cc 8505                                   sta zp05
  2529  34ce a904                                   lda #>SCREENRAM                     ; store screenram high in zp03
  2530  34d0 8503                                   sta zp03
  2531  34d2 a900                                   lda #$00
  2532  34d4 8502                                   sta zp02
  2533  34d6 8504                                   sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
  2534  34d8 c000                                   cpy #$00                            ; Y is probably the player Y position
  2535  34da f00c                                   beq +                               ; Y is 0 -> +
  2536  34dc 18                 -                   clc                                 ; Y not 0
  2537  34dd 6928                                   adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
  2538  34df 9004                                   bcc ++                              ; <256? -> ++
  2539  34e1 e603                                   inc zp03
  2540  34e3 e605                                   inc zp05
  2541  34e5 88                 ++                  dey                                 ; Y = Y - 1
  2542  34e6 d0f4                                   bne -                               ; Y = 0 ? -> -
  2543  34e8 18                 +                   clc                                 ;
  2544  34e9 6916               m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
  2545  34eb 8502                                   sta zp02
  2546  34ed 8504                                   sta zp04
  2547  34ef 9004                                   bcc +
  2548  34f1 e603                                   inc zp03
  2549  34f3 e605                                   inc zp05
  2550  34f5 a203               +                   ldx #$03                            ; draw 3 rows for the player "sprite"
  2551  34f7 a900                                   lda #$00
  2552  34f9 8509                                   sta zp09
  2553  34fb a000               --                  ldy #$00
  2554  34fd a5a7               -                   lda zpA7
  2555  34ff d006                                   bne +
  2556  3501 a9df                                   lda #$df                            ; empty char, but not sure why
  2557  3503 9102                                   sta (zp02),y
  2558  3505 d01b                                   bne ++
  2559  3507 c901               +                   cmp #$01
  2560  3509 d00a                                   bne +
  2561  350b a5a8                                   lda zpA8
  2562  350d 9102                                   sta (zp02),y
  2563  350f a50a                                   lda zp0A
  2564  3511 9104                                   sta (zp04),y
  2565  3513 d00d                                   bne ++
  2566  3515 b102               +                   lda (zp02),y
  2567  3517 8610                                   stx zp10
  2568  3519 a609                                   ldx zp09
  2569  351b 9d4503                                 sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
  2570  351e e609                                   inc zp09
  2571  3520 a610                                   ldx zp10
  2572  3522 e6a8               ++                  inc zpA8
  2573  3524 c8                                     iny
  2574  3525 c003                                   cpy #$03                            ; width of the player sprite in characters (3)
  2575  3527 d0d4                                   bne -
  2576  3529 a502                                   lda zp02
  2577  352b 18                                     clc
  2578  352c 6928                                   adc #$28                            ; $28 = #40, draws one row of the player under each other
  2579  352e 8502                                   sta zp02
  2580  3530 8504                                   sta zp04
  2581  3532 9004                                   bcc +
  2582  3534 e603                                   inc zp03
  2583  3536 e605                                   inc zp05
  2584  3538 ca                 +                   dex
  2585  3539 d0c0                                   bne --
  2586  353b 60                                     rts
  2587                          
  2588                          
  2589                          ; ==============================================================================
  2590                          ; $359b
  2591                          ; JOYSTICK CONTROLS
  2592                          ; ==============================================================================
  2593                          
  2594                          check_joystick:
  2595                          
  2596                                              ;lda #$fd
  2597                                              ;sta KEYBOARD_LATCH
  2598                                              ;lda KEYBOARD_LATCH
  2599  353c ad00dc                                 lda $dc00
  2600  353f a009               player_pos_y:       ldy #$09
  2601  3541 a215               player_pos_x:       ldx #$15
  2602  3543 4a                                     lsr
  2603  3544 b005                                   bcs +
  2604  3546 c000                                   cpy #$00
  2605  3548 f001                                   beq +
  2606  354a 88                                     dey                                           ; JOYSTICK UP
  2607  354b 4a                 +                   lsr
  2608  354c b005                                   bcs +
  2609  354e c015                                   cpy #$15
  2610  3550 b001                                   bcs +
  2611  3552 c8                                     iny                                           ; JOYSTICK DOWN
  2612  3553 4a                 +                   lsr
  2613  3554 b005                                   bcs +
  2614  3556 e000                                   cpx #$00
  2615  3558 f001                                   beq +
  2616  355a ca                                     dex                                           ; JOYSTICK LEFT
  2617  355b 4a                 +                   lsr
  2618  355c b005                                   bcs +
  2619  355e e024                                   cpx #$24
  2620  3560 b001                                   bcs +
  2621  3562 e8                                     inx                                           ; JOYSTICK RIGHT
  2622  3563 8c8135             +                   sty m35E7 + 1
  2623  3566 8e8635                                 stx m35EC + 1
  2624  3569 a902                                   lda #$02
  2625  356b 85a7                                   sta zpA7
  2626  356d 20c734                                 jsr draw_player
  2627  3570 a209                                   ldx #$09
  2628  3572 bd4403             -                   lda TAPE_BUFFER + $8,x
  2629  3575 c9df                                   cmp #$df
  2630  3577 f004                                   beq +
  2631  3579 c9e2                                   cmp #$e2
  2632  357b d00d                                   bne ++
  2633  357d ca                 +                   dex
  2634  357e d0f2                                   bne -
  2635  3580 a90a               m35E7:              lda #$0a
  2636  3582 8d4035                                 sta player_pos_y + 1
  2637  3585 a915               m35EC:              lda #$15
  2638  3587 8d4235                                 sta player_pos_x + 1
  2639                          ++                  ;lda #$ff
  2640                                              ;sta KEYBOARD_LATCH
  2641  358a a901                                   lda #$01
  2642  358c 85a7                                   sta zpA7
  2643  358e a993                                   lda #$93                ; first character of the player graphic
  2644  3590 85a8                                   sta zpA8
  2645  3592 a93d                                   lda #$3d
  2646  3594 850a                                   sta zp0A
  2647  3596 ac4035             get_player_pos:     ldy player_pos_y + 1
  2648  3599 ae4235                                 ldx player_pos_x + 1
  2649                                        
  2650  359c 4cc734                                 jmp draw_player
  2651                          
  2652                          ; ==============================================================================
  2653                          ;
  2654                          ; POLL RASTER
  2655                          ; ==============================================================================
  2656                          
  2657                          poll_raster:
  2658  359f 78                                     sei                     ; disable interrupt
  2659  35a0 a9f0                                   lda #$f0                ; lda #$c0  ;A = $c0
  2660  35a2 cd12d0             -                   cmp FF1D                ; vertical line bits 0-7
  2661                                              
  2662  35a5 d0fb                                   bne -                   ; loop until we hit line c0
  2663  35a7 a900                                   lda #$00                ; A = 0
  2664  35a9 85a7                                   sta zpA7                ; zpA7 = 0
  2665                                              
  2666  35ab 209635                                 jsr get_player_pos
  2667                                              
  2668  35ae 203c35                                 jsr check_joystick
  2669  35b1 58                                     cli
  2670  35b2 60                                     rts
  2671                          
  2672                          
  2673                          ; ==============================================================================
  2674                          ; ROOM 16
  2675                          ; BELEGRO ANIMATION
  2676                          ; ==============================================================================
  2677                          
  2678                          belegro_animation:
  2679                          
  2680  35b3 a900                                   lda #$00
  2681  35b5 85a7                                   sta zpA7
  2682  35b7 a20f               m3624:              ldx #$0f
  2683  35b9 a00f               m3626:              ldy #$0f
  2684  35bb 20c734                                 jsr draw_player
  2685  35be aeb835                                 ldx m3624 + 1
  2686  35c1 acba35                                 ldy m3626 + 1
  2687  35c4 ec4235                                 cpx player_pos_x + 1
  2688  35c7 b002                                   bcs +
  2689  35c9 e8                                     inx
  2690  35ca e8                                     inx
  2691  35cb ec4235             +                   cpx player_pos_x + 1
  2692  35ce f001                                   beq +
  2693  35d0 ca                                     dex
  2694  35d1 cc4035             +                   cpy player_pos_y + 1
  2695  35d4 b002                                   bcs +
  2696  35d6 c8                                     iny
  2697  35d7 c8                                     iny
  2698  35d8 cc4035             +                   cpy player_pos_y + 1
  2699  35db f001                                   beq +
  2700  35dd 88                                     dey
  2701  35de 8ef835             +                   stx m3668 + 1
  2702  35e1 8cfd35                                 sty m366D + 1
  2703  35e4 a902                                   lda #$02
  2704  35e6 85a7                                   sta zpA7
  2705  35e8 20c734                                 jsr draw_player
  2706  35eb a209                                   ldx #$09
  2707  35ed bd4403             -                   lda TAPE_BUFFER + $8,x
  2708  35f0 c992                                   cmp #$92
  2709  35f2 900d                                   bcc +
  2710  35f4 ca                                     dex
  2711  35f5 d0f6                                   bne -
  2712  35f7 a210               m3668:              ldx #$10
  2713  35f9 8eb835                                 stx m3624 + 1
  2714  35fc a00e               m366D:              ldy #$0e
  2715  35fe 8cba35                                 sty m3626 + 1
  2716  3601 a99c               +                   lda #$9c                                ; belegro chars
  2717  3603 85a8                                   sta zpA8
  2718  3605 a93e                                   lda #$3e
  2719  3607 850a                                   sta zp0A
  2720  3609 acba35                                 ldy m3626 + 1
  2721  360c aeb835                                 ldx m3624 + 1                    
  2722  360f a901                                   lda #$01
  2723  3611 85a7                                   sta zpA7
  2724  3613 4cc734                                 jmp draw_player
  2725                          
  2726                          
  2727                          ; ==============================================================================
  2728                          ; items
  2729                          ; This area seems to be responsible for items placement
  2730                          ;
  2731                          ; ==============================================================================
  2732                          
  2733                          items:

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
  2735                          items_end:
  2736                          
  2737                          next_item:
  2738  37c6 a5a7                                   lda zpA7
  2739  37c8 18                                     clc
  2740  37c9 6901                                   adc #$01
  2741  37cb 85a7                                   sta zpA7
  2742  37cd 9002                                   bcc +                       ; bcc $3845
  2743  37cf e6a8                                   inc zpA8
  2744  37d1 60                 +                   rts
  2745                          
  2746                          ; ==============================================================================
  2747                          ; TODO
  2748                          ; no clue yet. level data has already been drawn when this is called
  2749                          ; probably placing the items on the screen
  2750                          ; ==============================================================================
  2751                          
  2752                          update_items_display:
  2753  37d2 a936                                   lda #>items                 ; load address for items into zeropage
  2754  37d4 85a8                                   sta zpA8
  2755  37d6 a916                                   lda #<items
  2756  37d8 85a7                                   sta zpA7
  2757  37da a000                                   ldy #$00                    ; y = 0
  2758  37dc b1a7               --                  lda (zpA7),y                ; load first value
  2759  37de c9ff                                   cmp #$ff                    ; is it $ff?
  2760  37e0 f006                                   beq +                       ; yes -> +
  2761  37e2 20c637             -                   jsr next_item               ; no -> set zero page to next value
  2762  37e5 4cdc37                                 jmp --                      ; and loop
  2763  37e8 20c637             +                   jsr next_item               ; value was $ff, now get the next value in the list
  2764  37eb b1a7                                   lda (zpA7),y
  2765  37ed c9ff                                   cmp #$ff                    ; is the next value $ff again?
  2766  37ef d003                                   bne +
  2767  37f1 4c7638                                 jmp prepare_rooms           ; yes -> m38DF
  2768  37f4 cdf82f             +                   cmp current_room + 1        ; is the number the current room number?
  2769  37f7 d0e9                                   bne -                       ; no -> loop
  2770  37f9 a9d8                                   lda #>COLRAM                ; yes the number is the current room number
  2771  37fb 8505                                   sta zp05                    ; store COLRAM and SCREENRAM in zeropage
  2772  37fd a904                                   lda #>SCREENRAM
  2773  37ff 8503                                   sta zp03
  2774  3801 a900                                   lda #$00                    ; A = 0
  2775  3803 8502                                   sta zp02                    ; zp02 = 0, zp04 = 0
  2776  3805 8504                                   sta zp04
  2777  3807 20c637                                 jsr next_item               ; move to next value
  2778  380a b1a7                                   lda (zpA7),y                ; get next value in the list
  2779  380c c9fe               -                   cmp #$fe                    ; is it $FE?
  2780  380e f00b                                   beq +                       ; yes -> +
  2781  3810 c9f9                                   cmp #$f9                    ; no, is it $f9?
  2782  3812 d00d                                   bne +++                     ; no -> +++
  2783  3814 a502                                   lda zp02                    ; value is $f9
  2784  3816 206e38                                 jsr m38D7                   ; add 1 to zp02 and zp04
  2785  3819 9004                                   bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
  2786  381b e603               +                   inc zp03                    ; value is $fe
  2787  381d e605                                   inc zp05                    ; increase zp03 and zp05
  2788  381f b1a7               ++                  lda (zpA7),y                ; get value from list
  2789  3821 c9fb               +++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
  2790  3823 d009                                   bne +                       ; no -> +
  2791  3825 20c637                                 jsr next_item               ; yes it's $fb, get the next value
  2792  3828 b1a7                                   lda (zpA7),y                ; get value from list
  2793  382a 8509                                   sta zp09                    ; store value in zp09
  2794  382c d028                                   bne ++                      ; if value was 0 -> ++
  2795  382e c9f8               +                   cmp #$f8
  2796  3830 f01c                                   beq +
  2797  3832 c9fc                                   cmp #$fc
  2798  3834 d00d                                   bne +++
  2799  3836 a50a                                   lda zp0A
  2800                                                                          ; jmp m399F
  2801                          
  2802  3838 c9df                                   cmp #$df                    ; this part was moved here as it wasn't called anywhere else
  2803  383a f002                                   beq skip                    ; and I think it was just outsourced for branching length issues
  2804  383c e60a                                   inc zp0A           
  2805  383e b1a7               skip:               lda (zpA7),y        
  2806  3840 4c4e38                                 jmp m38B7
  2807                          
  2808  3843 c9fa               +++                 cmp #$fa
  2809  3845 d00f                                   bne ++
  2810  3847 20c637                                 jsr next_item
  2811  384a b1a7                                   lda (zpA7),y
  2812  384c 850a                                   sta zp0A
  2813                          m38B7:
  2814  384e a509               +                   lda zp09
  2815  3850 9104                                   sta (zp04),y
  2816  3852 a50a                                   lda zp0A
  2817  3854 9102                                   sta (zp02),y
  2818  3856 c9fd               ++                  cmp #$fd
  2819  3858 d009                                   bne +
  2820  385a 20c637                                 jsr next_item
  2821  385d b1a7                                   lda (zpA7),y
  2822  385f 8502                                   sta zp02
  2823  3861 8504                                   sta zp04
  2824  3863 20c637             +                   jsr next_item
  2825  3866 b1a7                                   lda (zpA7),y
  2826  3868 c9ff                                   cmp #$ff
  2827  386a d0a0                                   bne -
  2828  386c f008                                   beq prepare_rooms
  2829  386e 18                 m38D7:              clc
  2830  386f 6901                                   adc #$01
  2831  3871 8502                                   sta zp02
  2832  3873 8504                                   sta zp04
  2833  3875 60                                     rts
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
  2845                          
  2846                          
  2847                          
  2848                          
  2849                          
  2850                          
  2851                          
  2852                          
  2853                          
  2854                          
  2855                          
  2856                          
  2857                          
  2858                          
  2859                          
  2860                          
  2861                          
  2862                          ; ==============================================================================
  2863                          ; ROOM PREPARATION CHECK
  2864                          ; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
  2865                          ; ==============================================================================
  2866                          
  2867                          prepare_rooms:
  2868                                      
  2869  3876 adf82f                                 lda current_room + 1
  2870                                              
  2871  3879 c902                                   cmp #$02                                ; is the current room 02?
  2872  387b f01d                                   beq room_02_prep
  2873                          
  2874  387d c907                                   cmp #$07
  2875  387f f04c                                   beq room_07_make_sacred_column
  2876                                              
  2877  3881 c906                                   cmp #$06          
  2878  3883 f05a                                   beq room_06_make_deadly_doors
  2879                          
  2880  3885 c904                                   cmp #$04
  2881  3887 f062                                   beq room_04_prep
  2882                          
  2883  3889 c905                                   cmp #$05
  2884  388b f001                                   beq room_05_prep
  2885                          
  2886  388d 60                                     rts
  2887                          
  2888                          
  2889                          
  2890                          ; ==============================================================================
  2891                          ; ROOM 05
  2892                          ; HIDE THE BREATHING TUBE UNDER THE STONE
  2893                          ; ==============================================================================
  2894                          
  2895                          room_05_prep:                  
  2896                                                         
  2897  388e a9fd                                   lda #$fd                                    ; yes
  2898  3890 a201               breathing_tube_mod: ldx #$01
  2899  3892 d002                                   bne +                                       ; based on self mod, put the normal
  2900  3894 a97a                                   lda #$7a                                    ; stone char back again
  2901  3896 8dd206             +                   sta SCREENRAM + $2d2   
  2902  3899 60                                     rts
  2903                          
  2904                          
  2905                          
  2906                          ; ==============================================================================
  2907                          ; ROOM 02 PREP
  2908                          ; 
  2909                          ; ==============================================================================
  2910                          
  2911                          room_02_prep:
  2912  389a a90d                                   lda #$0d                                ; yes room is 02, a = $0d #13
  2913  389c 8502                                   sta zp02                                ; zp02 = $0d
  2914  389e 8504                                   sta zp04                                ; zp04 = $0d
  2915  38a0 a9d8                                   lda #>COLRAM                            ; set colram zp
  2916  38a2 8505                                   sta zp05
  2917  38a4 a904                                   lda #>SCREENRAM                         ; set screenram zp      
  2918  38a6 8503                                   sta zp03
  2919  38a8 a218                                   ldx #$18                                ; x = $18 #24
  2920  38aa b102               -                   lda (zp02),y                            ; y must have been set earlier
  2921  38ac c9df                                   cmp #$df                                ; $df = empty space likely
  2922  38ae f004                                   beq delete_fence                        ; yes, empty -> m3900
  2923  38b0 c9f5                                   cmp #$f5                                ; no, but maybe a $f5? (fence!)
  2924  38b2 d006                                   bne +                                   ; nope -> ++
  2925                          
  2926                          delete_fence:
  2927  38b4 a9f5                                   lda #$f5                                ; A is either $df or $f5 -> selfmod here
  2928  38b6 9102                                   sta (zp02),y                            ; store that value
  2929  38b8 9104                                   sta (zp04),y                            ; in zp02 and zo04
  2930  38ba a502               +                   lda zp02                                ; and load it in again, jeez
  2931  38bc 18                                     clc
  2932  38bd 6928                                   adc #$28                                ; smells like we're going to draw a fence
  2933  38bf 8502                                   sta zp02
  2934  38c1 8504                                   sta zp04
  2935  38c3 9004                                   bcc +             
  2936  38c5 e603                                   inc zp03
  2937  38c7 e605                                   inc zp05
  2938  38c9 ca                 +                   dex
  2939  38ca d0de                                   bne -              
  2940  38cc 60                                     rts
  2941                          
  2942                          ; ==============================================================================
  2943                          ; ROOM 07 PREP
  2944                          ;
  2945                          ; ==============================================================================
  2946                          
  2947                          room_07_make_sacred_column:
  2948                          
  2949                                              
  2950  38cd a217                                   ldx #$17                                    ; yes
  2951  38cf bd6805             -                   lda SCREENRAM + $168,x     
  2952  38d2 c9df                                   cmp #$df
  2953  38d4 d005                                   bne +                       
  2954  38d6 a9e3                                   lda #$e3
  2955  38d8 9d6805                                 sta SCREENRAM + $168,x    
  2956  38db ca                 +                   dex
  2957  38dc d0f1                                   bne -                      
  2958  38de 60                                     rts
  2959                          
  2960                          
  2961                          ; ==============================================================================
  2962                          ; ROOM 06
  2963                          ; PREPARE THE DEADLY DOORS
  2964                          ; ==============================================================================
  2965                          
  2966                          room_06_make_deadly_doors:
  2967                          
  2968                                              
  2969  38df a9f6                                   lda #$f6                                    ; char for wrong door
  2970  38e1 8d9c04                                 sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
  2971  38e4 8d7c06                                 sta SCREENRAM + $27c
  2972  38e7 8d6c07                                 sta SCREENRAM + $36c       
  2973  38ea 60                                     rts
  2974                          
  2975                          ; ==============================================================================
  2976                          ; ROOM 04
  2977                          ; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
  2978                          ; ==============================================================================
  2979                          
  2980                          room_04_prep: 
  2981                          
  2982                          
  2983                                              
  2984  38eb adf82f                                 lda current_room + 1                            ; get current room
  2985  38ee c904                                   cmp #04                                         ; is it 4? (coffins)
  2986  38f0 d00c                                   bne ++                                          ; nope
  2987  38f2 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  2988  38f4 ac0339                                 ldy m394A + 1                                   ; 
  2989  38f7 f002                                   beq +
  2990  38f9 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  2991  38fb 8df904             +                   sta SCREENRAM + $f9 
  2992                                          
  2993  38fe a2f7               ++                  ldx #$f7                                    ; yes room 04
  2994  3900 a0f8                                   ldy #$f8
  2995  3902 a901               m394A:              lda #$01
  2996  3904 d004                                   bne m3952           
  2997  3906 a23b                                   ldx #$3b
  2998  3908 a042                                   ldy #$42
  2999  390a a901               m3952:              lda #$01                                    ; some self mod here
  3000  390c c901                                   cmp #$01
  3001  390e d003                                   bne +           
  3002  3910 8e7a04                                 stx SCREENRAM+ $7a 
  3003  3913 c902               +                   cmp #$02
  3004  3915 d003                                   bne +           
  3005  3917 8e6a05                                 stx SCREENRAM + $16a   
  3006  391a c903               +                   cmp #$03
  3007  391c d003                                   bne +           
  3008  391e 8e5a06                                 stx SCREENRAM + $25a       
  3009  3921 c904               +                   cmp #$04
  3010  3923 d003                                   bne +           
  3011  3925 8e4a07                                 stx SCREENRAM + $34a   
  3012  3928 c905               +                   cmp #$05
  3013  392a d003                                   bne +           
  3014  392c 8c9c04                                 sty SCREENRAM + $9c    
  3015  392f c906               +                   cmp #$06
  3016  3931 d003                                   bne +           
  3017  3933 8c8c05                                 sty SCREENRAM + $18c   
  3018  3936 c907               +                   cmp #$07
  3019  3938 d003                                   bne +           
  3020  393a 8c7c06                                 sty SCREENRAM + $27c 
  3021  393d c908               +                   cmp #$08
  3022  393f d003                                   bne +           
  3023  3941 8c6c07                                 sty SCREENRAM + $36c   
  3024  3944 60                 +                   rts
  3025                          
  3026                          
  3027                          
  3028                          
  3029                          
  3030                          
  3031                          
  3032                          
  3033                          
  3034                          
  3035                          
  3036                          
  3037                          
  3038                          
  3039                          
  3040                          
  3041                          
  3042                          
  3043                          
  3044                          
  3045                          ; ==============================================================================
  3046                          ; PLAYER POSITION TABLE FOR EACH ROOM
  3047                          ; FORMAT: Y left door, X left door, Y right door, X right door
  3048                          ; ==============================================================================
  3049                          
  3050                          player_xy_pos_table:
  3051                          
  3052  3945 06031221           !byte $06, $03, $12, $21                                        ; room 00
  3053  3949 03031221           !byte $03, $03, $12, $21                                        ; room 01
  3054  394d 03031521           !byte $03, $03, $15, $21                                        ; room 02
  3055  3951 03030f21           !byte $03, $03, $0f, $21                                        ; room 03
  3056  3955 151e0606           !byte $15, $1e, $06, $06                                        ; room 04
  3057  3959 06031221           !byte $06, $03, $12, $21                                        ; room 05
  3058  395d 03030921           !byte $03, $03, $09, $21                                        ; room 06
  3059  3961 03031221           !byte $03, $03, $12, $21                                        ; room 07
  3060  3965 03030c21           !byte $03, $03, $0c, $21                                        ; room 08
  3061  3969 03031221           !byte $03, $03, $12, $21                                        ; room 09
  3062  396d 0c030c20           !byte $0c, $03, $0c, $20                                        ; room 10
  3063  3971 0c030c21           !byte $0c, $03, $0c, $21                                        ; room 11
  3064  3975 0c030915           !byte $0c, $03, $09, $15                                        ; room 12
  3065  3979 03030621           !byte $03, $03, $06, $21                                        ; room 13
  3066  397d 03030321           !byte $03, $03, $03, $21                                        ; room 14
  3067  3981 06031221           !byte $06, $03, $12, $21                                        ; room 15
  3068  3985 0303031d           !byte $03, $03, $03, $1d                                        ; room 16
  3069  3989 03030621           !byte $03, $03, $06, $21                                        ; room 17
  3070  398d 0303               !byte $03, $03                                                  ; room 18 (only one door)
  3071                          
  3072                          
  3073                          
  3074                          ; ==============================================================================
  3075                          ; $3a33
  3076                          ; Apparently some lookup table, e.g. to get the 
  3077                          ; ==============================================================================
  3078                          
  3079                          room_player_pos_lookup:
  3080                          
  3081  398f 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  3082  399f 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  3083  39af 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  3084  39bf 00                 !byte $00
  3085                          
  3086                          
  3087                          
  3088                          
  3089                          
  3090                          
  3091                          
  3092                          
  3093                          
  3094                          
  3095                          
  3096                          ; ==============================================================================
  3097                          ;
  3098                          ;
  3099                          ; ==============================================================================
  3100                          
  3101                          check_door:
  3102                          
  3103  39c0 a209                                   ldx #$09                                    ; set loop to 9
  3104  39c2 bd4403             -                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
  3105  39c5 c905                                   cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
  3106  39c7 f008                                   beq +                                       ; yes -> +
  3107  39c9 c903                                   cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
  3108  39cb f013                                   beq set_player_xy                           ; yes -> m3A17
  3109  39cd ca                                     dex                                         ; decrease loop
  3110  39ce d0f2                                   bne -                                       ; loop
  3111  39d0 60                 -                   rts
  3112                          
  3113  39d1 aef82f             +                   ldx current_room + 1
  3114  39d4 f0fa                                   beq -               
  3115  39d6 ca                                     dex
  3116  39d7 8ef82f                                 stx current_room + 1                        ; update room number                         
  3117  39da bc8f39                                 ldy room_player_pos_lookup,x                ; load        
  3118  39dd 4cea39                                 jmp update_player_pos           
  3119                          
  3120                          set_player_xy:
  3121  39e0 aef82f                                 ldx current_room + 1                            ; x = room number
  3122  39e3 e8                                     inx                                             ; room number ++
  3123  39e4 8ef82f                                 stx current_room + 1                            ; update room number
  3124  39e7 bca639                                 ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room
  3125                          
  3126                          update_player_pos:              
  3127  39ea b94539                                 lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
  3128  39ed 8d4035                                 sta player_pos_y + 1                            ; player y pos = a
  3129  39f0 b94639                                 lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
  3130  39f3 8d4235                                 sta player_pos_x + 1
  3131                          
  3132  39f6 20e42f             m3A2D:              jsr display_room                                ; done  
  3133  39f9 209115                                 jsr room_04_prep_door                           ; was in main loop before, might find a better place
  3134  39fc 4cd237                                 jmp update_items_display
  3135                          
  3136                          
  3137                          
  3138                          ; ==============================================================================
  3139                          ;
  3140                          ; wait routine
  3141                          ; usually called with Y set before
  3142                          ; ==============================================================================
  3143                          
  3144                          wait:
  3145  39ff ca                                     dex
  3146  3a00 d0fd                                   bne wait
  3147  3a02 88                                     dey
  3148  3a03 d0fa                                   bne wait
  3149  3a05 60                 fake:               rts
  3150                          
  3151                          
  3152                          ; ==============================================================================
  3153                          ; sets the game screen
  3154                          ; multicolor, charset, main colors
  3155                          ; ==============================================================================
  3156                          
  3157                          set_game_basics:
  3158  3a06 ad12ff                                 lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  3159  3a09 29fb                                   and #$fb                                    ; clear bit 2
  3160  3a0b 8d12ff                                 sta VOICE1                                  ; => get data from RAM
  3161  3a0e a918                                   lda #$18            ;lda #$21
  3162  3a10 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
  3163                                              
  3164                                                                                          ; bit 1 : Single clock set  ( 0 )
  3165                                                                                          ; b.2-7 : character data base address
  3166                                                                                          ; %00100$x ($2000)
  3167  3a13 ad16d0                                 lda FF07
  3168  3a16 0990                                   ora #$90                                    ; multicolor ON - reverse OFF
  3169  3a18 8d16d0                                 sta FF07
  3170                          
  3171                                                                                          ; set the main colors for the game
  3172                          
  3173  3a1b a90a                                   lda #MULTICOLOR_1                           ; original: #$db
  3174  3a1d 8d22d0                                 sta COLOR_1                                 ; char color 1
  3175  3a20 a909                                   lda #MULTICOLOR_2                           ; original: #$29
  3176  3a22 8d23d0                                 sta COLOR_2                                 ; char color 2
  3177                                              
  3178  3a25 60                                     rts
  3179                          
  3180                          ; ==============================================================================
  3181                          ; set font and screen setup (40 columns and hires)
  3182                          ; $3a9d
  3183                          ; ==============================================================================
  3184                          
  3185                          set_charset_and_screen:                               ; set text screen
  3186                                             
  3187  3a26 ad12ff                                 lda VOICE1
  3188  3a29 0904                                   ora #$04                                    ; set bit 2
  3189  3a2b 8d12ff                                 sta VOICE1                                  ; => get data from ROM
  3190  3a2e a917                                   lda #$17                                    ; lda #$d5                                    ; ROM FONT
  3191  3a30 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; set
  3192  3a33 ad16d0                                 lda FF07
  3193  3a36 a908                                   lda #$08                                    ; 40 columns and Multicolor OFF
  3194  3a38 8d16d0                                 sta FF07
  3195  3a3b 60                                     rts
  3196                          
  3197                          test:
  3198  3a3c ee20d0                                 inc BORDER_COLOR
  3199  3a3f 4c3c3a                                 jmp test
  3200                          
  3201                          ; ==============================================================================
  3202                          ; init
  3203                          ; start of game (original $3ab3)
  3204                          ; ==============================================================================
  3205                          
  3206                          code_start:
  3207                          init:
  3208                                              ;jsr init_music           ; TODO
  3209                                              
  3210  3a42 a917                                   lda #$17                  ; set lower case charset
  3211  3a44 8d18d0                                 sta $d018                 ; wasn't on Plus/4 for some reason
  3212                                              
  3213  3a47 a90b                                   lda #$0b
  3214  3a49 8d21d0                                 sta BG_COLOR              ; background color
  3215  3a4c 8d20d0                                 sta BORDER_COLOR          ; border color
  3216  3a4f 20bb16                                 jsr reset_items           ; might be a level data reset, and print the title screen
  3217                          
  3218  3a52 a020                                   ldy #$20
  3219  3a54 20ff39                                 jsr wait
  3220                                              
  3221                                              ; waiting for key press on title screen
  3222                          
  3223  3a57 a5cb               -                   lda $cb                   ; zp position of currently pressed key
  3224  3a59 c93c                                   cmp #$3c                  ; is it the space key?
  3225  3a5b d0fa                                   bne -
  3226                          
  3227                                                                        ; lda #$ff
  3228  3a5d 203c1d                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  3229                                              
  3230                          
  3231                                              ; TODO: unclear what the code below does
  3232                                              ; i think it fills the level data with "DF", which is a blank character
  3233  3a60 a904                                   lda #>SCREENRAM
  3234  3a62 8503                                   sta zp03
  3235  3a64 a900                                   lda #$00
  3236  3a66 8502                                   sta zp02
  3237  3a68 a204                                   ldx #$04
  3238  3a6a a000                                   ldy #$00
  3239  3a6c a9df                                   lda #$df
  3240  3a6e 9102               -                   sta (zp02),y
  3241  3a70 c8                                     iny
  3242  3a71 d0fb                                   bne -
  3243  3a73 e603                                   inc zp03
  3244  3a75 ca                                     dex
  3245  3a76 d0f6                                   bne -
  3246                                              
  3247  3a78 20063a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  3248                          
  3249                                              ; set background color
  3250  3a7b a900                                   lda #$00
  3251  3a7d 8d21d0                                 sta BG_COLOR
  3252                          
  3253                                              ; border color. default is a dark red
  3254  3a80 a902                                   lda #BORDER_COLOR_VALUE
  3255  3a82 8d20d0                                 sta BORDER_COLOR
  3256                                              
  3257  3a85 208b3a                                 jsr draw_border
  3258                                              
  3259  3a88 4cc33a                                 jmp set_start_screen
  3260                          
  3261                          ; ==============================================================================
  3262                          ;
  3263                          ; draws the extended "border"
  3264                          ; ==============================================================================
  3265                          
  3266                          draw_border:        
  3267  3a8b a927                                   lda #$27
  3268  3a8d 8502                                   sta zp02
  3269  3a8f 8504                                   sta zp04
  3270  3a91 a9d8                                   lda #>COLRAM
  3271  3a93 8505                                   sta zp05
  3272  3a95 a904                                   lda #>SCREENRAM
  3273  3a97 8503                                   sta zp03
  3274  3a99 a218                                   ldx #$18
  3275  3a9b a000                                   ldy #$00
  3276  3a9d a95d               -                   lda #$5d
  3277  3a9f 9102                                   sta (zp02),y
  3278  3aa1 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3279  3aa3 9104                                   sta (zp04),y
  3280  3aa5 98                                     tya
  3281  3aa6 18                                     clc
  3282  3aa7 6928                                   adc #$28
  3283  3aa9 a8                                     tay
  3284  3aaa 9004                                   bcc +
  3285  3aac e603                                   inc zp03
  3286  3aae e605                                   inc zp05
  3287  3ab0 ca                 +                   dex
  3288  3ab1 d0ea                                   bne -
  3289  3ab3 a95d               -                   lda #$5d
  3290  3ab5 9dc007                                 sta SCREENRAM + $3c0,x
  3291  3ab8 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3292  3aba 9dc0db                                 sta COLRAM + $3c0,x
  3293  3abd e8                                     inx
  3294  3abe e028                                   cpx #$28
  3295  3ac0 d0f1                                   bne -
  3296  3ac2 60                                     rts
  3297                          
  3298                          ; ==============================================================================
  3299                          ; SETUP FIRST ROOM
  3300                          ; player xy position and room number
  3301                          ; ==============================================================================
  3302                          
  3303                          set_start_screen:
  3304  3ac3 a906                                   lda #PLAYER_START_POS_Y
  3305  3ac5 8d4035                                 sta player_pos_y + 1                    ; Y player start position (0 = top)
  3306  3ac8 a903                                   lda #PLAYER_START_POS_X
  3307  3aca 8d4235                                 sta player_pos_x + 1                    ; X player start position (0 = left)
  3308  3acd a900                                   lda #START_ROOM                         ; room number (start screen) ($3b45)
  3309  3acf 8df82f                                 sta current_room + 1
  3310  3ad2 20f639                                 jsr m3A2D
  3311                                              
  3312                          
  3313                          main_loop:
  3314                                              
  3315  3ad5 20b92f                                 jsr rasterpoll_and_other_stuff
  3316  3ad8 a01b                                   ldy #$1b                                ; ldy #$30    ; wait a bit -> in each frame! slows down movement
  3317  3ada 20ff39                                 jsr wait
  3318                                                                                      ;jsr room_04_prep_door
  3319  3add 202e16                                 jsr prep_player_pos
  3320  3ae0 4c4716                                 jmp object_collision
  3321                          
  3322                          ; ==============================================================================
  3323                          ;
  3324                          ; Display the death message
  3325                          ; End of game and return to start screen
  3326                          ; ==============================================================================
  3327                          
  3328                          death:
  3329                                             
  3330  3ae3 a93b                                   lda #>death_messages
  3331  3ae5 85a8                                   sta zpA8
  3332  3ae7 a962                                   lda #<death_messages
  3333  3ae9 85a7                                   sta zpA7
  3334  3aeb c000                                   cpy #$00
  3335  3aed f00c                                   beq ++
  3336  3aef 18                 -                   clc
  3337  3af0 6932                                   adc #$32
  3338  3af2 85a7                                   sta zpA7
  3339  3af4 9002                                   bcc +
  3340  3af6 e6a8                                   inc zpA8
  3341  3af8 88                 +                   dey
  3342  3af9 d0f4                                   bne -
  3343  3afb a90c               ++                  lda #$0c
  3344  3afd 8503                                   sta zp03
  3345  3aff 8402                                   sty zp02
  3346  3b01 a204                                   ldx #$04
  3347  3b03 a920                                   lda #$20
  3348  3b05 9102               -                   sta (zp02),y
  3349  3b07 c8                                     iny
  3350  3b08 d0fb                                   bne -
  3351  3b0a e603                                   inc zp03
  3352  3b0c ca                                     dex
  3353  3b0d d0f6                                   bne -
  3354  3b0f 20263a                                 jsr set_charset_and_screen
  3355  3b12 20423b                                 jsr clear
  3356  3b15 b1a7               -                   lda (zpA7),y
  3357  3b17 9dc005                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  3358  3b1a a900                                   lda #$00                                    ; color of the death message
  3359  3b1c 9dc0d9                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  3360  3b1f e8                                     inx
  3361  3b20 c8                                     iny
  3362  3b21 e019                                   cpx #$19
  3363  3b23 d002                                   bne +
  3364  3b25 a250                                   ldx #$50
  3365  3b27 c032               +                   cpy #$32
  3366  3b29 d0ea                                   bne -
  3367  3b2b a903                                   lda #$03
  3368  3b2d 8d21d0                                 sta BG_COLOR
  3369  3b30 8d20d0                                 sta BORDER_COLOR
  3370                                             
  3371                          m3EF9:
  3372  3b33 a908                                   lda #$08
  3373  3b35 a0ff               -                   ldy #$ff
  3374  3b37 20ff39                                 jsr wait
  3375  3b3a 38                                     sec
  3376  3b3b e901                                   sbc #$01
  3377  3b3d d0f6                                   bne -
  3378                                              
  3379  3b3f 4c423a                                 jmp init
  3380                          
  3381                          ; ==============================================================================
  3382                          ;
  3383                          ; clear the sceen (replacing kernal call on plus/4)
  3384                          ; 
  3385                          ; ==============================================================================
  3386                          
  3387  3b42 a920               clear               lda #$20                    ; #$20 is the spacebar Screen Code
  3388  3b44 9d0004                                 sta $0400,x                 ; fill four areas with 256 spacebar characters
  3389  3b47 9d0005                                 sta $0500,x 
  3390  3b4a 9d0006                                 sta $0600,x 
  3391  3b4d 9de806                                 sta $06e8,x 
  3392  3b50 a900                                   lda #$00                    ; set foreground to black in Color Ram 
  3393  3b52 9d00d8                                 sta $d800,x  
  3394  3b55 9d00d9                                 sta $d900,x
  3395  3b58 9d00da                                 sta $da00,x
  3396  3b5b 9de8da                                 sta $dae8,x
  3397  3b5e e8                                     inx                         ; increment X
  3398  3b5f d0e1                                   bne clear                   ; did X turn to zero yet?
  3399                                                                          ; if not, continue with the loop
  3400  3b61 60                                     rts                         ; return from this subroutine
  3401                          ; ==============================================================================
  3402                          ;
  3403                          ; DEATH MESSAGES
  3404                          ; ==============================================================================
  3405                          
  3406                          death_messages:
  3407                          
  3408                          ; death messages
  3409                          ; like "You fell into a snake pit"
  3410                          
  3411                          ; scr conversion
  3412                          
  3413                          ; 00 You fell into a snake pit
  3414                          ; 01 You'd better watched out for the sacred column
  3415                          ; 02 You drowned in the deep river
  3416                          ; 03 You drank from the poisend bottle
  3417                          ; 04 Boris the spider got you and killed you
  3418                          ; 05 Didn't you see the laser beam?
  3419                          ; 06 240 Volts! You got an electrical shock!
  3420                          ; 07 You stepped on a nail!
  3421                          ; 08 A foot trap stopped you!
  3422                          ; 09 This room is doomed by the wizard Manilo!
  3423                          ; 0a You were locked in and starved!
  3424                          ; 0b You were hit by a big rock and died!
  3425                          ; 0c Belegro killed you!
  3426                          ; 0d You found a thirsty zombie....
  3427                          ; 0e The monster grabbed you you. You are dead!
  3428                          ; 0f You were wounded by the bush!
  3429                          ; 10 You are trapped in wire-nettings!
  3430                          
  3431                          !if LANGUAGE = EN{
  3432                          !scr "You fell into a          snake pit !              "
  3433                          !scr "You'd better watched out for the sacred column!   "
  3434                          !scr "You drowned in the deep  river !                  "
  3435                          !scr "You drank from the       poisened bottle ........ "
  3436                          !scr "Boris, the spider, got   you and killed you !     "
  3437                          !scr "Didn't you see the       laser beam ?!?           "
  3438                          !scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  3439                          !scr "You stepped on a nail !                           "
  3440                          !scr "A foot trap stopped you !                         "
  3441                          !scr "This room is doomed      by the wizard Manilo !   "
  3442                          !scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  3443                          !scr "You were hit by a big    rock and died !          "
  3444                          !scr "Belegro killed           you !                    "
  3445                          !scr "You found a thirsty      zombie .......           "
  3446                          !scr "The monster grapped       you. You are dead !     "
  3447                          !scr "You were wounded by      the bush !               "
  3448                          !scr "You are trapped in       wire-nettings !          "
  3449                          }
  3450                          
  3451                          
  3452                          !if LANGUAGE = DE{
  3453  3b62 5309052013090e04...!scr "Sie sind in eine         Schlangengrube gefallen !"
  3454  3b94 470f141405130c01...!scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  3455  3bc6 5309052013090e04...!scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  3456  3bf8 5309052008010205...!scr "Sie haben aus der Gift-  flasche getrunken....... "
  3457  3c2a 420f1209132c2004...!scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  3458  3c5c 44050e204c011305...!scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  3459  3c8e 32323020560f0c14...!scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  3460  3cc0 5309052013090e04...!scr "Sie sind in einen Nagel  getreten !               "
  3461  3cf2 45090e0520461513...!scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  3462  3d24 4115062004090513...!scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  3463  3d56 5309052017151204...!scr "Sie wurden eingeschlossenund verhungern !         "
  3464  3d88 5309052017151204...!scr "Sie wurden von einem     Stein ueberollt !!       "
  3465  3dba 42050c0507120f20...!scr "Belegro hat Sie          vernichtet !             "
  3466  3dec 490d205301120720...!scr "Im Sarg lag ein durstigerZombie........           "
  3467  3e1e 440113204d0f0e13...!scr "Das Monster hat Sie      erwischt !!!!!           "
  3468  3e50 5309052008010205...!scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  3469  3e82 5309052008010205...!scr "Sie haben sich im        Stacheldraht verfangen !!"
  3470                          }
  3471                          
  3472                          ; ==============================================================================
  3473                          ; screen messages
  3474                          ; and the code entry text
  3475                          ; ==============================================================================
  3476                          
  3477                          !if LANGUAGE = EN{
  3478                          
  3479                          hint_messages:
  3480                          !scr " A part of the code number is :         "
  3481                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3482                          !scr " You need: bulb, bulb holder, socket !  "
  3483                          !scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  3484                          !scr " *****   A helping letter :   "
  3485                          helping_letter: !scr "C   ***** "
  3486                          !scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  3487                          
  3488                          }
  3489                          
  3490                          !if LANGUAGE = DE{
  3491                          
  3492                          hint_messages:
  3493  3eb4 2045090e20540509...!scr " Ein Teil des Loesungscodes lautet:     "
  3494  3edc 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3495  3f04 2044152002120115...!scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  3496  3f2c 20570905200c0115...!scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  3497  3f54 202a2a2a2a2a2020...!scr " *****   Ein Hilfsbuchstabe:  "
  3498  3f72 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  3499  3f7c 2046010c13030805...!scr " Falscher Loesungscode ! TODESSTRAFE !! "
  3500                          
  3501                          }
  3502                          
  3503                          
  3504                          ; ==============================================================================
  3505                          ;
  3506                          ; ITEM PICKUP MESSAGES
  3507                          ; ==============================================================================
  3508                          
  3509                          
  3510                          item_pickup_message:              ; item pickup messages
  3511                          
  3512                          !if LANGUAGE = EN{
  3513                          !scr " There is a key in the bottle !         "
  3514                          !scr "   There is a key in the coffin !       "
  3515                          !scr " There is a breathing tube !            "
  3516                          }
  3517                          
  3518                          !if LANGUAGE = DE{
  3519  3fa4 20490e2004051220...!scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
  3520  3fcc 20202020490e2004...!scr "    In dem Sarg lag ein Schluessel !    "
  3521  3ff4 20550e1405122004...!scr " Unter dem Stein lag ein Taucheranzug ! "
  3522                          }
  3523                          item_pickup_message_end:
