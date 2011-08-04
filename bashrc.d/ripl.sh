#!/bin/bash

exists() {
  type "$@" >/dev/null 2>/dev/null
}

# use ripl if it exists
irb() {
  if exists ripl; then
    ripl "$@"
  else
    $(which irb) "$@"
  fi
}
