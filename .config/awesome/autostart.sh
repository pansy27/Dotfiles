#!/usr/bin/env bash

function run {
	if ! pgrep -f $1 ;
	then
		$@&
	fi
}
run xrdb ~/.config/X11/Xresources
# run mpv -wid 0  --no-osc --no-osd-bar --no-input-default-bindings --no-input-cursor --no-audio --quiet ~/.cache/video-wall
# run xwinwrap -ov -g 1366x768+0+0 \
# -- mpv -wid WID --no-osc --no-osd-bar \
# --loop-file --player-operation-mode=cplayer \
# --no-audio --panscan=1.0 --no-input-default-bindings -no-load-scripts "/home/anon/videos/live-walls/miku-snowflakes-vocaloid-moewalls.com.mp4"
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run redshift-gtk
run nitrogen --restore
run greenclip daemon
run picom 
# run batsignal -w 40 -c 30 -d 25 -f 100 -b
run nm-applet
run xautocfg
run xsettingsd -c ~/.config/xsettingsd/xsettingsd.conf
run xss-lock awesome-client 'lockScreen_visibility()'
