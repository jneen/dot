#!/bin/zsh
cd '/home/jay/src/tmuxinator'
tmux start-server

if ! $(tmux has-session -t 'tmuxinator'); then

tmux set-option base-index 1
tmux new-session -d -s 'tmuxinator' -n 'shell'



# set up tabs and panes

# tab "shell"

tmux send-keys -t 'tmuxinator':0 'gvim -v' C-m

tmux splitw -t 'tmuxinator':0
tmux send-keys -t 'tmuxinator':0 'git status' C-m

tmux splitw -t 'tmuxinator':0


tmux select-layout -t 'tmuxinator':0 'main-vertical'



tmux select-window -t 'tmuxinator':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'tmuxinator'
else
    tmux -u switch-client -t 'tmuxinator'
fi
