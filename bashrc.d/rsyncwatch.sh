#!/bin/bash

rsyncwatch() {
  local dir="$1"; shift
  local target="$1"; shift
  local files

  while __inotifywait; do
    rsync "$files" "$target"
  done
}

__inotifywait() {
  files="$(hg manifest | grep '^\w\+\?' | cut -d/ -f1 | uniq)"
  local ignore="$(cat .hgignore | \
            tail -n+2 | \
            xargs -I{} echo '--exclude {}' | \
            fgrep -v 'syntax:')"
  echo "$files"; echo "$ignore"
  {
    echo "$files"
  } | inotifywait -r --fromfile - $ignore
}
