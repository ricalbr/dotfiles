# PACMAN ALIASES

# pacman {{{
# https://wiki.archlinux.org/index.php/Pacman_Tips
alias pacs='sudo pacman -S'         # sync (intall)
alias pacsy='sudo pacman -Sy'       # update package database
alias pacyy='sudo pacman -Syy'      # force refresh even if up to date
alias pacsu='sudo pacman -Su'       # upgrade only
alias pacupg='sudo pacman -Syu'     # update dayabse and upgrade
alias pacss='pacman -Ss'            # search package
alias pacsi='pacman -Si'            # details of the package
alias pacsc='sudo pacman -Sc'       # remove old packages from cache directory
alias paclr='sudo pacman -Scc'      # remove ALL packages from cache directory

alias pacq='pacman -Q'              # version information
alias pacqs='pacman -Qs'            # search locally installed package
alias pacqi='pacman -Qi'            # details of the installed package
alias pacql='pacman -Ql'            # list all files of the package
alias pacqm='pacman -Qm'            # packages installed from aur
alias pacqo='pacman -Qo'            # file owned by $package
alias pacqkk='pacman -Qkk'          # check for any altered files
alias paclsorphans='sudo pacman -Qdt'

alias pacloc='sudo pacman -U'       # install local package
alias pacre='sudo pacman -R'        # remove package (leaving dependencies)
alias pacrs='sudo pacman -Rs'       # remove package not leaving orphans
alias pacrns='sudo pacman -Rns'     # remove package not leaving orphans nor config file

alias pacfiles='pacman -F'          # file informations
alias pacfileupg='sudo pacman -Fy'  # download fresh package databases from the server

# functions {{{
function paclist() {
  # Based on https://bbs.archlinux.org/viewtopic.php?id=93683
  pacman -Qqe | \
    xargs -I '{}' \
      expac "${bold_color}% 20n ${fg_no_bold[white]}%d${reset_color}" '{}'
}

function pacdisowned() {
  local tmp db fs
  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap 'rm -rf "$tmp"' EXIT

  pacman -Qlq | sort -u > "$db"

  find /bin /etc /lib /sbin /usr ! -name lost+found \
    \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}

alias pacmanallkeys='sudo pacman-key --refresh-keys'

function pacmansignkeys() {
  local key
  for key in $@; do
    sudo pacman-key --recv-keys $key
    sudo pacman-key --lsign-key $key
    printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg \
      --no-permission-warning --command-fd 0 --edit-key $key
  done
}

if (( $+commands[xdg-open] )); then
  function pacweb() {
    if [[ $# = 0 || "$1" =~ '--help|-h' ]]; then
      local underline_color="\e[${color[underline]}m"
      echo "$0 - open the website of an ArchLinux package"
      echo
      echo "Usage:"
      echo "    $bold_color$0$reset_color ${underline_color}target${reset_color}"
      return 1
    fi

    local pkg="$1"
    local infos="$(LANG=C pacman -Si "$pkg")"
    if [[ -z "$infos" ]]; then
      return
    fi
    local repo="$(grep -m 1 '^Repo' <<< "$infos" | grep -oP '[^ ]+$')"
    local arch="$(grep -m 1 '^Arch' <<< "$infos" | grep -oP '[^ ]+$')"
    xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &>/dev/null
  }
fi #}}}
# }}}

# yay helper {{{
alias yayin='yay -S'
alias yayyy="yay -Sy"
alias yayyy='yay -Syy'
alias yayupg='yay -Syu'
alias upgrade='yay -Syu'
alias yaysu='yay -Syu --noconfirm'
alias yayss='yay -Ss'
alias yaysi='yay -Si'
alias yaysc='yay -Sc'
alias yaycl='yay -Scc'

alias yayloc='yay -U'
alias yayconf='yay -Pg'
alias yayr='yay -R'
alias yayrs='yay -Rs'
alias yayrns='yay -Rns'

alias yayq='yay -Qi'
alias yayqs='yay -Qs'
alias yaqe='yay -Qe'
alias yayorph='yay -Qtd'
# }}}
