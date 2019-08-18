# (c) otofune

function code --wraps=code
  set length (count $argv)
  if test $length -eq 0
    set repository (ghq list | fzf --exit-0)
    command code (ghq root)/$repository
    return
  end
  command code $argv
end
