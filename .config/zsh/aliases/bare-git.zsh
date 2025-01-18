# GIT-BARE ALIASES (for .dotfiles)

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca=config_add
alias ccm=config_commit
alias ccm!=config_commit_amend
alias ccma='config commit -v -a'
alias ccma!='config commit -v -a --amend'
alias ccmam='config commit -v -a -m'
alias clogs="config log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat --max-count=15"
alias cdiff=config_diff
alias cmv='config mv'
alias cpull='config pull --recurse-submodules -v'
alias cpush='config push -v'
alias cs='config status -s'
alias csu='config submodule update --remote --merge'
alias cup='config pull --rebase -v'
function csa() { config submodule add ssh://git@github.com/"$*" }

# quick updates
alias cvim='config commit ~/.config/vim -m "Update Vim module"'
alias cgnome='config commit ~/.config/gnome_backup.txt -m "Update GNOME setting"'
alias cpac='config commit ~/.config/pkglist-pacman.txt -m "Update pacman package list"'
alias cyay='config commit ~/.config/pkglist-yay.txt -m "Update yay package list"'

# functions
function config_add(){
  fname=$(ls | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    config add $(echo "$fname" | tr '\n' ' ')
  fi
}

function config_commit() {
  # Usa fzf per selezionare più file e salva l'elenco
  fname=$(config status -s | cut -c12- | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    config commit -v $(echo "$fname" | tr '\n' ' ')
  fi
}


function config_commit_amend(){
  fname=$(config status -s | cut -c12- | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    config commit -v --amend $(echo "$fname" | tr '\n' ' ')
  fi
}

function config_diff(){
  fname=$(config status -s | cut -c12- | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    config diff $(echo "$fname" | tr '\n' ' ')
  fi
}
