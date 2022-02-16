# Zsh-History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End
#
# Keybinds Mode
bindkey -v
#
# Compinstall
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit
# 
# -- osc7 escape part ----
autoload -Uz add-zsh-hook
add-zsh-hook -Uz chpwd osc7_cwd
# --------------------------
compinit
# End
#
# More Options
setopt glob_dots     # no special treatment for dotfiles 
#setopt no_auto_menu  # require an extra TAB for completion menu 
setopt auto_cd		# cd into selected directory with just name
setopt auto_pushd
#setopt always_to_end
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt beep
#setopt correct
#setopt hash_list_all
# End
#
# Fzf-Options
export FZF_DEFAULT_OPTS='--layout=reverse -i --border sharp '
# --color='fg:#c4c9fa,hl:#8ec07c,fg+:#a598ab,bg+:#3d322a,pointer:#ebdbb2''
export FZF_CTRL_T_COMMAND='find'
# End
#
# emit osc 7 escape sequence
_urlencode() {
	local length="${#1}"
	for (( i = 0; i < length; i++ )); do
		local c="${1:$i:1}"
		case $c in
			%) printf '%%%02X' "'$c" ;;
			*) printf "%s" "$c" ;;
		esac
	done
}

osc7_cwd() {
	printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$(_urlencode "$PWD")"
}
# end 
#
# Keybinds
bindkey "^[[F" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[3;2~" delete-word
# => History-Substring-Search Keybinds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# => Single Tab Fzf-Menu keybind
#bindkey '^I' single-tab-menu
# End
#
# Single Tab Fzf-Menu
#unction single-tab-menu() {
#   if [[ $#BUFFER == 0 ]]; then
#     BUFFER="$(find $path -type f -printf "%f\n" | fzf --border sharp)"
#       CURSOR=3
#       zle list-choices
# zle accept-and-hold
#       zle backward-kill-word
#   else
#       zle expand-or-complete
#   fi
#
#zle -N single-tab-menu
# End
#
# Change cursor shape for different vi modes.
    function zle-keymap-select {
      if [[ ${KEYMAP} == vicmd ]] ||
         [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
 
      elif [[ ${KEYMAP} == main ]] ||
           [[ ${KEYMAP} == viins ]] ||
           [[ ${KEYMAP} = '' ]] ||
           [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
      fi
    }
 zle -N zle-keymap-select

# Aliases
alias tree='tree -a -I .git'
alias ncp='ncmpcpp' 
#alias rm="rm -i"
alias ls='exa'
alias rm='trash'
alias c='clear'
alias nrf='neofetch --sixel $HOME/Pictures/Wallpaper/butterflies.png'
alias weeb="weebsay"
alias temproot='xhost si:localuser:root'
alias temproot!='xhost -si:localuser:root'
alias wprop='swaymsg -t get_tree | grep -i app_id'
alias clip-clear='rm -f ~/.cache/cliphist/db'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#alias gitlab-push="gitlab push origin main"
alias ..='cd ..'
alias image='img2sixel'
alias farge='farge --image-viewer sxiv'
alias wev='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'''
#alias hx='helix'

# ===> Sourcing addons <===
# Autojump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
# Zsh-Completions
#fpath=($HOME/Github/zsh-completions/src $fpath)
# Zsh-Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# Zsh-History-Substring-Search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
# Zsh-Syntax-Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Fzf-Keybinds
source "/usr/share/fzf/key-bindings.zsh"
# Fzf-Tab
source "$HOME/Github/fzf-tab/fzf-tab.plugin.zsh"
# Prompt
#ROMPT="  %B%F{14}%n%f %b  %F{14}%m%f   %~%     "
#PROMPT="%T"
PROMPT='%B%F{14}%f%b %~ '
RPROMPT=''


#!/bin/sh
#f [ "$TERM" = "linux" ]; then
# /bin/echo -e "
# \e]P0403c58
# \e]P1ea6f91
# \e]P29bced7
# \e]P3f1ca93
# \e]P434738e
# \e]P5c3a5e6
# \e]P6eabbb9
# \e]P7faebd7
# \e]P86f6e85
# \e]P9ea6f91
# \e]PA9bced7
# \e]PBf1ca93
# \e]PC34738e
# \e]PDc3a5e6
# \e]PEeabbb9
# \e]PFffffff
# "
# # get rid of artifacts
# clear
#
# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'
# zstyle ':completion:*' original true
# zstyle ':completion:*' menu select
