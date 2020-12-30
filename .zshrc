# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gallois"
#gallois,kardan,nicoulaj

# completion
# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="false"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
dnf
fzf
git
gitfast
web-search
z
zsh-autosuggestions
zsh-syntax-highlighting
)
# if we get an error for the last two plugins just install them manually
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export PATH="$PATH:$HOME/miniconda3/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
alias status='git status'
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

#stow
sto(){
    stow -vSt ~ $1
}

unsto(){
    stow -vDt ~ $1
}

adopt(){
    stow --adopt -vSt ~ $1
}
