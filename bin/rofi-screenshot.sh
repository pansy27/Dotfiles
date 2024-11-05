#!/usr/bin/env bash

# Options
delay='<span font="Liga SFMono Nerd Font 11.5"> 󱑏</span>   Delay'
full='<span font="Liga SFMono Nerd Font 11.5"> 󰹑</span>   Full'
selection='<span font="Liga SFMono Nerd Font 11.5"> 󰩭</span>   Selection'
selection_delay='<span font="Liga SFMono Nerd Font 11.5"> 󱫗</span>   Delay (5 secs)'

# -theme-str 'entry { background-color: transparent; placeholder-color: transparent; text-color: transparent; }' \
# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-markup-rows \
		-no-show-icons \
		-theme-str 'entry { placeholder: "Capture!"; text-color: transparent; }'
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$full\n$selection\n$delay\n$selection_delay" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    "$full")
		screenshot.sh full
        ;;
    "$selection")
	    	screenshot.sh selection
        ;;
    "$delay")
	    	screenshot.sh delay
        ;;
    "$selection_delay")
	    	screenshot.sh selection_delay
        ;;
esac
