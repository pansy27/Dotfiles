#!/bin/bash

STATUS=$(pamixer --get-mute)

if 
		 	[ $STATUS = true ];
	then 
			echo 			
else
			echo 
fi
