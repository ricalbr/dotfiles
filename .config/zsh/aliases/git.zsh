# GIT ALIASES

# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

# basics
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gclean='git clean -id'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias glog='git log --graph --decorate --oneline'
alias gm='git merge'
alias gp='git push -v'
alias grh='git reset'
alias grm='git rm -v'
alias grs='git restore'
alias gs='git status -s 2>/dev/null'
alias gpl='git pull --recurse-submodules -v'
alias gup='git pull --rebase -v'
function gcl() { git clone ssh://git@github.com/"$*" }
function gsa() { git submodule add ssh://git@github.com/"$*" }

# add
alias gaa='git add --all'

# branch
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
alias gbD='git branch -D'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'

# commit
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcas='git commit -a -s'
alias gcmsg='git commit -m'
alias gcs='git commit -S'
alias gcss='git commit -S -s'
alias gcssm='git commit -S -s -m'

alias gcm=git_commit
function git_commit() {
  fname=$(git status -s | cut -c12- | fzf --multi --no-sort --reverse --cycle)

  if [ -n "$fname" ]; then
    git commit -v $(echo "$fname" | tr '\n' ' ')
  fi
}

# checkout
alias gcob='git checkout -b'
alias gcor='git checkout --recurse-submodules'
alias gcom='git checkout $(git_main_branch)'
alias gcod='git checkout $(git_develop_branch)'

alias gcls='git clone --recurse-submodules'

# diff
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'

# fetch
is-at-least 2.8 "$git_version" \
    && alias gfa='git fetch --all --prune --jobs=10' \
    || alias gfa='git fetch --all --prune'
    # --jobs=<n> was added in git 2.8
alias gfo='git fetch origin'

# log
alias glogs="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat --max-count=15"
alias gloga="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"

# merge
alias gmom='git merge origin/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gma='git merge --abort'

# push
alias gp='git push -v'
alias gpoat='git push origin --all && git push origin --tags'
alias ggpush='git push origin "$(git_current_branch)"'

# remove
alias grmc='git rm --cached'

# restore
alias grss='git restore --source'
alias grst='git restore --staged'

# reset
alias gru='git reset --'
alias grhh='git reset --hard'
alias groh='git reset origin/$(git_current_branch) --hard'
alias gpristine='git reset --hard && git clean -dffx'

# status
alias gsb='git status -sb'
alias gsl='git status'

# submodule
alias gsi='git submodule init'
alias gsu='git submodule update --remote --merge'

# update
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias glum='git pull upstream $(git_main_branch)'
alias ggpur='ggu'
alias ggpull='git pull origin "$(git_current_branch)"'
alias gstoptrack='git update-index --skip-worktree' # stop tracking changes in file on github

# FUNCTIONS

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log

# Warn if the current branch is a WIP
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}

function gccd() {
  command git clone --recurse-submodules "$@"
  [[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
}
compdef _git gccd=git-clone

function ggf() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force origin "${b:=$1}"
}
compdef _git ggf=git-checkout

function ggfl() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}
compdef _git ggfl=git-checkout

function ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}
compdef _git ggl=git-checkout

function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}
compdef _git ggp=git-checkout

function ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout

function ggu() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

unset git_version
