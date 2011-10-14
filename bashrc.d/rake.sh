#!/bin/bash

rake() {
  if which bundle 2>&1 >/dev/null; then
    bundle exec rake "$@"
  else
    $(which rake) "$@"
  fi
}
