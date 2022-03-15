#!/bin/sh

 for pid in $(pidof -x music-notifier); do
        if [ $pid != $$ ]; then
            kill -9 $pid
        fi 
    done >/dev/null
    
    killall -9 playerctl 2>/dev/null
    
    IFS='`' ## this works well enough and i could not find a better IFS okay?
    
    exec playerctl -Fsp playerctld metadata -f '{{status}}`{{title}}`{{artist}}`{{album}}`{{mpris:artUrl}}' | while read -r playing title artist album art; do 
##      printf "%s\n%s\n%s\n%s\n%s\n" "$playing" "$title" "$artist" "$album" "$art";
      [ ! -z "$art" ] && notify-send "$title" "\n''${artist%%,*} //\n$album" --expire-time "2000" --app-name "MusicNotif" --icon "$art"; ## Avoid multiple notifications due to missing album art
    done
