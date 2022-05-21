#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


# alias for dotfiles git repository
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# opens file with mimeo
function open() {
    mimeo -q "$*"
}

# dependency nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# quit running desktop manager, dwm or gnome
function qdm() {
    IS_DWM=$(pgrep -l dwm | grep -w dwm)
    if [ -z "$IS_DWM" ]; then
        sudo systemctl stop gdm
    else
        killall xinit
    fi
}
