# (c) 2018 otofune

# Set-up tools
set -x PATH ~/go/bin $PATH
eval (direnv hook fish)
ssh-add -A > /dev/null 2>&1
set -x GOPATH ~/go

alias ls="ls -a"
alias mili="env DIRENV_LOG_FORMAT= direnv exec (ghq root)/github.com/otofune/mili node (ghq root)/github.com/otofune/mili"
function note
  echo $argv | mili
end

# typo
alias gti="git"

# short exp
alias g-g="git grep"
function gh-unsub
  cd (ghq root)/github.com/vvakame/github-unsubscriber
  npx github-unsubscriber --run
end

# update brew once per hour at background
# this part is not so well... it's better choise to use LaunchAgent || Cron.
# but, they need priviledge access.
set brew_lock_dir ~/.config/fish/bu
mkdir -p $brew_lock_dir
set brew_lock ".b_u_"(date '+%y%m%d-%H')
if [ ! -f $brew_lock_dir/$brew_lock  ]
  touch $brew_lock_dir/$brew_lock
  echo 'Updating brew...'
  brew update > /dev/null 2>&1 &
end

anyenv init - fish | source

if test -f ~/.config/fish/config-secret.fish
  source ~/.config/fish/config-secret.fish
end

source ~/.config/fish/on-variable-handlers.fish
