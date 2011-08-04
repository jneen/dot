#!/bin/zsh
cd '~/src/iplogic'
tmux start-server

if ! $(tmux has-session -t 'iplogic'); then

tmux set-option base-index 1
tmux new-session -d -s 'iplogic' -n 'editor'



# set up tabs and panes

# tab "editor"

tmux send-keys -t 'iplogic':0 'vim' C-m

tmux splitw -t 'iplogic':0
tmux send-keys -t 'iplogic':0 'irb -r lib/iplogic' C-m

tmux splitw -t 'iplogic':0
tmux send-keys -t 'iplogic':0 'git status' C-m

tmux select-layout -t 'iplogic':0 'main-vertical'



tmux select-window -t 'iplogic':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'iplogic'
else
    tmux -u switch-client -t 'iplogic'
fi
