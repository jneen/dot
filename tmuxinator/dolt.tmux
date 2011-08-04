#!/bin/zsh
cd '/home/jay/src/dolt'
tmux start-server

if ! $(tmux has-session -t 'dolt'); then

tmux set-option base-index 1
tmux new-session -d -s 'dolt' -n 'dolt'



# set up tabs and panes

# tab "dolt"



tmux select-window -t 'dolt':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'dolt'
else
    tmux -u switch-client -t 'dolt'
fi
