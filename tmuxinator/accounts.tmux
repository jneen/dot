#!/bin/zsh
cd '/home/jay/src/accounts'
tmux start-server

if ! $(tmux has-session -t 'accounts'); then

tmux set-option base-index 1
tmux new-session -d -s 'accounts' -n 'editor'


tmux new-window -t 'accounts':1 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'accounts':0 'vim' C-m

tmux splitw -t 'accounts':0
tmux send-keys -t 'accounts':0 'git status' C-m

tmux splitw -t 'accounts':0
tmux send-keys -t 'accounts':0 'ripl rails' C-m

tmux select-layout -t 'accounts':0 'main-vertical'


# tab "server"

tmux send-keys -t 'accounts':1 'rails server' C-m

tmux splitw -t 'accounts':1
tmux send-keys -t 'accounts':1 '>tmp/debug.log && tail -f tmp/debug.log' C-m

tmux select-layout -t 'accounts':1 'even-horizontal'



tmux select-window -t 'accounts':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'accounts'
else
    tmux -u switch-client -t 'accounts'
fi
