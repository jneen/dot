#!/bin/zsh
cd '~/src/vio'
tmux start-server

if ! $(tmux has-session -t 'vio'); then

tmux set-option base-index 1
tmux new-session -d -s 'vio' -n 'editor'



# set up tabs and panes

# tab "editor"

tmux send-keys -t 'vio':0 'vim' C-m



tmux select-window -t 'vio':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'vio'
else
    tmux -u switch-client -t 'vio'
fi
