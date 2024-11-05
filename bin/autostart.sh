#!/usr/bin/env bash

exec waybar &
exec copyq &
exec wlsunset -t 4500 -s 18:30 -S 06:30 &
exec nm-applet &
exec /usr/bin/lxqt-policykit-agent &
# exec swayidle -w \
# 	timeout 300 'lock.sh' \
# 	timeout 600 'systemctl sleep' \
# 	# resume 'swaymsg "output * power on"' \
# 	before-sleep 'lock.sh' \
# 	lock 'lock.sh'
