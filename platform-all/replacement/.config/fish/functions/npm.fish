# (c) otofune

function npm --wraps=npm
  if [ -f 'yarn.lock' ]
    echo 'Use yarn instead of npm.'
    return 1
  end
  command npm $argv
end
