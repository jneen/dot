#!/bin/zsh
cd '/home/jay/src/balls'
tmux start-server

if ! $(tmux has-session -t 'balls'); then

tmux set-option base-index 1
tmux new-session -d -s 'balls' -n 'shell'



# set up tabs and panes

# tab "shell"



tmux select-window -t 'balls':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'balls'
else
    tmux -u switch-client -t 'balls'
fi
