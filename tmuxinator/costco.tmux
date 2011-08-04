#!/bin/zsh
cd '/home/jay/src/costco'
tmux start-server

if ! $(tmux has-session -t 'costco'); then

tmux set-option base-index 1
tmux new-session -d -s 'costco' -n 'editor'



# set up tabs and panes

# tab "editor"

tmux send-keys -t 'costco':0 'vim' C-m

tmux splitw -t 'costco':0
tmux send-keys -t 'costco':0 'rails console' C-m

tmux splitw -t 'costco':0
tmux send-keys -t 'costco':0 'hg st' C-m

tmux select-layout -t 'costco':0 'main-vertical'



tmux select-window -t 'costco':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'costco'
else
    tmux -u switch-client -t 'costco'
fi
