# (c) 2018 otofune

# Set-up tools
direnv hook fish | source
source ~/.cargo/env
ssh-add -A > /dev/null 2>&1
set -x GOPATH ~/.projects

# add path
set -x fish_user_paths $GOPATH/bin $fish_user_paths

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
