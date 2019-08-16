# (c) 2018 otofune

# Set-up tools
set -x PATH ~/go/bin $PATH
eval (direnv hook fish)
anyenv init - fish | source
ssh-add -A > /dev/null 2>&1
set -x GOPATH ~/.ghq

alias ls="ls -a"

# typo
alias gti="git"

# shorthand
alias gg="git grep"
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
