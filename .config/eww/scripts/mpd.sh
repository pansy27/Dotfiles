#!/bin/bash

playerctl=$(playerctl metadata --format "{{ artist }} - {{ title }}")
if 
 mpc status | awk "NR==2" | grep playing > /dev/null;
then 
	echo "$(mpc --format '%artist% - %title%' current)"
else 
	echo "$playerctl"
fi
