### ALIASES

# GNU and BSD (macOS) ls flags aren't compatible
ls --version &>/dev/null
if [ $? -eq 0 ]; then
  lsflags="--color --group-directories-first -F"
else
  lsflags="-GF"
  export CLICOLOR=1
fi

# edit config
alias ec="$EDITOR $ZDOTDIR/.zshrc $ZDOTDIR/aliases.zsh $HOME/.zshenv"
alias sz="source $ZDOTDIR/.zshrc"

# basic aliases
alias ls="ls ${lsflags}"
alias ll="ls ${lsflags} -lh"
alias la="ls ${lsflags} -lah"
alias h="history"
alias hg="history -1000 | grep -i"
alias ping="ping -c 5"                  # ping stops after 5 requests
alias df='df -h'                        # human-readable sizes
alias free='free -m'                    # show sizes in MB

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# confirm before overwriting something
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# fix typo
alias claer='clear'
alias sl='ls'
alias al='la'
alias dc='cd'

# useful programs
alias node='nodejs'
alias tmux='tmux -f ~/.config/tmux/.tmux.conf'
alias vim='nvim'
alias vimf='vim $(fzf)'
alias ytdl='youtube-dl'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/yarnrc"'
alias vscodium='vscodium --extensions-dir "$XDG_DATA_HOME"/vscode/extensions'

# GIT
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gp='git push'
alias gs='git status 2>/dev/null'
alias pull='git pull --recurse-submodules'
function gcl() { git clone ssh://git@github.com/"$*" }
function gsa() { git submodule add ssh://git@github.com/"$*" }
function gg() { git commit -am "$*" }

# git-bare repo (for .dotfiles)
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add'
alias ccm='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit'
alias cdiff='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME diff'
alias cpull='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull'
alias cpush='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push'
alias cs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status'
alias cu='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME submodule update --remote --merge'
alias cpac='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit ~/.config/pkglist-pacman.txt -m "Update pacman package list"'
alias cyay='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit ~/.config/pkglist-yay.txt -m "Update yay package list"'
alias ccv='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit ~/.config/vim -m "Update Vim module"'

# suckless programs aliases
alias fullclean='git checkout master && make clean && rm -f config.h && git reset --hard origin/master'
alias configinstall='git checkout master && rm -f config.h && make && sudo make clean install'

# quick fixes
alias setkeyb='setxkbmap -model pc104 -layout it -variant ,qwerty -option grp:alt_shift_toggle'
alias resetaudio='systemctl --user restart pulseaudio'
# alias dwdrive='rclone -P sync GoogleDrive: ~/Drive/'
# alias updrive='rclone -P sync ~/Drive/ GoogleDrive:'
alias onesync='onedrive --synchronize'
alias dwone='onedrive --synchronize --download-only'
alias upone='onedrive --synchronize --upload-only'
alias extback='dconf dump /org/gnome/shell/extensions/ > ~/.config/extensions_backup.txt'
alias gnomeback='dconf dump /org/gnome/> ~/.config/gnome_backup.txt'

# functions

mk () {
  mkdir -p "$@" && cd "$@"
}
