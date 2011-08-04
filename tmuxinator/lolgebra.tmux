#!/bin/zsh
cd '/home/jay/src/lolgebra'
tmux start-server

if ! $(tmux has-session -t 'lolgebra'); then

tmux set-option base-index 1
tmux new-session -d -s 'lolgebra' -n 'editor'


tmux new-window -t 'lolgebra':1 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'lolgebra':0 'vim' C-m


# tab "server"

tmux send-keys -t 'lolgebra':1 'coffee app.coffee' C-m



tmux select-window -t 'lolgebra':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'lolgebra'
else
    tmux -u switch-client -t 'lolgebra'
fi
