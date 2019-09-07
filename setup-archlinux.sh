
export GOPATH="$HOME/.projects"

cd $HOME

yay () {
  which yay &> /dev/null
  if [ $? -ne 0 ]
  then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git ~/.yay
    cd ~/.yay
    makepkg -si
    cd ~/
  fi

  $(which yay) $@
}
i () {
  target=$1

  if [ "$(pacman -Q $target)" = "" ]
  then
    sudo pacman -S --noconfirm $target
  else
    echo "$target was already installed."
  fi
}
i-aur () {
  target=$1

  if [ "$(pacman -Q $target )" = "" ]
  then
    yay -S --noconfirm $target
  else
    echo "$target was already installed."
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
i uim
i skk-jisyo
i ffmpeg
i cmus
i libcdio
i libdiscid

i fish
grep fish /etc/shells &>/dev/null
if [ $? -eq 1 ]
then
  which fish | sudo tee -a /etc/shells
fi
sudo chsh -s $(which fish) $USER

i go
i-aur anyenv
anyenv install --init
i python2
i python
i python-pipenv
i mariadb-clients

i-aur ghq
i-aur direnv
i fzf
i-aur micro

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

xdg-settings set default-web-browser firefox-developer-edition.desktop
