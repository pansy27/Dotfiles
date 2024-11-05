#!/usr/bin/env bash
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec sway
fi
