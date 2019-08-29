
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
   200  102c 204d11                                 jsr switch_charset           
   201  102f c003                                   cpy #$03                                ; is the display hint the one for the code number?
   202  1031 f003                                   beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
   203  1033 4cd510                                 jmp display_hint                        ; no, display the hint
   204                          
   205                          
   206                          room_16_code_number_prep:
   207                                              
   208  1036 20423b                                 jsr clear
   209  1039 200310                                 jsr display_hint_message                ; yes we are in room 3
   210  103c 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   211  103f 20eae8                                 jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
   212                                             
   213  1042 a001                                   ldy #$01                                ; y = 1
   214  1044 200310                                 jsr display_hint_message              
   215  1047 a200                                   ldx #$00                                ; x = 0
   216  1049 a000                                   ldy #$00                                ; y = 0
   217  104b f013                                   beq room_16_enter_code                  ; room 16 code? how?
   218                          
   219                          room_16_cursor_blinking: 
   220                          
   221  104d bdb905                                 lda SCREENRAM+$1B9,x                    ; load something from screen
   222  1050 18                                     clc                                     
   223  1051 6980                                   adc #$80                                ; add $80 = 128 = inverted char
   224  1053 9db905                                 sta SCREENRAM+$1B9,x                    ; store in the same location
   225  1056 b98805                                 lda SCREENRAM+$188,y                    ; and the same for another position
   226  1059 18                                     clc
   227  105a 6980                                   adc #$80
   228  105c 998805                                 sta SCREENRAM+$188,y 
   229  105f 60                                     rts
   230                          
   231                          ; ==============================================================================
   232                          ; ROOM 16
   233                          ; ENTER CODE
   234                          ; ==============================================================================
   235                          
   236                          room_16_enter_code:
   237                          
   238  1060 204d10                                 jsr room_16_cursor_blinking
   239  1063 8402                                   sty zp02
   240  1065 8604                                   stx zp04
   241  1067 20a210                                 jsr room_16_code_delay           
   242  106a 204d10                                 jsr room_16_cursor_blinking           
   243  106d 20a210                                 jsr room_16_code_delay
   244                          
   245  1070 ad00dc                                 lda $dc00
   246                                                                                          ; Bit #0: 0 = Port 2 joystick up pressed.
   247                                                                                          ; Bit #1: 0 = Port 2 joystick down pressed.
   248                                                                                          ; Bit #2: 0 = Port 2 joystick left pressed.
   249                                                                                          ; Bit #3: 0 = Port 2 joystick right pressed.
   250                                                                                          ; Bit #4: 0 = Port 2 joystick fire pressed.
   251                                              
   252  1073 4a                                     lsr                                         ; we don't check for up       
   253  1074 4a                                     lsr                                         ; we don't check for down
   254                                              
   255  1075 4a                                     lsr                                         ; now we have carry = 0 if LEFT PRESSED
   256  1076 b005                                   bcs +                                       ; left not pressed ->
   257  1078 e000                                   cpx #$00                                    ; x = 0?
   258  107a f001                                   beq +                                       ; yes ->
   259  107c ca                                     dex                                         ; no, x = x - 1 = move cursor left
   260                          
   261  107d 4a                 +                   lsr                                         ; now we have carry = 0 if RIGHT PRESSED
   262  107e b005                                   bcs +                                       ; right not pressed ->
   263  1080 e025                                   cpx #$25                                    ; right was pressed, but are we at the rightmost position already?
   264  1082 f001                                   beq +                                       ; yes we are ->
   265  1084 e8                                     inx                                         ; no, we can move one more, so x = x + 1
   266                          
   267  1085 4a                 +                   lsr                                         ; now we have carry = 0 if FIRE PRESSED
   268  1086 b0d8                                   bcs room_16_enter_code                      ; fire wasn't pressed, so start over
   269                                              
   270  1088 bdb905                                 lda SCREENRAM+$1B9,x                        ; fire WAS pressed, so get the current character
   271  108b c9bc                                   cmp #$bc                                    ; is it the "<" char for back?
   272  108d d008                                   bne ++                                      ; no ->
   273  108f c000                                   cpy #$00                                    ; yes, code submitted
   274  1091 f001                                   beq +
   275  1093 88                                     dey
   276  1094 4c6010             +                   jmp room_16_enter_code
   277  1097 998805             ++                  sta SCREENRAM+$188,y
   278  109a c8                                     iny
   279  109b c005                                   cpy #$05
   280  109d d0c1                                   bne room_16_enter_code
   281  109f 4cac10                                 jmp check_code_number
   282                          ; ==============================================================================
   283                          ;
   284                          ; DELAYS CURSOR MOVEMENT AND BLINKING
   285                          ; ==============================================================================
   286                          
   287                          room_16_code_delay:
   288  10a2 a020                                   ldy #$20                            ; wait a bit
   289  10a4 20ff39                                 jsr wait                        
   290  10a7 a402                                   ldy zp02                            ; and load x and y 
   291  10a9 a604                                   ldx zp04                            ; with shit from zp
   292  10ab 60                                     rts
   293                          
   294                          ; ==============================================================================
   295                          ; ROOM 16
   296                          ; CHECK THE CODE NUMBER
   297                          ; ==============================================================================
   298                          
   299                          check_code_number:
   300  10ac a205                                   ldx #$05                            ; x = 5
   301  10ae bd8705             -                   lda SCREENRAM+$187,x                ; get one number from code
   302  10b1 ddc310                                 cmp code_number-1,x                 ; is it correct?
   303  10b4 d006                                   bne +                               ; no -> +
   304  10b6 ca                                     dex                                 ; yes, check next number
   305  10b7 d0f5                                   bne -                               
   306  10b9 4cc910                                 jmp ++                              ; all correct -> ++
   307  10bc a005               +                   ldy #$05                            ; text for wrong code number
   308  10be 200310                                 jsr display_hint_message            ; wrong code -> death
   309  10c1 4c333b                                 jmp m3EF9          
   310                          
   311  10c4 3036313338         code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38
   312                          
   313  10c9 20063a             ++                  jsr set_game_basics                 ; code correct, continue
   314  10cc 20e039                                 jsr set_player_xy          
   315  10cf 208b3a                                 jsr draw_border          
   316  10d2 4cd53a                                 jmp main_loop          
   317                          
   318                          ; ==============================================================================
   319                          ;
   320                          ; hint system (question marks)
   321                          ; ==============================================================================
   322                          
   323                          
   324                          display_hint:
   325  10d5 c000                                   cpy #$00
   326  10d7 d04a                                   bne m11A2           
   327  10d9 200010                                 jsr display_hint_message_plus_clear
   328  10dc aef82f                                 ldx current_room + 1
   329  10df e001                                   cpx #$01
   330  10e1 d002                                   bne +               
   331  10e3 a928                                   lda #$28
   332  10e5 e005               +                   cpx #$05
   333  10e7 d002                                   bne +               
   334  10e9 a929                                   lda #$29
   335  10eb e00a               +                   cpx #$0a
   336  10ed d002                                   bne +               
   337  10ef a947                                   lda #$47                   
   338  10f1 e00c               +                   cpx #$0c
   339  10f3 d002                                   bne +
   340  10f5 a949                                   lda #$49
   341  10f7 e00d               +                   cpx #$0d
   342  10f9 d002                                   bne +
   343  10fb a945                                   lda #$45
   344  10fd e00f               +                   cpx #$0f
   345  10ff d00a                                   bne +               
   346  1101 a945                                   lda #$45
   347                                             
   348  1103 8d6fda                                 sta COLRAM + $26f       
   349  1106 a90f                                   lda #$0f
   350  1108 8d6f06                                 sta SCREENRAM + $26f       
   351  110b 8d1f06             +                   sta SCREENRAM + $21f       
   352  110e a948                                   lda #$48
   353  1110 8d1fda                                 sta COLRAM + $21f       
   354  1113 ad00dc             -                   lda $dc00                         ;lda #$fd
   355                                                                                ;sta KEYBOARD_LATCH
   356                                                                                ; lda KEYBOARD_LATCH
   357  1116 2910                                   and #$10                          ; and #$80
   358  1118 d0f9                                   bne -               
   359  111a 20063a                                 jsr set_game_basics
   360  111d 20f639                                 jsr m3A2D          
   361  1120 4cd53a                                 jmp main_loop         
   362  1123 c002               m11A2:              cpy #$02
   363  1125 d006                                   bne +             
   364  1127 200010             m11A6:              jsr display_hint_message_plus_clear
   365  112a 4c1311                                 jmp -             
   366  112d c004               +                   cpy #$04
   367  112f d00b                                   bne +              
   368  1131 ad0b39                                 lda m3952 + 1    
   369  1134 18                                     clc
   370  1135 6940                                   adc #$40                                        ; this is the helping letter
   371  1137 8d723f                                 sta helping_letter         
   372  113a d0eb                                   bne m11A6          
   373  113c 88                 +                   dey
   374  113d 88                                     dey
   375  113e 88                                     dey
   376  113f 88                                     dey
   377  1140 88                                     dey
   378  1141 a93f                                   lda #>item_pickup_message
   379  1143 85a8                                   sta zpA8
   380  1145 a9a4                                   lda #<item_pickup_message
   381  1147 200910                                 jsr m1009
   382  114a 4c1311                                 jmp -
   383                          
   384                          ; ==============================================================================
   385                          
   386                          switch_charset:
   387  114d 20263a                                 jsr set_charset_and_screen           
   388  1150 4c423b                                 jmp clear       ; jmp PRINT_KERNAL           
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
   408                          
   409                          
   410                          
   411                          
   412                          
   413                          
   414                          
   415                          
   416                          ; ==============================================================================
   417                          ;
   418                          ; JUMP TO ROOM LOGIC
   419                          ; This code is new. Previously, code execution jumped from room to room
   420                          ; and in each room did the comparison with the room number.
   421                          ; This is essentially the same, but bundled in one place.
   422                          ; not calles in between room changes, only e.g. for question mark
   423                          ; ==============================================================================
   424                          
   425                          check_room:
   426  1153 acf82f                                 ldy current_room + 1        ; load in the current room number
   427  1156 c000                                   cpy #0
   428  1158 d003                                   bne +
   429  115a 4cf511                                 jmp room_00
   430  115d c001               +                   cpy #1
   431  115f d003                                   bne +
   432  1161 4c1012                                 jmp room_01
   433  1164 c002               +                   cpy #2
   434  1166 d003                                   bne +
   435  1168 4c4d12                                 jmp room_02
   436  116b c003               +                   cpy #3
   437  116d d003                                   bne +
   438  116f 4ca312                                 jmp room_03
   439  1172 c004               +                   cpy #4
   440  1174 d003                                   bne +
   441  1176 4caf12                                 jmp room_04
   442  1179 c005               +                   cpy #5
   443  117b d003                                   bne +
   444  117d 4cd112                                 jmp room_05
   445  1180 c006               +                   cpy #6
   446  1182 d003                                   bne +
   447  1184 4cf512                                 jmp room_06
   448  1187 c007               +                   cpy #7
   449  1189 d003                                   bne +
   450  118b 4c0113                                 jmp room_07
   451  118e c008               +                   cpy #8
   452  1190 d003                                   bne +
   453  1192 4c3913                                 jmp room_08
   454  1195 c009               +                   cpy #9
   455  1197 d003                                   bne +
   456  1199 4c9013                                 jmp room_09
   457  119c c00a               +                   cpy #10
   458  119e d003                                   bne +
   459  11a0 4c9c13                                 jmp room_10
   460  11a3 c00b               +                   cpy #11
   461  11a5 d003                                   bne +
   462  11a7 4ccc13                                 jmp room_11 
   463  11aa c00c               +                   cpy #12
   464  11ac d003                                   bne +
   465  11ae 4cdb13                                 jmp room_12
   466  11b1 c00d               +                   cpy #13
   467  11b3 d003                                   bne +
   468  11b5 4cf713                                 jmp room_13
   469  11b8 c00e               +                   cpy #14
   470  11ba d003                                   bne +
   471  11bc 4c1b14                                 jmp room_14
   472  11bf c00f               +                   cpy #15
   473  11c1 d003                                   bne +
   474  11c3 4c2714                                 jmp room_15
   475  11c6 c010               +                   cpy #16
   476  11c8 d003                                   bne +
   477  11ca 4c3314                                 jmp room_16
   478  11cd c011               +                   cpy #17
   479  11cf d003                                   bne +
   480  11d1 4c5914                                 jmp room_17
   481  11d4 4c6814             +                   jmp room_18
   482                          
   483                          
   484                          
   485                          ; ==============================================================================
   486                          
   487                          check_death:
   488  11d7 20d237                                 jsr update_items_display
   489  11da 4cd53a                                 jmp main_loop           
   490                          
   491                          ; ==============================================================================
   492                          
   493                          m11E0:              
   494  11dd a200                                   ldx #$00
   495  11df bd4503             -                   lda TAPE_BUFFER + $9,x              
   496  11e2 c91e                                   cmp #$1e                            ; question mark
   497  11e4 9007                                   bcc check_next_char_under_player           
   498  11e6 c9df                                   cmp #$df
   499  11e8 f003                                   beq check_next_char_under_player
   500  11ea 4c5311                                 jmp check_room              
   501                          
   502                          ; ==============================================================================
   503                          
   504                          check_next_char_under_player:
   505  11ed e8                                     inx
   506  11ee e009                                   cpx #$09
   507  11f0 d0ed                                   bne -                              ; not done checking          
   508  11f2 4cd53a             -                   jmp main_loop           
   509                          
   510                          
   511                          ; ==============================================================================
   512                          ;
   513                          ;                                                             ###        ###
   514                          ;          #####      ####      ####     #    #              #   #      #   #
   515                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   516                          ;          #    #    #    #    #    #    # ## #             #     #    #     #
   517                          ;          #####     #    #    #    #    #    #             #     #    #     #
   518                          ;          #   #     #    #    #    #    #    #              #   #      #   #
   519                          ;          #    #     ####      ####     #    #               ###        ###
   520                          ;
   521                          ; ==============================================================================
   522                          
   523                          
   524                          room_00:
   525                          
   526  11f5 c9a9                                   cmp #$a9                                        ; has the player hit the gloves?
   527  11f7 d0f4                                   bne check_next_char_under_player                ; no
   528  11f9 a9df                                   lda #$df                                        ; yes, load in char for "empty"
   529  11fb cd6336                                 cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
   530  11fe d0f2                                   bne -                                           ; no
   531  1200 200512                                 jsr pickup_gloves                               ; yes
   532  1203 d0d2                                   bne check_death
   533                          
   534                          
   535                          pickup_gloves:
   536  1205 a96b                                   lda #$6b                                        ; load character for empty bush
   537  1207 8d1e36                                 sta items + $8                                  ; store 6b = gloves in inventory
   538  120a a93d                                   lda #$3d                                        ; set the foreground color
   539  120c 8d1c36                                 sta items + $6                                  ; and store the color in the items table
   540  120f 60                                     rts
   541                          
   542                          
   543                          
   544                          
   545                          
   546                          
   547                          ; ==============================================================================
   548                          ;
   549                          ;                                                             ###        #
   550                          ;          #####      ####      ####     #    #              #   #      ##
   551                          ;          #    #    #    #    #    #    ##  ##             #     #    # #
   552                          ;          #    #    #    #    #    #    # ## #             #     #      #
   553                          ;          #####     #    #    #    #    #    #             #     #      #
   554                          ;          #   #     #    #    #    #    #    #              #   #       #
   555                          ;          #    #     ####      ####     #    #               ###      #####
   556                          ;
   557                          ; ==============================================================================
   558                          
   559                          room_01:
   560                          
   561  1210 c9e0                                   cmp #$e0                                    ; empty character in charset -> invisible key
   562  1212 f004                                   beq +                                       ; yes, key is there -> +
   563  1214 c9e1                                   cmp #$e1
   564  1216 d014                                   bne ++
   565  1218 a9aa               +                   lda #$aa                                    ; display the key, $AA = 1st part of key
   566  121a 8d2636                                 sta items + $10                             ; store key in items list
   567  121d 20d237                                 jsr update_items_display                    ; update all items in the items list (we just made the key visible)
   568  1220 a0f0                                   ldy #$f0                                    ; set waiting time
   569  1222 20ff39                                 jsr wait                                    ; wait
   570  1225 a9df                                   lda #$df                                    ; set key to empty space
   571  1227 8d2636                                 sta items + $10                             ; update items list
   572  122a d0ab                                   bne check_death
   573  122c c927               ++                  cmp #$27                                    ; question mark (I don't know why 27)
   574  122e b005                                   bcs check_death_bush
   575  1230 a000                                   ldy #$00
   576  1232 4c2c10                                 jmp prep_and_display_hint
   577                          
   578                          check_death_bush:
   579  1235 c9ad                                   cmp #$ad                                    ; wirecutters
   580  1237 d0b4                                   bne check_next_char_under_player
   581  1239 ad1e36                                 lda items + $8                              ; inventory place for the gloves! 6b = gloves
   582  123c c96b                                   cmp #$6b
   583  123e f005                                   beq +
   584  1240 a00f                                   ldy #$0f
   585  1242 4ce33a                                 jmp death                                   ; 0f You were wounded by the bush!
   586                          
   587  1245 a9f9               +                   lda #$f9                                    ; wirecutter picked up
   588  1247 8d2f36                                 sta items + $19
   589  124a 4cd711                                 jmp check_death
   590                          
   591                          
   592                          
   593                          
   594                          
   595                          
   596                          ; ==============================================================================
   597                          ;
   598                          ;                                                             ###       #####
   599                          ;          #####      ####      ####     #    #              #   #     #     #
   600                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   601                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   602                          ;          #####     #    #    #    #    #    #             #     #    #
   603                          ;          #   #     #    #    #    #    #    #              #   #     #
   604                          ;          #    #     ####      ####     #    #               ###      #######
   605                          ;
   606                          ; ==============================================================================
   607                          
   608                          room_02:
   609                          
   610  124d c9f5                                   cmp #$f5                                    ; did the player hit the fence? f5 = fence character
   611  124f d014                                   bne check_lock                              ; no, check for the lock
   612  1251 ad2f36                                 lda items + $19                             ; fence was hit, so check if wirecuter was picked up
   613  1254 c9f9                                   cmp #$f9                                    ; where the wirecutters (f9) picked up?
   614  1256 f005                                   beq remove_fence                            ; yes
   615  1258 a010                                   ldy #$10                                    ; no, load the correct death message
   616  125a 4ce33a                                 jmp death                                   ; 10 You are trapped in wire-nettings!
   617                          
   618                          remove_fence:
   619  125d a9df                                   lda #$df                                    ; empty char
   620  125f 8db538                                 sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
   621  1262 4cd711             m1264:              jmp check_death
   622                          
   623                          
   624                          check_lock:
   625  1265 c9a6                                   cmp #$a6                                    ; lock
   626  1267 d00e                                   bne +
   627  1269 ad2636                                 lda items + $10
   628  126c c9df                                   cmp #$df
   629  126e d0f2                                   bne m1264
   630  1270 a9df                                   lda #$df
   631  1272 8d4e36                                 sta items + $38
   632  1275 d0eb                                   bne m1264
   633  1277 c9b1               +                   cmp #$b1                                    ; ladder
   634  1279 d00a                                   bne +
   635  127b a9df                                   lda #$df
   636  127d 8d6336                                 sta items + $4d
   637  1280 8d6e36                                 sta items + $58
   638  1283 d0dd                                   bne m1264
   639  1285 c9b9               +                   cmp #$b9                                    ; bottle
   640  1287 f003                                   beq +
   641  1289 4ced11                                 jmp check_next_char_under_player
   642  128c add136             +                   lda items + $bb
   643  128f c9df                                   cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
   644  1291 f005                                   beq take_key_out_of_bottle                                   
   645  1293 a003                                   ldy #$03
   646  1295 4ce33a                                 jmp death                                   ; 03 You drank from the poisend bottle
   647                          
   648                          take_key_out_of_bottle:
   649  1298 a901                                   lda #$01
   650  129a 8da212                                 sta key_in_bottle_storage
   651  129d a005                                   ldy #$05
   652  129f 4c2c10                                 jmp prep_and_display_hint
   653                          
   654                          ; ==============================================================================
   655                          ; this is 1 if the key from the bottle was taken and 0 if not
   656                          
   657  12a2 00                 key_in_bottle_storage:              !byte $00
   658                          
   659                          
   660                          
   661                          
   662                          
   663                          
   664                          
   665                          
   666                          
   667                          ; ==============================================================================
   668                          ;
   669                          ;                                                             ###       #####
   670                          ;          #####      ####      ####     #    #              #   #     #     #
   671                          ;          #    #    #    #    #    #    ##  ##             #     #          #
   672                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   673                          ;          #####     #    #    #    #    #    #             #     #          #
   674                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   675                          ;          #    #     ####      ####     #    #               ###       #####
   676                          ;
   677                          ; ==============================================================================
   678                          
   679                          room_03:
   680                          
   681  12a3 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   682  12a5 9003                                   bcc +
   683  12a7 4cd53a                                 jmp main_loop
   684  12aa a004               +                   ldy #$04
   685  12ac 4c2c10                                 jmp prep_and_display_hint
   686                          
   687                          
   688                          
   689                          
   690                          
   691                          
   692                          ; ==============================================================================
   693                          ;
   694                          ;                                                             ###      #
   695                          ;          #####      ####      ####     #    #              #   #     #    #
   696                          ;          #    #    #    #    #    #    ##  ##             #     #    #    #
   697                          ;          #    #    #    #    #    #    # ## #             #     #    #    #
   698                          ;          #####     #    #    #    #    #    #             #     #    #######
   699                          ;          #   #     #    #    #    #    #    #              #   #          #
   700                          ;          #    #     ####      ####     #    #               ###           #
   701                          ;
   702                          ; ==============================================================================
   703                          
   704                          room_04:
   705                          
   706  12af c93b                                   cmp #$3b                                    ; you bumped into a zombie coffin?
   707  12b1 f004                                   beq +                                       ; yep
   708  12b3 c942                                   cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
   709  12b5 d005                                   bne ++                                      ; no, really, I didn't ( I swear! )-> ++
   710  12b7 a00d               +                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
   711  12b9 4ce33a                                 jmp death                                   ; 0d You found a thirsty zombie....
   712                          
   713                          ++
   714  12bc c9f7                                   cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
   715  12be f007                                   beq +                                       ; seems you picked a coffin that contained something different...
   716  12c0 c9f8                                   cmp #$f8
   717  12c2 f003                                   beq +
   718  12c4 4ced11                                 jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
   719  12c7 a900               +                   lda #$00                                    ; 
   720  12c9 8d0339                                 sta m394A + 1                               ; some kind of prep for the door to be unlocked 
   721  12cc a006                                   ldy #$06                                    ; display
   722  12ce 4c2c10                                 jmp prep_and_display_hint
   723                          
   724                          
   725                          
   726                          
   727                          
   728                          
   729                          ; ==============================================================================
   730                          ;
   731                          ;                                                             ###      #######
   732                          ;          #####      ####      ####     #    #              #   #     #
   733                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   734                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   735                          ;          #####     #    #    #    #    #    #             #     #          #
   736                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   737                          ;          #    #     ####      ####     #    #               ###       #####
   738                          ;
   739                          ; ==============================================================================
   740                          
   741                          room_05:
   742                          
   743  12d1 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   744  12d3 b005                                   bcs +                                       ; no
   745  12d5 a000                                   ldy #$00                                    ; a = 0
   746  12d7 4c2c10                                 jmp prep_and_display_hint
   747                          
   748  12da c9fd               +                   cmp #$fd                                    ; stone with breathing tube hit?
   749  12dc f003                                   beq +                                       ; yes -> +
   750  12de 4ced11                                 jmp check_next_char_under_player            ; no
   751                          
   752  12e1 a900               +                   lda #$00                                    ; a = 0                  
   753  12e3 acac36                                 ldy items + $96                             ; do you have the shovel? 
   754  12e6 c0df                                   cpy #$df
   755  12e8 d008                                   bne +                                       ; no I don't
   756  12ea 8d9138                                 sta breathing_tube_mod + 1                  ; yes, take the breathing tube
   757  12ed a007                                   ldy #$07                                    ; and display the message
   758  12ef 4c2c10                                 jmp prep_and_display_hint
   759  12f2 4cd53a             +                   jmp main_loop
   760                          
   761                                              ;ldy #$07                                   ; same is happening above and I don't see this being called
   762                                              ;jmp prep_and_display_hint
   763                          
   764                          
   765                          
   766                          
   767                          
   768                          
   769                          ; ==============================================================================
   770                          ;
   771                          ;                                                             ###       #####
   772                          ;          #####      ####      ####     #    #              #   #     #     #
   773                          ;          #    #    #    #    #    #    ##  ##             #     #    #
   774                          ;          #    #    #    #    #    #    # ## #             #     #    ######
   775                          ;          #####     #    #    #    #    #    #             #     #    #     #
   776                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   777                          ;          #    #     ####      ####     #    #               ###       #####
   778                          ;
   779                          ; ==============================================================================
   780                          
   781                          room_06:
   782                          
   783  12f5 c9f6                                   cmp #$f6                                    ; is it a trapped door?
   784  12f7 f003                                   beq +                                       ; OMG Yes the room is full of...
   785  12f9 4ced11                                 jmp check_next_char_under_player            ; please move on. nothing happened.
   786  12fc a000               +                   ldy #$00
   787  12fe 4ce33a                                 jmp death                                   ; 00 You fell into a snake pit
   788                          
   789                          
   790                          
   791                          
   792                          
   793                          
   794                          ; ==============================================================================
   795                          ;
   796                          ;                                                             ###      #######
   797                          ;          #####      ####      ####     #    #              #   #     #    #
   798                          ;          #    #    #    #    #    #    ##  ##             #     #        #
   799                          ;          #    #    #    #    #    #    # ## #             #     #       #
   800                          ;          #####     #    #    #    #    #    #             #     #      #
   801                          ;          #   #     #    #    #    #    #    #              #   #       #
   802                          ;          #    #     ####      ####     #    #               ###        #
   803                          ;
   804                          ; ==============================================================================
   805                          
   806                          room_07:
   807                                  
   808  1301 c9e3                                   cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
   809  1303 d005                                   bne +
   810  1305 a001                                   ldy #$01                                    ; 01 You'd better watched out for the sacred column
   811  1307 4ce33a                                 jmp death                                   ; bne m1303 <- seems unneccessary
   812                          
   813  130a c95f               +                   cmp #$5f                                    ; seems to be the invisible char for the light
   814  130c f003                                   beq +                                       ; and it was hit -> +
   815  130e 4ced11                                 jmp check_next_char_under_player            ; if not, continue checking
   816                          
   817  1311 a9bc               +                   lda #$bc                                    ; make light visible
   818  1313 8d8a36                                 sta items + $74                             ; but I dont understand how the whole light is shown
   819  1316 a95f                                   lda #$5f                                    ; color?
   820  1318 8d8836                                 sta items + $72                             ; 
   821  131b 20d237                                 jsr update_items_display                    ; and redraw items
   822  131e a0ff                                   ldy #$ff
   823  1320 20ff39                                 jsr wait                                    ; wait for some time so the player can actually see the light
   824  1323 20ff39                                 jsr wait
   825  1326 20ff39                                 jsr wait
   826  1329 20ff39                                 jsr wait
   827  132c a9df                                   lda #$df
   828  132e 8d8a36                                 sta items + $74                             ; and pick up the light/ remove it from the items list
   829  1331 a900                                   lda #$00
   830  1333 8d8836                                 sta items + $72                             ; also paint the char black
   831  1336 4cd711                                 jmp check_death
   832                          
   833                          
   834                          
   835                          
   836                          
   837                          
   838                          ; ==============================================================================
   839                          ;
   840                          ;                                                             ###       #####
   841                          ;          #####      ####      ####     #    #              #   #     #     #
   842                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   843                          ;          #    #    #    #    #    #    # ## #             #     #     #####
   844                          ;          #####     #    #    #    #    #    #             #     #    #     #
   845                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   846                          ;          #    #     ####      ####     #    #               ###       #####
   847                          ;
   848                          ; ==============================================================================
   849                          
   850                          room_08:
   851                          
   852  1339 a000                                   ldy #$00                                    ; y = 0
   853  133b 84a7                                   sty zpA7                                    ; zpA7 = 0
   854  133d c94b                                   cmp #$4b                                    ; water
   855  133f d015                                   bne check_item_water
   856  1341 ac9138                                 ldy breathing_tube_mod + 1
   857  1344 d017                                   bne +
   858  1346 209635                                 jsr get_player_pos
   859  1349 a918                                   lda #$18                                    ; move player on the other side of the river
   860  134b 8d4235             --                  sta player_pos_x + 1
   861  134e a90c                                   lda #$0c
   862  1350 8d4035                                 sta player_pos_y + 1
   863  1353 4cd53a             -                   jmp main_loop
   864                          
   865                          
   866                          check_item_water:
   867  1356 c956                                   cmp #$56                                    ; so you want to swim right?
   868  1358 d011                                   bne check_item_shovel                       ; nah, not this time -> check_item_shovel
   869  135a ac9138                                 ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
   870  135d d007               +                   bne +
   871  135f 209635                                 jsr get_player_pos                          ; tube equipped and ready to submerge
   872  1362 a90c                                   lda #$0c
   873  1364 d0e5                                   bne --                                      ; see you on the other side!
   874                          
   875  1366 a002               +                   ldy #$02                                    ; breathing what?
   876  1368 4ce33a                                 jmp death                                   ; 02 You drowned in the deep river
   877                          
   878                          
   879                          check_item_shovel:
   880  136b c9c1                                   cmp #$c1                                    ; wanna have that shovel?
   881  136d f004                                   beq +                                       ; yup
   882  136f c9c3                                   cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
   883  1371 d008                                   bne ++                                      ; nah still not interested -> ++
   884  1373 a9df               +                   lda #$df                                    ; alright cool,
   885  1375 8dac36                                 sta items + $96                             ; shovel is yours now
   886  1378 4cd711             --                  jmp check_death
   887                          
   888                          
   889  137b c9ca               ++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
   890  137d f003                                   beq +                                       ; yup
   891  137f 4ced11                                 jmp check_next_char_under_player
   892  1382 add136             +                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
   893  1385 c9df                                   cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
   894  1387 d0ca                                   bne -                                       ; what hammer?
   895  1389 a9df                                   lda #$df
   896  138b 8d9a36                                 sta items + $84                             ; these fine boots are yours now, sir
   897  138e d0e8                                   bne --
   898                          
   899                          
   900                          
   901                          
   902                          
   903                          
   904                          ; ==============================================================================
   905                          ;
   906                          ;                                                             ###       #####
   907                          ;          #####      ####      ####     #    #              #   #     #     #
   908                          ;          #    #    #    #    #    #    ##  ##             #     #    #     #
   909                          ;          #    #    #    #    #    #    # ## #             #     #     ######
   910                          ;          #####     #    #    #    #    #    #             #     #          #
   911                          ;          #   #     #    #    #    #    #    #              #   #     #     #
   912                          ;          #    #     ####      ####     #    #               ###       #####
   913                          ;
   914                          ; ==============================================================================
   915                          
   916                          room_09:            
   917                          
   918  1390 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   919  1392 9003                                   bcc +                                       ; yes -> +
   920  1394 4ced11                                 jmp check_next_char_under_player            ; continue checking
   921  1397 a002               +                   ldy #$02                                    ; display hint
   922  1399 4c2c10                                 jmp prep_and_display_hint
   923                          
   924                          
   925                          
   926                          
   927                          
   928                          
   929                          ; ==============================================================================
   930                          ;
   931                          ;                                                             #        ###
   932                          ;          #####      ####      ####     #    #              ##       #   #
   933                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
   934                          ;          #    #    #    #    #    #    # ## #               #      #     #
   935                          ;          #####     #    #    #    #    #    #               #      #     #
   936                          ;          #   #     #    #    #    #    #    #               #       #   #
   937                          ;          #    #     ####      ####     #    #             #####      ###
   938                          ;
   939                          ; ==============================================================================
   940                          
   941                          room_10:
   942                          
   943  139c c927                                   cmp #$27                                    ; question mark (I don't know why 27)
   944  139e b005                                   bcs +
   945  13a0 a000                                   ldy #$00                                    ; display hint
   946  13a2 4c2c10                                 jmp prep_and_display_hint
   947                          
   948  13a5 c9cc               +                   cmp #$cc                                    ; hit the power outlet?
   949  13a7 f007                                   beq +                                       ; yes -> +
   950  13a9 c9cf                                   cmp #$cf                                    ; hit the power outlet?
   951  13ab f003                                   beq +                                       ; yes -> +
   952  13ad 4ced11                                 jmp check_next_char_under_player            ; no, continue
   953  13b0 a9df               +                   lda #$df                                    
   954  13b2 cd8a36                                 cmp items + $74                             ; light picked up?
   955  13b5 d010                                   bne +                                       ; no -> death
   956  13b7 cdde36                                 cmp items + $c8                             ; yes, lightbulb picked up?
   957  13ba d00b                                   bne +                                       ; no -> death
   958  13bc 8dc236                                 sta items + $ac                             ; yes, pick up power outlet
   959  13bf a959                                   lda #$59                                    ; and make the foot traps visible
   960  13c1 8d4237                                 sta items + $12c                            ; color position for foot traps
   961  13c4 4cd711                                 jmp check_death
   962                          
   963  13c7 a006               +                   ldy #$06
   964  13c9 4ce33a                                 jmp death                                   ; 06 240 Volts! You got an electrical shock!
   965                          
   966                          
   967                          
   968                          
   969                          
   970                          
   971                          ; ==============================================================================
   972                          ;
   973                          ;                                                             #        #
   974                          ;          #####      ####      ####     #    #              ##       ##
   975                          ;          #    #    #    #    #    #    ##  ##             # #      # #
   976                          ;          #    #    #    #    #    #    # ## #               #        #
   977                          ;          #####     #    #    #    #    #    #               #        #
   978                          ;          #   #     #    #    #    #    #    #               #        #
   979                          ;          #    #     ####      ####     #    #             #####    #####
   980                          ;
   981                          ; ==============================================================================
   982                          
   983                          room_11:
   984                          
   985  13cc c9d1                                   cmp #$d1                                    ; picking up the hammer?
   986  13ce f003                                   beq +                                       ; jep
   987  13d0 4ced11                                 jmp check_next_char_under_player            ; no, continue
   988  13d3 a9df               +                   lda #$df                                    ; player takes the hammer
   989  13d5 8dd136                                 sta items + $bb                             ; hammer
   990  13d8 4cd711                                 jmp check_death
   991                          
   992                          
   993                          
   994                          
   995                          
   996                          
   997                          ; ==============================================================================
   998                          ;
   999                          ;                                                             #       #####
  1000                          ;          #####      ####      ####     #    #              ##      #     #
  1001                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1002                          ;          #    #    #    #    #    #    # ## #               #       #####
  1003                          ;          #####     #    #    #    #    #    #               #      #
  1004                          ;          #   #     #    #    #    #    #    #               #      #
  1005                          ;          #    #     ####      ####     #    #             #####    #######
  1006                          ;
  1007                          ; ==============================================================================
  1008                          
  1009                          room_12:
  1010                          
  1011  13db c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1012  13dd b005                                   bcs +                                       ; no
  1013  13df a000                                   ldy #$00                                    
  1014  13e1 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1015                          
  1016  13e4 c9d2               +                   cmp #$d2                                    ; light bulb hit?
  1017  13e6 f007                                   beq +                                       ; yes
  1018  13e8 c9d5                                   cmp #$d5                                    ; light bulb hit?
  1019  13ea f003                                   beq +                                       ; yes
  1020  13ec 4ced11                                 jmp check_next_char_under_player            ; no, continue
  1021  13ef a9df               +                   lda #$df                                    ; pick up light bulb
  1022  13f1 8dde36                                 sta items + $c8
  1023  13f4 4cd711                                 jmp check_death
  1024                          
  1025                          
  1026                          
  1027                          
  1028                          
  1029                          
  1030                          ; ==============================================================================
  1031                          ;
  1032                          ;                                                             #       #####
  1033                          ;          #####      ####      ####     #    #              ##      #     #
  1034                          ;          #    #    #    #    #    #    ##  ##             # #            #
  1035                          ;          #    #    #    #    #    #    # ## #               #       #####
  1036                          ;          #####     #    #    #    #    #    #               #            #
  1037                          ;          #   #     #    #    #    #    #    #               #      #     #
  1038                          ;          #    #     ####      ####     #    #             #####     #####
  1039                          ;
  1040                          ; ==============================================================================
  1041                          
  1042                          room_13:           
  1043                          
  1044  13f7 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1045  13f9 b005                                   bcs +
  1046  13fb a000                                   ldy #$00                                    ; message 0 to display
  1047  13fd 4c2c10                                 jmp prep_and_display_hint                   ; display hint
  1048                          
  1049  1400 c9d6               +                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
  1050  1402 f003                                   beq +                                       ; OUCH!! -> +
  1051  1404 4ced11                                 jmp check_next_char_under_player            ; not stepped into a nail... yet.
  1052  1407 ad9a36             +                   lda items + $84                             ; are the boots taken?
  1053  140a c9df                                   cmp #$df                                
  1054  140c f005                                   beq +                                       ; yeah I'm cool these boots are made for nailin'. 
  1055  140e a007                                   ldy #$07                                    ; death by a thousand nails.
  1056  1410 4ce33a                                 jmp death                                   ; 07 You stepped on a nail!
  1057                          
  1058                          +
  1059  1413 a9e2                                   lda #$e2                                    ; this is also a nail. 
  1060  1415 8deb36                                 sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
  1061  1418 4cd711                                 jmp check_death
  1062                          
  1063                          
  1064                          
  1065                          
  1066                          
  1067                          
  1068                          ; ==============================================================================
  1069                          ;
  1070                          ;                                                             #      #
  1071                          ;          #####      ####      ####     #    #              ##      #    #
  1072                          ;          #    #    #    #    #    #    ##  ##             # #      #    #
  1073                          ;          #    #    #    #    #    #    # ## #               #      #    #
  1074                          ;          #####     #    #    #    #    #    #               #      #######
  1075                          ;          #   #     #    #    #    #    #    #               #           #
  1076                          ;          #    #     ####      ####     #    #             #####         #
  1077                          ;
  1078                          ; ==============================================================================
  1079                          
  1080                          room_14:
  1081                          
  1082  141b c9d7                                   cmp #$d7                                    ; foot trap char
  1083  141d f003                                   beq +                                       ; stepped into it?
  1084  141f 4ced11                                 jmp check_next_char_under_player            ; not... yet...
  1085  1422 a008               +                   ldy #$08                                    ; go die
  1086  1424 4ce33a                                 jmp death                                   ; 08 A foot trap stopped you!
  1087                          
  1088                          
  1089                          
  1090                          
  1091                          
  1092                          
  1093                          ; ==============================================================================
  1094                          ;
  1095                          ;                                                             #      #######
  1096                          ;          #####      ####      ####     #    #              ##      #
  1097                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1098                          ;          #    #    #    #    #    #    # ## #               #      ######
  1099                          ;          #####     #    #    #    #    #    #               #            #
  1100                          ;          #   #     #    #    #    #    #    #               #      #     #
  1101                          ;          #    #     ####      ####     #    #             #####     #####
  1102                          ;
  1103                          ; ==============================================================================
  1104                          
  1105                          room_15:
  1106                          
  1107  1427 c927                                   cmp #$27                                    ; question mark (I don't know why 27)
  1108  1429 b005                                   bcs +
  1109  142b a000                                   ldy #$00                                    ; display hint
  1110  142d 4c2c10                                 jmp prep_and_display_hint
  1111                          
  1112  1430 4ced11             +                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address
  1113                          
  1114                          
  1115                          
  1116                          
  1117                          
  1118                          
  1119                          ; ==============================================================================
  1120                          ;
  1121                          ;                                                             #       #####
  1122                          ;          #####      ####      ####     #    #              ##      #     #
  1123                          ;          #    #    #    #    #    #    ##  ##             # #      #
  1124                          ;          #    #    #    #    #    #    # ## #               #      ######
  1125                          ;          #####     #    #    #    #    #    #               #      #     #
  1126                          ;          #   #     #    #    #    #    #    #               #      #     #
  1127                          ;          #    #     ####      ####     #    #             #####     #####
  1128                          ;
  1129                          ; ==============================================================================
  1130                          
  1131                          room_16:
  1132                          
  1133  1433 c9f4                                   cmp #$f4                                    ; did you hit the wall in the left cell?
  1134  1435 d005                                   bne +                                       ; I did not! -> +
  1135  1437 a00a                                   ldy #$0a                                    ; yeah....
  1136  1439 4ce33a                                 jmp death                                   ; 0a You were locked in and starved!
  1137                          
  1138  143c c9d9               +                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
  1139  143e f004                                   beq +                                       ; not that I know of...
  1140  1440 c9db                                   cmp #$db                                    ; are you sure? take a look at this slightly different wall
  1141  1442 d005                                   bne ++                                      ; it doesn't look familiar... -> ++
  1142                          
  1143  1444 a009               +                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
  1144  1446 4ce33a                                 jmp death
  1145                          
  1146  1449 c9b9               ++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
  1147  144b f007                                   beq +                                       ; yes! -> +
  1148  144d c9bb                                   cmp #$bb                                    ; here's another part of that bottle for reference
  1149  144f f003                                   beq +                                       ; yes! -> +
  1150  1451 4ced11                                 jmp check_next_char_under_player            ; no, continue
  1151  1454 a003               +                   ldy #$03                                    ; display code enter screen
  1152  1456 4c2c10                                 jmp prep_and_display_hint
  1153                          
  1154                          
  1155                          
  1156                          
  1157                          
  1158                          
  1159                          ; ==============================================================================
  1160                          ;
  1161                          ;                                                             #      #######
  1162                          ;          #####      ####      ####     #    #              ##      #    #
  1163                          ;          #    #    #    #    #    #    ##  ##             # #          #
  1164                          ;          #    #    #    #    #    #    # ## #               #         #
  1165                          ;          #####     #    #    #    #    #    #               #        #
  1166                          ;          #   #     #    #    #    #    #    #               #        #
  1167                          ;          #    #     ####      ####     #    #             #####      #
  1168                          ;
  1169                          ; ==============================================================================
  1170                          
  1171                          room_17:
  1172                          
  1173  1459 c9dd                                   cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
  1174  145b f003                                   beq +                                       ; yup
  1175  145d 4ced11                                 jmp check_next_char_under_player            ; nah not yet.
  1176  1460 a9df               +                   lda #$df                                    ; pick up sword
  1177  1462 8dbd37                                 sta items + $1a7                            ; store in items list
  1178  1465 4cd711                                 jmp check_death
  1179                          
  1180                          
  1181                          
  1182                          
  1183                          
  1184                          
  1185                          ; ==============================================================================
  1186                          ;
  1187                          ;                                                             #       #####
  1188                          ;          #####      ####      ####     #    #              ##      #     #
  1189                          ;          #    #    #    #    #    #    ##  ##             # #      #     #
  1190                          ;          #    #    #    #    #    #    # ## #               #       #####
  1191                          ;          #####     #    #    #    #    #    #               #      #     #
  1192                          ;          #   #     #    #    #    #    #    #               #      #     #
  1193                          ;          #    #     ####      ####     #    #             #####     #####
  1194                          ;
  1195                          ; ==============================================================================
  1196                          
  1197                          room_18:
  1198  1468 c981                                   cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
  1199  146a b003                                   bcs +                   
  1200  146c 4cd711                                 jmp check_death
  1201                          
  1202  146f ada212             +                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
  1203  1472 d003                                   bne +                                       ; yes I actually did (flexes arms)
  1204  1474 4cd53a                                 jmp main_loop                               ; nope
  1205  1477 20263a             +                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
  1206  147a 4c421b                                 jmp print_endscreen                         ; (drops mic)
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
  1240                          
  1241                          
  1242                          
  1243                          
  1244                          
  1245                          
  1246                          
  1247                          
  1248                          ; ==============================================================================
  1249                          ; 
  1250                          ; EVERYTHING ANIMATION RELATED STARTS HERE
  1251                          ; ANIMATIONS FOR
  1252                          ; LASER, BORIS, BELEGRO, STONE, MONSTER
  1253                          ; ==============================================================================
  1254                          
  1255                          ; TODO
  1256                          ; this gets called all the time, no checks 
  1257                          ; needs to be optimized
  1258                          
  1259                          
  1260                          animation_entrypoint:
  1261                                              
  1262                                              ; code below is used to check if the foot traps should be visible
  1263                                              ; it checked for this every single fucking frame
  1264                                              ; moved the foot traps coloring where it belongs (when picking up power outlet)
  1265                                              ;lda items + $ac                         ; $cc (power outlet)
  1266                                              ;cmp #$df                                ; taken?
  1267                                              ;bne +                                   ; no -> +
  1268                                              ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
  1269                                              ;sta items + $12c                        ; originally $0
  1270                          
  1271  147d acf82f             +                   ldy current_room + 1                    ; load room number
  1272                          
  1273  1480 c011                                   cpy #$11                                ; is it room #17? (Belegro)
  1274  1482 d046                                   bne room_14_prep                         ; no -> m162A
  1275                                              
  1276                                              
  1277  1484 ad1915                                 lda m14CC + 1                           ; yes, get value from m14CD
  1278  1487 d013                                   bne m15FC                               ; 0? -> m15FC
  1279  1489 ad4035                                 lda player_pos_y + 1                    ; not 0, get player pos Y
  1280  148c c906                                   cmp #$06                                ; is it 6?
  1281  148e d00c                                   bne m15FC                               ; no -> m15FC
  1282  1490 ad4235                                 lda player_pos_x + 1                    ; yes, get player pos X
  1283  1493 c918                                   cmp #$18                                ; is player x position $18?
  1284  1495 d005                                   bne m15FC                               ; no -> m15FC
  1285  1497 a900                                   lda #$00                                ; yes, load 0
  1286  1499 8d9d14                                 sta m15FC + 1                           ; store 0 in m15FC+1
  1287  149c a901               m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
  1288  149e d016                                   bne +                                   ; is it 0? -> +
  1289  14a0 a006                                   ldy #$06                                ; y = $6
  1290  14a2 a21e               m1602:              ldx #$1e                                ; x = $1e
  1291  14a4 a900                                   lda #$00                                ; a = $0
  1292  14a6 85a7                                   sta zpA7                                ; zpA7 = 0
  1293  14a8 20c734                                 jsr draw_player                         ; TODO
  1294  14ab aea314                                 ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
  1295  14ae e003                                   cpx #$03                                ; is X = $3?
  1296  14b0 f001                                   beq ++                                  ; yes -> ++
  1297  14b2 ca                                     dex                                     ; x = x -1
  1298  14b3 8ea314             ++                  stx m1602 + 1                           ; store x in m1602+1
  1299  14b6 a978               +                   lda #$78                                ; a = $78
  1300  14b8 85a8                                   sta zpA8                                ; zpA8 = $78
  1301  14ba a949                                   lda #$49                                ; a = $49
  1302  14bc 850a                                   sta zp0A                                ; zp0A = $49
  1303  14be a006                                   ldy #$06                                ; y = $06
  1304  14c0 a901                                   lda #$01                                ; a = $01
  1305  14c2 85a7                                   sta zpA7                                ; zpA7 = $01
  1306  14c4 aea314                                 ldx m1602 + 1                           ; get stored x value (should still be the same?)
  1307  14c7 20c734                                 jsr draw_player                         ; TODO
  1308                          
  1309                          
  1310                          room_14_prep:              
  1311  14ca acf82f                                 ldy current_room + 1                    ; load room number
  1312  14cd c00e                                   cpy #14                                 ; is it #14?
  1313  14cf d005                                   bne room_15_prep                        ; no -> m148A
  1314  14d1 a020                                   ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
  1315  14d3 20ff39                                 jsr wait                                ; was jmp wait before
  1316                          
  1317                          ; ==============================================================================
  1318                          ; ROOM 15 ANIMATION
  1319                          ; MOVEMENT OF THE MONSTER
  1320                          ; ==============================================================================
  1321                          
  1322                          room_15_prep:              
  1323  14d6 c00f                                   cpy #15                                 ; room 15?
  1324  14d8 d03a                                   bne room_17_prep                        ; no -> m14C8
  1325  14da a900                                   lda #$00                                ; 
  1326  14dc 85a7                                   sta zpA7
  1327  14de a00c                                   ldy #$0c                                ; x/y pos of the monster
  1328  14e0 a206               m1494:              ldx #$06
  1329  14e2 20c734                                 jsr draw_player
  1330  14e5 a9eb                                   lda #$eb                                ; the monster (try 9c for Belegro)
  1331  14e7 85a8                                   sta zpA8
  1332  14e9 a939                                   lda #$39                                ; color of the monster's cape
  1333  14eb 850a                                   sta zp0A
  1334  14ed aee114                                 ldx m1494 + 1                           ; self mod the x position of the monster
  1335  14f0 a901               m14A4:              lda #$01
  1336  14f2 d00a                                   bne m14B2               
  1337  14f4 e006                                   cpx #$06                                ; moved 6 steps?
  1338  14f6 d002                                   bne +                                   ; no, keep moving
  1339  14f8 a901                                   lda #$01
  1340  14fa ca                 +                   dex
  1341  14fb 4c0515                                 jmp +                                   ; change direction
  1342                          
  1343                          m14B2:              
  1344  14fe e00b                                   cpx #$0b
  1345  1500 d002                                   bne ++
  1346  1502 a900                                   lda #$00
  1347  1504 e8                 ++                  inx
  1348  1505 8ee114             +                   stx m1494 + 1
  1349  1508 8df114                                 sta m14A4 + 1
  1350  150b a901                                   lda #$01
  1351  150d 85a7                                   sta zpA7
  1352  150f a00c                                   ldy #$0c
  1353  1511 4cc734                                 jmp draw_player
  1354                                             
  1355                          ; ==============================================================================
  1356                          ; ROOM 17 ANIMATION
  1357                          ;
  1358                          ; ==============================================================================
  1359                          
  1360                          room_17_prep:              
  1361  1514 c011                                   cpy #17                             ; room number 17?
  1362  1516 d014                                   bne +                               ; no -> +
  1363  1518 a901               m14CC:              lda #$01                            ; selfmod
  1364  151a f021                                   beq ++                              
  1365                                                                                 
  1366                                              ; was moved here
  1367                                              ; as it was called only from this place
  1368                                              ; jmp m15C1  
  1369  151c a900               m15C1:              lda #$00                            ; a = 0 (selfmod)
  1370  151e c900                                   cmp #$00                            ; is a = 0?
  1371  1520 d004                                   bne skipper                         ; not 0 -> 15CB
  1372  1522 ee1d15                                 inc m15C1 + 1                       ; inc m15C1
  1373  1525 60                                     rts
  1374                                       
  1375  1526 ce1d15             skipper:            dec m15C1 + 1                       ; dec $15c2
  1376  1529 4cb335                                 jmp belegro_animation
  1377                          
  1378  152c a90f               +                   lda #$0f                            ; a = $0f
  1379  152e 8db835                                 sta m3624 + 1                       ; selfmod
  1380  1531 8dba35                                 sta m3626 + 1                       ; selfmod
  1381                          
  1382                          
  1383  1534 c00a                                   cpy #10                             ; room number 10?
  1384  1536 d044                                   bne check_if_room_09                ; no -> m1523
  1385  1538 ceb82f                                 dec speed_byte                      ; yes, reduce speed
  1386  153b f001                                   beq laser_beam_animation            ; if positive -> laser_beam_animation            
  1387  153d 60                 ++                  rts
  1388                          
  1389                          ; ==============================================================================
  1390                          ; ROOM 10
  1391                          ; LASER BEAM ANIMATION
  1392                          ; ==============================================================================
  1393                          
  1394                          laser_beam_animation:
  1395                                             
  1396  153e a008                                   ldy #$08                            ; speed of the laser flashing
  1397  1540 8cb82f                                 sty speed_byte                      ; store     
  1398  1543 a9d9                                   lda #$d9
  1399  1545 8505                                   sta zp05                            ; affects the colram of the laser
  1400  1547 a905                                   lda #$05                            ; but not understood yet
  1401  1549 8503                                   sta zp03
  1402  154b a97b                                   lda #$7b                            ; position of the laser
  1403  154d 8502                                   sta zp02
  1404  154f 8504                                   sta zp04
  1405  1551 a9df                                   lda #$df                            ; laser beam off
  1406  1553 cd6015                                 cmp m1506 + 1                       
  1407  1556 d002                                   bne +                               
  1408  1558 a9d8                                   lda #$d8                            ; laser beam character
  1409  155a 8d6015             +                   sta m1506 + 1                       
  1410  155d a206                                   ldx #$06                            ; 6 laser beam characters
  1411  155f a9df               m1506:              lda #$df
  1412  1561 a000                                   ldy #$00
  1413  1563 9102                                   sta (zp02),y
  1414  1565 a9ee                                   lda #$ee
  1415  1567 9104                                   sta (zp04),y
  1416  1569 a502                                   lda zp02
  1417  156b 18                                     clc
  1418  156c 6928                                   adc #$28                            ; draws the laser beam
  1419  156e 8502                                   sta zp02
  1420  1570 8504                                   sta zp04
  1421  1572 9004                                   bcc +                               
  1422  1574 e603                                   inc zp03
  1423  1576 e605                                   inc zp05
  1424  1578 ca                 +                   dex
  1425  1579 d0e4                                   bne m1506                           
  1426  157b 60                 -                   rts
  1427                          
  1428                          ; ==============================================================================
  1429                          
  1430                          check_if_room_09:              
  1431  157c c009                                   cpy #09                         ; room number 09?
  1432  157e f001                                   beq room_09_counter                           ; yes -> +
  1433  1580 60                                     rts                             ; no
  1434                          
  1435                          room_09_counter:
  1436  1581 a201                                   ldx #$01                                ; x = 1 (selfmod)
  1437  1583 e001                                   cpx #$01                                ; is x = 1?
  1438  1585 f003                                   beq +                                   ; yes -> +
  1439  1587 4ca215                                 jmp boris_the_spider_animation          ; no, jump boris animation
  1440  158a ce8215             +                   dec room_09_counter + 1                 ; decrease initial x
  1441  158d 60                                     rts
  1442                          
  1443                          ; ==============================================================================
  1444                          ;
  1445                          ; I moved this out of the main loop and call it once when changing rooms
  1446                          ; TODO: call it only when room 4 is entered
  1447                          ; ==============================================================================
  1448                          
  1449                          room_04_prep_door:
  1450                                              
  1451  158e adf82f                                 lda current_room + 1                            ; get current room
  1452  1591 c904                                   cmp #04                                         ; is it 4? (coffins)
  1453  1593 d00c                                   bne ++                                          ; nope
  1454  1595 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  1455  1597 ac0339                                 ldy m394A + 1                                   ; 
  1456  159a f002                                   beq +
  1457  159c a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  1458  159e 8df904             +                   sta SCREENRAM + $f9 
  1459  15a1 60                 ++                  rts
  1460                          
  1461                          ; ==============================================================================
  1462                          ; ROOM 09
  1463                          ; BORIS THE SPIDER ANIMATION
  1464                          ; ==============================================================================
  1465                          
  1466                          boris_the_spider_animation:
  1467                          
  1468  15a2 ee8215                                 inc room_09_counter + 1                           
  1469  15a5 a9d8                                   lda #>COLRAM + 1                               ; affects the color ram position for boris the spider
  1470  15a7 8505                                   sta zp05
  1471  15a9 a904                                   lda #>SCREENRAM
  1472  15ab 8503                                   sta zp03
  1473  15ad a90f                                   lda #$0f
  1474  15af 8502                                   sta zp02
  1475  15b1 8504                                   sta zp04
  1476  15b3 a206               m1535:              ldx #$06
  1477  15b5 a900               m1537:              lda #$00
  1478  15b7 d009                                   bne +
  1479  15b9 ca                                     dex
  1480  15ba e002                                   cpx #$02
  1481  15bc d00b                                   bne ++
  1482  15be a901                                   lda #$01
  1483  15c0 d007                                   bne ++
  1484  15c2 e8                 +                   inx
  1485  15c3 e007                                   cpx #$07
  1486  15c5 d002                                   bne ++
  1487  15c7 a900                                   lda #$00
  1488  15c9 8db615             ++                  sta m1537 + 1
  1489  15cc 8eb415                                 stx m1535 + 1
  1490  15cf a000               -                   ldy #$00
  1491  15d1 a9df                                   lda #$df
  1492  15d3 9102                                   sta (zp02),y
  1493  15d5 c8                                     iny
  1494  15d6 c8                                     iny
  1495  15d7 9102                                   sta (zp02),y
  1496  15d9 88                                     dey
  1497  15da a9ea                                   lda #$ea
  1498  15dc 9102                                   sta (zp02),y
  1499  15de 9104                                   sta (zp04),y
  1500  15e0 201b16                                 jsr move_boris                       
  1501  15e3 ca                                     dex
  1502  15e4 d0e9                                   bne -
  1503  15e6 a9e4                                   lda #$e4
  1504  15e8 85a8                                   sta zpA8
  1505  15ea a202                                   ldx #$02
  1506  15ec a000               --                  ldy #$00
  1507  15ee a5a8               -                   lda zpA8
  1508  15f0 9102                                   sta (zp02),y
  1509  15f2 a9da                                   lda #$da
  1510  15f4 9104                                   sta (zp04),y
  1511  15f6 e6a8                                   inc zpA8
  1512  15f8 c8                                     iny
  1513  15f9 c003                                   cpy #$03
  1514  15fb d0f1                                   bne -
  1515  15fd 201b16                                 jsr move_boris                       
  1516  1600 ca                                     dex
  1517  1601 d0e9                                   bne --
  1518  1603 a000                                   ldy #$00
  1519  1605 a9e7                                   lda #$e7
  1520  1607 85a8                                   sta zpA8
  1521  1609 b102               -                   lda (zp02),y
  1522  160b c5a8                                   cmp zpA8
  1523  160d d004                                   bne +
  1524  160f a9df                                   lda #$df
  1525  1611 9102                                   sta (zp02),y
  1526  1613 e6a8               +                   inc zpA8
  1527  1615 c8                                     iny
  1528  1616 c003                                   cpy #$03
  1529  1618 d0ef                                   bne -
  1530  161a 60                                     rts
  1531                          
  1532                          ; ==============================================================================
  1533                          
  1534                          move_boris:
  1535  161b a502                                   lda zp02
  1536  161d 18                                     clc
  1537  161e 6928                                   adc #$28
  1538  1620 8502                                   sta zp02
  1539  1622 8504                                   sta zp04
  1540  1624 9004                                   bcc +                                   
  1541  1626 e603                                   inc zp03
  1542  1628 e605                                   inc zp05
  1543  162a 60                 +                   rts
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
  1556                          
  1557                          
  1558                          
  1559                          
  1560                          
  1561                          
  1562                          
  1563                          
  1564                          ; ==============================================================================
  1565                          
  1566                          prep_player_pos:
  1567                          
  1568  162b a209                                   ldx #$09
  1569  162d bd4403             -                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
  1570  1630 9d5403                                 sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
  1571  1633 ca                                     dex
  1572  1634 d0f7                                   bne -                                   ; so this seems to create a copy of the area under the player
  1573                          
  1574  1636 a902                                   lda #$02                                ; a = 2
  1575  1638 85a7                                   sta zpA7
  1576  163a ae4235                                 ldx player_pos_x + 1                    ; x = player x
  1577  163d ac4035                                 ldy player_pos_y + 1                    ; y = player y
  1578  1640 20c734                                 jsr draw_player                         ; draw player
  1579  1643 60                                     rts
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
  1593                          
  1594                          
  1595                          
  1596                          
  1597                          
  1598                          
  1599                          
  1600                          
  1601                          ; ==============================================================================
  1602                          ; OBJECT ANIMATION COLLISION ROUTINE
  1603                          ; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
  1604                          ; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
  1605                          ; ==============================================================================
  1606                          
  1607                          object_collision:
  1608                          
  1609  1644 a209                                   ldx #$09                                ; x = 9
  1610                          
  1611                          check_loop:              
  1612                          
  1613  1646 bd4403                                 lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1614  1649 c9d8                                   cmp #$d8                                ; check for laser beam
  1615  164b d005                                   bne +                  
  1616                          
  1617  164d a005               m164E:              ldy #$05
  1618  164f 4ce33a             jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?
  1619                          
  1620  1652 acf82f             +                   ldy current_room + 1                    ; get room number
  1621  1655 c011                                   cpy #17                                 ; is it $11 = #17 (Belegro)?
  1622  1657 d010                                   bne +                                   ; nope -> +
  1623  1659 c978                                   cmp #$78                                ; hit by the stone?
  1624  165b f008                                   beq ++                                  ; yep -> ++
  1625  165d c97b                                   cmp #$7b                                ; or another part of the stone?
  1626  165f f004                                   beq ++                                  ; yes -> ++
  1627  1661 c97e                                   cmp #$7e                                ; or another part of the stone?
  1628  1663 d004                                   bne +                                   ; nah, -> +
  1629  1665 a00b               ++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
  1630  1667 d0e6                                   bne jmp_death
  1631  1669 c99c               +                   cmp #$9c                                ; so Belegro hit you?
  1632  166b 9007                                   bcc m1676
  1633  166d c9a5                                   cmp #$a5
  1634  166f b003                                   bcs m1676
  1635  1671 4ca516                                 jmp m16A7
  1636                          
  1637  1674 c9e4               m1676:              cmp #$e4                                ; hit by Boris the spider?
  1638  1676 9010                                   bcc +                           
  1639  1678 c9eb                                   cmp #$eb
  1640  167a b004                                   bcs ++                          
  1641  167c a004               -                   ldy #$04                                ; 04 Boris the spider got you and killed you
  1642  167e d0cf                                   bne jmp_death                       
  1643  1680 c9f4               ++                  cmp #$f4
  1644  1682 b004                                   bcs +                           
  1645  1684 a00e                                   ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
  1646  1686 d0c7                                   bne jmp_death                       
  1647  1688 ca                 +                   dex
  1648  1689 d0bb                                   bne check_loop   
  1649                          
  1650                          
  1651                          
  1652  168b a209                                   ldx #$09
  1653  168d bd5403             --                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
  1654  1690 9d4403                                 sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
  1655  1693 c9d8                                   cmp #$d8
  1656  1695 f0b6                                   beq m164E                       
  1657  1697 c9e4                                   cmp #$e4
  1658  1699 9004                                   bcc +                           
  1659  169b c9ea                                   cmp #$ea
  1660  169d 90dd                                   bcc -                           
  1661  169f ca                 +                   dex
  1662  16a0 d0eb                                   bne --                          
  1663  16a2 4cdd11                                 jmp m11E0                     
  1664                          
  1665                          m16A7:
  1666  16a5 acbd37                                 ldy items + $1a7                        ; do you have the sword?
  1667  16a8 c0df                                   cpy #$df
  1668  16aa f004                                   beq +                                   ; yes -> +                        
  1669  16ac a00c                                   ldy #$0c                                ; 0c Belegro killed you!
  1670  16ae d09f                                   bne jmp_death                       
  1671  16b0 a000               +                   ldy #$00
  1672  16b2 8c1915                                 sty m14CC + 1                   
  1673  16b5 4c7416                                 jmp m1676                       
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
  1703                          
  1704                          
  1705                          
  1706                          
  1707                          
  1708                          
  1709                          
  1710                          
  1711                          ; ==============================================================================
  1712                          ; this might be the inventory/ world reset
  1713                          ; puts all items into the level data again
  1714                          ; maybe not. not all characters for e.g. the wirecutter is put back
  1715                          ; addresses are mostly within items.asm address space ( $368a )
  1716                          ; contains color information of the chars
  1717                          ; ==============================================================================
  1718                          
  1719                          reset_items:
  1720  16b8 a9a5                                   lda #$a5                        ; $a5 = lock of the shed
  1721  16ba 8d4e36                                 sta items + $38
  1722                          
  1723  16bd a9a9                                   lda #$a9                        ;
  1724  16bf 8d1e36                                 sta items + $8                  ; gloves
  1725  16c2 a979                                   lda #$79
  1726  16c4 8d1c36                                 sta items + $6                  ; gloves color
  1727                          
  1728  16c7 a9e0                                   lda #$e0                        ; empty char
  1729  16c9 8d2636                                 sta items + $10                 ; invisible key
  1730                          
  1731  16cc a9ac                                   lda #$ac                        ; wirecutter
  1732  16ce 8d2f36                                 sta items + $19
  1733                          
  1734  16d1 a9b8                                   lda #$b8                        ; bottle
  1735  16d3 8d3f36                                 sta items + $29
  1736                          
  1737  16d6 a9b0                                   lda #$b0                        ; ladder
  1738  16d8 8d6336                                 sta items + $4d
  1739  16db a9b5                                   lda #$b5                        ; more ladder
  1740  16dd 8d6e36                                 sta items + $58
  1741                          
  1742  16e0 a95e                                   lda #$5e                        ; seems to be water?
  1743  16e2 8d8a36                                 sta items + $74
  1744                          
  1745  16e5 a9c6                                   lda #$c6                        ; boots in the whatever box
  1746  16e7 8d9a36                                 sta items + $84
  1747                          
  1748  16ea a9c0                                   lda #$c0                        ; shovel
  1749  16ec 8dac36                                 sta items + $96
  1750                          
  1751  16ef a9cc                                   lda #$cc                        ; power outlet
  1752  16f1 8dc236                                 sta items + $ac
  1753                          
  1754  16f4 a9d0                                   lda #$d0                        ; hammer
  1755  16f6 8dd136                                 sta items + $bb
  1756                          
  1757  16f9 a9d2                                   lda #$d2                        ; light bulb
  1758  16fb 8dde36                                 sta items + $c8
  1759                          
  1760  16fe a9d6                                   lda #$d6                        ; nails
  1761  1700 8deb36                                 sta items + $d5
  1762                          
  1763  1703 a900                                   lda #$00                        ; door
  1764  1705 8d4237                                 sta items + $12c
  1765                          
  1766  1708 a9dd                                   lda #$dd                        ; sword
  1767  170a 8dbd37                                 sta items + $1a7
  1768                          
  1769  170d a901                                   lda #$01                        ; -> wrong write, produced selfmod at the wrong place
  1770  170f 8d0339                                 sta m394A + 1                   ; sta items + $2c1
  1771                          
  1772  1712 a901                                   lda #$01                        ; 
  1773  1714 8d9138                                 sta breathing_tube_mod + 1      ; sta items + $30a
  1774                          
  1775  1717 a9f5                                   lda #$f5                        ; fence
  1776  1719 8db538                                 sta delete_fence + 1            ; sta items + $277
  1777                          
  1778  171c a900                                   lda #$00                        ; key in the bottle
  1779  171e 8da212                                 sta key_in_bottle_storage
  1780                          
  1781  1721 a901                                   lda #$01                        ; door
  1782  1723 8d9d14                                 sta m15FC + 1
  1783                          
  1784  1726 a91e                                   lda #$1e
  1785  1728 8da314                                 sta m1602 + 1
  1786                          
  1787  172b a901                                   lda #$01
  1788  172d 8d1915                                 sta m14CC + 1
  1789                          
  1790  1730 a205               m1732:              ldx #$05
  1791  1732 e007                                   cpx #$07
  1792  1734 d002                                   bne +
  1793  1736 a2ff                                   ldx #$ff
  1794  1738 e8                 +                   inx
  1795  1739 8e3117                                 stx m1732 + 1                           ; stx $1733
  1796  173c bd4517                                 lda m1747,x                             ; lda $1747,x
  1797  173f 8d0b39                                 sta m3952 + 1                   ; sta $3953
  1798  1742 4cb030                                 jmp print_title     ; jmp $310d
  1799                                              
  1800                          ; ==============================================================================
  1801                          
  1802                          m1747:
  1803  1745 0207040608010503                       !byte $02, $07, $04, $06, $08, $01, $05, $03
  1804                          
  1805                          
  1806                          m174F:
  1807  174d e00c                                   cpx #$0c
  1808  174f d002                                   bne +
  1809  1751 a949                                   lda #$49
  1810  1753 e00d               +                   cpx #$0d
  1811  1755 d002                                   bne +
  1812  1757 a945                                   lda #$45
  1813  1759 60                 +                   rts
  1814                          
  1815                          
  1816                          
  1817                          screen_win_src:
  1818                                              !if LANGUAGE = EN{
  1819  175a 7040404040404040...                        !bin "includes/screen-win-en.scr"
  1820                                              }
  1821                                              !if LANGUAGE = DE{
  1822                                                  !bin "includes/screen-win-de.scr"
  1823                                              }
  1824                          screen_win_src_end:
  1825                          
  1826                          
  1827                          ; ==============================================================================
  1828                          ;
  1829                          ; PRINT WIN SCREEN
  1830                          ; ==============================================================================
  1831                          
  1832                          print_endscreen:
  1833  1b42 a904                                   lda #>SCREENRAM
  1834  1b44 8503                                   sta zp03
  1835  1b46 a9d8                                   lda #>COLRAM
  1836  1b48 8505                                   sta zp05
  1837  1b4a a900                                   lda #<SCREENRAM
  1838  1b4c 8502                                   sta zp02
  1839  1b4e 8504                                   sta zp04
  1840  1b50 a204                                   ldx #$04
  1841  1b52 a917                                   lda #>screen_win_src
  1842  1b54 85a8                                   sta zpA8
  1843  1b56 a95a                                   lda #<screen_win_src
  1844  1b58 85a7                                   sta zpA7
  1845  1b5a a000                                   ldy #$00
  1846  1b5c b1a7               -                   lda (zpA7),y        ; copy from $175c + y
  1847  1b5e 9102                                   sta (zp02),y        ; to SCREEN
  1848  1b60 a900                                   lda #$00            ; color = BLACK
  1849  1b62 9104                                   sta (zp04),y        ; to COLRAM
  1850  1b64 c8                                     iny
  1851  1b65 d0f5                                   bne -
  1852  1b67 e603                                   inc zp03
  1853  1b69 e605                                   inc zp05
  1854  1b6b e6a8                                   inc zpA8
  1855  1b6d ca                                     dex
  1856  1b6e d0ec                                   bne -
  1857  1b70 a907                                   lda #$07                  ; yellow
  1858  1b72 8d21d0                                 sta BG_COLOR              ; background
  1859  1b75 8d20d0                                 sta BORDER_COLOR          ; und border
  1860  1b78 a5cb               -                   lda $cb                   ; lda #$fd
  1861                                                                        ; sta KEYBOARD_LATCH
  1862                                                                        ; lda KEYBOARD_LATCH
  1863                                                                        ; and #$80           ; WAITKEY?
  1864                                              
  1865  1b7a c93c                                   cmp #$3c                  ; check for space key on C64
  1866  1b7c d0fa                                   bne -
  1867  1b7e 20b030                                 jsr print_title
  1868  1b81 20b030                                 jsr print_title
  1869  1b84 4c423a                                 jmp init
  1870                          
  1871                          
  1872                          ; ==============================================================================
  1873                          ;
  1874                          ; INTRO TEXT SCREEN
  1875                          ; ==============================================================================
  1876                          
  1877                          intro_text:
  1878                          
  1879                          ; instructions screen
  1880                          ; "Search the treasure..."
  1881                          
  1882                          !if LANGUAGE = EN{
  1883  1b87 5305011203082014...!scr "Search the treasure of Ghost Town and   "
  1884  1baf 0f10050e20091420...!scr "open it ! Kill Belegro, the wizard, and "
  1885  1bd7 040f04070520010c...!scr "dodge all other dangers. Don't forget to"
  1886  1bff 15130520010c0c20...!scr "use all the items you'll find during    "
  1887  1c27 190f1512200a0f15...!scr "your journey through 19 amazing hires-  "
  1888  1c4f 0712011008090313...!scr "graphics-rooms! Enjoy the quest and play"
  1889  1c77 091420010701090e...!scr "it again and again and again ...      > "
  1890                          }
  1891                          
  1892                          !if LANGUAGE = DE{
  1893                          !scr "Suchen Sie die Schatztruhe der Geister- "
  1894                          !scr "stadt und oeffnen Sie diese ! Toeten    "
  1895                          !scr "Sie Belegro, den Zauberer und weichen   "
  1896                          !scr "Sie vielen anderen Wesen geschickt aus. "
  1897                          !scr "Bedienen Sie sich an den vielen Gegen-  "
  1898                          !scr "staenden, welche sich in den 19 Bildern "
  1899                          !scr "befinden. Viel Spass !                > "
  1900                          }
  1901                          
  1902                          ; ==============================================================================
  1903                          ;
  1904                          ; DISPLAY INTRO TEXT
  1905                          ; ==============================================================================
  1906                          
  1907                          display_intro_text:
  1908                          
  1909                                              ; i think this part displays the introduction text
  1910                          
  1911  1c9f a904                                   lda #>SCREENRAM       ; lda #$0c
  1912  1ca1 8503                                   sta zp03
  1913  1ca3 a9d8                                   lda #>COLRAM        ; lda #$08
  1914  1ca5 8505                                   sta zp05
  1915  1ca7 a9a0                                   lda #$a0
  1916  1ca9 8502                                   sta zp02
  1917  1cab 8504                                   sta zp04
  1918  1cad a91b                                   lda #>intro_text
  1919  1caf 85a8                                   sta zpA8
  1920  1cb1 a987                                   lda #<intro_text
  1921  1cb3 85a7                                   sta zpA7
  1922  1cb5 a207                                   ldx #$07
  1923  1cb7 a000               --                  ldy #$00
  1924  1cb9 b1a7               -                   lda (zpA7),y
  1925  1cbb 9102                                   sta (zp02),y
  1926  1cbd a968                                   lda #$68
  1927  1cbf 9104                                   sta (zp04),y
  1928  1cc1 c8                                     iny
  1929  1cc2 c028                                   cpy #$28
  1930  1cc4 d0f3                                   bne -
  1931  1cc6 a5a7                                   lda zpA7
  1932  1cc8 18                                     clc
  1933  1cc9 6928                                   adc #$28
  1934  1ccb 85a7                                   sta zpA7
  1935  1ccd 9002                                   bcc +
  1936  1ccf e6a8                                   inc zpA8
  1937  1cd1 a502               +                   lda zp02
  1938  1cd3 18                                     clc
  1939  1cd4 6950                                   adc #$50
  1940  1cd6 8502                                   sta zp02
  1941  1cd8 8504                                   sta zp04
  1942  1cda 9004                                   bcc +
  1943  1cdc e603                                   inc zp03
  1944  1cde e605                                   inc zp05
  1945  1ce0 ca                 +                   dex
  1946  1ce1 d0d4                                   bne --
  1947  1ce3 a900                                   lda #$00
  1948  1ce5 8d21d0                                 sta BG_COLOR
  1949  1ce8 60                                     rts
  1950                          
  1951                          ; ==============================================================================
  1952                          ;
  1953                          ; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
  1954                          ; DECREASES MUSIC VOLUME
  1955                          ; ==============================================================================
  1956                          
  1957                          start_intro:        ;sta KEYBOARD_LATCH
  1958  1ce9 20423b                                 jsr clear                                   ; jsr PRINT_KERNAL
  1959  1cec 209f1c                                 jsr display_intro_text
  1960  1cef 20cb1e                                 jsr check_shift_key
  1961                                              
  1962                                              ;lda #$ba
  1963                                              ;sta music_volume+1                          ; sound volume
  1964  1cf2 60                                     rts
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
  1991                          
  1992                          
  1993                          
  1994                          
  1995                          
  1996                          
  1997                          
  1998                          
  1999                          ; ==============================================================================
  2000                          ; MUSIC
  2001                          ; ==============================================================================
  2002                                              !zone MUSIC

