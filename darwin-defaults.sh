#!/bin/sh

#######
# lib
#######

add-persistent-app() {
  app_path=$1
  payload=$(cat <<-EOF
    <dict>
      <key>tile-data</key>
      <dict>
        <key>file-data</key>
        <dict>
          <key>_CFURLString</key>
          <string>file://$app_path</string>
          <key>_CFURLStringType</key>
          <integer>15</integer>
        </dict>
      </dict>
    </dict>
EOF
  )
  # 改行を消し飛ばす
  # defaults がパースできないため
  payload="$(echo -n $payload | sed 's/ //g')"
  defaults write com.apple.dock persistent-apps -array-add $payload
}

#######
# main
#######

main() {
  configure-finder
  configure-dock
  set-persistent-app
  killall Dock
}

configure-dock() {
  # ウィンドウタイトルのダブルクリックで Dock にしまう
  defaults write -g AppleActionOnDoubleClick Minimize

  defaults write com.apple.dock orientation left
  defaults write com.apple.dock recent-apps -array
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock tilesize -int 30
  # 拡大
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock largesize -int 64
}

configure-finder() {
  # Finder で隠しファイルを表示する
  defaults write com.apple.finder AppleShowAllFiles -bool true
  # .app などの通常隠されている拡張子が表示されるようにする
  defaults write -g AppleShowAllExtensions -bool true
}

# Dock へのアプリ登録
set-persistent-app() {
  # 全部消す
  defaults write com.apple.dock persistent-apps -array

  # Finder は個別に登録されていない

  # add-persistent-app /System/Applications/Launchpad.app/
  add-persistent-app /Applications/Firefox.app/
  add-persistent-app /Applications/Discord.app/
  add-persistent-app /Applications/iTerm.app/
  add-persistent-app /Applications/Spotify.app/
  add-persistent-app '/System/Applications/System%20Preferences.app'
}

main
