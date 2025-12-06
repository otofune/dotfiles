#!/bin/bash

BASE_DIRECTORY=$(dirname $BASH_SOURCE)

main() {
  install-vscode-extensions
}

install-vscode-extensions() {
  for ext in $(cat "$BASE_DIRECTORY/code-extensions.txt"); do
    code --install-extension $ext
  done
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main
