#!/bin/bash
ps1() {
  local RED="$(c '1;32')"
  local ERR="$(c '1;3$(($??1:7))')"
  local DIR="$(c '1;34')"
  local PROMPT="$(c '1;32')"
  local CLEAR="$(c '0;38')"

  echo "$ERR[$PROMPT \u@\h $DIR\W $ERR]\$(ps1::git) \\$ $CLEAR"
}

c() {
  echo "\\[\\e[$@m\]"
}

ps1::isgit() {
  git symbolic-ref HEAD >/dev/null 2>/dev/null
}

ps1::git() {
  local branch="$(git symbolic-ref HEAD 2>/dev/null)"
  ps1::isgit || return

  [[ -z "$branch" ]] && branch='(detached)'
  branch="${branch##refs/heads/}"

  local dirty=''
  git diff --quiet 2>/dev/null || dirty='*'

  echo " -> $dirty$branch"
}

export PS1="$(ps1)"
