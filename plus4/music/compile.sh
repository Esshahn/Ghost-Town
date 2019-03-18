#!/bin/sh
OUTFILE="../build/music".prg

rm -f "$OUTFILE"

acme -v4 -f cbm -l labels.asm -o out.prg main.asm

STARTADDR=$(grep "code_start" labels.asm | cut -d$ -f2 | cut -f1)
exomizer sfx 0x$STARTADDR -n -t 4 -o "$OUTFILE" out.prg

rm -f out.prg
rm -f labels.asm

xplus4 "$OUTFILE"
#codenet -n 172.16.1.164 -x "$OUTFILE"
