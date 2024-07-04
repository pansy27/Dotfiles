# zsh config dir
export ZDOTDIR=$HOME/.config/zsh
# export QT_QPA_PLATFORMTHEME="qt5ct"

# add ~/bin to path
if [[ -d $HOME/bin ]]
then export PATH="$HOME/bin:$PATH"
fi
