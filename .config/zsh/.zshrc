# .zshrc
#
# @ricalbr

# THEME {{{
autoload -Uz colors && colors
source $ZDOTDIR/themes/cleanthefish.zsh-theme
# }}}

# HISTORY SETTINGS {{{
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY                   # allow multiple sessions to append to one history
setopt BANG_HIST                        # treat ! special during command expansion
setopt EXTENDED_HISTORY                 # Write history in :start:elasped;command format
setopt HIST_EXPIRE_DUPS_FIRST           # expire duplicates first when trimming history
setopt HIST_FIND_NO_DUPS                # When searching history, don't repeat
setopt HIST_IGNORE_DUPS                 # ignore duplicate entries of previous events
setopt HIST_IGNORE_SPACE                # prefix command with a space to skip it's recording
setopt HIST_REDUCE_BLANKS               # Remove extra blanks from each command added to history
setopt HIST_VERIFY                      # Don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY               # Write to history file immediately, not when shell quits
setopt SHARE_HISTORY                    # Share history among all sessions
# }}}

# TAB COMPLETION {{{
autoload -Uz compinit && compinit
_comp_options+=(globdots)               # Include hidden files.
setopt complete_in_word                 # cd /ho/sco/tm<TAB> expands to /home/scott/tmp
setopt autocd                           # cd to a folder just by typing it's name
setopt menucomplete                     # show completion menu on succesive tab presses
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'      # These "eat" the auto prior space after a tab complete

# completers
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR/.zcompcache"
zstyle ':completion:*' complete true
zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification

# complete case-insensitive and partial words
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# completion decorations
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:descriptions' format '%U%K{yellow} %F{green}-- %F{red} %BNICE!1! %b%f %d --%f%k%u'

# group completion
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

# navigate completion menu with Vim keys
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# }}}

# MISC {{{
setopt extendedglob
setopt interactive_comments     # allow # comments in shell; good for copy/paste
setopt PROMPT_SUBST
unsetopt correct_all            # I don't care for 'suggestions' from ZSH
export BLOCK_SIZE="'1"          # Add commas to file sizes

# map CAPS -> ESC
setxkbmap -option caps:escape
# }}}

# PLUGINS {{{
source $ZDOTDIR/plugins/archive_extract.zsh
source $ZDOTDIR/plugins/conda_init.zsh
source $ZDOTDIR/plugins/conda-zsh-completion/conda-zsh-completion.plugin.zsh
source $ZDOTDIR/plugins/fzf.plugin.zsh
source $ZDOTDIR/plugins/gitfast/gitfast.plugin.zsh
source $ZDOTDIR/plugins/quitcd.zsh
source $ZDOTDIR/plugins/web-search.plugin.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZDOTDIR/plugins/z/z.sh

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
# }}}

# ALIASES {{{
source $ZDOTDIR/aliases.zsh
# }}}

# BINDKEY {{{
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey ' '  magic-space

# move up directory
function up_widget() {
    BUFFER="cd .."
    zle accept-line
}
zle -N up_widget
bindkey '^k' up_widget

# home - navigates to the current root workspace
function git_root() {
    BUFFER="cd $(git rev-parse --show-toplevel || echo ".")"
    zle accept-line
}
zle -N git_root
bindkey '^h' git_root
#$(fc -ln -1) }}}
