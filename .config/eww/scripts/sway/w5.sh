#!/bin/bash

# workspace numbering starts from 0 so workspace 1 --> 0 
status=$(swaymsg -rt get_workspaces | jq '. [] | .num' | grep "5")

if 
	[	"$status" = 5 ];
then 
	echo "5"
fi
