#!/bin/bash
SSID=$(nmcli -t -f name connection show --active)
STATUS=$(nmcli device status | grep -m1 "wlp2s0" | awk '{print $3}')

if 
	[ $STATUS = "connected" ];
then 
	echo "$SSID"
else 
	echo "Disconnected"
fi
