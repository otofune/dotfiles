#!/bin/bash

install () {
  which $1
  if [ $? -eq 1 ]
  then
    eval ${@:2}
  fi
}

install brew '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

brew update

brew cask install iTerm2 aquaskk 1password

install code brew cask install visual-studio-code
install firefox brew cask install firefox
install fzf brew install fzf
install direnv brew install direnv
install jq brew install jq
install go brew install go
install node brew install node@10
install python2 brew install python2
install gcloud brew cask install google-cloud-sdk
install fish brew install fish
install ghq brew install ghq

brew cask install skitch

code --install-extension EditorConfig.EditorConfig
code --install-extension ms-vscode.Go
code --install-extension castwide.solargraph

which fish | sudo tee -a /etc/shells
chsh -s $(which fish)

npm install -g yarn
