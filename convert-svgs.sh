#!/bin/sh

rm -rf bmps;
mkdir bmps;

rm -rf svgs; 
mkdir svgs;

generate_svg() {
#    magick $i pgm: | mkbitmap -3 -g -b 2 -f 3 - -o - | potrace --svg -t 200 -u 2 -H 1 -o - > svgs/$(basename $i .jpg).svg
#    magick $i -resize x295 -adaptive-resize x200 -antialias pgm: | mkbitmap -3 -b 0.8 -f 5 - -o - | potrace --svg -t 200 -u 5 -H 0.1 -a 1.3 -O 0.7 -o - > svgs/$(basename $i .jpg).svg
#    magick $i pgm: | mkbitmap - -o - | potrace --svg -o - > svgs/$(basename $i .jpg).svg
    
    magick $1 pgm: | mkbitmap -3 -b 2 -f 30 - -o bmps/$(basename $1 .jpg).bmp
    magick $1 pgm: | mkbitmap -3 -b 2 -f 30 - -o - | potrace --svg -t 200 -u 2 -a 1.1 -O 10 -o - > svgs/$(basename $1 .jpg).svg
#    vtracer --input $i --output svgs/$(basename $i .jpg).svg
}

export -f generate_svg

find signs/ -name 'S*.jpg' | xargs -n 1 -P 20 bash -c 'generate_svg "$@"' _

fontforge -lang=py -script generate-font.py
open -W /Applications/FontForge.app indus-font.ttf
