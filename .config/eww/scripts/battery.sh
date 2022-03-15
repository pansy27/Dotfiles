#!/bin/bash

charging=$(acpi | awk '{print $3}')

case $charging in
	"Unknown,")
			echo "";;
		"Charging,")
			echo " ";;
		"Discharging,")
			echo "";;
		"Full,")
			echo "";;
	*)	
	echo ":("
esac
			
