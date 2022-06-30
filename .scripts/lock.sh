#!/usr/bin/env bash

# Upstream: https://github.com/b4skyx/unix-scripts

# Note: Works only with the i3lock latest version. They changed some flags which broke backwards compatibility.

CLOCK_FONT="Coming Soon"
FONT="Coming Soon"

quote="$(shuf -n 1 ~/.config/quotes)"
status=$(playerctl status || true)
mpd_status=$(mpc status | grep "playing" | sed 's/\[playing]/dank/' | awk '{print $1}')
music_paused_on_lock=false
mpd_paused_on_lock=false
lock() {
        i3lock -n -c 0000008c -e --fill \
                --ind-pos="w/2:h-24"\
                --radius=7 --ring-width=8 \
                --ring-color=31363b00 --ringver-color=474f5400 --ringwrong-color=474f5400 \
                --inside-color=474f54 --insidever-color=d39bb600 --insidewrong-color=d39bb600\
                --line-uses-inside \
                --time-str="%I:%M %p" --time-pos="w/2:h/2-70" \
                --time-color=bfddb2 --timeoutline-color=868686  --time-font="$CLOCK_FONT:style=Italic" --time-size=114 \
                --date-pos="tx:ty+62"\
                --date-color=b3cfa7 --date-font="$FONT:style=Bold" --date-size=34 \
                --greeter-text="\"$quote\"" \
                --greeter-pos="w/2:h/2+68"\
                --greeter-color=d39bb6 --greeter-font="$FONT" --greeter-size=24 \
                --keylayout 2 --layout-pos="18:h-18" --layout-color=999f93 --layout-align=1\
                --layout-font="Cascadia Code" \
                --verif-text="Matching Passphrase.." --verif-pos="w/2:h-18" \
                --verif-color=999f93 --verif-font="$FONT" --verif-size=14 \
                --wrong-text="Invalid Passphrase!" --wrong-pos="w/2:h-18" \
                --wrong-color=d76e6e --wrong-font="$FONT" --wrong-size=14 \
                --noinput-text="No Input"
}

# Pause the current playing song
if [ "$status" == "Playing" ]; then
	playerctl pause &
	music_paused_on_lock=true
fi

# Pause mpd using mpc
if [ "$mpd_status" == "dank" ]; then
  mpc pause &
  mpd_paused_on_lock=true
fi

# Pause dunst notifications
#dunstctl set-paused true

# kill all rofi instances
if pgrep -x rofi; then
	killall rofi
fi

# lock the screen
lock

# Resume playback on unlock
if [ "$music_paused_on_lock" = true ]; then
	playerctl play
fi

if [ "$mpd_paused_on_lock" = true ]; then
  mpc play
fi

# Resume dunst notifications
#dunstctl set-paused false
