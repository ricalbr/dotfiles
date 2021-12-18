# GIT-BARE ALIASES (for .dotfiles)

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca=config_add
alias ccm=config_commit
alias ccm!=config_commit_amend
alias ccma='config commit -v -a'
alias ccma!='config commit -v -a --amend'
alias ccmam='config commit -v -a -m'
# alias cdiff='config diff -- config_diff'
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
  fname=$(ls |\                                 # add files in cwd
    fzf --multi --no-sort --reverse --cycle|\   # use fzf
    awk '{print "\047" $0 "\047"}' |\           # add single quotes to each entry
    paste -sd", ")                              # join all lines
  if [ -n "$fname" ]
  then
    config add -- $fname
  fi
}

function config_commit(){
  fname=$(config status -s | cut -c12- |\
    fzf --multi --no-sort --reverse --cycle|\
    paste -sd" ")
  if [ -n "$fname" ]
  then
    config commit -v -- $fname
  fi
}

function config_commit_amend(){
  fname=$(config status -s | cut -c12- |\
    fzf --multi --no-sort --reverse --cycle|\
    paste -sd" ")
  config commit -v --amend -- $fname
}

function config_diff(){
  fname=$(config status -s | cut -c12- |\
    fzf -0 --no-sort --reverse --cycle)
  if [ -n "$fname" ]
  then
    config diff -- $fname
  fi
}
