#!/bin/bash
set -xeu
[ "$1" ] || exit 1
[ "$2" ] || exit 2
[ "$(ls -1 $2* | wc -l)" -eq 2 ] || exit 4
for f in $2*; do 
  if [[ "$f" =~ [0-9]{3}_ ]]; then
    mv -vi "$f" "$(printf '%03d' "$1")_${f:4}";
  else
    mv -vi "$f" "$(printf '%03d' "$1")_$f";
  fi
done
