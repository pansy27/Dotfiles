#!/usr/bin/env bash

function run {
	if ! pgrep -f $1 ;
	then 
		$@&
	fi
}
run picom --experimental-backends 
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 
run libinput-gestures-setup restart 
run greenclip daemon 
#run /home/mikage/.scripts/art.sh 
run nm-applet 
run urxvtd
