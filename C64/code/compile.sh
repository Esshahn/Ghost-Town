#!/bin/sh
OUTFILE="../build/ghosttown64".prg

rm -f "$OUTFILE"

acme -v4 -f cbm -l labels.asm --vicelabels vicelabels -o out.prg main.asm

STARTADDR=$(grep "code_start" labels.asm | cut -d$ -f2 | cut -f1)
exomizer sfx 0x$STARTADDR -n -o "$OUTFILE" out.prg

rm -f out.prg
rm -f labels.asm

if [ "$HOSTNAME" = havarie ]
    then
        vice -VICIIborders 2 -moncommands vicelabels "$OUTFILE"
    else
        #x64sc -VICIIborders 2 -moncommands vicelabels "$OUTFILE"
        codenet -n 172.16.1.164 -x "$OUTFILE"
fi

rm -f vicelabels
