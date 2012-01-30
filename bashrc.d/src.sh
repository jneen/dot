#!/bin/bash
export SRC_DIR="$HOME/src"

src() {
  local multiplexer name
  while [[ $# -gt 0 ]]; do
    OPTIND=
    while getopts :tTs opt; do
      case "$opt" in
        t) multiplexer='tmux -L'
        ;;
        s) multiplexer='screen -Rd'
        ;;
        T) multiplexer='__tmuxinator'
        ;;
      esac
    done
    shift $(expr $OPTIND - 1)

    if [[ $# -ne 0 ]]; then
      name="$1"; shift
    fi
  done

  cd $SRC_DIR

  if [[ -n "$name" ]]; then
    dir="$(find $SRC_DIR/ \
      -maxdepth 1 \
      -mindepth 1 \
      -name "$name*" \
      -type d \
      | sortlines | head -1
    )"
    cd "$dir"
    if [[ -n "$dir" ]]; then
      if [[ -n "$multiplexer" ]]; then
        $multiplexer "$name"
      else
        ls
      fi
    else
      ls
      false # no such project
    fi
  fi
}

src::tmux() { tmux -L "$@" ;}
src::screen() { screen -Rd "$@" ;}
TMUXINATOR='rvm ree exec tmuxinator'
src::tmuxinator() {
  local name="$1"; shift
  local script="$HOME/.tmuxinator/$name.tmux"
  [[ -s "$script" ]] || $TMUXINATOR open "$name"
  source ~/.tmuxinator/scripts/tmuxinator
  bash "$script"
}

# tab completion
__complete_src () {
  local cur src_dirs
  cur="${COMP_WORDS[COMP_CWORD]}"

  src_dirs="$(
    for f in $(/bin/ls --almost-all $SRC_DIR | grep ^$cur); do
      if [ -d "$SRC_DIR/$f" ]; then
        echo $f
      fi
    done
  )"

  COMPREPLY=( $( compgen -W "$src_dirs" ) )
}

complete -F __complete_src src
