#!/bin/zsh
cd '/home/jay/src/dimwit'
tmux start-server

if ! $(tmux has-session -t 'dimwit'); then

tmux set-option base-index 1
tmux new-session -d -s 'dimwit' -n 'main'


tmux new-window -t 'dimwit':1 -n 'server'


# set up tabs and panes

# tab "main"

tmux send-keys -t 'dimwit':0 'vim' C-m

tmux splitw -t 'dimwit':0
tmux send-keys -t 'dimwit':0 'ls' C-m

tmux select-layout -t 'dimwit':0 'main-vertical'


# tab "server"

tmux send-keys -t 'dimwit':1 './script/server' C-m



tmux select-window -t 'dimwit':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'dimwit'
else
    tmux -u switch-client -t 'dimwit'
fi
