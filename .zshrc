# PATH VARIABLE
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin:$PATH:$HOME/miniconda3/bin
export LANG=en_US.UTF-8

# CONDA INIT
__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
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

# ALIASES
source $HOME/.config/zsh/aliases

# More suitable for .zshenv
EDITOR=vim
# PROMPT='%n@%m %3~ %(!.#.$)%(?.. [%?]) '
# autoload -U promptinit && promptinit
source ~/.config/zsh/themes/cleanthefish.zsh-theme
# autoload -U colors && colors
# export PS1="%F{214}%K{000}%m%F{015}%K{000}:%F{039}%K{000}%~%F{015}%K{000}\$ "

# PLUGINS
source /home/ricalbr/.config/zsh/plugins/archive_extract
source /home/ricalbr/.config/zsh/plugins/conda-zsh-completion/conda-zsh-completion.plugin.zsh
source /home/ricalbr/.config/zsh/plugins/fzf.plugin.zsh
source /home/ricalbr/.config/zsh/plugins/gitfast/gitfast.plugin.zsh
source /home/ricalbr/.config/zsh/plugins/web-search.plugin.zsh
source /home/ricalbr/.config/zsh/plugins/z/z.sh
source /home/ricalbr/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /home/ricalbr/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# History settings
HISTFILE=~/.history-zsh
HISTSIZE=10000
SAVEHIST=10000
setopt append_history           # allow multiple sessions to append to one history
setopt bang_hist                # treat ! special during command expansion
setopt extended_history         # Write history in :start:elasped;command format
setopt hist_expire_dups_first   # expire duplicates first when trimming history
setopt hist_find_no_dups        # When searching history, don't repeat
setopt hist_ignore_dups         # ignore duplicate entries of previous events
setopt hist_ignore_space        # prefix command with a space to skip it's recording
setopt hist_reduce_blanks       # Remove extra blanks from each command added to history
setopt hist_verify              # Don't execute immediately upon history expansion
setopt inc_append_history       # Write to history file immediately, not when shell quits
setopt share_history            # Share history among all sessions

# Tab completion
autoload -Uz compinit && compinit
setopt complete_in_word         # cd /ho/sco/tm<TAB> expands to /home/scott/tmp
setopt auto_menu                # show completion menu on succesive tab presses
setopt autocd                   # cd to a folder just by typing it's name
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # These "eat" the auto prior space after a tab complete

# MISC
setopt interactive_comments     # allow # comments in shell; good for copy/paste
setopt PROMPT_SUBST
unsetopt correct_all            # I don't care for 'suggestions' from ZSH
export BLOCK_SIZE="'1"          # Add commas to file sizes

# PATH
typeset -U path                 # keep duplicates out of the path

# BINDKEY
bindkey -e
bindkey '\e[3~' delete-char
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey ' '  magic-space