; ******** Source: includes/music_data.asm
     1                          ; music! :)
     2                          
     3                          music_data_voice1:
     4  1cf3 8445434425262526...!byte $84, $45, $43, $44, $25, $26, $25, $26, $27, $24, $4b, $2c, $2d
     5  1d00 2c2d2e2b44252625...!byte $2c, $2d, $2e, $2b, $44, $25, $26, $25, $26, $27, $24, $46, $64, $66, $47, $67
     6  1d10 6746646647676727...!byte $67, $46, $64, $66, $47, $67, $67, $27, $29, $27, $49, $67, $44, $66, $64, $27
     7  1d20 2927496744666432...!byte $29, $27, $49, $67, $44, $66, $64, $32, $35, $32, $50, $6e, $2f, $30, $31, $30
     8  1d30 3132312f2f4f504f...!byte $31, $32, $31, $2f, $2f, $4f, $50, $4f, $2e, $2f, $30, $31, $30, $31, $32, $31
     9  1d40 2f4f6d6b4e6c6a4f...!byte $2f, $4f, $6d, $6b, $4e, $6c, $6a, $4f, $6d, $6b, $4e, $6c, $6a
    10                          
    11                          music_data_voice2:
    12  1d4d 923133             !byte $92, $31, $33
    13  1d50 3131523334333435...!byte $31, $31, $52, $33, $34, $33, $34, $35, $32, $54, $32, $52, $75, $54, $32, $52
    14  1d60 758d8d2c2dce8d8d...!byte $75, $8d, $8d, $2c, $2d, $ce, $8d, $8d, $2c, $2d, $ce, $75, $34, $32, $30, $2e
    15  1d70 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $35, $32, $35, $32, $35, $32, $2e
    16  1d80 2d2f303130313231...!byte $2d, $2f, $30, $31, $30, $31, $32, $31, $32, $4b, $69, $67, $4c, $6a, $68, $4b
    17  1d90 69674c6a68323332...!byte $69, $67, $4c, $6a, $68, $32, $33, $32, $b2, $33, $31, $32, $33, $34, $35, $36
    18  1da0 3533323131323334...!byte $35, $33, $32, $31, $31, $32, $33, $34, $33, $34, $35, $36, $35, $36, $37, $36
    19  1db0 ea                 !byte $ea

