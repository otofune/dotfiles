#!/bin/bash

main() {
  install-vscode-extensions
  install-rust
}

install-vscode-extensions() {
  local EXTENSIONS=$(cat <<EOL
EditorConfig.EditorConfig
esbenp.prettier-vscode
golang.go
hashicorp.terraform
matklad.rust-analyzer
ms-python.python
ms-vsliveshare.vsliveshare
WakaTime.vscode-wakatime
EOL
)

  for ext in $EXTENSIONS; do
    code --install-extension $ext
  done
}

install-rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source ~/.cargo/env
  cargo install cargo-edit
}

main
