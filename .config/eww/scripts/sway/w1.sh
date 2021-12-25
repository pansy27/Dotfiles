#!/bin/bash

# workspace numbering starts from 0 so workspace 1 --> 0 
status=$(swaymsg -rt get_workspaces | jq '. [] | .num' | grep "1")

if 
	[	"$status" = 1 ];
then 
	echo "1"
fi
