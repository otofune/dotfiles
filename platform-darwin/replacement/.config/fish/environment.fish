# (c) otofune

/opt/homebrew/bin/brew shellenv | source

set -x PATH $HOME/Library/Python/3.8/bin/ $PATH
set -x PATH /usr/local/opt/libpq/bin $PATH

ls ~/Library/LaunchAgents/local* | xargs -I% launchctl load % 2>/dev/null

export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"
