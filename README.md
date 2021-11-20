# ![home](https://win98icons.alexmeub.com/icons/png/regedit-0.png) ~/. dotfiles

collection of configuration and dotfiles for GNU/Linux. files and direcotries are laid out exactly how they go in the `$HOME` dir.

### install
```bash
git clone --bare https://github.com/john-kurkowski/dotfiles.git $HOME/.dotfiles
alias dotfiles='GIT_DIR=$HOME/.dotfiles/ GIT_WORK_TREE=$HOME git'
dotfiles config --local core.worktree $HOME
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout

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

many programs are not used on a regular basis but are stored here nonetheless to save the configs and may be used as starting point for future exeperiments.

### bugs
open a bug [here](https://github.com/ricalbr/.dotfiles/issues).

---
author: riccardo albiero albr.riccardo@gmail.com
