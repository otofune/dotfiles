# (c) otofune

function cd
  # previous pwd
  export PPWD=$PWD

  # with no args, override with ghq | fzf
  set length (count $argv)
  if test $length -eq 0
    set repository (ghq list | fzf --exit-0)
    builtin cd (ghq root)/$repository
    return
  end

  builtin cd $argv
end
