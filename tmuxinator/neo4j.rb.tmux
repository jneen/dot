#!/bin/zsh
cd '/home/jay/src/neo4j.rb'
tmux start-server

if ! $(tmux has-session -t 'neo4jrb'); then

tmux set-option base-index 1
tmux new-session -d -s 'neo4jrb' -n 'neo4j'



# set up tabs and panes

# tab "neo4j"

tmux send-keys -t 'neo4jrb':0 'vim' C-m

tmux splitw -t 'neo4jrb':0
tmux send-keys -t 'neo4jrb':0 'git status' C-m

tmux splitw -t 'neo4jrb':0
tmux send-keys -t 'neo4jrb':0 'irb -r lib/neo4j' C-m

tmux select-layout -t 'neo4jrb':0 'main-vertical'



tmux select-window -t 'neo4jrb':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'neo4jrb'
else
    tmux -u switch-client -t 'neo4jrb'
fi
