# GIT-BARE ALIASES (for .dotfiles)

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias da=dot_add
alias dcm=dot_commit
alias dcm!=dot_commit_amend
alias dcma='dot commit -v -a'
alias dcma!='dot commit -v -a --amend'
alias dcmam='dot commit -v -a -m'
alias dlogs="dot log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat --max-count=15"
alias ddiff=dot_diff
alias dmv='dot mv'
alias dpull='dot pull --recurse-submodules -v'
alias dpush='dot push -v'
alias ds='dot status -s'
alias dsu='dot submodule update --remote --merge'
alias dup='dot pull --rebase -v'
function dsa() { dot submodule add ssh://git@github.com/"$*" }

# quick updates
alias dnvim='dot commit ~/.config/nvim -m "Update Neovim module"'
alias dgnome='dot commit ~/.config/gnome_backup.txt -m "Update GNOME setting"'
alias dpac='pacman -Qqen > $HOME/.config/repo.txt && dot commit $HOME/.config/repo.txt -m "(chore) update pacman package list"'
alias dyay='pacman -Qqem > $HOME/.config/aur.txt && dot commit $HOME/.config/aur.txt -m "(chore) update yay package list"'

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
