#!/bin/bash

# workspace numbering starts from 0 so workspace 1 --> 0 
status=$(swaymsg -rt get_workspaces | jq '. [] | .num' | grep "2")

if 
	[	"$status" = 2 ];
then 
	echo "2"
fi
