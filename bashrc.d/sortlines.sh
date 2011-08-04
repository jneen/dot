#!/bin/bash
sortlines() {
  awk '{print length"\t"$0}' | sort -n | cut -f2-
}
