#!/bin/zsh
cd '/home/jay/src/goodguide'
tmux start-server

if ! $(tmux has-session -t 'goodguide'); then

tmux set-option base-index 1
tmux new-session -d -s 'goodguide' -n 'editor'


tmux new-window -t 'goodguide':1 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'goodguide':0 'vim' C-m

tmux splitw -t 'goodguide':0
tmux send-keys -t 'goodguide':0 'git status' C-m

tmux splitw -t 'goodguide':0
tmux send-keys -t 'goodguide':0 'rails console' C-m

tmux select-layout -t 'goodguide':0 'main-vertical'


# tab "server"

tmux send-keys -t 'goodguide':1 'rails server' C-m

tmux splitw -t 'goodguide':1
tmux send-keys -t 'goodguide':1 'touch tmp/debug.log && tail -f tmp/debug.log' C-m

tmux select-layout -t 'goodguide':1 'even-horizontal'



tmux select-window -t 'goodguide':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'goodguide'
else
    tmux -u switch-client -t 'goodguide'
fi
