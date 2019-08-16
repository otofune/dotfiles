# (c) otofune

function npm
  if [ -f 'yarn.lock' ]
    echo 'yarn つかえ'
    return 0
  end
  command npm $argv
end
