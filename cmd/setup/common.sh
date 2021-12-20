#!/bin/bash

BASE_DIRECTORY=$(dirname $BASH_SOURCE)

main() {
  install-asdf
  install-vscode-extensions
  install-rust
  install-go-tools
}

install-vscode-extensions() {
  for ext in $(cat "$BASE_DIRECTORY/code-extensions.txt"); do
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
  pushd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  update-asdf
  popd
}

install-go-tools() {
  export GOPATH="$HOME/projects"
  go install github.com/x-motemen/ghq@latest
}

update-asdf() {
  source $HOME/.asdf/asdf.sh

  asdf update

  asdf plugin add nodejs
  bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
  asdf plugin add python
  asdf list all python
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main
