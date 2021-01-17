# Git
function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function _file_count
  ls -1 | wc -l | sed 's/\ //g'
end

function __conda_add_prompt; end

function fish_prompt
    set_color $fish_color_cwd
    echo -n ' '(prompt_pwd)
    set_color normal
    echo -n ' $ '
end

function fish_right_prompt
    set -l last_status $status
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l normal (set_color normal)

    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)

        if [ (_is_git_dirty) ]
            set git_info "$red⚫$red$git_branch "
        else
            set git_info "$green$git_branch "
        end
    end

    echo -n -s $git_info
end

