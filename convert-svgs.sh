#!/bin/sh

rm -rf svgs; 
mkdir svgs;

for i in signs/S*.jpg; do 
    convert -resize 100x100 $i pgm: | mkbitmap -3 -g -b 2 -f 3 - -o - | potrace --svg -t 200 -u 2 -H 1 -o - | convert -resize 100x100 svg: svgs/$(basename $i .jpg).svg;
done;
