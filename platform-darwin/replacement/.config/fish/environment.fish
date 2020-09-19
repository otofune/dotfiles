# (c) otofune

ls ~/Library/LaunchAgents/local* | xargs -I% launchctl load % 2>/dev/null

set -x fish_user_paths /usr/local/opt/libpq/bin $fish_user_paths

export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"
