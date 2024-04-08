# zsh config dir
export ZDOTDIR=$HOME/.config/zsh

# add ~/bin to path
if [[ -d $HOME/bin ]]
then export PATH="$HOME/bin:$PATH"
fi
