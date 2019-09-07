# (c) otofune

function cd --wraps=cd
  # previous pwd
  export PPWD=$PWD

  # with no args, override with ghq | fzf
  set length (count $argv)
  if test $length -eq 0
    set repository (ghq list | fzf --exit-0)
    if test (string length "$repository") -eq 0
      return 1
    end
    builtin cd (ghq root)/$repository
    return
  end

  builtin cd $argv
end
