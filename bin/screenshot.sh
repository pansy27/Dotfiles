#!/usr/bin/env bash

mode="$1"
delay=5
fileName="$(date +"%Y%m%d_%H%M%S").png"
savePath="$HOME/pictures/captures"

case $mode in
    "selection")
	sleep 0.5 && slurp | grim -g - $savePath/$fileName || { notify-send "Screenshot not taken!" -t 1500; exit 0; }
	copyq write image/png - < $savePath/$fileName && notify-send "Screenshot taken!" -t 1500
        ;;
    "selection_delay")
	notify-send "Taking Screenshot in 5 Sec!" -t  2000
	sleep $delay && slurp | grim -g - $savePath/$fileName || { notify-send "Screenshot not taken!" -t 1500; exit 0; }
	copyq write image/png - < $savePath/$fileName && notify-send "Screenshot taken!" -t 1500
        ;;
    "full")
	sleep 0.5 && grim $savePath/$fileName || { notify-send "Screenshot not taken!" -t 1500; exit 0; }
	copyq write image/png - < $savePath/$fileName && notify-send "Screenshot taken!" -t 1500
        ;;
    "delay")
	notify-send "Taking Screenshot in 5 Sec!" -t  2000
	sleep $delay && grim $savePath/$fileName || { notify-send "Screenshot not taken!" -t 1500; exit 0; }
	copyq write image/png - < $savePath/$fileName && notify-send "Screenshot taken!" -t 1500
        ;;
    *)
        exit 1
esac

