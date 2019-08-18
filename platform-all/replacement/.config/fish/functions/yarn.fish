# (c) otofune

function yarn --wraps=yarn
  if [ -f 'package-lock.json' ]
    echo 'npm つかえ'
    return 0
  end
  command yarn $argv
end
