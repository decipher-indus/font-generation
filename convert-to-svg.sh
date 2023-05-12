#!/bin/sh

rm -rf svgs; 
mkdir svgs;

for i in {001..999}; do 
    ( 
        magick signs/S$i.jpg pgm: | mkbitmap - -o - | potrace --svg -o svgs/S$i.svg; 
    ) &
done;

wait

find ./ -size 0 -delete
