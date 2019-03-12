#!/bin/sh
OUTFILE="../build/testscreen.prg"

rm -f "$OUTFILE"

acme -v4 -f cbm -l labels.asm -o out.prg testscreen.asm

STARTADDR=$(grep "code_start" labels.asm | cut -d$ -f2 | cut -d\; -f1 )
exomizer sfx 0x$STARTADDR -n -o "$OUTFILE" out.prg

rm -f out.prg
rm -f labels.asm

x64sc -VICIIborders 0 "$OUTFILE"
#codenet -n 172.16.1.164 -x "$OUTFILE"
