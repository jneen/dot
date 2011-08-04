#!/bin/bash

#mk_nvm_interrupt() {
#  local bin="$1"; shift
#  alias "$bin"="__nvm_interrupt \"$bin\""
#}
#
#__nvm_interrupt() {
#  local bin="$1"; shift
#  unalias "$bin"
#  __nvm_load_default
#  "$bin" "$@"
#}
#
#__nvm_load_default() {
#}
#
#mk_nvm_interrupt nvm
#mk_nvm_interrupt node
#mk_nvm_interrupt uglifyjs
#mk_nvm_interrupt coffee
[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
nvm use v0.4.1
