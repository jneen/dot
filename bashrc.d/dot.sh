#!/usr/bin/env bash

export DOT_DIR="$HOME/Dropbox/dot"
dot() {
  cd "$DOT_DIR" && edit && cd -
}
