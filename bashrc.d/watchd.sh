#!/bin/bash

watchd() {
  watch -d -n1 "du -s $1; du -sh $@"
}
