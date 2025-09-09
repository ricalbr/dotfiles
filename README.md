# ![home](https://win98icons.alexmeub.com/icons/png/regedit-0.png) ~/.dotfiles

dotfiles for arch-based systems.

### install
```bash
# install required packages
curl -sL https://raw.githubusercontent.com/ricalbr/dotfiles/refs/heads/master/.config/pkglist-pacman.txt | sudo pacman -S --needed -

# copy dotfiles
git clone --bare https://github.com/ricalbr/dotfiles $HOME/.dotfiles
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

# set zsh as default shell
chsh -s zsh
```


