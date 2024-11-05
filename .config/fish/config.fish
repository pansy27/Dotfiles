if status is-interactive
    # Commands to run in interactive sessions can go here
    # source zoxide if it's installed
    zoxide init --cmd j fish | source
    #
    # arch specific
    abbr -a update 'sudo pacman -Syu'
    abbr -a install 'sudo pacman -S'
    abbr -a remove 'sudo pacman -Rns'
    abbr -a search 'pacman -Ss'
    abbr -a info 'pacman -Qi'

    # others
    abbr -a nrf 'fastfetch'
    abbr -a enable-keeb 'xinput enable "AT Translated Set 2 keyboard"'
    abbr -a disable-keeb 'xinput disable "AT Translated Set 2 keyboard"'

    abbr -a e '$EDITOR'
    abbr -a cat 'bat'
end
