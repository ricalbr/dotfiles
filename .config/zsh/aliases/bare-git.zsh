# GIT-BARE ALIASES (for .dotfiles)

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca=config_Add
alias ccm=config_commit
alias ccm!=config_commit_amend
alias ccma='config commit -v -a'
alias ccma!='config commit -v -a --amend'
alias ccmam='config commit -v -a -m'
alias cdiff=config_diff
alias cmv='config mv'
alias cpull='config pull --recurse-submodules -v'
alias cpush='config push -v'
alias cs='config status -s'
alias csu='config submodule update --remote --merge'
alias cup='config pull --rebase -v'
function csa() { config submodule add ssh://git@github.com/"$*" }

# quick updates
alias cpac='config commit ~/.config/pkglist-pacman.txt -m "Update pacman package list"'
alias cyay='config commit ~/.config/pkglist-yay.txt -m "Update yay package list"'
alias ccv='config commit ~/.config/vim -m "Update Vim module"'

# functions
function config_add(){
  config status -s | cut -c12- |\
  fzf --multi --no-sort --reverse --cycle --bind 'enter:execute(/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME add {})'
}

function config_commit(){
  config status -s | cut -c12- |\
  fzf --multi --no-sort --reverse --cycle --bind 'enter:execute(/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -v {})'
}

function config_commit_amend(){
  config status -s | cut -c12- |\
  fzf --multi --no-sort --reverse --cycle --bind 'enter:execute(/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -v --amend {})'
}

function config_diff(){
  config status -s | cut -c12- |\
  fzf --multi --no-sort --reverse --cycle --bind 'enter:execute(/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME diff {})'
}

