#!/bin/bash

STATUS=$(pamixer --get-mute)

if 
		 	[ $STATUS = true ];
	then 
			echo 	ﳌ
else
			echo 
fi
