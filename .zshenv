typeset -U path

# XDG PATHS
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

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
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export LEIN_HOME="$XDG_DATA_HOME"/lein
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_PREFIX=$XDG_DATA_HOME/npm
export NVM_DIR="$XDG_DATA_HOME"/nvm
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
