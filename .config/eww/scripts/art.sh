#!/bin/bash
fallback="../../Pictures/Others/not_human.jpg"
mpris="$HOME/.mozilla/firefox/firefox-mpris"
if 
	[[ -d "$HOME/.mozilla/firefox/firefox-mpris" ]];
then 
	echo "../../.mozilla/firefox/firefox-mpris/$(ls $mpris)"
else
	echo "$fallback"
fi
