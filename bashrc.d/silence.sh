#!/bin/bash

silence() {
  "$@" 2>&1 >/dev/null
}

alias ':s'=silence
