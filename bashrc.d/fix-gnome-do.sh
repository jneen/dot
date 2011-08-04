#!/bin/bash
fix-gnome-do() {
  killall 'gnome-do'
  nohup 'gnome-do' >/dev/null 2>/dev/null &
  exit
}
