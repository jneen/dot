#!/bin/bash

if type meld >/dev/null 2>/dev/null; then
  HGMERGE=meld
else
  HGMERGE=gvimdiff
fi

export HGMERGE
