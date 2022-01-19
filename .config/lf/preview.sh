#!/bin/sh
# Preview script built for use with lf and fzf

handle() {
	if [ -f "$1" ];
	then
		bat --color always "$1"
	elif [ -d "$1" ];
	then
		tree "$1" -La 1
	fi
}

case "$1" in
    *.png|*.jpg|*.jpeg|*.mkv|*.mp4|*.m4v) mediainfo "$1";;
    *.md) bat --color always "$1";;
    *.pdf) mediainfo "$1";;
    *.zip) zipinfo "$1";;
    *.tar.gz) tar -ztvf "$1";;
    *.tar.bz2) tar -jtvf "$1";;
    *.tar) tar -tvf "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.torrent) transmission-show "$1";;
    *.html|*.xml) bat --color always "$1";;
    *.zsh*|*.bash*|*.git*) bat --color always "$1";;
    *) handle "$1" ;;
esac


