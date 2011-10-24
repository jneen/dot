if type gvim 2>/dev/null >/dev/null; then
  export EDITOR='gvim -v'
  alias v='gvim -v'
  alias vi='gvim -v'
  alias vim='gvim -v'
fi

edit() {
  $EDITOR "$@"
}
