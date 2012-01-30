#!/bin/bash

nvm_script="$HOME/.nvm/nvm.sh"
[[ -s "$nvm_script" ]] && {
  . "$nvm_script"
  export PATH="$PATH:./node_modules/bin"
}
