typeset -U path

# XDG DIRECTORIES
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
export XDG_DATA_DIRS=${XDG_DATA_DIRS:="/usr/local/share:/usr/share"}
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:="/etc/xdg"}

# DISABLE FILES
export LESSHISTFILE=-

# PATH
export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/miniconda3/bin:$XDG_DATA_HOME/npm/bin

# DEFAULT APPS
export BROWSER="brave"
export COLORTERM="truecolor"
export EDITOR="nvim"
export IMAGE="sxiv"
export OPENER="xdg-open"
export PAGER="less"
export READER="zathura"
export TERMINAL="alacritty"
export VIDEO="mpv"
export VISUAL="nvim"
export LANG=en_US.UTF-8

# PROGRAM CONFIG
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CONDA_ROOT="$XDG_CONFIG_HOME"/conda
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
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export SSB_HOME="$XDG_DATA_HOME"/zoom
export VIMINIT="set nocp | source ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc"
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export WGETRC="$XDG_CONFIG_HOME/"wgetrc
export _Z_DATA="$XDG_CONFIG_HOME"/z/.z
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# FZF CONFIG
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND="fd --hidden . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --hidden -t d . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# NNN CONFIG
export NNN_BMS="d:$HOME/Documents;o:$HOME/OneDrive;v:$HOME/.config/vim"
NNN_PLUG_PLUGIN='d:fzcd;o:fzopen;j:autojump;u:getplugs;b:renamer;c:rsynccp'
NNN_PLUG_KEYCMD='x:!chmod +x $nnn;e:-!sudo -E vim $nnn*'
NNN_PLUG="$NNN_PLUG_PLUGIN;$NNN_PLUG_KEYCMD"
export NNN_PLUG
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_TMPFILE='/tmp/nnn'

# Colors
source $ZDOTDIR/themes/colors.zsh

# if tmux is executable and not inside a tmux session, then try to attach. if attachment fails, start a new session
# [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1

