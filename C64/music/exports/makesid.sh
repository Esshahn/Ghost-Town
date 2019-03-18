#!/bin/sh

# check if acme and psid64 are available
command -v acme >/dev/null 2>&1 || { echo >&2 "[ERROR] acme not installed or not in PATH variable."; exit 1; }
command -v psid64 >/dev/null 2>&1 || { echo >&2 "[ERROR] psid64 not installed or not in PATH variable."; exit 1; }

if [ "$#" -ge 1 ] && [ "$#" -le 2 ]
then
  INFILE=$1

  if [ "$#" -eq 1 ]
  then
    TITLE=untitled
  elif [ "$#" -eq 2 ]
  then
    TITLE=$2
  fi
  YEAR=`echo $(date +'%Y')`
  OUTFILE=`printf "$TITLE" | tr -s ' ' | tr ' ' '_' && printf ".sid"`

  echo "collecting data..."
  head -c 2 "$INFILE" >> initAddress
  printf "$TITLE" >> songTitle
  printf "Spider Jerusalem" >> songAuthor
  printf "$YEAR Mayday!" >> songReleased
  #printf "$YEAR Spider Jerusalem" >> songReleased
  cp -v "$INFILE" songData
  echo "compile sid file with acme crosass..."
  acme -v4 -f plain -o "../sid/$OUTFILE" psidheader.asm
  echo "building c64 executable with psid64..."
  psid64 -c -t blue -p "./sidid.cfg" -v -o "../psid64/" "../sid/$OUTFILE"

  echo "removing data files..."
  rm -v initAddress
  rm -v songTitle
  rm -v songAuthor
  rm -v songReleased
  rm -v songData
else
  echo "[ERROR] parameter error."
  echo "correct usage:"
  echo "./makesid.sh FILENAME \"SONGTITLE\""
  echo "ATTENTION: if no title is given"
  echo "the title and output filenames will default to:"
  echo " untitled.sid / untitled.prg "
  echo "old files with those names will be overwritten!!!"
  exit 1;
fi
