# CONDA ALIASES

alias cda='conda activate'          # activate environment
alias cdd='conda deactivate'        # deactivate environment
alias cdl='conda envs list'         # list all environments
alias ccenv='conda create -n'       # conda create new environment

# conda install from conda-forge
cdinstall() { conda install -c conda-forge "$@" ;}
