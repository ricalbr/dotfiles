# ![home](https://win98icons.alexmeub.com/icons/png/regedit-0.png) ~/. dotfiles

collection of configuration and dotfiles for GNU/Linux. files and direcotries are laid out exactly how they go in the `$HOME` dir.

### install
```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/ricalbr/.dotfiles $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
mkdir -p .config-backup && config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
config checkout

# if zsh is not the default shell
chsh -s zsh
```

### what's inside 
collection of configuration and dotfiles for various GNU/Linux tools and programs.
|   | Program|
| :-- | :--|
| application switcher | rofi | 
| media player | mpv | 
| pdf viever | zathura | 
| shell | zsh | 
| terminal emulator | alacritty | 
| terminal multiplexer | tmux | 
| text editor | [vim](https://github.com/ricalbr/vim) | 
| | + list of pacman and yay packages|

many programs are not used on a regular basis but are stored here nonetheless. these config files can be used as starting point for future tweakings.

### bugs
open a bug [here](https://github.com/ricalbr/.dotfiles/issues).

---
author: riccardo albiero albr.riccardo@gmail.com
