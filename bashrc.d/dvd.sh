#!/bin/bash

dvd() {
  gxine dvd:"$(readlink -f "$1")"
}
