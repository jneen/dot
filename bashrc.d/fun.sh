#!/bin/bash

rot13() {
  tr 'a-zN-ZA-M' 'n-za-mA-Z' "$@"
}
