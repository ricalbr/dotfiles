# CONDA ALIASES

alias cda='conda activate'          # activate environment
alias cdd='conda deactivate'        # deactivate environment
alias cdl='conda envs list'         # list all environments
alias ccenv='conda create -n'       # conda create new environment
alias cdu='conda uninstall'         # uninstall package

# conda install from conda-forge
cdi() { conda install -c conda-forge "$@" ;}

# conda update
cdup() { conda update --name "$@" --all;}

# remove environment
crenv() { conda remove --name "$@" --all;}

