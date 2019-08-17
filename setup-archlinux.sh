
alias pacman="sudo pacman"
export GOPATH="$HOME/.projects"

cd $HOME

i () {
  target=$1

  if [ "$(pacman -Q $target)" = "" ]
  then
    pacman -S --no-confirm $target
  else
    echo "$target was already installed."
  fi
}
i-aur () {
  target=$1

  if [ "$(pacman -Q $target)" = "" ]
  then
    yay -S --no-confirm $target
  fi
}
i-package-group () {
  target_group=$1

  packages=$(pacman -Sg i3 | awk '{ print $2 }')
  for p in $packages
  do
    i $p
  done
}

i adobe-source-code-pro-fonts
i-package-group i3
#ここに xorg いるかも
i xorg-xinit
i htop
i pulseaudio
i pulseaudio-bluetooth
i pulseaudio-alsa
i python2
i python
i uim
i skk-jisyo

i fish

i go
git clone https://github.com/anyenv/anyenv ~/.anyenv
~/.anyenv/bin/anyenv init
go get github.com/motemen/ghq

i chromium
i firefox
i firefox-developer-edition

i code

i android-tools
i-aur google-cloud-sdk

i terraform
i docker
i docker-compose

code --install-extension EditorConfig.EditorConfig
code --install-extension ms-vscode.Go
code --install-extension castwide.solargraph
code --install-extension mauve.terraform
