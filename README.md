# ![home](https://win98icons.alexmeub.com/icons/png/regedit-0.png) ~/.dotfiles

Dotfiles for Arch-based systems.

### Install
```bash
# install required packages
sudo pacman -Sy --needed curl git
sudo pacman -S --needed - < <(curl -sL https://raw.githubusercontent.com/ricalbr/dotfiles/refs/heads/master/.config/pkglist-pacman.txt)

# clone dotfiles as a bare repo
git clone --bare git@github.com:ricalbr/dotfiles.git "$HOME/.dotfiles"

# define helper function for easier commands
function dot() {
   /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

# create backup directory
mkdir -p "$HOME/.config-backup"

# try checkout
if dot checkout 2>/tmp/dotfiles-checkout.log; then
    echo "✅ Checked out config."
else
    echo "⚠️  Backing up pre-existing dot files..."
    cat /tmp/dotfiles-checkout.log | grep -E "\s+\." | awk '{print $1}' | while read -r file; do
        mkdir -p "$(dirname "$HOME/.config-backup/$file")"
        mv "$HOME/$file" "$HOME/.config-backup/$file"
    done
    dot checkout
fi

# initialize submodules
dot submodule update --init --recursive

# hide untracked files (to avoid noise)
dot config status.showUntrackedFiles no

# set zsh as default shell
sudo pacman -Sy --needed zsh
chsh -s "$(which zsh)"

echo "Installation complete. You may need to restart your terminal."

