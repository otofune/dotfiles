# (c) otofune

function code
  set length (count $argv)
  if test $length -eq 0
    ghq list | fzf --exit-0 | xargs -I% command code (ghq root)/%
    return
  end
  command code $argv
end