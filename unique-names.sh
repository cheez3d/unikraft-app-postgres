#!/bin/sh

SRC=build/libpostgres/origin/postgresql-13.4/src
EXT=.c

i=0

for src in $(
    find "$SRC" -type f -name "*$EXT" -printf '%p %f\n' |
    sort -t ' ' -k 2,2 |
    uniq -f 1 --all-repeated=separate |
    cut -d' ' -f1
); do
    path=$(dirname "$src")
    name=$(basename "$src" "$EXT")

    usrc="$path/$name-$i$EXT"

    echo "$usrc"
    mv "$src" "$usrc"

    i=$(echo $i+1 | bc)
done
