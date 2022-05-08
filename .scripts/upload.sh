#!/usr/bin/env bash
curl -F "file=@$1" https://0x0.st | xclip -selection clipboard
notify-send "file $1 uploaded to" $(xclip -o -selection clipboard)
printf "\n\e[1;31m$1\e[0m ⟿  \t\e[1;33m$(xclip -o -selection clipboard)\e[0m" >> $HOME/.cache/url.md




