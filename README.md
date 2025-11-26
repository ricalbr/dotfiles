# ![home](https://win98icons.alexmeub.com/icons/png/regedit-0.png) ~/.dotfiles

Dotfiles for Arch-based systems.

### Installation
Install required packages
```bash
bat eza fzf ripgrep zoxide zsh
```

Cloning and installation
```bash
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
dot submodule sync --recursive                                                                     ~
dot submodule update --init --recursive --force
-- twitter mode
vim.keymap.set('n', '<leader>tw', ':match Error "%>281v.+"<CR>')

-- let s:activatedt = 0
-- function! TwitterMode()
--     if s:activatedt == 0
--         let s:activatedt = 1
--         match Error '\%>281v.\+'
--     else
--         let s:activatedt = 0
--         match none
--     endif
-- endfunction

-- nnoremap <leader>tw :call TwitterMode()<CR>

# hide untracked files (to avoid noise)
dot config status.showUntrackedFiles no

# set zsh as default shell
chsh -s "$(which zsh)"

echo "Installation complete. You may need to restart your terminal."

