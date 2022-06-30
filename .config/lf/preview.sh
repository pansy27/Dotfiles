#!/usr/bin/env bash
draw() {
  ~/.config/lf/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '%s/.cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

handle() {
	if [ -f "$1" ];
	then
		bat --color always "$1"
	elif [ -d "$1" ];
	then
		tree "$1" -La 1
	fi
}

file="$1"
shift

if [ -n "$FIFO_UEBERZUG" ]; then
  case "$(file -Lb --mime-type -- "$file")" in
    image/*)
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
      if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        convert -- "$file" -auto-orient "$cache"
        draw "$cache" "$@"
      else
        draw "$file" "$@"
      fi
      ;;
    video/*)
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
      ffmpegthumbnailer -i "$file" -o "$cache" -s 0
      draw "$cache" "$@"
      ;;
    *.md) bat --color always "$file";;
    *.pdf) mediainfo "$file";;
    *.zip) zipinfo "$file";;
    *.tar.gz) tar -ztvf "$file";;
    *.tar.bz2) tar -jtvf "$file";;
    *.tar) tar -tvf "$file";;
    *.rar) unrar l "$file";;
    *.7z) 7z l "$file";;
    *.torrent) transmission-show "$file";;
    *.html|*.xml) bat --color always "$file";;
    *.zsh*|*.bash*|*.git*) bat --color always "$file";;
    *) 	if [ -f "$file" ];
        	then
		        bat --color always "$file"
	      elif [ -d "$file" ];
	        then
        		tree "$file" -La 1
      	fi
    esac
fi

file -Lb -- "$1" | fold -s -w "$width"
exit 0
