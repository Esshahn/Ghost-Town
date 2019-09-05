; --------- SID File Format Headerdata
*=$00
  ; PSID Header
  !byte $50, $53, $49, $44
*=$04
  ; version: PSID v2NG
  !byte $00, $02
*=$06
  ; dataOffset
  !byte $00, $7c
*=$08
  ; loadAddress ( = $0000 in PSID)
  !byte $00, $00
*=$0a
  ; initAddress ( get from file )
  !bin "initAddress",1,1
  !bin "initAddress",1,0
*=$0c
  ; playAddress ( lowbyte = $03, highbyte from initAdress file )
  !bin "initAddress",1,1
  !byte $03
*=$0e
  ; songs ( number of songs = 1 )
  !byte $00, $01
*=$10
  ; startSong
  !byte $00, $01
*=$12
  ; speed ( 0 for VIC irq )
  !byte $00, $00, $00, $00
*=$16
  ; <title>
  !bin "songTitle"
*=$35
  !byte $00
*=$36
  ; <author>
  !bin "songAuthor"
*=$55
  !byte $00
*=$56
  ; <released>
  !bin "songReleased"
*=$75
  !byte $00
*=$76
  ; flags ( $24 for PAL, 8580 )
  !byte $00, $24
*=$7c
  ; <data>
  !bin "songData"
