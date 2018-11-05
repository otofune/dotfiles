# (c) 2018 otofune

# Set-up tools
set -x PATH ~/go/bin $PATH
set -x PATH ~/.nodebrew/current/bin $PATH
eval (direnv hook fish)

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
  switch (echo $argv[1])
  # override with ghq
  case clone
     ghq get $argv[2..(count $argv)]
     ghq look $argv[2]
  case '*'
     command git $argv
  end
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

alias mili="direnv exec (ghq root)/github.com/otofune/mili node /Users/otofune/.ghq/github.com/otofune/mili"
function note
  echo $argv | mili
end

# typo
alias gti="git"

