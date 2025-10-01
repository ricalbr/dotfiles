# GIT-BARE ALIASES (for .dotfiles)

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca=dot_add
alias ccm=dot_commit
alias ccm!=dot_commit_amend
alias ccma='dot commit -v -a'
alias ccma!='dot commit -v -a --amend'
alias ccmam='dot commit -v -a -m'
alias clogs="dot log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat --max-count=15"
alias cdiff=dot_diff
alias cmv='dot mv'
alias cpull='dot pull --recurse-submodules -v'
alias cpush='dot push -v'
alias cs='dot status -s'
alias csu='dot submodule update --remote --merge'
alias cup='dot pull --rebase -v'
function csa() { dot submodule add ssh://git@github.com/"$*" }

# quick updates
alias cnvim='dot commit ~/.config/nvim -m "Update Neovim module"'
alias cgnome='dot commit ~/.config/gnome_backup.txt -m "Update GNOME setting"'
alias cpac='dot commit ~/.config/pkglist-pacman.txt -m "Update pacman package list"'
alias cyay='dot commit ~/.config/pkglist-yay.txt -m "Update yay package list"'

# functions
function dot_add(){
  fname=$(ls | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    dot add $(echo "$fname" | tr '\n' ' ')
  fi
}

function dot_commit() {
  # Usa fzf per selezionare più file e salva l'elenco
  fname=$(dot status -s | cut -c12- | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    dot commit -v $(echo "$fname" | tr '\n' ' ')
  fi
}


function dot_commit_amend(){
  fname=$(dot status -s | cut -c12- | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    dot commit -v --amend $(echo "$fname" | tr '\n' ' ')
  fi
}

function dot_diff(){
  fname=$(dot status -s | cut -c12- | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    dot diff $(echo "$fname" | tr '\n' ' ')
  fi
}
