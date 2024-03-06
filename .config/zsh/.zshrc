# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/usr/bin/env zsh
# zmodload zsh/zprof # could be used with zprof for testing loading times for individual plugins

# Zsh-history
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=2000
SAVEHIST=10000

# ==> additonal options <==
# beep on error ⬇
setopt autocd beep

# keybindings mode
bindkey -e

# ⬇ provides completions and stuff other than basic tab completion for files and stuff
zstyle :compinstall filename $XDG_CONFIG_HOME/zsh/.zshrc
# 🍡 case-insensitive matching only if there are no case-sensitive matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# 📦 caches the completions for faster completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/.zcompcache
# 🍡 creates menu, 🐹 allows using arrow keys for selecting, ❌ pressing tab continously
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

# ⌨  keybinds
# find out keyconds by executing cat
bindkey "^[[a" history-substring-search-up
bindkey "^[[b" history-substring-search-down

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
# bindkey "^[[3;2~" delete-word
bindkey "^[[5~" forward-char
bindkey "^[[6~" backward-char
# bindkey "^[[3;2~" delete-word

# sourcing aliases
source $ZDOTDIR/aliases.sh


# Plugins
# plugins dir ⬇
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]
  then git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# plugins list, loaded in order of listing
repos=(
  romkatv/powerlevel10k
  romkatv/zsh-defer
  Aloxaf/fzf-tab
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-autosuggestions
)

# loading plugins
plugin-load $repos

# plugins update
function plugin-update {
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

# 🐴 Plugin settings ⬇
if [[ -d "$HOME/bin" ]]
  then eval "$(jump shell)"
fi
# Zsh autosuggestions 
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Fzf 
# loading fzf keybinds
if [[ -d "/usr/share/fzf" ]]
 then source /usr/share/fzf/completion.zsh
   source /usr/share/fzf/key-bindings.zsh
fi

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f -d 4 --strip-cwd-prefix --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# fzf-completions (use fd instead of find)
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Fzf-tab
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --color=always $realpath'
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# making completions for kill command more user friendly :)
zstyle ':completion:*:processes' command "ps -u $USER -o pid,user,comm"
# systemctl command preview
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# environment variables preview(-command-)
zstyle ':fzf-tab:complete:(-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
# git preview for fzf-tab
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# Custom prompts i stole 💀
# RPROMPT='%(?.%F{red}ヾ(●´▽｀●)ﾉ彡☆勹”ﾉヽ.%F{red}┻━┻%F{magenta} ︵ ╯(°□° ╯%))'

# pyenv (for python)
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# Other settings
# Dynamic title in urxvt
case $TERM in
  (*xterm* | *rxvt*)
    # Write some info to terminal title.
    # This is seen when the shell prompts for input.
    function precmd {
      print -Pn "\e]0;zsh%L %(1j,%j job%(2j|s|); ,)%~\a"
    }
    # Write command and args to terminal title.
    # This is seen while the shell waits for a command to complete.
    function preexec {
      printf "\033]0;%s\a" "$1"
    }
  ;;
esac

# get nvm
# if [[ -d /usr/share/nvm ]] then 
#     source /usr/share/nvm/init-nvm.sh
# fi

source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# prints colors
palette() {
    local -a colors
    for i in {000..255}; do
        colors+=("%F{$i}$i%f")
    done
    print -cP $colors
}
palette2() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}
# change command not found message
# command_not_found_handler() { printf "fuck you, \e[31;1;1m'%s'\e[m try again.\n" "$1"; }
command_not_found_handler() { printf "fuck you, try again.\n" "$1"; }
# stupid welcome command
# welcome() {
#  ~/.scripts/welcome/welcome.sh
# }

# custom alias for installing and removing programs on arch linux :3
# for removing
remove () {
  if [ $# -eq 0 ]
  then
    pacman -Qqe | fzf --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns
  else
    sudo pacman -Rns $@
  fi
}

# for installing
pacinstall () {
  if [ $# -eq 0 ]
  then
    pacman -Slq | fzf --multi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S
  else
    sudo pacman -S $@
  fi
}

#lazy? load nvm
loadnvm() {
    if [[ -d /usr/share/nvm ]]
        then source /usr/share/nvm/init-nvm.sh
    fi
}

lf() {
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
source ~/.config/awesome/icon_customizer/dynamictitles.zsh
