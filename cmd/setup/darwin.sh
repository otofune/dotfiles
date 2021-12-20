#!/bin/bash

BASE_DIRECTORY=$(dirname $BASH_SOURCE)

i-cask () {
	echo "Installing $1 (cask)"
	target=$1

	brew list --cask $1 &>/dev/null
	if [ $? -eq 0 ]
	then
    echo $'\t'"already installed."
    return
	fi
  brew install --cask $target
}

i () {
	echo "Installing $1 (formula)"
	target=$1

	brew list $1 &>/dev/null
	if [ $? -eq 0 ]
	then
    echo $'\t'"already installed."
    return
	fi
  brew install $target
}

arch --x86_64 bash -c "arch"
if [ $? -ne 0 ]; then
  sudo softwareupdate --install-rosetta
fi

if [ ! -f /opt/homebrew/bin/brew  ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

for formula in $(cat $BASE_DIRECTORY/brew-formulas.txt)
do
  i $formula
done
for cask in $(cat $BASE_DIRECTORY/brew-casks.txt)
do
  i-cask $cask
done

grep fish /etc/shells &>/dev/null
if [ $? -eq 1 ]
then
  which fish | sudo tee -a /etc/shells
fi
if [ $SHELL != "$(which fish)" ]
then
  chsh -s $(which fish)
fi

$BASE_DIRECTORY/common.sh
$BASE_DIRECTORY/darwin-defaults.sh
