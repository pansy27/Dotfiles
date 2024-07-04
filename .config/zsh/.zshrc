#!/usr/bin/env zsh

# prompt
PROMPT="
%~
૮꒰˶• ༝ •˶꒱ა ♡ "
# PROMPT='
# %~
# ૮₍ ´ ꒳ `₎ა '


# history
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=2000
SAVEHIST=10000

# sourcing files
source $ZDOTDIR/aliases.sh
source $ZDOTDIR/functions

# keybindings mode
bindkey -e

# check cache only once per day
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# other options
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/.zcompcache
zstyle ':completion:*' menu select
zstyle :compinstall filename $ZDOTDIR/.zshrc


# keybinds
# use 'cat' for keycodes
bindkey "^[[a" history-substring-search-up
bindkey "^[[b" history-substring-search-down

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
# bindkey "^[[3;2~" delete-word
bindkey "^[[5~" forward-char
bindkey "^[[6~" backward-char

# Plugins
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# zsh_unplugged
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]
  then git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# loaded in order of listing
repos=(
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-autosuggestions
)

# load plugins
plugin-load $repos

# update plugins
function plugin-update {
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

# Zsh autosuggestions 
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Fzf 
if [[ -d "/usr/share/fzf" ]]
 then source /usr/share/fzf/completion.zsh
   source /usr/share/fzf/key-bindings.zsh
fi

export FZF_DEFAULT_COMMAND='fd --type f -d 4 --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# user friendly completions for 'kill'
zstyle ':completion:*:processes' command "ps -u $USER -o pid,user,comm"

# autojump
[[ -f /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh

# fnm
eval "$(fnm env --use-on-cd)"

# pywal
# (cat $HOME/.config/wpg/sequences &)

# auto awesome
source $ZDOTDIR/scripts/auto-awesome.sh
