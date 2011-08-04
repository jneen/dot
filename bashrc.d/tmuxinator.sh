#!/bin/bash
[[ -s ~/.tmuxinator/scripts/tmuxinator ]] && source ~/.tmuxinator/scripts/tmuxinator

alias tmo='rvm ree exec tmuxinator open'

# tab completion with src/* names.  ftw.
complete -F __complete_src tmo
