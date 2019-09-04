
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
    27                          HU = 2
    28                          
    29                          LANGUAGE = HU
    30                          
    31                          ; ==============================================================================
    32                          ; thse settings change the appearance of the game
    33                          ; EXTENDED = 0 -> original version
    34                          ; EXTENDED = 1 -> altered version
    35                          ; ==============================================================================
    36                          
    37                          EXTENDED                = 1       ; 0 = original version, 1 = tweaks and cosmetics
    38                          
    39                          !if EXTENDED = 0{
    40                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $02 ; red
    41                              MULTICOLOR_1        = $0a           ; face pink
    42                              MULTICOLOR_2        = $09
    43                              BORDER_COLOR_VALUE  = $02
    44                              TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    45                              TITLE_KEY           = $01
    46                          
    47                          }
    48                          
    49                          !if EXTENDED = 1{
    50                              COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $02 ; red
    51                              MULTICOLOR_1        = $0a           ; face pink
    52                              MULTICOLOR_2        = $09
    53                              BORDER_COLOR_VALUE  = $02
    54                              TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    55                              TITLE_KEY           = $01
    56                          }
    57                          
    58                          
    59                          ; ==============================================================================
    60                          ; CHEATS
    61                          ;
    62                          ;
    63                          ; ==============================================================================
    64                          
    65                          START_ROOM          = 18             ; default 0 
    66                          PLAYER_START_POS_X  = 3             ; default 3
    67                          PLAYER_START_POS_Y  = 6             ; default 6
    68                          SILENT_MODE         = 0
    69                          
    70                          ; ==============================================================================
    71                          ; ITEMS
    72                          ; not used in the code, but useful for testing, 
    73                          ; e.g. "> ._sword df" to pickup the sword in VICE monitor
    74                          ; ==============================================================================
    75                          
    76                          _boots              = items + $84
    77                          _ladder             = items + $4d
    78                          _gloves             = items + $8
    79                          _key                = items + $10
    80                          _wirecutter         = items + $19
    81                          _light              = items + $74
    82                          _hammer             = items + $bb
    83                          _shovel             = items + $96
    84                          _poweroutlet        = items + $ac
    85                          _lightbulb          = items + $c8
    86                          _sword              = items + $1a7
    87                          
    88                          ; ==============================================================================
    89                          ; ZEROPAGE
    90                          
    91                          zp02                = $02
    92                          zp03                = $03               ; high byte of screen ram
    93                          zp04                = $04               ; low byte of screen ram
    94                          zp05                = $05               ; seems to always store the COLRAM information
    95                          zp08                = $08
    96                          zp09                = $09
    97                          zp0A                = $0A
    98                          zp10                = $10
    99                          zp11                = $11
   100                          zpA7                = $A7
   101                          zpA8                = $A8
   102                          zpA9                = $A9
   103                          
   104                          ; ==============================================================================
   105                          
   106                          TAPE_BUFFER         = $033c             ; $0333
   107                          SCREENRAM           = $0400             ; $0C00             ; PLUS/4 default SCREEN
   108                          COLRAM              = $d800             ; $0800             ; PLUS/4 COLOR RAM
   109                          PRINT_KERNAL        = $ffd2             ; $c56b
   110                          BASIC_DA89          = $e8ea             ; $da89             ; scroll screen up by 1 line
   111                          FF07                = $d016             ; $FF07             ; FF07 scroll & multicolor
   112                          KEYBOARD_LATCH      = $FF08
   113                          INTERRUPT           = $FF09
   114                          FF0A                = $FF0A
   115                          VOICE1_FREQ_LOW     = $FF0E             ; Low byte of frequency for voice 1
   116                          VOICE2_FREQ_LOW     = $FF0F
   117                          VOICE2              = $FF10
   118                          VOLUME_AND_VOICE_SELECT = $FF11
   119                          VOICE1              = $FF12             ; Bit 0-1 : Voice #1 frequency, bits 8 & 9;  Bit 2    : TED data fetch ROM/RAM select; Bits 0-5 : Bit map base address
   120                          CHAR_BASE_ADDRESS   = $d018             ; $FF13
   121                          BG_COLOR            = $D021
   122                          COLOR_1             = $d022             ;$FF16
   123                          COLOR_2             = $d023             ; $FF17
   124                          COLOR_3             = $d024             ;$FF18
   125                          BORDER_COLOR        = $D020
   126                          FF1D                = $D012             ; $FF1D             ; FF1D raster line
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
   150                          
   151                          ; ==============================================================================
   152                          
   153                                              !cpu 6510
   154                                              *= $1000
   155                          
   156                          ; ==============================================================================
   157                          ;
   158                          ; display the hint messages
   159                          ; ==============================================================================
   160                          
   161                          display_hint_message_plus_clear:
   162                                             
   163  1000 20423b                                 jsr clear               ;     jsr PRINT_KERNAL   
   164                                                   
   165                          
   166                          display_hint_message:
   167                                             
   168                                              
   169  1003 a93e                                   lda #>hint_messages
   170  1005 85a8                                   sta zpA8
   171  1007 a9b4                                   lda #<hint_messages
   172  1009 c000               m1009:              cpy #$00
   173  100b f00a                                   beq ++              
   174  100d 18                 -                   clc
   175  100e 6928                                   adc #$28
   176  1010 9002                                   bcc +               
   177  1012 e6a8                                   inc zpA8
   178  1014 88                 +                   dey
   179  1015 d0f6                                   bne -               
   180  1017 85a7               ++                  sta zpA7
   181  1019 20263a                                 jsr set_charset_and_screen 
   182                                              
   183  101c a027                                   ldy #$27
   184  101e b1a7               -                   lda (zpA7),y
   185  1020 99b805                                 sta SCREENRAM+$1B8,y 
   186  1023 a905                                   lda #$05
   187  1025 99b8d9                                 sta COLRAM+$1B8,y 
   188  1028 88                                     dey
   189  1029 d0f3                                   bne -  
   190                                                 
   191  102b 60                                     rts
   192                          
   193                          
   194                          ; ==============================================================================
   195                          ;
   196                          ;
   197                          ; ==============================================================================
   198                          
   199                          prep_and_display_hint:
   200                                              
   201  102c 20423b                                 jsr clear
   202  102f 205011                                 jsr switch_charset           
   203  1032 c003                                   cpy #$03                                ; is the display hint the one for the code number?
   204  1034 f003                                   beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
   205  1036 4cd810                                 jmp display_hint                        ; no, display the hint
   206                          
   207                          
   208                          room_16_code_number_prep:
   209                                              
   210  1039 20423b                                 jsr clear
   211  103c 200310                                 jsr display_hint_message                ; yes we are in room 3
   212  103f 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   213  1042 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   214                                             
   215  1045 a001                                   ldy #$01                                ; y = 1
   216  1047 200310                                 jsr display_hint_message              
   217  104a a200                                   ldx #$00                                ; x = 0
   218  104c a000                                   ldy #$00                                ; y = 0
   219  104e f013                                   beq room_16_enter_code                  ; room 16 code? how?
   220                          
   221                          room_16_cursor_blinking: 
   222                          
   223  1050 bdb905                                 lda SCREENRAM+$1B9,x                    ; load something from screen
   224  1053 18                                     clc                                     
   225  1054 6980                                   adc #$80                                ; add $80 = 128 = inverted char
   226  1056 9db905                                 sta SCREENRAM+$1B9,x                    ; store in the same location
   227  1059 b98805                                 lda SCREENRAM+$188,y                    ; and the same for another position
   228  105c 18                                     clc
   229  105d 6980                                   adc #$80
   230  105f 998805                                 sta SCREENRAM+$188,y 
   231  1062 60                                     rts
   232                          
   233                          ; ==============================================================================
   234                          ; ROOM 16
   235                          ; ENTER CODE
   236                          ; ==============================================================================
   237                          
   238                          room_16_enter_code:
   239                          
   240  1063 205010                                 jsr room_16_cursor_blinking
   241  1066 8402                                   sty zp02
   242  1068 8604                                   stx zp04
   243  106a 20a510                                 jsr room_16_code_delay           
   244  106d 205010                                 jsr room_16_cursor_blinking           
   245  1070 20a510                                 jsr room_16_code_delay
   246                          
   247  1073 ad00dc                                 lda $dc00
   248                                                                                          ; Bit #0: 0 = Port 2 joystick up pressed.
   249                                                                                          ; Bit #1: 0 = Port 2 joystick down pressed.
   250                                                                                          ; Bit #2: 0 = Port 2 joystick left pressed.
   251                                                                                          ; Bit #3: 0 = Port 2 joystick right pressed.
   252                                                                                          ; Bit #4: 0 = Port 2 joystick fire pressed.
   253                                              
   254  1076 4a                                     lsr                                         ; we don't check for up       
   255  1077 4a                                     lsr                                         ; we don't check for down
   256                                              
   257  1078 4a                                     lsr                                         ; now we have carry = 0 if LEFT PRESSED
   258  1079 b005                                   bcs +                                       ; left not pressed ->
   259  107b e000                                   cpx #$00                                    ; x = 0?
   260  107d f001                                   beq +                                       ; yes ->
   261  107f ca                                     dex                                         ; no, x = x - 1 = move cursor left
   262                          
   263  1080 4a                 +                   lsr                                         ; now we have carry = 0 if RIGHT PRESSED
   264  1081 b005                                   bcs +                                       ; right not pressed ->
   265  1083 e025                                   cpx #$25                                    ; right was pressed, but are we at the rightmost position already?
   266  1085 f001                                   beq +                                       ; yes we are ->
   267  1087 e8                                     inx                                         ; no, we can move one more, so x = x + 1
   268                          
   269  1088 4a                 +                   lsr                                         ; now we have carry = 0 if FIRE PRESSED
   270  1089 b0d8                                   bcs room_16_enter_code                      ; fire wasn't pressed, so start over
   271                                              
   272  108b bdb905                                 lda SCREENRAM+$1B9,x                        ; fire WAS pressed, so get the current character
   273  108e c9bc                                   cmp #$bc                                    ; is it the "<" char for back?
   274  1090 d008                                   bne ++                                      ; no ->
   275  1092 c000                                   cpy #$00                                    ; yes, code submitted
   276  1094 f001                                   beq +
   277  1096 88                                     dey
   278  1097 4c6310             +                   jmp room_16_enter_code
   279  109a 998805             ++                  sta SCREENRAM+$188,y
   280  109d c8                                     iny
   281  109e c005                                   cpy #$05
   282  10a0 d0c1                                   bne room_16_enter_code
   283  10a2 4caf10                                 jmp check_code_number
   284                          ; ==============================================================================
   285                          ;
   286                          ; DELAYS CURSOR MOVEMENT AND BLINKING
   287                          ; ==============================================================================
   288                          
   289                          room_16_code_delay:
   290  10a5 a020                                   ldy #$20                            ; wait a bit
   291  10a7 20ff39                                 jsr wait                        
   292  10aa a402                                   ldy zp02                            ; and load x and y 
   293  10ac a604                                   ldx zp04                            ; with shit from zp
   294  10ae 60                                     rts
   295                          
   296                          ; ==============================================================================
   297                          ; ROOM 16
   298                          ; CHECK THE CODE NUMBER
   299                          ; ==============================================================================
   300                          
   301                          check_code_number:
   302  10af a205                                   ldx #$05                            ; x = 5
   303  10b1 bd8705             -                   lda SCREENRAM+$187,x                ; get one number from code
   304  10b4 ddc610                                 cmp code_number-1,x                 ; is it correct?
   305  10b7 d006                                   bne +                               ; no -> +
   306  10b9 ca                                     dex                                 ; yes, check next number
   307  10ba d0f5                                   bne -                               
   308  10bc 4ccc10                                 jmp ++                              ; all correct -> ++
   309  10bf a005               +                   ldy #$05                            ; text for wrong code number
   310  10c1 200310                                 jsr display_hint_message            ; wrong code -> death
   311  10c4 4c333b                                 jmp m3EF9          
   312                          
   313  10c7 3036313338         code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38
   314                          
   315  10cc 20063a             ++                  jsr set_game_basics                 ; code correct, continue
   316  10cf 20e039                                 jsr set_player_xy          
   317  10d2 208b3a                                 jsr draw_border          
   318  10d5 4cd53a                                 jmp main_loop          
   319                          
   320                          ; ==============================================================================
   321                          ;
   322                          ; hint system (question marks)
   323                          ; ==============================================================================
   324                          
   325                          
   326                          display_hint:
   327  10d8 c000                                   cpy #$00
   328  10da d04a                                   bne m11A2           
   329  10dc 200010                                 jsr display_hint_message_plus_clear
   330  10df aef82f                                 ldx current_room + 1
   331  10e2 e001                                   cpx #$01
   332  10e4 d002                                   bne +               
   333  10e6 a928                                   lda #$28
   334  10e8 e005               +                   cpx #$05
   335  10ea d002                                   bne +               
   336  10ec a929                                   lda #$29
   337  10ee e00a               +                   cpx #$0a
   338  10f0 d002                                   bne +               
   339  10f2 a947                                   lda #$47                   
   340  10f4 e00c               +                   cpx #$0c
   341  10f6 d002                                   bne +
   342  10f8 a949                                   lda #$49
   343  10fa e00d               +                   cpx #$0d
   344  10fc d002                                   bne +
   345  10fe a945                                   lda #$45
   346  1100 e00f               +                   cpx #$0f
   347  1102 d00a                                   bne +               
   348  1104 a945                                   lda #$45
   349                                             
   350  1106 8d6fda                                 sta COLRAM + $26f       
   351  1109 a90f                                   lda #$0f
   352  110b 8d6f06                                 sta SCREENRAM + $26f       
   353  110e 8d1f06             +                   sta SCREENRAM + $21f       
   354  1111 a948                                   lda #$48
   355  1113 8d1fda                                 sta COLRAM + $21f       
   356  1116 ad00dc             -                   lda $dc00                         ;lda #$fd
   357                                                                                ;sta KEYBOARD_LATCH
   358                                                                                ; lda KEYBOARD_LATCH
   359  1119 2910                                   and #$10                          ; and #$80
   360  111b d0f9                                   bne -               
   361  111d 20063a                                 jsr set_game_basics
   362  1120 20f639                                 jsr m3A2D          
   363  1123 4cd53a                                 jmp main_loop         
   364  1126 c002               m11A2:              cpy #$02
   365  1128 d006                                   bne +             
   366  112a 200010             m11A6:              jsr display_hint_message_plus_clear
   367  112d 4c1611                                 jmp -             
   368  1130 c004               +                   cpy #$04
   369  1132 d00b                                   bne +              
   370  1134 ad0b39                                 lda m3952 + 1    
   371  1137 18                                     clc
   372  1138 6940                                   adc #$40                                        ; this is the helping letter
   373  113a 8d723f                                 sta helping_letter         
   374  113d d0eb                                   bne m11A6          
   375  113f 88                 +                   dey
   376  1140 88                                     dey
   377  1141 88                                     dey
   378  1142 88                                     dey
   379  1143 88                                     dey
   380  1144 a93f                                   lda #>item_pickup_message
   381  1146 85a8                                   sta zpA8
   382  1148 a9a4                                   lda #<item_pickup_message
   383  114a 200910                                 jsr m1009
   384  114d 4c1611                                 jmp -
   385                          
   386                          ; ==============================================================================
   387                          
   388                          switch_charset:
   389  1150 20263a                                 jsr set_charset_and_screen           
   390  1153 4c423b                                 jmp clear       ; jmp PRINT_KERNAL           
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
   417                          
   418                          ; ==============================================================================
   419                          ;
   420                          ; JUMP TO ROOM LOGIC
   421                          ; This code is new. Previously, code execution jumped from room to room
   422                          ; and in each room did the comparison with the room number.
   423                          ; This is essentially the same, but bundled in one place.
   424                          ; not calles in between room changes, only e.g. for question mark
   425                          ; ==============================================================================
   426                          
   427                          check_room:
   428  1156 acf82f                                 ldy current_room + 1        ; load in the current room number
   429  1159 c000                                   cpy #0
   430  115b d003                                   bne +
   431  115d 4cf811                                 jmp room_00
   432  1160 c001               +                   cpy #1
   433  1162 d003                                   bne +
   434  1164 4c1312                                 jmp room_01
   435  1167 c002               +                   cpy #2
   436  1169 d003                                   bne +
   437  116b 4c5012                                 jmp room_02
   438  116e c003               +                   cpy #3
   439  1170 d003                                   bne +
   440  1172 4ca612                                 jmp room_03
   441  1175 c004               +                   cpy #4
   442  1177 d003                                   bne +
   443  1179 4cb212                                 jmp room_04
   444  117c c005               +                   cpy #5
   445  117e d003                                   bne +
   446  1180 4cd412                                 jmp room_05
   447  1183 c006               +                   cpy #6
   448  1185 d003                                   bne +
   449  1187 4cf812                                 jmp room_06
   450  118a c007               +                   cpy #7
   451  118c d003                                   bne +
   452  118e 4c0413                                 jmp room_07
   453  1191 c008               +                   cpy #8
   454  1193 d003                                   bne +
   455  1195 4c3c13                                 jmp room_08
   456  1198 c009               +                   cpy #9
   457  119a d003                                   bne +
   458  119c 4c9313                                 jmp room_09
   459  119f c00a               +                   cpy #10
   460  11a1 d003                                   bne +
   461  11a3 4c9f13                                 jmp room_10
   462  11a6 c00b               +                   cpy #11
   463  11a8 d003                                   bne +
   464  11aa 4ccf13                                 jmp room_11 
   465  11ad c00c               +                   cpy #12
   466  11af d003                                   bne +
   467  11b1 4cde13                                 jmp room_12
   468  11b4 c00d               +                   cpy #13
   469  11b6 d003                                   bne +
   470  11b8 4cfa13                                 jmp room_13
   471  11bb c00e               +                   cpy #14
   472  11bd d003                                   bne +
   473  11bf 4c1e14                                 jmp room_14
   474  11c2 c00f               +                   cpy #15
   475  11c4 d003                                   bne +
   476  11c6 4c2a14                                 jmp room_15
   477  11c9 c010               +                   cpy #16
   478  11cb d003                                   bne +
   479  11cd 4c3614                                 jmp room_16
   480  11d0 c011               +                   cpy #17
   481  11d2 d003                                   bne +
   482  11d4 4c5c14                                 jmp room_17
   483  11d7 4c6b14             +                   jmp room_18
   484                          
   485                          
   486                          
   487                          ; ==============================================================================
   488                          
   489                          check_death:
   490  11da 20d237                                 jsr update_items_display
   491  11dd 4cd53a                                 jmp main_loop           
   492                          
   493                          ; ==============================================================================
   494                          
   495                          m11E0:              
   496  11e0 a200                                   ldx #$00
   497  11e2 bd4503             -                   lda TAPE_BUFFER + $9,x              
   498  11e5 c91e                                   cmp #$1e                            ; question mark
   499  11e7 9007                                   bcc check_next_char_under_player           
   500  11e9 c9df                                   cmp #$df
   501  11eb f003                                   beq check_next_char_under_player
   502  11ed 4c5611                                 jmp check_room              
   503                          
   504                          ; ==============================================================================
   505                          
   506                          check_next_char_under_player:
   507  11f0 e8                                     inx
   508  11f1 e009                                   cpx #$09
   509  11f3 d0ed                                   bne -                              ; not done checking          
   510  11f5 4cd53a             -                   jmp main_loop           
   511                          
   512                          
   513                          ; ==============================================================================
   514                          ;
   515                          ;                                                             ###        ###
   516                          ;          #####      ####      ####     #    #              #   #      #   #
   517                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   518                          ;          #    #    #    #    #    #    # ## #             #     #    #     #
   519                          ;          #####     #    #    #    #    #    #             #     #    #     #
   520                          ;          #   #     #    #    #    #    #    #              #   #      #   #
   521                          ;          #    #     ####      ####     #    #               ###        ###
   522                          ;
   523                          ; ==============================================================================
   524                          
   525                          
   526                          room_00:
   527                          
   528  11f8 c9a9                                   cmp #$a9                                        ; has the player hit the gloves?
   529  11fa d0f4                                   bne check_next_char_under_player                ; no
   530  11fc a9df                                   lda #$df                                        ; yes, load in char for "empty"
   531  11fe cd6336                                 cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
   532  1201 d0f2                                   bne -                                           ; no
   533  1203 200812                                 jsr pickup_gloves                               ; yes
   534  1206 d0d2                                   bne check_death
   535                          
   536                          
   537                          pickup_gloves:
   538  1208 a96b                                   lda #$6b                                        ; load character for empty bush
   539  120a 8d1e36                                 sta items + $8                                  ; store 6b = gloves in inventory
   540  120d a93d                                   lda #$3d                                        ; set the foreground color
   541  120f 8d1c36                                 sta items + $6                                  ; and store the color in the items table
   542  1212 60                                     rts
   543                          
   544                          
   545                          
   546                          
   547                          
   548                          
   549                          ; ==============================================================================
   550                          ;
   551                          ;                                                             ###        #
   552                          ;          #####      ####      ####     #    #              #   #      ##
   553                          ;          #    #    #    #    #    #    ##  ##             #     #    # #
   554                          ;          #    #    #    #    #    #    # ## #             #     #      #
   555                          ;          #####     #    #    #    #    #    #             #     #      #
   556                          ;          #   #     #    #    #    #    #    #              #   #       #
   557                          ;          #    #     ####      ####     #    #               ###      #####
   558                          ;
   559                          ; ==============================================================================
   560                          
   561                          room_01:
   562                          
   563  1213 c9e0                                   cmp #$e0                                    ; empty character in charset -> invisible key
   564  1215 f004                                   beq +                                       ; yes, key is there -> +
   565  1217 c9e1                                   cmp #$e1
   566  1219 d014                                   bne ++
   567  121b a9aa               +                   lda #$aa                                    ; display the key, $AA = 1st part of key
   568  121d 8d2636                                 sta items + $10                             ; store key in items list
   569  1220 20d237                                 jsr update_items_display                    ; update all items in the items list (we just made the key visible)
   570  1223 a0f0                                   ldy #$f0                                    ; set waiting time
   571  1225 20ff39                                 jsr wait                                    ; wait
   572  1228 a9df                                   lda #$df                                    ; set key to empty space
   573  122a 8d2636                                 sta items + $10                             ; update items list
   574  122d d0ab                                   bne check_death
   575  122f c927               ++                  cmp #$27                                    ; question mark (I don't know why 27)
   576  1231 b005                                   bcs check_death_bush
   577  1233 a000                                   ldy #$00
   578  1235 4c2c10                                 jmp prep_and_display_hint
   579                          
   580                          check_death_bush:
   581  1238 c9ad                                   cmp #$ad                                    ; wirecutters
   582  123a d0b4                                   bne check_next_char_under_player
   583  123c ad1e36                                 lda items + $8                              ; inventory place for the gloves! 6b = gloves
   584  123f c96b                                   cmp #$6b
   585  1241 f005                                   beq +
   586  1243 a00f                                   ldy #$0f
   587  1245 4ce33a                                 jmp death                                   ; 0f You were wounded by the bush!
   588                          
   589  1248 a9f9               +                   lda #$f9                                    ; wirecutter picked up
   590  124a 8d2f36                                 sta items + $19
   591  124d 4cda11                                 jmp check_death
   592                          
   593                          
   594                          
   595                          
   596                          
   597                          
   598                          ; ==============================================================================
   599                          ;
   600                          ;                                                             ###       #####
   601                          ;          #####      ####      ####     #    #              #   #     #     #
   602                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   603                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   604                          ;          #####     #    #    #    #    #    #             #     #    #
   605                          ;          #   #     #    #    #    #    #    #              #   #     #
   606                          ;          #    #     ####      ####     #    #               ###      #######
   607                          ;
   608                          ; ==============================================================================
   609                          
   610                          room_02:
   611                          
   612  1250 c9f5                                   cmp #$f5                                    ; did the player hit the fence? f5 = fence character
   613  1252 d014                                   bne check_lock                              ; no, check for the lock
   614  1254 ad2f36                                 lda items + $19                             ; fence was hit, so check if wirecuter was picked up
   615  1257 c9f9                                   cmp #$f9                                    ; where the wirecutters (f9) picked up?
   616  1259 f005                                   beq remove_fence                            ; yes
   617  125b a010                                   ldy #$10                                    ; no, load the correct death message
   618  125d 4ce33a                                 jmp death                                   ; 10 You are trapped in wire-nettings!
   619                          
   620                          remove_fence:
   621  1260 a9df                                   lda #$df                                    ; empty char
   622  1262 8db538                                 sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
   623  1265 4cda11             m1264:              jmp check_death
   624                          
   625                          
   626                          check_lock:
   627  1268 c9a6                                   cmp #$a6                                    ; lock
   628  126a d00e                                   bne +
   629  126c ad2636                                 lda items + $10
   630  126f c9df                                   cmp #$df
   631  1271 d0f2                                   bne m1264
   632  1273 a9df                                   lda #$df
   633  1275 8d4e36                                 sta items + $38
   634  1278 d0eb                                   bne m1264
   635  127a c9b1               +                   cmp #$b1                                    ; ladder
   636  127c d00a                                   bne +
   637  127e a9df                                   lda #$df
   638  1280 8d6336                                 sta items + $4d
   639  1283 8d6e36                                 sta items + $58
   640  1286 d0dd                                   bne m1264
   641  1288 c9b9               +                   cmp #$b9                                    ; bottle
   642  128a f003                                   beq +
   643  128c 4cf011                                 jmp check_next_char_under_player
   644  128f add136             +                   lda items + $bb
   645  1292 c9df                                   cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
   646  1294 f005                                   beq take_key_out_of_bottle                                   
   647  1296 a003                                   ldy #$03
   648  1298 4ce33a                                 jmp death                                   ; 03 You drank from the poisend bottle
   649                          
   650                          take_key_out_of_bottle:
   651  129b a901                                   lda #$01
   652  129d 8da512                                 sta key_in_bottle_storage
   653  12a0 a005                                   ldy #$05
   654  12a2 4c2c10                                 jmp prep_and_display_hint
   655                          
   656                          ; ==============================================================================
   657                          ; this is 1 if the key from the bottle was taken and 0 if not
   658                          
   659  12a5 00                 key_in_bottle_storage:              !byte $00
   660                          
   661                          
   662                          
   663                          
   664                          
   665                          
   666                          
   667                          
   668                          
   669                          ; ==============================================================================
   670                          ;
   671                          ;                                                             ###       #####
   672                          ;          #####      ####      ####     #    #              #   #     #     #
   673                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   674                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   675                          ;          #####     #    #    #    #    #    #             #     #          #
   676                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   677                          ;          #    #     ####      ####     #    #               ###       #####
   678                          ;
   679                          ; ==============================================================================
   680                          
   681                          room_03:
   682                          
   683  12a6 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   684  12a8 9003                                   bcc +
   685  12aa 4cd53a                                 jmp main_loop
   686  12ad a004               +                   ldy #$04
   687  12af 4c2c10                                 jmp prep_and_display_hint
   688                          
   689                          
   690                          
   691                          
   692                          
   693                          
   694                          ; ==============================================================================
   695                          ;
   696                          ;                                                             ###      #
   697                          ;          #####      ####      ####     #    #              #   #     #    #
   698                          ;          #    #    #    #    #    #    ##  ##             #     #    #    #
   699                          ;          #    #    #    #    #    #    # ## #             #     #    #    #
   700                          ;          #####     #    #    #    #    #    #             #     #    #######
   701                          ;          #   #     #    #    #    #    #    #              #   #          #
   702                          ;          #    #     ####      ####     #    #               ###           #
   703                          ;
   704                          ; ==============================================================================
   705                          
   706                          room_04:
   707                          
   708  12b2 c93b                                   cmp #$3b                                    ; you bumped into a zombie coffin?
   709  12b4 f004                                   beq +                                       ; yep
   710  12b6 c942                                   cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
   711  12b8 d005                                   bne ++                                      ; no, really, I didn't ( I swear! )-> ++
   712  12ba a00d               +                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
   713  12bc 4ce33a                                 jmp death                                   ; 0d You found a thirsty zombie....
   714                          
   715                          ++
   716  12bf c9f7                                   cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
   717  12c1 f007                                   beq +                                       ; seems you picked a coffin that contained something different...
   718  12c3 c9f8                                   cmp #$f8
   719  12c5 f003                                   beq +
   720  12c7 4cf011                                 jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
   721  12ca a900               +                   lda #$00                                    ; 
   722  12cc 8d0339                                 sta m394A + 1                               ; some kind of prep for the door to be unlocked 
   723  12cf a006                                   ldy #$06                                    ; display
   724  12d1 4c2c10                                 jmp prep_and_display_hint
   725                          
   726                          
   727                          
   728                          
   729                          
   730                          
   731                          ; ==============================================================================
   732                          ;
   733                          ;                                                             ###      #######
   734                          ;          #####      ####      ####     #    #              #   #     #
   735                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   736                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   737                          ;          #####     #    #    #    #    #    #             #     #          #
   738                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   739                          ;          #    #     ####      ####     #    #               ###       #####
   740                          ;
   741                          ; ==============================================================================
   742                          
   743                          room_05:
   744                          
   745  12d4 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   746  12d6 b005                                   bcs +                                       ; no
   747  12d8 a000                                   ldy #$00                                    ; a = 0
   748  12da 4c2c10                                 jmp prep_and_display_hint
   749                          
   750  12dd c9fd               +                   cmp #$fd                                    ; stone with breathing tube hit?
   751  12df f003                                   beq +                                       ; yes -> +
   752  12e1 4cf011                                 jmp check_next_char_under_player            ; no
   753                          
   754  12e4 a900               +                   lda #$00                                    ; a = 0                  
   755  12e6 acac36                                 ldy items + $96                             ; do you have the shovel? 
   756  12e9 c0df                                   cpy #$df
   757  12eb d008                                   bne +                                       ; no I don't
   758  12ed 8d9138                                 sta breathing_tube_mod + 1                  ; yes, take the breathing tube
   759  12f0 a007                                   ldy #$07                                    ; and display the message
   760  12f2 4c2c10                                 jmp prep_and_display_hint
   761  12f5 4cd53a             +                   jmp main_loop
   762                          
   763                                              ;ldy #$07                                   ; same is happening above and I don't see this being called
   764                                              ;jmp prep_and_display_hint
   765                          
   766                          
   767                          
   768                          
   769                          
   770                          
   771                          ; ==============================================================================
   772                          ;
   773                          ;                                                             ###       #####
   774                          ;          #####      ####      ####     #    #              #   #     #     #
   775                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   776                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   777                          ;          #####     #    #    #    #    #    #             #     #    #     #
   778                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   779                          ;          #    #     ####      ####     #    #               ###       #####
   780                          ;
   781                          ; ==============================================================================
   782                          
   783                          room_06:
   784                          
   785  12f8 c9f6                                   cmp #$f6                                    ; is it a trapped door?
   786  12fa f003                                   beq +                                       ; OMG Yes the room is full of...
   787  12fc 4cf011                                 jmp check_next_char_under_player            ; please move on. nothing happened.
   788  12ff a000               +                   ldy #$00
   789  1301 4ce33a                                 jmp death                                   ; 00 You fell into a snake pit
   790                          
   791                          
   792                          
   793                          
   794                          
   795                          
   796                          ; ==============================================================================
   797                          ;
   798                          ;                                                             ###      #######
   799                          ;          #####      ####      ####     #    #              #   #     #    #
   800                          ;          #    #    #    #    #    #    ##  ##             #     #        #
   801                          ;          #    #    #    #    #    #    # ## #             #     #       #
   802                          ;          #####     #    #    #    #    #    #             #     #      #
   803                          ;          #   #     #    #    #    #    #    #              #   #       #
   804                          ;          #    #     ####      ####     #    #               ###        #
   805                          ;
   806                          ; ==============================================================================
   807                          
   808                          room_07:
   809                                  
   810  1304 c9e3                                   cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
   811  1306 d005                                   bne +
   812  1308 a001                                   ldy #$01                                    ; 01 You'd better watched out for the sacred column
   813  130a 4ce33a                                 jmp death                                   ; bne m1303 <- seems unneccessary
   814                          
   815  130d c95f               +                   cmp #$5f                                    ; seems to be the invisible char for the light
   816  130f f003                                   beq +                                       ; and it was hit -> +
   817  1311 4cf011                                 jmp check_next_char_under_player            ; if not, continue checking
   818                          
   819  1314 a9bc               +                   lda #$bc                                    ; make light visible
   820  1316 8d8a36                                 sta items + $74                             ; but I dont understand how the whole light is shown
   821  1319 a95f                                   lda #$5f                                    ; color?
   822  131b 8d8836                                 sta items + $72                             ; 
   823  131e 20d237                                 jsr update_items_display                    ; and redraw items
   824  1321 a0ff                                   ldy #$ff
   825  1323 20ff39                                 jsr wait                                    ; wait for some time so the player can actually see the light
   826  1326 20ff39                                 jsr wait
   827  1329 20ff39                                 jsr wait
   828  132c 20ff39                                 jsr wait
   829  132f a9df                                   lda #$df
   830  1331 8d8a36                                 sta items + $74                             ; and pick up the light/ remove it from the items list
   831  1334 a900                                   lda #$00
   832  1336 8d8836                                 sta items + $72                             ; also paint the char black
   833  1339 4cda11                                 jmp check_death
   834                          
   835                          
   836                          
   837                          
   838                          
   839                          
   840                          ; ==============================================================================
   841                          ;
   842                          ;                                                             ###       #####
   843                          ;          #####      ####      ####     #    #              #   #     #     #
   844                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   845                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   846                          ;          #####     #    #    #    #    #    #             #     #    #     #
   847                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   848                          ;          #    #     ####      ####     #    #               ###       #####
   849                          ;
   850                          ; ==============================================================================
   851                          
   852                          room_08:
   853                          
   854  133c a000                                   ldy #$00                                    ; y = 0
   855  133e 84a7                                   sty zpA7                                    ; zpA7 = 0
   856  1340 c94b                                   cmp #$4b                                    ; water
   857  1342 d015                                   bne check_item_water
   858  1344 ac9138                                 ldy breathing_tube_mod + 1
   859  1347 d017                                   bne +
   860  1349 209635                                 jsr get_player_pos
   861  134c a918                                   lda #$18                                    ; move player on the other side of the river
   862  134e 8d4235             --                  sta player_pos_x + 1
   863  1351 a90c                                   lda #$0c
   864  1353 8d4035                                 sta player_pos_y + 1
   865  1356 4cd53a             -                   jmp main_loop
   866                          
   867                          
   868                          check_item_water:
   869  1359 c956                                   cmp #$56                                    ; so you want to swim right?
   870  135b d011                                   bne check_item_shovel                       ; nah, not this time -> check_item_shovel
   871  135d ac9138                                 ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
   872  1360 d007               +                   bne +
   873  1362 209635                                 jsr get_player_pos                          ; tube equipped and ready to submerge
   874  1365 a90c                                   lda #$0c
   875  1367 d0e5                                   bne --                                      ; see you on the other side!
   876                          
   877  1369 a002               +                   ldy #$02                                    ; breathing what?
   878  136b 4ce33a                                 jmp death                                   ; 02 You drowned in the deep river
   879                          
   880                          
   881                          check_item_shovel:
   882  136e c9c1                                   cmp #$c1                                    ; wanna have that shovel?
   883  1370 f004                                   beq +                                       ; yup
   884  1372 c9c3                                   cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
   885  1374 d008                                   bne ++                                      ; nah still not interested -> ++
   886  1376 a9df               +                   lda #$df                                    ; alright cool,
   887  1378 8dac36                                 sta items + $96                             ; shovel is yours now
   888  137b 4cda11             --                  jmp check_death
   889                          
   890                          
   891  137e c9ca               ++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
   892  1380 f003                                   beq +                                       ; yup
   893  1382 4cf011                                 jmp check_next_char_under_player
   894  1385 add136             +                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
   895  1388 c9df                                   cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
   896  138a d0ca                                   bne -                                       ; what hammer?
   897  138c a9df                                   lda #$df
   898  138e 8d9a36                                 sta items + $84                             ; these fine boots are yours now, sir
   899  1391 d0e8                                   bne --
   900                          
   901                          
   902                          
   903                          
   904                          
   905                          
   906                          ; ==============================================================================
   907                          ;
   908                          ;                                                             ###       #####
   909                          ;          #####      ####      ####     #    #              #   #     #     #
   910                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   911                          ;          #    #    #    #    #    #    # ## #             #     #     ######
   912                          ;          #####     #    #    #    #    #    #             #     #          #
   913                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   914                          ;          #    #     ####      ####     #    #               ###       #####
   915                          ;
   916                          ; ==============================================================================
   917                          
   918                          room_09:            
   919                          
   920  1393 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   921  1395 9003                                   bcc +                                       ; yes -> +
   922  1397 4cf011                                 jmp check_next_char_under_player            ; continue checking
   923  139a a002               +                   ldy #$02                                    ; display hint
   924  139c 4c2c10                                 jmp prep_and_display_hint
   925                          
   926                          
   927                          
   928                          
   929                          
   930                          
   931                          ; ==============================================================================
   932                          ;
   933                          ;                                                             #        ###
   934                          ;          #####      ####      ####     #    #              ##       #   #
   935                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
   936                          ;          #    #    #    #    #    #    # ## #               #      #     #
   937                          ;          #####     #    #    #    #    #    #               #      #     #
   938                          ;          #   #     #    #    #    #    #    #               #       #   #
   939                          ;          #    #     ####      ####     #    #             #####      ###
   940                          ;
   941                          ; ==============================================================================
   942                          
   943                          room_10:
   944                          
   945  139f c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   946  13a1 b005                                   bcs +
   947  13a3 a000                                   ldy #$00                                    ; display hint
   948  13a5 4c2c10                                 jmp prep_and_display_hint
   949                          
   950  13a8 c9cc               +                   cmp #$cc                                    ; hit the power outlet?
   951  13aa f007                                   beq +                                       ; yes -> +
   952  13ac c9cf                                   cmp #$cf                                    ; hit the power outlet?
   953  13ae f003                                   beq +                                       ; yes -> +
   954  13b0 4cf011                                 jmp check_next_char_under_player            ; no, continue
   955  13b3 a9df               +                   lda #$df                                    
   956  13b5 cd8a36                                 cmp items + $74                             ; light picked up?
   957  13b8 d010                                   bne +                                       ; no -> death
   958  13ba cdde36                                 cmp items + $c8                             ; yes, lightbulb picked up?
   959  13bd d00b                                   bne +                                       ; no -> death
   960  13bf 8dc236                                 sta items + $ac                             ; yes, pick up power outlet
   961  13c2 a959                                   lda #$59                                    ; and make the foot traps visible
   962  13c4 8d4237                                 sta items + $12c                            ; color position for foot traps
   963  13c7 4cda11                                 jmp check_death
   964                          
   965  13ca a006               +                   ldy #$06
   966  13cc 4ce33a                                 jmp death                                   ; 06 240 Volts! You got an electrical shock!
   967                          
   968                          
   969                          
   970                          
   971                          
   972                          
   973                          ; ==============================================================================
   974                          ;
   975                          ;                                                             #        #
   976                          ;          #####      ####      ####     #    #              ##       ##
   977                          ;          #    #    #    #    #    #    ##  ##             # #      # #
   978                          ;          #    #    #    #    #    #    # ## #               #        #
   979                          ;          #####     #    #    #    #    #    #               #        #
   980                          ;          #   #     #    #    #    #    #    #               #        #
   981                          ;          #    #     ####      ####     #    #             #####    #####
   982                          ;
   983                          ; ==============================================================================
   984                          
   985                          room_11:
   986                          
   987  13cf c9d1                                   cmp #$d1                                    ; picking up the hammer?
   988  13d1 f003                                   beq +                                       ; jep
   989  13d3 4cf011                                 jmp check_next_char_under_player            ; no, continue
   990  13d6 a9df               +                   lda #$df                                    ; player takes the hammer
   991  13d8 8dd136                                 sta items + $bb                             ; hammer
   992  13db 4cda11                                 jmp check_death
   993                          
   994                          
   995                          
   996                          
   997                          
   998                          
   999                          ; ==============================================================================
  1000                          ;
  1001                          ;                                                             #       #####
  1002                          ;          #####      ####      ####     #    #              ##      #     #
  1003                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1004                          ;          #    #    #    #    #    #    # ## #               #       #####
  1005                          ;          #####     #    #    #    #    #    #               #      #
  1006                          ;          #   #     #    #    #    #    #    #               #      #
  1007                          ;          #    #     ####      ####     #    #             #####    #######
  1008                          ;
  1009                          ; ==============================================================================
  1010                          
  1011                          room_12:
  1012                          
  1013  13de c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1014  13e0 b005                                   bcs +                                       ; no
  1015  13e2 a000                                   ldy #$00                                    
  1016  13e4 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1017                          
  1018  13e7 c9d2               +                   cmp #$d2                                    ; light bulb hit?
  1019  13e9 f007                                   beq +                                       ; yes
  1020  13eb c9d5                                   cmp #$d5                                    ; light bulb hit?
  1021  13ed f003                                   beq +                                       ; yes
  1022  13ef 4cf011                                 jmp check_next_char_under_player            ; no, continue
  1023  13f2 a9df               +                   lda #$df                                    ; pick up light bulb
  1024  13f4 8dde36                                 sta items + $c8
  1025  13f7 4cda11                                 jmp check_death
  1026                          
  1027                          
  1028                          
  1029                          
  1030                          
  1031                          
  1032                          ; ==============================================================================
  1033                          ;
  1034                          ;                                                             #       #####
  1035                          ;          #####      ####      ####     #    #              ##      #     #
  1036                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1037                          ;          #    #    #    #    #    #    # ## #               #       #####
  1038                          ;          #####     #    #    #    #    #    #               #            #
  1039                          ;          #   #     #    #    #    #    #    #               #      #     #
  1040                          ;          #    #     ####      ####     #    #             #####     #####
  1041                          ;
  1042                          ; ==============================================================================
  1043                          
  1044                          room_13:           
  1045                          
  1046  13fa c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1047  13fc b005                                   bcs +
  1048  13fe a000                                   ldy #$00                                    ; message 0 to display
  1049  1400 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1050                          
  1051  1403 c9d6               +                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
  1052  1405 f003                                   beq +                                       ; OUCH!! -> +
  1053  1407 4cf011                                 jmp check_next_char_under_player            ; not stepped into a nail... yet.
  1054  140a ad9a36             +                   lda items + $84                             ; are the boots taken?
  1055  140d c9df                                   cmp #$df                                
  1056  140f f005                                   beq +                                       ; yeah I'm cool these boots are made for nailin'. 
  1057  1411 a007                                   ldy #$07                                    ; death by a thousand nails.
  1058  1413 4ce33a                                 jmp death                                   ; 07 You stepped on a nail!
  1059                          
  1060                          +
  1061  1416 a9e2                                   lda #$e2                                    ; this is also a nail. 
  1062  1418 8deb36                                 sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
  1063  141b 4cda11                                 jmp check_death
  1064                          
  1065                          
  1066                          
  1067                          
  1068                          
  1069                          
  1070                          ; ==============================================================================
  1071                          ;
  1072                          ;                                                             #      #
  1073                          ;          #####      ####      ####     #    #              ##      #    #
  1074                          ;          #    #    #    #    #    #    ##  ##             # #      #    #
  1075                          ;          #    #    #    #    #    #    # ## #               #      #    #
  1076                          ;          #####     #    #    #    #    #    #               #      #######
  1077                          ;          #   #     #    #    #    #    #    #               #           #
  1078                          ;          #    #     ####      ####     #    #             #####         #
  1079                          ;
  1080                          ; ==============================================================================
  1081                          
  1082                          room_14:
  1083                          
  1084  141e c9d7                                   cmp #$d7                                    ; foot trap char
  1085  1420 f003                                   beq +                                       ; stepped into it?
  1086  1422 4cf011                                 jmp check_next_char_under_player            ; not... yet...
  1087  1425 a008               +                   ldy #$08                                    ; go die
  1088  1427 4ce33a                                 jmp death                                   ; 08 A foot trap stopped you!
  1089                          
  1090                          
  1091                          
  1092                          
  1093                          
  1094                          
  1095                          ; ==============================================================================
  1096                          ;
  1097                          ;                                                             #      #######
  1098                          ;          #####      ####      ####     #    #              ##      #
  1099                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1100                          ;          #    #    #    #    #    #    # ## #               #      ######
  1101                          ;          #####     #    #    #    #    #    #               #            #
  1102                          ;          #   #     #    #    #    #    #    #               #      #     #
  1103                          ;          #    #     ####      ####     #    #             #####     #####
  1104                          ;
  1105                          ; ==============================================================================
  1106                          
  1107                          room_15:
  1108                          
  1109  142a c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1110  142c b005                                   bcs +
  1111  142e a000                                   ldy #$00                                    ; display hint
  1112  1430 4c2c10                                 jmp prep_and_display_hint
  1113                          
  1114  1433 4cf011             +                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address
  1115                          
  1116                          
  1117                          
  1118                          
  1119                          
  1120                          
  1121                          ; ==============================================================================
  1122                          ;
  1123                          ;                                                             #       #####
  1124                          ;          #####      ####      ####     #    #              ##      #     #
  1125                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1126                          ;          #    #    #    #    #    #    # ## #               #      ######
  1127                          ;          #####     #    #    #    #    #    #               #      #     #
  1128                          ;          #   #     #    #    #    #    #    #               #      #     #
  1129                          ;          #    #     ####      ####     #    #             #####     #####
  1130                          ;
  1131                          ; ==============================================================================
  1132                          
  1133                          room_16:
  1134                          
  1135  1436 c9f4                                   cmp #$f4                                    ; did you hit the wall in the left cell?
  1136  1438 d005                                   bne +                                       ; I did not! -> +
  1137  143a a00a                                   ldy #$0a                                    ; yeah....
  1138  143c 4ce33a                                 jmp death                                   ; 0a You were locked in and starved!
  1139                          
  1140  143f c9d9               +                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
  1141  1441 f004                                   beq +                                       ; not that I know of...
  1142  1443 c9db                                   cmp #$db                                    ; are you sure? take a look at this slightly different wall
  1143  1445 d005                                   bne ++                                      ; it doesn't look familiar... -> ++
  1144                          
  1145  1447 a009               +                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
  1146  1449 4ce33a                                 jmp death
  1147                          
  1148  144c c9b9               ++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
  1149  144e f007                                   beq +                                       ; yes! -> +
  1150  1450 c9bb                                   cmp #$bb                                    ; here's another part of that bottle for reference
  1151  1452 f003                                   beq +                                       ; yes! -> +
  1152  1454 4cf011                                 jmp check_next_char_under_player            ; no, continue
  1153  1457 a003               +                   ldy #$03                                    ; display code enter screen
  1154  1459 4c2c10                                 jmp prep_and_display_hint
  1155                          
  1156                          
  1157                          
  1158                          
  1159                          
  1160                          
  1161                          ; ==============================================================================
  1162                          ;
  1163                          ;                                                             #      #######
  1164                          ;          #####      ####      ####     #    #              ##      #    #
  1165                          ;          #    #    #    #    #    #    ##  ##             # #          #
  1166                          ;          #    #    #    #    #    #    # ## #               #         #
  1167                          ;          #####     #    #    #    #    #    #               #        #
  1168                          ;          #   #     #    #    #    #    #    #               #        #
  1169                          ;          #    #     ####      ####     #    #             #####      #
  1170                          ;
  1171                          ; ==============================================================================
  1172                          
  1173                          room_17:
  1174                          
  1175  145c c9dd                                   cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
  1176  145e f003                                   beq +                                       ; yup
  1177  1460 4cf011                                 jmp check_next_char_under_player            ; nah not yet.
  1178  1463 a9df               +                   lda #$df                                    ; pick up sword
  1179  1465 8dbd37                                 sta items + $1a7                            ; store in items list
  1180  1468 4cda11                                 jmp check_death
  1181                          
  1182                          
  1183                          
  1184                          
  1185                          
  1186                          
  1187                          ; ==============================================================================
  1188                          ;
  1189                          ;                                                             #       #####
  1190                          ;          #####      ####      ####     #    #              ##      #     #
  1191                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
  1192                          ;          #    #    #    #    #    #    # ## #               #       #####
  1193                          ;          #####     #    #    #    #    #    #               #      #     #
  1194                          ;          #   #     #    #    #    #    #    #               #      #     #
  1195                          ;          #    #     ####      ####     #    #             #####     #####
  1196                          ;
  1197                          ; ==============================================================================
  1198                          
  1199                          room_18:
  1200  146b c981                                   cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
  1201  146d b003                                   bcs +                   
  1202  146f 4cda11                                 jmp check_death
  1203                          
  1204  1472 ada512             +                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
  1205  1475 d003                                   bne +                                       ; yes I actually did (flexes arms)
  1206  1477 4cd53a                                 jmp main_loop                               ; nope
  1207  147a 20263a             +                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
  1208  147d 4c451b                                 jmp print_endscreen                         ; (drops mic)
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
  1249                          
  1250                          ; ==============================================================================
  1251                          ; 
  1252                          ; EVERYTHING ANIMATION RELATED STARTS HERE
  1253                          ; ANIMATIONS FOR
  1254                          ; LASER, BORIS, BELEGRO, STONE, MONSTER
  1255                          ; ==============================================================================
  1256                          
  1257                          ; TODO
  1258                          ; this gets called all the time, no checks 
  1259                          ; needs to be optimized
  1260                          
  1261                          
  1262                          animation_entrypoint:
  1263                                              
  1264                                              ; code below is used to check if the foot traps should be visible
  1265                                              ; it checked for this every single fucking frame
  1266                                              ; moved the foot traps coloring where it belongs (when picking up power outlet)
  1267                                              ;lda items + $ac                         ; $cc (power outlet)
  1268                                              ;cmp #$df                                ; taken?
  1269                                              ;bne +                                   ; no -> +
  1270                                              ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
  1271                                              ;sta items + $12c                        ; originally $0
  1272                          
  1273  1480 acf82f             +                   ldy current_room + 1                    ; load room number
  1274                          
  1275  1483 c011                                   cpy #$11                                ; is it room #17? (Belegro)
  1276  1485 d046                                   bne room_14_prep                         ; no -> m162A
  1277                                              
  1278                                              
  1279  1487 ad1c15                                 lda m14CC + 1                           ; yes, get value from m14CD
  1280  148a d013                                   bne m15FC                               ; 0? -> m15FC
  1281  148c ad4035                                 lda player_pos_y + 1                    ; not 0, get player pos Y
  1282  148f c906                                   cmp #$06                                ; is it 6?
  1283  1491 d00c                                   bne m15FC                               ; no -> m15FC
  1284  1493 ad4235                                 lda player_pos_x + 1                    ; yes, get player pos X
  1285  1496 c918                                   cmp #$18                                ; is player x position $18?
  1286  1498 d005                                   bne m15FC                               ; no -> m15FC
  1287  149a a900                                   lda #$00                                ; yes, load 0
  1288  149c 8da014                                 sta m15FC + 1                           ; store 0 in m15FC+1
  1289  149f a901               m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
  1290  14a1 d016                                   bne +                                   ; is it 0? -> +
  1291  14a3 a006                                   ldy #$06                                ; y = $6
  1292  14a5 a21e               m1602:              ldx #$1e                                ; x = $1e
  1293  14a7 a900                                   lda #$00                                ; a = $0
  1294  14a9 85a7                                   sta zpA7                                ; zpA7 = 0
  1295  14ab 20c734                                 jsr draw_player                         ; TODO
  1296  14ae aea614                                 ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
  1297  14b1 e003                                   cpx #$03                                ; is X = $3?
  1298  14b3 f001                                   beq ++                                  ; yes -> ++
  1299  14b5 ca                                     dex                                     ; x = x -1
  1300  14b6 8ea614             ++                  stx m1602 + 1                           ; store x in m1602+1
  1301  14b9 a978               +                   lda #$78                                ; a = $78
  1302  14bb 85a8                                   sta zpA8                                ; zpA8 = $78
  1303  14bd a949                                   lda #$49                                ; a = $49
  1304  14bf 850a                                   sta zp0A                                ; zp0A = $49
  1305  14c1 a006                                   ldy #$06                                ; y = $06
  1306  14c3 a901                                   lda #$01                                ; a = $01
  1307  14c5 85a7                                   sta zpA7                                ; zpA7 = $01
  1308  14c7 aea614                                 ldx m1602 + 1                           ; get stored x value (should still be the same?)
  1309  14ca 20c734                                 jsr draw_player                         ; TODO
  1310                          
  1311                          
  1312                          room_14_prep:              
  1313  14cd acf82f                                 ldy current_room + 1                    ; load room number
  1314  14d0 c00e                                   cpy #14                                 ; is it #14?
  1315  14d2 d005                                   bne room_15_prep                        ; no -> m148A
  1316  14d4 a020                                   ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
  1317  14d6 20ff39                                 jsr wait                                ; was jmp wait before
  1318                          
  1319                          ; ==============================================================================
  1320                          ; ROOM 15 ANIMATION
  1321                          ; MOVEMENT OF THE MONSTER
  1322                          ; ==============================================================================
  1323                          
  1324                          room_15_prep:              
  1325  14d9 c00f                                   cpy #15                                 ; room 15?
  1326  14db d03a                                   bne room_17_prep                        ; no -> m14C8
  1327  14dd a900                                   lda #$00                                ; 
  1328  14df 85a7                                   sta zpA7
  1329  14e1 a00c                                   ldy #$0c                                ; x/y pos of the monster
  1330  14e3 a206               m1494:              ldx #$06
  1331  14e5 20c734                                 jsr draw_player
  1332  14e8 a9eb                                   lda #$eb                                ; the monster (try 9c for Belegro)
  1333  14ea 85a8                                   sta zpA8
  1334  14ec a939                                   lda #$39                                ; color of the monster's cape
  1335  14ee 850a                                   sta zp0A
  1336  14f0 aee414                                 ldx m1494 + 1                           ; self mod the x position of the monster
  1337  14f3 a901               m14A4:              lda #$01
  1338  14f5 d00a                                   bne m14B2               
  1339  14f7 e006                                   cpx #$06                                ; moved 6 steps?
  1340  14f9 d002                                   bne +                                   ; no, keep moving
  1341  14fb a901                                   lda #$01
  1342  14fd ca                 +                   dex
  1343  14fe 4c0815                                 jmp +                                   ; change direction
  1344                          
  1345                          m14B2:              
  1346  1501 e00b                                   cpx #$0b
  1347  1503 d002                                   bne ++
  1348  1505 a900                                   lda #$00
  1349  1507 e8                 ++                  inx
  1350  1508 8ee414             +                   stx m1494 + 1
  1351  150b 8df414                                 sta m14A4 + 1
  1352  150e a901                                   lda #$01
  1353  1510 85a7                                   sta zpA7
  1354  1512 a00c                                   ldy #$0c
  1355  1514 4cc734                                 jmp draw_player
  1356                                             
  1357                          ; ==============================================================================
  1358                          ; ROOM 17 ANIMATION
  1359                          ;
  1360                          ; ==============================================================================
  1361                          
  1362                          room_17_prep:              
  1363  1517 c011                                   cpy #17                             ; room number 17?
  1364  1519 d014                                   bne +                               ; no -> +
  1365  151b a901               m14CC:              lda #$01                            ; selfmod
  1366  151d f021                                   beq ++                              
  1367                                                                                 
  1368                                              ; was moved here
  1369                                              ; as it was called only from this place
  1370                                              ; jmp m15C1  
  1371  151f a900               m15C1:              lda #$00                            ; a = 0 (selfmod)
  1372  1521 c900                                   cmp #$00                            ; is a = 0?
  1373  1523 d004                                   bne skipper                         ; not 0 -> 15CB
  1374  1525 ee2015                                 inc m15C1 + 1                       ; inc m15C1
  1375  1528 60                                     rts
  1376                                       
  1377  1529 ce2015             skipper:            dec m15C1 + 1                       ; dec $15c2
  1378  152c 4cb335                                 jmp belegro_animation
  1379                          
  1380  152f a90f               +                   lda #$0f                            ; a = $0f
  1381  1531 8db835                                 sta m3624 + 1                       ; selfmod
  1382  1534 8dba35                                 sta m3626 + 1                       ; selfmod
  1383                          
  1384                          
  1385  1537 c00a                                   cpy #10                             ; room number 10?
  1386  1539 d044                                   bne check_if_room_09                ; no -> m1523
  1387  153b ceb82f                                 dec speed_byte                      ; yes, reduce speed
  1388  153e f001                                   beq laser_beam_animation            ; if positive -> laser_beam_animation            
  1389  1540 60                 ++                  rts
  1390                          
  1391                          ; ==============================================================================
  1392                          ; ROOM 10
  1393                          ; LASER BEAM ANIMATION
  1394                          ; ==============================================================================
  1395                          
  1396                          laser_beam_animation:
  1397                                             
  1398  1541 a008                                   ldy #$08                            ; speed of the laser flashing
  1399  1543 8cb82f                                 sty speed_byte                      ; store     
  1400  1546 a9d9                                   lda #$d9
  1401  1548 8505                                   sta zp05                            ; affects the colram of the laser
  1402  154a a905                                   lda #$05                            ; but not understood yet
  1403  154c 8503                                   sta zp03
  1404  154e a97b                                   lda #$7b                            ; position of the laser
  1405  1550 8502                                   sta zp02
  1406  1552 8504                                   sta zp04
  1407  1554 a9df                                   lda #$df                            ; laser beam off
  1408  1556 cd6315                                 cmp m1506 + 1                       
  1409  1559 d002                                   bne +                               
  1410  155b a9d8                                   lda #$d8                            ; laser beam character
  1411  155d 8d6315             +                   sta m1506 + 1                       
  1412  1560 a206                                   ldx #$06                            ; 6 laser beam characters
  1413  1562 a9df               m1506:              lda #$df
  1414  1564 a000                                   ldy #$00
  1415  1566 9102                                   sta (zp02),y
  1416  1568 a9ee                                   lda #$ee
  1417  156a 9104                                   sta (zp04),y
  1418  156c a502                                   lda zp02
  1419  156e 18                                     clc
  1420  156f 6928                                   adc #$28                            ; draws the laser beam
  1421  1571 8502                                   sta zp02
  1422  1573 8504                                   sta zp04
  1423  1575 9004                                   bcc +                               
  1424  1577 e603                                   inc zp03
  1425  1579 e605                                   inc zp05
  1426  157b ca                 +                   dex
  1427  157c d0e4                                   bne m1506                           
  1428  157e 60                 -                   rts
  1429                          
  1430                          ; ==============================================================================
  1431                          
  1432                          check_if_room_09:              
  1433  157f c009                                   cpy #09                         ; room number 09?
  1434  1581 f001                                   beq room_09_counter                           ; yes -> +
  1435  1583 60                                     rts                             ; no
  1436                          
  1437                          room_09_counter:
  1438  1584 a201                                   ldx #$01                                ; x = 1 (selfmod)
  1439  1586 e001                                   cpx #$01                                ; is x = 1?
  1440  1588 f003                                   beq +                                   ; yes -> +
  1441  158a 4ca515                                 jmp boris_the_spider_animation          ; no, jump boris animation
  1442  158d ce8515             +                   dec room_09_counter + 1                 ; decrease initial x
  1443  1590 60                                     rts
  1444                          
  1445                          ; ==============================================================================
  1446                          ;
  1447                          ; I moved this out of the main loop and call it once when changing rooms
  1448                          ; TODO: call it only when room 4 is entered
  1449                          ; ==============================================================================
  1450                          
  1451                          room_04_prep_door:
  1452                                              
  1453  1591 adf82f                                 lda current_room + 1                            ; get current room
  1454  1594 c904                                   cmp #04                                         ; is it 4? (coffins)
  1455  1596 d00c                                   bne ++                                          ; nope
  1456  1598 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  1457  159a ac0339                                 ldy m394A + 1                                   ; 
  1458  159d f002                                   beq +
  1459  159f a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  1460  15a1 8df904             +                   sta SCREENRAM + $f9 
  1461  15a4 60                 ++                  rts
  1462                          
  1463                          ; ==============================================================================
  1464                          ; ROOM 09
  1465                          ; BORIS THE SPIDER ANIMATION
  1466                          ; ==============================================================================
  1467                          
  1468                          boris_the_spider_animation:
  1469                          
  1470  15a5 ee8515                                 inc room_09_counter + 1                           
  1471  15a8 a9d8                                   lda #>COLRAM + 1                               ; affects the color ram position for boris the spider
  1472  15aa 8505                                   sta zp05
  1473  15ac a904                                   lda #>SCREENRAM
  1474  15ae 8503                                   sta zp03
  1475  15b0 a90f                                   lda #$0f
  1476  15b2 8502                                   sta zp02
  1477  15b4 8504                                   sta zp04
  1478  15b6 a206               m1535:              ldx #$06
  1479  15b8 a900               m1537:              lda #$00
  1480  15ba d009                                   bne +
  1481  15bc ca                                     dex
  1482  15bd e002                                   cpx #$02
  1483  15bf d00b                                   bne ++
  1484  15c1 a901                                   lda #$01
  1485  15c3 d007                                   bne ++
  1486  15c5 e8                 +                   inx
  1487  15c6 e007                                   cpx #$07
  1488  15c8 d002                                   bne ++
  1489  15ca a900                                   lda #$00
  1490  15cc 8db915             ++                  sta m1537 + 1
  1491  15cf 8eb715                                 stx m1535 + 1
  1492  15d2 a000               -                   ldy #$00
  1493  15d4 a9df                                   lda #$df
  1494  15d6 9102                                   sta (zp02),y
  1495  15d8 c8                                     iny
  1496  15d9 c8                                     iny
  1497  15da 9102                                   sta (zp02),y
  1498  15dc 88                                     dey
  1499  15dd a9ea                                   lda #$ea
  1500  15df 9102                                   sta (zp02),y
  1501  15e1 9104                                   sta (zp04),y
  1502  15e3 201e16                                 jsr move_boris                       
  1503  15e6 ca                                     dex
  1504  15e7 d0e9                                   bne -
  1505  15e9 a9e4                                   lda #$e4
  1506  15eb 85a8                                   sta zpA8
  1507  15ed a202                                   ldx #$02
  1508  15ef a000               --                  ldy #$00
  1509  15f1 a5a8               -                   lda zpA8
  1510  15f3 9102                                   sta (zp02),y
  1511  15f5 a9da                                   lda #$da
  1512  15f7 9104                                   sta (zp04),y
  1513  15f9 e6a8                                   inc zpA8
  1514  15fb c8                                     iny
  1515  15fc c003                                   cpy #$03
  1516  15fe d0f1                                   bne -
  1517  1600 201e16                                 jsr move_boris                       
  1518  1603 ca                                     dex
  1519  1604 d0e9                                   bne --
  1520  1606 a000                                   ldy #$00
  1521  1608 a9e7                                   lda #$e7
  1522  160a 85a8                                   sta zpA8
  1523  160c b102               -                   lda (zp02),y
  1524  160e c5a8                                   cmp zpA8
  1525  1610 d004                                   bne +
  1526  1612 a9df                                   lda #$df
  1527  1614 9102                                   sta (zp02),y
  1528  1616 e6a8               +                   inc zpA8
  1529  1618 c8                                     iny
  1530  1619 c003                                   cpy #$03
  1531  161b d0ef                                   bne -
  1532  161d 60                                     rts
  1533                          
  1534                          ; ==============================================================================
  1535                          
  1536                          move_boris:
  1537  161e a502                                   lda zp02
  1538  1620 18                                     clc
  1539  1621 6928                                   adc #$28
  1540  1623 8502                                   sta zp02
  1541  1625 8504                                   sta zp04
  1542  1627 9004                                   bcc +                                   
  1543  1629 e603                                   inc zp03
  1544  162b e605                                   inc zp05
  1545  162d 60                 +                   rts
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
  1565                          
  1566                          ; ==============================================================================
  1567                          
  1568                          prep_player_pos:
  1569                          
  1570  162e a209                                   ldx #$09
  1571  1630 bd4403             -                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
  1572  1633 9d5403                                 sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
  1573  1636 ca                                     dex
  1574  1637 d0f7                                   bne -                                   ; so this seems to create a copy of the area under the player
  1575                          
  1576  1639 a902                                   lda #$02                                ; a = 2
  1577  163b 85a7                                   sta zpA7
  1578  163d ae4235                                 ldx player_pos_x + 1                    ; x = player x
  1579  1640 ac4035                                 ldy player_pos_y + 1                    ; y = player y
  1580  1643 20c734                                 jsr draw_player                         ; draw player
  1581  1646 60                                     rts
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
  1602                          
  1603                          ; ==============================================================================
  1604                          ; OBJECT ANIMATION COLLISION ROUTINE
  1605                          ; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
  1606                          ; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
  1607                          ; ==============================================================================
  1608                          
  1609                          object_collision:
  1610                          
  1611  1647 a209                                   ldx #$09                                ; x = 9
  1612                          
  1613                          check_loop:              
  1614                          
  1615  1649 bd4403                                 lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1616  164c c9d8                                   cmp #$d8                                ; check for laser beam
  1617  164e d005                                   bne +                  
  1618                          
  1619  1650 a005               m164E:              ldy #$05
  1620  1652 4ce33a             jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?
  1621                          
  1622  1655 acf82f             +                   ldy current_room + 1                    ; get room number
  1623  1658 c011                                   cpy #17                                 ; is it $11 = #17 (Belegro)?
  1624  165a d010                                   bne +                                   ; nope -> +
  1625  165c c978                                   cmp #$78                                ; hit by the stone?
  1626  165e f008                                   beq ++                                  ; yep -> ++
  1627  1660 c97b                                   cmp #$7b                                ; or another part of the stone?
  1628  1662 f004                                   beq ++                                  ; yes -> ++
  1629  1664 c97e                                   cmp #$7e                                ; or another part of the stone?
  1630  1666 d004                                   bne +                                   ; nah, -> +
  1631  1668 a00b               ++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
  1632  166a d0e6                                   bne jmp_death
  1633  166c c99c               +                   cmp #$9c                                ; so Belegro hit you?
  1634  166e 9007                                   bcc m1676
  1635  1670 c9a5                                   cmp #$a5
  1636  1672 b003                                   bcs m1676
  1637  1674 4ca816                                 jmp m16A7
  1638                          
  1639  1677 c9e4               m1676:              cmp #$e4                                ; hit by Boris the spider?
  1640  1679 9010                                   bcc +                           
  1641  167b c9eb                                   cmp #$eb
  1642  167d b004                                   bcs ++                          
  1643  167f a004               -                   ldy #$04                                ; 04 Boris the spider got you and killed you
  1644  1681 d0cf                                   bne jmp_death                       
  1645  1683 c9f4               ++                  cmp #$f4
  1646  1685 b004                                   bcs +                           
  1647  1687 a00e                                   ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
  1648  1689 d0c7                                   bne jmp_death                       
  1649  168b ca                 +                   dex
  1650  168c d0bb                                   bne check_loop   
  1651                          
  1652                          
  1653                          
  1654  168e a209                                   ldx #$09
  1655  1690 bd5403             --                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
  1656  1693 9d4403                                 sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1657  1696 c9d8                                   cmp #$d8
  1658  1698 f0b6                                   beq m164E                       
  1659  169a c9e4                                   cmp #$e4
  1660  169c 9004                                   bcc +                           
  1661  169e c9ea                                   cmp #$ea
  1662  16a0 90dd                                   bcc -                           
  1663  16a2 ca                 +                   dex
  1664  16a3 d0eb                                   bne --                          
  1665  16a5 4ce011                                 jmp m11E0                     
  1666                          
  1667                          m16A7:
  1668  16a8 acbd37                                 ldy items + $1a7                        ; do you have the sword?
  1669  16ab c0df                                   cpy #$df
  1670  16ad f004                                   beq +                                   ; yes -> +                        
  1671  16af a00c                                   ldy #$0c                                ; 0c Belegro killed you!
  1672  16b1 d09f                                   bne jmp_death                       
  1673  16b3 a000               +                   ldy #$00
  1674  16b5 8c1c15                                 sty m14CC + 1                   
  1675  16b8 4c7716                                 jmp m1676                       
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
  1712                          
  1713                          ; ==============================================================================
  1714                          ; this might be the inventory/ world reset
  1715                          ; puts all items into the level data again
  1716                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1717                          ; addresses are mostly within items.asm address space ( $368a )
  1718                          ; contains color information of the chars
  1719                          ; ==============================================================================
  1720                          
  1721                          reset_items:
  1722  16bb a9a5                                   lda #$a5                        ; $a5 = lock of the shed
  1723  16bd 8d4e36                                 sta items + $38
  1724                          
  1725  16c0 a9a9                                   lda #$a9                        ;
  1726  16c2 8d1e36                                 sta items + $8                  ; gloves
  1727  16c5 a979                                   lda #$79
  1728  16c7 8d1c36                                 sta items + $6                  ; gloves color
  1729                          
  1730  16ca a9e0                                   lda #$e0                        ; empty char
  1731  16cc 8d2636                                 sta items + $10                 ; invisible key
  1732                          
  1733  16cf a9ac                                   lda #$ac                        ; wirecutter
  1734  16d1 8d2f36                                 sta items + $19
  1735                          
  1736  16d4 a9b8                                   lda #$b8                        ; bottle
  1737  16d6 8d3f36                                 sta items + $29
  1738                          
  1739  16d9 a9b0                                   lda #$b0                        ; ladder
  1740  16db 8d6336                                 sta items + $4d
  1741  16de a9b5                                   lda #$b5                        ; more ladder
  1742  16e0 8d6e36                                 sta items + $58
  1743                          
  1744  16e3 a95e                                   lda #$5e                        ; seems to be water?
  1745  16e5 8d8a36                                 sta items + $74
  1746                          
  1747  16e8 a9c6                                   lda #$c6                        ; boots in the whatever box
  1748  16ea 8d9a36                                 sta items + $84
  1749                          
  1750  16ed a9c0                                   lda #$c0                        ; shovel
  1751  16ef 8dac36                                 sta items + $96
  1752                          
  1753  16f2 a9cc                                   lda #$cc                        ; power outlet
  1754  16f4 8dc236                                 sta items + $ac
  1755                          
  1756  16f7 a9d0                                   lda #$d0                        ; hammer
  1757  16f9 8dd136                                 sta items + $bb
  1758                          
  1759  16fc a9d2                                   lda #$d2                        ; light bulb
  1760  16fe 8dde36                                 sta items + $c8
  1761                          
  1762  1701 a9d6                                   lda #$d6                        ; nails
  1763  1703 8deb36                                 sta items + $d5
  1764                          
  1765  1706 a900                                   lda #$00                        ; door
  1766  1708 8d4237                                 sta items + $12c
  1767                          
  1768  170b a9dd                                   lda #$dd                        ; sword
  1769  170d 8dbd37                                 sta items + $1a7
  1770                          
  1771  1710 a901                                   lda #$01                        ; -> wrong write, produced selfmod at the wrong place
  1772  1712 8d0339                                 sta m394A + 1                   ; sta items + $2c1
  1773                          
  1774  1715 a901                                   lda #$01                        ; 
  1775  1717 8d9138                                 sta breathing_tube_mod + 1      ; sta items + $30a
  1776                          
  1777  171a a9f5                                   lda #$f5                        ; fence
  1778  171c 8db538                                 sta delete_fence + 1            ; sta items + $277
  1779                          
  1780  171f a900                                   lda #$00                        ; key in the bottle
  1781  1721 8da512                                 sta key_in_bottle_storage
  1782                          
  1783  1724 a901                                   lda #$01                        ; door
  1784  1726 8da014                                 sta m15FC + 1
  1785                          
  1786  1729 a91e                                   lda #$1e
  1787  172b 8da614                                 sta m1602 + 1
  1788                          
  1789  172e a901                                   lda #$01
  1790  1730 8d1c15                                 sta m14CC + 1
  1791                          
  1792  1733 a205               m1732:              ldx #$05
  1793  1735 e007                                   cpx #$07
  1794  1737 d002                                   bne +
  1795  1739 a2ff                                   ldx #$ff
  1796  173b e8                 +                   inx
  1797  173c 8e3417                                 stx m1732 + 1                   ; stx $1733
  1798  173f bd4817                                 lda m1747,x                     ; lda $1747,x
  1799  1742 8d0b39                                 sta m3952 + 1                   ; sta $3953
  1800  1745 4cb030                                 jmp print_title                 ; jmp $310d
  1801                                              
  1802                          ; ==============================================================================
  1803                          
  1804                          m1747:
  1805  1748 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1806                          
  1807                          
  1808                          m174F:
  1809  1750 e00c                                   cpx #$0c
  1810  1752 d002                                   bne +
  1811  1754 a949                                   lda #$49
  1812  1756 e00d               +                   cpx #$0d
  1813  1758 d002                                   bne +
  1814  175a a945                                   lda #$45
  1815  175c 60                 +                   rts
  1816                          
  1817                          
  1818                          
  1819                          screen_win_src:
  1820                                              !if LANGUAGE = EN{
  1821                                                  !bin "includes/screen-win-en.scr"
  1822                                              }
  1823                                              !if LANGUAGE = DE{
  1824                                                  !bin "includes/screen-win-de.scr"
  1825                                              }
  1826                                              !if LANGUAGE = HU{
  1827  175d 7040404040404040...                        !bin "includes/screen-win-hu.scr"
  1828                                              }
  1829                          screen_win_src_end:
  1830                          
  1831                          
  1832                          ; ==============================================================================
  1833                          ;
  1834                          ; PRINT WIN SCREEN
  1835                          ; ==============================================================================
  1836                          
  1837                          print_endscreen:
  1838  1b45 a904                                   lda #>SCREENRAM
  1839  1b47 8503                                   sta zp03
  1840  1b49 a9d8                                   lda #>COLRAM
  1841  1b4b 8505                                   sta zp05
  1842  1b4d a900                                   lda #<SCREENRAM
  1843  1b4f 8502                                   sta zp02
  1844  1b51 8504                                   sta zp04
  1845  1b53 a204                                   ldx #$04
  1846  1b55 a917                                   lda #>screen_win_src
  1847  1b57 85a8                                   sta zpA8
  1848  1b59 a95d                                   lda #<screen_win_src
  1849  1b5b 85a7                                   sta zpA7
  1850  1b5d a000                                   ldy #$00
  1851  1b5f b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1852  1b61 9102                                   sta (zp02),y        ; to SCREEN
  1853  1b63 a900                                   lda #$00            ; color = BLACK
  1854  1b65 9104                                   sta (zp04),y        ; to COLRAM
  1855  1b67 c8                                     iny
  1856  1b68 d0f5                                   bne -
  1857  1b6a e603                                   inc zp03
  1858  1b6c e605                                   inc zp05
  1859  1b6e e6a8                                   inc zpA8
  1860  1b70 ca                                     dex
  1861  1b71 d0ec                                   bne -
  1862  1b73 a907                                   lda #$07                  ; yellow
  1863  1b75 8d21d0                                 sta BG_COLOR              ; background
  1864  1b78 8d20d0                                 sta BORDER_COLOR          ; und border
  1865  1b7b a5cb               -                   lda $cb                   ; lda #$fd
  1866                                                                        ; sta KEYBOARD_LATCH
  1867                                                                        ; lda KEYBOARD_LATCH
  1868                                                                        ; and #$80           ; WAITKEY?
  1869                                              
  1870  1b7d c93c                                   cmp #$3c                  ; check for space key on C64
  1871  1b7f d0fa                                   bne -
  1872  1b81 20b030                                 jsr print_title
  1873  1b84 20b030                                 jsr print_title
  1874  1b87 4c423a                                 jmp init
  1875                          
  1876                          
  1877                          ; ==============================================================================
  1878                          ;
  1879                          ; INTRO TEXT SCREEN
  1880                          ; ==============================================================================
  1881                          
  1882                          intro_text:
  1883                          
  1884                          ; instructions screen
  1885                          ; "Search the treasure..."
  1886                          
  1887                          !if LANGUAGE = EN{
  1888                          !scr "Search the treasure of Ghost Town and   "
  1889                          !scr "open it ! Kill Belegro, the wizard, and "
  1890                          !scr "dodge all other dangers. Don't forget to"
  1891                          !scr "use all the items you'll find during    "
  1892                          !scr "your journey through 19 amazing hires-  "
  1893                          !scr "graphics-rooms! Enjoy the quest and play"
  1894                          !scr "it again and again and again ...        "
  1895                          !scr "                                        "
  1896                          !scr "         Press fire to start !          "
  1897                          }
  1898                          
  1899                          !if LANGUAGE = DE{
  1900                          !scr "Suchen Sie die Schatztruhe der Geister- "
  1901                          !scr "stadt und oeffnen Sie diese ! Toeten    "
  1902                          !scr "Sie Belegro, den Zauberer und weichen   "
  1903                          !scr "Sie vielen anderen Wesen geschickt aus. "
  1904                          !scr "Bedienen Sie sich an den vielen Gegen-  "
  1905                          !scr "staenden, welche sich in den 19 Bildern "
  1906                          !scr "befinden. Viel Spass !                  "
  1907                          !scr "                                        "
  1908                          !scr "    Druecken Sie Feuer zum Starten !    "
  1909                          }
  1910                          
  1911                          !if LANGUAGE = HU{
  1912  1b8a 4b0512051304200d...!scr "Keresd meg es nyisd fel a Szellemvaros  "
  1913  1bb2 0b090e0313051320...!scr "kincses ladikajat ! Old meg Bellegrot, a"
  1914  1bda 160112011a130c0f...!scr "varazslot, miutan elkerulted a kulonfele"
  1915  1c02 1605131a050c1905...!scr "veszelyes lenyeket. Hasznald az osszes  "
  1916  1c2a 140112071901142c...!scr "targyat, amelyeket a 19 valtozatos kep- "
  1917  1c52 05120e190f0e2001...!scr "ernyon at vezeto kalandod soran talalsz."
  1918  1c7a 4a0f20131a0f1201...!scr "Jo szorakozast!                         "
  1919  1ca2 2020202020202020...!scr "                                        "
  1920  1cca 2020202044121505...!scr "    Druecken Sie Feuer zum Starten !    "
  1921                          }
  1922                          
  1923                          ; ==============================================================================
  1924                          ;
  1925                          ; DISPLAY INTRO TEXT
  1926                          ; ==============================================================================
  1927                          
  1928                          display_intro_text:
  1929                          
  1930                                              ; i think this part displays the introduction text
  1931                          
  1932  1cf2 a904                                   lda #>SCREENRAM       ; lda #$0c
  1933  1cf4 8503                                   sta zp03
  1934  1cf6 a9d8                                   lda #>COLRAM        ; lda #$08
  1935  1cf8 8505                                   sta zp05
  1936  1cfa a9a0                                   lda #$a0
  1937  1cfc 8502                                   sta zp02
  1938  1cfe 8504                                   sta zp04
  1939  1d00 a91b                                   lda #>intro_text
  1940  1d02 85a8                                   sta zpA8
  1941  1d04 a98a                                   lda #<intro_text
  1942  1d06 85a7                                   sta zpA7
  1943  1d08 a209                                   ldx #$09
  1944  1d0a a000               --                  ldy #$00
  1945  1d0c b1a7               -                   lda (zpA7),y
  1946  1d0e 9102                                   sta (zp02),y
  1947  1d10 a968                                   lda #$68
  1948  1d12 9104                                   sta (zp04),y
  1949  1d14 c8                                     iny
  1950  1d15 c028                                   cpy #$28
  1951  1d17 d0f3                                   bne -
  1952  1d19 a5a7                                   lda zpA7
  1953  1d1b 18                                     clc
  1954  1d1c 6928                                   adc #$28
  1955  1d1e 85a7                                   sta zpA7
  1956  1d20 9002                                   bcc +
  1957  1d22 e6a8                                   inc zpA8
  1958  1d24 a502               +                   lda zp02
  1959  1d26 18                                     clc
  1960  1d27 6950                                   adc #$50
  1961  1d29 8502                                   sta zp02
  1962  1d2b 8504                                   sta zp04
  1963  1d2d 9004                                   bcc +
  1964  1d2f e603                                   inc zp03
  1965  1d31 e605                                   inc zp05
  1966  1d33 ca                 +                   dex
  1967  1d34 d0d4                                   bne --
  1968  1d36 a900                                   lda #$00
  1969  1d38 8d21d0                                 sta BG_COLOR
  1970  1d3b 60                                     rts
  1971                          
  1972                          ; ==============================================================================
  1973                          ;
  1974                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1975                          ; DECREASES MUSIC VOLUME
  1976                          ; ==============================================================================
  1977                          
  1978                          start_intro:        ;sta KEYBOARD_LATCH
  1979  1d3c 20423b                                 jsr clear                                   ; jsr PRINT_KERNAL
  1980  1d3f 20f21c                                 jsr display_intro_text
  1981  1d42 201e1f                                 jsr check_shift_key
  1982                                              
  1983                                              ;lda #$ba
  1984                                              ;sta music_volume+1                          ; sound volume
  1985  1d45 60                                     rts
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
  2004                          
  2005                          
  2006                          
  2007                          
  2008                          
  2009                          
  2010                          
  2011                          
  2012                          
  2013                          
  2014                          
  2015                          
  2016                          
  2017                          
  2018                          
  2019                          
  2020                          ; ==============================================================================
  2021                          ; MUSIC
  2022                          ; ==============================================================================
  2023                                              !zone MUSIC

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
  2025                          ; ==============================================================================
  2026                          music_get_data:
  2027  1e04 a000               .voice1_dur_pt:     ldy #$00
  2028  1e06 d01d                                   bne +
  2029  1e08 a940                                   lda #$40
  2030  1e0a 8d6b1e                                 sta music_voice1+1
  2031  1e0d 206a1e                                 jsr music_voice1
  2032  1e10 a200               .voice1_dat_pt:     ldx #$00
  2033  1e12 bd461d                                 lda music_data_voice1,x
  2034  1e15 ee111e                                 inc .voice1_dat_pt+1
  2035  1e18 a8                                     tay
  2036  1e19 291f                                   and #$1f
  2037  1e1b 8d6b1e                                 sta music_voice1+1
  2038  1e1e 98                                     tya
  2039  1e1f 4a                                     lsr
  2040  1e20 4a                                     lsr
  2041  1e21 4a                                     lsr
  2042  1e22 4a                                     lsr
  2043  1e23 4a                                     lsr
  2044  1e24 a8                                     tay
  2045  1e25 88                 +                   dey
  2046  1e26 8c051e                                 sty .voice1_dur_pt + 1
  2047  1e29 a000               .voice2_dur_pt:     ldy #$00
  2048  1e2b d022                                   bne +
  2049  1e2d a940                                   lda #$40
  2050  1e2f 8d931e                                 sta music_voice2 + 1
  2051  1e32 20921e                                 jsr music_voice2
  2052  1e35 a200               .voice2_dat_pt:     ldx #$00
  2053  1e37 bda01d                                 lda music_data_voice2,x
  2054  1e3a a8                                     tay
  2055  1e3b e8                                     inx
  2056  1e3c e065                                   cpx #$65
  2057  1e3e f019                                   beq music_reset
  2058  1e40 8e361e                                 stx .voice2_dat_pt + 1
  2059  1e43 291f                                   and #$1f
  2060  1e45 8d931e                                 sta music_voice2 + 1
  2061  1e48 98                                     tya
  2062  1e49 4a                                     lsr
  2063  1e4a 4a                                     lsr
  2064  1e4b 4a                                     lsr
  2065  1e4c 4a                                     lsr
  2066  1e4d 4a                                     lsr
  2067  1e4e a8                                     tay
  2068  1e4f 88                 +                   dey
  2069  1e50 8c2a1e                                 sty .voice2_dur_pt + 1
  2070  1e53 206a1e                                 jsr music_voice1
  2071  1e56 4c921e                                 jmp music_voice2
  2072                          ; ==============================================================================
  2073  1e59 a900               music_reset:        lda #$00
  2074  1e5b 8d051e                                 sta .voice1_dur_pt + 1
  2075  1e5e 8d111e                                 sta .voice1_dat_pt + 1
  2076  1e61 8d2a1e                                 sta .voice2_dur_pt + 1
  2077  1e64 8d361e                                 sta .voice2_dat_pt + 1
  2078  1e67 4c041e                                 jmp music_get_data
  2079                          ; ==============================================================================
  2080                          ; write music data for voice1 / voice2 into TED registers
  2081                          ; ==============================================================================
  2082  1e6a a204               music_voice1:       ldx #$04
  2083  1e6c e01c                                   cpx #$1c
  2084  1e6e 9008                                   bcc +
  2085  1e70 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2086  1e73 29ef                                   and #$ef
  2087  1e75 4c8e1e                                 jmp writeFF11
  2088  1e78 bdba1e             +                   lda freq_tab_lo,x
  2089  1e7b 8d0eff                                 sta VOICE1_FREQ_LOW
  2090  1e7e ad12ff                                 lda VOICE1
  2091  1e81 29fc                                   and #$fc
  2092  1e83 1dd21e                                 ora freq_tab_hi, x
  2093  1e86 8d12ff                                 sta VOICE1
  2094  1e89 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2095  1e8c 0910                                   ora #$10
  2096  1e8e 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  2097  1e91 60                                     rts
  2098                          ; ==============================================================================
  2099  1e92 a20d               music_voice2:       ldx #$0d
  2100  1e94 e01c                                   cpx #$1c
  2101  1e96 9008                                   bcc +
  2102  1e98 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2103  1e9b 29df                                   and #$df
  2104  1e9d 4c8e1e                                 jmp writeFF11
  2105  1ea0 bdba1e             +                   lda freq_tab_lo,x
  2106  1ea3 8d0fff                                 sta VOICE2_FREQ_LOW
  2107  1ea6 ad10ff                                 lda VOICE2
  2108  1ea9 29fc                                   and #$fc
  2109  1eab 1dd21e                                 ora freq_tab_hi,x
  2110  1eae 8d10ff                                 sta VOICE2
  2111  1eb1 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2112  1eb4 0920                                   ora #$20
  2113  1eb6 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2114  1eb9 60                                     rts
  2115                          ; ==============================================================================
  2116                          ; TED frequency tables
  2117                          ; ==============================================================================
  2118  1eba 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  2119  1ec1 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  2120  1ec8 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  2121  1ecf 818f95                                 !byte $81, $8f, $95
  2122  1ed2 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  2123  1ed9 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  2124  1ee0 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  2125  1ee7 030303                                 !byte $03, $03, $03
  2126                          ; ==============================================================================
  2127                                              MUSIC_DELAY_INITIAL   = $09
  2128                                              MUSIC_DELAY           = $0B
  2129  1eea a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  2130  1eec ca                                     dex
  2131  1eed 8eeb1e                                 stx music_play+1
  2132  1ef0 f001                                   beq +
  2133  1ef2 60                                     rts
  2134  1ef3 a20b               +                   ldx #MUSIC_DELAY
  2135  1ef5 8eeb1e                                 stx music_play+1
  2136  1ef8 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2137  1efb 0937                                   ora #$37
  2138  1efd 29bf               music_volume:       and #$bf
  2139  1eff 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2140  1f02 4c041e                                 jmp music_get_data
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
  2157                          
  2158                          
  2159                          
  2160                          
  2161                          
  2162                          
  2163                          
  2164                          
  2165                          
  2166                          
  2167                          
  2168                          
  2169                          
  2170                          
  2171                          
  2172                          
  2173                          ; ==============================================================================
  2174                          ; irq init
  2175                          ; ==============================================================================
  2176                                              !zone IRQ
  2177  1f05 78                 irq_init0:          sei
  2178  1f06 a929                                   lda #<irq0          ; lda #$06
  2179  1f08 8d1403                                 sta $0314          ; irq lo
  2180  1f0b a91f                                   lda #>irq0          ; lda #$1f
  2181  1f0d 8d1503                                 sta $0315          ; irq hi
  2182                                                                  ; irq at $1F06
  2183  1f10 a901                                   lda #$01            ;lda #$02
  2184  1f12 8d1ad0                                 sta $d01a           ; sta FF0A          ; set IRQ source to RASTER
  2185                          
  2186  1f15 a9bf                                   lda #$bf
  2187  1f17 8dfe1e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  2188  1f1a 58                                     cli
  2189                          
  2190  1f1b 4c263a                                 jmp set_charset_and_screen
  2191                          
  2192                          ; ==============================================================================
  2193                          ; intro text
  2194                          ; wait for shift or joy2 fire press
  2195                          ; ==============================================================================
  2196                          
  2197                          check_shift_key:
  2198                          
  2199  1f1e ad00dc             -                   lda $dc00
  2200  1f21 4a                                     lsr
  2201  1f22 4a                                     lsr
  2202  1f23 4a                                     lsr
  2203  1f24 4a                                     lsr
  2204  1f25 4a                                     lsr
  2205  1f26 b0f6                                   bcs -
  2206  1f28 60                                     rts
  2207                          
  2208                          ; ==============================================================================
  2209                          ;
  2210                          ; INTERRUPT routine for music
  2211                          ; ==============================================================================
  2212                          
  2213                                              ; *= $1F06
  2214                          irq0:
  2215  1f29 ce09ff                                 DEC INTERRUPT
  2216                          
  2217                                                                  ; this IRQ seems to handle music only!
  2218                                              !if SILENT_MODE = 1 {
  2219                                                  jsr fake
  2220                                              } else {
  2221  1f2c 20ea1e                                     jsr music_play
  2222                                              }
  2223  1f2f 68                                     pla
  2224  1f30 a8                                     tay
  2225  1f31 68                                     pla
  2226  1f32 aa                                     tax
  2227  1f33 68                                     pla
  2228  1f34 40                                     rti
  2229                          
  2230                          ; ==============================================================================
  2231                          ; checks if the music volume is at the desired level
  2232                          ; and increases it if not
  2233                          ; if volume is high enough, it initializes the music irq routine
  2234                          ; is called right at the start of the game, but also when a game ended
  2235                          ; and is about to show the title screen again (increasing the volume)
  2236                          ; ==============================================================================
  2237                          
  2238                          init_music:                                  
  2239  1f35 adfe1e                                 lda music_volume+1                              ; sound volume
  2240  1f38 c9bf               --                  cmp #$bf                                        ; is true on init
  2241  1f3a d003                                   bne +
  2242  1f3c 4c051f                                 jmp irq_init0
  2243  1f3f a204               +                   ldx #$04
  2244  1f41 86a8               -                   stx zpA8                                        ; buffer serial input byte ?
  2245  1f43 a0ff                                   ldy #$ff
  2246  1f45 20ff39                                 jsr wait
  2247  1f48 a6a8                                   ldx zpA8
  2248  1f4a ca                                     dex
  2249  1f4b d0f4                                   bne -                                               
  2250  1f4d 18                                     clc
  2251  1f4e 6901                                   adc #$01                                        ; increases volume again before returning to title screen
  2252  1f50 8dfe1e                                 sta music_volume+1                              ; sound volume
  2253  1f53 4c381f                                 jmp --
  2254                          
  2255                          
  2256                          
  2257                                              ; 222222222222222         000000000          000000000          000000000
  2258                                              ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
  2259                                              ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2260                                              ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2261                                              ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2262                                              ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2263                                              ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2264                                              ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2265                                              ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2266                                              ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2267                                              ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2268                                              ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2269                                              ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2270                                              ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2271                                              ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
  2272                                              ;22222222222222222222     000000000          000000000          000000000
  2273                          
  2274                          ; ==============================================================================
  2275                          ; CHARSET
  2276                          ; $2000 - $2800
  2277                          ; ==============================================================================
  2278                          
  2279                          
  2280                          charset_start:
  2281                                              *= $2000
  2282                                              !if EXTENDED {
  2283  2000 000000020a292727...                        !bin "includes/charset-extended.bin"
  2284                                              }else{
  2285                                                  !bin "includes/charset.bin" ; !bin "includes/charset.bin"
  2286                                              }
  2287                          charset_end:    ; $2800
  2288                          
  2289                          
  2290                                              ; 222222222222222         888888888          000000000           000000000
  2291                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  2292                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  2293                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2294                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2295                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2296                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  2297                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2298                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2299                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2300                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2301                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2302                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2303                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  2304                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  2305                                              ;22222222222222222222     888888888           000000000           000000000
  2306                          
  2307                          
  2308                          
  2309                          ; ==============================================================================
  2310                          ; LEVEL DATA
  2311                          ; Based on tiles
  2312                          ;                     !IMPORTANT!
  2313                          ;                     has to be page aligned or
  2314                          ;                     display_room routine will fail
  2315                          ; ==============================================================================
  2316                          
  2317                                              *= $2800
  2318                          level_data:

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
  2320                          level_data_end:
  2321                          
  2322                          
  2323                          ;$2fbf
  2324                          speed_byte:
  2325  2fb8 01                 !byte $01
  2326                          
  2327                          
  2328                          
  2329                          
  2330                          
  2331                          ; ==============================================================================
  2332                          ;
  2333                          ;
  2334                          ; ==============================================================================
  2335                                  
  2336                          
  2337                          rasterpoll_and_other_stuff:
  2338                          
  2339  2fb9 209f35                                 jsr poll_raster
  2340  2fbc 20c039                                 jsr check_door 
  2341  2fbf 4c8014                                 jmp animation_entrypoint          
  2342                          
  2343                          
  2344                          
  2345                          ; ==============================================================================
  2346                          ;
  2347                          ; tileset definition
  2348                          ; these are the first characters in the charset of each tile.
  2349                          ; example: rocks start at $0c and span 9 characters in total
  2350                          ; ==============================================================================
  2351                          
  2352                          tileset_definition:
  2353                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  2354  2fc2 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
  2355                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2356  2fca 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
  2357                                              ;     $10
  2358  2fd2 03                                     !byte $03                                           ; door
  2359                          
  2360                          !if EXTENDED = 0{
  2361                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2362                                              !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
  2363                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2364                                              !byte $1e, $1e, $1e, $3d, $3d, $0d, $2f, $2f
  2365                                              ;     $10
  2366                                              !byte $0a
  2367                          }
  2368                          
  2369                          !if EXTENDED = 1{
  2370                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2371  2fd3 000a0a0e3d7f2a2a                       !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
  2372                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2373  2fdb 1e1e1e3d3d0d2f2f                       !byte $1e, $1e, $1e, $3d, $3d, $0d, $2f, $2f
  2374                                              ;     $10
  2375  2fe3 0a                                     !byte $0a  
  2376                          }
  2377                          
  2378                          ; ==============================================================================
  2379                          ;
  2380                          ; displays a room based on tiles
  2381                          ; ==============================================================================
  2382                          
  2383                          display_room:       
  2384  2fe4 208b3a                                 jsr draw_border
  2385  2fe7 a900                                   lda #$00
  2386  2fe9 8502                                   sta zp02
  2387  2feb a2d8                                   ldx #>COLRAM        ; HiByte of COLRAM
  2388  2fed 8605                                   stx zp05
  2389  2fef a204                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  2390  2ff1 8603                                   stx zp03
  2391  2ff3 a228                                   ldx #>level_data    ; HiByte of level_data
  2392  2ff5 860a                                   stx zp0A            ; in zp0A
  2393  2ff7 a201               current_room:       ldx #$01            ; current_room in X
  2394  2ff9 f00a                                   beq ++              ; if 0 -> skip
  2395  2ffb 18                 -                   clc                 ; else
  2396  2ffc 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  2397  2ffe 9002                                   bcc +               ; to zp09/zp0A
  2398  3000 e60a                                   inc zp0A            ;
  2399  3002 ca                 +                   dex                 ; X times
  2400  3003 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  2401  3005 8509               ++                  sta zp09            ; LoByte from above
  2402  3007 a000                                   ldy #$00
  2403  3009 84a8                                   sty zpA8
  2404  300b 84a7                                   sty zpA7
  2405  300d b109               m3066:              lda (zp09),y        ; get Tilenumber
  2406  300f aa                                     tax                 ; in X
  2407  3010 bdd32f                                 lda tiles_colors,x  ; get Tilecolor
  2408  3013 8510                                   sta zp10            ; => zp10
  2409  3015 bdc22f                                 lda tiles_chars,x   ; get Tilechar
  2410  3018 8511                                   sta zp11            ; => zp11
  2411  301a a203                                   ldx #$03            ; (3 rows)
  2412  301c a000               --                  ldy #$00
  2413  301e a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  2414  3020 8504                                   sta zp04            ; LoByte of COLRAM pointer
  2415  3022 a511                                   lda zp11            ; Load Tilechar
  2416  3024 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  2417  3026 a510                                   lda zp10            ; Load Tilecolor
  2418  3028 9104                                   sta (zp04),y        ; to COLRAM + Y
  2419  302a a511                                   lda zp11            ; Load Tilechar again
  2420  302c c9df                                   cmp #$df            ; if empty tile
  2421  302e f002                                   beq +               ; -> skip
  2422  3030 e611                                   inc zp11            ; else: Tilechar + 1
  2423  3032 c8                 +                   iny                 ; Y = Y + 1
  2424  3033 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  2425  3035 d0e7                                   bne -               ; no -> next Char
  2426  3037 a502                                   lda zp02            ; yes:
  2427  3039 18                                     clc
  2428  303a 6928                                   adc #$28            ; next SCREEN row
  2429  303c 8502                                   sta zp02
  2430  303e 9004                                   bcc +
  2431  3040 e603                                   inc zp03
  2432  3042 e605                                   inc zp05            ; and COLRAM row
  2433  3044 ca                 +                   dex                 ; X = X - 1
  2434  3045 d0d5                                   bne --              ; X != 0 -> next Char
  2435  3047 e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  2436  3049 e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  2437  304b a975                                   lda #$75            ; for m30B8 + 1
  2438  304d a6a8                                   ldx zpA8
  2439  304f e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  2440  3051 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  2441  3053 a6a7                                   ldx zpA7            ; else:
  2442  3055 e066                                   cpx #$66            ; zpA7 >= $66
  2443  3057 b01c                                   bcs display_door    ; yes: display_door
  2444  3059 a900                                   lda #$00            ; else:
  2445  305b 85a8                                   sta zpA8            ; clear zpA8
  2446  305d a924                                   lda #$24            ; for m30B8 + 1
  2447  305f 8d6630             +                   sta m30B8 + 1       ;
  2448  3062 a502                                   lda zp02
  2449  3064 38                                     sec
  2450  3065 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  2451  3067 8502                                   sta zp02
  2452  3069 b004                                   bcs +
  2453  306b c603                                   dec zp03
  2454  306d c605                                   dec zp05
  2455  306f a4a7               +                   ldy zpA7
  2456  3071 4c0d30                                 jmp m3066
  2457  3074 60                                     rts                 ; will this ever be used?
  2458                          
  2459  3075 a904               display_door:       lda #>SCREENRAM
  2460  3077 8503                                   sta zp03
  2461  3079 a9d8                                   lda #>COLRAM
  2462  307b 8505                                   sta zp05
  2463  307d a900                                   lda #$00
  2464  307f 8502                                   sta zp02
  2465  3081 8504                                   sta zp04
  2466  3083 a028               -                   ldy #$28
  2467  3085 b102                                   lda (zp02),y        ; read from SCREENRAM
  2468  3087 c906                                   cmp #$06            ; $06 (part from Door?)
  2469  3089 b00b                                   bcs +               ; >= $06 -> skip
  2470  308b 38                                     sec                 ; else:
  2471  308c e903                                   sbc #$03            ; subtract $03
  2472  308e a000                                   ldy #$00            ; set Y = $00
  2473  3090 9102                                   sta (zp02),y        ; and copy to one row above
  2474  3092 a90a                                   lda #$0a            ; lda #$39 ; color brown - luminance $3  -> color of the top of a door
  2475  3094 9104                                   sta (zp04),y
  2476  3096 a502               +                   lda zp02
  2477  3098 18                                     clc
  2478  3099 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  2479  309b 9004                                   bcc +
  2480  309d e603                                   inc zp03            ; inc pointer HiBytes if necessary
  2481  309f e605                                   inc zp05
  2482  30a1 8502               +                   sta zp02
  2483  30a3 8504                                   sta zp04
  2484  30a5 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  2485  30a7 d0da                                   bne -               ; no -> loop
  2486  30a9 a503                                   lda zp03            ; else:
  2487  30ab c907                                   cmp #>(SCREENRAM+$300)
  2488  30ad d0d4                                   bne -               ; no -> loop
  2489  30af 60                                     rts                 ; else: finally ready with room display
  2490                          
  2491                          ; ==============================================================================
  2492                          
  2493  30b0 a904               print_title:        lda #>SCREENRAM
  2494  30b2 8503                                   sta zp03
  2495  30b4 a9d8                                   lda #>COLRAM
  2496  30b6 8505                                   sta zp05
  2497  30b8 a900                                   lda #<SCREENRAM
  2498  30ba 8502                                   sta zp02
  2499  30bc 8504                                   sta zp04
  2500  30be a930                                   lda #>screen_start_src
  2501  30c0 85a8                                   sta zpA8
  2502  30c2 a9df                                   lda #<screen_start_src
  2503  30c4 85a7                                   sta zpA7
  2504  30c6 a204                                   ldx #$04
  2505  30c8 a000               --                  ldy #$00
  2506  30ca b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  2507  30cc 9102                                   sta (zp02),y        ; nach SCREEN
  2508  30ce a900                                   lda #$00           ; BLACK
  2509  30d0 9104                                   sta (zp04),y        ; nach COLRAM
  2510  30d2 c8                                     iny
  2511  30d3 d0f5                                   bne -
  2512  30d5 e603                                   inc zp03
  2513  30d7 e605                                   inc zp05
  2514  30d9 e6a8                                   inc zpA8
  2515  30db ca                                     dex
  2516  30dc d0ea                                   bne --
  2517  30de 60                                     rts
  2518                          
  2519                          ; ==============================================================================
  2520                          ; TITLE SCREEN DATA
  2521                          ;
  2522                          ; ==============================================================================
  2523                          
  2524                          screen_start_src:
  2525                          
  2526                                              !if EXTENDED {
  2527  30df 20202020202020a0...                        !bin "includes/title-extended.scr"
  2528                                              }else{
  2529                                                  !bin "includes/title.scr"
  2530                                              }
  2531                          
  2532                          screen_start_src_end:
  2533                          
  2534                          
  2535                          ; ==============================================================================
  2536                          ; i think this might be the draw routine for the player sprite
  2537                          ;
  2538                          ; ==============================================================================
  2539                          
  2540                          
  2541                          draw_player:
  2542  34c7 8eea34                                 stx m3548 + 1                       ; store x pos of player
  2543  34ca a9d8                                   lda #>COLRAM                        ; store colram high in zp05
  2544  34cc 8505                                   sta zp05
  2545  34ce a904                                   lda #>SCREENRAM                     ; store screenram high in zp03
  2546  34d0 8503                                   sta zp03
  2547  34d2 a900                                   lda #$00
  2548  34d4 8502                                   sta zp02
  2549  34d6 8504                                   sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
  2550  34d8 c000                                   cpy #$00                            ; Y is probably the player Y position
  2551  34da f00c                                   beq +                               ; Y is 0 -> +
  2552  34dc 18                 -                   clc                                 ; Y not 0
  2553  34dd 6928                                   adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
  2554  34df 9004                                   bcc ++                              ; <256? -> ++
  2555  34e1 e603                                   inc zp03
  2556  34e3 e605                                   inc zp05
  2557  34e5 88                 ++                  dey                                 ; Y = Y - 1
  2558  34e6 d0f4                                   bne -                               ; Y = 0 ? -> -
  2559  34e8 18                 +                   clc                                 ;
  2560  34e9 6916               m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
  2561  34eb 8502                                   sta zp02
  2562  34ed 8504                                   sta zp04
  2563  34ef 9004                                   bcc +
  2564  34f1 e603                                   inc zp03
  2565  34f3 e605                                   inc zp05
  2566  34f5 a203               +                   ldx #$03                            ; draw 3 rows for the player "sprite"
  2567  34f7 a900                                   lda #$00
  2568  34f9 8509                                   sta zp09
  2569  34fb a000               --                  ldy #$00
  2570  34fd a5a7               -                   lda zpA7
  2571  34ff d006                                   bne +
  2572  3501 a9df                                   lda #$df                            ; empty char, but not sure why
  2573  3503 9102                                   sta (zp02),y
  2574  3505 d01b                                   bne ++
  2575  3507 c901               +                   cmp #$01
  2576  3509 d00a                                   bne +
  2577  350b a5a8                                   lda zpA8
  2578  350d 9102                                   sta (zp02),y
  2579  350f a50a                                   lda zp0A
  2580  3511 9104                                   sta (zp04),y
  2581  3513 d00d                                   bne ++
  2582  3515 b102               +                   lda (zp02),y
  2583  3517 8610                                   stx zp10
  2584  3519 a609                                   ldx zp09
  2585  351b 9d4503                                 sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
  2586  351e e609                                   inc zp09
  2587  3520 a610                                   ldx zp10
  2588  3522 e6a8               ++                  inc zpA8
  2589  3524 c8                                     iny
  2590  3525 c003                                   cpy #$03                            ; width of the player sprite in characters (3)
  2591  3527 d0d4                                   bne -
  2592  3529 a502                                   lda zp02
  2593  352b 18                                     clc
  2594  352c 6928                                   adc #$28                            ; $28 = #40, draws one row of the player under each other
  2595  352e 8502                                   sta zp02
  2596  3530 8504                                   sta zp04
  2597  3532 9004                                   bcc +
  2598  3534 e603                                   inc zp03
  2599  3536 e605                                   inc zp05
  2600  3538 ca                 +                   dex
  2601  3539 d0c0                                   bne --
  2602  353b 60                                     rts
  2603                          
  2604                          
  2605                          ; ==============================================================================
  2606                          ; $359b
  2607                          ; JOYSTICK CONTROLS
  2608                          ; ==============================================================================
  2609                          
  2610                          check_joystick:
  2611                          
  2612                                              ;lda #$fd
  2613                                              ;sta KEYBOARD_LATCH
  2614                                              ;lda KEYBOARD_LATCH
  2615  353c ad00dc                                 lda $dc00
  2616  353f a009               player_pos_y:       ldy #$09
  2617  3541 a215               player_pos_x:       ldx #$15
  2618  3543 4a                                     lsr
  2619  3544 b005                                   bcs +
  2620  3546 c000                                   cpy #$00
  2621  3548 f001                                   beq +
  2622  354a 88                                     dey                                           ; JOYSTICK UP
  2623  354b 4a                 +                   lsr
  2624  354c b005                                   bcs +
  2625  354e c015                                   cpy #$15
  2626  3550 b001                                   bcs +
  2627  3552 c8                                     iny                                           ; JOYSTICK DOWN
  2628  3553 4a                 +                   lsr
  2629  3554 b005                                   bcs +
  2630  3556 e000                                   cpx #$00
  2631  3558 f001                                   beq +
  2632  355a ca                                     dex                                           ; JOYSTICK LEFT
  2633  355b 4a                 +                   lsr
  2634  355c b005                                   bcs +
  2635  355e e024                                   cpx #$24
  2636  3560 b001                                   bcs +
  2637  3562 e8                                     inx                                           ; JOYSTICK RIGHT
  2638  3563 8c8135             +                   sty m35E7 + 1
  2639  3566 8e8635                                 stx m35EC + 1
  2640  3569 a902                                   lda #$02
  2641  356b 85a7                                   sta zpA7
  2642  356d 20c734                                 jsr draw_player
  2643  3570 a209                                   ldx #$09
  2644  3572 bd4403             -                   lda TAPE_BUFFER + $8,x
  2645  3575 c9df                                   cmp #$df
  2646  3577 f004                                   beq +
  2647  3579 c9e2                                   cmp #$e2
  2648  357b d00d                                   bne ++
  2649  357d ca                 +                   dex
  2650  357e d0f2                                   bne -
  2651  3580 a90a               m35E7:              lda #$0a
  2652  3582 8d4035                                 sta player_pos_y + 1
  2653  3585 a915               m35EC:              lda #$15
  2654  3587 8d4235                                 sta player_pos_x + 1
  2655                          ++                  ;lda #$ff
  2656                                              ;sta KEYBOARD_LATCH
  2657  358a a901                                   lda #$01
  2658  358c 85a7                                   sta zpA7
  2659  358e a993                                   lda #$93                ; first character of the player graphic
  2660  3590 85a8                                   sta zpA8
  2661  3592 a93d                                   lda #$3d
  2662  3594 850a                                   sta zp0A
  2663  3596 ac4035             get_player_pos:     ldy player_pos_y + 1
  2664  3599 ae4235                                 ldx player_pos_x + 1
  2665                                        
  2666  359c 4cc734                                 jmp draw_player
  2667                          
  2668                          ; ==============================================================================
  2669                          ;
  2670                          ; POLL RASTER
  2671                          ; ==============================================================================
  2672                          
  2673                          poll_raster:
  2674  359f 78                                     sei                     ; disable interrupt
  2675  35a0 a9f0                                   lda #$f0                ; lda #$c0  ;A = $c0
  2676  35a2 cd12d0             -                   cmp FF1D                ; vertical line bits 0-7
  2677                                              
  2678  35a5 d0fb                                   bne -                   ; loop until we hit line c0
  2679  35a7 a900                                   lda #$00                ; A = 0
  2680  35a9 85a7                                   sta zpA7                ; zpA7 = 0
  2681                                              
  2682  35ab 209635                                 jsr get_player_pos
  2683                                              
  2684  35ae 203c35                                 jsr check_joystick
  2685  35b1 58                                     cli
  2686  35b2 60                                     rts
  2687                          
  2688                          
  2689                          ; ==============================================================================
  2690                          ; ROOM 16
  2691                          ; BELEGRO ANIMATION
  2692                          ; ==============================================================================
  2693                          
  2694                          belegro_animation:
  2695                          
  2696  35b3 a900                                   lda #$00
  2697  35b5 85a7                                   sta zpA7
  2698  35b7 a20f               m3624:              ldx #$0f
  2699  35b9 a00f               m3626:              ldy #$0f
  2700  35bb 20c734                                 jsr draw_player
  2701  35be aeb835                                 ldx m3624 + 1
  2702  35c1 acba35                                 ldy m3626 + 1
  2703  35c4 ec4235                                 cpx player_pos_x + 1
  2704  35c7 b002                                   bcs +
  2705  35c9 e8                                     inx
  2706  35ca e8                                     inx
  2707  35cb ec4235             +                   cpx player_pos_x + 1
  2708  35ce f001                                   beq +
  2709  35d0 ca                                     dex
  2710  35d1 cc4035             +                   cpy player_pos_y + 1
  2711  35d4 b002                                   bcs +
  2712  35d6 c8                                     iny
  2713  35d7 c8                                     iny
  2714  35d8 cc4035             +                   cpy player_pos_y + 1
  2715  35db f001                                   beq +
  2716  35dd 88                                     dey
  2717  35de 8ef835             +                   stx m3668 + 1
  2718  35e1 8cfd35                                 sty m366D + 1
  2719  35e4 a902                                   lda #$02
  2720  35e6 85a7                                   sta zpA7
  2721  35e8 20c734                                 jsr draw_player
  2722  35eb a209                                   ldx #$09
  2723  35ed bd4403             -                   lda TAPE_BUFFER + $8,x
  2724  35f0 c992                                   cmp #$92
  2725  35f2 900d                                   bcc +
  2726  35f4 ca                                     dex
  2727  35f5 d0f6                                   bne -
  2728  35f7 a210               m3668:              ldx #$10
  2729  35f9 8eb835                                 stx m3624 + 1
  2730  35fc a00e               m366D:              ldy #$0e
  2731  35fe 8cba35                                 sty m3626 + 1
  2732  3601 a99c               +                   lda #$9c                                ; belegro chars
  2733  3603 85a8                                   sta zpA8
  2734  3605 a93e                                   lda #$3e
  2735  3607 850a                                   sta zp0A
  2736  3609 acba35                                 ldy m3626 + 1
  2737  360c aeb835                                 ldx m3624 + 1                    
  2738  360f a901                                   lda #$01
  2739  3611 85a7                                   sta zpA7
  2740  3613 4cc734                                 jmp draw_player
  2741                          
  2742                          
  2743                          ; ==============================================================================
  2744                          ; items
  2745                          ; This area seems to be responsible for items placement
  2746                          ;
  2747                          ; ==============================================================================
  2748                          
  2749                          items:

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
  2751                          items_end:
  2752                          
  2753                          next_item:
  2754  37c6 a5a7                                   lda zpA7
  2755  37c8 18                                     clc
  2756  37c9 6901                                   adc #$01
  2757  37cb 85a7                                   sta zpA7
  2758  37cd 9002                                   bcc +                       ; bcc $3845
  2759  37cf e6a8                                   inc zpA8
  2760  37d1 60                 +                   rts
  2761                          
  2762                          ; ==============================================================================
  2763                          ; TODO
  2764                          ; no clue yet. level data has already been drawn when this is called
  2765                          ; probably placing the items on the screen
  2766                          ; ==============================================================================
  2767                          
  2768                          update_items_display:
  2769  37d2 a936                                   lda #>items                 ; load address for items into zeropage
  2770  37d4 85a8                                   sta zpA8
  2771  37d6 a916                                   lda #<items
  2772  37d8 85a7                                   sta zpA7
  2773  37da a000                                   ldy #$00                    ; y = 0
  2774  37dc b1a7               --                  lda (zpA7),y                ; load first value
  2775  37de c9ff                                   cmp #$ff                    ; is it $ff?
  2776  37e0 f006                                   beq +                       ; yes -> +
  2777  37e2 20c637             -                   jsr next_item               ; no -> set zero page to next value
  2778  37e5 4cdc37                                 jmp --                      ; and loop
  2779  37e8 20c637             +                   jsr next_item               ; value was $ff, now get the next value in the list
  2780  37eb b1a7                                   lda (zpA7),y
  2781  37ed c9ff                                   cmp #$ff                    ; is the next value $ff again?
  2782  37ef d003                                   bne +
  2783  37f1 4c7638                                 jmp prepare_rooms           ; yes -> m38DF
  2784  37f4 cdf82f             +                   cmp current_room + 1        ; is the number the current room number?
  2785  37f7 d0e9                                   bne -                       ; no -> loop
  2786  37f9 a9d8                                   lda #>COLRAM                ; yes the number is the current room number
  2787  37fb 8505                                   sta zp05                    ; store COLRAM and SCREENRAM in zeropage
  2788  37fd a904                                   lda #>SCREENRAM
  2789  37ff 8503                                   sta zp03
  2790  3801 a900                                   lda #$00                    ; A = 0
  2791  3803 8502                                   sta zp02                    ; zp02 = 0, zp04 = 0
  2792  3805 8504                                   sta zp04
  2793  3807 20c637                                 jsr next_item               ; move to next value
  2794  380a b1a7                                   lda (zpA7),y                ; get next value in the list
  2795  380c c9fe               -                   cmp #$fe                    ; is it $FE?
  2796  380e f00b                                   beq +                       ; yes -> +
  2797  3810 c9f9                                   cmp #$f9                    ; no, is it $f9?
  2798  3812 d00d                                   bne +++                     ; no -> +++
  2799  3814 a502                                   lda zp02                    ; value is $f9
  2800  3816 206e38                                 jsr m38D7                   ; add 1 to zp02 and zp04
  2801  3819 9004                                   bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
  2802  381b e603               +                   inc zp03                    ; value is $fe
  2803  381d e605                                   inc zp05                    ; increase zp03 and zp05
  2804  381f b1a7               ++                  lda (zpA7),y                ; get value from list
  2805  3821 c9fb               +++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
  2806  3823 d009                                   bne +                       ; no -> +
  2807  3825 20c637                                 jsr next_item               ; yes it's $fb, get the next value
  2808  3828 b1a7                                   lda (zpA7),y                ; get value from list
  2809  382a 8509                                   sta zp09                    ; store value in zp09
  2810  382c d028                                   bne ++                      ; if value was 0 -> ++
  2811  382e c9f8               +                   cmp #$f8
  2812  3830 f01c                                   beq +
  2813  3832 c9fc                                   cmp #$fc
  2814  3834 d00d                                   bne +++
  2815  3836 a50a                                   lda zp0A
  2816                                                                          ; jmp m399F
  2817                          
  2818  3838 c9df                                   cmp #$df                    ; this part was moved here as it wasn't called anywhere else
  2819  383a f002                                   beq skip                    ; and I think it was just outsourced for branching length issues
  2820  383c e60a                                   inc zp0A           
  2821  383e b1a7               skip:               lda (zpA7),y        
  2822  3840 4c4e38                                 jmp m38B7
  2823                          
  2824  3843 c9fa               +++                 cmp #$fa
  2825  3845 d00f                                   bne ++
  2826  3847 20c637                                 jsr next_item
  2827  384a b1a7                                   lda (zpA7),y
  2828  384c 850a                                   sta zp0A
  2829                          m38B7:
  2830  384e a509               +                   lda zp09
  2831  3850 9104                                   sta (zp04),y
  2832  3852 a50a                                   lda zp0A
  2833  3854 9102                                   sta (zp02),y
  2834  3856 c9fd               ++                  cmp #$fd
  2835  3858 d009                                   bne +
  2836  385a 20c637                                 jsr next_item
  2837  385d b1a7                                   lda (zpA7),y
  2838  385f 8502                                   sta zp02
  2839  3861 8504                                   sta zp04
  2840  3863 20c637             +                   jsr next_item
  2841  3866 b1a7                                   lda (zpA7),y
  2842  3868 c9ff                                   cmp #$ff
  2843  386a d0a0                                   bne -
  2844  386c f008                                   beq prepare_rooms
  2845  386e 18                 m38D7:              clc
  2846  386f 6901                                   adc #$01
  2847  3871 8502                                   sta zp02
  2848  3873 8504                                   sta zp04
  2849  3875 60                                     rts
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
  2862                          
  2863                          
  2864                          
  2865                          
  2866                          
  2867                          
  2868                          
  2869                          
  2870                          
  2871                          
  2872                          
  2873                          
  2874                          
  2875                          
  2876                          
  2877                          
  2878                          ; ==============================================================================
  2879                          ; ROOM PREPARATION CHECK
  2880                          ; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
  2881                          ; ==============================================================================
  2882                          
  2883                          prepare_rooms:
  2884                                      
  2885  3876 adf82f                                 lda current_room + 1
  2886                                              
  2887  3879 c902                                   cmp #$02                                ; is the current room 02?
  2888  387b f01d                                   beq room_02_prep
  2889                          
  2890  387d c907                                   cmp #$07
  2891  387f f04c                                   beq room_07_make_sacred_column
  2892                                              
  2893  3881 c906                                   cmp #$06          
  2894  3883 f05a                                   beq room_06_make_deadly_doors
  2895                          
  2896  3885 c904                                   cmp #$04
  2897  3887 f062                                   beq room_04_prep
  2898                          
  2899  3889 c905                                   cmp #$05
  2900  388b f001                                   beq room_05_prep
  2901                          
  2902  388d 60                                     rts
  2903                          
  2904                          
  2905                          
  2906                          ; ==============================================================================
  2907                          ; ROOM 05
  2908                          ; HIDE THE BREATHING TUBE UNDER THE STONE
  2909                          ; ==============================================================================
  2910                          
  2911                          room_05_prep:                  
  2912                                                         
  2913  388e a9fd                                   lda #$fd                                    ; yes
  2914  3890 a201               breathing_tube_mod: ldx #$01
  2915  3892 d002                                   bne +                                       ; based on self mod, put the normal
  2916  3894 a97a                                   lda #$7a                                    ; stone char back again
  2917  3896 8dd206             +                   sta SCREENRAM + $2d2   
  2918  3899 60                                     rts
  2919                          
  2920                          
  2921                          
  2922                          ; ==============================================================================
  2923                          ; ROOM 02 PREP
  2924                          ; 
  2925                          ; ==============================================================================
  2926                          
  2927                          room_02_prep:
  2928  389a a90d                                   lda #$0d                                ; yes room is 02, a = $0d #13
  2929  389c 8502                                   sta zp02                                ; zp02 = $0d
  2930  389e 8504                                   sta zp04                                ; zp04 = $0d
  2931  38a0 a9d8                                   lda #>COLRAM                            ; set colram zp
  2932  38a2 8505                                   sta zp05
  2933  38a4 a904                                   lda #>SCREENRAM                         ; set screenram zp      
  2934  38a6 8503                                   sta zp03
  2935  38a8 a218                                   ldx #$18                                ; x = $18 #24
  2936  38aa b102               -                   lda (zp02),y                            ; y must have been set earlier
  2937  38ac c9df                                   cmp #$df                                ; $df = empty space likely
  2938  38ae f004                                   beq delete_fence                        ; yes, empty -> m3900
  2939  38b0 c9f5                                   cmp #$f5                                ; no, but maybe a $f5? (fence!)
  2940  38b2 d006                                   bne +                                   ; nope -> ++
  2941                          
  2942                          delete_fence:
  2943  38b4 a9f5                                   lda #$f5                                ; A is either $df or $f5 -> selfmod here
  2944  38b6 9102                                   sta (zp02),y                            ; store that value
  2945  38b8 9104                                   sta (zp04),y                            ; in zp02 and zo04
  2946  38ba a502               +                   lda zp02                                ; and load it in again, jeez
  2947  38bc 18                                     clc
  2948  38bd 6928                                   adc #$28                                ; smells like we're going to draw a fence
  2949  38bf 8502                                   sta zp02
  2950  38c1 8504                                   sta zp04
  2951  38c3 9004                                   bcc +             
  2952  38c5 e603                                   inc zp03
  2953  38c7 e605                                   inc zp05
  2954  38c9 ca                 +                   dex
  2955  38ca d0de                                   bne -              
  2956  38cc 60                                     rts
  2957                          
  2958                          ; ==============================================================================
  2959                          ; ROOM 07 PREP
  2960                          ;
  2961                          ; ==============================================================================
  2962                          
  2963                          room_07_make_sacred_column:
  2964                          
  2965                                              
  2966  38cd a217                                   ldx #$17                                    ; yes
  2967  38cf bd6805             -                   lda SCREENRAM + $168,x     
  2968  38d2 c9df                                   cmp #$df
  2969  38d4 d005                                   bne +                       
  2970  38d6 a9e3                                   lda #$e3
  2971  38d8 9d6805                                 sta SCREENRAM + $168,x    
  2972  38db ca                 +                   dex
  2973  38dc d0f1                                   bne -                      
  2974  38de 60                                     rts
  2975                          
  2976                          
  2977                          ; ==============================================================================
  2978                          ; ROOM 06
  2979                          ; PREPARE THE DEADLY DOORS
  2980                          ; ==============================================================================
  2981                          
  2982                          room_06_make_deadly_doors:
  2983                          
  2984                                              
  2985  38df a9f6                                   lda #$f6                                    ; char for wrong door
  2986  38e1 8d9c04                                 sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
  2987  38e4 8d7c06                                 sta SCREENRAM + $27c
  2988  38e7 8d6c07                                 sta SCREENRAM + $36c       
  2989  38ea 60                                     rts
  2990                          
  2991                          ; ==============================================================================
  2992                          ; ROOM 04
  2993                          ; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
  2994                          ; ==============================================================================
  2995                          
  2996                          room_04_prep: 
  2997                          
  2998                          
  2999                                              
  3000  38eb adf82f                                 lda current_room + 1                            ; get current room
  3001  38ee c904                                   cmp #04                                         ; is it 4? (coffins)
  3002  38f0 d00c                                   bne ++                                          ; nope
  3003  38f2 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  3004  38f4 ac0339                                 ldy m394A + 1                                   ; 
  3005  38f7 f002                                   beq +
  3006  38f9 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  3007  38fb 8df904             +                   sta SCREENRAM + $f9 
  3008                                          
  3009  38fe a2f7               ++                  ldx #$f7                                    ; yes room 04
  3010  3900 a0f8                                   ldy #$f8
  3011  3902 a901               m394A:              lda #$01
  3012  3904 d004                                   bne m3952           
  3013  3906 a23b                                   ldx #$3b
  3014  3908 a042                                   ldy #$42
  3015  390a a901               m3952:              lda #$01                                    ; some self mod here
  3016  390c c901                                   cmp #$01
  3017  390e d003                                   bne +           
  3018  3910 8e7a04                                 stx SCREENRAM+ $7a 
  3019  3913 c902               +                   cmp #$02
  3020  3915 d003                                   bne +           
  3021  3917 8e6a05                                 stx SCREENRAM + $16a   
  3022  391a c903               +                   cmp #$03
  3023  391c d003                                   bne +           
  3024  391e 8e5a06                                 stx SCREENRAM + $25a       
  3025  3921 c904               +                   cmp #$04
  3026  3923 d003                                   bne +           
  3027  3925 8e4a07                                 stx SCREENRAM + $34a   
  3028  3928 c905               +                   cmp #$05
  3029  392a d003                                   bne +           
  3030  392c 8c9c04                                 sty SCREENRAM + $9c    
  3031  392f c906               +                   cmp #$06
  3032  3931 d003                                   bne +           
  3033  3933 8c8c05                                 sty SCREENRAM + $18c   
  3034  3936 c907               +                   cmp #$07
  3035  3938 d003                                   bne +           
  3036  393a 8c7c06                                 sty SCREENRAM + $27c 
  3037  393d c908               +                   cmp #$08
  3038  393f d003                                   bne +           
  3039  3941 8c6c07                                 sty SCREENRAM + $36c   
  3040  3944 60                 +                   rts
  3041                          
  3042                          
  3043                          
  3044                          
  3045                          
  3046                          
  3047                          
  3048                          
  3049                          
  3050                          
  3051                          
  3052                          
  3053                          
  3054                          
  3055                          
  3056                          
  3057                          
  3058                          
  3059                          
  3060                          
  3061                          ; ==============================================================================
  3062                          ; PLAYER POSITION TABLE FOR EACH ROOM
  3063                          ; FORMAT: Y left door, X left door, Y right door, X right door
  3064                          ; ==============================================================================
  3065                          
  3066                          player_xy_pos_table:
  3067                          
  3068  3945 06031221           !byte $06, $03, $12, $21                                        ; room 00
  3069  3949 03031221           !byte $03, $03, $12, $21                                        ; room 01
  3070  394d 03031521           !byte $03, $03, $15, $21                                        ; room 02
  3071  3951 03030f21           !byte $03, $03, $0f, $21                                        ; room 03
  3072  3955 151e0606           !byte $15, $1e, $06, $06                                        ; room 04
  3073  3959 06031221           !byte $06, $03, $12, $21                                        ; room 05
  3074  395d 03030921           !byte $03, $03, $09, $21                                        ; room 06
  3075  3961 03031221           !byte $03, $03, $12, $21                                        ; room 07
  3076  3965 03030c21           !byte $03, $03, $0c, $21                                        ; room 08
  3077  3969 03031221           !byte $03, $03, $12, $21                                        ; room 09
  3078  396d 0c030c20           !byte $0c, $03, $0c, $20                                        ; room 10
  3079  3971 0c030c21           !byte $0c, $03, $0c, $21                                        ; room 11
  3080  3975 0c030915           !byte $0c, $03, $09, $15                                        ; room 12
  3081  3979 03030621           !byte $03, $03, $06, $21                                        ; room 13
  3082  397d 03030321           !byte $03, $03, $03, $21                                        ; room 14
  3083  3981 06031221           !byte $06, $03, $12, $21                                        ; room 15
  3084  3985 0303031d           !byte $03, $03, $03, $1d                                        ; room 16
  3085  3989 03030621           !byte $03, $03, $06, $21                                        ; room 17
  3086  398d 0303               !byte $03, $03                                                  ; room 18 (only one door)
  3087                          
  3088                          
  3089                          
  3090                          ; ==============================================================================
  3091                          ; $3a33
  3092                          ; Apparently some lookup table, e.g. to get the 
  3093                          ; ==============================================================================
  3094                          
  3095                          room_player_pos_lookup:
  3096                          
  3097  398f 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  3098  399f 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  3099  39af 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  3100  39bf 00                 !byte $00
  3101                          
  3102                          
  3103                          
  3104                          
  3105                          
  3106                          
  3107                          
  3108                          
  3109                          
  3110                          
  3111                          
  3112                          ; ==============================================================================
  3113                          ;
  3114                          ;
  3115                          ; ==============================================================================
  3116                          
  3117                          check_door:
  3118                          
  3119  39c0 a209                                   ldx #$09                                    ; set loop to 9
  3120  39c2 bd4403             -                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
  3121  39c5 c905                                   cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
  3122  39c7 f008                                   beq +                                       ; yes -> +
  3123  39c9 c903                                   cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
  3124  39cb f013                                   beq set_player_xy                           ; yes -> m3A17
  3125  39cd ca                                     dex                                         ; decrease loop
  3126  39ce d0f2                                   bne -                                       ; loop
  3127  39d0 60                 -                   rts
  3128                          
  3129  39d1 aef82f             +                   ldx current_room + 1
  3130  39d4 f0fa                                   beq -               
  3131  39d6 ca                                     dex
  3132  39d7 8ef82f                                 stx current_room + 1                        ; update room number                         
  3133  39da bc8f39                                 ldy room_player_pos_lookup,x                ; load        
  3134  39dd 4cea39                                 jmp update_player_pos           
  3135                          
  3136                          set_player_xy:
  3137  39e0 aef82f                                 ldx current_room + 1                            ; x = room number
  3138  39e3 e8                                     inx                                             ; room number ++
  3139  39e4 8ef82f                                 stx current_room + 1                            ; update room number
  3140  39e7 bca639                                 ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room
  3141                          
  3142                          update_player_pos:              
  3143  39ea b94539                                 lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
  3144  39ed 8d4035                                 sta player_pos_y + 1                            ; player y pos = a
  3145  39f0 b94639                                 lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
  3146  39f3 8d4235                                 sta player_pos_x + 1
  3147                          
  3148  39f6 20e42f             m3A2D:              jsr display_room                                ; done  
  3149  39f9 209115                                 jsr room_04_prep_door                           ; was in main loop before, might find a better place
  3150  39fc 4cd237                                 jmp update_items_display
  3151                          
  3152                          
  3153                          
  3154                          ; ==============================================================================
  3155                          ;
  3156                          ; wait routine
  3157                          ; usually called with Y set before
  3158                          ; ==============================================================================
  3159                          
  3160                          wait:
  3161  39ff ca                                     dex
  3162  3a00 d0fd                                   bne wait
  3163  3a02 88                                     dey
  3164  3a03 d0fa                                   bne wait
  3165  3a05 60                 fake:               rts
  3166                          
  3167                          
  3168                          ; ==============================================================================
  3169                          ; sets the game screen
  3170                          ; multicolor, charset, main colors
  3171                          ; ==============================================================================
  3172                          
  3173                          set_game_basics:
  3174  3a06 ad12ff                                 lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  3175  3a09 29fb                                   and #$fb                                    ; clear bit 2
  3176  3a0b 8d12ff                                 sta VOICE1                                  ; => get data from RAM
  3177  3a0e a918                                   lda #$18            ;lda #$21
  3178  3a10 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
  3179                                              
  3180                                                                                          ; bit 1 : Single clock set  ( 0 )
  3181                                                                                          ; b.2-7 : character data base address
  3182                                                                                          ; %00100$x ($2000)
  3183  3a13 ad16d0                                 lda FF07
  3184  3a16 0990                                   ora #$90                                    ; multicolor ON - reverse OFF
  3185  3a18 8d16d0                                 sta FF07
  3186                          
  3187                                                                                          ; set the main colors for the game
  3188                          
  3189  3a1b a90a                                   lda #MULTICOLOR_1                           ; original: #$db
  3190  3a1d 8d22d0                                 sta COLOR_1                                 ; char color 1
  3191  3a20 a909                                   lda #MULTICOLOR_2                           ; original: #$29
  3192  3a22 8d23d0                                 sta COLOR_2                                 ; char color 2
  3193                                              
  3194  3a25 60                                     rts
  3195                          
  3196                          ; ==============================================================================
  3197                          ; set font and screen setup (40 columns and hires)
  3198                          ; $3a9d
  3199                          ; ==============================================================================
  3200                          
  3201                          set_charset_and_screen:                               ; set text screen
  3202                                             
  3203  3a26 ad12ff                                 lda VOICE1
  3204  3a29 0904                                   ora #$04                                    ; set bit 2
  3205  3a2b 8d12ff                                 sta VOICE1                                  ; => get data from ROM
  3206  3a2e a917                                   lda #$17                                    ; lda #$d5                                    ; ROM FONT
  3207  3a30 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; set
  3208  3a33 ad16d0                                 lda FF07
  3209  3a36 a908                                   lda #$08                                    ; 40 columns and Multicolor OFF
  3210  3a38 8d16d0                                 sta FF07
  3211  3a3b 60                                     rts
  3212                          
  3213                          test:
  3214  3a3c ee20d0                                 inc BORDER_COLOR
  3215  3a3f 4c3c3a                                 jmp test
  3216                          
  3217                          ; ==============================================================================
  3218                          ; init
  3219                          ; start of game (original $3ab3)
  3220                          ; ==============================================================================
  3221                          
  3222                          code_start:
  3223                          init:
  3224                                              ;jsr init_music           ; TODO
  3225                                              
  3226  3a42 a917                                   lda #$17                  ; set lower case charset
  3227  3a44 8d18d0                                 sta $d018                 ; wasn't on Plus/4 for some reason
  3228                                              
  3229  3a47 a90b                                   lda #$0b
  3230  3a49 8d21d0                                 sta BG_COLOR              ; background color
  3231  3a4c 8d20d0                                 sta BORDER_COLOR          ; border color
  3232  3a4f 20bb16                                 jsr reset_items           ; might be a level data reset, and print the title screen
  3233                          
  3234  3a52 a020                                   ldy #$20
  3235  3a54 20ff39                                 jsr wait
  3236                                              
  3237                                              ; waiting for key press on title screen
  3238                          
  3239  3a57 a5cb               -                   lda $cb                   ; zp position of currently pressed key
  3240  3a59 c93c                                   cmp #$3c                  ; is it the space key?
  3241  3a5b d0fa                                   bne -
  3242                          
  3243                                                                        ; lda #$ff
  3244  3a5d 203c1d                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  3245                                              
  3246                          
  3247                                              ; TODO: unclear what the code below does
  3248                                              ; i think it fills the level data with "DF", which is a blank character
  3249  3a60 a904                                   lda #>SCREENRAM
  3250  3a62 8503                                   sta zp03
  3251  3a64 a900                                   lda #$00
  3252  3a66 8502                                   sta zp02
  3253  3a68 a204                                   ldx #$04
  3254  3a6a a000                                   ldy #$00
  3255  3a6c a9df                                   lda #$df
  3256  3a6e 9102               -                   sta (zp02),y
  3257  3a70 c8                                     iny
  3258  3a71 d0fb                                   bne -
  3259  3a73 e603                                   inc zp03
  3260  3a75 ca                                     dex
  3261  3a76 d0f6                                   bne -
  3262                                              
  3263  3a78 20063a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  3264                          
  3265                                              ; set background color
  3266  3a7b a900                                   lda #$00
  3267  3a7d 8d21d0                                 sta BG_COLOR
  3268                          
  3269                                              ; border color. default is a dark red
  3270  3a80 a902                                   lda #BORDER_COLOR_VALUE
  3271  3a82 8d20d0                                 sta BORDER_COLOR
  3272                                              
  3273  3a85 208b3a                                 jsr draw_border
  3274                                              
  3275  3a88 4cc33a                                 jmp set_start_screen
  3276                          
  3277                          ; ==============================================================================
  3278                          ;
  3279                          ; draws the extended "border"
  3280                          ; ==============================================================================
  3281                          
  3282                          draw_border:        
  3283  3a8b a927                                   lda #$27
  3284  3a8d 8502                                   sta zp02
  3285  3a8f 8504                                   sta zp04
  3286  3a91 a9d8                                   lda #>COLRAM
  3287  3a93 8505                                   sta zp05
  3288  3a95 a904                                   lda #>SCREENRAM
  3289  3a97 8503                                   sta zp03
  3290  3a99 a218                                   ldx #$18
  3291  3a9b a000                                   ldy #$00
  3292  3a9d a95d               -                   lda #$5d
  3293  3a9f 9102                                   sta (zp02),y
  3294  3aa1 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3295  3aa3 9104                                   sta (zp04),y
  3296  3aa5 98                                     tya
  3297  3aa6 18                                     clc
  3298  3aa7 6928                                   adc #$28
  3299  3aa9 a8                                     tay
  3300  3aaa 9004                                   bcc +
  3301  3aac e603                                   inc zp03
  3302  3aae e605                                   inc zp05
  3303  3ab0 ca                 +                   dex
  3304  3ab1 d0ea                                   bne -
  3305  3ab3 a95d               -                   lda #$5d
  3306  3ab5 9dc007                                 sta SCREENRAM + $3c0,x
  3307  3ab8 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3308  3aba 9dc0db                                 sta COLRAM + $3c0,x
  3309  3abd e8                                     inx
  3310  3abe e028                                   cpx #$28
  3311  3ac0 d0f1                                   bne -
  3312  3ac2 60                                     rts
  3313                          
  3314                          ; ==============================================================================
  3315                          ; SETUP FIRST ROOM
  3316                          ; player xy position and room number
  3317                          ; ==============================================================================
  3318                          
  3319                          set_start_screen:
  3320  3ac3 a906                                   lda #PLAYER_START_POS_Y
  3321  3ac5 8d4035                                 sta player_pos_y + 1                    ; Y player start position (0 = top)
  3322  3ac8 a903                                   lda #PLAYER_START_POS_X
  3323  3aca 8d4235                                 sta player_pos_x + 1                    ; X player start position (0 = left)
  3324  3acd a912                                   lda #START_ROOM                         ; room number (start screen) ($3b45)
  3325  3acf 8df82f                                 sta current_room + 1
  3326  3ad2 20f639                                 jsr m3A2D
  3327                                              
  3328                          
  3329                          main_loop:
  3330                                              
  3331  3ad5 20b92f                                 jsr rasterpoll_and_other_stuff
  3332  3ad8 a01b                                   ldy #$1b                                ; ldy #$30    ; wait a bit -> in each frame! slows down movement
  3333  3ada 20ff39                                 jsr wait
  3334                                                                                      ;jsr room_04_prep_door
  3335  3add 202e16                                 jsr prep_player_pos
  3336  3ae0 4c4716                                 jmp object_collision
  3337                          
  3338                          ; ==============================================================================
  3339                          ;
  3340                          ; Display the death message
  3341                          ; End of game and return to start screen
  3342                          ; ==============================================================================
  3343                          
  3344                          death:
  3345                                             
  3346  3ae3 a93b                                   lda #>death_messages
  3347  3ae5 85a8                                   sta zpA8
  3348  3ae7 a962                                   lda #<death_messages
  3349  3ae9 85a7                                   sta zpA7
  3350  3aeb c000                                   cpy #$00
  3351  3aed f00c                                   beq ++
  3352  3aef 18                 -                   clc
  3353  3af0 6932                                   adc #$32
  3354  3af2 85a7                                   sta zpA7
  3355  3af4 9002                                   bcc +
  3356  3af6 e6a8                                   inc zpA8
  3357  3af8 88                 +                   dey
  3358  3af9 d0f4                                   bne -
  3359  3afb a90c               ++                  lda #$0c
  3360  3afd 8503                                   sta zp03
  3361  3aff 8402                                   sty zp02
  3362  3b01 a204                                   ldx #$04
  3363  3b03 a920                                   lda #$20
  3364  3b05 9102               -                   sta (zp02),y
  3365  3b07 c8                                     iny
  3366  3b08 d0fb                                   bne -
  3367  3b0a e603                                   inc zp03
  3368  3b0c ca                                     dex
  3369  3b0d d0f6                                   bne -
  3370  3b0f 20263a                                 jsr set_charset_and_screen
  3371  3b12 20423b                                 jsr clear
  3372  3b15 b1a7               -                   lda (zpA7),y
  3373  3b17 9dc005                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  3374  3b1a a900                                   lda #$00                                    ; color of the death message
  3375  3b1c 9dc0d9                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  3376  3b1f e8                                     inx
  3377  3b20 c8                                     iny
  3378  3b21 e019                                   cpx #$19
  3379  3b23 d002                                   bne +
  3380  3b25 a250                                   ldx #$50
  3381  3b27 c032               +                   cpy #$32
  3382  3b29 d0ea                                   bne -
  3383  3b2b a903                                   lda #$03
  3384  3b2d 8d21d0                                 sta BG_COLOR
  3385  3b30 8d20d0                                 sta BORDER_COLOR
  3386                                             
  3387                          m3EF9:
  3388  3b33 a908                                   lda #$08
  3389  3b35 a0ff               -                   ldy #$ff
  3390  3b37 20ff39                                 jsr wait
  3391  3b3a 38                                     sec
  3392  3b3b e901                                   sbc #$01
  3393  3b3d d0f6                                   bne -
  3394                                              
  3395  3b3f 4c423a                                 jmp init
  3396                          
  3397                          ; ==============================================================================
  3398                          ;
  3399                          ; clear the sceen (replacing kernal call on plus/4)
  3400                          ; 
  3401                          ; ==============================================================================
  3402                          
  3403  3b42 a920               clear               lda #$20                    ; #$20 is the spacebar Screen Code
  3404  3b44 9d0004                                 sta $0400,x                 ; fill four areas with 256 spacebar characters
  3405  3b47 9d0005                                 sta $0500,x 
  3406  3b4a 9d0006                                 sta $0600,x 
  3407  3b4d 9de806                                 sta $06e8,x 
  3408  3b50 a900                                   lda #$00                    ; set foreground to black in Color Ram 
  3409  3b52 9d00d8                                 sta $d800,x  
  3410  3b55 9d00d9                                 sta $d900,x
  3411  3b58 9d00da                                 sta $da00,x
  3412  3b5b 9de8da                                 sta $dae8,x
  3413  3b5e e8                                     inx                         ; increment X
  3414  3b5f d0e1                                   bne clear                   ; did X turn to zero yet?
  3415                                                                          ; if not, continue with the loop
  3416  3b61 60                                     rts                         ; return from this subroutine
  3417                          ; ==============================================================================
  3418                          ;
  3419                          ; DEATH MESSAGES
  3420                          ; ==============================================================================
  3421                          
  3422                          death_messages:
  3423                          
  3424                          ; death messages
  3425                          ; like "You fell into a snake pit"
  3426                          
  3427                          ; scr conversion
  3428                          
  3429                          ; 00 You fell into a snake pit
  3430                          ; 01 You'd better watched out for the sacred column
  3431                          ; 02 You drowned in the deep river
  3432                          ; 03 You drank from the poisend bottle
  3433                          ; 04 Boris the spider got you and killed you
  3434                          ; 05 Didn't you see the laser beam?
  3435                          ; 06 240 Volts! You got an electrical shock!
  3436                          ; 07 You stepped on a nail!
  3437                          ; 08 A foot trap stopped you!
  3438                          ; 09 This room is doomed by the wizard Manilo!
  3439                          ; 0a You were locked in and starved!
  3440                          ; 0b You were hit by a big rock and died!
  3441                          ; 0c Belegro killed you!
  3442                          ; 0d You found a thirsty zombie....
  3443                          ; 0e The monster grabbed you you. You are dead!
  3444                          ; 0f You were wounded by the bush!
  3445                          ; 10 You are trapped in wire-nettings!
  3446                          
  3447                          !if LANGUAGE = EN{
  3448                          !scr "You fell into a          snake pit !              "
  3449                          !scr "You'd better watched out for the sacred column!   "
  3450                          !scr "You drowned in the deep  river !                  "
  3451                          !scr "You drank from the       poisoned bottle ........ "
  3452                          !scr "Boris, the spider, got   you and killed you !     "
  3453                          !scr "Didn't you see the       laser beam ?!?           "
  3454                          !scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  3455                          !scr "You stepped on a nail !                           "
  3456                          !scr "A foot trap stopped you !                         "
  3457                          !scr "This room is doomed      by the wizard Manilo !   "
  3458                          !scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  3459                          !scr "You were hit by a big    rock and died !          "
  3460                          !scr "Belegro killed           you !                    "
  3461                          !scr "You found a thirsty      zombie .......           "
  3462                          !scr "The monster grabbed       you. You are dead !     "
  3463                          !scr "You were wounded by      the bush !               "
  3464                          !scr "You are trapped in       wire-nettings !          "
  3465                          }
  3466                          
  3467                          
  3468                          !if LANGUAGE = DE{
  3469                          !scr "Sie sind in eine         Schlangengrube gefallen !"
  3470                          !scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  3471                          !scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  3472                          !scr "Sie haben aus der Gift-  flasche getrunken....... "
  3473                          !scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  3474                          !scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  3475                          !scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  3476                          !scr "Sie sind in einen Nagel  getreten !               "
  3477                          !scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  3478                          !scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  3479                          !scr "Sie wurden eingeschlossenund verhungern !         "
  3480                          !scr "Sie wurden von einem     Stein ueberollt !!       "
  3481                          !scr "Belegro hat Sie          vernichtet !             "
  3482                          !scr "Im Sarg lag ein durstigerZombie........           "
  3483                          !scr "Das Monster hat Sie      erwischt !!!!!           "
  3484                          !scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  3485                          !scr "Sie haben sich im        Stacheldraht verfangen !!"
  3486                          }
  3487                          
  3488                          
  3489                          !if LANGUAGE = HU{
  3490  3b62 450719200b090719...!scr "Egy kigyoverembe estel !                          "
  3491  3b94 411a20091314050e...!scr "Az istenkaromlas         buntetese halal !        "
  3492  3bc6 42050c0506150c0c...!scr "Belefulladtal a mely     folyoba !                "
  3493  3bf8 41200d051207051a...!scr "A mergezett flaskabol    ittal...                 "
  3494  3c2a 420f1209132c2001...!scr "Boris, a pok elkapott    es vegzett veled !       "
  3495  3c5c 480114200e050d20...!scr "Hat nem lattad a         lezersugarat ?!?         "
  3496  3c8e 32343020560f0c14...!scr "240 Volt ! Megrazott az  aram !                   "
  3497  3cc0 42050c050c051014...!scr "Beleleptel egy szogbe !                           "
  3498  3cf2 4120031301100401...!scr "A csapda, amibe bele-    leptel megallitott !     "
  3499  3d24 451a050e20012013...!scr "Ezen a szoban Manilo, a  varazslo atka ul !       "
  3500  3d56 4120131a0f020120...!scr "A szoba rad zarult es    ehen haltal !            "
  3501  3d88 450c14010c010c14...!scr "Eltalalt egy hatalmas ko es szornyet haltal !     "
  3502  3dba 42050c0507120f20...!scr "Belegro elpusztitott     teged!                   "
  3503  3dec 450719200907011a...!scr "Egy igazan szomjas zombitsikerult talalnod ...    "
  3504  3e1e 4120131a0f120e19...!scr "A szornyeteg elkapott !  Meghaltal.               "
  3505  3e50 41201415130b0513...!scr "A tuskes bokrok          megsebeztek !            "
  3506  3e82 4120131a0f070513...!scr "A szogesdrot fogja       lettel !                 "
  3507                          }
  3508                          
  3509                          ; ==============================================================================
  3510                          ; screen messages
  3511                          ; and the code entry text
  3512                          ; ==============================================================================
  3513                          
  3514                          !if LANGUAGE = EN{
  3515                          hint_messages:
  3516                          !scr " A part of the code number is :         "
  3517                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3518                          !scr " You need: bulb, bulb holder, socket !  "
  3519                          !scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  3520                          !scr " *****   A helping letter :   "
  3521                          helping_letter: !scr "C   ***** "
  3522                          !scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  3523                          }
  3524                          
  3525                          !if LANGUAGE = DE{
  3526                          hint_messages:
  3527                          !scr " Ein Teil des Loesungscodes lautet:     "
  3528                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3529                          !scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  3530                          !scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  3531                          !scr " *****   Ein Hilfsbuchstabe:  "
  3532                          helping_letter: !scr "C   ***** "
  3533                          !scr " Falscher Loesungscode ! TODESSTRAFE !! "
  3534                          }
  3535                          
  3536                          !if LANGUAGE = HU{
  3537                          hint_messages:
  3538  3eb4 2041200a050c131a...!scr " A jelszo egy resze a kovetkezo:        "
  3539  3edc 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3540  3f04 20451a050b200b05...!scr " Ezek kellenek: tarto, korte, foglalat !"
  3541  3f2c 204d092001200a05...!scr " Mi a jelszo ?                 ",$22,"     ",$22,"  "
  3542  3f54 202a2a2a2a2a2020...!scr " *****   Egy betunyi sugo :   "
  3543  3f72 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  3544  3f7c 2041200a050c131a...!scr " A jelszo hibas ! BUNTETESED HALAL !    "
  3545                          }
  3546                          
  3547                          
  3548                          ; ==============================================================================
  3549                          ;
  3550                          ; ITEM PICKUP MESSAGES
  3551                          ; ==============================================================================
  3552                          
  3553                          
  3554                          item_pickup_message:              ; item pickup messages
  3555                          
  3556                          !if LANGUAGE = EN{
  3557                          !scr " There is a key in the bottle !         "
  3558                          !scr "   There is a key in the coffin !       "
  3559                          !scr " There is a breathing tube !            "
  3560                          }
  3561                          
  3562                          !if LANGUAGE = DE{
  3563                          !scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
  3564                          !scr "    In dem Sarg lag ein Schluessel !    "
  3565                          !scr " Unter dem Stein lag ein Taucheranzug ! "
  3566                          }
  3567                          
  3568                          !if LANGUAGE = HU{
  3569  3fa4 20412010010c0103...!scr " A palackban egy kulcs van !            "
  3570  3fcc 202020450719200b...!scr "   Egy kulcs van a koporsoban !         "
  3571  3ff4 2041200b0f20010c...!scr " A ko alatt egy buvarfelszereles hever !"
  3572                          }
  3573                          
  3574                          item_pickup_message_end:
