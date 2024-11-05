#!/usr/bin/env bash

uptime="$(uptime -p | sed -e 's/up //g')"

# Options
shutdown='<span font="Liga SFMono Nerd Font 11.5"> </span>   Shutdown'
reboot='<span font="Liga SFMono Nerd Font 11.5"> </span>   Reboot'
lock='<span font="Liga SFMono Nerd Font 11.5"> </span>   Lock'
logout='<span font="Liga SFMono Nerd Font 11.5"> 󰗽</span>   Logout'
yes='<span font="Liga SFMono Nerd Font 11.5"> 󰄬</span>   Yes'
no='<span font="Liga SFMono Nerd Font 11.5"> </span>   No'

# -theme-str 'entry { background-color: transparent; placeholder-color: transparent; text-color: transparent; }' \
# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-markup-rows \
		-no-show-icons \
		-theme-str 'entry { placeholder: "$uptime"; }'
}

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-markup-rows \
		-no-show-icons \
		-theme-str 'entry { placeholder: "Are you Sure?"; text-color: transparent; }' \
		-p 'Confirmation' \
		-mesg 'Are you Sure?'
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			poweroff
		elif [[ $1 == '--reboot' ]]; then
			reboot
		elif [[ $1 == '--logout' ]]; then
			swaymsg exit
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    "$shutdown")
		run_cmd --shutdown
        ;;
    "$reboot")
		run_cmd --reboot
        ;;
    "$lock")
	    	lock.sh
        ;;
    "$logout")
		run_cmd --logout
        ;;
esac
