set-ps1-colors() {
  # Bash colors!
  SET_ERR_COLOR='\[\e[1;3$(($??1:7))m\]'
  SET_DIR_COLOR='\[\e[1;34m\]'
  SET_PROMPT_COLOR='\[\e[1;32m\]'
  CLEAR_COLOR='\[\e[0;38m\]'
  PS1="${SET_ERR_COLOR}[${SET_PROMPT_COLOR} \u@\h ${SET_DIR_COLOR}\W ${SET_ERR_COLOR}] \$ ${CLEAR_COLOR}"
}
set-ps1-colors

#vi mode!
set -o vi

#view using vim
alias view="vim -R"

#ascii buddha
alias buddhasay="cowsay -f /usr/share/cowsay/cows/buddha.cow -e'--'"
alias buddhathink="cowthink -f /usr/share/cowsay/cows/buddha.cow -e'--'"

export TERM="xterm-256color"

alias ls='ls -Ap'

export PATH="/usr/local/bin:$PATH"
export EDITOR=vim

alias ':e'='vim'
alias ':q'='exit'

# bash utility functions
cw() {
  watch -d -n1 "curl $@ 2>/dev/null"
}

# execute a command with no output
n() {
  "$@" >/dev/null 2>/dev/null
}

stderr() {
  echo "$@" >&2
}

putd() {
  stderr "$1=[${!1}]"
}

if [[ -d $HOME/.bashrc.d ]]; then
  for f in $HOME/.bashrc.d/*.sh; do
    [[ -s "$f" ]] && . "$f"
  done
fi
