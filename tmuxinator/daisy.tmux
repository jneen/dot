#!/bin/zsh
cd '/home/jay/src/daisy'
tmux start-server

if ! $(tmux has-session -t 'daisy'); then

tmux set-option base-index 1
tmux new-session -d -s 'daisy' -n 'editor'


tmux new-window -t 'daisy':1 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'daisy':0 'vim' C-m

tmux splitw -t 'daisy':0
tmux send-keys -t 'daisy':0 'ripl rails' C-m

tmux splitw -t 'daisy':0
tmux send-keys -t 'daisy':0 'top' C-m

tmux select-layout -t 'daisy':0 'main-vertical'


# tab "server"

tmux send-keys -t 'daisy':1 'rails s' C-m

tmux splitw -t 'daisy':1
tmux send-keys -t 'daisy':1 'mkdir -p tmp && touch tmp/debug.log && tail -f tmp/debug.log' C-m

tmux select-layout -t 'daisy':1 'even-vertical'



tmux select-window -t 'daisy':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'daisy'
else
    tmux -u switch-client -t 'daisy'
fi
