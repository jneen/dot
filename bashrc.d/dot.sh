#!/usr/bin/env bash

export DOT_DIR="$HOME/Dropbox/dot"
dotfiles() {
  cd "$DOT_DIR" && edit && cd -
}
