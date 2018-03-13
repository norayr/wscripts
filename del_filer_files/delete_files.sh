#!/bin/bash

oldifs=$IFS
IFS=$'\n'

if [ "x$1" == "x" ]; then
  echo "Usage: $0 {files_list}"
  exit
fi

i=0

for f in `cat $1`; do
  if [[ "$f" = "${f% *}" ]]; then 
    rm -Rf $f
    ((i=i+1))
  else 
    echo "Warning: $f has a whitespace"
  fi
done

echo "$i files deleted."

IFS=$oldifs
