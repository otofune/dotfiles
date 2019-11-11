# (c) otofune

function yarn --wraps=yarn
  if [ -f 'package-lock.json' ]
    echo 'Use npm instead of yarn.'
    return 1
  end
  command yarn $argv
end
