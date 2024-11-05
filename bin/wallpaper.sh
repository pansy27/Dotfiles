#!/usr/bin/env bash

file="$1"
mode="$2"
blur=3
wallPath="$HOME/.cache/wallpaper"
wallLockPath="$HOME/.cache/lockscreen"
resolution=(1366 768)

case $mode in
"normal")
	rm $wallPath
	ln -s "$file" $wallPath || { notify-send "Error setting wallpaper!"; exit 0; }
	# swaymsg output * bg "$wallPath" fill
	swaymsg output "*" bg $wallPath fill
	;;
"blur")
	rm $wallPath
	magick -gravity center \
	\( "$file" -resize ${resolution[0]}x${resolution[1]}^ -extent ${resolution[0]}x${resolution[1]} -blur 0x$blur \) \
	\( "$file" -resize ${resolution[0]}x${resolution[1]} \) -composite \
       	$wallPath
	swaymsg output "*" bg $wallPath fill && notify-send "Wallpaper set :)"
	;;
"top")
	rm $wallPath
	magick "$file" -resize ${resolution[0]}x${resolution[1]}^ -gravity north -extent ${resolution[0]}x${resolution[1]} $wallPath
	swaymsg output "*" bg $wallPath fill && notify-send "Wallpaper set :)"
	;;
"lockscreen")
	rm $wallLockPath
	ln -s "$file" $wallLockPath || { notify-send "Error setting wallpaper!"; exit 0; }
	;;
*)	
	notify-send "fallback case"
	;;
esac

# generate cool colors
matugen -m light image ~/.cache/wallpaper
