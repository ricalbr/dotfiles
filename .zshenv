typeset -U path

# XDG PATHS
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}

# DISABLE FILES
export LESSHISTFILE=-

# PATH
export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/miniconda3/bin:$XDG_DATA_HOME/npm/bin

# DEFAULT APPS
export BROWSER="brave"
export COLORTERM="truecolor"
export EDITOR="nvim"
export IMAGE="sxiv"
export LANG=en_US.UTF-8
export OPENER="xdg-open"
export PAGER="less"
export READER="zathura"
export TERMINAL="alacritty"
export VIDEO="mpv"
export VISUAL="nvim"

# PROGRAM CONFIG
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CONDARC="$XDG_CONFIG_HOME"/conda/condarc
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GOPATH="$XDG_DATA_HOME"/go
export HISTFILE="$ZDOTDIR"/.zhistory
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export LEIN_HOME="$XDG_DATA_HOME"/lein
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_PREFIX=$XDG_DATA_HOME/npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NVM_DIR="$XDG_DATA_HOME"/nvm
export WGETRC="$XDG_CONFIG_HOME/"wgetrc
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
