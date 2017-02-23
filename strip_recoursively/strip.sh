#!/bin/bash

# this file will strip all tags from images recoursively. useful to strip let's say geotags from hosted images.

function strip()
{
  echo $1
  find /path/to/files/ -iname "*${1}" | \
    while read I
    do
      echo "$I"
      exiftool -all= $I
    done
}

  strip jpg
  strip JPG
  strip png
  strip PNG

