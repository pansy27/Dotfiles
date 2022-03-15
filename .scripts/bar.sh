#!/usr/bin/env bash

if [ "$(pgrep eww)" = "" ];
then
	eww open bar
else
	$(eww kill)
fi
