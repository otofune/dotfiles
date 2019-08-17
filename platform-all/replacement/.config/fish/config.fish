# (c) 2018 otofune

# Set-up tools
eval (direnv hook fish)
anyenv init - fish | source
ssh-add -A > /dev/null 2>&1
set -x GOPATH ~/.projects

# add path
set -x fish_user_paths $GOPATH/bin $fish_user_paths
set -x fish_user_paths $HOME/.anyenv/bin $fish_user_paths

# typo
abbr --add gti git
abbr --add pcaman pacman

# shorthand
abbr --add gg git grep
abbr --add l ls -a
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias pacman="sudo pacman"

# update packages once per hour at background
# this part is not so well... it's better choise to use LaunchAgent || Cron.
# but, they need priviledge access.
set update_lock_dir ~/.config/fish/bu
mkdir -p $update_lock_dir
set update_lock ".u_"(date '+%y%m%d-%H')
if [ ! -f $update_lock_dir/$update_lock  ]
  touch $update_lock_dir/$update_lock
  __check_update
end

if test -f ~/.config/fish/config-secret.fish
  source ~/.config/fish/config-secret.fish
end

source ~/.config/fish/on-variable-handlers.fish
