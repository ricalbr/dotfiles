#!/bin/bash

# clone and backup files
git clone --bare https://github.com/ricalbr/.dotfiles $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
BACKUP_DIR=$HOME/.config-backup

# Make back-up directory
mkdir -p $BACKUP_DIR

config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $BACKUP_DIR/{}
fi;
config checkout
config config status.showUntrackedFiles no

# set shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    run "chsh -s $(which zsh)"
else
    echo "zsh is already set as deafult shell."
fi
