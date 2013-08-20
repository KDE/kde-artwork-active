#!/bin/sh

convert -resize 800x480\! lockscreen/1366x768/wallpaper.png lockscreen/800x480/wallpaper.png;
cd wallpaper/1366x768
for i in *jpg *.png; do convert -resize 800x480\! $i ../800x480/$i; done;
cd ../../
