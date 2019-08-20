#!/bin/bash

i-cask () {
	echo "Installing $1"
	target=$1

	brew cask list $1 &>/dev/null
	if [ $? -eq 1 ]
	then
		brew cask install $target
	fi
}

i () {
	echo "Installing $1"
	target=$1

	brew list $1 &>/dev/null
	if [ $? -eq 1 ]
	then
		brew install $target
	fi
}

if [ which brew &>/dev/null -ne 1 ]
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
fi

i-cask iTerm2
i-cask aquaskk
i-cask 1password
i-cask 1password-cli
i-cask slack
i-cask docker
i-cask visual-studio-code
i-cask firefox
i-cask toggl
i-cask aboptopenjdk
i-cask dbeaver-community

i fzf
i direnv
i jq
i go
i python2
i-cask google-cloud-sdk
i fish
i ghq
i micro
i anyenv
i watch

i-cask skitch
i-cask google-chrome
i-cask notion
i-cask gifox

code --install-extension EditorConfig.EditorConfig
code --install-extension ms-vscode.Go
code --install-extension castwide.solargraph
code --install-extension mauve.terraform

grep fish /etc/shells &>/dev/null
if [ $? -eq 1 ]
then
  which fish | sudo tee -a /etc/shells
fi
if [ $SHELL != $(which fish) ]
then
  chsh -s $(which fish)
fi

anyenv install --init

anyenv install nodenv
anyenv install rbenv
