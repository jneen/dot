#!/bin/zsh
cd '/home/jay/src/newapi'
tmux start-server

if ! $(tmux has-session -t 'newapi'); then

tmux set-option base-index 1
tmux new-session -d -s 'newapi' -n 'editor'


tmux new-window -t 'newapi':1 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'newapi':0 'vim' C-m

tmux splitw -t 'newapi':0


tmux select-layout -t 'newapi':0 'main-vertical'


# tab "server"

tmux send-keys -t 'newapi':1 'passenger start' C-m

tmux splitw -t 'newapi':1
tmux send-keys -t 'newapi':1 'mkdir -p tmp && touch tmp/debug.log && tail -f tmp/debug.log' C-m

tmux select-layout -t 'newapi':1 'even-horizontal'



tmux select-window -t 'newapi':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'newapi'
else
    tmux -u switch-client -t 'newapi'
fi
