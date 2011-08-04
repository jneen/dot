#!/bin/zsh
cd '~/src/Ranger'
tmux start-server

if ! $(tmux has-session -t 'Ranger'); then

tmux set-option base-index 1
tmux new-session -d -s 'Ranger' -n 'editor'


tmux new-window -t 'Ranger':1 -n 'server'

tmux new-window -t 'Ranger':2 -n 'logs'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'Ranger':0 'vim' C-m

tmux splitw -t 'Ranger':0
tmux send-keys -t 'Ranger':0 'rails console' C-m

tmux splitw -t 'Ranger':0
tmux send-keys -t 'Ranger':0 'git status' C-m

tmux select-layout -t 'Ranger':0 'main-vertical'


# tab "server"

tmux send-keys -t 'Ranger':1 'rails server' C-m


# tab "logs"

tmux send-keys -t 'Ranger':2 'tail -f log/development.log' C-m



tmux select-window -t 'Ranger':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'Ranger'
else
    tmux -u switch-client -t 'Ranger'
fi
