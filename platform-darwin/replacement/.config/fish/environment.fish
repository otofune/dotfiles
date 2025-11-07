# (c) otofune

/opt/homebrew/bin/brew shellenv | source

set -x PATH /usr/local/opt/libpq/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/Library/Python/3.11/bin $PATH

ls ~/Library/LaunchAgents/local* | xargs -I% launchctl load % 2>/dev/null

export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl/lib/"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc' ]; . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'; end
set -x PATH /opt/homebrew/opt/openjdk/bin $PATH
