#!/bin/bash

BASE_DIRECTORY=$(dirname $BASH_SOURCE)

main() {
  install-asdf
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

install-asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  update-asdf
}

update-asdf() {
  source $HOME/.asdf/asdf.sh

  asdf update

  asdf plugin add python
  asdf list all python
  asdf install python 3.8.5
  asdf global python 3.8.5
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main
