# export env vars
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export XAUTHORITY="$HOME/.local/share/xorg/Xauthority"
export GOPATH="$XDG_DATA_HOME/go"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
# export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
# export LIBVA_DRIVER_NAME=iHD
# export EDITOR="emacsclient -c -a 'emacs'"
export EDITOR="nvim"
# export TERMINAL="alacritty"
# export QT_STYLE_OVERRIDE=kvantum
export QT_QPA_PLATFORMTHEME=qt5ct
# export SUDO_PROMPT=" /\___/\  
# ꒰˶•༝-˶ ꒱
# ./づ~🍨"
export SUDO_PROMPT=" /\_/\     (\__/) 
(˶•o•˶)    (•ω•)   
ଘ(ა🍱)     (ა🍙૮)｡
passwd pwease 🥺: "
# Fzf colors
# export FZF_DEFAULT_OPTS='--layout=reverse -i --border sharp --multi'

# --color=hl+:135,hl:99
# --color=fg:235,fg+:233,bg+:189
# --color=info:233,prompt:97,pointer:99'
# zstyle ":fzf-tab:*" fzf-flags --color=hl:3
# fg -> fg color, better left alone, automatically selected(doesn't work for fzf-tab)
# fg+ (doesn't work for fzf-tab)
# bg -> bg color for fzf results
# bg+ -> color for top most result and left sidebar
# hl -> hl color for matching text in all entries(doesn't work for fzf-tab) [needs zstyle to work]
# (+) ones only work for top most result!!!
# info -> text displayed like 42/450 results
# prompt-> prompt for text you enter
# pointer -> prompt for top most result
# --color=fg:#8378c6,bg:#f9fbff,hl:#8378c6
# --color=fg+:#8378c6,bg+:#f9fbff,hl+:#f8928a
# --color=info:#f9fbff,prompt:#f8928a,pointer:#8378c6
# --color=marker:#f8928a,spinner:#f8928a,header:#d95d6b'

# fzf colors rose-pine
export FZF_DEFAULT_OPTS="
  --layout=reverse -i --border sharp --multi"
	# --color=fg:#908caa,bg:#191724,hl:#ebbcba
	# --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	# --color=border:#403d52,header:#31748f,gutter:#191724
	# --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	# --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
	#  --bind=shift-tab:toggle --cycle"

#export XDG_CURRENT_DESKTOP=Unity
# export XINITRC=$XDG_CONFIG_HOME/xorg/xinitrc
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export MANPAGER="helix -c 'Man!' -o -"
#export MANPAGER='/usr/bin/zsh -c "nvim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
