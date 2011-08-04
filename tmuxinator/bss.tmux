#!/bin/zsh
cd '/home/jay/src/bss'
tmux start-server

if ! $(tmux has-session -t 'bss'); then

tmux set-option base-index 1
tmux new-session -d -s 'bss' -n 'editor'



# set up tabs and panes

# tab "editor"

tmux send-keys -t 'bss':0 'vim' C-m

tmux splitw -t 'bss':0
tmux send-keys -t 'bss':0 'git status' C-m

tmux splitw -t 'bss':0


tmux select-layout -t 'bss':0 'main-vertical'



tmux select-window -t 'bss':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'bss'
else
    tmux -u switch-client -t 'bss'
fi
