# (c) 2018 otofune

ssh-add -A > /dev/null 2>&1

set -x GOPATH ~/projects
set -x PATH $GOPATH/bin $PATH
direnv hook fish | source

set -x PATH $HOME/bin $PATH

# not fish syntax: source ~/.cargo/env
set -x PATH $HOME/.cargo/bin $PATH

if which anyenv > /dev/null
  # backward compatibility
  anyenv init - | source
else
  source ~/.asdf/asdf.fish
end

# typo
abbr --add gti git
abbr --add pcaman pacman

# shorthand
abbr --add gg git grep
abbr --add l ls -a

# update packages once per hour at background
# this part is not so well. it's better choise to use cron
if type __check_update > /dev/null 2>&1
  set update_lock_dir ~/.config/fish/bu
  mkdir -p $update_lock_dir
  set update_lock ".u_"(date '+%y%m%d-%H')
  if [ ! -f $update_lock_dir/$update_lock  ]
    touch $update_lock_dir/$update_lock
    __check_update
  end
end

if test -f ~/.config/fish/config-secret.fish
  source ~/.config/fish/config-secret.fish
end
if test -f ~/.config/fish/environment.fish
  source ~/.config/fish/environment.fish
end

source ~/.config/fish/on-variable-handlers.fish
source ~/.config/fish/aliases.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end

# opam configuration
# https://github.com/ocaml/opam/pull/4736
#source /Users/owner/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

