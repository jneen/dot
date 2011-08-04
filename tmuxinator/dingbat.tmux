#!/bin/zsh
cd '~/src/dingbat'
tmux start-server

if ! $(tmux has-session -t 'dingbat'); then

tmux set-option base-index 1
tmux new-session -d -s 'dingbat' -n 'editor'


tmux new-window -t 'dingbat':1 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'dingbat':0 'vim' C-m

tmux splitw -t 'dingbat':0
tmux send-keys -t 'dingbat':0 'hg st' C-m

tmux splitw -t 'dingbat':0
tmux send-keys -t 'dingbat':0 'ripl rails' C-m

tmux select-layout -t 'dingbat':0 'main-vertical'


# tab "server"

tmux send-keys -t 'dingbat':1 'passenger start' C-m

tmux splitw -t 'dingbat':1
tmux send-keys -t 'dingbat':1 '>tmp/debug.log && tail -f tmp/debug.log' C-m

tmux select-layout -t 'dingbat':1 'even-horizontal'



tmux select-window -t 'dingbat':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'dingbat'
else
    tmux -u switch-client -t 'dingbat'
fi
