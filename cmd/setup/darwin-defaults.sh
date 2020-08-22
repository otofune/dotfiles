#!/bin/bash

#######
# lib
#######

add-persistent-app() {
  app_path=$1
  # Old-Style ASCII Property List は NSNumber を表現できないので JSON から変換する
  # 詳しくは Web でチェック: https://scrapbox.io/otofune/Property_List_%E3%82%92%E6%89%8B%E3%81%A7%E6%9B%B8%E3%81%8D%E3%81%9F%E3%81%84%E3%81%A8%E3%81%8D%E3%81%AF_JSON_%E3%81%8B%E3%82%89%E5%A4%89%E6%8F%9B%E3%81%99%E3%82%8B
  payload='{
    "tile-data": {
      "file-data": {
        "_CFURLString": "file://'; payload+=$app_path; payload+='",
        "_CFURLStringType": 15
      }
    }
  }'
  # plist としては XML, Binary, ASCII Property List が正式フォーマットなので、変換する
  payload="$(echo -n $payload | plutil -convert xml1 - -o -)"
  defaults write com.apple.dock persistent-apps -array-add "$payload"
}

#######
# main
#######

main() {
  configure-theme
  configure-scrollbar
  configure-finder
  configure-dock
  configure-music
  killall Music
  set-persistent-app
  killall Dock
}

configure-theme() {
  # アクセントカラー
  defaults write -g AppleHighlightColor "0.968627 0.831373 1.000000 Purple"
}

configure-scrollbar() {
  # マウスかトラックパッドかに関わらず、スクロールしないとスクロールバーが出ないようにする
  defaults write -g AppleShowScrollBars "WhenScrolling"
}

configure-dock() {
  # ウィンドウタイトルのダブルクリックで Dock にしまう
  defaults write -g AppleActionOnDoubleClick Minimize

  defaults write com.apple.dock orientation left
  defaults write com.apple.dock recent-apps -array
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock tilesize -int 50
  # 拡大
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock largesize -int 70
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
  add-persistent-app /Applications/Spotify.app/
  add-persistent-app /Applications/Discord.app/
  add-persistent-app /Applications/iTerm.app/
  # そのまま空白を指定すると詰められるので %20 にする必要がある (なんでだよ)
  add-persistent-app '/System/Applications/System%20Preferences.app'
}

configure-music() {
  # Apple Music は今後使うことないので無効にしとく
  defaults write com.apple.iTunes disableAppleMusic -bool true

  # なぜか 2 なんだけど、なんでなんだろう…
  defaults write com.apple.Music showStoreInSidebar -int 2
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main
