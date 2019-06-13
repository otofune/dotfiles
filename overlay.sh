#!/bin/bash

# JSON ONLY
find overlay -type f | sed 's/overlay\///g' | xargs -I% sh -c 'jq -s add "$HOME/%" "overlay/%" > "$HOME/%.new"'
find overlay -type f | sed 's/overlay\///g' | xargs -I% sh -c 'mv "$HOME/%.new" "$HOME/%"'
