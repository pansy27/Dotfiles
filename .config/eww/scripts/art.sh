#!/bin/bash
fallback="../../Pictures/Others/Elia.png"
mpris="$HOME/.mozilla/firefox/firefox-mpris"
if 
	[[ -d "$HOME/.mozilla/firefox/firefox-mpris" ]];
then 
	echo "../../.mozilla/firefox/firefox-mpris/$(ls $mpris)"
else
	echo "$fallback"
fi