; ******** Source: main.asm
  2004                          ; ==============================================================================
  2005                          music_get_data:
  2006  1db1 a000               .voice1_dur_pt:     ldy #$00
  2007  1db3 d01d                                   bne +
  2008  1db5 a940                                   lda #$40
  2009  1db7 8d181e                                 sta music_voice1+1
  2010  1dba 20171e                                 jsr music_voice1
  2011  1dbd a200               .voice1_dat_pt:     ldx #$00
  2012  1dbf bdf31c                                 lda music_data_voice1,x
  2013  1dc2 eebe1d                                 inc .voice1_dat_pt+1
  2014  1dc5 a8                                     tay
  2015  1dc6 291f                                   and #$1f
  2016  1dc8 8d181e                                 sta music_voice1+1
  2017  1dcb 98                                     tya
  2018  1dcc 4a                                     lsr
  2019  1dcd 4a                                     lsr
  2020  1dce 4a                                     lsr
  2021  1dcf 4a                                     lsr
  2022  1dd0 4a                                     lsr
  2023  1dd1 a8                                     tay
  2024  1dd2 88                 +                   dey
  2025  1dd3 8cb21d                                 sty .voice1_dur_pt + 1
  2026  1dd6 a000               .voice2_dur_pt:     ldy #$00
  2027  1dd8 d022                                   bne +
  2028  1dda a940                                   lda #$40
  2029  1ddc 8d401e                                 sta music_voice2 + 1
  2030  1ddf 203f1e                                 jsr music_voice2
  2031  1de2 a200               .voice2_dat_pt:     ldx #$00
  2032  1de4 bd4d1d                                 lda music_data_voice2,x
  2033  1de7 a8                                     tay
  2034  1de8 e8                                     inx
  2035  1de9 e065                                   cpx #$65
  2036  1deb f019                                   beq music_reset
  2037  1ded 8ee31d                                 stx .voice2_dat_pt + 1
  2038  1df0 291f                                   and #$1f
  2039  1df2 8d401e                                 sta music_voice2 + 1
  2040  1df5 98                                     tya
  2041  1df6 4a                                     lsr
  2042  1df7 4a                                     lsr
  2043  1df8 4a                                     lsr
  2044  1df9 4a                                     lsr
  2045  1dfa 4a                                     lsr
  2046  1dfb a8                                     tay
  2047  1dfc 88                 +                   dey
  2048  1dfd 8cd71d                                 sty .voice2_dur_pt + 1
  2049  1e00 20171e                                 jsr music_voice1
  2050  1e03 4c3f1e                                 jmp music_voice2
  2051                          ; ==============================================================================
  2052  1e06 a900               music_reset:        lda #$00
  2053  1e08 8db21d                                 sta .voice1_dur_pt + 1
  2054  1e0b 8dbe1d                                 sta .voice1_dat_pt + 1
  2055  1e0e 8dd71d                                 sta .voice2_dur_pt + 1
  2056  1e11 8de31d                                 sta .voice2_dat_pt + 1
  2057  1e14 4cb11d                                 jmp music_get_data
  2058                          ; ==============================================================================
  2059                          ; write music data for voice1 / voice2 into TED registers
  2060                          ; ==============================================================================
  2061  1e17 a204               music_voice1:       ldx #$04
  2062  1e19 e01c                                   cpx #$1c
  2063  1e1b 9008                                   bcc +
  2064  1e1d ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2065  1e20 29ef                                   and #$ef
  2066  1e22 4c3b1e                                 jmp writeFF11
  2067  1e25 bd671e             +                   lda freq_tab_lo,x
  2068  1e28 8d0eff                                 sta VOICE1_FREQ_LOW
  2069  1e2b ad12ff                                 lda VOICE1
  2070  1e2e 29fc                                   and #$fc
  2071  1e30 1d7f1e                                 ora freq_tab_hi, x
  2072  1e33 8d12ff                                 sta VOICE1
  2073  1e36 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2074  1e39 0910                                   ora #$10
  2075  1e3b 8d11ff             writeFF11           sta VOLUME_AND_VOICE_SELECT
  2076  1e3e 60                                     rts
  2077                          ; ==============================================================================
  2078  1e3f a20d               music_voice2:       ldx #$0d
  2079  1e41 e01c                                   cpx #$1c
  2080  1e43 9008                                   bcc +
  2081  1e45 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2082  1e48 29df                                   and #$df
  2083  1e4a 4c3b1e                                 jmp writeFF11
  2084  1e4d bd671e             +                   lda freq_tab_lo,x
  2085  1e50 8d0fff                                 sta VOICE2_FREQ_LOW
  2086  1e53 ad10ff                                 lda VOICE2
  2087  1e56 29fc                                   and #$fc
  2088  1e58 1d7f1e                                 ora freq_tab_hi,x
  2089  1e5b 8d10ff                                 sta VOICE2
  2090  1e5e ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2091  1e61 0920                                   ora #$20
  2092  1e63 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2093  1e66 60                                     rts
  2094                          ; ==============================================================================
  2095                          ; TED frequency tables
  2096                          ; ==============================================================================
  2097  1e67 0776a906597fc5     freq_tab_lo:        !byte $07, $76, $a9, $06, $59, $7f, $c5
  2098  1e6e 043b5483adc0e3                         !byte $04, $3b, $54, $83, $ad, $c0, $e3
  2099  1e75 021e2a42566071                         !byte $02, $1e, $2a, $42, $56, $60, $71
  2100  1e7c 818f95                                 !byte $81, $8f, $95
  2101  1e7f 00000001010101     freq_tab_hi:        !byte $00, $00, $00, $01, $01, $01, $01
  2102  1e86 02020202020202                         !byte $02, $02, $02, $02, $02, $02, $02
  2103  1e8d 03030303030303                         !byte $03, $03, $03, $03, $03, $03, $03
  2104  1e94 030303                                 !byte $03, $03, $03
  2105                          ; ==============================================================================
  2106                                              MUSIC_DELAY_INITIAL   = $09
  2107                                              MUSIC_DELAY           = $0B
  2108  1e97 a209               music_play:         ldx #MUSIC_DELAY_INITIAL
  2109  1e99 ca                                     dex
  2110  1e9a 8e981e                                 stx music_play+1
  2111  1e9d f001                                   beq +
  2112  1e9f 60                                     rts
  2113  1ea0 a20b               +                   ldx #MUSIC_DELAY
  2114  1ea2 8e981e                                 stx music_play+1
  2115  1ea5 ad11ff                                 lda VOLUME_AND_VOICE_SELECT
  2116  1ea8 0937                                   ora #$37
  2117  1eaa 29bf               music_volume:       and #$bf
  2118  1eac 8d11ff                                 sta VOLUME_AND_VOICE_SELECT
  2119  1eaf 4cb11d                                 jmp music_get_data
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
  2144                          
  2145                          
  2146                          
  2147                          
  2148                          
  2149                          
  2150                          
  2151                          
  2152                          ; ==============================================================================
  2153                          ; irq init
  2154                          ; ==============================================================================
  2155                                              !zone IRQ
  2156  1eb2 78                 irq_init0:          sei
  2157  1eb3 a9d2                                   lda #<irq0          ; lda #$06
  2158  1eb5 8d1403                                 sta $0314          ; irq lo
  2159  1eb8 a91e                                   lda #>irq0          ; lda #$1f
  2160  1eba 8d1503                                 sta $0315          ; irq hi
  2161                                                                  ; irq at $1F06
  2162  1ebd a901                                   lda #$01            ;lda #$02
  2163  1ebf 8d1ad0                                 sta $d01a           ; sta FF0A          ; set IRQ source to RASTER
  2164                          
  2165  1ec2 a9bf                                   lda #$bf
  2166  1ec4 8dab1e                                 sta music_volume+1         ; sta $1ed9    ; sound volume
  2167  1ec7 58                                     cli
  2168                          
  2169  1ec8 4c263a                                 jmp set_charset_and_screen
  2170                          
  2171                          ; ==============================================================================
  2172                          ; intro text
  2173                          ; wait for shift or joy2 fire press
  2174                          ; ==============================================================================
  2175                          
  2176                          check_shift_key:
  2177                          
  2178  1ecb a5cb               -                   lda $cb
  2179  1ecd c93c                                   cmp #$3c
  2180  1ecf d0fa                                   bne -
  2181  1ed1 60                                     rts
  2182                          
  2183                          ; ==============================================================================
  2184                          ;
  2185                          ; INTERRUPT routine for music
  2186                          ; ==============================================================================
  2187                          
  2188                                              ; *= $1F06
  2189                          irq0:
  2190  1ed2 ce09ff                                 DEC INTERRUPT
  2191                          
  2192                                                                  ; this IRQ seems to handle music only!
  2193                                              !if SILENT_MODE = 1 {
  2194                                                  jsr fake
  2195                                              } else {
  2196  1ed5 20971e                                     jsr music_play
  2197                                              }
  2198  1ed8 68                                     pla
  2199  1ed9 a8                                     tay
  2200  1eda 68                                     pla
  2201  1edb aa                                     tax
  2202  1edc 68                                     pla
  2203  1edd 40                                     rti
  2204                          
  2205                          ; ==============================================================================
  2206                          ; checks if the music volume is at the desired level
  2207                          ; and increases it if not
  2208                          ; if volume is high enough, it initializes the music irq routine
  2209                          ; is called right at the start of the game, but also when a game ended
  2210                          ; and is about to show the title screen again (increasing the volume)
  2211                          ; ==============================================================================
  2212                          
  2213                          init_music:                                  
  2214  1ede adab1e                                 lda music_volume+1                              ; sound volume
  2215  1ee1 c9bf               --                  cmp #$bf                                        ; is true on init
  2216  1ee3 d003                                   bne +
  2217  1ee5 4cb21e                                 jmp irq_init0
  2218  1ee8 a204               +                   ldx #$04
  2219  1eea 86a8               -                   stx zpA8                                        ; buffer serial input byte ?
  2220  1eec a0ff                                   ldy #$ff
  2221  1eee 20ff39                                 jsr wait
  2222  1ef1 a6a8                                   ldx zpA8
  2223  1ef3 ca                                     dex
  2224  1ef4 d0f4                                   bne -                                               
  2225  1ef6 18                                     clc
  2226  1ef7 6901                                   adc #$01                                        ; increases volume again before returning to title screen
  2227  1ef9 8dab1e                                 sta music_volume+1                              ; sound volume
  2228  1efc 4ce11e                                 jmp --
  2229                          
  2230                          
  2231                          
  2232                                              ; 222222222222222         000000000          000000000          000000000
  2233                                              ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
  2234                                              ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2235                                              ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2236                                              ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2237                                              ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2238                                              ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2239                                              ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2240                                              ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
  2241                                              ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2242                                              ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
  2243                                              ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
  2244                                              ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
  2245                                              ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
  2246                                              ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
  2247                                              ;22222222222222222222     000000000          000000000          000000000
  2248                          
  2249                          ; ==============================================================================
  2250                          ; CHARSET
  2251                          ; $2000 - $2800
  2252                          ; ==============================================================================
  2253                          
  2254                          
  2255                          charset_start:
  2256                                              *= $2000
  2257                                              !if EXTENDED {
  2258                                                  !bin "includes/charset-new-charset.bin"
  2259                                              }else{
  2260  2000 000000020a292727...                        !bin "includes/charset.bin"
  2261                                              }
  2262                          charset_end:    ; $2800
  2263                          
  2264                          
  2265                                              ; 222222222222222         888888888          000000000           000000000
  2266                                              ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
  2267                                              ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
  2268                                              ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2269                                              ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2270                                              ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2271                                              ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
  2272                                              ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2273                                              ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
  2274                                              ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2275                                              ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
  2276                                              ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
  2277                                              ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
  2278                                              ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
  2279                                              ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
  2280                                              ;22222222222222222222     888888888           000000000           000000000
  2281                          
  2282                          
  2283                          
  2284                          ; ==============================================================================
  2285                          ; LEVEL DATA
  2286                          ; Based on tiles
  2287                          ;                     !IMPORTANT!
  2288                          ;                     has to be page aligned or
  2289                          ;                     display_room routine will fail
  2290                          ; ==============================================================================
  2291                          
  2292                                              *= $2800
  2293                          level_data:

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
  2295                          level_data_end:
  2296                          
  2297                          
  2298                          ;$2fbf
  2299                          speed_byte:
  2300  2fb8 01                 !byte $01
  2301                          
  2302                          
  2303                          
  2304                          
  2305                          
  2306                          ; ==============================================================================
  2307                          ;
  2308                          ;
  2309                          ; ==============================================================================
  2310                                  
  2311                          
  2312                          rasterpoll_and_other_stuff:
  2313                          
  2314  2fb9 209f35                                 jsr poll_raster
  2315  2fbc 20c039                                 jsr check_door 
  2316  2fbf 4c7d14                                 jmp animation_entrypoint          
  2317                          
  2318                          
  2319                          
  2320                          ; ==============================================================================
  2321                          ;
  2322                          ; tileset definition
  2323                          ; these are the first characters in the charset of each tile.
  2324                          ; example: rocks start at $0c and span 9 characters in total
  2325                          ; ==============================================================================
  2326                          
  2327                          tileset_definition:
  2328                          tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
  2329  2fc2 df0c151e27303942                       !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
  2330                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2331  2fca 4b545d666f78818a                       !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
  2332                                              ;     $10
  2333  2fd2 03                                     !byte $03                                           ; door
  2334                          
  2335                          !if EXTENDED = 0{
  2336                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2337  2fd3 000a0a0e3d7f2a2a                       !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
  2338                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2339  2fdb 1e1e1e3d3d0e2f2f                       !byte $1e, $1e, $1e, $3d, $3d, $0e, $2f, $2f
  2340                                              ;     $10
  2341  2fe3 0a                                     !byte $0a
  2342                          }
  2343                          
  2344                          !if EXTENDED = 1{
  2345                          tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
  2346                                              !byte $00, $39, $2a, $0e, $3d, $7f, $2a, $2a
  2347                                              ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
  2348                                              !byte $1e, $1e, $1e, $3d, $3d, $19, $2f, $2f
  2349                                              ;     $10
  2350                                              !byte $29   
  2351                          }
  2352                          
  2353                          ; ==============================================================================
  2354                          ;
  2355                          ; displays a room based on tiles
  2356                          ; ==============================================================================
  2357                          
  2358                          display_room:       
  2359  2fe4 208b3a                                 jsr draw_border
  2360  2fe7 a900                                   lda #$00
  2361  2fe9 8502                                   sta zp02
  2362  2feb a2d8                                   ldx #>COLRAM        ; HiByte of COLRAM
  2363  2fed 8605                                   stx zp05
  2364  2fef a204                                   ldx #>SCREENRAM     ; HiByte of SCREENRAM
  2365  2ff1 8603                                   stx zp03
  2366  2ff3 a228                                   ldx #>level_data    ; HiByte of level_data
  2367  2ff5 860a                                   stx zp0A            ; in zp0A
  2368  2ff7 a201               current_room:       ldx #$01            ; current_room in X
  2369  2ff9 f00a                                   beq ++              ; if 0 -> skip
  2370  2ffb 18                 -                   clc                 ; else
  2371  2ffc 6968                                   adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
  2372  2ffe 9002                                   bcc +               ; to zp09/zp0A
  2373  3000 e60a                                   inc zp0A            ;
  2374  3002 ca                 +                   dex                 ; X times
  2375  3003 d0f6                                   bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
  2376  3005 8509               ++                  sta zp09            ; LoByte from above
  2377  3007 a000                                   ldy #$00
  2378  3009 84a8                                   sty zpA8
  2379  300b 84a7                                   sty zpA7
  2380  300d b109               m3066:              lda (zp09),y        ; get Tilenumber
  2381  300f aa                                     tax                 ; in X
  2382  3010 bdd32f                                 lda tiles_colors,x  ; get Tilecolor
  2383  3013 8510                                   sta zp10            ; => zp10
  2384  3015 bdc22f                                 lda tiles_chars,x   ; get Tilechar
  2385  3018 8511                                   sta zp11            ; => zp11
  2386  301a a203                                   ldx #$03            ; (3 rows)
  2387  301c a000               --                  ldy #$00
  2388  301e a502               -                   lda zp02            ; LoByte of SCREENRAM pointer
  2389  3020 8504                                   sta zp04            ; LoByte of COLRAM pointer
  2390  3022 a511                                   lda zp11            ; Load Tilechar
  2391  3024 9102                                   sta (zp02),y        ; to SCREENRAM + Y
  2392  3026 a510                                   lda zp10            ; Load Tilecolor
  2393  3028 9104                                   sta (zp04),y        ; to COLRAM + Y
  2394  302a a511                                   lda zp11            ; Load Tilechar again
  2395  302c c9df                                   cmp #$df            ; if empty tile
  2396  302e f002                                   beq +               ; -> skip
  2397  3030 e611                                   inc zp11            ; else: Tilechar + 1
  2398  3032 c8                 +                   iny                 ; Y = Y + 1
  2399  3033 c003                                   cpy #$03            ; Y = 3 ? (Tilecolumns)
  2400  3035 d0e7                                   bne -               ; no -> next Char
  2401  3037 a502                                   lda zp02            ; yes:
  2402  3039 18                                     clc
  2403  303a 6928                                   adc #$28            ; next SCREEN row
  2404  303c 8502                                   sta zp02
  2405  303e 9004                                   bcc +
  2406  3040 e603                                   inc zp03
  2407  3042 e605                                   inc zp05            ; and COLRAM row
  2408  3044 ca                 +                   dex                 ; X = X - 1
  2409  3045 d0d5                                   bne --              ; X != 0 -> next Char
  2410  3047 e6a8                                   inc zpA8            ; else: zpA8 = zpA8 + 1
  2411  3049 e6a7                                   inc zpA7            ; zpA7 = zpA7 + 1
  2412  304b a975                                   lda #$75            ; for m30B8 + 1
  2413  304d a6a8                                   ldx zpA8
  2414  304f e00d                                   cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
  2415  3051 900c                                   bcc +               ; yes: -> skip (-$75 for next Tile)
  2416  3053 a6a7                                   ldx zpA7            ; else:
  2417  3055 e066                                   cpx #$66            ; zpA7 >= $66
  2418  3057 b01c                                   bcs display_door    ; yes: display_door
  2419  3059 a900                                   lda #$00            ; else:
  2420  305b 85a8                                   sta zpA8            ; clear zpA8
  2421  305d a924                                   lda #$24            ; for m30B8 + 1
  2422  305f 8d6630             +                   sta m30B8 + 1       ;
  2423  3062 a502                                   lda zp02
  2424  3064 38                                     sec
  2425  3065 e975               m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
  2426  3067 8502                                   sta zp02
  2427  3069 b004                                   bcs +
  2428  306b c603                                   dec zp03
  2429  306d c605                                   dec zp05
  2430  306f a4a7               +                   ldy zpA7
  2431  3071 4c0d30                                 jmp m3066
  2432  3074 60                                     rts                 ; will this ever be used?
  2433                          
  2434  3075 a904               display_door:       lda #>SCREENRAM
  2435  3077 8503                                   sta zp03
  2436  3079 a9d8                                   lda #>COLRAM
  2437  307b 8505                                   sta zp05
  2438  307d a900                                   lda #$00
  2439  307f 8502                                   sta zp02
  2440  3081 8504                                   sta zp04
  2441  3083 a028               -                   ldy #$28
  2442  3085 b102                                   lda (zp02),y        ; read from SCREENRAM
  2443  3087 c906                                   cmp #$06            ; $06 (part from Door?)
  2444  3089 b00b                                   bcs +               ; >= $06 -> skip
  2445  308b 38                                     sec                 ; else:
  2446  308c e903                                   sbc #$03            ; subtract $03
  2447  308e a000                                   ldy #$00            ; set Y = $00
  2448  3090 9102                                   sta (zp02),y        ; and copy to one row above
  2449  3092 a90a                                   lda #$0a            ; lda #$39 ; color brown - luminance $3  -> color of the top of a door
  2450  3094 9104                                   sta (zp04),y
  2451  3096 a502               +                   lda zp02
  2452  3098 18                                     clc
  2453  3099 6901                                   adc #$01            ; add 1 to SCREENRAM pointer low
  2454  309b 9004                                   bcc +
  2455  309d e603                                   inc zp03            ; inc pointer HiBytes if necessary
  2456  309f e605                                   inc zp05
  2457  30a1 8502               +                   sta zp02
  2458  30a3 8504                                   sta zp04
  2459  30a5 c998                                   cmp #$98            ; SCREENRAM pointer low = $98
  2460  30a7 d0da                                   bne -               ; no -> loop
  2461  30a9 a503                                   lda zp03            ; else:
  2462  30ab c907                                   cmp #>(SCREENRAM+$300)
  2463  30ad d0d4                                   bne -               ; no -> loop
  2464  30af 60                                     rts                 ; else: finally ready with room display
  2465                          
  2466                          ; ==============================================================================
  2467                          
  2468  30b0 a904               print_title:        lda #>SCREENRAM
  2469  30b2 8503                                   sta zp03
  2470  30b4 a9d8                                   lda #>COLRAM
  2471  30b6 8505                                   sta zp05
  2472  30b8 a900                                   lda #<SCREENRAM
  2473  30ba 8502                                   sta zp02
  2474  30bc 8504                                   sta zp04
  2475  30be a930                                   lda #>screen_start_src
  2476  30c0 85a8                                   sta zpA8
  2477  30c2 a9df                                   lda #<screen_start_src
  2478  30c4 85a7                                   sta zpA7
  2479  30c6 a204                                   ldx #$04
  2480  30c8 a000               --                  ldy #$00
  2481  30ca b1a7               -                   lda (zpA7),y        ; $313C + Y ( Titelbild )
  2482  30cc 9102                                   sta (zp02),y        ; nach SCREEN
  2483  30ce a900                                   lda #$00           ; BLACK
  2484  30d0 9104                                   sta (zp04),y        ; nach COLRAM
  2485  30d2 c8                                     iny
  2486  30d3 d0f5                                   bne -
  2487  30d5 e603                                   inc zp03
  2488  30d7 e605                                   inc zp05
  2489  30d9 e6a8                                   inc zpA8
  2490  30db ca                                     dex
  2491  30dc d0ea                                   bne --
  2492  30de 60                                     rts
  2493                          
  2494                          ; ==============================================================================
  2495                          ; TITLE SCREEN DATA
  2496                          ;
  2497                          ; ==============================================================================
  2498                          
  2499                          screen_start_src:
  2500                          
  2501                                              !if EXTENDED {
  2502                                                  !bin "includes/screen-start-extended.scr"
  2503                                              }else{
  2504  30df 20202020202020a0...                        !bin "includes/screen-start.scr"
  2505                                              }
  2506                          
  2507                          screen_start_src_end:
  2508                          
  2509                          
  2510                          ; ==============================================================================
  2511                          ; i think this might be the draw routine for the player sprite
  2512                          ;
  2513                          ; ==============================================================================
  2514                          
  2515                          
  2516                          draw_player:
  2517  34c7 8eea34                                 stx m3548 + 1                       ; store x pos of player
  2518  34ca a9d8                                   lda #>COLRAM                        ; store colram high in zp05
  2519  34cc 8505                                   sta zp05
  2520  34ce a904                                   lda #>SCREENRAM                     ; store screenram high in zp03
  2521  34d0 8503                                   sta zp03
  2522  34d2 a900                                   lda #$00
  2523  34d4 8502                                   sta zp02
  2524  34d6 8504                                   sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
  2525  34d8 c000                                   cpy #$00                            ; Y is probably the player Y position
  2526  34da f00c                                   beq +                               ; Y is 0 -> +
  2527  34dc 18                 -                   clc                                 ; Y not 0
  2528  34dd 6928                                   adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
  2529  34df 9004                                   bcc ++                              ; <256? -> ++
  2530  34e1 e603                                   inc zp03
  2531  34e3 e605                                   inc zp05
  2532  34e5 88                 ++                  dey                                 ; Y = Y - 1
  2533  34e6 d0f4                                   bne -                               ; Y = 0 ? -> -
  2534  34e8 18                 +                   clc                                 ;
  2535  34e9 6916               m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
  2536  34eb 8502                                   sta zp02
  2537  34ed 8504                                   sta zp04
  2538  34ef 9004                                   bcc +
  2539  34f1 e603                                   inc zp03
  2540  34f3 e605                                   inc zp05
  2541  34f5 a203               +                   ldx #$03                            ; draw 3 rows for the player "sprite"
  2542  34f7 a900                                   lda #$00
  2543  34f9 8509                                   sta zp09
  2544  34fb a000               --                  ldy #$00
  2545  34fd a5a7               -                   lda zpA7
  2546  34ff d006                                   bne +
  2547  3501 a9df                                   lda #$df                            ; empty char, but not sure why
  2548  3503 9102                                   sta (zp02),y
  2549  3505 d01b                                   bne ++
  2550  3507 c901               +                   cmp #$01
  2551  3509 d00a                                   bne +
  2552  350b a5a8                                   lda zpA8
  2553  350d 9102                                   sta (zp02),y
  2554  350f a50a                                   lda zp0A
  2555  3511 9104                                   sta (zp04),y
  2556  3513 d00d                                   bne ++
  2557  3515 b102               +                   lda (zp02),y
  2558  3517 8610                                   stx zp10
  2559  3519 a609                                   ldx zp09
  2560  351b 9d4503                                 sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
  2561  351e e609                                   inc zp09
  2562  3520 a610                                   ldx zp10
  2563  3522 e6a8               ++                  inc zpA8
  2564  3524 c8                                     iny
  2565  3525 c003                                   cpy #$03                            ; width of the player sprite in characters (3)
  2566  3527 d0d4                                   bne -
  2567  3529 a502                                   lda zp02
  2568  352b 18                                     clc
  2569  352c 6928                                   adc #$28                            ; $28 = #40, draws one row of the player under each other
  2570  352e 8502                                   sta zp02
  2571  3530 8504                                   sta zp04
  2572  3532 9004                                   bcc +
  2573  3534 e603                                   inc zp03
  2574  3536 e605                                   inc zp05
  2575  3538 ca                 +                   dex
  2576  3539 d0c0                                   bne --
  2577  353b 60                                     rts
  2578                          
  2579                          
  2580                          ; ==============================================================================
  2581                          ; $359b
  2582                          ; JOYSTICK CONTROLS
  2583                          ; ==============================================================================
  2584                          
  2585                          check_joystick:
  2586                          
  2587                                              ;lda #$fd
  2588                                              ;sta KEYBOARD_LATCH
  2589                                              ;lda KEYBOARD_LATCH
  2590  353c ad00dc                                 lda $dc00
  2591  353f a009               player_pos_y:       ldy #$09
  2592  3541 a215               player_pos_x:       ldx #$15
  2593  3543 4a                                     lsr
  2594  3544 b005                                   bcs +
  2595  3546 c000                                   cpy #$00
  2596  3548 f001                                   beq +
  2597  354a 88                                     dey                                           ; JOYSTICK UP
  2598  354b 4a                 +                   lsr
  2599  354c b005                                   bcs +
  2600  354e c015                                   cpy #$15
  2601  3550 b001                                   bcs +
  2602  3552 c8                                     iny                                           ; JOYSTICK DOWN
  2603  3553 4a                 +                   lsr
  2604  3554 b005                                   bcs +
  2605  3556 e000                                   cpx #$00
  2606  3558 f001                                   beq +
  2607  355a ca                                     dex                                           ; JOYSTICK LEFT
  2608  355b 4a                 +                   lsr
  2609  355c b005                                   bcs +
  2610  355e e024                                   cpx #$24
  2611  3560 b001                                   bcs +
  2612  3562 e8                                     inx                                           ; JOYSTICK RIGHT
  2613  3563 8c8135             +                   sty m35E7 + 1
  2614  3566 8e8635                                 stx m35EC + 1
  2615  3569 a902                                   lda #$02
  2616  356b 85a7                                   sta zpA7
  2617  356d 20c734                                 jsr draw_player
  2618  3570 a209                                   ldx #$09
  2619  3572 bd4403             -                   lda TAPE_BUFFER + $8,x
  2620  3575 c9df                                   cmp #$df
  2621  3577 f004                                   beq +
  2622  3579 c9e2                                   cmp #$e2
  2623  357b d00d                                   bne ++
  2624  357d ca                 +                   dex
  2625  357e d0f2                                   bne -
  2626  3580 a90a               m35E7:              lda #$0a
  2627  3582 8d4035                                 sta player_pos_y + 1
  2628  3585 a915               m35EC:              lda #$15
  2629  3587 8d4235                                 sta player_pos_x + 1
  2630                          ++                  ;lda #$ff
  2631                                              ;sta KEYBOARD_LATCH
  2632  358a a901                                   lda #$01
  2633  358c 85a7                                   sta zpA7
  2634  358e a993                                   lda #$93                ; first character of the player graphic
  2635  3590 85a8                                   sta zpA8
  2636  3592 a93d                                   lda #$3d
  2637  3594 850a                                   sta zp0A
  2638  3596 ac4035             get_player_pos:     ldy player_pos_y + 1
  2639  3599 ae4235                                 ldx player_pos_x + 1
  2640                                        
  2641  359c 4cc734                                 jmp draw_player
  2642                          
  2643                          ; ==============================================================================
  2644                          ;
  2645                          ; POLL RASTER
  2646                          ; ==============================================================================
  2647                          
  2648                          poll_raster:
  2649  359f 78                                     sei                     ; disable interrupt
  2650  35a0 a9f0                                   lda #$f0                ; lda #$c0  ;A = $c0
  2651  35a2 cd12d0             -                   cmp FF1D                ; vertical line bits 0-7
  2652                                              
  2653  35a5 d0fb                                   bne -                   ; loop until we hit line c0
  2654  35a7 a900                                   lda #$00                ; A = 0
  2655  35a9 85a7                                   sta zpA7                ; zpA7 = 0
  2656                                              
  2657  35ab 209635                                 jsr get_player_pos
  2658                                              
  2659  35ae 203c35                                 jsr check_joystick
  2660  35b1 58                                     cli
  2661  35b2 60                                     rts
  2662                          
  2663                          
  2664                          ; ==============================================================================
  2665                          ; ROOM 16
  2666                          ; BELEGRO ANIMATION
  2667                          ; ==============================================================================
  2668                          
  2669                          belegro_animation:
  2670                          
  2671  35b3 a900                                   lda #$00
  2672  35b5 85a7                                   sta zpA7
  2673  35b7 a20f               m3624:              ldx #$0f
  2674  35b9 a00f               m3626:              ldy #$0f
  2675  35bb 20c734                                 jsr draw_player
  2676  35be aeb835                                 ldx m3624 + 1
  2677  35c1 acba35                                 ldy m3626 + 1
  2678  35c4 ec4235                                 cpx player_pos_x + 1
  2679  35c7 b002                                   bcs +
  2680  35c9 e8                                     inx
  2681  35ca e8                                     inx
  2682  35cb ec4235             +                   cpx player_pos_x + 1
  2683  35ce f001                                   beq +
  2684  35d0 ca                                     dex
  2685  35d1 cc4035             +                   cpy player_pos_y + 1
  2686  35d4 b002                                   bcs +
  2687  35d6 c8                                     iny
  2688  35d7 c8                                     iny
  2689  35d8 cc4035             +                   cpy player_pos_y + 1
  2690  35db f001                                   beq +
  2691  35dd 88                                     dey
  2692  35de 8ef835             +                   stx m3668 + 1
  2693  35e1 8cfd35                                 sty m366D + 1
  2694  35e4 a902                                   lda #$02
  2695  35e6 85a7                                   sta zpA7
  2696  35e8 20c734                                 jsr draw_player
  2697  35eb a209                                   ldx #$09
  2698  35ed bd4403             -                   lda TAPE_BUFFER + $8,x
  2699  35f0 c992                                   cmp #$92
  2700  35f2 900d                                   bcc +
  2701  35f4 ca                                     dex
  2702  35f5 d0f6                                   bne -
  2703  35f7 a210               m3668:              ldx #$10
  2704  35f9 8eb835                                 stx m3624 + 1
  2705  35fc a00e               m366D:              ldy #$0e
  2706  35fe 8cba35                                 sty m3626 + 1
  2707  3601 a99c               +                   lda #$9c                                ; belegro chars
  2708  3603 85a8                                   sta zpA8
  2709  3605 a93e                                   lda #$3e
  2710  3607 850a                                   sta zp0A
  2711  3609 acba35                                 ldy m3626 + 1
  2712  360c aeb835                                 ldx m3624 + 1                    
  2713  360f a901                                   lda #$01
  2714  3611 85a7                                   sta zpA7
  2715  3613 4cc734                                 jmp draw_player
  2716                          
  2717                          
  2718                          ; ==============================================================================
  2719                          ; items
  2720                          ; This area seems to be responsible for items placement
  2721                          ;
  2722                          ; ==============================================================================
  2723                          
  2724                          items:

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
  2726                          items_end:
  2727                          
  2728                          next_item:
  2729  37c6 a5a7                                   lda zpA7
  2730  37c8 18                                     clc
  2731  37c9 6901                                   adc #$01
  2732  37cb 85a7                                   sta zpA7
  2733  37cd 9002                                   bcc +                       ; bcc $3845
  2734  37cf e6a8                                   inc zpA8
  2735  37d1 60                 +                   rts
  2736                          
  2737                          ; ==============================================================================
  2738                          ; TODO
  2739                          ; no clue yet. level data has already been drawn when this is called
  2740                          ; probably placing the items on the screen
  2741                          ; ==============================================================================
  2742                          
  2743                          update_items_display:
  2744  37d2 a936                                   lda #>items                 ; load address for items into zeropage
  2745  37d4 85a8                                   sta zpA8
  2746  37d6 a916                                   lda #<items
  2747  37d8 85a7                                   sta zpA7
  2748  37da a000                                   ldy #$00                    ; y = 0
  2749  37dc b1a7               --                  lda (zpA7),y                ; load first value
  2750  37de c9ff                                   cmp #$ff                    ; is it $ff?
  2751  37e0 f006                                   beq +                       ; yes -> +
  2752  37e2 20c637             -                   jsr next_item               ; no -> set zero page to next value
  2753  37e5 4cdc37                                 jmp --                      ; and loop
  2754  37e8 20c637             +                   jsr next_item               ; value was $ff, now get the next value in the list
  2755  37eb b1a7                                   lda (zpA7),y
  2756  37ed c9ff                                   cmp #$ff                    ; is the next value $ff again?
  2757  37ef d003                                   bne +
  2758  37f1 4c7638                                 jmp prepare_rooms           ; yes -> m38DF
  2759  37f4 cdf82f             +                   cmp current_room + 1        ; is the number the current room number?
  2760  37f7 d0e9                                   bne -                       ; no -> loop
  2761  37f9 a9d8                                   lda #>COLRAM                ; yes the number is the current room number
  2762  37fb 8505                                   sta zp05                    ; store COLRAM and SCREENRAM in zeropage
  2763  37fd a904                                   lda #>SCREENRAM
  2764  37ff 8503                                   sta zp03
  2765  3801 a900                                   lda #$00                    ; A = 0
  2766  3803 8502                                   sta zp02                    ; zp02 = 0, zp04 = 0
  2767  3805 8504                                   sta zp04
  2768  3807 20c637                                 jsr next_item               ; move to next value
  2769  380a b1a7                                   lda (zpA7),y                ; get next value in the list
  2770  380c c9fe               -                   cmp #$fe                    ; is it $FE?
  2771  380e f00b                                   beq +                       ; yes -> +
  2772  3810 c9f9                                   cmp #$f9                    ; no, is it $f9?
  2773  3812 d00d                                   bne +++                     ; no -> +++
  2774  3814 a502                                   lda zp02                    ; value is $f9
  2775  3816 206e38                                 jsr m38D7                   ; add 1 to zp02 and zp04
  2776  3819 9004                                   bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
  2777  381b e603               +                   inc zp03                    ; value is $fe
  2778  381d e605                                   inc zp05                    ; increase zp03 and zp05
  2779  381f b1a7               ++                  lda (zpA7),y                ; get value from list
  2780  3821 c9fb               +++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
  2781  3823 d009                                   bne +                       ; no -> +
  2782  3825 20c637                                 jsr next_item               ; yes it's $fb, get the next value
  2783  3828 b1a7                                   lda (zpA7),y                ; get value from list
  2784  382a 8509                                   sta zp09                    ; store value in zp09
  2785  382c d028                                   bne ++                      ; if value was 0 -> ++
  2786  382e c9f8               +                   cmp #$f8
  2787  3830 f01c                                   beq +
  2788  3832 c9fc                                   cmp #$fc
  2789  3834 d00d                                   bne +++
  2790  3836 a50a                                   lda zp0A
  2791                                                                          ; jmp m399F
  2792                          
  2793  3838 c9df                                   cmp #$df                    ; this part was moved here as it wasn't called anywhere else
  2794  383a f002                                   beq skip                    ; and I think it was just outsourced for branching length issues
  2795  383c e60a                                   inc zp0A           
  2796  383e b1a7               skip:               lda (zpA7),y        
  2797  3840 4c4e38                                 jmp m38B7
  2798                          
  2799  3843 c9fa               +++                 cmp #$fa
  2800  3845 d00f                                   bne ++
  2801  3847 20c637                                 jsr next_item
  2802  384a b1a7                                   lda (zpA7),y
  2803  384c 850a                                   sta zp0A
  2804                          m38B7:
  2805  384e a509               +                   lda zp09
  2806  3850 9104                                   sta (zp04),y
  2807  3852 a50a                                   lda zp0A
  2808  3854 9102                                   sta (zp02),y
  2809  3856 c9fd               ++                  cmp #$fd
  2810  3858 d009                                   bne +
  2811  385a 20c637                                 jsr next_item
  2812  385d b1a7                                   lda (zpA7),y
  2813  385f 8502                                   sta zp02
  2814  3861 8504                                   sta zp04
  2815  3863 20c637             +                   jsr next_item
  2816  3866 b1a7                                   lda (zpA7),y
  2817  3868 c9ff                                   cmp #$ff
  2818  386a d0a0                                   bne -
  2819  386c f008                                   beq prepare_rooms
  2820  386e 18                 m38D7:              clc
  2821  386f 6901                                   adc #$01
  2822  3871 8502                                   sta zp02
  2823  3873 8504                                   sta zp04
  2824  3875 60                                     rts
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
  2845                          
  2846                          
  2847                          
  2848                          
  2849                          
  2850                          
  2851                          
  2852                          
  2853                          ; ==============================================================================
  2854                          ; ROOM PREPARATION CHECK
  2855                          ; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
  2856                          ; ==============================================================================
  2857                          
  2858                          prepare_rooms:
  2859                                      
  2860  3876 adf82f                                 lda current_room + 1
  2861                                              
  2862  3879 c902                                   cmp #$02                                ; is the current room 02?
  2863  387b f01d                                   beq room_02_prep
  2864                          
  2865  387d c907                                   cmp #$07
  2866  387f f04c                                   beq room_07_make_sacred_column
  2867                                              
  2868  3881 c906                                   cmp #$06          
  2869  3883 f05a                                   beq room_06_make_deadly_doors
  2870                          
  2871  3885 c904                                   cmp #$04
  2872  3887 f062                                   beq room_04_prep
  2873                          
  2874  3889 c905                                   cmp #$05
  2875  388b f001                                   beq room_05_prep
  2876                          
  2877  388d 60                                     rts
  2878                          
  2879                          
  2880                          
  2881                          ; ==============================================================================
  2882                          ; ROOM 05
  2883                          ; HIDE THE BREATHING TUBE UNDER THE STONE
  2884                          ; ==============================================================================
  2885                          
  2886                          room_05_prep:                  
  2887                                                         
  2888  388e a9fd                                   lda #$fd                                    ; yes
  2889  3890 a201               breathing_tube_mod: ldx #$01
  2890  3892 d002                                   bne +                                       ; based on self mod, put the normal
  2891  3894 a97a                                   lda #$7a                                    ; stone char back again
  2892  3896 8dd206             +                   sta SCREENRAM + $2d2   
  2893  3899 60                                     rts
  2894                          
  2895                          
  2896                          
  2897                          ; ==============================================================================
  2898                          ; ROOM 02 PREP
  2899                          ; 
  2900                          ; ==============================================================================
  2901                          
  2902                          room_02_prep:
  2903  389a a90d                                   lda #$0d                                ; yes room is 02, a = $0d #13
  2904  389c 8502                                   sta zp02                                ; zp02 = $0d
  2905  389e 8504                                   sta zp04                                ; zp04 = $0d
  2906  38a0 a9d8                                   lda #>COLRAM                            ; set colram zp
  2907  38a2 8505                                   sta zp05
  2908  38a4 a904                                   lda #>SCREENRAM                         ; set screenram zp      
  2909  38a6 8503                                   sta zp03
  2910  38a8 a218                                   ldx #$18                                ; x = $18 #24
  2911  38aa b102               -                   lda (zp02),y                            ; y must have been set earlier
  2912  38ac c9df                                   cmp #$df                                ; $df = empty space likely
  2913  38ae f004                                   beq delete_fence                        ; yes, empty -> m3900
  2914  38b0 c9f5                                   cmp #$f5                                ; no, but maybe a $f5? (fence!)
  2915  38b2 d006                                   bne +                                   ; nope -> ++
  2916                          
  2917                          delete_fence:
  2918  38b4 a9f5                                   lda #$f5                                ; A is either $df or $f5 -> selfmod here
  2919  38b6 9102                                   sta (zp02),y                            ; store that value
  2920  38b8 9104                                   sta (zp04),y                            ; in zp02 and zo04
  2921  38ba a502               +                   lda zp02                                ; and load it in again, jeez
  2922  38bc 18                                     clc
  2923  38bd 6928                                   adc #$28                                ; smells like we're going to draw a fence
  2924  38bf 8502                                   sta zp02
  2925  38c1 8504                                   sta zp04
  2926  38c3 9004                                   bcc +             
  2927  38c5 e603                                   inc zp03
  2928  38c7 e605                                   inc zp05
  2929  38c9 ca                 +                   dex
  2930  38ca d0de                                   bne -              
  2931  38cc 60                                     rts
  2932                          
  2933                          ; ==============================================================================
  2934                          ; ROOM 07 PREP
  2935                          ;
  2936                          ; ==============================================================================
  2937                          
  2938                          room_07_make_sacred_column:
  2939                          
  2940                                              
  2941  38cd a217                                   ldx #$17                                    ; yes
  2942  38cf bd6805             -                   lda SCREENRAM + $168,x     
  2943  38d2 c9df                                   cmp #$df
  2944  38d4 d005                                   bne +                       
  2945  38d6 a9e3                                   lda #$e3
  2946  38d8 9d6805                                 sta SCREENRAM + $168,x    
  2947  38db ca                 +                   dex
  2948  38dc d0f1                                   bne -                      
  2949  38de 60                                     rts
  2950                          
  2951                          
  2952                          ; ==============================================================================
  2953                          ; ROOM 06
  2954                          ; PREPARE THE DEADLY DOORS
  2955                          ; ==============================================================================
  2956                          
  2957                          room_06_make_deadly_doors:
  2958                          
  2959                                              
  2960  38df a9f6                                   lda #$f6                                    ; char for wrong door
  2961  38e1 8d9c04                                 sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
  2962  38e4 8d7c06                                 sta SCREENRAM + $27c
  2963  38e7 8d6c07                                 sta SCREENRAM + $36c       
  2964  38ea 60                                     rts
  2965                          
  2966                          ; ==============================================================================
  2967                          ; ROOM 04
  2968                          ; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
  2969                          ; ==============================================================================
  2970                          
  2971                          room_04_prep: 
  2972                          
  2973                          
  2974                                              
  2975  38eb adf82f                                 lda current_room + 1                            ; get current room
  2976  38ee c904                                   cmp #04                                         ; is it 4? (coffins)
  2977  38f0 d00c                                   bne ++                                          ; nope
  2978  38f2 a903                                   lda #$03                                        ; OMG YES! How did you know?? (and get door char)
  2979  38f4 ac0339                                 ldy m394A + 1                                   ; 
  2980  38f7 f002                                   beq +
  2981  38f9 a9f6                                   lda #$f6                                        ; put fake door char in place (making it closed)
  2982  38fb 8df904             +                   sta SCREENRAM + $f9 
  2983                                          
  2984  38fe a2f7               ++                  ldx #$f7                                    ; yes room 04
  2985  3900 a0f8                                   ldy #$f8
  2986  3902 a901               m394A:              lda #$01
  2987  3904 d004                                   bne m3952           
  2988  3906 a23b                                   ldx #$3b
  2989  3908 a042                                   ldy #$42
  2990  390a a901               m3952:              lda #$01                                    ; some self mod here
  2991  390c c901                                   cmp #$01
  2992  390e d003                                   bne +           
  2993  3910 8e7a04                                 stx SCREENRAM+ $7a 
  2994  3913 c902               +                   cmp #$02
  2995  3915 d003                                   bne +           
  2996  3917 8e6a05                                 stx SCREENRAM + $16a   
  2997  391a c903               +                   cmp #$03
  2998  391c d003                                   bne +           
  2999  391e 8e5a06                                 stx SCREENRAM + $25a       
  3000  3921 c904               +                   cmp #$04
  3001  3923 d003                                   bne +           
  3002  3925 8e4a07                                 stx SCREENRAM + $34a   
  3003  3928 c905               +                   cmp #$05
  3004  392a d003                                   bne +           
  3005  392c 8c9c04                                 sty SCREENRAM + $9c    
  3006  392f c906               +                   cmp #$06
  3007  3931 d003                                   bne +           
  3008  3933 8c8c05                                 sty SCREENRAM + $18c   
  3009  3936 c907               +                   cmp #$07
  3010  3938 d003                                   bne +           
  3011  393a 8c7c06                                 sty SCREENRAM + $27c 
  3012  393d c908               +                   cmp #$08
  3013  393f d003                                   bne +           
  3014  3941 8c6c07                                 sty SCREENRAM + $36c   
  3015  3944 60                 +                   rts
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
  3028                          
  3029                          
  3030                          
  3031                          
  3032                          
  3033                          
  3034                          
  3035                          
  3036                          ; ==============================================================================
  3037                          ; PLAYER POSITION TABLE FOR EACH ROOM
  3038                          ; FORMAT: Y left door, X left door, Y right door, X right door
  3039                          ; ==============================================================================
  3040                          
  3041                          player_xy_pos_table:
  3042                          
  3043  3945 06031221           !byte $06, $03, $12, $21                                        ; room 00
  3044  3949 03031221           !byte $03, $03, $12, $21                                        ; room 01
  3045  394d 03031521           !byte $03, $03, $15, $21                                        ; room 02
  3046  3951 03030f21           !byte $03, $03, $0f, $21                                        ; room 03
  3047  3955 151e0606           !byte $15, $1e, $06, $06                                        ; room 04
  3048  3959 06031221           !byte $06, $03, $12, $21                                        ; room 05
  3049  395d 03030921           !byte $03, $03, $09, $21                                        ; room 06
  3050  3961 03031221           !byte $03, $03, $12, $21                                        ; room 07
  3051  3965 03030c21           !byte $03, $03, $0c, $21                                        ; room 08
  3052  3969 03031221           !byte $03, $03, $12, $21                                        ; room 09
  3053  396d 0c030c20           !byte $0c, $03, $0c, $20                                        ; room 10
  3054  3971 0c030c21           !byte $0c, $03, $0c, $21                                        ; room 11
  3055  3975 0c030915           !byte $0c, $03, $09, $15                                        ; room 12
  3056  3979 03030621           !byte $03, $03, $06, $21                                        ; room 13
  3057  397d 03030321           !byte $03, $03, $03, $21                                        ; room 14
  3058  3981 06031221           !byte $06, $03, $12, $21                                        ; room 15
  3059  3985 0303031d           !byte $03, $03, $03, $1d                                        ; room 16
  3060  3989 03030621           !byte $03, $03, $06, $21                                        ; room 17
  3061  398d 0303               !byte $03, $03                                                  ; room 18 (only one door)
  3062                          
  3063                          
  3064                          
  3065                          ; ==============================================================================
  3066                          ; $3a33
  3067                          ; Apparently some lookup table, e.g. to get the 
  3068                          ; ==============================================================================
  3069                          
  3070                          room_player_pos_lookup:
  3071                          
  3072  398f 02060a0e12161a1e...!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
  3073  399f 42464a4e52565a5e...!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
  3074  39af 24282c3034383c40...!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
  3075  39bf 00                 !byte $00
  3076                          
  3077                          
  3078                          
  3079                          
  3080                          
  3081                          
  3082                          
  3083                          
  3084                          
  3085                          
  3086                          
  3087                          ; ==============================================================================
  3088                          ;
  3089                          ;
  3090                          ; ==============================================================================
  3091                          
  3092                          check_door:
  3093                          
  3094  39c0 a209                                   ldx #$09                                    ; set loop to 9
  3095  39c2 bd4403             -                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
  3096  39c5 c905                                   cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
  3097  39c7 f008                                   beq +                                       ; yes -> +
  3098  39c9 c903                                   cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
  3099  39cb f013                                   beq set_player_xy                           ; yes -> m3A17
  3100  39cd ca                                     dex                                         ; decrease loop
  3101  39ce d0f2                                   bne -                                       ; loop
  3102  39d0 60                 -                   rts
  3103                          
  3104  39d1 aef82f             +                   ldx current_room + 1
  3105  39d4 f0fa                                   beq -               
  3106  39d6 ca                                     dex
  3107  39d7 8ef82f                                 stx current_room + 1                        ; update room number                         
  3108  39da bc8f39                                 ldy room_player_pos_lookup,x                ; load        
  3109  39dd 4cea39                                 jmp update_player_pos           
  3110                          
  3111                          set_player_xy:
  3112  39e0 aef82f                                 ldx current_room + 1                            ; x = room number
  3113  39e3 e8                                     inx                                             ; room number ++
  3114  39e4 8ef82f                                 stx current_room + 1                            ; update room number
  3115  39e7 bca639                                 ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room
  3116                          
  3117                          update_player_pos:              
  3118  39ea b94539                                 lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
  3119  39ed 8d4035                                 sta player_pos_y + 1                            ; player y pos = a
  3120  39f0 b94639                                 lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
  3121  39f3 8d4235                                 sta player_pos_x + 1
  3122                          
  3123  39f6 20e42f             m3A2D:              jsr display_room                                ; done  
  3124  39f9 208e15                                 jsr room_04_prep_door                           ; was in main loop before, might find a better place
  3125  39fc 4cd237                                 jmp update_items_display
  3126                          
  3127                          
  3128                          
  3129                          ; ==============================================================================
  3130                          ;
  3131                          ; wait routine
  3132                          ; usually called with Y set before
  3133                          ; ==============================================================================
  3134                          
  3135                          wait:
  3136  39ff ca                                     dex
  3137  3a00 d0fd                                   bne wait
  3138  3a02 88                                     dey
  3139  3a03 d0fa                                   bne wait
  3140  3a05 60                 fake:               rts
  3141                          
  3142                          
  3143                          ; ==============================================================================
  3144                          ; sets the game screen
  3145                          ; multicolor, charset, main colors
  3146                          ; ==============================================================================
  3147                          
  3148                          set_game_basics:
  3149  3a06 ad12ff                                 lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
  3150  3a09 29fb                                   and #$fb                                    ; clear bit 2
  3151  3a0b 8d12ff                                 sta VOICE1                                  ; => get data from RAM
  3152  3a0e a918                                   lda #$18            ;lda #$21
  3153  3a10 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
  3154                                              
  3155                                                                                          ; bit 1 : Single clock set  ( 0 )
  3156                                                                                          ; b.2-7 : character data base address
  3157                                                                                          ; %00100$x ($2000)
  3158  3a13 ad16d0                                 lda FF07
  3159  3a16 0990                                   ora #$90                                    ; multicolor ON - reverse OFF
  3160  3a18 8d16d0                                 sta FF07
  3161                          
  3162                                                                                          ; set the main colors for the game
  3163                          
  3164  3a1b a90a                                   lda #MULTICOLOR_1                           ; original: #$db
  3165  3a1d 8d22d0                                 sta COLOR_1                                 ; char color 1
  3166  3a20 a909                                   lda #MULTICOLOR_2                           ; original: #$29
  3167  3a22 8d23d0                                 sta COLOR_2                                 ; char color 2
  3168                                              
  3169  3a25 60                                     rts
  3170                          
  3171                          ; ==============================================================================
  3172                          ; set font and screen setup (40 columns and hires)
  3173                          ; $3a9d
  3174                          ; ==============================================================================
  3175                          
  3176                          set_charset_and_screen:                               ; set text screen
  3177                                             
  3178  3a26 ad12ff                                 lda VOICE1
  3179  3a29 0904                                   ora #$04                                    ; set bit 2
  3180  3a2b 8d12ff                                 sta VOICE1                                  ; => get data from ROM
  3181  3a2e a917                                   lda #$17                                    ; lda #$d5                                    ; ROM FONT
  3182  3a30 8d18d0                                 sta CHAR_BASE_ADDRESS                       ; set
  3183  3a33 ad16d0                                 lda FF07
  3184  3a36 a908                                   lda #$08                                    ; 40 columns and Multicolor OFF
  3185  3a38 8d16d0                                 sta FF07
  3186  3a3b 60                                     rts
  3187                          
  3188                          test:
  3189  3a3c ee20d0                                 inc BORDER_COLOR
  3190  3a3f 4c3c3a                                 jmp test
  3191                          
  3192                          ; ==============================================================================
  3193                          ; init
  3194                          ; start of game (original $3ab3)
  3195                          ; ==============================================================================
  3196                          
  3197                          code_start:
  3198                          init:
  3199                                              ;jsr init_music           ; TODO
  3200                                              
  3201  3a42 a917                                   lda #$17                  ; set lower case charset
  3202  3a44 8d18d0                                 sta $d018                 ; wasn't on Plus/4 for some reason
  3203                                              
  3204  3a47 a90b                                   lda #$0b
  3205  3a49 8d21d0                                 sta BG_COLOR              ; background color
  3206  3a4c 8d20d0                                 sta BORDER_COLOR          ; border color
  3207  3a4f 20b816                                 jsr reset_items           ; might be a level data reset, and print the title screen
  3208                          
  3209  3a52 a020                                   ldy #$20
  3210  3a54 20ff39                                 jsr wait
  3211                                              
  3212                                              ; waiting for key press on title screen
  3213                          
  3214  3a57 a5cb               -                   lda $cb                   ; zp position of currently pressed key
  3215  3a59 c938                                   cmp #$38                  ; is it the space key?
  3216  3a5b d0fa                                   bne -
  3217                          
  3218                                                                        ; lda #$ff
  3219  3a5d 20e91c                                 jsr start_intro           ; displays intro text, waits for shift/fire and decreases the volume
  3220                                              
  3221                          
  3222                                              ; TODO: unclear what the code below does
  3223                                              ; i think it fills the level data with "DF", which is a blank character
  3224  3a60 a904                                   lda #>SCREENRAM
  3225  3a62 8503                                   sta zp03
  3226  3a64 a900                                   lda #$00
  3227  3a66 8502                                   sta zp02
  3228  3a68 a204                                   ldx #$04
  3229  3a6a a000                                   ldy #$00
  3230  3a6c a9df                                   lda #$df
  3231  3a6e 9102               -                   sta (zp02),y
  3232  3a70 c8                                     iny
  3233  3a71 d0fb                                   bne -
  3234  3a73 e603                                   inc zp03
  3235  3a75 ca                                     dex
  3236  3a76 d0f6                                   bne -
  3237                                              
  3238  3a78 20063a                                 jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors
  3239                          
  3240                                              ; set background color
  3241  3a7b a900                                   lda #$00
  3242  3a7d 8d21d0                                 sta BG_COLOR
  3243                          
  3244                                              ; border color. default is a dark red
  3245  3a80 a902                                   lda #BORDER_COLOR_VALUE
  3246  3a82 8d20d0                                 sta BORDER_COLOR
  3247                                              
  3248  3a85 208b3a                                 jsr draw_border
  3249                                              
  3250  3a88 4cc33a                                 jmp set_start_screen
  3251                          
  3252                          ; ==============================================================================
  3253                          ;
  3254                          ; draws the extended "border"
  3255                          ; ==============================================================================
  3256                          
  3257                          draw_border:        
  3258  3a8b a927                                   lda #$27
  3259  3a8d 8502                                   sta zp02
  3260  3a8f 8504                                   sta zp04
  3261  3a91 a9d8                                   lda #>COLRAM
  3262  3a93 8505                                   sta zp05
  3263  3a95 a904                                   lda #>SCREENRAM
  3264  3a97 8503                                   sta zp03
  3265  3a99 a218                                   ldx #$18
  3266  3a9b a000                                   ldy #$00
  3267  3a9d a95d               -                   lda #$5d
  3268  3a9f 9102                                   sta (zp02),y
  3269  3aa1 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3270  3aa3 9104                                   sta (zp04),y
  3271  3aa5 98                                     tya
  3272  3aa6 18                                     clc
  3273  3aa7 6928                                   adc #$28
  3274  3aa9 a8                                     tay
  3275  3aaa 9004                                   bcc +
  3276  3aac e603                                   inc zp03
  3277  3aae e605                                   inc zp05
  3278  3ab0 ca                 +                   dex
  3279  3ab1 d0ea                                   bne -
  3280  3ab3 a95d               -                   lda #$5d
  3281  3ab5 9dc007                                 sta SCREENRAM + $3c0,x
  3282  3ab8 a902                                   lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
  3283  3aba 9dc0db                                 sta COLRAM + $3c0,x
  3284  3abd e8                                     inx
  3285  3abe e028                                   cpx #$28
  3286  3ac0 d0f1                                   bne -
  3287  3ac2 60                                     rts
  3288                          
  3289                          ; ==============================================================================
  3290                          ; SETUP FIRST ROOM
  3291                          ; player xy position and room number
  3292                          ; ==============================================================================
  3293                          
  3294                          set_start_screen:
  3295  3ac3 a906                                   lda #PLAYER_START_POS_Y
  3296  3ac5 8d4035                                 sta player_pos_y + 1                    ; Y player start position (0 = top)
  3297  3ac8 a903                                   lda #PLAYER_START_POS_X
  3298  3aca 8d4235                                 sta player_pos_x + 1                    ; X player start position (0 = left)
  3299  3acd a900                                   lda #START_ROOM                         ; room number (start screen) ($3b45)
  3300  3acf 8df82f                                 sta current_room + 1
  3301  3ad2 20f639                                 jsr m3A2D
  3302                                              
  3303                          
  3304                          main_loop:
  3305                                              
  3306  3ad5 20b92f                                 jsr rasterpoll_and_other_stuff
  3307  3ad8 a01b                                   ldy #$1b                                ; ldy #$30    ; wait a bit -> in each frame! slows down movement
  3308  3ada 20ff39                                 jsr wait
  3309                                                                                      ;jsr room_04_prep_door
  3310  3add 202b16                                 jsr prep_player_pos
  3311  3ae0 4c4416                                 jmp object_collision
  3312                          
  3313                          ; ==============================================================================
  3314                          ;
  3315                          ; Display the death message
  3316                          ; End of game and return to start screen
  3317                          ; ==============================================================================
  3318                          
  3319                          death:
  3320                                             
  3321  3ae3 a93b                                   lda #>death_messages
  3322  3ae5 85a8                                   sta zpA8
  3323  3ae7 a962                                   lda #<death_messages
  3324  3ae9 85a7                                   sta zpA7
  3325  3aeb c000                                   cpy #$00
  3326  3aed f00c                                   beq ++
  3327  3aef 18                 -                   clc
  3328  3af0 6932                                   adc #$32
  3329  3af2 85a7                                   sta zpA7
  3330  3af4 9002                                   bcc +
  3331  3af6 e6a8                                   inc zpA8
  3332  3af8 88                 +                   dey
  3333  3af9 d0f4                                   bne -
  3334  3afb a90c               ++                  lda #$0c
  3335  3afd 8503                                   sta zp03
  3336  3aff 8402                                   sty zp02
  3337  3b01 a204                                   ldx #$04
  3338  3b03 a920                                   lda #$20
  3339  3b05 9102               -                   sta (zp02),y
  3340  3b07 c8                                     iny
  3341  3b08 d0fb                                   bne -
  3342  3b0a e603                                   inc zp03
  3343  3b0c ca                                     dex
  3344  3b0d d0f6                                   bne -
  3345  3b0f 20263a                                 jsr set_charset_and_screen
  3346  3b12 20423b                                 jsr clear
  3347  3b15 b1a7               -                   lda (zpA7),y
  3348  3b17 9dc005                                 sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
  3349  3b1a a900                                   lda #$00                                    ; color of the death message
  3350  3b1c 9dc0d9                                 sta COLRAM + $1c0,x     ; sta $09c0,x
  3351  3b1f e8                                     inx
  3352  3b20 c8                                     iny
  3353  3b21 e019                                   cpx #$19
  3354  3b23 d002                                   bne +
  3355  3b25 a250                                   ldx #$50
  3356  3b27 c032               +                   cpy #$32
  3357  3b29 d0ea                                   bne -
  3358  3b2b a903                                   lda #$03
  3359  3b2d 8d21d0                                 sta BG_COLOR
  3360  3b30 8d20d0                                 sta BORDER_COLOR
  3361                                             
  3362                          m3EF9:
  3363  3b33 a908                                   lda #$08
  3364  3b35 a0ff               -                   ldy #$ff
  3365  3b37 20ff39                                 jsr wait
  3366  3b3a 38                                     sec
  3367  3b3b e901                                   sbc #$01
  3368  3b3d d0f6                                   bne -
  3369                                              
  3370  3b3f 4c423a                                 jmp init
  3371                          
  3372                          ; ==============================================================================
  3373                          ;
  3374                          ; clear the sceen (replacing kernal call on plus/4)
  3375                          ; 
  3376                          ; ==============================================================================
  3377                          
  3378  3b42 a920               clear               lda #$20     ; #$20 is the spacebar Screen Code
  3379  3b44 9d0004                                 sta $0400,x  ; fill four areas with 256 spacebar characters
  3380  3b47 9d0005                                 sta $0500,x 
  3381  3b4a 9d0006                                 sta $0600,x 
  3382  3b4d 9de806                                 sta $06e8,x 
  3383  3b50 a900                                   lda #$00     ; set foreground to black in Color Ram 
  3384  3b52 9d00d8                                 sta $d800,x  
  3385  3b55 9d00d9                                 sta $d900,x
  3386  3b58 9d00da                                 sta $da00,x
  3387  3b5b 9de8da                                 sta $dae8,x
  3388  3b5e e8                                     inx           ; increment X
  3389  3b5f d0e1                                   bne clear     ; did X turn to zero yet?
  3390                                                          ; if not, continue with the loop
  3391  3b61 60                                     rts           ; return from this subroutine
  3392                          ; ==============================================================================
  3393                          ;
  3394                          ; DEATH MESSAGES
  3395                          ; ==============================================================================
  3396                          
  3397                          death_messages:
  3398                          
  3399                          ; death messages
  3400                          ; like "You fell into a snake pit"
  3401                          
  3402                          ; scr conversion
  3403                          
  3404                          ; 00 You fell into a snake pit
  3405                          ; 01 You'd better watched out for the sacred column
  3406                          ; 02 You drowned in the deep river
  3407                          ; 03 You drank from the poisend bottle
  3408                          ; 04 Boris the spider got you and killed you
  3409                          ; 05 Didn't you see the laser beam?
  3410                          ; 06 240 Volts! You got an electrical shock!
  3411                          ; 07 You stepped on a nail!
  3412                          ; 08 A foot trap stopped you!
  3413                          ; 09 This room is doomed by the wizard Manilo!
  3414                          ; 0a You were locked in and starved!
  3415                          ; 0b You were hit by a big rock and died!
  3416                          ; 0c Belegro killed you!
  3417                          ; 0d You found a thirsty zombie....
  3418                          ; 0e The monster grabbed you you. You are dead!
  3419                          ; 0f You were wounded by the bush!
  3420                          ; 10 You are trapped in wire-nettings!
  3421                          
  3422                          !if LANGUAGE = EN{
  3423  3b62 590f152006050c0c...!scr "You fell into a          snake pit !              "
  3424  3b94 590f152704200205...!scr "You'd better watched out for the sacred column!   "
  3425  3bc6 590f152004120f17...!scr "You drowned in the deep  river !                  "
  3426  3bf8 590f15200412010e...!scr "You drank from the       poisened bottle ........ "
  3427  3c2a 420f1209132c2014...!scr "Boris, the spider, got   you and killed you !     "
  3428  3c5c 4409040e27142019...!scr "Didn't you see the       laser beam ?!?           "
  3429  3c8e 32343020560f0c14...!scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
  3430  3cc0 590f152013140510...!scr "You stepped on a nail !                           "
  3431  3cf2 4120060f0f142014...!scr "A foot trap stopped you !                         "
  3432  3d24 5408091320120f0f...!scr "This room is doomed      by the wizard Manilo !   "
  3433  3d56 590f152017051205...!scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
  3434  3d88 590f152017051205...!scr "You were hit by a big    rock and died !          "
  3435  3dba 42050c0507120f20...!scr "Belegro killed           you !                    "
  3436  3dec 590f1520060f150e...!scr "You found a thirsty      zombie .......           "
  3437  3e1e 540805200d0f0e13...!scr "The monster grapped       you. You are dead !     "
  3438  3e50 590f152017051205...!scr "You were wounded by      the bush !               "
  3439  3e82 590f152001120520...!scr "You are trapped in       wire-nettings !          "
  3440                          }
  3441                          
  3442                          
  3443                          !if LANGUAGE = DE{
  3444                          !scr "Sie sind in eine         Schlangengrube gefallen !"
  3445                          !scr "Gotteslaesterung wird    mit dem Tod bestraft !   "
  3446                          !scr "Sie sind in dem tiefen   Fluss ertrunken !        "
  3447                          !scr "Sie haben aus der Gift-  flasche getrunken....... "
  3448                          !scr "Boris, die Spinne, hat   Sie verschlungen !!      "
  3449                          !scr "Den Laserstrahl muessen  Sie uebersehen haben ?!  "
  3450                          !scr "220 Volt !! Sie erlitten einen Elektroschock !    "
  3451                          !scr "Sie sind in einen Nagel  getreten !               "
  3452                          !scr "Eine Fussangel verhindertIhr Weiterkommen !       "
  3453                          !scr "Auf diesem Raum liegt einFluch des Magiers Manilo!"
  3454                          !scr "Sie wurden eingeschlossenund verhungern !         "
  3455                          !scr "Sie wurden von einem     Stein ueberollt !!       "
  3456                          !scr "Belegro hat Sie          vernichtet !             "
  3457                          !scr "Im Sarg lag ein durstigerZombie........           "
  3458                          !scr "Das Monster hat Sie      erwischt !!!!!           "
  3459                          !scr "Sie haben sich an dem    Dornenbusch verletzt !   "
  3460                          !scr "Sie haben sich im        Stacheldraht verfangen !!"
  3461                          }
  3462                          
  3463                          ; ==============================================================================
  3464                          ; screen messages
  3465                          ; and the code entry text
  3466                          ; ==============================================================================
  3467                          
  3468                          !if LANGUAGE = EN{
  3469                          
  3470                          hint_messages:
  3471  3eb4 2041201001121420...!scr " A part of the code number is :         "
  3472  3edc 2041424344454647...!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3473  3f04 20590f15200e0505...!scr " You need: bulb, bulb holder, socket !  "
  3474  3f2c 2054050c0c200d05...!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
  3475  3f54 202a2a2a2a2a2020...!scr " *****   A helping letter :   "
  3476  3f72 432020202a2a2a2a...helping_letter: !scr "C   ***** "
  3477  3f7c 2057120f0e072003...!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "
  3478                          
  3479                          }
  3480                          
  3481                          !if LANGUAGE = DE{
  3482                          
  3483                          hint_messages:
  3484                          !scr " Ein Teil des Loesungscodes lautet:     "
  3485                          !scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
  3486                          !scr " Du brauchst:Fassung,Gluehbirne,Strom ! "
  3487                          !scr " Wie lautet der Loesungscode ? ",$22,"     ",$22,"  "
  3488                          !scr " *****   Ein Hilfsbuchstabe:  "
  3489                          helping_letter: !scr "C   ***** "
  3490                          !scr " Falscher Loesungscode ! TODESSTRAFE !! "
  3491                          
  3492                          }
  3493                          
  3494                          
  3495                          ; ==============================================================================
  3496                          ;
  3497                          ; ITEM PICKUP MESSAGES
  3498                          ; ==============================================================================
  3499                          
  3500                          
  3501                          item_pickup_message:              ; item pickup messages
  3502                          
  3503                          !if LANGUAGE = EN{
  3504  3fa4 2054080512052009...!scr " There is a key in the bottle !         "
  3505  3fcc 2020205408051205...!scr "   There is a key in the coffin !       "
  3506  3ff4 2054080512052009...!scr " There is a breathing tube !            "
  3507                          }
  3508                          
  3509                          !if LANGUAGE = DE{
  3510                          !scr " In der Flasche liegt ein Schluessel !  " ; Original: !scr " In der Flasche war sich ein Schluessel "
  3511                          !scr "    In dem Sarg lag ein Schluessel !    "
  3512                          !scr " Unter dem Stein lag ein Taucheranzug ! "
  3513                          }
  3514                          item_pickup_message_end:
