#EXPORT
set fish_greeting                      # Supresses fish's intro message
set TERM "xterm-256color"              # Sets the terminal type
set -gx EDITOR nvim
set -gx PATH $PATH /usr/bin/conda

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/ricalbr/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# ALIASES
# better formatting
alias ls='ls --group-directories-first --color=auto'
alias l='ls -lah'
alias ll='ls -lh'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

#typo
alias claer="clear"
alias sl="ls"

# useful programs
alias sz="source ~/.zshrc"
alias node="nodejs"
alias tmux="tmux -f ~/.config/tmux/.tmux.conf"
alias vim="nvim -u $HOME/.config/nvim/minimal_init.vim"
alias tvim="tmux new-session nvim"

# safe remove
alias rm="rm -i"

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

#git aliases
alias add='git add'
alias commit='git commit'
alias diff='git diff'
alias pull='git pull --recurse-submodules'
alias push='git push'
alias gsta='git status'
alias branch='git branch'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# suckless programs aliases
alias fullclean='git checkout master && make clean && rm -f config.h && git reset --hard origin/master'
alias configinstall='git checkout master && rm -f config.h && make && sudo make clean install'

# quick fixes
alias setkeyb='setxkbmap -model pc104 -layout it -variant ,qwerty -option grp:alt_shift_toggle'
alias resetaudio='systemctl --user restart pulseaudio'
alias dwdrive='rclone -P sync GoogleDrive: ~/Drive/'
alias updrive='rclone -P sync ~/Drive/ GoogleDrive:'

