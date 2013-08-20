#!/bin/sh

cd splash/1366x768/

for f in *.png
do
 convert -channel rgba -filter Lagrange -sample 50%x50% $f ../800x480/$f
done

convert -filter Lagrange -resize 800x480\! background.png ../800x480/background.png

cd ../..
