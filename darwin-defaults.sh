#!/bin/sh

#######
# lib
#######

add-persistent-app() {
  app_path=$1
  # old-style plist のように簡潔に書ける、JSON 形式で書くことにする
  # NeXTStep 時代の old-style plist は 数値などの NSObject を継承するフィールドを表現できないらしい (Wikipedia 調べ)
  # このため _CFURLStringType が NSInteger であり、old-style plist では書くことができない
  # plist は NSDictionary が top-level の Object であり、NSJSONSerialization で変換できるので、そちらを使う
  payload='{
    "tile-data": {
      "file-data": {
        "_CFURLString": "file://'; payload+=$app_path; payload+='",
        "_CFURLStringType": 15
      }
    }
  }'
  # plist の本流は XML or binary 形式であるからか、defaults は JSON 形式を受けつけていないようなので、XML に変換してやる
  payload="$(echo -n $payload | plutil -convert xml1 - -o -)"
  defaults write com.apple.dock persistent-apps -array-add "$payload"
}

#######
# main
#######

main() {
  configure-theme
  configure-finder
  configure-dock
  set-persistent-app
  killall Dock
}

configure-theme() {
  # アクセントカラー
  defaults write -g AppleHighlightColor "0.968627 0.831373 1.000000 Purple"
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

main
