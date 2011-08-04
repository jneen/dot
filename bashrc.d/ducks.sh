#!/bin/bash

ducks() {
  du -cks "$@" * | sort -rn | head -11
}
