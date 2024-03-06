# add ~/bin to path
if [[ -d $HOME/bin ]]
 then export PATH="$HOME/bin:$PATH"
fi
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# autostart x server on succesful login
# if [[ -z $DISPLAY ]] && [[ $(tty) = "/dev/tty1" ]]; then
# 	exec startx "$HOME/.config/X11/xinitrc" --"$XDG_CONFIG_HOME/X11/xserverrc" 2>~/.cache/xorg-errors.log 1>~/.cache/xorg.log
# fi
