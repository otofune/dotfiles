#!/bin/bash

#######
# lib
#######

SETUP_DIRECTORY=$(dirname $BASH_SOURCE)

join() {
  echo "$SETUP_DIRECTORY/$1"
}

#######
# main
#######

main() {
  sync-brew
  sync-code
}

sync-brew() {
  which brew >/dev/null
  if [ $? -eq 1 ]; then return; fi

  brew leaves > $(join "brew-formulas.txt")
  brew list --cask > $(join "brew-casks.txt")
}

sync-code() {
  which code >/dev/null
  if [ $? -eq 1 ]; then return; fi

  code --list-extensions > $(join "code-extensions.txt")
}

main
