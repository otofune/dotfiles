# (c) otofune

function git
  # override simple clone with ghq
  if test $argv[1] = 'clone' -a (count $argv) -eq 2
    ghq get -u $argv[2..(count $argv)]
    ghq look $argv[2]
    return
  end
  
  command git $argv
end