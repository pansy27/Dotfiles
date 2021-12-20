# Zsh-History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End
#
# Keybinds Mode
bindkey -e
#
# Compinstall
zstyle :compinstall filename '/home/nobu/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit
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
# End
#
# Fzf-Options
export FZF_DEFAULT_OPTS='--layout=reverse -i --border sharp --color='fg:#c4c9fa,hl:#8ec07c,fg+:#a598ab,bg+:#3d322a,pointer:#ebdbb2''
export FZF_CTRL_T_COMMAND='find'
# End
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
#   function zle-keymap-select {
#     if [[ ${KEYMAP} == vicmd ]] ||
#        [[ $1 = 'block' ]]; then
#       echo -ne '\e[1 q'
#
#     elif [[ ${KEYMAP} == main ]] ||
#          [[ ${KEYMAP} == viins ]] ||
#          [[ ${KEYMAP} = '' ]] ||
#          [[ $1 = 'beam' ]]; then
#       echo -ne '\e[5 q'
#     fi
#   }
#zle -N zle-keymap-select

# Aliases
alias tree='tree -a -I .git'
alias ncp='ncmpcpp' 
#alias rm="rm -i"
alias ls='exa'                             
alias wd='ptPwd'
alias mkdir='ptMkdir'
alias rm='ptRm'
alias cc='ptCp'
alias touch='ptTouch'
alias nrf='neofetch --sixel ~/Pictures/Wallpaper/butterflies.png'
alias bunny='bunnyfetch'
#alias weeb="~/Github/weebsay/weebsay"
alias temproot='xhost si:localuser:root'
alias temproot!='xhost -si:localuser:root'
alias wprop='swaymsg -t get_tree | grep -i app_id'
alias clip-clear='rm -f ~/.cache/cliphist/db'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#alias gitlab-push="gitlab push origin main"
alias dotfiles-push='git push git@github.com:Sad-Shogun/Dotfiles.git'
alias ..='cd ..'
alias image='img2sixel'
alias wev='xev | awk -F'\''[ )]+'\'' '\''/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'\'''

# ===> Sourcing addons <===
# Autojump
[[ -s /home/koko/.autojump/etc/profile.d/autojump.sh ]] && source /home/koko/.autojump/etc/profile.d/autojump.sh
# Zsh-Completions
fpath=(/home/koko/Github/zsh-completions/src $fpath)
# Zsh-Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# Zsh-History-Substring-Search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
# Zsh-Syntax-Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Fzf-Keybinds
source "/usr/share/fzf/key-bindings.zsh"
# Fzf-Tab
source "/home/koko/Github/fzf-tab/fzf-tab.plugin.zsh"
# Prompt
#ROMPT="  %B%F{14}%n%f %b  %F{14}%m%f   %~%     "
#PROMPT="%T"
PROMPT='%B%F{14} %f%b %~  '
RPROMPT=''

