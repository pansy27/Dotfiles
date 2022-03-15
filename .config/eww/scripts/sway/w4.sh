#!/bin/bash

# workspace numbering starts from 0 so workspace 1 --> 0 
status=$(swaymsg -rt get_workspaces | jq '. [] | .num' | grep "4")

if 
	[	"$status" = 4 ];
then 
	echo "4"
fi
