# (c) 2018 otofune

# Set-up tools
set -x PATH ~/go/bin $PATH
set -x PATH ~/.nodebrew/current/bin $PATH
eval (direnv hook fish)
ssh-add -A > /dev/null 2>&1
set -x GOPATH ~/go

# be laziness
function code
  set length (count $argv)
  if test $length -eq 0
    ghq list | fzf --exit-0 | xargs -I% command code (ghq root)/%
    return
  end
  command code $argv
end

function git
  # override simple clone with ghq
  if test $argv[1] = 'clone' -a (count $argv) -eq 2
    ghq get -u $argv[2..(count $argv)]
    ghq look $argv[2]
    return
  end
  
  command git $argv
end

function cd
  # with no args, override with ghq | fzf
  set length (count $argv)
  if test $length -eq 0
    set repository (ghq list | fzf --exit-0)
    builtin cd (ghq root)/$repository
    return
  end

  builtin cd $argv
end

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

function npm
  if [ -f 'yarn.lock' ]
    echo 'yarn つかえ'
    return 0
  end
  command npm $argv
end

function yarn
  if [ -f 'package-lock.json' ]
    echo 'npm つかえ'
    return 0
  end
  command yarn $argv
end

set -g fish_user_paths "/usr/local/opt/node@10/bin" $fish_user_paths