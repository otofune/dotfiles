# (c) otofune

function cd --wraps=cd
  # previous pwd
  export PPWD=$PWD

  # with no args, override with ghq | fzf
  set length (count $argv)
  if test $length -eq 0
    set repository (select_ghq_directory)
    if test $status -ne 0
      return 1
    end
    builtin cd $repository
    __git_fetch
    return
  end

  builtin cd $argv
end
