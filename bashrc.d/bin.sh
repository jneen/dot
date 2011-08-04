#!/bin/bash
path_add() {
  for bindir in "$@"; do
    if ! grep "(^|:)$bindir(:|$)" <<<"$PATH" >/dev/null; then
      PATH="$bindir:$PATH"
    fi
  done
  export PATH
  true
}

path_add "$HOME/.bin"
