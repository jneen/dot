#!/bin/zsh
cd '~/code/rails_project'
tmux start-server

if ! $(tmux has-session -t 'Tmuxinator'); then

tmux set-option base-index 1
tmux new-session -d -s 'Tmuxinator' -n 'editor'


tmux new-window -t 'Tmuxinator':1 -n 'shell'

tmux new-window -t 'Tmuxinator':2 -n 'database'

tmux new-window -t 'Tmuxinator':3 -n 'server'

tmux new-window -t 'Tmuxinator':4 -n 'logs'

tmux new-window -t 'Tmuxinator':5 -n 'console'

tmux new-window -t 'Tmuxinator':6 -n 'capistrano'

tmux new-window -t 'Tmuxinator':7 -n 'server'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'Tmuxinator':0 'vim' C-m

tmux splitw -t 'Tmuxinator':0


tmux splitw -t 'Tmuxinator':0
tmux send-keys -t 'Tmuxinator':0 'top' C-m

tmux select-layout -t 'Tmuxinator':0 'main-vertical'


# tab "shell"

tmux send-keys -t 'Tmuxinator':1 'git pull' C-m


# tab "database"

tmux send-keys -t 'Tmuxinator':2 'rails db' C-m


# tab "server"

tmux send-keys -t 'Tmuxinator':3 'rails s' C-m


# tab "logs"

tmux send-keys -t 'Tmuxinator':4 'tail -f logs/development.log' C-m


# tab "console"

tmux send-keys -t 'Tmuxinator':5 'rails c' C-m


# tab "capistrano"


# tab "server"

tmux send-keys -t 'Tmuxinator':7 'ssh me@myhost' C-m



tmux select-window -t 'Tmuxinator':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'Tmuxinator'
else
    tmux -u switch-client -t 'Tmuxinator'
fi
