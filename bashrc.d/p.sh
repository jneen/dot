#!/bin/bash

p() {
  nohup "$@" >/dev/null 2>/dev/null &
  exit
}
