# GIT-BARE ALIASES (for .dotfiles)

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca='config add'
alias cca='config commit -v --amend'
alias ccm='config commit -v'
alias cdiff='config diff'
alias cpull='config pull --recurse-submodules -v'
alias cup='config pull --rebase -v'
alias cpush='config push -v'
alias cs='config status -s'
alias csu='config submodule update --remote --merge'

# lazy updates
alias cpac='config commit ~/.config/pkglist-pacman.txt -m "Update pacman package list"'
alias cyay='config commit ~/.config/pkglist-yay.txt -m "Update yay package list"'
alias ccv='config commit ~/.config/vim -m "Update Vim module"'
