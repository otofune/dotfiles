# (c) otofune

ls ~/Library/LaunchAgents/local* | xargs -I% launchctl load % 2>/dev/null
