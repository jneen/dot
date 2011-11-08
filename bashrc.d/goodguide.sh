#!/bin/bash

goodguide() {
  local cmd="$1"; shift

  "goodguide::$cmd" "$@"
}
alias gg=goodguide

goodguide::service::redis() {
  sudo service redis start
}

goodguide::service::mongodb() {
  cd ~/mongodb-linux-x86_64-2.0.0
  nohup ./bin/mongod --dbpath=./db/ >> mongod.log &
  cd -
}

goodguide::service::hoof() {
  rvm 1.9.2 && hoof start
}

goodguide::service::grendel() {
  cd ~/src/grendel
  nohup ./target/start >> grendel.log &
  cd -
}

goodguide::start() {
  goodguide::service::mongodb &
  goodguide::service::grendel &
  goodguide::service::hoof &
}

goodguide::log() {
  cd ~/.hoof
  tail "$@" */log/*.log /tmp/unicorn.*.log
  cd -
}

goodguide::kick() {
  local pid="$(
    ps aux | fgrep 'unicorn_rails master' | grep "$1" | awk '{ print $2 }'
  )"

  if [[ -z "$pid" ]]; then
    stderr "couldn't find unicorn process matching <$@> :("
  else
    stderr "kicking pids <$pid>"
    kill $pid
  fi

  goodguide::wakeup "$1"
}

goodguide::wakeup() {
  curl -D- "http://$1.goodguide.dev/health/status"
  echo
}
