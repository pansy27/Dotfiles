#!/bin/bash

# workspace numbering starts from 0 so workspace 1 --> 0 
status=$(swaymsg -rt get_workspaces | jq '. [] | .num' | grep "6")

if 
	[	"$status" = 6 ];
then 
	echo "6"
fi
