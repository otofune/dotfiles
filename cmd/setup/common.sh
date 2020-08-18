#!/bin/bash

BASE_DIRECTORY=$(dirname $BASH_SOURCE)

main() {
  install-vscode-extensions
  install-rust
}

install-vscode-extensions() {
  for ext in $(cat $BASE_DIRECTORY/code-extensions.txt); do
    code --install-extension $ext
  done
}

install-rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source ~/.cargo/env
  cargo install cargo-edit
}

main
