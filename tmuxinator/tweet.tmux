#!/bin/zsh
cd '/home/jay/src/tweet'
tmux start-server

if ! $(tmux has-session -t 'tweet'); then

tmux set-option base-index 1
tmux new-session -d -s 'tweet' -n 'editor'



# set up tabs and panes

# tab "editor"

tmux send-keys -t 'tweet':0 'vim' C-m

tmux splitw -t 'tweet':0
tmux send-keys -t 'tweet':0 'git status' C-m

tmux splitw -t 'tweet':0
tmux send-keys -t 'tweet':0 '. lib/tweet.sh' C-m

tmux select-layout -t 'tweet':0 'main-vertical'



tmux select-window -t 'tweet':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'tweet'
else
    tmux -u switch-client -t 'tweet'
fi
