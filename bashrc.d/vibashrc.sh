#!/bin/bash
export BASHRC_D="$HOME/.bashrc.d"
bashrc() {
  . ~/.bashrc
}

vibashrc() {
  if [[ -n "$1" ]]; then
    local fname="${1%.sh}.sh"
  else
    local fname=
  fi

  cd "$BASHRC_D"
    $EDITOR $fname
  cd -
  bashrc
}
alias vb=vibashrc

__complete_vb() {
  local cur files
  files="$(for f in "$BASHRC_D"/*.sh; do f="${f##*/}"; echo "${f%.sh}"; done)"
# echo "files:[$files]" >&2

  COMPREPLY=( $( compgen -W "$src_dirs" ) )
}

complete -F __complete_vb vb vibashrc
