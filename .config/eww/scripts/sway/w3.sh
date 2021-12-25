#!/bin/bash

# workspace numbering starts from 0 so workspace 1 --> 0 
status=$(swaymsg -rt get_workspaces | jq '. [] | .num' | grep "3")

if 
	[	"$status" = 3 ];
then 
	echo "3"
fi
