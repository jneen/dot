#!/bin/bash
def() {
  method="$1"; shift
  ack $@ "def (self\.)?$method"
}
