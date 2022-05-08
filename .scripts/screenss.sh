#!/usr/bin/env bash
shotgun $(slop -f "-i %i -g %g") $HOME/.cache/ss.png 
curl -F "file=@$HOME/.cache/ss.png" https://0x0.st | xclip -selection clipboard
notify-send "ss uploaded to" "$(xclip -o -selection clipboard)"
printf "\n\e[1;32mScreenshot\e[0m ⟿  \"\e[1;35mfilename:\e[0m \e[1;36m$(date +%H_%M_%S)\e[0m\" ⟿  \t\e[1;33m$(xclip -o -selection clipboard)\e[0m" >> $HOME/.cache/url.md
