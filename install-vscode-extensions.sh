#!/bin/sh

EXTENSIONS=$(cat <<EOL
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
