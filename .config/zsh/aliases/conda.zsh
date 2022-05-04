# CONDA ALIASES

alias cnda='conda activate'          # activate environment
alias cndd='conda deactivate'        # deactivate environment
alias cndl='conda envs list'         # list all environments
alias cndc='conda create -n'       # conda create new environment
alias cndu='conda uninstall'         # uninstall package

# conda install from conda-forge
cndi() { conda install -c conda-forge "$@" ;}

# conda update
cndup() { conda update --name "$@" --all;}

# remove environment
cndrenv() { conda remove --name "$@" --all;}

