# (c) otofune

function code --wraps=code
  set length (count $argv)
  if test $length -eq 0
    set repository (ghq list | fzf --exit-0)
    if test (string length "$repository") -eq 0
      return 1
    end
    command code (ghq root)/$repository
    return
  end
  command code $argv
end
