#!/bin/bash

[[ -s ~/.rvm/scripts/rvm ]] && . ~/.rvm/scripts/rvm
if [[ -s ./.rvmrc ]]; then
  . ./.rvmrc
else
  rvm 1.9.2
fi
